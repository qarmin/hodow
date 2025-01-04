// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/wsi/vktWsiSwapchainTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the `headless` platform and only `swapchain.create.*` and `simulate_oom.*` without the image swapchain create info cases (they need
// shaders): `createSwapchainTest` with `generateSwapchainParameterCases` for the headless platform properties (`SWAPCHAIN_EXTENT_SETS_WINDOW_SIZE`, no window features).
// `DeviceHelper` creates the device with VK_KHR_swapchain (and VK_EXT_attachment_feedback_loop_layout when the context has it) on one queue of every family that
// can present to the surface. The cases are returned keyed by their dotted path so `wsi::create_tests` can swap them in for the gated names.

use std::collections::HashMap;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::KhrSwapchainExtensionDeviceCommands;

use super::maintenance1_tests::{Resources, image_barrier};
use super::surface_tests::{
    Surface, common_check_support, create_headless_surface_with_allocator, create_instance_with_allocator,
    instance_helper, num_queue_families, physical_devices,
};
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::alloc_callback_util::AllocationCallbackRecorder;
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
enum TestDimension {
    MinImageCount,
    ImageFormat,
    ImageExtent,
    ImageArrayLayers,
    ImageUsage,
    ImageSharingMode,
    PreTransform,
    CompositeAlpha,
    PresentMode,
    Clipped,
    ExclusiveNonzero,
}

impl TestDimension {
    const ALL: [Self; 11] = [
        Self::MinImageCount,
        Self::ImageFormat,
        Self::ImageExtent,
        Self::ImageArrayLayers,
        Self::ImageUsage,
        Self::ImageSharingMode,
        Self::PreTransform,
        Self::CompositeAlpha,
        Self::PresentMode,
        Self::Clipped,
        Self::ExclusiveNonzero,
    ];

    /// `getTestDimensionName`
    fn name(self) -> &'static str {
        match self {
            Self::MinImageCount => "min_image_count",
            Self::ImageFormat => "image_format",
            Self::ImageExtent => "image_extent",
            Self::ImageArrayLayers => "image_array_layers",
            Self::ImageUsage => "image_usage",
            Self::ImageSharingMode => "image_sharing_mode",
            Self::PreTransform => "pre_transform",
            Self::CompositeAlpha => "composite_alpha",
            Self::PresentMode => "present_mode",
            Self::Clipped => "clipped",
            Self::ExclusiveNonzero => "exclusive_nonzero_queues",
        }
    }
}

/// The queue family indices (ascending) that can present to `surface`
pub(super) fn compatible_queue_family_indices(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    surface: vk::SurfaceKHR,
) -> Result<Vec<u32>, TestError> {
    use vulkanalia::vk::KhrSurfaceExtensionInstanceCommands;

    let mut indices = Vec::new();
    for queue_family_index in 0..num_queue_families(instance, physical_device) {
        let supported =
            unsafe { instance.get_physical_device_surface_support_khr(physical_device, queue_family_index, surface) }
                .vk_check("vkGetPhysicalDeviceSurfaceSupportKHR")?;
        if supported {
            indices.push(queue_family_index);
        }
    }
    Ok(indices)
}

/// `MultiQueueDeviceHelper`'s `DeviceWrapper`
pub(super) struct DeviceGuard<'a> {
    pub(super) device: Device,
    allocator: Option<&'a vk::AllocationCallbacks>,
}

impl Drop for DeviceGuard<'_> {
    fn drop(&mut self) {
        unsafe { self.device.destroy_device(self.allocator) };
    }
}

/// `createDeviceWithWsi`
pub(super) fn create_device_with_wsi<'a>(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    additional_extensions: &[&str],
    queue_family_indices: &[u32],
    allocator: Option<&'a vk::AllocationCallbacks>,
) -> Result<DeviceGuard<'a>, TestError> {
    use std::ffi::CString;

    let queue_priorities = [1.0f32];
    let queue_infos: Vec<vk::DeviceQueueCreateInfo> = queue_family_indices
        .iter()
        .map(|&family_index| {
            vk::DeviceQueueCreateInfo::builder()
                .queue_family_index(family_index)
                .queue_priorities(&queue_priorities)
                .build()
        })
        .collect();

    let mut extensions = vec!["VK_KHR_swapchain"];
    extensions.extend_from_slice(additional_extensions);
    let extension_names = extensions
        .iter()
        .map(|extension| CString::new(*extension).map_err(|e| TestError::InternalError(e.to_string())))
        .collect::<Result<Vec<_>, _>>()?;
    let extension_ptrs: Vec<*const std::ffi::c_char> = extension_names.iter().map(|name| name.as_ptr()).collect();

    let mut features2 = vk::PhysicalDeviceFeatures2::default();
    let mut private_data_create_info = vk::DevicePrivateDataCreateInfo {
        private_data_slot_request_count: 4,
        ..Default::default()
    };
    let mut private_data_features = vk::PhysicalDevicePrivateDataFeatures {
        private_data: vk::TRUE,
        ..Default::default()
    };
    let mut frame_boundary_features = vk::PhysicalDeviceFrameBoundaryFeaturesEXT {
        frame_boundary: vk::TRUE,
        ..Default::default()
    };
    let mut compression_swapchain_features = vk::PhysicalDeviceImageCompressionControlSwapchainFeaturesEXT {
        image_compression_control_swapchain: vk::TRUE,
        ..Default::default()
    };
    let mut info = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&queue_infos)
        .enabled_extension_names(&extension_ptrs)
        .push_next(&mut features2);
    if extensions.contains(&"VK_EXT_image_compression_control_swapchain") {
        info = info.push_next(&mut compression_swapchain_features);
    }
    if extensions.contains(&"VK_EXT_frame_boundary") {
        info = info.push_next(&mut frame_boundary_features);
    }
    if extensions.contains(&"VK_EXT_private_data") {
        info = info
            .push_next(&mut private_data_features)
            .push_next(&mut private_data_create_info);
    }

    let device = unsafe { instance.create_device(physical_device, &info, allocator) }.vk_check("vkCreateDevice")?;
    Ok(DeviceGuard { device, allocator })
}

