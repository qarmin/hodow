// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory/vktMemoryAllocationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 Google Inc.
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// One upstream file produces all three groups - `allocation`, `pageable_allocation`
// and `device_group_allocation` - from `createAllocationTestsCommon`, and that shape
// is kept here: the three public entry points differ only in the AllocationMode they
// pass.
//
// Two structural differences are forced by the framework and are the only ones:
//
//   * Upstream's `iterate` returns `tcu::TestStatus::incomplete()` and is called
//     again; hodow_cts calls `iterate` exactly once, so the outer "call me again"
//     loop (over memory types, and over random operations) is written as a Rust loop
//     around the same body.
//   * `TestCase::createInstance` cannot fail here, so the custom `VkDevice` these
//     tests build is created at the top of `iterate` instead of in the constructor.
//
// These tests use no shaders at all.

// Several loops here index by position because the upstream C++ does, and keeping the
// shape is what makes this file diffable against it when Khronos changes it.
#![allow(clippy::needless_range_loop, clippy::enum_variant_names)]

use std::alloc::Layout;
use std::collections::HashMap;
use std::ffi::c_void;
use std::sync::{Mutex, MutexGuard};

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::{self, Random, TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

/// The min max for allocation count is 4096. Use 4000 to take into account
/// possible memory allocations made by layers etc.
const MAX_ALLOCATION_COUNT: u32 = 4000;

#[derive(Clone, Copy, PartialEq, Eq)]
enum AllocationMode {
    Default,
    DeviceGroup,
    Pageable,
}

/// `TestConfig::Order`
#[derive(Clone, Copy, PartialEq, Eq)]
enum Order {
    AllocFree,
    AllocReverseFree,
    MixedAllocFree,
}

#[derive(Clone, Copy)]
struct TestConfig {
    memory_size: Option<vk::DeviceSize>,
    memory_percentage: Option<f32>,
    memory_allocation_count: u32,
    order: Order,
    allocation_mode: AllocationMode,
}

#[derive(Clone, Copy)]
struct TestConfigRandom {
    seed: u32,
    allocation_mode: AllocationMode,
}

/// The two failure kinds these paths raise, carried together.
///
/// Upstream throws `tcu::TestError` (which the framework turns into a Fail verdict)
/// and the `TestException` family (NotSupported, ResourceError, ...) from the same
/// functions. `TestError` here has no Fail variant, so `Fail` is spelled out and
/// unwrapped where `iterate` can return a `TestStatus`.
enum Bail {
    Fail(String),
    Error(TestError),
}

impl From<TestError> for Bail {
    fn from(error: TestError) -> Self {
        Self::Error(error)
    }
}

/// `tcu::ResultCollector`, reduced to the slice this file uses. Upstream orders
/// results by severity; only `fail` is ever called here, and a second failure keeps
/// the first message either way.
struct ResultCollector {
    result: Option<(TestResult, String)>,
}

impl ResultCollector {
    fn new() -> Self {
        Self { result: None }
    }

    fn fail(&mut self, message: impl Into<String>) {
        let message = message.into();
        log::error!("{message}");
        if self.result.is_none() {
            self.result = Some((TestResult::Fail, message));
        }
    }

    fn status(&self) -> TestStatus {
        match &self.result {
            Some((code, message)) => TestStatus::new(*code, message.clone()),
            None => TestStatus::pass("Pass"),
        }
    }
}

/// `tcu::PlatformMemoryLimits`, reduced to the three fields this file reads.
///
/// These are the values `tcu::Platform::getMemoryLimits` hands out; upstream's Linux
/// and Windows ports do not override them (only Android and the null platform do), so
/// the numbers a desktop `deqp-vk` run uses are exactly these.
#[derive(Clone, Copy)]
struct PlatformMemoryLimits {
    total_system_memory: u64,
    total_device_local_memory: u64,
    device_memory_allocation_granularity: u64,
}

impl PlatformMemoryLimits {
    fn get() -> Self {
        Self {
            total_system_memory: 256 * 1024 * 1024,
            total_device_local_memory: 128 * 1024 * 1024,
            device_memory_allocation_granularity: 64 * 1024,
        }
    }
}

fn round_up_to_next_multiple(value: vk::DeviceSize, multiple: vk::DeviceSize) -> vk::DeviceSize {
    if value.is_multiple_of(multiple) { value } else { value + multiple - (value % multiple) }
}

/// `deInt32Hash`, the seed generator the random cases are named after.
fn de_int32_hash(a: i32) -> u32 {
    // From: http://www.concentric.net/~Ttwang/tech/inthash.htm
    let mut key = a as u32;
    key = (key ^ 61) ^ (key >> 16);
    key = key.wrapping_add(key << 3);
    key ^= key >> 4;
    key = key.wrapping_mul(0x27d4eb2d); // prime/odd constant
    key ^= key >> 15;
    key
}

/// `Context::isDeviceFunctionalitySupported`, which hodow_cts's Context only exposes
/// in its throwing form.
fn is_device_functionality_supported(context: &Context<'_>, extension: &str) -> bool {
    context.get_device_extensions().iter().any(|e| e == extension)
}

// ---------------------------------------------------------------------------------
// BaseAllocateTestInstance
// ---------------------------------------------------------------------------------

/// The custom device both test instances allocate from, plus the properties they read.
///
/// The device is destroyed in `Drop`, which runs after the owning instance's own
/// `Drop` has freed every VkDeviceMemory taken from it - freeing memory through a
/// destroyed device would be a use-after-free.
struct BaseAllocateTestInstance<'a> {
    context: &'a Context<'a>,
    logical_device: Device,
    allocation_mode: AllocationMode,
    subset_allocation_allowed: bool,
    alloc_flags_info: vk::MemoryAllocateFlagsInfo,
    num_phys_devices: u32,
    memory_properties: vk::PhysicalDeviceMemoryProperties,
    device_coherent_mem_supported: bool,
}

impl<'a> BaseAllocateTestInstance<'a> {
    fn new(context: &'a Context<'a>, allocation_mode: AllocationMode, enable_descriptor_buffer: bool) -> Result<Self, Bail> {
        let mut subset_allocation_allowed = false;
        let mut num_phys_devices = 1;
        let mut device_coherent_mem_supported = false;
        let mut memory_properties = unsafe { context.get_instance().get_physical_device_memory_properties(context.get_physical_device()) };

        let logical_device = if allocation_mode == AllocationMode::DeviceGroup {
            create_device_group(context, &mut num_phys_devices, &mut subset_allocation_allowed, &mut memory_properties)?
        } else {
            create_test_device(context, allocation_mode, enable_descriptor_buffer, &mut device_coherent_mem_supported)?
        };

        let alloc_flags_info = vk::MemoryAllocateFlagsInfo {
            s_type: vk::StructureType::MEMORY_ALLOCATE_FLAGS_INFO,
            next: std::ptr::null(),
            flags: vk::MemoryAllocateFlags::DEVICE_MASK,
            device_mask: 0,
        };

        Ok(Self {
            context,
            logical_device,
            allocation_mode,
            subset_allocation_allowed,
            alloc_flags_info,
            num_phys_devices,
            memory_properties,
            device_coherent_mem_supported,
        })
    }
}

