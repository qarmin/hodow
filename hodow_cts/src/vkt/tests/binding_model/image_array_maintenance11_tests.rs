// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/binding_model/vktBindingImageArrayMaintenance11Tests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2026 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The compute shader depends on the descriptor kind, the integer class and
// storage qualifier of the format, the image dimension, whether the shader's descriptor is an array, the sampled lod and
// whether the storage image is stored to; shaders/manifest/binding_model_image_array_maintenance11.toml holds one program per
// combination and `program_key` names it. vulkanalia has no VK_KHR_maintenance11, so the image create flag
// VK_IMAGE_CREATE_ALIAS_SINGLE_LAYER_DESCRIPTOR_BIT_KHR is the raw bit 22. `getFormatMinIntValue` is `-max - 1`.
//
// Tests that a view of one layer of a (1D or 2D) image can be used through a descriptor of the opposite arrayness: an array
// descriptor over a non-arrayed view and a non-arrayed descriptor over an arrayed one.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::binding_model_image_array_maintenance11::ALL_IMAGE_ARRAY_PROGRAM;
use crate::tcu::image_compare::{float_threshold_compare, int_threshold_compare};
use crate::tcu::pixel::{
    ConstPixelBufferAccess, TextureLevel, get_format_max_int_value, get_format_max_uint_value,
    get_texture_format_bit_depth,
};
use crate::tcu::random::Random;
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureChannelClass, TextureFormat, map_vk_format};
use crate::tcu::{TestError, TestOutcome, TestStatus, UVec4};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The `rust_type` of the manifest entries.
#[derive(Clone, Copy)]
pub struct ImageArrayProgram {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

/// `VK_IMAGE_CREATE_ALIAS_SINGLE_LAYER_DESCRIPTOR_BIT_KHR`
const ALIAS_SINGLE_LAYER_DESCRIPTOR: u32 = 0x0040_0000;

#[derive(Clone, Copy)]
struct TestParams {
    image_format: vk::Format,
    /// 1D or 2D.
    image_type: vk::ImageType,
    /// 1D or 2D or array of them.
    view_type: vk::ImageViewType,
    /// Sampled or storage image.
    descriptor_type: vk::DescriptorType,
    /// Layer used to create the view.
    layer: u32,
    /// Lod level (only for sampled images).
    lod: u32,
    /// Store data in the image instead of reading from it (for storage images).
    store: bool,
}

impl TestParams {
    fn seed(&self) -> u32 {
        // MSB | Byte 3: format (8 bits: bits 24-31)
        //     | Byte 2: lod (7 bits: 17-23) store (bit 16)
        //     | Byte 1: image type (2 bits: 14-15) view type (3 bits: 11-13) desc type (4 bits: 8-11)
        // LSB | Byte 0: <empty>
        ((self.image_format.as_raw() as u32 & 0xFF) << 24)
            | ((self.lod & 0x3F) << 17)
            | (u32::from(self.store) << 16)
            | ((self.image_type.as_raw() as u32 & 0x3) << 14)
            | ((self.view_type.as_raw() as u32 & 0x7) << 11)
            | ((self.descriptor_type.as_raw() as u32 & 0xF) << 8)
    }

    fn tiling(&self) -> vk::ImageTiling {
        vk::ImageTiling::OPTIMAL
    }

    fn image_usage(&self) -> vk::ImageUsageFlags {
        let mut usage = vk::ImageUsageFlags::empty();

        if self.descriptor_type == vk::DescriptorType::COMBINED_IMAGE_SAMPLER {
            usage |= vk::ImageUsageFlags::SAMPLED;
        } else {
            usage |= vk::ImageUsageFlags::STORAGE;
        }

        if self.store {
            usage |= vk::ImageUsageFlags::TRANSFER_SRC;
        } else {
            usage |= vk::ImageUsageFlags::TRANSFER_DST;
        }

        usage
    }

