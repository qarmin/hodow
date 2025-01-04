// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cTextureGatherTests.cpp
//   external/openglcts/modules/gl/gl4cTextureGatherTests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The case classes are `Subcase`s (see `subcase.rs`). The `GatherBase` class hierarchy, whose subclasses only override `Init`, `Sampler`, `TextBody`, `InternalFormat`, `Format`, `Type`, `SetRbo`, `Expected`, `BufferData`, `Verify` and `Supported`, is a `Spec` value: one constructor per upstream class, built on the constructor of its base class exactly as the C++ class derives from it (including `OffsetsGatherInt2DRect` deriving from `PlainGatherUint2DRect`). The `TestFunction` overrides of some classes are the same `Sampler` + `TextBody` pair. `CheckProgram` logs the info log only.

use super::subcase::{ERROR, NO_ERROR, Subcase, SubcaseResult, TestSubcase, output_not_supported};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

type Vec4 = [f32; 4];

static DATA: [Vec4; 4] = [
    [12.0 / 16.0, 13.0 / 16.0, 14.0 / 16.0, 15.0 / 16.0],
    [8.0 / 16.0, 9.0 / 16.0, 10.0 / 16.0, 11.0 / 16.0],
    [0.0 / 16.0, 1.0 / 16.0, 2.0 / 16.0, 3.0 / 16.0],
    [4.0 / 16.0, 5.0 / 16.0, 6.0 / 16.0, 7.0 / 16.0],
];

static DATA_INT: [[i32; 4]; 4] = [[12, 13, 14, 15], [8, 9, 10, 11], [0, 1, 2, 3], [4, 5, 6, 7]];

const FACES: [GLenum; 6] = [
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
];

fn v4(x: f64, y: f64, z: f64, w: f64) -> Vec4 {
    [x as f32, y as f32, z as f32, w as f32]
}

/// `Vec4(a, b, c, d)` with float literals such as `22.9f`, divided in float as upstream does.
fn f(value: f32) -> f64 {
    f64::from(value)
}

fn expected_default() -> Vec4 {
    v4(0. / 16., 4. / 16., 8. / 16., 12. / 16.)
}

/// `GatherBase::Create*`: which texture `Init` builds.
#[derive(Clone, Copy)]
enum Init {
    Texture2D {
        rect: bool,
        base_level: bool,
    },
    Texture2DInt {
        rect: bool,
    },
    Texture2DArray {
        slices: i32,
        data_slice: i32,
    },
    Texture2DArrayInt {
        slices: i32,
        data_slice: i32,
    },
    TextureCube,
    TextureCubeInt,
    TextureCubeArray {
        slices: i32,
        data_slice: i32,
    },
    TextureCubeArrayInt {
        slices: i32,
        data_slice: i32,
    },
    /// `CreateTexture2DRgb`, `CreateTexture2DRg`, `CreateTexture2DR` by component count
    Texture2DComponents(usize),
    /// `IncompleteTexture::Init`
    Incomplete,
}

#[derive(Clone, Copy)]
enum Verify {
    Float(Vec4),
    Int { expected: [i32; 4], read_type: GLenum },
}

#[derive(Clone)]
struct Spec {
    init: Init,
    compare_target: Option<GLenum>,
    internal_format: GLenum,
    format: GLenum,
    type_name: &'static str,
    sampler: &'static str,
    body: &'static str,
    rbo_format: GLenum,
    verify: Verify,
    buffer_data: Vec4,
    needs_cube_map_array: bool,
}

/// `GatherBase`
fn base() -> Spec {
    Spec {
        init: Init::Texture2D {
            rect: false,
            base_level: false,
        },
        compare_target: None,
        internal_format: glw::GL_RGBA32F,
        format: glw::GL_RGBA,
        type_name: "vec4",
        sampler: "uniform sampler2D my_sampler;",
        body: "return textureGather(my_sampler, vec2(p.x, p.y));",
        rbo_format: glw::GL_RGBA32F,
        verify: Verify::Float(expected_default()),
        buffer_data: v4(23. / 32., 26. / 32., 5., 3.),
        needs_cube_map_array: false,
    }
}

fn expected_rg() -> Vec4 {
    v4(1. / 16., 5. / 16., 9. / 16., 13. / 16.)
}

fn expected_depth_high() -> Vec4 {
    [1.0, 1.0, 0.0, 0.0]
}

fn expected_depth_low() -> Vec4 {
    [0.0, 0.0, 1.0, 1.0]
}

fn float_2d_rg() -> Spec {
    Spec {
        internal_format: glw::GL_RG32F,
        body: "return textureGather(my_sampler, vec2(p.x, p.y), 1);",
        verify: Verify::Float(expected_rg()),
        ..base()
    }
}

fn unorm_2d() -> Spec {
    Spec {
        internal_format: glw::GL_RGBA16,
        body: "return textureGather(my_sampler, vec2(p.x, p.y), 0);",
        ..base()
    }
}

fn int_2d_rgba() -> Spec {
    Spec {
        internal_format: glw::GL_RGBA32I,
        init: Init::Texture2DInt { rect: false },
        rbo_format: glw::GL_RGBA32I,
        verify: Verify::Int {
            expected: [0, 4, 8, 12],
            read_type: glw::GL_INT,
        },
        sampler: "uniform isampler2D my_sampler;",
        type_name: "ivec4",
        ..base()
    }
}

fn int_2d_rg() -> Spec {
    Spec {
        internal_format: glw::GL_RG32I,
        ..int_2d_rgba()
    }
}

fn uint_2d() -> Spec {
    Spec {
        internal_format: glw::GL_RGBA32UI,
        init: Init::Texture2DInt { rect: false },
        rbo_format: glw::GL_RGBA32UI,
        verify: Verify::Int {
            expected: [2, 6, 10, 14],
            read_type: glw::GL_UNSIGNED_INT,
        },
        sampler: "uniform usampler2D my_sampler;",
        buffer_data: v4(f(22.9f32) / 32., f(25.9f32) / 32., 2., 2.),
        type_name: "uvec4",
        body: "return textureGather(my_sampler, vec2(p.x, p.y), 2);",
        ..base()
    }
}

fn depth_2d() -> Spec {
    Spec {
        internal_format: glw::GL_DEPTH_COMPONENT32F,
        format: glw::GL_DEPTH_COMPONENT,
        compare_target: Some(glw::GL_TEXTURE_2D),
        verify: Verify::Float(expected_depth_high()),
        buffer_data: v4(23. / 32., 26. / 32., 13.5 / 16., 3.),
        sampler: "uniform sampler2DShadow my_sampler;",
        body: "return textureGather(my_sampler, vec2(p.x, p.y), p.z);",
        ..base()
    }
}

fn float_2d_array() -> Spec {
    Spec {
        init: Init::Texture2DArray {
            slices: 9,
            data_slice: 5,
        },
        sampler: "uniform sampler2DArray my_sampler;",
        body: "return textureGather(my_sampler, vec3(p.x, p.y, p.z));",
        ..base()
    }
}

fn unorm_2d_array() -> Spec {
    Spec {
        init: Init::Texture2DArray {
            slices: 7,
            data_slice: 3,
        },
        sampler: "uniform sampler2DArray my_sampler;",
        body: "return textureGather(my_sampler, vec3(p.x, p.y, p.w));",
        internal_format: glw::GL_RGBA16,
        ..base()
    }
}

fn int_2d_array() -> Spec {
    Spec {
        init: Init::Texture2DArrayInt {
            slices: 20,
            data_slice: 11,
        },
        internal_format: glw::GL_RGBA32I,
        rbo_format: glw::GL_RGBA32I,
        verify: Verify::Int {
            expected: [3, 7, 11, 15],
            read_type: glw::GL_INT,
        },
        type_name: "ivec4",
        buffer_data: v4(23. / 32., 26. / 32., 11., 3.),
        sampler: "uniform isampler2DArray my_sampler;",
        body: "return textureGather(my_sampler, vec3(p.x, p.y, p.z), 3);",
        ..base()
    }
}

fn uint_2d_array() -> Spec {
    Spec {
        init: Init::Texture2DArrayInt {
            slices: 3,
            data_slice: 1,
        },
        internal_format: glw::GL_RGBA32UI,
        rbo_format: glw::GL_RGBA32UI,
        verify: Verify::Int {
            expected: [0, 4, 8, 12],
            read_type: glw::GL_UNSIGNED_INT,
        },
        type_name: "uvec4",
        buffer_data: v4(23. / 32., 26. / 32., 1., 3.),
        sampler: "uniform usampler2DArray my_sampler;",
        body: "return textureGather(my_sampler, vec3(p.x, p.y, p.z));",
        ..base()
    }
}

fn depth_2d_array() -> Spec {
    Spec {
        internal_format: glw::GL_DEPTH_COMPONENT32F,
        format: glw::GL_DEPTH_COMPONENT,
        init: Init::Texture2DArray {
            slices: 9,
            data_slice: 5,
        },
        compare_target: Some(glw::GL_TEXTURE_2D_ARRAY),
        verify: Verify::Float(expected_depth_high()),
        buffer_data: v4(23. / 32., 26. / 32., 5., 13.5 / 16.),
        sampler: "uniform sampler2DArrayShadow my_sampler;",
        body: "return textureGather(my_sampler, vec3(p.x, p.y, p.z), p.w);",
        ..base()
    }
}

const CUBE_BUFFER: [f64; 4] = [7. / 16., -10. / 16., 1., 7.5 / 16.];

fn cube_buffer() -> Vec4 {
    v4(CUBE_BUFFER[0], CUBE_BUFFER[1], CUBE_BUFFER[2], CUBE_BUFFER[3])
}

fn float_cube_rgba() -> Spec {
    Spec {
        init: Init::TextureCube,
        buffer_data: cube_buffer(),
        sampler: "uniform samplerCube my_sampler;",
        body: "return textureGather(my_sampler, vec3(p.x, p.y, p.z));",
        ..base()
    }
}

fn float_cube_rg() -> Spec {
    Spec {
        body: "return textureGather(my_sampler, vec3(p.x, p.y, p.z), 1);",
        verify: Verify::Float(expected_rg()),
        internal_format: glw::GL_RG32F,
        ..float_cube_rgba()
    }
}

fn unorm_cube() -> Spec {
    Spec {
        internal_format: glw::GL_RGBA16,
        ..float_cube_rgba()
    }
}

