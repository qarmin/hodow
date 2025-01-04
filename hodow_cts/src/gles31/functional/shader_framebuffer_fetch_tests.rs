// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fShaderFramebufferFetchTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2017 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Every upstream case class becomes one
// `TestCase` struct here; the base class's shared helpers (`genFramebufferWithTexture`,
// `genUniformColor`, `render`, `verifyRenderbuffer`, ...) are free functions instead of
// methods, since there is no persistent per-case state across an `iterate` call the way
// upstream's `deinit()` implies - every GL object this file creates is a local RAII
// wrapper (`glu::objects`) or is deleted explicitly before the function that made it
// returns.
//
// The `GL_FRAMEBUFFER_SRGB` toggle in upstream's `init`/`deinit`
// (`contextSupports(type, ApiType::core(4,5))`) is always false on an ES-only context
// and is not ported, the same convention `negative_shader_framebuffer_fetch_tests.rs`
// already documents for this file's negative sibling.
//
// `FboTestUtil::getFormatName` is not ported: it is the lowercased `GL_*` enum name,
// which `glu::texture_format_name` already answers (see `fragment_output_tests.rs`'s own
// header for the same note).

use crate::glu::texture_util::map_gl_internal_format;
use crate::glu::{
    Buffer, Context, ContextType, Framebuffer, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, Texture,
    TransferFormat, expect_no_error, get_transfer_format, read_pixels, texture_format_name,
};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::image_compare::{float_threshold_compare, float_ulp_threshold_compare, int_threshold_compare};
use crate::tcu::pixel::{
    PixelBufferAccess, TextureLevel, clear, clear_int, get_texture_format_bit_depth, get_texture_format_info,
    get_texture_format_mantissa_bit_depth, linear_to_srgb, srgb_to_linear,
};
use crate::tcu::{
    ChannelOrder, ChannelType, RGBA, TestError, TestOutcome, TestResult, TestStatus, TextureChannelClass,
    TextureFormat, UVec4, Vec4,
};

const VIEWPORT_WIDTH: i32 = 64;
const VIEWPORT_HEIGHT: i32 = 64;

const PASS_THROUGH_VERT_SOURCE: &str = concat!(
    "#version 310 es\n",
    "in highp vec4 a_position;\n\n",
    "void main (void)\n",
    "{\n",
    "    gl_Position = a_position;\n",
    "}\n"
);

// ---------------------------------------------------------------------------------
// Support checks (`checkFramebufferFetchSupport` / `checkFormatSupport`)
// ---------------------------------------------------------------------------------

fn check_framebuffer_fetch_support(context: &Context) -> Result<(), TestError> {
    if context
        .context_info
        .is_extension_supported("GL_EXT_shader_framebuffer_fetch")
    {
        Ok(())
    } else {
        Err(TestError::NotSupported(
            "GL_EXT_shader_framebuffer_fetch not supported".to_string(),
        ))
    }
}

/// `isRequiredFormat`
fn is_required_format(format: GLenum, context_type: ContextType) -> bool {
    let is_es32 = context_type.supports(3, 2);
    matches!(
        format,
        glw::GL_RGBA32I
            | glw::GL_RGBA32UI
            | glw::GL_RGBA16I
            | glw::GL_RGBA16UI
            | glw::GL_RGBA8
            | glw::GL_RGBA8I
            | glw::GL_RGBA8UI
            | glw::GL_SRGB8_ALPHA8
            | glw::GL_RGB10_A2
            | glw::GL_RGB10_A2UI
            | glw::GL_RGBA4
            | glw::GL_RGB5_A1
            | glw::GL_RGB8
            | glw::GL_RGB565
            | glw::GL_RG32I
            | glw::GL_RG32UI
            | glw::GL_RG16I
            | glw::GL_RG16UI
            | glw::GL_RG8
            | glw::GL_RG8I
            | glw::GL_RG8UI
            | glw::GL_R32I
            | glw::GL_R32UI
            | glw::GL_R16I
            | glw::GL_R16UI
            | glw::GL_R8
            | glw::GL_R8I
            | glw::GL_R8UI
    ) || (is_es32
        && matches!(
            format,
            glw::GL_RGBA32F | glw::GL_RGB32F | glw::GL_R11F_G11F_B10F | glw::GL_RG32F | glw::GL_R32F
        ))
}

/// `getEnablingExtensions`
fn get_enabling_extensions(format: GLenum, context_type: ContextType) -> Vec<&'static str> {
    let is_es32 = context_type.supports(3, 2);
    let mut out = Vec::new();

    match format {
        glw::GL_RGB16F => out.push("GL_EXT_color_buffer_half_float"),
        glw::GL_RGBA16F | glw::GL_RG16F | glw::GL_R16F => {
            out.push("GL_EXT_color_buffer_half_float");
            if !is_es32 {
                out.push("GL_EXT_color_buffer_float");
            }
        }
        glw::GL_RGBA32F | glw::GL_RGB32F | glw::GL_R11F_G11F_B10F | glw::GL_RG32F | glw::GL_R32F if !is_es32 => {
            out.push("GL_EXT_color_buffer_float");
        }
        _ => {}
    }

    out
}

/// `checkFormatSupport`
fn check_format_support(context: &Context, format: GLenum) -> Result<(), TestError> {
    let is_core = is_required_format(format, context.context_type());
    let required_exts = if is_core {
        Vec::new()
    } else {
        get_enabling_extensions(format, context.context_type())
    };

    if !required_exts.is_empty()
        && !required_exts
            .iter()
            .any(|ext| context.context_info.is_extension_supported(ext))
    {
        return Err(TestError::NotSupported("Format not supported".to_string()));
    }
    Ok(())
}

fn check_case_support(context: &Context, format: GLenum) -> Result<(), TestError> {
    check_framebuffer_fetch_support(context)?;
    check_format_support(context, format)
}

// ---------------------------------------------------------------------------------
// Small value-space helpers
// ---------------------------------------------------------------------------------

fn as_uint4(color: [f32; 4]) -> [u32; 4] {
    std::array::from_fn(|i| color[i] as u32)
}

fn as_int4(color: [f32; 4]) -> [i32; 4] {
    std::array::from_fn(|i| color[i] as i32)
}

fn add4(a: [f32; 4], b: [f32; 4]) -> [f32; 4] {
    std::array::from_fn(|i| a[i] + b[i])
}

fn clamp4(v: [f32; 4], lo: [f32; 4], hi: [f32; 4]) -> [f32; 4] {
    std::array::from_fn(|i| v[i].clamp(lo[i], hi[i]))
}

fn vec4_literal<T: std::fmt::Display + Copy>(v: [T; 4]) -> String {
    format!("({}, {}, {}, {})", v[0], v[1], v[2], v[3])
}

/// `scaleColorValue` - upstream quantises the input to 8-bit `tcu::RGBA` and back
/// before scaling into the format's own value range, which the literal test inputs
/// (0.1, 0.5, 0.25, ...) all round-trip through exactly.
fn scale_color_value(format: TextureFormat, color: [f32; 4]) -> [f32; 4] {
    let info = get_texture_format_info(format);
    let quantized = RGBA::from_vec(Vec4::from_array(color)).to_vec().m_data;
    std::array::from_fn(|i| quantized[i] * (info.value_max[i] - info.value_min[i]) + info.value_min[i])
}

/// `getReadPixelFormat`
fn get_read_pixel_format(tex_fmt: TextureFormat) -> TextureFormat {
    match tex_fmt.type_.channel_class() {
        TextureChannelClass::UnsignedInteger => TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT32),
        TextureChannelClass::SignedInteger => TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT32),
        TextureChannelClass::FloatingPoint => TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT),
        // `UnsignedFixedPoint` / `SignedFixedPoint` and the unreachable `Last` sentinel
        // (no colour-renderable format ever lands there).
        _ => TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
    }
}

