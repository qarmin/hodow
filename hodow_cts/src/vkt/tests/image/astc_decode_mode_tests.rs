// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageAstcDecodeModeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shader text depends only on 2D/3D and on the e5b9g9r9 clamping
// special cases, so the five variants are plain sources listed in shaders/manifest/image_astc_decode_mode.toml.
//
// The same random ASTC blocks are sampled through a view with an ASTC decode mode and through one without; the compute
// shader writes 0.5 where the two agree.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::image_astc_decode_mode::*;
use crate::tcu::{TestError, TestOutcome, TestStatus, astc};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compressed_formats::{
    get_block_depth, get_block_height, get_block_size_in_bytes, get_block_width, is_astc_srgb_format,
};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set,
};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::image::tests_util::{ImageType, get_image_size_bytes, map_image_type, map_image_view_type};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy)]
struct TestParameters {
    image_type: ImageType,
    image_size: [u32; 3],

    tested_format: vk::Format,
    tested_is_unorm: bool,
    tested_is_sfloat: bool,
    tested_decode_mode: vk::Format,
    tested_image_usage: vk::ImageUsageFlags,

    result_format: vk::Format,
    result_image_usage: vk::ImageUsageFlags,
}

/// `getCompressedImageResolutionInBlocks`
fn get_compressed_image_resolution_in_blocks(format: vk::Format, size: [u32; 3]) -> [u32; 3] {
    [
        size[0].div_ceil(get_block_width(format)),
        size[1].div_ceil(get_block_height(format)),
        size[2].div_ceil(get_block_depth(format)),
    ]
}

/// `getCompressedImageSizeInBytes`
fn get_compressed_image_size_in_bytes(format: vk::Format, size: [u32; 3]) -> vk::DeviceSize {
    let blocks = get_compressed_image_resolution_in_blocks(format, size);
    vk::DeviceSize::from(blocks[0])
        * vk::DeviceSize::from(blocks[1])
        * vk::DeviceSize::from(blocks[2])
        * vk::DeviceSize::from(get_block_size_in_bytes(format))
}

fn write_combined_image_sampler(
    device: &Device,
    descriptor_set: vk::DescriptorSet,
    binding: u32,
    image_info: &vk::DescriptorImageInfo,
) {
    write_image_descriptor(
        device,
        descriptor_set,
        binding,
        vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
        image_info,
    );
}

fn write_image_descriptor(
    device: &Device,
    descriptor_set: vk::DescriptorSet,
    binding: u32,
    descriptor_type: vk::DescriptorType,
    image_info: &vk::DescriptorImageInfo,
) {
    let write = vk::WriteDescriptorSet {
        s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
        next: std::ptr::null(),
        dst_set: descriptor_set,
        dst_binding: binding,
        dst_array_element: 0,
        descriptor_count: 1,
        descriptor_type,
        image_info,
        buffer_info: std::ptr::null(),
        texel_buffer_view: std::ptr::null(),
    };
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
}

fn make_image_create_info(
    flags: vk::ImageCreateFlags,
    image_type: vk::ImageType,
    format: vk::Format,
    extent: vk::Extent3D,
    usage: vk::ImageUsageFlags,
) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags,
        image_type,
        format,
        extent,
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::OPTIMAL,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    }
}

struct AstcDecodeModeCase {
    name: String,
    parameters: TestParameters,
}

