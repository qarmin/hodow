// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassUnusedClearAttachmentTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Copyright (c) 2019 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `vkCmdClearAttachments` names attachments by their index in the *subpass*, not in the
// render pass, and a subpass slot may be VK_ATTACHMENT_UNUSED. Clearing such a slot has
// to be a no-op rather than an out-of-bounds write into whatever image happens to be
// next. Every attachment is pre-filled with black (depth 1, stencil 0) outside the
// render pass; the clear then paints white (depth 0, stencil 255) through every subpass
// slot, and each image must have changed exactly if its slot was used.
//
// Nothing is ever drawn - the pipeline exists only because a render pass instance needs
// one bound before the clear.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat, map_vk_format};
use crate::tcu::{TestError, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, GraphicsPipelineStages, allocate_command_buffer, make_buffer_create_info, make_command_pool,
    make_framebuffer, make_graphics_pipeline_staged, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::tests::renderpass::group_params::{GroupParams, RenderingType};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The manifest declares its cases with this: the two shaders plus the bit pattern the
/// fragment shader's outputs were generated from, so the host can assert it picked the
/// right one.
pub struct UnusedClearProgram {
    pub name: &'static str,
    pub color_mask: u32,
    pub programs: BinaryCollection,
}

use crate::generated::shaders::renderpass_unused_clear::ALL_UNUSED_CLEAR_PROGRAM;

/// `COLOR_ATTACHMENTS_NUMBER` - maxColorAttachments is guaranteed to be at least 4.
const COLOR_ATTACHMENTS_NUMBER: usize = 4;
const FORMAT_COLOR: vk::Format = vk::Format::R8G8B8A8_UNORM;
const FORMAT_DEPTH: vk::Format = vk::Format::D32_SFLOAT;
const FORMAT_STENCIL: vk::Format = vk::Format::S8_UINT;
const FORMAT_DEPTH_STENCIL: vk::Format = vk::Format::D32_SFLOAT_S8_UINT;
const IMAGE_WIDTH: u32 = 32;
const IMAGE_HEIGHT: u32 = 32;
/// `VK_ATTACHMENT_UNUSED`
const ATTACHMENT_UNUSED: u32 = u32::MAX;

/// `DepthStencilType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum DepthStencilType {
    None,
    DepthOnly,
    StencilOnly,
    Both,
}

impl DepthStencilType {
    /// `getClearAspectMask` - which aspects the clear names, as opposed to which the
    /// format has.
    fn clear_aspect_mask(self) -> vk::ImageAspectFlags {
        let mut mask = vk::ImageAspectFlags::empty();
        if matches!(self, Self::DepthOnly | Self::Both) {
            mask |= vk::ImageAspectFlags::DEPTH;
        }
        if matches!(self, Self::StencilOnly | Self::Both) {
            mask |= vk::ImageAspectFlags::STENCIL;
        }
        mask
    }

    fn has_depth_stencil(self) -> bool {
        self != Self::None
    }

    /// `depthStencilTypeName`
    fn name(self, format: vk::Format) -> String {
        let format_name = match format {
            FORMAT_DEPTH => "d32",
            FORMAT_STENCIL => "s8",
            FORMAT_DEPTH_STENCIL => "d32s8",
            _ => "",
        };
        match self {
            Self::None => "nods".to_string(),
            Self::DepthOnly => format!("depthonly_{format_name}"),
            Self::StencilOnly => format!("stencilonly_{format_name}"),
            Self::Both => format!("depthstencil_{format_name}"),
        }
    }

    /// `getFormats` - the combined format is always tested, and the single-aspect
    /// types get their dedicated format as well.
    fn formats(self) -> Vec<vk::Format> {
        match self {
            Self::None => vec![vk::Format::UNDEFINED],
            Self::DepthOnly => vec![FORMAT_DEPTH_STENCIL, FORMAT_DEPTH],
            Self::StencilOnly => vec![FORMAT_DEPTH_STENCIL, FORMAT_STENCIL],
            Self::Both => vec![FORMAT_DEPTH_STENCIL],
        }
    }
}

/// `getFormatAspectMask` - what the format actually has, which is what the image view
/// and the copies have to name.
fn format_aspect_mask(format: vk::Format) -> vk::ImageAspectFlags {
    let Some(tcu_format) = map_vk_format(format) else {
        return vk::ImageAspectFlags::COLOR;
    };
    let mut mask = vk::ImageAspectFlags::empty();
    if crate::tcu::pixel::has_depth_component(tcu_format.order) {
        mask |= vk::ImageAspectFlags::DEPTH;
    }
    if crate::tcu::pixel::has_stencil_component(tcu_format.order) {
        mask |= vk::ImageAspectFlags::STENCIL;
    }
    if mask.is_empty() {
        mask |= vk::ImageAspectFlags::COLOR;
    }
    mask
}

