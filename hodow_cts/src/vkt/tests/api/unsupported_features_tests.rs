// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiDeviceInitializationTests.cpp
//   external/vulkancts/framework/vulkan/generated/vulkan/vkDeviceFeatures2.inl
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `addSeparateUnsupportedFeatureTests` (vkDeviceFeatureTest.inl, generated and not vendored): one case per feature struct. Like
// `createDeviceWithUnsupportedFeaturesTest`, every feature the device reports as unsupported is enabled on its own and vkCreateDevice must
// answer VK_ERROR_FEATURE_NOT_PRESENT. The struct comes from `feature_struct_list.rs` as raw bytes (sType, size, VkBool32 members from offset 16),
// the extension that owns it is enabled on the device when the core version does not provide the struct. The vendor structs of `vkDeviceFeatureTest.inl` come from
// `unsupported_feature_vendor_structs.rs`; names neither table carries are stubs.

use std::ffi::{CString, c_char, c_void};

use vulkanalia::Device;
use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::case_util::create_custom_instance;
use super::feature_struct_list::{FEATURE_STRUCTS, FeatureStruct};
use super::unsupported_feature_names::STUBBED_FEATURE_NAMES;
use super::unsupported_feature_vendor_structs::VENDOR_FEATURE_STRUCTS;
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

struct DeviceGuard(Device);

impl Drop for DeviceGuard {
    fn drop(&mut self) {
        unsafe { self.0.destroy_device(None) };
    }
}

fn read_u32(words: &[u64], byte_offset: usize) -> u32 {
    unsafe { std::ptr::read_unaligned(words.as_ptr().cast::<u8>().add(byte_offset).cast::<u32>()) }
}

fn write_u32(words: &mut [u64], byte_offset: usize, value: u32) {
    unsafe { std::ptr::write_unaligned(words.as_mut_ptr().cast::<u8>().add(byte_offset).cast::<u32>(), value) };
}

/// The struct is provided by the core version the run uses.
fn provided_by_version(context: &Context<'_>, spec: &FeatureStruct) -> bool {
    let (major, minor, _) = context.api_version();
    spec.api_version
        .is_some_and(|(want_major, want_minor)| (major, minor) >= (want_major, want_minor))
}

/// The first of the struct's extensions the device advertises.
fn advertised_extension(context: &Context<'_>, spec: &FeatureStruct) -> Option<&'static str> {
    let extensions = context.get_device_extensions();
    spec.extensions
        .iter()
        .copied()
        .find(|wanted| extensions.iter().any(|have| have == wanted))
}

/// One generated `createDeviceWithUnsupportedFeaturesTest<Struct>`.
struct UnsupportedFeaturesCase {
    spec: &'static FeatureStruct,
}

impl TestCase for UnsupportedFeaturesCase {
    fn name(&self) -> &str {
        self.spec.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if provided_by_version(context, self.spec) || advertised_extension(context, self.spec).is_some() {
            return Ok(());
        }
        Err(TestError::NotSupported(format!(
            "{} is not supported",
            self.spec.struct_name
        )))
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(UnsupportedFeaturesInstance {
            context,
            spec: self.spec,
        })
    }
}

struct UnsupportedFeaturesInstance<'a> {
    context: &'a Context<'a>,
    spec: &'static FeatureStruct,
}

impl TestInstance for UnsupportedFeaturesInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let spec = self.spec;
        let context = self.context;
        let custom = create_custom_instance(context, &[])?;
        let physical_device = custom.physical_device;
        let queue_family_index = 0u32;
        let queue_priority = [1.0f32];
        let mut result_collector = ResultCollector::new("");

        let extension = if provided_by_version(context, spec) {
            None
        } else {
            advertised_extension(context, spec)
        };
        let extension_names: Vec<CString> = extension
            .into_iter()
            .filter_map(|name| CString::new(name).ok())
            .collect();
        let extension_ptrs: Vec<*const c_char> = extension_names.iter().map(|name| name.as_ptr()).collect();

        let mut queried = vec![0u64; spec.size.div_ceil(8)];
        write_u32(&mut queried, 0, spec.s_type as u32);
        let mut features2 = vk::PhysicalDeviceFeatures2 {
            next: queried.as_mut_ptr().cast::<c_void>(),
            ..Default::default()
        };
        unsafe {
            custom
                .instance
                .get_physical_device_features2(physical_device, &mut features2)
        };
        let device_features = features2.features;

        for (index, field) in spec.fields.iter().enumerate() {
            let offset = 16 + 4 * index;

            // Test only features that are not supported.
            if read_u32(&queried, offset) != 0 {
                continue;
            }

            let mut enabled = queried.clone();
            write_u32(&mut enabled, offset, 1);

            let enabled_features2 = vk::PhysicalDeviceFeatures2 {
                next: enabled.as_mut_ptr().cast::<c_void>(),
                features: device_features,
                ..Default::default()
            };
            let queue_create_infos = [vk::DeviceQueueCreateInfo::builder()
                .queue_family_index(queue_family_index)
                .queue_priorities(&queue_priority)
                .build()];
            let mut device_create_info = vk::DeviceCreateInfo::builder()
                .queue_create_infos(&queue_create_infos)
                .enabled_extension_names(&extension_ptrs)
                .build();
            device_create_info.next = (&raw const enabled_features2).cast::<c_void>();

            match unsafe { custom.instance.create_device(physical_device, &device_create_info, None) } {
                Err(error) if error == vk::ErrorCode::FEATURE_NOT_PRESENT => {}
                Err(error) => result_collector.fail(format!(
                    "Creating a device with feature {} of {}, which was reported as unsupported, returned {error:?} instead of VK_ERROR_FEATURE_NOT_PRESENT.",
                    field, spec.struct_name
                )),
                Ok(device) => {
                    drop(DeviceGuard(device));
                    result_collector.fail(format!(
                        "Not returning VK_ERROR_FEATURE_NOT_PRESENT when creating device with feature {} of {}, which was reported as unsupported.",
                        field, spec.struct_name
                    ));
                }
            }
        }

        Ok(result_collector.to_status())
    }
}

/// A name the mustpass lists and the struct table does not carry.
struct StubbedFeaturesCase {
    name: &'static str,
}

impl TestCase for StubbedFeaturesCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, _context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(StubbedFeaturesInstance)
    }

    fn is_stub(&self) -> bool {
        true
    }
}

struct StubbedFeaturesInstance;

impl TestInstance for StubbedFeaturesInstance {
    fn iterate(&mut self) -> TestOutcome {
        Err(TestError::NotPorted(
            "the feature struct is not in feature_struct_list.rs".to_string(),
        ))
    }
}

/// `addSeparateUnsupportedFeatureTests`
pub fn add_separate_unsupported_feature_tests(group: &mut TestCaseGroup) {
    for spec in FEATURE_STRUCTS.iter().chain(VENDOR_FEATURE_STRUCTS) {
        group.add_child(Box::new(UnsupportedFeaturesCase { spec }) as Box<dyn TestCase>);
    }
    for name in STUBBED_FEATURE_NAMES {
        group.add_child(Box::new(StubbedFeaturesCase { name }) as Box<dyn TestCase>);
    }
}
