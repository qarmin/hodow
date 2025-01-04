// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/ycbcr/vktYCbCrConversionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders of the vertex, fragment and compute executors come from `scripts/gen_shader_executor_programs.py` (the
// `ycbcr_conv_*` specs, one per sampler binding, single or array of four samplers). The bounds of the expected colours are `conversion_util::calculate_bounds`.
// The `_descriptor_heap` cases are registered and report NotPorted: the executor only has the descriptor set mode. `FAKE_COLOR_CONVERSION` and the logging of the
// source and bound images are not ported.

use std::cell::RefCell;
use std::rc::Rc;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, InstanceV1_1};

use super::conversion_util::{
    Bounds, BoundsParams, ChannelAccess, SharedPlane, calculate_bounds, channel_desc, get_channel_access,
    get_precision, get_ycbcr_bit_depth, get_ycbcr_format_channel_count, is_x_chroma_subsampled, is_y_chroma_subsampled,
    wrap,
};
use super::format_lists::{XCHROMA_SUBSAMPLED_FORMATS, XYCHROMA_SUBSAMPLED_FORMATS};
use super::image_query_tests::YcbcrConversion;
use super::util::{
    MultiPlaneImageData, allocate_and_bind_image_memory, fill_image_memory, format_description, plane_size_in_bytes,
    upload_image,
};
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::make_descriptor_set;
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::shaderexecutor::{
    ExecutorDescriptorMode, ScalarKind, ShaderSpec, ShaderType, Symbol, check_support_shader, execute,
    executor_programs,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

static SINGLE_SAMPLER_SPEC: ShaderSpec = ShaderSpec {
    inputs: &[Symbol::new("uv", ScalarKind::Float, 2)],
    outputs: &[Symbol::new("o_color", ScalarKind::Float, 4)],
};

static SAMPLER_ARRAY_SPEC: ShaderSpec = ShaderSpec {
    inputs: &[Symbol::new("uv", ScalarKind::Float, 2)],
    outputs: &[
        Symbol::new("o_color0", ScalarKind::Float, 4),
        Symbol::new("o_color1", ScalarKind::Float, 4),
        Symbol::new("o_color2", ScalarKind::Float, 4),
        Symbol::new("o_color3", ScalarKind::Float, 4),
    ],
};

/// `genTexCoords`
fn gen_tex_coords(src_size: (u32, u32), dst_size: (u32, u32)) -> Vec<[f32; 2]> {
    let mut coords = Vec::new();
    for y in 0..dst_size.1 {
        for x in 0..dst_size.0 {
            let fx = x as f32;
            let fy = y as f32;

            let fw = src_size.0 as f32;
            let fh = src_size.1 as f32;

            let s = 1.5 * ((fx * 1.5 * fw + fx) / (1.5 * fw * 1.5 * fw)) - 0.25;
            let t = 1.5 * ((fy * 1.5 * fh + fy) / (1.5 * fh * 1.5 * fh)) - 0.25;

            coords.push([s, t]);
        }
    }
    coords
}

/// `genOneToOneTexCoords`
fn gen_one_to_one_tex_coords(size: (u32, u32)) -> Vec<[f32; 2]> {
    let mut coords = Vec::new();
    for y in 0..size.1 {
        for x in 0..size.0 {
            let s = (x as f32 + 0.5) / size.0 as f32;
            let t = (y as f32 + 0.5) / size.1 as f32;

            coords.push([s, t]);
        }
    }
    coords
}

/// `TestConfig`
#[derive(Clone, Copy)]
struct TestConfig {
    shader_type: ShaderType,
    format: vk::Format,
    image_tiling: vk::ImageTiling,
    texture_filter: vk::Filter,
    address_mode_u: vk::SamplerAddressMode,
    address_mode_v: vk::SamplerAddressMode,

    chroma_filter: vk::Filter,
    x_chroma_offset: vk::ChromaLocation,
    y_chroma_offset: vk::ChromaLocation,
    explicit_reconstruction: bool,
    disjoint: bool,

    color_range: vk::SamplerYcbcrRange,
    /// `VK_SAMPLER_YCBCR_MODEL_CONVERSION_LAST` upstream: an array of samplers, one per colour model
    color_model: Option<vk::SamplerYcbcrModelConversion>,
    component_mapping: vk::ComponentMapping,
    src_size: (u32, u32),
    dst_size: (u32, u32),
    sampler_binding: u32,

    descriptor_type: ExecutorDescriptorMode,
}

impl TestConfig {
    #[allow(clippy::too_many_arguments)]
    fn new(
        shader_type: ShaderType,
        format: vk::Format,
        image_tiling: vk::ImageTiling,
        texture_filter: vk::Filter,
        chroma_filter: vk::Filter,
        x_chroma_offset: vk::ChromaLocation,
        y_chroma_offset: vk::ChromaLocation,
        explicit_reconstruction: bool,
        disjoint: bool,
        color_range: vk::SamplerYcbcrRange,
        color_model: Option<vk::SamplerYcbcrModelConversion>,
        component_mapping: vk::ComponentMapping,
        src_size: (u32, u32),
        dst_size: (u32, u32),
        sampler_binding: u32,
    ) -> Self {
        Self {
            shader_type,
            format,
            image_tiling,
            texture_filter,
            address_mode_u: vk::SamplerAddressMode::CLAMP_TO_EDGE,
            address_mode_v: vk::SamplerAddressMode::CLAMP_TO_EDGE,
            chroma_filter,
            x_chroma_offset,
            y_chroma_offset,
            explicit_reconstruction,
            disjoint,
            color_range,
            color_model,
            component_mapping,
            src_size,
            dst_size,
            sampler_binding,
            descriptor_type: ExecutorDescriptorMode::DescriptorSet,
        }
    }

    /// The `descriptorHeapConfig` of the same case: the fragment executor over a descriptor heap.
    fn with_descriptor_heap(self) -> Self {
        Self {
            shader_type: ShaderType::Fragment,
            descriptor_type: ExecutorDescriptorMode::DescriptorHeap,
            ..self
        }
    }

    fn color_models(&self) -> Vec<vk::SamplerYcbcrModelConversion> {
        match self.color_model {
            Some(model) => vec![model],
            None => vec![
                vk::SamplerYcbcrModelConversion::RGB_IDENTITY,
                vk::SamplerYcbcrModelConversion::YCBCR_IDENTITY,
                vk::SamplerYcbcrModelConversion::YCBCR_709,
                vk::SamplerYcbcrModelConversion::YCBCR_601,
            ],
        }
    }

    fn spec_key(&self) -> String {
        format!(
            "ycbcr_conv{}_b{}",
            if self.color_model.is_none() { "_array" } else { "" },
            self.sampler_binding
        )
    }
}

fn log_test_case_info(config: &TestConfig) {
    log::info!("ShaderType: {:?}", config.shader_type);
    log::info!("Format: {:?}", config.format);
    log::info!("ImageTiling: {:?}", config.image_tiling);
    log::info!("TextureFilter: {:?}", config.texture_filter);
    log::info!("AddressModeU: {:?}", config.address_mode_u);
    log::info!("AddressModeV: {:?}", config.address_mode_v);
    log::info!("ChromaFilter: {:?}", config.chroma_filter);
    log::info!("XChromaOffset: {:?}", config.x_chroma_offset);
    log::info!("YChromaOffset: {:?}", config.y_chroma_offset);
    log::info!("ExplicitReconstruction: {}", config.explicit_reconstruction);
    log::info!("Disjoint: {}", config.disjoint);
    log::info!("ColorRange: {:?}", config.color_range);
    match config.color_model {
        Some(model) => log::info!("ColorModel: {model:?}"),
        None => log::info!("ColorModel: array of samplers"),
    }
    log::info!("ComponentMapping: {:?}", config.component_mapping);
}

/// `getImageViewComponentMapping`: both mappings are equivalent, alternate between them for different formats.
fn get_image_view_component_mapping(format: vk::Format) -> vk::ComponentMapping {
    if format.as_raw() % 2 == 0 {
        vk::ComponentMapping {
            r: vk::ComponentSwizzle::IDENTITY,
            g: vk::ComponentSwizzle::IDENTITY,
            b: vk::ComponentSwizzle::IDENTITY,
            a: vk::ComponentSwizzle::IDENTITY,
        }
    } else {
        vk::ComponentMapping {
            r: vk::ComponentSwizzle::R,
            g: vk::ComponentSwizzle::G,
            b: vk::ComponentSwizzle::B,
            a: vk::ComponentSwizzle::A,
        }
    }
}

fn texture_conversion_usage() -> vk::ImageUsageFlags {
    vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED
}

fn query_sampler_ycbcr_format_properties(
    context: &Context<'_>,
    format: vk::Format,
    tiling: vk::ImageTiling,
    flags: vk::ImageCreateFlags,
) -> Result<vk::SamplerYcbcrConversionImageFormatProperties, TestError> {
    let image_format_info = vk::PhysicalDeviceImageFormatInfo2::builder()
        .format(format)
        .type_(vk::ImageType::_2D)
        .tiling(tiling)
        .usage(texture_conversion_usage())
        .flags(flags);
    let mut ycbcr_properties = vk::SamplerYcbcrConversionImageFormatProperties::default();
    let mut properties = vk::ImageFormatProperties2::builder().push_next(&mut ycbcr_properties);
    match unsafe {
        context.get_instance().get_physical_device_image_format_properties2(
            context.get_physical_device(),
            &image_format_info,
            &mut properties,
        )
    } {
        Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => {
            return Err(TestError::NotSupported("Format not supported.".to_string()));
        }
        other => {
            other.vk_check("vkGetPhysicalDeviceImageFormatProperties2")?;
        }
    }
    Ok(ycbcr_properties)
}

struct ConversionCase {
    name: String,
    config: TestConfig,
}

impl TestCase for ConversionCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let config = &self.config;

        query_sampler_ycbcr_format_properties(
            context,
            config.format,
            vk::ImageTiling::OPTIMAL,
            vk::ImageCreateFlags::empty(),
        )?;

        // Check for plane compatible format support when the disjoint flag is being used
        if config.disjoint {
            let format_description = format_description(config.format);

            for channel_ndx in 0..4 {
                let Some(channel) = channel_desc(config.format, channel_ndx) else {
                    continue;
                };
                let plane_compatible_format = format_description.planes[channel.plane as usize].compatible_format;

                match query_sampler_ycbcr_format_properties(
                    context,
                    plane_compatible_format,
                    vk::ImageTiling::OPTIMAL,
                    vk::ImageCreateFlags::empty(),
                ) {
                    Err(TestError::NotSupported(_)) => {
                        return Err(TestError::NotSupported(
                            "Plane compatibile format not supported.".to_string(),
                        ));
                    }
                    other => {
                        other?;
                    }
                }
            }
        }

        if !context.is_device_functionality_supported("VK_KHR_sampler_ycbcr_conversion") {
            return Err(TestError::NotSupported(
                "Extension VK_KHR_sampler_ycbcr_conversion not supported".to_string(),
            ));
        }

        if config.descriptor_type == ExecutorDescriptorMode::DescriptorHeap {
            context.require_device_functionality("VK_EXT_descriptor_heap")?;
        }

        {
            let mut features = vk::PhysicalDeviceSamplerYcbcrConversionFeatures::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if features.sampler_ycbcr_conversion == vk::FALSE {
                return Err(TestError::NotSupported(
                    "samplerYcbcrConversion feature is not supported".to_string(),
                ));
            }
        }

        {
            let properties = unsafe {
                context
                    .get_instance()
                    .get_physical_device_format_properties(context.get_physical_device(), config.format)
            };
            let features = if config.image_tiling == vk::ImageTiling::OPTIMAL {
                properties.optimal_tiling_features
            } else {
                properties.linear_tiling_features
            };
            let unsupported = |message: &str| Err(TestError::NotSupported(message.to_string()));

            if !features.intersects(
                vk::FormatFeatureFlags::MIDPOINT_CHROMA_SAMPLES | vk::FormatFeatureFlags::COSITED_CHROMA_SAMPLES,
            ) {
                return unsupported("Format doesn't support YCbCr conversions");
            }

            if !features.contains(vk::FormatFeatureFlags::SAMPLED_IMAGE) {
                return unsupported("Format doesn't support sampling");
            }

            if config.texture_filter == vk::Filter::LINEAR
                && !features.contains(vk::FormatFeatureFlags::SAMPLED_IMAGE_FILTER_LINEAR)
            {
                return unsupported("Format doesn't support linear texture filtering");
            }

            if config.chroma_filter == vk::Filter::LINEAR
                && !features.contains(vk::FormatFeatureFlags::SAMPLED_IMAGE_YCBCR_CONVERSION_LINEAR_FILTER)
            {
                return unsupported("Format doesn't support YCbCr linear chroma reconstruction");
            }

            if config.chroma_filter != config.texture_filter
                && !features
                    .contains(vk::FormatFeatureFlags::SAMPLED_IMAGE_YCBCR_CONVERSION_SEPARATE_RECONSTRUCTION_FILTER)
            {
                return unsupported("Format doesn't support different chroma and texture filters");
            }

            if config.explicit_reconstruction
                && !features.contains(
                    vk::FormatFeatureFlags::SAMPLED_IMAGE_YCBCR_CONVERSION_CHROMA_RECONSTRUCTION_EXPLICIT_FORCEABLE,
                )
            {
                return unsupported("Format doesn't support explicit chroma reconstruction");
            }

            if config.disjoint && !features.contains(vk::FormatFeatureFlags::DISJOINT) {
                return unsupported("Format doesn't disjoint planes");
            }

            if is_x_chroma_subsampled(config.format)
                && config.x_chroma_offset == vk::ChromaLocation::COSITED_EVEN
                && !features.contains(vk::FormatFeatureFlags::COSITED_CHROMA_SAMPLES)
            {
                return unsupported("Format doesn't support cosited chroma samples");
            }

            if is_x_chroma_subsampled(config.format)
                && config.x_chroma_offset == vk::ChromaLocation::MIDPOINT
                && !features.contains(vk::FormatFeatureFlags::MIDPOINT_CHROMA_SAMPLES)
            {
                return unsupported("Format doesn't support midpoint chroma samples");
            }

            if is_y_chroma_subsampled(config.format)
                && config.y_chroma_offset == vk::ChromaLocation::COSITED_EVEN
                && !features.contains(vk::FormatFeatureFlags::COSITED_CHROMA_SAMPLES)
            {
                return unsupported("Format doesn't support cosited chroma samples");
            }

            if is_y_chroma_subsampled(config.format)
                && config.y_chroma_offset == vk::ChromaLocation::MIDPOINT
                && !features.contains(vk::FormatFeatureFlags::MIDPOINT_CHROMA_SAMPLES)
            {
                return unsupported("Format doesn't support midpoint chroma samples");
            }
        }

        check_support_shader(context, config.shader_type)
    }

    fn programs(&self) -> BinaryCollection {
        executor_programs(&self.config.spec_key(), self.config.shader_type)
    }

    fn is_stub(&self) -> bool {
        self.config.descriptor_type == ExecutorDescriptorMode::DescriptorHeap
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ConversionInstance {
            context,
            config: self.config,
        })
    }
}

