// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/subgroups/vktSubgroupsTestsUtils.cpp (`makeVertexFrameBufferTest`,
//   `makeGeometryFrameBufferTest`, `makeTessellationEvaluationFrameBufferTest`, `initStdFrameBufferPrograms`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `framebuffer` groups: the test source runs in one stage of the vertex pipeline
// (vertex, tessellation control, tessellation evaluation or geometry), reads its input from uniform buffers - these stages may not write
// storage buffers - and hands the verdict to the fragment shader as a float, which writes it to a one pixel high R32_UINT image. The
// shaders are in `shaders/manifest/subgroups_framebuffer.toml` (`test_<stage>`, with the `_ps` ones writing gl_PointSize for a device that
// has shaderTessellationAndGeometryPointSize) and the stages around the tested one in `subgroups_framebuffer_common.toml`.

use vulkanalia::prelude::v1_0::*;

use super::compute_tests::{Params, check_support_common, field, parse};
use super::graphics_tests::{MAX_WIDTH, get_next_width, make_render_pass};
use super::utils::{
    check, check_vertex_pipeline_stages_builtin, initialize_memory, subgroup_properties,
    subgroup_size_control_properties,
};
use crate::generated::shaders::subgroups_framebuffer::ALL_SUBGROUP_FRAMEBUFFER_CASE;
use crate::generated::shaders::subgroups_framebuffer_common::SG_FRAMEBUFFER_COMMON_PROGRAMS;
use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_create_info, make_image_memory_barrier,
    make_image_subresource_layers, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

/// The `rust_type` of the manifest entries: one test case of the framebuffer group of a subgroup family.
#[derive(Clone, Copy)]
pub struct SubgroupFramebufferCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

/// The `rust_type` of the stages shared by all of those cases.
#[derive(Clone, Copy)]
pub struct SubgroupFramebufferCommon {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Stage {
    Vertex,
    TessellationControl,
    TessellationEvaluation,
    Geometry,
    Fragment,
}

impl Stage {
    fn from_token(token: &str) -> Self {
        match token {
            "vert" => Self::Vertex,
            "tesc" => Self::TessellationControl,
            "tese" => Self::TessellationEvaluation,
            "geom" => Self::Geometry,
            "frag" => Self::Fragment,
            other => panic!("subgroup spec with an unknown stage {other}"),
        }
    }

    fn flag(self) -> vk::ShaderStageFlags {
        match self {
            Self::Vertex => vk::ShaderStageFlags::VERTEX,
            Self::TessellationControl => vk::ShaderStageFlags::TESSELLATION_CONTROL,
            Self::TessellationEvaluation => vk::ShaderStageFlags::TESSELLATION_EVALUATION,
            Self::Geometry => vk::ShaderStageFlags::GEOMETRY,
            Self::Fragment => vk::ShaderStageFlags::FRAGMENT,
        }
    }

    fn token(self) -> &'static str {
        match self {
            Self::Vertex => "vert",
            Self::TessellationControl => "tesc",
            Self::TessellationEvaluation => "tese",
            Self::Geometry => "geom",
            Self::Fragment => "frag",
        }
    }

    fn uses_patches(self) -> bool {
        matches!(self, Self::TessellationControl | Self::TessellationEvaluation)
    }
}

/// The pipeline stage flags and the required subgroup size of the tested stage (`vertexShaderStageCreateFlags` and the others of the `RequiredSubgroupSize` helpers)
pub(super) struct StageOptions {
    pub stage: vk::ShaderStageFlags,
    pub flags: vk::PipelineShaderStageCreateFlags,
    pub required_subgroup_size: u32,
}

/// The `check` of the size control cases: every pixel holds a subgroup size inside the limits, which is the required one when there is one
pub(super) fn check_size_control(
    data: &[u32],
    count: usize,
    min_size: u32,
    max_size: u32,
    required: Option<u32>,
) -> bool {
    data.iter()
        .take(count)
        .all(|&size| size <= max_size && size >= min_size && required.is_none_or(|required| size == required))
}

struct SubgroupFramebufferTestCase {
    name: String,
    spec: &'static str,
    programs: BinaryCollection,
}

