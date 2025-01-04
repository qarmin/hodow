// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcNegativeTextureLookupFunctionsBiasTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shader constants and the `OPS` table are extracted from the C++ by tmp/scripts/gen_negtex_bias.py; only the desktop branch of `init` is carried over (the roots here are desktop core, so `is_gles` is always false), as an op list that replays upstream's mutation of the global GLSL version between `addChild`s.

use crate::glu::{Context, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup};
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

enum Op {
    /// `GL_GLSL_VER = ...`
    GlVersion(&'static str),
    /// `addTest`: a shader with `${gsampler}`/`${gvec4}` placeholders, expanded for sampler, usampler and isampler.
    AddGeneric {
        name: &'static str,
        source: &'static str,
        shadow_lod: bool,
        cube_map_array: bool,
        sparse_texture2: bool,
    },
    /// `addChild(new NegativeTextureLookupFunctionsBiasTest(...))`
    AddDirect {
        name: &'static str,
        source: &'static str,
        shadow_lod: bool,
        cube_map_array: bool,
        sparse_texture2: bool,
    },
}

const TEXTURE_SAMPLER1_D_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}1D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = texture(texSampler, 0.0, bias);\n}\n";
const TEXTURE_SAMPLER1_DSHADOW_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler1DShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    float color = texture(texSampler, vec3(0.0), bias);\n}\n";
const TEXTURE_SAMPLER1_DARRAY_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}1DArray texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = texture(texSampler, vec2(0.0), bias);\n}\n";
const TEXTURE_SAMPLER1_DARRAY_SHADOW_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler1DArrayShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    float color = texture(texSampler, vec3(0.0), bias);\n}\n";
const TEXTURE_PROJ_SAMPLER1_D_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}1D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = textureProj(texSampler, vec2(0.0), bias);\n}\n";
const TEXTURE_PROJ_SAMPLER1_D_VEC4_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}1D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = textureProj(texSampler, vec4(0.0), bias);\n}\n";
const TEXTURE_PROJ_SAMPLER1_DSHADOW_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler1DShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    float color = textureProj(texSampler, vec4(0.0), bias);\n}\n";
const TEXTURE_OFFSET_SAMPLER1_D_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}1D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = textureOffset(texSampler, 0.0, 1, bias);\n}\n";
const TEXTURE_OFFSET_SAMPLER1_DSHADOW_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler1DShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    float color = textureOffset(texSampler, vec3(0.0), 1, bias);\n}\n";
const TEXTURE_OFFSET_SAMPLER1_DARRAY_SHADOW_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler1DArrayShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    float color = textureOffset(texSampler, vec3(0.0), 1, bias);\n}\n";
const TEXTURE_OFFSET_SAMPLER1_DARRAY_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}1DArray texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = textureOffset(texSampler, vec2(0.0), 1, bias);\n}\n";
const TEXTURE_PROJ_OFFSET_SAMPLER1_D_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}1D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = textureProjOffset(texSampler, vec2(0.0), 1, bias);\n}\n";
const TEXTURE_PROJ_OFFSET_SAMPLER1_D_VEC4_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}1D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = textureProjOffset(texSampler, vec4(0.0), 1, bias);\n}\n";
const TEXTURE_PROJ_OFFSET_SAMPLER1_DSHADOW_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler1DShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    float color = textureProjOffset(texSampler, vec4(0.0), 1, bias);\n}\n";
const TEXTURE1_D_SAMPLER1_D_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler1D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    vec4 color = texture1D(texSampler, 1.0, bias);\n}\n";
const TEXTURE1_DPROJ_SAMPLER1_D_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler1D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    vec4 color = texture1DProj(texSampler, vec2(1.0), bias);\n}\n";
const TEXTURE1_DPROJ_SAMPLER1_D_VEC4_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler1D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    vec4 color = texture1DProj(texSampler, vec4(1.0), bias);\n}\n";
const TEXTURE2_D_SAMPLER2_D_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler2D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    vec4 color = texture2D(texSampler, vec2(1.0), bias);\n}\n";
const TEXTURE2_DPROJ_SAMPLER2_D_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler2D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    vec4 color = texture2DProj(texSampler, vec3(1.0), bias);\n}\n";
const TEXTURE2_DPROJ_SAMPLER2_D_VEC4_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler2D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    vec4 color = texture2DProj(texSampler, vec4(1.0), bias);\n}\n";
const TEXTURE3_D_SAMPLER3_D_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler3D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    vec4 color = texture3D(texSampler, vec3(1.0), bias);\n}\n";
const TEXTURE3_DPROJ_SAMPLER3_D_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler3D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    vec4 color = texture3DProj(texSampler, vec4(1.0), bias);\n}\n";
const TEXTURE_CUBE_SAMPLER_CUBE_BIAS_VS: &str = "#version ${VERSION}\nuniform highp samplerCube texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    vec4 color = textureCube(texSampler, vec3(1.0), bias);\n}\n";
const SHADOW1_D_SAMPLER1_DSHADOW_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler1DShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    vec4 color = shadow1D(texSampler, vec3(1.0), bias);\n}\n";
const SHADOW2_D_SAMPLER2_DSHADOW_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler2DShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    vec4 color = shadow2D(texSampler, vec3(1.0), bias);\n}\n";
const SHADOW1_DPROJ_SAMPLER1_DSHADOW_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler1DShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    vec4 color = shadow1DProj(texSampler, vec4(1.0), bias);\n}\n";
const SHADOW2_DPROJ_SAMPLER2_DSHADOW_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler2DShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    vec4 color = shadow2DProj(texSampler, vec4(1.0), bias);\n}\n";
const SPARSE_TEXTURE_ARB_SAMPLER2_D_BIAS_VS: &str = "#version ${VERSION}\n#extension GL_ARB_sparse_texture2: enable\nuniform highp ${gsampler}2D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} texel = ${gvec4}(1.0);\n    int color = sparseTextureARB(texSampler, vec2(1.0), texel, bias);\n}\n";
const SPARSE_TEXTURE_ARB_SAMPLER3_D_BIAS_VS: &str = "#version ${VERSION}\n#extension GL_ARB_sparse_texture2: enable\nuniform highp ${gsampler}3D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} texel = ${gvec4}(1.0);\n    int color = sparseTextureARB(texSampler, vec3(1.0), texel, bias);\n}\n";
const SPARSE_TEXTURE_ARB_SAMPLER_CUBE_BIAS_VS: &str = "#version ${VERSION}\n#extension GL_ARB_sparse_texture2: enable\nuniform highp ${gsampler}Cube texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} texel = ${gvec4}(1.0);\n    int color = sparseTextureARB(texSampler, vec3(1.0), texel, bias);\n}\n";
const SPARSE_TEXTURE_ARB_SAMPLER2_DSHADOW_BIAS_VS: &str = "#version ${VERSION}\n#extension GL_ARB_sparse_texture2: enable\nuniform highp sampler2DShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    float texel = float(1.0);\n    int color = sparseTextureARB(texSampler, vec3(1.0), texel, bias);\n}\n";
const SPARSE_TEXTURE_ARB_SAMPLER_CUBE_SHADOW_BIAS_VS: &str = "#version ${VERSION}\n#extension GL_ARB_sparse_texture2: enable\nuniform highp samplerCubeShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    float texel = float(1.0);\n    int color = sparseTextureARB(texSampler, vec4(1.0), texel, bias);\n}\n";
const SPARSE_TEXTURE_ARB_SAMPLER2_DARRAY_BIAS_VS: &str = "#version ${VERSION}\n#extension GL_ARB_sparse_texture2: enable\nuniform highp ${gsampler}2DArray texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} texel = ${gvec4}(1.0);\n    int color = sparseTextureARB(texSampler, vec3(1.0), texel, bias);\n}\n";
const SPARSE_TEXTURE_ARB_SAMPLER_CUBE_ARRAY_BIAS_VS: &str = "#version ${VERSION}\n#extension GL_ARB_sparse_texture2: enable\nuniform highp ${gsampler}CubeArray texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} texel = ${gvec4}(1.0);\n    int color = sparseTextureARB(texSampler, vec4(1.0), texel, bias);\n}\n";
const SPARSE_TEXTURE_OFFSET_ARB_SAMPLER2_D_BIAS_VS: &str = "#version ${VERSION}\n#extension GL_ARB_sparse_texture2: enable\nuniform highp ${gsampler}2D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} texel = ${gvec4}(1.0);\n    int color = sparseTextureOffsetARB(texSampler, vec2(1.0), ivec2(1), texel, bias);\n}\n";
const SPARSE_TEXTURE_OFFSET_ARB_SAMPLER3_D_BIAS_VS: &str = "#version ${VERSION}\n#extension GL_ARB_sparse_texture2: enable\nuniform highp ${gsampler}3D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} texel = ${gvec4}(1.0);\n    int color = sparseTextureOffsetARB(texSampler, vec3(1.0), ivec3(1), texel, bias);\n}\n";
const SPARSE_TEXTURE_OFFSET_ARB_SAMPLER2_DSHADOW_BIAS_VS: &str = "#version ${VERSION}\n#extension GL_ARB_sparse_texture2: enable\nuniform highp sampler2DShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    float texel = float(1.0);\n    int color = sparseTextureOffsetARB(texSampler, vec3(1.0), ivec2(1), texel, bias);\n}\n";
const SPARSE_TEXTURE_OFFSET_ARB_SAMPLER2_DARRAY_BIAS_VS: &str = "#version ${VERSION}\n#extension GL_ARB_sparse_texture2: enable\nuniform highp ${gsampler}2DArray texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} texel = ${gvec4}(1.0);\n    int color = sparseTextureOffsetARB(texSampler, vec3(1.0), ivec2(1), texel, bias);\n}\n";
const TEXTURE_SAMPLER2_D_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}2D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = texture(texSampler, vec2(0.0), bias);\n}\n";
const TEXTURE_SAMPLER3_D_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}3D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = texture(texSampler, vec3(0.0), bias);\n}\n";
const TEXTURE_SAMPLER_CUBE_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}Cube texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = texture(texSampler, vec3(0.0), bias);\n}\n";
const TEXTURE_SAMPLER2_DSHADOW_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler2DShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    float color = texture(texSampler, vec3(0.0), bias);\n}\n";
const TEXTURE_SAMPLER_CUBE_SHADOW_BIAS_VS: &str = "#version ${VERSION}\nuniform highp samplerCubeShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    float color = texture(texSampler, vec4(0.0), bias);\n}\n";
const TEXTURE_SAMPLER2_DARRAY_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}2DArray texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = texture(texSampler, vec3(0.0), bias);\n}\n";
const TEXTURE_PROJ_SAMPLER2_D_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}2D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = textureProj(texSampler, vec3(0.0), bias);\n}\n";
const TEXTURE_PROJ_SAMPLER2_D_VEC4_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}2D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = textureProj(texSampler, vec4(0.0), bias);\n}\n";
const TEXTURE_PROJ_SAMPLER3_D_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}3D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = textureProj(texSampler, vec4(0.0), bias);\n}\n";
const TEXTURE_PROJ_SAMPLER2_DSHADOW_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler2DShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    float color = textureProj(texSampler, vec4(0.0), bias);\n}\n";
const TEXTURE_OFFSET_SAMPLER2_D_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}2D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = textureOffset(texSampler, vec2(0.0), ivec2(1), bias);\n}\n";
const TEXTURE_OFFSET_SAMPLER3_D_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}3D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = textureOffset(texSampler, vec3(0.0), ivec3(1), bias);\n}\n";
const TEXTURE_OFFSET_SAMPLER2_DSHADOW_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler2DShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    float color = textureOffset(texSampler, vec3(0.0), ivec2(1), bias);\n}\n";
const TEXTURE_OFFSET_SAMPLER2_DARRAY_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}2DArray texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = textureOffset(texSampler, vec3(0.0), ivec2(1), bias);\n}\n";
const TEXTURE_PROJ_OFFSET_SAMPLER2_D_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}2D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = textureProjOffset(texSampler, vec3(0.0), ivec2(1), bias);\n}\n";
const TEXTURE_PROJ_OFFSET_SAMPLER2_D_VEC4_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}2D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = textureProjOffset(texSampler, vec4(0.0), ivec2(1), bias);\n}\n";
const TEXTURE_PROJ_OFFSET_SAMPLER3_D_BIAS_VS: &str = "#version ${VERSION}\nuniform highp ${gsampler}3D texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = textureProjOffset(texSampler, vec4(0.0), ivec3(1), bias);\n}\n";
const TEXTURE_PROJ_OFFSET_SAMPLER2_DSHADOW_BIAS_VS: &str = "#version ${VERSION}\nuniform highp sampler2DShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    float color = textureProjOffset(texSampler, vec4(0.0), ivec2(1), bias);\n}\n";
const TEXTURE_SAMPLER2_DARRAY_SHADOW_BIAS_VS: &str = "#version ${VERSION}\n#extension GL_EXT_texture_shadow_lod: enable\nuniform highp sampler2DArrayShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    float color = texture(texSampler, vec4(0.0), bias);\n}\n";
const TEXTURE_OFFSET_SAMPLER2_DARRAY_SHADOW_BIAS_VS: &str = "#version ${VERSION}\n#extension GL_EXT_texture_shadow_lod: enable\nuniform highp sampler2DArrayShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    float color = textureOffset(texSampler, vec4(0.0), ivec2(1), bias);\n}\n";
const TEXTURE_SAMPLER_CUBE_ARRAY_SHADOW_BIAS_VS: &str = "#version ${VERSION}\n#extension GL_EXT_texture_shadow_lod: enable\n#extension GL_EXT_texture_cube_map_array: enable\nuniform highp samplerCubeArrayShadow texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    float color = texture(texSampler, vec4(0.0), 1.0, bias);\n}\n";
const TEXTURE_SAMPLER_CUBE_ARRAY_BIAS_VS: &str = "#version ${VERSION}\n#extension GL_EXT_texture_cube_map_array: enable\nuniform highp ${gsampler}CubeArray texSampler;\nuniform highp float bias;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    ${gvec4} color = texture(texSampler, vec4(0.0), bias);\n}\n";

