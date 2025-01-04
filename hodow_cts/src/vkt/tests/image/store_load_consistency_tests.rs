// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageLoadStoreTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Of that file only `createImageStoreLoadConsistencyTests` is here. The shaders are in
// shaders/manifest/image_store_load_consistency.toml, one per case, the template of `StoreLoadConsistencyTest::initPrograms` with
// what its string map holds as parameters. `ImageWithBuffer` of vktImageTestsUtil is an image, its view and a host visible buffer
// built inline.
//
// A compute shader writes a checkerboard into a storage image, reads it back from that same image and writes what it read into a
// second one; the second image is copied to a buffer and compared with the checkerboard.

use vulkanalia::prelude::v1_0::*;

use super::tests_util::{ImageType, map_image_type, map_image_view_type};
use crate::generated::shaders::image_store_load_consistency::ALL_STORE_LOAD_CONSISTENCY_PROGRAMS;
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::texture::map_vk_format;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The `rust_type` of the manifest entries.
#[derive(Clone, Copy)]
pub struct StoreLoadConsistencyPrograms {
    pub name: &'static str,
    #[allow(dead_code)]
    pub image_qualifier: &'static str,
    #[allow(dead_code)]
    pub image_var_type: &'static str,
    #[allow(dead_code)]
    pub image_coord: &'static str,
    #[allow(dead_code)]
    pub color_to_assign: &'static str,
    pub programs: BinaryCollection,
}

struct StoreLoadConsistencyTest {
    name: String,
    image_type: ImageType,
    format: vk::Format,
}

impl TestCase for StoreLoadConsistencyTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_STORE_LOAD_CONSISTENCY_PROGRAMS
            .iter()
            .find(|p| p.name == self.name)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(StoreLoadConsistencyInstance {
            context,
            image_type: self.image_type,
            format: self.format,
        })
    }
}

struct StoreLoadConsistencyInstance<'a> {
    context: &'a Context<'a>,
    image_type: ImageType,
    format: vk::Format,
}

/// `ImageWithBuffer` of vktImageTestsUtil
struct ImageWithBuffer<'a> {
    image: ImageWithMemory<'a>,
    view: Unique<'a, vk::ImageView>,
    buffer: BufferWithMemory<'a>,
}

impl<'a> ImageWithBuffer<'a> {
    fn new(
        context: &'a Context<'a>,
        extent: vk::Extent3D,
        format: vk::Format,
        usage: vk::ImageUsageFlags,
        image_type: ImageType,
        ssr: vk::ImageSubresourceRange,
    ) -> Result<Self, TestError> {
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let info = vk::ImageCreateInfo::builder()
            .image_type(map_image_type(image_type))
            .format(format)
            .extent(extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let image = ImageWithMemory::new(device, alloc, info, MemoryRequirement::ANY)?;
        let view_type = map_image_view_type(image_type)
            .ok_or_else(|| TestError::NotPorted("a view type of a buffer image".to_string()))?;
        let view = make_image_view(device, image.get(), view_type, format, ssr)?;
        let pixel_size = map_vk_format(format)
            .and_then(|f| f.pixel_size())
            .ok_or_else(|| TestError::NotPorted(format!("pixel size of {format:?}")))?;
        let buffer_size = vk::DeviceSize::from(extent.width * extent.height * extent.depth * pixel_size);
        let buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        Ok(Self { image, view, buffer })
    }
}

impl TestInstance for StoreLoadConsistencyInstance<'_> {
    /// `StoreLoadConsistencyInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let vk = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();

