// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageMultisampleLoadStoreTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders depend on the way the texture is bound, the format and the sample
// count, so the manifest holds one program set per combination and `programs()` looks the right one up.
//
// Multisampled storage image test.
//
//  Pass 1: Write a slightly different color pattern per-sample to the whole image.
//  Pass 2: Read samples of the same image and check if color values are in the expected range.
//          Write back results as a checksum image and verify them on the host.
//  Each checksum image pixel should contain an integer equal to the number of samples.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::image_multisample_load_store::ALL_MULTISAMPLE_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::tests::image::image_texture::Texture;
use crate::vkt::tests::image::tests_util::{ImageType, get_image_size_bytes, map_image_view_type};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const CHECKSUM_IMAGE_FORMAT: vk::Format = vk::Format::R32_SINT;

/// The `rust_type` of the manifest entries.
#[derive(Clone, Copy)]
pub struct MultisampleProgram {
    pub name: &'static str,
    pub kind: &'static str,
    pub format: &'static str,
    pub samples: u32,
    pub programs: BinaryCollection,
}

/// `CaseDef`; `format_name` is what the manifest knows the format by.
#[derive(Clone, Copy)]
struct CaseDef {
    texture: Texture,
    format: vk::Format,
    format_name: &'static str,
    num_samples: i32,
    single_layer_bind: bool,
}

/// `getImageTypeForSingleLayer`, for the types this group uses.
fn get_image_type_for_single_layer(image_type: ImageType) -> ImageType {
    match image_type {
        ImageType::TwoD | ImageType::TwoDArray => ImageType::TwoD,
        other => other,
    }
}

struct MultisampleLoadStoreCase {
    name: String,
    case_def: CaseDef,
}

impl TestCase for MultisampleLoadStoreCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let case_def = &self.case_def;
        if context.get_device_features().shader_storage_image_multisample == vk::FALSE {
            return Err(TestError::NotSupported(
                "shaderStorageImageMultisample not supported".to_string(),
            ));
        }

        if case_def.format == vk::Format::A8_UNORM {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let image_format_properties = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                case_def.format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                vk::ImageUsageFlags::STORAGE,
                vk::ImageCreateFlags::empty(),
            )
        };
        let Ok(image_format_properties) = image_format_properties else {
            return Err(TestError::NotSupported("Format is not supported".to_string()));
        };

        let samples = vk::SampleCountFlags::from_bits_truncate(case_def.num_samples as u32);
        if !image_format_properties.sample_counts.contains(samples) {
            return Err(TestError::NotSupported(
                "Requested sample count is not supported".to_string(),
            ));
        }

        if case_def.format == vk::Format::A8_UNORM {
            let mut format_properties3 = vk::FormatProperties3::default();
            let mut format_properties2 = vk::FormatProperties2::builder().push_next(&mut format_properties3);
            unsafe {
                instance.get_physical_device_format_properties2(
                    physical_device,
                    case_def.format,
                    &mut format_properties2,
                )
            };

            if !format_properties3
                .optimal_tiling_features
                .contains(vk::FormatFeatureFlags2::STORAGE_READ_WITHOUT_FORMAT)
            {
                return Err(TestError::NotSupported(
                    "Format does not support storage reads without format".to_string(),
                ));
            }
            if !format_properties3
                .optimal_tiling_features
                .contains(vk::FormatFeatureFlags2::STORAGE_WRITE_WITHOUT_FORMAT)
            {
                return Err(TestError::NotSupported(
                    "Format does not support storage writes without format".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let case_def = &self.case_def;
        let kind = if case_def.single_layer_bind {
            "2d_array_single"
        } else if case_def.texture.type_() == ImageType::TwoDArray {
            "2d_array"
        } else {
            "2d"
        };
        ALL_MULTISAMPLE_PROGRAM
            .iter()
            .find(|p| p.kind == kind && p.format == case_def.format_name && p.samples == case_def.num_samples as u32)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultisampleLoadStoreInstance {
            context,
            case_def: self.case_def,
        })
    }
}

struct MultisampleLoadStoreInstance<'a> {
    context: &'a Context<'a>,
    case_def: CaseDef,
}

/// `makeImageCreateInfo` for a storage image of `texture`.
fn make_texture_image_create_info(
    texture: &Texture,
    format: vk::Format,
    usage: vk::ImageUsageFlags,
) -> vk::ImageCreateInfo {
    let layer_size = texture.layer_size(0);
    vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: layer_size[0] as u32,
            height: layer_size[1] as u32,
            depth: layer_size[2] as u32,
        })
        .mip_levels(1)
        .array_layers(texture.num_layers() as u32)
        .samples(vk::SampleCountFlags::from_bits_truncate(texture.num_samples() as u32))
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build()
}

