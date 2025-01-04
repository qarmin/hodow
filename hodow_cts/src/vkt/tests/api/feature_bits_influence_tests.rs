// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiFeatureInfo.cpp (`featureBitInfluenceOnDeviceCreate`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Like `feature_struct_list`, the feature structures are byte buffers of the size and member count
// described there (a header of sType and pNext followed by VkBool32 members), found by name; upstream's tables of typed members are in
// `feature_bits_table.rs`, generated from them. Each feature a core structure reports as supported is enabled on its own (with the members it depends on)
// through the core structure, and through the extension structure with its extension enabled, and a device has to be creatable every time.

use std::collections::HashMap;
use std::ffi::{CString, c_void};

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::case_util::add_function_case;
use super::feature_bits_table::{
    FEATURE_BIT_DEPENDENCIES_1_2, FEATURE_BIT_DEPENDENCIES_1_3, FEATURE_BIT_DEPENDENCIES_1_4, FEATURE_BIT_ITEMS_1_2,
    FEATURE_BIT_ITEMS_1_3, FEATURE_BIT_ITEMS_1_4, FeatureBitDependency, FeatureBitItem,
};
use super::feature_struct_list::{FEATURE_STRUCTS, FeatureStruct};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vkt::{Context, TestCaseGroup};

const HEADER_SIZE: usize = 16;

/// A feature structure as memory: `s_type` set, every member readable and writable by index.
struct StructBuffer {
    info: &'static FeatureStruct,
    words: Vec<u64>,
}

impl StructBuffer {
    fn new(struct_name: &str) -> Result<Self, TestError> {
        let info = FEATURE_STRUCTS
            .iter()
            .find(|s| s.struct_name == struct_name)
            .ok_or_else(|| TestError::InternalError(format!("{struct_name} is not in the feature structure list")))?;
        let mut buffer = Self {
            info,
            words: vec![0u64; info.size.div_ceil(8)],
        };
        buffer.clean();
        Ok(buffer)
    }

    fn as_mut_ptr(&mut self) -> *mut u8 {
        self.words.as_mut_ptr().cast()
    }

    /// `cleanVulkanStruct`
    fn clean(&mut self) {
        self.words.iter_mut().for_each(|word| *word = 0);
        let s_type = self.info.s_type;
        unsafe { std::ptr::write(self.as_mut_ptr().cast::<i32>(), s_type) };
    }

    fn field_index(&self, field: &str) -> Result<usize, TestError> {
        self.info
            .fields
            .iter()
            .position(|name| *name == field)
            .ok_or_else(|| TestError::InternalError(format!("{} has no member {field}", self.info.struct_name)))
    }

    fn get(&mut self, field: &str) -> Result<bool, TestError> {
        let index = self.field_index(field)?;
        Ok(unsafe { std::ptr::read(self.as_mut_ptr().add(HEADER_SIZE + index * 4).cast::<u32>()) } != 0)
    }

    fn set(&mut self, field: &str, value: bool) -> Result<(), TestError> {
        let index = self.field_index(field)?;
        unsafe {
            std::ptr::write(
                self.as_mut_ptr().add(HEADER_SIZE + index * 4).cast::<u32>(),
                u32::from(value),
            )
        };
        Ok(())
    }
}

/// `createTestDevice`
fn create_test_device(context: &Context<'_>, next: *const c_void, extensions: &[&str]) -> Result<(), TestError> {
    let queue_priorities = [1.0f32];
    let queue_create_infos = [vk::DeviceQueueCreateInfo::builder()
        .queue_family_index(0)
        .queue_priorities(&queue_priorities)
        .build()];
    let names: Vec<CString> = extensions
        .iter()
        .map(|name| CString::new(*name).expect("an extension name has no NUL"))
        .collect();
    let name_pointers: Vec<*const std::ffi::c_char> = names.iter().map(|name| name.as_ptr()).collect();
    let mut device_create_info = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&queue_create_infos)
        .enabled_extension_names(&name_pointers)
        .build();
    device_create_info.next = next;

    let device = unsafe {
        context
            .get_instance()
            .create_device(context.get_physical_device(), &device_create_info, None)
    }
    .vk_check("vkCreateDevice")?;
    let queue = unsafe { device.get_device_queue(0, 0) };
    let result = unsafe { device.queue_wait_idle(queue) }.vk_check("vkQueueWaitIdle");
    unsafe { device.destroy_device(None) };
    result
}

fn set_dependencies(
    buffer: &mut StructBuffer,
    dependencies: &[FeatureBitDependency],
    field: &str,
) -> Result<(), TestError> {
    for dependency in dependencies {
        if dependency.structure == buffer.info.struct_name && dependency.field == field {
            buffer.set(dependency.depends_on, true)?;
        }
    }
    Ok(())
}

