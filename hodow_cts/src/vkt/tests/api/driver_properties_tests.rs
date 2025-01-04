// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiDriverPropertiesTests.cpp
//   (the driver id table is vkKnownDriverIds.inl, the conformance table
//   vkKnownConformanceVersions.inl, both copied from the pinned upstream revision)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::case_util::add_case;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

/// `driverIds` from vkKnownDriverIds.inl, including the `_KHR` aliases and the
/// `VK_DRIVER_ID_MAX_ENUM` sentinel that upstream's table ends on (which therefore
/// matches a driver reporting 0x7FFFFFFF).
const KNOWN_DRIVER_IDS: &[i32] = &[
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    0x7FFF_FFFF,
];

/// `knownConformanceVersions` as (major, minor, subminor, patch).
const KNOWN_CONFORMANCE_VERSIONS: &[(u8, u8, u8, u8)] = &[
    (1, 4, 7, 0),
    (1, 4, 6, 2),
    (1, 4, 6, 1),
    (1, 4, 6, 0),
    (1, 4, 5, 5),
    (1, 4, 5, 4),
    (1, 4, 5, 3),
    (1, 4, 5, 2),
    (1, 4, 5, 1),
    (1, 4, 5, 0),
    (1, 4, 4, 2),
    (1, 4, 4, 1),
    (1, 4, 4, 0),
    (1, 4, 3, 3),
    (1, 4, 3, 2),
    (1, 4, 3, 1),
    (1, 4, 3, 0),
];

const VK_MAX_DRIVER_NAME_SIZE: usize = 256;
const VK_MAX_DRIVER_INFO_SIZE: usize = 256;

#[derive(Clone, Copy)]
enum TestType {
    DriverIdMatch,
    NameIsNotEmpty,
    NameZeroTerminated,
    InfoZeroTerminated,
    Version,
}

/// `isNullTerminated`
fn is_null_terminated(chars: &[std::os::raw::c_char], max_size: usize) -> bool {
    chars.iter().take(max_size).any(|&c| c == 0)
}

fn test_driver_match(props: &vk::PhysicalDeviceDriverProperties) -> Result<(), TestError> {
    // vk::DriverId is a transparent i32 whose field is private.
    let id = unsafe { std::mem::transmute::<vk::DriverId, i32>(props.driver_id) };
    if KNOWN_DRIVER_IDS.contains(&id) {
        return Ok(());
    }
    Err(TestError::Fail("Driver ID did not match any known driver".to_string()))
}

fn test_name_is_not_empty(props: &vk::PhysicalDeviceDriverProperties) -> Result<(), TestError> {
    if props.driver_name.as_array()[0] == 0 {
        return Err(TestError::Fail("Driver name is empty".to_string()));
    }
    Ok(())
}

fn test_name_zero_terminated(props: &vk::PhysicalDeviceDriverProperties) -> Result<(), TestError> {
    if !is_null_terminated(props.driver_name.as_array(), VK_MAX_DRIVER_NAME_SIZE) {
        return Err(TestError::Fail(
            "Driver name is not a null-terminated string".to_string(),
        ));
    }
    Ok(())
}

fn test_info_zero_terminated(props: &vk::PhysicalDeviceDriverProperties) -> Result<(), TestError> {
    if !is_null_terminated(props.driver_info.as_array(), VK_MAX_DRIVER_INFO_SIZE) {
        return Err(TestError::Fail(
            "Driver info is not a null-terminated string".to_string(),
        ));
    }
    Ok(())
}

fn test_version(props: &vk::PhysicalDeviceDriverProperties, used_api_version: u32) -> Result<(), TestError> {
    let api_major_version = vk::version_major(used_api_version);
    let api_minor_version = vk::version_minor(used_api_version);
    let conformance = props.conformance_version;

    if (conformance.major as u32) < api_major_version
        || (conformance.major as u32 == api_major_version && (conformance.minor as u32) < api_minor_version)
    {
        return Err(TestError::Fail(
            "Wrong driver conformance version (older than used API version)".to_string(),
        ));
    }

    let known = KNOWN_CONFORMANCE_VERSIONS
        .iter()
        .any(|&(major, minor, subminor, patch)| {
            conformance.major == major
                && conformance.minor == minor
                && conformance.subminor == subminor
                && conformance.patch == patch
        });
    if known {
        return Ok(());
    }

    Err(TestError::Fail(
        "Wrong driver conformance version (not known)".to_string(),
    ))
}

/// `testQueryProperties`
fn test_query_properties(context: &Context<'_>, test_type: TestType) -> TestOutcome {
    let memset_pattern = 0xaau8;

    let mut driver_properties = unsafe {
        let mut uninit = std::mem::MaybeUninit::<vk::PhysicalDeviceDriverProperties>::uninit();
        std::ptr::write_bytes(uninit.as_mut_ptr(), memset_pattern, 1);
        uninit.assume_init()
    };
    driver_properties.s_type = vk::StructureType::PHYSICAL_DEVICE_DRIVER_PROPERTIES;
    driver_properties.next = std::ptr::null_mut();

    {
        let mut device_properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut driver_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut device_properties2)
        };
    }

    match test_type {
        TestType::DriverIdMatch => test_driver_match(&driver_properties)?,
        TestType::NameIsNotEmpty => test_name_is_not_empty(&driver_properties)?,
        TestType::NameZeroTerminated => test_name_zero_terminated(&driver_properties)?,
        TestType::InfoZeroTerminated => test_info_zero_terminated(&driver_properties)?,
        TestType::Version => test_version(&driver_properties, context.get_device_properties().api_version)?,
    }

    Ok(TestStatus::pass("Pass"))
}

struct DriverPropertiesCase {
    name: &'static str,
    test_type: TestType,
}

impl TestCase for DriverPropertiesCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_driver_properties")
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DriverPropertiesInstance {
            context,
            test_type: self.test_type,
        })
    }
}

struct DriverPropertiesInstance<'a> {
    context: &'a Context<'a>,
    test_type: TestType,
}

impl TestInstance for DriverPropertiesInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        test_query_properties(self.context, self.test_type)
    }
}

/// `createDriverPropertiesTests`
pub fn create_driver_properties_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("driver_properties");

    let cases = [
        ("driver_id_match", TestType::DriverIdMatch),
        ("name_is_not_empty", TestType::NameIsNotEmpty),
        ("name_zero_terminated", TestType::NameZeroTerminated),
        ("info_zero_terminated", TestType::InfoZeroTerminated),
        ("conformance_version", TestType::Version),
    ];
    for (name, test_type) in cases {
        add_case(&mut group, DriverPropertiesCase { name, test_type });
    }

    group
}
