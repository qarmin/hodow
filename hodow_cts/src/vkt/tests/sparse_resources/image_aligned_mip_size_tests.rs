// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesImageAlignedMipSize.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Checks that the first mip tail LOD the implementation reports follows from `residencyAlignedMipSize`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::base::{QueueRequirements, SparseDevice};
use super::tests_util::{
    ImageType, NO_MATCH_FOUND, TestImageParameters, check_sparse_support_for_image_format,
    check_sparse_support_for_image_type, format_is_r64, get_image_format_id, get_image_size_alignment,
    get_image_type_name, get_layer_size, get_mipmap_count, get_num_layers, get_sparse_aspect_requirements_index,
    get_test_formats, is_image_size_supported, map_image_type, mip_level_extents,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

struct ImageAlignedMipSizeCase {
    name: String,
    image_type: ImageType,
    image_size: [u32; 3],
    format: vk::Format,
}

impl TestCase for ImageAlignedMipSizeCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        // Check the image size does not exceed device limits
        if !is_image_size_supported(instance, physical_device, self.image_type, self.image_size) {
            return Err(TestError::NotSupported(
                "Image size not supported for device".to_string(),
            ));
        }

        // Check if device supports sparse operations for image type
        if !check_sparse_support_for_image_type(instance, physical_device, self.image_type) {
            return Err(TestError::NotSupported(
                "Sparse residency for image type is not supported".to_string(),
            ));
        }

        if format_is_r64(self.format) {
            context.require_device_functionality("VK_EXT_shader_image_atomic_int64")?;

            let mut atomic_int64_features = vk::PhysicalDeviceShaderImageAtomicInt64FeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut atomic_int64_features);
            unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
            if atomic_int64_features.sparse_image_int64_atomics == vk::FALSE {
                return Err(TestError::NotSupported(
                    "sparseImageInt64Atomics is not supported for device".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageAlignedMipSizeInstance {
            context,
            image_type: self.image_type,
            image_size: self.image_size,
            format: self.format,
        })
    }
}

struct ImageAlignedMipSizeInstance<'a> {
    context: &'a Context<'a>,
    image_type: ImageType,
    image_size: [u32; 3],
    format: vk::Format,
}

impl TestInstance for ImageAlignedMipSizeInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let sparse_properties = unsafe { instance.get_physical_device_properties(physical_device) }.sparse_properties;

        let extent = {
            let size = get_layer_size(self.image_type, self.image_size);
            vk::Extent3D {
                width: size[0],
                height: size[1],
                depth: size[2],
            }
        };
        let mut image_create_info = vk::ImageCreateInfo::builder()
            .flags(vk::ImageCreateFlags::SPARSE_RESIDENCY | vk::ImageCreateFlags::SPARSE_BINDING)
            .image_type(map_image_type(self.image_type))
            .format(self.format)
            .extent(extent)
            .array_layers(get_num_layers(self.image_type, self.image_size))
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::STORAGE)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .build();
        image_create_info.mip_levels = 1;

        if self.image_type == ImageType::Cube || self.image_type == ImageType::CubeArray {
            image_create_info.flags |= vk::ImageCreateFlags::CUBE_COMPATIBLE;
        }

        // Check if device supports sparse operations for image format
        if !check_sparse_support_for_image_format(instance, physical_device, &image_create_info) {
            return Err(TestError::NotSupported(
                "The image format does not support sparse operations".to_string(),
            ));
        }

        {
            let result = unsafe {
                instance.get_physical_device_image_format_properties(
                    physical_device,
                    image_create_info.format,
                    image_create_info.image_type,
                    image_create_info.tiling,
                    image_create_info.usage,
                    image_create_info.flags,
                )
            };
            match result {
                Err(error) if error == vk::ErrorCode::FORMAT_NOT_SUPPORTED => {
                    return Err(TestError::NotSupported(
                        "Image format does not support sparse operations".to_string(),
                    ));
                }
                Ok(image_format_properties) => {
                    image_create_info.mip_levels =
                        get_mipmap_count(self.format, &image_format_properties, image_create_info.extent);
                }
                Err(_) => {}
            }
        }

        let sparse_device = SparseDevice::new(
            context,
            &[QueueRequirements::new(vk::QueueFlags::SPARSE_BINDING, 1)],
            false,
        )?;
        let device = sparse_device.device();

        let (aspect_requirements, image_granularity) = {
            // Create sparse image
            let image_sparse = Unique::new(
                device,
                unsafe { device.create_image(&image_create_info, None) }.vk_check("vkCreateImage")?,
            );

            // Get sparse image sparse memory requirements
            let sparse_memory_requirements = unsafe { device.get_image_sparse_memory_requirements(*image_sparse) };
            assert!(!sparse_memory_requirements.is_empty());

            let color_aspect_index =
                get_sparse_aspect_requirements_index(&sparse_memory_requirements, vk::ImageAspectFlags::COLOR);
            if color_aspect_index == NO_MATCH_FOUND {
                return Err(TestError::NotSupported(
                    "Not supported image aspect - the test supports currently only VK_IMAGE_ASPECT_COLOR_BIT"
                        .to_string(),
                ));
            }

            let aspect_requirements = sparse_memory_requirements[color_aspect_index as usize];
            (
                aspect_requirements,
                aspect_requirements.format_properties.image_granularity,
            )
        };

        if sparse_properties.residency_aligned_mip_size != vk::FALSE {
            let mut lod = 0;
            loop {
                let extent = mip_level_extents(image_create_info.extent, lod);
                if !extent.width.is_multiple_of(image_granularity.width)
                    || !extent.height.is_multiple_of(image_granularity.height)
                    || !extent.depth.is_multiple_of(image_granularity.depth)
                {
                    break;
                }

                lod += 1;
                if !((extent.width != 1 || extent.height != 1 || extent.depth != 1)
                    && lod < image_create_info.mip_levels)
                {
                    break;
                }
            }

            if lod != aspect_requirements.image_mip_tail_first_lod {
                Ok(TestStatus::fail("Unexpected first LOD for mip tail."))
            } else {
                Ok(TestStatus::pass("pass"))
            }
        } else if aspect_requirements
            .format_properties
            .flags
            .contains(vk::SparseImageFormatFlags::ALIGNED_MIP_SIZE)
        {
            Ok(TestStatus::fail(
                "Aligned mip size flag doesn't match in device and image properties.",
            ))
        } else {
            Ok(TestStatus::pass("Aligned mip size not enabled."))
        }
    }
}

/// `createImageAlignedMipSizeTests`
pub fn create_image_aligned_mip_size_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("aligned_mip_size");

    let image_parameters = vec![
        TestImageParameters::new(ImageType::TwoD, vec![[512, 256, 1]], get_test_formats(ImageType::TwoD)),
        TestImageParameters::new(
            ImageType::TwoDArray,
            vec![[512, 256, 6]],
            get_test_formats(ImageType::TwoDArray),
        ),
        TestImageParameters::new(ImageType::Cube, vec![[256, 256, 1]], get_test_formats(ImageType::Cube)),
        TestImageParameters::new(
            ImageType::CubeArray,
            vec![[256, 256, 6]],
            get_test_formats(ImageType::CubeArray),
        ),
        TestImageParameters::new(
            ImageType::ThreeD,
            vec![[512, 256, 16]],
            get_test_formats(ImageType::ThreeD),
        ),
    ];

    for parameters in &image_parameters {
        let image_type = parameters.image_type;
        let mut image_type_group = TestCaseGroup::new(get_image_type_name(image_type));

        for &format in &parameters.formats {
            let image_size_alignment = get_image_size_alignment(format);
            let name = get_image_format_id(format);
            let image_size = parameters.image_sizes[0];

            // skip test for images with odd sizes for some YCbCr formats
            if image_size[0] % image_size_alignment[0] != 0 {
                continue;
            }
            if image_size[1] % image_size_alignment[1] != 0 {
                continue;
            }

            image_type_group.add_child(Box::new(ImageAlignedMipSizeCase {
                name,
                image_type,
                image_size,
                format,
            }) as Box<dyn TestCase>);
        }
        test_group.add_child(image_type_group);
    }

    test_group
}
