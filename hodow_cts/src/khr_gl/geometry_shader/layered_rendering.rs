// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderLayeredRendering.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The four-element `m_tests` array is a `Vec<LayeredRenderingTest>` in the same iteration order; `glProgramUniform1i` is the same call.

use std::ffi::CString;

use super::require_geometry_shader;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLboolean, GLenum, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

const EXPECTED_LAYER_DATA: [u8; 6 * 4] = [
    255, 0, 0, 0, 0, 255, 0, 0, 0, 0, 255, 0, 0, 0, 0, 255, 255, 255, 0, 0, 255, 0, 255, 0,
];

const FS_CODE: &str = "${VERSION}\n\nprecision highp float;\n\nflat in  int  layer_id;\n     out vec4 color;\n\nvoid main()\n{\n    switch (layer_id)\n    {\n        case 0:  color = vec4(1, 0, 0, 0); break;\n        case 1:  color = vec4(0, 1, 0, 0); break;\n        case 2:  color = vec4(0, 0, 1, 0); break;\n        case 3:  color = vec4(0, 0, 0, 1); break;\n        case 4:  color = vec4(1, 1, 0, 0); break;\n        case 5:  color = vec4(1, 0, 1, 0); break;\n        default: color = vec4(1, 1, 1, 1); break;\n    }\n}\n";
const GS_CODE_PREAMBLE: &str = "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\n";
const GS_CODE_2D_ARRAY: &str = "#define MAX_VERTICES 64\n#define N_LAYERS     4\n";
const GS_CODE_2D_MARRAY: &str = "#define MAX_VERTICES 64\n#define N_LAYERS     4\n";
const GS_CODE_3D: &str = "#define MAX_VERTICES 64\n#define N_LAYERS     4\n";
const GS_CODE_CM: &str = "#define MAX_VERTICES 96\n#define N_LAYERS     6\n";
const GS_CODE_MAIN: &str = "layout(points)                                    in;\nlayout(triangle_strip, max_vertices=MAX_VERTICES) out;\n\nprecision highp float;\n\nflat out int layer_id;\nuniform  int provoking_vertex_index;\n\nvoid main()\n{\n    for (int n = 0; n < N_LAYERS; ++n)\n    {\n        #ifndef SHOULD_NOT_SET_GL_LAYER\n            if (provoking_vertex_index == 0 || provoking_vertex_index == 1) gl_Layer = n;\n        #endif\n\n        layer_id    = gl_Layer;\n        gl_Position = vec4(1, 1, 0, 1);\n        EmitVertex();\n\n        #ifndef SHOULD_NOT_SET_GL_LAYER\n            if (provoking_vertex_index == 0 || provoking_vertex_index == 1) gl_Layer = n;\n        #endif\n\n        layer_id    = gl_Layer;\n        gl_Position = vec4(1, -1, 0, 1);\n        EmitVertex();\n\n        #ifndef SHOULD_NOT_SET_GL_LAYER\n            if (provoking_vertex_index == 0 || provoking_vertex_index == 2) gl_Layer = n;\n        #endif\n\n        layer_id    = gl_Layer;\n        gl_Position = vec4(-1, 1, 0, 1);\n        EmitVertex();\n\n        #ifndef SHOULD_NOT_SET_GL_LAYER\n            gl_Layer = n;\n        #endif\n\n        layer_id    = gl_Layer;\n        gl_Position = vec4(-1, -1, 0, 1);\n        EmitVertex();\n\n        EndPrimitive();\n    }\n}\n";
const VS_CODE: &str =
    "${VERSION}\n\nprecision highp float;\n\nflat out int layer_id;\nvoid main()\n{\n    layer_id = 0;\n}\n";

const TEXTURE_DEPTH: GLint = 64;
const TEXTURE_HEIGHT: GLint = 32;
const TEXTURE_N_COMPONENTS: usize = 4;
const TEXTURE_WIDTH: GLint = 32;

#[derive(Clone, Copy, PartialEq)]
enum Iteration {
    TwoDArray,
    TwoDMultisampleArray,
    ThreeD,
    CubeMap,
}

