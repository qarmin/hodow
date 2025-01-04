// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/ycbcr/vktYCbCrFormatTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders of the six executors come from `scripts/gen_shader_executor_programs.py`. What
// `getChannelAccess` and `fillGradient` do is done by `read_channel`, `write_channel` and `fill_gradient` over the channel table of
// `format_channels.rs` (`scripts/gen_ycbcr_channels.py`); the reference value of a texel is its channel value, as the nearest sampling of
// `Texture2DView::sample` at a texel centre returns it. The `_descriptor_buffer` and `_descriptor_heap` cases are registered and report
// NotPorted: the executor only has the descriptor set mode.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, ExtDescriptorBufferExtensionDeviceCommands, Handle, InstanceV1_1};

use super::copy_tests::is_ycbcr_format;
use super::format_channels::{CHANNELS, ChannelDesc};
use super::image_query_tests::{IDENTITY, YcbcrConversion};
use super::util::{
    MultiPlaneImageData, allocate_and_bind_image_memory, check_image_support, fill_image_memory_layer,
    format_description, upload_image_layer,
};
use crate::tcu::pixel::{TextureLevel, fill_with_component_gradients2};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::make_descriptor_set;
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::shaderexecutor::{
    BufferDescriptor, ExecutorDescriptorMode, ScalarKind, ShaderSpec, ShaderType, Symbol, execute, execute_buffer,
    executor_programs, executor_supported,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `VK_YCBCR_FORMAT_FIRST` .. `VK_YCBCR_FORMAT_LAST`, then the 444 two plane formats: the order `populateFormatGroup` registers them in.
pub(super) fn ycbcr_formats() -> Vec<vk::Format> {
    let mut formats = Vec::new();
    for raw in vk::Format::G8B8G8R8_422_UNORM.as_raw()..vk::Format::G16_B16_R16_3PLANE_444_UNORM.as_raw() + 1 {
        formats.push(vk::Format::from_raw(raw));
    }
    for raw in vk::Format::G8_B8R8_2PLANE_444_UNORM.as_raw()..vk::Format::G16_B16R16_2PLANE_444_UNORM.as_raw() + 1 {
        formats.push(vk::Format::from_raw(raw));
    }
    formats
}

pub(super) fn channel_desc(format: vk::Format, channel: usize) -> Option<ChannelDesc> {
    CHANNELS
        .iter()
        .find(|(f, _)| *f == format)
        .and_then(|(_, channels)| channels[channel])
}

/// Where the value of `channel` for the texel `(x, y)` is: the plane, the byte offset in it and the description. The access of
/// `getChannelAccess` is as large as the image and divides the texel coordinates by `texDivider` to get at the shared chroma samples.
fn channel_location(
    format: vk::Format,
    size: (u32, u32),
    channel: usize,
    x: u32,
    y: u32,
) -> (usize, usize, ChannelDesc) {
    let desc = channel_desc(format, channel).expect("the format has the channel");
    let info = format_description(format);
    let plane = &info.planes[desc.plane as usize];
    let row_pitch = (size.0 / (info.block_width * plane.width_divisor) * plane.element_size) as usize;
    let div_x = (info.block_width * plane.width_divisor * desc.stride_bytes / plane.element_size).max(1);
    let div_y = (info.block_height * plane.height_divisor * desc.stride_bytes / plane.element_size).max(1);
    let offset = (desc.offset_bits / 8) as usize
        + (x / div_x) as usize * desc.stride_bytes as usize
        + (y / div_y) as usize * row_pitch;
    (desc.plane as usize, offset, desc)
}

/// The channel format of `getChannelAccessFormat` read as a normalized float.
pub(super) fn read_channel(data: &MultiPlaneImageData, channel: usize, x: u32, y: u32) -> f32 {
    let (plane, offset, desc) = channel_location(data.format(), data.size(), channel, x, y);
    let bytes = data.plane(plane);
    let word = || u32::from(u16::from_le_bytes([bytes[offset], bytes[offset + 1]]));
    match (desc.offset_bits % 8, desc.size_bits) {
        (0, 8) => bytes[offset] as f32 / 255.0,
        (0, 16) => word() as f32 / 65535.0,
        (6, 10) => ((word() >> 6) & 0x3ff) as f32 / 1023.0,
        (4, 12) => ((word() >> 4) & 0xfff) as f32 / 4095.0,
        other => panic!("no channel access format for {other:?}"),
    }
}

/// `PixelBufferAccess::setPixel` of one channel: the float is rounded to the nearest unorm value.
fn write_channel(data: &mut MultiPlaneImageData, channel: usize, x: u32, y: u32, value: f32) {
    let (plane, offset, desc) = channel_location(data.format(), data.size(), channel, x, y);
    let quantize = |max: f32| (value.clamp(0.0, 1.0) * max + 0.5).floor() as u32;
    let bytes = data.plane_mut(plane);
    match (desc.offset_bits % 8, desc.size_bits) {
        (0, 8) => bytes[offset] = quantize(255.0) as u8,
        (0, 16) => bytes[offset..offset + 2].copy_from_slice(&(quantize(65535.0) as u16).to_le_bytes()),
        (6, 10) => bytes[offset..offset + 2].copy_from_slice(&((quantize(1023.0) << 6) as u16).to_le_bytes()),
        (4, 12) => bytes[offset..offset + 2].copy_from_slice(&((quantize(4095.0) << 4) as u16).to_le_bytes()),
        other => panic!("no channel access format for {other:?}"),
    }
}

/// `fillGradient`
pub(super) fn fill_gradient(
    data: &mut MultiPlaneImageData,
    min_val: [f32; 4],
    max_val: [f32; 4],
) -> Result<(), TestError> {
    let (width, height) = data.size();
    let format = data.format();

    for channel in 0..4 {
        if channel_desc(format, channel).is_some() {
            let mut tmp_texture = TextureLevel::new(
                TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT),
                width,
                height,
                1,
            )?;
            fill_with_component_gradients2(&mut tmp_texture.get_access(), min_val, max_val);
            let tmp_access = tmp_texture.get_const_access();

            for y in 0..height {
                for x in 0..width {
                    write_channel(data, channel, x, y, tmp_access.get_pixel(x, y, 0)[channel]);
                }
            }
        }
    }
    Ok(())
}

