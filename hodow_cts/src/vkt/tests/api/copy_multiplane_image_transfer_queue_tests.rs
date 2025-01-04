// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiCopyMultiplaneImageTransferQueueTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The case is `ycbcr::copy_tests`' `copy` group run on a dedicated transfer queue: the
// configuration types, seed, format compatibility rules, uploading, downloading and the comparison are shared with it (`verify_copies`),
// and what is here is what differs - the transfer queue, the copy granularity it asks for and the support checks.
// `multiplanar_xfer`: copies between multiplanar (and plain) formats recorded and submitted on the transfer queue.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::make_image_memory_barrier;
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vk::{Unique, VkResultExt};
use crate::vkt::tests::ycbcr::copy_tests::{
    ImageConfig, TestConfig, build_seed, is_compatible, is_copy_compatible, is_ycbcr_format, planes_of, verify_copies,
};
use crate::vkt::tests::ycbcr::util::{
    MultiPlaneImageData, allocate_and_bind_image_memory, aspect_plane_ndx, block_byte_size, block_extent,
    download_image, fill_image_memory, format_description, plane_aspect, plane_extent, read_image_memory, upload_image,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `checkFormatSupport`
fn check_format_support(context: &Context<'_>, config: &ImageConfig) -> Result<(), TestError> {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    {
        let image_format_info = vk::PhysicalDeviceImageFormatInfo2::builder()
            .format(config.format)
            .type_(vk::ImageType::_2D)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED)
            .flags(vk::ImageCreateFlags::empty());
        let mut image_format_properties = vk::ImageFormatProperties2::default();

        match unsafe {
            instance.get_physical_device_image_format_properties2(
                physical_device,
                &image_format_info,
                &mut image_format_properties,
            )
        } {
            Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => {
                return Err(TestError::NotSupported("Format not supported.".to_string()));
            }
            other => other.vk_check("vkGetPhysicalDeviceImageFormatProperties2")?,
        }

        // Check for plane compatible format support when the disjoint flag is being used
        if config.disjoint {
            for plane in planes_of(config.format) {
                let plane_image_format_info = vk::PhysicalDeviceImageFormatInfo2::builder()
                    .format(plane.compatible_format)
                    .type_(vk::ImageType::_2D)
                    .tiling(vk::ImageTiling::OPTIMAL)
                    .usage(vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED)
                    .flags(vk::ImageCreateFlags::empty());

                match unsafe {
                    instance.get_physical_device_image_format_properties2(
                        physical_device,
                        &plane_image_format_info,
                        &mut image_format_properties,
                    )
                } {
                    Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => {
                        return Err(TestError::NotSupported(
                            "Plane compatibile format not supported.".to_string(),
                        ));
                    }
                    other => other.vk_check("vkGetPhysicalDeviceImageFormatProperties2")?,
                }
            }
        }
    }

    {
        let properties = unsafe { instance.get_physical_device_format_properties(physical_device, config.format) };
        let features = if config.tiling == vk::ImageTiling::OPTIMAL {
            properties.optimal_tiling_features
        } else {
            properties.linear_tiling_features
        };

        if !features.intersects(vk::FormatFeatureFlags::TRANSFER_SRC | vk::FormatFeatureFlags::TRANSFER_DST) {
            return Err(TestError::NotSupported("Format doesn't support copies".to_string()));
        }

        if config.disjoint && !features.contains(vk::FormatFeatureFlags::DISJOINT) {
            return Err(TestError::NotSupported(
                "Format doesn't support disjoint planes".to_string(),
            ));
        }
    }

    Ok(())
}

