// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationCrossInstanceSharingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// A resource and a semaphore are created on one instance's device, exported through an external handle, imported into a second
// instance's device, and the write operation on the first is ordered before the read operation on the second by the shared
// semaphore. Every pair of queue families is tried; a pair one of the two operations cannot run on is skipped, as upstream does.
// Only file descriptor handle types can be exercised on this platform, the others are NotSupported at checkSupport.

use std::cell::RefCell;
use std::rc::Rc;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, DeviceV1_2, InstanceV1_1, KhrSynchronization2ExtensionDeviceCommands};

use super::operation::{
    OperationName, READ_OPS, RESOURCES, Resource, ResourceDescription, ResourceType, SyncInfo, SyncType, WRITE_OPS,
    build_operation, cmd_pipeline_barrier, first_difference, get_resource_name, make_buffer_memory_barrier2,
    make_image_memory_barrier2,
};
use crate::tcu::{Random, TestError, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::image_util::ImageWithMemory;
use crate::vk::mem_util::Allocation;
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_command_pool};
use crate::vk::platform::Platform;
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::context::{MultiQueueDevice, select_physical_device};
use crate::vkt::tests::util::external_memory_util::{
    DedicatedTo, NativeHandle, Permanence, allocate_exportable_memory, choose_memory_type,
    create_exportable_semaphore_type, create_semaphore_type, get_memory_native, get_semaphore_native, import_memory,
    import_semaphore, is_supported_semaphore_permanence,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// One way of exporting a memory handle together with the semaphore handle that accompanies it, and the case-name suffix of the pair.
struct HandleCase {
    memory_type: vk::ExternalMemoryHandleTypeFlags,
    semaphore_type: vk::ExternalSemaphoreHandleTypeFlags,
    name_suffix: &'static str,
}

const HANDLE_CASES: &[HandleCase] = &[
    HandleCase {
        memory_type: vk::ExternalMemoryHandleTypeFlags::OPAQUE_FD,
        semaphore_type: vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_FD,
        name_suffix: "_fd",
    },
    HandleCase {
        memory_type: vk::ExternalMemoryHandleTypeFlags::OPAQUE_FD,
        semaphore_type: vk::ExternalSemaphoreHandleTypeFlags::SYNC_FD,
        name_suffix: "_fence_fd",
    },
    HandleCase {
        memory_type: vk::ExternalMemoryHandleTypeFlags::OPAQUE_WIN32_KMT,
        semaphore_type: vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_WIN32_KMT,
        name_suffix: "_win32_kmt",
    },
    HandleCase {
        memory_type: vk::ExternalMemoryHandleTypeFlags::OPAQUE_WIN32,
        semaphore_type: vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_WIN32,
        name_suffix: "_win32",
    },
    HandleCase {
        memory_type: vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT,
        semaphore_type: vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_FD,
        name_suffix: "_dma_buf",
    },
    HandleCase {
        memory_type: vk::ExternalMemoryHandleTypeFlags::ZIRCON_VMO_FUCHSIA,
        semaphore_type: vk::ExternalSemaphoreHandleTypeFlags::ZIRCON_EVENT_FUCHSIA,
        name_suffix: "_zircon_handle",
    },
];

/// `TestConfig` + `SharingTestCase`
pub struct CrossInstanceTestCase {
    name: String,
    sync_type: SyncType,
    resource: ResourceDescription,
    semaphore_type: vk::SemaphoreType,
    write_op: OperationName,
    read_op: OperationName,
    memory_handle_type: vk::ExternalMemoryHandleTypeFlags,
    semaphore_handle_type: vk::ExternalSemaphoreHandleTypeFlags,
    dedicated: bool,
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

impl CrossInstanceTestCase {
    fn resource_usage(&self) -> u32 {
        in_usage(self.read_op, &self.resource) | out_usage(self.write_op, &self.resource)
    }

    fn share_spec(&self) -> ShareSpec<'_> {
        ShareSpec {
            resource: &self.resource,
            usage: self.resource_usage(),
            handle_type: self.memory_handle_type,
            dedicated: self.dedicated,
        }
    }
}

/// What a resource shared between two devices is made of, which both the exporting and the importing side need to agree on.
pub(super) struct ShareSpec<'s> {
    pub resource: &'s ResourceDescription,
    pub usage: u32,
    pub handle_type: vk::ExternalMemoryHandleTypeFlags,
    pub dedicated: bool,
}

/// `DeviceWaitIdleGuard` - waits for the device to be idle when it goes out of scope, so resources declared before it are not
/// destroyed under a submission that is still running.
pub(super) struct IdleGuard<'a>(pub &'a Device);

impl Drop for IdleGuard<'_> {
    fn drop(&mut self) {
        unsafe {
            let _ = self.0.device_wait_idle();
        }
    }
}

