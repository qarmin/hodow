// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/vktInfoTests.cpp (`createInfoTests`: build, device, platform, memory_limits)
//   external/vulkancts/modules/vulkan/api/vktApiFeatureInfo.cpp (`createFeatureInfoInstanceTests`,
//   `createFeatureInfoDeviceTests`, `createFeatureInfoDeviceGroupTests`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Queries of the instance and the physical device that run no shader. Not ported: the checks that read upstream's generated
// extension tables (the unknown-KHR-extension half of `instance_extensions` and `device_extensions`), and
// `device_memory_budget_multi_instance` and `device_group_peer_memory_features`, which build instances and devices of their own.
// `physical_device_groups` enumerates through the instance the run already has, not one made for the extension.

mod extension_dependencies;
mod feature_limits;
mod mandatory_features;

use std::collections::BTreeSet;
use std::ffi::c_void;
use std::mem::{MaybeUninit, size_of};

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vkt::tests::api::case_util::{
    add_function_case, add_function_case_no_support, create_custom_instance_with_extension,
    find_queue_family_index_with_caps,
};
use crate::vkt::{Context, TestCaseGroup};

/// `ValidateQueryBits::fillBits` - the pattern unused entries are checked against.
const FILL_BYTE: u8 = 0xCD;

fn fill_bits<T>(data: &mut [T]) {
    unsafe { std::ptr::write_bytes(data.as_mut_ptr().cast::<u8>(), FILL_BYTE, std::mem::size_of_val(data)) };
}

fn check_bits<T>(data: &[T]) -> bool {
    let bytes = unsafe { std::slice::from_raw_parts(data.as_ptr().cast::<u8>(), std::mem::size_of_val(data)) };
    bytes.iter().all(|byte| *byte == FILL_BYTE)
}

/// `CheckIncompleteResult::operator()` - a query given a third of the room it needs has to say `VK_INCOMPLETE`, report that many
/// entries and leave the rest of the array alone. `init` runs over the entries handed in, for the structures that carry an sType.
fn check_incomplete<T: Copy>(
    results: &mut ResultCollector,
    expected_complete_size: usize,
    query: &dyn Fn(&mut u32, *mut T) -> vk::Result,
    init: &dyn Fn(&mut [T]),
) {
    if expected_complete_size == 0 {
        return;
    }

    let mut output_data: Vec<T> = vec![unsafe { std::mem::zeroed() }; expected_complete_size];
    let used_size = (expected_complete_size / 3) as u32;

    fill_bits(&mut output_data);
    init(&mut output_data[..used_size as usize]);
    let mut count = used_size;

    let result = query(&mut count, output_data.as_mut_ptr());

    if count != used_size || result != vk::Result::INCOMPLETE || !check_bits(&output_data[count as usize..]) {
        results.fail("Query didn't return VK_INCOMPLETE");
    }
}

/// A `(count, array)` query run the usual two times: once for the count, once for the data.
fn query_list<T: Copy>(what: &str, query: &dyn Fn(&mut u32, *mut T) -> vk::Result) -> Result<Vec<T>, TestError> {
    let mut count = 0u32;
    let result = query(&mut count, std::ptr::null_mut());
    if result != vk::Result::SUCCESS {
        return Err(TestError::Fail(format!("{what} returned {result:?}")));
    }
    let mut data: Vec<T> = vec![unsafe { std::mem::zeroed() }; count as usize];
    let result = query(&mut count, data.as_mut_ptr());
    if result != vk::Result::SUCCESS && result != vk::Result::INCOMPLETE {
        return Err(TestError::Fail(format!("{what} returned {result:?}")));
    }
    data.truncate(count as usize);
    Ok(data)
}

/// `checkDuplicates`
fn check_duplicates(results: &mut ResultCollector, what: &str, values: &[String]) {
    let mut seen = BTreeSet::new();
    let mut duplicates = BTreeSet::new();

    for value in values {
        if !seen.insert(value) {
            duplicates.insert(value);
        }
    }

    for duplicate in duplicates {
        results.fail(format!("Duplicate {what}: {duplicate}"));
    }
}

fn instance_layers(context: &Context<'_>) -> Result<Vec<vk::LayerProperties>, TestError> {
    let commands = context.get_platform().entry.commands();
    query_list("vkEnumerateInstanceLayerProperties", &|count, data| unsafe {
        (commands.enumerate_instance_layer_properties)(count, data)
    })
}

fn instance_extensions(
    context: &Context<'_>,
    layer: Option<&vk::LayerProperties>,
) -> Result<Vec<vk::ExtensionProperties>, TestError> {
    let commands = context.get_platform().entry.commands();
    let layer_name = layer.map_or(std::ptr::null(), |layer| layer.layer_name.as_ptr());
    query_list("vkEnumerateInstanceExtensionProperties", &|count, data| unsafe {
        (commands.enumerate_instance_extension_properties)(layer_name, count, data)
    })
}

fn device_layers(context: &Context<'_>) -> Result<Vec<vk::LayerProperties>, TestError> {
    let commands = context.get_instance().commands();
    let physical_device = context.get_physical_device();
    query_list("vkEnumerateDeviceLayerProperties", &|count, data| unsafe {
        (commands.enumerate_device_layer_properties)(physical_device, count, data)
    })
}

fn device_extensions(
    context: &Context<'_>,
    layer: Option<&vk::LayerProperties>,
) -> Result<Vec<vk::ExtensionProperties>, TestError> {
    let commands = context.get_instance().commands();
    let physical_device = context.get_physical_device();
    let layer_name = layer.map_or(std::ptr::null(), |layer| layer.layer_name.as_ptr());
    query_list("vkEnumerateDeviceExtensionProperties", &|count, data| unsafe {
        (commands.enumerate_device_extension_properties)(physical_device, layer_name, count, data)
    })
}

/// `enumeratePhysicalDevices`
fn enumerate_physical_devices(context: &Context<'_>) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let instance = context.get_instance();
    let devices = unsafe { instance.enumerate_physical_devices() }.vk_check("vkEnumeratePhysicalDevices")?;

    log::info!("Number of devices: {}", devices.len());
    for (ndx, device) in devices.iter().enumerate() {
        log::info!("{ndx}: {device:?}");
    }

    let commands = instance.commands();
    let handle = instance.handle();
    check_incomplete::<vk::PhysicalDevice>(
        &mut results,
        devices.len(),
        &|count, data| unsafe { (commands.enumerate_physical_devices)(handle, count, data) },
        &|_| {},
    );

    Ok(results.to_status())
}

