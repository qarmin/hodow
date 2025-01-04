// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcPixelStorageModesTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's cases derive from `sglr::ContextWrapper` and construct an `sglr::GLContext` around the render context only to log calls; every GL call goes to the real context either way, so that wrapper has no counterpart. The case classes keep their parameters in a `TexImageUtils`/`CompressedTexImageUtils` struct and everything upstream stores in members between `iterate`'s steps (source data, texture, program) is a local here. The `ARB_compressed_texture_pixel_storage` and format extension checks upstream makes at the top of the compressed cases' `iterate` are in `check_support`. `tcu::Float<uint32_t, 5, 6, 15>` is only ever given 0.0 and multiples of 0.125 up to 1.0, which `unsigned_small_float_bits` encodes exactly; it is not a general converter.

use crate::glu::{self, Context, GlslVersion, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, pr, va};
use crate::glw::{self, GLenum};
use crate::sglr::reference_utils::map_gl_internal_format;
use crate::tcu::float::Float16;
use crate::tcu::rgba::RGBA;
use crate::tcu::{StringTemplate, Surface, TestError, TestOutcome, TestStatus};

const VS_TEMPLATE_SRC: &str = "${GLSL_VERSION}\nin highp vec4 pos;\nout highp ${TEXCOORDS_TYPE} texcoords;\n${LAYER}\nvoid main (void)\n{\n     texcoords = ${TEXCOORDS};\n     gl_Position = pos;\n}\n";

const FS_TEMPLATE_SRC: &str = "${GLSL_VERSION}\nprecision highp float;\nprecision highp int;\nout vec4 fragColour;\nin ${TEXCOORDS_TYPE} texcoords;\nuniform highp ${SAMPLER_TYPE} sampler;\nuniform ${COL_TYPE} refcolour;\nvoid main (void)\n{\n     ${COL_TYPE} colour = texelFetch(sampler, i${TEXCOORDS_TYPE}(texcoords), 0);\n     if (${CONDITION})\n         fragColour = vec4(0.0, 1.0, 0.0, 1.0);\n     else\n         fragColour = vec4(colour);\n}\n";

/// `getEps`
fn get_eps(internal_format: GLenum) -> Result<f64, TestError> {
    let eps = match internal_format {
        glw::GL_RGBA4 => 1.0 / f64::from(1 << 4),
        glw::GL_RGB565 | glw::GL_RGB5_A1 | glw::GL_COMPRESSED_RGB_S3TC_DXT1_EXT => 1.0 / f64::from(1 << 5),
        glw::GL_R8
        | glw::GL_R8_SNORM
        | glw::GL_RG8
        | glw::GL_RG8_SNORM
        | glw::GL_RGB8
        | glw::GL_SRGB8
        | glw::GL_RGB8_SNORM
        | glw::GL_RGBA8
        | glw::GL_SRGB8_ALPHA8
        | glw::GL_RGBA8_SNORM => 1.0 / f64::from(1 << 8),
        glw::GL_RGB9_E5 => 1.0 / f64::from(1 << 9),
        glw::GL_R11F_G11F_B10F | glw::GL_RGB10_A2 => 1.0 / f64::from(1 << 10),
        glw::GL_R16F | glw::GL_RG16F | glw::GL_RGB16F | glw::GL_RGBA16F | glw::GL_COMPRESSED_RGBA_ASTC_8x5_KHR => {
            1.0 / f64::from(1 << 16)
        }
        // upstream's `1 << 31` is INT_MIN, so this one is negative there and the max below picks 0.01 either way
        glw::GL_R32F | glw::GL_RG32F | glw::GL_RGB32F | glw::GL_RGBA32F => 1.0 / 2147483648.0,
        _ => return Err(TestError::Fail("Invalid internal format".to_string())),
    };

    Ok(eps.max(0.01))
}

/// `inrange`
fn inrange(x: i32, left: i32, right: i32) -> bool {
    x >= left && x < right
}

/// What `TexImageUtils`' constructor derives from the internal format: `m_format`, `m_type`, `m_pixelsize`, `m_num_channels`.
struct TexFormat {
    format: GLenum,
    type_: GLenum,
    pixel_size: usize,
    num_channels: i32,
}

fn describe_format(internal_format: GLenum) -> Result<TexFormat, TestError> {
    let tex_format = map_gl_internal_format(internal_format)
        .ok_or_else(|| TestError::InternalError(format!("unmapped internal format {internal_format:#x}")))?;
    let transfer = glu::get_transfer_format(tex_format)?;
    let pixel_size = tex_format
        .pixel_size()
        .ok_or_else(|| TestError::InternalError("texture format has no pixel size".to_string()))?
        as usize;
    Ok(TexFormat {
        format: transfer.format,
        type_: transfer.data_type,
        pixel_size,
        num_channels: tex_format.order.num_used_channels() as i32,
    })
}

/// `TexImageUtils` - the cuboid and the sub-cuboid read from it.
#[derive(Clone, Copy)]
struct Cuboid {
    cuboid_w: i32,
    cuboid_h: i32,
    cuboid_d: i32,
    subcuboid_x0: i32,
    subcuboid_y0: i32,
    subcuboid_z0: i32,
    subcuboid_w: i32,
    subcuboid_h: i32,
    subcuboid_d: i32,
}

/// Reads `p` as a native-endian unsigned integer of `size` bytes.
fn read_uint(p: &[u8], size: usize) -> u64 {
    match size {
        1 => u64::from(p[0]),
        2 => u64::from(u16::from_ne_bytes([p[0], p[1]])),
        4 => u64::from(u32::from_ne_bytes([p[0], p[1], p[2], p[3]])),
        other => panic!("no integer of {other} bytes"),
    }
}

fn write_uint(p: &mut [u8], size: usize, value: u64) {
    match size {
        1 => p[0] = value as u8,
        2 => p[..2].copy_from_slice(&(value as u16).to_ne_bytes()),
        4 => p[..4].copy_from_slice(&(value as u32).to_ne_bytes()),
        other => panic!("no integer of {other} bytes"),
    }
}

/// `writeToUnsignedChannel`
fn write_to_unsigned_channel(p: &mut [u8], size: usize, channel: usize, col: f64) {
    let d_max = ((1u64 << (size * 8)) - 1) as f64;
    let d_value = col * d_max;
    write_uint(&mut p[channel * size..], size, d_value as u64);
}

