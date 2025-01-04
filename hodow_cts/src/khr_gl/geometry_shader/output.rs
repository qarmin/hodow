// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderOutput.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The five classes of the header are one `Output` with a `Kind`; the three rendering ones share `GeometryShaderOutputRenderingBase`'s `initTest`/`iterate`/`deinit`.

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

const FRAGMENT_SHADER_CODE_WHITE_COLOR: &str =
    "${VERSION}\n\nprecision highp float;\n\nout vec4 color;\n\nvoid main()\n{\n    color = vec4(1, 1, 1, 1);\n}\n";
const VERTEX_SHADER_CODE_TWO_VEC4: &str = "${VERSION}\n\nprecision highp float;\n\nout vec4 v1;\nout vec4 v2;\n\nvoid main()\n{\n   v1 = vec4(-0.5, -0.5, 0, 1);\n   v2 = vec4( 0.5,  0.5, 0, 1);\n}\n";
const VERTEX_SHADER_CODE_VEC4_0_0_0_1: &str =
    "${VERSION}\n\nprecision highp float;\n\nvoid main()\n{\n   gl_Position = vec4(0, 0, 0, 1);\n}\n";

const DUPLICATE_OUTPUT_LAYOUT_QUALIFIER_GS: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout(points)                            in;\nlayout(triangle_strip, max_vertices = 60) out;\nlayout(points)                            out;\n\nin vec4 v1[];\nin vec4 v2[];\n\nvoid main()\n{\n    gl_Position = v1[0] + vec4(-0.1, -0.1, 0, 0);\n    EmitVertex();\n    gl_Position = v1[0] + vec4(0.1, -0.1, 0, 0);\n    EmitVertex();\n    gl_Position = v1[0] + vec4(0.1, 0.1, 0, 0);\n    EmitVertex();\n    EndPrimitive();\n\n    gl_Position = v2[0] + vec4(-0.1, -0.1, 0, 0);\n    EmitVertex();\n    gl_Position = v2[0] + vec4(-0.1, 0.1, 0, 0);\n    EmitVertex();\n    gl_Position = v2[0] + vec4(0.1, 0.1, 0, 0);\n    EmitVertex();\n    EndPrimitive();\n}\n";
const DUPLICATE_MAX_VERTICES_LAYOUT_QUALIFIER_GS: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout(points)                            in;\nlayout(triangle_strip, max_vertices = 60) out;\nlayout(max_vertices = 20)                 out;\n\nin vec4 v1[];\nin vec4 v2[];\n\nvoid main()\n{\n    gl_Position = v1[0] + vec4(-0.1, -0.1, 0, 0);\n    EmitVertex();\n    gl_Position = v1[0] + vec4(0.1, -0.1, 0, 0);\n    EmitVertex();\n    gl_Position = v1[0] + vec4(0.1, 0.1, 0, 0);\n    EmitVertex();\n    EndPrimitive();\n\n    gl_Position = v2[0] + vec4(-0.1, -0.1, 0, 0);\n    EmitVertex();\n    gl_Position = v2[0] + vec4(-0.1, 0.1, 0, 0);\n    EmitVertex();\n    gl_Position = v2[0] + vec4(0.1, 0.1, 0, 0);\n    EmitVertex();\n    EndPrimitive();\n}\n";
const IF_VERTEX_EMIT_IS_DONE_AT_END_GS: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout(points)                            in;\nlayout(triangle_strip, max_vertices = 60) out;\n\nin vec4 v1[];\n\nvoid main()\n{\n    gl_Position = vec4(-1, -1, 0, 1);\n    EmitVertex();\n    gl_Position = vec4(-1, 1, 0, 1);\n    EmitVertex();\n    gl_Position = vec4(1, 1, 0, 1);\n    EndPrimitive();\n}\n";
const MISSING_END_PRIMITIVE_CALL_GS: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout(points)                            in;\nlayout(triangle_strip, max_vertices = 60) out;\n\nvoid main()\n{\n    gl_Position = vec4(-1, -1.004, 0, 1);\n    EmitVertex();\n    gl_Position = vec4(-1, 1, 0, 1);\n    EmitVertex();\n    gl_Position = vec4(1.004, 1, 0, 1);\n    EmitVertex();\n}\n";
const MISSING_END_PRIMITIVE_CALL_FOR_SINGLE_PRIMITIVE_GS: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n${GEOMETRY_POINT_SIZE_ENABLE}\n\nlayout(points)                   in;\nlayout(points, max_vertices = 1) out;\n\nvoid main()\n{\n    gl_Position  = vec4(-1, -1, 0, 1);\n    gl_PointSize = 2.0f;\n    EmitVertex();\n}\n";