/// `enumeratePhysicalDeviceGroups`
fn enumerate_physical_device_groups(context: &Context<'_>) -> TestOutcome {
    let (major, minor, _) = context.api_version();
    if (major, minor) < (1, 1) {
        return Err(TestError::NotSupported(
            "VK_KHR_device_group_creation is not enabled on a 1.0 instance".to_string(),
        ));
    }

    let mut results = ResultCollector::new("");
    let instance = context.get_instance();
    let device_groups =
        unsafe { instance.enumerate_physical_device_groups() }.vk_check("vkEnumeratePhysicalDeviceGroups")?;

    log::info!("Number of device groups: {}", device_groups.len());
    for (ndx, group) in device_groups.iter().enumerate() {
        log::info!("{ndx}: {group:?}");
    }

    let commands = instance.commands();
    let handle = instance.handle();
    check_incomplete::<vk::PhysicalDeviceGroupProperties>(
        &mut results,
        device_groups.len(),
        &|count, data| unsafe { (commands.enumerate_physical_device_groups)(handle, count, data) },
        &|data| {
            data.iter_mut()
                .for_each(|entry| *entry = vk::PhysicalDeviceGroupProperties::default())
        },
    );

    Ok(results.to_status())
}

fn layer_names(layers: &[vk::LayerProperties]) -> Vec<String> {
    layers
        .iter()
        .map(|layer| layer.layer_name.to_string_lossy().to_string())
        .collect()
}

fn extension_names(extensions: &[vk::ExtensionProperties]) -> Vec<String> {
    extensions
        .iter()
        .map(|extension| extension.extension_name.to_string_lossy().to_string())
        .collect()
}

/// `enumerateInstanceLayers`
fn enumerate_instance_layers(context: &Context<'_>) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let properties = instance_layers(context)?;
    let names = layer_names(&properties);

    for (ndx, name) in names.iter().enumerate() {
        log::info!("{ndx}: {name}");
    }

    check_duplicates(&mut results, "layer", &names);
    let commands = context.get_platform().entry.commands();
    check_incomplete::<vk::LayerProperties>(
        &mut results,
        names.len(),
        &|count, data| unsafe { (commands.enumerate_instance_layer_properties)(count, data) },
        &|_| {},
    );

    Ok(results.to_status())
}

/// `enumerateInstanceExtensions`
fn enumerate_instance_extensions(context: &Context<'_>) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let commands = context.get_platform().entry.commands();

    {
        log::info!("Global Extensions");
        let properties = instance_extensions(context, None)?;
        let names = extension_names(&properties);
        for (ndx, name) in names.iter().enumerate() {
            log::info!("{ndx}: {name}");
        }

        check_duplicates(&mut results, "extension", &names);
        check_incomplete::<vk::ExtensionProperties>(
            &mut results,
            properties.len(),
            &|count, data| unsafe { (commands.enumerate_instance_extension_properties)(std::ptr::null(), count, data) },
            &|_| {},
        );
    }

    for layer in &instance_layers(context)? {
        log::info!("Layer: {}", layer.layer_name.to_string_lossy());
        let properties = instance_extensions(context, Some(layer))?;
        let names = extension_names(&properties);
        for (ndx, name) in names.iter().enumerate() {
            log::info!("{ndx}: {name}");
        }

        check_duplicates(&mut results, "extension", &names);
        let layer_name = layer.layer_name.as_ptr();
        check_incomplete::<vk::ExtensionProperties>(
            &mut results,
            properties.len(),
            &|count, data| unsafe { (commands.enumerate_instance_extension_properties)(layer_name, count, data) },
            &|_| {},
        );
    }

    Ok(results.to_status())
}

/// `testNoKhxExtensions`
fn test_no_khx_extensions(context: &Context<'_>) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let mut test_succeeded = true;

    let mut names = extension_names(&instance_extensions(context, None)?);
    names.extend(extension_names(&device_extensions(context, None)?));

    // KHX author ID is no longer used, all KHX extensions have been promoted to KHR status
    for name in names {
        if name.starts_with("VK_KHX_") {
            results.fail(format!("Invalid extension name {name}"));
            test_succeeded = false;
        }
    }

    if test_succeeded {
        return Ok(TestStatus::pass("No extensions begining with \"VK_KHX\""));
    }
    Ok(TestStatus::fail("One or more extensions begins with \"VK_KHX\""))
}

/// `enumerateDeviceLayers`
fn enumerate_device_layers(context: &Context<'_>) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let properties = device_layers(context)?;
    let names = layer_names(&properties);

    for (ndx, name) in names.iter().enumerate() {
        log::info!("{ndx}: {name}");
    }

    check_duplicates(&mut results, "layer", &names);
    let commands = context.get_instance().commands();
    let physical_device = context.get_physical_device();
    check_incomplete::<vk::LayerProperties>(
        &mut results,
        names.len(),
        &|count, data| unsafe { (commands.enumerate_device_layer_properties)(physical_device, count, data) },
        &|_| {},
    );

    Ok(results.to_status())
}

/// `enumerateDeviceExtensions`
fn enumerate_device_extensions(context: &Context<'_>) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let commands = context.get_instance().commands();
    let physical_device = context.get_physical_device();

    {
        log::info!("Global Extensions");
        let properties = device_extensions(context, None)?;
        let names = extension_names(&properties);
        for (ndx, name) in names.iter().enumerate() {
            log::info!("{ndx}: {name}");
        }

        check_duplicates(&mut results, "extension", &names);
        check_incomplete::<vk::ExtensionProperties>(
            &mut results,
            properties.len(),
            &|count, data| unsafe {
                (commands.enumerate_device_extension_properties)(physical_device, std::ptr::null(), count, data)
            },
            &|_| {},
        );
    }

    for layer in &device_layers(context)? {
        log::info!("Layer: {}", layer.layer_name.to_string_lossy());
        let properties = device_extensions(context, Some(layer))?;
        let names = extension_names(&properties);
        for (ndx, name) in names.iter().enumerate() {
            log::info!("{ndx}: {name}");
        }

        check_duplicates(&mut results, "extension", &names);
        let layer_name = layer.layer_name.as_ptr();
        check_incomplete::<vk::ExtensionProperties>(
            &mut results,
            properties.len(),
            &|count, data| unsafe {
                (commands.enumerate_device_extension_properties)(physical_device, layer_name, count, data)
            },
            &|_| {},
        );
    }

    Ok(results.to_status())
}

