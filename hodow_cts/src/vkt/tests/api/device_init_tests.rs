// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiDeviceInitializationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Ported: the instance-creation cases, `enumerate_devices_alloc_leak`, and the device
// creation cases up to and including `create_device_queue_priorities`; global priority,
// features2 and the queue2/protected family live in `device_init_extra_tests.rs`. The rest
// of `dEQP-VK.api.device_init` (`create_device_unsupported_features`) is registered as a
// stub, so the case tree matches upstream and `cts-coverage` does not count it.
//
// `createCustomInstanceFromContext` is `case_util::create_custom_instance`: an instance of
// the run's API version with no extensions, and the context's physical device inside it.

use std::ffi::{CString, c_char};

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::EntryV1_1;

use super::case_util::{add_function_case, add_function_case_no_support, create_custom_instance};
use super::device_init_extra_tests as extra;
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::alloc_callback_util::AllocationCallbackRecorder;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::mem_util::{MemoryRequirement, SimpleAllocator, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCaseGroup};

/// `VK_MAKE_API_VERSION`
fn make_api_version(variant: u32, major: u32, minor: u32, patch: u32) -> u32 {
    (variant << 29) | (major << 22) | (minor << 12) | patch
}

/// `vk::unpackVersion` as (variant, major, minor, patch).
fn unpack_version(version: u32) -> (u32, u32, u32, u32) {
    (
        version >> 29,
        (version >> 22) & 0x7f,
        (version >> 12) & 0x3ff,
        version & 0xfff,
    )
}

/// Destroys a device created through a custom instance when it leaves scope.
struct DeviceGuard(Device);

impl Drop for DeviceGuard {
    fn drop(&mut self) {
        unsafe { self.0.destroy_device(None) };
    }
}

/// One `VkApplicationInfo`, with its strings owned.
struct AppInfoSpec {
    app_name: Option<CString>,
    app_version: u32,
    engine_name: Option<CString>,
    engine_version: u32,
    api_version: u32,
}

impl AppInfoSpec {
    fn new(
        app_name: Option<&str>,
        app_version: u32,
        engine_name: Option<&str>,
        engine_version: u32,
        api_version: u32,
    ) -> Self {
        Self {
            app_name: app_name.map(|s| CString::new(s).expect("no interior NUL")),
            app_version,
            engine_name: engine_name.map(|s| CString::new(s).expect("no interior NUL")),
            engine_version,
            api_version,
        }
    }

    fn to_app_info(&self) -> vk::ApplicationInfo {
        vk::ApplicationInfo {
            application_name: self.app_name.as_ref().map_or(std::ptr::null(), |s| s.as_ptr()),
            application_version: self.app_version,
            engine_name: self.engine_name.as_ref().map_or(std::ptr::null(), |s| s.as_ptr()),
            engine_version: self.engine_version,
            api_version: self.api_version,
            ..Default::default()
        }
    }
}

/// `createInstanceTest`
fn create_instance_test(context: &Context<'_>) -> TestOutcome {
    let mut result_collector = ResultCollector::new("");
    let app_names = [
        Some("appName"),
        None,
        Some(""),
        Some("app, name"),
        Some("app(\"name\""),
        Some("app~!@#$%^&*()_+name"),
        Some("app\nName"),
        Some("app\r\nName"),
    ];
    let engine_names = [
        Some("engineName"),
        None,
        Some(""),
        Some("engine. name"),
        Some("engine\"(name)"),
        Some("eng~!@#$%^&*()_+name"),
        Some("engine\nName"),
        Some("engine\r\nName"),
    ];
    let patch_numbers = [0u32, 1, 2, 3, 4, 5, 13, 4094, 4095];
    let app_versions = [0u32, 1, u32::MAX];
    let engine_versions = [0u32, 1, u32::MAX];
    let api_version = context.get_platform().api_version;
    let mut app_infos: Vec<AppInfoSpec> = Vec::new();

    // test over appName
    for app_name in app_names {
        app_infos.push(AppInfoSpec::new(app_name, 0, Some("engineName"), 0, api_version));
    }

    // test over engineName
    for engine_name in engine_names {
        app_infos.push(AppInfoSpec::new(Some("appName"), 0, engine_name, 0, api_version));
    }

    // test over appVersion
    for app_version in app_versions {
        app_infos.push(AppInfoSpec::new(
            Some("appName"),
            app_version,
            Some("engineName"),
            0,
            api_version,
        ));
    }

    // test over engineVersion
    for engine_version in engine_versions {
        app_infos.push(AppInfoSpec::new(
            Some("appName"),
            0,
            Some("engineName"),
            engine_version,
            api_version,
        ));
    }

    let (variant_num, major_num, minor_num, _) = unpack_version(api_version);

    // patch component of api version checking (should be ignored by implementation)
    for patch in patch_numbers {
        app_infos.push(AppInfoSpec::new(
            Some("appName"),
            0,
            Some("engineName"),
            0,
            make_api_version(variant_num, major_num, minor_num, patch),
        ));
    }

    // test when apiVersion is 0
    app_infos.push(AppInfoSpec::new(Some("appName"), 0, Some("engineName"), 0, 0));

    // run the tests!
    let entry = &context.get_platform().entry;
    for (app_info_ndx, spec) in app_infos.iter().enumerate() {
        let app_info = spec.to_app_info();
        let instance_create_info = vk::InstanceCreateInfo::builder().application_info(&app_info);

        log::info!("Creating instance with appInfo #{app_info_ndx}: {app_info:?}");

        match unsafe { entry.create_instance(&instance_create_info, None) } {
            Ok(instance) => {
                unsafe { instance.destroy_instance(None) };
                log::info!("Succeeded");
            }
            Err(err) => result_collector.fail(format!("Failed, Error code: {err:?}")),
        }
    }

    Ok(result_collector.to_status())
}

