// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderMaxPatchVertices.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::CString;

use super::TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const OUTPUT_VERTEX_COUNT: usize = 2;

const VS_CODE: &str = "${VERSION}\n\n${SHADER_IO_BLOCKS_ENABLE}\n\nprecision highp float;\n\nlayout(location = 0) in vec4  in_fv;\nlayout(location = 1) in ivec4 in_iv;\n\nout Vertex\n{\n    ivec4 iv;\n    vec4  fv;\n} outVertex;\n\nvoid main()\n{\n    gl_Position  = in_fv;\n    outVertex.iv = in_iv;\n    outVertex.fv = in_fv;\n}\n";
const TC_CODE: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nprecision highp float;\n\nin Vertex\n{\n    ivec4 iv;\n    vec4  fv;\n} inVertex[];\n\nlayout(vertices = 2) out;\n\nout Vertex\n{\n    ivec4 iv;\n    vec4  fv;\n} outVertex[];\n\nvoid main()\n{\n    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n    outVertex[gl_InvocationID].iv = ivec4(0);\n    outVertex[gl_InvocationID].fv = vec4(0);\n\n    for (int i = 0; i < gl_PatchVerticesIn; i++)\n    {\n        outVertex[gl_InvocationID].iv += inVertex[i].iv;\n        outVertex[gl_InvocationID].fv += inVertex[i].fv;\n    }\n\n    gl_TessLevelInner[0] = 1.0;\n    gl_TessLevelInner[1] = 1.0;\n    gl_TessLevelOuter[0] = 1.0;\n    gl_TessLevelOuter[1] = 1.0;\n    gl_TessLevelOuter[2] = 1.0;\n    gl_TessLevelOuter[3] = 1.0;\n}\n";
const TE_CODE: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout (isolines, point_mode) in;\n\nin Vertex\n{\n    ivec4 iv;\n    vec4  fv;\n} inVertex[];\n\nout  vec4 result_fv;\nout ivec4 result_iv;\n\nvoid main()\n{\n    gl_Position = gl_in[0].gl_Position;\n    result_iv   = ivec4(0);\n    result_fv   = vec4(0.0);\n\n    for (int i = 0 ; i < gl_PatchVerticesIn; i++)\n    {\n        result_iv += inVertex[i].iv;\n        result_fv += inVertex[i].fv;\n    }\n}\n";
const FS_CODE: &str = "${VERSION}\n\nvoid main()\n{\n}\n";
const TF_VARYINGS: [&str; 2] = ["result_fv", "result_iv"];

/// `TessellationShaderMaxPatchVertices`
pub(super) struct MaxPatchVertices {
    pub ext_params: ExtParameters,
}

#[derive(Default)]
struct State {
    bo_id_f_1: GLuint,
    bo_id_f_2: GLuint,
    bo_id_i_1: GLuint,
    bo_id_i_2: GLuint,
    fs_id: GLuint,
    po_id_1: GLuint,
    po_id_2: GLuint,
    tc_id: GLuint,
    te_id: GLuint,
    tf_id_1: GLuint,
    tf_id_2: GLuint,
    vs_id: GLuint,
    vao_id: GLuint,
    gl_max_patch_vertices: GLint,
    patch_vertices_bo_f_id: GLuint,
    patch_vertices_bo_i_id: GLuint,
    ref_fv_case_1: [f32; 4],
    ref_iv_case_1: [GLint; 4],
    ref_fv_case_2: [f32; 4],
    ref_iv_case_2: [GLint; 4],
}

fn set_tf_varyings(gl: &glw::Functions, po_id: GLuint) -> Result<(), TestError> {
    let names: Vec<CString> = TF_VARYINGS
        .iter()
        .map(|name| CString::new(*name).expect("no nul byte"))
        .collect();
    let pointers: Vec<*const glw::GLchar> = names.iter().map(|name| name.as_ptr()).collect();
    gl!(gl.transform_feedback_varyings(po_id, 2, pointers.as_ptr(), glw::GL_SEPARATE_ATTRIBS));
    glu::expect_no_error(gl, "glTransformFeedbackVaryings() failed!")
}

