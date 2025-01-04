// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiImageCompressionControlTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `create_image` and `swapchain.headless` (in wsi/compression_swapchain_tests.rs) are ported. `android_hardware_buffer` needs the AHB platform layer and
// the other `swapchain` platforms need their window systems.

use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtImageCompressionControlExtensionDeviceCommands, InstanceV1_1};

use super::feature_info_tests::uncompressed_formats_with_planes;
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

/// `VK_IMAGE_COMPRESSION_FIXED_RATE_FLAG_BITS_MAX_ENUM_EXT`
const FIXED_RATE_MAX_ENUM: u32 = 0x7FFF_FFFF;

#[derive(Clone, Copy)]
pub(crate) struct TestParams {
    pub(crate) format: vk::Format,
    pub(crate) use_extension: bool,
    pub(crate) flags: vk::ImageCompressionFlagsEXT,
    pub(crate) ycbcr: bool,
    pub(crate) plane_count: u32,
}

/// The flag types define no bits above 1 << 23, and upstream deliberately sets such bits.
pub(crate) fn fixed_rate_flags(bits: u32) -> vk::ImageCompressionFixedRateFlagsEXT {
    unsafe { std::mem::transmute::<u32, vk::ImageCompressionFixedRateFlagsEXT>(bits) }
}

/// `checkImageCompressionControlSupport`
fn check_image_compression_control_support(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_image_compression_control")?;

    let mut compression_control = vk::PhysicalDeviceImageCompressionControlFeaturesEXT::default();
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
    Ok(())
}

/// `checkImageCreateTesSupport`
fn check_image_create_test_support(context: &Context<'_>, params: &TestParams) -> Result<(), TestError> {
    check_image_compression_control_support(context)?;

    let supported = unsafe {
        context.get_instance().get_physical_device_image_format_properties(
            context.get_physical_device(),
            params.format,
            vk::ImageType::_2D,
            vk::ImageTiling::OPTIMAL,
            vk::ImageUsageFlags::COLOR_ATTACHMENT,
            vk::ImageCreateFlags::empty(),
        )
    };
    if supported.is_err() {
        return Err(TestError::NotSupported("Image format not supported.".to_string()));
    }
    Ok(())
}

/// `control` as `testParams.control` carries it: the plane count follows the flags, the
/// per-plane rates are only present for the explicit mode.
pub(crate) fn make_control(
    params: &TestParams,
    plane_flags: &mut [vk::ImageCompressionFixedRateFlagsEXT; 3],
) -> vk::ImageCompressionControlEXT {
    let is_fixed_rate_ex = params.flags == vk::ImageCompressionFlagsEXT::FIXED_RATE_EXPLICIT;
    vk::ImageCompressionControlEXT {
        flags: params.flags,
        compression_control_plane_count: if is_fixed_rate_ex { params.plane_count } else { 0 },
        fixed_rate_flags: if is_fixed_rate_ex {
            plane_flags.as_mut_ptr()
        } else {
            std::ptr::null_mut()
        },
        ..Default::default()
    }
}

