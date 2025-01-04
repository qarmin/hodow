// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/rasterization/vktRasterizationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Imagination Technologies Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The part of `createRasterizationTests` that verifies the rasterization of triangles, points and polygon modes with
// `tcu::rasterization_verifier`: `primitives.no_stipple.{triangles,triangle_strip,triangle_fan,points}`, `fill_rules` and
// `culling` (without the `primitive_id` case). `BaseRenderingTestInstance` is `RenderingHarness`; upstream's test
// instances run one `iterate` per iteration and these run the iterations in a loop. Also here: `interpolation`,
// `flatshading` and the `_multisample_<n>_bit` variants of `primitives` (triangles and points), `fill_rules` and
// `interpolation`. Not ported: the line rasterization cases (they need `verifyRelaxedLineGroupRasterization`),
// discard and polygon-mode large points (the line cases are in line_tests.rs, conservative rasterization in conservative_tests.rs). The shaders are in
// `shaders/manifest/rasterization_rendering.toml`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtExtendedDynamicStateExtensionDeviceCommands, ExtLineRasterizationExtensionDeviceCommands,
    KhrLineRasterizationExtensionDeviceCommands,
};

use crate::generated::shaders::rasterization_rendering::{POINT_DEFAULT_SIZE, RENDERING_BASE, RENDERING_FLAT};
use crate::tcu::rasterization_verifier::{
    LineSceneSpec, PointSceneSpec, RasterizationArguments, SceneLine, ScenePoint, SceneTriangle, TriangleSceneSpec,
    VerificationMode, verify_line_group_rasterization, verify_point_group_rasterization,
    verify_triangle_group_interpolation, verify_triangle_group_rasterization,
    verify_triangulated_line_group_interpolation,
};
use crate::tcu::{RGBA, Random, Surface, TestError, TestOutcome, TestStatus, Vec2, Vec4};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::context::RobustnessFeatures;
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::rasterization::simple_tests;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The manifest declares its one case with this: just the shader pair.
pub struct RenderingProgram {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

pub(super) const RESOLUTION_POT: u32 = 256;
const IMAGE_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// The per-draw state `BaseRenderingTestInstance` virtual getters supply.
#[derive(Clone, Copy)]
pub(super) struct DrawState {
    pub(super) line_width: f32,
    pub(super) point_size: f32,
    pub(super) cull_mode: vk::CullModeFlags,
    pub(super) front_face: vk::FrontFace,
    pub(super) polygon_mode: vk::PolygonMode,
    // `FillRuleTestInstance::getColorBlendStateCreateInfo`: additive blending to find overlapping fragments.
    pub(super) additive_blend: bool,
    pub(super) rasterizer_discard: bool,
    // `drawPrimitivesDiscard`: a pipeline statistics query around the draw.
    pub(super) query_pool: Option<vk::QueryPool>,
    // `getLineRasterizationStateCreateInfo`: `None` is VK_LINE_RASTERIZATION_MODE_LAST, no line state in the pipeline.
    pub(super) line_mode: Option<vk::LineRasterizationMode>,
    pub(super) line_stipple_enable: bool,
    pub(super) line_stipple_factor: u32,
    pub(super) line_stipple_pattern: u16,
    // `getLineStippleDynamic`: the stipple is set with vkCmdSetLineStipple instead of the pipeline.
    pub(super) dynamic_line_stipple: Option<(u32, u16)>,
    // `isDynamicTopology`: (the wrong topology, the right one) - four offscreen points are drawn with the wrong one before the draw.
    pub(super) dynamic_topology: Option<(vk::PrimitiveTopology, vk::PrimitiveTopology)>,
    // `VkPipelineRasterizationConservativeStateCreateInfoEXT` chained to the rasterization state: the mode and the extra overestimation size.
    pub(super) conservative: Option<(vk::ConservativeRasterizationModeEXT, f32)>,
}

impl Default for DrawState {
    fn default() -> Self {
        Self {
            line_width: 1.0,
            point_size: 1.0,
            cull_mode: vk::CullModeFlags::NONE,
            front_face: vk::FrontFace::COUNTER_CLOCKWISE,
            polygon_mode: vk::PolygonMode::FILL,
            additive_blend: false,
            rasterizer_discard: false,
            query_pool: None,
            line_mode: Some(vk::LineRasterizationMode::DEFAULT),
            line_stipple_enable: false,
            line_stipple_factor: 1,
            line_stipple_pattern: 0xFFFF,
            dynamic_line_stipple: None,
            dynamic_topology: None,
            conservative: None,
        }
    }
}

/// `checkImageFormatProperties` of the `BaseRenderingTestInstance` constructor.
pub(super) fn check_render_target_support(
    context: &Context<'_>,
    format: vk::Format,
    sample_count: vk::SampleCountFlags,
) -> Result<(), TestError> {
    let usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
    let properties = unsafe {
        context.get_instance().get_physical_device_image_format_properties(
            context.get_physical_device(),
            format,
            vk::ImageType::_2D,
            vk::ImageTiling::OPTIMAL,
            usage,
            vk::ImageCreateFlags::empty(),
        )
    };
    match properties {
        Ok(properties) if properties.sample_counts.contains(sample_count) => Ok(()),
        _ => Err(TestError::NotSupported("Format not supported".to_string())),
    }
}

/// `PointSizeTestCase::createInstance`'s limit checks: the render target has to fit the viewport and the framebuffer.
fn check_point_size_support(context: &Context<'_>, render_size: u32) -> Result<(), TestError> {
    let limits = &context.get_device_properties().limits;

    if render_size > limits.max_viewport_dimensions[0] || render_size > limits.max_viewport_dimensions[1] {
        return Err(TestError::NotSupported("Viewport dimensions not supported".to_string()));
    }
    if render_size > limits.max_framebuffer_width || render_size > limits.max_framebuffer_height {
        return Err(TestError::NotSupported(
            "Framebuffer width/height not supported".to_string(),
        ));
    }
    Ok(())
}

/// `BaseRenderingTestInstance`: the render target (multisampled with a resolve image when asked to), its render pass,
/// the descriptor set holding the point size uniform, and the shaders.
pub(super) struct RenderingHarness<'a> {
    context: &'a Context<'a>,
    pub(super) render_size: u32,
    pub(super) sample_count: vk::SampleCountFlags,
    pub(super) multisampling: bool,
    pub(super) subpixel_bits: u32,
    image: ImageWithMemory<'a>,
    _image_view: Unique<'a, vk::ImageView>,
    resolved_image: Option<ImageWithMemory<'a>>,
    _resolved_image_view: Option<Unique<'a, vk::ImageView>>,
    render_pass: Unique<'a, vk::RenderPass>,
    frame_buffer: Unique<'a, vk::Framebuffer>,
    _descriptor_set_layout: Unique<'a, vk::DescriptorSetLayout>,
    descriptor_set: crate::vk::ref_util::UniqueDescriptorSet<'a>,
    _descriptor_pool: Unique<'a, vk::DescriptorPool>,
    uniform_buffer: BufferWithMemory<'a>,
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    vertex_shader_module: Unique<'a, vk::ShaderModule>,
    fragment_shader_module: Unique<'a, vk::ShaderModule>,
    result_buffer: BufferWithMemory<'a>,
    command_pool: Unique<'a, vk::CommandPool>,
}

impl<'a> RenderingHarness<'a> {
    pub(super) fn new(
        context: &'a Context<'a>,
        sample_count: vk::SampleCountFlags,
        render_size: u32,
    ) -> Result<Self, TestError> {
        Self::new_with_format(context, sample_count, render_size, IMAGE_FORMAT)
    }

