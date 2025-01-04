// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiImageCompressionControlTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `swapchainCreateTest` for the headless platform only, on top of the swapchain device of this group;
// the cases are returned keyed by `swapchain.headless.<flags>` for `api::image_compression_control_tests`.

use std::collections::HashMap;
use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    InstanceV1_1, KhrGetSurfaceCapabilities2ExtensionInstanceCommands, KhrSwapchainExtensionDeviceCommands,
};

use super::surface_tests::{Surface, common_check_support, instance_helper};
use super::swapchain_tests::{compatible_queue_family_indices, create_device_with_wsi};
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::api::image_compression_control_tests::{TestParams, fixed_rate_flags, make_control, validate};
use crate::vkt::{Context, TestCase, TestInstance};

/// `checkImageCompressionControlSupport` with `swapchain = true`
fn check_swapchain_create_test(context: &Context<'_>) -> Result<(), TestError> {
    common_check_support(context)?;
    context.require_device_functionality("VK_EXT_image_compression_control")?;
    context.require_device_functionality("VK_EXT_image_compression_control_swapchain")?;

    let mut swapchain = vk::PhysicalDeviceImageCompressionControlSwapchainFeaturesEXT::default();
    let mut compression_control = vk::PhysicalDeviceImageCompressionControlFeaturesEXT {
        next: (&raw mut swapchain).cast::<c_void>(),
        ..Default::default()
    };
    let mut features2 = vk::PhysicalDeviceFeatures2 {
        next: (&raw mut compression_control).cast::<c_void>(),
        ..Default::default()
    };
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };

    if compression_control.image_compression_control == vk::FALSE {
        return Err(TestError::NotSupported(
            "VK_EXT_image_compression_control Image compression control feature not supported.".to_string(),
        ));
    }
    if swapchain.image_compression_control_swapchain == vk::FALSE {
        return Err(TestError::NotSupported(
            "VK_EXT_image_compression_control_swapchain Image compression control feature for swapchains not supported."
                .to_string(),
        ));
    }
    Ok(())
}

