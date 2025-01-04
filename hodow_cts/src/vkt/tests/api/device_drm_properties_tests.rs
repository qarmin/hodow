// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiDeviceDrmPropertiesTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream looks the device nodes up through libdrm when `DEQP_SUPPORT_DRM` is defined.
// This port links no libdrm, which is upstream's own configuration without that macro: the
// nodes are never found, so a device that reports a primary or render node is
// NotSupported and one that reports neither passes.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::case_util::add_function_case;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vkt::{Context, TestCaseGroup};

fn check_support(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_physical_device_drm")
}

/// `testFilesExist`
fn test_files_exist(device_drm_properties: &vk::PhysicalDeviceDrmPropertiesEXT) -> Result<(), TestError> {
    let primary_found = device_drm_properties.has_primary == vk::FALSE;
    let render_found = device_drm_properties.has_render == vk::FALSE;

    if !primary_found && !render_found {
        return Err(TestError::NotSupported(
            "Neither DRM primary nor render device files were found".to_string(),
        ));
    }
    Ok(())
}

/// `testDeviceDrmProperties`
fn test_device_drm_properties(context: &Context<'_>) -> TestOutcome {
    let mut device_drm_properties = vk::PhysicalDeviceDrmPropertiesEXT::default();

    {
        let mut device_properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut device_drm_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut device_properties2)
        };
    }

    test_files_exist(&device_drm_properties)?;

    Ok(TestStatus::pass("Pass"))
}

/// `createDeviceDrmPropertiesTests`
pub fn create_device_drm_properties_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("device_drm_properties");

    // Verify device files for major/minor nodes exist
    add_function_case(&mut group, "drm_files_exist", check_support, test_device_drm_properties);

    group
}