    fn new_with_format(
        context: &'a Context<'a>,
        sample_count: vk::SampleCountFlags,
        render_size: u32,
        format: vk::Format,
    ) -> Result<Self, TestError> {
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let multisampling = sample_count != vk::SampleCountFlags::_1;
        let subpixel_bits = context.get_device_properties().limits.sub_pixel_precision_bits;

        let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;

        check_render_target_support(context, format, sample_count)?;
        let make_image = |samples: vk::SampleCountFlags, usage: vk::ImageUsageFlags| {
            let info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(vk::Extent3D {
                    width: render_size,
                    height: render_size,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(samples)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)
        };
        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let image = make_image(
            sample_count,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        )?;
        let image_view = make_image_view(device, image.get(), vk::ImageViewType::_2D, format, subresource_range)?;

        let (resolved_image, resolved_image_view) = if multisampling {
            let resolved = make_image(
                vk::SampleCountFlags::_1,
                vk::ImageUsageFlags::COLOR_ATTACHMENT
                    | vk::ImageUsageFlags::TRANSFER_SRC
                    | vk::ImageUsageFlags::TRANSFER_DST,
            )?;
            let view = make_image_view(
                device,
                resolved.get(),
                vk::ImageViewType::_2D,
                format,
                subresource_range,
            )?;
            (Some(resolved), Some(view))
        } else {
            (None, None)
        };

        // Render Pass
        let image_layout = vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL;
        let attachment_descs = [
            vk::AttachmentDescription::builder()
                .format(format)
                .samples(sample_count)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(image_layout)
                .final_layout(image_layout)
                .build(),
            vk::AttachmentDescription::builder()
                .format(format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::DONT_CARE)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(image_layout)
                .final_layout(image_layout)
                .build(),
        ];
        let attachment_ref = [vk::AttachmentReference {
            attachment: 0,
            layout: image_layout,
        }];
        let resolve_attachment_ref = [vk::AttachmentReference {
            attachment: 1,
            layout: image_layout,
        }];
        let mut subpass_desc = vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&attachment_ref);
        if multisampling {
            subpass_desc = subpass_desc.resolve_attachments(&resolve_attachment_ref);
        }
        let subpass_descs = [subpass_desc.build()];
        let attachment_count = if multisampling { 2 } else { 1 };
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachment_descs[..attachment_count])
            .subpasses(&subpass_descs);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );

        // FrameBuffer
        let mut attachments = vec![*image_view];
        if let Some(view) = &resolved_image_view {
            attachments.push(**view);
        }
        let frame_buffer = make_framebuffer(device, *render_pass, &attachments, render_size, render_size, 1)?;

        // Uniform Buffer
        let uniform_buffer_size = std::mem::size_of::<f32>() as vk::DeviceSize;
        let uniform_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(uniform_buffer_size, vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Descriptors
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::ALL)
            .build(device)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let descriptor_buffer_info = make_descriptor_buffer_info(uniform_buffer.get(), 0, vk::WHOLE_SIZE);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set,
                Location::binding(0),
                vk::DescriptorType::UNIFORM_BUFFER,
                &descriptor_buffer_info,
            )
            .update(device);

        // Pipeline Layout
        let set_layouts = [*descriptor_set_layout];
        let pipeline_layout = make_pipeline_layout(device, &set_layouts)?;

        // Shaders
        let binaries = context.get_binary_collection();
        let vertex_shader_module = create_shader_module(device, binaries.get("vertext_shader")?)?;
        let fragment_shader_module = create_shader_module(device, binaries.get("fragment_shader")?)?;

        // Result Buffer
        let texel_size: u32 = if format == vk::Format::R8_UNORM { 1 } else { 4 };
        let result_buffer_size = (render_size * render_size * texel_size) as vk::DeviceSize;
        let result_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(result_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        log::info!("Sample count = {sample_count:?}, SUBPIXEL_BITS = {subpixel_bits}");

        Ok(Self {
            context,
            render_size,
            sample_count,
            multisampling,
            subpixel_bits,
            image,
            _image_view: image_view,
            resolved_image,
            _resolved_image_view: resolved_image_view,
            render_pass,
            frame_buffer,
            _descriptor_set_layout: descriptor_set_layout,
            _descriptor_pool: descriptor_pool,
            descriptor_set,
            uniform_buffer,
            pipeline_layout,
            vertex_shader_module,
            fragment_shader_module,
            result_buffer,
            command_pool,
        })
    }

    /// The `RasterizationArguments` every `compareAndVerify` builds. `num_samples` is whatever the caller's own
    /// multisampling flag says: the culling instance shadows the base class's.
    pub(super) fn rasterization_args(&self, multisampled: bool) -> RasterizationArguments {
        RasterizationArguments {
            num_samples: i32::from(multisampled),
            subpixel_bits: self.subpixel_bits as i32,
            red_bits: 8,
            green_bits: 8,
            blue_bits: 8,
        }
    }

    /// `drawPrimitives` with the colour white for every vertex.
    fn draw_white(
        &self,
        position_data: &[Vec4],
        topology: vk::PrimitiveTopology,
        state: &DrawState,
    ) -> Result<Surface, TestError> {
        let color_data = vec![Vec4::new(1.0, 1.0, 1.0, 1.0); position_data.len()];
        self.draw_primitives(position_data, &color_data, topology, state)
    }

    /// The graphics pipeline `drawPrimitives` builds for a draw state.
    fn create_graphics_pipeline(
        &self,
        topology: vk::PrimitiveTopology,
        state: &DrawState,
        attribute_batch_size: usize,
    ) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        let context = self.context;
        let device = context.get_device();

        // Create Graphics Pipeline
        let vertex_bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<[f32; 4]>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let vertex_attributes = [
            // Positions.
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            },
            // Colors.
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: attribute_batch_size as u32,
            },
        ];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&vertex_bindings)
            .vertex_attribute_descriptions(&vertex_attributes);
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(topology)
            .primitive_restart_enable(false);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: self.render_size as f32,
            height: self.render_size as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: self.render_size,
                height: self.render_size,
            },
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let multisample_state =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(self.sample_count);
        let mut line_state = vk::PipelineRasterizationLineStateCreateInfoKHR::builder()
            .line_rasterization_mode(state.line_mode.unwrap_or(vk::LineRasterizationMode::DEFAULT))
            .stippled_line_enable(state.line_stipple_enable)
            .line_stipple_factor(state.line_stipple_factor)
            .line_stipple_pattern(state.line_stipple_pattern);
        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(state.rasterizer_discard)
            .polygon_mode(state.polygon_mode)
            .cull_mode(state.cull_mode)
            .front_face(state.front_face)
            .depth_bias_enable(false)
            .line_width(state.line_width);
        // Upstream chains the line state unconditionally, which is only valid where the extension is enabled.
        let line_rasterization_supported = context.is_device_functionality_supported("VK_KHR_line_rasterization")
            || context.is_device_functionality_supported("VK_EXT_line_rasterization");
        let mut conservative_state = vk::PipelineRasterizationConservativeStateCreateInfoEXT::builder()
            .conservative_rasterization_mode(
                state
                    .conservative
                    .map_or(vk::ConservativeRasterizationModeEXT::DISABLED, |(mode, _)| mode),
            )
            .extra_primitive_overestimation_size(state.conservative.map_or(0.0, |(_, size)| size));
        let mut rasterization_state = rasterization_state;
        if line_rasterization_supported && state.line_mode.is_some() {
            rasterization_state = rasterization_state.push_next(&mut line_state);
        }
        if state.conservative.is_some() {
            rasterization_state = rasterization_state.push_next(&mut conservative_state);
        }
        let blend_factor = if state.additive_blend {
            vk::BlendFactor::ONE
        } else {
            vk::BlendFactor::ZERO
        };
        let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(state.additive_blend)
            .src_color_blend_factor(vk::BlendFactor::ONE)
            .dst_color_blend_factor(blend_factor)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::ONE)
            .dst_alpha_blend_factor(blend_factor)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op_enable(false)
            .logic_op(vk::LogicOp::COPY)
            .attachments(&color_blend_attachments);
        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*self.vertex_shader_module)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*self.fragment_shader_module)
                .name(b"main\0")
                .build(),
        ];
        let stage_count = if state.rasterizer_discard { 1 } else { 2 };
        let mut dynamic_states = Vec::new();
        if state.dynamic_line_stipple.is_some() {
            dynamic_states.push(vk::DynamicState::LINE_STIPPLE);
        }
        if state.dynamic_topology.is_some() {
            dynamic_states.push(vk::DynamicState::PRIMITIVE_TOPOLOGY);
        }
        let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);
        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .dynamic_state(&dynamic_state)
            .stages(&stages[..stage_count])
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .color_blend_state(&color_blend_state)
            .layout(*self.pipeline_layout)
            .render_pass(*self.render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        let graphics_pipeline = Unique::new(device, pipelines.0[0]);
        Ok(graphics_pipeline)
    }

    /// `drawPrimitives`
    pub(super) fn draw_primitives(
        &self,
        position_data: &[Vec4],
        color_data: &[Vec4],
        topology: vk::PrimitiveTopology,
        state: &DrawState,
    ) -> Result<Surface, TestError> {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let attribute_batch_size = std::mem::size_of::<[f32; 4]>() * position_data.len();
        let total_attribute_size = attribute_batch_size * 2; // Position and color.
        let limits = &context.get_device_properties().limits;

        if attribute_batch_size > limits.max_vertex_input_attribute_offset as usize {
            return Err(TestError::NotSupported(format!(
                "Larger vertex input attribute offset is needed ({attribute_batch_size}) than the available maximum ({}).",
                limits.max_vertex_input_attribute_offset
            )));
        }

        let graphics_pipeline = self.create_graphics_pipeline(topology, state, attribute_batch_size)?;

        // Create Vertex Buffer
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                total_attribute_size as vk::DeviceSize,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let host_ptr = vertex_buffer.get_allocation().get_host_ptr();
            let to_floats =
                |data: &[Vec4]| -> Vec<[f32; 4]> { data.iter().map(|v| [v.x(), v.y(), v.z(), v.w()]).collect() };
            let positions = to_floats(position_data);
            let colors = to_floats(color_data);
            unsafe {
                std::ptr::copy_nonoverlapping(positions.as_ptr() as *const u8, host_ptr, attribute_batch_size);
                std::ptr::copy_nonoverlapping(
                    colors.as_ptr() as *const u8,
                    host_ptr.add(attribute_batch_size),
                    std::mem::size_of_val(colors.as_slice()),
                );
            }
            flush_alloc(device, vertex_buffer.get_allocation())?;
        }

        // Four offscreen points, positions first and white colours at the attribute offset like the vertex buffer
        let offscreen_buffer = if state.dynamic_topology.is_some() {
            let items_per_attribute = attribute_batch_size / std::mem::size_of::<[f32; 4]>();
            let mut full_offscreen_data = vec![[0.0f32; 4]; items_per_attribute * 2];
            let offscreen_points = (0..4).map(|ndx| [2.0, 2.0 + ndx as f32, 0.0, 1.0]);
            for (slot, point) in full_offscreen_data.iter_mut().zip(offscreen_points) {
                *slot = point;
            }
            for slot in full_offscreen_data[items_per_attribute..].iter_mut().take(4) {
                *slot = [1.0, 1.0, 1.0, 1.0];
            }
            let buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(
                    total_attribute_size as vk::DeviceSize,
                    vk::BufferUsageFlags::VERTEX_BUFFER,
                ),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe {
                std::ptr::copy_nonoverlapping(
                    full_offscreen_data.as_ptr() as *const u8,
                    buffer.get_allocation().get_host_ptr(),
                    std::mem::size_of_val(full_offscreen_data.as_slice()),
                );
            }
            flush_alloc(device, buffer.get_allocation())?;
            Some(buffer)
        } else {
            None
        };

        // Create Command Buffer
        let command_buffer = allocate_command_buffer(device, *self.command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;
        begin_command_buffer(device, cmd)?;

        let transition = |image: vk::Image| {
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                image,
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::ALL_COMMANDS,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                );
            }
        };
        transition(self.image.get());
        if let Some(resolved) = &self.resolved_image {
            transition(resolved.get());
        }

        if let Some(pool) = state.query_pool {
            unsafe { device.cmd_reset_query_pool(cmd, pool, 0, 1) };
        }

        // Begin Render Pass
        let render_area = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: self.render_size,
                height: self.render_size,
            },
        };
        begin_render_pass(
            device,
            cmd,
            *self.render_pass,
            *self.frame_buffer,
            render_area,
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 1.0],
                },
            },
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *self.pipeline_layout,
                0,
                &[*self.descriptor_set],
                &[],
            );
            if let Some((factor, pattern)) = state.dynamic_line_stipple {
                if context.is_device_functionality_supported("VK_KHR_line_rasterization") {
                    device.cmd_set_line_stipple_khr(cmd, factor, pattern);
                } else {
                    device.cmd_set_line_stipple_ext(cmd, factor, pattern);
                }
                if let (Some((wrong, right)), Some(offscreen)) = (state.dynamic_topology, &offscreen_buffer) {
                    // Using a dynamic topology can interact with the dynamic line stipple set above on some implementations, so we check
                    // nothing breaks: set a wrong topology, draw some offscreen data and go back to the right topology without re-setting
                    // the line stipple again.
                    device.cmd_set_primitive_topology_ext(cmd, wrong);
                    device.cmd_bind_vertex_buffers(cmd, 0, &[offscreen.get()], &[0]);
                    device.cmd_draw(cmd, 4, 1, 0, 0);
                    device.cmd_set_primitive_topology_ext(cmd, right);
                }
            }
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            if let Some(pool) = state.query_pool {
                device.cmd_begin_query(cmd, pool, 0, vk::QueryControlFlags::empty());
            }
            device.cmd_draw(cmd, position_data.len() as u32, 1, 0, 0);
            if let Some(pool) = state.query_pool {
                device.cmd_end_query(cmd, pool, 0);
            }
        }
        end_render_pass(device, cmd);

        // Copy Image
        let copy_source = self
            .resolved_image
            .as_ref()
            .map_or_else(|| self.image.get(), |resolved| resolved.get());
        copy_image_to_buffer(
            device,
            cmd,
            copy_source,
            self.result_buffer.get(),
            self.render_size,
            self.render_size,
        );
        end_command_buffer(device, cmd)?;

        // Set Point Size
        unsafe {
            std::ptr::copy_nonoverlapping(
                state.point_size.to_ne_bytes().as_ptr(),
                self.uniform_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of::<f32>(),
            )
        };
        flush_alloc(device, self.uniform_buffer.get_allocation())?;

        // Submit
        submit_commands_and_wait(device, queue, cmd)?;

        invalidate_alloc(device, self.result_buffer.get_allocation())?;
        let pixels = unsafe {
            std::slice::from_raw_parts(
                self.result_buffer.get_allocation().get_host_ptr(),
                (self.render_size * self.render_size * 4) as usize,
            )
        };
        let mut result = Surface::new(self.render_size as i32, self.render_size as i32);
        for y in 0..self.render_size {
            for x in 0..self.render_size {
                let offset = ((y * self.render_size + x) * 4) as usize;
                result.set_pixel(
                    x as i32,
                    y as i32,
                    RGBA::new(
                        i32::from(pixels[offset]),
                        i32::from(pixels[offset + 1]),
                        i32::from(pixels[offset + 2]),
                        i32::from(pixels[offset + 3]),
                    ),
                );
            }
        }
        Ok(result)
    }

    /// The pixels of `result_buffer` as a surface.
    fn read_result_surface(&self) -> Result<Surface, TestError> {
        invalidate_alloc(self.context.get_device(), self.result_buffer.get_allocation())?;
        let pixels = unsafe {
            std::slice::from_raw_parts(
                self.result_buffer.get_allocation().get_host_ptr(),
                (self.render_size * self.render_size * 4) as usize,
            )
        };
        let mut result = Surface::new(self.render_size as i32, self.render_size as i32);
        for y in 0..self.render_size {
            for x in 0..self.render_size {
                let offset = ((y * self.render_size + x) * 4) as usize;
                result.set_pixel(
                    x as i32,
                    y as i32,
                    RGBA::new(
                        i32::from(pixels[offset]),
                        i32::from(pixels[offset + 1]),
                        i32::from(pixels[offset + 2]),
                        i32::from(pixels[offset + 3]),
                    ),
                );
            }
        }
        Ok(result)
    }

    /// `drawPrimitives` of the double draw: the first half of the vertices is drawn with `state` into this target, the second half
    /// with `second_state` into the target of `second` (a harness of the same size and sample count), both in one command buffer.
    pub(super) fn draw_primitives_double(
        &self,
        second: &RenderingHarness<'_>,
        position_data: &[Vec4],
        color_data: &[Vec4],
        topology: vk::PrimitiveTopology,
        state: &DrawState,
        second_state: &DrawState,
    ) -> Result<(Surface, Surface), TestError> {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let attribute_batch_size = std::mem::size_of::<[f32; 4]>() * position_data.len();
        let total_attribute_size = attribute_batch_size * 2; // Position and color.
        let limits = &context.get_device_properties().limits;

        if attribute_batch_size > limits.max_vertex_input_attribute_offset as usize {
            return Err(TestError::NotSupported(format!(
                "Larger vertex input attribute offset is needed ({attribute_batch_size}) than the available maximum ({}).",
                limits.max_vertex_input_attribute_offset
            )));
        }

        // The pipeline of the first draw has the stipple of `state`, the second one `second_state` (stipple disabled).
        let graphics_pipeline = self.create_graphics_pipeline(topology, state, attribute_batch_size)?;
        let no_stipple_graphics_pipeline =
            self.create_graphics_pipeline(topology, second_state, attribute_batch_size)?;

        // Create Vertex Buffer
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                total_attribute_size as vk::DeviceSize,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let host_ptr = vertex_buffer.get_allocation().get_host_ptr();
            let to_floats =
                |data: &[Vec4]| -> Vec<[f32; 4]> { data.iter().map(|v| [v.x(), v.y(), v.z(), v.w()]).collect() };
            let positions = to_floats(position_data);
            let colors = to_floats(color_data);
            unsafe {
                std::ptr::copy_nonoverlapping(positions.as_ptr() as *const u8, host_ptr, attribute_batch_size);
                std::ptr::copy_nonoverlapping(
                    colors.as_ptr() as *const u8,
                    host_ptr.add(attribute_batch_size),
                    std::mem::size_of_val(colors.as_slice()),
                );
            }
            flush_alloc(device, vertex_buffer.get_allocation())?;
        }

        // Create Command Buffer
        let command_buffer = allocate_command_buffer(device, *self.command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;
        begin_command_buffer(device, cmd)?;

        let transition = |image: vk::Image| {
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                image,
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::ALL_COMMANDS,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                );
            }
        };
        transition(self.image.get());
        if let Some(resolved) = &self.resolved_image {
            transition(resolved.get());
        }
        transition(second.image.get());
        if let Some(resolved) = &second.resolved_image {
            transition(resolved.get());
        }

        let render_area = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: self.render_size,
                height: self.render_size,
            },
        };
        let clear_value = vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 1.0],
            },
        };
        let half = (position_data.len() / 2) as u32;

        // First draw: the first half of the vertices with the stipple enabled
        begin_render_pass(
            device,
            cmd,
            *self.render_pass,
            *self.frame_buffer,
            render_area,
            clear_value,
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *self.pipeline_layout,
                0,
                &[*self.descriptor_set],
                &[],
            );
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd, half, 1, 0, 0);
        }
        end_render_pass(device, cmd);

        // Second draw: the second half of the vertices with the stipple disabled, into the second target
        begin_render_pass(
            device,
            cmd,
            *self.render_pass,
            *second.frame_buffer,
            render_area,
            clear_value,
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *no_stipple_graphics_pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *self.pipeline_layout,
                0,
                &[*self.descriptor_set],
                &[],
            );
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd, half, 1, half, 0);
        }
        end_render_pass(device, cmd);

        // Copy Images
        let copy_source = |harness: &RenderingHarness<'_>| {
            harness
                .resolved_image
                .as_ref()
                .map_or_else(|| harness.image.get(), |resolved| resolved.get())
        };
        copy_image_to_buffer(
            device,
            cmd,
            copy_source(self),
            self.result_buffer.get(),
            self.render_size,
            self.render_size,
        );
        copy_image_to_buffer(
            device,
            cmd,
            copy_source(second),
            second.result_buffer.get(),
            self.render_size,
            self.render_size,
        );
        end_command_buffer(device, cmd)?;

        // Set Point Size
        unsafe {
            std::ptr::copy_nonoverlapping(
                state.point_size.to_ne_bytes().as_ptr(),
                self.uniform_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of::<f32>(),
            )
        };
        flush_alloc(device, self.uniform_buffer.get_allocation())?;

        // Submit
        submit_commands_and_wait(device, queue, cmd)?;

        Ok((self.read_result_surface()?, second.read_result_surface()?))
    }
}

