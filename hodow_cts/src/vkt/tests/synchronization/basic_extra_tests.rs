// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationBasicEventTests.cpp
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationBasicSemaphoreTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The whole `basic.event` group and the `one_queue`, `multi_queue`, `none_wait_submit` and `two_threads` semaphore cases, which take a
// configuration (compute queue, device-only events, a typed or an untyped create, binary or timeline) where `basic_tests.rs`' cases
// take only the synchronization type. Video queues are not ported.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, KhrSynchronization2ExtensionDeviceCommands};

use super::cross_instance_sharing_tests::{SemaphoreOp, submit};
use super::operation::{SyncType, make_memory_barrier2};
use crate::tcu::{TestError, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::util::external_memory_util::create_semaphore_type;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

type Outcome = Result<TestStatus, TestError>;

// ---------------------------------------------------------------------------------
// Events
// ---------------------------------------------------------------------------------

/// `TestConfig` of `vktSynchronizationBasicEventTests.cpp`
#[derive(Clone, Copy)]
struct EventConfig {
    sync: SyncType,
    flags: vk::EventCreateFlags,
    compute_queue: bool,
}

/// `getSyncQueue` / `getSyncQueueFamilyIndex` without a video device.
fn event_queue(context: &Context<'_>, config: EventConfig) -> Result<(vk::Queue, u32), TestError> {
    if config.compute_queue {
        context
            .get_compute_queue()
            .ok_or_else(|| TestError::NotSupported("no dedicated compute queue".to_string()))
    } else {
        Ok((
            context.get_universal_queue(),
            context.get_universal_queue_family_index(),
        ))
    }
}

fn make_event(device: &Device, flags: vk::EventCreateFlags) -> Result<Unique<'_, vk::Event>, TestError> {
    let info = vk::EventCreateInfo::builder().flags(flags);
    let event = unsafe { device.create_event(&info, None) }.vk_check("vkCreateEvent")?;
    Ok(Unique::new(device, event))
}

fn make_fence(device: &Device) -> Result<Unique<'_, vk::Fence>, TestError> {
    let fence = unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?;
    Ok(Unique::new(device, fence))
}

fn event_status(device: &Device, event: vk::Event) -> Result<vk::SuccessCode, TestError> {
    unsafe { device.get_event_status(event) }
        .map_err(|e| TestError::ResourceError(format!("vkGetEventStatus failed: {e}")))
}

fn wait_idle(device: &Device, queue: vk::Queue) -> Result<(), TestError> {
    unsafe { device.queue_wait_idle(queue) }.vk_check("vkQueueWaitIdle")
}

/// `SynchronizationWrapper::addSubmitInfo` + `queueSubmit` for command buffers with no semaphores.
fn submit_cmds(
    device: &Device,
    sync: SyncType,
    queue: vk::Queue,
    cmds: &[vk::CommandBuffer],
    fence: vk::Fence,
) -> Result<(), TestError> {
    if sync == SyncType::Synchronization2 {
        let infos: Vec<vk::CommandBufferSubmitInfo> = cmds
            .iter()
            .map(|&cb| {
                vk::CommandBufferSubmitInfo::builder()
                    .command_buffer(cb)
                    .device_mask(0)
                    .build()
            })
            .collect();
        let submit_info = vk::SubmitInfo2::builder().command_buffer_infos(&infos);
        return unsafe { device.queue_submit2_khr(queue, &[submit_info], fence) }.vk_check("vkQueueSubmit2KHR");
    }
    let submit_info = vk::SubmitInfo::builder().command_buffers(cmds);
    unsafe { device.queue_submit(queue, &[submit_info], fence) }.vk_check("vkQueueSubmit")
}

fn wait_for_fences(device: &Device, fences: &[vk::Fence]) -> Result<vk::SuccessCode, TestError> {
    unsafe { device.wait_for_fences(fences, true, u64::MAX) }
        .map_err(|e| TestError::ResourceError(format!("vkWaitForFences failed: {e}")))
}

/// `cmdSetEvent` with an empty dependency info; the legacy wrapper falls back to TOP_OF_PIPE.
fn cmd_set_event_empty(device: &Device, sync: SyncType, cmd_buffer: vk::CommandBuffer, event: vk::Event) {
    unsafe {
        if sync == SyncType::Synchronization2 {
            let dependency = vk::DependencyInfo::builder();
            device.cmd_set_event2_khr(cmd_buffer, event, &dependency);
        } else {
            device.cmd_set_event(cmd_buffer, event, vk::PipelineStageFlags::TOP_OF_PIPE);
        }
    }
}

