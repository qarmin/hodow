// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationSignalOrderTests.cpp
//   (QueueSubmitSignalOrderSharedTestInstance / TestCase / Tests)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The `shared_binary_semaphore` and `shared_timeline_semaphore` groups: the signal-order test of `signal_order_tests.rs`, but the
// reads run on a device of a second instance (so two queues exist even on an implementation with a single one). Twelve resources
// are exported from the default device and imported on the other; the writes signal their own semaphores in one submit, the last
// of them is exported, and a single read submit on the second device waits only on that one.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, InstanceV1_1};

use super::cross_instance_sharing_tests::{
    IdleGuard, SemaphoreOp, ShareSpec, create_exported_resource, cross_instances, import_resource, submit,
};
use super::operation::{
    Operation, OperationName, RESOURCES, Resource, ResourceDescription, ResourceType, SyncType, build_operation,
    cmd_pipeline_barrier, first_difference, get_resource_name, make_buffer_memory_barrier2, make_image_memory_barrier2,
};
use super::signal_order_tests::{SIGNAL_ORDER_READ_OPS, SIGNAL_ORDER_WRITE_OPS, SemaphoreType};
use crate::tcu::{Random, TestError, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::tests::util::external_memory_util::{
    NativeHandle, create_exportable_semaphore_type, create_semaphore_type, external_semaphore_type_name,
    get_memory_native, get_semaphore_native, import_semaphore,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `iterations(12)`
const ITERATION_COUNT: usize = 12;

/// `exportCases` - only semaphore handle types with reference semantics are valid here, which leaves the opaque ones.
struct ExportCase {
    memory_type: vk::ExternalMemoryHandleTypeFlags,
    semaphore_type: vk::ExternalSemaphoreHandleTypeFlags,
}

const EXPORT_CASES: &[ExportCase] = &[
    ExportCase {
        memory_type: vk::ExternalMemoryHandleTypeFlags::OPAQUE_FD,
        semaphore_type: vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_FD,
    },
    ExportCase {
        memory_type: vk::ExternalMemoryHandleTypeFlags::OPAQUE_WIN32_KMT,
        semaphore_type: vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_WIN32_KMT,
    },
    ExportCase {
        memory_type: vk::ExternalMemoryHandleTypeFlags::OPAQUE_WIN32,
        semaphore_type: vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_WIN32,
    },
];

fn vk_semaphore_type(semaphore_type: SemaphoreType) -> vk::SemaphoreType {
    match semaphore_type {
        SemaphoreType::Binary => vk::SemaphoreType::BINARY,
        SemaphoreType::Timeline => vk::SemaphoreType::TIMELINE,
    }
}

/// `getInResourceUsageFlags` for whichever kind of operation this is.
fn in_usage(op: OperationName, resource: &ResourceDescription) -> u32 {
    if op.is_copy() {
        op.copy_resource_usage().0
    } else {
        op.in_resource_usage(resource)
    }
}

/// `getOutResourceUsageFlags` for whichever kind of operation this is.
fn out_usage(op: OperationName, resource: &ResourceDescription) -> u32 {
    if op.is_copy() {
        op.copy_resource_usage().1
    } else {
        op.out_resource_usage(resource)
    }
}

/// `QueueSubmitSignalOrderSharedTestCase`
pub struct SignalOrderSharedTestCase {
    name: String,
    sync_type: SyncType,
    resource: ResourceDescription,
    write_op: OperationName,
    read_op: OperationName,
    memory_handle_type: vk::ExternalMemoryHandleTypeFlags,
    semaphore_type: SemaphoreType,
    semaphore_handle_type: vk::ExternalSemaphoreHandleTypeFlags,
}

impl SignalOrderSharedTestCase {
    fn resource_usage(&self) -> u32 {
        in_usage(self.read_op, &self.resource) | out_usage(self.write_op, &self.resource)
    }

    /// `isResourceExportable`
    fn is_resource_exportable(&self, context: &Context<'_>) -> Result<bool, TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let usage = self.resource_usage();

        if self.resource.kind == ResourceType::Image {
            let mut external_info =
                vk::PhysicalDeviceExternalImageFormatInfo::builder().handle_type(self.memory_handle_type);
            let image_format_info = vk::PhysicalDeviceImageFormatInfo2::builder()
                .push_next(&mut external_info)
                .format(self.resource.image_format)
                .type_(self.resource.image_type)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(vk::ImageUsageFlags::from_bits_truncate(usage))
                .flags(vk::ImageCreateFlags::empty());
            let mut external_properties = vk::ExternalImageFormatProperties::default();
            {
                let mut format_properties = vk::ImageFormatProperties2::builder().push_next(&mut external_properties);
                match unsafe {
                    instance.get_physical_device_image_format_properties2(
                        physical_device,
                        &image_format_info,
                        &mut format_properties,
                    )
                } {
                    Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => return Ok(false),
                    result => result.vk_check("vkGetPhysicalDeviceImageFormatProperties2")?,
                }
            }
            let features = external_properties.external_memory_properties.external_memory_features;
            Ok(features.contains(vk::ExternalMemoryFeatureFlags::EXPORTABLE)
                && features.contains(vk::ExternalMemoryFeatureFlags::IMPORTABLE))
        } else {
            let info = vk::PhysicalDeviceExternalBufferInfo::builder()
                .flags(vk::BufferCreateFlags::empty())
                .usage(vk::BufferUsageFlags::from_bits_truncate(usage))
                .handle_type(self.memory_handle_type);
            let mut properties = vk::ExternalBufferProperties::default();
            unsafe { instance.get_physical_device_external_buffer_properties(physical_device, &info, &mut properties) };
            let features = properties.external_memory_properties.external_memory_features;
            Ok(features.contains(vk::ExternalMemoryFeatureFlags::EXPORTABLE)
                && features.contains(vk::ExternalMemoryFeatureFlags::IMPORTABLE))
        }
    }
}

impl TestCase for SignalOrderSharedTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.semaphore_type == SemaphoreType::Timeline {
            context.require_device_functionality("VK_KHR_timeline_semaphore")?;
        }

        if self.semaphore_handle_type == vk::ExternalSemaphoreHandleTypeFlags::SYNC_FD
            || self.semaphore_handle_type == vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_FD
        {
            context.require_device_functionality("VK_KHR_external_semaphore_fd")?;
            context.require_device_functionality("VK_KHR_external_memory_fd")?;
        }

        if self.semaphore_handle_type == vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_WIN32
            || self.semaphore_handle_type == vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_WIN32_KMT
        {
            context.require_device_functionality("VK_KHR_external_semaphore_win32")?;
            context.require_device_functionality("VK_KHR_external_memory_win32")?;
        }

        if self.sync_type == SyncType::Synchronization2 {
            context.require_device_functionality("VK_KHR_synchronization2")?;
        }

        let mut semaphore_type_info = vk::SemaphoreTypeCreateInfo::builder()
            .semaphore_type(vk_semaphore_type(self.semaphore_type))
            .initial_value(0);
        let info = vk::PhysicalDeviceExternalSemaphoreInfo::builder()
            .push_next(&mut semaphore_type_info)
            .handle_type(self.semaphore_handle_type);
        let mut properties = vk::ExternalSemaphoreProperties::default();
        unsafe {
            context
                .get_instance()
                .get_physical_device_external_semaphore_properties(
                    context.get_physical_device(),
                    &info,
                    &mut properties,
                )
        };

        let features = properties.external_semaphore_features;
        if !features.contains(vk::ExternalSemaphoreFeatureFlags::EXPORTABLE)
            || !features.contains(vk::ExternalSemaphoreFeatureFlags::IMPORTABLE)
        {
            return Err(TestError::NotSupported(
                "Exporting and importing semaphore type not supported".to_string(),
            ));
        }

        if !self.is_resource_exportable(context)? {
            return Err(TestError::NotSupported("Resource not exportable".to_string()));
        }

        self.write_op.check_support(context, &self.resource)?;
        self.read_op.check_support(context, &self.resource)?;
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SignalOrderSharedTestInstance { context, params: self })
    }
}