// ---------------------------------------------------------------------------------
// Triangles
// ---------------------------------------------------------------------------------

/// `TrianglesTestInstance::generateTriangles`
fn generate_triangles_list(iteration: usize) -> (Vec<Vec4>, Vec<SceneTriangle>) {
    let data: [Vec4; 6] = match iteration {
        0 => [
            // \note: these values are chosen arbitrarily
            Vec4::new(0.2, 0.8, 0.0, 1.0),
            Vec4::new(0.5, 0.2, 0.0, 1.0),
            Vec4::new(0.5, 0.3, 0.0, 1.0),
            Vec4::new(-0.5, 0.2, 0.0, 1.0),
            Vec4::new(-1.5, -0.4, 0.0, 1.0),
            Vec4::new(-0.4, 0.2, 0.0, 1.0),
        ],
        1 => [
            Vec4::new(-0.499, 0.128, 0.0, 1.0),
            Vec4::new(-0.501, -0.3, 0.0, 1.0),
            Vec4::new(0.11, -0.2, 0.0, 1.0),
            Vec4::new(0.11, 0.2, 0.0, 1.0),
            Vec4::new(0.88, 0.9, 0.0, 1.0),
            Vec4::new(0.4, 1.2, 0.0, 1.0),
        ],
        _ => [
            Vec4::new(-0.9, -0.3, 0.0, 1.0),
            Vec4::new(1.1, -0.9, 0.0, 1.0),
            Vec4::new(-1.1, -0.1, 0.0, 1.0),
            Vec4::new(-0.11, 0.2, 0.0, 1.0),
            Vec4::new(0.88, 0.7, 0.0, 1.0),
            Vec4::new(-0.4, 0.4, 0.0, 1.0),
        ],
    };

    let triangles = vec![
        SceneTriangle::new(data[0], data[1], data[2]),
        SceneTriangle::new(data[3], data[4], data[5]),
    ];
    (data.to_vec(), triangles)
}

/// A scene triangle whose edges are shared with its neighbours as given.
fn shared_triangle(p0: Vec4, p1: Vec4, p2: Vec4, shared_edge: [bool; 3]) -> SceneTriangle {
    let mut triangle = SceneTriangle::new(p0, p1, p2);
    triangle.shared_edge = shared_edge;
    triangle
}

/// `TriangleStripTestInstance::generateTriangles`
fn generate_triangles_strip(iteration: usize) -> (Vec<Vec4>, Vec<SceneTriangle>) {
    let data: [Vec4; 5] = match iteration {
        0 => [
            // \note: these values are chosen arbitrarily
            Vec4::new(-0.504, 0.8, 0.0, 1.0),
            Vec4::new(-0.2, -0.2, 0.0, 1.0),
            Vec4::new(-0.2, 0.199, 0.0, 1.0),
            Vec4::new(0.5, 0.201, 0.0, 1.0),
            Vec4::new(1.5, 0.4, 0.0, 1.0),
        ],
        1 => [
            Vec4::new(-0.499, 0.129, 0.0, 1.0),
            Vec4::new(-0.501, -0.3, 0.0, 1.0),
            Vec4::new(0.11, -0.2, 0.0, 1.0),
            Vec4::new(0.11, -0.31, 0.0, 1.0),
            Vec4::new(0.88, 0.9, 0.0, 1.0),
        ],
        _ => [
            Vec4::new(-0.9, -0.3, 0.0, 1.0),
            Vec4::new(1.1, -0.9, 0.0, 1.0),
            Vec4::new(-0.87, -0.1, 0.0, 1.0),
            Vec4::new(-0.11, 0.19, 0.0, 1.0),
            Vec4::new(0.88, 0.7, 0.0, 1.0),
        ],
    };

    let triangles = vec![
        shared_triangle(data[0], data[1], data[2], [false, true, false]),
        shared_triangle(data[2], data[1], data[3], [true, false, true]),
        shared_triangle(data[2], data[3], data[4], [true, false, false]),
    ];
    (data.to_vec(), triangles)
}

/// `TriangleFanTestInstance::generateTriangles`
fn generate_triangles_fan(iteration: usize) -> (Vec<Vec4>, Vec<SceneTriangle>) {
    let data: [Vec4; 5] = match iteration {
        0 => [
            // \note: these values are chosen arbitrarily
            Vec4::new(0.01, 0.0, 0.0, 1.0),
            Vec4::new(0.5, 0.2, 0.0, 1.0),
            Vec4::new(0.46, 0.3, 0.0, 1.0),
            Vec4::new(-0.5, 0.2, 0.0, 1.0),
            Vec4::new(-1.5, -0.4, 0.0, 1.0),
        ],
        1 => [
            Vec4::new(-0.499, 0.128, 0.0, 1.0),
            Vec4::new(-0.501, -0.3, 0.0, 1.0),
            Vec4::new(0.11, -0.2, 0.0, 1.0),
            Vec4::new(0.11, 0.2, 0.0, 1.0),
            Vec4::new(0.88, 0.9, 0.0, 1.0),
        ],
        _ => [
            Vec4::new(-0.9, -0.3, 0.0, 1.0),
            Vec4::new(1.1, -0.9, 0.0, 1.0),
            Vec4::new(0.7, -0.1, 0.0, 1.0),
            Vec4::new(0.11, 0.2, 0.0, 1.0),
            Vec4::new(0.88, 0.7, 0.0, 1.0),
        ],
    };

    let triangles = vec![
        shared_triangle(data[0], data[1], data[2], [false, false, true]),
        shared_triangle(data[0], data[2], data[3], [true, false, true]),
        shared_triangle(data[0], data[3], data[4], [true, false, false]),
    ];
    (data.to_vec(), triangles)
}

// ---------------------------------------------------------------------------------
// Points
// ---------------------------------------------------------------------------------

