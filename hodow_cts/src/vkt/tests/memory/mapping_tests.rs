// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory/vktMemoryMappingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// These cases are about mapping semantics, so none of them goes through
// `vk::SimpleAllocator`: that helper maps every host-visible allocation at creation
// with offset 0 and size VK_WHOLE_SIZE, which is exactly the behaviour under test.
// vkAllocateMemory / vkMapMemory / vkFlushMappedMemoryRanges are called directly here,
// the way upstream does.
//
// No shaders: `programs()` hands back an empty collection.

use std::alloc::Layout;
use std::cell::RefCell;
use std::ffi::{c_char, c_void};
use std::rc::Rc;
use std::sync::Mutex;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, InstanceV1_1, KhrMapMemory2ExtensionDeviceCommands};

use crate::tcu::{Random, TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

fn div_round_up(a: u64, b: u64) -> u64 {
    (a / b) + if a.is_multiple_of(b) { 0 } else { 1 }
}

fn round_down_to_multiple(a: u64, b: u64) -> u64 {
    b * (a / b)
}

fn round_up_to_multiple(a: u64, b: u64) -> u64 {
    b * (a / b + if a.is_multiple_of(b) { 0 } else { 1 })
}

/// `de::Random::getUint8`, which `tcu::Random` does not carry yet.
fn get_uint8(rng: &mut Random) -> u8 {
    rng.get_uint32() as u8
}

/// `deSmallestGreaterOrEquallPowerOfTwoU32`
fn smallest_greater_or_equal_power_of_two_u32(a: u32) -> u32 {
    let mut a = a.wrapping_sub(1);
    a |= a >> 1;
    a |= a >> 2;
    a |= a >> 4;
    a |= a >> 8;
    a |= a >> 16;
    a.wrapping_add(1)
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum AllocationKind {
    Suballocated = 0,
    DedicatedBuffer = 1,
    DedicatedImage = 2,
}

const ALLOCATION_KIND_LAST: usize = 3;

const ALLOCATION_KINDS: [AllocationKind; ALLOCATION_KIND_LAST] = [
    AllocationKind::Suballocated,
    AllocationKind::DedicatedBuffer,
    AllocationKind::DedicatedImage,
];

/// `mapMemoryWrapper`
fn map_memory_wrapper(
    vkd: &Device,
    memory: vk::DeviceMemory,
    mapping_offset: vk::DeviceSize,
    mapping_size: vk::DeviceSize,
    use_map2: bool,
) -> Result<*mut c_void, TestError> {
    if !use_map2 {
        unsafe { vkd.map_memory(memory, mapping_offset, mapping_size, vk::MemoryMapFlags::empty()) }
            .vk_check("vkMapMemory")
    } else {
        let info = vk::MemoryMapInfo {
            s_type: vk::StructureType::MEMORY_MAP_INFO,
            next: std::ptr::null(),
            flags: vk::MemoryMapFlags::empty(),
            memory,
            offset: mapping_offset,
            size: mapping_size,
        };
        unsafe { vkd.map_memory2_khr(&info) }.vk_check("vkMapMemory2")
    }
}

/// `unmapMemoryWrapper`
fn unmap_memory_wrapper(vkd: &Device, memory: vk::DeviceMemory, use_map2: bool) -> Result<(), TestError> {
    if !use_map2 {
        unsafe { vkd.unmap_memory(memory) };
        Ok(())
    } else {
        let unmap = vk::MemoryUnmapInfo {
            s_type: vk::StructureType::MEMORY_UNMAP_INFO,
            next: std::ptr::null(),
            flags: vk::MemoryUnmapFlags::empty(),
            memory,
        };
        unsafe { vkd.unmap_memory2_khr(&unmap) }.vk_check("vkUnmapMemory2")
    }
}

// \note Bit vector that guarantees that each value takes only one bit.
// std::vector<bool> is often optimized to only take one bit for each bool, but
// that is implementation detail and in this case we really need to known how much
// memory is used.
struct BitVector {
    data: Vec<u32>,
}

impl BitVector {
    const BLOCK_BIT_SIZE: usize = 8 * std::mem::size_of::<u32>();

    fn new(size: usize, value: bool) -> Self {
        Self {
            data: vec![
                if value { !0x0u32 } else { 0x0u32 };
                div_round_up(size as u64, Self::BLOCK_BIT_SIZE as u64) as usize
            ],
        }
    }

    fn get(&self, ndx: usize) -> bool {
        (self.data[ndx / Self::BLOCK_BIT_SIZE] & (0x1u32 << (ndx % Self::BLOCK_BIT_SIZE))) != 0
    }

    fn set(&mut self, ndx: usize, value: bool) {
        if value {
            self.data[ndx / Self::BLOCK_BIT_SIZE] |= 0x1u32 << (ndx % Self::BLOCK_BIT_SIZE);
        } else {
            self.data[ndx / Self::BLOCK_BIT_SIZE] &= !(0x1u32 << (ndx % Self::BLOCK_BIT_SIZE));
        }
    }

    fn set_range(&mut self, offset: usize, count: usize, value: bool) {
        let mut ndx = offset;

        while (ndx < offset + count) && !ndx.is_multiple_of(Self::BLOCK_BIT_SIZE) {
            self.set(ndx, value);
            ndx += 1;
        }

        {
            let end_of_full_block_ndx =
                round_down_to_multiple((offset + count) as u64, Self::BLOCK_BIT_SIZE as u64) as usize;

            if ndx < end_of_full_block_ndx {
                let first = ndx / Self::BLOCK_BIT_SIZE;
                let last = end_of_full_block_ndx / Self::BLOCK_BIT_SIZE;
                for block in &mut self.data[first..last] {
                    *block = if value { !0x0u32 } else { 0x0u32 };
                }
                ndx = end_of_full_block_ndx;
            }
        }

        while ndx < offset + count {
            self.set(ndx, value);
            ndx += 1;
        }
    }

    fn vector_and(&mut self, other: &BitVector, offset: usize, count: usize) {
        let mut ndx = offset;

        while ndx < offset + count && !ndx.is_multiple_of(Self::BLOCK_BIT_SIZE) {
            let v = other.get(ndx) && self.get(ndx);
            self.set(ndx, v);
            ndx += 1;
        }

        while ndx < round_down_to_multiple((offset + count) as u64, Self::BLOCK_BIT_SIZE as u64) as usize {
            self.data[ndx / Self::BLOCK_BIT_SIZE] &= other.data[ndx / Self::BLOCK_BIT_SIZE];
            ndx += Self::BLOCK_BIT_SIZE;
        }

        while ndx < offset + count {
            let v = other.get(ndx) && self.get(ndx);
            self.set(ndx, v);
            ndx += 1;
        }
    }
}

struct ReferenceMemory {
    atom_size: usize,
    bytes: Vec<u8>,
    defined: BitVector,
    flushed: BitVector,
}

impl ReferenceMemory {
    fn new(size: usize, atom_size: usize) -> Self {
        Self {
            atom_size,
            bytes: vec![0xDEu8; size],
            defined: BitVector::new(size, false),
            flushed: BitVector::new(size / atom_size, false),
        }
    }

    fn write(&mut self, pos: usize, value: u8) {
        self.bytes[pos] = value;
        self.defined.set(pos, true);
        self.flushed.set(pos / self.atom_size, false);
    }

    fn read(&mut self, pos: usize, value: u8) -> bool {
        let is_ok = !self.defined.get(pos) || self.bytes[pos] == value;

        self.bytes[pos] = value;
        self.defined.set(pos, true);

        is_ok
    }

    fn modify_xor(&mut self, pos: usize, value: u8, mask: u8) -> bool {
        let is_ok = !self.defined.get(pos) || self.bytes[pos] == value;

        self.bytes[pos] = value ^ mask;
        self.defined.set(pos, true);
        self.flushed.set(pos / self.atom_size, false);

        is_ok
    }

    fn flush(&mut self, offset: usize, size: usize) {
        self.flushed
            .set_range(offset / self.atom_size, size / self.atom_size, true);
    }

    fn invalidate(&mut self, offset: usize, size: usize) {
        if self.atom_size == 1 {
            let flushed = std::mem::replace(&mut self.flushed, BitVector::new(0, false));
            self.defined.vector_and(&flushed, offset, size);
            self.flushed = flushed;
        } else {
            for ndx in 0..size / self.atom_size {
                if !self.flushed.get((offset / self.atom_size) + ndx) {
                    self.defined
                        .set_range(offset + ndx * self.atom_size, self.atom_size, false);
                }
            }
        }
    }
}

#[derive(Debug, Clone, Copy)]
struct MemoryType {
    index: u32,
    /// Kept because upstream's `MemoryType` carries it, even though only the index is
    /// read here.
    #[allow(dead_code)]
    ty: vk::MemoryType,
}

// ---------------------------------------------------------------------------------
// Allocation callbacks
//
// `implicit_unmap` is the only reason this exists: it frees a still-mapped
// VkDeviceMemory through its own VkAllocationCallbacks and then checks that the
// driver left nothing live behind. Upstream uses the framework's
// AllocationCallbackRecorder for that; this is the slice of it these tests use.
// ---------------------------------------------------------------------------------

struct AllocationCallbackRecorder {
    live: Mutex<std::collections::HashMap<usize, (usize, usize)>>,
    callbacks: vk::AllocationCallbacks,
}

impl AllocationCallbackRecorder {
    fn new() -> Box<Self> {
        let mut recorder = Box::new(Self {
            live: Mutex::new(std::collections::HashMap::new()),
            callbacks: vk::AllocationCallbacks {
                user_data: std::ptr::null_mut(),
                allocation: Some(allocation_callback),
                reallocation: Some(reallocation_callback),
                free: Some(free_callback),
                internal_allocation: None,
                internal_free: None,
            },
        });
        // The pointer has to be taken after boxing: it must survive every move of the
        // handle, and only the heap allocation behind the Box does.
        let self_ptr: *mut Self = &raw mut *recorder;
        recorder.callbacks.user_data = self_ptr.cast();
        recorder
    }

    fn get_callbacks(&self) -> &vk::AllocationCallbacks {
        &self.callbacks
    }

    /// `getLiveSystemAllocationTotal`
    fn live_allocation_total(&self) -> usize {
        self.live.lock().unwrap().values().map(|(size, _)| *size).sum()
    }

    fn live_allocation_count(&self) -> usize {
        self.live.lock().unwrap().len()
    }

    fn allocate(&self, size: usize, alignment: usize) -> *mut c_void {
        let alignment = if alignment == 0 { 1 } else { alignment };
        // A zero-sized allocation has no valid Layout; deqp's system allocator hands
        // back a unique pointer for it, so one aligned byte is allocated instead.
        let size = if size == 0 { alignment } else { size };
        let Ok(layout) = Layout::from_size_align(size, alignment) else {
            return std::ptr::null_mut();
        };
        let ptr = unsafe { std::alloc::alloc(layout) };
        if ptr.is_null() {
            return std::ptr::null_mut();
        }
        self.live.lock().unwrap().insert(ptr as usize, (size, alignment));
        ptr.cast()
    }

    fn reallocate(&self, original: *mut c_void, size: usize, alignment: usize) -> *mut c_void {
        if original.is_null() {
            return self.allocate(size, alignment);
        }
        if size == 0 {
            self.free(original);
            return std::ptr::null_mut();
        }

        let alignment = if alignment == 0 { 1 } else { alignment };
        let Some((old_size, old_alignment)) = self.live.lock().unwrap().remove(&(original as usize)) else {
            return std::ptr::null_mut();
        };
        let Ok(old_layout) = Layout::from_size_align(old_size, old_alignment) else {
            return std::ptr::null_mut();
        };

        if old_alignment == alignment {
            let ptr = unsafe { std::alloc::realloc(original.cast(), old_layout, size) };
            if ptr.is_null() {
                // The old block is still live after a failed realloc; put it back.
                self.live
                    .lock()
                    .unwrap()
                    .insert(original as usize, (old_size, old_alignment));
                return std::ptr::null_mut();
            }
            self.live.lock().unwrap().insert(ptr as usize, (size, alignment));
            return ptr.cast();
        }

        // Vulkan requires the same alignment across reallocations of one block, so this
        // path is defensive only.
        let ptr = self.allocate(size, alignment);
        if !ptr.is_null() {
            unsafe { std::ptr::copy_nonoverlapping(original.cast::<u8>(), ptr.cast::<u8>(), old_size.min(size)) };
        }
        unsafe { std::alloc::dealloc(original.cast(), old_layout) };
        ptr
    }

    fn free(&self, memory: *mut c_void) {
        if memory.is_null() {
            return;
        }
        let entry = self.live.lock().unwrap().remove(&(memory as usize));
        if let Some((size, alignment)) = entry {
            let layout = Layout::from_size_align(size, alignment).unwrap();
            unsafe { std::alloc::dealloc(memory.cast(), layout) };
        }
    }
}

unsafe extern "system" fn allocation_callback(
    user_data: *mut c_void,
    size: usize,
    alignment: usize,
    _scope: vk::SystemAllocationScope,
) -> *mut c_void {
    let recorder = unsafe { &*user_data.cast::<AllocationCallbackRecorder>() };
    recorder.allocate(size, alignment)
}

unsafe extern "system" fn reallocation_callback(
    user_data: *mut c_void,
    original: *mut c_void,
    size: usize,
    alignment: usize,
    _scope: vk::SystemAllocationScope,
) -> *mut c_void {
    let recorder = unsafe { &*user_data.cast::<AllocationCallbackRecorder>() };
    recorder.reallocate(original, size, alignment)
}

unsafe extern "system" fn free_callback(user_data: *mut c_void, memory: *mut c_void) {
    let recorder = unsafe { &*user_data.cast::<AllocationCallbackRecorder>() };
    recorder.free(memory);
}

/// `computeDeviceMemorySystemMemFootprint`
fn compute_device_memory_system_mem_footprint(vk: &Device) -> usize {
    let callback_recorder = AllocationCallbackRecorder::new();

    {
        // 1 B allocation from memory type 0
        let alloc_info = vk::MemoryAllocateInfo {
            s_type: vk::StructureType::MEMORY_ALLOCATE_INFO,
            next: std::ptr::null(),
            allocation_size: 1,
            memory_type_index: 0,
        };
        let Ok(memory) = (unsafe { vk.allocate_memory(&alloc_info, Some(callback_recorder.get_callbacks())) }) else {
            // Upstream TCU_CHECKs here; a driver that will not hand out one byte of
            // memory type 0 simply gives no footprint estimate, which only makes the
            // random cases allocate a little more conservatively.
            return 0;
        };

        let total = callback_recorder.live_allocation_total()
            + std::mem::size_of::<*const c_void>() * callback_recorder.live_allocation_count(); // allocation overhead

        unsafe { vk.free_memory(memory, Some(callback_recorder.get_callbacks())) };

        total
    }
}

/// `makeImage`
fn make_image(vk: &Device, size: vk::DeviceSize, queue_family_index: u32) -> Result<Unique<'_, vk::Image>, TestError> {
    const FORMATS: [vk::Format; 3] = [
        vk::Format::R8G8B8A8_UINT,
        vk::Format::R16G16B16A16_UINT,
        vk::Format::R32G32B32A32_UINT,
    ];
    // `vk::mapVkFormat(f).getPixelSize()` for the three formats above; the texture
    // format layer is not ported, and these are the only formats this function uses.
    const PIXEL_SIZES: [vk::DeviceSize; 3] = [4, 8, 16];

    let mut format = vk::Format::UNDEFINED;
    let mut power_of_two_size = 0u32;

    for (ndx, f) in FORMATS.into_iter().enumerate() {
        let pixel_size = PIXEL_SIZES[ndx];
        let size_in_pixels = (size + 3) / pixel_size;
        let sqrt_size = (size_in_pixels as f32).sqrt().ceil() as u32;

        format = f;
        power_of_two_size = smallest_greater_or_equal_power_of_two_u32(sqrt_size);

        // maxImageDimension2D
        if power_of_two_size < 4096 {
            break;
        }
    }

    let queue_family_indices = [queue_family_index];
    let color_image_params = vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::empty(),
        image_type: vk::ImageType::_2D,
        format,
        extent: vk::Extent3D {
            width: power_of_two_size,
            height: power_of_two_size,
            depth: 1,
        },
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::LINEAR,
        usage: vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 1,
        queue_family_indices: queue_family_indices.as_ptr(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    };

    let image = unsafe { vk.create_image(&color_image_params, None) }.vk_check("vkCreateImage")?;
    Ok(Unique::new(vk, image))
}

/// `makeBufferQF`
fn make_buffer_qf(
    vk: &Device,
    size: vk::DeviceSize,
    queue_family_index: u32,
) -> Result<Unique<'_, vk::Buffer>, TestError> {
    let queue_family_indices = [queue_family_index];
    let buffer_params = vk::BufferCreateInfo {
        s_type: vk::StructureType::BUFFER_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::BufferCreateFlags::empty(),
        size,
        usage: vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 1,
        queue_family_indices: queue_family_indices.as_ptr(),
    };
    let buffer = unsafe { vk.create_buffer(&buffer_params, None) }.vk_check("vkCreateBuffer")?;
    Ok(Unique::new(vk, buffer))
}

