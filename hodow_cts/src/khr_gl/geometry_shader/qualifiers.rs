// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderQualifiers.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::CString;

use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

/// `GeometryShaderFlatInterpolationTest`
pub(super) struct FlatInterpolation {
    pub ext_params: ExtParameters,
}

#[derive(Default)]
struct Resources {
    bo_id: GLuint,
    fs_id: GLuint,
    gs_id: GLuint,
    po_id: GLuint,
    vao_id: GLuint,
    vs_id: GLuint,
}

impl FlatInterpolation {
    /// `initProgram`
    fn init_program(context: &Context, base: &TestCaseBase, resources: &mut Resources) -> Result<(), TestError> {
        let gl = context.gl();

        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.gs_id = gl!(gl.create_shader(base.gl_ext_tokens.geometry_shader));
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;

        resources.po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() call failed.")?;

        let fs_code =
            "${VERSION}\n\nprecision highp float;\n\nout vec4 result;\n\nvoid main()\n{\n    result = vec4(1.0);\n}\n";
        let gs_code = "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout(triangles)                in;\nlayout(points, max_vertices = 1) out;\n\nflat in int out_vertex[];\n\nvoid main()\n{\n    if (out_vertex[0] != 0 || out_vertex[1] != 1 || out_vertex[2] != 2)\n    {\n        gl_Position = vec4(0.0);\n    }\n    else\n    {\n        gl_Position = vec4(1.0);\n    }\n    EmitVertex();\n}\n";
        let vs_code = "${VERSION}\n\nflat out int out_vertex;\n\nvoid main()\n{\n    gl_Position = vec4(0.0);\n    out_vertex  = gl_VertexID;\n}\n";

        let po_varying = CString::new("gl_Position").expect("no nul byte");
        let varyings = [po_varying.as_ptr()];
        gl!(gl.transform_feedback_varyings(resources.po_id, 1, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS));
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() call failed.")?;

        let (built, _) = base.build_program(
            context,
            resources.po_id,
            &[
                ShaderBody::Source(resources.gs_id, &[gs_code]),
                ShaderBody::Source(resources.vs_id, &[vs_code]),
                ShaderBody::Source(resources.fs_id, &[fs_code]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail("Could not build test program object".to_string()));
        }
        Ok(())
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let mut result = true;

        // This test should only run if EXT_geometry_shader is supported.
        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }

        // Set up the buffer object
        gl!(gl.gen_buffers(1, &mut resources.bo_id));
        glu::expect_no_error(gl, "glGenBuffers() call failed.")?;
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.bo_id));
        glu::expect_no_error(gl, "glBindBuffer() call failed.")?;
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            (std::mem::size_of::<f32>() * 4) as isize,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "glBufferData() call failed.")?;
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.bo_id));
        glu::expect_no_error(gl, "glBindBufferBase() call failed.")?;

        // Set up the vertex array object
        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        glu::expect_no_error(gl, "glGenVertexArrays() call failed.")?;
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "glBindVertexArray() call failed.")?;

        // Set up the test program
        Self::init_program(context, &base, resources)?;
        gl!(gl.use_program(resources.po_id));
        glu::expect_no_error(gl, "glUseProgram() call failed.")?;

        gl!(gl.begin_transform_feedback(glw::GL_POINTS));
        glu::expect_no_error(gl, "glBeginTransformFeedback() call failed.")?;

        // Draw the input triangle
        gl!(gl.draw_arrays(glw::GL_TRIANGLES, 0, 3));
        glu::expect_no_error(gl, "glDrawArrays() call failed.")?;

        gl!(gl.end_transform_feedback());
        glu::expect_no_error(gl, "glEndTransformFeedback() call failed.")?;

        // Map the BO contents to the process space
        let result_bo_data = gl!(gl.map_buffer_range(
            glw::GL_ARRAY_BUFFER,
            0,
            (std::mem::size_of::<f32>() * 4) as isize,
            glw::GL_MAP_READ_BIT
        ))
        .cast::<f32>();
        glu::expect_no_error(gl, "glMapBufferRange() call failed.")?;
        if result_bo_data.is_null() {
            return Err(TestError::Fail("glMapBufferRange() returned NULL.".to_string()));
        }
        // SAFETY: four floats were mapped for reading and the mapping lives until the unmap below.
        let data = unsafe { std::slice::from_raw_parts(result_bo_data, 4) }.to_vec();

        if data.iter().any(|value| (value - 1.0).abs() >= 1e-5) {
            log::info!("Invalid texel data was retrieved.");
            result = false;
        }

        gl!(gl.unmap_buffer(glw::GL_ARRAY_BUFFER));
        glu::expect_no_error(gl, "glUnmapBuffer() call failed.")?;

        Ok(if result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestCase for FlatInterpolation {
    fn name(&self) -> &str {
        "flat_interpolation"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        // deinit
        if resources.bo_id != 0 {
            gl!(gl.delete_buffers(1, &resources.bo_id));
        }
        if resources.fs_id != 0 {
            gl!(gl.delete_shader(resources.fs_id));
        }
        if resources.gs_id != 0 {
            gl!(gl.delete_shader(resources.gs_id));
        }
        if resources.po_id != 0 {
            gl!(gl.delete_program(resources.po_id));
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        if resources.vs_id != 0 {
            gl!(gl.delete_shader(resources.vs_id));
        }
        outcome
    }
}
