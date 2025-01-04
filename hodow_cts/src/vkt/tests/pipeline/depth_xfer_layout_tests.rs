// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineDepthTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `depth.xfer_queue_layout`: the layout of a depth/stencil image is changed on the transfer
// queue (the key of the test), with ownership handed over to the universal queue, which then uses the image as an attachment. The depth and
// stencil aspects are copied back with one barrier over both aspects (upstream transitions each in turn). Monolithic pipelines only.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_depth_xfer_layout::XFER_LAYOUT;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const CLEAR_COLOR: [f32; 4] = [0.0, 0.0, 0.0, 1.0];
const GEOMETRY_COLOR: [u8; 4] = [0, 0, 255, 255];
const CLEAR_DEPTH: f32 = 0.0;
const GEOMETRY_DEPTH: f32 = 1.0;
const CLEAR_STENCIL: u32 = 0;
const GEOMETRY_STENCIL: u32 = 255;

/// `TransferLayoutChangeParams`
#[derive(Clone, Copy)]
struct TransferLayoutChangeParams {
    aspects: vk::ImageAspectFlags,
}

struct TransferLayoutChangeCase {
    name: String,
    params: TransferLayoutChangeParams,
}

impl TestCase for TransferLayoutChangeCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `transferLayoutChangeSupportCheck`: fails with NotSupported when the queue does not exist.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_transfer_queue().is_none() {
            return Err(TestError::NotSupported("No transfer queue".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        XFER_LAYOUT.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TransferLayoutChangeInstance {
            context,
            params: self.params,
        })
    }
}

struct TransferLayoutChangeInstance<'a> {
    context: &'a Context<'a>,
    params: TransferLayoutChangeParams,
}

/// `chooseDepthStencilFormat`: the spec mandates support for one of these two formats, and the test reads from it.
fn choose_depth_stencil_format(context: &Context<'_>) -> Result<vk::Format, TestError> {
    let required_features = vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT | vk::FormatFeatureFlags::TRANSFER_SRC;
    for candidate in [vk::Format::D32_SFLOAT_S8_UINT, vk::Format::D24_UNORM_S8_UINT] {
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), candidate)
        };
        if properties.optimal_tiling_features.contains(required_features) {
            return Ok(candidate);
        }
    }
    Err(TestError::Fail("No suitable depth/stencil format found".to_string()))
}

fn pipeline_barrier(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barrier: vk::ImageMemoryBarrier,
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        )
    };
}

