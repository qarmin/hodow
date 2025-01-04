// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory/vktMemoryRequirementsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The image and multiplane_image halves are in requirements_image_tests.rs.
//
// Upstream's `IBufferMemoryRequirements` class hierarchy (Original -> Extended ->
// DedicatedAllocation, Original -> CreateInfo) is one struct with a `Variant` here; each
// virtual call is a `match` on it that keeps the same layering (DedicatedAllocation's
// verify runs Extended's, which is Original's).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, DeviceV1_3, KhrMaintenance4ExtensionDeviceCommands};

use super::requirements_image_tests::{ImageVariant, populate_image_test_group, populate_multiplane_test_group};
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `makeBuffer`
fn make_buffer(
    vk: &Device,
    size: vk::DeviceSize,
    flags: vk::BufferCreateFlags,
    usage: vk::BufferUsageFlags,
) -> Result<Unique<'_, vk::Buffer>, TestError> {
    let create_info = vk::BufferCreateInfo {
        s_type: vk::StructureType::BUFFER_CREATE_INFO,
        next: std::ptr::null(),
        flags,
        size,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
    };
    let buffer = unsafe { vk.create_buffer(&create_info, None) }.vk_check("vkCreateBuffer")?;
    Ok(Unique::new(vk, buffer))
}

/// `getBufferMemoryRequirements(vk, device, size, flags, usage)`
fn get_buffer_memory_requirements(
    vk: &Device,
    size: vk::DeviceSize,
    flags: vk::BufferCreateFlags,
    usage: vk::BufferUsageFlags,
) -> Result<vk::MemoryRequirements, TestError> {
    let buffer = make_buffer(vk, size, flags, usage)?;
    Ok(unsafe { vk.get_buffer_memory_requirements(*buffer) })
}

/// `getBufferMemoryRequirements2`
fn get_buffer_memory_requirements2(
    vk: &Device,
    size: vk::DeviceSize,
    flags: vk::BufferCreateFlags,
    usage: vk::BufferUsageFlags,
    next: Option<&mut vk::MemoryDedicatedRequirements>,
) -> Result<vk::MemoryRequirements, TestError> {
    let buffer = make_buffer(vk, size, flags, usage)?;
    let info = vk::BufferMemoryRequirementsInfo2 {
        s_type: vk::StructureType::BUFFER_MEMORY_REQUIREMENTS_INFO_2,
        next: std::ptr::null(),
        buffer: *buffer,
    };
    let mut req2 = vk::MemoryRequirements2::default();
    if let Some(next) = next {
        req2.next = (next as *mut vk::MemoryDedicatedRequirements).cast();
    }

    unsafe { vk.get_buffer_memory_requirements2(&info, &mut req2) };

    Ok(req2.memory_requirements)
}

/// `getBufferCreateInfoMemoryRequirementsKHR`
///
/// Upstream's `DeviceInterface` resolves `getDeviceBufferMemoryRequirements` from core 1.3 or
/// from the extension, whichever the device has; here that choice is made by hand.
fn get_buffer_create_info_memory_requirements_khr(
    context: &Context<'_>,
    size: vk::DeviceSize,
    flags: vk::BufferCreateFlags,
    usage: vk::BufferUsageFlags,
) -> Result<vk::MemoryRequirements, TestError> {
    let vk = context.get_device();
    let create_info = vk::BufferCreateInfo {
        s_type: vk::StructureType::BUFFER_CREATE_INFO,
        next: std::ptr::null(),
        flags,
        size,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
    };
    let memory_info = vk::DeviceBufferMemoryRequirements {
        s_type: vk::StructureType::DEVICE_BUFFER_MEMORY_REQUIREMENTS,
        next: std::ptr::null(),
        create_info: &create_info,
    };
    let mut req2 = vk::MemoryRequirements2::default();

    if context.api_version() >= (1, 3, 0) {
        unsafe { vk.get_device_buffer_memory_requirements(&memory_info, &mut req2) };
    } else {
        unsafe { vk.get_device_buffer_memory_requirements_khr(&memory_info, &mut req2) };
    }

    Ok(req2.memory_requirements)
}