/// `validateDeviceExtensionSupport`
fn validate_device_extension_support(context: &Context<'_>) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let supported = extension_names(&device_extensions(context, None)?);

    let required_support = [("VK_EXT_descriptor_heap", "VK_KHR_shader_untyped_pointers")];

    for (extension, requires) in required_support {
        let has = |name: &str| supported.iter().any(|supported| supported == name);
        if has(extension) && !has(requires) {
            results.fail(format!("{extension} is supported, but {requires} is not"));
        }
    }

    Ok(results.to_status())
}

/// A query into memory pre-filled with zeroes and with 0xFF, which `ValidateQueryBits::validateInitComplete` compares.
fn query_twice<T: Copy>(query: &dyn Fn(*mut T)) -> (T, T) {
    let run = |fill: u8| {
        let mut value = MaybeUninit::<T>::uninit();
        unsafe {
            std::ptr::write_bytes(value.as_mut_ptr().cast::<u8>(), fill, size_of::<T>());
            query(value.as_mut_ptr());
            value.assume_init()
        }
    };
    (run(0x00), run(0xFF))
}

/// `deviceFeatures`
fn device_features(context: &Context<'_>) -> TestOutcome {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let features = unsafe { instance.get_physical_device_features(physical_device) };
    log::info!("device = {physical_device:?}");
    log::info!("{features:?}");

    // Requirements and dependencies
    if features.robust_buffer_access == vk::FALSE {
        return Ok(TestStatus::fail("robustBufferAccess is not supported"));
    }

    let get = instance.commands().get_physical_device_features;
    let (first, second) = query_twice::<vk::PhysicalDeviceFeatures>(&|data| unsafe { get(physical_device, data) });
    let bytes = |value: &vk::PhysicalDeviceFeatures| unsafe {
        std::slice::from_raw_parts(
            std::ptr::from_ref(value).cast::<u8>(),
            size_of::<vk::PhysicalDeviceFeatures>(),
        )
    };
    if bytes(&first) != bytes(&second) {
        log::info!("deviceFeatures - VkPhysicalDeviceFeatures not completely initialized");
        return Ok(TestStatus::fail("deviceFeatures incomplete initialization"));
    }

    Ok(TestStatus::pass("Query succeeded"))
}

/// `deviceProperties`
fn device_properties(context: &Context<'_>) -> TestOutcome {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let props = unsafe { instance.get_physical_device_properties(physical_device) };
    let features = unsafe { instance.get_physical_device_features(physical_device) };

    log::info!("device = {physical_device:?}");
    log::info!("{props:?}");

    if !feature_limits::validate_feature_limits(&props, &features) {
        return Ok(TestStatus::fail("deviceProperties - feature limits failed"));
    }

    let get = instance.commands().get_physical_device_properties;
    let (first, second) = query_twice::<vk::PhysicalDeviceProperties>(&|data| unsafe { get(physical_device, data) });
    if !feature_limits::properties_init_complete(&first, &second) {
        log::info!("deviceProperties - VkPhysicalDeviceProperties not completely initialized");
        return Ok(TestStatus::fail("deviceProperties incomplete initialization"));
    }

    // Check if deviceName string is properly terminated.
    let device_name = unsafe { std::slice::from_raw_parts(props.device_name.as_ptr().cast::<u8>(), 256) };
    if !device_name.contains(&0) {
        log::info!("deviceProperties - VkPhysicalDeviceProperties deviceName not properly initialized");
        return Ok(TestStatus::fail("deviceProperties incomplete initialization"));
    }

    {
        let device_version = (
            vk::version_major(props.api_version),
            vk::version_minor(props.api_version),
        );
        // `VK_API_MAX_FRAMEWORK_VERSION`: the newest version the framework knows about.
        let deqp_version = (1, 4);

        if device_version.0 != deqp_version.0 {
            log::info!("deviceProperties - API Major Version {} is not valid", device_version.0);
            return Ok(TestStatus::fail("deviceProperties apiVersion not valid"));
        }

        if device_version.1 > deqp_version.1 {
            log::info!(
                "deviceProperties - API Minor Version {} is not valid for this version of dEQP",
                device_version.1
            );
            return Ok(TestStatus::fail("deviceProperties apiVersion not valid"));
        }
    }

    Ok(TestStatus::pass("DeviceProperites query succeeded"))
}

/// `deviceQueueFamilyProperties`
fn device_queue_family_properties(context: &Context<'_>) -> TestOutcome {
    let queue_properties = unsafe {
        context
            .get_instance()
            .get_physical_device_queue_family_properties(context.get_physical_device())
    };

    log::info!("device = {:?}", context.get_physical_device());

    for (queue_ndx, properties) in queue_properties.iter().enumerate() {
        log::info!("{queue_ndx}: {properties:?}");
    }

    Ok(TestStatus::pass("Querying queue properties succeeded"))
}

