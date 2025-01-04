// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory/vktMemoryMapPlacedTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shader of `gpu_access.read_write` is in
// shaders/manifest/memory_map_placed.toml.
//
// The Context's default device does not enable `VkPhysicalDeviceMapMemoryPlacedFeaturesEXT`
// (an extension being enabled does not enable the features it introduces), so each case builds
// a small device of its own with the features the physical device reports, and runs on that.
// That is the one structural difference from upstream, which runs on the framework's device.
//
// The POSIX calls upstream makes (mmap, memfd_create, ...) are declared here directly:
// hodow_cts has no `libc` dependency and links nothing but libc already. Linux only; any
// other target reports NotSupported, as upstream's `#else` branch does.

#![cfg_attr(
    not(target_os = "linux"),
    allow(
        dead_code,
        unused_imports,
        reason = "the cases need Linux's mmap and report NotSupported elsewhere"
    )
)]

use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{InstanceV1_1, KhrMapMemory2ExtensionDeviceCommands};

use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_descriptor_buffer_info, make_descriptor_set,
};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The `rust_type` of the manifest entry holding the `gpu_access` compute shader.
#[derive(Clone, Copy)]
pub struct MapPlacedPrograms {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

#[cfg(target_os = "linux")]
mod sys {
    use std::ffi::{c_char, c_int, c_long, c_uint, c_void};

    pub const PROT_NONE: c_int = 0;
    pub const PROT_READ: c_int = 1;
    pub const PROT_WRITE: c_int = 2;
    pub const MAP_SHARED: c_int = 0x01;
    pub const MAP_PRIVATE: c_int = 0x02;
    pub const MAP_ANONYMOUS: c_int = 0x20;
    pub const MFD_CLOEXEC: c_uint = 1;
    pub const SC_PAGESIZE: c_int = 30;

    unsafe extern "C" {
        // The 64-bit-offset spellings, so the same declaration is right on 32-bit targets.
        pub fn mmap64(
            addr: *mut c_void,
            length: usize,
            prot: c_int,
            flags: c_int,
            fd: c_int,
            offset: i64,
        ) -> *mut c_void;
        pub fn munmap(addr: *mut c_void, length: usize) -> c_int;
        pub fn memfd_create(name: *const c_char, flags: c_uint) -> c_int;
        pub fn ftruncate64(fd: c_int, length: i64) -> c_int;
        pub fn close(fd: c_int) -> c_int;
        pub fn sysconf(name: c_int) -> c_long;
    }

    pub fn map_failed() -> *mut c_void {
        usize::MAX as *mut c_void
    }
}

/// `TestParams`
#[derive(Clone, Copy)]
struct TestParams {
    memory_size: vk::DeviceSize,
    test_unmap_reserve: bool,
    #[allow(dead_code)] // upstream's field; `Kind` is what the instance dispatches on here
    test_gpu_access: bool,
}

/// `verifyRangeInProcMaps` - that a memory range is still covered by one region of
/// /proc/self/maps after UNMAP_RESERVE. The `Err` is upstream's `TCU_THROW(QualityWarning, ..)`.
fn verify_range_in_proc_maps(range_start: usize, range_end: usize) -> Result<(), String> {
    let maps = std::fs::read_to_string("/proc/self/maps")
        .map_err(|_| "Could not open /proc/self/maps for verification".to_string())?;

    let range_found = maps.lines().any(|line| {
        let Some((span, _)) = line.split_once(' ') else {
            return false;
        };
        let Some((start, end)) = span.split_once('-') else {
            return false;
        };
        match (usize::from_str_radix(start, 16), usize::from_str_radix(end, 16)) {
            (Ok(map_start), Ok(map_end)) => map_start <= range_start && map_end >= range_end,
            _ => false,
        }
    });

    if !range_found {
        return Err(format!(
            "/proc/self/maps does not show the reserved range {range_start:x}-{range_end:x} as covered after UNMAP_RESERVE"
        ));
    }

    log::info!("UNMAP_RESERVE: range {range_start:x}-{range_end:x} is still covered in /proc/self/maps");
    Ok(())
}

/// A device with the map-placed features turned on, torn down on drop.
struct PlacedDevice {
    device: Device,
}

impl Drop for PlacedDevice {
    fn drop(&mut self) {
        unsafe {
            let _ = self.device.device_wait_idle();
            self.device.destroy_device(None);
        }
    }
}

fn create_placed_device(context: &Context<'_>) -> Result<PlacedDevice, TestError> {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let priorities = [1.0f32];
    let queue_infos = [vk::DeviceQueueCreateInfo::builder()
        .queue_family_index(context.get_universal_queue_family_index())
        .queue_priorities(&priorities)
        .build()];

    let mut placed_features = vk::PhysicalDeviceMapMemoryPlacedFeaturesEXT::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut placed_features);
    unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };

    let extensions = [c"VK_KHR_map_memory2".as_ptr(), c"VK_EXT_map_memory_placed".as_ptr()];
    let info = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&queue_infos)
        .enabled_extension_names(&extensions)
        .push_next(&mut features2);

    let device = unsafe { instance.create_device(physical_device, &info, None) }.vk_check("vkCreateDevice")?;
    Ok(PlacedDevice { device })
}

