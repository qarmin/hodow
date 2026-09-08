// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationSignalOrderTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// What is under test is the *order* in which semaphore signal operations become
// visible, not the data path. Twelve write operations are submitted to one queue, each
// in its own submit info and each signalling its own semaphore; a single submit to a
// second queue then runs all twelve reads, waiting only on the *last* write's
// semaphore. The spec guarantees that submissions to one queue signal in order, so
// waiting on the last one has to imply all eleven before it have completed. A driver
// that signals out of order hands the reads a resource that was never written.
//
// Ported so far: the `binary_semaphore` and `timeline_semaphore` groups. The two
// `shared_*` groups export the semaphore to a second device and need external-semaphore
// support that is not ported.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_2;

use super::operation::{
    Operation, OperationName, RESOURCES, Resource, ResourceDescription, ResourceType, SyncType, build_operation, cmd_pipeline_barrier, first_difference, get_resource_name,
    make_buffer_memory_barrier2, make_image_memory_barrier2,
};
use crate::tcu::{Random, TestError, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::context::QueueFamilyQueues;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `iterations.resize(12)` - a dozen write/read pairs, so an out-of-order signal has
/// somewhere to hide.
const ITERATION_COUNT: usize = 12;

/// `VkSemaphoreType`, restricted to the two this group registers.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum SemaphoreType {
    Binary,
    Timeline,
}

impl SemaphoreType {
    fn group_name(self) -> &'static str {
        match self {
            Self::Binary => "binary_semaphore",
            Self::Timeline => "timeline_semaphore",
        }
    }
}

/// `QueueSubmitSignalOrderTestCase`
pub struct SignalOrderTestCase {
    name: String,
    sync_type: SyncType,
    semaphore_type: SemaphoreType,
    resource: ResourceDescription,
    write_op: OperationName,
    read_op: OperationName,
}

impl TestCase for SignalOrderTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if self.semaphore_type == SemaphoreType::Timeline {
            context.require_device_functionality("VK_KHR_timeline_semaphore")?;
        }
        if self.sync_type == SyncType::Synchronization2 {
            context.require_device_functionality("VK_KHR_synchronization2")?;
        }
        self.write_op.check_support(context, &self.resource)?;
        self.read_op.check_support(context, &self.resource)?;
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SignalOrderTestInstance { context, params: self })
    }
}

struct SignalOrderTestInstance<'a> {
    context: &'a Context<'a>,
    params: &'a SignalOrderTestCase,
}

/// The queue the writes go to and the queue the reads go to, which must be two distinct
/// queue objects.
struct QueuePairs {
    queue_a: vk::Queue,
    family_a: u32,
    queue_b: vk::Queue,
    family_b: u32,
}

/// `isQueueValid` - a queue that supports graphics or compute satisfies a transfer
/// requirement whether or not it advertises the bit.
fn is_queue_valid(available: vk::QueueFlags, required: vk::QueueFlags) -> bool {
    available.contains(required) || (required == vk::QueueFlags::TRANSFER && available.intersects(vk::QueueFlags::GRAPHICS | vk::QueueFlags::COMPUTE))
}

/// The constructor's queue search. Upstream does it in the instance constructor and
/// notes that moving it to `checkSupport` is not feasible, so the skip happens here.
fn find_queues(families: &[QueueFamilyQueues], write_flags: vk::QueueFlags, read_flags: vk::QueueFlags) -> Result<QueuePairs, TestError> {
    let (queue_a, family_a) = families
        .iter()
        .find(|f| is_queue_valid(f.flags, write_flags))
        .map(|f| (f.queues[0], f.family_index))
        .ok_or_else(|| TestError::NotSupported("No queue supporting write operation".into()))?;

    let (queue_b, family_b) = families
        .iter()
        .filter(|f| is_queue_valid(f.flags, read_flags))
        .find_map(|f| f.queues.iter().find(|&&q| q != queue_a).map(|&q| (q, f.family_index)))
        .ok_or_else(|| TestError::NotSupported("No queue supporting read operation".into()))?;

    Ok(QueuePairs {
        queue_a,
        family_a,
        queue_b,
        family_b,
    })
}

