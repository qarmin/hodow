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
// A binary semaphore can only be signalled by the device. A timeline semaphore can be
// signalled and waited on by the host as well, and every wait names a value rather than
// a state, so a chain of dependencies can be declared up front and satisfied out of
// order. `device_host` is the test of exactly that: twelve write/read pairs are queued
// in one submit, and between each pair the *host* has to wake up, copy what the device
// read into what the device is about to write, and signal the value the next write is
// waiting on. If the driver's timeline is wrong in either direction - the host wait
// returns early, or the device runs ahead of a host signal - the data that comes out
// the far end is not the data that went in.
//
// Ported so far: `device_host`. The other subgroups (`one_to_n`, `wait_before_signal`)
// chain the resource through the two-resource "copy" operation family, which is not
// ported.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_2;

use super::operation::{
    Operation, OperationName, RESOURCES, Resource, ResourceDescription, ResourceType, SyncType, build_operation,
    cmd_pipeline_barrier, first_difference, get_resource_name, make_buffer_memory_barrier2, make_image_memory_barrier2,
};
use crate::generated::shaders::synchronization_timeline_semaphore::IGNORE_TIMELINE_SEMAPHORE_INFO;
use crate::tcu::pixel::PixelBufferAccess;
use crate::tcu::random::Random;
use crate::tcu::texture::{TextureChannelClass, map_vk_format};
use crate::tcu::{TestError, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_pipeline_layout_with_push_constants,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `s_writeOps` for `DeviceHostTestsBase::initCommonTests`, restricted to the ported
/// operations. Upstream's list is a subset of the full catalogue to begin with - the
/// chain hands one operation's payload to the next, so only operations that stage
/// their data through a host buffer can appear.
static DEVICE_HOST_WRITE_OPS: &[OperationName] = &[
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

/// `readOps` for the same.
static DEVICE_HOST_READ_OPS: &[OperationName] = &[
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

/// `randomizeData` - the payload the chain starts with.
///
/// A buffer gets random bytes; an image is filled pixel by pixel so the values are
/// representable in its format, since a copy through the image would otherwise quantise
/// them and the comparison at the end would fail on the port rather than on the driver.
pub fn randomize_data(out: &mut [u8], desc: &ResourceDescription) {
    let mut rng = Random::new(1234);

    if desc.kind != ResourceType::Image {
        for byte in out.iter_mut() {
            *byte = rng.get_uint8();
        }
        return;
    }

    let format = map_vk_format(desc.image_format).expect("a resource image format maps");
    let extent = [
        desc.size[0] as u32,
        (desc.size[1].max(1)) as u32,
        (desc.size[2].max(1)) as u32,
    ];
    let is_float = matches!(
        format.channel_class(),
        TextureChannelClass::FloatingPoint
            | TextureChannelClass::SignedFixedPoint
            | TextureChannelClass::UnsignedFixedPoint
    );
    let bit_depth = crate::tcu::pixel::get_texture_format_bit_depth(format);
    let mut access = PixelBufferAccess::new(format, extent, out);

    for z in 0..extent[2] {
        for y in 0..extent[1] {
            for x in 0..extent[0] {
                if is_float {
                    access.set_pixel([rng.get_float(), rng.get_float(), rng.get_float(), 1.0], x, y, z);
                } else {
                    let value = [
                        rng.get_int(0, int_max_value(bit_depth[0])),
                        rng.get_int(0, int_max_value(bit_depth[1])),
                        rng.get_int(0, int_max_value(bit_depth[2])),
                        rng.get_int(0, int_max_value(bit_depth[3])),
                    ];
                    let _ = access.set_pixel_int(value, x, y, z);
                }
            }
        }
    }
}

/// `deIntMaxValue32` - the largest value that fits in `bits`, clamped to `i32::MAX`
/// because `de::Random::getInt` takes a signed range.
pub fn int_max_value(bits: i32) -> i32 {
    if bits <= 0 {
        return 0;
    }
    if bits >= 32 { i32::MAX } else { (1i32 << bits) - 1 }
}

/// `TimelineIteration` - one write/read pair, its own resource, and the three semaphore
/// values that order it against its neighbours.
struct TimelineIteration<'a> {
    resource: Resource<'a>,
    write_op: Box<dyn Operation + 'a>,
    read_op: Box<dyn Operation + 'a>,
    write_value: u64,
    read_value: u64,
    cpu_value: u64,
}

/// `DeviceHostSyncTestCase`
pub struct DeviceHostTestCase {
    name: String,
    sync_type: SyncType,
    resource: ResourceDescription,
    write_op: OperationName,
    read_op: OperationName,
}

impl TestCase for DeviceHostTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_timeline_semaphore")?;
        if self.sync_type == SyncType::Synchronization2 {
            context.require_device_functionality("VK_KHR_synchronization2")?;
        }

        if self.resource.kind == ResourceType::Image {
            let usage =
                self.write_op.out_resource_usage(&self.resource) | self.read_op.in_resource_usage(&self.resource);
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
                    return Err(TestError::NotSupported(
                        "Requested sample count is not supported".into(),
                    ));
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
        Box::new(DeviceHostTestInstance { context, params: self })
    }
}

struct DeviceHostTestInstance<'a> {
    context: &'a Context<'a>,
    params: &'a DeviceHostTestCase,
}

/// `ITERATION_COUNT` - upstream's "a dozen couple of operations".
const ITERATION_COUNT: usize = 12;

