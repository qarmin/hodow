// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cCopyImageTests.cpp
//   external/openglcts/modules/gl/gl4cCopyImageTests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `CopyImage::Utils`; the per-format switch statements are in tables.rs (generated). Pixels are byte slices; channel reads and writes go through `from_ne_bytes`/`to_ne_bytes` where upstream casts the pointer. The double to half-float conversion goes through f32 (`tcu::Float16(double)` upstream). Invalid-enum failures upstream raise `TCU_FAIL` from tables nothing reaches with a bad value; here they panic.

use super::tables::{filter_formats, get_epsilon, get_number_of_channels, get_pixel_size_for_format};
use crate::glu::{self, Context};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::TestError;
use crate::tcu::float::Float16;

/// `getPixelSizeForCompatibilityVerification`
fn pixel_size_for_compatibility_verification(internal_format: GLenum) -> u32 {
    match internal_format {
        glw::GL_RGBA2 => 1,
        _ => get_pixel_size_for_format(internal_format),
    }
}

/// `Utils::areFormatsCompatible`
pub(super) fn are_formats_compatible(src: GLenum, dst: GLenum) -> bool {
    let dst_size = pixel_size_for_compatibility_verification(dst);
    let src_size = pixel_size_for_compatibility_verification(src);

    if dst_size != src_size {
        return false;
    }

    if !filter_formats(src) || !filter_formats(dst) {
        return false;
    }

    if src != dst {
        let restricted = [
            glw::GL_R3_G3_B2,
            glw::GL_RGBA2,
            glw::GL_RGBA4,
            glw::GL_RGB5_A1,
            glw::GL_RGB10,
        ];
        if restricted.contains(&dst) || restricted.contains(&src) {
            return false;
        }
    }

    if dst_size == 2 {
        if src == dst {
            return true;
        }
        if (src == glw::GL_RGB4 && dst != glw::GL_RGB4)
            || (src != glw::GL_RGB4 && dst == glw::GL_RGB4)
            || (src == glw::GL_RGB5 && dst != glw::GL_RGB5)
            || (src != glw::GL_RGB5 && dst == glw::GL_RGB5)
        {
            return false;
        }
        return true;
    }

    true
}

/// `Utils::comparePixels` (channel values)
pub(super) fn compare_pixel_channels(
    left_internal_format: GLenum,
    left: [f64; 4],
    right_internal_format: GLenum,
    right: [f64; 4],
) -> bool {
    let n_channels =
        get_number_of_channels(left_internal_format).min(get_number_of_channels(right_internal_format)) as usize;

    for i in 0..n_channels {
        let eps = get_epsilon(left_internal_format)
            .max(get_epsilon(right_internal_format))
            .abs();
        if eps < (left[i] - right[i]).abs() {
            return false;
        }
    }
    true
}

/// `Utils::comparePixels` (memcmp of the larger pixel size)
pub(super) fn compare_pixel_memory(
    left_pixel_size: u32,
    left_pixel_data: &[u8],
    right_pixel_size: u32,
    right_pixel_data: &[u8],
) -> bool {
    let pixel_size = left_pixel_size.max(right_pixel_size) as usize;
    let n = pixel_size.min(left_pixel_data.len()).min(right_pixel_data.len());
    left_pixel_data[..n] == right_pixel_data[..n]
}

/// `Utils::deleteTexture`
pub(super) fn delete_texture(context: &Context, target: GLenum, name: GLuint) {
    let gl = context.gl();
    // SAFETY: deletes one name on the current context.
    unsafe {
        if target == glw::GL_RENDERBUFFER {
            gl.delete_renderbuffers(1, &name);
        } else {
            gl.delete_textures(1, &name);
        }
    }
}

/// `Utils::isTargetMultilayer`
pub(super) fn is_target_multilayer(target: GLenum) -> bool {
    matches!(
        target,
        glw::GL_TEXTURE_1D_ARRAY
            | glw::GL_TEXTURE_2D_ARRAY
            | glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
            | glw::GL_TEXTURE_3D
            | glw::GL_TEXTURE_CUBE_MAP_ARRAY
    )
}

