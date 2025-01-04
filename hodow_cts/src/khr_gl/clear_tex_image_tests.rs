// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cClearTexImageAndSubImageTests.cpp
//   external/openglcts/modules/gl/gl4cClearTexImageAndSubImageTests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The test names upstream builds from the constructor arguments (`format_..._internalFormat_..._type_..._pixelSize_..._texLevel_...`, with the *requested* level) are built when the tree is built; the level the case runs at is clamped to the context's `GL_MAX_TEXTURE_SIZE` in `iterate`, which is where upstream's constructor does it. The templated `test<type>` is `run_test::<T>` over `Element`. The repeated per-pixel-size switches of `clearImageTexture`, `clearSubImageTexture`, `verifyClearImageResults` and `verifyClearSubImageResults` are one expected-texel function (`expected_texel`): components below the number of cleared channels hold the clear value, the fourth the alpha (`ALPHA`, 1 for floats and 0xFFFF for unsigned shorts), the rest zero, which is exactly what the cascades spell out; clear data is padded to four elements instead of letting `glClearTexImage` read past a shorter array. Any error thrown inside a case upstream is reported as INTERNAL_ERROR, which `iterate` keeps. The twelve negative cases are functions.

use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint};
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};

type Res<T> = Result<T, TestError>;
type NegativeFn = fn(&Context) -> Res<bool>;

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const FILL_IMAGE_VALUE: i32 = 15;
const CLEAR_SUB_IMAGE_VALUE: i32 = 5;

/// `ClearTexAndSubImageTest::TestOptions`
#[derive(Clone, Copy)]
struct TestOptions {
    /// Kept for the shape of upstream's struct; `clear_sub_tex_image` alone picks the entry point.
    #[allow(dead_code)]
    clear_tex_image: bool,
    clear_sub_tex_image: bool,
    dimension_zero: bool,
    clear_with_red: bool,
    clear_with_rg: bool,
    clear_with_rgba: bool,
    clear_with_rgb: bool,
}

impl TestOptions {
    const fn new(flags: [bool; 7]) -> Self {
        Self {
            clear_tex_image: flags[0],
            clear_sub_tex_image: flags[1],
            dimension_zero: flags[2],
            clear_with_red: flags[3],
            clear_with_rg: flags[4],
            clear_with_rgba: flags[5],
            clear_with_rgb: flags[6],
        }
    }

    /// The `format` a clear is issued with, for an image of `image_format`.
    fn clear_format(&self, image_format: GLenum) -> GLenum {
        if self.clear_with_red {
            glw::GL_RED
        } else if self.clear_with_rg {
            glw::GL_RG
        } else if self.clear_with_rgb {
            glw::GL_RGB
        } else if self.clear_with_rgba {
            glw::GL_RGBA
        } else {
            image_format
        }
    }

    /// How many channels of a texel a clear with `clear_format` writes, for a texel of `pixel_size` components.
    fn cleared_channels(&self, pixel_size: usize) -> usize {
        if self.clear_with_red {
            1
        } else if self.clear_with_rg {
            2
        } else if self.clear_with_rgb {
            3
        } else {
            pixel_size
        }
    }
}

/// The element types of the textures: `unsigned short` and `float`.
trait Element: Copy + PartialEq {
    /// `static_cast<unsigned short>(-1)`, or 1 for `GL_FLOAT`
    const ALPHA: Self;
    fn from_i32(value: i32) -> Self;
}

impl Element for u16 {
    const ALPHA: Self = u16::MAX;

    fn from_i32(value: i32) -> Self {
        value as u16
    }
}

impl Element for f32 {
    const ALPHA: Self = 1.0;

    fn from_i32(value: i32) -> Self {
        value as f32
    }
}

/// What one texel holds after a clear that wrote `options.cleared_channels` channels of `base`.
fn expected_texel<T: Element>(pixel_size: usize, options: &TestOptions, base: [i32; 4]) -> Vec<T> {
    let channels = options.cleared_channels(pixel_size);
    (0..pixel_size)
        .map(|k| {
            if k < channels {
                T::from_i32(base[k])
            } else if k == 3 {
                T::ALPHA
            } else {
                T::from_i32(0)
            }
        })
        .collect()
}

struct ClearTexCase {
    name: String,
    format: GLenum,
    internal_format: GLenum,
    type_: GLenum,
    pixel_size: usize,
    tex_level: i32,
    options: TestOptions,
}

/// A row of the explicit part of `ClearTextureImageTestCases::init`.
struct ClearCase {
    name_prefix: &'static str,
    format: GLenum,
    internal_format: GLenum,
    type_: GLenum,
    pixel_size: usize,
    tex_level: i32,
    options: TestOptions,
}

const fn clear_case(
    name_prefix: &'static str,
    format: GLenum,
    internal_format: GLenum,
    type_: GLenum,
    pixel_size: usize,
    tex_level: i32,
    flags: [bool; 7],
) -> ClearCase {
    ClearCase {
        name_prefix,
        format,
        internal_format,
        type_,
        pixel_size,
        tex_level,
        options: TestOptions::new(flags),
    }
}