/// `cmdWaitEvents` with an empty dependency info; the legacy fallback is TOP_OF_PIPE -> ALL_COMMANDS.
fn cmd_wait_event_empty(device: &Device, sync: SyncType, cmd_buffer: vk::CommandBuffer, event: vk::Event) {
    unsafe {
        if sync == SyncType::Synchronization2 {
            let dependency = vk::DependencyInfo::builder();
            device.cmd_wait_events2_khr(cmd_buffer, &[event], &[dependency]);
        } else {
            device.cmd_wait_events(
                cmd_buffer,
                &[event],
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::ALL_COMMANDS,
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }
}

/// `hostResetSetEventCase`
fn host_reset_set_event_case(context: &Context<'_>, _config: EventConfig) -> Outcome {
    let device = context.get_device();
    let event = make_event(device, vk::EventCreateFlags::empty())?;

    if event_status(device, *event)? != vk::SuccessCode::EVENT_RESET {
        return Ok(TestStatus::fail("Created event should be in unsignaled state"));
    }
    unsafe { device.set_event(*event) }.vk_check("vkSetEvent")?;
    if event_status(device, *event)? != vk::SuccessCode::EVENT_SET {
        return Ok(TestStatus::fail("Event should be in signaled state after set"));
    }
    unsafe { device.reset_event(*event) }.vk_check("vkResetEvent")?;
    if event_status(device, *event)? != vk::SuccessCode::EVENT_RESET {
        return Ok(TestStatus::fail("Event should be in unsignaled state after reset"));
    }
    Ok(TestStatus::pass("Tests set and reset event on host pass"))
}

/// `deviceResetSetEventCase`
fn device_reset_set_event_case(context: &Context<'_>, config: EventConfig) -> Outcome {
    let device = context.get_device();
    let (queue, queue_family_index) = event_queue(context, config)?;
    let pool = make_command_pool(device, queue_family_index)?;
    let cmd = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;
    let event = make_event(device, vk::EventCreateFlags::empty())?;

    begin_command_buffer(device, *cmd)?;
    if config.sync == SyncType::Synchronization2 {
        let memory_barriers = [make_memory_barrier2(
            vk::PipelineStageFlags2::TOP_OF_PIPE,
            vk::AccessFlags2::empty(),
            vk::PipelineStageFlags2::BOTTOM_OF_PIPE,
            vk::AccessFlags2::empty(),
        )];
        let dependency = vk::DependencyInfo::builder().memory_barriers(&memory_barriers);
        unsafe { device.cmd_set_event2_khr(*cmd, *event, &dependency) };
    } else {
        // The legacy wrapper takes the stage from the first memory barrier's source stage.
        unsafe { device.cmd_set_event(*cmd, *event, vk::PipelineStageFlags::TOP_OF_PIPE) };
    }
    end_command_buffer(device, *cmd)?;
    submit_cmds(device, config.sync, queue, &[*cmd], vk::Fence::null())?;
    wait_idle(device, queue)?;

    if event_status(device, *event)? != vk::SuccessCode::EVENT_SET {
        return Ok(TestStatus::fail("Event should be in signaled state after set"));
    }

    begin_command_buffer(device, *cmd)?;
    unsafe {
        if config.sync == SyncType::Synchronization2 {
            device.cmd_reset_event2_khr(*cmd, *event, vk::PipelineStageFlags2::TOP_OF_PIPE);
        } else {
            device.cmd_reset_event(*cmd, *event, vk::PipelineStageFlags::TOP_OF_PIPE);
        }
    }
    end_command_buffer(device, *cmd)?;
    submit_cmds(device, config.sync, queue, &[*cmd], vk::Fence::null())?;
    wait_idle(device, queue)?;

    if event_status(device, *event)? != vk::SuccessCode::EVENT_RESET {
        return Ok(TestStatus::fail("Event should be in unsignaled state after set"));
    }
    Ok(TestStatus::pass("Device set and reset event tests pass"))
}

/// `eventSetResetNoneStage`
fn event_set_reset_none_stage(context: &Context<'_>, _config: EventConfig) -> Outcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;
    let event = make_event(device, vk::EventCreateFlags::empty())?;

    let memory_barriers = [make_memory_barrier2(
        vk::PipelineStageFlags2::empty(),
        vk::AccessFlags2::empty(),
        vk::PipelineStageFlags2::BOTTOM_OF_PIPE,
        vk::AccessFlags2::MEMORY_WRITE,
    )];
    let dependency = vk::DependencyInfo::builder().memory_barriers(&memory_barriers);
    let simultaneous = vk::CommandBufferBeginInfo::builder().flags(vk::CommandBufferUsageFlags::SIMULTANEOUS_USE);

    unsafe { device.begin_command_buffer(*cmd, &simultaneous) }.vk_check("vkBeginCommandBuffer")?;
    unsafe { device.cmd_set_event2_khr(*cmd, *event, &dependency) };
    end_command_buffer(device, *cmd)?;
    submit_cmds(device, SyncType::Synchronization2, queue, &[*cmd], vk::Fence::null())?;
    wait_idle(device, queue)?;

    if event_status(device, *event)? != vk::SuccessCode::EVENT_SET {
        return Ok(TestStatus::fail("Event should be in signaled state after set"));
    }

    unsafe { device.begin_command_buffer(*cmd, &simultaneous) }.vk_check("vkBeginCommandBuffer")?;
    unsafe { device.cmd_reset_event2_khr(*cmd, *event, vk::PipelineStageFlags2::empty()) };
    end_command_buffer(device, *cmd)?;
    submit_cmds(device, SyncType::Synchronization2, queue, &[*cmd], vk::Fence::null())?;
    wait_idle(device, queue)?;

    if event_status(device, *event)? != vk::SuccessCode::EVENT_RESET {
        return Ok(TestStatus::fail("Event should be in unsignaled state after reset"));
    }
    Ok(TestStatus::pass("Pass"))
}

/// `singleSubmissionCase` - the set and the wait are two command buffers in one submit.
fn single_submission_case(context: &Context<'_>, config: EventConfig) -> Outcome {
    let device = context.get_device();
    let (queue, queue_family_index) = event_queue(context, config)?;
    let fence = make_fence(device)?;
    let pool = make_command_pool(device, queue_family_index)?;
    let set_cmd = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;
    let wait_cmd = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;
    let event = make_event(device, config.flags)?;

    begin_command_buffer(device, *set_cmd)?;
    cmd_set_event_empty(device, config.sync, *set_cmd, *event);
    end_command_buffer(device, *set_cmd)?;

    begin_command_buffer(device, *wait_cmd)?;
    cmd_wait_event_empty(device, config.sync, *wait_cmd, *event);
    end_command_buffer(device, *wait_cmd)?;

    submit_cmds(device, config.sync, queue, &[*set_cmd, *wait_cmd], *fence)?;

    if wait_for_fences(device, &[*fence])? != vk::SuccessCode::SUCCESS {
        return Ok(TestStatus::fail("Queue should end execution"));
    }
    Ok(TestStatus::pass(
        "Wait and set even on device single submission tests pass",
    ))
}

/// `vertexStageBarrierCase`
fn vertex_stage_barrier_case(context: &Context<'_>, config: EventConfig) -> Outcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;
    let event = make_event(device, config.flags)?;

    let barrier = make_memory_barrier2(
        vk::PipelineStageFlags2::VERTEX_SHADER,
        vk::AccessFlags2::empty(),
        vk::PipelineStageFlags2::empty(),
        vk::AccessFlags2::empty(),
    );
    let exec_dep = make_memory_barrier2(
        vk::PipelineStageFlags2::ALL_COMMANDS,
        vk::AccessFlags2::empty(),
        vk::PipelineStageFlags2::VERTEX_SHADER,
        vk::AccessFlags2::empty(),
    );
    let barriers = [barrier];
    let exec_barriers = [exec_dep];
    let event_dependency = vk::DependencyInfo::builder().memory_barriers(&barriers);
    let exec_dependency = vk::DependencyInfo::builder().memory_barriers(&exec_barriers);

    begin_command_buffer(device, *cmd)?;
    unsafe {
        device.cmd_reset_event2_khr(*cmd, *event, vk::PipelineStageFlags2::ALL_COMMANDS);
        device.cmd_pipeline_barrier2_khr(*cmd, &exec_dependency);
        device.cmd_set_event2_khr(*cmd, *event, &event_dependency);
        device.cmd_wait_events2_khr(*cmd, &[*event], &[event_dependency]);
    }
    end_command_buffer(device, *cmd)?;

    let fence = make_fence(device)?;
    submit_cmds(device, config.sync, queue, &[*cmd], *fence)?;
    wait_for_fences(device, &[*fence])?;
    Ok(TestStatus::pass("Pass"))
}

/// `multiSubmissionCase` - the same two command buffers in two separate submits.
fn multi_submission_case(context: &Context<'_>, config: EventConfig) -> Outcome {
    let device = context.get_device();
    let (queue, queue_family_index) = event_queue(context, config)?;
    let set_fence = make_fence(device)?;
    let wait_fence = make_fence(device)?;
    let pool = make_command_pool(device, queue_family_index)?;
    let set_cmd = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;
    let wait_cmd = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;
    let event = make_event(device, config.flags)?;

    begin_command_buffer(device, *set_cmd)?;
    cmd_set_event_empty(device, config.sync, *set_cmd, *event);
    end_command_buffer(device, *set_cmd)?;

    begin_command_buffer(device, *wait_cmd)?;
    cmd_wait_event_empty(device, config.sync, *wait_cmd, *event);
    end_command_buffer(device, *wait_cmd)?;

    submit_cmds(device, config.sync, queue, &[*set_cmd], *set_fence)?;
    submit_cmds(device, config.sync, queue, &[*wait_cmd], *wait_fence)?;

    if wait_for_fences(device, &[*set_fence, *wait_fence])? != vk::SuccessCode::SUCCESS {
        return Ok(TestStatus::fail("Queue should end execution"));
    }
    Ok(TestStatus::pass(
        "Wait and set even on device multi submission tests pass",
    ))
}

/// `checkQueueForExecuteCommands`
fn check_queue_for_execute_commands(context: &Context<'_>, family_index: u32) -> Result<bool, TestError> {
    let families = unsafe {
        context
            .get_instance()
            .get_physical_device_queue_family_properties(context.get_physical_device())
    };
    let family = families.get(family_index as usize).ok_or_else(|| {
        TestError::Fail("Device returns less queue families than the required family index".to_string())
    })?;
    Ok(family
        .queue_flags
        .intersects(vk::QueueFlags::COMPUTE | vk::QueueFlags::GRAPHICS | vk::QueueFlags::TRANSFER))
}

/// `secondaryCommandBufferCase`
fn secondary_command_buffer_case(context: &Context<'_>, config: EventConfig) -> Outcome {
    let device = context.get_device();
    let (queue, queue_family_index) = event_queue(context, config)?;

    if !check_queue_for_execute_commands(context, queue_family_index)? {
        // To avoid VUID-vkCmdExecuteCommands-commandBuffer-cmdpool
        return Err(TestError::NotSupported(
            "The queue doesn't support for seconday commands execution".to_string(),
        ));
    }

    let fence = make_fence(device)?;
    let pool = make_command_pool(device, queue_family_index)?;
    let primary = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;
    let secondary_set = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::SECONDARY)?;
    let secondary_wait = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::SECONDARY)?;
    let event = make_event(device, config.flags)?;

    let inheritance_info = vk::CommandBufferInheritanceInfo::builder();
    let begin_info = vk::CommandBufferBeginInfo::builder()
        .flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT)
        .inheritance_info(&inheritance_info);

    unsafe { device.begin_command_buffer(*secondary_set, &begin_info) }.vk_check("vkBeginCommandBuffer")?;
    cmd_set_event_empty(device, config.sync, *secondary_set, *event);
    end_command_buffer(device, *secondary_set)?;

    unsafe { device.begin_command_buffer(*secondary_wait, &begin_info) }.vk_check("vkBeginCommandBuffer")?;
    cmd_wait_event_empty(device, config.sync, *secondary_wait, *event);
    end_command_buffer(device, *secondary_wait)?;

    begin_command_buffer(device, *primary)?;
    unsafe { device.cmd_execute_commands(*primary, &[*secondary_set, *secondary_wait]) };
    end_command_buffer(device, *primary)?;

    submit_cmds(device, config.sync, queue, &[*primary], *fence)?;

    if wait_for_fences(device, &[*fence])? != vk::SuccessCode::SUCCESS {
        return Ok(TestStatus::fail("Queue should end execution"));
    }
    Ok(TestStatus::pass(
        "Wait and set even on device using secondary command buffers tests pass",
    ))
}

