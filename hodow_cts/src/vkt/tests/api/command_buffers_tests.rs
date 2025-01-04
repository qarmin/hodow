// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiCommandBuffersTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Ported so far, out of `dEQP-VK.api.command_buffers.*` (about a quarter of the group):
//   pool_create_null_params, pool_create_non_null_allocator, pool_create_transient_bit,
//   pool_create_reset_bit, pool_reset_release_res, pool_reset_no_flags_res, pool_reset_reuse,
//   allocate_single_primary, allocate_many_primary, allocate_single_secondary,
//   allocate_many_secondary, execute_small_primary, execute_large_primary, reset_implicit,
//   trim_command_pool, trim_command_pool_secondary, record_single_primary, record_many_primary,
//   record_single_secondary, record_many_secondary, submit_twice_primary, submit_twice_secondary,
//   record_one_time_submit_primary, record_one_time_submit_secondary, submit_count_non_zero,
//   submit_count_equal_zero, submit_wait_single_semaphore, submit_wait_many_semaphores,
//   submit_null_fence, submit_two_buffers_one_buffer_null_with_fence, secondary_execute,
//   secondary_execute_twice, recording_to_ininitial, executable_to_ininitial, recording_to_invalid,
//   executable_to_invalid
// Everything else upstream (the render-pass-continue and
// inheritance cases, nested/secondary execution, state transition cases, ...) is absent rather
// than present-and-skipped. `CommandBufferBareTestEnvironment` and
// `CommandBufferRenderPassTestEnvironment` are not ported because only those later cases use them.
//
// `beginCommandBuffer(vk, cmd, 0u)` is `begin_command_buffer_flags` below: the shared
// `cmd_util::begin_command_buffer` always sets ONE_TIME_SUBMIT, which these cases do not.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, DeviceV1_2, InstanceV1_1};

use super::case_util::{add_case, add_function_case_no_support};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::alloc_callback_util::AllocationCallbackRecorder;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::obj_util::allocate_command_buffer;
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

/// `beginCommandBuffer(vk, commandBuffer, flags)`
fn begin_command_buffer_flags(
    device: &Device,
    command_buffer: vk::CommandBuffer,
    flags: vk::CommandBufferUsageFlags,
) -> Result<(), TestError> {
    let info = vk::CommandBufferBeginInfo::builder().flags(flags);
    unsafe { device.begin_command_buffer(command_buffer, &info) }.vk_check("vkBeginCommandBuffer")
}

/// `createCommandPool(vk, device, flags, queueFamilyIndex)`
fn create_command_pool<'a>(
    context: &'a Context<'a>,
    flags: vk::CommandPoolCreateFlags,
) -> Result<Unique<'a, vk::CommandPool>, TestError> {
    let device = context.get_device();
    let info = vk::CommandPoolCreateInfo::builder()
        .flags(flags)
        .queue_family_index(context.get_universal_queue_family_index());
    Ok(Unique::new(
        device,
        unsafe { device.create_command_pool(&info, None) }.vk_check("vkCreateCommandPool")?,
    ))
}

/// `checkEventSupport`
fn check_event_support(context: &Context<'_>) -> Result<(), TestError> {
    if context.is_device_functionality_supported("VK_KHR_portability_subset") {
        let mut portability_features = vk::PhysicalDevicePortabilitySubsetFeaturesKHR::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut portability_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        if portability_features.events == vk::FALSE {
            return Err(TestError::NotSupported(
                "VK_KHR_portability_subset: Events are not supported by this implementation".to_string(),
            ));
        }
    }
    Ok(())
}

// Testcases
// ********* 19.1. Command Pools (5.1 in VK 1.0 Spec) ***************************

/// `createPoolNullParamsTest`
fn create_pool_null_params_test(context: &Context<'_>) -> TestOutcome {
    let _pool = create_command_pool(context, vk::CommandPoolCreateFlags::empty())?;

    Ok(TestStatus::pass("Command Pool allocated correctly."))
}

/// `createPoolNonNullAllocatorTest`
fn create_pool_non_null_allocator_test(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();
    let allocation_callbacks = AllocationCallbackRecorder::new();

    let cmd_pool_params = vk::CommandPoolCreateInfo::builder()
        .flags(vk::CommandPoolCreateFlags::empty())
        .queue_family_index(context.get_universal_queue_family_index());

    let _pool = Unique::with_allocator(
        vk_device,
        unsafe { vk_device.create_command_pool(&cmd_pool_params, Some(allocation_callbacks.callbacks())) }
            .vk_check("vkCreateCommandPool")?,
        Some(allocation_callbacks.callbacks()),
    );

    Ok(TestStatus::pass("Command Pool allocated correctly."))
}

/// `createPoolTransientBitTest`
fn create_pool_transient_bit_test(context: &Context<'_>) -> TestOutcome {
    let _pool = create_command_pool(context, vk::CommandPoolCreateFlags::TRANSIENT)?;

    Ok(TestStatus::pass("Command Pool allocated correctly."))
}

/// `createPoolResetBitTest`
fn create_pool_reset_bit_test(context: &Context<'_>) -> TestOutcome {
    let _pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;

    Ok(TestStatus::pass("Command Pool allocated correctly."))
}

/// `resetPoolReleaseResourcesBitTest`
fn reset_pool_release_resources_bit_test(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();
    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::empty())?;

    unsafe { vk_device.reset_command_pool(*cmd_pool, vk::CommandPoolResetFlags::RELEASE_RESOURCES) }
        .vk_check("vkResetCommandPool")?;

    Ok(TestStatus::pass("Command Pool allocated correctly."))
}

/// `resetPoolNoFlagsTest`
fn reset_pool_no_flags_test(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();
    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::empty())?;

    unsafe { vk_device.reset_command_pool(*cmd_pool, vk::CommandPoolResetFlags::empty()) }
        .vk_check("vkResetCommandPool")?;

    Ok(TestStatus::pass("Command Pool allocated correctly."))
}

/// `executeCommandBuffer`
fn execute_command_buffer(
    device: &Device,
    queue: vk::Queue,
    command_buffer: vk::CommandBuffer,
    exit_before_end_command_buffer: bool,
) -> Result<bool, TestError> {
    let event = Unique::new(
        device,
        unsafe { device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
    );
    begin_command_buffer_flags(device, command_buffer, vk::CommandBufferUsageFlags::empty())?;
    {
        let stage_mask = vk::PipelineStageFlags::ALL_COMMANDS;
        unsafe { device.cmd_set_event(command_buffer, *event, stage_mask) };
        if exit_before_end_command_buffer {
            return Ok(exit_before_end_command_buffer);
        }
    }
    end_command_buffer(device, command_buffer)?;

    submit_commands_and_wait(device, queue, command_buffer)?;

    // check if buffer has been executed
    let result = unsafe { device.get_event_status(*event) };
    Ok(result == Ok(vk::SuccessCode::EVENT_SET))
}

/// `resetPoolReuseTest`
fn reset_pool_reuse_test(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();

    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::empty())?;
    let cmd_buf_params = vk::CommandBufferAllocateInfo::builder()
        .command_pool(*cmd_pool)
        .level(vk::CommandBufferLevel::PRIMARY)
        .command_buffer_count(1);
    let allocate_one = || -> Result<vk::CommandBuffer, TestError> {
        let buffers =
            unsafe { vk_device.allocate_command_buffers(&cmd_buf_params) }.vk_check("vkAllocateCommandBuffers")?;
        Ok(buffers[0])
    };
    let command_buffers = [allocate_one()?, allocate_one()?];

    let can_finish_earlier = true;

    // The first call is evaluated first, so the second only runs when it passed, exactly as the `&&` chain upstream.
    if !execute_command_buffer(vk_device, queue, command_buffers[0], false)? && can_finish_earlier {
        return Ok(TestStatus::fail("Failed"));
    }
    if !execute_command_buffer(vk_device, queue, command_buffers[1], true)? && can_finish_earlier {
        return Ok(TestStatus::fail("Failed"));
    }

    unsafe { vk_device.reset_command_pool(*cmd_pool, vk::CommandPoolResetFlags::RELEASE_RESOURCES) }
        .vk_check("vkResetCommandPool")?;

    if !execute_command_buffer(vk_device, queue, command_buffers[0], false)? && can_finish_earlier {
        return Ok(TestStatus::fail("Failed"));
    }
    if !execute_command_buffer(vk_device, queue, command_buffers[1], false)? && can_finish_earlier {
        return Ok(TestStatus::fail("Failed"));
    }

    {
        let after_reset_command_buffer = allocate_one()?;
        let executed = execute_command_buffer(vk_device, queue, after_reset_command_buffer, false);
        unsafe { vk_device.free_command_buffers(*cmd_pool, &[after_reset_command_buffer]) };
        if !executed? && can_finish_earlier {
            return Ok(TestStatus::fail("Failed"));
        }
    }

    unsafe { vk_device.free_command_buffers(*cmd_pool, &command_buffers) };

    Ok(TestStatus::pass("Passed"))
}

// ******** 19.2. Command Buffer Lifetime (5.2 in VK 1.0 Spec) ******************

/// `allocatePrimaryBufferTest` and `allocateSecondaryBufferTest`
fn allocate_single_buffer_test(context: &Context<'_>, level: vk::CommandBufferLevel) -> TestOutcome {
    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;

    // Command buffer
    let _cmd_buf = allocate_command_buffer(context.get_device(), *cmd_pool, level)?;

    Ok(TestStatus::pass("Buffer was created correctly."))
}

fn allocate_primary_buffer_test(context: &Context<'_>) -> TestOutcome {
    allocate_single_buffer_test(context, vk::CommandBufferLevel::PRIMARY)
}

