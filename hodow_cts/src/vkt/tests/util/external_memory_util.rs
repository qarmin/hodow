// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/util/vktExternalMemoryUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the POSIX file descriptor handle types (opaque fd, dma-buf, sync fd) can be
// exported and imported here; every other handle type is reported NotSupported, which is what a Linux driver says about the Win32,
// Fuchsia, Android hardware buffer and Metal ones anyway.

use std::os::fd::{FromRawFd, IntoRawFd, OwnedFd, RawFd};

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    KhrExternalFenceFdExtensionDeviceCommands, KhrExternalMemoryFdExtensionDeviceCommands,
    KhrExternalSemaphoreFdExtensionDeviceCommands,
};

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::ref_util::Unique;

/// `NativeHandle`, reduced to the one kind this platform has: a file descriptor that is closed on drop unless it was handed to the
/// driver by an import. A sync fd that is already signalled exports as -1, which is a valid handle with nothing to close.
pub struct NativeHandle {
    fd: Option<OwnedFd>,
    minus_one: bool,
}

impl NativeHandle {
    pub fn new() -> Self {
        Self {
            fd: None,
            minus_one: false,
        }
    }

    /// `NativeHandle::operator=(int fd)`; -1 is kept as such, since a sync fd that was already signalled exports as one.
    pub fn from_fd(fd: RawFd) -> Self {
        // Safety: the descriptor was just returned by the driver for us to own.
        Self {
            fd: (fd >= 0).then(|| unsafe { OwnedFd::from_raw_fd(fd) }),
            minus_one: fd == -1,
        }
    }

    pub fn has_valid_fd(&self) -> bool {
        self.fd.is_some() || self.minus_one
    }

    /// `hasValidFd() && getFd() == -1` - the driver reported the object as already signalled instead of handing out a descriptor.
    pub fn is_minus_one(&self) -> bool {
        self.minus_one
    }

    /// `NativeHandle::getFd` - -1 for the already-signalled sync fd.
    pub fn fd(&self) -> RawFd {
        use std::os::fd::AsRawFd;
        self.fd.as_ref().map_or(-1, AsRawFd::as_raw_fd)
    }

    /// `NativeHandle::NativeHandle(const NativeHandle &)` - a duplicate descriptor, so each copy can be imported once.
    pub fn try_clone(&self) -> Result<Self, TestError> {
        let fd = match &self.fd {
            Some(fd) => Some(
                fd.try_clone()
                    .map_err(|e| TestError::Fail(format!("dup() failed: {e}")))?,
            ),
            None => None,
        };
        Ok(Self {
            fd,
            minus_one: self.minus_one,
        })
    }

    /// `NativeHandle::disown` - the driver owns the descriptor now, so it must not be closed here.
    pub fn disown(&mut self) {
        if let Some(fd) = self.fd.take() {
            let _ = fd.into_raw_fd();
        }
    }

    /// `NativeHandle::reset`
    pub fn reset(&mut self) {
        self.fd = None;
        self.minus_one = false;
    }
}

impl Default for NativeHandle {
    fn default() -> Self {
        Self::new()
    }
}

/// `Permanence`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Permanence {
    Permanent,
    Temporary,
}

/// `Transference`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Transference {
    Copy,
    Reference,
}

/// What a dedicated allocation is dedicated to, which is `allocateExportableMemory`'s buffer/image overload pair and
/// `importDedicatedMemory`'s.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum DedicatedTo {
    None,
    Buffer(vk::Buffer),
    Image(vk::Image),
}

/// `externalSemaphoreTypeToName`
pub fn external_semaphore_type_name(handle_type: vk::ExternalSemaphoreHandleTypeFlags) -> &'static str {
    if handle_type == vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_FD {
        "opaque_fd"
    } else if handle_type == vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_WIN32 {
        "opaque_win32"
    } else if handle_type == vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_WIN32_KMT {
        "opaque_win32_kmt"
    } else if handle_type == vk::ExternalSemaphoreHandleTypeFlags::D3D12_FENCE {
        "d3d12_fenc"
    } else if handle_type == vk::ExternalSemaphoreHandleTypeFlags::SYNC_FD {
        "sync_fd"
    } else if handle_type == vk::ExternalSemaphoreHandleTypeFlags::ZIRCON_EVENT_FUCHSIA {
        "zircon_event"
    } else {
        "unknown"
    }
}

