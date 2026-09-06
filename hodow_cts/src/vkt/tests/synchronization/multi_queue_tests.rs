// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationOperationMultiQueueTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The same write operation / read operation pairs the single-queue tests use, but with
// the two halves submitted to *different* queues. What is under test is then the queue
// family ownership transfer as much as the primitive: a resource written on one family
// and read on another has to be released by the first and acquired by the second, and a
// driver that ignores either half hands the reader stale or undefined contents.
//
// Ported so far: the `fence` and `binary_semaphore` primitives. `timeline_semaphore`
// needs the two-resource "copy" operation family (`s_copyOps`) that is not ported, and
// `intermediate_barrier_use_all` needs VK_KHR_maintenance8 plus draw operations.

use vulkanalia::prelude::v1_0::*;

use super::operation::{
    OperationName, READ_OPS, RESOURCES, Resource, ResourceDescription, ResourceType, SyncInfo, SyncType, WRITE_OPS, build_operation, first_difference, get_resource_name,
    make_buffer_memory_barrier2, make_image_memory_barrier2,
};
use crate::tcu::{self, TestError, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::context::QueueFamilyQueues;
use crate::vkt::{Context, TestCase, TestInstance};

/// `SyncPrimitive`, restricted to the two the multi-queue group registers here.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum SyncPrimitive {
    Fence,
    BinarySemaphore,
}

impl SyncPrimitive {
    fn group_name(self) -> &'static str {
        match self {
            Self::Fence => "fence",
            Self::BinarySemaphore => "binary_semaphore",
        }
    }
}

/// `QueuePair`
#[derive(Clone, Copy)]
struct QueuePair {
    family_index_write: u32,
    family_index_read: u32,
    queue_write: vk::Queue,
    queue_read: vk::Queue,
}

/// `checkQueueFlags`
///
/// A queue that supports graphics or compute is required by the spec to support
/// transfer as well, whether or not it advertises the bit.
fn check_queue_flags(mut available: vk::QueueFlags, needed: vk::QueueFlags) -> bool {
    if available.intersects(vk::QueueFlags::GRAPHICS | vk::QueueFlags::COMPUTE) {
        available |= vk::QueueFlags::TRANSFER;
    }
    available.contains(needed)
}

/// `MultiQueues::getQueuesPairs`
///
/// One pair per (write family, read family) combination whose two queues are distinct
/// objects - the inner loops stop at the first suitable pair for a family combination,
/// exactly as upstream's `writeNdx = readNdx = max(...)` does.
fn get_queues_pairs(families: &[QueueFamilyQueues], flags_write: vk::QueueFlags, flags_read: vk::QueueFlags, require_different: bool) -> Vec<QueuePair> {
    let write_families: Vec<_> = families.iter().filter(|f| check_queue_flags(f.flags, flags_write)).collect();
    let read_families: Vec<_> = families.iter().filter(|f| check_queue_flags(f.flags, flags_read)).collect();

    let mut pairs = Vec::new();
    for write in &write_families {
        for read in &read_families {
            'combination: for &queue_write in &write.queues {
                for &queue_read in &read.queues {
                    if queue_write != queue_read && (!require_different || write.family_index != read.family_index) {
                        pairs.push(QueuePair {
                            family_index_write: write.family_index,
                            family_index_read: read.family_index,
                            queue_write,
                            queue_read,
                        });
                        break 'combination;
                    }
                }
            }
        }
    }
    pairs
}

/// `BaseTestCase`
pub struct MultiQueueTestCase {
    name: String,
    sync_type: SyncType,
    primitive: SyncPrimitive,
    resource: ResourceDescription,
    write_op: OperationName,
    read_op: OperationName,
    sharing_mode: vk::SharingMode,
    maintenance9: bool,
}

