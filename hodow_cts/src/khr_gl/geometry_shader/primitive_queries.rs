// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderPrimitiveQueries.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The three subclasses (points, lines, triangles) are one `PrimitiveQueries` with a `Primitive`.

use std::ffi::CString;

use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

const FS_CODE: &str = "${VERSION}\n\nprecision highp float;\n\nvoid main()\n{\n}\n";
const VS_CODE: &str =
    "${VERSION}\n\nprecision highp float;\n\nvoid main()\n{\n    gl_Position = vec4(gl_VertexID, 0, 0, 1);\n}\n";
const GS_CODE_POINTS: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout(points)                          in;\nlayout(points, max_vertices=8)          out;\n\nvoid main()\n{\n    for (int n = 0; n < 8; ++n)\n    {\n        gl_Position = vec4(1.0 / (float(n) + 1.0), 1.0 / (float(n) + 2.0), 0.0, 1.0);\n        EmitVertex();\n    }\n\n    EndPrimitive();\n}\n";
const GS_CODE_LINES: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout(points)                          in;\nlayout(line_strip, max_vertices=10)     out;\n\nvoid main()\n{\n    for (int n = 0; n < 10; ++n)\n    {\n        gl_Position = vec4(1.0 / (float(n) + 1.0), 1.0 / (float(n) + 2.0), 0.0, 1.0);\n        EmitVertex();\n    }\n\n    EndPrimitive();\n}\n";
const GS_CODE_TRIANGLES: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout(points)                          in;\nlayout(triangle_strip, max_vertices=12) out;\n\nvoid main()\n{\n    for (int n = 0; n < 12; ++n)\n    {\n        gl_Position = vec4(1.0 / (float(n) + 1.0), 1.0 / (float(n) + 2.0), 0.0, 1.0);\n        EmitVertex();\n    }\n\n    EndPrimitive();\n}\n";

const N_TEXTURE_COMPONENTS: usize = 4;

#[derive(Clone, Copy)]
pub(super) enum Primitive {
    Points,
    Lines,
    Triangles,
}

impl Primitive {
    fn geometry_shader_code(self) -> &'static str {
        match self {
            Self::Points => GS_CODE_POINTS,
            Self::Lines => GS_CODE_LINES,
            Self::Triangles => GS_CODE_TRIANGLES,
        }
    }

    /// `getAmountOfEmittedVertices`
    fn amount_of_emitted_vertices(self) -> usize {
        match self {
            Self::Points => 8,
            Self::Lines => 18,
            Self::Triangles => 30,
        }
    }

    /// `getTFMode`
    fn tf_mode(self) -> GLenum {
        match self {
            Self::Points => glw::GL_POINTS,
            Self::Lines => glw::GL_LINES,
            Self::Triangles => glw::GL_TRIANGLES,
        }
    }

    fn name(self) -> &'static str {
        match self {
            Self::Points => "primitive_queries_points",
            Self::Lines => "primitive_queries_lines",
            Self::Triangles => "primitive_queries_triangles",
        }
    }
}

/// `GeometryShaderPrimitiveQueries` and its three subclasses
pub(super) struct PrimitiveQueries {
    pub ext_params: ExtParameters,
    pub primitive: Primitive,
}

#[derive(Default)]
struct Resources {
    bo_large_id: GLuint,
    bo_small_id: GLuint,
    fs_id: GLuint,
    gs_id: GLuint,
    po_id: GLuint,
    qo_primitives_generated_id: GLuint,
    qo_tf_primitives_written_id: GLuint,
    vao_id: GLuint,
    vs_id: GLuint,
}

