// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcBindImageTextureTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the desktop paths are ported (`m_isContextES` is always false in the root that registers this group), so `${PRECISION}` is empty and both the 2D and the 1D texture are tested. The framebuffer, texture, vertex array and buffers are guards released when `iterate` ends or the loop body does.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint};
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

type Res<T> = Result<T, TestError>;

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

/// full screen quad
const FS_QUAD: [f32; 16] = [
    -1.0, -1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
];

/// Vertex shader source code to test non-layered bindings of shader images.
const SHADER_VERT: &str =
    "${VERSION}\n    in vec4 vertex;\n    void main()\n    {\n      gl_Position = vertex;\n    }\n    ";

/// Fragment shader source code to test non-layered bindings of 2D shader images.
const SHADER_FRAG: &str = "${VERSION}\n    ${PRECISION}\n    layout(binding = 0, rgba8) uniform readonly highp image2D img;\n    layout(location = 0) out vec4 color;\n    void main()\n    {\n        color = imageLoad(img, ivec2(0, 0));\n    }\n    ";

/// Fragment shader source code to test non-layered bindings of 1D shader images.
const SHADER_1D_FRAG: &str = "${VERSION}\n    ${PRECISION}\n    layout(binding = 0, rgba8) uniform image1D img;\n    layout(location = 0) out vec4 color;\n    void main(void)\n    {\n        color = imageLoad(img, 0);\n    }\n    ";

fn tex_target_name(target: GLenum) -> &'static str {
    match target {
        glw::GL_TEXTURE_2D => "GL_TEXTURE_2D",
        glw::GL_TEXTURE_1D => "GL_TEXTURE_1D",
        _ => "unknown",
    }
}

/// `drawAndVerify`
fn draw_and_verify(gl: &glw::Functions, tex_target: GLenum) -> Res<bool> {
    let data: [u8; 4] = [128, 128, 128, 128];
    let mut read_data: [u8; 4] = [0, 0, 0, 0];
    let mut ret = true;

    let tex = glu::Texture::new(gl);
    glu::expect_no_error(gl, "genTextures")?;
    gl_call!(gl, "bindTexture", gl.bind_texture(tex_target, tex.get()));
    if tex_target == glw::GL_TEXTURE_2D {
        gl_call!(
            gl,
            "texStorage2D",
            gl.tex_storage_2d(tex_target, 1, glw::GL_RGBA8, 1, 1)
        );
        gl_call!(
            gl,
            "texSubImage2D",
            gl.tex_sub_image_2d(
                tex_target,
                0,
                0,
                0,
                1,
                1,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                data.as_ptr().cast()
            )
        );
    } else {
        gl_call!(gl, "texStorage1D", gl.tex_storage_1d(tex_target, 1, glw::GL_RGBA8, 1));
        gl_call!(
            gl,
            "texSubImage1D",
            gl.tex_sub_image_1d(
                tex_target,
                0,
                0,
                1,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                data.as_ptr().cast()
            )
        );
    }
    gl_call!(
        gl,
        "texParameteri",
        gl.tex_parameteri(tex_target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint)
    );
    gl_call!(
        gl,
        "texParameteri",
        gl.tex_parameteri(tex_target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint)
    );

    let bind_img_params: [(glw::GLboolean, GLint); 4] =
        [(glw::TRUE, 1), (glw::TRUE, 0), (glw::FALSE, 1), (glw::FALSE, 0)];
    for (layered, layer) in bind_img_params {
        gl_call!(
            gl,
            "bindImageTexture",
            gl.bind_image_texture(0, tex.get(), 0, layered, layer, glw::GL_READ_ONLY, glw::GL_RGBA8)
        );
        gl_call!(gl, "clearColor", gl.clear_color(0.0, 0.0, 0.0, 1.0));
        gl_call!(
            gl,
            "clear",
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT)
        );
        gl_call!(gl, "drawArrays", gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        gl_call!(
            gl,
            "readPixels",
            gl.read_pixels(
                0,
                0,
                1,
                1,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                read_data.as_mut_ptr().cast()
            )
        );

        if data != read_data {
            log::info!(
                "BindImageTextureSingleLayerTestCase::drawAndVerify unexpected result :glBindImageTexture( layered: {}, layer: {layer})\n",
                if layered == glw::TRUE { "GL_TRUE" } else { "GL_FALSE" }
            );
            ret = false;
        }
    }

    // Result of comparison of two arrays are returned
    Ok(ret)
}