impl MaxPatchVertices {
    /// `initProgramObjects`
    fn init_program_objects(&self, context: &Context, base: &TestCaseBase, state: &mut State) -> Result<(), TestError> {
        let gl = context.gl();
        let tokens = base.gl_ext_tokens;
        let is_es = !context.context_type().api.desktop;

        state.po_id_1 = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed!")?;
        state.po_id_2 = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed!")?;

        gl!(gl.gen_transform_feedbacks(1, &mut state.tf_id_1));
        glu::expect_no_error(gl, "glGenTransformFeedbacks() failed!")?;
        gl!(gl.gen_transform_feedbacks(1, &mut state.tf_id_2));
        glu::expect_no_error(gl, "glGenTransformFeedbacks() failed!")?;

        state.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateShader(VERTEX_SHADER) failed!")?;
        state.tc_id = gl!(gl.create_shader(tokens.tess_control_shader));
        glu::expect_no_error(gl, "glCreateShader() failed!")?;
        state.te_id = gl!(gl.create_shader(tokens.tess_evaluation_shader));
        glu::expect_no_error(gl, "glCreateShader() failed!")?;
        state.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        glu::expect_no_error(gl, "glCreateShader() failed!")?;

        gl!(gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, state.tf_id_1));
        glu::expect_no_error(gl, "glBindTransformFeedback() failed!")?;
        set_tf_varyings(gl, state.po_id_1)?;

