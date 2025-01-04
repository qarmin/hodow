// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiFeatureInfo.cpp (`devicePropertyExtensionsConsistencyVulkan14`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The layout arrays are compared with a byte count equal to the element count, as upstream's deMemCmp does.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vkt::Context;

fn bytes_eq(a: &[vk::ImageLayout], b: &[vk::ImageLayout], byte_count: usize) -> bool {
    if byte_count == 0 {
        return true;
    }
    let as_bytes = |layouts: &[vk::ImageLayout]| {
        unsafe {
            std::slice::from_raw_parts(
                layouts.as_ptr() as *const u8,
                byte_count.min(std::mem::size_of_val(layouts)),
            )
        }
        .to_vec()
    };
    as_bytes(a) == as_bytes(b)
}

pub fn device_property_extensions_consistency_vulkan14(context: &Context<'_>) -> TestOutcome {
    let (major, minor, _) = context.api_version();
    if (major, minor) < (1, 4) {
        return Err(TestError::NotSupported(
            "At least Vulkan 1.4 required to run test".to_string(),
        ));
    }
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let mut vulkan14_properties = vk::PhysicalDeviceVulkan14Properties::default();
    {
        let mut ext_properties = vk::PhysicalDeviceProperties2::builder().push_next(&mut vulkan14_properties);
        unsafe { instance.get_physical_device_properties2(physical_device, &mut ext_properties) };
    }
    let src_count = vulkan14_properties.copy_src_layout_count as usize;
    let dst_count = vulkan14_properties.copy_dst_layout_count as usize;
    let mut vulkan14_copy_layouts = vec![vk::ImageLayout::UNDEFINED; src_count + dst_count];
    vulkan14_properties.copy_src_layouts = vulkan14_copy_layouts.as_mut_ptr();
    vulkan14_properties.copy_dst_layouts = unsafe { vulkan14_copy_layouts.as_mut_ptr().add(src_count) };
    {
        let mut ext_properties = vk::PhysicalDeviceProperties2::builder().push_next(&mut vulkan14_properties);
        unsafe { instance.get_physical_device_properties2(physical_device, &mut ext_properties) };
    }

    // Every field has to match the extension structures.
    let mut line_rasterization_properties = vk::PhysicalDeviceLineRasterizationProperties::default();
    let mut maintenance5_properties = vk::PhysicalDeviceMaintenance5Properties::default();
    let mut maintenance6_properties = vk::PhysicalDeviceMaintenance6Properties::default();
    let mut push_descriptor_properties = vk::PhysicalDevicePushDescriptorProperties::default();
    let mut vertex_attribute_divisor_properties = vk::PhysicalDeviceVertexAttributeDivisorProperties::default();
    let mut host_image_copy_properties = vk::PhysicalDeviceHostImageCopyProperties::default();
    let mut pipeline_robustness_properties = vk::PhysicalDevicePipelineRobustnessProperties::default();
    {
        let mut ext_properties = vk::PhysicalDeviceProperties2::builder()
            .push_next(&mut line_rasterization_properties)
            .push_next(&mut maintenance5_properties)
            .push_next(&mut maintenance6_properties)
            .push_next(&mut push_descriptor_properties)
            .push_next(&mut vertex_attribute_divisor_properties)
            .push_next(&mut host_image_copy_properties)
            .push_next(&mut pipeline_robustness_properties);
        unsafe { instance.get_physical_device_properties2(physical_device, &mut ext_properties) };
    }

    // Allocate and fill the layout arrays of the host image copy structure, which then is the only one queried.
    let ext_src_count = host_image_copy_properties.copy_src_layout_count as usize;
    let ext_dst_count = host_image_copy_properties.copy_dst_layout_count as usize;
    let mut ext_copy_layouts = vec![vk::ImageLayout::UNDEFINED; ext_src_count + ext_dst_count];
    host_image_copy_properties.copy_src_layouts = ext_copy_layouts.as_mut_ptr();
    host_image_copy_properties.copy_dst_layouts = unsafe { ext_copy_layouts.as_mut_ptr().add(ext_src_count) };
    host_image_copy_properties.next = std::ptr::null_mut();
    {
        let mut ext_properties = vk::PhysicalDeviceProperties2::builder().push_next(&mut host_image_copy_properties);
        unsafe { instance.get_physical_device_properties2(physical_device, &mut ext_properties) };
    }

    let v = &vulkan14_properties;
    let fail = |message: &str| Ok(TestStatus::fail(message.to_string()));

    if line_rasterization_properties.line_sub_pixel_precision_bits != v.line_sub_pixel_precision_bits {
        return fail(
            "Mismatch between VkPhysicalDeviceLineRasterizationPropertiesKHR and VkPhysicalDeviceVulkan14Properties",
        );
    }
    if maintenance5_properties.early_fragment_multisample_coverage_after_sample_counting
        != v.early_fragment_multisample_coverage_after_sample_counting
        || maintenance5_properties.early_fragment_sample_mask_test_before_sample_counting
            != v.early_fragment_sample_mask_test_before_sample_counting
        || maintenance5_properties.depth_stencil_swizzle_one_support != v.depth_stencil_swizzle_one_support
        || maintenance5_properties.polygon_mode_point_size != v.polygon_mode_point_size
        || maintenance5_properties.non_strict_single_pixel_wide_lines_use_parallelogram
            != v.non_strict_single_pixel_wide_lines_use_parallelogram
        || maintenance5_properties.non_strict_wide_lines_use_parallelogram != v.non_strict_wide_lines_use_parallelogram
    {
        return fail(
            "Mismatch between VkPhysicalDeviceMaintenance5PropertiesKHR and VkPhysicalDeviceVulkan14Properties",
        );
    }
    if maintenance6_properties.block_texel_view_compatible_multiple_layers
        != v.block_texel_view_compatible_multiple_layers
        || maintenance6_properties.max_combined_image_sampler_descriptor_count
            != v.max_combined_image_sampler_descriptor_count
        || maintenance6_properties.fragment_shading_rate_clamp_combiner_inputs
            != v.fragment_shading_rate_clamp_combiner_inputs
    {
        return fail(
            "Mismatch between VkPhysicalDeviceMaintenance6PropertiesKHR and VkPhysicalDeviceVulkan14Properties",
        );
    }
    if push_descriptor_properties.max_push_descriptors != v.max_push_descriptors {
        return fail(
            "Mismatch between VkPhysicalDevicePushDescriptorPropertiesKHR and VkPhysicalDeviceVulkan14Properties",
        );
    }
    if vertex_attribute_divisor_properties.max_vertex_attrib_divisor != v.max_vertex_attrib_divisor
        || vertex_attribute_divisor_properties.supports_non_zero_first_instance != v.supports_non_zero_first_instance
    {
        return fail(
            "Mismatch between VkPhysicalDeviceVertexAttributeDivisorPropertiesKHR and VkPhysicalDeviceVulkan14Properties",
        );
    }
    let (ext_src, ext_dst) = ext_copy_layouts.split_at(ext_src_count);
    let (v14_src, v14_dst) = vulkan14_copy_layouts.split_at(src_count);
    if host_image_copy_properties.copy_src_layout_count != v.copy_src_layout_count
        || !bytes_eq(ext_src, v14_src, src_count)
        || host_image_copy_properties.copy_dst_layout_count != v.copy_dst_layout_count
        || !bytes_eq(ext_dst, v14_dst, dst_count)
        || host_image_copy_properties.optimal_tiling_layout_uuid != v.optimal_tiling_layout_uuid
        || host_image_copy_properties.identical_memory_type_requirements != v.identical_memory_type_requirements
    {
        return fail(
            "Mismatch between VkPhysicalDeviceHostImageCopyPropertiesEXT and VkPhysicalDeviceVulkan14Properties",
        );
    }
    if pipeline_robustness_properties.default_robustness_storage_buffers != v.default_robustness_storage_buffers
        || pipeline_robustness_properties.default_robustness_uniform_buffers != v.default_robustness_uniform_buffers
        || pipeline_robustness_properties.default_robustness_vertex_inputs != v.default_robustness_vertex_inputs
        || pipeline_robustness_properties.default_robustness_images != v.default_robustness_images
    {
        return fail(
            "Mismatch between VkPhysicalDevicePipelineRobustnessPropertiesEXT and VkPhysicalDeviceVulkan14Properties",
        );
    }

    Ok(TestStatus::pass(
        "Vulkan 1.4 device properties are consistent with extension properties",
    ))
}
