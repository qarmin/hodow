// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationTimelineSemaphoreTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The two timeline subgroups that spread a chain across every queue in the system.
// Both exist because a timeline wait names a *value*, not a state, so a submission may
// legally be enqueued before anything can possibly signal what it waits on:
//
//   - `wait_before_signal` submits the chain in reverse dependency order, so every
//     submit but the last is waiting on a value no one has produced yet. Only a host
//     signal at the very end unblocks the whole thing. A driver that requires the
//     signal to precede the wait deadlocks or runs the chain out of order.
//   - `one_to_n` fans one write out to a copy on every queue, then a read behind each
//     copy, so a single payload has to arrive intact at N independent readers.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_2;

use super::operation::{
    COPY_OPS, Operation, OperationName, RESOURCES, Resource, ResourceDescription, ResourceType, SyncInfo, SyncType, build_copy_operation, build_operation, cmd_pipeline_barrier,
    first_difference, get_resource_name, is_stage_supported, make_buffer_memory_barrier2, make_image_memory_barrier2,
};
use super::timeline_semaphore_tests::randomize_data;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `QueueTimelineIteration` - one operation, the queue it goes to, and the timeline
/// value its submission signals.
struct QueueTimelineIteration {
    op_name: OperationName,
    queue: vk::Queue,
    queue_family_idx: u32,
    timeline_value: u64,
}

impl QueueTimelineIteration {
    fn new(op_name: OperationName, last_value: u64, queue: vk::Queue, queue_family_idx: u32, rng: &mut Random) -> Self {
        Self {
            op_name,
            queue,
            queue_family_idx,
            timeline_value: last_value + rng.get_int(1, 100) as u64,
        }
    }
}

/// Which of the two groups a case belongs to.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum TimelineQueueKind {
    WaitBeforeSignal,
    OneToN,
}

impl TimelineQueueKind {
    fn group_name(self) -> &'static str {
        match self {
            Self::WaitBeforeSignal => "wait_before_signal",
            Self::OneToN => "one_to_n",
        }
    }
}

/// `WaitBeforeSignalTestCase` / `OneToNTestCase` - the two differ only in which
/// instance they build.
pub struct TimelineQueueTestCase {
    name: String,
    kind: TimelineQueueKind,
    sync_type: SyncType,
    resource: ResourceDescription,
    write_op: OperationName,
    read_op: OperationName,
}

impl TestCase for TimelineQueueTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_timeline_semaphore")?;
        if self.sync_type == SyncType::Synchronization2 {
            context.require_device_functionality("VK_KHR_synchronization2")?;
        }
        self.write_op.check_support(context, &self.resource)?;
        self.read_op.check_support(context, &self.resource)?;
        for &copy_op in COPY_OPS {
            if copy_op.supports_resource(&self.resource) {
                copy_op.copy_check_support(context, &self.resource)?;
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TimelineQueueTestInstance { context, params: self })
    }
}

struct TimelineQueueTestInstance<'a> {
    context: &'a Context<'a>,
    params: &'a TimelineQueueTestCase,
}

impl TestInstance for TimelineQueueTestInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        match self.params.kind {
            TimelineQueueKind::WaitBeforeSignal => self.run_wait_before_signal(),
            TimelineQueueKind::OneToN => self.run_one_to_n(),
        }
    }
}

