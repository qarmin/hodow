// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderLayeredFramebuffer.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The four test classes (Blending, Clear, Depth, Stencil) are one struct with a `Kind`; the per-class deinit is the single cleanup of `Resources`. The Clear test keeps its slice data as raw bytes (char, int and uint variants) instead of three typed arrays.

use super::require_geometry_shader;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

const BOILERPLATE_VS_CODE: &str =
    "${VERSION}\n\nprecision highp float;\n\nvoid main()\n{\n    gl_Position = vec4(gl_VertexID, 0, 0, 1);\n}\n";

const BLENDING_FS_CODE: &str =
    "${VERSION}\n\nprecision highp float;\n\nout vec4 result;\n\nvoid main()\n{\n    result = vec4(0.2);\n}\n";
const BLENDING_GS_CODE: &str = "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout(points)                          in;\nlayout(triangle_strip, max_vertices=64) out;\n\nvoid main()\n{\n    for (int n = 0; n < 4; ++n)\n    {\n        gl_Layer    = n;\n        gl_Position = vec4(1, 1, 0, 1);\n        EmitVertex();\n\n        gl_Layer    = n;\n        gl_Position = vec4(1, -1, 0, 1);\n        EmitVertex();\n\n        gl_Layer    = n;\n        gl_Position = vec4(-1, 1, 0, 1);\n        EmitVertex();\n\n        gl_Layer    = n;\n        gl_Position = vec4(-1, -1, 0, 1);\n        EmitVertex();\n\n        EndPrimitive();\n    }\n}\n";
const DEPTH_FS_CODE: &str =
    "${VERSION}\n\nprecision highp float;\n\nout vec4 result;\n\nvoid main()\n{\n    result = vec4(1.0);\n}\n";
const DEPTH_GS_CODE: &str = "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nlayout(points)                          in;\nlayout(triangle_strip, max_vertices=64) out;\n\nvoid main()\n{\n    for (int n = 0; n < 4; ++n)\n    {\n        float depth = -1.0 + float(n) * 0.5;\n\n        gl_Layer    = n;\n        gl_Position = vec4(1, 1, depth, 1);\n        EmitVertex();\n\n        gl_Layer    = n;\n        gl_Position = vec4(1, -1, depth, 1);\n        EmitVertex();\n\n        gl_Layer    = n;\n        gl_Position = vec4(-1, 1, depth, 1);\n        EmitVertex();\n\n        gl_Layer    = n;\n        gl_Position = vec4(-1, -1, depth, 1);\n        EmitVertex();\n\n        EndPrimitive();\n    }\n}\n";
const STENCIL_FS_CODE: &str =
    "${VERSION}\n\nprecision highp float;\n\nout vec4 result;\n\nvoid main()\n{\n    result = vec4(1, 1, 1, 1);\n}\n";
const STENCIL_GS_CODE: &str = "${VERSION}\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout (points)                            in;\nlayout (triangle_strip, max_vertices = 16) out;\n\nvoid main()\n{\n    for (int n = 0; n < 4; ++n)\n    {\n        gl_Position = vec4(1, -1, 0, 1);\n        gl_Layer    = n;\n        EmitVertex();\n\n        gl_Position = vec4(1,  1, 0, 1);\n        gl_Layer    = n;\n        EmitVertex();\n\n        gl_Position = vec4(-1, -1, 0, 1);\n        gl_Layer    = n;\n        EmitVertex();\n\n        gl_Position = vec4(-1,  1, 0, 1);\n        gl_Layer    = n;\n        EmitVertex();\n\n        EndPrimitive();\n    }\n\n}\n";

const N_TEXTURE_COMPONENTS: usize = 4;
const TEXTURE_DEPTH: GLint = 4;
const TEXTURE_HEIGHT: GLint = 4;
const TEXTURE_WIDTH: GLint = 4;
const STENCIL_TEXTURE_WIDTH: GLint = 8;
const EPSILON: i32 = 1;