/// `generateSwapchainParameterCases` for the headless platform
fn generate_swapchain_parameter_cases(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    dimension: TestDimension,
    capabilities: &vk::SurfaceCapabilitiesKHR,
    formats: &[vk::SurfaceFormatKHR],
    present_modes: &[vk::PresentModeKHR],
) -> Vec<vk::SwapchainCreateInfoKHR> {
    let default_transform = if capabilities
        .supported_transforms
        .contains(vk::SurfaceTransformFlagsKHR::IDENTITY)
    {
        vk::SurfaceTransformFlagsKHR::IDENTITY
    } else {
        capabilities.current_transform
    };
    let base_parameters = vk::SwapchainCreateInfoKHR {
        min_image_count: capabilities.min_image_count,
        image_format: formats[0].format,
        image_color_space: formats[0].color_space,
        image_extent: capabilities.min_image_extent,
        image_array_layers: 1,
        image_usage: vk::ImageUsageFlags::COLOR_ATTACHMENT,
        image_sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        pre_transform: default_transform,
        composite_alpha: vk::CompositeAlphaFlagsKHR::OPAQUE,
        present_mode: vk::PresentModeKHR::FIFO,
        clipped: vk::FALSE,
        old_swapchain: vk::SwapchainKHR::null(),
        ..Default::default()
    };

    let mut cases = Vec::new();
    let mut push = |modify: &dyn Fn(&mut vk::SwapchainCreateInfoKHR)| {
        let mut case = base_parameters;
        modify(&mut case);
        cases.push(case);
    };

    match dimension {
        TestDimension::MinImageCount => {
            let max_count = if capabilities.max_image_count > 0 {
                capabilities.max_image_count
            } else {
                capabilities.min_image_count + 16
            };
            let max_image_count_to_test = 16u32.clamp(capabilities.min_image_count, max_count);

            for image_count in capabilities.min_image_count..=max_image_count_to_test {
                push(&|case| case.min_image_count = image_count);
            }
        }

        TestDimension::ImageFormat => {
            for format in formats {
                push(&|case| {
                    case.image_format = format.format;
                    case.image_color_space = format.color_space;
                });
            }
        }

        TestDimension::ImageExtent => {
            const TEST_SIZES: [(u32, u32); 5] = [(1, 1), (16, 32), (32, 16), (632, 231), (117, 998)];

            // `SWAPCHAIN_EXTENT_SETS_WINDOW_SIZE`
            for (width, height) in TEST_SIZES {
                push(&|case| {
                    case.image_extent.width =
                        width.clamp(capabilities.min_image_extent.width, capabilities.max_image_extent.width);
                    case.image_extent.height = height.clamp(
                        capabilities.min_image_extent.height,
                        capabilities.max_image_extent.height,
                    );
                });
            }

            push(&|case| case.image_extent = capabilities.min_image_extent);
            push(&|case| case.image_extent = capabilities.max_image_extent);
        }

        TestDimension::ImageArrayLayers => {
            let max_layers = capabilities.max_image_array_layers.min(16);

            for num_layers in 1..=max_layers {
                push(&|case| case.image_array_layers = num_layers);
            }
        }

        TestDimension::ImageUsage => {
            let max_possible_mask = vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST
                | vk::ImageUsageFlags::SAMPLED
                | vk::ImageUsageFlags::STORAGE
                | vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
                | vk::ImageUsageFlags::TRANSIENT_ATTACHMENT
                | vk::ImageUsageFlags::ATTACHMENT_FEEDBACK_LOOP_EXT;

            let valid_usage_flags = capabilities.supported_usage_flags & max_possible_mask;

            for flags in 1..=valid_usage_flags.bits() {
                let usage = vk::ImageUsageFlags::from_bits_truncate(flags);
                if (usage & !valid_usage_flags).is_empty() {
                    let supported = unsafe {
                        instance.get_physical_device_image_format_properties(
                            physical_device,
                            base_parameters.image_format,
                            vk::ImageType::_2D,
                            vk::ImageTiling::OPTIMAL,
                            usage,
                            vk::ImageCreateFlags::empty(),
                        )
                    }
                    .is_ok();
                    if !supported {
                        continue;
                    }
                    push(&|case| case.image_usage = usage);
                }
            }
        }

        TestDimension::ImageSharingMode => {
            push(&|case| case.image_sharing_mode = vk::SharingMode::CONCURRENT);
        }

        TestDimension::PreTransform => {
            let mut transform = 1u32;
            while transform <= capabilities.supported_transforms.bits() {
                if transform & capabilities.supported_transforms.bits() != 0 {
                    push(&|case| case.pre_transform = vk::SurfaceTransformFlagsKHR::from_bits_truncate(transform));
                }
                transform <<= 1;
            }
        }

        TestDimension::CompositeAlpha => {
            let mut alpha_mode = 1u32;
            while alpha_mode <= capabilities.supported_composite_alpha.bits() {
                if alpha_mode & capabilities.supported_composite_alpha.bits() != 0 {
                    push(&|case| case.composite_alpha = vk::CompositeAlphaFlagsKHR::from_bits_truncate(alpha_mode));
                }
                alpha_mode <<= 1;
            }
        }

        TestDimension::PresentMode => {
            for &mode in present_modes {
                push(&|case| case.present_mode = mode);
            }
        }

        TestDimension::Clipped => {
            push(&|case| case.clipped = vk::FALSE);
            push(&|case| case.clipped = vk::TRUE);
        }

        TestDimension::ExclusiveNonzero => {
            // Test the implementation doesn't attempt to do anything with the queue index array in exclusive sharing mode.
            push(&|case| case.queue_family_index_count = 2);
        }
    }

    assert!(!cases.is_empty());
    cases
}

struct SwapchainCreateCase {
    name: &'static str,
    dimension: TestDimension,
}

impl TestCase for SwapchainCreateCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        common_check_support(context)?;
        context.require_device_functionality("VK_KHR_swapchain")
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SwapchainCreateInstance {
            context,
            dimension: self.dimension,
        })
    }
}

struct SwapchainCreateInstance<'a> {
    context: &'a Context<'a>,
    dimension: TestDimension,
}

