// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiBufferTests.cpp
//   external/vulkancts/modules/vulkan/api/vktApiBufferViewCreateTests.cpp
//   external/vulkancts/modules/vulkan/api/vktApiGranularityTests.cpp
//   external/vulkancts/modules/vulkan/api/vktApiFormatPropertiesExtendedKHRtests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Samsung Electronics Co., Ltd.
// Copyright (c) 2021 The Khronos Group Inc.
// Copyright (c) 2016 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Every case in this file is shader-free - it creates and destroys Vulkan objects and
// queries properties - so no manifest and no GLSL belongs to it and `programs()`
// returns an empty collection throughout.
//
// The structure follows the upstream files closely: one TestCase + TestInstance pair
// per upstream class, `check_support` / `programs` / `create_instance` in that order,
// and `iterate` doing the same operations in the same sequence with the same names.
//
// Not ported here: `device_init`. `object_management` lives in its own module, and
// `buffer_view.access` in `buffer_view_access_tests`.

// Indexed loops and the wide tuple types below mirror the upstream C++; keeping the
// shape is what makes this file diffable against it.
#![allow(clippy::needless_range_loop, clippy::type_complexity, clippy::enum_variant_names)]

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, DeviceV1_3, DeviceV1_4, InstanceV1_1, KhrMaintenance5ExtensionDeviceCommands};

use crate::tcu::{Random, TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::mem_util::{MemoryRequirement, SimpleAllocator};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `VK_CORE_FORMAT_LAST` - one past `VK_FORMAT_ASTC_12x12_SRGB_BLOCK`, the last format
/// that is core rather than extension-provided. Several upstream groups iterate the
/// core format range with it.
const VK_CORE_FORMAT_LAST: i32 = 185;

/// `de::toLower(getFormatName(format)).substr(10)` for the core formats, i.e. the
/// spelling upstream uses to name a per-format test case. Indexed by
/// `format as usize - 1`, so `VK_FORMAT_UNDEFINED` has no entry - no group iterates it.
#[rustfmt::skip]
const FORMAT_NAMES: [&str; VK_CORE_FORMAT_LAST as usize - 1] = [
    "r4g4_unorm_pack8", "r4g4b4a4_unorm_pack16", "b4g4r4a4_unorm_pack16", "r5g6b5_unorm_pack16", "b5g6r5_unorm_pack16", "r5g5b5a1_unorm_pack16", "b5g5r5a1_unorm_pack16",
    "a1r5g5b5_unorm_pack16", "r8_unorm", "r8_snorm", "r8_uscaled", "r8_sscaled", "r8_uint", "r8_sint", "r8_srgb", "r8g8_unorm", "r8g8_snorm", "r8g8_uscaled", "r8g8_sscaled",
    "r8g8_uint", "r8g8_sint", "r8g8_srgb", "r8g8b8_unorm", "r8g8b8_snorm", "r8g8b8_uscaled", "r8g8b8_sscaled", "r8g8b8_uint", "r8g8b8_sint", "r8g8b8_srgb", "b8g8r8_unorm",
    "b8g8r8_snorm", "b8g8r8_uscaled", "b8g8r8_sscaled", "b8g8r8_uint", "b8g8r8_sint", "b8g8r8_srgb", "r8g8b8a8_unorm", "r8g8b8a8_snorm", "r8g8b8a8_uscaled",
    "r8g8b8a8_sscaled", "r8g8b8a8_uint", "r8g8b8a8_sint", "r8g8b8a8_srgb", "b8g8r8a8_unorm", "b8g8r8a8_snorm", "b8g8r8a8_uscaled", "b8g8r8a8_sscaled", "b8g8r8a8_uint",
    "b8g8r8a8_sint", "b8g8r8a8_srgb", "a8b8g8r8_unorm_pack32", "a8b8g8r8_snorm_pack32", "a8b8g8r8_uscaled_pack32", "a8b8g8r8_sscaled_pack32", "a8b8g8r8_uint_pack32",
    "a8b8g8r8_sint_pack32", "a8b8g8r8_srgb_pack32", "a2r10g10b10_unorm_pack32", "a2r10g10b10_snorm_pack32", "a2r10g10b10_uscaled_pack32", "a2r10g10b10_sscaled_pack32",
    "a2r10g10b10_uint_pack32", "a2r10g10b10_sint_pack32", "a2b10g10r10_unorm_pack32", "a2b10g10r10_snorm_pack32", "a2b10g10r10_uscaled_pack32", "a2b10g10r10_sscaled_pack32",
    "a2b10g10r10_uint_pack32", "a2b10g10r10_sint_pack32", "r16_unorm", "r16_snorm", "r16_uscaled", "r16_sscaled", "r16_uint", "r16_sint", "r16_sfloat", "r16g16_unorm",
    "r16g16_snorm", "r16g16_uscaled", "r16g16_sscaled", "r16g16_uint", "r16g16_sint", "r16g16_sfloat", "r16g16b16_unorm", "r16g16b16_snorm", "r16g16b16_uscaled",
    "r16g16b16_sscaled", "r16g16b16_uint", "r16g16b16_sint", "r16g16b16_sfloat", "r16g16b16a16_unorm", "r16g16b16a16_snorm", "r16g16b16a16_uscaled", "r16g16b16a16_sscaled",
    "r16g16b16a16_uint", "r16g16b16a16_sint", "r16g16b16a16_sfloat", "r32_uint", "r32_sint", "r32_sfloat", "r32g32_uint", "r32g32_sint", "r32g32_sfloat", "r32g32b32_uint",
    "r32g32b32_sint", "r32g32b32_sfloat", "r32g32b32a32_uint", "r32g32b32a32_sint", "r32g32b32a32_sfloat", "r64_uint", "r64_sint", "r64_sfloat", "r64g64_uint", "r64g64_sint",
    "r64g64_sfloat", "r64g64b64_uint", "r64g64b64_sint", "r64g64b64_sfloat", "r64g64b64a64_uint", "r64g64b64a64_sint", "r64g64b64a64_sfloat", "b10g11r11_ufloat_pack32",
    "e5b9g9r9_ufloat_pack32", "d16_unorm", "x8_d24_unorm_pack32", "d32_sfloat", "s8_uint", "d16_unorm_s8_uint", "d24_unorm_s8_uint", "d32_sfloat_s8_uint",
    "bc1_rgb_unorm_block", "bc1_rgb_srgb_block", "bc1_rgba_unorm_block", "bc1_rgba_srgb_block", "bc2_unorm_block", "bc2_srgb_block", "bc3_unorm_block", "bc3_srgb_block",
    "bc4_unorm_block", "bc4_snorm_block", "bc5_unorm_block", "bc5_snorm_block", "bc6h_ufloat_block", "bc6h_sfloat_block", "bc7_unorm_block", "bc7_srgb_block",
    "etc2_r8g8b8_unorm_block", "etc2_r8g8b8_srgb_block", "etc2_r8g8b8a1_unorm_block", "etc2_r8g8b8a1_srgb_block", "etc2_r8g8b8a8_unorm_block", "etc2_r8g8b8a8_srgb_block",
    "eac_r11_unorm_block", "eac_r11_snorm_block", "eac_r11g11_unorm_block", "eac_r11g11_snorm_block", "astc_4x4_unorm_block", "astc_4x4_srgb_block", "astc_5x4_unorm_block",
    "astc_5x4_srgb_block", "astc_5x5_unorm_block", "astc_5x5_srgb_block", "astc_6x5_unorm_block", "astc_6x5_srgb_block", "astc_6x6_unorm_block", "astc_6x6_srgb_block",
    "astc_8x5_unorm_block", "astc_8x5_srgb_block", "astc_8x6_unorm_block", "astc_8x6_srgb_block", "astc_8x8_unorm_block", "astc_8x8_srgb_block", "astc_10x5_unorm_block",
    "astc_10x5_srgb_block", "astc_10x6_unorm_block", "astc_10x6_srgb_block", "astc_10x8_unorm_block", "astc_10x8_srgb_block", "astc_10x10_unorm_block",
    "astc_10x10_srgb_block", "astc_12x10_unorm_block", "astc_12x10_srgb_block", "astc_12x12_unorm_block", "astc_12x12_srgb_block",
];

/// `de::toLower(getFormatName(format)).substr(10)`
fn format_name(format: vk::Format) -> &'static str {
    FORMAT_NAMES[format.as_raw() as usize - 1]
}

/// `de::toLower(getFormatName(format))` - the same thing with the `vk_format_` prefix
/// still on, which is how `buffer.invalid_buffer_features` names its cases.
fn full_format_name(format: vk::Format) -> String {
    format!("vk_format_{}", format_name(format))
}

/// `deAlign64`
fn de_align64(val: u64, align: u64) -> u64 {
    debug_assert!(align.is_power_of_two());
    (val.wrapping_add(align - 1)) & !(align - 1)
}

/// The core version an extension was promoted into, for the extensions this file asks
/// about. Kept separate from `vkt::Context`'s own table because that one is shared and
/// this file must not add to it.
fn promoted_to_core_version(extension: &str) -> Option<u32> {
    Some(match extension {
        "VK_KHR_dedicated_allocation" | "VK_KHR_get_memory_requirements2" | "VK_KHR_get_physical_device_properties2" => vk::make_version(1, 1, 0),
        "VK_KHR_maintenance4" | "VK_KHR_format_feature_flags2" | "VK_KHR_dynamic_rendering" => vk::make_version(1, 3, 0),
        "VK_KHR_maintenance5" => vk::make_version(1, 4, 0),
        _ => return None,
    })
}

/// `Context::isDeviceFunctionalitySupported`
fn is_device_functionality_supported(context: &Context<'_>, extension: &str) -> bool {
    if context.get_device_extensions().iter().any(|e| e == extension) {
        return true;
    }
    promoted_to_core_version(extension).is_some_and(|promoted_in| context.get_device_properties().api_version >= promoted_in)
}

/// `Context::requireDeviceFunctionality`
fn require_device_functionality(context: &Context<'_>, extension: &str) -> Result<(), TestError> {
    if is_device_functionality_supported(context, extension) {
        Ok(())
    } else {
        Err(TestError::NotSupported(format!("{extension} is not supported by this implementation")))
    }
}

/// True when the extension is advertised by name, which is what decides whether the
/// `*KHR` entry point can be dispatched. A driver that only exposes the promoted core
/// version has the core entry point and not the KHR alias, and calling the alias would
/// hit vulkanalia's panicking stub.
fn has_device_extension(context: &Context<'_>, extension: &str) -> bool {
    context.get_device_extensions().iter().any(|e| e == extension)
}

