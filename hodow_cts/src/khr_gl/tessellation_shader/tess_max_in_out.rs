// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderTessellation.cpp / .hpp   (TessellationShaderTessellationMaxInOut)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Written without compiling. The shader sources below are the upstream string literals concatenated.

use std::ffi::CString;

use super::TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `TessellationShaderTessellationMaxInOut`
pub(super) struct MaxInOut {
    pub ext_params: ExtParameters,
}

#[derive(Default)]
struct State {
    po_id_1: GLuint,
    po_id_2: GLuint,
    fs_id: GLuint,
    tcs_id_1: GLuint,
    tcs_id_2: GLuint,
    tes_id_1: GLuint,
    tes_id_2: GLuint,
    vs_id_1: GLuint,
    vs_id_2: GLuint,
    tf_bo_id_1: GLuint,
    tf_bo_id_2: GLuint,
    patch_data_bo_id: GLuint,
    vao_id: GLuint,
    gl_max_tess_control_input_components_value: GLint,
    gl_max_tess_control_output_components_value: GLint,
    gl_max_tess_evaluation_input_components_value: GLint,
    gl_max_tess_evaluation_output_components_value: GLint,
    gl_max_transform_feedback_interleaved_components_value: GLint,
    gl_max_tess_patch_components_value: GLint,
    gl_max_vertex_output_components_value: GLint,
    ref_patch_attributes: [f32; 4],
    ref_vertex_attributes: Vec<f32>,
}

const VS_CODE: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n${SHADER_IO_BLOCKS_ENABLE}\n\nprecision highp float;\n\nlayout(location = 0) in vec4 in_fv;\n\nout Vertex\n{\n    /* Note: we need to leave some space for gl_Position */\n    vec4 value[(gl_MaxTessControlInputComponents) / 4 - 1];\n} outVertex;\n\nvoid main()\n{\n    gl_Position = in_fv;\n\n    for (int i = 0 ; i < (gl_MaxTessControlInputComponents - 4) / 4 ; i++)\n    {\n        outVertex.value[i] = vec4(float(4*i), float(4*i) + 1.0, float(4*i) + 2.0, float(4*i) + 3.0);\n    }\n}\n";
const TC_CODE_1: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout(vertices = 2) out;\n\nin Vertex\n{\n    /* Note: we need to leave some space for gl_Position */\n    vec4 value[(gl_MaxTessControlInputComponents - 4) / 4];\n} inVertex[];\n\nout Vertex\n{\n    /* Note: we need to leave some space for gl_Position */\n    vec4 value[(gl_MaxTessControlOutputComponents - 4) / 4];\n} outVariables[];\n\nvoid main()\n{\n    gl_TessLevelInner[0] = 1.0;\n    gl_TessLevelInner[1] = 1.0;\n    gl_TessLevelOuter[0] = 1.0;\n    gl_TessLevelOuter[1] = 1.0;\n    gl_TessLevelOuter[2] = 1.0;\n    gl_TessLevelOuter[3] = 1.0;\n\n    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n\n    for (int j = 0; j < (gl_MaxTessControlOutputComponents - 4) / 4; j++)\n    {\n        outVariables[gl_InvocationID].value[j] = vec4(float(4*j), float(4*j) + 1.0, float(4*j) + 2.0, float(4*j) + 3.0);\n\n        for (int i = 0; i < (gl_MaxTessControlInputComponents-4)/4; i++)\n        {\n            outVariables[gl_InvocationID].value[j] += inVertex[gl_InvocationID].value[i];\n        }\n    }\n}\n";
const TC_CODE_2: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout(vertices = 2) out;\n\npatch out vec4 value[gl_MaxTessPatchComponents/4];\n\nvoid main()\n{\n    gl_TessLevelInner[0] = 1.0;\n    gl_TessLevelInner[1] = 1.0;\n    gl_TessLevelOuter[0] = 1.0;\n    gl_TessLevelOuter[1] = 1.0;\n    gl_TessLevelOuter[2] = 1.0;\n    gl_TessLevelOuter[3] = 1.0;\n\n    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n\n    for (int j = 0; j < gl_MaxTessPatchComponents / 4; j++)\n    {\n        value[j] = vec4(float(4*j), float(4*j) + 1.0, float(4*j) + 2.0, float(4*j) + 3.0);\n    }\n}\n";
const TE_CODE_1: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout (isolines, point_mode) in;\n\nin Vertex\n{\n    vec4 value[(gl_MaxTessEvaluationInputComponents - 4) / 4];\n} inVariables[];\n\nout Vertex\n{\n    vec4 value[(gl_MaxTessEvaluationOutputComponents - 4) / 4];\n} outVariables;\n\nvoid main()\n{\n    gl_Position = gl_in[0].gl_Position;\n\n    for (int j = 0; j < (gl_MaxTessEvaluationOutputComponents - 4) / 4; j++)\n    {\n        outVariables.value[j] = vec4(float(4*j), float(4*j) + 1.0, float(4*j) + 2.0, float(4*j) + 3.0);\n\n        for (int i = 0 ; i < (gl_MaxTessEvaluationInputComponents - 4) / 4; i++)\n        {\n            outVariables.value[j] += inVariables[0].value[i];\n        }\n    }\n}\n";
const TE_CODE_2: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout (isolines, point_mode) in;\n\npatch in vec4 value[gl_MaxTessPatchComponents / 4];\n\nout vec4 out_value;\n\nvoid main()\n{\n    gl_Position    = gl_in[0].gl_Position;\n    out_value = vec4(0.0);\n\n    for (int i = 0; i < gl_MaxTessPatchComponents / 4; i++)\n    {\n        out_value += value[i];\n    }\n}\n";
const FS_CODE: &str = "${VERSION}\n\nvoid main()\n{\n}\n";