/// `checkSupport` of the event tests
fn check_event_support(context: &Context<'_>, config: EventConfig) -> Result<(), TestError> {
    if config.sync == SyncType::Synchronization2 {
        context.require_device_functionality("VK_KHR_synchronization2")?;
    }
    if context.is_device_functionality_supported("VK_KHR_portability_subset") {
        return Err(TestError::NotSupported(
            "VK_KHR_portability_subset: Events are not supported by this implementation".to_string(),
        ));
    }
    if config.compute_queue && context.get_compute_queue().is_none() {
        return Err(TestError::NotSupported("no dedicated compute queue".to_string()));
    }
    Ok(())
}

struct EventCase {
    name: String,
    config: EventConfig,
    run: fn(&Context<'_>, EventConfig) -> Outcome,
}

impl TestCase for EventCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_event_support(context, self.config)
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(EventInstance { context, case: self })
    }
}

struct EventInstance<'a> {
    context: &'a Context<'a>,
    case: &'a EventCase,
}

impl TestInstance for EventInstance<'_> {
    fn iterate(&mut self) -> Outcome {
        (self.case.run)(self.context, self.case.config)
    }
}

/// `createBasicEventTests` / `createSynchronization2BasicEventTests`
pub fn create_basic_event_tests(sync: SyncType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("event");
    let add = |group: &mut TestCaseGroup,
               name: String,
               config: EventConfig,
               run: fn(&Context<'_>, EventConfig) -> Outcome| {
        group.add_child(Box::new(EventCase { name, config, run }) as Box<dyn TestCase>);
    };

    for compute_queue in [false, true] {
        let suffix = if compute_queue { "_cq" } else { "" };
        let mut config = EventConfig {
            sync,
            flags: vk::EventCreateFlags::empty(),
            compute_queue,
        };

        if sync == SyncType::Legacy {
            add(
                &mut group,
                format!("host_set_reset{suffix}"),
                config,
                host_reset_set_event_case,
            );
            add(
                &mut group,
                format!("device_set_reset{suffix}"),
                config,
                device_reset_set_event_case,
            );
            add(
                &mut group,
                format!("single_submit_multi_command_buffer{suffix}"),
                config,
                single_submission_case,
            );
            add(
                &mut group,
                format!("multi_submit_multi_command_buffer{suffix}"),
                config,
                multi_submission_case,
            );
            add(
                &mut group,
                format!("multi_secondary_command_buffer{suffix}"),
                config,
                secondary_command_buffer_case,
            );
        } else {
            add(
                &mut group,
                format!("device_set_reset{suffix}"),
                config,
                device_reset_set_event_case,
            );
            add(
                &mut group,
                format!("single_submit_multi_command_buffer{suffix}"),
                config,
                single_submission_case,
            );
            add(
                &mut group,
                format!("multi_submit_multi_command_buffer{suffix}"),
                config,
                multi_submission_case,
            );
            add(
                &mut group,
                format!("multi_secondary_command_buffer{suffix}"),
                config,
                secondary_command_buffer_case,
            );
            add(
                &mut group,
                format!("none_set_reset{suffix}"),
                config,
                event_set_reset_none_stage,
            );
            if !compute_queue {
                add(
                    &mut group,
                    "vertex_stage_barrier".to_string(),
                    config,
                    vertex_stage_barrier_case,
                );
            }

            config.flags = vk::EventCreateFlags::DEVICE_ONLY;
            add(
                &mut group,
                format!("single_submit_multi_command_buffer_device_only{suffix}"),
                config,
                single_submission_case,
            );
            add(
                &mut group,
                format!("multi_submit_multi_command_buffer_device_only{suffix}"),
                config,
                multi_submission_case,
            );
            add(
                &mut group,
                format!("multi_secondary_command_buffer_device_only{suffix}"),
                config,
                secondary_command_buffer_case,
            );
        }
    }

    group
}

