// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tessellation/vktTessellationMiscDrawTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `_shader_objects` repetitions of the state switch and unused builtin output cases are registered but report NotPorted,
// as a graphics pipeline cannot be built from shader objects here.
// The programs upstream generates from strings are pre-expanded in
// `shaders/manifest/tessellation_misc_draw.toml`, and the reference PNGs are embedded from `data/tessellation/`. The instanced draw
// cases (`TessInstancedDrawTestCase`) render their reference with `rr::`.
//
// `misc_draw`: fill_cover / fill_overlap / isolines against reference images, tessellation state switched between two draws, the
// tessellation factor barrier bug, a non-zero first vertex and instance, and unused built-in outputs across stage boundaries.

use vulkanalia::prelude::v1_0::*;

use super::util::{SpacingMode, TessLevels, TessPrimitiveType, clamped_rounded_tess_level};
use crate::generated::shaders::tessellation_misc_draw::*;
use crate::rr::defs::IndexType;
use crate::rr::fragment_packet::FragmentPacket;
use crate::rr::generic_vector::{GenericVec4, GenericVecType};
use crate::rr::primitive_types::PrimitiveType;
use crate::rr::render_state::{RenderState, ViewportState};
use crate::rr::renderer::{
    DrawCommand, DrawIndices, PrimitiveList, Program, RenderTarget, Renderer, as_multisample_view,
};
use crate::rr::shaders::{
    FragmentInputInfo, FragmentOutputInfo, FragmentShader, VertexInputInfo, VertexOutputInfo, VertexShader,
};
use crate::rr::shading_context::{FragmentShadingContext, write_fragment_output};
use crate::rr::vertex_attrib::{VertexAttrib, VertexAttribType, read_vertex_attrib_float};
use crate::rr::vertex_packet::VertexPacket;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel, clear};
use crate::tcu::png::load_png;
use crate::tcu::vector::Vec4;
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout, make_render_pass,
};
use crate::vk::pipeline_construction::{PipelineConstructionType, check_pipeline_construction_requirements};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RGBA8: vk::Format = vk::Format::R8G8B8A8_UNORM;

fn rgba8_format() -> TextureFormat {
    TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8)
}

/// `requireFeatures(FEATURE_TESSELLATION_SHADER)`
fn require_tessellation(context: &Context<'_>) -> Result<(), TestError> {
    if context.get_device_features().tessellation_shader == vk::FALSE {
        return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
    }
    Ok(())
}

/// `tcu::floatThresholdCompare` over two RGBA8 images (given channel order), with a threshold per channel.
fn float_threshold_compare_bytes(result: &[u8], reference: &[u8], thresholds: [f32; 4]) -> bool {
    result
        .chunks_exact(4)
        .zip(reference.chunks_exact(4))
        .all(|(got, want)| (0..4).all(|c| (got[c] as f32 / 255.0 - want[c] as f32 / 255.0).abs() <= thresholds[c]))
}

/// `tcu::clear` of an RGBA8 image with the colour, as bytes.
fn clear_bytes(pixels: usize, color: [f32; 4]) -> Vec<u8> {
    let quantized = color.map(|c| (c.clamp(0.0, 1.0) * 255.0).round() as u8);
    quantized.iter().copied().cycle().take(pixels * 4).collect()
}

fn layout_barrier(device: &Device, cmd: vk::CommandBuffer, image: vk::Image, first: bool) {
    // State is slightly different on the first iteration.
    let (current_layout, src_flags) = if first {
        (vk::ImageLayout::UNDEFINED, vk::AccessFlags::empty())
    } else {
        (vk::ImageLayout::TRANSFER_SRC_OPTIMAL, vk::AccessFlags::TRANSFER_READ)
    };
    let barrier = make_image_memory_barrier(
        src_flags,
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        current_layout,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        image,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE | vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        );
    }
}

// =================================================================================
// fill_cover / fill_overlap / isolines
// =================================================================================

#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawType {
    Draw,
    DrawIndirect,
}

impl DrawType {
    /// `getDrawName`
    fn name(self) -> &'static str {
        match self {
            DrawType::Draw => "draw",
            DrawType::DrawIndirect => "draw_indirect",
        }
    }
}

/// `CaseDefinition`
#[derive(Clone)]
struct RunCase {
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    draw_type: DrawType,
    /// The reference images without the `_<ndx>.png`, as upstream's `referenceImagePathPrefix` less the directory.
    reference_name: String,
}

/// The three reference images of one case, by its name.
fn reference_pngs(reference_name: &str) -> Option<[&'static [u8]; 3]> {
    macro_rules! refs {
        ($($name:literal),* $(,)?) => {
            match reference_name {
                $($name => Some([
                    include_bytes!(concat!("../../../../data/tessellation/", $name, "_ref_0.png")).as_slice(),
                    include_bytes!(concat!("../../../../data/tessellation/", $name, "_ref_1.png")).as_slice(),
                    include_bytes!(concat!("../../../../data/tessellation/", $name, "_ref_2.png")).as_slice(),
                ]),)*
                _ => None,
            }
        };
    }
    refs!(
        "fill_cover_triangles_equal_spacing",
        "fill_cover_triangles_fractional_odd_spacing",
        "fill_cover_triangles_fractional_even_spacing",
        "fill_cover_quads_equal_spacing",
        "fill_cover_quads_fractional_odd_spacing",
        "fill_cover_quads_fractional_even_spacing",
        "fill_overlap_triangles_equal_spacing",
        "fill_overlap_triangles_fractional_odd_spacing",
        "fill_overlap_triangles_fractional_even_spacing",
        "fill_overlap_quads_equal_spacing",
        "fill_overlap_quads_fractional_odd_spacing",
        "fill_overlap_quads_fractional_even_spacing",
        "isolines_equal_spacing",
        "isolines_fractional_odd_spacing",
        "isolines_fractional_even_spacing",
    )
}

/// `genTessLevelCases`
fn gen_tess_level_cases(spacing_mode: SpacingMode) -> Vec<TessLevels> {
    const TESS_LEVEL_CASES: [([f32; 2], [f32; 4]); 3] = [
        ([9.0, 9.0], [9.0, 9.0, 9.0, 9.0]),
        ([8.0, 11.0], [13.0, 15.0, 18.0, 21.0]),
        ([17.0, 14.0], [3.0, 6.0, 9.0, 12.0]),
    ];

    TESS_LEVEL_CASES
        .iter()
        .map(|(inner, outer)| TessLevels {
            inner: inner.map(|level| clamped_rounded_tess_level(spacing_mode, level) as f32),
            outer: outer.map(|level| clamped_rounded_tess_level(spacing_mode, level) as f32),
        })
        .collect()
}

/// `genVertexPositions`
fn gen_vertex_positions(primitive_type: TessPrimitiveType) -> Vec<[f32; 2]> {
    match primitive_type {
        TessPrimitiveType::Triangles => vec![[0.8, 0.6], [0.0, -0.786], [-0.8, 0.6]],
        TessPrimitiveType::Quads | TessPrimitiveType::Isolines => {
            vec![[-0.8, -0.8], [0.8, -0.8], [-0.8, 0.8], [0.8, 0.8]]
        }
    }
}