/// `writeToSignedChannel`
fn write_to_signed_channel(p: &mut [u8], size: usize, channel: usize, col: f64) {
    let d_max = ((1u64 << (size * 8 - 1)) - 1) as f64;
    let d_value = col * d_max;
    write_uint(&mut p[channel * size..], size, d_value as i64 as u64);
}

/// `write3Channel` / `write4Channel` - `sizes[i]` bits at offset `offs[i]` for channel `i`, or'ed into the packed word of `size` bytes.
fn write_packed_channel(
    p: &mut [u8],
    size: usize,
    sizes: &[u32],
    offs: &[u32],
    channel: i32,
    col: f64,
) -> Result<(), TestError> {
    let index = usize::try_from(channel)
        .ok()
        .filter(|&index| index < sizes.len())
        .ok_or_else(|| TestError::Fail("Invalid channel".to_string()))?;
    let max = (1u64 << sizes[index]) - 1;
    let mask = max;
    let off = offs[index];

    let d_value = col * max as f64;
    let t_value = d_value as u64;

    let result = (t_value & mask) << off;
    let current = read_uint(p, size);
    write_uint(p, size, current | result);
    Ok(())
}

/// The bits of `tcu::Float<uint32_t, exponent_bits, mantissa_bits, bias, FLOAT_SUPPORT_DENORM>` for a non-negative value that is zero or a normal number the format holds exactly.
fn unsigned_small_float_bits(value: f64, mantissa_bits: u32, bias: i32) -> u32 {
    if value == 0.0 {
        return 0;
    }
    let exponent = value.log2().floor() as i32;
    let mantissa = ((value / 2.0f64.powi(exponent) - 1.0) * f64::from(1u32 << mantissa_bits)).round() as u32;
    (((exponent + bias) as u32) << mantissa_bits) | mantissa
}

/// `write11F_11F_10F_Channel`
fn write_11f_11f_10f_channel(p: &mut [u8], channel: i32, col: f64) -> Result<(), TestError> {
    let current = read_uint(p, 4) as u32;
    let bits = match channel {
        0 => unsigned_small_float_bits(col, 6, 15),
        1 => unsigned_small_float_bits(col, 6, 15) << 11,
        2 => unsigned_small_float_bits(col, 5, 15) << 22,
        _ => return Err(TestError::Fail("Invalid channel".to_string())),
    };
    write_uint(p, 4, u64::from(current | bits));
    Ok(())
}

/// `writeChannel`
fn write_channel(type_: GLenum, p: &mut [u8], channel: i32, col: f64) -> Result<(), TestError> {
    let ch = channel as usize;
    match type_ {
        glw::GL_UNSIGNED_BYTE => write_to_unsigned_channel(p, 1, ch, col),
        glw::GL_BYTE => write_to_signed_channel(p, 1, ch, col),
        glw::GL_UNSIGNED_SHORT => write_to_unsigned_channel(p, 2, ch, col),
        glw::GL_UNSIGNED_SHORT_5_6_5 => write_packed_channel(p, 2, &[5, 6, 5], &[11, 5, 0], channel, col)?,
        glw::GL_SHORT => write_to_signed_channel(p, 2, ch, col),
        glw::GL_UNSIGNED_INT => write_to_unsigned_channel(p, 4, ch, col),
        glw::GL_UNSIGNED_INT_2_10_10_10_REV => {
            write_packed_channel(p, 4, &[2, 10, 10, 10], &[30, 20, 10, 0], 3 - channel, col)?
        }
        glw::GL_UNSIGNED_INT_10F_11F_11F_REV => write_11f_11f_10f_channel(p, channel, col)?,
        glw::GL_UNSIGNED_SHORT_4_4_4_4 => write_packed_channel(p, 2, &[4, 4, 4, 4], &[12, 8, 4, 0], channel, col)?,
        glw::GL_UNSIGNED_SHORT_5_5_5_1 => write_packed_channel(p, 2, &[5, 5, 5, 1], &[11, 6, 1, 0], channel, col)?,
        glw::GL_INT => write_to_signed_channel(p, 4, ch, col),
        glw::GL_HALF_FLOAT => p[ch * 2..ch * 2 + 2].copy_from_slice(&Float16::new(col as f32).bits().to_ne_bytes()),
        glw::GL_FLOAT => p[ch * 4..ch * 4 + 4].copy_from_slice(&(col as f32).to_ne_bytes()),
        _ => return Err(TestError::Fail("Invalid type".to_string())),
    }
    Ok(())
}

/// `writePixel`
fn write_pixel(format: &TexFormat, p: &mut [u8], col: f64) -> Result<(), TestError> {
    for ch in 0..format.num_channels {
        write_channel(format.type_, p, ch, if ch == 3 { 1.0 } else { col })?;
    }
    Ok(())
}

fn uniform_location(gl: &glw::Functions, program: &ShaderProgram<'_>, name: &std::ffi::CStr) -> glw::GLint {
    // SAFETY: a linked program and a NUL-terminated name.
    unsafe { gl.get_uniform_location(program.program(), name.as_ptr()) }
}

/// `setUnsignedRefcolour<T>` with `T`'s maximum value given.
fn set_unsigned_refcolour(gl: &glw::Functions, program: &ShaderProgram<'_>, format: &TexFormat, max: f64, col: f64) {
    let t_value = (max * col) as u32;
    let refcol: [u32; 4] = [
        if format.num_channels > 0 { t_value } else { 0 },
        if format.num_channels > 1 { t_value } else { 0 },
        if format.num_channels > 2 { t_value } else { 0 },
        255,
    ];
    // SAFETY: four GLuints for a uvec4 uniform.
    unsafe { gl.uniform_4uiv(uniform_location(gl, program, c"refcolour"), 1, refcol.as_ptr()) };
}