fn allocate_secondary_buffer_test(context: &Context<'_>) -> TestOutcome {
    allocate_single_buffer_test(context, vk::CommandBufferLevel::SECONDARY)
}

/// `allocateManyPrimaryBuffersTest` and `allocateManySecondaryBuffersTest`
fn allocate_many_buffers_test(context: &Context<'_>, level: vk::CommandBufferLevel, name: &str) -> TestOutcome {
    let vk_device = context.get_device();
    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;

    // \todo Determining the minimum number of command buffers should be a function of available system memory and driver capabilities.
    let min_command_buffer: u32 = if cfg!(target_pointer_width = "32") { 1024 } else { 10000 };

    // Command buffer
    let cmd_buf_params = vk::CommandBufferAllocateInfo::builder()
        .command_pool(*cmd_pool)
        .level(level)
        .command_buffer_count(min_command_buffer);

    // allocate the minimum required amount of buffers
    let cmd_buffers =
        unsafe { vk_device.allocate_command_buffers(&cmd_buf_params) }.vk_check("vkAllocateCommandBuffers")?;
    unsafe { vk_device.free_command_buffers(*cmd_pool, &cmd_buffers) };

    Ok(TestStatus::pass(format!(
        "{name} succeded: created {min_command_buffer} command buffers"
    )))
}

fn allocate_many_primary_buffers_test(context: &Context<'_>) -> TestOutcome {
    allocate_many_buffers_test(
        context,
        vk::CommandBufferLevel::PRIMARY,
        "allocateManyPrimaryBuffersTest",
    )
}

fn allocate_many_secondary_buffers_test(context: &Context<'_>) -> TestOutcome {
    allocate_many_buffers_test(
        context,
        vk::CommandBufferLevel::SECONDARY,
        "allocateManySecondaryBuffersTest",
    )
}