/// `bitsToIndices` - an index of each set bit, starting from the least significant bit.
pub(super) fn bits_to_indices(mut bits: u32) -> Vec<u32> {
    let mut indices = Vec::new();
    let mut i = 0u32;
    while bits != 0 {
        if bits & 1 != 0 {
            indices.push(i);
        }
        i += 1;
        bits >>= 1;
    }
    indices
}

/// `validValueVkBool32`
pub(super) fn valid_value_vk_bool32(value: vk::Bool32) -> bool {
    value == vk::FALSE || value == vk::TRUE
}

/// Whether `VK_KHR_get_memory_requirements2` / `VK_KHR_dedicated_allocation` is usable:
/// both were promoted to 1.1, and `Context::require_device_functionality` has no entry for
/// the first, so a 1.1+ device that dropped the string would be reported NotSupported where
/// upstream runs the case.
pub(super) fn require_promoted_to_1_1(context: &Context<'_>, extension: &str) -> Result<(), TestError> {
    if context.api_version() >= (1, 1, 0) {
        return Ok(());
    }
    context.require_device_functionality(extension)
}

/// The sparse features a buffer's create flags need, `checkSupportBufferMemoryRequirementsOriginal`.
fn require_feature(supported: vk::Bool32, name: &str) -> Result<(), TestError> {
    if supported == vk::FALSE {
        return Err(TestError::NotSupported(format!("Feature not supported: {name}")));
    }
    Ok(())
}

/// `checkSupportBufferMemoryRequirementsOriginal`
fn check_support_buffer_memory_requirements_original(
    context: &Context<'_>,
    flags: vk::BufferCreateFlags,
) -> Result<(), TestError> {
    let features = context.get_device_features();
    if flags.contains(vk::BufferCreateFlags::SPARSE_BINDING) {
        require_feature(features.sparse_binding, "sparseBinding")?;
    }
    if flags.contains(vk::BufferCreateFlags::SPARSE_RESIDENCY) {
        require_feature(features.sparse_residency_buffer, "sparseResidencyBuffer")?;
    }
    if flags.contains(vk::BufferCreateFlags::SPARSE_ALIASED) {
        require_feature(features.sparse_residency_aliased, "sparseResidencyAliased")?;
    }
    Ok(())
}

/// `checkSupportBufferMemoryRequirementsExtended`
fn check_support_buffer_memory_requirements_extended(
    context: &Context<'_>,
    flags: vk::BufferCreateFlags,
) -> Result<(), TestError> {
    check_support_buffer_memory_requirements_original(context, flags)?;
    require_promoted_to_1_1(context, "VK_KHR_get_memory_requirements2")
}

/// `checkSupportBufferMemoryRequirementsDedicatedAllocation`
fn check_support_buffer_memory_requirements_dedicated_allocation(
    context: &Context<'_>,
    flags: vk::BufferCreateFlags,
) -> Result<(), TestError> {
    check_support_buffer_memory_requirements_extended(context, flags)?;
    require_promoted_to_1_1(context, "VK_KHR_dedicated_allocation")
}

/// `checkSupportBufferMemoryRequirementsCreateInfo`
fn check_support_buffer_memory_requirements_create_info(
    context: &Context<'_>,
    flags: vk::BufferCreateFlags,
) -> Result<(), TestError> {
    check_support_buffer_memory_requirements_extended(context, flags)?;
    context.require_device_functionality("VK_KHR_maintenance4")
}

/// Which of upstream's four `IBufferMemoryRequirements` subclasses is running.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Variant {
    /// `BufferMemoryRequirementsOriginal`
    Original,
    /// `BufferMemoryRequirementsExtended`
    Extended,
    /// `BufferMemoryRequirementsDedicatedAllocation`
    DedicatedAllocation,
    /// `BufferMemoryRequirementsCreateInfo`
    CreateInfo,
}

/// The data members of the whole `BufferMemoryRequirements*` hierarchy.
struct BufferMemoryRequirements {
    variant: Variant,
    all_usage_flags_requirements: vk::MemoryRequirements,
    current_test_requirements: vk::MemoryRequirements,

    all_usage_flags_prefers_dedicated_allocation: vk::Bool32,
    all_usage_flags_requires_dedicated_allocation: vk::Bool32,
    current_test_prefers_dedicated_allocation: vk::Bool32,
    current_test_requires_dedicated_allocation: vk::Bool32,

