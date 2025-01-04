// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesImageBlockShapes.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Checks that the sparse image granularity an implementation reports is the standard block shape for the texel size, where the
// matching `residencyStandard*BlockShape` property says it should be.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::base::{QueueRequirements, SparseDevice};
use super::tests_util::{
    ImageType, NO_MATCH_FOUND, TestImageParameters, check_sparse_support_for_image_format,
    check_sparse_support_for_image_type, format_is_r64, get_image_format_id, get_image_size_alignment,
    get_image_type_name, get_layer_size, get_num_layers, get_sparse_aspect_requirements_index, get_test_formats,
    is_image_size_supported, map_image_type,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::compressed_formats::{get_block_height, get_block_size_in_bytes, get_block_width, is_compressed_format};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::ycbcr::copy_tests::is_ycbcr_format;
use crate::vkt::tests::ycbcr::util::{format_description, plane_aspect};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `isYCbCr422Format`
fn is_ycbcr_422_format(format: vk::Format) -> bool {
    use vk::Format as F;
    matches!(
        format,
        F::G8B8G8R8_422_UNORM
            | F::B8G8R8G8_422_UNORM
            | F::G8_B8_R8_3PLANE_422_UNORM
            | F::G8_B8R8_2PLANE_422_UNORM
            | F::G10X6B10X6G10X6R10X6_422_UNORM_4PACK16
            | F::B10X6G10X6R10X6G10X6_422_UNORM_4PACK16
            | F::G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16
            | F::G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16
            | F::G12X4B12X4G12X4R12X4_422_UNORM_4PACK16
            | F::B12X4G12X4R12X4G12X4_422_UNORM_4PACK16
            | F::G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16
            | F::G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16
            | F::G16B16G16R16_422_UNORM
            | F::B16G16R16G16_422_UNORM
            | F::G16_B16_R16_3PLANE_422_UNORM
            | F::G16_B16R16_2PLANE_422_UNORM
    )
}

struct ImageBlockShapesCase {
    name: String,
    image_type: ImageType,
    image_size: [u32; 3],
    format: vk::Format,
    num_samples: u32,
}

impl TestCase for ImageBlockShapesCase {
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

        // VUID-VkImageCreateInfo-format-06411
        if is_ycbcr_format(self.format) && self.num_samples > 1 {
            return Err(TestError::NotSupported(
                "YCbCr conversion formats only support a single sample".to_string(),
            ));
        }

        {
            let features = context.get_device_features();
            let sparse_samples_supported = match self.num_samples {
                1 => features.sparse_residency_image_2d,
                2 => features.sparse_residency2_samples,
                4 => features.sparse_residency4_samples,
                8 => features.sparse_residency8_samples,
                16 => features.sparse_residency16_samples,
                _ => vk::FALSE,
            };

            if sparse_samples_supported == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Unsupported number of samples for sparse residency".to_string(),
                ));
            }
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
        Box::new(ImageBlockShapesInstance {
            context,
            image_type: self.image_type,
            image_size: self.image_size,
            format: self.format,
            num_samples: self.num_samples,
        })
    }
}

struct ImageBlockShapesInstance<'a> {
    context: &'a Context<'a>,
    image_type: ImageType,
    image_size: [u32; 3],
    format: vk::Format,
    num_samples: u32,
}