// ---------------------------------------------------------------------------------
// Semaphores
// ---------------------------------------------------------------------------------

/// `TestConfig` of `vktSynchronizationBasicSemaphoreTests.cpp`
#[derive(Clone, Copy)]
struct SemaphoreConfig {
    use_type_create: bool,
    semaphore_type: vk::SemaphoreType,
    sync: SyncType,
}

impl SemaphoreConfig {
    fn is_timeline(self) -> bool {
        self.semaphore_type == vk::SemaphoreType::TIMELINE
    }
}

/// `createTestSemaphore`
fn create_test_semaphore(device: &Device, config: SemaphoreConfig) -> Result<Unique<'_, vk::Semaphore>, TestError> {
    if config.use_type_create {
        create_semaphore_type(device, config.semaphore_type)
    } else {
        let semaphore = unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
            .vk_check("vkCreateSemaphore")?;
        Ok(Unique::new(device, semaphore))
    }
}

fn simultaneous_use_begin(device: &Device, cmd: vk::CommandBuffer) -> Result<(), TestError> {
    let info = vk::CommandBufferBeginInfo::builder().flags(vk::CommandBufferUsageFlags::SIMULTANEOUS_USE);
    unsafe { device.begin_command_buffer(cmd, &info) }.vk_check("vkBeginCommandBuffer")
}