struct ConversionInstance<'a> {
    context: &'a Context<'a>,
    config: TestConfig,
}

/// `evalShader`: the colour of every `sts` for each of the colour models, sampled through the executor.
fn eval_shader(
    context: &Context<'_>,
    config: &TestConfig,
    image_data: &MultiPlaneImageData,
    color_models: &[vk::SamplerYcbcrModelConversion],
    sts: &[[f32; 2]],
) -> Result<Vec<Vec<[f32; 4]>>, TestError> {
    if config.descriptor_type == ExecutorDescriptorMode::DescriptorHeap {
        return Err(TestError::NotPorted(
            "the descriptor heap mode of the executor".to_string(),
        ));
    }

    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let format = config.format;

    let conversions = color_models
        .iter()
        .map(|&color_model| {
            let conversion_info = vk::SamplerYcbcrConversionCreateInfo {
                s_type: vk::StructureType::SAMPLER_YCBCR_CONVERSION_CREATE_INFO,
                next: std::ptr::null(),
                format,
                ycbcr_model: color_model,
                ycbcr_range: config.color_range,
                components: config.component_mapping,
                x_chroma_offset: config.x_chroma_offset,
                y_chroma_offset: config.y_chroma_offset,
                chroma_filter: config.chroma_filter,
                force_explicit_reconstruction: if config.explicit_reconstruction {
                    vk::TRUE
                } else {
                    vk::FALSE
                },
            };
            Ok(YcbcrConversion {
                device,
                handle: unsafe { device.create_sampler_ycbcr_conversion(&conversion_info, None) }
                    .vk_check("vkCreateSamplerYcbcrConversion")?,
            })
        })
        .collect::<Result<Vec<YcbcrConversion<'_>>, TestError>>()?;

    let conversion_infos: Vec<vk::SamplerYcbcrConversionInfo> = conversions
        .iter()
        .map(|conversion| vk::SamplerYcbcrConversionInfo {
            s_type: vk::StructureType::SAMPLER_YCBCR_CONVERSION_INFO,
            next: std::ptr::null(),
            conversion: conversion.handle,
        })
        .collect();

    let samplers = conversion_infos
        .iter()
        .map(|conversion_info| {
            let sampler_info = vk::SamplerCreateInfo {
                s_type: vk::StructureType::SAMPLER_CREATE_INFO,
                next: (conversion_info as *const vk::SamplerYcbcrConversionInfo).cast(),
                flags: vk::SamplerCreateFlags::empty(),
                mag_filter: config.texture_filter,
                min_filter: config.texture_filter,
                mipmap_mode: vk::SamplerMipmapMode::NEAREST,
                address_mode_u: config.address_mode_u,
                address_mode_v: config.address_mode_v,
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
            Ok(Unique::new(
                device,
                unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
            ))
        })
        .collect::<Result<Vec<Unique<'_, vk::Sampler>>, TestError>>()?;

    let create_flags = if config.disjoint {
        vk::ImageCreateFlags::DISJOINT
    } else {
        vk::ImageCreateFlags::empty()
    };
    let image_info = vk::ImageCreateInfo::builder()
        .flags(create_flags)
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: config.src_size.0,
            height: config.src_size.1,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(config.image_tiling)
        .usage(texture_conversion_usage())
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::PREINITIALIZED);
    let image = Unique::new(
        device,
        unsafe { device.create_image(&image_info, None) }.vk_check("vkCreateImage")?,
    );
    let memory_requirement = if config.image_tiling == vk::ImageTiling::OPTIMAL {
        MemoryRequirement::ANY
    } else {
        MemoryRequirement::HOST_VISIBLE
    };
    let image_memory =
        allocate_and_bind_image_memory(device, allocator, *image, format, config.disjoint, memory_requirement)?;

    let image_views = conversion_infos
        .iter()
        .map(|conversion_info| {
            let view_info = vk::ImageViewCreateInfo {
                s_type: vk::StructureType::IMAGE_VIEW_CREATE_INFO,
                next: (conversion_info as *const vk::SamplerYcbcrConversionInfo).cast(),
                flags: vk::ImageViewCreateFlags::empty(),
                image: *image,
                view_type: vk::ImageViewType::_2D,
                format,
                components: get_image_view_component_mapping(format),
                subresource_range: vk::ImageSubresourceRange {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    base_mip_level: 0,
                    level_count: 1,
                    base_array_layer: 0,
                    layer_count: 1,
                },
            };
            Ok(Unique::new(
                device,
                unsafe { device.create_image_view(&view_info, None) }.vk_check("vkCreateImageView")?,
            ))
        })
        .collect::<Result<Vec<Unique<'_, vk::ImageView>>, TestError>>()?;

    let combined_sampler_descriptor_count =
        query_sampler_ycbcr_format_properties(context, format, config.image_tiling, create_flags)?
            .combined_image_sampler_descriptor_count;

    let sampler_handles: Vec<vk::Sampler> = samplers.iter().map(|sampler| **sampler).collect();
    let layout = DescriptorSetLayoutBuilder::new()
        .add_indexed_sampler_binding(
            vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            vk::ShaderStageFlags::ALL,
            config.sampler_binding,
            &sampler_handles,
        )
        .build(device)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(
            vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            samplers.len() as u32 * combined_sampler_descriptor_count,
        )
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *layout)?;
    let image_infos: Vec<vk::DescriptorImageInfo> = samplers
        .iter()
        .zip(&image_views)
        .map(|(sampler, image_view)| vk::DescriptorImageInfo {
            sampler: **sampler,
            image_view: **image_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        })
        .collect();
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set.get())
        .dst_binding(config.sampler_binding)
        .dst_array_element(0)
        .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
        .image_info(&image_infos);
    unsafe { device.update_descriptor_sets(&[write.build()], &[] as &[vk::CopyDescriptorSet]) };

    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();
    if config.image_tiling == vk::ImageTiling::OPTIMAL {
        upload_image(
            device,
            allocator,
            queue,
            queue_family_index,
            *image,
            image_data,
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        )?;
    } else {
        fill_image_memory(
            device,
            queue,
            queue_family_index,
            *image,
            &image_memory,
            image_data,
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        )?;
    }

    let sts_bytes: Vec<u8> = sts.iter().flatten().flat_map(|value| value.to_ne_bytes()).collect();
    let mut result_bytes: Vec<Vec<u8>> = color_models.iter().map(|_| vec![0u8; sts.len() * 16]).collect();
    {
        let mut outputs: Vec<&mut [u8]> = result_bytes.iter_mut().map(|bytes| &mut bytes[..]).collect();
        execute(
            context,
            config.shader_type,
            if config.color_model.is_none() {
                &SAMPLER_ARRAY_SPEC
            } else {
                &SINGLE_SAMPLER_SPEC
            },
            Some(*layout),
            sts.len(),
            &[&sts_bytes],
            &mut outputs,
            Some(descriptor_set.get()),
        )?;
    }

    Ok(result_bytes
        .iter()
        .map(|bytes| {
            bytes
                .chunks_exact(16)
                .map(|texel| {
                    std::array::from_fn(|c| {
                        f32::from_ne_bytes([texel[4 * c], texel[4 * c + 1], texel[4 * c + 2], texel[4 * c + 3]])
                    })
                })
                .collect()
        })
        .collect())
}

