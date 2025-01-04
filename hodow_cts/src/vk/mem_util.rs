// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/framework/vulkan/vkMemUtil.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::KhrExternalMemoryFdExtensionDeviceCommands;

use crate::tcu::TestError;
use crate::vk::VkResultExt;

/// `vk::MemoryRequirement` - the host-side intent for an allocation, which decides
/// which memory type is selected.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub struct MemoryRequirement(u32);

impl MemoryRequirement {
    pub const ANY: Self = Self(0);
    pub const HOST_VISIBLE: Self = Self(1 << 0);
    pub const COHERENT: Self = Self(1 << 1);
    pub const LOCAL: Self = Self(1 << 2);
    pub const CACHED: Self = Self(1 << 3);
    pub const NON_LOCAL: Self = Self(1 << 4);
    pub const LAZILY_ALLOCATED: Self = Self(1 << 5);
    pub const PROTECTED: Self = Self(1 << 6);
    /// `MemoryRequirement::DeviceAddress` - the allocation is made with `VK_MEMORY_ALLOCATE_DEVICE_ADDRESS_BIT`.
    pub const DEVICE_ADDRESS: Self = Self(1 << 7);

    pub fn contains(self, other: Self) -> bool {
        (self.0 & other.0) == other.0
    }

    /// `MemoryRequirement::matchesHeap`
    pub fn matches_heap(self, property_flags: vk::MemoryPropertyFlags) -> bool {
        // Host-visible and local are mutually exclusive requests in upstream's model.
        debug_assert!(
            !(self.contains(Self::HOST_VISIBLE) && self.contains(Self::NON_LOCAL) && self.contains(Self::LOCAL))
        );
        debug_assert!(
            !(self.contains(Self::HOST_VISIBLE) && self.contains(Self::LAZILY_ALLOCATED)),
            "lazily allocated memory cannot be mappable"
        );

        if self.contains(Self::HOST_VISIBLE) && !property_flags.contains(vk::MemoryPropertyFlags::HOST_VISIBLE) {
            return false;
        }
        if self.contains(Self::COHERENT) && !property_flags.contains(vk::MemoryPropertyFlags::HOST_COHERENT) {
            return false;
        }
        if self.contains(Self::LAZILY_ALLOCATED) && !property_flags.contains(vk::MemoryPropertyFlags::LAZILY_ALLOCATED)
        {
            return false;
        }
        if self.contains(Self::PROTECTED) && !property_flags.contains(vk::MemoryPropertyFlags::PROTECTED) {
            return false;
        }
        if self.contains(Self::LOCAL) && !property_flags.contains(vk::MemoryPropertyFlags::DEVICE_LOCAL) {
            return false;
        }
        if self.contains(Self::CACHED) && !property_flags.contains(vk::MemoryPropertyFlags::HOST_CACHED) {
            return false;
        }
        if self.contains(Self::NON_LOCAL) && property_flags.contains(vk::MemoryPropertyFlags::DEVICE_LOCAL) {
            return false;
        }
        true
    }
}

impl std::ops::BitOr for MemoryRequirement {
    type Output = Self;

    fn bitor(self, rhs: Self) -> Self {
        Self(self.0 | rhs.0)
    }
}

/// `vk::Allocation` - one device memory allocation plus the host mapping, if any.
///
/// Upstream's `SimpleAllocator` hands out one `VkDeviceMemory` per allocation with
/// offset 0; this does the same, so `getOffset()` is always 0 here. The offset is
/// kept in the API because tests pass it explicitly to `bindBufferMemory` and one
/// of them (`api.smoke.triangle`) deliberately binds at a non-zero offset.
pub struct Allocation<'a> {
    device: &'a Device,
    memory: vk::DeviceMemory,
    offset: vk::DeviceSize,
    host_ptr: *mut u8,
}

impl<'a> Allocation<'a> {
    /// `SimpleAllocation` of the cross-instance tests: takes over a `VkDeviceMemory` made elsewhere (exported or imported through an
    /// external handle) and frees it on drop. Never host-mapped.
    pub fn from_memory(device: &'a Device, memory: vk::DeviceMemory) -> Self {
        Self {
            device,
            memory,
            offset: 0,
            host_ptr: std::ptr::null_mut(),
        }
    }

    pub fn get_memory(&self) -> vk::DeviceMemory {
        self.memory
    }

    pub fn get_offset(&self) -> vk::DeviceSize {
        self.offset
    }

    /// `Allocation::getHostPtr`. Only valid for host-visible allocations.
    pub fn get_host_ptr(&self) -> *mut u8 {
        assert!(!self.host_ptr.is_null(), "getHostPtr on a non-host-visible allocation");
        self.host_ptr
    }
}

