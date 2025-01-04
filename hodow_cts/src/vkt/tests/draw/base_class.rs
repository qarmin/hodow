// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawBaseClass.cpp
//   external/vulkancts/modules/vulkan/draw/vktDrawBaseClass.hpp
//   external/vulkancts/modules/vulkan/draw/vktDrawGroupParams.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Copyright (c) 2016 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `DrawTestsBaseClass` is a base class that the concrete tests derive from and finish by calling
// `initialize()` once their vertex data is filled in. Here it is a struct a test instance owns,
// built by `DrawTestsBase::new` from that vertex data. Upstream's `Draw::Image::readSurface` is
// `DrawTestsBase::read_color_surface`: the target is always RGBA8 and always left in GENERAL.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_3;

use crate::tcu::pixel::TextureLevel;
use crate::tcu::{ChannelOrder, ChannelType, TestError, TextureFormat};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::Context;
use crate::vkt::tests::draw::initial_transition_color_2d_image;

/// `Draw::GroupParams`
#[derive(Clone, Copy, Default)]
pub struct GroupParams {
    /// Tests use dynamic rendering, otherwise a render pass object is used.
    pub use_dynamic_rendering: bool,
    /// A secondary command buffer is created in the test.
    pub use_secondary_cmd_buffer: bool,
    /// When true begin/endRendering is in the secondary command buffer; only read when `use_secondary_cmd_buffer`.
    pub secondary_cmd_buffer_completely_contains_dynamic_renderpass: bool,
    /// The secondary command buffer with the render pass is nested within another secondary; only read when `use_secondary_cmd_buffer`.
    pub nested_secondary_cmd_buffer: bool,
}

/// `Draw::VertexElementData` (which extends `PositionColorVertex`). Laid out as upstream lays it out:
/// the pipeline reads it through offsets 0, 16 and 32 with a stride of 36.
#[repr(C)]
#[derive(Clone, Copy)]
pub struct VertexElementData {
    pub position: [f32; 4],
    pub color: [f32; 4],
    pub ref_vertex_index: u32,
}

impl VertexElementData {
    pub fn new(position: [f32; 4], color: [f32; 4], ref_vertex_index: u32) -> Self {
        Self {
            position,
            color,
            ref_vertex_index,
        }
    }
}

/// `Draw::ReferenceImageCoordinates`
#[derive(Clone, Copy)]
pub struct ReferenceImageCoordinates {
    pub left: f64,
    pub right: f64,
    pub top: f64,
    pub bottom: f64,
}

impl Default for ReferenceImageCoordinates {
    fn default() -> Self {
        Self {
            left: -0.3,
            right: 0.3,
            top: 0.3,
            bottom: -0.3,
        }
    }
}

/// `Draw::ReferenceImageInstancedCoordinates`
#[derive(Clone, Copy)]
pub struct ReferenceImageInstancedCoordinates {
    pub left: f64,
    pub right: f64,
    pub top: f64,
    pub bottom: f64,
}

impl Default for ReferenceImageInstancedCoordinates {
    fn default() -> Self {
        Self {
            left: -0.3,
            right: 0.6,
            top: 0.3,
            bottom: -0.6,
        }
    }
}

pub const DEFAULT_RENDER_SIZE: u32 = 256;

pub const COLOR_ATTACHMENT_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// What the pipeline reads vertices through: the base class's own `VertexElementData` buffer, or a layout the test
/// declares (and then binds its own vertex buffers for).
pub enum VertexInput {
    Elements(Vec<VertexElementData>),
    Custom {
        bindings: Vec<vk::VertexInputBindingDescription>,
        attributes: Vec<vk::VertexInputAttributeDescription>,
    },
}

/// `Draw::DrawTestsBaseClass`
pub struct DrawTestsBase<'a> {
    pub context: &'a Context<'a>,
    pub render_width: u32,
    pub render_height: u32,
    pub color_attachment_format: vk::Format,
    pub group_params: GroupParams,
    pub topology: vk::PrimitiveTopology,
    /// For multiview.
    pub layers: u32,
    pub data: Vec<VertexElementData>,

    pub pipeline: Unique<'a, vk::Pipeline>,
    pub pipeline_layout: Unique<'a, vk::PipelineLayout>,
    pub color_target_image: ImageWithMemory<'a>,
    pub color_target_view: Unique<'a, vk::ImageView>,
    /// Vertex buffer for vertex colors and positions.
    pub vertex_buffer: Option<BufferWithMemory<'a>>,
    pub cmd_buffer: UniqueCommandBuffer<'a>,
    pub sec_cmd_buffer: Option<UniqueCommandBuffer<'a>>,
    pub nested_cmd_buffer: Option<UniqueCommandBuffer<'a>>,
    pub cmd_pool: Unique<'a, vk::CommandPool>,
    pub framebuffer: Option<Unique<'a, vk::Framebuffer>>,
    pub render_pass: Option<Unique<'a, vk::RenderPass>>,
}