/// `externalFenceTypeToName`
pub fn external_fence_type_name(handle_type: vk::ExternalFenceHandleTypeFlags) -> &'static str {
    if handle_type == vk::ExternalFenceHandleTypeFlags::OPAQUE_FD {
        "opaque_fd"
    } else if handle_type == vk::ExternalFenceHandleTypeFlags::OPAQUE_WIN32 {
        "opaque_win32"
    } else if handle_type == vk::ExternalFenceHandleTypeFlags::OPAQUE_WIN32_KMT {
        "opaque_win32_kmt"
    } else if handle_type == vk::ExternalFenceHandleTypeFlags::SYNC_FD {
        "sync_fd"
    } else {
        "unknown"
    }
}

/// `externalMemoryTypeToName`
pub fn external_memory_type_name(handle_type: vk::ExternalMemoryHandleTypeFlags) -> &'static str {
    if handle_type == vk::ExternalMemoryHandleTypeFlags::OPAQUE_FD {
        "opaque_fd"
    } else if handle_type == vk::ExternalMemoryHandleTypeFlags::OPAQUE_WIN32 {
        "opaque_win32"
    } else if handle_type == vk::ExternalMemoryHandleTypeFlags::OPAQUE_WIN32_KMT {
        "opaque_win32_kmt"
    } else if handle_type == vk::ExternalMemoryHandleTypeFlags::D3D11_TEXTURE {
        "d3d11_texture"
    } else if handle_type == vk::ExternalMemoryHandleTypeFlags::D3D11_TEXTURE_KMT {
        "d3d11_texture_kmt"
    } else if handle_type == vk::ExternalMemoryHandleTypeFlags::D3D12_HEAP {
        "d3d12_heap"
    } else if handle_type == vk::ExternalMemoryHandleTypeFlags::D3D12_RESOURCE {
        "d3d12_resource"
    } else if handle_type == vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT {
        "dma_buf"
    } else if handle_type == vk::ExternalMemoryHandleTypeFlags::HOST_ALLOCATION_EXT {
        "host_allocation"
    } else if handle_type == vk::ExternalMemoryHandleTypeFlags::ZIRCON_VMO_FUCHSIA {
        "zircon_vmo"
    } else if handle_type == vk::ExternalMemoryHandleTypeFlags::ANDROID_HARDWARE_BUFFER_ANDROID {
        "android_hardware_buffer"
    } else if handle_type == vk::ExternalMemoryHandleTypeFlags::MTLBUFFER_EXT {
        "mtlbuffer"
    } else if handle_type == vk::ExternalMemoryHandleTypeFlags::MTLTEXTURE_EXT {
        "mtltexture"
    } else {
        "unknown"
    }
}

/// `isSupportedPermanence` for a semaphore handle type.
pub fn is_supported_semaphore_permanence(
    handle_type: vk::ExternalSemaphoreHandleTypeFlags,
    permanence: Permanence,
) -> bool {
    handle_type != vk::ExternalSemaphoreHandleTypeFlags::SYNC_FD || permanence == Permanence::Temporary
}

/// `getHandelTypeTransferences` for a semaphore handle type.
pub fn semaphore_handle_type_transference(handle_type: vk::ExternalSemaphoreHandleTypeFlags) -> Transference {
    if handle_type == vk::ExternalSemaphoreHandleTypeFlags::SYNC_FD {
        Transference::Copy
    } else {
        Transference::Reference
    }
}

/// `isSupportedPermanence` for a fence handle type.
pub fn is_supported_fence_permanence(handle_type: vk::ExternalFenceHandleTypeFlags, permanence: Permanence) -> bool {
    handle_type != vk::ExternalFenceHandleTypeFlags::SYNC_FD || permanence == Permanence::Temporary
}

/// `getHandelTypeTransferences` for a fence handle type.
pub fn fence_handle_type_transference(handle_type: vk::ExternalFenceHandleTypeFlags) -> Transference {
    if handle_type == vk::ExternalFenceHandleTypeFlags::SYNC_FD {
        Transference::Copy
    } else {
        Transference::Reference
    }
}

fn is_fd_memory_handle(handle_type: vk::ExternalMemoryHandleTypeFlags) -> bool {
    handle_type == vk::ExternalMemoryHandleTypeFlags::OPAQUE_FD
        || handle_type == vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT
}

