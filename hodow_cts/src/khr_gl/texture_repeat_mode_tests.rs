// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcTextureRepeatModeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream keeps two tables (`glInternalFormats`, `esInternalFormats`) and looks the tested format up in one of them for its `format`, `type` and sampler class; only the desktop rows of the nine tested formats are used here, so those three fields sit in `FormatInfo` itself and the ES table has no counterpart. `calcTextureEpsilon` reads GL_RED_BITS and friends, which a core context rejects with INVALID_ENUM and leaves the outputs unwritten (uninitialised upstream); they start at 8 here, the depth of the RGBA8 target.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const MAX_PIXEL_SIZE: usize = 16;

#[derive(Clone, Copy, PartialEq, Eq)]
enum Sampler {
    Unorm,
    Uint,
}

/// `FormatInfo`, with the three `InternalFormat` fields the test looks up.
struct FormatInfo {
    internalformat: GLenum,
    name: &'static str,
    format: GLenum,
    type_: GLenum,
    sampler: Sampler,
    /// `internalred`, `internalgreen`, `internalblue`, `internalwhite`
    internal: [&'static [u8]; 4],
    /// `RGBAred`, `RGBAgreen`, `RGBAblue`, `RGBAwhite`
    rgba: [[u8; 4]; 4],
}

const RED: usize = 0;
const GREEN: usize = 1;
const BLUE: usize = 2;
const WHITE: usize = 3;

/// `testedFormats`; the representation is little endian, so these fail on a big endian host.
static TESTED_FORMATS: [FormatInfo; 9] = [
    FormatInfo {
        internalformat: glw::GL_R8,
        name: "r8",
        format: glw::GL_RED,
        type_: glw::GL_UNSIGNED_BYTE,
        sampler: Sampler::Unorm,
        internal: [&[0xFF], &[0xC7], &[0x30], &[0x00]],
        rgba: [
            [0xFF, 0x00, 0x00, 0xFF],
            [0xC7, 0x00, 0x00, 0xFF],
            [0x30, 0x00, 0x00, 0xFF],
            [0x00, 0x00, 0x00, 0xFF],
        ],
    },
    FormatInfo {
        internalformat: glw::GL_RGB565,
        name: "rgb565",
        format: glw::GL_RGB,
        type_: glw::GL_UNSIGNED_SHORT_5_6_5,
        sampler: Sampler::Unorm,
        internal: [&[0x00, 0xF8], &[0xE0, 0x07], &[0x1F, 0x00], &[0xFF, 0xFF]],
        rgba: [
            [0xFF, 0x00, 0x00, 0xFF],
            [0x00, 0xFF, 0x00, 0xFF],
            [0x00, 0x00, 0xFF, 0xFF],
            [0xFF, 0xFF, 0xFF, 0xFF],
        ],
    },
    FormatInfo {
        internalformat: glw::GL_RGB8,
        name: "rgb8",
        format: glw::GL_RGB,
        type_: glw::GL_UNSIGNED_BYTE,
        sampler: Sampler::Unorm,
        internal: [
            &[0xFF, 0x00, 0x00],
            &[0x00, 0xFF, 0x00],
            &[0x00, 0x00, 0xFF],
            &[0xFF, 0xFF, 0xFF],
        ],
        rgba: [
            [0xFF, 0x00, 0x00, 0xFF],
            [0x00, 0xFF, 0x00, 0xFF],
            [0x00, 0x00, 0xFF, 0xFF],
            [0xFF, 0xFF, 0xFF, 0xFF],
        ],
    },
    FormatInfo {
        internalformat: glw::GL_RGB10_A2,
        name: "rgb10_a2",
        format: glw::GL_RGBA,
        type_: glw::GL_UNSIGNED_INT_2_10_10_10_REV,
        sampler: Sampler::Unorm,
        internal: [
            &[0xFF, 0x03, 0x00, 0xC0],
            &[0x00, 0xFC, 0x0F, 0xC0],
            &[0x00, 0x00, 0xF0, 0xFF],
            &[0xFF, 0xFF, 0xFF, 0xFF],
        ],
        rgba: [
            [0xFF, 0x00, 0x00, 0xFF],
            [0x00, 0xFF, 0x00, 0xFF],
            [0x00, 0x00, 0xFF, 0xFF],
            [0xFF, 0xFF, 0xFF, 0xFF],
        ],
    },
    FormatInfo {
        internalformat: glw::GL_R32UI,
        name: "r32ui",
        format: glw::GL_RED_INTEGER,
        type_: glw::GL_UNSIGNED_INT,
        sampler: Sampler::Uint,
        internal: [
            &[0xFF, 0x00, 0x00, 0x00],
            &[0x51, 0x00, 0x00, 0x00],
            &[0xF3, 0x00, 0x00, 0x00],
            &[0x00, 0x00, 0x00, 0x00],
        ],
        rgba: [
            [0xFF, 0x00, 0x00, 0xFF],
            [0x51, 0x00, 0x00, 0xFF],
            [0xF3, 0x00, 0x00, 0xFF],
            [0x00, 0x00, 0x00, 0xFF],
        ],
    },
    FormatInfo {
        internalformat: glw::GL_RG32UI,
        name: "rg32ui",
        format: glw::GL_RG_INTEGER,
        type_: glw::GL_UNSIGNED_INT,
        sampler: Sampler::Uint,
        internal: [
            &[0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00],
            &[0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF],
            &[0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
            &[0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF],
        ],
        rgba: [
            [0xFF, 0x00, 0x00, 0xFF],
            [0x00, 0xFF, 0x00, 0xFF],
            [0x00, 0x00, 0x00, 0xFF],
            [0xFF, 0xFF, 0x00, 0xFF],
        ],
    },
    FormatInfo {
        internalformat: glw::GL_RGBA32UI,
        name: "rgba32ui",
        format: glw::GL_RGBA_INTEGER,
        type_: glw::GL_UNSIGNED_INT,
        sampler: Sampler::Uint,
        internal: [
            &[
                0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF,
            ],
            &[
                0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF,
            ],
            &[
                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
            ],
            &[
                0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
            ],
        ],
        rgba: [
            [0xFF, 0x00, 0x00, 0xFF],
            [0x00, 0xFF, 0x00, 0xFF],
            [0x00, 0x00, 0xFF, 0xFF],
            [0xFF, 0xFF, 0xFF, 0xFF],
        ],
    },
    FormatInfo {
        internalformat: glw::GL_DEPTH_COMPONENT16,
        name: "depth_component16",
        format: glw::GL_DEPTH_COMPONENT,
        type_: glw::GL_UNSIGNED_SHORT,
        sampler: Sampler::Unorm,
        internal: [&[0xFF, 0xE8], &[0xFF, 0xAB], &[0x00, 0x78], &[0x00, 0x3C]],
        rgba: [
            [0x00, 0x00, 0x00, 0xff],
            [0x00, 0x00, 0xff, 0xff],
            [0x00, 0xff, 0xff, 0xff],
            [0xff, 0xff, 0xff, 0xff],
        ],
    },
    FormatInfo {
        internalformat: glw::GL_DEPTH24_STENCIL8,
        name: "depth24_stencil8",
        format: glw::GL_DEPTH_STENCIL,
        type_: glw::GL_UNSIGNED_INT_24_8,
        sampler: Sampler::Unorm,
        internal: [
            &[0x00, 0x00, 0xE8, 0xFF],
            &[0x88, 0x00, 0xAB, 0xAF],
            &[0xBB, 0x28, 0x55, 0x7F],
            &[0xFF, 0x78, 0x80, 0x02],
        ],
        rgba: [
            [0x00, 0x00, 0x00, 0xff],
            [0x00, 0x00, 0xff, 0xff],
            [0x00, 0xff, 0xff, 0xff],
            [0xff, 0xff, 0xff, 0xff],
        ],
    },
];

const BASIC_VS: &str = "precision mediump float;\nout vec2 texCoord;\nvoid main(void)\n{\n    switch(gl_VertexID)\n    {\n        case 0:\n            gl_Position = vec4( 1.0,-1.0, 0.0, 1.0);\n            texCoord = vec2(2.0, -1.0);\n            break;\n        case 1:\n            gl_Position = vec4( 1.0, 1.0, 0.0, 1.0);\n            texCoord = vec2(2.0, 2.0);\n            break;\n        case 2:\n            gl_Position = vec4(-1.0,-1.0, 0.0, 1.0);\n            texCoord = vec2(-1.0, -1.0);\n            break;\n        case 3:\n            gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);\n            texCoord = vec2(-1.0, 2.0);\n            break;\n    }\n}";

const BASIC_FS: &str = "precision mediump float;\nuniform sampler2D texture0;\nin vec2 texCoord;\nout vec4 color;\nvoid main(void)\n{\n    color = texture(texture0, texCoord);\n}";

const SHADOW_FS: &str = "precision mediump float;\nuniform mediump sampler2DShadow texture0;\nin  vec2 texCoord;\nout vec4 color;\nvoid main(void)\n{\n    float r = texture(texture0, vec3(texCoord.xy, 0.3));\n    float g = texture(texture0, vec3(texCoord.xy, 0.5));\n    float b = texture(texture0, vec3(texCoord.xy, 0.8));\n    color = vec4(r, g, b, 1.0);\n}\n";

const INTEGER_FS: &str = "precision mediump float;\nuniform mediump usampler2D texture0;\nin vec2 texCoord;\nout vec4 color;\nvoid main(void)\n{\n    highp uvec4 ci = texture(texture0, texCoord);\n    color = vec4(ci) / 255.0; // we are using an integer texture format - so convert to float\n    if (ci.a > 0u)\n        color.a = 1.0;\n    else\n        color.a = 0.0;\n}";

/// `TestClampModeForInternalFormat`
struct TestClampModeForInternalFormat {
    name: String,
    internal_format: GLenum,
    clamp_mode: GLenum,
    lod_level: i32,
    width: i32,
    height: i32,
}

fn find_format(internalformat: GLenum) -> &'static FormatInfo {
    TESTED_FORMATS
        .iter()
        .find(|format| format.internalformat == internalformat)
        .expect("every tested format is in the table")
}

/// `isEqual`
fn is_equal(color1: &[u8], color2: &[u8; 4], tolerance: u8) -> bool {
    (0..4).all(|i| (i32::from(color1[i]) - i32::from(color2[i])).abs() <= i32::from(tolerance))
}

/// The read-back pixels with a cursor, which is what `GLubyte *buf` and `buf += size` are upstream.
struct Cursor<'a> {
    buf: &'a [u8],
    pos: usize,
    what: &'static str,
}