impl TestCase for SubgroupFramebufferTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_support_common(context, self.spec, &parse(self.spec), vk::ShaderStageFlags::empty())?;

        // supportedCheckShader
        let stage = Stage::from_token(field(self.spec, "stage"));
        if let Some(size_control) = &parse(self.spec).size_control {
            size_control.check_support(context, stage.flag())?;
        }
        if !subgroup_properties(context).supported_stages.intersects(stage.flag()) {
            return Err(TestError::NotSupported(
                "Subgroup support is not available for test shader stage(s)".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SubgroupFramebufferInstance {
            context,
            params: parse(self.spec),
            stage: Stage::from_token(field(self.spec, "stage")),
            own_pipeline: self.spec.split(';').any(|entry| entry == "own=1"),
        })
    }
}

struct SubgroupFramebufferInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
    stage: Stage,
    /// The case holds every stage of its pipeline (`own=1`) instead of only the tested one
    own_pipeline: bool,
}

impl TestInstance for SubgroupFramebufferInstance<'_> {
    /// `noSSBOtest` of the families, which calls the `make*FrameBufferTest` of the stage.
    fn iterate(&mut self) -> TestOutcome {
        if self.stage == Stage::Fragment {
            return make_fragment_frame_buffer_test(self.context, &self.params);
        }
        make_frame_buffer_test(self.context, &self.params, self.stage, self.own_pipeline)
    }
}

/// `makeGraphicsPipeline` with `frameBufferTests == true`: the vertex input is one `vec4` position, the colour attachment has one
/// channel, and a patch has two control points.
fn make_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    stage_modules: &[(vk::ShaderStageFlags, vk::ShaderModule)],
    render_pass: vk::RenderPass,
    topology: vk::PrimitiveTopology,
    with_vertex_input: bool,
    color_write_mask: vk::ColorComponentFlags,
    tested_stage: Option<&StageOptions>,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let entry = c"main";
    let subgroup_size_info = tested_stage.map(|options| vk::PipelineShaderStageRequiredSubgroupSizeCreateInfo {
        s_type: vk::StructureType::PIPELINE_SHADER_STAGE_REQUIRED_SUBGROUP_SIZE_CREATE_INFO,
        next: std::ptr::null(),
        required_subgroup_size: options.required_subgroup_size,
    });
    let stages: Vec<vk::PipelineShaderStageCreateInfo> = stage_modules
        .iter()
        .map(|&(stage, module)| {
            let mut info = vk::PipelineShaderStageCreateInfo::builder()
                .stage(stage)
                .module(module)
                .name(entry.to_bytes_with_nul())
                .build();
            if let (Some(options), Some(size_info)) = (tested_stage, &subgroup_size_info)
                && options.stage == stage
            {
                info.flags = options.flags;
                if options.required_subgroup_size != 0 {
                    info.next = (size_info as *const vk::PipelineShaderStageRequiredSubgroupSizeCreateInfo).cast();
                }
            }
            info
        })
        .collect();
    let has_tessellation = stage_modules.iter().any(|&(stage, _)| {
        stage == vk::ShaderStageFlags::TESSELLATION_CONTROL || stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION
    });

    let bindings = [vk::VertexInputBindingDescription {
        binding: 0,
        stride: std::mem::size_of::<[f32; 4]>() as u32,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    let attributes = [vk::VertexInputAttributeDescription {
        location: 0,
        binding: 0,
        format: vk::Format::R32G32B32A32_SFLOAT,
        offset: 0,
    }];
    let vertex_input = if with_vertex_input {
        vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes)
    } else {
        vk::PipelineVertexInputStateCreateInfo::builder()
    };
    let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(topology)
        .primitive_restart_enable(false);
    let tessellation = vk::PipelineTessellationStateCreateInfo::builder().patch_control_points(2);
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewport_count(1)
        .scissor_count(1);
    let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(vk::SampleCountFlags::_1)
        .min_sample_shading(1.0);
    let stencil_op_state = vk::StencilOpState {
        fail_op: vk::StencilOp::KEEP,
        pass_op: vk::StencilOp::KEEP,
        depth_fail_op: vk::StencilOp::KEEP,
        compare_op: vk::CompareOp::NEVER,
        compare_mask: 0,
        write_mask: 0,
        reference: 0,
    };
    let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_compare_op(vk::CompareOp::LESS_OR_EQUAL)
        .front(stencil_op_state)
        .back(stencil_op_state)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0);
    let color_blend_attachment = [vk::PipelineColorBlendAttachmentState {
        blend_enable: vk::FALSE,
        src_color_blend_factor: vk::BlendFactor::ZERO,
        dst_color_blend_factor: vk::BlendFactor::ZERO,
        color_blend_op: vk::BlendOp::ADD,
        src_alpha_blend_factor: vk::BlendFactor::ZERO,
        dst_alpha_blend_factor: vk::BlendFactor::ZERO,
        alpha_blend_op: vk::BlendOp::ADD,
        color_write_mask,
    }];
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op(vk::LogicOp::CLEAR)
        .attachments(&color_blend_attachment);
    let dynamic_states = [vk::DynamicState::VIEWPORT, vk::DynamicState::SCISSOR];
    let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

    let mut info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .depth_stencil_state(&depth_stencil)
        .color_blend_state(&color_blend)
        .dynamic_state(&dynamic_state)
        .layout(pipeline_layout)
        .render_pass(render_pass)
        .subpass(0);
    if has_tessellation {
        info = info.tessellation_state(&tessellation);
    }

    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// `makeVertexFrameBufferTest`, `makeGeometryFrameBufferTest` and `makeTessellationEvaluationFrameBufferTest`, which differ in the stages