/// `validate`
pub(crate) fn validate(
    instance: &Instance,
    device: &Device,
    physical_device: vk::PhysicalDevice,
    rc: &mut ResultCollector,
    params: &TestParams,
    control: &vk::ImageCompressionControlEXT,
    image: vk::Image,
) {
    let plane_aspects = [
        vk::ImageAspectFlags::PLANE_0,
        vk::ImageAspectFlags::PLANE_1,
        vk::ImageAspectFlags::PLANE_2,
    ];
    let num_planes = if params.ycbcr { params.plane_count as usize } else { 1 };

    for plane_index in 0..num_planes {
        let mut aspect = vk::ImageAspectFlags::COLOR;
        // VUID-vkGetImageSubresourceLayout2-format-08886
        if params.ycbcr && num_planes > 1 {
            aspect = plane_aspects[plane_index];
        }

        let mut compression_properties = vk::ImageCompressionPropertiesEXT::default();
        let subresource = vk::ImageSubresource2 {
            image_subresource: vk::ImageSubresource {
                aspect_mask: aspect,
                mip_level: 0,
                array_layer: 0,
            },
            ..Default::default()
        };
        let mut subresource_layout = vk::SubresourceLayout2 {
            next: (&raw mut compression_properties).cast::<c_void>(),
            ..Default::default()
        };
        unsafe { device.get_image_subresource_layout2_ext(image, &subresource, &mut subresource_layout) };

        let mut compression_enabled = vk::ImageCompressionControlEXT {
            compression_control_plane_count: control.compression_control_plane_count,
            flags: control.flags,
            ..Default::default()
        };
        let mut fixed_rate_flags_query = [fixed_rate_flags(FIXED_RATE_MAX_ENUM); 3];
        if compression_enabled.compression_control_plane_count > 0 {
            compression_enabled.fixed_rate_flags = fixed_rate_flags_query.as_mut_ptr();
        }

        let format_info = vk::PhysicalDeviceImageFormatInfo2 {
            next: (&raw const compression_enabled).cast::<c_void>(),
            format: params.format,
            type_: vk::ImageType::_2D,
            tiling: vk::ImageTiling::OPTIMAL,
            usage: vk::ImageUsageFlags::COLOR_ATTACHMENT,
            ..Default::default()
        };
        let mut compression_properties_supported = vk::ImageCompressionPropertiesEXT::default();
        let mut properties2 = vk::ImageFormatProperties2 {
            next: (&raw mut compression_properties_supported).cast::<c_void>(),
            ..Default::default()
        };
        let _ = unsafe {
            instance.get_physical_device_image_format_properties2(physical_device, &format_info, &mut properties2)
        };

        let actual_flags = compression_properties.image_compression_flags;
        let actual_rate = compression_properties.image_compression_fixed_rate_flags.bits();
        let supported_flags = compression_properties_supported.image_compression_flags;
        let supported_rate = compression_properties_supported
            .image_compression_fixed_rate_flags
            .bits();

        if params.use_extension {
            if (supported_rate & actual_rate) != actual_rate {
                rc.fail("Got image with fixed rate flags that are not supported in image format properties.");
            }
            if (supported_flags.bits() & actual_flags.bits()) != actual_flags.bits()
                && actual_flags != vk::ImageCompressionFlagsEXT::DISABLED
            {
                rc.fail("Got image with compression flags that are not supported in image format properties.");
            }
            if params.flags == vk::ImageCompressionFlagsEXT::DEFAULT && actual_rate != 0 {
                rc.fail("Got lossy compression when DEFAULT compression was requested.");
            }
            if params.flags == vk::ImageCompressionFlagsEXT::DISABLED
                && actual_flags != vk::ImageCompressionFlagsEXT::DISABLED
            {
                rc.fail("Image compression not disabled.");
            }
            if params.flags == vk::ImageCompressionFlagsEXT::DISABLED && actual_rate != 0 {
                rc.fail("Image compression disabled but got fixed rate flags.");
            }
            if params.flags == vk::ImageCompressionFlagsEXT::FIXED_RATE_DEFAULT
                && !(actual_flags == vk::ImageCompressionFlagsEXT::FIXED_RATE_EXPLICIT
                    || actual_flags == vk::ImageCompressionFlagsEXT::DISABLED
                    || actual_flags == vk::ImageCompressionFlagsEXT::DEFAULT)
            {
                rc.fail("Explicit compression flags not returned for image creation with FIXED RATE DEFAULT.");
            }

            if params.flags == vk::ImageCompressionFlagsEXT::FIXED_RATE_EXPLICIT {
                let requested = unsafe { *control.fixed_rate_flags.add(plane_index) }.bits();
                let min_requested_rate = 1u32.checked_shl(requested.trailing_zeros()).unwrap_or(0);
                if actual_flags != vk::ImageCompressionFlagsEXT::DISABLED
                    && actual_flags != vk::ImageCompressionFlagsEXT::DEFAULT
                    && min_requested_rate > actual_rate
                {
                    rc.fail("Image created with less bpc than requested.");
                }
            }
        } else {
            if actual_rate != vk::ImageCompressionFixedRateFlagsEXT::NONE.bits() {
                rc.fail("Fixed rate compression should not be enabled.");
            }

            if actual_flags != vk::ImageCompressionFlagsEXT::DISABLED
                && actual_flags != vk::ImageCompressionFlagsEXT::DEFAULT
            {
                rc.fail("Image compression should be default or not be enabled.");
            }
        }
    }
}

/// `imageCreateTest`
fn image_create_test(context: &Context<'_>, params: &TestParams) -> TestOutcome {
    let queue_family_index = context.get_universal_queue_family_index();
    let device = context.get_device();
    let mut rc = ResultCollector::new("");
    let is_fixed_rate_ex = params.flags == vk::ImageCompressionFlagsEXT::FIXED_RATE_EXPLICIT;

    let mut plane_bits = [0u32; 3];
    let iterations = if is_fixed_rate_ex { 24u32 } else { 1 };

    for i in 0..iterations {
        plane_bits[0] ^= 3 << i;
        plane_bits[1] ^= 5 << i;
        plane_bits[2] ^= 7 << i;
        let mut plane_flags = plane_bits.map(fixed_rate_flags);

        let control = make_control(params, &mut plane_flags);

        let mut image_create_info = vk::ImageCreateInfo {
            image_type: vk::ImageType::_2D,
            format: params.format,
            extent: vk::Extent3D {
                width: 16,
                height: 16,
                depth: 1,
            },
            mip_levels: 1,
            array_layers: 1,
            samples: vk::SampleCountFlags::_1,
            tiling: vk::ImageTiling::OPTIMAL,
            usage: vk::ImageUsageFlags::COLOR_ATTACHMENT,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 1,
            queue_family_indices: &queue_family_index,
            initial_layout: vk::ImageLayout::UNDEFINED,
            ..Default::default()
        };
        if params.use_extension {
            image_create_info.next = (&raw const control).cast::<c_void>();
        }

        let image = Unique::new(
            device,
            unsafe { device.create_image(&image_create_info, None) }.vk_check("vkCreateImage")?,
        );

        validate(
            context.get_instance(),
            device,
            context.get_physical_device(),
            &mut rc,
            params,
            &control,
            image.get(),
        );
    }
    Ok(rc.to_status())
}

