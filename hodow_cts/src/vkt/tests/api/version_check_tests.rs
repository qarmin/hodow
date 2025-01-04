// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiVersionCheck.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Only `version` is ported. `entry_points` and `unavailable_entry_points` walk
// upstream's generated vkCoreFunctionalities.inl / vkExtensionFunctions.inl tables
// (every core and extension function name per version) and are registered as stubs.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::EntryV1_1;

use super::case_util::{StubCase, add_case, add_function_case_no_support};
use crate::tcu::{TestOutcome, TestStatus};
use crate::vk::platform::MAXIMUM_API_VERSION;
use crate::vkt::{Context, TestCaseGroup};

/// `vk::unpackVersion`
fn unpack_version(version: u32) -> (u32, u32, u32) {
    (
        vk::version_major(version),
        vk::version_minor(version),
        vk::version_patch(version),
    )
}

fn version_string(version: (u32, u32, u32)) -> String {
    format!("{}.{}.{}", version.0, version.1, version.2)
}

/// `APIVersionTestInstance::iterate`
fn api_version(context: &Context<'_>) -> TestOutcome {
    let platform = context.get_platform();
    let max_vulkan_version = unpack_version(MAXIMUM_API_VERSION);
    let available_instance_version =
        unsafe { platform.entry.enumerate_instance_version() }.unwrap_or(vk::make_version(1, 0, 0));
    let instance_version = unpack_version(available_instance_version);
    let device_api_version = context.get_device_properties().api_version;
    let device_version = unpack_version(device_api_version);
    let used_api_version = unpack_version(platform.api_version.min(device_api_version));
    let device_version_string = version_string(device_version);
    let used_api_version_string = version_string(used_api_version);

    log::info!("availableInstanceVersion: {}", version_string(instance_version));
    log::info!("deviceVersion: {device_version_string}");
    log::info!("usedApiVersion: {used_api_version_string}");

    if device_version.0 > max_vulkan_version.0 || device_version.1 > max_vulkan_version.1 {
        Ok(TestStatus::fail(format!(
            "This version of CTS does not support Vulkan device version {device_version_string}"
        )))
    } else {
        Ok(TestStatus::pass(used_api_version_string))
    }
}

/// `createVersionSanityCheckTests`
pub fn create_version_sanity_check_tests() -> TestCaseGroup {
    let mut version_tests = TestCaseGroup::new("version_check");
    add_function_case_no_support(&mut version_tests, "version", api_version);
    add_case(
        &mut version_tests,
        StubCase::new(
            "entry_points",
            "vkGet*ProcAddr entry point tables (vkCoreFunctionalities.inl, vkExtensionFunctions.inl)",
        ),
    );
    add_case(
        &mut version_tests,
        StubCase::new(
            "unavailable_entry_points",
            "vkGet*ProcAddr entry point tables (vkCoreFunctionalities.inl, vkExtensionFunctions.inl)",
        ),
    );
    version_tests
}