    fn mip_level_extent(&self) -> vk::Extent3D {
        if self.image_type == vk::ImageType::_1D {
            vk::Extent3D {
                width: 4096,
                height: 1,
                depth: 1,
            }
        } else {
            vk::Extent3D {
                width: 64,
                height: 64,
                depth: 1,
            }
        }
    }

    fn mip_level_count(&self) -> u32 {
        self.lod + 1
    }

    fn creation_extent(&self) -> vk::Extent3D {
        let multiplier = 1u32 << self.lod;
        let mut extent = self.mip_level_extent();
        extent.width *= multiplier;
        if self.image_type == vk::ImageType::_2D {
            extent.height *= multiplier;
        }
        extent
    }

    fn layer_count(&self) -> u32 {
        self.layer + 1
    }

    fn work_group_size(&self) -> u32 {
        64
    }

    fn image_layout_shader(&self) -> vk::ImageLayout {
        if self.descriptor_type == vk::DescriptorType::COMBINED_IMAGE_SAMPLER {
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
        } else {
            vk::ImageLayout::GENERAL
        }
    }

    /// The shader declares an array descriptor exactly when the view is not an arrayed one.
    fn array_in_shader(&self) -> bool {
        self.view_type == vk::ImageViewType::_1D || self.view_type == vk::ImageViewType::_2D
    }

    /// The name of the manifest entry holding the shader of this case.
    fn program_key(&self) -> String {
        let dim = if self.image_type == vk::ImageType::_1D {
            "1d"
        } else {
            "2d"
        };
        let arr = if self.array_in_shader() { "_array" } else { "" };
        if self.descriptor_type == vk::DescriptorType::STORAGE_IMAGE {
            format!(
                "storage_{}_{dim}{arr}_{}",
                format_simple_name(self.image_format),
                if self.store { "store" } else { "load" }
            )
        } else {
            let prefix = match map_vk_format(self.image_format).map(|format| format.channel_class()) {
                Some(TextureChannelClass::SignedInteger) => "i",
                Some(TextureChannelClass::UnsignedInteger) => "u",
                _ => "f",
            };
            format!("sampler_{prefix}_{dim}{arr}_lod{}", self.lod)
        }
    }
}

/// `getFormatSimpleName` for the formats of the test.
fn format_simple_name(format: vk::Format) -> &'static str {
    match format {
        vk::Format::R8_UNORM => "r8_unorm",
        vk::Format::R8_UINT => "r8_uint",
        vk::Format::R8_SINT => "r8_sint",
        vk::Format::R8G8_UNORM => "r8g8_unorm",
        vk::Format::R8G8_UINT => "r8g8_uint",
        vk::Format::R8G8_SINT => "r8g8_sint",
        vk::Format::R8G8B8A8_UNORM => "r8g8b8a8_unorm",
        vk::Format::R8G8B8A8_UINT => "r8g8b8a8_uint",
        vk::Format::R8G8B8A8_SINT => "r8g8b8a8_sint",
        vk::Format::R16_UNORM => "r16_unorm",
        vk::Format::R16_UINT => "r16_uint",
        vk::Format::R16_SINT => "r16_sint",
        vk::Format::R16G16_UNORM => "r16g16_unorm",
        vk::Format::R16G16_UINT => "r16g16_uint",
        vk::Format::R16G16_SINT => "r16g16_sint",
        vk::Format::R16G16B16A16_UNORM => "r16g16b16a16_unorm",
        vk::Format::R16G16B16A16_UINT => "r16g16b16a16_uint",
        vk::Format::R16G16B16A16_SINT => "r16g16b16a16_sint",
        vk::Format::R32_SFLOAT => "r32_sfloat",
        vk::Format::R32_UINT => "r32_uint",
        vk::Format::R32_SINT => "r32_sint",
        vk::Format::R32G32_SFLOAT => "r32g32_sfloat",
        vk::Format::R32G32_UINT => "r32g32_uint",
        vk::Format::R32G32_SINT => "r32g32_sint",
        vk::Format::R32G32B32A32_SFLOAT => "r32g32b32a32_sfloat",
        vk::Format::R32G32B32A32_UINT => "r32g32b32a32_uint",
        _ => "r32g32b32a32_sint",
    }
}