impl Drop for Allocation<'_> {
    fn drop(&mut self) {
        unsafe {
            if !self.host_ptr.is_null() {
                self.device.unmap_memory(self.memory);
            }
            self.device.free_memory(self.memory, None);
        }
    }
}

/// `vk::SimpleAllocator` - one `vkAllocateMemory` per request, no suballocation.
///
/// This is what most CTS tests use; it keeps allocation behaviour trivially
/// predictable, which matters when the thing under test is the driver's memory
/// handling.
pub struct SimpleAllocator {
    memory_properties: vk::PhysicalDeviceMemoryProperties,
    offset_params: Option<OffsetParams>,
    dma_heap: bool,
}

/// `SimpleAllocator::OptionalOffsetParams`: every allocation is made `offset` bytes larger (rounded up to
/// a multiple of both the non-coherent atom size and the resource's alignment) and the resource is
/// bound at that offset.
#[derive(Clone, Copy)]
pub struct OffsetParams {
    pub non_coherent_atom_size: vk::DeviceSize,
    pub offset: vk::DeviceSize,
}

fn gcd(a: vk::DeviceSize, b: vk::DeviceSize) -> vk::DeviceSize {
    if b == 0 { a } else { gcd(b, a % b) }
}

impl SimpleAllocator {
    pub fn new(memory_properties: vk::PhysicalDeviceMemoryProperties) -> Self {
        Self {
            memory_properties,
            offset_params: None,
            dma_heap: false,
        }
    }

    /// `DmaHeapAllocator`: every allocation is a buffer of `/dev/dma_heap/system` imported as a DMA_BUF.
    pub fn dma_heap(
        memory_properties: vk::PhysicalDeviceMemoryProperties,
        offset_params: Option<OffsetParams>,
    ) -> Self {
        debug_assert!(
            offset_params.is_none_or(|params| params.offset == 0 || params.non_coherent_atom_size != 0),
            "an offset needs a non-coherent atom size"
        );
        Self {
            memory_properties,
            offset_params,
            dma_heap: true,
        }
    }

    /// `SimpleAllocator(vk, device, memProps, OptionalOffsetParams({atomSize, offset}))`
    pub fn with_offset(memory_properties: vk::PhysicalDeviceMemoryProperties, offset_params: OffsetParams) -> Self {
        debug_assert!(
            offset_params.offset == 0 || offset_params.non_coherent_atom_size != 0,
            "an offset needs a non-coherent atom size"
        );
        Self {
            memory_properties,
            offset_params: Some(offset_params),
            dma_heap: false,
        }
    }

    /// The offset `allocate` binds a resource with this alignment at.
    fn allocation_offset(&self, alignment: vk::DeviceSize) -> vk::DeviceSize {
        match self.offset_params {
            Some(params) if params.offset != 0 => {
                let atom = params.non_coherent_atom_size.max(1);
                let alignment = alignment.max(1);
                let required_alignment = atom / gcd(atom, alignment) * alignment;
                params.offset.div_ceil(required_alignment) * required_alignment
            }
            _ => 0,
        }
    }