/// `TestParams`
struct TestParams {
    color_used: Vec<bool>,
    depth_stencil_type: DepthStencilType,
    depth_stencil_used: bool,
    depth_stencil_format: vk::Format,
    group_params: GroupParams,
}

pub struct UnusedClearAttachmentTest {
    name: String,
    params: TestParams,
}

impl UnusedClearAttachmentTest {
    fn program(&self) -> &'static UnusedClearProgram {
        let mask = self
            .params
            .color_used
            .iter()
            .enumerate()
            .fold(0u32, |m, (i, used)| if *used { m | (1 << i) } else { m });
        ALL_UNUSED_CLEAR_PROGRAM
            .iter()
            .copied()
            .find(|p| p.color_mask == mask)
            .expect("the generator covers every bit pattern")
    }
}

impl TestCase for UnusedClearAttachmentTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if self.params.group_params.rendering_type == RenderingType::DynamicRendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }

        if self.params.group_params.rendering_type == RenderingType::RenderPass2 {
            context.require_device_functionality("VK_KHR_create_renderpass2")?;
        }

        if !self.params.color_used.is_empty() {
            check_format_supported(context, FORMAT_COLOR, vk::ImageUsageFlags::COLOR_ATTACHMENT)?;
        }
        if self.params.depth_stencil_type.has_depth_stencil() {
            check_format_supported(
                context,
                self.params.depth_stencil_format,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT,
            )?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.program().programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(UnusedClearAttachmentTestInstance {
            context,
            params: &self.params,
        })
    }
}

/// `checkFormatSupported`
fn check_format_supported(context: &Context, format: vk::Format, usage: vk::ImageUsageFlags) -> Result<(), TestError> {
    let result = unsafe {
        context.get_instance().get_physical_device_image_format_properties(
            context.get_physical_device(),
            format,
            vk::ImageType::_2D,
            vk::ImageTiling::OPTIMAL,
            usage,
            vk::ImageCreateFlags::empty(),
        )
    };
    match result {
        Ok(_) => Ok(()),
        Err(_) => Err(TestError::NotSupported(format!(
            "Format {format:?} not supported for usage flags {usage:?}"
        ))),
    }
}

struct UnusedClearAttachmentTestInstance<'a> {
    context: &'a Context<'a>,
    params: &'a TestParams,
}

impl TestInstance for UnusedClearAttachmentTestInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_index = self.context.get_universal_queue_family_index();

        let mut color_images = Vec::new();
        let mut color_views = Vec::new();
        for _ in &p.color_used {
            let info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(FORMAT_COLOR)
                .extent(vk::Extent3D {
                    width: IMAGE_WIDTH,
                    height: IMAGE_HEIGHT,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
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
            let image = ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)?;
            let view = make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                FORMAT_COLOR,
                vk::ImageSubresourceRange {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    base_mip_level: 0,
                    level_count: 1,
                    base_array_layer: 0,
                    layer_count: 1,
                },
            )?;
            color_images.push(image);
            color_views.push(view);
        }

        let ds_aspect = format_aspect_mask(p.depth_stencil_format);
        let depth_resources = if p.depth_stencil_type.has_depth_stencil() {
            let info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(p.depth_stencil_format)
                .extent(vk::Extent3D {
                    width: IMAGE_WIDTH,
                    height: IMAGE_HEIGHT,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(
                    vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
                        | vk::ImageUsageFlags::TRANSFER_SRC
                        | vk::ImageUsageFlags::TRANSFER_DST,
                )
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            let image = ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)?;
            let view = make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                p.depth_stencil_format,
                vk::ImageSubresourceRange {
                    aspect_mask: ds_aspect,
                    base_mip_level: 0,
                    level_count: 1,
                    base_array_layer: 0,
                    layer_count: 1,
                },
            )?;
            Some((image, view))
        } else {
            None
        };

        // Fill every attachment before the render pass, so "the clear did nothing"
        // and "the clear wrote the wrong image" are distinguishable afterwards.
        self.initialize_attachments(
            &color_images,
            depth_resources.as_ref().map(|(i, _)| i),
            ds_aspect,
            queue,
            queue_index,
        )?;

        // Neither a render pass nor a framebuffer is built for dynamic rendering.
        let dynamic_rendering = p.group_params.rendering_type == RenderingType::DynamicRendering;
        let render_pass = (!dynamic_rendering).then(|| self.create_render_pass()).transpose()?;
        let mut framebuffer_views: Vec<vk::ImageView> = color_views.iter().map(|v| **v).collect();
        if let Some((_, view)) = &depth_resources {
            framebuffer_views.push(**view);
        }
        let framebuffer = render_pass
            .as_ref()
            .map(|render_pass| {
                make_framebuffer(device, **render_pass, &framebuffer_views, IMAGE_WIDTH, IMAGE_HEIGHT, 1)
            })
            .transpose()?;
        let raw_render_pass = render_pass.as_deref().copied().unwrap_or_else(vk::RenderPass::null);

        let program = ALL_UNUSED_CLEAR_PROGRAM
            .iter()
            .copied()
            .find(|prog| {
                prog.color_mask
                    == p.color_used
                        .iter()
                        .enumerate()
                        .fold(0u32, |m, (i, used)| if *used { m | (1 << i) } else { m })
            })
            .expect("the generator covers every bit pattern");
        let vertex_module = create_shader_module(device, program.programs.get("vert_shader")?)?;
        let fragment_module = create_shader_module(device, program.programs.get("frag_shader")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let has_depth = matches!(
            p.depth_stencil_type,
            DepthStencilType::Both | DepthStencilType::DepthOnly
        );
        let has_stencil = matches!(
            p.depth_stencil_type,
            DepthStencilType::Both | DepthStencilType::StencilOnly
        );
        let color_attachment_formats = vec![FORMAT_COLOR; p.color_used.len()];
        let mut rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
            .view_mask(0)
            .color_attachment_formats(&color_attachment_formats)
            .depth_attachment_format(if has_depth {
                p.depth_stencil_format
            } else {
                vk::Format::UNDEFINED
            })
            .stencil_attachment_format(if has_stencil {
                p.depth_stencil_format
            } else {
                vk::Format::UNDEFINED
            });

        let pipeline = make_graphics_pipeline_staged(
            device,
            *pipeline_layout,
            GraphicsPipelineStages {
                vertex: *vertex_module,
                fragment: *fragment_module,
                tessellation_control: None,
                tessellation_evaluation: None,
                geometry: None,
            },
            raw_render_pass,
            (IMAGE_WIDTH, IMAGE_HEIGHT),
            vk::PrimitiveTopology::TRIANGLE_LIST,
            vk::SampleCountFlags::_1,
            None,
            p.color_used.len(),
            None,
            dynamic_rendering.then_some(&mut rendering_create_info),
        )?;

        // `createCommandBuffer` - one clear naming every subpass slot, used or not.
        let command_pool = make_command_pool(device, queue_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        let mut clear_attachments: Vec<vk::ClearAttachment> = (0..p.color_used.len())
            .map(|i| vk::ClearAttachment {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                color_attachment: i as u32,
                clear_value: vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: [1.0, 1.0, 1.0, 1.0],
                    },
                },
            })
            .collect();
        if p.depth_stencil_type.has_depth_stencil() {
            clear_attachments.push(vk::ClearAttachment {
                aspect_mask: p.depth_stencil_type.clear_aspect_mask(),
                color_attachment: 0,
                clear_value: vk::ClearValue {
                    depth_stencil: vk::ClearDepthStencilValue {
                        depth: 0.0,
                        stencil: 255,
                    },
                },
            });
        }
        let clear_rect = [vk::ClearRect {
            rect: vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: IMAGE_WIDTH,
                    height: IMAGE_HEIGHT,
                },
            },
            base_array_layer: 0,
            layer_count: 1,
        }];

        let _secondary = if dynamic_rendering {
            self.record_dynamic_rendering(
                *command_pool,
                *command_buffer,
                *pipeline,
                &color_views,
                depth_resources.as_ref().map(|(_, view)| **view),
                &clear_attachments,
                &clear_rect,
            )?
        } else {
            begin_command_buffer(device, *command_buffer)?;
            self.begin_render_pass(
                *command_buffer,
                raw_render_pass,
                **framebuffer
                    .as_ref()
                    .expect("a render pass was built, so a framebuffer was too"),
            );
            unsafe {
                device.cmd_bind_pipeline(*command_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                if !clear_attachments.is_empty() {
                    device.cmd_clear_attachments(*command_buffer, &clear_attachments, &clear_rect);
                }
            }
            self.end_render_pass(*command_buffer);
            end_command_buffer(device, *command_buffer)?;
            None
        };
        submit_commands_and_wait(device, queue, *command_buffer)?;

        // Read the attachments back and compare against what their subpass slot said.
        let color_pixels = self.read_color_attachments(&color_images, queue, queue_index)?;
        for (i, (pixels, used)) in color_pixels.iter().zip(&p.color_used).enumerate() {
            let reference = if *used { [1.0f32; 4] } else { [0.0, 0.0, 0.0, 1.0] };
            let access = ConstPixelBufferAccess::new(
                TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
                [IMAGE_WIDTH, IMAGE_HEIGHT, 1],
                pixels,
            );
            for y in 0..IMAGE_HEIGHT {
                for x in 0..IMAGE_WIDTH {
                    let color = access.get_pixel(x, y, 0);
                    if color.iter().zip(reference).any(|(c, r)| (c - r).abs() > 0.01) {
                        return Ok(TestStatus::fail(format!(
                            "Attachment {i} with mismatched pixel ({x}, {y}): expecting pixel value {reference:?} and found {color:?}"
                        )));
                    }
                }
            }
        }

        if let Some((image, _)) = &depth_resources {
            let depth_only = p.depth_stencil_type == DepthStencilType::DepthOnly;
            let stencil_only = p.depth_stencil_type == DepthStencilType::StencilOnly;

            if !stencil_only {
                let pixels = self.read_depth_stencil_attachment(
                    image.get(),
                    vk::ImageAspectFlags::DEPTH,
                    4,
                    queue,
                    queue_index,
                )?;
                let reference = if p.depth_stencil_used { 0.0f32 } else { 1.0f32 };
                let access = ConstPixelBufferAccess::new(
                    TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT),
                    [IMAGE_WIDTH, IMAGE_HEIGHT, 1],
                    &pixels,
                );
                for y in 0..IMAGE_HEIGHT {
                    for x in 0..IMAGE_WIDTH {
                        let value = access.get_pix_depth(x, y, 0);
                        if (value - reference).abs() > 0.001 {
                            return Ok(TestStatus::fail(format!(
                                "Depth/stencil attachment with mismatched depth value at pixel ({x}, {y}): expected value {reference} and found {value}"
                            )));
                        }
                    }
                }
            }

            if !depth_only {
                let pixels = self.read_depth_stencil_attachment(
                    image.get(),
                    vk::ImageAspectFlags::STENCIL,
                    1,
                    queue,
                    queue_index,
                )?;
                let reference = if p.depth_stencil_used { 255u32 } else { 0u32 };
                let access = ConstPixelBufferAccess::new(
                    TextureFormat::new(ChannelOrder::S, ChannelType::UNSIGNED_INT8),
                    [IMAGE_WIDTH, IMAGE_HEIGHT, 1],
                    &pixels,
                );
                for y in 0..IMAGE_HEIGHT {
                    for x in 0..IMAGE_WIDTH {
                        let value = access.get_pix_stencil(x, y, 0);
                        if value != reference {
                            return Ok(TestStatus::fail(format!(
                                "Depth/stencil attachment with mismatched stencil value at pixel ({x}, {y}): expected value {reference} and found {value}"
                            )));
                        }
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl UnusedClearAttachmentTestInstance<'_> {
    /// The "clear image and leave it prepared to be used as an attachment" step the
    /// upstream constructor runs per image.
    fn initialize_attachments(
        &self,
        color_images: &[ImageWithMemory<'_>],
        depth_image: Option<&ImageWithMemory<'_>>,
        ds_aspect: vk::ImageAspectFlags,
        queue: vk::Queue,
        queue_index: u32,
    ) -> Result<(), TestError> {
        let device = self.context.get_device();
        let command_pool = make_command_pool(device, queue_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        let range = |aspect_mask| vk::ImageSubresourceRange {
            aspect_mask,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: 0,
            layer_count: 1,
        };
        let barrier = |image: vk::Image, aspect_mask, src_access, dst_access, old_layout, new_layout| {
            vk::ImageMemoryBarrier::builder()
                .src_access_mask(src_access)
                .dst_access_mask(dst_access)
                .old_layout(old_layout)
                .new_layout(new_layout)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .image(image)
                .subresource_range(range(aspect_mask))
                .build()
        };

        begin_command_buffer(device, *command_buffer)?;
        for image in color_images {
            let pre = barrier(
                image.get(),
                vk::ImageAspectFlags::COLOR,
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            );
            let post = barrier(
                image.get(),
                vk::ImageAspectFlags::COLOR,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    *command_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre],
                );
                device.cmd_clear_color_image(
                    *command_buffer,
                    image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &vk::ClearColorValue {
                        float32: [0.0, 0.0, 0.0, 1.0],
                    },
                    &[range(vk::ImageAspectFlags::COLOR)],
                );
                device.cmd_pipeline_barrier(
                    *command_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::FRAGMENT_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[post],
                );
            }
        }

        if let Some(image) = depth_image {
            let pre = barrier(
                image.get(),
                ds_aspect,
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            );
            let post = barrier(
                image.get(),
                ds_aspect,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    *command_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre],
                );
                device.cmd_clear_depth_stencil_image(
                    *command_buffer,
                    image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &vk::ClearDepthStencilValue { depth: 1.0, stencil: 0 },
                    &[range(ds_aspect)],
                );
                device.cmd_pipeline_barrier(
                    *command_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::FRAGMENT_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[post],
                );
            }
        }
        end_command_buffer(device, *command_buffer)?;
        submit_commands_and_wait(device, queue, *command_buffer)
    }

    /// `createRenderPass`. The attachment descriptions cover every image; the subpass
    /// references are what mark a slot unused.
    fn create_render_pass(&self) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        let p = self.params;
        let device = self.context.get_device();

        let color_description = vk::AttachmentDescription {
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: FORMAT_COLOR,
            samples: vk::SampleCountFlags::_1,
            load_op: vk::AttachmentLoadOp::LOAD,
            store_op: vk::AttachmentStoreOp::STORE,
            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
            initial_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        };
        let mut attachments = vec![color_description; p.color_used.len()];

        if p.depth_stencil_type.has_depth_stencil() {
            // The aspect the test does not exercise is left DONT_CARE, so a driver
            // that writes it anyway has nothing to preserve it from.
            let depth_only = p.depth_stencil_type == DepthStencilType::DepthOnly;
            let stencil_only = p.depth_stencil_type == DepthStencilType::StencilOnly;
            attachments.push(vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: p.depth_stencil_format,
                samples: vk::SampleCountFlags::_1,
                load_op: if stencil_only {
                    vk::AttachmentLoadOp::DONT_CARE
                } else {
                    vk::AttachmentLoadOp::LOAD
                },
                store_op: if stencil_only {
                    vk::AttachmentStoreOp::DONT_CARE
                } else {
                    vk::AttachmentStoreOp::STORE
                },
                stencil_load_op: if depth_only {
                    vk::AttachmentLoadOp::DONT_CARE
                } else {
                    vk::AttachmentLoadOp::LOAD
                },
                stencil_store_op: if depth_only {
                    vk::AttachmentStoreOp::DONT_CARE
                } else {
                    vk::AttachmentStoreOp::STORE
                },
                initial_layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                final_layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            });
        }

        let color_references: Vec<vk::AttachmentReference> = p
            .color_used
            .iter()
            .enumerate()
            .map(|(i, used)| vk::AttachmentReference {
                attachment: if *used { i as u32 } else { ATTACHMENT_UNUSED },
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            })
            .collect();
        let depth_reference = vk::AttachmentReference {
            attachment: if p.depth_stencil_used {
                p.color_used.len() as u32
            } else {
                ATTACHMENT_UNUSED
            },
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        };

        if p.group_params.rendering_type == RenderingType::RenderPass2 {
            return self.create_render_pass2(&attachments, &color_references, &depth_reference);
        }

        let mut subpass = vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_references);
        if p.depth_stencil_type.has_depth_stencil() {
            subpass = subpass.depth_stencil_attachment(&depth_reference);
        }
        let subpasses = [subpass.build()];
        let info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let handle = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
        Ok(Unique::new(device, handle))
    }

    /// The `vkCreateRenderPass2` half of `createRenderPass`.
    fn create_render_pass2(
        &self,
        attachments: &[vk::AttachmentDescription],
        color_references: &[vk::AttachmentReference],
        depth_reference: &vk::AttachmentReference,
    ) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
        let p = self.params;
        let device = self.context.get_device();

        let attachments2: Vec<vk::AttachmentDescription2> = attachments
            .iter()
            .map(|a| vk::AttachmentDescription2 {
                s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: a.flags,
                format: a.format,
                samples: a.samples,
                load_op: a.load_op,
                store_op: a.store_op,
                stencil_load_op: a.stencil_load_op,
                stencil_store_op: a.stencil_store_op,
                initial_layout: a.initial_layout,
                final_layout: a.final_layout,
            })
            .collect();

        let color_references2: Vec<vk::AttachmentReference2> = color_references
            .iter()
            .map(|r| vk::AttachmentReference2 {
                s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                next: std::ptr::null(),
                attachment: r.attachment,
                layout: r.layout,
                aspect_mask: vk::ImageAspectFlags::COLOR,
            })
            .collect();
        let depth_reference2 = vk::AttachmentReference2 {
            s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
            next: std::ptr::null(),
            attachment: depth_reference.attachment,
            layout: depth_reference.layout,
            aspect_mask: p.depth_stencil_type.clear_aspect_mask(),
        };

        let subpass = vk::SubpassDescription2 {
            s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
            next: std::ptr::null(),
            flags: vk::SubpassDescriptionFlags::empty(),
            pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
            view_mask: 0,
            input_attachment_count: 0,
            input_attachments: std::ptr::null(),
            color_attachment_count: color_references2.len() as u32,
            color_attachments: if color_references2.is_empty() {
                std::ptr::null()
            } else {
                color_references2.as_ptr()
            },
            resolve_attachments: std::ptr::null(),
            depth_stencil_attachment: if p.depth_stencil_type.has_depth_stencil() {
                &depth_reference2
            } else {
                std::ptr::null()
            },
            preserve_attachment_count: 0,
            preserve_attachments: std::ptr::null(),
        };

        let info = vk::RenderPassCreateInfo2 {
            s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
            next: std::ptr::null(),
            flags: vk::RenderPassCreateFlags::empty(),
            attachment_count: attachments2.len() as u32,
            attachments: if attachments2.is_empty() {
                std::ptr::null()
            } else {
                attachments2.as_ptr()
            },
            subpass_count: 1,
            subpasses: &subpass,
            dependency_count: 0,
            dependencies: std::ptr::null(),
            correlated_view_mask_count: 0,
            correlated_view_masks: std::ptr::null(),
        };
        let handle = unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?;
        Ok(Unique::new(device, handle))
    }

    /// The dynamic-rendering half of `createCommandBuffer`. Returns the secondary
    /// command buffer, which has to outlive the primary's submission.
    #[allow(clippy::too_many_arguments)]
    fn record_dynamic_rendering(
        &self,
        command_pool: vk::CommandPool,
        command_buffer: vk::CommandBuffer,
        pipeline: vk::Pipeline,
        color_views: &[Unique<'_, vk::ImageView>],
        depth_view: Option<vk::ImageView>,
        clear_attachments: &[vk::ClearAttachment],
        clear_rect: &[vk::ClearRect],
    ) -> Result<Option<UniqueCommandBuffer<'_>>, TestError> {
        use vulkanalia::vk::DeviceV1_3;

        let p = self.params;
        let device = self.context.get_device();

        let render_area = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: IMAGE_WIDTH,
                height: IMAGE_HEIGHT,
            },
        };
        let color_attachments: Vec<vk::RenderingAttachmentInfo> = color_views
            .iter()
            .zip(&p.color_used)
            .map(|(view, used)| {
                vk::RenderingAttachmentInfo::builder()
                    .image_view(if *used { **view } else { vk::ImageView::null() })
                    .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                    .resolve_mode(vk::ResolveModeFlags::NONE)
                    .resolve_image_view(vk::ImageView::null())
                    .resolve_image_layout(vk::ImageLayout::UNDEFINED)
                    .load_op(vk::AttachmentLoadOp::LOAD)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .clear_value(vk::ClearValue {
                        color: vk::ClearColorValue {
                            float32: [1.0, 1.0, 1.0, 1.0],
                        },
                    })
                    .build()
            })
            .collect();

        let depth_attachment = vk::RenderingAttachmentInfo::builder()
            .image_view(if p.depth_stencil_used {
                depth_view.unwrap_or_else(vk::ImageView::null)
            } else {
                vk::ImageView::null()
            })
            .image_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .resolve_mode(vk::ResolveModeFlags::NONE)
            .resolve_image_view(vk::ImageView::null())
            .resolve_image_layout(vk::ImageLayout::UNDEFINED)
            .load_op(vk::AttachmentLoadOp::LOAD)
            .store_op(vk::AttachmentStoreOp::STORE)
            .clear_value(vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue {
                    depth: 0.0,
                    stencil: 255,
                },
            })
            .build();

        let has_depth = matches!(
            p.depth_stencil_type,
            DepthStencilType::Both | DepthStencilType::DepthOnly
        ) && p.depth_stencil_used;
        let has_stencil = matches!(
            p.depth_stencil_type,
            DepthStencilType::Both | DepthStencilType::StencilOnly
        ) && p.depth_stencil_used;

        // An unused colour slot is VK_FORMAT_UNDEFINED here, unlike the pipeline's
        // rendering info, which names the format for every slot.
        let color_attachment_formats: Vec<vk::Format> = p
            .color_used
            .iter()
            .map(|used| if *used { FORMAT_COLOR } else { vk::Format::UNDEFINED })
            .collect();

        let make_rendering_info = |flags: vk::RenderingFlags| {
            let mut info = vk::RenderingInfo::builder()
                .flags(flags)
                .render_area(render_area)
                .layer_count(1)
                .view_mask(0)
                .color_attachments(&color_attachments);
            if has_depth {
                info = info.depth_attachment(&depth_attachment);
            }
            if has_stencil {
                info = info.stencil_attachment(&depth_attachment);
            }
            info
        };

        let completely_contains = p
            .group_params
            .secondary_cmd_buffer_completely_contains_dynamic_renderpass;

        if p.group_params.use_secondary_cmd_buffer {
            let sec_command_buffer = allocate_command_buffer(device, command_pool, vk::CommandBufferLevel::SECONDARY)?;

            // record secondary command buffer
            let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
                .flags(if completely_contains {
                    vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS
                } else {
                    vk::RenderingFlags::empty()
                })
                .view_mask(0)
                .color_attachment_formats(&color_attachment_formats)
                .depth_attachment_format(if has_depth {
                    p.depth_stencil_format
                } else {
                    vk::Format::UNDEFINED
                })
                .stencil_attachment_format(if has_stencil {
                    p.depth_stencil_format
                } else {
                    vk::Format::UNDEFINED
                })
                .rasterization_samples(vk::SampleCountFlags::_1);
            let inheritance_info =
                vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);
            let mut usage_flags = vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT;
            if !completely_contains {
                usage_flags |= vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE;
            }
            let begin_info = vk::CommandBufferBeginInfo::builder()
                .flags(usage_flags)
                .inheritance_info(&inheritance_info);
            unsafe { device.begin_command_buffer(*sec_command_buffer, &begin_info) }
                .vk_check("vkBeginCommandBuffer")?;

            if completely_contains {
                unsafe {
                    device.cmd_begin_rendering(*sec_command_buffer, &make_rendering_info(vk::RenderingFlags::empty()))
                };
            }

            unsafe {
                device.cmd_bind_pipeline(*sec_command_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline);
                if !clear_attachments.is_empty() {
                    device.cmd_clear_attachments(*sec_command_buffer, clear_attachments, clear_rect);
                }
            }

            if completely_contains {
                unsafe { device.cmd_end_rendering(*sec_command_buffer) };
            }
            end_command_buffer(device, *sec_command_buffer)?;

            // record primary command buffer
            begin_command_buffer(device, command_buffer)?;
            if !completely_contains {
                unsafe {
                    device.cmd_begin_rendering(
                        command_buffer,
                        &make_rendering_info(vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS),
                    )
                };
            }
            unsafe { device.cmd_execute_commands(command_buffer, &[*sec_command_buffer]) };
            if !completely_contains {
                unsafe { device.cmd_end_rendering(command_buffer) };
            }
            end_command_buffer(device, command_buffer)?;
            Ok(Some(sec_command_buffer))
        } else {
            begin_command_buffer(device, command_buffer)?;
            unsafe {
                device.cmd_begin_rendering(command_buffer, &make_rendering_info(vk::RenderingFlags::empty()));
                device.cmd_bind_pipeline(command_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline);
                if !clear_attachments.is_empty() {
                    device.cmd_clear_attachments(command_buffer, clear_attachments, clear_rect);
                }
                device.cmd_end_rendering(command_buffer);
            }
            end_command_buffer(device, command_buffer)?;
            Ok(None)
        }
    }

    fn begin_render_pass(
        &self,
        command_buffer: vk::CommandBuffer,
        render_pass: vk::RenderPass,
        framebuffer: vk::Framebuffer,
    ) {
        let device = self.context.get_device();
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(render_pass)
            .framebuffer(framebuffer)
            .render_area(vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: IMAGE_WIDTH,
                    height: IMAGE_HEIGHT,
                },
            })
            .build();

        if self.params.group_params.rendering_type == RenderingType::RenderPass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            let subpass_begin = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
            unsafe { device.cmd_begin_render_pass2_khr(command_buffer, &begin_info, &subpass_begin) };
        } else {
            unsafe { device.cmd_begin_render_pass(command_buffer, &begin_info, vk::SubpassContents::INLINE) };
        }
    }

    fn end_render_pass(&self, command_buffer: vk::CommandBuffer) {
        let device = self.context.get_device();
        if self.params.group_params.rendering_type == RenderingType::RenderPass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            let subpass_end = vk::SubpassEndInfo::builder();
            unsafe { device.cmd_end_render_pass2_khr(command_buffer, &subpass_end) };
        } else {
            unsafe { device.cmd_end_render_pass(command_buffer) };
        }
    }

    /// `pipeline::readColorAttachment` for each colour image at once.
    fn read_color_attachments(
        &self,
        images: &[ImageWithMemory<'_>],
        queue: vk::Queue,
        queue_index: u32,
    ) -> Result<Vec<Vec<u8>>, TestError> {
        let mut out = Vec::new();
        for image in images {
            out.push(self.read_attachment(
                image.get(),
                vk::ImageAspectFlags::COLOR,
                4,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                queue,
                queue_index,
            )?);
        }
        Ok(out)
    }

    /// `pipeline::readDepthAttachment` / `readStencilAttachment`.
    fn read_depth_stencil_attachment(
        &self,
        image: vk::Image,
        aspect_mask: vk::ImageAspectFlags,
        pixel_size: usize,
        queue: vk::Queue,
        queue_index: u32,
    ) -> Result<Vec<u8>, TestError> {
        self.read_attachment(
            image,
            aspect_mask,
            pixel_size,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            queue,
            queue_index,
        )
    }

    /// `readDepthAttachment`'s `barrierAspect`. A copy names one aspect, but the layout
    /// transition applies to the whole image, so a combined format has to name both -
    /// and a single-aspect one must not name the aspect it does not have.
    fn barrier_aspect_mask(&self, copy_aspect: vk::ImageAspectFlags) -> vk::ImageAspectFlags {
        if copy_aspect == vk::ImageAspectFlags::COLOR {
            copy_aspect
        } else {
            format_aspect_mask(self.params.depth_stencil_format)
        }
    }

    /// One aspect of one attachment, copied to a host-visible buffer. The image is
    /// returned to its attachment layout so a second aspect can be read after it.
    fn read_attachment(
        &self,
        image: vk::Image,
        aspect_mask: vk::ImageAspectFlags,
        pixel_size: usize,
        layout: vk::ImageLayout,
        queue: vk::Queue,
        queue_index: u32,
    ) -> Result<Vec<u8>, TestError> {
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let size = (IMAGE_WIDTH as usize) * (IMAGE_HEIGHT as usize) * pixel_size;
        let buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(size as u64, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let command_pool = make_command_pool(device, queue_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let range = vk::ImageSubresourceRange {
            aspect_mask: self.barrier_aspect_mask(aspect_mask),
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: 0,
            layer_count: 1,
        };

        begin_command_buffer(device, *command_buffer)?;
        unsafe {
            let to_src = vk::ImageMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::empty())
                .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
                .old_layout(layout)
                .new_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .image(image)
                .subresource_range(range)
                .build();
            device.cmd_pipeline_barrier(
                *command_buffer,
                vk::PipelineStageFlags::ALL_COMMANDS,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_src],
            );

            let region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: vk::ImageSubresourceLayers {
                    aspect_mask,
                    mip_level: 0,
                    base_array_layer: 0,
                    layer_count: 1,
                },
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: vk::Extent3D {
                    width: IMAGE_WIDTH,
                    height: IMAGE_HEIGHT,
                    depth: 1,
                },
            };
            device.cmd_copy_image_to_buffer(
                *command_buffer,
                image,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                buffer.get(),
                &[region],
            );

            let back = vk::ImageMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_READ)
                .dst_access_mask(vk::AccessFlags::empty())
                .old_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
                .new_layout(layout)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .image(image)
                .subresource_range(range)
                .build();
            let to_host = vk::BufferMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .buffer(buffer.get())
                .offset(0)
                .size(vk::WHOLE_SIZE)
                .build();
            device.cmd_pipeline_barrier(
                *command_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[to_host],
                &[back],
            );
        }
        end_command_buffer(device, *command_buffer)?;
        submit_commands_and_wait(device, queue, *command_buffer)?;

        invalidate_alloc(device, buffer.get_allocation())?;
        let mut out = vec![0u8; size];
        unsafe { std::ptr::copy_nonoverlapping(buffer.get_allocation().get_host_ptr(), out.as_mut_ptr(), size) };
        Ok(out)
    }
}

