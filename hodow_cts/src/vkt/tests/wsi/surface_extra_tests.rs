// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/wsi/vktWsiSurfaceTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `headless` platform cases of `surface_tests.rs` that need an extra instance extension: `query_surface_counters`,
// `query_protected_capabilities` and the four `*_surfaceless` queries (VK_GOOGLE_surfaceless_query). The cases are returned keyed by their dotted path so `wsi::create_tests`
// can swap them in for the gated names. The guard-pattern (0xcd) fills of the output structures are not reproduced.

use std::collections::HashMap;
use std::ptr;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtDisplaySurfaceCounterExtensionInstanceCommands, ExtFullScreenExclusiveExtensionInstanceCommands,
    KhrGetSurfaceCapabilities2ExtensionInstanceCommands, KhrSurfaceExtensionInstanceCommands,
};

use super::surface_tests::{
    Surface, common_check_support, instance_helper, is_supported_by_any_queue, physical_devices,
};
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::api::case_util::is_instance_extension_available;
use crate::vkt::{Context, TestCase, TestInstance};

fn require_instance_extension(context: &Context<'_>, extension: &str) -> Result<(), TestError> {
    if is_instance_extension_available(context, extension) {
        Ok(())
    } else {
        Err(TestError::NotSupported(format!(
            "{extension} is not supported by this implementation"
        )))
    }
}

fn check_query_surface_counter_support(context: &Context<'_>) -> Result<(), TestError> {
    common_check_support(context)?;
    require_instance_extension(context, "VK_KHR_display")?;
    require_instance_extension(context, "VK_EXT_display_surface_counter")
}

/// `querySurfaceCounterTest`; `isDisplaySurface` is false for the headless platform
fn query_surface_counter_test(context: &Context<'_>) -> TestOutcome {
    let helper = instance_helper(context, &["VK_KHR_display", "VK_EXT_display_surface_counter"])?;
    let surface = Surface::headless(&helper.instance)?;
    let physical_device = helper.physical_device;

    let surface_supported = unsafe {
        helper
            .instance
            .get_physical_device_surface_support_khr(physical_device, 0, surface.surface)
    }
    .unwrap_or(false);
    if !surface_supported {
        return Err(TestError::NotSupported(
            "Surface is not supported by physical device".to_string(),
        ));
    }

    let mut caps_ext = vk::SurfaceCapabilities2EXT::default();
    unsafe {
        helper
            .instance
            .get_physical_device_surface_capabilities2_ext(physical_device, surface.surface, &mut caps_ext)
    }
    .vk_check("vkGetPhysicalDeviceSurfaceCapabilities2EXT")?;
    let caps_khr = unsafe {
        helper
            .instance
            .get_physical_device_surface_capabilities_khr(physical_device, surface.surface)
    }
    .vk_check("vkGetPhysicalDeviceSurfaceCapabilitiesKHR")?;

    // sameSurfaceCapabilities
    let same = caps_khr.min_image_count == caps_ext.min_image_count
        && caps_khr.max_image_count == caps_ext.max_image_count
        && caps_khr.current_extent == caps_ext.current_extent
        && caps_khr.min_image_extent == caps_ext.min_image_extent
        && caps_khr.max_image_extent == caps_ext.max_image_extent
        && caps_khr.max_image_array_layers == caps_ext.max_image_array_layers
        && caps_khr.supported_transforms == caps_ext.supported_transforms
        && caps_khr.current_transform == caps_ext.current_transform
        && caps_khr.supported_composite_alpha == caps_ext.supported_composite_alpha
        && caps_khr.supported_usage_flags == caps_ext.supported_usage_flags;
    if !same {
        return Ok(TestStatus::fail("KHR and EXT surface capabilities do not match"));
    }

    if !caps_ext.supported_surface_counters.is_empty() {
        return Ok(TestStatus::fail(format!(
            "supportedSurfaceCounters nonzero ({}) for non-display surface",
            caps_ext.supported_surface_counters.bits()
        )));
    }

    Ok(TestStatus::pass("Pass"))
}

fn check_query_surface_protected_capabilities_support(context: &Context<'_>) -> Result<(), TestError> {
    common_check_support(context)?;
    require_instance_extension(context, "VK_KHR_get_surface_capabilities2")?;
    require_instance_extension(context, "VK_KHR_surface_protected_capabilities")
}