impl Cursor<'_> {
    /// `count` pixels that must all equal `color`.
    fn expect_run(&mut self, color: &[u8; 4], tolerance: u8, count: i32) -> Result<(), TestError> {
        for _ in 0..count {
            if !is_equal(&self.buf[self.pos..self.pos + 4], color, tolerance) {
                return Err(TestError::Fail(format!("{} failed", self.what)));
            }
            self.pos += 4;
        }
        Ok(())
    }
}

/// `fillTextureWithColor` - RGBW quadrants, `texture_data` is filled from its start.
fn fill_texture_with_color(texture_data: &mut [u8], tex_width: i32, tex_height: i32, internalformat: GLenum) {
    let tested_format = find_format(internalformat);
    let size = tested_format.internal[RED].len();
    let mut pos = 0usize;
    let mut put = |color: &[u8]| {
        texture_data[pos..pos + size].copy_from_slice(color);
        pos += size;
    };

    let mut j = 0;
    while j < tex_height / 2 {
        let mut i = 0;
        while i < tex_width / 2 {
            put(tested_format.internal[RED]);
            i += 1;
        }
        while i < tex_width {
            put(tested_format.internal[GREEN]);
            i += 1;
        }
        j += 1;
    }
    while j < tex_height {
        let mut i = 0;
        while i < tex_width / 2 {
            put(tested_format.internal[BLUE]);
            i += 1;
        }
        while i < tex_width {
            put(tested_format.internal[WHITE]);
            i += 1;
        }
        j += 1;
    }
}