impl MaxInOut {
    /// `retrieveGLConstantValues`
    fn retrieve_gl_constant_values(
        &self,
        context: &Context,
        base: &TestCaseBase,
        state: &mut State,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let tokens = base.gl_ext_tokens;

        gl!(gl.get_integerv(
            glw::GL_MAX_VERTEX_OUTPUT_COMPONENTS,
            &mut state.gl_max_vertex_output_components_value
        ));
        glu::expect_no_error(gl, "glGetIntegerv() failed for GL_MAX_VERTEX_OUTPUT_COMPONENTS pname!")?;

        gl!(gl.get_integerv(
            tokens.max_tess_control_input_components,
            &mut state.gl_max_tess_control_input_components_value
        ));
        glu::expect_no_error(
            gl,
            "glGetIntegerv() failed for GL_MAX_TESS_CONTROL_INPUT_COMPONENTS_EXT pname!",
        )?;

        gl!(gl.get_integerv(
            tokens.max_tess_control_output_components,
            &mut state.gl_max_tess_control_output_components_value
        ));
        glu::expect_no_error(
            gl,
            "glGetIntegerv() failed for GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS_EXT pname!",
        )?;

        gl!(gl.get_integerv(
            tokens.max_tess_patch_components,
            &mut state.gl_max_tess_patch_components_value
        ));
        glu::expect_no_error(gl, "glGetIntegerv() failed for GL_MAX_TESS_PATCH_COMPONENTS_EXT pname!")?;

        gl!(gl.get_integerv(
            tokens.max_tess_evaluation_input_components,
            &mut state.gl_max_tess_evaluation_input_components_value
        ));
        glu::expect_no_error(
            gl,
            "glGetIntegerv() failed for GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS_EXT pname!",
        )?;

        gl!(gl.get_integerv(
            tokens.max_tess_evaluation_output_components,
            &mut state.gl_max_tess_evaluation_output_components_value
        ));
        glu::expect_no_error(
            gl,
            "glGetIntegerv() failed for GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS_EXT pname!",
        )?;

        gl!(gl.get_integerv(
            glw::GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS,
            &mut state.gl_max_transform_feedback_interleaved_components_value
        ));
        glu::expect_no_error(
            gl,
            "glGetIntegerv() failed for GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS pname!",
        )?;

        // Make sure it is possible to transfer all components through all the stages. If not, the test may fail, so it is not supported.
        if state.gl_max_vertex_output_components_value < state.gl_max_tess_control_input_components_value {
            log::info!(
                "Warning: GL_MAX_VERTEX_OUTPUT_COMPONENTS value:{} is less than GL_MAX_TESS_CONTROL_INPUT_COMPONENTS_EXT: {}. It may not be possible to pass all GL_MAX_TESS_CONTROL_INPUT_COMPONENTS_EXT per-vertex components from Vertex Shader to Tessellation Control Shader.",
                state.gl_max_vertex_output_components_value,
                state.gl_max_tess_control_input_components_value
            );
            return Err(TestError::NotSupported(
                "GL_MAX_VERTEX_OUTPUT_COMPONENTS < GL_MAX_TESS_CONTROL_INPUT_COMPONENTS".to_string(),
            ));
        }

        if state.gl_max_tess_control_output_components_value != state.gl_max_tess_evaluation_input_components_value {
            log::info!(
                "Warning: GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS_EXT:{} is not equal to GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS_EXT:{}. It may not be possible to pass all GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS_EXT per-vertex components from Tessellation Control Shader to Tessellation Evaluation Shader.",
                state.gl_max_tess_control_output_components_value,
                state.gl_max_tess_evaluation_input_components_value
            );
            return Err(TestError::NotSupported(
                "GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS != GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS".to_string(),
            ));
        }

        if state.gl_max_tess_evaluation_output_components_value
            > state.gl_max_transform_feedback_interleaved_components_value
        {
            log::info!(
                "Warning: GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS_EXT:{} is greater than GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS:{}. It may not be possible to check all GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS_EXT per-vertex components from Tessellation Evaluation Shader.",
                state.gl_max_tess_evaluation_output_components_value,
                state.gl_max_transform_feedback_interleaved_components_value
            );
            return Err(TestError::NotSupported(
                "GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS > GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS"
                    .to_string(),
            ));
        }

        Ok(())
    }