/// `querySurfaceProtectedCapabilitiesTest`
fn query_surface_protected_capabilities_test(context: &Context<'_>) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let helper = instance_helper(
        context,
        &[
            "VK_KHR_get_surface_capabilities2",
            "VK_KHR_surface_protected_capabilities",
        ],
    )?;
    let surface = Surface::headless(&helper.instance)?;

    for &physical_device in &physical_devices(&helper.instance)? {
        if is_supported_by_any_queue(&helper.instance, physical_device, surface.surface)? {
            let mut protected_capabilities = vk::SurfaceProtectedCapabilitiesKHR::default();
            let mut capabilities = vk::SurfaceCapabilities2KHR {
                next: ptr::from_mut(&mut protected_capabilities).cast(),
                ..Default::default()
            };
            let surface_info = vk::PhysicalDeviceSurfaceInfo2KHR {
                surface: surface.surface,
                ..Default::default()
            };
            let info_copy = surface_info;

            unsafe {
                helper.instance.get_physical_device_surface_capabilities2_khr(
                    physical_device,
                    &surface_info,
                    &mut capabilities,
                )
            }
            .vk_check("vkGetPhysicalDeviceSurfaceCapabilities2KHR")?;

            results.check(surface_info == info_copy, "Driver wrote into input struct");
            results.check(
                capabilities.s_type == vk::StructureType::SURFACE_CAPABILITIES_2_KHR
                    && capabilities.next == ptr::from_mut(&mut protected_capabilities).cast(),
                "sType/pNext modified",
            );
            results.check(
                protected_capabilities.s_type == vk::StructureType::SURFACE_PROTECTED_CAPABILITIES_KHR
                    && protected_capabilities.next.is_null(),
                "sType/pNext modified",
            );
            results.check(
                protected_capabilities.supports_protected == 0 || protected_capabilities.supports_protected == 1,
                "supportsProtected ",
            );
        }
    }

    Ok(results.to_status())
}

fn check_google_surfaceless_query_support(context: &Context<'_>) -> Result<(), TestError> {
    common_check_support(context)?;
    require_instance_extension(context, "VK_GOOGLE_surfaceless_query")
}

/// `querySurfaceFormatsTestSurfaceless`
fn query_surface_formats_test_surfaceless(context: &Context<'_>) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let helper = instance_helper(context, &["VK_GOOGLE_surfaceless_query"])?;
    let surface = Surface::headless(&helper.instance)?;
    let null_surface = vk::SurfaceKHR::null();

    for &physical_device in &physical_devices(&helper.instance)? {
        if is_supported_by_any_queue(&helper.instance, physical_device, surface.surface)? {
            let formats_surface = unsafe {
                helper
                    .instance
                    .get_physical_device_surface_formats_khr(physical_device, surface.surface)
            }
            .vk_check("vkGetPhysicalDeviceSurfaceFormatsKHR")?;
            let formats_null = unsafe {
                helper
                    .instance
                    .get_physical_device_surface_formats_khr(physical_device, null_surface)
            }
            .vk_check("vkGetPhysicalDeviceSurfaceFormatsKHR")?;

            if formats_surface.len() != formats_null.len() {
                results.fail("Number of formats do not match");
                continue;
            }
            for (with_surface, with_null) in formats_surface.iter().zip(&formats_null) {
                if with_surface.color_space != with_null.color_space || with_surface.format != with_null.format {
                    results.fail("Surface formats do not match");
                }
            }
        }
    }

    Ok(results.to_status())
}

fn check_query_surface_formats2_support(context: &Context<'_>) -> Result<(), TestError> {
    common_check_support(context)?;
    require_instance_extension(context, "VK_KHR_get_surface_capabilities2")?;
    require_instance_extension(context, "VK_GOOGLE_surfaceless_query")
}