/// `createInstanceWithInvalidApiVersionTest`
fn create_instance_with_invalid_api_version_test(context: &Context<'_>) -> TestOutcome {
    let mut result_collector = ResultCollector::new("");
    let entry = &context.get_platform().entry;

    let instance_api_version = unsafe { entry.enumerate_instance_version() }.vk_check("vkEnumerateInstanceVersion")?;

    let (variant_num, major_num, minor_num, patch_num) = unpack_version(instance_api_version);

    let invalid_api_variant = (1u32 << 3) - 1;
    let invalid_major_version = (1u32 << 7) - 1;
    let invalid_minor_version = (1u32 << 10) - 1;
    let invalid_api_versions = [
        (invalid_api_variant, invalid_major_version, minor_num, patch_num),
        (variant_num, invalid_major_version, minor_num, patch_num),
        (variant_num, major_num, invalid_minor_version, patch_num),
    ];

    for &(variant, major, minor, patch) in &invalid_api_versions {
        let spec = AppInfoSpec::new(
            Some("appName"),
            0,
            Some("engineName"),
            0,
            make_api_version(variant, major, minor, patch),
        );
        let app_info = spec.to_app_info();
        let instance_create_info = vk::InstanceCreateInfo::builder().application_info(&app_info);

        log::info!(
            "API version reported by enumerateInstanceVersion: {major_num}.{minor_num}.{patch_num}, api version used to create instance: {major}.{minor}.{patch} (variant {variant})"
        );

        let result = unsafe { entry.create_instance(&instance_create_info, None) };

        if major_num == 1 && minor_num == 0 {
            match result {
                Err(vk::ErrorCode::INCOMPATIBLE_DRIVER) => {
                    log::info!("Pass, instance creation with invalid apiVersion is rejected")
                }
                Err(_) => result_collector.fail("Fail, instance creation with invalid apiVersion is not rejected"),
                Ok(instance) => {
                    unsafe { instance.destroy_instance(None) };
                    result_collector.fail("Fail, instance creation with invalid apiVersion is not rejected");
                }
            }
        } else if major_num == 1 && minor_num >= 1 {
            match result {
                Ok(instance) => {
                    unsafe { instance.destroy_instance(None) };
                    log::info!("Pass, instance creation with nonstandard apiVersion succeeds for Vulkan 1.1");
                }
                Err(vk::ErrorCode::INCOMPATIBLE_DRIVER) => result_collector
                    .fail("Fail, instance creation must not return VK_ERROR_INCOMPATIBLE_DRIVER for Vulkan 1.1"),
                Err(err) => result_collector.fail(format!("Fail, createInstance failed with {err:?}")),
            }
        } else if let Ok(instance) = result {
            unsafe { instance.destroy_instance(None) };
        }
    }

    Ok(result_collector.to_status())
}

/// `createInstanceWithNullApplicationInfoTest`
fn create_instance_with_null_application_info_test(context: &Context<'_>) -> TestOutcome {
    let mut result_collector = ResultCollector::new("");

    let instance_create_info = vk::InstanceCreateInfo::builder();

    log::info!("Creating instance with NULL pApplicationInfo");

    match unsafe {
        context
            .get_platform()
            .entry
            .create_instance(&instance_create_info, None)
    } {
        Ok(instance) => {
            unsafe { instance.destroy_instance(None) };
            log::info!("Succeeded");
        }
        Err(err) => result_collector.fail(format!("Failed, Error code: {err:?}")),
    }

    Ok(result_collector.to_status())
}

/// `createInstanceWithUnsupportedExtensionsTest`
fn create_instance_with_unsupported_extensions_test(context: &Context<'_>) -> TestOutcome {
    let enabled_extensions = [c"VK_UNSUPPORTED_EXTENSION", c"THIS_IS_NOT_AN_EXTENSION"];
    let spec = AppInfoSpec::new(
        Some("appName"),
        0,
        Some("engineName"),
        0,
        context.get_platform().api_version,
    );
    let app_info = spec.to_app_info();
    let extension_ptrs: Vec<*const c_char> = enabled_extensions.iter().map(|e| e.as_ptr()).collect();

    let instance_create_info = vk::InstanceCreateInfo::builder()
        .application_info(&app_info)
        .enabled_extension_names(&extension_ptrs);

    log::info!("Enabled extensions are: ");

    for extension in enabled_extensions {
        log::info!("{}", extension.to_string_lossy());
    }

    match unsafe {
        context
            .get_platform()
            .entry
            .create_instance(&instance_create_info, None)
    } {
        Err(vk::ErrorCode::EXTENSION_NOT_PRESENT) => Ok(TestStatus::pass(
            "Pass, creating instance with unsupported extension was rejected.",
        )),
        Ok(instance) => {
            unsafe { instance.destroy_instance(None) };
            Ok(TestStatus::fail(
                "Fail, creating instance with unsupported extensions succeeded.",
            ))
        }
        Err(_) => Ok(TestStatus::fail(
            "Fail, creating instance with unsupported extensions succeeded.",
        )),
    }
}