/// `glu::getTextureFormatName` / `glu::getTypeName` for the enums the table uses.
fn enum_name(value: GLenum) -> &'static str {
    match value {
        glw::GL_RGBA => "GL_RGBA",
        glw::GL_RGB => "GL_RGB",
        glw::GL_RG => "GL_RG",
        glw::GL_RED => "GL_RED",
        glw::GL_DEPTH_COMPONENT => "GL_DEPTH_COMPONENT",
        glw::GL_RGBA16 => "GL_RGBA16",
        glw::GL_RGBA32F => "GL_RGBA32F",
        glw::GL_RGB16 => "GL_RGB16",
        glw::GL_RGB32F => "GL_RGB32F",
        glw::GL_RG16 => "GL_RG16",
        glw::GL_RG32F => "GL_RG32F",
        glw::GL_R16 => "GL_R16",
        glw::GL_R32F => "GL_R32F",
        glw::GL_DEPTH_COMPONENT16 => "GL_DEPTH_COMPONENT16",
        glw::GL_DEPTH_COMPONENT32F => "GL_DEPTH_COMPONENT32F",
        glw::GL_UNSIGNED_SHORT => "GL_UNSIGNED_SHORT",
        glw::GL_FLOAT => "GL_FLOAT",
        _ => "unknown",
    }
}

impl ClearTexCase {
    fn new(
        name_prefix: &str,
        format: GLenum,
        internal_format: GLenum,
        type_: GLenum,
        pixel_size: usize,
        tex_level: i32,
        options: TestOptions,
    ) -> Self {
        let name = format!(
            "{name_prefix}_format_{}_internalFormat_{}_type_{}_pixelSize_{pixel_size}_texLevel_{tex_level}",
            enum_name(format),
            enum_name(internal_format),
            enum_name(type_)
        );
        Self {
            name,
            format,
            internal_format,
            type_,
            pixel_size,
            tex_level,
            options,
        }
    }
}

