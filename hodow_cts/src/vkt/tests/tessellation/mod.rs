// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tessellation/vktTessellationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Ported: `limits`, `tesscoord` (GLSL variants), `fractional_spacing` (GLSL variants), `shader_input_output`, `matrix_multiplication`, `primitive_discard` and the GLSL half of `winding`. Upstream also builds every `winding` case from HLSL (`hlsl_*`), which
// this port has no compiler for; `user_defined_io` is ported; `misc_draw` (without its instanced draw cases) and `unused_builtin_outputs` (monolithic only) are ported too; `invariance` is ported; the rest of the group (geometry interaction (but `point_size`, `passthrough`, `render`), max IO) is not ported.

pub mod common_edge_tests;
pub mod coordinates_tests;
pub mod fractional_spacing_tests;
pub mod geometry_grid_render_tests;
pub mod geometry_passthrough_tests;
pub mod geometry_point_size_tests;
pub mod invariance_tests;
pub mod limits_tests;
pub mod matrix_multiplication_tests;
pub mod max_io_tests;
pub mod misc_draw_tests;
pub mod primitive_discard_tests;
pub mod shader_input_output_tests;
pub mod user_defined_io_tests;
pub mod util;
pub mod winding_tests;

use crate::vkt::TestCaseGroup;

/// `createGeometryInteractionTests`, with every part.
fn create_geometry_interaction_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("geometry_interaction");
    group.add_child(geometry_passthrough_tests::create_geometry_passthrough_tests());
    group.add_child(geometry_grid_render_tests::create_geometry_grid_render_limits_tests());
    group.add_child(geometry_grid_render_tests::create_geometry_grid_render_scatter_tests());
    group.add_child(geometry_point_size_tests::create_geometry_point_size_tests());
    group
}

/// `createTests` - the `tessellation` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("tessellation");
    group.add_child(limits_tests::create_limits_tests());
    group.add_child(coordinates_tests::create_coordinates_tests());
    group.add_child(fractional_spacing_tests::create_fractional_spacing_tests());
    group.add_child(shader_input_output_tests::create_shader_input_output_tests());
    group.add_child(winding_tests::create_winding_tests());
    group.add_child(common_edge_tests::create_common_edge_tests());
    group.add_child(primitive_discard_tests::create_primitive_discard_tests());
    group.add_child(invariance_tests::create_invariance_tests());
    group.add_child(user_defined_io_tests::create_user_defined_io_tests());
    group.add_child(create_geometry_interaction_tests());
    group.add_child(matrix_multiplication_tests::create_tessellation_matrix_multiplication_tests());
    group.add_child(misc_draw_tests::create_misc_draw_tests());
    group.add_child(misc_draw_tests::create_unused_builtin_output_tests());
    group.add_child(max_io_tests::create_tess_io_tests());
    group
}