/// they put in the pipeline, in what they draw and in how many results that makes.
fn make_frame_buffer_test(context: &Context<'_>, params: &Params, stage: Stage, own_pipeline: bool) -> TestOutcome {
    let vk = context.get_device();
    let allocator = context.get_default_allocator();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();
    // The builtin variable tests write a four component result per pixel
    let (format, color_mask) = if params.result_components == 4 {
        (vk::Format::R32G32B32A32_UINT, vk::ColorComponentFlags::all())
    } else {
        (vk::Format::R32_UINT, vk::ColorComponentFlags::R)
    };
    let components = params.result_components as usize;
    let element_size = 4 * params.result_components;

    let geometry_point_size = if context
        .get_device_features()
        .shader_tessellation_and_geometry_point_size
        != vk::FALSE
    {
        "_ps"
    } else {
        ""
    };
    let test_program = if own_pipeline {
        stage.token().to_string()
    } else {
        format!(
            "test_{}{}",
            stage.token(),
            if stage == Stage::Vertex {
                ""
            } else {
                geometry_point_size
            }
        )
    };
    let binaries = context.get_binary_collection();
    let common = if own_pipeline {
        binaries
    } else {
        SG_FRAMEBUFFER_COMMON_PROGRAMS.programs
    };

    let mut modules: Vec<(vk::ShaderStageFlags, Unique<'_, vk::ShaderModule>)> = Vec::new();
    match stage {
        Stage::Vertex => modules.push((
            vk::ShaderStageFlags::VERTEX,
            create_shader_module(vk, binaries.get(&test_program)?)?,
        )),
        Stage::Geometry => {
            modules.push((
                vk::ShaderStageFlags::VERTEX,
                create_shader_module(vk, common.get("vert")?)?,
            ));
            modules.push((
                vk::ShaderStageFlags::GEOMETRY,
                create_shader_module(vk, binaries.get(&test_program)?)?,
            ));
        }
        Stage::TessellationControl => {
            modules.push((
                vk::ShaderStageFlags::VERTEX,
                create_shader_module(vk, common.get("vert")?)?,
            ));
            modules.push((
                vk::ShaderStageFlags::TESSELLATION_CONTROL,
                create_shader_module(vk, binaries.get(&test_program)?)?,
            ));
            modules.push((
                vk::ShaderStageFlags::TESSELLATION_EVALUATION,
                create_shader_module(vk, common.get("tese")?)?,
            ));
        }
        Stage::TessellationEvaluation => {
            modules.push((
                vk::ShaderStageFlags::VERTEX,
                create_shader_module(vk, common.get("vert")?)?,
            ));
            modules.push((
                vk::ShaderStageFlags::TESSELLATION_CONTROL,
                create_shader_module(vk, common.get("tesc")?)?,
            ));
            modules.push((
                vk::ShaderStageFlags::TESSELLATION_EVALUATION,
                create_shader_module(vk, binaries.get(&test_program)?)?,
            ));
        }
        Stage::Fragment => unreachable!("the fragment stage has its own test"),
    }
    modules.push((
        vk::ShaderStageFlags::FRAGMENT,
        create_shader_module(vk, common.get("fragment")?)?,
    ));

    let mut input_buffers = Vec::with_capacity(params.inputs.len());
    let mut layout_builder = DescriptorSetLayoutBuilder::new();
    for input in &params.inputs {
        debug_assert!(input.is_ubo());
        let buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(input.size_in_bytes(), vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        initialize_memory(context, buffer.get_allocation(), input)?;
        layout_builder = layout_builder.add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, stage.flag());
        input_buffers.push(buffer);
    }
    let descriptor_set_layout = layout_builder.build(vk)?;
    let pipeline_layout = make_pipeline_layout(vk, &[*descriptor_set_layout])?;
    let render_pass = make_render_pass(vk, format)?;

    let stage_modules: Vec<(vk::ShaderStageFlags, vk::ShaderModule)> =
        modules.iter().map(|(flag, module)| (*flag, **module)).collect();
    let topology = if stage.uses_patches() {
        vk::PrimitiveTopology::PATCH_LIST
    } else {
        vk::PrimitiveTopology::POINT_LIST
    };
    let stage_options = stage_options(context, params, stage.flag());
    let pipeline = make_pipeline(
        vk,
        *pipeline_layout,
        &stage_modules,
        *render_pass,
        topology,
        true,
        color_mask,
        stage_options.as_ref(),
    )?;

    let mut pool_builder = DescriptorPoolBuilder::new();
    for _ in &params.inputs {
        pool_builder = pool_builder.add_type(vk::DescriptorType::UNIFORM_BUFFER, 1);
    }
    // A pool without sizes is invalid, and a case without inputs has nothing to bind (`extraDataCount > 0`).
    let descriptor_pool = if params.inputs.is_empty() {
        None
    } else {
        Some(pool_builder.build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?)
    };
    let descriptor_set = match &descriptor_pool {
        Some(pool) => Some(make_descriptor_set(vk, **pool, *descriptor_set_layout)?),
        None => None,
    };
    let infos: Vec<vk::DescriptorBufferInfo> = input_buffers
        .iter()
        .zip(&params.inputs)
        .map(|(buffer, input)| make_descriptor_buffer_info(buffer.get(), 0, input.size_in_bytes()))
        .collect();
    if let Some(descriptor_set) = &descriptor_set {
        let mut update_builder = DescriptorSetUpdateBuilder::new();
        for (i, info) in infos.iter().enumerate() {
            update_builder = update_builder.write_single(
                **descriptor_set,
                Location::binding(i as u32),
                vk::DescriptorType::UNIFORM_BUFFER,
                info,
            );
        }
        update_builder.update(vk);
    }

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_buffer = cmd_buffer.get();

    // A patch is two vertices, one on each side of the pixel it covers; the points are in the middle of theirs.
    let vertices_per_pixel = if stage.uses_patches() { 2usize } else { 1 };
    let vertex_buffer_size = (vertices_per_pixel * MAX_WIDTH as usize * std::mem::size_of::<[f32; 4]>()) as u64;
    let vertex_buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    {
        let color = if stage.uses_patches() {
            [1.0f32, 0.0, 1.0, 1.0]
        } else {
            [1.0f32, 1.0, 1.0, 1.0]
        };
        let mut data = vec![color; vertices_per_pixel * MAX_WIDTH as usize];
        let pixel_size = 2.0 / MAX_WIDTH as f32;
        let mut left_hand_position = -1.0f32;
        if stage.uses_patches() {
            for pair in data.chunks_exact_mut(2) {
                pair[0][0] = left_hand_position;
                left_hand_position += pixel_size;
                pair[1][0] = left_hand_position;
            }
        } else {
            for vertex in data.iter_mut() {
                vertex[0] = left_hand_position + pixel_size / 2.0;
                left_hand_position += pixel_size;
            }
        }
        // SAFETY: the buffer was created with room for `data` and is mapped in full.
        unsafe {
            std::ptr::copy_nonoverlapping(
                data.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                vertex_buffer_size as usize,
            )
        };
        flush_alloc(vk, vertex_buffer.get_allocation())?;
    }

    let discardable_image = ImageWithMemory::new(
        vk,
        allocator,
        make_image_create_info(
            IVec2::new(MAX_WIDTH as i32, 1),
            format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        ),
        MemoryRequirement::ANY,
    )?;
    let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let image_view = make_image_view(
        vk,
        discardable_image.get(),
        vk::ImageViewType::_2D,
        format,
        subresource_range,
    )?;
    let framebuffer = make_framebuffer(vk, *render_pass, &[*image_view], MAX_WIDTH, 1, 1)?;
    let viewport = vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: MAX_WIDTH as f32,
        height: 1.0,
        min_depth: 0.0,
        max_depth: 1.0,
    };
    let scissor = make_rect_2d(0, 0, MAX_WIDTH, 1);
    let image_buffer_result = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(element_size * u64::from(MAX_WIDTH), vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let mut total_iterations = 0u32;
    let mut failed_iterations = 0u32;
    let mut width = 1u32;
    while width < MAX_WIDTH {
        total_iterations += 1;

        for (buffer, input) in input_buffers.iter().zip(&params.inputs) {
            initialize_memory(context, buffer.get_allocation(), input)?;
        }

        begin_command_buffer(vk, cmd_buffer)?;
        unsafe {
            vk.cmd_set_viewport(cmd_buffer, 0, &[viewport]);
            vk.cmd_set_scissor(cmd_buffer, 0, &[scissor]);
        }
        begin_render_pass(
            vk,
            cmd_buffer,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, MAX_WIDTH, 1),
            vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.0; 4] },
            },
        );
        unsafe {
            vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            if let Some(descriptor_set) = &descriptor_set {
                vk.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[**descriptor_set],
                    &[],
                );
            }
            vk.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
            vk.cmd_draw(cmd_buffer, width * vertices_per_pixel as u32, 1, 0, 0);
        }
        end_render_pass(vk, cmd_buffer);

        // copyImageToBuffer
        unsafe {
            let to_transfer_read = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                discardable_image.get(),
                subresource_range,
            );
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_transfer_read],
            );
            let copy = make_buffer_image_copy(
                vk::Extent3D {
                    width: MAX_WIDTH,
                    height: 1,
                    depth: 1,
                },
                make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            );
            vk.cmd_copy_image_to_buffer(
                cmd_buffer,
                discardable_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                image_buffer_result.get(),
                &[copy],
            );
            let to_host_read = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                image_buffer_result.get(),
                0,
                vk::WHOLE_SIZE,
            );
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[to_host_read],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(vk, cmd_buffer)?;
        submit_commands_and_wait(vk, queue, cmd_buffer)?;

        invalidate_alloc(vk, image_buffer_result.get_allocation())?;
        // SAFETY: the buffer holds `MAX_WIDTH` pixels and is mapped in full.
        let results = unsafe {
            std::slice::from_raw_parts(
                image_buffer_result
                    .get_allocation()
                    .get_host_ptr()
                    .cast_const()
                    .cast::<u32>(),
                MAX_WIDTH as usize * components,
            )
        };
        let checked_width = if stage == Stage::TessellationEvaluation {
            width / 2
        } else {
            width
        };
        let passed = match (params.builtin, &params.size_control) {
            (_, Some(size_control)) => {
                let properties = subgroup_size_control_properties(context);
                check_size_control(
                    results,
                    checked_width as usize,
                    properties.min_subgroup_size,
                    properties.max_subgroup_size,
                    size_control.required_subgroup_size(context),
                )
            }
            (Some(builtin), None) => check_vertex_pipeline_stages_builtin(
                builtin,
                results,
                checked_width,
                subgroup_properties(context).subgroup_size,
            ),
            (None, None) => check(results, checked_width as usize, params.check),
        };
        if !passed {
            failed_iterations += 1;
        }

        width = get_next_width(width);
    }

    if failed_iterations > 0 {
        return Ok(TestStatus::fail(format!(
            "Failed! ({} / {} values passed)",
            total_iterations.saturating_sub(failed_iterations),
            total_iterations
        )));
    }

    Ok(TestStatus::pass("OK"))
}

