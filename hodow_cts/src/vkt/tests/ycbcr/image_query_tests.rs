// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/ycbcr/vktYCbCrImageQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders of the executors come from `scripts/gen_shader_executor_programs.py`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, InstanceV1_1};

use super::copy_tests::is_ycbcr_format;
use super::util::{allocate_and_bind_image_memory, format_description};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{Allocation, MemoryRequirement};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_descriptor_set};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::shaderexecutor::{
    ExecutorDescriptorMode, ScalarKind, ShaderSpec, ShaderType, Symbol, check_support_shader, execute,
    executor_programs, executor_supported,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `QueryType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum QueryType {
    ImageSizeLod,
    ImageLevels,
}

impl QueryType {
    fn spec_key(self) -> &'static str {
        match self {
            Self::ImageSizeLod => "ycbcr_query_size_lod",
            Self::ImageLevels => "ycbcr_query_levels",
        }
    }
}

static SIZE_LOD_SPEC: ShaderSpec = ShaderSpec {
    inputs: &[Symbol::new("lod", ScalarKind::Int, 1)],
    outputs: &[Symbol::new("result", ScalarKind::Int, 2)],
};
static LEVELS_SPEC: ShaderSpec = ShaderSpec {
    inputs: &[Symbol::new("lod", ScalarKind::Int, 1)],
    outputs: &[Symbol::new("result", ScalarKind::Int, 1)],
};

/// `getShaderSpec`
fn get_shader_spec(query: QueryType) -> &'static ShaderSpec {
    match query {
        QueryType::ImageSizeLod => &SIZE_LOD_SPEC,
        QueryType::ImageLevels => &LEVELS_SPEC,
    }
}

/// `TestParameters`
#[derive(Clone, Copy)]
struct TestParameters {
    query: QueryType,
    format: vk::Format,
    flags: vk::ImageCreateFlags,
    shader_type: ShaderType,
}

/// `Move<VkSamplerYcbcrConversion>` - `Unique` has no entry for this handle type.
pub(super) struct YcbcrConversion<'a> {
    pub(super) device: &'a Device,
    pub(super) handle: vk::SamplerYcbcrConversion,
}

impl Drop for YcbcrConversion<'_> {
    fn drop(&mut self) {
        if self.handle != vk::SamplerYcbcrConversion::null() {
            unsafe { self.device.destroy_sampler_ycbcr_conversion(self.handle, None) };
        }
    }
}

pub(super) const IDENTITY: vk::ComponentMapping = vk::ComponentMapping {
    r: vk::ComponentSwizzle::IDENTITY,
    g: vk::ComponentSwizzle::IDENTITY,
    b: vk::ComponentSwizzle::IDENTITY,
    a: vk::ComponentSwizzle::IDENTITY,
};

/// `TestImage`
struct TestImage<'a> {
    size: (u32, u32),
    // Declared in the order they have to be dropped: the view, then the image, then its memory.
    image_view: Unique<'a, vk::ImageView>,
    _image: Unique<'a, vk::Image>,
    _allocations: Vec<Allocation<'a>>,
}

impl<'a> TestImage<'a> {
    fn new(
        context: &'a Context<'a>,
        format: vk::Format,
        size: (u32, u32),
        create_flags: vk::ImageCreateFlags,
        conversion: vk::SamplerYcbcrConversion,
    ) -> Result<Self, TestError> {
        let device = context.get_device();

        let create_info = vk::ImageCreateInfo::builder()
            .flags(create_flags)
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(vk::Extent3D {
                width: size.0,
                height: size.1,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED);
        let image = Unique::new(
            device,
            unsafe { device.create_image(&create_info, None) }.vk_check("vkCreateImage")?,
        );
        let allocations = allocate_and_bind_image_memory(
            device,
            context.get_default_allocator(),
            *image,
            format,
            create_flags.contains(vk::ImageCreateFlags::DISJOINT),
            MemoryRequirement::ANY,
        )?;

        let sampler_conversion_info = vk::SamplerYcbcrConversionInfo {
            s_type: vk::StructureType::SAMPLER_YCBCR_CONVERSION_INFO,
            next: std::ptr::null(),
            conversion,
        };
        let view_info = vk::ImageViewCreateInfo {
            s_type: vk::StructureType::IMAGE_VIEW_CREATE_INFO,
            next: if conversion != vk::SamplerYcbcrConversion::null() {
                (&sampler_conversion_info as *const vk::SamplerYcbcrConversionInfo).cast()
            } else {
                std::ptr::null()
            },
            flags: vk::ImageViewCreateFlags::empty(),
            image: *image,
            view_type: vk::ImageViewType::_2D,
            format,
            components: IDENTITY,
            subresource_range: make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        };
        let image_view = Unique::new(
            device,
            unsafe { device.create_image_view(&view_info, None) }.vk_check("vkCreateImageView")?,
        );

        // Transition image layout
        {
            let queue_family_index = context.get_universal_queue_family_index();
            let cmd_pool = make_command_pool(device, queue_family_index)?;
            let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd = *cmd_buffer;

            begin_command_buffer(device, cmd)?;
            let image_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                *image,
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_barrier],
                );
            }
            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;
        }

        Ok(Self {
            size,
            _image: image,
            _allocations: allocations,
            image_view,
        })
    }
}

/// `getMaxPlaneDivisor`
fn get_max_plane_divisor(format: vk::Format) -> (u32, u32) {
    let info = format_description(format);
    let mut max_divisor = (info.block_width, info.block_height);
    for plane in info.planes {
        max_divisor.0 = max_divisor.0.max(plane.width_divisor);
        max_divisor.1 = max_divisor.1.max(plane.height_divisor);
    }
    max_divisor
}

struct ImageQueryCase {
    name: String,
    params: TestParameters,
}

impl TestCase for ImageQueryCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;

        if is_ycbcr_format(params.format) {
            super::util::check_image_support(context, params.format, params.flags, vk::ImageTiling::OPTIMAL)?;

            let mut format_properties = vk::FormatProperties2::default();
            unsafe {
                context.get_instance().get_physical_device_format_properties2(
                    context.get_physical_device(),
                    params.format,
                    &mut format_properties,
                )
            };
            // VUID-VkSamplerYcbcrConversionCreateInfo-xChromaOffset-01652
            if !format_properties
                .format_properties
                .optimal_tiling_features
                .contains(vk::FormatFeatureFlags::MIDPOINT_CHROMA_SAMPLES)
            {
                return Err(TestError::NotSupported(
                    "Format does not support midpoint chroma subsampling".to_string(),
                ));
            }
        }

        check_support_shader(context, params.shader_type)
    }

    fn programs(&self) -> BinaryCollection {
        executor_programs(self.params.query.spec_key(), self.params.shader_type)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageQueryInstance {
            context,
            params: self.params,
        })
    }
}

struct ImageQueryInstance<'a> {
    context: &'a Context<'a>,
    params: TestParameters,
}

impl TestInstance for ImageQueryInstance<'_> {
    /// `testImageQuery`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let is_ycbcr_image = is_ycbcr_format(params.format);
        let instance = context.get_instance();
        let device = context.get_device();

        let conversion_info = vk::SamplerYcbcrConversionCreateInfo {
            s_type: vk::StructureType::SAMPLER_YCBCR_CONVERSION_CREATE_INFO,
            next: std::ptr::null(),
            format: params.format,
            ycbcr_model: vk::SamplerYcbcrModelConversion::RGB_IDENTITY,
            ycbcr_range: vk::SamplerYcbcrRange::ITU_FULL,
            components: IDENTITY,
            x_chroma_offset: vk::ChromaLocation::MIDPOINT,
            y_chroma_offset: vk::ChromaLocation::MIDPOINT,
            chroma_filter: vk::Filter::NEAREST,
            force_explicit_reconstruction: vk::FALSE,
        };
        let conversion = YcbcrConversion {
            device,
            handle: if is_ycbcr_image {
                unsafe { device.create_sampler_ycbcr_conversion(&conversion_info, None) }
                    .vk_check("vkCreateSamplerYcbcrConversion")?
            } else {
                vk::SamplerYcbcrConversion::null()
            },
        };

        let sampler_conversion_info = vk::SamplerYcbcrConversionInfo {
            s_type: vk::StructureType::SAMPLER_YCBCR_CONVERSION_INFO,
            next: std::ptr::null(),
            conversion: conversion.handle,
        };

        let sampler_info = vk::SamplerCreateInfo {
            s_type: vk::StructureType::SAMPLER_CREATE_INFO,
            next: if is_ycbcr_image {
                (&sampler_conversion_info as *const vk::SamplerYcbcrConversionInfo).cast()
            } else {
                std::ptr::null()
            },
            flags: vk::SamplerCreateFlags::empty(),
            mag_filter: vk::Filter::NEAREST,
            min_filter: vk::Filter::NEAREST,
            mipmap_mode: vk::SamplerMipmapMode::NEAREST,
            address_mode_u: vk::SamplerAddressMode::CLAMP_TO_EDGE,
            address_mode_v: vk::SamplerAddressMode::CLAMP_TO_EDGE,
            address_mode_w: vk::SamplerAddressMode::CLAMP_TO_EDGE,
            mip_lod_bias: 0.0,
            anisotropy_enable: vk::FALSE,
            max_anisotropy: 1.0,
            compare_enable: vk::FALSE,
            compare_op: vk::CompareOp::ALWAYS,
            min_lod: 0.0,
            max_lod: 0.0,
            border_color: vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
            unnormalized_coordinates: vk::FALSE,
        };

        let mut combined_sampler_descriptor_count = 1;
        if is_ycbcr_image {
            let image_format_info = vk::PhysicalDeviceImageFormatInfo2::builder()
                .format(params.format)
                .type_(vk::ImageType::_2D)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED)
                .flags(params.flags);
            let mut sampler_ycbcr_conversion_image = vk::SamplerYcbcrConversionImageFormatProperties::default();
            let mut image_format_properties =
                vk::ImageFormatProperties2::builder().push_next(&mut sampler_ycbcr_conversion_image);
            unsafe {
                instance.get_physical_device_image_format_properties2(
                    context.get_physical_device(),
                    &image_format_info,
                    &mut image_format_properties,
                )
            }
            .vk_check("vkGetPhysicalDeviceImageFormatProperties2")?;
            combined_sampler_descriptor_count = sampler_ycbcr_conversion_image.combined_image_sampler_descriptor_count;
        }

        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );
        let desc_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_sampler_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::ALL,
                0,
                &[*sampler],
            )
            .build(device)?;
        let desc_pool = DescriptorPoolBuilder::new()
            .add_type(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                combined_sampler_descriptor_count,
            )
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let desc_set = make_descriptor_set(device, *desc_pool, *desc_layout)?;

        let mut test_images = Vec::new();
        if params.query == QueryType::ImageSizeLod {
            let max_divisor = get_max_plane_divisor(params.format);
            let test_sizes = [
                max_divisor,
                (max_divisor.0 * 2, max_divisor.1),
                (max_divisor.0, max_divisor.1 * 2),
                (max_divisor.0 * 63, max_divisor.1 * 79),
                (max_divisor.0 * 99, max_divisor.1),
                (max_divisor.0 * 421, max_divisor.1 * 1117),
            ];
            for size in test_sizes {
                test_images.push(TestImage::new(
                    context,
                    params.format,
                    size,
                    params.flags,
                    conversion.handle,
                )?);
            }
        } else {
            test_images.push(TestImage::new(
                context,
                params.format,
                (16, 18),
                params.flags,
                conversion.handle,
            )?);
        }

        let mut all_ok = true;
        for (image_ndx, test_image) in test_images.iter().enumerate() {
            let lod = 0u32;
            let mut result = [!0u32, !0u32];

            // bindImage
            let image_info = vk::DescriptorImageInfo {
                sampler: *sampler,
                image_view: *test_image.image_view,
                image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            };
            let descriptor_write = vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: desc_set.get(),
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                image_info: &image_info,
                buffer_info: std::ptr::null(),
                texel_buffer_view: std::ptr::null(),
            };
            unsafe { device.update_descriptor_sets(&[descriptor_write], &[] as &[vk::CopyDescriptorSet]) };

            {
                let lod_bytes = lod.to_ne_bytes();
                let mut result_bytes = [0u8; 8];
                for (dst, src) in result_bytes
                    .iter_mut()
                    .zip(result.iter().flat_map(|value| value.to_ne_bytes()))
                {
                    *dst = src;
                }
                execute(
                    context,
                    params.shader_type,
                    get_shader_spec(params.query),
                    Some(*desc_layout),
                    1,
                    &[&lod_bytes],
                    &mut [&mut result_bytes[..]],
                    Some(desc_set.get()),
                )?;
                for (value, bytes) in result.iter_mut().zip(result_bytes.chunks_exact(4)) {
                    *value = u32::from_ne_bytes([bytes[0], bytes[1], bytes[2], bytes[3]]);
                }
            }

            match params.query {
                QueryType::ImageSizeLod => {
                    let reference = [test_image.size.0, test_image.size.1];
                    if result != reference {
                        log::error!("ERROR: Image {image_ndx}: got {result:?}, expected {reference:?}");
                        all_ok = false;
                    }
                }
                QueryType::ImageLevels => {
                    if result[0] != 1 {
                        log::error!("ERROR: Image {image_ndx}: got {}, expected 1", result[0]);
                        all_ok = false;
                    }
                }
            }
        }

        if all_ok {
            Ok(TestStatus::pass("Queries passed"))
        } else {
            Ok(TestStatus::fail("Got invalid results"))
        }
    }
}

/// The formats `populateQueryInShaderGroup` registers, in its order, each with whether it also gets a disjoint case.
fn query_formats() -> Vec<vk::Format> {
    let mut formats = vec![vk::Format::R8G8B8A8_UNORM];
    // VK_YCBCR_FORMAT_FIRST .. VK_YCBCR_FORMAT_LAST
    for raw in vk::Format::G8B8G8R8_422_UNORM.as_raw()..vk::Format::G16_B16_R16_3PLANE_444_UNORM.as_raw() + 1 {
        formats.push(vk::Format::from_raw(raw));
    }
    for raw in vk::Format::G8_B8R8_2PLANE_444_UNORM.as_raw()..vk::Format::G16_B16R16_2PLANE_444_UNORM.as_raw() + 1 {
        formats.push(vk::Format::from_raw(raw));
    }
    formats
}

/// `populateQueryInShaderGroup`
fn populate_query_in_shader_group(query: QueryType, shader_type: ShaderType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(shader_type.case_name());

    for format in query_formats() {
        let name = format!("{format:?}").to_lowercase();
        let mut add_case = |name: String, flags: vk::ImageCreateFlags| {
            group.add_child(Box::new(ImageQueryCase {
                name,
                params: TestParameters {
                    query,
                    format,
                    flags,
                    shader_type,
                },
            }) as Box<dyn TestCase>);
        };

        add_case(name.clone(), vk::ImageCreateFlags::empty());
        if format_description(format).planes.len() > 1 {
            add_case(format!("{name}_disjoint"), vk::ImageCreateFlags::DISJOINT);
        }
    }

    group
}

/// `populateQueryGroup`
fn populate_query_group(name: &str, query: QueryType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);

    for shader_type in ShaderType::ALL {
        if !executor_supported(shader_type, ExecutorDescriptorMode::DescriptorSet) {
            continue;
        }
        group.add_child(populate_query_in_shader_group(query, shader_type));
    }

    group
}

/// `createImageQueryTests`
pub fn create_image_query_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("query");
    group.add_child(populate_query_group("size_lod", QueryType::ImageSizeLod));
    group.add_child(populate_query_group("levels", QueryType::ImageLevels));
    group
}
