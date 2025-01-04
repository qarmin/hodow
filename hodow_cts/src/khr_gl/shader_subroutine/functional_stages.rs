// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderSubroutineTests.cpp  (FunctionalTest17, FunctionalTest18_19)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. FunctionalTest17's `deinit` is the `Drop` of `State`, which also restores the patch size and pack alignment its `initTest` changes.

use super::utils::{Buffer, VertexArray, draw_points_and_read_xfb};
use super::{ShaderStage, build_program, check_subroutine_support, fail, verdict};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLint, GLsizeiptr, GLuint};
use crate::tcu::{TestError, TestOutcome};

const STAGES_FS: &str = "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nin GS_DATA\n{\n    vec4 gs_data;\n    vec4 tc_data;\n    vec4 te_data;\n    vec4 vs_data;\n} gs;\n\nout vec4 result;\n\nsubroutine void subroutineTypeFS(out vec4 result);\n\nsubroutine(subroutineTypeFS) void subroutine1(out vec4 result)\n{\n    result = vec4(5, 6, 7, 8);\n}\n\nsubroutine uniform subroutineTypeFS function;\n\nvoid main()\n{\n    vec4 fs_data;\n\n    function(fs_data);\n    result = gs.gs_data + gs.tc_data + gs.te_data + gs.vs_data + fs_data;\n}\n";

const STAGES_GS: &str = "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nlayout(points)                           in;\nlayout(triangle_strip, max_vertices = 4) out;\n\nsubroutine void subroutineTypeGS(out vec4 result);\n\nsubroutine(subroutineTypeGS) void subroutine1(out vec4 result)\n{\n    result = vec4(4, 5, 6, 7);\n}\n\nsubroutine uniform subroutineTypeGS function;\n\nin TE_DATA\n{\n    vec4 tc_data;\n    vec4 te_data;\n    vec4 vs_data;\n} te[];\n\nout GS_DATA\n{\n    vec4 gs_data;\n    vec4 tc_data;\n    vec4 te_data;\n    vec4 vs_data;\n} result;\n\nvoid main()\n{\n    function(result.gs_data);\n    gl_Position    = vec4(1, -1, 0, 1);\n    result.tc_data = te[0].tc_data;\n    result.te_data = te[0].te_data;\n    result.vs_data = te[0].vs_data;\n    EmitVertex();\n\n    function(result.gs_data);\n    gl_Position    = vec4(-1, -1, 0, 1);\n    result.tc_data = te[0].tc_data;\n    result.te_data = te[0].te_data;\n    result.vs_data = te[0].vs_data;\n    EmitVertex();\n\n    function(result.gs_data);\n    gl_Position    = vec4(1, 1, 0, 1);\n    result.tc_data = te[0].tc_data;\n    result.te_data = te[0].te_data;\n    result.vs_data = te[0].vs_data;\n    EmitVertex();\n\n    function(result.gs_data);\n    gl_Position    = vec4(-1, 1, 0, 1);\n    result.tc_data = te[0].tc_data;\n    result.te_data = te[0].te_data;\n    result.vs_data = te[0].vs_data;\n    EmitVertex();\n    EndPrimitive();\n}\n";

const STAGES_TC: &str = "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nlayout (vertices = 4) out;\n\nsubroutine void subroutineTypeTC(out vec4 result);\n\nsubroutine(subroutineTypeTC) void subroutine1(out vec4 result)\n{\n    result = vec4(2, 3, 4, 5);\n}\n\nsubroutine uniform subroutineTypeTC function;\n\nin VS_DATA\n{\n    vec4 vs_data;\n} vs[];\n\nout TC_DATA\n{\n    vec4 tc_data;\n    vec4 vs_data;\n} result[];\n\nvoid main()\n{\n    gl_TessLevelInner[0] = 1.0;\n    gl_TessLevelInner[1] = 1.0;\n    gl_TessLevelOuter[0] = 1.0;\n    gl_TessLevelOuter[1] = 1.0;\n    gl_TessLevelOuter[2] = 1.0;\n    gl_TessLevelOuter[3] = 1.0;\n\n    function(result[gl_InvocationID].tc_data);\n    result[gl_InvocationID].vs_data = vs[gl_InvocationID].vs_data;\n}\n";