const TEXTURE_HEIGHT: u32 = 16;
const TEXTURE_PIXEL_SIZE: u32 = 4;
const TEXTURE_WIDTH: u32 = 16;

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    DuplicateOutputLayoutQualifier,
    DuplicateMaxVerticesLayoutQualifier,
    IfVertexEmitIsDoneAtEnd,
    MissingEndPrimitiveCall,
    MissingEndPrimitiveCallForSinglePrimitive,
}

/// `GeometryShaderOutput`'s subclasses
pub(super) struct Output {
    pub ext_params: ExtParameters,
    kind: Kind,
}

#[derive(Default)]
struct Resources {
    program_object_id: GLuint,
    vertex_shader_id: GLuint,
    fragment_shader_id: GLuint,
    geometry_shader_id: GLuint,
    vao_id: GLuint,
    fbo_id: GLuint,
    color_tex_id: GLuint,
}

pub(super) fn create_tests(ext_params: ExtParameters) -> Vec<Box<dyn TestCase>> {
    [
        Kind::DuplicateOutputLayoutQualifier,
        Kind::DuplicateMaxVerticesLayoutQualifier,
        Kind::IfVertexEmitIsDoneAtEnd,
        Kind::MissingEndPrimitiveCall,
        Kind::MissingEndPrimitiveCallForSinglePrimitive,
    ]
    .into_iter()
    .map(|kind| Box::new(Output { ext_params, kind }) as Box<dyn TestCase>)
    .collect()
}

