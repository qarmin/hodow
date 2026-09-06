// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationOperationSingleQueueTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// One write operation, one read operation, one synchronization primitive between them,
// all on the same queue. The primitive is what is under test: if it does not order the
// two, the read sees something other than what the write put there. Four primitives are
// ported - a barrier inside one command buffer, and a fence, a binary semaphore or an
// event between two.

use vulkanalia::prelude::v1_0::*;

use super::operation::{
    COPY_OPS, Operation, OperationName, READ_OPS, RESOURCES, Resource, ResourceDescription, ResourceType, SyncInfo, SyncType, WRITE_OPS, buffer_resource, build_copy_operation,
    build_operation, cmd_pipeline_barrier, first_difference, get_resource_name, image_resource, make_buffer_memory_barrier2, make_image_memory_barrier2,
};
use crate::tcu::{self, Random, TestError, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::obj_util::make_command_pool;
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

/// `SyncPrimitive`, restricted to the four that need no timeline semaphore.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum SyncPrimitive {
    Fence,
    BinarySemaphore,
    TimelineSemaphore,
    Barrier,
    Event,
}

impl SyncPrimitive {
    fn group_name(self) -> &'static str {
        match self {
            Self::Fence => "fence",
            Self::BinarySemaphore => "binary_semaphore",
            Self::TimelineSemaphore => "timeline_semaphore",
            Self::Barrier => "barrier",
            Self::Event => "event",
        }
    }
}

pub struct SyncTestCase {
    name: String,
    sync_type: SyncType,
    primitive: SyncPrimitive,
    resource: ResourceDescription,
    write_op: OperationName,
    read_op: OperationName,
    /// `specializedAccess` - the sync2 variant that names the narrow per-resource
    /// access flags rather than the broad SHADER_READ/SHADER_WRITE.
    specialized_access: bool,
    /// `maintenance9` - the sync2 event variant that asks for `VK_KHR_maintenance9`.
    maintenance9: bool,
    /// `computeQueue` - the `_cq` variant, which runs the whole thing on a dedicated
    /// compute queue instead of the universal one.
    compute_queue: bool,
}

impl TestCase for SyncTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if self.sync_type == SyncType::Synchronization2 {
            context.require_device_functionality("VK_KHR_synchronization2")?;
        }
        if self.primitive == SyncPrimitive::TimelineSemaphore {
            context.require_device_functionality("VK_KHR_timeline_semaphore")?;
            // Every copy operation the chain will step through has to be supported too,
            // which is why a timeline case skips wherever any stage in the chain does.
            for &copy_op in COPY_OPS {
                if copy_op.supports_resource(&self.resource) {
                    copy_op.copy_check_support(context, &self.resource)?;
                }
            }
        }
        if self.maintenance9 {
            context.require_device_functionality("VK_KHR_maintenance9")?;
        }
        if self.compute_queue && context.get_compute_queue().is_none() {
            return Err(TestError::NotSupported("no dedicated compute queue".into()));
        }

        if self.resource.kind == ResourceType::Image {
            let usage = self.write_op.out_resource_usage(&self.resource) | self.read_op.in_resource_usage(&self.resource);
            let properties = unsafe {
                context.get_instance().get_physical_device_image_format_properties(
                    context.get_physical_device(),
                    self.resource.image_format,
                    self.resource.image_type,
                    vk::ImageTiling::OPTIMAL,
                    vk::ImageUsageFlags::from_bits_truncate(usage),
                    vk::ImageCreateFlags::empty(),
                )
            };
            match properties {
                Err(_) => return Err(TestError::NotSupported("Image format is not supported".into())),
                Ok(p) if !p.sample_counts.contains(self.resource.image_samples) => {
                    return Err(TestError::NotSupported("Requested sample count is not supported".into()));
                }
                Ok(_) => {}
            }
        }

        self.write_op.check_support(context, &self.resource)?;
        self.read_op.check_support(context, &self.resource)?;

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SyncTestInstance { context, params: self })
    }
}

struct SyncTestInstance<'a> {
    context: &'a Context<'a>,
    params: &'a SyncTestCase,
}

impl TestInstance for SyncTestInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();

        let (queue, queue_index) = if p.compute_queue {
            self.context
                .get_compute_queue()
                .ok_or_else(|| TestError::NotSupported("no dedicated compute queue".into()))?
        } else {
            (self.context.get_universal_queue(), self.context.get_universal_queue_family_index())
        };

        // The timeline primitive does not use one resource and two operations; it
        // chains the payload through every copy operation the resource supports.
        if p.primitive == SyncPrimitive::TimelineSemaphore {
            return self.run_timeline_semaphore(device, allocator, queue, queue_index);
        }

        // `BaseTestInstance` - the resource is created with the union of what the write
        // op will produce and the read op will consume.
        let usage = p.write_op.out_resource_usage(&p.resource) | p.read_op.in_resource_usage(&p.resource);
        let resource = Resource::new(device, allocator, &p.resource, usage)?;
        let write_op = build_operation(device, allocator, p.write_op, &p.resource, &resource, p.specialized_access)?;
        let read_op = build_operation(device, allocator, p.read_op, &p.resource, &resource, p.specialized_access)?;

        let write_sync = write_op.out_sync_info(p.sync_type);
        let read_sync = read_op.in_sync_info(p.sync_type);

        let command_pool = make_command_pool(device, queue_index)?;
        match p.primitive {
            SyncPrimitive::Barrier => self.run_barrier(device, queue, *command_pool, &resource, &*write_op, &*read_op, write_sync, read_sync)?,
            SyncPrimitive::Fence => self.run_fence(device, queue, *command_pool, &resource, &*write_op, &*read_op, write_sync, read_sync)?,
            SyncPrimitive::BinarySemaphore => self.run_binary_semaphore(device, queue, *command_pool, &resource, &*write_op, &*read_op, write_sync, read_sync)?,
            SyncPrimitive::Event => self.run_event(device, queue, *command_pool, &resource, &*write_op, &*read_op, write_sync, read_sync)?,
            SyncPrimitive::TimelineSemaphore => unreachable!("handled above"),
        }

        let expected = write_op.data(device)?;
        let actual = read_op.data(device)?;

        // An indirect buffer holds a counter rather than a copy of the data, so only
        // the direction of the change is meaningful.
        if resource.kind.is_indirect_buffer() {
            let expected_value = u32::from_ne_bytes(expected[0..4].try_into().expect("at least 4 bytes"));
            let actual_value = u32::from_ne_bytes(actual[0..4].try_into().expect("at least 4 bytes"));
            if actual_value < expected_value {
                return Ok(TestStatus::fail("Counter value is smaller than expected"));
            }
        } else if let Some(at) = first_difference(&expected, &actual) {
            return Ok(TestStatus::fail(format!(
                "Memory contents don't match: first difference at byte {at} of {}, expected {:#04x} got {:#04x}",
                expected.len(),
                expected[at],
                actual[at],
            )));
        }

        Ok(TestStatus::pass("OK"))
    }
}