/// `runTest` - common test function used by all test cases.
fn run_test(context: &Context<'_>, case: &RunCase) -> TestOutcome {
    require_tessellation(context)?;

    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();

    let tess_level_cases = gen_tess_level_cases(case.spacing_mode);
    let vertex_data = gen_vertex_positions(case.primitive_type);
    let in_patch_size: u32 = if case.primitive_type == TessPrimitiveType::Triangles {
        3
    } else {
        4
    };

    // Vertex input: positions
    let vertex_buffer = create_host_buffer(context, &vertex_data, vk::BufferUsageFlags::VERTEX_BUFFER)?;
    debug_assert_eq!(in_patch_size as usize, vertex_data.len());

    // Indirect buffer
    let draw_indirect_args: [u32; 4] = [in_patch_size, 1, 0, 0];
    let indirect_buffer = create_host_buffer(context, &draw_indirect_args, vk::BufferUsageFlags::INDIRECT_BUFFER)?;

    // Color attachment, and the buffer its image is copied to for verification
    const RENDER_SIZE: u32 = 256;
    let color_target = ImageWithBuffer::new(
        context,
        RENDER_SIZE,
        RENDER_SIZE,
        RGBA8,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        4,
    )?;

    // Input buffer: tessellation levels. Data is filled in later.
    let tess_levels_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(
            std::mem::size_of::<TessLevels>() as vk::DeviceSize,
            vk::BufferUsageFlags::STORAGE_BUFFER,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    // Descriptors
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(
            vk::DescriptorType::STORAGE_BUFFER,
            vk::ShaderStageFlags::TESSELLATION_CONTROL | vk::ShaderStageFlags::TESSELLATION_EVALUATION,
        )
        .build(device)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
    let tess_levels_buffer_info = [vk::DescriptorBufferInfo {
        buffer: tess_levels_buffer.get(),
        offset: 0,
        range: std::mem::size_of::<TessLevels>() as vk::DeviceSize,
    }];
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set.get())
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
        .buffer_info(&tess_levels_buffer_info)
        .build();
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

    // Pipeline
    let render_pass = make_render_pass(device, RGBA8)?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*color_target.view], RENDER_SIZE, RENDER_SIZE, 1)?;
    let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let tesc_module = create_shader_module(device, binaries.get("tesc")?)?;
    let tese_module = create_shader_module(device, binaries.get("tese")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    let mut state =
        DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST).with_full_viewport(RENDER_SIZE, RENDER_SIZE);
    state.bindings = vec![vk::VertexInputBindingDescription {
        binding: 0,
        stride: 8,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    state.attributes = vec![vk::VertexInputAttributeDescription {
        location: 0,
        binding: 0,
        format: vk::Format::R32G32_SFLOAT,
        offset: 0,
    }];
    state.patch_control_points = Some(in_patch_size);
    let pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vert_module),
            (vk::ShaderStageFlags::TESSELLATION_CONTROL, *tesc_module),
            (vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tese_module),
            (vk::ShaderStageFlags::FRAGMENT, *frag_module),
        ],
        &state,
    )?;

    let references = reference_pngs(&case.reference_name)
        .ok_or_else(|| TestError::NotPorted(format!("no reference images embedded for {}", case.reference_name)))?;

    // Draw commands
    let mut num_passed_cases = 0;

    for (tess_level_case_ndx, tess_levels) in tess_level_cases.iter().enumerate() {
        // Upload tessellation levels data to the input buffer
        unsafe {
            std::ptr::copy_nonoverlapping(
                (tess_levels as *const TessLevels).cast::<u8>(),
                tess_levels_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of::<TessLevels>(),
            )
        };
        flush_alloc(device, tess_levels_buffer.get_allocation())?;

        // Reset the command buffer and begin recording.
        begin_command_buffer(device, cmd)?;

        // Change color attachment image layout
        layout_barrier(device, cmd, color_target.image.get(), tess_level_case_ndx == 0);

        // Begin render pass
        let clear_values = [clear_value_color([0.0, 0.0, 0.0, 1.0])];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);

            // Process enough vertices to make a patch.
            match case.draw_type {
                DrawType::Draw => device.cmd_draw(cmd, in_patch_size, 1, 0, 0),
                DrawType::DrawIndirect => device.cmd_draw_indirect(cmd, indirect_buffer.get(), 0, 1, 0), // Stride is ignored
            }
            device.cmd_end_render_pass(cmd);
        }

        // Copy render result to a host-visible buffer
        copy_image_to_buffer(
            device,
            cmd,
            color_target.image.get(),
            color_target.buffer.get(),
            RENDER_SIZE,
            RENDER_SIZE,
        );

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Verify case result
        let result_bytes = color_target.read_bytes(device)?;
        let result_image = ConstPixelBufferAccess::new(rgba8_format(), [RENDER_SIZE, RENDER_SIZE, 1], result_bytes);

        // Load reference image
        let reference = load_png(references[tess_level_case_ndx]).map_err(|e| {
            TestError::InternalError(format!(
                "data/tessellation/{}_ref_{tess_level_case_ndx}.png: {e}",
                case.reference_name
            ))
        })?;

        if fuzzy_compare_ok(&reference.get_const_access(), &result_image, 0.002) == Some(true) {
            num_passed_cases += 1;
        }
    }

    Ok(if num_passed_cases == tess_level_cases.len() {
        TestStatus::pass("OK")
    } else {
        TestStatus::fail("Failure")
    })
}

// =================================================================================
// TessStateSwitch
// =================================================================================

/// `VkTessellationDomainOrigin` of the two draws; `getDomainOriginName` is the lower-cased name without the prefix.
#[derive(Clone, Copy, PartialEq, Eq)]
enum DomainOrigin {
    UpperLeft,
    LowerLeft,
}

impl DomainOrigin {
    fn name(self) -> &'static str {
        match self {
            DomainOrigin::UpperLeft => "upper_left",
            DomainOrigin::LowerLeft => "lower_left",
        }
    }

    fn vk(self) -> vk::TessellationDomainOrigin {
        match self {
            DomainOrigin::UpperLeft => vk::TessellationDomainOrigin::UPPER_LEFT,
            DomainOrigin::LowerLeft => vk::TessellationDomainOrigin::LOWER_LEFT,
        }
    }
}

/// `TessStateSwitchParams`, the part the host side reads; the shader selection is in the manifest.
#[derive(Clone, Copy)]
struct SwitchParams {
    domain_origin: (DomainOrigin, DomainOrigin),
    geometry_shader: bool,
    construction: PipelineConstructionType,
}

impl SwitchParams {
    fn non_default_domain_origin(&self) -> bool {
        self.domain_origin.0 != DomainOrigin::UpperLeft || self.domain_origin.1 != DomainOrigin::UpperLeft
    }
}