impl SwapchainCreateInstance<'_> {
    /// `createSwapchainTest`
    fn run(&self) -> TestOutcome {
        use vulkanalia::vk::KhrSurfaceExtensionInstanceCommands;

        let context = self.context;
        let helper = instance_helper(context, &[])?;
        let surface = Surface::headless(&helper.instance)?;
        let physical_device = helper.physical_device;
        debug_assert!(physical_devices(&helper.instance)?.contains(&physical_device));

        // VUID-VkSwapchainCreateInfoKHR-imageUsage-parameter
        let mut additional_extensions = Vec::new();
        if context.is_device_functionality_supported("VK_EXT_attachment_feedback_loop_layout") {
            additional_extensions.push("VK_EXT_attachment_feedback_loop_layout");
        }

        let queue_family_indices = compatible_queue_family_indices(&helper.instance, physical_device, surface.surface)?;
        if queue_family_indices.is_empty() {
            return Err(TestError::NotSupported(
                "Device does not support presentation to the given surfaces".to_string(),
            ));
        }
        let device = create_device_with_wsi(
            &helper.instance,
            physical_device,
            &additional_extensions,
            &queue_family_indices,
            None,
        )?;

        let capabilities = unsafe {
            helper
                .instance
                .get_physical_device_surface_capabilities_khr(physical_device, surface.surface)
        }
        .vk_check("vkGetPhysicalDeviceSurfaceCapabilitiesKHR")?;
        let formats = unsafe {
            helper
                .instance
                .get_physical_device_surface_formats_khr(physical_device, surface.surface)
        }
        .vk_check("vkGetPhysicalDeviceSurfaceFormatsKHR")?;
        let present_modes = unsafe {
            helper
                .instance
                .get_physical_device_surface_present_modes_khr(physical_device, surface.surface)
        }
        .vk_check("vkGetPhysicalDeviceSurfacePresentModesKHR")?;

        let cases = generate_swapchain_parameter_cases(
            &helper.instance,
            physical_device,
            self.dimension,
            &capabilities,
            &formats,
            &present_modes,
        );

        for (case_ndx, case) in cases.iter().enumerate() {
            let subcase = format!("Sub-case {} / {}: ", case_ndx + 1, cases.len());

            let mut cur_params = *case;

            if cur_params.image_sharing_mode == vk::SharingMode::CONCURRENT {
                let num_families = queue_family_indices.len() as u32;
                if num_families < 2 {
                    return Err(TestError::NotSupported(format!(
                        "Only {num_families} queue families available for VK_SHARING_MODE_CONCURRENT"
                    )));
                }

                cur_params.queue_family_index_count = num_families;
                cur_params.queue_family_indices = queue_family_indices.as_ptr();
            }

            // Overwrite surface.
            cur_params.surface = surface.surface;

            log::info!("{subcase}{cur_params:?}");

            // imageFormat, imageUsage, imageExtent and imageArrayLayers must be supported for VK_IMAGE_TYPE_2D VK_IMAGE_TILING_OPTIMAL images
            let properties_result = unsafe {
                helper.instance.get_physical_device_image_format_properties(
                    physical_device,
                    cur_params.image_format,
                    vk::ImageType::_2D,
                    vk::ImageTiling::OPTIMAL,
                    cur_params.image_usage,
                    vk::ImageCreateFlags::empty(),
                )
            };

            log::info!("{subcase}vkGetPhysicalDeviceImageFormatProperties => {properties_result:?}");

            match properties_result {
                Ok(_) => {
                    // The maxExtents case and the minImageCount above the minimum might not be able to create the requested surface due to
                    // insufficient memory, so in these cases *only* an out of memory error is accepted
                    let may_run_out_of_memory = (self.dimension == TestDimension::ImageExtent
                        && capabilities.max_image_extent.width == cur_params.image_extent.width
                        && capabilities.max_image_extent.height == cur_params.image_extent.height)
                        || (self.dimension == TestDimension::MinImageCount
                            && cur_params.min_image_count > capabilities.min_image_count);

                    match unsafe { device.device.create_swapchain_khr(&cur_params, None) } {
                        Ok(swapchain) => {
                            unsafe { device.device.destroy_swapchain_khr(swapchain, None) };
                            log::info!("{subcase}Creating swapchain succeeded");
                        }
                        Err(code)
                            if may_run_out_of_memory
                                && (code == vk::ErrorCode::OUT_OF_HOST_MEMORY
                                    || code == vk::ErrorCode::OUT_OF_DEVICE_MEMORY) =>
                        {
                            log::info!("{subcase}vkCreateSwapchainKHR encountered {code:?}");
                        }
                        Err(code) => {
                            return Err(TestError::Fail(format!("vkCreateSwapchainKHR returned {code:?}")));
                        }
                    }
                }
                Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => {
                    log::info!(
                        "{subcase}Skip because vkGetPhysicalDeviceImageFormatProperties returned VK_ERROR_FORMAT_NOT_SUPPORTED"
                    );
                }
                Err(code) => {
                    log::info!("{subcase}Fail because vkGetPhysicalDeviceImageFormatProperties returned {code:?}");
                    return Ok(TestStatus::fail(
                        "Unexpected result from vkGetPhysicalDeviceImageFormatProperties",
                    ));
                }
            }
        }

        Ok(TestStatus::pass("No sub-case failed"))
    }
}

impl TestInstance for SwapchainCreateInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

/// `getBasicSwapchainParameters` for the headless platform
fn get_basic_swapchain_parameters(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    surface: vk::SurfaceKHR,
    desired_size: (u32, u32),
    desired_image_count: u32,
) -> Result<vk::SwapchainCreateInfoKHR, TestError> {
    use vulkanalia::vk::KhrSurfaceExtensionInstanceCommands;

    let capabilities = unsafe { instance.get_physical_device_surface_capabilities_khr(physical_device, surface) }
        .vk_check("vkGetPhysicalDeviceSurfaceCapabilitiesKHR")?;
    let formats = unsafe { instance.get_physical_device_surface_formats_khr(physical_device, surface) }
        .vk_check("vkGetPhysicalDeviceSurfaceFormatsKHR")?;
    let transform = if capabilities
        .supported_transforms
        .contains(vk::SurfaceTransformFlagsKHR::IDENTITY)
    {
        vk::SurfaceTransformFlagsKHR::IDENTITY
    } else {
        capabilities.current_transform
    };
    let max_image_count = if capabilities.max_image_count > 0 {
        capabilities.max_image_count
    } else {
        capabilities.min_image_count + desired_image_count
    };
    let first_format = formats
        .first()
        .ok_or_else(|| TestError::Fail("the surface reports no formats".to_string()))?;

    Ok(vk::SwapchainCreateInfoKHR {
        surface,
        min_image_count: desired_image_count
            .max(capabilities.min_image_count)
            .min(max_image_count),
        image_format: first_format.format,
        image_color_space: first_format.color_space,
        image_extent: vk::Extent2D {
            width: desired_size.0,
            height: desired_size.1,
        },
        image_array_layers: 1,
        image_usage: vk::ImageUsageFlags::COLOR_ATTACHMENT,
        image_sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        pre_transform: transform,
        composite_alpha: vk::CompositeAlphaFlagsKHR::OPAQUE,
        present_mode: vk::PresentModeKHR::FIFO,
        clipped: vk::FALSE,
        old_swapchain: vk::SwapchainKHR::null(),
        ..Default::default()
    })
}

/// `DeviceHelper`: a device with one queue of the first family that can present to `surface`
fn device_helper<'a>(
    context: &Context<'_>,
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    surface: vk::SurfaceKHR,
) -> Result<DeviceGuard<'a>, TestError> {
    let queue_family_indices = compatible_queue_family_indices(instance, physical_device, surface)?;
    let Some(&queue_family_index) = queue_family_indices.first() else {
        return Err(TestError::NotSupported(
            "Device does not support presentation to the given surfaces".to_string(),
        ));
    };
    let _ = context;
    create_device_with_wsi(instance, physical_device, &[], &[queue_family_index], None)
}

/// `getImagesIncompleteResultTest`
fn get_images_incomplete_result_test(context: &Context<'_>) -> TestOutcome {
    let helper = instance_helper(context, &[])?;
    let surface = Surface::headless(&helper.instance)?;
    let device = device_helper(context, &helper.instance, helper.physical_device, surface.surface)?;
    let swapchain_info =
        get_basic_swapchain_parameters(&helper.instance, helper.physical_device, surface.surface, (256, 256), 2)?;
    let swapchain = SwapchainGuard::new(&device.device, &swapchain_info)?;

    let mut swapchain_images =
        unsafe { device.device.get_swapchain_images_khr(swapchain.swapchain) }.vk_check("vkGetSwapchainImagesKHR")?;

    let used_count = (swapchain_images.len() / 2) as u32;
    let mut count = used_count;
    let result = unsafe {
        (device.device.commands().get_swapchain_images_khr)(
            device.device.handle(),
            swapchain.swapchain,
            &mut count,
            swapchain_images.as_mut_ptr(),
        )
    };

    if count != used_count || result != vk::Result::INCOMPLETE {
        Ok(TestStatus::fail("Get swapchain images didn't return VK_INCOMPLETE"))
    } else {
        Ok(TestStatus::pass("Get swapchain images tests succeeded"))
    }
}