/// `getImageMemoryRequirements`
fn get_image_memory_requirements(vk: &Device, image: vk::Image) -> vk::MemoryRequirements {
    let info = vk::ImageMemoryRequirementsInfo2 {
        s_type: vk::StructureType::IMAGE_MEMORY_REQUIREMENTS_INFO_2,
        next: std::ptr::null(),
        image,
    };
    let mut dedicated_requirements = vk::MemoryDedicatedRequirements {
        s_type: vk::StructureType::MEMORY_DEDICATED_REQUIREMENTS,
        next: std::ptr::null_mut(),
        prefers_dedicated_allocation: vk::FALSE,
        requires_dedicated_allocation: vk::FALSE,
    };
    let mut req2 = vk::MemoryRequirements2 {
        s_type: vk::StructureType::MEMORY_REQUIREMENTS_2,
        next: (&raw mut dedicated_requirements).cast(),
        memory_requirements: vk::MemoryRequirements::default(),
    };

    unsafe { vk.get_image_memory_requirements2(&info, &mut req2) };

    req2.memory_requirements
}

/// `getBufferMemoryRequirements`
fn get_buffer_memory_requirements(vk: &Device, buffer: vk::Buffer) -> vk::MemoryRequirements {
    let info = vk::BufferMemoryRequirementsInfo2 {
        s_type: vk::StructureType::BUFFER_MEMORY_REQUIREMENTS_INFO_2,
        next: std::ptr::null(),
        buffer,
    };
    let mut dedicated_requirements = vk::MemoryDedicatedRequirements {
        s_type: vk::StructureType::MEMORY_DEDICATED_REQUIREMENTS,
        next: std::ptr::null_mut(),
        prefers_dedicated_allocation: vk::FALSE,
        requires_dedicated_allocation: vk::FALSE,
    };
    let mut req2 = vk::MemoryRequirements2 {
        s_type: vk::StructureType::MEMORY_REQUIREMENTS_2,
        next: (&raw mut dedicated_requirements).cast(),
        memory_requirements: vk::MemoryRequirements::default(),
    };

    unsafe { vk.get_buffer_memory_requirements2(&info, &mut req2) };

    req2.memory_requirements
}

/// `Move<VkDeviceMemory>`, plus the allocation callbacks the memory was allocated
/// with so `implicit_unmap` can free it through the same recorder upstream does.
struct ScopedDeviceMemory<'a> {
    vkd: &'a Device,
    memory: vk::DeviceMemory,
    allocator: Option<&'a vk::AllocationCallbacks>,
}

impl<'a> ScopedDeviceMemory<'a> {
    fn get(&self) -> vk::DeviceMemory {
        self.memory
    }

    /// `Move<T>::disown` - hands the handle over, leaving nothing for Drop to free.
    fn disown(&mut self) -> vk::DeviceMemory {
        std::mem::replace(&mut self.memory, vk::DeviceMemory::null())
    }
}

impl Drop for ScopedDeviceMemory<'_> {
    fn drop(&mut self) {
        if self.memory != vk::DeviceMemory::null() {
            unsafe { self.vkd.free_memory(self.memory, self.allocator) };
        }
    }
}

/// `allocMemory(vk, device, size, memoryTypeIndex)`
fn alloc_memory(
    vk: &Device,
    p_alloc_info_allocation_size: vk::DeviceSize,
    p_alloc_info_memory_type_index: u32,
) -> Result<ScopedDeviceMemory<'_>, TestError> {
    let p_alloc_info = vk::MemoryAllocateInfo {
        s_type: vk::StructureType::MEMORY_ALLOCATE_INFO,
        next: std::ptr::null(),
        allocation_size: p_alloc_info_allocation_size,
        memory_type_index: p_alloc_info_memory_type_index,
    };
    let memory = unsafe { vk.allocate_memory(&p_alloc_info, None) }.vk_check("vkAllocateMemory")?;
    Ok(ScopedDeviceMemory {
        vkd: vk,
        memory,
        allocator: None,
    })
}

/// `findLargeAllocationSize`
fn find_large_allocation_size(vk: &Device, max: vk::DeviceSize, memory_type_index: u32) -> vk::DeviceSize {
    // max must be power of two
    let mut size = max;

    while size > 0 {
        let alloc_info = vk::MemoryAllocateInfo {
            s_type: vk::StructureType::MEMORY_ALLOCATE_INFO,
            next: std::ptr::null(),
            allocation_size: size,
            memory_type_index,
        };

        if let Ok(memory) = unsafe { vk.allocate_memory(&alloc_info, None) } {
            unsafe { vk.free_memory(memory, None) };
            return size;
        }

        size >>= 1;
    }

    0
}