impl<'a> DrawTestsBase<'a> {
    /// `DrawTestsBaseClass::DrawTestsBaseClass` followed by `initialize`, with the vertex data the derived class
    /// would have pushed into `m_data` in between.
    #[allow(clippy::too_many_arguments)]
    pub fn new(
        context: &'a Context<'a>,
        vertex_shader_name: &str,
        fragment_shader_name: &str,
        group_params: GroupParams,
        topology: vk::PrimitiveTopology,
        layers: u32,
        render_width: u32,
        render_height: u32,
        data: Vec<VertexElementData>,
    ) -> Result<Self, TestError> {
        Self::new_with_input(
            context,
            vertex_shader_name,
            fragment_shader_name,
            group_params,
            topology,
            layers,
            render_width,
            render_height,
            VertexInput::Elements(data),
        )
    }

    /// `new` for a test that declares its own vertex input, as `DrawIndirectInstancedInstance` does.
    #[allow(clippy::too_many_arguments)]
    pub fn new_with_input(
        context: &'a Context<'a>,
        vertex_shader_name: &str,
        fragment_shader_name: &str,
        group_params: GroupParams,
        topology: vk::PrimitiveTopology,
        layers: u32,
        render_width: u32,
        render_height: u32,
        input: VertexInput,
    ) -> Result<Self, TestError> {
        Self::new_with_set_layouts(
            context,
            vertex_shader_name,
            fragment_shader_name,
            group_params,
            topology,
            layers,
            render_width,
            render_height,
            input,
            &[],
        )
    }

    /// `new_with_input` for a test whose pipeline layout holds descriptor set layouts (`DrawIndexed::initialize` with `testDrawCount`).
    #[allow(clippy::too_many_arguments)]
    pub fn new_with_set_layouts(
        context: &'a Context<'a>,
        vertex_shader_name: &str,
        fragment_shader_name: &str,
        group_params: GroupParams,
        topology: vk::PrimitiveTopology,
        layers: u32,
        render_width: u32,
        render_height: u32,
        input: VertexInput,
        set_layouts: &[vk::DescriptorSetLayout],
    ) -> Result<Self, TestError> {
        Self::new_with_maintenance5(
            context,
            vertex_shader_name,
            fragment_shader_name,
            group_params,
            topology,
            layers,
            render_width,
            render_height,
            input,
            set_layouts,
            false,
        )
    }