/// `TessStateSwitchInstance::iterate`
fn run_state_switch(context: &Context<'_>, params: &SwitchParams) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    const FB_SIZE: u32 = 128;
    let usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;

    let reference_buffer = ImageWithBuffer::new(context, FB_SIZE, FB_SIZE, RGBA8, usage, 4)?;
    let result_buffer = ImageWithBuffer::new(context, FB_SIZE, FB_SIZE, RGBA8, usage, 4)?;

    // Vertex buffer containing a single full-screen patch.
    let vertices: [[f32; 4]; 4] = [
        [-1.0, -1.0, 0.0, 1.0],
        [-1.0, 1.0, 0.0, 1.0],
        [1.0, -1.0, 0.0, 1.0],
        [1.0, 1.0, 0.0, 1.0],
    ];
    let vertex_count = vertices.len() as u32;
    let patch_control_points = vertex_count;
    let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

    let pc_size = std::mem::size_of::<[f32; 2]>() as u32;
    let pc_stages = vk::ShaderStageFlags::VERTEX;
    let pc_ranges = [vk::PushConstantRange {
        stage_flags: pc_stages,
        offset: 0,
        size: pc_size,
    }];
    let layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&pc_ranges);
    let pipeline_layout = Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );

    let render_pass = make_render_pass(device, RGBA8)?;

    // Framebuffers.
    let framebuffer0 = make_framebuffer(device, *render_pass, &[*reference_buffer.view], FB_SIZE, FB_SIZE, 1)?;
    let framebuffer1 = make_framebuffer(device, *render_pass, &[*result_buffer.view], FB_SIZE, FB_SIZE, 1)?;

    // Shaders.
    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let tesc_module0 = create_shader_module(device, binaries.get("tesc0")?)?;
    let tesc_module1 = create_shader_module(device, binaries.get("tesc1")?)?;
    let tese_module0 = create_shader_module(device, binaries.get("tese0")?)?;
    let tese_module1 = create_shader_module(device, binaries.get("tese1")?)?;
    let geom_module = if params.geometry_shader {
        Some(create_shader_module(device, binaries.get("geom")?)?)
    } else {
        None
    };
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    // In the rasterization parameters, use wireframe mode to see each triangle if possible. This makes the test harder to pass by mistake.
    // We also cull back faces, which will help test domain origin. The front face changes with the domain origin.
    let front_face = if params.domain_origin.1 == DomainOrigin::UpperLeft {
        vk::FrontFace::COUNTER_CLOCKWISE // With the default value it's as specified in the shader.
    } else {
        vk::FrontFace::CLOCKWISE // Otherwise the winding order changes.
    };
    let polygon_mode = if context.get_device_features().fill_mode_non_solid != vk::FALSE {
        vk::PolygonMode::LINE
    } else {
        vk::PolygonMode::FILL
    };

    let pipeline_for = |domain_origin: DomainOrigin,
                        tesc: vk::ShaderModule,
                        tese: vk::ShaderModule,
                        construction: PipelineConstructionType| {
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST)
            .with_position_input()
            .with_full_viewport(FB_SIZE, FB_SIZE);
        state.construction = construction;
        state.patch_control_points = Some(patch_control_points);
        state.tessellation_domain_origin = if params.non_default_domain_origin() {
            Some(domain_origin.vk())
        } else {
            None
        };
        state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(polygon_mode)
            .cull_mode(vk::CullModeFlags::BACK)
            .front_face(front_face)
            .depth_bias_enable(false)
            .line_width(1.0)
            .build();

        let mut stages = vec![
            (vk::ShaderStageFlags::VERTEX, *vert_module),
            (vk::ShaderStageFlags::TESSELLATION_CONTROL, tesc),
            (vk::ShaderStageFlags::TESSELLATION_EVALUATION, tese),
        ];
        if let Some(geom) = &geom_module {
            stages.push((vk::ShaderStageFlags::GEOMETRY, **geom));
        }
        stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));
        create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)
    };

    // Create two pipelines varying the tessellation evaluation module and domain origin.
    let pipeline0 = pipeline_for(
        params.domain_origin.0,
        *tesc_module0,
        *tese_module0,
        params.construction,
    )?;
    let pipeline1 = pipeline_for(
        params.domain_origin.1,
        *tesc_module1,
        *tese_module1,
        params.construction,
    )?;
    // pipeline2 is like pipeline1 but always monolithic, and it's the one used to create the reference image.
    let pipeline2 = pipeline_for(
        params.domain_origin.1,
        *tesc_module1,
        *tese_module1,
        PipelineConstructionType::Monolithic,
    )?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer_ref = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_buffer_res = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    let no_offset = [0.0f32, 0.0];
    let offscreen_offset = [50.0f32, 50.0];
    let clear_values = [clear_value_color([0.0, 0.0, 0.0, 1.0])];
    let push_offset = |cmd: vk::CommandBuffer, offset: &[f32; 2]| unsafe {
        let bytes = std::slice::from_raw_parts(offset.as_ptr().cast::<u8>(), pc_size as usize);
        device.cmd_push_constants(cmd, *pipeline_layout, pc_stages, 0, bytes);
    };
    let begin_info = |framebuffer: vk::Framebuffer| {
        vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(framebuffer)
            .render_area(rect_2d(FB_SIZE, FB_SIZE))
            .clear_values(&clear_values)
    };

    // Reference image.
    {
        let cmd = *cmd_buffer_ref;
        begin_command_buffer(device, cmd)?;
        let info = begin_info(*framebuffer0);
        unsafe {
            device.cmd_begin_render_pass(cmd, &info, vk::SubpassContents::INLINE);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline2.get());
        }
        push_offset(cmd, &no_offset);
        unsafe {
            device.cmd_draw(cmd, vertex_count, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }
        copy_image_to_buffer(
            device,
            cmd,
            reference_buffer.image.get(),
            reference_buffer.buffer.get(),
            FB_SIZE,
            FB_SIZE,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;
    }

    // Result image.
    {
        let cmd = *cmd_buffer_res;
        begin_command_buffer(device, cmd)?;
        let info = begin_info(*framebuffer1);
        unsafe {
            device.cmd_begin_render_pass(cmd, &info, vk::SubpassContents::INLINE);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            // Draw offscreen first to force tessellation state emission.
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline0.get());
        }
        push_offset(cmd, &offscreen_offset);
        unsafe {
            device.cmd_draw(cmd, vertex_count, 1, 0, 0);
            // Draw onscreen second, changing some tessellation state. Domain origin is not part of the shader state, so we need a full
            // state rebind to change it.
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline1.get());
        }
        push_offset(cmd, &no_offset);
        unsafe {
            device.cmd_draw(cmd, vertex_count, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }
        copy_image_to_buffer(
            device,
            cmd,
            result_buffer.image.get(),
            result_buffer.buffer.get(),
            FB_SIZE,
            FB_SIZE,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;
    }

    let reference_bytes = reference_buffer.read_bytes(device)?;
    let result_bytes = result_buffer.read_bytes(device)?;

    // 1/255 < 0.005 < 2/255
    const THRESHOLD: f32 = 0.005;
    if !float_threshold_compare_bytes(result_bytes, reference_bytes, [THRESHOLD, THRESHOLD, THRESHOLD, 0.0]) {
        return Err(TestError::Fail(
            "Color result does not match reference image -- check log for details".to_string(),
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

// =================================================================================
// TessFactorBarrierBug
// =================================================================================

fn run_tess_factor_barrier_bug(context: &Context<'_>) -> TestOutcome {
    const EXTENT: u32 = 128;
    let color_format = vk::Format::B8G8R8A8_UNORM;
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();

    // Buffer for atomics.
    let storage_buffer_size = std::mem::size_of::<u32>() as vk::DeviceSize;
    let storage_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(
            storage_buffer_size,
            vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_DST,
        ),
        MemoryRequirement::ANY,
    )?;

    // Vertex buffer.
    let positions: [[f32; 2]; 4] = [[0.0, 0.0], [1.0, 0.0], [1.0, 1.0], [0.0, 1.0]];
    let vertex_buffer = create_host_buffer(context, &positions, vk::BufferUsageFlags::VERTEX_BUFFER)?;

    // Framebuffer.
    let color_usage =
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    let color_buffer = ImageWithBuffer::new(context, EXTENT, EXTENT, color_format, color_usage, 4)?;

    let desc_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::VERTEX)
        .build(device)?;
    let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;
    let descriptor_set = make_descriptor_set(device, *desc_pool, *set_layout)?;

    let desc_info = [vk::DescriptorBufferInfo {
        buffer: storage_buffer.get(),
        offset: 0,
        range: storage_buffer_size,
    }];
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set.get())
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
        .buffer_info(&desc_info)
        .build();
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

    let binaries = context.get_binary_collection();
    let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
    let tesc_shader = create_shader_module(device, binaries.get("tesc")?)?;
    let tese_shader = create_shader_module(device, binaries.get("tese")?)?;
    let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

    let render_pass = make_render_pass(device, color_format)?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], EXTENT, EXTENT, 1)?;

    let patch_control_points = 4u32;
    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST).with_full_viewport(EXTENT, EXTENT);
    state.bindings = vec![vk::VertexInputBindingDescription {
        binding: 0,
        stride: 8,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    state.attributes = vec![vk::VertexInputAttributeDescription {
        location: 0,
        binding: 0,
        format: vk::Format::R32G32_SFLOAT,
        offset: 0,
    }];
    state.patch_control_points = Some(patch_control_points);
    let pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vert_shader),
            (vk::ShaderStageFlags::TESSELLATION_CONTROL, *tesc_shader),
            (vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tese_shader),
            (vk::ShaderStageFlags::FRAGMENT, *frag_shader),
        ],
        &state,
    )?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let instance_count = 524288u32;
    let clear_values = [clear_value_color([0.0, 0.0, 0.0, 1.0])];

    begin_command_buffer(device, cmd)?;
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(*render_pass)
        .framebuffer(*framebuffer)
        .render_area(rect_2d(EXTENT, EXTENT))
        .clear_values(&clear_values);
    unsafe {
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::GRAPHICS,
            *pipeline_layout,
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
        device.cmd_draw(cmd, patch_control_points, instance_count, 0, 0);
        device.cmd_end_render_pass(cmd);
    }
    copy_image_to_buffer(
        device,
        cmd,
        color_buffer.image.get(),
        color_buffer.buffer.get(),
        EXTENT,
        EXTENT,
    );
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    // Expect more or less exact results; the image is B8G8R8A8.
    let expected_color = [0.502f32, 1.0, 0.502, 1.0];
    let expected = clear_bytes(
        (EXTENT * EXTENT) as usize,
        [
            expected_color[2],
            expected_color[1],
            expected_color[0],
            expected_color[3],
        ],
    );
    let result = color_buffer.read_bytes(device)?;
    // The channels are in the memory order B, G, R, A, so the thresholds (0.005, 0, 0.005, 0) on R, G, B, A swap the first and third.
    if !float_threshold_compare_bytes(result, &expected, [0.005, 0.0, 0.005, 0.0]) {
        return Err(TestError::Fail(
            "Unexpected results in color buffer; check log for details --".to_string(),
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

// =================================================================================
// NonZeroVertexInstance
// =================================================================================

fn run_non_zero_vertex_instance(context: &Context<'_>, indirect: bool) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();

    // Two triangles covering the left half and the right half of the framebuffer.
    let vertices: [[f32; 4]; 6] = [
        // Left half.
        [0.0, -1.0, 0.0, 1.0],
        [-4.0, -1.0, 0.0, 1.0],
        [0.0, 3.0, 0.0, 1.0],
        // Right half.
        [0.0, -1.0, 0.0, 1.0],
        [0.0, 3.0, 0.0, 1.0],
        [4.0, -1.0, 0.0, 1.0],
    ];
    let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

    // Color buffer with just two pixels: left and right.
    let color_usage =
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    let color_buffer = ImageWithBuffer::new(context, 2, 1, RGBA8, color_usage, 4)?;

    // Indirect buffer, which may not be needed, and draw parameters.
    // VkDrawIndirectCommand: vertexCount, instanceCount, firstVertex, firstInstance
    let draw_cmd: [u32; 4] = [
        3, // Just one triangle.
        1, // Just one instance.
        3, // Skip the left side (first 3 vertices).
        1, // Non-zero instance index.
    ];
    let indirect_buffer = create_host_buffer(context, &draw_cmd, vk::BufferUsageFlags::INDIRECT_BUFFER)?;

    let binaries = context.get_binary_collection();
    let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
    let tesc_shader = create_shader_module(device, binaries.get("tesc")?)?;
    let tese_shader = create_shader_module(device, binaries.get("tese")?)?;
    let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let render_pass = make_render_pass(device, RGBA8)?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], 2, 1, 1)?;
    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST)
        .with_position_input()
        .with_full_viewport(2, 1);
    state.patch_control_points = Some(3);
    let pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vert_shader),
            (vk::ShaderStageFlags::TESSELLATION_CONTROL, *tesc_shader),
            (vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tese_shader),
            (vk::ShaderStageFlags::FRAGMENT, *frag_shader),
        ],
        &state,
    )?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let clear_color = [1.0f32, 1.0, 1.0, 1.0];
    let geom_color = [0.0f32, 0.0, 1.0, 1.0];
    let clear_values = [clear_value_color(clear_color)];

    begin_command_buffer(device, cmd)?;
    unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
    }
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(*render_pass)
        .framebuffer(*framebuffer)
        .render_area(rect_2d(2, 1))
        .clear_values(&clear_values);
    unsafe {
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        if indirect {
            device.cmd_draw_indirect(cmd, indirect_buffer.get(), 0, 1, std::mem::size_of::<[u32; 4]>() as u32);
        } else {
            device.cmd_draw(cmd, draw_cmd[0], draw_cmd[1], draw_cmd[2], draw_cmd[3]);
        }
        device.cmd_end_render_pass(cmd);
    }
    copy_image_to_buffer(device, cmd, color_buffer.image.get(), color_buffer.buffer.get(), 2, 1);
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    // The left pixel keeps the clear colour, the right one the colour of the triangle drawn with instance index 1.
    let mut expected = clear_bytes(1, clear_color);
    expected.extend(clear_bytes(1, geom_color));
    let result = color_buffer.read_bytes(device)?;
    if !float_threshold_compare_bytes(result, &expected, [0.0; 4]) {
        return Err(TestError::Fail(
            "Unexpectd results in color buffer; check log for details --".to_string(),
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

// =================================================================================
// TessInstancedDraw
// =================================================================================

/// `TessInstancedDrawTestParams::testType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TessInstancedType {
    NoPatches,
    Instanced,
}

impl TessInstancedType {
    /// `getInstancedDrawTestName`
    fn name(self) -> &'static str {
        match self {
            TessInstancedType::NoPatches => "no_patches",
            TessInstancedType::Instanced => "instances",
        }
    }
}

fn instanced_per_vertex_data() -> [[f32; 4]; 4] {
    [
        [-0.1, -0.1, 0.0, 1.0],
        [0.1, -0.1, 0.0, 1.0],
        [0.1, 0.1, 0.0, 1.0],
        [-0.1, 0.1, 0.0, 1.0],
    ]
}

fn instanced_per_instance_data() -> [[f32; 4]; 4] {
    [
        [-0.5, -0.5, 0.0, 1.0],
        [0.5, -0.5, 0.0, 1.0],
        [0.5, 0.5, 0.0, 1.0],
        [-0.5, 0.5, 0.0, 1.0],
    ]
}

/// `InstancedVertexShader`
struct InstancedVertexShader {
    inputs: [VertexInputInfo; 2],
}

impl InstancedVertexShader {
    fn new() -> Self {
        Self {
            inputs: [
                VertexInputInfo {
                    type_: Some(GenericVecType::Float),
                },
                VertexInputInfo {
                    type_: Some(GenericVecType::Float),
                },
            ],
        }
    }
}

impl VertexShader for InstancedVertexShader {
    fn inputs(&self) -> &[VertexInputInfo] {
        &self.inputs
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        &[]
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        for packet in packets.iter_mut() {
            let mut position = Vec4::splat(0.0);
            let mut instance_position = Vec4::splat(0.0);
            // SAFETY: the attributes point at the arrays the instance keeps alive across the draw.
            unsafe {
                read_vertex_attrib_float(&mut position, &inputs[0], packet.instance_ndx, packet.vertex_ndx, 0);
                read_vertex_attrib_float(
                    &mut instance_position,
                    &inputs[1],
                    packet.instance_ndx,
                    packet.vertex_ndx,
                    0,
                );
            }
            packet.position = position + instance_position;
        }
    }
}

/// `InstancedFragmentShader`
struct InstancedFragmentShader {
    outputs: [FragmentOutputInfo; 1],
}

impl InstancedFragmentShader {
    fn new() -> Self {
        Self {
            outputs: [FragmentOutputInfo {
                type_: Some(GenericVecType::Float),
            }],
        }
    }
}

impl FragmentShader for InstancedFragmentShader {
    fn inputs(&self) -> &[FragmentInputInfo] {
        &[]
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        &self.outputs
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        for packet_ndx in 0..packets.len() {
            for frag_ndx in 0..4usize {
                let color = Vec4::new(1.0, 0.0, 1.0, 1.0);
                // SAFETY: the context was set up by the renderer for exactly these packets.
                unsafe {
                    write_fragment_output(
                        context,
                        packet_ndx as i32,
                        frag_ndx as i32,
                        0,
                        GenericVec4::from_float(color),
                    );
                }
            }
        }
    }
}

/// `TessInstancedDrawTestInstance::iterate`
fn run_instanced_draw(
    context: &Context<'_>,
    test_type: TessInstancedType,
    primitive_type: TessPrimitiveType,
) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    const SIZE: u32 = 256;

    let per_vertex_vertices = instanced_per_vertex_data();
    let per_instance_vertices = instanced_per_instance_data();
    let per_vertex_vb = create_host_buffer(context, &per_vertex_vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;
    let per_instance_vb = create_host_buffer(context, &per_instance_vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;
    let patch_cnt = per_vertex_vertices.len() as u32;

    let render_target = ImageWithBuffer::new(
        context,
        SIZE,
        SIZE,
        RGBA8,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        4,
    )?;

    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let render_pass = make_render_pass(device, RGBA8)?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*render_target.view], SIZE, SIZE, 1)?;

    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let tess_ctrl_module = create_shader_module(device, binaries.get("tess_ctrl")?)?;
    let tess_eval_module = create_shader_module(device, binaries.get("tess_eval")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST).with_full_viewport(SIZE, SIZE);
    state.bindings = vec![
        vk::VertexInputBindingDescription {
            binding: 0,
            stride: 16,
            input_rate: vk::VertexInputRate::VERTEX,
        },
        vk::VertexInputBindingDescription {
            binding: 1,
            stride: 16,
            input_rate: vk::VertexInputRate::INSTANCE,
        },
    ];
    state.attributes = (0..2)
        .map(|location| vk::VertexInputAttributeDescription {
            location,
            binding: location,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        })
        .collect();
    state.patch_control_points = Some(patch_cnt);
    let pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vert_module),
            (vk::ShaderStageFlags::TESSELLATION_CONTROL, *tess_ctrl_module),
            (vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tess_eval_module),
            (vk::ShaderStageFlags::FRAGMENT, *frag_module),
        ],
        &state,
    )?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let clear_color = [0.0f32, 0.0, 0.0, 1.0];
    let clear_values = [clear_value_color(clear_color)];
    begin_command_buffer(device, cmd)?;
    unsafe {
        device.cmd_bind_vertex_buffers(cmd, 0, &[per_vertex_vb.get(), per_instance_vb.get()], &[0, 0]);
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
    }
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(*render_pass)
        .framebuffer(*framebuffer)
        .render_area(rect_2d(SIZE, SIZE))
        .clear_values(&clear_values);
    unsafe {
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        if test_type == TessInstancedType::Instanced {
            device.cmd_draw(cmd, patch_cnt, per_instance_vertices.len() as u32, 0, 0);
        } else {
            device.cmd_draw(cmd, 2, 1, 0, 0);
        }
        device.cmd_end_render_pass(cmd);
    }
    copy_image_to_buffer(
        device,
        cmd,
        render_target.image.get(),
        render_target.buffer.get(),
        SIZE,
        SIZE,
    );
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    // Reference rendering
    let mut ref_image = TextureLevel::new(rgba8_format(), SIZE, SIZE, 1)?;
    clear(&mut ref_image.get_access(), clear_color);

    if test_type == TessInstancedType::Instanced {
        let vert_shader = InstancedVertexShader::new();
        let frag_shader = InstancedFragmentShader::new();
        let program = Program {
            vertex_shader: &vert_shader,
            fragment_shader: &frag_shader,
            geometry_shader: None,
        };
        let mut rr_target = RenderTarget::new(as_multisample_view(ref_image.get_access()), None, None);
        let render_state = RenderState::new(
            ViewportState::from_target_size(SIZE as i32, SIZE as i32),
            context.get_device_properties().limits.sub_pixel_precision_bits as i32,
        );
        let renderer = Renderer::new();
        let vertex_attribs = [
            VertexAttrib::from_pointer(
                VertexAttribType::Float,
                4,
                16,
                0,
                per_vertex_vertices.as_ptr().cast::<u8>(),
            ),
            VertexAttrib::from_pointer(
                VertexAttribType::Float,
                4,
                16,
                1,
                per_instance_vertices.as_ptr().cast::<u8>(),
            ),
        ];

        if primitive_type == TessPrimitiveType::Quads {
            let indices: [u16; 6] = [0, 1, 2, 2, 3, 0];
            let primitives = PrimitiveList::from_indices(
                PrimitiveType::Triangles,
                indices.len(),
                DrawIndices::U16(&indices, 0),
                IndexType::Uint16,
            );
            let command = DrawCommand {
                state: &render_state,
                program: &program,
                vertex_attribs: &vertex_attribs,
                primitives: &primitives,
            };
            renderer.draw_instanced(&command, &mut rr_target, 4);
        } else {
            let primitives = PrimitiveList::from_arrays(PrimitiveType::Triangles, per_vertex_vertices.len(), 0);
            let command = DrawCommand {
                state: &render_state,
                program: &program,
                vertex_attribs: &vertex_attribs,
                primitives: &primitives,
            };
            renderer.draw_instanced(&command, &mut rr_target, 4);
        }
    }

    // Compare result
    let result_bytes = render_target.read_bytes(device)?;
    let result_image = ConstPixelBufferAccess::new(rgba8_format(), [SIZE, SIZE, 1], result_bytes);
    if fuzzy_compare_ok(&ref_image.get_const_access(), &result_image, 0.05) == Some(true) {
        Ok(TestStatus::pass("Pass"))
    } else {
        Ok(TestStatus::fail("Fail"))
    }
}