/// The standard block shape (width, height, depth) of a texel size in bits, per the Vulkan specification's tables.
fn standard_block_shape(image_type: ImageType, num_samples: u32, pixel_size: u32) -> (u32, u32, u32) {
    if image_type == ImageType::ThreeD {
        return match pixel_size {
            8 => (64, 32, 32),
            16 => (32, 32, 32),
            32 => (32, 32, 16),
            64 => (32, 16, 16),
            _ => {
                assert!(pixel_size == 128);
                (16, 16, 16)
            }
        };
    }

    let (width, height) = match (num_samples, pixel_size) {
        (2, 8) => (128, 256),
        (2, 16) => (128, 128),
        (2, 32) => (64, 128),
        (2, 64) => (64, 64),
        (2, _) => (32, 64),
        (4, 8) => (128, 128),
        (4, 16) => (128, 64),
        (4, 32) => (64, 64),
        (4, 64) => (64, 32),
        (4, _) => (32, 32),
        (8, 8) => (64, 128),
        (8, 16) => (64, 64),
        (8, 32) => (32, 64),
        (8, 64) => (32, 32),
        (8, _) => (16, 32),
        (16, 8) => (64, 64),
        (16, 16) => (64, 32),
        (16, 32) => (32, 32),
        (16, 64) => (32, 16),
        (16, _) => (16, 16),
        (_, 8) => (256, 256),
        (_, 16) => (256, 128),
        (_, 32) => (128, 128),
        (_, 64) => (128, 64),
        (_, _) => (64, 64),
    };
    (width, height, 1)
}

impl TestInstance for ImageBlockShapesInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let sparse_properties = unsafe { instance.get_physical_device_properties(physical_device) }.sparse_properties;
        let is_compressed_fmt = is_compressed_format(self.format);
        let bits_per_pixel = 8u32;

        let layer_size = get_layer_size(self.image_type, self.image_size);
        let mut image_create_info = vk::ImageCreateInfo::builder()
            .flags(vk::ImageCreateFlags::SPARSE_RESIDENCY | vk::ImageCreateFlags::SPARSE_BINDING)
            .image_type(map_image_type(self.image_type))
            .format(self.format)
            .extent(vk::Extent3D {
                width: layer_size[0],
                height: layer_size[1],
                depth: layer_size[2],
            })
            .mip_levels(1)
            .array_layers(get_num_layers(self.image_type, self.image_size))
            .samples(vk::SampleCountFlags::from_bits_truncate(self.num_samples))
            .tiling(vk::ImageTiling::OPTIMAL)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .usage(vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .build();

        if self.image_type == ImageType::Cube || self.image_type == ImageType::CubeArray {
            image_create_info.flags |= vk::ImageCreateFlags::CUBE_COMPATIBLE;
        }

        // Check the format supports given number of samples
        let image_format_properties = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                image_create_info.format,
                image_create_info.image_type,
                image_create_info.tiling,
                image_create_info.usage,
                image_create_info.flags,
            )
        };
        match image_format_properties {
            Err(error) if error == vk::ErrorCode::FORMAT_NOT_SUPPORTED => {
                return Err(TestError::NotSupported(
                    "Image format does not support sparse operations".to_string(),
                ));
            }
            Ok(properties) => {
                if !properties.sample_counts.contains(image_create_info.samples) {
                    return Err(TestError::NotSupported(
                        "The image format does not support the number of samples specified".to_string(),
                    ));
                }
            }
            Err(_) => {}
        }

        // Check if device supports sparse operations for image format
        if !check_sparse_support_for_image_format(instance, physical_device, &image_create_info) {
            return Err(TestError::NotSupported(
                "The image format does not support sparse operations".to_string(),
            ));
        }

        let sparse_device = SparseDevice::new(
            context,
            &[QueueRequirements::new(vk::QueueFlags::SPARSE_BINDING, 1)],
            false,
        )?;
        let device = sparse_device.device();

        let sparse_memory_requirements = {
            // Create sparse image
            let image_sparse = Unique::new(
                device,
                unsafe { device.create_image(&image_create_info, None) }.vk_check("vkCreateImage")?,
            );

            // Get sparse image sparse memory requirements
            let requirements = unsafe { device.get_image_sparse_memory_requirements(*image_sparse) };
            assert!(!requirements.is_empty());
            requirements
        };

        let description = format_description(self.format);
        let num_planes = if is_compressed_fmt { 1 } else { description.planes.len() };

        for plane_ndx in 0..num_planes {
            let aspect = if num_planes > 1 {
                plane_aspect(plane_ndx)
            } else {
                vk::ImageAspectFlags::COLOR
            };
            let aspect_index = get_sparse_aspect_requirements_index(&sparse_memory_requirements, aspect);

            if aspect_index == NO_MATCH_FOUND {
                return Err(TestError::NotSupported("Not supported image aspect".to_string()));
            }

            let aspect_requirements = sparse_memory_requirements[aspect_index as usize];
            let image_granularity = aspect_requirements.format_properties.image_granularity;

            let pixel_size = if is_compressed_fmt {
                get_block_size_in_bytes(self.format) * bits_per_pixel
            } else {
                description.planes[plane_ndx].element_size * bits_per_pixel
            };

            // Standard sparse image block shapes are defined only up to 128-bit texels; larger formats
            // have no standardized shape, so there is nothing to validate against here.
            if pixel_size > 128 {
                return Ok(TestStatus::pass(
                    "Pass (no standard block shape defined for this texel size)",
                ));
            }

            if self.image_type == ImageType::ThreeD {
                if sparse_properties.residency_standard_3d_block_shape == vk::FALSE {
                    return Ok(TestStatus::pass("Pass (residencyStandard3DBlockShape disabled)"));
                }
            } else if self.num_samples == 2 || self.num_samples == 4 || self.num_samples == 8 || self.num_samples == 16
            {
                if sparse_properties.residency_standard_2d_multisample_block_shape == vk::FALSE {
                    return Ok(TestStatus::pass(
                        "Pass (residencyStandard2DMultisampleBlockShape disabled)",
                    ));
                }
            } else {
                assert!(self.num_samples == 1);

                if sparse_properties.residency_standard_2d_block_shape == vk::FALSE {
                    return Ok(TestStatus::pass("Pass (residencyStandard2DBlockShape disabled)"));
                }
            }

            let (mut expected_width, mut expected_height, expected_depth) =
                standard_block_shape(self.image_type, self.num_samples, pixel_size);

            if is_compressed_fmt {
                expected_width *= get_block_width(self.format);
                expected_height *= get_block_height(self.format);
            }

            if is_ycbcr_422_format(self.format) {
                expected_width *= description.block_width;
                expected_height *= description.block_height;
            }

            if image_granularity.width != expected_width
                || image_granularity.height != expected_height
                || image_granularity.depth != expected_depth
            {
                return Ok(TestStatus::fail("Non-standard block shape used"));
            }
        }

        Ok(TestStatus::pass("Passed"))
    }
}

