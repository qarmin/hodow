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

/// `getDepthCopyFormat`
pub fn get_depth_copy_format(combined_format: vk::Format) -> Option<crate::tcu::TextureFormat> {
    match combined_format {
        vk::Format::D16_UNORM | vk::Format::X8_D24_UNORM_PACK32 | vk::Format::D32_SFLOAT => crate::tcu::map_vk_format(combined_format),
        vk::Format::D16_UNORM_S8_UINT => crate::tcu::map_vk_format(vk::Format::D16_UNORM),
        vk::Format::D24_UNORM_S8_UINT => crate::tcu::map_vk_format(vk::Format::X8_D24_UNORM_PACK32),
        vk::Format::D32_SFLOAT_S8_UINT => crate::tcu::map_vk_format(vk::Format::D32_SFLOAT),
        _ => None,
    }
}

/// `getStencilCopyFormat`
pub fn get_stencil_copy_format(combined_format: vk::Format) -> Option<crate::tcu::TextureFormat> {
    match combined_format {
        vk::Format::S8_UINT | vk::Format::D16_UNORM_S8_UINT | vk::Format::D24_UNORM_S8_UINT | vk::Format::D32_SFLOAT_S8_UINT => crate::tcu::map_vk_format(vk::Format::S8_UINT),
        _ => None,
    }
}

/// `vkt::image::isPackedType`
///
/// A packed channel type stores several components in one machine word, so its shader
/// format qualifier cannot be built from the order and the per-channel size.
pub fn is_packed_type(format: crate::tcu::TextureFormat) -> bool {
    use crate::tcu::texture::ChannelType::*;
    matches!(
        format.type_,
        UNORM_BYTE_44
            | UNORM_SHORT_565
            | UNORM_SHORT_555
            | UNORM_SHORT_4444
            | UNORM_SHORT_5551
            | UNORM_SHORT_1555
            | UNORM_INT_101010
            | SNORM_INT_1010102_REV
            | UNORM_INT_1010102_REV
            | UNSIGNED_BYTE_44
            | UNSIGNED_SHORT_565
            | UNSIGNED_SHORT_4444
            | UNSIGNED_SHORT_5551
            | SIGNED_INT_1010102_REV
            | UNSIGNED_INT_1010102_REV
            | USCALED_INT_1010102_REV
            | SSCALED_INT_1010102_REV
            | UNSIGNED_INT_11F_11F_10F_REV
            | UNSIGNED_INT_999_E5_REV
            | UNSIGNED_INT_16_8_8
            | UNSIGNED_INT_24_8
            | UNSIGNED_INT_24_8_REV
            | FLOAT_UNSIGNED_INT_24_8_REV
    )
}

/// `vkt::image::getShaderImageFormatQualifier`
///
/// The GLSL layout qualifier a storage image of this format must be declared with.
/// `None` where upstream would DE_FATAL - a format that has no qualifier is one no
/// ported test may declare.
pub fn get_shader_image_format_qualifier(format: crate::tcu::TextureFormat, vk_format: vk::Format) -> Option<String> {
    use crate::tcu::texture::ChannelOrder::*;
    use crate::tcu::texture::ChannelType::*;

    if is_packed_type(format) {
        return match vk_format {
            vk::Format::B10G11R11_UFLOAT_PACK32 => Some("r11f_g11f_b10f".to_string()),
            vk::Format::A2B10G10R10_UNORM_PACK32 | vk::Format::A2R10G10B10_UNORM_PACK32 => Some("rgb10_a2".to_string()),
            vk::Format::A2B10G10R10_UINT_PACK32 | vk::Format::A2R10G10B10_UINT_PACK32 => Some("rgb10_a2ui".to_string()),
            _ => None,
        };
    }

    let order_part = match format.order {
        R | A | I | sR => "r",
        RG | RA | sRG => "rg",
        RGB | BGR | sRGB | sBGR => "rgb",
        RGBA | BGRA | ARGB | ABGR | sRGBA | sBGRA => "rgba",
        _ => return None,
    };

    let type_part = match format.type_ {
        FLOAT => "32f",
        HALF_FLOAT => "16f",
        UNSIGNED_INT64 => "64ui",
        UNSIGNED_INT32 => "32ui",
        USCALED_INT16 | UNSIGNED_INT16 => "16ui",
        USCALED_INT8 | UNSIGNED_INT8 => "8ui",
        SIGNED_INT64 => "64i",
        SIGNED_INT32 => "32i",
        SSCALED_INT16 | SIGNED_INT16 => "16i",
        SSCALED_INT8 | SIGNED_INT8 => "8i",
        UNORM_INT16 => "16",
        UNORM_INT8 => "8",
        SNORM_INT16 => "16_snorm",
        SNORM_INT8 => "8_snorm",
        _ => return None,
    };

    Some(format!("{order_part}{type_part}"))
}

/// `vkt::api::isSupportedImageLoadStore`
pub fn is_supported_image_load_store(format: crate::tcu::TextureFormat, vk_format: vk::Format) -> bool {
    use crate::tcu::texture::ChannelOrder;
    use crate::tcu::texture::ChannelType::*;

    if is_packed_type(format) {
        return matches!(vk_format, vk::Format::A2B10G10R10_UNORM_PACK32 | vk::Format::A2B10G10R10_UINT_PACK32);
    }
    if format.order != ChannelOrder::RGBA {
        return false;
    }
    matches!(
        format.type_,
        FLOAT | HALF_FLOAT | UNSIGNED_INT32 | UNSIGNED_INT16 | UNSIGNED_INT8 | SIGNED_INT32 | SIGNED_INT16 | SIGNED_INT8 | UNORM_INT16 | UNORM_INT8 | SNORM_INT16 | SNORM_INT8
    )
}