impl TestCase for CrossInstanceTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.dedicated {
            context.require_device_functionality("VK_KHR_dedicated_allocation")?;
        }

        context.require_device_functionality("VK_KHR_external_semaphore")?;
        context.require_device_functionality("VK_KHR_external_memory")?;

        if self.semaphore_type == vk::SemaphoreType::TIMELINE {
            context.require_device_functionality("VK_KHR_timeline_semaphore")?;
        }

        if self.sync_type == SyncType::Synchronization2 {
            context.require_device_functionality("VK_KHR_synchronization2")?;
        }

        if self.memory_handle_type == vk::ExternalMemoryHandleTypeFlags::OPAQUE_FD
            || self.semaphore_handle_type == vk::ExternalSemaphoreHandleTypeFlags::SYNC_FD
            || self.semaphore_handle_type == vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_FD
        {
            context.require_device_functionality("VK_KHR_external_semaphore_fd")?;
            context.require_device_functionality("VK_KHR_external_memory_fd")?;
        }

        if self.memory_handle_type == vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT {
            context.require_device_functionality("VK_EXT_external_memory_dma_buf")?;
        }

        if self.memory_handle_type == vk::ExternalMemoryHandleTypeFlags::OPAQUE_WIN32
            || self.memory_handle_type == vk::ExternalMemoryHandleTypeFlags::OPAQUE_WIN32_KMT
            || self.semaphore_handle_type == vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_WIN32
            || self.semaphore_handle_type == vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_WIN32_KMT
        {
            context.require_device_functionality("VK_KHR_external_semaphore_win32")?;
            context.require_device_functionality("VK_KHR_external_memory_win32")?;
        }

        if self.memory_handle_type == vk::ExternalMemoryHandleTypeFlags::ZIRCON_VMO_FUCHSIA
            || self.semaphore_handle_type == vk::ExternalSemaphoreHandleTypeFlags::ZIRCON_EVENT_FUCHSIA
        {
            context.require_device_functionality("VK_FUCHSIA_external_semaphore")?;
            context.require_device_functionality("VK_FUCHSIA_external_memory")?;
        }

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        self.write_op.check_support(context, &self.resource)?;
        self.read_op.check_support(context, &self.resource)?;

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
            let sample_counts = {
                let mut format_properties = vk::ImageFormatProperties2::builder().push_next(&mut external_properties);
                match unsafe {
                    instance.get_physical_device_image_format_properties2(
                        physical_device,
                        &image_format_info,
                        &mut format_properties,
                    )
                } {
                    Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => {
                        return Err(TestError::NotSupported("Image format not supported".to_string()));
                    }
                    result => result.vk_check("vkGetPhysicalDeviceImageFormatProperties2")?,
                }
                format_properties.image_format_properties.sample_counts
            };

            let features = external_properties.external_memory_properties.external_memory_features;
            if !features.contains(vk::ExternalMemoryFeatureFlags::EXPORTABLE) {
                return Err(TestError::NotSupported(
                    "Exporting image resource not supported".to_string(),
                ));
            }
            if !features.contains(vk::ExternalMemoryFeatureFlags::IMPORTABLE) {
                return Err(TestError::NotSupported(
                    "Importing image resource not supported".to_string(),
                ));
            }
            if !self.dedicated && features.contains(vk::ExternalMemoryFeatureFlags::DEDICATED_ONLY) {
                return Err(TestError::NotSupported(
                    "Handle requires dedicated allocation, but test uses suballocated memory".to_string(),
                ));
            }
            if !sample_counts.contains(self.resource.image_samples) {
                return Err(TestError::NotSupported(
                    "Specified sample count for format not supported".to_string(),
                ));
            }
            if self.resource.image_samples != vk::SampleCountFlags::_1
                && usage & vk::ImageUsageFlags::STORAGE.bits() != 0
                && context.get_device_features().shader_storage_image_multisample == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "shaderStorageImageMultisample not supported".to_string(),
                ));
            }
        } else {
            let info = vk::PhysicalDeviceExternalBufferInfo::builder()
                .flags(vk::BufferCreateFlags::empty())
                .usage(vk::BufferUsageFlags::from_bits_truncate(usage))
                .handle_type(self.memory_handle_type);
            let mut properties = vk::ExternalBufferProperties::default();
            unsafe { instance.get_physical_device_external_buffer_properties(physical_device, &info, &mut properties) };

            let features = properties.external_memory_properties.external_memory_features;
            if !features.contains(vk::ExternalMemoryFeatureFlags::EXPORTABLE)
                || !features.contains(vk::ExternalMemoryFeatureFlags::IMPORTABLE)
            {
                return Err(TestError::NotSupported(
                    "Exporting and importing memory type not supported".to_string(),
                ));
            }
            if !self.dedicated && features.contains(vk::ExternalMemoryFeatureFlags::DEDICATED_ONLY) {
                return Err(TestError::NotSupported(
                    "Handle requires dedicated allocation, but test uses suballocated memory".to_string(),
                ));
            }
        }

        let mut semaphore_type_info = vk::SemaphoreTypeCreateInfo::builder()
            .semaphore_type(self.semaphore_type)
            .initial_value(0);
        let info = vk::PhysicalDeviceExternalSemaphoreInfo::builder()
            .push_next(&mut semaphore_type_info)
            .handle_type(self.semaphore_handle_type);
        let mut properties = vk::ExternalSemaphoreProperties::default();
        unsafe { instance.get_physical_device_external_semaphore_properties(physical_device, &info, &mut properties) };

        let features = properties.external_semaphore_features;
        if !features.contains(vk::ExternalSemaphoreFeatureFlags::EXPORTABLE)
            || !features.contains(vk::ExternalSemaphoreFeatureFlags::IMPORTABLE)
        {
            return Err(TestError::NotSupported(
                "Exporting and importing semaphore type not supported".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SharingTestInstance { context, params: self })
    }
}

