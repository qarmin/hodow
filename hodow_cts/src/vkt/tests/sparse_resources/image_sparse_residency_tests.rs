// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesImageSparseResidency.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `ImageMutableSparseTest` (the `mutable` group) and `ImageSparseResidencyCase` for the
// formats with a single plane are here; the device group variant (`device_group_image_sparse_residency`) is not ported, so the loop over
// physical devices runs once, and neither are the multi-planar and YCbCr formats (the verification reads each channel through
// `getChannelAccess`, which the reduced `FormatInfo` cannot describe) and the A8_UNORM extra format. The compute shaders are in
// shaders/manifest/sparse_resources_image_mutable.toml (`scripts/gen_sparse_mutable_manifest.py`, one program set per image type and pair
// of view formats, found by `mutable_key`) and sparse_resources_image_residency.toml (`scripts/gen_sparse_residency_manifest.py`, one per
// image type, format and size, found by `residency_key`).
//
// `ImageSparseResidencyCase` binds every second sparse block of an image, stores a value derived from the invocation id with a compute
// shader, copies the image to a buffer and checks the bound blocks for that value and, where the implementation reports strict residency,
// the others for zero.
//
// A sparse image of one format is bound only in its left half, two views of it in different formats of the same texel size are
// written by a compute shader (the upper rows through the first view, the lower rows through the second), and the image is copied to a
// buffer and compared with the colour each view should have stored.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::base::{QueueRequirements, SparseDevice};
use super::tests_util::{
    BUFFER_IMAGE_COPY_OFFSET_GRANULARITY, ImageType, NO_MATCH_FOUND, TestImageParameters, aligned_divide,
    check_sparse_support_for_image_format, check_sparse_support_for_image_type, find_matching_memory_type,
    format_is_r64, get_image_format_id, get_image_mip_level_size_in_bytes, get_image_size_alignment,
    get_image_type_name, get_layer_size, get_num_layers, get_plane_compatible_format_for_writing, get_plane_extent,
    get_shader_grid_size, get_sparse_aspect_requirements_index, get_storage_compatible_format, get_test_formats,
    is_image_size_supported, make_sparse_image_memory_bind, make_sparse_memory_bind, map_image_type,
    map_image_view_type, submit_commands_and_wait,
};
use crate::generated::shaders::sparse_resources_image_mutable::ALL_SHARED_PROGRAM;
use crate::generated::shaders::sparse_resources_image_residency::ALL_SHARED_PROGRAM as RESIDENCY_PROGRAMS;
use crate::tcu::image_compare::{float_threshold_compare, int_threshold_compare};
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel};
use crate::tcu::tex_verifier::compute_fixed_point_error;
use crate::tcu::texture::{ChannelType, TextureChannelClass, map_vk_format};
use crate::tcu::{TestError, TestOutcome, TestStatus, UVec4};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::ycbcr::copy_tests::is_ycbcr_format;
use crate::vkt::tests::ycbcr::util::format_description;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FLOAT: [f32; 4] = [0.00, 0.40, 0.80, 0.10];
const COLOR_INT: [u32; 4] = [0x70707070, 0x3C3C3C3C, 0x65656565, 0x29292929];
const NUM_PORTIONS: u32 = 2;
const WIDTH_DIVISOR: u32 = 2;

fn texture_format_of(format: vk::Format) -> Result<crate::tcu::TextureFormat, TestError> {
    map_vk_format(format).ok_or_else(|| TestError::NotPorted(format!("texture format of {format:?}")))
}

fn is_integer_format(format: vk::Format) -> bool {
    map_vk_format(format).is_some_and(|f| {
        matches!(
            f.channel_class(),
            TextureChannelClass::SignedInteger | TextureChannelClass::UnsignedInteger
        )
    })
}

/// `getColorInt` - the integer colour masked to the channel size of the format.
fn get_color_int(format: vk::Format) -> Result<[i32; 4], TestError> {
    let channel_mask: u32 = match texture_format_of(format)?.type_ {
        ChannelType::SIGNED_INT8 | ChannelType::UNSIGNED_INT8 | ChannelType::SNORM_INT8 | ChannelType::UNORM_INT8 => {
            0xFF
        }
        ChannelType::SIGNED_INT16
        | ChannelType::UNSIGNED_INT16
        | ChannelType::SNORM_INT16
        | ChannelType::UNORM_INT16 => 0xFFFF,
        ChannelType::SIGNED_INT32
        | ChannelType::UNSIGNED_INT32
        | ChannelType::SNORM_INT32
        | ChannelType::UNORM_INT32 => 0xFFFF_FFFF,
        other => return Err(TestError::NotPorted(format!("channel size of {other:?}"))),
    };
    Ok(COLOR_INT.map(|value| (value & channel_mask) as i32))
}

/// `getFormatShortString`
fn get_format_short_string(format: vk::Format) -> String {
    format!("{format:?}").to_lowercase()
}

/// The key of the manifest entry of a case.
fn mutable_key(image_type: ImageType, view1_format: vk::Format, view2_format: vk::Format) -> String {
    format!(
        "mutable_{}_{}_{}",
        get_image_type_name(image_type),
        get_format_short_string(view1_format),
        get_format_short_string(view2_format)
    )
}

struct ImageMutableSparseCase {
    name: String,
    image_type: ImageType,
    image_size: [u32; 3],
    image_format: vk::Format,
    view1_format: vk::Format,
    view2_format: vk::Format,
}

