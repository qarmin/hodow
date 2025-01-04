// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFunctionalTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

pub mod attrib_location_tests;
pub mod blend_tests;
pub mod buffer;
pub mod builtin_precision_tests;
pub mod clipping_tests;
pub mod color_clear_test;
pub mod default_vertex_array_object_tests;
pub mod default_vertex_attribute_tests;
pub mod depth_stencil_clear_tests;
pub mod depth_stencil_tests;
pub mod depth_tests;
pub mod dithering_tests;
pub mod draw_buffers_indexed_tests;
pub mod draw_tests;
pub mod fbo;
pub mod frag_depth_tests;
pub mod frag_op_interaction_tests;
pub mod fragment_output_tests;
pub mod framebuffer_blit_tests;
pub mod implementation_limit_tests;
pub mod instanced_rendering_tests;
pub mod lifetime_tests;
pub mod multisample_tests;
pub mod negative_api;
pub mod occlusion_query_tests;
pub mod pixel_buffer_object_tests;
pub mod polygon_offset_tests;
pub mod prerequisite_tests;
pub mod primitive_restart_tests;
pub mod rasterization_tests;
pub mod rasterizer_discard_tests;
pub mod read_pixels_tests;
pub mod sampler_object_tests;
pub mod scissor_tests;
pub mod shader_api_tests;
pub mod shader_builtin_var_tests;
pub mod shader_common_function_tests;
pub mod shader_const_expr_tests;
pub mod shader_derivate_tests;
pub mod shader_discard_tests;
pub mod shader_frag_data_tests;
pub mod shader_function_tests;
pub mod shader_indexing_tests;
pub mod shader_invariance_tests;
pub mod shader_loop_tests;
pub mod shader_matrix_tests;
pub mod shader_metamorphic_tests;
pub mod shader_operator_tests;
pub mod shader_packing_function_tests;
pub mod shader_precision_tests;
pub mod shader_return_tests;
pub mod shader_struct_tests;
pub mod shader_switch_tests;
pub mod shader_tests;
pub mod shader_texture_function_tests;
pub mod state_query;
pub mod stencil_tests;
pub mod sync_tests;
pub mod texture;
pub mod transform_feedback_tests;
pub mod uniform_api_tests;
pub mod uniform_block_tests;
pub mod vertex_array_object_tests;
pub mod vertex_array_test;

use crate::glu::TestCaseGroup;

/// `FunctionalTests::init`, restricted to the groups that are ported and keeping their
/// relative order from upstream.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("functional");
    group.add_child(prerequisite_tests::create_tests());
    group.add_child(implementation_limit_tests::create_tests());
    group.add_child(color_clear_test::create_tests());
    group.add_child(depth_stencil_clear_tests::create_tests());
    group.add_child(buffer::create_tests());

    // `FragmentOpTests` - upstream declares this group inline in es3fFunctionalTests.cpp
    // rather than in a file of its own, so it is built here too. `blend` and `scissor`
    // of its seven children are ported (`scissor`'s `ScissorClearCase`s and
    // `ScissorPrimitiveCase`s, 17 of 26 - the 6 `FramebufferClearCase`s and 3
    // `FramebufferBlitCase`s remain); `depth`/`stencil`/`random`/`interaction` need a
    // rasterised reference.
    let mut fragment_ops = TestCaseGroup::new("fragment_ops");
    fragment_ops.add_child(depth_tests::create_tests());
    fragment_ops.add_child(stencil_tests::create_tests());
    fragment_ops.add_child(depth_stencil_tests::create_tests());
    fragment_ops.add_child(scissor_tests::create_tests());
    fragment_ops.add_child(blend_tests::create_tests());
    fragment_ops.add_child(crate::gls::random_fragment_op_tests::create_tests(
        crate::gls::fragment_op_util::QuadRendererGlslVersion::Es300,
    ));
    fragment_ops.add_child(frag_op_interaction_tests::create_tests());
    group.add_child(fragment_ops);
    group.add_child(shader_tests::create_tests());
    group.add_child(texture::create_tests());
    group.add_child(fbo::create_tests());
    group.add_child(clipping_tests::create_tests());
    group.add_child(polygon_offset_tests::create_tests());
    group.add_child(draw_tests::create_tests());
    group.add_child(vertex_array_test::create_tests());
    group.add_child(occlusion_query_tests::create_tests());
    group.add_child(primitive_restart_tests::create_tests());
    group.add_child(rasterizer_discard_tests::create_tests());
    group.add_child(uniform_block_tests::create_tests());
    group.add_child(uniform_api_tests::create_tests());
    group.add_child(attrib_location_tests::create_tests());
    group.add_child(fragment_output_tests::create_tests());
    group.add_child(sampler_object_tests::create_tests());
    group.add_child(transform_feedback_tests::create_tests());
    group.add_child(sync_tests::create_tests());
    group.add_child(shader_api_tests::create_tests());
    group.add_child(negative_api::create_tests());
    group.add_child(state_query::create_tests());
    group.add_child(default_vertex_array_object_tests::create_tests());
    group.add_child(default_vertex_attribute_tests::create_tests());
    group.add_child(read_pixels_tests::create_tests());
    group.add_child(dithering_tests::create_tests());
    group.add_child(pixel_buffer_object_tests::create_tests());
    // Upstream's `RasterizationTests` sits here too, between `PixelBufferObjectTests`
    // and `OcclusionQueryTests` - only its triangle-rasterization slice is ported (see
    // `rasterization_tests`'s own header for the rest still missing).
    group.add_child(rasterization_tests::create_tests());
    group.add_child(instanced_rendering_tests::create_tests());
    group.add_child(multisample_tests::create_tests());
    group.add_child(vertex_array_object_tests::create_tests());
    group.add_child(crate::gls::flush_finish_cases::create_tests(
        crate::gls::flush_finish_cases::FlushFinishEs::Es3,
    ));
    group.add_child(lifetime_tests::create_tests());
    // Upstream's `GL45ES3FunctionalTests`/plain `ES3FunctionalTests::init` both add
    // this last, after `DefaultVertexArrayObjectTests` - only the `overwrite_common`/
    // `overwrite_indexed` children are ported, see the module's own header.
    group.add_child(draw_buffers_indexed_tests::create_tests());
    group
}