/// `InstanceAndDevice` - a whole second instance with its own device, so nothing but the exported handles connects the two sides.
/// The device goes first on drop, the instance after it.
pub(super) struct InstanceAndDevice {
    pub queues: MultiQueueDevice,
    _platform: Platform,
}

impl InstanceAndDevice {
    fn new(device_index: usize) -> Result<Self, TestError> {
        let platform = Platform::new(false)
            .map_err(|e| TestError::InternalError(format!("could not create a second instance: {e}")))?;
        let physical_device = select_physical_device(&platform, device_index + 1)
            .map_err(|e| TestError::InternalError(format!("could not pick the physical device: {e}")))?;
        let queues = MultiQueueDevice::new(&platform, physical_device)?;
        Ok(Self {
            queues,
            _platform: platform,
        })
    }
}

pub(super) struct CrossInstances {
    pub a: InstanceAndDevice,
    pub b: InstanceAndDevice,
}

thread_local! {
    /// `InstanceAndDevice::m_instanceA`/`m_instanceB`: built by the first case that needs them and shared by every later one,
    /// since a pair of instances per case is the dominant cost of a group of tens of thousands.
    static CROSS_INSTANCES: RefCell<Option<Rc<CrossInstances>>> = const { RefCell::new(None) };
}

pub(super) fn cross_instances(context: &Context<'_>) -> Result<Rc<CrossInstances>, TestError> {
    if let Some(existing) = CROSS_INSTANCES.with(|cell| cell.borrow().clone()) {
        return Ok(existing);
    }
    let platform = context.get_platform();
    let device_index = platform
        .physical_devices()
        .map_err(|e| TestError::InternalError(e.to_string()))?
        .iter()
        .position(|&pd| pd == context.get_physical_device())
        .ok_or_else(|| {
            TestError::InternalError("the default physical device is not among the enumerated ones".to_string())
        })?;
    let created = Rc::new(CrossInstances {
        a: InstanceAndDevice::new(device_index)?,
        b: InstanceAndDevice::new(device_index)?,
    });
    CROSS_INSTANCES.with(|cell| *cell.borrow_mut() = Some(Rc::clone(&created)));
    Ok(created)
}

/// `checkQueueFlags` - a queue that supports graphics or compute satisfies a transfer requirement whether or not it advertises it.
pub(super) fn check_queue_flags(available: vk::QueueFlags, needed: vk::QueueFlags) -> bool {
    let available = if available.intersects(vk::QueueFlags::GRAPHICS | vk::QueueFlags::COMPUTE) {
        available | vk::QueueFlags::TRANSFER
    } else {
        available
    };
    available.intersects(needed)
}

/// `getMemoryRequirements` for an image, refusing a memory that must be dedicated when the case is not.
fn image_memory_requirements(
    device: &Device,
    image: vk::Image,
    dedicated: bool,
) -> Result<vk::MemoryRequirements, TestError> {
    let info = vk::ImageMemoryRequirementsInfo2::builder().image(image);
    let mut dedicated_requirements = vk::MemoryDedicatedRequirements::default();
    let requirements = {
        let mut requirements = vk::MemoryRequirements2::builder().push_next(&mut dedicated_requirements);
        unsafe { device.get_image_memory_requirements2(&info, &mut requirements) };
        requirements.memory_requirements
    };
    if !dedicated && dedicated_requirements.requires_dedicated_allocation != vk::FALSE {
        return Err(TestError::NotSupported(
            "Memory requires dedicated allocation".to_string(),
        ));
    }
    Ok(requirements)
}