impl TestInstance for SignalOrderTestInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        let p = self.params;
        let queues = self.context.multi_queue_device()?;
        let device = queues.device();
        let allocator = queues.allocator();
        let is_timeline = p.semaphore_type == SemaphoreType::Timeline;

        let q = find_queues(queues.families(), p.write_op.queue_flags(&p.resource), p.read_op.queue_flags(&p.resource))?;
        let queue_families = [q.family_a, q.family_b];

        let mut resources = Vec::with_capacity(ITERATION_COUNT);
        for _ in 0..ITERATION_COUNT {
            let usage = p.write_op.out_resource_usage(&p.resource) | p.read_op.in_resource_usage(&p.resource);
            resources.push(Resource::new_shared(device, allocator, &p.resource, usage, vk::SharingMode::EXCLUSIVE, &queue_families)?);
        }

        let mut write_ops: Vec<Box<dyn Operation + '_>> = Vec::with_capacity(ITERATION_COUNT);
        let mut read_ops: Vec<Box<dyn Operation + '_>> = Vec::with_capacity(ITERATION_COUNT);
        for resource in &resources {
            write_ops.push(build_operation(device, allocator, p.write_op, &p.resource, resource, false)?);
            read_ops.push(build_operation(device, allocator, p.read_op, &p.resource, resource, false)?);
        }

        let pool_a = make_command_pool(device, q.family_a)?;
        let pool_b = make_command_pool(device, q.family_b)?;

        // One command buffer per write, so each gets its own submit info and so its own
        // signal operation - which is the thing whose ordering is under test.
        let mut cmd_buffers_a = Vec::with_capacity(ITERATION_COUNT);
        for ndx in 0..ITERATION_COUNT {
            let cmd = allocate_command_buffer(device, *pool_a, vk::CommandBufferLevel::PRIMARY)?;
            begin_command_buffer(device, *cmd)?;
            write_ops[ndx].record_commands(device, p.sync_type, *cmd);

            let write_sync = write_ops[ndx].out_sync_info(p.sync_type);
            let read_sync = read_ops[ndx].in_sync_info(p.sync_type);
            if p.resource.kind == ResourceType::Image {
                let image = resources[ndx].image();
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
                cmd_pipeline_barrier(device, p.sync_type, *cmd, &[], &[barrier]);
            } else {
                let buffer = resources[ndx].buffer();
                let barrier = make_buffer_memory_barrier2(
                    write_sync.stage_mask,
                    write_sync.access_mask,
                    read_sync.stage_mask,
                    read_sync.access_mask,
                    buffer.handle,
                    0,
                    vk::WHOLE_SIZE,
                );
                cmd_pipeline_barrier(device, p.sync_type, *cmd, &[barrier], &[]);
            }

            end_command_buffer(device, *cmd)?;
            cmd_buffers_a.push(cmd);
        }

        // All the reads go in one command buffer on the other queue.
        let cmd_b = allocate_command_buffer(device, *pool_b, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd_b)?;
        for read_op in &read_ops {
            read_op.record_commands(device, p.sync_type, *cmd_b);
        }
        end_command_buffer(device, *cmd_b)?;

        // `addSemaphore`. A binary semaphore per write; for the timeline case a single
        // semaphore whose value each write advances, which is what makes the twelve
        // signals genuinely ordered rather than independent.
        let mut rng = Random::new(1234);
        let mut owned_a: Vec<Unique<'_, vk::Semaphore>> = Vec::new();
        let mut handles_a = Vec::with_capacity(ITERATION_COUNT);
        let mut values_a: Vec<u64> = Vec::with_capacity(ITERATION_COUNT);
        for _ in 0..ITERATION_COUNT {
            if !is_timeline || owned_a.is_empty() {
                owned_a.push(create_semaphore(device, p.semaphore_type)?);
            }
            handles_a.push(*owned_a[owned_a.len() - 1]);
            let previous = values_a.last().copied().unwrap_or(2);
            values_a.push(previous + rng.get_int(1, 100) as u64);
        }

        let semaphore_b = create_semaphore(device, p.semaphore_type)?;
        let value_b = values_a[values_a.len() - 1] + rng.get_int(1, 100) as u64;

        let fence = unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?;
        let fence = Unique::new(device, fence);

        self.submit_writes(device, q.queue_a, &cmd_buffers_a, &handles_a, &values_a)?;
        self.submit_reads(
            device,
            q.queue_b,
            *cmd_b,
            handles_a[ITERATION_COUNT - 1],
            values_a[ITERATION_COUNT - 1],
            *semaphore_b,
            value_b,
            *fence,
        )?;

        if is_timeline {
            // Every write submit waits on value 1 of the shared semaphore, so nothing
            // has started yet; this releases all twelve at once, which is the point.
            host_signal(device, handles_a[0], 1)?;
            let semaphores = [*semaphore_b];
            let values = [value_b];
            let info = vk::SemaphoreWaitInfo::builder().semaphores(&semaphores).values(&values);
            unsafe { device.wait_semaphores(&info, u64::MAX) }.vk_check("vkWaitSemaphores")?;
        } else {
            unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
        }

        // `DeviceWaitIdleGuard` - everything above has to be done with before the
        // resources it points at are dropped.
        unsafe { device.device_wait_idle() }.vk_check("vkDeviceWaitIdle")?;

        for ndx in 0..ITERATION_COUNT {
            let expected = write_ops[ndx].data(device)?;
            let actual = read_ops[ndx].data(device)?;

            if p.resource.kind.is_indirect_buffer() {
                let expected_value = u32::from_ne_bytes(expected[0..4].try_into().expect("at least 4 bytes"));
                let actual_value = u32::from_ne_bytes(actual[0..4].try_into().expect("at least 4 bytes"));
                if actual_value < expected_value {
                    return Ok(TestStatus::fail("Counter value is smaller than expected"));
                }
            } else if let Some(at) = first_difference(&expected, &actual) {
                return Ok(TestStatus::fail(format!(
                    "Memory contents don't match: iteration {ndx}, first difference at byte {at} of {}, expected {:#04x} got {:#04x}",
                    expected.len(),
                    expected[at],
                    actual[at],
                )));
            }
        }

        Ok(TestStatus::pass("Success"))
    }
}

