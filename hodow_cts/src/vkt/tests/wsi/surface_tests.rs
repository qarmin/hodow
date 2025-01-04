// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/wsi/vktWsiSurfaceTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the `headless` platform (VK_EXT_headless_surface, needs no native window or display) and only the
// cases that do not need a surfaceless query extension or a device group: create, create_custom_allocator, create_simulate_oom, destroy_null_handle, query_support,
// query_capabilities, query_capabilities2, query_formats, query_formats2, query_present_modes. `InstanceHelper` is `create_custom_instance` with the surface
// extensions; the guard-pattern checks of `CheckIncompleteResult` are reduced to the VK_INCOMPLETE and count checks. The cases are returned keyed by their
// dotted path so `wsi::create_tests` can swap them in for the gated names.

use std::collections::HashMap;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtHeadlessSurfaceExtensionInstanceCommands, KhrGetSurfaceCapabilities2ExtensionInstanceCommands,
    KhrSurfaceExtensionInstanceCommands,
};

use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::alloc_callback_util::AllocationCallbackRecorder;
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::api::case_util::{CustomInstance, create_custom_instance, is_instance_extension_available};
use crate::vkt::{Context, TestCase, TestInstance};

const REQUIRED_INSTANCE_EXTENSIONS: [&str; 2] = ["VK_KHR_surface", "VK_EXT_headless_surface"];
const SURFACE_EXTENT_DETERMINED_BY_SWAPCHAIN_MAGIC: u32 = 0xFFFF_FFFF;

fn require_instance_extension(context: &Context<'_>, extension: &str) -> Result<(), TestError> {
    if is_instance_extension_available(context, extension) {
        Ok(())
    } else {
        Err(TestError::NotSupported(format!(
            "{extension} is not supported by this implementation"
        )))
    }
}

/// `commonCheckSupport`
pub(super) fn common_check_support(context: &Context<'_>) -> Result<(), TestError> {
    for extension in REQUIRED_INSTANCE_EXTENSIONS {
        require_instance_extension(context, extension)?;
    }
    Ok(())
}

/// `checkQuerySurfaceCapabilities2Support`
fn check_query_surface_capabilities2_support(context: &Context<'_>) -> Result<(), TestError> {
    common_check_support(context)?;
    require_instance_extension(context, "VK_KHR_get_surface_capabilities2")
}

/// `InstanceHelper`: an instance with the headless surface extensions and `extra`
pub(super) fn instance_helper(context: &Context<'_>, extra: &[&str]) -> Result<CustomInstance, TestError> {
    let mut extensions: Vec<&str> = REQUIRED_INSTANCE_EXTENSIONS.to_vec();
    extensions.extend_from_slice(extra);
    create_custom_instance(context, &extensions)
}

/// `Unique<VkSurfaceKHR>`
pub(super) struct Surface<'a> {
    pub instance: &'a Instance,
    pub surface: vk::SurfaceKHR,
}

impl<'a> Surface<'a> {
    /// `createSurface` for `TYPE_HEADLESS`
    pub(super) fn headless(instance: &'a Instance) -> Result<Self, TestError> {
        let info = vk::HeadlessSurfaceCreateInfoEXT::default();
        let surface =
            unsafe { instance.create_headless_surface_ext(&info, None) }.vk_check("vkCreateHeadlessSurfaceEXT")?;
        Ok(Self { instance, surface })
    }
}

impl Drop for Surface<'_> {
    fn drop(&mut self) {
        unsafe { self.instance.destroy_surface_khr(self.surface, None) };
    }
}

pub(super) fn num_queue_families(instance: &Instance, physical_device: vk::PhysicalDevice) -> u32 {
    unsafe { instance.get_physical_device_queue_family_properties(physical_device) }.len() as u32
}

/// `isSupportedByAnyQueue`
pub(super) fn is_supported_by_any_queue(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    surface: vk::SurfaceKHR,
) -> Result<bool, TestError> {
    for queue_family_index in 0..num_queue_families(instance, physical_device) {
        let supported =
            unsafe { instance.get_physical_device_surface_support_khr(physical_device, queue_family_index, surface) }
                .vk_check("vkGetPhysicalDeviceSurfaceSupportKHR")?;
        if supported {
            return Ok(true);
        }
    }
    Ok(false)
}

pub(super) fn physical_devices(instance: &Instance) -> Result<Vec<vk::PhysicalDevice>, TestError> {
    unsafe { instance.enumerate_physical_devices() }.vk_check("vkEnumeratePhysicalDevices")
}