/// `setSignedRefcolour<T>`, `max` being `T(-1) >> 1` for the unsigned `T` upstream instantiates it with.
fn set_signed_refcolour(gl: &glw::Functions, program: &ShaderProgram<'_>, format: &TexFormat, max: f64, col: f64) {
    let t_value = (max * col) as u32 as i32;
    let refcol: [i32; 4] = [
        if format.num_channels > 0 { t_value } else { 0 },
        if format.num_channels > 1 { t_value } else { 0 },
        if format.num_channels > 2 { t_value } else { 0 },
        255,
    ];
    // SAFETY: four GLints for an ivec4 uniform.
    unsafe { gl.uniform_4iv(uniform_location(gl, program, c"refcolour"), 1, refcol.as_ptr()) };
}

/// `setRefcolour`
fn set_refcolour(
    gl: &glw::Functions,
    program: &ShaderProgram<'_>,
    format: &TexFormat,
    col: f64,
) -> Result<(), TestError> {
    match format.format {
        glw::GL_RED | glw::GL_RG | glw::GL_RGB | glw::GL_RGBA => {
            let channel = |index: i32| if format.num_channels > index { col as f32 } else { 0.0 };
            // SAFETY: a plain uniform write on the program in use.
            unsafe {
                gl.uniform_4f(
                    uniform_location(gl, program, c"refcolour"),
                    channel(0),
                    channel(1),
                    channel(2),
                    1.0,
                )
            };
        }
        _ => match format.type_ {
            glw::GL_UNSIGNED_BYTE => set_unsigned_refcolour(gl, program, format, 255.0, col),
            glw::GL_BYTE => set_signed_refcolour(gl, program, format, 127.0, col),
            glw::GL_UNSIGNED_SHORT
            | glw::GL_UNSIGNED_SHORT_5_6_5
            | glw::GL_UNSIGNED_SHORT_4_4_4_4
            | glw::GL_UNSIGNED_SHORT_5_5_5_1 => set_unsigned_refcolour(gl, program, format, 65535.0, col),
            glw::GL_SHORT => set_signed_refcolour(gl, program, format, 32767.0, col),
            glw::GL_UNSIGNED_INT => set_unsigned_refcolour(gl, program, format, 4294967295.0, col),
            // `setRGB10A2Refcolour`
            glw::GL_UNSIGNED_INT_2_10_10_10_REV => set_unsigned_refcolour(gl, program, format, 1023.0, col),
            glw::GL_INT => set_signed_refcolour(gl, program, format, 2147483647.0, col),
            _ => return Err(TestError::Fail("Invalid type".to_string())),
        },
    }
    Ok(())
}

/// `TexImageUtils::verify` - every pixel green; the error mask upstream builds is only for the log images.
fn verify(dst: &Surface) -> bool {
    for y in 0..dst.get_height() {
        for x in 0..dst.get_width() {
            if dst.get_pixel(x, y) != RGBA::green() {
                return false;
            }
        }
    }
    true
}

/// Fills the shader parameters both flavours share and builds the program.
fn build_program<'gl>(gl: &'gl glw::Functions, params: &[(&str, String)]) -> Result<ShaderProgram<'gl>, TestError> {
    let vs = StringTemplate::new(VS_TEMPLATE_SRC).specialize(params)?;
    let fs = StringTemplate::new(FS_TEMPLATE_SRC).specialize(params)?;

    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vs, fs));
    if !program.is_ok() {
        return Err(TestError::Fail("Shader creation failed".to_string()));
    }

    // SAFETY: a program that built.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1i(uniform_location(gl, &program, c"sampler"), 0);
    }
    Ok(program)
}

/// The first half of every `renderToSurf`: clear and viewport.
fn begin_render(gl: &glw::Functions, w: i32, h: i32) {
    // SAFETY: plain state setters.
    unsafe {
        gl.clear_color(0.3, 0.3, 0.3, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
        gl.viewport(0, 0, w, h);
    }
}

/// The second half: draw the quad and read the sub-cuboid sized rectangle back.
fn end_render(context: &Context, program: &ShaderProgram<'_>, w: i32, h: i32) -> Result<Surface, TestError> {
    let vertex_positions: [f32; 12] = [-1.0, -1.0, -1.0, 1.0, -1.0, 0.0, -1.0, 1.0, 0.0, 1.0, 1.0, 1.0];
    let indices: [u16; 6] = [0, 1, 2, 2, 1, 3];
    let attr_bindings = [va::float("pos", 3, 4, 0, &vertex_positions)];

    glu::draw(
        &context.render_context,
        program.program(),
        &attr_bindings,
        &pr::triangles(&indices),
    )?;

    let mut dst = Surface::new(w, h);
    glu::read_pixels(&context.render_context, 0, 0, &mut dst.get_access())?;
    Ok(dst)
}

fn pass_status(pass: bool) -> TestOutcome {
    Ok(if pass {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

fn sampler_params(format: &TexFormat) -> (&'static str, &'static str) {
    match format.format {
        glw::GL_RED_INTEGER | glw::GL_RG_INTEGER | glw::GL_RGB_INTEGER | glw::GL_RGBA_INTEGER => match format.type_ {
            glw::GL_BYTE | glw::GL_SHORT | glw::GL_INT => ("isampler", "ivec4"),
            _ => ("usampler", "uvec4"),
        },
        _ => ("sampler", "vec4"),
    }
}

/// `TexImage2DCase`
struct TexImage2DCase {
    name: String,
    internal_format: GLenum,
    cuboid: Cuboid,
    glsl_version: GlslVersion,
}

impl TestCase for TexImage2DCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let c = self.cuboid;
        let format = describe_format(self.internal_format)?;

        // generateSrcData
        let mut src_data = vec![0u8; c.cuboid_w as usize * c.cuboid_h as usize * format.pixel_size];
        for y in 0..c.cuboid_h {
            for x in 0..c.cuboid_w {
                let col = if inrange(y, c.subcuboid_y0, c.subcuboid_y0 + c.subcuboid_h)
                    && inrange(x, c.subcuboid_x0, c.subcuboid_x0 + c.subcuboid_w)
                {
                    1.0
                } else {
                    0.0
                };
                let offset = y as usize * c.cuboid_w as usize * format.pixel_size + x as usize * format.pixel_size;
                write_pixel(&format, &mut src_data[offset..], col)?;
            }
        }

        // createTexture
        let texture = glu::Texture::new(gl);
        // SAFETY: `src_data` holds the whole cuboid, of which the unpack state selects the sub-rectangle.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D, texture.get());
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);

            gl.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, c.cuboid_w);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, c.subcuboid_y0);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, c.subcuboid_x0);

            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                self.internal_format as i32,
                c.subcuboid_w,
                c.subcuboid_h,
                0,
                format.format,
                format.type_,
                src_data.as_ptr().cast(),
            );

            gl.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, 0);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, 0);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, 0);
        }

        // createShader
        let (sampler_prefix, col_type) = sampler_params(&format);
        let params = [
            ("GLSL_VERSION", self.glsl_version.declaration().to_string()),
            ("TEXCOORDS_TYPE", "vec2".to_string()),
            ("LAYER", String::new()),
            ("TEXCOORDS", "pos.xy".to_string()),
            ("CONDITION", "colour.rgb == refcolour.rgb".to_string()),
            ("SAMPLER_TYPE", format!("{sampler_prefix}2D")),
            ("COL_TYPE", col_type.to_string()),
        ];
        let program = build_program(gl, &params)?;

        // renderToSurf
        begin_render(gl, c.subcuboid_w, c.subcuboid_h);
        set_refcolour(gl, &program, &format, 1.0)?;
        let dst = end_render(context, &program, c.subcuboid_w, c.subcuboid_h)?;

        let pass = verify(&dst);
        log::info!("Image is {}", if pass { "valid" } else { "invalid" });
        pass_status(pass)
    }
}