impl SignalOrderTestInstance<'_> {
    /// One submit info per write, all in a single `vkQueueSubmit`. With binary
    /// semaphores nothing is waited on; with a timeline every one of them waits on
    /// value 1 of the shared semaphore, so they all start together when the host
    /// signals it.
    fn submit_writes(
        &self,
        device: &Device,
        queue: vk::Queue,
        cmd_buffers: &[crate::vk::ref_util::UniqueCommandBuffer<'_>],
        semaphores: &[vk::Semaphore],
        values: &[u64],
    ) -> Result<(), TestError> {
        let is_timeline = self.params.semaphore_type == SemaphoreType::Timeline;
        let raw: Vec<vk::CommandBuffer> = cmd_buffers.iter().map(|c| **c).collect();

        if self.params.sync_type == SyncType::Synchronization2 {
            use vulkanalia::vk::KhrSynchronization2ExtensionDeviceCommands;
            let cmd_infos: Vec<vk::CommandBufferSubmitInfo> = raw.iter().map(|cb| command_buffer_submit_info(*cb)).collect();
            let waits = vec![semaphore_submit_info(semaphores[0], 1, vk::PipelineStageFlags2::TOP_OF_PIPE); ITERATION_COUNT];
            let signals: Vec<vk::SemaphoreSubmitInfo> = (0..ITERATION_COUNT)
                .map(|ndx| semaphore_submit_info(semaphores[ndx], values[ndx], vk::PipelineStageFlags2::BOTTOM_OF_PIPE))
                .collect();
            let submits: Vec<vk::SubmitInfo2> = (0..ITERATION_COUNT)
                .map(|ndx| vk::SubmitInfo2 {
                    s_type: vk::StructureType::SUBMIT_INFO_2,
                    next: std::ptr::null(),
                    flags: vk::SubmitFlags::empty(),
                    wait_semaphore_info_count: u32::from(is_timeline),
                    wait_semaphore_infos: waits[ndx..].as_ptr(),
                    command_buffer_info_count: 1,
                    command_buffer_infos: cmd_infos[ndx..].as_ptr(),
                    signal_semaphore_info_count: 1,
                    signal_semaphore_infos: signals[ndx..].as_ptr(),
                })
                .collect();
            unsafe { device.queue_submit2_khr(queue, &submits, vk::Fence::null()) }.vk_check("vkQueueSubmit2KHR")?;
            return Ok(());
        }

        let first_semaphore = [semaphores[0]; ITERATION_COUNT];
        let stages = [vk::PipelineStageFlags::TOP_OF_PIPE; ITERATION_COUNT];
        let wait_values = [1u64; ITERATION_COUNT];
        let timeline_infos: Vec<vk::TimelineSemaphoreSubmitInfo> = (0..ITERATION_COUNT)
            .map(|ndx| vk::TimelineSemaphoreSubmitInfo {
                s_type: vk::StructureType::TIMELINE_SEMAPHORE_SUBMIT_INFO,
                next: std::ptr::null(),
                wait_semaphore_value_count: 1,
                wait_semaphore_values: wait_values[ndx..].as_ptr(),
                signal_semaphore_value_count: 1,
                signal_semaphore_values: values[ndx..].as_ptr(),
            })
            .collect();
        let submits: Vec<vk::SubmitInfo> = (0..ITERATION_COUNT)
            .map(|ndx| vk::SubmitInfo {
                s_type: vk::StructureType::SUBMIT_INFO,
                next: if is_timeline {
                    std::ptr::from_ref(&timeline_infos[ndx]).cast()
                } else {
                    std::ptr::null()
                },
                wait_semaphore_count: u32::from(is_timeline),
                wait_semaphores: first_semaphore[ndx..].as_ptr(),
                wait_dst_stage_mask: stages[ndx..].as_ptr(),
                command_buffer_count: 1,
                command_buffers: raw[ndx..].as_ptr(),
                signal_semaphore_count: 1,
                signal_semaphores: semaphores[ndx..].as_ptr(),
            })
            .collect();
        unsafe { device.queue_submit(queue, &submits, vk::Fence::null()) }.vk_check("vkQueueSubmit")
    }

    /// The single read submit, waiting only on the last write's signal.
    #[allow(clippy::too_many_arguments)]
    fn submit_reads(
        &self,
        device: &Device,
        queue: vk::Queue,
        cmd_buffer: vk::CommandBuffer,
        wait_semaphore: vk::Semaphore,
        wait_value: u64,
        signal_semaphore: vk::Semaphore,
        signal_value: u64,
        fence: vk::Fence,
    ) -> Result<(), TestError> {
        if self.params.sync_type == SyncType::Synchronization2 {
            use vulkanalia::vk::KhrSynchronization2ExtensionDeviceCommands;
            let cmd_infos = [command_buffer_submit_info(cmd_buffer)];
            let waits = [semaphore_submit_info(wait_semaphore, wait_value, vk::PipelineStageFlags2::TOP_OF_PIPE)];
            let signals = [semaphore_submit_info(signal_semaphore, signal_value, vk::PipelineStageFlags2::BOTTOM_OF_PIPE)];
            let submit = vk::SubmitInfo2 {
                s_type: vk::StructureType::SUBMIT_INFO_2,
                next: std::ptr::null(),
                flags: vk::SubmitFlags::empty(),
                wait_semaphore_info_count: 1,
                wait_semaphore_infos: waits.as_ptr(),
                command_buffer_info_count: 1,
                command_buffer_infos: cmd_infos.as_ptr(),
                signal_semaphore_info_count: 1,
                signal_semaphore_infos: signals.as_ptr(),
            };
            return unsafe { device.queue_submit2_khr(queue, &[submit], fence) }.vk_check("vkQueueSubmit2KHR");
        }

        let is_timeline = self.params.semaphore_type == SemaphoreType::Timeline;
        let wait_semaphores = [wait_semaphore];
        let signal_semaphores = [signal_semaphore];
        let stages = [vk::PipelineStageFlags::TOP_OF_PIPE];
        let cmd_buffers = [cmd_buffer];
        let wait_values = [wait_value];
        let signal_values = [signal_value];
        let timeline_info = vk::TimelineSemaphoreSubmitInfo {
            s_type: vk::StructureType::TIMELINE_SEMAPHORE_SUBMIT_INFO,
            next: std::ptr::null(),
            wait_semaphore_value_count: 1,
            wait_semaphore_values: wait_values.as_ptr(),
            signal_semaphore_value_count: 1,
            signal_semaphore_values: signal_values.as_ptr(),
        };
        let submit = vk::SubmitInfo {
            s_type: vk::StructureType::SUBMIT_INFO,
            next: if is_timeline { std::ptr::from_ref(&timeline_info).cast() } else { std::ptr::null() },
            wait_semaphore_count: 1,
            wait_semaphores: wait_semaphores.as_ptr(),
            wait_dst_stage_mask: stages.as_ptr(),
            command_buffer_count: 1,
            command_buffers: cmd_buffers.as_ptr(),
            signal_semaphore_count: 1,
            signal_semaphores: signal_semaphores.as_ptr(),
        };
        unsafe { device.queue_submit(queue, &[submit], fence) }.vk_check("vkQueueSubmit")
    }
}