/// `allocMemory(vk, device, size, memoryTypeIndex, image, buffer, allocator)`
fn alloc_memory_dedicated<'a>(
    vk: &'a Device,
    p_alloc_info_allocation_size: vk::DeviceSize,
    p_alloc_info_memory_type_index: u32,
    image: vk::Image,
    buffer: vk::Buffer,
    allocator: Option<&'a vk::AllocationCallbacks>,
) -> Result<ScopedDeviceMemory<'a>, TestError> {
    let dedicated_allocate_info = vk::MemoryDedicatedAllocateInfo {
        s_type: vk::StructureType::MEMORY_DEDICATED_ALLOCATE_INFO,
        next: std::ptr::null(),
        image,
        buffer,
    };

    let p_alloc_info = vk::MemoryAllocateInfo {
        s_type: vk::StructureType::MEMORY_ALLOCATE_INFO,
        next: if image == vk::Image::null() && buffer == vk::Buffer::null() {
            std::ptr::null()
        } else {
            (&raw const dedicated_allocate_info).cast()
        },
        allocation_size: p_alloc_info_allocation_size,
        memory_type_index: p_alloc_info_memory_type_index,
    };
    let memory = unsafe { vk.allocate_memory(&p_alloc_info, allocator) }.vk_check("vkAllocateMemory")?;
    Ok(ScopedDeviceMemory {
        vkd: vk,
        memory,
        allocator,
    })
}

#[derive(Debug, Clone, Copy)]
struct MemoryRange {
    offset: vk::DeviceSize,
    size: vk::DeviceSize,
}

impl MemoryRange {
    fn new(offset: vk::DeviceSize, size: vk::DeviceSize) -> Self {
        Self { offset, size }
    }
}

struct TestConfig {
    allocation_size: vk::DeviceSize,
    seed: u32,

    mapping: MemoryRange,
    flush_mappings: Vec<MemoryRange>,
    invalidate_mappings: Vec<MemoryRange>,
    remap: bool,
    implicit_unmap: bool,
    allocation_kind: AllocationKind,
    memory_map2: bool,
}

/// `compareAndLogBuffer`
///
/// The `result[ndx * stride]` indexing is upstream's and is kept verbatim: with the
/// loop already stepping by `stride` it samples a sparse subset for `implicit_unmap`,
/// and changing it would compare something upstream does not.
fn compare_and_log_buffer(size: usize, reference_size: usize, result: *const u8, reference: &[u8]) -> bool {
    let stride = size / reference_size;
    let mut failed_bytes = 0usize;
    let mut first_failed = usize::MAX;

    let mut ndx = 0usize;
    while ndx < reference_size {
        if unsafe { *result.add(ndx * stride) } != reference[ndx] {
            failed_bytes += 1;

            if first_failed == usize::MAX {
                first_failed = ndx;
            }
        }
        ndx += stride;
    }

    if failed_bytes > 0 {
        log::error!("Comparison failed. Failed bytes {failed_bytes}. First failed at offset {first_failed}.");

        let mut expected_values = String::new();
        let mut result_values = String::new();

        let mut ndx = first_failed;
        while ndx < first_failed + 10 && ndx < reference_size {
            if ndx != first_failed {
                expected_values.push_str(", ");
                result_values.push_str(", ");
            }

            expected_values.push_str(&reference[ndx].to_string());
            result_values.push_str(&unsafe { *result.add(ndx * stride) }.to_string());
            ndx += 1;
        }

        if first_failed + 10 < size {
            expected_values.push_str("...");
            result_values.push_str("...");
        }

        log::error!("Expected values at offset: {first_failed}, {expected_values}");
        log::error!("Result values at offset: {first_failed}, {result_values}");

        false
    } else {
        true
    }
}

/// `tcu::ResultCollector` - keeps the worst verdict seen and the message that caused
/// it, which is how upstream turns a loop over memory types into one status.
struct ResultCollector {
    result: Option<TestResult>,
    message: String,
}

impl ResultCollector {
    fn new() -> Self {
        Self {
            result: None,
            message: "Pass".to_string(),
        }
    }

    /// `testResultSeverity`
    fn severity(result: TestResult) -> i32 {
        match result {
            TestResult::Pass => 0,
            TestResult::Pending => 10,
            TestResult::NotSupported => 20,
            TestResult::QualityWarning => 30,
            TestResult::CompatibilityWarning | TestResult::CapabilityWarning => 40,
            TestResult::Timeout => 50,
            TestResult::Fail => 100,
            TestResult::ResourceError => 110,
            TestResult::InternalError => 120,
            TestResult::Crash | TestResult::DeviceLost => 150,
        }
    }

    fn get_result(&self) -> TestResult {
        self.result.unwrap_or(TestResult::Pass)
    }

    fn add_result(&mut self, result: TestResult, msg: String) {
        log::error!("{msg}");

        if Self::severity(result) > self.result.map_or(-1, Self::severity) {
            self.result = Some(result);
            self.message = msg;
        }
    }

    fn fail(&mut self, msg: String) {
        self.add_result(TestResult::Fail, msg);
    }
}

/// `DeviceWrapper` - either the Context's device or the protected-memory device
/// `implicit_unmap` builds for itself. Declared before anything allocated from it so
/// it is destroyed last.
enum DeviceWrapper<'a> {
    Default(&'a Device),
    // Boxed only because a `Device` is a whole dispatch table and would otherwise make
    // every `DeviceWrapper` that size.
    Custom(Box<Device>),
}

impl DeviceWrapper<'_> {
    fn get_driver(&self) -> &Device {
        match self {
            Self::Default(d) => d,
            Self::Custom(d) => d,
        }
    }
}

impl Drop for DeviceWrapper<'_> {
    fn drop(&mut self) {
        if let Self::Custom(device) = self {
            unsafe {
                let _ = device.device_wait_idle();
                device.destroy_device(None);
            }
        }
    }
}

/// `createProtectedMemoryDevice`
fn create_protected_memory_device<'a>(
    context: &Context<'_>,
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    features2: &vk::PhysicalDeviceFeatures2,
) -> Result<DeviceWrapper<'a>, TestError> {
    let queue_priority = 1.0f32;
    let queue_family_index = context.get_universal_queue_family_index();

    // Enable VK_KHR_map_memory2 if supported, as required by some tests.
    let map_memory2 = std::ffi::CString::new("VK_KHR_map_memory2").unwrap();
    let mut enabled_extensions: Vec<*const c_char> = Vec::new();
    if context.require_device_functionality("VK_KHR_map_memory2").is_ok() {
        enabled_extensions.push(map_memory2.as_ptr());
    }

    let queue_info = vk::DeviceQueueCreateInfo {
        s_type: vk::StructureType::DEVICE_QUEUE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::DeviceQueueCreateFlags::PROTECTED,
        queue_family_index,
        queue_count: 1,
        queue_priorities: &raw const queue_priority,
    };

    let device_info = vk::DeviceCreateInfo {
        s_type: vk::StructureType::DEVICE_CREATE_INFO,
        next: (features2 as *const vk::PhysicalDeviceFeatures2).cast(),
        flags: vk::DeviceCreateFlags::empty(),
        queue_create_info_count: 1,
        queue_create_infos: &raw const queue_info,
        enabled_layer_count: 0,
        enabled_layer_names: std::ptr::null(),
        enabled_extension_count: enabled_extensions.len() as u32,
        enabled_extension_names: enabled_extensions.as_ptr(),
        enabled_features: std::ptr::null(),
    };

    let device = unsafe { instance.create_device(physical_device, &device_info, None) }.vk_check("vkCreateDevice")?;
    Ok(DeviceWrapper::Custom(Box::new(device)))
}

/// `testMemoryMapping`
fn test_memory_mapping(context: &Context<'_>, config: &TestConfig) -> TestOutcome {
    let mut result = ResultCollector::new();
    let mut at_least_one_test_performed = false;
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();
    let memory_properties = unsafe { instance.get_physical_device_memory_properties(physical_device) };
    let non_coherent_atom_size = context.get_device_properties().limits.non_coherent_atom_size;
    let queue_family_index = context.get_universal_queue_family_index();

    // Create protected memory device if protected memory is supported
    // otherwise use the default device
    let mut protected_features = vk::PhysicalDeviceProtectedMemoryFeatures {
        s_type: vk::StructureType::PHYSICAL_DEVICE_PROTECTED_MEMORY_FEATURES,
        next: std::ptr::null_mut(),
        protected_memory: vk::FALSE,
    };
    let mut device_features2 = vk::PhysicalDeviceFeatures2 {
        s_type: vk::StructureType::PHYSICAL_DEVICE_FEATURES_2,
        next: (&raw mut protected_features).cast(),
        features: vk::PhysicalDeviceFeatures::default(),
    };
    unsafe { instance.get_physical_device_features2(physical_device, &mut device_features2) };

    let device = if protected_features.protected_memory != 0 && config.implicit_unmap {
        create_protected_memory_device(context, instance, physical_device, &device_features2)?
    } else {
        DeviceWrapper::Default(context.get_device())
    };
    let vkd = device.get_driver();

    for memory_type_index in 0..memory_properties.memory_type_count {
        // Upstream catches tcu::TestError here and turns it into a Fail; a
        // ResourceError (its OutOfMemoryError) or a lost device is not caught and
        // propagates out as its own verdict, so the same split is made here.
        match run_memory_type(
            vkd,
            config,
            &memory_properties,
            memory_type_index,
            non_coherent_atom_size,
            queue_family_index,
            &mut result,
            &mut at_least_one_test_performed,
        ) {
            Ok(()) => {}
            Err(TestError::InternalError(msg)) | Err(TestError::NotPorted(msg)) => result.fail(msg),
            Err(e) => return Err(e),
        }
    }

    if !at_least_one_test_performed {
        result.add_result(
            TestResult::NotSupported,
            "No suitable memory kind found to perform test.".to_string(),
        );
    }

    Ok(TestStatus::new(result.get_result(), result.message.clone()))
}