    /// `new_with_set_layouts` with `DrawParamsBase::useMaintenance5`: the pipeline gets `VK_PIPELINE_CREATE_LIBRARY_BIT_KHR` in its
    /// flags, which `VkPipelineCreateFlags2CreateInfo` (holding only ALLOW_DERIVATIVES) has to override.
    #[allow(clippy::too_many_arguments)]
    pub fn new_with_maintenance5(
        context: &'a Context<'a>,
        vertex_shader_name: &str,
        fragment_shader_name: &str,
        group_params: GroupParams,
        topology: vk::PrimitiveTopology,
        layers: u32,
        render_width: u32,
        render_height: u32,
        input: VertexInput,
        set_layouts: &[vk::DescriptorSetLayout],
        use_maintenance5: bool,
    ) -> Result<Self, TestError> {
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let queue_family_index = context.get_universal_queue_family_index();
        let color_attachment_format = COLOR_ATTACHMENT_FORMAT;
        let view_mask = default_view_mask(layers);
        let multiview = view_mask != 0;

        // initialize
        let pipeline_layout = make_pipeline_layout(device, set_layouts)?;

        let target_image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(color_attachment_format)
            .extent(vk::Extent3D {
                width: render_width,
                height: render_height,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(layers)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(
                vk::ImageUsageFlags::COLOR_ATTACHMENT
                    | vk::ImageUsageFlags::TRANSFER_SRC
                    | vk::ImageUsageFlags::TRANSFER_DST,
            )
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_target_image = ImageWithMemory::new(device, alloc, target_image_info, MemoryRequirement::ANY)?;

        let image_view_type = if multiview {
            vk::ImageViewType::_2D_ARRAY
        } else {
            vk::ImageViewType::_2D
        };
        let color_target_view = make_image_view(
            device,
            color_target_image.get(),
            image_view_type,
            color_attachment_format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, layers),
        )?;

        // create renderpass and framebuffer only when we are not using dynamic rendering
        let mut render_pass = None;
        let mut framebuffer = None;
        if !group_params.use_dynamic_rendering {
            let attachments = [vk::AttachmentDescription::builder()
                .format(color_attachment_format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::STORE)
                .initial_layout(vk::ImageLayout::GENERAL)
                .final_layout(vk::ImageLayout::GENERAL)
                .build()];
            let color_attachment_references = [vk::AttachmentReference::builder()
                .attachment(0)
                .layout(vk::ImageLayout::GENERAL)
                .build()];
            let subpasses = [vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .color_attachments(&color_attachment_references)
                .build()];

            let view_masks = [view_mask];
            let mut multiview_create_info = vk::RenderPassMultiviewCreateInfo::builder()
                .view_masks(&view_masks)
                .correlation_masks(&view_masks);

            let render_pass_info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachments)
                .subpasses(&subpasses);
            let render_pass_info = if multiview {
                render_pass_info.push_next(&mut multiview_create_info)
            } else {
                render_pass_info
            };
            let handle =
                unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?;
            let pass = Unique::new(device, handle);

            framebuffer = Some(make_framebuffer(
                device,
                *pass,
                &[*color_target_view],
                render_width,
                render_height,
                1,
            )?);
            render_pass = Some(pass);
        }

        let (data, custom_input) = match input {
            VertexInput::Elements(data) => (data, None),
            VertexInput::Custom { bindings, attributes } => (Vec::new(), Some((bindings, attributes))),
        };

        let vertex_buffer = if custom_input.is_none() {
            let vertex_buffer_size = (data.len() * std::mem::size_of::<VertexElementData>()) as vk::DeviceSize;
            let vertex_buffer = BufferWithMemory::new(
                device,
                alloc,
                make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe {
                std::ptr::copy_nonoverlapping(
                    data.as_ptr().cast::<u8>(),
                    vertex_buffer.get_allocation().get_host_ptr(),
                    vertex_buffer_size as usize,
                );
            }
            flush_alloc(device, vertex_buffer.get_allocation())?;
            Some(vertex_buffer)
        } else {
            None
        };

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let sec_cmd_buffer = if group_params.use_secondary_cmd_buffer {
            Some(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::SECONDARY,
            )?)
        } else {
            None
        };

        let nested_cmd_buffer = if group_params.nested_secondary_cmd_buffer {
            Some(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::SECONDARY,
            )?)
        } else {
            None
        };