impl TestCase for ImageMutableSparseCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `ImageMutableSparseTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let image_usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::STORAGE;
        let mut image_flags = vk::ImageCreateFlags::SPARSE_RESIDENCY | vk::ImageCreateFlags::SPARSE_BINDING;

        if self.image_type == ImageType::Cube || self.image_type == ImageType::CubeArray {
            image_flags |= vk::ImageCreateFlags::CUBE_COMPATIBLE;
        }

        // Check if we need to create image view with different from image format
        if self.image_format != self.view1_format || self.image_format != self.view2_format {
            image_flags |= vk::ImageCreateFlags::MUTABLE_FORMAT;
        }

        // Check if image size does not exceed device limits
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

        // Check if image format supports storage images
        for format in [self.image_format, self.view1_format, self.view2_format] {
            let format_properties = unsafe { instance.get_physical_device_format_properties(physical_device, format) };
            if !format_properties
                .optimal_tiling_features
                .contains(vk::FormatFeatureFlags::STORAGE_IMAGE)
            {
                return Err(TestError::NotSupported(
                    "Storage images are not supported for this format".to_string(),
                ));
            }
        }

        if !crate::vk::sparse_util::check_sparse_image_format_support_for(
            instance,
            physical_device,
            self.image_format,
            map_image_type(self.image_type),
            vk::SampleCountFlags::_1,
            image_usage,
            vk::ImageTiling::OPTIMAL,
        ) {
            return Err(TestError::NotSupported(
                "The image format does not support sparse operations".to_string(),
            ));
        }

        let result = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                self.image_format,
                map_image_type(self.image_type),
                vk::ImageTiling::OPTIMAL,
                image_usage,
                image_flags,
            )
        };
        if result.is_err() {
            return Err(TestError::NotSupported(
                "The image format does not support sparse+mutable operations".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = mutable_key(self.image_type, self.view1_format, self.view2_format);
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .map_or_else(|| BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageMutableSparseInstance {
            context,
            image_type: self.image_type,
            image_size: self.image_size,
            image_format: self.image_format,
            view1_format: self.view1_format,
            view2_format: self.view2_format,
        })
    }
}

struct ImageMutableSparseInstance<'a> {
    context: &'a Context<'a>,
    image_type: ImageType,
    image_size: [u32; 3],
    image_format: vk::Format,
    view1_format: vk::Format,
    view2_format: vk::Format,
}

/// `generateExpectedImage`
fn generate_expected_image(format: vk::Format, image_size: [u32; 3]) -> Result<TextureLevel, TestError> {
    let mut level = TextureLevel::new(texture_format_of(format)?, image_size[0], image_size[1], image_size[2])?;
    let integer = is_integer_format(format);
    let color_int = if integer { get_color_int(format)? } else { [0; 4] };
    let mut image = level.get_access();

    for z in 0..image_size[2] {
        for y in 0..image_size[1] {
            for x in 0..image_size[0] {
                if integer {
                    let _ = image.set_pixel_int(color_int, x, y, z);
                } else {
                    image.set_pixel(COLOR_FLOAT, x, y, z);
                }
            }
        }
    }

    Ok(level)
}

impl ImageMutableSparseInstance<'_> {
    /// `ImageMutableSparseTestInstance::verifyImage`
    fn verify_image(&self, image_ext: vk::Extent3D, output_data: &[u8]) -> TestOutcome {
        let tcu_format = texture_format_of(self.image_format)?;
        let pixel_size = tcu_format
            .pixel_size()
            .ok_or_else(|| TestError::NotPorted(format!("pixel size of {:?}", self.image_format)))?;
        let layer_pixels = image_ext.width * image_ext.height;
        let layer_bytes = (layer_pixels * pixel_size) as usize;
        // Each portion is half in height of the bound image
        let portion_ext = vk::Extent3D {
            width: image_ext.width,
            height: image_ext.height / NUM_PORTIONS,
            depth: image_ext.depth,
        };
        let portion_pixels = portion_ext.width * portion_ext.height;
        let portion_bytes = (portion_pixels * pixel_size) as usize;

        let portion_size = [portion_ext.width, portion_ext.height, portion_ext.depth];

        let is_img1_integer_format = is_integer_format(self.view1_format);
        let expected_image1 = generate_expected_image(self.view1_format, portion_size)?;

        let is_img2_integer_format = is_integer_format(self.view2_format);
        let expected_image2 = generate_expected_image(self.view2_format, portion_size)?;

        let mut ok_a = false;
        let mut ok_b = false;
        let int_threshold = UVec4::from_array([0; 4]);
        let float_threshold = [0.01f32; 4];

        let num_layers = get_num_layers(self.image_type, self.image_size);
        let depth_or_layers = self.image_size[2].max(num_layers);

        let compare =
            |expected: &TextureLevel, format: vk::Format, integer: bool, data: &[u8]| -> Result<bool, TestError> {
                let result = ConstPixelBufferAccess::new(texture_format_of(format)?, portion_size, data);
                let reference = expected.get_const_access();
                Ok(if integer {
                    int_threshold_compare(&reference, &result, int_threshold).ok
                } else {
                    float_threshold_compare(&reference, &result, float_threshold).ok
                })
            };

        for layer_idx in 0..depth_or_layers as usize {
            let layer_offset = layer_idx * layer_bytes;

            ok_a = compare(
                &expected_image1,
                self.view1_format,
                is_img1_integer_format,
                &output_data[layer_offset..layer_offset + portion_bytes],
            )?;
            ok_b = compare(
                &expected_image2,
                self.view2_format,
                is_img2_integer_format,
                &output_data[layer_offset + portion_bytes..layer_offset + 2 * portion_bytes],
            )?;

            if !ok_a || !ok_b {
                log::info!("Layer {layer_idx} comparison failed (portion 0: {ok_a}, portion 1: {ok_b})");
                break;
            }
        }

        Ok(if ok_a && ok_b {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestInstance for ImageMutableSparseInstance<'_> {
    /// `ImageMutableSparseTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;

        // Create logical device supporting sparse and compute queues
        let sparse_device = SparseDevice::new(
            context,
            &[
                QueueRequirements::new(vk::QueueFlags::SPARSE_BINDING, 1),
                QueueRequirements::new(vk::QueueFlags::COMPUTE, 1),
            ],
            false,
        )?;
        let device = sparse_device.device();

        // Get device interface once queues are created
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        // Create sparse image
        let mut image_flags = vk::ImageCreateFlags::SPARSE_RESIDENCY | vk::ImageCreateFlags::SPARSE_BINDING;

        if self.image_type == ImageType::Cube || self.image_type == ImageType::CubeArray {
            image_flags |= vk::ImageCreateFlags::CUBE_COMPATIBLE;
        }

        // Check if we need to create image view with different from image format
        if self.image_format != self.view1_format || self.image_format != self.view2_format {
            image_flags |= vk::ImageCreateFlags::MUTABLE_FORMAT;
        }

        let layer_size = get_layer_size(self.image_type, self.image_size);
        let image_create_info = vk::ImageCreateInfo::builder()
            .flags(image_flags)
            .image_type(map_image_type(self.image_type))
            .format(self.image_format)
            .extent(vk::Extent3D {
                width: layer_size[0],
                height: layer_size[1],
                depth: layer_size[2],
            })
            .mip_levels(1)
            .array_layers(get_num_layers(self.image_type, self.image_size))
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::STORAGE)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let image_sparse = Unique::new(
            device,
            unsafe { device.create_image(&image_create_info, None) }.vk_check("vkCreateImage")?,
        );

        // Image extent that is actually used
        let image_ext = vk::Extent3D {
            width: image_create_info.extent.width / WIDTH_DIVISOR,
            height: image_create_info.extent.height,
            depth: image_create_info.extent.depth,
        };

        // Create sparse image memory bind semaphore
        let image_memory_bind_semaphore = Unique::new(
            device,
            unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                .vk_check("vkCreateSemaphore")?,
        );

        // Bind sparse memory
        let sparse_queue = sparse_device.get_queue(vk::QueueFlags::SPARSE_BINDING, 0);
        let mut device_memory: Vec<Unique<'_, vk::DeviceMemory>> = Vec::new();

        {
            let mut image_residency_memory_binds: Vec<vk::SparseImageMemoryBind> = Vec::new();
            let mut image_mip_tail_memory_binds: Vec<vk::SparseMemoryBind> = Vec::new();

            // Get image general memory requirements
            let image_memory_requirements = unsafe { device.get_image_memory_requirements(*image_sparse) };

            if image_memory_requirements.size
                > unsafe { instance.get_physical_device_properties(physical_device) }
                    .limits
                    .sparse_address_space_size
            {
                return Err(TestError::NotSupported(
                    "Required memory size for sparse resource exceeds device limits".to_string(),
                ));
            }

            assert!(image_memory_requirements.size % image_memory_requirements.alignment == 0);

            let memory_type = find_matching_memory_type(
                instance,
                physical_device,
                &image_memory_requirements,
                MemoryRequirement::ANY,
            );

            if memory_type == NO_MATCH_FOUND {
                return Ok(TestStatus::fail("No matching memory type found"));
            }

            // Get sparse image sparse memory requirements
            let sparse_memory_requirements = unsafe { device.get_image_sparse_memory_requirements(*image_sparse) };
            assert!(!sparse_memory_requirements.is_empty());

            // Color aspect
            let aspect_index =
                get_sparse_aspect_requirements_index(&sparse_memory_requirements, vk::ImageAspectFlags::COLOR);

            if aspect_index == NO_MATCH_FOUND {
                return Err(TestError::NotSupported("Image aspect not supported".to_string()));
            }

            let aspect_requirements = sparse_memory_requirements[aspect_index as usize];
            let image_granularity = aspect_requirements.format_properties.image_granularity;

            // Test implements only base mip level
            assert!(image_create_info.mip_levels == 1);

            // Metadata aspect
            let metadata_aspect_index =
                get_sparse_aspect_requirements_index(&sparse_memory_requirements, vk::ImageAspectFlags::METADATA);

            // Allocate left half of the image
            let num_sparse_binds = aligned_divide(image_ext, image_granularity);
            {
                for layer_ndx in 0..image_create_info.array_layers {
                    for mip_level_ndx in 0..aspect_requirements
                        .image_mip_tail_first_lod
                        .min(image_create_info.mip_levels)
                    {
                        let last_block_extent = [
                            if !image_ext.width.is_multiple_of(image_granularity.width) {
                                image_ext.width % image_granularity.width
                            } else {
                                image_granularity.width
                            },
                            if !image_ext.height.is_multiple_of(image_granularity.height) {
                                image_ext.height % image_granularity.height
                            } else {
                                image_granularity.height
                            },
                            if !image_ext.depth.is_multiple_of(image_granularity.depth) {
                                image_ext.depth % image_granularity.depth
                            } else {
                                image_granularity.depth
                            },
                        ];

                        let subresource = vk::ImageSubresource {
                            aspect_mask: vk::ImageAspectFlags::COLOR,
                            mip_level: mip_level_ndx,
                            array_layer: layer_ndx,
                        };

                        // imageResidencyMemoryBinds
                        for z in 0..num_sparse_binds[2] {
                            for y in 0..num_sparse_binds[1] {
                                for x in 0..num_sparse_binds[0] {
                                    let offset = vk::Offset3D {
                                        x: (x * image_granularity.width) as i32,
                                        y: (y * image_granularity.height) as i32,
                                        z: (z * image_granularity.depth) as i32,
                                    };

                                    let extent = vk::Extent3D {
                                        width: if x == num_sparse_binds[0] - 1 {
                                            last_block_extent[0]
                                        } else {
                                            image_granularity.width
                                        },
                                        height: if y == num_sparse_binds[1] - 1 {
                                            last_block_extent[1]
                                        } else {
                                            image_granularity.height
                                        },
                                        depth: if z == num_sparse_binds[2] - 1 {
                                            last_block_extent[2]
                                        } else {
                                            image_granularity.depth
                                        },
                                    };

                                    let image_memory_bind = make_sparse_image_memory_bind(
                                        device,
                                        image_memory_requirements.alignment,
                                        memory_type,
                                        subresource,
                                        offset,
                                        extent,
                                    )?;

                                    device_memory.push(Unique::new(device, image_memory_bind.memory));
                                    image_residency_memory_binds.push(image_memory_bind);
                                }
                            }
                        }
                    }

                    // Per-layer miptail allocation if per-layer maiptail
                    if !aspect_requirements
                        .format_properties
                        .flags
                        .contains(vk::SparseImageFormatFlags::SINGLE_MIPTAIL)
                        && aspect_requirements.image_mip_tail_first_lod < image_create_info.mip_levels
                    {
                        let image_mip_tail_memory_bind = make_sparse_memory_bind(
                            device,
                            aspect_requirements.image_mip_tail_size,
                            memory_type,
                            aspect_requirements.image_mip_tail_offset
                                + vk::DeviceSize::from(layer_ndx) * aspect_requirements.image_mip_tail_stride,
                            vk::SparseMemoryBindFlags::empty(),
                        )?;

                        device_memory.push(Unique::new(device, image_mip_tail_memory_bind.memory));
                        image_mip_tail_memory_binds.push(image_mip_tail_memory_bind);
                    }

                    // Per-layer metadata allocation if per-layer maiptail
                    if metadata_aspect_index != NO_MATCH_FOUND {
                        let metadata_aspect_requirements = sparse_memory_requirements[metadata_aspect_index as usize];

                        if !metadata_aspect_requirements
                            .format_properties
                            .flags
                            .contains(vk::SparseImageFormatFlags::SINGLE_MIPTAIL)
                        {
                            let image_mip_tail_memory_bind = make_sparse_memory_bind(
                                device,
                                metadata_aspect_requirements.image_mip_tail_size,
                                memory_type,
                                metadata_aspect_requirements.image_mip_tail_offset
                                    + vk::DeviceSize::from(layer_ndx)
                                        * metadata_aspect_requirements.image_mip_tail_stride,
                                vk::SparseMemoryBindFlags::METADATA,
                            )?;

                            device_memory.push(Unique::new(device, image_mip_tail_memory_bind.memory));
                            image_mip_tail_memory_binds.push(image_mip_tail_memory_bind);
                        }
                    }
                }

                // Whole image metadata and miptail
                {
                    // Miptail
                    if aspect_requirements
                        .format_properties
                        .flags
                        .contains(vk::SparseImageFormatFlags::SINGLE_MIPTAIL)
                        && aspect_requirements.image_mip_tail_first_lod < image_create_info.mip_levels
                    {
                        let image_mip_tail_memory_bind = make_sparse_memory_bind(
                            device,
                            aspect_requirements.image_mip_tail_size,
                            memory_type,
                            aspect_requirements.image_mip_tail_offset,
                            vk::SparseMemoryBindFlags::empty(),
                        )?;

                        device_memory.push(Unique::new(device, image_mip_tail_memory_bind.memory));
                        image_mip_tail_memory_binds.push(image_mip_tail_memory_bind);
                    }

                    // Metadata
                    if metadata_aspect_index != NO_MATCH_FOUND {
                        let metadata_aspect_requirements = sparse_memory_requirements[metadata_aspect_index as usize];

                        if metadata_aspect_requirements
                            .format_properties
                            .flags
                            .contains(vk::SparseImageFormatFlags::SINGLE_MIPTAIL)
                        {
                            let image_mip_tail_memory_bind = make_sparse_memory_bind(
                                device,
                                metadata_aspect_requirements.image_mip_tail_size,
                                memory_type,
                                metadata_aspect_requirements.image_mip_tail_offset,
                                vk::SparseMemoryBindFlags::METADATA,
                            )?;

                            device_memory.push(Unique::new(device, image_mip_tail_memory_bind.memory));
                            image_mip_tail_memory_binds.push(image_mip_tail_memory_bind);
                        }
                    }
                }
            }

            let signal_semaphores = [*image_memory_bind_semaphore];
            let image_residency_bind_info = [vk::SparseImageMemoryBindInfo::builder()
                .image(*image_sparse)
                .binds(&image_residency_memory_binds)
                .build()];
            let image_mip_tail_bind_info = [vk::SparseImageOpaqueMemoryBindInfo::builder()
                .image(*image_sparse)
                .binds(&image_mip_tail_memory_binds)
                .build()];

            let mut bind_sparse_info = vk::BindSparseInfo::builder().signal_semaphores(&signal_semaphores);

            if !image_residency_memory_binds.is_empty() {
                bind_sparse_info = bind_sparse_info.image_binds(&image_residency_bind_info);
            }

            if !image_mip_tail_memory_binds.is_empty() {
                bind_sparse_info = bind_sparse_info.image_opaque_binds(&image_mip_tail_bind_info);
            }

            // Submit sparse bind commands for execution
            unsafe { device.queue_bind_sparse(sparse_queue.handle, &[bind_sparse_info], vk::Fence::null()) }
                .vk_check("vkQueueBindSparse")?;
            unsafe { device.queue_wait_idle(sparse_queue.handle) }.vk_check("vkQueueWaitIdle")?;
        }

        let compute_queue = sparse_device.get_queue(vk::QueueFlags::COMPUTE, 0);
        let subresource_range = make_image_subresource_range(
            vk::ImageAspectFlags::COLOR,
            0,
            1,
            0,
            get_num_layers(self.image_type, self.image_size),
        );

        // Create command buffer for compute and transfer operations
        let command_pool = make_command_pool(device, compute_queue.family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;

        // Start recording commands
        begin_command_buffer(device, cmd)?;

        // Create descriptor set layout
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;

        // Create and bind descriptor set
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        // Create and bind compute pipeline
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let shader_module = create_shader_module(device, context.get_binary_collection().get("comp")?)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*shader_module)
            .name(b"main\0");
        let compute_info = vk::ComputePipelineCreateInfo::builder()
            .stage(*stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(0);
        let compute_pipelines =
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[compute_info], None) }
                .vk_check("vkCreateComputePipelines")?;
        let compute_pipeline = Unique::new(device, compute_pipelines.0[0]);

        unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *compute_pipeline) };

        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let view_type = map_image_view_type(self.image_type);
        let image_view1 = make_image_view(device, *image_sparse, view_type, self.view1_format, subresource_range)?;
        let image_view2 = make_image_view(device, *image_sparse, view_type, self.view2_format, subresource_range)?;

        let image_info1 = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *image_view1,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let image_info2 = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *image_view2,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .dst_array_element(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&image_info1)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(1)
                .dst_array_element(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&image_info2)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            )
        };

        {
            let image_sparse_layout_change_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                *image_sparse,
                subresource_range,
            );

            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_sparse_layout_change_barrier],
                );
            }
        }

        // Compute
        unsafe {
            device.cmd_dispatch(
                cmd,
                image_ext.width,
                image_ext.height,
                image_ext.depth * image_create_info.array_layers,
            )
        };

        {
            let image_sparse_transfer_barrier = make_image_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                *image_sparse,
                subresource_range,
            );

            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_sparse_transfer_barrier],
                );
            }
        }

        // Create output buffer
        let pixel_size = texture_format_of(self.image_format)?
            .pixel_size()
            .ok_or_else(|| TestError::NotPorted(format!("pixel size of {:?}", self.image_format)))?;
        let image_size_in_bytes = vk::DeviceSize::from(pixel_size)
            * vk::DeviceSize::from(image_ext.width)
            * vk::DeviceSize::from(image_ext.height)
            * vk::DeviceSize::from(image_ext.depth)
            * vk::DeviceSize::from(image_create_info.array_layers);
        let output_buffer = BufferWithMemory::new(
            device,
            sparse_device.allocator(),
            make_buffer_create_info(image_size_in_bytes, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let mut buffer_image_copy: Vec<vk::BufferImageCopy> =
            Vec::with_capacity((NUM_PORTIONS * image_create_info.array_layers * image_ext.depth) as usize);

        // Create buffer copy regions for each portion of each layer
        let portion_ext = vk::Extent3D {
            width: image_ext.width,
            height: image_ext.height / NUM_PORTIONS,
            depth: 1,
        };
        let portion_size_in_bytes = vk::DeviceSize::from(pixel_size)
            * vk::DeviceSize::from(portion_ext.width)
            * vk::DeviceSize::from(portion_ext.height);
        let mut bytes: vk::DeviceSize = 0;

        for layer_idx in 0..image_create_info.array_layers {
            for depth_idx in 0..image_ext.depth {
                let mut image_offset = vk::Offset3D {
                    x: 0,
                    y: 0,
                    z: depth_idx as i32,
                };
                let subresource_layers = vk::ImageSubresourceLayers {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    mip_level: 0,
                    base_array_layer: layer_idx,
                    layer_count: 1,
                };
                buffer_image_copy.push(vk::BufferImageCopy {
                    buffer_offset: bytes,
                    buffer_row_length: 0,
                    buffer_image_height: 0,
                    image_subresource: subresource_layers,
                    image_offset,
                    image_extent: portion_ext,
                });

                image_offset.y += portion_ext.height as i32;
                bytes += portion_size_in_bytes;

                buffer_image_copy.push(vk::BufferImageCopy {
                    buffer_offset: bytes,
                    buffer_row_length: 0,
                    buffer_image_height: 0,
                    image_subresource: subresource_layers,
                    image_offset,
                    image_extent: portion_ext,
                });

                bytes += portion_size_in_bytes;
            }
        }

        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd,
                *image_sparse,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                output_buffer.get(),
                &buffer_image_copy,
            )
        };
        {
            let output_buffer_host_read_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                output_buffer.get(),
                0,
                image_size_in_bytes,
            );

            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[output_buffer_host_read_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        // End recording commands
        end_command_buffer(device, cmd)?;

        // The stage at which execution is going to wait for finish of sparse binding operations
        let stage_bits = [vk::PipelineStageFlags::COMPUTE_SHADER];
        submit_commands_and_wait(
            device,
            compute_queue.handle,
            cmd,
            &[*image_memory_bind_semaphore],
            &stage_bits,
            &[],
        )?;

        // Retrieve data from buffer to host memory
        invalidate_alloc(device, output_buffer.get_allocation())?;
        let output_data = unsafe {
            std::slice::from_raw_parts(
                output_buffer.get_allocation().get_host_ptr().cast_const(),
                image_size_in_bytes as usize,
            )
        };

        let img_ext = vk::Extent3D {
            width: image_ext.width,
            height: image_ext.height,
            depth: 1,
        };
        let outcome = self.verify_image(img_ext, output_data);

        // Keep the bound memory alive until here.
        drop(device_memory);

        outcome
    }
}