// =================================================================================
// UnusedBuiltinOutputs
// =================================================================================

#[derive(Clone, Copy, PartialEq, Eq)]
enum UnusedPointSizeBoundary {
    VertexToTesc,
    TescToTese,
    TeseToFrag,
}

impl UnusedPointSizeBoundary {
    fn point_size_from_tess_stage(self) -> bool {
        matches!(
            self,
            UnusedPointSizeBoundary::TescToTese | UnusedPointSizeBoundary::TeseToFrag
        )
    }
}

fn run_unused_builtin_output(context: &Context<'_>, construction: PipelineConstructionType) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    const FB_SIZE: u32 = 64;

    let result_buffer = ImageWithBuffer::new(
        context,
        FB_SIZE,
        FB_SIZE,
        RGBA8,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        4,
    )?;

    let vertices: [[f32; 4]; 3] = [[-1.0, -1.0, 0.0, 1.0], [3.0, -1.0, 0.0, 1.0], [-1.0, 3.0, 0.0, 1.0]];
    let vertex_count = vertices.len() as u32;
    let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let render_pass = make_render_pass(device, RGBA8)?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*result_buffer.view], FB_SIZE, FB_SIZE, 1)?;

    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let tesc_module = create_shader_module(device, binaries.get("tesc")?)?;
    let tese_module = create_shader_module(device, binaries.get("tese")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST)
        .with_position_input()
        .with_full_viewport(FB_SIZE, FB_SIZE);
    state.patch_control_points = Some(vertex_count);
    state.construction = construction;
    state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0)
        .build();
    let pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vert_module),
            (vk::ShaderStageFlags::TESSELLATION_CONTROL, *tesc_module),
            (vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tese_module),
            (vk::ShaderStageFlags::FRAGMENT, *frag_module),
        ],
        &state,
    )?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let clear_values = [clear_value_color([0.0, 0.0, 0.0, 1.0])];
    begin_command_buffer(device, cmd)?;
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(*render_pass)
        .framebuffer(*framebuffer)
        .render_area(rect_2d(FB_SIZE, FB_SIZE))
        .clear_values(&clear_values);
    unsafe {
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
        device.cmd_draw(cmd, vertex_count, 1, 0, 0);
        device.cmd_end_render_pass(cmd);
    }
    copy_image_to_buffer(
        device,
        cmd,
        result_buffer.image.get(),
        result_buffer.buffer.get(),
        FB_SIZE,
        FB_SIZE,
    );
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    let expected = clear_bytes((FB_SIZE * FB_SIZE) as usize, [0.0, 1.0, 0.0, 1.0]);
    let result = result_buffer.read_bytes(device)?;
    const THRESHOLD: f32 = 0.005;
    if !float_threshold_compare_bytes(result, &expected, [THRESHOLD; 4]) {
        return Ok(TestStatus::fail(
            "Color result does not match the expected all-green image",
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

// =================================================================================
// Registration
// =================================================================================

enum Kind {
    Run(RunCase),
    StateSwitch(SwitchParams),
    TessFactorBarrierBug,
    NonZeroVertexInstance { indirect: bool },
    InstancedDraw(TessInstancedType, TessPrimitiveType),
    UnusedBuiltinOutput(UnusedPointSizeBoundary, PipelineConstructionType),
}

struct MiscDrawCase {
    name: String,
    kind: Kind,
    programs: BinaryCollection,
}

impl TestCase for MiscDrawCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match &self.kind {
            // `runTest` requires it itself; `checkSupportCase` only looks at VK_KHR_portability_subset.
            Kind::Run(_) => Ok(()),
            Kind::StateSwitch(params) => {
                require_tessellation(context)?;
                check_pipeline_construction_requirements(context, params.construction)?;

                if params.geometry_shader && context.get_device_features().geometry_shader == vk::FALSE {
                    return Err(TestError::NotSupported("Geometry shader not supported".to_string()));
                }

                if params.non_default_domain_origin() {
                    context.require_device_functionality("VK_KHR_maintenance2")?;
                }
                Ok(())
            }
            Kind::TessFactorBarrierBug => {
                require_tessellation(context)?;

                if context.get_device_features().vertex_pipeline_stores_and_atomics == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Core feature vertexPipelineStoresAndAtomics not supported".to_string(),
                    ));
                }
                Ok(())
            }
            Kind::NonZeroVertexInstance { .. } | Kind::InstancedDraw(..) => require_tessellation(context),
            Kind::UnusedBuiltinOutput(boundary, construction) => {
                require_tessellation(context)?;
                check_pipeline_construction_requirements(context, *construction)?;

                if boundary.point_size_from_tess_stage()
                    && context
                        .get_device_features()
                        .shader_tessellation_and_geometry_point_size
                        == vk::FALSE
                {
                    return Err(TestError::NotSupported(
                        "shaderTessellationAndGeometryPointSize not supported".to_string(),
                    ));
                }
                Ok(())
            }
        }
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MiscDrawInstance {
            context,
            kind: &self.kind,
        })
    }
}

