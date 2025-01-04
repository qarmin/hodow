// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcTextureLodBasicTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the desktop paths are ported (`m_isContextES` is always false in the roots that register this group), so `${PRECISION}` is empty. The GL objects upstream keeps in members (`m_texture`, `m_vao`, `m_vbo`) are guards local to one texture target's pass.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

/// full screen quad
const FS_QUAD: [f32; 16] = [
    -1.0, -1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
];

const COLORARRAY: [[u8; 4]; 4] = [
    [255, 0, 0, 255],   // red
    [0, 255, 0, 255],   // green
    [0, 0, 255, 255],   // blue
    [127, 255, 0, 255], // redish green
];

/// `colorTexturing` - manually calculates the result of texturing.
#[allow(clippy::too_many_arguments)]
fn color_texturing(
    gl: &glw::Functions,
    lod_base: f32,
    mut lod_bias_sum: f32,
    lod_min: f32,
    lod_max: f32,
    level_base: i32,
    level_max: i32,
    level_base_max_size: i32,
    mag_filter: GLenum,
    min_filter: GLenum,
    mipmap: bool,
    colors: &[[u8; 4]],
) -> Result<[f32; 4], TestError> {
    const MAX_COLOR: f32 = 255.0;
    let copy_pixel = |src: &[u8; 4]| -> [f32; 4] { std::array::from_fn(|i| f32::from(src[i]) / MAX_COLOR) };

    if !mipmap {
        // When not mipmapped, level base is used
        return Ok(copy_pixel(&colors[level_base as usize]));
    }

    // Mipmapped

    // Check the constant divide the mag or min filter
    let lod_constant = if mag_filter == glw::GL_LINEAR
        && (min_filter == glw::GL_NEAREST_MIPMAP_NEAREST || min_filter == glw::GL_NEAREST_MIPMAP_LINEAR)
    {
        0.5
    } else {
        0.0
    };

    // Get final lod which is clamp
    let mut lod = lod_base;
    if lod_bias_sum != 0.0 {
        let mut max_lod_bias = 0.0f32;
        // SAFETY: one GLfloat out.
        unsafe { gl.get_floatv(glw::GL_MAX_TEXTURE_LOD_BIAS, &mut max_lod_bias) };
        glu::expect_no_error(gl, "getFloatv")?;
        if lod_bias_sum > max_lod_bias {
            lod_bias_sum = max_lod_bias;
        } else if lod_bias_sum < -max_lod_bias {
            lod_bias_sum = -max_lod_bias;
        }
        lod += lod_bias_sum;
    }
    if lod < lod_min {
        lod = lod_min;
    } else if lod > lod_max {
        lod = lod_max;
    }

    // Check which filter is to use
    if lod > lod_constant {
        // Min filter
        let mut temp_max_size = 1;
        let mut log2_temp_max_size = 0;

        // Calculate the max level
        while temp_max_size * 2 <= level_base_max_size {
            log2_temp_max_size += 1;
            temp_max_size <<= 1;
        }

        let p = log2_temp_max_size + level_base;
        let mut q = level_max;
        if p < q {
            q = p;
        }

        if min_filter == glw::GL_NEAREST || min_filter == glw::GL_LINEAR {
            // base level is used
            Ok(copy_pixel(&colors[level_base as usize]))
        } else if min_filter == glw::GL_NEAREST_MIPMAP_NEAREST || min_filter == glw::GL_LINEAR_MIPMAP_NEAREST {
            // only one array is selected
            let d1 = if lod <= 0.5 {
                level_base
            } else if level_base as f32 + lod <= q as f32 + 0.5 {
                (level_base as f32 + lod + 0.5).ceil() as i32 - 1
            } else {
                q
            };
            Ok(copy_pixel(&colors[d1 as usize]))
        } else {
            // interplate between two arrays
            let (d1, d2) = if level_base as f32 + lod >= q as f32 {
                (q, q)
            } else {
                let d1 = (level_base as f32 + lod).floor() as i32;
                (d1, d1 + 1)
            };

            let frac_lod = lod % 1.0;
            Ok(std::array::from_fn(|i| {
                let d1norm = f32::from(colors[d1 as usize][i]) / MAX_COLOR;
                let d2norm = f32::from(colors[d2 as usize][i]) / MAX_COLOR;
                (1.0 - frac_lod) * d1norm + frac_lod * d2norm
            }))
        }
    } else {
        // Mag filter, base level is used
        Ok(copy_pixel(&colors[level_base as usize]))
    }
}