/// `getUsed`
fn used_name(value: bool) -> &'static str {
    if value { "used" } else { "unused" }
}

/// `getCombName`
fn comb_name(array: &[bool]) -> String {
    array
        .iter()
        .map(|used| format!("color{}", used_name(*used)))
        .collect::<Vec<_>>()
        .join("_")
}

/// `createRenderPassUnusedClearAttachmentTests`
pub fn create_unused_clear_attachment_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("unused_clear_attachments");

    for ds_type in [
        DepthStencilType::None,
        DepthStencilType::DepthOnly,
        DepthStencilType::StencilOnly,
        DepthStencilType::Both,
    ] {
        for ds_format in ds_type.formats() {
            for depth_stencil_use in [false, true] {
                // In dynamic rendering a secondary command buffer may not name a
                // depth/stencil format when the primary's rendering info has no
                // depth/stencil view (VUID-vkCmdExecuteCommands-pDepthAttachment-06774).
                if group_params.rendering_type == RenderingType::DynamicRendering
                    && ds_type != DepthStencilType::None
                    && !depth_stencil_use
                    && group_params.use_secondary_cmd_buffer
                    && !group_params.secondary_cmd_buffer_completely_contains_dynamic_renderpass
                {
                    continue;
                }

                let ds_case = ds_type.name(ds_format);

                // No colour attachments, a single one, and the maximum guaranteed.
                let counts: &[usize] = if ds_type.has_depth_stencil() {
                    &[0, 1, COLOR_ATTACHMENTS_NUMBER]
                } else {
                    &[1, COLOR_ATTACHMENTS_NUMBER]
                };
                for &count in counts {
                    if count == 0 {
                        let name = format!("{ds_case}_{}", used_name(depth_stencil_use));
                        group.add_child(Box::new(UnusedClearAttachmentTest {
                            name,
                            params: TestParams {
                                color_used: Vec::new(),
                                depth_stencil_type: ds_type,
                                depth_stencil_used: depth_stencil_use,
                                depth_stencil_format: ds_format,
                                group_params,
                            },
                        }) as Box<dyn TestCase>);
                        continue;
                    }

                    // `runCallbackOnCombination` - every used/unused pattern, in the
                    // order the recursion produces, which varies the last slot fastest.
                    for combination in 0..(1u32 << count) {
                        let color_used: Vec<bool> =
                            (0..count).map(|i| (combination >> (count - 1 - i)) & 1 == 1).collect();
                        let mut name = format!("{}_{ds_case}", comb_name(&color_used));
                        if ds_type.has_depth_stencil() {
                            name += &format!("_{}", used_name(depth_stencil_use));
                        }
                        group.add_child(Box::new(UnusedClearAttachmentTest {
                            name,
                            params: TestParams {
                                color_used,
                                depth_stencil_type: ds_type,
                                depth_stencil_used: depth_stencil_use,
                                depth_stencil_format: ds_format,
                                group_params,
                            },
                        }) as Box<dyn TestCase>);
                    }
                }

                // Without a depth/stencil attachment there is nothing for the
                // used/unused flag to mean, so only the first pass registers.
                if !ds_type.has_depth_stencil() {
                    break;
                }
            }
        }
    }

    group
}