impl Drop for BaseAllocateTestInstance<'_> {
    fn drop(&mut self) {
        unsafe { self.logical_device.destroy_device(None) };
    }
}

/// `BaseAllocateTestInstance::createTestDevice`
fn create_test_device(context: &Context<'_>, allocation_mode: AllocationMode, enable_descriptor_buffer: bool, device_coherent_mem_supported: &mut bool) -> Result<Device, Bail> {
    let instance_driver = context.get_instance();
    let physical_device = context.get_physical_device();
    let device_features = unsafe { instance_driver.get_physical_device_features(physical_device) };
    let queue_priority = 1.0f32;
    let queue_family_index = 0u32;
    let use_pageable = allocation_mode == AllocationMode::Pageable;

    let mut pageable_device_local_memory_feature = vk::PhysicalDevicePageableDeviceLocalMemoryFeaturesEXT {
        s_type: vk::StructureType::PHYSICAL_DEVICE_PAGEABLE_DEVICE_LOCAL_MEMORY_FEATURES_EXT,
        next: std::ptr::null_mut(),
        pageable_device_local_memory: vk::FALSE,
    };
    let mut p_next: *mut c_void = if use_pageable {
        (&raw mut pageable_device_local_memory_feature).cast()
    } else {
        std::ptr::null_mut()
    };

    let mut protected_memory_feature = vk::PhysicalDeviceProtectedMemoryFeatures {
        s_type: vk::StructureType::PHYSICAL_DEVICE_PROTECTED_MEMORY_FEATURES,
        next: p_next,
        protected_memory: vk::FALSE,
    };
    p_next = (&raw mut protected_memory_feature).cast();

    let mut coherent_memory_features = vk::PhysicalDeviceCoherentMemoryFeaturesAMD {
        s_type: vk::StructureType::PHYSICAL_DEVICE_COHERENT_MEMORY_FEATURES_AMD,
        next: p_next,
        device_coherent_memory: vk::FALSE,
    };
    if is_device_functionality_supported(context, "VK_AMD_device_coherent_memory") {
        p_next = (&raw mut coherent_memory_features).cast();
    }

    let mut features2 = vk::PhysicalDeviceFeatures2 {
        s_type: vk::StructureType::PHYSICAL_DEVICE_FEATURES_2,
        next: p_next,
        features: vk::PhysicalDeviceFeatures::default(),
    };

    // requireInstanceFunctionality("VK_KHR_get_physical_device_properties2"): the
    // instance is created at API 1.1, where this is core, so there is nothing to ask
    // for.
    unsafe { instance_driver.get_physical_device_features2(physical_device, &mut features2) };
    let prot_mem_supported = protected_memory_feature.protected_memory != vk::FALSE;
    *device_coherent_mem_supported = coherent_memory_features.device_coherent_memory != vk::FALSE;

    let queue_create_flags = if prot_mem_supported {
        vk::DeviceQueueCreateFlags::PROTECTED
    } else {
        vk::DeviceQueueCreateFlags::empty()
    };

    if use_pageable && pageable_device_local_memory_feature.pageable_device_local_memory == vk::FALSE {
        return Err(Bail::Fail(
            "pageableDeviceLocalMemory feature not supported but VK_EXT_pageable_device_local_memory advertised".to_string(),
        ));
    }

    // Clippy sees a dead store here; it is not one. This struct was chained into
    // `features2.pNext` as a raw pointer above, so the write is read by
    // vkCreateDevice through that chain rather than through this binding.
    #[allow(unused_assignments)]
    {
        pageable_device_local_memory_feature.pageable_device_local_memory = if use_pageable { vk::TRUE } else { vk::FALSE };
    }

    let mut device_extensions: Vec<*const i8> = Vec::new();
    if use_pageable {
        device_extensions.push(vk::EXT_MEMORY_PRIORITY_EXTENSION.name.as_ptr());
        device_extensions.push(vk::EXT_PAGEABLE_DEVICE_LOCAL_MEMORY_EXTENSION.name.as_ptr());
    }
    if enable_descriptor_buffer && is_device_functionality_supported(context, "VK_EXT_descriptor_buffer") {
        // vulkanalia marks this deprecated in favour of VK_EXT_descriptor_heap, but
        // the extension the test must enable is the one upstream names.
        #[allow(deprecated)]
        device_extensions.push(vk::EXT_DESCRIPTOR_BUFFER_EXTENSION.name.as_ptr());
    }

    let queue_info = vk::DeviceQueueCreateInfo {
        s_type: vk::StructureType::DEVICE_QUEUE_CREATE_INFO,
        next: std::ptr::null(),
        flags: queue_create_flags,
        queue_family_index,
        queue_count: 1,
        queue_priorities: &raw const queue_priority,
    };

    let uses_features2 = prot_mem_supported || use_pageable || *device_coherent_mem_supported;
    let device_info = vk::DeviceCreateInfo {
        s_type: vk::StructureType::DEVICE_CREATE_INFO,
        next: if uses_features2 { (&raw const features2).cast() } else { std::ptr::null() },
        flags: vk::DeviceCreateFlags::empty(),
        queue_create_info_count: 1,
        queue_create_infos: &raw const queue_info,
        enabled_layer_count: 0,
        enabled_layer_names: std::ptr::null(),
        enabled_extension_count: device_extensions.len() as u32,
        enabled_extension_names: if device_extensions.is_empty() { std::ptr::null() } else { device_extensions.as_ptr() },
        enabled_features: if uses_features2 { std::ptr::null() } else { &raw const device_features },
    };

    Ok(unsafe { instance_driver.create_device(physical_device, &device_info, None) }.vk_check("vkCreateDevice")?)
}