const CLEAR_CASES: [ClearCase; 48] = [
    clear_case(
        "gl_clear_tex_image_clear_red_component_rgba_image",
        glw::GL_RGBA,
        glw::GL_RGBA32F,
        glw::GL_FLOAT,
        4,
        0,
        [true, false, false, true, false, false, false],
    ),
    clear_case(
        "gl_clear_tex_image_clear_red_component_rgba_image",
        glw::GL_RGBA,
        glw::GL_RGBA16,
        glw::GL_UNSIGNED_SHORT,
        4,
        0,
        [true, false, false, true, false, false, false],
    ),
    clear_case(
        "gl_clear_tex_image_clear_red_component_rgb_image",
        glw::GL_RGB,
        glw::GL_RGB32F,
        glw::GL_FLOAT,
        3,
        0,
        [true, false, false, true, false, false, false],
    ),
    clear_case(
        "gl_clear_tex_image_clear_red_component_rgb_image",
        glw::GL_RGB,
        glw::GL_RGB16,
        glw::GL_UNSIGNED_SHORT,
        3,
        0,
        [true, false, false, true, false, false, false],
    ),
    clear_case(
        "gl_clear_tex_image_clear_red_component_rg_image",
        glw::GL_RG,
        glw::GL_RG32F,
        glw::GL_FLOAT,
        2,
        0,
        [true, false, false, true, false, false, false],
    ),
    clear_case(
        "gl_clear_tex_image_clear_red_component_rg_image",
        glw::GL_RG,
        glw::GL_RG16,
        glw::GL_UNSIGNED_SHORT,
        2,
        0,
        [true, false, false, true, false, false, false],
    ),
    clear_case(
        "gl_clear_tex_image_clear_red_component_red_image",
        glw::GL_RED,
        glw::GL_R32F,
        glw::GL_FLOAT,
        1,
        0,
        [true, false, false, true, false, false, false],
    ),
    clear_case(
        "gl_clear_tex_image_clear_red_component_red_image",
        glw::GL_RED,
        glw::GL_R32F,
        glw::GL_UNSIGNED_SHORT,
        1,
        0,
        [true, false, false, true, false, false, false],
    ),
    clear_case(
        "gl_clear_tex_image_clear_rg_component_rgba_image",
        glw::GL_RGBA,
        glw::GL_RGBA32F,
        glw::GL_FLOAT,
        4,
        0,
        [true, false, false, false, true, false, false],
    ),
    clear_case(
        "gl_clear_tex_image_clear_rg_component_rgba_image",
        glw::GL_RGBA,
        glw::GL_RGBA16,
        glw::GL_UNSIGNED_SHORT,
        4,
        0,
        [true, false, false, false, true, false, false],
    ),
    clear_case(
        "gl_clear_tex_image_clear_rg_component_rgb_image",
        glw::GL_RGB,
        glw::GL_RGB32F,
        glw::GL_FLOAT,
        3,
        0,
        [true, false, false, false, true, false, false],
    ),
    clear_case(
        "gl_clear_tex_image_clear_rg_component_rgb_image",
        glw::GL_RGB,
        glw::GL_RGB16,
        glw::GL_UNSIGNED_SHORT,
        3,
        0,
        [true, false, false, false, true, false, false],
    ),
    clear_case(
        "gl_clear_tex_image_clear_rga_component_rgba_image",
        glw::GL_RGBA,
        glw::GL_RGBA32F,
        glw::GL_FLOAT,
        4,
        0,
        [true, false, false, false, false, false, true],
    ),
    clear_case(
        "gl_clear_tex_image_clear_rga_component_rgba_image",
        glw::GL_RGBA,
        glw::GL_RGBA16,
        glw::GL_UNSIGNED_SHORT,
        4,
        0,
        [true, false, false, false, false, false, true],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_red_component_rgba_image",
        glw::GL_RGBA,
        glw::GL_RGBA32F,
        glw::GL_FLOAT,
        4,
        0,
        [false, true, false, true, false, false, false],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_red_component_rgba_image",
        glw::GL_RGBA,
        glw::GL_RGBA16,
        glw::GL_UNSIGNED_SHORT,
        4,
        0,
        [false, true, false, true, false, false, false],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_red_component_rgb_image",
        glw::GL_RGB,
        glw::GL_RGB32F,
        glw::GL_FLOAT,
        3,
        0,
        [false, true, false, true, false, false, false],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_red_component_rgb_image",
        glw::GL_RGB,
        glw::GL_RGB16,
        glw::GL_UNSIGNED_SHORT,
        3,
        0,
        [false, true, false, true, false, false, false],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_red_component_rg_image",
        glw::GL_RG,
        glw::GL_RG32F,
        glw::GL_FLOAT,
        2,
        0,
        [false, true, false, true, false, false, false],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_red_component_rg_image",
        glw::GL_RG,
        glw::GL_RG16,
        glw::GL_UNSIGNED_SHORT,
        2,
        0,
        [false, true, false, true, false, false, false],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_red_component_rg_image",
        glw::GL_RED,
        glw::GL_R32F,
        glw::GL_FLOAT,
        1,
        0,
        [false, true, false, true, false, false, false],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_red_component_rg_image",
        glw::GL_RED,
        glw::GL_R16,
        glw::GL_UNSIGNED_SHORT,
        1,
        0,
        [false, true, false, true, false, false, false],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_rg_component_rgba_image",
        glw::GL_RGBA,
        glw::GL_RGBA32F,
        glw::GL_FLOAT,
        4,
        0,
        [false, true, false, false, true, false, false],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_rg_component_rgba_image",
        glw::GL_RGBA,
        glw::GL_RGBA16,
        glw::GL_UNSIGNED_SHORT,
        4,
        0,
        [false, true, false, false, true, false, false],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_rg_component_rgb_image",
        glw::GL_RGB,
        glw::GL_RGB32F,
        glw::GL_FLOAT,
        3,
        0,
        [false, true, false, false, true, false, false],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_rg_component_rgb_image",
        glw::GL_RGB,
        glw::GL_RGB16,
        glw::GL_UNSIGNED_SHORT,
        3,
        0,
        [false, true, false, false, true, false, false],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_rgb_component_rgba_image",
        glw::GL_RGBA,
        glw::GL_RGBA32F,
        glw::GL_FLOAT,
        4,
        0,
        [false, true, false, false, false, false, true],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_rgb_component_rgba_image",
        glw::GL_RGBA,
        glw::GL_RGBA16,
        glw::GL_UNSIGNED_SHORT,
        4,
        0,
        [false, true, false, false, false, false, true],
    ),
    clear_case(
        "gl_clear_tex_image_clear_rgba_component_red_image",
        glw::GL_RED,
        glw::GL_R32F,
        glw::GL_FLOAT,
        1,
        0,
        [true, false, false, false, false, true, false],
    ),
    clear_case(
        "gl_clear_tex_image_clear_rgba_component_red_image",
        glw::GL_RED,
        glw::GL_R16,
        glw::GL_UNSIGNED_SHORT,
        1,
        0,
        [true, false, false, false, false, true, false],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_rgba_component_red_image",
        glw::GL_RED,
        glw::GL_R32F,
        glw::GL_FLOAT,
        1,
        0,
        [false, true, false, false, false, true, false],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_rgba_component_red_image",
        glw::GL_RED,
        glw::GL_R16,
        glw::GL_UNSIGNED_SHORT,
        1,
        0,
        [false, true, false, false, false, true, false],
    ),
    clear_case(
        "gl_clear_tex_image_clear_rgba_component_rg_image",
        glw::GL_RG,
        glw::GL_RG32F,
        glw::GL_FLOAT,
        2,
        0,
        [true, false, false, false, false, true, false],
    ),
    clear_case(
        "gl_clear_tex_image_clear_rgba_component_rg_image",
        glw::GL_RG,
        glw::GL_RG16,
        glw::GL_UNSIGNED_SHORT,
        2,
        0,
        [true, false, false, false, false, true, false],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_rgba_component_rg_image",
        glw::GL_RG,
        glw::GL_RG32F,
        glw::GL_FLOAT,
        2,
        0,
        [false, true, false, false, false, true, false],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_rgba_component_rg_image",
        glw::GL_RG,
        glw::GL_RG16,
        glw::GL_UNSIGNED_SHORT,
        2,
        0,
        [false, true, false, false, false, true, false],
    ),
    clear_case(
        "gl_clear_tex_image_clear_rgb_component_red_image",
        glw::GL_RED,
        glw::GL_R32F,
        glw::GL_FLOAT,
        1,
        0,
        [true, false, false, false, false, false, true],
    ),
    clear_case(
        "gl_clear_tex_image_clear_rgb_component_red_image",
        glw::GL_RED,
        glw::GL_R16,
        glw::GL_UNSIGNED_SHORT,
        1,
        0,
        [true, false, false, false, false, false, true],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_rgb_component_red_image",
        glw::GL_RED,
        glw::GL_R32F,
        glw::GL_FLOAT,
        1,
        0,
        [false, true, false, false, false, false, true],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_rgb_component_red_image",
        glw::GL_RED,
        glw::GL_R16,
        glw::GL_UNSIGNED_SHORT,
        1,
        0,
        [false, true, false, false, false, false, true],
    ),
    clear_case(
        "gl_clear_tex_image_clear_rgb_component_rg_image",
        glw::GL_RG,
        glw::GL_RG32F,
        glw::GL_FLOAT,
        2,
        0,
        [true, false, false, false, false, false, true],
    ),
    clear_case(
        "gl_clear_tex_image_clear_rgb_component_rg_image",
        glw::GL_RG,
        glw::GL_RG16,
        glw::GL_UNSIGNED_SHORT,
        2,
        0,
        [true, false, false, false, false, false, true],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_rgb_component_rg_image",
        glw::GL_RG,
        glw::GL_RG32F,
        glw::GL_FLOAT,
        2,
        0,
        [false, true, false, false, false, false, true],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_rgb_component_rg_image",
        glw::GL_RG,
        glw::GL_RG16,
        glw::GL_UNSIGNED_SHORT,
        2,
        0,
        [false, true, false, false, false, false, true],
    ),
    clear_case(
        "gl_clear_tex_image_clear_rg_component_red_image",
        glw::GL_RED,
        glw::GL_R32F,
        glw::GL_FLOAT,
        1,
        0,
        [true, false, false, false, true, false, false],
    ),
    clear_case(
        "gl_clear_tex_image_clear_rg_component_red_image",
        glw::GL_RED,
        glw::GL_R16,
        glw::GL_UNSIGNED_SHORT,
        1,
        0,
        [true, false, false, false, true, false, false],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_rg_component_red_image",
        glw::GL_RED,
        glw::GL_R32F,
        glw::GL_FLOAT,
        1,
        0,
        [false, true, false, false, true, false, false],
    ),
    clear_case(
        "gl_clear_tex_sub_image_clear_rg_component_red_image",
        glw::GL_RED,
        glw::GL_R16,
        glw::GL_UNSIGNED_SHORT,
        1,
        0,
        [false, true, false, false, true, false, false],
    ),
];