/// `getMemoryRequirements` for a buffer.
fn buffer_memory_requirements(
    device: &Device,
    buffer: vk::Buffer,
    dedicated: bool,
) -> Result<vk::MemoryRequirements, TestError> {
    let info = vk::BufferMemoryRequirementsInfo2::builder().buffer(buffer);
    let mut dedicated_requirements = vk::MemoryDedicatedRequirements::default();
    let requirements = {
        let mut requirements = vk::MemoryRequirements2::builder().push_next(&mut dedicated_requirements);
        unsafe { device.get_buffer_memory_requirements2(&info, &mut requirements) };
        requirements.memory_requirements
    };
    if !dedicated && dedicated_requirements.requires_dedicated_allocation != vk::FALSE {
        return Err(TestError::NotSupported(
            "Memory requires dedicated allocation".to_string(),
        ));
    }
    Ok(requirements)
}

/// `createImage`
fn create_external_image<'a>(
    device: &'a Device,
    desc: &ResourceDescription,
    usage: u32,
    queue_family_indices: &[u32],
    handle_type: vk::ExternalMemoryHandleTypeFlags,
) -> Result<Unique<'a, vk::Image>, TestError> {
    let extent = vk::Extent3D {
        width: desc.size[0] as u32,
        height: desc.size[1].max(1) as u32,
        depth: desc.size[2].max(1) as u32,
    };
    let mut external_info = vk::ExternalMemoryImageCreateInfo::builder().handle_types(handle_type);
    let info = vk::ImageCreateInfo::builder()
        .push_next(&mut external_info)
        .image_type(desc.image_type)
        .format(desc.image_format)
        .extent(extent)
        .mip_levels(1)
        .array_layers(1)
        .samples(desc.image_samples)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::from_bits_truncate(usage))
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .queue_family_indices(queue_family_indices)
        .initial_layout(vk::ImageLayout::UNDEFINED);
    let image = unsafe { device.create_image(&info, None) }.vk_check("vkCreateImage")?;
    Ok(Unique::new(device, image))
}

/// `createBuffer`
fn create_external_buffer<'a>(
    device: &'a Device,
    size: vk::DeviceSize,
    usage: u32,
    handle_type: vk::ExternalMemoryHandleTypeFlags,
    queue_family_indices: &[u32],
) -> Result<Unique<'a, vk::Buffer>, TestError> {
    let mut external_info = vk::ExternalMemoryBufferCreateInfo::builder().handle_types(handle_type);
    let info = vk::BufferCreateInfo::builder()
        .push_next(&mut external_info)
        .size(size)
        .usage(vk::BufferUsageFlags::from_bits_truncate(usage))
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .queue_family_indices(queue_family_indices);
    let buffer = unsafe { device.create_buffer(&info, None) }.vk_check("vkCreateBuffer")?;
    Ok(Unique::new(device, buffer))
}

/// The first half of `iterate`'s resource creation: the resource on the exporting device, with the memory type it was allocated
/// from so the importing side can ask for the same one.
pub(super) fn create_exported_resource<'a>(
    device: &'a Device,
    p: &ShareSpec<'_>,
    queue_family_indices: &[u32],
) -> Result<(Resource<'a>, u32), TestError> {
    let usage = p.usage;
    if p.resource.kind == ResourceType::Image {
        let image = create_external_image(device, p.resource, usage, queue_family_indices, p.handle_type)?;
        let requirements = image_memory_requirements(device, *image, p.dedicated)?;
        let memory_type_index = choose_memory_type(requirements.memory_type_bits);
        let dedicated_to = if p.dedicated {
            DedicatedTo::Image(*image)
        } else {
            DedicatedTo::None
        };
        let memory = allocate_exportable_memory(
            device,
            requirements.size,
            memory_type_index,
            p.handle_type,
            dedicated_to,
        )?;
        unsafe { device.bind_image_memory(*image, *memory, 0) }.vk_check("vkBindImageMemory")?;
        let allocation = Allocation::from_memory(device, memory.release());
        Ok((
            Resource::from_image(p.resource, ImageWithMemory::from_parts(image, allocation)),
            memory_type_index,
        ))
    } else {
        let size = p.resource.size[0] as vk::DeviceSize;
        let buffer = create_external_buffer(device, size, usage, p.handle_type, queue_family_indices)?;
        let requirements = buffer_memory_requirements(device, *buffer, p.dedicated)?;
        let memory_type_index = choose_memory_type(requirements.memory_type_bits);
        let dedicated_to = if p.dedicated {
            DedicatedTo::Buffer(*buffer)
        } else {
            DedicatedTo::None
        };
        let memory = allocate_exportable_memory(
            device,
            requirements.size,
            memory_type_index,
            p.handle_type,
            dedicated_to,
        )?;
        unsafe { device.bind_buffer_memory(*buffer, *memory, 0) }.vk_check("vkBindBufferMemory")?;
        let allocation = Allocation::from_memory(device, memory.release());
        Ok((
            Resource::from_buffer(p.resource, BufferWithMemory::from_parts(buffer, allocation)),
            memory_type_index,
        ))
    }
}