/// `PointTestInstance::generatePoints`
fn generate_points(iteration: usize, point_size: f32) -> (Vec<Vec4>, Vec<ScenePoint>) {
    let data: [Vec4; 6] = match iteration {
        0 => [
            // \note: these values are chosen arbitrarily
            Vec4::new(0.2, 0.8, 0.0, 1.0),
            Vec4::new(0.5, 0.2, 0.0, 1.0),
            Vec4::new(0.5, 0.3, 0.0, 1.0),
            Vec4::new(-0.5, 0.2, 0.0, 1.0),
            Vec4::new(-0.2, -0.4, 0.0, 1.0),
            Vec4::new(-0.4, 0.2, 0.0, 1.0),
        ],
        1 => [
            Vec4::new(-0.499, 0.128, 0.0, 1.0),
            Vec4::new(-0.501, -0.3, 0.0, 1.0),
            Vec4::new(0.11, -0.2, 0.0, 1.0),
            Vec4::new(0.11, 0.2, 0.0, 1.0),
            Vec4::new(0.88, 0.9, 0.0, 1.0),
            Vec4::new(0.4, 1.2, 0.0, 1.0),
        ],
        _ => [
            Vec4::new(-0.9, -0.3, 0.0, 1.0),
            Vec4::new(0.3, -0.9, 0.0, 1.0),
            Vec4::new(-0.4, -0.1, 0.0, 1.0),
            Vec4::new(-0.11, 0.2, 0.0, 1.0),
            Vec4::new(0.88, 0.7, 0.0, 1.0),
            Vec4::new(-0.4, 0.4, 0.0, 1.0),
        ],
    };

    let points = data
        .iter()
        .map(|&position| ScenePoint { position, point_size })
        .collect();
    (data.to_vec(), points)
}

// ---------------------------------------------------------------------------------
// Point sizes
// ---------------------------------------------------------------------------------

/// The optional stages `PointDefaultSizeTestInstance` adds to the vertex and fragment shaders.
#[derive(Clone, Copy)]
struct PointStages {
    tessellation: bool,
    geometry: bool,
}

impl RenderingHarness<'_> {
    /// `PointSizeTestInstance::createPipeline` / `PointDefaultSizeTestInstance::createPipeline`: a point list (or a patch list
    /// of one control point), the position attribute and, for the plain case, the colour attribute at the next 16 bytes of
    /// an interleaved 32 byte vertex.
    fn create_point_pipeline(
        &self,
        tessellation_control: Option<vk::ShaderModule>,
        tessellation_evaluation: Option<vk::ShaderModule>,
        geometry: Option<vk::ShaderModule>,
        attribute_count: usize,
    ) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        let device = self.context.get_device();
        let has_tessellation = tessellation_control.is_some() && tessellation_evaluation.is_some();
        let topology = if has_tessellation {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            vk::PrimitiveTopology::POINT_LIST
        };

        let vertex_bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: (2 * std::mem::size_of::<[f32; 4]>()) as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let vertex_attributes = [
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            },
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: std::mem::size_of::<[f32; 4]>() as u32,
            },
        ];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&vertex_bindings)
            .vertex_attribute_descriptions(&vertex_attributes[..attribute_count]);
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(topology)
            .primitive_restart_enable(false);
        let tessellation_state = vk::PipelineTessellationStateCreateInfo::builder().patch_control_points(1);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: self.render_size as f32,
            height: self.render_size as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: self.render_size,
                height: self.render_size,
            },
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0);
        let multisample_state =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .src_color_blend_factor(vk::BlendFactor::ONE)
            .dst_color_blend_factor(vk::BlendFactor::ZERO)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::ONE)
            .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op_enable(false)
            .logic_op(vk::LogicOp::COPY)
            .attachments(&color_blend_attachments);

        let stage = |stage: vk::ShaderStageFlags, module: vk::ShaderModule| {
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(stage)
                .module(module)
                .name(b"main\0")
                .build()
        };
        let mut stages = vec![stage(vk::ShaderStageFlags::VERTEX, *self.vertex_shader_module)];
        if let (Some(control), Some(evaluation)) = (tessellation_control, tessellation_evaluation) {
            stages.push(stage(vk::ShaderStageFlags::TESSELLATION_CONTROL, control));
            stages.push(stage(vk::ShaderStageFlags::TESSELLATION_EVALUATION, evaluation));
        }
        if let Some(module) = geometry {
            stages.push(stage(vk::ShaderStageFlags::GEOMETRY, module));
        }
        stages.push(stage(vk::ShaderStageFlags::FRAGMENT, *self.fragment_shader_module));

        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .tessellation_state(&tessellation_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .color_blend_state(&color_blend_state)
            .layout(*self.pipeline_layout)
            .render_pass(*self.render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        Ok(Unique::new(device, pipelines.0[0]))
    }

    /// `PointSizeTestInstance::drawPoint` - one point, drawn with `graphics_pipeline`, and the single channel result image.
    fn draw_point(
        &self,
        graphics_pipeline: vk::Pipeline,
        position: Vec4,
        color: Vec4,
        point_size: f32,
        bind_descriptor_set: bool,
    ) -> Result<&[u8], TestError> {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();

        // Create Vertex Buffer: the position and then the colour
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                2 * std::mem::size_of::<[f32; 4]>() as vk::DeviceSize,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let vertex = [
            [position.x(), position.y(), position.z(), position.w()],
            [color.x(), color.y(), color.z(), color.w()],
        ];
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertex.as_ptr() as *const u8,
                vertex_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of_val(&vertex),
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        let command_buffer = allocate_command_buffer(device, *self.command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;
        begin_command_buffer(device, cmd)?;

        let barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            self.image.get(),
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::ALL_COMMANDS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
        }

        let render_area = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: self.render_size,
                height: self.render_size,
            },
        };
        begin_render_pass(
            device,
            cmd,
            *self.render_pass,
            *self.frame_buffer,
            render_area,
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 1.0],
                },
            },
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, graphics_pipeline);
            if bind_descriptor_set {
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *self.pipeline_layout,
                    0,
                    &[*self.descriptor_set],
                    &[],
                );
            }
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd, 1, 1, 0, 0);
        }
        end_render_pass(device, cmd);

        copy_image_to_buffer(
            device,
            cmd,
            self.image.get(),
            self.result_buffer.get(),
            self.render_size,
            self.render_size,
        );
        end_command_buffer(device, cmd)?;

        // Set Point Size
        unsafe {
            std::ptr::copy_nonoverlapping(
                point_size.to_ne_bytes().as_ptr(),
                self.uniform_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of::<f32>(),
            )
        };
        flush_alloc(device, self.uniform_buffer.get_allocation())?;

        submit_commands_and_wait(device, queue, cmd)?;

        invalidate_alloc(device, self.result_buffer.get_allocation())?;
        Ok(unsafe {
            std::slice::from_raw_parts(
                self.result_buffer.get_allocation().get_host_ptr(),
                (self.render_size * self.render_size) as usize,
            )
        })
    }
}

/// `PointSizeTestInstance::verifyPoint`. Both loops read the middle row, as upstream's do.
fn verify_point(image: &[u8], size: u32, point_size: f32) -> bool {
    let expected_point_color = 255u8;
    let expected_background_color = 0u8;
    let mut point_width = 0u32;
    let mut point_height = 0u32;
    let mut incorrectly_colored_pixels_found = false;
    let mut is_ok = true;
    let row = (size / 2) as usize;

    // Verify rasterized point width and color
    for x in 0..size as usize {
        let pixel_color = image[row * size as usize + x];

        if pixel_color == expected_point_color {
            point_width += 1;
        }
        if pixel_color != expected_point_color && pixel_color != expected_background_color {
            incorrectly_colored_pixels_found = true;
        }
    }

    // Verify rasterized point height and color
    for y in 0..size as usize {
        let pixel_color = image[row * size as usize + y];

        if pixel_color == expected_point_color {
            point_height += 1;
        }
        if pixel_color != expected_point_color && pixel_color != expected_background_color {
            incorrectly_colored_pixels_found = true;
        }
    }

    // Compare amount of rasterized point pixels to expected pointSize.
    let expected_size = point_size.round() as u32;
    if point_width != expected_size || point_height != expected_size {
        log::info!(
            "Incorrect point size. Expected pointSize: {point_size}. Rasterized point width: {point_width} pixels, height: {point_height} pixels."
        );
        is_ok = false;
    }

    // Check incorrectly colored pixels
    if incorrectly_colored_pixels_found {
        log::info!("Incorrectly colored pixels found.");
        is_ok = false;
    }

    is_ok
}

// ---------------------------------------------------------------------------------
// Fill rules
// ---------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum FillRuleCaseType {
    Basic,
    Reversed,
    ClippedFull,
    ClippedPartial,
    Projected,
}

impl FillRuleCaseType {
    /// `FillRuleTestInstance::getRenderSize`
    fn render_size(self) -> u32 {
        if matches!(self, Self::ClippedFull | Self::ClippedPartial) {
            RESOLUTION_POT / 4
        } else {
            RESOLUTION_POT
        }
    }

    /// `FillRuleTestInstance::getNumIterations`
    fn iteration_count(self) -> usize {
        if matches!(self, Self::ClippedFull | Self::ClippedPartial) {
            15
        } else {
            2
        }
    }

    /// `FillRuleTestInstance::generateTriangles`
    fn generate_triangles(self, iteration: usize) -> Vec<Vec4> {
        let iteration_count = self.iteration_count();
        match self {
            Self::Basic | Self::Reversed | Self::Projected => {
                let num_rows = 4usize;
                let num_columns = 4usize;
                let quad_side = 0.15f32;
                let mut rnd = Random::new(0xabcd);
                let mut out_data = vec![Vec4::new(0.0, 0.0, 0.0, 0.0); 6 * num_rows * num_columns];

                for col in 0..num_columns {
                    for row in 0..num_rows {
                        let center = Vec2::new(
                            (row as f32 + 0.5) / num_rows as f32 * 2.0 - 1.0,
                            (col as f32 + 0.5) / num_columns as f32 * 2.0 - 1.0,
                        );
                        let rotation = ((iteration * num_columns * num_rows + col * num_rows + row) as f32
                            / (iteration_count * num_columns * num_rows) as f32)
                            as f64
                            * std::f64::consts::PI
                            / 2.0;
                        let rotation = rotation as f32;
                        let side_h = Vec2::new(quad_side * rotation.cos(), quad_side * rotation.sin());
                        let side_v = Vec2::new(side_h.y(), -side_h.x());
                        let quad = [
                            center + side_h + side_v,
                            center + side_h - side_v,
                            center - side_h - side_v,
                            center - side_h + side_v,
                        ];
                        let base = 6 * (col * num_rows + row);

                        match self {
                            Self::Basic => {
                                for (offset, quad_index) in [0, 1, 2, 2, 0, 3].into_iter().enumerate() {
                                    out_data[base + offset] =
                                        Vec4::new(quad[quad_index].x(), quad[quad_index].y(), 0.0, 1.0);
                                }
                            }
                            Self::Reversed => {
                                for (offset, quad_index) in [0, 1, 2, 0, 2, 3].into_iter().enumerate() {
                                    out_data[base + offset] =
                                        Vec4::new(quad[quad_index].x(), quad[quad_index].y(), 0.0, 1.0);
                                }
                            }
                            _ => {
                                let w0 = rnd.get_float_range(0.1, 4.0);
                                let w1 = rnd.get_float_range(0.1, 4.0);
                                let w2 = rnd.get_float_range(0.1, 4.0);
                                let w3 = rnd.get_float_range(0.1, 4.0);
                                let w = [w0, w1, w2, w3];
                                for (offset, quad_index) in [0, 1, 2, 2, 0, 3].into_iter().enumerate() {
                                    let weight = w[quad_index];
                                    out_data[base + offset] = Vec4::new(
                                        quad[quad_index].x() * weight,
                                        quad[quad_index].y() * weight,
                                        0.0,
                                        weight,
                                    );
                                }
                            }
                        }
                    }
                }
                out_data
            }
            Self::ClippedPartial | Self::ClippedFull => {
                let quad_side = if self == Self::ClippedPartial { 1.0f32 } else { 2.0 };
                let center = if self == Self::ClippedPartial {
                    Vec2::new(0.5, 0.5)
                } else {
                    Vec2::new(0.0, 0.0)
                };
                let rotation = (iteration as f32 / (iteration_count - 1) as f32) as f64 * std::f64::consts::PI / 2.0;
                let rotation = rotation as f32;
                let side_h = Vec2::new(quad_side * rotation.cos(), quad_side * rotation.sin());
                let side_v = Vec2::new(side_h.y(), -side_h.x());
                let quad = [
                    center + side_h + side_v,
                    center + side_h - side_v,
                    center - side_h - side_v,
                    center - side_h + side_v,
                ];

                [0, 1, 2, 2, 0, 3]
                    .into_iter()
                    .map(|quad_index| Vec4::new(quad[quad_index].x(), quad[quad_index].y(), 0.0, 1.0))
                    .collect()
            }
        }
    }
}