    /// `SimpleAllocator::allocate`
    pub fn allocate<'a>(
        &self,
        device: &'a Device,
        req: vk::MemoryRequirements,
        requirement: MemoryRequirement,
    ) -> Result<Allocation<'a>, TestError> {
        let offset = self.allocation_offset(req.alignment);
        if self.dma_heap {
            return self.allocate_dma_heap(device, req, requirement, offset);
        }
        let memory_type_index = self.select_matching_memory_type(req.memory_type_bits, requirement)?;

        let mut flags_info = vk::MemoryAllocateFlagsInfo::builder().flags(vk::MemoryAllocateFlags::DEVICE_ADDRESS);
        let mut info = vk::MemoryAllocateInfo::builder()
            .allocation_size(req.size + offset)
            .memory_type_index(memory_type_index);
        if requirement.contains(MemoryRequirement::DEVICE_ADDRESS) {
            info = info.push_next(&mut flags_info);
        }

        let memory = unsafe { device.allocate_memory(&info, None) }.vk_check("vkAllocateMemory")?;

        let host_ptr = if requirement.contains(MemoryRequirement::HOST_VISIBLE) {
            match unsafe { device.map_memory(memory, 0, vk::WHOLE_SIZE, vk::MemoryMapFlags::empty()) } {
                Ok(p) => unsafe { p.cast::<u8>().add(offset as usize) },
                Err(e) => {
                    unsafe { device.free_memory(memory, None) };
                    return Err(TestError::ResourceError(format!("vkMapMemory failed: {e}")));
                }
            }
        } else {
            std::ptr::null_mut()
        };

        Ok(Allocation {
            device,
            memory,
            offset,
            host_ptr,
        })
    }

    /// `allocateExtended`: the allocation made with the given `VkMemoryAllocateFlags` and, for a buffer device address replay, with the
    /// opaque capture address the memory was originally allocated at.
    pub fn allocate_with_flags<'a>(
        &self,
        device: &'a Device,
        req: vk::MemoryRequirements,
        requirement: MemoryRequirement,
        flags: vk::MemoryAllocateFlags,
        opaque_capture_address: Option<u64>,
    ) -> Result<Allocation<'a>, TestError> {
        let memory_type_index = self.select_matching_memory_type(req.memory_type_bits, requirement)?;

        let mut flags_info = vk::MemoryAllocateFlagsInfo::builder().flags(flags);
        let mut opaque_info = vk::MemoryOpaqueCaptureAddressAllocateInfo::builder()
            .opaque_capture_address(opaque_capture_address.unwrap_or(0));
        let mut info = vk::MemoryAllocateInfo::builder()
            .allocation_size(req.size)
            .memory_type_index(memory_type_index);
        if !flags.is_empty() {
            info = info.push_next(&mut flags_info);
        }
        if opaque_capture_address.is_some() {
            info = info.push_next(&mut opaque_info);
        }

        let memory = unsafe { device.allocate_memory(&info, None) }.vk_check("vkAllocateMemory")?;

        let host_ptr = if requirement.contains(MemoryRequirement::HOST_VISIBLE) {
            match unsafe { device.map_memory(memory, 0, vk::WHOLE_SIZE, vk::MemoryMapFlags::empty()) } {
                Ok(p) => p.cast::<u8>(),
                Err(e) => {
                    unsafe { device.free_memory(memory, None) };
                    return Err(TestError::ResourceError(format!("vkMapMemory failed: {e}")));
                }
            }
        } else {
            std::ptr::null_mut()
        };

        Ok(Allocation {
            device,
            memory,
            offset: 0,
            host_ptr,
        })
    }

    /// `DmaHeapAllocator::allocate(memReqs, requirement, ..)`; `offset` is already rounded to the alignment and the atom size.
    fn allocate_dma_heap<'a>(
        &self,
        device: &'a Device,
        req: vk::MemoryRequirements,
        requirement: MemoryRequirement,
        offset: vk::DeviceSize,
    ) -> Result<Allocation<'a>, TestError> {
        let allocation_size = req.size + offset;
        let mut dma_buf_fd = allocate_dma_heap_buffer(allocation_size)?;

        let mut fd_properties = vk::MemoryFdPropertiesKHR::default();
        unsafe {
            device.get_memory_fd_properties_khr(
                vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT,
                dma_buf_fd.fd(),
                &mut fd_properties,
            )
        }
        .vk_check("vkGetMemoryFdPropertiesKHR")?;

        let memory_type_index = (0..self.memory_properties.memory_type_count)
            .find(|&index| {
                let bit = 1u32 << index;
                fd_properties.memory_type_bits & req.memory_type_bits & bit != 0
                    && requirement.matches_heap(self.memory_properties.memory_types[index as usize].property_flags)
            })
            .ok_or_else(|| {
                TestError::NotSupported(
                    "Could not find any memory type compatible with both requested memory and DMA heap memory"
                        .to_string(),
                )
            })?;

        let mut import_info = vk::ImportMemoryFdInfoKHR {
            handle_type: vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT,
            fd: dma_buf_fd.fd(),
            ..Default::default()
        };
        let info = vk::MemoryAllocateInfo::builder()
            .allocation_size(allocation_size)
            .memory_type_index(memory_type_index)
            .push_next(&mut import_info);
        let memory = unsafe { device.allocate_memory(&info, None) }.vk_check("vkAllocateMemory")?;
        dma_buf_fd.release();

        let host_visible = self.memory_properties.memory_types[memory_type_index as usize]
            .property_flags
            .contains(vk::MemoryPropertyFlags::HOST_VISIBLE);
        let host_ptr = if host_visible {
            match unsafe { device.map_memory(memory, 0, vk::WHOLE_SIZE, vk::MemoryMapFlags::empty()) } {
                Ok(p) => unsafe { p.cast::<u8>().add(offset as usize) },
                Err(e) => {
                    unsafe { device.free_memory(memory, None) };
                    return Err(TestError::ResourceError(format!("vkMapMemory failed: {e}")));
                }
            }
        } else {
            std::ptr::null_mut()
        };

        Ok(Allocation {
            device,
            memory,
            offset,
            host_ptr,
        })
    }

    /// `SimpleAllocator::allocate` with a `VkMemoryDedicatedAllocateInfo` chained in.
    ///
    /// This is what the `dedicated_allocation` variants of the copy tests are about:
    /// the same allocation, but the driver is told up front that it backs exactly one
    /// buffer. Going through the plain path would silently test the suballocated case
    /// twice.
    pub fn allocate_dedicated_buffer<'a>(
        &self,
        device: &'a Device,
        req: vk::MemoryRequirements,
        requirement: MemoryRequirement,
        buffer: vk::Buffer,
    ) -> Result<Allocation<'a>, TestError> {
        let memory_type_index = self.select_matching_memory_type(req.memory_type_bits, requirement)?;

        let mut dedicated = vk::MemoryDedicatedAllocateInfo::builder().buffer(buffer);
        let info = vk::MemoryAllocateInfo::builder()
            .allocation_size(req.size)
            .memory_type_index(memory_type_index)
            .push_next(&mut dedicated);

        let memory = unsafe { device.allocate_memory(&info, None) }.vk_check("vkAllocateMemory")?;

        let host_ptr = if requirement.contains(MemoryRequirement::HOST_VISIBLE) {
            match unsafe { device.map_memory(memory, 0, vk::WHOLE_SIZE, vk::MemoryMapFlags::empty()) } {
                Ok(p) => p.cast::<u8>(),
                Err(e) => {
                    unsafe { device.free_memory(memory, None) };
                    return Err(TestError::ResourceError(format!("vkMapMemory failed: {e}")));
                }
            }
        } else {
            std::ptr::null_mut()
        };

        Ok(Allocation {
            device,
            memory,
            offset: 0,
            host_ptr,
        })
    }

    /// `SimpleAllocator::allocate` with a `VkMemoryDedicatedAllocateInfo` naming an
    /// image. The image twin of `allocate_dedicated_buffer`, and needed for the same
    /// reason: without it the `dedicated_allocation` half of a test group allocates
    /// exactly like the `core` half and the two test the same thing.
    pub fn allocate_dedicated_image<'a>(
        &self,
        device: &'a Device,
        req: vk::MemoryRequirements,
        requirement: MemoryRequirement,
        image: vk::Image,
    ) -> Result<Allocation<'a>, TestError> {
        let memory_type_index = self.select_matching_memory_type(req.memory_type_bits, requirement)?;

        let mut dedicated = vk::MemoryDedicatedAllocateInfo::builder().image(image);
        let info = vk::MemoryAllocateInfo::builder()
            .allocation_size(req.size)
            .memory_type_index(memory_type_index)
            .push_next(&mut dedicated);

        let memory = unsafe { device.allocate_memory(&info, None) }.vk_check("vkAllocateMemory")?;

        let host_ptr = if requirement.contains(MemoryRequirement::HOST_VISIBLE) {
            match unsafe { device.map_memory(memory, 0, vk::WHOLE_SIZE, vk::MemoryMapFlags::empty()) } {
                Ok(ptr) => ptr.cast::<u8>(),
                Err(e) => {
                    unsafe { device.free_memory(memory, None) };
                    return Err(TestError::ResourceError(format!("vkMapMemory failed: {e}")));
                }
            }
        } else {
            std::ptr::null_mut()
        };

        Ok(Allocation {
            device,
            memory,
            offset: 0,
            host_ptr,
        })
    }

    /// `vk::selectMatchingMemoryType`
    fn select_matching_memory_type(
        &self,
        allowed_mem_type_bits: u32,
        requirement: MemoryRequirement,
    ) -> Result<u32, TestError> {
        let compatible_mem_types =
            allowed_mem_type_bits & ((1u32 << self.memory_properties.memory_type_count).wrapping_sub(1));

        for mem_type_ndx in 0..self.memory_properties.memory_type_count {
            if (compatible_mem_types & (1 << mem_type_ndx)) != 0
                && requirement.matches_heap(self.memory_properties.memory_types[mem_type_ndx as usize].property_flags)
            {
                return Ok(mem_type_ndx);
            }
        }

        Err(TestError::NotSupported("No compatible memory type found".to_string()))
    }

    pub fn memory_properties(&self) -> &vk::PhysicalDeviceMemoryProperties {
        &self.memory_properties
    }
}