/// `importResource` - the same resource description on the importing device, bound to the memory behind `handle`.
pub(super) fn import_resource<'a>(
    device: &'a Device,
    p: &ShareSpec<'_>,
    queue_family_indices: &[u32],
    handle: &mut NativeHandle,
    exported_memory_type_index: u32,
) -> Result<Resource<'a>, TestError> {
    let usage = p.usage;
    if p.resource.kind == ResourceType::Image {
        let image = create_external_image(device, p.resource, usage, queue_family_indices, p.handle_type)?;
        let requirements = unsafe { device.get_image_memory_requirements(*image) };
        let dedicated_to = if p.dedicated {
            DedicatedTo::Image(*image)
        } else {
            DedicatedTo::None
        };
        let memory = import_memory(
            device,
            &requirements,
            p.handle_type,
            exported_memory_type_index,
            handle,
            dedicated_to,
        )?;
        unsafe { device.bind_image_memory(*image, *memory, 0) }.vk_check("vkBindImageMemory")?;
        let allocation = Allocation::from_memory(device, memory.release());
        Ok(Resource::from_image(
            p.resource,
            ImageWithMemory::from_parts(image, allocation),
        ))
    } else {
        let size = p.resource.size[0] as vk::DeviceSize;
        let buffer = create_external_buffer(device, size, usage, p.handle_type, queue_family_indices)?;
        let requirements = unsafe { device.get_buffer_memory_requirements(*buffer) };
        let dedicated_to = if p.dedicated {
            DedicatedTo::Buffer(*buffer)
        } else {
            DedicatedTo::None
        };
        let memory = import_memory(
            device,
            &requirements,
            p.handle_type,
            exported_memory_type_index,
            handle,
            dedicated_to,
        )?;
        unsafe { device.bind_buffer_memory(*buffer, *memory, 0) }.vk_check("vkBindBufferMemory")?;
        let allocation = Allocation::from_memory(device, memory.release());
        Ok(Resource::from_buffer(
            p.resource,
            BufferWithMemory::from_parts(buffer, allocation),
        ))
    }
}

/// `recordWriteBarrier` - releases the resource from the writing queue family to the external one.
pub(super) fn record_write_barrier(
    device: &Device,
    sync: SyncType,
    cmd_buffer: vk::CommandBuffer,
    resource: &Resource<'_>,
    write_sync: &SyncInfo,
    write_queue_family_index: u32,
    read_sync: &SyncInfo,
) {
    if resource.kind == ResourceType::Image {
        let image = resource.image();
        let mut barrier = make_image_memory_barrier2(
            write_sync.stage_mask,
            write_sync.access_mask,
            read_sync.stage_mask,
            read_sync.access_mask,
            write_sync.image_layout,
            read_sync.image_layout,
            image.handle,
            image.subresource_range,
        );
        barrier.src_queue_family_index = write_queue_family_index;
        barrier.dst_queue_family_index = vk::QUEUE_FAMILY_EXTERNAL;
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
        barrier.src_queue_family_index = write_queue_family_index;
        barrier.dst_queue_family_index = vk::QUEUE_FAMILY_EXTERNAL;
        cmd_pipeline_barrier(device, sync, cmd_buffer, &[barrier], &[]);
    }
}

/// `recordReadBarrier` - acquires the resource from the external queue family onto the reading one. The source stage and access
/// are the read side's own, as upstream has them.
pub(super) fn record_read_barrier(
    device: &Device,
    sync: SyncType,
    cmd_buffer: vk::CommandBuffer,
    resource: &Resource<'_>,
    write_sync: &SyncInfo,
    read_sync: &SyncInfo,
    read_queue_family_index: u32,
) {
    if resource.kind == ResourceType::Image {
        let image = resource.image();
        let mut barrier = make_image_memory_barrier2(
            read_sync.stage_mask,
            read_sync.access_mask,
            read_sync.stage_mask,
            read_sync.access_mask,
            write_sync.image_layout,
            read_sync.image_layout,
            image.handle,
            image.subresource_range,
        );
        barrier.src_queue_family_index = vk::QUEUE_FAMILY_EXTERNAL;
        barrier.dst_queue_family_index = read_queue_family_index;
        cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[barrier]);
    } else {
        let buffer = resource.buffer();
        let mut barrier = make_buffer_memory_barrier2(
            read_sync.stage_mask,
            read_sync.access_mask,
            read_sync.stage_mask,
            read_sync.access_mask,
            buffer.handle,
            0,
            vk::WHOLE_SIZE,
        );
        barrier.src_queue_family_index = vk::QUEUE_FAMILY_EXTERNAL;
        barrier.dst_queue_family_index = read_queue_family_index;
        cmd_pipeline_barrier(device, sync, cmd_buffer, &[barrier], &[]);
    }
}

