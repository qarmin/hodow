// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/binding_model/vktBindingImageAtomicTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the `descriptor_set` / `32bit`
// leaf is ported. `descriptor_buffer` and `descriptor_heap` need entry points and
// features of VK_EXT_descriptor_buffer / VK_EXT_descriptor_heap that the shared device
// does not enable, and `64bit` needs shaderImageInt64Atomics - the groups are left out
// rather than registered and skipped. The output buffer also drops the
// SHADER_DEVICE_ADDRESS usage upstream adds to every buffer: only the buffer-backed
// descriptor modes take an address of it.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_create_info, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_memory_barrier, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const DESCRIPTOR_COUNT: u32 = 128;

#[derive(Clone, Copy)]
pub struct ImageAtomicCase {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

impl TestCase for ImageAtomicCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_buffer_device_address")?;

        let mut vulkan12_features = vk::PhysicalDeviceVulkan12Features::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut vulkan12_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if vulkan12_features.runtime_descriptor_array == vk::FALSE {
            return Err(TestError::NotSupported(
                "runtimeDescriptorArray not supported".to_string(),
            ));
        }
        if vulkan12_features.shader_storage_image_array_non_uniform_indexing == vk::FALSE {
            return Err(TestError::NotSupported(
                "shaderStorageImageArrayNonUniformIndexing not supported".to_string(),
            ));
        }

        let format_features = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), vk::Format::R32_UINT)
        };
        if !format_features
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::STORAGE_IMAGE_ATOMIC)
        {
            return Err(TestError::NotSupported(
                "Format does not support storage image atomics".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageAtomicInstance { context })
    }
}

struct ImageAtomicInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for ImageAtomicInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let queue = self.context.get_universal_queue();
        let alloc = self.context.get_default_allocator();

        let image_format = vk::Format::R32_UINT;
        let descriptor_count = DESCRIPTOR_COUNT;
        let output_count = descriptor_count;
        let output_buffer_size = (output_count as usize * std::mem::size_of::<u32>()) as u64;

        let output_buffer = BufferWithMemory::new(
            vk,
            alloc,
            make_buffer_create_info(output_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let mut image_create_info = make_image_create_info(
            crate::tcu::IVec2::new(1, 1),
            image_format,
            vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::TRANSFER_SRC,
        );
        image_create_info.array_layers = descriptor_count;

        let image = ImageWithMemory::new(vk, alloc, image_create_info, MemoryRequirement::ANY)?;

        let mut image_views: Vec<Unique<'_, vk::ImageView>> = Vec::with_capacity(descriptor_count as usize);
        let mut image_infos: Vec<vk::DescriptorImageInfo> = Vec::with_capacity(descriptor_count as usize);
        for i in 0..descriptor_count {
            let view = make_image_view(
                vk,
                image.get(),
                vk::ImageViewType::_2D,
                image_format,
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, i, 1),
            )?;
            image_infos.push(vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *view,
                image_layout: vk::ImageLayout::GENERAL,
            });
            image_views.push(view);
        }

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(
                vk::DescriptorType::STORAGE_IMAGE,
                vk::ShaderStageFlags::COMPUTE,
                0,
                descriptor_count,
            )
            .build(vk)?;
        let pipeline_layout = make_pipeline_layout(vk, &[*descriptor_set_layout])?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, descriptor_count)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let write = vk::WriteDescriptorSet {
            s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
            next: std::ptr::null(),
            dst_set: descriptor_set.get(),
            dst_binding: 0,
            dst_array_element: 0,
            descriptor_count,
            descriptor_type: vk::DescriptorType::STORAGE_IMAGE,
            image_info: image_infos.as_ptr(),
            buffer_info: std::ptr::null(),
            texel_buffer_view: std::ptr::null(),
        };
        unsafe { vk.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        let shader_module = create_shader_module(vk, self.context.get_binary_collection().get("compute")?)?;

        let entry_point = b"main\0";
        let pipeline_create_info = vk::ComputePipelineCreateInfo {
            s_type: vk::StructureType::COMPUTE_PIPELINE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::PipelineCreateFlags::empty(),
            stage: vk::PipelineShaderStageCreateInfo {
                s_type: vk::StructureType::PIPELINE_SHADER_STAGE_CREATE_INFO,
                next: std::ptr::null(),
                flags: vk::PipelineShaderStageCreateFlags::empty(),
                stage: vk::ShaderStageFlags::COMPUTE,
                module: *shader_module,
                name: entry_point.as_ptr().cast(),
                specialization_info: std::ptr::null(),
            },
            layout: *pipeline_layout,
            base_pipeline_handle: vk::Pipeline::null(),
            base_pipeline_index: -1,
        };
        let pipelines =
            unsafe { vk.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_create_info], None) }
                .map_err(|e| TestError::InternalError(format!("vkCreateComputePipelines returned {e:?}")))?;
        let pipeline = Unique::new(vk, pipelines.0[0]);

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer.get();

        let image_subresource_range =
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, descriptor_count);

        begin_command_buffer(vk, cmd_buffer)?;

        let pre_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            image.get(),
            image_subresource_range,
        );

        let clear_color = vk::ClearColorValue { uint32: [0; 4] };
        unsafe {
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_barrier],
            );
            vk.cmd_clear_color_image(
                cmd_buffer,
                image.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &clear_color,
                &[image_subresource_range],
            );
        }

        let clear_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::SHADER_WRITE | vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::GENERAL,
            image.get(),
            image_subresource_range,
        );
        unsafe {
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[clear_barrier],
            );

            vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline);
            vk.cmd_bind_descriptor_sets(
                cmd_buffer,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[],
            );

            vk.cmd_dispatch(cmd_buffer, descriptor_count, 1, 1);
        }

        let image_barrier = make_image_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            image.get(),
            image_subresource_range,
        );
        let buffer_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);

        let copy_region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: descriptor_count,
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width: 1,
                height: 1,
                depth: 1,
            },
        };

        unsafe {
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier],
            );
            vk.cmd_copy_image_to_buffer(
                cmd_buffer,
                image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                output_buffer.get(),
                &[copy_region],
            );
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[buffer_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vk, cmd_buffer)?;
        submit_commands_and_wait(vk, queue, cmd_buffer)?;

        invalidate_alloc(vk, output_buffer.get_allocation())?;

        let expected = vec![0x89abcedfu32; output_count as usize];

        let result = output_buffer.get_allocation().get_host_ptr().cast::<u32>();
        for i in 0..output_count as usize {
            let got = unsafe { *result.add(i) };
            if got != expected[i] {
                log::info!("At index {i} expected {} but was {got}", expected[i]);
                return Ok(TestStatus::fail("Fail"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createImageAtomicTests`
pub fn create_image_atomic_tests() -> TestCaseGroup {
    use crate::generated::shaders::binding_model_image_atomic as g;

    let mut image_atomic_group = TestCaseGroup::new("image_atomic");

    let mut descriptor_type_group = TestCaseGroup::new("descriptor_set");
    descriptor_type_group.add_child(Box::new(g::IMAGE_ATOMIC_DESCRIPTOR_SET_32BIT) as Box<dyn TestCase>);
    image_atomic_group.add_child(descriptor_type_group);

    image_atomic_group
}