impl SyncTestInstance<'_> {
    /// `TimelineSemaphoreTestInstance` - the write operation, then every copy
    /// operation the resource supports, then the read operation, each in its own submit
    /// and each waiting on the timeline value its predecessor signals.
    ///
    /// The chain is what makes this different from the other primitives: the payload
    /// has to survive being handed from one operation to the next through a fresh
    /// resource each time, so a driver that lets any one link run early corrupts the
    /// value that comes out the far end.
    fn run_timeline_semaphore(&self, device: &'_ Device, allocator: &crate::vk::mem_util::SimpleAllocator, queue: vk::Queue, queue_index: u32) -> Result<TestStatus, TestError> {
        let p = self.params;

        // `m_opSupports` - the write operation, the supported copy operations, the read.
        let mut op_names = vec![p.write_op];
        op_names.extend(COPY_OPS.iter().copied().filter(|op| op.supports_resource(&p.resource)));
        op_names.push(p.read_op);

        // One resource between each neighbouring pair.
        let mut resources = Vec::with_capacity(op_names.len() - 1);
        for window in op_names.windows(2) {
            let usage = out_usage(window[0], &p.resource) | in_usage(window[1], &p.resource);
            resources.push(Resource::new(device, allocator, &p.resource, usage)?);
        }

        let mut ops: Vec<Box<dyn Operation + '_>> = Vec::with_capacity(op_names.len());
        ops.push(build_operation(device, allocator, op_names[0], &p.resource, &resources[0], p.specialized_access)?);
        for ndx in 1..op_names.len() - 1 {
            ops.push(build_copy_operation(
                device,
                allocator,
                op_names[ndx],
                &p.resource,
                &resources[ndx - 1],
                &resources[ndx],
                p.specialized_access,
            )?);
        }
        let last = op_names.len() - 1;
        ops.push(build_operation(
            device,
            allocator,
            op_names[last],
            &p.resource,
            &resources[resources.len() - 1],
            p.specialized_access,
        )?);

        let semaphore = create_timeline_semaphore(device)?;
        let command_pool = make_command_pool(device, queue_index)?;

        // The values are drawn one per operation from a single `de::Random(1234)`, and
        // the draw order decides which submit waits on what.
        let mut rng = Random::new(1234);
        let mut increment = 0u64;
        let mut values = Vec::with_capacity(ops.len());
        for _ in 0..ops.len() {
            increment += 1 + u64::from(rng.get_uint8());
            values.push(increment);
        }

        let mut command_buffers = Vec::with_capacity(ops.len());
        for _ in 0..ops.len() {
            command_buffers.push(allocate_command_buffer(device, *command_pool)?);
        }

        for (ndx, op) in ops.iter().enumerate() {
            let cmd = *command_buffers[ndx];
            begin_command_buffer(device, cmd)?;

            // Every operation but the first starts by taking over the resource its
            // predecessor left behind.
            if ndx > 0 {
                let last_sync = ops[ndx - 1].out_sync_info(p.sync_type);
                let current_sync = op.in_sync_info(p.sync_type);
                self.record_transition(device, cmd, &resources[ndx - 1], last_sync, current_sync);
            }

            op.record_commands(device, p.sync_type, cmd);
            end_command_buffer(device, cmd)?;
        }

        self.submit_timeline_chain(device, queue, *semaphore, &command_buffers, &values)?;
        unsafe { device.queue_wait_idle(queue) }.vk_check("vkQueueWaitIdle")?;

        let expected = ops[0].data(device)?;
        let actual = ops[ops.len() - 1].data(device)?;

        if p.resource.kind == ResourceType::IndirectBufferDraw
            || p.resource.kind == ResourceType::IndirectBufferDrawIndexed
            || p.resource.kind == ResourceType::IndirectBufferDispatch
        {
            let expected_value = u32::from_ne_bytes(expected[0..4].try_into().expect("at least 4 bytes"));
            let actual_value = u32::from_ne_bytes(actual[0..4].try_into().expect("at least 4 bytes"));
            if actual_value < expected_value {
                return Ok(TestStatus::fail("Counter value is smaller than expected"));
            }
        } else if let Some(at) = first_difference(&expected, &actual) {
            return Ok(TestStatus::fail(format!(
                "Memory contents don't match: first difference at byte {at} of {}, expected {:#04x} got {:#04x}",
                expected.len(),
                expected[at],
                actual[at],
            )));
        }

        Ok(TestStatus::pass("OK"))
    }

    /// One submit per operation, chained on the timeline: operation i waits on the
    /// value operation i-1 signals.
    fn submit_timeline_chain(
        &self,
        device: &Device,
        queue: vk::Queue,
        semaphore: vk::Semaphore,
        command_buffers: &[crate::vk::ref_util::UniqueCommandBuffer<'_>],
        values: &[u64],
    ) -> Result<(), TestError> {
        if self.params.sync_type == SyncType::Synchronization2 {
            use vulkanalia::vk::KhrSynchronization2ExtensionDeviceCommands;
            let mut cmd_infos = Vec::with_capacity(command_buffers.len());
            let mut waits = Vec::with_capacity(command_buffers.len());
            let mut signals = Vec::with_capacity(command_buffers.len());
            for (ndx, cmd) in command_buffers.iter().enumerate() {
                cmd_infos.push(vk::CommandBufferSubmitInfo {
                    s_type: vk::StructureType::COMMAND_BUFFER_SUBMIT_INFO,
                    next: std::ptr::null(),
                    command_buffer: **cmd,
                    device_mask: 0,
                });
                let wait_value = if ndx == 0 { 0 } else { values[ndx - 1] };
                waits.push(timeline_semaphore_submit_info(semaphore, wait_value, vk::PipelineStageFlags2::TOP_OF_PIPE));
                signals.push(timeline_semaphore_submit_info(semaphore, values[ndx], vk::PipelineStageFlags2::BOTTOM_OF_PIPE));
            }
            let submits: Vec<vk::SubmitInfo2> = (0..command_buffers.len())
                .map(|ndx| vk::SubmitInfo2 {
                    s_type: vk::StructureType::SUBMIT_INFO_2,
                    next: std::ptr::null(),
                    flags: vk::SubmitFlags::empty(),
                    wait_semaphore_info_count: u32::from(ndx != 0),
                    wait_semaphore_infos: waits[ndx..].as_ptr(),
                    command_buffer_info_count: 1,
                    command_buffer_infos: cmd_infos[ndx..].as_ptr(),
                    signal_semaphore_info_count: 1,
                    signal_semaphore_infos: signals[ndx..].as_ptr(),
                })
                .collect();
            unsafe { device.queue_submit2_khr(queue, &submits, vk::Fence::null()) }.vk_check("vkQueueSubmit2KHR")?;
        } else {
            let raw: Vec<vk::CommandBuffer> = command_buffers.iter().map(|c| **c).collect();
            let semaphores = vec![semaphore; command_buffers.len()];
            let stages = vec![vk::PipelineStageFlags::TOP_OF_PIPE; command_buffers.len()];
            let wait_values: Vec<u64> = (0..command_buffers.len()).map(|ndx| if ndx == 0 { 0 } else { values[ndx - 1] }).collect();

            let timeline_infos: Vec<vk::TimelineSemaphoreSubmitInfo> = (0..command_buffers.len())
                .map(|ndx| vk::TimelineSemaphoreSubmitInfo {
                    s_type: vk::StructureType::TIMELINE_SEMAPHORE_SUBMIT_INFO,
                    next: std::ptr::null(),
                    wait_semaphore_value_count: u32::from(ndx != 0),
                    wait_semaphore_values: wait_values[ndx..].as_ptr(),
                    signal_semaphore_value_count: 1,
                    signal_semaphore_values: values[ndx..].as_ptr(),
                })
                .collect();
            let submits: Vec<vk::SubmitInfo> = (0..command_buffers.len())
                .map(|ndx| vk::SubmitInfo {
                    s_type: vk::StructureType::SUBMIT_INFO,
                    next: std::ptr::from_ref(&timeline_infos[ndx]).cast(),
                    wait_semaphore_count: u32::from(ndx != 0),
                    wait_semaphores: semaphores[ndx..].as_ptr(),
                    wait_dst_stage_mask: stages[ndx..].as_ptr(),
                    command_buffer_count: 1,
                    command_buffers: raw[ndx..].as_ptr(),
                    signal_semaphore_count: 1,
                    signal_semaphores: semaphores[ndx..].as_ptr(),
                })
                .collect();
            unsafe { device.queue_submit(queue, &submits, vk::Fence::null()) }.vk_check("vkQueueSubmit")?;
        }
        Ok(())
    }

    /// The barrier the write and read are separated by, in whichever flavour the
    /// resource needs.
    #[allow(clippy::too_many_arguments)]
    fn record_transition(&self, device: &Device, cmd_buffer: vk::CommandBuffer, resource: &Resource<'_>, write_sync: SyncInfo, read_sync: SyncInfo) {
        let sync = self.params.sync_type;
        if resource.kind == ResourceType::Image {
            let image = resource.image();
            let barrier = make_image_memory_barrier2(
                write_sync.stage_mask,
                write_sync.access_mask,
                read_sync.stage_mask,
                read_sync.access_mask,
                write_sync.image_layout,
                read_sync.image_layout,
                image.handle,
                image.subresource_range,
            );
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[barrier]);
        } else {
            let buffer = resource.buffer();
            let barrier = make_buffer_memory_barrier2(
                write_sync.stage_mask,
                write_sync.access_mask,
                read_sync.stage_mask,
                read_sync.access_mask,
                buffer.handle,
                buffer.offset,
                buffer.size,
            );
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[barrier], &[]);
        }
    }

    /// `BarrierTestInstance` - both operations in one command buffer, ordered by a
    /// pipeline barrier.
    #[allow(clippy::too_many_arguments)]
    fn run_barrier(
        &self,
        device: &Device,
        queue: vk::Queue,
        command_pool: vk::CommandPool,
        resource: &Resource<'_>,
        write_op: &dyn Operation,
        read_op: &dyn Operation,
        write_sync: SyncInfo,
        read_sync: SyncInfo,
    ) -> Result<(), TestError> {
        let cmd = allocate_command_buffer(device, command_pool)?;
        begin_command_buffer(device, *cmd)?;
        write_op.record_commands(device, self.params.sync_type, *cmd);
        self.record_transition(device, *cmd, resource, write_sync, read_sync);
        read_op.record_commands(device, self.params.sync_type, *cmd);
        end_command_buffer(device, *cmd)?;
        self.submit_and_wait(device, queue, &[*cmd], &[], &[])
    }

    /// `FenceTestInstance` - two submits, the first waited on before the second is
    /// recorded. The write side still needs the image layout transition.
    #[allow(clippy::too_many_arguments)]
    fn run_fence(
        &self,
        device: &Device,
        queue: vk::Queue,
        command_pool: vk::CommandPool,
        resource: &Resource<'_>,
        write_op: &dyn Operation,
        read_op: &dyn Operation,
        write_sync: SyncInfo,
        read_sync: SyncInfo,
    ) -> Result<(), TestError> {
        let write_cmd = allocate_command_buffer(device, command_pool)?;
        begin_command_buffer(device, *write_cmd)?;
        write_op.record_commands(device, self.params.sync_type, *write_cmd);
        if resource.kind == ResourceType::Image {
            self.record_transition(device, *write_cmd, resource, write_sync, read_sync);
        }
        end_command_buffer(device, *write_cmd)?;
        self.submit_and_wait(device, queue, &[*write_cmd], &[], &[])?;

        let read_cmd = allocate_command_buffer(device, command_pool)?;
        begin_command_buffer(device, *read_cmd)?;
        read_op.record_commands(device, self.params.sync_type, *read_cmd);
        end_command_buffer(device, *read_cmd)?;
        self.submit_and_wait(device, queue, &[*read_cmd], &[], &[])
    }

    /// `BinarySemaphoreTestInstance` - two submits in one batch, the second waiting on
    /// a semaphore the first signals.
    #[allow(clippy::too_many_arguments)]
    fn run_binary_semaphore(
        &self,
        device: &Device,
        queue: vk::Queue,
        command_pool: vk::CommandPool,
        resource: &Resource<'_>,
        write_op: &dyn Operation,
        read_op: &dyn Operation,
        write_sync: SyncInfo,
        read_sync: SyncInfo,
    ) -> Result<(), TestError> {
        let semaphore = unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }.vk_check("vkCreateSemaphore")?;
        let semaphore = Unique::new(device, semaphore);

        let write_cmd = allocate_command_buffer(device, command_pool)?;
        begin_command_buffer(device, *write_cmd)?;
        write_op.record_commands(device, self.params.sync_type, *write_cmd);
        self.record_transition(device, *write_cmd, resource, write_sync, read_sync);
        end_command_buffer(device, *write_cmd)?;

        let read_cmd = allocate_command_buffer(device, command_pool)?;
        begin_command_buffer(device, *read_cmd)?;
        read_op.record_commands(device, self.params.sync_type, *read_cmd);
        end_command_buffer(device, *read_cmd)?;

        self.submit_and_wait(device, queue, &[*write_cmd], &[], &[*semaphore])?;
        self.submit_and_wait(device, queue, &[*read_cmd], &[*semaphore], &[])
    }

    /// `EventTestInstance` - both operations in one command buffer, ordered by an event
    /// the write sets and the read waits on.
    #[allow(clippy::too_many_arguments)]
    fn run_event(
        &self,
        device: &Device,
        queue: vk::Queue,
        command_pool: vk::CommandPool,
        resource: &Resource<'_>,
        write_op: &dyn Operation,
        read_op: &dyn Operation,
        write_sync: SyncInfo,
        read_sync: SyncInfo,
    ) -> Result<(), TestError> {
        // Under synchronization2 the event carries its own dependency, so it can be
        // device-only; the legacy one has to be host-visible because the wait names its
        // stage masks separately.
        let flags = if self.params.sync_type == SyncType::Synchronization2 {
            vk::EventCreateFlags::DEVICE_ONLY
        } else {
            vk::EventCreateFlags::empty()
        };
        let event = unsafe { device.create_event(&vk::EventCreateInfo::builder().flags(flags), None) }.vk_check("vkCreateEvent")?;
        let event = Unique::new(device, event);

        let cmd = allocate_command_buffer(device, command_pool)?;
        begin_command_buffer(device, *cmd)?;
        write_op.record_commands(device, self.params.sync_type, *cmd);
        self.record_event_transition(device, *cmd, *event, resource, write_sync, read_sync);
        read_op.record_commands(device, self.params.sync_type, *cmd);
        end_command_buffer(device, *cmd)?;
        self.submit_and_wait(device, queue, &[*cmd], &[], &[])
    }

    /// `cmdSetEvent` + `cmdWaitEvents`, with the same barrier the plain barrier path
    /// uses; the event is what turns it into a wait rather than an immediate ordering.
    fn record_event_transition(&self, device: &Device, cmd_buffer: vk::CommandBuffer, event: vk::Event, resource: &Resource<'_>, write_sync: SyncInfo, read_sync: SyncInfo) {
        let sync = self.params.sync_type;
        let image_barriers;
        let buffer_barriers;
        let (buffers, images): (&[vk::BufferMemoryBarrier2], &[vk::ImageMemoryBarrier2]) = if resource.kind == ResourceType::Image {
            let image = resource.image();
            image_barriers = [make_image_memory_barrier2(
                write_sync.stage_mask,
                write_sync.access_mask,
                read_sync.stage_mask,
                read_sync.access_mask,
                write_sync.image_layout,
                read_sync.image_layout,
                image.handle,
                image.subresource_range,
            )];
            (&[], &image_barriers)
        } else {
            let buffer = resource.buffer();
            buffer_barriers = [make_buffer_memory_barrier2(
                write_sync.stage_mask,
                write_sync.access_mask,
                read_sync.stage_mask,
                read_sync.access_mask,
                buffer.handle,
                buffer.offset,
                buffer.size,
            )];
            (&buffer_barriers, &[])
        };

        if sync == SyncType::Synchronization2 {
            use vulkanalia::vk::KhrSynchronization2ExtensionDeviceCommands;
            let info = vk::DependencyInfo {
                s_type: vk::StructureType::DEPENDENCY_INFO,
                next: std::ptr::null(),
                dependency_flags: vk::DependencyFlags::empty(),
                memory_barrier_count: 0,
                memory_barriers: std::ptr::null(),
                buffer_memory_barrier_count: buffers.len() as u32,
                buffer_memory_barriers: buffers.as_ptr(),
                image_memory_barrier_count: images.len() as u32,
                image_memory_barriers: images.as_ptr(),
            };
            unsafe {
                device.cmd_set_event2_khr(cmd_buffer, event, &info);
                device.cmd_wait_events2_khr(cmd_buffer, &[event], &[info]);
            }
            return;
        }

        // The legacy entry points take the stage masks separately, and a zero mask is
        // not allowed there, so an operation that reports no stage falls back to the
        // top and bottom of the pipe.
        let src_stage = legacy_stage(write_sync.stage_mask, vk::PipelineStageFlags::BOTTOM_OF_PIPE);
        let dst_stage = legacy_stage(read_sync.stage_mask, vk::PipelineStageFlags::TOP_OF_PIPE);
        let legacy_buffers: Vec<vk::BufferMemoryBarrier> = buffers.iter().map(to_legacy_buffer_barrier).collect();
        let legacy_images: Vec<vk::ImageMemoryBarrier> = images.iter().map(to_legacy_image_barrier).collect();

        unsafe {
            device.cmd_set_event(cmd_buffer, event, src_stage);
            device.cmd_wait_events(cmd_buffer, &[event], src_stage, dst_stage, &[] as &[vk::MemoryBarrier], &legacy_buffers, &legacy_images);
        }
    }

    /// `submitCommandsAndWait` - the sync2 path goes through `vkQueueSubmit2`, since
    /// the semaphore stage masks live on the submit info there.
    fn submit_and_wait(&self, device: &Device, queue: vk::Queue, cmd_buffers: &[vk::CommandBuffer], wait: &[vk::Semaphore], signal: &[vk::Semaphore]) -> Result<(), TestError> {
        let fence = unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?;
        let fence = Unique::new(device, fence);

        if self.params.sync_type == SyncType::Synchronization2 {
            use vulkanalia::vk::KhrSynchronization2ExtensionDeviceCommands;
            let cmd_infos: Vec<vk::CommandBufferSubmitInfo> = cmd_buffers
                .iter()
                .map(|cb| vk::CommandBufferSubmitInfo {
                    s_type: vk::StructureType::COMMAND_BUFFER_SUBMIT_INFO,
                    next: std::ptr::null(),
                    command_buffer: *cb,
                    device_mask: 0,
                })
                .collect();
            let wait_infos: Vec<vk::SemaphoreSubmitInfo> = wait.iter().map(|s| semaphore_submit_info(*s, vk::PipelineStageFlags2::TOP_OF_PIPE)).collect();
            let signal_infos: Vec<vk::SemaphoreSubmitInfo> = signal.iter().map(|s| semaphore_submit_info(*s, vk::PipelineStageFlags2::BOTTOM_OF_PIPE)).collect();

            let submit = vk::SubmitInfo2 {
                s_type: vk::StructureType::SUBMIT_INFO_2,
                next: std::ptr::null(),
                flags: vk::SubmitFlags::empty(),
                wait_semaphore_info_count: wait_infos.len() as u32,
                wait_semaphore_infos: wait_infos.as_ptr(),
                command_buffer_info_count: cmd_infos.len() as u32,
                command_buffer_infos: cmd_infos.as_ptr(),
                signal_semaphore_info_count: signal_infos.len() as u32,
                signal_semaphore_infos: signal_infos.as_ptr(),
            };
            unsafe { device.queue_submit2_khr(queue, &[submit], *fence) }.vk_check("vkQueueSubmit2KHR")?;
        } else {
            let wait_stages = vec![vk::PipelineStageFlags::TOP_OF_PIPE; wait.len()];
            let submit = vk::SubmitInfo::builder()
                .wait_semaphores(wait)
                .wait_dst_stage_mask(&wait_stages)
                .command_buffers(cmd_buffers)
                .signal_semaphores(signal);
            unsafe { device.queue_submit(queue, &[submit], *fence) }.vk_check("vkQueueSubmit")?;
        }

        unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
        Ok(())
    }
}

