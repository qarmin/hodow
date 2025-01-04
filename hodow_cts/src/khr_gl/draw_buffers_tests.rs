// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl3cDrawBuffers.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Every framebuffer attachment in this case is a renderbuffer, so `applyFBO`'s texture branches are not carried over, and the legacy `gl_FragColor` branch of `setupProgram` is dropped (the contexts here are core profiles).

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const MAX_ATTACHMENTS: usize = 16;

/// full screen quad
const QUAD: [f32; 16] = [
    -1.0, -1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
];

const EXPECTED_RESULTS: [[u8; 4]; 8] = [
    [255, 255, 255, 255],
    [127, 127, 127, 127],
    [255, 255, 255, 255],
    [255, 255, 255, 255],
    [255, 255, 255, 255],
    [255, 255, 255, 255],
    [255, 255, 255, 255],
    [255, 255, 255, 255],
];

/// Vertex shader source code to test vectors DrawBuffers functionality.
const VERT_SHADER_SRC: &str = "${VERSION}\n\
    in vec4 vertex;\n\
    void main (void)\n\
    {\n\
    \x20   gl_Position = vertex;\n\
    }\n";

/// Fragment shader source code to test vectors DrawBuffers functionality.
const FRAG_SHADER_SRC: &str = "${VERSION}\n\
    ${EXTENSION}\n\
    ${ATTACHMENTS}\n\
    void main (void)\n\
    {\n\
    ${OUTPUT}\n\
    }\n";

/// `GL3RBO`
#[derive(Clone, Copy, Default)]
struct Rbo {
    object: GLuint,
}

/// `GL3FBO`, whose attachments are always renderbuffers `GL_COLOR_ATTACHMENT0 + i`.
struct Fbo {
    object: GLuint,
}

struct DrawBuffersTestCase;

