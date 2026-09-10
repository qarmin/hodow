// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fIntegerStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Every "is this core GL 4.5?" branch
// takes the ES path, so a case whose minimum version is ES 3.2 reports NotSupported on
// the ES 3.1 context this module brings up rather than running.

use crate::gles31::functional::state_query::query_util::{
    QueriedState, QueryType, query_state, verify_state_integer, verify_state_integer_max, verify_state_integer_min,
};
use crate::glu::{ApiCase, Buffer, TestCaseGroup, add_api_case};
use crate::glw::{self, GLenum, GLint, GLuint};

/// `verifiers[]`
const VERIFIERS: [QueryType; 4] = [QueryType::Boolean, QueryType::Integer, QueryType::Integer64, QueryType::Float];

/// The ES 3.2 minimums that differ from ES 3.1's for the same target.
const MAX_FRAG_ATOMIC_COUNTER_BUFFERS_GLES32: i32 = 1;
const MAX_FRAG_ATOMIC_COUNTERS_GLES32: i32 = 8;
const MAX_FRAG_SHADER_STORAGE_BLOCKS_GLES32: i32 = 4;

/// `MaxSamplesCase::iterate`
fn max_samples_case(case: &mut ApiCase<'_>, target: GLenum, min_value: i32, verifier: QueryType) {
    verify_state_integer_min(case, target, min_value, verifier);
}

/// `TexBindingCase::init`
fn tex_binding_supported(case: &mut ApiCase<'_>, tex_target: GLenum) -> bool {
    if case.context().context_type().supports(3, 2) {
        return true;
    }

    let (needed, extension) = match tex_target {
        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => (true, "GL_OES_texture_storage_multisample_2d_array"),
        glw::GL_TEXTURE_CUBE_MAP_ARRAY => (true, "GL_EXT_texture_cube_map_array"),
        glw::GL_TEXTURE_BUFFER => (true, "GL_EXT_texture_buffer"),
        _ => (false, ""),
    };
    if !needed || case.context().context_info.is_extension_supported(extension) {
        return true;
    }
    case.not_supported(format!("Test requires {extension} extension"));
    false
}

/// `TexBindingCase::iterate`
fn tex_binding_case(case: &mut ApiCase<'_>, tex_target: GLenum, bind_target: GLenum, verifier: QueryType) {
    if !tex_binding_supported(case, tex_target) {
        return;
    }

    case.section("Initial value");
    verify_state_integer(case, bind_target, 0, verifier);

    case.section("After bind");
    let mut texture: GLuint = 0;
    // SAFETY: one name out, then bound to the target under test.
    unsafe {
        case.gl().gen_textures(1, &raw mut texture);
        case.gl().bind_texture(tex_target, texture);
    }
    case.expect_no_error("bind texture");

    #[expect(clippy::cast_possible_wrap, reason = "a GL name always fits in a GLint")]
    let texture_as_int = texture as GLint;
    verify_state_integer(case, bind_target, texture_as_int, verifier);

    // SAFETY: this case's own name; deleting it also unbinds it.
    unsafe { case.gl().delete_textures(1, &raw const texture) };

    case.section("After delete");
    verify_state_integer(case, bind_target, 0, verifier);
}

/// `MinimumValueCase::iterate`
fn minimum_value_case(case: &mut ApiCase<'_>, target: GLenum, min_value: i32, verifier: QueryType, min_version: (i32, i32)) {
    if !case.context().context_type().supports(min_version.0, min_version.1) {
        case.not_supported("Test not supported in this context version.");
        return;
    }

    // In GL ES 3.2 these three targets have different limits than in 3.1.
    let value = if case.context().context_type().supports(3, 2) {
        match target {
            glw::GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS => MAX_FRAG_ATOMIC_COUNTER_BUFFERS_GLES32,
            glw::GL_MAX_FRAGMENT_ATOMIC_COUNTERS => MAX_FRAG_ATOMIC_COUNTERS_GLES32,
            glw::GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS => MAX_FRAG_SHADER_STORAGE_BLOCKS_GLES32,
            _ => min_value,
        }
    } else {
        min_value
    };

    verify_state_integer_min(case, target, value, verifier);
}

