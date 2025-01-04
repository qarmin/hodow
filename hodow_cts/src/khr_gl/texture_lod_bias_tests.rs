// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcTextureLodBiasTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the desktop paths are ported (`m_isContextES` is always false in the roots that register this group): `${PRECISION}` and `${EXTENSION}` are empty, the error tolerance is 5 and vertex lookups are always supported. The GL objects upstream keeps in members are guards local to `iterate`.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

const LEVELS: u32 = 8;

/// full screen quad
const QUAD: [f32; 16] = [
    -1.0, -1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
];

/// constant array table
const COLORS: [[u8; 4]; LEVELS as usize + 1] = [
    [255, 0, 0, 255],     // red
    [0, 255, 0, 255],     // green
    [0, 0, 255, 255],     // blue
    [255, 255, 0, 255],   // yellow
    [0, 255, 255, 255],   // cyan
    [255, 0, 255, 255],   // purple
    [255, 128, 128, 255], // light red
    [128, 255, 128, 255], // light green
    [128, 128, 255, 255], // light blue
];

const MAX_ERROR_TOLERANCE: i32 = 5;

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
) -> Result<[u8; 4], TestError> {
    if !mipmap {
        // When not mipmapped, level base is used
        return Ok(colors[level_base as usize]);
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
            Ok(colors[level_base as usize])
        } else if min_filter == glw::GL_NEAREST_MIPMAP_NEAREST || min_filter == glw::GL_LINEAR_MIPMAP_NEAREST {
            // only one array is selected
            let d1 = if lod <= 0.5 {
                level_base
            } else if level_base as f32 + lod <= q as f32 + 0.5 {
                (level_base as f32 + lod + 0.5).ceil() as i32 - 1
            } else {
                q
            };
            Ok(colors[d1 as usize])
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
                ((1.0 - frac_lod) * f32::from(colors[d1 as usize][i]) + frac_lod * f32::from(colors[d2 as usize][i]))
                    as u8
            }))
        }
    } else {
        // Mag filter, base level is used
        Ok(colors[level_base as usize])
    }
}

/// `m_vert_shader_sampler_vert` - vertex lookup texture lod bias.
const VERT_SHADER_SAMPLER_VERT: &str = "${VERSION}\n    ${EXTENSION}\n    in vec4 vertex;\n    out vec4 tex;\n    uniform float      lodbase;\n    uniform sampler2D texture0;\n    void main(void)\n    {\n        gl_Position = vertex;\n        tex = textureLod(texture0, vertex.xy * 0.5 + 0.5, lodbase);\n    }\n    ";

/// `m_frag_shader_sampler_vert`
const FRAG_SHADER_SAMPLER_VERT: &str = "${VERSION}\n    ${PRECISION}\n    in vec4     tex;\n    out vec4 frag;\n    void main(void)\n    {\n        frag = tex;\n    }\n    ";

/// `m_vert_shader_sampler_frag` - fragment lookup texture lod bias.
const VERT_SHADER_SAMPLER_FRAG: &str = "${VERSION}\n    ${EXTENSION}\n    in vec4 vertex;\n    out vec2 tex;\n    void main(void)\n    {\n        gl_Position = vertex;\n        tex.xy = vertex.xy * 0.5 + 0.5;\n    }\n    ";

/// `m_frag_shader_sampler_frag`
const FRAG_SHADER_SAMPLER_FRAG: &str = "${VERSION}\n    ${PRECISION}\n    in vec2 tex;\n    out vec4 frag;\n    uniform float      biasshader;\n    uniform float      scale;\n    uniform sampler2D texture0;\n    void main(void)\n    {\n        frag = texture(texture0, vec2(scale * tex.x, 0), biasshader);\n    }\n    ";

/// `TextureLodBiasAllTestCase`
struct TextureLodBiasAllTestCase;

