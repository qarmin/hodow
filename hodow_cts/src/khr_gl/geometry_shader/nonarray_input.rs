// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderNonarrayInput.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The two printed pixel coordinates of the failure message are `n / 4` and `n % 4` as upstream writes them.

use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, LogType, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

const FS_CODE: &str =
    "${VERSION}\n\nprecision highp float;\n\nout vec4 color;\n\nvoid main()\n{\n    color = vec4(0, 1, 0, 1);\n}\n";
const GS_CODE_PREAMBLE: &str = "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\n";
const GS_CODE_BODY: &str = "layout(points)                         in;\nlayout(triangle_strip, max_vertices=4) out;\n\n#ifndef USE_BLOCK\n    #define V1 v1[0]\n    #define V2 v2[0]\n    #define V3 v3[0]\n\n    in vec4 v1[];\n    in vec4 v2[];\n    in vec4 v3[];\n    \n    #ifdef CORRUPT\n        #define V4 v4\n        in vec4 v4;\n    #else\n        #define V4 v4[0]\n        in vec4 v4[];\n    #endif\n#else\n    in VS_GS\n    {\n        in vec4 v1;\n        in vec4 v2;\n        in vec4 v3;\n        in vec4 v4;\n    #ifdef CORRUPT\n        } interface_block;\n\n        #define V1 interface_block.v1\n        #define V2 interface_block.v2\n        #define V3 interface_block.v3\n        #define V4 interface_block.v4\n    #else\n        } interface_block[];\n\n        #define V1 interface_block[0].v1\n        #define V2 interface_block[0].v2\n        #define V3 interface_block[0].v3\n        #define V4 interface_block[0].v4\n    #endif\n#endif\n\nvoid main()\n{\n    gl_Position = V1;\n    EmitVertex();\n    gl_Position = V2;\n    EmitVertex();\n    gl_Position = V3;\n    EmitVertex();\n    gl_Position = V4;\n    EmitVertex();\n    EndPrimitive();\n}\n";
const VS_CODE_PREAMBLE: &str = "${VERSION}\n\n";
const VS_CODE_BODY: &str = "#ifndef USE_BLOCK\n    #define V1 v1\n    #define V2 v2\n    #define V3 v3\n    #define V4 v4\n\n    out vec4 v1;\n    out vec4 v2;\n    out vec4 v3;\n    out vec4 v4;\n#else\n    ${SHADER_IO_BLOCKS_ENABLE}\n    #define V1 interface_block.v1\n    #define V2 interface_block.v2\n    #define V3 interface_block.v3\n    #define V4 interface_block.v4\n\n    out VS_GS\n    {\n        vec4 v1;\n        vec4 v2;\n        vec4 v3;\n        vec4 v4;\n    } interface_block;\n#endif\n\nvoid main()\n{\n    V1 = vec4(-1, -1, 0, 1);\n    V2 = vec4(-1,  1, 0, 1);\n    V3 = vec4( 1, -1, 0, 1);\n    V4 = vec4( 1,  1, 0, 1);\n}\n";

const TEXTURE_HEIGHT: i32 = 4;
const TEXTURE_WIDTH: i32 = 4;

/// `GeometryShaderNonarrayInputCase`
pub(super) struct NonarrayInput {
    pub ext_params: ExtParameters,
}

#[derive(Default)]
struct Resources {
    fbo_id: GLuint,
    fs: GLuint,
    gs_invalid_non_ib: GLuint,
    gs_invalid_ib: GLuint,
    gs_valid_non_ib: GLuint,
    gs_valid_ib: GLuint,
    po_a_invalid: GLuint,
    po_b_invalid: GLuint,
    po_a_valid: GLuint,
    po_b_valid: GLuint,
    to_id: GLuint,
    vao_id: GLuint,
    vs_valid_ib: GLuint,
    vs_valid_non_ib: GLuint,
}

/// `shaderSourceSpecialized`
fn shader_source_specialized(gl: &glw::Functions, base: &TestCaseBase, shader: GLuint, parts: &[&str]) {
    let merged = base.specialize_shader(parts);
    let pointer = merged.as_ptr().cast::<glw::GLchar>();
    let length = merged.len() as GLint;
    gl!(gl.shader_source(shader, 1, &pointer, &length));
}

fn link_status(gl: &glw::Functions, program: GLuint) -> GLint {
    let mut status = glw::GL_FALSE as GLint;
    gl!(gl.link_program(program));
    gl!(gl.get_programiv(program, glw::GL_LINK_STATUS, &mut status));
    status
}

