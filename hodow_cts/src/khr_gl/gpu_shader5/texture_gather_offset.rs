// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/gpu_shader5/esextcGPUShader5TextureGatherOffset.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Written without compiling; the GL object bookkeeping is `common::Objects`. The C++ hierarchy (`TestBase` <- `ColorTestBase`/`DepthTestBase` <- the eleven case classes, each overriding a few virtuals) is `Case`, matched in the methods of `TextureGatherOffset`. Upstream draws its texture coordinates and the depth cases' offsets with the C library's unseeded `rand()`; `CRand` is the glibc generator, started from seed 1 for every case. The vertex shader sources are the upstream string literals concatenated.

use std::ffi::CString;

use super::common::{CRand, Objects, require_gpu_shader5, run_case};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, RandomFormula, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const TEXTURE_BORDER_CLAMP_NOT_SUPPORTED: &str = "Texture border clamp not supported, skipping";

const COORDINATES_ATTRIBUTE_NAME: &str = "texCoords";
const OFFSETS_ATTRIBUTE_NAME: &str = "offsets";
const COORDINATE_RESOLUTION: i32 = 1024;
const MAX_COORDINATE_VALUE: i32 = 8;
const MIN_COORDINATE_VALUE: i32 = -8;
const N_COMPONENTS_PER_VARYING: usize = 4;
const N_TEXTURE_ARRAY_LENGTH: u32 = 4;
const N_VERTICES: usize = 128;
const N_OFFSETS_COMPONENTS: usize = 2;
const TEXTURE_SIZE: u32 = 64;
const SAMPLER_UNIFORM_NAME: &str = "sampler";
const REFERENCE_SAMPLER_UNIFORM_NAME: &str = "reference_sampler";