fn int_cube_rgba() -> Spec {
    Spec {
        init: Init::TextureCubeInt,
        buffer_data: cube_buffer(),
        sampler: "uniform isamplerCube my_sampler;",
        body: "return textureGather(my_sampler, vec3(p.x, p.y, p.z));",
        internal_format: glw::GL_RGBA32I,
        rbo_format: glw::GL_RGBA32I,
        verify: Verify::Int {
            expected: [0, 4, 8, 12],
            read_type: glw::GL_INT,
        },
        type_name: "ivec4",
        ..base()
    }
}

fn int_cube_rg() -> Spec {
    Spec {
        body: "return textureGather(my_sampler, vec3(p.x, p.y, p.z), 1);",
        internal_format: glw::GL_RG32I,
        verify: Verify::Int {
            expected: [1, 5, 9, 13],
            read_type: glw::GL_INT,
        },
        ..int_cube_rgba()
    }
}

/// `PlainGatherUintCube::Verify` reads with `GL_INT`.
fn uint_cube() -> Spec {
    Spec {
        sampler: "uniform usamplerCube my_sampler;",
        body: "return textureGather(my_sampler, vec3(p.x, p.y, p.z), 0);",
        internal_format: glw::GL_RGBA32UI,
        rbo_format: glw::GL_RGBA32UI,
        type_name: "uvec4",
        ..int_cube_rgba()
    }
}

fn depth_cube() -> Spec {
    Spec {
        init: Init::TextureCube,
        compare_target: Some(glw::GL_TEXTURE_CUBE_MAP),
        internal_format: glw::GL_DEPTH_COMPONENT32F,
        format: glw::GL_DEPTH_COMPONENT,
        buffer_data: cube_buffer(),
        sampler: "uniform samplerCubeShadow my_sampler;",
        body: "return textureGather(my_sampler, vec3(p.x, p.y, p.z), p.w);",
        verify: Verify::Float(expected_depth_low()),
        ..base()
    }
}

fn float_cube_array() -> Spec {
    Spec {
        needs_cube_map_array: true,
        init: Init::TextureCubeArray {
            slices: 9,
            data_slice: 5,
        },
        buffer_data: v4(7. / 16., -10. / 16., 1., 5.),
        sampler: "uniform samplerCubeArray my_sampler;",
        body: "return textureGather(my_sampler, p);",
        ..base()
    }
}

fn unorm_cube_array() -> Spec {
    Spec {
        init: Init::TextureCubeArray {
            slices: 7,
            data_slice: 3,
        },
        buffer_data: v4(7. / 16., -10. / 16., 1., 3.),
        internal_format: glw::GL_RGBA16,
        ..float_cube_array()
    }
}

fn int_cube_array() -> Spec {
    Spec {
        needs_cube_map_array: true,
        init: Init::TextureCubeArrayInt {
            slices: 20,
            data_slice: 11,
        },
        buffer_data: v4(7. / 16., -10. / 16., 1., 11.),
        sampler: "uniform isamplerCubeArray my_sampler;",
        body: "return textureGather(my_sampler, p);",
        internal_format: glw::GL_RGBA32I,
        rbo_format: glw::GL_RGBA32I,
        verify: Verify::Int {
            expected: [0, 4, 8, 12],
            read_type: glw::GL_INT,
        },
        type_name: "ivec4",
        ..base()
    }
}

fn uint_cube_array() -> Spec {
    Spec {
        init: Init::TextureCubeArrayInt {
            slices: 3,
            data_slice: 1,
        },
        buffer_data: v4(7. / 16., -10. / 16., 1., 1.),
        sampler: "uniform usamplerCubeArray my_sampler;",
        internal_format: glw::GL_RGBA32UI,
        rbo_format: glw::GL_RGBA32UI,
        verify: Verify::Int {
            expected: [0, 4, 8, 12],
            read_type: glw::GL_UNSIGNED_INT,
        },
        type_name: "uvec4",
        ..int_cube_array()
    }
}

fn depth_cube_array() -> Spec {
    Spec {
        needs_cube_map_array: true,
        init: Init::TextureCubeArray {
            slices: 7,
            data_slice: 3,
        },
        compare_target: Some(glw::GL_TEXTURE_CUBE_MAP_ARRAY),
        buffer_data: v4(7. / 16., -10. / 16., 1., 3.),
        sampler: "uniform samplerCubeArrayShadow my_sampler;",
        body: "return textureGather(my_sampler, p, 7.5/16);",
        internal_format: glw::GL_DEPTH_COMPONENT32F,
        format: glw::GL_DEPTH_COMPONENT,
        verify: Verify::Float(expected_depth_low()),
        ..base()
    }
}

fn float_2d_rect() -> Spec {
    Spec {
        init: Init::Texture2D {
            rect: true,
            base_level: false,
        },
        buffer_data: v4(23., 26., 0., 0.),
        sampler: "uniform sampler2DRect my_sampler;",
        verify: Verify::Float(expected_rg()),
        body: "return textureGather(my_sampler, vec2(p.x, p.y), 1);",
        ..base()
    }
}

fn unorm_2d_rect() -> Spec {
    Spec {
        init: Init::Texture2D {
            rect: true,
            base_level: false,
        },
        buffer_data: v4(23., 26., 0., 0.),
        sampler: "uniform sampler2DRect my_sampler;",
        body: "return textureGather(my_sampler, vec2(p.x, p.y));",
        internal_format: glw::GL_RGBA16,
        ..base()
    }
}

fn int_2d_rect() -> Spec {
    Spec {
        init: Init::Texture2DInt { rect: true },
        buffer_data: v4(f(22.9f32), f(25.9f32), 0., 0.),
        sampler: "uniform isampler2DRect my_sampler;",
        body: "return textureGather(my_sampler, vec2(p.x, p.y));",
        internal_format: glw::GL_RGBA32I,
        rbo_format: glw::GL_RGBA32I,
        verify: Verify::Int {
            expected: [0, 4, 8, 12],
            read_type: glw::GL_INT,
        },
        type_name: "ivec4",
        ..base()
    }
}

fn uint_2d_rect() -> Spec {
    Spec {
        init: Init::Texture2DInt { rect: true },
        buffer_data: v4(f(22.9f32), f(25.9f32), 0., 0.),
        sampler: "uniform usampler2DRect my_sampler;",
        body: "return textureGather(my_sampler, vec2(p.x, p.y));",
        internal_format: glw::GL_RGBA32UI,
        rbo_format: glw::GL_RGBA32UI,
        verify: Verify::Int {
            expected: [0, 4, 8, 12],
            read_type: glw::GL_UNSIGNED_INT,
        },
        type_name: "uvec4",
        ..base()
    }
}

fn depth_2d_rect() -> Spec {
    Spec {
        init: Init::Texture2D {
            rect: true,
            base_level: false,
        },
        compare_target: Some(glw::GL_TEXTURE_RECTANGLE),
        buffer_data: v4(23., 26., 13.5 / 16., 3.),
        sampler: "uniform sampler2DRectShadow my_sampler;",
        body: "return textureGather(my_sampler, vec2(p.x, p.y), p.z);",
        internal_format: glw::GL_DEPTH_COMPONENT32F,
        format: glw::GL_DEPTH_COMPONENT,
        verify: Verify::Float(expected_depth_high()),
        ..base()
    }
}

const OFFSET_2D: &str = "return textureGatherOffset(my_sampler, vec2(p.x, p.y), ivec2(int(p.z)));";
const OFFSET_2D_W: &str = "return textureGatherOffset(my_sampler, vec2(p.x, p.y), ivec2(int(p.w)));";
const OFFSET_3D_W: &str = "return textureGatherOffset(my_sampler, vec3(p.x, p.y, p.z), ivec2(int(p.w)));";

/// `OffsetsGather*` bodies: `textureGatherOffsets` over the fixed offsets array.
macro_rules! offsets_body {
    ($call:literal) => {
        concat!(
            "const ivec2 offsets[4] = ivec2[](ivec2(7, 6), ivec2(-8, 7), ivec2(-6, -5), ivec2(-1, 3));\n    ",
            $call
        )
    };
}

fn offset_float_2d() -> Spec {
    Spec {
        buffer_data: v4(19. / 32., 22. / 32., 4., 4.),
        body: OFFSET_2D,
        ..base()
    }
}

fn offset_unorm_2d() -> Spec {
    Spec {
        buffer_data: v4(19. / 32., 22. / 32., 4., 4.),
        body: OFFSET_2D,
        ..unorm_2d()
    }
}

fn offset_int_2d() -> Spec {
    Spec {
        buffer_data: v4(f(18.9f32) / f(32.0f32), f(21.9f32) / f(32.0f32), 4., 4.),
        body: OFFSET_2D,
        ..int_2d_rgba()
    }
}

fn offset_uint_2d() -> Spec {
    Spec {
        buffer_data: v4(f(18.9f32) / f(32.0f32), f(21.9f32) / f(32.0f32), 4., 2.),
        body: "return textureGatherOffset(my_sampler, vec2(p.x, p.y), ivec2(int(p.z)), 2);",
        ..uint_2d()
    }
}

fn offset_depth_2d() -> Spec {
    Spec {
        buffer_data: v4(19. / 32., 22. / 32., 4., 13.5 / 16.),
        body: "return textureGatherOffset(my_sampler, vec2(p.x, p.y), p.w, ivec2(int(p.z)));",
        ..depth_2d()
    }
}

fn offset_float_2d_array() -> Spec {
    Spec {
        buffer_data: v4(19. / 32., 22. / 32., 5., 4.),
        body: OFFSET_3D_W,
        ..float_2d_array()
    }
}

fn offset_unorm_2d_array() -> Spec {
    Spec {
        buffer_data: v4(19. / 32., 22. / 32., 3., 4.),
        body: OFFSET_3D_W,
        ..unorm_2d_array()
    }
}

fn offset_int_2d_array() -> Spec {
    Spec {
        buffer_data: v4(19. / 32., 22. / 32., 11., 4.),
        body: "return textureGatherOffset(my_sampler, vec3(p.x, p.y, p.z), ivec2(int(p.w)), 3);",
        ..int_2d_array()
    }
}

fn offset_uint_2d_array() -> Spec {
    Spec {
        buffer_data: v4(19. / 32., 22. / 32., 1., 4.),
        body: OFFSET_3D_W,
        ..uint_2d_array()
    }
}

fn offset_depth_2d_array() -> Spec {
    Spec {
        init: Init::Texture2DArray {
            slices: 7,
            data_slice: 3,
        },
        buffer_data: v4(19. / 32., 22. / 32., 3., 4.),
        body: "return textureGatherOffset(my_sampler, vec3(p.x, p.y, p.z), p.y + (5./32), ivec2(int(p.w)));",
        ..depth_2d_array()
    }
}