/// `Utils::isTargetMultilevel`
pub(super) fn is_target_multilevel(target: GLenum) -> bool {
    !matches!(
        target,
        glw::GL_TEXTURE_2D_MULTISAMPLE
            | glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
            | glw::GL_TEXTURE_RECTANGLE
            | glw::GL_RENDERBUFFER
    )
}

/// `Utils::isTargetMultisampled`
pub(super) fn is_target_multisampled(target: GLenum) -> bool {
    matches!(
        target,
        glw::GL_TEXTURE_2D_MULTISAMPLE | glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
    )
}

/// `Utils::generateTexture`
pub(super) fn generate_texture(context: &Context, target: GLenum) -> Result<GLuint, TestError> {
    let gl = context.gl();
    let mut name: GLuint = 0;

    if target == glw::GL_RENDERBUFFER {
        // SAFETY: one name out.
        unsafe { gl.gen_renderbuffers(1, &mut name) };
        glu::expect_no_error(gl, "GenRenderbuffers")?;
    } else {
        // SAFETY: one name out.
        unsafe { gl.gen_textures(1, &mut name) };
        glu::expect_no_error(gl, "GenTextures")?;
    }
    Ok(name)
}

/// `Utils::getPixelString`
pub(super) fn get_pixel_string(internal_format: GLenum, pixel: &[u8]) -> String {
    let pixel_size = get_pixel_size_for_format(internal_format) as usize;
    let mut result = String::from("0x");
    for i in (0..pixel_size.min(pixel.len())).rev() {
        result.push_str(&format!("{:02x}", pixel[i]));
    }
    result
}

/// `Utils::makeTextureComplete`
pub(super) fn make_texture_complete(
    context: &Context,
    target: GLenum,
    id: GLuint,
    base_level: GLint,
    max_level: GLint,
) -> Result<(), TestError> {
    let gl = context.gl();

    if target == glw::GL_RENDERBUFFER {
        return Ok(());
    }

    let target = trans_real_to_bind_target(trans_proxy_to_real_target(target));

    // SAFETY: texture state calls on the current context.
    unsafe { gl.bind_texture(target, id) };
    glu::expect_no_error(gl, "BindTexture")?;

    if target != glw::GL_TEXTURE_BUFFER {
        // SAFETY: as above.
        unsafe {
            gl.tex_parameteri(target, glw::GL_TEXTURE_BASE_LEVEL, base_level);
            glu::expect_no_error(gl, "TexParameteri")?;
            gl.tex_parameteri(target, glw::GL_TEXTURE_MAX_LEVEL, max_level);
            glu::expect_no_error(gl, "TexParameteri")?;
        }

        // Integer textures won't be complete with the default min filter.
        if target != glw::GL_TEXTURE_2D_MULTISAMPLE && target != glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY {
            // SAFETY: as above.
            unsafe {
                gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
                if target != glw::GL_TEXTURE_RECTANGLE {
                    gl.tex_parameteri(
                        target,
                        glw::GL_TEXTURE_MIN_FILTER,
                        glw::GL_NEAREST_MIPMAP_NEAREST as GLint,
                    );
                } else {
                    gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
                }
            }
            glu::expect_no_error(gl, "TexParameteri")?;
        }
    }

    // SAFETY: as above.
    unsafe { gl.bind_texture(target, 0) };
    glu::expect_no_error(gl, "BindTexture")
}