impl DrawBuffersTestCase {
    /// `setupProgram`
    fn setup_program<'gl>(context: &'gl Context, num_attachments: GLint) -> Result<ShaderProgram<'gl>, TestError> {
        let gl = context.gl();
        let glsl_version = context.context_type().glsl_version();
        let exp_ext_supported = context
            .context_info
            .is_extension_supported("GL_ARB_explicit_attrib_location");

        let mut extension = String::new();

        let (attachments, output) = if context.context_type().supports_core(3, 3) || exp_ext_supported {
            if exp_ext_supported {
                extension = "#extension GL_ARB_explicit_attrib_location : enable".to_string();
            }

            let mut attachments_src = String::new();
            let mut output_src = String::new();
            for i in 0..num_attachments {
                attachments_src.push_str(&format!("layout(location = {i}) out vec4 fragColor{i};\n"));
                output_src.push_str(&format!("        fragColor{i} = vec4(1.0, 1.0, 1.0, 1.0);\n"));
            }
            (attachments_src, output_src)
        } else {
            (
                "out vec4 fragColor;".to_string(),
                "        fragColor = vec4(1.0, 1.0, 1.0, 1.0);\n".to_string(),
            )
        };

        let specialization = [
            ("VERSION", glsl_version.declaration().to_string()),
            ("EXTENSION", extension),
            ("ATTACHMENTS", attachments),
            ("OUTPUT", output),
        ];

        // Building basic program.
        let vert_shader = StringTemplate::new(VERT_SHADER_SRC).specialize(&specialization)?;
        let frag_shader = StringTemplate::new(FRAG_SHADER_SRC).specialize(&specialization)?;
        let program = ShaderProgram::new(
            gl,
            &ProgramSources::vtx_frag(vert_shader.as_str(), frag_shader.as_str()),
        );
        if !program.is_ok() {
            log::warn!(
                "Shader build failed.\n{}\nVertex:\n{vert_shader}\nFragment:\n{frag_shader}",
                program.build_failure_summary().unwrap_or_default()
            );
            return Err(TestError::Fail("Invalid program".to_string()));
        }

        Ok(program)
    }

    /// `checkResults`
    fn check_results(gl: &glw::Functions, db: GLint, check_none: bool) -> Result<bool, TestError> {
        let mut ret = true;

        for i in 0..db {
            let mut readcolor = [0u8; 4];

            let mut ca: GLint = 0;
            gl_call!(
                gl,
                "getIntegerv",
                gl.get_integerv(glw::GL_DRAW_BUFFER0 + i as u32, &mut ca)
            );

            if ca == glw::GL_NONE as GLint {
                if check_none {
                    ca = (glw::GL_COLOR_ATTACHMENT0 + i as u32) as GLint;
                } else {
                    continue;
                }
            }

            gl_call!(gl, "readBuffer", gl.read_buffer(ca as GLenum));
            gl_call!(
                gl,
                "readPixels",
                gl.read_pixels(
                    2,
                    2,
                    1,
                    1,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    readcolor.as_mut_ptr().cast()
                )
            );

            for j in 0..4 {
                if (i32::from(readcolor[j]) - i32::from(EXPECTED_RESULTS[i as usize % 8][j])).abs() > 1 {
                    ret = false;
                    log::warn!(
                        "DrawBuffersTestCase::checkResults: Color attachment {i}, component {j}: {} != {}",
                        readcolor[j],
                        EXPECTED_RESULTS[i as usize % 8][j]
                    );
                }
            }
        }

        Ok(ret)
    }

    /// `applyFBO`
    fn apply_fbo(gl: &glw::Functions, fbo: &mut Fbo, rbos: &[Rbo]) -> Result<bool, TestError> {
        gl_call!(gl, "genRenderbuffers", gl.gen_framebuffers(1, &mut fbo.object));
        gl_call!(
            gl,
            "genRenderbuffers",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.object)
        );

        // Attach renderbuffers.
        for (i, rbo) in rbos.iter().enumerate().take(MAX_ATTACHMENTS) {
            if rbo.object != 0 {
                gl_call!(
                    gl,
                    "framebufferRenderbuffer",
                    gl.framebuffer_renderbuffer(
                        glw::GL_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0 + i as u32,
                        glw::GL_RENDERBUFFER,
                        rbo.object
                    )
                );
            }
        }

        // Check FBO completeness.
        // SAFETY: a plain query on the framebuffer bound above.
        let framebuffer_status = unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) };
        glu::expect_no_error(gl, "checkFramebufferStatus")?;

        if framebuffer_status != glw::GL_FRAMEBUFFER_COMPLETE {
            log::warn!("Framebuffer status is {framebuffer_status:#06x}.");
            return Ok(false);
        }

        Ok(true)
    }

    /// `setupBuffers`
    fn setup_buffers(
        gl: &glw::Functions,
        max_col_att: GLint,
        rbos: &mut Vec<Rbo>,
        fbo: &mut Fbo,
    ) -> Result<bool, TestError> {
        // Create CA renderbuffers.
        for _ in 0..max_col_att.min(MAX_ATTACHMENTS as GLint) {
            let mut rbo = Rbo::default();
            gl_call!(gl, "genRenderbuffers", gl.gen_renderbuffers(1, &mut rbo.object));
            gl_call!(
                gl,
                "bindRenderbuffer",
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo.object)
            );
            gl_call!(
                gl,
                "renderbufferStorage",
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, 4, 4)
            );
            rbos.push(rbo);
        }

        // Setup and bind an FBO with these renderbuffers attached.
        Self::apply_fbo(gl, fbo, rbos)
    }

    /// `deleteBuffers`
    fn delete_buffers(gl: &glw::Functions, rbos: &[Rbo], fbo: &Fbo) -> Result<(), TestError> {
        gl_call!(gl, "deleteFramebuffers", gl.delete_framebuffers(1, &fbo.object));
        gl_call!(gl, "bindFramebuffer", gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));

        for rbo in rbos {
            gl_call!(gl, "deleteRenderbuffers", gl.delete_renderbuffers(1, &rbo.object));
            gl_call!(gl, "bindRenderbuffer", gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0));
        }
        Ok(())
    }
}