fn any_less(a: [f32; 4], b: [f32; 4]) -> bool {
    (0..4).any(|c| a[c] < b[c])
}

fn any_greater(a: [f32; 4], b: [f32; 4]) -> bool {
    (0..4).any(|c| a[c] > b[c])
}

impl TestInstance for ConversionInstance<'_> {
    /// `textureConversionTest`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let config = self.config;
        let filtering_precision = get_precision(config.format);
        let conversion_precision = get_precision(config.format);
        let sub_texel_precision_bits = context.get_device_properties().limits.sub_texel_precision_bits;
        let bit_depth = get_ycbcr_bit_depth(config.format);
        let mut explicit_reconstruction = config.explicit_reconstruction;
        let src_size = config.src_size;
        let dst_size = config.dst_size;
        let mut is_ok = true;

        log_test_case_info(&config);

        query_sampler_ycbcr_format_properties(
            context,
            config.format,
            vk::ImageTiling::OPTIMAL,
            vk::ImageCreateFlags::empty(),
        )?;

        {
            let properties = unsafe {
                context
                    .get_instance()
                    .get_physical_device_format_properties(context.get_physical_device(), config.format)
            };
            let features = if config.image_tiling == vk::ImageTiling::OPTIMAL {
                properties.optimal_tiling_features
            } else {
                properties.linear_tiling_features
            };

            if features.contains(vk::FormatFeatureFlags::SAMPLED_IMAGE_YCBCR_CONVERSION_CHROMA_RECONSTRUCTION_EXPLICIT)
            {
                explicit_reconstruction = true;
            }

            log::info!("FormatFeatures: {features:?}");
        }

        let plane_info = format_description(config.format);
        let mut src = MultiPlaneImageData::new(config.format, src_size);
        let planes: Vec<SharedPlane> = (0..plane_info.planes.len())
            .map(|plane_ndx| {
                Rc::new(RefCell::new(vec![
                    0u8;
                    plane_size_in_bytes(&plane_info, src_size, plane_ndx)
                ]))
            })
            .collect();

        let access_size = [src_size.0 as i32, src_size.1 as i32, 1];
        let channel_access = |channel_ndx: usize| -> ChannelAccess {
            if channel_desc(config.format, channel_ndx).is_some() {
                get_channel_access(&planes, config.format, src_size, channel_ndx)
            } else {
                ChannelAccess::constant(access_size, if channel_ndx == 3 { !0u32 } else { 0 })
            }
        };
        let r_channel_access = channel_access(0);
        let g_channel_access = channel_access(1);
        let b_channel_access = channel_access(2);
        let a_channel_access = channel_access(3);
        let implicit_nearest_cosited = (config.chroma_filter == vk::Filter::NEAREST && !config.explicit_reconstruction)
            && (config.x_chroma_offset == vk::ChromaLocation::COSITED_EVEN
                || config.y_chroma_offset == vk::ChromaLocation::COSITED_EVEN);

        // \todo Limit values to only values that produce defined values using selected colorRange and colorModel? The verification code handles those cases already correctly.
        if channel_desc(config.format, 0).is_some() {
            let size = r_channel_access.get_size();
            for y in 0..size[1] {
                for x in 0..size[0] {
                    r_channel_access.set_channel([x, y, 0], x as f32 / size[0] as f32);
                }
            }
        }

        if channel_desc(config.format, 1).is_some() {
            let size = g_channel_access.get_size();
            for y in 0..size[1] {
                for x in 0..size[0] {
                    g_channel_access.set_channel([x, y, 0], y as f32 / size[1] as f32);
                }
            }
        }

        if channel_desc(config.format, 2).is_some() {
            let size = b_channel_access.get_size();
            for y in 0..size[1] {
                for x in 0..size[0] {
                    b_channel_access.set_channel([x, y, 0], (x + y) as f32 / (size[0] + size[1]) as f32);
                }
            }
        }

        if channel_desc(config.format, 3).is_some() {
            let size = a_channel_access.get_size();
            for y in 0..size[1] {
                for x in 0..size[0] {
                    a_channel_access.set_channel([x, y, 0], (x * y) as f32 / (size[0] * size[1]) as f32);
                }
            }
        }

        let sts = if dst_size.0 > src_size.0 && dst_size.1 > src_size.1 {
            gen_tex_coords(src_size, dst_size)
        } else {
            gen_one_to_one_tex_coords(dst_size)
        };

        let color_models = config.color_models();

        let mut min_bounds: Vec<Vec<[f32; 4]>> = Vec::new();
        let mut min_midpoint_bounds: Vec<Vec<[f32; 4]>> = Vec::new();
        let mut max_bounds: Vec<Vec<[f32; 4]>> = Vec::new();
        let mut max_midpoint_bounds: Vec<Vec<[f32; 4]>> = Vec::new();
        let mut uv_bounds: Vec<Vec<[f32; 4]>> = Vec::new();
        let mut ij_bounds: Vec<Vec<[i32; 4]>> = Vec::new();

        for &color_model in &color_models {
            let mut params = BoundsParams {
                bit_depth,
                sts: &sts,
                filtering_format: &filtering_precision,
                conversion_format: &conversion_precision,
                sub_texel_precision_bits,
                filter: config.texture_filter,
                color_model,
                range: config.color_range,
                chroma_filter: config.chroma_filter,
                x_chroma_offset: config.x_chroma_offset,
                y_chroma_offset: config.y_chroma_offset,
                component_mapping: config.component_mapping,
                explicit_reconstruction,
                address_mode_u: config.address_mode_u,
                address_mode_v: config.address_mode_v,
            };
            let bounds = calculate_bounds(
                &r_channel_access,
                &g_channel_access,
                &b_channel_access,
                &a_channel_access,
                &params,
            );

            let mut midpoint_bounds = Bounds {
                min_bounds: Vec::new(),
                max_bounds: Vec::new(),
                uv_bounds: Vec::new(),
                ij_bounds: Vec::new(),
            };
            if implicit_nearest_cosited {
                params.x_chroma_offset = vk::ChromaLocation::MIDPOINT;
                params.y_chroma_offset = vk::ChromaLocation::MIDPOINT;
                midpoint_bounds = calculate_bounds(
                    &r_channel_access,
                    &g_channel_access,
                    &b_channel_access,
                    &a_channel_access,
                    &params,
                );
            }

            min_bounds.push(bounds.min_bounds);
            min_midpoint_bounds.push(midpoint_bounds.min_bounds);
            max_bounds.push(bounds.max_bounds);
            max_midpoint_bounds.push(midpoint_bounds.max_bounds);
            uv_bounds.push(bounds.uv_bounds);
            ij_bounds.push(bounds.ij_bounds);
        }

        for (plane_ndx, plane) in planes.iter().enumerate() {
            src.plane_mut(plane_ndx).copy_from_slice(&plane.borrow());
        }

        let results = eval_shader(context, &config, &src, &color_models, &sts)?;

        let mut error_count = 0usize;

        for i in 0..color_models.len() {
            for ndx in 0..sts.len() {
                let result = results[i][ndx];
                let fail = if implicit_nearest_cosited {
                    (any_less(result, min_midpoint_bounds[i][ndx]) || any_greater(result, max_midpoint_bounds[i][ndx]))
                        && (any_less(result, min_bounds[i][ndx]) || any_greater(result, max_bounds[i][ndx]))
                } else {
                    any_less(result, min_bounds[i][ndx]) || any_greater(result, max_bounds[i][ndx])
                };

                if fail {
                    log::error!("Fail: {} {:?} {:?}", i, sts[ndx], result);
                    log::error!("  Min : {:?}", min_bounds[i][ndx]);
                    log::error!("  Max : {:?}", max_bounds[i][ndx]);
                    log::error!(
                        "  Threshold: {:?}",
                        std::array::from_fn::<f32, 4, _>(|c| max_bounds[i][ndx][c] - min_bounds[i][ndx][c])
                    );
                    log::error!("  UMin : {}", uv_bounds[i][ndx][0]);
                    log::error!("  UMax : {}", uv_bounds[i][ndx][1]);
                    log::error!("  VMin : {}", uv_bounds[i][ndx][2]);
                    log::error!("  VMax : {}", uv_bounds[i][ndx][3]);
                    log::error!("  IMin : {}", ij_bounds[i][ndx][0]);
                    log::error!("  IMax : {}", ij_bounds[i][ndx][1]);
                    log::error!("  JMin : {}", ij_bounds[i][ndx][2]);
                    log::error!("  JMax : {}", ij_bounds[i][ndx][3]);

                    let linear_extra = if config.texture_filter == vk::Filter::LINEAR {
                        1
                    } else {
                        0
                    };
                    let channels: &[(&ChannelAccess, &str)] = if is_x_chroma_subsampled(config.format) {
                        &[(&g_channel_access, "luma"), (&a_channel_access, "alpha")]
                    } else {
                        &[
                            (&r_channel_access, "r"),
                            (&g_channel_access, "g"),
                            (&b_channel_access, "b"),
                            (&a_channel_access, "a"),
                        ]
                    };
                    let size = channels[0].0.get_size();
                    for k in ij_bounds[i][ndx][2]..=ij_bounds[i][ndx][3] + linear_extra {
                        let wrapped_k = wrap(config.address_mode_v, k, size[1]);
                        let mut line = String::new();
                        for j in ij_bounds[i][ndx][0]..=ij_bounds[i][ndx][1] + linear_extra {
                            let wrapped_j = wrap(config.address_mode_u, j, size[0]);
                            let values: Vec<String> = channels
                                .iter()
                                .map(|(access, _)| format!("{:5}", access.get_channel_uint([wrapped_j, wrapped_k, 0])))
                                .collect();
                            line.push_str(&format!("({}) ", values.join(", ")));
                        }
                        log::error!("    {line}");
                    }

                    error_count += 1;
                    is_ok = false;

                    if error_count > 30 {
                        log::error!("Encountered {error_count} errors. Omitting rest of the per result logs.");
                        break;
                    }
                }
            }
        }

        if is_ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Result comparison failed"))
        }
    }
}