/// `deviceMemoryProperties`
fn device_memory_properties(context: &Context<'_>) -> TestOutcome {
    let mem_props = unsafe {
        context
            .get_instance()
            .get_physical_device_memory_properties(context.get_physical_device())
    };

    log::info!("device = {:?}", context.get_physical_device());
    log::info!("{mem_props:?}");

    if mem_props.memory_heap_count >= vk::MAX_MEMORY_HEAPS as u32 {
        log::info!(
            "deviceMemoryProperties - HeapCount larger than {}",
            vk::MAX_MEMORY_HEAPS
        );
        return Ok(TestStatus::fail("deviceMemoryProperties HeapCount too large"));
    }

    if mem_props.memory_heap_count == 1
        && !mem_props.memory_heaps[0]
            .flags
            .contains(vk::MemoryHeapFlags::DEVICE_LOCAL)
    {
        log::info!("deviceMemoryProperties - Single heap is not marked DEVICE_LOCAL");
        return Ok(TestStatus::fail("deviceMemoryProperties invalid HeapFlags"));
    }

    use vk::MemoryPropertyFlags as P;
    let valid_property_flags = [
        P::empty(),
        P::DEVICE_LOCAL,
        P::DEVICE_LOCAL | P::HOST_VISIBLE | P::HOST_COHERENT,
        P::DEVICE_LOCAL | P::HOST_VISIBLE | P::HOST_CACHED,
        P::DEVICE_LOCAL | P::HOST_VISIBLE | P::HOST_CACHED | P::HOST_COHERENT,
        P::HOST_VISIBLE | P::HOST_COHERENT,
        P::HOST_VISIBLE | P::HOST_CACHED,
        P::HOST_VISIBLE | P::HOST_CACHED | P::HOST_COHERENT,
        P::DEVICE_LOCAL | P::LAZILY_ALLOCATED,
    ];

    let required_property_flags = [P::HOST_VISIBLE | P::HOST_COHERENT];
    let mut required_flags_found = [false; 1];

    for memory_type in &mem_props.memory_types[..mem_props.memory_type_count as usize] {
        if memory_type.heap_index >= mem_props.memory_heap_count {
            log::info!(
                "deviceMemoryProperties - heapIndex {} larger than heapCount",
                memory_type.heap_index
            );
            return Ok(TestStatus::fail("deviceMemoryProperties - invalid heapIndex"));
        }

        let bits_to_check = P::DEVICE_LOCAL | P::HOST_VISIBLE | P::HOST_COHERENT | P::HOST_CACHED | P::LAZILY_ALLOCATED;

        for (ndx, required) in required_property_flags.iter().enumerate() {
            if memory_type.property_flags.contains(*required) {
                required_flags_found[ndx] = true;
            }
        }

        if !valid_property_flags.contains(&(memory_type.property_flags & bits_to_check)) {
            log::info!(
                "deviceMemoryProperties - propertyFlags {:?} not valid",
                memory_type.property_flags
            );
            return Ok(TestStatus::fail("deviceMemoryProperties propertyFlags not valid"));
        }

        let heap_is_device_local = mem_props.memory_heaps[memory_type.heap_index as usize]
            .flags
            .contains(vk::MemoryHeapFlags::DEVICE_LOCAL);
        if memory_type.property_flags.contains(P::DEVICE_LOCAL) {
            if !heap_is_device_local {
                log::info!(
                    "deviceMemoryProperties - DEVICE_LOCAL memory type references heap which is not DEVICE_LOCAL"
                );
                return Ok(TestStatus::fail(
                    "deviceMemoryProperties inconsistent memoryType and HeapFlags",
                ));
            }
        } else if heap_is_device_local {
            log::info!("deviceMemoryProperties - non-DEVICE_LOCAL memory type references heap with is DEVICE_LOCAL");
            return Ok(TestStatus::fail(
                "deviceMemoryProperties inconsistent memoryType and HeapFlags",
            ));
        }
    }

    if let Some(missing) = required_flags_found.iter().position(|found| !found) {
        log::info!(
            "deviceMemoryProperties - required property flags {:?} not found",
            required_property_flags[missing]
        );
        return Ok(TestStatus::fail("deviceMemoryProperties propertyFlags not valid"));
    }

    Ok(TestStatus::pass("Querying memory properties succeeded"))
}

/// `checkMemoryBudgetSupport`
fn check_memory_budget_support(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_memory_budget")
}

/// `deviceMemoryBudgetProperties`
fn device_memory_budget_properties(context: &Context<'_>) -> TestOutcome {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let mut budget_props = vk::PhysicalDeviceMemoryBudgetPropertiesEXT::default();
    let mut mem_props = vk::PhysicalDeviceMemoryProperties2::builder().push_next(&mut budget_props);
    unsafe { instance.get_physical_device_memory_properties2(physical_device, &mut mem_props) };
    let heap_count = mem_props.memory_properties.memory_heap_count as usize;
    let heaps = mem_props.memory_properties.memory_heaps;

    log::info!("device = {physical_device:?}");
    log::info!("{budget_props:?}");

    for (i, heap) in heaps.iter().enumerate().take(heap_count) {
        if budget_props.heap_budget[i] == 0 {
            log::info!("deviceMemoryBudgetProperties - Supported heaps must report nonzero budget");
            return Err(TestError::Fail(
                "deviceMemoryBudgetProperties invalid heap budget (zero)".to_string(),
            ));
        }
        if budget_props.heap_budget[i] > heap.size {
            log::info!("deviceMemoryBudgetProperties - Heap budget must be less than or equal to heap size");
            return Err(TestError::Fail(
                "deviceMemoryBudgetProperties invalid heap budget (too large)".to_string(),
            ));
        }
    }

    for i in heap_count..vk::MAX_MEMORY_HEAPS {
        if budget_props.heap_budget[i] != 0 || budget_props.heap_usage[i] != 0 {
            log::info!("deviceMemoryBudgetProperties - Unused heaps must report budget/usage of zero");
            return Err(TestError::Fail(
                "deviceMemoryBudgetProperties invalid unused heaps".to_string(),
            ));
        }
    }

    Ok(TestStatus::pass("Querying memory budget properties succeeded"))
}

/// `GUARD_SIZE` and `GUARD_VALUE`: bytes after a queried structure that the query must leave alone.
const GUARD_SIZE: usize = 0x20;
const GUARD_VALUE: u8 = 0xCD;

/// `MemoryBudgetInfo`
struct MemoryBudgetInfo {
    mem_props: vk::PhysicalDeviceMemoryProperties,
    budget_props: vk::PhysicalDeviceMemoryBudgetPropertiesEXT,
}

/// `getBudgetInfo`: the budget structure is queried into a buffer with a guard behind it.
fn get_budget_info(instance: &Instance, physical_device: vk::PhysicalDevice) -> Result<MemoryBudgetInfo, TestError> {
    let budget_size = size_of::<vk::PhysicalDeviceMemoryBudgetPropertiesEXT>();
    let mut buffer = vec![0u64; (budget_size + GUARD_SIZE).div_ceil(8)];
    let bytes = buffer.as_mut_ptr().cast::<u8>();
    unsafe { std::ptr::write_bytes(bytes, GUARD_VALUE, (budget_size + GUARD_SIZE).div_ceil(8) * 8) };

    let budget_ptr = bytes.cast::<vk::PhysicalDeviceMemoryBudgetPropertiesEXT>();
    unsafe {
        budget_ptr.write(vk::PhysicalDeviceMemoryBudgetPropertiesEXT::default());
        std::ptr::write_bytes(bytes.add(budget_size), GUARD_VALUE, GUARD_SIZE);
    }

    let mut mem_props2 = vk::PhysicalDeviceMemoryProperties2 {
        next: budget_ptr.cast::<c_void>(),
        ..Default::default()
    };
    unsafe { instance.get_physical_device_memory_properties2(physical_device, &mut mem_props2) };

    for ndx in 0..GUARD_SIZE {
        if unsafe { *bytes.add(budget_size + ndx) } != GUARD_VALUE {
            log::info!("deviceMemoryBudgetProperties - Guard offset {ndx} not valid");
            return Err(TestError::Fail(
                "deviceMemoryBudgetProperties buffer overflow".to_string(),
            ));
        }
    }

    Ok(MemoryBudgetInfo {
        mem_props: mem_props2.memory_properties,
        budget_props: unsafe { budget_ptr.read() },
    })
}

