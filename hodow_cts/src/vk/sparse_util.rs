// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/framework/vulkan/vkImageUtil.hpp / .cpp (allocateAndBindSparseImage, checkSparseImageFormatSupport)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The Context has no dedicated sparse queue, so the caller passes whichever queue
// it binds on (the universal one, after `universal_queue_supports_sparse_binding`).

use vulkanalia::prelude::v1_0::*;

use crate::tcu::TestError;
use crate::tcu::pixel::{has_depth_component, has_stencil_component};
use crate::tcu::texture::TextureFormat;
use crate::vk::VkResultExt;
use crate::vk::mem_util::{Allocation, MemoryRequirement, SimpleAllocator};

/// `getImageAspectFlags(tcu::TextureFormat)`
fn get_image_aspect_flags(format: TextureFormat) -> vk::ImageAspectFlags {
    let mut flags = vk::ImageAspectFlags::empty();
    if has_depth_component(format.order) {
        flags |= vk::ImageAspectFlags::DEPTH;
    }
    if has_stencil_component(format.order) {
        flags |= vk::ImageAspectFlags::STENCIL;
    }
    if flags.is_empty() {
        vk::ImageAspectFlags::COLOR
    } else {
        flags
    }
}

/// `mipLevelExtents`
fn mip_level_extents(extent: vk::Extent3D, mip_level: u32) -> vk::Extent3D {
    vk::Extent3D {
        width: (extent.width >> mip_level).max(1),
        height: (extent.height >> mip_level).max(1),
        depth: (extent.depth >> mip_level).max(1),
    }
}

/// True when the queue family can run `vkQueueBindSparse`; the Context only hands out the universal queue.
pub fn universal_queue_supports_sparse_binding(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    queue_family_index: u32,
) -> bool {
    let families = unsafe { instance.get_physical_device_queue_family_properties(physical_device) };
    families
        .get(queue_family_index as usize)
        .is_some_and(|f| f.queue_flags.contains(vk::QueueFlags::SPARSE_BINDING))
}

/// `checkSparseImageFormatSupport` (the `VkImageCreateInfo` overload)
pub fn check_sparse_image_format_support(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    create_info: &vk::ImageCreateInfo,
) -> bool {
    check_sparse_image_format_support_for(
        instance,
        physical_device,
        create_info.format,
        create_info.image_type,
        create_info.samples,
        create_info.usage,
        create_info.tiling,
    )
}

/// `checkSparseImageFormatSupport` (the by-parts overload)
pub fn check_sparse_image_format_support_for(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    format: vk::Format,
    image_type: vk::ImageType,
    samples: vk::SampleCountFlags,
    usage: vk::ImageUsageFlags,
    tiling: vk::ImageTiling,
) -> bool {
    let properties = unsafe {
        instance.get_physical_device_sparse_image_format_properties(
            physical_device,
            format,
            image_type,
            samples,
            usage,
            tiling,
        )
    };
    !properties.is_empty()
}