impl TestCase for MultiQueueTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if self.sync_type == SyncType::Synchronization2 {
            context.require_device_functionality("VK_KHR_synchronization2")?;
        }

        let instance = context.get_instance();
        let queue_family_properties = unsafe { instance.get_physical_device_queue_family_properties(context.get_physical_device()) };

        if self.sharing_mode == vk::SharingMode::CONCURRENT && queue_family_properties.len() < 2 {
            return Err(TestError::NotSupported("Concurrent requires more than 1 queue family".into()));
        }

        if self.resource.kind == ResourceType::Image {
            let usage = self.write_op.out_resource_usage(&self.resource) | self.read_op.in_resource_usage(&self.resource);
            let properties = unsafe {
                instance.get_physical_device_image_format_properties(
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

        if self.maintenance9 {
            context.require_device_functionality("VK_KHR_maintenance9")?;
        }

        // `OperationSupport::checkSupport` for both halves.
        if self.write_op.needs_blit_format_support() || self.read_op.needs_blit_format_support() {
            let props = unsafe { instance.get_physical_device_format_properties(context.get_physical_device(), self.resource.image_format) };
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
        Box::new(MultiQueueTestInstance { context, params: self })
    }
}

struct MultiQueueTestInstance<'a> {
    context: &'a Context<'a>,
    params: &'a MultiQueueTestCase,
}

impl TestInstance for MultiQueueTestInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        let p = self.params;
        let queues = self.context.multi_queue_device()?;
        let device = queues.device();
        let allocator = queues.allocator();

        let pairs = get_queues_pairs(queues.families(), p.write_op.queue_flags(&p.resource), p.read_op.queue_flags(&p.resource), false);
        // Only `BinarySemaphoreTestInstance` rejects an empty pair list.
        // `FenceTestInstance` does not check, so on a device with a single queue it
        // runs its loop zero times and passes vacuously. That is upstream's behaviour
        // and the verdicts have to match it, odd as a test that passes without running
        // anything is.
        if pairs.is_empty() && p.primitive == SyncPrimitive::BinarySemaphore {
            return Err(TestError::NotSupported("No suitable queue pairs found".into()));
        }

        for pair in &pairs {
            let usage = p.write_op.out_resource_usage(&p.resource) | p.read_op.in_resource_usage(&p.resource);
            let resource = Resource::new(device, allocator, &p.resource, usage)?;
            let write_op = build_operation(device, allocator, p.write_op, &p.resource, &resource, false)?;
            let read_op = build_operation(device, allocator, p.read_op, &p.resource, &resource, false)?;

            let write_pool = make_command_pool(device, pair.family_index_write)?;
            let read_pool = make_command_pool(device, pair.family_index_read)?;
            let write_cmd = allocate_command_buffer(device, *write_pool, vk::CommandBufferLevel::PRIMARY)?;
            let read_cmd = allocate_command_buffer(device, *read_pool, vk::CommandBufferLevel::PRIMARY)?;

            let write_sync = write_op.out_sync_info(p.sync_type);
            let read_sync = read_op.in_sync_info(p.sync_type);

            // `queueFamilyOwnershipTransferRequired`. Without maintenance9 the transfer
            // is always required; with it a driver may declare that some images need no
            // transfer between the two families at all.
            let perform_qfot = self.queue_family_ownership_transfer_required(&resource, pair.family_index_write, pair.family_index_read);
            let (barrier_write_family, barrier_read_family) = if perform_qfot {
                (pair.family_index_write, pair.family_index_read)
            } else {
                (vk::QUEUE_FAMILY_IGNORED, vk::QUEUE_FAMILY_IGNORED)
            };

            begin_command_buffer(device, *write_cmd)?;
            write_op.record_commands(device, p.sync_type, *write_cmd);
            let write_stage_mask = self.create_barrier_multi_queue(device, *write_cmd, write_sync, read_sync, &resource, barrier_write_family, barrier_read_family, false);
            end_command_buffer(device, *write_cmd)?;

            begin_command_buffer(device, *read_cmd)?;
            let mut read_stage_mask = vk::PipelineStageFlags2::TOP_OF_PIPE;
            if perform_qfot {
                read_stage_mask = self.create_barrier_multi_queue(device, *read_cmd, write_sync, read_sync, &resource, barrier_write_family, barrier_read_family, true);
            }
            read_op.record_commands(device, p.sync_type, *read_cmd);
            end_command_buffer(device, *read_cmd)?;

            match p.primitive {
                // `FenceTestInstance` - the write side is waited to completion on the
                // host before the read is submitted at all.
                SyncPrimitive::Fence => {
                    self.submit_and_wait(device, pair.queue_write, *write_cmd, &[], &[], write_stage_mask)?;
                    self.submit_and_wait(device, pair.queue_read, *read_cmd, &[], &[], read_stage_mask)?;
                }
                // `BinarySemaphoreTestInstance` - both submitted up front, ordered only
                // by the semaphore.
                SyncPrimitive::BinarySemaphore => {
                    let semaphore = unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }.vk_check("vkCreateSemaphore")?;
                    let semaphore = Unique::new(device, semaphore);
                    self.submit(device, pair.queue_write, *write_cmd, &[], &[*semaphore], write_stage_mask)?;
                    self.submit(device, pair.queue_read, *read_cmd, &[*semaphore], &[], read_stage_mask)?;
                    unsafe { device.queue_wait_idle(pair.queue_write) }.vk_check("vkQueueWaitIdle")?;
                    unsafe { device.queue_wait_idle(pair.queue_read) }.vk_check("vkQueueWaitIdle")?;
                }
            }

            let expected = write_op.data(device)?;
            let actual = read_op.data(device)?;

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
        }

        Ok(TestStatus::pass("OK"))
    }
}