#[derive(Default)]
struct LayeredRenderingTest {
    fbo_id: GLuint,
    fs_id: GLuint,
    gs_id: GLuint,
    po_id: GLuint,
    to_id: GLuint,
    vs_id: GLuint,
}

/// `GeometryShaderLayeredRendering`
pub(super) struct LayeredRendering {
    pub ext_params: ExtParameters,
}

#[derive(Default)]
struct Resources {
    tests: Vec<LayeredRenderingTest>,
    vao_id: GLuint,
}

impl LayeredRendering {
    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let is_es = !context.context_type().api.desktop;

        require_geometry_shader(&base)?;

        // Configure test descriptors
        let descriptors: [(Iteration, u32, &str); 4] = [
            (Iteration::TwoDArray, 4, GS_CODE_2D_ARRAY),
            (Iteration::TwoDMultisampleArray, 4, GS_CODE_2D_MARRAY),
            (Iteration::ThreeD, 4, GS_CODE_3D),
            (Iteration::CubeMap, 6, GS_CODE_CM),
        ];
        resources.tests = descriptors.iter().map(|_| LayeredRenderingTest::default()).collect();

        // Create shader objects we'll use for the test
        for test in resources.tests.iter_mut() {
            test.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
            test.gs_id = gl!(gl.create_shader(base.gl_ext_tokens.geometry_shader));
            test.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        }
        glu::expect_no_error(gl, "Could not create shaders!")?;

        // Create program objects as well
        for test in resources.tests.iter_mut() {
            test.po_id = gl!(gl.create_program());
        }
        glu::expect_no_error(gl, "Could not create programs!")?;

        // Build the programs
        let mut all_built = true;
        for (test, (_, _, gs_defines)) in resources.tests.iter().zip(descriptors.iter()) {
            let (built, _) = base.build_program(
                context,
                test.po_id,
                &[
                    ShaderBody::Source(test.fs_id, &[FS_CODE]),
                    ShaderBody::Source(test.gs_id, &[GS_CODE_PREAMBLE, *gs_defines, GS_CODE_MAIN]),
                    ShaderBody::Source(test.vs_id, &[VS_CODE]),
                ],
            )?;
            all_built &= built;
        }
        if !all_built {
            return Err(TestError::Fail(
                "Could not create a program for cube-map texture layered rendering test!".to_string(),
            ));
        }

        // Set up provoking vertex uniform value, given the GL_LAYER_PROVOKING_VERTEX_EXT value.
        let mut layer_provoking_vertex_gl_value: GLint = -1;
        gl!(gl.get_integerv(
            base.gl_ext_tokens.layer_provoking_vertex,
            &mut layer_provoking_vertex_gl_value
        ));
        glu::expect_no_error(gl, "glGetIntegerv() failed for GL_LAYER_PROVOKING_VERTEX_EXT pname")?;

        if !is_es && layer_provoking_vertex_gl_value as GLenum == glw::GL_PROVOKING_VERTEX {
            gl!(gl.get_integerv(glw::GL_PROVOKING_VERTEX, &mut layer_provoking_vertex_gl_value));
            glu::expect_no_error(gl, "glGetIntegerv() failed for GL_PROVOKING_VERTEX pname")?;
        }

        let layer_provoking_vertex_gl_value = layer_provoking_vertex_gl_value as GLenum;
        let layer_provoking_vertex_uniform_value: GLint = if layer_provoking_vertex_gl_value
            == base.gl_ext_tokens.first_vertex_convention
        {
            1
        } else if layer_provoking_vertex_gl_value == base.gl_ext_tokens.last_vertex_convention {
            2
        } else if layer_provoking_vertex_gl_value == base.gl_ext_tokens.undefined_vertex {
            0
        } else {
            return Err(TestError::Fail(
                "Unrecognized value returned by glGetIntegerv() for GL_LAYER_PROVOKING_VERTEX_EXT pname.".to_string(),
            ));
        };

