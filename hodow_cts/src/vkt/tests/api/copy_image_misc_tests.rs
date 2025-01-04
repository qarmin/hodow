// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiCopyImageToImageTests.cpp (addImageToImageMiscTests)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Reproduces a Mesa issue: a multisampled image copy on the transfer queue followed by a single-sample copy on the same queue, in the
// same command buffer. Both copies are unrelated; an optional barrier sits between them.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_3;

use super::copies_buffer_tests::{QueueSelection, select_queue};
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel, clear};
use crate::tcu::{TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_memory_barrier};
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::draw::util::ImageWithBuffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

/// `MultiSampleThenSingleSampleParams` (`barrierSrcStage` of `VK_PIPELINE_STAGE_FLAG_BITS_MAX_ENUM` is `None`).
#[derive(Clone, Copy)]
struct MultiSampleThenSingleSampleCase {
    name: &'static str,
    barrier_src_stage: Option<vk::PipelineStageFlags>,
}

impl TestCase for MultiSampleThenSingleSampleCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        select_queue(context, QueueSelection::TransferOnly).map(|_| ())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultiSampleThenSingleSampleInstance {
            context,
            barrier_src_stage: self.barrier_src_stage,
        })
    }
}

struct MultiSampleThenSingleSampleInstance<'a> {
    context: &'a Context<'a>,
    barrier_src_stage: Option<vk::PipelineStageFlags>,
}

impl TestInstance for MultiSampleThenSingleSampleInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        multi_sample_then_single_sample_test(self.context, self.barrier_src_stage)
    }
}