const FRAGMENT_SHADER_CODE: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\n\nlayout(location = 0) out vec4 fs_out_color;\n\nvoid main()\n{\n    fs_out_color = vec4(1, 1, 1, 1);\n}\n";
const COLOR_2D_REPEAT_VS: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\nprecision highp isampler2D;\n\nuniform isampler2D sampler;\n\nin ivec2 offsets;\nin vec2  texCoords;\n\nflat out ivec4 without_offset_0;\nflat out ivec4 without_offset_1;\nflat out ivec4 without_offset_2;\nflat out ivec4 without_offset_3;\n\nflat out ivec4 with_offset_0;\nflat out ivec4 with_offset_1;\nflat out ivec4 with_offset_2;\nflat out ivec4 with_offset_3;\n\nvoid main()\n{\n    without_offset_0 = textureGather      (sampler, texCoords, 0);\n    without_offset_1 = textureGather      (sampler, texCoords, 1);\n    without_offset_2 = textureGather      (sampler, texCoords, 2);\n    without_offset_3 = textureGather      (sampler, texCoords, 3);\n\n    with_offset_0    = textureGatherOffset(sampler, texCoords, offsets, 0);\n    with_offset_1    = textureGatherOffset(sampler, texCoords, offsets, 1);\n    with_offset_2    = textureGatherOffset(sampler, texCoords, offsets, 2);\n    with_offset_3    = textureGatherOffset(sampler, texCoords, offsets, 3);\n}\n";
const COLOR_2D_ARRAY_VS: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\nprecision highp isampler2DArray;\n\nuniform isampler2DArray sampler;\n\nin ivec2 offsets;\nin vec3  texCoords;\n\nflat out ivec4 without_offset_0;\nflat out ivec4 without_offset_1;\nflat out ivec4 without_offset_2;\nflat out ivec4 without_offset_3;\n\nflat out ivec4 with_offset_0;\nflat out ivec4 with_offset_1;\nflat out ivec4 with_offset_2;\nflat out ivec4 with_offset_3;\n\nvoid main()\n{\n    without_offset_0 = textureGather      (sampler, texCoords, 0);\n    without_offset_1 = textureGather      (sampler, texCoords, 1);\n    without_offset_2 = textureGather      (sampler, texCoords, 2);\n    without_offset_3 = textureGather      (sampler, texCoords, 3);\n\n    with_offset_0    = textureGatherOffset(sampler, texCoords, offsets, 0);\n    with_offset_1    = textureGatherOffset(sampler, texCoords, offsets, 1);\n    with_offset_2    = textureGatherOffset(sampler, texCoords, offsets, 2);\n    with_offset_3    = textureGatherOffset(sampler, texCoords, offsets, 3);\n}\n";
const COLOR_2D_CLAMP_TO_BORDER_VS: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\nprecision highp isampler2D;\n\nuniform isampler2D sampler;\n\nin ivec2 offsets;\nin vec2  texCoords;\n\nflat out ivec4 without_offset_0;\nflat out ivec4 without_offset_1;\nflat out ivec4 without_offset_2;\nflat out ivec4 without_offset_3;\n\nflat out ivec4 with_offset_0;\nflat out ivec4 with_offset_1;\nflat out ivec4 with_offset_2;\nflat out ivec4 with_offset_3;\n\nvoid main()\n{\n    vec2 floorTexCoords = floor(texCoords);\n    vec2 fractTexCoords = texCoords - floorTexCoords;\n\n    without_offset_0 = textureGather      (sampler, fractTexCoords, 0);\n    without_offset_1 = textureGather      (sampler, fractTexCoords, 1);\n\n    without_offset_2 = ivec4(int(floorTexCoords.x));\n    without_offset_3 = ivec4(int(floorTexCoords.y));\n\n    with_offset_0    = textureGatherOffset(sampler, texCoords, offsets, 0);\n    with_offset_1    = textureGatherOffset(sampler, texCoords, offsets, 1);\n    with_offset_2    = textureGatherOffset(sampler, texCoords, offsets, 2);\n    with_offset_3    = textureGatherOffset(sampler, texCoords, offsets, 3);\n}\n";
const COLOR_2D_CLAMP_TO_EDGE_VS: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\nprecision highp isampler2D;\n\nuniform isampler2D sampler;\nuniform isampler2D reference_sampler;\n\nin ivec2 offsets;\nin vec2  texCoords;\n\nflat out ivec4 without_offset_0;\nflat out ivec4 without_offset_1;\nflat out ivec4 without_offset_2;\nflat out ivec4 without_offset_3;\n\nflat out ivec4 with_offset_0;\nflat out ivec4 with_offset_1;\nflat out ivec4 with_offset_2;\nflat out ivec4 with_offset_3;\n\nvoid main()\n{\n    vec2 floorTexCoords = floor(texCoords);\n    vec2 fractTexCoords = texCoords - floorTexCoords;\n\n    without_offset_0 = textureGather      (reference_sampler, fractTexCoords, 0);\n    without_offset_1 = textureGather      (reference_sampler, fractTexCoords, 1);\n\n    without_offset_2 = ivec4(int(floorTexCoords.x));\n    without_offset_3 = ivec4(int(floorTexCoords.y));\n\n    with_offset_0    = textureGatherOffset(sampler, texCoords, offsets, 0);\n    with_offset_1    = textureGatherOffset(sampler, texCoords, offsets, 1);\n    with_offset_2    = textureGatherOffset(sampler, texCoords, offsets, 2);\n    with_offset_3    = textureGatherOffset(sampler, texCoords, offsets, 3);\n}\n";
const COLOR_2D_OFFSETS_VS_PREAMBLE: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\nprecision highp isampler2D;\n\nuniform isampler2D sampler;\n\nin vec2  texCoords;\n\nflat out ivec4 without_offset_0;\nflat out ivec4 without_offset_1;\nflat out ivec4 without_offset_2;\nflat out ivec4 without_offset_3;\n\nflat out ivec4 with_offset_0;\nflat out ivec4 with_offset_1;\nflat out ivec4 with_offset_2;\nflat out ivec4 with_offset_3;\n\nvoid main()\n{\n    const ivec2 offsets[4] = \n";
const COLOR_2D_OFFSETS_VS_BODY: &str = "\n    without_offset_0 = textureGather       (sampler, texCoords, 0);\n    without_offset_1 = textureGather       (sampler, texCoords, 1);\n    without_offset_2 = textureGather       (sampler, texCoords, 2);\n    without_offset_3 = textureGather       (sampler, texCoords, 3);\n\n    with_offset_0    = textureGatherOffsets(sampler, texCoords, offsets, 0);\n    with_offset_1    = textureGatherOffsets(sampler, texCoords, offsets, 1);\n    with_offset_2    = textureGatherOffsets(sampler, texCoords, offsets, 2);\n    with_offset_3    = textureGatherOffsets(sampler, texCoords, offsets, 3);\n}\n";
const DEPTH_2D_REPEAT_VS: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\nprecision highp sampler2DShadow;\n\nuniform sampler2DShadow sampler;\n\nin ivec2 offsets;\nin vec2  texCoords;\n\nflat out ivec4 with_offset;\nflat out ivec4 without_offset;\n\nvoid main()\n{\n    ivec2 texture_size = textureSize(sampler, 0 /* lod */);\n    float step         = 1.0f / float(texture_size.x);\n\n    without_offset = ivec4(0, 0, 0, 0);\n    with_offset    = ivec4(0, 0, 0, 0);\n\n    for (int x = 0; x < texture_size.x; ++x)\n    {\n        float refZ = float(x) * step;\n\n        without_offset += ivec4(textureGather      (sampler, texCoords, refZ));\n        with_offset    += ivec4(textureGatherOffset(sampler, texCoords, refZ, offsets));\n    }\n}\n";
const DEPTH_2D_REPEAT_Y_VS: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\nprecision highp sampler2DShadow;\n\nuniform sampler2DShadow sampler;\n\nin ivec2 offsets;\nin vec2  texCoords;\n\nflat out ivec4 without_offset;\nflat out ivec4 with_offset;\n\nvoid main()\n{\n    ivec2 texture_size = textureSize(sampler, 0 /* lod */);\n    float step         = 1.0f / float(texture_size.y);\n\n    without_offset = ivec4(0, 0, 0, 0);\n    with_offset    = ivec4(0, 0, 0, 0);\n\n    for (int y = 0; y < texture_size.y; ++y)\n    {\n        float refZ = float(y) * step;\n\n        without_offset += ivec4(textureGather      (sampler, texCoords, refZ));\n        with_offset    += ivec4(textureGatherOffset(sampler, texCoords, refZ, offsets));\n    }\n}\n";
const DEPTH_2D_ARRAY_VS: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\nprecision highp sampler2DArrayShadow;\n\nuniform sampler2DArrayShadow sampler;\n\nin ivec2 offsets;\nin vec3  texCoords;\n\nflat out ivec4 without_offset;\nflat out ivec4 with_offset;\n\nvoid main()\n{\n    ivec3 texture_size = textureSize(sampler, 0 /* lod */);\n    float step         = 1.0f / float(texture_size.x);\n\n    without_offset = ivec4(0, 0, 0, 0);\n    with_offset    = ivec4(0, 0, 0, 0);\n\n    for (int x = 0; x < texture_size.x; ++x)\n    {\n        float refZ = float(x) * step;\n\n        without_offset += ivec4(textureGather      (sampler, texCoords, refZ));\n        with_offset    += ivec4(textureGatherOffset(sampler, texCoords, refZ, offsets));\n    }\n}\n";
const DEPTH_2D_CLAMP_TO_BORDER_VS: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\nprecision highp sampler2DShadow;\n\nuniform sampler2DShadow sampler;\n\nin ivec2 offsets;\nin vec2  texCoords;\n\nflat out ivec4 with_offset;\nflat out ivec4 without_offset;\nflat out ivec4 floor_tex_coord;\n\nvoid main()\n{\n    ivec2 texture_size  = textureSize(sampler, 0 /* lod */);\n    float step          = 1.0f / float(texture_size.x);\n\n    vec2 floorTexCoords = floor(texCoords);\n    vec2 fractTexCoords = texCoords - floorTexCoords;\n\n    floor_tex_coord     = ivec4(ivec2(floorTexCoords.xy), 0, 0);\n\n    without_offset      = ivec4(0, 0, 0, 0);\n    with_offset         = ivec4(0, 0, 0, 0);\n\n    for (int x = 0; x < texture_size.x; ++x)\n    {\n        float refZ = float(x) * step;\n\n        without_offset += ivec4(textureGather      (sampler, fractTexCoords, refZ));\n        with_offset    += ivec4(textureGatherOffset(sampler, texCoords,      refZ, offsets));\n    }\n}\n";
const DEPTH_2D_CLAMP_TO_EDGE_VS: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\nprecision highp sampler2DShadow;\n\nuniform sampler2DShadow sampler;\nuniform sampler2DShadow reference_sampler;\n\nin ivec2 offsets;\nin vec2  texCoords;\n\nflat out ivec4 with_offset;\nflat out ivec4 without_offset;\nflat out ivec4 floor_tex_coord;\n\nvoid main()\n{\n    ivec2 texture_size  = textureSize(sampler, 0 /* lod */);\n    float step          = 1.0f / float(texture_size.x);\n\n    vec2 floorTexCoords = floor(texCoords);\n    vec2 fractTexCoords = texCoords - floorTexCoords;\n\n    floor_tex_coord     = ivec4(ivec2(floorTexCoords.xy), 0, 0);\n\n    without_offset      = ivec4(0, 0, 0, 0);\n    with_offset         = ivec4(0, 0, 0, 0);\n\n    for (int x = 0; x < texture_size.x; ++x)\n    {\n        float refZ = float(x) * step;\n\n        without_offset += ivec4(textureGather      (reference_sampler, fractTexCoords, refZ));\n        with_offset    += ivec4(textureGatherOffset(sampler,           texCoords,      refZ, offsets));\n    }\n}\n";
const DEPTH_2D_OFFSETS_VS_PREAMBLE: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\nprecision highp sampler2DShadow;\n\nuniform sampler2DShadow sampler;\n\nin vec2  texCoords;\n\nflat out ivec4 without_offset;\nflat out ivec4 with_offset;\n\nvoid main()\n{\n    const ivec2 offsets[4] =\n";
const DEPTH_2D_OFFSETS_VS_BODY: &str = "\n    ivec2 texture_size = textureSize(sampler, 0 /* lod */);\n    float step         = 1.0f / float(texture_size.x);\n\n    without_offset = ivec4(0, 0, 0, 0);\n    with_offset = ivec4(0, 0, 0, 0);\n\n    for (int x = 0; x < texture_size.x; ++x)\n    {\n        float refZ = float(x) * step;\n\n        without_offset += ivec4(textureGather       (sampler, texCoords, refZ));\n        with_offset    += ivec4(textureGatherOffsets(sampler, texCoords, refZ, offsets));\n    }\n}\n";

/// The case classes of `GPUShader5TextureGatherOffset*CaseTest`.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Case {
    Color2DRepeat,
    Color2DArray,
    Color2DOffsets,
    Color2DClampToBorder,
    Color2DClampToEdge,
    Depth2DRepeat,
    Depth2DRepeatY,
    Depth2DArray,
    Depth2DOffsets,
    Depth2DClampToBorder,
    Depth2DClampToEdge,
}

/// One case of tests 9, 10 and 11.
pub(super) struct TextureGatherOffset {
    pub ext_params: ExtParameters,
    pub name: &'static str,
    pub case: Case,
}

/// `GPUShader5TextureGatherOffsetColorTestBase::CapturedVaryings`
struct ColorVaryings {
    without_offset: [[i32; N_COMPONENTS_PER_VARYING]; 4],
    with_offset: [[i32; N_COMPONENTS_PER_VARYING]; 4],
}

/// `GPUShader5TextureGatherOffsetDepthTestBase::CapturedVaryings`
struct DepthVaryings {
    without_offset: [i32; N_COMPONENTS_PER_VARYING],
    with_offset: [i32; N_COMPONENTS_PER_VARYING],
    floor_tex_coord: [i32; N_COMPONENTS_PER_VARYING],
}

/// What the case classes keep in members.
#[derive(Default)]
struct State {
    min_texture_gather_offset: GLint,
    max_texture_gather_offset: GLint,
    is_texture_array: bool,
    texture_wrap_mode: GLenum,
    n_coordinates_components: usize,
    coordinates_buffer_data: Vec<f32>,
    offsets_buffer_data: Vec<i32>,
    n_varyings_per_vertex: usize,
}

/// `VertexBufferInfo`
struct VertexBufferInfo {
    attribute_name: &'static str,
    n_components: GLint,
    type_: GLenum,
    data: Vec<u8>,
}

fn int_bytes(values: &[i32]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_ne_bytes()).collect()
}

fn float_bytes(values: &[f32]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_ne_bytes()).collect()
}

fn read_ints(bytes: &[u8]) -> Vec<i32> {
    bytes
        .chunks_exact(4)
        .map(|chunk| i32::from_ne_bytes(chunk.try_into().expect("four bytes")))
        .collect()
}