/// `fillZero`
fn fill_zero(data: &mut MultiPlaneImageData) {
    for plane_ndx in 0..data.plane_count() {
        data.plane_mut(plane_ndx).fill(0);
    }
}

static FORMAT_SPEC: ShaderSpec = ShaderSpec {
    inputs: &[Symbol::new("texCoord", ScalarKind::Float, 2)],
    outputs: &[Symbol::new("result", ScalarKind::Float, 4)],
};

/// `TestParameters`
#[derive(Clone, Copy)]
struct TestParameters {
    format: vk::Format,
    size: (u32, u32),
    flags: vk::ImageCreateFlags,
    tiling: vk::ImageTiling,
    shader_type: ShaderType,
    use_mapped_memory: bool,
    use_array_layers: bool,
    descriptor_type: ExecutorDescriptorMode,
}

struct FormatCase {
    name: String,
    params: TestParameters,
}

impl TestCase for FormatCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        check_image_support(context, params.format, params.flags, params.tiling)?;

        if params.use_array_layers {
            context.require_device_functionality("VK_EXT_ycbcr_image_arrays")?;

            let properties = unsafe {
                context.get_instance().get_physical_device_image_format_properties(
                    context.get_physical_device(),
                    params.format,
                    vk::ImageType::_2D,
                    params.tiling,
                    vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED,
                    params.flags,
                )
            }
            .vk_check("vkGetPhysicalDeviceImageFormatProperties")?;
            if properties.max_array_layers < 2 {
                return Err(TestError::NotSupported(
                    "Image format does not support more than 1 maxArrayLayers".to_string(),
                ));
            }
        }

        if matches!(
            params.shader_type,
            ShaderType::Vertex
                | ShaderType::TessellationControl
                | ShaderType::TessellationEvaluation
                | ShaderType::Geometry
        ) && context.get_device_features().vertex_pipeline_stores_and_atomics == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "vertexPipelineStoresAndAtomics not supported".to_string(),
            ));
        }

        match params.descriptor_type {
            ExecutorDescriptorMode::DescriptorBuffer => {
                context.require_device_functionality("VK_EXT_descriptor_buffer")?
            }
            ExecutorDescriptorMode::DescriptorHeap => context.require_device_functionality("VK_EXT_descriptor_heap")?,
            ExecutorDescriptorMode::DescriptorSet => {}
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        executor_programs(
            if self.params.use_array_layers {
                "ycbcr_format_array"
            } else {
                "ycbcr_format_2d"
            },
            self.params.shader_type,
        )
    }

    fn is_stub(&self) -> bool {
        self.params.descriptor_type == ExecutorDescriptorMode::DescriptorHeap
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FormatInstance {
            context,
            params: self.params,
        })
    }
}