/// `swapchainCreateTest`
fn swapchain_create_test(context: &Context<'_>, flags: vk::ImageCompressionFlagsEXT) -> TestOutcome {
    let mut results = ResultCollector::new("");
    let helper = instance_helper(context, &["VK_KHR_get_surface_capabilities2"])?;
    let is_fixed_rate_ex = flags == vk::ImageCompressionFlagsEXT::FIXED_RATE_EXPLICIT;
    let mut plane_bits = [0u32; 3];

    for i in 0..(if is_fixed_rate_ex { 24u32 } else { 1 }) {
        plane_bits[0] ^= 3 << i;
        let mut plane_flags = plane_bits.map(fixed_rate_flags);

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
            &[
                "VK_EXT_image_compression_control",
                "VK_EXT_image_compression_control_swapchain",
            ],
            &[queue_family_index],
            None,
        )?;
        let device = &device_guard.device;

        let surface_info = vk::PhysicalDeviceSurfaceInfo2KHR {
            surface: surface.surface,
            ..Default::default()
        };
        let mut caps = vk::SurfaceCapabilities2KHR::default();
        unsafe {
            helper.instance.get_physical_device_surface_capabilities2_khr(
                helper.physical_device,
                &surface_info,
                &mut caps,
            )
        }
        .vk_check("vkGetPhysicalDeviceSurfaceCapabilities2KHR")?;

        let mut num_formats = 0u32;
        let get_formats = helper.instance.commands().get_physical_device_surface_formats2_khr;
        unsafe {
            get_formats(
                helper.physical_device,
                &surface_info,
                &mut num_formats,
                std::ptr::null_mut(),
            );
        }
        let mut compression_props = vec![vk::ImageCompressionPropertiesEXT::default(); num_formats as usize];
        let mut formats: Vec<vk::SurfaceFormat2KHR> = compression_props
            .iter_mut()
            .map(|props| vk::SurfaceFormat2KHR {
                next: std::ptr::from_mut(props).cast::<c_void>(),
                ..Default::default()
            })
            .collect();
        let result = unsafe {
            get_formats(
                helper.physical_device,
                &surface_info,
                &mut num_formats,
                formats.as_mut_ptr(),
            )
        };
        if result != vk::Result::SUCCESS {
            return Err(TestError::Fail(format!(
                "vkGetPhysicalDeviceSurfaceFormats2KHR returned {result:?}"
            )));
        }

        for (format, props) in formats.iter().zip(&compression_props) {
            let supported_mode = props.image_compression_flags;
            let supported_rate = props.image_compression_fixed_rate_flags;

            // Headless surface formats are never multi-planar
            let params = TestParams {
                format: format.surface_format.format,
                use_extension: true,
                flags,
                ycbcr: false,
                plane_count: 1,
            };
            let control = make_control(&params, &mut plane_flags);

            if (flags.bits() & supported_mode.bits()) == 0
                || (is_fixed_rate_ex && (plane_flags[0].bits() & supported_rate.bits()) == 0)
            {
                // FIXED_RATE_DEFAULT is reported as FIXED_RATE_EXPLICIT: only skip when the rate is zero as well
                if !(flags == vk::ImageCompressionFlagsEXT::FIXED_RATE_DEFAULT && supported_rate.bits() != 0) {
                    return Err(TestError::NotSupported(
                        "Swapchain compression control and format not compatible".to_string(),
                    ));
                }
            }

            if is_fixed_rate_ex {
                plane_flags[0] = fixed_rate_flags(plane_flags[0].bits() & supported_rate.bits());
            }

            let swapchain_info = vk::SwapchainCreateInfoKHR {
                next: (&raw const control).cast::<c_void>(),
                surface: surface.surface,
                min_image_count: caps.surface_capabilities.min_image_count,
                image_format: format.surface_format.format,
                image_color_space: format.surface_format.color_space,
                image_extent: vk::Extent2D { width: 16, height: 16 },
                image_array_layers: 1,
                image_usage: vk::ImageUsageFlags::COLOR_ATTACHMENT,
                image_sharing_mode: vk::SharingMode::EXCLUSIVE,
                queue_family_index_count: 1,
                queue_family_indices: &queue_family_index,
                pre_transform: caps.surface_capabilities.current_transform,
                composite_alpha: vk::CompositeAlphaFlagsKHR::INHERIT,
                present_mode: vk::PresentModeKHR::FIFO,
                clipped: vk::TRUE,
                ..Default::default()
            };

            let swapchain =
                unsafe { device.create_swapchain_khr(&swapchain_info, None) }.vk_check("vkCreateSwapchainKHR")?;
            let images = unsafe { device.get_swapchain_images_khr(swapchain) }.vk_check("vkGetSwapchainImagesKHR");
            if let Ok(images) = &images {
                validate(
                    &helper.instance,
                    device,
                    helper.physical_device,
                    &mut results,
                    &params,
                    &control,
                    images[0],
                );
            }
            unsafe { device.destroy_swapchain_khr(swapchain, None) };
            images?;
        }
    }

    Ok(results.to_status())
}

struct CompressionSwapchainCase {
    name: &'static str,
    flags: vk::ImageCompressionFlagsEXT,
}

impl TestCase for CompressionSwapchainCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_swapchain_create_test(context)
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CompressionSwapchainInstance {
            context,
            flags: self.flags,
        })
    }
}

struct CompressionSwapchainInstance<'a> {
    context: &'a Context<'a>,
    flags: vk::ImageCompressionFlagsEXT,
}

impl TestInstance for CompressionSwapchainInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        swapchain_create_test(self.context, self.flags)
    }
}

/// `swapchain.headless.<flags>` of `image_compression_control`
pub fn create_headless_compression_swapchain_cases() -> HashMap<String, Box<dyn TestCase>> {
    [
        ("default", vk::ImageCompressionFlagsEXT::DEFAULT),
        ("fixed_rate_default", vk::ImageCompressionFlagsEXT::FIXED_RATE_DEFAULT),
        ("disabled", vk::ImageCompressionFlagsEXT::DISABLED),
        ("explicit", vk::ImageCompressionFlagsEXT::FIXED_RATE_EXPLICIT),
    ]
    .into_iter()
    .map(|(name, flags)| {
        (
            format!("swapchain.headless.{name}"),
            Box::new(CompressionSwapchainCase { name, flags }) as Box<dyn TestCase>,
        )
    })
    .collect()
}