/// `create_program` of `iterate`
fn create_program<'gl>(
    gl: &'gl glw::Functions,
    specialization_map: &[(&str, String)],
    vert: &str,
    frag: &str,
) -> Result<ShaderProgram<'gl>, TestError> {
    let vshader = StringTemplate::new(vert).specialize(specialization_map)?;
    let fshader = StringTemplate::new(frag).specialize(specialization_map)?;
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vshader, fshader));
    if !program.is_ok() {
        return Err(TestError::Fail("Compile failed".to_string()));
    }
    Ok(program)
}

/// `setBuffers` - activates the program and sets vertex and texture attributes.
fn set_buffers(
    gl: &glw::Functions,
    program: &ShaderProgram<'_>,
    vao: &glu::VertexArray<'_>,
    vbo: &glu::Buffer<'_>,
) -> Result<(), TestError> {
    // SAFETY: names owned by the caller's guards, `QUAD` outlives the upload, and the attribute pointer is an offset into the bound buffer.
    unsafe {
        gl.bind_vertex_array(vao.get());
        glu::expect_no_error(gl, "bindVertexArray")?;

        gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo.get());
        glu::expect_no_error(gl, "bindBuffer")?;

        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(&QUAD) as isize,
            QUAD.as_ptr().cast(),
            glw::GL_DYNAMIC_DRAW,
        );
        glu::expect_no_error(gl, "bufferData")?;

        gl.use_program(program.program());
        glu::expect_no_error(gl, "useProgram")?;

        let loc_vertices = gl.get_attrib_location(program.program(), c"vertex".as_ptr());
        if loc_vertices != -1 {
            gl.enable_vertex_attrib_array(0);
            glu::expect_no_error(gl, "enableVertexAttribArray")?;

            let stride_size = (std::mem::size_of_val(&QUAD) / 4) as i32;
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
        if loc_texture != -1 {
            gl.uniform_1i(loc_texture, 0);
            glu::expect_no_error(gl, "uniform1i")?;
        }
    }
    Ok(())
}

/// `releaseBuffers`, without the deletion the guards do.
fn release_buffers(gl: &glw::Functions) -> Result<(), TestError> {
    // SAFETY: plain state setter.
    unsafe { gl.disable_vertex_attrib_array(0) };
    glu::expect_no_error(gl, "disableVertexAttribArray")
}

