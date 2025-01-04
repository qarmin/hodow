// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiGetDeviceProcAddrTests.cpp
//   external/vulkancts/framework/vulkan/generated/vulkan/vkGetDeviceProcAddr.inl
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::CString;

use vulkanalia::prelude::v1_0::*;

use super::case_util::{add_function_case_no_support, create_custom_instance};
use super::get_device_proc_addr_names::NON_ENABLED_FUNCTIONS;
use crate::tcu::{TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vkt::{Context, TestCaseGroup};

/// Destroys the custom device when it leaves scope.
struct DeviceGuard(Device);

impl Drop for DeviceGuard {
    fn drop(&mut self) {
        unsafe { self.0.destroy_device(None) };
    }
}

/// `testGetDeviceProcAddr`
fn test_get_device_proc_addr(context: &Context<'_>) -> TestOutcome {
    let custom = create_custom_instance(context, &[])?;
    let instance = &custom.instance;
    let physical_device = custom.physical_device;
    let queue_family_index = 0u32;
    let queue_priority = [1.0f32];

    let device_queue_create_infos = [vk::DeviceQueueCreateInfo::builder()
        .queue_family_index(queue_family_index)
        .queue_priorities(&queue_priority)
        .build()];
    let device_create_info = vk::DeviceCreateInfo::builder().queue_create_infos(&device_queue_create_infos);

    let device = DeviceGuard(
        unsafe { instance.create_device(physical_device, &device_create_info, None) }.vk_check("vkCreateDevice")?,
    );

    let mut fail = false;
    for function in NON_ENABLED_FUNCTIONS {
        let name = CString::new(*function).expect("function names have no interior NUL");
        if unsafe { instance.get_device_proc_addr(device.0.handle(), &name) }.is_some() {
            fail = true;
            log::info!("Function {function} is not NULL");
        }
    }
    if fail {
        return Ok(TestStatus::fail("Fail"));
    }
    Ok(TestStatus::pass("All functions are NULL"))
}

/// `createGetDeviceProcAddrTests`
pub fn create_get_device_proc_addr_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("get_device_proc_addr");
    add_function_case_no_support(&mut group, "non_enabled", test_get_device_proc_addr);
    group
}