/// `TexImage3DCase`
struct TexImage3DCase {
    name: String,
    internal_format: GLenum,
    cuboid: Cuboid,
    glsl_version: GlslVersion,
}

impl TestCase for TexImage3DCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let c = self.cuboid;
        let format = describe_format(self.internal_format)?;

        // generateSrcData
        let mut src_data =
            vec![0u8; c.cuboid_w as usize * c.cuboid_h as usize * c.cuboid_d as usize * format.pixel_size];
        for z in 0..c.cuboid_d {
            for y in 0..c.cuboid_h {
                for x in 0..c.cuboid_w {
                    let col = if inrange(z, c.subcuboid_z0, c.subcuboid_z0 + c.subcuboid_d)
                        && inrange(y, c.subcuboid_y0, c.subcuboid_y0 + c.subcuboid_h)
                        && inrange(x, c.subcuboid_x0, c.subcuboid_x0 + c.subcuboid_w)
                    {
                        0.125 + f64::from(z - c.subcuboid_z0) * 0.125 /* [0.125, 0.250..1.0] */
                    } else {
                        0.0
                    };
                    let offset = z as usize * c.cuboid_h as usize * c.cuboid_w as usize * format.pixel_size
                        + y as usize * c.cuboid_w as usize * format.pixel_size
                        + x as usize * format.pixel_size;
                    write_pixel(&format, &mut src_data[offset..], col)?;
                }
            }
        }

        // createTexture
        let texture = glu::Texture::new(gl);
        // SAFETY: `src_data` holds the whole cuboid, of which the unpack state selects the sub-cuboid.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, texture.get());
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_MIN_FILTER,
                glw::GL_NEAREST as i32,
            );
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_MAG_FILTER,
                glw::GL_NEAREST as i32,
            );

            gl.pixel_storei(glw::GL_UNPACK_IMAGE_HEIGHT, c.cuboid_h);
            gl.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, c.cuboid_w);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_IMAGES, c.subcuboid_z0);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, c.subcuboid_y0);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, c.subcuboid_x0);

            gl.tex_image_3d(
                glw::GL_TEXTURE_2D_ARRAY,
                0,
                self.internal_format as i32,
                c.subcuboid_w,
                c.subcuboid_h,
                c.subcuboid_d,
                0,
                format.format,
                format.type_,
                src_data.as_ptr().cast(),
            );

            gl.pixel_storei(glw::GL_UNPACK_IMAGE_HEIGHT, 0);
            gl.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, 0);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_IMAGES, 0);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, 0);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, 0);
        }

        // createShader
        let (sampler_prefix, col_type) = sampler_params(&format);
        let condition = match format.format {
            glw::GL_RED_INTEGER | glw::GL_RG_INTEGER | glw::GL_RGB_INTEGER | glw::GL_RGBA_INTEGER => match format.type_
            {
                glw::GL_BYTE | glw::GL_SHORT | glw::GL_INT => {
                    "all(lessThan(uvec4(abs(colour - refcolour)).rgb, uvec3(2u)))".to_string()
                }
                _ => "all(lessThan(uvec4(abs(ivec4(colour) - ivec4(refcolour))).rgb, uvec3(2u)))".to_string(),
            },
            _ => format!(
                "all(lessThan((abs(colour - refcolour)).rgb, vec3({:.6})))",
                get_eps(self.internal_format)?
            ),
        };
        let params = [
            ("GLSL_VERSION", self.glsl_version.declaration().to_string()),
            ("TEXCOORDS_TYPE", "vec3".to_string()),
            ("LAYER", "uniform int layer;".to_string()),
            ("TEXCOORDS", "vec3(pos.xy, layer)".to_string()),
            ("SAMPLER_TYPE", format!("{sampler_prefix}2DArray")),
            ("COL_TYPE", col_type.to_string()),
            ("CONDITION", condition),
        ];
        let program = build_program(gl, &params)?;

        let mut pass = true;
        for z in 0..c.subcuboid_d {
            // renderToSurf
            begin_render(gl, c.subcuboid_w, c.subcuboid_h);
            // SAFETY: a plain uniform write on the program in use.
            unsafe { gl.uniform_1i(uniform_location(gl, &program, c"layer"), z) };
            let refcol: f32 = 0.125 + z as f32 * 0.125;
            set_refcolour(gl, &program, &format, f64::from(refcol))?;
            let dst = end_render(context, &program, c.subcuboid_w, c.subcuboid_h)?;

            let layer_pass = verify(&dst);
            log::info!("Layer {z} is {}", if layer_pass { "valid" } else { "invalid" });
            pass &= layer_pass;
        }

        log::info!("Image is {}", if pass { "valid" } else { "invalid" });
        pass_status(pass)
    }
}

/// The block geometry and the extension a compressed format needs; the `switch` at the top of the compressed cases' `iterate`.
struct BlockInfo {
    bw: i32,
    bh: i32,
    bd: i32,
    bs: i32,
    extension: &'static str,
}