// ---------------------------------------------------------------------------------
// Culling
// ---------------------------------------------------------------------------------

/// `CullingTestInstance::triangleOrder`
fn triangle_order(v0: Vec4, v1: Vec4, v2: Vec4) -> bool {
    let s0 = Vec2::new(v0.x() / v0.w(), v0.y() / v0.w());
    let s1 = Vec2::new(v1.x() / v1.w(), v1.y() / v1.w());
    let s2 = Vec2::new(v2.x() / v2.w(), v2.y() / v2.w());

    // cross
    ((s1.x() - s0.x()) * (s2.y() - s0.y()) - (s2.x() - s0.x()) * (s1.y() - s0.y())) > 0.0
}

#[derive(Clone, Copy)]
struct CullingParams {
    cull_mode: vk::CullModeFlags,
    primitive_topology: vk::PrimitiveTopology,
    front_face: vk::FrontFace,
    polygon_mode: vk::PolygonMode,
}

impl CullingParams {
    /// `CullingTestInstance::generateVertices`
    fn generate_vertices() -> Vec<Vec4> {
        let mut rnd = Random::new(543210);
        (0..6)
            .map(|_| {
                let x = rnd.get_float_range(-0.9, 0.9);
                let y = rnd.get_float_range(-0.9, 0.9);
                Vec4::new(x, y, 0.0, 1.0)
            })
            .collect()
    }

    /// `CullingTestInstance::extractTriangles` - the triangles that survive culling.
    fn extract_triangles(&self, vertices: &[Vec4]) -> Vec<SceneTriangle> {
        let cull_direction =
            (self.cull_mode == vk::CullModeFlags::FRONT) ^ (self.front_face == vk::FrontFace::COUNTER_CLOCKWISE);

        // No triangles
        if self.cull_mode == vk::CullModeFlags::FRONT_AND_BACK {
            return Vec::new();
        }

        let mut out_triangles = Vec::new();
        match self.primitive_topology {
            vk::PrimitiveTopology::TRIANGLE_LIST => {
                for vtx_ndx in (0..vertices.len().saturating_sub(2)).step_by(3) {
                    let (v0, v1, v2) = (vertices[vtx_ndx], vertices[vtx_ndx + 1], vertices[vtx_ndx + 2]);
                    if triangle_order(v0, v1, v2) != cull_direction {
                        out_triangles.push(SceneTriangle::new(v0, v1, v2));
                    }
                }
            }
            vk::PrimitiveTopology::TRIANGLE_STRIP => {
                for vtx_ndx in 0..vertices.len().saturating_sub(2) {
                    let (v0, v1, v2) = (vertices[vtx_ndx], vertices[vtx_ndx + 1], vertices[vtx_ndx + 2]);
                    if triangle_order(v0, v1, v2) != (cull_direction ^ (vtx_ndx % 2 != 0)) {
                        out_triangles.push(SceneTriangle::new(v0, v1, v2));
                    }
                }
            }
            vk::PrimitiveTopology::TRIANGLE_FAN => {
                for vtx_ndx in 1..vertices.len().saturating_sub(1) {
                    let (v0, v1, v2) = (vertices[0], vertices[vtx_ndx], vertices[vtx_ndx + 1]);
                    if triangle_order(v0, v1, v2) != cull_direction {
                        out_triangles.push(SceneTriangle::new(v0, v1, v2));
                    }
                }
            }
            _ => unreachable!("culling cases use triangle topologies only"),
        }
        out_triangles
    }
}

// ---------------------------------------------------------------------------------
// Interpolation
// ---------------------------------------------------------------------------------

/// `PrimitiveStrictness`
#[derive(Clone, Copy, PartialEq, Eq)]
enum PrimitiveStrictness {
    Strict,
    NonStrict,
    Ignore,
}

/// `TriangleInterpolationTestCase`'s topology and `InterpolationCaseFlags`.
#[derive(Clone, Copy)]
struct TriangleInterpolationParams {
    topology: vk::PrimitiveTopology,
    projective: bool,
    flatshade: bool,
}

/// `LineInterpolationTestCase`'s topology, `InterpolationCaseFlags`, wideness and strictness.
#[derive(Clone, Copy)]
struct LineInterpolationParams {
    topology: vk::PrimitiveTopology,
    projective: bool,
    flatshade: bool,
    wide: bool,
    strictness: PrimitiveStrictness,
}

/// `TriangleInterpolationTestInstance::generateVertices` and `LineInterpolationTestInstance::generateVertices`
fn generate_interpolation_vertices(
    iteration: usize,
    topology: vk::PrimitiveTopology,
    projective: bool,
) -> (Vec<Vec4>, Vec<Vec4>) {
    // use only red, green and blue
    let colors = [
        Vec4::new(1.0, 0.0, 0.0, 1.0),
        Vec4::new(0.0, 1.0, 0.0, 1.0),
        Vec4::new(0.0, 0.0, 1.0, 1.0),
    ];
    let mut rnd = Random::new((123 + iteration as i32 * 1000 + topology.as_raw()) as u32);
    let mut out_vertices = Vec::with_capacity(6);
    let mut out_colors = Vec::with_capacity(6);

    for vtx_ndx in 0..6 {
        let x = rnd.get_float_range(-0.9, 0.9);
        let y = rnd.get_float_range(-0.9, 0.9);
        let vertex = if !projective {
            Vec4::new(x, y, 0.0, 1.0)
        } else {
            let w = rnd.get_float_range(0.2, 4.0);
            Vec4::new(x * w, y * w, 0.0, w)
        };
        out_vertices.push(vertex);
        out_colors.push(colors[vtx_ndx % colors.len()]);
    }
    (out_vertices, out_colors)
}

/// `TriangleInterpolationTestInstance::extractTriangles`
fn extract_interpolation_triangles(
    topology: vk::PrimitiveTopology,
    flatshade: bool,
    vertices: &[Vec4],
    colors: &[Vec4],
) -> Vec<SceneTriangle> {
    let mut out_triangles = Vec::new();
    let triangle = |p: [Vec4; 3], c: [Vec4; 3]| SceneTriangle::with_colors(p[0], p[1], p[2], c[0], c[1], c[2]);

    match topology {
        vk::PrimitiveTopology::TRIANGLE_LIST => {
            for vtx_ndx in (0..vertices.len().saturating_sub(2)).step_by(3) {
                let positions = [vertices[vtx_ndx], vertices[vtx_ndx + 1], vertices[vtx_ndx + 2]];
                let tri_colors = if flatshade {
                    [colors[vtx_ndx]; 3]
                } else {
                    [colors[vtx_ndx], colors[vtx_ndx + 1], colors[vtx_ndx + 2]]
                };
                out_triangles.push(triangle(positions, tri_colors));
            }
        }
        vk::PrimitiveTopology::TRIANGLE_STRIP => {
            for vtx_ndx in 0..vertices.len().saturating_sub(2) {
                let positions = [vertices[vtx_ndx], vertices[vtx_ndx + 1], vertices[vtx_ndx + 2]];
                let tri_colors = if flatshade {
                    [colors[vtx_ndx]; 3]
                } else {
                    [colors[vtx_ndx], colors[vtx_ndx + 1], colors[vtx_ndx + 2]]
                };
                out_triangles.push(triangle(positions, tri_colors));
            }
        }
        vk::PrimitiveTopology::TRIANGLE_FAN => {
            for vtx_ndx in 1..vertices.len().saturating_sub(1) {
                let positions = [vertices[0], vertices[vtx_ndx], vertices[vtx_ndx + 1]];
                let tri_colors = if flatshade {
                    [colors[vtx_ndx]; 3]
                } else {
                    [colors[0], colors[vtx_ndx], colors[vtx_ndx + 1]]
                };
                out_triangles.push(triangle(positions, tri_colors));
            }
        }
        _ => unreachable!("triangle interpolation cases use triangle topologies only"),
    }
    out_triangles
}

/// `LineInterpolationTestInstance::extractLines`
fn extract_interpolation_lines(
    topology: vk::PrimitiveTopology,
    flatshade: bool,
    vertices: &[Vec4],
    colors: &[Vec4],
) -> Vec<SceneLine> {
    let line = |vtx_ndx: usize| {
        let (c0, c1) = if flatshade {
            (colors[vtx_ndx], colors[vtx_ndx])
        } else {
            (colors[vtx_ndx], colors[vtx_ndx + 1])
        };
        SceneLine::with_colors(vertices[vtx_ndx], vertices[vtx_ndx + 1], c0, c1)
    };

    match topology {
        vk::PrimitiveTopology::LINE_LIST => (0..vertices.len().saturating_sub(1)).step_by(2).map(line).collect(),
        vk::PrimitiveTopology::LINE_STRIP => (0..vertices.len().saturating_sub(1)).map(line).collect(),
        _ => unreachable!("line interpolation cases use line topologies only"),
    }
}

impl RenderingInstance<'_> {
    /// `TriangleInterpolationTestInstance::iterate` over its three iterations.
    fn run_triangle_interpolation(&self, params: TriangleInterpolationParams) -> TestOutcome {
        let harness = RenderingHarness::new(self.context, self.sample_count, RESOLUTION_POT)?;
        let mut all_iterations_passed = true;

        for iteration in 0..3 {
            // generate scene
            let (draw_buffer, color_buffer) =
                generate_interpolation_vertices(iteration, params.topology, params.projective);
            let triangles =
                extract_interpolation_triangles(params.topology, params.flatshade, &draw_buffer, &color_buffer);

            // draw image
            let result_image =
                harness.draw_primitives(&draw_buffer, &color_buffer, params.topology, &DrawState::default())?;

            // compare
            let args = harness.rasterization_args(harness.multisampling);
            let verify = verify_triangle_group_interpolation(&result_image, &TriangleSceneSpec { triangles }, &args);
            if !verify.ok {
                log::warn!(
                    "Iteration {iteration}: {} invalid pixel(s) found",
                    verify.invalid_pixels
                );
                all_iterations_passed = false;
            }
        }

        Ok(if all_iterations_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Found invalid pixel values")
        })
    }

    /// `LineInterpolationTestInstance::iterate` over its three iterations.
    fn run_line_interpolation(&self, params: LineInterpolationParams) -> TestOutcome {
        let harness = RenderingHarness::new(self.context, self.sample_count, RESOLUTION_POT)?;
        let iteration_count = 3;
        let (line_widths, max_line_width) = if params.wide {
            let range = self.context.get_device_properties().limits.line_width_range;
            log::info!("ALIASED_LINE_WIDTH_RANGE = [{}, {}]", range[0], range[1]);
            // set hand picked sizes
            (vec![5.0f32, 10.0, range[1]], range[1])
        } else {
            (vec![1.0f32; iteration_count], 1.0f32)
        };
        let mut all_iterations_passed = true;

        for (iteration, &line_width) in line_widths.iter().enumerate() {
            // supported?
            if line_width > max_line_width {
                log::info!("Line width {line_width} not supported, skipping iteration.");
                continue;
            }

            // generate scene
            let (draw_buffer, color_buffer) =
                generate_interpolation_vertices(iteration, params.topology, params.projective);
            let lines = extract_interpolation_lines(params.topology, params.flatshade, &draw_buffer, &color_buffer);

            // draw image
            let state = DrawState {
                line_width,
                ..DrawState::default()
            };
            let result_image = harness.draw_primitives(&draw_buffer, &color_buffer, params.topology, &state)?;

            // compare
            let args = harness.rasterization_args(harness.multisampling);
            let scene = LineSceneSpec {
                lines,
                line_width,
                ..Default::default()
            };
            let ok = match params.strictness {
                PrimitiveStrictness::Strict => {
                    verify_triangulated_line_group_interpolation(&result_image, &scene, &args, true, false)
                }
                PrimitiveStrictness::NonStrict | PrimitiveStrictness::Ignore => {
                    verify_triangulated_line_group_interpolation(&result_image, &scene, &args, false, true)
                }
            };
            if !ok {
                all_iterations_passed = false;
            }
        }

        Ok(if all_iterations_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Incorrect rasterization")
        })
    }
}

