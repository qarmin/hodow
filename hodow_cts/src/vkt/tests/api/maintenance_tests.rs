// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiMaintenance6Check.cpp
//   external/vulkancts/modules/vulkan/api/vktApiMaintenance7Tests.cpp
//   external/vulkancts/modules/vulkan/api/vktApiMaintenance11Tests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Every case here is a property query. VK_KHR_maintenance11 is newer than the vulkanalia
// registry, so its one struct is declared locally from vk.xml (extension 658, offset 1).

use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::case_util::add_function_case;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vkt::{Context, TestCaseGroup};

// ---------------------------------------------------------------------------------
// vktApiMaintenance6Check.cpp
// ---------------------------------------------------------------------------------

fn check_support_maintenance6(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_KHR_maintenance6")
}

/// `Maintenance6MaxCombinedImageSamplerDescriptorCountTestInstance::iterate`
fn maintenance6_max_combined_image_sampler_descriptor_count(context: &Context<'_>) -> TestOutcome {
    let vki = context.get_instance();
    let physical_device = context.get_physical_device();

    let mut maint_prop6 = vk::PhysicalDeviceMaintenance6Properties::default();
    {
        let mut prop2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut maint_prop6);
        unsafe { vki.get_physical_device_properties2(physical_device, &mut prop2) };
    }

    // (begin, end) with `end` exclusive, as upstream's `(VkFormat)(last + 1)`.
    let format_ranges: [(i32, i32); 3] = [
        // YCbCr formats
        (
            vk::Format::G8B8G8R8_422_UNORM.as_raw(),
            vk::Format::G16_B16_R16_3PLANE_444_UNORM.as_raw() + 1,
        ),
        // YCbCr extended formats
        (
            vk::Format::G8_B8R8_2PLANE_444_UNORM.as_raw(),
            vk::Format::G16_B16R16_2PLANE_444_UNORM.as_raw() + 1,
        ),
        // VK_FORMAT_R16G16_S10_5_NV
        (1000464000, 1000464000 + 1),
    ];

    for (range_begin, range_end) in format_ranges {
        for raw_format in range_begin..range_end {
            let format = vk::Format::from_raw(raw_format);

            let mut conversion_image_format_props = vk::SamplerYcbcrConversionImageFormatProperties::default();
            let mut format_props = vk::ImageFormatProperties2::builder().push_next(&mut conversion_image_format_props);
            let image_info = vk::PhysicalDeviceImageFormatInfo2::builder()
                .format(format)
                .type_(vk::ImageType::_2D)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(vk::ImageUsageFlags::TRANSFER_DST)
                .flags(vk::ImageCreateFlags::empty());
            // The result is deliberately not checked: an unsupported format leaves the
            // zero-initialised structure, which is within the limit.
            unsafe {
                vki.get_physical_device_image_format_properties2(physical_device, &image_info, &mut format_props)
            }
            .ok();

            if conversion_image_format_props.combined_image_sampler_descriptor_count
                > maint_prop6.max_combined_image_sampler_descriptor_count
            {
                return Ok(TestStatus::fail(format!(
                    "Fail: format {format:?} requires a larger combinedImageSamplerDescriptorCount={} than maxCombinedImageSamplerDescriptorCount={}",
                    conversion_image_format_props.combined_image_sampler_descriptor_count,
                    maint_prop6.max_combined_image_sampler_descriptor_count
                )));
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `createMaintenance6Tests`
pub fn create_maintenance6_tests() -> TestCaseGroup {
    let mut main6_tests = TestCaseGroup::new("maintenance6_check");
    add_function_case(
        &mut main6_tests,
        "maintenance6_properties",
        check_support_maintenance6,
        maintenance6_max_combined_image_sampler_descriptor_count,
    );
    main6_tests
}

// ---------------------------------------------------------------------------------
// vktApiMaintenance7Tests.cpp
// ---------------------------------------------------------------------------------

fn check_support_maintenance7(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_KHR_maintenance7")
}

/// `Maintenance7LayeredApiVulkanPropertiesTestInstance::iterate`
fn maintenance7_layered_api_vulkan_properties(context: &Context<'_>) -> TestOutcome {
    let vki = context.get_instance();
    let physical_device = context.get_physical_device();

    let mut layered_api_properties_list = vk::PhysicalDeviceLayeredApiPropertiesListKHR::default();
    let mut properties2 = vk::PhysicalDeviceProperties2 {
        next: (&raw mut layered_api_properties_list).cast::<c_void>(),
        ..Default::default()
    };
    unsafe { vki.get_physical_device_properties2(physical_device, &mut properties2) };

    if layered_api_properties_list.layered_api_count > 0 {
        let count = layered_api_properties_list.layered_api_count as usize;
        let mut layered_api_vulkan_properties = vec![vk::PhysicalDeviceLayeredApiVulkanPropertiesKHR::default(); count];
        let mut layered_api_properties = vec![vk::PhysicalDeviceLayeredApiPropertiesKHR::default(); count];
        for i in 0..count {
            layered_api_vulkan_properties[i] = vk::PhysicalDeviceLayeredApiVulkanPropertiesKHR::default();
            layered_api_vulkan_properties[i].properties.s_type = vk::StructureType::PHYSICAL_DEVICE_PROPERTIES_2;
            unsafe {
                std::ptr::write_bytes(
                    &raw mut layered_api_vulkan_properties[i].properties.properties.limits,
                    255,
                    1,
                );
                std::ptr::write_bytes(
                    &raw mut layered_api_vulkan_properties[i].properties.properties.sparse_properties,
                    255,
                    1,
                );
            }

            layered_api_properties[i] = vk::PhysicalDeviceLayeredApiPropertiesKHR::default();
            layered_api_properties[i].next = (&raw mut layered_api_vulkan_properties[i]).cast::<c_void>();
        }
        // Read back through `properties2`' raw `pNext` pointer by the call below.
        #[allow(unused_assignments)]
        {
            layered_api_properties_list.layered_apis = layered_api_properties.as_mut_ptr();
        }
        unsafe { vki.get_physical_device_properties2(physical_device, &mut properties2) };

        for i in 0..count {
            let is_vulkan = layered_api_properties[i].layered_api == vk::PhysicalDeviceLayeredApiKHR::VULKAN;
            let vulkan_properties = &layered_api_vulkan_properties[i].properties.properties;

            if is_vulkan {
                if layered_api_properties[i].device_id != vulkan_properties.device_id {
                    log::info!(
                        "deviceID of VkPhysicalDeviceLayeredApiPropertiesKHR and VkPhysicalDeviceLayeredApiVulkanPropertiesKHR::properties::properties at index {i} do not match"
                    );
                    return Ok(TestStatus::fail("Fail"));
                }
                if layered_api_properties[i].vendor_id != vulkan_properties.vendor_id {
                    log::info!(
                        "vendorID of VkPhysicalDeviceLayeredApiPropertiesKHR and VkPhysicalDeviceLayeredApiVulkanPropertiesKHR::properties::properties at index {i} do not match"
                    );
                    return Ok(TestStatus::fail("Fail"));
                }
            }

            let limits = unsafe {
                std::slice::from_raw_parts(
                    (&raw const vulkan_properties.limits).cast::<u8>(),
                    std::mem::size_of::<vk::PhysicalDeviceLimits>(),
                )
            };
            for &byte in limits {
                if is_vulkan {
                    if byte != 0 {
                        log::info!(
                            "VkPhysicalDeviceLayeredApiPropertiesKHR[{i}].layerAPI is VK_PHYSICAL_DEVICE_LAYERED_API_VULKAN_KHR, but VkPhysicalDeviceLayeredApiVulkanPropertiesKHR::properties::limits in pNext was not zero-filled"
                        );
                        return Ok(TestStatus::fail("Fail"));
                    }
                } else if byte != 255 {
                    log::info!(
                        "VkPhysicalDeviceLayeredApiPropertiesKHR[{i}].layerAPI is VK_PHYSICAL_DEVICE_LAYERED_API_VULKAN_KHR, but VkPhysicalDeviceLayeredApiVulkanPropertiesKHR::properties::limits in pNext was not ignored"
                    );
                    return Ok(TestStatus::fail("Fail"));
                }
            }

            let sparse_properties = unsafe {
                std::slice::from_raw_parts(
                    (&raw const vulkan_properties.sparse_properties).cast::<u8>(),
                    std::mem::size_of::<vk::PhysicalDeviceSparseProperties>(),
                )
            };
            for &byte in sparse_properties {
                if is_vulkan {
                    if byte != 0 {
                        log::info!(
                            "VkPhysicalDeviceLayeredApiPropertiesKHR[{i}].layerAPI is VK_PHYSICAL_DEVICE_LAYERED_API_VULKAN_KHR, but VkPhysicalDeviceLayeredApiVulkanPropertiesKHR::properties::sparseProperties in pNext was not zero-filled"
                        );
                        return Ok(TestStatus::fail("Fail"));
                    }
                } else if byte != 255 {
                    log::info!(
                        "VkPhysicalDeviceLayeredApiPropertiesKHR[{i}].layerAPI is VK_PHYSICAL_DEVICE_LAYERED_API_VULKAN_KHR, but VkPhysicalDeviceLayeredApiVulkanPropertiesKHR::properties::sparseProperties in pNext was not ignored"
                    );
                    return Ok(TestStatus::fail("Fail"));
                }
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `Maintenance7TotalDynamicBuffersPropertiesTestInstance::iterate`
fn maintenance7_total_dynamic_buffers_properties(context: &Context<'_>) -> TestOutcome {
    let mut maint7_prop = vk::PhysicalDeviceMaintenance7PropertiesKHR::default();
    {
        let mut prop2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut maint7_prop);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut prop2)
        };
    }

    // check dynamic buffers limits
    let device_limits = &context.get_device_properties().limits;
    if maint7_prop.max_descriptor_set_total_uniform_buffers_dynamic
        < device_limits.max_descriptor_set_uniform_buffers_dynamic
    {
        log::info!(
            "maxDescriptorSetTotalUniformBuffersDynamic: {}is less than maxDescriptorSetUniformBuffersDynamic: {}",
            maint7_prop.max_descriptor_set_total_uniform_buffers_dynamic,
            device_limits.max_descriptor_set_uniform_buffers_dynamic
        );
        return Ok(TestStatus::fail("Fail"));
    }

    if maint7_prop.max_descriptor_set_total_storage_buffers_dynamic
        < device_limits.max_descriptor_set_storage_buffers_dynamic
    {
        log::info!(
            "maxDescriptorSetTotalStorageBuffersDynamic: {}is less than maxDescriptorSetStorageBuffersDynamic: {}",
            maint7_prop.max_descriptor_set_total_storage_buffers_dynamic,
            device_limits.max_descriptor_set_storage_buffers_dynamic
        );
        return Ok(TestStatus::fail("Fail"));
    }

    if maint7_prop.max_descriptor_set_total_buffers_dynamic
        < device_limits.max_descriptor_set_uniform_buffers_dynamic
            + device_limits.max_descriptor_set_storage_buffers_dynamic
    {
        log::info!(
            "maxDescriptorSetTotalBuffersDynamic: {}is less than some of maxDescriptorSetUniformBuffersDynamic: {} and maxDescriptorSetStorageBuffersDynamic: {}",
            maint7_prop.max_descriptor_set_total_buffers_dynamic,
            device_limits.max_descriptor_set_uniform_buffers_dynamic,
            device_limits.max_descriptor_set_storage_buffers_dynamic
        );
        return Ok(TestStatus::fail("Fail"));
    }

    // check update after bind dynamic buffers limits
    let mut device_prop12 = vk::PhysicalDeviceVulkan12Properties::default();
    {
        let mut prop2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut device_prop12);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut prop2)
        };
    }

    if maint7_prop.max_descriptor_set_update_after_bind_total_uniform_buffers_dynamic
        < device_prop12.max_descriptor_set_update_after_bind_uniform_buffers_dynamic
    {
        log::info!(
            "maxDescriptorSetUpdateAfterBindTotalUniformBuffersDynamic: {}is less than maxDescriptorSetUpdateAfterBindUniformBuffersDynamic: {}",
            maint7_prop.max_descriptor_set_update_after_bind_total_uniform_buffers_dynamic,
            device_prop12.max_descriptor_set_update_after_bind_uniform_buffers_dynamic
        );
        return Ok(TestStatus::fail("Fail"));
    }

    if maint7_prop.max_descriptor_set_update_after_bind_total_storage_buffers_dynamic
        < device_prop12.max_descriptor_set_update_after_bind_storage_buffers_dynamic
    {
        log::info!(
            "maxDescriptorSetUpdateAfterBindTotalStorageBuffersDynamic: {}is less than maxDescriptorSetUpdateAfterBindStorageBuffersDynamic: {}",
            maint7_prop.max_descriptor_set_update_after_bind_total_storage_buffers_dynamic,
            device_prop12.max_descriptor_set_update_after_bind_storage_buffers_dynamic
        );
        return Ok(TestStatus::fail("Fail"));
    }

    if maint7_prop.max_descriptor_set_update_after_bind_total_buffers_dynamic
        < device_prop12.max_descriptor_set_update_after_bind_uniform_buffers_dynamic
            + device_prop12.max_descriptor_set_update_after_bind_storage_buffers_dynamic
    {
        log::info!(
            "maxDescriptorSetUpdateAfterBindTotalBuffersDynamic: {}is less than some of maxDescriptorSetUpdateAfterBindUniformBuffersDynamic: {} and maxDescriptorSetUpdateAfterBindStorageBuffersDynamic: {}",
            maint7_prop.max_descriptor_set_update_after_bind_total_buffers_dynamic,
            device_prop12.max_descriptor_set_update_after_bind_uniform_buffers_dynamic,
            device_prop12.max_descriptor_set_update_after_bind_storage_buffers_dynamic
        );
        return Ok(TestStatus::fail("Fail"));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `createMaintenance7Tests`
pub fn create_maintenance7_tests() -> TestCaseGroup {
    let mut main7_tests = TestCaseGroup::new("maintenance7");

    add_function_case(
        &mut main7_tests,
        "layered_api_vulkan_properties",
        check_support_maintenance7,
        maintenance7_layered_api_vulkan_properties,
    );
    add_function_case(
        &mut main7_tests,
        "total_dynamic_buffers_properties",
        check_support_maintenance7,
        maintenance7_total_dynamic_buffers_properties,
    );

    main7_tests
}

// ---------------------------------------------------------------------------------
// vktApiMaintenance11Tests.cpp
// ---------------------------------------------------------------------------------

/// `VK_STRUCTURE_TYPE_QUEUE_FAMILY_OPTIMAL_IMAGE_TRANSFER_GRANULARITY_PROPERTIES_KHR`:
/// 1000000000 + (658 - 1) * 1000 + 1.
const STRUCTURE_TYPE_QUEUE_FAMILY_OPTIMAL_IMAGE_TRANSFER_GRANULARITY_PROPERTIES_KHR: i32 = 1_000_657_001;

/// `VkQueueFamilyOptimalImageTransferGranularityPropertiesKHR`
#[repr(C)]
#[derive(Clone, Copy)]
struct QueueFamilyOptimalImageTransferGranularityPropertiesKHR {
    s_type: vk::StructureType,
    next: *mut c_void,
    optimal_image_transfer_granularity: vk::Extent3D,
}

fn check_support_maintenance11(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_KHR_maintenance11")
}

fn is_power_of_two32(x: u32) -> bool {
    x > 0 && (x & (x - 1)) == 0
}

/// `Maintenance11QueuePropsTestInstance::iterate`
fn maintenance11_queue_props(context: &Context<'_>) -> TestOutcome {
    let vki = context.get_instance();
    let physical_device = context.get_physical_device();
    let get_queue_family_properties2 = vki.commands().get_physical_device_queue_family_properties2;

    let mut num_queues: u32 = 0;
    unsafe { get_queue_family_properties2(physical_device, &mut num_queues, std::ptr::null_mut()) };

    let count = num_queues as usize;
    let mut transfer_granularity_props = vec![
        QueueFamilyOptimalImageTransferGranularityPropertiesKHR {
            s_type: vk::StructureType::from_raw(
                STRUCTURE_TYPE_QUEUE_FAMILY_OPTIMAL_IMAGE_TRANSFER_GRANULARITY_PROPERTIES_KHR
            ),
            next: std::ptr::null_mut(),
            optimal_image_transfer_granularity: vk::Extent3D {
                width: 1337,
                height: 1337,
                depth: 1337
            },
        };
        count
    ];
    let mut queue_family_props = vec![vk::QueueFamilyProperties2::default(); count];
    for i in 0..count {
        queue_family_props[i].next = (&raw mut transfer_granularity_props[i]).cast::<c_void>();
    }
    unsafe { get_queue_family_properties2(physical_device, &mut num_queues, queue_family_props.as_mut_ptr()) };

    for i in 0..queue_family_props.len() {
        let props = &queue_family_props[i].queue_family_properties;
        let optimal_image_transfer_granularity = transfer_granularity_props[i].optimal_image_transfer_granularity;

        if !props.queue_flags.contains(vk::QueueFlags::TRANSFER) {
            continue;
        }

        if props.min_image_transfer_granularity.width != 1
            || props.min_image_transfer_granularity.height != 1
            || props.min_image_transfer_granularity.depth != 1
        {
            return Ok(TestStatus::fail(format!(
                "queue family {i}: minImageTransferGranularity is {i} but must be 1x1x1"
            )));
        }

        let optimal_image_transfer_granularity_is_valid = (optimal_image_transfer_granularity.width == 0
            && optimal_image_transfer_granularity.height == 0
            && optimal_image_transfer_granularity.depth == 0)
            || (is_power_of_two32(optimal_image_transfer_granularity.width)
                && is_power_of_two32(optimal_image_transfer_granularity.height)
                && is_power_of_two32(optimal_image_transfer_granularity.depth));
        if !optimal_image_transfer_granularity_is_valid {
            return Ok(TestStatus::fail(format!(
                "queue family {i}: optimalImageTransferGranularity is {}x{}x{} but must be either all zeros, or the sides must be powers of two",
                optimal_image_transfer_granularity.width,
                optimal_image_transfer_granularity.height,
                optimal_image_transfer_granularity.depth
            )));
        }
    }

    Ok(TestStatus::pass(""))
}

/// `createMaintenance11Tests`
pub fn create_maintenance11_tests() -> TestCaseGroup {
    let mut main11_tests = TestCaseGroup::new("maintenance11");
    add_function_case(
        &mut main11_tests,
        "queue_properties",
        check_support_maintenance11,
        maintenance11_queue_props,
    );
    main11_tests
}
