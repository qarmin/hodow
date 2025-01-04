// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/util/vktDrawUtil.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `VulkanDrawContext`: sets up a graphics pipeline per registered draw object and enables simple draw calls to a
// predefined colour attachment (and an optional depth attachment) which is then read back. Clip volume uses wc = 1.0, which
// gives clip coord ranges x = [-1, 1], y = [-1, 1], z = [0, 1]; clip coords (-1, -1) map to viewport coords (0, 0).
// `PipelineState::compare_op` is a `vk::CompareOp` here rather than `rr::TestFunc` (upstream maps it to one on the way into the
// pipeline), and `get_color_pixels` returns a copy of the read-back buffer as a level rather than a view of the mapped memory.
// `ReferenceDrawContext` is `reference_draw`: the same draw objects rendered by the `rr` software rasterizer.

use vulkanalia::prelude::v1_0::*;

use crate::rr::primitive_types::PrimitiveType;
use crate::rr::render_state::{CullMode, RenderState, ViewportOrientation, ViewportState};
use crate::rr::renderer::{DrawCommand, PrimitiveList, Program, RenderTarget, Renderer, as_multisample_view};
use crate::rr::shaders::{FragmentShader, VertexShader};
use crate::rr::vertex_attrib::{VertexAttrib, VertexAttribType};
use crate::tcu::TestError;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::texture::map_vk_format;
use crate::tcu::vector::Vec4;
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, GraphicsPipelineStages, allocate_command_buffer, make_buffer_create_info, make_command_pool,
};
use crate::vk::programs::{ProgramBinary, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::Context;

/// `drawutil::FrameBufferState`
#[derive(Clone, Copy)]
pub struct FrameBufferState {
    pub color_format: vk::Format,
    pub depth_format: vk::Format,
    pub render_size: (u32, u32),
    pub num_samples: vk::SampleCountFlags,
    /// A depth view the caller made; null makes the context create its own when `depth_format` names a format.
    pub depth_image_view: vk::ImageView,
}

impl FrameBufferState {
    pub fn new(render_width: u32, render_height: u32) -> Self {
        assert!(render_width != 0 && render_height != 0);
        Self {
            color_format: vk::Format::R8G8B8A8_UNORM,
            depth_format: vk::Format::UNDEFINED,
            render_size: (render_width, render_height),
            num_samples: vk::SampleCountFlags::_1,
            depth_image_view: vk::ImageView::null(),
        }
    }
}

/// `drawutil::PipelineState`
#[derive(Clone)]
pub struct PipelineState {
    pub depth_clamp_enable: bool,
    pub depth_test_enable: bool,
    pub depth_write_enable: bool,
    pub compare_op: vk::CompareOp,
    pub depth_bounds_test_enable: bool,
    pub blend_enable: bool,
    pub cull_mode: vk::CullModeFlags,
    pub line_width: f32,
    pub num_patch_control_points: u32,
    pub sample_shading_enable: bool,
    pub subpixel_bits: i32,
    pub sample_masks: Vec<u32>,

    // VK_EXT_depth_clip_enable
    pub explicit_depth_clip_enable: bool,
    pub depth_clip_enable: bool,
}

impl PipelineState {
    pub fn new(subpixel_bits: i32) -> Self {
        Self {
            depth_clamp_enable: false,
            depth_test_enable: false,
            depth_write_enable: false,
            compare_op: vk::CompareOp::LESS,
            depth_bounds_test_enable: false,
            blend_enable: false,
            cull_mode: vk::CullModeFlags::NONE,
            line_width: 1.0,
            num_patch_control_points: 0,
            sample_shading_enable: false,
            subpixel_bits,
            sample_masks: Vec::new(),
            explicit_depth_clip_enable: false,
            depth_clip_enable: false,
        }
    }
}

/// `drawutil::DrawCallData`
#[derive(Clone, Copy)]
pub struct DrawCallData<'a> {
    pub topology: vk::PrimitiveTopology,
    pub vertices: &'a [Vec4],
}

/// `drawutil::VulkanShader`
#[derive(Clone, Copy)]
pub struct VulkanShader {
    pub stage: vk::ShaderStageFlags,
    pub binary: ProgramBinary,
}

/// `drawutil::VulkanProgram`
#[derive(Clone)]
pub struct VulkanProgram {
    pub shaders: Vec<VulkanShader>,
    pub descriptor_set_layout: vk::DescriptorSetLayout,
    pub descriptor_set: vk::DescriptorSet,
}