    current_test_original_requirements: vk::MemoryRequirements,
    current_test_half_requirements: vk::MemoryRequirements,
}

impl BufferMemoryRequirements {
    fn new(variant: Variant) -> Self {
        Self {
            variant,
            all_usage_flags_requirements: vk::MemoryRequirements::default(),
            current_test_requirements: vk::MemoryRequirements::default(),
            all_usage_flags_prefers_dedicated_allocation: vk::FALSE,
            all_usage_flags_requires_dedicated_allocation: vk::FALSE,
            current_test_prefers_dedicated_allocation: vk::FALSE,
            current_test_requires_dedicated_allocation: vk::FALSE,
            current_test_original_requirements: vk::MemoryRequirements::default(),
            current_test_half_requirements: vk::MemoryRequirements::default(),
        }
    }

    /// `execTest`
    fn exec_test(&mut self, context: &Context<'_>, buffer_flags: vk::BufferCreateFlags) -> TestOutcome {
        let vki = context.get_instance();
        let phys_device = context.get_physical_device();

        let memory_properties = unsafe { vki.get_physical_device_memory_properties(phys_device) };
        let limits = context.get_device_properties().limits;
        let all_usage_flags =
            vk::BufferUsageFlags::from_bits_truncate((vk::BufferUsageFlags::INDIRECT_BUFFER.bits() << 1) - 1);
        let mut all_pass = true;

        let size_cases: [vk::DeviceSize; 4] = [1024, 8 * 1024, 64 * 1024, 1024 * 1024];

        // Updates m_allUsageFlags* fields
        self.update_memory_requirements(context, 1024, buffer_flags, all_usage_flags, true)?; // doesn't depend on size

        let mut usage_bits = vk::BufferUsageFlags::TRANSFER_SRC.bits();
        while usage_bits <= vk::BufferUsageFlags::INDIRECT_BUFFER.bits() {
            let usage = vk::BufferUsageFlags::from_bits_truncate(usage_bits);
            let mut previous_memory_type_bits = 0u32;
            let mut previous_alignment: vk::DeviceSize = 0;

            log::info!("Verify a buffer with usage flags: {usage:?}");

            for (size_ndx, p_size) in size_cases.iter().enumerate() {
                log::info!("- size {p_size} bytes");

                let mut result = ResultCollector::new("ERROR: ");

                // Updates m_allUsageFlags* fields
                self.update_memory_requirements(context, *p_size, buffer_flags, usage, false)?;

                // Check:
                // - requirements for a particular buffer usage
                // - memoryTypeBits are a subset of bits for requirements with all usage flags combined
                self.verify_memory_requirements(&mut result, &memory_properties, &limits, buffer_flags, usage);

                // Check that for the same usage and create flags:
                // - memoryTypeBits are the same
                // - alignment is the same
                if size_ndx > 0 {
                    result.check(
                        self.current_test_requirements.memory_type_bits == previous_memory_type_bits,
                        "memoryTypeBits differ from the ones in the previous buffer size",
                    );

                    result.check(
                        self.current_test_requirements.alignment == previous_alignment,
                        "alignment differs from the one in the previous buffer size",
                    );
                }

                if result.to_status().code() != TestResult::Pass {
                    all_pass = false;
                }

                previous_memory_type_bits = self.current_test_requirements.memory_type_bits;
                previous_alignment = self.current_test_requirements.alignment;
            }

            if !all_pass {
                break;
            }
            usage_bits <<= 1;
        }

        Ok(if all_pass {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Some memory requirements were incorrect")
        })
    }

