// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/texture/vktTextureTests.cpp (createTests)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the `filtering`, `mipmap` (2d coordinate types and bias), `filtering_anisotropy`, `shadow`, `swizzle` and `conversion.snorm_clamp` groups are ported so far.

pub mod anisotropy_tests;
pub mod compressed_format_tests;
pub mod filtering_tests;
pub mod min_lod_gather_tests;
pub mod mipmap_tests;
pub mod misc_amber_tests;
pub mod multisample_cases;
pub mod multisample_tests;
pub mod not_ported_tests;
pub mod shadow_tests;
pub mod snorm_clamp_tests;
pub mod subgroup_lod_cases;
pub mod subgroup_lod_tests;
pub mod swizzle_tests;
pub mod test_util;
pub mod texel_buffer_cases;
pub mod texel_buffer_tests;
pub mod texel_offset_tests;

use crate::vkt::TestCaseGroup;

/// `createTests` - the `dEQP-VK.texture` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture");
    group.add_child(filtering_tests::create_texture_filtering_tests());
    let mut mipmap = mipmap_tests::create_texture_mipmapping_tests();
    mipmap.add_child(min_lod_gather_tests::create_min_lod_gather_tests());
    group.add_child(mipmap);
    group.add_child(snorm_clamp_tests::create_conversion_tests());
    group.add_child(anisotropy_tests::create_filtering_anisotropy_tests());
    group.add_child(shadow_tests::create_texture_shadow_tests());
    group.add_child(not_ported_tests::create_explicit_lod_group());
    group.add_child(swizzle_tests::create_texture_swizzle_tests());
    group.add_child(compressed_format_tests::create_texture_compressed_format_tests());
    group.add_child(multisample_tests::create_multisample_tests());
    group.add_child(subgroup_lod_tests::create_subgroup_lod_tests());
    group.add_child(texel_buffer_tests::create_texel_buffer_tests());
    group.add_child(texel_offset_tests::create_texel_offset_tests());
    group.add_child(compressed_format_tests::create_3d_texture_compressed_format_tests());
    group
}