#[derive(Clone, Copy, PartialEq)]
pub(super) enum Kind {
    Blending,
    Clear,
    Depth,
    Stencil,
}

/// The `GeometryShaderLayeredFramebuffer*` classes
pub(super) struct LayeredFramebuffer {
    pub ext_params: ExtParameters,
    pub kind: Kind,
}

#[derive(Default)]
struct Resources {
    fbo_ids: Vec<GLuint>,
    to_ids: Vec<GLuint>,
    shader_ids: Vec<GLuint>,
    po_id: GLuint,
    vao_id: GLuint,
}

fn build_test_program(
    base: &TestCaseBase,
    context: &Context,
    resources: &mut Resources,
    fs_code: &str,
    gs_code: &str,
    error_message: &str,
) -> Result<(), TestError> {
    let gl = context.gl();
    let fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
    let gs_id = gl!(gl.create_shader(base.gl_ext_tokens.geometry_shader));
    let vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
    resources.shader_ids.extend([fs_id, gs_id, vs_id]);
    glu::expect_no_error(gl, "Could not generate shader objects")?;

    resources.po_id = gl!(gl.create_program());
    let (built, _) = base.build_program(
        context,
        resources.po_id,
        &[
            ShaderBody::Source(fs_id, &[fs_code]),
            ShaderBody::Source(gs_id, &[gs_code]),
            ShaderBody::Source(vs_id, &[BOILERPLATE_VS_CODE]),
        ],
    )?;
    if !built {
        return Err(TestError::Fail(error_message.to_string()));
    }
    Ok(())
}

fn gen_texture(gl: &glw::Functions, resources: &mut Resources) -> GLuint {
    let mut to_id = 0;
    gl!(gl.gen_textures(1, &mut to_id));
    resources.to_ids.push(to_id);
    to_id
}

fn gen_framebuffer(gl: &glw::Functions, resources: &mut Resources) -> GLuint {
    let mut fbo_id = 0;
    gl!(gl.gen_framebuffers(1, &mut fbo_id));
    resources.fbo_ids.push(fbo_id);
    fbo_id
}

fn gen_vertex_array(gl: &glw::Functions, resources: &mut Resources) {
    gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
    gl!(gl.bind_vertex_array(resources.vao_id));
}