/// `Utils::prepareMultisampleTex`
pub(super) fn prepare_multisample_tex(context: &Context, target: GLenum, n_samples: i32) -> Result<GLuint, TestError> {
    const DEPTH: GLint = 6;
    const HEIGHT: GLint = 16;
    const WIDTH: GLint = 16;
    let gl = context.gl();
    let mut name: GLuint = 0;

    // SAFETY: one name out.
    unsafe { gl.gen_textures(1, &mut name) };
    glu::expect_no_error(gl, "GenTextures")?;

    match target {
        glw::GL_TEXTURE_2D_MULTISAMPLE => {
            // SAFETY: texture state calls on the current context.
            unsafe { gl.bind_texture(target, name) };
            glu::expect_no_error(gl, "BindTexture")?;
            // SAFETY: as above.
            unsafe { gl.tex_image_2d_multisample(target, n_samples, glw::GL_RGBA8, WIDTH, HEIGHT, glw::FALSE) };
            glu::expect_no_error(gl, "TexImage2DMultisample")?;
        }
        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => {
            // SAFETY: as above.
            unsafe { gl.bind_texture(target, name) };
            glu::expect_no_error(gl, "BindTexture")?;
            // SAFETY: as above.
            unsafe { gl.tex_image_3d_multisample(target, n_samples, glw::GL_RGBA8, WIDTH, HEIGHT, DEPTH, glw::FALSE) };
            glu::expect_no_error(gl, "TexImage3DMultisample")?;
        }
        _ => return Err(TestError::Fail("Invalid enum".to_string())),
    }

    // SAFETY: as above.
    unsafe { gl.bind_texture(target, 0) };
    glu::expect_no_error(gl, "BindTexture")?;
    Ok(name)
}

/// `Utils::prepareRenderBuffer`
pub(super) fn prepare_render_buffer(context: &Context, internal_format: GLenum) -> Result<GLuint, TestError> {
    const HEIGHT: GLint = 16;
    const WIDTH: GLint = 16;
    let gl = context.gl();
    let mut name: GLuint = 0;

    // SAFETY: one name out.
    unsafe { gl.gen_renderbuffers(1, &mut name) };
    glu::expect_no_error(gl, "GenRenderbuffers")?;

    // SAFETY: renderbuffer state calls on the current context.
    unsafe { gl.bind_renderbuffer(glw::GL_RENDERBUFFER, name) };
    glu::expect_no_error(gl, "BindRenderbuffer")?;
    // SAFETY: as above.
    unsafe { gl.renderbuffer_storage(glw::GL_RENDERBUFFER, internal_format, WIDTH, HEIGHT) };
    glu::expect_no_error(gl, "RenderbufferStorage")?;
    // SAFETY: as above.
    unsafe { gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0) };
    glu::expect_no_error(gl, "BindRenderbuffer")?;
    Ok(name)
}

/// `Utils::prepareTex16x16x6`
pub(super) fn prepare_tex_16x16x6(
    context: &Context,
    target: GLenum,
    internal_format: GLenum,
    format: GLenum,
    type_: GLenum,
    out_buf_id: &mut GLuint,
) -> Result<GLuint, TestError> {
    let name = generate_texture(context, target)?;
    prepare_texture(
        context,
        name,
        target,
        internal_format,
        format,
        type_,
        0,
        16,
        16,
        6,
        None,
        out_buf_id,
    )?;
    Ok(name)
}

