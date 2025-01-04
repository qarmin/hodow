// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageConcurrentCopyTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. No shaders. `HostCopyThread` becomes a scoped thread per region; the
// `VK_EXT_host_image_copy` entry points are the extension ones. `ycbcr::fillRandomNoNaN` is a private helper here, and
// the mismatch report is one log line per mismatching byte (at most ten) without the image logging.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtHostImageCopyExtensionDeviceCommands, InstanceV1_1};

use crate::tcu::float::Float16;
use crate::tcu::random::{Random, de_int32_hash};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::api::object_tests::format_name;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy)]
struct TestParameters {
    format: vk::Format,
    tiling: vk::ImageTiling,
    image_type: vk::ImageType,
    host_copy: bool,
    read: bool,
    single_command: bool,
    random_data: bool,
    create_2d_array_compatible: bool,
}

/// `ycbcr::fillRandomNoNaN`
pub(super) fn fill_random_no_nan(random_gen: &mut Random, data: &mut [u8], format: vk::Format) {
    let (is_float, stride) = match format {
        vk::Format::B10G11R11_UFLOAT_PACK32 => (true, 1usize),
        vk::Format::R16_SFLOAT
        | vk::Format::R16G16_SFLOAT
        | vk::Format::R16G16B16_SFLOAT
        | vk::Format::R16G16B16A16_SFLOAT => (true, 2),
        vk::Format::R32_SFLOAT
        | vk::Format::R32G32_SFLOAT
        | vk::Format::R32G32B32_SFLOAT
        | vk::Format::R32G32B32A32_SFLOAT => (true, 4),
        vk::Format::R64_SFLOAT
        | vk::Format::R64G64_SFLOAT
        | vk::Format::R64G64B64_SFLOAT
        | vk::Format::R64G64B64A64_SFLOAT => (true, 8),
        _ => (false, 1),
    };

    if is_float {
        let size = data.len();
        let mut ndx = 0usize;
        while ndx + stride <= size {
            match stride {
                1 => {
                    // Set first bit of each channel to 0 to avoid NaNs, only format is B10G11R11
                    let mask = [0x7Fu8, 0xDF, 0xFB, 0xFF];
                    // Apply mask for both endians
                    data[ndx] = (random_gen.get_uint8() & mask[ndx % 4]) & mask[3 - ndx % 4];
                }
                2 => data[ndx..ndx + 2].copy_from_slice(&Float16::new(random_gen.get_float()).bits().to_ne_bytes()),
                4 => data[ndx..ndx + 4].copy_from_slice(&random_gen.get_float().to_ne_bytes()),
                _ => data[ndx..ndx + 8].copy_from_slice(&random_gen.get_double().to_ne_bytes()),
            }
            ndx += stride;
        }
        for byte in &mut data[ndx..] {
            *byte = 0;
        }
    } else {
        for byte in data.iter_mut() {
            *byte = random_gen.get_uint8();
        }
    }
}

/// `splitRegion`
fn split_region(random_gen: &mut Random, size: u32, output: &mut Vec<u32>) {
    let mut pos = 0u32;
    while pos < size {
        let mut current = random_gen.get_uint32() % 32 + 1;
        if current + pos > size {
            current = size - pos;
        }
        output.push(current);
        pos += current;
    }
}

/// A region handed to a copy thread; the host pointer inside points at memory that outlives the scope.
struct HostCopyJob {
    region: vk::MemoryToImageCopy,
}

// Safety: the only pointer in a job is the host pointer of the source buffer, which is only read.
unsafe impl Send for HostCopyJob {}