/// `QueueSubmitOrderSharedIteration` - the operations are declared first so they are dropped before the resources they point at.
struct Iteration<'a, 'b> {
    write_op: Box<dyn Operation + 'a>,
    read_op: Box<dyn Operation + 'b>,
    resource_a: Resource<'a>,
    _resource_b: Resource<'b>,
}

struct SignalOrderSharedTestInstance<'a> {
    context: &'a Context<'a>,
    params: &'a SignalOrderSharedTestCase,
}

/// `addSemaphore` - one more write (or read) signal. A timeline case allocates one exportable semaphore once and every call after
/// that advances its value; a binary one allocates a semaphore per call, exportable only when asked.
#[allow(clippy::too_many_arguments)]
fn add_semaphore<'a>(
    device: &'a Device,
    semaphores: &mut Vec<Unique<'a, vk::Semaphore>>,
    handles: &mut Vec<vk::Semaphore>,
    values: &mut Vec<u64>,
    exportable: bool,
    first_timeline_value: u64,
    semaphore_type: SemaphoreType,
    handle_type: vk::ExternalSemaphoreHandleTypeFlags,
    rng: &mut Random,
) -> Result<(), TestError> {
    let vk_type = vk_semaphore_type(semaphore_type);
    if semaphore_type == SemaphoreType::Timeline {
        if semaphores.is_empty() {
            semaphores.push(create_exportable_semaphore_type(device, vk_type, handle_type)?);
        }
    } else if exportable {
        semaphores.push(create_exportable_semaphore_type(device, vk_type, handle_type)?);
    } else {
        semaphores.push(create_semaphore_type(device, vk_type)?);
    }

    handles.push(*semaphores[semaphores.len() - 1]);
    let base = values.last().copied().unwrap_or(first_timeline_value);
    values.push(base + rng.get_int(1, 100) as u64);
    Ok(())
}