/// `VkPhysicalDeviceMapMemoryPlacedFeaturesEXT` as the physical device reports it.
fn query_placed_features(context: &Context<'_>) -> vk::PhysicalDeviceMapMemoryPlacedFeaturesEXT {
    let mut placed_features = vk::PhysicalDeviceMapMemoryPlacedFeaturesEXT::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut placed_features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    placed_features
}

/// `selectMatchingMemoryType(memProps, allowedBits, requirement)` for the host-visible requirement,
/// optionally also device-local.
fn first_memory_type(
    props: &vk::PhysicalDeviceMemoryProperties,
    allowed_bits: u32,
    required: vk::MemoryPropertyFlags,
) -> Option<u32> {
    (0..props.memory_type_count)
        .find(|&i| allowed_bits & (1u32 << i) != 0 && props.memory_types[i as usize].property_flags.contains(required))
}

fn allocate<'a>(
    device: &'a Device,
    size: vk::DeviceSize,
    memory_type_index: u32,
) -> Result<Unique<'a, vk::DeviceMemory>, TestError> {
    let info = vk::MemoryAllocateInfo {
        s_type: vk::StructureType::MEMORY_ALLOCATE_INFO,
        next: std::ptr::null(),
        allocation_size: size,
        memory_type_index,
    };
    let memory = unsafe { device.allocate_memory(&info, None) }.vk_check("vkAllocateMemory")?;
    Ok(Unique::new(device, memory))
}

fn placed_map_info(
    placed_info: &vk::MemoryMapPlacedInfoEXT,
    memory: vk::DeviceMemory,
    flags: vk::MemoryMapFlags,
) -> vk::MemoryMapInfo {
    vk::MemoryMapInfo {
        s_type: vk::StructureType::MEMORY_MAP_INFO,
        next: (placed_info as *const vk::MemoryMapPlacedInfoEXT).cast::<c_void>(),
        flags,
        memory,
        offset: 0,
        size: vk::WHOLE_SIZE,
    }
}

fn unmap_info(memory: vk::DeviceMemory, flags: vk::MemoryUnmapFlags) -> vk::MemoryUnmapInfo {
    vk::MemoryUnmapInfo {
        s_type: vk::StructureType::MEMORY_UNMAP_INFO,
        next: std::ptr::null(),
        flags,
        memory,
    }
}

/// `deAlignPtr`
fn align_up(value: usize, alignment: usize) -> usize {
    value.div_ceil(alignment) * alignment
}

