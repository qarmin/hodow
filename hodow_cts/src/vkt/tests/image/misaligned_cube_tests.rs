// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageMisalignedCubeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shader is in shaders/manifest/image_misaligned_cube.toml.
//
// Two cube views of one 2D array image, the second starting on a layer that is not a multiple of six.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::image_misaligned_cube::MISALIGNED_CUBE_PROGRAMS;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::texture::map_vk_format;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set,
};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// `makeImageCreateInfo`
fn make_image_create_info(size: [u32; 3], format: vk::Format) -> vk::ImageCreateInfo {
    let usage = vk::ImageUsageFlags::STORAGE
        | vk::ImageUsageFlags::SAMPLED
        | vk::ImageUsageFlags::TRANSFER_SRC
        | vk::ImageUsageFlags::TRANSFER_DST;
    vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::CUBE_COMPATIBLE,
        image_type: vk::ImageType::_2D,
        format,
        extent: vk::Extent3D {
            width: size[0],
            height: size[1],
            depth: 1,
        },
        mip_levels: 1,
        array_layers: size[2],
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::OPTIMAL,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    }
}

/// `fillBuffer` - repeats one pixel of `color` over `size` bytes of the allocation, starting at `offset`.
fn fill_buffer(
    device: &Device,
    buffer: &BufferWithMemory<'_>,
    offset: vk::DeviceSize,
    size: vk::DeviceSize,
    format: vk::Format,
    color: [f32; 4],
) -> Result<(), TestError> {
    let texture_format =
        map_vk_format(format).ok_or_else(|| TestError::InternalError(format!("no texture format for {format:?}")))?;
    let color_pixel_size = texture_format
        .pixel_size()
        .ok_or_else(|| TestError::InternalError(format!("no pixel size for {format:?}")))?
        as usize;
    let mut color_pixel_buffer = TextureLevel::new(texture_format, 1, 1, 1)?;
    color_pixel_buffer.get_access().set_pixel(color, 0, 0, 0);

    let src = &color_pixel_buffer.data()[..color_pixel_size];
    let alloc = buffer.get_allocation();
    let dst = unsafe { alloc.get_host_ptr().add(offset as usize) };

    let mut pixel_pos = 0usize;
    while pixel_pos < size as usize {
        unsafe { std::ptr::copy_nonoverlapping(src.as_ptr(), dst.add(pixel_pos), color_pixel_size) };
        pixel_pos += color_pixel_size;
    }

    flush_alloc(device, alloc)
}

/// `makeBufferImageCopy`
fn make_buffer_image_copy(
    buffer_offset: vk::DeviceSize,
    image_subresource: vk::ImageSubresourceLayers,
    image_offset: vk::Offset3D,
    image_extent: vk::Extent3D,
) -> vk::BufferImageCopy {
    vk::BufferImageCopy {
        buffer_offset,
        buffer_row_length: 0,
        buffer_image_height: 0,
        image_subresource,
        image_offset,
        image_extent,
    }
}

/// `readVec4` - interpret the memory as a Vec4
fn read_vec4(data: *const u8, ndx: u32) -> [f32; 4] {
    let p = data.cast::<f32>();
    let ofs = 4 * ndx as usize;
    unsafe { [*p.add(ofs), *p.add(ofs + 1), *p.add(ofs + 2), *p.add(ofs + 3)] }
}

fn write_storage_image(
    device: &Device,
    descriptor_set: vk::DescriptorSet,
    binding: u32,
    image_info: &vk::DescriptorImageInfo,
) {
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

struct MisalignedCubeTest {
    name: String,
    size: [u32; 3],
}

impl TestCase for MisalignedCubeTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        MISALIGNED_CUBE_PROGRAMS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MisalignedCubeTestInstance {
            context,
            size: self.size,
            format: FORMAT,
        })
    }
}

struct MisalignedCubeTestInstance<'a> {
    context: &'a Context<'a>,
    size: [u32; 3],
    format: vk::Format,
}