/// `getImagesResultsCountTest`
fn get_images_results_count_test(context: &Context<'_>) -> TestOutcome {
    let helper = instance_helper(context, &[])?;
    let surface = Surface::headless(&helper.instance)?;
    let device = device_helper(context, &helper.instance, helper.physical_device, surface.surface)?;
    let swapchain_info =
        get_basic_swapchain_parameters(&helper.instance, helper.physical_device, surface.surface, (256, 256), 2)?;
    let swapchain = SwapchainGuard::new(&device.device, &swapchain_info)?;

    let commands = device.device.commands();
    let mut num_images = 0u32;
    let result = unsafe {
        (commands.get_swapchain_images_khr)(
            device.device.handle(),
            swapchain.swapchain,
            &mut num_images,
            std::ptr::null_mut(),
        )
    };
    if result != vk::Result::SUCCESS {
        return Err(TestError::Fail(format!("vkGetSwapchainImagesKHR returned {result:?}")));
    }

    if num_images > 0 {
        let mut images = vec![vk::Image::null(); num_images as usize + 1];
        let num_images_orig = num_images;

        // check if below call properly overwrites the image count
        num_images += 1;

        let result = unsafe {
            (commands.get_swapchain_images_khr)(
                device.device.handle(),
                swapchain.swapchain,
                &mut num_images,
                images.as_mut_ptr(),
            )
        };
        if result != vk::Result::SUCCESS {
            return Err(TestError::Fail(format!("vkGetSwapchainImagesKHR returned {result:?}")));
        }

        if num_images != num_images_orig {
            return Err(TestError::Fail("Image count changed between calls".to_string()));
        }
    }
    Ok(TestStatus::pass("Get swapchain images tests succeeded"))
}

/// `destroyNullHandleSwapchainTest`, without the allocation recorder half
fn destroy_null_handle_swapchain_test(context: &Context<'_>) -> TestOutcome {
    let helper = instance_helper(context, &[])?;
    let surface = Surface::headless(&helper.instance)?;
    let device = device_helper(context, &helper.instance, helper.physical_device, surface.surface)?;

    unsafe { device.device.destroy_swapchain_khr(vk::SwapchainKHR::null(), None) };

    Ok(TestStatus::pass("Destroying a VK_NULL_HANDLE surface has no effect"))
}

/// `destroyOldSwapchainTest`
fn destroy_old_swapchain_test(context: &Context<'_>) -> TestOutcome {
    let helper = instance_helper(context, &[])?;
    let surface = Surface::headless(&helper.instance)?;
    let device = device_helper(context, &helper.instance, helper.physical_device, surface.surface)?;

    // Create the first swapchain.
    let mut swapchain_info =
        get_basic_swapchain_parameters(&helper.instance, helper.physical_device, surface.surface, (256, 256), 2)?;
    let swapchain =
        unsafe { device.device.create_swapchain_khr(&swapchain_info, None) }.vk_check("vkCreateSwapchainKHR")?;

    // Create a new swapchain replacing the old one.
    swapchain_info.old_swapchain = swapchain;
    let recreated_swapchain =
        match unsafe { device.device.create_swapchain_khr(&swapchain_info, None) }.vk_check("vkCreateSwapchainKHR") {
            Ok(recreated_swapchain) => recreated_swapchain,
            Err(e) => {
                unsafe { device.device.destroy_swapchain_khr(swapchain, None) };
                return Err(e);
            }
        };

    // Destroying the old swapchain should have no effect.
    unsafe { device.device.destroy_swapchain_khr(swapchain, None) };

    // Destroy the new swapchain for cleanup.
    unsafe { device.device.destroy_swapchain_khr(recreated_swapchain, None) };

    Ok(TestStatus::pass("Destroying an old swapchain has no effect."))
}

fn create_fences<'a>(device: &'a Device, num_fences: usize) -> Result<Vec<Unique<'a, vk::Fence>>, TestError> {
    (0..num_fences)
        .map(|_| {
            let info = vk::FenceCreateInfo::builder();
            let fence = unsafe { device.create_fence(&info, None) }.vk_check("vkCreateFence")?;
            Ok(Unique::new(device, fence))
        })
        .collect()
}

/// `destroyOldSwapchainWithAcquiredImageTest`
fn destroy_old_swapchain_with_acquired_image_test(context: &Context<'_>) -> TestOutcome {
    let helper = instance_helper(context, &[])?;
    let surface = Surface::headless(&helper.instance)?;
    let device = device_helper(context, &helper.instance, helper.physical_device, surface.surface)?;

    // Create the first swapchain.
    let mut swapchain_info =
        get_basic_swapchain_parameters(&helper.instance, helper.physical_device, surface.surface, (256, 256), 2)?;
    let swapchain = SwapchainGuard::new(&device.device, &swapchain_info)?;
    unsafe { device.device.get_swapchain_images_khr(swapchain.swapchain) }.vk_check("vkGetSwapchainImagesKHR")?;

    let fences = create_fences(&device.device, 2)?;
    unsafe {
        device
            .device
            .acquire_next_image_khr(swapchain.swapchain, u64::MAX, vk::Semaphore::null(), *fences[0])
    }
    .vk_check("vkAcquireNextImageKHR")?;
    unsafe { device.device.wait_for_fences(&[*fences[0]], true, u64::MAX) }.vk_check("vkWaitForFences")?;

    // Create a new swapchain replacing the old one.
    swapchain_info.old_swapchain = swapchain.swapchain;
    let recreated_swapchain = SwapchainGuard::new(&device.device, &swapchain_info)?;

    // Destroying the old swapchain should have no effect.
    drop(swapchain);

    unsafe { device.device.get_swapchain_images_khr(recreated_swapchain.swapchain) }
        .vk_check("vkGetSwapchainImagesKHR")?;

    unsafe {
        device.device.acquire_next_image_khr(
            recreated_swapchain.swapchain,
            u64::MAX,
            vk::Semaphore::null(),
            *fences[1],
        )
    }
    .vk_check("vkAcquireNextImageKHR")?;
    unsafe { device.device.wait_for_fences(&[*fences[1]], true, u64::MAX) }.vk_check("vkWaitForFences")?;

    Ok(TestStatus::pass("Destroying an old swapchain has no effect."))
}