struct DeviceGuard(Device);

impl Drop for DeviceGuard {
    fn drop(&mut self) {
        unsafe { self.0.destroy_device(None) };
    }
}

struct BufferGuard<'a>(&'a Device, vk::Buffer);

impl Drop for BufferGuard<'_> {
    fn drop(&mut self) {
        unsafe { self.0.destroy_buffer(self.1, None) };
    }
}

struct MemoryGuard<'a>(&'a Device, vk::DeviceMemory);

impl Drop for MemoryGuard<'_> {
    fn drop(&mut self) {
        unsafe { self.0.free_memory(self.1, None) };
    }
}

/// `HostIntent`
#[derive(Clone, Copy, PartialEq, Eq)]
enum HostIntent {
    None,
    R,
    W,
    Rw,
}

/// `selectBestMemoryType`: of the types a resource allows, the one that suits the host's use of it best - cached for reads, uncached for
/// writes, and the first that has the properties at all when the host does not touch it.
fn select_best_memory_type(
    mem_props: &vk::PhysicalDeviceMemoryProperties,
    memory_type_bits: u32,
    host_visible: bool,
    intent: HostIntent,
) -> Result<u32, TestError> {
    use vk::MemoryPropertyFlags as P;

    let candidates = (0..mem_props.memory_type_count).filter(|&ndx| {
        let flags = mem_props.memory_types[ndx as usize].property_flags;
        memory_type_bits & (1 << ndx) != 0 && (!host_visible || flags.contains(P::HOST_VISIBLE))
    });

    let score = |ndx: u32| {
        let flags = mem_props.memory_types[ndx as usize].property_flags;
        match intent {
            HostIntent::None => 0,
            HostIntent::R | HostIntent::Rw => {
                i32::from(flags.contains(P::HOST_CACHED)) * 2 + i32::from(flags.contains(P::HOST_COHERENT))
            }
            HostIntent::W => {
                i32::from(!flags.contains(P::HOST_CACHED)) * 2 + i32::from(flags.contains(P::HOST_COHERENT))
            }
        }
    };

    candidates
        .max_by_key(|&ndx| (score(ndx), std::cmp::Reverse(ndx)))
        .ok_or_else(|| TestError::NotSupported("No compatible memory type found".to_string()))
}