fn is_fd_semaphore_handle(handle_type: vk::ExternalSemaphoreHandleTypeFlags) -> bool {
    handle_type == vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_FD
        || handle_type == vk::ExternalSemaphoreHandleTypeFlags::SYNC_FD
}

fn is_fd_fence_handle(handle_type: vk::ExternalFenceHandleTypeFlags) -> bool {
    handle_type == vk::ExternalFenceHandleTypeFlags::OPAQUE_FD
        || handle_type == vk::ExternalFenceHandleTypeFlags::SYNC_FD
}

fn unsupported_handle(kind: &str, name: &str) -> TestError {
    TestError::NotSupported(format!("{kind} handle type {name} is not available on this platform"))
}

/// `getMemoryFd`
pub fn get_memory_fd(
    device: &Device,
    memory: vk::DeviceMemory,
    handle_type: vk::ExternalMemoryHandleTypeFlags,
) -> Result<RawFd, TestError> {
    let info = vk::MemoryGetFdInfoKHR {
        memory,
        handle_type,
        ..Default::default()
    };
    let fd = unsafe { device.get_memory_fd_khr(&info) }.vk_check("vkGetMemoryFdKHR")?;
    if fd < 0 {
        return Err(TestError::Fail(format!(
            "vkGetMemoryFdKHR returned the invalid descriptor {fd}"
        )));
    }
    Ok(fd)
}

/// `getMemoryNative`
pub fn get_memory_native(
    device: &Device,
    memory: vk::DeviceMemory,
    handle_type: vk::ExternalMemoryHandleTypeFlags,
) -> Result<NativeHandle, TestError> {
    if !is_fd_memory_handle(handle_type) {
        return Err(unsupported_handle("memory", external_memory_type_name(handle_type)));
    }
    Ok(NativeHandle::from_fd(get_memory_fd(device, memory, handle_type)?))
}

/// `createExportableSemaphore`
pub fn create_exportable_semaphore(
    device: &Device,
    handle_type: vk::ExternalSemaphoreHandleTypeFlags,
) -> Result<Unique<'_, vk::Semaphore>, TestError> {
    let mut export_info = vk::ExportSemaphoreCreateInfo::builder().handle_types(handle_type);
    let info = vk::SemaphoreCreateInfo::builder().push_next(&mut export_info);
    let semaphore = unsafe { device.create_semaphore(&info, None) }.vk_check("vkCreateSemaphore")?;
    Ok(Unique::new(device, semaphore))
}

/// `createExportableSemaphoreType`
pub fn create_exportable_semaphore_type(
    device: &Device,
    semaphore_type: vk::SemaphoreType,
    handle_type: vk::ExternalSemaphoreHandleTypeFlags,
) -> Result<Unique<'_, vk::Semaphore>, TestError> {
    let mut type_info = vk::SemaphoreTypeCreateInfo::builder()
        .semaphore_type(semaphore_type)
        .initial_value(0);
    let mut export_info = vk::ExportSemaphoreCreateInfo::builder().handle_types(handle_type);
    let info = vk::SemaphoreCreateInfo::builder()
        .push_next(&mut export_info)
        .push_next(&mut type_info);
    let semaphore = unsafe { device.create_semaphore(&info, None) }.vk_check("vkCreateSemaphore")?;
    Ok(Unique::new(device, semaphore))
}

/// `createSemaphoreType`
pub fn create_semaphore_type(
    device: &Device,
    semaphore_type: vk::SemaphoreType,
) -> Result<Unique<'_, vk::Semaphore>, TestError> {
    let mut type_info = vk::SemaphoreTypeCreateInfo::builder()
        .semaphore_type(semaphore_type)
        .initial_value(0);
    let info = vk::SemaphoreCreateInfo::builder().push_next(&mut type_info);
    let semaphore = unsafe { device.create_semaphore(&info, None) }.vk_check("vkCreateSemaphore")?;
    Ok(Unique::new(device, semaphore))
}