impl TestInstance for DeviceHostTestInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_index = self.context.get_universal_queue_family_index();

        let usage = p.write_op.out_resource_usage(&p.resource) | p.read_op.in_resource_usage(&p.resource);
        let mut rng = Random::new(1234);
        let mut iterations: Vec<TimelineIteration<'_>> = Vec::with_capacity(ITERATION_COUNT);
        for i in 0..ITERATION_COUNT {
            let last_value = if i == 0 { 0 } else { iterations[i - 1].cpu_value };
            let resource = Resource::new(device, allocator, &p.resource, usage)?;
            let write_op = build_operation(device, allocator, p.write_op, &p.resource, &resource, false)?;
            let read_op = build_operation(device, allocator, p.read_op, &p.resource, &resource, false)?;

            // The three values are drawn in this order and only from this rng, so the
            // sequence has to match upstream's exactly or the submit order changes.
            let write_value = last_value + u64::from(rng.get_int(1, 100) as u32);
            let read_value = write_value + u64::from(rng.get_int(1, 100) as u32);
            let cpu_value = read_value + u64::from(rng.get_int(1, 100) as u32);

            iterations.push(TimelineIteration {
                resource,
                write_op,
                read_op,
                write_value,
                read_value,
                cpu_value,
            });
        }

        let semaphore = create_timeline_semaphore(device)?;
        let command_pool = make_command_pool(device, queue_index)?;

        // Randomise what the chain starts with, so a driver that leaves the resource
        // untouched cannot pass by accident.
        {
            let start = iterations[0].write_op.data(device)?;
            let mut randomized = vec![0u8; start.len()];
            randomize_data(&mut randomized, &p.resource);
            iterations[0].write_op.set_data(device, &randomized)?;
        }

        let mut command_buffers = Vec::with_capacity(ITERATION_COUNT * 2);
        for _ in 0..ITERATION_COUNT * 2 {
            command_buffers.push(allocate_command_buffer(
                device,
                *command_pool,
                vk::CommandBufferLevel::PRIMARY,
            )?);
        }

        for (iter_ndx, iteration) in iterations.iter().enumerate() {
            let write_cmd = *command_buffers[2 * iter_ndx];
            begin_command_buffer(device, write_cmd)?;
            iteration.write_op.record_commands(device, p.sync_type, write_cmd);
            self.record_transition(device, write_cmd, iteration);
            end_command_buffer(device, write_cmd)?;

            let read_cmd = *command_buffers[2 * iter_ndx + 1];
            begin_command_buffer(device, read_cmd)?;
            iteration.read_op.record_commands(device, p.sync_type, read_cmd);
            end_command_buffer(device, read_cmd)?;
        }

        self.submit_all(device, queue, *semaphore, &iterations, &command_buffers)?;

        // `HostCopyThread::run`. Upstream runs this on its own thread started before the
        // submit; `vkQueueSubmit` does not block, so running it here after the submit
        // interleaves with the device exactly the same way. Each round waits for the
        // device to finish that iteration's read, hands the result to the next write,
        // and releases the next write by signalling the value it waits on.
        for iter_ndx in 0..iterations.len() {
            wait_semaphore(device, *semaphore, iterations[iter_ndx].read_value)?;

            if iter_ndx + 1 < iterations.len() {
                let read_back = iterations[iter_ndx].read_op.data(device)?;
                iterations[iter_ndx + 1].write_op.set_data(device, &read_back)?;
            }

            signal_semaphore(device, *semaphore, iterations[iter_ndx].cpu_value)?;
        }

        unsafe { device.device_wait_idle() }.vk_check("vkDeviceWaitIdle")?;

        let expected = iterations.first().expect("twelve iterations").write_op.data(device)?;
        let actual = iterations.last().expect("twelve iterations").read_op.data(device)?;
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
}