const EPSILON: f32 = 1e-5;
const MAX_COMPUTE_WORK_GROUP_COUNT: u32 = 65535;

/// `computeWorkGroupSize`
fn compute_work_group_size(plane_extent: vk::Extent3D) -> [u32; 3] {
    let max_compute_work_group_invocations = 128u32;
    let max_compute_work_group_size = [128u32, 128, 64];

    let x_work_group_size = plane_extent
        .width
        .min(max_compute_work_group_size[0])
        .min(max_compute_work_group_invocations);
    let y_work_group_size = plane_extent
        .height
        .min(max_compute_work_group_size[1])
        .min(max_compute_work_group_invocations / x_work_group_size);
    let z_work_group_size = plane_extent
        .depth
        .min(max_compute_work_group_size[2])
        .min(max_compute_work_group_invocations / (x_work_group_size * y_work_group_size));

    [x_work_group_size, y_work_group_size, z_work_group_size]
}

/// The key of the manifest entry of a case.
fn residency_key(image_type: ImageType, image_size: [u32; 3], format: vk::Format) -> String {
    format!(
        "res_{}_{}_{}_{}_{}",
        get_image_type_name(image_type),
        get_image_format_id(format),
        image_size[0],
        image_size[1],
        image_size[2]
    )
}

/// The number of channels a single plane format has.
fn channel_count(format: vk::Format) -> usize {
    let name = format!("{format:?}");
    name.split('_')
        .next()
        .unwrap_or("")
        .chars()
        .filter(|c| matches!(c, 'R' | 'G' | 'B' | 'A'))
        .count()
}

