// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiToolingInfoTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The raw two-call enumeration is driven through the command pointer rather than
// vulkanalia's wrapper, since the whole point of `validate_getter` is what the driver
// answers to a short, long and zero-sized array.

use vulkanalia::prelude::v1_0::*;

use super::case_util::{TestFn, add_function_case};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vkt::{Context, TestCaseGroup};

type GetToolPropertiesFn =
    unsafe extern "system" fn(vk::PhysicalDevice, *mut u32, *mut vk::PhysicalDeviceToolProperties) -> vk::Result;

const MAX_EXTENSION_NAME_SIZE: usize = 256;
const MAX_DESCRIPTION_SIZE: usize = 256;

fn get_tool_properties_fn(context: &Context<'_>) -> GetToolPropertiesFn {
    let commands = context.get_instance().commands();
    if context.get_device_properties().api_version >= vk::make_version(1, 3, 0) {
        commands.get_physical_device_tool_properties
    } else {
        commands.get_physical_device_tool_properties_ext
    }
}

fn blank_tools(count: usize) -> Vec<vk::PhysicalDeviceToolProperties> {
    let mut tools = vec![vk::PhysicalDeviceToolProperties::default(); count];
    for tool in &mut tools {
        tool.s_type = vk::StructureType::PHYSICAL_DEVICE_TOOL_PROPERTIES;
    }
    tools
}

/// `validateToolPurposeFlagBits`
fn validate_tool_purpose_flag_bits(purposes: vk::ToolPurposeFlags) -> bool {
    let valid_purposes = vk::ToolPurposeFlags::VALIDATION
        | vk::ToolPurposeFlags::PROFILING
        | vk::ToolPurposeFlags::TRACING
        | vk::ToolPurposeFlags::ADDITIONAL_FEATURES
        | vk::ToolPurposeFlags::MODIFYING_FEATURES
        | vk::ToolPurposeFlags::DEBUG_REPORTING_EXT
        | vk::ToolPurposeFlags::DEBUG_MARKERS_EXT;
    (purposes | valid_purposes) == valid_purposes
}

/// `strnlen` over a fixed character array.
fn strnlen(chars: &[std::os::raw::c_char]) -> usize {
    chars.iter().position(|&c| c == 0).unwrap_or(chars.len())
}

fn check_support(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_tooling_info")
}

