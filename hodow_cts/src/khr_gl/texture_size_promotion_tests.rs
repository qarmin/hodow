// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl3cTextureSizePromotion.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `throw 0` becomes a `TestError::Fail` and upstream's `catch (...)` in `iterate` the single `InternalError` mapping at the end; `Utilities::buildProgram` is `glu::ShaderProgram`, so its compile/link logging and the shader/program deletion come from there.

use crate::glu::{self, Context, ContextType, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals or statics of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const RED_COMPONENT: usize = 0;
const ALPHA_COMPONENT: usize = 3;
const COMPONENTS_COUNT: usize = 4;

const SOURCE_TEXTURE_SIZE: i32 = 1;

static SOURCE_TEXTURE_DATA_F: [f32; 4] = [0.125, 0.25, 0.5, 0.75];
static SOURCE_TEXTURE_DATA_N: [f32; 4] = [0.125, 0.25, 0.5, 0.75];
static SOURCE_TEXTURE_DATA_SN: [f32; 4] = [-0.125, 0.25, -0.5, 0.75];
static SOURCE_TEXTURE_DATA_I: [i32; 4] = [-1, 2, -3, 4];
static SOURCE_TEXTURE_DATA_UI: [u32; 4] = [4, 3, 2, 1];
static DESTINATION_TEXTURE_DATA_F: [f32; 1] = [5.0];
static DESTINATION_TEXTURE_DATA_I: [i32; 1] = [-5];
static DESTINATION_TEXTURE_DATA_UI: [u32; 1] = [5];

const SOURCE_TEXTURE_TARGETS: [(GLenum, &str); 8] = [
    (glw::GL_TEXTURE_1D, "GL_TEXTURE_1D"),
    (glw::GL_TEXTURE_2D, "GL_TEXTURE_2D"),
    (glw::GL_TEXTURE_1D_ARRAY, "GL_TEXTURE_1D_ARRAY"),
    (glw::GL_TEXTURE_RECTANGLE, "GL_TEXTURE_RECTANGLE"),
    (glw::GL_TEXTURE_2D_ARRAY, "GL_TEXTURE_2D_ARRAY"),
    (glw::GL_TEXTURE_3D, "GL_TEXTURE_3D"),
    (glw::GL_TEXTURE_2D_MULTISAMPLE, "GL_TEXTURE_2D_MULTISAMPLE"),
    (glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, "GL_TEXTURE_2D_MULTISAMPLE_ARRAY"),
];

const COLOR_CHANNEL_NAMES: [&str; 5] = ["red", "green", "blue", "alpha", "all"];

const VERTEX_SHADER_CODE: &str = "#version 140\n\
    \n\
    void main()\n\
    {\n\
    \x20   switch(gl_VertexID % 4)\n\
    \x20   {\n\
    \x20   case 0:\n\
    \x20       gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);\n\
    \x20       break;\n\
    \x20   case 1:\n\
    \x20       gl_Position = vec4(-1.0,  1.0, 0.0, 1.0);\n\
    \x20       break;\n\
    \x20   case 2:\n\
    \x20       gl_Position = vec4( 1.0, -1.0, 0.0, 1.0);\n\
    \x20       break;\n\
    \x20   case 3:\n\
    \x20       gl_Position = vec4( 1.0,  1.0, 0.0, 1.0);\n\
    \x20       break;\n\
    \x20   }\n\
    }\n";

const FRAGMENT_SHADER_TEMPLATE: &str = "#version 140\n\
    #extension GL_ARB_texture_multisample : enable\n\
    \n\
    out TEMPLATE_TYPE result;\n\
    \n\
    uniform TEMPLATE_SAMPLER data;\n\
    \n\
    void main()\n\
    {\n\
    \x20   result = texelFetch(data, TEMPLATE_TEXEL_FETCH_ARGUMENTS)TEMPLATE_COMPONENT;\n\
    }\n";

/// `TextureInternalFormatDescriptor`
struct Format {
    required_by_context: (i32, i32),
    internal_format: GLenum,
    internal_format_name: &'static str,
    is_srgb: bool,
    is_color_renderable: bool,
    /// Minimum red, green, blue, alpha, depth and stencil sizes.
    min_size: [GLint; 6],
    /// Expected red, green, blue, alpha and depth types.
    expected_type: [GLenum; 5],
}

const fn fmt(
    major: i32,
    minor: i32,
    internal_format: GLenum,
    internal_format_name: &'static str,
    is_srgb: bool,
    is_color_renderable: bool,
    min_size: [GLint; 6],
    expected_type: [GLenum; 5],
) -> Format {
    Format {
        required_by_context: (major, minor),
        internal_format,
        internal_format_name,
        is_srgb,
        is_color_renderable,
        min_size,
        expected_type,
    }
}

impl Format {
    fn has_color_type(&self, ty: GLenum) -> bool {
        self.expected_type[..4].contains(&ty)
    }

    fn is_float_type(&self) -> bool {
        self.has_color_type(glw::GL_FLOAT)
    }

    fn is_fixed_signed_type(&self) -> bool {
        self.has_color_type(glw::GL_SIGNED_NORMALIZED)
    }

    fn is_fixed_unsigned_type(&self) -> bool {
        self.has_color_type(glw::GL_UNSIGNED_NORMALIZED)
    }

    fn is_integer_signed_type(&self) -> bool {
        self.has_color_type(glw::GL_INT)
    }

    fn is_integer_unsigned_type(&self) -> bool {
        self.has_color_type(glw::GL_UNSIGNED_INT)
    }

    fn is_depth_type(&self) -> bool {
        self.expected_type[4] != glw::GL_NONE
    }

    fn is_stencil_type(&self) -> bool {
        self.min_size[5] > 0
    }

    fn is_channel_type_none(&self, channel: usize) -> bool {
        self.expected_type[channel] == glw::GL_NONE
    }

    /// `getMinPrecision`
    fn get_min_precision(&self, channel: usize) -> f32 {
        let ty = self.expected_type[channel];
        let size = self.min_size[channel];

        if ty == glw::GL_NONE || size == 0 {
            return 0.1;
        }

        if self.is_float_type() {
            return match size {
                32 => 0.00001,
                16 => 1.0 / 1024.0,
                11 => 1.0 / 64.0,
                10 => 1.0 / 32.0,
                _ => 0.00001,
            };
        }

        if self.is_fixed_signed_type() {
            return (2.0 / 2.0f64.powf(f64::from(size - 1))) as f32;
        }

        if self.is_fixed_unsigned_type() {
            return (2.0 / 2.0f64.powf(f64::from(size))) as f32;
        }

        1.0
    }

    /// `getDestinationFormatForChannel`
    fn destination_format_for_channel(&self) -> GLenum {
        if self.is_float_type() {
            glw::GL_R32F
        } else if self.is_fixed_unsigned_type() {
            glw::GL_R16
        } else if self.is_fixed_signed_type() {
            glw::GL_R16_SNORM
        } else if self.is_integer_unsigned_type() {
            glw::GL_R32UI
        } else if self.is_integer_signed_type() {
            glw::GL_R32I
        } else {
            glw::GL_R32F
        }
    }
}

fn is_target_multisampled(target: GLenum) -> bool {
    target == glw::GL_TEXTURE_2D_MULTISAMPLE || target == glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
}

/// `convert_from_sRGB`
fn convert_from_srgb(value: f32) -> f32 {
    if value > 0.04045 {
        ((value + 0.055) / 1.055).powf(2.4)
    } else {
        value / 12.92
    }
}

const FORMATS: [Format; 68] = [
    fmt(
        3,
        0,
        glw::GL_R8,
        "GL_R8",
        false,
        true,
        [8, 0, 0, 0, 0, 0],
        [
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        1,
        glw::GL_R8_SNORM,
        "GL_R8_SNORM",
        false,
        true,
        [8, 0, 0, 0, 0, 0],
        [
            glw::GL_SIGNED_NORMALIZED,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_R16,
        "GL_R16",
        false,
        true,
        [16, 0, 0, 0, 0, 0],
        [
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        1,
        glw::GL_R16_SNORM,
        "GL_R16_SNORM",
        false,
        true,
        [16, 0, 0, 0, 0, 0],
        [
            glw::GL_SIGNED_NORMALIZED,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_RG8,
        "GL_RG8",
        false,
        true,
        [8, 8, 0, 0, 0, 0],
        [
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        1,
        glw::GL_RG8_SNORM,
        "GL_RG8_SNORM",
        false,
        true,
        [8, 8, 0, 0, 0, 0],
        [
            glw::GL_SIGNED_NORMALIZED,
            glw::GL_SIGNED_NORMALIZED,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_RG16,
        "GL_RG16",
        false,
        true,
        [16, 16, 0, 0, 0, 0],
        [
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        1,
        glw::GL_RG16_SNORM,
        "GL_RG16_SNORM",
        false,
        true,
        [16, 16, 0, 0, 0, 0],
        [
            glw::GL_SIGNED_NORMALIZED,
            glw::GL_SIGNED_NORMALIZED,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        4,
        4,
        glw::GL_R3_G3_B2,
        "GL_R3_G3_B2",
        false,
        true,
        [3, 3, 2, 0, 0, 0],
        [
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        4,
        4,
        glw::GL_RGB4,
        "GL_RGB4",
        false,
        true,
        [4, 4, 4, 0, 0, 0],
        [
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        4,
        4,
        glw::GL_RGB5,
        "GL_RGB5",
        false,
        true,
        [5, 5, 5, 0, 0, 0],
        [
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_RGB8,
        "GL_RGB8",
        false,
        true,
        [8, 8, 8, 0, 0, 0],
        [
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        1,
        glw::GL_RGB8_SNORM,
        "GL_RGB8_SNORM",
        false,
        true,
        [8, 8, 8, 0, 0, 0],
        [
            glw::GL_SIGNED_NORMALIZED,
            glw::GL_SIGNED_NORMALIZED,
            glw::GL_SIGNED_NORMALIZED,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        4,
        4,
        glw::GL_RGB10,
        "GL_RGB10",
        false,
        true,
        [10, 10, 10, 0, 0, 0],
        [
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        4,
        4,
        glw::GL_RGB12,
        "GL_RGB12",
        false,
        true,
        [12, 12, 12, 0, 0, 0],
        [
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_RGB16,
        "GL_RGB16",
        false,
        true,
        [16, 16, 16, 0, 0, 0],
        [
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        1,
        glw::GL_RGB16_SNORM,
        "GL_RGB16_SNORM",
        false,
        true,
        [16, 16, 16, 0, 0, 0],
        [
            glw::GL_SIGNED_NORMALIZED,
            glw::GL_SIGNED_NORMALIZED,
            glw::GL_SIGNED_NORMALIZED,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        4,
        4,
        glw::GL_RGBA2,
        "GL_RGBA2",
        false,
        true,
        [2, 2, 2, 2, 0, 0],
        [
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_NONE,
        ],
    ),
    fmt(
        4,
        2,
        glw::GL_RGBA4,
        "GL_RGBA4",
        false,
        true,
        [4, 4, 4, 4, 0, 0],
        [
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_NONE,
        ],
    ),
    fmt(
        4,
        2,
        glw::GL_RGB5_A1,
        "GL_RGB5_A1",
        false,
        true,
        [5, 5, 5, 1, 0, 0],
        [
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_RGBA8,
        "GL_RGBA8",
        false,
        true,
        [8, 8, 8, 8, 0, 0],
        [
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        1,
        glw::GL_RGBA8_SNORM,
        "GL_RGBA8_SNORM",
        false,
        true,
        [8, 8, 8, 8, 0, 0],
        [
            glw::GL_SIGNED_NORMALIZED,
            glw::GL_SIGNED_NORMALIZED,
            glw::GL_SIGNED_NORMALIZED,
            glw::GL_SIGNED_NORMALIZED,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_RGB10_A2,
        "GL_RGB10_A2",
        false,
        true,
        [10, 10, 10, 2, 0, 0],
        [
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        3,
        glw::GL_RGB10_A2UI,
        "GL_RGB10_A2UI",
        false,
        true,
        [10, 10, 10, 2, 0, 0],
        [
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_NONE,
        ],
    ),
    fmt(
        4,
        4,
        glw::GL_RGBA12,
        "GL_RGBA12",
        false,
        true,
        [12, 12, 12, 12, 0, 0],
        [
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_RGBA16,
        "GL_RGBA16",
        false,
        true,
        [16, 16, 16, 16, 0, 0],
        [
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        1,
        glw::GL_RGBA16_SNORM,
        "GL_RGBA16_SNORM",
        false,
        true,
        [16, 16, 16, 16, 0, 0],
        [
            glw::GL_SIGNED_NORMALIZED,
            glw::GL_SIGNED_NORMALIZED,
            glw::GL_SIGNED_NORMALIZED,
            glw::GL_SIGNED_NORMALIZED,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_SRGB8,
        "GL_SRGB8",
        true,
        true,
        [8, 8, 8, 0, 0, 0],
        [
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_SRGB8_ALPHA8,
        "GL_SRGB8_ALPHA8",
        true,
        true,
        [8, 8, 8, 8, 0, 0],
        [
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_UNSIGNED_NORMALIZED,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_R16F,
        "GL_R16F",
        false,
        true,
        [16, 0, 0, 0, 0, 0],
        [glw::GL_FLOAT, glw::GL_NONE, glw::GL_NONE, glw::GL_NONE, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_RG16F,
        "GL_RG16F",
        false,
        true,
        [16, 16, 0, 0, 0, 0],
        [glw::GL_FLOAT, glw::GL_FLOAT, glw::GL_NONE, glw::GL_NONE, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_RGB16F,
        "GL_RGB16F",
        false,
        true,
        [16, 16, 16, 0, 0, 0],
        [glw::GL_FLOAT, glw::GL_FLOAT, glw::GL_FLOAT, glw::GL_NONE, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_RGBA16F,
        "GL_RGBA16F",
        false,
        true,
        [16, 16, 16, 16, 0, 0],
        [glw::GL_FLOAT, glw::GL_FLOAT, glw::GL_FLOAT, glw::GL_FLOAT, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_R32F,
        "GL_R32F",
        false,
        true,
        [32, 0, 0, 0, 0, 0],
        [glw::GL_FLOAT, glw::GL_NONE, glw::GL_NONE, glw::GL_NONE, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_RG32F,
        "GL_RG32F",
        false,
        true,
        [32, 32, 0, 0, 0, 0],
        [glw::GL_FLOAT, glw::GL_FLOAT, glw::GL_NONE, glw::GL_NONE, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_RGB32F,
        "GL_RGB32F",
        false,
        true,
        [32, 32, 32, 0, 0, 0],
        [glw::GL_FLOAT, glw::GL_FLOAT, glw::GL_FLOAT, glw::GL_NONE, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_RGBA32F,
        "GL_RGBA32F",
        false,
        true,
        [32, 32, 32, 32, 0, 0],
        [glw::GL_FLOAT, glw::GL_FLOAT, glw::GL_FLOAT, glw::GL_FLOAT, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_R11F_G11F_B10F,
        "GL_R11F_G11F_B10F",
        false,
        true,
        [11, 11, 10, 0, 0, 0],
        [glw::GL_FLOAT, glw::GL_FLOAT, glw::GL_FLOAT, glw::GL_NONE, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_RGB9_E5,
        "GL_RGB9_E5",
        false,
        false,
        [9, 9, 9, 0, 0, 0],
        [glw::GL_FLOAT, glw::GL_FLOAT, glw::GL_FLOAT, glw::GL_NONE, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_R8I,
        "GL_R8I",
        false,
        true,
        [8, 0, 0, 0, 0, 0],
        [glw::GL_INT, glw::GL_NONE, glw::GL_NONE, glw::GL_NONE, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_R8UI,
        "GL_R8UI",
        false,
        true,
        [8, 0, 0, 0, 0, 0],
        [
            glw::GL_UNSIGNED_INT,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_R16I,
        "GL_R16I",
        false,
        true,
        [16, 0, 0, 0, 0, 0],
        [glw::GL_INT, glw::GL_NONE, glw::GL_NONE, glw::GL_NONE, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_R16UI,
        "GL_R16UI",
        false,
        true,
        [16, 0, 0, 0, 0, 0],
        [
            glw::GL_UNSIGNED_INT,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_R32I,
        "GL_R32I",
        false,
        true,
        [32, 0, 0, 0, 0, 0],
        [glw::GL_INT, glw::GL_NONE, glw::GL_NONE, glw::GL_NONE, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_R32UI,
        "GL_R32UI",
        false,
        true,
        [32, 0, 0, 0, 0, 0],
        [
            glw::GL_UNSIGNED_INT,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_RG8I,
        "GL_RG8I",
        false,
        true,
        [8, 8, 0, 0, 0, 0],
        [glw::GL_INT, glw::GL_INT, glw::GL_NONE, glw::GL_NONE, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_RG8UI,
        "GL_RG8UI",
        false,
        true,
        [8, 8, 0, 0, 0, 0],
        [
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_RG16I,
        "GL_RG16I",
        false,
        true,
        [16, 16, 0, 0, 0, 0],
        [glw::GL_INT, glw::GL_INT, glw::GL_NONE, glw::GL_NONE, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_RG16UI,
        "GL_RG16UI",
        false,
        true,
        [16, 16, 0, 0, 0, 0],
        [
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_RG32I,
        "GL_RG32I",
        false,
        true,
        [32, 32, 0, 0, 0, 0],
        [glw::GL_INT, glw::GL_INT, glw::GL_NONE, glw::GL_NONE, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_RG32UI,
        "GL_RG32UI",
        false,
        true,
        [32, 32, 0, 0, 0, 0],
        [
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_RGB8I,
        "GL_RGB8I",
        false,
        true,
        [8, 8, 8, 0, 0, 0],
        [glw::GL_INT, glw::GL_INT, glw::GL_INT, glw::GL_NONE, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_RGB8UI,
        "GL_RGB8UI",
        false,
        true,
        [8, 8, 8, 0, 0, 0],
        [
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_RGB16I,
        "GL_RGB16I",
        false,
        true,
        [16, 16, 16, 0, 0, 0],
        [glw::GL_INT, glw::GL_INT, glw::GL_INT, glw::GL_NONE, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_RGB16UI,
        "GL_RGB16UI",
        false,
        true,
        [16, 16, 16, 0, 0, 0],
        [
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_RGB32I,
        "GL_RGB32I",
        false,
        true,
        [32, 32, 32, 0, 0, 0],
        [glw::GL_INT, glw::GL_INT, glw::GL_INT, glw::GL_NONE, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_RGB32UI,
        "GL_RGB32UI",
        false,
        true,
        [32, 32, 32, 0, 0, 0],
        [
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_NONE,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_RGBA8I,
        "GL_RGBA8I",
        false,
        true,
        [8, 8, 8, 8, 0, 0],
        [glw::GL_INT, glw::GL_INT, glw::GL_INT, glw::GL_INT, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_RGBA8UI,
        "GL_RGBA8UI",
        false,
        true,
        [8, 8, 8, 8, 0, 0],
        [
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_RGBA16I,
        "GL_RGBA16I",
        false,
        true,
        [16, 16, 16, 16, 0, 0],
        [glw::GL_INT, glw::GL_INT, glw::GL_INT, glw::GL_INT, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_RGBA16UI,
        "GL_RGBA16UI",
        false,
        true,
        [16, 16, 16, 16, 0, 0],
        [
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_RGBA32I,
        "GL_RGBA32I",
        false,
        true,
        [32, 32, 32, 32, 0, 0],
        [glw::GL_INT, glw::GL_INT, glw::GL_INT, glw::GL_INT, glw::GL_NONE],
    ),
    fmt(
        3,
        0,
        glw::GL_RGBA32UI,
        "GL_RGBA32UI",
        false,
        true,
        [32, 32, 32, 32, 0, 0],
        [
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_UNSIGNED_INT,
            glw::GL_NONE,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_DEPTH_COMPONENT16,
        "GL_DEPTH_COMPONENT16",
        false,
        true,
        [0, 0, 0, 0, 16, 0],
        [
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_UNSIGNED_NORMALIZED,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_DEPTH_COMPONENT24,
        "GL_DEPTH_COMPONENT24",
        false,
        true,
        [0, 0, 0, 0, 24, 0],
        [
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_UNSIGNED_NORMALIZED,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_DEPTH_COMPONENT32F,
        "GL_DEPTH_COMPONENT32F",
        false,
        true,
        [0, 0, 0, 0, 32, 0],
        [glw::GL_NONE, glw::GL_NONE, glw::GL_NONE, glw::GL_NONE, glw::GL_FLOAT],
    ),
    fmt(
        3,
        0,
        glw::GL_DEPTH24_STENCIL8,
        "GL_DEPTH24_STENCIL8",
        false,
        true,
        [0, 0, 0, 0, 24, 8],
        [
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_NONE,
            glw::GL_UNSIGNED_NORMALIZED,
        ],
    ),
    fmt(
        3,
        0,
        glw::GL_DEPTH32F_STENCIL8,
        "GL_DEPTH32F_STENCIL8",
        false,
        true,
        [0, 0, 0, 0, 32, 8],
        [glw::GL_NONE, glw::GL_NONE, glw::GL_NONE, glw::GL_NONE, glw::GL_FLOAT],
    ),
];

/// `Tests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture_size_promotion");
    group.add_child(Box::new(FunctionalTest) as Box<dyn TestCase>);
    group
}

/// The members of `FunctionalTest` that change while it iterates.
struct Runner<'a> {
    gl: &'a glw::Functions,
    context_type: ContextType,
    vao: GLuint,
    source_texture: GLuint,
    destination_texture: GLuint,
    framebuffer: GLuint,
    max_samples: GLint,
}

impl<'a> Runner<'a> {
    fn new(gl: &'a glw::Functions, context_type: ContextType) -> Self {
        Self {
            gl,
            context_type,
            vao: 0,
            source_texture: 0,
            destination_texture: 0,
            framebuffer: 0,
            max_samples: 0,
        }
    }

    /// The body of `iterate`'s `try`; `Ok(false)` is upstream's `is_ok == false` without an exception.
    fn run(&mut self, is_arb_texture_storage_multisample: bool) -> Result<bool, TestError> {
        let mut is_ok = true;

        if !self.context_type.supports_core(3, 1) {
            return Ok(is_ok);
        }

        self.prepare_vertex_array_object()?;

        for format in &FORMATS {
            if !self
                .context_type
                .supports_core(format.required_by_context.0, format.required_by_context.1)
            {
                continue;
            }

            for &(target, target_name) in &SOURCE_TEXTURE_TARGETS {
                if is_target_multisampled(target) {
                    if !is_arb_texture_storage_multisample && !self.context_type.supports_core(4, 3) {
                        continue;
                    }

                    if !format.is_color_renderable {
                        continue;
                    }

                    if format.is_depth_type() || format.is_stencil_type() {
                        continue;
                    }
                }

                if (format.is_depth_type() || format.is_stencil_type()) && target == glw::GL_TEXTURE_3D {
                    continue;
                }

                match self.prepare_source_texture(format, target) {
                    Err(TestError::NotSupported(_)) => continue,
                    Err(error) => return Err(error),
                    Ok(()) => {}
                }

                if is_ok {
                    is_ok = self.check_source_texture_size_and_type(format, target)?;
                }

                for channel in 0..COMPONENTS_COUNT {
                    match self.prepare_destination_texture_and_framebuffer(format, glw::GL_TEXTURE_2D) {
                        Err(TestError::NotSupported(message)) => {
                            // R16_SNORM is not mandatory for rendering (OpenGL 3.1, page 119).
                            if format.is_fixed_signed_type() {
                                continue;
                            }
                            return Err(TestError::Fail(message));
                        }
                        Err(error) => return Err(error),
                        Ok(()) => {}
                    }

                    let program = self.prepare_program(target, format, channel)?;

                    self.make_program_and_source_texture_active(&program, target)?;

                    self.draw_quad()?;

                    if is_ok {
                        is_ok = self.check_destination_texture(format, channel, target, target_name)?;
                    }

                    self.clean_destination_texture();
                    self.clean_framebuffer();
                    self.clean_program(program);
                }

                self.clean_source_texture()?;
            }
        }

        Ok(is_ok)
    }

    /// `prepareVertexArrayObject`
    fn prepare_vertex_array_object(&mut self) -> Result<(), TestError> {
        let gl = self.gl;
        gl_call!(
            gl,
            "glGenVertexArrays have failed",
            gl.gen_vertex_arrays(1, &mut self.vao)
        );
        gl_call!(gl, "glBindVertexArray have failed", gl.bind_vertex_array(self.vao));
        Ok(())
    }

    /// `prepareSourceTexture`
    fn prepare_source_texture(&mut self, format: &Format, target: GLenum) -> Result<(), TestError> {
        let gl = self.gl;

        gl_call!(
            gl,
            "glGetTexLevelParameteriv have failed",
            gl.gen_textures(1, &mut self.source_texture)
        );
        gl_call!(
            gl,
            "glGetTexLevelParameteriv have failed",
            gl.bind_texture(target, self.source_texture)
        );

        if !is_target_multisampled(target) {
            if format.is_depth_type() && self.context_type.supports_core(3, 1) {
                // A 3.1 context may expose GL_ARB_compatibility, whose GL_DEPTH_TEXTURE_MODE defaults to GL_LUMINANCE.
                // SAFETY: plain state calls on the current context; 0x884B is GL_DEPTH_TEXTURE_MODE.
                unsafe {
                    gl.tex_parameteri(target, 0x884B, glw::GL_RED as GLint);
                    gl.get_error();
                }
            }

            // SAFETY: plain state calls on the current context.
            unsafe {
                gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
                gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
            }

            glu::expect_no_error(gl, "glGetTexLevelParameteriv have failed")?;
        }

        let (source_data, source_type, source_format): (*const std::ffi::c_void, GLenum, GLenum) =
            if format.is_float_type() {
                (SOURCE_TEXTURE_DATA_F.as_ptr().cast(), glw::GL_FLOAT, glw::GL_RGBA)
            } else if format.is_fixed_signed_type() {
                (SOURCE_TEXTURE_DATA_SN.as_ptr().cast(), glw::GL_FLOAT, glw::GL_RGBA)
            } else if format.is_fixed_unsigned_type() {
                (SOURCE_TEXTURE_DATA_N.as_ptr().cast(), glw::GL_FLOAT, glw::GL_RGBA)
            } else if format.is_integer_signed_type() {
                (SOURCE_TEXTURE_DATA_I.as_ptr().cast(), glw::GL_INT, glw::GL_RGBA_INTEGER)
            } else if format.is_integer_unsigned_type() {
                (
                    SOURCE_TEXTURE_DATA_UI.as_ptr().cast(),
                    glw::GL_UNSIGNED_INT,
                    glw::GL_RGBA_INTEGER,
                )
            } else if format.is_depth_type() {
                (
                    SOURCE_TEXTURE_DATA_F.as_ptr().cast(),
                    glw::GL_FLOAT,
                    glw::GL_DEPTH_COMPONENT,
                )
            } else if format.is_stencil_type() {
                (
                    SOURCE_TEXTURE_DATA_UI.as_ptr().cast(),
                    glw::GL_UNSIGNED_INT,
                    glw::GL_STENCIL_INDEX,
                )
            } else {
                (std::ptr::null(), glw::GL_NONE, glw::GL_RGBA)
            };

        let internal_format = format.internal_format as GLint;

        match target {
            glw::GL_TEXTURE_1D => {
                gl_call!(
                    gl,
                    "glGetTexLevelParameteriv have failed",
                    gl.tex_image_1d(
                        target,
                        0,
                        internal_format,
                        SOURCE_TEXTURE_SIZE,
                        0,
                        source_format,
                        source_type,
                        source_data
                    )
                );
            }
            glw::GL_TEXTURE_1D_ARRAY | glw::GL_TEXTURE_2D | glw::GL_TEXTURE_RECTANGLE => {
                gl_call!(
                    gl,
                    "glGetTexLevelParameteriv have failed",
                    gl.tex_image_2d(
                        target,
                        0,
                        internal_format,
                        SOURCE_TEXTURE_SIZE,
                        SOURCE_TEXTURE_SIZE,
                        0,
                        source_format,
                        source_type,
                        source_data
                    )
                );
            }
            glw::GL_TEXTURE_2D_ARRAY | glw::GL_TEXTURE_3D => {
                gl_call!(
                    gl,
                    "glGetTexLevelParameteriv have failed",
                    gl.tex_image_3d(
                        target,
                        0,
                        internal_format,
                        SOURCE_TEXTURE_SIZE,
                        SOURCE_TEXTURE_SIZE,
                        SOURCE_TEXTURE_SIZE,
                        0,
                        source_format,
                        source_type,
                        source_data
                    )
                );
            }
            glw::GL_TEXTURE_2D_MULTISAMPLE | glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => {
                self.render_data_into_multisampled_texture(format, target)?;
            }
            _ => return Err(TestError::Fail("unexpected texture target".to_string())),
        }
        Ok(())
    }

    /// `renderDataIntoMultisampledTexture`
    fn render_data_into_multisampled_texture(&mut self, format: &Format, target: GLenum) -> Result<(), TestError> {
        let gl = self.gl;

        gl_call!(
            gl,
            "glGetIntegerv have failed",
            gl.get_integerv(glw::GL_MAX_SAMPLES, &mut self.max_samples)
        );

        if self.max_samples == 0 {
            self.max_samples = 1;
        }

        let non_ms_target = if target == glw::GL_TEXTURE_2D_MULTISAMPLE {
            glw::GL_TEXTURE_2D
        } else {
            glw::GL_TEXTURE_2D_ARRAY
        };

        self.clean_source_texture()?;

        self.prepare_source_texture(format, non_ms_target)?;

        self.prepare_destination_texture_and_framebuffer(format, target)?;

        let program = self.prepare_program(non_ms_target, format, COMPONENTS_COUNT)?;

        self.make_program_and_source_texture_active(&program, non_ms_target)?;

        self.draw_quad()?;

        self.clean_framebuffer();
        self.clean_source_texture()?;

        self.source_texture = self.destination_texture;
        self.destination_texture = 0;

        self.clean_program(program);
        Ok(())
    }

    /// `prepareDestinationTextureAndFramebuffer`
    fn prepare_destination_texture_and_framebuffer(
        &mut self,
        format: &Format,
        target: GLenum,
    ) -> Result<(), TestError> {
        let gl = self.gl;
        let internal_format = format.destination_format_for_channel();

        gl_call!(
            gl,
            "glGenFramebuffers call failed.",
            gl.gen_framebuffers(1, &mut self.framebuffer)
        );
        gl_call!(
            gl,
            "glBindFramebuffer call failed.",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.framebuffer)
        );

        gl_call!(
            gl,
            "glGetTexLevelParameteriv have failed",
            gl.gen_textures(1, &mut self.destination_texture)
        );
        gl_call!(
            gl,
            "glGetTexLevelParameteriv have failed",
            gl.bind_texture(target, self.destination_texture)
        );

        if target == glw::GL_TEXTURE_2D {
            let mut destination_format = glw::GL_RED;
            let mut destination_type = glw::GL_FLOAT;
            let mut destination_data: *const std::ffi::c_void = DESTINATION_TEXTURE_DATA_F.as_ptr().cast();

            if format.is_integer_signed_type() {
                destination_format = glw::GL_RED_INTEGER;
                destination_type = glw::GL_INT;
                destination_data = DESTINATION_TEXTURE_DATA_I.as_ptr().cast();
            }

            if format.is_integer_unsigned_type() {
                destination_format = glw::GL_RED_INTEGER;
                destination_type = glw::GL_UNSIGNED_INT;
                destination_data = DESTINATION_TEXTURE_DATA_UI.as_ptr().cast();
            }

            gl_call!(
                gl,
                "glGetTexLevelParameteriv have failed",
                gl.tex_image_2d(
                    target,
                    0,
                    internal_format as GLint,
                    SOURCE_TEXTURE_SIZE,
                    SOURCE_TEXTURE_SIZE,
                    0,
                    destination_format,
                    destination_type,
                    destination_data
                )
            );

            gl_call!(
                gl,
                "glFramebufferTexture2D have failed",
                gl.framebuffer_texture_2d(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_TEXTURE_2D,
                    self.destination_texture,
                    0
                )
            );
        } else if target == glw::GL_TEXTURE_2D_MULTISAMPLE {
            gl_call!(
                gl,
                "glGetTexLevelParameteriv have failed",
                gl.tex_image_2d_multisample(
                    target,
                    self.max_samples - 1,
                    format.internal_format,
                    SOURCE_TEXTURE_SIZE,
                    SOURCE_TEXTURE_SIZE,
                    glw::GL_TRUE as glw::GLboolean
                )
            );

            gl_call!(
                gl,
                "glFramebufferTexture2D have failed",
                gl.framebuffer_texture_2d(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    target,
                    self.destination_texture,
                    0
                )
            );
        } else {
            gl_call!(
                gl,
                "glGetTexLevelParameteriv have failed",
                gl.tex_image_3d_multisample(
                    target,
                    self.max_samples - 1,
                    format.internal_format,
                    SOURCE_TEXTURE_SIZE,
                    SOURCE_TEXTURE_SIZE,
                    SOURCE_TEXTURE_SIZE,
                    glw::GL_TRUE as glw::GLboolean
                )
            );

            gl_call!(
                gl,
                "glFramebufferTexture2D have failed",
                gl.framebuffer_texture_layer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    self.destination_texture,
                    0,
                    0
                )
            );
        }

        // SAFETY: a plain query on the current context.
        let status = unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) };
        if status != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(if status == glw::GL_FRAMEBUFFER_UNSUPPORTED {
                TestError::NotSupported("unsupported framebuffer configuration".to_string())
            } else {
                TestError::Fail("incomplete framebuffer".to_string())
            });
        }

        gl_call!(
            gl,
            "glViewport call failed.",
            gl.viewport(0, 0, SOURCE_TEXTURE_SIZE, SOURCE_TEXTURE_SIZE)
        );
        Ok(())
    }

    /// `makeProgramAndSourceTextureActive`
    fn make_program_and_source_texture_active(
        &self,
        program: &ShaderProgram<'_>,
        target: GLenum,
    ) -> Result<(), TestError> {
        let gl = self.gl;

        gl_call!(gl, "glUseProgram have failed", gl.use_program(program.program()));
        gl_call!(gl, "glActiveTexture have failed", gl.active_texture(glw::GL_TEXTURE0));
        gl_call!(
            gl,
            "glGetTexLevelParameteriv have failed",
            gl.bind_texture(target, self.source_texture)
        );

        // SAFETY: a NUL-terminated name.
        let location = unsafe { gl.get_uniform_location(program.program(), c"data".as_ptr()) };
        glu::expect_no_error(gl, "glGetUniformLocation have failed")?;

        gl_call!(gl, "glUniform1i have failed", gl.uniform_1i(location, 0));
        Ok(())
    }

    /// `checkSourceTextureSizeAndType`
    fn check_source_texture_size_and_type(&self, format: &Format, target: GLenum) -> Result<bool, TestError> {
        let gl = self.gl;

        gl_call!(
            gl,
            "glGetTexLevelParameteriv have failed",
            gl.bind_texture(target, self.source_texture)
        );

        let size_pnames = [
            glw::GL_TEXTURE_RED_SIZE,
            glw::GL_TEXTURE_GREEN_SIZE,
            glw::GL_TEXTURE_BLUE_SIZE,
            glw::GL_TEXTURE_ALPHA_SIZE,
            glw::GL_TEXTURE_DEPTH_SIZE,
            glw::GL_TEXTURE_STENCIL_SIZE,
        ];
        let type_pnames = [
            glw::GL_TEXTURE_RED_TYPE,
            glw::GL_TEXTURE_GREEN_TYPE,
            glw::GL_TEXTURE_BLUE_TYPE,
            glw::GL_TEXTURE_ALPHA_TYPE,
            glw::GL_TEXTURE_DEPTH_TYPE,
        ];

        let mut sizes: [GLint; 6] = [0; 6];
        let mut types: [GLint; 5] = [0; 5];

        // SAFETY: every pointer is to one element of a live local array.
        unsafe {
            for (size, pname) in sizes.iter_mut().zip(size_pnames) {
                gl.get_tex_level_parameteriv(target, 0, pname, size);
            }
            for (ty, pname) in types.iter_mut().zip(type_pnames) {
                gl.get_tex_level_parameteriv(target, 0, pname, ty);
            }
        }

        glu::expect_no_error(gl, "glGetTexLevelParameteriv have failed")?;

        let is_ok = sizes
            .iter()
            .zip(&format.min_size)
            .all(|(queried, expected)| queried >= expected)
            && types
                .iter()
                .zip(&format.expected_type)
                .all(|(queried, expected)| *queried as GLenum == *expected);

        if !is_ok {
            log::info!(
                "Promotion from internal format {} have failed during glGetTexLevelParameteriv query. Expected sizes (r, g, b, a, depth, stencil) = {:?}, queried sizes = {:?}. Expected types (r, g, b, a, depth) = {:#x?}, queried types = {:#x?}.",
                format.internal_format_name,
                format.min_size,
                sizes,
                format.expected_type,
                types
            );
        }

        Ok(is_ok)
    }

    /// `prepareProgram`
    fn prepare_program(&self, target: GLenum, format: &Format, channel: usize) -> Result<ShaderProgram<'a>, TestError> {
        let gl = self.gl;

        let (sampler_name, texel_fetch_arguments_tail) = match target {
            glw::GL_TEXTURE_1D => ("sampler1D", "0, 0".to_string()),
            glw::GL_TEXTURE_2D => ("sampler2D", "ivec2(0), 0".to_string()),
            glw::GL_TEXTURE_1D_ARRAY => ("sampler1DArray", "ivec2(0), 0".to_string()),
            glw::GL_TEXTURE_RECTANGLE => ("sampler2DRect", "ivec2(0)".to_string()),
            glw::GL_TEXTURE_2D_ARRAY => ("sampler2DArray", "ivec3(0), 0".to_string()),
            glw::GL_TEXTURE_3D => ("sampler3D", "ivec3(0), 0".to_string()),
            glw::GL_TEXTURE_2D_MULTISAMPLE => ("sampler2DMS", format!("ivec2(0), {}", self.max_samples - 1)),
            glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => ("sampler2DMSArray", format!("ivec3(0), {}", self.max_samples - 1)),
            _ => return Err(TestError::Fail("unexpected texture target".to_string())),
        };

        let component_name = match channel {
            0 => ".r",
            1 => ".g",
            2 => ".b",
            3 => ".a",
            _ => "",
        };

        let all_channels = channel == COMPONENTS_COUNT;
        let (type_name, sampler_prefix) = if format.is_float_type()
            || format.is_fixed_signed_type()
            || format.is_fixed_unsigned_type()
            || format.is_depth_type()
            || format.is_stencil_type()
        {
            (if all_channels { "vec4" } else { "float" }, "")
        } else if format.is_integer_signed_type() {
            (if all_channels { "ivec4" } else { "int" }, "i")
        } else {
            (if all_channels { "uvec4" } else { "uint" }, "u")
        };

        let fragment_shader = FRAGMENT_SHADER_TEMPLATE
            .replace("TEMPLATE_TYPE", type_name)
            .replace("TEMPLATE_SAMPLER", &format!("{sampler_prefix}{sampler_name}"))
            .replace("TEMPLATE_TEXEL_FETCH_ARGUMENTS", &texel_fetch_arguments_tail)
            .replace("TEMPLATE_COMPONENT", component_name);

        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_CODE, fragment_shader));

        if !program.is_ok() {
            log::info!(
                "Shader build failed.\n{}",
                program.build_failure_summary().unwrap_or_default()
            );
            return Err(TestError::Fail("program build failed".to_string()));
        }

        Ok(program)
    }

    /// `drawQuad`
    fn draw_quad(&self) -> Result<(), TestError> {
        let gl = self.gl;
        gl_call!(
            gl,
            "glDrawArrays have failed",
            gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4)
        );
        Ok(())
    }

    /// `checkDestinationTexture`
    fn check_destination_texture(
        &self,
        format: &Format,
        channel: usize,
        target: GLenum,
        target_name: &str,
    ) -> Result<bool, TestError> {
        let gl = self.gl;

        let compare_float = |pixel: f32, expected_value: f32| -> bool {
            if (pixel - expected_value).abs() <= format.get_min_precision(channel) {
                return true;
            }
            log::info!(
                "Promotion from internal format {} have failed during functional test of {} channel with target {}. Expected value = {} read value = {}.",
                format.internal_format_name,
                COLOR_CHANNEL_NAMES[channel],
                target_name,
                expected_value,
                pixel
            );
            false
        };

        let missing_channel_value = if channel == ALPHA_COMPONENT { 1.0 } else { 0.0 };

        if format.is_depth_type() || format.is_stencil_type() {
            let mut pixel: f32 = 3.1415927;
            gl_call!(
                gl,
                "glReadPixels have failed",
                gl.read_pixels(
                    0,
                    0,
                    1,
                    1,
                    glw::GL_RED,
                    glw::GL_FLOAT,
                    std::ptr::from_mut(&mut pixel).cast()
                )
            );

            let expected_value = if channel == RED_COMPONENT {
                SOURCE_TEXTURE_DATA_F[0]
            } else if channel == ALPHA_COMPONENT {
                1.0
            } else {
                0.0
            };

            return Ok(compare_float(pixel, expected_value));
        }

        if format.is_float_type() || format.is_fixed_signed_type() || format.is_fixed_unsigned_type() {
            let mut pixel: f32 = 3.1415927;
            gl_call!(
                gl,
                "glReadPixels have failed",
                gl.read_pixels(
                    0,
                    0,
                    1,
                    1,
                    glw::GL_RED,
                    glw::GL_FLOAT,
                    std::ptr::from_mut(&mut pixel).cast()
                )
            );

            let expected_value = if format.is_channel_type_none(channel) {
                missing_channel_value
            } else if format.is_float_type() {
                SOURCE_TEXTURE_DATA_F[channel]
            } else if format.is_fixed_signed_type() {
                // Signed fixed-point read colours are clamped to [0, 1] by default.
                SOURCE_TEXTURE_DATA_SN[channel].clamp(0.0, 1.0)
            } else {
                let mut expected_value = SOURCE_TEXTURE_DATA_N[channel];

                if format.is_srgb && channel < ALPHA_COMPONENT {
                    expected_value = convert_from_srgb(expected_value);

                    // Multisampled targets convert twice: in the upload and in the shader.
                    if is_target_multisampled(target) {
                        expected_value = convert_from_srgb(expected_value);
                    }
                }
                expected_value
            };

            return Ok(compare_float(pixel, expected_value));
        }

        if format.is_integer_signed_type() {
            let mut pixel: GLint = 5;
            gl_call!(
                gl,
                "glReadPixels have failed",
                gl.read_pixels(
                    0,
                    0,
                    1,
                    1,
                    glw::GL_RED_INTEGER,
                    glw::GL_INT,
                    std::ptr::from_mut(&mut pixel).cast()
                )
            );

            let expected_value = if format.is_channel_type_none(channel) {
                i32::from(channel == ALPHA_COMPONENT)
            } else {
                SOURCE_TEXTURE_DATA_I[channel]
            };

            if pixel == expected_value {
                return Ok(true);
            }
            log::info!(
                "Promotion from internal format {} have failed during functional test of {} channel with target {}. Expected value = {} read value = {}.",
                format.internal_format_name,
                COLOR_CHANNEL_NAMES[channel],
                target_name,
                expected_value,
                pixel
            );
            return Ok(false);
        }

        if format.is_integer_unsigned_type() {
            let mut pixel: GLuint = 5;
            gl_call!(
                gl,
                "glReadPixels have failed",
                gl.read_pixels(
                    0,
                    0,
                    1,
                    1,
                    glw::GL_RED_INTEGER,
                    glw::GL_UNSIGNED_INT,
                    std::ptr::from_mut(&mut pixel).cast()
                )
            );

            let expected_value = if format.is_channel_type_none(channel) {
                u32::from(channel == ALPHA_COMPONENT)
            } else {
                SOURCE_TEXTURE_DATA_UI[channel]
            };

            if pixel == expected_value {
                return Ok(true);
            }
            log::info!(
                "Promotion from internal format {} have failed during functional test of {} channel with target {}. Expected value = {} read value = {}.",
                format.internal_format_name,
                COLOR_CHANNEL_NAMES[channel],
                target_name,
                expected_value,
                pixel
            );
            return Ok(false);
        }

        Ok(false)
    }

    /// `cleanSourceTexture`
    fn clean_source_texture(&mut self) -> Result<(), TestError> {
        let gl = self.gl;
        if self.source_texture != 0 {
            gl_call!(
                gl,
                "glDeleteTextures have failed",
                gl.delete_textures(1, &self.source_texture)
            );
            self.source_texture = 0;
        }
        Ok(())
    }

    /// `cleanDestinationTexture`
    fn clean_destination_texture(&mut self) {
        if self.destination_texture != 0 {
            // SAFETY: the name was generated by this runner and is deleted once.
            unsafe { self.gl.delete_textures(1, &self.destination_texture) };
            self.destination_texture = 0;
        }
    }

    /// `cleanFramebuffer`
    fn clean_framebuffer(&mut self) {
        if self.framebuffer != 0 {
            // SAFETY: the name was generated by this runner and is deleted once.
            unsafe { self.gl.delete_framebuffers(1, &self.framebuffer) };
            self.framebuffer = 0;
        }
    }

    /// `cleanProgram`; the program itself is deleted when `ShaderProgram` drops.
    fn clean_program(&self, program: ShaderProgram<'_>) {
        // SAFETY: unbinding is always valid on the current context.
        unsafe { self.gl.use_program(0) };
        drop(program);
    }

    /// `cleanVertexArrayObject`
    fn clean_vertex_array_object(&mut self) {
        if self.vao != 0 {
            // SAFETY: the name was generated by this runner and is deleted once.
            unsafe { self.gl.delete_vertex_arrays(1, &self.vao) };
            self.vao = 0;
        }
    }
}

/// `FunctionalTest`
struct FunctionalTest;

impl TestCase for FunctionalTest {
    fn name(&self) -> &str {
        "functional"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let is_arb_texture_storage_multisample = context
            .context_info
            .is_extension_supported("GL_ARB_texture_storage_multisample");

        let mut runner = Runner::new(context.gl(), context.context_type());
        let result = runner.run(is_arb_texture_storage_multisample);

        let _ = runner.clean_source_texture();
        runner.clean_destination_texture();
        runner.clean_framebuffer();
        runner.clean_vertex_array_object();

        match result {
            Ok(true) => {
                log::info!("Texture Size Promotion Test have passed.");
                Ok(TestStatus::pass("Pass"))
            }
            Ok(false) => {
                log::info!("Texture Size Promotion Test have failed.");
                Ok(TestStatus::fail("Fail"))
            }
            Err(error) => {
                log::info!("Texture Size Promotion Test have approached error: {error:?}");
                Err(TestError::InternalError("Error".to_string()))
            }
        }
    }
}