const UTF8ABUSE_MAX: usize = 7;

/// `getUTF8AbuseString`, as the raw bytes (several of them are not valid UTF-8).
fn get_utf8_abuse_string(index: usize) -> Vec<u8> {
    match index {
        // UTF8ABUSE_LONGNAME: Generate a long name.
        0 => vec![b'k'; 65535],

        // UTF8ABUSE_BADNAMES: Various illegal code points in utf-8
        1 => b"Illegal bytes in UTF-8: \xc0 \xc1 \xf5 \xf6 \xf7 \xf8 \xf9 \xfa \xfb \xfc \xfd \xfe \xffillegal surrogates: \xed\xad\xbf \xed\xbe\x80".to_vec(),

        // UTF8ABUSE_OVERLONGNUL: Zero encoded as overlong, not exactly legal but often supported to differentiate from terminating zero
        2 => b"UTF-8 encoded nul \xc0\x80 (should not end name)".to_vec(),

        // UTF8ABUSE_OVERLONG: Some overlong encodings
        3 => b"UTF-8 overlong \xf0\x82\x82\xac \xfc\x83\xbf\xbf\xbf\xbf \xf8\x87\xbf\xbf\xbf \xf0\x8f\xbf\xbf".to_vec(),

        // UTF8ABUSE_ZALGO: Internet "zalgo" meme "bleeding text"
        4 => b"V\xcc\xb5\xcc\x85\xcc\x94\xcc\x88\xcd\x8a\xcc\x91\xcc\x88\xcd\x91\xcc\x83\xcd\x82\xcc\x83\xcd\x90\xcc\x8a\xcc\x92\xcc\x92\xcd\x8b\xcc\x94\xcd\x9d\xcc\x98\xcc\xab\xcc\xae\xcc\xa9\xcc\xad\xcc\x97\xcc\xb0u\xcc\xb6\xcc\xbe\xcc\x80\xcc\x82\xcc\x84\xcd\x84\xcc\x90\xcd\x86\xcc\x9a\xcd\x84\xcc\x9b\xcd\x86\xcd\x92\xcc\x9a\xcd\x99\xcd\x99\xcc\xbb\xcc\x98\xcd\x8e\xcd\x88\xcd\x9a\xcc\xa6\xcc\x9c\xcc\xab\xcc\x99\xcd\x94\xcd\x99\xcd\x95\xcc\xa5\xcc\xab\xcd\x89l\xcc\xb8\xcc\x8e\xcc\x8b\xcc\x8b\xcc\x9a\xcc\x8e\xcd\x9d\xcc\x80\xcc\xa1\xcc\xad\xcd\x9c\xcc\xba\xcc\x96\xcc\xb3\xcc\xa2\xcd\x8e\xcc\xa2\xcd\x96k\xcc\xb8\xcc\x84\xcd\x81\xcc\xbf\xcc\x8d\xcc\x89\xcc\x85\xcc\x92\xcc\x84\xcc\x90\xcd\x81\xcc\x93\xcd\x90\xcd\x92\xcd\x9d\xcc\x84\xcd\x98\xcd\x9d\xcd\xa0\xcd\x91\xcc\x94\xcc\xb9\xcd\x93\xcc\xa5\xcd\x87\xcc\xad\xcc\xa7\xcd\x96\xcd\x99\xcc\x9d\xcc\xbc\xcd\x96\xcd\x93\xcc\x9d\xcc\x99\xcc\xa8\xcc\xb1\xcd\x85\xcc\xba\xcc\xa7a\xcc\xb8\xcc\x8e\xcc\x81\xcd\x90\xcd\x84\xcd\x8c\xcc\x8c\xcc\x85\xcd\x86\xcc\x84\xcd\x84\xcc\x90\xcc\x84\xcc\x8d\xcd\x99\xcd\x8d\xcc\xb0\xcc\xa3\xcc\xa6\xcd\x89\xcd\x8d\xcd\x87\xcc\x98\xcd\x8d\xcc\xa4\xcd\x9a\xcd\x8e\xcc\xab\xcc\xb9\xcc\xac\xcc\xa2\xcd\x87\xcc\xa0\xcc\xb3\xcd\x89\xcc\xb9\xcc\xa7\xcc\xa6\xcd\x89\xcd\x95n\xcc\xb8\xcd\x8a\xcc\x8a\xcd\x82\xcc\x9b\xcd\x81\xcd\x90\xcc\x85\xcc\x9b\xcd\x80\xcd\x91\xcd\x9b\xcc\x81\xcd\x81\xcc\x9a\xcc\xb3\xcd\x9c\xcc\x9e\xcc\x9d\xcd\x99\xcc\xa2\xcd\x93\xcd\x96\xcc\x97\xff".to_vec(),

        // UTF8ABUSE_CHINESE: Some Chinese glyphs.
        // "English equivalent: The devil is in the details", https://en.wikiquote.org/wiki/Chinese_proverbs
        5 => {
            b"\xe8\xaf\xbb\xe4\xb9\xa6\xe9\xa1\xbb\xe7\x94\xa8\xe6\x84\x8f\xef\xbc\x8c\xe4\xb8\x80\xe5\xad\x97\xe5\x80\xbc\xe5\x8d\x83\xe9\x87\x91 ".to_vec()
        }

        // UTF8ABUSE_EMPTY: Also try an empty string.
        _ => Vec::new(),
    }
}