const STAGES_TE: &str = "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nlayout (quads, point_mode) in;\n\nsubroutine void subroutineTypeTE(out vec4 result);\n\nsubroutine(subroutineTypeTE) void subroutine1(out vec4 result)\n{\n    result = vec4(3, 4, 5, 6);\n}\n\nsubroutine uniform subroutineTypeTE function;\n\nin TC_DATA\n{\n    vec4 tc_data;\n    vec4 vs_data;\n} tc[];\n\nout TE_DATA\n{\n    vec4 tc_data;\n    vec4 te_data;\n    vec4 vs_data;\n} result;\n\nvoid main()\n{\n    result.vs_data = tc[0].vs_data;\n    result.tc_data = tc[0].tc_data;\n    function(result.te_data);\n}\n";

const STAGES_VS: &str = "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nout VS_DATA\n{\n    vec4 vs_data;\n} result;\n\nsubroutine void subroutineTypeVS(out vec4 result);\n\nsubroutine(subroutineTypeVS) void subroutine1(out vec4 result)\n{\n    result = vec4(1, 2, 3, 4);\n}\n\nsubroutine uniform subroutineTypeVS function;\n\nvoid main()\n{\n    function(result.vs_data);\n}\n";

const TO_WIDTH: GLuint = 4;
const TO_HEIGHT: GLuint = 4;

/// The GL objects of `FunctionalTest17` that are not the program; its `deinit` is the `Drop`.
struct State<'gl> {
    gl: &'gl glw::Functions,
    fbo_id: GLuint,
    to_id: GLuint,
    vao_id: GLuint,
}

impl Drop for State<'_> {
    fn drop(&mut self) {
        // SAFETY: every name below was created by this state, is deleted once and zero names are skipped.
        unsafe {
            if self.fbo_id != 0 {
                self.gl.delete_framebuffers(1, &self.fbo_id);
            }
            if self.to_id != 0 {
                self.gl.delete_textures(1, &self.to_id);
            }
            if self.vao_id != 0 {
                self.gl.delete_vertex_arrays(1, &self.vao_id);
            }
            self.gl.patch_parameteri(glw::GL_PATCH_VERTICES, 3);
            self.gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 4);
        }
    }
}

/// `FunctionalTest17`
pub(super) struct SameNamesDifferentTypesInAllStages;

impl TestCase for SameNamesDifferentTypesInAllStages {
    fn name(&self) -> &str {
        "same_subroutine_and_subroutine_uniform_but_different_type_used_in_all_stages"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut has_test_passed = true;

        check_subroutine_support(context)?;

        let mut state = State {
            gl,
            fbo_id: 0,
            to_id: 0,
            vao_id: 0,
        };

        gl_call!(
            gl,
            "glPatchParameteri() call failed.",
            gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1)
        );
        gl_call!(
            gl,
            "glGenVertexArrays() call failed.",
            gl.gen_vertex_arrays(1, &mut state.vao_id)
        );
        gl_call!(
            gl,
            "glBindVertexArray() call failed.",
            gl.bind_vertex_array(state.vao_id)
        );

        let sources = [
            (ShaderStage::Vertex, STAGES_VS),
            (ShaderStage::TessellationControl, STAGES_TC),
            (ShaderStage::TessellationEvaluation, STAGES_TE),
            (ShaderStage::Geometry, STAGES_GS),
            (ShaderStage::Fragment, STAGES_FS),
        ];
        let Some(program) = build_program(gl, &sources, None)? else {
            return fail("Failed to link test program object");
        };