impl VulkanProgram {
    pub fn new(shaders: Vec<VulkanShader>) -> Self {
        Self {
            shaders,
            descriptor_set_layout: vk::DescriptorSetLayout::null(),
            descriptor_set: vk::DescriptorSet::null(),
        }
    }
}

/// `drawutil::RenderObject`
struct RenderObject<'a> {
    pipeline: Unique<'a, vk::Pipeline>,
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    _shader_modules: Vec<Unique<'a, vk::ShaderModule>>,
    vertex_buffer: BufferWithMemory<'a>,
    vertex_count: u32,
    descriptor_set: vk::DescriptorSet,
}

/// `drawutil::VulkanDrawContext`
pub struct VulkanDrawContext<'a> {
    context: &'a Context<'a>,
    framebuffer_state: FrameBufferState,
    // Declared in the order they have to be destroyed in.
    render_objects: Vec<RenderObject<'a>>,
    framebuffer: Unique<'a, vk::Framebuffer>,
    render_pass: Unique<'a, vk::RenderPass>,
    cmd_buffer: UniqueCommandBuffer<'a>,
    _cmd_pool: Unique<'a, vk::CommandPool>,
    _color_image_view: Unique<'a, vk::ImageView>,
    depth_image_view: Option<Unique<'a, vk::ImageView>>,
    color_attachment_buffer: BufferWithMemory<'a>,
    _resolve_image: Option<ImageWithMemory<'a>>,
    color_image: ImageWithMemory<'a>,
    _depth_image: Option<ImageWithMemory<'a>>,
}

impl<'a> VulkanDrawContext<'a> {
    pub fn new(context: &'a Context<'a>, framebuffer_state: &FrameBufferState) -> Result<Self, TestError> {
        let framebuffer_state = *framebuffer_state;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let (width, height) = framebuffer_state.render_size;
        let extent = vk::Extent3D {
            width,
            height,
            depth: 1,
        };

        // Color attachment image
        let color_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(framebuffer_state.color_format)
            .extent(extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(framebuffer_state.num_samples)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::COLOR_ATTACHMENT)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_image = ImageWithMemory::new(device, alloc, color_info, MemoryRequirement::ANY)?;
        let color_image_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            framebuffer_state.color_format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        // Buffer to copy attachment data after rendering
        let pixel_size = map_vk_format(framebuffer_state.color_format)
            .and_then(|format| format.pixel_size())
            .ok_or_else(|| TestError::NotPorted("colour format without a texture format".to_string()))?
            as usize;
        let bitmap_size = pixel_size * width as usize * height as usize;
        let color_attachment_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(bitmap_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::write_bytes(color_attachment_buffer.get_allocation().get_host_ptr(), 0, bitmap_size) };
        flush_alloc(device, color_attachment_buffer.get_allocation())?;

        // Depth buffer - create image when user didn't deliver its own, but configured depthFormat
        let mut depth_image = None;
        let mut depth_image_view = None;
        let mut depth_view_handle = framebuffer_state.depth_image_view;
        if framebuffer_state.depth_image_view == vk::ImageView::null()
            && framebuffer_state.depth_format != vk::Format::UNDEFINED
        {
            let depth_info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(framebuffer_state.depth_format)
                .extent(extent)
                .mip_levels(1)
                .array_layers(1)
                .samples(framebuffer_state.num_samples)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            let image = ImageWithMemory::new(device, alloc, depth_info, MemoryRequirement::ANY)?;
            let view = make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                framebuffer_state.depth_format,
                make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
            )?;
            depth_view_handle = *view;
            depth_image = Some(image);
            depth_image_view = Some(view);
        }
        let has_depth = depth_view_handle != vk::ImageView::null();