        let (built, _) = base.build_program(
            context,
            state.po_id_1,
            &[
                ShaderBody::Source(state.vs_id, &[VS_CODE]),
                ShaderBody::Source(state.tc_id, &[TC_CODE]),
                ShaderBody::Source(state.te_id, &[TE_CODE]),
                ShaderBody::Source(state.fs_id, &[FS_CODE]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail("Program linking failed!".to_string()));
        }

        if !is_es {
            gl!(gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, state.tf_id_2));
            glu::expect_no_error(gl, "glBindTransformFeedback() failed!")?;
            set_tf_varyings(gl, state.po_id_2)?;

            let (built, _) = base.build_program(
                context,
                state.po_id_2,
                &[
                    ShaderBody::Source(state.vs_id, &[VS_CODE]),
                    ShaderBody::Source(state.te_id, &[TE_CODE]),
                    ShaderBody::Source(state.fs_id, &[FS_CODE]),
                ],
            )?;
            if !built {
                return Err(TestError::Fail("Program linking failed!".to_string()));
            }
        }
        Ok(())
    }

    /// `initTransformFeedbackBufferObjects`
    fn init_transform_feedback_buffer_objects(&self, context: &Context, state: &mut State) -> Result<(), TestError> {
        let gl = context.gl();
        let is_es = !context.context_type().api.desktop;
        let float_size = (std::mem::size_of::<f32>() * 4 * OUTPUT_VERTEX_COUNT) as isize;
        let int_size = (std::mem::size_of::<GLint>() * 4 * OUTPUT_VERTEX_COUNT) as isize;

        gl!(gl.gen_buffers(1, &mut state.bo_id_f_1));
        glu::expect_no_error(gl, "glGenBuffers() failed")?;
        gl!(gl.gen_buffers(1, &mut state.bo_id_f_2));
        glu::expect_no_error(gl, "glGenBuffers() failed")?;
        gl!(gl.gen_buffers(1, &mut state.bo_id_i_1));
        glu::expect_no_error(gl, "glGenBuffers() failed")?;
        gl!(gl.gen_buffers(1, &mut state.bo_id_i_2));
        glu::expect_no_error(gl, "glGenBuffers() failed")?;

        gl!(gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, state.tf_id_1));
        glu::expect_no_error(gl, "glBindTransformFeedback() failed!")?;

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, state.bo_id_f_1));
        glu::expect_no_error(gl, "glBindBuffer() failed!")?;
        gl!(gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            float_size,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "glBufferData() failed")?;

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, state.bo_id_i_1));
        glu::expect_no_error(gl, "glBindBuffer() failed!")?;
        gl!(gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            int_size,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "glBufferData() failed")?;

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0));
        glu::expect_no_error(gl, "glBindTransformFeedback(0) failed")?;

        if !is_es {
            gl!(gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, state.tf_id_2));
            glu::expect_no_error(gl, "glBindTransformFeedback() failed!")?;

            gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, state.bo_id_f_2));
            glu::expect_no_error(gl, "glBindBuffer() failed!")?;
            gl!(gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                float_size,
                std::ptr::null(),
                glw::GL_STATIC_DRAW
            ));
            glu::expect_no_error(gl, "glBufferData() failed")?;

            gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, state.bo_id_i_2));
            glu::expect_no_error(gl, "glBindBuffer() failed!")?;
            gl!(gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                int_size,
                std::ptr::null(),
                glw::GL_STATIC_DRAW
            ));
            glu::expect_no_error(gl, "glBufferData() failed")?;

            gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0));
            glu::expect_no_error(gl, "glBindTransformFeedback(0) failed")?;

            set_tf_varyings(gl, state.po_id_2)?;
        }
        Ok(())
    }

    /// `initVertexBufferObjects`
    fn init_vertex_buffer_objects(&self, context: &Context, state: &mut State) -> Result<(), TestError> {
        let gl = context.gl();
        let n = state.gl_max_patch_vertices as usize;

        let patch_vertices_f: Vec<f32> = (0..n).flat_map(|_| [1.0_f32, 2.0, 3.0, 4.0]).collect();
        let patch_vertices_i: Vec<GLint> = (0..n).flat_map(|_| [1, 2, 3, 4]).collect();

        gl!(gl.gen_buffers(1, &mut state.patch_vertices_bo_f_id));
        glu::expect_no_error(gl, "glGenBuffers() failed!")?;
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, state.patch_vertices_bo_f_id));
        glu::expect_no_error(gl, "glBindBuffer() failed!")?;
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            (n * 4 * std::mem::size_of::<f32>()) as isize,
            patch_vertices_f.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "glBufferData() failed!")?;
        gl!(gl.vertex_attrib_pointer(
            0,
            4,
            glw::GL_FLOAT,
            glw::GL_FALSE as glw::GLboolean,
            0,
            std::ptr::null()
        ));
        glu::expect_no_error(gl, "glVertexAttribPointer(fv) failed!")?;
        gl!(gl.enable_vertex_attrib_array(0));
        glu::expect_no_error(gl, "glEnableVertexAttribArray(fv) failed!")?;
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

        gl!(gl.gen_buffers(1, &mut state.patch_vertices_bo_i_id));
        glu::expect_no_error(gl, "glGenBuffers(ARRAY_BUFFER) failed!")?;
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, state.patch_vertices_bo_i_id));
        glu::expect_no_error(gl, "glBindBuffer(ARRAY_BUFFER) failed!")?;
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            (n * 4 * std::mem::size_of::<GLint>()) as isize,
            patch_vertices_i.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "glBufferData(ARRAY_BUFFER) failed!")?;
        gl!(gl.vertex_attrib_i_pointer(1, 4, glw::GL_INT, 0, std::ptr::null()));
        glu::expect_no_error(gl, "glVertexAttribPointer(iv) failed!")?;
        gl!(gl.enable_vertex_attrib_array(1));
        glu::expect_no_error(gl, "glEnableVertexAttribArray(iv) failed!")?;
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        glu::expect_no_error(gl, "glBindBuffer() failed!")
    }

    /// `initReferenceValues`
    fn init_reference_values(&self, context: &Context, state: &mut State) {
        let max = state.gl_max_patch_vertices;
        state.ref_fv_case_1 = [
            (max * 2) as f32 * 1.0,
            (max * 2) as f32 * 2.0,
            (max * 2) as f32 * 3.0,
            (max * 2) as f32 * 4.0,
        ];
        state.ref_iv_case_1 = [max * 2, max * 2 * 2, max * 2 * 3, max * 2 * 4];

        if context.context_type().api.desktop {
            state.ref_fv_case_2 = [max as f32 * 1.0, max as f32 * 2.0, max as f32 * 3.0, max as f32 * 4.0];
            state.ref_iv_case_2 = [max, max * 2, max * 3, max * 4];
        }
    }

    /// `initTest`
    fn init_test(&self, context: &Context, base: &TestCaseBase, state: &mut State) -> Result<(), TestError> {
        let gl = context.gl();

        gl!(gl.gen_vertex_arrays(1, &mut state.vao_id));
        glu::expect_no_error(gl, "Could not generate vertex array object")?;
        gl!(gl.bind_vertex_array(state.vao_id));
        glu::expect_no_error(gl, "Error binding vertex array object!")?;

        gl!(gl.get_integerv(base.gl_ext_tokens.max_patch_vertices, &mut state.gl_max_patch_vertices));
        glu::expect_no_error(gl, "glGetIntegerv() failed for GL_MAX_PATCH_VERTICES_EXT pname!")?;

        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, state.gl_max_patch_vertices));
        glu::expect_no_error(gl, "glPatchParameteriEXT() failed for GL_PATCH_VERTICES_EXT pname!")?;

        self.init_program_objects(context, base, state)?;
        self.init_transform_feedback_buffer_objects(context, state)?;
        self.init_vertex_buffer_objects(context, state)?;
        self.init_reference_values(context, state);
        Ok(())
    }

    fn map_xfb_words(gl: &glw::Functions, message: &str) -> Result<Vec<u32>, TestError> {
        let size = std::mem::size_of::<u32>() * 4 * OUTPUT_VERTEX_COUNT;
        let mapped = gl!(gl.map_buffer_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            size as isize,
            glw::GL_MAP_READ_BIT
        ));
        glu::expect_no_error(gl, message)?;
        if mapped.is_null() {
            return Err(TestError::Fail("glMapBufferRange() returned NULL.".to_string()));
        }
        // SAFETY: `size` bytes were mapped for reading and the copy ends before the unmap.
        Ok(unsafe { std::slice::from_raw_parts(mapped.cast::<u32>(), size / 4) }.to_vec())
    }

    /// `compareResults(description, GLfloat ref_fv[4])`
    fn compare_results_float(
        &self,
        context: &Context,
        description: &str,
        ref_fv: &[f32; 4],
        failed: &mut bool,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let words = Self::map_xfb_words(gl, "glMapBufferRange(floats) failed")?;
        let result_floats: Vec<f32> = words.iter().map(|word| f32::from_bits(*word)).collect();

        let epsilon = 1e-5_f32;
        let mut test_failed = false;
        for i in 0..4 {
            if (result_floats[i] - ref_fv[i]).abs() > epsilon {
                *failed = true;
                log::info!(
                    "{description} captured results vec4({}, {}, {}, {}) are different from the expected values vec4({}, {}, {}, {}).",
                    result_floats[0],
                    result_floats[1],
                    result_floats[2],
                    result_floats[3],
                    ref_fv[0],
                    ref_fv[1],
                    ref_fv[2],
                    ref_fv[3]
                );
                test_failed = true;
                break;
            }
        }

        gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
        glu::expect_no_error(gl, "glUnmapBuffer() failed!")?;
        Ok(!test_failed)
    }

    /// `compareResults(description, GLint ref_iv[4])`
    fn compare_results_int(
        &self,
        context: &Context,
        description: &str,
        ref_iv: &[GLint; 4],
        failed: &mut bool,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let words = Self::map_xfb_words(gl, "glMapBufferRange(ints) failed")?;
        let result_ints: Vec<GLint> = words.iter().map(|word| *word as GLint).collect();

        let mut test_failed = false;
        for i in 0..4 {
            if result_ints[i] != ref_iv[i] {
                *failed = true;
                log::info!(
                    "{description} captured results ivec4({}, {}, {}, {}) are different from the expected values ivec4({}, {}, {}, {}).",
                    result_ints[0],
                    result_ints[1],
                    result_ints[2],
                    result_ints[3],
                    ref_iv[0],
                    ref_iv[1],
                    ref_iv[2],
                    ref_iv[3]
                );
                test_failed = true;
                break;
            }
        }

        gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
        glu::expect_no_error(gl, "glUnmapBuffer() failed!")?;
        Ok(!test_failed)
    }

    fn run(&self, context: &Context, state: &mut State) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        if !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        self.init_test(context, &base, state)?;

        gl!(gl.use_program(state.po_id_1));
        glu::expect_no_error(gl, "glUseProgram() failed!")?;

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glEnable(RASTERIZER_DISCARD) failed!")?;

        gl!(gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, state.tf_id_1));
        glu::expect_no_error(gl, "glBindTransformFeedback() failed!")?;

        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, state.bo_id_f_1));
        glu::expect_no_error(gl, "glBindBufferRange() failed!")?;
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 1, state.bo_id_i_1));
        glu::expect_no_error(gl, "glBindBufferRange() failed!")?;

        gl!(gl.begin_transform_feedback(glw::GL_POINTS));
        glu::expect_no_error(gl, "glBeginTransformFeedback() failed")?;

        gl!(gl.draw_arrays(base.gl_ext_tokens.patches, 0, state.gl_max_patch_vertices));
        glu::expect_no_error(gl, "glDrawArrays() failed")?;

        gl!(gl.end_transform_feedback());
        glu::expect_no_error(gl, "glEndTransformFeedback() failed")?;

        let mut failed = false;
        let mut test_passed = true;

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, state.bo_id_f_1));
        glu::expect_no_error(gl, "glBindBuffer() failed!")?;
        test_passed &=
            self.compare_results_float(context, "Case 1 (explicit arrays)", &state.ref_fv_case_1, &mut failed)?;

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, state.bo_id_i_1));
        glu::expect_no_error(gl, "glBindBuffer() failed!")?;
        test_passed &=
            self.compare_results_int(context, "Case 1 (explicit arrays)", &state.ref_iv_case_1, &mut failed)?;

        // Case 2 runs with no TCS (the default one is expected to be used); desktop only.
        if context.context_type().api.desktop {
            gl!(gl.use_program(state.po_id_2));
            glu::expect_no_error(gl, "glUseProgram() failed!")?;

            gl!(gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, state.tf_id_2));
            glu::expect_no_error(gl, "glBindTransformFeedback() failed!")?;

            gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, state.bo_id_f_2));
            glu::expect_no_error(gl, "glBindBufferRange() failed!")?;
            gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 1, state.bo_id_i_2));
            glu::expect_no_error(gl, "glBindBufferRange() failed!")?;

            let inner = [1.0_f32, 1.0];
            let outer = [1.0_f32, 1.0, 1.0, 1.0];
            gl!(gl.patch_parameterfv(glw::GL_PATCH_DEFAULT_OUTER_LEVEL, outer.as_ptr()));
            glu::expect_no_error(gl, "glPatchParameterfv() failed!")?;
            gl!(gl.patch_parameterfv(glw::GL_PATCH_DEFAULT_INNER_LEVEL, inner.as_ptr()));
            glu::expect_no_error(gl, "glPatchParameterfv() failed!")?;

            gl!(gl.begin_transform_feedback(glw::GL_POINTS));
            glu::expect_no_error(gl, "glBeginTransformFeedback(GL_POINTS) failed")?;

            gl!(gl.draw_arrays(glw::GL_PATCHES, 0, state.gl_max_patch_vertices));
            glu::expect_no_error(gl, "glDrawArrays() failed")?;

            gl!(gl.end_transform_feedback());
            glu::expect_no_error(gl, "glEndTransformFeedback() failed")?;

            gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, state.bo_id_f_2));
            glu::expect_no_error(gl, "glBindBuffer() failed!")?;
            test_passed &=
                self.compare_results_float(context, "Case 2 (implicit arrays)", &state.ref_fv_case_2, &mut failed)?;

            gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, state.bo_id_i_2));
            glu::expect_no_error(gl, "glBindBuffer() failed!")?;
            test_passed &=
                self.compare_results_int(context, "Case 2 (implicit arrays)", &state.ref_iv_case_2, &mut failed)?;
        }

        // Upstream sets the failure on the first mismatch and the pass only when nothing mismatched.
        Ok(if test_passed && !failed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestCase for MaxPatchVertices {
    fn name(&self) -> &str {
        "max_patch_vertices"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut state = State::default();
        let outcome = self.run(context, &mut state);

        let base = TestCaseBase::init(context, self.ext_params);
        if !base.is_tessellation_shader_supported {
            return outcome;
        }

        gl!(gl.use_program(0));
        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 3));
        if context.context_type().api.desktop {
            let default_levels = [1.0_f32, 1.0, 1.0, 1.0];
            gl!(gl.patch_parameterfv(glw::GL_PATCH_DEFAULT_INNER_LEVEL, default_levels.as_ptr()));
            gl!(gl.patch_parameterfv(glw::GL_PATCH_DEFAULT_OUTER_LEVEL, default_levels.as_ptr()));
        }
        gl!(gl.disable_vertex_attrib_array(0));
        gl!(gl.disable_vertex_attrib_array(1));
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 1, 0));
        gl!(gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, 0));
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.bind_vertex_array(0));

        for buffer in [
            state.bo_id_f_1,
            state.bo_id_f_2,
            state.bo_id_i_1,
            state.bo_id_i_2,
            state.patch_vertices_bo_f_id,
            state.patch_vertices_bo_i_id,
        ] {
            if buffer != 0 {
                gl!(gl.delete_buffers(1, &buffer));
            }
        }
        for shader in [state.vs_id, state.tc_id, state.te_id, state.fs_id] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        for tf in [state.tf_id_1, state.tf_id_2] {
            if tf != 0 {
                gl!(gl.delete_transform_feedbacks(1, &tf));
            }
        }
        for program in [state.po_id_1, state.po_id_2] {
            if program != 0 {
                gl!(gl.delete_program(program));
            }
        }
        if state.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &state.vao_id));
        }
        outcome
    }
}