        gl_call!(gl, "glGenTextures() call failed.", gl.gen_textures(1, &mut state.to_id));
        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_2D, state.to_id)
        );
        gl_call!(
            gl,
            "glTexStorage2D() call failed.",
            gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                1,
                glw::GL_RGBA32F,
                TO_WIDTH as glw::GLsizei,
                TO_HEIGHT as glw::GLsizei
            )
        );

        gl_call!(
            gl,
            "glGenFramebuffers() call failed.",
            gl.gen_framebuffers(1, &mut state.fbo_id)
        );
        gl_call!(
            gl,
            "glBindFramebuffer() call failed.",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, state.fbo_id)
        );
        gl_call!(
            gl,
            "glFramebufferTexture2D() call failed.",
            gl.framebuffer_texture_2d(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                state.to_id,
                0
            )
        );

        gl_call!(
            gl,
            "glPixelStorei() call failed.",
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1)
        );

        let mut to_data = vec![0.0f32; (TO_WIDTH * TO_HEIGHT * 4) as usize];

        gl_call!(gl, "glUseProgram() call failed.", gl.use_program(program.program));
        gl_call!(gl, "glDrawArrays() call failed.", gl.draw_arrays(glw::GL_PATCHES, 0, 1));
        gl_call!(
            gl,
            "glReaDPixels() call failed.",
            gl.read_pixels(
                0,
                0,
                TO_WIDTH as glw::GLsizei,
                TO_HEIGHT as glw::GLsizei,
                glw::GL_RGBA,
                glw::GL_FLOAT,
                to_data.as_mut_ptr().cast()
            )
        );

        let epsilon = 1e-5;
        let expected_data = [15.0f32, 20.0, 25.0, 30.0];

        'rows: for y in 0..TO_HEIGHT as usize {
            for x in 0..TO_WIDTH as usize {
                let pixel = &to_data[(y * TO_WIDTH as usize + x) * 4..][..4];

                if (0..4).any(|i| (pixel[i] - expected_data[i]).abs() > epsilon) {
                    log::info!(
                        "Invalid texel found at ({x}, {y}): expected:({}, {}, {}, {}), found:({}, {}, {}, {}).",
                        expected_data[0],
                        expected_data[1],
                        expected_data[2],
                        expected_data[3],
                        pixel[0],
                        pixel[1],
                        pixel[2],
                        pixel[3]
                    );
                    has_test_passed = false;
                    break 'rows;
                }
            }
        }

        verdict(has_test_passed)
    }
}

const CONTROL_FLOW_VS: &str = "#version 400\n\nsubroutine bool bool_processor();\nsubroutine vec4 vec4_processor(in vec4 iparam);\n\nsubroutine(bool_processor) bool returnsFalse()\n{\n    return false;\n}\n\nsubroutine(bool_processor) bool returnsTrue()\n{\n    return true;\n}\n\nsubroutine(vec4_processor) vec4 divideByTwo(in vec4 iparam)\n{\n    return iparam * vec4(0.5);\n}\n\nsubroutine(vec4_processor) vec4 multiplyByFour(in vec4 iparam)\n{\n    return iparam * vec4(4.0);\n}\n\nsubroutine uniform bool_processor bool_operator1;\nsubroutine uniform bool_processor bool_operator2;\nsubroutine uniform vec4_processor vec4_operator1;\nsubroutine uniform vec4_processor vec4_operator2;\n\nout float result;\n\nvoid main()\n{\n    if (bool_operator1() )\n    {\n        float value = float( (3 * gl_VertexID + 1) * 2);\n\n        while (bool_operator1() )\n        {\n            value /= float(gl_VertexID + 2);\n\n            if (value <= 1.0f) break;\n        }\n\n        result = value;\n    }\n    else\n    {\n        vec4 value = vec4(gl_VertexID,     gl_VertexID + 1,\n                          gl_VertexID + 2, gl_VertexID + 3);\n\n        switch (gl_VertexID % 2)\n        {\n            case 0:\n            {\n                for (int iteration = 0; iteration < gl_VertexID && bool_operator2(); ++iteration)\n                {\n                    value = vec4_operator2(vec4_operator1(value));\n                }\n\n                break;\n            }\n\n            case 1:\n            {\n                for (int iteration = 0; iteration < gl_VertexID * 2; ++iteration)\n                {\n                    value = vec4_operator1(vec4_operator2(value));\n                }\n\n                break;\n            }\n        }\n\n        result = value.x + value.y + value.z + value.w;\n\n    }\n}\n";

/// The GL names and subroutine locations `FunctionalTest18_19::initTest` looks up.
struct ControlFlowLocations {
    divide_by_two: GLuint,
    returns_true: GLuint,
    uniform_bool_operator1: GLint,
    uniform_bool_operator2: GLint,
    uniform_vec4_processor1: GLint,
    uniform_vec4_processor2: GLint,
}