fn offset_float_2d_rect() -> Spec {
    Spec {
        buffer_data: v4(19., 22., 0., 4.),
        body: "return textureGatherOffset(my_sampler, vec2(p.x, p.y), ivec2(int(p.w)), 1);",
        ..float_2d_rect()
    }
}

fn offset_unorm_2d_rect() -> Spec {
    Spec {
        buffer_data: v4(f(30.9f32), f(18.9f32), -8., 7.),
        body: "return textureGatherOffset(my_sampler, vec2(p.x, p.y), ivec2(int(p.z), int(p.w)));",
        ..unorm_2d_rect()
    }
}

fn offset_int_2d_rect() -> Spec {
    Spec {
        buffer_data: v4(f(22.9f32), f(25.9f32), 0., 0.),
        body: OFFSET_2D_W,
        ..int_2d_rect()
    }
}

fn offset_uint_2d_rect() -> Spec {
    Spec {
        buffer_data: v4(f(26.9f32), f(29.9f32), 0., -4.),
        body: OFFSET_2D_W,
        ..uint_2d_rect()
    }
}

fn offset_depth_2d_rect() -> Spec {
    Spec {
        buffer_data: v4(19., 22., 13.5 / 16., 4.),
        body: "return textureGatherOffset(my_sampler, vec2(p.x, p.y), p.z, ivec2(int(p.w)));",
        ..depth_2d_rect()
    }
}

fn offsets_float_2d() -> Spec {
    Spec {
        buffer_data: v4(18. / 32., 8. / 32., 0., 0.),
        body: offsets_body!("return textureGatherOffsets(my_sampler, vec2(p.x, p.y), offsets);"),
        ..offset_float_2d()
    }
}

fn offsets_unorm_2d() -> Spec {
    Spec {
        buffer_data: v4(18. / 32., 8. / 32., 0., 0.),
        body: offsets_body!("return textureGatherOffsets(my_sampler, vec2(p.x, p.y), offsets);"),
        ..offset_unorm_2d()
    }
}

fn offsets_int_2d() -> Spec {
    Spec {
        buffer_data: v4(18. / 32., 8. / 32., 0., 0.),
        body: offsets_body!("return textureGatherOffsets(my_sampler, vec2(p.x, p.y), offsets);"),
        ..offset_int_2d()
    }
}

fn offsets_uint_2d() -> Spec {
    Spec {
        buffer_data: v4(18. / 32., 8. / 32., 2., 2.),
        body: offsets_body!("return textureGatherOffsets(my_sampler, vec2(p.x, p.y), offsets, 2);"),
        ..offset_uint_2d()
    }
}

fn offsets_depth_2d() -> Spec {
    Spec {
        buffer_data: v4(18. / 32., 8. / 32., f(0.49f32), 0.),
        body: offsets_body!("return textureGatherOffsets(my_sampler, vec2(p.x, p.y), p.z, offsets);"),
        verify: Verify::Float(expected_depth_low()),
        ..offset_depth_2d()
    }
}

fn offsets_float_2d_array() -> Spec {
    Spec {
        init: Init::Texture2DArray {
            slices: 3,
            data_slice: 1,
        },
        buffer_data: v4(18. / 32., 8. / 32., 1., 0.),
        body: offsets_body!("return textureGatherOffsets(my_sampler, vec3(p.x, p.y, p.z), offsets);"),
        ..float_2d_array()
    }
}

fn offsets_unorm_2d_array() -> Spec {
    Spec {
        init: Init::Texture2DArray {
            slices: 3,
            data_slice: 1,
        },
        buffer_data: v4(18. / 32., 8. / 32., 1., 0.),
        body: offsets_body!("return textureGatherOffsets(my_sampler, vec3(p.x, p.y, p.z), offsets);"),
        ..unorm_2d_array()
    }
}

fn offsets_int_2d_array() -> Spec {
    Spec {
        init: Init::Texture2DArrayInt {
            slices: 3,
            data_slice: 1,
        },
        buffer_data: v4(18. / 32., 8. / 32., 1., 0.),
        body: offsets_body!("return textureGatherOffsets(my_sampler, vec3(p.x, p.y, p.z), offsets, 3);"),
        ..int_2d_array()
    }
}

fn offsets_uint_2d_array() -> Spec {
    Spec {
        init: Init::Texture2DArrayInt {
            slices: 3,
            data_slice: 1,
        },
        buffer_data: v4(18. / 32., 8. / 32., 1., 0.),
        body: offsets_body!("return textureGatherOffsets(my_sampler, vec3(p.x, p.y, p.z), offsets);"),
        ..uint_2d_array()
    }
}

fn offsets_depth_2d_array() -> Spec {
    Spec {
        init: Init::Texture2DArray {
            slices: 3,
            data_slice: 1,
        },
        buffer_data: v4(18. / 32., 8. / 32., 1., f(0.49f32)),
        body: offsets_body!("return textureGatherOffsets(my_sampler, vec3(p.x, p.y, p.z), p.w, offsets);"),
        verify: Verify::Float(expected_depth_low()),
        ..depth_2d_array()
    }
}

fn offsets_float_2d_rect() -> Spec {
    Spec {
        buffer_data: v4(18., 8., 0., 0.),
        body: offsets_body!("return textureGatherOffsets(my_sampler, vec2(p.x, p.y), offsets, 1);"),
        ..float_2d_rect()
    }
}

fn offsets_unorm_2d_rect() -> Spec {
    Spec {
        buffer_data: v4(18., 8., 0., 0.),
        body: offsets_body!("return textureGatherOffsets(my_sampler, vec2(p.x, p.y), offsets);"),
        ..unorm_2d_rect()
    }
}

/// `OffsetsGatherInt2DRect` derives from `PlainGatherUint2DRect`.
fn offsets_int_2d_rect() -> Spec {
    Spec {
        buffer_data: v4(f(17.9f32), f(7.9f32), 0., 0.),
        body: offsets_body!("return textureGatherOffsets(my_sampler, vec2(p.x, p.y), offsets);"),
        ..uint_2d_rect()
    }
}

fn offsets_uint_2d_rect() -> Spec {
    Spec {
        buffer_data: v4(f(17.9f32), f(7.9f32), 0., 0.),
        body: offsets_body!("return textureGatherOffsets(my_sampler, vec2(p.x, p.y), offsets);"),
        ..uint_2d_rect()
    }
}

fn offsets_depth_2d_rect() -> Spec {
    Spec {
        buffer_data: v4(f(17.9f32), f(7.9f32), f(0.49f32), 0.),
        body: offsets_body!("return textureGatherOffsets(my_sampler, vec2(p.x, p.y), p.z, offsets);"),
        verify: Verify::Float(expected_depth_low()),
        ..depth_2d_rect()
    }
}

fn swizzle() -> Spec {
    Spec {
        body: "return textureGather(my_sampler, vec2(p.x, p.y), 1).yzww;",
        verify: Verify::Float(v4(5. / 16., 9. / 16., 13. / 16., 13. / 16.)),
        ..base()
    }
}

fn base_level() -> Spec {
    Spec {
        init: Init::Texture2D {
            rect: false,
            base_level: true,
        },
        ..base()
    }
}

fn incomplete_texture() -> Spec {
    Spec {
        init: Init::Incomplete,
        verify: Verify::Float([0.0; 4]),
        ..base()
    }
}

fn incomplete_texture_last_comp() -> Spec {
    Spec {
        init: Init::Incomplete,
        verify: Verify::Float([1.0; 4]),
        body: "return textureGather(my_sampler, vec2(p.x, p.y), 3);",
        ..base()
    }
}

fn float_2d_srgb() -> Spec {
    Spec {
        verify: Verify::Float(v4(0., f(0.0512695f32), f(0.21582f32), f(0.519531f32))),
        internal_format: glw::GL_SRGB8_ALPHA8,
        ..base()
    }
}

fn float_2d_srgb_alpha() -> Spec {
    Spec {
        body: "return textureGather(my_sampler, vec2(p.x, p.y), 3);",
        verify: Verify::Float(v4(3. / 16., 7. / 16., 11. / 16., 15. / 16.)),
        internal_format: glw::GL_SRGB8_ALPHA8,
        ..base()
    }
}

fn float_2d_components(components: usize) -> Spec {
    Spec {
        init: Init::Texture2DComponents(components),
        ..base()
    }
}

fn offset_float_2d_components(components: usize) -> Spec {
    Spec {
        init: Init::Texture2DComponents(components),
        ..offset_float_2d()
    }
}

/// `TGBase`: the per-case GL names the cleanup deletes.
#[derive(Default)]
struct Names {
    tex: GLuint,
    fbo: GLuint,
    rbo: GLuint,
    program: GLuint,
    vao: GLuint,
    vbo: GLuint,
}

impl Names {
    /// `GatherBase::Cleanup`
    fn cleanup(&self, context: &Context) {
        let gl = context.gl();
        let render_target = context.render_target();
        gl!(gl.viewport(0, 0, render_target.width, render_target.height));
        gl!(gl.disable_vertex_attrib_array(0));
        gl!(gl.delete_textures(1, &self.tex));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.vbo));
        gl!(gl.delete_renderbuffers(1, &self.rbo));
        gl!(gl.delete_framebuffers(1, &self.fbo));
        gl!(gl.delete_program(self.program));
    }
}

/// `TGBase::g_color_eps`
fn color_eps(context: &Context) -> Vec4 {
    let render_target = context.render_target();
    [
        1.0 / (1u32 << render_target.red_bits.min(8)) as f32,
        1.0 / (1u32 << render_target.green_bits.min(8)) as f32,
        1.0 / (1u32 << render_target.blue_bits.min(8)) as f32,
        1.0 / (1u32 << render_target.alpha_bits) as f32,
    ]
}

/// `TGBase::ColorEqual`
fn color_equal(c0: &Vec4, c1: &Vec4, epsilon: &Vec4) -> bool {
    (0..4).all(|i| (c0[i] - c1[i]).abs() <= epsilon[i])
}