/// `clamp<T>`
fn clamp_in_place(value: &mut i32, min: i32, max: i32) {
    if min > *value {
        *value = min;
    } else if max < *value {
        *value = max;
    }
}

/// X and Y offsets of the texels of a gather 2x2 set.
const GATHER_OFFSETS_X: [i32; 4] = [0, 1, 1, 0];
const GATHER_OFFSETS_Y: [i32; 4] = [1, 1, 0, 0];

impl Case {
    fn is_color(self) -> bool {
        matches!(
            self,
            Case::Color2DRepeat
                | Case::Color2DArray
                | Case::Color2DOffsets
                | Case::Color2DClampToBorder
                | Case::Color2DClampToEdge
        )
    }

    fn is_texture_array(self) -> bool {
        matches!(self, Case::Color2DArray | Case::Depth2DArray)
    }

    fn uses_clamp_to_border_support(self) -> bool {
        matches!(
            self,
            Case::Color2DClampToBorder
                | Case::Color2DClampToEdge
                | Case::Depth2DClampToBorder
                | Case::Depth2DClampToEdge
        )
    }

    fn is_offsets_case(self) -> bool {
        matches!(self, Case::Color2DOffsets | Case::Depth2DOffsets)
    }
}

impl TextureGatherOffset {
    /// `getTextureWrapMode`
    fn texture_wrap_mode(&self, base: &TestCaseBase) -> GLenum {
        match self.case {
            Case::Color2DClampToBorder | Case::Depth2DClampToBorder => base.gl_ext_tokens.clamp_to_border,
            Case::Color2DClampToEdge | Case::Depth2DClampToEdge => glw::GL_CLAMP_TO_EDGE,
            _ => glw::GL_REPEAT,
        }
    }

    /// `getShaderParts`; the offsets cases build the middle part from the queried limits.
    fn vertex_shader_parts(&self, state: &State) -> Vec<String> {
        let offsets_text = || {
            let (min, max) = (state.min_texture_gather_offset, state.max_texture_gather_offset);

            format!(
                "           ivec2[4]( ivec2( {min}, {min}),\n                     ivec2( {min}, {max}),\n                     ivec2( {max}, {min}),\n                     ivec2( {max}, {max}));\n"
            )
        };

        match self.case {
            Case::Color2DRepeat => vec![COLOR_2D_REPEAT_VS.to_string()],
            Case::Color2DArray => vec![COLOR_2D_ARRAY_VS.to_string()],
            Case::Color2DClampToBorder => vec![COLOR_2D_CLAMP_TO_BORDER_VS.to_string()],
            Case::Color2DClampToEdge => vec![COLOR_2D_CLAMP_TO_EDGE_VS.to_string()],
            Case::Color2DOffsets => vec![
                COLOR_2D_OFFSETS_VS_PREAMBLE.to_string(),
                offsets_text(),
                COLOR_2D_OFFSETS_VS_BODY.to_string(),
            ],
            Case::Depth2DRepeat => vec![DEPTH_2D_REPEAT_VS.to_string()],
            Case::Depth2DRepeatY => vec![DEPTH_2D_REPEAT_Y_VS.to_string()],
            Case::Depth2DArray => vec![DEPTH_2D_ARRAY_VS.to_string()],
            Case::Depth2DClampToBorder => vec![DEPTH_2D_CLAMP_TO_BORDER_VS.to_string()],
            Case::Depth2DClampToEdge => vec![DEPTH_2D_CLAMP_TO_EDGE_VS.to_string()],
            Case::Depth2DOffsets => vec![
                DEPTH_2D_OFFSETS_VS_PREAMBLE.to_string(),
                offsets_text(),
                DEPTH_2D_OFFSETS_VS_BODY.to_string(),
            ],
        }
    }