/// `getOptimalUniformBufferChunkSize`: the minimum chunk size is determined by the offset alignment requirements.
fn get_optimal_uniform_buffer_chunk_size(
    context: &Context<'_>,
    minimum_required_chunk_size_bytes: vk::DeviceSize,
) -> vk::DeviceSize {
    let alignment = context
        .get_device_properties()
        .limits
        .min_uniform_buffer_offset_alignment;

    if minimum_required_chunk_size_bytes > alignment {
        alignment + (minimum_required_chunk_size_bytes / alignment) * alignment
    } else {
        alignment
    }
}

fn create_compute_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    module: vk::ShaderModule,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(module)
        .name(b"main\0")
        .build();
    let info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(layout)
        .base_pipeline_index(-1)
        .build();
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

fn image_barriers(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barriers: &[vk::ImageMemoryBarrier],
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            barriers,
        )
    };
}

impl<'a> MultisampleLoadStoreInstance<'a> {
    /// `insertImageViews`: a view per layer when binding a single layer, otherwise one view over all of them.
    fn insert_image_views(
        &self,
        format: vk::Format,
        image: vk::Image,
    ) -> Result<Vec<Unique<'a, vk::ImageView>>, TestError> {
        let device = self.context.get_device();
        let texture = &self.case_def.texture;