/// `getColorOutputType`
fn get_color_output_type(tex_fmt: TextureFormat) -> &'static str {
    match tex_fmt.type_.channel_class() {
        TextureChannelClass::UnsignedInteger => "uvec4",
        TextureChannelClass::SignedInteger => "ivec4",
        _ => "vec4",
    }
}

/// `getFixedPointFormatThreshold`
fn get_fixed_point_format_threshold(source_format: TextureFormat, read_pixels_format: TextureFormat) -> [f32; 4] {
    let src_bits = get_texture_format_bit_depth(source_format);
    let read_bits = get_texture_format_bit_depth(read_pixels_format);
    let bits: [i32; 4] = std::array::from_fn(|i| {
        if src_bits[i] == 0 {
            read_bits[i]
        } else {
            src_bits[i].min(read_bits[i])
        }
    });
    std::array::from_fn(|i| 3.0 / (((1u64 << bits[i]) - 1) as f32))
}

/// `getFloatULPThreshold`
fn get_float_ulp_threshold(source_format: TextureFormat, read_pixels_format: TextureFormat) -> [u32; 4] {
    let src_mantissa = get_texture_format_mantissa_bit_depth(source_format);
    let read_mantissa = get_texture_format_mantissa_bit_depth(read_pixels_format);
    let ulp_diff: [i32; 4] = std::array::from_fn(|i| (read_mantissa[i] - src_mantissa[i]).max(0));
    std::array::from_fn(|i| 4u32 * (1u32 << (ulp_diff[i] as u32)))
}

/// `isGLInternalColorFormatFilterable`, ported for the sized formats this file's own
/// `COLOR_FORMATS` table (plus `GL_RGBA8`, the `basic` group's fixed format) uses - not
/// upstream's full switch, which also covers formats no case here ever passes.
fn is_gl_internal_color_format_filterable(format: GLenum) -> bool {
    match format {
        glw::GL_R8
        | glw::GL_RG8
        | glw::GL_RGB8
        | glw::GL_RGB565
        | glw::GL_RGBA4
        | glw::GL_RGB5_A1
        | glw::GL_RGBA8
        | glw::GL_RGB10_A2
        | glw::GL_SRGB8_ALPHA8
        | glw::GL_R16F
        | glw::GL_RG16F
        | glw::GL_RGB16F
        | glw::GL_RGBA16F
        | glw::GL_R11F_G11F_B10F => true,

        glw::GL_RGB10_A2UI
        | glw::GL_R32F
        | glw::GL_RG32F
        | glw::GL_RGBA32F
        | glw::GL_R8I
        | glw::GL_R8UI
        | glw::GL_R16I
        | glw::GL_R16UI
        | glw::GL_R32I
        | glw::GL_R32UI
        | glw::GL_RG8I
        | glw::GL_RG8UI
        | glw::GL_RG16I
        | glw::GL_RG16UI
        | glw::GL_RG32I
        | glw::GL_RG32UI
        | glw::GL_RGBA8I
        | glw::GL_RGBA8UI
        | glw::GL_RGBA16I
        | glw::GL_RGBA16UI
        | glw::GL_RGBA32I
        | glw::GL_RGBA32UI => false,

        _ => {
            debug_assert!(
                false,
                "is_gl_internal_color_format_filterable: format {format:#x} not in this file's own table"
            );
            false
        }
    }
}

/// `fillWithGrid`, the 2D case only (every texture here is a single 2D layer).
fn fill_with_grid_2d(access: &mut PixelBufferAccess<'_>, cell_size: u32, color_even: [f32; 4], color_odd: [f32; 4]) {
    let [width, height, _] = access.size();
    for y in 0..height {
        for x in 0..width {
            let parity = ((x / cell_size) % 2) ^ ((y / cell_size) % 2);
            access.set_pixel(if parity != 0 { color_odd } else { color_even }, x, y, 0);
        }
    }
}

/// A store's destination fill, dispatched by channel class - `tcu::clear` for
/// fixed-point/float formats, `tcu::clear(IVec4/UVec4)` for integer ones.
fn fill_solid(access: &mut PixelBufferAccess<'_>, tex_fmt: TextureFormat, color: [f32; 4]) -> Result<(), TestError> {
    match tex_fmt.type_.channel_class() {
        TextureChannelClass::UnsignedInteger => {
            if !clear_int(access, as_uint4(color).map(|v| v as i32)) {
                return Err(TestError::InternalError(
                    "clear_int: unsigned integer format".to_string(),
                ));
            }
        }
        TextureChannelClass::SignedInteger => {
            if !clear_int(access, as_int4(color)) {
                return Err(TestError::InternalError("clear_int: signed integer format".to_string()));
            }
        }
        _ => clear(access, color),
    }
    Ok(())
}

/// `verifyRenderbuffer`
fn verify_renderbuffer(tex_fmt: TextureFormat, reference: &TextureLevel, result: &TextureLevel) -> TestOutcome {
    let ref_access = reference.get_const_access();
    let res_access = result.get_const_access();

    let ok = match tex_fmt.type_.channel_class() {
        TextureChannelClass::FloatingPoint => {
            let threshold = get_float_ulp_threshold(tex_fmt, result.format());
            float_ulp_threshold_compare(&ref_access, &res_access, UVec4::from_array(threshold)).ok
        }
        TextureChannelClass::SignedInteger | TextureChannelClass::UnsignedInteger => {
            int_threshold_compare(&ref_access, &res_access, UVec4::new(1, 1, 1, 1)).ok
        }
        TextureChannelClass::SignedFixedPoint | TextureChannelClass::UnsignedFixedPoint => {
            let threshold = get_fixed_point_format_threshold(tex_fmt, result.format());
            float_threshold_compare(&ref_access, &res_access, threshold).ok
        }
        TextureChannelClass::Last => return Err(TestError::Fail("Unsupported comparison".to_string())),
    };

    if ok {
        Ok(TestStatus::pass("Pass"))
    } else {
        Ok(TestStatus::fail("Fail"))
    }
}

// ---------------------------------------------------------------------------------
// Shared GL plumbing (`FramebufferFetchTestCase`'s own methods)
// ---------------------------------------------------------------------------------

fn build_program<'gl>(gl: &'gl glw::Functions, sources: &ProgramSources) -> Result<ShaderProgram<'gl>, TestError> {
    let program = ShaderProgram::new(gl, sources);
    if !program.is_ok() {
        return Err(TestError::Fail("Failed to compile shader program".to_string()));
    }
    Ok(program)
}

/// `genAttachementTexture`
fn gen_attachment_texture<'gl>(
    gl: &'gl glw::Functions,
    format: GLenum,
    tex_fmt: TextureFormat,
    transfer_fmt: TransferFormat,
    color: [f32; 4],
) -> Result<Texture<'gl>, TestError> {
    let mut data = TextureLevel::new(tex_fmt, VIEWPORT_WIDTH as u32, VIEWPORT_HEIGHT as u32, 1)?;
    fill_solid(&mut data.get_access(), tex_fmt, color)?;

    let filter = if is_gl_internal_color_format_filterable(format) {
        glw::GL_LINEAR
    } else {
        glw::GL_NEAREST
    } as GLint;
    let texture = Texture::new(gl);

    // SAFETY: `texture` is a fresh object this function owns; `data` holds exactly
    // `VIEWPORT_WIDTH * VIEWPORT_HEIGHT` texels laid out as `transfer_fmt` describes.
    unsafe {
        gl.bind_texture(glw::GL_TEXTURE_2D, texture.get());
        gl.tex_parameteri(
            glw::GL_TEXTURE_2D,
            glw::GL_TEXTURE_WRAP_S,
            glw::GL_CLAMP_TO_EDGE as GLint,
        );
        gl.tex_parameteri(
            glw::GL_TEXTURE_2D,
            glw::GL_TEXTURE_WRAP_T,
            glw::GL_CLAMP_TO_EDGE as GLint,
        );
        gl.tex_parameteri(
            glw::GL_TEXTURE_2D,
            glw::GL_TEXTURE_WRAP_R,
            glw::GL_CLAMP_TO_EDGE as GLint,
        );
        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, filter);
        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, filter);
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            format as GLint,
            VIEWPORT_WIDTH,
            VIEWPORT_HEIGHT,
            0,
            transfer_fmt.format,
            transfer_fmt.data_type,
            data.data().as_ptr().cast(),
        );
        gl.bind_texture(glw::GL_TEXTURE_2D, 0);
    }
    Ok(texture)
}

