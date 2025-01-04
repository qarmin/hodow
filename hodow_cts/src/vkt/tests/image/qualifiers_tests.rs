// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageQualifiersTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are in shaders/manifest/image_qualifiers.toml; the `restrict` group
// is `createImageQualifierRestrictCase` of vktImageLoadStoreTests.cpp, which load_store_tests.rs ports. The
// reference image is computed on plain integers and compared texel by texel rather than through `tcu::*ThresholdCompare`
// per layer; the formats are all R32, so the comparison is exact for the integer ones and 0.01 for the float one.

use vulkanalia::prelude::v1_0::*;

use super::load_store_tests::create_image_qualifier_restrict_case;
use super::tests_util::{
    ImageType, get_image_type_name, get_layer_size, get_num_layers, get_num_pixels, get_shader_grid_size,
    map_image_type, map_image_view_type,
};
use crate::generated::shaders::image_qualifiers::ALL_QUALIFIER_PROGRAMS;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set,
};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const G_LOCAL_WORK_GROUP_SIZE_BASE: [u32; 3] = [8, 8, 2];
const G_SHADER_READ_OFFSETS_X: [i32; 4] = [1, 4, 7, 10];
const G_SHADER_READ_OFFSETS_Y: [i32; 4] = [2, 5, 8, 11];
const G_SHADER_READ_OFFSETS_Z: [i32; 4] = [3, 6, 9, 12];

/// The `rust_type` of the manifest entries: the program of one (qualifier, image type, format) combination.
#[derive(Clone, Copy)]
pub struct QualifierPrograms {
    pub name: &'static str,
    pub qualifier: &'static str,
    pub kind: &'static str,
    pub fmt: &'static str,
    pub programs: BinaryCollection,
}

/// The three formats the group runs: `R` with `FLOAT`, `UNSIGNED_INT32` and `SIGNED_INT32`.
#[derive(Clone, Copy, PartialEq, Eq)]
enum ColorKind {
    Float,
    Uint,
    Int,
}

impl ColorKind {
    /// The manifest's `fmt`
    fn manifest_name(self) -> &'static str {
        match self {
            ColorKind::Float => "f",
            ColorKind::Uint => "u",
            ColorKind::Int => "i",
        }
    }

    fn vk_format(self) -> vk::Format {
        match self {
            ColorKind::Float => vk::Format::R32_SFLOAT,
            ColorKind::Uint => vk::Format::R32_UINT,
            ColorKind::Int => vk::Format::R32_SINT,
        }
    }

    /// `getShaderImageFormatQualifier`, which names the case
    fn format_qualifier(self) -> &'static str {
        match self {
            ColorKind::Float => "r32f",
            ColorKind::Uint => "r32ui",
            ColorKind::Int => "r32i",
        }
    }
}

/// `getLocalWorkGroupSize`
fn get_local_work_group_size(image_type: ImageType, image_size: [u32; 3]) -> [u32; 3] {
    let compute_grid_size = get_shader_grid_size(image_type, image_size);

    [
        G_LOCAL_WORK_GROUP_SIZE_BASE[0].min(compute_grid_size[0]),
        G_LOCAL_WORK_GROUP_SIZE_BASE[1].min(compute_grid_size[1]),
        G_LOCAL_WORK_GROUP_SIZE_BASE[2].min(compute_grid_size[2]),
    ]
}

/// `getNumWorkGroups`
fn get_num_work_groups(image_type: ImageType, image_size: [u32; 3]) -> [u32; 3] {
    let compute_grid_size = get_shader_grid_size(image_type, image_size);
    let local_work_group_size = get_local_work_group_size(image_type, image_size);

    [
        compute_grid_size[0] / local_work_group_size[0],
        compute_grid_size[1] / local_work_group_size[1],
        compute_grid_size[2] / local_work_group_size[2],
    ]
}