impl NonarrayInput {
    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        // This test should only run if EXT_geometry_shader is supported. Note that EXT_shader_io_blocks support is implied.
        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }

        // Create program objects
        resources.po_a_invalid = gl!(gl.create_program());
        resources.po_b_invalid = gl!(gl.create_program());

        // Create shader objects
        resources.fs = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.gs_invalid_non_ib = gl!(gl.create_shader(base.gl_ext_tokens.geometry_shader));
        resources.gs_invalid_ib = gl!(gl.create_shader(base.gl_ext_tokens.geometry_shader));
        resources.gs_valid_non_ib = gl!(gl.create_shader(base.gl_ext_tokens.geometry_shader));
        resources.gs_valid_ib = gl!(gl.create_shader(base.gl_ext_tokens.geometry_shader));
        resources.vs_valid_non_ib = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        resources.vs_valid_ib = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));

        shader_source_specialized(gl, &base, resources.fs, &[FS_CODE]);
        shader_source_specialized(
            gl,
            &base,
            resources.gs_invalid_non_ib,
            &[GS_CODE_PREAMBLE, "#define CORRUPT\n", GS_CODE_BODY],
        );
        shader_source_specialized(
            gl,
            &base,
            resources.gs_invalid_ib,
            &[GS_CODE_PREAMBLE, "#define CORRUPT\n#define USE_BLOCK\n", GS_CODE_BODY],
        );
        shader_source_specialized(gl, &base, resources.gs_valid_non_ib, &[GS_CODE_PREAMBLE, GS_CODE_BODY]);
        shader_source_specialized(
            gl,
            &base,
            resources.gs_valid_ib,
            &[GS_CODE_PREAMBLE, "#define USE_BLOCK\n", GS_CODE_BODY],
        );
        shader_source_specialized(gl, &base, resources.vs_valid_non_ib, &[VS_CODE_PREAMBLE, VS_CODE_BODY]);
        shader_source_specialized(
            gl,
            &base,
            resources.vs_valid_ib,
            &[VS_CODE_PREAMBLE, "#define USE_BLOCK\n", VS_CODE_BODY],
        );

        // Create and form invalid programs
        gl!(gl.attach_shader(resources.po_a_invalid, resources.fs));
        gl!(gl.attach_shader(resources.po_a_invalid, resources.gs_invalid_non_ib));
        gl!(gl.attach_shader(resources.po_a_invalid, resources.vs_valid_non_ib));
        gl!(gl.attach_shader(resources.po_b_invalid, resources.fs));
        gl!(gl.attach_shader(resources.po_b_invalid, resources.gs_invalid_ib));
        gl!(gl.attach_shader(resources.po_b_invalid, resources.vs_valid_ib));

        // Try to compile the shaders. Do not check GL_COMPILE_STATUS - we expect a linking failure
        for shader in [
            resources.fs,
            resources.gs_invalid_non_ib,
            resources.gs_invalid_ib,
            resources.vs_valid_non_ib,
            resources.vs_valid_ib,
        ] {
            gl!(gl.compile_shader(shader));
        }

        // Try to link the programs
        if link_status(gl, resources.po_a_invalid) != glw::GL_FALSE as GLint {
            log::info!(
                "Program linked sucessfully although it shouldn't because geometry shaders are not expected to support non-array input attributes."
            );
            return Ok(TestStatus::fail("Fail"));
        }
        if link_status(gl, resources.po_b_invalid) != glw::GL_FALSE as GLint {
            log::info!(
                "Program linked sucessfully although it shouldn't because geometry shaders are not expected to support non-array block input attributes."
            );
            return Ok(TestStatus::fail("Fail"));
        }

        // Release the programs before we continue
        gl!(gl.delete_program(resources.po_a_invalid));
        gl!(gl.delete_program(resources.po_b_invalid));
        resources.po_a_invalid = 0;
        resources.po_b_invalid = 0;

        // Release the invalid geometry shaders
        gl!(gl.delete_shader(resources.gs_invalid_non_ib));
        gl!(gl.delete_shader(resources.gs_invalid_ib));
        resources.gs_invalid_non_ib = 0;
        resources.gs_invalid_ib = 0;

        // Create and form valid programs
        resources.po_a_valid = gl!(gl.create_program());
        resources.po_b_valid = gl!(gl.create_program());

        gl!(gl.attach_shader(resources.po_a_valid, resources.fs));
        gl!(gl.attach_shader(resources.po_a_valid, resources.gs_valid_non_ib));
        gl!(gl.attach_shader(resources.po_a_valid, resources.vs_valid_non_ib));
        gl!(gl.attach_shader(resources.po_b_valid, resources.fs));
        gl!(gl.attach_shader(resources.po_b_valid, resources.gs_valid_ib));
        gl!(gl.attach_shader(resources.po_b_valid, resources.vs_valid_ib));

        gl!(gl.compile_shader(resources.gs_valid_non_ib));
        gl!(gl.compile_shader(resources.gs_valid_ib));

        for shader in [resources.gs_valid_non_ib, resources.gs_valid_ib] {
            let mut compile_status = glw::GL_FALSE as GLint;
            gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut compile_status));
            if compile_status != glw::GL_TRUE as GLint {
                let info_log = base.get_info_log(context, LogType::Shader, shader)?;
                log::info!("Valid geometry shader didn't compile. Error message: {info_log}");
                return Ok(TestStatus::fail("Fail"));
            }
        }

        for program in [resources.po_a_valid, resources.po_b_valid] {
            if link_status(gl, program) != glw::GL_TRUE as GLint {
                let info_log = base.get_info_log(context, LogType::Program, program)?;
                log::info!(
                    "Program failed to link although it was expected to link successfully. Error message: {info_log}"
                );
                return Ok(TestStatus::fail("Fail"));
            }
        }

        // Set up a FBO
        gl!(gl.gen_framebuffers(1, &mut resources.fbo_id));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, resources.fbo_id));
        gl!(gl.gen_textures(1, &mut resources.to_id));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, resources.to_id));
        gl!(gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, TEXTURE_WIDTH, TEXTURE_HEIGHT));
        gl!(gl.framebuffer_texture_2d(
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            resources.to_id,
            0
        ));
        glu::expect_no_error(gl, "Failed to set up a framebuffer object")?;

        gl!(gl.viewport(0, 0, TEXTURE_WIDTH, TEXTURE_HEIGHT));

        // Generate and bind a VAO
        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        gl!(gl.bind_vertex_array(resources.vao_id));

        // Set up clear color
        gl!(gl.clear_color(1.0, 0.0, 0.0, 0.0));

        // Use both program objects and verify they work correctly
        for program in [resources.po_a_valid, resources.po_b_valid] {
            let mut result = vec![0u8; (TEXTURE_WIDTH * TEXTURE_HEIGHT * 4) as usize];

            // Clear the color attachment before we continue
            gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));

            // Render!
            gl!(gl.use_program(program));
            gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
            glu::expect_no_error(gl, "glDrawArrays() call failed")?;

            // Read back the result
            gl!(gl.read_pixels(
                0,
                0,
                TEXTURE_WIDTH,
                TEXTURE_HEIGHT,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                result.as_mut_ptr().cast()
            ));
            glu::expect_no_error(gl, "Could not read back pixels from color attachment 0")?;

            // Verify the result data is correct
            for n in 0..(TEXTURE_WIDTH * TEXTURE_HEIGHT) as usize {
                let pixel = &result[n * 4..n * 4 + 4];
                if pixel != [0, 255, 0, 255] {
                    log::info!(
                        "Pixel data isn't correct. All pixels should have green color. Pixel at: [{}, {}] has color: [{}, {}, {}, {}]",
                        n / 4,
                        n % 4,
                        pixel[0],
                        pixel[1],
                        pixel[2],
                        pixel[3]
                    );
                    return Ok(TestStatus::fail("Fail"));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for NonarrayInput {
    fn name(&self) -> &str {
        "nonarray_input"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        // deinit: reset state, then delete what is left
        gl!(gl.use_program(0));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
        gl!(gl.bind_vertex_array(0));
        for program in [
            resources.po_a_valid,
            resources.po_b_valid,
            resources.po_a_invalid,
            resources.po_b_invalid,
        ] {
            if program != 0 {
                gl!(gl.delete_program(program));
            }
        }
        for shader in [
            resources.fs,
            resources.gs_invalid_ib,
            resources.gs_invalid_non_ib,
            resources.gs_valid_ib,
            resources.gs_valid_non_ib,
            resources.vs_valid_ib,
            resources.vs_valid_non_ib,
        ] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        if resources.to_id != 0 {
            gl!(gl.delete_textures(1, &resources.to_id));
        }
        if resources.fbo_id != 0 {
            gl!(gl.delete_framebuffers(1, &resources.fbo_id));
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        outcome
    }
}