/// `presentImageFromRetiredSwapchain`
fn present_image_from_retired_swapchain_test(context: &Context<'_>) -> TestOutcome {
    let helper = instance_helper(context, &[])?;
    let surface = Surface::headless(&helper.instance)?;
    let device_guard = device_helper(context, &helper.instance, helper.physical_device, surface.surface)?;
    let device = &device_guard.device;
    let queue_family_index =
        compatible_queue_family_indices(&helper.instance, helper.physical_device, surface.surface)?[0];
    let queue = unsafe { device.get_device_queue(queue_family_index, 0) };

    // Create the first swapchain.
    let mut swapchain_info =
        get_basic_swapchain_parameters(&helper.instance, helper.physical_device, surface.surface, (256, 256), 2)?;
    let mut resources = Resources::new(device);
    let swapchain = resources.create_swapchain(&swapchain_info)?;
    let images = unsafe { device.get_swapchain_images_khr(swapchain) }.vk_check("vkGetSwapchainImagesKHR")?;

    let acquire_semaphore = resources.create_semaphore()?;
    let submit_semaphore = resources.create_semaphore()?;

    let (image_index, _) =
        unsafe { device.acquire_next_image_khr(swapchain, u64::MAX, acquire_semaphore, vk::Fence::null()) }
            .vk_check("vkAcquireNextImageKHR")?;

    resources.create_command_pool(queue_family_index)?;
    let command_buffer = resources.allocate_command_buffers(1)?[0];
    unsafe {
        device
            .begin_command_buffer(command_buffer, &vk::CommandBufferBeginInfo::default())
            .vk_check("vkBeginCommandBuffer")?;
        let barrier = image_barrier(
            images[image_index as usize],
            vk::AccessFlags::empty(),
            vk::AccessFlags::empty(),
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::PRESENT_SRC_KHR,
        );
        device.cmd_pipeline_barrier(
            command_buffer,
            vk::PipelineStageFlags::BOTTOM_OF_PIPE,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        );
        device
            .end_command_buffer(command_buffer)
            .vk_check("vkEndCommandBuffer")?;
    }
    let wait_semaphores = [acquire_semaphore];
    let wait_stages = [vk::PipelineStageFlags::TOP_OF_PIPE];
    let command_buffers = [command_buffer];
    let signal_semaphores = [submit_semaphore];
    let submit_info = vk::SubmitInfo::builder()
        .wait_semaphores(&wait_semaphores)
        .wait_dst_stage_mask(&wait_stages)
        .command_buffers(&command_buffers)
        .signal_semaphores(&signal_semaphores)
        .build();
    unsafe { device.queue_submit(queue, &[submit_info], vk::Fence::null()) }.vk_check("vkQueueSubmit")?;

    // Create a new swapchain replacing the old one.
    swapchain_info.old_swapchain = swapchain;
    let recreated_swapchain = resources.create_swapchain(&swapchain_info)?;

    let present_info = vk::PresentInfoKHR {
        wait_semaphore_count: 1,
        wait_semaphores: &submit_semaphore,
        swapchain_count: 1,
        swapchains: &swapchain,
        image_indices: &image_index,
        ..Default::default()
    };
    match unsafe { device.queue_present_khr(queue, &present_info) } {
        Ok(_) | Err(vk::ErrorCode::OUT_OF_DATE_KHR) => {}
        Err(_) => {
            return Ok(TestStatus::fail(
                "vkQueuePresentKHR with image from retired swapchain failed",
            ));
        }
    }

    let acquire_semaphore2 = resources.create_semaphore()?;
    unsafe { device.acquire_next_image_khr(recreated_swapchain, u64::MAX, acquire_semaphore2, vk::Fence::null()) }
        .vk_check("vkAcquireNextImageKHR")?;

    unsafe { device.queue_wait_idle(queue) }.vk_check("vkQueueWaitIdle")?;
    Ok(TestStatus::pass(""))
}

/// `acquireTooManyTest` (`timeout` 0) and `acquireTooManyTimeoutTest` (a 50 ms timeout)
fn acquire_too_many(context: &Context<'_>, timeout: u64) -> TestOutcome {
    use vulkanalia::vk::KhrSurfaceExtensionInstanceCommands;

    let helper = instance_helper(context, &[])?;
    let surface = Surface::headless(&helper.instance)?;
    let device = device_helper(context, &helper.instance, helper.physical_device, surface.surface)?;
    let swapchain_info =
        get_basic_swapchain_parameters(&helper.instance, helper.physical_device, surface.surface, (256, 256), 2)?;
    let swapchain = SwapchainGuard::new(&device.device, &swapchain_info)?;

    let num_images = unsafe { device.device.get_swapchain_images_khr(swapchain.swapchain) }
        .vk_check("vkGetSwapchainImagesKHR")?
        .len() as u32;
    let min_image_count = unsafe {
        helper
            .instance
            .get_physical_device_surface_capabilities_khr(helper.physical_device, surface.surface)
    }
    .vk_check("vkGetPhysicalDeviceSurfaceCapabilitiesKHR")?
    .min_image_count;
    if num_images < min_image_count {
        return Ok(TestStatus::fail(
            "Get swapchain images returned less than minImageCount images",
        ));
    }
    let num_acquirable_images = (num_images - min_image_count + 1) as usize;

    let fences = create_fences(&device.device, num_acquirable_images + 1)?;

    for fence in &fences[..num_acquirable_images] {
        unsafe {
            device
                .device
                .acquire_next_image_khr(swapchain.swapchain, u64::MAX, vk::Semaphore::null(), **fence)
        }
        .vk_check("vkAcquireNextImageKHR")?;
    }

    let result = unsafe {
        device.device.acquire_next_image_khr(
            swapchain.swapchain,
            timeout,
            vk::Semaphore::null(),
            *fences[num_acquirable_images],
        )
    };

    // the code the implementation reports when no image is available within the timeout
    let (not_available, what) = if timeout == 0 {
        (vk::SuccessCode::NOT_READY, "with 0 timeout")
    } else {
        (vk::SuccessCode::TIMEOUT, "with timeout")
    };
    let acquired = match result {
        Ok((_, code)) if code == vk::SuccessCode::SUCCESS || code == vk::SuccessCode::SUBOPTIMAL_KHR => true,
        Ok((_, code)) if code == not_available => false,
        _ => {
            return Ok(TestStatus::fail(format!(
                "Implementation failed to respond well acquiring too many images {what}"
            )));
        }
    };

    // cleanup
    let num_fences = if acquired { fences.len() } else { fences.len() - 1 };
    let fences_raw: Vec<vk::Fence> = fences[..num_fences].iter().map(|fence| **fence).collect();
    unsafe { device.device.wait_for_fences(&fences_raw, true, u64::MAX) }.vk_check("vkWaitForFences")?;

    Ok(TestStatus::pass("Acquire too many swapchain images test succeeded"))
}

fn acquire_too_many_test(context: &Context<'_>) -> TestOutcome {
    acquire_too_many(context, 0)
}

fn acquire_too_many_timeout_test(context: &Context<'_>) -> TestOutcome {
    // arbitrary realistic non-0 non-infinite timeout
    acquire_too_many(context, 50 * 1_000_000)
}

/// `Unique<VkSwapchainKHR>`
struct SwapchainGuard<'a> {
    device: &'a Device,
    swapchain: vk::SwapchainKHR,
}

impl<'a> SwapchainGuard<'a> {
    fn new(device: &'a Device, info: &vk::SwapchainCreateInfoKHR) -> Result<Self, TestError> {
        let swapchain = unsafe { device.create_swapchain_khr(info, None) }.vk_check("vkCreateSwapchainKHR")?;
        Ok(Self { device, swapchain })
    }
}

impl Drop for SwapchainGuard<'_> {
    fn drop(&mut self) {
        unsafe { self.device.destroy_swapchain_khr(self.swapchain, None) };
    }
}

fn swapchain_check_support(context: &Context<'_>) -> Result<(), TestError> {
    common_check_support(context)?;
    context.require_device_functionality("VK_KHR_swapchain")
}