/// `basicOneQueueCase` - one queue, one semaphore between two submits of the same command buffer.
fn basic_one_queue_case(context: &Context<'_>, config: SemaphoreConfig) -> Outcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let semaphore = create_test_semaphore(device, config)?;
    let pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;
    let fence = make_fence(device)?;
    let timeline_value = 1u64;

    simultaneous_use_begin(device, *cmd)?;
    end_command_buffer(device, *cmd)?;

    let signal = SemaphoreOp {
        semaphore: *semaphore,
        value: timeline_value,
        stage: vk::PipelineStageFlags2::BOTTOM_OF_PIPE,
    };
    let wait = SemaphoreOp {
        semaphore: *semaphore,
        value: timeline_value,
        stage: vk::PipelineStageFlags2::TOP_OF_PIPE,
    };
    submit(
        device,
        config.sync,
        config.is_timeline(),
        queue,
        *cmd,
        None,
        Some(signal),
        vk::Fence::null(),
    )?;
    submit(
        device,
        config.sync,
        config.is_timeline(),
        queue,
        *cmd,
        Some(wait),
        None,
        *fence,
    )?;

    if wait_for_fences(device, &[*fence])? != vk::SuccessCode::SUCCESS {
        return Ok(TestStatus::fail("Basic semaphore tests with one queue failed"));
    }
    Ok(TestStatus::pass("Basic semaphore tests with one queue passed"))
}