impl TestCase for DrawBuffersTestCase {
    fn name(&self) -> &str {
        "draw_buffers_1"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut fbo = Fbo { object: 0 };
        let mut rbos: Vec<Rbo> = Vec::new();

        gl_call!(gl, "viewport", gl.viewport(0, 0, 4, 4));

        let mut max_drawbuffers: GLint = 0;
        let mut max_color_attachments: GLint = 0;
        gl_call!(
            gl,
            "getIntegerv",
            gl.get_integerv(glw::GL_MAX_DRAW_BUFFERS, &mut max_drawbuffers)
        );
        gl_call!(
            gl,
            "getIntegerv",
            gl.get_integerv(glw::GL_MAX_COLOR_ATTACHMENTS, &mut max_color_attachments)
        );

        if max_drawbuffers <= 0 || max_color_attachments <= 0 {
            return Ok(TestStatus::fail("Fail"));
        }

        if max_drawbuffers < 2 || max_color_attachments < 2 {
            return Err(TestError::NotSupported("Not supported".to_string()));
        }

        max_drawbuffers = max_drawbuffers.min(8);
        let num_attachments = max_drawbuffers.min(max_color_attachments);

        let program = Self::setup_program(context, num_attachments)?;

        if !Self::setup_buffers(gl, max_color_attachments, &mut rbos, &mut fbo)? {
            return Ok(TestStatus::fail("Fail"));
        }

        let mut drawbuffers = [0 as GLenum; MAX_ATTACHMENTS];
        for i in 0..max_drawbuffers as usize {
            drawbuffers[i] = glw::GL_COLOR_ATTACHMENT0 + i as u32;
            if drawbuffers[i] >= glw::GL_COLOR_ATTACHMENT0 + max_color_attachments as u32 {
                drawbuffers[i] = glw::GL_NONE;
            }
        }

        gl_call!(
            gl,
            "drawBuffers",
            gl.draw_buffers(max_drawbuffers, drawbuffers.as_ptr())
        );

        let clrv = 0.502f32;
        gl_call!(gl, "clearColor", gl.clear_color(clrv, clrv, clrv, clrv));
        gl_call!(gl, "clear", gl.clear(glw::GL_COLOR_BUFFER_BIT));

        // Setup DrawBuffers(maxDrawbuffers, buffers) where buffers[i] = COLOR_ATTACHMENT0 + i for i = { 0, 2..maxDrawbuffers-1 } and buffers[1] = NONE
        drawbuffers[1] = glw::GL_NONE;
        gl_call!(
            gl,
            "drawBuffers",
            gl.draw_buffers(max_drawbuffers, drawbuffers.as_ptr())
        );

        // Draw a triangle covering some reasonable fraction of the color buffer
        let mut vao: GLuint = 0;
        let mut vbo: GLuint = 0;
        gl_call!(gl, "genVertexArrays", gl.gen_vertex_arrays(1, &mut vao));
        gl_call!(gl, "bindVertexArray", gl.bind_vertex_array(vao));
        gl_call!(gl, "genBuffers", gl.gen_buffers(1, &mut vbo));
        gl_call!(gl, "bindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo));
        gl_call!(
            gl,
            "bufferData",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(&QUAD) as isize,
                QUAD.as_ptr().cast(),
                glw::GL_DYNAMIC_DRAW
            )
        );

        gl_call!(gl, "useProgram", gl.use_program(program.program()));
        // SAFETY: a NUL-terminated name and a program that was just built.
        let loc_vertices = unsafe { gl.get_attrib_location(program.program(), c"vertex".as_ptr()) };
        glu::expect_no_error(gl, "getAttribLocation")?;
        if loc_vertices != -1 {
            gl_call!(
                gl,
                "vertexAttribPointer",
                gl.vertex_attrib_pointer(loc_vertices as u32, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null())
            );
            gl_call!(
                gl,
                "enableVertexAttribArray",
                gl.enable_vertex_attrib_array(loc_vertices as u32)
            );
        }

        gl_call!(gl, "drawArrays", gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        let result = Self::check_results(gl, max_drawbuffers.min(max_color_attachments), true)?;

        Self::delete_buffers(gl, &rbos, &fbo)?;

        gl_call!(gl, "deleteBuffers", gl.delete_buffers(1, &vbo));
        gl_call!(gl, "deleteVertexArrays", gl.delete_vertex_arrays(1, &vao));

        Ok(if result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `DrawBuffersTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("draw_buffers");
    group.add_child(Box::new(DrawBuffersTestCase) as Box<dyn TestCase>);
    group
}