struct MiscDrawInstance<'a> {
    context: &'a Context<'a>,
    kind: &'a Kind,
}

impl TestInstance for MiscDrawInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.kind {
            Kind::Run(case) => run_test(self.context, case),
            Kind::StateSwitch(params) => run_state_switch(self.context, params),
            Kind::TessFactorBarrierBug => run_tess_factor_barrier_bug(self.context),
            Kind::NonZeroVertexInstance { indirect } => run_non_zero_vertex_instance(self.context, *indirect),
            Kind::InstancedDraw(test_type, primitive_type) => {
                run_instanced_draw(self.context, *test_type, *primitive_type)
            }
            Kind::UnusedBuiltinOutput(_, construction) => run_unused_builtin_output(self.context, *construction),
        }
    }
}

/// The programs of a fill_cover/fill_overlap/isolines case.
fn run_programs(case_name: &str) -> BinaryCollection {
    match case_name {
        "fill_cover_triangles_equal_spacing" => MD_FILL_COVER_TRIANGLES_EQUAL_SPACING.programs,
        "fill_cover_triangles_fractional_odd_spacing" => MD_FILL_COVER_TRIANGLES_FRACTIONAL_ODD_SPACING.programs,
        "fill_cover_triangles_fractional_even_spacing" => MD_FILL_COVER_TRIANGLES_FRACTIONAL_EVEN_SPACING.programs,
        "fill_cover_quads_equal_spacing" => MD_FILL_COVER_QUADS_EQUAL_SPACING.programs,
        "fill_cover_quads_fractional_odd_spacing" => MD_FILL_COVER_QUADS_FRACTIONAL_ODD_SPACING.programs,
        "fill_cover_quads_fractional_even_spacing" => MD_FILL_COVER_QUADS_FRACTIONAL_EVEN_SPACING.programs,
        "fill_overlap_triangles_equal_spacing" => MD_FILL_OVERLAP_TRIANGLES_EQUAL_SPACING.programs,
        "fill_overlap_triangles_fractional_odd_spacing" => MD_FILL_OVERLAP_TRIANGLES_FRACTIONAL_ODD_SPACING.programs,
        "fill_overlap_triangles_fractional_even_spacing" => MD_FILL_OVERLAP_TRIANGLES_FRACTIONAL_EVEN_SPACING.programs,
        "fill_overlap_quads_equal_spacing" => MD_FILL_OVERLAP_QUADS_EQUAL_SPACING.programs,
        "fill_overlap_quads_fractional_odd_spacing" => MD_FILL_OVERLAP_QUADS_FRACTIONAL_ODD_SPACING.programs,
        "fill_overlap_quads_fractional_even_spacing" => MD_FILL_OVERLAP_QUADS_FRACTIONAL_EVEN_SPACING.programs,
        "isolines_equal_spacing" => MD_ISOLINES_EQUAL_SPACING.programs,
        "isolines_fractional_odd_spacing" => MD_ISOLINES_FRACTIONAL_ODD_SPACING.programs,
        _ => MD_ISOLINES_FRACTIONAL_EVEN_SPACING.programs,
    }
}