/// `noneWaitSubmitTest` - a submit that waits at the none stage still orders after the semaphore's signal.
fn none_wait_submit_test(context: &Context<'_>, config: SemaphoreConfig) -> Outcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let semaphore = create_test_semaphore(device, config)?;
    let pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let first = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;
    let second = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;
    let fence1 = make_fence(device)?;
    let fence2 = make_fence(device)?;
    let event = make_event(device, vk::EventCreateFlags::empty())?;

    simultaneous_use_begin(device, *first)?;
    end_command_buffer(device, *first)?;

    let semaphores = [*semaphore];
    let first_buffers = [*first];
    let first_submit = vk::SubmitInfo::builder()
        .command_buffers(&first_buffers)
        .signal_semaphores(&semaphores);

    // Waiting on the none stage.
    let wait_stages = [vk::PipelineStageFlags::empty()];
    let second_buffers = [*second];
    let second_submit = vk::SubmitInfo::builder()
        .wait_semaphores(&semaphores)
        .wait_dst_stage_mask(&wait_stages)
        .command_buffers(&second_buffers);

    simultaneous_use_begin(device, *second)?;
    unsafe { device.cmd_set_event(*second, *event, vk::PipelineStageFlags::TOP_OF_PIPE) };
    end_command_buffer(device, *second)?;

    unsafe { device.queue_submit(queue, &[first_submit], *fence1) }.vk_check("vkQueueSubmit")?;
    unsafe { device.queue_submit(queue, &[second_submit], *fence2) }.vk_check("vkQueueSubmit")?;
    wait_idle(device, queue)?;

    if wait_for_fences(device, &[*fence1])? != vk::SuccessCode::SUCCESS {
        return Ok(TestStatus::fail("None stage test failed, failed to wait for fence"));
    }
    if wait_for_fences(device, &[*fence2])? != vk::SuccessCode::SUCCESS {
        return Ok(TestStatus::fail(
            "None stage test failed, failed to wait for the second fence",
        ));
    }
    if event_status(device, *event)? != vk::SuccessCode::EVENT_SET {
        return Ok(TestStatus::fail("None stage test failed, event isn't set"));
    }
    Ok(TestStatus::pass("Pass"))
}

/// `getQueues` without video queues: the first queue family, then the first family that is another one or has a second queue.
fn find_queue_families(families: &[crate::vkt::context::QueueFamilyQueues]) -> (Option<usize>, Option<usize>) {
    let mut first = None;
    for (index, family) in families.iter().enumerate() {
        if first.is_none() {
            first = Some(index);
        }
        if first != Some(index) || family.queues.len() > 1 {
            return (first, Some(index));
        }
    }
    (first, None)
}

