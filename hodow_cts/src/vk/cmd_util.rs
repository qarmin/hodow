// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/framework/vulkan/vkCmdUtil.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::TestError;
use crate::vk::VkResultExt;

/// `vk::beginCommandBuffer`
pub fn begin_command_buffer(device: &Device, cmd_buffer: vk::CommandBuffer) -> Result<(), TestError> {
    let info = vk::CommandBufferBeginInfo::builder().flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT);
    unsafe { device.begin_command_buffer(cmd_buffer, &info) }.vk_check("vkBeginCommandBuffer")
}

/// `vk::beginSecondaryCommandBuffer`, narrowed to a buffer that continues a render
/// pass. The inheritance info is what makes the recorded draws legal outside a
/// `vkCmdBeginRenderPass`, so the render pass and subpass have to match the primary's
/// exactly; the framebuffer is only a hint and may be null.
pub fn begin_secondary_command_buffer(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    render_pass: vk::RenderPass,
    subpass: u32,
    framebuffer: vk::Framebuffer,
) -> Result<(), TestError> {
    let inheritance = vk::CommandBufferInheritanceInfo::builder()
        .render_pass(render_pass)
        .subpass(subpass)
        .framebuffer(framebuffer)
        .occlusion_query_enable(false);
    let info = vk::CommandBufferBeginInfo::builder()
        .flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT | vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE)
        .inheritance_info(&inheritance);
    unsafe { device.begin_command_buffer(cmd_buffer, &info) }.vk_check("vkBeginCommandBuffer")
}

/// `vk::endCommandBuffer`
pub fn end_command_buffer(device: &Device, cmd_buffer: vk::CommandBuffer) -> Result<(), TestError> {
    unsafe { device.end_command_buffer(cmd_buffer) }.vk_check("vkEndCommandBuffer")
}

/// `vk::submitCommandsAndWait`
///
/// Waits on a fence rather than `vkQueueWaitIdle` because that is what upstream does
/// and because a fence with a finite timeout is what lets the runner tell a hung GPU
/// apart from a slow one.
pub fn submit_commands_and_wait(
    device: &Device,
    queue: vk::Queue,
    cmd_buffer: vk::CommandBuffer,
) -> Result<(), TestError> {
    let fence_info = vk::FenceCreateInfo::builder();
    let fence = unsafe { device.create_fence(&fence_info, None) }.vk_check("vkCreateFence")?;

    let result = (|| -> Result<(), TestError> {
        let cmd_buffers = [cmd_buffer];
        let submit_info = vk::SubmitInfo::builder().command_buffers(&cmd_buffers);
        unsafe { device.queue_submit(queue, &[submit_info], fence) }.vk_check("vkQueueSubmit")?;
        // An infinite timeout is deliberate: VK_TIMEOUT is a *success* code, so a
        // finite wait here would silently return Ok on a hung GPU. Hangs are the
        // runner's watchdog to detect, and it can attribute them to a case.
        unsafe { device.wait_for_fences(&[fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
        Ok(())
    })();

    unsafe { device.destroy_fence(fence, None) };
    result
}

/// `vk::beginRenderPass`
pub fn begin_render_pass(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    render_pass: vk::RenderPass,
    framebuffer: vk::Framebuffer,
    render_area: vk::Rect2D,
    clear_value: vk::ClearValue,
) {
    let clear_values = [clear_value];
    let info = vk::RenderPassBeginInfo::builder()
        .render_pass(render_pass)
        .framebuffer(framebuffer)
        .render_area(render_area)
        .clear_values(&clear_values);
    unsafe { device.cmd_begin_render_pass(cmd_buffer, &info, vk::SubpassContents::INLINE) };
}

/// `vk::endRenderPass`
pub fn end_render_pass(device: &Device, cmd_buffer: vk::CommandBuffer) {
    unsafe { device.cmd_end_render_pass(cmd_buffer) };
}

/// `vk::makeRect2D`
pub fn make_rect_2d(x: i32, y: i32, width: u32, height: u32) -> vk::Rect2D {
    vk::Rect2D {
        offset: vk::Offset2D { x, y },
        extent: vk::Extent2D { width, height },
    }
}