impl RenderingInstance<'_> {
    /// `DiscardTestInstance::iterate`: with rasterizer discard enabled nothing may reach the framebuffer.
    fn run_discard(&self, topology: vk::PrimitiveTopology, query_fragment_shader_invocations: bool) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let harness = RenderingHarness::new(context, vk::SampleCountFlags::_1, RESOLUTION_POT)?;

        // generateVertices
        let mut rnd = Random::new(12345);
        let draw_buffer: Vec<Vec4> = (0..6)
            .map(|_| {
                let x = rnd.get_float_range(-0.9, 0.9);
                let y = rnd.get_float_range(-0.9, 0.9);
                Vec4::new(x, y, 0.0, 1.0)
            })
            .collect();

        let mut state = DrawState {
            rasterizer_discard: true,
            ..DrawState::default()
        };
        let mut query_result = 0u64;
        let result_image = if query_fragment_shader_invocations {
            let query_pool_create_info = vk::QueryPoolCreateInfo::builder()
                .query_type(vk::QueryType::PIPELINE_STATISTICS)
                .query_count(1)
                .pipeline_statistics(vk::QueryPipelineStatisticFlags::FRAGMENT_SHADER_INVOCATIONS);
            let query_pool = Unique::new(
                device,
                unsafe { device.create_query_pool(&query_pool_create_info, None) }.vk_check("vkCreateQueryPool")?,
            );
            state.query_pool = Some(*query_pool);
            let image = harness.draw_white(&draw_buffer, topology, &state)?;
            let mut bytes = [0u8; 8];
            unsafe {
                device
                    .get_query_pool_results(
                        *query_pool,
                        0,
                        1,
                        &mut bytes,
                        std::mem::size_of::<u64>() as u64,
                        vk::QueryResultFlags::_64 | vk::QueryResultFlags::WAIT,
                    )
                    .vk_check("vkGetQueryPoolResults")?;
            }
            query_result = u64::from_ne_bytes(bytes);
            image
        } else {
            harness.draw_white(&draw_buffer, topology, &state)?
        };

        // Empty scene to compare to, primitives should be discarded before rasterization
        let args = harness.rasterization_args(false);
        let verify = verify_triangle_group_rasterization(
            &result_image,
            &TriangleSceneSpec::default(),
            &args,
            VerificationMode::Strict,
        );
        Ok(if verify.ok {
            if query_fragment_shader_invocations && query_result > 0 {
                TestStatus::fail("Fragment shader invocations occured")
            } else {
                TestStatus::pass("Pass")
            }
        } else {
            TestStatus::fail("Incorrect rendering")
        })
    }
}

// ---------------------------------------------------------------------------------
// The cases
// ---------------------------------------------------------------------------------

#[derive(Clone, Copy)]
enum RenderingKind {
    Triangles,
    TriangleStrip,
    TriangleFan,
    // Whether this is the wide variant: the only one registered, upstream's `points` case.
    Points,
    PointSize {
        render_size: u32,
        point_size: f32,
    },
    PointDefaultSize {
        render_size: u32,
        stages: PointStages,
    },
    FillRule(FillRuleCaseType),
    Culling(CullingParams),
    TriangleInterpolation(TriangleInterpolationParams),
    LineInterpolation(LineInterpolationParams),
    Discard {
        topology: vk::PrimitiveTopology,
        query_fragment_shader_invocations: bool,
    },
}

struct RenderingTestCase {
    name: String,
    kind: RenderingKind,
    sample_count: vk::SampleCountFlags,
}

impl TestCase for RenderingTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.kind {
            RenderingKind::Points => {
                // WidenessTestCase with PRIMITIVEWIDENESS_WIDE for a point test
                if context.get_device_features().large_points == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Core feature largePoints not supported".to_string(),
                    ));
                }
            }
            RenderingKind::PointSize { render_size, .. } => {
                check_point_size_support(context, render_size)?;
                if context.get_device_features().large_points == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Core feature largePoints not supported".to_string(),
                    ));
                }
                return check_render_target_support(context, vk::Format::R8_UNORM, vk::SampleCountFlags::_1);
            }
            RenderingKind::PointDefaultSize { render_size, stages } => {
                check_point_size_support(context, render_size)?;
                let features = context.get_device_features();
                if stages.tessellation {
                    if features.shader_tessellation_and_geometry_point_size == vk::FALSE {
                        return Err(TestError::NotSupported(
                            "Core feature shaderTessellationAndGeometryPointSize not supported".to_string(),
                        ));
                    }
                    if features.tessellation_shader == vk::FALSE {
                        return Err(TestError::NotSupported(
                            "Core feature tessellationShader not supported".to_string(),
                        ));
                    }
                }
                if stages.geometry {
                    if features.shader_tessellation_and_geometry_point_size == vk::FALSE {
                        return Err(TestError::NotSupported(
                            "Core feature shaderTessellationAndGeometryPointSize not supported".to_string(),
                        ));
                    }
                    if features.geometry_shader == vk::FALSE {
                        return Err(TestError::NotSupported(
                            "Core feature geometryShader not supported".to_string(),
                        ));
                    }
                }
                context.require_device_functionality("VK_KHR_maintenance5")?;
                return check_render_target_support(context, vk::Format::R8_UNORM, vk::SampleCountFlags::_1);
            }
            RenderingKind::Discard {
                query_fragment_shader_invocations: true,
                ..
            } => {
                if context.get_device_features().pipeline_statistics_query == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Core feature pipelineStatisticsQuery not supported".to_string(),
                    ));
                }
            }
            RenderingKind::LineInterpolation(params) => {
                if params.strictness == PrimitiveStrictness::Strict
                    && context.get_device_properties().limits.strict_lines == vk::FALSE
                {
                    return Err(TestError::NotSupported(
                        "Strict rasterization is not supported".to_string(),
                    ));
                }
                if params.wide && context.get_device_features().wide_lines == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Core feature wideLines not supported".to_string(),
                    ));
                }
            }
            RenderingKind::Culling(params)
                if context.get_device_features().fill_mode_non_solid == vk::FALSE
                    && matches!(params.polygon_mode, vk::PolygonMode::LINE | vk::PolygonMode::POINT) =>
            {
                return Err(TestError::NotSupported(
                    "Wireframe fill modes are not supported".to_string(),
                ));
            }
            _ => {}
        }
        check_render_target_support(context, IMAGE_FORMAT, self.sample_count)
    }

    fn programs(&self) -> BinaryCollection {
        match self.kind {
            RenderingKind::PointDefaultSize { .. } => POINT_DEFAULT_SIZE.programs,
            RenderingKind::TriangleInterpolation(TriangleInterpolationParams { flatshade: true, .. })
            | RenderingKind::LineInterpolation(LineInterpolationParams { flatshade: true, .. }) => {
                RENDERING_FLAT.programs
            }
            _ => RENDERING_BASE.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(RenderingInstance {
            context,
            kind: self.kind,
            sample_count: self.sample_count,
        })
    }
}

struct RenderingInstance<'a> {
    context: &'a Context<'a>,
    kind: RenderingKind,
    sample_count: vk::SampleCountFlags,
}