/// `TGBase::CreateProgram`: each stage that has a source is compiled and attached; nothing is linked.
fn create_program(
    gl: &glw::Functions,
    vs: Option<&str>,
    tcs: Option<&str>,
    tes: Option<&str>,
    gs: Option<&str>,
    fs: Option<&str>,
) -> GLuint {
    let program = gl!(gl.create_program());
    for (shader_type, source) in [
        (glw::GL_VERTEX_SHADER, vs),
        (glw::GL_TESS_CONTROL_SHADER, tcs),
        (glw::GL_TESS_EVALUATION_SHADER, tes),
        (glw::GL_GEOMETRY_SHADER, gs),
        (glw::GL_FRAGMENT_SHADER, fs),
    ] {
        if let Some(source) = source {
            attach_shader(gl, program, shader_type, source);
        }
    }
    program
}

fn attach_shader(gl: &glw::Functions, program: GLuint, shader_type: GLenum, source: &str) {
    let shader = gl!(gl.create_shader(shader_type));
    gl!(gl.attach_shader(program, shader));
    gl!(gl.delete_shader(shader));
    let pointer = source.as_ptr().cast::<glw::GLchar>();
    let length = source.len() as GLint;
    gl!(gl.shader_source(shader, 1, &pointer, &length));
    gl!(gl.compile_shader(shader));
}

/// `TGBase::CreateComputeProgram`
fn create_compute_program(gl: &glw::Functions, source: &str) -> GLuint {
    let program = gl!(gl.create_program());
    if !source.is_empty() {
        attach_shader(gl, program, glw::GL_COMPUTE_SHADER, source);
    }
    program
}

/// `TGBase::CheckProgram`; the compile status of each shader is implied by the link status.
fn check_program(gl: &glw::Functions, program: GLuint) -> bool {
    let mut status: GLint = 0;
    gl!(gl.get_programiv(program, glw::GL_LINK_STATUS, &mut status));
    if status == glw::GL_FALSE as GLint {
        let mut length: GLint = 0;
        gl!(gl.get_programiv(program, glw::GL_INFO_LOG_LENGTH, &mut length));
        if length > 0 {
            let mut info_log = vec![0u8; length as usize];
            gl!(gl.get_program_info_log(program, length, std::ptr::null_mut(), info_log.as_mut_ptr().cast()));
            log::info!("{}", String::from_utf8_lossy(&info_log));
        }
    }
    status == glw::GL_TRUE as GLint
}

/// The five `glTexSubImage*` calls every `Create*` function ends with; `first` is the data of the 2x2 update and `data` the one of the four 1x1 updates (`data + k`).
fn put_texels(first: *const u8, data: *const u8, element_size: usize, put: &dyn Fn(i32, i32, i32, i32, *const u8)) {
    put(22, 25, 2, 2, first);
    for (k, (x, y)) in [(16, 10), (11, 2), (24, 13), (9, 14)].into_iter().enumerate() {
        put(x, y, 1, 1, data.wrapping_add(k * element_size));
    }
}

fn wrap_clamp_to_edge(gl: &glw::Functions, target: GLenum) {
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as GLint));
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as GLint));
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_R, glw::GL_CLAMP_TO_EDGE as GLint));
}

fn filter_nearest(gl: &glw::Functions, target: GLenum) {
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
}

/// The `for (int i = 0; size > 0; ++i, size /= 2)` loops over the mip chain.
fn mip_sizes(csize: i32) -> impl Iterator<Item = (i32, i32)> {
    let mut size = csize;
    let mut level = 0;
    std::iter::from_fn(move || {
        if size <= 0 {
            return None;
        }
        let item = (level, size);
        level += 1;
        size /= 2;
        Some(item)
    })
}

impl Spec {
    /// `GatherBase::TestFunction` (`Sampler()` + `TextBody()`)
    fn test_function(&self) -> String {
        [
            self.sampler,
            "\n",
            self.type_name,
            " test_function(vec4 p) {\n    ",
            self.body,
            "\n}\n",
        ]
        .concat()
    }