fn semaphore_submit_info(semaphore: vk::Semaphore, stage_mask: vk::PipelineStageFlags2) -> vk::SemaphoreSubmitInfo {
    vk::SemaphoreSubmitInfo {
        s_type: vk::StructureType::SEMAPHORE_SUBMIT_INFO,
        next: std::ptr::null(),
        semaphore,
        value: 0,
        stage_mask,
        device_index: 0,
    }
}

fn legacy_stage(mask: vk::PipelineStageFlags2, fallback: vk::PipelineStageFlags) -> vk::PipelineStageFlags {
    let truncated = vk::PipelineStageFlags::from_bits_truncate(mask.bits() as u32);
    if truncated.is_empty() { fallback } else { truncated }
}

fn to_legacy_buffer_barrier(b: &vk::BufferMemoryBarrier2) -> vk::BufferMemoryBarrier {
    vk::BufferMemoryBarrier {
        s_type: vk::StructureType::BUFFER_MEMORY_BARRIER,
        next: std::ptr::null(),
        src_access_mask: vk::AccessFlags::from_bits_truncate(b.src_access_mask.bits() as u32),
        dst_access_mask: vk::AccessFlags::from_bits_truncate(b.dst_access_mask.bits() as u32),
        src_queue_family_index: b.src_queue_family_index,
        dst_queue_family_index: b.dst_queue_family_index,
        buffer: b.buffer,
        offset: b.offset,
        size: b.size,
    }
}