struct FormatInstance<'a> {
    context: &'a Context<'a>,
    params: TestParameters,
}

impl TestInstance for FormatInstance<'_> {
    /// `testFormat`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let allocator = context.get_default_allocator();

        if params.descriptor_type == ExecutorDescriptorMode::DescriptorHeap {
            return Err(TestError::NotPorted(
                "the descriptor heap mode of the executor".to_string(),
            ));
        }
        let use_descriptor_buffer = params.descriptor_type == ExecutorDescriptorMode::DescriptorBuffer;

        let format = params.format;
        let size = params.size;
        let array_layers = if params.use_array_layers { 2u32 } else { 1 };
        let array_layer = array_layers - 1;
        let mapped_memory = params.use_mapped_memory;
        let disjoint = params.flags.contains(vk::ImageCreateFlags::DISJOINT);

        // createTestImage
        let create_info = vk::ImageCreateInfo::builder()
            .flags(params.flags)
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(vk::Extent3D {
                width: size.0,
                height: size.1,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(array_layers)
            .samples(vk::SampleCountFlags::_1)
            .tiling(params.tiling)
            .usage(vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(if mapped_memory {
                vk::ImageLayout::PREINITIALIZED
            } else {
                vk::ImageLayout::UNDEFINED
            });
        let image = Unique::new(
            device,
            unsafe { device.create_image(&create_info, None) }.vk_check("vkCreateImage")?,
        );
        let allocations = allocate_and_bind_image_memory(
            device,
            allocator,
            *image,
            format,
            disjoint,
            if mapped_memory {
                MemoryRequirement::HOST_VISIBLE
            } else {
                MemoryRequirement::ANY
            },
        )?;

        let format_properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), format)
        };
        let feature_flags = if params.tiling == vk::ImageTiling::OPTIMAL {
            format_properties.optimal_tiling_features
        } else {
            format_properties.linear_tiling_features
        };

        // VUID-VkSamplerYcbcrConversionCreateInfo-xChromaOffset-01652
        if !feature_flags.contains(vk::FormatFeatureFlags::MIDPOINT_CHROMA_SAMPLES) {
            return Err(TestError::NotSupported(
                "Format does not support midpoint chroma subsampling".to_string(),
            ));
        }

        let conversion_info = vk::SamplerYcbcrConversionCreateInfo {
            s_type: vk::StructureType::SAMPLER_YCBCR_CONVERSION_CREATE_INFO,
            next: std::ptr::null(),
            format,
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
            handle: unsafe { device.create_sampler_ycbcr_conversion(&conversion_info, None) }
                .vk_check("vkCreateSamplerYcbcrConversion")?,
        };
        let sampler_conversion_info = vk::SamplerYcbcrConversionInfo {
            s_type: vk::StructureType::SAMPLER_YCBCR_CONVERSION_INFO,
            next: std::ptr::null(),
            conversion: conversion.handle,
        };

        let view_info = vk::ImageViewCreateInfo {
            s_type: vk::StructureType::IMAGE_VIEW_CREATE_INFO,
            next: (&sampler_conversion_info as *const vk::SamplerYcbcrConversionInfo).cast(),
            flags: vk::ImageViewCreateFlags::empty(),
            image: *image,
            view_type: if array_layers > 1 {
                vk::ImageViewType::_2D_ARRAY
            } else {
                vk::ImageViewType::_2D
            },
            format,
            components: IDENTITY,
            subresource_range: vk::ImageSubresourceRange {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                base_mip_level: 0,
                level_count: 1,
                base_array_layer: 0,
                layer_count: array_layers,
            },
        };
        let image_view = Unique::new(
            device,
            unsafe { device.create_image_view(&view_info, None) }.vk_check("vkCreateImageView")?,
        );

        let sampler_info = vk::SamplerCreateInfo {
            s_type: vk::StructureType::SAMPLER_CREATE_INFO,
            next: (&sampler_conversion_info as *const vk::SamplerYcbcrConversionInfo).cast(),
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

        let image_format_info = vk::PhysicalDeviceImageFormatInfo2::builder()
            .format(format)
            .type_(vk::ImageType::_2D)
            .tiling(params.tiling)
            .usage(vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED)
            .flags(params.flags);
        let mut ycbcr_properties = vk::SamplerYcbcrConversionImageFormatProperties::default();
        let mut ext_properties = vk::ImageFormatProperties2::builder().push_next(&mut ycbcr_properties);
        // Verify that a yuv image consumes at least one descriptor
        unsafe {
            context.get_instance().get_physical_device_image_format_properties2(
                context.get_physical_device(),
                &image_format_info,
                &mut ext_properties,
            )
        }
        .vk_check("vkGetPhysicalDeviceImageFormatProperties2")?;
        if ycbcr_properties.combined_image_sampler_descriptor_count < 1 {
            return Ok(TestStatus::fail("combinedImageSamplerDescriptorCount is zero"));
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
            .build_with_flags(
                device,
                if use_descriptor_buffer {
                    vk::DescriptorSetLayoutCreateFlags::DESCRIPTOR_BUFFER_EXT
                } else {
                    vk::DescriptorSetLayoutCreateFlags::empty()
                },
            )?;
        let desc_pool = DescriptorPoolBuilder::new()
            .add_type(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                ycbcr_properties.combined_image_sampler_descriptor_count,
            )
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let desc_set = if use_descriptor_buffer {
            None
        } else {
            Some(make_descriptor_set(device, *desc_pool, *desc_layout)?)
        };
        let buffer_descriptors = [BufferDescriptor {
            image_info: vk::DescriptorImageInfo {
                sampler: *sampler,
                image_view: *image_view,
                image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            },
            buffer_offset: if use_descriptor_buffer {
                unsafe { device.get_descriptor_set_layout_binding_offset_ext(*desc_layout, 0) }
            } else {
                0
            },
            combined_sampler_descriptor_count: ycbcr_properties.combined_image_sampler_descriptor_count,
        }];
        if let Some(desc_set) = &desc_set {
            // The sampler is not required to be valid: use something invalid and not NULL.
            let image_info = vk::DescriptorImageInfo {
                sampler: vk::Sampler::from_raw(0xdeadbeef),
                image_view: *image_view,
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
        }

        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let upload = |data: &MultiPlaneImageData, layer: u32| -> Result<(), TestError> {
            if mapped_memory {
                fill_image_memory_layer(
                    device,
                    queue,
                    queue_family_index,
                    *image,
                    &allocations,
                    data,
                    vk::AccessFlags::SHADER_READ,
                    vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                    layer,
                )
            } else {
                upload_image_layer(
                    device,
                    allocator,
                    queue,
                    queue_family_index,
                    *image,
                    data,
                    vk::AccessFlags::SHADER_READ,
                    vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                    layer,
                )
            }
        };

        let mut image_data = MultiPlaneImageData::new(format, size);

        // Zero fill unused layer
        if params.use_array_layers {
            fill_zero(&mut image_data);
            upload(&image_data, 0)?;
        }

        // Prepare texture data
        fill_gradient(&mut image_data, [0.0; 4], [1.0; 4])?;
        upload(&image_data, array_layer)?;

        // generateLookupCoordinates
        let mut tex_coord: Vec<[f32; 2]> = Vec::with_capacity((size.0 * size.1) as usize);
        for texel_y in 0..size.1 {
            for texel_x in 0..size.0 {
                tex_coord.push([
                    (texel_x as f32 + 0.5) / size.0 as f32,
                    (texel_y as f32 + 0.5) / size.1 as f32,
                ]);
            }
        }
        let num_values = tex_coord.len();
        let tex_coord_bytes: Vec<u8> = tex_coord
            .iter()
            .flatten()
            .flat_map(|value| value.to_ne_bytes())
            .collect();
        let mut result_bytes = vec![0u8; num_values * 16];

        if let Some(desc_set) = &desc_set {
            execute(
                context,
                params.shader_type,
                &FORMAT_SPEC,
                Some(*desc_layout),
                num_values,
                &[&tex_coord_bytes],
                &mut [&mut result_bytes[..]],
                Some(desc_set.get()),
            )?;
        } else {
            execute_buffer(
                context,
                params.shader_type,
                &FORMAT_SPEC,
                *desc_layout,
                num_values,
                &[&tex_coord_bytes],
                &mut [&mut result_bytes[..]],
                &buffer_descriptors,
            )?;
        }
        let result: Vec<[f32; 4]> = result_bytes
            .chunks_exact(16)
            .map(|texel| {
                std::array::from_fn(|c| {
                    f32::from_ne_bytes([texel[4 * c], texel[4 * c + 1], texel[4 * c + 2], texel[4 * c + 3]])
                })
            })
            .collect();

        let threshold = 0.02f32;
        let mut all_ok = true;
        for ndx in 0..num_values {
            let (texel_x, texel_y) = (ndx as u32 % size.0, ndx as u32 / size.0);
            let reference: [f32; 4] = std::array::from_fn(|channel_ndx| {
                if channel_desc(format, channel_ndx).is_some() {
                    read_channel(&image_data, channel_ndx, texel_x, texel_y)
                } else if channel_ndx == 3 {
                    1.0
                } else {
                    0.0
                }
            });

            if (0..4).any(|c| (result[ndx][c] - reference[c]).abs() >= threshold) {
                log::error!(
                    "ERROR: At {:?}: got {:?}, expected {:?}",
                    tex_coord[ndx],
                    result[ndx],
                    reference
                );
                all_ok = false;
            }
        }

        Ok(if all_ok {
            TestStatus::pass("All samples passed")
        } else {
            TestStatus::fail("Got invalid results")
        })
    }
}

/// `populatePerFormatGroup`
fn populate_per_format_group(format: vk::Format) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(format!("{format:?}").to_lowercase());
    let size = (66u32, 32u32);
    let shader_types = [
        ShaderType::Vertex,
        ShaderType::Fragment,
        ShaderType::Geometry,
        ShaderType::TessellationControl,
        ShaderType::TessellationEvaluation,
        ShaderType::Compute,
    ];
    let tilings = [
        ("optimal", vk::ImageTiling::OPTIMAL),
        ("linear", vk::ImageTiling::LINEAR),
    ];
    let descriptor_types = [
        (ExecutorDescriptorMode::DescriptorSet, ""),
        (ExecutorDescriptorMode::DescriptorBuffer, "_descriptor_buffer"),
        (ExecutorDescriptorMode::DescriptorHeap, "_descriptor_heap"),
    ];
    let plane_count = format_description(format).planes.len();

    for shader_type in shader_types {
        for (descriptor_type, descriptor_name) in descriptor_types {
            if !executor_supported(shader_type, descriptor_type) {
                continue;
            }

            for (tiling_name, tiling) in tilings {
                for use_array_layers in [false, true] {
                    let name = format!(
                        "{}_{}{}{}",
                        shader_type.case_name(),
                        tiling_name,
                        if use_array_layers { "_array" } else { "" },
                        descriptor_name
                    );
                    let mut add = |name: String, flags: vk::ImageCreateFlags, use_mapped_memory: bool| {
                        group.add_child(Box::new(FormatCase {
                            name,
                            params: TestParameters {
                                format,
                                size,
                                flags,
                                tiling,
                                shader_type,
                                use_mapped_memory,
                                use_array_layers,
                                descriptor_type,
                            },
                        }) as Box<dyn TestCase>);
                    };

                    add(name.clone(), vk::ImageCreateFlags::empty(), false);

                    if plane_count > 1 {
                        add(format!("{name}_disjoint"), vk::ImageCreateFlags::DISJOINT, false);
                    }

                    if tiling == vk::ImageTiling::LINEAR {
                        add(format!("{name}_mapped"), vk::ImageCreateFlags::empty(), true);

                        if plane_count > 1 {
                            add(format!("{name}_disjoint_mapped"), vk::ImageCreateFlags::DISJOINT, true);
                        }
                    }
                }
            }
        }
    }

    group
}

/// `createFormatTests`
pub fn create_format_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("format");
    for format in ycbcr_formats() {
        debug_assert!(is_ycbcr_format(format));
        group.add_child(populate_per_format_group(format));
    }
    group
}