/// The body of `testMemoryMapping`'s per-memory-type loop, split out so the `continue`
/// statements upstream uses become early returns and so the exception boundary is a
/// single `Result`.
#[allow(clippy::too_many_arguments)]
fn run_memory_type(
    vkd: &Device,
    config: &TestConfig,
    memory_properties: &vk::PhysicalDeviceMemoryProperties,
    memory_type_index: u32,
    non_coherent_atom_size: vk::DeviceSize,
    queue_family_index: u32,
    result: &mut ResultCollector,
    at_least_one_test_performed: &mut bool,
) -> Result<(), TestError> {
    let memory_type = memory_properties.memory_types[memory_type_index as usize];
    let memory_heap = memory_properties.memory_heaps[memory_type.heap_index as usize];
    let atom_size = non_coherent_atom_size;
    let stride: vk::DeviceSize = if config.implicit_unmap { 1024 } else { 1 };
    let iterations: u32 = if config.implicit_unmap { 128 } else { 1 };

    let mut allocation_size = if config.allocation_size.is_multiple_of(atom_size) {
        config.allocation_size
    } else {
        config.allocation_size + (atom_size - (config.allocation_size % atom_size))
    };

    // VUID-vkAllocateMemory-deviceCoherentMemory-02790. hodow_cts's Context never turns
    // VK_AMD_device_coherent_memory's feature bit on, so these types are always skipped,
    // which is what upstream does when `deviceCoherentMemory` is false.
    if memory_type
        .property_flags
        .contains(vk::MemoryPropertyFlags::DEVICE_COHERENT_AMD)
    {
        return Ok(());
    }

    if config.implicit_unmap {
        let mut max: vk::DeviceSize = 0x10000000; // 256MiB

        while memory_heap.size <= 4 * max {
            max >>= 1;
        }

        allocation_size = find_large_allocation_size(vkd, max, memory_type_index);
    }

    let mut req = vk::MemoryRequirements {
        size: allocation_size,
        alignment: 0,
        memory_type_bits: !0u32,
    };
    let mut image: Option<Unique<'_, vk::Image>> = None;
    let mut buffer: Option<Unique<'_, vk::Buffer>> = None;

    if config.allocation_kind == AllocationKind::DedicatedImage {
        let created = make_image(vkd, allocation_size, queue_family_index)?;
        req = get_image_memory_requirements(vkd, *created);
        image = Some(created);
    } else if config.allocation_kind == AllocationKind::DedicatedBuffer {
        let created = make_buffer_qf(vkd, allocation_size, queue_family_index)?;
        req = get_buffer_memory_requirements(vkd, *created);
        buffer = Some(created);
    }
    let allocation_size = req.size;
    let mut mapping_size = if config.mapping.size.is_multiple_of(atom_size) {
        config.mapping.size
    } else {
        config.mapping.size + (atom_size - (config.mapping.size % atom_size))
    };
    let mapping_offset = if config.mapping.offset.is_multiple_of(atom_size) {
        config.mapping.offset
    } else {
        config.mapping.offset - (config.mapping.offset % atom_size)
    };
    if config.mapping.size == config.allocation_size && config.mapping.offset == 0 {
        mapping_size = allocation_size;
    }

    let reference_size = (mapping_size / stride) as usize;
    let mut reference = vec![0u8; mapping_offset as usize + reference_size];

    if (req.memory_type_bits & (1u32 << memory_type_index)) == 0 {
        const ALLOCATION_KIND_NAME: [&str; 3] = [
            "suballocation",
            "dedicated allocation of buffers",
            "dedicated allocation of images",
        ];
        log::info!(
            "Memory type does not support {}.",
            ALLOCATION_KIND_NAME[config.allocation_kind as usize]
        );
        return Ok(());
    }

    if (memory_type.property_flags & vk::MemoryPropertyFlags::HOST_VISIBLE).is_empty() {
        log::info!("Memory type doesn't support mapping.");
    } else if memory_heap.size <= 4 * allocation_size {
        log::info!("Memory type's heap is too small.");
    } else {
        for _iteration in 0..iterations {
            *at_least_one_test_performed = true;
            let recorder = AllocationCallbackRecorder::new();
            let allocator = if config.implicit_unmap {
                Some(recorder.get_callbacks())
            } else {
                None
            };
            let mut memory = alloc_memory_dedicated(
                vkd,
                allocation_size,
                memory_type_index,
                image.as_ref().map_or(vk::Image::null(), |i| **i),
                buffer.as_ref().map_or(vk::Buffer::null(), |b| **b),
                allocator,
            )?;
            let mut rng = Random::new(config.seed);
            let mut mapping: *mut u8;

            {
                let ptr = map_memory_wrapper(vkd, memory.get(), mapping_offset, mapping_size, config.memory_map2)?;
                if ptr.is_null() {
                    return Err(TestError::InternalError(
                        "vkMapMemory returned a null pointer".to_string(),
                    ));
                }

                mapping = ptr.cast::<u8>();
            }

            let mut ndx: vk::DeviceSize = 0;
            while ndx < reference_size as vk::DeviceSize {
                let val = get_uint8(&mut rng);

                unsafe { *mapping.add((ndx * stride) as usize) = val };
                reference[(mapping_offset + ndx) as usize] = val;
                ndx += stride;
            }

            if !config.flush_mappings.is_empty() {
                let mut ranges: Vec<vk::MappedMemoryRange> = Vec::new();

                for flush in &config.flush_mappings {
                    let range = vk::MappedMemoryRange {
                        s_type: vk::StructureType::MAPPED_MEMORY_RANGE,
                        next: std::ptr::null(),

                        memory: memory.get(),
                        offset: if flush.offset.is_multiple_of(atom_size) {
                            flush.offset
                        } else {
                            flush.offset - (flush.offset % atom_size)
                        },
                        size: round_size_up_to_atom(flush.size, atom_size),
                    };

                    ranges.push(range);
                }

                unsafe { vkd.flush_mapped_memory_ranges(&ranges) }.vk_check("vkFlushMappedMemoryRanges")?;
            }

            if config.remap {
                unmap_memory_wrapper(vkd, memory.get(), config.memory_map2)?;
                let ptr = map_memory_wrapper(vkd, memory.get(), mapping_offset, mapping_size, config.memory_map2)?;

                if ptr.is_null() {
                    return Err(TestError::InternalError(
                        "vkMapMemory returned a null pointer".to_string(),
                    ));
                }

                mapping = ptr.cast::<u8>();
            }

            if !config.invalidate_mappings.is_empty() {
                let mut ranges: Vec<vk::MappedMemoryRange> = Vec::new();

                for invalidate in &config.invalidate_mappings {
                    let range = vk::MappedMemoryRange {
                        s_type: vk::StructureType::MAPPED_MEMORY_RANGE,
                        next: std::ptr::null(),

                        memory: memory.get(),
                        offset: if invalidate.offset.is_multiple_of(atom_size) {
                            invalidate.offset
                        } else {
                            invalidate.offset - (invalidate.offset % atom_size)
                        },
                        size: round_size_up_to_atom(invalidate.size, atom_size),
                    };

                    ranges.push(range);
                }

                unsafe { vkd.invalidate_mapped_memory_ranges(&ranges) }.vk_check("vkInvalidateMappedMemoryRanges")?;
            }

            if !compare_and_log_buffer(
                mapping_size as usize,
                reference_size,
                mapping,
                &reference[mapping_offset as usize..],
            ) {
                result.fail("Unexpected values read from mapped memory.".to_string());
            }

            if config.implicit_unmap {
                let disowned = memory.disown();
                unsafe { vkd.free_memory(disowned, allocator) };

                if recorder.live_allocation_count() != 0 {
                    result.fail("Live allocations remain after freeing mapped memory".to_string());
                }
            } else {
                unmap_memory_wrapper(vkd, memory.get(), config.memory_map2)?;
            }
        }
    }

    Ok(())
}

// ---------------------------------------------------------------------------------
// Random mapping
// ---------------------------------------------------------------------------------

/// `MemoryMapping`
///
/// Upstream holds a `ReferenceMemory&` here; in Rust the reference memory stays inside
/// the owning `MemoryObject` and is handed to each operation instead, which is the only
/// structural change in this part of the port.
struct MemoryMapping {
    range: MemoryRange,
    ptr: *mut u8,
}

impl MemoryMapping {
    fn new(range: MemoryRange, ptr: *mut u8) -> Self {
        Self { range, ptr }
    }

    fn get_range(&self) -> MemoryRange {
        self.range
    }

    /// `MemoryMapping::randomRead`. `false` is upstream's failing `TCU_CHECK`.
    fn random_read(&self, rng: &mut Random, reference: &mut ReferenceMemory) -> bool {
        let count = rng.get_int(0, 100) as usize;

        for _ndx in 0..count {
            let pos = (rng.get_uint64() % self.range.size) as usize;
            let val = unsafe { *self.ptr.add(pos) };

            if !reference.read((self.range.offset as usize) + pos, val) {
                return false;
            }
        }

        true
    }

    /// `MemoryMapping::randomWrite`
    fn random_write(&self, rng: &mut Random, reference: &mut ReferenceMemory) {
        let count = rng.get_int(0, 100) as usize;

        for _ndx in 0..count {
            let pos = (rng.get_uint64() % self.range.size) as usize;
            let val = get_uint8(rng);

            unsafe { *self.ptr.add(pos) = val };
            reference.write((self.range.offset as usize) + pos, val);
        }
    }

    /// `MemoryMapping::randomModify`
    fn random_modify(&self, rng: &mut Random, reference: &mut ReferenceMemory) -> bool {
        let count = rng.get_int(0, 100) as usize;

        for _ndx in 0..count {
            let pos = (rng.get_uint64() % self.range.size) as usize;
            let val = unsafe { *self.ptr.add(pos) };
            let mask = get_uint8(rng);

            unsafe { *self.ptr.add(pos) = val ^ mask };
            if !reference.modify_xor((self.range.offset as usize) + pos, val, mask) {
                return false;
            }
        }

        true
    }
}

/// `randomSize`
fn random_size(rng: &mut Random, atom_size: vk::DeviceSize, max_size: vk::DeviceSize) -> vk::DeviceSize {
    let max_size_in_atoms = max_size / atom_size;

    if max_size_in_atoms > 1 {
        atom_size * (1 + (rng.get_uint64() % max_size_in_atoms))
    } else {
        atom_size
    }
}

/// `randomOffset`
fn random_offset(rng: &mut Random, atom_size: vk::DeviceSize, max_offset: vk::DeviceSize) -> vk::DeviceSize {
    let max_offset_in_atoms = max_offset / atom_size;

    if max_offset_in_atoms > 0 {
        atom_size * (rng.get_uint64() % (max_offset_in_atoms + 1))
    } else {
        0
    }
}

/// `randomRanges`
fn random_ranges(
    rng: &mut Random,
    ranges: &mut Vec<vk::MappedMemoryRange>,
    count: usize,
    memory: vk::DeviceMemory,
    min_offset: vk::DeviceSize,
    max_size: vk::DeviceSize,
    atom_size: vk::DeviceSize,
) {
    ranges.clear();
    ranges.reserve(count);

    for _range_ndx in 0..count {
        let size = random_size(rng, atom_size, max_size);
        let offset = min_offset + random_offset(rng, atom_size, max_size - size);

        let range = vk::MappedMemoryRange {
            s_type: vk::StructureType::MAPPED_MEMORY_RANGE,
            next: std::ptr::null(),

            memory,
            offset,
            size,
        };
        ranges.push(range);
    }
}

/// `MemoryObject`
struct MemoryObject<'a> {
    vkd: &'a Device,

    /// Upstream keeps this member; nothing reads it back after the allocation.
    #[allow(dead_code)]
    memory_type_index: u32,
    size: vk::DeviceSize,
    atom_size: vk::DeviceSize,
    memory_usage: vk::DeviceSize,
    reference_memory_usage: vk::DeviceSize,

    memory: vk::DeviceMemory,

    mapping: Option<MemoryMapping>,
    reference_memory: ReferenceMemory,
}