    /// `getTransformFeedBackDetails` / `getVaryings`: the captured varyings' names.
    fn captured_varyings(&self) -> Vec<&'static str> {
        if self.case.is_color() {
            vec![
                "without_offset_0",
                "with_offset_0",
                "without_offset_1",
                "with_offset_1",
                "without_offset_2",
                "with_offset_2",
                "without_offset_3",
                "with_offset_3",
            ]
        } else if matches!(self.case, Case::Depth2DClampToBorder | Case::Depth2DClampToEdge) {
            vec!["without_offset", "with_offset", "floor_tex_coord"]
        } else {
            vec!["without_offset", "with_offset"]
        }
    }

    /// `getBorderColor`
    fn border_color(&self) -> [f32; 4] {
        if self.case.is_color() { [-1.0; 4] } else { [1.0; 4] }
    }

    /// `prepareTextureData`: `(data, bytes per pixel)`
    fn texture_data(&self) -> Vec<u8> {
        let size = TEXTURE_SIZE as usize;

        if self.case.is_color() {
            // Each texel is assigned {x, y, x, y}, where x and y are coordinates of texel.
            let mut texture_data = vec![0i32; size * size * 4];

            for y in 0..size {
                for x in 0..size {
                    let pixel_offset = y * 4 * size + x * 4;

                    texture_data[pixel_offset] = x as i32;
                    texture_data[pixel_offset + 1] = y as i32;
                    texture_data[pixel_offset + 2] = x as i32;
                    texture_data[pixel_offset + 3] = y as i32;
                }
            }

            int_bytes(&texture_data)
        } else {
            let step = 1.0f32 / TEXTURE_SIZE as f32;
            let mut texture_data = vec![0.0f32; size * size];

            for y in 0..size {
                for x in 0..size {
                    texture_data[y * size + x] = if self.case == Case::Depth2DRepeatY {
                        y as f32 * step
                    } else {
                        x as f32 * step
                    };
                }
            }

            float_bytes(&texture_data)
        }
    }

    /// `prepareVertexBuffersData`: the cases' own attribute (`offsets`) if they have one.
    fn prepare_vertex_buffers_data(&self, state: &mut State, crand: &mut CRand) {
        let n_total_components = N_VERTICES * N_OFFSETS_COMPONENTS;
        let min_ptgo = state.min_texture_gather_offset;
        let max_ptgo = state.max_texture_gather_offset;

        if self.case.is_offsets_case() {
            return;
        }

        state.offsets_buffer_data = vec![0; n_total_components];

        if self.case.is_color() {
            let mut random = RandomFormula::default();
            random.random_seed(1);

            for offset in &mut state.offsets_buffer_data {
                *offset = random.random_formula((max_ptgo - min_ptgo + 1) as GLuint) as i32 + min_ptgo;
            }
        } else if self.case == Case::Depth2DClampToBorder {
            for (i, offset) in state.offsets_buffer_data.iter_mut().enumerate() {
                *offset = if i % 2 == 0 {
                    crand.next() % (max_ptgo - min_ptgo + 1) + min_ptgo
                } else {
                    0
                };
            }
        } else {
            for offset in &mut state.offsets_buffer_data {
                *offset = crand.next() % (max_ptgo - min_ptgo + 1) + min_ptgo;
            }
        }
    }

    /// `getOffsets`
    fn offsets(state: &State, index: usize) -> (i32, i32) {
        (
            state.offsets_buffer_data[index * N_OFFSETS_COMPONENTS],
            state.offsets_buffer_data[index * N_OFFSETS_COMPONENTS + 1],
        )
    }

    /// `logCoordinates`
    fn log_coordinates(state: &State, index: usize) {
        let components = &state.coordinates_buffer_data
            [index * state.n_coordinates_components..(index + 1) * state.n_coordinates_components];
        let text = components
            .iter()
            .map(|component| component.to_string())
            .collect::<Vec<_>>()
            .join(", ");

        log::info!("Texture coordinates (range [0:1]): [{text}]");
    }

    fn log_color_varyings(varyings: &ColorVaryings) {
        for (label, data) in [
            "Without offset X: ",
            "Without offset Y: ",
            "Without offset Z: ",
            "Without offset W: ",
        ]
        .into_iter()
        .zip(varyings.without_offset)
        {
            log::info!(
                "{label}( {} )",
                data.iter().map(|value| value.to_string()).collect::<Vec<_>>().join(" ")
            );
        }
        for (label, data) in [
            "With offset X: ",
            "With offset Y: ",
            "With offset Z: ",
            "With offset W: ",
        ]
        .into_iter()
        .zip(varyings.with_offset)
        {
            log::info!(
                "{label}( {} )",
                data.iter().map(|value| value.to_string()).collect::<Vec<_>>().join(" ")
            );
        }
    }

    fn log_depth_varyings(varyings: &DepthVaryings) {
        log::info!(
            "Without offset: ( {} )",
            varyings
                .without_offset
                .iter()
                .map(|value| value.to_string())
                .collect::<Vec<_>>()
                .join(" ")
        );
        log::info!(
            "With offset: ( {} )",
            varyings
                .with_offset
                .iter()
                .map(|value| value.to_string())
                .collect::<Vec<_>>()
                .join(" ")
        );
    }

    /// The `Invalid result` section every `checkResult` logs.
    fn log_invalid_color_result(
        state: &State,
        index: usize,
        texture_size: i32,
        offsets: &str,
        varyings: &ColorVaryings,
    ) {
        log::info!("Invalid result");
        Self::log_coordinates(state, index);
        log::info!("Texture size: {texture_size}");
        log::info!("Offsets: {offsets}");
        Self::log_color_varyings(varyings);
    }

    fn log_invalid_depth_result(
        state: &State,
        index: usize,
        texture_size: i32,
        offsets: &str,
        varyings: &DepthVaryings,
    ) {
        log::info!("Invalid result");
        Self::log_coordinates(state, index);
        log::info!("Texture size: {texture_size}");
        log::info!("Offsets: {offsets}");
        Self::log_depth_varyings(varyings);
    }

    fn log_unexpected_color_sampling(
        state: &State,
        index: usize,
        texture_size: i32,
        x_offset: i32,
        y_offset: i32,
        varyings: &ColorVaryings,
    ) {
        log::info!("Unexpected sampling results");
        Self::log_coordinates(state, index);
        log::info!("Texture size: {texture_size}");
        log::info!("Offsets: {x_offset}, {y_offset}");
        Self::log_color_varyings(varyings);
    }

    /// `Color2DRepeatCaseTest::checkResult` (also used by the array case)
    fn check_color_repeat(state: &State, captured: &ColorVaryings, index: usize, tex_size: u32) -> bool {
        let texture_size = tex_size as i32;
        let (mut x_offset, mut y_offset) = Self::offsets(state, index);

        // Roll x offsets around left edge when negative
        if x_offset < 0 {
            x_offset %= texture_size;
            x_offset += texture_size;
        }

        // Roll y offsets around top edge when negative
        if y_offset < 0 {
            y_offset %= texture_size;
            y_offset += texture_size;
        }

        let mut expected_values = [[0i32; N_COMPONENTS_PER_VARYING]; 4];

        for i in 0..N_COMPONENTS_PER_VARYING {
            expected_values[0][i] = (x_offset + captured.without_offset[0][i]) % texture_size;
            expected_values[1][i] = (y_offset + captured.without_offset[1][i]) % texture_size;
            expected_values[2][i] = (x_offset + captured.without_offset[2][i]) % texture_size;
            expected_values[3][i] = (y_offset + captured.without_offset[3][i]) % texture_size;
        }

        for i in 0..N_COMPONENTS_PER_VARYING {
            if (0..4).any(|k| captured.with_offset[k][i] != expected_values[k][i]) {
                Self::log_invalid_color_result(
                    state,
                    index,
                    texture_size,
                    &format!("{x_offset}, {y_offset}"),
                    captured,
                );
                return false;
            }
        }

        true
    }

    /// The "find the first texel that is not clamped" lookup of the color clamp cases.
    fn first_not_clamped_color_texel(captured: &ColorVaryings) -> Option<usize> {
        (0..N_COMPONENTS_PER_VARYING)
            .find(|&i| captured.without_offset[0][i] >= 0 && captured.without_offset[1][i] >= 0)
    }

    /// The absolute position of the lower left corner of the without-offset set, per texel of the 2x2 set (X values, Y values).
    fn color_absolute_positions(
        captured: &ColorVaryings,
        not_clamped_texel_index: usize,
        texture_size: i32,
    ) -> ([i32; 4], [i32; 4]) {
        // Fraction part of position for lower left texel without_offset set
        let fract_position_x =
            captured.without_offset[0][not_clamped_texel_index] - GATHER_OFFSETS_X[not_clamped_texel_index];
        let fract_position_y =
            captured.without_offset[1][not_clamped_texel_index] - GATHER_OFFSETS_Y[not_clamped_texel_index];

        // Absolute position of lower left corner in without_offset set
        let absolute_position_x = fract_position_x + captured.without_offset[2][0] * texture_size;
        let absolute_position_y = fract_position_y + captured.without_offset[3][0] * texture_size;

        let mut xs = [0; 4];
        let mut ys = [0; 4];
        for i in 0..N_COMPONENTS_PER_VARYING {
            xs[i] = absolute_position_x + GATHER_OFFSETS_X[i];
            ys[i] = absolute_position_y + GATHER_OFFSETS_Y[i];
        }

        (xs, ys)
    }

    /// `Color2DClampToBorderCaseTest::checkResult`
    fn check_color_clamp_to_border(
        state: &State,
        captured: &ColorVaryings,
        index: usize,
        texture_size: u32,
    ) -> Result<bool, TestError> {
        let texture_size = texture_size as i32;
        let (x_offset, y_offset) = Self::offsets(state, index);

        let Some(not_clamped_texel_index) = Self::first_not_clamped_color_texel(captured) else {
            Self::log_unexpected_color_sampling(state, index, texture_size, x_offset, y_offset, captured);
            return Err(TestError::Fail("Unexpected sampling results".to_string()));
        };

        let (xs, ys) = Self::color_absolute_positions(captured, not_clamped_texel_index, texture_size);

        // Modify "border color" to -1 in with_offset set
        let mut with_offset = [[0i32; N_COMPONENTS_PER_VARYING]; 4];
        for k in 0..4 {
            for i in 0..N_COMPONENTS_PER_VARYING {
                with_offset[k][i] = if captured.with_offset[k][i] >= 0 {
                    captured.with_offset[k][i]
                } else {
                    -1
                };
            }
        }

        // Apply offsets to absolute positions of without_offset
        let mut expected_values = [xs, ys, xs, ys];
        for i in 0..N_COMPONENTS_PER_VARYING {
            expected_values[0][i] += x_offset;
            expected_values[1][i] += y_offset;
            expected_values[2][i] += x_offset;
            expected_values[3][i] += y_offset;

            // Set to -1, when point defined by expected_values_01 is outside of texture
            if expected_values[0][i] < 0
                || texture_size <= expected_values[0][i]
                || expected_values[1][i] < 0
                || texture_size <= expected_values[1][i]
            {
                expected_values[0][i] = -1;
                expected_values[1][i] = -1;
            }

            // Set to -1, when point defined by expected_values_23 is outside of texture
            if expected_values[2][i] < 0
                || texture_size <= expected_values[2][i]
                || expected_values[3][i] < 0
                || texture_size <= expected_values[3][i]
            {
                expected_values[2][i] = -1;
                expected_values[3][i] = -1;
            }
        }

        for i in 0..N_COMPONENTS_PER_VARYING {
            if (0..4).any(|k| with_offset[k][i] != expected_values[k][i]) {
                Self::log_invalid_color_result(
                    state,
                    index,
                    texture_size,
                    &format!("{x_offset}, {y_offset}"),
                    captured,
                );
                return Ok(false);
            }
        }

        Ok(true)
    }

    /// `Color2DClampToEdgeCaseTest::checkResult`
    fn check_color_clamp_to_edge(
        state: &State,
        captured: &ColorVaryings,
        index: usize,
        texture_size: u32,
    ) -> Result<bool, TestError> {
        let texture_size = texture_size as i32;
        let (x_offset, y_offset) = Self::offsets(state, index);

        let Some(not_clamped_texel_index) = Self::first_not_clamped_color_texel(captured) else {
            Self::log_unexpected_color_sampling(state, index, texture_size, x_offset, y_offset, captured);
            return Err(TestError::Fail("Unexpected sampling results".to_string()));
        };

        let (xs, ys) = Self::color_absolute_positions(captured, not_clamped_texel_index, texture_size);

        let mut expected_values = [xs, ys, xs, ys];
        for i in 0..N_COMPONENTS_PER_VARYING {
            expected_values[0][i] += x_offset;
            expected_values[1][i] += y_offset;
            expected_values[2][i] += x_offset;
            expected_values[3][i] += y_offset;

            // Clamp value when point is outside of texture
            for values in &mut expected_values {
                clamp_in_place(&mut values[i], 0, texture_size - 1);
            }
        }

        for i in 0..N_COMPONENTS_PER_VARYING {
            if (0..4).any(|k| captured.with_offset[k][i] != expected_values[k][i]) {
                Self::log_invalid_color_result(
                    state,
                    index,
                    texture_size,
                    &format!("{x_offset}, {y_offset}"),
                    captured,
                );
                return Ok(false);
            }
        }

        Ok(true)
    }

    /// `Color2DOffsetsCaseTest::checkResult`
    fn check_color_offsets(state: &State, captured: &ColorVaryings, index: usize, tex_size: u32) -> bool {
        let texture_size = tex_size as i32;
        let (min, max) = (state.min_texture_gather_offset, state.max_texture_gather_offset);

        let mut x_offsets = [min, min, max, max];
        let mut y_offsets = [min, max, min, max];

        for i in 0..N_COMPONENTS_PER_VARYING {
            // Roll x offsets around left edge when negative
            if x_offsets[i] < 0 {
                x_offsets[i] %= texture_size;
                x_offsets[i] += texture_size;
            }

            // Roll y offsets around top edge when negative
            if y_offsets[i] < 0 {
                y_offsets[i] %= texture_size;
                y_offsets[i] += texture_size;
            }
        }

        let mut expected_values = [[0i32; N_COMPONENTS_PER_VARYING]; 4];
        for i in 0..N_COMPONENTS_PER_VARYING {
            expected_values[0][i] = (x_offsets[i] + captured.without_offset[0][3]) % texture_size;
            expected_values[1][i] = (y_offsets[i] + captured.without_offset[1][3]) % texture_size;
            expected_values[2][i] = (x_offsets[i] + captured.without_offset[2][3]) % texture_size;
            expected_values[3][i] = (y_offsets[i] + captured.without_offset[3][3]) % texture_size;
        }

        for i in 0..N_COMPONENTS_PER_VARYING {
            if (0..4).any(|k| captured.with_offset[k][i] != expected_values[k][i]) {
                let offsets = format!(
                    "({}, {}) ({}, {}) ({}, {}) ({}, {}) ",
                    x_offsets[0],
                    y_offsets[0],
                    x_offsets[1],
                    y_offsets[1],
                    x_offsets[2],
                    y_offsets[2],
                    x_offsets[3],
                    y_offsets[3]
                );
                Self::log_invalid_color_result(state, index, texture_size, &offsets, captured);
                return false;
            }
        }

        true
    }

    /// `Depth2DRepeatCaseTest::checkResult` (also used by the array case) and `Depth2DRepeatYCaseTest::checkResult` when `along_y`.
    fn check_depth_repeat(state: &State, captured: &DepthVaryings, index: usize, tex_size: u32, along_y: bool) -> bool {
        let texture_size = tex_size as i32;
        let (mut x_offset, mut y_offset) = Self::offsets(state, index);

        // Roll the offset around the edge when negative
        let rolled = if along_y { &mut y_offset } else { &mut x_offset };
        if *rolled < 0 {
            *rolled %= texture_size;
            *rolled += texture_size;
        }
        let rolled = if along_y { y_offset } else { x_offset };

        let mut expected_values = [0i32; N_COMPONENTS_PER_VARYING];
        for i in 0..N_COMPONENTS_PER_VARYING {
            expected_values[i] = (rolled + captured.without_offset[i]) % texture_size;
        }

        for i in 0..N_COMPONENTS_PER_VARYING {
            if captured.with_offset[i] != expected_values[i] {
                Self::log_invalid_depth_result(
                    state,
                    index,
                    texture_size,
                    &format!("{x_offset}, {y_offset}"),
                    captured,
                );
                return false;
            }
        }

        true
    }

    /// The first texel of the without-offset set that is not the clamped one (`texture_size`).
    fn first_not_clamped_depth_texel(captured: &DepthVaryings, texture_size: i32) -> Option<usize> {
        (0..N_COMPONENTS_PER_VARYING).find(|&i| texture_size != captured.without_offset[i])
    }

    /// `Depth2DClampToBorderCaseTest::checkResult`
    fn check_depth_clamp_to_border(
        state: &State,
        captured: &DepthVaryings,
        index: usize,
        texture_size: u32,
    ) -> Result<bool, TestError> {
        let texture_size = texture_size as i32;
        let (x_offset, y_offset) = Self::offsets(state, index);

        let Some(not_clamped_texel_index) = Self::first_not_clamped_depth_texel(captured, texture_size) else {
            log::info!("Unexpected sampling results");
            Self::log_coordinates(state, index);
            log::info!("Texture size: {texture_size}");
            log::info!("Offsets: {x_offset}, {y_offset}");
            Self::log_depth_varyings(captured);
            return Err(TestError::Fail("Unexpected sampling results".to_string()));
        };

        // Fraction part of position for lower left texel without_offset set
        let fract_position_x =
            captured.without_offset[not_clamped_texel_index] - GATHER_OFFSETS_X[not_clamped_texel_index];

        // Absolute position of lower left corner in without_offset set
        let absolute_position_x = fract_position_x + captured.floor_tex_coord[0] * texture_size;

        let mut wrap_matrix = [0i32; 4];

        // Index of value in without_offset set, that should be checked for being clamped
        let wrap_value_to_check_indices = [3usize, 2, 1, 0];
        let wrap_value_to_check = captured.without_offset[wrap_value_to_check_indices[not_clamped_texel_index]];

        match not_clamped_texel_index {
            0 | 1 => {
                wrap_matrix[0] = 0;
                wrap_matrix[1] = 0;
                if texture_size == wrap_value_to_check {
                    wrap_matrix[2] = -1;
                    wrap_matrix[3] = -1;
                }
            }
            _ => {
                wrap_matrix[2] = 0;
                wrap_matrix[3] = 0;
                if texture_size == wrap_value_to_check {
                    wrap_matrix[0] = 1;
                    wrap_matrix[1] = 1;
                }
            }
        }

        // Apply integral part of texture coordinates to wrap_matrix
        for value in &mut wrap_matrix {
            *value += captured.floor_tex_coord[1];
        }

        // For each texel in without_offset set calculate absolute position and apply offset
        let mut expected_values = [0i32; N_COMPONENTS_PER_VARYING];
        for i in 0..N_COMPONENTS_PER_VARYING {
            expected_values[i] = absolute_position_x + GATHER_OFFSETS_X[i];
            expected_values[i] += x_offset;

            // Set to texture_size when point is outside of texture
            if expected_values[i] < 0 || texture_size < expected_values[i] || wrap_matrix[i] != 0 {
                expected_values[i] = texture_size;
            }
        }

        for i in 0..N_COMPONENTS_PER_VARYING {
            if captured.with_offset[i] != expected_values[i] {
                Self::log_invalid_depth_result(
                    state,
                    index,
                    texture_size,
                    &format!("{x_offset}, {y_offset}"),
                    captured,
                );
                return Ok(false);
            }
        }

        Ok(true)
    }

    /// `Depth2DClampToEdgeCaseTest::checkResult`
    fn check_depth_clamp_to_edge(
        state: &State,
        captured: &DepthVaryings,
        index: usize,
        texture_size: u32,
    ) -> Result<bool, TestError> {
        let texture_size = texture_size as i32;
        let (x_offset, y_offset) = Self::offsets(state, index);

        let Some(not_clamped_texel_index) = Self::first_not_clamped_depth_texel(captured, texture_size) else {
            log::info!("Unexpected sampling results");
            Self::log_coordinates(state, index);
            log::info!("Texture size: {texture_size}");
            log::info!("Offsets: {x_offset}, {y_offset}");
            Self::log_depth_varyings(captured);
            return Err(TestError::Fail("Unexpected sampling results".to_string()));
        };

        let fract_position_x =
            captured.without_offset[not_clamped_texel_index] - GATHER_OFFSETS_X[not_clamped_texel_index];
        let absolute_position_x = fract_position_x + captured.floor_tex_coord[0] * texture_size;

        let mut expected_values = [0i32; N_COMPONENTS_PER_VARYING];
        for i in 0..N_COMPONENTS_PER_VARYING {
            expected_values[i] = absolute_position_x + GATHER_OFFSETS_X[i];
            expected_values[i] += x_offset;

            // Clamp when point is outside of texture
            clamp_in_place(&mut expected_values[i], 0, texture_size - 1);
        }

        for i in 0..N_COMPONENTS_PER_VARYING {
            if captured.with_offset[i] != expected_values[i] {
                Self::log_invalid_depth_result(
                    state,
                    index,
                    texture_size,
                    &format!("{x_offset}, {y_offset}"),
                    captured,
                );
                return Ok(false);
            }
        }

        Ok(true)
    }

    /// `Depth2DOffsetsCaseTest::checkResult`
    fn check_depth_offsets(state: &State, captured: &DepthVaryings, index: usize, tex_size: u32) -> bool {
        let texture_size = tex_size as i32;
        let (min, max) = (state.min_texture_gather_offset, state.max_texture_gather_offset);

        let mut x_offsets = [min, min, max, max];
        let y_offsets = [min, max, min, max];

        for x_offset in &mut x_offsets {
            // Roll x offsets around left edge when negative
            if *x_offset < 0 {
                *x_offset %= texture_size;
                *x_offset += texture_size;
            }
        }

        let mut expected_values = [0i32; N_COMPONENTS_PER_VARYING];
        for i in 0..N_COMPONENTS_PER_VARYING {
            expected_values[i] = (x_offsets[i] + captured.without_offset[3]) % texture_size;
        }

        for i in 0..N_COMPONENTS_PER_VARYING {
            if captured.with_offset[i] != expected_values[i] {
                let offsets = format!(
                    "({}, {}) ({}, {}) ({}, {}) ({}, {}) ",
                    x_offsets[0],
                    y_offsets[0],
                    x_offsets[1],
                    y_offsets[1],
                    x_offsets[2],
                    y_offsets[2],
                    x_offsets[3],
                    y_offsets[3]
                );
                Self::log_invalid_depth_result(state, index, texture_size, &offsets, captured);
                return false;
            }
        }

        true
    }

    /// `verifyResult` of the color and depth base classes: every vertex is checked, without stopping at the first error.
    fn verify_result(&self, state: &State, result_data: &[i32]) -> Result<bool, TestError> {
        let mut result = true;
        let texture_size = TEXTURE_SIZE;

        if self.case.is_color() {
            let vertex_size_in_results_buffer = state.n_varyings_per_vertex * N_COMPONENTS_PER_VARYING;

            for vertex in 0..N_VERTICES {
                let vertex_base = vertex * vertex_size_in_results_buffer;
                let mut captured = ColorVaryings {
                    without_offset: [[0; N_COMPONENTS_PER_VARYING]; 4],
                    with_offset: [[0; N_COMPONENTS_PER_VARYING]; 4],
                };

                // The varyings are captured as without_offset_k, with_offset_k for k = 0..3
                for k in 0..4 {
                    let varying_offset = vertex_base + k * 2 * N_COMPONENTS_PER_VARYING;

                    captured.without_offset[k]
                        .copy_from_slice(&result_data[varying_offset..varying_offset + N_COMPONENTS_PER_VARYING]);
                    captured.with_offset[k].copy_from_slice(
                        &result_data
                            [varying_offset + N_COMPONENTS_PER_VARYING..varying_offset + 2 * N_COMPONENTS_PER_VARYING],
                    );
                }

                let is_result_ok = match self.case {
                    Case::Color2DOffsets => Self::check_color_offsets(state, &captured, vertex, texture_size),
                    Case::Color2DClampToBorder => {
                        Self::check_color_clamp_to_border(state, &captured, vertex, texture_size)?
                    }
                    Case::Color2DClampToEdge => {
                        Self::check_color_clamp_to_edge(state, &captured, vertex, texture_size)?
                    }
                    _ => Self::check_color_repeat(state, &captured, vertex, texture_size),
                };

                if !is_result_ok {
                    result = false;
                }
            }
        } else {
            let vertex_size_in_results_buffer = state.n_varyings_per_vertex * N_COMPONENTS_PER_VARYING;

            for vertex in 0..N_VERTICES {
                let vertex_base = vertex * vertex_size_in_results_buffer;
                let mut captured = DepthVaryings {
                    without_offset: [0; N_COMPONENTS_PER_VARYING],
                    with_offset: [0; N_COMPONENTS_PER_VARYING],
                    floor_tex_coord: [0; N_COMPONENTS_PER_VARYING],
                };

                captured
                    .without_offset
                    .copy_from_slice(&result_data[vertex_base..vertex_base + N_COMPONENTS_PER_VARYING]);
                captured.with_offset.copy_from_slice(
                    &result_data[vertex_base + N_COMPONENTS_PER_VARYING..vertex_base + 2 * N_COMPONENTS_PER_VARYING],
                );

                if state.n_varyings_per_vertex >= 3 {
                    captured.floor_tex_coord.copy_from_slice(
                        &result_data
                            [vertex_base + 2 * N_COMPONENTS_PER_VARYING..vertex_base + 3 * N_COMPONENTS_PER_VARYING],
                    );
                }

                let is_result_ok = match self.case {
                    Case::Depth2DOffsets => Self::check_depth_offsets(state, &captured, vertex, texture_size),
                    Case::Depth2DRepeatY => Self::check_depth_repeat(state, &captured, vertex, texture_size, true),
                    Case::Depth2DClampToBorder => {
                        Self::check_depth_clamp_to_border(state, &captured, vertex, texture_size)?
                    }
                    Case::Depth2DClampToEdge => {
                        Self::check_depth_clamp_to_edge(state, &captured, vertex, texture_size)?
                    }
                    _ => Self::check_depth_repeat(state, &captured, vertex, texture_size, false),
                };

                if !is_result_ok {
                    result = false;
                }
            }
        }

        Ok(result)
    }

    /// `prepareVertexBufferInfoForCoordinates`: fills `state.coordinates_buffer_data` and returns its buffer info.
    fn prepare_coordinates(&self, state: &mut State, crand: &mut CRand) -> VertexBufferInfo {
        // Select proper number of components
        state.n_coordinates_components = if state.is_texture_array { 3 } else { 2 };

        state.coordinates_buffer_data = vec![0.0; N_VERTICES * state.n_coordinates_components];

        let coordinate_denominator = COORDINATE_RESOLUTION as f32;

        // Calculation of texture coordinates' range and offsets
        let x_range = (MAX_COORDINATE_VALUE - MIN_COORDINATE_VALUE) as f32 * coordinate_denominator;
        let y_range = (MAX_COORDINATE_VALUE - MIN_COORDINATE_VALUE) as f32 * coordinate_denominator;
        let x_offset = MIN_COORDINATE_VALUE as f32;
        let y_offset = MIN_COORDINATE_VALUE as f32;
        let x_modulus = x_range as i32;
        let y_modulus = y_range as i32;

        let components = state.n_coordinates_components;
        let mut set_coordinates = |values: &[f32], index: usize| {
            state.coordinates_buffer_data[components * index..components * index + values.len()]
                .copy_from_slice(values);
        };

        if state.is_texture_array {
            // First four coordinates are corners, each comes from unique level
            set_coordinates(&[0.0, 0.0, 0.0], 0);
            set_coordinates(&[0.0, 1.0, 1.0], 1);
            set_coordinates(&[1.0, 0.0, 2.0], 2);
            set_coordinates(&[1.0, 1.0, 3.0], 3);

            // Generate rest of texture coordinates
            for i in 4..N_VERTICES {
                let coord_x = (crand.next() % x_modulus) as f32 / coordinate_denominator + x_offset;
                let coord_y = (crand.next() % y_modulus) as f32 / coordinate_denominator + y_offset;
                let coord_z = ((crand.next() as u32 % N_TEXTURE_ARRAY_LENGTH) * COORDINATE_RESOLUTION as u32) as f32
                    / coordinate_denominator;

                set_coordinates(&[coord_x, coord_y, coord_z], i);
            }
        } else {
            // First four coordinates are corners
            set_coordinates(&[0.0, 0.0], 0);
            set_coordinates(&[0.0, 1.0], 1);
            set_coordinates(&[1.0, 0.0], 2);
            set_coordinates(&[1.0, 1.0], 3);

            // Generate rest of texture coordinates
            for i in 4..N_VERTICES {
                let coord_x = (crand.next() % x_modulus) as f32 / coordinate_denominator + x_offset;
                let coord_y = (crand.next() % y_modulus) as f32 / coordinate_denominator + y_offset;

                set_coordinates(&[coord_x, coord_y], i);
            }
        }

        VertexBufferInfo {
            attribute_name: COORDINATES_ATTRIBUTE_NAME,
            n_components: components as GLint,
            type_: glw::GL_FLOAT,
            data: float_bytes(&state.coordinates_buffer_data),
        }
    }

    /// `prepareTexture`; returns the border color for the reference sampler setup too.
    fn prepare_texture(
        &self,
        context: &Context,
        base: &TestCaseBase,
        state: &mut State,
        objects: &mut Objects,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let tokens = base.gl_ext_tokens;

        let (texture_internal_format, texture_format, texture_type, bytes_per_pixel) = if self.case.is_color() {
            (
                glw::GL_RGBA32I,
                glw::GL_RGBA_INTEGER,
                glw::GL_INT,
                4 * std::mem::size_of::<i32>() as u32,
            )
        } else {
            (
                glw::GL_DEPTH_COMPONENT32F,
                glw::GL_DEPTH_COMPONENT,
                glw::GL_FLOAT,
                std::mem::size_of::<f32>() as u32,
            )
        };

        state.is_texture_array = self.case.is_texture_array();
        state.texture_wrap_mode = self.texture_wrap_mode(base);

        // Verify that received texture parameters are valid
        let mut max_texture_size: GLint = 0;
        gl!(gl.get_integerv(glw::GL_MAX_TEXTURE_SIZE, &mut max_texture_size));
        glu::expect_no_error(gl, "glGetIntegerv() failed for GL_MAX_TEXTURE_SIZE pname")?;

        if TEXTURE_SIZE > max_texture_size as u32 {
            return Err(TestError::NotSupported(
                "Required texture dimmensions exceeds GL_MAX_TEXTURE_SIZE limit".to_string(),
            ));
        }

        // Activate first texture unit
        gl!(gl.active_texture(glw::GL_TEXTURE0));
        glu::expect_no_error(gl, "glActiveTexture(GL_TEXTURE0) failed")?;

        // Generate and allocate texture
        let mut texture_object_id: GLuint = 0;
        gl!(gl.gen_textures(1, &mut texture_object_id));
        objects.textures.push(texture_object_id);
        glu::expect_no_error(gl, "glGenTextures() call failed")?;

        let texture_target = if state.is_texture_array {
            glw::GL_TEXTURE_2D_ARRAY
        } else {
            glw::GL_TEXTURE_2D
        };

        gl!(gl.bind_texture(texture_target, texture_object_id));
        glu::expect_no_error(gl, "glBindTexture() call failed")?;

        if state.is_texture_array {
            gl!(gl.tex_storage_3d(
                glw::GL_TEXTURE_2D_ARRAY,
                1,
                texture_internal_format,
                TEXTURE_SIZE as GLint,
                TEXTURE_SIZE as GLint,
                N_TEXTURE_ARRAY_LENGTH as GLint
            ));
            glu::expect_no_error(gl, "glTexStorage3D() call failed")?;
        } else {
            gl!(gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                1,
                texture_internal_format,
                TEXTURE_SIZE as GLint,
                TEXTURE_SIZE as GLint
            ));
            glu::expect_no_error(gl, "glTexStorage2D() call failed")?;
        }

        // Let the case prepare the data for the texture and update it
        let texture_data = self.texture_data();
        debug_assert_eq!(
            texture_data.len(),
            (TEXTURE_SIZE * TEXTURE_SIZE * bytes_per_pixel) as usize
        );

        if state.is_texture_array {
            for z in 0..N_TEXTURE_ARRAY_LENGTH {
                gl!(gl.tex_sub_image_3d(
                    glw::GL_TEXTURE_2D_ARRAY,
                    0,
                    0,
                    0,
                    z as GLint,
                    TEXTURE_SIZE as GLint,
                    TEXTURE_SIZE as GLint,
                    1,
                    texture_format,
                    texture_type,
                    texture_data.as_ptr().cast()
                ));
                glu::expect_no_error(gl, "Failed to update texture data")?;
            }
        } else {
            gl!(gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                TEXTURE_SIZE as GLint,
                TEXTURE_SIZE as GLint,
                texture_format,
                texture_type,
                texture_data.as_ptr().cast()
            ));
            glu::expect_no_error(gl, "Failed to update texture data")?;
        }

        // Set shadow comparison, filtering and wrap modes
        let color = self.border_color();

        gl!(gl.tex_parameteri(texture_target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
        gl!(gl.tex_parameteri(texture_target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
        gl!(gl.tex_parameteri(texture_target, glw::GL_TEXTURE_WRAP_S, state.texture_wrap_mode as GLint));
        gl!(gl.tex_parameteri(texture_target, glw::GL_TEXTURE_WRAP_T, state.texture_wrap_mode as GLint));
        gl!(gl.tex_parameteri(
            texture_target,
            glw::GL_TEXTURE_COMPARE_MODE,
            glw::GL_COMPARE_REF_TO_TEXTURE as GLint
        ));
        gl!(gl.tex_parameteri(texture_target, glw::GL_TEXTURE_COMPARE_FUNC, glw::GL_LESS as GLint));

        // Set border color when "clamp to border" mode is selected
        if tokens.clamp_to_border == state.texture_wrap_mode {
            gl!(gl.tex_parameterfv(texture_target, tokens.texture_border_color, color.as_ptr()));
        }
        glu::expect_no_error(gl, "Failed to set texture parameters")?;

        // Setup texture unit for reference_sampler
        if state.texture_wrap_mode == glw::GL_CLAMP_TO_EDGE {
            gl!(gl.active_texture(glw::GL_TEXTURE1));
            glu::expect_no_error(gl, "glActiveTexture(GL_TEXTURE1) failed")?;

            gl!(gl.bind_texture(texture_target, texture_object_id));
            glu::expect_no_error(gl, "glBindTexture failed")?;

            let mut sampler_object_id: GLuint = 0;
            gl!(gl.gen_samplers(1, &mut sampler_object_id));
            glu::expect_no_error(gl, "Failed to generate sampler")?;

            gl!(gl.bind_sampler(1, sampler_object_id));
            glu::expect_no_error(gl, "Failed to bind sampler to unit 1")?;

            gl!(gl.sampler_parameteri(sampler_object_id, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
            gl!(gl.sampler_parameteri(sampler_object_id, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
            gl!(gl.sampler_parameteri(
                sampler_object_id,
                glw::GL_TEXTURE_WRAP_S,
                tokens.clamp_to_border as GLint
            ));
            gl!(gl.sampler_parameteri(
                sampler_object_id,
                glw::GL_TEXTURE_WRAP_T,
                tokens.clamp_to_border as GLint
            ));
            gl!(gl.sampler_parameteri(
                sampler_object_id,
                glw::GL_TEXTURE_COMPARE_MODE,
                glw::GL_COMPARE_REF_TO_TEXTURE as GLint
            ));
            gl!(gl.sampler_parameteri(sampler_object_id, glw::GL_TEXTURE_COMPARE_FUNC, glw::GL_LESS as GLint));
            gl!(gl.sampler_parameterfv(sampler_object_id, tokens.texture_border_color, color.as_ptr()));
            glu::expect_no_error(gl, "Failed to set sampler parameters")?;

            // Released with the other names; the sampler is unbound from its unit first.
            objects.samplers.push(sampler_object_id);
        }

        Ok(())
    }

    /// `prepareProgramInput`
    fn prepare_program_input(
        &self,
        context: &Context,
        state: &mut State,
        objects: &mut Objects,
        program_object_id: GLuint,
        crand: &mut CRand,
    ) -> Result<(), TestError> {
        let gl = context.gl();

        // Get vertex buffer infos from the case, then the one for the coordinates
        self.prepare_vertex_buffers_data(state, crand);

        let mut vertex_buffer_infos: Vec<VertexBufferInfo> = Vec::new();
        if !self.case.is_offsets_case() {
            vertex_buffer_infos.push(VertexBufferInfo {
                attribute_name: OFFSETS_ATTRIBUTE_NAME,
                n_components: N_OFFSETS_COMPONENTS as GLint,
                type_: glw::GL_INT,
                data: int_bytes(&state.offsets_buffer_data),
            });
        }
        vertex_buffer_infos.push(self.prepare_coordinates(state, crand));

        let n_vertex_buffers = vertex_buffer_infos.len();
        let mut vertex_buffer_ids = vec![0 as GLuint; n_vertex_buffers];

        gl!(gl.gen_buffers(n_vertex_buffers as i32, vertex_buffer_ids.as_mut_ptr()));
        objects.buffers.extend(vertex_buffer_ids.iter().copied());
        glu::expect_no_error(gl, "Failed to create vertex buffers")?;

        // Setup each vertex buffer
        for (vertex_buffer_id, info) in vertex_buffer_ids.iter().zip(&vertex_buffer_infos) {
            let attribute_name = CString::new(info.attribute_name).expect("no nul byte");
            let attribute_location = gl!(gl.get_attrib_location(program_object_id, attribute_name.as_ptr()));
            if attribute_location == -1 || gl!(gl.get_error()) != glw::GL_NO_ERROR {
                return Err(TestError::Fail("Failed to get location of attribute".to_string()));
            }

            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, *vertex_buffer_id));
            gl!(gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                info.data.len() as isize,
                info.data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            ));
            glu::expect_no_error(gl, "Failed to fill vertex buffer with data")?;

            gl!(gl.enable_vertex_attrib_array(attribute_location as GLuint));
            if info.type_ == glw::GL_INT {
                gl!(gl.vertex_attrib_i_pointer(
                    attribute_location as GLuint,
                    info.n_components,
                    info.type_,
                    0,
                    std::ptr::null()
                ));
            } else {
                gl!(gl.vertex_attrib_pointer(
                    attribute_location as GLuint,
                    info.n_components,
                    info.type_,
                    glw::FALSE,
                    0,
                    std::ptr::null()
                ));
            }
            glu::expect_no_error(gl, "Failed to setup vertex attribute arrays")?;
        }

        // Get sampler location
        let sampler_name = CString::new(SAMPLER_UNIFORM_NAME).expect("no nul byte");
        let sampler_location = gl!(gl.get_uniform_location(program_object_id, sampler_name.as_ptr()));
        if sampler_location == -1 || gl!(gl.get_error()) != glw::GL_NO_ERROR {
            return Err(TestError::Fail(
                "Failed to get location of uniform \"sampler\"".to_string(),
            ));
        }

        // Set uniform at sampler location value to index of first texture unit
        gl!(gl.uniform_1i(sampler_location, 0));
        glu::expect_no_error(gl, "Could not set uniform value")?;

        if state.texture_wrap_mode == glw::GL_CLAMP_TO_EDGE {
            let reference_sampler_name = CString::new(REFERENCE_SAMPLER_UNIFORM_NAME).expect("no nul byte");
            let reference_sampler_location =
                gl!(gl.get_uniform_location(program_object_id, reference_sampler_name.as_ptr()));
            if reference_sampler_location == -1 || gl!(gl.get_error()) != glw::GL_NO_ERROR {
                return Err(TestError::Fail(
                    "Failed to get location of uniform \"reference sampler\"".to_string(),
                ));
            }

            // Set uniform at reference_sampler location value to index of second texture unit
            gl!(gl.uniform_1i(reference_sampler_location, 1));
            glu::expect_no_error(gl, "Could not set uniform value")?;
        }

        Ok(())
    }

    fn run(&self, context: &Context, base: &TestCaseBase, objects: &mut Objects) -> TestOutcome {
        let gl = context.gl();
        let mut state = State::default();
        let mut crand = CRand::new(1);

        // initTest: the clamp cases check texture_border_clamp first
        if self.case.uses_clamp_to_border_support() && !base.is_texture_border_clamp_supported {
            return Err(TestError::NotSupported(TEXTURE_BORDER_CLAMP_NOT_SUPPORTED.to_string()));
        }

        // This test should only run if gpu_shader5 is supported
        require_gpu_shader5(base)?;

        // Get minimum and maximum texture gather offsets
        gl!(gl.get_integerv(
            glw::GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET,
            &mut state.min_texture_gather_offset
        ));
        gl!(gl.get_integerv(
            glw::GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET,
            &mut state.max_texture_gather_offset
        ));
        glu::expect_no_error(
            gl,
            "Failed to get value of GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET or GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET",
        )?;

        // Get details for transform feedback and the shaders' code
        let captured_varyings = self.captured_varyings();
        state.n_varyings_per_vertex = captured_varyings.len();
        let transform_feedback_buffer_size =
            N_VERTICES * state.n_varyings_per_vertex * N_COMPONENTS_PER_VARYING * std::mem::size_of::<i32>();
        let vertex_shader_parts = self.vertex_shader_parts(&state);

        // Create program and shaders
        let program_object_id = gl!(gl.create_program());
        let fragment_shader_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        let vertex_shader_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        objects.programs.push(program_object_id);
        objects.shaders.extend([fragment_shader_id, vertex_shader_id]);
        glu::expect_no_error(gl, "Failed to create program or shader object(s)")?;

        // Set up transform feedback
        let varying_names: Vec<CString> = captured_varyings
            .iter()
            .map(|name| CString::new(*name).expect("no nul byte"))
            .collect();
        let varying_pointers: Vec<*const glw::GLchar> = varying_names.iter().map(|name| name.as_ptr()).collect();
        gl!(gl.transform_feedback_varyings(
            program_object_id,
            varying_pointers.len() as i32,
            varying_pointers.as_ptr(),
            glw::GL_INTERLEAVED_ATTRIBS
        ));
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() call failed")?;

        // Build program
        let vertex_shader_part_refs: Vec<&str> = vertex_shader_parts.iter().map(String::as_str).collect();
        let (built, _) = base.build_program(
            context,
            program_object_id,
            &[
                ShaderBody::Source(fragment_shader_id, &[FRAGMENT_SHADER_CODE]),
                ShaderBody::Source(vertex_shader_id, &vertex_shader_part_refs),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Could not create program from valid vertex/geometry/fragment shader".to_string(),
            ));
        }

        // Set program as active
        gl!(gl.use_program(program_object_id));
        glu::expect_no_error(gl, "glUseProgram() call failed")?;

        // Generate and bind VAO
        let mut vertex_array_object_id: GLuint = 0;
        gl!(gl.gen_vertex_arrays(1, &mut vertex_array_object_id));
        objects.vertex_arrays.push(vertex_array_object_id);
        gl!(gl.bind_vertex_array(vertex_array_object_id));
        glu::expect_no_error(gl, "Could not create vertex array object")?;

        // Generate, bind and allocate buffer
        let mut transform_feedback_buffer_object_id: GLuint = 0;
        gl!(gl.gen_buffers(1, &mut transform_feedback_buffer_object_id));
        objects.buffers.push(transform_feedback_buffer_object_id);
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, transform_feedback_buffer_object_id));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            transform_feedback_buffer_size as isize,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "Could not create buffer object")?;

        gl!(gl.bind_buffer_base(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            transform_feedback_buffer_object_id
        ));
        glu::expect_no_error(gl, "glBindBufferBase() call failed")?;

        // Create and fill texture
        self.prepare_texture(context, base, &mut state, objects)?;

        // Let the case prepare its specific input for the program
        self.prepare_program_input(context, &mut state, objects, program_object_id, &mut crand)?;

        // iterate: setup transform feedback
        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glEnable(GL_RASTERIZER_DISCARD) call failed")?;

        gl!(gl.begin_transform_feedback(glw::GL_POINTS));
        glu::expect_no_error(gl, "glBeginTransformFeedback() call failed")?;

        gl!(gl.draw_arrays(glw::GL_POINTS, 0, N_VERTICES as GLint));
        glu::expect_no_error(gl, "glDrawArrays() call failed")?;

        gl!(gl.end_transform_feedback());
        glu::expect_no_error(gl, "glEndTransformFeedback() call failed")?;

        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glDisable(GL_RASTERIZER_DISCARD) call failed")?;

        // Map transform feedback results
        let mapped = gl!(gl.map_buffer_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            transform_feedback_buffer_size as isize,
            glw::GL_MAP_READ_BIT
        ));
        glu::expect_no_error(gl, "Could not map the buffer object into process space")?;
        if mapped.is_null() {
            return Err(TestError::Fail(
                "Could not map the buffer object into process space".to_string(),
            ));
        }
        // SAFETY: `transform_feedback_buffer_size` bytes were mapped for reading; they are copied out before the unmap below.
        let result_data =
            read_ints(unsafe { std::slice::from_raw_parts(mapped.cast::<u8>(), transform_feedback_buffer_size) });

        gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
        glu::expect_no_error(gl, "Error unmapping the buffer object")?;

        // Verify data extracted from transform feedback
        let result = self.verify_result(&state, &result_data)?;

        Ok(if result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestCase for TextureGatherOffset {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        run_case(context, self.ext_params, |context, base, objects| {
            self.run(context, base, objects)
        })
    }
}