fn block_info(internal_format: GLenum) -> Result<BlockInfo, TestError> {
    match internal_format {
        glw::GL_COMPRESSED_RGB_S3TC_DXT1_EXT => Ok(BlockInfo {
            bw: 4,
            bh: 4,
            bd: 1,
            bs: 8,
            extension: "GL_EXT_texture_compression_s3tc",
        }),
        glw::GL_COMPRESSED_RGBA_ASTC_8x5_KHR => Ok(BlockInfo {
            bw: 8,
            bh: 5,
            bd: 1,
            bs: 16,
            extension: "GL_KHR_texture_compression_astc_ldr",
        }),
        _ => Err(TestError::Fail("Invalid internal format".to_string())),
    }
}

fn check_compressed_support(context: &Context, internal_format: GLenum) -> Result<(), TestError> {
    if !context.context_type().supports_core(4, 2)
        && !context
            .context_info
            .is_extension_supported("GL_ARB_compressed_texture_pixel_storage")
    {
        return Err(TestError::NotSupported(
            "GL_ARB_compressed_texture_pixel_storage extension is not supported".to_string(),
        ));
    }
    let info = block_info(internal_format)?;
    if !context.context_info.is_extension_supported(info.extension) {
        return Err(TestError::NotSupported(format!(
            "{} extension is not supported",
            info.extension
        )));
    }
    Ok(())
}

/// `CompressedTexImageUtils::getImageSize`
fn get_image_size(info: &BlockInfo, width: i32, height: i32, depth: i32) -> i32 {
    (width / info.bw + i32::from(width % info.bw > 0))
        * (height / info.bh + i32::from(height % info.bh > 0))
        * (depth / info.bd + i32::from(depth % info.bd > 0))
        * info.bs
}

fn blocks_to_bytes(blocks: &[u64]) -> Vec<u8> {
    blocks.iter().flat_map(|block| block.to_ne_bytes()).collect()
}

/// Number of blocks along an axis, rounded up.
fn block_count(size: i32, block: i32) -> i32 {
    size / block + i32::from(size % block > 0)
}

const ASTC_MASK: u64 = 0xffff_ffff_ffff_fdfc;

/// `CompressedTexImage2DCase::generateSrcData_s3tc`
fn generate_src_data_2d_s3tc(c: &Cuboid, info: &BlockInfo) -> Vec<u8> {
    let mut src = vec![0u64; (c.cuboid_w / info.bw * c.cuboid_h / info.bh) as usize];
    for y in (0..c.cuboid_h).step_by(info.bh as usize) {
        for x in (0..c.cuboid_w).step_by(info.bw as usize) {
            let col = if inrange(x, c.subcuboid_x0, c.subcuboid_x0 + c.subcuboid_w)
                && inrange(y, c.subcuboid_y0, c.subcuboid_y0 + c.subcuboid_h)
            {
                0xffff
            } else {
                0x0
            };
            let index = (y / info.bh) * (c.cuboid_w / info.bw) + (x / info.bw);
            src[index as usize] = col;
        }
    }
    blocks_to_bytes(&src)
}

/// `CompressedTexImage2DCase::generateSrcData_astc`
fn generate_src_data_2d_astc(c: &Cuboid, info: &BlockInfo) -> Vec<u8> {
    let img_size = 2 * block_count(c.cuboid_w, info.bw) * block_count(c.cuboid_h, info.bh);
    let mut src = vec![0u64; img_size as usize];
    for y in (0..c.cuboid_h).step_by(info.bh as usize) {
        for x in (0..c.cuboid_w).step_by(info.bw as usize) {
            let col = if inrange(x, c.subcuboid_x0, c.subcuboid_x0 + c.subcuboid_w)
                && inrange(y, c.subcuboid_y0, c.subcuboid_y0 + c.subcuboid_h)
            {
                0xffff_ffff_ffff_ffff /* (1.0, 1.0, 1.0) */
            } else {
                0x0 /* (0.0, 0.0, 0.0) */
            };
            let index = (y / info.bh) * block_count(c.cuboid_w, info.bw) + (x / info.bw);
            src[2 * index as usize] = ASTC_MASK;
            src[2 * index as usize + 1] = col;
        }
    }
    blocks_to_bytes(&src)
}

/// `CompressedTexImage3DCase::generateSrcData_s3tc`
fn generate_src_data_3d_s3tc(c: &Cuboid, info: &BlockInfo) -> Vec<u8> {
    let mut src = vec![0u64; (c.cuboid_w / info.bw * c.cuboid_h / info.bh * c.cuboid_d / info.bd) as usize];
    let col_list: [u64; 8] = [
        0x18E3, /* (0.125, 0.125, 0.125) */
        0x39E7, /* (0.250, 0.250, 0.250) */
        0x5AEB, /* (0.375, 0.375, 0.375) */
        0x7BEF, /* (0.500, 0.500, 0.500) */
        0x9CF3, /* (0.625, 0.625, 0.625) */
        0xBDF7, /* (0.750, 0.750, 0.750) */
        0xDEFB, /* (0.875, 0.875, 0.875) */
        0xffff, /* (1.000, 1.000, 1.000) */
    ];
    for z in (0..c.cuboid_d).step_by(info.bd as usize) {
        for y in (0..c.cuboid_h).step_by(info.bh as usize) {
            for x in (0..c.cuboid_w).step_by(info.bw as usize) {
                let col = if inrange(x, c.subcuboid_x0, c.subcuboid_x0 + c.subcuboid_w)
                    && inrange(y, c.subcuboid_y0, c.subcuboid_y0 + c.subcuboid_h)
                    && inrange(z, c.subcuboid_z0, c.subcuboid_z0 + c.subcuboid_d)
                {
                    col_list[(z % 8) as usize]
                } else {
                    0x0
                };
                let index = (z / info.bd) * (c.cuboid_h / info.bh) * (c.cuboid_w / info.bw)
                    + (y / info.bh) * (c.cuboid_w / info.bw)
                    + (x / info.bw);
                src[index as usize] = col;
            }
        }
    }
    blocks_to_bytes(&src)
}