/// `BaseAllocateTestInstance::createDeviceGroup`
fn create_device_group(
    context: &Context<'_>,
    num_phys_devices: &mut u32,
    subset_allocation_allowed: &mut bool,
    memory_properties: &mut vk::PhysicalDeviceMemoryProperties,
) -> Result<Device, Bail> {
    // Upstream reads --deqp-vk-device-group-id / --deqp-vk-device-id here; hodow_cts
    // has neither flag, so both stay at the defaults those options carry.
    let dev_group_idx = 0usize;
    let phys_device_idx = 0usize;
    let queue_priority = 1.0f32;
    let mut queue_family_index = 0u32;
    let instance_driver = context.get_instance();
    let dev_group_properties = unsafe { instance_driver.enumerate_physical_device_groups() }.vk_check("vkEnumeratePhysicalDeviceGroups")?;

    if dev_group_properties.len() <= dev_group_idx {
        return Err(Bail::Error(TestError::InternalError("no physical device group to create a device from".to_string())));
    }

    *num_phys_devices = dev_group_properties[dev_group_idx].physical_device_count;
    *subset_allocation_allowed = dev_group_properties[dev_group_idx].subset_allocation != vk::FALSE;
    // VK_KHR_device_group is core from 1.1 and the instance is created at 1.1, so
    // `isCoreDeviceExtension` is always true and the list stays empty.
    let device_extensions: Vec<*const i8> = Vec::new();

    let device_group_info = vk::DeviceGroupDeviceCreateInfo {
        s_type: vk::StructureType::DEVICE_GROUP_DEVICE_CREATE_INFO,
        next: std::ptr::null(),
        physical_device_count: dev_group_properties[dev_group_idx].physical_device_count,
        physical_devices: dev_group_properties[dev_group_idx].physical_devices.as_ptr(),
    };

    let group_physical_device = dev_group_properties[dev_group_idx].physical_devices[phys_device_idx];
    let device_features = unsafe { instance_driver.get_physical_device_features(group_physical_device) };

    let queue_props = unsafe { instance_driver.get_physical_device_queue_family_properties(group_physical_device) };
    for (queue_ndx, props) in queue_props.iter().enumerate() {
        if props.queue_flags.contains(vk::QueueFlags::COMPUTE) {
            queue_family_index = queue_ndx as u32;
        }
    }

    let queue_info = vk::DeviceQueueCreateInfo {
        s_type: vk::StructureType::DEVICE_QUEUE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::DeviceQueueCreateFlags::empty(),
        queue_family_index,
        queue_count: 1,
        queue_priorities: &raw const queue_priority,
    };

    let device_info = vk::DeviceCreateInfo {
        s_type: vk::StructureType::DEVICE_CREATE_INFO,
        next: (&raw const device_group_info).cast(),
        flags: vk::DeviceCreateFlags::empty(),
        queue_create_info_count: 1,
        queue_create_infos: &raw const queue_info,
        enabled_layer_count: 0,
        enabled_layer_names: std::ptr::null(),
        enabled_extension_count: device_extensions.len() as u32,
        enabled_extension_names: if device_extensions.is_empty() { std::ptr::null() } else { device_extensions.as_ptr() },
        enabled_features: &raw const device_features,
    };

    let logical_device = unsafe { instance_driver.create_device(group_physical_device, &device_info, None) }.vk_check("vkCreateDevice")?;

    *memory_properties = unsafe { instance_driver.get_physical_device_memory_properties(group_physical_device) };

    Ok(logical_device)
}

// ---------------------------------------------------------------------------------
// AllocateFreeTestInstance
// ---------------------------------------------------------------------------------

struct AllocateFreeTestInstance<'a> {
    context: &'a Context<'a>,
    config: TestConfig,
}

impl TestInstance for AllocateFreeTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let base = match BaseAllocateTestInstance::new(self.context, self.config.allocation_mode, false) {
            Ok(base) => base,
            Err(Bail::Fail(message)) => return Ok(TestStatus::fail(message)),
            Err(Bail::Error(error)) => return Err(error),
        };

        let config = self.config;
        let mut result = ResultCollector::new();
        let memory_limits = PlatformMemoryLimits::get();
        // Upstream rewrites the member for every device mask; `base` is only borrowed
        // immutably from here on, so the struct is taken out by value instead.
        let mut alloc_flags_info = base.alloc_flags_info;

        // Upstream's iterate() handles one memory type per call and asks the framework
        // to call it again; the loop is explicit here.
        for memory_type_index in 0..base.memory_properties.memory_type_count {
            let device = &base.logical_device;
            let queue_family_index = base.context.get_universal_queue_family_index();
            let mut create_flags = vk::BufferCreateFlags::empty();
            let usage_flags = vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST;
            let sharing_mode = vk::SharingMode::EXCLUSIVE;

            if base.memory_properties.memory_types[memory_type_index as usize]
                .property_flags
                .contains(vk::MemoryPropertyFlags::PROTECTED)
            {
                create_flags |= vk::BufferCreateFlags::PROTECTED;
            }

            if memory_type_index == 0 {
                log::debug!("Memory allocation count: {}", config.memory_allocation_count);
                log::debug!(
                    "Single allocation size: {}",
                    match config.memory_size {
                        Some(memory_size) => memory_size.to_string(),
                        None => format!("{} percent of the heap size.", 100.0 * config.memory_percentage.unwrap_or(0.0)),
                    }
                );

                match config.order {
                    Order::AllocReverseFree => log::debug!("Memory is freed in reversed order. "),
                    Order::AllocFree => log::debug!("Memory is freed in same order as allocated. "),
                    Order::MixedAllocFree => log::debug!("Memory is freed right after allocation. "),
                }
            }

            let memory_type_supported = !(base.memory_properties.memory_types[memory_type_index as usize]
                .property_flags
                .contains(vk::MemoryPropertyFlags::DEVICE_COHERENT_AMD)
                && !base.device_coherent_mem_supported);

            if memory_type_supported {
                let outcome = (|| -> Result<(), TestError> {
                    let memory_type = base.memory_properties.memory_types[memory_type_index as usize];
                    // Upstream reads memoryHeaps[heapIndex] before checking the index and
                    // would run off the end of the array; the check has to come first here.
                    if memory_type.heap_index as usize >= base.memory_properties.memory_heaps.len() {
                        return Err(TestError::InternalError("Invalid heap index defined for memory type.".to_string()));
                    }
                    let memory_heap = base.memory_properties.memory_heaps[memory_type.heap_index as usize];

                    // Create a buffer to get the required size
                    let mem_reqs = {
                        let buffer_size = match config.memory_size {
                            Some(memory_size) => memory_size,
                            None => (config.memory_percentage.unwrap_or(0.0) * memory_heap.size as f32) as vk::DeviceSize,
                        };

                        let buffer_params = vk::BufferCreateInfo {
                            s_type: vk::StructureType::BUFFER_CREATE_INFO,
                            next: std::ptr::null(),
                            flags: create_flags,
                            size: buffer_size,
                            usage: usage_flags,
                            sharing_mode,
                            queue_family_index_count: 1,
                            queue_family_indices: &raw const queue_family_index,
                        };

                        let buffer = Unique::new(device, unsafe { device.create_buffer(&buffer_params, None) }.vk_check("vkCreateBuffer")?);
                        unsafe { device.get_buffer_memory_requirements(*buffer) }
                    };

                    let allocation_size = match config.memory_size {
                        Some(_) => mem_reqs.size,
                        None => (config.memory_percentage.unwrap_or(0.0) * memory_heap.size as f32) as vk::DeviceSize,
                    };
                    let rounded_up_allocation_size = round_up_to_next_multiple(allocation_size, memory_limits.device_memory_allocation_granularity);
                    let mut memory_objects = vec![vk::DeviceMemory::null(); config.memory_allocation_count as usize];

                    log::debug!("Memory type index: {memory_type_index}");

                    if memory_type.heap_index >= base.memory_properties.memory_heap_count {
                        return Err(TestError::InternalError("Invalid heap index defined for memory type.".to_string()));
                    }

                    log::debug!("Memory type: {memory_type:?}");
                    log::debug!("Memory heap: {memory_heap:?}");

                    // note this check can't be moved to checkSupport as it requires buffer creation
                    if rounded_up_allocation_size.saturating_mul(config.memory_allocation_count as u64) > memory_heap.size {
                        crate::tcu_throw_not_supported!("Memory heap doesn't have enough memory.");
                    }

                    // For 32-bit binaries we cap the total host visible allocations to 1.5GB to
                    // avoid exhausting CPU virtual address space and throwing a false negative result.
                    let out_of_address_space = cfg!(target_pointer_width = "32")
                        && memory_type.property_flags.contains(vk::MemoryPropertyFlags::HOST_VISIBLE)
                        && allocation_size
                            .saturating_mul(config.memory_allocation_count as u64)
                            .saturating_mul(if base.subset_allocation_allowed { 1 } else { base.num_phys_devices as u64 })
                            >= 1610612736;

                    if out_of_address_space {
                        log::debug!("    Skipping: Not enough CPU virtual address space for all host visible allocations.");
                    } else {
                        let allocated = (|| -> Result<(), TestError> {
                            let total_device_mask_combinations = if base.subset_allocation_allowed { (1 << base.num_phys_devices) - 1 } else { 1 };
                            let mut device_mask = 1u32;
                            while device_mask <= total_device_mask_combinations {
                                // Allocate on all physical devices if subset allocation is not allowed, do only once.
                                if !base.subset_allocation_allowed {
                                    device_mask = (1 << base.num_phys_devices) - 1;
                                }
                                alloc_flags_info.device_mask = device_mask;

                                if config.order == Order::AllocFree || config.order == Order::AllocReverseFree {
                                    for ndx in 0..config.memory_allocation_count as usize {
                                        let alloc = make_memory_allocate_info(base.allocation_mode, &alloc_flags_info, allocation_size, memory_type_index);

                                        let res = unsafe { device.allocate_memory(&alloc, None) };

                                        // Some implementations might have limitations on protected heap, and these limitations
                                        // don't show up in Vulkan queries. Use a hard coded threshold after which out of memory
                                        // is allowed.
                                        if matches!(res, Err(vk::ErrorCode::OUT_OF_DEVICE_MEMORY))
                                            && memory_type.property_flags.contains(vk::MemoryPropertyFlags::PROTECTED)
                                            && ndx > 80
                                        {
                                            break;
                                        }

                                        // We don't know the purpose of the memory type, memory type might have limitation not checked in this test.
                                        if matches!(res, Err(vk::ErrorCode::OUT_OF_DEVICE_MEMORY)) && (mem_reqs.memory_type_bits & (1 << memory_type_index)) == 0 {
                                            break;
                                        }

                                        memory_objects[ndx] = res.vk_check("vkAllocateMemory")?;

                                        if memory_objects[ndx].is_null() {
                                            return Err(TestError::InternalError("vkAllocateMemory returned a null handle".to_string()));
                                        }
                                    }

                                    if config.order == Order::AllocFree {
                                        for ndx in 0..config.memory_allocation_count as usize {
                                            let last = memory_objects.len() - 1 - ndx;
                                            let mem = memory_objects[last];

                                            if !mem.is_null() {
                                                unsafe { device.free_memory(mem, None) };
                                                memory_objects[last] = vk::DeviceMemory::null();
                                            }
                                        }
                                    } else {
                                        for ndx in 0..config.memory_allocation_count as usize {
                                            let mem = memory_objects[ndx];

                                            if !mem.is_null() {
                                                unsafe { device.free_memory(mem, None) };
                                                memory_objects[ndx] = vk::DeviceMemory::null();
                                            }
                                        }
                                    }
                                } else {
                                    for ndx in 0..config.memory_allocation_count as usize {
                                        let alloc = make_memory_allocate_info(base.allocation_mode, &alloc_flags_info, allocation_size, memory_type_index);

                                        memory_objects[ndx] = unsafe { device.allocate_memory(&alloc, None) }.vk_check("vkAllocateMemory")?;
                                        if memory_objects[ndx].is_null() {
                                            return Err(TestError::InternalError("vkAllocateMemory returned a null handle".to_string()));
                                        }
                                        unsafe { device.free_memory(memory_objects[ndx], None) };
                                        memory_objects[ndx] = vk::DeviceMemory::null();
                                    }
                                }

                                device_mask += 1;
                            }

                            Ok(())
                        })();

                        // Upstream's catch(...) frees whatever is still live and rethrows.
                        // Running it on the success path too is harmless: every branch above
                        // nulls the handles it freed.
                        for ndx in 0..config.memory_allocation_count as usize {
                            let mem = memory_objects[ndx];

                            if !mem.is_null() {
                                unsafe { device.free_memory(mem, None) };
                                memory_objects[ndx] = vk::DeviceMemory::null();
                            }
                        }

                        allocated?;
                    }

                    Ok(())
                })();

                match outcome {
                    Ok(()) => {}
                    // NotSupportedError and ResourceError are not tcu::TestError upstream,
                    // so they escape iterate() and become the whole test's verdict.
                    Err(error @ (TestError::NotSupported(_) | TestError::ResourceError(_))) => return Err(error),
                    Err(error) => result.fail(error.to_string()),
                }
            }
        }

        Ok(result.status())
    }
}