/// One semaphore operation of a submit: the semaphore, the timeline value (ignored for a binary one) and the stage it applies at.
#[derive(Clone, Copy)]
pub(super) struct SemaphoreOp {
    pub semaphore: vk::Semaphore,
    pub value: u64,
    pub stage: vk::PipelineStageFlags2,
}

/// `SynchronizationWrapper::addSubmitInfo` + `queueSubmit` for one command buffer with at most one wait and one signal.
pub(super) fn submit(
    device: &Device,
    sync: SyncType,
    is_timeline: bool,
    queue: vk::Queue,
    cmd_buffer: vk::CommandBuffer,
    wait: Option<SemaphoreOp>,
    signal: Option<SemaphoreOp>,
    fence: vk::Fence,
) -> Result<(), TestError> {
    if sync == SyncType::Synchronization2 {
        let cmd_infos = [vk::CommandBufferSubmitInfo::builder()
            .command_buffer(cmd_buffer)
            .device_mask(0)
            .build()];
        let to_info = |op: &SemaphoreOp| {
            vk::SemaphoreSubmitInfo::builder()
                .semaphore(op.semaphore)
                .value(op.value)
                .stage_mask(op.stage)
                .device_index(0)
                .build()
        };
        let waits: Vec<vk::SemaphoreSubmitInfo> = wait.iter().map(to_info).collect();
        let signals: Vec<vk::SemaphoreSubmitInfo> = signal.iter().map(to_info).collect();
        let submit_info = vk::SubmitInfo2::builder()
            .wait_semaphore_infos(&waits)
            .command_buffer_infos(&cmd_infos)
            .signal_semaphore_infos(&signals);
        return unsafe { device.queue_submit2_khr(queue, &[submit_info], fence) }.vk_check("vkQueueSubmit2KHR");
    }

    let wait_semaphores: Vec<vk::Semaphore> = wait.iter().map(|op| op.semaphore).collect();
    let wait_stages: Vec<vk::PipelineStageFlags> = wait
        .iter()
        .map(|op| {
            let stages = vk::PipelineStageFlags::from_bits_truncate(op.stage.bits() as u32);
            if stages.is_empty() {
                vk::PipelineStageFlags::TOP_OF_PIPE
            } else {
                stages
            }
        })
        .collect();
    let wait_values: Vec<u64> = wait.iter().map(|op| op.value).collect();
    let signal_semaphores: Vec<vk::Semaphore> = signal.iter().map(|op| op.semaphore).collect();
    let signal_values: Vec<u64> = signal.iter().map(|op| op.value).collect();
    let cmd_buffers = [cmd_buffer];

    let mut timeline_info = vk::TimelineSemaphoreSubmitInfo::builder()
        .wait_semaphore_values(&wait_values)
        .signal_semaphore_values(&signal_values);
    let mut submit_info = vk::SubmitInfo::builder()
        .wait_semaphores(&wait_semaphores)
        .wait_dst_stage_mask(&wait_stages)
        .command_buffers(&cmd_buffers)
        .signal_semaphores(&signal_semaphores);
    if is_timeline {
        submit_info = submit_info.push_next(&mut timeline_info);
    }
    unsafe { device.queue_submit(queue, &[submit_info], fence) }.vk_check("vkQueueSubmit")
}

struct SharingTestInstance<'a> {
    context: &'a Context<'a>,
    params: &'a CrossInstanceTestCase,
}

impl TestInstance for SharingTestInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        let instances = cross_instances(self.context)?;
        let family_count_a = instances.a.queues.families().len();
        let family_count_b = instances.b.queues.families().len();

        // `m_resultCollector`: the first failure is the one reported, a pair that cannot run is skipped.
        let mut failure: Option<String> = None;
        for queue_a_ndx in 0..family_count_a {
            for queue_b_ndx in 0..family_count_b {
                match self.run_queue_pair(&instances, queue_a_ndx, queue_b_ndx) {
                    Ok(None) => {}
                    Ok(Some(message)) => {
                        failure.get_or_insert(message);
                    }
                    Err(TestError::NotSupported(message)) => log::info!("Not supported: {message}"),
                    Err(error @ TestError::NotPorted(_)) => return Err(error),
                    Err(error) => {
                        failure.get_or_insert(format!("Exception: {error}"));
                    }
                }
            }
        }

        Ok(match failure {
            Some(message) => TestStatus::fail(message),
            None => TestStatus::pass("Pass"),
        })
    }
}

