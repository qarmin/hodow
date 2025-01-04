// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared  (deqp::gls::)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The helpers upstream shares between its GL modules. Ported on demand, like `tcu`
// and `glu`: whatever the ported groups actually use, and nothing guessed at.

pub mod attribute_location_tests;
pub mod brick_texture;
pub mod buffer_test_util;
pub mod builtin_precision_tests;
pub mod calibration;
pub mod clipping_tests;
pub mod default_vertex_attribute_case;
pub mod depth_tests;
pub mod draw_test;
pub mod draw_tests;
pub mod fbo_completeness_tests;
pub mod fbo_util;
pub mod flush_finish_cases;
pub mod frag_op_interaction_case;
pub mod fragment_op_util;
pub mod gen_mipmap;
pub mod interaction_test_util;
pub mod lifetime_tests;
pub mod polygon_offset_tests;
pub mod random_fragment_op_tests;
pub mod random_shader_case;
pub mod random_shader_program;
pub mod random_shader_tests;
pub mod random_uniform_block_case;
pub mod reference_context_buffers;
pub mod sampler_object_tests;
pub mod scissor_tests;
pub mod shader_builtin_var_cases;
pub mod shader_const_expr_tests;
pub mod shader_exec_util;
pub mod shader_library;
pub mod shader_render_case;
pub mod state_query_util;
pub mod stencil_tests;
pub mod texture_buffer_case;
pub mod texture_state_query_tests;
pub mod texture_test_util;
pub mod uniform_api_case;
pub mod uniform_block_case;
pub mod uniform_color_shader;
pub mod vertex_array_tests;