const OPS: &[Op] = &[
    Op::AddGeneric {
        name: "texture_sampler1D_bias",
        source: TEXTURE_SAMPLER1_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "texture_sampler1DShadow_bias",
        source: TEXTURE_SAMPLER1_DSHADOW_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddGeneric {
        name: "texture_sampler1DArray_bias",
        source: TEXTURE_SAMPLER1_DARRAY_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "texture_sampler1DArrayShadow_bias",
        source: TEXTURE_SAMPLER1_DARRAY_SHADOW_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddGeneric {
        name: "textureProj_sampler1D_bias",
        source: TEXTURE_PROJ_SAMPLER1_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddGeneric {
        name: "textureProj_sampler1D_vec4_bias",
        source: TEXTURE_PROJ_SAMPLER1_D_VEC4_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "textureProj_sampler1DShadow_bias",
        source: TEXTURE_PROJ_SAMPLER1_DSHADOW_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddGeneric {
        name: "textureOffset_sampler1D_bias",
        source: TEXTURE_OFFSET_SAMPLER1_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "textureOffset_sampler1DShadow_bias",
        source: TEXTURE_OFFSET_SAMPLER1_DSHADOW_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "textureOffset_sampler1DArrayShadow_bias",
        source: TEXTURE_OFFSET_SAMPLER1_DARRAY_SHADOW_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddGeneric {
        name: "textureOffset_sampler1DArray_bias",
        source: TEXTURE_OFFSET_SAMPLER1_DARRAY_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddGeneric {
        name: "textureProjOffset_sampler1D_bias",
        source: TEXTURE_PROJ_OFFSET_SAMPLER1_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddGeneric {
        name: "textureProjOffset_sampler1D_vec4_bias",
        source: TEXTURE_PROJ_OFFSET_SAMPLER1_D_VEC4_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "textureProjOffset_sampler1DShadow_bias",
        source: TEXTURE_PROJ_OFFSET_SAMPLER1_DSHADOW_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::GlVersion("120"),
    Op::AddDirect {
        name: "texture1D_sampler1D_bias",
        source: TEXTURE1_D_SAMPLER1_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "texture1DProj_sampler1D_bias",
        source: TEXTURE1_DPROJ_SAMPLER1_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "texture1DProj_sampler1D_vec4_bias",
        source: TEXTURE1_DPROJ_SAMPLER1_D_VEC4_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "texture2D_sampler2D_bias",
        source: TEXTURE2_D_SAMPLER2_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "texture2DProj_sampler2D_bias",
        source: TEXTURE2_DPROJ_SAMPLER2_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "texture2DProj_sampler2D_vec4_bias",
        source: TEXTURE2_DPROJ_SAMPLER2_D_VEC4_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "texture3D_sampler3D_bias",
        source: TEXTURE3_D_SAMPLER3_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "texture3DProj_sampler3D_bias",
        source: TEXTURE3_DPROJ_SAMPLER3_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "textureCube_samplerCube_bias",
        source: TEXTURE_CUBE_SAMPLER_CUBE_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "shadow1D_sampler1DShadow_bias",
        source: SHADOW1_D_SAMPLER1_DSHADOW_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "shadow2D_sampler2DShadow_bias",
        source: SHADOW2_D_SAMPLER2_DSHADOW_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "shadow1DProj_sampler1DShadow_bias",
        source: SHADOW1_DPROJ_SAMPLER1_DSHADOW_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "shadow2DProj_sampler2DShadow_bias",
        source: SHADOW2_DPROJ_SAMPLER2_DSHADOW_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::GlVersion("400 core"),
    Op::AddGeneric {
        name: "sparseTextureARB_sampler2D_bias",
        source: SPARSE_TEXTURE_ARB_SAMPLER2_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: true,
    },
    Op::AddGeneric {
        name: "sparseTextureARB_sampler3D_bias",
        source: SPARSE_TEXTURE_ARB_SAMPLER3_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: true,
    },
    Op::AddGeneric {
        name: "sparseTextureARB_samplerCube_bias",
        source: SPARSE_TEXTURE_ARB_SAMPLER_CUBE_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: true,
    },
    Op::AddDirect {
        name: "sparseTextureARB_sampler2DShadow_bias",
        source: SPARSE_TEXTURE_ARB_SAMPLER2_DSHADOW_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: true,
    },
    Op::AddDirect {
        name: "sparseTextureARB_samplerCubeShadow_bias",
        source: SPARSE_TEXTURE_ARB_SAMPLER_CUBE_SHADOW_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: true,
    },
    Op::AddGeneric {
        name: "sparseTextureARB_sampler2DArray_bias",
        source: SPARSE_TEXTURE_ARB_SAMPLER2_DARRAY_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: true,
    },
    Op::AddGeneric {
        name: "sparseTextureARB_samplerCubeArray_bias",
        source: SPARSE_TEXTURE_ARB_SAMPLER_CUBE_ARRAY_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: true,
    },
    Op::AddGeneric {
        name: "sparseTextureOffsetARB_sampler2D_bias",
        source: SPARSE_TEXTURE_OFFSET_ARB_SAMPLER2_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: true,
    },
    Op::AddGeneric {
        name: "sparseTextureOffsetARB_sampler3D_bias",
        source: SPARSE_TEXTURE_OFFSET_ARB_SAMPLER3_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: true,
    },
    Op::AddDirect {
        name: "sparseTextureOffsetARB_sampler2DShadow_bias",
        source: SPARSE_TEXTURE_OFFSET_ARB_SAMPLER2_DSHADOW_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: true,
    },
    Op::AddGeneric {
        name: "sparseTextureOffsetARB_sampler2DArray_bias",
        source: SPARSE_TEXTURE_OFFSET_ARB_SAMPLER2_DARRAY_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: true,
    },
    Op::AddGeneric {
        name: "texture_sampler2D_bias",
        source: TEXTURE_SAMPLER2_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddGeneric {
        name: "texture_sampler3D_bias",
        source: TEXTURE_SAMPLER3_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddGeneric {
        name: "texture_samplerCube_bias",
        source: TEXTURE_SAMPLER_CUBE_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "texture_sampler2DShadow_bias",
        source: TEXTURE_SAMPLER2_DSHADOW_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "texture_samplerCubeShadow_bias",
        source: TEXTURE_SAMPLER_CUBE_SHADOW_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddGeneric {
        name: "texture_sampler2DArray_bias",
        source: TEXTURE_SAMPLER2_DARRAY_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddGeneric {
        name: "textureProj_sampler2D_bias",
        source: TEXTURE_PROJ_SAMPLER2_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddGeneric {
        name: "textureProj_sampler2D_vec4_bias",
        source: TEXTURE_PROJ_SAMPLER2_D_VEC4_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddGeneric {
        name: "textureProj_sampler3D_bias",
        source: TEXTURE_PROJ_SAMPLER3_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "textureProj_sampler2DShadow_bias",
        source: TEXTURE_PROJ_SAMPLER2_DSHADOW_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddGeneric {
        name: "textureOffset_sampler2D_bias",
        source: TEXTURE_OFFSET_SAMPLER2_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddGeneric {
        name: "textureOffset_sampler3D_bias",
        source: TEXTURE_OFFSET_SAMPLER3_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "textureOffset_sampler2DShadow_bias",
        source: TEXTURE_OFFSET_SAMPLER2_DSHADOW_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddGeneric {
        name: "textureOffset_sampler2DArray_bias",
        source: TEXTURE_OFFSET_SAMPLER2_DARRAY_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddGeneric {
        name: "textureProjOffset_sampler2D_bias",
        source: TEXTURE_PROJ_OFFSET_SAMPLER2_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddGeneric {
        name: "textureProjOffset_sampler2D_vec4_bias",
        source: TEXTURE_PROJ_OFFSET_SAMPLER2_D_VEC4_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddGeneric {
        name: "textureProjOffset_sampler3D_bias",
        source: TEXTURE_PROJ_OFFSET_SAMPLER3_D_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "textureProjOffset_sampler2DShadow_bias",
        source: TEXTURE_PROJ_OFFSET_SAMPLER2_DSHADOW_BIAS_VS,
        shadow_lod: false,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "texture_sampler2DArrayShadow_bias",
        source: TEXTURE_SAMPLER2_DARRAY_SHADOW_BIAS_VS,
        shadow_lod: true,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "textureOffset_sampler2DArrayShadow_bias",
        source: TEXTURE_OFFSET_SAMPLER2_DARRAY_SHADOW_BIAS_VS,
        shadow_lod: true,
        cube_map_array: false,
        sparse_texture2: false,
    },
    Op::AddDirect {
        name: "texture_samplerCubeArrayShadow_bias",
        source: TEXTURE_SAMPLER_CUBE_ARRAY_SHADOW_BIAS_VS,
        shadow_lod: true,
        cube_map_array: true,
        sparse_texture2: false,
    },
    Op::AddGeneric {
        name: "texture_samplerCubeArray_bias",
        source: TEXTURE_SAMPLER_CUBE_ARRAY_BIAS_VS,
        shadow_lod: false,
        cube_map_array: true,
        sparse_texture2: false,
    },
];

struct NegativeTextureLookupFunctionsBiasTest {
    case_name: String,
    vertex_shader_txt: String,
    texture_shadow_lod_required: bool,
    texture_cube_map_array_required: bool,
    sparse_texture2_required: bool,
}

impl TestCase for NegativeTextureLookupFunctionsBiasTest {
    fn name(&self) -> &str {
        &self.case_name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let info = &context.context_info;

        if self.texture_shadow_lod_required && !info.is_extension_supported("GL_EXT_texture_shadow_lod") {
            return Err(TestError::NotSupported(
                "texture_shadow_lod extension not supported".to_string(),
            ));
        }
        if self.texture_cube_map_array_required && !info.is_extension_supported("GL_ARB_texture_cube_map_array") {
            return Err(TestError::NotSupported(
                "texture_cube_map_array extension not supported".to_string(),
            ));
        }
        if self.sparse_texture2_required && !info.is_extension_supported("GL_ARB_sparse_texture2") {
            return Err(TestError::NotSupported(
                "sparse_texture2 extension not supported".to_string(),
            ));
        }

        // Expecting compile error
        let program = ShaderProgram::new_expecting_build_failure(
            context.gl(),
            &ProgramSources::default().with(ShaderType::Vertex, self.vertex_shader_txt.as_str()),
        );
        let compile_ok = program
            .shader_info
            .iter()
            .any(|(ty, info)| *ty == ShaderType::Vertex && info.ok);

        Ok(if compile_ok {
            TestStatus::fail("Expected vertex shader compilation fail")
        } else {
            TestStatus::pass("Pass")
        })
    }
}

/// `NegativeTextureLookupFunctionsBiasTests::init`
pub fn create_tests() -> TestCaseGroup {
    const SAMPLERS: [&str; 3] = ["sampler", "usampler", "isampler"];
    const VEC_TYPES: [&str; 3] = ["vec4", "uvec4", "ivec4"];

    let mut group = TestCaseGroup::new("negative_texture_lookup_functions_with_bias_tests");
    let mut gl_glsl_ver = "400 core";

    for op in OPS {
        match *op {
            Op::GlVersion(version) => gl_glsl_ver = version,
            Op::AddGeneric {
                name,
                source,
                shadow_lod,
                cube_map_array,
                sparse_texture2,
            } => {
                for (sampler, vec_type) in SAMPLERS.into_iter().zip(VEC_TYPES) {
                    let shader = StringTemplate::new(source)
                        .specialize(&[
                            ("VERSION", gl_glsl_ver.to_string()),
                            ("gsampler", sampler.to_string()),
                            ("gvec4", vec_type.to_string()),
                        ])
                        .expect("every placeholder has a value");

                    group.add_child(Box::new(NegativeTextureLookupFunctionsBiasTest {
                        case_name: name.replacen("sampler", sampler, 1),
                        vertex_shader_txt: shader,
                        texture_shadow_lod_required: shadow_lod,
                        texture_cube_map_array_required: cube_map_array,
                        sparse_texture2_required: sparse_texture2,
                    }) as Box<dyn TestCase>);
                }
            }
            Op::AddDirect {
                name,
                source,
                shadow_lod,
                cube_map_array,
                sparse_texture2,
            } => {
                let shader = StringTemplate::new(source)
                    .specialize(&[("VERSION", gl_glsl_ver.to_string())])
                    .expect("every placeholder has a value");

                group.add_child(Box::new(NegativeTextureLookupFunctionsBiasTest {
                    case_name: name.to_string(),
                    vertex_shader_txt: shader,
                    texture_shadow_lod_required: shadow_lod,
                    texture_cube_map_array_required: cube_map_array,
                    sparse_texture2_required: sparse_texture2,
                }) as Box<dyn TestCase>);
            }
        }
    }

    group
}