/// `basicMultiQueueCase` - the semaphore orders submits made to two different queues, then the same with the roles swapped.
fn basic_multi_queue_case(context: &Context<'_>, config: SemaphoreConfig) -> Outcome {
    let queues_device = context.multi_queue_device()?;
    let device = queues_device.device();
    let is_timeline = config.is_timeline();

    let (Some(first_family), Some(second_family)) = find_queue_families(queues_device.families()) else {
        return Err(TestError::NotSupported("Queues couldn't be created".to_string()));
    };
    let same_family = first_family == second_family;
    let first_queue = queues_device.families()[first_family].queues[0];
    let second_queue = queues_device.families()[second_family].queues[usize::from(same_family)];
    let first_family_index = queues_device.families()[first_family].family_index;
    let second_family_index = queues_device.families()[second_family].family_index;

    let semaphore = create_test_semaphore(device, config)?;
    let pool_first = make_command_pool(device, first_family_index)?;
    let pool_second = make_command_pool(device, second_family_index)?;
    let cmd_first = allocate_command_buffer(device, *pool_first, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_second = allocate_command_buffer(device, *pool_second, vk::CommandBufferLevel::PRIMARY)?;
    simultaneous_use_begin(device, *cmd_first)?;
    end_command_buffer(device, *cmd_first)?;
    simultaneous_use_begin(device, *cmd_second)?;
    end_command_buffer(device, *cmd_second)?;
    let fence_first = make_fence(device)?;
    let fence_second = make_fence(device)?;

    let signal_info = |value: u64| SemaphoreOp {
        semaphore: *semaphore,
        value,
        stage: vk::PipelineStageFlags2::BOTTOM_OF_PIPE,
    };
    let wait_info = |value: u64| SemaphoreOp {
        semaphore: *semaphore,
        value,
        stage: vk::PipelineStageFlags2::TOP_OF_PIPE,
    };
    let (timeline_first, timeline_second) = (1u64, 2u64);

    submit(
        device,
        config.sync,
        is_timeline,
        first_queue,
        *cmd_first,
        None,
        Some(signal_info(timeline_first)),
        *fence_first,
    )?;
    submit(
        device,
        config.sync,
        is_timeline,
        second_queue,
        *cmd_second,
        Some(wait_info(timeline_first)),
        Some(signal_info(timeline_second)),
        *fence_second,
    )?;

    if wait_for_fences(device, &[*fence_first])? != vk::SuccessCode::SUCCESS
        || wait_for_fences(device, &[*fence_second])? != vk::SuccessCode::SUCCESS
    {
        return Ok(TestStatus::fail("Basic semaphore tests with multi queue failed"));
    }

    // Swap the semaphore infos compared to the submits above.
    let (timeline_first, timeline_second) = if is_timeline {
        (3u64, 4u64)
    } else {
        (timeline_first, timeline_second)
    };
    unsafe { device.reset_fences(&[*fence_first]) }.vk_check("vkResetFences")?;
    unsafe { device.reset_fences(&[*fence_second]) }.vk_check("vkResetFences")?;

    let wait_value = if is_timeline { 3u64 } else { timeline_first };
    submit(
        device,
        config.sync,
        is_timeline,
        second_queue,
        *cmd_second,
        if is_timeline { None } else { Some(wait_info(wait_value)) },
        Some(signal_info(timeline_first)),
        *fence_second,
    )?;
    submit(
        device,
        config.sync,
        is_timeline,
        first_queue,
        *cmd_first,
        Some(wait_info(wait_value)),
        Some(signal_info(timeline_second)),
        *fence_first,
    )?;

    if wait_for_fences(device, &[*fence_first])? != vk::SuccessCode::SUCCESS
        || wait_for_fences(device, &[*fence_second])? != vk::SuccessCode::SUCCESS
    {
        return Ok(TestStatus::fail("Basic semaphore tests with multi queue failed"));
    }
    Ok(TestStatus::pass("Basic semaphore tests with multi queue passed"))
}

/// `basicThreadTimelineCase` - a timeline semaphore handed back and forth between the test and a thread.
fn basic_thread_timeline_case(context: &Context<'_>, _config: SemaphoreConfig) -> Outcome {
    const WAIT_TIMEOUT: u64 = 50 * 1_000_000;
    let device = context.get_device();
    let mut type_info = vk::SemaphoreTypeCreateInfo::builder()
        .semaphore_type(vk::SemaphoreType::TIMELINE)
        .initial_value(0);
    let info = vk::SemaphoreCreateInfo::builder().push_next(&mut type_info);
    let semaphore = Unique::new(
        device,
        unsafe { device.create_semaphore(&info, None) }.vk_check("vkCreateSemaphore")?,
    );
    let semaphore_handle = *semaphore;

    let wait_for = |value: u64| -> Result<vk::SuccessCode, vk::ErrorCode> {
        let semaphores = [semaphore_handle];
        let values = [value];
        let wait_info = vk::SemaphoreWaitInfo::builder()
            .flags(vk::SemaphoreWaitFlags::ANY)
            .semaphores(&semaphores)
            .values(&values);
        unsafe { device.wait_semaphores(&wait_info, WAIT_TIMEOUT) }
    };
    let signal = |value: u64| -> Result<(), vk::ErrorCode> {
        let signal_info = vk::SemaphoreSignalInfo::builder()
            .semaphore(semaphore_handle)
            .value(value);
        unsafe { device.signal_semaphore(&signal_info) }
    };

    // The thread waits for the value 1, then signals 2; the semaphore starts at 0.
    let (main_result, thread_result) = std::thread::scope(|scope| {
        let thread = scope.spawn(|| match wait_for(1) {
            Ok(vk::SuccessCode::SUCCESS) => signal(2).map(|()| vk::SuccessCode::SUCCESS),
            other => other,
        });

        // Gives the thread a chance to start.
        std::thread::sleep(std::time::Duration::from_millis(1));
        let _ = signal(1);

        let main_result = wait_for(2);
        let thread_result = thread.join().expect("the waiting thread does not panic");
        (main_result, thread_result)
    });

    if main_result == Ok(vk::SuccessCode::SUCCESS) {
        return Ok(TestStatus::pass("Pass"));
    }
    if main_result == Ok(vk::SuccessCode::TIMEOUT) || thread_result == Ok(vk::SuccessCode::TIMEOUT) {
        return Ok(TestStatus::new(TestResult::QualityWarning, "Reached wait timeout"));
    }
    Ok(TestStatus::fail("Fail"))
}

/// `checkSupport`, `checkCommandBufferSimultaneousUseSupport` and `checkMultiQueueSupport` of the semaphore tests.
#[derive(Clone, Copy, PartialEq, Eq)]
enum SemaphoreSupport {
    Plain,
    MultiQueue,
}

struct SemaphoreCase {
    name: String,
    config: SemaphoreConfig,
    support: SemaphoreSupport,
    run: fn(&Context<'_>, SemaphoreConfig) -> Outcome,
}

impl TestCase for SemaphoreCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.config.is_timeline() {
            context.require_device_functionality("VK_KHR_timeline_semaphore")?;
        }
        if self.config.sync == SyncType::Synchronization2 {
            context.require_device_functionality("VK_KHR_synchronization2")?;
        }
        if self.support == SemaphoreSupport::MultiQueue {
            let queues_device = context.multi_queue_device()?;
            if find_queue_families(queues_device.families()).1.is_none() {
                return Err(TestError::NotSupported("Queues couldn't be created".to_string()));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SemaphoreInstance { context, case: self })
    }
}

struct SemaphoreInstance<'a> {
    context: &'a Context<'a>,
    case: &'a SemaphoreCase,
}