const NO_CHROMA_SUBSAMPLED_FORMATS: &[vk::Format] = &[
    vk::Format::R4G4B4A4_UNORM_PACK16,
    vk::Format::B4G4R4A4_UNORM_PACK16,
    vk::Format::R5G6B5_UNORM_PACK16,
    vk::Format::B5G6R5_UNORM_PACK16,
    vk::Format::R5G5B5A1_UNORM_PACK16,
    vk::Format::B5G5R5A1_UNORM_PACK16,
    vk::Format::A1R5G5B5_UNORM_PACK16,
    vk::Format::R8G8B8_UNORM,
    vk::Format::B8G8R8_UNORM,
    vk::Format::R8G8B8A8_UNORM,
    vk::Format::B8G8R8A8_UNORM,
    vk::Format::A8B8G8R8_UNORM_PACK32,
    vk::Format::A2R10G10B10_UNORM_PACK32,
    vk::Format::A2B10G10R10_UNORM_PACK32,
    vk::Format::R16G16B16_UNORM,
    vk::Format::R16G16B16A16_UNORM,
    vk::Format::R10X6_UNORM_PACK16,
    vk::Format::R10X6G10X6_UNORM_2PACK16,
    vk::Format::R10X6G10X6B10X6A10X6_UNORM_4PACK16,
    vk::Format::R12X4_UNORM_PACK16,
    vk::Format::R12X4G12X4_UNORM_2PACK16,
    vk::Format::R12X4G12X4B12X4A12X4_UNORM_4PACK16,
    vk::Format::G8_B8_R8_3PLANE_444_UNORM,
    vk::Format::G10X6_B10X6_R10X6_3PLANE_444_UNORM_3PACK16,
    vk::Format::G12X4_B12X4_R12X4_3PLANE_444_UNORM_3PACK16,
    vk::Format::G16_B16_R16_3PLANE_444_UNORM,
    vk::Format::G8_B8R8_2PLANE_444_UNORM,
    vk::Format::G10X6_B10X6R10X6_2PLANE_444_UNORM_3PACK16,
    vk::Format::G12X4_B12X4R12X4_2PLANE_444_UNORM_3PACK16,
    vk::Format::G16_B16R16_2PLANE_444_UNORM,
];

