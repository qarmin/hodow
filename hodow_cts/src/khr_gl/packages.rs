// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl3cTestPackages.cpp
//   external/openglcts/modules/gl/gl4cTestPackages.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's packages are cumulative: `GL31TestPackage::init` calls `GL30TestPackage::init` and then adds its own groups, and so on up to `GL46TestPackage`. A group is therefore registered exactly once, in the first package that has it, and every later root contains it too. The same shape here: one function per package, called in order up to the root's version. Registration order is upstream's, which is the order the cases run in.
//
// A group is added in the function of the package that adds it upstream, never in a later one, even when a later one would be easier: the mustpass lists (and `just cts-gl-coverage`) are the check that it lands in the right roots.

use super::esext::{ExtParameters, ExtensionType};
use super::shader_library::create_group;
use super::{
    aggressive_shader_optimizations_tests, bind_image_texture_tests, blend_equation_advanced_tests,
    buffer_objects_tests, buffer_storage_tests, clear_tex_image_tests, clip_control_tests, clip_distance_tests,
    common_bugs_tests, compute_shader_tests, conditional_render_inverted_tests, copy_image, cull_distance_tests,
    direct_state_access_tests, draw_buffers_tests, draw_elements_base_vertex_tests, es31_compatibility_tests,
    explicit_uniform_location_tests, exposed_extensions_tests, frag_coord_conventions_tests, geometry_shader,
    get_texture_sub_image_tests, get_uniform_tests, glsl_noperspective_tests, glsl_vector_constructor_tests,
    gpu_shader5, gpu_shader5_gl_tests, incomplete_texture_access_tests, indirect_parameters_tests,
    internalformat_tests, layout_binding_tests, layout_location_tests, limits_tests, map_buffer_alignment_tests,
    multi_bind_tests, nearest_edge_tests, negative_texture_lookup_functions_bias_tests, packed_depth_stencil_tests,
    packed_pixels, parallel_shader_compile_tests, pipeline_statistics_query_tests, pixel_storage_modes_tests,
    polygon_offset_clamp_tests, post_depth_coverage_tests, primitive_restart_tests, program_interface_query_tests,
    sample_shading_tests, sample_variables_tests, separable_programs_transform_feedback_tests, sepshaderobjs,
    shader_atomic_counter_ops_tests, shader_atomic_counters_tests, shader_ballot_tests,
    shader_bitfield_operation_tests, shader_const_expr_tests, shader_draw_parameters_tests, shader_group_vote_tests,
    shader_image_size_tests, shader_integer_mix_tests, shader_multisample_interpolation_tests, shader_negative_tests,
    shader_texture_image_samples_tests, shader_viewport_layer_array_tests, spirv_extensions_tests,
    stencil_texturing_tests, sync_tests, texture_barrier_tests, texture_border_clamp, texture_buffer,
    texture_buffer_size_clamping_tests, texture_cube_map_array, texture_filter_anisotropic_tests,
    texture_filter_minmax_tests, texture_gather_tests, texture_lod_basic_tests, texture_lod_bias_tests,
    texture_query_levels_tests, texture_query_lod_tests, texture_repeat_mode_tests, texture_size_promotion_tests,
    texture_stencil8_tests, texture_storage_tests, texture_swizzle, texture_view,
    transform_feedback_overflow_query_tests, transform_feedback2_tests, transform_feedback3_tests, uniform_block,
    vertex_attrib_64bit_tests, vertex_attrib_binding_tests, viewport_array,
};
use crate::generated::khr_shader_library as library;
use crate::gles3::functional::{
    frag_depth_tests, shader_function_tests, shader_indexing_tests, shader_loop_tests, shader_struct_tests,
};
use crate::glu::{GlslVersion, TestCaseGroup, TestNode, info_tests};