/// `clearTextures` - black into every level but `lod`, down to 1x1.
fn clear_textures(
    gl: &glw::Functions,
    target: GLenum,
    mut width: i32,
    mut height: i32,
    lod: i32,
    internalformat: GLenum,
    type_: GLenum,
    format: GLenum,
) {
    let mut level = lod;
    while level > 0 {
        width *= 2;
        height *= 2;
        level -= 1;
    }

    let tex_buf = vec![0u8; width as usize * height as usize * MAX_PIXEL_SIZE];
    loop {
        if level != lod {
            // SAFETY: `tex_buf` is sized for the largest level, which no later level exceeds.
            unsafe {
                gl.tex_image_2d(
                    target,
                    level,
                    internalformat as i32,
                    width,
                    height,
                    0,
                    format,
                    type_,
                    tex_buf.as_ptr().cast(),
                )
            };
        }
        level += 1;

        let continue_loop = !(height == 1 && width == 1);
        if width > 1 {
            width /= 2;
        }
        if height > 1 {
            height /= 2;
        }
        if !continue_loop {
            break;
        }
    }
}

/// `calcTextureEpsilon` - the error bound for the least accurate of the frame buffer and the texture.
fn calc_texture_epsilon(gl: &glw::Functions, texture_bits: [i32; 4]) -> [f32; 4] {
    let mut buffer_bits = [8i32; 4];
    // SAFETY: four GLint outs, one per call.
    unsafe {
        gl.get_integerv(glw::GL_RED_BITS, &mut buffer_bits[0]);
        gl.get_integerv(glw::GL_GREEN_BITS, &mut buffer_bits[1]);
        gl.get_integerv(glw::GL_BLUE_BITS, &mut buffer_bits[2]);
        gl.get_integerv(glw::GL_ALPHA_BITS, &mut buffer_bits[3]);
    }

    let mut texture_epsilon = [0.0f32; 4];
    for i in 0..4 {
        // 'exact'
        let mut bits = if texture_bits[i] == 0 { 1000 } else { texture_bits[i] };

        // The tests use 8-bit transfers and textures, so RGB10_A2 precision is limited to 8 bits.
        if bits > 8 {
            bits = 8;
        }

        if bits > buffer_bits[i] {
            bits = buffer_bits[i];
        }

        if bits == 0 {
            // infinity
            texture_epsilon[i] = 2.0;
        } else {
            let zero_epsilon = 2.0f32.powi(-13);
            texture_epsilon[i] = (1.0 / (2.0f32.powi(bits) - 1.0)) + zero_epsilon;
            texture_epsilon[i] = texture_epsilon[i].min(1.0);
        }

        // With an 8 bit frame buffer the right value is hit within one intensity level.
        if bits == 8 && buffer_bits[i] != 0 {
            texture_epsilon[i] /= 2.0;
        }
    }
    texture_epsilon
}