/// `generateReferenceImage` - the value every texel of the grid ends up with, in x-fastest order.
fn generate_reference_image(image_type: ImageType, image_size: [u32; 3]) -> Vec<i32> {
    // Generate a reference image data using the storage format
    let compute_grid_size = get_shader_grid_size(image_type, image_size);
    let (width, height, depth) = (
        compute_grid_size[0] as i32,
        compute_grid_size[1] as i32,
        compute_grid_size[2] as i32,
    );

    let base_value = |x: i32, y: i32, z: i32| x ^ y ^ z;

    let local_work_group_size = get_local_work_group_size(image_type, image_size);
    let (local_x, local_y, local_z) = (
        local_work_group_size[0] as i32,
        local_work_group_size[1] as i32,
        local_work_group_size[2] as i32,
    );

    let mut reference = Vec::with_capacity((width * height * depth) as usize);
    for z in 0..depth {
        for y in 0..height {
            for x in 0..width {
                let group_base_x = x / local_x * local_x;
                let group_base_y = y / local_y * local_y;
                let group_base_z = z / local_z * local_z;
                let mut sum = 0i32;

                for i in 0..G_SHADER_READ_OFFSETS_X.len() {
                    sum += base_value(
                        group_base_x + (x + G_SHADER_READ_OFFSETS_X[i]) % local_x,
                        group_base_y + (y + G_SHADER_READ_OFFSETS_Y[i]) % local_y,
                        group_base_z + (z + G_SHADER_READ_OFFSETS_Z[i]) % local_z,
                    );
                }

                reference.push(sum);
            }
        }
    }

    reference
}

struct MemoryQualifierTestCase {
    name: String,
    qualifier: &'static str,
    image_type: ImageType,
    image_size: [u32; 3],
    color: ColorKind,
}

impl TestCase for MemoryQualifierTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.image_type == ImageType::CubeArray && context.get_device_features().image_cube_array == vk::FALSE {
            return Err(TestError::NotSupported("imageCubeArray not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let kind = get_image_type_name(self.image_type);
        let fmt = self.color.manifest_name();
        ALL_QUALIFIER_PROGRAMS
            .iter()
            .find(|p| p.qualifier == self.qualifier && p.kind == kind && p.fmt == fmt)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MemoryQualifierInstance {
            context,
            image_type: self.image_type,
            image_size: self.image_size,
            color: self.color,
        })
    }
}

struct MemoryQualifierInstance<'a> {
    context: &'a Context<'a>,
    image_type: ImageType,
    image_size: [u32; 3],
    color: ColorKind,
}