struct ImageArrayCase {
    name: String,
    params: TestParams,
}

impl TestCase for ImageArrayCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_maintenance11")?;

        let params = &self.params;
        let format_properties = match unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                params.image_format,
                params.image_type,
                params.tiling(),
                params.image_usage(),
                vk::ImageCreateFlags::empty(),
            )
        } {
            Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => {
                return Err(TestError::NotSupported(
                    "Format not supported for requested usage".to_string(),
                ));
            }
            result => result.vk_check("vkGetPhysicalDeviceImageFormatProperties")?,
        };

        let extent = params.creation_extent();
        let max_extent = format_properties.max_extent;

        if extent.width > max_extent.width || extent.height > max_extent.height || extent.depth > max_extent.depth {
            return Err(TestError::NotSupported(format!(
                "Extent limits ({}, {}, {} too small for target extent ({}, {}, {})",
                max_extent.width, max_extent.height, max_extent.depth, extent.width, extent.height, extent.depth
            )));
        }

        let layer_count = params.layer_count();
        if layer_count > format_properties.max_array_layers {
            return Err(TestError::NotSupported(format!(
                "maxArrayLayers ({}) too small for target layers ({layer_count})",
                format_properties.max_array_layers
            )));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = self.params.program_key();
        ALL_IMAGE_ARRAY_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .expect("the manifest has a program for every case")
            .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageArrayInstance {
            context,
            params: self.params,
        })
    }
}

struct ImageArrayInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

/// `genIntValues` - int values for color channels, based on minimum and maximum values.
fn gen_int_values(
    rng: &mut Random,
    bit_depth: [i32; 4],
    min_int_values: [i32; 4],
    max_int_values: [i32; 4],
) -> [i32; 4] {
    let mut values = [0i32; 4];
    for c in 0..4 {
        values[c] = if bit_depth[c] > 0 {
            rng.get_int(min_int_values[c], max_int_values[c])
        } else if c == 3 {
            1
        } else {
            0
        };
    }
    values
}

/// `genUintValues` - uint values for color channels, based on maximum allowed values.
fn gen_uint_values(rng: &mut Random, bit_depth: [i32; 4], max_uint_values: [u32; 4]) -> [u32; 4] {
    let mut values = [0u32; 4];
    for c in 0..4 {
        values[c] = if bit_depth[c] > 0 {
            rng.get_uint32() & max_uint_values[c]
        } else if c == 3 {
            1
        } else {
            0
        };
    }
    values
}

/// `genFloatValues` - float values for color channels, in the [0,1] range.
fn gen_float_values(rng: &mut Random, bit_depth: [i32; 4]) -> [f32; 4] {
    let mut values = [0.0f32; 4];
    for c in 0..4 {
        values[c] = if bit_depth[c] > 0 {
            rng.get_float()
        } else if c == 3 {
            1.0
        } else {
            0.0
        };
    }
    values
}

fn image_barrier(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barrier: vk::ImageMemoryBarrier,
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        )
    };
}