impl RenderingInstance<'_> {
    /// `BaseTriangleTestInstance::iterate` over its three iterations.
    fn run_triangles(
        &self,
        topology: vk::PrimitiveTopology,
        generate: fn(usize) -> (Vec<Vec4>, Vec<SceneTriangle>),
    ) -> TestOutcome {
        let harness = RenderingHarness::new(self.context, self.sample_count, RESOLUTION_POT)?;
        let mut all_iterations_passed = true;

        for iteration in 0..3 {
            let (draw_buffer, triangles) = generate(iteration);
            let result_image = harness.draw_white(&draw_buffer, topology, &DrawState::default())?;

            let args = harness.rasterization_args(harness.multisampling);
            let scene = TriangleSceneSpec { triangles };
            let verify = verify_triangle_group_rasterization(&result_image, &scene, &args, VerificationMode::Strict);
            if !verify.ok {
                log::warn!(
                    "Iteration {iteration}: {} missing and {} unexpected pixels",
                    verify.missing_pixels,
                    verify.unexpected_pixels
                );
                all_iterations_passed = false;
            }
        }

        Ok(if all_iterations_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Incorrect rasterization")
        })
    }

    /// `PointTestInstance::iterate` with the wide point sizes.
    fn run_points(&self) -> TestOutcome {
        let harness = RenderingHarness::new(self.context, self.sample_count, RESOLUTION_POT)?;
        let range = self.context.get_device_properties().limits.point_size_range;
        let max_point_size = range[1];
        let point_sizes = [10.0f32, 25.0, max_point_size];
        let mut all_iterations_passed = true;

        for (iteration, &point_size) in point_sizes.iter().enumerate() {
            // supported?
            if point_size > max_point_size {
                log::info!("Point size {point_size} not supported, skipping iteration.");
                continue;
            }

            let (draw_buffer, points) = generate_points(iteration, point_size);
            let state = DrawState {
                point_size,
                ..DrawState::default()
            };
            let result_image = harness.draw_white(&draw_buffer, vk::PrimitiveTopology::POINT_LIST, &state)?;

            let args = harness.rasterization_args(harness.multisampling);
            let verify = verify_point_group_rasterization(&result_image, &PointSceneSpec { points }, &args);
            if !verify.ok {
                all_iterations_passed = false;
            }
        }

        Ok(if all_iterations_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Incorrect rasterization")
        })
    }

    /// `PointSizeTestInstance::iterate`
    fn run_point_size(&self, render_size: u32, point_size: f32) -> TestOutcome {
        let harness = RenderingHarness::new_with_format(
            self.context,
            vk::SampleCountFlags::_1,
            render_size,
            vk::Format::R8_UNORM,
        )?;
        let max_point_size = self.context.get_device_properties().limits.point_size_range[1];

        let pipeline = harness.create_point_pipeline(None, None, None, 2)?;
        let result = harness.draw_point(
            *pipeline,
            Vec4::new(0.0, 0.0, 0.0, 1.0),
            Vec4::new(1.0, 0.0, 0.0, 0.0),
            point_size,
            true,
        )?;

        // pointSize must either be specified pointSize or clamped to device limit pointSizeRange[1]
        let effective_point_size = point_size.min(max_point_size);
        Ok(if verify_point(result, render_size, effective_point_size) {
            if effective_point_size == max_point_size {
                TestStatus::pass("Pass, pointSize clamped to pointSizeRange[1]")
            } else {
                TestStatus::pass("Pass")
            }
        } else {
            TestStatus::fail("Incorrect rasterization")
        })
    }

    /// `PointDefaultSizeTestInstance::iterate` - the same, with a point size of 1 that no shader writes.
    fn run_point_default_size(&self, render_size: u32, stages: PointStages) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let harness =
            RenderingHarness::new_with_format(context, vk::SampleCountFlags::_1, render_size, vk::Format::R8_UNORM)?;
        let max_point_size = context.get_device_properties().limits.point_size_range[1];
        let binaries = context.get_binary_collection();

        let tessellation_control = if stages.tessellation {
            Some(create_shader_module(
                device,
                binaries.get("tessellation_control_shader")?,
            )?)
        } else {
            None
        };
        let tessellation_evaluation = if stages.tessellation {
            Some(create_shader_module(
                device,
                binaries.get("tessellation_evaluation_shader")?,
            )?)
        } else {
            None
        };
        let geometry = if stages.geometry {
            Some(create_shader_module(device, binaries.get("geometry_shader")?)?)
        } else {
            None
        };

        let pipeline = harness.create_point_pipeline(
            tessellation_control.as_ref().map(|m| **m),
            tessellation_evaluation.as_ref().map(|m| **m),
            geometry.as_ref().map(|m| **m),
            1,
        )?;
        let result = harness.draw_point(
            *pipeline,
            Vec4::new(0.0, 0.0, 0.0, 1.0),
            Vec4::new(1.0, 0.0, 0.0, 0.0),
            1.0,
            false,
        )?;

        let effective_point_size = 1.0f32.min(max_point_size);
        Ok(if verify_point(result, render_size, effective_point_size) {
            if effective_point_size == max_point_size {
                TestStatus::pass("Pass, pointSize clamped to pointSizeRange[1]")
            } else {
                TestStatus::pass("Pass")
            }
        } else {
            TestStatus::fail("Incorrect rasterization")
        })
    }

    /// `FillRuleTestInstance::iterate` over its iterations.
    fn run_fill_rule(&self, case_type: FillRuleCaseType) -> TestOutcome {
        let harness = RenderingHarness::new(self.context, self.sample_count, case_type.render_size())?;
        // 8 bits per channel
        let threshold_red = 1;
        let threshold_green = 1;
        let threshold_blue = 1;
        let mut all_iterations_passed = true;

        for iteration in 0..case_type.iteration_count() {
            let draw_buffer = case_type.generate_triangles(iteration);

            // draw image
            log::info!(
                "Drawing gray triangles with shared edges. Enabling additive blending to detect overlapping fragments."
            );
            let color_buffer = vec![Vec4::new(0.5, 0.5, 0.5, 1.0); draw_buffer.len()];
            let state = DrawState {
                additive_blend: true,
                ..DrawState::default()
            };
            let result_image = harness.draw_primitives(
                &draw_buffer,
                &color_buffer,
                vk::PrimitiveTopology::TRIANGLE_LIST,
                &state,
            )?;

            // verify no overdraw
            let triangle_color = RGBA::new(127, 127, 127, 255);
            let mut overdraw = false;
            for y in 0..result_image.get_height() {
                for x in 0..result_image.get_width() {
                    let color = result_image.get_pixel(x, y);

                    // color values are greater than triangle color? Allow lower values for multisampled edges and background.
                    if (color.get_red() - triangle_color.get_red()) > threshold_red
                        || (color.get_green() - triangle_color.get_green()) > threshold_green
                        || (color.get_blue() - triangle_color.get_blue()) > threshold_blue
                    {
                        overdraw = true;
                    }
                }
            }
            if overdraw {
                log::warn!("Overlapping fragments detected, image is not valid.");
                all_iterations_passed = false;
            }

            // verify no missing fragments in the full viewport case
            if case_type == FillRuleCaseType::ClippedFull {
                let mut missing_fragments = false;
                for y in 0..result_image.get_height() {
                    for x in 0..result_image.get_width() {
                        let color = result_image.get_pixel(x, y);

                        // black? (background)
                        if color.get_red() <= threshold_red
                            || color.get_green() <= threshold_green
                            || color.get_blue() <= threshold_blue
                        {
                            missing_fragments = true;
                        }
                    }
                }
                if missing_fragments {
                    log::warn!("Missing fragments detected, image is not valid.");
                    all_iterations_passed = false;
                }
            }
        }

        Ok(if all_iterations_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Found invalid pixels")
        })
    }

    /// `CullingTestInstance::iterate`
    fn run_culling(&self, params: CullingParams) -> TestOutcome {
        let harness = RenderingHarness::new(self.context, vk::SampleCountFlags::_1, RESOLUTION_POT)?;

        // generate scene
        let draw_buffer = CullingParams::generate_vertices();
        let triangles = params.extract_triangles(&draw_buffer);

        // draw image
        let state = DrawState {
            cull_mode: params.cull_mode,
            front_face: params.front_face,
            polygon_mode: params.polygon_mode,
            line_width: 1.0,
            ..DrawState::default()
        };
        let result_image = harness.draw_white(&draw_buffer, params.primitive_topology, &state)?;

        // compare. The culling instance's own `m_multisampling` is true, which shadows the base class's.
        let args = harness.rasterization_args(true);
        let is_compare_ok = match params.polygon_mode {
            vk::PolygonMode::LINE => {
                let mut lines = Vec::new();
                for triangle in &triangles {
                    for vertex_ndx in 0..2 {
                        lines.push(SceneLine::new(
                            triangle.positions[vertex_ndx],
                            triangle.positions[vertex_ndx + 1],
                        ));
                    }
                    lines.push(SceneLine::new(triangle.positions[2], triangle.positions[0]));
                }
                verify_line_group_rasterization(
                    &result_image,
                    &LineSceneSpec {
                        lines,
                        line_width: 0.0,
                        ..Default::default()
                    },
                    &args,
                )
                .ok
            }
            vk::PolygonMode::POINT => {
                let points = triangles
                    .iter()
                    .flat_map(|triangle| {
                        triangle.positions.iter().map(|&position| ScenePoint {
                            position,
                            point_size: 1.0,
                        })
                    })
                    .collect();
                verify_point_group_rasterization(&result_image, &PointSceneSpec { points }, &args).ok
            }
            _ => {
                verify_triangle_group_rasterization(
                    &result_image,
                    &TriangleSceneSpec { triangles },
                    &args,
                    VerificationMode::Weak,
                )
                .ok
            }
        };

        Ok(if is_compare_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Incorrect rendering")
        })
    }
}

impl TestInstance for RenderingInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.kind {
            RenderingKind::Triangles => {
                self.run_triangles(vk::PrimitiveTopology::TRIANGLE_LIST, generate_triangles_list)
            }
            RenderingKind::TriangleStrip => {
                self.run_triangles(vk::PrimitiveTopology::TRIANGLE_STRIP, generate_triangles_strip)
            }
            RenderingKind::TriangleFan => {
                self.run_triangles(vk::PrimitiveTopology::TRIANGLE_FAN, generate_triangles_fan)
            }
            RenderingKind::Points => self.run_points(),
            RenderingKind::PointSize {
                render_size,
                point_size,
            } => self.run_point_size(render_size, point_size),
            RenderingKind::PointDefaultSize { render_size, stages } => self.run_point_default_size(render_size, stages),
            RenderingKind::FillRule(case_type) => self.run_fill_rule(case_type),
            RenderingKind::Culling(params) => self.run_culling(params),
            RenderingKind::TriangleInterpolation(params) => self.run_triangle_interpolation(params),
            RenderingKind::LineInterpolation(params) => self.run_line_interpolation(params),
            RenderingKind::Discard {
                topology,
                query_fragment_shader_invocations,
            } => self.run_discard(topology, query_fragment_shader_invocations),
        }
    }
}

/// `PointDefaultSizeNoLargePointsTestCase`: `PointDefaultSizeTestCase` on a second context whose device has largePoints off.
struct NoLargePointsCase {
    name: String,
    inner: RenderingTestCase,
}

struct NoLargePointsInstance<'a> {
    context: &'a Context<'a>,
    inner: &'a RenderingTestCase,
}

impl TestInstance for NoLargePointsInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let no_large_points_context = Context::new_with_robustness(
            context.get_platform(),
            context.get_physical_device(),
            context.get_binary_collection(),
            RobustnessFeatures {
                no_large_points: true,
                ..Default::default()
            },
        )?;
        self.inner.create_instance(&no_large_points_context).iterate()
    }
}

impl TestCase for NoLargePointsCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        self.inner.check_support(context)
    }

    fn programs(&self) -> BinaryCollection {
        self.inner.programs()
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NoLargePointsInstance {
            context,
            inner: &self.inner,
        })
    }
}

/// `PointDefaultSizeNoLargePointsTestCase` named `<stage>_no_large_points`
fn create_no_large_points_case(stage_name: &str, tessellation: bool, geometry: bool) -> Box<dyn TestCase> {
    Box::new(NoLargePointsCase {
        name: format!("{stage_name}_no_large_points"),
        inner: RenderingTestCase {
            name: format!("{stage_name}_no_large_points"),
            kind: RenderingKind::PointDefaultSize {
                render_size: 3,
                stages: PointStages { tessellation, geometry },
            },
            sample_count: vk::SampleCountFlags::_1,
        },
    })
}