/// `getSemaphoreFd`
pub fn get_semaphore_fd(
    device: &Device,
    semaphore: vk::Semaphore,
    handle_type: vk::ExternalSemaphoreHandleTypeFlags,
) -> Result<RawFd, TestError> {
    let info = vk::SemaphoreGetFdInfoKHR {
        semaphore,
        handle_type,
        ..Default::default()
    };
    let fd = unsafe { device.get_semaphore_fd_khr(&info) }.vk_check("vkGetSemaphoreFdKHR")?;
    if fd < 0 {
        return Err(TestError::Fail(format!(
            "vkGetSemaphoreFdKHR returned the invalid descriptor {fd}"
        )));
    }
    Ok(fd)
}

/// `getSemaphoreNative`
pub fn get_semaphore_native(
    device: &Device,
    semaphore: vk::Semaphore,
    handle_type: vk::ExternalSemaphoreHandleTypeFlags,
) -> Result<NativeHandle, TestError> {
    if !is_fd_semaphore_handle(handle_type) {
        return Err(unsupported_handle(
            "semaphore",
            external_semaphore_type_name(handle_type),
        ));
    }
    let info = vk::SemaphoreGetFdInfoKHR {
        semaphore,
        handle_type,
        ..Default::default()
    };
    let fd = unsafe { device.get_semaphore_fd_khr(&info) }.vk_check("vkGetSemaphoreFdKHR")?;
    // A sync fd that is already signalled comes back as -1; an opaque fd never does.
    let lowest_valid = if handle_type == vk::ExternalSemaphoreHandleTypeFlags::SYNC_FD {
        -1
    } else {
        0
    };
    if fd < lowest_valid {
        return Err(TestError::Fail(format!(
            "vkGetSemaphoreFdKHR returned the invalid descriptor {fd}"
        )));
    }
    Ok(NativeHandle::from_fd(fd))
}

/// `importSemaphore`
pub fn import_semaphore(
    device: &Device,
    semaphore: vk::Semaphore,
    handle_type: vk::ExternalSemaphoreHandleTypeFlags,
    handle: &mut NativeHandle,
    flags: vk::SemaphoreImportFlags,
) -> Result<(), TestError> {
    if !is_fd_semaphore_handle(handle_type) {
        return Err(unsupported_handle(
            "semaphore",
            external_semaphore_type_name(handle_type),
        ));
    }
    let info = vk::ImportSemaphoreFdInfoKHR {
        semaphore,
        flags,
        handle_type,
        fd: handle.fd(),
        ..Default::default()
    };
    unsafe { device.import_semaphore_fd_khr(&info) }.vk_check("vkImportSemaphoreFdKHR")?;
    handle.disown();
    Ok(())
}

/// `createAndImportSemaphore`
pub fn create_and_import_semaphore<'a>(
    device: &'a Device,
    handle_type: vk::ExternalSemaphoreHandleTypeFlags,
    handle: &mut NativeHandle,
    flags: vk::SemaphoreImportFlags,
) -> Result<Unique<'a, vk::Semaphore>, TestError> {
    let semaphore =
        unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }.vk_check("vkCreateSemaphore")?;
    let semaphore = Unique::new(device, semaphore);
    import_semaphore(device, *semaphore, handle_type, handle, flags)?;
    Ok(semaphore)
}

/// `createExportableFence`
pub fn create_exportable_fence(
    device: &Device,
    handle_type: vk::ExternalFenceHandleTypeFlags,
) -> Result<Unique<'_, vk::Fence>, TestError> {
    let mut export_info = vk::ExportFenceCreateInfo::builder().handle_types(handle_type);
    let info = vk::FenceCreateInfo::builder().push_next(&mut export_info);
    let fence = unsafe { device.create_fence(&info, None) }.vk_check("vkCreateFence")?;
    Ok(Unique::new(device, fence))
}

/// `getFenceFd`
pub fn get_fence_fd(
    device: &Device,
    fence: vk::Fence,
    handle_type: vk::ExternalFenceHandleTypeFlags,
) -> Result<RawFd, TestError> {
    let info = vk::FenceGetFdInfoKHR {
        fence,
        handle_type,
        ..Default::default()
    };
    let fd = unsafe { device.get_fence_fd_khr(&info) }.vk_check("vkGetFenceFdKHR")?;
    let lowest_valid = if handle_type == vk::ExternalFenceHandleTypeFlags::SYNC_FD {
        -1
    } else {
        0
    };
    if fd < lowest_valid {
        return Err(TestError::Fail(format!(
            "vkGetFenceFdKHR returned the invalid descriptor {fd}"
        )));
    }
    Ok(fd)
}