/// The root for one desktop version, `30` to `46`, built the way upstream's package chain builds it.
pub fn create_root(version: u8) -> TestCaseGroup {
    let mut root = TestCaseGroup::new(format!("KHR-GL{version}"));
    let steps: [(u8, fn(&mut TestCaseGroup)); 11] = [
        (30, gl30),
        (31, gl31),
        (32, gl32),
        (33, gl33),
        (40, gl40),
        (41, gl41),
        (42, gl42),
        (43, gl43),
        (44, gl44),
        (45, gl45),
        (46, gl46),
    ];
    for (step_version, add) in steps {
        if step_version <= version {
            add(&mut root);
        }
    }
    root
}

/// `GL30TestPackage::init`
fn gl30(root: &mut TestCaseGroup) {
    root.add_child(info_tests::create_tests());
    root.add_child(clip_distance_tests::create_tests());
    root.add_child(glsl_noperspective_tests::create_tests());
    root.add_child(super::transform_feedback_tests::create_tests());
    root.add_child(transform_feedback3_tests::create_tests());
    root.add_child(texture_repeat_mode_tests::create_tests());
    root.add_child(texture_lod_basic_tests::create_tests());

    // `GL30ShaderTests`
    let mut shaders = TestCaseGroup::new("shaders30");
    shaders.add_child(TestNode::Group(create_group(
        "declarations",
        &library::gl30_declarations::ROOT,
    )));
    shaders.add_child(TestNode::Group(glsl_vector_constructor_tests::create_tests(
        GlslVersion::Glsl130,
    )));
    shaders.add_child(TestNode::Group(uniform_block::create_negative_tests(
        GlslVersion::Glsl150,
    )));
    root.add_child(shaders);

    root.add_child(super::ext_texture_shadow_lod_tests::create_tests());
    root.add_child(super::framebuffer_blit::create_tests());
    root.add_child(texture_lod_bias_tests::create_tests());
    root.add_child(buffer_objects_tests::create_tests());
    root.add_child(transform_feedback2_tests::create_tests());
    root.add_child(super::api_coverage::create_tests());
    root.add_child(get_uniform_tests::create_tests());
    root.add_child(frag_coord_conventions_tests::create_tests());
    root.add_child(texture_storage_tests::create_tests());
    root.add_child(draw_buffers_tests::create_tests());
}

/// `GL31TestPackage::init`
fn gl31(root: &mut TestCaseGroup) {
    root.add_child(common_bugs_tests::create_tests());
    root.add_child(texture_size_promotion_tests::create_tests());
    root.add_child(primitive_restart_tests::create_tests());
}

/// `GL32TestPackage::init`
fn gl32(root: &mut TestCaseGroup) {
    root.add_child(gpu_shader5_gl_tests::create_tests());
    root.add_child(transform_feedback_overflow_query_tests::create_tests());
    root.add_child(packed_pixels::create_tests());
    root.add_child(packed_depth_stencil_tests::create_tests());
}

/// `GL33TestPackage::init`
fn gl33(root: &mut TestCaseGroup) {
    // `GL33ShaderTests`
    let mut shaders = TestCaseGroup::new("shaders");
    shaders.add_child(TestNode::Group(create_group("arrays", &library::gl33_arrays::ROOT)));
    shaders.add_child(TestNode::Group(create_group(
        "declarations",
        &library::gl33_declarations::ROOT,
    )));
    shaders.add_child(TestNode::Group(frag_depth_tests::create_khronos_tests(
        GlslVersion::Glsl330,
    )));
    shaders.add_child(TestNode::Group(shader_indexing_tests::create_khronos_tests(
        GlslVersion::Glsl330,
    )));
    shaders.add_child(TestNode::Group(shader_loop_tests::create_khronos_tests(
        GlslVersion::Glsl330,
    )));
    shaders.add_child(TestNode::Group(create_group(
        "preprocessor",
        &library::gl33_preprocessor::ROOT,
    )));
    shaders.add_child(TestNode::Group(shader_function_tests::create_khronos_tests(
        GlslVersion::Glsl330,
    )));
    shaders.add_child(TestNode::Group(shader_struct_tests::create_khronos_tests(
        GlslVersion::Glsl330,
    )));
    shaders.add_child(TestNode::Group(uniform_block::create_tests(GlslVersion::Glsl330)));
    shaders.add_child(TestNode::Group(shader_integer_mix_tests::create_tests(
        GlslVersion::Glsl330,
    )));
    shaders.add_child(TestNode::Group(shader_negative_tests::create_tests(
        GlslVersion::Glsl330,
    )));
    root.add_child(shaders);

    root.add_child(pipeline_statistics_query_tests::create_tests());
    root.add_child(cull_distance_tests::create_tests());
    root.add_child(texture_swizzle::create_tests());
    root.add_child(nearest_edge_tests::create_tests());
    root.add_child(pixel_storage_modes_tests::create_tests(GlslVersion::Glsl330));
    root.add_child(texture_filter_minmax_tests::create_tests());
}