fn to_legacy_image_barrier(b: &vk::ImageMemoryBarrier2) -> vk::ImageMemoryBarrier {
    vk::ImageMemoryBarrier {
        s_type: vk::StructureType::IMAGE_MEMORY_BARRIER,
        next: std::ptr::null(),
        src_access_mask: vk::AccessFlags::from_bits_truncate(b.src_access_mask.bits() as u32),
        dst_access_mask: vk::AccessFlags::from_bits_truncate(b.dst_access_mask.bits() as u32),
        old_layout: b.old_layout,
        new_layout: b.new_layout,
        src_queue_family_index: b.src_queue_family_index,
        dst_queue_family_index: b.dst_queue_family_index,
        image: b.image,
        subresource_range: b.subresource_range,
    }
}

/// `makeCommandBuffer`
fn allocate_command_buffer(device: &Device, pool: vk::CommandPool) -> Result<crate::vk::ref_util::UniqueCommandBuffer<'_>, TestError> {
    crate::vk::obj_util::allocate_command_buffer(device, pool, vk::CommandBufferLevel::PRIMARY)
}

/// `createSynchronizedOperationSingleQueueTests` -> `createTests`
pub fn create_single_queue_tests(sync_type: SyncType) -> tcu::TestCaseGroup {
    let mut group = tcu::TestCaseGroup::new("single_queue");

    for primitive in [
        SyncPrimitive::Fence,
        SyncPrimitive::BinarySemaphore,
        SyncPrimitive::TimelineSemaphore,
        SyncPrimitive::Barrier,
        SyncPrimitive::Event,
    ] {
        let mut primitive_group = tcu::TestCaseGroup::new(primitive.group_name());

        for &write_op in WRITE_OPS {
            for &read_op in READ_OPS {
                let mut op_group = tcu::TestCaseGroup::new(format!("{}_{}", write_op.as_str(), read_op.as_str()));
                let mut empty = true;

                for resource in RESOURCES {
                    if !write_op.supports_resource(resource) || !read_op.supports_resource(resource) {
                        continue;
                    }
                    let name = get_resource_name(resource);

                    // Under synchronization2, an operation that has a narrow access
                    // flag of its own gets a variant that names it instead of the
                    // broad SHADER_READ/SHADER_WRITE.
                    if sync_type == SyncType::Synchronization2 && (write_op.has_specialized_access_flag() || read_op.has_specialized_access_flag()) {
                        op_group.add_child(Box::new(SyncTestCase {
                            name: format!("{name}_specialized_access_flag"),
                            sync_type,
                            primitive,
                            resource: *resource,
                            write_op,
                            read_op,
                            specialized_access: true,
                            maintenance9: false,
                            compute_queue: false,
                        }) as Box<dyn TestCase>);
                    }

                    // Under synchronization2 an event also gets a maintenance9 variant.
                    if sync_type == SyncType::Synchronization2 && primitive == SyncPrimitive::Event {
                        op_group.add_child(Box::new(SyncTestCase {
                            name: format!("{name}_maintenance9"),
                            sync_type,
                            primitive,
                            resource: *resource,
                            write_op,
                            read_op,
                            specialized_access: false,
                            maintenance9: true,
                            compute_queue: false,
                        }) as Box<dyn TestCase>);
                    }

                    // And, for both, a compute-queue variant when everything involved
                    // can run there.
                    if primitive == SyncPrimitive::Event && write_op.can_run_on_compute() && read_op.can_run_on_compute() && resource_supports_compute_queue(resource) {
                        op_group.add_child(Box::new(SyncTestCase {
                            name: format!("{name}_cq"),
                            sync_type,
                            primitive,
                            resource: *resource,
                            write_op,
                            read_op,
                            specialized_access: false,
                            maintenance9: false,
                            compute_queue: true,
                        }) as Box<dyn TestCase>);
                    }

                    op_group.add_child(Box::new(SyncTestCase {
                        name,
                        sync_type,
                        primitive,
                        resource: *resource,
                        write_op,
                        read_op,
                        specialized_access: false,
                        maintenance9: false,
                        compute_queue: false,
                    }) as Box<dyn TestCase>);
                    empty = false;
                }

                if !empty {
                    primitive_group.add_child(op_group);
                }
            }
        }

        group.add_child(primitive_group);
    }

    group
}