/// `hostSignal`
fn host_signal(device: &Device, semaphore: vk::Semaphore, value: u64) -> Result<(), TestError> {
    let info = vk::SemaphoreSignalInfo::builder().semaphore(semaphore).value(value);
    unsafe { device.signal_semaphore(&info) }.vk_check("vkSignalSemaphore")
}

impl TestInstance for SignalOrderSharedTestInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        let p = self.params;
        let sync = p.sync_type;
        let is_timeline = p.semaphore_type == SemaphoreType::Timeline;
        let mut rng = Random::new(1234);

        // Two devices, so there are two queues even on an implementation that only has one.
        let instances = cross_instances(self.context)?;
        let other = &instances.b;
        let device_a = self.context.get_device();
        let device_b = other.queues.device();
        let allocator_a = self.context.get_default_allocator();
        let allocator_b = other.queues.allocator();
        let universal_queue_family_index = self.context.get_universal_queue_family_index();
        let queue_a = self.context.get_universal_queue();
        let family_b = other
            .queues
            .families()
            .iter()
            .find(|f| f.family_index == universal_queue_family_index)
            .ok_or_else(|| {
                TestError::NotSupported("The second device has no queue of the universal family".to_string())
            })?;
        let queue_b = family_b.queues[0];

        let fence_b = Unique::new(
            device_b,
            unsafe { device_b.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
        );
        let pool_a = make_command_pool(device_a, universal_queue_family_index)?;
        let pool_b = make_command_pool(device_b, universal_queue_family_index)?;

        let mut iterations: Vec<Iteration<'_, '_>> = Vec::with_capacity(ITERATION_COUNT);
        let mut cmd_buffers_a: Vec<UniqueCommandBuffer<'_>> = Vec::with_capacity(ITERATION_COUNT);
        let mut semaphores_a: Vec<Unique<'_, vk::Semaphore>> = Vec::new();
        let mut semaphores_b: Vec<Unique<'_, vk::Semaphore>> = Vec::new();
        let mut handles_a: Vec<vk::Semaphore> = Vec::new();
        let mut handles_b: Vec<vk::Semaphore> = Vec::new();
        let mut values_a: Vec<u64> = Vec::new();
        let mut values_b: Vec<u64> = Vec::new();
        let mut stage_bits: Vec<vk::PipelineStageFlags2> = Vec::with_capacity(ITERATION_COUNT);

        // These guards wait for the devices to be idle before the resources above are torn down.
        let _idle_guard_a = IdleGuard(device_a);
        let _idle_guard_b = IdleGuard(device_b);

        let spec = ShareSpec {
            resource: &p.resource,
            usage: p.resource_usage(),
            handle_type: p.memory_handle_type,
            dedicated: false,
        };
        let family_indices = [universal_queue_family_index];

        // A dozen sets of write/read operations.
        for _ in 0..ITERATION_COUNT {
            let (resource_a, memory_type_index) = create_exported_resource(device_a, &spec, &family_indices)?;
            let mut native_memory_handle = get_memory_native(device_a, resource_a.memory(), p.memory_handle_type)?;
            let resource_b = import_resource(
                device_b,
                &spec,
                &family_indices,
                &mut native_memory_handle,
                memory_type_index,
            )?;

            let write_op = build_operation(device_a, allocator_a, p.write_op, &p.resource, &resource_a, false)?;
            let read_op = build_operation(device_b, allocator_b, p.read_op, &p.resource, &resource_b, false)?;
            iterations.push(Iteration {
                write_op,
                read_op,
                resource_a,
                _resource_b: resource_b,
            });
        }

        // Each write operation goes into its own command buffer.
        for (ndx, iteration) in iterations.iter().enumerate() {
            let cmd = allocate_command_buffer(device_a, *pool_a, vk::CommandBufferLevel::PRIMARY)?;
            begin_command_buffer(device_a, *cmd)?;
            iteration.write_op.record_commands(device_a, sync, *cmd);

            let write_sync = iteration.write_op.out_sync_info(sync);
            let read_sync = iteration.read_op.in_sync_info(sync);
            if p.resource.kind == ResourceType::Image {
                let image = iteration.resource_a.image();
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
                cmd_pipeline_barrier(device_a, sync, *cmd, &[], &[barrier]);
            } else {
                let buffer = iteration.resource_a.buffer();
                let barrier = make_buffer_memory_barrier2(
                    write_sync.stage_mask,
                    write_sync.access_mask,
                    read_sync.stage_mask,
                    read_sync.access_mask,
                    buffer.handle,
                    0,
                    vk::WHOLE_SIZE,
                );
                cmd_pipeline_barrier(device_a, sync, *cmd, &[barrier], &[]);
            }
            stage_bits.push(write_sync.stage_mask);

            end_command_buffer(device_a, *cmd)?;
            cmd_buffers_a.push(cmd);

            add_semaphore(
                device_a,
                &mut semaphores_a,
                &mut handles_a,
                &mut values_a,
                ndx == ITERATION_COUNT - 1,
                2,
                p.semaphore_type,
                p.semaphore_handle_type,
                &mut rng,
            )?;
        }

        // All the reads go into one command buffer, and the union of their stages is what the read submit waits at.
        let mut read_stages = vk::PipelineStageFlags2::empty();
        let cmd_b = allocate_command_buffer(device_b, *pool_b, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device_b, *cmd_b)?;
        for iteration in &iterations {
            read_stages |= iteration.read_op.in_sync_info(sync).stage_mask;
            iteration.read_op.record_commands(device_b, sync, *cmd_b);
        }
        end_command_buffer(device_b, *cmd_b)?;

        // The last semaphore is exported to the second device, and another one is created there to signal.
        {
            let last_semaphore_a = handles_a[handles_a.len() - 1];
            let last_value_a = values_a[values_a.len() - 1];

            add_semaphore(
                device_b,
                &mut semaphores_b,
                &mut handles_b,
                &mut values_b,
                true,
                last_value_a,
                p.semaphore_type,
                p.semaphore_handle_type,
                &mut rng,
            )?;

            let mut native_semaphore_handle: NativeHandle =
                get_semaphore_native(device_a, last_semaphore_a, p.semaphore_handle_type)?;
            import_semaphore(
                device_b,
                handles_b[handles_b.len() - 1],
                p.semaphore_handle_type,
                &mut native_semaphore_handle,
                vk::SemaphoreImportFlags::empty(),
            )?;

            add_semaphore(
                device_b,
                &mut semaphores_b,
                &mut handles_b,
                &mut values_b,
                false,
                last_value_a,
                p.semaphore_type,
                p.semaphore_handle_type,
                &mut rng,
            )?;
        }

        // The writes, each in its own submit info: with binary semaphores they wait on nothing, with timeline ones on a host signal
        // done below.
        for (ndx, cmd) in cmd_buffers_a.iter().enumerate() {
            let wait = is_timeline.then(|| SemaphoreOp {
                semaphore: handles_a[0],
                value: 1,
                stage: stage_bits[ndx],
            });
            let signal = SemaphoreOp {
                semaphore: handles_a[ndx],
                value: values_a[ndx],
                stage: vk::PipelineStageFlags2::BOTTOM_OF_PIPE,
            };
            submit(
                device_a,
                sync,
                is_timeline,
                queue_a,
                **cmd,
                wait,
                Some(signal),
                vk::Fence::null(),
            )?;
        }

        // The reads wait only on the last write; the ordering of signal operations has to guarantee that all the writes before it
        // have completed by then.
        {
            let wait = SemaphoreOp {
                semaphore: handles_b[0],
                value: values_a[values_a.len() - 1],
                stage: read_stages,
            };
            let signal = SemaphoreOp {
                semaphore: handles_b[handles_b.len() - 1],
                value: values_b[values_b.len() - 1],
                stage: vk::PipelineStageFlags2::BOTTOM_OF_PIPE,
            };
            submit(
                device_b,
                sync,
                is_timeline,
                queue_b,
                *cmd_b,
                Some(wait),
                Some(signal),
                *fence_b,
            )?;

            if is_timeline {
                // Unblock the whole lot.
                host_signal(device_a, handles_a[0], 2)?;

                let semaphores = [handles_b[handles_b.len() - 1]];
                let values = [values_b[values_b.len() - 1]];
                let wait_info = vk::SemaphoreWaitInfo::builder().semaphores(&semaphores).values(&values);
                unsafe { device_b.wait_semaphores(&wait_info, u64::MAX) }.vk_check("vkWaitSemaphores")?;
            } else {
                unsafe { device_b.wait_for_fences(&[*fence_b], true, u64::MAX) }.vk_check("vkWaitForFences")?;
            }
        }

        for (ndx, iteration) in iterations.iter().enumerate() {
            let expected = iteration.write_op.data(device_a)?;
            let actual = iteration.read_op.data(device_b)?;

            if iteration.resource_a.kind.is_indirect_buffer() {
                let expected_value = u32::from_ne_bytes(expected[0..4].try_into().expect("at least 4 bytes"));
                let actual_value = u32::from_ne_bytes(actual[0..4].try_into().expect("at least 4 bytes"));
                if actual_value < expected_value {
                    return Ok(TestStatus::fail("Counter value is smaller than expected"));
                }
            } else if let Some(at) = first_difference(&expected, &actual) {
                return Ok(TestStatus::fail(format!(
                    "Memory contents don't match: iteration {ndx}, first difference at byte {at}"
                )));
            }
        }

        Ok(TestStatus::pass("Success"))
    }
}