/// `genFramebufferWithTexture`
fn gen_framebuffer_with_texture<'gl>(
    gl: &'gl glw::Functions,
    format: GLenum,
    tex_fmt: TextureFormat,
    transfer_fmt: TransferFormat,
    color: [f32; 4],
) -> Result<(Framebuffer<'gl>, Texture<'gl>), TestError> {
    let framebuffer = Framebuffer::new(gl);
    // SAFETY: binding a framebuffer this function owns.
    unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.get()) };

    let texture = gen_attachment_texture(gl, format, tex_fmt, transfer_fmt, color)?;
    expect_no_error(gl, "genAttachementTexture()")?;

    // SAFETY: attaching the texture this function just built to the framebuffer it
    // just built.
    unsafe {
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            texture.get(),
            0,
        );
        if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::Fail("Framebuffer was not complete".to_string()));
        }
    }
    Ok((framebuffer, texture))
}

/// `genUniformColor`
fn gen_uniform_color(
    gl: &glw::Functions,
    program: &ShaderProgram<'_>,
    tex_fmt: TextureFormat,
    color: [f32; 4],
) -> Result<(), TestError> {
    // SAFETY: `program` is current and declares `u_color` at the type
    // `get_color_output_type` names.
    unsafe {
        let location = gl.get_uniform_location(program.program(), c"u_color".as_ptr());
        match tex_fmt.type_.channel_class() {
            TextureChannelClass::UnsignedInteger => gl.uniform_4uiv(location, 1, as_uint4(color).as_ptr()),
            TextureChannelClass::SignedInteger => gl.uniform_4iv(location, 1, as_int4(color).as_ptr()),
            _ => gl.uniform_4fv(location, 1, color.as_ptr()),
        }
    }
    expect_no_error(gl, "genUniformColor()")
}

/// `render` - draws a full-viewport quad through the `a_position` attribute.
fn render(gl: &glw::Functions, program: &ShaderProgram<'_>) -> Result<(), TestError> {
    const COORDS: [f32; 8] = [-1.0, -1.0, 1.0, -1.0, 1.0, 1.0, -1.0, 1.0];
    const INDICES: [u16; 6] = [0, 1, 2, 2, 3, 0];

    let coord_buffer = Buffer::new(gl);
    let element_buffer = Buffer::new(gl);

    // SAFETY: `program` is current; the VAO is deleted and both buffers drop before
    // this function returns.
    unsafe {
        let mut vao: GLuint = 0;
        gl.gen_vertex_arrays(1, &mut vao);
        gl.bind_vertex_array(vao);

        let coord_location = gl.get_attrib_location(program.program(), c"a_position".as_ptr()) as GLuint;

        gl.viewport(0, 0, VIEWPORT_WIDTH, VIEWPORT_HEIGHT);

        gl.bind_buffer(glw::GL_ARRAY_BUFFER, coord_buffer.get());
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            size_of_val(&COORDS) as glw::GLsizeiptr,
            COORDS.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );
        gl.enable_vertex_attrib_array(coord_location);
        gl.vertex_attrib_pointer(
            coord_location,
            2,
            glw::GL_FLOAT,
            glw::GL_FALSE as glw::GLboolean,
            0,
            std::ptr::null(),
        );

        gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, element_buffer.get());
        gl.buffer_data(
            glw::GL_ELEMENT_ARRAY_BUFFER,
            size_of_val(&INDICES) as glw::GLsizeiptr,
            INDICES.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );

        gl.draw_elements(glw::GL_TRIANGLES, 6, glw::GL_UNSIGNED_SHORT, std::ptr::null());

        gl.delete_vertex_arrays(1, &vao);
    }

    expect_no_error(gl, "render()")
}

fn tex_fmt_of_rgba8() -> TextureFormat {
    map_gl_internal_format(glw::GL_RGBA8).expect("GL_RGBA8 maps")
}

// ---------------------------------------------------------------------------------
// framebuffer_format group (`TextureFormatTestCase`)
// ---------------------------------------------------------------------------------

fn format_value_bounds(tex_fmt: TextureFormat) -> (String, String) {
    let info = get_texture_format_info(tex_fmt);
    match tex_fmt.type_.channel_class() {
        TextureChannelClass::UnsignedInteger => (
            vec4_literal(as_uint4(info.value_max)),
            vec4_literal(as_uint4(info.value_min)),
        ),
        TextureChannelClass::SignedInteger => (
            vec4_literal(as_int4(info.value_max)),
            vec4_literal(as_int4(info.value_min)),
        ),
        _ => (vec4_literal(info.value_max), vec4_literal(info.value_min)),
    }
}

/// `FramebufferFetchTestCase::genShaderSources` - the base-class shader every case
/// without its own override (`TextureFormatTestCase`, `TextureLevelCase`,
/// `TextureLayerCase`) uses.
fn base_fragment_source(tex_fmt: TextureFormat) -> String {
    let vec_type = get_color_output_type(tex_fmt);
    let (max_str, min_str) = format_value_bounds(tex_fmt);
    format!(
        "#version 310 es\n#extension GL_EXT_shader_framebuffer_fetch : require\nlayout(location = 0) inout highp {vec_type} o_color;\nuniform highp {vec_type} u_color;\n\nvoid main (void)\n{{\n    o_color = clamp(o_color + u_color, {vec_type}{min_str}, {vec_type}{max_str});\n}}\n"
    )
}

fn fill_texture_format_reference(
    access: &mut PixelBufferAccess<'_>,
    tex_fmt: TextureFormat,
    fb_color: [f32; 4],
    uniform_color: [f32; 4],
) -> Result<(), TestError> {
    let info = get_texture_format_info(tex_fmt);

    match tex_fmt.type_.channel_class() {
        TextureChannelClass::UnsignedInteger => {
            let fb = as_uint4(fb_color);
            let u = as_uint4(uniform_color);
            let min = as_uint4(info.value_min);
            let max = as_uint4(info.value_max);
            let sum: [u32; 4] = std::array::from_fn(|i| fb[i].wrapping_add(u[i]).clamp(min[i], max[i]));
            if !clear_int(access, sum.map(|v| v as i32)) {
                return Err(TestError::InternalError(
                    "clear_int: unsigned integer reference".to_string(),
                ));
            }
        }
        TextureChannelClass::SignedInteger => {
            let fb = as_int4(fb_color);
            let u = as_int4(uniform_color);
            // 64-bit addition then mask to 32 bits, exactly as upstream avoids signed
            // overflow.
            let sum: [i32; 4] = std::array::from_fn(|i| (((fb[i] as i64) + (u[i] as i64)) & 0xFFFF_FFFF) as i32);
            if !clear_int(access, sum) {
                return Err(TestError::InternalError(
                    "clear_int: signed integer reference".to_string(),
                ));
            }
        }
        _ => {
            if tex_fmt.order.is_srgb() {
                let fragment_color = clamp4(
                    add4(srgb_to_linear(fb_color), uniform_color),
                    info.value_min,
                    info.value_max,
                );
                clear(access, linear_to_srgb(fragment_color));
            } else {
                clear(
                    access,
                    clamp4(add4(fb_color, uniform_color), info.value_min, info.value_max),
                );
            }
        }
    }
    Ok(())
}