impl SharingTestInstance<'_> {
    /// One pass of upstream's `iterate`: write on queue family `queue_a_ndx` of the first device, read on `queue_b_ndx` of the second.
    /// `Ok(Some(message))` is a failed comparison.
    fn run_queue_pair(
        &self,
        instances: &CrossInstances,
        queue_a_ndx: usize,
        queue_b_ndx: usize,
    ) -> Result<Option<String>, TestError> {
        let p = self.params;
        let sync = p.sync_type;
        let is_timeline = p.semaphore_type == vk::SemaphoreType::TIMELINE;

        let device_a = instances.a.queues.device();
        let device_b = instances.b.queues.device();
        let family_a = &instances.a.queues.families()[queue_a_ndx];
        let family_b = &instances.b.queues.families()[queue_b_ndx];
        let family_indices_a: Vec<u32> = instances.a.queues.families().iter().map(|f| f.family_index).collect();
        let family_indices_b: Vec<u32> = instances.b.queues.families().iter().map(|f| f.family_index).collect();

        if !check_queue_flags(family_a.flags, p.write_op.queue_flags(&p.resource)) {
            return Err(TestError::NotSupported(
                "Operation not supported by the source queue".to_string(),
            ));
        }
        if !check_queue_flags(family_b.flags, p.read_op.queue_flags(&p.resource)) {
            return Err(TestError::NotSupported(
                "Operation not supported by the destination queue".to_string(),
            ));
        }

        let semaphore_a = create_exportable_semaphore_type(device_a, p.semaphore_type, p.semaphore_handle_type)?;
        let semaphore_b = create_semaphore_type(device_b, p.semaphore_type)?;

        let (resource_a, exported_memory_type_index) =
            create_exported_resource(device_a, &p.share_spec(), &family_indices_a)?;
        let mut native_memory_handle = get_memory_native(device_a, resource_a.memory(), p.memory_handle_type)?;
        let resource_b = import_resource(
            device_b,
            &p.share_spec(),
            &family_indices_b,
            &mut native_memory_handle,
            exported_memory_type_index,
        )?;

        let queue_a = family_a.queues[0];
        let pool_a = make_command_pool(device_a, family_a.family_index)?;
        let command_buffer_a = allocate_command_buffer(device_a, *pool_a, vk::CommandBufferLevel::PRIMARY)?;
        let allocator_a = instances.a.queues.allocator();

        let queue_b = family_b.queues[0];
        let pool_b = make_command_pool(device_b, family_b.family_index)?;
        let command_buffer_b = allocate_command_buffer(device_b, *pool_b, vk::CommandBufferLevel::PRIMARY)?;
        let allocator_b = instances.b.queues.allocator();

        let write_op = build_operation(device_a, allocator_a, p.write_op, &p.resource, &resource_a, false)?;
        let read_op = build_operation(device_b, allocator_b, p.read_op, &p.resource, &resource_b, false)?;

        let _idle_a = IdleGuard(device_a);
        let _idle_b = IdleGuard(device_b);

        let write_sync = write_op.out_sync_info(sync);
        let read_sync = read_op.in_sync_info(sync);

        let graphics_flags = vk::PipelineStageFlags2::VERTEX_SHADER
            | vk::PipelineStageFlags2::TESSELLATION_CONTROL_SHADER
            | vk::PipelineStageFlags2::TESSELLATION_EVALUATION_SHADER
            | vk::PipelineStageFlags2::GEOMETRY_SHADER
            | vk::PipelineStageFlags2::FRAGMENT_SHADER;

        if write_sync.stage_mask.intersects(graphics_flags) || !read_sync.stage_mask.is_empty() {
            if !check_queue_flags(family_a.flags, vk::QueueFlags::GRAPHICS) {
                return Err(TestError::NotSupported(
                    "Operation not supported by the source queue".to_string(),
                ));
            }
            if !check_queue_flags(family_b.flags, vk::QueueFlags::GRAPHICS) {
                return Err(TestError::NotSupported(
                    "Operation not supported by the destination queue".to_string(),
                ));
            }
        }

        begin_command_buffer(device_a, *command_buffer_a)?;
        write_op.record_commands(device_a, sync, *command_buffer_a);
        record_write_barrier(
            device_a,
            sync,
            *command_buffer_a,
            &resource_a,
            &write_sync,
            family_a.family_index,
            &read_sync,
        );
        end_command_buffer(device_a, *command_buffer_a)?;

        begin_command_buffer(device_b, *command_buffer_b)?;
        record_read_barrier(
            device_b,
            sync,
            *command_buffer_b,
            &resource_b,
            &write_sync,
            &read_sync,
            family_b.family_index,
        );
        read_op.record_commands(device_b, sync, *command_buffer_b);
        end_command_buffer(device_b, *command_buffer_b)?;

        {
            let mut rng = Random::new(1234);
            let signal = SemaphoreOp {
                semaphore: *semaphore_a,
                value: rng.get_int(1, i32::MAX) as u64,
                stage: vk::PipelineStageFlags2::BOTTOM_OF_PIPE,
            };
            submit(
                device_a,
                sync,
                is_timeline,
                queue_a,
                *command_buffer_a,
                None,
                Some(signal),
                vk::Fence::null(),
            )?;

            let flags = if is_supported_semaphore_permanence(p.semaphore_handle_type, Permanence::Permanent) {
                vk::SemaphoreImportFlags::empty()
            } else {
                vk::SemaphoreImportFlags::TEMPORARY
            };
            let mut native_semaphore_handle = get_semaphore_native(device_a, *semaphore_a, p.semaphore_handle_type)?;
            import_semaphore(
                device_b,
                *semaphore_b,
                p.semaphore_handle_type,
                &mut native_semaphore_handle,
                flags,
            )?;
        }
        {
            let wait = SemaphoreOp {
                semaphore: *semaphore_b,
                value: 1,
                stage: read_sync.stage_mask,
            };
            submit(
                device_b,
                sync,
                is_timeline,
                queue_b,
                *command_buffer_b,
                Some(wait),
                None,
                vk::Fence::null(),
            )?;
        }

        unsafe { device_a.queue_wait_idle(queue_a) }.vk_check("vkQueueWaitIdle")?;
        unsafe { device_b.queue_wait_idle(queue_b) }.vk_check("vkQueueWaitIdle")?;

        if is_timeline {
            let value_a =
                unsafe { device_a.get_semaphore_counter_value(*semaphore_a) }.vk_check("vkGetSemaphoreCounterValue")?;
            let value_b =
                unsafe { device_b.get_semaphore_counter_value(*semaphore_b) }.vk_check("vkGetSemaphoreCounterValue")?;
            if value_a != value_b {
                return Ok(Some("Inconsistent values between shared semaphores".to_string()));
            }
        }

        let expected = write_op.data(device_a)?;
        let actual = read_op.data(device_b)?;

        if !p.resource.kind.is_indirect_buffer() {
            if let Some(at) = first_difference(&expected, &actual) {
                log::info!("First different byte at offset: {at}");
                return Ok(Some("Memory contents don't match".to_string()));
            }
        } else {
            let expected_value = u32::from_ne_bytes(expected[0..4].try_into().expect("at least 4 bytes"));
            let actual_value = u32::from_ne_bytes(actual[0..4].try_into().expect("at least 4 bytes"));
            if actual_value < expected_value {
                log::info!("Expected counter value: ({expected_value}), actual counter value: ({actual_value})");
                return Ok(Some("Counter value is smaller than expected".to_string()));
            }
        }

        Ok(None)
    }
}