/// `createSwapchainSimulateOOMTest`
fn create_swapchain_simulate_oom_test(context: &Context<'_>, dimension: TestDimension) -> TestOutcome {
    use vulkanalia::vk::KhrSurfaceExtensionInstanceCommands;

    const MAX_CASES: usize = 300;
    const MAX_ALLOCS: u32 = 1024;

    let mut results = ResultCollector::new("");

    let recorder = AllocationCallbackRecorder::new();
    {
        let helper = create_instance_with_allocator(context, recorder.callbacks())?;
        let surface = create_headless_surface_with_allocator(&helper.instance, recorder.callbacks())
            .map_err(|code| TestError::Fail(format!("vkCreateHeadlessSurfaceEXT returned {code:?}")))?;
        let physical_device = unsafe { helper.instance.enumerate_physical_devices() }
            .vk_check("vkEnumeratePhysicalDevices")?
            .into_iter()
            .find(|&physical_device| {
                let properties = unsafe { helper.instance.get_physical_device_properties(physical_device) };
                let reference = context.get_device_properties();
                properties.vendor_id == reference.vendor_id
                    && properties.device_id == reference.device_id
                    && properties.pipeline_cache_uuid == reference.pipeline_cache_uuid
            })
            .ok_or_else(|| TestError::NotSupported("no physical device in the custom instance".to_string()))?;

        let mut additional_extensions = Vec::new();
        // If the driver supports VK_PRESENT_MODE_FIFO_LATEST_READY_KHR and it will be used, VK_KHR_present_mode_fifo_latest_ready must be enabled
        if context.is_device_functionality_supported("VK_KHR_present_mode_fifo_latest_ready") {
            additional_extensions.push("VK_KHR_present_mode_fifo_latest_ready");
        }
        // VUID-VkSwapchainCreateInfoKHR-imageUsage-parameter
        if context.is_device_functionality_supported("VK_EXT_attachment_feedback_loop_layout") {
            additional_extensions.push("VK_EXT_attachment_feedback_loop_layout");
        }

        let queue_family_indices = compatible_queue_family_indices(&helper.instance, physical_device, surface.surface)?;
        let Some(&queue_family_index) = queue_family_indices.first() else {
            return Err(TestError::NotSupported(
                "Device does not support presentation to the given surfaces".to_string(),
            ));
        };
        let device = create_device_with_wsi(
            &helper.instance,
            physical_device,
            &additional_extensions,
            &[queue_family_index],
            Some(recorder.callbacks()),
        )?;

        let capabilities = unsafe {
            helper
                .instance
                .get_physical_device_surface_capabilities_khr(physical_device, surface.surface)
        }
        .vk_check("vkGetPhysicalDeviceSurfaceCapabilitiesKHR")?;
        let formats = unsafe {
            helper
                .instance
                .get_physical_device_surface_formats_khr(physical_device, surface.surface)
        }
        .vk_check("vkGetPhysicalDeviceSurfaceFormatsKHR")?;
        let present_modes = unsafe {
            helper
                .instance
                .get_physical_device_surface_present_modes_khr(physical_device, surface.surface)
        }
        .vk_check("vkGetPhysicalDeviceSurfacePresentModesKHR")?;
        let all_cases = generate_swapchain_parameter_cases(
            &helper.instance,
            physical_device,
            dimension,
            &capabilities,
            &formats,
            &present_modes,
        );

        if MAX_CASES < all_cases.len() {
            log::info!(
                "Note: Will only test first {MAX_CASES} cases out of total of {} parameter combinations",
                all_cases.len()
            );
        }

        for (case_ndx, case) in all_cases.iter().take(MAX_CASES).enumerate() {
            log::info!("Testing parameter case {case_ndx}: {case:?}");

            for num_passing_allocs in 0..=MAX_ALLOCS {
                let mut got_oom = false;
                let mut cur_params = *case;
                cur_params.surface = surface.surface;
                cur_params.queue_family_index_count = 1;
                cur_params.queue_family_indices = &queue_family_index;

                // With concurrent sharing mode, at least two queues are needed: the case is skipped, as upstream does
                if cur_params.image_sharing_mode == vk::SharingMode::CONCURRENT {
                    break;
                }

                recorder.set_budget(Some(num_passing_allocs));

                log::info!("Testing with {num_passing_allocs} first allocations succeeding");

                match unsafe {
                    device
                        .device
                        .create_swapchain_khr(&cur_params, Some(recorder.callbacks()))
                } {
                    Ok(swapchain) => unsafe {
                        device
                            .device
                            .destroy_swapchain_khr(swapchain, Some(recorder.callbacks()));
                    },
                    Err(code)
                        if code == vk::ErrorCode::OUT_OF_HOST_MEMORY || code == vk::ErrorCode::OUT_OF_DEVICE_MEMORY =>
                    {
                        log::info!("Got {code:?}");
                        got_oom = true;
                    }
                    Err(code) => {
                        recorder.set_budget(None);
                        return Err(TestError::Fail(format!("vkCreateSwapchainKHR returned {code:?}")));
                    }
                }

                if !got_oom {
                    log::info!("Creating swapchain succeeded!");

                    if num_passing_allocs == 0 {
                        results.add_result(
                            TestResult::QualityWarning,
                            "Allocation callbacks were not used".to_string(),
                        );
                    }

                    break;
                } else if num_passing_allocs == MAX_ALLOCS {
                    // The maxExtents case might not be able to create the requested surface due to insufficient memory, so in this case *only*
                    // the OOM is allowed up to maxAllocs.
                    if dimension == TestDimension::ImageExtent
                        && capabilities.max_image_extent.width == cur_params.image_extent.width
                        && capabilities.max_image_extent.height == cur_params.image_extent.height
                    {
                        break;
                    }

                    results.add_result(
                        TestResult::QualityWarning,
                        "Creating swapchain did not succeed, callback limit exceeded".to_string(),
                    );
                }
            }
        }

        recorder.set_budget(None);
    }

    if !recorder.validate(0) {
        results.fail("Detected invalid system allocation callback");
    }

    Ok(results.to_status())
}

/// `checkSwapchainPrivateDataSupport`
fn check_swapchain_private_data_support(context: &Context<'_>) -> Result<(), TestError> {
    use vulkanalia::vk::InstanceV1_1;

    swapchain_check_support(context)?;

    context.require_device_functionality("VK_EXT_private_data")?;
    let mut private_data_features = vk::PhysicalDevicePrivateDataFeatures::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut private_data_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    if private_data_features.private_data == vk::FALSE {
        return Err(TestError::NotSupported("privateData not supported".to_string()));
    }
    Ok(())
}