        let mut views = Vec::new();
        if self.case_def.single_layer_bind {
            let view_type = map_image_view_type(get_image_type_for_single_layer(texture.type_()))
                .ok_or_else(|| TestError::InternalError("no view type".to_string()))?;
            for layer_ndx in 0..texture.num_layers() {
                views.push(make_image_view(
                    device,
                    image,
                    view_type,
                    format,
                    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, layer_ndx as u32, 1),
                )?);
            }
        } else {
            let view_type = map_image_view_type(texture.type_())
                .ok_or_else(|| TestError::InternalError("no view type".to_string()))?;
            views.push(make_image_view(
                device,
                image,
                view_type,
                format,
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, texture.num_layers() as u32),
            )?);
        }
        Ok(views)
    }

    /// `insertDescriptorSets`
    fn insert_descriptor_sets(
        &self,
        descriptor_pool: vk::DescriptorPool,
        descriptor_set_layout: vk::DescriptorSetLayout,
    ) -> Result<Vec<UniqueDescriptorSet<'a>>, TestError> {
        let device = self.context.get_device();
        let count = if self.case_def.single_layer_bind {
            self.case_def.texture.num_layers()
        } else {
            1
        };
        (0..count)
            .map(|_| make_descriptor_set(device, descriptor_pool, descriptor_set_layout))
            .collect()
    }

    fn run(&self) -> TestOutcome {
        let case_def = &self.case_def;
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let allocator = context.get_default_allocator();

        // Images

        let ms_image = ImageWithMemory::new(
            device,
            allocator,
            make_texture_image_create_info(&case_def.texture, case_def.format, vk::ImageUsageFlags::STORAGE),
            MemoryRequirement::ANY,
        )?;

        let checksum_texture = Texture::with_samples(&case_def.texture, 1);
        let checksum_image = ImageWithMemory::new(
            device,
            allocator,
            make_texture_image_create_info(
                &checksum_texture,
                CHECKSUM_IMAGE_FORMAT,
                vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;

        // Buffer used to pass constants to the shader.

        let num_layers = case_def.texture.num_layers();
        let buffer_chunk_size =
            get_optimal_uniform_buffer_chunk_size(context, std::mem::size_of::<i32>() as vk::DeviceSize);
        let constants_buffer_size_bytes = num_layers as vk::DeviceSize * buffer_chunk_size;
        let constants_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(constants_buffer_size_bytes, vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        {
            let alloc = constants_buffer.get_allocation();
            let base_ptr = alloc.get_host_ptr();

            unsafe {
                std::ptr::write_bytes(base_ptr, 0, constants_buffer_size_bytes as usize);
                for layer_ndx in 0..num_layers {
                    base_ptr
                        .add(layer_ndx as usize * buffer_chunk_size as usize)
                        .cast::<i32>()
                        .write_unaligned(layer_ndx);
                }
            }

            flush_alloc(device, alloc)?;
        }

        let result_buffer_size_bytes = get_image_size_bytes(case_def.texture.size(0), CHECKSUM_IMAGE_FORMAT)
            .ok_or_else(|| TestError::InternalError("no image size".to_string()))?;
        let result_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(result_buffer_size_bytes, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        {
            let alloc = result_buffer.get_allocation();
            unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, result_buffer_size_bytes as usize) };
            flush_alloc(device, alloc)?;
        }

        // Descriptors

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::UNIFORM_BUFFER, num_layers as u32)
            .add_type(vk::DescriptorType::STORAGE_IMAGE, num_layers as u32)
            .add_type(vk::DescriptorType::STORAGE_IMAGE, num_layers as u32)
            .build(
                device,
                vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                num_layers as u32,
            )?;

        let all_descriptor_sets = self.insert_descriptor_sets(*descriptor_pool, *descriptor_set_layout)?;
        let all_multisampled_image_views = self.insert_image_views(case_def.format, ms_image.get())?;
        let all_checksum_image_views = self.insert_image_views(CHECKSUM_IMAGE_FORMAT, checksum_image.get())?;

        // Prepare commands

        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let work_size = if case_def.single_layer_bind {
            case_def.texture.layer_size(0)
        } else {
            case_def.texture.size(0)
        };
        let loop_num_layers = if case_def.single_layer_bind { num_layers } else { 1 };
        let subresource_all_layers =
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, num_layers as u32);

        let binaries = context.get_binary_collection();

        // Writes the descriptors of one layer; the checksum image is only bound by the second pass.
        let update_descriptors = |layer_ndx: i32, with_checksum: bool| {
            let descriptor_set = all_descriptor_sets[layer_ndx as usize].get();
            let multi_image_info = [vk::DescriptorImageInfo::builder()
                .sampler(vk::Sampler::null())
                .image_view(*all_multisampled_image_views[layer_ndx as usize])
                .image_layout(vk::ImageLayout::GENERAL)
                .build()];
            let checksum_image_info = [vk::DescriptorImageInfo::builder()
                .sampler(vk::Sampler::null())
                .image_view(*all_checksum_image_views[layer_ndx as usize])
                .image_layout(vk::ImageLayout::GENERAL)
                .build()];
            let constants_buffer_info = [vk::DescriptorBufferInfo::builder()
                .buffer(constants_buffer.get())
                .offset(layer_ndx as vk::DeviceSize * buffer_chunk_size)
                .range(buffer_chunk_size)
                .build()];

            let mut writes = vec![
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set)
                    .dst_binding(0)
                    .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
                    .buffer_info(&constants_buffer_info)
                    .build(),
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set)
                    .dst_binding(1)
                    .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                    .image_info(&multi_image_info)
                    .build(),
            ];
            if with_checksum {
                writes.push(
                    vk::WriteDescriptorSet::builder()
                        .dst_set(descriptor_set)
                        .dst_binding(2)
                        .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                        .image_info(&checksum_image_info)
                        .build(),
                );
            }
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
            descriptor_set
        };

        // Pass 1: Write MS image
        {
            let shader_module = create_shader_module(device, binaries.get("comp_store")?)?;
            let pipeline = create_compute_pipeline(device, *pipeline_layout, *shader_module)?;

            begin_command_buffer(device, cmd)?;
            unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, pipeline.get()) };

            let barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::SHADER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    ms_image.get(),
                    subresource_all_layers,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::SHADER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    checksum_image.get(),
                    subresource_all_layers,
                ),
            ];
            image_barriers(
                device,
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                &barriers,
            );

            for layer_ndx in 0..loop_num_layers {
                let descriptor_set = update_descriptors(layer_ndx, false);

                unsafe {
                    device.cmd_bind_descriptor_sets(
                        cmd,
                        vk::PipelineBindPoint::COMPUTE,
                        *pipeline_layout,
                        0,
                        &[descriptor_set],
                        &[] as &[u32],
                    );
                    device.cmd_dispatch(cmd, work_size[0] as u32, work_size[1] as u32, work_size[2] as u32);
                }
            }

            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        // Pass 2: "Resolve" MS image in compute shader
        {
            let shader_module = create_shader_module(device, binaries.get("comp_load")?)?;
            let pipeline = create_compute_pipeline(device, *pipeline_layout, *shader_module)?;

            begin_command_buffer(device, cmd)?;
            unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, pipeline.get()) };

            let barriers = [make_image_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::GENERAL,
                ms_image.get(),
                subresource_all_layers,
            )];
            image_barriers(
                device,
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                &barriers,
            );

            for layer_ndx in 0..loop_num_layers {
                let descriptor_set = update_descriptors(layer_ndx, true);

                unsafe {
                    device.cmd_bind_descriptor_sets(
                        cmd,
                        vk::PipelineBindPoint::COMPUTE,
                        *pipeline_layout,
                        0,
                        &[descriptor_set],
                        &[] as &[u32],
                    );
                    device.cmd_dispatch(cmd, work_size[0] as u32, work_size[1] as u32, work_size[2] as u32);
                }
            }

            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        // Retrieve result
        {
            begin_command_buffer(device, cmd)?;

            let barriers = [make_image_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                checksum_image.get(),
                subresource_all_layers,
            )];
            image_barriers(
                device,
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::TRANSFER,
                &barriers,
            );

            let layer_size = case_def.texture.layer_size(0);
            let copy_region = make_buffer_image_copy(
                vk::Extent3D {
                    width: layer_size[0] as u32,
                    height: layer_size[1] as u32,
                    depth: layer_size[2] as u32,
                },
                make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, num_layers as u32),
            );
            unsafe {
                device.cmd_copy_image_to_buffer(
                    cmd,
                    checksum_image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    result_buffer.get(),
                    &[copy_region],
                )
            };

            let buffer_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                result_buffer.get(),
                0,
                result_buffer_size_bytes,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[buffer_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }

            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        // Verify
        let alloc = result_buffer.get_allocation();
        invalidate_alloc(device, alloc)?;

        let image_size = case_def.texture.size(0);
        let expected_checksum = case_def.texture.num_samples();
        let texel_count = (image_size[0] * image_size[1] * image_size[2]) as usize;
        let checksums = unsafe { std::slice::from_raw_parts(alloc.get_host_ptr().cast::<i32>(), texel_count) };

        if checksums.iter().any(|&checksum| checksum != expected_checksum) {
            return Ok(TestStatus::fail("Some sample colors were incorrect"));
        }

        Ok(TestStatus::pass("OK"))
    }
}

