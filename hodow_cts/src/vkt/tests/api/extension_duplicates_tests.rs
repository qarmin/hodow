// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiExtensionDuplicatesTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `getDeviceCreationExtensions` is `Context::get_device_extensions` here: the context
// device is created with every advertised extension bar the presentation family, and
// the same filter is applied below so the duplicated device is built from that set.

use std::ffi::{CString, c_char};

use vulkanalia::prelude::v1_0::*;

use super::case_util::add_case;
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

/// `ut::StringDuplicator`. The source is deduplicated first; the i-th distinct name is then
/// repeated twice when i is even, three times when i is odd and divisible by 3, and four
/// times otherwise. `by_pointers` repeats one pointer, `by_names` gives every repeat its own
/// allocation.
struct StringDuplicator {
    source: Vec<CString>,
}

impl StringDuplicator {
    fn new(src: &[String]) -> Self {
        let mut distinct: Vec<CString> = Vec::new();
        for name in src {
            if let Ok(c) = CString::new(name.as_str())
                && !distinct.contains(&c)
            {
                distinct.push(c);
            }
        }
        Self { source: distinct }
    }

    fn get_input_count(&self) -> usize {
        self.source.len()
    }

    fn repeat_count(i: usize) -> usize {
        if i.is_multiple_of(2) {
            2
        } else if i.is_multiple_of(3) {
            3
        } else {
            4
        }
    }

    /// `duplicatePointers`
    fn duplicate_pointers(&self) -> Vec<*const c_char> {
        let mut r = Vec::new();
        for (i, p) in self.source.iter().enumerate() {
            for _ in 0..Self::repeat_count(i) {
                r.push(p.as_ptr());
            }
        }
        r
    }

    /// `duplicateStrings` - the returned pointers borrow from the second value, which has
    /// to outlive them.
    fn duplicate_strings(&self) -> (Vec<*const c_char>, Vec<CString>) {
        let mut strings = Vec::new();
        for (i, p) in self.source.iter().enumerate() {
            for _ in 0..Self::repeat_count(i) {
                strings.push(p.clone());
            }
        }
        let r = strings.iter().map(|s| s.as_ptr()).collect();
        (r, strings)
    }
}

/// `InstanceExtensionDuplicatesInstance::iterate`
fn instance_extension_duplicates(context: &Context<'_>, by_pointers_or_names: bool) -> TestOutcome {
    let platform = context.get_platform();
    let available_extensions = unsafe { platform.entry.enumerate_instance_extension_properties(None) }
        .map_err(|e| TestError::InternalError(format!("vkEnumerateInstanceExtensionProperties returned {e:?}")))?;

    if available_extensions.is_empty() {
        return Ok(TestStatus::new(
            TestResult::QualityWarning,
            "Unable to perform test due to empty instance extension list",
        ));
    }

    let available_extension_names: Vec<String> = available_extensions
        .iter()
        .map(|props| props.extension_name.to_string_lossy().into_owned())
        .collect();

    let duplicator = StringDuplicator::new(&available_extension_names);
    let (duplicated_extensions, _owned_names) = if by_pointers_or_names {
        (duplicator.duplicate_pointers(), Vec::new())
    } else {
        duplicator.duplicate_strings()
    };
    let duplicated_extension_cnt = duplicated_extensions.len();

    let application_info = vk::ApplicationInfo::builder()
        .application_name(b"extension_duplicates_instance\0")
        .application_version(vk::make_version(1, 0, 0))
        .engine_name(b"extension_duplicates_instance_engine\0")
        .engine_version(vk::make_version(1, 0, 0))
        .api_version(platform.api_version);

    let instance_create_info = vk::InstanceCreateInfo::builder()
        .application_info(&application_info)
        .enabled_extension_names(&duplicated_extensions);

    match unsafe { platform.entry.create_instance(&instance_create_info, None) } {
        Ok(instance) => {
            unsafe { instance.destroy_instance(None) };
            Ok(TestStatus::pass(format!(
                "Created {duplicated_extension_cnt} duplicates of {} extensions",
                duplicator.get_input_count()
            )))
        }
        Err(res) => Ok(TestStatus::fail(format!("vkCreateInstance returned {res:?}"))),
    }
}

/// `DeviceExtensionDuplicatesInstance::iterate`
fn device_extension_duplicates(context: &Context<'_>, by_pointers_or_names: bool) -> TestOutcome {
    let idx = context.get_universal_queue_family_index();
    let qpr = [1.0f32];

    let creation_extensions: Vec<String> = context
        .get_device_extensions()
        .iter()
        .filter(|n| {
            !(n.contains("swapchain")
                || n.contains("present")
                || n.contains("display")
                || n.as_str() == "VK_EXT_hdr_metadata")
        })
        .cloned()
        .collect();
    let sd = StringDuplicator::new(&creation_extensions);

    let (dup, _owned_names) = if by_pointers_or_names {
        (sd.duplicate_pointers(), Vec::new())
    } else {
        sd.duplicate_strings()
    };
    let cnt = dup.len();
    if cnt == 0 {
        return Ok(TestStatus::new(
            TestResult::QualityWarning,
            "Unable to perform test due to empty device extension list",
        ));
    }

    let queue_create_infos = [vk::DeviceQueueCreateInfo::builder()
        .queue_family_index(idx)
        .queue_priorities(&qpr)
        .build()];
    let device_create_info = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&queue_create_infos)
        .enabled_extension_names(&dup);

    match unsafe {
        context
            .get_instance()
            .create_device(context.get_physical_device(), &device_create_info, None)
    } {
        Ok(device) => {
            unsafe { device.destroy_device(None) };
            Ok(TestStatus::pass(format!(
                "Created {cnt} duplicates of {} extensions",
                sd.get_input_count()
            )))
        }
        Err(res) => Ok(TestStatus::fail(format!("vkCreateDevice returned {res:?}"))),
    }
}

/// `ExtensionDuplicatesCase`
struct ExtensionDuplicatesCase {
    name: &'static str,
    instance_or_device: bool,
    by_pointers_or_names: bool,
}

impl TestCase for ExtensionDuplicatesCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ExtensionDuplicatesInstance {
            context,
            instance_or_device: self.instance_or_device,
            by_pointers_or_names: self.by_pointers_or_names,
        })
    }
}

struct ExtensionDuplicatesInstance<'a> {
    context: &'a Context<'a>,
    instance_or_device: bool,
    by_pointers_or_names: bool,
}

impl TestInstance for ExtensionDuplicatesInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        if self.instance_or_device {
            instance_extension_duplicates(self.context, self.by_pointers_or_names)
        } else {
            device_extension_duplicates(self.context, self.by_pointers_or_names)
        }
    }
}

/// `createExtensionDuplicatesTests`
pub fn create_extension_duplicates_tests() -> TestCaseGroup {
    let types: [(&'static str, bool); 2] = [("instance", true), ("device", false)];
    let methods: [(&'static str, bool); 2] = [("by_pointers", true), ("by_names", false)];

    // Verifies that we can create a device or an instance with duplicate extensions
    let mut root_group = TestCaseGroup::new("extension_duplicates");
    for (type_name, instance_or_device) in types {
        let mut type_group = TestCaseGroup::new(type_name);
        for (method_name, by_pointers_or_names) in methods {
            add_case(
                &mut type_group,
                ExtensionDuplicatesCase {
                    name: method_name,
                    instance_or_device,
                    by_pointers_or_names,
                },
            );
        }
        root_group.add_child(type_group);
    }

    root_group
}