impl TestInstance for TransferLayoutChangeInstance<'_> {
    /// `transferLayoutChangeTest`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let params = self.params;
        let ds_format = choose_depth_stencil_format(context)?;
        let xfer_usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        let fb_extent = vk::Extent3D {
            width: 1,
            height: 1,
            depth: 1,
        };
        let ds_aspects = vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL;
        let use_depth = params.aspects.contains(vk::ImageAspectFlags::DEPTH);
        let use_stencil = params.aspects.contains(vk::ImageAspectFlags::STENCIL);
        let ds_used_aspects = params.aspects;
        let ds_unused_aspects = ds_aspects & !ds_used_aspects;

        let xfer_stage = vk::PipelineStageFlags::TRANSFER;
        let ds_stage = vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS;

        let (xfer_queue, xfer_qf_index) = context
            .get_transfer_queue()
            .ok_or_else(|| TestError::NotSupported("No transfer queue".to_string()))?;
        let queue = context.get_universal_queue();
        let qf_index = context.get_universal_queue_family_index();

        // Color buffer.
        let color_buffer = ImageWithBuffer::new(
            context,
            1,
            1,
            COLOR_FORMAT,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | xfer_usage,
            4,
        )?;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        // Depth/stencil buffers (regular and staging).
        let ds_create_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(ds_format)
            .extent(fb_extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | xfer_usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let ds_buffer = ImageWithMemory::new(device, alloc, ds_create_info, MemoryRequirement::ANY)?;
        let ds_staging_buffer = ImageWithMemory::new(device, alloc, ds_create_info, MemoryRequirement::ANY)?;

        let ds_srr = make_image_subresource_range(ds_aspects, 0, 1, 0, 1);
        let ds_view = make_image_view(device, ds_buffer.get(), vk::ImageViewType::_2D, ds_format, ds_srr)?;
        let ds_used_srr = make_image_subresource_range(ds_used_aspects, 0, 1, 0, 1);
        let ds_unused_srr = make_image_subresource_range(ds_unused_aspects, 0, 1, 0, 1);
        let ds_used_srl = vk::ImageSubresourceLayers {
            aspect_mask: ds_used_aspects,
            mip_level: 0,
            base_array_layer: 0,
            layer_count: 1,
        };

        // Render pass and framebuffer. The images are cleared from the transfer queue, so they are loaded here.
        let attachment_descriptions = [
            vk::AttachmentDescription::builder()
                .format(COLOR_FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
            vk::AttachmentDescription::builder()
                .format(ds_format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(if use_depth {
                    vk::AttachmentLoadOp::LOAD
                } else {
                    vk::AttachmentLoadOp::DONT_CARE
                })
                .store_op(if use_depth {
                    vk::AttachmentStoreOp::STORE
                } else {
                    vk::AttachmentStoreOp::DONT_CARE
                })
                .stencil_load_op(if use_stencil {
                    vk::AttachmentLoadOp::LOAD
                } else {
                    vk::AttachmentLoadOp::DONT_CARE
                })
                .stencil_store_op(if use_stencil {
                    vk::AttachmentStoreOp::STORE
                } else {
                    vk::AttachmentStoreOp::DONT_CARE
                })
                .initial_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build(),
        ];
        let color_reference = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let ds_reference = vk::AttachmentReference {
            attachment: 1,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        };
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_reference)
            .depth_stencil_attachment(&ds_reference)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachment_descriptions)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view, *ds_view], 1, 1, 1)?;

        // Pipeline.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        // Enable depth/stencil tests depending on the used aspects.
        let stencil_op = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::KEEP)
            .pass_op(vk::StencilOp::REPLACE)
            .depth_fail_op(vk::StencilOp::KEEP)
            .compare_op(vk::CompareOp::ALWAYS)
            .compare_mask(0xFF)
            .write_mask(0xFF)
            .reference(GEOMETRY_STENCIL)
            .build();
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(1, 1);
        state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(use_depth)
            .depth_write_enable(use_depth)
            .depth_compare_op(vk::CompareOp::ALWAYS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(use_stencil)
            .front(stencil_op)
            .back(stencil_op)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0)
            .build();
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?;

        // Clear the staging image on the universal queue first: vkCmdClearDepthStencilImage cannot run on the transfer queue
        // (VUID-vkCmdClearDepthStencilImage-commandBuffer-cmdpool), and neither can vkCmdCopyBufferToImage
        // (VUID-vkCmdCopyBufferToImage-commandBuffer-07737). A staging image cleared on the universal queue and copied with vkCmdCopyImage on the
        // transfer queue is legal.
        let staging_pool = make_command_pool(device, qf_index)?;
        let staging_cmd = allocate_command_buffer(device, *staging_pool, vk::CommandBufferLevel::PRIMARY)?;
        let staging_cmd_buffer = *staging_cmd;
        begin_command_buffer(device, staging_cmd_buffer)?;
        {
            let pre_clear_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                ds_staging_buffer.get(),
                ds_srr,
            );
            pipeline_barrier(
                device,
                staging_cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                xfer_stage,
                pre_clear_barrier,
            );

            let ds_clear_value = vk::ClearDepthStencilValue {
                depth: CLEAR_DEPTH,
                stencil: CLEAR_STENCIL,
            };
            unsafe {
                device.cmd_clear_depth_stencil_image(
                    staging_cmd_buffer,
                    ds_staging_buffer.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &ds_clear_value,
                    &[ds_srr],
                )
            };
        }

        // Barrier to transition layout and ownership of the staging image.
        let mut qfot_staging_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            ds_staging_buffer.get(),
            ds_srr,
        );
        qfot_staging_barrier.src_queue_family_index = qf_index;
        qfot_staging_barrier.dst_queue_family_index = xfer_qf_index;
        pipeline_barrier(device, staging_cmd_buffer, xfer_stage, xfer_stage, qfot_staging_barrier);
        end_command_buffer(device, staging_cmd_buffer)?;

        let xfer_pool = make_command_pool(device, xfer_qf_index)?;
        let xfer_cmd = allocate_command_buffer(device, *xfer_pool, vk::CommandBufferLevel::PRIMARY)?;
        let xfer_cmd_buffer = *xfer_cmd;
        begin_command_buffer(device, xfer_cmd_buffer)?;

        // Acquire ownership of the staging image.
        pipeline_barrier(device, xfer_cmd_buffer, xfer_stage, xfer_stage, qfot_staging_barrier);

        // Transition the layout of the final depth/stencil buffer before the copy. This is the motivation of the test: the layout of a
        // depth/stencil image is transitioned using the transfer queue.
        let pre_copy_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            ds_buffer.get(),
            ds_used_srr,
        );
        pipeline_barrier(
            device,
            xfer_cmd_buffer,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            xfer_stage,
            pre_copy_barrier,
        );
        {
            let zero_offset = vk::Offset3D { x: 0, y: 0, z: 0 };
            let copy_region = vk::ImageCopy {
                src_subresource: ds_used_srl,
                src_offset: zero_offset,
                dst_subresource: ds_used_srl,
                dst_offset: zero_offset,
                extent: fb_extent,
            };
            unsafe {
                device.cmd_copy_image(
                    xfer_cmd_buffer,
                    ds_staging_buffer.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    ds_buffer.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[copy_region],
                )
            };
        }
        let ds_access =
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE;
        let mut qfot_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            ds_access,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            ds_buffer.get(),
            ds_used_srr,
        );
        qfot_barrier.src_queue_family_index = xfer_qf_index;
        qfot_barrier.dst_queue_family_index = qf_index;

        // Some bitflags are zeroed out in the barrier and command because it is recommended by the spec and because only stages supported by
        // the queue can be included, and the transfer queue does not support the destination stage.
        let mut qfot_barrier_release = qfot_barrier;
        qfot_barrier_release.dst_access_mask = vk::AccessFlags::empty();
        let mut qfot_barrier_acquire = qfot_barrier;
        qfot_barrier_acquire.src_access_mask = vk::AccessFlags::empty();

        // Release the depth/stencil image to the universal queue.
        pipeline_barrier(
            device,
            xfer_cmd_buffer,
            xfer_stage,
            vk::PipelineStageFlags::BOTTOM_OF_PIPE,
            qfot_barrier_release,
        );
        end_command_buffer(device, xfer_cmd_buffer)?;

        // Use the depth/stencil attachment normally in the universal queue.
        let use_pool = make_command_pool(device, qf_index)?;
        let draw_cmd = allocate_command_buffer(device, *use_pool, vk::CommandBufferLevel::PRIMARY)?;
        let draw_cmd_buffer = *draw_cmd;
        begin_command_buffer(device, draw_cmd_buffer)?;

        // Acquire the depth/stencil image.
        pipeline_barrier(
            device,
            draw_cmd_buffer,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            ds_stage,
            qfot_barrier_acquire,
        );

        // Clear the color image.
        {
            let pre_clear_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                color_buffer.image.get(),
                color_srr,
            );
            pipeline_barrier(
                device,
                draw_cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                xfer_stage,
                pre_clear_barrier,
            );

            let color_clear_value = vk::ClearColorValue { float32: CLEAR_COLOR };
            unsafe {
                device.cmd_clear_color_image(
                    draw_cmd_buffer,
                    color_buffer.image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &color_clear_value,
                    &[color_srr],
                )
            };

            let color_access = vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE;
            let post_clear_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                color_access,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_buffer.image.get(),
                color_srr,
            );
            pipeline_barrier(
                device,
                draw_cmd_buffer,
                xfer_stage,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                post_clear_barrier,
            );
        }

        // Transition the pending depth/stencil aspect if needed.
        if !ds_unused_aspects.is_empty() {
            let extra_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                ds_access,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                ds_buffer.get(),
                ds_unused_srr,
            );
            pipeline_barrier(
                device,
                draw_cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                ds_stage,
                extra_barrier,
            );
        }

        let clear_values = [clear_value_color(CLEAR_COLOR), clear_value_color(CLEAR_COLOR)];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(1, 1))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(draw_cmd_buffer, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(draw_cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_draw(draw_cmd_buffer, 3, 1, 0, 0);
            device.cmd_end_render_pass(draw_cmd_buffer);
        }

        // Copy the color, depth and stencil aspects to buffers.
        copy_image_to_buffer(
            device,
            draw_cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            1,
            1,
        );

        let depth_verif_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(4, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let stencil_verif_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(1, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let to_transfer_src = make_image_memory_barrier(
            ds_access,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            ds_buffer.get(),
            ds_srr,
        );
        pipeline_barrier(
            device,
            draw_cmd_buffer,
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::PipelineStageFlags::TRANSFER,
            to_transfer_src,
        );
        for (aspect, buffer) in [
            (vk::ImageAspectFlags::DEPTH, &depth_verif_buffer),
            (vk::ImageAspectFlags::STENCIL, &stencil_verif_buffer),
        ] {
            let region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: vk::ImageSubresourceLayers {
                    aspect_mask: aspect,
                    mip_level: 0,
                    base_array_layer: 0,
                    layer_count: 1,
                },
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: fb_extent,
            };
            unsafe {
                device.cmd_copy_image_to_buffer(
                    draw_cmd_buffer,
                    ds_buffer.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    buffer.get(),
                    &[region],
                )
            };
        }
        let host_barrier = vk::MemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .build();
        unsafe {
            device.cmd_pipeline_barrier(
                draw_cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[host_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            )
        };
        end_command_buffer(device, draw_cmd_buffer)?;

        // Two semaphores: from the universal queue to the transfer queue, and from the transfer queue to the universal queue.
        let uni_to_xfer_sem = Unique::new(
            device,
            unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                .vk_check("vkCreateSemaphore")?,
        );
        let xfer_to_uni_sem = Unique::new(
            device,
            unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                .vk_check("vkCreateSemaphore")?,
        );

        let staging_cmds = [staging_cmd_buffer];
        let uni_to_xfer = [*uni_to_xfer_sem];
        let staging_submit = vk::SubmitInfo::builder()
            .command_buffers(&staging_cmds)
            .signal_semaphores(&uni_to_xfer);
        unsafe { device.queue_submit(queue, &[staging_submit], vk::Fence::null()) }.vk_check("vkQueueSubmit")?;

        let xfer_cmds = [xfer_cmd_buffer];
        let xfer_wait_stages = [xfer_stage];
        let xfer_to_uni = [*xfer_to_uni_sem];
        let xfer_submit = vk::SubmitInfo::builder()
            .wait_semaphores(&uni_to_xfer)
            .wait_dst_stage_mask(&xfer_wait_stages)
            .command_buffers(&xfer_cmds)
            .signal_semaphores(&xfer_to_uni);
        unsafe { device.queue_submit(xfer_queue, &[xfer_submit], vk::Fence::null()) }.vk_check("vkQueueSubmit")?;

        let draw_cmds = [draw_cmd_buffer];
        let draw_wait_stages = [ds_stage];
        let draw_submit = vk::SubmitInfo::builder()
            .wait_semaphores(&xfer_to_uni)
            .wait_dst_stage_mask(&draw_wait_stages)
            .command_buffers(&draw_cmds);
        let fence = Unique::new(
            device,
            unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
        );
        unsafe { device.queue_submit(queue, &[draw_submit], *fence) }.vk_check("vkQueueSubmit")?;
        unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;

        // Check the color buffer.
        let color = color_buffer.read_bytes(device)?;
        if color[..4] != GEOMETRY_COLOR {
            return Ok(TestStatus::fail(
                "Unexpected results in color buffer; check log for details;",
            ));
        }

        if use_depth {
            invalidate_alloc(device, depth_verif_buffer.get_allocation())?;
            let bytes = unsafe { std::slice::from_raw_parts(depth_verif_buffer.get_allocation().get_host_ptr(), 4) };
            let word = u32::from_ne_bytes([bytes[0], bytes[1], bytes[2], bytes[3]]);
            let depth_ok = if ds_format == vk::Format::D32_SFLOAT_S8_UINT {
                f32::from_bits(word) == GEOMETRY_DEPTH
            } else {
                word & 0x00FF_FFFF == 0x00FF_FFFF
            };
            if !depth_ok {
                return Ok(TestStatus::fail(
                    "Unexpected results in depth buffer; check log for details;",
                ));
            }
        }

        if use_stencil {
            invalidate_alloc(device, stencil_verif_buffer.get_allocation())?;
            let stencil = unsafe { *stencil_verif_buffer.get_allocation().get_host_ptr() };
            if u32::from(stencil) != GEOMETRY_STENCIL {
                return Ok(TestStatus::fail(
                    "Unexpected results in stencil buffer; check log for details;",
                ));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// The `xfer_queue_layout` group of `createDepthTests`.
pub fn create_xfer_queue_layout_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("xfer_queue_layout");
    let aspect_cases = [
        vk::ImageAspectFlags::DEPTH,
        vk::ImageAspectFlags::STENCIL,
        vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
    ];
    for aspects in aspect_cases {
        let name = format!(
            "aspect{}{}",
            if aspects.contains(vk::ImageAspectFlags::DEPTH) {
                "_depth"
            } else {
                ""
            },
            if aspects.contains(vk::ImageAspectFlags::STENCIL) {
                "_stencil"
            } else {
                ""
            }
        );
        group.add_child(Box::new(TransferLayoutChangeCase {
            name,
            params: TransferLayoutChangeParams { aspects },
        }) as Box<dyn TestCase>);
    }
    group
}
