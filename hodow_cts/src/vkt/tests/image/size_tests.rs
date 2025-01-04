// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageSizeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are in shaders/manifest/image_size.toml, one per
// (image type, access qualifiers, 2D view of 3D); the three instance classes (`SizeTestInstance`, `ImageSizeTestInstance`,
// `BufferSizeTestInstance`) become one function that branches on the buffer type.

use vulkanalia::prelude::v1_0::*;

use super::image_texture::Texture;
use super::tests_util::{ImageType, get_image_size_bytes, get_image_type_name, map_image_type, map_image_view_type};
use crate::generated::shaders::image_size::ALL_IMAGE_SIZE_PROGRAMS;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set,
};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FLAG_READONLY_IMAGE: u32 = 1 << 0;
const FLAG_WRITEONLY_IMAGE: u32 = 1 << 1;

/// The `rust_type` of the manifest entries: the program of one (image type, flags, 2D view of 3D) combination.
#[derive(Clone, Copy)]
pub struct ImageSizePrograms {
    pub name: &'static str,
    pub kind: &'static str,
    pub flags: u32,
    pub view_2d: bool,
    #[allow(dead_code)]
    pub access: &'static str,
    #[allow(dead_code)]
    pub glsl_type: &'static str,
    #[allow(dead_code)]
    pub body: &'static str,
    pub programs: BinaryCollection,
}

/// `getTexture` - get a texture based on image type and suggested size.
fn get_texture(image_type: ImageType, size: [i32; 3]) -> Texture {
    match image_type {
        ImageType::OneD | ImageType::Buffer => Texture::simple(image_type, [size[0], 1, 1], 1),
        ImageType::OneDArray => Texture::simple(image_type, [size[0], 1, 1], size[1]),
        ImageType::TwoD => Texture::simple(image_type, [size[0], size[1], 1], 1),
        ImageType::TwoDArray => Texture::simple(image_type, [size[0], size[1], 1], size[2]),
        ImageType::Cube => Texture::simple(image_type, [size[0], size[0], 1], 6),
        ImageType::CubeArray => Texture::simple(image_type, [size[0], size[0], 1], 2 * 6),
        ImageType::ThreeD => Texture::simple(image_type, size, 1),
    }
}

/// `makeImageCreateInfo`
fn make_image_create_info(texture: &Texture, format: vk::Format, is_2d_view_of_3d: bool) -> vk::ImageCreateInfo {
    let mut create_flags = vk::ImageCreateFlags::empty();

    if texture.is_cube() {
        create_flags |= vk::ImageCreateFlags::CUBE_COMPATIBLE;
    } else if is_2d_view_of_3d {
        // VUID-VkImageMemoryBarrier-subresourceRange-01725
        create_flags |= vk::ImageCreateFlags::_2D_VIEW_COMPATIBLE_EXT | vk::ImageCreateFlags::_2D_ARRAY_COMPATIBLE;
    }

    let layer_size = texture.layer_size(0);
    vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: create_flags,
        image_type: map_image_type(texture.type_()),
        format,
        extent: vk::Extent3D {
            width: layer_size[0] as u32,
            height: layer_size[1] as u32,
            depth: layer_size[2] as u32,
        },
        mip_levels: 1,
        array_layers: texture.num_layers() as u32,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::OPTIMAL,
        usage: vk::ImageUsageFlags::STORAGE,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    }
}

/// `readIVec3` - interpret the memory as an IVec3
fn read_ivec3(data: *const u8) -> [i32; 3] {
    let p = data.cast::<i32>();
    unsafe { [*p, *p.add(1), *p.add(2)] }
}

/// `getExpectedImageSizeResult`
fn get_expected_image_size_result(texture: &Texture, is_2d_view_of_3d: bool) -> [i32; 3] {
    // GLSL imageSize() function returns:
    // z = 0 for cubes
    // z = N for cube arrays, where N is the number of cubes
    // y or z = L where L is the number of layers for other array types (e.g. 1D array, 2D array)
    // z = D where D is the depth of 3d image

    let size = texture.size(0);
    let num_cube_faces = 6;

    match texture.type_() {
        ImageType::OneD | ImageType::Buffer => [size[0], 0, 0],
        ImageType::OneDArray | ImageType::TwoD | ImageType::Cube => [size[0], size[1], 0],
        ImageType::TwoDArray | ImageType::ThreeD => {
            if is_2d_view_of_3d {
                return [size[0], size[1], 0];
            }
            size
        }
        ImageType::CubeArray => [size[0], size[1], size[2] / num_cube_faces],
    }
}

struct SizeTest {
    name: String,
    texture: Texture,
    format: vk::Format,
    flags: u32,
    is_2d_view_of_3d: bool,
}