/// `allocateAndBindSparseImage` - backs every block of every mip level above the mip tail, plus the tail and the metadata,
/// with memory and binds it all in one `vkQueueBindSparse` that signals `signal_semaphore`. The allocations pushed onto
/// `allocations` have to outlive the image.
#[allow(clippy::too_many_arguments)]
pub fn allocate_and_bind_sparse_image<'a>(
    device: &'a Device,
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    image_create_info: &vk::ImageCreateInfo,
    signal_semaphore: vk::Semaphore,
    queue: vk::Queue,
    allocator: &SimpleAllocator,
    allocations: &mut Vec<Allocation<'a>>,
    format: TextureFormat,
    dest_image: vk::Image,
    fence: vk::Fence,
) -> Result<(), TestError> {
    let image_aspect_flags = get_image_aspect_flags(format);
    let device_properties = unsafe { instance.get_physical_device_properties(physical_device) };

    if !check_sparse_image_format_support(instance, physical_device, image_create_info) {
        return Err(TestError::NotSupported(
            "The image format does not support sparse operations.".to_string(),
        ));
    }

    let sparse_image_memory_requirements = unsafe { device.get_image_sparse_memory_requirements(dest_image) };
    assert!(
        !sparse_image_memory_requirements.is_empty(),
        "a sparse image reports at least one sparse memory requirement"
    );

    let mut aspect_indices = Vec::new();
    let mut mem_req_aspect_flags = vk::ImageAspectFlags::empty();
    for (index, requirement) in sparse_image_memory_requirements.iter().enumerate() {
        if requirement.format_properties.aspect_mask.intersects(image_aspect_flags) {
            aspect_indices.push(index);
            mem_req_aspect_flags |= requirement.format_properties.aspect_mask;
        }
    }

    let metadata_aspect_index = sparse_image_memory_requirements.iter().position(|requirement| {
        requirement
            .format_properties
            .aspect_mask
            .contains(vk::ImageAspectFlags::METADATA)
    });

    if mem_req_aspect_flags != image_aspect_flags {
        return Err(TestError::NotSupported(
            "Required image aspect not supported.".to_string(),
        ));
    }

    let memory_requirements = unsafe { device.get_image_memory_requirements(dest_image) };

    let memory_properties = allocator.memory_properties();
    let has_memory_type = (0..memory_properties.memory_type_count).any(|index| {
        memory_requirements.memory_type_bits & (1 << index) != 0
            && MemoryRequirement::ANY.matches_heap(memory_properties.memory_types[index as usize].property_flags)
    });
    if !has_memory_type {
        return Err(TestError::NotSupported("No matching memory type found.".to_string()));
    }

    if memory_requirements.size > device_properties.limits.sparse_address_space_size {
        return Err(TestError::NotSupported(
            "Required memory size for sparse resource exceeds device limits.".to_string(),
        ));
    }

    let mut image_residency_memory_binds: Vec<vk::SparseImageMemoryBind> = Vec::new();
    let mut image_mip_tail_memory_binds: Vec<vk::SparseMemoryBind> = Vec::new();

    for &aspect_index in &aspect_indices {
        let aspect_requirements = sparse_image_memory_requirements[aspect_index];
        let block_size = aspect_requirements.format_properties.image_granularity;

        for layer_ndx in 0..image_create_info.array_layers {
            for mip_level_ndx in 0..aspect_requirements.image_mip_tail_first_lod {
                let mip_extent = mip_level_extents(image_create_info.extent, mip_level_ndx);
                let num_sparse_binds = [
                    mip_extent.width.div_ceil(block_size.width),
                    mip_extent.height.div_ceil(block_size.height),
                    mip_extent.depth.div_ceil(block_size.depth),
                ];
                let last_block_extent = [
                    if !mip_extent.width.is_multiple_of(block_size.width) {
                        mip_extent.width % block_size.width
                    } else {
                        block_size.width
                    },
                    if !mip_extent.height.is_multiple_of(block_size.height) {
                        mip_extent.height % block_size.height
                    } else {
                        block_size.height
                    },
                    if !mip_extent.depth.is_multiple_of(block_size.depth) {
                        mip_extent.depth % block_size.depth
                    } else {
                        block_size.depth
                    },
                ];

                for z in 0..num_sparse_binds[2] {
                    for y in 0..num_sparse_binds[1] {
                        for x in 0..num_sparse_binds[0] {
                            // 28.7.5 alignment shows the block size in bytes
                            let alloc_requirements = vk::MemoryRequirements {
                                size: memory_requirements.alignment,
                                alignment: memory_requirements.alignment,
                                memory_type_bits: memory_requirements.memory_type_bits,
                            };
                            let allocation = allocator.allocate(device, alloc_requirements, MemoryRequirement::ANY)?;

                            let offset = vk::Offset3D {
                                x: (x * block_size.width) as i32,
                                y: (y * block_size.height) as i32,
                                z: (z * block_size.depth) as i32,
                            };
                            let extent = vk::Extent3D {
                                width: if x == num_sparse_binds[0] - 1 {
                                    last_block_extent[0]
                                } else {
                                    block_size.width
                                },
                                height: if y == num_sparse_binds[1] - 1 {
                                    last_block_extent[1]
                                } else {
                                    block_size.height
                                },
                                depth: if z == num_sparse_binds[2] - 1 {
                                    last_block_extent[2]
                                } else {
                                    block_size.depth
                                },
                            };

                            image_residency_memory_binds.push(vk::SparseImageMemoryBind {
                                subresource: vk::ImageSubresource {
                                    aspect_mask: aspect_requirements.format_properties.aspect_mask,
                                    mip_level: mip_level_ndx,
                                    array_layer: layer_ndx,
                                },
                                offset,
                                extent,
                                memory: allocation.get_memory(),
                                memory_offset: allocation.get_offset(),
                                flags: vk::SparseMemoryBindFlags::empty(),
                            });
                            allocations.push(allocation);
                        }
                    }
                }
            }

            // Handle MIP tail. There are two cases to consider here:
            //
            // 1) VK_SPARSE_IMAGE_FORMAT_SINGLE_MIPTAIL_BIT is requested by the driver: each layer needs a separate tail.
            // 2) otherwise:                                                            only one tail is needed.
            if aspect_requirements.image_mip_tail_size > 0
                && (layer_ndx == 0
                    || !aspect_requirements
                        .format_properties
                        .flags
                        .contains(vk::SparseImageFormatFlags::SINGLE_MIPTAIL))
            {
                let alloc_requirements = vk::MemoryRequirements {
                    size: aspect_requirements.image_mip_tail_size,
                    alignment: memory_requirements.alignment,
                    memory_type_bits: memory_requirements.memory_type_bits,
                };
                let allocation = allocator.allocate(device, alloc_requirements, MemoryRequirement::ANY)?;

                image_mip_tail_memory_binds.push(vk::SparseMemoryBind {
                    resource_offset: aspect_requirements.image_mip_tail_offset
                        + layer_ndx as vk::DeviceSize * aspect_requirements.image_mip_tail_stride,
                    size: aspect_requirements.image_mip_tail_size,
                    memory: allocation.get_memory(),
                    memory_offset: allocation.get_offset(),
                    flags: vk::SparseMemoryBindFlags::empty(),
                });
                allocations.push(allocation);
            }

            // Handle Metadata. Similarly to MIP tail in aspectRequirements, there are two cases to consider here:
            //
            // 1) VK_SPARSE_IMAGE_FORMAT_SINGLE_MIPTAIL_BIT is requested by the driver: each layer needs a separate tail.
            // 2) otherwise:
            if let Some(metadata_index) = metadata_aspect_index {
                let metadata_requirements = sparse_image_memory_requirements[metadata_index];

                if layer_ndx == 0
                    || !metadata_requirements
                        .format_properties
                        .flags
                        .contains(vk::SparseImageFormatFlags::SINGLE_MIPTAIL)
                {
                    let alloc_requirements = vk::MemoryRequirements {
                        size: metadata_requirements.image_mip_tail_size,
                        alignment: memory_requirements.alignment,
                        memory_type_bits: memory_requirements.memory_type_bits,
                    };
                    let allocation = allocator.allocate(device, alloc_requirements, MemoryRequirement::ANY)?;

                    image_mip_tail_memory_binds.push(vk::SparseMemoryBind {
                        resource_offset: metadata_requirements.image_mip_tail_offset
                            + layer_ndx as vk::DeviceSize * metadata_requirements.image_mip_tail_stride,
                        size: metadata_requirements.image_mip_tail_size,
                        memory: allocation.get_memory(),
                        memory_offset: allocation.get_offset(),
                        flags: vk::SparseMemoryBindFlags::METADATA,
                    });
                    allocations.push(allocation);
                }
            }
        }
    }

    let image_residency_bind_info = [vk::SparseImageMemoryBindInfo::builder()
        .image(dest_image)
        .binds(&image_residency_memory_binds)
        .build()];
    let image_mip_tail_bind_info = [vk::SparseImageOpaqueMemoryBindInfo::builder()
        .image(dest_image)
        .binds(&image_mip_tail_memory_binds)
        .build()];
    let signal_semaphores = [signal_semaphore];

    let mut bind_sparse_info = vk::BindSparseInfo::builder().signal_semaphores(&signal_semaphores);
    if !image_residency_memory_binds.is_empty() {
        bind_sparse_info = bind_sparse_info.image_binds(&image_residency_bind_info);
    }
    if !image_mip_tail_memory_binds.is_empty() {
        bind_sparse_info = bind_sparse_info.image_opaque_binds(&image_mip_tail_bind_info);
    }

    unsafe { device.queue_bind_sparse(queue, &[bind_sparse_info], fence) }.vk_check("vkQueueBindSparse")?;
    Ok(())
}
