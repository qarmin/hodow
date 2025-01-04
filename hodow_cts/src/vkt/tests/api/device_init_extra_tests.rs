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
// The device creation cases of `dEQP-VK.api.device_init` after `create_device_queue_priorities`: global
// priority (EXT and KHR, creation and query), `create_device_features2` and the `create_device_queue2*`
// family. Registered from `device_init_tests.rs`, which keeps the rest of the group.
//
// `create_device_unsupported_features` walks the members of `VkPhysicalDeviceFeatures` only, as upstream does.
// `create_instance_device_intentional_alloc_fail` is here too, with its own allocator ledger.

use std::alloc::Layout;
use std::collections::{BTreeMap, HashMap};
use std::ffi::c_void;
use std::sync::Mutex;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, InstanceV1_1};

use super::case_util::{create_custom_instance, create_custom_instance_with_extension};
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vkt::Context;

/// Destroys a device created through a custom instance when it leaves scope.
struct DeviceGuard(Device);

impl Drop for DeviceGuard {
    fn drop(&mut self) {
        unsafe { self.0.destroy_device(None) };
    }
}

// ---------------------------------------------------------------------------------
// Global priority
// ---------------------------------------------------------------------------------

/// `checkGlobalPrioritySupport(context, false)`
pub fn check_global_priority_support_ext(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_global_priority")
}

/// `checkGlobalPrioritySupport(context, true)`
pub fn check_global_priority_support_khr(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_KHR_global_priority")
}

/// `checkGlobalPriorityQuerySupport(context, false)`
pub fn check_global_priority_query_support_ext(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_global_priority_query")
}

/// `checkGlobalPriorityQuerySupport(context, true)`
pub fn check_global_priority_query_support_khr(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_KHR_global_priority")
}

/// The global priorities of every queue family, queried through a `QueueFamilyGlobalPriorityProperties` chain.
fn query_global_priority_properties(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
) -> Result<Vec<vk::QueueFamilyGlobalPriorityProperties>, TestError> {
    let get_properties2 = instance.commands().get_physical_device_queue_family_properties2;

    let mut queue_family_property_count = 0u32;
    unsafe { get_properties2(physical_device, &mut queue_family_property_count, std::ptr::null_mut()) };
    if queue_family_property_count == 0 {
        return Err(TestError::Fail("queueFamilyPropertyCount > 0".to_string()));
    }

    let mut global_priority_properties =
        vec![vk::QueueFamilyGlobalPriorityProperties::default(); queue_family_property_count as usize];
    let mut queue_family_properties2: Vec<vk::QueueFamilyProperties2> = global_priority_properties
        .iter_mut()
        .map(|properties| vk::QueueFamilyProperties2 {
            next: properties as *mut vk::QueueFamilyGlobalPriorityProperties as *mut c_void,
            ..Default::default()
        })
        .collect();

    let mut written_count = queue_family_property_count;
    unsafe {
        get_properties2(
            physical_device,
            &mut written_count,
            queue_family_properties2.as_mut_ptr(),
        )
    };
    if written_count != queue_family_property_count {
        return Err(TestError::Fail(
            "queueFamilyPropertyCount == queueFamilyProperties2.size()".to_string(),
        ));
    }

    Ok(global_priority_properties)
}

const GLOBAL_PRIORITIES: [vk::QueueGlobalPriority; 4] = [
    vk::QueueGlobalPriority::LOW,
    vk::QueueGlobalPriority::MEDIUM,
    vk::QueueGlobalPriority::HIGH,
    vk::QueueGlobalPriority::REALTIME,
];

/// The outcome of one device creation with a global priority, as the two tests below tell them apart.
enum PriorityVerdict {
    /// The result the test accepts without further checks.
    Accepted,
    Failed(String),
}