impl MultiQueueTestInstance<'_> {
    /// `BaseTestInstance::queueFamilyOwnershipTransferRequired`
    fn queue_family_ownership_transfer_required(&self, resource: &Resource<'_>, qf1: u32, qf2: u32) -> bool {
        if !self.params.maintenance9 {
            return true;
        }
        if resource.kind != ResourceType::Image {
            return true;
        }

        let usage = self.params.write_op.out_resource_usage(&self.params.resource) | self.params.read_op.in_resource_usage(&self.params.resource);
        let attachment_usages = (vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
            | vk::ImageUsageFlags::TRANSIENT_ATTACHMENT
            | vk::ImageUsageFlags::INPUT_ATTACHMENT)
            .bits();
        if usage & attachment_usages != 0 {
            return true;
        }

        // Upstream asks for one family's properties (`count = 1u`) and treats the two
        // family *indices* as a bit mask; both are reproduced here, because a different
        // answer means a different barrier and so a different test.
        // vulkanalia's safe wrapper allocates its own output vector and gives no way to
        // chain a pNext onto it, so the raw entry point is used here.
        let instance = self.context.get_instance();
        let mut ownership = vk::QueueFamilyOwnershipTransferPropertiesKHR::default();
        let mut properties = vk::QueueFamilyProperties2::builder().push_next(&mut ownership).build();
        let mut count = 1u32;
        unsafe {
            (instance.commands().get_physical_device_queue_family_properties2)(self.context.get_physical_device(), &mut count, &mut properties);
        }

        let required = qf1 | qf2;
        (ownership.optimal_image_transfer_to_queue_families & required) != required
    }

    /// `createBarrierMultiQueue`, without the `useAllStages` branch: no registered case
    /// sets it, since it needs VK_KHR_maintenance8's dependency flag.
    ///
    /// Returns the pipeline stage the semaphore is signalled or waited at.
    #[allow(clippy::too_many_arguments)]
    fn create_barrier_multi_queue(
        &self,
        device: &Device,
        cmd_buffer: vk::CommandBuffer,
        write_sync: SyncInfo,
        read_sync: SyncInfo,
        resource: &Resource<'_>,
        write_family: u32,
        read_family: u32,
        second_queue: bool,
    ) -> vk::PipelineStageFlags2 {
        let pipeline_flags = if second_queue {
            vk::PipelineStageFlags2::TOP_OF_PIPE
        } else {
            vk::PipelineStageFlags2::BOTTOM_OF_PIPE
        };
        let sharing_mode = self.params.sharing_mode;
        let sync = self.params.sync_type;

        // The release half names the write's real stage and access and the acquire's
        // stage as a bare BOTTOM_OF_PIPE; the acquire half is the mirror image. Only
        // one of the two carries the access mask, which is what makes it an ownership
        // transfer rather than two independent barriers.
        let src_stage = if second_queue { vk::PipelineStageFlags2::TOP_OF_PIPE } else { write_sync.stage_mask };
        let src_access = if second_queue { vk::AccessFlags2::empty() } else { write_sync.access_mask };
        let dst_stage = if second_queue { read_sync.stage_mask } else { vk::PipelineStageFlags2::BOTTOM_OF_PIPE };
        let dst_access = if second_queue { read_sync.access_mask } else { vk::AccessFlags2::empty() };

        if resource.kind == ResourceType::Image {
            let image = resource.image();
            let mut barrier = make_image_memory_barrier2(
                src_stage,
                src_access,
                dst_stage,
                dst_access,
                write_sync.image_layout,
                read_sync.image_layout,
                image.handle,
                image.subresource_range,
            );

            if write_family != read_family && sharing_mode == vk::SharingMode::EXCLUSIVE {
                barrier.src_queue_family_index = write_family;
                barrier.dst_queue_family_index = read_family;
                cmd_pipeline_barrier_images(device, sync, cmd_buffer, &[barrier]);
            } else if !second_queue {
                cmd_pipeline_barrier_images(device, sync, cmd_buffer, &[barrier]);
            }
        } else {
            let buffer = resource.buffer();
            let mut barrier = make_buffer_memory_barrier2(src_stage, src_access, dst_stage, dst_access, buffer.handle, buffer.offset, buffer.size);
            if write_family != read_family && sharing_mode == vk::SharingMode::EXCLUSIVE {
                barrier.src_queue_family_index = write_family;
                barrier.dst_queue_family_index = read_family;
            }
            cmd_pipeline_barrier_buffers(device, sync, cmd_buffer, &[barrier]);
        }

        pipeline_flags
    }

    /// `submitCommandsAndWait` for one queue.
    fn submit_and_wait(
        &self,
        device: &Device,
        queue: vk::Queue,
        cmd_buffer: vk::CommandBuffer,
        wait: &[vk::Semaphore],
        signal: &[vk::Semaphore],
        stage_mask: vk::PipelineStageFlags2,
    ) -> Result<(), TestError> {
        let fence = unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?;
        let fence = Unique::new(device, fence);
        self.submit_with_fence(device, queue, cmd_buffer, wait, signal, stage_mask, *fence)?;
        unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
        Ok(())
    }

    fn submit(
        &self,
        device: &Device,
        queue: vk::Queue,
        cmd_buffer: vk::CommandBuffer,
        wait: &[vk::Semaphore],
        signal: &[vk::Semaphore],
        stage_mask: vk::PipelineStageFlags2,
    ) -> Result<(), TestError> {
        self.submit_with_fence(device, queue, cmd_buffer, wait, signal, stage_mask, vk::Fence::null())
    }

    #[allow(clippy::too_many_arguments)]
    fn submit_with_fence(
        &self,
        device: &Device,
        queue: vk::Queue,
        cmd_buffer: vk::CommandBuffer,
        wait: &[vk::Semaphore],
        signal: &[vk::Semaphore],
        stage_mask: vk::PipelineStageFlags2,
        fence: vk::Fence,
    ) -> Result<(), TestError> {
        if self.params.sync_type == SyncType::Synchronization2 {
            use vulkanalia::vk::KhrSynchronization2ExtensionDeviceCommands;
            let cmd_infos = [vk::CommandBufferSubmitInfo {
                s_type: vk::StructureType::COMMAND_BUFFER_SUBMIT_INFO,
                next: std::ptr::null(),
                command_buffer: cmd_buffer,
                device_mask: 0,
            }];
            let wait_infos: Vec<vk::SemaphoreSubmitInfo> = wait.iter().map(|s| semaphore_submit_info(*s, stage_mask)).collect();
            let signal_infos: Vec<vk::SemaphoreSubmitInfo> = signal.iter().map(|s| semaphore_submit_info(*s, stage_mask)).collect();
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
            unsafe { device.queue_submit2_khr(queue, &[submit], fence) }.vk_check("vkQueueSubmit2KHR")
        } else {
            let legacy_stage = vk::PipelineStageFlags::from_bits_truncate(stage_mask.bits() as u32);
            let legacy_stage = if legacy_stage.is_empty() { vk::PipelineStageFlags::TOP_OF_PIPE } else { legacy_stage };
            let wait_stages = vec![legacy_stage; wait.len()];
            let cmd_buffers = [cmd_buffer];
            let submit = vk::SubmitInfo::builder()
                .wait_semaphores(wait)
                .wait_dst_stage_mask(&wait_stages)
                .command_buffers(&cmd_buffers)
                .signal_semaphores(signal);
            unsafe { device.queue_submit(queue, &[submit], fence) }.vk_check("vkQueueSubmit")
        }
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

fn cmd_pipeline_barrier_images(device: &Device, sync: SyncType, cmd_buffer: vk::CommandBuffer, images: &[vk::ImageMemoryBarrier2]) {
    super::operation::cmd_pipeline_barrier(device, sync, cmd_buffer, &[], images);
}

fn cmd_pipeline_barrier_buffers(device: &Device, sync: SyncType, cmd_buffer: vk::CommandBuffer, buffers: &[vk::BufferMemoryBarrier2]) {
    super::operation::cmd_pipeline_barrier(device, sync, cmd_buffer, buffers, &[]);
}

/// `createSynchronizedOperationMultiQueueTests` -> `createTests`
pub fn create_multi_queue_tests(sync_type: SyncType) -> tcu::TestCaseGroup {
    let mut group = tcu::TestCaseGroup::new("multi_queue");

    for primitive in [SyncPrimitive::Fence, SyncPrimitive::BinarySemaphore] {
        let mut primitive_group = tcu::TestCaseGroup::new(primitive.group_name());

        for &write_op in WRITE_OPS {
            for &read_op in READ_OPS {
                let mut op_group = tcu::TestCaseGroup::new(format!("{}_{}", write_op.as_str(), read_op.as_str()));
                let mut empty = true;

                // `optionNdx` - the sharing mode the resource is declared with.
                for sharing_mode in [vk::SharingMode::EXCLUSIVE, vk::SharingMode::CONCURRENT] {
                    for resource in RESOURCES {
                        if !write_op.supports_resource(resource) || !read_op.supports_resource(resource) {
                            continue;
                        }
                        let suffix = if sharing_mode == vk::SharingMode::CONCURRENT { "_concurrent" } else { "_exclusive" };
                        let name = format!("{}{suffix}", get_resource_name(resource));

                        op_group.add_child(Box::new(MultiQueueTestCase {
                            name: name.clone(),
                            sync_type,
                            primitive,
                            resource: *resource,
                            write_op,
                            read_op,
                            sharing_mode,
                            maintenance9: false,
                        }) as Box<dyn TestCase>);

                        if sharing_mode == vk::SharingMode::CONCURRENT {
                            op_group.add_child(Box::new(MultiQueueTestCase {
                                name: format!("{name}_maintenance9"),
                                sync_type,
                                primitive,
                                resource: *resource,
                                write_op,
                                read_op,
                                sharing_mode,
                                maintenance9: true,
                            }) as Box<dyn TestCase>);
                        }
                        empty = false;
                    }
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

#[cfg(test)]
mod tests {
    use super::*;

    fn family(index: u32, flags: vk::QueueFlags, count: usize) -> QueueFamilyQueues {
        // The queue handles only have to be distinct; they are never dereferenced by
        // the pairing logic, which compares them for identity.
        QueueFamilyQueues {
            family_index: index,
            flags,
            queues: (0..count).map(|i| vk::Queue::from_raw(index as usize * 100 + i + 1)).collect(),
        }
    }

    /// A queue that supports graphics or compute supports transfer whether or not it
    /// says so, which is what lets a transfer operation run on the universal queue.
    #[test]
    fn transfer_is_implied_by_graphics_or_compute() {
        assert!(check_queue_flags(vk::QueueFlags::GRAPHICS, vk::QueueFlags::TRANSFER));
        assert!(check_queue_flags(vk::QueueFlags::COMPUTE, vk::QueueFlags::TRANSFER));
        assert!(!check_queue_flags(vk::QueueFlags::TRANSFER, vk::QueueFlags::GRAPHICS));
        assert!(!check_queue_flags(vk::QueueFlags::TRANSFER, vk::QueueFlags::COMPUTE));
    }

    /// One family with one queue can produce no pair at all: the two halves would have
    /// to be the same queue object. This is the SwiftShader case, and the reason the
    /// binary-semaphore cases report NotSupported there.
    #[test]
    fn single_queue_yields_no_pairs() {
        let families = [family(0, vk::QueueFlags::GRAPHICS | vk::QueueFlags::COMPUTE | vk::QueueFlags::TRANSFER, 1)];
        assert!(get_queues_pairs(&families, vk::QueueFlags::TRANSFER, vk::QueueFlags::TRANSFER, false).is_empty());
    }

    /// Two queues in one family pair with each other, but only once - upstream breaks
    /// out of both inner loops after the first suitable pair per family combination.
    #[test]
    fn two_queues_in_one_family_yield_one_pair() {
        let families = [family(0, vk::QueueFlags::GRAPHICS | vk::QueueFlags::COMPUTE, 2)];
        let pairs = get_queues_pairs(&families, vk::QueueFlags::TRANSFER, vk::QueueFlags::TRANSFER, false);
        assert_eq!(pairs.len(), 1);
        assert_eq!(pairs[0].family_index_write, 0);
        assert_eq!(pairs[0].family_index_read, 0);
        assert_ne!(pairs[0].queue_write, pairs[0].queue_read);
    }

    /// `requireDifferent` drops the same-family pairs, leaving only the cross-family
    /// ones - the ownership transfers.
    #[test]
    fn require_different_keeps_only_cross_family_pairs() {
        let families = [
            family(0, vk::QueueFlags::GRAPHICS | vk::QueueFlags::COMPUTE, 2),
            family(1, vk::QueueFlags::COMPUTE, 2),
            family(2, vk::QueueFlags::TRANSFER, 2),
        ];
        let all = get_queues_pairs(&families, vk::QueueFlags::TRANSFER, vk::QueueFlags::TRANSFER, false);
        assert_eq!(all.len(), 9, "every ordered family combination, including self-pairs");

        let different = get_queues_pairs(&families, vk::QueueFlags::TRANSFER, vk::QueueFlags::TRANSFER, true);
        assert_eq!(different.len(), 6);
        assert!(different.iter().all(|p| p.family_index_write != p.family_index_read));
    }

    /// A graphics-only write op cannot be paired with a transfer-only family on the
    /// write side, but that family is still eligible on the read side.
    #[test]
    fn queue_flags_filter_each_side_separately() {
        let families = [family(0, vk::QueueFlags::GRAPHICS | vk::QueueFlags::COMPUTE, 2), family(1, vk::QueueFlags::TRANSFER, 2)];
        let pairs = get_queues_pairs(&families, vk::QueueFlags::GRAPHICS, vk::QueueFlags::TRANSFER, false);
        assert_eq!(pairs.len(), 2);
        assert!(pairs.iter().all(|p| p.family_index_write == 0));
        assert_eq!(pairs.iter().filter(|p| p.family_index_read == 1).count(), 1);
    }
}
