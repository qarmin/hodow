// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderLayeredRenderingFBONoAttachment.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLboolean, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

const FS_CODE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout(rgba32i, binding = 0) writeonly uniform highp iimage2DArray array_image;\n\n     in  vec2 uv;\nflat in  int  layer_id;\nout vec4 color;\n\nvoid main()\n{\n    imageStore(array_image, ivec3( int(128.0 * uv.x), int(128.0 * uv.y), layer_id ), ivec4(0, 255, 0, 0) );\n}\n";
const GS_CODE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout(points)                          in;\nlayout(triangle_strip, max_vertices=16) out;\n\n     out vec2 uv;\nflat out int  layer_id;\n\nvoid main()\n{\n    for (int n = 0; n < 4; ++n)\n    {\n        gl_Position = vec4(1, -1, 0, 1);\n        gl_Layer    = n;\n        layer_id    = n;\n        uv          = vec2(1, 0);\n        EmitVertex();\n\n        gl_Position = vec4(1,  1, 0, 1);\n        gl_Layer    = n;\n        layer_id    = n;\n        uv          = vec2(1, 1);\n        EmitVertex();\n\n        gl_Position = vec4(-1, -1, 0, 1);\n        gl_Layer    = n;\n        layer_id    = n;\n        uv          = vec2(0, 0);\n        EmitVertex();\n\n        gl_Position = vec4(-1,  1, 0, 1);\n        gl_Layer    = n;\n        layer_id    = n;\n        uv          = vec2(0, 1);\n        EmitVertex();\n\n        EndPrimitive();\n    }\n}\n";
const VS_CODE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nvoid main()\n{\n}\n";

const HEIGHT: GLint = 128;
const WIDTH: GLint = 128;
const N_LAYERS: GLint = 4;
const N_TEXTURE_COMPONENTS: usize = 4;

/// `GeometryShaderLayeredRenderingFBONoAttachment`
pub(super) struct LayeredRenderingFboNoAttachment {
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

impl LayeredRenderingFboNoAttachment {
    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }
        if !base.is_framebuffer_no_attachments_supported {
            return Err(TestError::NotSupported(
                "framebuffer_no_attachment, is not supported".to_string(),
            ));
        }
        if !base.is_shader_image_load_store_supported {
            return Err(TestError::NotSupported(
                "shader_image_load_store, is not supported".to_string(),
            ));
        }