impl TimelineQueueTestInstance<'_> {
    /// `WaitBeforeSignalTestInstance`
    fn run_wait_before_signal(&self) -> Result<TestStatus, TestError> {
        let p = self.params;
        let queues = self.context.multi_queue_device()?;
        let device = queues.device();
        let allocator = queues.allocator();
        let families = queues.families();
        let universal = families[0].family_index;

        let mut rng = Random::new(1234);
        let host_timeline_value = rng.get_int(0, 1000) as u64;

        let mut iterations = vec![QueueTimelineIteration::new(p.write_op, host_timeline_value, families[0].queues[0], universal, &mut rng)];
        let mut used_queues = vec![(universal, 0usize)];

        // Use every queue in the system once, each running whichever copy operation it
        // is capable of. The chain is only as interesting as the number of distinct
        // queues it crosses.
        for family in families {
            for (instance_idx, &queue) in family.queues.iter().enumerate() {
                if used_queues.contains(&(family.family_index, instance_idx)) {
                    continue;
                }
                let Some(copy_op) = COPY_OPS.iter().copied().find(|&copy_op| {
                    copy_op.supports_resource(&p.resource)
                        && family.flags.contains(copy_op.copy_queue_flags(&p.resource))
                        // The barriers below name VERTEX_INPUT, so the queue has to be
                        // able to run graphics whatever the copy itself needs.
                        && copy_op.copy_queue_flags(&p.resource).contains(vk::QueueFlags::GRAPHICS)
                }) else {
                    continue;
                };
                let last_value = iterations[iterations.len() - 1].timeline_value;
                iterations.push(QueueTimelineIteration::new(copy_op, last_value, queue, family.family_index, &mut rng));
                used_queues.push((family.family_index, instance_idx));
            }
        }

        let last_value = iterations[iterations.len() - 1].timeline_value;
        iterations.push(QueueTimelineIteration::new(p.read_op, last_value, families[0].queues[0], universal, &mut rng));

        let mut resources = Vec::with_capacity(iterations.len() - 1);
        for window in iterations.windows(2) {
            let usage = out_usage(window[0].op_name, &p.resource) | in_usage(window[1].op_name, &p.resource);
            resources.push(Resource::new(device, allocator, &p.resource, usage)?);
        }

        let mut ops: Vec<Box<dyn Operation + '_>> = Vec::with_capacity(iterations.len());
        ops.push(build_operation(device, allocator, iterations[0].op_name, &p.resource, &resources[0], false)?);
        for ndx in 1..iterations.len() - 1 {
            ops.push(build_copy_operation(
                device,
                allocator,
                iterations[ndx].op_name,
                &p.resource,
                &resources[ndx - 1],
                &resources[ndx],
                false,
            )?);
        }
        let last = iterations.len() - 1;
        ops.push(build_operation(
            device,
            allocator,
            iterations[last].op_name,
            &p.resource,
            &resources[resources.len() - 1],
            false,
        )?);

        let semaphore = create_timeline_semaphore(device)?;
        let mut command_pools = Vec::with_capacity(iterations.len());
        let mut command_buffers = Vec::with_capacity(iterations.len());
        for iteration in &iterations {
            let pool = make_command_pool(device, iteration.queue_family_idx)?;
            command_buffers.push(allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?);
            command_pools.push(pool);
        }

        let mut data = ops[0].data(device)?;
        randomize_data(&mut data, &p.resource);
        ops[0].set_data(device, &data)?;

        // Submit in reverse dependency order. Every one of these is waiting on a value
        // that will only be signalled by a submission made *after* it, which is the
        // behaviour under test.
        for reverse_ndx in 0..iterations.len() - 1 {
            let ndx = iterations.len() - 2 - reverse_ndx;
            let cmd = *command_buffers[ndx];
            begin_command_buffer(device, cmd)?;

            if ndx > 0 {
                // The resource this operation reads was left by a queue that has not
                // run yet, so it is still in UNDEFINED and has to be acquired.
                let read_sync = ops[ndx].in_sync_info(p.sync_type);
                if p.resource.kind == ResourceType::Image {
                    let image = resources[ndx - 1].image();
                    let mut barrier = make_image_memory_barrier2(
                        vk::PipelineStageFlags2::TOP_OF_PIPE,
                        vk::AccessFlags2::empty(),
                        read_sync.stage_mask,
                        read_sync.access_mask,
                        vk::ImageLayout::UNDEFINED,
                        read_sync.image_layout,
                        image.handle,
                        image.subresource_range,
                    );
                    barrier.src_queue_family_index = iterations[ndx].queue_family_idx;
                    barrier.dst_queue_family_index = iterations[ndx + 1].queue_family_idx;
                    cmd_pipeline_barrier(device, p.sync_type, cmd, &[], &[barrier]);
                }
            }

            ops[ndx].record_commands(device, p.sync_type, cmd);
            self.record_handoff_barrier(
                device,
                cmd,
                ops[ndx].out_sync_info(p.sync_type),
                ops[ndx + 1].in_sync_info(p.sync_type),
                &resources[ndx],
                iterations[ndx].queue_family_idx,
                iterations[ndx + 1].queue_family_idx,
                true,
            );
            end_command_buffer(device, cmd)?;

            let wait_value = if ndx == 0 { host_timeline_value } else { iterations[ndx - 1].timeline_value };
            self.submit(device, iterations[ndx].queue, *semaphore, cmd, &[wait_value], iterations[ndx].timeline_value)?;
        }

        // The read goes last and in order, so by the time it is submitted its
        // dependency really has been enqueued.
        {
            let ndx = iterations.len() - 1;
            let cmd = *command_buffers[ndx];
            begin_command_buffer(device, cmd)?;
            ops[ndx].record_commands(device, p.sync_type, cmd);
            end_command_buffer(device, cmd)?;
            self.submit(
                device,
                iterations[ndx].queue,
                *semaphore,
                cmd,
                &[iterations[ndx - 1].timeline_value],
                iterations[ndx].timeline_value,
            )?;
        }

        host_signal(device, *semaphore, host_timeline_value)?;
        unsafe { device.device_wait_idle() }.vk_check("vkDeviceWaitIdle")?;

        let expected = ops[0].data(device)?;
        let actual = ops[ops.len() - 1].data(device)?;
        if let Some(at) = first_difference(&expected, &actual) {
            return Ok(TestStatus::fail(format!(
                "Memory contents don't match: first difference at byte {at} of {}, expected {:#04x} got {:#04x}",
                expected.len(),
                expected[at],
                actual[at],
            )));
        }
        Ok(TestStatus::pass("OK"))
    }

    /// `OneToNTestInstance`
    fn run_one_to_n(&self) -> Result<TestStatus, TestError> {
        let p = self.params;
        let queues = self.context.multi_queue_device()?;
        let device = queues.device();
        let allocator = queues.allocator();
        let families = queues.families();
        let universal = families[0].family_index;

        let mut rng = Random::new(1234);
        let host_timeline_value = rng.get_int(0, 1000) as u64;

        let write_iteration = QueueTimelineIteration::new(p.write_op, host_timeline_value, families[0].queues[0], universal, &mut rng);
        let mut last_submit_value = write_iteration.timeline_value;

        // One copy per queue in the system, every one of them reading the *same* written
        // resource. Unlike wait_before_signal this does not skip the universal queue,
        // so a single-queue device still gets one copy.
        let mut copy_iterations = Vec::new();
        for family in families {
            for &queue in &family.queues {
                let Some(copy_op) = COPY_OPS.iter().copied().find(|&copy_op| {
                    if !copy_op.supports_resource(&p.resource) {
                        return false;
                    }
                    let flags = copy_op.copy_queue_flags(&p.resource);
                    if !family.flags.contains(flags) {
                        return false;
                    }
                    // The write and the read run in whatever stage they were named for,
                    // so a queue that cannot run that stage cannot host this copy.
                    for stage in [p.write_op.shader_stage(), p.read_op.shader_stage()].into_iter().flatten() {
                        if !is_stage_supported(stage, flags) {
                            return false;
                        }
                    }
                    true
                }) else {
                    continue;
                };
                copy_iterations.push(QueueTimelineIteration::new(copy_op, last_submit_value, queue, family.family_index, &mut rng));
                last_submit_value = copy_iterations[copy_iterations.len() - 1].timeline_value;
            }
        }

        // One read behind each copy, all on the universal queue.
        let read_op_flags = p.read_op.queue_flags(&p.resource);
        if read_op_flags.contains(vk::QueueFlags::GRAPHICS) && !families.iter().any(|f| f.flags.contains(vk::QueueFlags::GRAPHICS)) {
            return Err(TestError::NotSupported("Graphics queue required but not supported by the driver".into()));
        }
        let mut read_iterations = Vec::with_capacity(copy_iterations.len());
        for _ in 0..copy_iterations.len() {
            let usable = families.iter().any(|f| {
                f.flags.contains(read_op_flags) || (read_op_flags.contains(vk::QueueFlags::TRANSFER) && f.flags.intersects(vk::QueueFlags::GRAPHICS | vk::QueueFlags::COMPUTE))
            });
            if !usable {
                continue;
            }
            read_iterations.push(QueueTimelineIteration::new(p.read_op, last_submit_value, families[0].queues[0], universal, &mut rng));
            last_submit_value = read_iterations[read_iterations.len() - 1].timeline_value;
        }

        // No guard for an empty chain: when no queue can host a copy of this resource -
        // a depth or stencil image, say - upstream submits the write, has nothing to
        // compare, and passes. The verdicts have to match that.
        debug_assert_eq!(copy_iterations.len(), read_iterations.len());

        let mut write_usage = p.write_op.out_resource_usage(&p.resource);
        for copy in &copy_iterations {
            write_usage |= in_usage(copy.op_name, &p.resource);
        }
        let write_resource = Resource::new(device, allocator, &p.resource, write_usage)?;
        let write_op = build_operation(device, allocator, p.write_op, &p.resource, &write_resource, false)?;

        let mut copy_resources = Vec::with_capacity(copy_iterations.len());
        for copy in &copy_iterations {
            let usage = out_usage(copy.op_name, &p.resource) | p.read_op.in_resource_usage(&p.resource);
            copy_resources.push(Resource::new(device, allocator, &p.resource, usage)?);
        }
        let mut copy_ops: Vec<Box<dyn Operation + '_>> = Vec::with_capacity(copy_iterations.len());
        let mut read_ops: Vec<Box<dyn Operation + '_>> = Vec::with_capacity(copy_iterations.len());
        for ndx in 0..copy_iterations.len() {
            copy_ops.push(build_copy_operation(
                device,
                allocator,
                copy_iterations[ndx].op_name,
                &p.resource,
                &write_resource,
                &copy_resources[ndx],
                false,
            )?);
            read_ops.push(build_operation(device, allocator, p.read_op, &p.resource, &copy_resources[ndx], false)?);
        }

        let semaphore = create_timeline_semaphore(device)?;
        let write_pool = make_command_pool(device, write_iteration.queue_family_idx)?;
        let write_cmd = allocate_command_buffer(device, *write_pool, vk::CommandBufferLevel::PRIMARY)?;
        let mut copy_pools = Vec::new();
        let mut copy_cmds = Vec::new();
        let mut read_pools = Vec::new();
        let mut read_cmds = Vec::new();
        for ndx in 0..copy_iterations.len() {
            let pool = make_command_pool(device, copy_iterations[ndx].queue_family_idx)?;
            copy_cmds.push(allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?);
            copy_pools.push(pool);
            let pool = make_command_pool(device, read_iterations[ndx].queue_family_idx)?;
            read_cmds.push(allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?);
            read_pools.push(pool);
        }

        let mut data = write_op.data(device)?;
        randomize_data(&mut data, &p.resource);
        write_op.set_data(device, &data)?;

        begin_command_buffer(device, *write_cmd)?;
        write_op.record_commands(device, p.sync_type, *write_cmd);
        // The written resource is the source of N copies, so it is released once, not
        // once per copy - upstream records the barrier only for the first two indices,
        // the second of which is what puts it in the layout the rest will read.
        for ndx in 0..copy_iterations.len().min(2) {
            self.record_release_barrier(
                device,
                *write_cmd,
                write_op.out_sync_info(p.sync_type),
                copy_ops[ndx].in_sync_info(p.sync_type),
                &write_resource,
                write_iteration.queue_family_idx,
                copy_iterations[ndx].queue_family_idx,
                ndx == 0,
            );
        }
        end_command_buffer(device, *write_cmd)?;

        for ndx in 0..copy_iterations.len() {
            let cmd = *copy_cmds[ndx];
            begin_command_buffer(device, cmd)?;
            if ndx < 2 {
                self.record_handoff_barrier(
                    device,
                    cmd,
                    write_op.out_sync_info(p.sync_type),
                    copy_ops[ndx].in_sync_info(p.sync_type),
                    &write_resource,
                    write_iteration.queue_family_idx,
                    copy_iterations[ndx].queue_family_idx,
                    ndx == 0,
                );
            }
            copy_ops[ndx].record_commands(device, p.sync_type, cmd);
            self.record_release_barrier(
                device,
                cmd,
                copy_ops[ndx].out_sync_info(p.sync_type),
                read_ops[ndx].in_sync_info(p.sync_type),
                &copy_resources[ndx],
                copy_iterations[ndx].queue_family_idx,
                read_iterations[ndx].queue_family_idx,
                true,
            );
            end_command_buffer(device, cmd)?;
        }

        for ndx in 0..read_iterations.len() {
            let cmd = *read_cmds[ndx];
            begin_command_buffer(device, cmd)?;
            self.record_handoff_barrier(
                device,
                cmd,
                copy_ops[ndx].out_sync_info(p.sync_type),
                read_ops[ndx].in_sync_info(p.sync_type),
                &copy_resources[ndx],
                copy_iterations[ndx].queue_family_idx,
                read_iterations[ndx].queue_family_idx,
                true,
            );
            read_ops[ndx].record_commands(device, p.sync_type, cmd);
            end_command_buffer(device, cmd)?;
        }

        self.submit(
            device,
            write_iteration.queue,
            *semaphore,
            *write_cmd,
            &[host_timeline_value],
            write_iteration.timeline_value,
        )?;
        for ndx in 0..copy_iterations.len() {
            // Every copy waits on the write; from the second on it also waits on its
            // predecessor, which serialises the copies without ordering them against
            // the reads.
            let waits: Vec<u64> = if ndx > 0 {
                vec![write_iteration.timeline_value, copy_iterations[ndx - 1].timeline_value]
            } else {
                vec![write_iteration.timeline_value]
            };
            self.submit(device, copy_iterations[ndx].queue, *semaphore, *copy_cmds[ndx], &waits, copy_iterations[ndx].timeline_value)?;
        }
        for ndx in 0..read_iterations.len() {
            let second = if ndx > 0 {
                read_iterations[ndx - 1].timeline_value
            } else {
                copy_iterations[copy_iterations.len() - 1].timeline_value
            };
            let waits = [copy_iterations[ndx].timeline_value, second];
            self.submit(device, read_iterations[ndx].queue, *semaphore, *read_cmds[ndx], &waits, read_iterations[ndx].timeline_value)?;
        }

        host_signal(device, *semaphore, host_timeline_value)?;
        unsafe { device.device_wait_idle() }.vk_check("vkDeviceWaitIdle")?;

        let expected = write_op.data(device)?;
        for read_op in &read_ops {
            let actual = read_op.data(device)?;
            if let Some(at) = first_difference(&expected, &actual) {
                return Ok(TestStatus::fail(format!(
                    "Memory contents don't match: first difference at byte {at} of {}, expected {:#04x} got {:#04x}",
                    expected.len(),
                    expected[at],
                    actual[at],
                )));
            }
        }
        Ok(TestStatus::pass("OK"))
    }

    /// `recordBarrier` - the acquiring half, which names both real stages.
    #[allow(clippy::too_many_arguments)]
    fn record_handoff_barrier(
        &self,
        device: &Device,
        cmd_buffer: vk::CommandBuffer,
        write_sync: SyncInfo,
        read_sync: SyncInfo,
        resource: &Resource<'_>,
        src_family: u32,
        dst_family: u32,
        original_layout: bool,
    ) {
        let sync = self.params.sync_type;
        if resource.kind == ResourceType::Image {
            let image = resource.image();
            let mut barrier = make_image_memory_barrier2(
                write_sync.stage_mask,
                write_sync.access_mask,
                read_sync.stage_mask,
                read_sync.access_mask,
                if original_layout { write_sync.image_layout } else { read_sync.image_layout },
                read_sync.image_layout,
                image.handle,
                image.subresource_range,
            );
            barrier.src_queue_family_index = src_family;
            barrier.dst_queue_family_index = dst_family;
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[barrier]);
        } else {
            let buffer = resource.buffer();
            let mut barrier = make_buffer_memory_barrier2(
                write_sync.stage_mask,
                write_sync.access_mask,
                read_sync.stage_mask,
                read_sync.access_mask,
                buffer.handle,
                0,
                vk::WHOLE_SIZE,
            );
            barrier.src_queue_family_index = src_family;
            barrier.dst_queue_family_index = dst_family;
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[barrier], &[]);
        }
    }

    /// `recordReleaseBarrier` - the releasing half. It names BOTTOM_OF_PIPE and no
    /// access on the destination side, since the acquiring queue supplies those, and it
    /// is skipped entirely when both sides are the same family.
    #[allow(clippy::too_many_arguments)]
    fn record_release_barrier(
        &self,
        device: &Device,
        cmd_buffer: vk::CommandBuffer,
        write_sync: SyncInfo,
        read_sync: SyncInfo,
        resource: &Resource<'_>,
        src_family: u32,
        dst_family: u32,
        original_layout: bool,
    ) {
        if src_family == dst_family {
            return;
        }
        let sync = self.params.sync_type;
        if resource.kind == ResourceType::Image {
            let image = resource.image();
            let mut barrier = make_image_memory_barrier2(
                write_sync.stage_mask,
                write_sync.access_mask,
                vk::PipelineStageFlags2::BOTTOM_OF_PIPE,
                vk::AccessFlags2::empty(),
                if original_layout { write_sync.image_layout } else { read_sync.image_layout },
                read_sync.image_layout,
                image.handle,
                image.subresource_range,
            );
            barrier.src_queue_family_index = src_family;
            barrier.dst_queue_family_index = dst_family;
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[barrier]);
        } else {
            let buffer = resource.buffer();
            let mut barrier = make_buffer_memory_barrier2(
                write_sync.stage_mask,
                write_sync.access_mask,
                vk::PipelineStageFlags2::BOTTOM_OF_PIPE,
                vk::AccessFlags2::empty(),
                buffer.handle,
                0,
                vk::WHOLE_SIZE,
            );
            barrier.src_queue_family_index = src_family;
            barrier.dst_queue_family_index = dst_family;
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[barrier], &[]);
        }
    }

    /// One command buffer, waiting on one or two timeline values and signalling one.
    fn submit(&self, device: &Device, queue: vk::Queue, semaphore: vk::Semaphore, cmd_buffer: vk::CommandBuffer, wait_values: &[u64], signal_value: u64) -> Result<(), TestError> {
        if self.params.sync_type == SyncType::Synchronization2 {
            use vulkanalia::vk::KhrSynchronization2ExtensionDeviceCommands;
            let cmd_infos = [vk::CommandBufferSubmitInfo {
                s_type: vk::StructureType::COMMAND_BUFFER_SUBMIT_INFO,
                next: std::ptr::null(),
                command_buffer: cmd_buffer,
                device_mask: 0,
            }];
            let waits: Vec<vk::SemaphoreSubmitInfo> = wait_values
                .iter()
                .map(|&v| semaphore_submit_info(semaphore, v, vk::PipelineStageFlags2::TOP_OF_PIPE))
                .collect();
            let signals = [semaphore_submit_info(semaphore, signal_value, vk::PipelineStageFlags2::BOTTOM_OF_PIPE)];
            let submit = vk::SubmitInfo2 {
                s_type: vk::StructureType::SUBMIT_INFO_2,
                next: std::ptr::null(),
                flags: vk::SubmitFlags::empty(),
                wait_semaphore_info_count: waits.len() as u32,
                wait_semaphore_infos: waits.as_ptr(),
                command_buffer_info_count: 1,
                command_buffer_infos: cmd_infos.as_ptr(),
                signal_semaphore_info_count: 1,
                signal_semaphore_infos: signals.as_ptr(),
            };
            return unsafe { device.queue_submit2_khr(queue, &[submit], vk::Fence::null()) }.vk_check("vkQueueSubmit2KHR");
        }

        let semaphores = vec![semaphore; wait_values.len()];
        let stages = vec![vk::PipelineStageFlags::TOP_OF_PIPE; wait_values.len()];
        let signal_semaphores = [semaphore];
        let signal_values = [signal_value];
        let cmd_buffers = [cmd_buffer];
        let timeline_info = vk::TimelineSemaphoreSubmitInfo {
            s_type: vk::StructureType::TIMELINE_SEMAPHORE_SUBMIT_INFO,
            next: std::ptr::null(),
            wait_semaphore_value_count: wait_values.len() as u32,
            wait_semaphore_values: wait_values.as_ptr(),
            signal_semaphore_value_count: 1,
            signal_semaphore_values: signal_values.as_ptr(),
        };
        let submit = vk::SubmitInfo {
            s_type: vk::StructureType::SUBMIT_INFO,
            next: std::ptr::from_ref(&timeline_info).cast(),
            wait_semaphore_count: semaphores.len() as u32,
            wait_semaphores: semaphores.as_ptr(),
            wait_dst_stage_mask: stages.as_ptr(),
            command_buffer_count: 1,
            command_buffers: cmd_buffers.as_ptr(),
            signal_semaphore_count: 1,
            signal_semaphores: signal_semaphores.as_ptr(),
        };
        unsafe { device.queue_submit(queue, &[submit], vk::Fence::null()) }.vk_check("vkQueueSubmit")
    }
}

