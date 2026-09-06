// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationImplicitTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// A single `vkQueueSubmit` carrying many submit infos at once. The spec orders the
// submit infos within one call, and that ordering is *implicit* - nothing in the
// structures says so - which is what the group is named for. Each case picks a
// permutation of four submit-info shapes:
//
//   0: wait only            1: wait + command buffers
//   2: wait + signal        3: wait + command buffers + signal
//
// and the test generates the counterpart of each one, so that every wait is signalled,
// every signal is waited on, and every read has a write behind it. A driver that
// executes the submit infos out of order lets a read run before its write.

use vulkanalia::prelude::v1_0::*;

use super::operation::{
    Operation, OperationName, RESOURCES, Resource, ResourceDescription, ResourceType, SyncType, build_operation, cmd_pipeline_barrier, first_difference, get_resource_name,
    make_buffer_memory_barrier2, make_image_memory_barrier2,
};
use super::signal_order_tests::SemaphoreType;
use crate::tcu::{self, Random, TestError, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

/// `SubmitInfoElements` - which of the three parts a submit info carries. The array
/// index is the part, so a `None` in slot 1 means "no command buffers".
#[derive(Clone, Copy, PartialEq, Eq)]
enum SubmitElement {
    Wait,
    CmdBuff,
    Signal,
    None,
}

/// `SIE_MAX`
const ELEMENT_COUNT: usize = 3;

/// `queueSumbitInfoTypes` - the four shapes a permutation is drawn from. Every one
/// starts with a wait, which is what lets the generated counterpart always be a signal.
const SUBMIT_INFO_TYPES: [[SubmitElement; ELEMENT_COUNT]; 4] = [
    [SubmitElement::Wait, SubmitElement::None, SubmitElement::None],
    [SubmitElement::Wait, SubmitElement::CmdBuff, SubmitElement::None],
    [SubmitElement::Wait, SubmitElement::None, SubmitElement::Signal],
    [SubmitElement::Wait, SubmitElement::CmdBuff, SubmitElement::Signal],
];

const MIN_OPS_PER_INFO: i32 = 2;
const MAX_OPS_PER_INFO: i32 = 10;

/// `QueueSubmitImplicitTestCase`
pub struct ImplicitTestCase {
    name: String,
    sync_type: SyncType,
    semaphore_type: SemaphoreType,
    resource: ResourceDescription,
    write_op: OperationName,
    read_op: OperationName,
    /// The four indices into `SUBMIT_INFO_TYPES` that give this case its name.
    combo: [usize; 4],
}

impl TestCase for ImplicitTestCase {
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
        Box::new(ImplicitTestInstance { context, params: self })
    }
}

struct ImplicitTestInstance<'a> {
    context: &'a Context<'a>,
    params: &'a ImplicitTestCase,
}

/// The semaphores one submit info owns, and the timeline value each of them is used
/// with. A binary case creates one semaphore per entry; a timeline case creates one and
/// repeats its handle, so the values are what tell the entries apart.
#[derive(Default)]
struct SemaphoreSet<'a> {
    owned: Vec<Unique<'a, vk::Semaphore>>,
    handles: Vec<vk::Semaphore>,
    values: Vec<u64>,
}

impl<'a> SemaphoreSet<'a> {
    /// `addSemaphore`
    fn add(&mut self, device: &'a Device, semaphore_type: SemaphoreType, first_value: u64, rng: &mut Random) -> Result<(), TestError> {
        if semaphore_type == SemaphoreType::Binary || self.owned.is_empty() {
            self.owned.push(create_semaphore(device, semaphore_type)?);
        }
        self.handles.push(*self.owned[self.owned.len() - 1]);
        let previous = self.values.last().copied().unwrap_or(first_value);
        self.values.push(previous + rng.get_int(1, 100) as u64);
        Ok(())
    }
}