/// `Utils::prepareTexture`
#[allow(clippy::too_many_arguments)]
pub(super) fn prepare_texture(
    context: &Context,
    name: GLuint,
    target: GLenum,
    internal_format: GLenum,
    format: GLenum,
    type_: GLenum,
    level: GLuint,
    width: GLuint,
    height: GLuint,
    depth: GLuint,
    pixels: Option<&[u8]>,
    out_buf_id: &mut GLuint,
) -> Result<(), TestError> {
    const BORDER: GLint = 0;
    const SAMPLES: i32 = 1;
    let gl = context.gl();
    let (level, w, h, d) = (level as GLint, width as GLint, height as GLint, depth as GLint);
    let pixel_ptr = pixels.map_or(std::ptr::null(), |p| p.as_ptr().cast::<std::ffi::c_void>());

    let mut error: GLenum = glw::GL_NO_ERROR;
    let mut function_name = "unknown";

    let mut target = trans_proxy_to_real_target(target);

    // SAFETY: every call below is made with a current context; the pixel pointer is null or a live slice sized by the caller.
    unsafe {
        match target {
            glw::GL_RENDERBUFFER => {
                gl.bind_renderbuffer(target, name);
                glu::expect_no_error(gl, "BindRenderbuffer")?;
                gl.renderbuffer_storage(target, internal_format, w, h);
                glu::expect_no_error(gl, "RenderbufferStorage")?;
                gl.bind_renderbuffer(target, 0);
                glu::expect_no_error(gl, "BindRenderbuffer")?;
            }
            glw::GL_TEXTURE_1D => {
                gl.bind_texture(target, name);
                glu::expect_no_error(gl, "BindTexture")?;
                gl.tex_image_1d(
                    target,
                    level,
                    internal_format as GLint,
                    w,
                    BORDER,
                    format,
                    type_,
                    pixel_ptr,
                );
                error = gl.get_error();
                function_name = "TexImage1D";
            }
            glw::GL_TEXTURE_1D_ARRAY | glw::GL_TEXTURE_2D | glw::GL_TEXTURE_RECTANGLE => {
                gl.bind_texture(target, name);
                glu::expect_no_error(gl, "BindTexture")?;
                gl.tex_image_2d(
                    target,
                    level,
                    internal_format as GLint,
                    w,
                    h,
                    BORDER,
                    format,
                    type_,
                    pixel_ptr,
                );
                error = gl.get_error();
                function_name = "TexImage2D";
            }
            glw::GL_TEXTURE_2D_MULTISAMPLE => {
                gl.bind_texture(target, name);
                glu::expect_no_error(gl, "BindTexture")?;
                gl.tex_image_2d_multisample(target, SAMPLES, internal_format, w, h, glw::FALSE);
                error = gl.get_error();
                function_name = "TexImage2DMultisample";
            }
            glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => {
                gl.bind_texture(target, name);
                glu::expect_no_error(gl, "BindTexture")?;
                gl.tex_image_3d_multisample(target, SAMPLES, internal_format, w, h, d, glw::FALSE);
                error = gl.get_error();
                function_name = "TexImage3DMultisample";
            }
            glw::GL_TEXTURE_2D_ARRAY | glw::GL_TEXTURE_3D | glw::GL_TEXTURE_CUBE_MAP_ARRAY => {
                gl.bind_texture(target, name);
                glu::expect_no_error(gl, "BindTexture")?;
                gl.tex_image_3d(
                    target,
                    level,
                    internal_format as GLint,
                    w,
                    h,
                    d,
                    BORDER,
                    format,
                    type_,
                    pixel_ptr,
                );
                error = gl.get_error();
                function_name = "TexImage3D";
            }
            glw::GL_TEXTURE_BUFFER => {
                gl.gen_buffers(1, out_buf_id);
                glu::expect_no_error(gl, "GenBuffers")?;
                gl.bind_buffer(glw::GL_TEXTURE_BUFFER, *out_buf_id);
                glu::expect_no_error(gl, "BindBuffer")?;

                let (size, data) = if pixels.is_some() {
                    (w as glw::GLsizeiptr, pixel_ptr)
                } else {
                    (16, std::ptr::null())
                };
                gl.buffer_data(glw::GL_TEXTURE_BUFFER, size, data, glw::GL_DYNAMIC_COPY);
                glu::expect_no_error(gl, "BufferData")?;

                gl.bind_texture(glw::GL_TEXTURE_BUFFER, name);
                glu::expect_no_error(gl, "BindTexture")?;
                gl.tex_buffer(glw::GL_TEXTURE_BUFFER, internal_format, *out_buf_id);
                glu::expect_no_error(gl, "TexBuffer")?;
            }
            glw::GL_TEXTURE_CUBE_MAP
            | glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X
            | glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y
            | glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z
            | glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X
            | glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y
            | glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z => {
                // Change target to CUBE_MAP, it will be used later to change base and max level.
                target = glw::GL_TEXTURE_CUBE_MAP;
                gl.bind_texture(target, name);
                glu::expect_no_error(gl, "BindTexture")?;

                for face in [
                    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
                    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
                    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
                    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
                    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
                    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
                ] {
                    gl.tex_image_2d(
                        face,
                        level,
                        internal_format as GLint,
                        w,
                        h,
                        BORDER,
                        format,
                        type_,
                        pixel_ptr,
                    );
                }
                error = gl.get_error();
                function_name = "TexImage2D";
            }
            _ => return Err(TestError::Fail("Invalid enum".to_string())),
        }
    }

    if error != glw::GL_NO_ERROR {
        log::info!(
            "Error: {}. Function: {function_name}. Target: {target:#x}. Format: {internal_format:#x}, {format:#x}, {type_:#x}",
            glw::error_name(error)
        );
        return Err(TestError::Fail("Failed to create texture".to_string()));
    }

    if target != glw::GL_RENDERBUFFER {
        // SAFETY: as above.
        unsafe { gl.bind_texture(target, 0) };
        glu::expect_no_error(gl, "BindTexture")?;
    }
    Ok(())
}