/// `createDeviceWithGlobalPriorityTest`
fn create_device_with_global_priority_test(context: &Context<'_>, use_khr_global_priority: bool) -> TestOutcome {
    let custom = create_custom_instance(context, &[])?;
    let instance = &custom.instance;
    let physical_device = custom.physical_device;
    let queue_priorities = [1.0f32];

    let global_priority_properties = if use_khr_global_priority {
        query_global_priority_properties(instance, physical_device)?
    } else {
        Vec::new()
    };

    let extension: &std::ffi::CStr = if use_khr_global_priority {
        c"VK_KHR_global_priority"
    } else {
        c"VK_EXT_global_priority"
    };
    let enabled_extensions = [extension.as_ptr()];

    for global_priority in GLOBAL_PRIORITIES {
        let mut queue_global_priority = vk::DeviceQueueGlobalPriorityCreateInfo {
            global_priority,
            ..Default::default()
        };
        let queue_create_info = vk::DeviceQueueCreateInfo::builder()
            .queue_family_index(0)
            .queue_priorities(&queue_priorities)
            .push_next(&mut queue_global_priority)
            .build();
        let queue_create_infos = [queue_create_info];

        let mut global_priority_query_features = vk::PhysicalDeviceGlobalPriorityQueryFeatures {
            global_priority_query: vk::TRUE,
            ..Default::default()
        };
        let device_create_info = vk::DeviceCreateInfo::builder()
            .queue_create_infos(&queue_create_infos)
            .enabled_extension_names(&enabled_extensions);
        let device_create_info = if use_khr_global_priority {
            device_create_info.push_next(&mut global_priority_query_features)
        } else {
            device_create_info
        };

        let may_be_denied = global_priority.as_raw() > vk::QueueGlobalPriority::MEDIUM.as_raw();
        let must_fail = use_khr_global_priority && {
            let properties = &global_priority_properties[0];
            global_priority.as_raw() < properties.priorities[0].as_raw()
                || global_priority.as_raw() > properties.priorities[properties.priority_count as usize - 1].as_raw()
        };

        let verdict = match unsafe { instance.create_device(physical_device, &device_create_info, None) } {
            Ok(device) => {
                let device = DeviceGuard(device);
                let queue = unsafe { device.0.get_device_queue(queue_create_infos[0].queue_family_index, 0) };
                if queue == vk::Queue::null() {
                    return Err(TestError::Fail("!!queue".to_string()));
                }

                match unsafe { device.0.queue_wait_idle(queue) } {
                    Err(vk::ErrorCode::NOT_PERMITTED) if may_be_denied => PriorityVerdict::Accepted,
                    Err(vk::ErrorCode::INITIALIZATION_FAILED) if must_fail => PriorityVerdict::Accepted,
                    _ if must_fail => PriorityVerdict::Failed(format!(
                        "device creation must fail but not, globalPriority = {}",
                        global_priority.as_raw()
                    )),
                    Err(code) => PriorityVerdict::Failed(format!(
                        "vkQueueWaitIdle failed, globalPriority = {}, Error Code: {code:?}",
                        global_priority.as_raw()
                    )),
                    Ok(()) => PriorityVerdict::Accepted,
                }
            }
            Err(code) => {
                if (code == vk::ErrorCode::NOT_PERMITTED && may_be_denied)
                    || (code == vk::ErrorCode::INITIALIZATION_FAILED && must_fail)
                {
                    PriorityVerdict::Accepted
                } else {
                    PriorityVerdict::Failed(format!(
                        "exception thrown, globalPriority = {}, Error Code: {code:?}",
                        global_priority.as_raw()
                    ))
                }
            }
        };

        if let PriorityVerdict::Failed(message) = verdict {
            log::info!("{message}");
            return Ok(TestStatus::fail("Fail"));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

pub fn create_device_with_global_priority_test_ext(context: &Context<'_>) -> TestOutcome {
    create_device_with_global_priority_test(context, false)
}

pub fn create_device_with_global_priority_test_khr(context: &Context<'_>) -> TestOutcome {
    create_device_with_global_priority_test(context, true)
}

/// `isValidGlobalPriority`
fn is_valid_global_priority(priority: vk::QueueGlobalPriority) -> bool {
    [
        vk::QueueGlobalPriority::LOW,
        vk::QueueGlobalPriority::MEDIUM,
        vk::QueueGlobalPriority::HIGH,
        vk::QueueGlobalPriority::REALTIME,
    ]
    .contains(&priority)
}

/// `checkGlobalPriorityProperties`
fn check_global_priority_properties(properties: &vk::QueueFamilyGlobalPriorityProperties) -> Result<(), TestError> {
    let count = properties.priority_count as usize;
    let check = |condition: bool, what: &str| {
        if condition {
            Ok(())
        } else {
            Err(TestError::Fail(what.to_string()))
        }
    };

    check(count > 0, "properties.priorityCount > 0")?;
    check(
        count <= vk::MAX_GLOBAL_PRIORITY_SIZE,
        "properties.priorityCount <= VK_MAX_GLOBAL_PRIORITY_SIZE",
    )?;
    check(
        is_valid_global_priority(properties.priorities[0]),
        "isValidGlobalPriority(properties.priorities[0])",
    )?;

    for ndx in 1..count {
        check(
            is_valid_global_priority(properties.priorities[ndx]),
            "isValidGlobalPriority(properties.priorities[ndx])",
        )?;
        check(
            properties.priorities[ndx].as_raw() == properties.priorities[ndx - 1].as_raw() << 1,
            "properties.priorities[ndx] == (properties.priorities[ndx - 1] << 1)",
        )?;
    }
    Ok(())
}

/// `createDeviceWithQueriedGlobalPriorityTest`
fn create_device_with_queried_global_priority_test(
    context: &Context<'_>,
    use_khr_global_priority: bool,
) -> TestOutcome {
    let custom = create_custom_instance(context, &[])?;
    let instance = &custom.instance;
    let physical_device = custom.physical_device;
    let queue_priorities = [1.0f32];

    let global_priority_properties = query_global_priority_properties(instance, physical_device)?;

    let enabled_extension_cstrs: Vec<&std::ffi::CStr> = if use_khr_global_priority {
        vec![c"VK_KHR_global_priority"]
    } else {
        vec![c"VK_EXT_global_priority", c"VK_EXT_global_priority_query"]
    };
    let enabled_extensions: Vec<*const std::ffi::c_char> = enabled_extension_cstrs
        .iter()
        .map(|extension| extension.as_ptr())
        .collect();

    for (ndx, properties) in global_priority_properties.iter().enumerate() {
        check_global_priority_properties(properties)?;

        for global_priority in GLOBAL_PRIORITIES {
            let mut global_priority_query_features = vk::PhysicalDeviceGlobalPriorityQueryFeatures {
                global_priority_query: vk::TRUE,
                ..Default::default()
            };
            let mut queue_global_priority_create_info = vk::DeviceQueueGlobalPriorityCreateInfo {
                global_priority,
                ..Default::default()
            };
            let queue_create_infos = [vk::DeviceQueueCreateInfo::builder()
                .queue_family_index(ndx as u32)
                .queue_priorities(&queue_priorities)
                .push_next(&mut queue_global_priority_create_info)
                .build()];
            let device_create_info = vk::DeviceCreateInfo::builder()
                .queue_create_infos(&queue_create_infos)
                .enabled_extension_names(&enabled_extensions)
                .push_next(&mut global_priority_query_features);

            let may_be_denied = global_priority.as_raw() > vk::QueueGlobalPriority::MEDIUM.as_raw();
            let must_fail = global_priority.as_raw() < properties.priorities[0].as_raw()
                || global_priority.as_raw() > properties.priorities[properties.priority_count as usize - 1].as_raw();

            match unsafe { instance.create_device(physical_device, &device_create_info, None) } {
                Ok(device) => {
                    let device = DeviceGuard(device);
                    let queue = unsafe { device.0.get_device_queue(ndx as u32, 0) };
                    if queue == vk::Queue::null() {
                        return Err(TestError::Fail("!!queue".to_string()));
                    }

                    if must_fail {
                        log::info!(
                            "device creation must fail but not, globalPriority = {}",
                            global_priority.as_raw()
                        );
                        return Ok(TestStatus::fail("Fail"));
                    }
                }
                Err(code) => {
                    if must_fail || (code == vk::ErrorCode::NOT_PERMITTED && may_be_denied) {
                        continue;
                    }
                    log::info!(
                        "exception thrown, globalPriority = {}, Error Code: {code:?}",
                        global_priority.as_raw()
                    );
                    return Ok(TestStatus::fail("Fail"));
                }
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

pub fn create_device_with_queried_global_priority_test_ext(context: &Context<'_>) -> TestOutcome {
    create_device_with_queried_global_priority_test(context, false)
}

pub fn create_device_with_queried_global_priority_test_khr(context: &Context<'_>) -> TestOutcome {
    create_device_with_queried_global_priority_test(context, true)
}

// ---------------------------------------------------------------------------------
// create_device_features2
// ---------------------------------------------------------------------------------

/// `createDeviceFeatures2Test`
pub fn create_device_features2_test(context: &Context<'_>) -> TestOutcome {
    // A 1.1 instance has the query in core; an older one needs the extension.
    let custom = if context.get_platform().api_version >= vk::make_version(1, 1, 0) {
        create_custom_instance(context, &[])?
    } else {
        create_custom_instance_with_extension(context, "VK_KHR_get_physical_device_properties2")?
    };
    let physical_device = custom.physical_device;
    let queue_family_index = 0u32;
    let queue_index = 0u32;
    let queue_priority = [1.0f32];

    let device_queue_create_infos = [vk::DeviceQueueCreateInfo::builder()
        .queue_family_index(queue_family_index)
        .queue_priorities(&queue_priority)
        .build()];

    // Populate enabledFeatures
    let mut enabled_features = vk::PhysicalDeviceFeatures2::default();
    unsafe {
        custom
            .instance
            .get_physical_device_features2(physical_device, &mut enabled_features)
    };

    let device_create_info = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&device_queue_create_infos)
        .push_next(&mut enabled_features);
    let device = DeviceGuard(
        unsafe {
            custom
                .instance
                .create_device(physical_device, &device_create_info, None)
        }
        .vk_check("vkCreateDevice")?,
    );
    let queue = unsafe { device.0.get_device_queue(queue_family_index, queue_index) };

    unsafe { device.0.queue_wait_idle(queue) }.vk_check("vkQueueWaitIdle")?;

    Ok(TestStatus::pass("Pass"))
}

// ---------------------------------------------------------------------------------
// create_device_unsupported_features
// ---------------------------------------------------------------------------------

/// A `VkPhysicalDeviceFeatures` member by name: a reader and a writer of its `VkBool32`.
type FeatureAccessor = (
    &'static str,
    fn(&vk::PhysicalDeviceFeatures) -> vk::Bool32,
    fn(&mut vk::PhysicalDeviceFeatures, vk::Bool32),
);

macro_rules! feature_accessors {
    ($($field:ident),* $(,)?) => {
        [$((stringify!($field), (|features: &vk::PhysicalDeviceFeatures| features.$field) as fn(&vk::PhysicalDeviceFeatures) -> vk::Bool32, (|features: &mut vk::PhysicalDeviceFeatures, value: vk::Bool32| features.$field = value) as fn(&mut vk::PhysicalDeviceFeatures, vk::Bool32))),*]
    };
}

/// `createDeviceWithUnsupportedFeaturesTest` - every `VkPhysicalDeviceFeatures` member the device does not report must make
/// vkCreateDevice fail with VK_ERROR_FEATURE_NOT_PRESENT when it is enabled.
pub fn create_device_with_unsupported_features_test(context: &Context<'_>) -> TestOutcome {
    let custom = create_custom_instance(context, &[])?;
    let physical_device = custom.physical_device;
    let queue_family_index = 0u32;
    let queue_priority = [1.0f32];
    let device_features = unsafe { custom.instance.get_physical_device_features(physical_device) };
    let mut result_collector = ResultCollector::new("");

    // robustBufferAccess is left out, because it's always supported.
    let features: [FeatureAccessor; 54] = feature_accessors!(
        full_draw_index_uint32,
        image_cube_array,
        independent_blend,
        geometry_shader,
        tessellation_shader,
        sample_rate_shading,
        dual_src_blend,
        logic_op,
        multi_draw_indirect,
        draw_indirect_first_instance,
        depth_clamp,
        depth_bias_clamp,
        fill_mode_non_solid,
        depth_bounds,
        wide_lines,
        large_points,
        alpha_to_one,
        multi_viewport,
        sampler_anisotropy,
        texture_compression_etc2,
        texture_compression_astc_ldr,
        texture_compression_bc,
        occlusion_query_precise,
        pipeline_statistics_query,
        vertex_pipeline_stores_and_atomics,
        fragment_stores_and_atomics,
        shader_tessellation_and_geometry_point_size,
        shader_image_gather_extended,
        shader_storage_image_extended_formats,
        shader_storage_image_multisample,
        shader_storage_image_read_without_format,
        shader_storage_image_write_without_format,
        shader_uniform_buffer_array_dynamic_indexing,
        shader_sampled_image_array_dynamic_indexing,
        shader_storage_buffer_array_dynamic_indexing,
        shader_storage_image_array_dynamic_indexing,
        shader_clip_distance,
        shader_cull_distance,
        shader_float64,
        shader_int64,
        shader_int16,
        shader_resource_residency,
        shader_resource_min_lod,
        sparse_binding,
        sparse_residency_buffer,
        sparse_residency_image_2d,
        sparse_residency_image_3d,
        sparse_residency2_samples,
        sparse_residency4_samples,
        sparse_residency8_samples,
        sparse_residency16_samples,
        sparse_residency_aliased,
        variable_multisample_rate,
        inherited_queries,
    );

    for (name, read, write) in features {
        // Test only features that are not supported.
        if read(&device_features) != vk::FALSE {
            continue;
        }

        let mut enabled_features = device_features;
        write(&mut enabled_features, vk::TRUE);

        let device_queue_create_infos = [vk::DeviceQueueCreateInfo::builder()
            .queue_family_index(queue_family_index)
            .queue_priorities(&queue_priority)
            .build()];
        let device_create_info = vk::DeviceCreateInfo::builder()
            .queue_create_infos(&device_queue_create_infos)
            .enabled_features(&enabled_features);

        match unsafe { custom.instance.create_device(physical_device, &device_create_info, None) } {
            Err(error) if error == vk::ErrorCode::FEATURE_NOT_PRESENT => {}
            Err(error) => result_collector.fail(format!("Creating a device with feature {name}, which was reported as unsupported, returned {error:?} instead of VK_ERROR_FEATURE_NOT_PRESENT.")),
            Ok(device) => {
                drop(DeviceGuard(device));
                result_collector.fail(format!("Not returning VK_ERROR_FEATURE_NOT_PRESENT when creating device with feature {name}, which was reported as unsupported."));
            }
        }
    }

    Ok(result_collector.to_status())
}

// ---------------------------------------------------------------------------------
// create_device_queue2*
// ---------------------------------------------------------------------------------

/// `checkProtectedMemorySupport`
pub fn check_protected_memory_support(context: &Context<'_>) -> Result<(), TestError> {
    if context.get_platform().api_version < vk::make_version(1, 1, 0) {
        return Err(TestError::NotSupported("Vulkan 1.1 is not supported".to_string()));
    }

    let mut protected_memory_features = vk::PhysicalDeviceProtectedMemoryFeatures::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut protected_memory_features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };

    if protected_memory_features.protected_memory == vk::FALSE {
        return Err(TestError::NotSupported(
            "Protected memory feature is not supported".to_string(),
        ));
    }
    Ok(())
}

/// `createDeviceQueue2Test`
pub fn create_device_queue2_test(context: &Context<'_>) -> TestOutcome {
    let custom = create_custom_instance(context, &[])?;
    let physical_device = custom.physical_device;
    let queue_family_index = context.get_universal_queue_family_index();
    let queue_index = 0u32;
    let queue_priority = [1.0f32];

    let mut protected_memory_feature = vk::PhysicalDeviceProtectedMemoryFeatures::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut protected_memory_feature);
    unsafe {
        custom
            .instance
            .get_physical_device_features2(physical_device, &mut features2)
    };

    let device_queue_create_infos = [vk::DeviceQueueCreateInfo::builder()
        .flags(vk::DeviceQueueCreateFlags::PROTECTED)
        .queue_family_index(queue_family_index)
        .queue_priorities(&queue_priority)
        .build()];
    let device_create_info = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&device_queue_create_infos)
        .push_next(&mut features2);

    let device_queue_info2 = vk::DeviceQueueInfo2 {
        flags: vk::DeviceQueueCreateFlags::PROTECTED,
        queue_family_index,
        queue_index,
        ..Default::default()
    };

    let device = DeviceGuard(
        unsafe {
            custom
                .instance
                .create_device(physical_device, &device_create_info, None)
        }
        .vk_check("vkCreateDevice")?,
    );
    let queue2 = unsafe { device.0.get_device_queue2(&device_queue_info2) };

    unsafe { device.0.queue_wait_idle(queue2) }.vk_check("vkQueueWaitIdle")?;

    Ok(TestStatus::pass("Pass"))
}

/// `findQueueFamiliesWithCaps`: family index and properties of every family with all the required flags.
fn find_queue_families_with_caps(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    required_caps: vk::QueueFlags,
) -> Result<BTreeMap<u32, vk::QueueFamilyProperties>, TestError> {
    let queue_props = unsafe { instance.get_physical_device_queue_family_properties(physical_device) };
    let queue_families: BTreeMap<u32, vk::QueueFamilyProperties> = queue_props
        .iter()
        .enumerate()
        .filter(|(_, properties)| properties.queue_flags.contains(required_caps))
        .map(|(index, properties)| (index as u32, *properties))
        .collect();

    if queue_families.is_empty() {
        return Err(TestError::NotSupported("No matching queue found".to_string()));
    }
    Ok(queue_families)
}

/// `QueueCreationInfo`
#[derive(Clone, Copy)]
struct QueueCreationInfo {
    family_index: u32,
    flags: vk::DeviceQueueCreateFlags,
    count: u32,
}

const PROTECTED_QUEUE: vk::DeviceQueueCreateFlags = vk::DeviceQueueCreateFlags::PROTECTED;

/// `runQueueCreationTestCombination`
fn run_queue_creation_test_combination(
    context: &Context<'_>,
    results: &mut ResultCollector,
    test_combination: &[QueueCreationInfo],
) -> Result<bool, TestError> {
    let sum_queue_count: u32 = test_combination.iter().map(|info| info.count).sum();

    // Have an array of queue priorities which can be used when creating the queues (it is always greater or equal to
    // the number of queues for a given VkDeviceQueueCreateInfo).
    let queue_priorities = vec![1.0f32; sum_queue_count as usize];
    let queue_create_infos: Vec<vk::DeviceQueueCreateInfo> = test_combination
        .iter()
        .map(|info| vk::DeviceQueueCreateInfo {
            flags: info.flags,
            queue_family_index: info.family_index,
            queue_count: info.count,
            queue_priorities: queue_priorities.as_ptr(),
            ..Default::default()
        })
        .collect();

    for (index, info) in queue_create_infos.iter().enumerate() {
        log::info!(
            "QueueCreateInfo {index}: flags: {:?} family: {} count: {}",
            info.flags,
            info.queue_family_index,
            info.queue_count
        );
    }

    // Protected memory features availability should be already checked at this point.
    let custom = create_custom_instance(context, &[])?;
    let mut protected_memory_feature = vk::PhysicalDeviceProtectedMemoryFeatures {
        protected_memory: vk::TRUE,
        ..Default::default()
    };
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut protected_memory_feature);
    let device_create_info = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&queue_create_infos)
        .push_next(&mut features2);
    let device = DeviceGuard(
        unsafe {
            custom
                .instance
                .create_device(custom.physical_device, &device_create_info, None)
        }
        .vk_check("vkCreateDevice")?,
    );

    for info in test_combination {
        // Query Queues (based on the test configuration)
        for queue_idx in 0..info.count {
            let message = format!(
                "(queueFamilyIndex: {}, flags: {:?}, queue Index: {queue_idx})",
                info.family_index, info.flags
            );
            let queue_info2 = vk::DeviceQueueInfo2 {
                flags: info.flags,
                queue_family_index: info.family_index,
                queue_index: queue_idx,
                ..Default::default()
            };
            let queue = unsafe { device.0.get_device_queue2(&queue_info2) };

            if queue != vk::Queue::null() {
                unsafe { device.0.queue_wait_idle(queue) }.vk_check("vkQueueWaitIdle")?;
                results.add_result(TestResult::Pass, format!("Found Queue. {message}"));
            } else {
                results.fail(format!("Unable to access the Queue. {message}"));
            }
        }
    }

    Ok(results.to_status().code() == TestResult::Pass)
}

fn queue_creation_result(results: &ResultCollector, success: bool, message: &str) -> TestOutcome {
    if success {
        Ok(TestStatus::pass(message))
    } else {
        Ok(results.to_status())
    }
}

/// `createDeviceQueue2WithTwoQueuesSmokeTest`
pub fn create_device_queue2_with_two_queues_smoke_test(context: &Context<'_>) -> TestOutcome {
    let queue_family_properties = unsafe {
        context
            .get_instance()
            .get_physical_device_queue_family_properties(context.get_physical_device())
    };

    // Find the first protected-capable queue with a queueCount >= 2 and use it for testing (smoke test)
    let required_caps = vk::QueueFlags::PROTECTED;
    let required_queue_count = 2;
    let queue_family_index = queue_family_properties
        .iter()
        .position(|properties| {
            properties.queue_flags.contains(required_caps) && properties.queue_count >= required_queue_count
        })
        .ok_or_else(|| {
            TestError::NotSupported(
                "Unable to find a queue family that is protected-capable and supports more than one queue.".to_string(),
            )
        })? as u32;

    log::info!("Selected VkQueueFamilyProperties index: {queue_family_index}");

    // Use the previously selected queue family index to create 1 protected-capable and 1 unprotected queue.
    let protected_queue_config = QueueCreationInfo {
        family_index: queue_family_index,
        flags: PROTECTED_QUEUE,
        count: 1,
    };
    let unprotected_queue_config = QueueCreationInfo {
        family_index: queue_family_index,
        flags: vk::DeviceQueueCreateFlags::empty(),
        count: 1,
    };

    let mut results = ResultCollector::new("");
    let success = run_queue_creation_test_combination(
        context,
        &mut results,
        &[protected_queue_config, unprotected_queue_config],
    )?;
    queue_creation_result(&results, success, "All Queues were queried correctly.")
}

/// `createDeviceQueue2WithAllProtectedQueues`
pub fn create_device_queue2_with_all_protected_queues(context: &Context<'_>) -> TestOutcome {
    // Select only protected-capable queue families
    let queue_family_properties = find_queue_families_with_caps(
        context.get_instance(),
        context.get_physical_device(),
        vk::QueueFlags::PROTECTED,
    )?;

    let mut success = true;
    let mut results = ResultCollector::new("");

    // For each protected-capable queue family, create a device with the max number of queues available and all queues created as protected-capable.
    for (&queue_family_index, properties) in &queue_family_properties {
        let protected_queue_config = QueueCreationInfo {
            family_index: queue_family_index,
            flags: PROTECTED_QUEUE,
            count: properties.queue_count,
        };

        // Run current confugurations.
        success = success && run_queue_creation_test_combination(context, &mut results, &[protected_queue_config])?;
    }

    queue_creation_result(&results, success, "All queues were queried correctly.")
}

/// `createDeviceQueue2WithAllUnprotectedQueues`
pub fn create_device_queue2_with_all_unprotected_queues(context: &Context<'_>) -> TestOutcome {
    // Select all queue families with or without protected bit
    let queue_family_properties = find_queue_families_with_caps(
        context.get_instance(),
        context.get_physical_device(),
        vk::QueueFlags::empty(),
    )?;

    let mut success = true;
    let mut results = ResultCollector::new("");

    // For each Queue Family create the max number of unprotected Queues.
    for (&queue_family_index, properties) in &queue_family_properties {
        let unprotected_queue_config = QueueCreationInfo {
            family_index: queue_family_index,
            flags: vk::DeviceQueueCreateFlags::empty(),
            count: properties.queue_count,
        };

        // Run current confugurations.
        success = success && run_queue_creation_test_combination(context, &mut results, &[unprotected_queue_config])?;
    }

    queue_creation_result(&results, success, "All Queues were queried correctly.")
}

type DeviceQueueConfig = Vec<QueueCreationInfo>;
type QueueFamilyConfigurations = BTreeMap<u32, Vec<DeviceQueueConfig>>;

/// `buildQueueConfigurations`
fn build_queue_configurations(
    queue_family_properties: &BTreeMap<u32, vk::QueueFamilyProperties>,
) -> QueueFamilyConfigurations {
    let mut queues_per_family = QueueFamilyConfigurations::new();

    // Build up the queue creation combinations (N protected and M unprotected queues where N+M == queueFamily.queueCount)
    // on each protected-capable queue family
    for (&queue_family_index, queue_family_property) in queue_family_properties {
        let allowed_queue_count = queue_family_property.queue_count;

        for split_count in 0..=allowed_queue_count {
            let protected_queues_count = allowed_queue_count - split_count;
            let unprotected_queues_count = split_count;

            let mut test_combination = DeviceQueueConfig::new();

            if protected_queues_count != 0 {
                test_combination.push(QueueCreationInfo {
                    family_index: queue_family_index,
                    flags: PROTECTED_QUEUE,
                    count: protected_queues_count,
                });
            }

            if unprotected_queues_count != 0 {
                test_combination.push(QueueCreationInfo {
                    family_index: queue_family_index,
                    flags: vk::DeviceQueueCreateFlags::empty(),
                    count: unprotected_queues_count,
                });
            }

            queues_per_family
                .entry(queue_family_index)
                .or_default()
                .push(test_combination);
        }
    }

    queues_per_family
}

/// Runs every combination, then every combination in reverse order (so the unprotected queue creation info is at
/// the start of the VkDeviceQueueCreateInfo vector).
fn run_combinations_both_ways(
    context: &Context<'_>,
    results: &mut ResultCollector,
    mut queue_create_combinations: Vec<DeviceQueueConfig>,
) -> Result<bool, TestError> {
    for test_combination in &queue_create_combinations {
        let queues_info: String = test_combination
            .iter()
            .map(|info| {
                format!(
                    "(Queue family: {}, flags: {:?}, count: {})",
                    info.family_index, info.flags, info.count
                )
            })
            .collect();
        log::info!("Test Combination: {queues_info}");
    }

    let mut success = true;

    // Based on the protected-unprotected queue combinations, run each test case.
    for test_combination in &queue_create_combinations {
        success = success && run_queue_creation_test_combination(context, results, test_combination)?;
    }

    // Run the test cases also in reverse order.
    for test_combination in &mut queue_create_combinations {
        test_combination.reverse();

        success = success && run_queue_creation_test_combination(context, results, test_combination)?;
    }

    Ok(success)
}

/// `createDeviceQueue2WithNProtectedAndMUnprotectedQueues`
pub fn create_device_queue2_with_n_protected_and_m_unprotected_queues(context: &Context<'_>) -> TestOutcome {
    // Select only protected-capable queue families
    let queue_family_properties = find_queue_families_with_caps(
        context.get_instance(),
        context.get_physical_device(),
        vk::QueueFlags::PROTECTED,
    )?;

    // Build all protected-unprotected splits per queue family, transformed to a simple vector.
    let queues_per_family = build_queue_configurations(&queue_family_properties);
    let queue_create_combinations: Vec<DeviceQueueConfig> = queues_per_family.into_values().flatten().collect();

    let mut results = ResultCollector::new("");
    let success = run_combinations_both_ways(context, &mut results, queue_create_combinations)?;
    queue_creation_result(&results, success, "All Queues were queried correctly.")
}

/// `createDeviceQueue2WithMultipleQueueCombinations`
pub fn create_device_queue2_with_multiple_queue_combinations(context: &Context<'_>) -> TestOutcome {
    // Select only protected-capable queue families.
    let queue_family_properties = find_queue_families_with_caps(
        context.get_instance(),
        context.get_physical_device(),
        vk::QueueFlags::PROTECTED,
    )?;

    // Build all protected-unprotected splits per queue family.
    let queues_per_family = build_queue_configurations(&queue_family_properties);

    // Build up all combinations of queue families from the previous mapping.
    let mut queue_create_combinations: Vec<DeviceQueueConfig> = Vec::new();
    {
        let mut item_indices = vec![0usize; queues_per_family.len()];

        // Calculate the max number of combinations.
        let item_count: usize = queues_per_family.values().map(|configs| configs.len()).product();

        // Extract queue families from queuesPerFamily map
        let queue_families_vect: Vec<u32> = queues_per_family.keys().copied().collect();

        for _ in 0..item_count {
            let mut test_combination = DeviceQueueConfig::new();

            // Select queue configurations from each family
            for (ndx, &queue_family) in queue_families_vect.iter().enumerate() {
                let family_configurations = &queues_per_family[&queue_family];
                let target_queue_config = &family_configurations[item_indices[ndx]];

                test_combination.extend_from_slice(target_queue_config);
            }

            queue_create_combinations.push(test_combination);

            // Increment the indices of permutations in each family. Upstream looks the family up by the position `ndx`
            // here (std::map::operator[]), not by family index, and so does this.
            for ndx in 0..item_indices.len() {
                item_indices[ndx] += 1;
                if item_indices[ndx] < queues_per_family.get(&(ndx as u32)).map_or(0, |configs| configs.len()) {
                    break;
                }

                // "overflow" happened in the given index, restart from zero and increment the next item index (restart loop).
                item_indices[ndx] = 0;
            }
        }
    }

    let mut results = ResultCollector::new("");
    let success = run_combinations_both_ways(context, &mut results, queue_create_combinations)?;
    queue_creation_result(&results, success, "All Queues were queried correctly.")
}

/// `createDeviceQueue2WithAllFamilies`
pub fn create_device_queue2_with_all_families(context: &Context<'_>) -> TestOutcome {
    // Get all queue families
    let queue_family_properties = find_queue_families_with_caps(
        context.get_instance(),
        context.get_physical_device(),
        vk::QueueFlags::empty(),
    )?;

    // Create test configuration where for each queue family the maximum number of queues are created.
    let queue_configurations: Vec<QueueCreationInfo> = queue_family_properties
        .iter()
        .map(|(&queue_family_index, properties)| QueueCreationInfo {
            family_index: queue_family_index,
            flags: vk::DeviceQueueCreateFlags::empty(),
            count: properties.queue_count,
        })
        .collect();

    let mut results = ResultCollector::new("");

    // Execute test to see if it possible to have all queue families created at the same time.
    let success = run_queue_creation_test_combination(context, &mut results, &queue_configurations)?;
    queue_creation_result(&results, success, "All Queues were queried correctly.")
}

/// `createDeviceQueue2WithAllFamiliesProtected`
pub fn create_device_queue2_with_all_families_protected(context: &Context<'_>) -> TestOutcome {
    // Get all queue families
    let queue_family_properties = find_queue_families_with_caps(
        context.get_instance(),
        context.get_physical_device(),
        vk::QueueFlags::empty(),
    )?;

    // Create test configuration where for each queue family the maximum number of queues are created.
    // If a queue supports protected memory then create a protected-capable queue.
    let queue_configurations: Vec<QueueCreationInfo> = queue_family_properties
        .iter()
        .map(|(&queue_family_index, properties)| {
            // Upstream tests the family's queue flags against VK_DEVICE_QUEUE_CREATE_PROTECTED_BIT, whose value (1) is
            // VK_QUEUE_GRAPHICS_BIT in that field.
            let use_flags = if properties.queue_flags.bits() & vk::DeviceQueueCreateFlags::PROTECTED.bits()
                == vk::DeviceQueueCreateFlags::PROTECTED.bits()
            {
                PROTECTED_QUEUE
            } else {
                vk::DeviceQueueCreateFlags::empty()
            };
            QueueCreationInfo {
                family_index: queue_family_index,
                flags: use_flags,
                count: properties.queue_count,
            }
        })
        .collect();

    let mut results = ResultCollector::new("");

    // Execute test to see if it possible to have all queue families created at the same time.
    let success = run_queue_creation_test_combination(context, &mut results, &queue_configurations)?;
    queue_creation_result(&results, success, "All Queues were queried correctly.")
}

// ---------------------------------------------------------------------------------
// create_instance_device_intentional_alloc_fail
// ---------------------------------------------------------------------------------

/// The ledger behind upstream's `g_allocatedVector` and its counters: the allocation callbacks have no
/// per-call state to reach it through, so it is global, as there.
struct AllocTracker {
    /// How many allocations may be live at once (`g_allocatedVector.size()`).
    capacity: usize,
    active: HashMap<usize, (Layout, usize)>,
    was_allocated: bool,
    intentional_fail_enabled: bool,
    intentional_fail_index: u32,
    intentional_fail_count: u32,
    allocations_count: usize,
}

static ALLOC_TRACKER: Mutex<Option<AllocTracker>> = Mutex::new(None);

fn with_tracker<T>(f: impl FnOnce(&mut AllocTracker) -> T) -> Option<T> {
    ALLOC_TRACKER.lock().ok().and_then(|mut guard| guard.as_mut().map(f))
}

/// `freeAllocTracker`
fn free_alloc_tracker() {
    if let Ok(mut guard) = ALLOC_TRACKER.lock()
        && let Some(tracker) = guard.take()
    {
        for (address, (layout, _)) in tracker.active {
            unsafe { std::alloc::dealloc(address as *mut u8, layout) };
        }
    }
}

/// `initAllocTracker`; `intentional_fail_index` is `None` for upstream's `~0`.
fn init_alloc_tracker(size: usize, intentional_fail_index: Option<u32>) {
    free_alloc_tracker();
    if let Ok(mut guard) = ALLOC_TRACKER.lock() {
        *guard = Some(AllocTracker {
            capacity: size,
            active: HashMap::new(),
            was_allocated: false,
            intentional_fail_enabled: intentional_fail_index.is_some(),
            intentional_fail_index: intentional_fail_index.unwrap_or(0),
            intentional_fail_count: 0,
            allocations_count: 0,
        });
    }
}

/// `isAllocTrackerEmpty`
fn is_alloc_tracker_empty() -> bool {
    with_tracker(|tracker| {
        let mut success = tracker.active.is_empty();
        if !tracker.intentional_fail_enabled && !tracker.was_allocated {
            success = false;
        }
        success
    })
    .unwrap_or(false)
}

fn tracked_allocate(tracker: &mut AllocTracker, size: usize, alignment: usize) -> *mut c_void {
    if tracker.intentional_fail_enabled {
        tracker.intentional_fail_count += 1;
        if tracker.intentional_fail_count >= tracker.intentional_fail_index {
            return std::ptr::null_mut();
        }
    }

    if tracker.active.len() >= tracker.capacity {
        return std::ptr::null_mut();
    }

    let Ok(layout) = Layout::from_size_align(size.max(1), alignment.max(1)) else {
        return std::ptr::null_mut();
    };
    let address = unsafe { std::alloc::alloc(layout) };
    if !address.is_null() {
        tracker.active.insert(address as usize, (layout, size));
        tracker.was_allocated = true;
    }

    tracker.allocations_count += 1;
    address.cast()
}

fn tracked_free(tracker: &mut AllocTracker, memory: *mut c_void) {
    if let Some((layout, _)) = tracker.active.remove(&(memory as usize)) {
        unsafe { std::alloc::dealloc(memory.cast(), layout) };
    }
}

/// `allocCallbackFunc`
unsafe extern "system" fn alloc_callback_func(
    _user_data: *mut c_void,
    size: usize,
    alignment: usize,
    _scope: vk::SystemAllocationScope,
) -> *mut c_void {
    with_tracker(|tracker| tracked_allocate(tracker, size, alignment)).unwrap_or(std::ptr::null_mut())
}

/// `freeCallbackFunc`
unsafe extern "system" fn free_callback_func(_user_data: *mut c_void, memory: *mut c_void) {
    with_tracker(|tracker| tracked_free(tracker, memory));
}

/// `reallocCallbackFunc`
unsafe extern "system" fn realloc_callback_func(
    _user_data: *mut c_void,
    original: *mut c_void,
    size: usize,
    alignment: usize,
    _scope: vk::SystemAllocationScope,
) -> *mut c_void {
    with_tracker(|tracker| {
        if original.is_null() {
            return tracked_allocate(tracker, size, alignment);
        }

        let Some(&(_, requested_size)) = tracker.active.get(&(original as usize)) else {
            return std::ptr::null_mut();
        };

        if size == 0 {
            tracked_free(tracker, original);
            std::ptr::null_mut()
        } else if size < requested_size {
            original
        } else {
            let new_memory = tracked_allocate(tracker, size, alignment);
            if !new_memory.is_null() {
                unsafe {
                    std::ptr::copy_nonoverlapping(
                        original.cast::<u8>(),
                        new_memory.cast::<u8>(),
                        requested_size.min(size),
                    )
                };
                tracked_free(tracker, original);
            }
            new_memory
        }
    })
    .unwrap_or(std::ptr::null_mut())
}

/// What one attempt at creating the instance and the device came to.
enum AllocFailAttempt {
    Complete,
    OutOfHostMemory,
}

/// One pass of upstream's do-while body, from `createInstance` to the destruction of both objects.
fn attempt_instance_and_device(
    context: &Context<'_>,
    allocation_callbacks: &vk::AllocationCallbacks,
    fail_index: u32,
) -> Result<AllocFailAttempt, String> {
    // The tracker must be empty after a failed attempt, once whatever was created is destroyed.
    let check_remaining = || -> Result<AllocFailAttempt, String> {
        if !is_alloc_tracker_empty() {
            return Err(format!("Allocations still remain, failed on index {fail_index}"));
        }
        free_alloc_tracker();
        Ok(AllocFailAttempt::OutOfHostMemory)
    };

    let entry = &context.get_platform().entry;
    let queue_priority = [0.0f32];

    let application_name = c"appName";
    let engine_name = c"engineName";
    let app_info = vk::ApplicationInfo {
        application_name: application_name.as_ptr(),
        engine_name: engine_name.as_ptr(),
        api_version: vk::make_version(1, 0, 0),
        ..Default::default()
    };

    let portability_extension = [c"VK_KHR_portability_enumeration".as_ptr()];
    let portability_available =
        super::case_util::is_instance_extension_available(context, "VK_KHR_portability_enumeration");
    let mut instance_create_info = vk::InstanceCreateInfo::builder().application_info(&app_info);
    if portability_available {
        instance_create_info = instance_create_info
            .flags(vk::InstanceCreateFlags::ENUMERATE_PORTABILITY_KHR)
            .enabled_extension_names(&portability_extension);
    }

    let instance = match unsafe { entry.create_instance(&instance_create_info, Some(allocation_callbacks)) } {
        Ok(instance) => instance,
        Err(vk::ErrorCode::OUT_OF_HOST_MEMORY) => return check_remaining(),
        Err(code) => return Err(format!("createInstance returned {code:?}")),
    };

    let physical_devices = match unsafe { instance.enumerate_physical_devices() } {
        Ok(physical_devices) => physical_devices,
        Err(vk::ErrorCode::OUT_OF_HOST_MEMORY) => {
            unsafe { instance.destroy_instance(Some(allocation_callbacks)) };
            return check_remaining();
        }
        Err(code) => {
            unsafe { instance.destroy_instance(Some(allocation_callbacks)) };
            return Err(format!("enumeratePhysicalDevices returned {code:?}"));
        }
    };

    // The context's device when the new instance can tell it apart, as the custom instance helper does.
    let reference = context.get_device_properties();
    let chosen_device = physical_devices
        .iter()
        .copied()
        .find(|&physical_device| {
            let properties = unsafe { instance.get_physical_device_properties(physical_device) };
            properties.vendor_id == reference.vendor_id
                && properties.device_id == reference.device_id
                && properties.pipeline_cache_uuid == reference.pipeline_cache_uuid
        })
        .or_else(|| physical_devices.first().copied());
    let Some(chosen_device) = chosen_device else {
        unsafe { instance.destroy_instance(Some(allocation_callbacks)) };
        return Err("enumeratePhysicalDevices returned no devices".to_string());
    };

    let queue_families = unsafe { instance.get_physical_device_queue_family_properties(chosen_device) };
    if queue_families.is_empty() {
        unsafe { instance.destroy_instance(Some(allocation_callbacks)) };
        return Err("getPhysicalDeviceQueueFamilyProperties returned zero queue families".to_string());
    }
    let queue_family_index = queue_families
        .iter()
        .position(|family| family.queue_flags.contains(vk::QueueFlags::GRAPHICS))
        .unwrap_or(0) as u32;

    let device_queue_create_infos = [vk::DeviceQueueCreateInfo::builder()
        .queue_family_index(queue_family_index)
        .queue_priorities(&queue_priority)
        .build()];
    let device_create_info = vk::DeviceCreateInfo::builder().queue_create_infos(&device_queue_create_infos);

    match unsafe { instance.create_device(chosen_device, &device_create_info, Some(allocation_callbacks)) } {
        Ok(device) => {
            unsafe {
                device.destroy_device(Some(allocation_callbacks));
                instance.destroy_instance(Some(allocation_callbacks));
            }
            Ok(AllocFailAttempt::Complete)
        }
        Err(vk::ErrorCode::OUT_OF_HOST_MEMORY) => {
            unsafe { instance.destroy_instance(Some(allocation_callbacks)) };
            check_remaining()
        }
        Err(code) => {
            unsafe { instance.destroy_instance(Some(allocation_callbacks)) };
            Err(format!("VkCreateDevice returned {code:?}"))
        }
    }
}

/// `createInstanceDeviceIntentionalAllocFail`
pub fn create_instance_device_intentional_alloc_fail(context: &Context<'_>) -> TestOutcome {
    let allocation_callbacks = vk::AllocationCallbacks {
        user_data: std::ptr::null_mut(),
        allocation: Some(alloc_callback_func),
        reallocation: Some(realloc_callback_func),
        free: Some(free_callback_func),
        internal_allocation: None,
        internal_free: None,
    };

    let mut fail_index = 0u32;
    let mut result_out_of_host_memory = false;
    let mut max_allowed_alloc = 0usize;

    let outcome = loop {
        if max_allowed_alloc == 0 {
            if result_out_of_host_memory {
                break Ok(TestStatus::fail("Could not create instance and device"));
            }

            init_alloc_tracker(99999, None);
        } else {
            init_alloc_tracker(max_allowed_alloc, Some(fail_index));
            fail_index += 1;

            if fail_index as usize >= max_allowed_alloc {
                break Ok(TestStatus::fail("Out of retries, could not create instance and device"));
            }
        }

        match attempt_instance_and_device(context, &allocation_callbacks, fail_index) {
            Err(message) => break Ok(TestStatus::fail(message)),
            Ok(AllocFailAttempt::OutOfHostMemory) => {
                result_out_of_host_memory = true;
            }
            Ok(AllocFailAttempt::Complete) => {
                result_out_of_host_memory = false;
                if max_allowed_alloc == 0 {
                    max_allowed_alloc = with_tracker(|tracker| tracker.allocations_count).unwrap_or(0) + 100;
                    result_out_of_host_memory = true;
                }
                free_alloc_tracker();
            }
        }

        if !result_out_of_host_memory {
            break Ok(TestStatus::pass("Pass"));
        }
    };

    free_alloc_tracker();
    outcome
}