impl DeviceHostTestInstance<'_> {
    /// The barrier between an iteration's write and its read, in whichever flavour the
    /// resource needs. It goes at the end of the *write* command buffer, since the two
    /// halves are separate submits.
    fn record_transition(&self, device: &Device, cmd_buffer: vk::CommandBuffer, iteration: &TimelineIteration<'_>) {
        let sync = self.params.sync_type;
        let write_sync = iteration.write_op.out_sync_info(sync);
        let read_sync = iteration.read_op.in_sync_info(sync);

        if iteration.resource.kind == ResourceType::Image {
            let image = iteration.resource.image();
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
            let buffer = iteration.resource.buffer();
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

    /// The whole chain in one `vkQueueSubmit`: 24 batches, each waiting on the value
    /// its predecessor signals. Queuing them all up front is the point of the test -
    /// the device has to block on values only the host can produce.
    fn submit_all(
        &self,
        device: &Device,
        queue: vk::Queue,
        semaphore: vk::Semaphore,
        iterations: &[TimelineIteration<'_>],
        command_buffers: &[crate::vk::ref_util::UniqueCommandBuffer<'_>],
    ) -> Result<(), TestError> {
        let mut wait_values = Vec::with_capacity(iterations.len() * 2);
        let mut signal_values = Vec::with_capacity(iterations.len() * 2);
        for (iter_ndx, iteration) in iterations.iter().enumerate() {
            // The write waits on the *host* value of the previous iteration, so it
            // cannot start until the host has handed it the data.
            wait_values.push(if iter_ndx == 0 {
                0
            } else {
                iterations[iter_ndx - 1].cpu_value
            });
            signal_values.push(iteration.write_value);
            wait_values.push(iteration.write_value);
            signal_values.push(iteration.read_value);
        }

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
                waits.push(semaphore_submit_info(
                    semaphore,
                    wait_values[ndx],
                    vk::PipelineStageFlags2::TOP_OF_PIPE,
                ));
                signals.push(semaphore_submit_info(
                    semaphore,
                    signal_values[ndx],
                    vk::PipelineStageFlags2::BOTTOM_OF_PIPE,
                ));
            }

            let submits: Vec<vk::SubmitInfo2> = (0..command_buffers.len())
                .map(|ndx| vk::SubmitInfo2 {
                    s_type: vk::StructureType::SUBMIT_INFO_2,
                    next: std::ptr::null(),
                    flags: vk::SubmitFlags::empty(),
                    // The very first batch has nothing to wait for.
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
            let wait_stage = vk::PipelineStageFlags::TOP_OF_PIPE;
            let stages = vec![wait_stage; command_buffers.len()];
            let raw_buffers: Vec<vk::CommandBuffer> = command_buffers.iter().map(|c| **c).collect();
            let semaphores = vec![semaphore; command_buffers.len()];

            let timeline_infos: Vec<vk::TimelineSemaphoreSubmitInfo> = (0..command_buffers.len())
                .map(|ndx| vk::TimelineSemaphoreSubmitInfo {
                    s_type: vk::StructureType::TIMELINE_SEMAPHORE_SUBMIT_INFO,
                    next: std::ptr::null(),
                    wait_semaphore_value_count: u32::from(ndx != 0),
                    wait_semaphore_values: wait_values[ndx..].as_ptr(),
                    signal_semaphore_value_count: 1,
                    signal_semaphore_values: signal_values[ndx..].as_ptr(),
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
                    command_buffers: raw_buffers[ndx..].as_ptr(),
                    signal_semaphore_count: 1,
                    signal_semaphores: semaphores[ndx..].as_ptr(),
                })
                .collect();
            unsafe { device.queue_submit(queue, &submits, vk::Fence::null()) }.vk_check("vkQueueSubmit")?;
        }
        Ok(())
    }
}

fn semaphore_submit_info(
    semaphore: vk::Semaphore,
    value: u64,
    stage_mask: vk::PipelineStageFlags2,
) -> vk::SemaphoreSubmitInfo {
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
    create_timeline_semaphore_with_value(device, 0)
}

/// `createSemaphoreType(VK_SEMAPHORE_TYPE_TIMELINE, initialValue)`
fn create_timeline_semaphore_with_value(
    device: &Device,
    initial_value: u64,
) -> Result<Unique<'_, vk::Semaphore>, TestError> {
    let mut type_info = vk::SemaphoreTypeCreateInfo::builder()
        .semaphore_type(vk::SemaphoreType::TIMELINE)
        .initial_value(initial_value);
    let info = vk::SemaphoreCreateInfo::builder().push_next(&mut type_info);
    let semaphore = unsafe { device.create_semaphore(&info, None) }.vk_check("vkCreateSemaphore")?;
    Ok(Unique::new(device, semaphore))
}

fn wait_semaphore(device: &Device, semaphore: vk::Semaphore, value: u64) -> Result<(), TestError> {
    let semaphores = [semaphore];
    let values = [value];
    let info = vk::SemaphoreWaitInfo::builder().semaphores(&semaphores).values(&values);
    unsafe { device.wait_semaphores(&info, u64::MAX) }.vk_check("vkWaitSemaphores")?;
    Ok(())
}

fn signal_semaphore(device: &Device, semaphore: vk::Semaphore, value: u64) -> Result<(), TestError> {
    let info = vk::SemaphoreSignalInfo::builder().semaphore(semaphore).value(value);
    unsafe { device.signal_semaphore(&info) }.vk_check("vkSignalSemaphore")
}

// ---------------------------------------------------------------------------------
// `WaitTests` - the timeline API on its own, with no operation behind it
// ---------------------------------------------------------------------------------

/// `WAIT_SEMAPHORE_COUNT` - upstream waits on a hundred at once, which is the point:
/// `VK_SEMAPHORE_WAIT_ANY_BIT` has to return when *one* of them reaches its value.
const WAIT_SEMAPHORE_COUNT: usize = 100;

/// `deviceSignal` - signal a timeline value from a submit with no work in it.
fn device_signal(
    device: &Device,
    queue: vk::Queue,
    sync: SyncType,
    semaphore: vk::Semaphore,
    value: u64,
    fence: vk::Fence,
) -> Result<(), TestError> {
    if sync == SyncType::Synchronization2 {
        use vulkanalia::vk::KhrSynchronization2ExtensionDeviceCommands;
        let signal = [semaphore_submit_info(
            semaphore,
            value,
            vk::PipelineStageFlags2::BOTTOM_OF_PIPE,
        )];
        let submit = vk::SubmitInfo2 {
            s_type: vk::StructureType::SUBMIT_INFO_2,
            next: std::ptr::null(),
            flags: vk::SubmitFlags::empty(),
            wait_semaphore_info_count: 0,
            wait_semaphore_infos: std::ptr::null(),
            command_buffer_info_count: 0,
            command_buffer_infos: std::ptr::null(),
            signal_semaphore_info_count: 1,
            signal_semaphore_infos: signal.as_ptr(),
        };
        unsafe { device.queue_submit2_khr(queue, &[submit], vk::Fence::null()) }.vk_check("vkQueueSubmit2KHR")?;
    } else {
        let semaphores = [semaphore];
        let values = [value];
        let mut timeline = vk::TimelineSemaphoreSubmitInfo::builder().signal_semaphore_values(&values);
        let submit = vk::SubmitInfo::builder()
            .signal_semaphores(&semaphores)
            .push_next(&mut timeline);
        unsafe { device.queue_submit(queue, &[submit], vk::Fence::null()) }.vk_check("vkQueueSubmit")?;
    }

    // Upstream follows the signalling submit with an empty one carrying the fence, so
    // the host can tell when the queue has drained without waiting on the timeline.
    if fence != vk::Fence::null() {
        unsafe { device.queue_submit(queue, &[] as &[vk::SubmitInfo], fence) }.vk_check("vkQueueSubmit")?;
        unsafe { device.wait_for_fences(&[fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
    }
    Ok(())
}

fn semaphore_counter_value(device: &Device, semaphore: vk::Semaphore) -> Result<u64, TestError> {
    unsafe { device.get_semaphore_counter_value(semaphore) }
        .map_err(|e| TestError::ResourceError(format!("vkGetSemaphoreCounterValue failed: {e}")))
}

/// `vkWaitSemaphores` without treating `VK_TIMEOUT` as an error.
fn wait_semaphores_status(
    device: &Device,
    semaphores: &[vk::Semaphore],
    values: &[u64],
    wait_any: bool,
    timeout: u64,
) -> Result<vk::SuccessCode, TestError> {
    let flags = if wait_any {
        vk::SemaphoreWaitFlags::ANY
    } else {
        vk::SemaphoreWaitFlags::empty()
    };
    let info = vk::SemaphoreWaitInfo::builder()
        .flags(flags)
        .semaphores(semaphores)
        .values(values);
    match unsafe { device.wait_semaphores(&info, timeout) } {
        Ok(code) => Ok(code),
        Err(e) => Err(TestError::ResourceError(format!("vkWaitSemaphores failed: {e}"))),
    }
}

/// `WaitTestInstance` - a hundred semaphores, each with its own target value. With
/// `waitAll` every one is signalled first; with wait-any only one randomly chosen
/// semaphore is, and the wait still has to return immediately.
fn timeline_wait(
    context: &Context<'_>,
    sync: SyncType,
    wait_all: bool,
    signal_from_device: bool,
) -> Result<TestStatus, TestError> {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let fence = {
        let info = vk::FenceCreateInfo::builder();
        Unique::new(
            device,
            unsafe { device.create_fence(&info, None) }.vk_check("vkCreateFence")?,
        )
    };

    let mut semaphores = Vec::with_capacity(WAIT_SEMAPHORE_COUNT);
    for _ in 0..WAIT_SEMAPHORE_COUNT {
        semaphores.push(create_timeline_semaphore(device)?);
    }
    let raw: Vec<vk::Semaphore> = semaphores.iter().map(|s| **s).collect();

    let mut rng = Random::new(1234);
    let values: Vec<u64> = (0..WAIT_SEMAPHORE_COUNT)
        .map(|_| rng.get_int(1, 10000) as u64)
        .collect();

    if wait_all {
        for (ndx, &semaphore) in raw.iter().enumerate() {
            if signal_from_device {
                device_signal(device, queue, sync, semaphore, values[ndx], *fence)?;
                unsafe { device.reset_fences(&[*fence]) }.vk_check("vkResetFences")?;
            } else {
                signal_semaphore(device, semaphore, values[ndx])?;
            }
        }
    } else {
        let ndx = rng.get_int(0, WAIT_SEMAPHORE_COUNT as i32 - 1) as usize;
        if signal_from_device {
            device_signal(device, queue, sync, raw[ndx], values[ndx], *fence)?;
        } else {
            signal_semaphore(device, raw[ndx], values[ndx])?;
        }
    }

    // Timeout zero: the wait has to be satisfied already, not merely eventually.
    if wait_semaphores_status(device, &raw, &values, !wait_all, 0)? != vk::SuccessCode::SUCCESS {
        return Ok(TestStatus::fail("Wait failed"));
    }

    unsafe { device.device_wait_idle() }.vk_check("vkDeviceWaitIdle")?;
    Ok(TestStatus::pass("Wait success"))
}

/// `HostWaitBeforeSignalTestInstance` - twelve submits are queued, each waiting on the
/// value its predecessor signals, and the whole chain is held up by one value only the
/// host can produce. Waiting on any of those values before that must time out.
fn timeline_host_wait_before_signal(context: &Context<'_>, sync: SyncType) -> Result<TestStatus, TestError> {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let semaphore = create_timeline_semaphore(device)?;
    let mut rng = Random::new(1234);

    let mut values: Vec<u64> = vec![1 + rng.get_int(1, 10000) as u64];
    for _ in 0..12 {
        let next = values[values.len() - 1] + rng.get_int(1, 10000) as u64;
        let wait_value = values[values.len() - 1];

        if sync == SyncType::Synchronization2 {
            use vulkanalia::vk::KhrSynchronization2ExtensionDeviceCommands;
            let waits = [semaphore_submit_info(
                *semaphore,
                wait_value,
                vk::PipelineStageFlags2::TOP_OF_PIPE,
            )];
            let signals = [semaphore_submit_info(
                *semaphore,
                next,
                vk::PipelineStageFlags2::BOTTOM_OF_PIPE,
            )];
            let submit = vk::SubmitInfo2 {
                s_type: vk::StructureType::SUBMIT_INFO_2,
                next: std::ptr::null(),
                flags: vk::SubmitFlags::empty(),
                wait_semaphore_info_count: 1,
                wait_semaphore_infos: waits.as_ptr(),
                command_buffer_info_count: 0,
                command_buffer_infos: std::ptr::null(),
                signal_semaphore_info_count: 1,
                signal_semaphore_infos: signals.as_ptr(),
            };
            unsafe { device.queue_submit2_khr(queue, &[submit], vk::Fence::null()) }.vk_check("vkQueueSubmit2KHR")?;
        } else {
            let semaphores = [*semaphore];
            let wait_values = [wait_value];
            let signal_values = [next];
            let stages = [vk::PipelineStageFlags::TOP_OF_PIPE];
            let mut timeline = vk::TimelineSemaphoreSubmitInfo::builder()
                .wait_semaphore_values(&wait_values)
                .signal_semaphore_values(&signal_values);
            let submit = vk::SubmitInfo::builder()
                .wait_semaphores(&semaphores)
                .wait_dst_stage_mask(&stages)
                .signal_semaphores(&semaphores)
                .push_next(&mut timeline);
            unsafe { device.queue_submit(queue, &[submit], vk::Fence::null()) }.vk_check("vkQueueSubmit")?;
        }

        values.push(next);
    }

    {
        let pick = rng.get_int(0, values.len() as i32 - 1) as usize;
        if wait_semaphores_status(device, &[*semaphore], &[values[pick]], false, 0)? != vk::SuccessCode::TIMEOUT {
            return Ok(TestStatus::fail("Wait failed"));
        }
    }

    signal_semaphore(device, *semaphore, values[0])?;

    {
        let last = values[values.len() - 1];
        if wait_semaphores_status(device, &[*semaphore], &[last], false, u64::MAX)? != vk::SuccessCode::SUCCESS {
            return Ok(TestStatus::fail("Wait failed"));
        }
    }

    unsafe { device.device_wait_idle() }.vk_check("vkDeviceWaitIdle")?;
    Ok(TestStatus::pass("Wait success"))
}

/// `PollTestInstance` - the same signals, observed through
/// `vkGetSemaphoreCounterValue` instead of a wait. The counter must reach the value and
/// must never overshoot it.
fn timeline_poll(context: &Context<'_>, signal_from_device: bool) -> Result<TestStatus, TestError> {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let fence = {
        let info = vk::FenceCreateInfo::builder();
        Unique::new(
            device,
            unsafe { device.create_fence(&info, None) }.vk_check("vkCreateFence")?,
        )
    };

    let mut semaphores = Vec::with_capacity(WAIT_SEMAPHORE_COUNT);
    for _ in 0..WAIT_SEMAPHORE_COUNT {
        semaphores.push(create_timeline_semaphore(device)?);
    }
    let raw: Vec<vk::Semaphore> = semaphores.iter().map(|s| **s).collect();

    let mut rng = Random::new(1234);
    let values: Vec<u64> = (0..WAIT_SEMAPHORE_COUNT)
        .map(|_| rng.get_int(1, 10000) as u64)
        .collect();

    for (ndx, &semaphore) in raw.iter().enumerate() {
        if signal_from_device {
            // Only the last signal carries the fence; upstream always uses the legacy
            // submit path here regardless of the group.
            let fence_handle = if ndx == raw.len() - 1 {
                *fence
            } else {
                vk::Fence::null()
            };
            device_signal(device, queue, SyncType::Legacy, semaphore, values[ndx], fence_handle)?;
        } else {
            signal_semaphore(device, semaphore, values[ndx])?;
        }
    }

    let last = raw[raw.len() - 1];
    let target = values[values.len() - 1];
    let start = std::time::Instant::now();
    loop {
        let value = semaphore_counter_value(device, last)?;
        if value == target {
            if signal_from_device {
                unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
            }
            unsafe { device.device_wait_idle() }.vk_check("vkDeviceWaitIdle")?;
            return Ok(TestStatus::pass("Poll on timeline value succeeded"));
        }
        if value > target {
            return Ok(TestStatus::fail("Timeline value greater than expected"));
        }
        if start.elapsed() > std::time::Duration::from_secs(1) {
            return Ok(TestStatus::fail("Timeline value polling timed out"));
        }
    }
}

/// `initialValueCase` - a timeline semaphore created with a non-zero initial value
/// reports it immediately, and a wait for that value is satisfied without any signal.
fn timeline_initial_value(context: &Context<'_>, sync: SyncType) -> Result<TestStatus, TestError> {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let max_difference = max_timeline_semaphore_value_difference(context);
    let mut rng = Random::new(1234);
    let non_zero_value = 1 + rng.get_uint64() % (max_difference - 1);

    let default_value = create_timeline_semaphore(device)?;
    let initial_value = create_timeline_semaphore_with_value(device, non_zero_value)?;

    if wait_semaphores_status(device, &[*default_value], &[0], false, 0)? != vk::SuccessCode::SUCCESS {
        return Ok(TestStatus::fail("Wait zero initial value failed"));
    }

    // A submit that waits on the value the semaphore already has must not block.
    if sync == SyncType::Synchronization2 {
        use vulkanalia::vk::KhrSynchronization2ExtensionDeviceCommands;
        let waits = [semaphore_submit_info(
            *default_value,
            0,
            vk::PipelineStageFlags2::TOP_OF_PIPE,
        )];
        let submit = vk::SubmitInfo2 {
            s_type: vk::StructureType::SUBMIT_INFO_2,
            next: std::ptr::null(),
            flags: vk::SubmitFlags::empty(),
            wait_semaphore_info_count: 1,
            wait_semaphore_infos: waits.as_ptr(),
            command_buffer_info_count: 0,
            command_buffer_infos: std::ptr::null(),
            signal_semaphore_info_count: 0,
            signal_semaphore_infos: std::ptr::null(),
        };
        unsafe { device.queue_submit2_khr(queue, &[submit], vk::Fence::null()) }.vk_check("vkQueueSubmit2KHR")?;
    } else {
        let semaphores = [*default_value];
        let wait_values = [0u64];
        let stages = [vk::PipelineStageFlags::TOP_OF_PIPE];
        let mut timeline = vk::TimelineSemaphoreSubmitInfo::builder().wait_semaphore_values(&wait_values);
        let submit = vk::SubmitInfo::builder()
            .wait_semaphores(&semaphores)
            .wait_dst_stage_mask(&stages)
            .push_next(&mut timeline);
        unsafe { device.queue_submit(queue, &[submit], vk::Fence::null()) }.vk_check("vkQueueSubmit")?;
    }
    unsafe { device.device_wait_idle() }.vk_check("vkDeviceWaitIdle")?;

    if semaphore_counter_value(device, *default_value)? != 0 {
        return Ok(TestStatus::fail("Invalid zero initial value"));
    }

    if wait_semaphores_status(device, &[*initial_value], &[non_zero_value], false, 0)? != vk::SuccessCode::SUCCESS {
        return Ok(TestStatus::fail("Wait non zero initial value failed"));
    }
    if semaphore_counter_value(device, *initial_value)? != non_zero_value {
        return Ok(TestStatus::fail("Invalid non zero initial value"));
    }

    if max_difference != u64::MAX {
        let non_zero_max = max_difference + 1;
        let max_value = create_timeline_semaphore_with_value(device, non_zero_max)?;
        if wait_semaphores_status(device, &[*max_value], &[non_zero_max], false, 0)? != vk::SuccessCode::SUCCESS {
            return Ok(TestStatus::fail("Wait max value failed"));
        }
        if semaphore_counter_value(device, *max_value)? != non_zero_max {
            return Ok(TestStatus::fail("Invalid max value initial value"));
        }
    }

    Ok(TestStatus::pass("Initial value correct"))
}

/// `getMaxTimelineSemaphoreValueDifference`
fn max_timeline_semaphore_value_difference(context: &Context<'_>) -> u64 {
    let mut timeline = vk::PhysicalDeviceTimelineSemaphoreProperties::default();
    let mut properties = vk::PhysicalDeviceProperties2::builder()
        .push_next(&mut timeline)
        .build();
    unsafe {
        (context.get_instance().commands().get_physical_device_properties2)(
            context.get_physical_device(),
            &mut properties,
        );
    }
    timeline.max_timeline_semaphore_value_difference
}

/// `maxDifferenceValueCase`: queue device signals close to the edges of maxTimelineSemaphoreValueDifference and verify that the value of the
/// semaphore never goes backwards, with `MonotonicallyIncrementChecker` polling it from a thread of its own.
fn timeline_max_difference_value(context: &Context<'_>, sync: SyncType) -> Result<TestStatus, TestError> {
    use std::sync::atomic::{AtomicBool, Ordering};

    let device = context.get_device();
    let queue = context.get_universal_queue();
    let required_min_value_difference = 0x7FFF_FFFFu64;
    let max_timeline_value_difference = max_timeline_semaphore_value_difference(context);
    let semaphore = create_timeline_semaphore(device)?;
    let fence = unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?;
    let fence = Unique::new(device, fence);

    if max_timeline_value_difference < required_min_value_difference {
        return Ok(TestStatus::fail("Timeline semaphore max value difference test failed"));
    }

    let iterations = (u64::MAX / max_timeline_value_difference).min(100);
    log::info!(
        " maxTimelineSemaphoreValueDifference={max_timeline_value_difference} maxExpected={required_min_value_difference} iterations={iterations}"
    );

    let running = AtomicBool::new(true);
    let semaphore_handle = *semaphore;
    std::thread::scope(|scope| {
        let checker = scope.spawn(|| -> Result<TestStatus, TestError> {
            let mut last_value = 0u64;
            while running.load(Ordering::Relaxed) {
                let value = semaphore_counter_value(device, semaphore_handle)?;
                if value < last_value {
                    return Ok(TestStatus::fail("Value not monotonically increasing"));
                }
                last_value = value;
                std::thread::yield_now();
            }
            Ok(TestStatus::pass("Value monotonically increasing"))
        });

        let driver = || -> Result<(), TestError> {
            let mut timeline_back_value = 1u64;
            let mut timeline_front_value = 1u64;
            signal_semaphore(device, semaphore_handle, timeline_front_value)?;

            for _ in 0..iterations {
                for _ in 1..=10 {
                    timeline_front_value += 1;
                    device_signal(
                        device,
                        queue,
                        sync,
                        semaphore_handle,
                        timeline_front_value,
                        vk::Fence::null(),
                    )?;
                }

                timeline_front_value = timeline_back_value
                    .wrapping_add(max_timeline_value_difference)
                    .wrapping_sub(10);
                let fence_value = timeline_front_value;
                device_signal(device, queue, sync, semaphore_handle, fence_value, *fence)?;
                for _ in 1..10 {
                    timeline_front_value = timeline_front_value.wrapping_add(1);
                    device_signal(
                        device,
                        queue,
                        sync,
                        semaphore_handle,
                        timeline_front_value,
                        vk::Fence::null(),
                    )?;
                }

                semaphore_counter_value(device, semaphore_handle)?;

                unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
                unsafe { device.reset_fences(&[*fence]) }.vk_check("vkResetFences")?;

                timeline_back_value = fence_value;
            }

            unsafe { device.device_wait_idle() }.vk_check("vkDeviceWaitIdle")?;
            Ok(())
        };
        let result = driver();

        running.store(false, Ordering::Relaxed);
        let status = checker.join().expect("the checker thread does not panic");
        result?;
        status
    })
}

/// `ignoreTimelineSemaphoreSubmitInfoRun`
fn timeline_ignore_semaphore_info_run(context: &Context<'_>) -> Result<TestStatus, TestError> {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();
    let data_size = std::mem::size_of::<u32>() as u32;
    let semaphore_set_size = 64usize;
    let shader_stages = vk::ShaderStageFlags::COMPUTE;

    let set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, shader_stages)
        .build(device)?;
    let pc_range = vk::PushConstantRange {
        stage_flags: shader_stages,
        offset: 0,
        size: data_size,
    };
    let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*set_layout], &[pc_range])?;

    let binaries = context.get_binary_collection();
    let comp_shader = create_shader_module(device, binaries.get("comp")?)?;
    let stage = vk::PipelineShaderStageCreateInfo {
        stage: shader_stages,
        module: *comp_shader,
        name: c"main".as_ptr(),
        ..Default::default()
    };
    let pipeline_info = vk::ComputePipelineCreateInfo {
        stage,
        layout: *pipeline_layout,
        base_pipeline_index: -1,
        ..Default::default()
    };
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
        .vk_check("vkCreateComputePipelines")?;
    let pipeline = Unique::new(device, pipelines.0[0]);

    // Output buffer.
    let buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(data_size as vk::DeviceSize, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    // Descriptor pool and set.
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
    let buffer_desc_info = make_descriptor_buffer_info(buffer.get(), 0, vk::WHOLE_SIZE);
    DescriptorSetUpdateBuilder::new()
        .write_single(
            descriptor_set.get(),
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &buffer_desc_info,
        )
        .update(device);

    // Create multiple semaphores to wait on, and multiple semaphores to signal. None of them are timeline semaphores.
    let create_binary = || -> Result<Unique<'_, vk::Semaphore>, TestError> {
        let semaphore = unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
            .vk_check("vkCreateSemaphore")?;
        Ok(Unique::new(device, semaphore))
    };
    let wait_semaphores = (0..semaphore_set_size)
        .map(|_| create_binary())
        .collect::<Result<Vec<_>, _>>()?;
    let signal_semaphores = (0..semaphore_set_size)
        .map(|_| create_binary())
        .collect::<Result<Vec<_>, _>>()?;
    let wait_handles: Vec<vk::Semaphore> = wait_semaphores.iter().map(|s| **s).collect();
    let signal_handles: Vec<vk::Semaphore> = signal_semaphores.iter().map(|s| **s).collect();

    let submit_and_wait = |submit: vk::SubmitInfo| -> Result<(), TestError> {
        let fence = unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?;
        let fence = Unique::new(device, fence);
        unsafe { device.queue_submit(queue, &[submit], *fence) }.vk_check("vkQueueSubmit")?;
        unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
        Ok(())
    };

    // The semaphores to be waited on should be signaled.
    submit_and_wait(vk::SubmitInfo::builder().signal_semaphores(&wait_handles).build())?;

    // Main job.
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = cmd_buffer.get();

    let pc_value = 777u32;
    begin_command_buffer(device, cmd)?;
    unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::COMPUTE,
            *pipeline_layout,
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );
        device.cmd_push_constants(cmd, *pipeline_layout, shader_stages, 0, &pc_value.to_ne_bytes());
        device.cmd_dispatch(cmd, 1, 1, 1);
        let barrier = vk::MemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::SHADER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ);
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(device, cmd)?;

    // Submit the previous work with unneeded VkTimelineSemaphoreSubmitInfo, where the arrays referenced by it will not have matching counts with
    // VkSubmitInfo, and are smaller, to make sure the driver ignores the struct instead of reading beyond the end of the arrays. See
    // VUID-VkSubmitInfo-pNext-03240 and others in the spec (VUIDs from 1.4.326).
    let wait_stages = vec![vk::PipelineStageFlags::COMPUTE_SHADER; wait_handles.len()];

    // To see if the implementation tries to access the values array beyond the end, a large chunk of memory holds the real value at its end, so
    // chances are that a read beyond it fails or causes a segfault.
    const VALUES_VECTOR_COUNT: usize = 1_000_000;
    let mut wait_values = vec![0u64; VALUES_VECTOR_COUNT];
    let mut signal_values = vec![0u64; VALUES_VECTOR_COUNT];
    *wait_values.last_mut().expect("not empty") = 1000;
    *signal_values.last_mut().expect("not empty") = 2000;

    let timeline_info = vk::TimelineSemaphoreSubmitInfo {
        wait_semaphore_value_count: 1,
        wait_semaphore_values: wait_values.last().expect("not empty"),
        signal_semaphore_value_count: 1,
        signal_semaphore_values: signal_values.last().expect("not empty"),
        ..Default::default()
    };
    let command_buffers = [cmd];
    let submit_info = vk::SubmitInfo {
        next: (&timeline_info as *const vk::TimelineSemaphoreSubmitInfo).cast(),
        wait_semaphore_count: wait_handles.len() as u32,
        wait_semaphores: wait_handles.as_ptr(),
        wait_dst_stage_mask: wait_stages.as_ptr(),
        command_buffer_count: 1,
        command_buffers: command_buffers.as_ptr(),
        signal_semaphore_count: signal_handles.len() as u32,
        signal_semaphores: signal_handles.as_ptr(),
        ..Default::default()
    };
    submit_and_wait(submit_info)?;

    // Let's wait for the signaled semaphores.
    let top_of_pipe = vec![vk::PipelineStageFlags::TOP_OF_PIPE; signal_handles.len()];
    submit_and_wait(
        vk::SubmitInfo::builder()
            .wait_semaphores(&signal_handles)
            .wait_dst_stage_mask(&top_of_pipe)
            .build(),
    )?;

    // Check buffer contents and finish.
    invalidate_alloc(device, buffer.get_allocation())?;
    let output_value = unsafe { std::ptr::read_unaligned(buffer.get_allocation().get_host_ptr().cast::<u32>()) };
    if output_value != pc_value {
        return Err(TestError::Fail(format!(
            "Unexpected value found in output buffer: expected {pc_value} but found {output_value}"
        )));
    }

    Ok(TestStatus::pass("Pass"))
}