/// `querySurfaceFormats2TestSurfaceless`
fn query_surface_formats2_test_surfaceless(context: &Context<'_>) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let helper = instance_helper(
        context,
        &["VK_KHR_get_surface_capabilities2", "VK_GOOGLE_surfaceless_query"],
    )?;
    let surface = Surface::headless(&helper.instance)?;

    for &physical_device in &physical_devices(&helper.instance)? {
        if is_supported_by_any_queue(&helper.instance, physical_device, surface.surface)? {
            let surface_info = vk::PhysicalDeviceSurfaceInfo2KHR {
                surface: surface.surface,
                ..Default::default()
            };
            let null_surface_info = vk::PhysicalDeviceSurfaceInfo2KHR {
                surface: vk::SurfaceKHR::null(),
                ..Default::default()
            };
            let formats_surface = unsafe {
                helper
                    .instance
                    .get_physical_device_surface_formats2_khr(physical_device, &surface_info)
            }
            .vk_check("vkGetPhysicalDeviceSurfaceFormats2KHR")?;
            let formats_null = unsafe {
                helper
                    .instance
                    .get_physical_device_surface_formats2_khr(physical_device, &null_surface_info)
            }
            .vk_check("vkGetPhysicalDeviceSurfaceFormats2KHR")?;

            if formats_surface.len() != formats_null.len() {
                results.fail("Number of formats do not match");
                continue;
            }
            for (with_surface, with_null) in formats_surface.iter().zip(&formats_null) {
                if with_surface.surface_format != with_null.surface_format {
                    results.fail("Surface formats do not match");
                }
            }
        }
    }

    Ok(results.to_status())
}

/// The spec version of `VK_GOOGLE_surfaceless_query`, or 1 when the loader does not list it
fn surfaceless_query_spec_version(context: &Context<'_>) -> Result<u32, TestError> {
    let properties = unsafe {
        context
            .get_platform()
            .entry
            .enumerate_instance_extension_properties(None)
    }
    .map_err(|code| {
        TestError::Fail(format!(
            "Failed to retrieve spec version for extension VK_GOOGLE_surfaceless_query ({code:?})"
        ))
    })?;
    Ok(properties
        .iter()
        .find(|property| property.extension_name.to_string_lossy() == "VK_GOOGLE_surfaceless_query")
        .map_or(1, |property| property.spec_version))
}

const VALID_SURFACELESS_PRESENT_MODES: [vk::PresentModeKHR; 3] = [
    vk::PresentModeKHR::FIFO,
    vk::PresentModeKHR::SHARED_DEMAND_REFRESH,
    vk::PresentModeKHR::SHARED_CONTINUOUS_REFRESH,
];

/// `querySurfacePresentModesTestSurfaceless`
fn query_surface_present_modes_test_surfaceless(context: &Context<'_>) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let helper = instance_helper(context, &["VK_GOOGLE_surfaceless_query"])?;
    let surface = Surface::headless(&helper.instance)?;
    let null_surface = vk::SurfaceKHR::null();

    let extension_version = surfaceless_query_spec_version(context)?;
    log::info!("Checking spec version {extension_version} for VK_GOOGLE_surfaceless_query");
    let check_deprecated_version = extension_version < 2;

    for &physical_device in &physical_devices(&helper.instance)? {
        let modes_null = unsafe {
            helper
                .instance
                .get_physical_device_surface_present_modes_khr(physical_device, null_surface)
        }
        .vk_check("vkGetPhysicalDeviceSurfacePresentModesKHR");

        if check_deprecated_version {
            // checkDeprecatedExtensionGoogleSurfacelessQuery
            if !is_supported_by_any_queue(&helper.instance, physical_device, surface.surface)? {
                continue;
            }
            let modes_surface = unsafe {
                helper
                    .instance
                    .get_physical_device_surface_present_modes_khr(physical_device, surface.surface)
            }
            .vk_check("vkGetPhysicalDeviceSurfacePresentModesKHR")?;
            let modes_null = modes_null?;
            if modes_null.is_empty() {
                continue;
            }

            // Actual surface needs to have at least the amount of modes that null surface has
            if modes_surface.len() < modes_null.len() {
                results.fail("Number of modes does not match");
                continue;
            }

            // All modes present in null surface should also be present in actual surface
            if let Some(mode) = modes_null.iter().find(|mode| !modes_surface.contains(mode)) {
                results.fail(format!("Present mode mismatch with mode: {mode:?}"));
            }
        } else {
            // checkExtensionGoogleSurfacelessQuery
            let modes_null = modes_null?;
            if let Some(mode) = modes_null
                .iter()
                .find(|mode| !VALID_SURFACELESS_PRESENT_MODES.contains(mode))
            {
                results.fail(format!("Present mode mismatch with mode: {mode:?}"));
            }
        }
    }

    Ok(results.to_status())
}