/// `genCopies`: ten copies between randomly chosen compatible plane pairs, aligned to the copy granularity of the transfer queue.
fn gen_copies(rng: &mut Random, copy_count: usize, config: &TestConfig, granularity: (u32, u32)) -> Vec<vk::ImageCopy> {
    let src_info = format_description(config.src.format);
    let dst_info = format_description(config.dst.format);

    let mut pairs = Vec::new();
    for (src_ndx, src_plane) in src_info.planes.iter().enumerate() {
        for (dst_ndx, dst_plane) in dst_info.planes.iter().enumerate() {
            if is_compatible(src_plane.compatible_format, dst_plane.compatible_format) {
                pairs.push((src_ndx, dst_ndx));
            }
        }
    }
    assert!(
        !pairs.is_empty(),
        "the case would not have been registered without a compatible plane pair"
    );

    let random_uvec2 = |rng: &mut Random, min: (u32, u32), max: (u32, u32)| {
        let range = |min: u32, max: u32| 1u32.wrapping_add(max).wrapping_sub(min);
        (
            min.0
                .wrapping_add(rng.get_uint32().checked_rem(range(min.0, max.0)).unwrap_or(0)),
            min.1
                .wrapping_add(rng.get_uint32().checked_rem(range(min.1, max.1)).unwrap_or(0)),
        )
    };
    // `deIntRoundToPow2`
    let round_to_pow2 =
        |number: u32, power_of_2: u32| number.wrapping_add(power_of_2.wrapping_sub(1)) & !power_of_2.wrapping_sub(1);

    let mut copies = Vec::with_capacity(copy_count);
    for _ in 0..copy_count {
        let (src_plane_ndx, dst_plane_ndx) = *rng.choose(&pairs);

        let src_block = block_extent(src_info.planes[src_plane_ndx].compatible_format);
        let src_plane_extent = plane_extent(&src_info, config.src.size, src_plane_ndx);
        let src_plane_blocks = (src_plane_extent.0 / src_block.0, src_plane_extent.1 / src_block.1);

        let dst_block = block_extent(dst_info.planes[dst_plane_ndx].compatible_format);
        let dst_plane_extent = plane_extent(&dst_info, config.dst.size, dst_plane_ndx);
        let dst_plane_blocks = (dst_plane_extent.0 / dst_block.0, dst_plane_extent.1 / dst_block.1);

        let mut copy_blocks = random_uvec2(
            rng,
            (1, 1),
            (
                src_plane_blocks.0.min(dst_plane_blocks.0),
                src_plane_blocks.1.min(dst_plane_blocks.1),
            ),
        );
        copy_blocks.0 = round_to_pow2(copy_blocks.0, granularity.0);
        copy_blocks.1 = round_to_pow2(copy_blocks.1, granularity.1);

        let src_off = random_uvec2(
            rng,
            (0, 0),
            (
                src_plane_blocks.0.wrapping_sub(copy_blocks.0),
                src_plane_blocks.1.wrapping_sub(copy_blocks.1),
            ),
        );
        let mut src_offset = (src_block.0.wrapping_mul(src_off.0), src_block.1.wrapping_mul(src_off.1));
        src_offset.0 &= !granularity.0.wrapping_sub(1);
        src_offset.1 &= !granularity.1.wrapping_sub(1);

        let dst_off = random_uvec2(
            rng,
            (0, 0),
            (
                dst_plane_blocks.0.wrapping_sub(copy_blocks.0),
                dst_plane_blocks.1.wrapping_sub(copy_blocks.1),
            ),
        );
        let mut dst_offset = (dst_block.0.wrapping_mul(dst_off.0), dst_block.1.wrapping_mul(dst_off.1));
        dst_offset.0 &= !granularity.0.wrapping_sub(1);
        dst_offset.1 &= !granularity.1.wrapping_sub(1);

        let copy_extent = (
            copy_blocks.0.wrapping_mul(src_block.0),
            copy_blocks.1.wrapping_mul(src_block.1),
        );

        let layers =
            |info: &crate::vkt::tests::ycbcr::format_tables::FormatInfo, ndx: usize| vk::ImageSubresourceLayers {
                aspect_mask: if info.planes.len() > 1 {
                    plane_aspect(ndx)
                } else {
                    vk::ImageAspectFlags::COLOR
                },
                mip_level: 0,
                base_array_layer: 0,
                layer_count: 1,
            };

        copies.push(vk::ImageCopy {
            src_subresource: layers(&src_info, src_plane_ndx),
            src_offset: vk::Offset3D {
                x: src_offset.0 as i32,
                y: src_offset.1 as i32,
                z: 0,
            },
            dst_subresource: layers(&dst_info, dst_plane_ndx),
            dst_offset: vk::Offset3D {
                x: dst_offset.0 as i32,
                y: dst_offset.1 as i32,
                z: 0,
            },
            extent: vk::Extent3D {
                width: copy_extent.0,
                height: copy_extent.1,
                depth: 1,
            },
        });
    }
    copies
}