struct TextureFormatCase {
    name: String,
    format: GLenum,
}

impl TestCase for TextureFormatCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_case_support(context, self.format)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let tex_fmt = map_gl_internal_format(self.format).expect("every framebuffer_fetch format maps");
        let transfer_fmt = get_transfer_format(tex_fmt)?;

        let uniform_color = scale_color_value(tex_fmt, [0.1, 0.1, 0.1, 1.0]);
        let fb_color = scale_color_value(tex_fmt, [0.5, 0.0, 0.0, 1.0]);

        let mut reference = TextureLevel::new(tex_fmt, VIEWPORT_WIDTH as u32, VIEWPORT_HEIGHT as u32, 1)?;
        fill_texture_format_reference(&mut reference.get_access(), tex_fmt, fb_color, uniform_color)?;

        let mut result = TextureLevel::new(
            get_read_pixel_format(tex_fmt),
            VIEWPORT_WIDTH as u32,
            VIEWPORT_HEIGHT as u32,
            1,
        )?;

        let program = build_program(
            gl,
            &ProgramSources::vtx_frag(PASS_THROUGH_VERT_SOURCE, base_fragment_source(tex_fmt)),
        )?;
        // SAFETY: `program` was just built successfully.
        unsafe { gl.use_program(program.program()) };

        let (_framebuffer, _texture) = gen_framebuffer_with_texture(gl, self.format, tex_fmt, transfer_fmt, fb_color)?;
        gen_uniform_color(gl, &program, tex_fmt, uniform_color)?;
        render(gl, &program)?;

        read_pixels(&context.render_context, 0, 0, &mut result.get_access())?;

        verify_renderbuffer(tex_fmt, &reference, &result)
    }
}

const COLOR_FORMATS: &[GLenum] = &[
    // RGBA formats
    glw::GL_RGBA32I,
    glw::GL_RGBA32UI,
    glw::GL_RGBA16I,
    glw::GL_RGBA16UI,
    glw::GL_RGBA8,
    glw::GL_RGBA8I,
    glw::GL_RGBA8UI,
    glw::GL_SRGB8_ALPHA8,
    glw::GL_RGB10_A2,
    glw::GL_RGB10_A2UI,
    glw::GL_RGBA4,
    glw::GL_RGB5_A1,
    // RGB formats
    glw::GL_RGB8,
    glw::GL_RGB565,
    // RG formats
    glw::GL_RG32I,
    glw::GL_RG32UI,
    glw::GL_RG16I,
    glw::GL_RG16UI,
    glw::GL_RG8,
    glw::GL_RG8I,
    glw::GL_RG8UI,
    // R formats
    glw::GL_R32I,
    glw::GL_R32UI,
    glw::GL_R16I,
    glw::GL_R16UI,
    glw::GL_R8,
    glw::GL_R8I,
    glw::GL_R8UI,
    // GL_EXT_color_buffer_float
    glw::GL_RGBA32F,
    glw::GL_RGBA16F,
    glw::GL_R11F_G11F_B10F,
    glw::GL_RG32F,
    glw::GL_RG16F,
    glw::GL_R32F,
    glw::GL_R16F,
    // GL_EXT_color_buffer_half_float
    glw::GL_RGB16F,
];

fn create_framebuffer_format_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("framebuffer_format");
    for &format in COLOR_FORMATS {
        let name = texture_format_name(format).expect("every framebuffer_fetch format has a name")[3..].to_lowercase();
        group.add_child(Box::new(TextureFormatCase { name, format }) as Box<dyn TestCase>);
    }
    group
}

// ---------------------------------------------------------------------------------
// basic group - every case below is fixed to GL_RGBA8, exactly as upstream registers
// them (`basicTestGroup->addChild(new XxxCase(m_context, "name", "desc", GL_RGBA8))`).
// ---------------------------------------------------------------------------------

/// `TexelFetchTestCase`
struct TexelFetchCase;

impl TestCase for TexelFetchCase {
    fn name(&self) -> &str {
        "texel_fetch"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_case_support(context, glw::GL_RGBA8)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let tex_fmt = tex_fmt_of_rgba8();
        let transfer_fmt = get_transfer_format(tex_fmt)?;

        const FRAGMENT_SOURCE: &str = concat!(
            "#version 310 es\n",
            "#extension GL_EXT_shader_framebuffer_fetch : require\n",
            "layout(location = 0) inout highp vec4 o_color;\n",
            "\n",
            "uniform sampler2D u_sampler;\n",
            "void main (void)\n",
            "{\n",
            "    o_color += texelFetch(u_sampler, ivec2(gl_FragCoord), 0);\n",
            "}\n"
        );

        let program = build_program(gl, &ProgramSources::vtx_frag(PASS_THROUGH_VERT_SOURCE, FRAGMENT_SOURCE))?;
        // SAFETY: `program` was just built successfully.
        unsafe { gl.use_program(program.program()) };

        let fb_color = scale_color_value(tex_fmt, [0.5, 0.0, 0.5, 1.0]);
        let color_even = scale_color_value(tex_fmt, [0.5, 0.5, 0.0, 1.0]);
        let color_odd = scale_color_value(tex_fmt, [0.5, 0.0, 0.5, 1.0]);

        // `genSamplerTexture` upstream: `m_texColorBuffer` is still zero-initialised at
        // this point (this call happens before `genFramebufferWithTexture` below), so
        // its `bindTexture(GL_TEXTURE_2D, m_texColorBuffer)` binds texture object 0 at
        // unit 1, not the `m_samplerTexture` name it just generated. Ported verbatim,
        // per "ported code keeps upstream shape": the grid pattern this uploads lands in
        // unit 1's own default `GL_TEXTURE_2D` object, and `sampler_texture` below is
        // generated and later deleted without ever being bound to anything.
        let mut sampler_texture: GLuint = 0;
        // SAFETY: writes exactly one name, deleted below.
        unsafe { gl.gen_textures(1, &mut sampler_texture) };

        let mut grid = TextureLevel::new(tex_fmt, VIEWPORT_WIDTH as u32, VIEWPORT_HEIGHT as u32, 1)?;
        fill_with_grid_2d(&mut grid.get_access(), 8, color_even, color_odd);

        // SAFETY: unit 1's own default `GL_TEXTURE_2D` object, matching upstream.
        unsafe {
            gl.active_texture(glw::GL_TEXTURE1);
            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA8 as GLint,
                VIEWPORT_WIDTH,
                VIEWPORT_HEIGHT,
                0,
                transfer_fmt.format,
                transfer_fmt.data_type,
                grid.data().as_ptr().cast(),
            );

            let sampler_location = gl.get_uniform_location(program.program(), c"u_sampler".as_ptr());
            gl.uniform_1i(sampler_location, 1);
        }
        expect_no_error(gl, "genSamplerTexture()")?;

        let mut reference = TextureLevel::new(tex_fmt, VIEWPORT_WIDTH as u32, VIEWPORT_HEIGHT as u32, 1)?;
        fill_with_grid_2d(
            &mut reference.get_access(),
            8,
            add4(color_even, fb_color),
            add4(color_odd, fb_color),
        );

        let mut result = TextureLevel::new(
            get_read_pixel_format(tex_fmt),
            VIEWPORT_WIDTH as u32,
            VIEWPORT_HEIGHT as u32,
            1,
        )?;

