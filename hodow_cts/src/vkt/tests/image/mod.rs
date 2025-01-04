// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Ported so far: `texel_view_compatible` and `qualifiers` (coherent and volatile), `image_size`, `misaligned_cube`, `mismatched_formats`
// , `sample_cubemap`, `extended_usage_bit_compatibility`, `subresource_layout`, `queue_transfer`, `concurrent_copy` `non_uniform_offset_sample`, `astc_decode_mode`, `2d_array_compatible`, `load_store_multisample` and `sample_texture` and `tiling_control` and `depth_stencil_separate_access` and `depth_stencil_descriptor` and `host_image_copy` (partly) and `general_layout` and `mismatched_write_op` and `store_load_consistency` and `store` and `load_store` (both without the depth formats and the buffer `minalign` cases) and `load_store_lod` and `format_reinterpret` and `device_scope_access` and `extend_operands_spirv1p4` and `nontemporal_operand`. Children are registered in
// upstream's order.

pub mod array_compatible_tests;
pub mod astc_decode_mode_tests;
mod atomic_operation_instance;
pub mod atomic_operation_tests;
pub mod concurrent_copy_tests;
pub mod depth_stencil_descriptor_tests;
pub mod depth_stencil_separate_tests;
pub mod device_scope_tests;
pub mod extend_operands_tests;
pub mod extended_usage_bit_tests;
pub mod general_layout_tests;
pub mod host_image_copy_format_tests;
pub mod host_image_copy_formats;
pub mod host_image_copy_layout_tests;
pub mod host_image_copy_tests;
pub mod image_texture;
pub mod load_store_lod_tests;
pub mod load_store_tests;
pub mod misaligned_cube_tests;
pub mod mismatched_formats_tests;
pub mod mismatched_write_op_tests;
pub mod multisample_load_store_tests;
pub mod mutable_tests;
pub mod non_uniform_offset_sample_tests;
pub mod qualifiers_tests;
pub mod sample_compressed_texture_tests;
pub mod sample_drawn_cube_face_tests;
pub mod size_tests;
pub mod store_load_consistency_tests;
pub mod store_tests;
pub mod subresource_layout_tests;
pub mod tests_util;
pub mod texel_view_compatible_tests;
mod texel_view_graphics_tests;
pub mod tiling_control_tests;
pub mod transfer_tests;

use crate::vkt::TestCaseGroup;

/// `createTests` - the `dEQP-VK.image` group.
pub fn create_tests() -> TestCaseGroup {
    let mut image_tests = TestCaseGroup::new("image");
    image_tests.add_child(store_tests::create_image_store_tests());
    image_tests.add_child(load_store_tests::create_image_load_store_tests());
    image_tests.add_child(load_store_lod_tests::create_image_load_store_lod_amd_tests());
    image_tests.add_child(load_store_tests::create_image_format_reinterpret_tests());
    image_tests.add_child(device_scope_tests::create_image_device_scope_access_tests());
    image_tests.add_child(qualifiers_tests::create_image_qualifiers_tests());
    image_tests.add_child(size_tests::create_image_size_tests());
    image_tests.add_child(astc_decode_mode_tests::create_image_astc_decode_mode_tests());
    image_tests.add_child(misaligned_cube_tests::create_misaligned_cube_tests());
    image_tests.add_child(subresource_layout_tests::create_image_subresource_layout_tests());
    image_tests.add_child(mismatched_formats_tests::create_image_mismatched_formats_tests());
    image_tests.add_child(mismatched_write_op_tests::create_image_write_op_tests());
    image_tests.add_child(mutable_tests::create_image_mutable_tests());
    image_tests.add_child(sample_drawn_cube_face_tests::create_image_sample_drawn_cube_face_tests());
    image_tests.add_child(depth_stencil_descriptor_tests::create_image_depth_stencil_descriptor_tests());
    image_tests.add_child(sample_compressed_texture_tests::create_image_sample_drawn_texture_tests());
    image_tests.add_child(extended_usage_bit_tests::create_image_extended_usage_bit_tests());
    image_tests.add_child(transfer_tests::create_transfer_queue_image_tests());
    image_tests.add_child(concurrent_copy_tests::create_image_concurrent_copy_tests());
    image_tests.add_child(host_image_copy_tests::create_image_host_image_copy_tests());
    image_tests.add_child(non_uniform_offset_sample_tests::create_image_non_uniform_offset_sample_tests());
    image_tests.add_child(store_load_consistency_tests::create_image_store_load_consistency_tests());
    image_tests.add_child(array_compatible_tests::create_image_2d_array_compatible_tests());
    image_tests.add_child(general_layout_tests::create_image_general_layout_tests());
    image_tests.add_child(multisample_load_store_tests::create_image_multisample_load_store_tests());
    image_tests.add_child(extend_operands_tests::create_image_extend_operands_tests());
    image_tests.add_child(atomic_operation_tests::create_image_atomic_operation_tests());
    image_tests.add_child(extend_operands_tests::create_image_nontemporal_operand_tests());
    image_tests.add_child(tiling_control_tests::create_image_tiling_control_tests());
    image_tests.add_child(depth_stencil_separate_tests::create_image_depth_stencil_separate_tests());
    image_tests.add_child(texel_view_compatible_tests::create_image_compression_transcoding_tests());
    let mut swapchain_mutable = mutable_tests::create_headless_swapchain_mutable_cases();
    for child in crate::vkt::gated::build_gated_groups_with(
        include_str!("swapchain_mutable_cases.txt"),
        &["VK_KHR_swapchain", "VK_KHR_swapchain_mutable_format"],
        "the window system (only the headless platform is ported)",
        &mut |path| swapchain_mutable.remove(path),
    ) {
        image_tests.add_child(child);
    }
    image_tests
}
