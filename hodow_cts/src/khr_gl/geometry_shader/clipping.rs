// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderClipping.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The readback is 4x4 RGBA8 as upstream's constants say, and like upstream passes the texture height as the width and the width as the height to glReadPixels (both are 4).

use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

const FS_CODE: &str =
    "${VERSION}\n\nprecision highp float;\n\nout vec4 result;\n\nvoid main()\n{\n    result = vec4(0, 1, 0, 0);\n}\n";
const VS_CODE: &str =
    "${VERSION}\n\nprecision highp float;\n\nvoid main()\n{\n    gl_Position = vec4(-10, -10, -10, 0);\n}\n";
const GS_CODE: &str = "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout(points)                                    in;\nlayout(triangle_strip, max_vertices=4) out;\n\nvoid main()\n{\n\n    gl_Position = vec4(1, 1, 0, 1);\n    EmitVertex();\n\n    gl_Position = vec4(1, -1, 0, 1);\n    EmitVertex();\n\n    gl_Position = vec4(-1, 1, 0, 1);\n    EmitVertex();\n\n    gl_Position = vec4(-1, -1, 0, 1);\n    EmitVertex();\n\n    EndPrimitive();\n}\n";

const TEXTURE_HEIGHT: i32 = 4;
const TEXTURE_WIDTH: i32 = 4;
const TEXTURE_N_LEVELS: i32 = 1;
const TEXTURE_N_COMPONENTS: i32 = 4;

/// `GeometryShaderClipping`
pub(super) struct Clipping {
    pub ext_params: ExtParameters,
}

#[derive(Default)]
struct Resources {
    fbo_id: GLuint,
    fs_id: GLuint,
    gs_id: GLuint,
    po_id: GLuint,
    to_id: GLuint,
    vao_id: GLuint,
    vs_id: GLuint,
}

impl Clipping {
    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let mut buffer = vec![0u8; (TEXTURE_WIDTH * TEXTURE_HEIGHT * TEXTURE_N_COMPONENTS) as usize];
        let reference_color: [u8; 4] = [0, 255, 0, 0];
        let row_size = (TEXTURE_WIDTH * TEXTURE_N_COMPONENTS) as usize;

        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }

        // Create shader objects we'll need
        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.gs_id = gl!(gl.create_shader(base.gl_ext_tokens.geometry_shader));
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        resources.po_id = gl!(gl.create_program());

        let (built, _) = base.build_program(
            context,
            resources.po_id,
            &[
                ShaderBody::Source(resources.fs_id, &[FS_CODE]),
                ShaderBody::Source(resources.gs_id, &[GS_CODE]),
                ShaderBody::Source(resources.vs_id, &[VS_CODE]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Could not create program object from valid vertex/geometry/fragment shaders!".to_string(),
            ));
        }

        // Create and configure texture object we'll be rendering to
        gl!(gl.gen_textures(1, &mut resources.to_id));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, resources.to_id));
        gl!(gl.tex_storage_2d(
            glw::GL_TEXTURE_2D,
            TEXTURE_N_LEVELS,
            glw::GL_RGBA8,
            TEXTURE_WIDTH,
            TEXTURE_HEIGHT
        ));
        glu::expect_no_error(gl, "Error creating texture object!")?;

        // Create and configure the framebuffer object
        gl!(gl.gen_framebuffers(1, &mut resources.fbo_id));
        gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, resources.fbo_id));
        gl!(gl.framebuffer_texture_2d(
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            resources.to_id,
            0
        ));
        glu::expect_no_error(gl, "Error configuring framebuffer object!")?;

        // Create and bind vertex array object
        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Error configuring vertex array object")?;

        // Render
        gl!(gl.viewport(0, 0, TEXTURE_WIDTH, TEXTURE_HEIGHT));
        gl!(gl.use_program(resources.po_id));
        gl!(gl.clear_color(1.0, 0.0, 0.0, 0.0));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
        glu::expect_no_error(gl, "Rendering failed!")?;

        // Read the rendered data
        gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, resources.fbo_id));
        gl!(gl.read_pixels(
            0,
            0,
            TEXTURE_HEIGHT as GLint,
            TEXTURE_WIDTH as GLint,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            buffer.as_mut_ptr().cast()
        ));
        glu::expect_no_error(gl, "Reading pixels failed!")?;

        // Loop over all pixels and compare the rendered data with reference value
        for y in 0..TEXTURE_HEIGHT as usize {
            let data_row = &buffer[y * row_size..(y + 1) * row_size];
            for x in 0..TEXTURE_WIDTH as usize {
                let data = &data_row[x * TEXTURE_N_COMPONENTS as usize..][..4];
                if data != reference_color {
                    log::info!(
                        "Rendered data [{}, {}, {}, {}] is different from reference data [{}, {}, {}, {}] !",
                        data[0],
                        data[1],
                        data[2],
                        data[3],
                        reference_color[0],
                        reference_color[1],
                        reference_color[2],
                        reference_color[3]
                    );
                    return Ok(TestStatus::fail("Fail"));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for Clipping {
    fn name(&self) -> &str {
        "clipping"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        // deinit: reset state, then delete what was created
        gl!(gl.use_program(0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
        gl!(gl.bind_vertex_array(0));
        if resources.po_id != 0 {
            gl!(gl.delete_program(resources.po_id));
        }
        for shader in [resources.fs_id, resources.gs_id, resources.vs_id] {
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