/// `executePrimaryBufferTest`
fn execute_primary_buffer_test(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();

    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;

    // Command buffer
    let prim_cmd_buf = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    // create event that will be used to check if secondary command buffer has been executed
    let event = Unique::new(
        vk_device,
        unsafe { vk_device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
    );

    // reset event
    unsafe { vk_device.reset_event(*event) }.vk_check("vkResetEvent")?;

    // record primary command buffer
    begin_command_buffer_flags(vk_device, *prim_cmd_buf, vk::CommandBufferUsageFlags::empty())?;
    {
        // allow execution of event during every stage of pipeline
        let stage_mask = vk::PipelineStageFlags::ALL_COMMANDS;

        // record setting event
        unsafe { vk_device.cmd_set_event(*prim_cmd_buf, *event, stage_mask) };
    }
    end_command_buffer(vk_device, *prim_cmd_buf)?;

    submit_commands_and_wait(vk_device, queue, *prim_cmd_buf)?;

    // check if buffer has been executed
    if unsafe { vk_device.get_event_status(*event) } == Ok(vk::SuccessCode::EVENT_SET) {
        return Ok(TestStatus::pass("Execute Primary Command Buffer succeeded"));
    }

    Ok(TestStatus::fail("Execute Primary Command Buffer FAILED"))
}

/// `executeLargePrimaryBufferTest`
fn execute_large_primary_buffer_test(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();
    let large_buffer_size: u32 = 10000;

    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;

    // Command buffer
    let prim_cmd_buf = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    let mut events: Vec<Unique<'_, vk::Event>> = Vec::with_capacity(large_buffer_size as usize);
    for _ in 0..large_buffer_size {
        events.push(Unique::new(
            vk_device,
            unsafe { vk_device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
        ));
    }

    // record primary command buffer
    begin_command_buffer_flags(vk_device, *prim_cmd_buf, vk::CommandBufferUsageFlags::empty())?;
    {
        // set all the events
        for event in &events {
            unsafe { vk_device.cmd_set_event(*prim_cmd_buf, event.get(), vk::PipelineStageFlags::ALL_COMMANDS) };
        }
    }
    end_command_buffer(vk_device, *prim_cmd_buf)?;

    submit_commands_and_wait(vk_device, queue, *prim_cmd_buf)?;

    // check if the buffer was executed correctly - all events had their status
    // changed
    for event in &events {
        if unsafe { vk_device.get_event_status(event.get()) } != Ok(vk::SuccessCode::EVENT_SET) {
            return Ok(TestStatus::fail("An event was not set."));
        }
    }

    Ok(TestStatus::pass("All events set correctly."))
}

/// `resetBufferImplicitlyTest`
fn reset_buffer_implicitly_test(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();

    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;

    // Command buffer
    let cmd_buf = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    let event = Unique::new(
        vk_device,
        unsafe { vk_device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
    );

    // Put the command buffer in recording state.
    begin_command_buffer_flags(vk_device, *cmd_buf, vk::CommandBufferUsageFlags::empty())?;
    {
        // Set the event
        unsafe { vk_device.cmd_set_event(*cmd_buf, *event, vk::PipelineStageFlags::ALL_COMMANDS) };
    }
    end_command_buffer(vk_device, *cmd_buf)?;

    submit_commands_and_wait(vk_device, queue, *cmd_buf)?;

    // Check if the buffer was executed
    if unsafe { vk_device.get_event_status(*event) } != Ok(vk::SuccessCode::EVENT_SET) {
        return Ok(TestStatus::fail("Failed to set the event."));
    }

    // Reset the event
    unsafe { vk_device.reset_event(*event) }.ok();
    if unsafe { vk_device.get_event_status(*event) } != Ok(vk::SuccessCode::EVENT_RESET) {
        return Ok(TestStatus::fail("Failed to reset the event."));
    }

    // Reset the command buffer by putting it in recording state again. This
    // should empty the command buffer.
    begin_command_buffer_flags(vk_device, *cmd_buf, vk::CommandBufferUsageFlags::empty())?;
    end_command_buffer(vk_device, *cmd_buf)?;

    // Submit the command buffer after resetting. It should have no commands
    // recorded, so the event should remain unsignaled.
    submit_commands_and_wait(vk_device, queue, *cmd_buf)?;

    // Check if the event remained unset.
    if unsafe { vk_device.get_event_status(*event) } == Ok(vk::SuccessCode::EVENT_RESET) {
        Ok(TestStatus::pass("Buffer was reset correctly."))
    } else {
        Ok(TestStatus::fail("Buffer was not reset correctly."))
    }
}

/// `submitAndCheck`
fn submit_and_check(
    context: &Context<'_>,
    cmd_buffers: &[vk::CommandBuffer],
    events: &[Unique<'_, vk::Event>],
) -> Result<bool, TestError> {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();
    let fence = Unique::new(
        vk_device,
        unsafe { vk_device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );

    let submit_info = vk::SubmitInfo::builder().command_buffers(cmd_buffers);

    unsafe { vk_device.queue_submit(queue, &[submit_info], *fence) }.vk_check("vkQueueSubmit")?;
    unsafe { vk_device.wait_for_fences(&[*fence], false, u64::MAX) }.vk_check("vkWaitForFences")?;

    for event in events {
        if unsafe { vk_device.get_event_status(event.get()) } != Ok(vk::SuccessCode::EVENT_SET) {
            return Ok(false);
        }
        unsafe { vk_device.reset_event(event.get()) }.ok();
    }

    Ok(true)
}

/// `createCommadBuffers`
fn create_command_buffers(
    device: &Device,
    buffer_count: u32,
    pool: vk::CommandPool,
    cmd_buffer_level: vk::CommandBufferLevel,
) -> Result<Vec<vk::CommandBuffer>, TestError> {
    let cmd_buf_params = vk::CommandBufferAllocateInfo::builder()
        .command_pool(pool)
        .level(cmd_buffer_level)
        .command_buffer_count(buffer_count);
    unsafe { device.allocate_command_buffers(&cmd_buf_params) }.vk_check("vkAllocateCommandBuffers")
}

/// `addCommandsToBuffer`
fn add_commands_to_buffer(
    device: &Device,
    cmd_buffers: &[vk::CommandBuffer],
    events: &[Unique<'_, vk::Event>],
) -> Result<(), TestError> {
    let sec_cmd_buf_inherit_info = vk::CommandBufferInheritanceInfo::builder()
        .render_pass(vk::RenderPass::null())
        .subpass(0)
        .framebuffer(vk::Framebuffer::null())
        .occlusion_query_enable(false)
        .query_flags(vk::QueryControlFlags::empty())
        .pipeline_statistics(vk::QueryPipelineStatisticFlags::empty());

    let cmd_buf_begin_info = vk::CommandBufferBeginInfo::builder()
        .flags(vk::CommandBufferUsageFlags::empty())
        .inheritance_info(&sec_cmd_buf_inherit_info);

    for (buffer_ndx, &cmd_buffer) in cmd_buffers.iter().enumerate() {
        unsafe { device.begin_command_buffer(cmd_buffer, &cmd_buf_begin_info) }.vk_check("vkBeginCommandBuffer")?;
        unsafe {
            device.cmd_set_event(
                cmd_buffer,
                events[buffer_ndx % events.len()].get(),
                vk::PipelineStageFlags::ALL_COMMANDS,
            )
        };
        end_command_buffer(device, cmd_buffer)?;
    }
    Ok(())
}

/// `executeSecondaryCmdBuffer`
fn execute_secondary_cmd_buffer(
    context: &Context<'_>,
    pool: vk::CommandPool,
    cmd_buffers_secondary: &[vk::CommandBuffer],
    events: &[Unique<'_, vk::Event>],
) -> Result<bool, TestError> {
    let vk_device = context.get_device();

    let cmd_buffer = create_command_buffers(vk_device, 1, pool, vk::CommandBufferLevel::PRIMARY)?;
    begin_command_buffer_flags(vk_device, cmd_buffer[0], vk::CommandBufferUsageFlags::empty())?;
    unsafe { vk_device.cmd_execute_commands(cmd_buffer[0], cmd_buffers_secondary) };
    end_command_buffer(vk_device, cmd_buffer[0])?;

    let return_value = submit_and_check(context, &cmd_buffer, events);
    unsafe { vk_device.free_command_buffers(pool, &cmd_buffer) };
    return_value
}

/// `trimCommandPoolTest`
fn trim_command_pool_test(context: &Context<'_>, cmd_buffer_level: vk::CommandBufferLevel) -> TestOutcome {
    let vk_device = context.get_device();

    // test parameters
    let cmd_buffer_iteration_count = 300u32;
    let cmd_buffer_count = 10u32;

    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;

    let mut events: Vec<Unique<'_, vk::Event>> = Vec::new();
    for _ in 0..cmd_buffer_count {
        events.push(Unique::new(
            vk_device,
            unsafe { vk_device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
        ));
    }

    {
        let mut cmd_buffers = create_command_buffers(vk_device, cmd_buffer_count, *cmd_pool, cmd_buffer_level)?;

        for cmd_buffer_iterationr_ndx in 0..cmd_buffer_iteration_count {
            add_commands_to_buffer(vk_device, &cmd_buffers, &events)?;

            // Peak, situation when we use a lot more command buffers
            if cmd_buffer_iterationr_ndx % 10 == 0 {
                let cmd_buffers_peak =
                    create_command_buffers(vk_device, cmd_buffer_count * 10, *cmd_pool, cmd_buffer_level)?;
                add_commands_to_buffer(vk_device, &cmd_buffers_peak, &events)?;

                match cmd_buffer_level {
                    vk::CommandBufferLevel::PRIMARY => {
                        if !submit_and_check(context, &cmd_buffers_peak, &events)? {
                            return Ok(TestStatus::fail("Fail"));
                        }
                    }
                    _ => {
                        if !execute_secondary_cmd_buffer(context, *cmd_pool, &cmd_buffers_peak, &events)? {
                            return Ok(TestStatus::fail("Fail"));
                        }
                    }
                }
                unsafe { vk_device.free_command_buffers(*cmd_pool, &cmd_buffers_peak) };
            }

            unsafe { vk_device.trim_command_pool(*cmd_pool, vk::CommandPoolTrimFlags::empty()) };

            match cmd_buffer_level {
                vk::CommandBufferLevel::PRIMARY => {
                    if !submit_and_check(context, &cmd_buffers, &events)? {
                        return Ok(TestStatus::fail("Fail"));
                    }
                }
                _ => {
                    if !execute_secondary_cmd_buffer(context, *cmd_pool, &cmd_buffers, &events)? {
                        return Ok(TestStatus::fail("Fail"));
                    }
                }
            }

            let mut buffer_ndx = cmd_buffer_iterationr_ndx % 3;
            while buffer_ndx < cmd_buffer_count {
                unsafe { vk_device.free_command_buffers(*cmd_pool, &[cmd_buffers[buffer_ndx as usize]]) };
                cmd_buffers[buffer_ndx as usize] =
                    create_command_buffers(vk_device, 1, *cmd_pool, cmd_buffer_level)?[0];
                buffer_ndx += 2;
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

fn trim_command_pool_primary_test(context: &Context<'_>) -> TestOutcome {
    trim_command_pool_test(context, vk::CommandBufferLevel::PRIMARY)
}

fn trim_command_pool_secondary_test(context: &Context<'_>) -> TestOutcome {
    trim_command_pool_test(context, vk::CommandBufferLevel::SECONDARY)
}

// ******** 19.3. Command Buffer Recording (5.3 in VK 1.0 Spec) *****************

/// `recordSinglePrimaryBufferTest`
fn record_single_primary_buffer_test(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();

    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;

    // Command buffer
    let prim_cmd_buf = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    // create event that will be used to check if secondary command buffer has been executed
    let event = Unique::new(
        vk_device,
        unsafe { vk_device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
    );

    // record primary command buffer
    begin_command_buffer_flags(vk_device, *prim_cmd_buf, vk::CommandBufferUsageFlags::empty())?;
    {
        // record setting event
        unsafe { vk_device.cmd_set_event(*prim_cmd_buf, *event, vk::PipelineStageFlags::ALL_COMMANDS) };
    }
    end_command_buffer(vk_device, *prim_cmd_buf)?;

    Ok(TestStatus::pass("Primary buffer recorded successfully."))
}

/// `minNumCommands` of `recordLargePrimaryBufferTest` / `recordLargeSecondaryBufferTest`
const MIN_NUM_COMMANDS: u64 = 10000;

/// `recordLargePrimaryBufferTest`
fn record_large_primary_buffer_test(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();

    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;

    // Command buffer
    let prim_cmd_buf = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    // create event that will be used to check if secondary command buffer has been executed
    let event = Unique::new(
        vk_device,
        unsafe { vk_device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
    );

    // reset event
    unsafe { vk_device.reset_event(*event) }.vk_check("vkResetEvent")?;

    // record primary command buffer
    begin_command_buffer_flags(vk_device, *prim_cmd_buf, vk::CommandBufferUsageFlags::empty())?;
    {
        // allow execution of event during every stage of pipeline
        let stage_mask = vk::PipelineStageFlags::ALL_COMMANDS;

        for _ in 0..MIN_NUM_COMMANDS / 2 {
            // record setting event
            unsafe { vk_device.cmd_set_event(*prim_cmd_buf, *event, stage_mask) };

            // record resetting event
            unsafe { vk_device.cmd_reset_event(*prim_cmd_buf, *event, stage_mask) };
        }
    }
    end_command_buffer(vk_device, *prim_cmd_buf)?;

    submit_commands_and_wait(vk_device, queue, *prim_cmd_buf)?;

    Ok(TestStatus::pass("hugeTest succeeded"))
}

/// `secCmdBufBeginInfo` with its `secCmdBufInheritInfo`: every inheritance field null/zero.
fn begin_secondary_command_buffer_without_inheritance(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    flags: vk::CommandBufferUsageFlags,
) -> Result<(), TestError> {
    let sec_cmd_buf_inherit_info = vk::CommandBufferInheritanceInfo::builder()
        .render_pass(vk::RenderPass::null())
        .subpass(0)
        .framebuffer(vk::Framebuffer::null())
        .occlusion_query_enable(false)
        .query_flags(vk::QueryControlFlags::empty())
        .pipeline_statistics(vk::QueryPipelineStatisticFlags::empty());
    let sec_cmd_buf_begin_info = vk::CommandBufferBeginInfo::builder()
        .flags(flags)
        .inheritance_info(&sec_cmd_buf_inherit_info);

    unsafe { device.begin_command_buffer(cmd_buffer, &sec_cmd_buf_begin_info) }.vk_check("vkBeginCommandBuffer")
}

/// `recordSingleSecondaryBufferTest`
fn record_single_secondary_buffer_test(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();

    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;

    // Command buffer
    let sec_cmd_buf = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

    // create event that will be used to check if secondary command buffer has been executed
    let event = Unique::new(
        vk_device,
        unsafe { vk_device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
    );

    // record primary command buffer
    begin_secondary_command_buffer_without_inheritance(vk_device, *sec_cmd_buf, vk::CommandBufferUsageFlags::empty())?;
    {
        // record setting event
        unsafe { vk_device.cmd_set_event(*sec_cmd_buf, *event, vk::PipelineStageFlags::ALL_COMMANDS) };
    }
    end_command_buffer(vk_device, *sec_cmd_buf)?;

    Ok(TestStatus::pass("Secondary buffer recorded successfully."))
}

/// `recordLargeSecondaryBufferTest`
fn record_large_secondary_buffer_test(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();

    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;
    let sec_cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;
    // Command buffer
    let prim_cmd_buf = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    let sec_cmd_buf = allocate_command_buffer(vk_device, *sec_cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

    // create event that will be used to check if secondary command buffer has been executed
    let event = Unique::new(
        vk_device,
        unsafe { vk_device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
    );

    // reset event
    unsafe { vk_device.reset_event(*event) }.vk_check("vkResetEvent")?;

    // record primary command buffer
    begin_command_buffer_flags(vk_device, *prim_cmd_buf, vk::CommandBufferUsageFlags::empty())?;
    {
        // record secondary command buffer
        begin_secondary_command_buffer_without_inheritance(
            vk_device,
            *sec_cmd_buf,
            vk::CommandBufferUsageFlags::empty(),
        )?;
        {
            // allow execution of event during every stage of pipeline
            let stage_mask = vk::PipelineStageFlags::ALL_COMMANDS;

            for _ in 0..MIN_NUM_COMMANDS / 2 {
                // record setting event
                unsafe { vk_device.cmd_set_event(*sec_cmd_buf, *event, stage_mask) };

                // record resetting event
                unsafe { vk_device.cmd_reset_event(*sec_cmd_buf, *event, stage_mask) };
            }
        }

        // end recording of secondary buffers
        end_command_buffer(vk_device, *sec_cmd_buf)?;

        // execute secondary buffer
        unsafe { vk_device.cmd_execute_commands(*prim_cmd_buf, &[*sec_cmd_buf]) };
    }
    end_command_buffer(vk_device, *prim_cmd_buf)?;

    submit_commands_and_wait(vk_device, queue, *prim_cmd_buf)?;

    Ok(TestStatus::pass("hugeTest succeeded"))
}

/// `submitPrimaryBufferTwiceTest`
fn submit_primary_buffer_twice_test(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();

    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;

    // Command buffer
    let prim_cmd_buf = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    // create event that will be used to check if secondary command buffer has been executed
    let event = Unique::new(
        vk_device,
        unsafe { vk_device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
    );

    // reset event
    unsafe { vk_device.reset_event(*event) }.vk_check("vkResetEvent")?;

    // record primary command buffer
    begin_command_buffer_flags(vk_device, *prim_cmd_buf, vk::CommandBufferUsageFlags::empty())?;
    {
        // allow execution of event during every stage of pipeline
        let stage_mask = vk::PipelineStageFlags::ALL_COMMANDS;

        // record setting event
        unsafe { vk_device.cmd_set_event(*prim_cmd_buf, *event, stage_mask) };
    }
    end_command_buffer(vk_device, *prim_cmd_buf)?;

    submit_commands_and_wait(vk_device, queue, *prim_cmd_buf)?;

    // check if buffer has been executed
    if unsafe { vk_device.get_event_status(*event) } != Ok(vk::SuccessCode::EVENT_SET) {
        return Ok(TestStatus::fail("Submit Twice Test FAILED"));
    }

    // reset event
    unsafe { vk_device.reset_event(*event) }.vk_check("vkResetEvent")?;

    submit_commands_and_wait(vk_device, queue, *prim_cmd_buf)?;

    // check if buffer has been executed
    if unsafe { vk_device.get_event_status(*event) } != Ok(vk::SuccessCode::EVENT_SET) {
        Ok(TestStatus::fail("Submit Twice Test FAILED"))
    } else {
        Ok(TestStatus::pass("Submit Twice Test succeeded"))
    }
}

/// `submitSecondaryBufferTwiceTest`
fn submit_secondary_buffer_twice_test(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();

    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;
    let sec_cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;

    // Command buffer
    let prim_cmd_buf1 = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let prim_cmd_buf2 = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    // Secondary Command buffer
    let sec_cmd_buf = allocate_command_buffer(vk_device, *sec_cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

    // create event that will be used to check if secondary command buffer has been executed
    let event = Unique::new(
        vk_device,
        unsafe { vk_device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
    );

    // reset event
    unsafe { vk_device.reset_event(*event) }.vk_check("vkResetEvent")?;

    // record first primary command buffer
    begin_command_buffer_flags(vk_device, *prim_cmd_buf1, vk::CommandBufferUsageFlags::empty())?;
    {
        // record secondary command buffer
        begin_secondary_command_buffer_without_inheritance(
            vk_device,
            *sec_cmd_buf,
            vk::CommandBufferUsageFlags::empty(),
        )?;
        {
            // allow execution of event during every stage of pipeline
            let stage_mask = vk::PipelineStageFlags::ALL_COMMANDS;

            // record setting event
            unsafe { vk_device.cmd_set_event(*sec_cmd_buf, *event, stage_mask) };
        }

        // end recording of secondary buffers
        end_command_buffer(vk_device, *sec_cmd_buf)?;

        // execute secondary buffer
        unsafe { vk_device.cmd_execute_commands(*prim_cmd_buf1, &[*sec_cmd_buf]) };
    }
    end_command_buffer(vk_device, *prim_cmd_buf1)?;

    submit_commands_and_wait(vk_device, queue, *prim_cmd_buf1)?;

    // check if secondary buffer has been executed
    if unsafe { vk_device.get_event_status(*event) } != Ok(vk::SuccessCode::EVENT_SET) {
        return Ok(TestStatus::fail("Submit Twice Secondary Command Buffer FAILED"));
    }

    // reset first primary buffer
    unsafe { vk_device.reset_command_buffer(*prim_cmd_buf1, vk::CommandBufferResetFlags::empty()) }
        .vk_check("vkResetCommandBuffer")?;

    // reset event to allow receiving it again
    unsafe { vk_device.reset_event(*event) }.vk_check("vkResetEvent")?;

    // record second primary command buffer
    begin_command_buffer_flags(vk_device, *prim_cmd_buf2, vk::CommandBufferUsageFlags::empty())?;
    {
        // execute secondary buffer
        unsafe { vk_device.cmd_execute_commands(*prim_cmd_buf2, &[*sec_cmd_buf]) };
    }
    // end recording
    end_command_buffer(vk_device, *prim_cmd_buf2)?;

    submit_commands_and_wait(vk_device, queue, *prim_cmd_buf2)?;

    // check if secondary buffer has been executed
    if unsafe { vk_device.get_event_status(*event) } != Ok(vk::SuccessCode::EVENT_SET) {
        Ok(TestStatus::fail("Submit Twice Secondary Command Buffer FAILED"))
    } else {
        Ok(TestStatus::pass("Submit Twice Secondary Command Buffer succeeded"))
    }
}

/// `oneTimeSubmitFlagPrimaryBufferTest`
fn one_time_submit_flag_primary_buffer_test(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();

    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;

    // Command buffer
    let prim_cmd_buf = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    // create event that will be used to check if secondary command buffer has been executed
    let event = Unique::new(
        vk_device,
        unsafe { vk_device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
    );

    // reset event
    unsafe { vk_device.reset_event(*event) }.vk_check("vkResetEvent")?;

    // record primary command buffer
    begin_command_buffer(vk_device, *prim_cmd_buf)?;
    {
        // allow execution of event during every stage of pipeline
        let stage_mask = vk::PipelineStageFlags::ALL_COMMANDS;

        // record setting event
        unsafe { vk_device.cmd_set_event(*prim_cmd_buf, *event, stage_mask) };
    }
    end_command_buffer(vk_device, *prim_cmd_buf)?;

    submit_commands_and_wait(vk_device, queue, *prim_cmd_buf)?;

    // check if buffer has been executed
    if unsafe { vk_device.get_event_status(*event) } != Ok(vk::SuccessCode::EVENT_SET) {
        return Ok(TestStatus::fail("oneTimeSubmitFlagPrimaryBufferTest FAILED"));
    }

    // record primary command buffer again - implicit reset because of VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT
    begin_command_buffer(vk_device, *prim_cmd_buf)?;
    {
        // allow execution of event during every stage of pipeline
        let stage_mask = vk::PipelineStageFlags::ALL_COMMANDS;

        // record setting event
        unsafe { vk_device.cmd_set_event(*prim_cmd_buf, *event, stage_mask) };
    }
    end_command_buffer(vk_device, *prim_cmd_buf)?;

    submit_commands_and_wait(vk_device, queue, *prim_cmd_buf)?;

    // check if buffer has been executed
    if unsafe { vk_device.get_event_status(*event) } != Ok(vk::SuccessCode::EVENT_SET) {
        Ok(TestStatus::fail("oneTimeSubmitFlagPrimaryBufferTest FAILED"))
    } else {
        Ok(TestStatus::pass("oneTimeSubmitFlagPrimaryBufferTest succeeded"))
    }
}

/// `oneTimeSubmitFlagSecondaryBufferTest`
fn one_time_submit_flag_secondary_buffer_test(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();

    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;
    let sec_cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;

    // Command buffer
    let prim_cmd_buf1 = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let prim_cmd_buf2 = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    // Secondary Command buffer
    let sec_cmd_buf = allocate_command_buffer(vk_device, *sec_cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

    // create event that will be used to check if secondary command buffer has been executed
    let event = Unique::new(
        vk_device,
        unsafe { vk_device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
    );

    // reset event
    unsafe { vk_device.reset_event(*event) }.vk_check("vkResetEvent")?;

    // record first primary command buffer
    begin_command_buffer_flags(vk_device, *prim_cmd_buf1, vk::CommandBufferUsageFlags::empty())?;
    {
        // record secondary command buffer
        begin_secondary_command_buffer_without_inheritance(
            vk_device,
            *sec_cmd_buf,
            vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT,
        )?;
        {
            // allow execution of event during every stage of pipeline
            let stage_mask = vk::PipelineStageFlags::ALL_COMMANDS;

            // record setting event
            unsafe { vk_device.cmd_set_event(*sec_cmd_buf, *event, stage_mask) };
        }

        // end recording of secondary buffers
        end_command_buffer(vk_device, *sec_cmd_buf)?;

        // execute secondary buffer
        unsafe { vk_device.cmd_execute_commands(*prim_cmd_buf1, &[*sec_cmd_buf]) };
    }
    end_command_buffer(vk_device, *prim_cmd_buf1)?;

    submit_commands_and_wait(vk_device, queue, *prim_cmd_buf1)?;

    // check if secondary buffer has been executed
    if unsafe { vk_device.get_event_status(*event) } != Ok(vk::SuccessCode::EVENT_SET) {
        return Ok(TestStatus::fail("Submit Twice Secondary Command Buffer FAILED"));
    }

    // reset first primary buffer
    unsafe { vk_device.reset_command_buffer(*prim_cmd_buf1, vk::CommandBufferResetFlags::empty()) }
        .vk_check("vkResetCommandBuffer")?;

    // reset event to allow receiving it again
    unsafe { vk_device.reset_event(*event) }.vk_check("vkResetEvent")?;

    // record secondary command buffer again
    begin_secondary_command_buffer_without_inheritance(
        vk_device,
        *sec_cmd_buf,
        vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT,
    )?;
    {
        // allow execution of event during every stage of pipeline
        let stage_mask = vk::PipelineStageFlags::ALL_COMMANDS;

        // record setting event
        unsafe { vk_device.cmd_set_event(*sec_cmd_buf, *event, stage_mask) };
    }
    // end recording of secondary buffers
    end_command_buffer(vk_device, *sec_cmd_buf)?;

    // record second primary command buffer
    begin_command_buffer_flags(vk_device, *prim_cmd_buf2, vk::CommandBufferUsageFlags::empty())?;
    {
        // execute secondary buffer
        unsafe { vk_device.cmd_execute_commands(*prim_cmd_buf2, &[*sec_cmd_buf]) };
    }
    // end recording
    end_command_buffer(vk_device, *prim_cmd_buf2)?;

    submit_commands_and_wait(vk_device, queue, *prim_cmd_buf2)?;

    // check if secondary buffer has been executed
    if unsafe { vk_device.get_event_status(*event) } != Ok(vk::SuccessCode::EVENT_SET) {
        Ok(TestStatus::fail("oneTimeSubmitFlagSecondaryBufferTest FAILED"))
    } else {
        Ok(TestStatus::pass("oneTimeSubmitFlagSecondaryBufferTest succeeded"))
    }
}

/// The preamble `submitBufferCountNonZero`, `submitBufferCountEqualZero`, `submitBufferNullFence` and
/// `submitTwoBuffersOneBufferNullWithFence` share: a pool, `buffer_count` primary command buffers,
/// one event each, and every buffer recorded to set its own event.
fn record_event_buffers<'a>(
    context: &'a Context<'a>,
    pool_flags: vk::CommandPoolCreateFlags,
    buffer_count: u32,
) -> Result<
    (
        Unique<'a, vk::CommandPool>,
        Vec<vk::CommandBuffer>,
        Vec<Unique<'a, vk::Event>>,
    ),
    TestError,
> {
    let vk_device = context.get_device();
    let cmd_pool = create_command_pool(context, pool_flags)?;

    // Command buffer
    let cmd_buf_params = vk::CommandBufferAllocateInfo::builder()
        .command_pool(*cmd_pool)
        .level(vk::CommandBufferLevel::PRIMARY)
        .command_buffer_count(buffer_count);
    let cmd_buffers =
        unsafe { vk_device.allocate_command_buffers(&cmd_buf_params) }.vk_check("vkAllocateCommandBuffers")?;

    let mut events: Vec<Unique<'a, vk::Event>> = Vec::new();
    for _ in 0..buffer_count {
        events.push(Unique::new(
            vk_device,
            unsafe { vk_device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
        ));
    }

    // Record the command buffers
    for (ndx, &cmd_buffer) in cmd_buffers.iter().enumerate() {
        begin_command_buffer_flags(vk_device, cmd_buffer, vk::CommandBufferUsageFlags::empty())?;
        {
            unsafe { vk_device.cmd_set_event(cmd_buffer, events[ndx].get(), vk::PipelineStageFlags::ALL_COMMANDS) };
        }
        end_command_buffer(vk_device, cmd_buffer)?;
    }

    Ok((cmd_pool, cmd_buffers, events))
}

/// `submitBufferCountNonZero`
fn submit_buffer_count_non_zero(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();

    let buffer_count = 5u32;

    let (_cmd_pool, cmd_buffers, events) =
        record_event_buffers(context, vk::CommandPoolCreateFlags::empty(), buffer_count)?;

    // We'll use a fence to wait for the execution of the queue
    let fence = Unique::new(
        vk_device,
        unsafe { vk_device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );

    let submit_info = vk::SubmitInfo::builder().command_buffers(&cmd_buffers);

    // Submit the alpha command buffer to the queue
    unsafe { vk_device.queue_submit(queue, &[submit_info], *fence) }.vk_check("vkQueueSubmit")?;
    // Wait for the queue
    unsafe { vk_device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;

    // Check if the buffers were executed
    for event in &events {
        if unsafe { vk_device.get_event_status(event.get()) } != Ok(vk::SuccessCode::EVENT_SET) {
            return Ok(TestStatus::fail("Failed to set the event."));
        }
    }

    Ok(TestStatus::pass("All buffers were submitted and executed correctly."))
}

/// `submitBufferCountEqualZero`
fn submit_buffer_count_equal_zero(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();

    let buffer_count = 2u32;

    let (_cmd_pool, cmd_buffers, events) =
        record_event_buffers(context, vk::CommandPoolCreateFlags::empty(), buffer_count)?;

    // We'll use a fence to wait for the execution of the queue
    let fence_zero = Unique::new(
        vk_device,
        unsafe { vk_device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );
    let fence_one = Unique::new(
        vk_device,
        unsafe { vk_device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );

    let cmd_buf0 = [cmd_buffers[0]];
    let submit_info_count_zero = vk::SubmitInfo::builder().command_buffers(&cmd_buf0);

    let cmd_buf1 = [cmd_buffers[1]];
    let submit_info_count_one = vk::SubmitInfo::builder().command_buffers(&cmd_buf1);

    // Submit the command buffers to the queue
    // We're performing two submits to make sure that the first one has
    // a chance to be processed before we check the event's status
    // (the first one is submitted with submitCount 0, so its submit info is never read)
    let _ = submit_info_count_zero;
    unsafe { vk_device.queue_submit(queue, &[] as &[vk::SubmitInfo], *fence_zero) }.vk_check("vkQueueSubmit")?;
    unsafe { vk_device.queue_submit(queue, &[submit_info_count_one], *fence_one) }.vk_check("vkQueueSubmit")?;

    let fences = [*fence_zero, *fence_one];

    // Wait for the queue
    unsafe { vk_device.wait_for_fences(&fences, true, u64::MAX) }.vk_check("vkWaitForFences")?;

    // Check if the first buffer was executed
    if unsafe { vk_device.get_event_status(events[0].get()) } == Ok(vk::SuccessCode::EVENT_SET) {
        Ok(TestStatus::fail("The first event was signaled."))
    } else {
        Ok(TestStatus::pass("The first submission was ignored."))
    }
}

/// `submitBufferNullFence`
fn submit_buffer_null_fence(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();

    let buffer_count = 2u32;

    let (_cmd_pool, cmd_buffers, events) =
        record_event_buffers(context, vk::CommandPoolCreateFlags::empty(), buffer_count)?;

    // We'll use a fence to wait for the execution of the queue
    let fence = Unique::new(
        vk_device,
        unsafe { vk_device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );

    let cmd_buf0 = [cmd_buffers[0]];
    let submit_info_null_fence = vk::SubmitInfo::builder().command_buffers(&cmd_buf0);

    let cmd_buf1 = [cmd_buffers[1]];
    let submit_info_non_null_fence = vk::SubmitInfo::builder().command_buffers(&cmd_buf1);

    // Perform two submissions - one with no fence, the other one with a valid
    // fence Hoping submitting the other buffer will give the first one time to
    // execute
    unsafe { vk_device.queue_submit(queue, &[submit_info_null_fence], vk::Fence::null()) }.vk_check("vkQueueSubmit")?;
    unsafe { vk_device.queue_submit(queue, &[submit_info_non_null_fence], *fence) }.vk_check("vkQueueSubmit")?;

    // Wait for the queue
    unsafe { vk_device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;

    // Fence guaranteed that all buffers submited before fence were executed
    let test_result = if unsafe { vk_device.get_event_status(events[0].get()) } != Ok(vk::SuccessCode::EVENT_SET)
        || unsafe { vk_device.get_event_status(events[1].get()) } != Ok(vk::SuccessCode::EVENT_SET)
    {
        TestStatus::fail("One of the buffers was not executed.")
    } else {
        TestStatus::pass("Buffers have been submitted and executed correctly.")
    };

    unsafe { vk_device.queue_wait_idle(queue) }.ok();
    Ok(test_result)
}

/// `submitTwoBuffersOneBufferNullWithFence`
fn submit_two_buffers_one_buffer_null_with_fence(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();
    let buffer_count = 2u32;

    let (_cmd_pool, cmd_buffers, _events) =
        record_event_buffers(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER, buffer_count)?;

    // First command buffer
    let cmd_buf0 = [cmd_buffers[0]];
    let submit_info_non_null_first = vk::SubmitInfo::builder().command_buffers(&cmd_buf0);

    // Second command buffer
    let cmd_buf1 = [cmd_buffers[1]];
    let submit_info_non_null_second = vk::SubmitInfo::builder().command_buffers(&cmd_buf1);

    // Fence will be submitted with the null queue
    let fence = Unique::new(
        vk_device,
        unsafe { vk_device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );

    // Perform two separate queueSubmit calls on the same queue followed
    // by a third call with no submitInfos and with a valid fence
    unsafe { vk_device.queue_submit(queue, &[submit_info_non_null_first], vk::Fence::null()) }
        .vk_check("vkQueueSubmit")?;
    unsafe { vk_device.queue_submit(queue, &[submit_info_non_null_second], vk::Fence::null()) }
        .vk_check("vkQueueSubmit")?;
    unsafe { vk_device.queue_submit(queue, &[] as &[vk::SubmitInfo], *fence) }.vk_check("vkQueueSubmit")?;

    // Wait for the queue
    unsafe { vk_device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;

    Ok(TestStatus::pass("Buffers have been submitted correctly"))
}

/// `submitBufferWaitSingleSemaphore`
fn submit_buffer_wait_single_semaphore(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();

    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;

    // Create two command buffers
    let prim_cmd_buf1 = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let prim_cmd_buf2 = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    // create two events that will be used to check if command buffers has been executed
    let event1 = Unique::new(
        vk_device,
        unsafe { vk_device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
    );
    let event2 = Unique::new(
        vk_device,
        unsafe { vk_device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
    );

    // reset events
    unsafe { vk_device.reset_event(*event1) }.vk_check("vkResetEvent")?;
    unsafe { vk_device.reset_event(*event2) }.vk_check("vkResetEvent")?;

    // record first command buffer
    begin_command_buffer_flags(vk_device, *prim_cmd_buf1, vk::CommandBufferUsageFlags::empty())?;
    {
        // allow execution of event during every stage of pipeline
        let stage_mask = vk::PipelineStageFlags::ALL_COMMANDS;

        // record setting event
        unsafe { vk_device.cmd_set_event(*prim_cmd_buf1, *event1, stage_mask) };
    }
    end_command_buffer(vk_device, *prim_cmd_buf1)?;

    // record second command buffer
    begin_command_buffer_flags(vk_device, *prim_cmd_buf2, vk::CommandBufferUsageFlags::empty())?;
    {
        // allow execution of event during every stage of pipeline
        let stage_mask = vk::PipelineStageFlags::ALL_COMMANDS;

        // record setting event
        unsafe { vk_device.cmd_set_event(*prim_cmd_buf2, *event2, stage_mask) };
    }
    end_command_buffer(vk_device, *prim_cmd_buf2)?;

    // create fence to wait for execution of queue
    let fence = Unique::new(
        vk_device,
        unsafe { vk_device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );

    // create semaphore for use in this test
    let semaphore = Unique::new(
        vk_device,
        unsafe { vk_device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
            .vk_check("vkCreateSemaphore")?,
    );

    // create submit info for first buffer - signalling semaphore
    let command_buffers1 = [*prim_cmd_buf1];
    let signal_semaphores = [*semaphore];
    let submit_info1 = vk::SubmitInfo::builder()
        .command_buffers(&command_buffers1)
        .signal_semaphores(&signal_semaphores);

    // Submit the command buffer to the queue
    unsafe { vk_device.queue_submit(queue, &[submit_info1], *fence) }.vk_check("vkQueueSubmit")?;

    // wait for end of execution of queue
    unsafe { vk_device.wait_for_fences(&[*fence], false, u64::MAX) }.vk_check("vkWaitForFences")?;

    // check if buffer has been executed
    if unsafe { vk_device.get_event_status(*event1) } != Ok(vk::SuccessCode::EVENT_SET) {
        return Ok(TestStatus::fail(
            "Submit Buffer and Wait for Single Semaphore Test FAILED",
        ));
    }

    let wait_dst_stage_flags = [vk::PipelineStageFlags::TOP_OF_PIPE];

    // create submit info for second buffer - waiting for semaphore
    let command_buffers2 = [*prim_cmd_buf2];
    let wait_semaphores = [*semaphore];
    let submit_info2 = vk::SubmitInfo::builder()
        .wait_semaphores(&wait_semaphores)
        .wait_dst_stage_mask(&wait_dst_stage_flags)
        .command_buffers(&command_buffers2);

    // reset fence, so it can be used again
    unsafe { vk_device.reset_fences(&[*fence]) }.vk_check("vkResetFences")?;

    // Submit the second command buffer to the queue
    unsafe { vk_device.queue_submit(queue, &[submit_info2], *fence) }.vk_check("vkQueueSubmit")?;

    // wait for end of execution of queue
    unsafe { vk_device.wait_for_fences(&[*fence], false, u64::MAX) }.vk_check("vkWaitForFences")?;

    // check if second buffer has been executed
    // if it has been executed, it means that the semaphore was signalled - so test if passed
    if unsafe { vk_device.get_event_status(*event1) } != Ok(vk::SuccessCode::EVENT_SET) {
        return Ok(TestStatus::fail(
            "Submit Buffer and Wait for Single Semaphore Test FAILED",
        ));
    }

    Ok(TestStatus::pass(
        "Submit Buffer and Wait for Single Semaphore Test succeeded",
    ))
}

/// `submitBufferWaitManySemaphores`
fn submit_buffer_wait_many_semaphores(context: &Context<'_>) -> TestOutcome {
    // This test will create numSemaphores semaphores, and signal them in NUM_SEMAPHORES submits to queue
    // After that the numSubmissions queue submissions will wait for each semaphore

    let num_semaphores = 10u32; // it must be multiply of numSubmission
    let num_submissions = 2u32;
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();

    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;

    // Create command buffer
    let prim_cmd_buf = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    // create event that will be used to check if command buffers has been executed
    let event = Unique::new(
        vk_device,
        unsafe { vk_device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
    );

    // reset event - at creation state is undefined
    unsafe { vk_device.reset_event(*event) }.vk_check("vkResetEvent")?;

    // record command buffer
    begin_command_buffer_flags(vk_device, *prim_cmd_buf, vk::CommandBufferUsageFlags::empty())?;
    {
        // allow execution of event during every stage of pipeline
        let stage_mask = vk::PipelineStageFlags::ALL_COMMANDS;

        // record setting event
        unsafe { vk_device.cmd_set_event(*prim_cmd_buf, *event, stage_mask) };
    }
    end_command_buffer(vk_device, *prim_cmd_buf)?;

    // create fence to wait for execution of queue
    let fence = Unique::new(
        vk_device,
        unsafe { vk_device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );

    // the semaphores will be destroyed automatically at end of scope
    let mut semaphore_array: Vec<Unique<'_, vk::Semaphore>> = Vec::new();
    let mut semaphores: Vec<vk::Semaphore> = Vec::new();

    for _ in 0..num_semaphores {
        // create semaphores for use in this test
        let semaphore = Unique::new(
            vk_device,
            unsafe { vk_device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                .vk_check("vkCreateSemaphore")?,
        );
        semaphores.push(*semaphore);
        semaphore_array.push(semaphore);
    }

    let command_buffers = [*prim_cmd_buf];

    {
        // create submit info for buffer - signal semaphores
        let submit_info1 = vk::SubmitInfo::builder()
            .command_buffers(&command_buffers)
            .signal_semaphores(&semaphores);
        // Submit the command buffer to the queue
        unsafe { vk_device.queue_submit(queue, &[submit_info1], *fence) }.vk_check("vkQueueSubmit")?;

        // wait for end of execution of queue
        unsafe { vk_device.wait_for_fences(&[*fence], false, u64::MAX) }.vk_check("vkWaitForFences")?;

        // check if buffer has been executed
        if unsafe { vk_device.get_event_status(*event) } != Ok(vk::SuccessCode::EVENT_SET) {
            return Ok(TestStatus::fail(
                "Submit Buffer and Wait for Many Semaphores Test FAILED",
            ));
        }

        // reset event, so next buffers can set it again
        unsafe { vk_device.reset_event(*event) }.vk_check("vkResetEvent")?;

        // reset fence, so it can be used again
        unsafe { vk_device.reset_fences(&[*fence]) }.vk_check("vkResetFences")?;
    }

    let number_of_semaphores_to_be_waited_by_one_submission = num_semaphores / num_submissions;
    let wait_dst_stage_flags =
        vec![vk::PipelineStageFlags::TOP_OF_PIPE; number_of_semaphores_to_be_waited_by_one_submission as usize];

    // the following code waits for the semaphores set above - numSubmissions queues will wait for each semaphore from above
    for idx_submission in 0..num_submissions {
        let first = (number_of_semaphores_to_be_waited_by_one_submission * idx_submission) as usize;
        let wait_semaphores = &semaphores[first..first + number_of_semaphores_to_be_waited_by_one_submission as usize];

        // create submit info for buffer - waiting for semaphore
        let submit_info2 = vk::SubmitInfo::builder()
            .wait_semaphores(wait_semaphores)
            .wait_dst_stage_mask(&wait_dst_stage_flags)
            .command_buffers(&command_buffers);

        // Submit the second command buffer to the queue
        unsafe { vk_device.queue_submit(queue, &[submit_info2], *fence) }.vk_check("vkQueueSubmit")?;

        // wait for 1 second.
        unsafe { vk_device.wait_for_fences(&[*fence], false, 1000 * 1000 * 1000) }.vk_check("vkWaitForFences")?;

        // check if second buffer has been executed
        // if it has been executed, it means that the semaphore was signalled - so test if passed
        if unsafe { vk_device.get_event_status(*event) } != Ok(vk::SuccessCode::EVENT_SET) {
            return Ok(TestStatus::fail(
                "Submit Buffer and Wait for Many Semaphores Test FAILED",
            ));
        }

        // reset fence, so it can be used again
        unsafe { vk_device.reset_fences(&[*fence]) }.vk_check("vkResetFences")?;

        // reset event, so next buffers can set it again
        unsafe { vk_device.reset_event(*event) }.vk_check("vkResetEvent")?;
    }

    Ok(TestStatus::pass(
        "Submit Buffer and Wait for Many Semaphores Test succeeded",
    ))
}

/// `executeSecondaryBufferTest`
fn execute_secondary_buffer_test(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();

    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;

    // Command buffer
    let prim_cmd_buf = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    // Secondary Command buffer
    let sec_cmd_buf = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

    // create event that will be used to check if secondary command buffer has been executed
    let event = Unique::new(
        vk_device,
        unsafe { vk_device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
    );

    // reset event
    unsafe { vk_device.reset_event(*event) }.vk_check("vkResetEvent")?;

    // record secondary command buffer
    begin_secondary_command_buffer_without_inheritance(vk_device, *sec_cmd_buf, vk::CommandBufferUsageFlags::empty())?;
    {
        // allow execution of event during every stage of pipeline
        let stage_mask = vk::PipelineStageFlags::ALL_COMMANDS;
        // record setting event
        unsafe { vk_device.cmd_set_event(*sec_cmd_buf, *event, stage_mask) };
    }
    // end recording of the secondary buffer
    end_command_buffer(vk_device, *sec_cmd_buf)?;

    // record primary command buffer
    begin_command_buffer_flags(vk_device, *prim_cmd_buf, vk::CommandBufferUsageFlags::empty())?;
    {
        // execute secondary buffer
        unsafe { vk_device.cmd_execute_commands(*prim_cmd_buf, &[*sec_cmd_buf]) };
    }
    end_command_buffer(vk_device, *prim_cmd_buf)?;

    submit_commands_and_wait(vk_device, queue, *prim_cmd_buf)?;

    // check if secondary buffer has been executed
    if unsafe { vk_device.get_event_status(*event) } == Ok(vk::SuccessCode::EVENT_SET) {
        return Ok(TestStatus::pass("executeSecondaryBufferTest succeeded"));
    }

    Ok(TestStatus::fail("executeSecondaryBufferTest FAILED"))
}

/// `executeSecondaryBufferTwiceTest`
fn execute_secondary_buffer_twice_test(context: &Context<'_>) -> TestOutcome {
    let buffer_count = 10u32;
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();

    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;

    // Command buffer
    let prim_cmd_buf_one = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let prim_cmd_buf_two = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    // Secondary Command buffers params
    let sec_cmd_buf_params = vk::CommandBufferAllocateInfo::builder()
        .command_pool(*cmd_pool)
        .level(vk::CommandBufferLevel::SECONDARY)
        .command_buffer_count(buffer_count);
    let cmd_buffers =
        unsafe { vk_device.allocate_command_buffers(&sec_cmd_buf_params) }.vk_check("vkAllocateCommandBuffers")?;

    // create event that will be used to check if secondary command buffer has been executed
    let event_one = Unique::new(
        vk_device,
        unsafe { vk_device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
    );

    // reset event
    unsafe { vk_device.reset_event(*event_one) }.vk_check("vkResetEvent")?;

    for &cmd_buffer in &cmd_buffers {
        // record secondary command buffer
        begin_secondary_command_buffer_without_inheritance(
            vk_device,
            cmd_buffer,
            vk::CommandBufferUsageFlags::SIMULTANEOUS_USE,
        )?;
        {
            // set event
            unsafe { vk_device.cmd_set_event(cmd_buffer, *event_one, vk::PipelineStageFlags::TOP_OF_PIPE) };
        }
        // end recording of secondary buffers
        end_command_buffer(vk_device, cmd_buffer)?;
    }

    // record primary command buffer one
    begin_command_buffer_flags(vk_device, *prim_cmd_buf_one, vk::CommandBufferUsageFlags::empty())?;
    {
        // execute one secondary buffer
        unsafe { vk_device.cmd_execute_commands(*prim_cmd_buf_one, &cmd_buffers[..1]) };
    }
    end_command_buffer(vk_device, *prim_cmd_buf_one)?;

    // record primary command buffer two
    begin_command_buffer_flags(vk_device, *prim_cmd_buf_two, vk::CommandBufferUsageFlags::empty())?;
    {
        // execute one secondary buffer with all buffers
        unsafe { vk_device.cmd_execute_commands(*prim_cmd_buf_two, &cmd_buffers) };
    }
    end_command_buffer(vk_device, *prim_cmd_buf_two)?;

    // create fence to wait for execution of queue
    let fence_one = Unique::new(
        vk_device,
        unsafe { vk_device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );
    let fence_two = Unique::new(
        vk_device,
        unsafe { vk_device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );

    let semaphore_wait_value = [1u64];
    let semaphore_wait_stage = [vk::PipelineStageFlags::TOP_OF_PIPE];
    let mut semaphore_type_info = vk::SemaphoreTypeCreateInfo::builder()
        .semaphore_type(vk::SemaphoreType::TIMELINE)
        .initial_value(0);
    let semaphore_info = vk::SemaphoreCreateInfo::builder().push_next(&mut semaphore_type_info);
    let semaphore = Unique::new(
        vk_device,
        unsafe { vk_device.create_semaphore(&semaphore_info, None) }.vk_check("vkCreateSemaphore")?,
    );
    let wait_semaphores = [*semaphore];

    // Use timeline semaphore to wait for signal from the host.
    let command_buffers_one = [*prim_cmd_buf_one];
    let mut timeline_wait_submit_info =
        vk::TimelineSemaphoreSubmitInfo::builder().wait_semaphore_values(&semaphore_wait_value);
    let submit_info = vk::SubmitInfo::builder()
        .push_next(&mut timeline_wait_submit_info)
        .wait_semaphores(&wait_semaphores)
        .wait_dst_stage_mask(&semaphore_wait_stage)
        .command_buffers(&command_buffers_one);
    unsafe { vk_device.queue_submit(queue, &[submit_info], *fence_one) }.vk_check("vkQueueSubmit")?;

    let command_buffers_two = [*prim_cmd_buf_two];
    let mut timeline_wait_submit_info2 =
        vk::TimelineSemaphoreSubmitInfo::builder().wait_semaphore_values(&semaphore_wait_value);
    let submit_info2 = vk::SubmitInfo::builder()
        .push_next(&mut timeline_wait_submit_info2)
        .wait_semaphores(&wait_semaphores)
        .wait_dst_stage_mask(&semaphore_wait_stage)
        .command_buffers(&command_buffers_two);

    unsafe { vk_device.queue_submit(queue, &[submit_info2], *fence_two) }.vk_check("vkQueueSubmit")?;

    // Signal from host
    let signal_info = vk::SemaphoreSignalInfo::builder()
        .semaphore(*semaphore)
        .value(semaphore_wait_value[0]);

    unsafe { vk_device.signal_semaphore(&signal_info) }.vk_check("vkSignalSemaphore")?;

    // wait for end of execution of fenceOne
    unsafe { vk_device.wait_for_fences(&[*fence_one], false, u64::MAX) }.vk_check("vkWaitForFences")?;

    // wait for end of execution of fenceTwo
    unsafe { vk_device.wait_for_fences(&[*fence_two], false, u64::MAX) }.vk_check("vkWaitForFences")?;

    if unsafe { vk_device.get_event_status(*event_one) } != Ok(vk::SuccessCode::EVENT_SET) {
        return Err(TestError::Fail(
            "Check failed: vk.getEventStatus(vkDevice, *eventOne) == vk::VK_EVENT_SET".to_string(),
        ));
    }

    Ok(TestStatus::pass("executeSecondaryBufferTwiceTest succeeded"))
}

/// `StateTransitionTest`
#[derive(Clone, Copy)]
enum StateTransitionTest {
    RecordingToInitial,
    ExecutableToInitial,
    RecordingToInvalid,
    ExecutableToInvalid,
}

/// `executeStateTransitionTest`
fn execute_state_transition_test(context: &Context<'_>, test_type: StateTransitionTest) -> TestOutcome {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();

    let cmd_pool = create_command_pool(context, vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)?;
    let cmd_buffer = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let global_event = Unique::new(
        vk_device,
        unsafe { vk_device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
    );

    unsafe { vk_device.reset_event(*global_event) }.vk_check("vkResetEvent")?;

    match test_type {
        StateTransitionTest::RecordingToInitial => {
            begin_command_buffer_flags(vk_device, *cmd_buffer, vk::CommandBufferUsageFlags::empty())?;
            unsafe { vk_device.cmd_set_event(*cmd_buffer, *global_event, vk::PipelineStageFlags::ALL_COMMANDS) };
            // command buffer is still in recording state
        }
        StateTransitionTest::ExecutableToInitial => {
            begin_command_buffer_flags(vk_device, *cmd_buffer, vk::CommandBufferUsageFlags::empty())?;
            unsafe { vk_device.cmd_set_event(*cmd_buffer, *global_event, vk::PipelineStageFlags::ALL_COMMANDS) };
            end_command_buffer(vk_device, *cmd_buffer)?;
            // command buffer is still in executable state
        }
        StateTransitionTest::RecordingToInvalid => {
            let subpass_description = [vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .build()];

            let render_pass_create_info = vk::RenderPassCreateInfo::builder().subpasses(&subpass_description);

            // Error here - renderpass and framebuffer were created localy
            let render_pass = Unique::new(
                vk_device,
                unsafe { vk_device.create_render_pass(&render_pass_create_info, None) }
                    .vk_check("vkCreateRenderPass")?,
            );

            let framebuffer_create_info = vk::FramebufferCreateInfo::builder()
                .render_pass(*render_pass)
                .width(16)
                .height(16)
                .layers(1);
            let framebuffer = Unique::new(
                vk_device,
                unsafe { vk_device.create_framebuffer(&framebuffer_create_info, None) }
                    .vk_check("vkCreateFramebuffer")?,
            );

            let render_pass_begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(vk::Rect2D {
                    offset: vk::Offset2D { x: 0, y: 0 },
                    extent: vk::Extent2D { width: 16, height: 16 },
                });

            begin_command_buffer_flags(vk_device, *cmd_buffer, vk::CommandBufferUsageFlags::empty())?;
            unsafe {
                vk_device.cmd_begin_render_pass(*cmd_buffer, &render_pass_begin_info, vk::SubpassContents::INLINE);
                vk_device.cmd_end_render_pass(*cmd_buffer);
            }

            // not executing endCommandBuffer(vk, *cmdBuffer);
            // command buffer is still in recording state
            // renderpass and framebuffer are destroyed; command buffer should be now in invalid state
        }
        StateTransitionTest::ExecutableToInvalid => {
            // create event that will be used to check if command buffer has been executed
            let local_event = Unique::new(
                vk_device,
                unsafe { vk_device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
            );
            unsafe { vk_device.reset_event(*local_event) }.vk_check("vkResetEvent")?;

            begin_command_buffer_flags(vk_device, *cmd_buffer, vk::CommandBufferUsageFlags::empty())?;
            unsafe { vk_device.cmd_set_event(*cmd_buffer, *local_event, vk::PipelineStageFlags::ALL_COMMANDS) };
            end_command_buffer(vk_device, *cmd_buffer)?;
            // command buffer is in executable state
            // localEvent is destroyed; command buffer should be now in invalid state
        }
    }

    unsafe { vk_device.reset_event(*global_event) }.vk_check("vkResetEvent")?;

    unsafe { vk_device.reset_command_buffer(*cmd_buffer, vk::CommandBufferResetFlags::empty()) }
        .vk_check("vkResetCommandBuffer")?;
    // command buffer should now be back in initial state

    // verify commandBuffer
    begin_command_buffer_flags(vk_device, *cmd_buffer, vk::CommandBufferUsageFlags::empty())?;
    unsafe { vk_device.cmd_set_event(*cmd_buffer, *global_event, vk::PipelineStageFlags::ALL_COMMANDS) };
    end_command_buffer(vk_device, *cmd_buffer)?;
    submit_commands_and_wait(vk_device, queue, *cmd_buffer)?;

    // check if buffer has been executed
    if unsafe { vk_device.get_event_status(*global_event) } != Ok(vk::SuccessCode::EVENT_SET) {
        return Ok(TestStatus::fail("Submit failed"));
    }

    Ok(TestStatus::pass("Pass"))
}

fn recording_to_initial_test(context: &Context<'_>) -> TestOutcome {
    execute_state_transition_test(context, StateTransitionTest::RecordingToInitial)
}

fn executable_to_initial_test(context: &Context<'_>) -> TestOutcome {
    execute_state_transition_test(context, StateTransitionTest::ExecutableToInitial)
}

fn recording_to_invalid_test(context: &Context<'_>) -> TestOutcome {
    execute_state_transition_test(context, StateTransitionTest::RecordingToInvalid)
}

fn executable_to_invalid_test(context: &Context<'_>) -> TestOutcome {
    execute_state_transition_test(context, StateTransitionTest::ExecutableToInvalid)
}

/// A case with the portability-subset event check, which most of this group carries.
struct EventCase {
    name: &'static str,
    test: super::case_util::TestFn,
    /// `checkEventAndMaint1Support`
    needs_maintenance1: bool,
    /// `checkEventAndTimelineSemaphoreAndSimultaneousUseAndSecondaryCommandBufferNullFramebufferSupport`
    needs_timeline_semaphore: bool,
}

impl TestCase for EventCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_event_support(context)?;
        if self.needs_maintenance1 {
            context.require_device_functionality("VK_KHR_maintenance1")?;
        }
        if self.needs_timeline_semaphore {
            context.require_device_functionality("VK_KHR_timeline_semaphore")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(EventInstance {
            context,
            test: self.test,
        })
    }
}

struct EventInstance<'a> {
    context: &'a Context<'a>,
    test: super::case_util::TestFn,
}

impl TestInstance for EventInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        (self.test)(self.context)
    }
}

/// The part of `createCommandBuffersTests` that is ported.
pub fn create_command_buffers_tests() -> TestCaseGroup {
    let mut command_buffers_tests = TestCaseGroup::new("command_buffers");
    let g = &mut command_buffers_tests;

    // 19.1. Command Pools (5.1 in VK 1.0 Spec)
    add_function_case_no_support(g, "pool_create_null_params", create_pool_null_params_test);
    add_function_case_no_support(g, "pool_create_non_null_allocator", create_pool_non_null_allocator_test);
    add_function_case_no_support(g, "pool_create_transient_bit", create_pool_transient_bit_test);
    add_function_case_no_support(g, "pool_create_reset_bit", create_pool_reset_bit_test);
    add_function_case_no_support(g, "pool_reset_release_res", reset_pool_release_resources_bit_test);
    add_function_case_no_support(g, "pool_reset_no_flags_res", reset_pool_no_flags_test);
    add_case(
        g,
        EventCase {
            name: "pool_reset_reuse",
            test: reset_pool_reuse_test,
            needs_maintenance1: false,
            needs_timeline_semaphore: false,
        },
    );

    // 19.2. Command Buffer Lifetime (5.2 in VK 1.0 Spec)
    add_function_case_no_support(g, "allocate_single_primary", allocate_primary_buffer_test);
    add_function_case_no_support(g, "allocate_many_primary", allocate_many_primary_buffers_test);
    add_function_case_no_support(g, "allocate_single_secondary", allocate_secondary_buffer_test);
    add_function_case_no_support(g, "allocate_many_secondary", allocate_many_secondary_buffers_test);
    add_case(
        g,
        EventCase {
            name: "execute_small_primary",
            test: execute_primary_buffer_test,
            needs_maintenance1: false,
            needs_timeline_semaphore: false,
        },
    );
    add_case(
        g,
        EventCase {
            name: "execute_large_primary",
            test: execute_large_primary_buffer_test,
            needs_maintenance1: false,
            needs_timeline_semaphore: false,
        },
    );
    add_case(
        g,
        EventCase {
            name: "reset_implicit",
            test: reset_buffer_implicitly_test,
            needs_maintenance1: false,
            needs_timeline_semaphore: false,
        },
    );
    add_case(
        g,
        EventCase {
            name: "trim_command_pool",
            test: trim_command_pool_primary_test,
            needs_maintenance1: true,
            needs_timeline_semaphore: false,
        },
    );
    add_case(
        g,
        EventCase {
            name: "trim_command_pool_secondary",
            test: trim_command_pool_secondary_test,
            needs_maintenance1: true,
            needs_timeline_semaphore: false,
        },
    );

    // 19.3. Command Buffer Recording (5.3 in VK 1.0 Spec)
    add_case(
        g,
        EventCase {
            name: "record_single_primary",
            test: record_single_primary_buffer_test,
            needs_maintenance1: false,
            needs_timeline_semaphore: false,
        },
    );
    add_case(
        g,
        EventCase {
            name: "record_many_primary",
            test: record_large_primary_buffer_test,
            needs_maintenance1: false,
            needs_timeline_semaphore: false,
        },
    );
    add_case(
        g,
        EventCase {
            name: "record_single_secondary",
            test: record_single_secondary_buffer_test,
            needs_maintenance1: false,
            needs_timeline_semaphore: false,
        },
    );
    add_case(
        g,
        EventCase {
            name: "record_many_secondary",
            test: record_large_secondary_buffer_test,
            needs_maintenance1: false,
            needs_timeline_semaphore: false,
        },
    );
    add_case(
        g,
        EventCase {
            name: "submit_twice_primary",
            test: submit_primary_buffer_twice_test,
            needs_maintenance1: false,
            needs_timeline_semaphore: false,
        },
    );
    add_case(
        g,
        EventCase {
            name: "submit_twice_secondary",
            test: submit_secondary_buffer_twice_test,
            needs_maintenance1: false,
            needs_timeline_semaphore: false,
        },
    );
    add_case(
        g,
        EventCase {
            name: "record_one_time_submit_primary",
            test: one_time_submit_flag_primary_buffer_test,
            needs_maintenance1: false,
            needs_timeline_semaphore: false,
        },
    );
    add_case(
        g,
        EventCase {
            name: "record_one_time_submit_secondary",
            test: one_time_submit_flag_secondary_buffer_test,
            needs_maintenance1: false,
            needs_timeline_semaphore: false,
        },
    );
    add_case(
        g,
        EventCase {
            name: "submit_count_non_zero",
            test: submit_buffer_count_non_zero,
            needs_maintenance1: false,
            needs_timeline_semaphore: false,
        },
    );
    add_case(
        g,
        EventCase {
            name: "submit_count_equal_zero",
            test: submit_buffer_count_equal_zero,
            needs_maintenance1: false,
            needs_timeline_semaphore: false,
        },
    );
    add_case(
        g,
        EventCase {
            name: "submit_wait_single_semaphore",
            test: submit_buffer_wait_single_semaphore,
            needs_maintenance1: false,
            needs_timeline_semaphore: false,
        },
    );
    add_case(
        g,
        EventCase {
            name: "submit_wait_many_semaphores",
            test: submit_buffer_wait_many_semaphores,
            needs_maintenance1: false,
            needs_timeline_semaphore: false,
        },
    );
    add_case(
        g,
        EventCase {
            name: "submit_null_fence",
            test: submit_buffer_null_fence,
            needs_maintenance1: false,
            needs_timeline_semaphore: false,
        },
    );
    add_case(
        g,
        EventCase {
            name: "submit_two_buffers_one_buffer_null_with_fence",
            test: submit_two_buffers_one_buffer_null_with_fence,
            needs_maintenance1: false,
            needs_timeline_semaphore: false,
        },
    );

    // 19.5. Secondary Command Buffer Execution (5.6 in VK 1.0 Spec)
    add_case(
        g,
        EventCase {
            name: "secondary_execute",
            test: execute_secondary_buffer_test,
            needs_maintenance1: false,
            needs_timeline_semaphore: false,
        },
    );
    add_case(
        g,
        EventCase {
            name: "secondary_execute_twice",
            test: execute_secondary_buffer_twice_test,
            needs_maintenance1: false,
            needs_timeline_semaphore: true,
        },
    );

    // Verify untested transitions between command buffer states
    add_function_case_no_support(g, "recording_to_ininitial", recording_to_initial_test);
    add_function_case_no_support(g, "executable_to_ininitial", executable_to_initial_test);
    add_function_case_no_support(g, "recording_to_invalid", recording_to_invalid_test);
    add_function_case_no_support(g, "executable_to_invalid", executable_to_invalid_test);

    super::command_buffers_indirect_tests::add_indirect_dispatch_alignment_tests(g);
    super::command_buffers_indirect_tests::add_many_indirect_tests(g);
    super::command_buffers_indirect_tests::add_secondary_extra_tests(g);
    super::command_buffers_simul_tests::add_simultaneous_use_tests(g);
    super::command_buffers_nested_tests::add_nested_execute_tests(g);
    super::command_buffers_mix_tests::add_mix_with_secondaries_tests(g);
    super::command_buffers_many_draws_tests::add_many_draws_tests(g);
    super::command_buffers_render_pass_tests::add_render_pass_continue_tests(g);
    super::command_buffers_order_tests::add_order_bind_pipeline_tests(g);

    command_buffers_tests
}