impl TestInstance for MultisampleLoadStoreInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

/// `createImageMultisampleLoadStoreTests`
pub fn create_image_multisample_load_store_tests() -> TestCaseGroup {
    // \note Shader code is tweaked to work with image size of 32, take a look if this needs to be modified.
    let textures = [
        (Texture::simple(ImageType::TwoD, [32, 32, 1], 1), "2d"),
        (Texture::simple(ImageType::TwoDArray, [32, 32, 1], 4), "2d_array"),
    ];

    let formats = [
        (vk::Format::R32G32B32A32_SFLOAT, "r32g32b32a32_sfloat"),
        (vk::Format::R16G16B16A16_SFLOAT, "r16g16b16a16_sfloat"),
        (vk::Format::R32_SFLOAT, "r32_sfloat"),
        (vk::Format::R32G32B32A32_UINT, "r32g32b32a32_uint"),
        (vk::Format::R16G16B16A16_UINT, "r16g16b16a16_uint"),
        (vk::Format::R8G8B8A8_UINT, "r8g8b8a8_uint"),
        (vk::Format::R32_UINT, "r32_uint"),
        (vk::Format::R32G32B32A32_SINT, "r32g32b32a32_sint"),
        (vk::Format::R16G16B16A16_SINT, "r16g16b16a16_sint"),
        (vk::Format::R8G8B8A8_SINT, "r8g8b8a8_sint"),
        (vk::Format::R32_SINT, "r32_sint"),
        (vk::Format::R8G8B8A8_UNORM, "r8g8b8a8_unorm"),
        (vk::Format::R8G8B8A8_SNORM, "r8g8b8a8_snorm"),
        (vk::Format::A8_UNORM, "a8_unorm"),
    ];

    let samples = [2, 4, 8, 16, 32, 64];

    let mut test_group = TestCaseGroup::new("load_store_multisample");

    for (base_texture, image_type_name) in textures {
        let mut image_view_group = TestCaseGroup::new(image_type_name);
        let num_layer_bind_modes = if base_texture.num_layers() == 1 { 1 } else { 2 };

        for (format, format_name) in formats {
            for layer_bind_mode in 0..num_layer_bind_modes {
                let single_layer_bind = layer_bind_mode != 0;
                let format_group_name =
                    format!("{format_name}{}", if single_layer_bind { "_single_layer" } else { "" });
                let mut format_group = TestCaseGroup::new(format_group_name);

                for num_samples in samples {
                    let case_def = CaseDef {
                        texture: Texture::with_samples(&base_texture, num_samples),
                        format,
                        format_name,
                        num_samples,
                        single_layer_bind,
                    };
                    format_group.add_child(Box::new(MultisampleLoadStoreCase {
                        name: format!("samples_{num_samples}"),
                        case_def,
                    }) as Box<dyn TestCase>);
                }
                image_view_group.add_child(format_group);
            }
        }
        test_group.add_child(image_view_group);
    }

    test_group
}