        // Renderpass
        let mut attachment_descriptions = vec![
            vk::AttachmentDescription::builder()
                .format(framebuffer_state.color_format)
                .samples(framebuffer_state.num_samples)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
        ];
        if has_depth {
            attachment_descriptions.push(
                vk::AttachmentDescription::builder()
                    .format(framebuffer_state.depth_format)
                    .samples(framebuffer_state.num_samples)
                    .load_op(vk::AttachmentLoadOp::CLEAR)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .initial_layout(vk::ImageLayout::UNDEFINED)
                    .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                    .build(),
            );
        }
        let color_reference = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        // The attachment of a subpass that has no depth is VK_ATTACHMENT_UNUSED, a reference upstream always passes.
        let depth_reference = vk::AttachmentReference::builder()
            .attachment(if has_depth { 1 } else { vk::ATTACHMENT_UNUSED })
            .layout(if has_depth {
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
            } else {
                vk::ImageLayout::UNDEFINED
            })
            .build();
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_reference)
            .depth_stencil_attachment(&depth_reference)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachment_descriptions)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );

        // Framebuffer
        let mut attachment_bind_infos = vec![*color_image_view];
        if has_depth {
            attachment_bind_infos.push(depth_view_handle);
        }
        let framebuffer_info = vk::FramebufferCreateInfo::builder()
            .render_pass(*render_pass)
            .attachments(&attachment_bind_infos)
            .width(width)
            .height(height)
            .layers(1);
        let framebuffer = Unique::new(
            device,
            unsafe { device.create_framebuffer(&framebuffer_info, None) }.vk_check("vkCreateFramebuffer")?,
        );

        // Command buffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        Ok(Self {
            context,
            framebuffer_state,
            render_objects: Vec::new(),
            framebuffer,
            render_pass,
            cmd_buffer,
            _cmd_pool: cmd_pool,
            _color_image_view: color_image_view,
            depth_image_view,
            color_attachment_buffer,
            _resolve_image: None,
            color_image,
            _depth_image: depth_image,
        })
    }

    /// `VulkanDrawContext::registerDrawObject`
    pub fn register_draw_object(
        &mut self,
        pipeline_state: &PipelineState,
        vulkan_program: &VulkanProgram,
        draw_call_data: &DrawCallData<'_>,
    ) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();

        // Vertex buffer
        let buffer_size = std::mem::size_of_val(draw_call_data.vertices);
        let vertex_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(buffer_size as vk::DeviceSize, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let vertex_count = draw_call_data.vertices.len() as u32;
        unsafe {
            std::ptr::copy_nonoverlapping(
                draw_call_data.vertices.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                buffer_size,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        // bind descriptor sets
        let set_layouts: Vec<vk::DescriptorSetLayout> =
            if vulkan_program.descriptor_set_layout == vk::DescriptorSetLayout::null() {
                Vec::new()
            } else {
                vec![vulkan_program.descriptor_set_layout]
            };
        let pipeline_layout = crate::vk::obj_util::make_pipeline_layout(device, &set_layouts)?;

        // Graphics pipeline
        assert!(
            draw_call_data.topology != vk::PrimitiveTopology::PATCH_LIST || pipeline_state.num_patch_control_points > 0
        );

        let mut shader_modules = Vec::new();
        let mut stages = GraphicsPipelineStages {
            vertex: vk::ShaderModule::null(),
            fragment: vk::ShaderModule::null(),
            tessellation_control: None,
            tessellation_evaluation: None,
            geometry: None,
        };
        for shader in &vulkan_program.shaders {
            let module = create_shader_module(device, shader.binary)?;
            match shader.stage {
                vk::ShaderStageFlags::VERTEX => stages.vertex = *module,
                vk::ShaderStageFlags::TESSELLATION_CONTROL => stages.tessellation_control = Some(*module),
                vk::ShaderStageFlags::TESSELLATION_EVALUATION => stages.tessellation_evaluation = Some(*module),
                vk::ShaderStageFlags::GEOMETRY => stages.geometry = Some(*module),
                _ => stages.fragment = *module,
            }
            shader_modules.push(module);
        }

        if pipeline_state.depth_bounds_test_enable && context.get_device_features().depth_bounds == vk::FALSE {
            return Err(TestError::NotSupported("depthBounds not supported".to_string()));
        }

        let (width, height) = self.framebuffer_state.render_size;
        let pipeline = self.make_pipeline(
            pipeline_state,
            draw_call_data.topology,
            *pipeline_layout,
            &stages,
            width,
            height,
        )?;

        self.render_objects.push(RenderObject {
            pipeline,
            pipeline_layout,
            _shader_modules: shader_modules,
            vertex_buffer,
            vertex_count,
            descriptor_set: vulkan_program.descriptor_set,
        });
        Ok(())
    }

    /// The `makeGraphicsPipeline` call of `registerDrawObject`, with the states of `pipeline_state` and a vertex input
    /// state left empty (the vertex buffer is read through the `v_position` input the shaders declare).
    fn make_pipeline(
        &self,
        pipeline_state: &PipelineState,
        topology: vk::PrimitiveTopology,
        layout: vk::PipelineLayout,
        modules: &GraphicsPipelineStages,
        width: u32,
        height: u32,
    ) -> Result<Unique<'a, vk::Pipeline>, TestError> {
        let device = self.context.get_device();

        let entry = b"main\0";
        let mut stage_infos = vec![
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(modules.vertex)
                .name(entry)
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(modules.fragment)
                .name(entry)
                .build(),
        ];
        if let Some(module) = modules.tessellation_control {
            stage_infos.push(
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::TESSELLATION_CONTROL)
                    .module(module)
                    .name(entry)
                    .build(),
            );
        }
        if let Some(module) = modules.tessellation_evaluation {
            stage_infos.push(
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::TESSELLATION_EVALUATION)
                    .module(module)
                    .name(entry)
                    .build(),
            );
        }
        if let Some(module) = modules.geometry {
            stage_infos.push(
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::GEOMETRY)
                    .module(module)
                    .name(entry)
                    .build(),
            );
        }

        // `makeGraphicsPipeline` is handed a null vertex input state and builds the one for a single vec4 binding at
        // location 0, which is the layout the vertex buffer has.
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
        let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes);
        let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(topology)
            .primitive_restart_enable(false);
        let tessellation = vk::PipelineTessellationStateCreateInfo::builder()
            .patch_control_points(pipeline_state.num_patch_control_points);

        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: width as f32,
            height: height as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D { width, height },
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);

        let mut depth_clip_state = vk::PipelineRasterizationDepthClipStateCreateInfoEXT::builder()
            .depth_clip_enable(pipeline_state.depth_clip_enable);
        let mut rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(pipeline_state.depth_clamp_enable)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(pipeline_state.cull_mode)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(false)
            .depth_bias_constant_factor(0.0)
            .depth_bias_clamp(0.0)
            .depth_bias_slope_factor(0.0)
            .line_width(pipeline_state.line_width);
        if pipeline_state.explicit_depth_clip_enable {
            rasterization = rasterization.push_next(&mut depth_clip_state);
        }

        let multisample = vk::PipelineMultisampleStateCreateInfo::builder()
            .rasterization_samples(self.framebuffer_state.num_samples)
            .sample_shading_enable(pipeline_state.sample_shading_enable)
            .min_sample_shading(if pipeline_state.sample_shading_enable { 1.0 } else { 0.0 })
            .alpha_to_coverage_enable(false)
            .alpha_to_one_enable(false);
        let multisample = if pipeline_state.sample_masks.is_empty() {
            multisample
        } else {
            multisample.sample_mask(&pipeline_state.sample_masks)
        };

        let stencil_op_state = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::KEEP)
            .pass_op(vk::StencilOp::KEEP)
            .depth_fail_op(vk::StencilOp::KEEP)
            .compare_op(vk::CompareOp::NEVER)
            .compare_mask(0)
            .write_mask(0)
            .reference(0)
            .build();
        let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(pipeline_state.depth_test_enable)
            .depth_write_enable(pipeline_state.depth_write_enable)
            .depth_compare_op(pipeline_state.compare_op)
            .depth_bounds_test_enable(pipeline_state.depth_bounds_test_enable)
            .stencil_test_enable(false)
            .front(stencil_op_state)
            .back(stencil_op_state)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);

        let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(pipeline_state.blend_enable)
            .src_color_blend_factor(vk::BlendFactor::SRC_ALPHA)
            .dst_color_blend_factor(vk::BlendFactor::ONE)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::SRC_ALPHA)
            .dst_alpha_blend_factor(vk::BlendFactor::ONE)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op_enable(false)
            .logic_op(vk::LogicOp::COPY)
            .attachments(&blend_attachments)
            .blend_constants([0.0; 4]);

        let mut info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stage_infos)
            .vertex_input_state(&vertex_input)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample)
            .depth_stencil_state(&depth_stencil)
            .color_blend_state(&color_blend)
            .layout(layout)
            .render_pass(*self.render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        if modules.tessellation_control.is_some() && modules.tessellation_evaluation.is_some() {
            info = info.tessellation_state(&tessellation);
        }
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        Ok(Unique::new(device, pipelines.0[0]))
    }

    /// `VulkanDrawContext::draw`
    pub fn draw(&mut self) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let (width, height) = self.framebuffer_state.render_size;
        let cmd = *self.cmd_buffer;
        let extent = vk::Extent3D {
            width,
            height,
            depth: 1,
        };
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        // Record commands
        begin_command_buffer(device, cmd)?;

        // Begin render pass
        let has_depth =
            self.framebuffer_state.depth_image_view != vk::ImageView::null() || self.depth_image_view.is_some();
        let mut clear_values = vec![vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 1.0],
            },
        }];
        if has_depth {
            clear_values.push(vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 },
            });
        }
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*self.render_pass)
            .framebuffer(*self.framebuffer)
            .render_area(vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D { width, height },
            })
            .clear_values(&clear_values);
        unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };

        for object in &self.render_objects {
            unsafe {
                if object.descriptor_set != vk::DescriptorSet::null() {
                    device.cmd_bind_descriptor_sets(
                        cmd,
                        vk::PipelineBindPoint::GRAPHICS,
                        *object.pipeline_layout,
                        0,
                        &[object.descriptor_set],
                        &[],
                    );
                }
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *object.pipeline);
                device.cmd_bind_vertex_buffers(cmd, 0, &[object.vertex_buffer.get()], &[0]);
                device.cmd_draw(cmd, object.vertex_count, 1, 0, 0);
            }
        }
        unsafe { device.cmd_end_render_pass(cmd) };

        // Barrier: draw -> copy from image
        let barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            self.color_image.get(),
            color_range,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
        }

        // Resolve multisample image
        let copy_source = if self.framebuffer_state.num_samples != vk::SampleCountFlags::_1 {
            let image_resolve = vk::ImageResolve {
                src_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                src_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                dst_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                dst_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                extent,
            };

            let resolve_info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(self.framebuffer_state.color_format)
                .extent(extent)
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::TRANSFER_SRC)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            let resolve_image = ImageWithMemory::new(device, alloc, resolve_info, MemoryRequirement::ANY)?;

            let resolve_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                resolve_image.get(),
                color_range,
            );
            let to_read = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                resolve_image.get(),
                color_range,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[resolve_barrier],
                );
                device.cmd_resolve_image(
                    cmd,
                    self.color_image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    resolve_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[image_resolve],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_read],
                );
            }
            let source = resolve_image.get();
            self._resolve_image = Some(resolve_image);
            source
        } else {
            self.color_image.get()
        };

        let copy_region = make_buffer_image_copy(
            extent,
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );
        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd,
                copy_source,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                self.color_attachment_buffer.get(),
                &[copy_region],
            )
        };

        // Barrier: copy to buffer -> host read
        let buffer_barrier = vk::BufferMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .buffer(self.color_attachment_buffer.get())
            .offset(0)
            .size(vk::WHOLE_SIZE)
            .build();
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, cmd)?;

        submit_commands_and_wait(device, queue, cmd)
    }

    /// `VulkanDrawContext::getColorPixels`
    pub fn get_color_pixels(&self) -> Result<TextureLevel, TestError> {
        let device = self.context.get_device();
        let (width, height) = self.framebuffer_state.render_size;

        let alloc = self.color_attachment_buffer.get_allocation();
        invalidate_alloc(device, alloc)?;

        let format = map_vk_format(self.framebuffer_state.color_format)
            .ok_or_else(|| TestError::NotPorted("colour format without a texture format".to_string()))?;
        let mut level = TextureLevel::new(format, width, height, 1)?;
        let size = level.data_mut().len();
        let bytes = unsafe { std::slice::from_raw_parts(alloc.get_host_ptr(), size) };
        level.data_mut().copy_from_slice(bytes);
        Ok(level)
    }
}

