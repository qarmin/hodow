// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/data/vulkan/amber/spirv_assembly/instruction/image_query/samples_storage.amber
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmInstructionTests.cpp (createQueryGroup)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. What Amber does for the script is done directly: a 256x256 four-sample RGBA8 storage image in
// GENERAL layout at binding 0, an int storage buffer at binding 1, one workgroup, and the buffer must hold 4 afterwards (OpImageQuerySamples on
// a storage image). The case also asks for the image format to support four-sample storage use, which Amber leaves to image creation.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::spirv_assembly_image_query::*;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const IMAGE_SIZE: u32 = 256;
const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

fn image_create_info() -> vk::ImageCreateInfo {
    vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(FORMAT)
        .extent(vk::Extent3D {
            width: IMAGE_SIZE,
            height: IMAGE_SIZE,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_4)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::STORAGE)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build()
}

struct SamplesStorageCase;

impl TestCase for SamplesStorageCase {
    fn name(&self) -> &str {
        "samples_storage"
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().shader_storage_image_multisample == vk::FALSE {
            return Err(TestError::NotSupported(
                "Features.shaderStorageImageMultisample not supported".to_string(),
            ));
        }
        let info = image_create_info();
        let properties = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                info.format,
                info.image_type,
                info.tiling,
                info.usage,
                info.flags,
            )
        };
        match properties {
            Ok(properties) if properties.sample_counts.contains(vk::SampleCountFlags::_4) => Ok(()),
            Ok(_) | Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => Err(TestError::NotSupported(
                "4-sample storage image of R8G8B8A8_UNORM not supported".to_string(),
            )),
            Err(error) => Err(TestError::Fail(format!(
                "vkGetPhysicalDeviceImageFormatProperties: {error:?}"
            ))),
        }
    }

    fn programs(&self) -> BinaryCollection {
        IMAGE_QUERY.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SamplesStorageInstance { context })
    }
}

struct SamplesStorageInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for SamplesStorageInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();

        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let image = ImageWithMemory::new(device, allocator, image_create_info(), MemoryRequirement::ANY)?;
        let view = make_image_view(device, image.get(), vk::ImageViewType::_2D, FORMAT, range)?;
        let buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(4, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0, 4) };
        flush_alloc(device, buffer.get_allocation())?;

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;
        let pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let set = make_descriptor_set(device, *pool, *set_layout)?;
        let image_infos = [vk::DescriptorImageInfo::builder()
            .image_view(*view)
            .image_layout(vk::ImageLayout::GENERAL)
            .build()];
        let buffer_infos = [vk::DescriptorBufferInfo::builder()
            .buffer(buffer.get())
            .offset(0)
            .range(vk::WHOLE_SIZE)
            .build()];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(set.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&image_infos)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(set.get())
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&buffer_infos)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let binaries = context.get_binary_collection();
        let module = create_shader_module(device, binaries.get("compute")?)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*module)
            .name(b"main\0")
            .build();
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(0)
            .build();
        let pipeline = Unique::new(
            device,
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?
                .0[0],
        );

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd)?;
        let barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            image.get(),
            range,
        );
        let host_barrier = vk::MemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::SHADER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .build();
        unsafe {
            device.cmd_pipeline_barrier(
                *cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
            device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
            device.cmd_bind_descriptor_sets(
                *cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[set.get()],
                &[] as &[u32],
            );
            device.cmd_dispatch(*cmd, 1, 1, 1);
            device.cmd_pipeline_barrier(
                *cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[host_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, *cmd)?;
        submit_commands_and_wait(device, queue, *cmd)?;

        invalidate_alloc(device, buffer.get_allocation())?;
        let samples =
            unsafe { std::ptr::read_unaligned(buffer.get_allocation().get_host_ptr().cast_const().cast::<i32>()) };
        if samples != 4 {
            return Ok(TestStatus::fail(format!(
                "OpImageQuerySamples returned {samples}, expected 4"
            )));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createQueryGroup`
pub fn create_query_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("image_query");
    group.add_child(Box::new(SamplesStorageCase) as Box<dyn crate::vkt::TestCase>);
    group
}
