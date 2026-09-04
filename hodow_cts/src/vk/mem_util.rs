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

    pub fn contains(self, other: Self) -> bool {
        (self.0 & other.0) == other.0
    }

    /// `MemoryRequirement::matchesHeap`
    fn matches_heap(self, property_flags: vk::MemoryPropertyFlags) -> bool {
        // Host-visible and local are mutually exclusive requests in upstream's model.
        debug_assert!(!(self.contains(Self::HOST_VISIBLE) && self.contains(Self::NON_LOCAL) && self.contains(Self::LOCAL)));

        if self.contains(Self::HOST_VISIBLE) && !property_flags.contains(vk::MemoryPropertyFlags::HOST_VISIBLE) {
            return false;
        }
        if self.contains(Self::COHERENT) && !property_flags.contains(vk::MemoryPropertyFlags::HOST_COHERENT) {
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
}

impl SimpleAllocator {
    pub fn new(memory_properties: vk::PhysicalDeviceMemoryProperties) -> Self {
        Self { memory_properties }
    }

    /// `SimpleAllocator::allocate`
    pub fn allocate<'a>(&self, device: &'a Device, req: vk::MemoryRequirements, requirement: MemoryRequirement) -> Result<Allocation<'a>, TestError> {
        let memory_type_index = self.select_matching_memory_type(req.memory_type_bits, requirement)?;

        let info = vk::MemoryAllocateInfo::builder().allocation_size(req.size).memory_type_index(memory_type_index);

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
    fn select_matching_memory_type(&self, allowed_mem_type_bits: u32, requirement: MemoryRequirement) -> Result<u32, TestError> {
        let compatible_mem_types = allowed_mem_type_bits & ((1u32 << self.memory_properties.memory_type_count).wrapping_sub(1));

        for mem_type_ndx in 0..self.memory_properties.memory_type_count {
            if (compatible_mem_types & (1 << mem_type_ndx)) != 0 && requirement.matches_heap(self.memory_properties.memory_types[mem_type_ndx as usize].property_flags) {
                return Ok(mem_type_ndx);
            }
        }

        Err(TestError::NotSupported("No compatible memory type found".to_string()))
    }

    pub fn memory_properties(&self) -> &vk::PhysicalDeviceMemoryProperties {
        &self.memory_properties
    }
}

/// `vk::flushAlloc` - makes host writes visible to the device.
///
/// Upstream skips the flush when the memory type is HOST_COHERENT. This does not:
/// `vkFlushMappedMemoryRanges` on coherent memory is explicitly allowed and is a
/// no-op, and always issuing it keeps one code path instead of two.
pub fn flush_alloc(device: &Device, alloc: &Allocation<'_>) -> Result<(), TestError> {
    let range = vk::MappedMemoryRange::builder().memory(alloc.get_memory()).offset(alloc.get_offset()).size(vk::WHOLE_SIZE);
    unsafe { device.flush_mapped_memory_ranges(&[range]) }.vk_check("vkFlushMappedMemoryRanges")
}

/// `vk::invalidateAlloc` - makes device writes visible to the host.
pub fn invalidate_alloc(device: &Device, alloc: &Allocation<'_>) -> Result<(), TestError> {
    let range = vk::MappedMemoryRange::builder().memory(alloc.get_memory()).offset(alloc.get_offset()).size(vk::WHOLE_SIZE);
    unsafe { device.invalidate_mapped_memory_ranges(&[range]) }.vk_check("vkInvalidateMappedMemoryRanges")
}