/// `AlignmentCase::iterate` - an alignment is an upper bound, not a lower one.
fn alignment_case(case: &mut ApiCase<'_>, target: GLenum, min_value: i32, verifier: QueryType, min_version: (i32, i32)) {
    if !case.context().context_type().supports(min_version.0, min_version.1) {
        case.not_supported("Test not supported in this context.");
        return;
    }
    verify_state_integer_max(case, target, min_value, verifier);
}

/// `BufferBindingCase::iterate`
fn buffer_binding_case(case: &mut ApiCase<'_>, query_target: GLenum, binding_point: GLenum, verifier: QueryType) {
    case.section("Initial value");
    verify_state_integer(case, query_target, 0, verifier);

    case.section("After binding");
    {
        let buf = Buffer::new(case.gl());
        // SAFETY: a buffer name this case owns until the end of this block.
        unsafe { case.gl().bind_buffer(binding_point, buf.get()) };
        case.expect_no_error("setup");

        #[expect(clippy::cast_possible_wrap, reason = "a GL name always fits in a GLint")]
        let buf_as_int = buf.get() as GLint;
        verify_state_integer(case, query_target, buf_as_int, verifier);
    }

    case.section("After deleting");
    let mut buf: GLuint = 0;
    // SAFETY: one name out, bound, then deleted - which unbinds it.
    unsafe {
        case.gl().gen_buffers(1, &raw mut buf);
        case.gl().bind_buffer(binding_point, buf);
        case.gl().delete_buffers(1, &raw const buf);
    }
    case.expect_no_error("setup");
    verify_state_integer(case, query_target, 0, verifier);
}

/// `ProgramPipelineBindingCase::iterate`
fn program_pipeline_binding_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    case.section("Initial value");
    verify_state_integer(case, glw::GL_PROGRAM_PIPELINE_BINDING, 0, verifier);

    case.section("After binding");
    let mut pipeline: GLuint = 0;
    // SAFETY: one name out, then bound.
    unsafe {
        case.gl().gen_program_pipelines(1, &raw mut pipeline);
        case.gl().bind_program_pipeline(pipeline);
    }
    case.expect_no_error("setup");

    #[expect(clippy::cast_possible_wrap, reason = "a GL name always fits in a GLint")]
    let pipeline_as_int = pipeline as GLint;
    verify_state_integer(case, glw::GL_PROGRAM_PIPELINE_BINDING, pipeline_as_int, verifier);

    // SAFETY: this case's own name.
    unsafe {
        case.gl().bind_program_pipeline(0);
        case.gl().delete_program_pipelines(1, &raw const pipeline);
    }

    case.section("After deleting");
    let mut pipeline: GLuint = 0;
    // SAFETY: as above - deleting a bound pipeline resets the binding to zero.
    unsafe {
        case.gl().gen_program_pipelines(1, &raw mut pipeline);
        case.gl().bind_program_pipeline(pipeline);
        case.gl().delete_program_pipelines(1, &raw const pipeline);
    }
    case.expect_no_error("setup");
    verify_state_integer(case, glw::GL_PROGRAM_PIPELINE_BINDING, 0, verifier);
}

/// `FramebufferMinimumValueCase::iterate`
fn framebuffer_minimum_value_case(case: &mut ApiCase<'_>, target: GLenum, min_value: i32, tied_to: GLenum, verifier: QueryType) {
    case.section("Specified minimum");
    verify_state_integer_min(case, target, min_value, verifier);

    case.section("The limit is tied to another state's value");
    if let Some(QueriedState::Integer(tied)) = query_state(case, QueryType::Integer, tied_to) {
        verify_state_integer_min(case, target, tied, verifier);
    }
}

