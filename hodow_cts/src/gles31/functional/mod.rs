// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fFunctionalTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

pub mod advanced_blend_tests;
pub mod android_extension_pack_es31a_tests;
pub mod atomic_counter_tests;
pub mod builtin_constant_tests;
pub mod builtin_precision_tests;
pub mod compute;
pub mod compute_shader_builtin_var_tests;
pub mod copy_image_tests;
pub mod debug_tests;
pub mod default_vertex_array_object_tests;
pub mod draw_compute_interop_tests;
pub mod draw_elements_base_vertex_tests;
pub mod draw_indirect_tests;
pub mod draw_instancing_tests;
pub mod draw_test_case;
pub mod draw_tests;
pub mod fbo;
pub mod geometry_shading_layered_tests;
pub mod geometry_shading_render_tests;
pub mod geometry_shading_tests;
pub mod layout_binding_tests;
pub mod multisample_shader_render_case;
pub mod multisample_tests;
pub mod negative_advanced_blend_equation_tests;
pub mod negative_atomic_counter_tests;
pub mod negative_buffer_api_tests;
pub mod negative_compute_tests;
pub mod negative_fragment_api_tests;
pub mod negative_precise_tests;
pub mod negative_sample_variables_tests;
pub mod negative_shader_api_tests;
pub mod negative_shader_directive_tests;
pub mod negative_shader_framebuffer_fetch_tests;
pub mod negative_shader_function_tests;
pub mod negative_shader_image_load_store_tests;
pub mod negative_shader_storage_tests;
pub mod negative_ssbo_block_tests;
pub mod negative_state_api_tests;
pub mod negative_tessellation_tests;
pub mod negative_test_shared;
pub mod negative_texture_api_tests;
pub mod negative_vertex_array_api_tests;
pub mod opaque_type_indexing_tests;
pub mod primitive_bounding_box_line_tests;
pub mod primitive_bounding_box_misc_tests;
pub mod primitive_bounding_box_point_tests;
pub mod primitive_bounding_box_render_tests;
pub mod primitive_bounding_box_tests;
pub mod program_interface_definition;
pub mod program_interface_definition_util;
pub mod program_interface_query_test_case;
pub mod program_interface_query_tests;
pub mod program_interface_resource_definition;
pub mod program_uniform_tests;
pub mod sample_shading_tests;
pub mod sample_variable_tests;
pub mod separate_shader_tests;
pub mod shader_atomic_op_tests;
pub mod shader_common_function_tests;
pub mod shader_framebuffer_fetch_tests;
pub mod shader_helper_invocation_tests;
pub mod shader_image_load_store_tests;
pub mod shader_integer_function_tests;
pub mod shader_multisample_interpolation_tests;
pub mod shader_packing_function_tests;
pub mod shader_shared_var_tests;
pub mod shader_tests;
pub mod shader_texture_size_tests;
pub mod shader_uniform_integer_function_tests;
pub mod srgb_decode_tests;
pub mod ssbo_array_length_tests;
pub mod ssbo_layout_case;
pub mod ssbo_layout_tests;
pub mod state_query;
pub mod stencil_texturing_tests;
pub mod synchronization_tests;
pub mod tessellation_geometry_interaction_tests;
pub mod tessellation_render_tests;
pub mod tessellation_tests;
pub mod texture;
pub mod uniform_block_tests;
pub mod uniform_location_tests;
pub mod vertex_attribute_binding_tests;

use shader_atomic_op_tests::AtomicOperandType;

use crate::glu::TestCaseGroup;

/// `FunctionalTests::init`, restricted to the groups that are ported.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("functional");
    group.add_child(shader_tests::create_tests());
    group.add_child(compute::create_tests());
    group.add_child(draw_tests::create_tests());
    group.add_child(tessellation_tests::create_tests());
    group.add_child(create_ssbo_tests());
    group.add_child(uniform_block_tests::create_tests());
    group.add_child(shader_image_load_store_tests::create_tests());
    group.add_child(atomic_counter_tests::create_tests());
    group.add_child(stencil_texturing_tests::create_tests());
    group.add_child(texture::create_tests());
    group.add_child(state_query::create_tests());
    group.add_child(multisample_tests::create_tests());
    group.add_child(synchronization_tests::create_tests());
    group.add_child(sample_shading_tests::create_tests());
    group.add_child(vertex_attribute_binding_tests::create_tests());
    group.add_child(program_interface_query_tests::create_tests());
    group.add_child(program_uniform_tests::create_tests());
    group.add_child(advanced_blend_tests::create_tests());
    group.add_child(separate_shader_tests::create_tests());
    group.add_child(uniform_location_tests::create_tests());
    group.add_child(tessellation_geometry_interaction_tests::create_tests());
    group.add_child(layout_binding_tests::create_tests());
    group.add_child(debug_tests::create_tests());
    group.add_child(default_vertex_array_object_tests::create_tests());
    group.add_child(srgb_decode_tests::create_tests());
    group.add_child(fbo::create_tests());
    group.add_child(primitive_bounding_box_tests::create_tests());
    group.add_child(copy_image_tests::create_tests());
    group.add_child(draw_elements_base_vertex_tests::create_tests());
    group.add_child(geometry_shading_tests::create_tests());
    group.add_child(android_extension_pack_es31a_tests::create_tests());
    group
}

/// `SSBOTests::init`
fn create_ssbo_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("ssbo");
    group.add_child(ssbo_layout_tests::create_tests());
    group.add_child(shader_atomic_op_tests::create_tests(
        "atomic",
        AtomicOperandType::BufferVariable,
    ));
    group.add_child(ssbo_array_length_tests::create_tests());
    group
}