/// `HostCopyThread::run`; the result is `m_failed`.
fn host_copy_thread(
    device: &Device,
    image: vk::Image,
    image_layout: vk::ImageLayout,
    job: HostCopyJob,
    read: bool,
    pixel_size: u32,
) -> Result<bool, TestError> {
    let region = job.region;
    let copy_info = vk::CopyMemoryToImageInfo {
        s_type: vk::StructureType::COPY_MEMORY_TO_IMAGE_INFO,
        next: std::ptr::null(),
        flags: vk::HostImageCopyFlags::empty(),
        dst_image: image,
        dst_image_layout: image_layout,
        region_count: 1,
        regions: &region,
    };
    unsafe { device.copy_memory_to_image_ext(&copy_info) }.vk_check("vkCopyMemoryToImageEXT")?;

    let mut failed = false;

    if read {
        let mut data = vec![
            0u8;
            (region.image_extent.width * region.image_extent.height * region.image_extent.depth * pixel_size)
                as usize
        ];

        let read_region = vk::ImageToMemoryCopy {
            s_type: vk::StructureType::IMAGE_TO_MEMORY_COPY,
            next: std::ptr::null(),
            host_pointer: data.as_mut_ptr().cast(),
            memory_row_length: 0,
            memory_image_height: 0,
            image_subresource: region.image_subresource,
            image_offset: region.image_offset,
            image_extent: region.image_extent,
        };
        let read_info = vk::CopyImageToMemoryInfo {
            s_type: vk::StructureType::COPY_IMAGE_TO_MEMORY_INFO,
            next: std::ptr::null(),
            flags: vk::HostImageCopyFlags::empty(),
            src_image: image,
            src_image_layout: image_layout,
            region_count: 1,
            regions: &read_region,
        };

        unsafe { device.copy_image_to_memory_ext(&read_info) }.vk_check("vkCopyImageToMemoryEXT")?;

        let row_length = (region.image_extent.width * pixel_size) as usize;
        for k in 0..region.image_extent.depth {
            for j in 0..region.image_extent.height {
                let src_offset = ((region.memory_row_length * j
                    + region.memory_row_length * region.memory_image_height * k)
                    * pixel_size) as usize;
                let src =
                    unsafe { std::slice::from_raw_parts(region.host_pointer.cast::<u8>().add(src_offset), row_length) };
                let dst_offset = ((region.image_extent.width * j
                    + region.image_extent.width * region.image_extent.height * k)
                    * pixel_size) as usize;
                if src != &data[dst_offset..dst_offset + row_length] {
                    failed = true;
                }
            }
        }
    }

    Ok(failed)
}

