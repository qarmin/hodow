// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// `KHR-GL30` ... `KHR-GL46`: the Khronos GL CTS desktop OpenGL roots (`external/openglcts`, one mustpass list `gl<version>-main` each). Every case registered here is a port of an
// upstream case under the same name, and the acceptance gate is `just cts-gl-diff` against the real `glcts` binary (`just glcts-build`).
//
// `packages.rs` mirrors upstream's cumulative package chain and says which root gets which group; one file per upstream group next to it. Keep the upstream group and case names exactly.

mod aggressive_shader_optimizations_tests;
mod api_coverage;
mod bind_image_texture_tests;
mod blend_equation_advanced_tests;
mod blend_reference;
mod buffer_objects_tests;
mod buffer_storage_tests;
mod clear_tex_image_tests;
mod clip_control_tests;
mod clip_distance_tests;
mod common_bugs_reserved_names;
mod common_bugs_tests;
mod compute_shader_tests;
mod conditional_render_inverted_tests;
mod copy_image;
mod cull_distance_tests;
mod direct_state_access_buffers_tests;
mod direct_state_access_framebuffers_tests;
mod direct_state_access_tests;
mod direct_state_access_textures_compressed_tests;
mod direct_state_access_textures_plain_tests;
mod direct_state_access_textures_subimage_errors_tests;
mod direct_state_access_textures_tests;
mod direct_state_access_vertex_arrays_tests;
mod draw_buffers_tests;
mod draw_elements_base_vertex_tests;
mod draw_indirect;
mod es31_compatibility_tests;
mod es31_image_load_store;
mod es31_ssbo;
pub mod esext;
mod explicit_uniform_location_tests;
mod exposed_extensions_tests;
mod ext_texture_shadow_lod_tests;
mod frag_coord_conventions_tests;
mod fragment_shading_rate;
mod framebuffer_blit;
mod geometry_shader;
mod get_texture_sub_image_tests;
mod get_uniform_tests;
mod gl_spirv_builtin_functions_table;
mod gl_spirv_builtin_variable_decorations_table;
mod gl_spirv_capabilities_table;
mod gl_spirv_tests;
mod glsl_noperspective_tests;
mod glsl_vector_constructor_tests;
mod gpu_shader5;
mod gpu_shader5_gl_tests;
mod gpu_shader_fp64;
mod incomplete_texture_access_tests;
mod indirect_parameters_tests;
pub mod internalformat_tests;
mod layout_binding_tests;
mod layout_location_tests;
mod limits_tests;
mod map_buffer_alignment_tests;
mod misc;
mod multi_bind_tests;
mod nearest_edge_tests;
mod negative_texture_lookup_functions_bias_tests;
mod packages;
mod packed_depth_stencil_tests;
pub mod packed_pixels;
mod parallel_shader_compile_tests;
mod pipeline_statistics_query_draw;
mod pipeline_statistics_query_functional;
mod pipeline_statistics_query_tests;
mod pixel_storage_modes_tests;
mod polygon_offset_clamp_tests;
mod post_depth_coverage_tests;
mod primitive_restart_tests;
mod program_interface_query_tests;
mod sample_shading_tests;
mod sample_variables_tests;
mod separable_programs_transform_feedback_tests;
mod sepshaderobjs;
mod shader_atomic_counter_ops_tests;
mod shader_atomic_counters_tests;
mod shader_ballot_tests;
mod shader_bitfield_operation_tests;
mod shader_const_expr_tests;
mod shader_draw_parameters_tests;
mod shader_group_vote_tests;
mod shader_image_load_store;
mod shader_image_size_tests;
mod shader_integer_mix_tests;
pub mod shader_library;
mod shader_multisample_interpolation_tests;
mod shader_negative_tests;
mod shader_storage_buffer_object;
mod shader_subroutine;
mod shader_texture_image_samples_tests;
mod shader_viewport_layer_array_tests;
mod shading_language_420pack;
mod sparse_buffer_tests;
mod sparse_texture2_tests;
mod sparse_texture_clamp_tests;
mod sparse_texture_tests;
mod spirv_extensions_tests;
mod stencil_texturing_tests;
mod subcase;
mod sync_tests;
mod tessellation_shader;
mod texture_barrier_tests;
mod texture_border_clamp;
mod texture_buffer;
mod texture_buffer_size_clamping_tests;
mod texture_cube_map_array;
mod texture_filter_anisotropic_tests;
mod texture_filter_minmax_tests;
mod texture_gather_tests;
mod texture_lod_basic_tests;
mod texture_lod_bias_tests;
mod texture_query_levels_tests;
mod texture_query_lod_tests;
mod texture_repeat_mode_tests;
mod texture_size_promotion_tests;
mod texture_stencil8_tests;
mod texture_storage_tests;
pub mod texture_swizzle;
mod texture_view;
mod transform_feedback2_tests;
mod transform_feedback3_tests;
mod transform_feedback_overflow_query_tests;
mod transform_feedback_tests;
mod uniform_block;
mod vertex_attrib_64bit_limits_tests;
mod vertex_attrib_64bit_tests;
mod vertex_attrib_64bit_vao_tests;
mod vertex_attrib_binding_tests;
mod viewport_array;

use crate::glu::TestCaseGroup;

/// The root for one desktop version, `30` to `46`.
pub fn create_tests(version: u8) -> TestCaseGroup {
    packages::create_root(version)
}
