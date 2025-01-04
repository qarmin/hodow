// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassClearSomeAttachmentsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Both attachments are pre-filled outside the render pass; the render pass then clears
// only one of them through its load op and must leave the other one untouched.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::tests::renderpass::group_params::{GroupParams, RenderingType};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

const SIZE: u32 = 8;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// Colour and depth values the images are cleared to before the render pass.
const COLOR_CLEAR_IMAGE: [f32; 4] = [0.2, 0.8, 0.4, 0.6];
const DEPTH_CLEAR_IMAGE: f32 = 0.2;

/// Values the render pass's own load op clears to.
const COLOR_CLEAR_ATTACHMENT: [f32; 4] = [0.7, 0.1, 0.5, 0.3];
const DEPTH_CLEAR_ATTACHMENT: f32 = 0.7;
const STENCIL_CLEAR_ATTACHMENT: u32 = 2;

/// `TestMode`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestMode {
    ClearOnlyColor,
    ClearOnlyDepth,
}

pub struct ClearSomeAttachmentsTest {
    name: &'static str,
    group_params: GroupParams,
    test_mode: TestMode,
}

impl TestCase for ClearSomeAttachmentsTest {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        match self.group_params.rendering_type {
            RenderingType::RenderPass2 => context.require_device_functionality("VK_KHR_create_renderpass2"),
            RenderingType::DynamicRendering => context.require_device_functionality("VK_KHR_dynamic_rendering"),
            RenderingType::Legacy => Ok(()),
        }
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ClearSomeAttachmentsInstance {
            context,
            group_params: self.group_params,
            test_mode: self.test_mode,
        })
    }
}

struct ClearSomeAttachmentsInstance<'a> {
    context: &'a Context<'a>,
    group_params: GroupParams,
    test_mode: TestMode,
}

fn range(aspect_mask: vk::ImageAspectFlags) -> vk::ImageSubresourceRange {
    vk::ImageSubresourceRange {
        aspect_mask,
        base_mip_level: 0,
        level_count: 1,
        base_array_layer: 0,
        layer_count: 1,
    }
}

fn image_barrier(
    image: vk::Image,
    aspect_mask: vk::ImageAspectFlags,
    src_access: vk::AccessFlags,
    dst_access: vk::AccessFlags,
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
) -> vk::ImageMemoryBarrier {
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
}