impl TestInstance for ImplicitTestInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_index = self.context.get_universal_queue_family_index();
        let is_timeline = p.semaphore_type == SemaphoreType::Timeline;
        let mut rng = Random::new(1024);

        let infos: Vec<[SubmitElement; ELEMENT_COUNT]> = p.combo.iter().map(|&i| SUBMIT_INFO_TYPES[i]).collect();
        let count_a = infos.len();

        // How many waits, command buffers and signals each shape gets. The counterpart
        // counts mirror them: a wait on the A side is a signal on the B side, and a
        // command buffer on the A side (a read) needs one on the B side (its write).
        let mut wait_count_a = vec![0u32; count_a];
        let mut cmd_count_a = vec![0u32; count_a];
        let mut signal_count_a = vec![0u32; count_a];
        let mut wait_count_b = vec![0u32; count_a];
        let mut cmd_count_b = vec![0u32; count_a];
        let mut signal_count_b = vec![0u32; count_a];

        let mut operations_required = 0u32;
        let mut count_b = 0usize;
        for (info_idx, info) in infos.iter().enumerate() {
            for element in info {
                match element {
                    SubmitElement::Wait => {
                        let n = rng.get_int(MIN_OPS_PER_INFO, MAX_OPS_PER_INFO) as u32;
                        wait_count_a[info_idx] = n;
                        signal_count_b[info_idx] = n;
                    }
                    SubmitElement::CmdBuff => {
                        let n = rng.get_int(MIN_OPS_PER_INFO, MAX_OPS_PER_INFO) as u32;
                        cmd_count_a[info_idx] = n;
                        cmd_count_b[info_idx] = n;
                        operations_required += n;
                    }
                    SubmitElement::Signal => {
                        let n = rng.get_int(MIN_OPS_PER_INFO, MAX_OPS_PER_INFO) as u32;
                        signal_count_a[info_idx] = n;
                        wait_count_b[info_idx] = n;
                        // Every shape begins with a wait, so a shape that also signals
                        // needs a second counterpart: one to signal what it waits on,
                        // one to wait on what it signals.
                        count_b += 1;
                    }
                    SubmitElement::None => {}
                }
            }
            count_b += 1;
        }

        let mut resources = Vec::with_capacity(operations_required as usize);
        for _ in 0..operations_required {
            let usage = p.write_op.out_resource_usage(&p.resource) | p.read_op.in_resource_usage(&p.resource);
            resources.push(Resource::new(device, allocator, &p.resource, usage)?);
        }
        let mut write_ops: Vec<Box<dyn Operation + '_>> = Vec::with_capacity(resources.len());
        let mut read_ops: Vec<Box<dyn Operation + '_>> = Vec::with_capacity(resources.len());
        for resource in &resources {
            write_ops.push(build_operation(device, allocator, p.write_op, &p.resource, resource, false)?);
            read_ops.push(build_operation(device, allocator, p.read_op, &p.resource, resource, false)?);
        }

        let command_pool = make_command_pool(device, queue_index)?;
        let mut cmd_buffers_w = Vec::with_capacity(resources.len());
        let mut cmd_buffers_r = Vec::with_capacity(resources.len());
        for ndx in 0..resources.len() {
            let cmd = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
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
            cmd_buffers_w.push(cmd);

            let cmd = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
            begin_command_buffer(device, *cmd)?;
            read_ops[ndx].record_commands(device, p.sync_type, *cmd);
            end_command_buffer(device, *cmd)?;
            cmd_buffers_r.push(cmd);
        }

        // The semaphores each side owns. B's are created first because A waits on them.
        let mut semaphores_a: Vec<SemaphoreSet<'_>> = (0..count_a).map(|_| SemaphoreSet::default()).collect();
        let mut semaphores_b: Vec<SemaphoreSet<'_>> = (0..count_a).map(|_| SemaphoreSet::default()).collect();

        let mut wait_infos_a: Vec<Vec<vk::SemaphoreSubmitInfo>> = vec![Vec::new(); count_a];
        let mut signal_infos_a: Vec<Vec<vk::SemaphoreSubmitInfo>> = vec![Vec::new(); count_a];
        let mut cmd_infos_a: Vec<Vec<vk::CommandBufferSubmitInfo>> = vec![Vec::new(); count_a];
        let mut wait_infos_b: Vec<Vec<vk::SemaphoreSubmitInfo>> = vec![Vec::new(); count_b];
        let mut signal_infos_b: Vec<Vec<vk::SemaphoreSubmitInfo>> = vec![Vec::new(); count_a];
        let mut cmd_infos_b: Vec<Vec<vk::CommandBufferSubmitInfo>> = vec![Vec::new(); count_a];

        let mut cmd_idx_w = 0usize;
        let mut cmd_idx_r = 0usize;

        // Pass one: the counterparts. The wait on the A side becomes a signal here, and
        // the read on the A side gets the write it needs.
        for (info_idx, info) in infos.iter().enumerate() {
            for element in info {
                match element {
                    SubmitElement::Wait => {
                        for _ in 0..signal_count_b[info_idx] {
                            semaphores_b[info_idx].add(device, p.semaphore_type, 2, &mut rng)?;
                            let ndx = signal_infos_b[info_idx].len();
                            let handle = semaphores_b[info_idx].handles[semaphores_b[info_idx].handles.len() - 1];
                            let value = semaphores_b[info_idx].values[ndx];
                            signal_infos_b[info_idx].push(semaphore_submit_info(handle, value));
                        }
                    }
                    SubmitElement::CmdBuff => {
                        for _ in 0..cmd_count_b[info_idx] {
                            cmd_infos_b[info_idx].push(command_buffer_submit_info(*cmd_buffers_w[cmd_idx_w]));
                            cmd_idx_w += 1;
                        }
                    }
                    SubmitElement::Signal | SubmitElement::None => {}
                }
            }
        }

        // Pass two: the submit infos the case actually names.
        for (info_idx, info) in infos.iter().enumerate() {
            for element in info {
                match element {
                    SubmitElement::Wait => {
                        for ndx in 0..wait_count_a[info_idx] as usize {
                            wait_infos_a[info_idx].push(semaphore_submit_info(semaphores_b[info_idx].handles[ndx], semaphores_b[info_idx].values[ndx]));
                        }
                    }
                    SubmitElement::CmdBuff => {
                        for _ in 0..cmd_count_a[info_idx] {
                            cmd_infos_a[info_idx].push(command_buffer_submit_info(*cmd_buffers_r[cmd_idx_r]));
                            cmd_idx_r += 1;
                        }
                    }
                    SubmitElement::Signal => {
                        for _ in 0..signal_count_a[info_idx] {
                            semaphores_a[info_idx].add(device, p.semaphore_type, 2, &mut rng)?;
                            let ndx = signal_infos_a[info_idx].len();
                            let handle = semaphores_a[info_idx].handles[semaphores_a[info_idx].handles.len() - 1];
                            let value = semaphores_a[info_idx].values[ndx];
                            signal_infos_a[info_idx].push(semaphore_submit_info(handle, value));
                        }
                    }
                    SubmitElement::None => {}
                }
            }
        }

        // Pass three: a wait-only counterpart for every signal the case makes, so
        // nothing is left signalled but unwaited.
        let mut wait_slot = count_a;
        for (info_idx, info) in infos.iter().enumerate() {
            if info[2] != SubmitElement::Signal {
                continue;
            }
            for ndx in 0..wait_count_b[info_idx] as usize {
                wait_infos_b[wait_slot].push(semaphore_submit_info(semaphores_a[info_idx].handles[ndx], semaphores_a[info_idx].values[ndx]));
            }
            wait_slot += 1;
        }

        // The submit order is the point of the test: counterparts first, then the named
        // infos, then the trailing waits, all in one call.
        let mut submits = Vec::with_capacity(count_b + count_a);
        for info_idx in 0..count_a {
            if cmd_count_b[info_idx] > 0 || signal_count_b[info_idx] > 0 {
                submits.push((&[][..], &cmd_infos_b[info_idx][..], &signal_infos_b[info_idx][..]));
            }
        }
        for info_idx in 0..count_a {
            if wait_count_a[info_idx] > 0 || cmd_count_a[info_idx] > 0 || signal_count_a[info_idx] > 0 {
                submits.push((&wait_infos_a[info_idx][..], &cmd_infos_a[info_idx][..], &signal_infos_a[info_idx][..]));
            }
        }
        for waits in &wait_infos_b[count_a..wait_slot] {
            if !waits.is_empty() {
                submits.push((&waits[..], &[][..], &[][..]));
            }
        }

        let fence = unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?;
        let fence = Unique::new(device, fence);
        self.submit(device, queue, &submits, *fence, is_timeline)?;
        unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;

        for ndx in 0..resources.len() {
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
                    "Memory contents don't match: operation {ndx}, first difference at byte {at} of {}, expected {:#04x} got {:#04x}",
                    expected.len(),
                    expected[at],
                    actual[at],
                )));
            }
        }

        Ok(TestStatus::pass("Success"))
    }
}

