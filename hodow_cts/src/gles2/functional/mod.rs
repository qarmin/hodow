// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fFunctionalTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::gls::fragment_op_util::QuadRendererGlslVersion;

pub mod attrib_location_tests;
pub mod blend_tests;
pub mod buffer_write_tests;
pub mod clip_control_tests;
pub mod clipping_tests;
pub mod color_clear_test;
pub mod debug_marker_tests;
pub mod default_vertex_attribute_tests;
pub mod depth_range_tests;
pub mod depth_stencil_clear_tests;
pub mod depth_stencil_tests;
pub mod depth_tests;
pub mod dithering_tests;
pub mod draw_tests;
pub mod fbo;
pub mod frag_op_interaction_tests;
pub mod implementation_limit_tests;
pub mod lifetime_tests;
pub mod light_amount_test;
pub mod multisample_tests;
pub mod multisampled_render_to_texture_tests;
pub mod negative_api;
pub mod polygon_offset_tests;
pub mod prerequisite_tests;
pub mod rasterization_tests;
pub mod read_pixels_tests;
pub mod scissor_tests;
pub mod shader_algorithm_tests;
pub mod shader_api_tests;
pub mod shader_builtin_var_tests;
pub mod shader_const_expr_tests;
pub mod shader_discard_tests;
pub mod shader_frag_data_tests;
pub mod shader_function_tests;
pub mod shader_indexing_tests;
pub mod shader_invariance_tests;
pub mod shader_loop_tests;
pub mod shader_matrix_tests;
pub mod shader_operator_tests;
pub mod shader_return_tests;
pub mod shader_struct_tests;
pub mod shader_texture_function_tests;
pub mod state_query;
pub mod stencil_tests;
pub mod texture;
pub mod uniform_api_tests;
pub mod vertex_array_test;

use crate::glu::TestCaseGroup;

/// `FunctionalTests::init`, restricted to the groups that are ported and keeping their
/// relative order from upstream.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("functional");
    group.add_child(prerequisite_tests::create_tests());
    group.add_child(read_pixels_tests::create_tests());
    group.add_child(depth_range_tests::create_tests());
    group.add_child(dithering_tests::create_tests());
    group.add_child(implementation_limit_tests::create_tests());
    group.add_child(clip_control_tests::create_tests());
    group.add_child(color_clear_test::create_tests());
    group.add_child(depth_stencil_clear_tests::create_tests());
    group.add_child(buffer_write_tests::create_tests());
    group.add_child(light_amount_test::create_tests());
    group.add_child(multisampled_render_to_texture_tests::create_tests());

    // `FragmentOpTests` - upstream declares this group inline in es2fFunctionalTests.cpp
    // rather than in a file of its own, so it is built here too. `blend` and `scissor`
    // of its seven children are ported (`scissor`'s `ScissorClearCase`s and
    // `ScissorPrimitiveCase`s, 17 of 17 - fully closed on this API); `depth`/`stencil`/
    // `random`/`interaction` need a rasterised reference.
    let mut fragment_ops = TestCaseGroup::new("fragment_ops");
    fragment_ops.add_child(depth_tests::create_tests());
    fragment_ops.add_child(stencil_tests::create_tests());
    fragment_ops.add_child(depth_stencil_tests::create_tests(QuadRendererGlslVersion::Es100));
    fragment_ops.add_child(scissor_tests::create_tests());
    fragment_ops.add_child(blend_tests::create_tests());
    fragment_ops.add_child(crate::gls::random_fragment_op_tests::create_tests(
        QuadRendererGlslVersion::Es100,
    ));
    fragment_ops.add_child(frag_op_interaction_tests::create_tests());
    group.add_child(fragment_ops);
    group.add_child(create_shaders_tests());
    group.add_child(texture::create_tests());
    group.add_child(fbo::create_tests());
    group.add_child(clipping_tests::create_tests());
    group.add_child(polygon_offset_tests::create_tests());
    group.add_child(draw_tests::create_tests());
    group.add_child(vertex_array_test::create_tests());
    group.add_child(uniform_api_tests::create_tests());
    group.add_child(shader_api_tests::create_tests());
    group.add_child(negative_api::create_tests());
    // Upstream's `RasterizationTests` sits here too, between `NegativeApiTestGroup` and
    // `createAttributeLocationTests` - only its triangle-rasterization slice is ported
    // (see `rasterization_tests`'s own header for the rest still missing).
    group.add_child(rasterization_tests::create_tests());
    group.add_child(attrib_location_tests::create_tests());
    // Upstream registers `MultisampleTests` here too (right after
    // `createAttributeLocationTests`), between the render-dependent
    // `TextureTestGroup`/etc. this port skips.
    group.add_child(multisample_tests::create_tests());
    group.add_child(default_vertex_attribute_tests::create_tests());
    group.add_child(state_query::create_tests());
    // Upstream's own last two children are `createLifetimeTests`/`createDebugMarkerTests`.
    group.add_child(crate::gls::flush_finish_cases::create_tests(
        crate::gls::flush_finish_cases::FlushFinishEs::Es2,
    ));
    group.add_child(lifetime_tests::create_tests());
    group.add_child(debug_marker_tests::create_tests());
    group
}