/// `ClearTexAndSubImageTest::test<type>`
fn run_test<T: Element>(context: &Context, case: &ClearTexCase) -> Res<bool> {
    let gl = context.gl();
    let options = &case.options;
    let pixel_size = case.pixel_size;
    let is_depth = case.format == glw::GL_DEPTH_COMPONENT;

    // The constructor's size computation
    let mut gl_max_texture_size: GLint = 0;
    // SAFETY: one GLint out.
    unsafe { gl.get_integerv(glw::GL_MAX_TEXTURE_SIZE, &mut gl_max_texture_size) };
    let max_level = ((f64::from(gl_max_texture_size)).log2() / 2.0f64.log2()) as GLint;
    let tex_level = case.tex_level.min(max_level);
    let max_width = gl_max_texture_size >> tex_level;
    let max_height = gl_max_texture_size >> tex_level;
    let render_target = context.render_target();
    let width = max_width.min(render_target.width);
    let height = max_height.min(render_target.height);

    // createTexture
    let texture = glu::Texture::new(gl);
    glu::expect_no_error(gl, "glGenTextures")?;
    gl_call!(gl, "glBindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, texture.get()));
    gl_call!(
        gl,
        "glTexParameteri",
        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint)
    );
    gl_call!(
        gl,
        "glTexParameteri",
        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint)
    );
    gl_call!(
        gl,
        "glTexParameteri",
        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_REPEAT as GLint)
    );
    gl_call!(
        gl,
        "glTexParameteri",
        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_REPEAT as GLint)
    );
    gl_call!(
        gl,
        "glTexParameteri",
        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_LEVEL, tex_level)
    );

    // fillTexture
    let color = T::from_i32(if is_depth { 1 } else { FILL_IMAGE_VALUE });
    let tex_data = vec![color; (width * height) as usize * pixel_size];
    if pixel_size < 4 {
        // SAFETY: a current context.
        unsafe { gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1) };
    }
    gl_call!(
        gl,
        "glTexImage2D",
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            tex_level,
            case.internal_format as GLint,
            width,
            height,
            0,
            case.format,
            case.type_,
            tex_data.as_ptr().cast()
        )
    );

    // clearTexture: disabled color write masks must not affect texture clears.
    gl_call!(
        gl,
        "colorMask",
        gl.color_mask(glw::FALSE, glw::FALSE, glw::FALSE, glw::FALSE)
    );
    let clear_format = options.clear_format(case.format);
    if options.clear_sub_tex_image {
        // clearSubImageTexture
        let value = T::from_i32(if pixel_size == 1 && is_depth {
            1
        } else {
            CLEAR_SUB_IMAGE_VALUE
        });
        let clear_data = [value; 4];
        let depth = if options.dimension_zero { 0 } else { 1 };
        gl_call!(
            gl,
            "clearTexImage",
            gl.clear_tex_sub_image(
                texture.get(),
                tex_level,
                0,
                0,
                0,
                width / 2,
                height / 2,
                depth,
                clear_format,
                case.type_,
                clear_data.as_ptr().cast()
            )
        );
    } else {
        // clearImageTexture
        let base = if pixel_size == 1 && is_depth {
            [1, 0, 0, 0]
        } else {
            [5, 4, 3, 2]
        };
        let clear_data = base.map(T::from_i32);
        gl_call!(
            gl,
            "clearTexImage",
            gl.clear_tex_image(
                texture.get(),
                tex_level,
                clear_format,
                case.type_,
                clear_data.as_ptr().cast()
            )
        );
    }

    // verifyResults
    let size = (width * height) as usize * pixel_size;
    let mut tex_read_data = vec![T::from_i32(0); size];
    if pixel_size < 4 {
        // SAFETY: a current context.
        unsafe { gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1) };
    }
    gl_call!(
        gl,
        "getTexImage",
        gl.get_tex_image(
            glw::GL_TEXTURE_2D,
            tex_level,
            case.format,
            case.type_,
            tex_read_data.as_mut_ptr().cast()
        )
    );

    let (width, height) = (width as usize, height as usize);
    if !options.clear_sub_tex_image {
        // verifyClearImageResults
        let base = if pixel_size == 1 && is_depth {
            [1, 0, 0, 0]
        } else {
            [5, 4, 3, 2]
        };
        let expected = expected_texel::<T>(pixel_size, options, base);
        for x in (0..size).step_by(pixel_size) {
            if tex_read_data[x..x + pixel_size] != expected[..] {
                return Ok(false);
            }
        }
    } else if options.clear_with_red || options.clear_with_rg || options.clear_with_rgb {
        // verifyClearSubImageResults, for the clears that leave channels at their defaults
        let expected = expected_texel::<T>(pixel_size, options, [CLEAR_SUB_IMAGE_VALUE; 4]);
        for h in 0..height / 2 {
            for w in (0..(width / 2) * pixel_size).step_by(pixel_size) {
                let pixel = h * width * pixel_size + w;
                if tex_read_data[pixel..pixel + pixel_size] != expected[..] {
                    return Ok(false);
                }
            }
        }
    } else {
        let clear = if is_depth {
            1
        } else if options.dimension_zero {
            FILL_IMAGE_VALUE
        } else {
            CLEAR_SUB_IMAGE_VALUE
        };
        let clear = T::from_i32(clear);
        for h in 0..height / 2 {
            for w in 0..(width / 2) * pixel_size {
                if tex_read_data[h * width * pixel_size + w] != clear {
                    return Ok(false);
                }
            }
        }
    }

    Ok(true)
}