/// `vk::findQueueFamilyIndexWithCaps` - the first family whose flags cover `caps`.
fn find_queue_family_index_with_caps(context: &Context<'_>, caps: vk::QueueFlags) -> Option<u32> {
    let families = unsafe { context.get_instance().get_physical_device_queue_family_properties(context.get_physical_device()) };
    families.iter().position(|f| f.queue_flags.contains(caps)).map(|i| i as u32)
}

/// `Context::getSparseQueueFamilyIndex`
fn get_sparse_queue_family_index(context: &Context<'_>) -> u32 {
    if context.get_device_features().sparse_binding == vk::FALSE {
        return 0;
    }
    find_queue_family_index_with_caps(context, vk::QueueFlags::SPARSE_BINDING).unwrap_or(0)
}

/// `Context::getMaintenance4Properties().maxBufferSize`
fn get_max_buffer_size_limit(context: &Context<'_>) -> vk::DeviceSize {
    let mut maintenance4 = vk::PhysicalDeviceMaintenance4Properties::default();
    let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut maintenance4);
    unsafe { context.get_instance().get_physical_device_properties2(context.get_physical_device(), &mut properties2) };
    maintenance4.max_buffer_size
}

/// `vk::getPhysicalDeviceFormatProperties`
fn get_physical_device_format_properties(context: &Context<'_>, format: vk::Format) -> vk::FormatProperties {
    unsafe { context.get_instance().get_physical_device_format_properties(context.get_physical_device(), format) }
}

// =================================================================================
// vktApiBufferTests.cpp
// =================================================================================

#[derive(Clone, Copy, PartialEq, Eq)]
enum AllocationKind {
    Suballocated,
    Dedicated,
}

/// `tcu::PlatformMemoryLimits`
struct PlatformMemoryLimits {
    total_system_memory: u64,
    total_device_local_memory: u64,
}

/// `getPlatformMemoryLimits` - deqp's defaults from `tcu::Platform::getMemoryLimits`.
/// No platform deqp ships for a desktop OS overrides them, and this port has no
/// platform layer at all, so the defaults are what upstream uses here too.
fn get_platform_memory_limits() -> PlatformMemoryLimits {
    PlatformMemoryLimits {
        total_system_memory: 256 * 1024 * 1024,
        total_device_local_memory: 128 * 1024 * 1024,
    }
}

/// `getMaxBufferSize`
fn get_max_buffer_size(buffer_size: vk::DeviceSize, alignment: vk::DeviceSize, limits: &PlatformMemoryLimits) -> vk::DeviceSize {
    if limits.total_device_local_memory == 0 {
        // 'UMA' systems where device memory counts against system memory
        buffer_size.min(limits.total_system_memory - alignment)
    } else {
        // 'LMA' systems where device memory is local to the GPU
        buffer_size.min(limits.total_device_local_memory - alignment)
    }
}

#[derive(Clone, Copy)]
struct BufferCaseParameters {
    usage: vk::BufferUsageFlags,
    flags: vk::BufferCreateFlags,
    sharing_mode: vk::SharingMode,
}

const SPARSE_FLAGS: vk::BufferCreateFlags = vk::BufferCreateFlags::from_bits_truncate(
    vk::BufferCreateFlags::SPARSE_BINDING.bits() | vk::BufferCreateFlags::SPARSE_RESIDENCY.bits() | vk::BufferCreateFlags::SPARSE_ALIASED.bits(),
);

/// `BuffersTestCase`
struct BuffersTestCase {
    name: String,
    test_case: BufferCaseParameters,
}

impl TestCase for BuffersTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, ctx: &Context<'_>) -> Result<(), TestError> {
        let physical_device_features = ctx.get_device_features();

        if self.test_case.flags.contains(vk::BufferCreateFlags::SPARSE_BINDING) && physical_device_features.sparse_binding == vk::FALSE {
            return Err(TestError::NotSupported("Sparse bindings feature is not supported".to_string()));
        }

        if self.test_case.flags.contains(vk::BufferCreateFlags::SPARSE_RESIDENCY) && physical_device_features.sparse_residency_buffer == vk::FALSE {
            return Err(TestError::NotSupported("Sparse buffer residency feature is not supported".to_string()));
        }

        if self.test_case.flags.contains(vk::BufferCreateFlags::SPARSE_ALIASED) && physical_device_features.sparse_residency_aliased == vk::FALSE {
            return Err(TestError::NotSupported("Sparse aliased residency feature is not supported".to_string()));
        }

        // `vkt::Context` here owns one device with one queue, taken from the universal
        // family. Upstream's DefaultDevice also creates a queue on the sparse family,
        // so when the two differ there is no queue this port could bind sparse memory
        // on. The Vulkan spec does not require them to coincide, but every driver seen
        // so far reports SPARSE_BINDING on the universal family as well.
        if self.test_case.flags.intersects(SPARSE_FLAGS) && get_sparse_queue_family_index(ctx) != ctx.get_universal_queue_family_index() {
            return Err(TestError::NotSupported(
                "the sparse-capable queue family is not the universal one, which this port cannot bind sparse memory on".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BufferTestInstance {
            context,
            test_case: self.test_case,
            allocation_kind: AllocationKind::Suballocated,
        })
    }
}

/// `DedicatedAllocationBuffersTestCase`
struct DedicatedAllocationBuffersTestCase {
    name: String,
    test_case: BufferCaseParameters,
}

impl TestCase for DedicatedAllocationBuffersTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, ctx: &Context<'_>) -> Result<(), TestError> {
        if !is_device_functionality_supported(ctx, "VK_KHR_dedicated_allocation") {
            return Err(TestError::NotSupported("Not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BufferTestInstance {
            context,
            test_case: self.test_case,
            allocation_kind: AllocationKind::Dedicated,
        })
    }
}

/// `BufferTestInstance` and `DedicatedAllocationBufferTestInstance` collapsed into one
/// type; upstream separates them only to override `bufferCreateAndAllocTest`, and the
/// two overrides are dispatched on here instead.
struct BufferTestInstance<'a> {
    context: &'a Context<'a>,
    test_case: BufferCaseParameters,
    allocation_kind: AllocationKind,
}