impl PrimitiveQueries {
    /// `readPrimitiveQueryValues`: draws into `buffer_id` with both queries active and returns (primitives generated, primitives written).
    fn read_primitive_query_values(
        &self,
        context: &Context,
        base: &TestCaseBase,
        resources: &Resources,
        buffer_id: GLuint,
    ) -> Result<(GLuint, GLuint), TestError> {
        let gl = context.gl();

        // Bind the buffer object to hold the captured data.
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, buffer_id));

        // Activate the program object
        gl!(gl.use_program(resources.po_id));
        glu::expect_no_error(gl, "Error using program object")?;

        gl!(gl.begin_transform_feedback(self.primitive.tf_mode()));
        glu::expect_no_error(gl, "Error starting transform feedback")?;

        // Activate the queries
        gl!(gl.begin_query(
            base.gl_ext_tokens.primitives_generated,
            resources.qo_primitives_generated_id
        ));
        glu::expect_no_error(gl, "Error starting GL_PRIMITIVES_GENERATED_EXT query")?;
        gl!(gl.begin_query(
            glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN,
            resources.qo_tf_primitives_written_id
        ));
        glu::expect_no_error(gl, "Error starting GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN query")?;

        // Render
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
        glu::expect_no_error(gl, "Error executing draw call")?;

        gl!(gl.end_transform_feedback());
        glu::expect_no_error(gl, "Error finishing transform feedback")?;

        // Query objects end here.
        gl!(gl.end_query(base.gl_ext_tokens.primitives_generated));
        gl!(gl.end_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN));

        // Retrieve query values
        let mut primitives_generated: GLuint = 0;
        let mut primitives_written: GLuint = 0;
        gl!(gl.get_query_objectuiv(
            resources.qo_primitives_generated_id,
            glw::GL_QUERY_RESULT,
            &mut primitives_generated
        ));
        gl!(gl.get_query_objectuiv(
            resources.qo_tf_primitives_written_id,
            glw::GL_QUERY_RESULT,
            &mut primitives_written
        ));
        glu::expect_no_error(gl, "Error retrieving query values.")?;
        Ok((primitives_generated, primitives_written))
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        // Check if geometry_shader extension is supported
        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }

        // Create shader objects and a program object
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.gs_id = gl!(gl.create_shader(base.gl_ext_tokens.geometry_shader));
        resources.po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "Error creating program/shader objects.")?;

        // Try to build test-specific program object
        let tf_varying = CString::new("gl_Position").expect("no nul byte");
        let tf_varyings = [tf_varying.as_ptr()];
        gl!(gl.transform_feedback_varyings(resources.po_id, 1, tf_varyings.as_ptr(), glw::GL_SEPARATE_ATTRIBS));
        let (built, _) = base.build_program(
            context,
            resources.po_id,
            &[
                ShaderBody::Source(resources.fs_id, &[FS_CODE]),
                ShaderBody::Source(resources.gs_id, &[self.primitive.geometry_shader_code()]),
                ShaderBody::Source(resources.vs_id, &[VS_CODE]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Could not create a program for GeometryShaderPrimitiveQueries!".to_string(),
            ));
        }

        // Create and bind a vertex array object
        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Error creating a vertex array object.")?;

        // Create two buffer objects: one with sufficiently large storage space to hold position data for particular output, another one of insufficient size.
        let emitted = self.primitive.amount_of_emitted_vertices();
        gl!(gl.gen_buffers(1, &mut resources.bo_large_id));
        gl!(gl.gen_buffers(1, &mut resources.bo_small_id));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.bo_large_id));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            (emitted * N_TEXTURE_COMPONENTS * std::mem::size_of::<f32>()) as isize,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.bo_small_id));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            ((emitted / 2) * N_TEXTURE_COMPONENTS * std::mem::size_of::<f32>()) as isize,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "Error allocating buffer objects.")?;

        // Create primitive query objects
        gl!(gl.gen_queries(1, &mut resources.qo_tf_primitives_written_id));
        gl!(gl.gen_queries(1, &mut resources.qo_primitives_generated_id));

        // Test case 13.1
        let (primitives_generated, tf_primitives_written) =
            self.read_primitive_query_values(context, &base, resources, resources.bo_large_id)?;
        if primitives_generated == 0 {
            log::info!("Retrieved GL_PRIMITIVES_GENERATED_EXT query object value is zero which should never happen.");
            return Ok(TestStatus::fail("Fail"));
        }
        if tf_primitives_written == 0 {
            log::info!(
                "Retrieved GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN query object value is zero which should never happen."
            );
            return Ok(TestStatus::fail("Fail"));
        }
        if primitives_generated != tf_primitives_written {
            log::info!(
                "Retrieved GL_PRIMITIVES_GENERATED_EXT query object value({primitives_generated}) is different than for GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN ({tf_primitives_written})"
            );
            return Ok(TestStatus::fail("Fail"));
        }

        // Test case 13.2
        let (primitives_generated, tf_primitives_written) =
            self.read_primitive_query_values(context, &base, resources, resources.bo_small_id)?;
        if primitives_generated == 0 {
            log::info!("Retrieved GL_PRIMITIVES_GENERATED_EXT query object value is zero which should never happen.");
            return Ok(TestStatus::fail("Fail"));
        }
        if tf_primitives_written == 0 {
            log::info!(
                "Retrieved GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN query object value is zero which should never happen."
            );
            return Ok(TestStatus::fail("Fail"));
        }
        if primitives_generated / 2 != tf_primitives_written {
            log::info!(
                "Retrieved GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN query object value({primitives_generated}) should be half the amount of GL_PRIMITIVES_GENERATED_EXT ({tf_primitives_written})"
            );
            return Ok(TestStatus::fail("Fail"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for PrimitiveQueries {
    fn name(&self) -> &str {
        self.primitive.name()
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        // deinit: reset state, then delete what was created
        gl!(gl.use_program(0));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.bind_vertex_array(0));
        if resources.po_id != 0 {
            gl!(gl.delete_program(resources.po_id));
        }
        for shader in [resources.fs_id, resources.gs_id, resources.vs_id] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        for buffer in [resources.bo_small_id, resources.bo_large_id] {
            if buffer != 0 {
                gl!(gl.delete_buffers(1, &buffer));
            }
        }
        for query in [
            resources.qo_primitives_generated_id,
            resources.qo_tf_primitives_written_id,
        ] {
            if query != 0 {
                gl!(gl.delete_queries(1, &query));
            }
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        outcome
    }
}