        let (_framebuffer, _texture) =
            gen_framebuffer_with_texture(gl, glw::GL_RGBA8, tex_fmt, transfer_fmt, fb_color)?;
        render(gl, &program)?;

        read_pixels(&context.render_context, 0, 0, &mut result.get_access())?;

        // SAFETY: deletes exactly the name generated above, never bound anywhere.
        unsafe { gl.delete_textures(1, &sampler_texture) };

        verify_renderbuffer(tex_fmt, &reference, &result)
    }
}

/// `LastFragDataTestCase`
struct LastFragDataCase;

impl TestCase for LastFragDataCase {
    fn name(&self) -> &str {
        "last_frag_data"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_case_support(context, glw::GL_RGBA8)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let tex_fmt = tex_fmt_of_rgba8();
        let transfer_fmt = get_transfer_format(tex_fmt)?;

        const VERTEX_SOURCE: &str = concat!(
            "#version 100\n",
            "attribute vec4 a_position;\n\n",
            "void main (void)\n",
            "{\n",
            "    gl_Position = a_position;\n",
            "}\n"
        );
        const FRAGMENT_SOURCE: &str = concat!(
            "#version 100\n",
            "#extension GL_EXT_shader_framebuffer_fetch : require\n",
            "uniform highp vec4 u_color;\n",
            "\n",
            "void main (void)\n",
            "{\n",
            "    gl_FragColor = u_color + gl_LastFragData[0];\n",
            "}\n"
        );

        let program = build_program(gl, &ProgramSources::vtx_frag(VERTEX_SOURCE, FRAGMENT_SOURCE))?;
        // SAFETY: `program` was just built successfully.
        unsafe { gl.use_program(program.program()) };

        let uniform_color = scale_color_value(tex_fmt, [0.1, 0.1, 0.1, 1.0]);
        let fb_color = scale_color_value(tex_fmt, [0.5, 0.0, 0.0, 1.0]);

        let mut reference = TextureLevel::new(tex_fmt, VIEWPORT_WIDTH as u32, VIEWPORT_HEIGHT as u32, 1)?;
        clear(&mut reference.get_access(), add4(fb_color, uniform_color));

        let mut result = TextureLevel::new(
            get_read_pixel_format(tex_fmt),
            VIEWPORT_WIDTH as u32,
            VIEWPORT_HEIGHT as u32,
            1,
        )?;

        let (_framebuffer, _texture) =
            gen_framebuffer_with_texture(gl, glw::GL_RGBA8, tex_fmt, transfer_fmt, fb_color)?;
        gen_uniform_color(gl, &program, tex_fmt, uniform_color)?;
        render(gl, &program)?;

        read_pixels(&context.render_context, 0, 0, &mut result.get_access())?;

        verify_renderbuffer(tex_fmt, &reference, &result)
    }
}

/// `FragmentDiscardTestCase`
struct FragmentDiscardCase;

impl TestCase for FragmentDiscardCase {
    fn name(&self) -> &str {
        "fragment_discard"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_case_support(context, glw::GL_RGBA8)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let tex_fmt = tex_fmt_of_rgba8();
        let transfer_fmt = get_transfer_format(tex_fmt)?;

        const FRAGMENT_SOURCE: &str = concat!(
            "#version 310 es\n",
            "#extension GL_EXT_shader_framebuffer_fetch : require\n",
            "layout(location = 0) inout highp vec4 o_color;\n",
            "uniform highp vec4 u_color;\n",
            "\n",
            "void main (void)\n",
            "{\n",
            "    const highp float threshold = 0.0005f;\n",
            "    bool valuesEqual = all(lessThan(abs(o_color - u_color), vec4(threshold)));\n",
            "\n",
            "    if (valuesEqual)\n",
            "        o_color += u_color;\n",
            "    else\n",
            "        discard;\n",
            "}\n"
        );

        let program = build_program(gl, &ProgramSources::vtx_frag(PASS_THROUGH_VERT_SOURCE, FRAGMENT_SOURCE))?;
        // SAFETY: `program` was just built successfully.
        unsafe { gl.use_program(program.program()) };

        let fb_color_even = scale_color_value(tex_fmt, [0.5, 0.0, 1.0, 1.0]);
        let fb_color_odd = scale_color_value(tex_fmt, [0.0, 1.0, 1.0, 1.0]);

        // `genFramebufferWithGrid` upstream: the same shape as `gen_framebuffer_with_texture`,
        // just filled with a grid pattern instead of a solid colour (and with no
        // explicit filter/wrap parameters at all - the texture's own GL defaults apply).
        let framebuffer = Framebuffer::new(gl);
        // SAFETY: binding a framebuffer this function owns.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.get()) };

        let mut data = TextureLevel::new(tex_fmt, VIEWPORT_WIDTH as u32, VIEWPORT_HEIGHT as u32, 1)?;
        fill_with_grid_2d(&mut data.get_access(), 8, fb_color_even, fb_color_odd);

        let texture = Texture::new(gl);
        // SAFETY: `texture` and `framebuffer` are fresh objects this function owns.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D, texture.get());
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA8 as GLint,
                VIEWPORT_WIDTH,
                VIEWPORT_HEIGHT,
                0,
                transfer_fmt.format,
                transfer_fmt.data_type,
                data.data().as_ptr().cast(),
            );
            gl.bind_texture(glw::GL_TEXTURE_2D, 0);

            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                texture.get(),
                0,
            );
            if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                return Err(TestError::Fail("Framebuffer was not complete".to_string()));
            }
        }

        // `FragmentDiscardTestCase::genReferenceTexture` writes `fbColorEven +
        // fbColorEven` for the even cells - numerically identical to `fbColorEven +
        // uniformColor` here, since `uniformColor` passed to `genUniformColor` below
        // *is* `fbColorEven`. The odd cells are discarded and keep their original colour.
        let mut reference = TextureLevel::new(tex_fmt, VIEWPORT_WIDTH as u32, VIEWPORT_HEIGHT as u32, 1)?;
        fill_with_grid_2d(
            &mut reference.get_access(),
            8,
            add4(fb_color_even, fb_color_even),
            fb_color_odd,
        );

        let mut result = TextureLevel::new(
            get_read_pixel_format(tex_fmt),
            VIEWPORT_WIDTH as u32,
            VIEWPORT_HEIGHT as u32,
            1,
        )?;

        gen_uniform_color(gl, &program, tex_fmt, fb_color_even)?;
        render(gl, &program)?;

        read_pixels(&context.render_context, 0, 0, &mut result.get_access())?;

        verify_renderbuffer(tex_fmt, &reference, &result)
    }
}

/// `MultipleAssignmentTestCase`
struct MultipleAssignmentCase;

fn fill_multiple_assignment_reference(access: &mut PixelBufferAccess<'_>, fb_color: [f32; 4], uniform_color: [f32; 4]) {
    let [width, height, _] = access.size();
    let left = width / 2;
    let top = height / 2;
    let composite: [f32; 4] = std::array::from_fn(|i| uniform_color[i] * 2.0);
    let color_composite = add4(fb_color, composite);
    let color_single = add4(fb_color, uniform_color);

    clear(
        &mut access.get_subregion(left, 0, 0, width - left, top, 1),
        color_composite,
    );
    clear(
        &mut access.get_subregion(0, top, 0, left, height - top, 1),
        color_single,
    );
    clear(
        &mut access.get_subregion(left, top, 0, width - left, height - top, 1),
        color_composite,
    );
    clear(&mut access.get_subregion(0, 0, 0, left, top, 1), color_single);
}