fn command_buffer_submit_info(command_buffer: vk::CommandBuffer) -> vk::CommandBufferSubmitInfo {
    vk::CommandBufferSubmitInfo {
        s_type: vk::StructureType::COMMAND_BUFFER_SUBMIT_INFO,
        next: std::ptr::null(),
        command_buffer,
        device_mask: 0,
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

/// `createSemaphoreType`
fn create_semaphore(device: &Device, semaphore_type: SemaphoreType) -> Result<Unique<'_, vk::Semaphore>, TestError> {
    let handle = match semaphore_type {
        SemaphoreType::Binary => unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) },
        SemaphoreType::Timeline => {
            let mut type_info = vk::SemaphoreTypeCreateInfo::builder().semaphore_type(vk::SemaphoreType::TIMELINE).initial_value(0);
            let info = vk::SemaphoreCreateInfo::builder().push_next(&mut type_info);
            unsafe { device.create_semaphore(&info, None) }
        }
    }
    .vk_check("vkCreateSemaphore")?;
    Ok(Unique::new(device, handle))
}

/// `hostSignal`
fn host_signal(device: &Device, semaphore: vk::Semaphore, value: u64) -> Result<(), TestError> {
    let info = vk::SemaphoreSignalInfo::builder().semaphore(semaphore).value(value);
    unsafe { device.signal_semaphore(&info) }.vk_check("vkSignalSemaphore")
}