    /// `updateMemoryRequirements` - the override of each variant.
    fn update_memory_requirements(
        &mut self,
        context: &Context<'_>,
        size: vk::DeviceSize,
        flags: vk::BufferCreateFlags,
        usage: vk::BufferUsageFlags,
        all: bool,
    ) -> Result<(), TestError> {
        let vk = context.get_device();
        match self.variant {
            Variant::Original => {
                if all {
                    self.all_usage_flags_requirements = get_buffer_memory_requirements(vk, size, flags, usage)?;
                } else {
                    self.current_test_requirements = get_buffer_memory_requirements(vk, size, flags, usage)?;
                }
            }
            Variant::Extended => {
                if all {
                    self.all_usage_flags_requirements = get_buffer_memory_requirements2(vk, size, flags, usage, None)?;
                } else {
                    self.current_test_requirements = get_buffer_memory_requirements2(vk, size, flags, usage, None)?;
                }
            }
            Variant::DedicatedAllocation => {
                let invalid_vk_bool32: u32 = !0;

                let mut dedicated_requirements = vk::MemoryDedicatedRequirements {
                    s_type: vk::StructureType::MEMORY_DEDICATED_REQUIREMENTS,
                    next: std::ptr::null_mut(),
                    prefers_dedicated_allocation: invalid_vk_bool32,
                    requires_dedicated_allocation: invalid_vk_bool32,
                };

                if all {
                    self.all_usage_flags_requirements =
                        get_buffer_memory_requirements2(vk, size, flags, usage, Some(&mut dedicated_requirements))?;
                    self.all_usage_flags_prefers_dedicated_allocation =
                        dedicated_requirements.prefers_dedicated_allocation;
                    self.all_usage_flags_requires_dedicated_allocation =
                        dedicated_requirements.requires_dedicated_allocation;

                    if !valid_value_vk_bool32(self.all_usage_flags_prefers_dedicated_allocation) {
                        return Err(TestError::Fail(
                            "valid_value_vk_bool32(m_allUsageFlagsPrefersDedicatedAllocation)".to_string(),
                        ));
                    }
                    // Test design expects m_allUsageFlagsRequiresDedicatedAllocation to be false
                    if self.all_usage_flags_requires_dedicated_allocation != vk::FALSE {
                        return Err(TestError::Fail(
                            "m_allUsageFlagsRequiresDedicatedAllocation == VK_FALSE".to_string(),
                        ));
                    }
                } else {
                    self.current_test_requirements =
                        get_buffer_memory_requirements2(vk, size, flags, usage, Some(&mut dedicated_requirements))?;
                    self.current_test_prefers_dedicated_allocation =
                        dedicated_requirements.prefers_dedicated_allocation;
                    self.current_test_requires_dedicated_allocation =
                        dedicated_requirements.requires_dedicated_allocation;
                }
            }
            Variant::CreateInfo => {
                if all {
                    self.all_usage_flags_requirements =
                        get_buffer_create_info_memory_requirements_khr(context, size, flags, usage)?;
                } else {
                    self.current_test_requirements =
                        get_buffer_create_info_memory_requirements_khr(context, size, flags, usage)?;
                    self.current_test_half_requirements =
                        get_buffer_create_info_memory_requirements_khr(context, size / 2, flags, usage)?;
                }

                self.current_test_original_requirements = get_buffer_memory_requirements(vk, size, flags, usage)?;
            }
        }
        Ok(())
    }

    /// `verifyMemoryRequirements` - the override of each variant, each one running its base's first.
    fn verify_memory_requirements(
        &self,
        result: &mut ResultCollector,
        device_memory_properties: &vk::PhysicalDeviceMemoryProperties,
        limits: &vk::PhysicalDeviceLimits,
        buffer_flags: vk::BufferCreateFlags,
        usage: vk::BufferUsageFlags,
    ) {
        self.verify_original(result, device_memory_properties, limits, buffer_flags, usage);

        match self.variant {
            Variant::Original | Variant::Extended => {}
            Variant::DedicatedAllocation => {
                result.check(
                    valid_value_vk_bool32(self.current_test_prefers_dedicated_allocation),
                    "Invalid VkBool32 value in m_currentTestPrefersDedicatedAllocation",
                );

                result.check(
                    self.current_test_requires_dedicated_allocation == vk::FALSE,
                    "Regular (non-shared) objects must not require dedicated allocations",
                );
            }
            Variant::CreateInfo => {
                result.check(
                    self.current_test_requirements.alignment == self.current_test_original_requirements.alignment,
                    "VkMemoryRequirements alignment queried from vkBufferCreateInfo does not match alignment from equivalent object",
                );

                result.check(
                    self.current_test_requirements.memory_type_bits == self.current_test_original_requirements.memory_type_bits,
                    "VkMemoryRequirements memoryTypeBits queried from vkBufferCreateInfo does not match memoryTypeBits from equivalent object",
                );

                result.check(
                    self.current_test_requirements.size == self.current_test_original_requirements.size,
                    "VkMemoryRequirements size queried from vkBufferCreateInfo does not match size from equivalent object",
                );

                result.check(
                    self.current_test_requirements.size >= self.current_test_half_requirements.size,
                    "VkMemoryRequirements size queried from vkBufferCreateInfo is larger for a smaller buffer",
                );
            }
        }
    }