fn make_memory_allocate_info(
    allocation_mode: AllocationMode,
    alloc_flags_info: &vk::MemoryAllocateFlagsInfo,
    allocation_size: vk::DeviceSize,
    memory_type_index: u32,
) -> vk::MemoryAllocateInfo {
    vk::MemoryAllocateInfo {
        s_type: vk::StructureType::MEMORY_ALLOCATE_INFO,
        next: if allocation_mode == AllocationMode::DeviceGroup {
            (alloc_flags_info as *const vk::MemoryAllocateFlagsInfo).cast()
        } else {
            std::ptr::null()
        },
        allocation_size,
        memory_type_index,
    }
}

// ---------------------------------------------------------------------------------
// computeDeviceMemorySystemMemFootprint
// ---------------------------------------------------------------------------------

/// `vk::AllocationCallbackRecorder`, reduced to what the footprint measurement needs:
/// the live allocations and their sizes.
///
/// Upstream also records a full history and validates it for callback violations
/// (double free, unknown pointer, wrong scope); that machinery is not ported, so
/// `TCU_CHECK(validateRes.violations.empty())` has no counterpart here. It only ever
/// fires on a driver that misuses its own allocator, which no ported case depends on.
struct AllocationCallbackRecorder {
    live: Mutex<HashMap<usize, (usize, usize)>>,
}

impl AllocationCallbackRecorder {
    fn new() -> Self {
        Self { live: Mutex::new(HashMap::new()) }
    }

    /// A poisoned lock would mean a panic crossed an `extern "system"` boundary, which
    /// is already fatal; recovering the map is strictly better than panicking again.
    fn lock(&self) -> MutexGuard<'_, HashMap<usize, (usize, usize)>> {
        self.live.lock().unwrap_or_else(|poisoned| poisoned.into_inner())
    }

    /// `getLiveSystemAllocationTotal`
    fn live_system_allocation_total(&self) -> usize {
        self.lock().values().map(|&(size, alignment)| size + alignment - usize::from(alignment > 0)).sum()
    }

    fn live_allocation_count(&self) -> usize {
        self.lock().len()
    }
}