/// `createInstanceWithExtensionNameAbuseTest`
fn create_instance_with_extension_name_abuse_test(context: &Context<'_>) -> TestOutcome {
    let spec = AppInfoSpec::new(
        Some("appName"),
        0,
        Some("engineName"),
        0,
        context.get_platform().api_version,
    );
    let mut fail_count: u32 = 0;

    for i in 0..UTF8ABUSE_MAX {
        let abuse_string =
            CString::new(get_utf8_abuse_string(i)).map_err(|e| TestError::InternalError(e.to_string()))?;
        let extension_list = [abuse_string.as_ptr()];

        let app_info = spec.to_app_info();
        let instance_create_info = vk::InstanceCreateInfo::builder()
            .application_info(&app_info)
            .enabled_extension_names(&extension_list);

        match unsafe {
            context
                .get_platform()
                .entry
                .create_instance(&instance_create_info, None)
        } {
            Err(vk::ErrorCode::EXTENSION_NOT_PRESENT) => {}
            Err(_) => fail_count += 1,
            Ok(instance) => {
                unsafe { instance.destroy_instance(None) };
                fail_count += 1;
            }
        }
    }

    if fail_count > 0 {
        return Ok(TestStatus::fail(
            "Fail, creating instances with unsupported extensions succeeded.",
        ));
    }

    Ok(TestStatus::pass(
        "Pass, creating instances with unsupported extensions were rejected.",
    ))
}

/// `createInstanceWithLayerNameAbuseTest`
fn create_instance_with_layer_name_abuse_test(context: &Context<'_>) -> TestOutcome {
    let spec = AppInfoSpec::new(
        Some("appName"),
        0,
        Some("engineName"),
        0,
        context.get_platform().api_version,
    );
    let mut fail_count: u32 = 0;

    for i in 0..UTF8ABUSE_MAX {
        let abuse_string =
            CString::new(get_utf8_abuse_string(i)).map_err(|e| TestError::InternalError(e.to_string()))?;
        let layer_list = [abuse_string.as_ptr()];

        let app_info = spec.to_app_info();
        let instance_create_info = vk::InstanceCreateInfo::builder()
            .application_info(&app_info)
            .enabled_layer_names(&layer_list);

        match unsafe {
            context
                .get_platform()
                .entry
                .create_instance(&instance_create_info, None)
        } {
            Err(vk::ErrorCode::LAYER_NOT_PRESENT) => {}
            Err(_) => fail_count += 1,
            Ok(instance) => {
                unsafe { instance.destroy_instance(None) };
                fail_count += 1;
            }
        }
    }

    if fail_count > 0 {
        return Ok(TestStatus::fail(
            "Fail, creating instances with unsupported layers succeeded.",
        ));
    }

    Ok(TestStatus::pass(
        "Pass, creating instances with unsupported layers were rejected.",
    ))
}

/// `enumerateDevicesAllocLeakTest`
fn enumerate_devices_alloc_leak_test(context: &Context<'_>) -> TestOutcome {
    // enumeratePhysicalDevices uses instance-provided allocator
    // and this test checks if all alocated memory is freed
    let recorder = AllocationCallbackRecorder::new();
    let entry = &context.get_platform().entry;
    let spec = AppInfoSpec::new(
        Some("hodow_cts"),
        0,
        Some("hodow_cts"),
        0,
        context.get_platform().api_version,
    );
    let app_info = spec.to_app_info();
    let instance_create_info = vk::InstanceCreateInfo::builder().application_info(&app_info);

    let instance = unsafe { entry.create_instance(&instance_create_info, Some(recorder.callbacks())) }
        .vk_check("vkCreateInstance")?;

    let result = (|| -> TestOutcome {
        unsafe { instance.enumerate_physical_devices() }.vk_check("vkEnumeratePhysicalDevices")?;
        let live_before = recorder.live_allocation_count() as i64;

        match unsafe { instance.enumerate_physical_devices() } {
            Ok(_) => {}
            Err(vk::ErrorCode::OUT_OF_HOST_MEMORY) => {}
            Err(e) => {
                return Err(TestError::InternalError(format!(
                    "vkEnumeratePhysicalDevices returned {e:?}"
                )));
            }
        }

        // make sure that same number of allocations and frees was done
        let allocation_records = recorder.live_allocation_count() as i64 - live_before;
        if allocation_records != 0 {
            return Ok(TestStatus::fail("enumeratePhysicalDevices leaked memory"));
        }
        Ok(TestStatus::pass("Ok"))
    })();

    unsafe { instance.destroy_instance(Some(recorder.callbacks())) };
    result
}

