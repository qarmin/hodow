// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageTransfer.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. No shaders. Despite the group name (`queue_transfer`) the copies run on
// the universal queue, as they do upstream.

use vulkanalia::prelude::v1_0::*;

use super::concurrent_copy_tests::fill_random_no_nan;
use super::subresource_layout_tests::{BASIC_COLOR_FORMATS, short_format_name};
use crate::tcu::random::{Random, de_int32_hash};
use crate::tcu::texture::map_vk_format;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy)]
struct TestParams {
    image_type: vk::ImageType,
    image_format: vk::Format,
    /// `.depth` will be the number of layers for 2D images and the depth for 3D images.
    dimensions: vk::Extent3D,
}

struct TransferQueueCase {
    name: String,
    params: TestParams,
}

impl TestCase for TransferQueueCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let params = &self.params;

        if params.image_format == vk::Format::A8_UNORM || params.image_format == vk::Format::A1B5G5R5_UNORM_PACK16 {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }

        let result = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                params.image_format,
                params.image_type,
                vk::ImageTiling::OPTIMAL,
                vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
                vk::ImageCreateFlags::empty(),
            )
        };
        match result {
            Ok(_) => {}
            Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => {
                return Err(TestError::NotSupported(format!(
                    "format {:?} does not support the required features",
                    params.image_format
                )));
            }
            Err(_) => {
                return Err(TestError::Fail(
                    "vkGetPhysicalDeviceImageFormatProperties returned unexpected error".to_string(),
                ));
            }
        }

        let props = unsafe { instance.get_physical_device_format_properties(physical_device, params.image_format) };
        let features = props.optimal_tiling_features;

        if !features.intersects(vk::FormatFeatureFlags::TRANSFER_SRC | vk::FormatFeatureFlags::TRANSFER_DST) {
            return Err(TestError::NotSupported("Format not supported for transfer".to_string()));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TransferQueueInstance {
            context,
            params: self.params,
        })
    }
}

struct TransferQueueInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for TransferQueueInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let params = self.params;
        let vk = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let queue = self.context.get_universal_queue();

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let tcu_format = map_vk_format(params.image_format)
            .ok_or_else(|| TestError::NotPorted(format!("texture format of {:?}", params.image_format)))?;
        let pixel_size = tcu_format
            .pixel_size()
            .ok_or_else(|| TestError::NotPorted(format!("pixel size of {:?}", params.image_format)))?;

        let width = params.dimensions.width;
        let height = params.dimensions.height;
        let layers = if params.image_type == vk::ImageType::_3D {
            1
        } else {
            params.dimensions.depth
        };
        let depth = if params.image_type == vk::ImageType::_3D {
            params.dimensions.depth
        } else {
            1
        };
        let pixel_data_size = pixel_size * width * height * layers * depth;

        let buffer_usage = vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST;
        let src_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(u64::from(pixel_data_size), buffer_usage),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let dst_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(u64::from(pixel_data_size), buffer_usage),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let extent = vk::Extent3D {
            width: params.dimensions.width,
            height: params.dimensions.height,
            depth,
        };
        let image_create_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: params.image_type,
            format: params.image_format,
            extent,
            mip_levels: 1,
            array_layers: layers,
            samples: vk::SampleCountFlags::_1,
            tiling: vk::ImageTiling::OPTIMAL,
            usage: vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };
        let image = ImageWithMemory::new(vk, allocator, image_create_info, MemoryRequirement::ANY)?;

        // Generate data for the source buffer and copy it into the buffer
        let mut generated_data = vec![0u8; pixel_data_size as usize];
        let mut random_gen = Random::new(
            de_int32_hash(params.image_format.as_raw())
                ^ de_int32_hash(params.image_type.as_raw())
                ^ de_int32_hash(params.dimensions.width as i32)
                ^ de_int32_hash(params.dimensions.height as i32)
                ^ de_int32_hash(params.dimensions.depth as i32),
        );
        {
            fill_random_no_nan(&mut random_gen, &mut generated_data, params.image_format);
            let alloc = src_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(generated_data.as_ptr(), alloc.get_host_ptr(), generated_data.len())
            };
            flush_alloc(vk, alloc)?;
        }

        begin_command_buffer(vk, cmd)?;
        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, layers);
        let image_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            image.get(),
            subresource_range,
        );
        unsafe {
            vk.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier],
            );
        }
        // Copy buffer to image
        {
            // None of the basic colour formats is compressed, so the block height is one
            let image_height = height;

            let copy_region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: image_height,
                image_subresource: vk::ImageSubresourceLayers {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    mip_level: 0,
                    base_array_layer: 0,
                    layer_count: layers,
                },
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: extent,
            };

            let post_image_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::GENERAL,
                image.get(),
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, layers),
            );

            unsafe {
                vk.cmd_copy_buffer_to_image(
                    cmd,
                    src_buffer.get(),
                    image.get(),
                    vk::ImageLayout::GENERAL,
                    &[copy_region],
                );

                vk.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[post_image_barrier],
                );

                vk.cmd_copy_image_to_buffer(
                    cmd,
                    image.get(),
                    vk::ImageLayout::GENERAL,
                    dst_buffer.get(),
                    &[copy_region],
                );
            }
        }
        end_command_buffer(vk, cmd)?;

        submit_commands_and_wait(vk, queue, cmd)?;

        {
            let alloc = dst_buffer.get_allocation();
            invalidate_alloc(vk, alloc)?;
            let result_data =
                unsafe { std::slice::from_raw_parts(alloc.get_host_ptr().cast_const(), pixel_data_size as usize) };

            if result_data != generated_data.as_slice() {
                return Ok(TestStatus::fail("Transfer queue test"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createTransferQueueImageTests`
pub fn create_transfer_queue_image_tests() -> TestCaseGroup {
    let mut layout_test_group = TestCaseGroup::new("queue_transfer");

    let image_class = [
        (vk::ImageType::_2D, "2d"),
        (vk::ImageType::_2D, "2d_array"),
        (vk::ImageType::_3D, "3d"),
    ];

    let extents = [
        (
            vk::Extent3D {
                width: 4,
                height: 3,
                depth: 1,
            },
            "4x3x1",
        ),
        (
            vk::Extent3D {
                width: 16,
                height: 15,
                depth: 1,
            },
            "16x15x1",
        ),
        (
            vk::Extent3D {
                width: 64,
                height: 31,
                depth: 1,
            },
            "64x31x1",
        ),
        (
            vk::Extent3D {
                width: 4,
                height: 3,
                depth: 2,
            },
            "4x3x2",
        ),
        (
            vk::Extent3D {
                width: 16,
                height: 15,
                depth: 16,
            },
            "16x15x16",
        ),
    ];

    for (image_type, class_name) in image_class {
        let mut class_group = TestCaseGroup::new(class_name);

        for (extent, extent_name) in extents {
            let mut mip_group = TestCaseGroup::new(extent_name);

            for &format in BASIC_COLOR_FORMATS {
                let params = TestParams {
                    image_format: format,
                    image_type,
                    dimensions: extent,
                };

                mip_group.add_child(Box::new(TransferQueueCase {
                    name: short_format_name(format),
                    params,
                }) as Box<dyn TestCase>);
            }

            class_group.add_child(mip_group);
        }

        layout_test_group.add_child(class_group);
    }

    layout_test_group
}