const COLOR_MODELS: &[(&str, vk::SamplerYcbcrModelConversion)] = &[
    ("rgb_identity", vk::SamplerYcbcrModelConversion::RGB_IDENTITY),
    ("ycbcr_identity", vk::SamplerYcbcrModelConversion::YCBCR_IDENTITY),
    ("ycbcr_709", vk::SamplerYcbcrModelConversion::YCBCR_709),
    ("ycbcr_601", vk::SamplerYcbcrModelConversion::YCBCR_601),
    ("ycbcr_2020", vk::SamplerYcbcrModelConversion::YCBCR_2020),
];

const COLOR_RANGES: &[(&str, vk::SamplerYcbcrRange)] = &[
    ("itu_full", vk::SamplerYcbcrRange::ITU_FULL),
    ("itu_narrow", vk::SamplerYcbcrRange::ITU_NARROW),
];

const CHROMA_LOCATIONS: &[(&str, vk::ChromaLocation)] = &[
    ("cosited", vk::ChromaLocation::COSITED_EVEN),
    ("midpoint", vk::ChromaLocation::MIDPOINT),
];

const TEXTURE_FILTERS: &[(&str, vk::Filter)] = &[("linear", vk::Filter::LINEAR), ("nearest", vk::Filter::NEAREST)];

const SHADER_TYPES: &[ShaderType] = &[ShaderType::Vertex, ShaderType::Fragment, ShaderType::Compute];

const IMAGE_TILINGS: &[(&str, vk::ImageTiling)] = &[
    ("tiling_linear", vk::ImageTiling::LINEAR),
    ("tiling_optimal", vk::ImageTiling::OPTIMAL),
];

const SAMPLER_BINDINGS: &[(&str, u32)] = &[
    ("binding_0", 0),
    ("binding_7", 7),
    ("binding_15", 15),
    ("binding_31", 31),
];

const DEFAULT_COLOR_MODEL: vk::SamplerYcbcrModelConversion = vk::SamplerYcbcrModelConversion::RGB_IDENTITY;
const DEFAULT_COLOR_RANGE: vk::SamplerYcbcrRange = vk::SamplerYcbcrRange::ITU_FULL;
const SWAPPED_CHROMA_SWIZZLE: vk::ComponentMapping = vk::ComponentMapping {
    r: vk::ComponentSwizzle::B,
    g: vk::ComponentSwizzle::IDENTITY,
    b: vk::ComponentSwizzle::R,
    a: vk::ComponentSwizzle::IDENTITY,
};

fn binding_suffix(binding: u32, name: &str) -> String {
    if binding != 0 {
        format!("_{name}")
    } else {
        String::new()
    }
}

/// `YCbCrConversionTestBuilder`: the random choices come from one generator, in the order upstream makes them.
struct ConversionTestBuilder {
    rng: Random,
    alternate: bool,
}

impl ConversionTestBuilder {
    fn new() -> Self {
        Self {
            rng: Random::new(1978765638),
            alternate: false,
        }
    }

    fn shader_type(&mut self) -> ShaderType {
        *self.rng.choose(SHADER_TYPES)
    }

    fn color_range(&mut self) -> vk::SamplerYcbcrRange {
        self.rng.choose(COLOR_RANGES).1
    }

    fn chroma_location(&mut self) -> vk::ChromaLocation {
        self.rng.choose(CHROMA_LOCATIONS).1
    }

    /// `getIdentitySwizzle`: alternate between swizzle_identity and its equivalent, both should work.
    fn identity_swizzle(&mut self) -> vk::ComponentMapping {
        let mapping_a = vk::ComponentMapping {
            r: vk::ComponentSwizzle::IDENTITY,
            g: vk::ComponentSwizzle::IDENTITY,
            b: vk::ComponentSwizzle::IDENTITY,
            a: vk::ComponentSwizzle::IDENTITY,
        };
        let mapping_b = vk::ComponentMapping {
            r: vk::ComponentSwizzle::R,
            g: vk::ComponentSwizzle::G,
            b: vk::ComponentSwizzle::B,
            a: vk::ComponentSwizzle::A,
        };
        let mapping = if self.alternate { mapping_b } else { mapping_a };
        self.alternate = !self.alternate;
        mapping
    }

    fn add(group: &mut TestCaseGroup, name: String, config: TestConfig) {
        group.add_child(Box::new(ConversionCase { name, config }) as Box<dyn TestCase>);
    }