/// `Utils::transProxyToRealTarget`
pub(super) fn trans_proxy_to_real_target(target: GLenum) -> GLenum {
    match target {
        glw::GL_PROXY_TEXTURE_1D => glw::GL_TEXTURE_1D,
        glw::GL_PROXY_TEXTURE_1D_ARRAY => glw::GL_TEXTURE_1D_ARRAY,
        glw::GL_PROXY_TEXTURE_2D => glw::GL_TEXTURE_2D,
        glw::GL_PROXY_TEXTURE_2D_ARRAY => glw::GL_TEXTURE_2D_ARRAY,
        glw::GL_PROXY_TEXTURE_2D_MULTISAMPLE => glw::GL_TEXTURE_2D_MULTISAMPLE,
        glw::GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY => glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
        glw::GL_PROXY_TEXTURE_3D => glw::GL_TEXTURE_3D,
        glw::GL_PROXY_TEXTURE_CUBE_MAP => glw::GL_TEXTURE_CUBE_MAP,
        glw::GL_PROXY_TEXTURE_CUBE_MAP_ARRAY => glw::GL_TEXTURE_CUBE_MAP_ARRAY,
        glw::GL_PROXY_TEXTURE_RECTANGLE => glw::GL_TEXTURE_RECTANGLE,
        other => other,
    }
}

/// `Utils::transRealToBindTarget`
pub(super) fn trans_real_to_bind_target(target: GLenum) -> GLenum {
    match target {
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X
        | glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y
        | glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z
        | glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X
        | glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y
        | glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z => glw::GL_TEXTURE_CUBE_MAP,
        other => other,
    }
}

/// `read3Channel`, `read4Channel`: one channel of a packed pixel, scaled to 0..1
fn read_packed_channel(value: u32, sizes: &[u32], offsets: &[u32], channel: usize) -> f64 {
    let max = (1u32 << sizes[channel]) - 1;
    let result = (value >> offsets[channel]) & max;
    result as f64 / max as f64
}

/// `write3Channel`, `write4Channel`: ORs one channel into a packed pixel of `n_bytes` bytes
fn write_packed_channel(pixel: &mut [u8], n_bytes: usize, sizes: &[u32], offsets: &[u32], channel: usize, value: f64) {
    let max = (1u32 << sizes[channel]) - 1;
    let t_value = (value * max as f64) as u32;
    let result = (t_value & max) << offsets[channel];

    let mut current = [0u8; 4];
    current[..n_bytes].copy_from_slice(&pixel[..n_bytes]);
    let combined = u32::from_ne_bytes(current) | result;
    pixel[..n_bytes].copy_from_slice(&combined.to_ne_bytes()[..n_bytes]);
}

/// `tcu::Float<uint32_t, 5, MantissaBits, 15, FLOAT_SUPPORT_DENORM>::asDouble`
fn decode_unsigned_small_float(bits: u32, mantissa_bits: u32) -> f64 {
    let exponent = bits >> mantissa_bits;
    let mantissa = bits & ((1u32 << mantissa_bits) - 1);
    let scale = (1u64 << mantissa_bits) as f64;

    if exponent == 0 {
        return mantissa as f64 / scale * 2f64.powi(1 - 15);
    }
    if exponent == 31 {
        return if mantissa == 0 { f64::INFINITY } else { f64::NAN };
    }
    (1.0 + mantissa as f64 / scale) * 2f64.powi(exponent as i32 - 15)
}