impl BufferTestInstance<'_> {
    /// `BufferTestInstance::bufferCreateAndAllocTest`
    fn buffer_create_and_alloc_test(&self, mut size: vk::DeviceSize) -> TestOutcome {
        let vk_physical_device = self.context.get_physical_device();
        let vk_instance = self.context.get_instance();
        let vk = self.context.get_device();
        let queue_family_index = get_sparse_queue_family_index(self.context);
        let memory_properties = unsafe { vk_instance.get_physical_device_memory_properties(vk_physical_device) };
        let limits = self.context.get_device_properties().limits;
        if self.test_case.flags.contains(vk::BufferCreateFlags::SPARSE_BINDING) {
            size = size.min(limits.sparse_address_space_size);
        }

        // Create a minimal buffer first to get the supported memory types
        let queue_family_indices = [queue_family_index];
        let mut buffer_params = vk::BufferCreateInfo {
            s_type: vk::StructureType::BUFFER_CREATE_INFO,
            next: std::ptr::null(),
            flags: self.test_case.flags,
            size: 1,
            usage: self.test_case.usage,
            sharing_mode: self.test_case.sharing_mode,
            queue_family_index_count: 1,
            queue_family_indices: queue_family_indices.as_ptr(),
        };

        let first_buffer = unsafe { vk.create_buffer(&buffer_params, None) }.vk_check("vkCreateBuffer")?;

        // Declared in upstream's order so the reverse-order drop frees the memory
        // first and destroys the buffer second, exactly as the C++ scope exit does.
        let mut buffer: Option<Unique<'_, vk::Buffer>> = Some(Unique::new(vk, first_buffer));
        let mut memory: Option<Unique<'_, vk::DeviceMemory>> = None;
        let mut mem_reqs = unsafe { vk.get_buffer_memory_requirements(first_buffer) };

        // Create the test buffer and a memory allocation for it
        {
            let heap_type_index = mem_reqs.memory_type_bits.trailing_zeros();
            let memory_type = memory_properties.memory_types[heap_type_index as usize];
            let memory_heap = memory_properties.memory_heaps[memory_type.heap_index as usize];
            let shrink_bits = 4u32; // number of bits to shift when reducing the size with each iteration

            // Buffer size - Choose half of the reported heap size for the maximum buffer size, we
            // should attempt to test as large a portion as possible.
            //
            // However on a system where device memory is shared with the system, the maximum size
            // should be tested against the platform memory limits as significant portion of the heap
            // may already be in use by the operating system and other running processes.
            let available_buffer_size = get_max_buffer_size(memory_heap.size, mem_reqs.alignment, &get_platform_memory_limits());

            // For our test buffer size, halve the maximum available size and align
            let max_buffer_size = de_align64(available_buffer_size >> 1, mem_reqs.alignment);

            size = size.min(max_buffer_size);

            while memory.is_none() {
                // Create the buffer
                {
                    buffer_params.size = size;
                    buffer = None; // free the previous buffer, if any
                    let result = unsafe { vk.create_buffer(&buffer_params, None) };

                    match result {
                        Err(code) => {
                            size = de_align64(size >> shrink_bits, mem_reqs.alignment);

                            if size == 0 || buffer_params.size == mem_reqs.alignment {
                                return Ok(TestStatus::fail(format!("Buffer creation failed! ({code:?})")));
                            }

                            continue; // didn't work, try with a smaller buffer
                        }
                        Ok(raw_buffer) => buffer = Some(Unique::new(vk, raw_buffer)),
                    }
                }

                let current_buffer = **buffer.as_ref().unwrap();
                mem_reqs = unsafe { vk.get_buffer_memory_requirements(current_buffer) }; // get the proper size requirement

                if size > mem_reqs.size {
                    return Ok(TestStatus::fail(format!(
                        "Required memory size ({} bytes) smaller than the buffer's size ({size} bytes)!",
                        mem_reqs.size
                    )));
                }

                // Allocate the memory
                {
                    let mem_alloc = vk::MemoryAllocateInfo::builder().allocation_size(mem_reqs.size).memory_type_index(heap_type_index);

                    match unsafe { vk.allocate_memory(&mem_alloc, None) } {
                        Err(_) => {
                            size = de_align64(size >> shrink_bits, mem_reqs.alignment);

                            if size == 0 || mem_reqs.size == mem_reqs.alignment {
                                return Ok(TestStatus::fail(format!("Unable to allocate {} bytes of memory", mem_reqs.size)));
                            }

                            continue; // didn't work, try with a smaller allocation (and a smaller buffer)
                        }
                        Ok(raw_memory) => memory = Some(Unique::new(vk, raw_memory)),
                    }
                }
            } // while
        }

        let buffer_handle = **buffer.as_ref().unwrap();
        let memory_handle = **memory.as_ref().unwrap();

        // Bind the memory
        if self.test_case.flags.intersects(SPARSE_FLAGS) {
            let queue = self.context.get_universal_queue();

            let sparse_memory_bind = vk::SparseMemoryBind {
                resource_offset: 0,
                size: mem_reqs.size,
                memory: memory_handle,
                memory_offset: 0,
                flags: vk::SparseMemoryBindFlags::empty(),
            };

            let sparse_buffer_memory_bind_info = vk::SparseBufferMemoryBindInfo {
                buffer: buffer_handle,
                bind_count: 1,
                binds: &sparse_memory_bind,
            };

            let bind_sparse_info = vk::BindSparseInfo {
                s_type: vk::StructureType::BIND_SPARSE_INFO,
                next: std::ptr::null(),
                wait_semaphore_count: 0,
                wait_semaphores: std::ptr::null(),
                buffer_bind_count: 1,
                buffer_binds: &sparse_buffer_memory_bind_info,
                image_opaque_bind_count: 0,
                image_opaque_binds: std::ptr::null(),
                image_bind_count: 0,
                image_binds: std::ptr::null(),
                signal_semaphore_count: 0,
                signal_semaphores: std::ptr::null(),
            };

            let fence_info = vk::FenceCreateInfo::builder();
            let fence = unsafe { vk.create_fence(&fence_info, None) }.vk_check("vkCreateFence")?;
            let fence = Unique::new(vk, fence);

            if unsafe { vk.queue_bind_sparse(queue, &[bind_sparse_info], *fence) }.is_err() {
                return Ok(TestStatus::fail(format!("Bind sparse buffer memory failed! (requested memory size: {size})")));
            }

            unsafe { vk.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
        } else if unsafe { vk.bind_buffer_memory(buffer_handle, memory_handle, 0) }.is_err() {
            return Ok(TestStatus::fail(format!("Bind buffer memory failed! (requested memory size: {size})")));
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// `DedicatedAllocationBufferTestInstance::bufferCreateAndAllocTest`
    fn dedicated_buffer_create_and_alloc_test(&self, mut size: vk::DeviceSize) -> TestOutcome {
        let vk_physical_device = self.context.get_physical_device();
        let vk_instance = self.context.get_instance();
        let vk = self.context.get_device();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let memory_properties = unsafe { vk_instance.get_physical_device_memory_properties(vk_physical_device) };
        let limits = self.context.get_device_properties().limits;

        let mut dedicated_requirements = vk::MemoryDedicatedRequirements::default();
        let mut mem_reqs = vk::MemoryRequirements2::builder().push_next(&mut dedicated_requirements).build();

        if self.test_case.flags.contains(vk::BufferCreateFlags::SPARSE_BINDING) {
            size = size.min(limits.sparse_address_space_size);
        }

        // Create a minimal buffer first to get the supported memory types
        let queue_family_indices = [queue_family_index];
        let mut buffer_params = vk::BufferCreateInfo {
            s_type: vk::StructureType::BUFFER_CREATE_INFO,
            next: std::ptr::null(),
            flags: self.test_case.flags,
            size: 1,
            usage: self.test_case.usage,
            sharing_mode: self.test_case.sharing_mode,
            queue_family_index_count: 1,
            queue_family_indices: queue_family_indices.as_ptr(),
        };

        let first_buffer = unsafe { vk.create_buffer(&buffer_params, None) }.vk_check("vkCreateBuffer")?;
        let mut buffer: Option<Unique<'_, vk::Buffer>> = Some(Unique::new(vk, first_buffer));

        let mut info = vk::BufferMemoryRequirementsInfo2::builder().buffer(first_buffer).build();

        unsafe { vk.get_buffer_memory_requirements2(&info, &mut mem_reqs) };

        if dedicated_requirements.requires_dedicated_allocation == vk::TRUE {
            return Ok(TestStatus::fail("Nonexternal objects cannot require dedicated allocation."));
        }

        if mem_reqs.memory_requirements.memory_type_bits == 0 {
            return Ok(TestStatus::fail("memoryTypeBits is 0"));
        }

        let heap_type_index = mem_reqs.memory_requirements.memory_type_bits.trailing_zeros();
        let memory_type = memory_properties.memory_types[heap_type_index as usize];
        let memory_heap = memory_properties.memory_heaps[memory_type.heap_index as usize];
        let shrink_bits = 4u32; // number of bits to shift when reducing the size with each iteration

        let max_buffer_size = get_max_buffer_size(memory_heap.size, mem_reqs.memory_requirements.alignment, &get_platform_memory_limits());

        let mut memory: Option<Unique<'_, vk::DeviceMemory>> = None;
        size = de_align64(size.min(max_buffer_size >> 1), mem_reqs.memory_requirements.alignment);
        while memory.is_none() {
            // Create the buffer
            {
                buffer_params.size = size;
                buffer = None; // free the previous buffer, if any
                let result = unsafe { vk.create_buffer(&buffer_params, None) };

                match result {
                    Err(code) => {
                        size = de_align64(size >> shrink_bits, mem_reqs.memory_requirements.alignment);

                        if size == 0 || buffer_params.size == mem_reqs.memory_requirements.alignment {
                            return Ok(TestStatus::fail(format!("Buffer creation failed! ({code:?})")));
                        }

                        continue; // didn't work, try with a smaller buffer
                    }
                    Ok(raw_buffer) => buffer = Some(Unique::new(vk, raw_buffer)),
                }
            }

            let current_buffer = **buffer.as_ref().unwrap();
            info.buffer = current_buffer;
            unsafe { vk.get_buffer_memory_requirements2(&info, &mut mem_reqs) }; // get the proper size requirement

            if size > mem_reqs.memory_requirements.size {
                return Ok(TestStatus::fail(format!(
                    "Requied memory size ({} bytes) smaller than the buffer's size ({size} bytes)!",
                    mem_reqs.memory_requirements.size
                )));
            }

            // Allocate the memory
            {
                let mut dedicated_info = vk::MemoryDedicatedAllocateInfo::builder().buffer(current_buffer);

                let memory_allocate_info = vk::MemoryAllocateInfo::builder()
                    .allocation_size(mem_reqs.memory_requirements.size)
                    .memory_type_index(heap_type_index)
                    .push_next(&mut dedicated_info);

                match unsafe { vk.allocate_memory(&memory_allocate_info, None) } {
                    Err(_) => {
                        size = de_align64(size >> shrink_bits, mem_reqs.memory_requirements.alignment);

                        if size == 0 || mem_reqs.memory_requirements.size == mem_reqs.memory_requirements.alignment {
                            return Ok(TestStatus::fail(format!("Unable to allocate {} bytes of memory", mem_reqs.memory_requirements.size)));
                        }

                        continue; // didn't work, try with a smaller allocation (and a smaller buffer)
                    }
                    Ok(raw_memory) => memory = Some(Unique::new(vk, raw_memory)),
                }
            }
        } // while

        let buffer_handle = **buffer.as_ref().unwrap();
        let memory_handle = **memory.as_ref().unwrap();

        if unsafe { vk.bind_buffer_memory(buffer_handle, memory_handle, 0) }.is_err() {
            return Ok(TestStatus::fail(format!("Bind buffer memory failed! (requested memory size: {size})")));
        }

        // `memory` is bound to `buffer`; dropping in this order frees the memory before
        // destroying the buffer, which is the order upstream's scope exit uses.
        drop(memory);
        drop(buffer);

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestInstance for BufferTestInstance<'_> {
    /// `BufferTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let test_sizes: [vk::DeviceSize; 5] = [
            1, 1181, 15991, 16384, !0u64, // try to exercise a very large buffer too (will be clamped to a sensible size later)
        ];

        for size in test_sizes {
            let test_status = match self.allocation_kind {
                AllocationKind::Suballocated => self.buffer_create_and_alloc_test(size)?,
                AllocationKind::Dedicated => self.dedicated_buffer_create_and_alloc_test(size)?,
            };

            if test_status.code() != TestResult::Pass {
                return Ok(test_status);
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `getBufferUsageFlagsName`
fn get_buffer_usage_flags_name(flags: vk::BufferUsageFlags) -> &'static str {
    match flags {
        vk::BufferUsageFlags::TRANSFER_SRC => "transfer_src",
        vk::BufferUsageFlags::TRANSFER_DST => "transfer_dst",
        vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER => "uniform_texel",
        vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER => "storage_texel",
        vk::BufferUsageFlags::UNIFORM_BUFFER => "uniform",
        vk::BufferUsageFlags::STORAGE_BUFFER => "storage",
        vk::BufferUsageFlags::INDEX_BUFFER => "index",
        vk::BufferUsageFlags::VERTEX_BUFFER => "vertex",
        vk::BufferUsageFlags::INDIRECT_BUFFER => "indirect",
        _ => unreachable!("Unknown buffer usage flag"),
    }
}

/// `getBufferCreateFlagsName`
fn get_buffer_create_flags_name(flags: vk::BufferCreateFlags) -> String {
    let mut name = String::new();

    if flags.contains(vk::BufferCreateFlags::SPARSE_BINDING) {
        name.push_str("_binding");
    }
    if flags.contains(vk::BufferCreateFlags::SPARSE_RESIDENCY) {
        name.push_str("_residency");
    }
    if flags.contains(vk::BufferCreateFlags::SPARSE_ALIASED) {
        name.push_str("_aliased");
    }
    if flags.is_empty() {
        name.push_str("_zero");
    }

    debug_assert!(!name.is_empty());

    name[1..].to_string()
}

/// `createBufferUsageCases` - creates all VkBufferUsageFlags combinations recursively.
fn create_buffer_usage_cases(test_group: &mut TestCaseGroup, first_ndx: u32, buffer_usage_flags: vk::BufferUsageFlags, allocation_kind: AllocationKind) {
    let buffer_usage_modes = [
        vk::BufferUsageFlags::TRANSFER_SRC,
        vk::BufferUsageFlags::TRANSFER_DST,
        vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER,
        vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER,
        vk::BufferUsageFlags::UNIFORM_BUFFER,
        vk::BufferUsageFlags::STORAGE_BUFFER,
        vk::BufferUsageFlags::INDEX_BUFFER,
        vk::BufferUsageFlags::VERTEX_BUFFER,
        vk::BufferUsageFlags::INDIRECT_BUFFER,
    ];

    // Add test groups
    for current_ndx in first_ndx as usize..buffer_usage_modes.len() {
        let new_buffer_usage_flags = buffer_usage_flags | buffer_usage_modes[current_ndx];
        let new_group_name = get_buffer_usage_flags_name(buffer_usage_modes[current_ndx]);
        let mut new_test_group = TestCaseGroup::new(new_group_name);

        create_buffer_usage_cases(&mut new_test_group, current_ndx as u32 + 1, new_buffer_usage_flags, allocation_kind);
        test_group.add_child(new_test_group);
    }

    // Add test cases
    if !buffer_usage_flags.is_empty() {
        // \note SPARSE_RESIDENCY and SPARSE_ALIASED have to be used together with the SPARSE_BINDING flag.
        let buffer_create_flags = [
            vk::BufferCreateFlags::empty(),
            vk::BufferCreateFlags::SPARSE_BINDING,
            vk::BufferCreateFlags::SPARSE_BINDING | vk::BufferCreateFlags::SPARSE_RESIDENCY,
            vk::BufferCreateFlags::SPARSE_BINDING | vk::BufferCreateFlags::SPARSE_ALIASED,
            vk::BufferCreateFlags::SPARSE_BINDING | vk::BufferCreateFlags::SPARSE_RESIDENCY | vk::BufferCreateFlags::SPARSE_ALIASED,
        ];

        // Dedicated allocation does not support sparse feature
        let num_buffer_create_flags = if allocation_kind == AllocationKind::Suballocated {
            buffer_create_flags.len()
        } else {
            1
        };

        let mut new_test_group = TestCaseGroup::new("create");

        for &flags in &buffer_create_flags[..num_buffer_create_flags] {
            let test_params = BufferCaseParameters {
                usage: buffer_usage_flags,
                flags,
                sharing_mode: vk::SharingMode::EXCLUSIVE,
            };

            let case_name = get_buffer_create_flags_name(flags);

            match allocation_kind {
                AllocationKind::Suballocated => new_test_group.add_child(Box::new(BuffersTestCase {
                    name: case_name,
                    test_case: test_params,
                }) as Box<dyn TestCase>),
                AllocationKind::Dedicated => new_test_group.add_child(Box::new(DedicatedAllocationBuffersTestCase {
                    name: case_name,
                    test_case: test_params,
                }) as Box<dyn TestCase>),
            };
        }
        test_group.add_child(new_test_group);
    }
}

/// `testDepthStencilBufferFeatures`
struct DepthStencilBufferFeaturesCase {
    name: String,
    format: vk::Format,
}

impl TestCase for DepthStencilBufferFeaturesCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DepthStencilBufferFeaturesInstance { context, format: self.format })
    }
}

struct DepthStencilBufferFeaturesInstance<'a> {
    context: &'a Context<'a>,
    format: vk::Format,
}

impl TestInstance for DepthStencilBufferFeaturesInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let format_properties = get_physical_device_format_properties(self.context, self.format);

        if format_properties.buffer_features.is_empty() {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Fail"))
        }
    }
}

/// `LargeBufferParameters`
#[derive(Clone, Copy)]
struct LargeBufferParameters {
    buffer_size: u64,
    use_max_buffer_size: bool,
    flags: vk::BufferCreateFlags,
}

/// `testLargeBuffer` plus its `checkMaintenance4Support`
struct LargeBufferCase {
    name: &'static str,
    params: LargeBufferParameters,
}

impl TestCase for LargeBufferCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `checkMaintenance4Support`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.params.use_max_buffer_size {
            require_device_functionality(context, "VK_KHR_maintenance4")?;
        } else if is_device_functionality_supported(context, "VK_KHR_maintenance4") && self.params.buffer_size > get_max_buffer_size_limit(context) {
            return Err(TestError::NotSupported(
                "vkCreateBuffer with a size larger than maxBufferSize is not valid usage".to_string(),
            ));
        }

        let physical_device_features = context.get_device_features();
        if self.params.flags.contains(vk::BufferCreateFlags::SPARSE_BINDING) && physical_device_features.sparse_binding == vk::FALSE {
            return Err(TestError::NotSupported("Sparse bindings feature is not supported".to_string()));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(LargeBufferInstance { context, params: self.params })
    }
}

struct LargeBufferInstance<'a> {
    context: &'a Context<'a>,
    params: LargeBufferParameters,
}

impl TestInstance for LargeBufferInstance<'_> {
    /// `testLargeBuffer`
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let limits = self.context.get_device_properties().limits;
        let mut params = self.params;

        if params.use_max_buffer_size {
            params.buffer_size = get_max_buffer_size_limit(self.context);
        }

        if params.flags.contains(vk::BufferCreateFlags::SPARSE_BINDING) {
            params.buffer_size = params.buffer_size.min(limits.sparse_address_space_size);
        }

        let queue_family_indices = [queue_family_index];
        let buffer_params = vk::BufferCreateInfo {
            s_type: vk::StructureType::BUFFER_CREATE_INFO,
            next: std::ptr::null(),
            flags: params.flags,
            size: params.buffer_size,
            usage: vk::BufferUsageFlags::STORAGE_BUFFER,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 1,
            queue_family_indices: queue_family_indices.as_ptr(),
        };

        let result = unsafe { vk.create_buffer(&buffer_params, None) };

        // if buffer creation succeeds verify that the correct amount of memory was bound to it
        match result {
            Ok(raw_buffer) => {
                let memory_requirements = unsafe { vk.get_buffer_memory_requirements(raw_buffer) };
                unsafe { vk.destroy_buffer(raw_buffer, None) };

                if memory_requirements.size >= params.buffer_size {
                    return Ok(TestStatus::pass("Pass"));
                }
                Ok(TestStatus::fail("Fail"))
            }
            // check if one of the allowed errors was returned
            Err(code) if code == vk::ErrorCode::OUT_OF_DEVICE_MEMORY || code == vk::ErrorCode::OUT_OF_HOST_MEMORY => Ok(TestStatus::pass("Pass")),
            Err(_) => Ok(TestStatus::fail("Fail")),
        }
    }
}

/// `createBufferTests`
fn create_buffer_tests() -> TestCaseGroup {
    let mut buffers_tests = TestCaseGroup::new("buffer");

    {
        let mut regular_allocation = TestCaseGroup::new("suballocation");
        create_buffer_usage_cases(&mut regular_allocation, 0, vk::BufferUsageFlags::empty(), AllocationKind::Suballocated);
        buffers_tests.add_child(regular_allocation);
    }

    {
        let mut dedicated_allocation = TestCaseGroup::new("dedicated_alloc");
        create_buffer_usage_cases(&mut dedicated_allocation, 0, vk::BufferUsageFlags::empty(), AllocationKind::Dedicated);
        buffers_tests.add_child(dedicated_allocation);
    }

    {
        let mut basic_tests = TestCaseGroup::new("basic");
        // Creating buffer using maxBufferSize limit.
        basic_tests.add_child(Box::new(LargeBufferCase {
            name: "max_size",
            params: LargeBufferParameters {
                buffer_size: 0,
                use_max_buffer_size: true,
                flags: vk::BufferCreateFlags::empty(),
            },
        }) as Box<dyn TestCase>);
        // Creating sparse buffer using maxBufferSize limit.
        basic_tests.add_child(Box::new(LargeBufferCase {
            name: "max_size_sparse",
            params: LargeBufferParameters {
                buffer_size: 0,
                use_max_buffer_size: true,
                flags: vk::BufferCreateFlags::SPARSE_BINDING,
            },
        }) as Box<dyn TestCase>);
        // Creating a ULLONG_MAX buffer and verify that it either succeeds or returns one of the allowed errors.
        basic_tests.add_child(Box::new(LargeBufferCase {
            name: "size_max_uint64",
            params: LargeBufferParameters {
                buffer_size: u64::MAX,
                use_max_buffer_size: false,
                flags: vk::BufferCreateFlags::empty(),
            },
        }) as Box<dyn TestCase>);
        buffers_tests.add_child(basic_tests);
    }

    {
        // Checks that drivers are not exposing undesired format features for depth/stencil formats.
        let mut invalid_buffer_features = TestCaseGroup::new("invalid_buffer_features");

        // `formats::depthAndStencilFormats`
        let depth_and_stencil_formats = [
            vk::Format::D16_UNORM,
            vk::Format::X8_D24_UNORM_PACK32,
            vk::Format::D32_SFLOAT,
            vk::Format::S8_UINT,
            vk::Format::D16_UNORM_S8_UINT,
            vk::Format::D24_UNORM_S8_UINT,
            vk::Format::D32_SFLOAT_S8_UINT,
        ];

        for format in depth_and_stencil_formats {
            invalid_buffer_features.add_child(Box::new(DepthStencilBufferFeaturesCase {
                name: full_format_name(format),
                format,
            }) as Box<dyn TestCase>);
        }

        buffers_tests.add_child(invalid_buffer_features);
    }

    buffers_tests
}

// =================================================================================
// vktApiBufferViewCreateTests.cpp
// =================================================================================

#[derive(Clone, Copy)]
struct BufferViewCaseParameters {
    format: vk::Format,
    offset: vk::DeviceSize,
    range: vk::DeviceSize,
    usage: vk::BufferUsageFlags,
    features: vk::FormatFeatureFlags,
    buffer_allocation_kind: AllocationKind,
}

/// `BufferViewTestCase`
struct BufferViewTestCase {
    name: &'static str,
    test_case: BufferViewCaseParameters,
}

impl TestCase for BufferViewTestCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, ctx: &Context<'_>) -> Result<(), TestError> {
        let properties = get_physical_device_format_properties(ctx, self.test_case.format);

        if !properties.buffer_features.contains(self.test_case.features) {
            return Err(TestError::NotSupported("Format not supported".to_string()));
        }
        if self.test_case.buffer_allocation_kind == AllocationKind::Dedicated {
            require_device_functionality(ctx, "VK_KHR_dedicated_allocation")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BufferViewTestInstance {
            context,
            test_case: self.test_case,
        })
    }
}

struct BufferViewTestInstance<'a> {
    context: &'a Context<'a>,
    test_case: BufferViewCaseParameters,
}