impl<'a> MemoryObject<'a> {
    fn new(
        vkd: &'a Device,
        size: vk::DeviceSize,
        memory_type_index: u32,
        atom_size: vk::DeviceSize,
        memory_usage: vk::DeviceSize,
        reference_memory_usage: vk::DeviceSize,
    ) -> Result<Self, TestError> {
        let reference_memory = ReferenceMemory::new(size as usize, atom_size as usize);
        let mut memory = alloc_memory(vkd, size, memory_type_index)?;

        Ok(Self {
            vkd,
            memory_type_index,
            size,
            atom_size,
            memory_usage,
            reference_memory_usage,
            memory: memory.disown(),
            mapping: None,
            reference_memory,
        })
    }

    /// `MemoryObject::getSize`, kept for parity with upstream.
    #[allow(dead_code)]
    fn get_size(&self) -> vk::DeviceSize {
        self.size
    }

    fn get_memory_usage(&self) -> vk::DeviceSize {
        self.memory_usage
    }

    fn get_reference_memory_usage(&self) -> vk::DeviceSize {
        self.reference_memory_usage
    }

    fn has_mapping(&self) -> bool {
        self.mapping.is_some()
    }

    /// `MemoryObject::mapRandom`
    fn map_random(&mut self, rng: &mut Random, map2: bool) -> Result<(), TestError> {
        let size = random_size(rng, self.atom_size, self.size);
        let offset = random_offset(rng, self.atom_size, self.size - size);

        let ptr = map_memory_wrapper(self.vkd, self.memory, offset, size, map2)?;
        if ptr.is_null() {
            return Err(TestError::InternalError(
                "vkMapMemory returned a null pointer".to_string(),
            ));
        }
        self.mapping = Some(MemoryMapping::new(MemoryRange::new(offset, size), ptr.cast::<u8>()));

        Ok(())
    }

    /// `MemoryObject::unmap`
    fn unmap(&mut self, map2: bool) -> Result<(), TestError> {
        unmap_memory_wrapper(self.vkd, self.memory, map2)?;

        self.mapping = None;

        Ok(())
    }

    /// `MemoryObject::randomFlush`
    fn random_flush(&mut self, rng: &mut Random) -> Result<(), TestError> {
        let range_count = rng.get_int(1, 10) as usize;
        let mut ranges: Vec<vk::MappedMemoryRange> = Vec::new();

        let mapping_range = self.mapping.as_ref().unwrap().get_range();
        random_ranges(
            rng,
            &mut ranges,
            range_count,
            self.memory,
            mapping_range.offset,
            mapping_range.size,
            self.atom_size,
        );

        for range in &ranges {
            self.reference_memory.flush(range.offset as usize, range.size as usize);
        }

        unsafe { self.vkd.flush_mapped_memory_ranges(&ranges) }.vk_check("vkFlushMappedMemoryRanges")
    }

    /// `MemoryObject::randomInvalidate`
    fn random_invalidate(&mut self, rng: &mut Random) -> Result<(), TestError> {
        let range_count = rng.get_int(1, 10) as usize;
        let mut ranges: Vec<vk::MappedMemoryRange> = Vec::new();

        let mapping_range = self.mapping.as_ref().unwrap().get_range();
        random_ranges(
            rng,
            &mut ranges,
            range_count,
            self.memory,
            mapping_range.offset,
            mapping_range.size,
            self.atom_size,
        );

        for range in &ranges {
            self.reference_memory
                .invalidate(range.offset as usize, range.size as usize);
        }

        unsafe { self.vkd.invalidate_mapped_memory_ranges(&ranges) }.vk_check("vkInvalidateMappedMemoryRanges")
    }

    fn random_read(&mut self, rng: &mut Random) -> bool {
        let mapping = self.mapping.as_ref().unwrap();
        mapping.random_read(rng, &mut self.reference_memory)
    }

    fn random_write(&mut self, rng: &mut Random) {
        let mapping = self.mapping.as_ref().unwrap();
        mapping.random_write(rng, &mut self.reference_memory);
    }

    fn random_modify(&mut self, rng: &mut Random) -> bool {
        let mapping = self.mapping.as_ref().unwrap();
        mapping.random_modify(rng, &mut self.reference_memory)
    }
}

impl Drop for MemoryObject<'_> {
    fn drop(&mut self) {
        // Freeing still-mapped memory unmaps it implicitly, which is what upstream's
        // `Move<VkDeviceMemory>` does too.
        unsafe { self.vkd.free_memory(self.memory, None) };
    }
}

type MemoryObjectPtr<'a> = Rc<RefCell<MemoryObject<'a>>>;

const MAX_MEMORY_USAGE_DIV: vk::DeviceSize = 2; // Use only 1/2 of each memory heap.
const MAX_MEMORY_ALLOC_DIV: vk::DeviceSize = 2; // Do not alloc more than 1/2 of available space.

/// `removeFirstEqual`
fn remove_first_equal<'a>(vec: &mut Vec<MemoryObjectPtr<'a>>, val: &MemoryObjectPtr<'a>) {
    for ndx in 0..vec.len() {
        if Rc::ptr_eq(&vec[ndx], val) {
            let back = vec.pop().unwrap();
            if ndx < vec.len() {
                vec[ndx] = back;
            }
            return;
        }
    }
}

/// `de::Random::choose<T>(first, last)` - reservoir sampling, one item. The RNG is
/// consumed once per element past the first, so this has to keep the same shape.
fn choose<T: Clone>(rng: &mut Random, items: &[T]) -> T {
    let mut val = items[0].clone();

    for (ndx, item) in items.iter().enumerate().skip(1) {
        let r = rng.get_int(0, ndx as i32);
        if r < 1 {
            val = item.clone();
        }
    }

    val
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum MemoryClass {
    System = 0,
    Device = 1,
}

const MEMORY_CLASS_LAST: usize = 2;

/// `TotalMemoryTracker`
struct TotalMemoryTracker {
    usage: [vk::DeviceSize; MEMORY_CLASS_LAST],
}

impl TotalMemoryTracker {
    fn new() -> Self {
        Self {
            usage: [0; MEMORY_CLASS_LAST],
        }
    }

    fn allocate(&mut self, mem_class: MemoryClass, size: vk::DeviceSize) {
        self.usage[mem_class as usize] += size;
    }

    fn free(&mut self, mem_class: MemoryClass, size: vk::DeviceSize) {
        self.usage[mem_class as usize] -= size;
    }

    fn get_usage(&self, mem_class: MemoryClass) -> vk::DeviceSize {
        self.usage[mem_class as usize]
    }

    fn get_total_usage(&self) -> vk::DeviceSize {
        self.usage.iter().sum()
    }
}

/// `getHostPageSize`
fn get_host_page_size() -> vk::DeviceSize {
    4096
}

/// `tcu::PlatformMemoryLimits`. hodow_cts has no platform layer; these are the defaults
/// `tcu::Platform::getMemoryLimits` hands out, which every platform upstream except
/// Android and the null platform uses unchanged.
#[allow(dead_code)]
#[derive(Debug, Clone, Copy)]
struct PlatformMemoryLimits {
    total_system_memory: vk::DeviceSize,
    total_device_local_memory: vk::DeviceSize,
    device_memory_allocation_granularity: vk::DeviceSize,
    device_page_size: vk::DeviceSize,
    device_page_table_entry_size: vk::DeviceSize,
    device_page_table_hierarchy_levels: usize,
}

fn get_memory_limits() -> PlatformMemoryLimits {
    PlatformMemoryLimits {
        total_system_memory: 256 * 1024 * 1024,
        total_device_local_memory: 128 * 1024 * 1024,
        device_memory_allocation_granularity: 64 * 1024,
        device_page_size: 4096,
        device_page_table_entry_size: 8,
        device_page_table_hierarchy_levels: 3,
    }
}

/// `MemoryHeap`
///
/// Upstream keeps a `TotalMemoryTracker&` member; here the tracker is passed in to each
/// method that touches it, because two heaps sharing one mutable tracker cannot be
/// expressed as a borrow held across calls.
struct MemoryHeap<'a> {
    heap: vk::MemoryHeap,
    memory_types: Vec<MemoryType>,
    limits: PlatformMemoryLimits,
    non_coherent_atom_size: vk::DeviceSize,
    min_atom_size: vk::DeviceSize,

    usage: vk::DeviceSize,
    objects: Vec<MemoryObjectPtr<'a>>,
}

impl<'a> MemoryHeap<'a> {
    fn new(
        heap: vk::MemoryHeap,
        memory_types: Vec<MemoryType>,
        memory_limits: PlatformMemoryLimits,
        non_coherent_atom_size: vk::DeviceSize,
    ) -> Self {
        Self {
            heap,
            memory_types,
            limits: memory_limits,
            non_coherent_atom_size,
            min_atom_size: non_coherent_atom_size,
            usage: 0,
            objects: Vec::new(),
        }
    }

    fn get_memory_class(&self) -> MemoryClass {
        if !(self.heap.flags & vk::MemoryHeapFlags::DEVICE_LOCAL).is_empty() {
            MemoryClass::Device
        } else {
            MemoryClass::System
        }
    }

    // Heap is full if there is not enough memory to allocate minimal memory object.
    fn full(&self, total_mem_tracker: &TotalMemoryTracker) -> bool {
        let available_in_heap = self.heap.size / MAX_MEMORY_USAGE_DIV - self.usage;
        let is_uma = self.limits.total_device_local_memory == 0;
        let mem_class = self.get_memory_class();
        let min_allocation_size = self.min_atom_size.max(if mem_class == MemoryClass::Device {
            self.limits.device_page_size
        } else {
            get_host_page_size()
        });
        // Memory required for reference. One byte and one bit for each byte and one bit per each m_atomSize.
        let min_reference_size = min_allocation_size
            + div_round_up(min_allocation_size, 8)
            + div_round_up(min_allocation_size, self.min_atom_size * 8);

        if is_uma {
            let total_usage = total_mem_tracker.get_total_usage();
            let total_sys_mem = self.limits.total_system_memory;

            // See the wrapping note in the else branch.
            (min_allocation_size + min_reference_size) > total_sys_mem.wrapping_sub(total_usage)
                || min_allocation_size > available_in_heap
        } else {
            let total_usage = total_mem_tracker.get_total_usage();
            let total_sys_mem = self.limits.total_system_memory;

            let total_mem_class = if mem_class == MemoryClass::System {
                self.limits.total_system_memory
            } else {
                self.limits.total_device_local_memory
            };
            let used_mem_class = total_mem_tracker.get_usage(mem_class);

            // Upstream asserts `usedMemClass <= totalMemClass` and `totalUsage <=
            // totalSysMem` here, but the assert is compiled out of the release build the
            // conformance runs use, and the budget is an estimate the allocator can
            // overshoot slightly - `suballocation.random.66` ends up 449 bytes over the
            // system total. There the subtraction wraps to a huge number, the comparison
            // is false, and the heap is reported as not full. Saturating instead would
            // report it full and take a different path, so the wrap is reproduced.
            min_allocation_size > available_in_heap
                || min_allocation_size > total_mem_class.wrapping_sub(used_mem_class)
                || min_reference_size > total_sys_mem.wrapping_sub(total_usage)
        }
    }

