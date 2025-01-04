// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiArrayTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `oversizedArrayWsiTest` for the headless platform and the functions that do not need a display
// (`WsiArrayFunction::GetPhysicalDeviceSurfaceFormats`, `...PresentModes`, `GetSwapchainImages`, `GetPhysicalDevicePresentRectangles`,
// `GetPhysicalDeviceSurfaceFormats2`); `GetPhysicalDeviceSurfacePresentModes2` needs VK_EXT_full_screen_exclusive and stays gated. Runs on this group's swapchain device.

use std::collections::HashMap;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    KhrGetSurfaceCapabilities2ExtensionInstanceCommands, KhrSurfaceExtensionInstanceCommands,
    KhrSwapchainExtensionDeviceCommands,
};

use super::surface_tests::{Surface, common_check_support, instance_helper};
use super::swapchain_tests::{compatible_queue_family_indices, create_device_with_wsi};
use crate::tcu::{TestError, TestOutcome};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::api::array_tests::{oversized_array_test_wsi, with_u32_count};
use crate::vkt::tests::api::case_util::is_instance_extension_available;
use crate::vkt::{Context, TestCase, TestInstance};

#[derive(Clone, Copy)]
enum WsiArrayFunction {
    SurfaceFormats,
    SurfacePresentModes,
    SwapchainImages,
    PresentRectangles,
    SurfaceFormats2,
}

fn check_support_wsi(context: &Context<'_>, function: WsiArrayFunction) -> Result<(), TestError> {
    common_check_support(context)?;
    context.require_device_functionality("VK_KHR_swapchain")?;
    match function {
        WsiArrayFunction::PresentRectangles => context.require_device_functionality("VK_KHR_device_group"),
        WsiArrayFunction::SurfaceFormats2 => {
            if is_instance_extension_available(context, "VK_KHR_get_surface_capabilities2") {
                Ok(())
            } else {
                Err(TestError::NotSupported(
                    "VK_KHR_get_surface_capabilities2 is not supported".to_string(),
                ))
            }
        }
        _ => Ok(()),
    }
}