unsafe extern "system" fn allocation_callback(user_data: *mut c_void, size: usize, alignment: usize, _allocation_scope: vk::SystemAllocationScope) -> *mut c_void {
    if size == 0 {
        return std::ptr::null_mut();
    }
    let alignment = alignment.max(1);
    let Ok(layout) = Layout::from_size_align(size, alignment) else {
        return std::ptr::null_mut();
    };
    let ptr = unsafe { std::alloc::alloc(layout) };
    if ptr.is_null() {
        return std::ptr::null_mut();
    }
    let recorder = unsafe { &*user_data.cast::<AllocationCallbackRecorder>() };
    recorder.lock().insert(ptr as usize, (size, alignment));
    ptr.cast()
}

unsafe extern "system" fn reallocation_callback(
    user_data: *mut c_void,
    original: *mut c_void,
    size: usize,
    alignment: usize,
    allocation_scope: vk::SystemAllocationScope,
) -> *mut c_void {
    if original.is_null() {
        return unsafe { allocation_callback(user_data, size, alignment, allocation_scope) };
    }
    if size == 0 {
        unsafe { free_callback(user_data, original) };
        return std::ptr::null_mut();
    }

    let recorder = unsafe { &*user_data.cast::<AllocationCallbackRecorder>() };
    let mut live = recorder.lock();
    let Some((old_size, old_alignment)) = live.remove(&(original as usize)) else {
        return std::ptr::null_mut();
    };
    let Ok(old_layout) = Layout::from_size_align(old_size, old_alignment) else {
        return std::ptr::null_mut();
    };
    // Vulkan requires the requested alignment to match the original allocation's, so
    // reallocating under the old layout keeps the guarantee the driver asked for.
    let ptr = unsafe { std::alloc::realloc(original.cast(), old_layout, size) };
    if ptr.is_null() {
        live.insert(original as usize, (old_size, old_alignment));
        return std::ptr::null_mut();
    }
    live.insert(ptr as usize, (size, old_alignment));
    ptr.cast()
}

unsafe extern "system" fn free_callback(user_data: *mut c_void, memory: *mut c_void) {
    if memory.is_null() {
        return;
    }
    let recorder = unsafe { &*user_data.cast::<AllocationCallbackRecorder>() };
    let entry = recorder.lock().remove(&(memory as usize));
    if let Some((size, alignment)) = entry
        && let Ok(layout) = Layout::from_size_align(size, alignment)
    {
        unsafe { std::alloc::dealloc(memory.cast(), layout) };
    }
}

/// `computeDeviceMemorySystemMemFootprint`
fn compute_device_memory_system_mem_footprint(vk: &Device) -> Result<usize, TestError> {
    let recorder = Box::new(AllocationCallbackRecorder::new());
    let callbacks = vk::AllocationCallbacks {
        user_data: (&raw const *recorder).cast_mut().cast(),
        allocation: Some(allocation_callback),
        reallocation: Some(reallocation_callback),
        free: Some(free_callback),
        internal_allocation: None,
        internal_free: None,
    };

    {
        // 1 B allocation from memory type 0
        let alloc_info = vk::MemoryAllocateInfo {
            s_type: vk::StructureType::MEMORY_ALLOCATE_INFO,
            next: std::ptr::null(),
            allocation_size: 1,
            memory_type_index: 0,
        };
        // Not a `Unique`: memory taken with these callbacks has to be given back with
        // the same ones, and Unique frees with a null allocator.
        let memory = unsafe { vk.allocate_memory(&alloc_info, Some(&callbacks)) }.vk_check("vkAllocateMemory")?;

        let footprint = recorder.live_system_allocation_total() + std::mem::size_of::<*const c_void>() * recorder.live_allocation_count(); // allocation overhead

        unsafe { vk.free_memory(memory, Some(&callbacks)) };

        Ok(footprint)
    }
}

// ---------------------------------------------------------------------------------
// RandomAllocFreeTestInstance
// ---------------------------------------------------------------------------------

#[derive(Clone, Copy)]
struct MemoryType {
    index: u32,
    /// Upstream calls this member `type`, which Rust reserves.
    mem_type: vk::MemoryType,
}

#[derive(Clone, Copy)]
struct MemoryObject {
    memory: vk::DeviceMemory,
    size: vk::DeviceSize,
    property_flags: vk::MemoryPropertyFlags,
}

struct Heap {
    heap: vk::MemoryHeap,
    memory_usage: vk::DeviceSize,
    max_memory_usage: vk::DeviceSize,
    types: Vec<MemoryType>,
    objects: Vec<MemoryObject>,
}

/// `m_rng.getUint32() % container.size()`, with the empty case upstream leaves to
/// undefined behaviour turned into a legible error instead of a division by zero.
fn random_index(rng: &mut Random, len: usize) -> Result<usize, TestError> {
    if len == 0 {
        return Err(TestError::InternalError("random choice from an empty set".to_string()));
    }
    Ok((rng.get_uint32() % len as u32) as usize)
}

/// `de::Random::choose<MemoryType>(first, last)` with `numItems == 1`.
///
/// Reservoir sampling, which draws one random number per element after the first. The
/// stream has to match upstream's, so this cannot become a single modulo.
fn choose_memory_type(rng: &mut Random, types: &[MemoryType]) -> Result<MemoryType, TestError> {
    let Some((first, rest)) = types.split_first() else {
        return Err(TestError::InternalError("no usable memory type in this heap".to_string()));
    };

    let mut val = *first;
    for (ndx, memory_type) in rest.iter().enumerate() {
        if rng.get_int(0, (ndx + 1) as i32) < 1 {
            val = *memory_type;
        }
    }
    Ok(val)
}

/// `Context::getDescriptorBufferPropertiesEXT`, which hodow_cts's Context does not
/// carry.
fn get_descriptor_buffer_properties_ext(context: &Context<'_>) -> vk::PhysicalDeviceDescriptorBufferPropertiesEXT {
    let mut descriptor_buffer_properties = vk::PhysicalDeviceDescriptorBufferPropertiesEXT::default();
    let mut properties2 = vk::PhysicalDeviceProperties2 {
        s_type: vk::StructureType::PHYSICAL_DEVICE_PROPERTIES_2,
        next: (&raw mut descriptor_buffer_properties).cast(),
        properties: vk::PhysicalDeviceProperties::default(),
    };
    unsafe { context.get_instance().get_physical_device_properties2(context.get_physical_device(), &mut properties2) };
    descriptor_buffer_properties
}

struct RandomAllocFreeTestInstance<'a> {
    base: BaseAllocateTestInstance<'a>,
    op_count: usize,
    alloc_sys_mem_size: usize,
    memory_limits: PlatformMemoryLimits,
    total_device_mask_combinations: u32,

    memory_object_count: u32,
    memory_protected_object_count: u32,
    current_device_mask: u32,
    op_ndx: usize,
    rng: Random,
    heaps: Vec<Heap>,
    total_system_mem: vk::DeviceSize,
    total_device_mem: vk::DeviceSize,
}