/// `SyncEventsTestCase`
///
/// Two events, each carrying one write/read pair, set one after the other and then
/// waited on together. One of the two may be a "nop" event: no work and an empty
/// dependency, which checks that waiting on an event that carries nothing still
/// behaves.
struct SyncEventsTestCase {
    name: String,
    /// `None` when this event does no work at all.
    events: [Option<EventPair>; 2],
}

#[derive(Clone, Copy)]
struct EventPair {
    resource: ResourceDescription,
    write_op: OperationName,
    read_op: OperationName,
}

impl TestCase for SyncEventsTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_synchronization2")?;

        // Upstream checks only the image format here, never the operations' own
        // `checkSupport`, so a case whose operation needs a feature the device lacks
        // is attempted rather than skipped. Kept, because the verdicts have to match.
        for pair in self.events.iter().flatten() {
            if pair.resource.kind != ResourceType::Image {
                continue;
            }
            let usage = pair.write_op.out_resource_usage(&pair.resource) | pair.read_op.in_resource_usage(&pair.resource);
            let properties = unsafe {
                context.get_instance().get_physical_device_image_format_properties(
                    context.get_physical_device(),
                    pair.resource.image_format,
                    pair.resource.image_type,
                    vk::ImageTiling::OPTIMAL,
                    vk::ImageUsageFlags::from_bits_truncate(usage),
                    vk::ImageCreateFlags::empty(),
                )
            };
            match properties {
                Err(_) => return Err(TestError::NotSupported("Image format is not supported".into())),
                Ok(p) if !p.sample_counts.contains(pair.resource.image_samples) => {
                    return Err(TestError::NotSupported("Requested sample count is not supported".into()));
                }
                Ok(_) => {}
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SyncEventsTestInstance { context, params: self })
    }
}