fn run_iterate(context: &Context<'_>, params: TestParameters) -> TestOutcome {
    let vk = context.get_device();
    let allocator = context.get_default_allocator();
    let queue_family_index = context.get_universal_queue_family_index();
    let queue = context.get_universal_queue();

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let width = 128u32;
    let height = 128u32;
    let depth = if params.image_type == vk::ImageType::_3D {
        32u32
    } else {
        1
    };

    let image_layout = if params.read {
        vk::ImageLayout::GENERAL
    } else {
        vk::ImageLayout::TRANSFER_DST_OPTIMAL
    };

    let subresource_range = make_image_subresource_range(
        vk::ImageAspectFlags::COLOR,
        0,
        1,
        0,
        if params.create_2d_array_compatible { depth } else { 1 },
    );

    let pixel_size = crate::tcu::texture::map_vk_format(params.format)
        .and_then(|f| f.pixel_size())
        .ok_or_else(|| TestError::InternalError("no pixel size".to_string()))?;
    let buffer_size = width * height * depth * pixel_size;
    let mut test_data = vec![0u8; buffer_size as usize];
    let mut random_gen = Random::new(de_int32_hash(params.format.as_raw()) ^ de_int32_hash(buffer_size as i32));
    if params.random_data {
        fill_random_no_nan(&mut random_gen, &mut test_data, params.format);
    } else {
        for i in 0..width {
            for j in 0..height {
                for k in 0..depth {
                    let p = (i + j * width + k * width * height) as usize;
                    let v = i.max(j).max(k);
                    if pixel_size == 1 {
                        test_data[p] = (v % 256) as u8;
                    } else if pixel_size == 2 {
                        test_data[p * 2..p * 2 + 2].copy_from_slice(&(v as u16).to_ne_bytes());
                    } else {
                        for l in 0..pixel_size / 4 {
                            let offset = (p * pixel_size as usize / 4 + l as usize) * 4;
                            test_data[offset..offset + 4].copy_from_slice(&(v + l).to_ne_bytes());
                        }
                    }
                }
            }
        }
    }

    let src_buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(u64::from(buffer_size), vk::BufferUsageFlags::TRANSFER_SRC),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let dst_buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(u64::from(buffer_size), vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let src_buffer_alloc = src_buffer.get_allocation();
    unsafe {
        std::ptr::copy_nonoverlapping(
            test_data.as_ptr(),
            src_buffer_alloc.get_host_ptr(),
            buffer_size as usize,
        )
    };
    flush_alloc(vk, src_buffer_alloc)?;

    let mut usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    if params.host_copy {
        usage |= vk::ImageUsageFlags::HOST_TRANSFER;
    }

    let image_create_flags = if params.create_2d_array_compatible {
        vk::ImageCreateFlags::_2D_ARRAY_COMPATIBLE
    } else {
        vk::ImageCreateFlags::empty()
    };

    let image_create_info = vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: image_create_flags,
        image_type: params.image_type,
        format: params.format,
        extent: vk::Extent3D { width, height, depth },
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: params.tiling,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    };

    let image = ImageWithMemory::new(vk, allocator, image_create_info, MemoryRequirement::ANY)?;

    let mut widths = Vec::new();
    let mut heights = Vec::new();
    let mut depths = Vec::new();
    if !params.create_2d_array_compatible {
        split_region(&mut random_gen, width, &mut widths);
        split_region(&mut random_gen, height, &mut heights);
        if params.image_type == vk::ImageType::_2D {
            depths.push(1);
        } else {
            split_region(&mut random_gen, depth, &mut depths);
        }
    } else {
        widths.push(width);
        heights.push(height);
        split_region(&mut random_gen, depth, &mut depths);
    }

    let mut regions: Vec<vk::BufferImageCopy> = Vec::new();
    let mut pos_width = 0u32;
    for &w in &widths {
        let mut pos_height = 0u32;
        for &h in &heights {
            let mut pos_depth = 0u32;
            for &d in &depths {
                regions.push(vk::BufferImageCopy {
                    buffer_offset: u64::from(
                        (width * height * pos_depth + width * pos_height + pos_width) * pixel_size,
                    ),
                    buffer_row_length: width,
                    buffer_image_height: height,
                    image_subresource: vk::ImageSubresourceLayers {
                        aspect_mask: vk::ImageAspectFlags::COLOR,
                        mip_level: 0,
                        base_array_layer: 0,
                        layer_count: 1,
                    },
                    image_offset: vk::Offset3D {
                        x: pos_width as i32,
                        y: pos_height as i32,
                        z: pos_depth as i32,
                    },
                    image_extent: vk::Extent3D {
                        width: w,
                        height: h,
                        depth: d,
                    },
                });

                pos_depth += d;
            }
            pos_height += h;
        }
        pos_width += w;
    }

    if params.host_copy {
        if !params.create_2d_array_compatible || params.single_command {
            let transition = vk::HostImageLayoutTransitionInfo {
                s_type: vk::StructureType::HOST_IMAGE_LAYOUT_TRANSITION_INFO,
                next: std::ptr::null(),
                image: image.get(),
                old_layout: vk::ImageLayout::UNDEFINED,
                new_layout: image_layout,
                subresource_range,
            };
            unsafe { vk.transition_image_layout_ext(&[transition]) }.vk_check("vkTransitionImageLayoutEXT")?;
        }

        let host_base = src_buffer_alloc.get_host_ptr();
        let memory_to_image_copies: Vec<vk::MemoryToImageCopy> = regions
            .iter()
            .map(|region| vk::MemoryToImageCopy {
                s_type: vk::StructureType::MEMORY_TO_IMAGE_COPY,
                next: std::ptr::null(),
                host_pointer: unsafe { host_base.add(region.buffer_offset as usize) }
                    .cast_const()
                    .cast(),
                memory_row_length: region.buffer_row_length,
                memory_image_height: region.buffer_image_height,
                image_subresource: region.image_subresource,
                image_offset: region.image_offset,
                image_extent: region.image_extent,
            })
            .collect();

        if params.single_command {
            let copy_info = vk::CopyMemoryToImageInfo {
                s_type: vk::StructureType::COPY_MEMORY_TO_IMAGE_INFO,
                next: std::ptr::null(),
                flags: vk::HostImageCopyFlags::empty(),
                dst_image: image.get(),
                dst_image_layout: image_layout,
                region_count: memory_to_image_copies.len() as u32,
                regions: memory_to_image_copies.as_ptr(),
            };
            unsafe { vk.copy_memory_to_image_ext(&copy_info) }.vk_check("vkCopyMemoryToImageEXT")?;
        } else {
            let batch_size = 256usize;
            let num_batches = memory_to_image_copies.len() / batch_size + 1;

            for batch in 0..num_batches {
                let from = batch * batch_size;
                let to = ((batch + 1) * batch_size).min(memory_to_image_copies.len());

                let any_failed = std::thread::scope(|scope| -> Result<bool, TestError> {
                    let mut threads = Vec::new();

                    for region in &memory_to_image_copies[from..to] {
                        let job = HostCopyJob { region: *region };
                        let image_handle = image.get();
                        let read = params.read;

                        if params.create_2d_array_compatible {
                            let layers_subresource_range = make_image_subresource_range(
                                vk::ImageAspectFlags::COLOR,
                                0,
                                1,
                                region.image_offset.z as u32,
                                region.image_extent.depth,
                            );
                            let transition = vk::HostImageLayoutTransitionInfo {
                                s_type: vk::StructureType::HOST_IMAGE_LAYOUT_TRANSITION_INFO,
                                next: std::ptr::null(),
                                image: image_handle,
                                old_layout: vk::ImageLayout::UNDEFINED,
                                new_layout: image_layout,
                                subresource_range: layers_subresource_range,
                            };
                            unsafe { vk.transition_image_layout_ext(&[transition]) }
                                .vk_check("vkTransitionImageLayoutEXT")?;
                        }
                        threads
                            .push(scope.spawn(move || {
                                host_copy_thread(vk, image_handle, image_layout, job, read, pixel_size)
                            }));
                    }

                    let mut failed = false;
                    for thread in threads {
                        match thread.join() {
                            Ok(result) => failed |= result?,
                            Err(_) => return Err(TestError::InternalError("a host copy thread panicked".to_string())),
                        }
                    }
                    Ok(failed)
                })?;

                if any_failed {
                    return Ok(TestStatus::fail("Fail"));
                }
            }
        }
    } else {
        if !params.create_2d_array_compatible || params.single_command {
            begin_command_buffer(vk, cmd)?;
            let pre_image_memory_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                image_layout,
                image.get(),
                subresource_range,
            );
            unsafe {
                vk.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::empty(),
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre_image_memory_barrier],
                );
            }
            end_command_buffer(vk, cmd)?;
            submit_commands_and_wait(vk, queue, cmd)?;
        }

        begin_command_buffer(vk, cmd)?;
        if params.single_command {
            unsafe { vk.cmd_copy_buffer_to_image(cmd, src_buffer.get(), image.get(), image_layout, &regions) };
        } else {
            for region in &regions {
                if params.create_2d_array_compatible {
                    let layers_subresource_range = make_image_subresource_range(
                        vk::ImageAspectFlags::COLOR,
                        0,
                        1,
                        region.image_offset.z as u32,
                        region.image_extent.depth,
                    );
                    let pre_image_memory_barrier = make_image_memory_barrier(
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        image_layout,
                        image.get(),
                        layers_subresource_range,
                    );
                    unsafe {
                        vk.cmd_pipeline_barrier(
                            cmd,
                            vk::PipelineStageFlags::empty(),
                            vk::PipelineStageFlags::TRANSFER,
                            vk::DependencyFlags::empty(),
                            &[] as &[vk::MemoryBarrier],
                            &[] as &[vk::BufferMemoryBarrier],
                            &[pre_image_memory_barrier],
                        );
                    }
                }
                unsafe {
                    vk.cmd_copy_buffer_to_image(
                        cmd,
                        src_buffer.get(),
                        image.get(),
                        image_layout,
                        std::slice::from_ref(region),
                    )
                };
            }
        }
        end_command_buffer(vk, cmd)?;
        submit_commands_and_wait(vk, queue, cmd)?;
    }

    begin_command_buffer(vk, cmd)?;
    if !params.create_2d_array_compatible {
        let post_image_memory_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            image_layout,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
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
                &[post_image_memory_barrier],
            );
        }

        let region = vk::BufferImageCopy {
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
            image_extent: vk::Extent3D { width, height, depth },
        };
        unsafe {
            vk.cmd_copy_image_to_buffer(
                cmd,
                image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                dst_buffer.get(),
                &[region],
            )
        };
    } else {
        // Create a random order in which the layers will be copied
        let mut layer_ndx: Vec<u32> = (0..depth).collect();
        for i in 0..depth {
            let random_index = i + (random_gen.get_uint32() % (depth - i));
            layer_ndx.swap(i as usize, random_index as usize);
        }

        for j in 0..depth {
            let i = layer_ndx[j as usize];
            let layer_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, i, 1);
            // Alternate between transfer src optimal and general layouts
            let layout = if j % 2 == 0 {
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL
            } else {
                vk::ImageLayout::GENERAL
            };
            let post_image_memory_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                image_layout,
                layout,
                image.get(),
                layer_subresource_range,
            );
            unsafe {
                vk.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[post_image_memory_barrier],
                );
            }

            let region = vk::BufferImageCopy {
                buffer_offset: u64::from(width * height * i * pixel_size),
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: vk::ImageSubresourceLayers {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    mip_level: 0,
                    base_array_layer: 0,
                    layer_count: 1,
                },
                image_offset: vk::Offset3D {
                    x: 0,
                    y: 0,
                    z: i as i32,
                },
                image_extent: vk::Extent3D {
                    width,
                    height,
                    depth: 1,
                },
            };
            unsafe { vk.cmd_copy_image_to_buffer(cmd, image.get(), layout, dst_buffer.get(), &[region]) };
        }
    }
    end_command_buffer(vk, cmd)?;
    submit_commands_and_wait(vk, queue, cmd)?;

    let dst_buffer_alloc = dst_buffer.get_allocation();
    invalidate_alloc(vk, dst_buffer_alloc)?;
    let src_data =
        unsafe { std::slice::from_raw_parts(src_buffer_alloc.get_host_ptr().cast_const(), buffer_size as usize) };
    let dst_data =
        unsafe { std::slice::from_raw_parts(dst_buffer_alloc.get_host_ptr().cast_const(), buffer_size as usize) };
    if src_data != dst_data {
        let mut remaining_fails = 10;
        for (i, (src, dst)) in src_data.iter().zip(dst_data).enumerate() {
            if src != dst {
                if remaining_fails > 0 {
                    log::info!("Mismatch at byte {i}. Src value: {src}, dst value: {dst}.");
                    remaining_fails -= 1;
                } else {
                    log::info!(".. more mismatches not shown ..");
                    break;
                }
            }
        }
        return Ok(TestStatus::fail("Fail"));
    }

    Ok(TestStatus::pass("Pass"))
}

