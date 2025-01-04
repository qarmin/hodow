// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesBufferTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Ported so far: `transfer` (sparse_binding, rebind) and `ssbo` (sparse_binding_aliased,
// sparse_residency). The device group variants of the three plain groups are `device_group_tests`; the ones of `ubo` and the others, `ubo`, `ssbo.read_write`, `vertex_buffer`, `index_buffer`, `indirect_buffer`, `transform_feedback`, `indirect_dispatch` and `memory_copy_indirect` are in `buffer_draw_tests`; `misc` is in `buffer_null_address_tests`.

use super::buffer_memory_aliasing_tests::add_buffer_sparse_memory_aliasing_tests;
use super::buffer_rebind_tests::add_buffer_sparse_rebind_tests;
use super::buffer_sparse_binding_tests::add_buffer_sparse_binding_tests;
use super::buffer_sparse_residency_tests::add_buffer_sparse_residency_tests;
use super::device_group_tests::{DeviceGroupBufferKind, add_device_group_buffer_tests};
use crate::vkt::TestCaseGroup;

/// `createSparseBufferTests`
pub fn create_sparse_buffer_tests() -> TestCaseGroup {
    let mut parent_group = TestCaseGroup::new("buffer");

    // Transfer
    {
        let mut group = TestCaseGroup::new("transfer");

        let mut sub_group = TestCaseGroup::new("sparse_binding");
        add_buffer_sparse_binding_tests(&mut sub_group);
        group.add_child(sub_group);

        let mut sub_group = TestCaseGroup::new("device_group_sparse_binding");
        add_device_group_buffer_tests(&mut sub_group, DeviceGroupBufferKind::SparseBinding);
        group.add_child(sub_group);

        let mut sub_group_rebind = TestCaseGroup::new("rebind");
        add_buffer_sparse_rebind_tests(&mut sub_group_rebind);
        group.add_child(sub_group_rebind);

        parent_group.add_child(group);
    }

    // SSBO
    {
        let mut group = TestCaseGroup::new("ssbo");

        let mut sub_group = TestCaseGroup::new("sparse_binding_aliased");
        add_buffer_sparse_memory_aliasing_tests(&mut sub_group);
        group.add_child(sub_group);

        let mut sub_group = TestCaseGroup::new("device_group_sparse_binding_aliased");
        add_device_group_buffer_tests(&mut sub_group, DeviceGroupBufferKind::SparseBindingAliased);
        group.add_child(sub_group);

        let mut sub_group = TestCaseGroup::new("sparse_residency");
        add_buffer_sparse_residency_tests(&mut sub_group);
        group.add_child(sub_group);

        let mut sub_group = TestCaseGroup::new("device_group_sparse_residency");
        add_device_group_buffer_tests(&mut sub_group, DeviceGroupBufferKind::SparseResidency);
        group.add_child(sub_group);

        // Read and write sparse storage buffers in shaders
        group.add_child(super::buffer_draw_tests::create_sparse_buffer_read_write_group());

        parent_group.add_child(group);
    }

    parent_group.add_child(super::buffer_draw_tests::create_sparse_buffer_ubo_group());

    // Texel buffers
    {
        let mut group = TestCaseGroup::new("texel_buffers");

        let mut sub_group = TestCaseGroup::new("sparse_residency");
        super::buffer_texel_tests::add_texel_buffer_sparse_residency_tests(&mut sub_group);
        group.add_child(sub_group);

        parent_group.add_child(group);
    }

    for group in super::buffer_draw_tests::create_sparse_buffer_draw_grid_groups() {
        parent_group.add_child(group);
    }
    parent_group.add_child(super::buffer_draw_tests::create_sparse_buffer_transform_feedback_group());
    parent_group.add_child(super::buffer_draw_tests::create_sparse_buffer_indirect_dispatch_group());
    parent_group.add_child(super::buffer_draw_tests::create_sparse_buffer_memory_copy_indirect_group());

    parent_group.add_child(super::buffer_null_address_tests::create_sparse_buffer_misc_tests());

    parent_group
}