        // initPipeline
        let pipeline = {
            let binaries: BinaryCollection = context.get_binary_collection();
            let vs = create_shader_module(device, binaries.get(vertex_shader_name)?)?;
            let fs = create_shader_module(device, binaries.get(fragment_shader_name)?)?;

            let stages = [
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::VERTEX)
                    .module(*vs)
                    .name(b"main\0")
                    .build(),
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::FRAGMENT)
                    .module(*fs)
                    .name(b"main\0")
                    .build(),
            ];

            let (vertex_input_binding_descriptions, vertex_input_attribute_descriptions) =
                custom_input.unwrap_or_else(|| {
                    (
                        vec![
                            vk::VertexInputBindingDescription::builder()
                                .binding(0)
                                .stride(std::mem::size_of::<VertexElementData>() as u32)
                                .input_rate(vk::VertexInputRate::VERTEX)
                                .build(),
                        ],
                        vec![
                            vk::VertexInputAttributeDescription::builder()
                                .location(0)
                                .binding(0)
                                .format(vk::Format::R32G32B32A32_SFLOAT)
                                .offset(0)
                                .build(),
                            vk::VertexInputAttributeDescription::builder()
                                .location(1)
                                .binding(0)
                                .format(vk::Format::R32G32B32A32_SFLOAT)
                                .offset(16)
                                .build(),
                            vk::VertexInputAttributeDescription::builder()
                                .location(2)
                                .binding(0)
                                .format(vk::Format::R32_SINT)
                                .offset(32)
                                .build(),
                        ],
                    )
                });
            let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
                .vertex_binding_descriptions(&vertex_input_binding_descriptions)
                .vertex_attribute_descriptions(&vertex_input_attribute_descriptions);
            let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
                .topology(topology)
                .primitive_restart_enable(false);
            let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
                .blend_enable(false)
                .color_write_mask(vk::ColorComponentFlags::all())
                .build()];
            let color_blend_state =
                vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachments);
            let viewports = [vk::Viewport {
                x: 0.0,
                y: 0.0,
                width: render_width as f32,
                height: render_height as f32,
                min_depth: 0.0,
                max_depth: 1.0,
            }];
            let scissors = [vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: render_width,
                    height: render_height,
                },
            }];
            let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
                .viewports(&viewports)
                .scissors(&scissors);
            let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
                .depth_compare_op(vk::CompareOp::ALWAYS)
                .max_depth_bounds(1.0);
            let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
                .depth_clamp_enable(false)
                .rasterizer_discard_enable(false)
                .polygon_mode(vk::PolygonMode::FILL)
                .cull_mode(vk::CullModeFlags::NONE)
                .front_face(vk::FrontFace::CLOCKWISE)
                .depth_bias_enable(true)
                .line_width(1.0);
            let multisample_state =
                vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);

            let color_formats = [color_attachment_format];
            let mut rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
                .view_mask(view_mask)
                .color_attachment_formats(&color_formats)
                .depth_attachment_format(vk::Format::UNDEFINED)
                .stencil_attachment_format(vk::Format::UNDEFINED);

            let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
                .stages(&stages)
                .vertex_input_state(&vertex_input_state)
                .input_assembly_state(&input_assembly_state)
                .viewport_state(&viewport_state)
                .rasterization_state(&rasterization_state)
                .multisample_state(&multisample_state)
                .depth_stencil_state(&depth_stencil_state)
                .color_blend_state(&color_blend_state)
                .layout(*pipeline_layout)
                .render_pass(render_pass.as_ref().map_or_else(vk::RenderPass::null, |pass| **pass))
                .subpass(0)
                .base_pipeline_index(0);
            let pipeline_info = if group_params.use_dynamic_rendering {
                pipeline_info.push_next(&mut rendering_create_info)
            } else {
                pipeline_info
            };
            let mut pipeline_flags2 =
                vk::PipelineCreateFlags2CreateInfo::builder().flags(vk::PipelineCreateFlags2::ALLOW_DERIVATIVES);
            let pipeline_info = if use_maintenance5 {
                pipeline_info
                    .flags(vk::PipelineCreateFlags::LIBRARY_KHR)
                    .push_next(&mut pipeline_flags2)
            } else {
                pipeline_info
            };
            let pipelines =
                unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                    .vk_check("vkCreateGraphicsPipelines")?;
            Unique::new(device, pipelines.0[0])
        };

        Ok(Self {
            context,
            render_width,
            render_height,
            color_attachment_format,
            group_params,
            topology,
            layers,
            data,
            pipeline,
            pipeline_layout,
            color_target_image,
            color_target_view,
            vertex_buffer,
            cmd_pool,
            cmd_buffer,
            sec_cmd_buffer,
            nested_cmd_buffer,
            framebuffer,
            render_pass,
        })
    }

    /// The same with upstream's default arguments: 1 layer, a 256x256 target.
    pub fn new_default(
        context: &'a Context<'a>,
        vertex_shader_name: &str,
        fragment_shader_name: &str,
        group_params: GroupParams,
        topology: vk::PrimitiveTopology,
        data: Vec<VertexElementData>,
    ) -> Result<Self, TestError> {
        Self::new(
            context,
            vertex_shader_name,
            fragment_shader_name,
            group_params,
            topology,
            1,
            DEFAULT_RENDER_SIZE,
            DEFAULT_RENDER_SIZE,
            data,
        )
    }

    /// `DrawTestsBaseClass::getDefaultViewMask`
    pub fn get_default_view_mask(&self) -> u32 {
        default_view_mask(self.layers)
    }

    pub fn render_pass_handle(&self) -> vk::RenderPass {
        self.render_pass
            .as_ref()
            .map_or_else(vk::RenderPass::null, |pass| **pass)
    }

    pub fn framebuffer_handle(&self) -> vk::Framebuffer {
        self.framebuffer
            .as_ref()
            .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer)
    }

    fn render_area(&self) -> vk::Rect2D {
        vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: self.render_width,
                height: self.render_height,
            },
        }
    }

    /// `DrawTestsBaseClass::preRenderBarriers`
    pub fn pre_render_barriers(&self) {
        let device = self.context.get_device();
        let cmd_buffer = *self.cmd_buffer;
        let clear_color = vk::ClearColorValue {
            float32: [0.0, 0.0, 0.0, 1.0],
        };

        initial_transition_color_2d_image(
            device,
            cmd_buffer,
            self.color_target_image.get(),
            vk::ImageLayout::GENERAL,
            vk::AccessFlags::TRANSFER_WRITE,
            vk::PipelineStageFlags::TRANSFER,
            self.layers,
        );

        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let mem_barrier = make_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        );
        unsafe {
            device.cmd_clear_color_image(
                cmd_buffer,
                self.color_target_image.get(),
                vk::ImageLayout::GENERAL,
                &clear_color,
                &[subresource_range],
            );
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[mem_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }

    /// `DrawTestsBaseClass::beginLegacyRender`
    pub fn begin_legacy_render(&self, cmd_buffer: vk::CommandBuffer, content: vk::SubpassContents) {
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(self.render_pass_handle())
            .framebuffer(self.framebuffer_handle())
            .render_area(self.render_area());
        unsafe {
            self.context
                .get_device()
                .cmd_begin_render_pass(cmd_buffer, &begin_info, content)
        };
    }

    /// `DrawTestsBaseClass::endLegacyRender`
    pub fn end_legacy_render(&self, cmd_buffer: vk::CommandBuffer) {
        unsafe { self.context.get_device().cmd_end_render_pass(cmd_buffer) };
    }

    /// `DrawTestsBaseClass::beginSecondaryCmdBuffer`
    pub fn begin_secondary_cmd_buffer(&self, rendering_flags: vk::RenderingFlags) -> Result<(), TestError> {
        let sec_cmd_buffer = self
            .sec_cmd_buffer
            .as_ref()
            .expect("the secondary command buffer is only allocated for useSecondaryCmdBuffer");
        self.begin_inheriting_cmd_buffer(**sec_cmd_buffer, rendering_flags)
    }

    /// `beginNestedCmdBuffer` of the basic draw tests: the same inheritance as `begin_secondary_cmd_buffer`, for the
    /// buffer the secondary one is nested in.
    pub fn begin_nested_cmd_buffer(&self, rendering_flags: vk::RenderingFlags) -> Result<(), TestError> {
        let nested_cmd_buffer = self
            .nested_cmd_buffer
            .as_ref()
            .expect("the nested command buffer is only allocated for nestedSecondaryCmdBuffer");
        self.begin_inheriting_cmd_buffer(**nested_cmd_buffer, rendering_flags)
    }

    fn begin_inheriting_cmd_buffer(
        &self,
        target: vk::CommandBuffer,
        rendering_flags: vk::RenderingFlags,
    ) -> Result<(), TestError> {
        let color_formats = [self.color_attachment_format];
        let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
            .flags(rendering_flags)
            .view_mask(self.get_default_view_mask())
            .color_attachment_formats(&color_formats)
            .depth_attachment_format(vk::Format::UNDEFINED)
            .stencil_attachment_format(vk::Format::UNDEFINED)
            .rasterization_samples(vk::SampleCountFlags::_1);
        let buffer_inheritance_info =
            vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);

        let mut usage_flags = vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT;
        if !self
            .group_params
            .secondary_cmd_buffer_completely_contains_dynamic_renderpass
        {
            usage_flags |= vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE;
        }

        let begin_info = vk::CommandBufferBeginInfo::builder()
            .flags(usage_flags)
            .inheritance_info(&buffer_inheritance_info);
        unsafe { self.context.get_device().begin_command_buffer(target, &begin_info) }.vk_check("vkBeginCommandBuffer")
    }

    /// `DrawTestsBaseClass::beginDynamicRender`
    pub fn begin_dynamic_render(&self, cmd_buffer: vk::CommandBuffer, rendering_flags: vk::RenderingFlags) {
        let clear_value = vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 1.0],
            },
        };
        let color_attachments = [vk::RenderingAttachmentInfo::builder()
            .image_view(*self.color_target_view)
            .image_layout(vk::ImageLayout::GENERAL)
            .resolve_mode(vk::ResolveModeFlags::NONE)
            .load_op(vk::AttachmentLoadOp::LOAD)
            .store_op(vk::AttachmentStoreOp::STORE)
            .clear_value(clear_value)
            .build()];
        let rendering_info = vk::RenderingInfo::builder()
            .flags(rendering_flags)
            .render_area(self.render_area())
            .layer_count(self.layers)
            .view_mask(self.get_default_view_mask())
            .color_attachments(&color_attachments);
        unsafe {
            self.context
                .get_device()
                .cmd_begin_rendering(cmd_buffer, &rendering_info)
        };
    }

    /// `DrawTestsBaseClass::endDynamicRender`
    pub fn end_dynamic_render(&self, cmd_buffer: vk::CommandBuffer) {
        unsafe { self.context.get_device().cmd_end_rendering(cmd_buffer) };
    }

    /// `Draw::Image::readSurface` for the colour target: copies mip 0 of layer 0, which the base class leaves in
    /// `layout`, to a host buffer and returns it as an RGBA8 level.
    pub fn read_color_surface(&self, queue: vk::Queue, layout: vk::ImageLayout) -> Result<TextureLevel, TestError> {
        let device = self.context.get_device();
        let alloc = self.context.get_default_allocator();
        let size = (self.render_width * self.render_height) as vk::DeviceSize * 4;

        let staging = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let read_cmd_buffer = allocate_command_buffer(device, *self.cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let to_transfer = make_image_memory_barrier(
            vk::AccessFlags::MEMORY_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            layout,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            self.color_target_image.get(),
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        );
        let back_to_layout = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_READ,
            vk::AccessFlags::MEMORY_READ | vk::AccessFlags::MEMORY_WRITE,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            layout,
            self.color_target_image.get(),
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        );
        let copy_region = make_buffer_image_copy(
            vk::Extent3D {
                width: self.render_width,
                height: self.render_height,
                depth: 1,
            },
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );
        let to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);

        begin_command_buffer(device, *read_cmd_buffer)?;
        unsafe {
            device.cmd_pipeline_barrier(
                *read_cmd_buffer,
                vk::PipelineStageFlags::ALL_COMMANDS,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_transfer],
            );
            device.cmd_copy_image_to_buffer(
                *read_cmd_buffer,
                self.color_target_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                staging.get(),
                &[copy_region],
            );
            device.cmd_pipeline_barrier(
                *read_cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST | vk::PipelineStageFlags::ALL_COMMANDS,
                vk::DependencyFlags::empty(),
                &[to_host],
                &[] as &[vk::BufferMemoryBarrier],
                &[back_to_layout],
            );
        }
        end_command_buffer(device, *read_cmd_buffer)?;
        submit_commands_and_wait(device, queue, *read_cmd_buffer)?;

        invalidate_alloc(device, staging.get_allocation())?;
        let mut level = TextureLevel::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            self.render_width,
            self.render_height,
            1,
        )?;
        let bytes = unsafe { std::slice::from_raw_parts(staging.get_allocation().get_host_ptr(), size as usize) };
        level.data_mut().copy_from_slice(bytes);
        Ok(level)
    }
}