/// `createSurfaceTest`
fn create_surface_test(context: &Context<'_>) -> TestOutcome {
    let helper = instance_helper(context, &[])?;
    let _surface = Surface::headless(&helper.instance)?;
    Ok(TestStatus::pass("Creating surface succeeded"))
}

/// An instance created with `allocator` as its allocation callbacks, destroyed with them on drop
pub(super) struct AllocatedInstance<'a> {
    pub instance: Instance,
    allocator: &'a vk::AllocationCallbacks,
}

impl Drop for AllocatedInstance<'_> {
    fn drop(&mut self) {
        unsafe { self.instance.destroy_instance(Some(self.allocator)) };
    }
}

/// `createInstanceWithWsi(context, wsiType, {}, pAllocator)`
pub(super) fn create_instance_with_allocator<'a>(
    context: &Context<'_>,
    allocator: &'a vk::AllocationCallbacks,
) -> Result<AllocatedInstance<'a>, TestError> {
    let platform = context.get_platform();
    let extension_ptrs: Vec<*const std::ffi::c_char> = vec![
        vk::KHR_SURFACE_EXTENSION.name.as_ptr(),
        vk::EXT_HEADLESS_SURFACE_EXTENSION.name.as_ptr(),
    ];
    let app_info = vk::ApplicationInfo::builder()
        .application_name(b"hodow_cts\0")
        .application_version(vk::make_version(0, 1, 0))
        .engine_name(b"hodow_cts\0")
        .engine_version(vk::make_version(0, 1, 0))
        .api_version(platform.api_version);
    let info = vk::InstanceCreateInfo::builder()
        .application_info(&app_info)
        .enabled_extension_names(&extension_ptrs);

    let instance = unsafe { platform.entry.create_instance(&info, Some(allocator)) }.vk_check("vkCreateInstance")?;
    Ok(AllocatedInstance { instance, allocator })
}

/// `Unique<VkSurfaceKHR>` created and destroyed with allocation callbacks
pub(super) struct AllocatedSurface<'a> {
    instance: &'a Instance,
    pub surface: vk::SurfaceKHR,
    allocator: &'a vk::AllocationCallbacks,
}

impl Drop for AllocatedSurface<'_> {
    fn drop(&mut self) {
        unsafe { self.instance.destroy_surface_khr(self.surface, Some(self.allocator)) };
    }
}

pub(super) fn create_headless_surface_with_allocator<'a>(
    instance: &'a Instance,
    allocator: &'a vk::AllocationCallbacks,
) -> Result<AllocatedSurface<'a>, vk::ErrorCode> {
    let info = vk::HeadlessSurfaceCreateInfoEXT::default();
    let surface = unsafe { instance.create_headless_surface_ext(&info, Some(allocator)) }?;
    Ok(AllocatedSurface {
        instance,
        surface,
        allocator,
    })
}

/// `1u << VK_SYSTEM_ALLOCATION_SCOPE_OBJECT | 1u << VK_SYSTEM_ALLOCATION_SCOPE_INSTANCE`
pub(super) const OBJECT_AND_INSTANCE_SCOPES: u32 = (1 << 1) | (1 << 4);

/// `createSurfaceCustomAllocatorTest`
fn create_surface_custom_allocator_test(context: &Context<'_>) -> TestOutcome {
    let recorder = AllocationCallbackRecorder::new();
    let allocation_callbacks_used;

    {
        let helper = create_instance_with_allocator(context, recorder.callbacks())?;
        let surface = create_headless_surface_with_allocator(&helper.instance, recorder.callbacks())
            .map_err(|code| TestError::Fail(format!("vkCreateHeadlessSurfaceEXT returned {code:?}")))?;
        allocation_callbacks_used = recorder.live_allocation_count() > 0;

        if !recorder.validate(OBJECT_AND_INSTANCE_SCOPES) {
            return Ok(TestStatus::fail("Detected invalid system allocation callback"));
        }
        drop(surface);
    }

    if !recorder.validate(0) {
        return Ok(TestStatus::fail("Detected invalid system allocation callback"));
    }

    if !allocation_callbacks_used {
        Ok(TestStatus::new(
            TestResult::QualityWarning,
            "Allocation callbacks were not used",
        ))
    } else {
        Ok(TestStatus::pass("Creating surface succeeded using custom allocator"))
    }
}