/// `featureBitInfluenceOnDeviceCreate`
fn feature_bit_influence_on_device_create(
    context: &Context<'_>,
    version: (u32, u32),
    items: &[FeatureBitItem],
    dependencies: &[FeatureBitDependency],
) -> TestOutcome {
    let (major, minor, _) = context.api_version();
    if (major, minor) < version {
        return Err(TestError::NotSupported(format!(
            "Vulkan {}.{} is not supported",
            version.0, version.1
        )));
    }
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();
    let device_extensions = unsafe { instance.enumerate_device_extension_properties(physical_device, None) }
        .vk_check("vkEnumerateDeviceExtensionProperties")?;
    let extension_supported = |name: &str| {
        device_extensions.iter().any(|extension| {
            unsafe { std::ffi::CStr::from_ptr(extension.extension_name.as_ptr()) }.to_bytes() == name.as_bytes()
        })
    };

    let mut features2 = vk::PhysicalDeviceFeatures2::default();
    let mut buffers: HashMap<&'static str, StructBuffer> = HashMap::new();

    for item in items {
        // Core test.
        {
            let core = match buffers.entry(item.core_struct) {
                std::collections::hash_map::Entry::Occupied(entry) => entry.into_mut(),
                std::collections::hash_map::Entry::Vacant(entry) => entry.insert(StructBuffer::new(item.core_struct)?),
            };
            features2.next = core.as_mut_ptr().cast();
            unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
            let state = core.get(item.field)?;
            if state {
                core.clean();
                core.set(item.field, true)?;
                set_dependencies(core, dependencies, item.field)?;
                create_test_device(context, (&features2 as *const vk::PhysicalDeviceFeatures2).cast(), &[])?;
            }
        }

        // Extension test. The members that have no structure of their own (`descriptorIndexing`, `samplerFilterMinmax`) are never reported.
        if item.ext_struct != "unused" && item.ext_string.is_none_or(extension_supported) {
            let ext = match buffers.entry(item.ext_struct) {
                std::collections::hash_map::Entry::Occupied(entry) => entry.into_mut(),
                std::collections::hash_map::Entry::Vacant(entry) => entry.insert(StructBuffer::new(item.ext_struct)?),
            };
            features2.next = ext.as_mut_ptr().cast();
            unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
            let state = ext.get(item.field)?;
            if state {
                ext.clean();
                ext.set(item.field, true)?;
                set_dependencies(ext, dependencies, item.field)?;
                let extensions: Vec<&str> = item.ext_string.into_iter().collect();
                create_test_device(
                    context,
                    (&features2 as *const vk::PhysicalDeviceFeatures2).cast(),
                    &extensions,
                )?;
            }
        }
    }
    Ok(TestStatus::pass("pass"))
}

fn vulkan12(context: &Context<'_>) -> TestOutcome {
    feature_bit_influence_on_device_create(context, (1, 2), FEATURE_BIT_ITEMS_1_2, FEATURE_BIT_DEPENDENCIES_1_2)
}

fn vulkan13(context: &Context<'_>) -> TestOutcome {
    feature_bit_influence_on_device_create(context, (1, 3), FEATURE_BIT_ITEMS_1_3, FEATURE_BIT_DEPENDENCIES_1_3)
}

fn vulkan14(context: &Context<'_>) -> TestOutcome {
    feature_bit_influence_on_device_create(context, (1, 4), FEATURE_BIT_ITEMS_1_4, FEATURE_BIT_DEPENDENCIES_1_4)
}

fn check_api_version(context: &Context<'_>, version: (u32, u32)) -> Result<(), TestError> {
    let (major, minor, _) = context.api_version();
    if (major, minor) < version {
        return Err(TestError::NotSupported(format!(
            "Vulkan {}.{} is not supported",
            version.0, version.1
        )));
    }
    Ok(())
}

/// `feature_bits_influence` of the `vulkan1p2`, `vulkan1p3` and `vulkan1p4` groups.
pub fn add_feature_bits_influence_case(group: &mut TestCaseGroup, minor: u32) {
    match minor {
        2 => add_function_case(
            group,
            "feature_bits_influence",
            |context| check_api_version(context, (1, 2)),
            vulkan12,
        ),
        3 => add_function_case(
            group,
            "feature_bits_influence",
            |context| check_api_version(context, (1, 3)),
            vulkan13,
        ),
        4 => add_function_case(
            group,
            "feature_bits_influence",
            |context| check_api_version(context, (1, 4)),
            vulkan14,
        ),
        _ => unreachable!("only Vulkan 1.2 to 1.4 have the case"),
    }
}