/// `multiSampleThenSingleSampleTest`
fn multi_sample_then_single_sample_test(
    context: &Context<'_>,
    barrier_src_stage: Option<vk::PipelineStageFlags>,
) -> TestOutcome {
    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let queue = context.get_universal_queue();
    let qf_index = context.get_universal_queue_family_index();
    let (transfer_queue, transfer_qf_index) = context
        .get_transfer_queue()
        .ok_or_else(|| TestError::NotSupported("No transfer-only queue family".to_string()))?;

    let format = vk::Format::R8G8B8A8_UNORM;
    let extent = [1u32, 1, 1];
    let usage =
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let color_srl = vk::ImageSubresourceLayers {
        aspect_mask: vk::ImageAspectFlags::COLOR,
        mip_level: 0,
        base_array_layer: 0,
        layer_count: 1,
    };
    let xfer_src_layout = vk::ImageLayout::TRANSFER_SRC_OPTIMAL;
    let xfer_dst_layout = vk::ImageLayout::TRANSFER_DST_OPTIMAL;
    let zero_offset = vk::Offset3D { x: 0, y: 0, z: 0 };
    let extent_vk = vk::Extent3D {
        width: extent[0],
        height: extent[1],
        depth: extent[2],
    };

    let ms_create_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(extent_vk)
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_4)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let mut ss_create_info = ms_create_info;
    ss_create_info.samples = vk::SampleCountFlags::_1;

    let ms_src_img = ImageWithMemory::new(device, allocator, ms_create_info, MemoryRequirement::ANY)?;
    let ms_dst_img = ImageWithMemory::new(device, allocator, ms_create_info, MemoryRequirement::ANY)?;
    let ss_src_img = ImageWithMemory::new(device, allocator, ss_create_info, MemoryRequirement::ANY)?;
    let ss_dst_img = ImageWithBuffer::new(context, extent[0], extent[1], format, usage, 4)?;
    let ss_extra_img = ImageWithBuffer::new(context, extent[0], extent[1], format, usage, 4)?;

    let all_handles = [
        ms_src_img.get(),
        ms_dst_img.get(),
        ss_src_img.get(),
        ss_dst_img.image.get(),
        ss_extra_img.image.get(),
    ];

    let ms_src_color_vec = [0.0f32, 0.0, 1.0, 1.0];
    let ss_src_color_vec = [0.0f32, 1.0, 1.0, 1.0];
    let clear_color_vec = [0.0f32, 0.0, 0.0, 1.0];
    let ms_src_color = vk::ClearColorValue {
        float32: ms_src_color_vec,
    };
    let ss_src_color = vk::ClearColorValue {
        float32: ss_src_color_vec,
    };
    let clear_color = vk::ClearColorValue {
        float32: clear_color_vec,
    };

    let univ_cmd_pool = make_command_pool(device, qf_index)?;
    let xfer_cmd_pool = make_command_pool(device, transfer_qf_index)?;

    // Clear images.
    {
        let cmd_buffer_ptr = allocate_command_buffer(device, *univ_cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = *cmd_buffer_ptr;
        begin_command_buffer(device, cmd_buffer)?;
        unsafe {
            let prepare_barriers: Vec<vk::ImageMemoryBarrier> = all_handles
                .iter()
                .map(|&img| {
                    make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        xfer_dst_layout,
                        img,
                        color_srr,
                    )
                })
                .collect();
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::empty(),
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &prepare_barriers,
            );

            device.cmd_clear_color_image(
                cmd_buffer,
                ms_src_img.get(),
                xfer_dst_layout,
                &ms_src_color,
                &[color_srr],
            );
            device.cmd_clear_color_image(
                cmd_buffer,
                ms_dst_img.get(),
                xfer_dst_layout,
                &clear_color,
                &[color_srr],
            );
            device.cmd_clear_color_image(
                cmd_buffer,
                ss_src_img.get(),
                xfer_dst_layout,
                &ss_src_color,
                &[color_srr],
            );
            device.cmd_clear_color_image(
                cmd_buffer,
                ss_dst_img.image.get(),
                xfer_dst_layout,
                &clear_color,
                &[color_srr],
            );
            device.cmd_clear_color_image(
                cmd_buffer,
                ss_extra_img.image.get(),
                xfer_dst_layout,
                &clear_color,
                &[color_srr],
            );

            let post_clear_barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::empty(),
                    xfer_dst_layout,
                    xfer_src_layout,
                    ms_src_img.get(),
                    color_srr,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::empty(),
                    xfer_dst_layout,
                    xfer_src_layout,
                    ss_src_img.get(),
                    color_srr,
                ),
            ];
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::BOTTOM_OF_PIPE,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &post_clear_barriers,
            );
        }
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;
    }

    // Copy src images to dst images.
    {
        let cmd_buffer_ptr = allocate_command_buffer(device, *xfer_cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = *cmd_buffer_ptr;

        let copy_region = vk::ImageCopy2 {
            s_type: vk::StructureType::IMAGE_COPY_2,
            next: std::ptr::null(),
            src_subresource: color_srl,
            src_offset: zero_offset,
            dst_subresource: color_srl,
            dst_offset: zero_offset,
            extent: extent_vk,
        };

        begin_command_buffer(device, cmd_buffer)?;
        unsafe {
            let ms_copy_image_info = vk::CopyImageInfo2 {
                s_type: vk::StructureType::COPY_IMAGE_INFO_2,
                next: std::ptr::null(),
                src_image: ms_src_img.get(),
                src_image_layout: xfer_src_layout,
                dst_image: ms_dst_img.get(),
                dst_image_layout: xfer_dst_layout,
                region_count: 1,
                regions: &copy_region,
            };
            device.cmd_copy_image2(cmd_buffer, &ms_copy_image_info);

            if let Some(src_stage) = barrier_src_stage {
                let dst_mask = vk::AccessFlags::TRANSFER_READ | vk::AccessFlags::TRANSFER_WRITE;
                let src_mask = if src_stage == vk::PipelineStageFlags::BOTTOM_OF_PIPE {
                    vk::AccessFlags::empty()
                } else {
                    dst_mask
                };
                let barrier = make_memory_barrier(src_mask, dst_mask);
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    src_stage,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }

            let mut ss_copy_image_info = ms_copy_image_info;
            ss_copy_image_info.src_image = ss_src_img.get();
            ss_copy_image_info.dst_image = ss_dst_img.image.get();
            device.cmd_copy_image2(cmd_buffer, &ss_copy_image_info);
        }
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, transfer_queue, cmd_buffer)?;
    }

    // Resolve MS image and copy SS images to verification buffers.
    {
        let cmd_buffer_ptr = allocate_command_buffer(device, *univ_cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = *cmd_buffer_ptr;
        begin_command_buffer(device, cmd_buffer)?;
        unsafe {
            let pre_resolve_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_READ,
                xfer_dst_layout,
                xfer_src_layout,
                ms_dst_img.get(),
                color_srr,
            );
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_resolve_barrier],
            );

            let resolve_region = vk::ImageResolve2 {
                s_type: vk::StructureType::IMAGE_RESOLVE_2,
                next: std::ptr::null(),
                src_subresource: color_srl,
                src_offset: zero_offset,
                dst_subresource: color_srl,
                dst_offset: zero_offset,
                extent: extent_vk,
            };
            let resolve_info = vk::ResolveImageInfo2 {
                s_type: vk::StructureType::RESOLVE_IMAGE_INFO_2,
                next: std::ptr::null(),
                src_image: ms_dst_img.get(),
                src_image_layout: xfer_src_layout,
                dst_image: ss_extra_img.image.get(),
                dst_image_layout: xfer_dst_layout,
                region_count: 1,
                regions: &resolve_region,
            };
            device.cmd_resolve_image2(cmd_buffer, &resolve_info);

            let pre_verif_barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    xfer_dst_layout,
                    xfer_src_layout,
                    ss_extra_img.image.get(),
                    color_srr,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_READ,
                    xfer_dst_layout,
                    xfer_src_layout,
                    ss_dst_img.image.get(),
                    color_srr,
                ),
            ];
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE | vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &pre_verif_barriers,
            );

            let buffer_copy_region = vk::BufferImageCopy2 {
                s_type: vk::StructureType::BUFFER_IMAGE_COPY_2,
                next: std::ptr::null(),
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: color_srl,
                image_offset: zero_offset,
                image_extent: extent_vk,
            };
            let ss_extra_copy_info = vk::CopyImageToBufferInfo2 {
                s_type: vk::StructureType::COPY_IMAGE_TO_BUFFER_INFO_2,
                next: std::ptr::null(),
                src_image: ss_extra_img.image.get(),
                src_image_layout: xfer_src_layout,
                dst_buffer: ss_extra_img.buffer.get(),
                region_count: 1,
                regions: &buffer_copy_region,
            };
            device.cmd_copy_image_to_buffer2(cmd_buffer, &ss_extra_copy_info);

            let mut ss_orig_copy_info = ss_extra_copy_info;
            ss_orig_copy_info.src_image = ss_dst_img.image.get();
            ss_orig_copy_info.dst_buffer = ss_dst_img.buffer.get();
            device.cmd_copy_image_to_buffer2(cmd_buffer, &ss_orig_copy_info);

            let host_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[host_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;
    }

    let tcu_format = map_vk_format(format).ok_or_else(|| TestError::InternalError("Unmapped format".to_string()))?;

    let mut orig_ref_level = TextureLevel::new(tcu_format, extent[0], extent[1], extent[2])?;
    clear(&mut orig_ref_level.get_access(), ss_src_color_vec);
    let mut extra_ref_level = TextureLevel::new(tcu_format, extent[0], extent[1], extent[2])?;
    clear(&mut extra_ref_level.get_access(), ms_src_color_vec);

    let orig_res_access = ConstPixelBufferAccess::new(tcu_format, extent, ss_dst_img.read_bytes(device)?);
    let extra_res_access = ConstPixelBufferAccess::new(tcu_format, extent, ss_extra_img.read_bytes(device)?);

    let threshold = [0.0f32; 4];
    let mut fail = false;
    let extra = float_threshold_compare(&extra_ref_level.get_const_access(), &extra_res_access, threshold);
    if !extra.ok {
        log::info!(
            "MultiSample: result differs from the reference by up to {:?}",
            extra.max_diff
        );
        fail = true;
    }
    let orig = float_threshold_compare(&orig_ref_level.get_const_access(), &orig_res_access, threshold);
    if !orig.ok {
        log::info!(
            "SingleSample: result differs from the reference by up to {:?}",
            orig.max_diff
        );
        fail = true;
    }
    if fail {
        return Err(TestError::Fail(
            "Unexpected results found in copy destination images; check log for details --".to_string(),
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `addImageToImageMiscTests`
pub fn add_image_to_image_misc_tests(group: &mut TestCaseGroup) {
    let barrier_cases = [
        ("ms_then_ss", None),
        (
            "ms_then_ss_bottom_of_pipe_barrier",
            Some(vk::PipelineStageFlags::BOTTOM_OF_PIPE),
        ),
        ("ms_then_ss_transfer_barrier", Some(vk::PipelineStageFlags::TRANSFER)),
        (
            "ms_then_ss_all_commands_barrier",
            Some(vk::PipelineStageFlags::ALL_COMMANDS),
        ),
    ];
    for (name, barrier_src_stage) in barrier_cases {
        group.add_child(Box::new(MultiSampleThenSingleSampleCase {
            name,
            barrier_src_stage,
        }) as Box<dyn TestCase>);
    }
}
