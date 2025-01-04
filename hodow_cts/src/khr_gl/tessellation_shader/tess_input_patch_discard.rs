// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderTessellation.cpp / .hpp   (TessellationShaderTessellationInputPatchDiscard)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::CString;

use super::utils::{PrimitiveMode, Utils, get_es_token_for_primitive_mode, get_tf_mode_for_primitive_mode};
use super::{TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED, shader_source_specialized};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `TessellationShaderTessellationInputPatchDiscard`
pub(super) struct InputPatchDiscard {
    pub ext_params: ExtParameters,
}

struct RunDescriptor {
    primitive_mode: PrimitiveMode,
    po_id: GLuint,
    tc_id: GLuint,
    te_id: GLuint,
}

#[derive(Default)]
struct Resources {
    bo_id: GLuint,
    fs_id: GLuint,
    vs_id: GLuint,
    vao_id: GLuint,
    runs: Vec<RunDescriptor>,
}

const FS_BODY: &str = "${VERSION}\n\nvoid main()\n{\n}\n";
const VS_BODY: &str = "${VERSION}\n\nvoid main()\n{\n    gl_Position = vec4(1.0, 0.0, 0.0, 1.0);\n}\n";
const TC_CODE: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout(vertices = 2) out;\n\nout int tc_primitive_id[];\n\nvoid main()\n{\n    if ((gl_PrimitiveID % 4) == 0)\n    {\n        gl_TessLevelOuter[0] = 0.0;\n        gl_TessLevelOuter[1] = 0.0;\n        gl_TessLevelOuter[2] = 0.0;\n        gl_TessLevelOuter[3] = 0.0;\n    }\n    else\n    if ((gl_PrimitiveID % 4) == 2)\n    {\n        gl_TessLevelOuter[0] = -1.0;\n        gl_TessLevelOuter[1] = -1.0;\n        gl_TessLevelOuter[2] = -1.0;\n        gl_TessLevelOuter[3] = -1.0;\n    }\n    else\n    {\n        gl_TessLevelOuter[0] = 1.0;\n        gl_TessLevelOuter[1] = 1.0;\n        gl_TessLevelOuter[2] = 1.0;\n        gl_TessLevelOuter[3] = 1.0;\n    }\n\n    gl_TessLevelInner[0]                           = 1.0;\n    gl_TessLevelInner[1]                           = 1.0;\n    gl_out           [gl_InvocationID].gl_Position = gl_in[0].gl_Position;\n    tc_primitive_id  [gl_InvocationID]             = gl_PrimitiveID;\n}\n";
const TE_CODE: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout(PRIMITIVE_MODE) in;\n\nin  int   tc_primitive_id   [];\nout ivec2 te_tc_primitive_id;\nout int   te_primitive_id;\n\nvoid main()\n{\n    te_tc_primitive_id[0] = tc_primitive_id[0];\n    te_tc_primitive_id[1] = tc_primitive_id[1];\n    te_primitive_id       = gl_PrimitiveID;\n}\n";