/// `ClearTexAndSubImageTest::iterate` after the support check
fn clear_tex_test(context: &Context, case: &ClearTexCase) -> Res<bool> {
    match case.type_ {
        glw::GL_UNSIGNED_SHORT => run_test::<u16>(context, case),
        glw::GL_FLOAT => run_test::<f32>(context, case),
        _ => Ok(true),
    }
}

/// `checkError`
fn check_error(gl: &glw::Functions, expected_error: GLenum, function_name: &str) -> bool {
    // SAFETY: no arguments.
    let error = unsafe { gl.get_error() };
    if expected_error != error {
        log::info!(
            "{function_name} generated error {} but, {} was expected",
            glw::error_name(error),
            glw::error_name(expected_error)
        );
        return false;
    }
    true
}

/// A negative case: a texture of (internal format, format, type), cleared with the given format and types through both entry points, each of which must raise GL_INVALID_OPERATION.
fn invalid_operation_case(
    context: &Context,
    texture_setup: (GLenum, GLenum, GLenum),
    clear_format: GLenum,
    clear_type: GLenum,
    sub_clear_type: GLenum,
    clear_data: Option<[u16; 4]>,
) -> Res<bool> {
    let gl = context.gl();
    let texture = glu::Texture::new(gl);
    glu::expect_no_error(gl, "glGenTextures")?;
    gl_call!(gl, "glBindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, texture.get()));
    let (internal_format, format, type_) = texture_setup;
    let tex_data = vec![5u8; 10 * 10 * 4 * 4];
    gl_call!(
        gl,
        "glTexImage2D",
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            internal_format as GLint,
            10,
            10,
            0,
            format,
            type_,
            tex_data.as_ptr().cast()
        )
    );

    let data = clear_data
        .as_ref()
        .map_or(std::ptr::null(), |d| d.as_ptr().cast::<std::ffi::c_void>());
    // SAFETY: the texture exists and `data` is null or four elements.
    unsafe { gl.clear_tex_image(texture.get(), 0, clear_format, clear_type, data) };
    let mut result = check_error(gl, glw::GL_INVALID_OPERATION, "glClearTexImage");
    // SAFETY: as above.
    unsafe { gl.clear_tex_sub_image(texture.get(), 0, 0, 0, 0, 10, 10, 1, clear_format, sub_clear_type, data) };
    result &= check_error(gl, glw::GL_INVALID_OPERATION, "glClearTexSubImage");
    Ok(result)
}