fn semaphore_submit_info(semaphore: vk::Semaphore, value: u64, stage_mask: vk::PipelineStageFlags2) -> vk::SemaphoreSubmitInfo {
    vk::SemaphoreSubmitInfo {
        s_type: vk::StructureType::SEMAPHORE_SUBMIT_INFO,
        next: std::ptr::null(),
        semaphore,
        value,
        stage_mask,
        device_index: 0,
    }
}

fn create_timeline_semaphore(device: &Device) -> Result<Unique<'_, vk::Semaphore>, TestError> {
    let mut type_info = vk::SemaphoreTypeCreateInfo::builder().semaphore_type(vk::SemaphoreType::TIMELINE).initial_value(0);
    let info = vk::SemaphoreCreateInfo::builder().push_next(&mut type_info);
    let semaphore = unsafe { device.create_semaphore(&info, None) }.vk_check("vkCreateSemaphore")?;
    Ok(Unique::new(device, semaphore))
}

fn host_signal(device: &Device, semaphore: vk::Semaphore, value: u64) -> Result<(), TestError> {
    let info = vk::SemaphoreSignalInfo::builder().semaphore(semaphore).value(value);
    unsafe { device.signal_semaphore(&info) }.vk_check("vkSignalSemaphore")
}

fn in_usage(op: OperationName, resource: &ResourceDescription) -> u32 {
    if op.is_copy() { op.copy_resource_usage().0 } else { op.in_resource_usage(resource) }
}

