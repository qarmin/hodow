// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiCommandBuffersTests.cpp (`executeNestedBufferTest`, `executeMultipleLevelsNestedBufferTest`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::case_util::add_function_case;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{end_command_buffer, submit_commands_and_wait};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCaseGroup};

fn check_nested_command_buffer_support(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_nested_command_buffer")?;
    let mut features = vk::PhysicalDeviceNestedCommandBufferFeaturesEXT::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    if features.nested_command_buffer == vk::FALSE {
        return Err(TestError::NotSupported(
            "nestedCommandBuffer is not supported".to_string(),
        ));
    }
    Ok(())
}

fn check_nested_command_buffer_depth_support(context: &Context<'_>) -> Result<(), TestError> {
    check_nested_command_buffer_support(context)?;
    let mut properties = vk::PhysicalDeviceNestedCommandBufferPropertiesEXT::default();
    let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
    unsafe {
        context
            .get_instance()
            .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
    };
    if properties.max_command_buffer_nesting_level <= 1 {
        return Err(TestError::NotSupported(
            "nestedCommandBuffer with nesting level greater than 1 is not supported".to_string(),
        ));
    }
    Ok(())
}

fn begin_secondary(device: &Device, cmd: vk::CommandBuffer) -> Result<(), TestError> {
    let inheritance_info = vk::CommandBufferInheritanceInfo::default();
    let begin_info = vk::CommandBufferBeginInfo::builder()
        .flags(vk::CommandBufferUsageFlags::empty())
        .inheritance_info(&inheritance_info);
    unsafe { device.begin_command_buffer(cmd, &begin_info) }.vk_check("vkBeginCommandBuffer")
}

fn begin_primary(device: &Device, cmd: vk::CommandBuffer) -> Result<(), TestError> {
    let begin_info = vk::CommandBufferBeginInfo::builder().flags(vk::CommandBufferUsageFlags::empty());
    unsafe { device.begin_command_buffer(cmd, &begin_info) }.vk_check("vkBeginCommandBuffer")
}

/// `executeNestedBufferTest`
fn execute_nested_buffer_test(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;

    let prim_cmd_buf = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let sec_cmd_buf = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
    let nested_cmd_buf = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

    let event = Unique::new(
        device,
        unsafe { device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
    );
    unsafe { device.reset_event(*event) }.vk_check("vkResetEvent")?;

    begin_secondary(device, *nested_cmd_buf)?;
    unsafe { device.cmd_set_event(*nested_cmd_buf, *event, vk::PipelineStageFlags::ALL_COMMANDS) };
    end_command_buffer(device, *nested_cmd_buf)?;

    begin_secondary(device, *sec_cmd_buf)?;
    unsafe { device.cmd_execute_commands(*sec_cmd_buf, &[*nested_cmd_buf]) };
    end_command_buffer(device, *sec_cmd_buf)?;

    begin_primary(device, *prim_cmd_buf)?;
    unsafe { device.cmd_execute_commands(*prim_cmd_buf, &[*sec_cmd_buf]) };
    end_command_buffer(device, *prim_cmd_buf)?;

    submit_commands_and_wait(device, queue, *prim_cmd_buf)?;

    if unsafe { device.get_event_status(*event) } == Ok(vk::SuccessCode::EVENT_SET) {
        return Ok(TestStatus::pass("executeNestedBufferTest succeeded"));
    }
    Ok(TestStatus::fail("executeNestedBufferTest FAILED"))
}

/// `executeMultipleLevelsNestedBufferTest`
fn execute_multiple_levels_nested_buffer_test(context: &Context<'_>) -> TestOutcome {
    const BUFFER_COUNT: usize = 2;
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;

    let prim_cmd_buf = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let mut nested_buffers = Vec::with_capacity(BUFFER_COUNT);
    for _ in 0..BUFFER_COUNT {
        nested_buffers.push(allocate_command_buffer(
            device,
            *cmd_pool,
            vk::CommandBufferLevel::SECONDARY,
        )?);
    }

    let event = Unique::new(
        device,
        unsafe { device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?,
    );
    unsafe { device.reset_event(*event) }.vk_check("vkResetEvent")?;

    for ndx in 0..BUFFER_COUNT {
        begin_secondary(device, *nested_buffers[ndx])?;
        if ndx == 0 {
            unsafe { device.cmd_set_event(*nested_buffers[ndx], *event, vk::PipelineStageFlags::ALL_COMMANDS) };
        } else {
            unsafe { device.cmd_execute_commands(*nested_buffers[ndx], &[*nested_buffers[ndx - 1]]) };
        }
        end_command_buffer(device, *nested_buffers[ndx])?;
    }

    begin_primary(device, *prim_cmd_buf)?;
    unsafe { device.cmd_execute_commands(*prim_cmd_buf, &[*nested_buffers[BUFFER_COUNT - 1]]) };
    end_command_buffer(device, *prim_cmd_buf)?;

    submit_commands_and_wait(device, queue, *prim_cmd_buf)?;

    if unsafe { device.get_event_status(*event) } == Ok(vk::SuccessCode::EVENT_SET) {
        return Ok(TestStatus::pass("executeMultipleLevelsNestedBufferTest succeeded"));
    }
    Ok(TestStatus::fail("executeMultipleLevelsNestedBufferTest FAILED"))
}

/// The `nested_execute*` cases of `createCommandBuffersTests`.
pub fn add_nested_execute_tests(group: &mut TestCaseGroup) {
    add_function_case(
        group,
        "nested_execute",
        check_nested_command_buffer_support,
        execute_nested_buffer_test,
    );
    add_function_case(
        group,
        "nested_execute_multiple_levels",
        check_nested_command_buffer_depth_support,
        execute_multiple_levels_nested_buffer_test,
    );
}