/// The stage flags and required subgroup size of a size control case for the stage it tests
fn stage_options(context: &Context<'_>, params: &Params, stage: vk::ShaderStageFlags) -> Option<StageOptions> {
    params.size_control.as_ref().map(|size_control| StageOptions {
        stage,
        flags: size_control.flags,
        required_subgroup_size: size_control.required_subgroup_size(context).unwrap_or(0),
    })
}

/// `checkFragmentPipelineStages` of the vote tests: 0x40 marks that a helper invocation was in the subgroup, which then has to show in the other bits.
fn check_fragment_pipeline_stages(data: &[u32], width: u32, height: u32) -> bool {
    for x in 0..width {
        for y in 0..height {
            let value = data[(x * height + y) as usize];
            let verdict = value & 0x1F;
            if value & 0x40 != 0 {
                // Helper fragment shader invocation was executed
                if verdict != 0x1F {
                    return false;
                }
            } else if verdict != 0x1E {
                // Helper fragment shader invocation was not executed yet
                return false;
            }
        }
    }
    true
}

/// `makeFragmentFrameBufferTest`: a full-screen triangle strip over a render target of every size from 8x8 to subgroupSize x subgroupSize, the test
/// source running in the fragment shader.
fn make_fragment_frame_buffer_test(context: &Context<'_>, params: &Params) -> TestOutcome {
    let vk = context.get_device();
    let allocator = context.get_default_allocator();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();
    let format = vk::Format::R32_UINT;
    let element_size = 4u64;

    let binaries = context.get_binary_collection();
    let vertex_module = create_shader_module(vk, binaries.get("vert")?)?;
    let fragment_module = create_shader_module(vk, binaries.get("fragment")?)?;

    let mut input_buffers = Vec::with_capacity(params.inputs.len());
    let mut layout_builder = DescriptorSetLayoutBuilder::new();
    for input in &params.inputs {
        debug_assert!(input.is_ubo());
        let buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(input.size_in_bytes(), vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        initialize_memory(context, buffer.get_allocation(), input)?;
        layout_builder =
            layout_builder.add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::FRAGMENT);
        input_buffers.push(buffer);
    }
    let descriptor_set_layout = layout_builder.build(vk)?;
    let pipeline_layout = make_pipeline_layout(vk, &[*descriptor_set_layout])?;
    let render_pass = make_render_pass(vk, format)?;
    let pipeline = make_pipeline(
        vk,
        *pipeline_layout,
        &[
            (vk::ShaderStageFlags::VERTEX, *vertex_module),
            (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
        ],
        *render_pass,
        vk::PrimitiveTopology::TRIANGLE_STRIP,
        false,
        vk::ColorComponentFlags::R,
        stage_options(context, params, vk::ShaderStageFlags::FRAGMENT).as_ref(),
    )?;

    let mut pool_builder = DescriptorPoolBuilder::new();
    for _ in &params.inputs {
        pool_builder = pool_builder.add_type(vk::DescriptorType::UNIFORM_BUFFER, 1);
    }
    let descriptor_pool = if params.inputs.is_empty() {
        None
    } else {
        Some(pool_builder.build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?)
    };
    let descriptor_set = match &descriptor_pool {
        Some(pool) => Some(make_descriptor_set(vk, **pool, *descriptor_set_layout)?),
        None => None,
    };
    let infos: Vec<vk::DescriptorBufferInfo> = input_buffers
        .iter()
        .zip(&params.inputs)
        .map(|(buffer, input)| make_descriptor_buffer_info(buffer.get(), 0, input.size_in_bytes()))
        .collect();
    if let Some(descriptor_set) = &descriptor_set {
        let mut update_builder = DescriptorSetUpdateBuilder::new();
        for (i, info) in infos.iter().enumerate() {
            update_builder = update_builder.write_single(
                **descriptor_set,
                Location::binding(i as u32),
                vk::DescriptorType::UNIFORM_BUFFER,
                info,
            );
        }
        update_builder.update(vk);
    }

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_buffer = cmd_buffer.get();
    let subgroup_size = subgroup_properties(context).subgroup_size;
    let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

    let mut total_iterations = 0u32;
    let mut failed_iterations = 0u32;
    let mut width = 8u32;
    while width <= subgroup_size {
        let mut height = 8u32;
        while height <= subgroup_size {
            total_iterations += 1;

            // re-init the data
            for (buffer, input) in input_buffers.iter().zip(&params.inputs) {
                initialize_memory(context, buffer.get_allocation(), input)?;
            }

            let result_image_size = u64::from(width) * u64::from(height) * element_size;
            let result_image = ImageWithMemory::new(
                vk,
                allocator,
                make_image_create_info(
                    IVec2::new(width as i32, height as i32),
                    format,
                    vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
                ),
                MemoryRequirement::ANY,
            )?;
            let result_view = make_image_view(
                vk,
                result_image.get(),
                vk::ImageViewType::_2D,
                format,
                subresource_range,
            )?;
            let result_buffer = BufferWithMemory::new(
                vk,
                allocator,
                make_buffer_create_info(result_image_size, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            let framebuffer = make_framebuffer(vk, *render_pass, &[*result_view], width, height, 1)?;
            let viewport = vk::Viewport {
                x: 0.0,
                y: 0.0,
                width: width as f32,
                height: height as f32,
                min_depth: 0.0,
                max_depth: 1.0,
            };
            let scissor = make_rect_2d(0, 0, width, height);

            begin_command_buffer(vk, cmd_buffer)?;
            unsafe {
                vk.cmd_set_viewport(cmd_buffer, 0, &[viewport]);
                vk.cmd_set_scissor(cmd_buffer, 0, &[scissor]);
            }
            begin_render_pass(
                vk,
                cmd_buffer,
                *render_pass,
                *framebuffer,
                make_rect_2d(0, 0, width, height),
                vk::ClearValue {
                    color: vk::ClearColorValue { float32: [0.0; 4] },
                },
            );
            unsafe {
                vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                if let Some(descriptor_set) = &descriptor_set {
                    vk.cmd_bind_descriptor_sets(
                        cmd_buffer,
                        vk::PipelineBindPoint::GRAPHICS,
                        *pipeline_layout,
                        0,
                        &[**descriptor_set],
                        &[],
                    );
                }
                vk.cmd_draw(cmd_buffer, 4, 1, 0, 0);
            }
            end_render_pass(vk, cmd_buffer);

            // copyImageToBuffer
            unsafe {
                let to_transfer_read = make_image_memory_barrier(
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    result_image.get(),
                    subresource_range,
                );
                vk.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_transfer_read],
                );
                let copy = make_buffer_image_copy(
                    vk::Extent3D {
                        width,
                        height,
                        depth: 1,
                    },
                    make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                );
                vk.cmd_copy_image_to_buffer(
                    cmd_buffer,
                    result_image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    result_buffer.get(),
                    &[copy],
                );
                let to_host_read = make_buffer_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::HOST_READ,
                    result_buffer.get(),
                    0,
                    vk::WHOLE_SIZE,
                );
                vk.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[to_host_read],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
            end_command_buffer(vk, cmd_buffer)?;
            submit_commands_and_wait(vk, queue, cmd_buffer)?;

            invalidate_alloc(vk, result_buffer.get_allocation())?;
            // SAFETY: the buffer holds `width * height` pixels and is mapped in full.
            let results = unsafe {
                std::slice::from_raw_parts(
                    result_buffer.get_allocation().get_host_ptr().cast_const().cast::<u32>(),
                    (width * height) as usize,
                )
            };
            let passed = match &params.size_control {
                Some(size_control) => {
                    let properties = subgroup_size_control_properties(context);
                    check_size_control(
                        results,
                        (width * height) as usize,
                        properties.min_subgroup_size,
                        properties.max_subgroup_size,
                        size_control.required_subgroup_size(context),
                    )
                }
                None => check_fragment_pipeline_stages(results, width, height),
            };
            if !passed {
                failed_iterations += 1;
            }

            height *= 2;
        }
        width *= 2;
    }

    if failed_iterations > 0 {
        return Ok(TestStatus::fail(format!(
            "Failed! ({} / {} values passed)",
            total_iterations.saturating_sub(failed_iterations),
            total_iterations
        )));
    }

    Ok(TestStatus::pass("OK"))
}

/// The cases of the framebuffer groups of the ported families, as the groups of their path below `subgroups` and the case.
pub fn create_framebuffer_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_SUBGROUP_FRAMEBUFFER_CASE
        .iter()
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            segments.remove(0);
            (
                segments,
                Box::new(SubgroupFramebufferTestCase {
                    name: leaf.to_string(),
                    spec: case.spec,
                    programs: case.programs,
                }) as Box<dyn TestCase>,
            )
        })
        .collect()
}