impl TestCase for AstcDecodeModeCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let p = &self.parameters;

        context.require_device_functionality("VK_EXT_astc_decode_mode")?;
        if context.get_device_features().texture_compression_astc_ldr == vk::FALSE {
            return Err(TestError::NotSupported(
                "textureCompressionASTC_LDR not supported".to_string(),
            ));
        }

        let image_type = map_image_type(p.image_type);
        let tested = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                p.tested_format,
                image_type,
                vk::ImageTiling::OPTIMAL,
                p.tested_image_usage,
                vk::ImageCreateFlags::empty(),
            )
        };
        if matches!(tested, Err(e) if e == vk::ErrorCode::FORMAT_NOT_SUPPORTED) {
            return Err(TestError::NotSupported(
                "Operation not supported with this image format".to_string(),
            ));
        }
        let result = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                p.result_format,
                image_type,
                vk::ImageTiling::OPTIMAL,
                p.result_image_usage,
                vk::ImageCreateFlags::empty(),
            )
        };
        if matches!(result, Err(e) if e == vk::ErrorCode::FORMAT_NOT_SUPPORTED) {
            return Err(TestError::NotSupported(
                "Operation not supported with this image format".to_string(),
            ));
        }

        if p.tested_decode_mode == vk::Format::E5B9G9R9_UFLOAT_PACK32 {
            let mut astc_decode_features = vk::PhysicalDeviceASTCDecodeFeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut astc_decode_features);
            unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
            if astc_decode_features.decode_mode_shared_exponent == vk::FALSE {
                return Err(TestError::NotSupported(
                    "decodeModeSharedExponent not supported".to_string(),
                ));
            }
        }

        let properties = unsafe { instance.get_physical_device_format_properties(physical_device, p.result_format) };
        if !properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::STORAGE_IMAGE)
        {
            return Err(TestError::NotSupported(
                "Format storage feature not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let p = &self.parameters;
        let e5 = p.tested_decode_mode == vk::Format::E5B9G9R9_UFLOAT_PACK32;
        let is_3d = p.image_size[2] > 1;
        let program = match (is_3d, e5 && p.tested_is_unorm, e5 && p.tested_is_sfloat) {
            (false, true, _) => &ASTC_2D_UNORM_E5,
            (false, false, _) => &ASTC_2D_PLAIN,
            (true, true, _) => &ASTC_3D_UNORM_E5,
            (true, false, true) => &ASTC_3D_SFLOAT_E5,
            (true, false, false) => &ASTC_3D_PLAIN,
        };
        program.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BasicComputeTestInstance {
            context,
            parameters: self.parameters,
        })
    }
}

struct BasicComputeTestInstance<'a> {
    context: &'a Context<'a>,
    parameters: TestParameters,
}