    fn fallthrough_vertex_shader() -> &'static str {
        "#version 400\nin vec4 v_in_0;\nflat out vec4 v_out_0;\nvoid main() {\n    gl_Position = vec4(0,0,0,1);\n    v_out_0 = v_in_0;\n}"
    }

    fn fallthrough_fragment_shader(&self) -> String {
        [
            "#version 400\nout ",
            self.type_name,
            " f_out_0;\nflat in ",
            self.type_name,
            " v_out_0;\nvoid main() {\n    f_out_0 = v_out_0;\n}",
        ]
        .concat()
    }

    fn vertex_shader(&self) -> String {
        [
            "#version 400\n#extension GL_ARB_texture_cube_map_array : enable\n\nin vec4 v_in_0;\nflat out ",
            self.type_name,
            " v_out_0;\n",
            &self.test_function(),
            "void main() {\n    gl_Position = vec4(0,0,0,1);\n    v_out_0 = test_function(v_in_0);\n}",
        ]
        .concat()
    }

    fn fragment_shader(&self) -> String {
        [
            "#version 400\n#extension GL_ARB_texture_cube_map_array : enable\n\nflat in vec4 v_out_0;\nout ",
            self.type_name,
            " f_out_0;\n",
            &self.test_function(),
            "void main() {\n    f_out_0 = test_function(v_out_0);\n}",
        ]
        .concat()
    }

    fn compute_shader(&self) -> String {
        [
            "#version 420 core\n#extension GL_ARB_shader_storage_buffer_object : require\n#extension GL_ARB_compute_shader : require\n#extension GL_ARB_texture_cube_map_array : enable\nlayout(local_size_x = 1, local_size_y = 1) in;\nlayout(std430) buffer Output {\n  ",
            self.type_name,
            " data;\n} g_out;\nuniform vec4 cs_in;\n",
            &self.test_function(),
            "void main() {\n  g_out.data = test_function(cs_in);\n}\n",
        ]
        .concat()
    }

    fn is_depth(&self) -> bool {
        self.format == glw::GL_DEPTH_COMPONENT
    }

    /// `GatherBase::CreateTexture2D`
    fn create_texture_2d(&self, gl: &glw::Functions, names: &mut Names, rect: bool, base_level: bool) {
        let csize = if base_level { 64 } else { 32 };
        let target = if rect {
            glw::GL_TEXTURE_RECTANGLE
        } else {
            glw::GL_TEXTURE_2D
        };

        gl!(gl.gen_textures(1, &mut names.tex));
        gl!(gl.bind_texture(target, names.tex));
        if !rect {
            for (level, size) in mip_sizes(csize) {
                gl!(gl.tex_image_2d(
                    target,
                    level,
                    self.internal_format as GLint,
                    size,
                    size,
                    0,
                    self.format,
                    glw::GL_FLOAT,
                    std::ptr::null()
                ));
            }
        } else {
            gl!(gl.tex_image_2d(
                target,
                0,
                self.internal_format as GLint,
                csize,
                csize,
                0,
                self.format,
                glw::GL_FLOAT,
                std::ptr::null()
            ));
        }
        let pixels = vec![[1.0f32; 4]; (csize * csize) as usize];
        gl!(gl.tex_sub_image_2d(
            target,
            0,
            0,
            0,
            csize,
            csize,
            self.format,
            glw::GL_FLOAT,
            pixels.as_ptr().cast()
        ));

        if !rect && !self.is_depth() {
            gl!(gl.generate_mipmap(target));
        }

        let data = DATA.as_ptr().cast::<u8>();
        put_texels(data, data, 16, &|x, y, w, h, texels| {
            gl!(gl.tex_sub_image_2d(
                target,
                base_level as GLint,
                x,
                y,
                w,
                h,
                self.format,
                glw::GL_FLOAT,
                texels.cast()
            ));
        });

        wrap_clamp_to_edge(gl, target);

        if base_level {
            gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_BASE_LEVEL, 1));
        }
    }

    /// `GatherBase::CreateTexture2DRgb`, `CreateTexture2DRg` and `CreateTexture2DR`
    fn create_texture_2d_components(&self, gl: &glw::Functions, names: &mut Names, components: usize) {
        let (internal_format, format) = match components {
            3 => (glw::GL_RGB32F, glw::GL_RGB),
            2 => (glw::GL_RG32F, glw::GL_RG),
            _ => (glw::GL_R32F, glw::GL_RED),
        };
        let csize = 32;
        let target = glw::GL_TEXTURE_2D;

        gl!(gl.gen_textures(1, &mut names.tex));
        gl!(gl.bind_texture(target, names.tex));
        for (level, size) in mip_sizes(csize) {
            gl!(gl.tex_image_2d(
                target,
                level,
                internal_format as GLint,
                size,
                size,
                0,
                format,
                glw::GL_FLOAT,
                std::ptr::null()
            ));
        }
        let pixels = vec![1.0f32; (csize * csize) as usize * components];
        gl!(gl.tex_sub_image_2d(
            target,
            0,
            0,
            0,
            csize,
            csize,
            format,
            glw::GL_FLOAT,
            pixels.as_ptr().cast()
        ));
        gl!(gl.generate_mipmap(target));

        let data: Vec<f32> = DATA
            .iter()
            .flat_map(|texel| texel[..components].iter().copied())
            .collect();
        let data = data.as_ptr().cast::<u8>();
        put_texels(data, data, components * 4, &|x, y, w, h, texels| {
            gl!(gl.tex_sub_image_2d(target, 0, x, y, w, h, format, glw::GL_FLOAT, texels.cast()));
        });

        wrap_clamp_to_edge(gl, target);
    }

    /// `GatherBase::CreateTexture2DInt`
    fn create_texture_2d_int(&self, gl: &glw::Functions, names: &mut Names, rect: bool) {
        let csize = 32;
        let target = if rect {
            glw::GL_TEXTURE_RECTANGLE
        } else {
            glw::GL_TEXTURE_2D
        };

        gl!(gl.gen_textures(1, &mut names.tex));
        gl!(gl.bind_texture(target, names.tex));
        if !rect {
            for (level, size) in mip_sizes(csize) {
                gl!(gl.tex_image_2d(
                    target,
                    level,
                    self.internal_format as GLint,
                    size,
                    size,
                    0,
                    glw::GL_RGBA_INTEGER,
                    glw::GL_INT,
                    std::ptr::null()
                ));
            }
        } else {
            gl!(gl.tex_image_2d(
                target,
                0,
                self.internal_format as GLint,
                csize,
                csize,
                0,
                glw::GL_RGBA_INTEGER,
                glw::GL_INT,
                std::ptr::null()
            ));
        }
        let pixels = vec![[999i32; 4]; (csize * csize) as usize];
        gl!(gl.tex_sub_image_2d(
            target,
            0,
            0,
            0,
            csize,
            csize,
            glw::GL_RGBA_INTEGER,
            glw::GL_INT,
            pixels.as_ptr().cast()
        ));

        let data = DATA_INT.as_ptr().cast::<u8>();
        put_texels(data, data, 16, &|x, y, w, h, texels| {
            gl!(gl.tex_sub_image_2d(target, 0, x, y, w, h, glw::GL_RGBA_INTEGER, glw::GL_INT, texels.cast()));
        });

        wrap_clamp_to_edge(gl, target);
        filter_nearest(gl, target);
    }

    /// `GatherBase::CreateTexture2DArray`
    fn create_texture_2d_array(&self, gl: &glw::Functions, names: &mut Names, slices: i32, data_slice: i32) {
        let csize = 32;
        let target = glw::GL_TEXTURE_2D_ARRAY;

        gl!(gl.gen_textures(1, &mut names.tex));
        gl!(gl.bind_texture(target, names.tex));
        for (level, size) in mip_sizes(csize) {
            gl!(gl.tex_image_3d(
                target,
                level,
                self.internal_format as GLint,
                size,
                size,
                slices,
                0,
                self.format,
                glw::GL_FLOAT,
                std::ptr::null()
            ));
        }
        let pixels = vec![[1.0f32; 4]; (csize * csize) as usize];
        for i in 0..slices {
            gl!(gl.tex_sub_image_3d(
                target,
                0,
                0,
                0,
                i,
                csize,
                csize,
                1,
                self.format,
                glw::GL_FLOAT,
                pixels.as_ptr().cast()
            ));
        }

        if !self.is_depth() {
            gl!(gl.generate_mipmap(target));
        }

        let data = DATA.as_ptr().cast::<u8>();
        put_texels(data, data, 16, &|x, y, w, h, texels| {
            gl!(gl.tex_sub_image_3d(
                target,
                0,
                x,
                y,
                data_slice,
                w,
                h,
                1,
                self.format,
                glw::GL_FLOAT,
                texels.cast()
            ));
        });

        wrap_clamp_to_edge(gl, target);
    }

    /// `GatherBase::CreateTexture2DArrayInt`
    fn create_texture_2d_array_int(&self, gl: &glw::Functions, names: &mut Names, slices: i32, data_slice: i32) {
        let csize = 32;
        let target = glw::GL_TEXTURE_2D_ARRAY;

        gl!(gl.gen_textures(1, &mut names.tex));
        gl!(gl.bind_texture(target, names.tex));
        for (level, size) in mip_sizes(csize) {
            gl!(gl.tex_image_3d(
                target,
                level,
                self.internal_format as GLint,
                size,
                size,
                slices,
                0,
                glw::GL_RGBA_INTEGER,
                glw::GL_INT,
                std::ptr::null()
            ));
        }
        let pixels = vec![[999i32; 4]; (csize * csize) as usize];
        for i in 0..slices {
            gl!(gl.tex_sub_image_3d(
                target,
                0,
                0,
                0,
                i,
                csize,
                csize,
                1,
                glw::GL_RGBA_INTEGER,
                glw::GL_INT,
                pixels.as_ptr().cast()
            ));
        }

        let data = DATA_INT.as_ptr().cast::<u8>();
        put_texels(data, data, 16, &|x, y, w, h, texels| {
            gl!(gl.tex_sub_image_3d(
                target,
                0,
                x,
                y,
                data_slice,
                w,
                h,
                1,
                glw::GL_RGBA_INTEGER,
                glw::GL_INT,
                texels.cast()
            ));
        });

        wrap_clamp_to_edge(gl, target);
        filter_nearest(gl, target);
    }

    /// `GatherBase::CreateTextureCube`
    fn create_texture_cube(&self, gl: &glw::Functions, names: &mut Names) {
        let csize = 32;
        let target = glw::GL_TEXTURE_CUBE_MAP;

        gl!(gl.gen_textures(1, &mut names.tex));
        gl!(gl.bind_texture(target, names.tex));
        for (level, size) in mip_sizes(csize) {
            for face in FACES {
                gl!(gl.tex_image_2d(
                    face,
                    level,
                    self.internal_format as GLint,
                    size,
                    size,
                    0,
                    self.format,
                    glw::GL_FLOAT,
                    std::ptr::null()
                ));
            }
        }
        let pixels = vec![[1.0f32; 4]; (csize * csize) as usize];
        for face in FACES {
            gl!(gl.tex_sub_image_2d(
                face,
                0,
                0,
                0,
                csize,
                csize,
                self.format,
                glw::GL_FLOAT,
                pixels.as_ptr().cast()
            ));
        }

        if !self.is_depth() {
            gl!(gl.generate_mipmap(target));
        }

        let depth_data: Vec4 = [DATA[0][0], DATA[1][0], DATA[2][0], DATA[3][0]];
        let packed = if self.is_depth() {
            depth_data.as_ptr().cast::<u8>()
        } else {
            DATA.as_ptr().cast::<u8>()
        };
        for face in FACES {
            put_texels(packed, DATA.as_ptr().cast(), 16, &|x, y, w, h, texels| {
                gl!(gl.tex_sub_image_2d(face, 0, x, y, w, h, self.format, glw::GL_FLOAT, texels.cast()));
            });
        }

        wrap_clamp_to_edge(gl, target);
    }

    /// `GatherBase::CreateTextureCubeInt`
    fn create_texture_cube_int(&self, gl: &glw::Functions, names: &mut Names) {
        let csize = 32;
        let target = glw::GL_TEXTURE_CUBE_MAP;

        gl!(gl.gen_textures(1, &mut names.tex));
        gl!(gl.bind_texture(target, names.tex));
        for (level, size) in mip_sizes(csize) {
            for face in FACES {
                gl!(gl.tex_image_2d(
                    face,
                    level,
                    self.internal_format as GLint,
                    size,
                    size,
                    0,
                    glw::GL_RGBA_INTEGER,
                    glw::GL_INT,
                    std::ptr::null()
                ));
            }
        }
        let pixels = vec![[999i32; 4]; (csize * csize) as usize];
        for face in FACES {
            gl!(gl.tex_sub_image_2d(
                face,
                0,
                0,
                0,
                csize,
                csize,
                glw::GL_RGBA_INTEGER,
                glw::GL_INT,
                pixels.as_ptr().cast()
            ));
        }

        let data = DATA_INT.as_ptr().cast::<u8>();
        for face in FACES {
            put_texels(data, data, 16, &|x, y, w, h, texels| {
                gl!(gl.tex_sub_image_2d(face, 0, x, y, w, h, glw::GL_RGBA_INTEGER, glw::GL_INT, texels.cast()));
            });
        }

        wrap_clamp_to_edge(gl, target);
        filter_nearest(gl, target);
    }

    /// `GatherBase::CreateTextureCubeArray`; the wrap parameters go to `GL_TEXTURE_CUBE_MAP`, as upstream has them.
    fn create_texture_cube_array(&self, gl: &glw::Functions, names: &mut Names, slices: i32, data_slice: i32) {
        let csize = 32;
        let target = glw::GL_TEXTURE_CUBE_MAP_ARRAY;

        gl!(gl.gen_textures(1, &mut names.tex));
        gl!(gl.bind_texture(target, names.tex));
        for (level, size) in mip_sizes(csize) {
            gl!(gl.tex_image_3d(
                target,
                level,
                self.internal_format as GLint,
                size,
                size,
                6 * slices,
                0,
                self.format,
                glw::GL_FLOAT,
                std::ptr::null()
            ));
        }
        let pixels = vec![[1.0f32; 4]; (csize * csize) as usize];
        for j in 0..6 * slices {
            gl!(gl.tex_sub_image_3d(
                target,
                0,
                0,
                0,
                j,
                csize,
                csize,
                1,
                self.format,
                glw::GL_FLOAT,
                pixels.as_ptr().cast()
            ));
        }

        if !self.is_depth() {
            gl!(gl.generate_mipmap(target));
        }

        let depth_data: Vec4 = [DATA[0][0], DATA[1][0], DATA[2][0], DATA[3][0]];
        let packed = if self.is_depth() {
            depth_data.as_ptr().cast::<u8>()
        } else {
            DATA.as_ptr().cast::<u8>()
        };
        for i in 0..6 {
            put_texels(packed, DATA.as_ptr().cast(), 16, &|x, y, w, h, texels| {
                gl!(gl.tex_sub_image_3d(
                    target,
                    0,
                    x,
                    y,
                    6 * data_slice + i,
                    w,
                    h,
                    1,
                    self.format,
                    glw::GL_FLOAT,
                    texels.cast()
                ));
            });
        }

        wrap_clamp_to_edge(gl, glw::GL_TEXTURE_CUBE_MAP);
    }

    /// `GatherBase::CreateTextureCubeArrayInt`
    fn create_texture_cube_array_int(&self, gl: &glw::Functions, names: &mut Names, slices: i32, data_slice: i32) {
        let csize = 32;
        let target = glw::GL_TEXTURE_CUBE_MAP_ARRAY;

        gl!(gl.gen_textures(1, &mut names.tex));
        gl!(gl.bind_texture(target, names.tex));
        for (level, size) in mip_sizes(csize) {
            gl!(gl.tex_image_3d(
                target,
                level,
                self.internal_format as GLint,
                size,
                size,
                6 * slices,
                0,
                glw::GL_RGBA_INTEGER,
                glw::GL_INT,
                std::ptr::null()
            ));
        }
        let pixels = vec![[999i32; 4]; (csize * csize) as usize];
        for j in 0..6 * slices {
            gl!(gl.tex_sub_image_3d(
                target,
                0,
                0,
                0,
                j,
                csize,
                csize,
                1,
                glw::GL_RGBA_INTEGER,
                glw::GL_INT,
                pixels.as_ptr().cast()
            ));
        }

        let data = DATA_INT.as_ptr().cast::<u8>();
        for i in 0..6 {
            put_texels(data, data, 16, &|x, y, w, h, texels| {
                gl!(gl.tex_sub_image_3d(
                    target,
                    0,
                    x,
                    y,
                    6 * data_slice + i,
                    w,
                    h,
                    1,
                    glw::GL_RGBA_INTEGER,
                    glw::GL_INT,
                    texels.cast()
                ));
            });
        }

        wrap_clamp_to_edge(gl, target);
        filter_nearest(gl, target);
    }

    /// `GatherBase::Init`
    fn init(&self, gl: &glw::Functions, names: &mut Names) {
        match self.init {
            Init::Texture2D { rect, base_level } => self.create_texture_2d(gl, names, rect, base_level),
            Init::Texture2DInt { rect } => self.create_texture_2d_int(gl, names, rect),
            Init::Texture2DArray { slices, data_slice } => self.create_texture_2d_array(gl, names, slices, data_slice),
            Init::Texture2DArrayInt { slices, data_slice } => {
                self.create_texture_2d_array_int(gl, names, slices, data_slice)
            }
            Init::TextureCube => self.create_texture_cube(gl, names),
            Init::TextureCubeInt => self.create_texture_cube_int(gl, names),
            Init::TextureCubeArray { slices, data_slice } => {
                self.create_texture_cube_array(gl, names, slices, data_slice)
            }
            Init::TextureCubeArrayInt { slices, data_slice } => {
                self.create_texture_cube_array_int(gl, names, slices, data_slice)
            }
            Init::Texture2DComponents(components) => self.create_texture_2d_components(gl, names, components),
            Init::Incomplete => {
                self.create_texture_2d(gl, names, false, false);
                gl!(gl.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    1,
                    glw::GL_RGBA32F as GLint,
                    1,
                    1,
                    0,
                    glw::GL_RGBA,
                    glw::GL_FLOAT,
                    std::ptr::null()
                ));
            }
        }
        if let Some(target) = self.compare_target {
            gl!(gl.tex_parameteri(
                target,
                glw::GL_TEXTURE_COMPARE_MODE,
                glw::GL_COMPARE_REF_TO_TEXTURE as GLint
            ));
        }
    }

    /// `GatherBase::Supported`
    fn supported(&self, context: &Context) -> bool {
        if self.needs_cube_map_array
            && !context
                .context_info
                .is_extension_supported("GL_ARB_texture_cube_map_array")
        {
            output_not_supported("GL_ARB_texture_cube_map_array not supported");
            return false;
        }
        true
    }

    /// `GatherBase::Verify`
    fn verify(&self, context: &Context) -> bool {
        let gl = context.gl();
        match self.verify {
            Verify::Float(expected) => {
                let mut data: Vec4 = [0.0; 4];
                gl!(gl.read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_FLOAT, data.as_mut_ptr().cast()));
                let eps = color_eps(context);
                if !color_equal(&data, &expected, &eps) {
                    log::info!(
                        "Expected {}, {}, {}, {}, got: {}, {}, {}, {}, epsilon: {}, {}, {}, {}",
                        expected[0],
                        expected[1],
                        expected[2],
                        expected[3],
                        data[0],
                        data[1],
                        data[2],
                        data[3],
                        eps[0],
                        eps[1],
                        eps[2],
                        eps[3]
                    );
                    return false;
                }
                true
            }
            Verify::Int { expected, read_type } => {
                let mut data = [0i32; 4];
                gl!(gl.read_pixels(0, 0, 1, 1, glw::GL_RGBA_INTEGER, read_type, data.as_mut_ptr().cast()));
                if data != expected {
                    log::info!(
                        "Expected {}, {}, {}, {}, got: {}, {}, {}, {}",
                        expected[0],
                        expected[1],
                        expected[2],
                        expected[3],
                        data[0],
                        data[1],
                        data[2],
                        data[3]
                    );
                    return false;
                }
                true
            }
        }
    }

    /// `GatherBase::VerifyCompute`
    fn verify_compute(&self, context: &Context) -> bool {
        let gl = context.gl();
        let mapped = gl!(gl.map_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, 0, 16, glw::GL_MAP_READ_BIT));
        if mapped.is_null() {
            log::info!("glMapBufferRange returned NULL");
            return false;
        }
        match self.verify {
            Verify::Float(expected) => {
                // SAFETY: the mapping covers the 16 bytes of one vec4.
                let data = unsafe { *mapped.cast::<Vec4>() };
                if !color_equal(&data, &expected, &color_eps(context)) {
                    log::info!(
                        "Expected {}, {}, {}, {} got: {}, {}, {}, {}",
                        expected[0],
                        expected[1],
                        expected[2],
                        expected[3],
                        data[0],
                        data[1],
                        data[2],
                        data[3]
                    );
                    return false;
                }
                true
            }
            Verify::Int { expected, .. } => {
                // SAFETY: the mapping covers the 16 bytes of one ivec4.
                let data = unsafe { *mapped.cast::<[i32; 4]>() };
                if data != expected {
                    log::info!(
                        "Expected {}, {}, {}, {}, got: {}, {}, {}, {}",
                        expected[0],
                        expected[1],
                        expected[2],
                        expected[3],
                        data[0],
                        data[1],
                        data[2],
                        data[3]
                    );
                    return false;
                }
                true
            }
        }
    }

    /// `GatherBase::TestCompute`
    fn test_compute(&self, context: &Context, names: &mut Names) -> SubcaseResult {
        let gl = context.gl();

        names.program = create_compute_program(gl, &self.compute_shader());
        gl!(gl.link_program(names.program));
        if !check_program(gl, names.program) {
            return Ok(ERROR);
        }
        gl!(gl.use_program(names.program));

        let location = gl!(gl.get_uniform_location(names.program, c"cs_in".as_ptr()));
        gl!(gl.uniform_4f(
            location,
            self.buffer_data[0],
            self.buffer_data[1],
            self.buffer_data[2],
            self.buffer_data[3]
        ));

        let mut buffer: GLuint = 0;
        gl!(gl.gen_buffers(1, &mut buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            16,
            std::ptr::null(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));

        gl!(gl.dispatch_compute(1, 1, 1));

        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        let ok = self.verify_compute(context);
        gl!(gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER));
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));
        gl!(gl.delete_buffers(1, &buffer));

        Ok(if ok { NO_ERROR } else { ERROR })
    }

    /// `GatherBase::Run` up to the vertex buffer: the framebuffer, `SetRbo`, the vertex array and the buffer data. `Init` runs before it.
    fn prepare(&self, context: &Context, names: &mut Names) {
        let gl = context.gl();
        self.init(gl, names);

        gl!(gl.gen_framebuffers(1, &mut names.fbo));
        gl!(gl.gen_renderbuffers(1, &mut names.rbo));
        gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, names.rbo));
        gl!(gl.renderbuffer_storage(glw::GL_RENDERBUFFER, self.rbo_format, 1, 1));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.fbo));
        gl!(gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            names.rbo
        ));
        let draw_buffer = glw::GL_COLOR_ATTACHMENT0;
        gl!(gl.draw_buffers(1, &draw_buffer));
        let colorf = [0.0f32; 4];
        gl!(gl.clear_bufferfv(glw::GL_COLOR, 0, colorf.as_ptr()));
        gl!(gl.viewport(0, 0, 1, 1));

        gl!(gl.gen_vertex_arrays(1, &mut names.vao));
        gl!(gl.bind_vertex_array(names.vao));
        gl!(gl.gen_buffers(1, &mut names.vbo));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, names.vbo));
        gl!(gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null()));
        gl!(gl.enable_vertex_attrib_array(0));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            16,
            self.buffer_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
    }

    fn link_with_locations(gl: &glw::Functions, program: GLuint) -> bool {
        gl!(gl.bind_attrib_location(program, 0, c"v_in_0".as_ptr()));
        gl!(gl.bind_frag_data_location(program, 0, c"f_out_0".as_ptr()));
        gl!(gl.link_program(program));
        check_program(gl, program)
    }
}