/// `tcu::Float<uint32_t, 5, MantissaBits, 15, FLOAT_SUPPORT_DENORM>(double)`: round to nearest even, negative values to zero, overflow to infinity
fn encode_unsigned_small_float(value: f64, mantissa_bits: u32) -> u32 {
    const OTHER_MANTISSA_BITS: u32 = 52;
    const E_MIN: i32 = 1 - 15;
    const E_MAX: i32 = 30 - 15;
    let inf_bits = 31u32 << mantissa_bits;

    if value.is_sign_negative() {
        return 0;
    }
    if value.is_infinite() {
        return inf_bits;
    }
    if value.is_nan() {
        return inf_bits | (1 << (mantissa_bits - 1));
    }
    if value == 0.0 {
        return 0;
    }

    let double_bits = value.to_bits();
    let exponent_field = ((double_bits >> 52) & 0x7ff) as i32;
    let mut m = double_bits & ((1u64 << 52) - 1);
    let mut e = if exponent_field == 0 {
        1 - 1023
    } else {
        exponent_field - 1023
    };
    if exponent_field != 0 {
        m |= 1u64 << 52;
    }

    while m & (1u64 << OTHER_MANTISSA_BITS) == 0 {
        m <<= 1;
        e -= 1;
    }

    if e < E_MIN {
        if E_MIN - e - 1 <= mantissa_bits as i32 {
            let bit_diff = (OTHER_MANTISSA_BITS - mantissa_bits) as i32 + (E_MIN - e);
            let half = (1u64 << (bit_diff - 1)) - 1;
            let bias = (m >> bit_diff) & 1;
            return ((m + half + bias) >> bit_diff) as u32;
        }
        return 0;
    }

    m &= !(1u64 << OTHER_MANTISSA_BITS);

    let bit_diff = OTHER_MANTISSA_BITS - mantissa_bits;
    let half = (1u64 << (bit_diff - 1)) - 1;
    let bias = (m >> bit_diff) & 1;
    m = (m + half + bias) >> bit_diff;

    if m & (1u64 << mantissa_bits) != 0 {
        m = 0;
        e += 1;
    }

    if e > E_MAX {
        return inf_bits;
    }
    (((e + 15) as u32) << mantissa_bits) | m as u32
}

/// `Utils::readChannel`
pub(super) fn read_channel(type_: GLenum, channel: u32, pixel: &[u8]) -> f64 {
    let c = channel as usize;
    match type_ {
        glw::GL_UNSIGNED_BYTE => pixel[c] as f64 / u8::MAX as f64,
        glw::GL_UNSIGNED_SHORT => u16::from_ne_bytes([pixel[2 * c], pixel[2 * c + 1]]) as f64 / u16::MAX as f64,
        glw::GL_UNSIGNED_INT => {
            u32::from_ne_bytes(pixel[4 * c..4 * c + 4].try_into().unwrap()) as f64 / u32::MAX as f64
        }
        glw::GL_BYTE => pixel[c] as i8 as f64 / i8::MAX as f64,
        glw::GL_SHORT => i16::from_ne_bytes([pixel[2 * c], pixel[2 * c + 1]]) as f64 / i16::MAX as f64,
        glw::GL_INT => i32::from_ne_bytes(pixel[4 * c..4 * c + 4].try_into().unwrap()) as f64 / i32::MAX as f64,
        glw::GL_HALF_FLOAT => {
            Float16::from_bits(u16::from_ne_bytes([pixel[2 * c], pixel[2 * c + 1]])).as_float() as f64
        }
        glw::GL_FLOAT => f32::from_ne_bytes(pixel[4 * c..4 * c + 4].try_into().unwrap()) as f64,
        glw::GL_UNSIGNED_BYTE_3_3_2 => read_packed_channel(pixel[0] as u32, &[3, 3, 2], &[5, 2, 0], c),
        glw::GL_UNSIGNED_SHORT_5_6_5 => read_packed_channel(
            u16::from_ne_bytes([pixel[0], pixel[1]]) as u32,
            &[5, 6, 5],
            &[11, 5, 0],
            c,
        ),
        glw::GL_UNSIGNED_SHORT_4_4_4_4 => read_packed_channel(
            u16::from_ne_bytes([pixel[0], pixel[1]]) as u32,
            &[4, 4, 4, 4],
            &[12, 8, 4, 0],
            c,
        ),
        glw::GL_UNSIGNED_SHORT_5_5_5_1 => read_packed_channel(
            u16::from_ne_bytes([pixel[0], pixel[1]]) as u32,
            &[5, 5, 5, 1],
            &[11, 6, 1, 0],
            c,
        ),
        glw::GL_UNSIGNED_INT_2_10_10_10_REV => read_packed_channel(
            u32::from_ne_bytes(pixel[..4].try_into().unwrap()),
            &[2, 10, 10, 10],
            &[30, 20, 10, 0],
            3 - c,
        ),
        glw::GL_UNSIGNED_INT_5_9_9_9_REV => read_packed_channel(
            u32::from_ne_bytes(pixel[..4].try_into().unwrap()),
            &[5, 9, 9, 9],
            &[27, 18, 9, 0],
            3 - c,
        ),
        glw::GL_UNSIGNED_INT_10F_11F_11F_REV => {
            let val = u32::from_ne_bytes(pixel[..4].try_into().unwrap());
            match c {
                0 => decode_unsigned_small_float(val & 0x7ff, 6),
                1 => decode_unsigned_small_float((val >> 11) & 0x7ff, 6),
                2 => decode_unsigned_small_float((val >> 22) & 0x3ff, 5),
                _ => panic!("Invalid channel"),
            }
        }
        _ => panic!("Invalid enum"),
    }
}