impl LayeredFramebuffer {
    fn blending(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let pixels = (TEXTURE_WIDTH * TEXTURE_HEIGHT) as usize;

        require_geometry_shader(&base)?;

        build_test_program(
            &base,
            context,
            resources,
            BLENDING_FS_CODE,
            BLENDING_GS_CODE,
            "Could not build program object",
        )?;

        // Prepare texture data we will use for each slice
        let mut buffer_slices = [
            vec![0u8; pixels * N_TEXTURE_COMPONENTS],
            vec![0u8; pixels * N_TEXTURE_COMPONENTS],
            vec![0u8; pixels * N_TEXTURE_COMPONENTS],
            vec![0u8; pixels * N_TEXTURE_COMPONENTS],
        ];
        for n in 0..pixels {
            for (n_slice, slice) in buffer_slices.iter_mut().enumerate() {
                let n_slice = n_slice as u32;
                slice[n * N_TEXTURE_COMPONENTS] = 0;
                slice[n * N_TEXTURE_COMPONENTS + 1] = (n_slice * 255 / 4) as u8;
                slice[n * N_TEXTURE_COMPONENTS + 2] = (n_slice * 255 / 8) as u8;
                slice[n * N_TEXTURE_COMPONENTS + 3] = (n_slice * 255 / 12) as u8;
            }
        }

        // Calculate reference texture data we will later use when verifying the rendered data
        let mut ref_buffer_slices = [
            vec![0u8; pixels * N_TEXTURE_COMPONENTS],
            vec![0u8; pixels * N_TEXTURE_COMPONENTS],
            vec![0u8; pixels * N_TEXTURE_COMPONENTS],
            vec![0u8; pixels * N_TEXTURE_COMPONENTS],
        ];
        for n in 0..pixels {
            for (n_slice, ref_slice) in ref_buffer_slices.iter_mut().enumerate() {
                let slice = &buffer_slices[n_slice];
                for n_component in 0..N_TEXTURE_COMPONENTS {
                    let component = slice[n * N_TEXTURE_COMPONENTS + n_component] as f32 / 255.0;
                    let temp_component = (component * component + 0.8 * 0.2).clamp(0.0, 1.0);
                    ref_slice[n * N_TEXTURE_COMPONENTS + n_component] = (temp_component * 255.0) as u8;
                }
            }
        }

        // Set up texture object used for the test
        let to_id = gen_texture(gl, resources);
        gl!(gl.bind_texture(glw::GL_TEXTURE_3D, to_id));
        gl!(gl.tex_storage_3d(
            glw::GL_TEXTURE_3D,
            1,
            glw::GL_RGBA8,
            TEXTURE_WIDTH,
            TEXTURE_HEIGHT,
            TEXTURE_DEPTH
        ));
        for (n_slice, slice) in buffer_slices.iter().enumerate() {
            gl!(gl.tex_sub_image_3d(
                glw::GL_TEXTURE_3D,
                0,
                0,
                0,
                n_slice as GLint,
                TEXTURE_WIDTH,
                TEXTURE_HEIGHT,
                1,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                slice.as_ptr().cast()
            ));
        }
        glu::expect_no_error(gl, "Could not set up texture object")?;

        // Set up framebuffer object used for the test
        let fbo_id = gen_framebuffer(gl, resources);
        gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo_id));
        gl!(gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, to_id, 0));
        glu::expect_no_error(gl, "Could not set up draw framebuffer")?;

        // Generate and bind a vertex array object
        gen_vertex_array(gl, resources);
        glu::expect_no_error(gl, "Could not set up vertex array object")?;

        // Set up blending
        gl!(gl.blend_func(glw::GL_ONE_MINUS_SRC_COLOR, glw::GL_DST_COLOR));
        gl!(gl.enable(glw::GL_BLEND));

        // Render
        gl!(gl.use_program(resources.po_id));
        gl!(gl.viewport(0, 0, TEXTURE_WIDTH, TEXTURE_HEIGHT));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
        glu::expect_no_error(gl, "Draw call failed")?;

        // Verify rendered data in the layers
        let read_fbo_id = gen_framebuffer(gl, resources);
        gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, read_fbo_id));

        let mut buffer = vec![0u8; pixels * N_TEXTURE_COMPONENTS];
        for n_layer in 0..TEXTURE_DEPTH as usize {
            let mut has_layer_failed = false;
            let ref_buffer = &ref_buffer_slices[n_layer];

            gl!(gl.framebuffer_texture_layer(
                glw::GL_READ_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                to_id,
                0,
                n_layer as GLint
            ));
            gl!(gl.read_pixels(
                0,
                0,
                TEXTURE_WIDTH,
                TEXTURE_HEIGHT,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                buffer.as_mut_ptr().cast()
            ));
            glu::expect_no_error(gl, "Could not read back pixel data!")?;

            for y in 0..TEXTURE_HEIGHT as usize {
                let pixel_size = N_TEXTURE_COMPONENTS;
                let ref_row = &ref_buffer[y * pixel_size..];
                let row = &buffer[y * pixel_size..];

                for x in 0..TEXTURE_WIDTH as usize {
                    let data = &row[x * pixel_size..][..4];
                    let ref_data = &ref_row[x * pixel_size..][..4];

                    if (0..4).any(|c| (data[c] as i32 - ref_data[c] as i32).abs() > EPSILON) {
                        log::info!(
                            "(layer={n_layer} x={x} y={y}) Reference value is different than the rendered data (epsilon > {EPSILON}): ({}, {}, {}, {}) vs ({}, {}, {}, {}).",
                            ref_data[0],
                            ref_data[1],
                            ref_data[2],
                            ref_data[3],
                            data[0],
                            data[1],
                            data[2],
                            data[3]
                        );
                        has_layer_failed = true;
                    }
                }
            }

            if has_layer_failed {
                return Err(TestError::Fail("Pixel data comparison failed".to_string()));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }

    fn clear(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let fbo_draw_buffer = glw::GL_COLOR_ATTACHMENT0;
        let pixels = (TEXTURE_WIDTH * TEXTURE_HEIGHT) as usize;

        // Only carry on if geometry shaders are supported
        require_geometry_shader(&base)?;

        // Set up slice data: [char, int, uint] x 4 slices, as raw bytes
        let element_sizes = [1usize, 4, 4];
        let slice_data: Vec<[Vec<u8>; 4]> = element_sizes
            .iter()
            .map(|&element_size| {
                let component_sets: [&[usize]; 4] = [&[0], &[1], &[2], &[0, 1]];
                component_sets.map(|components| {
                    let mut data = vec![0u8; pixels * N_TEXTURE_COMPONENTS * element_size];
                    for n in 0..pixels {
                        for &component in components {
                            let at = (4 * n + component) * element_size;
                            if element_size == 1 {
                                data[at] = 255;
                            } else {
                                data[at..at + 4].copy_from_slice(&255u32.to_ne_bytes());
                            }
                        }
                    }
                    data
                })
            })
            .collect();

        // (internal format, format, type) of the rgba8, rgba32i and rgba32ui textures
        let texture_formats: [(GLenum, GLenum, GLenum); 3] = [
            (glw::GL_RGBA8, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE),
            (glw::GL_RGBA32I, glw::GL_RGBA_INTEGER, glw::GL_INT),
            (glw::GL_RGBA32UI, glw::GL_RGBA_INTEGER, glw::GL_UNSIGNED_INT),
        ];

        // Set up texture objects
        let to_ids: Vec<GLuint> = (0..3).map(|_| gen_texture(gl, resources)).collect();
        for n in 0..3 {
            let (to_internalformat, to_format, to_type) = texture_formats[n];

            gl!(gl.bind_texture(glw::GL_TEXTURE_3D, to_ids[n]));
            gl!(gl.tex_storage_3d(
                glw::GL_TEXTURE_3D,
                1,
                to_internalformat,
                TEXTURE_WIDTH,
                TEXTURE_HEIGHT,
                TEXTURE_DEPTH
            ));
            for (n_slice, data) in slice_data[n].iter().enumerate() {
                gl!(gl.tex_sub_image_3d(
                    glw::GL_TEXTURE_3D,
                    0,
                    0,
                    0,
                    n_slice as GLint,
                    TEXTURE_WIDTH,
                    TEXTURE_HEIGHT,
                    1,
                    to_format,
                    to_type,
                    data.as_ptr().cast()
                ));
            }
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_BASE_LEVEL, 0));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_MAX_LEVEL, 0));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
            glu::expect_no_error(gl, "Could not initialize texture object")?;
        }

        // Set up framebuffer object
        let fbo_ids: Vec<GLuint> = (0..3).map(|_| gen_framebuffer(gl, resources)).collect();
        let read_fbo_id = gen_framebuffer(gl, resources);
        for n in 0..3 {
            gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo_ids[n]));
            gl!(gl.draw_buffers(1, &fbo_draw_buffer));
            gl!(gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, to_ids[n], 0));
            glu::expect_no_error(gl, "Could not initialize framebuffer object")?;
        }

        // Try reading from the layered framebuffer.
        let mut buffer_char = vec![0u8; pixels * N_TEXTURE_COMPONENTS];
        gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo_ids[0]));
        gl!(gl.read_pixels(
            0,
            0,
            TEXTURE_WIDTH,
            TEXTURE_HEIGHT,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            buffer_char.as_mut_ptr().cast()
        ));

        // Is the returned data an exact copy of what we've uploaded for layer zero?
        if buffer_char != slice_data[0][0] {
            return Err(TestError::Fail(
                "Retrieved data is different from data uploaded for layer 0 of a layered framebuffer.".to_string(),
            ));
        }

        #[derive(Clone, Copy, PartialEq)]
        enum ClearType {
            Plain,
            BufferFv,
            BufferIv,
            BufferUiv,
        }

        // Iterate through all clear calls supported
        for current_test in [
            ClearType::Plain,
            ClearType::BufferFv,
            ClearType::BufferIv,
            ClearType::BufferUiv,
        ] {
            let clear_color_float: [f32; 4] = [0.25, 0.5, 1.0, 32.0 / 255.0];
            let clear_color_int: [i32; 4] = [64, 128, 255, 32];

            // Index into the char / int / uint tables
            let table = match current_test {
                ClearType::BufferFv | ClearType::Plain => 0,
                ClearType::BufferIv => 1,
                ClearType::BufferUiv => 2,
            };
            let fbo_id = fbo_ids[table];
            let to_id = to_ids[table];
            let pixel_size = N_TEXTURE_COMPONENTS * element_sizes[table];
            let (_, to_format, to_type) = texture_formats[table];
            let mut buffer = vec![0u8; pixels * pixel_size];

            // Restore layer data just in case
            gl!(gl.bind_texture(glw::GL_TEXTURE_3D, to_id));
            for (n_slice, data) in slice_data[table].iter().enumerate() {
                gl!(gl.tex_sub_image_3d(
                    glw::GL_TEXTURE_3D,
                    0,
                    0,
                    0,
                    n_slice as GLint,
                    TEXTURE_WIDTH,
                    TEXTURE_HEIGHT,
                    1,
                    to_format,
                    to_type,
                    data.as_ptr().cast()
                ));
            }
            glu::expect_no_error(gl, "glTexSubImage3D() call failed.")?;

            // Issue requested clear call
            gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_id));
            match current_test {
                ClearType::Plain => {
                    gl!(gl.clear_color(
                        clear_color_float[0],
                        clear_color_float[1],
                        clear_color_float[2],
                        clear_color_float[3]
                    ));
                    gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
                }
                ClearType::BufferIv => gl!(gl.clear_bufferiv(glw::GL_COLOR, 0, clear_color_int.as_ptr())),
                ClearType::BufferUiv => gl!(gl.clear_bufferuiv(glw::GL_COLOR, 0, clear_color_int.as_ptr().cast())),
                ClearType::BufferFv => gl!(gl.clear_bufferfv(glw::GL_COLOR, 0, clear_color_float.as_ptr())),
            }

            // Make sure no error was generated
            glu::expect_no_error(gl, "Clear call failed.")?;

            gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, read_fbo_id));
            glu::expect_no_error(gl, "Could not create read framebuffer object!")?;

            // Check the layer data after a clear call
            for n_layer in 0..TEXTURE_DEPTH {
                gl!(gl.framebuffer_texture_layer(
                    glw::GL_READ_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    to_id,
                    0,
                    n_layer
                ));
                gl!(gl.read_pixels(
                    0,
                    0,
                    TEXTURE_WIDTH,
                    TEXTURE_HEIGHT,
                    to_format,
                    to_type,
                    buffer.as_mut_ptr().cast()
                ));
                glu::expect_no_error(gl, "glReadPixels() call failed.")?;

                // If we requested an integer clear, the pixels we obtained should be reset to specific values.
                for y in 0..TEXTURE_HEIGHT as usize {
                    let row_size = TEXTURE_WIDTH as usize * pixel_size;
                    let row = &buffer[y * row_size..][..row_size];

                    for x in 0..TEXTURE_WIDTH as usize {
                        let pixel = &row[x * pixel_size..][..pixel_size];

                        if current_test == ClearType::BufferIv || current_test == ClearType::BufferUiv {
                            let words: Vec<i32> = pixel
                                .chunks_exact(4)
                                .map(|word| i32::from_ne_bytes(word.try_into().unwrap()))
                                .collect();
                            if words != clear_color_int {
                                log::info!(
                                    "(x={x} y={y}) Reference pixel [{}, {}, {}, {}] is different from the one retrieved [{}, {}, {}, {}]",
                                    clear_color_int[0],
                                    clear_color_int[1],
                                    clear_color_int[2],
                                    clear_color_int[3],
                                    words[0],
                                    words[1],
                                    words[2],
                                    words[3]
                                );
                                return Err(TestError::Fail("Data comparison failure".to_string()));
                            }
                        } else if (0..4).any(|c| (pixel[c] as i32 - clear_color_int[c]).abs() > EPSILON) {
                            log::info!(
                                "(x={x} y={y}) Reference pixel [{}, {}, {}, {}] is different from the one retrieved [{}, {}, {}, {}]",
                                clear_color_int[0],
                                clear_color_int[1],
                                clear_color_int[2],
                                clear_color_int[3],
                                pixel[0],
                                pixel[1],
                                pixel[2],
                                pixel[3]
                            );
                            return Err(TestError::Fail("Data comparison failure".to_string()));
                        }
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }

    fn depth(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let pixels = (TEXTURE_WIDTH * TEXTURE_HEIGHT) as usize;

        // This test should only run if EXT_geometry_shader is supported
        require_geometry_shader(&base)?;

        // Set up texture objects we will be using for the test
        let to_a_id = gen_texture(gl, resources);
        let to_b_id = gen_texture(gl, resources);

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, to_a_id));
        gl!(gl.tex_storage_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            1,
            glw::GL_RGBA8,
            TEXTURE_WIDTH,
            TEXTURE_HEIGHT,
            TEXTURE_DEPTH
        ));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, to_b_id));
        gl!(gl.tex_storage_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            1,
            glw::GL_DEPTH_COMPONENT32F,
            TEXTURE_WIDTH,
            TEXTURE_HEIGHT,
            TEXTURE_DEPTH
        ));
        glu::expect_no_error(gl, "Could not initialize texture objects")?;

        // Set up framebuffer object we will use for the test
        let fbo_id = gen_framebuffer(gl, resources);
        let read_fbo_id = gen_framebuffer(gl, resources);
        gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo_id));
        gl!(gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, to_a_id, 0));
        gl!(gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_DEPTH_ATTACHMENT, to_b_id, 0));
        glu::expect_no_error(gl, "Could not initialize framebuffer object")?;

        let status = gl!(gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER));
        if status != glw::GL_FRAMEBUFFER_COMPLETE {
            log::info!("Draw framebuffer is incomplete: {status}");
            return Err(TestError::Fail("Draw framebuffer is incomplete.".to_string()));
        }

        // Set up shader objects and the program object
        build_test_program(
            &base,
            context,
            resources,
            DEPTH_FS_CODE,
            DEPTH_GS_CODE,
            "Could not build program object",
        )?;

        // Set up vertex array object
        gen_vertex_array(gl, resources);
        glu::expect_no_error(gl, "Could not bind vertex array object")?;

        // Clear the depth attachment before we continue
        gl!(gl.clear_color(0.0, 0.0, 0.0, 0.0));
        gl!(gl.clear_depthf(0.5));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT));
        glu::expect_no_error(gl, "Depth buffer clear operation failed")?;

        // Render
        gl!(gl.use_program(resources.po_id));
        gl!(gl.viewport(0, 0, TEXTURE_WIDTH, TEXTURE_HEIGHT));
        gl!(gl.enable(glw::GL_DEPTH_TEST));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
        glu::expect_no_error(gl, "Rendering failed")?;

        // Verify the output
        gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, read_fbo_id));
        for n in 0..TEXTURE_DEPTH {
            let mut buffer = vec![0u8; pixels * N_TEXTURE_COMPONENTS];
            let ref_color: [u8; 4] = if n < 2 { [0xFF; 4] } else { [0; 4] };

            // Read the rendered layer data
            gl!(gl.framebuffer_texture_layer(glw::GL_READ_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, to_a_id, 0, n));
            gl!(gl.read_pixels(
                0,
                0,
                TEXTURE_WIDTH,
                TEXTURE_HEIGHT,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                buffer.as_mut_ptr().cast()
            ));
            glu::expect_no_error(gl, "glReadPixels() call failed")?;

            // Compare all pixels against the reference value
            for y in 0..TEXTURE_HEIGHT as usize {
                let row_width = TEXTURE_WIDTH as usize * N_TEXTURE_COMPONENTS;
                let row_data = &buffer[y * row_width..][..row_width];

                for x in 0..TEXTURE_WIDTH as usize {
                    let result = &row_data[x * N_TEXTURE_COMPONENTS..][..4];
                    if result != ref_color {
                        log::info!(
                            "(x={x} y={y}) Reference value is different than the rendered data: ({}, {}, {}, {}) vs ({}, {}, {}, {}).",
                            ref_color[0],
                            ref_color[1],
                            ref_color[2],
                            ref_color[3],
                            result[0],
                            result[1],
                            result[2],
                            result[3]
                        );
                        return Err(TestError::Fail("Rendered data mismatch".to_string()));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }

    fn stencil(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let width = STENCIL_TEXTURE_WIDTH;
        let texels = (TEXTURE_DEPTH * width * TEXTURE_HEIGHT) as usize;

        // This test should only run if EXT_geometry_shader is supported
        require_geometry_shader(&base)?;

        // Create shader and program objects, build the test program object
        build_test_program(
            &base,
            context,
            resources,
            STENCIL_FS_CODE,
            STENCIL_GS_CODE,
            "Could not build test program object",
        )?;

        // Generate and bind a vertex array object
        gen_vertex_array(gl, resources);
        glu::expect_no_error(gl, "Could not create & bind a vertex array object.")?;

        // Configure slice data. The depth data may be anything, the stencil data must be well-defined.
        let slice_null_data = vec![0u8; texels];
        let slice_1_data = vec![2u8; texels * 8];
        let slice_2_data = vec![1u8; texels * 8];
        let slice_3_data = vec![0u8; texels * 8];
        let slice_4_data = vec![0u8; texels * 8];

        // Set up texture objects
        let to_a_id = gen_texture(gl, resources);
        let to_b_id = gen_texture(gl, resources);

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, to_a_id));
        gl!(gl.tex_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            glw::GL_RGBA8 as GLint,
            width,
            TEXTURE_HEIGHT,
            TEXTURE_DEPTH,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null()
        ));
        for n_slice in 0..4 {
            gl!(gl.tex_sub_image_3d(
                glw::GL_TEXTURE_2D_ARRAY,
                0,
                0,
                0,
                n_slice,
                width,
                TEXTURE_HEIGHT,
                1,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                slice_null_data.as_ptr().cast()
            ));
        }
        glu::expect_no_error(gl, "Could not set up texture object A.")?;

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, to_b_id));
        gl!(gl.tex_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            glw::GL_DEPTH32F_STENCIL8 as GLint,
            width,
            TEXTURE_HEIGHT,
            TEXTURE_DEPTH,
            0,
            glw::GL_DEPTH_STENCIL,
            glw::GL_FLOAT_32_UNSIGNED_INT_24_8_REV,
            std::ptr::null()
        ));
        for (n_slice, data) in [&slice_1_data, &slice_2_data, &slice_3_data, &slice_4_data]
            .into_iter()
            .enumerate()
        {
            gl!(gl.tex_sub_image_3d(
                glw::GL_TEXTURE_2D_ARRAY,
                0,
                0,
                0,
                n_slice as GLint,
                width,
                TEXTURE_HEIGHT,
                1,
                glw::GL_DEPTH_STENCIL,
                glw::GL_FLOAT_32_UNSIGNED_INT_24_8_REV,
                data.as_ptr().cast()
            ));
        }
        glu::expect_no_error(gl, "Could not set up texture object B.")?;

        // Set up depth tests
        gl!(gl.disable(glw::GL_DEPTH_TEST));

        // Set up stencil tests
        gl!(gl.enable(glw::GL_STENCIL_TEST));
        gl!(gl.stencil_func(glw::GL_LESS, 0, 0xFFFFFFFF));

        // Set up framebuffer objects
        let fbo_id = gen_framebuffer(gl, resources);
        gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo_id));
        gl!(gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, to_a_id, 0));
        gl!(gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_DEPTH_STENCIL_ATTACHMENT, to_b_id, 0));
        glu::expect_no_error(gl, "Could not set up draw framebuffer.")?;

        // Issue the draw call.
        gl!(gl.use_program(resources.po_id));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
        glu::expect_no_error(gl, "Draw call failed.")?;

        // Check the results
        let row_size = N_TEXTURE_COMPONENTS * width as usize;
        for n in 0..4 {
            // Configure the read framebuffer
            gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo_id));
            gl!(gl.framebuffer_texture_layer(glw::GL_READ_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, to_a_id, 0, n));
            gl!(gl.framebuffer_texture(glw::GL_READ_FRAMEBUFFER, glw::GL_DEPTH_STENCIL_ATTACHMENT, 0, 0));
            glu::expect_no_error(gl, "Could not set up read framebuffer.")?;

            // Verify read framebuffer is considered complete
            let fbo_completeness = gl!(gl.check_framebuffer_status(glw::GL_READ_FRAMEBUFFER));
            if fbo_completeness != glw::GL_FRAMEBUFFER_COMPLETE {
                log::info!("Read FBO is incomplete: [{fbo_completeness}]");
                return Err(TestError::Fail("Read FBO is incomplete.".to_string()));
            }

            // Build reference data
            let ref_data = vec![if n < 2 { 255u8 } else { 0u8 }; row_size * TEXTURE_HEIGHT as usize];
            let mut result_data = vec![0u8; row_size * TEXTURE_HEIGHT as usize];

            // Read the rendered data
            gl!(gl.read_pixels(
                0,
                0,
                width,
                TEXTURE_HEIGHT,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                result_data.as_mut_ptr().cast()
            ));
            glu::expect_no_error(gl, "glReadPixels() failed")?;

            for y in 0..TEXTURE_HEIGHT as usize {
                let ref_row = &ref_data[y * row_size..][..row_size];
                let result_row = &result_data[y * row_size..][..row_size];

                for x in 0..width as usize {
                    let ref_pixel = &ref_row[x * N_TEXTURE_COMPONENTS..][..N_TEXTURE_COMPONENTS];
                    let result_pixel = &result_row[x * N_TEXTURE_COMPONENTS..][..N_TEXTURE_COMPONENTS];
                    if ref_pixel != result_pixel {
                        log::info!(
                            "(x={x} y={y}): Rendered data ({}, {}, {}, {}) is different from reference data ({}, {}, {}, {})",
                            result_pixel[0],
                            result_pixel[1],
                            result_pixel[2],
                            result_pixel[3],
                            ref_pixel[0],
                            ref_pixel[1],
                            ref_pixel[2],
                            ref_pixel[3]
                        );
                        return Err(TestError::Fail("Data comparison failed".to_string()));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for LayeredFramebuffer {
    fn name(&self) -> &str {
        match self.kind {
            Kind::Blending => "blending_support",
            Kind::Clear => "clear_call_support",
            Kind::Depth => "depth_support",
            Kind::Stencil => "stencil_support",
        }
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = match self.kind {
            Kind::Blending => self.blending(context, &mut resources),
            Kind::Clear => self.clear(context, &mut resources),
            Kind::Depth => self.depth(context, &mut resources),
            Kind::Stencil => self.stencil(context, &mut resources),
        };

        // deinit
        gl!(gl.use_program(0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
        for fbo in &resources.fbo_ids {
            gl!(gl.delete_framebuffers(1, fbo));
        }
        for shader in &resources.shader_ids {
            gl!(gl.delete_shader(*shader));
        }
        if resources.po_id != 0 {
            gl!(gl.delete_program(resources.po_id));
        }
        for to in &resources.to_ids {
            gl!(gl.delete_textures(1, to));
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        outcome
    }
}