impl TestCase for MultipleAssignmentCase {
    fn name(&self) -> &str {
        "multiple_assignment"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_case_support(context, glw::GL_RGBA8)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let tex_fmt = tex_fmt_of_rgba8();
        let transfer_fmt = get_transfer_format(tex_fmt)?;

        const VERTEX_SOURCE: &str = concat!(
            "#version 310 es\n",
            "in highp vec4 a_position;\n",
            "out highp vec4 v_position;\n",
            "\n",
            "void main (void)\n",
            "{\n",
            "    gl_Position = a_position;\n",
            "    v_position  = gl_Position;\n",
            "}\n"
        );
        const FRAGMENT_SOURCE: &str = concat!(
            "#version 310 es\n",
            "#extension GL_EXT_shader_framebuffer_fetch : require\n",
            "in highp vec4 v_position;\n",
            "layout(location = 0) inout highp vec4 o_color;\n",
            "uniform highp vec4 u_color;\n",
            "\n",
            "void main (void)\n",
            "{\n",
            "    if (v_position.x > 0.0f)\n",
            "        o_color += u_color;\n",
            "\n",
            "    o_color += u_color;\n",
            "}\n"
        );

        let program = build_program(gl, &ProgramSources::vtx_frag(VERTEX_SOURCE, FRAGMENT_SOURCE))?;
        // SAFETY: `program` was just built successfully.
        unsafe { gl.use_program(program.program()) };

        let fb_color = scale_color_value(tex_fmt, [0.5, 0.0, 0.0, 1.0]);
        let uniform_color = scale_color_value(tex_fmt, [0.25, 0.0, 0.0, 1.0]);

        let mut reference = TextureLevel::new(tex_fmt, VIEWPORT_WIDTH as u32, VIEWPORT_HEIGHT as u32, 1)?;
        fill_multiple_assignment_reference(&mut reference.get_access(), fb_color, uniform_color);

        let mut result = TextureLevel::new(
            get_read_pixel_format(tex_fmt),
            VIEWPORT_WIDTH as u32,
            VIEWPORT_HEIGHT as u32,
            1,
        )?;

        let (_framebuffer, _texture) =
            gen_framebuffer_with_texture(gl, glw::GL_RGBA8, tex_fmt, transfer_fmt, fb_color)?;
        gen_uniform_color(gl, &program, tex_fmt, uniform_color)?;
        render(gl, &program)?;

        read_pixels(&context.render_context, 0, 0, &mut result.get_access())?;

        verify_renderbuffer(tex_fmt, &reference, &result)
    }
}

/// `MultipleRenderTargetsTestCase`
struct MultipleRenderTargetsCase;

const MRT_ATTACHMENTS: [GLenum; 4] = [
    glw::GL_COLOR_ATTACHMENT0,
    glw::GL_COLOR_ATTACHMENT1,
    glw::GL_COLOR_ATTACHMENT2,
    glw::GL_COLOR_ATTACHMENT3,
];

impl TestCase for MultipleRenderTargetsCase {
    fn name(&self) -> &str {
        "multiple_render_targets"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_case_support(context, glw::GL_RGBA8)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let tex_fmt = tex_fmt_of_rgba8();
        let transfer_fmt = get_transfer_format(tex_fmt)?;

        const FRAGMENT_SOURCE: &str = concat!(
            "#version 310 es\n",
            "#extension GL_EXT_shader_framebuffer_fetch : require\n",
            "layout(location = 0) inout highp vec4 o_color0;\n",
            "layout(location = 1) inout highp vec4 o_color1;\n",
            "layout(location = 2) inout highp vec4 o_color2;\n",
            "layout(location = 3) inout highp vec4 o_color3;\n",
            "uniform highp vec4 u_color;\n",
            "\n",
            "void main (void)\n",
            "{\n",
            "    o_color0 += u_color;\n",
            "    o_color1 += u_color;\n",
            "    o_color2 += u_color;\n",
            "    o_color3 += u_color;\n",
            "}\n"
        );

        let program = build_program(gl, &ProgramSources::vtx_frag(PASS_THROUGH_VERT_SOURCE, FRAGMENT_SOURCE))?;
        // SAFETY: `program` was just built successfully.
        unsafe { gl.use_program(program.program()) };

        let uniform_color = scale_color_value(tex_fmt, [0.1, 0.1, 0.1, 1.0]);
        let colors = [
            scale_color_value(tex_fmt, [0.9, 0.0, 0.0, 1.0]),
            scale_color_value(tex_fmt, [0.0, 0.9, 0.0, 1.0]),
            scale_color_value(tex_fmt, [0.0, 0.0, 0.9, 1.0]),
            scale_color_value(tex_fmt, [0.0, 0.9, 0.9, 1.0]),
        ];

        let framebuffer = Framebuffer::new(gl);
        // SAFETY: binding a framebuffer this function owns.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.get()) };

        let mut textures = Vec::with_capacity(4);
        for &color in &colors {
            textures.push(gen_attachment_texture(gl, glw::GL_RGBA8, tex_fmt, transfer_fmt, color)?);
        }
        expect_no_error(gl, "genAttachmentTextures()")?;

        // SAFETY: attaching the four textures this function just built.
        unsafe {
            for (i, texture) in textures.iter().enumerate() {
                gl.framebuffer_texture_2d(
                    glw::GL_FRAMEBUFFER,
                    MRT_ATTACHMENTS[i],
                    glw::GL_TEXTURE_2D,
                    texture.get(),
                    0,
                );
            }
            if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                return Err(TestError::Fail("Framebuffer was not complete".to_string()));
            }
            gl.draw_buffers(MRT_ATTACHMENTS.len() as glw::GLsizei, MRT_ATTACHMENTS.as_ptr());
        }
        expect_no_error(gl, "genFramebufferWithTextures()")?;

        gen_uniform_color(gl, &program, tex_fmt, uniform_color)?;
        render(gl, &program)?;

        let mut result = TextureLevel::new(
            get_read_pixel_format(tex_fmt),
            VIEWPORT_WIDTH as u32,
            VIEWPORT_HEIGHT as u32,
            1,
        )?;

        // Upstream's own loop calls `verifyRenderbuffer` once per attachment with no
        // early exit, and that helper resets the verdict to Pass at the top of every
        // call - so only the *last* attachment's comparison survives in the final
        // result, whichever the earlier three said. Ported exactly: this is what a real
        // `deqp-gles31` run also does, and an aggregated/early-exit verdict here would
        // disagree with it on a case where an earlier buffer fails and the last passes.
        let mut last_status = TestStatus::pass("Pass");
        for (i, &color) in colors.iter().enumerate() {
            let mut reference = TextureLevel::new(tex_fmt, VIEWPORT_WIDTH as u32, VIEWPORT_HEIGHT as u32, 1)?;
            clear(&mut reference.get_access(), add4(color, uniform_color));

            // SAFETY: `i` indexes one of the four attachments just bound above.
            unsafe { gl.read_buffer(MRT_ATTACHMENTS[i]) };
            read_pixels(&context.render_context, 0, 0, &mut result.get_access())?;

            last_status = verify_renderbuffer(tex_fmt, &reference, &result)?;
        }

        Ok(last_status)
    }
}

/// `MultipleRenderTargetsOverdrawTestCase::clearWithScissors`
fn clear_with_scissor(access: &mut PixelBufferAccess<'_>, color: [f32; 4], scissor: [i32; 4]) {
    let [width, height, _] = access.size();
    for y in 0..height as i32 {
        for x in 0..width as i32 {
            if y >= scissor[1] && y < scissor[1] + scissor[3] && x >= scissor[0] && x < scissor[0] + scissor[2] {
                access.set_pixel(color, x as u32, y as u32, 0);
            }
        }
    }
}

fn swizzle_argb(c: [f32; 4]) -> [f32; 4] {
    [c[3], c[0], c[1], c[2]]
}