impl TestInstance for MemoryQualifierInstance<'_> {
    /// `MemoryQualifierInstanceBase::iterate`, with the image and buffer instances' `prepareResources`,
    /// `prepareDescriptors` and `commandsBeforeCompute`/`commandsAfterCompute` inline.
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let format = self.color.vk_format();
        let is_buffer = self.image_type == ImageType::Buffer;
        let num_layers = get_num_layers(self.image_type, self.image_size);
        let layer_size = get_layer_size(self.image_type, self.image_size);

        let buffer_size_in_bytes = vk::DeviceSize::from(get_num_pixels(self.image_type, self.image_size))
            * std::mem::size_of::<u32>() as vk::DeviceSize;

        // Prepare resources for the test
        let image = if is_buffer {
            None
        } else {
            let create_flags = if self.image_type == ImageType::Cube || self.image_type == ImageType::CubeArray {
                vk::ImageCreateFlags::CUBE_COMPATIBLE
            } else {
                vk::ImageCreateFlags::empty()
            };
            let image_create_info = vk::ImageCreateInfo {
                s_type: vk::StructureType::IMAGE_CREATE_INFO,
                next: std::ptr::null(),
                flags: create_flags,
                image_type: map_image_type(self.image_type),
                format,
                extent: vk::Extent3D {
                    width: layer_size[0],
                    height: layer_size[1],
                    depth: layer_size[2],
                },
                mip_levels: 1,
                array_layers: num_layers,
                samples: vk::SampleCountFlags::_1,
                tiling: vk::ImageTiling::OPTIMAL,
                usage: vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::STORAGE,
                sharing_mode: vk::SharingMode::EXCLUSIVE,
                queue_family_index_count: 0,
                queue_family_indices: std::ptr::null(),
                initial_layout: vk::ImageLayout::UNDEFINED,
            };
            Some(ImageWithMemory::new(
                vk,
                allocator,
                image_create_info,
                MemoryRequirement::ANY,
            )?)
        };
        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, num_layers);
        let image_view = match &image {
            Some(image) => {
                let view_type = map_image_view_type(self.image_type)
                    .ok_or_else(|| TestError::InternalError("no view type for the image type".to_string()))?;
                Some(make_image_view(vk, image.get(), view_type, format, subresource_range)?)
            }
            None => None,
        };

        // The buffer that stores the shader output: copied image data, or the texel buffer itself
        let buffer_usage = if is_buffer {
            vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER
        } else {
            vk::BufferUsageFlags::TRANSFER_DST
        };
        let buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(buffer_size_in_bytes, buffer_usage),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let buffer_view = if is_buffer {
            let info = vk::BufferViewCreateInfo::builder()
                .buffer(buffer.get())
                .format(format)
                .offset(0)
                .range(buffer_size_in_bytes);
            Some(Unique::new(
                vk,
                unsafe { vk.create_buffer_view(&info, None) }.vk_check("vkCreateBufferView")?,
            ))
        } else {
            None
        };

        // Prepare descriptor sets
        let descriptor_type = if is_buffer {
            vk::DescriptorType::STORAGE_TEXEL_BUFFER
        } else {
            vk::DescriptorType::STORAGE_IMAGE
        };
        let descriptor_pool = DescriptorPoolBuilder::new().add_type(descriptor_type, 1).build(
            vk,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(descriptor_type, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;
        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let image_info = image_view.as_ref().map(|view| {
            [vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: **view,
                image_layout: vk::ImageLayout::GENERAL,
            }]
        });
        let texel_buffer_views = buffer_view.as_ref().map(|view| [**view]);
        let mut write = vk::WriteDescriptorSet::builder()
            .dst_set(*descriptor_set)
            .dst_binding(0)
            .descriptor_type(descriptor_type);
        if let Some(info) = &image_info {
            write = write.image_info(info);
        }
        if let Some(views) = &texel_buffer_views {
            write = write.texel_buffer_view(views);
        }
        unsafe { vk.update_descriptor_sets(&[write.build()], &[] as &[vk::CopyDescriptorSet]) };

        // Create compute shader and pipeline
        let mut pipeline = ComputePipelineWrapper::new(
            vk,
            ComputePipelineConstructionType::Pipeline,
            self.context.get_binary_collection().get("comp")?,
        );
        pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline.build_pipeline()?;

        // Create command buffer
        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Start recording commands
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

        // `commandsBeforeCompute`
        if let Some(image) = &image {
            let image_layout_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                image.get(),
                subresource_range,
            );

            unsafe {
                vk.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_layout_barrier],
                );
            }
        }

        let num_groups = get_num_work_groups(self.image_type, self.image_size);
        unsafe { vk.cmd_dispatch(cmd, num_groups[0], num_groups[1], num_groups[2]) };

        // `commandsAfterCompute`
        match &image {
            Some(image) => {
                let image_pre_copy_barrier = make_image_memory_barrier(
                    vk::AccessFlags::SHADER_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::GENERAL,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    image.get(),
                    subresource_range,
                );

                unsafe {
                    vk.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::COMPUTE_SHADER,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[image_pre_copy_barrier],
                    );
                }

                let copy_params = vk::BufferImageCopy {
                    buffer_offset: 0,
                    buffer_row_length: 0,
                    buffer_image_height: 0,
                    image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, num_layers),
                    image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                    image_extent: vk::Extent3D {
                        width: layer_size[0],
                        height: layer_size[1],
                        depth: layer_size[2],
                    },
                };
                unsafe {
                    vk.cmd_copy_image_to_buffer(
                        cmd,
                        image.get(),
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                        buffer.get(),
                        &[copy_params],
                    )
                };

                let buffer_post_copy_barrier = make_buffer_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::HOST_READ,
                    buffer.get(),
                    0,
                    buffer_size_in_bytes,
                );
                unsafe {
                    vk.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::PipelineStageFlags::HOST,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[buffer_post_copy_barrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }
            }
            None => {
                let shader_write_barrier = make_buffer_memory_barrier(
                    vk::AccessFlags::SHADER_WRITE,
                    vk::AccessFlags::HOST_READ,
                    buffer.get(),
                    0,
                    buffer_size_in_bytes,
                );
                unsafe {
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
            }
        }

        end_command_buffer(vk, cmd)?;

        // Submit and wait for completion
        submit_commands_and_wait(vk, queue, cmd)?;

        // Retrieve data from the buffer to host memory
        let allocation = buffer.get_allocation();
        invalidate_alloc(vk, allocation)?;

        let compute_grid_size = get_shader_grid_size(self.image_type, self.image_size);
        let num_texels = (compute_grid_size[0] * compute_grid_size[1] * compute_grid_size[2]) as usize;
        let result =
            unsafe { std::slice::from_raw_parts(allocation.get_host_ptr().cast_const().cast::<u32>(), num_texels) };

        // Create a reference image and validate the result
        let reference = generate_reference_image(self.image_type, self.image_size);

        let mismatch = result
            .iter()
            .zip(&reference)
            .position(|(&actual, &expected)| match self.color {
                ColorKind::Float => (f32::from_bits(actual) - expected as f32).abs() > 0.01,
                ColorKind::Uint => actual != expected as u32,
                ColorKind::Int => actual as i32 != expected,
            });

        match mismatch {
            None => Ok(TestStatus::pass("Passed")),
            Some(index) => {
                log::info!(
                    "Image comparison failed at texel {index}: reference {}, result bits {:#x}",
                    reference[index],
                    result[index]
                );
                Ok(TestStatus::fail("Image comparison failed"))
            }
        }
    }
}