/// A single-queue-family device create info over `queue_infos`, with no extensions or features.
fn create_device_through(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    queue_infos: &[vk::DeviceQueueCreateInfo],
) -> Result<DeviceGuard, vk::ErrorCode> {
    let device_create_info = vk::DeviceCreateInfo::builder().queue_create_infos(queue_infos);
    unsafe { instance.create_device(physical_device, &device_create_info, None) }.map(DeviceGuard)
}

/// `createDeviceTest`
fn create_device_test(context: &Context<'_>) -> TestOutcome {
    let custom = create_custom_instance(context, &[])?;
    let physical_device = custom.physical_device;
    let queue_family_index = 0u32;
    let queue_index = 0u32;
    let queue_priority = [1.0f32];

    let device_queue_create_info = [vk::DeviceQueueCreateInfo::builder()
        .queue_family_index(queue_family_index)
        .queue_priorities(&queue_priority)
        .build()];

    let device = create_device_through(&custom.instance, physical_device, &device_queue_create_info)
        .vk_check("vkCreateDevice")?;
    let queue = unsafe { device.0.get_device_queue(queue_family_index, queue_index) };

    unsafe { device.0.queue_wait_idle(queue) }.vk_check("vkQueueWaitIdle")?;

    Ok(TestStatus::pass("Pass"))
}

/// `createMultipleDevicesTest`
fn create_multiple_devices_test(context: &Context<'_>) -> TestOutcome {
    let mut result_collector = ResultCollector::new("");
    let num_devices = 5;

    // Declared in this order so every device is destroyed before the instance it came from.
    let mut instances = Vec::new();
    let mut devices: Vec<DeviceGuard> = Vec::new();

    for device_ndx in 0..num_devices {
        let custom = create_custom_instance(context, &[])?;
        let physical_device = custom.physical_device;
        let queue_family_index = 0u32;
        let queue_index = 0u32;
        let queue_priority = [1.0f32];
        let device_queue_create_info = [vk::DeviceQueueCreateInfo::builder()
            .queue_family_index(queue_family_index)
            .queue_priorities(&queue_priority)
            .build()];

        let created = create_device_through(&custom.instance, physical_device, &device_queue_create_info);
        instances.push(custom);

        match created {
            Ok(device) => devices.push(device),
            Err(result) => {
                result_collector.fail(format!(
                    "Failed to create Device No.{device_ndx}, Error Code: {result:?}"
                ));
                break;
            }
        }

        let device = devices.last().expect("just pushed");
        let queue = unsafe { device.0.get_device_queue(queue_family_index, queue_index) };
        if let Err(e) = unsafe { device.0.queue_wait_idle(queue) } {
            result_collector.fail(format!("{e:?}"));
            break;
        }
    }

    // `devices` was declared after `instances`, so it drops first.
    Ok(result_collector.to_status())
}

/// `createDeviceWithUnsupportedExtensionsTest`
fn create_device_with_unsupported_extensions_test(context: &Context<'_>) -> TestOutcome {
    let custom = create_custom_instance(context, &[])?;
    let enabled_extensions = [
        c"VK_UNSUPPORTED_EXTENSION",
        c"THIS_IS_NOT_AN_EXTENSION",
        c"VK_DONT_SUPPORT_ME",
    ];
    let queue_priority = [1.0f32];
    let device_queue_create_info = [vk::DeviceQueueCreateInfo::builder()
        .queue_family_index(0)
        .queue_priorities(&queue_priority)
        .build()];
    let extension_ptrs: Vec<*const c_char> = enabled_extensions.iter().map(|e| e.as_ptr()).collect();

    let device_create_info = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&device_queue_create_info)
        .enabled_extension_names(&extension_ptrs);

    log::info!("Enabled extensions are: ");

    for extension in enabled_extensions {
        log::info!("{}", extension.to_string_lossy());
    }

    match unsafe {
        custom
            .instance
            .create_device(custom.physical_device, &device_create_info, None)
    } {
        Err(vk::ErrorCode::EXTENSION_NOT_PRESENT) => Ok(TestStatus::pass(
            "Pass, create device with unsupported extension is rejected.",
        )),
        Ok(device) => {
            unsafe { device.destroy_device(None) };
            Ok(TestStatus::fail(
                "Fail, create device with unsupported extension but succeed.",
            ))
        }
        Err(_) => Ok(TestStatus::fail(
            "Fail, create device with unsupported extension but succeed.",
        )),
    }
}

/// `getGlobalMaxQueueCount`
fn get_global_max_queue_count(queue_family_properties: &[vk::QueueFamilyProperties]) -> u32 {
    queue_family_properties.iter().map(|p| p.queue_count).max().unwrap_or(0)
}