impl TestCase for SizeTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let img_type = self.texture.type_();

        if img_type == ImageType::CubeArray && context.get_device_features().image_cube_array == vk::FALSE {
            return Err(TestError::NotSupported("imageCubeArray not supported".to_string()));
        }

        // VUID-vkGetPhysicalDeviceImageFormatProperties-flags-parameter
        if self.is_2d_view_of_3d {
            context.require_device_functionality("VK_EXT_image_2d_view_of_3d")?;
        }

        if img_type != ImageType::Buffer {
            let create_info = make_image_create_info(&self.texture, self.format, self.is_2d_view_of_3d);

            let result = unsafe {
                context.get_instance().get_physical_device_image_format_properties(
                    context.get_physical_device(),
                    create_info.format,
                    create_info.image_type,
                    create_info.tiling,
                    create_info.usage,
                    create_info.flags,
                )
            };

            if let Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) = result {
                return Err(TestError::NotSupported(
                    "Format not supported for the specified usage".to_string(),
                ));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let kind = get_image_type_name(self.texture.type_());
        ALL_IMAGE_SIZE_PROGRAMS
            .iter()
            .find(|p| p.kind == kind && p.flags == self.flags && p.view_2d == self.is_2d_view_of_3d)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SizeTestInstance {
            context,
            texture: self.texture,
            format: self.format,
            is_2d_view_of_3d: self.is_2d_view_of_3d,
        })
    }
}

struct SizeTestInstance<'a> {
    context: &'a Context<'a>,
    texture: Texture,
    format: vk::Format,
    is_2d_view_of_3d: bool,
}

impl TestInstance for SizeTestInstance<'_> {
    /// `SizeTestInstance::iterate`, with the image or buffer side of `prepareDescriptors` and `commandBeforeCompute` inline.
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let is_buffer = self.texture.type_() == ImageType::Buffer;

        let result_buffer_size_bytes = (3 * std::mem::size_of::<u32>()) as vk::DeviceSize; // ivec3 in shader

        // Create an SSBO for shader output
        let result_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(result_buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // An image or a texel buffer, whose data will be uninitialized as the test does not read from it
        let image = if is_buffer {
            None
        } else {
            Some(ImageWithMemory::new(
                vk,
                allocator,
                make_image_create_info(&self.texture, self.format, self.is_2d_view_of_3d),
                MemoryRequirement::ANY,
            )?)
        };
        let image_view = match &image {
            Some(image) => {
                let base_layer = if self.is_2d_view_of_3d {
                    (self.texture.size(0)[2] / 2) as u32
                } else {
                    0
                };
                let view_type = if self.is_2d_view_of_3d {
                    vk::ImageViewType::_2D
                } else {
                    map_image_view_type(self.texture.type_())
                        .ok_or_else(|| TestError::InternalError("no view type for the image type".to_string()))?
                };
                let subresource_range = make_image_subresource_range(
                    vk::ImageAspectFlags::COLOR,
                    0,
                    1,
                    base_layer,
                    self.texture.num_layers() as u32,
                );
                Some(make_image_view(
                    vk,
                    image.get(),
                    view_type,
                    self.format,
                    subresource_range,
                )?)
            }
            None => None,
        };

        let image_size_bytes = if is_buffer {
            get_image_size_bytes(self.texture.size(0), self.format)
                .ok_or_else(|| TestError::InternalError("no pixel size".to_string()))?
        } else {
            0
        };
        let image_buffer = if is_buffer {
            Some(BufferWithMemory::new(
                vk,
                allocator,
                make_buffer_create_info(image_size_bytes, vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER),
                MemoryRequirement::ANY,
            )?)
        } else {
            None
        };
        let buffer_view = match &image_buffer {
            Some(buffer) => {
                let info = vk::BufferViewCreateInfo::builder()
                    .buffer(buffer.get())
                    .format(self.format)
                    .offset(0)
                    .range(image_size_bytes);
                Some(Unique::new(
                    vk,
                    unsafe { vk.create_buffer_view(&info, None) }.vk_check("vkCreateBufferView")?,
                ))
            }
            None => None,
        };

        let first_descriptor_type = if is_buffer {
            vk::DescriptorType::STORAGE_TEXEL_BUFFER
        } else {
            vk::DescriptorType::STORAGE_IMAGE
        };
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(first_descriptor_type, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(first_descriptor_type, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let descriptor_buffer_info = make_descriptor_buffer_info(result_buffer.get(), 0, result_buffer_size_bytes);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set,
                Location::binding(1),
                vk::DescriptorType::STORAGE_BUFFER,
                &descriptor_buffer_info,
            )
            .update(vk);

        let image_info = image_view.as_ref().map(|view| {
            [vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: **view,
                image_layout: vk::ImageLayout::GENERAL,
            }]
        });
        let texel_buffer_views = buffer_view.as_ref().map(|view| [**view]);
        let mut first_write = vk::WriteDescriptorSet::builder()
            .dst_set(*descriptor_set)
            .dst_binding(0)
            .descriptor_type(first_descriptor_type);
        if let Some(info) = &image_info {
            first_write = first_write.image_info(info);
        }
        if let Some(views) = &texel_buffer_views {
            first_write = first_write.texel_buffer_view(views);
        }
        unsafe { vk.update_descriptor_sets(&[first_write.build()], &[] as &[vk::CopyDescriptorSet]) };

        // Create memory barriers
        let shader_write_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            result_buffer.get(),
            0,
            result_buffer_size_bytes,
        );

        // Create the pipeline
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
            )
        };

        // `commandBeforeCompute` of the image variant
        if let Some(image) = &image {
            // VUID-vkCmdDraw-None-09600
            let subresource_range = make_image_subresource_range(
                vk::ImageAspectFlags::COLOR,
                0,
                vk::REMAINING_MIP_LEVELS,
                0,
                vk::REMAINING_ARRAY_LAYERS,
            );
            let barrier_set_image_layout = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                image.get(),
                subresource_range,
            );

            unsafe {
                vk.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier_set_image_layout],
                );
            }
        }

        unsafe {
            vk.cmd_dispatch(cmd, 1, 1, 1);
            vk.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[shader_write_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vk, cmd)?;

        submit_commands_and_wait(vk, queue, cmd)?;

        // Compare the result
        let buffer_alloc = result_buffer.get_allocation();
        invalidate_alloc(vk, buffer_alloc)?;

        let result_size = read_ivec3(buffer_alloc.get_host_ptr().cast_const());
        let expected_size = get_expected_image_size_result(&self.texture, self.is_2d_view_of_3d);

        if result_size != expected_size {
            Ok(TestStatus::fail(format!(
                "Incorrect imageSize(): expected ({}, {}, {}) but got ({}, {}, {})",
                expected_size[0], expected_size[1], expected_size[2], result_size[0], result_size[1], result_size[2]
            )))
        } else {
            Ok(TestStatus::pass("Passed"))
        }
    }
}

