// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageMismatchedFormatsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are in shaders/manifest/image_mismatched_formats.toml,
// one program per (read, write or sparse read, SPIR-V format). The sparse image is bound on the universal queue, the
// context having no sparse queue of its own.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::image_mismatched_formats::ALL_MISMATCHED_FORMAT_PROGRAMS;
use crate::tcu::texture::{ChannelOrder, TextureChannelClass, map_vk_format};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compressed_formats::is_compressed_format;
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{Allocation, MemoryRequirement};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_descriptor_set};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vk::sparse_util::{
    allocate_and_bind_sparse_image, check_sparse_image_format_support, universal_queue_supports_sparse_binding,
};
use crate::vkt::tests::api::object_tests::format_name;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `VK_CORE_FORMAT_LAST`
const VK_CORE_FORMAT_LAST: i32 = 185;

/// The `rust_type` of the manifest entries: the program of one (kind, SPIR-V format) pair.
#[derive(Clone, Copy)]
pub struct MismatchedFormatPrograms {
    pub name: &'static str,
    pub kind: &'static str,
    pub spirv_format: &'static str,
    #[allow(dead_code)]
    pub glsl_format: &'static str,
    pub programs: BinaryCollection,
}

/// `FormatInfo`, minus the GLSL format which the manifest carries
#[derive(Clone, Copy)]
struct FormatInfo {
    vector_width: u32,
    bytes_per_pixel: u32,
    channel_class: TextureChannelClass,
}