    /// `BufferMemoryRequirementsOriginal::verifyMemoryRequirements`
    fn verify_original(
        &self,
        result: &mut ResultCollector,
        device_memory_properties: &vk::PhysicalDeviceMemoryProperties,
        limits: &vk::PhysicalDeviceLimits,
        buffer_flags: vk::BufferCreateFlags,
        usage: vk::BufferUsageFlags,
    ) {
        if result.check(
            self.current_test_requirements.memory_type_bits != 0,
            "VkMemoryRequirements memoryTypeBits has no bits set",
        ) {
            let used_memory_type_indices = bits_to_indices(self.current_test_requirements.memory_type_bits);
            let mut device_local_memory_found = false;
            let mut host_visible_coherent_memory_found = false;

            for &memory_type_ndx in &used_memory_type_indices {
                if memory_type_ndx >= device_memory_properties.memory_type_count {
                    result.fail("VkMemoryRequirements memoryTypeBits contains bits for non-existing memory types");
                    continue;
                }

                let memory_property_flags =
                    device_memory_properties.memory_types[memory_type_ndx as usize].property_flags;

                if memory_property_flags.contains(vk::MemoryPropertyFlags::DEVICE_LOCAL) {
                    device_local_memory_found = true;
                }

                if memory_property_flags
                    .intersects(vk::MemoryPropertyFlags::HOST_VISIBLE | vk::MemoryPropertyFlags::HOST_COHERENT)
                {
                    host_visible_coherent_memory_found = true;
                }

                result.check(
                    !memory_property_flags.contains(vk::MemoryPropertyFlags::LAZILY_ALLOCATED),
                    "Memory type includes VK_MEMORY_PROPERTY_LAZILY_ALLOCATED_BIT",
                );
            }

            result.check(
                self.current_test_requirements.alignment.is_power_of_two(),
                "VkMemoryRequirements alignment isn't power of two",
            );

            if usage.intersects(vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER | vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER)
            {
                result.check(
                    self.current_test_requirements.alignment >= limits.min_texel_buffer_offset_alignment,
                    "VkMemoryRequirements alignment doesn't respect minTexelBufferOffsetAlignment",
                );
            }

            if usage.contains(vk::BufferUsageFlags::UNIFORM_BUFFER) {
                result.check(
                    self.current_test_requirements.alignment >= limits.min_uniform_buffer_offset_alignment,
                    "VkMemoryRequirements alignment doesn't respect minUniformBufferOffsetAlignment",
                );
            }

            if usage.contains(vk::BufferUsageFlags::STORAGE_BUFFER) {
                result.check(
                    self.current_test_requirements.alignment >= limits.min_storage_buffer_offset_alignment,
                    "VkMemoryRequirements alignment doesn't respect minStorageBufferOffsetAlignment",
                );
            }

            result.check(
                device_local_memory_found,
                "None of the required memory types included VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT",
            );

            result.check(
                buffer_flags.contains(vk::BufferCreateFlags::SPARSE_BINDING) || host_visible_coherent_memory_found,
                "Required memory type doesn't include VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT and VK_MEMORY_PROPERTY_HOST_COHERENT_BIT",
            );

            result.check(
                (self.current_test_requirements.memory_type_bits & self.all_usage_flags_requirements.memory_type_bits)
                    == self.all_usage_flags_requirements.memory_type_bits,
                "Memory type bits aren't a superset of memory type bits for all usage flags combined",
            );
        }
    }
}

struct BufferRequirementsCase {
    name: &'static str,
    variant: Variant,
    flags: vk::BufferCreateFlags,
}