/// `createSurfaceSimulateOOMTest`
fn create_surface_simulate_oom_test(context: &Context<'_>) -> TestOutcome {
    for num_passing_allocs in 0..=1024u32 {
        let recorder = AllocationCallbackRecorder::new();
        let mut got_oom = false;

        log::info!("Testing with {num_passing_allocs} first allocations succeeding");

        {
            let helper = create_instance_with_allocator(context, recorder.callbacks())?;

            // OOM is not simulated for VkInstance as we don't want to spend time testing OOM paths inside instance creation.
            recorder.set_budget(Some(num_passing_allocs));

            match create_headless_surface_with_allocator(&helper.instance, recorder.callbacks()) {
                Ok(surface) => {
                    if !recorder.validate(OBJECT_AND_INSTANCE_SCOPES) {
                        return Ok(TestStatus::fail("Detected invalid system allocation callback"));
                    }
                    drop(surface);
                }
                Err(vk::ErrorCode::OUT_OF_HOST_MEMORY) => {
                    log::info!("Got VK_ERROR_OUT_OF_HOST_MEMORY");
                    got_oom = true;
                }
                Err(code) => {
                    return Err(TestError::Fail(format!("vkCreateHeadlessSurfaceEXT returned {code:?}")));
                }
            }

            recorder.set_budget(None);
        }

        if !recorder.validate(0) {
            return Ok(TestStatus::fail("Detected invalid system allocation callback"));
        }

        if !got_oom {
            log::info!("Creating surface succeeded!");

            return if num_passing_allocs == 0 {
                Ok(TestStatus::new(
                    TestResult::QualityWarning,
                    "Allocation callbacks were not used",
                ))
            } else {
                Ok(TestStatus::pass("OOM simulation completed"))
            };
        }
    }

    Ok(TestStatus::new(
        TestResult::QualityWarning,
        "Creating surface did not succeed, callback limit exceeded",
    ))
}

/// `destroyNullHandleSurfaceTest`, without the allocation recorder half
fn destroy_null_handle_surface_test(context: &Context<'_>) -> TestOutcome {
    let helper = instance_helper(context, &[])?;
    unsafe { helper.instance.destroy_surface_khr(vk::SurfaceKHR::null(), None) };
    Ok(TestStatus::pass("Destroying a VK_NULL_HANDLE surface has no effect"))
}

/// `querySurfaceSupportTest`
fn query_surface_support_test(context: &Context<'_>) -> TestOutcome {
    let helper = instance_helper(context, &[])?;
    let surface = Surface::headless(&helper.instance)?;

    for (device_ndx, &physical_device) in physical_devices(&helper.instance)?.iter().enumerate() {
        for queue_family_ndx in 0..num_queue_families(&helper.instance, physical_device) {
            let is_supported = unsafe {
                helper.instance.get_physical_device_surface_support_khr(
                    physical_device,
                    queue_family_ndx,
                    surface.surface,
                )
            }
            .vk_check("vkGetPhysicalDeviceSurfaceSupportKHR")?;
            log::info!(
                "Device {device_ndx}, queue family {queue_family_ndx}: {}supported",
                if is_supported { "" } else { "NOT " }
            );
        }
    }

    Ok(ResultCollector::new("").to_status())
}

/// `validateSurfaceCapabilities`
fn validate_surface_capabilities(results: &mut ResultCollector, capabilities: &vk::SurfaceCapabilitiesKHR) {
    results.check(capabilities.min_image_count > 0, "minImageCount must be larger than 0");

    results.check(
        capabilities.min_image_extent.width > 0 && capabilities.min_image_extent.height > 0,
        "minImageExtent dimensions must be larger than 0",
    );

    results.check(
        capabilities.max_image_extent.width > 0 && capabilities.max_image_extent.height > 0,
        "maxImageExtent dimensions must be larger than 0",
    );

    results.check(
        capabilities.min_image_extent.width <= capabilities.max_image_extent.width
            && capabilities.min_image_extent.height <= capabilities.max_image_extent.height,
        "maxImageExtent must be larger or equal to minImageExtent",
    );

    if capabilities.current_extent.width != SURFACE_EXTENT_DETERMINED_BY_SWAPCHAIN_MAGIC
        || capabilities.current_extent.height != SURFACE_EXTENT_DETERMINED_BY_SWAPCHAIN_MAGIC
    {
        results.check(
            capabilities.current_extent.width > 0 && capabilities.current_extent.height > 0,
            "currentExtent dimensions must be larger than 0",
        );

        results.check(
            (capabilities.min_image_extent.width..=capabilities.max_image_extent.width)
                .contains(&capabilities.current_extent.width)
                && (capabilities.min_image_extent.height..=capabilities.max_image_extent.height)
                    .contains(&capabilities.current_extent.height),
            "currentExtent is not in supported extent limits",
        );
    }

    results.check(
        capabilities.max_image_array_layers > 0,
        "maxImageArrayLayers must be larger than 0",
    );

    results.check(
        capabilities
            .supported_usage_flags
            .contains(vk::ImageUsageFlags::COLOR_ATTACHMENT),
        "VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT must be set in supportedUsageFlags",
    );

    results.check(
        !capabilities.supported_transforms.is_empty(),
        "At least one transform must be supported",
    );

    results.check(
        capabilities.current_transform.bits().count_ones() != 0,
        "Invalid currentTransform",
    );

    results.check(
        capabilities
            .supported_transforms
            .intersects(capabilities.current_transform),
        "currentTransform is not supported by surface",
    );

    results.check(
        !capabilities.supported_composite_alpha.is_empty(),
        "At least one alpha mode must be supported",
    );
}

