// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationBasicFenceTests.cpp
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationBasicEventTests.cpp
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationBasicSemaphoreTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The `op` tests use a synchronization primitive to order two operations and check the
// data that comes out. These check the primitive itself, with no operation at all: that
// a fresh fence reports `VK_NOT_READY`, that waiting on it times out, that
// `vkWaitForFences` with `waitAll = false` returns as soon as *one* fence is signalled,
// that an event set on the host is readable on the host. Nothing here writes a resource,
// so nothing here can be right by accident - the verdict is the return code the driver
// gave, compared against the one the spec requires.

use vulkanalia::prelude::v1_0::*;

use super::operation::SyncType;
use crate::tcu::{TestError, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `SHORT_FENCE_WAIT` - long enough that a driver which is going to signal has, short
/// enough that a test which expects a timeout does not sit on it.
const SHORT_FENCE_WAIT: u64 = 1_000;
/// `LONG_FENCE_WAIT`
const LONG_FENCE_WAIT: u64 = 1_000_000_000;

/// `addFunctionCase`, which has no counterpart here: a case that is a plain function of
/// the context, with no shaders and nothing to check support for.
struct FunctionCase {
    name: &'static str,
    sync_type: SyncType,
    run: fn(&Context<'_>, SyncType) -> Result<TestStatus, TestError>,
}

impl TestCase for FunctionCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FunctionInstance {
            context,
            sync_type: self.sync_type,
            run: self.run,
        })
    }
}

struct FunctionInstance<'a> {
    context: &'a Context<'a>,
    sync_type: SyncType,
    run: fn(&Context<'_>, SyncType) -> Result<TestStatus, TestError>,
}

impl TestInstance for FunctionInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        (self.run)(self.context, self.sync_type)
    }
}

/// An empty command buffer, submitted only so something reaches the queue.
fn empty_command_buffer<'a>(
    device: &'a Device,
    pool: vk::CommandPool,
    simultaneous_use: bool,
) -> Result<crate::vk::ref_util::UniqueCommandBuffer<'a>, TestError> {
    let cmd = allocate_command_buffer(device, pool, vk::CommandBufferLevel::PRIMARY)?;
    if simultaneous_use {
        // The multi-fence cases submit the same buffer twice while the first submission
        // may still be running, which is only legal with this flag.
        let info = vk::CommandBufferBeginInfo::builder().flags(vk::CommandBufferUsageFlags::SIMULTANEOUS_USE);
        unsafe { device.begin_command_buffer(*cmd, &info) }.vk_check("vkBeginCommandBuffer")?;
    } else {
        begin_command_buffer(device, *cmd)?;
    }
    end_command_buffer(device, *cmd)?;
    Ok(cmd)
}

fn make_fence(device: &Device, signaled: bool) -> Result<Unique<'_, vk::Fence>, TestError> {
    let flags = if signaled {
        vk::FenceCreateFlags::SIGNALED
    } else {
        vk::FenceCreateFlags::empty()
    };
    let info = vk::FenceCreateInfo::builder().flags(flags);
    let fence = unsafe { device.create_fence(&info, None) }.vk_check("vkCreateFence")?;
    Ok(Unique::new(device, fence))
}

/// `vkWaitForFences`' status without treating `VK_TIMEOUT` as an error - it is the
/// answer several of these cases are looking for.
fn wait_for_fences(
    device: &Device,
    fences: &[vk::Fence],
    wait_all: bool,
    timeout: u64,
) -> Result<vk::SuccessCode, TestError> {
    match unsafe { device.wait_for_fences(fences, wait_all, timeout) } {
        Ok(code) => Ok(code),
        Err(e) => Err(TestError::ResourceError(format!("vkWaitForFences failed: {e}"))),
    }
}

fn fence_status(device: &Device, fence: vk::Fence) -> Result<vk::SuccessCode, TestError> {
    match unsafe { device.get_fence_status(fence) } {
        Ok(code) => Ok(code),
        Err(e) => Err(TestError::ResourceError(format!("vkGetFenceStatus failed: {e}"))),
    }
}

fn submit(device: &Device, queue: vk::Queue, cmd_buffer: vk::CommandBuffer, fence: vk::Fence) -> Result<(), TestError> {
    let buffers = [cmd_buffer];
    let info = vk::SubmitInfo::builder().command_buffers(&buffers);
    unsafe { device.queue_submit(queue, &[info], fence) }.vk_check("vkQueueSubmit")
}