        // Generate and bind a framebuffer object
        gl!(gl.gen_framebuffers(1, &mut resources.fbo_id));
        gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, resources.fbo_id));

        // Get the default number of layers of a newly created framebuffer object
        let mut n_layers: GLint = -1;
        gl!(gl.get_framebuffer_parameteriv(
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_FRAMEBUFFER_DEFAULT_LAYERS,
            &mut n_layers
        ));
        glu::expect_no_error(
            gl,
            "Could not query a framebuffer object for the number of default layers!",
        )?;

        // check 14.2 test condition - if default number of layer equals 0
        if n_layers != 0 {
            log::info!("Number of default layers should be equal to 0 but is {n_layers}");
            return Ok(TestStatus::fail("Fail"));
        }

        // Set the default resolution to 128x128
        let mut width: GLint = 0;
        let mut height: GLint = 0;
        gl!(gl.framebuffer_parameteri(glw::GL_DRAW_FRAMEBUFFER, glw::GL_FRAMEBUFFER_DEFAULT_WIDTH, WIDTH));
        glu::expect_no_error(gl, "Could not set the default framebuffer's width!")?;
        gl!(gl.get_framebuffer_parameteriv(glw::GL_DRAW_FRAMEBUFFER, glw::GL_FRAMEBUFFER_DEFAULT_WIDTH, &mut width));
        glu::expect_no_error(gl, "Could not get the default framebuffer's width!")?;
        gl!(gl.framebuffer_parameteri(glw::GL_DRAW_FRAMEBUFFER, glw::GL_FRAMEBUFFER_DEFAULT_HEIGHT, HEIGHT));
        glu::expect_no_error(gl, "Could not set the default framebuffer's height!")?;
        gl!(gl.get_framebuffer_parameteriv(
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_FRAMEBUFFER_DEFAULT_HEIGHT,
            &mut height
        ));
        glu::expect_no_error(gl, "Could not get the default framebuffer's height!")?;

        if WIDTH != width || HEIGHT != height {
            log::info!("Framebuffer's default width/height is not equal to{WIDTH}\\{HEIGHT} but is {width}\\{height}");
            return Ok(TestStatus::fail("Fail"));
        }

        // Configure program object to be used for functional part of the test
        resources.po_id = gl!(gl.create_program());
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        resources.gs_id = gl!(gl.create_shader(base.gl_ext_tokens.geometry_shader));
        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));

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
                "Could not create program object from a valid vertex/geometry/fragment shader code!".to_string(),
            ));
        }

        // Configure texture objects and fill them with initial data
        let pixels = (N_LAYERS * WIDTH * HEIGHT) as usize;
        let mut all_layers_data = vec![0 as GLint; pixels * N_TEXTURE_COMPONENTS];
        for n in 0..pixels {
            all_layers_data[n * N_TEXTURE_COMPONENTS] = 255;
        }

        gl!(gl.gen_textures(1, &mut resources.to_id));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, resources.to_id));
        gl!(gl.tex_storage_3d(glw::GL_TEXTURE_2D_ARRAY, 1, glw::GL_RGBA32I, WIDTH, HEIGHT, N_LAYERS));
        gl!(gl.tex_parameterf(
            glw::GL_TEXTURE_2D_ARRAY,
            glw::GL_TEXTURE_MAG_FILTER,
            glw::GL_NEAREST as f32
        ));
        gl!(gl.tex_parameterf(
            glw::GL_TEXTURE_2D_ARRAY,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST as f32
        ));
        glu::expect_no_error(gl, "Error creating texture objects!")?;

        // Activate the test program object
        gl!(gl.use_program(resources.po_id));
        glu::expect_no_error(gl, "Could not use program!")?;

        // Bind texture to image unit
        gl!(gl.bind_image_texture(
            0,
            resources.to_id,
            0,
            glw::GL_TRUE as GLboolean,
            0,
            glw::GL_WRITE_ONLY,
            glw::GL_RGBA32I
        ));
        glu::expect_no_error(gl, "Could not bind texture to image unit!")?;

        // Generate & bind a VAO
        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Could not create a vertex array object!")?;

        // Set up the viewport
        gl!(gl.viewport(0, 0, WIDTH, HEIGHT));
        glu::expect_no_error(gl, "glViewport() call failed.")?;

        // Test 21.4 runs the test twice: with the default layer count set to 4 and then to 0
        let mut test_failed = false;
        let mut layer_data = vec![0 as GLint; (WIDTH * HEIGHT) as usize * N_TEXTURE_COMPONENTS];

        let mut n_test_iteration = 0;
        while n_test_iteration < 2 && !test_failed {
            let current_n_layers = if n_test_iteration == 1 { 0 } else { N_LAYERS };

            // Reset render-target contents
            gl!(gl.tex_sub_image_3d(
                glw::GL_TEXTURE_2D_ARRAY,
                0,
                0,
                0,
                0,
                WIDTH,
                HEIGHT,
                N_LAYERS,
                glw::GL_RGBA_INTEGER,
                glw::GL_INT,
                all_layers_data.as_ptr().cast()
            ));
            glu::expect_no_error(gl, "glTexSubImage3D() call failed.")?;

            // Set the default number of layers to m_n_layers
            gl!(gl.framebuffer_parameteri(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_FRAMEBUFFER_DEFAULT_LAYERS,
                current_n_layers
            ));
            glu::expect_no_error(
                gl,
                "Could not set the default number of layers of a framebuffer object!",
            )?;

            gl!(gl.get_framebuffer_parameteriv(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_FRAMEBUFFER_DEFAULT_LAYERS,
                &mut n_layers
            ));

            // check if the reported value equals m_n_layers
            if current_n_layers != n_layers {
                log::info!("FBO's default layers should be equal to {N_LAYERS}but is {n_layers}");
                return Ok(TestStatus::fail("Fail"));
            }

            // Render!
            gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
            glu::expect_no_error(gl, "Could not execute a draw call!")?;

            // Verify result texture data
            gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, resources.fbo_id));

            let mut n_layer = 0;
            while n_layer < N_LAYERS && !test_failed {
                gl!(gl.framebuffer_texture_layer(
                    glw::GL_READ_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    resources.to_id,
                    0,
                    n_layer
                ));
                glu::expect_no_error(gl, "Could not bind texture as color attachment to framebuffer!")?;

                if gl!(gl.check_framebuffer_status(glw::GL_READ_FRAMEBUFFER)) != glw::GL_FRAMEBUFFER_COMPLETE {
                    return Err(TestError::Fail("Read framebuffer is not complete!".to_string()));
                }

                gl!(gl.memory_barrier(glw::GL_FRAMEBUFFER_BARRIER_BIT));
                gl!(gl.read_pixels(
                    0,
                    0,
                    WIDTH,
                    HEIGHT,
                    glw::GL_RGBA_INTEGER,
                    glw::GL_INT,
                    layer_data.as_mut_ptr().cast()
                ));
                glu::expect_no_error(
                    gl,
                    "Could not read back pixels from the texture bound to color attachment!",
                )?;

                // Perform the verification
                let reference_color: [GLint; 4] = [0, 255, 0, 0];
                for (n_px, pixel) in layer_data.chunks_exact(N_TEXTURE_COMPONENTS).enumerate() {
                    if pixel != reference_color {
                        log::info!(
                            "The test failed: Pixel {n_px} from layer {n_layer} is set to [{},{},{},{}] but should be equal to [{},{},{},{},]",
                            pixel[0],
                            pixel[1],
                            pixel[2],
                            pixel[3],
                            reference_color[0],
                            reference_color[1],
                            reference_color[2],
                            reference_color[3]
                        );
                        test_failed = true;
                        break;
                    }
                }
                n_layer += 1;
            }

            // Restore the FBO to no-attachment state for the next iteration
            gl!(gl.framebuffer_texture_layer(glw::GL_READ_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, 0, 0, 0));
            n_test_iteration += 1;
        }

        Ok(if test_failed {
            TestStatus::fail("Fail")
        } else {
            TestStatus::pass("Pass")
        })
    }
}

impl TestCase for LayeredRenderingFboNoAttachment {
    fn name(&self) -> &str {
        "layered_rendering_fbo_no_attachment"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        // deinit
        gl!(gl.use_program(0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, 0));
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