/// `LegacyVectorLimitCase::iterate`
fn legacy_vector_limit_case(case: &mut ApiCase<'_>, legacy_target: GLenum, component_target: GLenum, verifier: QueryType) {
    case.section("The legacy limit is the component limit divided by four");
    if let Some(QueriedState::Integer(components)) = query_state(case, QueryType::Integer, component_target) {
        verify_state_integer(case, legacy_target, components / 4, verifier);
    }
}

/// `CombinedUniformComponentsCase::iterate`
fn combined_uniform_components_case(case: &mut ApiCase<'_>, target: GLenum, verifier: QueryType, min_version: (i32, i32)) {
    if !case.context().context_type().supports(min_version.0, min_version.1) {
        case.not_supported("Test not supported in this context.");
        return;
    }

    let max_uniform_blocks_enum = match target {
        glw::GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS => glw::GL_MAX_COMPUTE_UNIFORM_BLOCKS,
        glw::GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS => glw::GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS,
        glw::GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS => glw::GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS,
        glw::GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS => glw::GL_MAX_GEOMETRY_UNIFORM_BLOCKS,
        _ => glw::GL_NONE,
    };
    let max_uniform_components_enum = match target {
        glw::GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS => glw::GL_MAX_COMPUTE_UNIFORM_COMPONENTS,
        glw::GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS => glw::GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS,
        glw::GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS => glw::GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS,
        glw::GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS => glw::GL_MAX_GEOMETRY_UNIFORM_COMPONENTS,
        _ => glw::GL_NONE,
    };

    case.section("The minimum value is MAX_*_UNIFORM_BLOCKS x MAX_UNIFORM_BLOCK_SIZE / 4 + MAX_*_UNIFORM_COMPONENTS");

    let mut blocks = 0;
    let mut block_size = 0;
    let mut components = 0;
    // SAFETY: three separate one-integer queries.
    unsafe {
        case.gl().get_integerv(max_uniform_blocks_enum, &raw mut blocks);
        case.gl().get_integerv(glw::GL_MAX_UNIFORM_BLOCK_SIZE, &raw mut block_size);
        case.gl().get_integerv(max_uniform_components_enum, &raw mut components);
    }
    case.expect_no_error("glGetIntegerv");

    verify_state_integer_min(case, target, blocks * block_size / 4 + components, verifier);
}

/// `TextureGatherLimitCase::iterate`
fn texture_gather_limit_case(case: &mut ApiCase<'_>, is_max_case: bool, verifier: QueryType) {
    if is_max_case {
        verify_state_integer_min(case, glw::GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET, 0, verifier);
    } else {
        verify_state_integer_max(case, glw::GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET, 0, verifier);
    }
}

/// `MaxUniformBufferBindingsCase::iterate`
fn max_uniform_buffer_bindings_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    let min_max = if case.context().context_type().supports(3, 2) {
        72
    } else if case.context().context_info.is_extension_supported("GL_EXT_tessellation_shader") {
        72
    } else if case.context().context_info.is_extension_supported("GL_EXT_geometry_shader") {
        48
    } else {
        36
    };
    verify_state_integer_min(case, glw::GL_MAX_UNIFORM_BUFFER_BINDINGS, min_max, verifier);
}

/// `MaxCombinedUniformBlocksCase::iterate`
fn max_combined_uniform_blocks_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    let min_max = if case.context().context_type().supports(3, 2) {
        60
    } else if case.context().context_info.is_extension_supported("GL_EXT_tessellation_shader") {
        60
    } else if case.context().context_info.is_extension_supported("GL_EXT_geometry_shader") {
        36
    } else {
        24
    };
    verify_state_integer_min(case, glw::GL_MAX_COMBINED_UNIFORM_BLOCKS, min_max, verifier);
}