impl TestInstance for SemaphoreInstance<'_> {
    fn iterate(&mut self) -> Outcome {
        (self.case.run)(self.context, self.case.config)
    }
}

fn add_semaphore_case(
    group: &mut TestCaseGroup,
    name: &str,
    config: SemaphoreConfig,
    support: SemaphoreSupport,
    run: fn(&Context<'_>, SemaphoreConfig) -> Outcome,
) {
    group.add_child(Box::new(SemaphoreCase {
        name: name.to_string(),
        config,
        support,
        run,
    }) as Box<dyn TestCase>);
}

/// The binary semaphore cases `createBasicBinarySemaphoreTests` adds besides `chain`.
pub fn add_basic_binary_semaphore_tests(group: &mut TestCaseGroup, sync: SyncType) {
    let mut config = SemaphoreConfig {
        use_type_create: false,
        semaphore_type: vk::SemaphoreType::BINARY,
        sync,
    };

    for typed_create in [false, true] {
        config.use_type_create = typed_create;
        let create_name = if typed_create { "_typed" } else { "" };
        add_semaphore_case(
            group,
            &format!("one_queue{create_name}"),
            config,
            SemaphoreSupport::Plain,
            basic_one_queue_case,
        );
        add_semaphore_case(
            group,
            &format!("multi_queue{create_name}"),
            config,
            SemaphoreSupport::MultiQueue,
            basic_multi_queue_case,
        );
    }

    if sync == SyncType::Synchronization2 {
        add_semaphore_case(
            group,
            "none_wait_submit",
            config,
            SemaphoreSupport::Plain,
            none_wait_submit_test,
        );
    }
}

/// The timeline semaphore cases `createBasicTimelineSemaphoreTests` adds besides `chain` and the wait-for-value ones.
pub fn add_basic_timeline_semaphore_tests(group: &mut TestCaseGroup, sync: SyncType) {
    let config = SemaphoreConfig {
        use_type_create: true,
        semaphore_type: vk::SemaphoreType::TIMELINE,
        sync,
    };

    add_semaphore_case(
        group,
        "one_queue",
        config,
        SemaphoreSupport::Plain,
        basic_one_queue_case,
    );
    add_semaphore_case(
        group,
        "multi_queue",
        config,
        SemaphoreSupport::MultiQueue,
        basic_multi_queue_case,
    );

    // Not repeated for synchronization2.
    if sync == SyncType::Legacy {
        add_semaphore_case(
            group,
            "two_threads",
            config,
            SemaphoreSupport::Plain,
            basic_thread_timeline_case,
        );
    }
}