/// `oversizedArrayWsiTest`
fn oversized_array_wsi_test(context: &Context<'_>, function: WsiArrayFunction) -> TestOutcome {
    let helper = instance_helper(context, &["VK_KHR_get_surface_capabilities2"])?;
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
        &[],
        &[queue_family_index],
        None,
    )?;
    let device = &device_guard.device;
    let instance = &helper.instance;
    let physical_device = helper.physical_device;

    let capabilities =
        unsafe { instance.get_physical_device_surface_capabilities_khr(physical_device, surface.surface) }
            .vk_check("vkGetPhysicalDeviceSurfaceCapabilitiesKHR")?;
    if !capabilities
        .supported_usage_flags
        .contains(vk::ImageUsageFlags::TRANSFER_DST)
    {
        return Err(TestError::NotSupported(
            "supportedUsageFlags does not contain VK_IMAGE_USAGE_TRANSFER_DST_BIT".to_string(),
        ));
    }
    let formats = unsafe { instance.get_physical_device_surface_formats_khr(physical_device, surface.surface) }
        .vk_check("vkGetPhysicalDeviceSurfaceFormatsKHR")?;
    let surface_format = formats
        .first()
        .ok_or_else(|| TestError::Fail("the surface reports no formats".to_string()))?;
    let composite_alpha = [
        vk::CompositeAlphaFlagsKHR::OPAQUE,
        vk::CompositeAlphaFlagsKHR::INHERIT,
        vk::CompositeAlphaFlagsKHR::PRE_MULTIPLIED,
        vk::CompositeAlphaFlagsKHR::POST_MULTIPLIED,
    ]
    .into_iter()
    .find(|&bit| capabilities.supported_composite_alpha.contains(bit))
    .unwrap_or_default();
    let swapchain_info = vk::SwapchainCreateInfoKHR {
        surface: surface.surface,
        min_image_count: capabilities.min_image_count.max(1),
        image_format: surface_format.format,
        image_color_space: surface_format.color_space,
        image_extent: vk::Extent2D {
            width: 16u32.clamp(
                capabilities.min_image_extent.width,
                capabilities
                    .max_image_extent
                    .width
                    .max(capabilities.min_image_extent.width),
            ),
            height: 16u32.clamp(
                capabilities.min_image_extent.height,
                capabilities
                    .max_image_extent
                    .height
                    .max(capabilities.min_image_extent.height),
            ),
        },
        image_array_layers: 1,
        image_usage: vk::ImageUsageFlags::TRANSFER_DST,
        image_sharing_mode: vk::SharingMode::EXCLUSIVE,
        pre_transform: capabilities.current_transform,
        composite_alpha,
        present_mode: vk::PresentModeKHR::FIFO,
        clipped: vk::FALSE,
        ..Default::default()
    };
    let swapchain = unsafe { device.create_swapchain_khr(&swapchain_info, None) }.vk_check("vkCreateSwapchainKHR")?;

    let commands = instance.commands();
    let outcome = match function {
        WsiArrayFunction::SurfaceFormats => oversized_array_test_wsi::<vk::SurfaceFormatKHR>(&|count, array| unsafe {
            with_u32_count(count, |n| {
                (commands.get_physical_device_surface_formats_khr)(physical_device, surface.surface, n, array)
            })
        }),
        WsiArrayFunction::SurfacePresentModes => {
            oversized_array_test_wsi::<vk::PresentModeKHR>(&|count, array| unsafe {
                with_u32_count(count, |n| {
                    (commands.get_physical_device_surface_present_modes_khr)(physical_device, surface.surface, n, array)
                })
            })
        }
        WsiArrayFunction::PresentRectangles => oversized_array_test_wsi::<vk::Rect2D>(&|count, array| unsafe {
            with_u32_count(count, |n| {
                (commands.get_physical_device_present_rectangles_khr)(physical_device, surface.surface, n, array)
            })
        }),
        WsiArrayFunction::SwapchainImages => oversized_array_test_wsi::<vk::Image>(&|count, array| unsafe {
            with_u32_count(count, |n| {
                (device.commands().get_swapchain_images_khr)(device.handle(), swapchain, n, array)
            })
        }),
        WsiArrayFunction::SurfaceFormats2 => {
            let surface_info = vk::PhysicalDeviceSurfaceInfo2KHR {
                surface: surface.surface,
                ..Default::default()
            };
            oversized_array_test_wsi::<vk::SurfaceFormat2KHR>(&|count, array| unsafe {
                with_u32_count(count, |n| {
                    (commands.get_physical_device_surface_formats2_khr)(physical_device, &surface_info, n, array)
                })
            })
        }
    };

    unsafe { device.destroy_swapchain_khr(swapchain, None) };
    outcome
}

struct ArrayWsiCase {
    name: &'static str,
    function: WsiArrayFunction,
}

impl TestCase for ArrayWsiCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_support_wsi(context, self.function)
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ArrayWsiInstance {
            context,
            function: self.function,
        })
    }
}

struct ArrayWsiInstance<'a> {
    context: &'a Context<'a>,
    function: WsiArrayFunction,
}

impl TestInstance for ArrayWsiInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        oversized_array_wsi_test(self.context, self.function)
    }
}

/// `wsi.headless.<function>` of `api.array.oversized_array`
pub fn create_headless_array_cases() -> HashMap<String, Box<dyn TestCase>> {
    [
        (
            "get_physical_device_present_rectangles",
            WsiArrayFunction::PresentRectangles,
        ),
        ("get_physical_device_surface_formats", WsiArrayFunction::SurfaceFormats),
        (
            "get_physical_device_surface_formats2",
            WsiArrayFunction::SurfaceFormats2,
        ),
        (
            "get_physical_device_surface_present_modes",
            WsiArrayFunction::SurfacePresentModes,
        ),
        ("get_swapchain_images", WsiArrayFunction::SwapchainImages),
    ]
    .into_iter()
    .map(|(name, function)| {
        (
            format!("wsi.headless.{name}"),
            Box::new(ArrayWsiCase { name, function }) as Box<dyn TestCase>,
        )
    })
    .collect()
}
