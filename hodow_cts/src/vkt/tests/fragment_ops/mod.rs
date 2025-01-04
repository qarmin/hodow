// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/fragment_ops/vktFragmentOperationsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Ported: `scissor`, `occlusion_query`, `transient_attachment_bit` and the plain and `discard_*` cases of `early_fragment`.

pub mod early_fragment_discard_tests;
pub mod early_fragment_samplecount_tests;
pub mod early_fragment_samplemask_tests;
pub mod early_fragment_tests;
pub mod occlusion_query_tests;
pub mod scissor_multi_viewport_tests;
pub mod scissor_tests;
pub mod transient_attachment_tests;

use vulkanalia::prelude::v1_0::*;

use crate::vk::image_util::{
    make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
};
use crate::vk::obj_util::make_memory_barrier;
use crate::vkt::TestCaseGroup;

/// `vk::copyImageToBuffer` for a colour image left in COLOR_ATTACHMENT_OPTIMAL by a render pass.
pub fn copy_image_to_buffer(
    device: &Device,
    cmd: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    width: u32,
    height: u32,
) {
    let to_transfer = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    );
    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width,
            height,
            depth: 1,
        },
        make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
    );
    let to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[to_transfer],
        );
        device.cmd_copy_image_to_buffer(
            cmd,
            image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            buffer,
            &[copy_region],
        );
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[to_host],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// `createTests` - the `fragment_operations` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fragment_operations");
    group.add_child(scissor_tests::create_scissor_tests());
    group.add_child(early_fragment_tests::create_early_fragment_tests());
    group.add_child(occlusion_query_tests::create_occlusion_query_tests());
    group.add_child(transient_attachment_tests::create_transient_attachment_tests());
    group
}