/// `m_shader_basic_vert`
const SHADER_BASIC_VERT: &str = "${VERSION}\n    in vec4 vertex;\n    out vec2    tex;\n    void main(void)\n    {\n        gl_Position = vertex;\n        tex = vertex.xy * 0.5 + 0.5;\n    }\n    ";

/// `m_shader_basic_1d_frag`
const SHADER_BASIC_1D_FRAG: &str = "${VERSION}\n    ${PRECISION}\n    in vec2 tex;\n    out vec4 frag;\n    uniform float      scale;\n    uniform sampler1D texture0;\n    void main(void)\n    {\n        frag = texture(texture0, tex.x * scale);\n    }\n    ";

/// `m_shader_basic_2d_frag`
const SHADER_BASIC_2D_FRAG: &str = "${VERSION}\n    ${PRECISION}\n    in vec2 tex;\n    out vec4 frag;\n    uniform float      scale;\n    uniform sampler2D texture0;\n    void main(void)\n    {\n        frag = texture(texture0, vec2(tex.x * scale, 0));\n    }\n    ";

/// `TextureLodSelectionTestCase`
struct TextureLodSelectionTestCase;

/// `create_program` of `iterate`
fn create_program<'gl>(
    gl: &'gl glw::Functions,
    specialization_map: &[(&str, String)],
    vert: &str,
    frag: &str,
) -> Result<ShaderProgram<'gl>, TestError> {
    let vshader = StringTemplate::new(vert).specialize(specialization_map)?;
    let fshader = StringTemplate::new(frag).specialize(specialization_map)?;
    Ok(ShaderProgram::new(gl, &ProgramSources::vtx_frag(vshader, fshader)))
}

/// Creates a texture that has solid color in given lod level.
fn create_solid_texture(
    gl: &glw::Functions,
    tex_target: GLenum,
    level: i32,
    size: i32,
    color: &[u8; 4],
) -> Result<(), TestError> {
    let data: Vec<u8> = (0..size * size).flat_map(|_| *color).collect();

    // SAFETY: `data` holds size x size (or size) RGBA8 texels.
    unsafe {
        if tex_target == glw::GL_TEXTURE_2D {
            gl.tex_image_2d(
                tex_target,
                level,
                glw::GL_RGBA8 as i32,
                size,
                size,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                data.as_ptr().cast(),
            );
            glu::expect_no_error(gl, "texImage2D")?;
        } else if tex_target == glw::GL_TEXTURE_1D {
            gl.tex_image_1d(
                tex_target,
                level,
                glw::GL_RGBA8 as i32,
                size,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                data.as_ptr().cast(),
            );
            glu::expect_no_error(gl, "texImage1D")?;
        }
    }
    Ok(())
}

/// `createLodTexture` - the texture is generated from the constant color array.
fn create_lod_texture(gl: &glw::Functions, texture: &glu::Texture<'_>, target: GLenum) -> Result<(), TestError> {
    // SAFETY: state setters on the texture just bound.
    unsafe {
        gl.bind_texture(target, texture.get());
        glu::expect_no_error(gl, "bindTexture")?;

        gl.viewport(0, 0, 4, 4);
        glu::expect_no_error(gl, "viewport")?;
    }

    // 1. Create a texture with 8x8, 4x4, 2x2 and 1x1 images in levels 0, 1, 2 and 3 respectively, with consistent formats and types. Set TEXTURE_MAG_FILTER to LINEAR and TEXTURE_MIN_FILTER to LINEAR_MIPMAP_LINEAR.
    for (i, color) in COLORARRAY.iter().enumerate() {
        create_solid_texture(gl, target, i as i32, 8 >> i, color)?;
    }

    // SAFETY: as above.
    unsafe {
        gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR as i32);
        glu::expect_no_error(gl, "texParameteri")?;
        gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR_MIPMAP_LINEAR as i32);
        glu::expect_no_error(gl, "texParameteri")?;

        gl.tex_parameterf(target, glw::GL_TEXTURE_BASE_LEVEL, 1.0);
        glu::expect_no_error(gl, "texParameterf")?;
        gl.tex_parameterf(target, glw::GL_TEXTURE_MAX_LEVEL, 2.0);
        glu::expect_no_error(gl, "texParameterf")?;
        gl.tex_parameterf(target, glw::GL_TEXTURE_MIN_LOD, -1000.0);
        glu::expect_no_error(gl, "texParameterf")?;
        gl.tex_parameterf(target, glw::GL_TEXTURE_MAX_LOD, 1000.0);
        glu::expect_no_error(gl, "texParameterf")?;
    }
    Ok(())
}