/// `MaxCombinedTexImageUnitsCase::iterate`
fn max_combined_tex_image_units_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    let min_max = if case.context().context_type().supports(3, 2) {
        96
    } else if case.context().context_info.is_extension_supported("GL_EXT_tessellation_shader") {
        96
    } else if case.context().context_info.is_extension_supported("GL_EXT_geometry_shader") {
        // Upstream's log line here says 36 while the value it checks is 64; the value
        // is what matters and is kept as upstream has it.
        64
    } else {
        48
    };
    verify_state_integer_min(case, glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS, min_max, verifier);
}

/// Every `MaxSamplesCase` entry: (name, target, minimum).
const MAX_SAMPLES: [(&str, GLenum, i32); 3] = [
    ("max_color_texture_samples", glw::GL_MAX_COLOR_TEXTURE_SAMPLES, 1),
    ("max_depth_texture_samples", glw::GL_MAX_DEPTH_TEXTURE_SAMPLES, 1),
    ("max_integer_samples", glw::GL_MAX_INTEGER_SAMPLES, 1),
];

/// Every `TexBindingCase` entry: (name, texture target, binding query).
const TEX_BINDINGS: [(&str, GLenum, GLenum); 4] = [
    ("texture_binding_2d_multisample", glw::GL_TEXTURE_2D_MULTISAMPLE, glw::GL_TEXTURE_BINDING_2D_MULTISAMPLE),
    (
        "texture_binding_2d_multisample_array",
        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
        glw::GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY,
    ),
    ("texture_binding_cube_map_array", glw::GL_TEXTURE_CUBE_MAP_ARRAY, glw::GL_TEXTURE_BINDING_CUBE_MAP_ARRAY),
    ("texture_binding_buffer", glw::GL_TEXTURE_BUFFER, glw::GL_TEXTURE_BINDING_BUFFER),
];

/// Every `BufferBindingCase` entry: (name, query target, binding point).
const BUFFER_BINDINGS: [(&str, GLenum, GLenum); 4] = [
    ("draw_indirect_buffer_binding", glw::GL_DRAW_INDIRECT_BUFFER_BINDING, glw::GL_DRAW_INDIRECT_BUFFER),
    ("atomic_counter_buffer_binding", glw::GL_ATOMIC_COUNTER_BUFFER_BINDING, glw::GL_ATOMIC_COUNTER_BUFFER),
    ("shader_storage_buffer_binding", glw::GL_SHADER_STORAGE_BUFFER_BINDING, glw::GL_SHADER_STORAGE_BUFFER),
    ("dispatch_indirect_buffer_binding", glw::GL_DISPATCH_INDIRECT_BUFFER_BINDING, glw::GL_DISPATCH_INDIRECT_BUFFER),
];

/// Every `FramebufferMinimumValueCase` entry: (name, target, minimum, tied to).
const FRAMEBUFFER_MINIMUMS: [(&str, GLenum, i32, GLenum); 3] = [
    ("max_framebuffer_width", glw::GL_MAX_FRAMEBUFFER_WIDTH, 2048, glw::GL_MAX_TEXTURE_SIZE),
    ("max_framebuffer_height", glw::GL_MAX_FRAMEBUFFER_HEIGHT, 2048, glw::GL_MAX_TEXTURE_SIZE),
    ("max_framebuffer_samples", glw::GL_MAX_FRAMEBUFFER_SAMPLES, 4, glw::GL_MAX_SAMPLES),
];