/// `MapPlacedExactSizeTestInstance::iterate`
#[cfg(target_os = "linux")]
fn iterate_exact_size(context: &Context<'_>, params: TestParams) -> TestOutcome {
    use sys::*;

    let placed = create_placed_device(context)?;
    let vk = &placed.device;
    let vki = context.get_instance();
    let phys_dev = context.get_physical_device();
    let mut result_collector = ResultCollector::new("");

    let mut placed_props = vk::PhysicalDeviceMapMemoryPlacedPropertiesEXT::default();
    let mut props2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut placed_props);
    unsafe { vki.get_physical_device_properties2(phys_dev, &mut props2) };

    let page_size = unsafe { sysconf(SC_PAGESIZE) } as usize;
    let min_alignment = placed_props.min_placed_memory_map_alignment as usize;
    let alignment = if min_alignment > page_size {
        min_alignment
    } else {
        page_size
    };

    log::info!(
        "System page size: {page_size}, minPlacedMemoryMapAlignment: {min_alignment}, using alignment: {alignment}"
    );

    // Round the Vulkan allocation size up to a multiple of alignment so that the
    // placed mapping covers whole pages on both ends.
    let memory_size = params.memory_size as usize;
    let remainder = memory_size % alignment;
    let aligned_memory_size = if remainder == 0 {
        memory_size
    } else {
        memory_size + alignment - remainder
    };

    // Reserved memory layout:
    // |---- guard ----|---- VkMemory ----|---- guard ----|
    let guard_size = alignment;
    let file_size = guard_size + alignment + aligned_memory_size + guard_size;

    let memfd = unsafe { memfd_create(c"mapplaced-test".as_ptr(), MFD_CLOEXEC) };
    if memfd < 0 {
        return Err(TestError::NotSupported("memfd_create failed".to_string()));
    }

    if unsafe { ftruncate64(memfd, file_size as i64) } < 0 {
        unsafe { close(memfd) };
        return Err(TestError::InternalError("ftruncate failed".to_string()));
    }

    // Two independent views of the same backing file
    let reserved_map = unsafe {
        mmap64(
            std::ptr::null_mut(),
            file_size,
            PROT_READ | PROT_WRITE,
            MAP_SHARED,
            memfd,
            0,
        )
    };
    if reserved_map == map_failed() {
        unsafe { close(memfd) };
        return Err(TestError::InternalError("mmap failed for reservedMap".to_string()));
    }

    let inspector_map = unsafe {
        mmap64(
            std::ptr::null_mut(),
            file_size,
            PROT_READ | PROT_WRITE,
            MAP_SHARED,
            memfd,
            0,
        )
    };
    if inspector_map == map_failed() {
        unsafe {
            munmap(reserved_map, file_size);
            close(memfd);
        }
        return Err(TestError::InternalError("mmap failed for inspectorMap".to_string()));
    }

    // Every exit below goes through here, so the mappings and the fd are released exactly once.
    let release = || unsafe {
        munmap(inspector_map, file_size);
        munmap(reserved_map, file_size);
        close(memfd);
    };

    let reserved_base = reserved_map.cast::<u8>();
    let inspector_base = inspector_map.cast::<u8>().cast_const();

    log::info!("File size: {file_size}, reservedBase: {reserved_base:p}, inspectorBase: {inspector_base:p}");

    // Align placedAddr upward to satisfy minPlacedMemoryMapAlignment:
    let base_for_align = unsafe { reserved_base.add(guard_size) } as usize;
    let placed_addr = align_up(base_for_align, alignment) as *mut u8;
    let placed_offset = placed_addr as usize - reserved_base as usize;

    debug_assert!(placed_offset + aligned_memory_size <= file_size);

    log::info!("Placed address: {placed_addr:p} (file offset {placed_offset})");

    let mem_props = unsafe { vki.get_physical_device_memory_properties(phys_dev) };
    let Some(mem_type_index) = first_memory_type(&mem_props, !0u32, vk::MemoryPropertyFlags::HOST_VISIBLE) else {
        release();
        return Err(TestError::NotSupported("no host visible memory type".to_string()));
    };

    let memory = match allocate(vk, aligned_memory_size as vk::DeviceSize, mem_type_index) {
        Ok(memory) => memory,
        Err(e) => {
            release();
            return Err(e);
        }
    };

    let placed_info = vk::MemoryMapPlacedInfoEXT {
        s_type: vk::StructureType::MEMORY_MAP_PLACED_INFO_EXT,
        next: std::ptr::null(),
        placed_address: placed_addr.cast::<c_void>(),
    };
    let map_info = placed_map_info(&placed_info, *memory, vk::MemoryMapFlags::PLACED_EXT);

    let mapped_ptr = match unsafe { vk.map_memory2_khr(&map_info) } {
        Ok(ptr) => ptr,
        Err(_) => {
            release();
            result_collector.fail("vkMapMemory2 with VK_MEMORY_MAP_PLACED_BIT_EXT failed");
            return Ok(result_collector.to_status());
        }
    };

    if mapped_ptr != placed_addr.cast::<c_void>() {
        unsafe { vk.unmap_memory(*memory) };
        release();
        result_collector.fail("Mapped address does not match requested pPlacedAddress");
        return Ok(result_collector.to_status());
    }

    log::info!("VkDeviceMemory mapped at: {mapped_ptr:p}");

    // Fill entire range
    let fill_pattern: u8 = 0xAB;
    unsafe { std::ptr::write_bytes(reserved_base, fill_pattern, file_size) };

    if params.test_unmap_reserve {
        if let Err(e) = unsafe { vk.unmap_memory2_khr(&unmap_info(*memory, vk::MemoryUnmapFlags::RESERVE_EXT)) }
            .vk_check("vkUnmapMemory2")
        {
            release();
            return Err(e);
        }

        // Verify guard pages before the Vulkan mapping via reservedMap
        let mut ends_ok = true;
        let mut i = 0;
        while i < placed_offset && ends_ok {
            let byte = unsafe { *reserved_base.add(i) };
            if byte != fill_pattern {
                log::info!("Guard byte at offset {i} before Vulkan mapping has value {byte}, expected {fill_pattern}");
                result_collector
                    .fail("Pages before VkDeviceMemory are not accessible or corrupted after UNMAP_RESERVE");
                ends_ok = false;
            }
            i += 1;
        }

        // Verify guard pages after the Vulkan mapping via reservedMap
        let after_start = placed_offset + aligned_memory_size;
        let mut i = after_start;
        while i < file_size && ends_ok {
            let byte = unsafe { *reserved_base.add(i) };
            if byte != fill_pattern {
                log::info!("Guard byte at offset {i} after Vulkan mapping has value {byte}, expected {fill_pattern}");
                result_collector.fail("Pages after VkDeviceMemory are not accessible or corrupted after UNMAP_RESERVE");
                ends_ok = false;
            }
            i += 1;
        }

        if ends_ok {
            log::info!("UNMAP_RESERVE: guard pages before and after Vulkan mapping are accessible and correct");
        }

        // Verify /proc/self/maps cover range
        let placed_start = placed_addr as usize;
        if let Err(message) = verify_range_in_proc_maps(placed_start, placed_start + aligned_memory_size) {
            release();
            return Ok(TestStatus::new(TestResult::QualityWarning, message));
        }

        release();
        return Ok(result_collector.to_status());
    }

    unsafe { vk.unmap_memory(*memory) };

    // Verify via inspectorMap
    // |---- 0xAB ----|---- VkMemory ----|---- 0xAB----|
    let inspector_byte = |i: usize| unsafe { *inspector_base.add(i) };

    let mut passed_inspection = true;

    // Guard before
    let mut i = 0;
    while i < placed_offset && passed_inspection {
        if inspector_byte(i) != fill_pattern {
            log::info!(
                "inspectorMap byte at offset {i} (guard before) is {}, expected fillPattern {fill_pattern}",
                inspector_byte(i)
            );
            result_collector.fail("Guard pages before VkDeviceMemory mapping did not receive the fill pattern");
            passed_inspection = false;
        }
        i += 1;
    }

    // Vulkan region is managed by the driver and may be backed by device memory,
    // not the memfd file, so inspectorMap should not see the fill pattern there
    if passed_inspection {
        let mut i = placed_offset;
        while i < placed_offset + aligned_memory_size && passed_inspection {
            if inspector_byte(i) == fill_pattern {
                log::info!(
                    "inspectorMap byte at offset {i} Vulkan region is fillPattern {fill_pattern} driver must have mapped extra pages into the memfd backing"
                );
                result_collector.fail(
                    "VkDeviceMemory placed mapping overwrote the memfd backing driver mapped extra or wrong pages",
                );
                passed_inspection = false;
            }
            i += 1;
        }
    }

    // Guard after
    if passed_inspection {
        let after_start = placed_offset + aligned_memory_size;
        let mut i = after_start;
        while i < file_size && passed_inspection {
            if inspector_byte(i) != fill_pattern {
                log::info!(
                    "inspectorMap byte at offset {i} (guard after) is {}, expected fillPattern {fill_pattern}",
                    inspector_byte(i)
                );
                result_collector.fail("Guard pages after VkDeviceMemory mapping did not receive the fill pattern");
                passed_inspection = false;
            }
            i += 1;
        }
    }

    if passed_inspection {
        log::info!("Exact size test passed: guard pages have fillPattern, Vulkan region does not");
    }

    {
        let re_placed_info = vk::MemoryMapPlacedInfoEXT {
            s_type: vk::StructureType::MEMORY_MAP_PLACED_INFO_EXT,
            next: std::ptr::null(),
            placed_address: placed_addr.cast::<c_void>(),
        };
        let re_map_info = placed_map_info(&re_placed_info, *memory, vk::MemoryMapFlags::PLACED_EXT);
        match unsafe { vk.map_memory2_khr(&re_map_info) } {
            Ok(remapped_ptr) if remapped_ptr == placed_addr.cast::<c_void>() => {
                let verify_pattern: u32 = 0xCAFEBABE;
                let readback = unsafe {
                    remapped_ptr.cast::<u32>().write_unaligned(verify_pattern);
                    remapped_ptr.cast::<u32>().read_unaligned()
                };
                if readback != verify_pattern {
                    result_collector.fail("CPU read/write verification via re-mapped VkDeviceMemory failed");
                } else {
                    log::info!("CPU read/write via re-mapped memory passed");
                }
                unsafe { vk.unmap_memory(*memory) };
            }
            _ => {
                log::info!("Note: re-map for CPU verification skipped (could not map at same address again)");
            }
        }
    }

    release();
    Ok(result_collector.to_status())
}