/// `createSwapchainPrivateDataTest`
fn create_swapchain_private_data_test(context: &Context<'_>, dimension: TestDimension) -> TestOutcome {
    use vulkanalia::vk::{
        ExtPrivateDataExtensionDeviceCommands, Handle as VkHandle, KhrSurfaceExtensionInstanceCommands,
    };

    const NUM_SLOTS: usize = 100;

    let helper = instance_helper(context, &[])?;
    let surface = Surface::headless(&helper.instance)?;
    let physical_device = helper.physical_device;

    // VUID-VkSwapchainCreateInfoKHR-imageUsage-parameter
    let mut extra_extensions = vec!["VK_EXT_private_data"];
    if context.is_device_functionality_supported("VK_EXT_attachment_feedback_loop_layout") {
        extra_extensions.push("VK_EXT_attachment_feedback_loop_layout");
    }
    let queue_family_indices = compatible_queue_family_indices(&helper.instance, physical_device, surface.surface)?;
    let device = create_device_with_wsi(
        &helper.instance,
        physical_device,
        &extra_extensions,
        &queue_family_indices,
        None,
    )?;
    let device = &device.device;

    let capabilities = unsafe {
        helper
            .instance
            .get_physical_device_surface_capabilities_khr(physical_device, surface.surface)
    }
    .vk_check("vkGetPhysicalDeviceSurfaceCapabilitiesKHR")?;
    let formats = unsafe {
        helper
            .instance
            .get_physical_device_surface_formats_khr(physical_device, surface.surface)
    }
    .vk_check("vkGetPhysicalDeviceSurfaceFormatsKHR")?;
    let present_modes = unsafe {
        helper
            .instance
            .get_physical_device_surface_present_modes_khr(physical_device, surface.surface)
    }
    .vk_check("vkGetPhysicalDeviceSurfacePresentModesKHR")?;
    let cases = generate_swapchain_parameter_cases(
        &helper.instance,
        physical_device,
        dimension,
        &capabilities,
        &formats,
        &present_modes,
    );

    let create_slots = || -> Result<Vec<Unique<'_, vk::PrivateDataSlot>>, TestError> {
        (0..NUM_SLOTS)
            .map(|_| {
                let info = vk::PrivateDataSlotCreateInfo::builder();
                let slot = unsafe { device.create_private_data_slot_ext(&info, None) }
                    .vk_check("vkCreatePrivateDataSlotEXT")?;
                Ok(Unique::new(device, slot))
            })
            .collect()
    };

    for (case_ndx, case) in cases.iter().enumerate() {
        let subcase = format!("Sub-case {} / {}: ", case_ndx + 1, cases.len());

        let mut cur_params = *case;

        if cur_params.image_sharing_mode == vk::SharingMode::CONCURRENT {
            let num_families = queue_family_indices.len() as u32;
            if num_families < 2 {
                return Err(TestError::NotSupported(format!(
                    "Only {num_families} queue families available for VK_SHARING_MODE_CONCURRENT"
                )));
            }
            cur_params.queue_family_index_count = num_families;
        } else {
            // Take only the first queue.
            if queue_family_indices.is_empty() {
                return Err(TestError::NotSupported(
                    "No queue families compatible with the given surface".to_string(),
                ));
            }
            cur_params.queue_family_index_count = 1;
        }
        cur_params.queue_family_indices = queue_family_indices.as_ptr();
        cur_params.surface = surface.surface;

        log::info!("{subcase}{cur_params:?}");

        let properties_result = unsafe {
            helper.instance.get_physical_device_image_format_properties(
                physical_device,
                cur_params.image_format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                cur_params.image_usage,
                vk::ImageCreateFlags::empty(),
            )
        };

        log::info!("{subcase}vkGetPhysicalDeviceImageFormatProperties => {properties_result:?}");

        match properties_result {
            Ok(_) => {
                let swapchain = SwapchainGuard::new(device, &cur_params)?;
                let handle = swapchain.swapchain.as_raw();
                let object_type = vk::ObjectType::SWAPCHAIN_KHR;

                let mut slots = create_slots()?;

                // Based on code in vktApiObjectManagementTests.cpp
                for _ in 0..3 {
                    for slot in &slots {
                        let data = unsafe { device.get_private_data_ext(object_type, handle, slot.get()) };
                        if data != 0 {
                            return Ok(TestStatus::fail("Expected initial value of zero"));
                        }
                    }

                    for (i, slot) in slots.iter().enumerate() {
                        let value = (i * i * i + 1) as u64;
                        unsafe { device.set_private_data_ext(object_type, handle, slot.get(), value) }
                            .vk_check("vkSetPrivateDataEXT")?;
                    }

                    for (i, slot) in slots.iter().enumerate() {
                        let data = unsafe { device.get_private_data_ext(object_type, handle, slot.get()) };
                        if data != (i * i * i + 1) as u64 {
                            return Ok(TestStatus::fail("Didn't read back set value"));
                        }
                    }

                    // Destroy and realloc slots for the next iteration
                    slots.clear();
                    slots = create_slots()?;
                }
            }
            Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => {
                log::info!(
                    "{subcase}Skip because vkGetPhysicalDeviceImageFormatProperties returned VK_ERROR_FORMAT_NOT_SUPPORTED"
                );
            }
            Err(code) => {
                log::info!("{subcase}Fail because vkGetPhysicalDeviceImageFormatProperties returned {code:?}");
                return Ok(TestStatus::fail(
                    "Unexpected result from vkGetPhysicalDeviceImageFormatProperties",
                ));
            }
        }
    }

    Ok(TestStatus::pass("No sub-case failed"))
}

struct SwapchainPrivateDataCase {
    name: &'static str,
    dimension: TestDimension,
}

impl TestCase for SwapchainPrivateDataCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_swapchain_private_data_support(context)
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SwapchainPrivateDataInstance {
            context,
            dimension: self.dimension,
        })
    }
}

struct SwapchainPrivateDataInstance<'a> {
    context: &'a Context<'a>,
    dimension: TestDimension,
}

impl TestInstance for SwapchainPrivateDataInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        create_swapchain_private_data_test(self.context, self.dimension)
    }
}

struct SwapchainSimulateOomCase {
    name: &'static str,
    dimension: TestDimension,
}

impl TestCase for SwapchainSimulateOomCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        swapchain_check_support(context)
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SwapchainSimulateOomInstance {
            context,
            dimension: self.dimension,
        })
    }
}

struct SwapchainSimulateOomInstance<'a> {
    context: &'a Context<'a>,
    dimension: TestDimension,
}

impl TestInstance for SwapchainSimulateOomInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        create_swapchain_simulate_oom_test(self.context, self.dimension)
    }
}

struct SwapchainFunctionCase {
    name: &'static str,
    test: fn(&Context<'_>) -> TestOutcome,
}

impl TestCase for SwapchainFunctionCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        swapchain_check_support(context)
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SwapchainFunctionInstance {
            context,
            test: self.test,
        })
    }
}

struct SwapchainFunctionInstance<'a> {
    context: &'a Context<'a>,
    test: fn(&Context<'_>) -> TestOutcome,
}

impl TestInstance for SwapchainFunctionInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        (self.test)(self.context)
    }
}