/// `querySurfaceCapabilitiesTest`
fn query_surface_capabilities_test(context: &Context<'_>) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let helper = instance_helper(context, &[])?;
    let surface = Surface::headless(&helper.instance)?;

    for (device_ndx, &physical_device) in physical_devices(&helper.instance)?.iter().enumerate() {
        if is_supported_by_any_queue(&helper.instance, physical_device, surface.surface)? {
            let capabilities = unsafe {
                helper
                    .instance
                    .get_physical_device_surface_capabilities_khr(physical_device, surface.surface)
            }
            .vk_check("vkGetPhysicalDeviceSurfaceCapabilitiesKHR")?;

            log::info!("Device {device_ndx}: {capabilities:?}");

            validate_surface_capabilities(&mut results, &capabilities);
        }
        // else skip query as surface is not supported by the device
    }

    Ok(results.to_status())
}

/// `querySurfaceCapabilities2Test`
fn query_surface_capabilities2_test(context: &Context<'_>) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let helper = instance_helper(context, &["VK_KHR_get_surface_capabilities2"])?;
    let surface = Surface::headless(&helper.instance)?;

    for (device_ndx, &physical_device) in physical_devices(&helper.instance)?.iter().enumerate() {
        if is_supported_by_any_queue(&helper.instance, physical_device, surface.surface)? {
            let ref_capabilities = unsafe {
                helper
                    .instance
                    .get_physical_device_surface_capabilities_khr(physical_device, surface.surface)
            }
            .vk_check("vkGetPhysicalDeviceSurfaceCapabilitiesKHR")?;

            let surface_info = vk::PhysicalDeviceSurfaceInfo2KHR {
                surface: surface.surface,
                ..Default::default()
            };
            let mut ext_capabilities = vk::SurfaceCapabilities2KHR::default();
            unsafe {
                helper.instance.get_physical_device_surface_capabilities2_khr(
                    physical_device,
                    &surface_info,
                    &mut ext_capabilities,
                )
            }
            .vk_check("vkGetPhysicalDeviceSurfaceCapabilities2KHR")?;

            results.check(
                ext_capabilities.s_type == vk::StructureType::SURFACE_CAPABILITIES_2_KHR
                    && ext_capabilities.next.is_null(),
                "sType/pNext modified",
            );

            if ref_capabilities != ext_capabilities.surface_capabilities {
                log::info!(
                    "Device {device_ndx}: expected {ref_capabilities:?}, got {:?}",
                    ext_capabilities.surface_capabilities
                );
                results.fail("Mismatch between VK_KHR_surface and VK_KHR_surface2 query results");
            }
        }
    }

    Ok(results.to_status())
}

/// `validateSurfaceFormats`: no format is required on the headless platform, only that there are no duplicates
fn validate_surface_formats(results: &mut ResultCollector, formats: &[vk::SurfaceFormatKHR]) {
    for ndx in 1..formats.len() {
        if formats[..ndx].contains(&formats[ndx]) {
            results.fail(format!("Found duplicate entry {:?}", formats[ndx]));
        }
    }
}