/// `MapPlacedGpuAccessTestInstance::iterate`
#[cfg(target_os = "linux")]
fn iterate_gpu_access(context: &Context<'_>, params: TestParams) -> TestOutcome {
    use sys::*;

    let placed = create_placed_device(context)?;
    let vk = &placed.device;
    let vki = context.get_instance();
    let phys_dev = context.get_physical_device();
    let queue_family_index = context.get_universal_queue_family_index();
    let mut result_collector = ResultCollector::new("");

    let mut placed_props = vk::PhysicalDeviceMapMemoryPlacedPropertiesEXT::default();
    let mut props2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut placed_props);
    unsafe { vki.get_physical_device_properties2(phys_dev, &mut props2) };

    let page_size = unsafe { sysconf(SC_PAGESIZE) } as usize;
    let min_alignment = placed_props.min_placed_memory_map_alignment as usize;
    let alignment = if min_alignment > page_size {
        min_alignment
    } else {
        page_size
    };

    let mem_props = unsafe { vki.get_physical_device_memory_properties(phys_dev) };

    // getCompatibleMemoryTypes(HostVisible | Local), lowest bit first, else any host-visible type
    let mem_type_index = first_memory_type(
        &mem_props,
        !0u32,
        vk::MemoryPropertyFlags::HOST_VISIBLE | vk::MemoryPropertyFlags::DEVICE_LOCAL,
    )
    .or_else(|| first_memory_type(&mem_props, !0u32, vk::MemoryPropertyFlags::HOST_VISIBLE))
    .ok_or_else(|| TestError::NotSupported("no host visible memory type".to_string()))?;

    let buffer_size = params.memory_size;

    let queue_family_indices = [queue_family_index];
    let buffer_info = vk::BufferCreateInfo {
        s_type: vk::StructureType::BUFFER_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::BufferCreateFlags::empty(),
        size: buffer_size,
        usage: vk::BufferUsageFlags::STORAGE_BUFFER
            | vk::BufferUsageFlags::TRANSFER_SRC
            | vk::BufferUsageFlags::TRANSFER_DST,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 1,
        queue_family_indices: queue_family_indices.as_ptr(),
    };

    let buffer = unsafe { vk.create_buffer(&buffer_info, None) }.vk_check("vkCreateBuffer")?;
    let buffer = Unique::new(vk, buffer);

    let mem_reqs = unsafe { vk.get_buffer_memory_requirements(*buffer) };

    if mem_reqs.memory_type_bits & (1u32 << mem_type_index) == 0 {
        return Err(TestError::NotSupported(
            "Chosen memory type not compatible with buffer".to_string(),
        ));
    }

    let memory = allocate(vk, mem_reqs.size, mem_type_index)?;

    unsafe { vk.bind_buffer_memory(*buffer, *memory, 0) }.vk_check("vkBindBufferMemory")?;

    // Reserved address layout:
    // |--- slack ---|---- VkMemory ----|
    let reserve_size = mem_reqs.size as usize + alignment;
    let reserved_range = unsafe {
        mmap64(
            std::ptr::null_mut(),
            reserve_size,
            PROT_NONE,
            MAP_PRIVATE | MAP_ANONYMOUS,
            -1,
            0,
        )
    };
    if reserved_range == map_failed() {
        return Err(TestError::InternalError("Failed to reserve address range".to_string()));
    }

    let aligned_addr = align_up(reserved_range as usize, alignment);
    let reserved_addr = aligned_addr as *mut c_void;

    let placed_info = vk::MemoryMapPlacedInfoEXT {
        s_type: vk::StructureType::MEMORY_MAP_PLACED_INFO_EXT,
        next: std::ptr::null(),
        placed_address: reserved_addr,
    };
    let map_info = placed_map_info(&placed_info, *memory, vk::MemoryMapFlags::PLACED_EXT);

    let mapped_ptr = match unsafe { vk.map_memory2_khr(&map_info) } {
        Ok(ptr) => ptr,
        Err(_) => {
            unsafe { munmap(reserved_range, reserve_size) };
            result_collector.fail("Failed to map memory with MAP_PLACED_BIT");
            return Ok(result_collector.to_status());
        }
    };

    // CPU write
    let num_elements = (buffer_size / std::mem::size_of::<u32>() as u64) as u32;
    let data = mapped_ptr.cast::<u32>();
    let mem_flags = mem_props.memory_types[mem_type_index as usize].property_flags;

    for i in 0..num_elements {
        unsafe { data.add(i as usize).write(i) };
    }

    let whole_range = vk::MappedMemoryRange {
        s_type: vk::StructureType::MAPPED_MEMORY_RANGE,
        next: std::ptr::null(),
        memory: *memory,
        offset: 0,
        size: vk::WHOLE_SIZE,
    };
    if !mem_flags.contains(vk::MemoryPropertyFlags::HOST_COHERENT) {
        unsafe { vk.flush_mapped_memory_ranges(&[whole_range]) }.vk_check("vkFlushMappedMemoryRanges")?;
    }

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(vk)?;

    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

    let buffer_desc_info = make_descriptor_buffer_info(*buffer, 0, vk::WHOLE_SIZE);
    DescriptorSetUpdateBuilder::new()
        .write_single(
            *descriptor_set,
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &buffer_desc_info,
        )
        .update(vk);

    let mut pipeline = ComputePipelineWrapper::new(
        vk,
        ComputePipelineConstructionType::Pipeline,
        context.get_binary_collection().get("comp")?,
    );
    pipeline.set_descriptor_set_layout(*descriptor_set_layout);
    pipeline.build_pipeline()?;

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buf = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    begin_command_buffer(vk, *cmd_buf)?;

    {
        let barrier = vk::BufferMemoryBarrier {
            s_type: vk::StructureType::BUFFER_MEMORY_BARRIER,
            next: std::ptr::null(),
            src_access_mask: vk::AccessFlags::HOST_WRITE,
            dst_access_mask: vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
            src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
            dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
            buffer: *buffer,
            offset: 0,
            size: vk::WHOLE_SIZE,
        };
        unsafe {
            vk.cmd_pipeline_barrier(
                *cmd_buf,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }

    pipeline.bind(*cmd_buf);
    unsafe {
        vk.cmd_bind_descriptor_sets(
            *cmd_buf,
            vk::PipelineBindPoint::COMPUTE,
            pipeline.get_pipeline_layout(),
            0,
            &[*descriptor_set],
            &[],
        )
    };

    // GPU write
    let group_count = num_elements.div_ceil(64);
    unsafe { vk.cmd_dispatch(*cmd_buf, group_count, 1, 1) };

    {
        let barrier = vk::BufferMemoryBarrier {
            s_type: vk::StructureType::BUFFER_MEMORY_BARRIER,
            next: std::ptr::null(),
            src_access_mask: vk::AccessFlags::SHADER_WRITE,
            dst_access_mask: vk::AccessFlags::HOST_READ,
            src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
            dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
            buffer: *buffer,
            offset: 0,
            size: vk::WHOLE_SIZE,
        };
        unsafe {
            vk.cmd_pipeline_barrier(
                *cmd_buf,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }

    end_command_buffer(vk, *cmd_buf)?;

    // vkQueueSubmit + vkQueueWaitIdle on the universal queue, here on the matching queue of the new device.
    let queue = unsafe { vk.get_device_queue(queue_family_index, 0) };
    submit_commands_and_wait(vk, queue, *cmd_buf)?;

    // CPU readback
    if !mem_flags.contains(vk::MemoryPropertyFlags::HOST_COHERENT) {
        unsafe { vk.invalidate_mapped_memory_ranges(&[whole_range]) }.vk_check("vkInvalidateMappedMemoryRanges")?;
    }

    // Expected: values[i] = i + 1  (CPU wrote i, GPU added 1)
    let mut data_correct = true;
    let mut i = 0;
    while i < num_elements && data_correct {
        let expected = i + 1;
        let got = unsafe { data.add(i as usize).read() };
        if got != expected {
            log::info!("Data mismatch at index {i}: expected {expected}, got {got}");
            data_correct = false;
        }
        i += 1;
    }

    if !data_correct {
        result_collector.fail("GPU access verification failed: values[i] != i+1 after compute dispatch");
    } else {
        log::info!("GPU access test passed: all {num_elements} values correctly incremented by GPU");
    }

    // Unmap padding regions
    let placed_start = aligned_addr;
    let placed_end = placed_start + mem_reqs.size as usize;
    let reserve_start = reserved_range as usize;
    let prefix_size = placed_start - reserve_start;
    let suffix_size = reserve_size - prefix_size - mem_reqs.size as usize;
    if prefix_size > 0 {
        unsafe { munmap(reserved_range, prefix_size) };
    }
    if suffix_size > 0 {
        unsafe { munmap(placed_end as *mut c_void, suffix_size) };
    }

    Ok(result_collector.to_status())
}

/// `MapNormalUnmapReserveTestInstance::iterate`
#[cfg(target_os = "linux")]
fn iterate_normal_unmap_reserve(context: &Context<'_>, params: TestParams) -> TestOutcome {
    use sys::*;

    let placed = create_placed_device(context)?;
    let vk = &placed.device;
    let vki = context.get_instance();
    let phys_dev = context.get_physical_device();
    let mut result_collector = ResultCollector::new("");

    let mem_props = unsafe { vki.get_physical_device_memory_properties(phys_dev) };
    let mem_type_index = first_memory_type(&mem_props, !0u32, vk::MemoryPropertyFlags::HOST_VISIBLE)
        .ok_or_else(|| TestError::NotSupported("no host visible memory type".to_string()))?;

    let page_size = unsafe { sysconf(SC_PAGESIZE) } as usize;
    let aligned_mem_size = align_up(params.memory_size as usize, page_size);

    let memory = allocate(vk, aligned_mem_size as vk::DeviceSize, mem_type_index)?;

    let mapped_ptr =
        unsafe { vk.map_memory(*memory, 0, vk::WHOLE_SIZE, vk::MemoryMapFlags::empty()) }.vk_check("vkMapMemory")?;

    // Record the address range that is now mapped
    let range_start = mapped_ptr as usize;
    let range_end = range_start + aligned_mem_size;

    log::info!("Normal map: address {mapped_ptr:p}, size {aligned_mem_size}");

    unsafe { std::ptr::write_bytes(mapped_ptr.cast::<u8>(), 0xCD, aligned_mem_size) };

    unsafe { vk.unmap_memory2_khr(&unmap_info(*memory, vk::MemoryUnmapFlags::RESERVE_EXT)) }
        .vk_check("vkUnmapMemory2")?;

    log::info!("vkUnmapMemory2 with UNMAP_RESERVE done");

    // Verify mmap(NULL) not land in the reserved range
    {
        let prob_addr = unsafe {
            mmap64(
                std::ptr::null_mut(),
                page_size,
                PROT_NONE,
                MAP_PRIVATE | MAP_ANONYMOUS,
                -1,
                0,
            )
        };
        if prob_addr != map_failed() {
            let prob_start = prob_addr as usize;
            let overlaps = prob_start < range_end && prob_start + page_size > range_start;
            unsafe { munmap(prob_addr, page_size) };
            if overlaps {
                result_collector.fail(
                    "mmap(NULL) returned an address inside the UNMAP_RESERVE range range was not properly reserved",
                );
            } else {
                log::info!("mmap probe did not overlap the reserved range (good)");
            }
        }
    }

    // Verify /proc/self/maps cover range
    if let Err(message) = verify_range_in_proc_maps(range_start, range_end) {
        return Ok(TestStatus::new(TestResult::QualityWarning, message));
    }

    Ok(result_collector.to_status())
}

#[cfg(not(target_os = "linux"))]
fn iterate_exact_size(_context: &Context<'_>, _params: TestParams) -> TestOutcome {
    Err(TestError::NotSupported(
        "Test requires Linux/Android with memfd_create support".to_string(),
    ))
}

#[cfg(not(target_os = "linux"))]
fn iterate_gpu_access(_context: &Context<'_>, _params: TestParams) -> TestOutcome {
    Err(TestError::NotSupported(
        "Test requires POSIX system calls (Linux/Android only)".to_string(),
    ))
}

#[cfg(not(target_os = "linux"))]
fn iterate_normal_unmap_reserve(_context: &Context<'_>, _params: TestParams) -> TestOutcome {
    Err(TestError::NotSupported("Test requires Linux/Android".to_string()))
}

/// Which of upstream's three instance classes a case runs.
#[derive(Clone, Copy)]
enum Kind {
    /// `MapPlacedExactSizeTestInstance` (`MapPlacedTestCase` with `gpuAccessTest` false)
    ExactSize,
    /// `MapPlacedGpuAccessTestInstance` (`MapPlacedTestCase` with `gpuAccessTest` true)
    GpuAccess,
    /// `MapNormalUnmapReserveTestInstance` (`MapNormalUnmapReserveTestCase`)
    NormalUnmapReserve,
}

struct MapPlacedCase {
    name: String,
    kind: Kind,
    params: TestParams,
    programs: BinaryCollection,
}

impl TestCase for MapPlacedCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if !cfg!(target_os = "linux") {
            return Err(TestError::NotSupported(
                "Test requires POSIX system calls (Linux/Android only)".to_string(),
            ));
        }

        context.require_device_functionality("VK_EXT_map_memory_placed")?;
        context.require_device_functionality("VK_KHR_map_memory2")?;

        let placed_features = query_placed_features(context);

        match self.kind {
            Kind::ExactSize | Kind::GpuAccess => {
                if placed_features.memory_map_placed == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "memoryMapPlaced feature not supported".to_string(),
                    ));
                }

                if self.params.test_unmap_reserve && placed_features.memory_unmap_reserve == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "memoryUnmapReserve feature not supported".to_string(),
                    ));
                }
            }
            Kind::NormalUnmapReserve => {
                if placed_features.memory_unmap_reserve == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "memoryUnmapReserve feature not supported".to_string(),
                    ));
                }
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MapPlacedInstance {
            context,
            kind: self.kind,
            params: self.params,
        })
    }
}

