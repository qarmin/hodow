// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiDebugUtilsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `long_labels_*` builds its own instance with VK_EXT_debug_utils enabled and its own
// device on the chosen queue family, so the labels are exercised whether or not the run
// has validation on.

use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtDebugMarkerExtensionDeviceCommands, ExtDebugUtilsExtensionInstanceCommands, Handle};

use super::case_util::{
    add_case, create_custom_instance_with_extension, find_queue_family_index_with_caps, is_instance_extension_available,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, SimpleAllocator};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

/// `TestParams`
#[derive(Clone, Copy)]
struct TestParams {
    required: vk::QueueFlags,
    excluded: vk::QueueFlags,
}

/// `std::string longName(64 * 1024 + 1, 'x')`, NUL-terminated for the C API.
fn long_name() -> Vec<u8> {
    let mut name = vec![b'x'; 64 * 1024 + 1];
    name.push(0);
    name
}

/// `testLongDebugLabelsTest`
fn test_long_debug_labels_test(context: &Context<'_>, params: TestParams) -> TestOutcome {
    // create custom instance to test debug_utils regardles of validation beeing enabled
    let custom = create_custom_instance_with_extension(context, "VK_EXT_debug_utils")?;
    let vki = &custom.instance;
    let physical_device = custom.physical_device;
    let queue_family_index = find_queue_family_index_with_caps(vki, physical_device, params.required, params.excluded)?;

    let queue_priority = [1.0f32];
    let device_queue_create_infos = [vk::DeviceQueueCreateInfo::builder()
        .queue_family_index(queue_family_index)
        .queue_priorities(&queue_priority)
        .build()];

    let device_create_info = vk::DeviceCreateInfo::builder().queue_create_infos(&device_queue_create_infos);

    let device = unsafe { vki.create_device(physical_device, &device_create_info, None) }.vk_check("vkCreateDevice")?;
    let _device_guard = DeviceGuard(&device);
    let queue = unsafe { device.get_device_queue(queue_family_index, 0) };
    let allocator = SimpleAllocator::new(unsafe { vki.get_physical_device_memory_properties(physical_device) });

    let long_name = long_name();

    let usage = vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::TRANSFER_SRC;
    let buffer_info = make_buffer_create_info(1024, usage);
    let test_buffer = BufferWithMemory::new(&device, &allocator, buffer_info, MemoryRequirement::HOST_VISIBLE)?;

    // test extremely long debug object names
    let name_info = vk::DebugUtilsObjectNameInfoEXT {
        object_type: vk::ObjectType::BUFFER,
        object_handle: test_buffer.get().as_raw(),
        object_name: long_name.as_ptr().cast(),
        ..Default::default()
    };
    unsafe { vki.set_debug_utils_object_name_ext(device.handle(), &name_info) }
        .vk_check("vkSetDebugUtilsObjectNameEXT")?;

    let insert_label_info = vk::DebugUtilsLabelEXT {
        label_name: long_name.as_ptr().cast(),
        ..Default::default()
    };

    let cmd_pool_create_info = vk::CommandPoolCreateInfo::builder()
        .flags(vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)
        .queue_family_index(queue_family_index);
    let cmd_pool = Unique::new(
        &device,
        unsafe { device.create_command_pool(&cmd_pool_create_info, None) }.vk_check("vkCreateCommandPool")?,
    );
    let cmd_buffer = allocate_command_buffer(&device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    begin_command_buffer(&device, *cmd_buffer)?;
    unsafe { vki.cmd_insert_debug_utils_label_ext(*cmd_buffer, &insert_label_info) };
    if params
        .required
        .intersects(vk::QueueFlags::GRAPHICS | vk::QueueFlags::COMPUTE | vk::QueueFlags::TRANSFER)
    {
        unsafe { device.cmd_fill_buffer(*cmd_buffer, test_buffer.get(), 0, vk::WHOLE_SIZE, 1985) };
    }
    end_command_buffer(&device, *cmd_buffer)?;

    unsafe { vki.queue_insert_debug_utils_label_ext(queue, &insert_label_info) };

    submit_commands_and_wait(&device, queue, *cmd_buffer)?;

    Ok(TestStatus::pass("Pass"))
}

/// Destroys the custom device when it leaves scope; the objects created from it are
/// declared after it and so are dropped before it.
struct DeviceGuard<'a>(&'a Device);

impl Drop for DeviceGuard<'_> {
    fn drop(&mut self) {
        unsafe { self.0.destroy_device(None) };
    }
}