/// Formats the port registers but does not run: the YCbCr, multi-planar and `R10X6` family ones and the A8_UNORM extra format.
fn is_registered_only_format(format: vk::Format) -> bool {
    is_ycbcr_format(format) || format == vk::Format::A8_UNORM
}

struct ImageSparseResidencyCase {
    name: String,
    image_type: ImageType,
    image_size: [u32; 3],
    format: vk::Format,
}

impl TestCase for ImageSparseResidencyCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `ImageSparseResidencyCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        if self.format == vk::Format::A8_UNORM {
            context.require_device_functionality("VK_KHR_maintenance5")?;

            let mut properties3 = vk::FormatProperties3::default();
            let mut properties2 = vk::FormatProperties2::builder().push_next(&mut properties3);
            unsafe { instance.get_physical_device_format_properties2(physical_device, self.format, &mut properties2) };
            if !properties3
                .optimal_tiling_features
                .contains(vk::FormatFeatureFlags2::STORAGE_WRITE_WITHOUT_FORMAT)
            {
                return Err(TestError::NotSupported(
                    "Format does not support writes without format".to_string(),
                ));
            }
        }

        // Check if image size does not exceed device limits
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

        // Check if image format supports storage images
        let format_properties = unsafe { instance.get_physical_device_format_properties(physical_device, self.format) };
        if !format_properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::STORAGE_IMAGE)
        {
            return Err(TestError::NotSupported(
                "Storage images are not supported for this format".to_string(),
            ));
        }

        if format_is_r64(self.format) {
            context.require_device_functionality("VK_EXT_shader_image_atomic_int64")?;

            let mut atomic_int64_features = vk::PhysicalDeviceShaderImageAtomicInt64FeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut atomic_int64_features);
            unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };

            if atomic_int64_features.shader_image_int64_atomics == vk::FALSE {
                return Err(TestError::NotSupported(
                    "shaderImageInt64Atomics is not supported".to_string(),
                ));
            }

            if atomic_int64_features.sparse_image_int64_atomics == vk::FALSE {
                return Err(TestError::NotSupported(
                    "sparseImageInt64Atomics is not supported for device".to_string(),
                ));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = residency_key(self.image_type, self.image_size, self.format);
        RESIDENCY_PROGRAMS
            .iter()
            .find(|program| program.name == key)
            .map_or_else(|| BinaryCollection::new(&[]), |program| program.programs)
    }

    fn is_stub(&self) -> bool {
        is_registered_only_format(self.format)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageSparseResidencyInstance {
            context,
            image_type: self.image_type,
            image_size: self.image_size,
            format: self.format,
        })
    }
}

struct ImageSparseResidencyInstance<'a> {
    context: &'a Context<'a>,
    image_type: ImageType,
    image_size: [u32; 3],
    format: vk::Format,
}

/// The value the shader stores in `channel` of the texel at (x, y, z), as an integer and as a float.
fn reference_value(channel: usize, x: u32, y: u32, z: u32) -> (u32, f32) {
    let integer = match channel {
        0 => x % 127,
        1 => y % 127,
        2 => z % 127,
        _ => 1,
    };
    let float = if channel == 3 { 1.0 } else { integer as f32 / 127.0 };
    (integer, float)
}

impl ImageSparseResidencyInstance<'_> {
    /// One texel of the validation loops: `resident` texels hold the reference value, the others zero.
    fn texel_ok(
        &self,
        pixels: &ConstPixelBufferAccess<'_>,
        class: TextureChannelClass,
        channel: usize,
        size_bits: i32,
        (x, y, z): (u32, u32, u32),
        resident: bool,
    ) -> bool {
        let (integer_reference, float_reference) = reference_value(channel, x, y, z);
        match class {
            TextureChannelClass::SignedInteger | TextureChannelClass::UnsignedInteger => {
                let output = pixels.get_pixel_uint(x, y, z)[channel];
                output == if resident { integer_reference } else { 0 }
            }
            TextureChannelClass::UnsignedFixedPoint | TextureChannelClass::SignedFixedPoint => {
                let acceptable_error = EPSILON + compute_fixed_point_error(size_bits);
                (pixels.get_pixel(x, y, z)[channel] - if resident { float_reference } else { 0.0 }).abs()
                    <= acceptable_error
            }
            _ => (pixels.get_pixel(x, y, z)[channel] - if resident { float_reference } else { 0.0 }).abs() <= EPSILON,
        }
    }
}

impl TestInstance for ImageSparseResidencyInstance<'_> {
    /// `ImageSparseResidencyInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;

        // Create logical device supporting both sparse and compute queues
        let sparse_device = SparseDevice::new(
            context,
            &[
                QueueRequirements::new(vk::QueueFlags::SPARSE_BINDING, 1),
                QueueRequirements::new(vk::QueueFlags::COMPUTE, 1),
            ],
            false,
        )?;
        let device = sparse_device.device();

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let sparse_queue = sparse_device.get_queue(vk::QueueFlags::SPARSE_BINDING, 0);
        let compute_queue = sparse_device.get_queue(vk::QueueFlags::COMPUTE, 0);
        let format_description = format_description(self.format);
        let physical_device_properties = unsafe { instance.get_physical_device_properties(physical_device) };

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
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::STORAGE)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .build();

        if self.image_type == ImageType::Cube || self.image_type == ImageType::CubeArray {
            image_create_info.flags |= vk::ImageCreateFlags::CUBE_COMPATIBLE;
        }

        // The view format differs from the image format when writing needs another format or storage is not available for it
        let plane_compatible_format0 = format_description.planes[0].compatible_format;
        let writing_plane_compatible_format0 = get_plane_compatible_format_for_writing(self.format, 0);
        let storage_plane_compatible_format0 = get_storage_compatible_format(plane_compatible_format0);
        if writing_plane_compatible_format0 != plane_compatible_format0
            || storage_plane_compatible_format0 != plane_compatible_format0
        {
            image_create_info.flags |= vk::ImageCreateFlags::MUTABLE_FORMAT | vk::ImageCreateFlags::EXTENDED_USAGE;
        }

        // Check if device supports sparse operations for image format
        if !check_sparse_support_for_image_format(instance, physical_device, &image_create_info) {
            return Err(TestError::NotSupported(
                "The image format does not support sparse operations".to_string(),
            ));
        }

        // The registered-only formats stop here, where a device without sparse support for them (every desktop one) has already
        // reported NotSupported as upstream does.
        if is_registered_only_format(self.format) {
            return Err(TestError::NotPorted(
                "sparse residency of multi-planar, YCbCr and alpha only formats".to_string(),
            ));
        }

        // Create sparse image
        let image_sparse = Unique::new(
            device,
            unsafe { device.create_image(&image_create_info, None) }.vk_check("vkCreateImage")?,
        );

        // Create sparse image memory bind semaphore
        let image_memory_bind_semaphore = Unique::new(
            device,
            unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                .vk_check("vkCreateSemaphore")?,
        );

        let mut device_memory: Vec<Unique<'_, vk::DeviceMemory>> = Vec::new();

        // Get image general memory requirements
        let image_memory_requirements = unsafe { device.get_image_memory_requirements(*image_sparse) };

        if image_memory_requirements.size > physical_device_properties.limits.sparse_address_space_size {
            return Err(TestError::NotSupported(
                "Required memory size for sparse resource exceeds device limits".to_string(),
            ));
        }

        assert!(image_memory_requirements.size % image_memory_requirements.alignment == 0);

        let memory_type = find_matching_memory_type(
            instance,
            physical_device,
            &image_memory_requirements,
            MemoryRequirement::ANY,
        );

        if memory_type == NO_MATCH_FOUND {
            return Ok(TestStatus::fail("No matching memory type found"));
        }

        // Get sparse image sparse memory requirements
        let sparse_memory_requirements = unsafe { device.get_image_sparse_memory_requirements(*image_sparse) };
        assert!(!sparse_memory_requirements.is_empty());

        let metadata_aspect_index =
            get_sparse_aspect_requirements_index(&sparse_memory_requirements, vk::ImageAspectFlags::METADATA);

        let mut image_residency_memory_binds: Vec<vk::SparseImageMemoryBind> = Vec::new();
        let mut image_mip_tail_memory_binds: Vec<vk::SparseMemoryBind> = Vec::new();

        // Bind device memory for the color aspect
        {
            let aspect = vk::ImageAspectFlags::COLOR;
            let aspect_index = get_sparse_aspect_requirements_index(&sparse_memory_requirements, aspect);

            if aspect_index == NO_MATCH_FOUND {
                return Err(TestError::NotSupported("Not supported image aspect".to_string()));
            }

            let aspect_requirements = sparse_memory_requirements[aspect_index as usize];
            let image_granularity = aspect_requirements.format_properties.image_granularity;

            for layer_ndx in 0..image_create_info.array_layers {
                for mip_level_ndx in 0..aspect_requirements.image_mip_tail_first_lod {
                    let subresource = vk::ImageSubresource {
                        aspect_mask: aspect,
                        mip_level: mip_level_ndx,
                        array_layer: layer_ndx,
                    };
                    let plane_extent =
                        get_plane_extent(&format_description, image_create_info.extent, 0, mip_level_ndx);
                    let num_sparse_binds = aligned_divide(plane_extent, image_granularity);
                    let last_block_extent = [
                        if !plane_extent.width.is_multiple_of(image_granularity.width) {
                            plane_extent.width % image_granularity.width
                        } else {
                            image_granularity.width
                        },
                        if !plane_extent.height.is_multiple_of(image_granularity.height) {
                            plane_extent.height % image_granularity.height
                        } else {
                            image_granularity.height
                        },
                        if !plane_extent.depth.is_multiple_of(image_granularity.depth) {
                            plane_extent.depth % image_granularity.depth
                        } else {
                            image_granularity.depth
                        },
                    ];

                    for z in 0..num_sparse_binds[2] {
                        for y in 0..num_sparse_binds[1] {
                            for x in 0..num_sparse_binds[0] {
                                let linear_index = x
                                    + y * num_sparse_binds[0]
                                    + z * num_sparse_binds[0] * num_sparse_binds[1]
                                    + layer_ndx * num_sparse_binds[0] * num_sparse_binds[1] * num_sparse_binds[2];

                                if linear_index % 2 == 0 {
                                    let offset = vk::Offset3D {
                                        x: (x * image_granularity.width) as i32,
                                        y: (y * image_granularity.height) as i32,
                                        z: (z * image_granularity.depth) as i32,
                                    };

                                    let extent = vk::Extent3D {
                                        width: if x == num_sparse_binds[0] - 1 {
                                            last_block_extent[0]
                                        } else {
                                            image_granularity.width
                                        },
                                        height: if y == num_sparse_binds[1] - 1 {
                                            last_block_extent[1]
                                        } else {
                                            image_granularity.height
                                        },
                                        depth: if z == num_sparse_binds[2] - 1 {
                                            last_block_extent[2]
                                        } else {
                                            image_granularity.depth
                                        },
                                    };

                                    let image_memory_bind = make_sparse_image_memory_bind(
                                        device,
                                        image_memory_requirements.alignment,
                                        memory_type,
                                        subresource,
                                        offset,
                                        extent,
                                    )?;

                                    device_memory.push(Unique::new(device, image_memory_bind.memory));
                                    image_residency_memory_binds.push(image_memory_bind);
                                }
                            }
                        }
                    }
                }

                if !aspect_requirements
                    .format_properties
                    .flags
                    .contains(vk::SparseImageFormatFlags::SINGLE_MIPTAIL)
                    && aspect_requirements.image_mip_tail_first_lod < image_create_info.mip_levels
                {
                    let image_mip_tail_memory_bind = make_sparse_memory_bind(
                        device,
                        aspect_requirements.image_mip_tail_size,
                        memory_type,
                        aspect_requirements.image_mip_tail_offset
                            + vk::DeviceSize::from(layer_ndx) * aspect_requirements.image_mip_tail_stride,
                        vk::SparseMemoryBindFlags::empty(),
                    )?;

                    device_memory.push(Unique::new(device, image_mip_tail_memory_bind.memory));
                    image_mip_tail_memory_binds.push(image_mip_tail_memory_bind);
                }

                // Metadata
                if metadata_aspect_index != NO_MATCH_FOUND {
                    let metadata_aspect_requirements = sparse_memory_requirements[metadata_aspect_index as usize];

                    if !metadata_aspect_requirements
                        .format_properties
                        .flags
                        .contains(vk::SparseImageFormatFlags::SINGLE_MIPTAIL)
                    {
                        let image_mip_tail_memory_bind = make_sparse_memory_bind(
                            device,
                            metadata_aspect_requirements.image_mip_tail_size,
                            memory_type,
                            metadata_aspect_requirements.image_mip_tail_offset
                                + vk::DeviceSize::from(layer_ndx) * metadata_aspect_requirements.image_mip_tail_stride,
                            vk::SparseMemoryBindFlags::METADATA,
                        )?;

                        device_memory.push(Unique::new(device, image_mip_tail_memory_bind.memory));
                        image_mip_tail_memory_binds.push(image_mip_tail_memory_bind);
                    }
                }
            }

            if aspect_requirements
                .format_properties
                .flags
                .contains(vk::SparseImageFormatFlags::SINGLE_MIPTAIL)
                && aspect_requirements.image_mip_tail_first_lod < image_create_info.mip_levels
            {
                let image_mip_tail_memory_bind = make_sparse_memory_bind(
                    device,
                    aspect_requirements.image_mip_tail_size,
                    memory_type,
                    aspect_requirements.image_mip_tail_offset,
                    vk::SparseMemoryBindFlags::empty(),
                )?;

                device_memory.push(Unique::new(device, image_mip_tail_memory_bind.memory));
                image_mip_tail_memory_binds.push(image_mip_tail_memory_bind);
            }
        }

        // Metadata
        if metadata_aspect_index != NO_MATCH_FOUND {
            let metadata_aspect_requirements = sparse_memory_requirements[metadata_aspect_index as usize];

            if metadata_aspect_requirements
                .format_properties
                .flags
                .contains(vk::SparseImageFormatFlags::SINGLE_MIPTAIL)
            {
                let image_mip_tail_memory_bind = make_sparse_memory_bind(
                    device,
                    metadata_aspect_requirements.image_mip_tail_size,
                    memory_type,
                    metadata_aspect_requirements.image_mip_tail_offset,
                    vk::SparseMemoryBindFlags::METADATA,
                )?;

                device_memory.push(Unique::new(device, image_mip_tail_memory_bind.memory));
                image_mip_tail_memory_binds.push(image_mip_tail_memory_bind);
            }
        }

        {
            let signal_semaphores = [*image_memory_bind_semaphore];
            let image_residency_bind_info = [vk::SparseImageMemoryBindInfo::builder()
                .image(*image_sparse)
                .binds(&image_residency_memory_binds)
                .build()];
            let image_mip_tail_bind_info = [vk::SparseImageOpaqueMemoryBindInfo::builder()
                .image(*image_sparse)
                .binds(&image_mip_tail_memory_binds)
                .build()];

            let mut bind_sparse_info = vk::BindSparseInfo::builder().signal_semaphores(&signal_semaphores);

            if !image_residency_memory_binds.is_empty() {
                bind_sparse_info = bind_sparse_info.image_binds(&image_residency_bind_info);
            }

            if !image_mip_tail_memory_binds.is_empty() {
                bind_sparse_info = bind_sparse_info.image_opaque_binds(&image_mip_tail_bind_info);
            }

            // Submit sparse bind commands for execution
            unsafe { device.queue_bind_sparse(sparse_queue.handle, &[bind_sparse_info], vk::Fence::null()) }
                .vk_check("vkQueueBindSparse")?;
        }

        // Create command buffer for compute and transfer operations
        let command_pool = make_command_pool(device, compute_queue.family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;

        // Start recording commands
        begin_command_buffer(device, cmd)?;

        // Create descriptor set layout
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;

        // Create and bind descriptor set
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        let shader_grid_size = get_shader_grid_size(self.image_type, self.image_size, 0);

        // Run the compute shader for the only plane
        let subresource_range = make_image_subresource_range(
            vk::ImageAspectFlags::COLOR,
            0,
            1,
            0,
            get_num_layers(self.image_type, self.image_size),
        );
        let storage_view_format = storage_plane_compatible_format0;
        let shader_extent = vk::Extent3D {
            width: shader_grid_size[0],
            height: shader_grid_size[1],
            depth: shader_grid_size[2],
        };

        // Create and bind compute pipeline
        let shader_module = create_shader_module(device, context.get_binary_collection().get("comp0")?)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*shader_module)
            .name(b"main\0");
        let compute_info = vk::ComputePipelineCreateInfo::builder()
            .stage(*stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(0);
        let compute_pipelines =
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[compute_info], None) }
                .vk_check("vkCreateComputePipelines")?;
        let compute_pipeline = Unique::new(device, compute_pipelines.0[0]);
        unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *compute_pipeline) };

        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let image_view = make_image_view(
            device,
            *image_sparse,
            map_image_view_type(self.image_type),
            storage_view_format,
            subresource_range,
        )?;
        let image_sparse_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *image_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let write = vk::WriteDescriptorSet::builder()
            .dst_set(descriptor_set.get())
            .dst_binding(0)
            .dst_array_element(0)
            .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
            .image_info(&image_sparse_info);
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            )
        };

        {
            let image_sparse_layout_change_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                *image_sparse,
                subresource_range,
            );

            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_sparse_layout_change_barrier],
                );
            }
        }

        {
            let work_group_size = compute_work_group_size(shader_extent);

            let x_work_group_count = shader_extent.width.div_ceil(work_group_size[0]);
            let y_work_group_count = shader_extent.height.div_ceil(work_group_size[1]);
            let z_work_group_count = shader_extent.depth.div_ceil(work_group_size[2]);

            if MAX_COMPUTE_WORK_GROUP_COUNT < x_work_group_count
                || MAX_COMPUTE_WORK_GROUP_COUNT < y_work_group_count
                || MAX_COMPUTE_WORK_GROUP_COUNT < z_work_group_count
            {
                return Err(TestError::NotSupported("Image size is not supported".to_string()));
            }

            unsafe { device.cmd_dispatch(cmd, x_work_group_count, y_work_group_count, z_work_group_count) };
        }

        {
            let image_sparse_transfer_barrier = make_image_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                *image_sparse,
                subresource_range,
            );

            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_sparse_transfer_barrier],
                );
            }
        }

        let image_size_in_bytes = get_image_mip_level_size_in_bytes(
            image_create_info.extent,
            image_create_info.array_layers,
            self.format,
            0,
            0,
            BUFFER_IMAGE_COPY_OFFSET_GRANULARITY,
        );
        let output_buffer = BufferWithMemory::new(
            device,
            sparse_device.allocator(),
            make_buffer_create_info(
                vk::DeviceSize::from(image_size_in_bytes),
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let buffer_image_copy = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: image_create_info.array_layers,
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: get_plane_extent(&format_description, image_create_info.extent, 0, 0),
        };
        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd,
                *image_sparse,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                output_buffer.get(),
                &[buffer_image_copy],
            )
        };

        {
            let output_buffer_host_read_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                output_buffer.get(),
                0,
                vk::DeviceSize::from(image_size_in_bytes),
            );

            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[output_buffer_host_read_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        // End recording commands
        end_command_buffer(device, cmd)?;

        // The stage at which execution is going to wait for finish of sparse binding operations
        let stage_bits = [vk::PipelineStageFlags::COMPUTE_SHADER];

        // Submit commands for execution and wait for completion
        submit_commands_and_wait(
            device,
            compute_queue.handle,
            cmd,
            &[*image_memory_bind_semaphore],
            &stage_bits,
            &[],
        )?;

        // Retrieve data from buffer to host memory
        invalidate_alloc(device, output_buffer.get_allocation())?;
        let output_data = unsafe {
            std::slice::from_raw_parts(
                output_buffer.get_allocation().get_host_ptr().cast_const(),
                image_size_in_bytes as usize,
            )
        };

        // Wait for sparse queue to become idle
        unsafe { device.queue_wait_idle(sparse_queue.handle) }.vk_check("vkQueueWaitIdle")?;

        // Validate results
        let tcu_format = texture_format_of(self.format)?;
        let class = tcu_format.channel_class();
        let size_bits = (tcu_format.pixel_size().unwrap_or(1) * 8 / channel_count(self.format) as u32) as i32;
        let pixels = ConstPixelBufferAccess::new(tcu_format, shader_grid_size, output_data);
        let aspect_index =
            get_sparse_aspect_requirements_index(&sparse_memory_requirements, vk::ImageAspectFlags::COLOR);
        if aspect_index == NO_MATCH_FOUND {
            return Err(TestError::NotSupported("Not supported image aspect".to_string()));
        }
        let aspect_requirements = sparse_memory_requirements[aspect_index as usize];
        let compatible_image_granularity = aspect_requirements.format_properties.image_granularity;
        let plane_extent = get_plane_extent(&format_description, image_create_info.extent, 0, 0);

        for channel_ndx in 0..channel_count(self.format) {
            if aspect_requirements.image_mip_tail_first_lod > 0 {
                let num_sparse_binds = aligned_divide(plane_extent, compatible_image_granularity);
                let last_block_extent = [
                    if !plane_extent.width.is_multiple_of(compatible_image_granularity.width) {
                        plane_extent.width % compatible_image_granularity.width
                    } else {
                        compatible_image_granularity.width
                    },
                    if !plane_extent.height.is_multiple_of(compatible_image_granularity.height) {
                        plane_extent.height % compatible_image_granularity.height
                    } else {
                        compatible_image_granularity.height
                    },
                    if !plane_extent.depth.is_multiple_of(compatible_image_granularity.depth) {
                        plane_extent.depth % compatible_image_granularity.depth
                    } else {
                        compatible_image_granularity.depth
                    },
                ];

                for layer_ndx in 0..image_create_info.array_layers {
                    for z in 0..num_sparse_binds[2] {
                        for y in 0..num_sparse_binds[1] {
                            for x in 0..num_sparse_binds[0] {
                                let offset_width = x * compatible_image_granularity.width;
                                let offset_height = y * compatible_image_granularity.height;
                                let offset_depth = z * compatible_image_granularity.depth
                                    + layer_ndx * num_sparse_binds[2] * compatible_image_granularity.depth;

                                let extent_width = if x == num_sparse_binds[0] - 1 {
                                    last_block_extent[0]
                                } else {
                                    compatible_image_granularity.width
                                };
                                let extent_height = if y == num_sparse_binds[1] - 1 {
                                    last_block_extent[1]
                                } else {
                                    compatible_image_granularity.height
                                };
                                let extent_depth = if z == num_sparse_binds[2] - 1 {
                                    last_block_extent[2]
                                } else {
                                    compatible_image_granularity.depth
                                };

                                let linear_index = x
                                    + y * num_sparse_binds[0]
                                    + z * num_sparse_binds[0] * num_sparse_binds[1]
                                    + layer_ndx * num_sparse_binds[0] * num_sparse_binds[1] * num_sparse_binds[2];

                                let resident = linear_index % 2 == 0;
                                if !resident
                                    && physical_device_properties
                                        .sparse_properties
                                        .residency_non_resident_strict
                                        == vk::FALSE
                                {
                                    continue;
                                }

                                for offset_z in offset_depth..offset_depth + extent_depth {
                                    for offset_y in offset_height..offset_height + extent_height {
                                        for offset_x in offset_width..offset_width + extent_width {
                                            if !self.texel_ok(
                                                &pixels,
                                                class,
                                                channel_ndx,
                                                size_bits,
                                                (offset_x, offset_y, offset_z),
                                                resident,
                                            ) {
                                                return Ok(TestStatus::fail("Failed"));
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                for offset_z in 0..plane_extent.depth * image_create_info.array_layers {
                    for offset_y in 0..plane_extent.height {
                        for offset_x in 0..plane_extent.width {
                            if !self.texel_ok(
                                &pixels,
                                class,
                                channel_ndx,
                                size_bits,
                                (offset_x, offset_y, offset_z),
                                true,
                            ) {
                                return Ok(TestStatus::fail("Failed"));
                            }
                        }
                    }
                }
            }
        }

        // Keep the bound memory alive until here.
        drop(device_memory);

        Ok(TestStatus::pass("Passed"))
    }
}

/// `getSparseResidencyTestFormats` of the plain group: every test format and the A8_UNORM extra one.
fn get_test_formats_for_residency(image_type: ImageType) -> Vec<vk::Format> {
    let mut formats = get_test_formats(image_type);
    formats.push(vk::Format::A8_UNORM);
    formats
}

/// `getTestFormatsForMutableSparse` - the test formats without the r64, alpha only and YCbCr ones.
fn get_test_formats_for_mutable_sparse(image_type: ImageType) -> Vec<vk::Format> {
    get_test_formats(image_type)
        .into_iter()
        .filter(|&format| !(format_is_r64(format) || format == vk::Format::A8_UNORM || is_ycbcr_format(format)))
        .collect()
}

/// `formatsAreCompatible`
fn formats_are_compatible(format0: vk::Format, format1: vk::Format) -> bool {
    let pixel_size = |format: vk::Format| map_vk_format(format).and_then(|f| f.pixel_size());
    format0 == format1 || pixel_size(format0) == pixel_size(format1)
}

/// `createImageSparseResidencyTestsCommon`, less the device group variant; the YCbCr formats and A8_UNORM are registered and stop with NotPorted.
pub fn create_image_sparse_residency_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("image_sparse_residency");

    {
        let image_parameters = vec![
            TestImageParameters::new(
                ImageType::TwoD,
                vec![[512, 256, 1], [1024, 128, 1], [11, 137, 1]],
                get_test_formats_for_residency(ImageType::TwoD),
            ),
            TestImageParameters::new(
                ImageType::TwoDArray,
                vec![[512, 256, 6], [1024, 128, 8], [11, 137, 3]],
                get_test_formats_for_residency(ImageType::TwoDArray),
            ),
            TestImageParameters::new(
                ImageType::Cube,
                vec![[256, 256, 1], [128, 128, 1], [137, 137, 1]],
                get_test_formats_for_residency(ImageType::Cube),
            ),
            TestImageParameters::new(
                ImageType::CubeArray,
                vec![[256, 256, 6], [128, 128, 8], [137, 137, 3]],
                get_test_formats_for_residency(ImageType::CubeArray),
            ),
            TestImageParameters::new(
                ImageType::ThreeD,
                vec![[512, 256, 16], [1024, 128, 8], [11, 137, 3]],
                get_test_formats_for_residency(ImageType::ThreeD),
            ),
        ];

        for parameters in &image_parameters {
            let image_type = parameters.image_type;
            let mut image_type_group = TestCaseGroup::new(get_image_type_name(image_type));

            for &format in &parameters.formats {
                let mut format_group = TestCaseGroup::new(get_image_format_id(format));

                let image_size_alignment = get_image_size_alignment(format);

                for &image_size in &parameters.image_sizes {
                    // skip test for images with odd sizes for some YCbCr formats
                    if image_size[0] % image_size_alignment[0] != 0 {
                        continue;
                    }
                    if image_size[1] % image_size_alignment[1] != 0 {
                        continue;
                    }

                    let name = format!("{}_{}_{}", image_size[0], image_size[1], image_size[2]);
                    format_group.add_child(Box::new(ImageSparseResidencyCase {
                        name,
                        image_type,
                        image_size,
                        format,
                    }) as Box<dyn TestCase>);
                }
                image_type_group.add_child(format_group);
            }
            test_group.add_child(image_type_group);
        }
    }

    // Mutable and sparse image tests
    {
        let image_parameters = vec![
            TestImageParameters::new(
                ImageType::TwoD,
                vec![[512, 256, 1]],
                get_test_formats_for_mutable_sparse(ImageType::TwoD),
            ),
            TestImageParameters::new(
                ImageType::TwoDArray,
                vec![[512, 512, 2]],
                get_test_formats_for_mutable_sparse(ImageType::TwoDArray),
            ),
            TestImageParameters::new(
                ImageType::ThreeD,
                vec![[512, 512, 3]],
                get_test_formats_for_mutable_sparse(ImageType::ThreeD),
            ),
        ];

        let mut mutable_group = TestCaseGroup::new("mutable");

        for parameters in &image_parameters {
            let image_type = parameters.image_type;
            let mut image_type_group = TestCaseGroup::new(get_image_type_name(image_type));

            for (image_format_ndx, &image_format) in parameters.formats.iter().enumerate() {
                for (view1_format_ndx, &view1_format) in parameters.formats.iter().enumerate() {
                    for (view2_format_ndx, &view2_format) in parameters.formats.iter().enumerate() {
                        if image_format_ndx != view1_format_ndx
                            && image_format_ndx != view2_format_ndx
                            && view1_format_ndx != view2_format_ndx
                            && formats_are_compatible(image_format, view1_format)
                            && formats_are_compatible(image_format, view2_format)
                        {
                            let test_name = format!(
                                "{}_{}_{}",
                                get_format_short_string(image_format),
                                get_format_short_string(view1_format),
                                get_format_short_string(view2_format)
                            );

                            // Test with a single image size
                            let test_image_size = parameters.image_sizes[0];

                            image_type_group.add_child(Box::new(ImageMutableSparseCase {
                                name: test_name,
                                image_type,
                                image_size: test_image_size,
                                image_format,
                                view1_format,
                                view2_format,
                            }) as Box<dyn TestCase>);
                        }
                    }
                }
            }
            mutable_group.add_child(image_type_group);
        }
        test_group.add_child(mutable_group);
    }

    test_group
}