struct ConcurrentCopyTestCase {
    name: &'static str,
    params: TestParameters,
}

impl TestCase for ConcurrentCopyTestCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = self.params;

        if params.host_copy {
            context.require_device_functionality("VK_EXT_host_image_copy")?;
        }

        let mut usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        if params.host_copy {
            usage |= vk::ImageUsageFlags::HOST_TRANSFER;
        }

        let result = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                params.format,
                params.image_type,
                params.tiling,
                usage,
                vk::ImageCreateFlags::empty(),
            )
        };

        if result.is_err() {
            return Err(TestError::NotSupported("Format unsupported".to_string()));
        }

        if params.host_copy {
            let required_dst_layout = if params.read {
                vk::ImageLayout::GENERAL
            } else {
                vk::ImageLayout::TRANSFER_DST_OPTIMAL
            };

            let mut host_image_copy_properties = vk::PhysicalDeviceHostImageCopyProperties::default();
            {
                let mut properties2 =
                    vk::PhysicalDeviceProperties2::builder().push_next(&mut host_image_copy_properties);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                };
            }
            let mut src_layouts =
                vec![vk::ImageLayout::UNDEFINED; host_image_copy_properties.copy_src_layout_count as usize];
            let mut dst_layouts =
                vec![vk::ImageLayout::UNDEFINED; host_image_copy_properties.copy_dst_layout_count as usize];
            host_image_copy_properties.copy_src_layouts = src_layouts.as_mut_ptr();
            host_image_copy_properties.copy_dst_layouts = dst_layouts.as_mut_ptr();
            {
                let mut properties2 =
                    vk::PhysicalDeviceProperties2::builder().push_next(&mut host_image_copy_properties);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                };
            }
            if !dst_layouts.contains(&required_dst_layout) {
                return Err(TestError::NotSupported(
                    "Required layout not supported in VkPhysicalDeviceHostImageCopyPropertiesEXT::pCopyDstLayouts"
                        .to_string(),
                ));
            }
        }

        if params.create_2d_array_compatible {
            context.require_device_functionality("VK_KHR_maintenance9")?;
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ConcurrentCopyTestInstance {
            context,
            params: self.params,
        })
    }
}