/// `testDebugMarker`
fn test_debug_marker(context: &Context<'_>, _params: TestParams) -> TestOutcome {
    let vk = context.get_device();

    let long_name = long_name();

    // create a small buffer to name/tag
    let usage = vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::TRANSFER_SRC;
    let buffer_info = make_buffer_create_info(256, usage);
    let test_buffer = BufferWithMemory::new(
        vk,
        context.get_default_allocator(),
        buffer_info,
        MemoryRequirement::HOST_VISIBLE,
    )?;

    // set object name
    let name_info = vk::DebugMarkerObjectNameInfoEXT {
        object_type: vk::DebugReportObjectTypeEXT::BUFFER,
        object: test_buffer.get().as_raw(),
        object_name: long_name.as_ptr().cast(),
        ..Default::default()
    };
    unsafe { vk.debug_marker_set_object_name_ext(&name_info) }.vk_check("vkDebugMarkerSetObjectNameEXT")?;

    // set object tag
    let tag_name = 0xCAFE_BABEu64;
    let tag_data = 0x1234_5678u32;
    let tag_info = vk::DebugMarkerObjectTagInfoEXT {
        object_type: name_info.object_type,
        object: name_info.object,
        tag_name,
        tag_size: std::mem::size_of::<u32>(),
        tag: (&raw const tag_data).cast::<c_void>(),
        ..Default::default()
    };
    unsafe { vk.debug_marker_set_object_tag_ext(&tag_info) }.vk_check("vkDebugMarkerSetObjectTagEXT")?;

    // create command pool and buffer and use marker commands
    let cmd_pool = make_command_pool(vk, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    let marker_info = vk::DebugMarkerMarkerInfoEXT {
        marker_name: long_name.as_ptr().cast(),
        color: [0.0, 1.0, 0.0, 1.0],
        ..Default::default()
    };

    // do a simple command between begin/insert/end
    begin_command_buffer(vk, *cmd_buffer)?;
    unsafe {
        vk.cmd_debug_marker_begin_ext(*cmd_buffer, &marker_info);
        vk.cmd_fill_buffer(*cmd_buffer, test_buffer.get(), 0, vk::WHOLE_SIZE, 0xDEAD_BEEF);
        vk.cmd_debug_marker_insert_ext(*cmd_buffer, &marker_info);
        vk.cmd_debug_marker_end_ext(*cmd_buffer);
    }
    end_command_buffer(vk, *cmd_buffer)?;

    submit_commands_and_wait(vk, context.get_universal_queue(), *cmd_buffer)?;

    Ok(TestStatus::pass("Pass"))
}

/// `checkDebugUtilsSupport`
fn check_debug_utils_support(context: &Context<'_>, params: TestParams) -> Result<(), TestError> {
    if !is_instance_extension_available(context, "VK_EXT_debug_utils") {
        return Err(TestError::NotSupported(
            "VK_EXT_debug_utils is not supported by this implementation".to_string(),
        ));
    }

    find_queue_family_index_with_caps(
        context.get_instance(),
        context.get_physical_device(),
        params.required,
        params.excluded,
    )?;
    Ok(())
}

/// `checkDebugMarkerSupport`
fn check_debug_marker_support(context: &Context<'_>, _params: TestParams) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_debug_marker")
}

struct DebugUtilsCase {
    name: &'static str,
    params: TestParams,
    check_support: fn(&Context<'_>, TestParams) -> Result<(), TestError>,
    test: fn(&Context<'_>, TestParams) -> TestOutcome,
}

impl TestCase for DebugUtilsCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        (self.check_support)(context, self.params)
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DebugUtilsInstance {
            context,
            params: self.params,
            test: self.test,
        })
    }
}

struct DebugUtilsInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
    test: fn(&Context<'_>, TestParams) -> TestOutcome,
}

impl TestInstance for DebugUtilsInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        (self.test)(self.context, self.params)
    }
}

/// `createDebugUtilsTests`
pub fn create_debug_utils_tests() -> TestCaseGroup {
    let mut debug_utils_tests = TestCaseGroup::new("debug_utils");

    let mut params = TestParams {
        required: vk::QueueFlags::GRAPHICS,
        excluded: vk::QueueFlags::empty(),
    };
    add_case(
        &mut debug_utils_tests,
        DebugUtilsCase {
            name: "long_labels_graphics",
            params,
            check_support: check_debug_utils_support,
            test: test_long_debug_labels_test,
        },
    );

    add_case(
        &mut debug_utils_tests,
        DebugUtilsCase {
            name: "debug_marker_graphics",
            params,
            check_support: check_debug_marker_support,
            test: test_debug_marker,
        },
    );

    params.required = vk::QueueFlags::TRANSFER;
    params.excluded = vk::QueueFlags::GRAPHICS | vk::QueueFlags::COMPUTE;
    add_case(
        &mut debug_utils_tests,
        DebugUtilsCase {
            name: "long_labels_transfer",
            params,
            check_support: check_debug_utils_support,
            test: test_long_debug_labels_test,
        },
    );

    params.required = vk::QueueFlags::VIDEO_DECODE_KHR;
    params.excluded = vk::QueueFlags::GRAPHICS | vk::QueueFlags::COMPUTE;
    add_case(
        &mut debug_utils_tests,
        DebugUtilsCase {
            name: "long_labels_video_decode",
            params,
            check_support: check_debug_utils_support,
            test: test_long_debug_labels_test,
        },
    );

    debug_utils_tests
}