struct MultiplanarXferCase {
    name: String,
    config: TestConfig,
}

impl TestCase for MultiplanarXferCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let limits = context.get_device_properties().limits;

        if context.get_transfer_queue().is_none() {
            return Err(TestError::NotSupported(
                "Device does not have dedicated transfer queues".to_string(),
            ));
        }

        for image in [&self.config.src, &self.config.dst] {
            if image.size.0 > limits.max_image_dimension_2d || image.size.1 > limits.max_image_dimension_2d {
                return Err(TestError::NotSupported(
                    "Requested image dimensions not supported".to_string(),
                ));
            }
        }

        check_format_support(context, &self.config.src)?;
        check_format_support(context, &self.config.dst)?;
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultiplanarXferInstance {
            context,
            config: self.config,
        })
    }
}

struct MultiplanarXferInstance<'a> {
    context: &'a Context<'a>,
    config: TestConfig,
}

/// `createImage`
fn create_image<'a>(device: &'a Device, image_config: &ImageConfig) -> Result<Unique<'a, vk::Image>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .flags(if image_config.disjoint {
            vk::ImageCreateFlags::DISJOINT
        } else {
            vk::ImageCreateFlags::empty()
        })
        .image_type(vk::ImageType::_2D)
        .format(image_config.format)
        .extent(vk::Extent3D {
            width: image_config.size.0,
            height: image_config.size.1,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(image_config.tiling)
        .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(if image_config.tiling == vk::ImageTiling::LINEAR {
            vk::ImageLayout::PREINITIALIZED
        } else {
            vk::ImageLayout::UNDEFINED
        });
    let handle = unsafe { device.create_image(&info, None) }.vk_check("vkCreateImage")?;
    Ok(Unique::new(device, handle))
}

impl TestInstance for MultiplanarXferInstance<'_> {
    /// `testCopies`
    fn iterate(&mut self) -> TestOutcome {
        let config = self.config;
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let (transfer_queue, transfer_queue_family_index) = context
            .get_transfer_queue()
            .ok_or_else(|| TestError::NotSupported("Device does not have dedicated transfer queues".to_string()))?;

        let queue_props = unsafe {
            context
                .get_instance()
                .get_physical_device_queue_family_properties(context.get_physical_device())
        };
        let xfer_granularity = queue_props[transfer_queue_family_index as usize].min_image_transfer_granularity;
        let granularity = (xfer_granularity.width, xfer_granularity.height);

        const COPY_COUNT: usize = 10;

        let mut rng = Random::new(build_seed(&config));
        let copies = gen_copies(&mut rng, COPY_COUNT, &config, granularity);
        log::info!("Copies: {}", copies.len());

        let mut src_data = MultiPlaneImageData::new(config.src.format, config.src.size);
        let mut dst_data = MultiPlaneImageData::new(config.dst.format, config.dst.size);
        // To avoid putting NaNs in dst in the image copy
        src_data.fill_random(&mut rng);
        dst_data.fill_random(&mut rng);

        let src_image = create_image(device, &config.src)?;
        let dst_image = create_image(device, &config.dst)?;

        let requirement_for = |tiling: vk::ImageTiling| {
            if tiling == vk::ImageTiling::OPTIMAL {
                MemoryRequirement::ANY
            } else {
                MemoryRequirement::HOST_VISIBLE
            }
        };
        let src_memory = allocate_and_bind_image_memory(
            device,
            allocator,
            *src_image,
            config.src.format,
            config.src.disjoint,
            requirement_for(config.src.tiling),
        )?;
        let dst_memory = allocate_and_bind_image_memory(
            device,
            allocator,
            *dst_image,
            config.dst.format,
            config.dst.disjoint,
            requirement_for(config.dst.tiling),
        )?;

        if config.src.tiling == vk::ImageTiling::OPTIMAL {
            upload_image(
                device,
                allocator,
                queue,
                queue_family_index,
                *src_image,
                &src_data,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            )?;
        } else {
            fill_image_memory(
                device,
                queue,
                queue_family_index,
                *src_image,
                &src_memory,
                &src_data,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            )?;
        }

        if config.dst.tiling == vk::ImageTiling::OPTIMAL {
            upload_image(
                device,
                allocator,
                queue,
                queue_family_index,
                *dst_image,
                &dst_data,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            )?;
        } else {
            fill_image_memory(
                device,
                queue,
                queue_family_index,
                *dst_image,
                &dst_memory,
                &dst_data,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            )?;
        }

        {
            let transfer_cmd_pool = make_command_pool(device, transfer_queue_family_index)?;
            let transfer_cmd_buffer =
                allocate_command_buffer(device, *transfer_cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd = *transfer_cmd_buffer;

            begin_command_buffer(device, cmd)?;

            // Held until the submit below completes.
            let mut buffers = Vec::with_capacity(copies.len());

            for copy in &copies {
                let src_plane_ndx = if copy.src_subresource.aspect_mask != vk::ImageAspectFlags::COLOR {
                    aspect_plane_ndx(copy.src_subresource.aspect_mask)
                } else {
                    0
                };
                let src_plane_format = format_description(config.src.format).planes[src_plane_ndx].compatible_format;

                let block_size_bytes = block_byte_size(src_plane_format);
                let buffer_size = (config.src.size.0 * config.src.size.1 * block_size_bytes) as vk::DeviceSize;
                let buffer = BufferWithMemory::new(
                    device,
                    allocator,
                    make_buffer_create_info(
                        buffer_size,
                        vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
                    ),
                    MemoryRequirement::ANY,
                )?;

                if config.intermediate_buffer {
                    let image_to_buffer_copy = vk::BufferImageCopy {
                        buffer_offset: 0,
                        buffer_row_length: 0,
                        buffer_image_height: 0,
                        image_subresource: copy.src_subresource,
                        image_offset: copy.src_offset,
                        image_extent: copy.extent,
                    };
                    let buffer_barrier = vk::BufferMemoryBarrier::builder()
                        .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                        .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
                        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                        .buffer(buffer.get())
                        .offset(0)
                        .size(vk::WHOLE_SIZE)
                        .build();
                    let buffer_to_image_copy = vk::BufferImageCopy {
                        buffer_offset: 0,
                        buffer_row_length: 0,
                        buffer_image_height: 0,
                        image_subresource: copy.dst_subresource,
                        image_offset: copy.dst_offset,
                        image_extent: copy.extent,
                    };

                    unsafe {
                        device.cmd_copy_image_to_buffer(
                            cmd,
                            *src_image,
                            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                            buffer.get(),
                            &[image_to_buffer_copy],
                        );
                        device.cmd_pipeline_barrier(
                            cmd,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::DependencyFlags::empty(),
                            &[] as &[vk::MemoryBarrier],
                            &[buffer_barrier],
                            &[] as &[vk::ImageMemoryBarrier],
                        );
                        device.cmd_copy_buffer_to_image(
                            cmd,
                            buffer.get(),
                            *dst_image,
                            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                            &[buffer_to_image_copy],
                        );
                    }
                } else {
                    unsafe {
                        device.cmd_copy_image(
                            cmd,
                            *src_image,
                            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                            *dst_image,
                            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                            &[*copy],
                        )
                    };
                }
                buffers.push(buffer);

                let pre_copy_barrier = make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::TRANSFER_READ | vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    *dst_image,
                    vk::ImageSubresourceRange {
                        aspect_mask: vk::ImageAspectFlags::COLOR,
                        base_mip_level: 0,
                        level_count: 1,
                        base_array_layer: 0,
                        layer_count: 1,
                    },
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[pre_copy_barrier],
                    );
                }
            }

            end_command_buffer(device, cmd)?;

            submit_commands_and_wait(device, transfer_queue, cmd)?;
        }

        let mut result = MultiPlaneImageData::new(config.dst.format, config.dst.size);
        if config.dst.tiling == vk::ImageTiling::OPTIMAL {
            download_image(
                device,
                allocator,
                transfer_queue,
                transfer_queue_family_index,
                *dst_image,
                &mut result,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            )?;
        } else {
            read_image_memory(device, *dst_image, &dst_memory, &mut result)?;
        }

        verify_copies(&config, &copies, &src_data, &dst_data, &result)
    }
}