fn check_query_surface_present_modes2_support(context: &Context<'_>) -> Result<(), TestError> {
    common_check_support(context)?;
    require_instance_extension(context, "VK_GOOGLE_surfaceless_query")?;
    context.require_device_functionality("VK_EXT_full_screen_exclusive")
}

/// `querySurfacePresentModes2TestSurfaceless`
fn query_surface_present_modes2_test_surfaceless(context: &Context<'_>) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let helper = instance_helper(context, &["VK_GOOGLE_surfaceless_query"])?;
    let _surface = Surface::headless(&helper.instance)?;

    if !context.is_device_functionality_supported("VK_EXT_full_screen_exclusive") {
        return Ok(TestStatus::new(
            crate::tcu::TestResult::NotSupported,
            "Extension VK_EXT_full_screen_exclusive not supported",
        ));
    }

    // Ensure "VK_GOOGLE_surfaceless_query" extension's spec version is at least 2
    if surfaceless_query_spec_version(context)? < 2 {
        return Ok(TestStatus::new(
            crate::tcu::TestResult::NotSupported,
            "VK_GOOGLE_surfaceless_query is version 1. Need version 2 or higher",
        ));
    }

    for &physical_device in &physical_devices(&helper.instance)? {
        let null_surface_info = vk::PhysicalDeviceSurfaceInfo2KHR {
            surface: vk::SurfaceKHR::null(),
            ..Default::default()
        };
        let modes_null = unsafe {
            helper
                .instance
                .get_physical_device_surface_present_modes2_ext(physical_device, &null_surface_info)
        }
        .vk_check("vkGetPhysicalDeviceSurfacePresentModes2EXT")?;

        if let Some(mode) = modes_null
            .iter()
            .find(|mode| !VALID_SURFACELESS_PRESENT_MODES.contains(mode))
        {
            results.fail(format!("Present mode mismatch with mode: {mode:?}"));
        }
    }

    Ok(results.to_status())
}

struct ExtraSurfaceCase {
    name: &'static str,
    check_support: fn(&Context<'_>) -> Result<(), TestError>,
    test: fn(&Context<'_>) -> TestOutcome,
}

impl TestCase for ExtraSurfaceCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        (self.check_support)(context)
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ExtraSurfaceInstance {
            context,
            test: self.test,
        })
    }
}

struct ExtraSurfaceInstance<'a> {
    context: &'a Context<'a>,
    test: fn(&Context<'_>) -> TestOutcome,
}

impl TestInstance for ExtraSurfaceInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        (self.test)(self.context)
    }
}

/// `createSurfaceTests` for the headless platform, the cases that need an extra instance extension: `headless.surface.<name>`
pub fn create_headless_surface_extra_cases() -> HashMap<String, Box<dyn TestCase>> {
    let cases: [(
        &'static str,
        fn(&Context<'_>) -> Result<(), TestError>,
        fn(&Context<'_>) -> TestOutcome,
    ); 6] = [
        (
            "query_protected_capabilities",
            check_query_surface_protected_capabilities_support,
            query_surface_protected_capabilities_test,
        ),
        (
            "query_surface_counters",
            check_query_surface_counter_support,
            query_surface_counter_test,
        ),
        (
            "query_formats_surfaceless",
            check_google_surfaceless_query_support,
            query_surface_formats_test_surfaceless,
        ),
        (
            "query_present_modes_surfaceless",
            check_google_surfaceless_query_support,
            query_surface_present_modes_test_surfaceless,
        ),
        (
            "query_present_modes2_surfaceless",
            check_query_surface_present_modes2_support,
            query_surface_present_modes2_test_surfaceless,
        ),
        (
            "query_formats2_surfaceless",
            check_query_surface_formats2_support,
            query_surface_formats2_test_surfaceless,
        ),
    ];

    cases
        .into_iter()
        .map(|(name, check_support, test)| {
            (
                format!("headless.surface.{name}"),
                Box::new(ExtraSurfaceCase {
                    name,
                    check_support,
                    test,
                }) as Box<dyn TestCase>,
            )
        })
        .collect()
}