impl TestInstance for ImageArrayInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let tcu_format = map_vk_format(params.image_format)
            .ok_or_else(|| TestError::NotPorted(format!("texture format of {:?}", params.image_format)))?;
        let aspects = vk::ImageAspectFlags::COLOR;

        let image_create_info = vk::ImageCreateInfo::builder()
            .flags(unsafe { vk::ImageCreateFlags::from_bits_unchecked(ALIAS_SINGLE_LAYER_DESCRIPTOR) })
            .image_type(params.image_type)
            .format(params.image_format)
            .extent(params.creation_extent())
            .mip_levels(params.mip_level_count())
            .array_layers(params.layer_count())
            .samples(vk::SampleCountFlags::_1)
            .tiling(params.tiling())
            .usage(params.image_usage())
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let image = ImageWithMemory::new(
            device,
            context.get_default_allocator(),
            image_create_info,
            MemoryRequirement::ANY,
        )?;
        let image_srr = make_image_subresource_range(aspects, 0, params.mip_level_count(), params.layer, 1);
        let mip_layer_srl = make_image_subresource_layers(aspects, params.lod, params.layer, 1);
        let image_view = make_image_view(device, image.get(), params.view_type, params.image_format, image_srr)?;

        let channel_class = tcu_format.channel_class();
        let use_ints = channel_class == TextureChannelClass::SignedInteger;
        let use_uints = channel_class == TextureChannelClass::UnsignedInteger;
        let use_floats = !use_ints && !use_uints;

        let use_sampler = params.descriptor_type == vk::DescriptorType::COMBINED_IMAGE_SAMPLER;
        let sampler = if use_sampler {
            let sampler_create_info = vk::SamplerCreateInfo::builder()
                .mag_filter(vk::Filter::NEAREST)
                .min_filter(vk::Filter::NEAREST)
                .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
                .address_mode_u(vk::SamplerAddressMode::REPEAT)
                .address_mode_v(vk::SamplerAddressMode::REPEAT)
                .address_mode_w(vk::SamplerAddressMode::REPEAT)
                .mip_lod_bias(0.0)
                .anisotropy_enable(false)
                .max_anisotropy(0.0)
                .compare_enable(false)
                .compare_op(vk::CompareOp::NEVER)
                .min_lod(0.0)
                .max_lod(params.lod as f32)
                .border_color(if use_floats {
                    vk::BorderColor::FLOAT_OPAQUE_BLACK
                } else {
                    vk::BorderColor::INT_OPAQUE_BLACK
                })
                .unnormalized_coordinates(false);
            Some(Unique::new(
                device,
                unsafe { device.create_sampler(&sampler_create_info, None) }.vk_check("vkCreateSampler")?,
            ))
        } else {
            None
        };

        let mip_extent = params.mip_level_extent();
        let extent3 = [mip_extent.width, mip_extent.height, mip_extent.depth];
        let pixel_count = mip_extent.width * mip_extent.height * mip_extent.depth;

        let vec_size = std::mem::size_of::<[f32; 4]>() as u32;
        let vec_buffer_size = pixel_count * vec_size;

        let pixel_size = tcu_format
            .pixel_size()
            .ok_or_else(|| TestError::NotPorted(format!("pixel size of {:?}", params.image_format)))?;
        let pixel_buffer_size = pixel_count * pixel_size;

        // We need 2 buffers: a buffer with "expanded" values, i.e. in vec form as used by the shaders, and a buffer containing
        // pixel values in "image" form, i.e. the type that you would use with copyImageToBuffer or copyBufferToImage.
        //
        // If we're testing reads from the image, we need the pixel buffer as input, to run copyBufferToImage, and the expanded
        // buffer as output, to see what we got out.
        //
        // If we're testing writes to the image, we need the expanded buffer as input in the shader and the pixel buffer as the
        // output, where we will copy results.

        // Expanded or "vec" buffer. This is the one used in the shader, so it's a storage buffer.
        let vec_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(vec_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Pixel buffer, potentially smaller, used to copy image data in or out.
        let px_buffer_usage = if params.store {
            vk::BufferUsageFlags::TRANSFER_DST
        } else {
            vk::BufferUsageFlags::TRANSFER_SRC
        };
        let px_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(pixel_buffer_size as vk::DeviceSize, px_buffer_usage),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Fill source buffer(s).
        let seed = params.seed();

        // Bit depths and value ranges.
        let bit_depth = get_texture_format_bit_depth(tcu_format);
        let max_int_values = if use_ints {
            get_format_max_int_value(tcu_format)
        } else {
            [0; 4]
        };
        let min_int_values = max_int_values.map(|max| if use_ints { -max - 1 } else { 0 });
        let max_uint_values = if use_uints {
            get_format_max_uint_value(tcu_format)
        } else {
            [0; 4]
        };

        let mut rnd = Random::new(seed);

        let mut vec_bytes = vec![0u8; vec_buffer_size as usize];
        let mut px_level = TextureLevel::new(tcu_format, extent3[0], extent3[1], extent3[2])?;

        if params.store {
            for i in 0..pixel_count as usize {
                let byte_idx = i * vec_size as usize;
                let bytes = &mut vec_bytes[byte_idx..byte_idx + vec_size as usize];

                if use_ints {
                    let values = gen_int_values(&mut rnd, bit_depth, min_int_values, max_int_values);
                    for (c, value) in values.iter().enumerate() {
                        bytes[c * 4..c * 4 + 4].copy_from_slice(&value.to_ne_bytes());
                    }
                } else if use_uints {
                    let values = gen_uint_values(&mut rnd, bit_depth, max_uint_values);
                    for (c, value) in values.iter().enumerate() {
                        bytes[c * 4..c * 4 + 4].copy_from_slice(&value.to_ne_bytes());
                    }
                } else {
                    let values = gen_float_values(&mut rnd, bit_depth);
                    for (c, value) in values.iter().enumerate() {
                        bytes[c * 4..c * 4 + 4].copy_from_slice(&value.to_ne_bytes());
                    }
                }
            }

            unsafe {
                std::ptr::copy_nonoverlapping(
                    vec_bytes.as_ptr(),
                    vec_buffer.get_allocation().get_host_ptr(),
                    vec_bytes.len(),
                )
            };
            flush_alloc(device, vec_buffer.get_allocation())?;
        } else {
            {
                let mut px_access = px_level.get_access();
                for z in 0..extent3[2] {
                    for y in 0..extent3[1] {
                        for x in 0..extent3[0] {
                            if use_ints {
                                let values = gen_int_values(&mut rnd, bit_depth, min_int_values, max_int_values);
                                if !px_access.set_pixel_int(values, x, y, z) {
                                    return Err(TestError::NotPorted(format!(
                                        "writing texels of {:?}",
                                        params.image_format
                                    )));
                                }
                            } else if use_uints {
                                let values = gen_uint_values(&mut rnd, bit_depth, max_uint_values);
                                if !px_access.set_pixel_int(values.map(|value| value as i32), x, y, z) {
                                    return Err(TestError::NotPorted(format!(
                                        "writing texels of {:?}",
                                        params.image_format
                                    )));
                                }
                            } else {
                                let values = gen_float_values(&mut rnd, bit_depth);
                                px_access.set_pixel(values, x, y, z);
                            }
                        }
                    }
                }
            }

            unsafe {
                std::ptr::copy_nonoverlapping(
                    px_level.data().as_ptr(),
                    px_buffer.get_allocation().get_host_ptr(),
                    pixel_buffer_size as usize,
                )
            };
            flush_alloc(device, px_buffer.get_allocation())?;
        }

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(params.descriptor_type, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(params.descriptor_type, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;

        let img_layout = params.image_layout_shader();
        let img_desc = [vk::DescriptorImageInfo {
            sampler: sampler.as_ref().map_or(vk::Sampler::null(), |sampler| **sampler),
            image_view: *image_view,
            image_layout: img_layout,
        }];
        let buffer_desc = [vk::DescriptorBufferInfo {
            buffer: vec_buffer.get(),
            offset: 0,
            range: vk::WHOLE_SIZE,
        }];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .descriptor_type(params.descriptor_type)
                .image_info(&img_desc)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&buffer_desc)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;

        let comp_shader = create_shader_module(device, context.get_binary_collection().get("comp")?)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*comp_shader)
            .name(b"main\0")
            .build();
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(0);
        let pipeline = Unique::new(
            device,
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?
                .0[0],
        );

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: mip_layer_srl,
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: mip_extent,
        };

        begin_command_buffer(device, cmd)?;
        if params.store {
            // The vector buffer already has the right contents, ready to be copied to the image.
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::UNDEFINED,
                img_layout,
                image.get(),
                image_srr,
            );
            image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                barrier,
            );
        } else {
            // Copy the pixel buffer to the first layer of the image's mip level so it's read in the shader.
            let pre_copy_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                image.get(),
                image_srr,
            );
            image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                pre_copy_barrier,
            );

            unsafe {
                device.cmd_copy_buffer_to_image(
                    cmd,
                    px_buffer.get(),
                    image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[region],
                )
            };

            let post_copy_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                img_layout,
                image.get(),
                image_srr,
            );
            image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                post_copy_barrier,
            );
        }
        {
            let bind_point = vk::PipelineBindPoint::COMPUTE;
            unsafe {
                device.cmd_bind_pipeline(cmd, bind_point, *pipeline);
                device.cmd_bind_descriptor_sets(
                    cmd,
                    bind_point,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
                let wg_count = pixel_count.div_ceil(params.work_group_size());
                device.cmd_dispatch(cmd, wg_count, 1, 1);
            }
        }
        if params.store {
            // Copy first layer of the image's mip level to the pixel buffer, for verification.
            let pre_copy_barrier = make_image_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                img_layout,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                image.get(),
                image_srr,
            );
            image_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::TRANSFER,
                pre_copy_barrier,
            );

            unsafe {
                device.cmd_copy_image_to_buffer(
                    cmd,
                    image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    px_buffer.get(),
                    &[region],
                )
            };
        }
        {
            // Reads from any buffer to the host.
            let pre_host_barrier = make_memory_barrier(
                vk::AccessFlags::SHADER_WRITE | vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMPUTE_SHADER | vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[pre_host_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        if params.store {
            // Verify contents of the pixel buffer.
            invalidate_alloc(device, px_buffer.get_allocation())?;
            let px_data = unsafe {
                std::slice::from_raw_parts(
                    px_buffer.get_allocation().get_host_ptr().cast_const(),
                    pixel_buffer_size as usize,
                )
            };
            px_level.data_mut().copy_from_slice(px_data);
        } else {
            // Verify contents of the vec buffer.
            invalidate_alloc(device, vec_buffer.get_allocation())?;
        }

        // Make sure both buffers match. Create views into the vec buffer as a texture.
        let vec_data = unsafe {
            std::slice::from_raw_parts(
                vec_buffer.get_allocation().get_host_ptr().cast_const(),
                vec_buffer_size as usize,
            )
        };
        let i_vec_access = ConstPixelBufferAccess::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT32),
            extent3,
            vec_data,
        );
        let u_vec_access = ConstPixelBufferAccess::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT32),
            extent3,
            vec_data,
        );
        let f_vec_access = ConstPixelBufferAccess::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT),
            extent3,
            vec_data,
        );
        let px_access = px_level.get_const_access();

        // For integers, values should be stored without errors.
        let integer_threshold = UVec4::from_array([0, 0, 0, 0]);

        // For floats, when loading we get exact results normally because the value comes from the pixel buffer and is stored in a
        // precise vec buffer. However, when storing we depend on the image format precision, so we use the lowest precision just
        // in case.
        let unorm_threshold = bit_depth.map(|bits| {
            if bits > 0 {
                1.0 / ((1u64 << bits) as f32 - 1.0)
            } else {
                0.0
            }
        });

        // 0.0000002 has proven to be a good value for other tests and is way less than a single 16-bit unit.
        let sfloat_threshold = bit_depth.map(|bits| if bits > 0 { 0.0000002 } else { 0.0 });

        let float_threshold = if channel_class == TextureChannelClass::FloatingPoint {
            sfloat_threshold
        } else {
            unorm_threshold
        };

        let ok = if use_ints {
            let (reference, result) = if params.store {
                (&i_vec_access, &px_access)
            } else {
                (&px_access, &i_vec_access)
            };
            int_threshold_compare(reference, result, integer_threshold).ok
        } else if use_uints {
            let (reference, result) = if params.store {
                (&u_vec_access, &px_access)
            } else {
                (&px_access, &u_vec_access)
            };
            int_threshold_compare(reference, result, integer_threshold).ok
        } else {
            let (reference, result) = if params.store {
                (&f_vec_access, &px_access)
            } else {
                (&px_access, &f_vec_access)
            };
            float_threshold_compare(reference, result, float_threshold).ok
        };

        if !ok {
            return Err(TestError::Fail(
                "Unexpected results in output buffer; check log for details --".to_string(),
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createImageArrayMaintenance11Tests`
pub fn create_image_array_maintenance11_tests() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("image_array_m11");

    let format_list = [
        vk::Format::R8_UNORM,
        vk::Format::R8_UINT,
        vk::Format::R8_SINT,
        vk::Format::R8G8_UNORM,
        vk::Format::R8G8_UINT,
        vk::Format::R8G8_SINT,
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R8G8B8A8_UINT,
        vk::Format::R8G8B8A8_SINT,
        vk::Format::R16_UNORM,
        vk::Format::R16_UINT,
        vk::Format::R16_SINT,
        vk::Format::R16G16_UNORM,
        vk::Format::R16G16_UINT,
        vk::Format::R16G16_SINT,
        vk::Format::R16G16B16A16_UNORM,
        vk::Format::R16G16B16A16_UINT,
        vk::Format::R16G16B16A16_SINT,
        vk::Format::R32_SFLOAT,
        vk::Format::R32_UINT,
        vk::Format::R32_SINT,
        vk::Format::R32G32_SFLOAT,
        vk::Format::R32G32_UINT,
        vk::Format::R32G32_SINT,
        vk::Format::R32G32B32A32_SFLOAT,
        vk::Format::R32G32B32A32_UINT,
        vk::Format::R32G32B32A32_SINT,
    ];

    let image_types = [vk::ImageType::_1D, vk::ImageType::_2D];

    // (view type, the group name `de::toLower(getImageViewTypeName(viewType).substr(strlen("VK_IMAGE_")))`)
    let image_view_types = [
        (vk::ImageViewType::_1D, "view_type_1d"),
        (vk::ImageViewType::_1D_ARRAY, "view_type_1d_array"),
        (vk::ImageViewType::_2D, "view_type_2d"),
        (vk::ImageViewType::_2D_ARRAY, "view_type_2d_array"),
    ];

    let descriptor_types = [
        vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
        vk::DescriptorType::STORAGE_IMAGE,
    ];

    for format in format_list {
        let mut format_group = TestCaseGroup::new(format_simple_name(format));

        for image_type in image_types {
            for (view_type, view_type_group_name) in image_view_types {
                if image_type == vk::ImageType::_2D {
                    if view_type != vk::ImageViewType::_2D && view_type != vk::ImageViewType::_2D_ARRAY {
                        continue;
                    }
                } else if view_type != vk::ImageViewType::_1D && view_type != vk::ImageViewType::_1D_ARRAY {
                    continue;
                }

                let mut view_type_group = TestCaseGroup::new(view_type_group_name);

                for descriptor_type in descriptor_types {
                    for layer in [0u32, 1] {
                        for lod in [0u32, 1, 2] {
                            if lod != 0 && descriptor_type != vk::DescriptorType::COMBINED_IMAGE_SAMPLER {
                                continue;
                            }

                            for store in [false, true] {
                                if store && descriptor_type != vk::DescriptorType::STORAGE_IMAGE {
                                    continue;
                                }

                                let params = TestParams {
                                    image_format: format,
                                    image_type,
                                    view_type,
                                    descriptor_type,
                                    layer,
                                    lod,
                                    store,
                                };

                                let test_name = if descriptor_type == vk::DescriptorType::STORAGE_IMAGE {
                                    format!("storage_img_{layer}{}", if store { "_store" } else { "_load" })
                                } else {
                                    format!("sampler_lod_{layer}{lod}")
                                };

                                view_type_group.add_child(Box::new(ImageArrayCase {
                                    name: test_name,
                                    params,
                                }) as Box<dyn TestCase>);
                            }
                        }
                    }
                }

                format_group.add_child(view_type_group);
            }
        }

        main_group.add_child(format_group);
    }

    main_group
}