/// `Utils::writeChannel`
pub(super) fn write_channel(type_: GLenum, channel: u32, value: f64, pixel: &mut [u8]) {
    let c = channel as usize;
    match type_ {
        glw::GL_UNSIGNED_BYTE => pixel[c] = (value * u8::MAX as f64) as u8,
        glw::GL_UNSIGNED_SHORT => {
            pixel[2 * c..2 * c + 2].copy_from_slice(&((value * u16::MAX as f64) as u16).to_ne_bytes())
        }
        glw::GL_UNSIGNED_INT => {
            pixel[4 * c..4 * c + 4].copy_from_slice(&((value * u32::MAX as f64) as u32).to_ne_bytes())
        }
        glw::GL_BYTE => pixel[c] = (value * i8::MAX as f64) as i8 as u8,
        glw::GL_SHORT => pixel[2 * c..2 * c + 2].copy_from_slice(&((value * i16::MAX as f64) as i16).to_ne_bytes()),
        glw::GL_INT => pixel[4 * c..4 * c + 4].copy_from_slice(&((value * i32::MAX as f64) as i32).to_ne_bytes()),
        glw::GL_HALF_FLOAT => pixel[2 * c..2 * c + 2].copy_from_slice(&Float16::new(value as f32).bits().to_ne_bytes()),
        glw::GL_FLOAT => pixel[4 * c..4 * c + 4].copy_from_slice(&(value as f32).to_ne_bytes()),
        glw::GL_UNSIGNED_BYTE_3_3_2 => write_packed_channel(pixel, 1, &[3, 3, 2], &[5, 2, 0], c, value),
        glw::GL_UNSIGNED_SHORT_5_6_5 => write_packed_channel(pixel, 2, &[5, 6, 5], &[11, 5, 0], c, value),
        glw::GL_UNSIGNED_SHORT_4_4_4_4 => write_packed_channel(pixel, 2, &[4, 4, 4, 4], &[12, 8, 4, 0], c, value),
        glw::GL_UNSIGNED_SHORT_5_5_5_1 => write_packed_channel(pixel, 2, &[5, 5, 5, 1], &[11, 6, 1, 0], c, value),
        glw::GL_UNSIGNED_INT_2_10_10_10_REV => {
            write_packed_channel(pixel, 4, &[2, 10, 10, 10], &[30, 20, 10, 0], 3 - c, value)
        }
        glw::GL_UNSIGNED_INT_5_9_9_9_REV => {
            write_packed_channel(pixel, 4, &[5, 9, 9, 9], &[27, 18, 9, 0], 3 - c, value)
        }
        glw::GL_UNSIGNED_INT_10F_11F_11F_REV => {
            let (mantissa_bits, shift) = match c {
                0 => (6, 0),
                1 => (6, 11),
                2 => (5, 22),
                _ => panic!("Invalid channel"),
            };
            let current = u32::from_ne_bytes(pixel[..4].try_into().unwrap());
            let combined = current | (encode_unsigned_small_float(value, mantissa_bits) << shift);
            pixel[..4].copy_from_slice(&combined.to_ne_bytes());
        }
        _ => panic!("Invalid enum"),
    }
}