/// `basicOneFenceCase`
fn basic_one_fence(context: &Context<'_>, _sync: SyncType) -> Result<TestStatus, TestError> {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd = empty_command_buffer(device, *pool, false)?;
    let fence = make_fence(device, false)?;

    if fence_status(device, *fence)? != vk::SuccessCode::NOT_READY {
        return Ok(TestStatus::fail("Created fence should be in unsignaled state"));
    }
    if wait_for_fences(device, &[*fence], true, SHORT_FENCE_WAIT)? != vk::SuccessCode::TIMEOUT {
        return Ok(TestStatus::fail("vkWaitForFences should return VK_TIMEOUT"));
    }
    if fence_status(device, *fence)? != vk::SuccessCode::NOT_READY {
        return Ok(TestStatus::fail("Created fence should be in unsignaled state"));
    }

    submit(device, queue, *cmd, *fence)?;

    if wait_for_fences(device, &[*fence], true, LONG_FENCE_WAIT)? != vk::SuccessCode::SUCCESS {
        return Ok(TestStatus::fail("vkWaitForFences should return VK_SUCCESS"));
    }
    if fence_status(device, *fence)? != vk::SuccessCode::SUCCESS {
        return Ok(TestStatus::fail("Fence should be in signaled state"));
    }
    unsafe { device.reset_fences(&[*fence]) }.vk_check("vkResetFences")?;
    if fence_status(device, *fence)? != vk::SuccessCode::NOT_READY {
        return Ok(TestStatus::fail("Fence after reset should be in unsignaled state"));
    }

    Ok(TestStatus::pass("Basic one fence tests passed"))
}

/// `basicMultiFenceCase`
fn basic_multi_fence(context: &Context<'_>, _sync: SyncType) -> Result<TestStatus, TestError> {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd = empty_command_buffer(device, *pool, true)?;
    let first = make_fence(device, false)?;
    let second = make_fence(device, false)?;

    submit(device, queue, *cmd, *first)?;
    if wait_for_fences(device, &[*first], false, LONG_FENCE_WAIT)? != vk::SuccessCode::SUCCESS {
        return Ok(TestStatus::fail("vkWaitForFences should return VK_SUCCESS"));
    }
    unsafe { device.reset_fences(&[*first]) }.vk_check("vkResetFences")?;

    submit(device, queue, *cmd, *first)?;
    if wait_for_fences(device, &[*first, *second], true, SHORT_FENCE_WAIT)? != vk::SuccessCode::TIMEOUT {
        return Ok(TestStatus::fail("vkWaitForFences should return VK_TIMEOUT"));
    }

    submit(device, queue, *cmd, *second)?;
    if wait_for_fences(device, &[*first, *second], true, LONG_FENCE_WAIT)? != vk::SuccessCode::SUCCESS {
        return Ok(TestStatus::fail("vkWaitForFences should return VK_SUCCESS"));
    }

    Ok(TestStatus::pass("Basic multi fence tests passed"))
}

/// `emptySubmitCase` - a submit with no command buffers still has to signal its fence.
fn empty_submit(context: &Context<'_>, _sync: SyncType) -> Result<TestStatus, TestError> {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let fence = make_fence(device, false)?;

    unsafe { device.queue_submit(queue, &[] as &[vk::SubmitInfo], *fence) }.vk_check("vkQueueSubmit")?;

    if wait_for_fences(device, &[*fence], true, LONG_FENCE_WAIT)? != vk::SuccessCode::SUCCESS {
        return Ok(TestStatus::fail("vkWaitForFences should return VK_SUCCESS"));
    }
    Ok(TestStatus::pass("OK"))
}