/// `createCopyMultiplaneImageTransferQueueTests`
pub fn create_copy_multiplane_image_transfer_queue_tests() -> TestCaseGroup {
    const TILINGS: [(&str, vk::ImageTiling); 2] = [
        ("optimal", vk::ImageTiling::OPTIMAL),
        ("linear", vk::ImageTiling::LINEAR),
    ];

    let multiplane_formats = [
        vk::Format::G8_B8_R8_3PLANE_420_UNORM,
        vk::Format::G8_B8R8_2PLANE_420_UNORM,
        vk::Format::G8_B8_R8_3PLANE_422_UNORM,
        vk::Format::G8_B8R8_2PLANE_422_UNORM,
        vk::Format::G8_B8_R8_3PLANE_444_UNORM,
        vk::Format::G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16,
        vk::Format::G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16,
        vk::Format::G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16,
        vk::Format::G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16,
        vk::Format::G10X6_B10X6_R10X6_3PLANE_444_UNORM_3PACK16,
        vk::Format::G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16,
        vk::Format::G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16,
        vk::Format::G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16,
        vk::Format::G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16,
        vk::Format::G12X4_B12X4_R12X4_3PLANE_444_UNORM_3PACK16,
        vk::Format::G16_B16_R16_3PLANE_420_UNORM,
        vk::Format::G16_B16R16_2PLANE_420_UNORM,
        vk::Format::G16_B16_R16_3PLANE_422_UNORM,
        vk::Format::G16_B16R16_2PLANE_422_UNORM,
    ];

    // `de::toLower(getFormatName(format).substr(10))`
    let format_name = |format: vk::Format| format!("{format:?}").to_lowercase();
    let size_for = |format: vk::Format| if is_ycbcr_format(format) { (64, 64) } else { (23, 17) };

    let mut multiplane_group = TestCaseGroup::new("multiplanar_xfer");

    for src_format in multiplane_formats {
        let src_size = size_for(src_format);
        let mut src_format_group = TestCaseGroup::new(format_name(src_format));

        for dst_format in multiplane_formats {
            let dst_size = size_for(dst_format);

            if (!is_ycbcr_format(src_format) && !is_ycbcr_format(dst_format))
                || !is_copy_compatible(src_format, dst_format)
            {
                continue;
            }

            let mut dst_format_group = TestCaseGroup::new(format_name(dst_format));
            for (src_tiling_name, src_tiling) in TILINGS {
                for (dst_tiling_name, dst_tiling) in TILINGS {
                    if src_tiling == vk::ImageTiling::LINEAR || dst_tiling == vk::ImageTiling::LINEAR {
                        continue;
                    }

                    for src_disjoint in [false, true] {
                        for dst_disjoint in [false, true] {
                            for use_buffer in [false, true] {
                                let config = TestConfig {
                                    src: ImageConfig {
                                        format: src_format,
                                        tiling: src_tiling,
                                        disjoint: src_disjoint,
                                        size: src_size,
                                    },
                                    dst: ImageConfig {
                                        format: dst_format,
                                        tiling: dst_tiling,
                                        disjoint: dst_disjoint,
                                        size: dst_size,
                                    },
                                    intermediate_buffer: use_buffer,
                                    extent: None,
                                };
                                let name = format!(
                                    "{src_tiling_name}{}{}{dst_tiling_name}{}",
                                    if src_disjoint { "_disjoint_" } else { "_" },
                                    if use_buffer { "buffer_" } else { "" },
                                    if dst_disjoint { "_disjoint" } else { "" },
                                );
                                dst_format_group
                                    .add_child(Box::new(MultiplanarXferCase { name, config }) as Box<dyn TestCase>);
                            }
                        }
                    }
                }
            }
            src_format_group.add_child(dst_format_group);
        }

        multiplane_group.add_child(src_format_group);
    }

    multiplane_group
}
