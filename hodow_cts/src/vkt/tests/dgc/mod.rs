// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The case trees of `dgc.ext` (VK_EXT_device_generated_commands) and `dgc.nv` (VK_NV_device_generated_commands) are
// registered from the mustpass names and gated on the extension upstream's first support check requires: NotSupported without it, NotPorted with it. The bodies are ported
// where a module of this directory provides the case (`ext.compute.smoke`, `ext.compute.get_info`, `ext.compute.subgroups`, `ext.compute.preprocess`, `ext.compute.conditional_rendering`, parts of `ext.compute.misc`, the pipeline variants of `ext.compute.layout`, five of the six `ext.misc.properties`, the monolithic `ext.graphics.draw` and `ext.graphics.tess_state` layer cases, the pipeline `ext.graphics.draw_count` cases, `ext.graphics.conditional_rendering`, `ext.graphics.multiview`, 38 of the 258 `ext.graphics.misc` ones: tg_push_constants, early_fragment_tests, draw index/base instance, sequence_index_token, vbo_update, reuse_dgc_for_normal, rebind_normal_state, mix_normal_dgc, monolithic dynamic_vertex_input); `scripts/gen_dgc_cases.py` writes the name lists. Also ported: `ext.graphics.xfb`, all of `ext.graphics.mesh` (conditional_rendering, misc, token_draw, token_draw_count) and every `nv` case (compute smoke, get_info, subgroups, preprocess, conditional_rendering, layout, misc and the misc.properties limits).

use std::collections::HashMap;

use crate::vkt::TestCaseGroup;
use crate::vkt::gated::build_gated_groups_with;

pub mod compute_conditional_tests;
pub mod compute_get_info_tests;
pub mod compute_layout_tests;
pub mod compute_misc_tests;
pub mod compute_preprocess_tests;
pub mod compute_push_index_heap_tests;
pub mod compute_smoke_tests;
pub mod compute_subgroup_tests;
pub mod graphics_conditional_tests;
pub mod graphics_draw_count_tests;
pub mod graphics_draw_tests;
pub mod graphics_mesh_conditional_tests;
pub mod graphics_mesh_draw_tests;
pub mod graphics_mesh_misc_tests;
pub mod graphics_mesh_util;
pub mod graphics_misc_dyn_vtx_tests;
pub mod graphics_misc_ies_vtx_tests;
pub mod graphics_misc_iface_tests;
pub mod graphics_misc_mix_tests;
pub mod graphics_misc_ms_tests;
pub mod graphics_misc_rebind_tests;
pub mod graphics_misc_reuse_tests;
pub mod graphics_misc_robust_vbo_tests;
pub mod graphics_misc_sample_id_tests;
pub mod graphics_misc_sparse_vbo_tests;
pub mod graphics_misc_tests;
pub mod graphics_misc_tg_pc_tests;
pub mod graphics_misc_vbo_tests;
pub mod graphics_multiview_tests;
pub mod graphics_tess_state_tests;
pub mod graphics_xfb_tests;
pub mod nv_compute_conditional_tests;
pub mod nv_compute_get_info_tests;
pub mod nv_compute_layout_tests;
pub mod nv_compute_misc_tests;
pub mod nv_compute_preprocess_tests;
pub mod nv_compute_properties_tests;
pub mod nv_compute_smoke_tests;
pub mod nv_compute_subgroup_tests;
pub mod property_tests;
pub mod stat_query_gfx_tests;
pub mod stat_query_mesh_tests;
pub mod stat_query_tests;
pub mod util_ext;
pub mod util_nv;

const EXT_CASE_NAMES: &str = include_str!("ext_cases.txt");
const NV_CASE_NAMES: &str = include_str!("nv_cases.txt");