#[cfg(target_os = "linux")]
mod dma_heap_sys {
    use super::TestError;

    unsafe extern "C" {
        fn open(path: *const std::ffi::c_char, flags: i32, ...) -> i32;
        fn close(fd: i32) -> i32;
        fn ioctl(fd: i32, request: std::ffi::c_ulong, ...) -> i32;
    }

    const O_RDWR: i32 = 2;
    const O_CLOEXEC: i32 = 0o2000000;
    /// `_IOWR('H', 0, struct dma_heap_allocation_data)`, the struct being 32 bytes
    const DMA_HEAP_IOCTL_ALLOC: std::ffi::c_ulong = 0xC020_4800;

    /// `struct dma_heap_allocation_data`
    #[repr(C)]
    struct DmaHeapAllocationData {
        len: u64,
        fd: u32,
        fd_flags: u32,
        heap_flags: u64,
    }

    /// `DmaHeapBufferFd`: owns a file descriptor until `release`.
    pub struct DmaHeapBufferFd(i32);

    impl DmaHeapBufferFd {
        pub fn fd(&self) -> i32 {
            self.0
        }

        pub fn release(&mut self) {
            self.0 = -1;
        }
    }

    impl Drop for DmaHeapBufferFd {
        fn drop(&mut self) {
            if self.0 >= 0 {
                unsafe { close(self.0) };
            }
        }
    }

