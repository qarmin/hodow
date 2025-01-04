// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiImageClearingTests.cpp
//     (colorImageFormatsToTest, getFormatCaseName)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Extracted from the upstream array with line comments stripped first. That matters:
// the block-compressed formats are commented out there ("tcu::TextureFormat does not
// support them yet"), and a naive scan pulls 62 of them in - formats
// vkCmdClearColorImage cannot even take. The count is asserted against the mustpass
// list rather than trusted.
//
// The case name is the enum name lowercased with VK_FORMAT_ removed, and with the
// vendor suffix removed too, because upstream's getFormatStr prints the core name for
// an aliased format - the mustpass has `a4b4g4r4_unorm_pack16`, not `..._ext`.

use vulkanalia::vk;

/// `colorImageFormatsToTest`, paired with the name each case is registered under.
pub static COLOR_IMAGE_FORMATS_TO_TEST: &[(vk::Format, &str)] = &[
    (vk::Format::R4G4_UNORM_PACK8, "r4g4_unorm_pack8"),
    (vk::Format::R4G4B4A4_UNORM_PACK16, "r4g4b4a4_unorm_pack16"),
    (vk::Format::B4G4R4A4_UNORM_PACK16, "b4g4r4a4_unorm_pack16"),
    (vk::Format::R5G6B5_UNORM_PACK16, "r5g6b5_unorm_pack16"),
    (vk::Format::B5G6R5_UNORM_PACK16, "b5g6r5_unorm_pack16"),
    (vk::Format::R5G5B5A1_UNORM_PACK16, "r5g5b5a1_unorm_pack16"),
    (vk::Format::B5G5R5A1_UNORM_PACK16, "b5g5r5a1_unorm_pack16"),
    (vk::Format::A1R5G5B5_UNORM_PACK16, "a1r5g5b5_unorm_pack16"),
    (vk::Format::A1B5G5R5_UNORM_PACK16, "a1b5g5r5_unorm_pack16"),
    (vk::Format::R8_UNORM, "r8_unorm"),
    (vk::Format::R8_SNORM, "r8_snorm"),
    (vk::Format::R8_USCALED, "r8_uscaled"),
    (vk::Format::R8_SSCALED, "r8_sscaled"),
    (vk::Format::R8_UINT, "r8_uint"),
    (vk::Format::R8_SINT, "r8_sint"),
    (vk::Format::R8_SRGB, "r8_srgb"),
    (vk::Format::A8_UNORM, "a8_unorm"),
    (vk::Format::R8G8_UNORM, "r8g8_unorm"),
    (vk::Format::R8G8_SNORM, "r8g8_snorm"),
    (vk::Format::R8G8_USCALED, "r8g8_uscaled"),
    (vk::Format::R8G8_SSCALED, "r8g8_sscaled"),
    (vk::Format::R8G8_UINT, "r8g8_uint"),
    (vk::Format::R8G8_SINT, "r8g8_sint"),
    (vk::Format::R8G8_SRGB, "r8g8_srgb"),
    (vk::Format::R8G8B8_UNORM, "r8g8b8_unorm"),
    (vk::Format::R8G8B8_SNORM, "r8g8b8_snorm"),
    (vk::Format::R8G8B8_USCALED, "r8g8b8_uscaled"),
    (vk::Format::R8G8B8_SSCALED, "r8g8b8_sscaled"),
    (vk::Format::R8G8B8_UINT, "r8g8b8_uint"),
    (vk::Format::R8G8B8_SINT, "r8g8b8_sint"),
    (vk::Format::R8G8B8_SRGB, "r8g8b8_srgb"),
    (vk::Format::B8G8R8_UNORM, "b8g8r8_unorm"),
    (vk::Format::B8G8R8_SNORM, "b8g8r8_snorm"),
    (vk::Format::B8G8R8_USCALED, "b8g8r8_uscaled"),
    (vk::Format::B8G8R8_SSCALED, "b8g8r8_sscaled"),
    (vk::Format::B8G8R8_UINT, "b8g8r8_uint"),
    (vk::Format::B8G8R8_SINT, "b8g8r8_sint"),
    (vk::Format::B8G8R8_SRGB, "b8g8r8_srgb"),
    (vk::Format::R8G8B8A8_UNORM, "r8g8b8a8_unorm"),
    (vk::Format::R8G8B8A8_SNORM, "r8g8b8a8_snorm"),
    (vk::Format::R8G8B8A8_USCALED, "r8g8b8a8_uscaled"),
    (vk::Format::R8G8B8A8_SSCALED, "r8g8b8a8_sscaled"),
    (vk::Format::R8G8B8A8_UINT, "r8g8b8a8_uint"),
    (vk::Format::R8G8B8A8_SINT, "r8g8b8a8_sint"),
    (vk::Format::R8G8B8A8_SRGB, "r8g8b8a8_srgb"),
    (vk::Format::B8G8R8A8_UNORM, "b8g8r8a8_unorm"),
    (vk::Format::B8G8R8A8_SNORM, "b8g8r8a8_snorm"),
    (vk::Format::B8G8R8A8_USCALED, "b8g8r8a8_uscaled"),
    (vk::Format::B8G8R8A8_SSCALED, "b8g8r8a8_sscaled"),
    (vk::Format::B8G8R8A8_UINT, "b8g8r8a8_uint"),
    (vk::Format::B8G8R8A8_SINT, "b8g8r8a8_sint"),
    (vk::Format::B8G8R8A8_SRGB, "b8g8r8a8_srgb"),
    (vk::Format::A8B8G8R8_UNORM_PACK32, "a8b8g8r8_unorm_pack32"),
    (vk::Format::A8B8G8R8_SNORM_PACK32, "a8b8g8r8_snorm_pack32"),
    (vk::Format::A8B8G8R8_USCALED_PACK32, "a8b8g8r8_uscaled_pack32"),
    (vk::Format::A8B8G8R8_SSCALED_PACK32, "a8b8g8r8_sscaled_pack32"),
    (vk::Format::A8B8G8R8_UINT_PACK32, "a8b8g8r8_uint_pack32"),
    (vk::Format::A8B8G8R8_SINT_PACK32, "a8b8g8r8_sint_pack32"),
    (vk::Format::A8B8G8R8_SRGB_PACK32, "a8b8g8r8_srgb_pack32"),
    (vk::Format::A2R10G10B10_UNORM_PACK32, "a2r10g10b10_unorm_pack32"),
    (vk::Format::A2R10G10B10_SNORM_PACK32, "a2r10g10b10_snorm_pack32"),
    (vk::Format::A2R10G10B10_USCALED_PACK32, "a2r10g10b10_uscaled_pack32"),
    (vk::Format::A2R10G10B10_SSCALED_PACK32, "a2r10g10b10_sscaled_pack32"),
    (vk::Format::A2R10G10B10_UINT_PACK32, "a2r10g10b10_uint_pack32"),
    (vk::Format::A2R10G10B10_SINT_PACK32, "a2r10g10b10_sint_pack32"),
    (vk::Format::A2B10G10R10_UNORM_PACK32, "a2b10g10r10_unorm_pack32"),
    (vk::Format::A2B10G10R10_SNORM_PACK32, "a2b10g10r10_snorm_pack32"),
    (vk::Format::A2B10G10R10_USCALED_PACK32, "a2b10g10r10_uscaled_pack32"),
    (vk::Format::A2B10G10R10_SSCALED_PACK32, "a2b10g10r10_sscaled_pack32"),
    (vk::Format::A2B10G10R10_UINT_PACK32, "a2b10g10r10_uint_pack32"),
    (vk::Format::A2B10G10R10_SINT_PACK32, "a2b10g10r10_sint_pack32"),
    (vk::Format::R16_UNORM, "r16_unorm"),
    (vk::Format::R16_SNORM, "r16_snorm"),
    (vk::Format::R16_USCALED, "r16_uscaled"),
    (vk::Format::R16_SSCALED, "r16_sscaled"),
    (vk::Format::R16_UINT, "r16_uint"),
    (vk::Format::R16_SINT, "r16_sint"),
    (vk::Format::R16_SFLOAT, "r16_sfloat"),
    (vk::Format::R16G16_UNORM, "r16g16_unorm"),
    (vk::Format::R16G16_SNORM, "r16g16_snorm"),
    (vk::Format::R16G16_USCALED, "r16g16_uscaled"),
    (vk::Format::R16G16_SSCALED, "r16g16_sscaled"),
    (vk::Format::R16G16_UINT, "r16g16_uint"),
    (vk::Format::R16G16_SINT, "r16g16_sint"),
    (vk::Format::R16G16_SFLOAT, "r16g16_sfloat"),
    (vk::Format::R16G16B16_UNORM, "r16g16b16_unorm"),
    (vk::Format::R16G16B16_SNORM, "r16g16b16_snorm"),
    (vk::Format::R16G16B16_USCALED, "r16g16b16_uscaled"),
    (vk::Format::R16G16B16_SSCALED, "r16g16b16_sscaled"),
    (vk::Format::R16G16B16_UINT, "r16g16b16_uint"),
    (vk::Format::R16G16B16_SINT, "r16g16b16_sint"),
    (vk::Format::R16G16B16_SFLOAT, "r16g16b16_sfloat"),
    (vk::Format::R16G16B16A16_UNORM, "r16g16b16a16_unorm"),
    (vk::Format::R16G16B16A16_SNORM, "r16g16b16a16_snorm"),
    (vk::Format::R16G16B16A16_USCALED, "r16g16b16a16_uscaled"),
    (vk::Format::R16G16B16A16_SSCALED, "r16g16b16a16_sscaled"),
    (vk::Format::R16G16B16A16_UINT, "r16g16b16a16_uint"),
    (vk::Format::R16G16B16A16_SINT, "r16g16b16a16_sint"),
    (vk::Format::R16G16B16A16_SFLOAT, "r16g16b16a16_sfloat"),
    (vk::Format::R32_UINT, "r32_uint"),
    (vk::Format::R32_SINT, "r32_sint"),
    (vk::Format::R32_SFLOAT, "r32_sfloat"),
    (vk::Format::R32G32_UINT, "r32g32_uint"),
    (vk::Format::R32G32_SINT, "r32g32_sint"),
    (vk::Format::R32G32_SFLOAT, "r32g32_sfloat"),
    (vk::Format::R32G32B32_UINT, "r32g32b32_uint"),
    (vk::Format::R32G32B32_SINT, "r32g32b32_sint"),
    (vk::Format::R32G32B32_SFLOAT, "r32g32b32_sfloat"),
    (vk::Format::R32G32B32A32_UINT, "r32g32b32a32_uint"),
    (vk::Format::R32G32B32A32_SINT, "r32g32b32a32_sint"),
    (vk::Format::R32G32B32A32_SFLOAT, "r32g32b32a32_sfloat"),
    (vk::Format::R64_UINT, "r64_uint"),
    (vk::Format::R64_SINT, "r64_sint"),
    (vk::Format::R64G64_UINT, "r64g64_uint"),
    (vk::Format::R64G64_SINT, "r64g64_sint"),
    (vk::Format::B10G11R11_UFLOAT_PACK32, "b10g11r11_ufloat_pack32"),
    (vk::Format::E5B9G9R9_UFLOAT_PACK32, "e5b9g9r9_ufloat_pack32"),
    (vk::Format::A4R4G4B4_UNORM_PACK16, "a4r4g4b4_unorm_pack16"),
    (vk::Format::A4B4G4R4_UNORM_PACK16, "a4b4g4r4_unorm_pack16"),
];

/// `depthStencilImageFormatsToTest`, paired with the name each case is registered under.
pub static DEPTH_STENCIL_IMAGE_FORMATS_TO_TEST: &[(vk::Format, &str)] = &[
    (vk::Format::D16_UNORM, "d16_unorm"),
    (vk::Format::X8_D24_UNORM_PACK32, "x8_d24_unorm_pack32"),
    (vk::Format::D32_SFLOAT, "d32_sfloat"),
    (vk::Format::S8_UINT, "s8_uint"),
    (vk::Format::D16_UNORM_S8_UINT, "d16_unorm_s8_uint"),
    (vk::Format::D24_UNORM_S8_UINT, "d24_unorm_s8_uint"),
    (vk::Format::D32_SFLOAT_S8_UINT, "d32_sfloat_s8_uint"),
];