    fn empty(&self, total_mem_tracker: &TotalMemoryTracker) -> bool {
        self.usage == 0 && !self.full(total_mem_tracker)
    }

    /// `MemoryHeap::allocateRandom`
    fn allocate_random(
        &mut self,
        vkd: &'a Device,
        rng: &mut Random,
        total_mem_tracker: &mut TotalMemoryTracker,
    ) -> Result<MemoryObjectPtr<'a>, TestError> {
        let memory_type_max_size_pair: (MemoryType, vk::DeviceSize);

        // Pick random memory type
        {
            let mut memory_types: Vec<(MemoryType, vk::DeviceSize)> = Vec::new();

            let available_in_heap = self.heap.size / MAX_MEMORY_USAGE_DIV - self.usage;
            let is_uma = self.limits.total_device_local_memory == 0;
            let mem_class = self.get_memory_class();

            // Collect memory types that can be allocated and the maximum size of allocation.
            // Memory type can be only allocated if minimal memory allocation is less than available memory.
            for ty in &self.memory_types {
                let atom_size = self.non_coherent_atom_size;
                let allocation_size_granularity = atom_size.max(if mem_class == MemoryClass::Device {
                    self.limits.device_page_size
                } else {
                    get_host_page_size()
                });
                let min_allocation_size = allocation_size_granularity;
                let min_reference_size = min_allocation_size
                    + div_round_up(min_allocation_size, 8)
                    + div_round_up(min_allocation_size, atom_size * 8);

                if is_uma {
                    let total_usage = total_mem_tracker.get_total_usage();
                    let total_sys_mem = self.limits.total_system_memory;
                    let available_bits = total_sys_mem.wrapping_sub(total_usage).wrapping_mul(8);
                    let max_allocation_size = round_down_to_multiple(
                        ((atom_size * available_bits) / (17 * atom_size + 1)).min(available_in_heap),
                        allocation_size_granularity,
                    );

                    if min_allocation_size + min_reference_size <= total_sys_mem.wrapping_sub(total_usage)
                        && min_allocation_size <= available_in_heap
                    {
                        memory_types.push((*ty, max_allocation_size));
                    }
                } else {
                    let total_usage = total_mem_tracker.get_total_usage();
                    let total_sys_mem = self.limits.total_system_memory;

                    let total_mem_class = if mem_class == MemoryClass::System {
                        self.limits.total_system_memory
                    } else {
                        self.limits.total_device_local_memory
                    };
                    let used_mem_class = total_mem_tracker.get_usage(mem_class);
                    let max_allocation_size = round_down_to_multiple(
                        total_mem_class
                            .wrapping_sub(used_mem_class)
                            .min(
                                atom_size
                                    .wrapping_mul(8)
                                    .wrapping_mul(total_sys_mem.wrapping_sub(total_usage))
                                    / (9 * atom_size + 1),
                            )
                            .min(available_in_heap),
                        allocation_size_granularity,
                    );

                    if min_allocation_size <= available_in_heap
                        && min_allocation_size <= total_mem_class.wrapping_sub(used_mem_class)
                        && min_reference_size <= total_sys_mem.wrapping_sub(total_usage)
                    {
                        memory_types.push((*ty, max_allocation_size));
                    }
                }
            }

            if memory_types.is_empty() {
                return Err(TestError::InternalError(
                    "no memory type left to allocate from".to_string(),
                ));
            }

            memory_type_max_size_pair = choose(rng, &memory_types);
        }

        let ty = memory_type_max_size_pair.0;
        let max_allocation_size = memory_type_max_size_pair.1 / MAX_MEMORY_ALLOC_DIV;
        let atom_size = self.non_coherent_atom_size;
        let allocation_size_granularity = atom_size.max(if self.get_memory_class() == MemoryClass::Device {
            self.limits.device_page_size
        } else {
            get_host_page_size()
        });
        let size = random_size(rng, atom_size, max_allocation_size);
        let memory_usage = round_up_to_multiple(size, allocation_size_granularity);
        let reference_memory_usage = size + div_round_up(size, 8) + div_round_up(size / atom_size, 8);

        let object: MemoryObjectPtr<'a> = Rc::new(RefCell::new(MemoryObject::new(
            vkd,
            size,
            ty.index,
            atom_size,
            memory_usage,
            reference_memory_usage,
        )?));

        self.usage += memory_usage;
        total_mem_tracker.allocate(self.get_memory_class(), memory_usage);
        total_mem_tracker.allocate(MemoryClass::System, reference_memory_usage);
        self.objects.push(Rc::clone(&object));

        Ok(object)
    }

    fn get_random_object(&self, rng: &mut Random) -> MemoryObjectPtr<'a> {
        choose(rng, &self.objects)
    }

    fn free(&mut self, object: &MemoryObjectPtr<'a>, total_mem_tracker: &mut TotalMemoryTracker) {
        remove_first_equal(&mut self.objects, object);
        self.usage -= object.borrow().get_memory_usage();
        total_mem_tracker.free(MemoryClass::System, object.borrow().get_reference_memory_usage());
        total_mem_tracker.free(self.get_memory_class(), object.borrow().get_memory_usage());
    }
}

/// `getMemoryObjectSystemSize`
fn get_memory_object_system_size(context: &Context<'_>) -> usize {
    compute_device_memory_system_mem_footprint(context.get_device())
        + std::mem::size_of::<MemoryObject<'_>>()
        + std::mem::size_of::<MemoryObjectPtr<'_>>()
}

/// `getMemoryMappingSystemSize`
fn get_memory_mapping_system_size() -> usize {
    std::mem::size_of::<MemoryMapping>() + std::mem::size_of::<Rc<RefCell<MemoryMapping>>>()
}

#[derive(Debug, Clone, Copy)]
struct RandomMappingConfig {
    seed: u32,
    memory_map2: bool,
}

/// `RandomMemoryMappingInstance`
///
/// Upstream's `iterate` runs one operation per call and returns `incomplete()` until
/// the hundredth; hodow_cts calls `iterate` exactly once, so the op loop lives inside
/// it. Everything the upstream constructor does happens at the top of `iterate` for
/// the same reason: `create_instance` cannot fail, and building the heap list can.
struct RandomMemoryMappingInstance<'a> {
    context: &'a Context<'a>,
    config: RandomMappingConfig,
}