    fn build_tests(&mut self, test_group: &mut TestCaseGroup) {
        // Test formats without chroma reconstruction
        for &format in NO_CHROMA_SUBSAMPLED_FORMATS {
            let format_name = format!("{format:?}").to_lowercase();
            let mut format_group = TestCaseGroup::new(format_name);
            let src_size = (
                if is_x_chroma_subsampled(format) { 12 } else { 7 },
                if is_y_chroma_subsampled(format) { 8 } else { 13 },
            );
            let dst_size = (src_size.0 + src_size.0 / 2, src_size.1 + src_size.1 / 2);

            for &(color_model_name, color_model) in COLOR_MODELS {
                if color_model != vk::SamplerYcbcrModelConversion::RGB_IDENTITY
                    && get_ycbcr_format_channel_count(format) < 3
                {
                    continue;
                }

                let mut color_model_group = TestCaseGroup::new(color_model_name);

                if color_model == vk::SamplerYcbcrModelConversion::RGB_IDENTITY {
                    for &(texture_filter_name, texture_filter) in TEXTURE_FILTERS {
                        for &(tiling_name, tiling) in IMAGE_TILINGS {
                            let shader_type = self.shader_type();
                            let color_range = self.color_range();
                            let chroma_location = self.chroma_location();

                            for &(binding_name, sampler_binding) in SAMPLER_BINDINGS {
                                let sampler_binding_name = binding_suffix(sampler_binding, binding_name);
                                let config = TestConfig::new(
                                    shader_type,
                                    format,
                                    tiling,
                                    texture_filter,
                                    texture_filter,
                                    chroma_location,
                                    chroma_location,
                                    false,
                                    false,
                                    color_range,
                                    Some(color_model),
                                    self.identity_swizzle(),
                                    src_size,
                                    dst_size,
                                    sampler_binding,
                                );

                                Self::add(
                                    &mut color_model_group,
                                    format!("{texture_filter_name}_{tiling_name}{sampler_binding_name}"),
                                    config,
                                );
                                Self::add(
                                    &mut color_model_group,
                                    format!(
                                        "{texture_filter_name}_{tiling_name}{sampler_binding_name}_descriptor_heap"
                                    ),
                                    config.with_descriptor_heap(),
                                );
                            }
                        }
                    }
                } else {
                    for &(color_range_name, color_range) in COLOR_RANGES {
                        // Narrow range doesn't really work with formats that have less than 8 bits
                        if color_range == vk::SamplerYcbcrRange::ITU_NARROW {
                            let bit_depth = get_ycbcr_bit_depth(format);

                            if bit_depth[0] < 8 || bit_depth[1] < 8 || bit_depth[2] < 8 {
                                continue;
                            }
                        }

                        let mut color_range_group = TestCaseGroup::new(color_range_name);

                        for &(texture_filter_name, texture_filter) in TEXTURE_FILTERS {
                            for &(tiling_name, tiling) in IMAGE_TILINGS {
                                let shader_type = self.shader_type();
                                let chroma_location = self.chroma_location();
                                for &(binding_name, sampler_binding) in SAMPLER_BINDINGS {
                                    let sampler_binding_name = binding_suffix(sampler_binding, binding_name);
                                    let config = TestConfig::new(
                                        shader_type,
                                        format,
                                        tiling,
                                        texture_filter,
                                        texture_filter,
                                        chroma_location,
                                        chroma_location,
                                        false,
                                        false,
                                        color_range,
                                        Some(color_model),
                                        self.identity_swizzle(),
                                        src_size,
                                        dst_size,
                                        sampler_binding,
                                    );

                                    Self::add(
                                        &mut color_range_group,
                                        format!("{texture_filter_name}_{tiling_name}{sampler_binding_name}"),
                                        config,
                                    );
                                }
                            }
                        }

                        color_model_group.add_child(color_range_group);
                    }
                }

                format_group.add_child(color_model_group);
            }

            // Color conversion tests for array of samplers ( noChromaSubsampledFormats )
            if get_ycbcr_format_channel_count(format) >= 3 {
                self.build_array_of_samplers_tests(format, src_size, dst_size, &mut format_group);
            }

            test_group.add_child(format_group);
        }

        // Test formats with x chroma reconstruction
        for &format in XCHROMA_SUBSAMPLED_FORMATS {
            let format_name = format!("{format:?}").to_lowercase();
            let mut format_group = TestCaseGroup::new(format_name);
            let src_size = (
                if is_x_chroma_subsampled(format) { 12 } else { 7 },
                if is_y_chroma_subsampled(format) { 8 } else { 13 },
            );
            let dst_size = (src_size.0 + src_size.0 / 2, src_size.1 + src_size.1 / 2);

            // Color conversion tests
            {
                let mut conversion_group = TestCaseGroup::new("color_conversion");

                for &(x_chroma_offset_name, x_chroma_offset) in CHROMA_LOCATIONS {
                    for &(color_model_name, color_model) in COLOR_MODELS {
                        if color_model != vk::SamplerYcbcrModelConversion::RGB_IDENTITY
                            && get_ycbcr_format_channel_count(format) < 3
                        {
                            continue;
                        }

                        if color_model == vk::SamplerYcbcrModelConversion::RGB_IDENTITY {
                            for &(tiling_name, tiling) in IMAGE_TILINGS {
                                let color_range = self.color_range();
                                let shader_type = self.shader_type();
                                let y_chroma_offset = self.chroma_location();
                                for &(binding_name, sampler_binding) in SAMPLER_BINDINGS {
                                    let sampler_binding_name = binding_suffix(sampler_binding, binding_name);
                                    let config = TestConfig::new(
                                        shader_type,
                                        format,
                                        tiling,
                                        vk::Filter::NEAREST,
                                        vk::Filter::NEAREST,
                                        x_chroma_offset,
                                        y_chroma_offset,
                                        false,
                                        false,
                                        color_range,
                                        Some(color_model),
                                        self.identity_swizzle(),
                                        src_size,
                                        dst_size,
                                        sampler_binding,
                                    );

                                    Self::add(
                                        &mut conversion_group,
                                        format!(
                                            "{color_model_name}_{tiling_name}_{x_chroma_offset_name}{sampler_binding_name}"
                                        ),
                                        config,
                                    );
                                }
                            }
                        } else {
                            for &(color_range_name, color_range) in COLOR_RANGES {
                                // Narrow range doesn't really work with formats that have less than 8 bits
                                if color_range == vk::SamplerYcbcrRange::ITU_NARROW {
                                    let bit_depth = get_ycbcr_bit_depth(format);

                                    if bit_depth[0] < 8 || bit_depth[1] < 8 || bit_depth[2] < 8 {
                                        continue;
                                    }
                                }

                                for &(tiling_name, tiling) in IMAGE_TILINGS {
                                    let shader_type = self.shader_type();
                                    let y_chroma_offset = self.chroma_location();
                                    for &(binding_name, sampler_binding) in SAMPLER_BINDINGS {
                                        let sampler_binding_name = binding_suffix(sampler_binding, binding_name);
                                        let config = TestConfig::new(
                                            shader_type,
                                            format,
                                            tiling,
                                            vk::Filter::NEAREST,
                                            vk::Filter::NEAREST,
                                            x_chroma_offset,
                                            y_chroma_offset,
                                            false,
                                            false,
                                            color_range,
                                            Some(color_model),
                                            self.identity_swizzle(),
                                            src_size,
                                            dst_size,
                                            sampler_binding,
                                        );

                                        Self::add(
                                            &mut conversion_group,
                                            format!(
                                                "{color_model_name}_{color_range_name}_{tiling_name}_{x_chroma_offset_name}{sampler_binding_name}"
                                            ),
                                            config,
                                        );
                                        Self::add(
                                            &mut conversion_group,
                                            format!(
                                                "{color_model_name}_{color_range_name}_{tiling_name}_{x_chroma_offset_name}{sampler_binding_name}_descriptor_heap"
                                            ),
                                            config.with_descriptor_heap(),
                                        );
                                    }
                                }
                            }
                        }
                    }
                }

                format_group.add_child(conversion_group);
            }

            // Color conversion tests for array of samplers ( xChromaSubsampledFormats )
            if get_ycbcr_format_channel_count(format) >= 3 {
                self.build_array_of_samplers_tests(format, src_size, dst_size, &mut format_group);
            }

            // Chroma reconstruction tests
            {
                let mut reconstruction_group = TestCaseGroup::new("chroma_reconstruction");

                for &(texture_filter_name, texture_filter) in TEXTURE_FILTERS {
                    let mut texture_filter_group = TestCaseGroup::new(texture_filter_name);

                    for explicit_reconstruction in [false, true] {
                        for disjoint in [false, true] {
                            for &(x_chroma_offset_name, x_chroma_offset) in CHROMA_LOCATIONS {
                                for &(tiling_name, tiling) in IMAGE_TILINGS {
                                    let explicit_prefix = if explicit_reconstruction {
                                        "explicit_linear_"
                                    } else {
                                        "default_linear_"
                                    };
                                    let disjoint_suffix = if disjoint { "_disjoint" } else { "" };

                                    {
                                        let shader_type = self.shader_type();
                                        let y_chroma_offset = self.chroma_location();
                                        let config = TestConfig::new(
                                            shader_type,
                                            format,
                                            tiling,
                                            texture_filter,
                                            vk::Filter::LINEAR,
                                            x_chroma_offset,
                                            y_chroma_offset,
                                            explicit_reconstruction,
                                            disjoint,
                                            DEFAULT_COLOR_RANGE,
                                            Some(DEFAULT_COLOR_MODEL),
                                            self.identity_swizzle(),
                                            src_size,
                                            dst_size,
                                            0,
                                        );

                                        Self::add(
                                            &mut texture_filter_group,
                                            format!(
                                                "{explicit_prefix}{x_chroma_offset_name}_{tiling_name}{disjoint_suffix}"
                                            ),
                                            config,
                                        );
                                    }

                                    {
                                        let shader_type = self.shader_type();
                                        let y_chroma_offset = self.chroma_location();
                                        let config = TestConfig::new(
                                            shader_type,
                                            format,
                                            tiling,
                                            texture_filter,
                                            vk::Filter::LINEAR,
                                            x_chroma_offset,
                                            y_chroma_offset,
                                            explicit_reconstruction,
                                            disjoint,
                                            DEFAULT_COLOR_RANGE,
                                            Some(DEFAULT_COLOR_MODEL),
                                            SWAPPED_CHROMA_SWIZZLE,
                                            src_size,
                                            dst_size,
                                            0,
                                        );

                                        Self::add(
                                            &mut texture_filter_group,
                                            format!(
                                                "{explicit_prefix}{x_chroma_offset_name}_{tiling_name}{disjoint_suffix}_swapped_chroma"
                                            ),
                                            config,
                                        );
                                    }

                                    if !explicit_reconstruction {
                                        {
                                            let shader_type = self.shader_type();
                                            let y_chroma_offset = self.chroma_location();
                                            let config = TestConfig::new(
                                                shader_type,
                                                format,
                                                tiling,
                                                texture_filter,
                                                vk::Filter::NEAREST,
                                                x_chroma_offset,
                                                y_chroma_offset,
                                                explicit_reconstruction,
                                                disjoint,
                                                DEFAULT_COLOR_RANGE,
                                                Some(DEFAULT_COLOR_MODEL),
                                                self.identity_swizzle(),
                                                src_size,
                                                dst_size,
                                                0,
                                            );

                                            Self::add(
                                                &mut texture_filter_group,
                                                format!(
                                                    "default_nearest_{x_chroma_offset_name}_{tiling_name}{disjoint_suffix}"
                                                ),
                                                config,
                                            );
                                        }

                                        {
                                            let shader_type = self.shader_type();
                                            let y_chroma_offset = self.chroma_location();
                                            let config = TestConfig::new(
                                                shader_type,
                                                format,
                                                tiling,
                                                texture_filter,
                                                vk::Filter::NEAREST,
                                                x_chroma_offset,
                                                y_chroma_offset,
                                                explicit_reconstruction,
                                                disjoint,
                                                DEFAULT_COLOR_RANGE,
                                                Some(DEFAULT_COLOR_MODEL),
                                                SWAPPED_CHROMA_SWIZZLE,
                                                src_size,
                                                dst_size,
                                                0,
                                            );

                                            Self::add(
                                                &mut texture_filter_group,
                                                format!(
                                                    "default_nearest_{x_chroma_offset_name}_{tiling_name}{disjoint_suffix}_swapped_chroma"
                                                ),
                                                config,
                                            );
                                        }
                                    }
                                }
                            }

                            if explicit_reconstruction {
                                self.add_explicit_nearest_cases(
                                    &mut texture_filter_group,
                                    format,
                                    texture_filter,
                                    disjoint,
                                    src_size,
                                    dst_size,
                                );
                            }
                        }
                    }

                    reconstruction_group.add_child(texture_filter_group);
                }

                format_group.add_child(reconstruction_group);
            }

            test_group.add_child(format_group);
        }

        // Test formats with xy chroma reconstruction
        for &format in XYCHROMA_SUBSAMPLED_FORMATS {
            let format_name = format!("{format:?}").to_lowercase();
            let mut format_group = TestCaseGroup::new(format_name);
            let src_size = (
                if is_x_chroma_subsampled(format) { 12 } else { 7 },
                if is_y_chroma_subsampled(format) { 8 } else { 13 },
            );
            let dst_size = (src_size.0 + src_size.0 / 2, src_size.1 + src_size.1 / 2);

            // Color conversion tests
            {
                let mut conversion_group = TestCaseGroup::new("color_conversion");

                for &(chroma_offset_name, chroma_offset) in CHROMA_LOCATIONS {
                    for &(color_model_name, color_model) in COLOR_MODELS {
                        if color_model != vk::SamplerYcbcrModelConversion::RGB_IDENTITY
                            && get_ycbcr_format_channel_count(format) < 3
                        {
                            continue;
                        }

                        if color_model == vk::SamplerYcbcrModelConversion::RGB_IDENTITY {
                            for &(tiling_name, tiling) in IMAGE_TILINGS {
                                let color_range = self.color_range();
                                let shader_type = self.shader_type();
                                for &(binding_name, sampler_binding) in SAMPLER_BINDINGS {
                                    let sampler_binding_name = binding_suffix(sampler_binding, binding_name);
                                    let config = TestConfig::new(
                                        shader_type,
                                        format,
                                        tiling,
                                        vk::Filter::NEAREST,
                                        vk::Filter::NEAREST,
                                        chroma_offset,
                                        chroma_offset,
                                        false,
                                        false,
                                        color_range,
                                        Some(color_model),
                                        self.identity_swizzle(),
                                        src_size,
                                        dst_size,
                                        sampler_binding,
                                    );

                                    Self::add(
                                        &mut conversion_group,
                                        format!(
                                            "{color_model_name}_{tiling_name}_{chroma_offset_name}{sampler_binding_name}"
                                        ),
                                        config,
                                    );
                                    Self::add(
                                        &mut conversion_group,
                                        format!(
                                            "{color_model_name}_{tiling_name}_{chroma_offset_name}{sampler_binding_name}_descriptor_heap"
                                        ),
                                        config.with_descriptor_heap(),
                                    );
                                }
                            }
                        } else {
                            for &(color_range_name, color_range) in COLOR_RANGES {
                                // Narrow range doesn't really work with formats that have less than 8 bits
                                if color_range == vk::SamplerYcbcrRange::ITU_NARROW {
                                    let bit_depth = get_ycbcr_bit_depth(format);

                                    if bit_depth[0] < 8 || bit_depth[1] < 8 || bit_depth[2] < 8 {
                                        continue;
                                    }
                                }

                                for &(tiling_name, tiling) in IMAGE_TILINGS {
                                    let shader_type = self.shader_type();
                                    for &(binding_name, sampler_binding) in SAMPLER_BINDINGS {
                                        let sampler_binding_name = binding_suffix(sampler_binding, binding_name);
                                        let config = TestConfig::new(
                                            shader_type,
                                            format,
                                            tiling,
                                            vk::Filter::NEAREST,
                                            vk::Filter::NEAREST,
                                            chroma_offset,
                                            chroma_offset,
                                            false,
                                            false,
                                            color_range,
                                            Some(color_model),
                                            self.identity_swizzle(),
                                            src_size,
                                            dst_size,
                                            sampler_binding,
                                        );

                                        Self::add(
                                            &mut conversion_group,
                                            format!(
                                                "{color_model_name}_{color_range_name}_{tiling_name}_{chroma_offset_name}{sampler_binding_name}"
                                            ),
                                            config,
                                        );
                                    }
                                }
                            }
                        }
                    }
                }

                format_group.add_child(conversion_group);
            }

            // Color conversion tests for array of samplers ( xyChromaSubsampledFormats )
            if get_ycbcr_format_channel_count(format) >= 3 {
                self.build_array_of_samplers_tests(format, src_size, dst_size, &mut format_group);
            }

            // Chroma reconstruction tests
            {
                let mut reconstruction_group = TestCaseGroup::new("chroma_reconstruction");

                for &(texture_filter_name, texture_filter) in TEXTURE_FILTERS {
                    let mut texture_filter_group = TestCaseGroup::new(texture_filter_name);

                    for explicit_reconstruction in [false, true] {
                        for disjoint in [false, true] {
                            for &(x_chroma_offset_name, x_chroma_offset) in CHROMA_LOCATIONS {
                                for &(y_chroma_offset_name, y_chroma_offset) in CHROMA_LOCATIONS {
                                    for &(tiling_name, tiling) in IMAGE_TILINGS {
                                        let explicit_prefix = if explicit_reconstruction {
                                            "explicit_linear_"
                                        } else {
                                            "default_linear_"
                                        };
                                        let disjoint_suffix = if disjoint { "_disjoint" } else { "" };

                                        {
                                            let shader_type = self.shader_type();
                                            let config = TestConfig::new(
                                                shader_type,
                                                format,
                                                tiling,
                                                texture_filter,
                                                vk::Filter::LINEAR,
                                                x_chroma_offset,
                                                y_chroma_offset,
                                                explicit_reconstruction,
                                                disjoint,
                                                DEFAULT_COLOR_RANGE,
                                                Some(DEFAULT_COLOR_MODEL),
                                                self.identity_swizzle(),
                                                src_size,
                                                dst_size,
                                                0,
                                            );

                                            Self::add(
                                                &mut texture_filter_group,
                                                format!(
                                                    "{explicit_prefix}{x_chroma_offset_name}_{y_chroma_offset_name}_{tiling_name}{disjoint_suffix}"
                                                ),
                                                config,
                                            );
                                        }

                                        {
                                            let shader_type = self.shader_type();
                                            let config = TestConfig::new(
                                                shader_type,
                                                format,
                                                tiling,
                                                texture_filter,
                                                vk::Filter::LINEAR,
                                                x_chroma_offset,
                                                y_chroma_offset,
                                                explicit_reconstruction,
                                                disjoint,
                                                DEFAULT_COLOR_RANGE,
                                                Some(DEFAULT_COLOR_MODEL),
                                                SWAPPED_CHROMA_SWIZZLE,
                                                src_size,
                                                dst_size,
                                                0,
                                            );

                                            Self::add(
                                                &mut texture_filter_group,
                                                format!(
                                                    "{explicit_prefix}{x_chroma_offset_name}_{y_chroma_offset_name}_{tiling_name}{disjoint_suffix}_swapped_chroma"
                                                ),
                                                config,
                                            );
                                        }

                                        if !explicit_reconstruction {
                                            {
                                                let shader_type = self.shader_type();
                                                let config = TestConfig::new(
                                                    shader_type,
                                                    format,
                                                    tiling,
                                                    texture_filter,
                                                    vk::Filter::NEAREST,
                                                    x_chroma_offset,
                                                    y_chroma_offset,
                                                    explicit_reconstruction,
                                                    disjoint,
                                                    DEFAULT_COLOR_RANGE,
                                                    Some(DEFAULT_COLOR_MODEL),
                                                    self.identity_swizzle(),
                                                    src_size,
                                                    dst_size,
                                                    0,
                                                );

                                                Self::add(
                                                    &mut texture_filter_group,
                                                    format!(
                                                        "default_nearest_{x_chroma_offset_name}_{y_chroma_offset_name}_{tiling_name}{disjoint_suffix}"
                                                    ),
                                                    config,
                                                );
                                            }

                                            {
                                                let shader_type = self.shader_type();
                                                let config = TestConfig::new(
                                                    shader_type,
                                                    format,
                                                    tiling,
                                                    texture_filter,
                                                    vk::Filter::NEAREST,
                                                    x_chroma_offset,
                                                    y_chroma_offset,
                                                    explicit_reconstruction,
                                                    disjoint,
                                                    DEFAULT_COLOR_RANGE,
                                                    Some(DEFAULT_COLOR_MODEL),
                                                    SWAPPED_CHROMA_SWIZZLE,
                                                    src_size,
                                                    dst_size,
                                                    0,
                                                );

                                                Self::add(
                                                    &mut texture_filter_group,
                                                    format!(
                                                        "default_nearest_{x_chroma_offset_name}_{y_chroma_offset_name}_{tiling_name}{disjoint_suffix}_swapped_chroma"
                                                    ),
                                                    config,
                                                );
                                            }
                                        }
                                    }
                                }
                            }

                            if explicit_reconstruction {
                                self.add_explicit_nearest_cases(
                                    &mut texture_filter_group,
                                    format,
                                    texture_filter,
                                    disjoint,
                                    src_size,
                                    dst_size,
                                );
                            }
                        }
                    }

                    reconstruction_group.add_child(texture_filter_group);
                }

                format_group.add_child(reconstruction_group);
            }

            test_group.add_child(format_group);
        }

        {
            let image_sizes = [(16u32, 16u32), (20, 12)];

            let mut one_to_one_group = TestCaseGroup::new("one_to_one");

            let format = vk::Format::G8_B8_R8_3PLANE_420_UNORM;
            let filter = vk::Filter::NEAREST;

            for src_size in image_sizes {
                for &(x_chroma_offset_name, x_chroma_offset) in CHROMA_LOCATIONS {
                    for &(y_chroma_offset_name, y_chroma_offset) in CHROMA_LOCATIONS {
                        for &(tiling_name, tiling) in IMAGE_TILINGS {
                            let shader_type = self.shader_type();

                            let config = TestConfig::new(
                                shader_type,
                                format,
                                tiling,
                                filter,
                                filter,
                                x_chroma_offset,
                                y_chroma_offset,
                                false,
                                false,
                                DEFAULT_COLOR_RANGE,
                                Some(DEFAULT_COLOR_MODEL),
                                self.identity_swizzle(),
                                src_size,
                                src_size,
                                0,
                            );
                            let test_name = format!(
                                "implicit_nearest_{}x{}_{tiling_name}_{x_chroma_offset_name}_{y_chroma_offset_name}",
                                src_size.0, src_size.1
                            );

                            Self::add(&mut one_to_one_group, test_name, config);
                        }
                    }
                }
            }

            test_group.add_child(one_to_one_group);
        }
    }