/// `getImageTestFormats`
fn get_image_test_formats(image_type: ImageType) -> Vec<vk::Format> {
    use vk::Format as F;
    let mut results = get_test_formats(image_type);

    results.extend([
        F::BC1_RGB_UNORM_BLOCK,
        F::BC1_RGB_SRGB_BLOCK,
        F::BC1_RGBA_UNORM_BLOCK,
        F::BC1_RGBA_SRGB_BLOCK,
        F::BC2_UNORM_BLOCK,
        F::BC2_SRGB_BLOCK,
        F::BC3_UNORM_BLOCK,
        F::BC3_SRGB_BLOCK,
        F::BC4_UNORM_BLOCK,
        F::BC4_SNORM_BLOCK,
        F::BC5_UNORM_BLOCK,
        F::BC5_SNORM_BLOCK,
        F::BC6H_UFLOAT_BLOCK,
        F::BC6H_SFLOAT_BLOCK,
        F::BC7_UNORM_BLOCK,
        F::BC7_SRGB_BLOCK,
        F::ETC2_R8G8B8_UNORM_BLOCK,
        F::ETC2_R8G8B8_SRGB_BLOCK,
        F::ETC2_R8G8B8A1_UNORM_BLOCK,
        F::ETC2_R8G8B8A1_SRGB_BLOCK,
        F::ETC2_R8G8B8A8_UNORM_BLOCK,
        F::ETC2_R8G8B8A8_SRGB_BLOCK,
        F::EAC_R11_UNORM_BLOCK,
        F::EAC_R11_SNORM_BLOCK,
        F::EAC_R11G11_UNORM_BLOCK,
        F::EAC_R11G11_SNORM_BLOCK,
        F::ASTC_4X4_UNORM_BLOCK,
        F::ASTC_4X4_SRGB_BLOCK,
        F::ASTC_5X4_UNORM_BLOCK,
        F::ASTC_5X4_SRGB_BLOCK,
        F::ASTC_5X5_UNORM_BLOCK,
        F::ASTC_5X5_SRGB_BLOCK,
        F::ASTC_6X5_UNORM_BLOCK,
        F::ASTC_6X5_SRGB_BLOCK,
        F::ASTC_6X6_UNORM_BLOCK,
        F::ASTC_6X6_SRGB_BLOCK,
        F::ASTC_8X5_UNORM_BLOCK,
        F::ASTC_8X5_SRGB_BLOCK,
        F::ASTC_8X6_UNORM_BLOCK,
        F::ASTC_8X6_SRGB_BLOCK,
        F::ASTC_8X8_UNORM_BLOCK,
        F::ASTC_8X8_SRGB_BLOCK,
        F::ASTC_10X5_UNORM_BLOCK,
        F::ASTC_10X5_SRGB_BLOCK,
        F::ASTC_10X6_UNORM_BLOCK,
        F::ASTC_10X6_SRGB_BLOCK,
        F::ASTC_10X8_UNORM_BLOCK,
        F::ASTC_10X8_SRGB_BLOCK,
        F::ASTC_10X10_UNORM_BLOCK,
        F::ASTC_10X10_SRGB_BLOCK,
        F::ASTC_12X10_UNORM_BLOCK,
        F::ASTC_12X10_SRGB_BLOCK,
        F::ASTC_12X12_UNORM_BLOCK,
        F::ASTC_12X12_SRGB_BLOCK,
    ]);

    results
}