        let uniform_name = CString::new("provoking_vertex_index").unwrap();
        for test in &resources.tests {
            let location = gl!(gl.get_uniform_location(test.po_id, uniform_name.as_ptr()));
            glu::expect_no_error(gl, "glGetUniformLocation() call generated an error")?;
            assert!(location != -1);

            gl!(gl.program_uniform_1i(test.po_id, location, layer_provoking_vertex_uniform_value));
            glu::expect_no_error(gl, "glProgramUniform1i() call failed.")?;
        }

        // Initialize texture objects
        for test in resources.tests.iter_mut() {
            gl!(gl.gen_textures(1, &mut test.to_id));
        }
        glu::expect_no_error(gl, "Could not create texture object(s)!")?;

        gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, resources.tests[3].to_id));
        gl!(gl.tex_storage_2d(
            glw::GL_TEXTURE_CUBE_MAP,
            1,
            glw::GL_RGBA8,
            TEXTURE_WIDTH,
            TEXTURE_HEIGHT
        ));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, resources.tests[0].to_id));
        gl!(gl.tex_storage_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            1,
            glw::GL_RGBA8,
            TEXTURE_WIDTH,
            TEXTURE_HEIGHT,
            TEXTURE_DEPTH
        ));
        gl!(gl.bind_texture(glw::GL_TEXTURE_3D, resources.tests[2].to_id));
        gl!(gl.tex_storage_3d(
            glw::GL_TEXTURE_3D,
            1,
            glw::GL_RGBA8,
            TEXTURE_WIDTH,
            TEXTURE_HEIGHT,
            TEXTURE_DEPTH
        ));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, resources.tests[1].to_id));
        gl!(gl.tex_storage_3d_multisample(
            glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
            1,
            glw::GL_RGBA8,
            TEXTURE_WIDTH,
            TEXTURE_HEIGHT,
            TEXTURE_DEPTH,
            glw::GL_FALSE as GLboolean
        ));
        glu::expect_no_error(gl, "Could not initialize texture object(s)!")?;

        // Initialize framebuffer objects
        for test in resources.tests.iter_mut() {
            gl!(gl.gen_framebuffers(1, &mut test.fbo_id));
        }
        glu::expect_no_error(gl, "Could not create framebuffer object(s)!")?;

        for test in &resources.tests {
            gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, test.fbo_id));
            gl!(gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, test.to_id, 0));
        }
        glu::expect_no_error(gl, "Could not configure framebuffer object(s)!")?;

        // Initialize vertex array object. We don't really use any attributes, but ES does not support drawing without one being bound.
        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Could not bind a vertex array object!")?;

        // Execute all iterations
        for (test, (iteration, n_layers, _)) in resources.tests.iter().zip(descriptors.iter()) {
            let mut buffer = [0u8; TEXTURE_WIDTH as usize * TEXTURE_HEIGHT as usize * TEXTURE_N_COMPONENTS];

            // Bind the iteration-specific framebuffer
            gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, test.fbo_id));

            // Clear the color attachment with (1, 1, 1, 1) which is not used for any of the layers
            gl!(gl.clear_color(1.0, 1.0, 1.0, 1.0));
            gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));

            // Render a single point. This should result in full-screen quads drawn to each layer.
            gl!(gl.use_program(test.po_id));
            gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
            glu::expect_no_error(gl, "Error rendering geometry!")?;

            // Read contents of each layer we rendered to and verify the contents
            for n_layer in 0..*n_layers {
                let expected_data =
                    &EXPECTED_LAYER_DATA[TEXTURE_N_COMPONENTS * n_layer as usize..][..TEXTURE_N_COMPONENTS];

                // What is the source attachment's texture target?
                let (texture_layered, texture_target) = match iteration {
                    Iteration::CubeMap => (
                        false,
                        match n_layer {
                            0 => glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
                            1 => glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
                            2 => glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
                            3 => glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
                            4 => glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
                            _ => glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
                        },
                    ),
                    Iteration::TwoDMultisampleArray => (true, glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY),
                    Iteration::ThreeD => (true, glw::GL_TEXTURE_3D),
                    Iteration::TwoDArray => (true, glw::GL_TEXTURE_2D_ARRAY),
                };

                // Configure the read framebuffer's read buffer, depending on whether the attachment is layered
                if texture_layered {
                    gl!(gl.framebuffer_texture_layer(
                        glw::GL_READ_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        test.to_id,
                        0,
                        n_layer as GLint
                    ));
                } else {
                    gl!(gl.framebuffer_texture_2d(
                        glw::GL_READ_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        texture_target,
                        test.to_id,
                        0
                    ));
                }

                // Make sure read framebuffer was configured successfully
                glu::expect_no_error(gl, "Error setting read framebuffer!")?;

                // Read the data
                if *iteration == Iteration::TwoDMultisampleArray {
                    let mut new_dst_to: GLuint = 0;
                    let mut dst_fbo_id: GLuint = 0;
                    gl!(gl.gen_framebuffers(1, &mut dst_fbo_id));
                    gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, test.fbo_id));
                    gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, dst_fbo_id));

                    gl!(gl.gen_textures(1, &mut new_dst_to));
                    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, new_dst_to));
                    gl!(gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, TEXTURE_WIDTH, TEXTURE_HEIGHT));
                    glu::expect_no_error(
                        gl,
                        "Could not setup texture object for draw framebuffer color attachment.",
                    )?;

                    gl!(gl.framebuffer_texture_2d(
                        glw::GL_DRAW_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        glw::GL_TEXTURE_2D,
                        new_dst_to,
                        0
                    ));
                    glu::expect_no_error(
                        gl,
                        "Could not attach texture object to draw framebuffer color attachment.",
                    )?;

                    gl!(gl.blit_framebuffer(
                        0,
                        0,
                        TEXTURE_WIDTH,
                        TEXTURE_HEIGHT,
                        0,
                        0,
                        TEXTURE_WIDTH,
                        TEXTURE_HEIGHT,
                        glw::GL_COLOR_BUFFER_BIT,
                        glw::GL_LINEAR
                    ));
                    glu::expect_no_error(gl, "Error blitting from read framebuffer to draw framebuffer.")?;

                    gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, dst_fbo_id));
                    gl!(gl.read_pixels(
                        0,
                        0,
                        TEXTURE_WIDTH,
                        TEXTURE_HEIGHT,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        buffer.as_mut_ptr().cast()
                    ));
                    glu::expect_no_error(gl, "Error reading attachment's data!")?;

                    gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, test.fbo_id));
                    gl!(gl.delete_framebuffers(1, &dst_fbo_id));
                    gl!(gl.delete_textures(1, &new_dst_to));
                } else {
                    gl!(gl.read_pixels(
                        0,
                        0,
                        TEXTURE_WIDTH,
                        TEXTURE_HEIGHT,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        buffer.as_mut_ptr().cast()
                    ));
                    glu::expect_no_error(gl, "Error reading attachment's data!")?;
                }

                // Validate it
                for data in buffer.chunks_exact(TEXTURE_N_COMPONENTS) {
                    if data != expected_data {
                        log::info!(
                            "Rendered data [{}, {}, {}, {}] is different from reference data [{}, {}, {}, {}] !",
                            data[0],
                            data[1],
                            data[2],
                            data[3],
                            EXPECTED_LAYER_DATA[0],
                            EXPECTED_LAYER_DATA[1],
                            EXPECTED_LAYER_DATA[2],
                            EXPECTED_LAYER_DATA[3]
                        );
                        return Ok(TestStatus::fail("Fail"));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for LayeredRendering {
    fn name(&self) -> &str {
        "layered_rendering"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        // deinit
        gl!(gl.use_program(0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
        gl!(gl.bind_vertex_array(0));
        for test in &resources.tests {
            if test.po_id != 0 {
                gl!(gl.delete_program(test.po_id));
            }
            for shader in [test.fs_id, test.gs_id, test.vs_id] {
                if shader != 0 {
                    gl!(gl.delete_shader(shader));
                }
            }
            if test.to_id != 0 {
                gl!(gl.delete_textures(1, &test.to_id));
            }
            if test.fbo_id != 0 {
                gl!(gl.delete_framebuffers(1, &test.fbo_id));
            }
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        outcome
    }
}