struct IgnoreTimelineInfoCase;

impl TestCase for IgnoreTimelineInfoCase {
    fn name(&self) -> &str {
        "ignore_timeline_semaphore_info"
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_timeline_semaphore")
    }

    fn programs(&self) -> BinaryCollection {
        IGNORE_TIMELINE_SEMAPHORE_INFO.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(IgnoreTimelineInfoInstance { context })
    }
}

struct IgnoreTimelineInfoInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for IgnoreTimelineInfoInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        timeline_ignore_semaphore_info_run(self.context)
    }
}

/// A `wait` or `misc` case: a plain function of the context and the synchronization
/// type, with nothing to build.
struct TimelineFunctionCase {
    name: &'static str,
    sync_type: SyncType,
    run: fn(&Context<'_>, SyncType) -> Result<TestStatus, TestError>,
}

impl TestCase for TimelineFunctionCase {
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
        Box::new(TimelineFunctionInstance {
            context,
            sync_type: self.sync_type,
            run: self.run,
        })
    }
}

struct TimelineFunctionInstance<'a> {
    context: &'a Context<'a>,
    sync_type: SyncType,
    run: fn(&Context<'_>, SyncType) -> Result<TestStatus, TestError>,
}

impl TestInstance for TimelineFunctionInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        (self.run)(self.context, self.sync_type)
    }
}