/// `Utils::packPixel`
pub(super) fn pack_pixel(
    internal_format: GLenum,
    type_: GLenum,
    red: f64,
    green: f64,
    blue: f64,
    alpha: f64,
    out_pixel: &mut [u8],
) {
    let n_channels = match internal_format {
        glw::GL_RGB9_E5 => 4,
        other => get_number_of_channels(other),
    };
    let channels = [red, green, blue, alpha];
    for (channel, value) in channels.iter().take(n_channels as usize).enumerate() {
        write_channel(type_, channel as u32, *value, out_pixel);
    }
}

/// `Utils::unpackPixel`
#[allow(unused_assignments)]
pub(super) fn unpack_pixel(format: GLenum, type_: GLenum, pixel: &[u8]) -> [f64; 4] {
    let (mut red, mut green, mut blue, mut alpha) = (1.0, 1.0, 1.0, 1.0);

    match format {
        glw::GL_RED | glw::GL_RED_INTEGER => {
            red = read_channel(type_, 0, pixel);
        }
        glw::GL_RG | glw::GL_RG_INTEGER => {
            red = read_channel(type_, 0, pixel);
            green = read_channel(type_, 1, pixel);
        }
        glw::GL_RGB | glw::GL_RGB_INTEGER => {
            red = read_channel(type_, 0, pixel);
            green = read_channel(type_, 1, pixel);
            blue = read_channel(type_, 2, pixel);
            if type_ == glw::GL_UNSIGNED_INT_5_9_9_9_REV {
                alpha = read_channel(type_, 3, pixel);
            }
        }
        glw::GL_RGBA | glw::GL_RGBA_INTEGER => {
            red = read_channel(type_, 0, pixel);
            green = read_channel(type_, 1, pixel);
            blue = read_channel(type_, 2, pixel);
            alpha = read_channel(type_, 3, pixel);
        }
        _ => panic!("Invalid enum"),
    }
    [red, green, blue, alpha]
}

/// `Utils::roundComponent`
fn round_component(internal_format: GLenum, component: GLenum, value: &mut f64) -> bool {
    let exponent = match internal_format {
        glw::GL_RGB4 => 4,
        glw::GL_RGB5 => 5,
        _ => return false,
    };

    let rounded_value = ((2f64.powi(exponent) - 1.0) * *value + 0.5).floor() as i32;
    let mut multiplier = if component == glw::GL_GREEN { 2 } else { 1 };
    if internal_format == glw::GL_RGB4 {
        multiplier *= 2;
    }
    *value = (rounded_value * multiplier) as f64;
    true
}

/// `Utils::unpackAndComaprePixels`
pub(super) fn unpack_and_compare_pixels(
    left_format: GLenum,
    left_type: GLenum,
    left_internal_format: GLenum,
    left_pixel: &[u8],
    right_format: GLenum,
    right_type: GLenum,
    right_internal_format: GLenum,
    right_pixel: &[u8],
) -> bool {
    let mut left = unpack_pixel(left_format, left_type, left_pixel);
    let mut right = unpack_pixel(right_format, right_type, right_pixel);

    for (channel, component) in [glw::GL_RED, glw::GL_GREEN, glw::GL_BLUE].into_iter().enumerate() {
        round_component(left_internal_format, component, &mut left[channel]);
    }
    for (channel, component) in [glw::GL_RED, glw::GL_GREEN, glw::GL_BLUE].into_iter().enumerate() {
        round_component(right_internal_format, component, &mut right[channel]);
    }

    compare_pixel_channels(left_internal_format, left, right_internal_format, right)
}