    /// The `if (explicitReconstruction)` tail of the chroma reconstruction loops: `explicit_nearest` with each swizzle.
    fn add_explicit_nearest_cases(
        &mut self,
        texture_filter_group: &mut TestCaseGroup,
        format: vk::Format,
        texture_filter: vk::Filter,
        disjoint: bool,
        src_size: (u32, u32),
        dst_size: (u32, u32),
    ) {
        for &(tiling_name, tiling) in IMAGE_TILINGS {
            let disjoint_suffix = if disjoint { "_disjoint" } else { "" };
            {
                let shader_type = self.shader_type();
                let chroma_location = self.chroma_location();
                let config = TestConfig::new(
                    shader_type,
                    format,
                    tiling,
                    texture_filter,
                    vk::Filter::NEAREST,
                    chroma_location,
                    chroma_location,
                    true,
                    disjoint,
                    DEFAULT_COLOR_RANGE,
                    Some(DEFAULT_COLOR_MODEL),
                    self.identity_swizzle(),
                    src_size,
                    dst_size,
                    0,
                );

                Self::add(
                    texture_filter_group,
                    format!("explicit_nearest_{tiling_name}{disjoint_suffix}"),
                    config,
                );
            }

            {
                let shader_type = self.shader_type();
                let chroma_location = self.chroma_location();
                let config = TestConfig::new(
                    shader_type,
                    format,
                    tiling,
                    texture_filter,
                    vk::Filter::NEAREST,
                    chroma_location,
                    chroma_location,
                    true,
                    disjoint,
                    DEFAULT_COLOR_RANGE,
                    Some(DEFAULT_COLOR_MODEL),
                    SWAPPED_CHROMA_SWIZZLE,
                    src_size,
                    dst_size,
                    0,
                );

                Self::add(
                    texture_filter_group,
                    format!("explicit_nearest_{tiling_name}{disjoint_suffix}_swapped_chroma"),
                    config,
                );
            }
        }
    }