fn wait_all_signal_from_device(context: &Context<'_>, sync: SyncType) -> Result<TestStatus, TestError> {
    timeline_wait(context, sync, true, true)
}
fn wait_one_signal_from_device(context: &Context<'_>, sync: SyncType) -> Result<TestStatus, TestError> {
    timeline_wait(context, sync, false, true)
}
fn wait_all_signal_from_host(context: &Context<'_>, sync: SyncType) -> Result<TestStatus, TestError> {
    timeline_wait(context, sync, true, false)
}
fn wait_one_signal_from_host(context: &Context<'_>, sync: SyncType) -> Result<TestStatus, TestError> {
    timeline_wait(context, sync, false, false)
}
fn poll_signal_from_device(context: &Context<'_>, _sync: SyncType) -> Result<TestStatus, TestError> {
    timeline_poll(context, true)
}
fn poll_signal_from_host(context: &Context<'_>, _sync: SyncType) -> Result<TestStatus, TestError> {
    timeline_poll(context, false)
}

/// `DeviceHostTestsBase::initCommonTests`
pub fn create_timeline_semaphore_tests(sync_type: SyncType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("timeline_semaphore");
    let mut device_host = TestCaseGroup::new("device_host");

    for &write_op in DEVICE_HOST_WRITE_OPS {
        for &read_op in DEVICE_HOST_READ_OPS {
            let mut op_group = TestCaseGroup::new(format!("{}_{}", write_op.as_str(), read_op.as_str()));
            let mut empty = true;

            for resource in RESOURCES {
                if !write_op.supports_resource(resource) || !read_op.supports_resource(resource) {
                    continue;
                }
                op_group.add_child(Box::new(DeviceHostTestCase {
                    name: get_resource_name(resource),
                    sync_type,
                    resource: *resource,
                    write_op,
                    read_op,
                }) as Box<dyn TestCase>);
                empty = false;
            }

            if !empty {
                device_host.add_child(op_group);
            }
        }
    }

    // `LegacyDeviceHostTests::init`'s misc group; upstream registers `initial_value`
    // only under the legacy tree.
    {
        let mut misc = TestCaseGroup::new("misc");
        misc.add_child(Box::new(TimelineFunctionCase {
            name: "max_difference_value",
            sync_type,
            run: timeline_max_difference_value,
        }) as Box<dyn TestCase>);
        if sync_type == SyncType::Legacy {
            misc.add_child(Box::new(TimelineFunctionCase {
                name: "initial_value",
                sync_type,
                run: timeline_initial_value,
            }) as Box<dyn TestCase>);
        }
        device_host.add_child(misc);
    }

    group.add_child(device_host);

    let mut wait = TestCaseGroup::new("wait");
    for (name, run) in [
        (
            "all_signal_from_device",
            wait_all_signal_from_device as fn(&Context<'_>, SyncType) -> Result<TestStatus, TestError>,
        ),
        ("one_signal_from_device", wait_one_signal_from_device),
        ("all_signal_from_host", wait_all_signal_from_host),
        ("one_signal_from_host", wait_one_signal_from_host),
        ("host_wait_before_signal", timeline_host_wait_before_signal),
        ("poll_signal_from_device", poll_signal_from_device),
        ("poll_signal_from_host", poll_signal_from_host),
    ] {
        wait.add_child(Box::new(TimelineFunctionCase { name, sync_type, run }) as Box<dyn TestCase>);
    }
    group.add_child(wait);

    // `WaitBeforeSignalTests` / `OneToNTests` - the two subgroups that spread the chain
    // across every queue, so they live in their own module.
    use super::timeline_queue_tests::{TimelineQueueKind, create_timeline_queue_tests};
    group.add_child(create_timeline_queue_tests(
        TimelineQueueKind::WaitBeforeSignal,
        sync_type,
    ));
    group.add_child(create_timeline_queue_tests(TimelineQueueKind::OneToN, sync_type));

    // `SparseBindGroup`: only the legacy synchronization variant has it
    if matches!(sync_type, SyncType::Legacy) {
        group.add_child(super::timeline_sparse_bind_tests::create_sparse_bind_group());

        let mut misc = TestCaseGroup::new("misc");
        misc.add_child(Box::new(IgnoreTimelineInfoCase) as Box<dyn TestCase>);
        group.add_child(misc);
    }

    group
}