/// Every `MinimumValueCase` entry, in upstream's registration order:
/// (name, target, minimum, minimum context version).
const MINIMUM_VALUES: [(&str, GLenum, i32, (i32, i32)); 79] = [
    ("max_vertex_attrib_relative_offset", glw::GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET, 2047, (3, 1)),
    ("max_vertex_attrib_bindings", glw::GL_MAX_VERTEX_ATTRIB_BINDINGS, 16, (3, 1)),
    ("max_vertex_attrib_stride", glw::GL_MAX_VERTEX_ATTRIB_STRIDE, 2048, (3, 1)),
    ("max_sample_mask_words", glw::GL_MAX_SAMPLE_MASK_WORDS, 1, (3, 1)),
    // vertex
    ("max_vertex_atomic_counter_buffers", glw::GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS, 0, (3, 1)),
    ("max_vertex_atomic_counters", glw::GL_MAX_VERTEX_ATOMIC_COUNTERS, 0, (3, 1)),
    ("max_vertex_image_uniforms", glw::GL_MAX_VERTEX_IMAGE_UNIFORMS, 0, (3, 1)),
    ("max_vertex_shader_storage_blocks", glw::GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS, 0, (3, 1)),
    ("max_vertex_uniform_components", glw::GL_MAX_VERTEX_UNIFORM_COMPONENTS, 1024, (3, 1)),
    // fragment
    ("max_fragment_atomic_counter_buffers", glw::GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS, 0, (3, 1)),
    ("max_fragment_atomic_counters", glw::GL_MAX_FRAGMENT_ATOMIC_COUNTERS, 0, (3, 1)),
    ("max_fragment_image_uniforms", glw::GL_MAX_FRAGMENT_IMAGE_UNIFORMS, 0, (3, 1)),
    ("max_fragment_shader_storage_blocks", glw::GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS, 0, (3, 1)),
    ("max_fragment_uniform_components", glw::GL_MAX_FRAGMENT_UNIFORM_COMPONENTS, 1024, (3, 1)),
    // compute
    ("max_compute_work_group_invocations", glw::GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS, 128, (3, 1)),
    ("max_compute_uniform_blocks", glw::GL_MAX_COMPUTE_UNIFORM_BLOCKS, 12, (3, 1)),
    ("max_compute_texture_image_units", glw::GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS, 16, (3, 1)),
    ("max_compute_shared_memory_size", glw::GL_MAX_COMPUTE_SHARED_MEMORY_SIZE, 16384, (3, 1)),
    ("max_compute_uniform_components", glw::GL_MAX_COMPUTE_UNIFORM_COMPONENTS, 1024, (3, 1)),
    ("max_compute_atomic_counter_buffers", glw::GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS, 1, (3, 1)),
    ("max_compute_atomic_counters", glw::GL_MAX_COMPUTE_ATOMIC_COUNTERS, 8, (3, 1)),
    ("max_compute_image_uniforms", glw::GL_MAX_COMPUTE_IMAGE_UNIFORMS, 4, (3, 1)),
    ("max_compute_shader_storage_blocks", glw::GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS, 4, (3, 1)),
    ("max_uniform_locations", glw::GL_MAX_UNIFORM_LOCATIONS, 1024, (3, 1)),
    ("max_atomic_counter_buffer_bindings", glw::GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS, 1, (3, 1)),
    ("max_atomic_counter_buffer_size", glw::GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE, 32, (3, 1)),
    ("max_combined_atomic_counter_buffers", glw::GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS, 1, (3, 1)),
    ("max_combined_atomic_counters", glw::GL_MAX_COMBINED_ATOMIC_COUNTERS, 8, (3, 1)),
    ("max_image_units", glw::GL_MAX_IMAGE_UNITS, 4, (3, 1)),
    ("max_combined_image_uniforms", glw::GL_MAX_COMBINED_IMAGE_UNIFORMS, 4, (3, 1)),
    ("max_shader_storage_buffer_bindings", glw::GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS, 4, (3, 1)),
    ("max_shader_storage_block_size", glw::GL_MAX_SHADER_STORAGE_BLOCK_SIZE, 1 << 27, (3, 1)),
    ("max_combined_shader_storage_blocks", glw::GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS, 4, (3, 1)),
    ("max_combined_shader_output_resources", glw::GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES, 4, (3, 1)),
    // GL ES 3.2
    ("max_framebuffer_layers", glw::GL_MAX_FRAMEBUFFER_LAYERS, 256, (3, 2)),
    ("fragment_interpolation_offset_bits", glw::GL_FRAGMENT_INTERPOLATION_OFFSET_BITS, 4, (3, 2)),
    ("max_texture_buffer_size", glw::GL_MAX_TEXTURE_BUFFER_SIZE, 65536, (3, 2)),
    ("max_tess_gen_level", glw::GL_MAX_TESS_GEN_LEVEL, 64, (3, 2)),
    ("max_patch_vertices", glw::GL_MAX_PATCH_VERTICES, 32, (3, 2)),
    ("max_tess_patch_components", glw::GL_MAX_TESS_PATCH_COMPONENTS, 120, (3, 2)),
    // tess control
    ("max_tess_control_uniform_components", glw::GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS, 1024, (3, 2)),
    ("max_tess_control_texture_image_units", glw::GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS, 16, (3, 2)),
    ("max_tess_control_output_components", glw::GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS, 64, (3, 2)),
    ("max_tess_control_total_output_components", glw::GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS, 2048, (3, 2)),
    ("max_tess_control_input_components", glw::GL_MAX_TESS_CONTROL_INPUT_COMPONENTS, 64, (3, 2)),
    ("max_tess_control_uniform_blocks", glw::GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS, 12, (3, 2)),
    ("max_tess_control_atomic_counter_buffers", glw::GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS, 0, (3, 2)),
    ("max_tess_control_atomic_counters", glw::GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS, 0, (3, 2)),
    ("max_tess_control_shader_storage_blocks", glw::GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS, 0, (3, 2)),
    // tess evaluation
    ("max_tess_evaluation_uniform_components", glw::GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS, 1024, (3, 2)),
    ("max_tess_evaluation_texture_image_units", glw::GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS, 16, (3, 2)),
    ("max_tess_evaluation_output_components", glw::GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS, 64, (3, 2)),
    ("max_tess_evaluation_input_components", glw::GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS, 64, (3, 2)),
    ("max_tess_evaluation_uniform_blocks", glw::GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS, 12, (3, 2)),
    ("max_tess_evaluation_atomic_counter_buffers", glw::GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS, 0, (3, 2)),
    ("max_tess_evaluation_atomic_counters", glw::GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS, 0, (3, 2)),
    ("max_tess_evaluation_shader_storage_blocks", glw::GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS, 0, (3, 2)),
    // geometry
    ("max_geometry_uniform_components", glw::GL_MAX_GEOMETRY_UNIFORM_COMPONENTS, 1024, (3, 2)),
    ("max_geometry_uniform_blocks", glw::GL_MAX_GEOMETRY_UNIFORM_BLOCKS, 12, (3, 2)),
    ("max_geometry_input_components", glw::GL_MAX_GEOMETRY_INPUT_COMPONENTS, 64, (3, 2)),
    ("max_geometry_output_components", glw::GL_MAX_GEOMETRY_OUTPUT_COMPONENTS, 64, (3, 2)),
    ("max_geometry_output_vertices", glw::GL_MAX_GEOMETRY_OUTPUT_VERTICES, 256, (3, 2)),
    ("max_geometry_total_output_components", glw::GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS, 1024, (3, 2)),
    ("max_geometry_texture_image_units", glw::GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS, 16, (3, 2)),
    ("max_geometry_shader_invocations", glw::GL_MAX_GEOMETRY_SHADER_INVOCATIONS, 32, (3, 2)),
    ("max_geometry_atomic_counter_buffers", glw::GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS, 0, (3, 2)),
    ("max_geometry_atomic_counters", glw::GL_MAX_GEOMETRY_ATOMIC_COUNTERS, 0, (3, 2)),
    ("max_geometry_shader_storage_blocks", glw::GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS, 0, (3, 2)),
    ("max_tess_control_image_uniforms", glw::GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS, 0, (3, 2)),
    ("max_tess_evaluation_image_uniforms", glw::GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS, 0, (3, 2)),
    ("max_geometry_image_uniforms", glw::GL_MAX_GEOMETRY_IMAGE_UNIFORMS, 0, (3, 2)),
    ("debug_logged_messages", glw::GL_DEBUG_LOGGED_MESSAGES, 0, (3, 2)),
    ("debug_next_logged_message_length", glw::GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH, 0, (3, 2)),
    ("debug_group_stack_depth", glw::GL_DEBUG_GROUP_STACK_DEPTH, 0, (3, 2)),
    ("max_debug_message_length", glw::GL_MAX_DEBUG_MESSAGE_LENGTH, 1, (3, 2)),
    ("max_debug_logged_messages", glw::GL_MAX_DEBUG_LOGGED_MESSAGES, 1, (3, 2)),
    ("max_debug_group_stack_depth", glw::GL_MAX_DEBUG_GROUP_STACK_DEPTH, 64, (3, 2)),
    ("max_label_length", glw::GL_MAX_LABEL_LENGTH, 256, (3, 2)),
    ("texture_buffer_binding", glw::GL_TEXTURE_BUFFER_BINDING, 0, (3, 2)),
];