    /// `buildArrayOfSamplersTests`
    fn build_array_of_samplers_tests(
        &mut self,
        format: vk::Format,
        src_size: (u32, u32),
        dst_size: (u32, u32),
        format_group: &mut TestCaseGroup,
    ) {
        let mut sampler_array_group = TestCaseGroup::new("sampler_array");

        for &(texture_filter_name, texture_filter) in TEXTURE_FILTERS {
            for &(tiling_name, tiling) in IMAGE_TILINGS {
                let shader_type = self.shader_type();
                let color_range = vk::SamplerYcbcrRange::ITU_FULL;
                let chroma_location = self.chroma_location();

                for &(binding_name, sampler_binding) in SAMPLER_BINDINGS {
                    let sampler_binding_name = binding_suffix(sampler_binding, binding_name);
                    // No colour model means an array of samplers instead of a single sampler
                    let config = TestConfig::new(
                        shader_type,
                        format,
                        tiling,
                        texture_filter,
                        texture_filter,
                        chroma_location,
                        chroma_location,
                        false,
                        false,
                        color_range,
                        None,
                        self.identity_swizzle(),
                        src_size,
                        dst_size,
                        sampler_binding,
                    );

                    Self::add(
                        &mut sampler_array_group,
                        format!("{texture_filter_name}_{tiling_name}{sampler_binding_name}"),
                        config,
                    );
                }
            }
        }
        format_group.add_child(sampler_array_group);
    }
}

/// `createConversionTests`
pub fn create_conversion_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("conversion");
    ConversionTestBuilder::new().build_tests(&mut group);
    group
}