/// `doComparison` - compares the expected result and the frame buffer output. Pixel epsilon is one.
fn do_comparison(context: &Context, size: i32, expectedcolor: &[f32; 4]) -> Result<bool, TestError> {
    let gl = context.gl();
    let mut ret = true;

    let mut data = vec![0u32; (size * size) as usize];

    // one pixel is read
    let target = context.render_target();
    let use_10_bits = target.red_bits == 10
        && target.green_bits == 10
        && target.blue_bits == 10
        && (target.alpha_bits == 2 || target.alpha_bits == 0);
    let type_ = if use_10_bits {
        glw::GL_UNSIGNED_INT_2_10_10_10_REV
    } else {
        glw::GL_UNSIGNED_BYTE
    };
    let num_channels = if target.alpha_bits == 0 { 3 } else { 4 };
    // SAFETY: `data` holds size x size four-byte pixels.
    unsafe { gl.read_pixels(0, 0, size, size, glw::GL_RGBA, type_, data.as_mut_ptr().cast()) };
    glu::expect_no_error(gl, "readPixels")?;

    let col_bits = [target.red_bits, target.green_bits, target.blue_bits, target.alpha_bits];
    let calc_epsilon = |bits: i32| -> f32 {
        let zero = 2.0f32.powi(-8);
        let mut e = zero;
        if bits != 0 {
            e = (1.0 / (2.0f32.powi(bits) - 1.0)) + zero;
            if e > 1.0 {
                e = 1.0;
            }
        }
        e
    };
    let mut epsilon = [0.0f32; 4];
    for i in 0..num_channels {
        epsilon[i] = calc_epsilon(col_bits[i]);
    }

    for (i, &pixel) in data.iter().enumerate() {
        let px_bytes = pixel.to_ne_bytes();
        let result_color: [f32; 4] = if use_10_bits {
            // Note this is a strange way to store RGB10A2 but it matches what implementations do.
            [
                (pixel & 0x3FF) as f32 / 1023.0,
                ((pixel >> 10) & 0x3FF) as f32 / 1023.0,
                ((pixel >> 20) & 0x3FF) as f32 / 1023.0,
                ((pixel >> 30) & 0x3) as f32 / 3.0,
            ]
        } else {
            // If not 10-bit then we already converted to 8-bit (UNSIGNED_BYTE) in the ReadPixels call, above.
            std::array::from_fn(|c| f32::from(px_bytes[c]) / 255.0)
        };

        for j in 0..num_channels {
            if (result_color[j] - expectedcolor[j]).abs() > epsilon[j] {
                log::info!(
                    "TextureLodSelectionTestCase: Unexpected result of color comparison at pixel {i}: {} {} {} {} != {} {} {} {}",
                    expectedcolor[0],
                    expectedcolor[1],
                    expectedcolor[2],
                    expectedcolor[3],
                    result_color[0],
                    result_color[1],
                    result_color[2],
                    result_color[3]
                );
                ret = false;
                break;
            }
        }
    }
    Ok(ret)
}