/// Every `AlignmentCase` entry: (name, target, alignment, minimum context version).
const ALIGNMENTS: [(&str, GLenum, i32, (i32, i32)); 2] = [
    ("shader_storage_buffer_offset_alignment", glw::GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT, 256, (3, 1)),
    ("texture_buffer_offset_alignment", glw::GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT, 256, (3, 2)),
];

/// Every `LegacyVectorLimitCase` entry: (name, legacy target, component target).
const LEGACY_VECTOR_LIMITS: [(&str, GLenum, GLenum); 2] = [
    ("max_vertex_uniform_vectors", glw::GL_MAX_VERTEX_UNIFORM_VECTORS, glw::GL_MAX_VERTEX_UNIFORM_COMPONENTS),
    ("max_fragment_uniform_vectors", glw::GL_MAX_FRAGMENT_UNIFORM_VECTORS, glw::GL_MAX_FRAGMENT_UNIFORM_COMPONENTS),
];

/// Every `CombinedUniformComponentsCase` entry: (name, target, minimum version).
const COMBINED_UNIFORM_COMPONENTS: [(&str, GLenum, (i32, i32)); 4] = [
    ("max_combined_compute_uniform_components", glw::GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS, (3, 1)),
    ("max_combined_tess_control_uniform_components", glw::GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS, (3, 2)),
    (
        "max_combined_tess_evaluation_uniform_components",
        glw::GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS,
        (3, 2),
    ),
    ("max_combined_geometry_uniform_components", glw::GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS, (3, 2)),
];