struct MapPlacedInstance<'a> {
    context: &'a Context<'a>,
    kind: Kind,
    params: TestParams,
}

impl TestInstance for MapPlacedInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.kind {
            Kind::ExactSize => iterate_exact_size(self.context, self.params),
            Kind::GpuAccess => iterate_gpu_access(self.context, self.params),
            Kind::NormalUnmapReserve => iterate_normal_unmap_reserve(self.context, self.params),
        }
    }
}

/// `createMapPlacedTests`
pub fn create_map_placed_tests() -> TestCaseGroup {
    use crate::generated::shaders::memory_map_placed as g;

    let mut group = TestCaseGroup::new("map_placed");

    let sizes: [vk::DeviceSize; 4] = [
        4096,        // 1 page
        8192,        // 2 pages
        65536,       // 16 pages
        1024 * 1024, // 1 MB
    ];
    let no_programs = BinaryCollection::new(&[]);

    // Use double mmap strategy to verify that the driver maps exactly the
    // expected number of pages, no extra padding on either side
    {
        let mut exact_group = TestCaseGroup::new("exact_size");

        for size in sizes {
            exact_group.add_child(Box::new(MapPlacedCase {
                name: format!("size_{size}"),
                kind: Kind::ExactSize,
                params: TestParams {
                    memory_size: size,
                    test_unmap_reserve: false,
                    test_gpu_access: false,
                },
                programs: no_programs,
            }) as Box<dyn TestCase>);
        }

        group.add_child(exact_group);
    }

    // CPU writes data through the placed map, GPU increments each value via compute
    // shader, CPU reads back and verifies. Confirms that the placed mapping is
    // accessible to both the CPU and the GPU without corruption
    {
        let mut gpu_group = TestCaseGroup::new("gpu_access");

        gpu_group.add_child(Box::new(MapPlacedCase {
            name: "read_write".to_string(),
            kind: Kind::GpuAccess,
            params: TestParams {
                memory_size: 65536,
                test_unmap_reserve: false,
                test_gpu_access: true,
            },
            programs: g::MAP_PLACED_PROGRAMS.programs,
        }) as Box<dyn TestCase>);

        group.add_child(gpu_group);
    }

    // MAP_PLACED + UNMAP_RESERVE with exact size verification
    // after UNMAP_RESERVE, verifies that only the Vulkan region is reserved
    // and that guard pages on both sides are still accessible.
    {
        let mut unmap_reserve_group = TestCaseGroup::new("unmap_reserve");

        for size in sizes {
            unmap_reserve_group.add_child(Box::new(MapPlacedCase {
                name: format!("size_{size}"),
                kind: Kind::ExactSize,
                params: TestParams {
                    memory_size: size,
                    test_unmap_reserve: true,
                    test_gpu_access: false,
                },
                programs: no_programs,
            }) as Box<dyn TestCase>);
        }

        group.add_child(unmap_reserve_group);
    }

    // Map a memory object with the normal vkMapMemory then unmap with UNMAP_RESERVE
    // verifies that the address range remains reserved after the unmap
    // so that it cannot be recycled by a subsequent mmap
    {
        let mut normal_unmap_group = TestCaseGroup::new("normal_unmap_reserve");

        for size in sizes {
            normal_unmap_group.add_child(Box::new(MapPlacedCase {
                name: format!("size_{size}"),
                kind: Kind::NormalUnmapReserve,
                params: TestParams {
                    memory_size: size,
                    test_unmap_reserve: false,
                    test_gpu_access: false,
                },
                programs: no_programs,
            }) as Box<dyn TestCase>);
        }

        group.add_child(normal_unmap_group);
    }

    group
}
