// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiFeatureInfo.cpp (`deviceFeaturesVulkan12`, `deviceFeaturesVulkan13`,
//   `deviceFeaturesVulkan14`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The `features` case of the `vulkan1p2`, `vulkan1p3` and `vulkan1p4` groups: the core feature structures are queried twice, into
// zeroed and into 0xFF-filled memory, and every VkBool32 member has to come back identical. Like `feature_struct_list`, the
// structures are described by their size and member count rather than declared - each is a header of sType and pNext followed by
// nothing but VkBool32 members, so a member count is the whole of upstream's offset table. The `properties` case is in `vulkan_properties_tests` and `feature_extensions_consistency` in
// `vulkan_feature_consistency_tests`. `property_extensions_consistency` is in `vulkan_property_consistency_tests` (1.2 and 1.3; the 1.4 one is in `vulkan14_property_consistency_tests`); `feature_bits_influence` is in `feature_bits_influence_tests`.

use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;

use super::case_util::add_function_case_no_support;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vkt::{Context, TestCaseGroup};

/// The `sType` and `pNext` every Vulkan structure starts with.
const HEADER_SIZE: usize = 16;

/// A core features structure: its `VkStructureType`, its size and how many VkBool32 members follow the header.
struct CoreFeatures {
    name: &'static str,
    s_type: i32,
    size: usize,
    member_count: usize,
}

const VULKAN_11_FEATURES: CoreFeatures = CoreFeatures {
    name: "VkPhysicalDeviceVulkan11Features",
    s_type: 49,
    size: 64,
    member_count: 12,
};
const VULKAN_12_FEATURES: CoreFeatures = CoreFeatures {
    name: "VkPhysicalDeviceVulkan12Features",
    s_type: 51,
    size: 208,
    member_count: 47,
};
const VULKAN_13_FEATURES: CoreFeatures = CoreFeatures {
    name: "VkPhysicalDeviceVulkan13Features",
    s_type: 53,
    size: 80,
    member_count: 15,
};
const VULKAN_14_FEATURES: CoreFeatures = CoreFeatures {
    name: "VkPhysicalDeviceVulkan14Features",
    s_type: 55,
    size: 96,
    member_count: 20,
};

/// One query of `structs` chained behind a `VkPhysicalDeviceFeatures2`, each structure pre-filled with `fill`. Returns the bytes of every
/// structure.
fn query_chain(context: &Context<'_>, structs: &[&CoreFeatures], fill: u8) -> Vec<Vec<u64>> {
    // 8-byte aligned storage, since the structures hold a pointer.
    let mut buffers: Vec<Vec<u64>> = structs.iter().map(|s| vec![0u64; s.size.div_ceil(8)]).collect();
    let base_pointers: Vec<*mut u8> = buffers.iter_mut().map(|b| b.as_mut_ptr().cast::<u8>()).collect();

    for (ndx, s) in structs.iter().enumerate() {
        let pointer = base_pointers[ndx];
        let next: *mut c_void = base_pointers
            .get(ndx + 1)
            .map_or(std::ptr::null_mut(), |p| p.cast::<c_void>());
        unsafe {
            std::ptr::write_bytes(pointer, fill, s.size);
            pointer.cast::<i32>().write(s.s_type);
            pointer.add(8).cast::<*mut c_void>().write(next);
        }
    }

    let mut features2 = vk::PhysicalDeviceFeatures2 {
        next: base_pointers[0].cast::<c_void>(),
        ..Default::default()
    };
    let get_features2 = context.get_instance().commands().get_physical_device_features2;
    unsafe { get_features2(context.get_physical_device(), &mut features2) };

    buffers
}