/// `drawutil::getPrimitiveTopologyShortName`: the Vulkan name without `VK_PRIMITIVE_TOPOLOGY_`, in lower case.
pub fn get_primitive_topology_short_name(topology: vk::PrimitiveTopology) -> &'static str {
    match topology {
        vk::PrimitiveTopology::POINT_LIST => "point_list",
        vk::PrimitiveTopology::LINE_LIST => "line_list",
        vk::PrimitiveTopology::LINE_STRIP => "line_strip",
        vk::PrimitiveTopology::TRIANGLE_LIST => "triangle_list",
        vk::PrimitiveTopology::TRIANGLE_STRIP => "triangle_strip",
        vk::PrimitiveTopology::TRIANGLE_FAN => "triangle_fan",
        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY => "line_list_with_adjacency",
        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => "line_strip_with_adjacency",
        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => "triangle_list_with_adjacency",
        vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => "triangle_strip_with_adjacency",
        _ => "patch_list",
    }
}

/// `mapVkPrimitiveToRRPrimitive`
fn map_vk_primitive_to_rr_primitive(topology: vk::PrimitiveTopology) -> PrimitiveType {
    match topology {
        vk::PrimitiveTopology::POINT_LIST => PrimitiveType::Points,
        vk::PrimitiveTopology::LINE_LIST => PrimitiveType::Lines,
        vk::PrimitiveTopology::LINE_STRIP => PrimitiveType::LineStrip,
        vk::PrimitiveTopology::TRIANGLE_LIST => PrimitiveType::Triangles,
        vk::PrimitiveTopology::TRIANGLE_STRIP => PrimitiveType::TriangleStrip,
        vk::PrimitiveTopology::TRIANGLE_FAN => PrimitiveType::TriangleFan,
        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY => PrimitiveType::LinesAdjacency,
        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => PrimitiveType::LineStripAdjacency,
        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => PrimitiveType::TrianglesAdjacency,
        _ => PrimitiveType::TriangleStripAdjacency,
    }
}