/// `SpirvFormats` - kept in the order `std::map<std::string, ...>` iterates it (by name), which is the order the cases
/// are registered in. The byte counts are upstream's, including the ones that look wrong (`Rg32i`, `R32i`): they decide
/// which vk formats a SPIR-V format is paired with.
const SPIRV_FORMATS: &[(&str, FormatInfo)] = &[
    (
        "R11fG11fB10f",
        FormatInfo {
            vector_width: 3,
            bytes_per_pixel: 4,
            channel_class: TextureChannelClass::FloatingPoint,
        },
    ),
    (
        "R16",
        FormatInfo {
            vector_width: 1,
            bytes_per_pixel: 2,
            channel_class: TextureChannelClass::UnsignedFixedPoint,
        },
    ),
    (
        "R16Snorm",
        FormatInfo {
            vector_width: 1,
            bytes_per_pixel: 2,
            channel_class: TextureChannelClass::SignedFixedPoint,
        },
    ),
    (
        "R16f",
        FormatInfo {
            vector_width: 1,
            bytes_per_pixel: 2,
            channel_class: TextureChannelClass::FloatingPoint,
        },
    ),
    (
        "R16i",
        FormatInfo {
            vector_width: 1,
            bytes_per_pixel: 2,
            channel_class: TextureChannelClass::SignedInteger,
        },
    ),
    (
        "R16ui",
        FormatInfo {
            vector_width: 1,
            bytes_per_pixel: 2,
            channel_class: TextureChannelClass::UnsignedInteger,
        },
    ),
    (
        "R32f",
        FormatInfo {
            vector_width: 1,
            bytes_per_pixel: 4,
            channel_class: TextureChannelClass::FloatingPoint,
        },
    ),
    (
        "R32i",
        FormatInfo {
            vector_width: 1,
            bytes_per_pixel: 1,
            channel_class: TextureChannelClass::SignedInteger,
        },
    ),
    (
        "R32ui",
        FormatInfo {
            vector_width: 1,
            bytes_per_pixel: 4,
            channel_class: TextureChannelClass::UnsignedInteger,
        },
    ),
    (
        "R8",
        FormatInfo {
            vector_width: 1,
            bytes_per_pixel: 1,
            channel_class: TextureChannelClass::UnsignedFixedPoint,
        },
    ),
    (
        "R8Snorm",
        FormatInfo {
            vector_width: 1,
            bytes_per_pixel: 1,
            channel_class: TextureChannelClass::SignedFixedPoint,
        },
    ),
    (
        "R8i",
        FormatInfo {
            vector_width: 1,
            bytes_per_pixel: 1,
            channel_class: TextureChannelClass::SignedInteger,
        },
    ),
    (
        "R8ui",
        FormatInfo {
            vector_width: 1,
            bytes_per_pixel: 1,
            channel_class: TextureChannelClass::UnsignedInteger,
        },
    ),
    (
        "Rg16",
        FormatInfo {
            vector_width: 2,
            bytes_per_pixel: 4,
            channel_class: TextureChannelClass::UnsignedFixedPoint,
        },
    ),
    (
        "Rg16Snorm",
        FormatInfo {
            vector_width: 2,
            bytes_per_pixel: 4,
            channel_class: TextureChannelClass::SignedFixedPoint,
        },
    ),
    (
        "Rg16f",
        FormatInfo {
            vector_width: 2,
            bytes_per_pixel: 4,
            channel_class: TextureChannelClass::FloatingPoint,
        },
    ),
    (
        "Rg16i",
        FormatInfo {
            vector_width: 2,
            bytes_per_pixel: 4,
            channel_class: TextureChannelClass::SignedInteger,
        },
    ),
    (
        "Rg16ui",
        FormatInfo {
            vector_width: 2,
            bytes_per_pixel: 4,
            channel_class: TextureChannelClass::UnsignedInteger,
        },
    ),
    (
        "Rg32f",
        FormatInfo {
            vector_width: 2,
            bytes_per_pixel: 8,
            channel_class: TextureChannelClass::FloatingPoint,
        },
    ),
    (
        "Rg32i",
        FormatInfo {
            vector_width: 2,
            bytes_per_pixel: 2,
            channel_class: TextureChannelClass::SignedInteger,
        },
    ),
    (
        "Rg32ui",
        FormatInfo {
            vector_width: 2,
            bytes_per_pixel: 8,
            channel_class: TextureChannelClass::UnsignedInteger,
        },
    ),
    (
        "Rg8",
        FormatInfo {
            vector_width: 2,
            bytes_per_pixel: 2,
            channel_class: TextureChannelClass::UnsignedFixedPoint,
        },
    ),
    (
        "Rg8Snorm",
        FormatInfo {
            vector_width: 2,
            bytes_per_pixel: 2,
            channel_class: TextureChannelClass::SignedFixedPoint,
        },
    ),
    (
        "Rg8i",
        FormatInfo {
            vector_width: 2,
            bytes_per_pixel: 2,
            channel_class: TextureChannelClass::SignedInteger,
        },
    ),
    (
        "Rg8ui",
        FormatInfo {
            vector_width: 2,
            bytes_per_pixel: 2,
            channel_class: TextureChannelClass::UnsignedInteger,
        },
    ),
    (
        "Rgb10A2",
        FormatInfo {
            vector_width: 4,
            bytes_per_pixel: 4,
            channel_class: TextureChannelClass::UnsignedFixedPoint,
        },
    ),
    (
        "Rgb10a2ui",
        FormatInfo {
            vector_width: 4,
            bytes_per_pixel: 4,
            channel_class: TextureChannelClass::UnsignedInteger,
        },
    ),
    (
        "Rgba16",
        FormatInfo {
            vector_width: 4,
            bytes_per_pixel: 8,
            channel_class: TextureChannelClass::UnsignedFixedPoint,
        },
    ),
    (
        "Rgba16Snorm",
        FormatInfo {
            vector_width: 4,
            bytes_per_pixel: 8,
            channel_class: TextureChannelClass::SignedFixedPoint,
        },
    ),
    (
        "Rgba16f",
        FormatInfo {
            vector_width: 4,
            bytes_per_pixel: 8,
            channel_class: TextureChannelClass::FloatingPoint,
        },
    ),
    (
        "Rgba16i",
        FormatInfo {
            vector_width: 4,
            bytes_per_pixel: 8,
            channel_class: TextureChannelClass::SignedInteger,
        },
    ),
    (
        "Rgba16ui",
        FormatInfo {
            vector_width: 4,
            bytes_per_pixel: 8,
            channel_class: TextureChannelClass::UnsignedInteger,
        },
    ),
    (
        "Rgba32f",
        FormatInfo {
            vector_width: 4,
            bytes_per_pixel: 16,
            channel_class: TextureChannelClass::FloatingPoint,
        },
    ),
    (
        "Rgba32i",
        FormatInfo {
            vector_width: 4,
            bytes_per_pixel: 16,
            channel_class: TextureChannelClass::SignedInteger,
        },
    ),
    (
        "Rgba32ui",
        FormatInfo {
            vector_width: 4,
            bytes_per_pixel: 16,
            channel_class: TextureChannelClass::UnsignedInteger,
        },
    ),
    (
        "Rgba8",
        FormatInfo {
            vector_width: 4,
            bytes_per_pixel: 4,
            channel_class: TextureChannelClass::UnsignedFixedPoint,
        },
    ),
    (
        "Rgba8Snorm",
        FormatInfo {
            vector_width: 4,
            bytes_per_pixel: 4,
            channel_class: TextureChannelClass::SignedFixedPoint,
        },
    ),
    (
        "Rgba8i",
        FormatInfo {
            vector_width: 4,
            bytes_per_pixel: 4,
            channel_class: TextureChannelClass::SignedInteger,
        },
    ),
    (
        "Rgba8ui",
        FormatInfo {
            vector_width: 4,
            bytes_per_pixel: 4,
            channel_class: TextureChannelClass::UnsignedInteger,
        },
    ),
];