/// `deviceFeaturesVulkan12`, `deviceFeaturesVulkan13` and `deviceFeaturesVulkan14`: the structures of one core version.
fn device_features_vulkan(context: &Context<'_>, version: (u32, u32), structs: &[&CoreFeatures]) -> TestOutcome {
    let (major, minor, _) = context.api_version();
    if (major, minor) < version {
        return Err(TestError::NotSupported(format!(
            "At least Vulkan {}.{} required to run test",
            version.0, version.1
        )));
    }

    // Validate all fields initialized
    let first = query_chain(context, structs, 0x00);
    let second = query_chain(context, structs, 0xFF);

    for (ndx, s) in structs.iter().enumerate() {
        let members = |buffer: &Vec<u64>| {
            unsafe { std::slice::from_raw_parts(buffer.as_ptr().cast::<u8>().add(HEADER_SIZE), s.member_count * 4) }
                .to_vec()
        };
        let a = members(&first[ndx]);
        let b = members(&second[ndx]);

        log::info!("{} = {a:?}", s.name);

        if a != b {
            log::info!("deviceFeatures - {} initialization failure", s.name);
            return Ok(TestStatus::fail(format!("{} initialization failure", s.name)));
        }
    }

    Ok(TestStatus::pass(format!(
        "Querying Vulkan {}.{} device features succeeded",
        version.0, version.1
    )))
}

fn device_features_vulkan12(context: &Context<'_>) -> TestOutcome {
    device_features_vulkan(context, (1, 2), &[&VULKAN_11_FEATURES, &VULKAN_12_FEATURES])
}

fn device_features_vulkan13(context: &Context<'_>) -> TestOutcome {
    device_features_vulkan(context, (1, 3), &[&VULKAN_13_FEATURES])
}

fn device_features_vulkan14(context: &Context<'_>) -> TestOutcome {
    device_features_vulkan(context, (1, 4), &[&VULKAN_14_FEATURES])
}

/// The `vulkan1p2`, `vulkan1p3` and `vulkan1p4` groups, with the `features` and `properties` cases.
pub fn add_vulkan_features_groups(info_tests: &mut TestCaseGroup) {
    let mut vulkan1p2 = TestCaseGroup::new("vulkan1p2");
    add_function_case_no_support(&mut vulkan1p2, "features", device_features_vulkan12);
    add_function_case_no_support(
        &mut vulkan1p2,
        "properties",
        super::vulkan_properties_tests::device_properties_vulkan12,
    );
    add_function_case_no_support(
        &mut vulkan1p2,
        "feature_extensions_consistency",
        super::vulkan_feature_consistency_tests::device_feature_extensions_consistency_vulkan12,
    );
    add_function_case_no_support(
        &mut vulkan1p2,
        "property_extensions_consistency",
        super::vulkan_property_consistency_tests::device_property_extensions_consistency_vulkan12,
    );
    super::feature_bits_influence_tests::add_feature_bits_influence_case(&mut vulkan1p2, 2);
    info_tests.add_child(vulkan1p2);

    let mut vulkan1p3 = TestCaseGroup::new("vulkan1p3");
    add_function_case_no_support(&mut vulkan1p3, "features", device_features_vulkan13);
    add_function_case_no_support(
        &mut vulkan1p3,
        "properties",
        super::vulkan_properties_tests::device_properties_vulkan13,
    );
    add_function_case_no_support(
        &mut vulkan1p3,
        "feature_extensions_consistency",
        super::vulkan_feature_consistency_tests::device_feature_extensions_consistency_vulkan13,
    );
    add_function_case_no_support(
        &mut vulkan1p3,
        "property_extensions_consistency",
        super::vulkan_property_consistency_tests::device_property_extensions_consistency_vulkan13,
    );
    super::feature_bits_influence_tests::add_feature_bits_influence_case(&mut vulkan1p3, 3);
    info_tests.add_child(vulkan1p3);

    let mut vulkan1p4 = TestCaseGroup::new("vulkan1p4");
    add_function_case_no_support(&mut vulkan1p4, "features", device_features_vulkan14);
    add_function_case_no_support(
        &mut vulkan1p4,
        "properties",
        super::vulkan_properties_tests::device_properties_vulkan14,
    );
    add_function_case_no_support(
        &mut vulkan1p4,
        "feature_extensions_consistency",
        super::vulkan_feature_consistency_tests::device_feature_extensions_consistency_vulkan14,
    );
    add_function_case_no_support(
        &mut vulkan1p4,
        "property_extensions_consistency",
        super::vulkan14_property_consistency_tests::device_property_extensions_consistency_vulkan14,
    );
    super::feature_bits_influence_tests::add_feature_bits_influence_case(&mut vulkan1p4, 4);
    info_tests.add_child(vulkan1p4);
}