/// `memoryBudgetMultiInstance`
fn memory_budget_multi_instance(context: &Context<'_>) -> TestOutcome {
    let instance1 = create_custom_instance_with_extension(context, "VK_KHR_get_physical_device_properties2")?;
    let instance2 = create_custom_instance_with_extension(context, "VK_KHR_get_physical_device_properties2")?;
    let (vki1, phys_dev1) = (&instance1.instance, instance1.physical_device);
    let (vki2, phys_dev2) = (&instance2.instance, instance2.physical_device);

    // Both devices should refer to the same dev/driver combo.
    let budget_info1 = get_budget_info(vki1, phys_dev1)?;
    let budget_info2 = get_budget_info(vki2, phys_dev2)?;

    // Make sure both devices report basically the same information.
    if budget_info1.mem_props.memory_heap_count != budget_info2.mem_props.memory_heap_count {
        return Err(TestError::Fail(
            "Different memory heap counts in both instances".to_string(),
        ));
    }

    if budget_info1.mem_props.memory_type_count != budget_info2.mem_props.memory_type_count {
        return Err(TestError::Fail(
            "Different memory type counts in both instances".to_string(),
        ));
    }

    // Create logical devices to do some basic allocations.
    let dev_extensions = [c"VK_EXT_memory_budget".as_ptr()];
    let queue_priorities = [1.0f32];

    let qf_index1 =
        find_queue_family_index_with_caps(vki1, phys_dev1, vk::QueueFlags::COMPUTE, vk::QueueFlags::empty())?;
    let qf_index2 =
        find_queue_family_index_with_caps(vki2, phys_dev2, vk::QueueFlags::COMPUTE, vk::QueueFlags::empty())?;

    let queue_infos1 = [vk::DeviceQueueCreateInfo::builder()
        .queue_family_index(qf_index1)
        .queue_priorities(&queue_priorities)];
    let queue_infos2 = [vk::DeviceQueueCreateInfo::builder()
        .queue_family_index(qf_index2)
        .queue_priorities(&queue_priorities)];
    let dev_create_info1 = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&queue_infos1)
        .enabled_extension_names(&dev_extensions);
    let dev_create_info2 = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&queue_infos2)
        .enabled_extension_names(&dev_extensions);

    let device1 =
        DeviceGuard(unsafe { vki1.create_device(phys_dev1, &dev_create_info1, None) }.vk_check("vkCreateDevice")?);
    let device2 =
        DeviceGuard(unsafe { vki2.create_device(phys_dev2, &dev_create_info2, None) }.vk_check("vkCreateDevice")?);
    let (vkd1, vkd2) = (&device1.0, &device2.0);

    let buffer_size: vk::DeviceSize = 4 << 20;
    let buffer_create_info = vk::BufferCreateInfo::builder()
        .size(buffer_size)
        .usage(vk::BufferUsageFlags::STORAGE_BUFFER)
        .sharing_mode(vk::SharingMode::EXCLUSIVE);

    let buffer1 = BufferGuard(
        vkd1,
        unsafe { vkd1.create_buffer(&buffer_create_info, None) }.vk_check("vkCreateBuffer")?,
    );
    let buffer2 = BufferGuard(
        vkd2,
        unsafe { vkd2.create_buffer(&buffer_create_info, None) }.vk_check("vkCreateBuffer")?,
    );

    let buffer_mem_reqs1 = unsafe { vkd1.get_buffer_memory_requirements(buffer1.1) };
    let buffer_mem_reqs2 = unsafe { vkd2.get_buffer_memory_requirements(buffer2.1) };

    // Try different memory types and, potentially, heaps.
    for host_intent in [HostIntent::None, HostIntent::R, HostIntent::W, HostIntent::Rw] {
        let host_visible = host_intent != HostIntent::None;
        let mem_type1 = select_best_memory_type(
            &budget_info1.mem_props,
            buffer_mem_reqs1.memory_type_bits,
            host_visible,
            host_intent,
        )?;
        let mem_type2 = select_best_memory_type(
            &budget_info2.mem_props,
            buffer_mem_reqs2.memory_type_bits,
            host_visible,
            host_intent,
        )?;

        // In theory, both memory types should be the same.
        if mem_type1 != mem_type2 {
            return Err(TestError::Fail("Memory types differ for identical buffers".to_string()));
        }

        let heap_index1 = budget_info1.mem_props.memory_types[mem_type1 as usize].heap_index as usize;
        let heap_index2 = budget_info2.mem_props.memory_types[mem_type2 as usize].heap_index as usize;

        if heap_index1 != heap_index2 {
            return Err(TestError::Fail(
                "Heap indices differ for the same memory types".to_string(),
            ));
        }

        let allocate_info1 = vk::MemoryAllocateInfo::builder()
            .allocation_size(buffer_mem_reqs1.size)
            .memory_type_index(mem_type1);
        let allocate_info2 = vk::MemoryAllocateInfo::builder()
            .allocation_size(buffer_mem_reqs2.size)
            .memory_type_index(mem_type2);

        let _memory1 = MemoryGuard(
            vkd1,
            unsafe { vkd1.allocate_memory(&allocate_info1, None) }.vk_check("vkAllocateMemory")?,
        );

        let after_alloc1_budget1 = get_budget_info(vki1, phys_dev1)?;

        if after_alloc1_budget1.budget_props.heap_usage[heap_index1]
            <= budget_info1.budget_props.heap_usage[heap_index1]
        {
            return Err(TestError::Fail(format!(
                "Memory heap usage not increased for heap {heap_index1}"
            )));
        }

        // Not sure about this check. The spec says this about heapBudget: "The budget includes any currently allocated device memory", and
        // heapUsage is only an estimate, so the budget being no bigger than the usage is not clearly wrong.
        if after_alloc1_budget1.budget_props.heap_budget[heap_index1]
            <= after_alloc1_budget1.budget_props.heap_usage[heap_index1]
        {
            return Err(TestError::Fail(format!(
                "Memory heap budget below heap usage for heap {heap_index1}"
            )));
        }

        // Because these are per-process, the data for the other instance should also have been affected.
        let after_alloc1_budget2 = get_budget_info(vki2, phys_dev2)?;

        if after_alloc1_budget2.budget_props.heap_usage[heap_index2]
            <= budget_info2.budget_props.heap_usage[heap_index2]
        {
            return Err(TestError::Fail(format!(
                "Memory heap usage not increased for heap {heap_index2}"
            )));
        }

        if after_alloc1_budget2.budget_props.heap_budget[heap_index2]
            <= after_alloc1_budget2.budget_props.heap_usage[heap_index2]
        {
            return Err(TestError::Fail(format!(
                "Memory heap budget below heap usage for heap {heap_index2}"
            )));
        }

        let _memory2 = MemoryGuard(
            vkd2,
            unsafe { vkd2.allocate_memory(&allocate_info2, None) }.vk_check("vkAllocateMemory")?,
        );

        let after_alloc2_budget1 = get_budget_info(vki1, phys_dev1)?;

        if after_alloc2_budget1.budget_props.heap_usage[heap_index1]
            <= after_alloc1_budget1.budget_props.heap_usage[heap_index1]
        {
            return Err(TestError::Fail(format!(
                "Memory heap usage not increased for heap {heap_index1}"
            )));
        }

        if after_alloc2_budget1.budget_props.heap_budget[heap_index1]
            <= after_alloc2_budget1.budget_props.heap_usage[heap_index1]
        {
            return Err(TestError::Fail(format!(
                "Memory heap budget below heap usage for heap {heap_index1}"
            )));
        }

        let after_alloc2_budget2 = get_budget_info(vki2, phys_dev2)?;

        if after_alloc2_budget2.budget_props.heap_usage[heap_index2]
            <= after_alloc1_budget2.budget_props.heap_usage[heap_index2]
        {
            return Err(TestError::Fail(format!(
                "Memory heap usage not increased for heap {heap_index2}"
            )));
        }

        if after_alloc2_budget2.budget_props.heap_budget[heap_index2]
            <= after_alloc2_budget2.budget_props.heap_usage[heap_index2]
        {
            return Err(TestError::Fail(format!(
                "Memory heap budget below heap usage for heap {heap_index2}"
            )));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `deviceGroupPeerMemoryFeatures`
fn device_group_peer_memory_features(context: &Context<'_>) -> TestOutcome {
    let instance = context.get_instance();
    let dev_group_idx = 0usize;
    let device_idx = 0usize;
    let queue_priorities = [1.0f32];

    let device_group_props =
        unsafe { instance.enumerate_physical_device_groups() }.vk_check("vkEnumeratePhysicalDeviceGroups")?;

    if dev_group_idx >= device_group_props.len() {
        return Err(TestError::NotSupported(format!(
            "Chosen device group index {dev_group_idx} too big: found {} device groups",
            device_group_props.len()
        )));
    }

    let group = &device_group_props[dev_group_idx];
    let num_physical_devices = group.physical_device_count;

    if device_idx >= num_physical_devices as usize {
        return Err(TestError::NotSupported(format!(
            "Chosen device index {device_idx} too big: chosen device group {dev_group_idx} has {num_physical_devices} devices"
        )));
    }

    // Need at least 2 devices for peer memory features.
    if num_physical_devices < 2 {
        return Err(TestError::NotSupported(
            "Need a device group with at least 2 physical devices".to_string(),
        ));
    }

    let physical_device = group.physical_devices[device_idx];
    let queue_props = unsafe { instance.get_physical_device_queue_family_properties(physical_device) };
    let mut queue_family_index = 0u32;
    for (queue_ndx, props) in queue_props.iter().enumerate() {
        if props.queue_flags.contains(vk::QueueFlags::GRAPHICS) {
            queue_family_index = queue_ndx as u32;
        }
    }

    let queue_infos = [vk::DeviceQueueCreateInfo::builder()
        .queue_family_index(queue_family_index)
        .queue_priorities(&queue_priorities)];
    let mut device_group_info = vk::DeviceGroupDeviceCreateInfo {
        physical_device_count: group.physical_device_count,
        physical_devices: group.physical_devices.as_ptr(),
        ..Default::default()
    };
    let device_create_info = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&queue_infos)
        .push_next(&mut device_group_info);

    let device_group = DeviceGuard(
        unsafe { instance.create_device(physical_device, &device_create_info, None) }.vk_check("vkCreateDevice")?,
    );
    let mem_props = unsafe { instance.get_physical_device_memory_properties(physical_device) };

    let peer_features_size = size_of::<vk::PeerMemoryFeatureFlags>();
    let mut buffer = vec![0u8; peer_features_size + GUARD_SIZE];
    buffer.fill(GUARD_VALUE);
    let get_peer_memory_features = device_group.0.commands().get_device_group_peer_memory_features;

    for heap_index in 0..mem_props.memory_heap_count {
        for local_device_index in 0..num_physical_devices {
            for remote_device_index in 0..num_physical_devices {
                if local_device_index == remote_device_index {
                    continue;
                }

                let peer_mem_features = buffer.as_mut_ptr().cast::<vk::PeerMemoryFeatureFlags>();
                unsafe {
                    get_peer_memory_features(
                        device_group.0.handle(),
                        heap_index,
                        local_device_index,
                        remote_device_index,
                        peer_mem_features,
                    )
                };

                // Check guard
                for ndx in 0..GUARD_SIZE {
                    if buffer[ndx + peer_features_size] != GUARD_VALUE {
                        log::info!("deviceGroupPeerMemoryFeatures - Guard offset {ndx} not valid");
                        return Ok(TestStatus::fail("deviceGroupPeerMemoryFeatures buffer overflow"));
                    }
                }

                let features = unsafe { peer_mem_features.read_unaligned() };
                let required_flag = vk::PeerMemoryFeatureFlags::COPY_DST;
                let max_valid_flag = vk::PeerMemoryFeatureFlags::COPY_SRC
                    | vk::PeerMemoryFeatureFlags::COPY_DST
                    | vk::PeerMemoryFeatureFlags::GENERIC_SRC
                    | vk::PeerMemoryFeatureFlags::GENERIC_DST;
                if !features.contains(required_flag) || features.bits() > max_valid_flag.bits() {
                    return Ok(TestStatus::fail("deviceGroupPeerMemoryFeatures invalid flag"));
                }

                log::info!("heapIndex = {heap_index}");
                log::info!("localDeviceIndex = {local_device_index}");
                log::info!("remoteDeviceIndex = {remote_device_index}");
                log::info!("PeerMemoryFeatureFlags = {features:?}");
            }
        }
    }

    Ok(TestStatus::pass("Querying deviceGroup peer memory features succeeded"))
}

/// `vkt::info::createTests`, with what `createFeatureInfoInstanceTests` and `createFeatureInfoDeviceTests` register.
/// `checkExtensionDependencies`
fn check_extension_dependencies(
    results: &mut ResultCollector,
    dependencies: &[(&str, extension_dependencies::IsSupportedFun)],
    version: (u32, u32),
    instance_extension_names: &[String],
    device_extension_names: &[String],
) {
    for (name, check) in dependencies {
        if !check(version, instance_extension_names, device_extension_names) {
            results.fail(format!("Extension {name} is missing dependency"));
        }
    }
}

/// The newest of `releasedApiVersions` the context supports, as `context.contextSupports` picks it
fn highest_supported_released_version(context: &Context<'_>) -> Option<(u32, u32)> {
    let (major, minor, _) = context.api_version();
    extension_dependencies::RELEASED_API_VERSIONS
        .into_iter()
        .find(|&(released_major, released_minor)| (released_major, released_minor) <= (major, minor))
}

/// `validateInstanceExtensionDependencies`
fn validate_instance_extension_dependencies(context: &Context<'_>) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let instance_extension_names = extension_names(&instance_extensions(context, None)?);
    if let Some(version) = highest_supported_released_version(context) {
        check_extension_dependencies(
            &mut results,
            extension_dependencies::INSTANCE_EXTENSION_DEPENDENCIES,
            version,
            &instance_extension_names,
            &[],
        );
    }
    Ok(results.to_status())
}

/// `validateDeviceExtensionDependencies`
fn validate_device_extension_dependencies(context: &Context<'_>) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let instance_extension_names = extension_names(&instance_extensions(context, None)?);
    let device_extension_names = extension_names(&device_extensions(context, None)?);
    if let Some(version) = highest_supported_released_version(context) {
        check_extension_dependencies(
            &mut results,
            extension_dependencies::DEVICE_EXTENSION_DEPENDENCIES,
            version,
            &instance_extension_names,
            &device_extension_names,
        );
    }
    Ok(results.to_status())
}

/// `validateDeviceLevelEntryPointsFromInstanceExtensions`
fn validate_device_level_entry_points_from_instance_extensions(context: &Context<'_>) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let instance_extension_names = extension_names(&instance_extensions(context, None)?);
    let instance = context.get_instance();
    let device = context.get_device();
    for (extension, entry_points) in extension_dependencies::INSTANCE_EXTENSION_DEVICE_FUNCTIONS {
        if !instance_extension_names.iter().any(|name| name == extension) {
            continue;
        }
        for entry_point in *entry_points {
            let name = std::ffi::CString::new(*entry_point).expect("entry point names have no interior NUL");
            if unsafe { instance.get_device_proc_addr(device.handle(), &name) }.is_none() {
                results.fail(format!("Missing {entry_point}"));
            }
        }
    }
    Ok(results.to_status())
}

/// `logBuildInfo`
fn log_build_info(_context: &Context<'_>) -> TestOutcome {
    log::info!(
        "DE_OS: {}\nDE_CPU: {}\nDE_PTR_SIZE: {}\nDE_ENDIANNESS: {}\nDE_COMPILER: rustc\nDE_DEBUG: {}",
        std::env::consts::OS,
        std::env::consts::ARCH,
        size_of::<usize>(),
        if cfg!(target_endian = "little") {
            "DE_LITTLE_ENDIAN"
        } else {
            "DE_BIG_ENDIAN"
        },
        cfg!(debug_assertions)
    );
    Ok(TestStatus::pass("Not validated"))
}

/// `logDeviceInfo`
fn log_device_info(context: &Context<'_>) -> TestOutcome {
    let properties = context.get_device_properties();
    let (major, minor, patch) = context.api_version();
    let device_name = unsafe { std::ffi::CStr::from_ptr(properties.device_name.as_ptr().cast()) };
    log::info!(
        "apiVersion: {major}.{minor}.{patch}\ndriverVersion: {:#x}\ndeviceName: {}\nvendorID: {:#x}\ndeviceID: {:#x}",
        properties.driver_version,
        device_name.to_string_lossy(),
        properties.vendor_id,
        properties.device_id
    );
    Ok(TestStatus::pass("Not validated"))
}

/// `logPlatformInfo`
fn log_platform_info(_context: &Context<'_>) -> TestOutcome {
    log::info!("Platform: {} ({})", std::env::consts::OS, std::env::consts::FAMILY);
    Ok(TestStatus::pass("Not validated"))
}

/// `logPlatformMemoryLimits`, at `tcu::Platform::getMemoryLimits`' defaults, which the Linux and Windows platforms do not override
fn log_platform_memory_limits(_context: &Context<'_>) -> TestOutcome {
    const TOTAL_SYSTEM_MEMORY: u64 = 256 * 1024 * 1024;
    const TOTAL_DEVICE_LOCAL_MEMORY: u64 = 128 * 1024 * 1024;
    const DEVICE_MEMORY_ALLOCATION_GRANULARITY: u64 = 64 * 1024;
    const DEVICE_PAGE_SIZE: u64 = 4096;
    const DEVICE_PAGE_TABLE_ENTRY_SIZE: u64 = 8;
    const DEVICE_PAGE_TABLE_HIERARCHY_LEVELS: u32 = 3;
    log::info!(
        "totalSystemMemory = {TOTAL_SYSTEM_MEMORY}\ntotalDeviceLocalMemory = {TOTAL_DEVICE_LOCAL_MEMORY}\ndeviceMemoryAllocationGranularity = {DEVICE_MEMORY_ALLOCATION_GRANULARITY}\ndevicePageSize = {DEVICE_PAGE_SIZE}\ndevicePageTableEntrySize = {DEVICE_PAGE_TABLE_ENTRY_SIZE}\ndevicePageTableHierarchyLevels = {DEVICE_PAGE_TABLE_HIERARCHY_LEVELS}"
    );
    if TOTAL_SYSTEM_MEMORY == 0 || DEVICE_MEMORY_ALLOCATION_GRANULARITY == 0 || !DEVICE_PAGE_SIZE.is_power_of_two() {
        return Err(TestError::Fail("invalid platform memory limits".to_string()));
    }
    Ok(TestStatus::pass("Pass"))
}

/// `deviceMandatoryFeatures`
fn device_mandatory_features(context: &Context<'_>) -> TestOutcome {
    let mut fail_messages: Vec<String> = Vec::new();
    mandatory_features::check_basic_mandatory_features(context, &mut fail_messages)?;

    let mut additional_checks_passed = true;

    // for vulkan 1.4+ we need to check complex cases that were not generated in vkMandatoryFeatures.inl
    if context.api_version() >= (1, 4, 0) {
        let mut vulkan14 = vk::PhysicalDeviceVulkan14Features::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut vulkan14);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }

        if vulkan14.host_image_copy == vk::FALSE {
            // find graphics and transfer queues
            let queue_props = unsafe {
                context
                    .get_instance()
                    .get_physical_device_queue_family_properties(context.get_physical_device())
            };
            let mut graphics_queue_ndx: Option<usize> = None;
            let mut transfer_queue_ndx: Option<usize> = None;
            for (queue_ndx, properties) in queue_props.iter().enumerate() {
                let queue_flags = properties.queue_flags;
                if queue_flags.contains(vk::QueueFlags::GRAPHICS) && graphics_queue_ndx.is_none() {
                    graphics_queue_ndx = Some(queue_ndx);
                } else if queue_flags.contains(vk::QueueFlags::TRANSFER) && transfer_queue_ndx.is_none() {
                    transfer_queue_ndx = Some(queue_ndx);
                }
            }

            if graphics_queue_ndx.is_none() || transfer_queue_ndx.is_none() {
                log::info!(
                    "Implementation that has a VK_QUEUE_GRAPHICS_BIT queue must support either the hostImageCopy feature or an additional queue that supports VK_QUEUE_TRANSFER_BIT"
                );
                additional_checks_passed = false;
            }
        }
    }

    if additional_checks_passed {
        if fail_messages.is_empty() {
            return Ok(TestStatus::pass("Passed"));
        }

        // if there is only one failure return the exact message
        if fail_messages.len() == 1 {
            return Ok(TestStatus::fail(format!(
                "Mandatory feature {} not supported",
                fail_messages[0]
            )));
        }

        // log all failures
        for message in &fail_messages {
            log::info!("Mandatory feature {message} not supported");
        }
    }

    Ok(TestStatus::fail(
        "Not all mandatory features are supported, see log and vkspec.html#features-requirements",
    ))
}

pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("info");

    // `createInfoTests`
    add_function_case_no_support(&mut group, "build", log_build_info);
    add_function_case_no_support(&mut group, "device", log_device_info);
    add_function_case_no_support(&mut group, "platform", log_platform_info);
    add_function_case_no_support(&mut group, "memory_limits", log_platform_memory_limits);

    // `createFeatureInfoInstanceTests`
    add_function_case_no_support(&mut group, "physical_devices", enumerate_physical_devices);
    add_function_case_no_support(&mut group, "physical_device_groups", enumerate_physical_device_groups);
    add_function_case_no_support(&mut group, "instance_layers", enumerate_instance_layers);
    add_function_case_no_support(&mut group, "instance_extensions", enumerate_instance_extensions);
    add_function_case_no_support(
        &mut group,
        "instance_extension_dependencies",
        validate_instance_extension_dependencies,
    );
    add_function_case_no_support(
        &mut group,
        "instance_extension_device_functions",
        validate_device_level_entry_points_from_instance_extensions,
    );

    // `createFeatureInfoDeviceTests`
    add_function_case_no_support(&mut group, "device_features", device_features);
    add_function_case_no_support(&mut group, "device_properties", device_properties);
    add_function_case_no_support(
        &mut group,
        "device_queue_family_properties",
        device_queue_family_properties,
    );
    add_function_case_no_support(&mut group, "device_memory_properties", device_memory_properties);
    add_function_case_no_support(&mut group, "device_layers", enumerate_device_layers);
    add_function_case_no_support(&mut group, "device_extensions", enumerate_device_extensions);
    add_function_case_no_support(
        &mut group,
        "device_extension_supported",
        validate_device_extension_support,
    );
    add_function_case_no_support(
        &mut group,
        "device_extension_dependencies",
        validate_device_extension_dependencies,
    );
    add_function_case_no_support(&mut group, "device_no_khx_extensions", test_no_khx_extensions);
    add_function_case_no_support(&mut group, "device_mandatory_features", device_mandatory_features);
    add_function_case(
        &mut group,
        "device_memory_budget",
        check_memory_budget_support,
        device_memory_budget_properties,
    );
    add_function_case(
        &mut group,
        "device_memory_budget_multi_instance",
        check_memory_budget_support,
        memory_budget_multi_instance,
    );

    // `createFeatureInfoDeviceGroupTests`
    add_function_case_no_support(
        &mut group,
        "device_group_peer_memory_features",
        device_group_peer_memory_features,
    );

    group
}