fn out_usage(op: OperationName, resource: &ResourceDescription) -> u32 {
    if op.is_copy() { op.copy_resource_usage().1 } else { op.out_resource_usage(resource) }
}

/// `writeOps` for both groups - the same list, and the same one `signal_order` uses.
const TIMELINE_QUEUE_WRITE_OPS: &[OperationName] = &[
    OperationName::WriteCopyBuffer,
    OperationName::WriteCopyBufferToImage,
    OperationName::WriteCopyImageToBuffer,
    OperationName::WriteCopyImage,
    OperationName::WriteBlitImage,
    OperationName::WriteSsboVertex,
    OperationName::WriteSsboTessControl,
    OperationName::WriteSsboTessEval,
    OperationName::WriteSsboGeometry,
    OperationName::WriteSsboFragment,
    OperationName::WriteSsboCompute,
    OperationName::WriteSsboComputeIndirect,
    OperationName::WriteImageVertex,
    OperationName::WriteImageTessControl,
    OperationName::WriteImageTessEval,
    OperationName::WriteImageGeometry,
    OperationName::WriteImageFragment,
    OperationName::WriteImageCompute,
    OperationName::WriteImageComputeIndirect,
];

const TIMELINE_QUEUE_READ_OPS: &[OperationName] = &[
    OperationName::ReadCopyBuffer,
    OperationName::ReadCopyBufferToImage,
    OperationName::ReadCopyImageToBuffer,
    OperationName::ReadCopyImage,
    OperationName::ReadBlitImage,
    OperationName::ReadUboVertex,
    OperationName::ReadUboTessControl,
    OperationName::ReadUboTessEval,
    OperationName::ReadUboGeometry,
    OperationName::ReadUboFragment,
    OperationName::ReadUboCompute,
    OperationName::ReadUboComputeIndirect,
    OperationName::ReadSsboVertex,
    OperationName::ReadSsboTessControl,
    OperationName::ReadSsboTessEval,
    OperationName::ReadSsboGeometry,
    OperationName::ReadSsboFragment,
    OperationName::ReadSsboCompute,
    OperationName::ReadSsboComputeIndirect,
    OperationName::ReadImageVertex,
    OperationName::ReadImageTessControl,
    OperationName::ReadImageTessEval,
    OperationName::ReadImageGeometry,
    OperationName::ReadImageFragment,
    OperationName::ReadImageCompute,
    OperationName::ReadImageComputeIndirect,
    OperationName::ReadIndirectBufferDraw,
    OperationName::ReadIndirectBufferDrawIndexed,
    OperationName::ReadIndirectBufferDispatch,
    OperationName::ReadVertexInput,
];