/// `getFormatInfo(VkFormat)`
fn get_format_info(format: vk::Format) -> Option<FormatInfo> {
    let tex_format = map_vk_format(format)?;
    Some(FormatInfo {
        vector_width: tex_format.order.num_used_channels(),
        bytes_per_pixel: tex_format.pixel_size()?,
        channel_class: tex_format.channel_class(),
    })
}

/// `matching`
fn matching(format: vk::Format, spirv_format: &FormatInfo) -> bool {
    match get_format_info(format) {
        Some(base_format) => {
            base_format.vector_width == spirv_format.vector_width
                && base_format.bytes_per_pixel == spirv_format.bytes_per_pixel
                && base_format.channel_class == spirv_format.channel_class
        }
        None => false,
    }
}

/// `getImageAspectFlags(mapVkFormat(format))`
fn get_image_aspect_flags(format: vk::Format) -> vk::ImageAspectFlags {
    match map_vk_format(format).map(|f| f.order) {
        Some(ChannelOrder::D) => vk::ImageAspectFlags::DEPTH,
        Some(ChannelOrder::S) => vk::ImageAspectFlags::STENCIL,
        Some(ChannelOrder::DS) => vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
        _ => vk::ImageAspectFlags::COLOR,
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    Read,
    SparseRead,
    Write,
}

impl TestType {
    fn kind(self) -> &'static str {
        match self {
            TestType::Read => "read",
            TestType::SparseRead => "sparse_read",
            TestType::Write => "write",
        }
    }
}

/// `fillImageCreateInfo`
fn fill_image_create_info(test_type: TestType, format: vk::Format) -> vk::ImageCreateInfo {
    let flags = if test_type == TestType::SparseRead {
        vk::ImageCreateFlags::SPARSE_BINDING | vk::ImageCreateFlags::SPARSE_RESIDENCY
    } else {
        vk::ImageCreateFlags::empty()
    };
    vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags,
        image_type: vk::ImageType::_2D,
        format,
        extent: vk::Extent3D {
            width: 8,
            height: 8,
            depth: 1,
        },
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::OPTIMAL,
        usage: vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    }
}

struct MismatchedFormatTest {
    name: String,
    test_type: TestType,
    format: vk::Format,
    spirv_format: &'static str,
}

impl TestCase for MismatchedFormatTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.test_type == TestType::SparseRead {
            let features = context.get_device_features();
            if features.sparse_binding == vk::FALSE {
                return Err(TestError::NotSupported("sparseBinding not supported".to_string()));
            }
            if features.sparse_residency_buffer == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Sparse partially resident buffers not supported".to_string(),
                ));
            }

            // Check sparse operations support before creating the image.
            if !check_sparse_image_format_support(
                context.get_instance(),
                context.get_physical_device(),
                &fill_image_create_info(self.test_type, self.format),
            ) {
                return Err(TestError::NotSupported(
                    "The image format does not support sparse operations.".to_string(),
                ));
            }

            if features.shader_resource_residency == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Shader resource residency not supported".to_string(),
                ));
            }

            if !universal_queue_supports_sparse_binding(
                context.get_instance(),
                context.get_physical_device(),
                context.get_universal_queue_family_index(),
            ) {
                return Err(TestError::NotSupported(
                    "the universal queue cannot bind sparse memory".to_string(),
                ));
            }
        }

        let format_properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), self.format)
        };

        if !format_properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::STORAGE_IMAGE)
        {
            return Err(TestError::NotSupported(
                "Creating storage image with this format is not supported".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let kind = self.test_type.kind();
        ALL_MISMATCHED_FORMAT_PROGRAMS
            .iter()
            .find(|p| p.kind == kind && p.spirv_format == self.spirv_format)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MismatchedFormatTestInstance {
            context,
            test_type: self.test_type,
            format: self.format,
        })
    }
}

struct MismatchedFormatTestInstance<'a> {
    context: &'a Context<'a>,
    test_type: TestType,
    format: vk::Format,
}

