// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Ported so far: `buffer` (see buffer_tests.rs), `image_sparse_binding`, `aligned_mip_size`,
// `image_block_shapes`, `image_rebind`, `image_sparse_memory_aliasing` (the single-plane formats), `image_sparse_residency` (the single-plane formats and `mutable`), `mipmap_sparse_residency`, `multisampled_image_sparse_binding`, `multisampled_image_sparse_residency`,
// `queue_bind`, `shader_intrinsics` (the single-plane formats) and `transfer_queue`. The four `device_group_*` trees are registered by `device_group_tests` and report NotSupported without a group of two physical devices. Tests take their queues from `Context::multi_queue_device()` through
// `base::SparseDevice`.

pub mod base;
pub mod buffer_draw_tests;
pub mod buffer_memory_aliasing_tests;
pub mod buffer_null_address_tests;
pub mod buffer_rebind_tests;
pub mod buffer_sparse_binding_tests;
pub mod buffer_sparse_residency_tests;
pub mod buffer_tests;
pub mod buffer_texel_tests;
pub mod device_group_tests;
pub mod image_aligned_mip_size_tests;
pub mod image_block_shapes_tests;
pub mod image_memory_aliasing_tests;
pub mod image_rebind_tests;
pub mod image_sparse_binding_tests;
pub mod image_sparse_residency_tests;
pub mod mipmap_sparse_residency_tests;
pub mod multisampled_image_sparse_binding_tests;
pub mod multisampled_image_sparse_residency_tests;
mod null_address_programs;
pub mod queue_bind_sparse_tests;
pub mod shader_intrinsics_tests;
pub mod tests_util;
mod texel_programs;
pub mod transfer_queue_tests;

use crate::vkt::TestCaseGroup;

/// `createTests` - the `dEQP-VK.sparse_resources` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("sparse_resources");
    group.add_child(buffer_tests::create_sparse_buffer_tests());
    group.add_child(image_sparse_binding_tests::create_image_sparse_binding_tests());
    group.add_child(device_group_tests::create_device_group_image_sparse_binding_tests());
    group.add_child(image_sparse_residency_tests::create_image_sparse_residency_tests());
    group.add_child(device_group_tests::create_device_group_image_sparse_residency_tests());
    group.add_child(image_memory_aliasing_tests::create_image_sparse_memory_aliasing_tests());
    group.add_child(device_group_tests::create_device_group_image_sparse_memory_aliasing_tests());
    group.add_child(shader_intrinsics_tests::create_sparse_resources_shader_intrinsics_tests());
    group.add_child(image_aligned_mip_size_tests::create_image_aligned_mip_size_tests());
    group.add_child(image_block_shapes_tests::create_image_block_shapes_tests());
    group.add_child(image_rebind_tests::create_image_sparse_rebind_tests());
    group.add_child(mipmap_sparse_residency_tests::create_mipmap_sparse_residency_tests());
    group.add_child(device_group_tests::create_device_group_mipmap_sparse_residency_tests());
    group.add_child(multisampled_image_sparse_binding_tests::create_multisampled_image_sparse_binding_tests());
    group.add_child(multisampled_image_sparse_residency_tests::create_multisampled_image_sparse_residency_tests());
    group.add_child(queue_bind_sparse_tests::create_queue_bind_sparse_tests());
    group.add_child(transfer_queue_tests::create_transfer_queue_tests());
    group
}