/// `proportion` - (a * b) / c with rounding.
fn proportion(a: i32, b: i32, c: i32) -> i32 {
    let result = a as f32 * b as f32;
    (0.5 + result / c as f32) as i32
}

/// `verifyClampToEdge`
fn verify_clamp_to_edge(
    gl: &glw::Functions,
    buf: &[u8],
    width_init: i32,
    height_init: i32,
    width: i32,
    height: i32,
    internalformat: GLenum,
) -> Result<bool, TestError> {
    let tested_format = find_format(internalformat);
    let red = &tested_format.rgba[RED];
    let green = &tested_format.rgba[GREEN];
    let blue = &tested_format.rgba[BLUE];
    let white = &tested_format.rgba[WHITE];
    let size = 4i32;
    let skip = 6i32;

    let red_w = proportion(width, width_init / 2, width_init);
    let red_h = proportion(height, height_init / 2, height_init);
    let bits = [8, 8, 8, 8];

    // (left, right, top, bottom)
    let check_area = (0, width, 0, height);

    let epsilonf = calc_texture_epsilon(gl, bits);
    let epsilons: [u8; 4] = std::array::from_fn(|i| (epsilonf[i] * 255.0) as u8);

    let mut cursor = Cursor {
        buf,
        pos: 0,
        what: "verifyClampToEdge",
    };

    let mut i;
    let mut h = 0;
    while h < red_h - skip / 2 {
        i = 0;
        while i < red_w - skip / 2 {
            // skip over corner pixel to avoid issues with mipmap selection
            if (i >= check_area.0 || h >= check_area.2) && !is_equal(&cursor.buf[cursor.pos..], red, epsilons[0]) {
                return Err(TestError::Fail("verifyClampToEdge failed".to_string()));
            }
            cursor.pos += size as usize;
            i += 1;
        }

        // skip over border pixels to avoid issues with rounding
        i += skip;
        cursor.pos += (skip * size) as usize;

        while i < width {
            if (i < check_area.1 || h >= check_area.2) && !is_equal(&cursor.buf[cursor.pos..], green, epsilons[1]) {
                return Err(TestError::Fail("verifyClampToEdge failed".to_string()));
            }
            cursor.pos += size as usize;
            i += 1;
        }
        h += 1;
    }

    // skip over border pixels to avoid issues with rounding
    h += skip;
    cursor.pos += (skip * width * size) as usize;

    while h < height {
        i = 0;
        while i < red_w - skip / 2 {
            if (i >= check_area.0 || h < check_area.3) && !is_equal(&cursor.buf[cursor.pos..], blue, epsilons[2]) {
                return Err(TestError::Fail("verifyClampToEdge failed".to_string()));
            }
            cursor.pos += size as usize;
            i += 1;
        }

        i += skip;
        cursor.pos += (skip * size) as usize;

        while i < width {
            if (i < check_area.1 || h < check_area.3) && !is_equal(&cursor.buf[cursor.pos..], white, epsilons[0]) {
                return Err(TestError::Fail("verifyClampToEdge failed".to_string()));
            }
            cursor.pos += size as usize;
            i += 1;
        }
        h += 1;
    }

    log::info!(" verifyClampToEdge succeeded.");
    Ok(true)
}