/// `DrawTestsBaseClass::getDefaultViewMask`
pub fn default_view_mask(layers: u32) -> u32 {
    if layers > 1 { (1u32 << layers) - 1 } else { 0 }
}

impl DrawTestsBase<'_> {
    /// The recording every simple draw test repeats in `iterate`: the draw commands go to a secondary command buffer,
    /// a primary one or a render pass, depending on the group parameters. `draw` is called with the vertex buffer
    /// and pipeline already bound; the command buffer is submitted before this returns.
    pub fn record_and_submit(
        &self,
        queue: vk::Queue,
        draw: impl FnMut(vk::CommandBuffer) -> Result<(), TestError>,
    ) -> Result<(), TestError> {
        self.record_and_submit_with_post(queue, draw, |_| {})
    }

    /// `record_and_submit` with `post` recorded into the primary command buffer after rendering has ended.
    pub fn record_and_submit_with_post(
        &self,
        queue: vk::Queue,
        draw: impl FnMut(vk::CommandBuffer) -> Result<(), TestError>,
        post: impl FnOnce(vk::CommandBuffer),
    ) -> Result<(), TestError> {
        self.record_commands(draw, post)?;
        submit_commands_and_wait(self.context.get_device(), queue, *self.cmd_buffer)
    }

    /// `record_and_submit_with_post` up to, and not including, the submission: the primary command buffer is left recorded.
    pub fn record_commands(
        &self,
        draw: impl FnMut(vk::CommandBuffer) -> Result<(), TestError>,
        post: impl FnOnce(vk::CommandBuffer),
    ) -> Result<(), TestError> {
        self.record_commands_hooked(|_| {}, |_| {}, draw, post)
    }

    /// `record_commands` with `before_barriers` recorded into the primary command buffer ahead of `preRenderBarriers` and
    /// `after_barriers` right after it.
    pub fn record_commands_hooked(
        &self,
        before_barriers: impl FnOnce(vk::CommandBuffer),
        after_barriers: impl FnOnce(vk::CommandBuffer),
        mut draw: impl FnMut(vk::CommandBuffer) -> Result<(), TestError>,
        post: impl FnOnce(vk::CommandBuffer),
    ) -> Result<(), TestError> {
        let device = self.context.get_device();
        let cmd_buffer = *self.cmd_buffer;
        let vertex_buffer = self.vertex_buffer.as_ref().map(|buffer| buffer.get());
        let bind = |cmd: vk::CommandBuffer| unsafe {
            if let Some(vertex_buffer) = vertex_buffer {
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer], &[0]);
            }
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *self.pipeline);
        };
        let params = self.group_params;

        if params.use_secondary_cmd_buffer {
            let sec_cmd_buffer = **self.sec_cmd_buffer.as_ref().expect("secondary command buffer");
            let contains_render_pass = params.secondary_cmd_buffer_completely_contains_dynamic_renderpass;

            // record secondary command buffer
            if contains_render_pass {
                self.begin_secondary_cmd_buffer(vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS)?;
                self.begin_dynamic_render(sec_cmd_buffer, vk::RenderingFlags::empty());
            } else {
                self.begin_secondary_cmd_buffer(vk::RenderingFlags::empty())?;
            }

            bind(sec_cmd_buffer);
            draw(sec_cmd_buffer)?;

            if contains_render_pass {
                self.end_dynamic_render(sec_cmd_buffer);
            }
            end_command_buffer(device, sec_cmd_buffer)?;

            let executed_cmd_buffer = if params.nested_secondary_cmd_buffer {
                // record buffer to nest secondary buffer in
                let nested_cmd_buffer = **self.nested_cmd_buffer.as_ref().expect("nested command buffer");
                self.begin_nested_cmd_buffer(
                    vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS | vk::RenderingFlags::CONTENTS_INLINE_KHR,
                )?;
                unsafe { device.cmd_execute_commands(nested_cmd_buffer, &[sec_cmd_buffer]) };
                end_command_buffer(device, nested_cmd_buffer)?;
                nested_cmd_buffer
            } else {
                sec_cmd_buffer
            };

            // record primary command buffer
            begin_command_buffer(device, cmd_buffer)?;
            before_barriers(cmd_buffer);
            self.pre_render_barriers();
            after_barriers(cmd_buffer);

            if !contains_render_pass {
                self.begin_dynamic_render(cmd_buffer, vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS);
            }

            unsafe { device.cmd_execute_commands(cmd_buffer, &[executed_cmd_buffer]) };

            if !contains_render_pass {
                self.end_dynamic_render(cmd_buffer);
            }
            post(cmd_buffer);
            end_command_buffer(device, cmd_buffer)?;
        } else if params.use_dynamic_rendering {
            begin_command_buffer(device, cmd_buffer)?;
            before_barriers(cmd_buffer);
            self.pre_render_barriers();
            after_barriers(cmd_buffer);
            self.begin_dynamic_render(cmd_buffer, vk::RenderingFlags::empty());

            bind(cmd_buffer);
            draw(cmd_buffer)?;

            self.end_dynamic_render(cmd_buffer);
            post(cmd_buffer);
            end_command_buffer(device, cmd_buffer)?;
        } else {
            begin_command_buffer(device, cmd_buffer)?;
            before_barriers(cmd_buffer);
            self.pre_render_barriers();
            after_barriers(cmd_buffer);
            self.begin_legacy_render(cmd_buffer, vk::SubpassContents::INLINE);

            bind(cmd_buffer);
            draw(cmd_buffer)?;

            self.end_legacy_render(cmd_buffer);
            post(cmd_buffer);
            end_command_buffer(device, cmd_buffer)?;
        }
        Ok(())
    }

    /// The reference image most draw tests compare against: `background` everywhere except the rectangle
    /// `left..=right`, `bottom..=top` (in normalised device coordinates), which is `fill`.
    pub fn make_rect_reference(
        &self,
        background: [f32; 4],
        fill: [f32; 4],
        left: f64,
        right: f64,
        top: f64,
        bottom: f64,
    ) -> Result<TextureLevel, TestError> {
        let mut reference_frame = TextureLevel::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            self.render_width,
            self.render_height,
            1,
        )?;
        let frame_width = self.render_width;
        let frame_height = self.render_height;
        let mut access = reference_frame.get_access();

        for y in 0..frame_height {
            for x in 0..frame_width {
                access.set_pixel(background, x, y, 0);
            }
        }

        for y in 0..frame_height {
            let y_coord = (y as f64 / (0.5 * frame_height as f64)) as f32 - 1.0;

            for x in 0..frame_width {
                let x_coord = (x as f64 / (0.5 * frame_width as f64)) as f32 - 1.0;

                if f64::from(y_coord) >= bottom
                    && f64::from(y_coord) <= top
                    && f64::from(x_coord) >= left
                    && f64::from(x_coord) <= right
                {
                    access.set_pixel(fill, x, y, 0);
                }
            }
        }
        Ok(reference_frame)
    }

    /// `tcu::fuzzyCompare(..., 0.05f, COMPARE_LOG_RESULT)` of `reference` against the colour target.
    pub fn target_matches(&self, queue: vk::Queue, reference: &TextureLevel) -> Result<bool, TestError> {
        let rendered_frame = self.read_color_surface(queue, vk::ImageLayout::GENERAL)?;
        Ok(crate::tcu::fuzzy_image_compare::fuzzy_compare_ok(
            &reference.get_const_access(),
            &rendered_frame.get_const_access(),
            0.05,
        ) == Some(true))
    }

    /// `target_matches` as the `Pass`/`Fail` verdict most draw tests return.
    pub fn compare_with_target(
        &self,
        queue: vk::Queue,
        reference: &TextureLevel,
    ) -> Result<crate::tcu::TestStatus, TestError> {
        if !self.target_matches(queue, reference)? {
            return Ok(crate::tcu::TestStatus::fail("Fail"));
        }
        Ok(crate::tcu::TestStatus::pass("Pass"))
    }
}