impl TestInstance for MisalignedCubeTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        debug_assert!((6..=16).contains(&self.size[2]));
        debug_assert!(self.format == vk::Format::R8G8B8A8_UNORM);

        let vk = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let num_layers = self.size[2];
        let cube0_layer_start = 0u32;
        let cube1_layer_start = num_layers - 6;
        let result_buffer_size_bytes = (2 * 6 * 4 * std::mem::size_of::<f32>()) as vk::DeviceSize; // vec4[6] in shader
        let image_extent = vk::Extent3D {
            width: self.size[0],
            height: self.size[1],
            depth: 1,
        };
        let pixel_size = map_vk_format(self.format)
            .and_then(|f| f.pixel_size())
            .ok_or_else(|| TestError::InternalError("no pixel size".to_string()))?;
        let layer_size = image_extent.width * image_extent.height * pixel_size;
        let eps = 1.0f32 / (2 * 256) as f32;

        let result_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(result_buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let result_buffer_alloc = result_buffer.get_allocation();
        let image = ImageWithMemory::new(
            vk,
            allocator,
            make_image_create_info(self.size, self.format),
            MemoryRequirement::ANY,
        )?;
        let image_subresource_range0 =
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, cube0_layer_start, 6);
        let image_view0 = make_image_view(
            vk,
            image.get(),
            vk::ImageViewType::CUBE,
            self.format,
            image_subresource_range0,
        )?;
        let image_subresource_range1 =
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, cube1_layer_start, 6);
        let image_view1 = make_image_view(
            vk,
            image.get(),
            vk::ImageViewType::CUBE,
            self.format,
            image_subresource_range1,
        )?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 2)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;
        let descriptor_image_info0 = vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *image_view0,
            image_layout: vk::ImageLayout::GENERAL,
        };
        let descriptor_image_info1 = vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *image_view1,
            image_layout: vk::ImageLayout::GENERAL,
        };
        let descriptor_buffer_info = make_descriptor_buffer_info(result_buffer.get(), 0, result_buffer_size_bytes);

        let mut pipeline = ComputePipelineWrapper::new(
            vk,
            ComputePipelineConstructionType::Pipeline,
            self.context.get_binary_collection().get("comp")?,
        );
        pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline.build_pipeline()?;
        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let clear_buffer_size = vk::DeviceSize::from(layer_size) * vk::DeviceSize::from(num_layers);
        let clear_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(clear_buffer_size, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let clear_subres_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, num_layers);
        let clear_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            image.get(),
            clear_subres_range,
        );
        let pre_shader_image_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::GENERAL,
            image.get(),
            clear_subres_range,
        );
        let post_shader_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            result_buffer.get(),
            0,
            vk::WHOLE_SIZE,
        );
        let mut result = true;

        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set,
                Location::binding(2),
                vk::DescriptorType::STORAGE_BUFFER,
                &descriptor_buffer_info,
            )
            .update(vk);
        write_storage_image(vk, *descriptor_set, 0, &descriptor_image_info0);
        write_storage_image(vk, *descriptor_set, 1, &descriptor_image_info1);

        begin_command_buffer(vk, cmd)?;

        pipeline.bind(cmd);
        unsafe {
            vk.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                pipeline.get_pipeline_layout(),
                0,
                &[*descriptor_set],
                &[],
            );

            vk.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[clear_barrier],
            );
        }

        // Clear layers with predefined values
        for layer_ndx in 0..num_layers {
            let component_value = (16 * layer_ndx) as f32 / 255.0;
            let clear_color = [component_value, component_value, component_value, 1.0];
            let buffer_offset = vk::DeviceSize::from(layer_ndx) * vk::DeviceSize::from(layer_size);
            let image_subresource = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, layer_ndx, 1);
            let buffer_image_copy_region = make_buffer_image_copy(
                buffer_offset,
                image_subresource,
                vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent,
            );

            fill_buffer(
                vk,
                &clear_buffer,
                buffer_offset,
                vk::DeviceSize::from(layer_size),
                self.format,
                clear_color,
            )?;

            unsafe {
                vk.cmd_copy_buffer_to_image(
                    cmd,
                    clear_buffer.get(),
                    image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[buffer_image_copy_region],
                )
            };
        }

        unsafe {
            vk.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_shader_image_barrier],
            );

            vk.cmd_dispatch(cmd, 1, 1, 1);

            vk.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[post_shader_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vk, cmd)?;
        submit_commands_and_wait(vk, queue, cmd)?;

        invalidate_alloc(vk, result_buffer_alloc)?;

        let check_cube = |layer_start: u32, result_offset: u32| -> bool {
            let mut ok = true;
            for layer_ndx in 0..6u32 {
                let layer_used = layer_start + layer_ndx;
                let component_value = (16 * layer_used) as f32 / 255.0;
                let expected_color = [component_value, component_value, component_value, 1.0];
                let result_color = read_vec4(
                    result_buffer_alloc.get_host_ptr().cast_const(),
                    layer_ndx + result_offset,
                );

                if (0..4).any(|c| (expected_color[c] - result_color[c]).abs() > eps) {
                    ok = false;
                }
            }
            ok
        };

        // Check cube 0
        if !check_cube(cube0_layer_start, 0) {
            result = false;
        }

        // Check cube 1
        if !check_cube(cube1_layer_start, 6) {
            result = false;
        }

        if result {
            Ok(TestStatus::pass("pass"))
        } else {
            Ok(TestStatus::fail("fail"))
        }
    }
}

/// `createMisalignedCubeTests`
pub fn create_misaligned_cube_tests() -> TestCaseGroup {
    // Cube image with misaligned baseArrayLayer test cases
    let mut test_group = TestCaseGroup::new("misaligned_cube");

    // Base sizes used to generate actual image sizes in the test
    let base_image_sizes: [[u32; 3]; 5] = [[16, 16, 7], [16, 16, 8], [16, 16, 9], [16, 16, 10], [16, 16, 11]];

    for size in base_image_sizes {
        test_group.add_child(Box::new(MisalignedCubeTest {
            name: size[2].to_string(),
            size,
        }) as Box<dyn TestCase>);
    }

    test_group
}