type SubmitParts<'a> = (&'a [vk::SemaphoreSubmitInfo], &'a [vk::CommandBufferSubmitInfo], &'a [vk::SemaphoreSubmitInfo]);

impl ImplicitTestInstance<'_> {
    /// Every submit info in one `vkQueueSubmit`, which is what makes their ordering
    /// implicit rather than declared.
    fn submit(&self, device: &Device, queue: vk::Queue, submits: &[SubmitParts<'_>], fence: vk::Fence, is_timeline: bool) -> Result<(), TestError> {
        if self.params.sync_type == SyncType::Synchronization2 {
            use vulkanalia::vk::KhrSynchronization2ExtensionDeviceCommands;
            let infos: Vec<vk::SubmitInfo2> = submits
                .iter()
                .map(|(waits, cmds, signals)| vk::SubmitInfo2 {
                    s_type: vk::StructureType::SUBMIT_INFO_2,
                    next: std::ptr::null(),
                    flags: vk::SubmitFlags::empty(),
                    wait_semaphore_info_count: waits.len() as u32,
                    wait_semaphore_infos: waits.as_ptr(),
                    command_buffer_info_count: cmds.len() as u32,
                    command_buffer_infos: cmds.as_ptr(),
                    signal_semaphore_info_count: signals.len() as u32,
                    signal_semaphore_infos: signals.as_ptr(),
                })
                .collect();
            return unsafe { device.queue_submit2_khr(queue, &infos, fence) }.vk_check("vkQueueSubmit2KHR");
        }

        // The legacy path needs the handles, stages and values as separate flat arrays,
        // and all of them have to outlive the call.
        let mut wait_handles = Vec::with_capacity(submits.len());
        let mut wait_stages = Vec::with_capacity(submits.len());
        let mut wait_values = Vec::with_capacity(submits.len());
        let mut signal_handles = Vec::with_capacity(submits.len());
        let mut signal_values = Vec::with_capacity(submits.len());
        let mut cmd_handles = Vec::with_capacity(submits.len());
        for (waits, cmds, signals) in submits {
            wait_handles.push(waits.iter().map(|w| w.semaphore).collect::<Vec<_>>());
            wait_stages.push(vec![vk::PipelineStageFlags::BOTTOM_OF_PIPE; waits.len()]);
            wait_values.push(waits.iter().map(|w| w.value).collect::<Vec<_>>());
            signal_handles.push(signals.iter().map(|s| s.semaphore).collect::<Vec<_>>());
            signal_values.push(signals.iter().map(|s| s.value).collect::<Vec<_>>());
            cmd_handles.push(cmds.iter().map(|c| c.command_buffer).collect::<Vec<_>>());
        }

        let timeline_infos: Vec<vk::TimelineSemaphoreSubmitInfo> = (0..submits.len())
            .map(|ndx| vk::TimelineSemaphoreSubmitInfo {
                s_type: vk::StructureType::TIMELINE_SEMAPHORE_SUBMIT_INFO,
                next: std::ptr::null(),
                wait_semaphore_value_count: wait_values[ndx].len() as u32,
                wait_semaphore_values: wait_values[ndx].as_ptr(),
                signal_semaphore_value_count: signal_values[ndx].len() as u32,
                signal_semaphore_values: signal_values[ndx].as_ptr(),
            })
            .collect();
        let infos: Vec<vk::SubmitInfo> = (0..submits.len())
            .map(|ndx| vk::SubmitInfo {
                s_type: vk::StructureType::SUBMIT_INFO,
                next: if is_timeline {
                    std::ptr::from_ref(&timeline_infos[ndx]).cast()
                } else {
                    std::ptr::null()
                },
                wait_semaphore_count: wait_handles[ndx].len() as u32,
                wait_semaphores: wait_handles[ndx].as_ptr(),
                wait_dst_stage_mask: wait_stages[ndx].as_ptr(),
                command_buffer_count: cmd_handles[ndx].len() as u32,
                command_buffers: cmd_handles[ndx].as_ptr(),
                signal_semaphore_count: signal_handles[ndx].len() as u32,
                signal_semaphores: signal_handles[ndx].as_ptr(),
            })
            .collect();
        unsafe { device.queue_submit(queue, &infos, fence) }.vk_check("vkQueueSubmit")
    }
}