/// `BufferSuballocation::createTestBuffer` and `BufferDedicatedAllocation::createTestBuffer`.
///
/// Upstream returns a `tcu::TestStatus` here and the caller drops it on the floor; this
/// returns the failing status instead, which only changes behaviour in a run that was
/// already going to be reported as broken - and avoids handing a null handle to
/// `vkCreateBufferView` afterwards.
fn create_test_buffer<'a>(
    context: &'a Context<'a>,
    allocation_kind: AllocationKind,
    size: vk::DeviceSize,
    usage: vk::BufferUsageFlags,
) -> Result<Result<(Unique<'a, vk::Buffer>, Unique<'a, vk::DeviceMemory>), TestStatus>, TestError> {
    let vk = context.get_device();
    let queue_family_index = context.get_universal_queue_family_index();

    let queue_family_indices = [queue_family_index];
    let buffer_params = vk::BufferCreateInfo {
        s_type: vk::StructureType::BUFFER_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::BufferCreateFlags::empty(),
        size,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 1,
        queue_family_indices: queue_family_indices.as_ptr(),
    };

    let test_buffer = match unsafe { vk.create_buffer(&buffer_params, None) } {
        Ok(b) => Unique::new(vk, b),
        Err(code) => return Ok(Err(TestStatus::fail(format!("Buffer creation failed! (Error code: {code:?})")))),
    };

    let (allocation_size, memory_type_index, dedicated) = match allocation_kind {
        AllocationKind::Suballocated => {
            let mem_reqs = unsafe { vk.get_buffer_memory_requirements(*test_buffer) };

            if size > mem_reqs.size {
                return Ok(Err(TestStatus::fail(format!(
                    "Required memory size ({} bytes) smaller than the buffer's size ({size} bytes)!",
                    mem_reqs.size
                ))));
            }

            (mem_reqs.size, mem_reqs.memory_type_bits.trailing_zeros(), false)
        }
        AllocationKind::Dedicated => {
            let mut dedicated_requirements = vk::MemoryDedicatedRequirements::default();
            let mut mem_reqs = vk::MemoryRequirements2::builder().push_next(&mut dedicated_requirements).build();
            let info = vk::BufferMemoryRequirementsInfo2::builder().buffer(*test_buffer).build();

            unsafe { vk.get_buffer_memory_requirements2(&info, &mut mem_reqs) };

            if dedicated_requirements.requires_dedicated_allocation == vk::TRUE {
                return Ok(Err(TestStatus::fail("Nonexternal objects cannot require dedicated allocation.")));
            }

            if size > mem_reqs.memory_requirements.size {
                return Ok(Err(TestStatus::fail(format!(
                    "Requied memory size ({} bytes) smaller than the buffer's size ({size} bytes)!",
                    mem_reqs.memory_requirements.size
                ))));
            }

            if mem_reqs.memory_requirements.memory_type_bits == 0 {
                return Ok(Err(TestStatus::fail("memoryTypeBits is 0")));
            }

            (mem_reqs.memory_requirements.size, mem_reqs.memory_requirements.memory_type_bits.trailing_zeros(), true)
        }
    };

    let mut dedicated_info = vk::MemoryDedicatedAllocateInfo::builder().buffer(*test_buffer);
    let mut mem_alloc = vk::MemoryAllocateInfo::builder().allocation_size(allocation_size).memory_type_index(memory_type_index);
    if dedicated {
        mem_alloc = mem_alloc.push_next(&mut dedicated_info);
    }

    let memory = match unsafe { vk.allocate_memory(&mem_alloc, None) } {
        Ok(m) => Unique::new(vk, m),
        Err(code) => return Ok(Err(TestStatus::fail(format!("Alloc memory failed! (Error code: {code:?})")))),
    };

    if unsafe { vk.bind_buffer_memory(*test_buffer, *memory, 0) }.is_err() {
        return Ok(Err(TestStatus::fail("Bind buffer memory failed!")));
    }

    Ok(Ok((test_buffer, memory)))
}

impl TestInstance for BufferViewTestInstance<'_> {
    /// `BufferViewTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let size: vk::DeviceSize = 3 * 5 * 7 * 64;

        // Create buffer
        let (test_buffer, _test_buffer_memory) = match create_test_buffer(self.context, self.test_case.buffer_allocation_kind, size, self.test_case.usage)? {
            Ok(pair) => pair,
            Err(status) => return Ok(status),
        };

        {
            // Create buffer view.
            let buffer_view_create_info = vk::BufferViewCreateInfo::builder()
                .buffer(*test_buffer)
                .format(self.test_case.format)
                .offset(self.test_case.offset)
                .range(self.test_case.range);

            match unsafe { vk.create_buffer_view(&buffer_view_create_info, None) } {
                Ok(raw) => drop(Unique::new(vk, raw)),
                Err(code) => return Ok(TestStatus::fail(format!("Buffer View creation failed! (Error code: {code:?})"))),
            }
        }

        // Testing complete view size.
        {
            let complete_buffer_view_create_info = vk::BufferViewCreateInfo::builder()
                .buffer(*test_buffer)
                .format(self.test_case.format)
                .offset(self.test_case.offset)
                .range(size);

            match unsafe { vk.create_buffer_view(&complete_buffer_view_create_info, None) } {
                Ok(raw) => drop(Unique::new(vk, raw)),
                Err(code) => return Ok(TestStatus::fail(format!("Buffer View creation failed! (Error code: {code:?})"))),
            }
        }

        Ok(TestStatus::pass("BufferView test"))
    }
}

/// `createBufferViewCreateTests`, wrapped in the `buffer_view` group that
/// `createApiTests` puts it under upstream.
fn create_buffer_view_tests() -> TestCaseGroup {
    let range = vk::WHOLE_SIZE;
    let usage = [vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER, vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER];
    let feature = [vk::FormatFeatureFlags::UNIFORM_TEXEL_BUFFER, vk::FormatFeatureFlags::STORAGE_TEXEL_BUFFER];
    let usage_name = ["uniform", "storage"];

    let mut buffer_view_tests = TestCaseGroup::new("create");

    let mut buffer_view_allocation_group_tests = [
        // BufferView Construction Tests for Suballocated Buffer
        TestCaseGroup::new("suballocation"),
        // BufferView Construction Tests for Dedicatedly Allocated Buffer
        TestCaseGroup::new("dedicated_alloc"),
    ];

    for (allocation_kind_ndx, allocation_kind) in [AllocationKind::Suballocated, AllocationKind::Dedicated].into_iter().enumerate() {
        for usage_ndx in 0..usage.len() {
            let mut usage_group = TestCaseGroup::new(usage_name[usage_ndx]);

            for format in vk::Format::UNDEFINED.as_raw() + 1..VK_CORE_FORMAT_LAST {
                let format = vk::Format::from_raw(format);
                let test_name = format_name(format);

                let test_params = BufferViewCaseParameters {
                    format,
                    offset: 0,
                    range,
                    usage: usage[usage_ndx],
                    features: feature[usage_ndx],
                    buffer_allocation_kind: allocation_kind,
                };

                usage_group.add_child(Box::new(BufferViewTestCase {
                    name: test_name,
                    test_case: test_params,
                }) as Box<dyn TestCase>);
            }
            buffer_view_allocation_group_tests[allocation_kind_ndx].add_child(usage_group);
        }
    }

    for group in buffer_view_allocation_group_tests {
        buffer_view_tests.add_child(group);
    }

    let mut buffer_view_group = TestCaseGroup::new("buffer_view");
    buffer_view_group.add_child(buffer_view_tests);

    // `buffer_view.access`: the memory tests, which read the view from a draw or a
    // dispatch, and the all-formats tests, which read it from a compute shader.
    let mut access = TestCaseGroup::new("access");
    super::buffer_view_access_tests::add_buffer_view_memory_tests(&mut access);
    super::buffer_view_access_tests::add_buffer_view_all_formats_tests(&mut access);
    buffer_view_group.add_child(access);
    buffer_view_group
}

// =================================================================================
// vktApiGranularityTests.cpp
// =================================================================================

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestMode {
    NoRenderPass,
    UseRenderPass,
    UseDynamicRenderPass,
}

/// `AttachmentInfo`
#[derive(Clone, Copy)]
struct AttachmentInfo {
    format: vk::Format,
    extent: vk::Extent3D,
}

impl AttachmentInfo {
    fn new(vk_format: vk::Format, width: u32, height: u32, depth: u32) -> Self {
        Self {
            format: vk_format,
            extent: vk::Extent3D { width, height, depth },
        }
    }
}

/// `tcu::hasDepthComponent(mapVkFormat(format).order)` for the core formats the
/// granularity group iterates. Spelled out rather than derived from a texture-format
/// mapping because that mapping is not ported.
fn has_depth_component(format: vk::Format) -> bool {
    format == vk::Format::D16_UNORM
        || format == vk::Format::X8_D24_UNORM_PACK32
        || format == vk::Format::D32_SFLOAT
        || format == vk::Format::D16_UNORM_S8_UINT
        || format == vk::Format::D24_UNORM_S8_UINT
        || format == vk::Format::D32_SFLOAT_S8_UINT
}

/// `tcu::hasStencilComponent(mapVkFormat(format).order)`
fn has_stencil_component(format: vk::Format) -> bool {
    format == vk::Format::S8_UINT || format == vk::Format::D16_UNORM_S8_UINT || format == vk::Format::D24_UNORM_S8_UINT || format == vk::Format::D32_SFLOAT_S8_UINT
}

/// `GranularityCase`
struct GranularityCase {
    name: &'static str,
    attachments: Vec<AttachmentInfo>,
    test_mode: TestMode,
}

impl TestCase for GranularityCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let required_features = vk::FormatFeatureFlags::COLOR_ATTACHMENT | vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT;

        for attachment_info in &self.attachments {
            let format_properties = get_physical_device_format_properties(context, attachment_info.format);
            if (format_properties.optimal_tiling_features & required_features).is_empty() {
                return Err(TestError::NotSupported("Format not supported".to_string()));
            }
        }

        if self.test_mode == TestMode::UseDynamicRenderPass {
            require_device_functionality(context, "VK_KHR_maintenance5")?;
            // iterate() calls vkCmdBeginRendering. Without this the entry point is
            // null on a pre-1.3 driver and vulkanalia's stub aborts the process, which
            // the runner can only report as a crash - a driver simply lacking dynamic
            // rendering must be NotSupported instead.
            require_device_functionality(context, "VK_KHR_dynamic_rendering")?;
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(GranularityInstance {
            context,
            attachments: &self.attachments,
            test_mode: self.test_mode,
        })
    }
}

/// `GranularityInstance`.
///
/// Upstream keeps the images, views, render pass, framebuffer and command buffer as
/// members so that C++ destroys them in reverse declaration order. Here they are
/// locals in `iterate` declared in the same order, which gives the identical teardown
/// sequence - command buffer, pool, framebuffer, render pass, views, images - without
/// the struct-field drop-order trap.
struct GranularityInstance<'a> {
    context: &'a Context<'a>,
    attachments: &'a [AttachmentInfo],
    test_mode: TestMode,
}