/// `FunctionalTest18_19`
pub(super) struct ControlFlowAndReturnedValues;

impl ControlFlowAndReturnedValues {
    const N_POINTS_TO_DRAW: usize = 16;

    /// `FunctionalTest18_19::verifyXFBData`
    fn verify_xfb_data(
        words: &[u32],
        locations: &ControlFlowLocations,
        bool_operator1_subroutine_location: GLuint,
        bool_operator2_subroutine_location: GLuint,
        vec4_operator1_subroutine_location: GLuint,
        vec4_operator2_subroutine_location: GLuint,
    ) -> bool {
        let epsilon = 1e-5;
        let mut has_test_passed = true;

        let bool_operator1_result = bool_operator1_subroutine_location == locations.returns_true;
        let bool_operator2_result = bool_operator2_subroutine_location == locations.returns_true;
        let operator1: fn([f32; 4]) -> [f32; 4] = if vec4_operator1_subroutine_location == locations.divide_by_two {
            |data| data.map(|v| v * 0.5)
        } else {
            |data| data.map(|v| v * 4.0)
        };
        let operator2: fn([f32; 4]) -> [f32; 4] = if vec4_operator2_subroutine_location == locations.divide_by_two {
            |data| data.map(|v| v * 0.5)
        } else {
            |data| data.map(|v| v * 4.0)
        };

        for n_vertex in 0..Self::N_POINTS_TO_DRAW as u32 {
            let expected_value = if bool_operator1_result {
                let mut value = ((3 * n_vertex + 1) * 2) as f32;

                loop {
                    value /= (n_vertex + 2) as f32;

                    if value <= 1.0 {
                        break;
                    }
                }

                value
            } else {
                let n = n_vertex as f32;
                let mut value = [n, n + 1.0, n + 2.0, n + 3.0];

                match n_vertex % 2 {
                    0 => {
                        let mut iteration = 0;
                        while iteration < n_vertex && bool_operator2_result {
                            value = operator2(operator1(value));
                            iteration += 1;
                        }
                    }
                    _ => {
                        for _ in 0..n_vertex * 2 {
                            value = operator1(operator2(value));
                        }
                    }
                }

                value[0] + value[1] + value[2] + value[3]
            };

            let found = f32::from_bits(words[n_vertex as usize]);

            if (expected_value - found).abs() > epsilon {
                log::info!(
                    "XFBed data was found to be invalid at index [{n_vertex}]for the following subroutine location configuration: bool_operator1_subroutine_location:[{bool_operator1_subroutine_location}] bool_operator2_subroutine_location:[{bool_operator2_subroutine_location}] vec4_operator1_subroutine_location:[{vec4_operator1_subroutine_location}] vec4_operator2_subroutine_location:[{vec4_operator2_subroutine_location}]; expected data:{expected_value}, found:{found}"
                );
                has_test_passed = false;
            }
        }

        has_test_passed
    }

    /// `FunctionalTest18_19::executeTest`
    fn execute_test(
        context: &Context,
        po_id: GLuint,
        locations: &ControlFlowLocations,
        bool_operator1_subroutine_location: GLuint,
        bool_operator2_subroutine_location: GLuint,
        vec4_operator1_subroutine_location: GLuint,
        vec4_operator2_subroutine_location: GLuint,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut subroutine_configuration = [0 as GLuint; 4];

        subroutine_configuration[locations.uniform_bool_operator1 as usize] = bool_operator1_subroutine_location;
        subroutine_configuration[locations.uniform_bool_operator2 as usize] = bool_operator2_subroutine_location;
        subroutine_configuration[locations.uniform_vec4_processor1 as usize] = vec4_operator1_subroutine_location;
        subroutine_configuration[locations.uniform_vec4_processor2 as usize] = vec4_operator2_subroutine_location;

        gl_call!(gl, "glUseProgram() call failed", gl.use_program(po_id));
        gl_call!(
            gl,
            "glUniformSubroutinesuiv() call failed",
            gl.uniform_subroutinesuiv(glw::GL_VERTEX_SHADER, 4, subroutine_configuration.as_ptr())
        );

        let words = draw_points_and_read_xfb(context, Self::N_POINTS_TO_DRAW as glw::GLsizei, Self::N_POINTS_TO_DRAW)?;

        Ok(Self::verify_xfb_data(
            &words,
            locations,
            bool_operator1_subroutine_location,
            bool_operator2_subroutine_location,
            vec4_operator1_subroutine_location,
            vec4_operator2_subroutine_location,
        ))
    }
}