/// `GatherBase` and every subclass of it that only overrides what `Spec` holds
struct GatherCase {
    spec: Spec,
    names: Names,
}

impl Subcase for GatherCase {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let spec = &self.spec;
        if !spec.supported(context) {
            return Ok(NO_ERROR);
        }
        spec.prepare(context, &mut self.names);

        for i in 0..2 {
            self.names.program = if i == 0 {
                create_program(
                    gl,
                    Some(&spec.vertex_shader()),
                    None,
                    None,
                    None,
                    Some(&spec.fallthrough_fragment_shader()),
                )
            } else {
                create_program(
                    gl,
                    Some(Spec::fallthrough_vertex_shader()),
                    None,
                    None,
                    None,
                    Some(&spec.fragment_shader()),
                )
            };
            if !Spec::link_with_locations(gl, self.names.program) {
                return Ok(ERROR);
            }
            gl!(gl.use_program(self.names.program));

            gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
            gl!(gl.read_buffer(glw::GL_COLOR_ATTACHMENT0));

            gl!(gl.delete_program(self.names.program));

            if !spec.verify(context) {
                return Ok(ERROR);
            }
        }

        if !context.context_info.is_extension_supported("GL_ARB_compute_shader") {
            log::info!("Expected GL_ARB_compute_shader or GL_ARB_compute_shader not supported, skipping compute stage");
            return Ok(NO_ERROR);
        }
        spec.test_compute(context, &mut self.names)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        self.names.cleanup(context);
        Ok(NO_ERROR)
    }
}

/// `GatherEnumsTest`
struct GatherEnumsTest;

impl Subcase for GatherEnumsTest {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut res: GLint = 0;
        gl!(gl.get_integerv(glw::GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET, &mut res));
        if res > -8 {
            return Ok(ERROR);
        }
        gl!(gl.get_integerv(glw::GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET, &mut res));
        if res < 7 {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }
}

/// `GatherGLSLCompile`
struct GatherGlslCompile {
    program: GLuint,
}

const GLSL_COMPILE_UNIFORMS: &str = "uniform sampler2D tex_2d;                  \nuniform isamplerCube itex_cube;            \nuniform usampler2DArray utex_2da;          \nuniform isampler2DRect itex_2dr;           \nuniform sampler2DRectShadow tex_2drs;      \nuniform sampler2DShadow tex_2ds;           \nuniform samplerCubeShadow tex_cubes;       \nuniform sampler2DArrayShadow tex_2das;     \n";

const GLSL_COMPILE_SAMPLING: &str = "    textureGather(tex_2d,vec2(1));          \n    textureGather(itex_cube,vec3(1));       \n    textureGather(utex_2da,vec3(1));        \n    textureGather(itex_2dr,vec2(1));        \n    textureGather(tex_2drs,vec2(1), 0.5);   \n    textureGather(tex_2ds,vec2(1), 0.5);    \n    textureGather(tex_cubes,vec3(1), 0.5);  \n    textureGather(tex_2das,vec3(1), 0.5);   \n    textureGatherOffset(tex_2d,vec2(1), ivec2(0));          \n    textureGatherOffset(utex_2da,vec3(1), ivec2(0));        \n    textureGatherOffset(itex_2dr,vec2(1), ivec2(0));        \n    textureGatherOffset(tex_2drs,vec2(1), 0.5, ivec2(0));   \n    textureGatherOffset(tex_2ds,vec2(1), 0.5, ivec2(0));    \n    textureGatherOffset(tex_2das,vec3(1), 0.5, ivec2(0));   \n    const ivec2 offsets[4] = ivec2[](ivec2(0), ivec2(0), ivec2(0), ivec2(0)); \n    textureGatherOffsets(tex_2d,vec2(1), offsets);          \n    textureGatherOffsets(utex_2da,vec3(1), offsets);        \n    textureGatherOffsets(itex_2dr,vec2(1), offsets);        \n    textureGatherOffsets(tex_2drs,vec2(1), 0.5, offsets);   \n    textureGatherOffsets(tex_2ds,vec2(1), 0.5, offsets);    \n    textureGatherOffsets(tex_2das,vec3(1), 0.5, offsets);   \n";