impl<'a> RandomAllocFreeTestInstance<'a> {
    fn new(context: &'a Context<'a>, config: TestConfigRandom) -> Result<Self, Bail> {
        let base = BaseAllocateTestInstance::new(context, config.allocation_mode, true)?;
        let op_count = 128usize;
        let alloc_sys_mem_size = compute_device_memory_system_mem_footprint(&base.logical_device)? + std::mem::size_of::<MemoryObject>();
        let memory_limits = PlatformMemoryLimits::get();
        let total_device_mask_combinations = if base.subset_allocation_allowed { (1 << base.num_phys_devices) - 1 } else { 1 };
        let current_device_mask = if base.subset_allocation_allowed { 1 } else { (1 << base.num_phys_devices) - 1 };

        if base.memory_properties.memory_heap_count > 32 {
            return Err(Bail::Fail("memoryHeapCount <= 32".to_string()));
        }
        if base.memory_properties.memory_type_count > 32 {
            return Err(Bail::Fail("memoryTypeCount <= 32".to_string()));
        }

        let mut mem_reqs_db = vk::MemoryRequirements::default();
        let mut mem_reqs_rb = vk::MemoryRequirements::default();
        let mut mem_reqs_sb = vk::MemoryRequirements::default();
        let descriptor_buffer_supported = is_device_functionality_supported(context, "VK_EXT_descriptor_buffer");

        // If descriptor buffers are supported we need to record which memory types
        // can be used for descriptor buffers as their memory allocations will
        // have some limitations.
        if descriptor_buffer_supported {
            let create_flags = vk::BufferCreateFlags::empty();
            let usage_flags_db = vk::BufferUsageFlags::SAMPLER_DESCRIPTOR_BUFFER_EXT | vk::BufferUsageFlags::RESOURCE_DESCRIPTOR_BUFFER_EXT;
            let usage_flags_rb = vk::BufferUsageFlags::RESOURCE_DESCRIPTOR_BUFFER_EXT;
            let usage_flags_sb = vk::BufferUsageFlags::SAMPLER_DESCRIPTOR_BUFFER_EXT;
            let sharing_mode = vk::SharingMode::EXCLUSIVE;
            let queue_family_index = 0u32;
            let device = &base.logical_device;
            let buffer_size = 1024u64;

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

            let mut buffer = Unique::new(device, unsafe { device.create_buffer(&buffer_params, None) }.vk_check("vkCreateBuffer")?);
            mem_reqs_db = unsafe { device.get_buffer_memory_requirements(*buffer) };

            buffer_params.usage = usage_flags_rb;
            buffer = Unique::new(device, unsafe { device.create_buffer(&buffer_params, None) }.vk_check("vkCreateBuffer")?);
            mem_reqs_rb = unsafe { device.get_buffer_memory_requirements(*buffer) };

            buffer_params.usage = usage_flags_sb;
            buffer = Unique::new(device, unsafe { device.create_buffer(&buffer_params, None) }.vk_check("vkCreateBuffer")?);
            mem_reqs_sb = unsafe { device.get_buffer_memory_requirements(*buffer) };
        }

        let mut heaps: Vec<Heap> = Vec::new();
        for heap_ndx in 0..base.memory_properties.memory_heap_count as usize {
            let heap = base.memory_properties.memory_heaps[heap_ndx];
            heaps.push(Heap {
                heap,
                memory_usage: 0,
                max_memory_usage: heap.size / 8, // Use at maximum 12.5% of heap
                types: Vec::new(),
                objects: Vec::with_capacity(100),
            });
        }

        for memory_type_ndx in 0..base.memory_properties.memory_type_count {
            let memory_type = MemoryType {
                index: memory_type_ndx,
                mem_type: base.memory_properties.memory_types[memory_type_ndx as usize],
            };

            if memory_type.mem_type.heap_index >= base.memory_properties.memory_heap_count {
                return Err(Bail::Fail("type.type.heapIndex < m_memoryProperties.memoryHeapCount".to_string()));
            }

            if base.memory_properties.memory_types[memory_type.index as usize]
                .property_flags
                .contains(vk::MemoryPropertyFlags::DEVICE_COHERENT_AMD)
                && !base.device_coherent_mem_supported
            {
                continue;
            }

            let heap_index = memory_type.mem_type.heap_index as usize;
            heaps[heap_index].types.push(memory_type);

            // If descriptor buffers are supported, then we need to limit heaps maximum allocation
            // size by the limit of the descriptor buffer address space
            if descriptor_buffer_supported {
                let descriptor_buffer_properties = get_descriptor_buffer_properties_ext(context);

                if (1 << memory_type_ndx) & mem_reqs_db.memory_type_bits != 0 {
                    heaps[heap_index].max_memory_usage = heaps[heap_index]
                        .max_memory_usage
                        .min(descriptor_buffer_properties.descriptor_buffer_address_space_size / 8);
                }

                if (1 << memory_type_ndx) & mem_reqs_rb.memory_type_bits != 0 {
                    heaps[heap_index].max_memory_usage = heaps[heap_index]
                        .max_memory_usage
                        .min(descriptor_buffer_properties.resource_descriptor_buffer_address_space_size / 8);
                }

                if (1 << memory_type_ndx) & mem_reqs_sb.memory_type_bits != 0 {
                    heaps[heap_index].max_memory_usage = heaps[heap_index]
                        .max_memory_usage
                        .min(descriptor_buffer_properties.sampler_descriptor_buffer_address_space_size / 8);
                }
            }
        }

        Ok(Self {
            base,
            op_count,
            alloc_sys_mem_size,
            memory_limits,
            total_device_mask_combinations,
            memory_object_count: 0,
            memory_protected_object_count: 0,
            current_device_mask,
            op_ndx: 0,
            rng: Random::new(config.seed),
            heaps,
            total_system_mem: 0,
            total_device_mem: 0,
        })
    }