/// `textureEqualZeroTestCase`
fn texture_equal_zero(context: &Context) -> Res<bool> {
    let gl = context.gl();
    // SAFETY: texture name zero, null data.
    unsafe { gl.clear_tex_image(0, 0, glw::GL_RGBA, glw::GL_UNSIGNED_SHORT, std::ptr::null()) };
    let mut result = check_error(gl, glw::GL_INVALID_OPERATION, "glClearTexImage");
    // SAFETY: as above.
    unsafe { gl.clear_tex_sub_image(0, 0, 0, 0, 0, 10, 10, 1, glw::GL_RGBA, glw::GL_FLOAT, std::ptr::null()) };
    result &= check_error(gl, glw::GL_INVALID_OPERATION, "glClearTexSubImage");
    Ok(result)
}

/// `bufferTextureTestCase`
fn buffer_texture(context: &Context) -> Res<bool> {
    let gl = context.gl();
    let tbo_data = vec![1.0f32; 10 * 10 * 4];
    let tbo = glu::Buffer::new(gl);
    let texture = glu::Texture::new(gl);

    gl_call!(gl, "bindBuffer", gl.bind_buffer(glw::GL_TEXTURE_BUFFER, tbo.get()));
    gl_call!(
        gl,
        "bufferData",
        gl.buffer_data(
            glw::GL_TEXTURE_BUFFER,
            std::mem::size_of_val(tbo_data.as_slice()) as isize,
            tbo_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        )
    );
    gl_call!(gl, "bindBuffer", gl.bind_buffer(glw::GL_TEXTURE_BUFFER, 0));
    gl_call!(
        gl,
        "bindTexture",
        gl.bind_texture(glw::GL_TEXTURE_BUFFER, texture.get())
    );
    gl_call!(
        gl,
        "textureBuffer",
        gl.texture_buffer(texture.get(), glw::GL_RGBA32F, tbo.get())
    );

    // SAFETY: the texture exists, null data.
    unsafe { gl.clear_tex_image(texture.get(), 0, glw::GL_RGBA, glw::GL_FLOAT, std::ptr::null()) };
    let mut result = check_error(gl, glw::GL_INVALID_OPERATION, "glClearTexImage");
    // SAFETY: as above.
    unsafe {
        gl.clear_tex_sub_image(
            texture.get(),
            0,
            0,
            0,
            0,
            10,
            10,
            1,
            glw::GL_RGBA,
            glw::GL_FLOAT,
            std::ptr::null(),
        )
    };
    result &= check_error(gl, glw::GL_INVALID_OPERATION, "glClearTexSubImage");
    Ok(result)
}

/// `compressedTextureTestCase`
fn compressed_texture(context: &Context) -> Res<bool> {
    invalid_operation_case(
        context,
        (glw::GL_COMPRESSED_RGBA, glw::GL_RGBA, glw::GL_UNSIGNED_SHORT),
        glw::GL_RGBA,
        glw::GL_UNSIGNED_SHORT,
        glw::GL_FLOAT,
        None,
    )
}

/// `negativeDimensionTestCase`
fn negative_dimension(context: &Context) -> Res<bool> {
    let gl = context.gl();
    let texture = glu::Texture::new(gl);
    glu::expect_no_error(gl, "glGenTextures")?;
    gl_call!(gl, "glBindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, texture.get()));
    let tex_data = vec![5u16; 10 * 10 * 4];
    gl_call!(
        gl,
        "glTexImage2D",
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA as GLint,
            10,
            10,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_SHORT,
            tex_data.as_ptr().cast()
        )
    );

    // SAFETY: the texture exists, null data.
    unsafe {
        gl.clear_tex_sub_image(
            texture.get(),
            0,
            0,
            0,
            0,
            10,
            10,
            -1,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_SHORT,
            std::ptr::null(),
        )
    };
    let mut result = check_error(gl, glw::GL_INVALID_VALUE, "glClearTexSubImage");
    // SAFETY: as above.
    unsafe {
        gl.clear_tex_sub_image(
            texture.get(),
            0,
            0,
            0,
            0,
            -10,
            10,
            1,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_SHORT,
            std::ptr::null(),
        )
    };
    result &= check_error(gl, glw::GL_INVALID_VALUE, "glClearTexSubImage");
    // SAFETY: as above.
    unsafe {
        gl.clear_tex_sub_image(
            texture.get(),
            0,
            0,
            0,
            0,
            10,
            -10,
            1,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_SHORT,
            std::ptr::null(),
        )
    };
    result &= check_error(gl, glw::GL_INVALID_VALUE, "glClearTexSubImage");
    Ok(result)
}

