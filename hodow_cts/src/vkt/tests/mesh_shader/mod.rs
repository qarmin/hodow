// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `ext` group (VK_EXT_mesh_shader) is ported; of the `nv` group of the
// deprecated VK_NV_mesh_shader only `smoke`, `api`, `synchronization`, `property`, `builtin` and part of `misc` and `in_out` so far. Ported so far: `smoke` (monolithic), `synchronization`, `builtin` (without `primitive_id_spirv`), `api`, `conditional_rendering`, `in_out`, `misc` (all but local_size_id and work_group_ordering), `properties`, `provoking_vertex` and `query`.

pub mod api_nv_tests;
pub mod api_tests;
pub mod builtin_nv_tests;
pub mod builtin_tests;
pub mod conditional_rendering_tests;
pub mod in_out_nv_tests;
pub mod in_out_tests;
pub mod misc_nv_tests;
pub mod misc_tests;
pub mod property_nv_tests;
pub mod property_tests;
pub mod provoking_vertex_tests;
pub mod query_tests;
pub mod smoke_nv_tests;
pub mod smoke_shared_frag_tests;
pub mod smoke_tests;
pub mod sync_nv_tests;
pub mod sync_tests;
pub mod util;
pub mod vertex_state_tests;
pub mod work_group_ordering_tests;

use crate::vkt::TestCaseGroup;

/// `createTests` - the `mesh_shader` group.
pub fn create_tests() -> TestCaseGroup {
    let mut nv_group = TestCaseGroup::new("nv");
    nv_group.add_child(smoke_nv_tests::create_mesh_shader_smoke_tests());
    nv_group.add_child(api_nv_tests::create_mesh_shader_api_tests());
    nv_group.add_child(sync_nv_tests::create_mesh_shader_sync_tests());
    nv_group.add_child(property_nv_tests::create_mesh_shader_property_tests());
    nv_group.add_child(builtin_nv_tests::create_mesh_shader_builtin_tests());
    nv_group.add_child(misc_nv_tests::create_mesh_shader_misc_tests());
    nv_group.add_child(in_out_nv_tests::create_mesh_shader_in_out_tests());

    let mut ext_group = TestCaseGroup::new("ext");
    ext_group.add_child(smoke_tests::create_mesh_shader_smoke_tests_ext());
    ext_group.add_child(builtin_tests::create_mesh_shader_builtin_tests_ext());
    ext_group.add_child(builtin_tests::create_mesh_shader_pipeline_tests_ext());
    ext_group.add_child(sync_tests::create_mesh_shader_sync_tests_ext());
    ext_group.add_child(api_tests::create_mesh_shader_api_tests_ext());
    ext_group.add_child(conditional_rendering_tests::create_mesh_shader_conditional_rendering_tests_ext());
    ext_group.add_child(in_out_tests::create_mesh_shader_in_out_tests_ext());
    ext_group.add_child(misc_tests::create_mesh_shader_misc_tests_ext());
    ext_group.add_child(property_tests::create_mesh_shader_property_tests_ext());
    ext_group.add_child(query_tests::create_mesh_shader_query_tests_ext());
    ext_group.add_child(provoking_vertex_tests::create_mesh_shader_provoking_vertex_tests_ext());

    let mut group = TestCaseGroup::new("mesh_shader");
    group.add_child(nv_group);
    group.add_child(ext_group);
    group
}