/// `createSwapchainTests` for the headless platform, the `create` group and the simple `get_images` / `destroy` cases: the cases keyed by their dotted path (`headless.swapchain.create.<dimension>`)
pub fn create_headless_swapchain_cases() -> HashMap<String, Box<dyn TestCase>> {
    let mut cases: HashMap<String, Box<dyn TestCase>> = TestDimension::ALL
        .into_iter()
        .map(|dimension| {
            (
                format!("headless.swapchain.create.{}", dimension.name()),
                Box::new(SwapchainCreateCase {
                    name: dimension.name(),
                    dimension,
                }) as Box<dyn TestCase>,
            )
        })
        .collect();

    cases.extend(
        TestDimension::ALL
            .into_iter()
            .filter(|&dimension| dimension != TestDimension::ImageExtent)
            .map(|dimension| {
                (
                    format!("headless.swapchain.private_data.{}", dimension.name()),
                    Box::new(SwapchainPrivateDataCase {
                        name: dimension.name(),
                        dimension,
                    }) as Box<dyn TestCase>,
                )
            }),
    );

    cases.extend(TestDimension::ALL.into_iter().map(|dimension| {
        (
            format!("headless.swapchain.simulate_oom.{}", dimension.name()),
            Box::new(SwapchainSimulateOomCase {
                name: dimension.name(),
                dimension,
            }) as Box<dyn TestCase>,
        )
    }));

    let functions: [(&'static str, &'static str, fn(&Context<'_>) -> TestOutcome); 8] = [
        ("get_images", "incomplete", get_images_incomplete_result_test),
        ("get_images", "count", get_images_results_count_test),
        ("destroy", "null_handle", destroy_null_handle_swapchain_test),
        ("destroy", "old_swapchain", destroy_old_swapchain_test),
        (
            "destroy",
            "old_swapchain_acquired_image",
            destroy_old_swapchain_with_acquired_image_test,
        ),
        (
            "destroy",
            "retired_swapchain_present",
            present_image_from_retired_swapchain_test,
        ),
        ("acquire", "too_many", acquire_too_many_test),
        ("acquire", "too_many_timeout", acquire_too_many_timeout_test),
    ];
    for (group, name, test) in functions {
        cases.insert(
            format!("headless.swapchain.{group}.{name}"),
            Box::new(SwapchainFunctionCase { name, test }),
        );
    }
    cases
}

/// `checkWsiSupport` of vktApiFrameBoundaryTests.cpp for the headless platform
fn frame_boundary_check_support(context: &Context<'_>) -> Result<(), TestError> {
    common_check_support(context)?;
    context.require_device_functionality("VK_KHR_swapchain")?;
    context.require_device_functionality("VK_EXT_frame_boundary")
}

/// `testCaseWsi` of vktApiFrameBoundaryTests.cpp for the headless platform: clears a swapchain image and presents it with a `VkFrameBoundaryEXT` chained to `VkPresentInfoKHR`
fn frame_boundary_headless_test(context: &Context<'_>) -> TestOutcome {
    use vulkanalia::vk::KhrSurfaceExtensionInstanceCommands;

    let helper = instance_helper(context, &[])?;
    let surface = Surface::headless(&helper.instance)?;
    let queue_family_indices =
        compatible_queue_family_indices(&helper.instance, helper.physical_device, surface.surface)?;
    let Some(&queue_family_index) = queue_family_indices.first() else {
        return Err(TestError::NotSupported(
            "Device does not support presentation to the given surfaces".to_string(),
        ));
    };
    let device_guard = create_device_with_wsi(
        &helper.instance,
        helper.physical_device,
        &["VK_EXT_frame_boundary"],
        &[queue_family_index],
        None,
    )?;
    let device = &device_guard.device;
    let queue = unsafe { device.get_device_queue(queue_family_index, 0) };

    let capabilities = unsafe {
        helper
            .instance
            .get_physical_device_surface_capabilities_khr(helper.physical_device, surface.surface)
    }
    .vk_check("vkGetPhysicalDeviceSurfaceCapabilitiesKHR")?;
    if !capabilities
        .supported_usage_flags
        .contains(vk::ImageUsageFlags::TRANSFER_DST)
    {
        return Err(TestError::NotSupported(
            "supportedUsageFlags does not contain VK_IMAGE_USAGE_TRANSFER_DST_BIT".to_string(),
        ));
    }
    let formats = unsafe {
        helper
            .instance
            .get_physical_device_surface_formats_khr(helper.physical_device, surface.surface)
    }
    .vk_check("vkGetPhysicalDeviceSurfaceFormatsKHR")?;
    let surface_format = formats
        .first()
        .ok_or_else(|| TestError::Fail("the surface reports no formats".to_string()))?;

    let swapchain_info = vk::SwapchainCreateInfoKHR {
        surface: surface.surface,
        min_image_count: capabilities.min_image_count.max(1),
        image_format: surface_format.format,
        image_color_space: surface_format.color_space,
        image_extent: vk::Extent2D {
            width: 16u32.clamp(capabilities.min_image_extent.width, capabilities.max_image_extent.width),
            height: 16u32.clamp(
                capabilities.min_image_extent.height,
                capabilities.max_image_extent.height,
            ),
        },
        image_array_layers: 1,
        image_usage: vk::ImageUsageFlags::TRANSFER_DST,
        image_sharing_mode: vk::SharingMode::EXCLUSIVE,
        pre_transform: capabilities.current_transform,
        composite_alpha: vk::CompositeAlphaFlagsKHR::OPAQUE,
        present_mode: vk::PresentModeKHR::FIFO,
        clipped: vk::FALSE,
        old_swapchain: vk::SwapchainKHR::null(),
        ..Default::default()
    };
    let mut resources = Resources::new(device);
    let swapchain = resources.create_swapchain(&swapchain_info)?;
    let swapchain_images = unsafe { device.get_swapchain_images_khr(swapchain) }.vk_check("vkGetSwapchainImagesKHR")?;

    resources.create_command_pool(queue_family_index)?;
    let command_buffer = resources.allocate_command_buffers(1)?[0];
    let acquire_semaphore = resources.create_semaphore()?;
    let fence = resources.create_fence()?;

    let (current_buffer, _) =
        unsafe { device.acquire_next_image_khr(swapchain, u64::MAX, acquire_semaphore, vk::Fence::null()) }
            .vk_check("vkAcquireNextImageKHR")?;
    let image = swapchain_images[current_buffer as usize];

    unsafe {
        device
            .begin_command_buffer(command_buffer, &vk::CommandBufferBeginInfo::default())
            .vk_check("vkBeginCommandBuffer")?;
        let barrier = image_barrier(
            image,
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        );
        device.cmd_pipeline_barrier(
            command_buffer,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        );
        let clear_color = vk::ClearColorValue {
            float32: [1.0, 1.0, 1.0, 1.0],
        };
        let range = vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: 0,
            layer_count: 1,
        };
        device.cmd_clear_color_image(
            command_buffer,
            image,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            &clear_color,
            &[range],
        );
        device
            .end_command_buffer(command_buffer)
            .vk_check("vkEndCommandBuffer")?;
    }

    let wait_semaphores = [acquire_semaphore];
    let wait_stages = [vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT];
    let command_buffers = [command_buffer];
    let submit_info = vk::SubmitInfo::builder()
        .wait_semaphores(&wait_semaphores)
        .wait_dst_stage_mask(&wait_stages)
        .command_buffers(&command_buffers)
        .build();
    unsafe { device.queue_submit(queue, &[submit_info], fence) }.vk_check("vkQueueSubmit")?;
    unsafe { device.wait_for_fences(&[fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;

    let frame_images = [image];
    let mut frame_boundary = vk::FrameBoundaryEXT::builder()
        .flags(vk::FrameBoundaryFlagsEXT::FRAME_END)
        .frame_id(1)
        .images(&frame_images);
    let swapchains = [swapchain];
    let image_indices = [current_buffer];
    let present_info = vk::PresentInfoKHR::builder()
        .swapchains(&swapchains)
        .image_indices(&image_indices)
        .push_next(&mut frame_boundary);
    unsafe { device.queue_present_khr(queue, &present_info) }.vk_check("vkQueuePresentKHR")?;

    unsafe { device.queue_wait_idle(queue) }.vk_check("vkQueueWaitIdle")?;
    Ok(TestStatus::pass("Pass"))
}

struct FrameBoundaryHeadlessCase;

impl TestCase for FrameBoundaryHeadlessCase {
    fn name(&self) -> &str {
        "headless"
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        frame_boundary_check_support(context)
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SwapchainFunctionInstance {
            context,
            test: frame_boundary_headless_test,
        })
    }
}

/// `api.frame_boundary.wsi.headless`
pub fn create_frame_boundary_headless_case() -> Box<dyn TestCase> {
    Box::new(FrameBoundaryHeadlessCase)
}