/// The `primitives`, `fill_rules` and `culling` groups of `createRasterizationTests`, added to the `rasterization` group.
pub fn add_rendering_tests(rasterization_tests: &mut TestCaseGroup) {
    let case = |name: &str, kind: RenderingKind| {
        Box::new(RenderingTestCase {
            name: name.to_string(),
            kind,
            sample_count: vk::SampleCountFlags::_1,
        }) as Box<dyn TestCase>
    };

    // .primitives
    {
        let mut primitives = TestCaseGroup::new("primitives");
        let mut nostipple_tests = TestCaseGroup::new("no_stipple");

        // Render primitives as VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST, verify rasterization result
        nostipple_tests.add_child(case("triangles", RenderingKind::Triangles));
        // Render primitives as VK_PRIMITIVE_TOPOLOGY_TRIANGLE_STRIP, verify rasterization result
        nostipple_tests.add_child(case("triangle_strip", RenderingKind::TriangleStrip));
        // Render primitives as VK_PRIMITIVE_TOPOLOGY_TRIANGLE_FAN, verify rasterization result
        nostipple_tests.add_child(case("triangle_fan", RenderingKind::TriangleFan));
        // Render primitives as VK_PRIMITIVE_TOPOLOGY_POINT_LIST, verify rasterization result
        nostipple_tests.add_child(case("points", RenderingKind::Points));

        super::line_tests::add_primitives_line_tests(&mut primitives, nostipple_tests);
        primitives.add_child(simple_tests::create_stride_zero_tests());
        rasterization_tests.add_child(primitives);
    }

    // .primitive_size
    {
        let mut primitive_size = TestCaseGroup::new("primitive_size");

        // .points
        {
            let mut points = TestCaseGroup::new("points");
            let test_combinations: [(u32, f32); 8] = [
                (1024, 128.0),
                (1024, 256.0),
                (1024, 512.0),
                (2048, 1024.0),
                (4096, 2048.0),
                (8192, 4096.0),
                (9216, 8192.0),
                (10240, 10000.0),
            ];

            for (render_size, point_size) in test_combinations {
                points.add_child(case(
                    &format!("point_size_{point_size}"),
                    RenderingKind::PointSize {
                        render_size,
                        point_size,
                    },
                ));
            }
            primitive_size.add_child(points);
        }

        // .default_size
        {
            let mut default_size = TestCaseGroup::new("default_size");

            // .points: the default point size, whichever stage supplies the point. The `_no_large_points` variants run on a device
            // created with largePoints disabled (`PointDefaultSizeNoLargePointsTestCase`).
            let mut points = TestCaseGroup::new("points");
            let combinations = [
                ("vertex", false, false),
                ("tessellation", true, false),
                ("geometry", false, true),
                ("all", true, true),
            ];
            for (name, tessellation, geometry) in combinations {
                // Odd number so only the center pixel is rendered
                points.add_child(case(
                    name,
                    RenderingKind::PointDefaultSize {
                        render_size: 3,
                        stages: PointStages { tessellation, geometry },
                    },
                ));
                points.add_child(create_no_large_points_case(name, tessellation, geometry));
            }
            default_size.add_child(points);
            default_size.add_child(super::polygon_large_points_tests::create_polygon_as_points_tests());
            primitive_size.add_child(default_size);
        }

        rasterization_tests.add_child(primitive_size);
    }

    // .fill_rules
    {
        let mut fill_rules = TestCaseGroup::new("fill_rules");
        fill_rules.add_child(case("basic_quad", RenderingKind::FillRule(FillRuleCaseType::Basic)));
        fill_rules.add_child(case(
            "basic_quad_reverse",
            RenderingKind::FillRule(FillRuleCaseType::Reversed),
        ));
        fill_rules.add_child(case(
            "clipped_full",
            RenderingKind::FillRule(FillRuleCaseType::ClippedFull),
        ));
        fill_rules.add_child(case(
            "clipped_partly",
            RenderingKind::FillRule(FillRuleCaseType::ClippedPartial),
        ));
        fill_rules.add_child(case("projected", RenderingKind::FillRule(FillRuleCaseType::Projected)));
        rasterization_tests.add_child(fill_rules);
    }

    // .culling
    {
        let cull_modes = [
            (vk::CullModeFlags::FRONT, "front_"),
            (vk::CullModeFlags::BACK, "back_"),
            (vk::CullModeFlags::FRONT_AND_BACK, "both_"),
        ];
        let primitive_types = [
            (vk::PrimitiveTopology::TRIANGLE_LIST, "triangles"),
            (vk::PrimitiveTopology::TRIANGLE_STRIP, "triangle_strip"),
            (vk::PrimitiveTopology::TRIANGLE_FAN, "triangle_fan"),
        ];
        let front_orders = [
            (vk::FrontFace::COUNTER_CLOCKWISE, ""),
            (vk::FrontFace::CLOCKWISE, "_reverse"),
        ];
        let polygon_modes = [
            (vk::PolygonMode::FILL, ""),
            (vk::PolygonMode::LINE, "_line"),
            (vk::PolygonMode::POINT, "_point"),
        ];

        let mut culling = TestCaseGroup::new("culling");

        for (cull_mode, cull_prefix) in cull_modes {
            for (primitive_topology, primitive_name) in primitive_types {
                for (front_face, front_postfix) in front_orders {
                    for (polygon_mode, polygon_name) in polygon_modes {
                        if !(cull_mode == vk::CullModeFlags::FRONT_AND_BACK && polygon_mode != vk::PolygonMode::FILL) {
                            let name = format!("{cull_prefix}{primitive_name}{front_postfix}{polygon_name}");
                            // Test primitive culling.
                            culling.add_child(case(
                                &name,
                                RenderingKind::Culling(CullingParams {
                                    cull_mode,
                                    primitive_topology,
                                    front_face,
                                    polygon_mode,
                                }),
                            ));
                        }
                    }
                }
            }
        }

        culling.add_child(simple_tests::create_cull_and_primitive_id_test());
        rasterization_tests.add_child(culling);
    }

    add_discard_tests(rasterization_tests);
    add_interpolation_tests(rasterization_tests);
    add_multisample_tests(rasterization_tests);
}

/// The triangle and line cases of one `interpolation` / `flatshading` group, named as upstream names them.
fn add_interpolation_cases(group: &mut TestCaseGroup, projective: bool, flatshade: bool) {
    let triangle_topologies = [
        ("triangles", vk::PrimitiveTopology::TRIANGLE_LIST),
        ("triangle_strip", vk::PrimitiveTopology::TRIANGLE_STRIP),
        ("triangle_fan", vk::PrimitiveTopology::TRIANGLE_FAN),
    ];
    for (name, topology) in triangle_topologies {
        group.add_child(Box::new(RenderingTestCase {
            name: name.to_string(),
            kind: RenderingKind::TriangleInterpolation(TriangleInterpolationParams {
                topology,
                projective,
                flatshade,
            }),
            sample_count: vk::SampleCountFlags::_1,
        }) as Box<dyn TestCase>);
    }

    let strictnesses = [
        ("", PrimitiveStrictness::Ignore),
        ("strict_", PrimitiveStrictness::Strict),
        ("non_strict_", PrimitiveStrictness::NonStrict),
    ];
    for (prefix, strictness) in strictnesses {
        let line_cases = [
            ("lines", vk::PrimitiveTopology::LINE_LIST, false),
            ("line_strip", vk::PrimitiveTopology::LINE_STRIP, false),
            ("lines_wide", vk::PrimitiveTopology::LINE_LIST, true),
            ("line_strip_wide", vk::PrimitiveTopology::LINE_STRIP, true),
        ];
        for (name, topology, wide) in line_cases {
            group.add_child(Box::new(RenderingTestCase {
                name: format!("{prefix}{name}"),
                kind: RenderingKind::LineInterpolation(LineInterpolationParams {
                    topology,
                    projective,
                    flatshade,
                    wide,
                    strictness,
                }),
                sample_count: vk::SampleCountFlags::_1,
            }) as Box<dyn TestCase>);
        }
    }
}

/// `.discard`
fn add_discard_tests(rasterization_tests: &mut TestCaseGroup) {
    let primitive_types = [
        (vk::PrimitiveTopology::TRIANGLE_LIST, "triangle_list"),
        (vk::PrimitiveTopology::TRIANGLE_STRIP, "triangle_strip"),
        (vk::PrimitiveTopology::TRIANGLE_FAN, "triangle_fan"),
        (vk::PrimitiveTopology::LINE_LIST, "line_list"),
        (vk::PrimitiveTopology::LINE_STRIP, "line_strip"),
        (vk::PrimitiveTopology::POINT_LIST, "point_list"),
    ];
    let query_pipeline = [(false, "query_pipeline_false"), (true, "query_pipeline_true")];

    let mut discard = TestCaseGroup::new("discard");
    for (topology, primitive_name) in primitive_types {
        let mut primitive = TestCaseGroup::new(primitive_name);
        for (query_fragment_shader_invocations, name) in query_pipeline {
            // Test primitive discarding.
            primitive.add_child(Box::new(RenderingTestCase {
                name: name.to_string(),
                kind: RenderingKind::Discard {
                    topology,
                    query_fragment_shader_invocations,
                },
                sample_count: vk::SampleCountFlags::_1,
            }) as Box<dyn TestCase>);
        }
        discard.add_child(primitive);
    }
    rasterization_tests.add_child(discard);
}

/// `.interpolation` (`basic`, `projected`) and `.flatshading`
fn add_interpolation_tests(rasterization_tests: &mut TestCaseGroup) {
    let mut interpolation = TestCaseGroup::new("interpolation");

    let mut basic = TestCaseGroup::new("basic");
    add_interpolation_cases(&mut basic, false, false);
    interpolation.add_child(basic);

    let mut projected = TestCaseGroup::new("projected");
    add_interpolation_cases(&mut projected, true, false);
    interpolation.add_child(projected);

    rasterization_tests.add_child(interpolation);

    let mut flatshading = TestCaseGroup::new("flatshading");
    add_interpolation_cases(&mut flatshading, false, true);
    rasterization_tests.add_child(flatshading);
}

/// `primitives_multisample_<n>_bit` (the triangle and point cases), `fill_rules_multisample_<n>_bit` and
/// `interpolation_multisample_<n>_bit`. The line and stipple cases of `primitives` are not ported.
fn add_multisample_tests(rasterization_tests: &mut TestCaseGroup) {
    let samples = [
        (2, vk::SampleCountFlags::_2),
        (4, vk::SampleCountFlags::_4),
        (8, vk::SampleCountFlags::_8),
        (16, vk::SampleCountFlags::_16),
        (32, vk::SampleCountFlags::_32),
        (64, vk::SampleCountFlags::_64),
    ];

    for (count, sample_count) in samples {
        let case = |name: &str, kind: RenderingKind| {
            Box::new(RenderingTestCase {
                name: name.to_string(),
                kind,
                sample_count,
            }) as Box<dyn TestCase>
        };
        let case_name = format!("_multisample_{count}_bit");

        // .primitives
        {
            let mut primitives = TestCaseGroup::new(&format!("primitives{case_name}"));
            let mut nostipple_tests = TestCaseGroup::new("no_stipple");
            // Render primitives as VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST, verify rasterization result
            nostipple_tests.add_child(case("triangles", RenderingKind::Triangles));
            // Render primitives as VK_PRIMITIVE_TOPOLOGY_POINT_LIST, verify rasterization result
            nostipple_tests.add_child(case("points", RenderingKind::Points));
            super::line_tests::add_multisample_primitives_line_tests(&mut primitives, nostipple_tests, sample_count);
            rasterization_tests.add_child(primitives);
        }

        // .fill_rules
        {
            let mut fill_rules = TestCaseGroup::new(&format!("fill_rules{case_name}"));
            fill_rules.add_child(case("basic_quad", RenderingKind::FillRule(FillRuleCaseType::Basic)));
            fill_rules.add_child(case(
                "basic_quad_reverse",
                RenderingKind::FillRule(FillRuleCaseType::Reversed),
            ));
            fill_rules.add_child(case(
                "clipped_full",
                RenderingKind::FillRule(FillRuleCaseType::ClippedFull),
            ));
            fill_rules.add_child(case(
                "clipped_partly",
                RenderingKind::FillRule(FillRuleCaseType::ClippedPartial),
            ));
            fill_rules.add_child(case("projected", RenderingKind::FillRule(FillRuleCaseType::Projected)));
            rasterization_tests.add_child(fill_rules);
        }

        // .interpolation
        {
            let mut interpolation = TestCaseGroup::new(&format!("interpolation{case_name}"));
            interpolation.add_child(case(
                "triangles",
                RenderingKind::TriangleInterpolation(TriangleInterpolationParams {
                    topology: vk::PrimitiveTopology::TRIANGLE_LIST,
                    projective: false,
                    flatshade: false,
                }),
            ));
            let line_cases = [
                ("lines", false, PrimitiveStrictness::Ignore),
                ("lines_wide", true, PrimitiveStrictness::Ignore),
                ("strict_lines", false, PrimitiveStrictness::Strict),
                ("strict_lines_wide", true, PrimitiveStrictness::Strict),
                ("non_strict_lines", false, PrimitiveStrictness::NonStrict),
                ("non_strict_lines_wide", true, PrimitiveStrictness::NonStrict),
            ];
            for (name, wide, strictness) in line_cases {
                interpolation.add_child(case(
                    name,
                    RenderingKind::LineInterpolation(LineInterpolationParams {
                        topology: vk::PrimitiveTopology::LINE_LIST,
                        projective: false,
                        flatshade: false,
                        wide,
                        strictness,
                    }),
                ));
            }
            rasterization_tests.add_child(interpolation);
        }
    }
}