/// `drawQuad` - renders a full screen textured quad. Returns true if no error occured, false otherwise.
#[allow(clippy::too_many_arguments)]
fn draw_quad(
    context: &Context,
    program: &ShaderProgram<'_>,
    b_vertex_shader: bool,
    lodbase: f32,
    statebias: f32,
    shaderbias: f32,
    lod_min: f32,
    lod_max: f32,
) -> Result<bool, TestError> {
    let gl = context.gl();
    let bias_sum = statebias + shaderbias;
    let saved_statebias = statebias;
    let saved_shaderbias = shaderbias;
    let program_id = program.program();

    let uniform_location = |name: &std::ffi::CStr| -> glw::GLint {
        // SAFETY: a linked program and a NUL-terminated name.
        unsafe { gl.get_uniform_location(program_id, name.as_ptr()) }
    };

    if b_vertex_shader {
        let lodbase_loc = uniform_location(c"lodbase");
        if lodbase_loc == -1 {
            log::info!("Couldn't get shader uniform lodbase.");
            return Ok(false);
        }

        // Shader bias is not used and is accumulated into state bias
        let statebias = bias_sum;

        // SAFETY: state setters on the bound texture and the program in use.
        unsafe {
            gl.tex_parameterf(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_LOD_BIAS, statebias);
            glu::expect_no_error(gl, "texParameterf")?;

            // Explicit lodbase value for textureLod
            gl.uniform_1f(lodbase_loc, lodbase);
            glu::expect_no_error(gl, "uniform1f")?;
        }
    } else {
        let bias_loc = uniform_location(c"biasshader");
        let scale_loc = uniform_location(c"scale");
        if bias_loc == -1 || scale_loc == -1 {
            log::info!("Couldn't get shader uniform(s) biasshader or/and scale.");
            return Ok(false);
        }

        // SAFETY: as above.
        unsafe {
            gl.tex_parameterf(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_LOD_BIAS, statebias);
            glu::expect_no_error(gl, "texParameterf")?;

            gl.uniform_1f(bias_loc, shaderbias);
            glu::expect_no_error(gl, "uniform1f")?;

            // Setup scale to get proper lodbase
            gl.uniform_1f(scale_loc, 2.0f32.powf(lodbase));
            glu::expect_no_error(gl, "uniform1f")?;
        }
    }

    let mut readdata = [0u8; 4];
    // SAFETY: state setters, a draw from the vertex array set up by the caller, and a one pixel read into four bytes.
    unsafe {
        gl.tex_parameterf(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_LOD, lod_min);
        glu::expect_no_error(gl, "texParameterf")?;
        gl.tex_parameterf(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_LOD, lod_max);
        glu::expect_no_error(gl, "texParameterf")?;

        gl.clear_color(0.0, 0.0, 0.0, 1.0);
        glu::expect_no_error(gl, "clearColor")?;

        gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT);
        glu::expect_no_error(gl, "clear")?;

        gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);
        glu::expect_no_error(gl, "drawArrays")?;

        // one pixel is read
        gl.read_pixels(
            0,
            0,
            1,
            1,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            readdata.as_mut_ptr().cast(),
        );
        glu::expect_no_error(gl, "readPixels")?;
    }

    let expectedresult = color_texturing(
        gl,
        lodbase,
        bias_sum,
        lod_min,
        lod_max,
        0,
        8,
        1 << LEVELS,
        glw::GL_LINEAR,
        glw::GL_LINEAR_MIPMAP_LINEAR,
        true,
        &COLORS,
    )?;

    let precision = context.render_target().red_bits;
    let epsilon = (256 / (1 << precision)).max(MAX_ERROR_TOLERANCE);

    if (0..4).any(|i| (i32::from(readdata[i]) - i32::from(expectedresult[i])).abs() > epsilon) {
        log::info!(
            "texture bias ({saved_statebias:.6}), shader bias({saved_shaderbias:.6}), sum({:.6}): {} {} {} {} != {} {} {} {}",
            saved_statebias + saved_shaderbias,
            readdata[0],
            readdata[1],
            readdata[2],
            readdata[3],
            expectedresult[0],
            expectedresult[1],
            expectedresult[2],
            expectedresult[3]
        );
        Ok(false)
    } else {
        Ok(true)
    }
}

/// One of the two bias sweeps of `iterate`: every texture object bias against every shader bias.
fn sweep(
    context: &Context,
    program: &ShaderProgram<'_>,
    b_vertex_shader: bool,
    m: f32,
    returnvalue: &mut bool,
    failedbiases: &mut i32,
) -> Result<(), TestError> {
    const SAMPLES: i32 = 128;

    for i in 0..SAMPLES {
        // this is the texture object bias
        let f = m * ((i as f32 / (SAMPLES - 1) as f32) * 2.0 - 1.0);
        for j in 0..SAMPLES {
            // this is the shader bias
            let g = m * ((j as f32 / (SAMPLES - 1) as f32) * 2.0 - 1.0);
            if !draw_quad(context, program, b_vertex_shader, 0.0, f, g, -1000.0, 1000.0)? {
                *returnvalue = false;
                *failedbiases += 1;
                break;
            }
        }
        if !*returnvalue {
            break;
        }
    }
    Ok(())
}

impl TestCase for TextureLodBiasAllTestCase {
    fn name(&self) -> &str {
        "texture_lod_bias_all"
    }