impl TestInstance for RandomMemoryMappingInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let memory_object_sys_mem_size = get_memory_object_system_size(context) as vk::DeviceSize;
        let memory_mapping_sys_mem_size = get_memory_mapping_system_size() as vk::DeviceSize;
        let memory_limits = get_memory_limits();
        let mut rng = Random::new(self.config.seed);
        let map2 = self.config.memory_map2;

        let mut total_mem_tracker = TotalMemoryTracker::new();
        let mut memory_heaps: Vec<MemoryHeap<'_>> = Vec::new();

        let mut mapped_memory_objects: Vec<MemoryObjectPtr<'_>> = Vec::new();
        let mut non_mapped_memory_objects: Vec<MemoryObjectPtr<'_>> = Vec::new();
        let mut memory_mappings: Vec<MemoryObjectPtr<'_>> = Vec::new();

        let physical_device = context.get_physical_device();
        let vki = context.get_instance();
        let memory_properties = unsafe { vki.get_physical_device_memory_properties(physical_device) };
        let non_coherent_atom_size = context.get_device_properties().limits.non_coherent_atom_size;
        let device = context.get_device();
        let vkd = device;

        let mut mem_reqs_db = vk::MemoryRequirements::default();
        let mut mem_reqs_rb = vk::MemoryRequirements::default();
        let mut mem_reqs_sb = vk::MemoryRequirements::default();
        let descriptor_buffer_supported = context.require_device_functionality("VK_EXT_descriptor_buffer").is_ok();

        /* If descriptor buffers are supported we need to record which memory types
         * can be used for descriptor buffers as their memory allocations will
         * have some limitations.
         */
        if descriptor_buffer_supported {
            let create_flags = vk::BufferCreateFlags::empty();
            let usage_flags_db = vk::BufferUsageFlags::SAMPLER_DESCRIPTOR_BUFFER_EXT
                | vk::BufferUsageFlags::RESOURCE_DESCRIPTOR_BUFFER_EXT;
            let usage_flags_rb = vk::BufferUsageFlags::RESOURCE_DESCRIPTOR_BUFFER_EXT;
            let usage_flags_sb = vk::BufferUsageFlags::SAMPLER_DESCRIPTOR_BUFFER_EXT;
            let sharing_mode = vk::SharingMode::EXCLUSIVE;
            let queue_family_index = 0u32;
            let buffer_size: vk::DeviceSize = 1024;

            let mut buffer_params = vk::BufferCreateInfo {
                s_type: vk::StructureType::BUFFER_CREATE_INFO,
                next: std::ptr::null(),
                flags: create_flags,
                size: buffer_size,
                usage: usage_flags_db,
                sharing_mode,
                queue_family_index_count: 1,
                queue_family_indices: &raw const queue_family_index,
            };

            let buffer = unsafe { vkd.create_buffer(&buffer_params, None) }.vk_check("vkCreateBuffer")?;
            let buffer = Unique::new(vkd, buffer);
            mem_reqs_db = unsafe { vkd.get_buffer_memory_requirements(*buffer) };
            drop(buffer);

            buffer_params.usage = usage_flags_rb;
            let buffer = unsafe { vkd.create_buffer(&buffer_params, None) }.vk_check("vkCreateBuffer")?;
            let buffer = Unique::new(vkd, buffer);
            mem_reqs_rb = unsafe { vkd.get_buffer_memory_requirements(*buffer) };
            drop(buffer);

            buffer_params.usage = usage_flags_sb;
            let buffer = unsafe { vkd.create_buffer(&buffer_params, None) }.vk_check("vkCreateBuffer")?;
            let buffer = Unique::new(vkd, buffer);
            mem_reqs_sb = unsafe { vkd.get_buffer_memory_requirements(*buffer) };
            drop(buffer);
        }

        // Initialize heaps
        {
            let mut memory_types: Vec<Vec<MemoryType>> = vec![Vec::new(); memory_properties.memory_heap_count as usize];
            let mut memory_heap_infos: Vec<vk::MemoryHeap> =
                memory_properties.memory_heaps[..memory_properties.memory_heap_count as usize].to_vec();

            let descriptor_buffer_properties = if descriptor_buffer_supported {
                get_descriptor_buffer_properties(vki, physical_device)
            } else {
                vk::PhysicalDeviceDescriptorBufferPropertiesEXT::default()
            };

            for memory_type_ndx in 0..memory_properties.memory_type_count {
                // VUID-vkAllocateMemory-deviceCoherentMemory-02790
                if !(memory_properties.memory_types[memory_type_ndx as usize].property_flags
                    & vk::MemoryPropertyFlags::DEVICE_COHERENT_AMD)
                    .is_empty()
                {
                    continue;
                }

                if !(memory_properties.memory_types[memory_type_ndx as usize].property_flags
                    & vk::MemoryPropertyFlags::HOST_VISIBLE)
                    .is_empty()
                {
                    memory_types[memory_properties.memory_types[memory_type_ndx as usize].heap_index as usize].push(
                        MemoryType {
                            index: memory_type_ndx,
                            ty: memory_properties.memory_types[memory_type_ndx as usize],
                        },
                    );
                }

                /* If descriptor buffers are supported, then we need to limit heaps maximum allocation
                 * size by the limit of the descriptor buffer address space
                 */
                if descriptor_buffer_supported {
                    let heap_index = memory_properties.memory_types[memory_type_ndx as usize].heap_index as usize;

                    if ((1u32 << memory_type_ndx) & mem_reqs_db.memory_type_bits) != 0 {
                        memory_heap_infos[heap_index].size = memory_heap_infos[heap_index]
                            .size
                            .min(descriptor_buffer_properties.descriptor_buffer_address_space_size / 8);
                    }

                    if ((1u32 << memory_type_ndx) & mem_reqs_rb.memory_type_bits) != 0 {
                        memory_heap_infos[heap_index].size = memory_heap_infos[heap_index]
                            .size
                            .min(descriptor_buffer_properties.resource_descriptor_buffer_address_space_size / 8);
                    }

                    if ((1u32 << memory_type_ndx) & mem_reqs_sb.memory_type_bits) != 0 {
                        memory_heap_infos[heap_index].size = memory_heap_infos[heap_index]
                            .size
                            .min(descriptor_buffer_properties.sampler_descriptor_buffer_address_space_size / 8);
                    }
                }
            }

            for heap_index in 0..memory_properties.memory_heap_count as usize {
                let heap_info = memory_heap_infos[heap_index];

                if !memory_types[heap_index].is_empty() {
                    let heap = MemoryHeap::new(
                        heap_info,
                        memory_types[heap_index].clone(),
                        memory_limits,
                        non_coherent_atom_size,
                    );

                    if heap.full(&total_mem_tracker) {
                        return Err(TestError::InternalError(
                            "memory heap is full before any allocation".to_string(),
                        ));
                    }

                    memory_heaps.push(heap);
                }
            }
        }

        let op_count = 100usize;
        let memory_op_probability = 0.5f32; // 0.50
        let flush_invalidate_probability = 0.4f32; // 0.20
        let map_probability = 0.50f32; // 0.15
        let unmap_probability = 0.25f32; // 0.075

        let alloc_probability = 0.75f32; // Versun free

        for _op_ndx in 0..op_count {
            let sys_mem_usage = if memory_limits.total_device_local_memory == 0 {
                total_mem_tracker.get_total_usage()
            } else {
                total_mem_tracker.get_usage(MemoryClass::System)
            };

            if !memory_mappings.is_empty() && rng.get_float() < memory_op_probability {
                // Perform operations on mapped memory
                let object = choose(&mut rng, &memory_mappings);

                const OP_LAST: u32 = 3;
                let op = rng.get_uint32() % OP_LAST;

                let ok = match op {
                    0 => object.borrow_mut().random_read(&mut rng),
                    1 => {
                        object.borrow_mut().random_write(&mut rng);
                        true
                    }
                    _ => object.borrow_mut().random_modify(&mut rng),
                };

                if !ok {
                    return Ok(TestStatus::fail("Unexpected values read from mapped memory."));
                }
            } else if !mapped_memory_objects.is_empty() && rng.get_float() < flush_invalidate_probability {
                let object = choose(&mut rng, &mapped_memory_objects);

                if rng.get_bool() {
                    object.borrow_mut().random_flush(&mut rng)?;
                } else {
                    object.borrow_mut().random_invalidate(&mut rng)?;
                }
            } else if !mapped_memory_objects.is_empty() && rng.get_float() < unmap_probability {
                // Unmap memory object
                let object = choose(&mut rng, &mapped_memory_objects);

                // Remove mapping
                remove_first_equal(&mut memory_mappings, &object);

                object.borrow_mut().unmap(map2)?;
                remove_first_equal(&mut mapped_memory_objects, &object);
                non_mapped_memory_objects.push(Rc::clone(&object));

                total_mem_tracker.free(MemoryClass::System, memory_mapping_sys_mem_size);
            } else if !non_mapped_memory_objects.is_empty()
                && (rng.get_float() < map_probability)
                && (sys_mem_usage + memory_mapping_sys_mem_size <= memory_limits.total_system_memory)
            {
                // Map memory object
                let object = choose(&mut rng, &non_mapped_memory_objects);
                object.borrow_mut().map_random(&mut rng, map2)?;

                memory_mappings.push(Rc::clone(&object));
                mapped_memory_objects.push(Rc::clone(&object));
                remove_first_equal(&mut non_mapped_memory_objects, &object);

                total_mem_tracker.allocate(MemoryClass::System, memory_mapping_sys_mem_size);
            } else {
                // Sort heaps based on capacity (full or not)
                let mut non_full_heaps: Vec<usize> = Vec::new();
                let mut non_empty_heaps: Vec<usize> = Vec::new();

                if sys_mem_usage + memory_object_sys_mem_size <= memory_limits.total_system_memory {
                    // For the duration of sorting reserve MemoryObject space from system memory
                    total_mem_tracker.allocate(MemoryClass::System, memory_object_sys_mem_size);

                    for (heap_ndx, heap) in memory_heaps.iter().enumerate() {
                        if !heap.full(&total_mem_tracker) {
                            non_full_heaps.push(heap_ndx);
                        }

                        if !heap.empty(&total_mem_tracker) {
                            non_empty_heaps.push(heap_ndx);
                        }
                    }

                    total_mem_tracker.free(MemoryClass::System, memory_object_sys_mem_size);
                } else {
                    // Not possible to even allocate MemoryObject from system memory, look for non-empty heaps
                    for (heap_ndx, heap) in memory_heaps.iter().enumerate() {
                        if !heap.empty(&total_mem_tracker) {
                            non_empty_heaps.push(heap_ndx);
                        }
                    }
                }

                if !non_full_heaps.is_empty() && (non_empty_heaps.is_empty() || rng.get_float() < alloc_probability) {
                    // Reserve MemoryObject from sys mem first
                    total_mem_tracker.allocate(MemoryClass::System, memory_object_sys_mem_size);

                    // Allocate more memory objects
                    let heap_ndx = choose(&mut rng, &non_full_heaps);
                    let object = memory_heaps[heap_ndx].allocate_random(vkd, &mut rng, &mut total_mem_tracker)?;

                    non_mapped_memory_objects.push(object);
                } else if !non_empty_heaps.is_empty() {
                    // Free memory objects
                    let heap_ndx = choose(&mut rng, &non_empty_heaps);
                    let object = memory_heaps[heap_ndx].get_random_object(&mut rng);

                    // Remove mapping
                    if object.borrow().has_mapping() {
                        remove_first_equal(&mut memory_mappings, &object);
                        total_mem_tracker.free(MemoryClass::System, memory_mapping_sys_mem_size);
                    }

                    remove_first_equal(&mut mapped_memory_objects, &object);
                    remove_first_equal(&mut non_mapped_memory_objects, &object);

                    memory_heaps[heap_ndx].free(&object, &mut total_mem_tracker);
                    total_mem_tracker.free(MemoryClass::System, memory_object_sys_mem_size);
                }
            }
        }

        // Everything below owns a VkDeviceMemory; dropping the object lists before the
        // heaps that also hold them is harmless (Rc), but the heaps must outlive the
        // device, which they do - the device belongs to the Context.
        Ok(TestStatus::pass("Pass"))
    }
}

/// `Context::getDescriptorBufferPropertiesEXT`
fn get_descriptor_buffer_properties(
    vki: &Instance,
    physical_device: vk::PhysicalDevice,
) -> vk::PhysicalDeviceDescriptorBufferPropertiesEXT {
    let mut descriptor_buffer_properties = vk::PhysicalDeviceDescriptorBufferPropertiesEXT {
        s_type: vk::StructureType::PHYSICAL_DEVICE_DESCRIPTOR_BUFFER_PROPERTIES_EXT,
        ..Default::default()
    };
    let mut properties2 = vk::PhysicalDeviceProperties2 {
        s_type: vk::StructureType::PHYSICAL_DEVICE_PROPERTIES_2,
        next: (&raw mut descriptor_buffer_properties).cast(),
        properties: vk::PhysicalDeviceProperties::default(),
    };

    unsafe { vki.get_physical_device_properties2(physical_device, &mut properties2) };

    descriptor_buffer_properties
}

// ---------------------------------------------------------------------------------
// Case registration
// ---------------------------------------------------------------------------------

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Op {
    None = 0,

    Flush,
    SubFlush,
    SubFlushSeparate,
    #[allow(dead_code)]
    SubFlushOverlapping,

    Invalidate,
    SubInvalidate,
    SubInvalidateSeparate,
    #[allow(dead_code)]
    SubInvalidateOverlapping,

    Remap,
    ImplicitUnmap,
}

/// The size upstream hands to `vkFlushMappedMemoryRanges`/`vkInvalidateMappedMemoryRanges`.
///
/// `subMappedConfig` rewrites a range that runs past the mapping to VK_WHOLE_SIZE, and
/// this rounding then adds to it - so in C++ the arithmetic wraps and the driver is
/// handed 0. Reproducing the wrap rather than the intent is deliberate: the point of
/// the port is to make the same call upstream makes, and a size of VK_WHOLE_SIZE here
/// would be a different test. In Rust the addition has to say so explicitly, since a
/// debug build traps on overflow instead.
fn round_size_up_to_atom(size: vk::DeviceSize, atom_size: vk::DeviceSize) -> vk::DeviceSize {
    if size.is_multiple_of(atom_size) {
        size
    } else {
        size.wrapping_add(atom_size - (size % atom_size))
    }
}