impl TestInstance for GranularityInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let vki = self.context.get_instance();
        let physical_device = self.context.get_physical_device();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let render_area = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D { width: 1, height: 1 },
        };

        let mut pre_pass_granularity = vk::Extent2D { width: !0u32, height: !0u32 };
        let mut granularity = vk::Extent2D { width: 0, height: 0 };

        // `initAttachmentDescriptions`
        let mut attachment_descriptions: Vec<vk::AttachmentDescription> = Vec::new();
        for it in self.attachments {
            attachment_descriptions.push(vk::AttachmentDescription {
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: it.format,
                samples: vk::SampleCountFlags::_1,
                load_op: vk::AttachmentLoadOp::DONT_CARE,
                store_op: vk::AttachmentStoreOp::DONT_CARE,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::UNDEFINED,
                final_layout: vk::ImageLayout::GENERAL,
            });
        }

        // `initImages`
        let mem_alloc = SimpleAllocator::new(unsafe { vki.get_physical_device_memory_properties(physical_device) });

        let mut images: Vec<crate::vk::ImageWithMemory<'_>> = Vec::new();
        let mut image_views: Vec<Unique<'_, vk::ImageView>> = Vec::new();

        for it in self.attachments {
            let mut aspect_flags = vk::ImageAspectFlags::empty();
            let mut usage = vk::ImageUsageFlags::empty();

            if has_depth_component(it.format) {
                aspect_flags |= vk::ImageAspectFlags::DEPTH;
                usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
            }

            if has_stencil_component(it.format) {
                aspect_flags |= vk::ImageAspectFlags::STENCIL;
                usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
            }

            if aspect_flags.is_empty() {
                aspect_flags = vk::ImageAspectFlags::COLOR;
                usage = vk::ImageUsageFlags::COLOR_ATTACHMENT;
            }

            let queue_family_indices = [queue_family_index];
            let image_info = vk::ImageCreateInfo {
                s_type: vk::StructureType::IMAGE_CREATE_INFO,
                next: std::ptr::null(),
                flags: vk::ImageCreateFlags::empty(),
                image_type: vk::ImageType::_2D,
                format: it.format,
                extent: it.extent,
                mip_levels: 1,
                array_layers: 1,
                samples: vk::SampleCountFlags::_1,
                tiling: vk::ImageTiling::OPTIMAL,
                usage,
                sharing_mode: vk::SharingMode::EXCLUSIVE,
                queue_family_index_count: 1,
                queue_family_indices: queue_family_indices.as_ptr(),
                initial_layout: vk::ImageLayout::UNDEFINED,
            };

            // Create the image
            let image = crate::vk::ImageWithMemory::new(vk, &mem_alloc, image_info, MemoryRequirement::ANY)?;

            let create_info = vk::ImageViewCreateInfo::builder()
                .image(image.get())
                .view_type(vk::ImageViewType::_2D)
                .format(it.format)
                .components(vk::ComponentMapping {
                    r: vk::ComponentSwizzle::R,
                    g: vk::ComponentSwizzle::G,
                    b: vk::ComponentSwizzle::B,
                    a: vk::ComponentSwizzle::A,
                })
                .subresource_range(vk::ImageSubresourceRange {
                    aspect_mask: aspect_flags,
                    base_mip_level: 0,
                    level_count: 1,
                    base_array_layer: 0,
                    layer_count: 1,
                });

            // Create the Image View
            let image_view = unsafe { vk.create_image_view(&create_info, None) }.vk_check("vkCreateImageView")?;

            images.push(image);
            image_views.push(Unique::new(vk, image_view));
        }

        // `initObjects` - Create RenderPass and Framebuffer
        let mut render_pass: Option<Unique<'_, vk::RenderPass>> = None;
        let mut frame_buffer: Option<Unique<'_, vk::Framebuffer>> = None;

        if self.test_mode != TestMode::UseDynamicRenderPass {
            let subpass_desc = vk::SubpassDescription::builder().pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS);
            let subpasses = [subpass_desc];

            let render_pass_params = vk::RenderPassCreateInfo::builder().attachments(&attachment_descriptions).subpasses(&subpasses);

            let raw_render_pass = unsafe { vk.create_render_pass(&render_pass_params, None) }.vk_check("vkCreateRenderPass")?;
            render_pass = Some(Unique::new(vk, raw_render_pass));

            let raw_image_views: Vec<vk::ImageView> = image_views.iter().map(|v| **v).collect();

            let framebuffer_params = vk::FramebufferCreateInfo::builder()
                .render_pass(raw_render_pass)
                .attachments(&raw_image_views)
                .width(1)
                .height(1)
                .layers(1);

            let raw_framebuffer = unsafe { vk.create_framebuffer(&framebuffer_params, None) }.vk_check("vkCreateFramebuffer")?;
            frame_buffer = Some(Unique::new(vk, raw_framebuffer));
        }

        let cmd_pool = make_command_pool(vk, queue_family_index)?;

        // Create CommandBuffer
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let begin_info = vk::CommandBufferBeginInfo::builder();
        unsafe { vk.begin_command_buffer(*cmd_buffer, &begin_info) }.vk_check("vkBeginCommandBuffer")?;

        if self.test_mode == TestMode::UseDynamicRenderPass {
            let mut subresource_range = vk::ImageSubresourceRange {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                base_mip_level: 0,
                level_count: 1,
                base_array_layer: 0,
                layer_count: 1,
            };
            let mut color_attachment_formats: Vec<vk::Format> = Vec::new();
            let mut depth_attachment_format = vk::Format::UNDEFINED;
            let mut stencil_attachment_format = vk::Format::UNDEFINED;

            let default_attachment = vk::RenderingAttachmentInfo {
                image_layout: vk::ImageLayout::GENERAL,
                load_op: vk::AttachmentLoadOp::DONT_CARE,
                store_op: vk::AttachmentStoreOp::DONT_CARE,
                ..vk::RenderingAttachmentInfo::default()
            };

            let mut color_attachment_info: Vec<vk::RenderingAttachmentInfo> = Vec::new();
            let mut depth_attachment_info = default_attachment;
            let mut stencil_attachment_info = default_attachment;

            for i in 0..self.attachments.len() {
                let format = self.attachments[i].format;
                let mut is_color_format = true;

                subresource_range.aspect_mask = vk::ImageAspectFlags::empty();

                if has_depth_component(format) {
                    subresource_range.aspect_mask = vk::ImageAspectFlags::DEPTH;
                    depth_attachment_format = format;
                    depth_attachment_info.image_view = *image_views[i];
                    is_color_format = false;
                }
                if has_stencil_component(format) {
                    subresource_range.aspect_mask |= vk::ImageAspectFlags::STENCIL;
                    stencil_attachment_format = format;
                    stencil_attachment_info.image_view = *image_views[i];
                    is_color_format = false;
                }
                if is_color_format {
                    subresource_range.aspect_mask = vk::ImageAspectFlags::COLOR;
                    color_attachment_formats.push(format);
                    color_attachment_info.push(default_attachment);
                    color_attachment_info.last_mut().unwrap().image_view = *image_views[i];
                }

                // transition layout
                let layout_barrier = crate::vk::image_util::make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::SHADER_READ,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    images[i].get(),
                    subresource_range,
                );
                unsafe {
                    vk.cmd_pipeline_barrier(
                        *cmd_buffer,
                        vk::PipelineStageFlags::HOST,
                        vk::PipelineStageFlags::FRAGMENT_SHADER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[layout_barrier],
                    );
                }
            }

            let rendering_area_info = vk::RenderingAreaInfo {
                s_type: vk::StructureType::RENDERING_AREA_INFO,
                next: std::ptr::null(),
                view_mask: 0,
                color_attachment_count: color_attachment_formats.len() as u32,
                color_attachment_formats: color_attachment_formats.as_ptr(),
                depth_attachment_format,
                stencil_attachment_format,
            };

            pre_pass_granularity = get_rendering_area_granularity(self.context, &rendering_area_info);

            // start dynamic render pass
            let rendering_info = vk::RenderingInfo {
                s_type: vk::StructureType::RENDERING_INFO,
                next: std::ptr::null(),
                flags: vk::RenderingFlags::empty(),
                render_area,
                layer_count: 1,
                view_mask: 0,
                color_attachment_count: color_attachment_info.len() as u32,
                color_attachments: color_attachment_info.as_ptr(),
                depth_attachment: if depth_attachment_format != vk::Format::UNDEFINED {
                    &depth_attachment_info
                } else {
                    std::ptr::null()
                },
                stencil_attachment: if stencil_attachment_format != vk::Format::UNDEFINED {
                    &stencil_attachment_info
                } else {
                    std::ptr::null()
                },
            };
            unsafe { vk.cmd_begin_rendering(*cmd_buffer, &rendering_info) };

            granularity = get_rendering_area_granularity(self.context, &rendering_area_info);
        }

        if self.test_mode != TestMode::UseDynamicRenderPass {
            let raw_render_pass = **render_pass.as_ref().unwrap();
            pre_pass_granularity = unsafe { vk.get_render_area_granularity(raw_render_pass) };

            if self.test_mode == TestMode::UseRenderPass {
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(raw_render_pass)
                    .framebuffer(**frame_buffer.as_ref().unwrap())
                    .render_area(render_area);
                unsafe { vk.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE) };
            }

            granularity = unsafe { vk.get_render_area_granularity(raw_render_pass) };
        }

        if !(granularity.width >= 1 && granularity.height >= 1) {
            return Ok(TestStatus::fail("granularity.width >= 1 && granularity.height >= 1"));
        }
        if !(pre_pass_granularity.width == granularity.width && pre_pass_granularity.height == granularity.height) {
            return Ok(TestStatus::fail(
                "prePassGranularity.width == granularity.width && prePassGranularity.height == granularity.height",
            ));
        }
        let limits = self.context.get_device_properties().limits;
        if !(granularity.width <= limits.max_framebuffer_width && granularity.height <= limits.max_framebuffer_height) {
            return Ok(TestStatus::fail("granularity.width <= maxFramebufferWidth && granularity.height <= maxFramebufferHeight"));
        }

        if self.test_mode == TestMode::UseRenderPass {
            unsafe { vk.cmd_end_render_pass(*cmd_buffer) };
        }

        if self.test_mode == TestMode::UseDynamicRenderPass {
            unsafe { vk.cmd_end_rendering(*cmd_buffer) };
        }

        unsafe { vk.end_command_buffer(*cmd_buffer) }.vk_check("vkEndCommandBuffer")?;

        log::info!("Horizontal granularity: {} Vertical granularity: {}", granularity.width, granularity.height);
        Ok(TestStatus::pass("Granularity test"))
    }
}