    /// `DmaHeapAllocator::isSupported` plus the open of the heap device, so a machine without one is NotSupported as upstream's
    /// `allocateDmaHeapBuffer` reports it.
    pub fn dma_heap_available() -> bool {
        let fd = unsafe {
            open(c"/dev/dma_heap/system".as_ptr(), 0 /* O_RDONLY */ | O_CLOEXEC)
        };
        if fd < 0 {
            return false;
        }
        unsafe { close(fd) };
        true
    }

    /// `allocateDmaHeapBuffer`
    pub fn allocate_dma_heap_buffer(size: u64) -> Result<DmaHeapBufferFd, TestError> {
        let heap_fd = unsafe { open(c"/dev/dma_heap/system".as_ptr(), O_CLOEXEC) };
        if heap_fd == -1 {
            return Err(TestError::NotSupported("Could not open DMA heap device".to_string()));
        }
        let mut data = DmaHeapAllocationData {
            len: size,
            fd: 0,
            fd_flags: (O_RDWR | O_CLOEXEC) as u32,
            heap_flags: 0,
        };
        let result = unsafe { ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &mut data as *mut DmaHeapAllocationData) };
        unsafe { close(heap_fd) };
        if result != 0 {
            return Err(TestError::NotSupported(
                "Error while allocating DMA heap memory".to_string(),
            ));
        }
        Ok(DmaHeapBufferFd(data.fd as i32))
    }
}

#[cfg(not(target_os = "linux"))]
mod dma_heap_sys {
    use super::TestError;

    pub struct DmaHeapBufferFd;

    impl DmaHeapBufferFd {
        pub fn fd(&self) -> i32 {
            -1
        }

        pub fn release(&mut self) {}
    }

    pub fn dma_heap_available() -> bool {
        false
    }

    pub fn allocate_dma_heap_buffer(_size: u64) -> Result<DmaHeapBufferFd, TestError> {
        Err(TestError::NotSupported("Could not open DMA heap device".to_string()))
    }
}

use dma_heap_sys::allocate_dma_heap_buffer;
pub use dma_heap_sys::dma_heap_available;

/// `vk::flushAlloc` - makes host writes visible to the device.
///
/// Upstream skips the flush when the memory type is HOST_COHERENT. This does not:
/// `vkFlushMappedMemoryRanges` on coherent memory is explicitly allowed and is a
/// no-op, and always issuing it keeps one code path instead of two.
pub fn flush_alloc(device: &Device, alloc: &Allocation<'_>) -> Result<(), TestError> {
    let range = vk::MappedMemoryRange::builder()
        .memory(alloc.get_memory())
        .offset(alloc.get_offset())
        .size(vk::WHOLE_SIZE);
    unsafe { device.flush_mapped_memory_ranges(&[range]) }.vk_check("vkFlushMappedMemoryRanges")
}

/// `vk::invalidateAlloc` - makes device writes visible to the host.
pub fn invalidate_alloc(device: &Device, alloc: &Allocation<'_>) -> Result<(), TestError> {
    let range = vk::MappedMemoryRange::builder()
        .memory(alloc.get_memory())
        .offset(alloc.get_offset())
        .size(vk::WHOLE_SIZE);
    unsafe { device.invalidate_mapped_memory_ranges(&[range]) }.vk_check("vkInvalidateMappedMemoryRanges")
}