struct SyncEventsTestInstance<'a> {
    context: &'a Context<'a>,
    params: &'a SyncEventsTestCase,
}

impl TestInstance for SyncEventsTestInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        const SYNC: SyncType = SyncType::Synchronization2;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_index = self.context.get_universal_queue_family_index();

        // Only the events that do work own a resource and a pair of operations; the
        // nop event contributes nothing to these, which is why they are indexed
        // separately from the events themselves.
        let mut resources = Vec::new();
        let mut write_ops: Vec<Box<dyn Operation + '_>> = Vec::new();
        let mut read_ops: Vec<Box<dyn Operation + '_>> = Vec::new();
        for pair in self.params.events.iter().flatten() {
            let usage = pair.write_op.out_resource_usage(&pair.resource) | pair.read_op.in_resource_usage(&pair.resource);
            resources.push(Resource::new(device, allocator, &pair.resource, usage)?);
        }
        for (ndx, pair) in self.params.events.iter().flatten().enumerate() {
            write_ops.push(build_operation(device, allocator, pair.write_op, &pair.resource, &resources[ndx], false)?);
            read_ops.push(build_operation(device, allocator, pair.read_op, &pair.resource, &resources[ndx], false)?);
        }

        let command_pool = make_command_pool(device, queue_index)?;
        let cmd = allocate_command_buffer(device, *command_pool)?;
        let events: Vec<_> = (0..2)
            .map(|_| {
                let event = unsafe { device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?;
                Ok::<_, TestError>(Unique::new(device, event))
            })
            .collect::<Result<_, _>>()?;

        begin_command_buffer(device, *cmd)?;

        // The barrier arrays have to outlive `vkCmdWaitEvents2`, which reads them again
        // long after each `vkCmdSetEvent2` has copied nothing.
        let mut buffer_barriers = Vec::new();
        let mut image_barriers = Vec::new();
        for (ops_idx, pair) in self.params.events.iter().flatten().enumerate() {
            let write_sync = write_ops[ops_idx].out_sync_info(SYNC);
            let read_sync = read_ops[ops_idx].in_sync_info(SYNC);
            let resource = &resources[ops_idx];
            if pair.resource.kind == ResourceType::Image {
                let image = resource.image();
                image_barriers.push((
                    ops_idx,
                    make_image_memory_barrier2(
                        write_sync.stage_mask,
                        write_sync.access_mask,
                        read_sync.stage_mask,
                        read_sync.access_mask,
                        write_sync.image_layout,
                        read_sync.image_layout,
                        image.handle,
                        image.subresource_range,
                    ),
                ));
            } else {
                let buffer = resource.buffer();
                buffer_barriers.push((
                    ops_idx,
                    make_buffer_memory_barrier2(
                        write_sync.stage_mask,
                        write_sync.access_mask,
                        read_sync.stage_mask,
                        read_sync.access_mask,
                        buffer.handle,
                        buffer.offset,
                        buffer.size,
                    ),
                ));
            }
        }

        let mut dependency_infos = Vec::with_capacity(2);
        // Not an index into `events`: a nop event consumes no operation, so this
        // advances only for the events that do work.
        let mut ops_idx = 0;
        for pair in &self.params.events {
            let Some(pair) = pair else {
                dependency_infos.push(event_dependency_info(&[], &[]));
                continue;
            };
            write_ops[ops_idx].record_commands(device, SYNC, *cmd);
            let info = if pair.resource.kind == ResourceType::Image {
                let barrier = &image_barriers.iter().find(|(i, _)| *i == ops_idx).expect("recorded above").1;
                event_dependency_info(&[], std::slice::from_ref(barrier))
            } else {
                let barrier = &buffer_barriers.iter().find(|(i, _)| *i == ops_idx).expect("recorded above").1;
                event_dependency_info(std::slice::from_ref(barrier), &[])
            };
            dependency_infos.push(info);
            ops_idx += 1;
        }

        let event_handles: Vec<vk::Event> = events.iter().map(|e| **e).collect();
        unsafe {
            use vulkanalia::vk::KhrSynchronization2ExtensionDeviceCommands;
            for (event_idx, handle) in event_handles.iter().enumerate() {
                device.cmd_set_event2_khr(*cmd, *handle, &dependency_infos[event_idx]);
            }
            device.cmd_wait_events2_khr(*cmd, &event_handles, &dependency_infos);
        }

        for read_op in &read_ops {
            read_op.record_commands(device, SYNC, *cmd);
        }
        end_command_buffer(device, *cmd)?;

        // Keeps the barriers alive until the command buffer is fully recorded.
        drop(buffer_barriers);
        drop(image_barriers);

        self.submit_and_wait(device, queue, *cmd)?;

        for ndx in 0..write_ops.len() {
            let expected = write_ops[ndx].data(device)?;
            let actual = read_ops[ndx].data(device)?;

            if resources[ndx].kind.is_indirect_buffer() {
                let expected_value = u32::from_ne_bytes(expected[0..4].try_into().expect("at least 4 bytes"));
                let actual_value = u32::from_ne_bytes(actual[0..4].try_into().expect("at least 4 bytes"));
                if actual_value < expected_value {
                    return Ok(TestStatus::fail("Counter value is smaller than expected"));
                }
            } else if let Some(at) = first_difference(&expected, &actual) {
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
}

impl SyncEventsTestInstance<'_> {
    fn submit_and_wait(&self, device: &Device, queue: vk::Queue, cmd_buffer: vk::CommandBuffer) -> Result<(), TestError> {
        use vulkanalia::vk::KhrSynchronization2ExtensionDeviceCommands;
        let fence = unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?;
        let fence = Unique::new(device, fence);
        let cmd_infos = [vk::CommandBufferSubmitInfo {
            s_type: vk::StructureType::COMMAND_BUFFER_SUBMIT_INFO,
            next: std::ptr::null(),
            command_buffer: cmd_buffer,
            device_mask: 0,
        }];
        let submit = vk::SubmitInfo2 {
            s_type: vk::StructureType::SUBMIT_INFO_2,
            next: std::ptr::null(),
            flags: vk::SubmitFlags::empty(),
            wait_semaphore_info_count: 0,
            wait_semaphore_infos: std::ptr::null(),
            command_buffer_info_count: 1,
            command_buffer_infos: cmd_infos.as_ptr(),
            signal_semaphore_info_count: 0,
            signal_semaphore_infos: std::ptr::null(),
        };
        unsafe { device.queue_submit2_khr(queue, &[submit], *fence) }.vk_check("vkQueueSubmit2KHR")?;
        unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
        Ok(())
    }
}

/// `makeCommonDependencyInfo(..., eventDependency = true)` - no BY_REGION, since an
/// event dependency is not framebuffer-local.
fn event_dependency_info(buffer_barriers: &[vk::BufferMemoryBarrier2], image_barriers: &[vk::ImageMemoryBarrier2]) -> vk::DependencyInfo {
    vk::DependencyInfo {
        s_type: vk::StructureType::DEPENDENCY_INFO,
        next: std::ptr::null(),
        dependency_flags: vk::DependencyFlags::empty(),
        memory_barrier_count: 0,
        memory_barriers: std::ptr::null(),
        buffer_memory_barrier_count: buffer_barriers.len() as u32,
        buffer_memory_barriers: buffer_barriers.as_ptr(),
        image_memory_barrier_count: image_barriers.len() as u32,
        image_memory_barriers: image_barriers.as_ptr(),
    }
}

/// `createMultipleEventsTests` - a subset of the operations and resources, since every
/// valid pair is then crossed with every other.
const EVENT_WRITE_OPS: &[OperationName] = &[
    OperationName::WriteFillBuffer,
    OperationName::WriteCopyBufferToImage,
    OperationName::WriteBlitImage,
    OperationName::WriteSsboVertex,
];

const EVENT_READ_OPS: &[OperationName] = &[
    OperationName::ReadCopyBufferToImage,
    OperationName::ReadBlitImage,
    OperationName::ReadUboFragment,
    OperationName::ReadSsboVertex,
];

const EVENT_RESOURCES: &[ResourceDescription] = &[
    buffer_resource(0x4000),
    buffer_resource(0x40000),
    image_resource(
        [128, 128, 0],
        vk::ImageType::_2D,
        vk::Format::R8G8B8A8_UNORM,
        vk::ImageAspectFlags::COLOR,
        vk::SampleCountFlags::_1,
    ),
    image_resource(
        [128, 128, 0],
        vk::ImageType::_2D,
        vk::Format::R32G32B32A32_SFLOAT,
        vk::ImageAspectFlags::COLOR,
        vk::SampleCountFlags::_1,
    ),
    image_resource(
        [64, 64, 8],
        vk::ImageType::_3D,
        vk::Format::R32_SFLOAT,
        vk::ImageAspectFlags::COLOR,
        vk::SampleCountFlags::_1,
    ),
];

fn create_multiple_events_tests() -> tcu::TestCaseGroup {
    let mut group = tcu::TestCaseGroup::new("multi_events");

    let mut op_sets = Vec::new();
    for &write_op in EVENT_WRITE_OPS {
        for &read_op in EVENT_READ_OPS {
            for resource in EVENT_RESOURCES {
                if write_op.supports_resource(resource) && read_op.supports_resource(resource) {
                    op_sets.push(EventPair {
                        resource: *resource,
                        write_op,
                        read_op,
                    });
                }
            }
        }
    }

    let pair_name = |p: &EventPair| format!("{}_{}", p.write_op.as_str(), p.read_op.as_str());

    for first in &op_sets {
        for second in &op_sets {
            group.add_child(Box::new(SyncEventsTestCase {
                name: format!(
                    "{}__{}_res_{}_{}",
                    pair_name(first),
                    pair_name(second),
                    get_resource_name(&first.resource),
                    get_resource_name(&second.resource)
                ),
                events: [Some(*first), Some(*second)],
            }) as Box<dyn TestCase>);
        }
    }

    // One of the two events does no work and carries no dependency.
    for pair in &op_sets {
        for is_first_event_nop in [true, false] {
            let (first_name, second_name) = if is_first_event_nop {
                ("nop".to_owned(), pair_name(pair))
            } else {
                (pair_name(pair), "nop".to_owned())
            };
            let (first_res, second_res) = if is_first_event_nop {
                ("none".to_owned(), get_resource_name(&pair.resource))
            } else {
                (get_resource_name(&pair.resource), "none".to_owned())
            };
            let events = if is_first_event_nop { [None, Some(*pair)] } else { [Some(*pair), None] };
            group.add_child(Box::new(SyncEventsTestCase {
                name: format!("{first_name}__{second_name}_res_{first_res}_{second_res}"),
                events,
            }) as Box<dyn TestCase>);
        }
    }

    group
}

/// `resourceSupportsComputeQueue` - a depth or stencil image cannot be copied on a
/// queue without graphics, so its cases have no compute-queue variant.
fn resource_supports_compute_queue(resource: &ResourceDescription) -> bool {
    !(resource.kind == ResourceType::Image && resource.image_aspect.intersects(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL))
}

/// `createSynchronizationTests`, restricted to the two `op.single_queue` trees.
pub fn create_tests() -> Vec<tcu::TestCaseGroup> {
    [("synchronization", SyncType::Legacy), ("synchronization2", SyncType::Synchronization2)]
        .into_iter()
        .map(|(name, sync_type)| {
            let mut group = tcu::TestCaseGroup::new(name);
            let mut op = tcu::TestCaseGroup::new("op");
            op.add_child({
                let mut single = create_single_queue_tests(sync_type);
                if sync_type == SyncType::Synchronization2 {
                    single.add_child(create_multiple_events_tests());
                }
                single
            });
            op.add_child(super::multi_queue_tests::create_multi_queue_tests(sync_type));
            group.add_child(op);
            group.add_child(super::timeline_semaphore_tests::create_timeline_semaphore_tests(sync_type));
            group.add_child(super::basic_tests::create_basic_tests(sync_type));
            group.add_child(super::signal_order_tests::create_signal_order_tests(sync_type));
            group
        })
        .collect()
}

/// `getInResourceUsageFlags` for whichever kind of operation this is.
fn in_usage(op: OperationName, resource: &ResourceDescription) -> u32 {
    if op.is_copy() { op.copy_resource_usage().0 } else { op.in_resource_usage(resource) }
}

/// `getOutResourceUsageFlags` for whichever kind of operation this is.
fn out_usage(op: OperationName, resource: &ResourceDescription) -> u32 {
    if op.is_copy() { op.copy_resource_usage().1 } else { op.out_resource_usage(resource) }
}

fn timeline_semaphore_submit_info(semaphore: vk::Semaphore, value: u64, stage_mask: vk::PipelineStageFlags2) -> vk::SemaphoreSubmitInfo {
    vk::SemaphoreSubmitInfo {
        s_type: vk::StructureType::SEMAPHORE_SUBMIT_INFO,
        next: std::ptr::null(),
        semaphore,
        value,
        stage_mask,
        device_index: 0,
    }
}

/// `createSemaphoreType(VK_SEMAPHORE_TYPE_TIMELINE)`
fn create_timeline_semaphore(device: &Device) -> Result<Unique<'_, vk::Semaphore>, TestError> {
    let mut type_info = vk::SemaphoreTypeCreateInfo::builder().semaphore_type(vk::SemaphoreType::TIMELINE).initial_value(0);
    let info = vk::SemaphoreCreateInfo::builder().push_next(&mut type_info);
    let semaphore = unsafe { device.create_semaphore(&info, None) }.vk_check("vkCreateSemaphore")?;
    Ok(Unique::new(device, semaphore))
}