impl TestInstance for BasicComputeTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let p = &self.parameters;
        let allocator = self.context.get_default_allocator();
        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let image_type = map_image_type(p.image_type);
        let blocks = get_compressed_image_resolution_in_blocks(p.tested_format, p.image_size);
        let extent_compressed = vk::Extent3D {
            width: blocks[0],
            height: blocks[1],
            depth: blocks[2],
        };
        let extent_uncompressed = vk::Extent3D {
            width: p.image_size[0],
            height: p.image_size[1],
            depth: p.image_size[2],
        };
        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let compressed_image_info = make_image_create_info(
            vk::ImageCreateFlags::MUTABLE_FORMAT | vk::ImageCreateFlags::BLOCK_TEXEL_VIEW_COMPATIBLE,
            image_type,
            p.tested_format,
            extent_compressed,
            vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST,
        );
        let result_image_info = make_image_create_info(
            vk::ImageCreateFlags::empty(),
            image_type,
            p.result_format,
            extent_uncompressed,
            vk::ImageUsageFlags::SAMPLED
                | vk::ImageUsageFlags::STORAGE
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST,
        );

        // create images
        let tested_image = ImageWithMemory::new(vk, allocator, compressed_image_info, MemoryRequirement::ANY)?;
        let reference_image = ImageWithMemory::new(vk, allocator, compressed_image_info, MemoryRequirement::ANY)?;
        let result_image = ImageWithMemory::new(vk, allocator, result_image_info, MemoryRequirement::ANY)?;

        // create image views
        let image_view_type = map_image_view_type(p.image_type)
            .ok_or_else(|| TestError::InternalError("no view type for the image type".to_string()))?;
        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let mut decode_mode = vk::ImageViewASTCDecodeModeEXT::builder().decode_mode(p.tested_decode_mode);
        let image_view_params = vk::ImageViewCreateInfo::builder()
            .image(*tested_image)
            .view_type(image_view_type)
            .format(p.tested_format)
            .components(vk::ComponentMapping {
                r: vk::ComponentSwizzle::IDENTITY,
                g: vk::ComponentSwizzle::IDENTITY,
                b: vk::ComponentSwizzle::IDENTITY,
                a: vk::ComponentSwizzle::IDENTITY,
            })
            .subresource_range(subresource_range)
            .push_next(&mut decode_mode);
        let tested_view = Unique::new(
            vk,
            unsafe { vk.create_image_view(&image_view_params, None) }.vk_check("vkCreateImageView")?,
        );
        let reference_view = make_image_view(
            vk,
            *reference_image,
            image_view_type,
            p.tested_format,
            subresource_range,
        )?;
        let result_view = make_image_view(
            vk,
            *result_image,
            image_view_type,
            p.result_format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::COMPUTE,
            )
            .add_single_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::COMPUTE,
            )
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let mut pipeline = ComputePipelineWrapper::new(
            vk,
            ComputePipelineConstructionType::Pipeline,
            self.context.get_binary_collection().get("comp")?,
        );
        pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline.build_pipeline()?;

        let buffer_size_compressed = get_compressed_image_size_in_bytes(p.tested_format, p.image_size);
        let buffer_size_uncompressed = get_image_size_bytes(
            [
                extent_uncompressed.width as i32,
                extent_uncompressed.height as i32,
                extent_uncompressed.depth as i32,
            ],
            p.result_format,
        )
        .ok_or_else(|| TestError::InternalError("no size for the result format".to_string()))?;
        let compressed_buffer_ci = make_buffer_create_info(buffer_size_compressed, vk::BufferUsageFlags::TRANSFER_SRC);
        let uncompressed_buffer_ci = make_buffer_create_info(
            buffer_size_uncompressed,
            vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
        );
        let in_buffer = BufferWithMemory::new(vk, allocator, compressed_buffer_ci, MemoryRequirement::HOST_VISIBLE)?;
        let result_buffer =
            BufferWithMemory::new(vk, allocator, uncompressed_buffer_ci, MemoryRequirement::HOST_VISIBLE)?;

        // generate data for compressed image and copy it to in buffer
        {
            let mut generated_data = vec![0u8; buffer_size_compressed as usize];
            let block_count = (blocks[0] * blocks[1] * blocks[2]) as usize;
            astc::generate_random_valid_blocks(
                &mut generated_data,
                block_count,
                get_block_width(p.tested_format),
                get_block_height(p.tested_format),
                is_astc_srgb_format(p.tested_format),
                true,
                1,
            );

            let alloc = in_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(generated_data.as_ptr(), alloc.get_host_ptr(), generated_data.len())
            };
            flush_alloc(vk, alloc)?;
        }

        let sampler_create_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .mip_lod_bias(0.0)
            .anisotropy_enable(false)
            .max_anisotropy(1.0)
            .compare_enable(false)
            .compare_op(vk::CompareOp::EQUAL)
            .min_lod(0.0)
            .max_lod(1.0)
            .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
            .unnormalized_coordinates(false);
        let sampler = Unique::new(
            vk,
            unsafe { vk.create_sampler(&sampler_create_info, None) }.vk_check("vkCreateSampler")?,
        );

        let tested_info = vk::DescriptorImageInfo {
            sampler: *sampler,
            image_view: *tested_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        };
        let reference_info = vk::DescriptorImageInfo {
            sampler: *sampler,
            image_view: *reference_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        };
        let result_info = vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *result_view,
            image_layout: vk::ImageLayout::GENERAL,
        };
        write_combined_image_sampler(vk, *descriptor_set, 0, &tested_info);
        write_combined_image_sampler(vk, *descriptor_set, 1, &reference_info);
        write_image_descriptor(vk, *descriptor_set, 2, vk::DescriptorType::STORAGE_IMAGE, &result_info);

        begin_command_buffer(vk, cmd)?;
        {
            // copy input buffer to tested and reference images
            for image in [&tested_image, &reference_image] {
                let pre_copy_image_barrier = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    **image,
                    subresource_range,
                );
                let flush_host_copy_barrier = make_buffer_memory_barrier(
                    vk::AccessFlags::HOST_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    *in_buffer,
                    0,
                    buffer_size_compressed,
                );

                unsafe {
                    vk.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::HOST,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[flush_host_copy_barrier],
                        &[pre_copy_image_barrier],
                    );
                }

                let copy_region = make_buffer_image_copy(
                    extent_compressed,
                    make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                );
                unsafe {
                    vk.cmd_copy_buffer_to_image(
                        cmd,
                        *in_buffer,
                        **image,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &[copy_region],
                    )
                };
            }

            // bind pipeline and descriptors
            pipeline.bind(cmd);
            unsafe {
                vk.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    pipeline.get_pipeline_layout(),
                    0,
                    &[*descriptor_set],
                    &[],
                )
            };

            {
                let pre_shader_image_barriers = [
                    make_image_memory_barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::SHADER_READ,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                        *tested_image,
                        subresource_range,
                    ),
                    make_image_memory_barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::SHADER_READ,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                        *reference_image,
                        subresource_range,
                    ),
                    make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::SHADER_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::GENERAL,
                        *result_image,
                        subresource_range,
                    ),
                ];

                unsafe {
                    vk.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::PipelineStageFlags::COMPUTE_SHADER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &pre_shader_image_barriers,
                    );
                }
            }

            unsafe {
                vk.cmd_dispatch(
                    cmd,
                    extent_uncompressed.width,
                    extent_uncompressed.height,
                    extent_uncompressed.depth,
                )
            };

            {
                let post_shader_image_barriers = [make_image_memory_barrier(
                    vk::AccessFlags::SHADER_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::GENERAL,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    *result_image,
                    subresource_range,
                )];

                unsafe {
                    vk.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::COMPUTE_SHADER,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &post_shader_image_barriers,
                    );
                }
            }

            let copy_region = make_buffer_image_copy(
                result_image_info.extent,
                make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            );
            unsafe {
                vk.cmd_copy_image_to_buffer(
                    cmd,
                    *result_image,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    *result_buffer,
                    &[copy_region],
                )
            };

            {
                let post_copy_buffer_barrier = [make_buffer_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::HOST_READ,
                    *result_buffer,
                    0,
                    buffer_size_uncompressed,
                )];

                unsafe {
                    vk.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::PipelineStageFlags::HOST,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &post_copy_buffer_barrier,
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }
            }
        }
        end_command_buffer(vk, cmd)?;
        submit_commands_and_wait(vk, queue, cmd)?;

        let result_alloc = result_buffer.get_allocation();
        invalidate_alloc(vk, result_alloc)?;

        // verification is done in shader - here we just check if one of pixels has wrong value
        let result = unsafe {
            std::slice::from_raw_parts(
                result_alloc.get_host_ptr().cast_const(),
                buffer_size_uncompressed as usize,
            )
        };
        for pixel in result.chunks(4) {
            // expected result should be around 128 (if reference is same as tested mode then we return 0.5)
            if pixel[0] < 100 || pixel[0] > 150 {
                return Ok(TestStatus::fail("Fail"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

struct FormatData {
    format: vk::Format,
    name: &'static str,
    is_unorm: bool,
    is_sfloat: bool,
}

/// `createImageAstcDecodeModeTests`
pub fn create_image_astc_decode_mode_tests() -> TestCaseGroup {
    macro_rules! fd {
        ($format:ident, $name:expr, $unorm:expr, $sfloat:expr) => {
            FormatData {
                format: vk::Format::$format,
                name: $name,
                is_unorm: $unorm,
                is_sfloat: $sfloat,
            }
        };
    }
    let astc_formats = [
        fd!(ASTC_4X4_UNORM_BLOCK, "4x4_unorm", true, false),
        fd!(ASTC_4X4_SRGB_BLOCK, "4x4_srgb", false, false),
        fd!(ASTC_5X4_UNORM_BLOCK, "5x4_unorm", true, false),
        fd!(ASTC_5X4_SRGB_BLOCK, "5x4_srgb", false, false),
        fd!(ASTC_5X5_UNORM_BLOCK, "5x5_unorm", true, false),
        fd!(ASTC_5X5_SRGB_BLOCK, "5x5_srgb", false, false),
        fd!(ASTC_6X5_UNORM_BLOCK, "6x5_unorm", true, false),
        fd!(ASTC_6X5_SRGB_BLOCK, "6x5_srgb", false, false),
        fd!(ASTC_6X6_UNORM_BLOCK, "6x6_unorm", true, false),
        fd!(ASTC_6X6_SRGB_BLOCK, "6x6_srgb", false, false),
        fd!(ASTC_8X5_UNORM_BLOCK, "8x5_unorm", true, false),
        fd!(ASTC_8X5_SRGB_BLOCK, "8x5_srgb", false, false),
        fd!(ASTC_8X6_UNORM_BLOCK, "8x6_unorm", true, false),
        fd!(ASTC_8X6_SRGB_BLOCK, "8x6_srgb", false, false),
        fd!(ASTC_8X8_UNORM_BLOCK, "8x8_unorm", true, false),
        fd!(ASTC_8X8_SRGB_BLOCK, "8x8_srgb", false, false),
        fd!(ASTC_10X5_UNORM_BLOCK, "10x5_unorm", true, false),
        fd!(ASTC_10X5_SRGB_BLOCK, "10x5_srgb", false, false),
        fd!(ASTC_10X6_UNORM_BLOCK, "10x6_unorm", true, false),
        fd!(ASTC_10X6_SRGB_BLOCK, "10x6_srgb", false, false),
        fd!(ASTC_10X8_UNORM_BLOCK, "10x8_unorm", true, false),
        fd!(ASTC_10X8_SRGB_BLOCK, "10x8_srgb", false, false),
        fd!(ASTC_10X10_UNORM_BLOCK, "10x10_unorm", true, false),
        fd!(ASTC_10X10_SRGB_BLOCK, "10x10_srgb", false, false),
        fd!(ASTC_12X10_UNORM_BLOCK, "12x10_unorm", true, false),
        fd!(ASTC_12X10_SRGB_BLOCK, "12x10_srgb", false, false),
        fd!(ASTC_12X12_UNORM_BLOCK, "12x12_unorm", true, false),
        fd!(ASTC_12X12_SRGB_BLOCK, "12x12_srgb", false, false),
    ];
    let astc_3d_formats = [
        fd!(ASTC_3X3X3_UNORM_BLOCK_EXT, "3x3x3_unorm", true, false),
        fd!(ASTC_3X3X3_SRGB_BLOCK_EXT, "3x3x3_srgb", false, false),
        fd!(ASTC_3X3X3_SFLOAT_BLOCK_EXT, "3x3x3_sfloat", true, true),
        fd!(ASTC_4X3X3_UNORM_BLOCK_EXT, "4x3x3_unorm", true, false),
        fd!(ASTC_4X3X3_SRGB_BLOCK_EXT, "4x3x3_srgb", false, false),
        fd!(ASTC_4X3X3_SFLOAT_BLOCK_EXT, "4x3x3_sfloat", false, true),
        fd!(ASTC_4X4X3_UNORM_BLOCK_EXT, "4x4x3_unorm", true, false),
        fd!(ASTC_4X4X3_SRGB_BLOCK_EXT, "4x4x3_srgb", false, false),
        fd!(ASTC_4X4X3_SFLOAT_BLOCK_EXT, "4x4x3_sfloat", false, true),
        fd!(ASTC_4X4X4_UNORM_BLOCK_EXT, "4x4x4_unorm", true, false),
        fd!(ASTC_4X4X4_SRGB_BLOCK_EXT, "4x4x4_srgb", false, false),
        fd!(ASTC_4X4X4_SFLOAT_BLOCK_EXT, "4x4x4_sfloat", false, true),
        fd!(ASTC_5X4X4_UNORM_BLOCK_EXT, "5x4x4_unorm", true, false),
        fd!(ASTC_5X4X4_SRGB_BLOCK_EXT, "5x4x4_srgb", false, false),
        fd!(ASTC_5X4X4_SFLOAT_BLOCK_EXT, "5x4x4_sfloat", false, true),
        fd!(ASTC_5X5X4_UNORM_BLOCK_EXT, "5x5x4_unorm", true, false),
        fd!(ASTC_5X5X4_SRGB_BLOCK_EXT, "5x5x4_srgb", false, false),
        fd!(ASTC_5X5X4_SFLOAT_BLOCK_EXT, "5x5x4_sfloat", false, true),
        fd!(ASTC_5X5X5_UNORM_BLOCK_EXT, "5x5x5_unorm", true, false),
        fd!(ASTC_5X5X5_SRGB_BLOCK_EXT, "5x5x5_srgb", false, false),
        fd!(ASTC_5X5X5_SFLOAT_BLOCK_EXT, "5x5x5_sfloat", false, true),
        fd!(ASTC_6X5X5_UNORM_BLOCK_EXT, "6x5x5_unorm", true, false),
        fd!(ASTC_6X5X5_SRGB_BLOCK_EXT, "6x5x5_srgb", false, false),
        fd!(ASTC_6X5X5_SFLOAT_BLOCK_EXT, "6x5x5_sfloat", false, true),
        fd!(ASTC_6X6X5_UNORM_BLOCK_EXT, "6x6x5_unorm", true, false),
        fd!(ASTC_6X6X5_SRGB_BLOCK_EXT, "6x6x5_srgb", false, false),
        fd!(ASTC_6X6X5_SFLOAT_BLOCK_EXT, "6x6x5_sfloat", false, true),
        fd!(ASTC_6X6X6_UNORM_BLOCK_EXT, "6x6x6_unorm", true, false),
        fd!(ASTC_6X6X6_SRGB_BLOCK_EXT, "6x6x6_srgb", false, false),
        fd!(ASTC_6X6X6_SFLOAT_BLOCK_EXT, "6x6x6_sfloat", false, true),
    ];

    let decode_modes = [
        (vk::Format::R16G16B16A16_SFLOAT, "r16g16b16a16_sfloat"),
        (vk::Format::R8G8B8A8_UNORM, "r8g8b8a8_unorm"),
        (vk::Format::E5B9G9R9_UFLOAT_PACK32, "e5b9g9r9_ufloat_pack32"),
    ];

    let tested_usage =
        vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED;

    // Intermediate decoding precision cases
    let mut astc_decode_mode_tests = TestCaseGroup::new("astc_decode_mode");
    for format in &astc_formats {
        for (mode, mode_name) in decode_modes {
            let parameters = TestParameters {
                image_type: ImageType::TwoD,
                image_size: [64, 64, 1],
                tested_format: format.format,
                tested_is_unorm: format.is_unorm,
                tested_is_sfloat: format.is_sfloat,
                tested_decode_mode: mode,
                tested_image_usage: tested_usage,
                result_format: vk::Format::R8G8B8A8_UNORM,
                result_image_usage: vk::ImageUsageFlags::STORAGE,
            };
            let name = format!("{}_to_{}", format.name, mode_name);
            astc_decode_mode_tests.add_child(Box::new(AstcDecodeModeCase { name, parameters }) as Box<dyn TestCase>);
        }
    }
    for format in &astc_3d_formats {
        for (mode, mode_name) in decode_modes {
            // Skip invalid combination
            if format.is_sfloat && mode == vk::Format::R8G8B8A8_UNORM {
                continue;
            }
            let parameters = TestParameters {
                image_type: ImageType::ThreeD,
                image_size: [64, 64, 3],
                tested_format: format.format,
                tested_is_unorm: format.is_unorm,
                tested_is_sfloat: format.is_sfloat,
                tested_decode_mode: mode,
                tested_image_usage: tested_usage,
                result_format: vk::Format::R8G8B8A8_UNORM,
                result_image_usage: vk::ImageUsageFlags::STORAGE,
            };
            let name = format!("{}_to_{}", format.name, mode_name);
            astc_decode_mode_tests.add_child(Box::new(AstcDecodeModeCase { name, parameters }) as Box<dyn TestCase>);
        }
    }

    astc_decode_mode_tests
}