fn run_case(
    prefix: &str,
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    draw_type: DrawType,
) -> Box<dyn TestCase> {
    let ref_name = if primitive_type == TessPrimitiveType::Isolines {
        format!("isolines_{}", spacing_mode.shader_name())
    } else {
        format!(
            "{prefix}_{}_{}",
            primitive_type.shader_name(),
            spacing_mode.shader_name()
        )
    };
    let case_name = format!("{ref_name}_{}", draw_type.name());
    Box::new(MiscDrawCase {
        name: case_name,
        programs: run_programs(&ref_name),
        kind: Kind::Run(RunCase {
            primitive_type,
            spacing_mode,
            draw_type,
            reference_name: ref_name,
        }),
    })
}

/// The programs of one state switch case, by its test name.
fn switch_programs(name: &str) -> BinaryCollection {
    match name {
        "switch_primitive_triangles_to_quads" => SW_SWITCH_PRIMITIVE_TRIANGLES_TO_QUADS.programs,
        "switch_primitive_quads_to_triangles" => SW_SWITCH_PRIMITIVE_QUADS_TO_TRIANGLES.programs,
        "switch_domain_origin_lower_left_to_upper_left" => SW_SWITCH_DOMAIN_ORIGIN_LOWER_LEFT_TO_UPPER_LEFT.programs,
        "switch_domain_origin_upper_left_to_lower_left" => SW_SWITCH_DOMAIN_ORIGIN_UPPER_LEFT_TO_LOWER_LEFT.programs,
        "switch_spacing_mode_equal_spacing_to_fractional_odd_spacing" => {
            SW_SWITCH_SPACING_MODE_EQUAL_SPACING_TO_FRACTIONAL_ODD_SPACING.programs
        }
        "switch_spacing_mode_equal_spacing_to_fractional_even_spacing" => {
            SW_SWITCH_SPACING_MODE_EQUAL_SPACING_TO_FRACTIONAL_EVEN_SPACING.programs
        }
        "switch_spacing_mode_fractional_odd_spacing_to_equal_spacing" => {
            SW_SWITCH_SPACING_MODE_FRACTIONAL_ODD_SPACING_TO_EQUAL_SPACING.programs
        }
        "switch_spacing_mode_fractional_odd_spacing_to_fractional_even_spacing" => {
            SW_SWITCH_SPACING_MODE_FRACTIONAL_ODD_SPACING_TO_FRACTIONAL_EVEN_SPACING.programs
        }
        "switch_spacing_mode_fractional_even_spacing_to_equal_spacing" => {
            SW_SWITCH_SPACING_MODE_FRACTIONAL_EVEN_SPACING_TO_EQUAL_SPACING.programs
        }
        "switch_spacing_mode_fractional_even_spacing_to_fractional_odd_spacing" => {
            SW_SWITCH_SPACING_MODE_FRACTIONAL_EVEN_SPACING_TO_FRACTIONAL_ODD_SPACING.programs
        }
        "switch_out_vertices_3_to_4" => SW_SWITCH_OUT_VERTICES_3_TO_4.programs,
        "switch_out_vertices_4_to_3" => SW_SWITCH_OUT_VERTICES_4_TO_3.programs,
        "switch_primitive_triangles_to_quads_with_geom_shader" => {
            SW_SWITCH_PRIMITIVE_TRIANGLES_TO_QUADS_WITH_GEOM_SHADER.programs
        }
        "switch_primitive_quads_to_triangles_with_geom_shader" => {
            SW_SWITCH_PRIMITIVE_QUADS_TO_TRIANGLES_WITH_GEOM_SHADER.programs
        }
        "switch_domain_origin_lower_left_to_upper_left_with_geom_shader" => {
            SW_SWITCH_DOMAIN_ORIGIN_LOWER_LEFT_TO_UPPER_LEFT_WITH_GEOM_SHADER.programs
        }
        "switch_domain_origin_upper_left_to_lower_left_with_geom_shader" => {
            SW_SWITCH_DOMAIN_ORIGIN_UPPER_LEFT_TO_LOWER_LEFT_WITH_GEOM_SHADER.programs
        }
        "switch_spacing_mode_equal_spacing_to_fractional_odd_spacing_with_geom_shader" => {
            SW_SWITCH_SPACING_MODE_EQUAL_SPACING_TO_FRACTIONAL_ODD_SPACING_WITH_GEOM_SHADER.programs
        }
        "switch_spacing_mode_equal_spacing_to_fractional_even_spacing_with_geom_shader" => {
            SW_SWITCH_SPACING_MODE_EQUAL_SPACING_TO_FRACTIONAL_EVEN_SPACING_WITH_GEOM_SHADER.programs
        }
        "switch_spacing_mode_fractional_odd_spacing_to_equal_spacing_with_geom_shader" => {
            SW_SWITCH_SPACING_MODE_FRACTIONAL_ODD_SPACING_TO_EQUAL_SPACING_WITH_GEOM_SHADER.programs
        }
        "switch_spacing_mode_fractional_odd_spacing_to_fractional_even_spacing_with_geom_shader" => {
            SW_SWITCH_SPACING_MODE_FRACTIONAL_ODD_SPACING_TO_FRACTIONAL_EVEN_SPACING_WITH_GEOM_SHADER.programs
        }
        "switch_spacing_mode_fractional_even_spacing_to_equal_spacing_with_geom_shader" => {
            SW_SWITCH_SPACING_MODE_FRACTIONAL_EVEN_SPACING_TO_EQUAL_SPACING_WITH_GEOM_SHADER.programs
        }
        "switch_spacing_mode_fractional_even_spacing_to_fractional_odd_spacing_with_geom_shader" => {
            SW_SWITCH_SPACING_MODE_FRACTIONAL_EVEN_SPACING_TO_FRACTIONAL_ODD_SPACING_WITH_GEOM_SHADER.programs
        }
        "switch_out_vertices_3_to_4_with_geom_shader" => SW_SWITCH_OUT_VERTICES_3_TO_4_WITH_GEOM_SHADER.programs,
        _ => SW_SWITCH_OUT_VERTICES_4_TO_3_WITH_GEOM_SHADER.programs,
    }
}