/// `getFenceNative`. A sync fd of a fence that is already signalled comes back as -1, which is as valid as a descriptor; an
/// opaque fd never is -1. `expect_fence_unsignaled` is upstream's parameter, which its check never lets change the outcome.
pub fn get_fence_native(
    device: &Device,
    fence: vk::Fence,
    handle_type: vk::ExternalFenceHandleTypeFlags,
    expect_fence_unsignaled: bool,
) -> Result<NativeHandle, TestError> {
    let _ = expect_fence_unsignaled;
    if !is_fd_fence_handle(handle_type) {
        return Err(unsupported_handle("fence", external_fence_type_name(handle_type)));
    }
    let info = vk::FenceGetFdInfoKHR {
        fence,
        handle_type,
        ..Default::default()
    };
    let fd = unsafe { device.get_fence_fd_khr(&info) }.vk_check("vkGetFenceFdKHR")?;
    let lowest_valid = if handle_type == vk::ExternalFenceHandleTypeFlags::SYNC_FD {
        -1
    } else {
        0
    };
    if fd < lowest_valid {
        return Err(TestError::Fail(format!(
            "vkGetFenceFdKHR returned the invalid descriptor {fd}"
        )));
    }
    Ok(NativeHandle::from_fd(fd))
}

/// `importFence`
pub fn import_fence(
    device: &Device,
    fence: vk::Fence,
    handle_type: vk::ExternalFenceHandleTypeFlags,
    handle: &mut NativeHandle,
    flags: vk::FenceImportFlags,
) -> Result<(), TestError> {
    if !is_fd_fence_handle(handle_type) {
        return Err(unsupported_handle("fence", external_fence_type_name(handle_type)));
    }
    let info = vk::ImportFenceFdInfoKHR {
        fence,
        flags,
        handle_type,
        fd: handle.fd(),
        ..Default::default()
    };
    unsafe { device.import_fence_fd_khr(&info) }.vk_check("vkImportFenceFdKHR")?;
    handle.disown();
    Ok(())
}

/// `createAndImportFence`
pub fn create_and_import_fence<'a>(
    device: &'a Device,
    handle_type: vk::ExternalFenceHandleTypeFlags,
    handle: &mut NativeHandle,
    flags: vk::FenceImportFlags,
) -> Result<Unique<'a, vk::Fence>, TestError> {
    let fence = unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?;
    let fence = Unique::new(device, fence);
    import_fence(device, *fence, handle_type, handle, flags)?;
    Ok(fence)
}

/// `chooseMemoryType` - the lowest memory type the requirements allow.
pub fn choose_memory_type(bits: u32) -> u32 {
    if bits == 0 {
        return 0;
    }
    bits.trailing_zeros()
}

/// `chooseHostVisibleMemoryType`
pub fn choose_host_visible_memory_type(
    bits: u32,
    properties: &vk::PhysicalDeviceMemoryProperties,
) -> Result<u32, TestError> {
    (0..properties.memory_type_count)
        .find(|&index| {
            bits & (1 << index) != 0
                && properties.memory_types[index as usize]
                    .property_flags
                    .contains(vk::MemoryPropertyFlags::HOST_VISIBLE)
        })
        .ok_or_else(|| TestError::NotSupported("No supported memory type found".to_string()))
}

/// `allocateExportableMemory`, with `dedicated_to` standing for the buffer and image overloads.
pub fn allocate_exportable_memory(
    device: &Device,
    allocation_size: vk::DeviceSize,
    memory_type_index: u32,
    handle_type: vk::ExternalMemoryHandleTypeFlags,
    dedicated_to: DedicatedTo,
) -> Result<Unique<'_, vk::DeviceMemory>, TestError> {
    let mut export_info = vk::ExportMemoryAllocateInfo::builder().handle_types(handle_type);
    let mut dedicated_info = match dedicated_to {
        DedicatedTo::None => None,
        DedicatedTo::Buffer(buffer) => Some(vk::MemoryDedicatedAllocateInfo::builder().buffer(buffer)),
        DedicatedTo::Image(image) => Some(vk::MemoryDedicatedAllocateInfo::builder().image(image)),
    };
    let mut info = vk::MemoryAllocateInfo::builder()
        .allocation_size(allocation_size)
        .memory_type_index(memory_type_index)
        .push_next(&mut export_info);
    if let Some(dedicated_info) = dedicated_info.as_mut() {
        info = info.push_next(dedicated_info);
    }
    let memory = unsafe { device.allocate_memory(&info, None) }.vk_check("vkAllocateMemory")?;
    Ok(Unique::new(device, memory))
}