/// `querySurfaceFormatsTest`
fn query_surface_formats_test(context: &Context<'_>) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let helper = instance_helper(context, &[])?;
    let surface = Surface::headless(&helper.instance)?;
    let commands = helper.instance.commands();

    for (device_ndx, &physical_device) in physical_devices(&helper.instance)?.iter().enumerate() {
        if is_supported_by_any_queue(&helper.instance, physical_device, surface.surface)? {
            let mut num_formats = 0u32;
            let result = unsafe {
                (commands.get_physical_device_surface_formats_khr)(
                    physical_device,
                    surface.surface,
                    &mut num_formats,
                    std::ptr::null_mut(),
                )
            };
            if result != vk::Result::SUCCESS {
                return Err(TestError::Fail(format!(
                    "vkGetPhysicalDeviceSurfaceFormatsKHR returned {result:?}"
                )));
            }

            let mut formats = vec![vk::SurfaceFormatKHR::default(); num_formats as usize + 1];

            if num_formats > 0 {
                let num_formats_orig = num_formats;

                // check if below call properly overwrites formats count
                num_formats += 1;

                let result = unsafe {
                    (commands.get_physical_device_surface_formats_khr)(
                        physical_device,
                        surface.surface,
                        &mut num_formats,
                        formats.as_mut_ptr(),
                    )
                };
                if result != vk::Result::SUCCESS {
                    return Err(TestError::Fail(format!(
                        "vkGetPhysicalDeviceSurfaceFormatsKHR returned {result:?}"
                    )));
                }

                if num_formats != num_formats_orig {
                    results.fail("Format count changed between calls");
                }
            }

            formats.pop();

            log::info!("Device {device_ndx}: {formats:?}");

            validate_surface_formats(&mut results, &formats);

            // `CheckPhysicalDeviceSurfaceFormatsIncompleteResult`
            if !formats.is_empty() {
                let mut used_size = (formats.len() / 3) as u32;
                let used_size_orig = used_size;
                let mut output = vec![vk::SurfaceFormatKHR::default(); formats.len()];
                let result = unsafe {
                    (commands.get_physical_device_surface_formats_khr)(
                        physical_device,
                        surface.surface,
                        &mut used_size,
                        output.as_mut_ptr(),
                    )
                };
                if used_size != used_size_orig || result != vk::Result::INCOMPLETE {
                    results.fail("Query didn't return VK_INCOMPLETE");
                }
            }
        }
        // else skip query as surface is not supported by the device
    }

    Ok(results.to_status())
}

/// `querySurfaceFormats2Test`
fn query_surface_formats2_test(context: &Context<'_>) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let helper = instance_helper(context, &["VK_KHR_get_surface_capabilities2"])?;
    let surface = Surface::headless(&helper.instance)?;

    for &physical_device in &physical_devices(&helper.instance)? {
        if is_supported_by_any_queue(&helper.instance, physical_device, surface.surface)? {
            let ref_formats = unsafe {
                helper
                    .instance
                    .get_physical_device_surface_formats_khr(physical_device, surface.surface)
            }
            .vk_check("vkGetPhysicalDeviceSurfaceFormatsKHR")?;
            let surface_info = vk::PhysicalDeviceSurfaceInfo2KHR {
                surface: surface.surface,
                ..Default::default()
            };

            let formats = unsafe {
                helper
                    .instance
                    .get_physical_device_surface_formats2_khr(physical_device, &surface_info)
            }
            .vk_check("vkGetPhysicalDeviceSurfaceFormats2KHR")?;

            if formats.len() != ref_formats.len() {
                results.fail("vkGetPhysicalDeviceSurfaceFormats2KHR() returned different number of formats");
            }

            let ext_formats: Vec<vk::SurfaceFormatKHR> = formats
                .iter()
                .map(|format| {
                    results.check(
                        format.s_type == vk::StructureType::SURFACE_FORMAT_2_KHR && format.next.is_null(),
                        "sType/pNext modified",
                    );
                    format.surface_format
                })
                .collect();

            for ref_format in &ref_formats {
                if !ext_formats.contains(ref_format) {
                    results.fail(format!("{ref_format:?} missing from extended query"));
                }
            }
        }
        // else skip query as surface is not supported by the device
    }

    Ok(results.to_status())
}

/// `validateSurfacePresentModes`
fn validate_surface_present_modes(results: &mut ResultCollector, modes: &[vk::PresentModeKHR]) {
    results.check(
        modes.contains(&vk::PresentModeKHR::FIFO),
        "VK_PRESENT_MODE_FIFO_KHR is not supported",
    );
}