        let usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::STORAGE;
        let image_extent = vk::Extent3D {
            width: 64,
            height: if self.image_type != ImageType::OneD { 64 } else { 1 },
            depth: if self.image_type == ImageType::ThreeD { 4 } else { 1 },
        };
        let ssr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let copy_region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: 1,
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent,
        };

        // create two storage images, one for writing and reading and one just for writing
        let src_image = ImageWithBuffer::new(context, image_extent, self.format, usage, self.image_type, ssr)?;
        let dst_image = ImageWithBuffer::new(context, image_extent, self.format, usage, self.image_type, ssr)?;

        let comp_stage = vk::ShaderStageFlags::COMPUTE;
        let desc_type = vk::DescriptorType::STORAGE_IMAGE;
        let descriptor_pool = DescriptorPoolBuilder::new().add_type(desc_type, 2).build(
            vk,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            2,
        )?;
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, comp_stage)
            .add_single_binding(desc_type, comp_stage)
            .build(vk)?;
        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        // update descriptor set
        let image_descriptor_infos = [
            vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *src_image.view,
                image_layout: vk::ImageLayout::GENERAL,
            },
            vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *dst_image.view,
                image_layout: vk::ImageLayout::GENERAL,
            },
        ];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(*descriptor_set)
                .dst_binding(0)
                .descriptor_type(desc_type)
                .image_info(&image_descriptor_infos[..1]),
            vk::WriteDescriptorSet::builder()
                .dst_set(*descriptor_set)
                .dst_binding(1)
                .descriptor_type(desc_type)
                .image_info(&image_descriptor_infos[1..]),
        ];
        unsafe { vk.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let pipeline_layout = make_pipeline_layout(vk, &[*descriptor_set_layout])?;

        let compute_module = create_shader_module(vk, context.get_binary_collection().get("comp")?)?;

        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(comp_stage)
            .module(*compute_module)
            .name(b"main\0");
        let pipeline_create_info = vk::ComputePipelineCreateInfo::builder()
            .stage(*stage)
            .layout(*pipeline_layout);
        let pipelines =
            unsafe { vk.create_compute_pipelines(vk::PipelineCache::null(), &[*pipeline_create_info], None) }
                .vk_check("vkCreateComputePipelines")?;
        let compute_pipeline = Unique::new(vk, pipelines.0[0]);

        let image_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            src_image.image.get(),
            ssr,
        );
        let mut image_barriers = [image_barrier, image_barrier];
        image_barriers[1].image = dst_image.image.get();

        let bp = vk::PipelineBindPoint::COMPUTE;
        let command_pool = make_command_pool(vk, queue_family_index)?;
        let command_buffer = allocate_command_buffer(vk, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = *command_buffer;

        begin_command_buffer(vk, cmd_buffer)?;

        unsafe {
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &image_barriers,
            );

            vk.cmd_bind_pipeline(cmd_buffer, bp, *compute_pipeline);
            vk.cmd_bind_descriptor_sets(cmd_buffer, bp, *pipeline_layout, 0, &[*descriptor_set], &[] as &[u32]);
            vk.cmd_dispatch(cmd_buffer, image_extent.width, image_extent.height, image_extent.depth);
        }

        image_barriers[1].src_access_mask = vk::AccessFlags::SHADER_WRITE;
        image_barriers[1].dst_access_mask = vk::AccessFlags::TRANSFER_READ;
        unsafe {
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &image_barriers[1..],
            );

            vk.cmd_copy_image_to_buffer(
                cmd_buffer,
                dst_image.image.get(),
                vk::ImageLayout::GENERAL,
                dst_image.buffer.get(),
                &[copy_region],
            );
        }

        end_command_buffer(vk, cmd_buffer)?;
        submit_commands_and_wait(vk, queue, cmd_buffer)?;

        let buffer_allocation = dst_image.buffer.get_allocation();
        invalidate_alloc(vk, buffer_allocation)?;
        let tex_format = map_vk_format(self.format)
            .ok_or_else(|| TestError::NotPorted(format!("tcu format of {:?}", self.format)))?;
        let pixel_size = tex_format
            .pixel_size()
            .ok_or_else(|| TestError::NotPorted(format!("pixel size of {:?}", self.format)))?
            as usize;
        let data = unsafe {
            std::slice::from_raw_parts(
                buffer_allocation.get_host_ptr().cast_const(),
                image_extent.width as usize * image_extent.height as usize * image_extent.depth as usize * pixel_size,
            )
        };
        let result_access = ConstPixelBufferAccess::new(
            tex_format,
            [image_extent.width, image_extent.height, image_extent.depth],
            data,
        );

        let mut expected_pixel: [[i32; 4]; 2] = [[0, 0, 255, 255], [255, 0, 0, 255]];
        if self.format == vk::Format::R32_SINT {
            expected_pixel = [[0, 0, 0, 1], [255, 0, 0, 1]];
        } else if self.format == vk::Format::R32G32B32A32_SFLOAT {
            expected_pixel = [[0, 0, 1, 1], [1, 0, 0, 1]];
        }

        // generate same checkerboard pattern and compare with the result from shader
        for z in 0..image_extent.depth {
            for y in 0..image_extent.height {
                for x in 0..image_extent.width {
                    if result_access.get_pixel_int(x, y, z) == expected_pixel[((x / 2 + y / 2 + z / 2) % 2) as usize] {
                        continue;
                    }

                    return Ok(TestStatus::fail(format!("Fail at {x},{y},{z}")));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createImageStoreLoadConsistencyTests`
pub fn create_image_store_load_consistency_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("store_load_consistency");

    let cases = [
        ("1d", ImageType::OneD, vk::Format::R32G32B32A32_SFLOAT),
        ("2d", ImageType::TwoD, vk::Format::R32_SINT),
        ("3d", ImageType::ThreeD, vk::Format::R8G8B8A8_UNORM),
    ];

    for (name, image_type, format) in cases {
        test_group.add_child(Box::new(StoreLoadConsistencyTest {
            name: name.to_string(),
            image_type,
            format,
        }) as Box<dyn TestCase>);
    }

    test_group
}