/// `vkGetRenderingAreaGranularity`.
///
/// The KHR alias only exists when the extension is advertised by name; a driver that
/// only exposes the promoted Vulkan 1.4 entry point has the core one instead, and
/// dispatching the missing alias would hit vulkanalia's panicking stub.
fn get_rendering_area_granularity(context: &Context<'_>, info: &vk::RenderingAreaInfo) -> vk::Extent2D {
    let vk = context.get_device();
    if has_device_extension(context, "VK_KHR_maintenance5") {
        unsafe { vk.get_rendering_area_granularity_khr(info) }
    } else {
        unsafe { vk.get_rendering_area_granularity(info) }
    }
}

/// `createGranularityQueryTests`
fn create_granularity_query_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("granularity");
    // Subgroups
    // Single texture granularity tests.
    let mut single = TestCaseGroup::new("single");
    // Multiple textures with same format granularity tests.
    let mut multi = TestCaseGroup::new("multi");
    let mut random = TestCaseGroup::new("random");
    let mut in_render_pass = TestCaseGroup::new("in_render_pass");
    let mut in_dynamic_render_pass = TestCaseGroup::new("in_dynamic_render_pass");

    let mut rnd = Random::new(215);

    let mandatory_formats = [
        vk::Format::B4G4R4A4_UNORM_PACK16,
        vk::Format::R5G6B5_UNORM_PACK16,
        vk::Format::A1R5G5B5_UNORM_PACK16,
        vk::Format::R8_UNORM,
        vk::Format::R8_SNORM,
        vk::Format::R8_UINT,
        vk::Format::R8_SINT,
        vk::Format::R8G8_UNORM,
        vk::Format::R8G8_SNORM,
        vk::Format::R8G8_UINT,
        vk::Format::R8G8_SINT,
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R8G8B8A8_SNORM,
        vk::Format::R8G8B8A8_UINT,
        vk::Format::R8G8B8A8_SINT,
        vk::Format::R8G8B8A8_SRGB,
        vk::Format::B8G8R8A8_UNORM,
        vk::Format::B8G8R8A8_SRGB,
        vk::Format::A8B8G8R8_UNORM_PACK32,
        vk::Format::A8B8G8R8_SNORM_PACK32,
        vk::Format::A8B8G8R8_UINT_PACK32,
        vk::Format::A8B8G8R8_SINT_PACK32,
        vk::Format::A8B8G8R8_SRGB_PACK32,
        vk::Format::A2B10G10R10_UNORM_PACK32,
        vk::Format::A2B10G10R10_UINT_PACK32,
        vk::Format::R16_UINT,
        vk::Format::R16_SINT,
        vk::Format::R16_SFLOAT,
        vk::Format::R16G16_UINT,
        vk::Format::R16G16_SINT,
        vk::Format::R16G16_SFLOAT,
        vk::Format::R16G16B16A16_UINT,
        vk::Format::R16G16B16A16_SINT,
        vk::Format::R16G16B16A16_SFLOAT,
        vk::Format::R32_UINT,
        vk::Format::R32_SINT,
        vk::Format::R32_SFLOAT,
        vk::Format::R32G32_UINT,
        vk::Format::R32G32_SINT,
        vk::Format::R32G32_SFLOAT,
        vk::Format::R32G32B32A32_UINT,
        vk::Format::R32G32B32A32_SINT,
        vk::Format::R32G32B32A32_SFLOAT,
        vk::Format::B10G11R11_UFLOAT_PACK32,
        vk::Format::E5B9G9R9_UFLOAT_PACK32,
        vk::Format::D16_UNORM,
        vk::Format::D32_SFLOAT,
    ];

    let max_dimension = 500;
    let min_iteration = 2;
    let max_iteration = 10;

    for format_idx in 1..=vk::Format::D32_SFLOAT_S8_UINT.as_raw() {
        let format = vk::Format::from_raw(format_idx);
        let name = format_name(format);

        {
            let mut attachments = Vec::new();
            let i0 = rnd.get_int(1, max_dimension);
            let i1 = rnd.get_int(1, max_dimension);
            attachments.push(AttachmentInfo::new(format, i0 as u32, i1 as u32, 1));
            single.add_child(Box::new(GranularityCase {
                name,
                attachments,
                test_mode: TestMode::NoRenderPass,
            }) as Box<dyn TestCase>);
        }

        {
            let mut attachments = Vec::new();
            let iterations = rnd.get_int(min_iteration, max_iteration);
            let i0 = rnd.get_int(1, max_dimension);
            let i1 = rnd.get_int(1, max_dimension);
            for _ in 0..iterations {
                attachments.push(AttachmentInfo::new(format, i0 as u32, i1 as u32, 1));
            }
            multi.add_child(Box::new(GranularityCase {
                name,
                attachments,
                test_mode: TestMode::NoRenderPass,
            }) as Box<dyn TestCase>);
        }

        {
            let mut attachments = Vec::new();
            let iterations = rnd.get_int(min_iteration, max_iteration);
            let i0 = rnd.get_int(1, max_dimension);
            let i1 = rnd.get_int(1, max_dimension);
            attachments.push(AttachmentInfo::new(format, i0 as u32, i1 as u32, 1));
            for _ in 0..iterations {
                let i2 = rnd.get_int(0, mandatory_formats.len() as i32 - 1);
                let i3 = rnd.get_int(1, max_dimension);
                let i4 = rnd.get_int(1, max_dimension);
                attachments.push(AttachmentInfo::new(mandatory_formats[i2 as usize], i3 as u32, i4 as u32, 1));
            }
            random.add_child(Box::new(GranularityCase {
                name,
                attachments,
                test_mode: TestMode::NoRenderPass,
            }) as Box<dyn TestCase>);
        }

        {
            let i0 = rnd.get_int(1, max_dimension);
            let i1 = rnd.get_int(1, max_dimension);
            let attachments = vec![AttachmentInfo::new(format, i0 as u32, i1 as u32, 1)];
            in_render_pass.add_child(Box::new(GranularityCase {
                name,
                attachments: attachments.clone(),
                test_mode: TestMode::UseRenderPass,
            }) as Box<dyn TestCase>);

            in_dynamic_render_pass.add_child(Box::new(GranularityCase {
                name,
                attachments,
                test_mode: TestMode::UseDynamicRenderPass,
            }) as Box<dyn TestCase>);
        }
    }

    group.add_child(single);
    group.add_child(multi);
    group.add_child(random);
    group.add_child(in_render_pass);
    group.add_child(in_dynamic_render_pass);

    group
}

// =================================================================================
// vktApiFormatPropertiesExtendedKHRtests.cpp
// =================================================================================

/// `VkFormatProperties4KHR`. vulkanalia does not know `VK_KHR_extended_flags` yet, so
/// the struct is declared here; only its size and sType matter, since the test chains
/// it in and reads the `VkFormatProperties3` it hangs off.
#[repr(C)]
#[derive(Clone, Copy)]
struct FormatProperties4KHR {
    s_type: vk::StructureType,
    next: *mut std::ffi::c_void,
    linear_tiling_features: u64,
    optimal_tiling_features: u64,
    buffer_features: u64,
}

const STRUCTURE_TYPE_FORMAT_PROPERTIES_4_KHR: i32 = 1_000_668_000;
const VK_KHR_EXTENDED_FLAGS_EXTENSION_NAME: &str = "VK_KHR_extended_flags";

/// `isSpirvCompatibleFormat`
fn is_spirv_compatible_format(format: vk::Format) -> bool {
    // These formats can be explicitly expressed in SPIR-V.
    const SPIRV_COMPATIBLE: [vk::Format; 41] = [
        vk::Format::R32G32B32A32_SFLOAT,
        vk::Format::R32G32_SFLOAT,
        vk::Format::R32_SFLOAT,
        vk::Format::R16G16B16A16_SFLOAT,
        vk::Format::R16G16_SFLOAT,
        vk::Format::R16_SFLOAT,
        vk::Format::R16G16B16A16_UNORM,
        vk::Format::R16G16_UNORM,
        vk::Format::R16_UNORM,
        vk::Format::R16G16B16A16_SNORM,
        vk::Format::R16G16_SNORM,
        vk::Format::R16_SNORM,
        vk::Format::A2B10G10R10_UNORM_PACK32,
        vk::Format::B10G11R11_UFLOAT_PACK32,
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R8G8_UNORM,
        vk::Format::R8_UNORM,
        vk::Format::R8G8B8A8_SNORM,
        vk::Format::R8G8_SNORM,
        vk::Format::R8_SNORM,
        vk::Format::R32G32B32A32_SINT,
        vk::Format::R32G32_SINT,
        vk::Format::R32_SINT,
        vk::Format::R16G16B16A16_SINT,
        vk::Format::R16G16_SINT,
        vk::Format::R16_SINT,
        vk::Format::R8G8B8A8_SINT,
        vk::Format::R8G8_SINT,
        vk::Format::R8_SINT,
        vk::Format::R32G32B32A32_UINT,
        vk::Format::R32G32_UINT,
        vk::Format::R32_UINT,
        vk::Format::R16G16B16A16_UINT,
        vk::Format::R16G16_UINT,
        vk::Format::R16_UINT,
        vk::Format::A2B10G10R10_UINT_PACK32,
        vk::Format::R8G8B8A8_UINT,
        vk::Format::R8G8_UINT,
        vk::Format::R8_UINT,
        vk::Format::R64_SINT,
        vk::Format::R64_UINT,
    ];
    SPIRV_COMPATIBLE.contains(&format)
}