    /// This test should only be executed if we're running a GL>=3.0 context.
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !context.context_type().supports_core(3, 0) {
            return Err(TestError::NotSupported(
                "Test texture_lod_bias_all is not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let version = context.context_type().glsl_version().declaration();
        let specialization_map = [
            ("VERSION", version.to_string()),
            ("EXTENSION", String::new()),
            ("PRECISION", String::new()),
        ];

        let mut returnvalue = true;
        let mut failedbiases = 0;
        let mut m = 0.0f32;
        // SAFETY: one GLfloat out.
        unsafe { gl.get_floatv(glw::GL_MAX_TEXTURE_LOD_BIAS, &mut m) };
        glu::expect_no_error(gl, "getFloatv")?;

        // createRenderingResources
        let target = glu::Texture::new(gl);
        let fbo = glu::Framebuffer::new(gl);
        let texture = glu::Texture::new(gl);
        // SAFETY: names owned by the guards above; `data` holds the largest level, which every later level fits in.
        unsafe {
            // setup fbo along with attached color texture
            glu::expect_no_error(gl, "genTextures")?;
            gl.bind_texture(glw::GL_TEXTURE_2D, target.get());
            glu::expect_no_error(gl, "bindTexture")?;

            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, 1, 1);
            glu::expect_no_error(gl, "texStorage2D")?;

            glu::expect_no_error(gl, "genFramebuffers")?;
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo.get());
            glu::expect_no_error(gl, "bindFramebuffer")?;

            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo.get());
            glu::expect_no_error(gl, "bindFramebuffer")?;

            gl.framebuffer_texture_2d(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                target.get(),
                0,
            );
            glu::expect_no_error(gl, "framebufferTexture2D")?;

            // setup testing texture
            let mut texturesize: u32 = 1 << LEVELS;
            let mut data = vec![0u8; (texturesize * texturesize * 3) as usize];

            gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
            glu::expect_no_error(gl, "pixelStorei")?;

            glu::expect_no_error(gl, "genTextures")?;
            gl.bind_texture(glw::GL_TEXTURE_2D, texture.get());
            glu::expect_no_error(gl, "bindTexture")?;

            gl.viewport(0, 0, texturesize as i32, texturesize as i32);
            glu::expect_no_error(gl, "viewport")?;

            for j in 0..=LEVELS {
                for i in 0..(texturesize * texturesize) as usize {
                    data[i * 3] = COLORS[j as usize][0];
                    data[i * 3 + 1] = COLORS[j as usize][1];
                    data[i * 3 + 2] = COLORS[j as usize][2];
                }
                gl.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    j as i32,
                    glw::GL_RGB as i32,
                    texturesize as i32,
                    texturesize as i32,
                    0,
                    glw::GL_RGB,
                    glw::GL_UNSIGNED_BYTE,
                    data.as_ptr().cast(),
                );
                glu::expect_no_error(gl, "texImage2D")?;

                texturesize >>= 1;
            }

            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR as i32);
            glu::expect_no_error(gl, "texParameteri")?;
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_MIN_FILTER,
                glw::GL_LINEAR_MIPMAP_LINEAR as i32,
            );
            glu::expect_no_error(gl, "texParameteri")?;
        }

        {
            let program_vert = create_program(
                gl,
                &specialization_map,
                VERT_SHADER_SAMPLER_VERT,
                FRAG_SHADER_SAMPLER_VERT,
            )?;

            // fragment shader test
            let vao = glu::VertexArray::new(gl);
            let vbo = glu::Buffer::new(gl);
            set_buffers(gl, &program_vert, &vao, &vbo)?;
            sweep(context, &program_vert, true, m, &mut returnvalue, &mut failedbiases)?;
            release_buffers(gl)?;
        }

        {
            let program_frag = create_program(
                gl,
                &specialization_map,
                VERT_SHADER_SAMPLER_FRAG,
                FRAG_SHADER_SAMPLER_FRAG,
            )?;

            // fragment shader test
            let vao = glu::VertexArray::new(gl);
            let vbo = glu::Buffer::new(gl);
            set_buffers(gl, &program_frag, &vao, &vbo)?;
            sweep(context, &program_frag, false, m, &mut returnvalue, &mut failedbiases)?;
            release_buffers(gl)?;
        }

        if failedbiases > 0 {
            log::info!("Total failed lod bias combinations (vertex shader): {failedbiases}");
        }

        Ok(if returnvalue {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `TextureLodBiasTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture_lod_bias");
    group.add_child(Box::new(TextureLodBiasAllTestCase) as Box<dyn TestCase>);
    group
}