/// `drawAndVerify` - draws a quad using the given lod. Minlod and maxlod values are used to calculate the reference value.
#[allow(clippy::too_many_arguments)]
fn draw_and_verify(
    context: &Context,
    loc_scale: glw::GLint,
    lod_level: f32,
    level_base: i32,
    level_max: i32,
    level_base_max_size: i32,
    lod_biasshader: f32,
    lod_min: f32,
    lod_max: f32,
    mag_filter: GLenum,
    min_filter: GLenum,
    mipmap: bool,
) -> Result<bool, TestError> {
    let gl = context.gl();

    // is this selection ok?
    let scale = 8.0 * 2.0f32.powf(lod_level) / 8.0;

    // SAFETY: state setters and a draw from the vertex array set up by the caller.
    unsafe {
        gl.uniform_1f(loc_scale, scale);
        glu::expect_no_error(gl, "uniform1f")?;

        gl.clear_color(0.0, 0.0, 0.0, 1.0);
        glu::expect_no_error(gl, "clearColor")?;

        gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT);
        glu::expect_no_error(gl, "clear")?;

        gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);
        glu::expect_no_error(gl, "drawArrays")?;
    }

    // Expected result
    let result = color_texturing(
        gl,
        lod_level,
        lod_biasshader,
        lod_min,
        lod_max,
        level_base,
        level_max,
        level_base_max_size,
        mag_filter,
        min_filter,
        mipmap,
        &COLORARRAY,
    )?;

    // Result of comparison of two arrays are returned
    do_comparison(context, 4, &result)
}

