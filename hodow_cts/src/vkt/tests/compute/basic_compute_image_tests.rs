// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/compute/vktComputeBasicComputeShaderTests.cpp
//   (CopyImageToSSBOTest, CopySSBOToImageTest, ImageAtomicOpTest, ImageBarrierTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Split out of
// basic_compute_shader_tests.rs because these are the cases that need the image side
// of the vk layer; upstream keeps them in the one file.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::{IVec2, Random, TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper, check_shader_object_requirements};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_create_info, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool, make_descriptor_buffer_info, make_descriptor_set,
};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The format every one of these tests uses for its storage image.
const IMAGE_FORMAT: vk::Format = vk::Format::R32_UINT;

/// `vk::makeDescriptorImageInfo` for a storage image bound in the GENERAL layout.
fn make_descriptor_image_info(image_view: vk::ImageView, image_layout: vk::ImageLayout) -> vk::DescriptorImageInfo {
    vk::DescriptorImageInfo {
        sampler: vk::Sampler::null(),
        image_view,
        image_layout,
    }
}

/// Adds a storage-image descriptor write. `DescriptorSetUpdateBuilder` only carries
/// buffer infos, so image writes go through their own call.
fn write_storage_image(device: &Device, descriptor_set: vk::DescriptorSet, binding: u32, image_info: &vk::DescriptorImageInfo) {
    let write = vk::WriteDescriptorSet {
        s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
        next: std::ptr::null(),
        dst_set: descriptor_set,
        dst_binding: binding,
        dst_array_element: 0,
        descriptor_count: 1,
        descriptor_type: vk::DescriptorType::STORAGE_IMAGE,
        image_info,
        buffer_info: std::ptr::null(),
        texel_buffer_view: std::ptr::null(),
    };
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
}

/// `vk::copyBufferToImage`, narrowed to the single-region 2D case these tests use.
///
/// Transitions UNDEFINED -> TRANSFER_DST, copies, then TRANSFER_DST -> GENERAL, which
/// is the layout the compute shader reads and writes the image in.
fn copy_buffer_to_image(vk: &Device, cmd_buffer: vk::CommandBuffer, buffer: vk::Buffer, image: vk::Image, extent: vk::Extent3D) {
    let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let subresource_layers = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);

    let pre_copy_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::TRANSFER_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        image,
        subresource_range,
    );
    let post_copy_barrier = make_image_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::SHADER_READ,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        vk::ImageLayout::GENERAL,
        image,
        subresource_range,
    );

    unsafe {
        vk.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre_copy_barrier],
        );

        let region = make_buffer_image_copy(extent, subresource_layers);
        vk.cmd_copy_buffer_to_image(cmd_buffer, buffer, image, vk::ImageLayout::TRANSFER_DST_OPTIMAL, &[region]);

        vk.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[post_copy_barrier],
        );
    }
}

/// Moves an image from UNDEFINED straight to GENERAL, for tests that write it first.
fn transition_to_general(vk: &Device, cmd_buffer: vk::CommandBuffer, image: vk::Image, dst_access: vk::AccessFlags) {
    let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        dst_access,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::GENERAL,
        image,
        subresource_range,
    );
    unsafe {
        vk.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        );
    }
}

/// Copies the image back into a host-visible buffer so the result can be checked.
fn copy_image_to_buffer(vk: &Device, cmd_buffer: vk::CommandBuffer, image: vk::Image, buffer: vk::Buffer, extent: vk::Extent3D, size: u64) {
    let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let subresource_layers = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);

    let pre_copy_barrier = make_image_memory_barrier(
        vk::AccessFlags::SHADER_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::GENERAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        subresource_range,
    );
    let post_copy_barrier = make_buffer_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ, buffer, 0, size);

    unsafe {
        vk.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre_copy_barrier],
        );

        let region = make_buffer_image_copy(extent, subresource_layers);
        vk.cmd_copy_image_to_buffer(cmd_buffer, image, vk::ImageLayout::TRANSFER_SRC_OPTIMAL, buffer, &[region]);

        vk.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[post_copy_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

fn extent_of(size: IVec2) -> vk::Extent3D {
    vk::Extent3D {
        width: size.x() as u32,
        height: size.y() as u32,
        depth: 1,
    }
}

fn multiply_components2(v: IVec2) -> i32 {
    v.x() * v.y()
}

// ---------------------------------------------------------------------------------
// CopyImageToSSBOTest
// ---------------------------------------------------------------------------------

#[derive(Clone, Copy)]
pub struct CopyImageToSsboCase {
    pub name: &'static str,
    pub local_size: IVec2,
    pub image_size: IVec2,
    pub programs: BinaryCollection,
}

impl TestCase for CopyImageToSsboCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CopyImageToSsboInstance {
            context,
            local_size: self.local_size,
            image_size: self.image_size,
        })
    }
}