struct ImageCompressionCase {
    name: &'static str,
    params: TestParams,
}

impl TestCase for ImageCompressionCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_image_create_test_support(context, &self.params)
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageCompressionInstance {
            context,
            params: self.params,
        })
    }
}

struct ImageCompressionInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for ImageCompressionInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        image_create_test(self.context, &self.params)
    }
}

/// `addImageCompressionControlTests`
fn add_image_compression_control_tests(
    name: &str,
    use_extension: bool,
    flags: vk::ImageCompressionFlagsEXT,
) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);

    for (format, case_name, ycbcr, plane_count) in uncompressed_formats_with_planes() {
        let params = TestParams {
            format,
            use_extension,
            flags,
            ycbcr,
            plane_count: if ycbcr { plane_count } else { 1 },
        };
        group.add_child(Box::new(ImageCompressionCase {
            name: case_name,
            params,
        }) as Box<dyn TestCase>);
    }
    group
}

/// `addAhbCompressionControlTests` - Android hardware buffers exist only on Android, so these end in NotSupported elsewhere.
struct AhbCompressionCase {
    name: &'static str,
}

impl TestCase for AhbCompressionCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_ANDROID_external_memory_android_hardware_buffer")?;
        context.require_device_functionality("VK_EXT_image_compression_control")?;
        Err(TestError::NotSupported(
            "Platform doesn't support Android Hardware Buffer handles".to_string(),
        ))
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, _context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(AhbCompressionInstance)
    }
}

struct AhbCompressionInstance;

impl TestInstance for AhbCompressionInstance {
    fn iterate(&mut self) -> TestOutcome {
        Err(TestError::NotPorted(
            "image compression control on an Android hardware buffer".to_string(),
        ))
    }
}

const AHB_FORMATS: [&str; 11] = [
    "a2b10g10r10_unorm_pack32",
    "d16_unorm",
    "d24_unorm_s8_uint",
    "d32_sfloat",
    "d32_sfloat_s8_uint",
    "r16g16b16a16_sfloat",
    "r5g6b5_unorm_pack16",
    "r8g8b8_unorm",
    "r8g8b8a8_unorm",
    "s8_uint",
    "x8_d24_unorm_pack32",
];

/// `createImageCompressionControlTests`
pub fn create_image_compression_control_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("image_compression_control");
    let mut create_image = TestCaseGroup::new("create_image");

    // Queries images created without compression control struct.
    create_image.add_child(add_image_compression_control_tests(
        "no_compression_control",
        false,
        vk::ImageCompressionFlagsEXT::DEFAULT,
    ));

    let compression_flags = [
        ("default", vk::ImageCompressionFlagsEXT::DEFAULT),
        ("fixed_rate_default", vk::ImageCompressionFlagsEXT::FIXED_RATE_DEFAULT),
        ("disabled", vk::ImageCompressionFlagsEXT::DISABLED),
        ("explicit", vk::ImageCompressionFlagsEXT::FIXED_RATE_EXPLICIT),
    ];
    for (name, flags) in compression_flags {
        create_image.add_child(add_image_compression_control_tests(name, true, flags));
    }

    group.add_child(create_image);

    let mut android_hardware_buffer = TestCaseGroup::new("android_hardware_buffer");
    for (name, _) in compression_flags {
        let mut flag_group = TestCaseGroup::new(name);
        for format in AHB_FORMATS {
            flag_group.add_child(Box::new(AhbCompressionCase { name: format }) as Box<dyn TestCase>);
        }
        android_hardware_buffer.add_child(flag_group);
    }
    group.add_child(android_hardware_buffer);
    let mut headless = crate::vkt::tests::wsi::compression_swapchain_cases();
    for child in crate::vkt::gated::build_gated_groups_with(
        include_str!("image_compression_control_swapchain_cases.txt"),
        &["VK_EXT_image_compression_control_swapchain", "VK_KHR_swapchain"],
        "the window system (only the headless platform exists here)",
        &mut |path| headless.remove(path),
    ) {
        group.add_child(child);
    }
    group
}