/// `writeOps` - a subset, since every one is crossed with every read.
const SIGNAL_ORDER_WRITE_OPS: &[OperationName] = &[
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

const SIGNAL_ORDER_READ_OPS: &[OperationName] = &[
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

/// `createSignalOrderTests`
pub fn create_signal_order_tests(sync_type: SyncType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("signal_order");

    for semaphore_type in [SemaphoreType::Binary, SemaphoreType::Timeline] {
        let mut semaphore_group = TestCaseGroup::new(semaphore_type.group_name());

        for &write_op in SIGNAL_ORDER_WRITE_OPS {
            for &read_op in SIGNAL_ORDER_READ_OPS {
                let mut op_group = TestCaseGroup::new(format!("{}_{}", write_op.as_str(), read_op.as_str()));
                let mut empty = true;

                for resource in RESOURCES {
                    if !write_op.supports_resource(resource) || !read_op.supports_resource(resource) {
                        continue;
                    }
                    op_group.add_child(Box::new(SignalOrderTestCase {
                        name: get_resource_name(resource),
                        sync_type,
                        semaphore_type,
                        resource: *resource,
                        write_op,
                        read_op,
                    }) as Box<dyn TestCase>);
                    empty = false;
                }

                if !empty {
                    semaphore_group.add_child(op_group);
                }
            }
        }

        group.add_child(semaphore_group);
    }

    group
}

#[cfg(test)]
mod tests {
    use super::*;

    fn family(index: u32, flags: vk::QueueFlags, count: usize) -> QueueFamilyQueues {
        // The queue handles only have to be distinct; the search compares them for
        // identity and never dereferences them.
        QueueFamilyQueues {
            family_index: index,
            flags,
            queues: (0..count).map(|i| vk::Queue::from_raw(index as usize * 100 + i + 1)).collect(),
        }
    }

    #[test]
    fn a_single_queue_cannot_supply_both_sides() {
        let families = [family(0, vk::QueueFlags::GRAPHICS | vk::QueueFlags::COMPUTE, 1)];
        let result = find_queues(&families, vk::QueueFlags::TRANSFER, vk::QueueFlags::TRANSFER);
        assert!(matches!(result, Err(TestError::NotSupported(_))));
    }

    #[test]
    fn two_queues_in_one_family_are_enough() {
        let families = [family(0, vk::QueueFlags::GRAPHICS, 2)];
        let q = find_queues(&families, vk::QueueFlags::GRAPHICS, vk::QueueFlags::GRAPHICS).unwrap();
        assert_ne!(q.queue_a, q.queue_b);
        assert_eq!(q.family_a, q.family_b);
    }

    #[test]
    fn transfer_is_implied_by_graphics_or_compute() {
        assert!(is_queue_valid(vk::QueueFlags::GRAPHICS, vk::QueueFlags::TRANSFER));
        assert!(is_queue_valid(vk::QueueFlags::COMPUTE, vk::QueueFlags::TRANSFER));
        // The implication only runs one way: a transfer-only queue is not a graphics one.
        assert!(!is_queue_valid(vk::QueueFlags::TRANSFER, vk::QueueFlags::GRAPHICS));
    }
}
