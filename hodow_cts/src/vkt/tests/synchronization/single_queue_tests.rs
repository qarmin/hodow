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
    Operation, OperationName, READ_OPS, RESOURCES, Resource, ResourceDescription, ResourceType, SyncInfo, SyncType, WRITE_OPS, build_operation, cmd_pipeline_barrier,
    get_resource_name, make_buffer_memory_barrier2, make_image_memory_barrier2,
};
use crate::tcu::{self, TestError, TestStatus};
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
    Barrier,
    Event,
}

impl SyncPrimitive {
    fn group_name(self) -> &'static str {
        match self {
            Self::Fence => "fence",
            Self::BinarySemaphore => "binary_semaphore",
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
        if self.maintenance9 {
            context.require_device_functionality("VK_KHR_maintenance9")?;
        }
        if self.compute_queue && context.get_compute_queue().is_none() {
            return Err(TestError::NotSupported("no dedicated compute queue".into()));
        }

        if self.resource.kind == ResourceType::Image {
            let usage = self.write_op.out_resource_usage() | self.read_op.in_resource_usage();
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

        // `checkSupportForFormatBlit` - both ends of the blit go through the same
        // format, so it has to be usable as source and destination.
        if self.write_op.needs_blit_format_support() || self.read_op.needs_blit_format_support() {
            let props = unsafe {
                context
                    .get_instance()
                    .get_physical_device_format_properties(context.get_physical_device(), self.resource.image_format)
            };
            let needed = vk::FormatFeatureFlags::BLIT_SRC | vk::FormatFeatureFlags::BLIT_DST;
            if !props.optimal_tiling_features.contains(needed) {
                return Err(TestError::NotSupported("Format does not support blitting".into()));
            }
        }

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
            self.context.get_compute_queue().ok_or_else(|| TestError::NotSupported("no dedicated compute queue".into()))?
        } else {
            (self.context.get_universal_queue(), self.context.get_universal_queue_family_index())
        };

        // `BaseTestInstance` - the resource is created with the union of what the write
        // op will produce and the read op will consume.
        let usage = p.write_op.out_resource_usage() | p.read_op.in_resource_usage();
        let resource = Resource::new(device, allocator, &p.resource, usage)?;
        let write_op = build_operation(device, allocator, p.write_op, &resource, p.specialized_access)?;
        let read_op = build_operation(device, allocator, p.read_op, &resource, p.specialized_access)?;

        let write_sync = write_op.out_sync_info(p.sync_type);
        let read_sync = read_op.in_sync_info(p.sync_type);

        let command_pool = make_command_pool(device, queue_index)?;
        match p.primitive {
            SyncPrimitive::Barrier => self.run_barrier(device, queue, *command_pool, &resource, &*write_op, &*read_op, write_sync, read_sync)?,
            SyncPrimitive::Fence => self.run_fence(device, queue, *command_pool, &resource, &*write_op, &*read_op, write_sync, read_sync)?,
            SyncPrimitive::BinarySemaphore => self.run_binary_semaphore(device, queue, *command_pool, &resource, &*write_op, &*read_op, write_sync, read_sync)?,
            SyncPrimitive::Event => self.run_event(device, queue, *command_pool, &resource, &*write_op, &*read_op, write_sync, read_sync)?,
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
        } else if expected != actual {
            return Ok(TestStatus::fail("Memory contents don't match"));
        }

        Ok(TestStatus::pass("OK"))
    }
}

impl SyncTestInstance<'_> {
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
            device.cmd_wait_events(
                cmd_buffer,
                &[event],
                src_stage,
                dst_stage,
                &[] as &[vk::MemoryBarrier],
                &legacy_buffers,
                &legacy_images,
            );
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

    for primitive in [SyncPrimitive::Fence, SyncPrimitive::BinarySemaphore, SyncPrimitive::Barrier, SyncPrimitive::Event] {
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
            op.add_child(create_single_queue_tests(sync_type));
            group.add_child(op);
            group
        })
        .collect()
}