/// `createCrossInstanceSharingTest`
pub fn create_cross_instance_sharing_tests(sync_type: SyncType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("cross_instance");

    for dedicated in [false, true] {
        let mut dedicated_group = TestCaseGroup::new(if dedicated { "dedicated" } else { "suballocated" });

        for &write_op in WRITE_OPS {
            for &read_op in READ_OPS {
                let mut op_group = TestCaseGroup::new(format!("{}_{}", write_op.as_str(), read_op.as_str()));
                let mut empty = true;

                for resource in RESOURCES {
                    for handle_case in HANDLE_CASES {
                        for (semaphore_type, semaphore_name) in [
                            (vk::SemaphoreType::BINARY, "_binary_semaphore"),
                            (vk::SemaphoreType::TIMELINE, "_timeline_semaphore"),
                        ] {
                            if handle_case.semaphore_type == vk::ExternalSemaphoreHandleTypeFlags::SYNC_FD
                                && semaphore_type == vk::SemaphoreType::TIMELINE
                            {
                                continue;
                            }

                            if write_op.supports_resource(resource) && read_op.supports_resource(resource) {
                                op_group.add_child(Box::new(CrossInstanceTestCase {
                                    name: format!(
                                        "{}{}{}",
                                        get_resource_name(resource),
                                        semaphore_name,
                                        handle_case.name_suffix
                                    ),
                                    sync_type,
                                    resource: *resource,
                                    semaphore_type,
                                    write_op,
                                    read_op,
                                    memory_handle_type: handle_case.memory_type,
                                    semaphore_handle_type: handle_case.semaphore_type,
                                    dedicated,
                                }) as Box<dyn TestCase>);
                                empty = false;
                            }
                        }
                    }
                }

                if !empty {
                    dedicated_group.add_child(op_group);
                }
            }
        }

        group.add_child(dedicated_group);
    }

    group
}