/// `createDGCTests` - the `dgc` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("dgc");
    let mut real: HashMap<String, _> = compute_smoke_tests::create_dgc_compute_smoke_tests_ext()
        .into_iter()
        .chain(compute_get_info_tests::create_dgc_compute_get_info_tests_ext())
        .chain(compute_subgroup_tests::create_dgc_compute_subgroup_tests_ext())
        .chain(compute_preprocess_tests::create_dgc_compute_preprocess_tests_ext())
        .chain(compute_conditional_tests::create_dgc_compute_conditional_tests_ext())
        .chain(compute_misc_tests::create_dgc_compute_misc_tests_ext())
        .chain(compute_layout_tests::create_dgc_compute_layout_tests_ext())
        .chain(compute_push_index_heap_tests::create_dgc_compute_push_index_heap_tests_ext())
        .chain(property_tests::create_dgc_property_tests_ext())
        .chain(stat_query_tests::create_dgc_stat_query_tests_ext())
        .chain(stat_query_gfx_tests::create_dgc_stat_query_gfx_tests_ext())
        .chain(stat_query_mesh_tests::create_dgc_stat_query_mesh_tests_ext())
        .chain(graphics_draw_tests::create_dgc_graphics_draw_tests_ext())
        .chain(graphics_tess_state_tests::create_dgc_graphics_tess_state_tests_ext())
        .chain(graphics_tess_state_tests::create_dgc_graphics_tess_state_dynamic_tests_ext())
        .chain(graphics_draw_count_tests::create_dgc_graphics_draw_count_tests_ext())
        .chain(graphics_conditional_tests::create_dgc_graphics_conditional_tests_ext())
        .chain(graphics_multiview_tests::create_dgc_graphics_multiview_tests_ext())
        .chain(graphics_misc_dyn_vtx_tests::create_dgc_graphics_misc_dyn_vtx_tests_ext())
        .chain(graphics_misc_ies_vtx_tests::create_dgc_graphics_misc_ies_vtx_tests_ext())
        .chain(graphics_misc_iface_tests::create_dgc_graphics_misc_iface_tests_ext())
        .chain(graphics_misc_mix_tests::create_dgc_graphics_misc_mix_tests_ext())
        .chain(graphics_misc_ms_tests::create_dgc_graphics_misc_ms_tests_ext())
        .chain(graphics_misc_robust_vbo_tests::create_dgc_graphics_misc_robust_vbo_tests_ext())
        .chain(graphics_misc_sample_id_tests::create_dgc_graphics_misc_sample_id_tests_ext())
        .chain(graphics_misc_sparse_vbo_tests::create_dgc_graphics_misc_sparse_vbo_tests_ext())
        .chain(graphics_misc_rebind_tests::create_dgc_graphics_misc_rebind_tests_ext())
        .chain(graphics_misc_reuse_tests::create_dgc_graphics_misc_reuse_tests_ext())
        .chain(graphics_misc_tests::create_dgc_graphics_misc_tests_ext())
        .chain(graphics_misc_vbo_tests::create_dgc_graphics_misc_vbo_tests_ext())
        .chain(graphics_misc_tg_pc_tests::create_dgc_graphics_misc_tg_pc_tests_ext())
        .chain(graphics_xfb_tests::create_dgc_graphics_xfb_tests_ext())
        .chain(graphics_mesh_conditional_tests::create_dgc_graphics_mesh_conditional_tests_ext())
        .chain(graphics_mesh_misc_tests::create_dgc_graphics_mesh_misc_tests_ext())
        .chain(graphics_mesh_draw_tests::create_dgc_graphics_mesh_draw_tests_ext())
        .collect();
    for child in build_gated_groups_with(
        EXT_CASE_NAMES,
        &["VK_EXT_device_generated_commands"],
        "the VK_EXT_device_generated_commands tests",
        &mut |path| real.remove(path),
    ) {
        group.add_child(child);
    }
    let mut real_nv: HashMap<String, _> = nv_compute_smoke_tests::create_dgc_compute_smoke_tests_nv()
        .into_iter()
        .chain(nv_compute_conditional_tests::create_dgc_compute_conditional_tests_nv())
        .chain(nv_compute_subgroup_tests::create_dgc_compute_subgroup_tests_nv())
        .chain(nv_compute_preprocess_tests::create_dgc_compute_preprocess_tests_nv())
        .chain(nv_compute_get_info_tests::create_dgc_compute_get_info_tests_nv())
        .chain(nv_compute_layout_tests::create_dgc_compute_layout_tests_nv())
        .chain(nv_compute_misc_tests::create_dgc_compute_misc_tests_nv())
        .chain(nv_compute_properties_tests::create_dgc_property_tests_nv())
        .collect();
    for child in build_gated_groups_with(
        NV_CASE_NAMES,
        &["VK_NV_device_generated_commands"],
        "the VK_NV_device_generated_commands tests",
        &mut |path| real_nv.remove(path),
    ) {
        group.add_child(child);
    }
    group
}
