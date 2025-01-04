// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassTests.cpp (`RenderPassNoDrawLoadStoreTestCase`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// A render pass (or dynamic rendering) that only clears and stores a 1x1 colour attachment, with no draw in it; the cleared
// pixel has to be what lands in the buffer. Upstream builds the render pass from the AttachmentDescription1/2 wrapper
// templates, which are written out by hand here.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, KhrCreateRenderpass2ExtensionDeviceCommands};

use super::group_params::{GroupParams, RenderingType};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

const IMAGE_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// `RenderPassNoDrawLoadStoreTestCase`
struct RenderPassNoDrawLoadStoreTestCase {
    name: &'static str,
    group_params: GroupParams,
}

impl TestCase for RenderPassNoDrawLoadStoreTestCase {
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
        Box::new(RenderPassNoDrawLoadStoreTestInstance {
            context,
            group_params: self.group_params,
        })
    }
}

/// `RenderPassNoDrawLoadStoreTestInstance`
struct RenderPassNoDrawLoadStoreTestInstance<'a> {
    context: &'a Context<'a>,
    group_params: GroupParams,
}

impl RenderPassNoDrawLoadStoreTestInstance<'_> {
    /// `createRenderPass`
    fn create_render_pass(&self, rendering_type: RenderingType) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        let device = self.context.get_device();

        if rendering_type == RenderingType::RenderPass2 {
            let attachment_description = vk::AttachmentDescription2 {
                s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: IMAGE_FORMAT,
                samples: vk::SampleCountFlags::_1,
                load_op: vk::AttachmentLoadOp::CLEAR,
                store_op: vk::AttachmentStoreOp::STORE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::UNDEFINED,
                final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            };
            let result_attachment_ref_subpass0 = vk::AttachmentReference2 {
                s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                next: std::ptr::null(),
                attachment: 0,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                aspect_mask: vk::ImageAspectFlags::COLOR,
            };
            let subpass_description = vk::SubpassDescription2 {
                s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: vk::SubpassDescriptionFlags::empty(),
                pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
                view_mask: 0,
                input_attachment_count: 0,
                input_attachments: std::ptr::null(),
                color_attachment_count: 1,
                color_attachments: &result_attachment_ref_subpass0,
                resolve_attachments: std::ptr::null(),
                depth_stencil_attachment: std::ptr::null(),
                preserve_attachment_count: 0,
                preserve_attachments: std::ptr::null(),
            };
            let info = vk::RenderPassCreateInfo2 {
                s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
                next: std::ptr::null(),
                flags: vk::RenderPassCreateFlags::empty(),
                attachment_count: 1,
                attachments: &attachment_description,
                subpass_count: 1,
                subpasses: &subpass_description,
                dependency_count: 0,
                dependencies: std::ptr::null(),
                correlated_view_mask_count: 0,
                correlated_view_masks: std::ptr::null(),
            };
            let handle = unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?;
            return Ok(Unique::new(device, handle));
        }

        let attachments = [vk::AttachmentDescription::builder()
            .format(IMAGE_FORMAT)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let color_references = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_references)
            .build()];
        let info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let handle = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
        Ok(Unique::new(device, handle))
    }
}

impl TestInstance for RenderPassNoDrawLoadStoreTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let q_index = context.get_universal_queue_family_index();
        let rendering_type = self.group_params.rendering_type;

        let image_extent = vk::Extent3D {
            width: 1,
            height: 1,
            depth: 1,
        };
        let scissor = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D { width: 1, height: 1 },
        };
        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(IMAGE_FORMAT)
            .extent(image_extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_attachment = ImageWithMemory::new(device, alloc, image_info, MemoryRequirement::ANY)?;
        let color_attachment_view = make_image_view(
            device,
            color_attachment.get(),
            vk::ImageViewType::_2D,
            IMAGE_FORMAT,
            subresource_range,
        )?;

        let out_buffer_size = 4 as vk::DeviceSize;
        let out_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(out_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let render_pass = if rendering_type == RenderingType::DynamicRendering {
            None
        } else {
            Some(self.create_render_pass(rendering_type)?)
        };
        let framebuffer = match &render_pass {
            Some(render_pass) => Some(make_framebuffer(
                device,
                **render_pass,
                &[*color_attachment_view],
                1,
                1,
                1,
            )?),
            None => None,
        };

        let clear_value_color = vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [1.0, 0.0, 1.0, 1.0],
            },
        };

        let command_pool = make_command_pool(device, q_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;

        begin_command_buffer(device, cmd)?;

        if rendering_type == RenderingType::DynamicRendering {
            let color_attachment_info = vk::RenderingAttachmentInfo::builder()
                .image_view(*color_attachment_view)
                .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .resolve_image_layout(vk::ImageLayout::UNDEFINED)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .clear_value(clear_value_color)
                .build();
            let color_attachments = [color_attachment_info];
            let rendering_info = vk::RenderingInfo::builder()
                .render_area(scissor)
                .layer_count(1)
                .view_mask(0)
                .color_attachments(&color_attachments);

            let image_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_attachment.get(),
                subresource_range,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::FRAGMENT_SHADER,
                    vk::PipelineStageFlags::FRAGMENT_SHADER,
                    vk::DependencyFlags::BY_REGION,
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_barrier],
                );
                device.cmd_begin_rendering(cmd, &rendering_info);
                device.cmd_end_rendering(cmd);
            }
        } else {
            let clear_values = [clear_value_color];
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(**render_pass.as_ref().expect("created above"))
                .framebuffer(**framebuffer.as_ref().expect("created above"))
                .render_area(scissor)
                .clear_values(&clear_values);
            unsafe {
                if rendering_type == RenderingType::RenderPass2 {
                    let subpass_begin_info = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
                    device.cmd_begin_render_pass2_khr(cmd, &begin_info, &subpass_begin_info);
                    device.cmd_end_render_pass2_khr(cmd, &vk::SubpassEndInfo::builder());
                } else {
                    device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                    device.cmd_end_render_pass(cmd);
                }
            }
        }

        let barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            color_attachment.get(),
            subresource_range,
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
        copy_image_to_buffer(device, cmd, color_attachment.get(), out_buffer.get(), 1, 1);
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        let allocation = out_buffer.get_allocation();
        invalidate_alloc(device, allocation)?;
        let pixel = unsafe { std::slice::from_raw_parts(allocation.get_host_ptr(), out_buffer_size as usize) };
        let expected = [255u8, 0, 255, 255];

        if pixel != expected {
            return Ok(TestStatus::fail(format!(
                "Pixel isn't equal to clear color: {pixel:?} instead of {expected:?}"
            )));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// The `no_draws` group `createRenderPassTestsInternal` builds for a monolithic pipeline without secondary command buffers.
pub fn create_render_pass_no_draw_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut no_draw_group = TestCaseGroup::new("no_draws");
    no_draw_group.add_child(Box::new(RenderPassNoDrawLoadStoreTestCase {
        name: "no_draw_clear_load_store",
        group_params,
    }) as Box<dyn TestCase>);
    no_draw_group
}