/// `createImageBlockShapesTests`
pub fn create_image_block_shapes_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("image_block_shapes");

    let image_parameters = vec![
        TestImageParameters::new(
            ImageType::TwoD,
            vec![[512, 256, 1]],
            get_image_test_formats(ImageType::TwoD),
        ),
        TestImageParameters::new(
            ImageType::TwoDArray,
            vec![[512, 256, 6]],
            get_image_test_formats(ImageType::TwoDArray),
        ),
        TestImageParameters::new(
            ImageType::Cube,
            vec![[256, 256, 1]],
            get_image_test_formats(ImageType::Cube),
        ),
        TestImageParameters::new(
            ImageType::CubeArray,
            vec![[256, 256, 6]],
            get_image_test_formats(ImageType::CubeArray),
        ),
        TestImageParameters::new(
            ImageType::ThreeD,
            vec![[512, 256, 16]],
            get_image_test_formats(ImageType::ThreeD),
        ),
    ];

    const SAMPLE_COUNTS: [u32; 5] = [1, 2, 4, 8, 16];

    for parameters in &image_parameters {
        let image_type = parameters.image_type;
        let mut image_type_group = TestCaseGroup::new(get_image_type_name(image_type));

        for &format in &parameters.formats {
            let mut format_group = TestCaseGroup::new(get_image_format_id(format));

            for sample_count in SAMPLE_COUNTS {
                for &image_size in &parameters.image_sizes {
                    // skip test for images with odd sizes for some YCbCr formats
                    if is_ycbcr_format(format) {
                        let image_size_alignment = get_image_size_alignment(format);
                        if image_size[0] % image_size_alignment[0] != 0 {
                            continue;
                        }
                        if image_size[1] % image_size_alignment[1] != 0 {
                            continue;
                        }
                    }

                    if image_type != ImageType::TwoD && image_type != ImageType::TwoDArray && sample_count > 1 {
                        continue;
                    }

                    let name = format!("samples_{sample_count}");
                    format_group.add_child(Box::new(ImageBlockShapesCase {
                        name,
                        image_type,
                        image_size,
                        format,
                        num_samples: sample_count,
                    }) as Box<dyn TestCase>);
                }
            }
            image_type_group.add_child(format_group);
        }
        test_group.add_child(image_type_group);
    }

    test_group
}