/// A host-visible buffer holding a copy of `data`, flushed (`Draw::Buffer::createAndAlloc` + `deMemcpy` + `flushAlloc`).
pub fn create_host_buffer<'a, T: Copy>(
    context: &'a Context<'a>,
    data: &[T],
    usage: vk::BufferUsageFlags,
) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let size = std::mem::size_of_val(data) as vk::DeviceSize;
    let memory_requirement = if usage.contains(vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS) {
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS
    } else {
        MemoryRequirement::HOST_VISIBLE
    };
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(size, usage),
        memory_requirement,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            data.as_ptr().cast::<u8>(),
            buffer.get_allocation().get_host_ptr(),
            size as usize,
        )
    };
    flush_alloc(device, buffer.get_allocation())?;
    Ok(buffer)
}

/// `create_host_buffer` for the maintenance5 cases: the usage is given in a `VkBufferUsageFlags2CreateInfo` and `VkBufferCreateInfo::usage`
/// holds the bad value `0xBAD00000`, which has to be ignored.
pub fn create_host_buffer_maintenance5<'a, T: Copy>(
    context: &'a Context<'a>,
    data: &[T],
    usage: vk::BufferUsageFlags2,
) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let size = std::mem::size_of_val(data) as vk::DeviceSize;
    let usage_flags2 = vk::BufferUsageFlags2CreateInfo {
        usage,
        ..Default::default()
    };
    let bad_usage = unsafe { vk::BufferUsageFlags::from_bits_unchecked(0xBAD0_0000) };
    let mut info = make_buffer_create_info(size, bad_usage);
    info.next = (&usage_flags2 as *const vk::BufferUsageFlags2CreateInfo).cast::<std::ffi::c_void>();
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        info,
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            data.as_ptr().cast::<u8>(),
            buffer.get_allocation().get_host_ptr(),
            size as usize,
        )
    };
    flush_alloc(device, buffer.get_allocation())?;
    Ok(buffer)
}