impl InputPatchDiscard {
    /// `initRun`
    fn init_run(
        &self,
        context: &Context,
        base: &TestCaseBase,
        utils: &Utils<'_>,
        fs_id: GLuint,
        vs_id: GLuint,
        primitive_mode: PrimitiveMode,
        run: &mut RunDescriptor,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let tokens = base.gl_ext_tokens;

        run.primitive_mode = primitive_mode;

        run.po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed")?;

        run.tc_id = gl!(gl.create_shader(tokens.tess_control_shader));
        run.te_id = gl!(gl.create_shader(tokens.tess_evaluation_shader));
        glu::expect_no_error(gl, "glCreateShader() call(s) failed")?;

        shader_source_specialized(gl, base, run.tc_id, TC_CODE);
        glu::expect_no_error(gl, "glShaderSource() failed for tessellation control shader")?;

        let te_body = TE_CODE.replace("PRIMITIVE_MODE", get_es_token_for_primitive_mode(primitive_mode));
        shader_source_specialized(gl, base, run.te_id, &te_body);
        glu::expect_no_error(gl, "glShaderSource() failed for tessellation evaluation shader")?;

        utils.compile_shaders(&[run.tc_id, run.te_id], true)?;

        gl!(gl.attach_shader(run.po_id, fs_id));
        gl!(gl.attach_shader(run.po_id, run.tc_id));
        gl!(gl.attach_shader(run.po_id, run.te_id));
        gl!(gl.attach_shader(run.po_id, vs_id));
        glu::expect_no_error(gl, "glAttachShader() failed")?;

        let names = [
            CString::new("te_tc_primitive_id").expect("no nul byte"),
            CString::new("te_primitive_id").expect("no nul byte"),
        ];
        let varyings = [names[0].as_ptr(), names[1].as_ptr()];
        gl!(gl.transform_feedback_varyings(run.po_id, 2, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS));
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() failed")?;

        let mut link_status = glw::GL_FALSE as GLint;
        gl!(gl.link_program(run.po_id));
        glu::expect_no_error(gl, "glLinkProgram() failed")?;
        gl!(gl.get_programiv(run.po_id, glw::GL_LINK_STATUS, &mut link_status));
        glu::expect_no_error(gl, "glGetProgramiv() failed")?;
        if link_status != glw::GL_TRUE as GLint {
            return Err(TestError::Fail("Program linking failed".to_string()));
        }
        Ok(())
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        if !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        // initTest
        let utils = Utils::new(context, &base)?;

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        glu::expect_no_error(gl, "Could not generate vertex array object")?;
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Error binding vertex array object!")?;

        gl!(gl.gen_buffers(1, &mut resources.bo_id));
        glu::expect_no_error(gl, "glGenBuffers() failed")?;

        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateShader() failed")?;

        shader_source_specialized(gl, &base, resources.fs_id, FS_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for fragment shader")?;
        shader_source_specialized(gl, &base, resources.vs_id, VS_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for vertex shader")?;

        utils.compile_shaders(&[resources.fs_id, resources.vs_id], true)?;

        for primitive_mode in [PrimitiveMode::Isolines, PrimitiveMode::Quads, PrimitiveMode::Triangles] {
            let mut run = RunDescriptor {
                primitive_mode,
                po_id: 0,
                tc_id: 0,
                te_id: 0,
            };
            let result = self.init_run(
                context,
                &base,
                &utils,
                resources.fs_id,
                resources.vs_id,
                primitive_mode,
                &mut run,
            );
            resources.runs.push(run);
            result?;
        }

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, resources.bo_id));
        glu::expect_no_error(gl, "glBindBuffer() failed")?;
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.bo_id));
        glu::expect_no_error(gl, "glBindBufferBase() failed")?;

        // No rasterization is needed.
        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glEnable(GL_RASTERIZER_DISCARD) failed.")?;

        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 1));
        glu::expect_no_error(gl, "glPatchParameteriEXT() failed for GL_PATCH_VERTICES_EXT pname")?;

        for run in &resources.runs {
            // Each input patch generates 1 ivec2 and 1 int if it is an odd patch, and 0 bytes otherwise. For 'quads' 6 vertices are used instead of 4, as the quad is broken down to two triangles later in the pipeline.
            let n_total_primitives = 4;
            let n_vertices_per_patch = match run.primitive_mode {
                PrimitiveMode::Isolines => 2,
                PrimitiveMode::Quads => 6,
                PrimitiveMode::Triangles => 3,
            };
            let n_bytes_per_result_vertex = std::mem::size_of::<i32>() + 2 * std::mem::size_of::<i32>();
            let n_bytes_needed = (n_total_primitives / 2) * n_vertices_per_patch * n_bytes_per_result_vertex;
            gl!(gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                n_bytes_needed as isize,
                std::ptr::null(),
                glw::GL_STATIC_DRAW
            ));
            glu::expect_no_error(gl, "glBufferData() failed")?;

            gl!(gl.use_program(run.po_id));
            glu::expect_no_error(gl, "glUseProgram() failed")?;

            let tf_mode = get_tf_mode_for_primitive_mode(run.primitive_mode, false);
            gl!(gl.begin_transform_feedback(tf_mode));
            glu::expect_no_error(gl, "glBeginTransformFeedback() failed.")?;

            gl!(gl.draw_arrays(base.gl_ext_tokens.patches, 0, n_total_primitives as i32));
            glu::expect_no_error(gl, "glDrawArrays() failed")?;

            gl!(gl.end_transform_feedback());
            glu::expect_no_error(gl, "glEndTransformFeedback() failed")?;

            let mapped = gl!(gl.map_buffer_range(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                0,
                n_bytes_needed as isize,
                glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT
            ));
            glu::expect_no_error(gl, "glMapBufferRange() call failed")?;
            if mapped.is_null() {
                return Err(TestError::Fail("glMapBufferRange() returned NULL.".to_string()));
            }
            // SAFETY: `n_bytes_needed` bytes were mapped for reading and writing; the mapping lives until the unmap below.
            let result_data = unsafe { std::slice::from_raw_parts_mut(mapped.cast::<i32>(), n_bytes_needed / 4) };

            // Both TC and TE operate on the same primitive IDs; with this configuration the tessellator generates its coordinates for the second and the fourth input primitive only.
            let expected_primitive_ids = [1, 3];
            let n_expected_repetitions = n_vertices_per_patch;
            let mut traveller = 0;
            for (n_primitive_id, &expected_primitive_id) in expected_primitive_ids.iter().enumerate() {
                for _n_repetition in 0..n_expected_repetitions {
                    for n_integer in 0..3 {
                        if result_data[traveller] != expected_primitive_id {
                            log::info!(
                                "For primitive mode: {} invalid gl_PrimitiveID of value {} was found instead of expected {expected_primitive_id} at index:{}",
                                get_es_token_for_primitive_mode(run.primitive_mode),
                                result_data[traveller],
                                n_primitive_id * 3 + n_integer
                            );
                            return Err(TestError::Fail("Discard mechanism failed".to_string()));
                        }
                        traveller += 1;
                    }
                }
            }

            result_data.fill(0);
            gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
            glu::expect_no_error(gl, "glUnmapBuffer() call failed")?;
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for InputPatchDiscard {
    fn name(&self) -> &str {
        "input_patch_discard"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        let base = TestCaseBase::init(context, self.ext_params);
        if !base.is_tessellation_shader_supported {
            return outcome;
        }

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0));
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 3));
        gl!(gl.bind_vertex_array(0));
        if resources.bo_id != 0 {
            gl!(gl.delete_buffers(1, &resources.bo_id));
        }
        for shader in [resources.fs_id, resources.vs_id] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        for run in &resources.runs {
            if run.po_id != 0 {
                gl!(gl.delete_program(run.po_id));
            }
            for shader in [run.tc_id, run.te_id] {
                if shader != 0 {
                    gl!(gl.delete_shader(shader));
                }
            }
        }
        outcome
    }
}