impl TestCase for ControlFlowAndReturnedValues {
    fn name(&self) -> &str {
        "control_flow_and_returned_subroutine_values_used_as_subroutine_input"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut has_test_passed = true;

        check_subroutine_support(context)?;

        let Some(program) = build_program(gl, &[(ShaderStage::Vertex, CONTROL_FLOW_VS)], Some(&["result"]))? else {
            return fail("Failed to build test program object");
        };
        let po_id = program.program;

        let subroutine_index = |name: &str| {
            let name = std::ffi::CString::new(name).expect("names have no NUL");
            // SAFETY: the name is a live NUL-terminated string.
            unsafe { gl.get_subroutine_index(po_id, glw::GL_VERTEX_SHADER, name.as_ptr()) }
        };
        let divide_by_two = subroutine_index("divideByTwo");
        let multiply_by_four = subroutine_index("multiplyByFour");
        let returns_false = subroutine_index("returnsFalse");
        let returns_true = subroutine_index("returnsTrue");
        crate::glu::expect_no_error(gl, "glGetSubroutineIndex() call(s) failed")?;

        if [divide_by_two, multiply_by_four, returns_false, returns_true].contains(&glw::GL_INVALID_INDEX) {
            return fail("glGetSubroutineIndex() returned GL_INVALID_INDEX for a valid subroutine");
        }

        let uniform_location = |name: &str| {
            let name = std::ffi::CString::new(name).expect("names have no NUL");
            // SAFETY: the name is a live NUL-terminated string.
            unsafe { gl.get_subroutine_uniform_location(po_id, glw::GL_VERTEX_SHADER, name.as_ptr()) }
        };
        let locations = ControlFlowLocations {
            divide_by_two,
            returns_true,
            uniform_bool_operator1: uniform_location("bool_operator1"),
            uniform_bool_operator2: uniform_location("bool_operator2"),
            uniform_vec4_processor1: uniform_location("vec4_operator1"),
            uniform_vec4_processor2: uniform_location("vec4_operator2"),
        };
        crate::glu::expect_no_error(gl, "glGetSubroutineUniformLocation() call(s) failed")?;

        if [
            locations.uniform_bool_operator1,
            locations.uniform_bool_operator2,
            locations.uniform_vec4_processor1,
            locations.uniform_vec4_processor2,
        ]
        .contains(&-1)
        {
            return fail("glGetSubroutineUniformLocation() returned -1 for an active subroutine uniform");
        }

        let bo_size = std::mem::size_of::<f32>() * Self::N_POINTS_TO_DRAW;
        let mut xfb_bo = Buffer::new(context);
        let mut vao = VertexArray::new(context);

        xfb_bo.generate()?;
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, xfb_bo.id)
        );
        gl_call!(
            gl,
            "glBindBufferBase() call failed.",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, xfb_bo.id)
        );
        gl_call!(
            gl,
            "glBufferData() call failed.",
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                bo_size as GLsizeiptr,
                std::ptr::null(),
                glw::GL_STATIC_COPY
            )
        );
        vao.generate()?;
        vao.bind()?;

        let subroutine_bool_operators = [returns_false, returns_true];
        let subroutine_vec4_operators = [divide_by_two, multiply_by_four];

        for bool_operator1 in subroutine_bool_operators {
            for bool_operator2 in subroutine_bool_operators {
                for vec4_operator1 in subroutine_vec4_operators {
                    for vec4_operator2 in subroutine_vec4_operators {
                        if !Self::execute_test(
                            context,
                            po_id,
                            &locations,
                            bool_operator1,
                            bool_operator2,
                            vec4_operator1,
                            vec4_operator2,
                        )? {
                            has_test_passed = false;
                        }
                    }
                }
            }
        }

        verdict(has_test_passed)
    }
}