/// `querySurfacePresentModesTest`
fn query_surface_present_modes_test(context: &Context<'_>) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let helper = instance_helper(context, &[])?;
    let surface = Surface::headless(&helper.instance)?;
    let commands = helper.instance.commands();

    for (device_ndx, &physical_device) in physical_devices(&helper.instance)?.iter().enumerate() {
        if is_supported_by_any_queue(&helper.instance, physical_device, surface.surface)? {
            let mut num_modes = 0u32;
            let result = unsafe {
                (commands.get_physical_device_surface_present_modes_khr)(
                    physical_device,
                    surface.surface,
                    &mut num_modes,
                    std::ptr::null_mut(),
                )
            };
            if result != vk::Result::SUCCESS {
                return Err(TestError::Fail(format!(
                    "vkGetPhysicalDeviceSurfacePresentModesKHR returned {result:?}"
                )));
            }

            let mut modes = vec![vk::PresentModeKHR::default(); num_modes as usize + 1];

            if num_modes > 0 {
                let num_modes_orig = num_modes;

                // check if below call properly overwrites mode count
                num_modes += 1;

                let result = unsafe {
                    (commands.get_physical_device_surface_present_modes_khr)(
                        physical_device,
                        surface.surface,
                        &mut num_modes,
                        modes.as_mut_ptr(),
                    )
                };
                if result != vk::Result::SUCCESS {
                    return Err(TestError::Fail(format!(
                        "vkGetPhysicalDeviceSurfacePresentModesKHR returned {result:?}"
                    )));
                }

                if num_modes != num_modes_orig {
                    return Err(TestError::Fail("Mode count changed between calls".to_string()));
                }
            }

            modes.pop();

            log::info!("Device {device_ndx}: {modes:?}");

            validate_surface_present_modes(&mut results, &modes);

            // `CheckPhysicalDeviceSurfacePresentModesIncompleteResult`
            if !modes.is_empty() {
                let mut used_size = (modes.len() / 3) as u32;
                let used_size_orig = used_size;
                let mut output = vec![vk::PresentModeKHR::default(); modes.len()];
                let result = unsafe {
                    (commands.get_physical_device_surface_present_modes_khr)(
                        physical_device,
                        surface.surface,
                        &mut used_size,
                        output.as_mut_ptr(),
                    )
                };
                if used_size != used_size_orig || result != vk::Result::INCOMPLETE {
                    results.fail("Query didn't return VK_INCOMPLETE");
                }
            }
        }
        // else skip query as surface is not supported by the device
    }

    Ok(results.to_status())
}

struct SurfaceCase {
    name: &'static str,
    check_support: fn(&Context<'_>) -> Result<(), TestError>,
    test: fn(&Context<'_>) -> TestOutcome,
}

impl TestCase for SurfaceCase {
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
        Box::new(SurfaceInstance {
            context,
            test: self.test,
        })
    }
}

struct SurfaceInstance<'a> {
    context: &'a Context<'a>,
    test: fn(&Context<'_>) -> TestOutcome,
}

impl TestInstance for SurfaceInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        (self.test)(self.context)
    }
}

/// `createSurfaceTests` for the headless platform: the cases keyed by their dotted path (`headless.surface.<name>`)
pub fn create_headless_surface_cases() -> HashMap<String, Box<dyn TestCase>> {
    let cases: [(
        &'static str,
        fn(&Context<'_>) -> Result<(), TestError>,
        fn(&Context<'_>) -> TestOutcome,
    ); 10] = [
        ("create", common_check_support, create_surface_test),
        (
            "create_custom_allocator",
            common_check_support,
            create_surface_custom_allocator_test,
        ),
        (
            "create_simulate_oom",
            common_check_support,
            create_surface_simulate_oom_test,
        ),
        ("query_support", common_check_support, query_surface_support_test),
        (
            "query_capabilities",
            common_check_support,
            query_surface_capabilities_test,
        ),
        (
            "query_capabilities2",
            check_query_surface_capabilities2_support,
            query_surface_capabilities2_test,
        ),
        ("query_formats", common_check_support, query_surface_formats_test),
        (
            "query_formats2",
            check_query_surface_capabilities2_support,
            query_surface_formats2_test,
        ),
        (
            "query_present_modes",
            common_check_support,
            query_surface_present_modes_test,
        ),
        (
            "destroy_null_handle",
            common_check_support,
            destroy_null_handle_surface_test,
        ),
    ];

    cases
        .into_iter()
        .map(|(name, check_support, test)| {
            (
                format!("headless.surface.{name}"),
                Box::new(SurfaceCase {
                    name,
                    check_support,
                    test,
                }) as Box<dyn TestCase>,
            )
        })
        .collect()
}