/// `ShadersTestGroup::init`, restricted to the sub-groups that are ported: the
/// `gls::ShaderLibrary`-driven ones, which come out of `src/generated/shader_library/`,
/// and the `gls::ShaderRenderCase`-driven ones.
fn create_shaders_tests() -> TestCaseGroup {
    use crate::generated::shader_library as lib;
    use crate::gls::shader_library::create_group;

    let mut group = TestCaseGroup::new("shaders");
    group.add_child(create_group("preprocessor", &lib::gles2_preprocessor::ROOT));
    group.add_child(create_group("constants", &lib::gles2_constants::ROOT));
    group.add_child(create_group("linkage", &lib::gles2_linkage::ROOT));
    group.add_child(create_group("conversions", &lib::gles2_conversions::ROOT));
    group.add_child(create_group("conditionals", &lib::gles2_conditionals::ROOT));
    group.add_child(create_group("declarations", &lib::gles2_declarations::ROOT));
    group.add_child(create_group("swizzles", &lib::gles2_swizzles::ROOT));
    group.add_child(create_group("functions", &lib::gles2_functions::ROOT));
    group.add_child(create_group("keywords", &lib::gles2_keywords::ROOT));
    group.add_child(create_group("reserved_operators", &lib::gles2_reserved_operators::ROOT));
    group.add_child(create_group(
        "qualification_order",
        &lib::gles2_qualification_order::ROOT,
    ));
    group.add_child(create_group("scoping", &lib::gles2_scoping::ROOT));
    group.add_child(create_group(
        "invalid_implicit_conversions",
        &lib::gles2_invalid_implicit_conversions::ROOT,
    ));
    group.add_child(create_group("misc", &lib::gles2_misc::ROOT));
    group.add_child(shader_builtin_var_tests::create_tests());
    group.add_child(shader_indexing_tests::create_tests());
    group.add_child(shader_loop_tests::create_tests());
    group.add_child(shader_operator_tests::create_tests());
    group.add_child(shader_matrix_tests::create_tests());
    group.add_child(shader_return_tests::create_tests());
    group.add_child(shader_discard_tests::create_tests());
    group.add_child(shader_struct_tests::create_tests());
    group.add_child(shader_texture_function_tests::create_tests());
    group.add_child(shader_invariance_tests::create_tests(shader_invariance_tests::ES2));
    group.add_child(shader_frag_data_tests::create_tests());
    group.add_child(shader_algorithm_tests::create_tests());
    group.add_child(shader_const_expr_tests::create_tests());
    group.add_child(shader_function_tests::create_tests());
    group.add_child(crate::gls::random_shader_tests::create_tests(
        crate::rsg::parameters::Version::Version100,
    ));
    group
}