impl TestInstance for MismatchedFormatTestInstance<'_> {
    #[allow(unused_assignments)]
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let allocator = self.context.get_default_allocator();

        // Declared before the images so the sparse memory is freed after the image.
        let mut allocations: Vec<Allocation<'_>> = Vec::new();

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
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

        let image_create_info = fill_image_create_info(self.test_type, self.format);
        let normal_image;
        let sparse_image;
        let mut bind_semaphore = None;
        let storage_image_handle = if self.test_type == TestType::SparseRead {
            let image = Unique::new(
                vk,
                unsafe { vk.create_image(&image_create_info, None) }.vk_check("vkCreateImage")?,
            );
            let semaphore = Unique::new(
                vk,
                unsafe { vk.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                    .vk_check("vkCreateSemaphore")?,
            );
            let tcu_format = map_vk_format(self.format)
                .ok_or_else(|| TestError::NotPorted(format!("tcu format of {:?}", self.format)))?;
            allocate_and_bind_sparse_image(
                vk,
                self.context.get_instance(),
                self.context.get_physical_device(),
                &image_create_info,
                *semaphore,
                queue,
                allocator,
                &mut allocations,
                tcu_format,
                *image,
                vk::Fence::null(),
            )?;
            bind_semaphore = Some(semaphore);
            normal_image = None;
            sparse_image = Some(image);
            sparse_image.as_ref().map_or_else(vk::Image::null, |image| **image)
        } else {
            sparse_image = None;
            normal_image = Some(ImageWithMemory::new(
                vk,
                allocator,
                image_create_info,
                MemoryRequirement::ANY,
            )?);
            normal_image.as_ref().map_or_else(vk::Image::null, |image| image.get())
        };

        let subresource_range = make_image_subresource_range(get_image_aspect_flags(self.format), 0, 1, 0, 1);
        let storage_image_view = make_image_view(
            vk,
            storage_image_handle,
            vk::ImageViewType::_2D,
            self.format,
            subresource_range,
        )?;
        let storage_image_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *storage_image_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];

        let write = vk::WriteDescriptorSet::builder()
            .dst_set(*descriptor_set)
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
            .image_info(&storage_image_info)
            .build();
        unsafe { vk.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let layout_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            storage_image_handle,
            subresource_range,
        );

        begin_command_buffer(vk, cmd)?;
        unsafe {
            vk.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[layout_barrier],
            );
        }
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
            vk.cmd_dispatch(cmd, 8, 8, 1);
        }
        end_command_buffer(vk, cmd)?;

        if let Some(semaphore) = &bind_semaphore {
            let fence = Unique::new(
                vk,
                unsafe { vk.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
            );
            let wait_semaphores = [**semaphore];
            let wait_stages = [vk::PipelineStageFlags::TRANSFER];
            let cmd_buffers = [cmd];
            let submit_info = vk::SubmitInfo::builder()
                .wait_semaphores(&wait_semaphores)
                .wait_dst_stage_mask(&wait_stages)
                .command_buffers(&cmd_buffers);
            unsafe { vk.queue_submit(queue, &[submit_info], *fence) }.vk_check("vkQueueSubmit")?;
            unsafe { vk.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
        } else {
            submit_commands_and_wait(vk, queue, cmd)?;
        }

        Ok(TestStatus::pass("Passed"))
    }
}

/// `createImageMismatchedFormatsTests`
pub fn create_image_mismatched_formats_tests() -> TestCaseGroup {
    // Test image load/store operations on mismatched formats
    let mut test_group = TestCaseGroup::new("mismatched_formats");
    // perform OpImageRead
    let mut test_group_op_read = TestCaseGroup::new("image_read");
    let mut test_group_op_write = TestCaseGroup::new("image_write");
    let mut test_group_op_sparse_read = TestCaseGroup::new("sparse_image_read");

    for raw_format in vk::Format::R4G4_UNORM_PACK8.as_raw()..VK_CORE_FORMAT_LAST {
        let format = vk::Format::from_raw(raw_format);
        if is_compressed_format(format) {
            continue;
        }

        for &(spirv_format, info) in SPIRV_FORMATS {
            if matching(format, &info) {
                let test_name = format!("{}_with_{}", format_name(format), spirv_format).to_lowercase();

                test_group_op_read.add_child(Box::new(MismatchedFormatTest {
                    name: test_name.clone(),
                    test_type: TestType::Read,
                    format,
                    spirv_format,
                }) as Box<dyn TestCase>);
                test_group_op_write.add_child(Box::new(MismatchedFormatTest {
                    name: test_name.clone(),
                    test_type: TestType::Write,
                    format,
                    spirv_format,
                }) as Box<dyn TestCase>);
                test_group_op_sparse_read.add_child(Box::new(MismatchedFormatTest {
                    name: test_name,
                    test_type: TestType::SparseRead,
                    format,
                    spirv_format,
                }) as Box<dyn TestCase>);
            }
        }
    }

    test_group.add_child(test_group_op_read);
    test_group.add_child(test_group_op_write);
    test_group.add_child(test_group_op_sparse_read);

    test_group
}