/// `QueueSubmitSignalOrderSharedTests`
pub fn create_signal_order_shared_tests(sync_type: SyncType, semaphore_type: SemaphoreType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(format!("shared_{}", semaphore_type.group_name()));

    for &write_op in SIGNAL_ORDER_WRITE_OPS {
        for &read_op in SIGNAL_ORDER_READ_OPS {
            let mut op_group = TestCaseGroup::new(format!("{}_{}", write_op.as_str(), read_op.as_str()));
            let mut empty = true;

            for resource in RESOURCES {
                if !write_op.supports_resource(resource) || !read_op.supports_resource(resource) {
                    continue;
                }
                for export_case in EXPORT_CASES {
                    op_group.add_child(Box::new(SignalOrderSharedTestCase {
                        name: format!(
                            "{}_{}",
                            get_resource_name(resource),
                            external_semaphore_type_name(export_case.semaphore_type)
                        ),
                        sync_type,
                        resource: *resource,
                        write_op,
                        read_op,
                        memory_handle_type: export_case.memory_type,
                        semaphore_type,
                        semaphore_handle_type: export_case.semaphore_type,
                    }) as Box<dyn TestCase>);
                    empty = false;
                }
            }

            if !empty {
                group.add_child(op_group);
            }
        }
    }

    group
}