/// `CompressedTexImage3DCase::generateSrcData_astc`
fn generate_src_data_3d_astc(c: &Cuboid, info: &BlockInfo) -> Vec<u8> {
    let col_list: [u64; 8] = [
        0xffff_1fff_1fff_1fff, /* (0.125, 0.125, 0.125) */
        0xffff_3fff_3fff_3fff, /* (0.250, 0.250, 0.250) */
        0xffff_5fff_5fff_5fff, /* (0.375, 0.375, 0.375) */
        0xffff_7fff_7fff_7fff, /* (0.500, 0.500, 0.500) */
        0xffff_9fff_9fff_9fff, /* (0.625, 0.625, 0.625) */
        0xffff_bfff_bfff_bfff, /* (0.750, 0.750, 0.750) */
        0xffff_dfff_dfff_dfff, /* (0.875, 0.875, 0.875) */
        0xffff_ffff_ffff_ffff, /* (1.000, 1.000, 1.000) */
    ];
    let img_size =
        2 * block_count(c.cuboid_w, info.bw) * block_count(c.cuboid_h, info.bh) * block_count(c.cuboid_d, info.bd);
    let mut src = vec![0u64; img_size as usize];
    for z in (0..c.cuboid_d).step_by(info.bd as usize) {
        for y in (0..c.cuboid_h).step_by(info.bh as usize) {
            for x in (0..c.cuboid_w).step_by(info.bw as usize) {
                let col = if inrange(x, c.subcuboid_x0, c.subcuboid_x0 + c.subcuboid_w)
                    && inrange(y, c.subcuboid_y0, c.subcuboid_y0 + c.subcuboid_h)
                    && inrange(z, c.subcuboid_z0, c.subcuboid_z0 + c.subcuboid_d)
                {
                    col_list[(z % 8) as usize]
                } else {
                    0x0
                };
                let index = (z / info.bd) * block_count(c.cuboid_h, info.bh) * block_count(c.cuboid_w, info.bw)
                    + (y / info.bh) * block_count(c.cuboid_w, info.bw)
                    + (x / info.bw);
                src[2 * index as usize] = ASTC_MASK;
                src[2 * index as usize + 1] = col;
            }
        }
    }
    blocks_to_bytes(&src)
}

/// `CompressedTexImage2DCase`
struct CompressedTexImage2DCase {
    name: String,
    internal_format: GLenum,
    cuboid: Cuboid,
    glsl_version: GlslVersion,
}

impl TestCase for CompressedTexImage2DCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_compressed_support(context, self.internal_format)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let c = self.cuboid;
        let info = block_info(self.internal_format)?;

        let src_data = match self.internal_format {
            glw::GL_COMPRESSED_RGB_S3TC_DXT1_EXT => generate_src_data_2d_s3tc(&c, &info),
            _ => generate_src_data_2d_astc(&c, &info),
        };

        // createTexture
        let texture = glu::Texture::new(gl);
        // SAFETY: `src_data` holds the whole cuboid in blocks, of which the unpack state selects the sub-rectangle.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D, texture.get());
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);

            gl.pixel_storei(glw::GL_UNPACK_COMPRESSED_BLOCK_SIZE, info.bs);
            gl.pixel_storei(glw::GL_UNPACK_COMPRESSED_BLOCK_WIDTH, info.bw);
            gl.pixel_storei(glw::GL_UNPACK_COMPRESSED_BLOCK_HEIGHT, info.bh);
            gl.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, c.cuboid_w);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, c.subcuboid_y0);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, c.subcuboid_x0);

            gl.compressed_tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                self.internal_format,
                c.subcuboid_w,
                c.subcuboid_h,
                0,
                get_image_size(&info, c.subcuboid_w, c.subcuboid_h, c.subcuboid_d),
                src_data.as_ptr().cast(),
            );

            gl.pixel_storei(glw::GL_UNPACK_COMPRESSED_BLOCK_SIZE, 0);
            gl.pixel_storei(glw::GL_UNPACK_COMPRESSED_BLOCK_WIDTH, 0);
            gl.pixel_storei(glw::GL_UNPACK_COMPRESSED_BLOCK_HEIGHT, 0);
            gl.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, 0);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, 0);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, 0);
        }

        // createShader
        let params = [
            ("GLSL_VERSION", self.glsl_version.declaration().to_string()),
            ("TEXCOORDS_TYPE", "vec2".to_string()),
            ("LAYER", String::new()),
            ("TEXCOORDS", "pos.xy".to_string()),
            ("SAMPLER_TYPE", "sampler2D".to_string()),
            ("COL_TYPE", "vec4".to_string()),
            ("CONDITION", "colour.rgb == refcolour.rgb".to_string()),
        ];
        let program = build_program(gl, &params)?;

        // renderToSurf
        begin_render(gl, c.subcuboid_w, c.subcuboid_h);
        let refcol: f32 = 1.0;
        // SAFETY: a plain uniform write on the program in use.
        unsafe {
            gl.uniform_4f(
                uniform_location(gl, &program, c"refcolour"),
                refcol,
                refcol,
                refcol,
                1.0,
            )
        };
        let dst = end_render(context, &program, c.subcuboid_w, c.subcuboid_h)?;

        let pass = verify(&dst);
        log::info!("Image is {}", if pass { "valid" } else { "invalid" });
        pass_status(pass)
    }
}

/// `CompressedTexImage3DCase`
struct CompressedTexImage3DCase {
    name: String,
    internal_format: GLenum,
    cuboid: Cuboid,
    glsl_version: GlslVersion,
}