/// `GL40TestPackage::init`
fn gl40(root: &mut TestCaseGroup) {
    root.add_child(draw_elements_base_vertex_tests::create_tests(ExtParameters::new(
        GlslVersion::Glsl400,
        ExtensionType::None,
    )));
    root.add_child(internalformat_tests::create_tests());
    root.add_child(super::gpu_shader_fp64::create_tests());
    root.add_child(texture_gather_tests::create_tests());
    root.add_child(super::draw_indirect::create_tests());
    root.add_child(clip_control_tests::create_tests(false));
    root.add_child(super::shader_subroutine::create_tests());
    root.add_child(texture_barrier_tests::create_tests(
        texture_barrier_tests::Api::GlArbTextureBarrier,
    ));
    root.add_child(exposed_extensions_tests::create_tests());
    root.add_child(super::fragment_shading_rate::create_tests(ExtParameters::new(
        GlslVersion::Glsl400,
        ExtensionType::Ext,
    )));
}

/// `GL41TestPackage::init`
fn gl41(root: &mut TestCaseGroup) {
    root.add_child(vertex_attrib_64bit_tests::create_tests());
    root.add_child(viewport_array::create_tests(ExtParameters::new(
        GlslVersion::Glsl410,
        ExtensionType::None,
    )));
}

/// `GL42TestPackage::init`
fn gl42(root: &mut TestCaseGroup) {
    root.add_child(map_buffer_alignment_tests::create_tests());
    root.add_child(shader_atomic_counters_tests::create_tests());
    root.add_child(super::shader_image_load_store::create_tests());
    root.add_child(super::shading_language_420pack::create_tests());
    root.add_child(texture_view::create_tests());
    root.add_child(bind_image_texture_tests::create_tests());

    // `GL42ShaderTests`
    let mut shaders = TestCaseGroup::new("shaders42");
    shaders.add_child(TestNode::Group(create_group(
        "declarations",
        &library::gl42_declarations::ROOT,
    )));
    root.add_child(shaders);
}

/// `GL43TestPackage::init`
fn gl43(root: &mut TestCaseGroup) {
    root.add_child(copy_image::create_tests());
    root.add_child(super::draw_indirect::create_tests_43());
    root.add_child(program_interface_query_tests::create_tests());
    root.add_child(compute_shader_tests::create_tests());
    root.add_child(super::shader_storage_buffer_object::create_tests());
    root.add_child(vertex_attrib_binding_tests::create_tests());
    root.add_child(shader_image_size_tests::create_tests());
    root.add_child(explicit_uniform_location_tests::create_tests());
    root.add_child(blend_equation_advanced_tests::create_tests(GlslVersion::Glsl430));
    root.add_child(shader_bitfield_operation_tests::create_tests(GlslVersion::Glsl430));
    root.add_child(stencil_texturing_tests::create_tests());
    root.add_child(super::sparse_buffer_tests::create_tests());
    root.add_child(super::sparse_texture_tests::create_tests());
    root.add_child(indirect_parameters_tests::create_tests());
    root.add_child(shader_ballot_tests::create_tests());
    root.add_child(shader_const_expr_tests::create_tests());
    root.add_child(clear_tex_image_tests::create_tests());
    root.add_child(aggressive_shader_optimizations_tests::create_tests());
    root.add_child(texture_query_levels_tests::create_tests());
    root.add_child(texture_query_lod_tests::create_tests());
    root.add_child(texture_buffer_size_clamping_tests::create_tests());
}

