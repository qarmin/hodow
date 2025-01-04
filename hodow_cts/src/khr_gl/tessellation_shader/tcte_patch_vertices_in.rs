// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderTCTE.cpp / .hpp   (TessellationShaderTCTEgl_PatchVerticesIn)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::CString;

use super::utils::TestType;
use super::{TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED, shader_source_specialized};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `TessellationShaderTCTEgl_PatchVerticesIn`
pub(super) struct GlPatchVerticesIn {
    pub ext_params: ExtParameters,
}

/// `_test_descriptor`
struct TestDescriptor {
    test_type: TestType,
    fs_id: GLuint,
    po_id: GLuint,
    tcs_id: GLuint,
    tes_id: GLuint,
    vs_id: GLuint,
    input_patch_size: u32,
}

#[derive(Default)]
struct Resources {
    bo_id: GLuint,
    vao_id: GLuint,
    tests: Vec<TestDescriptor>,
}

const FS_BODY: &str = "${VERSION}\n\nvoid main()\n{\n}\n";
const TC_BODY: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (vertices = VERTICES_TOKEN) out;\n\nvoid main()\n{\n    gl_out           [gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n    gl_TessLevelOuter[0]                           = 1.0;\n    gl_TessLevelOuter[1]                           = 1.0;\n}\n";
const TE_BODY: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout (isolines, point_mode) in;\n\nflat out int result_PatchVerticesIn;\n\nvoid main()\n{\n    gl_Position = gl_in[0].gl_Position;\n\n    result_PatchVerticesIn = gl_PatchVerticesIn;\n}\n";
const VS_BODY: &str = "${VERSION}\n\nvoid main()\n{\n    gl_Position = vec4(float(gl_VertexID), 2.0, 3.0, 4.0);\n}\n";

impl GlPatchVerticesIn {
    /// `initTestDescriptor`
    fn init_test_descriptor(
        &self,
        context: &Context,
        base: &TestCaseBase,
        test_type: TestType,
        input_patch_size: u32,
    ) -> Result<TestDescriptor, TestError> {
        let gl = context.gl();
        let tokens = base.gl_ext_tokens;

        let mut test = TestDescriptor {
            test_type,
            fs_id: 0,
            po_id: 0,
            tcs_id: 0,
            tes_id: 0,
            vs_id: 0,
            input_patch_size,
        };

        test.po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed")?;

        test.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        test.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        test.tes_id = gl!(gl.create_shader(tokens.tess_evaluation_shader));
        if test_type == TestType::TcsTes {
            test.tcs_id = gl!(gl.create_shader(tokens.tess_control_shader));
        }
        glu::expect_no_error(gl, "glCreateShader() failed")?;

        match self.configure_test_descriptor(context, base, &test) {
            Ok(()) => Ok(test),
            Err(error) => {
                Self::release_descriptor(gl, &mut test);
                Err(error)
            }
        }
    }

    fn configure_test_descriptor(
        &self,
        context: &Context,
        base: &TestCaseBase,
        test: &TestDescriptor,
    ) -> Result<(), TestError> {
        let gl = context.gl();

        shader_source_specialized(gl, base, test.fs_id, FS_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for fragment shader object")?;

        if test.test_type == TestType::TcsTes {
            let tc_body = TC_BODY.replace("VERTICES_TOKEN", &test.input_patch_size.to_string());
            shader_source_specialized(gl, base, test.tcs_id, &tc_body);
            glu::expect_no_error(gl, "glShaderSource() failed for tessellation control shader object")?;
        }

        shader_source_specialized(gl, base, test.tes_id, TE_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for tessellation evaluation shader object")?;

        shader_source_specialized(gl, base, test.vs_id, VS_BODY);
        glu::expect_no_error(gl, "glShaderSource() failed for vertex shader object")?;

        for (n_shader, shader) in [test.fs_id, test.tcs_id, test.tes_id, test.vs_id]
            .into_iter()
            .enumerate()
        {
            if shader != 0 {
                let mut compile_status = glw::GL_FALSE as GLint;
                gl!(gl.compile_shader(shader));
                glu::expect_no_error(gl, "glCompileShader() call failed")?;
                gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut compile_status));
                glu::expect_no_error(gl, "glGetShaderiv() call failed")?;
                if compile_status != glw::GL_TRUE as GLint {
                    log::info!("Compilation of shader object at index {n_shader} failed.");
                    return Err(TestError::Fail("Shader compilation failed".to_string()));
                }
            }
        }

        let varying = CString::new("result_PatchVerticesIn").expect("no nul byte");
        let varyings = [varying.as_ptr()];
        gl!(gl.transform_feedback_varyings(test.po_id, 1, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS));
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() call failed")?;

        gl!(gl.attach_shader(test.po_id, test.fs_id));
        gl!(gl.attach_shader(test.po_id, test.vs_id));
        if test.tcs_id != 0 {
            gl!(gl.attach_shader(test.po_id, test.tcs_id));
        }
        if test.tes_id != 0 {
            gl!(gl.attach_shader(test.po_id, test.tes_id));
        }
        glu::expect_no_error(gl, "glAttachShader() call(s) failed.")?;

        let mut link_status = glw::GL_FALSE as GLint;
        gl!(gl.link_program(test.po_id));
        glu::expect_no_error(gl, "glLinkProgram() call failed.")?;
        gl!(gl.get_programiv(test.po_id, glw::GL_LINK_STATUS, &mut link_status));
        glu::expect_no_error(gl, "glGetProgramiv() call failed.")?;
        if link_status != glw::GL_TRUE as GLint {
            return Err(TestError::Fail("Program linking failed".to_string()));
        }
        Ok(())
    }

    /// `deinitTestDescriptor`
    fn release_descriptor(gl: &glw::Functions, test: &mut TestDescriptor) {
        if test.fs_id != 0 {
            gl!(gl.delete_shader(test.fs_id));
            test.fs_id = 0;
        }
        if test.po_id != 0 {
            gl!(gl.delete_program(test.po_id));
            test.po_id = 0;
        }
        for shader in [&mut test.tcs_id, &mut test.tes_id, &mut test.vs_id] {
            if *shader != 0 {
                gl!(gl.delete_shader(*shader));
                *shader = 0;
            }
        }
    }

    /// `initTest`
    fn init_test(&self, context: &Context, base: &TestCaseBase, resources: &mut Resources) -> Result<(), TestError> {
        let gl = context.gl();

        if !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        glu::expect_no_error(gl, "Could not generate vertex array object")?;
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Error binding vertex array object!")?;

        let mut gl_max_patch_vertices_value: GLint = 0;
        gl!(gl.get_integerv(base.gl_ext_tokens.max_patch_vertices, &mut gl_max_patch_vertices_value));
        glu::expect_no_error(gl, "glGetIntegerv() for GL_MAX_PATCH_VERTICES_EXT pname failed")?;

        // Multiples of 4, since isolines need a multiple of 4 vertices per patch to generate the requested amount of line segments.
        let mut n_half_max_patch_vertices_mul_4 = gl_max_patch_vertices_value / 2;
        let mut n_max_patch_vertices_mul_4 = gl_max_patch_vertices_value;
        if n_half_max_patch_vertices_mul_4 % 4 != 0 {
            n_half_max_patch_vertices_mul_4 += 4 - (gl_max_patch_vertices_value / 2) % 4;
        }
        if n_max_patch_vertices_mul_4 % 4 != 0 {
            n_max_patch_vertices_mul_4 -= gl_max_patch_vertices_value % 4;
        }

        let sizes = [
            4,
            n_half_max_patch_vertices_mul_4 as u32,
            n_max_patch_vertices_mul_4 as u32,
        ];
        for size in sizes {
            let test = self.init_test_descriptor(context, base, TestType::TcsTes, size)?;
            resources.tests.push(test);
        }
        if context.context_type().api.desktop {
            for size in sizes {
                let test = self.init_test_descriptor(context, base, TestType::Tes, size)?;
                resources.tests.push(test);
            }
        }

        gl!(gl.gen_buffers(1, &mut resources.bo_id));
        glu::expect_no_error(gl, "glGenBuffers() call failed")?;
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, resources.bo_id));
        glu::expect_no_error(gl, "glBindBuffer() call failed")?;
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.bo_id));
        glu::expect_no_error(gl, "glBindBufferBase() call failed")
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        self.init_test(context, &base, resources)?;

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glEnable(GL_RASTERIZER_DISCARD) call failed.")?;

        for test in &resources.tests {
            gl!(gl.use_program(test.po_id));
            glu::expect_no_error(gl, "glUseProgram() call failed")?;

            let n_patch_vertices = match test.test_type {
                TestType::TcsTes => {
                    // Isolines need at least 4 input vertices per patch.
                    gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 4));
                    glu::expect_no_error(gl, "glPatchParameteriEXT() for GL_PATCH_VERTICES_EXT failed.")?;
                    4
                }
                TestType::Tes => {
                    gl!(gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, test.input_patch_size as GLint));
                    glu::expect_no_error(gl, "glPatchParameteriEXT() call failed")?;
                    test.input_patch_size as GLint
                }
            };

            // The tessellator outputs two vertices.
            let n_bytes_needed = std::mem::size_of::<i32>() * 2;
            gl!(gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                n_bytes_needed as isize,
                std::ptr::null(),
                glw::GL_STATIC_DRAW
            ));
            glu::expect_no_error(gl, "glBufferData() call failed")?;

            gl!(gl.begin_transform_feedback(glw::GL_POINTS));
            glu::expect_no_error(gl, "glBeginTransformFeedback() call failed")?;

            gl!(gl.draw_arrays(base.gl_ext_tokens.patches, 0, n_patch_vertices));
            glu::expect_no_error(gl, "glDrawArrays() call failed")?;

            gl!(gl.end_transform_feedback());
            glu::expect_no_error(gl, "glEndTransformFeedback() call failed")?;

            let mapped = gl!(gl.map_buffer_range(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                0,
                n_bytes_needed as isize,
                glw::GL_MAP_READ_BIT
            ));
            glu::expect_no_error(gl, "glMapBufferRange() call failed.")?;
            if mapped.is_null() {
                return Err(TestError::Fail("glMapBufferRange() returned NULL.".to_string()));
            }
            // SAFETY: two ints were mapped for reading; the copy ends before the unmap below.
            let mapped_data = unsafe { std::slice::from_raw_parts(mapped.cast::<i32>(), 2) }.to_vec();

            gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
            glu::expect_no_error(gl, "glUnmapBuffer() call failed.")?;

            for (n_vertex, &value) in mapped_data.iter().enumerate() {
                let te_patch_vertices_in_size = value as u32;
                if te_patch_vertices_in_size != test.input_patch_size {
                    log::info!(
                        "Invalid gl_PatchVerticesIn defined for TE stage  and result vertex index:{n_vertex} expected:{} rendered:{te_patch_vertices_in_size}",
                        test.input_patch_size
                    );
                    return Err(TestError::Fail(
                        "Invalid gl_PatchVerticesIn size used in TE stage".to_string(),
                    ));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for GlPatchVerticesIn {
    fn name(&self) -> &str {
        "gl_PatchVerticesIn"
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
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        for test in &mut resources.tests {
            Self::release_descriptor(gl, test);
        }
        outcome
    }
}