impl TestCase for CompressedTexImage3DCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_compressed_support(context, self.internal_format)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let c = self.cuboid;
        let info = block_info(self.internal_format)?;

        let src_data = match self.internal_format {
            glw::GL_COMPRESSED_RGB_S3TC_DXT1_EXT => generate_src_data_3d_s3tc(&c, &info),
            _ => generate_src_data_3d_astc(&c, &info),
        };

        // createTexture
        let texture = glu::Texture::new(gl);
        // SAFETY: `src_data` holds the whole cuboid in blocks, of which the unpack state selects the sub-cuboid.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, texture.get());
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_MIN_FILTER,
                glw::GL_NEAREST as i32,
            );
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_MAG_FILTER,
                glw::GL_NEAREST as i32,
            );

            gl.pixel_storei(glw::GL_UNPACK_COMPRESSED_BLOCK_SIZE, info.bs);
            gl.pixel_storei(glw::GL_UNPACK_COMPRESSED_BLOCK_WIDTH, info.bw);
            gl.pixel_storei(glw::GL_UNPACK_COMPRESSED_BLOCK_HEIGHT, info.bh);
            gl.pixel_storei(glw::GL_UNPACK_COMPRESSED_BLOCK_DEPTH, info.bd);
            gl.pixel_storei(glw::GL_UNPACK_IMAGE_HEIGHT, c.cuboid_h);
            gl.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, c.cuboid_w);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_IMAGES, c.subcuboid_z0);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, c.subcuboid_y0);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, c.subcuboid_x0);

            gl.compressed_tex_image_3d(
                glw::GL_TEXTURE_2D_ARRAY,
                0,
                self.internal_format,
                c.subcuboid_w,
                c.subcuboid_h,
                c.subcuboid_d,
                0,
                get_image_size(&info, c.subcuboid_w, c.subcuboid_h, c.subcuboid_d),
                src_data.as_ptr().cast(),
            );

            gl.pixel_storei(glw::GL_UNPACK_COMPRESSED_BLOCK_SIZE, 0);
            gl.pixel_storei(glw::GL_UNPACK_COMPRESSED_BLOCK_WIDTH, 0);
            gl.pixel_storei(glw::GL_UNPACK_COMPRESSED_BLOCK_HEIGHT, 0);
            gl.pixel_storei(glw::GL_UNPACK_COMPRESSED_BLOCK_DEPTH, 0);
            gl.pixel_storei(glw::GL_UNPACK_IMAGE_HEIGHT, 0);
            gl.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, 0);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_IMAGES, 0);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, 0);
            gl.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, 0);
        }

        // createShader
        let params = [
            ("GLSL_VERSION", self.glsl_version.declaration().to_string()),
            ("TEXCOORDS_TYPE", "vec3".to_string()),
            ("LAYER", "uniform int layer;".to_string()),
            ("TEXCOORDS", "vec3(pos.xy, layer)".to_string()),
            ("SAMPLER_TYPE", "sampler2DArray".to_string()),
            ("COL_TYPE", "vec4".to_string()),
            (
                "CONDITION",
                format!(
                    "all(lessThan((abs(colour - refcolour)).rgb, vec3({:.6})))",
                    get_eps(self.internal_format)?
                ),
            ),
        ];
        let program = build_program(gl, &params)?;

        let mut pass = true;
        for z in 0..c.subcuboid_d {
            // renderToSurf
            begin_render(gl, c.subcuboid_w, c.subcuboid_h);
            // SAFETY: a plain uniform write on the program in use.
            unsafe { gl.uniform_1i(uniform_location(gl, &program, c"layer"), z) };
            let refcols: [f32; 8] = [0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1.0];
            let refcol = refcols[((z + c.subcuboid_z0 % 8) % 8) as usize];
            // SAFETY: a plain uniform write on the program in use.
            unsafe {
                gl.uniform_4f(
                    uniform_location(gl, &program, c"refcolour"),
                    refcol,
                    refcol,
                    refcol,
                    1.0,
                )
            };
            let dst = end_render(context, &program, c.subcuboid_w, c.subcuboid_h)?;

            let layer_pass = verify(&dst);
            log::info!("Layer {z} is {}", if layer_pass { "valid" } else { "invalid" });
            pass &= layer_pass;
        }

        log::info!("Image is {}", if pass { "valid" } else { "invalid" });
        pass_status(pass)
    }
}

const INTERNAL_FMTS: [(&str, GLenum); 46] = [
    ("r8", glw::GL_R8),
    ("r8snorm", glw::GL_R8_SNORM),
    ("r16f", glw::GL_R16F),
    ("r32f", glw::GL_R32F),
    ("r8ui", glw::GL_R8UI),
    ("r8i", glw::GL_R8I),
    ("r16ui", glw::GL_R16UI),
    ("r16i", glw::GL_R16I),
    ("r32ui", glw::GL_R32UI),
    ("r32i", glw::GL_R32I),
    ("rg8", glw::GL_RG8),
    ("rg8snorm", glw::GL_RG8_SNORM),
    ("rg16f", glw::GL_RG16F),
    ("rg32f", glw::GL_RG32F),
    ("rg8ui", glw::GL_RG8UI),
    ("rg8i", glw::GL_RG8I),
    ("rg16ui", glw::GL_RG16UI),
    ("rg16i", glw::GL_RG16I),
    ("rg32ui", glw::GL_RG32UI),
    ("rg32i", glw::GL_RG32I),
    ("rgb8", glw::GL_RGB8),
    ("rgb565", glw::GL_RGB565),
    ("rgb8snorm", glw::GL_RGB8_SNORM),
    ("r11g11b10f", glw::GL_R11F_G11F_B10F),
    ("rgb16f", glw::GL_RGB16F),
    ("rgb32f", glw::GL_RGB32F),
    ("rgb8ui", glw::GL_RGB8UI),
    ("rgb8i", glw::GL_RGB8I),
    ("rgb16ui", glw::GL_RGB16UI),
    ("rgb16i", glw::GL_RGB16I),
    ("rgb32ui", glw::GL_RGB32UI),
    ("rgb32i", glw::GL_RGB32I),
    ("rgba8", glw::GL_RGBA8),
    ("rgba8snorm", glw::GL_RGBA8_SNORM),
    ("rgb5a1", glw::GL_RGB5_A1),
    ("rgba4", glw::GL_RGBA4),
    ("rgb10a2", glw::GL_RGB10_A2),
    ("rgba16f", glw::GL_RGBA16F),
    ("rgba32f", glw::GL_RGBA32F),
    ("rgba8ui", glw::GL_RGBA8UI),
    ("rgba8i", glw::GL_RGBA8I),
    ("rgb10a2ui", glw::GL_RGB10_A2UI),
    ("rgba16ui", glw::GL_RGBA16UI),
    ("rgba16i", glw::GL_RGBA16I),
    ("rgba32i", glw::GL_RGBA32I),
    ("rgba32ui", glw::GL_RGBA32UI),
];