/// `verifyRepeat`
fn verify_repeat(buf: &[u8], width: i32, height: i32, internalformat: GLenum) -> Result<bool, TestError> {
    let tested_format = find_format(internalformat);
    let red = &tested_format.rgba[RED];
    let green = &tested_format.rgba[GREEN];
    let blue = &tested_format.rgba[BLUE];
    let white = &tested_format.rgba[WHITE];
    let tolerance = 0u8;

    let tex_w = width / 3;
    let tex_h = height / 3;

    let red_w = tex_w / 2;
    let red_h = tex_h / 2;

    let green_w = tex_w - red_w;

    let blue_w = red_w;
    let blue_h = tex_h - red_h;

    let white_w = green_w;

    let mut cursor = Cursor {
        buf,
        pos: 0,
        what: "verifyRepeat",
    };
    for _g in 0..3 {
        for _h in 0..red_h {
            for _j in 0..3 {
                cursor.expect_run(red, tolerance, red_w)?;
                cursor.expect_run(green, tolerance, green_w)?;
            }
        }
        for _h in 0..blue_h {
            for _j in 0..3 {
                cursor.expect_run(blue, tolerance, blue_w)?;
                cursor.expect_run(white, tolerance, white_w)?;
            }
        }
    }

    log::info!(" verifyRepeat succeeded.");
    Ok(true)
}

/// One row of three tiles that mirror each other: `first` then `second` on even tiles, the other way round on odd ones.
fn mirrored_rows(
    cursor: &mut Cursor<'_>,
    tolerance: u8,
    rows: i32,
    first: (&[u8; 4], i32),
    second: (&[u8; 4], i32),
) -> Result<(), TestError> {
    for _h in 0..rows {
        for j in 0..3 {
            if j % 2 == 0 {
                cursor.expect_run(first.0, tolerance, first.1)?;
                cursor.expect_run(second.0, tolerance, second.1)?;
            } else {
                cursor.expect_run(second.0, tolerance, second.1)?;
                cursor.expect_run(first.0, tolerance, first.1)?;
            }
        }
    }
    Ok(())
}