/// `getCaseName` - build a case name, e.g. "readonly_writeonly_32x32"
fn get_case_name(texture: &Texture, flags: u32, is_2d_view_of_3d: bool) -> String {
    let mut name = String::new();
    if flags & FLAG_READONLY_IMAGE != 0 {
        name.push_str("readonly_");
    }
    if flags & FLAG_WRITEONLY_IMAGE != 0 {
        name.push_str("writeonly_");
    }

    if is_2d_view_of_3d {
        name.push_str("2d_view_");
    }

    let num_components = texture.dimension() as usize;
    for i in 0..num_components {
        if i != 0 {
            name.push('x');
        }
        name.push_str(&texture.size(0)[i].to_string());
    }

    name
}

/// `createImageSizeTests`
pub fn create_image_size_tests() -> TestCaseGroup {
    let image_types = [
        ImageType::OneD,
        ImageType::OneDArray,
        ImageType::TwoD,
        ImageType::TwoDArray,
        ImageType::ThreeD,
        ImageType::Cube,
        ImageType::CubeArray,
        ImageType::Buffer,
    ];

    // Base sizes used to generate actual image/buffer sizes in the test
    let base_image_sizes: [[i32; 3]; 4] = [[32, 32, 32], [12, 34, 56], [1, 1, 1], [7, 1, 1]];

    let all_flags = [
        FLAG_READONLY_IMAGE,
        FLAG_WRITEONLY_IMAGE,
        FLAG_READONLY_IMAGE | FLAG_WRITEONLY_IMAGE,
    ];

    let mut test_group = TestCaseGroup::new("image_size");

    let format = vk::Format::R32G32B32A32_SFLOAT;

    for image_type in image_types {
        let mut image_group = TestCaseGroup::new(get_image_type_name(image_type));

        for flags in all_flags {
            for base_image_size in base_image_sizes {
                for bool_idx in 0..2 {
                    let is_2d_view_of_3d = bool_idx > 0;

                    if is_2d_view_of_3d && image_type != ImageType::ThreeD {
                        continue;
                    }

                    let texture = get_texture(image_type, base_image_size);
                    let case_name = get_case_name(&texture, flags, is_2d_view_of_3d);

                    image_group.add_child(Box::new(SizeTest {
                        name: case_name,
                        texture,
                        format,
                        flags,
                        is_2d_view_of_3d,
                    }) as Box<dyn TestCase>);
                }
            }
        }

        test_group.add_child(image_group);
    }

    test_group
}