const INTERNAL_FMTS_COMPRESSED: [(&str, GLenum, i32, i32, i32); 2] = [
    ("rgb_s3tc_dxt1", glw::GL_COMPRESSED_RGB_S3TC_DXT1_EXT, 4, 4, 1),
    ("rgba_astc_8x5", glw::GL_COMPRESSED_RGBA_ASTC_8x5_KHR, 8, 5, 1),
];

/// `PixelStorageModesTests::init`
pub fn create_tests(glsl_version: GlslVersion) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("pixelstoragemodes");

    let cuboid_w = 64;
    let cuboid_h = 64;
    let cuboid_d = 64;
    let subcuboid_w = 32;
    let subcuboid_h = 32;
    let subcuboid_d = 8;

    let mut tex_image_2d_group = TestCaseGroup::new("teximage2d");
    for (name, internal_fmt) in INTERNAL_FMTS {
        let mut formats_group = TestCaseGroup::new(name);
        let (bw, bh) = (1, 1);
        let skip_pixels = [0, bw, bw * (subcuboid_w / (2 * bw))];
        let skip_rows = [0, bh, bh * (subcuboid_h / (2 * bh))];

        for r in 0..3 {
            for p in r..3 {
                let skip_name = format!("{}_{}", skip_pixels[p], skip_rows[r]);
                formats_group.add_child(Box::new(TexImage2DCase {
                    name: skip_name,
                    internal_format: internal_fmt,
                    cuboid: Cuboid {
                        cuboid_w,
                        cuboid_h,
                        cuboid_d: 1,
                        subcuboid_x0: skip_pixels[p],
                        subcuboid_y0: skip_rows[r],
                        subcuboid_z0: 0,
                        subcuboid_w,
                        subcuboid_h,
                        subcuboid_d: 1,
                    },
                    glsl_version,
                }) as Box<dyn TestCase>);
            }
        }
        tex_image_2d_group.add_child(formats_group);
    }
    group.add_child(tex_image_2d_group);

    let mut tex_image_3d_group = TestCaseGroup::new("teximage3d");
    for (name, internal_fmt) in INTERNAL_FMTS {
        let mut formats_group = TestCaseGroup::new(name);
        let (bw, bh, bd) = (1, 1, 1);
        let skip_pixels = [0, bw, bw * (subcuboid_w / (2 * bw))];
        let skip_rows = [0, bh, bh * (subcuboid_h / (2 * bh))];
        let skip_images = [0, bd, bd * (subcuboid_d / (2 * bd))];

        for i in 0..3 {
            for r in i..3 {
                for p in r..3 {
                    let skip_name = format!("{}_{}_{}", skip_pixels[p], skip_rows[r], skip_images[i]);
                    formats_group.add_child(Box::new(TexImage3DCase {
                        name: skip_name,
                        internal_format: internal_fmt,
                        cuboid: Cuboid {
                            cuboid_w,
                            cuboid_h,
                            cuboid_d,
                            subcuboid_x0: skip_pixels[p],
                            subcuboid_y0: skip_rows[r],
                            subcuboid_z0: skip_images[i],
                            subcuboid_w,
                            subcuboid_h,
                            subcuboid_d,
                        },
                        glsl_version,
                    }) as Box<dyn TestCase>);
                }
            }
        }
        tex_image_3d_group.add_child(formats_group);
    }
    group.add_child(tex_image_3d_group);

    let mut compressed_tex_image_2d_group = TestCaseGroup::new("compressedteximage2d");
    for (name, internal_fmt, bw, bh, _bd) in INTERNAL_FMTS_COMPRESSED {
        let mut formats_group = TestCaseGroup::new(name);
        let skip_pixels = [0, bw, bw * (subcuboid_w / (2 * bw)), bw * (subcuboid_w / bw)];
        let skip_rows = [0, bh, bh * (subcuboid_h / (2 * bh)), bh * (subcuboid_h / bh)];
        for r in 0..4 {
            for p in 0..4 {
                let skip_name = format!("{}_{}", skip_pixels[p], skip_rows[r]);
                formats_group.add_child(Box::new(CompressedTexImage2DCase {
                    name: skip_name,
                    internal_format: internal_fmt,
                    cuboid: Cuboid {
                        cuboid_w,
                        cuboid_h,
                        cuboid_d: 1,
                        subcuboid_x0: skip_pixels[p],
                        subcuboid_y0: skip_rows[r],
                        subcuboid_z0: 0,
                        subcuboid_w,
                        subcuboid_h,
                        subcuboid_d: 1,
                    },
                    glsl_version,
                }) as Box<dyn TestCase>);
            }
        }
        compressed_tex_image_2d_group.add_child(formats_group);
    }
    group.add_child(compressed_tex_image_2d_group);

    let mut compressed_tex_image_3d_group = TestCaseGroup::new("compressedteximage3d");
    for (name, internal_fmt, bw, bh, bd) in INTERNAL_FMTS_COMPRESSED {
        let mut formats_group = TestCaseGroup::new(name);
        let skip_pixels = [0, bw, bw * (subcuboid_w / (2 * bw)), bw * (subcuboid_w / bw)];
        let skip_rows = [0, bh, bh * (subcuboid_h / (2 * bh)), bh * (subcuboid_h / bh)];
        let skip_images = [0, bd, bd * (subcuboid_d / (2 * bd)), bd * (subcuboid_d / bd)];
        for i in 0..4 {
            for r in 0..4 {
                for p in 0..4 {
                    let skip_name = format!("{}_{}_{}", skip_pixels[p], skip_rows[r], skip_images[i]);
                    formats_group.add_child(Box::new(CompressedTexImage3DCase {
                        name: skip_name,
                        internal_format: internal_fmt,
                        cuboid: Cuboid {
                            cuboid_w,
                            cuboid_h,
                            cuboid_d,
                            subcuboid_x0: skip_pixels[p],
                            subcuboid_y0: skip_rows[r],
                            subcuboid_z0: skip_images[i],
                            subcuboid_w,
                            subcuboid_h,
                            subcuboid_d,
                        },
                        glsl_version,
                    }) as Box<dyn TestCase>);
                }
            }
        }
        compressed_tex_image_3d_group.add_child(formats_group);
    }
    group.add_child(compressed_tex_image_3d_group);

    group
}