impl Output {
    fn geometry_shader_code(&self) -> &'static str {
        match self.kind {
            Kind::DuplicateOutputLayoutQualifier => DUPLICATE_OUTPUT_LAYOUT_QUALIFIER_GS,
            Kind::DuplicateMaxVerticesLayoutQualifier => DUPLICATE_MAX_VERTICES_LAYOUT_QUALIFIER_GS,
            Kind::IfVertexEmitIsDoneAtEnd => IF_VERTEX_EMIT_IS_DONE_AT_END_GS,
            Kind::MissingEndPrimitiveCall => MISSING_END_PRIMITIVE_CALL_GS,
            Kind::MissingEndPrimitiveCallForSinglePrimitive => MISSING_END_PRIMITIVE_CALL_FOR_SINGLE_PRIMITIVE_GS,
        }
    }

    /// The two `...LayoutQualifierTest::iterate`: the program must not build.
    fn run_invalid_program(&self, context: &Context, base: &TestCaseBase) -> TestOutcome {
        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }

        // Verify the program does not build.
        let result = base.does_program_build(
            context,
            &[FRAGMENT_SHADER_CODE_WHITE_COLOR],
            &[self.geometry_shader_code()],
            &[VERTEX_SHADER_CODE_TWO_VEC4],
        )?;
        if !result {
            Ok(TestStatus::pass("Pass"))
        } else {
            log::info!("Invalid program was linked successfully.");
            Ok(TestStatus::fail("Fail"))
        }
    }

    /// `GeometryShaderOutputRenderingBase::initTest`
    fn init_test(&self, context: &Context, base: &TestCaseBase, resources: &mut Resources) -> Result<(), TestError> {
        let gl = context.gl();
        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }

        // Create shader objects
        resources.fragment_shader_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.geometry_shader_id = gl!(gl.create_shader(base.gl_ext_tokens.geometry_shader));
        resources.vertex_shader_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));

        // Create program object
        resources.program_object_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "Could not create program object")?;

        // Build the program object
        let (built, _) = base.build_program(
            context,
            resources.program_object_id,
            &[
                ShaderBody::Source(resources.fragment_shader_id, &[FRAGMENT_SHADER_CODE_WHITE_COLOR]),
                ShaderBody::Source(resources.geometry_shader_id, &[self.geometry_shader_code()]),
                ShaderBody::Source(resources.vertex_shader_id, &[VERTEX_SHADER_CODE_VEC4_0_0_0_1]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Could not create program from valid vertex/geometry/fragment shader".to_string(),
            ));
        }

        // Set up texture object and a FBO
        gl!(gl.gen_textures(1, &mut resources.color_tex_id));
        gl!(gl.gen_framebuffers(1, &mut resources.fbo_id));
        glu::expect_no_error(gl, "Could not create framebuffer")?;

        if !TestCaseBase::setup_framebuffer_with_texture_as_attachment(
            context,
            resources.fbo_id,
            resources.color_tex_id,
            glw::GL_RGBA8,
            TEXTURE_WIDTH,
            TEXTURE_HEIGHT,
        )? {
            return Err(TestError::Fail("Failed to setup framebuffer".to_string()));
        }

        // Set up a vertex array object
        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        gl!(gl.bind_vertex_array(resources.vao_id));
        if context.context_type().api.desktop {
            gl!(gl.enable(glw::GL_PROGRAM_POINT_SIZE));
        }
        glu::expect_no_error(gl, "Could not create vertex array object")
    }

    /// `verifyResult` of the three rendering cases
    fn verify_result(&self, result_image: &[u8]) -> bool {
        let (width, height, pixel_size) = (TEXTURE_WIDTH, TEXTURE_HEIGHT, TEXTURE_PIXEL_SIZE);
        let compare = |x, y, red, green, blue, alpha| {
            TestCaseBase::compare_pixel(result_image, x, y, width, height, pixel_size, red, green, blue, alpha)
        };

        // Image size
        let (left, right, bottom, top) = (0, width - 1, 0, height - 1);

        match self.kind {
            Kind::IfVertexEmitIsDoneAtEnd => {
                // Check if the data was modified during the rendering process
                for y in 0..height {
                    for x in 0..width {
                        if !compare(x, y, 0, 0, 0, 0) {
                            log::info!("Vertex emitted without a corresponding EmitVertex() call made");
                            return false;
                        }
                    }
                }
                true
            }
            Kind::MissingEndPrimitiveCall => {
                if compare(left, bottom, 255, 255, 255, 255)
                    && compare(left, top, 255, 255, 255, 255)
                    && compare(right, top, 255, 255, 255, 255)
                    && compare(right, bottom, 0, 0, 0, 0)
                {
                    true
                } else {
                    log::info!("EndPrimitive() is not called at the end of geometry shader");
                    false
                }
            }
            Kind::MissingEndPrimitiveCallForSinglePrimitive => {
                if compare(left, bottom, 255, 255, 255, 255)
                    && compare(left, top, 0, 0, 0, 0)
                    && compare(right, top, 0, 0, 0, 0)
                    && compare(right, bottom, 0, 0, 0, 0)
                {
                    true
                } else {
                    log::info!("EndPrimitive() is not done for a single primitive");
                    false
                }
            }
            Kind::DuplicateOutputLayoutQualifier | Kind::DuplicateMaxVerticesLayoutQualifier => {
                unreachable!("not a rendering case")
            }
        }
    }

    /// `GeometryShaderOutputRenderingBase::iterate`
    fn run_rendering(&self, context: &Context, base: &TestCaseBase, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();

        if self.kind == Kind::MissingEndPrimitiveCallForSinglePrimitive && !base.is_geometry_shader_point_size_supported
        {
            return Err(TestError::NotSupported(
                "Geometry shader point size functionality not supported, skipping".to_string(),
            ));
        }

        self.init_test(context, base, resources)?;

        let mut result_image = vec![0u8; (TEXTURE_HEIGHT * TEXTURE_WIDTH * TEXTURE_PIXEL_SIZE) as usize];

        // Render
        gl!(gl.use_program(resources.program_object_id));
        gl!(gl.clear_color(0.0, 0.0, 0.0, 0.0));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        glu::expect_no_error(gl, "Could not clear the color buffer")?;

        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
        glu::expect_no_error(gl, "Call drawArrays() failed")?;

        // Extract image from FBO
        gl!(gl.read_pixels(
            0,
            0,
            TEXTURE_WIDTH as i32,
            TEXTURE_HEIGHT as i32,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            result_image.as_mut_ptr().cast()
        ));
        glu::expect_no_error(gl, "Could not read back pixels from color buffer")?;

        // Run verification
        Ok(if self.verify_result(&result_image) {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestCase for Output {
    fn name(&self) -> &str {
        match self.kind {
            Kind::DuplicateOutputLayoutQualifier => "conflicted_output_primitive",
            Kind::DuplicateMaxVerticesLayoutQualifier => "conflicted_output_vertices_max",
            Kind::IfVertexEmitIsDoneAtEnd => "vertex_emit_at_end",
            Kind::MissingEndPrimitiveCall => "primitive_end_done_at_end",
            Kind::MissingEndPrimitiveCallForSinglePrimitive => "primite_end_done_for_single_primitive",
        }
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);

        if matches!(
            self.kind,
            Kind::DuplicateOutputLayoutQualifier | Kind::DuplicateMaxVerticesLayoutQualifier
        ) {
            return self.run_invalid_program(context, &base);
        }

        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run_rendering(context, &base, &mut resources);

        // deinit: reset state, then delete what was created
        gl!(gl.use_program(0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
        if context.context_type().api.desktop {
            gl!(gl.disable(glw::GL_PROGRAM_POINT_SIZE));
        }
        if resources.program_object_id != 0 {
            gl!(gl.delete_program(resources.program_object_id));
        }
        for shader in [
            resources.fragment_shader_id,
            resources.geometry_shader_id,
            resources.vertex_shader_id,
        ] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        if resources.color_tex_id != 0 {
            gl!(gl.delete_textures(1, &resources.color_tex_id));
        }
        if resources.fbo_id != 0 {
            gl!(gl.delete_framebuffers(1, &resources.fbo_id));
        }
        outcome
    }
}