/// `importMemory` / `importDedicatedMemory`. A `memory_type_index` of `u32::MAX` (upstream's `~0U`) picks the lowest type the
/// requirements allow.
pub fn import_memory<'a>(
    device: &'a Device,
    requirements: &vk::MemoryRequirements,
    handle_type: vk::ExternalMemoryHandleTypeFlags,
    memory_type_index: u32,
    handle: &mut NativeHandle,
    dedicated_to: DedicatedTo,
) -> Result<Unique<'a, vk::DeviceMemory>, TestError> {
    if !is_fd_memory_handle(handle_type) {
        return Err(unsupported_handle("memory", external_memory_type_name(handle_type)));
    }
    let mut import_info = vk::ImportMemoryFdInfoKHR {
        handle_type,
        fd: handle.fd(),
        ..Default::default()
    };
    let mut dedicated_info = match dedicated_to {
        DedicatedTo::None => None,
        DedicatedTo::Buffer(buffer) => Some(vk::MemoryDedicatedAllocateInfo::builder().buffer(buffer)),
        DedicatedTo::Image(image) => Some(vk::MemoryDedicatedAllocateInfo::builder().image(image)),
    };
    let type_index = if memory_type_index == u32::MAX {
        choose_memory_type(requirements.memory_type_bits)
    } else {
        memory_type_index
    };
    let mut info = vk::MemoryAllocateInfo::builder()
        .allocation_size(requirements.size)
        .memory_type_index(type_index)
        .push_next(&mut import_info);
    if let Some(dedicated_info) = dedicated_info.as_mut() {
        info = info.push_next(dedicated_info);
    }
    let memory = unsafe { device.allocate_memory(&info, None) }.vk_check("vkAllocateMemory")?;
    handle.disown();
    Ok(Unique::new(device, memory))
}

/// `createExternalBuffer`
pub fn create_external_buffer(
    device: &Device,
    queue_family_index: u32,
    handle_type: vk::ExternalMemoryHandleTypeFlags,
    size: vk::DeviceSize,
    create_flags: vk::BufferCreateFlags,
    usage: vk::BufferUsageFlags,
) -> Result<Unique<'_, vk::Buffer>, TestError> {
    let queue_family_indices = [queue_family_index];
    let mut external_info = vk::ExternalMemoryBufferCreateInfo::builder().handle_types(handle_type);
    let info = vk::BufferCreateInfo::builder()
        .push_next(&mut external_info)
        .flags(create_flags)
        .size(size)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .queue_family_indices(&queue_family_indices);
    let buffer = unsafe { device.create_buffer(&info, None) }.vk_check("vkCreateBuffer")?;
    Ok(Unique::new(device, buffer))
}

/// `createExternalImage`
#[allow(clippy::too_many_arguments)]
pub fn create_external_image(
    device: &Device,
    queue_family_index: u32,
    handle_type: vk::ExternalMemoryHandleTypeFlags,
    format: vk::Format,
    width: u32,
    height: u32,
    tiling: vk::ImageTiling,
    create_flags: vk::ImageCreateFlags,
    usage: vk::ImageUsageFlags,
    mip_levels: u32,
    array_layers: u32,
) -> Result<Unique<'_, vk::Image>, TestError> {
    let queue_family_indices = [queue_family_index];
    let mut external_info = vk::ExternalMemoryImageCreateInfo::builder().handle_types(handle_type);
    let info = vk::ImageCreateInfo::builder()
        .push_next(&mut external_info)
        .flags(create_flags)
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width,
            height,
            depth: 1,
        })
        .mip_levels(mip_levels)
        .array_layers(array_layers)
        .samples(vk::SampleCountFlags::_1)
        .tiling(tiling)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .queue_family_indices(&queue_family_indices)
        .initial_layout(vk::ImageLayout::UNDEFINED);
    let image = unsafe { device.create_image(&info, None) }.vk_check("vkCreateImage")?;
    Ok(Unique::new(device, image))
}