/// One entry of `drawutil::ReferenceDrawContext::registerDrawObject`.
pub struct ReferenceDrawObject<'a> {
    pub pipeline_state: PipelineState,
    pub vertex_shader: &'a dyn VertexShader,
    pub fragment_shader: &'a dyn FragmentShader,
    pub draw_call_data: DrawCallData<'a>,
}

/// `drawutil::ReferenceDrawContext::draw` followed by `getColorPixels`: renders every object with the software rasterizer
/// into a level of the framebuffer's colour format, cleared to (0, 0, 0, 1), and returns it.
pub fn reference_draw(
    framebuffer_state: &FrameBufferState,
    objects: &[ReferenceDrawObject<'_>],
) -> Result<TextureLevel, TestError> {
    let (width, height) = framebuffer_state.render_size;
    let format = map_vk_format(framebuffer_state.color_format)
        .ok_or_else(|| TestError::NotPorted("colour format without a texture format".to_string()))?;
    let mut ref_image = TextureLevel::new(format, width, height, 1)?;
    {
        let mut access = ref_image.get_access();
        for y in 0..height {
            for x in 0..width {
                access.set_pixel([0.0, 0.0, 0.0, 1.0], x, y, 0);
            }
        }
    }

    let renderer = Renderer::new();
    for object in objects {
        let cull_mode = match object.pipeline_state.cull_mode {
            vk::CullModeFlags::BACK => CullMode::Back,
            vk::CullModeFlags::FRONT => CullMode::Front,
            vk::CullModeFlags::FRONT_AND_BACK => CullMode::FrontAndBack,
            _ => CullMode::None,
        };

        let render_state = RenderState::with_orientation_and_cull(
            ViewportState::from_target_size(width as i32, height as i32),
            object.pipeline_state.subpixel_bits,
            ViewportOrientation::UpperLeft,
            cull_mode,
        );
        let program = Program {
            vertex_shader: object.vertex_shader,
            fragment_shader: object.fragment_shader,
            geometry_shader: None,
        };
        let vertices = object.draw_call_data.vertices;
        let vertex_attribs = [VertexAttrib::from_pointer(
            VertexAttribType::Float,
            4,
            std::mem::size_of::<Vec4>() as i32,
            0,
            vertices.as_ptr().cast::<u8>(),
        )];
        let primitives = PrimitiveList::from_arrays(
            map_vk_primitive_to_rr_primitive(object.draw_call_data.topology),
            vertices.len(),
            0,
        );
        let command = DrawCommand {
            state: &render_state,
            program: &program,
            vertex_attribs: &vertex_attribs,
            primitives: &primitives,
        };
        let mut render_target = RenderTarget::new(as_multisample_view(ref_image.get_access()), None, None);
        renderer.draw(&command, &mut render_target);
    }
    Ok(ref_image)
}