/// `verifyMirroredRepeat`
fn verify_mirrored_repeat(buf: &[u8], width: i32, height: i32, internalformat: GLenum) -> Result<bool, TestError> {
    let tested_format = find_format(internalformat);
    let red = &tested_format.rgba[RED];
    let green = &tested_format.rgba[GREEN];
    let blue = &tested_format.rgba[BLUE];
    let white = &tested_format.rgba[WHITE];
    let tolerance = 0u8;

    let tex_w = width / 3;
    let tex_h = height / 3;

    let red_w = tex_w / 2;
    let red_h = tex_h / 2;

    let green_w = tex_w - red_w;
    let green_h = red_h;

    let blue_w = red_w;
    let blue_h = tex_h - red_h;

    let white_w = green_w;
    let white_h = blue_h;

    let mut cursor = Cursor {
        buf,
        pos: 0,
        what: "verifyMirroredRepeat",
    };

    for g in 0..3 {
        if g % 2 == 0 {
            mirrored_rows(&mut cursor, tolerance, white_h, (white, white_w), (blue, blue_w))?;
            mirrored_rows(&mut cursor, tolerance, green_h, (green, green_w), (red, red_w))?;
        } else {
            mirrored_rows(&mut cursor, tolerance, green_h, (green, green_w), (red, red_w))?;
            mirrored_rows(&mut cursor, tolerance, white_h, (white, white_w), (blue, blue_w))?;
        }
    }

    log::info!(" verifyMirroredRepeat succeeded.");
    Ok(true)
}

impl TestClampModeForInternalFormat {
    /// `verifyClampMode`
    fn verify_clamp_mode(
        &self,
        gl: &glw::Functions,
        buf: &[u8],
        width: i32,
        height: i32,
        internalformat: GLenum,
    ) -> Result<bool, TestError> {
        match self.clamp_mode {
            glw::GL_CLAMP_TO_EDGE => verify_clamp_to_edge(gl, buf, width, height, width, height, internalformat),
            glw::GL_REPEAT => verify_repeat(buf, width, height, internalformat),
            glw::GL_MIRRORED_REPEAT => verify_mirrored_repeat(buf, width, height, internalformat),
            _ => Ok(false),
        }
    }
}

impl TestCase for TestClampModeForInternalFormat {
    fn name(&self) -> &str {
        &self.name
    }

    /// Uploads the texture to the requested level, draws a quad three times its size with texture coordinates from -1 to 2, reads the quad back and checks the clamp mode's pattern.
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        // Retrieve properties of the tested format
        let tested_format = find_format(self.internal_format);
        let format = tested_format.format;
        let type_ = tested_format.type_;
        let internalformat = tested_format.internalformat;
        let sampler = tested_format.sampler;
        let view_width = 3 * self.width;
        let view_height = 3 * self.height;

        // Allocate buffers for texture data
        let result_texture_size = (view_width * view_height) as usize;
        let mut texture_data = vec![0u8; result_texture_size * MAX_PIXEL_SIZE];

        let result_texture = glu::Texture::new(gl);
        let source_texture = glu::Texture::new(gl);
        let framebuffer = glu::Framebuffer::new(gl);
        // SAFETY: state setters, and texture uploads from `texture_data`, which is sized for every upload made from it (the result texture is RGBA8 and the source texture's pixels are at most MAX_PIXEL_SIZE bytes).
        unsafe {
            // Set pixel storage modes
            gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1);