/// `base_name` is the case name without the construction type suffix, which is what its programs are keyed by.
fn switch_case(
    base_name: &str,
    construction_suffix: &str,
    domain_origin: (DomainOrigin, DomainOrigin),
    geometry_shader: bool,
    construction: PipelineConstructionType,
) -> Box<dyn TestCase> {
    Box::new(MiscDrawCase {
        programs: switch_programs(base_name),
        name: format!("{base_name}{construction_suffix}"),
        kind: Kind::StateSwitch(SwitchParams {
            domain_origin,
            geometry_shader,
            construction,
        }),
    })
}

/// `createMiscDrawTests`
pub fn create_misc_draw_tests() -> TestCaseGroup {
    // Miscellaneous draw-result-verifying cases
    let mut group = TestCaseGroup::new("misc_draw");

    let primitives_no_isolines = [TessPrimitiveType::Triangles, TessPrimitiveType::Quads];
    let draw_types = [DrawType::Draw, DrawType::DrawIndirect];

    // Triangle fill case: check that there are no obvious gaps in the triangle-filled area of a tessellated shape
    for draw_type in draw_types {
        for primitive_type in primitives_no_isolines {
            for spacing_mode in SpacingMode::ALL {
                group.add_child(run_case("fill_cover", primitive_type, spacing_mode, draw_type));
            }
        }
    }

    // Triangle non-overlap case: check that there are no obvious triangle overlaps in the triangle-filled area of a tessellated shape
    for draw_type in draw_types {
        for primitive_type in primitives_no_isolines {
            for spacing_mode in SpacingMode::ALL {
                group.add_child(run_case("fill_overlap", primitive_type, spacing_mode, draw_type));
            }
        }
    }

    // Isolines: basic isolines render test
    for draw_type in draw_types {
        for spacing_mode in SpacingMode::ALL {
            group.add_child(run_case(
                "isolines",
                TessPrimitiveType::Isolines,
                spacing_mode,
                draw_type,
            ));
        }
    }

    // Test switching tessellation parameters on the fly.
    for (construction, construction_suffix) in [
        (PipelineConstructionType::Monolithic, ""),
        (PipelineConstructionType::FastLinkedLibrary, "_fast_lib"),
        (PipelineConstructionType::ShaderObjectUnlinkedSpirv, "_shader_objects"),
    ] {
        for geometry_shader in [false, true] {
            let name_suffix = if geometry_shader { "_with_geom_shader" } else { "" };
            let upper_left = (DomainOrigin::UpperLeft, DomainOrigin::UpperLeft);
            let domain_origins = [DomainOrigin::LowerLeft, DomainOrigin::UpperLeft];

            for first_primitive_type in primitives_no_isolines {
                for second_primitive_type in primitives_no_isolines {
                    if first_primitive_type == second_primitive_type {
                        continue;
                    }

                    let test_name = format!(
                        "switch_primitive_{}_to_{}{name_suffix}",
                        first_primitive_type.shader_name(),
                        second_primitive_type.shader_name()
                    );
                    group.add_child(switch_case(
                        &test_name,
                        construction_suffix,
                        upper_left,
                        geometry_shader,
                        construction,
                    ));
                }
            }

            for first_domain_origin in domain_origins {
                for second_domain_origin in domain_origins {
                    if first_domain_origin == second_domain_origin {
                        continue;
                    }

                    let test_name = format!(
                        "switch_domain_origin_{}_to_{}{name_suffix}",
                        first_domain_origin.name(),
                        second_domain_origin.name()
                    );
                    group.add_child(switch_case(
                        &test_name,
                        construction_suffix,
                        (first_domain_origin, second_domain_origin),
                        geometry_shader,
                        construction,
                    ));
                }
            }

            for first_spacing_mode in SpacingMode::ALL {
                for second_spacing_mode in SpacingMode::ALL {
                    if first_spacing_mode == second_spacing_mode {
                        continue;
                    }

                    let test_name = format!(
                        "switch_spacing_mode_{}_to_{}{name_suffix}",
                        first_spacing_mode.shader_name(),
                        second_spacing_mode.shader_name()
                    );
                    group.add_child(switch_case(
                        &test_name,
                        construction_suffix,
                        upper_left,
                        geometry_shader,
                        construction,
                    ));
                }
            }

            // Switch vertex counts.
            for first_count in [3u32, 4] {
                for second_count in [3u32, 4] {
                    if first_count == second_count {
                        continue;
                    }

                    let test_name = format!("switch_out_vertices_{first_count}_to_{second_count}{name_suffix}");
                    group.add_child(switch_case(
                        &test_name,
                        construction_suffix,
                        upper_left,
                        geometry_shader,
                        construction,
                    ));
                }
            }
        }
    }

    group.add_child(Box::new(MiscDrawCase {
        name: "tess_factor_barrier_bug".to_string(),
        kind: Kind::TessFactorBarrierBug,
        programs: MD_BARRIER_BUG.programs,
    }) as Box<dyn TestCase>);

    for indirect_draw in [false, true] {
        let test_name = format!(
            "non_zero_vertex_instance{}",
            if indirect_draw { "_indirect_draw" } else { "" }
        );
        group.add_child(Box::new(MiscDrawCase {
            name: test_name,
            kind: Kind::NonZeroVertexInstance {
                indirect: indirect_draw,
            },
            programs: MD_NON_ZERO_VERTEX_INSTANCE.programs,
        }) as Box<dyn TestCase>);
    }

    for primitive_type in [TessPrimitiveType::Triangles, TessPrimitiveType::Quads] {
        for test_type in [TessInstancedType::NoPatches, TessInstancedType::Instanced] {
            group.add_child(Box::new(MiscDrawCase {
                name: format!("{}_{}", primitive_type.shader_name(), test_type.name()),
                kind: Kind::InstancedDraw(test_type, primitive_type),
                programs: if primitive_type == TessPrimitiveType::Quads {
                    MD_INSTANCED_QUADS.programs
                } else {
                    MD_INSTANCED_TRIANGLES.programs
                },
            }) as Box<dyn TestCase>);
        }
    }

    group
}