/// `WaitBeforeSignalTests::init` / `OneToNTests::init`
pub fn create_timeline_queue_tests(kind: TimelineQueueKind, sync_type: SyncType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(kind.group_name());

    for &write_op in TIMELINE_QUEUE_WRITE_OPS {
        for &read_op in TIMELINE_QUEUE_READ_OPS {
            let mut op_group = TestCaseGroup::new(format!("{}_{}", write_op.as_str(), read_op.as_str()));
            let mut empty = true;

            for resource in RESOURCES {
                if !write_op.supports_resource(resource) || !read_op.supports_resource(resource) {
                    continue;
                }
                op_group.add_child(Box::new(TimelineQueueTestCase {
                    name: get_resource_name(resource),
                    kind,
                    sync_type,
                    resource: *resource,
                    write_op,
                    read_op,
                }) as Box<dyn TestCase>);
                empty = false;
            }

            if !empty {
                group.add_child(op_group);
            }
        }
    }

    group
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn graphics_stages_need_a_graphics_queue() {
        assert!(!is_stage_supported(vk::ShaderStageFlags::VERTEX, vk::QueueFlags::COMPUTE));
        assert!(is_stage_supported(vk::ShaderStageFlags::VERTEX, vk::QueueFlags::GRAPHICS));
        assert!(!is_stage_supported(vk::ShaderStageFlags::COMPUTE, vk::QueueFlags::GRAPHICS));
        assert!(is_stage_supported(vk::ShaderStageFlags::COMPUTE, vk::QueueFlags::COMPUTE));
    }

    #[test]
    fn every_write_op_names_a_shader_stage_or_none() {
        // A transfer operation runs in no shader stage, so the queue-compatibility
        // filter must not reject a queue on its account.
        assert_eq!(OperationName::WriteCopyBuffer.shader_stage(), None);
        assert_eq!(OperationName::WriteSsboCompute.shader_stage(), Some(vk::ShaderStageFlags::COMPUTE));
        assert_eq!(OperationName::WriteSsboVertex.shader_stage(), Some(vk::ShaderStageFlags::VERTEX));
        assert_eq!(OperationName::ReadImageGeometry.shader_stage(), Some(vk::ShaderStageFlags::GEOMETRY));
    }
}