/// `makeCommonSemaphoreSubmitInfo`. Upstream names BOTTOM_OF_PIPE for both the signal
/// and the wait side here - its ternary picks the same value either way.
fn semaphore_submit_info(semaphore: vk::Semaphore, value: u64) -> vk::SemaphoreSubmitInfo {
    vk::SemaphoreSubmitInfo {
        s_type: vk::StructureType::SEMAPHORE_SUBMIT_INFO,
        next: std::ptr::null(),
        semaphore,
        value,
        stage_mask: vk::PipelineStageFlags2::BOTTOM_OF_PIPE,
        device_index: 0,
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

const IMPLICIT_WRITE_OPS: &[OperationName] = &[OperationName::WriteCopyBuffer, OperationName::WriteSsboVertex];
const IMPLICIT_READ_OPS: &[OperationName] = &[OperationName::ReadCopyBuffer, OperationName::ReadSsboVertex];

/// `createImplicitSyncTests`
pub fn create_implicit_tests(sync_type: SyncType) -> tcu::TestCaseGroup {
    let mut group = tcu::TestCaseGroup::new("implicit");

    for semaphore_type in [SemaphoreType::Binary, SemaphoreType::Timeline] {
        let mut semaphore_group = tcu::TestCaseGroup::new(match semaphore_type {
            SemaphoreType::Binary => "binary_semaphore",
            SemaphoreType::Timeline => "timeline_semaphore",
        });

        // `comboCnt` walks across the whole write/read cross product, so the first
        // permutation index differs from one operation pair to the next.
        let mut combo_cnt = 0usize;
        for &write_op in IMPLICIT_WRITE_OPS {
            for &read_op in IMPLICIT_READ_OPS {
                let mut op_group = tcu::TestCaseGroup::new(format!("{}_{}", write_op.as_str(), read_op.as_str()));
                let mut empty = true;

                // Only the first resource the pair supports is used - the permutations
                // are the point, not the resource.
                for resource in RESOURCES {
                    if !write_op.supports_resource(resource) || !read_op.supports_resource(resource) {
                        continue;
                    }
                    let mut res_group = tcu::TestCaseGroup::new(get_resource_name(resource));
                    let idx0 = combo_cnt % SUBMIT_INFO_TYPES.len();
                    for idx1 in 0..SUBMIT_INFO_TYPES.len() {
                        for idx2 in 0..SUBMIT_INFO_TYPES.len() {
                            for idx3 in 0..SUBMIT_INFO_TYPES.len() {
                                res_group.add_child(Box::new(ImplicitTestCase {
                                    name: format!("{idx0}{idx1}{idx2}{idx3}"),
                                    sync_type,
                                    semaphore_type,
                                    resource: *resource,
                                    write_op,
                                    read_op,
                                    combo: [idx0, idx1, idx2, idx3],
                                }) as Box<dyn TestCase>);
                            }
                        }
                    }
                    op_group.add_child(res_group);
                    empty = false;
                    combo_cnt += 1;
                    break;
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