impl ClearSomeAttachmentsInstance<'_> {
    fn create_image(&self, format: vk::Format, usage: vk::ImageUsageFlags) -> Result<ImageWithMemory<'_>, TestError> {
        let info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(vk::Extent3D {
                width: SIZE,
                height: SIZE,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        ImageWithMemory::new(
            self.context.get_device(),
            self.context.get_default_allocator(),
            info,
            MemoryRequirement::ANY,
        )
    }

    /// `createRenderPass` - the colour attachment is slot 0, depth/stencil slot 1.
    fn create_render_pass(&self, ds_format: vk::Format) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        let device = self.context.get_device();
        let (color_load_op, depth_load_op) = match self.test_mode {
            TestMode::ClearOnlyColor => (vk::AttachmentLoadOp::CLEAR, vk::AttachmentLoadOp::LOAD),
            TestMode::ClearOnlyDepth => (vk::AttachmentLoadOp::LOAD, vk::AttachmentLoadOp::CLEAR),
        };

        let attachments = [
            vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: COLOR_FORMAT,
                samples: vk::SampleCountFlags::_1,
                load_op: color_load_op,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            },
            vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: ds_format,
                samples: vk::SampleCountFlags::_1,
                load_op: depth_load_op,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: depth_load_op,
                stencil_store_op: vk::AttachmentStoreOp::STORE,
                initial_layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                final_layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            },
        ];
        let color_reference = vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        };
        let depth_reference = vk::AttachmentReference {
            attachment: 1,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        };

        if self.group_params.rendering_type == RenderingType::RenderPass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;

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
            let color_reference2 = vk::AttachmentReference2 {
                s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                next: std::ptr::null(),
                attachment: color_reference.attachment,
                layout: color_reference.layout,
                aspect_mask: vk::ImageAspectFlags::COLOR,
            };
            let depth_reference2 = vk::AttachmentReference2 {
                s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                next: std::ptr::null(),
                attachment: depth_reference.attachment,
                layout: depth_reference.layout,
                aspect_mask: vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
            };
            let subpass = vk::SubpassDescription2 {
                s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: vk::SubpassDescriptionFlags::empty(),
                pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
                view_mask: 0,
                input_attachment_count: 0,
                input_attachments: std::ptr::null(),
                color_attachment_count: 1,
                color_attachments: &color_reference2,
                resolve_attachments: std::ptr::null(),
                depth_stencil_attachment: &depth_reference2,
                preserve_attachment_count: 0,
                preserve_attachments: std::ptr::null(),
            };
            let info = vk::RenderPassCreateInfo2 {
                s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
                next: std::ptr::null(),
                flags: vk::RenderPassCreateFlags::empty(),
                attachment_count: attachments2.len() as u32,
                attachments: attachments2.as_ptr(),
                subpass_count: 1,
                subpasses: &subpass,
                dependency_count: 0,
                dependencies: std::ptr::null(),
                correlated_view_mask_count: 0,
                correlated_view_masks: std::ptr::null(),
            };
            let handle = unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?;
            return Ok(Unique::new(device, handle));
        }

        let color_references = [color_reference];
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_references)
            .depth_stencil_attachment(&depth_reference)
            .build()];
        let info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let handle = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
        Ok(Unique::new(device, handle))
    }

    /// `beginRenderPass` / `endRenderPass` from vktRenderPassTestsUtil, with a clear value
    /// for each of the two attachments.
    fn begin_render_pass(
        &self,
        command_buffer: vk::CommandBuffer,
        render_pass: vk::RenderPass,
        framebuffer: vk::Framebuffer,
    ) {
        let device = self.context.get_device();
        let clear_values = [
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: COLOR_CLEAR_ATTACHMENT,
                },
            },
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue {
                    depth: DEPTH_CLEAR_ATTACHMENT,
                    stencil: STENCIL_CLEAR_ATTACHMENT,
                },
            },
        ];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(render_pass)
            .framebuffer(framebuffer)
            .render_area(vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: SIZE,
                    height: SIZE,
                },
            })
            .clear_values(&clear_values)
            .build();

        if self.group_params.rendering_type == RenderingType::RenderPass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            let subpass_begin = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
            unsafe { device.cmd_begin_render_pass2_khr(command_buffer, &begin_info, &subpass_begin) };
        } else {
            unsafe { device.cmd_begin_render_pass(command_buffer, &begin_info, vk::SubpassContents::INLINE) };
        }
    }

    fn end_render_pass(&self, command_buffer: vk::CommandBuffer) {
        let device = self.context.get_device();
        if self.group_params.rendering_type == RenderingType::RenderPass2 {
            use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
            let subpass_end = vk::SubpassEndInfo::builder();
            unsafe { device.cmd_end_render_pass2_khr(command_buffer, &subpass_end) };
        } else {
            unsafe { device.cmd_end_render_pass(command_buffer) };
        }
    }

    /// `copyImageToBuffer` plus the host read: one aspect of an attachment, as raw texels.
    fn read_aspect(
        &self,
        image: vk::Image,
        copy_aspect: vk::ImageAspectFlags,
        barrier_aspect: vk::ImageAspectFlags,
        texel_size: usize,
        src_access: vk::AccessFlags,
        layout: vk::ImageLayout,
    ) -> Result<Vec<u8>, TestError> {
        let device = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let size = (SIZE as usize) * (SIZE as usize) * texel_size;
        let buffer = BufferWithMemory::new(
            device,
            self.context.get_default_allocator(),
            make_buffer_create_info(size as u64, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let command_pool = make_command_pool(device, self.context.get_universal_queue_family_index())?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(device, *command_buffer)?;
        unsafe {
            let to_src = image_barrier(
                image,
                barrier_aspect,
                src_access,
                vk::AccessFlags::TRANSFER_READ,
                layout,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            );
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
                    aspect_mask: copy_aspect,
                    mip_level: 0,
                    base_array_layer: 0,
                    layer_count: 1,
                },
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: vk::Extent3D {
                    width: SIZE,
                    height: SIZE,
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

            // The depth read and the stencil-free colour read both leave the image in
            // its attachment layout, so the second aspect can be read afterwards.
            let back = image_barrier(
                image,
                barrier_aspect,
                vk::AccessFlags::TRANSFER_READ,
                vk::AccessFlags::empty(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                layout,
            );
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

    /// `beginSecondaryCmdBuffer`
    fn begin_secondary_cmd_buffer(&self, secondary: vk::CommandBuffer) -> Result<(), TestError> {
        let device = self.context.get_device();
        let color_formats = [COLOR_FORMAT];
        let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
            .color_attachment_formats(&color_formats)
            .rasterization_samples(vk::SampleCountFlags::_1);
        let inheritance_info = vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);
        let begin_info = vk::CommandBufferBeginInfo::builder()
            .flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT)
            .inheritance_info(&inheritance_info);
        unsafe { device.begin_command_buffer(secondary, &begin_info) }.vk_check("vkBeginCommandBuffer")
    }
}

impl TestInstance for ClearSomeAttachmentsInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        use vulkanalia::vk::DeviceV1_3;

        let device = self.context.get_device();
        let instance = self.context.get_instance();
        let queue = self.context.get_universal_queue();
        let queue_index = self.context.get_universal_queue_family_index();

        let render_area = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: SIZE,
                height: SIZE,
            },
        };

        let transfer_usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | transfer_usage;
        let ds_usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | transfer_usage;

        let ds_aspect = vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL;
        let color_range = range(vk::ImageAspectFlags::COLOR);
        let ds_range = range(ds_aspect);

        // One of d24s8 and d32s8 has to be supported.
        let mut ds_format = vk::Format::D24_UNORM_S8_UINT;
        let ds_format_check = unsafe {
            instance.get_physical_device_image_format_properties(
                self.context.get_physical_device(),
                ds_format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                ds_usage,
                vk::ImageCreateFlags::empty(),
            )
        };
        if ds_format_check.is_err() {
            ds_format = vk::Format::D32_SFLOAT_S8_UINT;
        }

        let color_image = self.create_image(COLOR_FORMAT, color_usage)?;
        let ds_image = self.create_image(ds_format, ds_usage)?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_range,
        )?;
        let ds_view = make_image_view(device, ds_image.get(), vk::ImageViewType::_2D, ds_format, ds_range)?;

        let dynamic_rendering = self.group_params.rendering_type == RenderingType::DynamicRendering;
        let render_pass = (!dynamic_rendering)
            .then(|| self.create_render_pass(ds_format))
            .transpose()?;
        let framebuffer = render_pass
            .as_ref()
            .map(|render_pass| make_framebuffer(device, **render_pass, &[*color_view, *ds_view], SIZE, SIZE, 1))
            .transpose()?;

        let command_pool = make_command_pool(device, queue_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        let (color_load_op, depth_load_op) = match self.test_mode {
            TestMode::ClearOnlyColor => (vk::AttachmentLoadOp::CLEAR, vk::AttachmentLoadOp::LOAD),
            TestMode::ClearOnlyDepth => (vk::AttachmentLoadOp::LOAD, vk::AttachmentLoadOp::CLEAR),
        };
        let color_attachments = [vk::RenderingAttachmentInfo::builder()
            .image_view(*color_view)
            .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .load_op(color_load_op)
            .store_op(vk::AttachmentStoreOp::STORE)
            .clear_value(vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: COLOR_CLEAR_ATTACHMENT,
                },
            })
            .build()];
        let depth_attachment = vk::RenderingAttachmentInfo::builder()
            .image_view(*ds_view)
            .image_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .load_op(depth_load_op)
            .store_op(vk::AttachmentStoreOp::STORE)
            .clear_value(vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue {
                    depth: DEPTH_CLEAR_ATTACHMENT,
                    stencil: 0,
                },
            })
            .build();
        let rendering_info = vk::RenderingInfo::builder()
            .render_area(render_area)
            .layer_count(1)
            .color_attachments(&color_attachments)
            .depth_attachment(&depth_attachment);

        let mut secondary: Option<UniqueCommandBuffer<'_>> = None;
        if dynamic_rendering
            && self
                .group_params
                .secondary_cmd_buffer_completely_contains_dynamic_renderpass
        {
            let sec = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::SECONDARY)?;
            self.begin_secondary_cmd_buffer(*sec)?;
            unsafe {
                device.cmd_begin_rendering(*sec, &rendering_info);
                device.cmd_end_rendering(*sec);
            }
            end_command_buffer(device, *sec)?;
            secondary = Some(sec);
        }

        let t_write_access = vk::AccessFlags::TRANSFER_WRITE;
        let t_dst_layout = vk::ImageLayout::TRANSFER_DST_OPTIMAL;
        let initial_barriers = [
            image_barrier(
                color_image.get(),
                vk::ImageAspectFlags::COLOR,
                vk::AccessFlags::empty(),
                t_write_access,
                vk::ImageLayout::UNDEFINED,
                t_dst_layout,
            ),
            image_barrier(
                ds_image.get(),
                ds_aspect,
                vk::AccessFlags::empty(),
                t_write_access,
                vk::ImageLayout::UNDEFINED,
                t_dst_layout,
            ),
        ];
        let pre_render_pass_barriers = [
            image_barrier(
                color_image.get(),
                vk::ImageAspectFlags::COLOR,
                t_write_access,
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                t_dst_layout,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            ),
            image_barrier(
                ds_image.get(),
                ds_aspect,
                t_write_access,
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                t_dst_layout,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            ),
        ];

        begin_command_buffer(device, *command_buffer)?;
        unsafe {
            // Both images to transfer dst, then both cleared to known values.
            device.cmd_pipeline_barrier(
                *command_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &initial_barriers,
            );
            device.cmd_clear_color_image(
                *command_buffer,
                color_image.get(),
                t_dst_layout,
                &vk::ClearColorValue {
                    float32: COLOR_CLEAR_IMAGE,
                },
                &[color_range],
            );
            device.cmd_clear_depth_stencil_image(
                *command_buffer,
                ds_image.get(),
                t_dst_layout,
                &vk::ClearDepthStencilValue {
                    depth: DEPTH_CLEAR_IMAGE,
                    stencil: 0,
                },
                &[ds_range],
            );
            device.cmd_pipeline_barrier(
                *command_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::ALL_GRAPHICS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &pre_render_pass_barriers,
            );
        }

        // Clear only one attachment in the render pass, to a new value.
        if let (Some(render_pass), Some(framebuffer)) = (&render_pass, &framebuffer) {
            self.begin_render_pass(*command_buffer, **render_pass, **framebuffer);
            self.end_render_pass(*command_buffer);
        } else if let Some(sec) = &secondary {
            unsafe { device.cmd_execute_commands(*command_buffer, &[**sec]) };
        } else {
            unsafe {
                device.cmd_begin_rendering(*command_buffer, &rendering_info);
                device.cmd_end_rendering(*command_buffer);
            }
        }
        end_command_buffer(device, *command_buffer)?;
        submit_commands_and_wait(device, queue, *command_buffer)?;

        let color_bytes = self.read_aspect(
            color_image.get(),
            vk::ImageAspectFlags::COLOR,
            vk::ImageAspectFlags::COLOR,
            4,
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let depth_bytes = self.read_aspect(
            ds_image.get(),
            vk::ImageAspectFlags::DEPTH,
            ds_aspect,
            4,
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        )?;

        // Expected colour and depth: whichever attachment was not cleared keeps the
        // value the image was cleared to before the render pass.
        let (expected_color, expected_depth) = match self.test_mode {
            TestMode::ClearOnlyColor => (COLOR_CLEAR_ATTACHMENT, DEPTH_CLEAR_IMAGE),
            TestMode::ClearOnlyDepth => (COLOR_CLEAR_IMAGE, DEPTH_CLEAR_ATTACHMENT),
        };

        // Only a few fragments are verified, as upstream does.
        let epsilon = 0.05f32;
        for i in 0..4usize {
            let texel = (i * 2) * SIZE as usize + i * 2;

            let mut color = [0.0f32; 4];
            for (channel, value) in color.iter_mut().enumerate() {
                *value = f32::from(color_bytes[texel * 4 + channel]) / 255.0;
            }

            // The depth aspect of d24s8 is copied as X8_D24 (depth in the low 24 bits).
            let depth_bits: [u8; 4] = depth_bytes[texel * 4..texel * 4 + 4]
                .try_into()
                .expect("four bytes per texel");
            let depth_word = u32::from_le_bytes(depth_bits);
            let depth = if ds_format == vk::Format::D32_SFLOAT_S8_UINT {
                f32::from_bits(depth_word)
            } else {
                (depth_word & 0x00ff_ffff) as f32 / 16_777_215.0
            };

            let color_mismatch = color.iter().zip(expected_color).any(|(c, e)| (e - c).abs() > epsilon);
            if color_mismatch || (expected_depth - depth).abs() > epsilon {
                return Ok(TestStatus::fail(format!(
                    "Fail at ({0}, {0}): colour {color:?} (expected {expected_color:?}), depth {depth} (expected {expected_depth})",
                    i * 2
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createRenderPassClearSomeAttachmentsTests`
pub fn create_clear_some_attachments_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("clear_some_attachments");
    for (name, test_mode) in [
        ("clear_only_color", TestMode::ClearOnlyColor),
        ("clear_only_depth", TestMode::ClearOnlyDepth),
    ] {
        group.add_child(Box::new(ClearSomeAttachmentsTest {
            name,
            group_params,
            test_mode,
        }) as Box<dyn TestCase>);
    }
    group
}