            // Generate and bind the texture object that will store test result
            gl.bind_texture(glw::GL_TEXTURE_2D, result_texture.get());
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_MIN_FILTER,
                glw::GL_NEAREST_MIPMAP_NEAREST as i32,
            );
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA8 as i32,
                view_width,
                view_height,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                texture_data.as_ptr().cast(),
            );
        }

        // Reuse textureData buffer to initialize source texture. Fill the buffer according to the color scheme
        fill_texture_with_color(&mut texture_data, self.width, self.height, internalformat);

        // SAFETY: as above.
        unsafe {
            // Generate and bind the texture object that will store color scheme
            gl.bind_texture(glw::GL_TEXTURE_2D, source_texture.get());
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_MIN_FILTER,
                glw::GL_NEAREST_MIPMAP_NEAREST as i32,
            );
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                self.lod_level,
                internalformat as i32,
                self.width,
                self.height,
                0,
                format,
                type_,
                texture_data.as_ptr().cast(),
            );

            // Set compare function used by shadow samplers
            if glw::GL_DEPTH_COMPONENT == format || glw::GL_DEPTH_STENCIL == format {
                gl.tex_parameteri(
                    glw::GL_TEXTURE_2D,
                    glw::GL_TEXTURE_COMPARE_MODE,
                    glw::GL_COMPARE_REF_TO_TEXTURE as i32,
                );
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_COMPARE_FUNC, glw::GL_GEQUAL as i32);
            }
        }

        // Clear the other source texture levels with black
        clear_textures(
            gl,
            glw::GL_TEXTURE_2D,
            self.width,
            self.height,
            self.lod_level,
            internalformat,
            type_,
            format,
        );

        // SAFETY: the framebuffer and result texture are this function's own.
        unsafe {
            // Create and bind the FBO
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.get());
            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                result_texture.get(),
                0,
            );
        }

        // Construct shaders
        let version = format!("{}\n", context.context_type().glsl_version().declaration());
        let vs = format!("{version}{BASIC_VS}");
        let fs_body = if glw::GL_DEPTH_COMPONENT == format || glw::GL_DEPTH_STENCIL == format {
            SHADOW_FS
        } else if sampler == Sampler::Uint {
            INTEGER_FS
        } else {
            BASIC_FS
        };
        let fs = format!("{version}{fs_body}");
        let sources = ProgramSources::vtx_frag(vs, fs);

        // Create program object
        let program = ShaderProgram::new(gl, &sources);
        if !program.is_ok() {
            return Err(TestError::Fail("Compile failed".to_string()));
        }
        let program_id = program.program();
        // SAFETY: a program that built, and a NUL-terminated name.
        let sampler_location = unsafe { gl.get_uniform_location(program_id, c"texture0".as_ptr()) };
        if -1 == sampler_location {
            return Err(TestError::Fail(
                "Fragment shader does not have texture0 input.".to_string(),
            ));
        }
        // SAFETY: the program just checked.
        unsafe {
            gl.use_program(program_id);
            gl.uniform_1i(sampler_location, 0);
        }

        log::info!(
            "NPOT [{}] ({view_width} x {view_height}), Level: {}",
            self.internal_format,
            self.lod_level
        );

        // SAFETY: state setters and a draw without vertex attributes, from the vertex array made here.
        unsafe {
            // Set the wrap parameters for texture coordinates s and t to the current clamp mode
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, self.clamp_mode as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, self.clamp_mode as i32);

            // Set viewport's width and height based on an overview
            gl.viewport(0, 0, view_width, view_height);
        }

        // Draw rectangle
        {
            let vertex_array = glu::VertexArray::new(gl);
            // SAFETY: the vertex array is this block's own.
            unsafe {
                gl.bind_vertex_array(vertex_array.get());
                gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);
                gl.bind_vertex_array(0);
            }
        }

        // Read back pixels and verify that they have the proper values
        let mut buffer = vec![0u8; result_texture_size * 4];
        // SAFETY: `buffer` holds view_width x view_height RGBA8 pixels.
        unsafe {
            gl.read_pixels(
                0,
                0,
                view_width,
                view_height,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                buffer.as_mut_ptr().cast(),
            )
        };
        let status = if self.verify_clamp_mode(gl, &buffer, view_width, view_height, internalformat)? {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        };

        // SAFETY: unbinding; the guards delete the objects.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.get());
            gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, 0, 0);
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        }

        Ok(status)
    }
}

/// `TextureRepeatModeTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture_repeat_mode");

    let texture_sizes = [(49, 23), (11, 131)];
    let levels_of_detail = [0, 1, 2];

    for (width, height) in texture_sizes {
        for format_info in &TESTED_FORMATS {
            for lod in levels_of_detail {
                let test_base_name = format!("{}_{width}x{height}_{lod}_", format_info.name);
                for (suffix, clamp_mode) in [
                    ("clamp_to_edge", glw::GL_CLAMP_TO_EDGE),
                    ("repeat", glw::GL_REPEAT),
                    ("mirrored_repeat", glw::GL_MIRRORED_REPEAT),
                ] {
                    group.add_child(Box::new(TestClampModeForInternalFormat {
                        name: format!("{test_base_name}{suffix}"),
                        internal_format: format_info.internalformat,
                        clamp_mode,
                        lod_level: lod,
                        width,
                        height,
                    }) as Box<dyn TestCase>);
                }
            }
        }
    }
    group
}