struct CopyImageToSsboInstance<'a> {
    context: &'a Context<'a>,
    local_size: IVec2,
    image_size: IVec2,
}

impl TestInstance for CopyImageToSsboInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let allocator = self.context.get_default_allocator();

        let image_params = make_image_create_info(self.image_size, IMAGE_FORMAT, vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::STORAGE);
        let image = ImageWithMemory::new(vk, allocator, image_params, MemoryRequirement::ANY)?;
        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let image_view = make_image_view(vk, image.get(), vk::ImageViewType::_2D, IMAGE_FORMAT, subresource_range)?;

        let image_area = multiply_components2(self.image_size) as u32;
        let buffer_size_bytes = std::mem::size_of::<u32>() as u64 * image_area as u64;

        let staging_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let mut reference: Vec<u32> = Vec::with_capacity(image_area as usize);
        {
            let mut rnd = Random::new(0xab2c7);
            let staging_buffer_allocation = staging_buffer.get_allocation();
            let buffer_ptr = staging_buffer_allocation.get_host_ptr().cast::<u32>();
            for i in 0..image_area {
                let value = rnd.get_uint32();
                reference.push(value);
                unsafe { *buffer_ptr.add(i as usize) = value };
            }
            flush_alloc(vk, staging_buffer_allocation)?;
        }

        let output_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let image_descriptor_info = make_descriptor_image_info(*image_view, vk::ImageLayout::GENERAL);
        let buffer_descriptor_info = make_descriptor_buffer_info(output_buffer.get(), 0, buffer_size_bytes);
        DescriptorSetUpdateBuilder::new()
            .write_single(*descriptor_set, Location::binding(0), vk::DescriptorType::STORAGE_BUFFER, &buffer_descriptor_info)
            .update(vk);
        write_storage_image(vk, *descriptor_set, 1, &image_descriptor_info);

        {
            let mut pipeline = ComputePipelineWrapper::new(vk, ComputePipelineConstructionType::Pipeline, self.context.get_binary_collection().get("comp")?);
            pipeline.set_descriptor_set_layout(*descriptor_set_layout);
            pipeline.build_pipeline()?;

            let compute_finish_barrier = make_buffer_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ, output_buffer.get(), 0, buffer_size_bytes);

            let work_size = IVec2::new(self.image_size.x() / self.local_size.x(), self.image_size.y() / self.local_size.y());

            let cmd_pool = make_command_pool(vk, queue_family_index)?;
            let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

            begin_command_buffer(vk, *cmd_buffer)?;

            pipeline.bind(*cmd_buffer);
            unsafe {
                vk.cmd_bind_descriptor_sets(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline.get_pipeline_layout(), 0, &[*descriptor_set], &[]);
            }

            copy_buffer_to_image(vk, *cmd_buffer, staging_buffer.get(), image.get(), extent_of(self.image_size));

            unsafe {
                vk.cmd_dispatch(*cmd_buffer, work_size.x() as u32, work_size.y() as u32, 1);
                vk.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[compute_finish_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }

            end_command_buffer(vk, *cmd_buffer)?;
            submit_commands_and_wait(vk, queue, *cmd_buffer)?;
        }

        let output_buffer_allocation = output_buffer.get_allocation();
        invalidate_alloc(vk, output_buffer_allocation)?;
        let buffer_ptr = output_buffer_allocation.get_host_ptr().cast::<u32>();

        for ndx in 0..image_area {
            let res = unsafe { *buffer_ptr.add(ndx as usize) };
            let reference_value = reference[ndx as usize];
            if res != reference_value {
                return Ok(TestStatus::fail(format!("Comparison failed for Output.values[{ndx}]")));
            }
        }
        Ok(TestStatus::pass("Compute succeeded"))
    }
}

// ---------------------------------------------------------------------------------
// CopySSBOToImageTest
// ---------------------------------------------------------------------------------

#[derive(Clone, Copy)]
pub struct CopySsboToImageCase {
    pub name: &'static str,
    pub local_size: IVec2,
    pub image_size: IVec2,
    pub programs: BinaryCollection,
}

impl TestCase for CopySsboToImageCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CopySsboToImageInstance {
            context,
            local_size: self.local_size,
            image_size: self.image_size,
        })
    }
}

struct CopySsboToImageInstance<'a> {
    context: &'a Context<'a>,
    local_size: IVec2,
    image_size: IVec2,
}