    /// `initProgramObjects`
    fn init_program_objects(&self, context: &Context, base: &TestCaseBase, state: &mut State) -> Result<(), TestError> {
        let gl = context.gl();
        let tokens = base.gl_ext_tokens;

        state.po_id_1 = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed!")?;

        state.po_id_2 = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed!")?;

        state.vs_id_1 = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateShader(GL_VERTEX_SHADER) failed!")?;

        state.vs_id_2 = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateShader(GL_VERTEX_SHADER) failed!")?;

        state.tcs_id_1 = gl!(gl.create_shader(tokens.tess_control_shader));
        glu::expect_no_error(gl, "glCreateShader(GL_TESS_CONTROL_SHADER_EXT) failed!")?;

        state.tcs_id_2 = gl!(gl.create_shader(tokens.tess_control_shader));
        glu::expect_no_error(gl, "glCreateShader(GL_TESS_CONTROL_SHADER_EXT) failed!")?;

        state.tes_id_1 = gl!(gl.create_shader(tokens.tess_evaluation_shader));
        glu::expect_no_error(gl, "glCreateShader(GL_TESS_EVALUATION_SHADER_EXT) failed!")?;

        state.tes_id_2 = gl!(gl.create_shader(tokens.tess_evaluation_shader));
        glu::expect_no_error(gl, "glCreateShader(GL_TESS_EVALUATION_SHADER_EXT) failed!")?;

        state.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        glu::expect_no_error(gl, "glCreateShader(GL_FRAGMENT_SHADER) failed!")?;

        // Transform Feedback setup for case 1: "Vertex.value[i]" for i < MAX_TESS_EVALUATION_OUTPUT_COMPONENTS / 4 - 1, then gl_Position.
        let n_varyings = (state.gl_max_tess_evaluation_output_components_value / 4) as usize;
        let mut tf_varyings_names: Vec<CString> = Vec::with_capacity(n_varyings);
        for i in 0..n_varyings.saturating_sub(1) {
            tf_varyings_names.push(CString::new(format!("Vertex.value[{i}]")).expect("no nul byte"));
        }
        tf_varyings_names.push(CString::new("gl_Position").expect("no nul byte"));
        let tf_varyings: Vec<*const glw::GLchar> = tf_varyings_names.iter().map(|name| name.as_ptr()).collect();

        gl!(gl.transform_feedback_varyings(
            state.po_id_1,
            n_varyings as i32,
            tf_varyings.as_ptr(),
            glw::GL_INTERLEAVED_ATTRIBS
        ));
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() failed!")?;

        let (built, _) = base.build_program(
            context,
            state.po_id_1,
            &[
                ShaderBody::Source(state.vs_id_1, &[VS_CODE]),
                ShaderBody::Source(state.tcs_id_1, &[TC_CODE_1]),
                ShaderBody::Source(state.tes_id_1, &[TE_CODE_1]),
                ShaderBody::Source(state.fs_id, &[FS_CODE]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail("Could not build first test program object".to_string()));
        }

        // Transform Feedback setup for case 2
        let tf_varying_2 = CString::new("out_value").expect("no nul byte");
        let tf_varying_2_ptr = tf_varying_2.as_ptr();

        gl!(gl.transform_feedback_varyings(state.po_id_2, 1, &tf_varying_2_ptr, glw::GL_INTERLEAVED_ATTRIBS));
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() failed!")?;

        let (built, _) = base.build_program(
            context,
            state.po_id_2,
            &[
                ShaderBody::Source(state.vs_id_2, &[VS_CODE]),
                ShaderBody::Source(state.tcs_id_2, &[TC_CODE_2]),
                ShaderBody::Source(state.tes_id_2, &[TE_CODE_2]),
                ShaderBody::Source(state.fs_id, &[FS_CODE]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail("Could not link second test program object".to_string()));
        }

        Ok(())
    }

    /// `initBufferObjects`
    fn init_buffer_objects(&self, context: &Context, state: &mut State) -> Result<(), TestError> {
        let gl = context.gl();

        // Transform feedback buffer object for case 1
        gl!(gl.gen_buffers(1, &mut state.tf_bo_id_1));
        glu::expect_no_error(gl, "glGenBuffers() failed!")?;

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, state.tf_bo_id_1));
        glu::expect_no_error(gl, "glBindBuffer() failed!")?;

        let bo_size =
            (2 * 4 * state.gl_max_tess_evaluation_output_components_value / 4) as usize * std::mem::size_of::<f32>();

        gl!(gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            bo_size as isize,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "glBufferData() failed")?;

        // Transform feedback buffer object for case 2
        let bo_size = 2 * std::mem::size_of::<f32>() * 4;

        gl!(gl.gen_buffers(1, &mut state.tf_bo_id_2));
        glu::expect_no_error(gl, "glGenBuffers() failed!")?;

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, state.tf_bo_id_2));
        glu::expect_no_error(gl, "glBindBuffer() failed!")?;

        gl!(gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            bo_size as isize,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "glBufferData() failed")?;

        // Set up vertex data buffer storage
        let vertices: [f32; 8] = [0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0];

        gl!(gl.gen_buffers(1, &mut state.patch_data_bo_id));
        glu::expect_no_error(gl, "glGenBuffers() failed!")?;

        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, state.patch_data_bo_id));
        glu::expect_no_error(gl, "glBindBuffer() failed!")?;

        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(&vertices) as isize,
            vertices.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "glBufferData() failed!")?;

        gl!(gl.enable_vertex_attrib_array(0));
        glu::expect_no_error(gl, "glEnableVertexAttribArray() failed!")?;

        gl!(gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null()));
        glu::expect_no_error(gl, "glVertexAttribPointer() failed!")?;

        Ok(())
    }

    /// `initReferenceValues`
    fn init_reference_values(&self, state: &mut State) {
        let control_in = state.gl_max_tess_control_input_components_value;
        let control_out = state.gl_max_tess_control_output_components_value;
        let evaluation_in = state.gl_max_tess_evaluation_input_components_value;
        let evaluation_out = state.gl_max_tess_evaluation_output_components_value;

        let max_array_size = control_in.max(control_out).max(evaluation_in).max(evaluation_out);

        let reference = &mut state.ref_vertex_attributes;
        *reference = vec![0.0; max_array_size as usize];

        // The array holds the values of the per-vertex output block of the TE stage plus gl_Position.
        let mut sum_in_tcs = [0.0f32; 4];
        let mut sum_in_tes = [0.0f32; 4];

        for i in 0..control_in - 4 {
            reference[i as usize] = i as f32;
        }

        for i in 0..control_in - 4 {
            sum_in_tcs[(i % 4) as usize] += reference[i as usize];
        }

        for i in 0..control_out - 4 {
            reference[i as usize] = sum_in_tcs[(i % 4) as usize] + i as f32;
        }

        for i in (control_in - 4)..(control_out - 4) {
            reference[i as usize] = i as f32;
        }

        for i in 0..evaluation_in - 4 {
            sum_in_tes[(i % 4) as usize] += reference[i as usize];
        }

        for i in 0..evaluation_out - 4 {
            reference[i as usize] = sum_in_tes[(i % 4) as usize] + i as f32;
        }

        for i in (evaluation_in - 4)..(evaluation_out - 4) {
            reference[i as usize] = i as f32;
        }

        // gl_Position reference values (only the first vertex is compared)
        reference[(evaluation_out - 4) as usize] = 0.0;
        reference[(evaluation_out - 3) as usize] = 0.0;
        reference[(evaluation_out - 2) as usize] = 0.0;
        reference[(evaluation_out - 1) as usize] = 1.0;

        // Reference data for case 2: only one output vector is needed for comparison.
        state.ref_patch_attributes = [0.0; 4];

        for i in 0..state.gl_max_tess_patch_components_value {
            state.ref_patch_attributes[(i % 4) as usize] += i as f32;
        }
    }

    /// `compareValues`
    fn compare_values(
        &self,
        context: &Context,
        description: &str,
        reference_values: &[f32],
        n_reference_values: usize,
    ) -> Result<bool, TestError> {
        let gl = context.gl();

        let bo_size = 2 * std::mem::size_of::<f32>() * n_reference_values * 4;
        let mapped = gl!(gl.map_buffer_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            bo_size as isize,
            glw::GL_MAP_READ_BIT
        ));
        glu::expect_no_error(gl, "glMapBufferRange() failed")?;
        if mapped.is_null() {
            return Err(TestError::Fail("glMapBufferRange() returned NULL.".to_string()));
        }
        // SAFETY: `bo_size` bytes were mapped for reading; the mapping lives until the unmap below.
        let result_floats =
            unsafe { std::slice::from_raw_parts(mapped.cast::<f32>(), bo_size / std::mem::size_of::<f32>()) };

        let epsilon = 1e-5f32;
        let mut test_passed = true;

        for i in (0..n_reference_values * 4).step_by(4) {
            if (result_floats[i] - reference_values[i]).abs() > epsilon
                || (result_floats[i + 1] - reference_values[i + 1]).abs() > epsilon
                || (result_floats[i + 2] - reference_values[i + 2]).abs() > epsilon
                || (result_floats[i + 3] - reference_values[i + 3]).abs() > epsilon
            {
                log::info!(
                    "{description}: captured results vec4({}, {}, {}, {}) are different from the expected values vec4({}, {}, {}, {}).",
                    result_floats[i],
                    result_floats[i + 1],
                    result_floats[i + 2],
                    result_floats[i + 3],
                    reference_values[i],
                    reference_values[i + 1],
                    reference_values[i + 2],
                    reference_values[i + 3]
                );

                test_passed = false;
                break;
            }
        }

        gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
        glu::expect_no_error(gl, "glUnmapBuffer() failed!")?;

        Ok(test_passed)
    }

    fn run(&self, context: &Context, state: &mut State) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        // initTest
        if !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        gl!(gl.gen_vertex_arrays(1, &mut state.vao_id));
        glu::expect_no_error(gl, "Could not generate vertex array object")?;

        gl!(gl.bind_vertex_array(state.vao_id));
        glu::expect_no_error(gl, "Error binding vertex array object!")?;

        // All tessellation control shaders used by this test assume two vertices are going to be provided per input patch.
        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 2));
        glu::expect_no_error(gl, "glPatchParameteriEXT() failed!")?;

        self.retrieve_gl_constant_values(context, &base, state)?;
        self.init_program_objects(context, &base, state)?;
        self.init_buffer_objects(context, state)?;
        self.init_reference_values(state);

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glEnable(RASTERIZER_DISCARD) failed!")?;

        // Execute test case 1
        gl!(gl.use_program(state.po_id_1));
        glu::expect_no_error(gl, "glUseProgram() failed!")?;

        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, state.tf_bo_id_1));
        glu::expect_no_error(gl, "glBindBufferBase() failed!")?;

        gl!(gl.begin_transform_feedback(glw::GL_POINTS));
        glu::expect_no_error(gl, "glBeginTransformFeedback() failed")?;

        gl!(gl.draw_arrays(base.gl_ext_tokens.patches, 0, 2));
        glu::expect_no_error(gl, "glDrawArrays() failed")?;

        gl!(gl.end_transform_feedback());
        glu::expect_no_error(gl, "glEndTransformFeedback() failed")?;

        let mut test_passed = true;

        test_passed &= self.compare_values(
            context,
            "Per-vertex components test ",
            &state.ref_vertex_attributes,
            (state.gl_max_tess_evaluation_output_components_value / 4) as usize,
        )?;

        // Execute test case 2
        gl!(gl.use_program(state.po_id_2));
        glu::expect_no_error(gl, "glUseProgram() failed!")?;

        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, state.tf_bo_id_2));
        glu::expect_no_error(gl, "glBindBufferBase() failed!")?;

        gl!(gl.begin_transform_feedback(glw::GL_POINTS));
        glu::expect_no_error(gl, "glBeginTransformFeedback() failed")?;

        gl!(gl.draw_arrays(base.gl_ext_tokens.patches, 0, 2));
        glu::expect_no_error(gl, "glDrawArrays() failed")?;

        gl!(gl.end_transform_feedback());
        glu::expect_no_error(gl, "glEndTransformFeedback() failed")?;

        test_passed &= self.compare_values(context, "Per-patch components test ", &state.ref_patch_attributes, 1)?;

        Ok(if test_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestCase for MaxInOut {
    fn name(&self) -> &str {
        "max_in_out_attributes"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut state = State::default();
        let outcome = self.run(context, &mut state);

        let base = TestCaseBase::init(context, self.ext_params);
        if !base.is_tessellation_shader_supported {
            return outcome;
        }

        // upstream leaves rasterizer discard enabled
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 3));
        gl!(gl.bind_vertex_array(0));

        for shader in [
            state.fs_id,
            state.tcs_id_1,
            state.tcs_id_2,
            state.tes_id_1,
            state.tes_id_2,
            state.vs_id_1,
            state.vs_id_2,
        ] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        for program in [state.po_id_1, state.po_id_2] {
            if program != 0 {
                gl!(gl.delete_program(program));
            }
        }
        for buffer in [state.tf_bo_id_1, state.tf_bo_id_2, state.patch_data_bo_id] {
            if buffer != 0 {
                gl!(gl.delete_buffers(1, &buffer));
            }
        }
        if state.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &state.vao_id));
        }
        outcome
    }
}