impl Subcase for GatherGlslCompile {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let vertex_shader = [
            "#version 400                               \n",
            GLSL_COMPILE_UNIFORMS,
            "  void main() {                            \n",
            GLSL_COMPILE_SAMPLING,
            "    gl_Position = vec4(1);                 \n  }                                        \n",
        ]
        .concat();
        let fragment_shader = [
            "#version 400                               \nout vec4 color;                            \n",
            GLSL_COMPILE_UNIFORMS,
            "  void main() {                            \n",
            GLSL_COMPILE_SAMPLING,
            "    color = vec4(1);                       \n  }                                        \n",
        ]
        .concat();
        self.program = create_program(gl, Some(&vertex_shader), None, None, None, Some(&fragment_shader));
        gl!(gl.link_program(self.program));
        if !check_program(gl, self.program) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().delete_program(self.program));
        Ok(NO_ERROR)
    }
}

/// `TriangleDraw`
struct TriangleDraw {
    names: Names,
}

impl Subcase for TriangleDraw {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let names = &mut self.names;

        gl!(gl.gen_framebuffers(1, &mut names.fbo));
        gl!(gl.gen_renderbuffers(1, &mut names.rbo));
        gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, names.rbo));
        gl!(gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA32F, 100, 100));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, names.fbo));
        gl!(gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            names.rbo
        ));
        let draw_buffer = glw::GL_COLOR_ATTACHMENT0;
        gl!(gl.draw_buffers(1, &draw_buffer));
        let colorf = [0.0f32; 4];
        gl!(gl.clear_bufferfv(glw::GL_COLOR, 0, colorf.as_ptr()));
        gl!(gl.viewport(0, 0, 100, 100));

        let vertex_shader = "#version 400                                  \nout vec2 texcoords;                           \nin vec4 Vertex;                               \nvoid main() {                                 \n   gl_Position = Vertex;                      \n   texcoords = (Vertex.xy + vec2(1.0)) / 2.0; \n}\n";
        let fragment_shader = "#version 400                                      \nin vec2 texcoords;                                \nout vec4 FragColor;                               \nuniform sampler2D tex;                            \nvoid main() {                                     \n   FragColor = textureGather(tex, texcoords, 2);  \n}\n";
        names.program = create_program(gl, Some(vertex_shader), None, None, None, Some(fragment_shader));
        gl!(gl.bind_attrib_location(names.program, 0, c"Vertex".as_ptr()));
        gl!(gl.bind_frag_data_location(names.program, 0, c"FragColor".as_ptr()));
        gl!(gl.link_program(names.program));
        if !check_program(gl, names.program) {
            return Ok(ERROR);
        }
        gl!(gl.use_program(names.program));

        gl!(gl.gen_textures(1, &mut names.tex));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, names.tex));
        let data = vec![[0.25f32, 0.5, 0.75, 1.0]; 100 * 100];
        gl!(gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA32F as GLint,
            100,
            100,
            0,
            glw::GL_RGBA,
            glw::GL_FLOAT,
            data.as_ptr().cast()
        ));
        gl!(gl.tex_parameteri(
            glw::GL_TEXTURE_2D,
            glw::GL_TEXTURE_WRAP_S,
            glw::GL_CLAMP_TO_EDGE as GLint
        ));
        gl!(gl.tex_parameteri(
            glw::GL_TEXTURE_2D,
            glw::GL_TEXTURE_WRAP_T,
            glw::GL_CLAMP_TO_EDGE as GLint
        ));
        gl!(gl.tex_parameteri(
            glw::GL_TEXTURE_2D,
            glw::GL_TEXTURE_WRAP_R,
            glw::GL_CLAMP_TO_EDGE as GLint
        ));
        gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
        gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));

        let mut local_vao: GLuint = 0;
        gl!(gl.gen_vertex_arrays(1, &mut local_vao));
        gl!(gl.bind_vertex_array(local_vao));
        gl!(gl.gen_buffers(1, &mut names.vbo));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, names.vbo));
        let buff_data: [f32; 16] = [-1., 1., 0., 1., -1., -1., 0., 1., 1., 1., 0., 1., 1., -1., 0., 1.];
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(&buff_data) as glw::GLsizeiptr,
            buff_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        gl!(gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, glw::FALSE, 16, std::ptr::null()));
        gl!(gl.enable_vertex_attrib_array(0));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        gl!(gl.disable_vertex_attrib_array(0));
        gl!(gl.delete_vertex_arrays(1, &local_vao));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

        gl!(gl.read_buffer(glw::GL_COLOR_ATTACHMENT0));
        let mut read = vec![[0.0f32; 4]; 100 * 100];
        gl!(gl.read_pixels(0, 0, 100, 100, glw::GL_RGBA, glw::GL_FLOAT, read.as_mut_ptr().cast()));
        for texel in &read {
            if *texel != [0.75; 4] {
                log::info!(
                    "Got: {} {} {} {}, expected vec4(0.25)",
                    texel[0],
                    texel[1],
                    texel[2],
                    texel[3]
                );
                return Ok(ERROR);
            }
        }

        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let render_target = context.render_target();
        gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, 0));
        gl!(gl.viewport(0, 0, render_target.width, render_target.height));
        gl!(gl.delete_textures(1, &self.names.tex));
        gl!(gl.delete_framebuffers(1, &self.names.fbo));
        gl!(gl.delete_renderbuffers(1, &self.names.rbo));
        gl!(gl.delete_vertex_arrays(1, &self.names.vao));
        gl!(gl.delete_buffers(1, &self.names.vbo));
        gl!(gl.delete_program(self.names.program));
        Ok(NO_ERROR)
    }
}

/// `GatherGeometryShader` and `GatherTesselationShader`: `GatherBase` state, one program with the extra stages, the pixel must be green.
#[derive(Clone, Copy)]
enum ExtraStage {
    Geometry,
    Tessellation,
}

struct GatherStageCase {
    stage: ExtraStage,
    spec: Spec,
    names: Names,
}

const GEOMETRY_VERTEX_SHADER: &str = "#version 400                       \nin vec4 v_in_0;                    \nout vec4 d;                        \nvoid main() {                      \n   gl_Position = vec4(0, 0, 0, 1); \n   d = v_in_0;                     \n}";

const GEOMETRY_SHADER: &str = "#version 400                                                  \nlayout(points) in;                                            \nlayout(points, max_vertices = 1) out;                         \nout vec4 col;                                                 \nin vec4 d[1];                                                 \nuniform sampler2D tex;                                        \nvoid main() {                                                 \n   vec4 v1 = textureGather(tex, vec2(d[0].x, d[0].y));                                               \n   vec4 v2 = textureGatherOffset(tex, vec2(d[0].x, d[0].y) - vec2(4./32), ivec2(4));                 \n   const ivec2 offsets[4] = ivec2[](ivec2(7, 6), ivec2(-8, 7), ivec2(-6, -5), ivec2(-1, 3));         \n   vec4 v3 = textureGatherOffsets(tex, vec2(d[0].x, d[0].y) - vec2(5./32, 18./32), offsets);         \n   vec4 expected = vec4(0./16, 4./16, 8./16, 12./16);                                                \n   float error = 0.0;                                         \n   if (v1 != expected)    \n       error += 0.01;     \n   if (v2 != expected)    \n       error += 0.02;     \n   if (v3 != expected)    \n       error += 0.04;     \n   if (error != 0.0)                         \n       col = vec4(v1.x, v2.y, v3.z, d[0].x); \n   else                                      \n       col = vec4(0, 1, 0, 1);               \n   gl_Position = vec4(0, 0, 0, 1);         \n   EmitVertex();                           \n   EndPrimitive();                         \n}";

const GEOMETRY_FRAGMENT_SHADER: &str = "#version 400               \nin vec4 col;               \nout vec4 f_out_0;          \nvoid main() {              \n   f_out_0 = col;          \n}";

const TESSELLATION_CONTROL_SHADER: &str = "#version 400                                                  \nlayout(vertices = 1) out;                                     \nout vec4 ccol[];                                              \nin vec4 d[];                                                  \nout vec4 d_con[];                                             \nuniform sampler2D tex;                                        \nvoid main() {                                        \n   vec4 v1 = textureGather(tex, vec2(d[0].x, d[0].y));                                               \n   vec4 v2 = textureGatherOffset(tex, vec2(d[0].x, d[0].y) - vec2(4./32), ivec2(4));                 \n   const ivec2 offsets[4] = ivec2[](ivec2(7, 6), ivec2(-8, 7), ivec2(-6, -5), ivec2(-1, 3));         \n   vec4 v3 = textureGatherOffsets(tex, vec2(d[0].x, d[0].y) - vec2(5./32, 18./32), offsets);         \n   vec4 expected = vec4(0./16, 4./16, 8./16, 12./16);                                                \n   float error = 0.0;                                         \n   if (v1 != expected)    \n       error += 0.01;     \n   if (v2 != expected)    \n       error += 0.02;     \n   if (v3 != expected)    \n       error += 0.04;     \n   if (error != 0.0)                                            \n       ccol[gl_InvocationID] = vec4(v1.x, v2.y, d[0].x, 1);      \n   else                                                         \n       ccol[gl_InvocationID] = vec4(0, 1, 0, 1);                \n   d_con[gl_InvocationID] = d[gl_InvocationID];                                 \n   gl_out[gl_InvocationID].gl_Position = vec4(0, 0, 0, 1);                      \n   gl_TessLevelInner[0] = 1.0;                                                  \n   gl_TessLevelOuter[0] = 1.0;                                                  \n   gl_TessLevelOuter[1] = 1.0;                                                  \n   gl_TessLevelOuter[2] = 1.0;                                                  \n}";