/// `BindImageTextureSingleLayerTestCase::iterate`
fn single_layer(context: &Context) -> TestOutcome {
    let gl = context.gl();
    let specialization = [
        (
            "VERSION",
            context.context_type().glsl_version().declaration().to_string(),
        ),
        ("PRECISION", String::new()),
    ];
    let textures = [glw::GL_TEXTURE_2D, glw::GL_TEXTURE_1D];
    let mut ret = true;

    // setup fbo along with attached color texture
    let target = glu::Texture::new(gl);
    glu::expect_no_error(gl, "genTextures")?;
    gl_call!(gl, "bindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, target.get()));
    gl_call!(
        gl,
        "texStorage2D",
        gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, 1, 1)
    );
    let fbo = glu::Framebuffer::new(gl);
    glu::expect_no_error(gl, "genFramebuffers")?;
    gl_call!(
        gl,
        "bindFramebuffer",
        gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo.get())
    );
    gl_call!(
        gl,
        "bindFramebuffer",
        gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo.get())
    );
    gl_call!(
        gl,
        "framebufferTexture2D",
        gl.framebuffer_texture_2d(
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            target.get(),
            0
        )
    );

    for tex_target in textures {
        let frag = if tex_target == glw::GL_TEXTURE_2D {
            SHADER_FRAG
        } else {
            SHADER_1D_FRAG
        };
        let vshader = StringTemplate::new(SHADER_VERT).specialize(&specialization)?;
        let fshader = StringTemplate::new(frag).specialize(&specialization)?;
        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vshader, fshader));
        if !program.is_ok() {
            log::info!(
                "Shader build failed.\n{}",
                program.build_failure_summary().unwrap_or_default()
            );
            return Err(TestError::Fail("Compile failed".to_string()));
        }

        // set up rendering resources: setBuffers
        let vao = glu::VertexArray::new(gl);
        glu::expect_no_error(gl, "genVertexArrays")?;
        gl_call!(gl, "bindVertexArray", gl.bind_vertex_array(vao.get()));
        let vbo = glu::Buffer::new(gl);
        glu::expect_no_error(gl, "genBuffers")?;
        gl_call!(gl, "bindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo.get()));
        gl_call!(
            gl,
            "bufferData",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&FS_QUAD) as isize,
                FS_QUAD.as_ptr().cast(),
                glw::GL_DYNAMIC_DRAW
            )
        );
        gl_call!(gl, "useProgram", gl.use_program(program.program()));
        // SAFETY: a linked program and a NUL-terminated name.
        let loc_vertices = unsafe { gl.get_attrib_location(program.program(), c"vertex".as_ptr()) };
        glu::expect_no_error(gl, "getAttribLocation")?;
        if loc_vertices != -1 {
            gl_call!(gl, "enableVertexAttribArray", gl.enable_vertex_attrib_array(0));
            let stride_size = (std::mem::size_of_val(&FS_QUAD) / 4) as i32;
            gl_call!(
                gl,
                "vertexAttribPointer",
                gl.vertex_attrib_pointer(
                    loc_vertices as u32,
                    4,
                    glw::GL_FLOAT,
                    glw::FALSE,
                    stride_size,
                    std::ptr::null()
                )
            );
        }

        if !draw_and_verify(gl, tex_target)? {
            log::info!(
                "BindImageTextureSingleLayerTestCase::iterate failed for target :{}\n",
                tex_target_name(tex_target)
            );
            ret = false;
        }

        // Release resources: releaseBuffers, the program, vao and vbo are dropped with this iteration
        gl_call!(gl, "disableVertexAttribArray", gl.disable_vertex_attrib_array(0));
    }

    Ok(if ret {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

struct BindImageTextureCase;

impl TestCase for BindImageTextureCase {
    fn name(&self) -> &str {
        "single_layer"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        single_layer(context)
    }
}

/// `BindImageTextureTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("bind_image_texture");
    group.add_child(Box::new(BindImageTextureCase) as Box<dyn TestCase>);
    group
}