    /// `RandomAllocFreeTestInstance::iterate`, with upstream's "call me again" loop
    /// made explicit.
    fn iterate(&mut self) -> TestOutcome {
        loop {
            let device = &self.base.logical_device;
            let is_uma = self.memory_limits.total_device_local_memory == 0;
            let used_sys_mem = if is_uma { self.total_device_mem + self.total_system_mem } else { self.total_system_mem };
            // \note Always leave room for 1 KiB sys mem alloc
            let can_allocate_sys = used_sys_mem + self.alloc_sys_mem_size as u64 + 1024 < self.memory_limits.total_system_memory;
            let can_allocate_dev = if is_uma {
                can_allocate_sys
            } else {
                self.total_device_mem + 16 < self.memory_limits.total_device_local_memory
            };
            let mut non_full_heaps: Vec<usize> = Vec::new();
            let mut non_empty_heaps: Vec<usize> = Vec::new();
            let allocate_more;

            if self.op_ndx == 0 {
                log::debug!("Performing {} random VkAllocMemory() / VkFreeMemory() calls before freeing all memory.", self.op_count);
                log::debug!("Using max 1/8 of the memory in each memory heap.");
            }

            // Sort heaps based on whether allocations or frees are possible
            for heap_ndx in 0..self.heaps.len() {
                let is_device_local = self.heaps[heap_ndx].heap.flags.contains(vk::MemoryHeapFlags::DEVICE_LOCAL);
                let is_heap_full = self.heaps[heap_ndx].memory_usage >= self.heaps[heap_ndx].max_memory_usage;
                let is_heap_empty = self.heaps[heap_ndx].memory_usage == 0;

                if !is_heap_empty {
                    non_empty_heaps.push(heap_ndx);
                }

                if !is_heap_full && ((is_uma && can_allocate_sys) || (!is_uma && is_device_local && can_allocate_dev) || (!is_uma && !is_device_local && can_allocate_sys)) {
                    non_full_heaps.push(heap_ndx);
                }
            }

            if self.op_ndx >= self.op_count {
                if non_empty_heaps.is_empty() {
                    self.current_device_mask += 1;
                    if self.current_device_mask > self.total_device_mask_combinations {
                        return Ok(TestStatus::pass("Pass"));
                    } else {
                        self.op_ndx = 0;
                        continue;
                    }
                } else {
                    allocate_more = false;
                }
            } else if !non_empty_heaps.is_empty() && !non_full_heaps.is_empty() && self.memory_object_count < MAX_ALLOCATION_COUNT && can_allocate_sys {
                allocate_more = self.rng.get_bool(); // Randomize if both operations are doable.
            } else if non_empty_heaps.is_empty() {
                allocate_more = true; // Allocate more if there are no objects to free.
            } else if non_full_heaps.is_empty() || !can_allocate_sys {
                allocate_more = false; // Free objects if there is no free space for new objects.
            } else {
                return Err(TestError::InternalError("Fail".to_string()));
            }

            if allocate_more {
                let non_full_heap_ndx = random_index(&mut self.rng, non_full_heaps.len())?;
                let heap_ndx = non_full_heaps[non_full_heap_ndx];
                let memory_type = choose_memory_type(&mut self.rng, &self.heaps[heap_ndx].types)?;
                let is_device_local = self.heaps[heap_ndx].heap.flags.contains(vk::MemoryHeapFlags::DEVICE_LOCAL);
                let is_protected = memory_type.mem_type.property_flags.contains(vk::MemoryPropertyFlags::PROTECTED);
                let heap_headroom = self.heaps[heap_ndx].max_memory_usage.saturating_sub(self.heaps[heap_ndx].memory_usage);
                let mut max_alloc_size = if is_device_local && !is_uma {
                    heap_headroom.min(self.memory_limits.total_device_local_memory.saturating_sub(self.total_device_mem))
                } else {
                    heap_headroom.min(
                        self.memory_limits
                            .total_system_memory
                            .saturating_sub(used_sys_mem)
                            .saturating_sub(self.alloc_sys_mem_size as u64),
                    )
                };
                let max_protected_alloc_size: vk::DeviceSize = 1024 * 1024;

                // Some implementations might have limitations on protected heap, and these
                // limitations don't show up in Vulkan queries. Use a hard coded limit for
                // allocations of arbitrarily selected size of 1MB as per Note at "Device
                // Memory Allocation" at the spec to use minimum-size allocations.
                if is_protected {
                    max_alloc_size = if max_alloc_size > max_protected_alloc_size {
                        max_protected_alloc_size
                    } else {
                        max_alloc_size
                    };
                }

                // Upstream divides by this unguarded; a zero would be a Rust panic rather
                // than the undefined behaviour it is there.
                let allocation_size = 1 + (self.rng.get_uint64() % max_alloc_size.max(1));

                if allocation_size > heap_headroom && allocation_size != 1 {
                    return Err(TestError::InternalError(
                        "Test Error: trying to allocate memory more than the available heap size.".to_string(),
                    ));
                }

                let object = MemoryObject {
                    memory: vk::DeviceMemory::null(),
                    size: allocation_size,
                    property_flags: memory_type.mem_type.property_flags,
                };

                self.heaps[heap_ndx].objects.push(object);

                self.base.alloc_flags_info.device_mask = self.current_device_mask;
                let alloc = make_memory_allocate_info(self.base.allocation_mode, &self.base.alloc_flags_info, object.size, memory_type.index);

                let res = unsafe { device.allocate_memory(&alloc, None) };

                // Some implementations might have limitations on protected heap, and these
                // limitations don't show up in Vulkan queries. Use a hard coded threshold
                // after which out of memory is allowed as per Note at "Device Memory Allocation"
                // at the spec to support at least 80 allocations concurrently.
                if matches!(res, Err(vk::ErrorCode::OUT_OF_DEVICE_MEMORY)) && is_protected && self.memory_protected_object_count > 80 {
                    self.heaps[heap_ndx].objects.pop();
                } else {
                    let memory = res.vk_check("vkAllocateMemory")?;

                    if memory.is_null() {
                        return Err(TestError::InternalError("vkAllocateMemory returned a null handle".to_string()));
                    }

                    let last = self.heaps[heap_ndx].objects.len() - 1;
                    self.heaps[heap_ndx].objects[last].memory = memory;
                    self.memory_object_count += 1;

                    if is_protected {
                        self.memory_protected_object_count += 1;
                    }

                    self.heaps[heap_ndx].memory_usage += allocation_size;
                    if is_device_local {
                        self.total_device_mem += allocation_size;
                    } else {
                        self.total_system_mem += allocation_size;
                    }
                    self.total_system_mem += self.alloc_sys_mem_size as u64;
                }
            } else {
                let non_empty_heap_ndx = random_index(&mut self.rng, non_empty_heaps.len())?;
                let heap_ndx = non_empty_heaps[non_empty_heap_ndx];
                let memory_object_ndx = random_index(&mut self.rng, self.heaps[heap_ndx].objects.len())?;
                let memory_object = self.heaps[heap_ndx].objects[memory_object_ndx];
                let is_device_local = self.heaps[heap_ndx].heap.flags.contains(vk::MemoryHeapFlags::DEVICE_LOCAL);

                unsafe { device.free_memory(memory_object.memory, None) };
                self.heaps[heap_ndx].objects[memory_object_ndx].memory = vk::DeviceMemory::null();
                self.memory_object_count -= 1;

                if memory_object.property_flags.contains(vk::MemoryPropertyFlags::PROTECTED) {
                    self.memory_protected_object_count -= 1;
                    self.heaps[heap_ndx].objects[memory_object_ndx].property_flags = vk::MemoryPropertyFlags::empty();
                }

                self.heaps[heap_ndx].memory_usage -= memory_object.size;
                if is_device_local {
                    self.total_device_mem -= memory_object.size;
                } else {
                    self.total_system_mem -= memory_object.size;
                }
                self.total_system_mem -= self.alloc_sys_mem_size as u64;

                self.heaps[heap_ndx].objects.swap_remove(memory_object_ndx);
            }

            self.op_ndx += 1;
        }
    }
}

impl Drop for RandomAllocFreeTestInstance<'_> {
    fn drop(&mut self) {
        // Runs before `base`, so the device is still alive here - freeing memory through
        // a destroyed device would be a use-after-free.
        for heap in &self.heaps {
            for object in &heap.objects {
                if !object.memory.is_null() {
                    unsafe { self.base.logical_device.free_memory(object.memory, None) };
                }
            }
        }
    }
}

/// The deferral `TestCase::createInstance` forces: it cannot fail, and building the
/// custom device can, so the ported instance is constructed on the first `iterate`.
struct RandomAllocFreeRunner<'a> {
    context: &'a Context<'a>,
    config: TestConfigRandom,
}

impl TestInstance for RandomAllocFreeRunner<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let mut instance = match RandomAllocFreeTestInstance::new(self.context, self.config) {
            Ok(instance) => instance,
            Err(Bail::Fail(message)) => return Ok(TestStatus::fail(message)),
            Err(Bail::Error(error)) => return Err(error),
        };
        instance.iterate()
    }
}