impl TestCase for BufferRequirementsCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.variant {
            Variant::Original => check_support_buffer_memory_requirements_original(context, self.flags),
            Variant::Extended => check_support_buffer_memory_requirements_extended(context, self.flags),
            Variant::DedicatedAllocation => {
                check_support_buffer_memory_requirements_dedicated_allocation(context, self.flags)
            }
            Variant::CreateInfo => check_support_buffer_memory_requirements_create_info(context, self.flags),
        }
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BufferRequirementsInstance {
            context,
            variant: self.variant,
            flags: self.flags,
        })
    }
}

struct BufferRequirementsInstance<'a> {
    context: &'a Context<'a>,
    variant: Variant,
    flags: vk::BufferCreateFlags,
}

impl TestInstance for BufferRequirementsInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let mut test = BufferMemoryRequirements::new(self.variant);
        test.exec_test(self.context, self.flags)
    }
}

/// `BufferMemoryRequirements*::populateTestGroup`
fn populate_buffer_test_group(group: &mut TestCaseGroup, variant: Variant) {
    let buffer_cases: [(vk::BufferCreateFlags, &'static str); 5] = [
        (vk::BufferCreateFlags::empty(), "regular"),
        (vk::BufferCreateFlags::SPARSE_BINDING, "sparse"),
        (
            vk::BufferCreateFlags::SPARSE_BINDING | vk::BufferCreateFlags::SPARSE_RESIDENCY,
            "sparse_residency",
        ),
        (
            vk::BufferCreateFlags::SPARSE_BINDING | vk::BufferCreateFlags::SPARSE_ALIASED,
            "sparse_aliased",
        ),
        (
            vk::BufferCreateFlags::SPARSE_BINDING
                | vk::BufferCreateFlags::SPARSE_RESIDENCY
                | vk::BufferCreateFlags::SPARSE_ALIASED,
            "sparse_residency_aliased",
        ),
    ];

    let mut buffer_group = TestCaseGroup::new("buffer");

    for (flags, name) in buffer_cases {
        buffer_group.add_child(Box::new(BufferRequirementsCase { name, variant, flags }) as Box<dyn TestCase>);
    }

    group.add_child(buffer_group);
}

/// `testVkMemoryPropertyFlags`
fn test_vk_memory_property_flags(context: &Context<'_>) -> TestOutcome {
    use vk::MemoryPropertyFlags as F;

    let property_flag_sets: [F; 22] = [
        F::empty(),
        F::HOST_VISIBLE | F::HOST_COHERENT,
        F::HOST_VISIBLE | F::HOST_CACHED,
        F::HOST_VISIBLE | F::HOST_CACHED | F::HOST_COHERENT,
        F::DEVICE_LOCAL,
        F::DEVICE_LOCAL | F::HOST_VISIBLE | F::HOST_COHERENT,
        F::DEVICE_LOCAL | F::HOST_VISIBLE | F::HOST_CACHED,
        F::DEVICE_LOCAL | F::HOST_VISIBLE | F::HOST_CACHED | F::HOST_COHERENT,
        F::DEVICE_LOCAL | F::LAZILY_ALLOCATED,
        F::PROTECTED,
        F::PROTECTED | F::DEVICE_LOCAL,
        F::HOST_VISIBLE | F::HOST_COHERENT | F::DEVICE_COHERENT_AMD,
        F::HOST_VISIBLE | F::HOST_CACHED | F::HOST_COHERENT | F::DEVICE_COHERENT_AMD,
        F::DEVICE_LOCAL | F::DEVICE_COHERENT_AMD,
        F::DEVICE_LOCAL | F::HOST_VISIBLE | F::HOST_COHERENT | F::DEVICE_COHERENT_AMD,
        F::DEVICE_LOCAL | F::HOST_VISIBLE | F::HOST_CACHED | F::HOST_COHERENT | F::DEVICE_COHERENT_AMD,
        F::HOST_VISIBLE | F::HOST_COHERENT | F::DEVICE_COHERENT_AMD | F::DEVICE_UNCACHED_AMD,
        F::HOST_VISIBLE | F::HOST_CACHED | F::HOST_COHERENT | F::DEVICE_COHERENT_AMD | F::DEVICE_UNCACHED_AMD,
        F::DEVICE_LOCAL | F::DEVICE_COHERENT_AMD | F::DEVICE_UNCACHED_AMD,
        F::DEVICE_LOCAL | F::HOST_VISIBLE | F::HOST_COHERENT | F::DEVICE_COHERENT_AMD | F::DEVICE_UNCACHED_AMD,
        F::DEVICE_LOCAL
            | F::HOST_VISIBLE
            | F::HOST_CACHED
            | F::HOST_COHERENT
            | F::DEVICE_COHERENT_AMD
            | F::DEVICE_UNCACHED_AMD,
        F::DEVICE_LOCAL | F::RDMA_CAPABLE_NV,
    ];

    let vki = context.get_instance();
    let physical_device = context.get_physical_device();
    let mut matching_types: u32 = 0;
    let mut result = ResultCollector::new("ERROR: ");

    let memory_properties = unsafe { vki.get_physical_device_memory_properties(physical_device) };

    for ndx in 0..memory_properties.memory_type_count {
        for flag in &property_flag_sets {
            if memory_properties.memory_types[ndx as usize].property_flags == *flag {
                matching_types += 1;
            }
        }
    }

    let diff_str = (i64::from(memory_properties.memory_type_count) - i64::from(matching_types)).to_string();

    result.check(
        matching_types == memory_properties.memory_type_count,
        format!("Unknown memory type bits set in memory requirements: {diff_str} mismatch"),
    );

    Ok(result.to_status())
}

struct MemoryPropertyFlagsCase;

impl TestCase for MemoryPropertyFlagsCase {
    fn name(&self) -> &str {
        "check_all"
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MemoryPropertyFlagsInstance { context })
    }
}

struct MemoryPropertyFlagsInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for MemoryPropertyFlagsInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        test_vk_memory_property_flags(self.context)
    }
}

/// `populateCoreTestGroup` / `populateExtendedTestGroup` / `populateDedicatedAllocationTestGroup` /
/// `populateCreateInfoTestGroup`: the buffer half, then the image half.
fn requirements_group(name: &str, variant: Variant) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    populate_buffer_test_group(&mut group, variant);

    let image_variant = match variant {
        Variant::Original => ImageVariant::Original,
        Variant::Extended => ImageVariant::Extended,
        Variant::DedicatedAllocation => ImageVariant::DedicatedAllocation,
        Variant::CreateInfo => ImageVariant::CreateInfo,
    };
    populate_image_test_group(&mut group, image_variant);

    group
}

/// `createRequirementsTests`
pub fn create_requirements_tests() -> TestCaseGroup {
    let mut requirements_group_root = TestCaseGroup::new("requirements");

    // Memory requirements tests with core functionality
    requirements_group_root.add_child(requirements_group("core", Variant::Original));
    // Memory requirements tests with extension VK_KHR_get_memory_requirements2
    requirements_group_root.add_child(requirements_group("extended", Variant::Extended));
    // Memory requirements tests with extension VK_KHR_dedicated_allocation
    requirements_group_root.add_child(requirements_group("dedicated_allocation", Variant::DedicatedAllocation));
    // Memory requirements tests with vkGetImagePlaneMemoryRequirements
    let mut multiplane_image = TestCaseGroup::new("multiplane_image");
    populate_multiplane_test_group(&mut multiplane_image, false);
    requirements_group_root.add_child(multiplane_image);
    // Memory requirements tests with vkGetPhysicalDeviceMemoryProperties
    let mut memory_property_flags = TestCaseGroup::new("memory_property_flags");
    memory_property_flags.add_child(Box::new(MemoryPropertyFlagsCase) as Box<dyn TestCase>);
    requirements_group_root.add_child(memory_property_flags);
    // Memory requirements tests with extension VK_KHR_maintenance4
    let mut create_info = requirements_group("create_info", Variant::CreateInfo);
    let mut create_info_multiplane = TestCaseGroup::new("multiplane_image");
    populate_multiplane_test_group(&mut create_info_multiplane, true);
    create_info.add_child(create_info_multiplane);
    requirements_group_root.add_child(create_info);

    requirements_group_root
}