/// `isExtendedStorageFormat`
fn is_extended_storage_format(format: vk::Format) -> bool {
    const EXTENDED_STORAGE: [vk::Format; 39] = [
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R8G8B8A8_SNORM,
        vk::Format::R8G8B8A8_UINT,
        vk::Format::R8G8B8A8_SINT,
        vk::Format::R32_UINT,
        vk::Format::R32_SINT,
        vk::Format::R32_SFLOAT,
        vk::Format::R32G32_UINT,
        vk::Format::R32G32_SINT,
        vk::Format::R32G32_SFLOAT,
        vk::Format::R32G32B32A32_UINT,
        vk::Format::R32G32B32A32_SINT,
        vk::Format::R32G32B32A32_SFLOAT,
        vk::Format::R16G16B16A16_UINT,
        vk::Format::R16G16B16A16_SINT,
        vk::Format::R16G16B16A16_SFLOAT,
        vk::Format::R16G16_SFLOAT,
        vk::Format::B10G11R11_UFLOAT_PACK32,
        vk::Format::R16_SFLOAT,
        vk::Format::R16G16B16A16_UNORM,
        vk::Format::A2B10G10R10_UNORM_PACK32,
        vk::Format::R16G16_UNORM,
        vk::Format::R8G8_UNORM,
        vk::Format::R16_UNORM,
        vk::Format::R8_UNORM,
        vk::Format::R16G16B16A16_SNORM,
        vk::Format::R16G16_SNORM,
        vk::Format::R8G8_SNORM,
        vk::Format::R16_SNORM,
        vk::Format::R8_SNORM,
        vk::Format::R16G16_SINT,
        vk::Format::R8G8_SINT,
        vk::Format::R16_SINT,
        vk::Format::R8_SINT,
        vk::Format::A2B10G10R10_UINT_PACK32,
        vk::Format::R16G16_UINT,
        vk::Format::R8G8_UINT,
        vk::Format::R16_UINT,
        vk::Format::R8_UINT,
    ];
    EXTENDED_STORAGE.contains(&format)
}

/// `isDepthFormat`
fn is_depth_format(format: vk::Format) -> bool {
    has_depth_component(format)
}

/// `Context::getRequiredFormatProperties`
fn get_required_format_properties(context: &Context<'_>, format: vk::Format) -> vk::FormatProperties3 {
    let mut p = vk::FormatProperties3::default();

    let properties = get_physical_device_format_properties(context, format);
    p.linear_tiling_features = vk::FormatFeatureFlags2::from_bits_truncate(properties.linear_tiling_features.bits() as u64);
    p.optimal_tiling_features = vk::FormatFeatureFlags2::from_bits_truncate(properties.optimal_tiling_features.bits() as u64);
    p.buffer_features = vk::FormatFeatureFlags2::from_bits_truncate(properties.buffer_features.bits() as u64);

    let features_available = context.get_device_features();
    if is_extended_storage_format(format) && features_available.shader_storage_image_read_without_format != vk::FALSE {
        if p.linear_tiling_features.contains(vk::FormatFeatureFlags2::STORAGE_IMAGE) {
            p.linear_tiling_features |= vk::FormatFeatureFlags2::STORAGE_READ_WITHOUT_FORMAT;
        }
        if p.optimal_tiling_features.contains(vk::FormatFeatureFlags2::STORAGE_IMAGE) {
            p.optimal_tiling_features |= vk::FormatFeatureFlags2::STORAGE_READ_WITHOUT_FORMAT;
        }
    }
    if is_extended_storage_format(format) && features_available.shader_storage_image_write_without_format != vk::FALSE {
        if p.linear_tiling_features.contains(vk::FormatFeatureFlags2::STORAGE_IMAGE) {
            p.linear_tiling_features |= vk::FormatFeatureFlags2::STORAGE_WRITE_WITHOUT_FORMAT;
        }
        if p.optimal_tiling_features.contains(vk::FormatFeatureFlags2::STORAGE_IMAGE) {
            p.optimal_tiling_features |= vk::FormatFeatureFlags2::STORAGE_WRITE_WITHOUT_FORMAT;
        }
    }
    // If an implementation exposes storage image/buffer feature on formats not in the SPIR-V compatibility table,
    // the implementation must at least expose one of the WITHOUT_FORMAT (either READ or WRITE) storage features.
    if !is_spirv_compatible_format(format) {
        if p.linear_tiling_features
            .intersects(vk::FormatFeatureFlags2::STORAGE_READ_WITHOUT_FORMAT | vk::FormatFeatureFlags2::STORAGE_WRITE_WITHOUT_FORMAT)
        {
            p.linear_tiling_features |= vk::FormatFeatureFlags2::STORAGE_IMAGE;
        }
        if p.optimal_tiling_features
            .intersects(vk::FormatFeatureFlags2::STORAGE_READ_WITHOUT_FORMAT | vk::FormatFeatureFlags2::STORAGE_WRITE_WITHOUT_FORMAT)
        {
            p.optimal_tiling_features |= vk::FormatFeatureFlags2::STORAGE_IMAGE;
        }
        if p.buffer_features
            .intersects(vk::FormatFeatureFlags2::STORAGE_READ_WITHOUT_FORMAT | vk::FormatFeatureFlags2::STORAGE_WRITE_WITHOUT_FORMAT)
        {
            p.buffer_features |= vk::FormatFeatureFlags2::STORAGE_TEXEL_BUFFER;
        }
    }
    if is_depth_format(format) && p.linear_tiling_features.contains(vk::FormatFeatureFlags2::SAMPLED_IMAGE) {
        p.linear_tiling_features |= vk::FormatFeatureFlags2::SAMPLED_IMAGE_DEPTH_COMPARISON;
    }
    if is_depth_format(format) && p.optimal_tiling_features.contains(vk::FormatFeatureFlags2::SAMPLED_IMAGE) {
        p.optimal_tiling_features |= vk::FormatFeatureFlags2::SAMPLED_IMAGE_DEPTH_COMPARISON;
    }

    p
}

/// `Context::getFormatProperties`
fn get_format_properties(context: &Context<'_>, format: vk::Format) -> vk::FormatProperties3 {
    if is_device_functionality_supported(context, "VK_KHR_format_feature_flags2") {
        let mut p = vk::FormatProperties3::default();
        let mut properties = vk::FormatProperties2::builder().push_next(&mut p).build();

        unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties2(context.get_physical_device(), format, &mut properties)
        };
        p
    } else {
        get_required_format_properties(context, format)
    }
}

/// `checkFlags`
fn check_flags(reported_flags: vk::FormatFeatureFlags2, requested_flags: vk::FormatFeatureFlags2, set_name: &str) -> Result<(), String> {
    let and_mask = reported_flags & requested_flags;
    if and_mask != requested_flags {
        // Find which bits are missing.
        let missing_bits = and_mask ^ requested_flags;
        return Err(format!("{set_name}: missing flags 0x{:016x}", missing_bits.bits()));
    }
    Ok(())
}

/// `TestParams`
#[derive(Clone, Copy)]
struct FormatFeaturesTestParams {
    format: vk::Format,
    extended_flags: bool,
}

struct FormatFeaturesCase {
    name: &'static str,
    params: FormatFeaturesTestParams,
}

impl TestCase for FormatFeaturesCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        require_device_functionality(context, "VK_KHR_format_feature_flags2")?;
        // `requireInstanceFunctionality(VK_KHR_get_physical_device_properties2)`: this
        // port always creates a Vulkan 1.1 instance, where that extension is core.
        if self.params.extended_flags {
            require_device_functionality(context, VK_KHR_EXTENDED_FLAGS_EXTENSION_NAME)?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FormatFeaturesInstance { context, params: self.params })
    }
}

struct FormatFeaturesInstance<'a> {
    context: &'a Context<'a>,
    params: FormatFeaturesTestParams,
}

impl TestInstance for FormatFeaturesInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let required_properties = get_required_format_properties(self.context, self.params.format);
        let format_properties = if !self.params.extended_flags {
            get_format_properties(self.context, self.params.format)
        } else {
            let mut properties4 = FormatProperties4KHR {
                s_type: vk::StructureType::from_raw(STRUCTURE_TYPE_FORMAT_PROPERTIES_4_KHR),
                next: std::ptr::null_mut(),
                linear_tiling_features: 0,
                optimal_tiling_features: 0,
                buffer_features: 0,
            };

            let mut format_properties = vk::FormatProperties3 {
                s_type: vk::StructureType::FORMAT_PROPERTIES_3,
                next: std::ptr::addr_of_mut!(properties4).cast(),
                ..vk::FormatProperties3::default()
            };

            let mut properties = vk::FormatProperties2 {
                s_type: vk::StructureType::FORMAT_PROPERTIES_2,
                next: std::ptr::addr_of_mut!(format_properties).cast(),
                ..vk::FormatProperties2::default()
            };

            unsafe {
                self.context
                    .get_instance()
                    .get_physical_device_format_properties2(self.context.get_physical_device(), self.params.format, &mut properties)
            };

            // `properties4` dies with this block; unlink it so the value that escapes
            // carries no dangling pointer.
            format_properties.next = std::ptr::null_mut();
            format_properties
        };

        if let Err(msg) = check_flags(format_properties.buffer_features, required_properties.buffer_features, "Buffer features") {
            return Ok(TestStatus::fail(msg));
        }
        if let Err(msg) = check_flags(
            format_properties.linear_tiling_features,
            required_properties.linear_tiling_features,
            "Linear tiling features",
        ) {
            return Ok(TestStatus::fail(msg));
        }
        if let Err(msg) = check_flags(
            format_properties.optimal_tiling_features,
            required_properties.optimal_tiling_features,
            "Optimal tiling features",
        ) {
            return Ok(TestStatus::fail(msg));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createTestCases`
fn create_format_features_test_cases(group: &mut TestCaseGroup, extended_flags: bool) {
    for format in vk::Format::R4G4_UNORM_PACK8.as_raw()..VK_CORE_FORMAT_LAST {
        let format = vk::Format::from_raw(format);
        let test_name = format_name(format);

        let params = FormatFeaturesTestParams { format, extended_flags };

        group.add_child(Box::new(FormatFeaturesCase { name: test_name, params }) as Box<dyn TestCase>);
    }
}

/// `createFormatPropertiesExtendedKHRTests`
fn create_format_properties_extended_khr_tests() -> TestCaseGroup {
    let mut format_features_test_group = TestCaseGroup::new("format_features");

    let mut format_feature_flags2_test_group = TestCaseGroup::new("format_feature_flags2");
    create_format_features_test_cases(&mut format_feature_flags2_test_group, false);

    let mut extended_flags_test_group = TestCaseGroup::new("extended_flags");
    create_format_features_test_cases(&mut extended_flags_test_group, true);

    format_features_test_group.add_child(format_feature_flags2_test_group);
    format_features_test_group.add_child(extended_flags_test_group);

    format_features_test_group
}

// =================================================================================
// Entry point
// =================================================================================

/// One group per `dEQP-VK.api.*` sub-group ported in this file, in the order
/// `createApiTests` registers them upstream.
pub fn create_object_groups() -> Vec<TestCaseGroup> {
    vec![
        create_buffer_tests(),
        create_buffer_view_tests(),
        create_granularity_query_tests(),
        create_format_properties_extended_khr_tests(),
    ]
}