/// `GL44TestPackage::init`
fn gl44(root: &mut TestCaseGroup) {
    let ext_params = ExtParameters::new(GlslVersion::Glsl440, ExtensionType::None);

    // `GL44ShaderTests`
    let mut shaders = TestCaseGroup::new("shaders44");
    shaders.add_child(TestNode::Group(create_group(
        "preprocessor",
        &library::gl44_preprocessor::ROOT,
    )));
    root.add_child(shaders);
    root.add_child(buffer_storage_tests::create_tests());
    root.add_child(layout_binding_tests::create_tests(GlslVersion::Glsl440));
    root.add_child(multi_bind_tests::create_tests());
    root.add_child(sepshaderobjs::create_tests(GlslVersion::Glsl440));
    root.add_child(sample_shading_tests::create_tests(GlslVersion::Glsl440));
    root.add_child(sample_variables_tests::create_tests(GlslVersion::Glsl440));
    root.add_child(shader_multisample_interpolation_tests::create_tests(
        GlslVersion::Glsl440,
    ));
    root.add_child(shader_texture_image_samples_tests::create_tests());
    root.add_child(texture_filter_anisotropic_tests::create_tests());
    root.add_child(texture_stencil8_tests::create_tests());

    root.add_child(geometry_shader::create_tests(ext_params));
    root.add_child(gpu_shader5::create_tests(ext_params));
    root.add_child(super::tessellation_shader::create_tests(ext_params));
    root.add_child(texture_cube_map_array::create_tests(ext_params));
    root.add_child(texture_border_clamp::create_tests(ext_params));
    root.add_child(texture_buffer::create_tests(ext_params));
}

/// `GL45TestPackage::init`
fn gl45(root: &mut TestCaseGroup) {
    if let Some(group) = root.group_mut("shader_atomic_counters") {
        shader_atomic_counters_tests::add_gl45_cases(group);
    }
    // `GL45ShaderTests`
    let mut shaders = TestCaseGroup::new("shaders45");
    shaders.add_child(TestNode::Group(shader_integer_mix_tests::create_tests(
        GlslVersion::Glsl450,
    )));
    root.add_child(shaders);
    root.add_child(clip_control_tests::create_tests(true));
    root.add_child(direct_state_access_tests::create_tests());
    root.add_child(get_texture_sub_image_tests::create_tests());
    root.add_child(texture_barrier_tests::create_tests(
        texture_barrier_tests::Api::Gl45Core,
    ));
    root.add_child(conditional_render_inverted_tests::create_tests());
    root.add_child(sync_tests::create_tests());
    root.add_child(incomplete_texture_access_tests::create_tests());
    root.add_child(parallel_shader_compile_tests::create_tests());
    root.add_child(post_depth_coverage_tests::create_tests());
    root.add_child(shader_atomic_counter_ops_tests::create_tests());
    root.add_child(shader_draw_parameters_tests::create_tests());
    root.add_child(shader_viewport_layer_array_tests::create_tests());
    root.add_child(limits_tests::create_tests());
    root.add_child(shader_group_vote_tests::create_tests());
    root.add_child(polygon_offset_clamp_tests::create_tests());
    root.add_child(separable_programs_transform_feedback_tests::create_tests());
    root.add_child(layout_location_tests::create_tests());
    root.add_child(spirv_extensions_tests::create_tests());
    root.add_child(super::gl_spirv_tests::create_tests());
    root.add_child(es31_compatibility_tests::create_tests());
    root.add_child(negative_texture_lookup_functions_bias_tests::create_tests());
    root.add_child(super::sparse_texture2_tests::create_tests());
    root.add_child(super::sparse_texture_clamp_tests::create_tests());
}

/// `GL46TestPackage::init`
fn gl46(_root: &mut TestCaseGroup) {}