impl TestCase for TextureLodSelectionTestCase {
    fn name(&self) -> &str {
        "lod_selection"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let version = context.context_type().glsl_version().declaration();
        let specialization_map = [("VERSION", version.to_string()), ("PRECISION", String::new())];

        let textures = [glw::GL_TEXTURE_2D, glw::GL_TEXTURE_1D];
        let mut ret = true;

        for tex_target in textures {
            let program = if tex_target == glw::GL_TEXTURE_2D {
                create_program(gl, &specialization_map, SHADER_BASIC_VERT, SHADER_BASIC_2D_FRAG)?
            } else {
                create_program(gl, &specialization_map, SHADER_BASIC_VERT, SHADER_BASIC_1D_FRAG)?
            };

            if !program.is_ok() {
                return Err(TestError::Fail("Compile failed".to_string()));
            }

            // fragment shader test
            let vao = glu::VertexArray::new(gl);
            let vbo = glu::Buffer::new(gl);

            // setBuffers
            // SAFETY: names owned by the guards above, `FS_QUAD` outlives the upload, and the attribute pointer is an offset into the bound buffer.
            unsafe {
                glu::expect_no_error(gl, "genVertexArrays")?;
                gl.bind_vertex_array(vao.get());
                glu::expect_no_error(gl, "bindVertexArray")?;

                glu::expect_no_error(gl, "genBuffers")?;
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo.get());
                glu::expect_no_error(gl, "bindBuffer")?;

                gl.buffer_data(
                    glw::GL_ARRAY_BUFFER,
                    std::mem::size_of_val(&FS_QUAD) as isize,
                    FS_QUAD.as_ptr().cast(),
                    glw::GL_DYNAMIC_DRAW,
                );
                glu::expect_no_error(gl, "bufferData")?;

                gl.use_program(program.program());
                glu::expect_no_error(gl, "useProgram")?;

                let loc_vertices = gl.get_attrib_location(program.program(), c"vertex".as_ptr());
                glu::expect_no_error(gl, "getAttribLocation")?;
                if loc_vertices != -1 {
                    gl.enable_vertex_attrib_array(0);
                    glu::expect_no_error(gl, "enableVertexAttribArray")?;

                    let stride_size = (std::mem::size_of_val(&FS_QUAD) / 4) as i32;
                    gl.vertex_attrib_pointer(
                        loc_vertices as u32,
                        4,
                        glw::GL_FLOAT,
                        glw::FALSE,
                        stride_size,
                        std::ptr::null(),
                    );
                    glu::expect_no_error(gl, "vertexAttribPointer")?;
                }

                let loc_texture = gl.get_uniform_location(program.program(), c"texture0".as_ptr());
                glu::expect_no_error(gl, "getUniformLocation")?;
                if loc_texture != -1 {
                    gl.uniform_1i(loc_texture, 0);
                    glu::expect_no_error(gl, "uniform1i")?;
                }
            }

            // SAFETY: a linked program.
            let loc_scale = unsafe { gl.get_uniform_location(program.program(), c"scale".as_ptr()) };
            glu::expect_no_error(gl, "getUniformLocation")?;
            if loc_scale == -1 {
                return Err(TestError::Fail("scale location not valid".to_string()));
            }

            let texture = glu::Texture::new(gl);
            create_lod_texture(gl, &texture, tex_target)?;

            // 2. Set TEXTURE_BASE_LEVEL to 1 and TEXTURE_MAX_LEVEL to 2. Render with a LOD of -1, and check that level 1 is used.
            // 3. Set TEXTURE_BASE_LEVEL to 1 and TEXTURE_MAX_LEVEL to 2. Render with a LOD of 3, and check that level 2 is used.
            // 4. Set TEXTURE_BASE_LEVEL to 1 and TEXTURE_MAX_LEVEL to 2. Render with a LOD of 0.5, and check that this is correctly interpolated.
            for lod_level in [-1.0, 3.0, 0.5] {
                if !draw_and_verify(
                    context,
                    loc_scale,
                    lod_level,
                    1,
                    2,
                    4,
                    0.0,
                    -1000.0,
                    1000.0,
                    glw::GL_LINEAR,
                    glw::GL_LINEAR_MIPMAP_LINEAR,
                    true,
                )? {
                    ret = false;
                }
            }

            // 5. Set TEXTURE_BASE_LEVEL to 1, TEXTURE_MAX_LEVEL to 2, TEXTURE_MIN_LOD to 0.5, TEXTURE_MAX_LOD to 1000. Render with a LOD of 0, and check that it is clamped to 0.5.
            // SAFETY: state setters on the bound texture.
            unsafe {
                gl.tex_parameterf(tex_target, glw::GL_TEXTURE_MIN_LOD, 0.5);
                glu::expect_no_error(gl, "texParameterf")?;
                gl.tex_parameterf(tex_target, glw::GL_TEXTURE_MAX_LOD, 1000.0);
                glu::expect_no_error(gl, "texParameterf")?;
            }
            if !draw_and_verify(
                context,
                loc_scale,
                0.0,
                1,
                2,
                4,
                0.0,
                0.5,
                1000.0,
                glw::GL_LINEAR,
                glw::GL_LINEAR_MIPMAP_LINEAR,
                true,
            )? {
                ret = false;
            }

            // 6. Set TEXTURE_BASE_LEVEL to 1, TEXTURE_MAX_LEVEL to 2, TEXTURE_MIN_LOD to -1000, TEXTURE_MAX_LOD to 0.5. Render with a LOD of 1, and check that it is clamped to 0.5.
            // SAFETY: as above.
            unsafe {
                gl.tex_parameterf(tex_target, glw::GL_TEXTURE_MIN_LOD, -1000.0);
                glu::expect_no_error(gl, "texParameterf")?;
                gl.tex_parameterf(tex_target, glw::GL_TEXTURE_MAX_LOD, 0.5);
                glu::expect_no_error(gl, "texParameterf")?;
            }
            if !draw_and_verify(
                context,
                loc_scale,
                1.0,
                1,
                2,
                4,
                0.0,
                -1000.0,
                0.5,
                glw::GL_LINEAR,
                glw::GL_LINEAR_MIPMAP_LINEAR,
                true,
            )? {
                ret = false;
            }

            // Release resources: releaseBuffers, then the guards delete the buffer, the array and the texture.
            // SAFETY: plain state setter.
            unsafe { gl.disable_vertex_attrib_array(0) };
            glu::expect_no_error(gl, "disableVertexAttribArray")?;
        }

        Ok(if ret {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `TextureLodBasicTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture_lod_basic");
    group.add_child(Box::new(TextureLodSelectionTestCase) as Box<dyn TestCase>);
    group
}