/// `depthComponentIsInternalFormatButFormatNotTestCase`
fn depth_component_is_internal_format_but_format_not(context: &Context) -> Res<bool> {
    invalid_operation_case(
        context,
        (glw::GL_DEPTH_COMPONENT, glw::GL_DEPTH_COMPONENT, glw::GL_UNSIGNED_SHORT),
        glw::GL_RGBA,
        glw::GL_UNSIGNED_SHORT,
        glw::GL_UNSIGNED_SHORT,
        None,
    )
}

/// `depthStencilIsInternalFormatButFormatNotTestCase`
fn depth_stencil_is_internal_format_but_format_not(context: &Context) -> Res<bool> {
    invalid_operation_case(
        context,
        (glw::GL_DEPTH_STENCIL, glw::GL_DEPTH_STENCIL, glw::GL_UNSIGNED_INT_24_8),
        glw::GL_RGBA,
        glw::GL_UNSIGNED_INT_24_8,
        glw::GL_UNSIGNED_INT_24_8,
        None,
    )
}

/// `stencilIndexIsInternalFormatButFormatNotTestCase`
fn stencil_index_is_internal_format_but_format_not(context: &Context) -> Res<bool> {
    invalid_operation_case(
        context,
        (glw::GL_STENCIL_INDEX, glw::GL_STENCIL_INDEX, glw::GL_UNSIGNED_SHORT),
        glw::GL_RGBA,
        glw::GL_UNSIGNED_SHORT,
        glw::GL_UNSIGNED_SHORT,
        None,
    )
}

/// `rgbaIsInternalFormatButFormatDepthComponentTestCase`
fn rgba_is_internal_format_but_format_depth_component(context: &Context) -> Res<bool> {
    invalid_operation_case(
        context,
        (glw::GL_RGBA, glw::GL_RGBA, glw::GL_UNSIGNED_SHORT),
        glw::GL_DEPTH_COMPONENT,
        glw::GL_UNSIGNED_SHORT,
        glw::GL_UNSIGNED_SHORT,
        None,
    )
}

/// `rgbaIsInternalFormatButFormatDepthStencilTestCase`
fn rgba_is_internal_format_but_format_depth_stencil(context: &Context) -> Res<bool> {
    invalid_operation_case(
        context,
        (glw::GL_RGBA, glw::GL_RGBA, glw::GL_UNSIGNED_SHORT),
        glw::GL_DEPTH_STENCIL,
        glw::GL_UNSIGNED_SHORT,
        glw::GL_UNSIGNED_SHORT,
        None,
    )
}

/// `rgbaIsInternalFormatButFormatStencilIndexTestCase`
fn rgba_is_internal_format_but_format_stencil_index(context: &Context) -> Res<bool> {
    invalid_operation_case(
        context,
        (glw::GL_RGBA, glw::GL_RGBA, glw::GL_UNSIGNED_SHORT),
        glw::GL_STENCIL_INDEX,
        glw::GL_UNSIGNED_SHORT,
        glw::GL_UNSIGNED_SHORT,
        None,
    )
}

/// `integerIsInternalFormatButFormatNotIntegerTestCase`
fn integer_is_internal_format_but_format_not_integer(context: &Context) -> Res<bool> {
    invalid_operation_case(
        context,
        (glw::GL_RGBA16UI, glw::GL_RGBA_INTEGER, glw::GL_UNSIGNED_SHORT),
        glw::GL_RGBA,
        glw::GL_UNSIGNED_SHORT,
        glw::GL_UNSIGNED_SHORT,
        Some([5, 4, 3, 2]),
    )
}

/// `integerIsNotInternalFormatButFormatIsIntegerTestCase`
fn integer_is_not_internal_format_but_format_is_integer(context: &Context) -> Res<bool> {
    invalid_operation_case(
        context,
        (glw::GL_RGBA16, glw::GL_RGBA, glw::GL_UNSIGNED_SHORT),
        glw::GL_RGBA_INTEGER,
        glw::GL_UNSIGNED_SHORT,
        glw::GL_UNSIGNED_SHORT,
        Some([5, 4, 3, 2]),
    )
}

enum Kind {
    ClearTex(ClearTexCase),
    Negative(NegativeFn),
}

struct ClearTexImageCase {
    name: String,
    kind: Kind,
}

