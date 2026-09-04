// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/framework/vulkan/vkImageWithMemory.hpp
//   external/vulkancts/framework/vulkan/vkImageUtil.hpp / .cpp
//   external/vulkancts/framework/vulkan/vkBarrierUtil.hpp (image barriers)
//   external/vulkancts/framework/vulkan/vkObjUtil.hpp (makeImage*, makeBufferImageCopy)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Ported on demand: only the 2D,
// single-mip, single-layer paths the compute tests use. Anything else is absent
// rather than approximated.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::mem_util::{Allocation, MemoryRequirement, SimpleAllocator};
use crate::vk::ref_util::Unique;

/// `vk::makeImageCreateInfo` for a 2D image.
pub fn make_image_create_info(size: crate::tcu::IVec2, format: vk::Format, usage: vk::ImageUsageFlags) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::empty(),
        image_type: vk::ImageType::_2D,
        format,
        extent: vk::Extent3D {
            width: size.x() as u32,
            height: size.y() as u32,
            depth: 1,
        },
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::OPTIMAL,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    }
}

/// `vk::makeImageSubresourceRange`
pub fn make_image_subresource_range(
    aspect_mask: vk::ImageAspectFlags,
    base_mip_level: u32,
    level_count: u32,
    base_array_layer: u32,
    layer_count: u32,
) -> vk::ImageSubresourceRange {
    vk::ImageSubresourceRange {
        aspect_mask,
        base_mip_level,
        level_count,
        base_array_layer,
        layer_count,
    }
}

/// `vk::makeImageSubresourceLayers`
pub fn make_image_subresource_layers(aspect_mask: vk::ImageAspectFlags, mip_level: u32, base_array_layer: u32, layer_count: u32) -> vk::ImageSubresourceLayers {
    vk::ImageSubresourceLayers {
        aspect_mask,
        mip_level,
        base_array_layer,
        layer_count,
    }
}

/// `vk::makeImageView` for a 2D view of the whole image.
pub fn make_image_view(
    device: &Device,
    image: vk::Image,
    view_type: vk::ImageViewType,
    format: vk::Format,
    subresource_range: vk::ImageSubresourceRange,
) -> Result<Unique<'_, vk::ImageView>, TestError> {
    let info = vk::ImageViewCreateInfo::builder()
        .image(image)
        .view_type(view_type)
        .format(format)
        .components(vk::ComponentMapping {
            r: vk::ComponentSwizzle::IDENTITY,
            g: vk::ComponentSwizzle::IDENTITY,
            b: vk::ComponentSwizzle::IDENTITY,
            a: vk::ComponentSwizzle::IDENTITY,
        })
        .subresource_range(subresource_range);
    let view = unsafe { device.create_image_view(&info, None) }.vk_check("vkCreateImageView")?;
    Ok(Unique::new(device, view))
}

/// `vk::makeImageMemoryBarrier`
pub fn make_image_memory_barrier(
    src_access_mask: vk::AccessFlags,
    dst_access_mask: vk::AccessFlags,
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
    image: vk::Image,
    subresource_range: vk::ImageSubresourceRange,
) -> vk::ImageMemoryBarrier {
    vk::ImageMemoryBarrier {
        s_type: vk::StructureType::IMAGE_MEMORY_BARRIER,
        next: std::ptr::null(),
        src_access_mask,
        dst_access_mask,
        old_layout,
        new_layout,
        src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        image,
        subresource_range,
    }
}

/// `vk::makeBufferImageCopy` for a 2D region covering the whole image.
pub fn make_buffer_image_copy(extent: vk::Extent3D, subresource_layers: vk::ImageSubresourceLayers) -> vk::BufferImageCopy {
    vk::BufferImageCopy {
        buffer_offset: 0,
        buffer_row_length: 0,
        buffer_image_height: 0,
        image_subresource: subresource_layers,
        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        image_extent: extent,
    }
}

/// `vk::ImageWithMemory` - an image plus the allocation backing it, bound together.
pub struct ImageWithMemory<'a> {
    image: Unique<'a, vk::Image>,
    #[allow(dead_code)]
    allocation: Allocation<'a>,
}

impl<'a> ImageWithMemory<'a> {
    pub fn new(device: &'a Device, allocator: &SimpleAllocator, image_create_info: vk::ImageCreateInfo, requirement: MemoryRequirement) -> Result<Self, TestError> {
        let image = unsafe { device.create_image(&image_create_info, None) }.vk_check("vkCreateImage")?;
        let image = Unique::new(device, image);

        let req = unsafe { device.get_image_memory_requirements(*image) };
        let allocation = allocator.allocate(device, req, requirement)?;

        unsafe { device.bind_image_memory(*image, allocation.get_memory(), allocation.get_offset()) }.vk_check("vkBindImageMemory")?;

        Ok(Self { image, allocation })
    }

    /// `allocateAndBindImageMemory` with `ALLOCATION_KIND_DEDICATED`.
    pub fn new_dedicated(device: &'a Device, allocator: &SimpleAllocator, image_create_info: vk::ImageCreateInfo, requirement: MemoryRequirement) -> Result<Self, TestError> {
        let image = unsafe { device.create_image(&image_create_info, None) }.vk_check("vkCreateImage")?;
        let image = Unique::new(device, image);

        let req = unsafe { device.get_image_memory_requirements(*image) };
        let allocation = allocator.allocate_dedicated_image(device, req, requirement, *image)?;

        unsafe { device.bind_image_memory(*image, allocation.get_memory(), allocation.get_offset()) }.vk_check("vkBindImageMemory")?;

        Ok(Self { image, allocation })
    }

    pub fn get(&self) -> vk::Image {
        *self.image
    }

    pub fn get_allocation(&self) -> &Allocation<'a> {
        &self.allocation
    }
}

impl std::ops::Deref for ImageWithMemory<'_> {
    type Target = vk::Image;

    fn deref(&self) -> &vk::Image {
        &self.image
    }
}