/// `createDeviceWithVariousQueueCountsTest`
fn create_device_with_various_queue_counts_test(context: &Context<'_>) -> TestOutcome {
    let queue_count_diff = 1u32;
    let custom = create_custom_instance(context, &[])?;
    let physical_device = custom.physical_device;
    let queue_family_properties = unsafe {
        custom
            .instance
            .get_physical_device_queue_family_properties(physical_device)
    };
    let queue_priorities = vec![1.0f32; get_global_max_queue_count(&queue_family_properties) as usize];
    let mut device_queue_create_infos: Vec<vk::DeviceQueueCreateInfo> = Vec::new();

    for (queue_family_ndx, family) in queue_family_properties.iter().enumerate() {
        let max_queue_count = family.queue_count;

        let mut queue_count = 1;
        while queue_count <= max_queue_count {
            device_queue_create_infos.push(vk::DeviceQueueCreateInfo {
                queue_family_index: queue_family_ndx as u32,
                queue_count,
                queue_priorities: queue_priorities.as_ptr(),
                ..Default::default()
            });
            queue_count += queue_count_diff;
        }
    }

    for queue_create_info in &device_queue_create_infos {
        let device = create_device_through(
            &custom.instance,
            physical_device,
            std::slice::from_ref(queue_create_info),
        )
        .vk_check("vkCreateDevice")?;
        let queue_family_index = queue_create_info.queue_family_index;
        let queue_count = queue_create_info.queue_count;

        for queue_index in 0..queue_count {
            let queue = unsafe { device.0.get_device_queue(queue_family_index, queue_index) };

            if queue == vk::Queue::null() {
                return Err(TestError::Fail("queue is null".to_string()));
            }

            if let Err(result) = unsafe { device.0.queue_wait_idle(queue) } {
                log::info!(
                    "vkQueueWaitIdle failed,  queueIndex = {queue_index}, queueFamilyIndex = {queue_family_index}, queueCount = {queue_count}, Error Code: {result:?}"
                );
                return Ok(TestStatus::fail("Fail"));
            }
        }
    }
    Ok(TestStatus::pass("Pass"))
}

/// `makeSpanningQueuePriorities`
fn make_spanning_queue_priorities(queue_count: u32) -> Vec<f32> {
    (0..queue_count)
        .map(|queue_ndx| {
            if queue_count == 1 {
                1.0
            } else {
                queue_ndx as f32 / (queue_count - 1) as f32
            }
        })
        .collect()
}

/// `createDeviceWithQueuePrioritiesTest`
fn create_device_with_queue_priorities_test(context: &Context<'_>) -> TestOutcome {
    let custom = create_custom_instance(context, &[])?;
    let physical_device = custom.physical_device;
    let queue_family_properties = unsafe {
        custom
            .instance
            .get_physical_device_queue_family_properties(physical_device)
    };

    let properties = unsafe { custom.instance.get_physical_device_properties(physical_device) };
    let discrete_queue_priorities = properties.limits.discrete_queue_priorities;

    log::info!("VkPhysicalDeviceLimits::discreteQueuePriorities = {discrete_queue_priorities}");

    for (queue_family_ndx, family) in queue_family_properties.iter().enumerate() {
        let queue_family_ndx = queue_family_ndx as u32;
        let queue_count = family.queue_count.min(discrete_queue_priorities + 1);
        let queue_priorities = make_spanning_queue_priorities(queue_count);

        let queue_create_info = vk::DeviceQueueCreateInfo {
            queue_family_index: queue_family_ndx,
            queue_count,
            queue_priorities: queue_priorities.as_ptr(),
            ..Default::default()
        };

        let device = create_device_through(
            &custom.instance,
            physical_device,
            std::slice::from_ref(&queue_create_info),
        )
        .vk_check("vkCreateDevice")?;

        for queue_index in 0..queue_count {
            let queue = unsafe { device.0.get_device_queue(queue_family_ndx, queue_index) };

            if queue == vk::Queue::null() {
                return Err(TestError::Fail("queue is null".to_string()));
            }

            if let Err(result) = unsafe { device.0.queue_wait_idle(queue) } {
                log::info!(
                    "vkQueueWaitIdle failed, queueFamilyIndex = {queue_family_ndx}, queueIndex = {queue_index}, priority = {}, Error Code: {result:?}",
                    queue_priorities[queue_index as usize]
                );
                return Ok(TestStatus::fail("Fail"));
            }
        }
    }
    Ok(TestStatus::pass("Pass"))
}