/// `IntegerStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("integer");

    for (name, target, min_value) in MAX_SAMPLES {
        for verifier in VERIFIERS {
            add_api_case(&mut group, format!("{name}_{}", verifier.suffix()), move |case: &mut ApiCase<'_>| {
                max_samples_case(case, target, min_value, verifier);
            });
        }
    }

    for (name, tex_target, bind_target) in TEX_BINDINGS {
        for verifier in VERIFIERS {
            add_api_case(&mut group, format!("{name}_{}", verifier.suffix()), move |case: &mut ApiCase<'_>| {
                tex_binding_case(case, tex_target, bind_target, verifier);
            });
        }
    }

    // The first four `MINIMUM_VALUES` rows, then the alignment, buffer-binding,
    // framebuffer-limit and pipeline cases, then the rest of the minimums - upstream
    // interleaves them, and the case *order* inside the group is what it decides.
    let mut add_minimums = |group: &mut TestCaseGroup, rows: &[(&'static str, GLenum, i32, (i32, i32))]| {
        for (name, target, min_value, min_version) in rows.iter().copied() {
            for verifier in VERIFIERS {
                add_api_case(group, format!("{name}_{}", verifier.suffix()), move |case: &mut ApiCase<'_>| {
                    minimum_value_case(case, target, min_value, verifier, min_version);
                });
            }
        }
    };

    add_minimums(&mut group, &MINIMUM_VALUES[0..4]);

    for verifier in VERIFIERS {
        let (name, target, min_value, min_version) = ALIGNMENTS[0];
        add_api_case(&mut group, format!("{name}_{}", verifier.suffix()), move |case: &mut ApiCase<'_>| {
            alignment_case(case, target, min_value, verifier, min_version);
        });
    }

    for (name, query_target, binding_point) in BUFFER_BINDINGS {
        for verifier in VERIFIERS {
            add_api_case(&mut group, format!("{name}_{}", verifier.suffix()), move |case: &mut ApiCase<'_>| {
                buffer_binding_case(case, query_target, binding_point, verifier);
            });
        }
    }

    for (name, target, min_value, tied_to) in FRAMEBUFFER_MINIMUMS {
        for verifier in VERIFIERS {
            add_api_case(&mut group, format!("{name}_{}", verifier.suffix()), move |case: &mut ApiCase<'_>| {
                framebuffer_minimum_value_case(case, target, min_value, tied_to, verifier);
            });
        }
    }

    for verifier in VERIFIERS {
        add_api_case(&mut group, format!("program_pipeline_binding_{}", verifier.suffix()), move |case: &mut ApiCase<'_>| {
            program_pipeline_binding_case(case, verifier);
        });
    }

    add_minimums(&mut group, &MINIMUM_VALUES[4..34]);

    for verifier in VERIFIERS {
        add_api_case(&mut group, format!("max_uniform_buffer_bindings_{}", verifier.suffix()), move |case: &mut ApiCase<'_>| {
            max_uniform_buffer_bindings_case(case, verifier);
        });
    }
    for verifier in VERIFIERS {
        add_api_case(&mut group, format!("max_combined_uniform_blocks_{}", verifier.suffix()), move |case: &mut ApiCase<'_>| {
            max_combined_uniform_blocks_case(case, verifier);
        });
    }
    for verifier in VERIFIERS {
        add_api_case(
            &mut group,
            format!("max_combined_texture_image_units_{}", verifier.suffix()),
            move |case: &mut ApiCase<'_>| max_combined_tex_image_units_case(case, verifier),
        );
    }
    for verifier in VERIFIERS {
        let (name, target, min_version) = COMBINED_UNIFORM_COMPONENTS[0];
        add_api_case(&mut group, format!("{name}_{}", verifier.suffix()), move |case: &mut ApiCase<'_>| {
            combined_uniform_components_case(case, target, verifier, min_version);
        });
    }

    for (name, legacy_target, component_target) in LEGACY_VECTOR_LIMITS {
        for verifier in VERIFIERS {
            add_api_case(&mut group, format!("{name}_{}", verifier.suffix()), move |case: &mut ApiCase<'_>| {
                legacy_vector_limit_case(case, legacy_target, component_target, verifier);
            });
        }
    }

    for (name, is_max_case) in [("min_program_texture_gather_offset", false), ("max_program_texture_gather_offset", true)] {
        for verifier in VERIFIERS {
            add_api_case(&mut group, format!("{name}_{}", verifier.suffix()), move |case: &mut ApiCase<'_>| {
                texture_gather_limit_case(case, is_max_case, verifier);
            });
        }
    }

    // GL ES 3.2 tests
    add_minimums(&mut group, &MINIMUM_VALUES[34..37]);

    for verifier in VERIFIERS {
        let (name, target, min_value, min_version) = ALIGNMENTS[1];
        add_api_case(&mut group, format!("{name}_{}", verifier.suffix()), move |case: &mut ApiCase<'_>| {
            alignment_case(case, target, min_value, verifier, min_version);
        });
    }

    add_minimums(&mut group, &MINIMUM_VALUES[37..79]);

    for (name, target, min_version) in COMBINED_UNIFORM_COMPONENTS.into_iter().skip(1) {
        for verifier in VERIFIERS {
            add_api_case(&mut group, format!("{name}_{}", verifier.suffix()), move |case: &mut ApiCase<'_>| {
                combined_uniform_components_case(case, target, verifier, min_version);
            });
        }
    }

    group
}
