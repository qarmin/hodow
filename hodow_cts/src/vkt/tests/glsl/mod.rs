// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/vktTestPackage.cpp (`createGlslTests`, the ShaderLibrary part)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the `.test` shader library files are ported (`es310/*` and `440/linkage`) the compute stage of `shader_expect_assume` and `bfloat16.dot` and `bfloat16.various` and the compute stage of `shader_clock`; builtin.function.integer through the ShaderExecutor; the
// ShaderRenderCase based groups of `glsl` (derivate, discard, indexing, loops, ...) are not.

pub mod amber_graphics_tests;
pub mod bfloat16_constant_tests;
pub mod bfloat16_dot_tests;
pub mod bfloat16_various_tests;
pub mod builtin_common_function_tests;
pub mod builtin_integer_function_tests;
pub mod builtin_packing_function_tests;
pub mod fconvert_tests;
pub mod limit_tests;
pub mod not_ported_tests;
pub mod opaque_type_indexing_tests;
pub mod shader_clock_tests;
pub mod shader_expect_assume_gfx_cases;
pub mod shader_expect_assume_gfx_tests;
pub mod shader_expect_assume_tests;
pub mod shader_helper_invocations_tests;
pub mod shader_library;
pub mod shader_render;
pub mod shader_render_builtin_var_fragcoord_msaa_tests;
pub mod shader_render_builtin_var_fragdepth_tests;
pub mod shader_render_builtin_var_frontfacing_tests;
pub mod shader_render_builtin_var_pointcoord_tests;
pub mod shader_render_builtin_var_tests;
pub mod shader_render_derivate_tests;
pub mod shader_render_discard_tests;
pub mod shader_render_helper_invocation_tests;
pub mod shader_render_indexing_cases;
pub mod shader_render_indexing_tests;
pub mod shader_render_invariance_cases;
pub mod shader_render_invariance_tests;
pub mod shader_render_loop_cases;
pub mod shader_render_loop_tests;
pub mod shader_render_matrix_cases;
pub mod shader_render_matrix_tests;
pub mod shader_render_operator_cases;
pub mod shader_render_operator_tests;
pub mod shader_render_return_tests;
pub mod shader_render_struct_cases;
pub mod shader_render_struct_tests;
pub mod shader_render_switch_tests;
pub mod texture_function_special_tests;

use crate::vkt::TestCaseGroup;

/// `createGlslTests` - the `glsl` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = shader_library::create_shader_library_groups("glsl");
    group.add_child(shader_expect_assume_tests::create_shader_expect_assume_tests());
    group.add_child(shader_clock_tests::create_shader_clock_tests());
    group.add_child(limit_tests::create_limit_tests());
    group.add_child(amber_graphics_tests::create_crash_test_group());
    group.add_child(amber_graphics_tests::create_logical_copy_group());
    group.add_child(amber_graphics_tests::create_combined_operations_group());
    let mut bfloat16 = TestCaseGroup::new("bfloat16");
    bfloat16.add_child(bfloat16_constant_tests::create_bfloat16_constant_tests());
    bfloat16.add_child(bfloat16_dot_tests::create_bfloat16_dot_tests());
    bfloat16.add_child(bfloat16_various_tests::create_bfloat16_various_tests());
    group.add_child(bfloat16);
    let mut builtin = TestCaseGroup::new("builtin");
    let mut function = TestCaseGroup::new("function");
    function.add_child(builtin_common_function_tests::create_common_function_tests());
    function.add_child(builtin_integer_function_tests::create_integer_function_tests());
    function.add_child(builtin_packing_function_tests::create_packing_function_tests());
    builtin.add_child(function);
    builtin.add_child(fconvert_tests::create_precision_fconvert_group());
    for precision in not_ported_tests::create_builtin_precision_groups() {
        builtin.add_child(precision);
    }
    group.add_child(builtin);
    group.add_child(opaque_type_indexing_tests::create_opaque_type_indexing_tests());
    group.add_child(shader_render_builtin_var_tests::create_builtin_var_tests());
    group.add_child(shader_render_derivate_tests::create_derivate_tests());
    group.add_child(shader_render_discard_tests::create_demote_tests());
    group.add_child(shader_render_discard_tests::create_discard_tests());
    group.add_child(shader_helper_invocations_tests::create_shader_helper_invocations_tests());
    group.add_child(shader_render_helper_invocation_tests::create_helper_invocation_tests());
    group.add_child(shader_render_indexing_tests::create_indexing_tests());
    for root in shader_render_invariance_tests::create_invariance_and_precise_tests() {
        group.add_child(root);
    }
    group.add_child(shader_render_loop_tests::create_loop_tests());
    group.add_child(shader_render_matrix_tests::create_matrix_tests());
    group.add_child(shader_render_operator_tests::create_operator_tests());
    group.add_child(shader_render_return_tests::create_return_tests());
    group.add_child(shader_render_struct_tests::create_struct_tests());
    group.add_child(shader_render_switch_tests::create_switch_tests());
    group.add_child(crate::vkt::tests::shaderexecutor::atomic_operation_tests::create_atomic_operation_tests());
    let mut texture_functions = TestCaseGroup::new("texture_functions");
    for child in texture_function_special_tests::create_texture_function_special_groups() {
        texture_functions.add_child(child);
    }
    for child in not_ported_tests::create_texture_function_groups() {
        texture_functions.add_child(child);
    }
    group.add_child(texture_functions);
    group.add_child(not_ported_tests::create_texture_gather_group());
    group
}