// ---------------------------------------------------------------------------------
// commonCheckSupport
// ---------------------------------------------------------------------------------

fn common_check_support(context: &Context<'_>, allocation_mode: AllocationMode) -> Result<(), TestError> {
    let vki = context.get_instance();
    // Upstream reads --deqp-vk-device-group-id here; hodow_cts has no such flag.
    let dev_group_idx = 0usize;
    let dev_group_properties = unsafe { vki.enumerate_physical_device_groups() }.vk_check("vkEnumeratePhysicalDeviceGroups")?;

    if dev_group_properties.len() <= dev_group_idx {
        return Err(TestError::InternalError("vkEnumeratePhysicalDeviceGroups reported no groups".to_string()));
    }

    if allocation_mode == AllocationMode::DeviceGroup && dev_group_properties[dev_group_idx].physical_device_count < 2 {
        crate::tcu_throw_not_supported!("Device group allocation tests not supported with 1 physical device");
    } else if allocation_mode == AllocationMode::Pageable {
        context.require_device_functionality("VK_EXT_pageable_device_local_memory")?;
    }

    Ok(())
}

// ---------------------------------------------------------------------------------
// Test cases
// ---------------------------------------------------------------------------------

struct AllocateFreeCase {
    name: String,
    config: TestConfig,
}

impl TestCase for AllocateFreeCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        common_check_support(context, self.config.allocation_mode)
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(AllocateFreeTestInstance { context, config: self.config })
    }
}

struct RandomAllocFreeCase {
    name: String,
    config: TestConfigRandom,
}

impl TestCase for RandomAllocFreeCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        common_check_support(context, self.config.allocation_mode)
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(RandomAllocFreeRunner { context, config: self.config })
    }
}

// ---------------------------------------------------------------------------------
// createAllocationTestsCommon
// ---------------------------------------------------------------------------------

fn create_allocation_tests_common(allocation_mode: AllocationMode) -> tcu::TestCaseGroup {
    let name = match allocation_mode {
        AllocationMode::Default => "allocation",
        AllocationMode::DeviceGroup => "device_group_allocation",
        AllocationMode::Pageable => "pageable_allocation",
    };
    let mut group = tcu::TestCaseGroup::new(name);

    const KIB: vk::DeviceSize = 1024;
    const MIB: vk::DeviceSize = 1024 * KIB;

    let allocation_sizes: [(&str, vk::DeviceSize); 8] = [
        ("64", 64),
        ("128", 128),
        ("256", 256),
        ("512", 512),
        ("1KiB", KIB),
        ("4KiB", 4 * KIB),
        ("8KiB", 8 * KIB),
        ("1MiB", MIB),
    ];

    let allocation_percents = [1];

    let allocation_counts = [1, 10, 100, 1000, -1];

    let orders = [("forward", Order::AllocFree), ("reverse", Order::AllocReverseFree), ("mixed", Order::MixedAllocFree)];

    {
        let mut basic_group = tcu::TestCaseGroup::new("basic");

        for (allocation_size_name, allocation_size) in allocation_sizes {
            let mut size_group = tcu::TestCaseGroup::new(format!("size_{allocation_size_name}"));

            for (order_name, order) in orders {
                let mut order_group = tcu::TestCaseGroup::new(order_name);

                for allocation_count in allocation_counts {
                    if allocation_count != -1 && allocation_count as u64 * allocation_size > 50 * MIB {
                        continue;
                    }

                    let memory_allocation_count = if allocation_count == -1 {
                        if allocation_size < 4096 {
                            continue;
                        }

                        let memory_allocation_count = ((50 * MIB / allocation_size) as u32).min(MAX_ALLOCATION_COUNT);

                        if memory_allocation_count == 0
                            || memory_allocation_count == 1
                            || memory_allocation_count == 10
                            || memory_allocation_count == 100
                            || memory_allocation_count == 1000
                        {
                            continue;
                        }
                        memory_allocation_count
                    } else {
                        allocation_count as u32
                    };

                    let config = TestConfig {
                        memory_size: Some(allocation_size),
                        memory_percentage: None,
                        memory_allocation_count,
                        order,
                        allocation_mode,
                    };

                    order_group.add_child(Box::new(AllocateFreeCase {
                        name: format!("count_{memory_allocation_count}"),
                        config,
                    }) as Box<dyn TestCase>);
                }

                size_group.add_child(order_group);
            }

            basic_group.add_child(size_group);
        }

        for allocation_percent in allocation_percents {
            let mut percent_group = tcu::TestCaseGroup::new(format!("percent_{allocation_percent}"));

            for (order_name, order) in orders {
                let mut order_group = tcu::TestCaseGroup::new(order_name);

                for allocation_count in allocation_counts {
                    if allocation_count != -1 && (allocation_count as f32 * allocation_percent as f32) >= 1.00f32 / 8.00f32 {
                        continue;
                    }

                    let memory_allocation_count = if allocation_count == -1 {
                        let memory_allocation_count = ((1.00f32 / 8.00f32) / (allocation_percent as f32 / 100.0f32)) as u32;
                        let memory_allocation_count = memory_allocation_count.min(MAX_ALLOCATION_COUNT);

                        if memory_allocation_count == 0
                            || memory_allocation_count == 1
                            || memory_allocation_count == 10
                            || memory_allocation_count == 100
                            || memory_allocation_count == 1000
                        {
                            continue;
                        }
                        memory_allocation_count
                    } else {
                        allocation_count as u32
                    };

                    let config = TestConfig {
                        memory_size: None,
                        memory_percentage: Some(allocation_percent as f32 / 100.0f32),
                        memory_allocation_count,
                        order,
                        allocation_mode,
                    };

                    order_group.add_child(Box::new(AllocateFreeCase {
                        name: format!("count_{memory_allocation_count}"),
                        config,
                    }) as Box<dyn TestCase>);
                }

                percent_group.add_child(order_group);
            }

            basic_group.add_child(percent_group);
        }

        group.add_child(basic_group);
    }

    {
        let case_count = 100u32;
        let mut random_group = tcu::TestCaseGroup::new("random");

        for case_ndx in 0..case_count {
            let config = TestConfigRandom {
                seed: de_int32_hash((case_ndx ^ 32480) as i32),
                allocation_mode,
            };
            // Random case
            random_group.add_child(Box::new(RandomAllocFreeCase {
                name: case_ndx.to_string(),
                config,
            }) as Box<dyn TestCase>);
        }

        group.add_child(random_group);
    }

    group
}

/// `createAllocationTests`
pub fn create_allocation_tests() -> tcu::TestCaseGroup {
    create_allocation_tests_common(AllocationMode::Default)
}

/// `createDeviceGroupAllocationTests`
pub fn create_device_group_allocation_tests() -> tcu::TestCaseGroup {
    create_allocation_tests_common(AllocationMode::DeviceGroup)
}

/// `createPageableAllocationTests`
pub fn create_pageable_allocation_tests() -> tcu::TestCaseGroup {
    create_allocation_tests_common(AllocationMode::Pageable)
}