/// `MultipleRenderTargetsOverdrawTestCase`
struct MultipleRenderTargetsOverdrawCase;

const OVERDRAW_ATTACHMENTS: [GLenum; 2] = [glw::GL_COLOR_ATTACHMENT0, glw::GL_COLOR_ATTACHMENT1];

impl TestCase for MultipleRenderTargetsOverdrawCase {
    fn name(&self) -> &str {
        "multiple_render_targets_overdraw"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_case_support(context, glw::GL_RGBA8)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const OVERDRAW_COUNT: i32 = 4;

        let gl = context.gl();
        let tex_fmt = tex_fmt_of_rgba8();
        let transfer_fmt = get_transfer_format(tex_fmt)?;

        const FRAGMENT_SOURCE: &str = concat!(
            "#version 310 es\n",
            "#extension GL_EXT_shader_framebuffer_fetch : require\n",
            "layout(location = 0) inout highp vec4 o_color0;\n",
            "layout(location = 1) out highp vec4 o_color1;\n",
            "\n",
            "void main (void)\n",
            "{\n",
            "    o_color0 = o_color0.argb;\n",
            "    o_color1 = o_color0.argb;\n",
            "}\n"
        );

        let program = build_program(gl, &ProgramSources::vtx_frag(PASS_THROUGH_VERT_SOURCE, FRAGMENT_SOURCE))?;
        // SAFETY: `program` was just built successfully.
        unsafe { gl.use_program(program.program()) };

        let colors = [
            scale_color_value(tex_fmt, [1.0, 0.0, 0.0, 0.0]),
            scale_color_value(tex_fmt, [0.0, 0.0, 0.0, 0.0]),
        ];

        let framebuffer = Framebuffer::new(gl);
        // SAFETY: binding a framebuffer this function owns.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.get()) };

        // `genAttachmentTextures` upstream: GL_NEAREST unconditionally, and no wrap mode
        // set at all - unlike the shared `gen_attachment_texture` helper the other cases
        // use, so not reused here.
        let mut textures = Vec::with_capacity(2);
        for &color in &colors {
            let mut data = TextureLevel::new(tex_fmt, VIEWPORT_WIDTH as u32, VIEWPORT_HEIGHT as u32, 1)?;
            fill_solid(&mut data.get_access(), tex_fmt, color)?;
            let texture = Texture::new(gl);
            // SAFETY: `texture` is a fresh object this function owns.
            unsafe {
                gl.bind_texture(glw::GL_TEXTURE_2D, texture.get());
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
                gl.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    glw::GL_RGBA8 as GLint,
                    VIEWPORT_WIDTH,
                    VIEWPORT_HEIGHT,
                    0,
                    transfer_fmt.format,
                    transfer_fmt.data_type,
                    data.data().as_ptr().cast(),
                );
            }
            textures.push(texture);
        }
        // SAFETY: unbinding the last texture bound in the loop above.
        unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, 0) };
        expect_no_error(gl, "genAttachmentTextures()")?;

        // SAFETY: attaching the two textures this function just built.
        unsafe {
            for (i, texture) in textures.iter().enumerate() {
                gl.framebuffer_texture_2d(
                    glw::GL_FRAMEBUFFER,
                    OVERDRAW_ATTACHMENTS[i],
                    glw::GL_TEXTURE_2D,
                    texture.get(),
                    0,
                );
            }
            if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                return Err(TestError::Fail("Framebuffer was not complete".to_string()));
            }
            gl.draw_buffers(
                OVERDRAW_ATTACHMENTS.len() as glw::GLsizei,
                OVERDRAW_ATTACHMENTS.as_ptr(),
            );
        }
        expect_no_error(gl, "genFramebufferWithTextures()")?;

        let mut reference0 = TextureLevel::new(tex_fmt, VIEWPORT_WIDTH as u32, VIEWPORT_HEIGHT as u32, 1)?;
        let mut reference1 = TextureLevel::new(tex_fmt, VIEWPORT_WIDTH as u32, VIEWPORT_HEIGHT as u32, 1)?;

        // SAFETY: scissor state affects only draws inside this function's own
        // framebuffer binding, and is disabled again before returning.
        unsafe { gl.enable(glw::GL_SCISSOR_TEST) };

        let mut buffer0_color = [1.0f32, 0.0, 0.0, 0.0];
        for i in 0..OVERDRAW_COUNT {
            let scissor = [0, 0, VIEWPORT_WIDTH >> i, VIEWPORT_HEIGHT >> i];
            // SAFETY: `scissor` values are all non-negative and within the viewport.
            unsafe { gl.scissor(scissor[0], scissor[1], scissor[2], scissor[3]) };
            render(gl, &program)?;

            buffer0_color = swizzle_argb(buffer0_color);
            let buffer1_color = swizzle_argb(buffer0_color);

            clear_with_scissor(&mut reference0.get_access(), buffer0_color, scissor);
            clear_with_scissor(&mut reference1.get_access(), buffer1_color, scissor);
        }
        // SAFETY: matches the `enable` above.
        unsafe { gl.disable(glw::GL_SCISSOR_TEST) };

        let mut result = TextureLevel::new(
            get_read_pixel_format(tex_fmt),
            VIEWPORT_WIDTH as u32,
            VIEWPORT_HEIGHT as u32,
            1,
        )?;

        // SAFETY: `OVERDRAW_ATTACHMENTS[0]` is bound to this framebuffer above.
        unsafe { gl.read_buffer(OVERDRAW_ATTACHMENTS[0]) };
        read_pixels(&context.render_context, 0, 0, &mut result.get_access())?;
        let status0 = verify_renderbuffer(tex_fmt, &reference0, &result)?;
        if status0.code() != TestResult::Pass {
            return Ok(status0);
        }

        // SAFETY: `OVERDRAW_ATTACHMENTS[1]` is bound to this framebuffer above.
        unsafe { gl.read_buffer(OVERDRAW_ATTACHMENTS[1]) };
        read_pixels(&context.render_context, 0, 0, &mut result.get_access())?;
        verify_renderbuffer(tex_fmt, &reference1, &result)
    }
}

fn fill_quadrant_reference(access: &mut PixelBufferAccess<'_>, color: [f32; 4]) {
    let [width, height, _] = access.size();
    let left = width / 2;
    let top = height / 2;
    clear(&mut access.get_subregion(left, 0, 0, width - left, top, 1), color);
    clear(&mut access.get_subregion(0, top, 0, left, height - top, 1), color);
    clear(
        &mut access.get_subregion(left, top, 0, width - left, height - top, 1),
        color,
    );
    clear(&mut access.get_subregion(0, 0, 0, left, top, 1), color);
}

/// `TextureLevelTestCase` - registered as `framebuffer_texture_level`. Uses the base
/// class's own `genShaderSources` (no override upstream), same as `TextureFormatCase`.
struct TextureLevelCase;