/// `basicMultiFenceWaitAllFalseCase` - the four combinations of "any / all" against
/// "none / one / both signalled".
fn basic_multi_fence_wait_all_false(context: &Context<'_>, _sync: SyncType) -> Result<TestStatus, TestError> {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd = empty_command_buffer(device, *pool, true)?;
    let first = make_fence(device, false)?;
    let second = make_fence(device, false)?;
    let both = [*first, *second];

    if wait_for_fences(device, &both, false, SHORT_FENCE_WAIT)? != vk::SuccessCode::TIMEOUT {
        return Ok(TestStatus::fail(
            "vkWaitForFences should return VK_TIMEOUT for case: Wait for any fence (No fence has been signaled)",
        ));
    }
    if wait_for_fences(device, &both, true, SHORT_FENCE_WAIT)? != vk::SuccessCode::TIMEOUT {
        return Ok(TestStatus::fail(
            "vkWaitForFences should return VK_TIMEOUT for case: Wait for all fences (No fence has been signaled)",
        ));
    }

    submit(device, queue, *cmd, *second)?;
    if wait_for_fences(device, &both, false, LONG_FENCE_WAIT)? != vk::SuccessCode::SUCCESS {
        return Ok(TestStatus::fail(
            "vkWaitForFences should return VK_SUCCESS for case: Wait for any fence (Only second fence signaled)",
        ));
    }
    if wait_for_fences(device, &both, true, SHORT_FENCE_WAIT)? != vk::SuccessCode::TIMEOUT {
        return Ok(TestStatus::fail(
            "vkWaitForFences should return VK_TIMEOUT for case: Wait for all fences (Only second fence signaled)",
        ));
    }

    submit(device, queue, *cmd, *first)?;
    if wait_for_fences(device, &both, false, LONG_FENCE_WAIT)? != vk::SuccessCode::SUCCESS {
        return Ok(TestStatus::fail(
            "vkWaitForFences should return VK_SUCCESS for case: Wait for any fence (All fences signaled)",
        ));
    }
    if wait_for_fences(device, &both, true, LONG_FENCE_WAIT)? != vk::SuccessCode::SUCCESS {
        return Ok(TestStatus::fail(
            "vkWaitForFences should return VK_SUCCESS for case: Wait for all fences (All fences signaled)",
        ));
    }

    Ok(TestStatus::pass("Basic multi fence test without waitAll passed"))
}

/// `basicSignaledCase` with `numFences = 1`.
fn basic_one_signaled(context: &Context<'_>, _sync: SyncType) -> Result<TestStatus, TestError> {
    basic_signaled(context, 1)
}

/// `basicSignaledCase` with `numFences = 10`.
fn basic_multiple_signaled(context: &Context<'_>, _sync: SyncType) -> Result<TestStatus, TestError> {
    basic_signaled(context, 10)
}