struct ConcurrentCopyTestInstance<'a> {
    context: &'a Context<'a>,
    params: TestParameters,
}

impl TestInstance for ConcurrentCopyTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_iterate(self.context, self.params)
    }
}

/// `createImageConcurrentCopyTests`
pub fn create_image_concurrent_copy_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("concurrent_copy");

    // The `std::set`s upstream iterates in enum value order
    let formats = [
        vk::Format::R8_UNORM,
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R32G32_SFLOAT,
    ];
    let tilings = [
        (vk::ImageTiling::OPTIMAL, "vk_image_tiling_optimal"),
        (vk::ImageTiling::LINEAR, "vk_image_tiling_linear"),
    ];
    let types = [
        (vk::ImageType::_2D, "vk_image_type_2d"),
        (vk::ImageType::_3D, "vk_image_type_3d"),
    ];
    let copy_types = [(false, "device"), (true, "host")];
    let access_types = [(false, "write"), (true, "read_and_write")];
    let command_types = [(true, "single"), (false, "multiple")];
    let data_types = [(true, "random"), (false, "gradient")];
    let image_flags = [(false, "none"), (true, "2d_array_compatible")];

    for format in formats {
        let mut format_group = TestCaseGroup::new(format!("vk_format_{}", format_name(format)));
        for (tiling, tiling_name) in tilings {
            let mut tiling_group = TestCaseGroup::new(tiling_name);
            for (image_type, type_name) in types {
                let mut type_group = TestCaseGroup::new(type_name);
                for (single_command, command_name) in command_types {
                    let mut command_type_group = TestCaseGroup::new(command_name);
                    for (random_data, data_name) in data_types {
                        let mut data_type_group = TestCaseGroup::new(data_name);
                        for (host_copy, copy_name) in copy_types {
                            let mut copy_type_group = TestCaseGroup::new(copy_name);
                            for (read, access_name) in access_types {
                                if read && !host_copy {
                                    continue;
                                }

                                let mut access_type_group = TestCaseGroup::new(access_name);

                                for (create_2d_array_compatible, flag_name) in image_flags {
                                    if image_type != vk::ImageType::_3D && create_2d_array_compatible {
                                        continue;
                                    }

                                    let params = TestParameters {
                                        format,
                                        tiling,
                                        image_type,
                                        host_copy,
                                        read,
                                        single_command,
                                        random_data,
                                        create_2d_array_compatible,
                                    };

                                    access_type_group.add_child(Box::new(ConcurrentCopyTestCase {
                                        name: flag_name,
                                        params,
                                    })
                                        as Box<dyn TestCase>);
                                }
                                copy_type_group.add_child(access_type_group);
                            }
                            data_type_group.add_child(copy_type_group);
                        }
                        command_type_group.add_child(data_type_group);
                    }
                    type_group.add_child(command_type_group);
                }
                tiling_group.add_child(type_group);
            }
            format_group.add_child(tiling_group);
        }
        test_group.add_child(format_group);
    }

    test_group
}