impl TestCase for TextureLevelCase {
    fn name(&self) -> &str {
        "framebuffer_texture_level"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_case_support(context, glw::GL_RGBA8)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let tex_fmt = tex_fmt_of_rgba8();
        let transfer_fmt = get_transfer_format(tex_fmt)?;

        let program = build_program(
            gl,
            &ProgramSources::vtx_frag(PASS_THROUGH_VERT_SOURCE, base_fragment_source(tex_fmt)),
        )?;
        // SAFETY: `program` was just built successfully.
        unsafe { gl.use_program(program.program()) };

        let uniform_color = scale_color_value(tex_fmt, [0.1, 0.0, 0.0, 1.0]);
        let level_colors = [
            scale_color_value(tex_fmt, [0.4, 0.0, 0.0, 1.0]),
            scale_color_value(tex_fmt, [0.2, 0.0, 0.0, 1.0]),
            scale_color_value(tex_fmt, [0.0, 0.0, 0.0, 1.0]),
        ];

        let framebuffer = Framebuffer::new(gl);
        // SAFETY: binding a framebuffer this function owns.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.get()) };

        let texture = Texture::new(gl);
        // SAFETY: `texture` is a fresh object this function owns; every upload below is
        // sized to exactly the mip level it targets.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, texture.get());
            gl.tex_image_3d(
                glw::GL_TEXTURE_2D_ARRAY,
                0,
                glw::GL_RGBA8 as GLint,
                VIEWPORT_WIDTH,
                VIEWPORT_HEIGHT,
                1,
                0,
                transfer_fmt.format,
                transfer_fmt.data_type,
                std::ptr::null(),
            );
            gl.generate_mipmap(glw::GL_TEXTURE_2D_ARRAY);

            for (level, &color) in level_colors.iter().enumerate() {
                let level_w = (VIEWPORT_WIDTH >> level).max(1);
                let level_h = (VIEWPORT_HEIGHT >> level).max(1);
                let mut level_data = TextureLevel::new(tex_fmt, level_w as u32, level_h as u32, 1)?;
                fill_solid(&mut level_data.get_access(), tex_fmt, color)?;
                gl.tex_image_3d(
                    glw::GL_TEXTURE_2D_ARRAY,
                    level as GLint,
                    glw::GL_RGBA8 as GLint,
                    level_w,
                    level_h,
                    1,
                    0,
                    transfer_fmt.format,
                    transfer_fmt.data_type,
                    level_data.data().as_ptr().cast(),
                );
            }
            gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, 0);
        }
        expect_no_error(gl, "create2DTextureArrayMipMaps()")?;

        for (level, &color) in level_colors.iter().enumerate() {
            let level_w = (VIEWPORT_WIDTH >> level).max(1);
            let level_h = (VIEWPORT_HEIGHT >> level).max(1);

            let mut reference = TextureLevel::new(tex_fmt, level_w as u32, level_h as u32, 1)?;
            fill_quadrant_reference(&mut reference.get_access(), add4(color, uniform_color));

            let mut result = TextureLevel::new(get_read_pixel_format(tex_fmt), level_w as u32, level_h as u32, 1)?;

            // SAFETY: `level` is one of the mip levels uploaded above.
            unsafe {
                gl.framebuffer_texture_layer(
                    glw::GL_DRAW_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    texture.get(),
                    level as GLint,
                    0,
                )
            };

            gen_uniform_color(gl, &program, tex_fmt, uniform_color)?;
            render(gl, &program)?;

            read_pixels(&context.render_context, 0, 0, &mut result.get_access())?;

            let status = verify_renderbuffer(tex_fmt, &reference, &result)?;
            if status.code() != TestResult::Pass {
                return Ok(status);
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `TextureLayerTestCase` - registered as `framebuffer_texture_layer`. Also uses the
/// base class's own `genShaderSources`.
struct TextureLayerCase;

impl TestCase for TextureLayerCase {
    fn name(&self) -> &str {
        "framebuffer_texture_layer"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_case_support(context, glw::GL_RGBA8)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let tex_fmt = tex_fmt_of_rgba8();
        let transfer_fmt = get_transfer_format(tex_fmt)?;

        let program = build_program(
            gl,
            &ProgramSources::vtx_frag(PASS_THROUGH_VERT_SOURCE, base_fragment_source(tex_fmt)),
        )?;
        // SAFETY: `program` was just built successfully.
        unsafe { gl.use_program(program.program()) };

        let uniform_color = scale_color_value(tex_fmt, [0.1, 0.1, 0.1, 1.0]);
        let layer_colors = [
            scale_color_value(tex_fmt, [0.4, 0.0, 0.0, 1.0]),
            scale_color_value(tex_fmt, [0.2, 0.0, 0.0, 1.0]),
            scale_color_value(tex_fmt, [0.0, 0.0, 0.0, 1.0]),
        ];

        let framebuffer = Framebuffer::new(gl);
        // SAFETY: binding a framebuffer this function owns.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.get()) };

        let texture = Texture::new(gl);
        // SAFETY: `texture` is a fresh object this function owns.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, texture.get());
            gl.tex_storage_3d(
                glw::GL_TEXTURE_2D_ARRAY,
                1,
                glw::GL_RGBA8,
                VIEWPORT_WIDTH,
                VIEWPORT_HEIGHT,
                layer_colors.len() as GLint,
            );
            // `create2DTextureArrayLayers` upstream: binds this same texture as a
            // read-only image at unit 0 - dead state, unrelated to anything the shader
            // reads, ported verbatim.
            gl.bind_image_texture(
                0,
                texture.get(),
                0,
                glw::GL_FALSE as glw::GLboolean,
                0,
                glw::GL_READ_ONLY,
                glw::GL_RGBA8,
            );

            for (layer, &color) in layer_colors.iter().enumerate() {
                let mut layer_data = TextureLevel::new(tex_fmt, VIEWPORT_WIDTH as u32, VIEWPORT_HEIGHT as u32, 1)?;
                fill_solid(&mut layer_data.get_access(), tex_fmt, color)?;
                gl.tex_sub_image_3d(
                    glw::GL_TEXTURE_2D_ARRAY,
                    0,
                    0,
                    0,
                    layer as GLint,
                    VIEWPORT_WIDTH,
                    VIEWPORT_HEIGHT,
                    1,
                    transfer_fmt.format,
                    transfer_fmt.data_type,
                    layer_data.data().as_ptr().cast(),
                );
            }
            gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, 0);
        }
        expect_no_error(gl, "create2DTextureArrayLayers()")?;

        for (layer, &color) in layer_colors.iter().enumerate() {
            let mut reference = TextureLevel::new(tex_fmt, VIEWPORT_WIDTH as u32, VIEWPORT_HEIGHT as u32, 1)?;
            clear(&mut reference.get_access(), add4(color, uniform_color));

            let mut result = TextureLevel::new(
                get_read_pixel_format(tex_fmt),
                VIEWPORT_WIDTH as u32,
                VIEWPORT_HEIGHT as u32,
                1,
            )?;

            // SAFETY: `layer` is one of the array layers uploaded above.
            unsafe {
                gl.framebuffer_texture_layer(
                    glw::GL_DRAW_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    texture.get(),
                    0,
                    layer as GLint,
                )
            };

            gen_uniform_color(gl, &program, tex_fmt, uniform_color)?;
            render(gl, &program)?;

            read_pixels(&context.render_context, 0, 0, &mut result.get_access())?;

            let status = verify_renderbuffer(tex_fmt, &reference, &result)?;
            if status.code() != TestResult::Pass {
                return Ok(status);
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `ShaderFramebufferFetchTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("framebuffer_fetch");

    let mut basic = TestCaseGroup::new("basic");
    basic.add_child(Box::new(TexelFetchCase) as Box<dyn TestCase>);
    basic.add_child(Box::new(LastFragDataCase) as Box<dyn TestCase>);
    basic.add_child(Box::new(FragmentDiscardCase) as Box<dyn TestCase>);
    basic.add_child(Box::new(MultipleAssignmentCase) as Box<dyn TestCase>);
    basic.add_child(Box::new(MultipleRenderTargetsCase) as Box<dyn TestCase>);
    basic.add_child(Box::new(MultipleRenderTargetsOverdrawCase) as Box<dyn TestCase>);
    basic.add_child(Box::new(TextureLevelCase) as Box<dyn TestCase>);
    basic.add_child(Box::new(TextureLayerCase) as Box<dyn TestCase>);
    group.add_child(basic);

    group.add_child(create_framebuffer_format_tests());

    group
}