impl TestInstance for CopySsboToImageInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let allocator = self.context.get_default_allocator();

        let image_params = make_image_create_info(self.image_size, IMAGE_FORMAT, vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::STORAGE);
        let image = ImageWithMemory::new(vk, allocator, image_params, MemoryRequirement::ANY)?;
        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let image_view = make_image_view(vk, image.get(), vk::ImageViewType::_2D, IMAGE_FORMAT, subresource_range)?;

        let image_area = multiply_components2(self.image_size) as u32;
        let buffer_size_bytes = std::mem::size_of::<u32>() as u64 * image_area as u64;

        let input_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let mut reference: Vec<u32> = Vec::with_capacity(image_area as usize);
        {
            let mut rnd = Random::new(0x77238ac2);
            let input_buffer_allocation = input_buffer.get_allocation();
            let buffer_ptr = input_buffer_allocation.get_host_ptr().cast::<u32>();
            for i in 0..image_area {
                let value = rnd.get_uint32();
                reference.push(value);
                unsafe { *buffer_ptr.add(i as usize) = value };
            }
            flush_alloc(vk, input_buffer_allocation)?;
        }

        let output_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let image_descriptor_info = make_descriptor_image_info(*image_view, vk::ImageLayout::GENERAL);
        let buffer_descriptor_info = make_descriptor_buffer_info(input_buffer.get(), 0, buffer_size_bytes);
        DescriptorSetUpdateBuilder::new()
            .write_single(*descriptor_set, Location::binding(0), vk::DescriptorType::STORAGE_BUFFER, &buffer_descriptor_info)
            .update(vk);
        write_storage_image(vk, *descriptor_set, 1, &image_descriptor_info);

        {
            let mut pipeline = ComputePipelineWrapper::new(vk, ComputePipelineConstructionType::Pipeline, self.context.get_binary_collection().get("comp")?);
            pipeline.set_descriptor_set_layout(*descriptor_set_layout);
            pipeline.build_pipeline()?;

            let host_write_barrier = make_buffer_memory_barrier(vk::AccessFlags::HOST_WRITE, vk::AccessFlags::SHADER_READ, input_buffer.get(), 0, buffer_size_bytes);

            let work_size = IVec2::new(self.image_size.x() / self.local_size.x(), self.image_size.y() / self.local_size.y());

            let cmd_pool = make_command_pool(vk, queue_family_index)?;
            let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

            begin_command_buffer(vk, *cmd_buffer)?;

            pipeline.bind(*cmd_buffer);
            unsafe {
                vk.cmd_bind_descriptor_sets(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline.get_pipeline_layout(), 0, &[*descriptor_set], &[]);
            }

            transition_to_general(vk, *cmd_buffer, image.get(), vk::AccessFlags::SHADER_WRITE);

            unsafe {
                vk.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[host_write_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
                vk.cmd_dispatch(*cmd_buffer, work_size.x() as u32, work_size.y() as u32, 1);
            }

            copy_image_to_buffer(vk, *cmd_buffer, image.get(), output_buffer.get(), extent_of(self.image_size), buffer_size_bytes);

            end_command_buffer(vk, *cmd_buffer)?;
            submit_commands_and_wait(vk, queue, *cmd_buffer)?;
        }

        let output_buffer_allocation = output_buffer.get_allocation();
        invalidate_alloc(vk, output_buffer_allocation)?;
        let buffer_ptr = output_buffer_allocation.get_host_ptr().cast::<u32>();

        for ndx in 0..image_area {
            let res = unsafe { *buffer_ptr.add(ndx as usize) };
            let reference_value = reference[ndx as usize];
            if res != reference_value {
                return Ok(TestStatus::fail(format!("Comparison failed for pixel {ndx}")));
            }
        }
        Ok(TestStatus::pass("Compute succeeded"))
    }
}

// ---------------------------------------------------------------------------------
// createBasicComputeImageTests
// ---------------------------------------------------------------------------------

/// Registers the image-backed cases of `createBasicComputeShaderTests`.
///
/// ImageAtomicOpTest and ImageBarrierTest have their shaders generated already but
/// their instances are not written yet, so they are absent rather than registered and
/// failing.
pub fn add_basic_compute_image_tests(group: &mut TestCaseGroup) {
    use crate::generated::shaders::compute_basic_images as g;

    // Image to SSBO copy
    group.add_child(Box::new(g::COPY_IMAGE_TO_SSBO_SMALL) as Box<dyn TestCase>);
    group.add_child(Box::new(g::COPY_IMAGE_TO_SSBO_LARGE) as Box<dyn TestCase>);

    // SSBO to image copy
    group.add_child(Box::new(g::COPY_SSBO_TO_IMAGE_SMALL) as Box<dyn TestCase>);
    group.add_child(Box::new(g::COPY_SSBO_TO_IMAGE_LARGE) as Box<dyn TestCase>);
}