fn basic_signaled(context: &Context<'_>, count: usize) -> Result<TestStatus, TestError> {
    let device = context.get_device();
    let mut fences = Vec::with_capacity(count);
    for _ in 0..count {
        let fence = make_fence(device, true)?;
        if fence_status(device, *fence)? != vk::SuccessCode::SUCCESS {
            return Ok(TestStatus::fail("Fence was not created signaled"));
        }
        fences.push(fence);
    }

    let raw: Vec<vk::Fence> = fences.iter().map(|f| **f).collect();
    let result = wait_for_fences(device, &raw, true, LONG_FENCE_WAIT)?;
    if result != vk::SuccessCode::SUCCESS {
        return Ok(TestStatus::fail(format!(
            "vkWaitForFences failed with exit status {result:?}"
        )));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `basicChainLength` - long enough that a driver which leaks or serialises per
/// semaphore shows it.
const BASIC_CHAIN_LENGTH: usize = 32768;

/// `basicChainCase` - 32768 submits, each signalling a fresh binary semaphore and
/// waiting on the previous one, then one submit with a fence at the end.
///
/// Nothing does any work; what is under test is that the driver can carry a chain of
/// that many dependencies without dropping one or running out of whatever it tracks
/// them with.
fn binary_semaphore_chain(context: &Context<'_>, _sync: SyncType) -> Result<TestStatus, TestError> {
    let device = context.get_device();
    let queue = context.get_universal_queue();

    let mut semaphores: Vec<Unique<'_, vk::Semaphore>> = Vec::with_capacity(BASIC_CHAIN_LENGTH);
    let mut previous: Option<vk::Semaphore> = None;

    for _ in 0..BASIC_CHAIN_LENGTH {
        let semaphore = unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
            .vk_check("vkCreateSemaphore")?;
        let semaphore = Unique::new(device, semaphore);

        let signal = [*semaphore];
        let stages = [vk::PipelineStageFlags::BOTTOM_OF_PIPE];
        // `waits` has to outlive the submit: `VkSubmitInfo` only holds a pointer to it,
        // so building the struct in an inner scope leaves that pointer dangling.
        let waits = [previous.unwrap_or_else(vk::Semaphore::null)];
        let builder = vk::SubmitInfo::builder().signal_semaphores(&signal);
        let submit = if previous.is_some() {
            builder.wait_semaphores(&waits).wait_dst_stage_mask(&stages)
        } else {
            builder
        };
        unsafe { device.queue_submit(queue, &[submit], vk::Fence::null()) }.vk_check("vkQueueSubmit")?;

        previous = Some(*semaphore);
        semaphores.push(semaphore);
    }

    let fence = make_fence(device, false)?;
    let waits = [previous.expect("the chain has at least one link")];
    let stages = [vk::PipelineStageFlags::BOTTOM_OF_PIPE];
    let submit = vk::SubmitInfo::builder()
        .wait_semaphores(&waits)
        .wait_dst_stage_mask(&stages);
    unsafe { device.queue_submit(queue, &[submit], *fence) }.vk_check("vkQueueSubmit")?;
    unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;

    Ok(TestStatus::pass("Basic semaphore chain test passed"))
}

/// `basicChainTimelineCase` - the same chain on *one* timeline semaphore, each submit
/// waiting on value i and signalling i+1.
fn timeline_semaphore_chain(context: &Context<'_>, _sync: SyncType) -> Result<TestStatus, TestError> {
    let device = context.get_device();
    let queue = context.get_universal_queue();

    let mut type_info = vk::SemaphoreTypeCreateInfo::builder()
        .semaphore_type(vk::SemaphoreType::TIMELINE)
        .initial_value(0);
    let info = vk::SemaphoreCreateInfo::builder().push_next(&mut type_info);
    let semaphore = unsafe { device.create_semaphore(&info, None) }.vk_check("vkCreateSemaphore")?;
    let semaphore = Unique::new(device, semaphore);

    let semaphores = [*semaphore];
    let stages = [vk::PipelineStageFlags::BOTTOM_OF_PIPE];
    for i in 0..BASIC_CHAIN_LENGTH {
        let signal_values = [i as u64 + 1];
        let wait_values = [i as u64];
        // `timeline` has to stay alive across the submit: it is reached through
        // `VkSubmitInfo::pNext`, which is a bare pointer.
        let mut timeline = vk::TimelineSemaphoreSubmitInfo::builder().signal_semaphore_values(&signal_values);
        if i > 0 {
            timeline = timeline.wait_semaphore_values(&wait_values);
        }
        let builder = vk::SubmitInfo::builder()
            .signal_semaphores(&semaphores)
            .push_next(&mut timeline);
        let submit = if i == 0 {
            builder
        } else {
            builder.wait_semaphores(&semaphores).wait_dst_stage_mask(&stages)
        };
        unsafe { device.queue_submit(queue, &[submit], vk::Fence::null()) }.vk_check("vkQueueSubmit")?;
    }

    let fence = make_fence(device, false)?;
    let wait_values = [BASIC_CHAIN_LENGTH as u64];
    let mut timeline = vk::TimelineSemaphoreSubmitInfo::builder().wait_semaphore_values(&wait_values);
    let submit = vk::SubmitInfo::builder()
        .wait_semaphores(&semaphores)
        .wait_dst_stage_mask(&stages)
        .push_next(&mut timeline);
    unsafe { device.queue_submit(queue, &[submit], *fence) }.vk_check("vkQueueSubmit")?;
    unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;

    Ok(TestStatus::pass("Basic semaphore chain test passed"))
}

/// `basicWaitForTimelineValueHelper` - signal one value from the host, then ask whether
/// a wait for another is already satisfied, with a timeout of zero.
fn wait_for_timeline_value(
    context: &Context<'_>,
    wait_any: bool,
    signal_value: u64,
    wait_value: u64,
) -> Result<TestStatus, TestError> {
    use vulkanalia::vk::DeviceV1_2;

    let device = context.get_device();
    let mut type_info = vk::SemaphoreTypeCreateInfo::builder()
        .semaphore_type(vk::SemaphoreType::TIMELINE)
        .initial_value(0);
    let info = vk::SemaphoreCreateInfo::builder().push_next(&mut type_info);
    let semaphore = unsafe { device.create_semaphore(&info, None) }.vk_check("vkCreateSemaphore")?;
    let semaphore = Unique::new(device, semaphore);

    let signal = vk::SemaphoreSignalInfo::builder()
        .semaphore(*semaphore)
        .value(signal_value);
    unsafe { device.signal_semaphore(&signal) }.vk_check("vkSignalSemaphore")?;

    let flags = if wait_any {
        vk::SemaphoreWaitFlags::ANY
    } else {
        vk::SemaphoreWaitFlags::empty()
    };
    let semaphores = [*semaphore];
    let values = [wait_value];
    let wait = vk::SemaphoreWaitInfo::builder()
        .flags(flags)
        .semaphores(&semaphores)
        .values(&values);
    let result = match unsafe { device.wait_semaphores(&wait, 0) } {
        Ok(code) => code,
        Err(e) => return Err(TestError::ResourceError(format!("vkWaitSemaphores failed: {e}"))),
    };

    if result == vk::SuccessCode::SUCCESS {
        Ok(TestStatus::pass("Pass"))
    } else {
        Ok(TestStatus::fail("Fail"))
    }
}

fn wait_for_any_current_value(context: &Context<'_>, _sync: SyncType) -> Result<TestStatus, TestError> {
    wait_for_timeline_value(context, true, 1, 1)
}
fn wait_for_any_lesser_value(context: &Context<'_>, _sync: SyncType) -> Result<TestStatus, TestError> {
    wait_for_timeline_value(context, true, 4, 1)
}
fn wait_for_all_current_value(context: &Context<'_>, _sync: SyncType) -> Result<TestStatus, TestError> {
    wait_for_timeline_value(context, false, 1, 1)
}
fn wait_for_all_lesser_value(context: &Context<'_>, _sync: SyncType) -> Result<TestStatus, TestError> {
    wait_for_timeline_value(context, false, 4, 1)
}

/// A case that needs `VK_KHR_timeline_semaphore`.
struct TimelineCase {
    name: &'static str,
    sync_type: SyncType,
    run: fn(&Context<'_>, SyncType) -> Result<TestStatus, TestError>,
}

impl TestCase for TimelineCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_timeline_semaphore")?;
        if self.sync_type == SyncType::Synchronization2 {
            context.require_device_functionality("VK_KHR_synchronization2")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FunctionInstance {
            context,
            sync_type: self.sync_type,
            run: self.run,
        })
    }
}

/// `createBasicFenceTests` / `createBasicEventTests` / `createBasicSemaphoreTests`,
/// restricted to the cases that need no second queue and no video device.
pub fn create_basic_tests(sync_type: SyncType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("basic");

    // The fence API is the same under both synchronization types, so upstream only
    // registers it once, under the legacy tree.
    if sync_type == SyncType::Legacy {
        let mut fence = TestCaseGroup::new("fence");
        for (name, run) in [
            (
                "one",
                basic_one_fence as fn(&Context<'_>, SyncType) -> Result<TestStatus, TestError>,
            ),
            ("multi", basic_multi_fence),
            ("empty_submit", empty_submit),
            ("multi_waitall_false", basic_multi_fence_wait_all_false),
            ("one_signaled", basic_one_signaled),
            ("multiple_signaled", basic_multiple_signaled),
        ] {
            fence.add_child(Box::new(FunctionCase { name, sync_type, run }) as Box<dyn TestCase>);
        }
        group.add_child(fence);
    }

    group.add_child(super::basic_extra_tests::create_basic_event_tests(sync_type));

    let mut binary = TestCaseGroup::new("binary_semaphore");
    super::basic_extra_tests::add_basic_binary_semaphore_tests(&mut binary, sync_type);
    binary.add_child(Box::new(FunctionCase {
        name: "chain",
        sync_type,
        run: binary_semaphore_chain,
    }) as Box<dyn TestCase>);
    group.add_child(binary);

    let mut timeline = TestCaseGroup::new("timeline_semaphore");
    super::basic_extra_tests::add_basic_timeline_semaphore_tests(&mut timeline, sync_type);
    timeline.add_child(Box::new(TimelineCase {
        name: "chain",
        sync_type,
        run: timeline_semaphore_chain,
    }) as Box<dyn TestCase>);
    // Upstream does not repeat the wait-for-value cases under synchronization2: they
    // touch no part of the API the two versions differ in.
    if sync_type == SyncType::Legacy {
        for (name, run) in [
            (
                "wait_for_any_current_value",
                wait_for_any_current_value as fn(&Context<'_>, SyncType) -> Result<TestStatus, TestError>,
            ),
            ("wait_for_any_lesser_value", wait_for_any_lesser_value),
            ("wait_for_all_current_value", wait_for_all_current_value),
            ("wait_for_all_lesser_value", wait_for_all_lesser_value),
        ] {
            timeline.add_child(Box::new(TimelineCase { name, sync_type, run }) as Box<dyn TestCase>);
        }
    }
    group.add_child(timeline);

    group
}
