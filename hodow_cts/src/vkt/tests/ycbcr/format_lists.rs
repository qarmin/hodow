// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/framework/vulkan/generated/vulkan/vkFormatLists.inl
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the `formats::` lists the ycbcr
// groups read, in upstream's order.

use vulkanalia::vk;

/// `formats::disjointPlanesFormats`
pub static DISJOINT_PLANES_FORMATS: &[vk::Format] = &[
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
    vk::Format::G16_B16_R16_3PLANE_444_UNORM,
    vk::Format::G8_B8R8_2PLANE_444_UNORM,
    vk::Format::G10X6_B10X6R10X6_2PLANE_444_UNORM_3PACK16,
    vk::Format::G12X4_B12X4R12X4_2PLANE_444_UNORM_3PACK16,
    vk::Format::G16_B16R16_2PLANE_444_UNORM,
];

/// `formats::xChromaSubsampledFormats`
pub static XCHROMA_SUBSAMPLED_FORMATS: &[vk::Format] = &[
    vk::Format::G8B8G8R8_422_UNORM,
    vk::Format::B8G8R8G8_422_UNORM,
    vk::Format::G8_B8_R8_3PLANE_422_UNORM,
    vk::Format::G8_B8R8_2PLANE_422_UNORM,
    vk::Format::G10X6B10X6G10X6R10X6_422_UNORM_4PACK16,
    vk::Format::B10X6G10X6R10X6G10X6_422_UNORM_4PACK16,
    vk::Format::G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16,
    vk::Format::G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16,
    vk::Format::G12X4B12X4G12X4R12X4_422_UNORM_4PACK16,
    vk::Format::B12X4G12X4R12X4G12X4_422_UNORM_4PACK16,
    vk::Format::G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16,
    vk::Format::G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16,
    vk::Format::G16B16G16R16_422_UNORM,
    vk::Format::B16G16R16G16_422_UNORM,
    vk::Format::G16_B16_R16_3PLANE_422_UNORM,
    vk::Format::G16_B16R16_2PLANE_422_UNORM,
];

/// `formats::xyChromaSubsampledFormats`
pub static XYCHROMA_SUBSAMPLED_FORMATS: &[vk::Format] = &[
    vk::Format::G8_B8_R8_3PLANE_420_UNORM,
    vk::Format::G8_B8R8_2PLANE_420_UNORM,
    vk::Format::G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16,
    vk::Format::G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16,
    vk::Format::G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16,
    vk::Format::G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16,
    vk::Format::G16_B16_R16_3PLANE_420_UNORM,
    vk::Format::G16_B16R16_2PLANE_420_UNORM,
];