const TESSELLATION_EVALUATION_SHADER: &str = "#version 400                                                  \nlayout(triangles, point_mode) in;                             \nin vec4 ccol[];                                               \nin vec4 d_con[];                                              \nout vec4 ecol;                                                \nuniform sampler2D tex;                                        \nvoid main() {                                        \n   vec4 v1 = textureGather(tex, vec2(d_con[0].x, d_con[0].y));                                                \n   vec4 v2 = textureGatherOffset(tex, vec2(d_con[0].x, d_con[0].y) - vec2(4./32), ivec2(4));                  \n   const ivec2 offsets[4] = ivec2[](ivec2(7, 6), ivec2(-8, 7), ivec2(-6, -5), ivec2(-1, 3));                  \n   vec4 v3 = textureGatherOffsets(tex, vec2(d_con[0].x, d_con[0].y) - vec2(5./32, 18./32), offsets);          \n   vec4 expected = vec4(0./16, 4./16, 8./16, 12./16);                                                         \n   float error = 0.0;                                         \n   if (v1 != expected)    \n       error += 0.01;     \n   if (v2 != expected)    \n       error += 0.02;     \n   if (v3 != expected)    \n       error += 0.04;     \n   if (error != 0.0)                                          \n       ecol = vec4(v1.x, v2.y, d_con[0].x, -1);                      \n   else if (ccol[0] != vec4(0, 1, 0, 1))     \n       ecol = ccol[0];                       \n   else                                      \n       ecol = vec4(0, 1, 0, 1);              \n   gl_Position = vec4(0, 0, 0, 1);   \n}";

const TESSELLATION_FRAGMENT_SHADER: &str = "#version 400               \nin vec4 ecol;              \nout vec4 f_out_0;          \nvoid main() {              \n   f_out_0 = ecol;         \n}";

impl Subcase for GatherStageCase {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !self.spec.supported(context) {
            return Ok(NO_ERROR);
        }
        self.spec.prepare(context, &mut self.names);

        self.names.program = match self.stage {
            ExtraStage::Geometry => create_program(
                gl,
                Some(GEOMETRY_VERTEX_SHADER),
                None,
                None,
                Some(GEOMETRY_SHADER),
                Some(GEOMETRY_FRAGMENT_SHADER),
            ),
            ExtraStage::Tessellation => create_program(
                gl,
                Some(GEOMETRY_VERTEX_SHADER),
                Some(TESSELLATION_CONTROL_SHADER),
                Some(TESSELLATION_EVALUATION_SHADER),
                None,
                Some(TESSELLATION_FRAGMENT_SHADER),
            ),
        };
        if !Spec::link_with_locations(gl, self.names.program) {
            return Ok(ERROR);
        }
        gl!(gl.use_program(self.names.program));

        match self.stage {
            ExtraStage::Geometry => gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1)),
            ExtraStage::Tessellation => {
                gl!(gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1));
                gl!(gl.draw_arrays(glw::GL_PATCHES, 0, 1));
            }
        }
        gl!(gl.read_buffer(glw::GL_COLOR_ATTACHMENT0));

        gl!(gl.delete_program(self.names.program));
        let mut data: Vec4 = [0.0; 4];
        gl!(gl.read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_FLOAT, data.as_mut_ptr().cast()));
        let eps = color_eps(context);
        if !color_equal(&data, &[0.0, 1.0, 0.0, 1.0], &eps) {
            log::info!(
                "Expected Vec4(0, 1, 0, 1), got: {}, {}, {}, {}, epsilon: {}, {}, {}, {}",
                data[0],
                data[1],
                data[2],
                data[3],
                eps[0],
                eps[1],
                eps[2],
                eps[3]
            );
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        self.names.cleanup(context);
        Ok(NO_ERROR)
    }
}

fn add_gather(group: &mut TestCaseGroup, name: &str, make: fn() -> Spec) {
    group.add_child(Box::new(TestSubcase::new(name, move || {
        Box::new(GatherCase {
            spec: make(),
            names: Names::default(),
        })
    })) as Box<dyn TestCase>);
}

fn add_subcase(group: &mut TestCaseGroup, name: &str, make: fn() -> Box<dyn Subcase>) {
    group.add_child(Box::new(TestSubcase::new(name, make)) as Box<dyn TestCase>);
}

/// `TextureGatherTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture_gather");
    let g = &mut group;

    add_subcase(g, "api-enums", || Box::new(GatherEnumsTest));
    add_subcase(g, "gather-glsl-compile", || Box::new(GatherGlslCompile { program: 0 }));
    add_gather(g, "plain-gather-float-2d-rgba", base);
    add_gather(g, "plain-gather-float-2d-rg", float_2d_rg);
    add_gather(g, "plain-gather-unorm-2d", unorm_2d);
    add_gather(g, "plain-gather-int-2d-rgba", int_2d_rgba);
    add_gather(g, "plain-gather-int-2d-rg", int_2d_rg);
    add_gather(g, "plain-gather-uint-2d", uint_2d);
    add_gather(g, "plain-gather-depth-2d", depth_2d);
    add_gather(g, "plain-gather-float-2darray", float_2d_array);
    add_gather(g, "plain-gather-unorm-2darray", unorm_2d_array);
    add_gather(g, "plain-gather-int-2darray", int_2d_array);
    add_gather(g, "plain-gather-uint-2darray", uint_2d_array);
    add_gather(g, "plain-gather-depth-2darray", depth_2d_array);
    add_gather(g, "plain-gather-float-cube-rgba", float_cube_rgba);
    add_gather(g, "plain-gather-float-cube-rg", float_cube_rg);
    add_gather(g, "plain-gather-unorm-cube", unorm_cube);
    add_gather(g, "plain-gather-int-cube-rgba", int_cube_rgba);
    add_gather(g, "plain-gather-int-cube-rg", int_cube_rg);
    add_gather(g, "plain-gather-uint-cube", uint_cube);
    add_gather(g, "plain-gather-depth-cube", depth_cube);
    add_gather(g, "plain-gather-float-cube-array", float_cube_array);
    add_gather(g, "plain-gather-unorm-cube-array", unorm_cube_array);
    add_gather(g, "plain-gather-int-cube-array", int_cube_array);
    add_gather(g, "plain-gather-uint-cube-array", uint_cube_array);
    add_gather(g, "plain-gather-depth-cube-array", depth_cube_array);
    add_gather(g, "plain-gather-float-2drect", float_2d_rect);
    add_gather(g, "plain-gather-unorm-2drect", unorm_2d_rect);
    add_gather(g, "plain-gather-int-2drect", int_2d_rect);
    add_gather(g, "plain-gather-uint-2drect", uint_2d_rect);
    add_gather(g, "plain-gather-depth-2drect", depth_2d_rect);
    add_gather(g, "offset-gather-float-2d", offset_float_2d);
    add_gather(g, "offset-gather-unorm-2d", offset_unorm_2d);
    add_gather(g, "offset-gather-int-2d", offset_int_2d);
    add_gather(g, "offset-gather-uint-2d", offset_uint_2d);
    add_gather(g, "offset-gather-depth-2d", offset_depth_2d);
    add_gather(g, "offset-gather-float-2darray", offset_float_2d_array);
    add_gather(g, "offset-gather-unorm-2darray", offset_unorm_2d_array);
    add_gather(g, "offset-gather-int-2darray", offset_int_2d_array);
    add_gather(g, "offset-gather-uint-2darray", offset_uint_2d_array);
    add_gather(g, "offset-gather-depth-2darray", offset_depth_2d_array);
    add_gather(g, "offset-gather-float-2drect", offset_float_2d_rect);
    add_gather(g, "offset-gather-unorm-2drect", offset_unorm_2d_rect);
    add_gather(g, "offset-gather-int-2drect", offset_int_2d_rect);
    add_gather(g, "offset-gather-uint-2drect", offset_uint_2d_rect);
    add_gather(g, "offset-gather-depth-2drect", offset_depth_2d_rect);
    add_gather(g, "offsets-gather-float-2d", offsets_float_2d);
    add_gather(g, "offsets-gather-unorm-2d", offsets_unorm_2d);
    add_gather(g, "offsets-gather-int-2d", offsets_int_2d);
    add_gather(g, "offsets-gather-uint-2d", offsets_uint_2d);
    add_gather(g, "offsets-gather-depth-2d", offsets_depth_2d);
    add_gather(g, "offsets-gather-float-2darray", offsets_float_2d_array);
    add_gather(g, "offsets-gather-unorm-2darray", offsets_unorm_2d_array);
    add_gather(g, "offsets-gather-int-2darray", offsets_int_2d_array);
    add_gather(g, "offsets-gather-uint-2darray", offsets_uint_2d_array);
    add_gather(g, "offsets-gather-depth-2darray", offsets_depth_2d_array);
    add_gather(g, "offsets-gather-float-2drect", offsets_float_2d_rect);
    add_gather(g, "offsets-gather-unorm-2drect", offsets_unorm_2d_rect);
    add_gather(g, "offsets-gather-int-2drect", offsets_int_2d_rect);
    add_gather(g, "offsets-gather-uint-2drect", offsets_uint_2d_rect);
    add_gather(g, "offsets-gather-depth-2drect", offsets_depth_2d_rect);
    add_gather(g, "swizzle", swizzle);
    add_gather(g, "base-level", base_level);
    add_gather(g, "incomplete-texture", incomplete_texture);
    add_gather(g, "incomplete-texture-last-comp", incomplete_texture_last_comp);
    add_subcase(g, "triangle-draw", || {
        Box::new(TriangleDraw {
            names: Names::default(),
        })
    });
    add_gather(g, "plain-gather-float-2d-srgb", float_2d_srgb);
    add_gather(g, "plain-gather-float-2d-srgb-alpha", float_2d_srgb_alpha);
    add_subcase(g, "gather-geometry-shader", || {
        Box::new(GatherStageCase {
            stage: ExtraStage::Geometry,
            spec: base(),
            names: Names::default(),
        })
    });
    add_subcase(g, "gather-tesselation-shader", || {
        Box::new(GatherStageCase {
            stage: ExtraStage::Tessellation,
            spec: base(),
            names: Names::default(),
        })
    });
    add_gather(g, "plain-gather-float-2d-rgb", || float_2d_components(3));
    add_gather(g, "plain-gather-float-2d-r", || float_2d_components(1));
    add_gather(g, "offset-gather-float-2d-rgb", || offset_float_2d_components(3));
    add_gather(g, "offset-gather-float-2d-rg", || offset_float_2d_components(2));
    add_gather(g, "offset-gather-float-2d-r", || offset_float_2d_components(1));

    group
}