/// `subMappedConfig`
fn sub_mapped_config(
    allocation_size: vk::DeviceSize,
    mapping: MemoryRange,
    op: Op,
    seed: u32,
    allocation_kind: AllocationKind,
    memory_map2: bool,
) -> TestConfig {
    let mut config = TestConfig {
        allocation_size,
        seed,
        mapping,
        flush_mappings: Vec::new(),
        invalidate_mappings: Vec::new(),
        remap: false,
        implicit_unmap: false,
        allocation_kind,
        memory_map2,
    };

    match op {
        Op::None => {}

        Op::Remap => config.remap = true,

        Op::ImplicitUnmap => config.implicit_unmap = true,

        Op::Flush => config.flush_mappings = vec![MemoryRange::new(mapping.offset, mapping.size)],

        Op::SubFlush => {
            config.flush_mappings = vec![MemoryRange::new(mapping.offset + mapping.size / 4, mapping.size / 2)]
        }

        Op::SubFlushSeparate => {
            config.flush_mappings.push(MemoryRange::new(
                mapping.offset + mapping.size / 2,
                mapping.size - (mapping.size / 2),
            ));
            config
                .flush_mappings
                .push(MemoryRange::new(mapping.offset, mapping.size / 2));
        }

        Op::SubFlushOverlapping => {
            config.flush_mappings.push(MemoryRange::new(
                mapping.offset + mapping.size / 3,
                mapping.size - (mapping.size / 2),
            ));
            config
                .flush_mappings
                .push(MemoryRange::new(mapping.offset, (2 * mapping.size) / 3));
        }

        Op::Invalidate => {
            config.flush_mappings = vec![MemoryRange::new(mapping.offset, mapping.size)];
            config.invalidate_mappings = vec![MemoryRange::new(mapping.offset, mapping.size)];
        }

        Op::SubInvalidate => {
            config.flush_mappings = vec![MemoryRange::new(mapping.offset + mapping.size / 4, mapping.size / 2)];
            config.invalidate_mappings = vec![MemoryRange::new(mapping.offset + mapping.size / 4, mapping.size / 2)];
        }

        Op::SubInvalidateSeparate => {
            config.flush_mappings.push(MemoryRange::new(
                mapping.offset + mapping.size / 2,
                mapping.size - (mapping.size / 2),
            ));
            config
                .flush_mappings
                .push(MemoryRange::new(mapping.offset, mapping.size / 2));

            config.invalidate_mappings.push(MemoryRange::new(
                mapping.offset + mapping.size / 2,
                mapping.size - (mapping.size / 2),
            ));
            config
                .invalidate_mappings
                .push(MemoryRange::new(mapping.offset, mapping.size / 2));
        }

        Op::SubInvalidateOverlapping => {
            config.flush_mappings.push(MemoryRange::new(
                mapping.offset + mapping.size / 3,
                mapping.size - (mapping.size / 2),
            ));
            config
                .flush_mappings
                .push(MemoryRange::new(mapping.offset, (2 * mapping.size) / 3));

            config.invalidate_mappings.push(MemoryRange::new(
                mapping.offset + mapping.size / 3,
                mapping.size - (mapping.size / 2),
            ));
            config
                .invalidate_mappings
                .push(MemoryRange::new(mapping.offset, (2 * mapping.size) / 3));
        }
    }

    for range in &mut config.flush_mappings {
        if range.offset + range.size > mapping.size {
            range.size = vk::WHOLE_SIZE;
        }
    }
    for range in &mut config.invalidate_mappings {
        if range.offset + range.size > mapping.size {
            range.size = vk::WHOLE_SIZE;
        }
    }
    config
}

/// `fullMappedConfig`
fn full_mapped_config(
    allocation_size: vk::DeviceSize,
    op: Op,
    seed: u32,
    allocation_kind: AllocationKind,
    memory_map2: bool,
) -> TestConfig {
    sub_mapped_config(
        allocation_size,
        MemoryRange::new(0, allocation_size),
        op,
        seed,
        allocation_kind,
        memory_map2,
    )
}

/// `checkMapMemory2Support`
fn check_map_memory2_support(context: &Context<'_>, memory_map2: bool) -> Result<(), TestError> {
    if memory_map2 {
        context.require_device_functionality("VK_KHR_map_memory2")?;
    }
    Ok(())
}

/// `VK_KHR_dedicated_allocation` was promoted to core in Vulkan 1.1, and upstream's
/// `isDeviceFunctionalitySupported` honours that promotion. The port's promotion table
/// (`vkt::context::promoted_to_core_version`) does not carry this extension, so the
/// core check is made here instead.
fn require_dedicated_allocation(context: &Context<'_>) -> Result<(), TestError> {
    if context.get_device_properties().api_version >= vk::make_version(1, 1, 0) {
        return Ok(());
    }
    context.require_device_functionality("VK_KHR_dedicated_allocation")
}

/// One `dEQP-VK.memory.mapping.*.{full,sub}.*` case.
struct MemoryMappingCase {
    name: String,
    config: TestConfig,
}

impl TestCase for MemoryMappingCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport(Context&, TestConfig)`
    ///
    /// Upstream also does `requireInstanceFunctionality("VK_KHR_get_physical_device_properties2")`;
    /// hodow_cts creates a Vulkan 1.1 instance, where that extension is core, so the
    /// check can never fail here.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.config.allocation_kind == AllocationKind::DedicatedImage
            || self.config.allocation_kind == AllocationKind::DedicatedBuffer
        {
            require_dedicated_allocation(context)?;
        }

        check_map_memory2_support(context, self.config.memory_map2)
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MemoryMappingInstance {
            context,
            config: &self.config,
        })
    }
}

struct MemoryMappingInstance<'a> {
    context: &'a Context<'a>,
    config: &'a TestConfig,
}

impl TestInstance for MemoryMappingInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        test_memory_mapping(self.context, self.config)
    }
}

/// One `dEQP-VK.memory.mapping.suballocation.random.*` case.
struct RandomMemoryMappingCase {
    name: String,
    config: RandomMappingConfig,
}

impl TestCase for RandomMemoryMappingCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport(Context&, RandomMappingConfig)`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_map_memory2_support(context, self.config.memory_map2)
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(RandomMemoryMappingInstance {
            context,
            config: self.config,
        })
    }
}

/// `createMappingTests`
pub fn create_mapping_tests() -> TestCaseGroup {
    // Memory mapping tests.
    let mut group = TestCaseGroup::new("mapping");
    // Dedicated memory mapping tests.
    let mut dedicated = TestCaseGroup::new("dedicated_alloc");
    let mut sets = [
        TestCaseGroup::new("suballocation"),
        TestCaseGroup::new("buffer"),
        TestCaseGroup::new("image"),
    ];

    const ALLOCATION_SIZES: [vk::DeviceSize; 6] = [0, 33, 257, 4087, 8095, 1024 * 1024 + 1];

    const OFFSETS: [vk::DeviceSize; 6] = [0, 17, 129, 255, 1025, 32 * 1024 + 1];

    const SIZES: [vk::DeviceSize; 5] = [31, 255, 1025, 4085, 1024 * 1024 - 1];

    // The two `_overlapping` entries deliberately carry the `_SEPARATE` op: that is what
    // upstream registers, and matching its behaviour matters more than the name reading
    // right.
    const OPS: [(Op, &str); 11] = [
        (Op::None, "simple"),
        (Op::Remap, "remap"),
        (Op::ImplicitUnmap, "implicit_unmap"),
        (Op::Flush, "flush"),
        (Op::SubFlush, "subflush"),
        (Op::SubFlushSeparate, "subflush_separate"),
        (Op::SubFlushSeparate, "subflush_overlapping"),
        (Op::Invalidate, "invalidate"),
        (Op::SubInvalidate, "subinvalidate"),
        (Op::SubInvalidateSeparate, "subinvalidate_separate"),
        (Op::SubInvalidateSeparate, "subinvalidate_overlapping"),
    ];

    const MAP_FUNCTIONS: [(bool, &str); 2] = [(false, ""), (true, "_map2")];

    // .full
    for (allocation_kind_ndx, allocation_kind) in ALLOCATION_KINDS.into_iter().enumerate() {
        let mut full_group = TestCaseGroup::new("full");

        for (allocation_size_ndx, allocation_size) in ALLOCATION_SIZES.into_iter().enumerate() {
            let size_group_name = if allocation_size == 0 {
                "variable".to_string()
            } else {
                allocation_size.to_string()
            };
            let mut allocation_size_group = TestCaseGroup::new(size_group_name);

            for (op_ndx, (op, op_name)) in OPS.into_iter().enumerate() {
                // implicit_unmap ignores allocationSize
                if ((allocation_size == 0) && (op != Op::ImplicitUnmap))
                    || ((allocation_size != 0) && (op == Op::ImplicitUnmap))
                {
                    continue;
                }

                for (memory_map2, name_suffix) in MAP_FUNCTIONS {
                    let name = format!("{op_name}{name_suffix}");
                    let seed = (op_ndx * allocation_size_ndx) as u32;
                    let config = full_mapped_config(allocation_size, op, seed, allocation_kind, memory_map2);

                    allocation_size_group.add_child(Box::new(MemoryMappingCase { name, config }) as Box<dyn TestCase>);
                }
            }

            full_group.add_child(allocation_size_group);
        }

        sets[allocation_kind_ndx].add_child(full_group);
    }

    // .sub
    for (allocation_kind_ndx, allocation_kind) in ALLOCATION_KINDS.into_iter().enumerate() {
        let mut sub_group = TestCaseGroup::new("sub");

        for (allocation_size_ndx, allocation_size) in ALLOCATION_SIZES.into_iter().enumerate() {
            let size_group_name = if allocation_size == 0 {
                "variable".to_string()
            } else {
                allocation_size.to_string()
            };
            let mut allocation_size_group = TestCaseGroup::new(size_group_name);

            for offset in OFFSETS {
                if offset >= allocation_size {
                    continue;
                }

                let mut offset_group = TestCaseGroup::new(format!("offset_{offset}"));

                for size in SIZES {
                    if offset + size > allocation_size {
                        continue;
                    }

                    if offset == 0 && size == allocation_size {
                        continue;
                    }

                    let mut size_group = TestCaseGroup::new(format!("size_{size}"));

                    for (op_ndx, (op, op_name)) in OPS.into_iter().enumerate() {
                        // implicit_unmap ignores allocationSize
                        if ((allocation_size == 0) && (op != Op::ImplicitUnmap))
                            || ((allocation_size != 0) && (op == Op::ImplicitUnmap))
                        {
                            continue;
                        }

                        let seed = (op_ndx * allocation_size_ndx) as u32;

                        for (memory_map2, name_suffix) in MAP_FUNCTIONS {
                            let name = format!("{op_name}{name_suffix}");
                            let config = sub_mapped_config(
                                allocation_size,
                                MemoryRange::new(offset, size),
                                op,
                                seed,
                                allocation_kind,
                                memory_map2,
                            );

                            size_group.add_child(Box::new(MemoryMappingCase { name, config }) as Box<dyn TestCase>);
                        }
                    }

                    offset_group.add_child(size_group);
                }

                allocation_size_group.add_child(offset_group);
            }

            sub_group.add_child(allocation_size_group);
        }

        sets[allocation_kind_ndx].add_child(sub_group);
    }

    // .random
    {
        let mut random_group = TestCaseGroup::new("random");
        let mut rng = Random::new(3927960301u32);
        for ndx in 0..100usize {
            let seed = rng.get_uint32();

            for (memory_map2, name_suffix) in MAP_FUNCTIONS {
                let name = format!("{ndx}{name_suffix}");
                let config = RandomMappingConfig { seed, memory_map2 };
                // Random case
                random_group.add_child(Box::new(RandomMemoryMappingCase { name, config }) as Box<dyn TestCase>);
            }
        }

        sets[AllocationKind::Suballocated as usize].add_child(random_group);
    }

    let [suballocation, buffer, image] = sets;
    group.add_child(suballocation);
    dedicated.add_child(buffer);
    dedicated.add_child(image);
    group.add_child(dedicated);

    group
}