/// `createImageQualifiersTests`
pub fn create_image_qualifiers_tests() -> TestCaseGroup {
    // Coherent, volatile and restrict
    let mut image_qualifiers_tests = TestCaseGroup::new("qualifiers");

    struct ImageParams {
        image_type: ImageType,
        image_size: [u32; 3],
    }

    let image_params_array = [
        ImageParams {
            image_type: ImageType::OneD,
            image_size: [64, 1, 1],
        },
        ImageParams {
            image_type: ImageType::OneDArray,
            image_size: [64, 1, 8],
        },
        ImageParams {
            image_type: ImageType::TwoD,
            image_size: [64, 64, 1],
        },
        ImageParams {
            image_type: ImageType::TwoDArray,
            image_size: [64, 64, 8],
        },
        ImageParams {
            image_type: ImageType::ThreeD,
            image_size: [64, 64, 8],
        },
        ImageParams {
            image_type: ImageType::Cube,
            image_size: [64, 64, 1],
        },
        ImageParams {
            image_type: ImageType::CubeArray,
            image_size: [64, 64, 2],
        },
        ImageParams {
            image_type: ImageType::Buffer,
            image_size: [64, 1, 1],
        },
    ];

    let formats = [ColorKind::Float, ColorKind::Uint, ColorKind::Int];

    for memory_qualifier_name in ["coherent", "volatile"] {
        let mut qualifier_group = TestCaseGroup::new(memory_qualifier_name);

        for image_params in &image_params_array {
            let mut image_type_group = TestCaseGroup::new(get_image_type_name(image_params.image_type));

            for color in formats {
                image_type_group.add_child(Box::new(MemoryQualifierTestCase {
                    name: color.format_qualifier().to_string(),
                    qualifier: memory_qualifier_name,
                    image_type: image_params.image_type,
                    image_size: image_params.image_size,
                    color,
                }) as Box<dyn TestCase>);
            }

            qualifier_group.add_child(image_type_group);
        }

        image_qualifiers_tests.add_child(qualifier_group);
    }

    // restrict: the cases come from `createImageQualifierRestrictCase` in vktImageLoadStoreTests.cpp, see load_store_tests.rs
    let mut restrict_group = TestCaseGroup::new("restrict");
    for image_params in &image_params_array {
        restrict_group.add_child(create_image_qualifier_restrict_case(
            image_params.image_type,
            get_image_type_name(image_params.image_type),
        ));
    }
    image_qualifiers_tests.add_child(restrict_group);

    image_qualifiers_tests
}