/// `createDeviceWithQueuePrioritiesContentionTest`
fn create_device_with_queue_priorities_contention_test(context: &Context<'_>) -> TestOutcome {
    let custom = create_custom_instance(context, &[])?;
    let physical_device = custom.physical_device;
    let queue_family_properties = unsafe {
        custom
            .instance
            .get_physical_device_queue_family_properties(physical_device)
    };

    let properties = unsafe { custom.instance.get_physical_device_properties(physical_device) };
    let discrete_queue_priorities = properties.limits.discrete_queue_priorities;

    let buffer_size: vk::DeviceSize = 4 * 1024 * 1024;
    let element_count = (buffer_size / std::mem::size_of::<u32>() as u64) as u32;
    let transfer_capable = vk::QueueFlags::GRAPHICS | vk::QueueFlags::COMPUTE | vk::QueueFlags::TRANSFER;
    let mut any_family_tested = false;
    let mut any_failed = false;

    for (queue_family_ndx, family) in queue_family_properties.iter().enumerate() {
        let queue_family_ndx = queue_family_ndx as u32;
        if !family.queue_flags.intersects(transfer_capable) {
            continue;
        }

        let queue_count = family.queue_count.min(discrete_queue_priorities + 1);

        if queue_count < 2 {
            continue; // Nothing to contend with a single queue
        }

        any_family_tested = true;

        let queue_priorities = make_spanning_queue_priorities(queue_count);

        let queue_create_info = vk::DeviceQueueCreateInfo {
            queue_family_index: queue_family_ndx,
            queue_count,
            queue_priorities: queue_priorities.as_ptr(),
            ..Default::default()
        };

        let device = create_device_through(
            &custom.instance,
            physical_device,
            std::slice::from_ref(&queue_create_info),
        )
        .vk_check("vkCreateDevice")?;
        let vkd = &device.0;
        let allocator =
            SimpleAllocator::new(unsafe { custom.instance.get_physical_device_memory_properties(physical_device) });

        let command_pool = make_command_pool(vkd, queue_family_ndx)?;

        let mut buffers = Vec::with_capacity(queue_count as usize);
        let mut command_buffers = Vec::with_capacity(queue_count as usize);
        let mut fences: Vec<Unique<'_, vk::Fence>> = Vec::with_capacity(queue_count as usize);
        let mut fill_values = Vec::with_capacity(queue_count as usize);

        // Record every queue's command buffer up front
        for queue_index in 0..queue_count {
            let buffer_create_info = make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST);
            buffers.push(BufferWithMemory::new(
                vkd,
                &allocator,
                buffer_create_info,
                MemoryRequirement::HOST_VISIBLE,
            )?);
            let command_buffer = allocate_command_buffer(vkd, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
            let fill_value = 0xACE0_0000u32 | queue_index;

            begin_command_buffer(vkd, *command_buffer)?;
            unsafe {
                vkd.cmd_fill_buffer(
                    *command_buffer,
                    buffers[queue_index as usize].get(),
                    0,
                    buffer_size,
                    fill_value,
                )
            };
            end_command_buffer(vkd, *command_buffer)?;

            command_buffers.push(command_buffer);
            fill_values.push(fill_value);
        }

        // Submit to every queue before waiting on any of them so the differently prioritized
        // queues have overlapping work in flight
        for queue_index in 0..queue_count {
            let queue = unsafe { vkd.get_device_queue(queue_family_ndx, queue_index) };

            // `submitCommands`
            let fence = Unique::new(
                vkd,
                unsafe { vkd.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
            );
            let cmd_buffers = [*command_buffers[queue_index as usize]];
            let submit_info = vk::SubmitInfo::builder().command_buffers(&cmd_buffers);
            unsafe { vkd.queue_submit(queue, &[submit_info], *fence) }.vk_check("vkQueueSubmit")?;
            fences.push(fence);
        }

        let fence_handles: Vec<vk::Fence> = fences.iter().map(|f| f.get()).collect();
        unsafe { vkd.wait_for_fences(&fence_handles, true, u64::MAX) }.vk_check("vkWaitForFences")?;

        for queue_index in 0..queue_count as usize {
            let alloc = buffers[queue_index].get_allocation();
            invalidate_alloc(vkd, alloc)?;

            let data =
                unsafe { std::slice::from_raw_parts(alloc.get_host_ptr().cast::<u32>(), element_count as usize) };

            for (element_ndx, &value) in data.iter().enumerate() {
                if value != fill_values[queue_index] {
                    log::info!(
                        "Corrupted data for queueFamilyIndex = {queue_family_ndx}, queueIndex = {queue_index}, priority = {}, element {element_ndx}: expected {}, got {value}",
                        queue_priorities[queue_index],
                        fill_values[queue_index]
                    );
                    any_failed = true;
                }
            }
        }
    }

    if !any_family_tested {
        return Err(TestError::NotSupported(
            "No queue family exposes enough queues to test priority contention".to_string(),
        ));
    }

    if any_failed {
        return Ok(TestStatus::fail(
            "Fail, corrupted data under priority-differentiated contention",
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `addFunctionCaseInNewSubgroup`
fn add_in_new_subgroup(group: &mut TestCaseGroup, subgroup_name: &str, test: super::case_util::TestFn) {
    let mut subgroup = TestCaseGroup::new(subgroup_name);
    add_function_case_no_support(&mut subgroup, "basic", test);
    group.add_child(subgroup);
}

/// `addFunctionCaseInNewSubgroup` with a support check.
fn add_checked_in_new_subgroup(
    group: &mut TestCaseGroup,
    subgroup_name: &str,
    check_support: super::case_util::CheckSupportFn,
    test: super::case_util::TestFn,
) {
    let mut subgroup = TestCaseGroup::new(subgroup_name);
    add_function_case(&mut subgroup, "basic", check_support, test);
    group.add_child(subgroup);
}

/// `createDeviceInitializationTests`
pub fn create_device_initialization_tests() -> TestCaseGroup {
    let mut device_initialization_tests = TestCaseGroup::new("device_init");
    let g = &mut device_initialization_tests;

    add_in_new_subgroup(g, "create_instance_name_version", create_instance_test);
    add_in_new_subgroup(
        g,
        "create_instance_invalid_api_version",
        create_instance_with_invalid_api_version_test,
    );
    add_in_new_subgroup(
        g,
        "create_instance_null_appinfo",
        create_instance_with_null_application_info_test,
    );
    add_in_new_subgroup(
        g,
        "create_instance_unsupported_extensions",
        create_instance_with_unsupported_extensions_test,
    );
    add_in_new_subgroup(
        g,
        "create_instance_extension_name_abuse",
        create_instance_with_extension_name_abuse_test,
    );
    add_in_new_subgroup(
        g,
        "create_instance_layer_name_abuse",
        create_instance_with_layer_name_abuse_test,
    );
    add_in_new_subgroup(g, "enumerate_devices_alloc_leak", enumerate_devices_alloc_leak_test);
    add_in_new_subgroup(g, "create_device", create_device_test);
    add_in_new_subgroup(g, "create_multiple_devices", create_multiple_devices_test);
    add_in_new_subgroup(
        g,
        "create_device_unsupported_extensions",
        create_device_with_unsupported_extensions_test,
    );
    add_in_new_subgroup(
        g,
        "create_device_various_queue_counts",
        create_device_with_various_queue_counts_test,
    );
    {
        let mut subgroup = TestCaseGroup::new("create_device_queue_priorities");
        add_function_case_no_support(&mut subgroup, "basic", create_device_with_queue_priorities_test);
        add_function_case_no_support(
            &mut subgroup,
            "concurrent_submission",
            create_device_with_queue_priorities_contention_test,
        );
        g.add_child(subgroup);
    }
    add_checked_in_new_subgroup(
        g,
        "create_device_global_priority",
        extra::check_global_priority_support_ext,
        extra::create_device_with_global_priority_test_ext,
    );
    add_checked_in_new_subgroup(
        g,
        "create_device_global_priority_khr",
        extra::check_global_priority_support_khr,
        extra::create_device_with_global_priority_test_khr,
    );
    add_checked_in_new_subgroup(
        g,
        "create_device_global_priority_query",
        extra::check_global_priority_query_support_ext,
        extra::create_device_with_queried_global_priority_test_ext,
    );
    add_checked_in_new_subgroup(
        g,
        "create_device_global_priority_query_khr",
        extra::check_global_priority_query_support_khr,
        extra::create_device_with_queried_global_priority_test_khr,
    );
    add_in_new_subgroup(g, "create_device_features2", extra::create_device_features2_test);
    {
        let mut subgroup = TestCaseGroup::new("create_device_unsupported_features");
        add_function_case_no_support(
            &mut subgroup,
            "core",
            extra::create_device_with_unsupported_features_test,
        );
        super::unsupported_features_tests::add_separate_unsupported_feature_tests(&mut subgroup);
        g.add_child(subgroup);
    }
    add_checked_in_new_subgroup(
        g,
        "create_device_queue2",
        extra::check_protected_memory_support,
        extra::create_device_queue2_test,
    );
    add_in_new_subgroup(
        g,
        "create_instance_device_intentional_alloc_fail",
        extra::create_instance_device_intentional_alloc_fail,
    );

    // Tests using a single Queue Family when creating a device.
    add_checked_in_new_subgroup(
        g,
        "create_device_queue2_two_queues",
        extra::check_protected_memory_support,
        extra::create_device_queue2_with_two_queues_smoke_test,
    );
    add_checked_in_new_subgroup(
        g,
        "create_device_queue2_all_protected",
        extra::check_protected_memory_support,
        extra::create_device_queue2_with_all_protected_queues,
    );
    add_checked_in_new_subgroup(
        g,
        "create_device_queue2_all_unprotected",
        extra::check_protected_memory_support,
        extra::create_device_queue2_with_all_unprotected_queues,
    );
    add_checked_in_new_subgroup(
        g,
        "create_device_queue2_split",
        extra::check_protected_memory_support,
        extra::create_device_queue2_with_n_protected_and_m_unprotected_queues,
    );

    // Tests using multiple Queue Families when creating a device.
    add_checked_in_new_subgroup(
        g,
        "create_device_queue2_all_families",
        extra::check_protected_memory_support,
        extra::create_device_queue2_with_all_families,
    );
    add_checked_in_new_subgroup(
        g,
        "create_device_queue2_all_families_protected",
        extra::check_protected_memory_support,
        extra::create_device_queue2_with_all_families_protected,
    );
    add_checked_in_new_subgroup(
        g,
        "create_device_queue2_all_combinations",
        extra::check_protected_memory_support,
        extra::create_device_queue2_with_multiple_queue_combinations,
    );

    device_initialization_tests
}