impl TestCase for ClearTexImageCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let is_at_least_gl_44 = context.context_type().supports_core(4, 4);
        let is_arb_clear_texture = context.context_info.is_extension_supported("GL_ARB_clear_texture");
        if !(is_at_least_gl_44 || is_arb_clear_texture) {
            return Err(TestError::NotSupported("Not Supported".to_string()));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let outcome = match &self.kind {
            Kind::ClearTex(case) => clear_tex_test(context, case),
            Kind::Negative(test_func) => test_func(context),
        };
        Ok(match outcome {
            Ok(true) => TestStatus::pass("Pass"),
            Ok(false) => TestStatus::fail("Fail"),
            // upstream's `catch (...)`
            Err(error) => {
                log::info!("{error}");
                TestStatus::new(TestResult::InternalError, "Error")
            }
        })
    }
}

/// `ClearTextureImageTestCases::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("clear_tex_image");

    let formats = [
        glw::GL_RGBA,
        glw::GL_RGBA,
        glw::GL_RGB,
        glw::GL_RGB,
        glw::GL_DEPTH_COMPONENT,
        glw::GL_DEPTH_COMPONENT,
    ];
    let internal_formats = [
        glw::GL_RGBA16,
        glw::GL_RGBA32F,
        glw::GL_RGB16,
        glw::GL_RGB32F,
        glw::GL_DEPTH_COMPONENT16,
        glw::GL_DEPTH_COMPONENT32F,
    ];
    let types = [
        glw::GL_UNSIGNED_SHORT,
        glw::GL_FLOAT,
        glw::GL_UNSIGNED_SHORT,
        glw::GL_FLOAT,
        glw::GL_UNSIGNED_SHORT,
        glw::GL_FLOAT,
    ];
    let pixel_sizes = [4usize, 4, 3, 3, 1, 1];
    let clear_img_opts = TestOptions::new([true, false, false, false, false, false, false]);
    let clear_sub_img_opts = TestOptions::new([false, true, false, false, false, false, false]);
    let clear_sub_img_dim_zero_opts = TestOptions::new([false, true, true, false, false, false, false]);

    let mut add = |case: ClearTexCase| {
        group.add_child(Box::new(ClearTexImageCase {
            name: case.name.clone(),
            kind: Kind::ClearTex(case),
        }) as Box<dyn TestCase>);
    };

    for i in 0..formats.len() {
        for (prefix, options) in [
            ("gl_clear_tex_image", clear_img_opts),
            ("gl_clear_tex_sub_image", clear_sub_img_opts),
            (
                "gl_clear_tex_sub_image_dimension_equal_zero",
                clear_sub_img_dim_zero_opts,
            ),
        ] {
            add(ClearTexCase::new(
                prefix,
                formats[i],
                internal_formats[i],
                types[i],
                pixel_sizes[i],
                i as i32,
                options,
            ));
        }
    }

    for row in &CLEAR_CASES {
        add(ClearTexCase::new(
            row.name_prefix,
            row.format,
            row.internal_format,
            row.type_,
            row.pixel_size,
            row.tex_level,
            row.options,
        ));
    }

    let negatives: [(&str, NegativeFn); 12] = [
        (
            "negative_gl_clear_tex_and_sub_image_texture_zero",
            texture_equal_zero as NegativeFn,
        ),
        (
            "negative_gl_clear_tex_and_sub_image_buffer_texture",
            buffer_texture as NegativeFn,
        ),
        (
            "negative_gl_clear_tex_and_sub_image_compressed_texture",
            compressed_texture as NegativeFn,
        ),
        (
            "negative_gl_clear_tex_sub_image_negative_dimension",
            negative_dimension as NegativeFn,
        ),
        (
            "negative_gl_clear_tex_and_sub_image_depth_component_is_internal_format_but_format_not",
            depth_component_is_internal_format_but_format_not as NegativeFn,
        ),
        (
            "negative_gl_clear_tex_and_sub_image_depth_stencil_is_internal_format_but_format_not",
            depth_stencil_is_internal_format_but_format_not as NegativeFn,
        ),
        (
            "negative_gl_clear_tex_and_sub_image_stencil_index_is_internal_format_but_format_not",
            stencil_index_is_internal_format_but_format_not as NegativeFn,
        ),
        (
            "negative_gl_clear_tex_and_sub_rgba_is_internal_format_but_depth_component_format",
            rgba_is_internal_format_but_format_depth_component as NegativeFn,
        ),
        (
            "negative_gl_clear_tex_and_sub_rgba_is_internal_format_but_depth_stencil_format",
            rgba_is_internal_format_but_format_depth_stencil as NegativeFn,
        ),
        (
            "negative_gl_clear_tex_and_sub_rgba_is_internal_format_but_stencil_index_format",
            rgba_is_internal_format_but_format_stencil_index as NegativeFn,
        ),
        (
            "negative_gl_clear_tex_and_sub_integer_is_internal_format_but_format_not_integer",
            integer_is_internal_format_but_format_not_integer as NegativeFn,
        ),
        (
            "negative_gl_clear_tex_and_sub_not_integer_internal_format_but_format_integer",
            integer_is_not_internal_format_but_format_is_integer as NegativeFn,
        ),
    ];
    for (name, test_func) in negatives {
        group.add_child(Box::new(ClearTexImageCase {
            name: name.to_string(),
            kind: Kind::Negative(test_func),
        }) as Box<dyn TestCase>);
    }

    group
}