fn validate_getter(context: &Context<'_>) -> TestOutcome {
    let get_tool_properties = get_tool_properties_fn(context);
    let physical_device = context.get_physical_device();

    let mut tool_count: u32 = 0;
    let result = unsafe { get_tool_properties(physical_device, &mut tool_count, std::ptr::null_mut()) };

    if result != vk::Result::SUCCESS {
        log::info!("getPhysicalDeviceToolPropertiesEXT wrong result code");
        return Ok(TestStatus::fail("Fail"));
    }

    if tool_count > 0 {
        let mut tool_count_second_call = tool_count;
        let mut tools = blank_tools(tool_count_second_call as usize);

        let result = unsafe { get_tool_properties(physical_device, &mut tool_count_second_call, tools.as_mut_ptr()) };

        if result != vk::Result::SUCCESS {
            log::info!("getPhysicalDeviceToolPropertiesEXT wrong result code");
            return Ok(TestStatus::fail("Fail"));
        }

        if tool_count_second_call != tool_count {
            log::info!("Got different tools count on the second call");
            return Ok(TestStatus::fail("Fail"));
        }

        tool_count_second_call += 1;
        tools = blank_tools(tool_count_second_call as usize);

        let result = unsafe { get_tool_properties(physical_device, &mut tool_count_second_call, tools.as_mut_ptr()) };

        if result != vk::Result::SUCCESS {
            log::info!("getPhysicalDeviceToolPropertiesEXT wrong result code");
            return Ok(TestStatus::fail("Fail"));
        }

        if tool_count_second_call != tool_count {
            log::info!("Bigger array causes an error");
            return Ok(TestStatus::fail("Fail"));
        }

        tool_count_second_call = 0;

        let result = unsafe { get_tool_properties(physical_device, &mut tool_count_second_call, tools.as_mut_ptr()) };

        if result != vk::Result::INCOMPLETE {
            log::info!("getPhysicalDeviceToolPropertiesEXT wrong result code");
            return Ok(TestStatus::fail("Fail"));
        }

        if tool_count_second_call != 0 {
            log::info!("Zero array causes an error");
            return Ok(TestStatus::fail("Fail"));
        }
    }

    if tool_count > 1 {
        let mut tool_count_second_call = tool_count / 2;
        let mut tools = blank_tools(tool_count_second_call as usize);

        let result = unsafe { get_tool_properties(physical_device, &mut tool_count_second_call, tools.as_mut_ptr()) };

        if result != vk::Result::INCOMPLETE {
            log::info!("getPhysicalDeviceToolPropertiesEXT wrong result code");
            return Ok(TestStatus::fail("Fail"));
        }

        if tool_count_second_call != tool_count / 2 {
            log::info!("Smaller array causes an error");
            return Ok(TestStatus::fail("Fail"));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

fn validate_tools_properties(context: &Context<'_>) -> TestOutcome {
    let get_tool_properties = get_tool_properties_fn(context);
    let physical_device = context.get_physical_device();

    let mut result = true;
    let mut tool_count: u32 = 0;

    let vk_result = unsafe { get_tool_properties(physical_device, &mut tool_count, std::ptr::null_mut()) };
    if vk_result != vk::Result::SUCCESS {
        return Err(TestError::Fail(format!(
            "vkGetPhysicalDeviceToolProperties returned {vk_result:?}"
        )));
    }

    if tool_count > 0 {
        let mut tools = blank_tools(tool_count as usize);

        let vk_result = unsafe { get_tool_properties(physical_device, &mut tool_count, tools.as_mut_ptr()) };
        if vk_result != vk::Result::SUCCESS {
            return Err(TestError::Fail(format!(
                "vkGetPhysicalDeviceToolProperties returned {vk_result:?}"
            )));
        }

        for tool in tools.iter().take(tool_count as usize) {
            let name_size = strnlen(tool.name.as_array());
            let version_size = strnlen(tool.version.as_array());
            let desc_size = strnlen(tool.description.as_array());
            let layer_size = strnlen(tool.layer.as_array());

            result = result && tool.s_type == vk::StructureType::PHYSICAL_DEVICE_TOOL_PROPERTIES;
            result = result && validate_tool_purpose_flag_bits(tool.purposes);
            result = result && (name_size > 0 && name_size < MAX_EXTENSION_NAME_SIZE);
            result = result && (version_size > 0 && version_size < MAX_EXTENSION_NAME_SIZE);
            result = result && (desc_size > 0 && desc_size < MAX_DESCRIPTION_SIZE);
            result = result && (layer_size == 0 || layer_size < MAX_EXTENSION_NAME_SIZE);

            if !result {
                log::info!("Tool validation failed");
                log::info!("Tool name: {}", tool.name.to_string_lossy());
                log::info!("Version: {}", tool.version.to_string_lossy());
                log::info!("Description: {}", tool.description.to_string_lossy());
                log::info!("Purposes: {:?}", tool.purposes);
                if layer_size > 0 {
                    log::info!("Corresponding Layer: {}", tool.layer.to_string_lossy());
                }
                break;
            }
        }
    }

    if result {
        Ok(TestStatus::pass("Pass"))
    } else {
        Ok(TestStatus::fail("Fail"))
    }
}

/// `createToolingInfoTests`
pub fn create_tooling_info_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("tooling_info");

    let cases: [(&str, TestFn); 2] = [
        ("validate_getter", validate_getter),
        ("validate_tools_properties", validate_tools_properties),
    ];
    for (name, test) in cases {
        add_function_case(&mut group, name, check_support, test);
    }

    group
}
