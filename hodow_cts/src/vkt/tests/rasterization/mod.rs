// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/rasterization/vktRasterizationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Ported: `frag_side_effects`, `depth_bias_control`, `provoking_vertex`, `rasterization_order_attachment_access`. The rest of
// upstream's `rasterization` group (the 10k-line line/point/triangle rasterization cases) is not; `shader_tile_image` is, with its shaders from scripts/gen_shader_tile_image_programs.py.

pub mod conservative_tests;
pub mod depth_bias_control_tests;
pub mod depth_bias_tests;
pub mod frag_side_effects_tests;
pub mod line_tests;
pub mod order_attachment_access_tests;
pub mod polygon_large_points_tests;
pub mod provoking_vertex_tests;
pub mod rendering_tests;
pub mod shader_tile_image_tests;
pub mod simple_tests;

use crate::vkt::TestCaseGroup;

/// `createTests` - the `rasterization` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("rasterization");
    group.add_child(conservative_tests::create_conservative_tests());
    group.add_child(depth_bias_control_tests::create_depth_bias_control_tests());
    group.add_child(depth_bias_tests::create_depth_bias_amber_tests());
    group.add_child(depth_bias_tests::create_line_continuity_tests());
    group.add_child(frag_side_effects_tests::create_frag_side_effects_tests());
    group.add_child(line_tests::create_maintenance5_tests());
    group.add_child(order_attachment_access_tests::create_order_attachment_access_tests());
    group.add_child(polygon_large_points_tests::create_polygon_as_large_points_tests());
    group.add_child(provoking_vertex_tests::create_provoking_vertex_tests());
    group.add_child(shader_tile_image_tests::create_shader_tile_image_tests());
    rendering_tests::add_rendering_tests(&mut group);
    group
}