/// `createUnusedBuiltinOutputTests`: unused builtin (gl_PointSize) outputs across unlinked tessellation stage boundaries (#4388).
pub fn create_unused_builtin_output_tests() -> TestCaseGroup {
    let mut unused_builtin_group = TestCaseGroup::new("unused_builtin_outputs");

    for (boundary, name, programs) in [
        (
            UnusedPointSizeBoundary::VertexToTesc,
            "point_size_vertex_to_tesc",
            MD_UNUSED_VERTEX_TO_TESC.programs,
        ),
        (
            UnusedPointSizeBoundary::TescToTese,
            "point_size_tesc_to_tese",
            MD_UNUSED_TESC_TO_TESE.programs,
        ),
        (
            UnusedPointSizeBoundary::TeseToFrag,
            "point_size_tese_to_frag",
            MD_UNUSED_TESE_TO_FRAG.programs,
        ),
    ] {
        for (construction, suffix) in [
            (PipelineConstructionType::Monolithic, ""),
            (PipelineConstructionType::FastLinkedLibrary, "_fast_lib"),
            (PipelineConstructionType::ShaderObjectUnlinkedSpirv, "_shader_objects"),
        ] {
            unused_builtin_group.add_child(Box::new(MiscDrawCase {
                name: format!("{name}{suffix}"),
                kind: Kind::UnusedBuiltinOutput(boundary, construction),
                programs,
            }) as Box<dyn TestCase>);
        }
    }

    unused_builtin_group
}
