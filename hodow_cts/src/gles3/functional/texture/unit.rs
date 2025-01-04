// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fTextureUnitTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts, following the ES 2.0 port (`gles2::functional::texture::unit`):
// `MultiTexShader` is built once per `render()` from a plain-data `MultiTexSpec`; `init()` is the first half
// of `iterate()`; the per-unit `uniform mat4 u_transN` is declared as four `vec4` columns
// (`u_transN_c0..c3`, `uniform4fv`) assembled with `mat4(...)` in the GLSL; `tcu::Texture2D/Cube/2DArray/3D`
// are plain `TextureLevel`s per (face, level), which is all this test reads out of them. Matrices are
// row-major arrays like upstream's `tcu::Mat3/Mat4(const float*)`. The integer samplers' LOD is computed
// from the texture's base size with the same derivative formula the float `sample_*_quad` helpers use.
// Upstream's cube face-target quirk (`s_cubeFaceTargets` indexed in `tcu::CubeFace` order) is kept.

use super::spec_shaders::sampler_types;
use crate::gls::reference_context_buffers::create_reference_context_rgb8;
use crate::glu::shader_util::DataType;
use crate::glu::texture_util::{get_transfer_format, map_gl_internal_format};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::rr::fragment_packet::FragmentPacket;
use crate::rr::generic_vector::{GenericVec4, GenericVecType};
use crate::rr::shaders::{
    FragmentInputInfo, FragmentOutputInfo, FragmentShader, VertexInputInfo, VertexOutputInfo, VertexShader,
};
use crate::rr::shading_context::{FragmentShadingContext, read_varying, write_fragment_output};
use crate::rr::vertex_attrib::{VertexAttrib, read_vertex_attrib_float};
use crate::rr::vertex_packet::VertexPacket;
use crate::sglr::context::Context as SglrContext;
use crate::sglr::context_util::draw_quad;
use crate::sglr::gl_context::GLContext;
use crate::sglr::reference_context::{
    ResolvedSampler, ResolvedSampler2D, ResolvedSampler2DArray, ResolvedSampler3D, ResolvedSamplerCube,
};
use crate::sglr::shader_program::{ShaderProgram, ShaderProgramBase, pdec};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::{TextureLevel, fill_with_grid, get_texture_format_info};
use crate::tcu::random::de_int32_hash;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::vector::{Vec3, Vec4};
use crate::tcu::{Random, TestError, TestOutcome, TestStatus, TextureFormat};

const VIEWPORT_WIDTH: i32 = 128;
const VIEWPORT_HEIGHT: i32 = 128;

const TEXTURE_WIDTH_2D: i32 = 128;
const TEXTURE_HEIGHT_2D: i32 = 128;

// Cube map texture size is larger in order to make minifications possible - otherwise would need to display different faces at same time.
const TEXTURE_WIDTH_CUBE: i32 = 256;
const TEXTURE_HEIGHT_CUBE: i32 = 256;

const TEXTURE_WIDTH_2D_ARRAY: i32 = 64;
const TEXTURE_HEIGHT_2D_ARRAY: i32 = 64;
const TEXTURE_LAYERS_2D_ARRAY: i32 = 4;

const TEXTURE_WIDTH_3D: i32 = 32;
const TEXTURE_HEIGHT_3D: i32 = 32;
const TEXTURE_DEPTH_3D: i32 = 32;

const GRID_CELL_SIZE: i32 = 8;

const TEST_SIZED_INTERNAL_FORMATS: [GLenum; 49] = [
    glw::GL_RGBA32F,
    glw::GL_RGBA32I,
    glw::GL_RGBA32UI,
    glw::GL_RGBA16F,
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
    glw::GL_RGBA8_SNORM,
    glw::GL_RGB8,
    glw::GL_RGB565,
    glw::GL_R11F_G11F_B10F,
    glw::GL_RGB32F,
    glw::GL_RGB32I,
    glw::GL_RGB32UI,
    glw::GL_RGB16F,
    glw::GL_RGB16I,
    glw::GL_RGB16UI,
    glw::GL_RGB8_SNORM,
    glw::GL_RGB8I,
    glw::GL_RGB8UI,
    glw::GL_SRGB8,
    glw::GL_RGB9_E5,
    glw::GL_RG32F,
    glw::GL_RG32I,
    glw::GL_RG32UI,
    glw::GL_RG16F,
    glw::GL_RG16I,
    glw::GL_RG16UI,
    glw::GL_RG8,
    glw::GL_RG8I,
    glw::GL_RG8UI,
    glw::GL_RG8_SNORM,
    glw::GL_R32F,
    glw::GL_R32I,
    glw::GL_R32UI,
    glw::GL_R16F,
    glw::GL_R16I,
    glw::GL_R16UI,
    glw::GL_R8,
    glw::GL_R8I,
    glw::GL_R8UI,
    glw::GL_R8_SNORM,
];

const TEST_WRAP_MODES: [GLenum; 3] = [glw::GL_CLAMP_TO_EDGE, glw::GL_REPEAT, glw::GL_MIRRORED_REPEAT];

const TEST_MIN_FILTERS: [GLenum; 6] = [
    glw::GL_NEAREST,
    glw::GL_LINEAR,
    glw::GL_NEAREST_MIPMAP_NEAREST,
    glw::GL_LINEAR_MIPMAP_NEAREST,
    glw::GL_NEAREST_MIPMAP_LINEAR,
    glw::GL_LINEAR_MIPMAP_LINEAR,
];

const TEST_NON_MIPMAP_MIN_FILTERS: [GLenum; 2] = [glw::GL_NEAREST, glw::GL_LINEAR];

const TEST_NEAREST_MIN_FILTERS: [GLenum; 2] = [glw::GL_NEAREST, glw::GL_NEAREST_MIPMAP_NEAREST];

const TEST_MAG_FILTERS: [GLenum; 2] = [glw::GL_NEAREST, glw::GL_LINEAR];

/// `s_cubeFaceTargets`; indexed by `tcu::CubeFace` order exactly as upstream does, which pairs -X data with the +X target.
const CUBE_FACE_TARGETS: [GLenum; 6] = [
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
];

/// `glu::isGLInternalColorFormatFilterable`
fn is_gl_internal_color_format_filterable(format: GLenum) -> bool {
    matches!(
        format,
        glw::GL_R8
            | glw::GL_R8_SNORM
            | glw::GL_RG8
            | glw::GL_RG8_SNORM
            | glw::GL_RGB8
            | glw::GL_RGB8_SNORM
            | glw::GL_RGB565
            | glw::GL_RGBA4
            | glw::GL_RGB5_A1
            | glw::GL_RGBA8
            | glw::GL_RGBA8_SNORM
            | glw::GL_RGB10_A2
            | glw::GL_SR8_EXT
            | glw::GL_SRG8_EXT
            | glw::GL_SRGB8
            | glw::GL_SRGB8_ALPHA8
            | glw::GL_R16F
            | glw::GL_RG16F
            | glw::GL_RGB16F
            | glw::GL_RGBA16F
            | glw::GL_R11F_G11F_B10F
            | glw::GL_RGB9_E5
    )
}

fn log2_floor(value: i32) -> i32 {
    31 - (value as u32).leading_zeros() as i32
}

// Row-major matrices.

type Mat3 = [[f32; 3]; 3];
type Mat4 = [[f32; 4]; 4];

fn mat3_mul(a: &Mat3, b: &Mat3) -> Mat3 {
    std::array::from_fn(|r| std::array::from_fn(|c| (0..3).map(|k| a[r][k] * b[k][c]).sum::<f32>()))
}

fn mat4_mul(a: &Mat4, b: &Mat4) -> Mat4 {
    std::array::from_fn(|r| std::array::from_fn(|c| (0..4).map(|k| a[r][k] * b[k][c]).sum::<f32>()))
}

fn mat4_vec(m: &Mat4, v: [f32; 4]) -> [f32; 4] {
    std::array::from_fn(|r| m[r][0] * v[0] + m[r][1] * v[1] + m[r][2] * v[2] + m[r][3] * v[3])
}

fn mat3_scaled(m: &Mat3, s: f32) -> Mat3 {
    std::array::from_fn(|r| std::array::from_fn(|c| m[r][c] * s))
}

fn mat3_from(data: [f32; 9]) -> Mat3 {
    [
        [data[0], data[1], data[2]],
        [data[3], data[4], data[5]],
        [data[6], data[7], data[8]],
    ]
}

fn mat4_from(data: [f32; 16]) -> Mat4 {
    std::array::from_fn(|r| std::array::from_fn(|c| data[r * 4 + c]))
}

/// `matExtend3To4`: 1.0 in the right-down cell, 0.0 in the other new cells.
fn mat_extend_3_to_4(mat: &Mat3) -> Mat4 {
    std::array::from_fn(|r| {
        std::array::from_fn(|c| {
            if r < 3 && c < 3 {
                mat[r][c]
            } else if r == 3 && c == 3 {
                1.0
            } else {
                0.0
            }
        })
    })
}

/// Column `c` of `m`, as `getColumnMajorData()` lays it out.
fn mat4_column(m: &Mat4, c: usize) -> [f32; 4] {
    [m[0][c], m[1][c], m[2][c], m[3][c]]
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    Tex2D,
    Cube,
    Array,
    ThreeD,
}

impl Kind {
    fn gl_target(self) -> GLenum {
        match self {
            Kind::Tex2D => glw::GL_TEXTURE_2D,
            Kind::Cube => glw::GL_TEXTURE_CUBE_MAP,
            Kind::Array => glw::GL_TEXTURE_2D_ARRAY,
            Kind::ThreeD => glw::GL_TEXTURE_3D,
        }
    }
}

/// `glu::getSampler2DType`/`getSamplerCubeType`/`getSampler2DArrayType`/`getSampler3DType`
fn sampler_type_for(kind: Kind, format: TextureFormat) -> DataType {
    let (sampler_2d, sampler_cube) = sampler_types(format);
    match kind {
        Kind::Tex2D => sampler_2d,
        Kind::Cube => sampler_cube,
        Kind::Array => match sampler_2d {
            DataType::IntSampler2D => DataType::IntSampler2DArray,
            DataType::UintSampler2D => DataType::UintSampler2DArray,
            _ => DataType::Sampler2DArray,
        },
        Kind::ThreeD => match sampler_2d {
            DataType::IntSampler2D => DataType::IntSampler3D,
            DataType::UintSampler2D => DataType::UintSampler3D,
            _ => DataType::Sampler3D,
        },
    }
}

fn generate_multi_tex_fragment_shader(unit_kinds: &[Kind], sampler_types: &[DataType]) -> String {
    // The fragment shader calculates the average of a set of textures.
    let num_units = unit_kinds.len();
    let mut samplers_str = String::new();
    let mut matrices_str = String::new();
    let mut scales_str = String::new();
    let mut biases_str = String::new();
    let mut lookups_str = String::new();

    let color_multiplier = format!("(1.0/{num_units}.0)");

    for (ndx, &kind) in unit_kinds.iter().enumerate() {
        let sampler_name = format!("u_sampler{ndx}");
        let transformation_name = format!("u_trans{ndx}");
        let scale_name = format!("u_texScale{ndx}");
        let bias_name = format!("u_texBias{ndx}");

        samplers_str += &format!("uniform highp {} {sampler_name};\n", sampler_types[ndx].name());
        for col in 0..4 {
            matrices_str += &format!("uniform highp vec4 {transformation_name}_c{col};\n");
        }
        scales_str += &format!("uniform highp vec4 {scale_name};\n");
        biases_str += &format!("uniform highp vec4 {bias_name};\n");

        let lookup_coord = format!(
            "mat4({transformation_name}_c0, {transformation_name}_c1, {transformation_name}_c2, {transformation_name}_c3)*vec4(v_coord, 1.0, 1.0)"
        );
        let lookup_coord = if kind == Kind::Tex2D {
            format!("vec2({lookup_coord})")
        } else {
            format!("vec3({lookup_coord})")
        };

        lookups_str += &format!(
            "\tcolor += {color_multiplier}*(vec4(texture({sampler_name}, {lookup_coord}))*{scale_name} + {bias_name});\n"
        );
    }

    format!(
        "#version 300 es\n\
         layout(location = 0) out mediump vec4 o_color;\n\
         {samplers_str}{matrices_str}{scales_str}{biases_str}\
         in highp vec2 v_coord;\n\
         \n\
         void main (void)\n\
         {{\n\
         \x20   mediump vec4 color = vec4(0.0);\n\
         {lookups_str}\
         \x20   o_color = color;\n\
         }}\n"
    )
}

fn generate_shader_program_declaration(
    unit_kinds: &[Kind],
    sampler_types: &[DataType],
) -> pdec::ShaderProgramDeclaration {
    let mut decl = pdec::ShaderProgramDeclaration::new()
        .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
        .vertex_attribute(pdec::VertexAttribute::new("a_coord", GenericVecType::Float))
        .vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float))
        .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float));

    for ndx in 0..unit_kinds.len() {
        decl = decl.uniform(pdec::Uniform::new(format!("u_sampler{ndx}"), sampler_types[ndx]));
        for col in 0..4 {
            decl = decl.uniform(pdec::Uniform::new(format!("u_trans{ndx}_c{col}"), DataType::FloatVec4));
        }
        decl = decl.uniform(pdec::Uniform::new(format!("u_texScale{ndx}"), DataType::FloatVec4));
        decl = decl.uniform(pdec::Uniform::new(format!("u_texBias{ndx}"), DataType::FloatVec4));
    }

    decl.vertex_source(
        "#version 300 es\n\
         in highp vec4 a_position;\n\
         in highp vec2 a_coord;\n\
         out highp vec2 v_coord;\n\
         \n\
         void main (void)\n\
         {\n\
         \x20   gl_Position = a_position;\n\
         \x20   v_coord = a_coord;\n\
         }\n"
        .to_string(),
    )
    .fragment_source(generate_multi_tex_fragment_shader(unit_kinds, sampler_types))
}

/// Parts of the lod derivates, one `(d/dx, d/dy)` pair per texture axis.
type LodDerivateParts = [[f32; 2]; 3];

/// Calculates values that will be used in `calculate_lod_max`/`min`.
fn calculate_lod_derivate_parts(transformation: &Mat4) -> LodDerivateParts {
    // Calculate transformed coordinates of three screen corners.
    let trans00 = mat4_vec(transformation, [0.0, 0.0, 1.0, 1.0]);
    let trans01 = mat4_vec(transformation, [0.0, 1.0, 1.0, 1.0]);
    let trans10 = mat4_vec(transformation, [1.0, 0.0, 1.0, 1.0]);

    std::array::from_fn(|axis| [trans10[axis] - trans00[axis], trans01[axis] - trans00[axis]])
}

fn lod_terms(parts: &LodDerivateParts, texture_size: [i32; 3], screen_derivate: (f32, f32)) -> (f32, f32, f32) {
    let term = |axis: usize| {
        let ddx = parts[axis][0] * texture_size[axis] as f32 * screen_derivate.0;
        let ddy = parts[axis][1] * texture_size[axis] as f32 * screen_derivate.1;
        ddx.abs().max(ddy.abs())
    };
    (term(0), term(1), term(2))
}

/// Calculates the maximum allowed lod from derivates
fn calculate_lod_max(parts: &LodDerivateParts, texture_size: [i32; 3], screen_derivate: (f32, f32)) -> f32 {
    let (mu, mv, mw) = lod_terms(parts, texture_size, screen_derivate);
    (mu + mv + mw).log2()
}

/// Calculates the minimum allowed lod from derivates
fn calculate_lod_min(parts: &LodDerivateParts, texture_size: [i32; 3], screen_derivate: (f32, f32)) -> f32 {
    let (mu, mv, mw) = lod_terms(parts, texture_size, screen_derivate);
    mu.max(mv.max(mw)).log2()
}

/// What `MultiTexShader`'s constructor generates; the shader itself is built from it for each context.
#[derive(Clone)]
struct MultiTexSpec {
    unit_kinds: Vec<Kind>,
    sampler_types: Vec<DataType>,
    tex_scales: Vec<[f32; 4]>,
    tex_biases: Vec<[f32; 4]>,
    /// Base level size of each unit's texture, `[w, h, depth]` (depth is 0 for everything but 3D, as in `texSizes`).
    sizes: Vec<[i32; 3]>,
    transformations: Vec<Mat4>,
    lod_derivate_parts: Vec<LodDerivateParts>,
}

impl MultiTexSpec {
    /// `MultiTexShader::MultiTexShader`
    fn new(
        rand_seed: u32,
        unit_kinds: Vec<Kind>,
        sampler_types: Vec<DataType>,
        tex_scales: Vec<[f32; 4]>,
        tex_biases: Vec<[f32; 4]>,
        sizes: Vec<[i32; 3]>,
        num_2d_array_layers: &[i32],
    ) -> Self {
        // 2d-to-cube-face transformations.
        // 2d coordinates range from 0 to 1 and cube face coordinates from -1 to 1, so scaling is done as well.
        const CUBE_TRANSFORMS: [[f32; 9]; 6] = [
            // Face -X: (x, y, 1) -> (-1, -(2*y-1), +(2*x-1))
            [0.0, 0.0, -1.0, 0.0, -2.0, 1.0, 2.0, 0.0, -1.0],
            // Face +X: (x, y, 1) -> (+1, -(2*y-1), -(2*x-1))
            [0.0, 0.0, 1.0, 0.0, -2.0, 1.0, -2.0, 0.0, 1.0],
            // Face -Y: (x, y, 1) -> (+(2*x-1), -1, -(2*y-1))
            [2.0, 0.0, -1.0, 0.0, 0.0, -1.0, 0.0, -2.0, 1.0],
            // Face +Y: (x, y, 1) -> (+(2*x-1), +1, +(2*y-1))
            [2.0, 0.0, -1.0, 0.0, 0.0, 1.0, 0.0, 2.0, -1.0],
            // Face -Z: (x, y, 1) -> (-(2*x-1), -(2*y-1), -1)
            [-2.0, 0.0, 1.0, 0.0, -2.0, 1.0, 0.0, 0.0, -1.0],
            // Face +Z: (x, y, 1) -> (+(2*x-1), -(2*y-1), +1)
            [2.0, 0.0, -1.0, 0.0, -2.0, 1.0, 0.0, 0.0, 1.0],
        ];

        // Generate transformation matrices.
        let mut rnd = Random::new(rand_seed);
        let num_units = unit_kinds.len();
        let mut transformations = Vec::with_capacity(num_units);
        let mut lod_derivate_parts = Vec::with_capacity(num_units);
        let mut tex_2d_array_ndx = 0usize; // Keep track of 2d texture array index.

        for &kind in &unit_kinds {
            match kind {
                Kind::Tex2D => {
                    let rot_angle = rnd.get_float_range(0.0, 2.0 * std::f32::consts::PI);
                    let x_scale_factor = rnd.get_float_range(0.7, 1.5);
                    let y_scale_factor = rnd.get_float_range(0.7, 1.5);
                    let x_shear_amount = rnd.get_float_range(0.0, 0.5);
                    let y_shear_amount = rnd.get_float_range(0.0, 0.5);
                    let x_translation_amount = rnd.get_float_range(-0.5, 0.5);
                    let y_translation_amount = rnd.get_float_range(-0.5, 0.5);

                    // For temporarily centering the coordinates to get nicer transformations.
                    let temp_offset = mat3_from([1.0, 0.0, -0.5, 0.0, 1.0, -0.5, 0.0, 0.0, 1.0]);
                    let rot_transf = mat3_from([
                        rot_angle.cos(),
                        -rot_angle.sin(),
                        0.0,
                        rot_angle.sin(),
                        rot_angle.cos(),
                        0.0,
                        0.0,
                        0.0,
                        1.0,
                    ]);
                    let scale_transf = mat3_from([x_scale_factor, 0.0, 0.0, 0.0, y_scale_factor, 0.0, 0.0, 0.0, 1.0]);
                    let x_shear_transf = mat3_from([1.0, x_shear_amount, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0]);
                    let y_shear_transf = mat3_from([1.0, 0.0, 0.0, y_shear_amount, 1.0, 0.0, 0.0, 0.0, 1.0]);
                    let translation_transf = mat3_from([
                        1.0,
                        0.0,
                        x_translation_amount,
                        0.0,
                        1.0,
                        y_translation_amount,
                        0.0,
                        0.0,
                        1.0,
                    ]);

                    // `Mat3(tempOffsetData) * (-1.0f)` scales every element, the diagonal included.
                    let neg_temp_offset = mat3_scaled(&temp_offset, -1.0);
                    let mut product = mat3_mul(&temp_offset, &translation_transf);
                    for next in [
                        &rot_transf,
                        &scale_transf,
                        &x_shear_transf,
                        &y_shear_transf,
                        &neg_temp_offset,
                    ] {
                        product = mat3_mul(&product, next);
                    }
                    let transformation = mat_extend_3_to_4(&product);

                    lod_derivate_parts.push(calculate_lod_derivate_parts(&transformation));
                    transformations.push(transformation);
                }
                Kind::Cube => {
                    // In case of a cube map, we only want to render one face, so the transformation needs to be restricted - only enlarging scaling is done.
                    let mut planar_trans_data = [0.0f32; 9];
                    for (i, cell) in planar_trans_data.iter_mut().enumerate() {
                        *cell = if i == 0 || i == 4 {
                            rnd.get_float_range(0.1, 0.9) // Two first diagonal cells control the scaling.
                        } else if i == 8 {
                            1.0
                        } else {
                            0.0
                        };
                    }

                    let face_ndx = rnd.get_int(0, 5) as usize;
                    let planar_trans = mat3_from(planar_trans_data); // Planar, face-agnostic transformation.
                    // Final transformation from planar to cube map coordinates, including the transformation just generated.
                    let final_trans =
                        mat_extend_3_to_4(&mat3_mul(&mat3_from(CUBE_TRANSFORMS[face_ndx]), &planar_trans));
                    let planar_trans_4x4 = mat_extend_3_to_4(&planar_trans);

                    lod_derivate_parts.push(calculate_lod_derivate_parts(&planar_trans_4x4));
                    transformations.push(final_trans);
                }
                Kind::Array | Kind::ThreeD => {
                    let mut trans_data = [0.0f32; 16];
                    for cell in trans_data.iter_mut() {
                        let sign = if rnd.get_bool() { 1.0 } else { -1.0 };
                        *cell = rnd.get_float_range(0.7, 1.4) * sign;
                    }

                    let mut transformation = mat4_from(trans_data);

                    if kind == Kind::Array {
                        // Z direction: Translate by 0.5 and scale by layer amount.
                        let num_layers = num_2d_array_layers[tex_2d_array_ndx] as f32;

                        let z_translation_transf = mat4_from([
                            1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.5, 0.0, 0.0, 0.0, 1.0,
                        ]);
                        let z_scale_transf = mat4_from([
                            1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, num_layers, 0.0, 0.0, 0.0, 0.0, 1.0,
                        ]);

                        transformation = mat4_mul(&mat4_mul(&transformation, &z_scale_transf), &z_translation_transf);

                        tex_2d_array_ndx += 1;
                    }

                    lod_derivate_parts.push(calculate_lod_derivate_parts(&transformation));
                    transformations.push(transformation);
                }
            }
        }

        Self {
            unit_kinds,
            sampler_types,
            tex_scales,
            tex_biases,
            sizes,
            transformations,
            lod_derivate_parts,
        }
    }

    /// `MultiTexShader::makeSafeLods` - modifies texture coordinates so that LODs aren't too close to x.5 or 0.0.
    fn make_safe_lods(&mut self, viewport_size: (i32, i32)) {
        let shrink_scale_mat_2d = mat_extend_3_to_4(&mat3_from([0.95, 0.0, 0.0, 0.0, 0.95, 0.0, 0.0, 0.0, 1.0]));
        let shrink_scale_mat_3d = mat_extend_3_to_4(&mat3_from([0.95, 0.0, 0.0, 0.0, 0.95, 0.0, 0.0, 0.0, 0.95]));
        let screen_derivate = (1.0 / viewport_size.0 as f32, 1.0 / viewport_size.1 as f32);

        for unit_ndx in 0..self.unit_kinds.len() {
            // As long as LOD is too close to 0.0 or is positive and too close to a something-and-a-half (0.5, 1.5, 2.5 etc) or allowed lod range could round to different levels, zoom in a little to get a safer LOD.
            loop {
                let threshold = 0.1f32;
                let epsilon = 0.01f32;

                let lod_max = calculate_lod_max(
                    &self.lod_derivate_parts[unit_ndx],
                    self.sizes[unit_ndx],
                    screen_derivate,
                );
                let lod_min = calculate_lod_min(
                    &self.lod_derivate_parts[unit_ndx],
                    self.sizes[unit_ndx],
                    screen_derivate,
                );

                let max_level = if lod_max + epsilon < 0.5 {
                    0
                } else {
                    (lod_max + epsilon + 0.5).ceil() as i32 - 1
                };
                let min_level = if lod_min - epsilon < 0.5 {
                    0
                } else {
                    (lod_min - epsilon + 0.5).ceil() as i32 - 1
                };

                let frac = |v: f32| v - v.floor();
                if lod_max.abs() < threshold
                    || (lod_max > 0.0 && (frac(lod_max) - 0.5).abs() < threshold)
                    || lod_min.abs() < threshold
                    || (lod_min > 0.0 && (frac(lod_min) - 0.5).abs() < threshold)
                    || max_level != min_level
                {
                    let shrink = if self.unit_kinds[unit_ndx] == Kind::ThreeD {
                        &shrink_scale_mat_3d
                    } else {
                        &shrink_scale_mat_2d
                    };
                    self.transformations[unit_ndx] = mat4_mul(shrink, &self.transformations[unit_ndx]);
                    self.lod_derivate_parts[unit_ndx] = calculate_lod_derivate_parts(&self.transformations[unit_ndx]);
                } else {
                    break;
                }
            }
        }
    }

    /// `MultiTexShader::setUniforms`
    fn set_uniforms(&self, ctx: &mut dyn SglrContext, program: u32) {
        ctx.use_program(program);

        // Sampler and matrix uniforms.
        for ndx in 0..self.unit_kinds.len() {
            let sampler_loc = ctx.get_uniform_location(program, &format!("u_sampler{ndx}"));
            ctx.uniform1i(sampler_loc, ndx as i32);
            for col in 0..4 {
                let loc = ctx.get_uniform_location(program, &format!("u_trans{ndx}_c{col}"));
                ctx.uniform4fv(loc, 1, &mat4_column(&self.transformations[ndx], col));
            }
            let scale_loc = ctx.get_uniform_location(program, &format!("u_texScale{ndx}"));
            ctx.uniform4fv(scale_loc, 1, &self.tex_scales[ndx]);
            let bias_loc = ctx.get_uniform_location(program, &format!("u_texBias{ndx}"));
            ctx.uniform4fv(bias_loc, 1, &self.tex_biases[ndx]);
        }
    }
}

enum UnitSampler {
    Unbound,
    Tex2D(ResolvedSampler2D),
    Cube(ResolvedSamplerCube),
    Array(ResolvedSampler2DArray),
    ThreeD(ResolvedSampler3D),
}

struct MultiTexShader {
    base: ShaderProgramBase,
    spec: MultiTexSpec,
    samplers: Vec<UnitSampler>,
}

impl MultiTexShader {
    fn new(spec: &MultiTexSpec) -> Self {
        let base = ShaderProgramBase::new(&generate_shader_program_declaration(
            &spec.unit_kinds,
            &spec.sampler_types,
        ));
        let samplers = spec.unit_kinds.iter().map(|_| UnitSampler::Unbound).collect();
        Self {
            base,
            spec: spec.clone(),
            samplers,
        }
    }

    /// One fragment's lookup into unit `unit` at transformed coordinate `c`, with the quad's derivatives `dx`/`dy`.
    fn sample_unit(&self, unit: usize, c: [f32; 3], dx: [f32; 3], dy: [f32; 3]) -> [f32; 4] {
        let sampler_type = self.spec.sampler_types[unit];
        let is_int = matches!(
            sampler_type,
            DataType::IntSampler2D | DataType::IntSamplerCube | DataType::IntSampler2DArray | DataType::IntSampler3D
        );
        let is_uint = matches!(
            sampler_type,
            DataType::UintSampler2D
                | DataType::UintSamplerCube
                | DataType::UintSampler2DArray
                | DataType::UintSampler3D
        );
        let size = self.spec.sizes[unit];
        let to_f32_i = |v: [i32; 4]| v.map(|x| x as f32);
        let to_f32_u = |v: [u32; 4]| v.map(|x| x as f32);

        let (mu, mv, mw) = (
            dx[0].abs().max(dy[0].abs()),
            dx[1].abs().max(dy[1].abs()),
            dx[2].abs().max(dy[2].abs()),
        );
        let (w, h, d) = (size[0] as f32, size[1] as f32, size[2] as f32);

        match &self.samplers[unit] {
            UnitSampler::Tex2D(sampler) => {
                if is_int || is_uint {
                    let lod = (mu * w).max(mv * h).log2();
                    if is_int {
                        to_f32_i(sampler.sample_int(c[0], c[1], lod))
                    } else {
                        to_f32_u(sampler.sample_uint(c[0], c[1], lod))
                    }
                } else {
                    sampler.sample_2d_quad(c[0], c[1], (dx[0], dx[1]), (dy[0], dy[1]))
                }
            }
            UnitSampler::Cube(sampler) => {
                if is_int || is_uint {
                    let lod = (mu.max(mv).max(mw) * w.max(h)).log2();
                    if is_int {
                        to_f32_i(sampler.sample_int(c[0], c[1], c[2], lod))
                    } else {
                        to_f32_u(sampler.sample_uint(c[0], c[1], c[2], lod))
                    }
                } else {
                    sampler.sample_cube_quad(c[0], c[1], c[2], (dx[0], dx[1], dx[2]), (dy[0], dy[1], dy[2]))
                }
            }
            UnitSampler::Array(sampler) => {
                if is_int || is_uint {
                    let lod = (mu * w).max(mv * h).log2();
                    if is_int {
                        to_f32_i(sampler.sample_int(c[0], c[1], c[2], lod))
                    } else {
                        to_f32_u(sampler.sample_uint(c[0], c[1], c[2], lod))
                    }
                } else {
                    sampler.sample_2d_array_quad(c[0], c[1], c[2], (dx[0], dx[1]), (dy[0], dy[1]))
                }
            }
            UnitSampler::ThreeD(sampler) => {
                if is_int || is_uint {
                    let lod = (mu * w).max(mv * h).max(mw * d).log2();
                    if is_int {
                        to_f32_i(sampler.sample_int(c[0], c[1], c[2], lod))
                    } else {
                        to_f32_u(sampler.sample_uint(c[0], c[1], c[2], lod))
                    }
                } else {
                    sampler.sample_3d_quad(c[0], c[1], c[2], (dx[0], dx[1], dx[2]), (dy[0], dy[1], dy[2]))
                }
            }
            UnitSampler::Unbound => [0.0; 4],
        }
    }
}

impl VertexShader for MultiTexShader {
    fn inputs(&self) -> &[VertexInputInfo] {
        self.base.vertex_inputs()
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        self.base.vertex_outputs()
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        for packet in packets.iter_mut() {
            let mut position = Vec4::splat(0.0);
            let mut coord = Vec4::splat(0.0);
            // SAFETY: the attributes were bound by `draw_quad` before the draw call.
            unsafe {
                read_vertex_attrib_float(&mut position, &inputs[0], packet.instance_ndx, packet.vertex_ndx, 0);
                read_vertex_attrib_float(&mut coord, &inputs[1], packet.instance_ndx, packet.vertex_ndx, 0);
            }
            packet.position = position;
            packet.outputs[0] = GenericVec4::from_float(coord);
        }
    }
}

impl FragmentShader for MultiTexShader {
    fn inputs(&self) -> &[FragmentInputInfo] {
        self.base.fragment_inputs()
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        self.base.fragment_outputs()
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        let num_units = self.spec.unit_kinds.len();
        let color_multiplier = 1.0 / num_units as f32;

        for packet_ndx in 0..packets.len() {
            let mut out_colors = [[0.0f32; 4]; 4];

            // Read tex coords
            let tex_coords: [[f32; 2]; 4] = std::array::from_fn(|frag_ndx| {
                // SAFETY: the context was set up by the renderer for exactly these packets.
                let coord = unsafe { read_varying(&packets[packet_ndx], context, 0, frag_ndx) };
                [coord.x(), coord.y()]
            });

            for unit_ndx in 0..num_units {
                let transformation = &self.spec.transformations[unit_ndx];
                // Transform
                let coords_3d: [[f32; 3]; 4] = std::array::from_fn(|f| {
                    let t = mat4_vec(transformation, [tex_coords[f][0], tex_coords[f][1], 1.0, 1.0]);
                    [t[0], t[1], t[2]]
                });

                for frag_ndx in 0..4usize {
                    // Fragment ndx = x + 2 * y within the quad.
                    let (dx_other, dy_other) = (frag_ndx ^ 1, frag_ndx ^ 2);
                    let dfdx: [f32; 3] = std::array::from_fn(|c| coords_3d[frag_ndx][c] - coords_3d[dx_other][c]);
                    let dfdy: [f32; 3] = std::array::from_fn(|c| coords_3d[frag_ndx][c] - coords_3d[dy_other][c]);

                    let sample = self.sample_unit(unit_ndx, coords_3d[frag_ndx], dfdx, dfdy);

                    // Add to sum
                    for c in 0..4 {
                        out_colors[frag_ndx][c] += color_multiplier
                            * (sample[c] * self.spec.tex_scales[unit_ndx][c] + self.spec.tex_biases[unit_ndx][c]);
                    }
                }
            }

            // output
            for (frag_ndx, c) in out_colors.iter().enumerate() {
                // SAFETY: as above.
                unsafe {
                    write_fragment_output(
                        context,
                        packet_ndx as i32,
                        frag_ndx as i32,
                        0,
                        GenericVec4::from_float(Vec4::new(c[0], c[1], c[2], c[3])),
                    )
                };
            }
        }
    }
}

impl ShaderProgram for MultiTexShader {
    fn program_base(&self) -> &ShaderProgramBase {
        &self.base
    }

    fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
        &mut self.base
    }

    fn bind_samplers(&mut self, resolved: &[(String, Option<ResolvedSampler>)]) {
        for (name, sampler) in resolved {
            for ndx in 0..self.samplers.len() {
                if *name == format!("u_sampler{ndx}") {
                    self.samplers[ndx] = match sampler {
                        Some(s) => match self.spec.unit_kinds[ndx] {
                            Kind::Tex2D => s
                                .as_2d()
                                .map_or(UnitSampler::Unbound, |v| UnitSampler::Tex2D(v.clone())),
                            Kind::Cube => s
                                .as_cube()
                                .map_or(UnitSampler::Unbound, |v| UnitSampler::Cube(v.clone())),
                            Kind::Array => s
                                .as_2d_array()
                                .map_or(UnitSampler::Unbound, |v| UnitSampler::Array(v.clone())),
                            Kind::ThreeD => s
                                .as_3d()
                                .map_or(UnitSampler::Unbound, |v| UnitSampler::ThreeD(v.clone())),
                        },
                        None => UnitSampler::Unbound,
                    };
                }
            }
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum CaseType {
    Only2d,
    OnlyCube,
    Only2dArray,
    Only3d,
    Mixed,
}

struct TextureParameters {
    internal_format: GLenum,
    wrap_mode_s: GLenum,
    wrap_mode_t: GLenum,
    wrap_mode_r: GLenum,
    min_filter: GLenum,
    mag_filter: GLenum,
}

struct UnitCaseTexture {
    kind: Kind,
    /// Base level size; the third entry is the layer count of an array and the depth of a 3D texture, 1 otherwise.
    size: [i32; 3],
    params: TextureParameters,
    tex_format: TextureFormat,
    transfer_format: GLenum,
    transfer_type: GLenum,
    /// `[face][level]`; one face except for a cube map's six.
    levels: Vec<Vec<TextureLevel>>,
}

struct TextureUnitCase {
    name: String,
    /// If non-positive, use all units.
    num_units_param: i32,
    case_type: CaseType,
    rand_seed: u32,
}

/// `TextureUnitCase::init`'s result.
struct CaseData {
    num_units: i32,
    textures: Vec<UnitCaseTexture>,
    /// Which texture is used in a particular unit.
    unit_textures: Vec<usize>,
    spec: MultiTexSpec,
}

impl TextureUnitCase {
    /// `TextureUnitCase::init`
    fn init(&self, context: &Context) -> Result<CaseData, TestError> {
        let num_units = if self.num_units_param > 0 {
            self.num_units_param
        } else {
            context
                .context_info
                .get_int(context.gl(), glw::GL_MAX_TEXTURE_IMAGE_UNITS)
        };

        // Make the textures.
        let mut rnd = Random::new(self.rand_seed);

        // Needed in addition to num_units since same texture may be bound to many texture units.
        let num_textures = if rnd.get_float() < 0.7 {
            num_units // In most cases use one unit per texture.
        } else {
            rnd.get_int((num_units - 2).max(1), num_units) // Sometimes assign same texture to multiple units.
        };

        let mut textures = Vec::with_capacity(num_textures as usize);

        // Generate textures.
        for _ in 0..num_textures {
            // Either fixed or randomized target types, and randomized parameters for every texture.
            let tex_type = if self.case_type == CaseType::Mixed {
                rnd.get_int(0, CaseType::Mixed as i32 - 1)
            } else {
                self.case_type as i32
            };
            let kind = match tex_type {
                0 => Kind::Tex2D,
                1 => Kind::Cube,
                2 => Kind::Array,
                _ => Kind::ThreeD,
            };

            let (tex_width, tex_height) = match kind {
                Kind::Tex2D => (TEXTURE_WIDTH_2D, TEXTURE_HEIGHT_2D),
                Kind::Cube => (TEXTURE_WIDTH_CUBE, TEXTURE_HEIGHT_CUBE),
                Kind::Array => (TEXTURE_WIDTH_2D_ARRAY, TEXTURE_HEIGHT_2D_ARRAY),
                Kind::ThreeD => (TEXTURE_WIDTH_3D, TEXTURE_HEIGHT_3D),
            };
            let tex_depth = if kind == Kind::ThreeD { TEXTURE_DEPTH_3D } else { 1 };
            let tex_layers = if kind == Kind::Array {
                TEXTURE_LAYERS_2D_ARRAY
            } else {
                1
            };

            let mipmaps = (tex_width as u32).is_power_of_two()
                && (tex_height as u32).is_power_of_two()
                && (tex_depth as u32).is_power_of_two();
            let num_levels = if mipmaps {
                log2_floor(tex_width.max(tex_height).max(tex_depth)) + 1
            } else {
                1
            };

            let internal_format =
                TEST_SIZED_INTERNAL_FORMATS[rnd.get_int(0, TEST_SIZED_INTERNAL_FORMATS.len() as i32 - 1) as usize];
            let is_filterable = is_gl_internal_color_format_filterable(internal_format);

            let wrap_mode_s = TEST_WRAP_MODES[rnd.get_int(0, TEST_WRAP_MODES.len() as i32 - 1) as usize];
            let wrap_mode_t = TEST_WRAP_MODES[rnd.get_int(0, TEST_WRAP_MODES.len() as i32 - 1) as usize];
            let wrap_mode_r = TEST_WRAP_MODES[rnd.get_int(0, TEST_WRAP_MODES.len() as i32 - 1) as usize];

            let mag_filter = if is_filterable {
                TEST_MAG_FILTERS[rnd.get_int(0, TEST_MAG_FILTERS.len() as i32 - 1) as usize]
            } else {
                glw::GL_NEAREST
            };

            let min_filter = if mipmaps {
                if is_filterable {
                    TEST_MIN_FILTERS[rnd.get_int(0, TEST_MIN_FILTERS.len() as i32 - 1) as usize]
                } else {
                    TEST_NEAREST_MIN_FILTERS[rnd.get_int(0, TEST_NEAREST_MIN_FILTERS.len() as i32 - 1) as usize]
                }
            } else if is_filterable {
                TEST_NON_MIPMAP_MIN_FILTERS[rnd.get_int(0, TEST_NON_MIPMAP_MIN_FILTERS.len() as i32 - 1) as usize]
            } else {
                glw::GL_NEAREST
            };

            // Create new texture.
            let tex_format = map_gl_internal_format(internal_format)
                .ok_or_else(|| TestError::Fail(format!("unsupported sized internal format {internal_format:#x}")))?;
            let transfer = get_transfer_format(tex_format)?;
            let fmt_info = get_texture_format_info(tex_format);
            let c_bias = fmt_info.value_min;
            let c_scale: [f32; 4] = std::array::from_fn(|c| fmt_info.value_max[c] - fmt_info.value_min[c]);

            // Fill with grid texture.
            let num_faces = if kind == Kind::Cube { 6 } else { 1 };
            let mut levels = Vec::with_capacity(num_faces);

            for _ in 0..num_faces {
                let rgb = rnd.get_uint32() & 0x00ff_ffff;
                let alpha = 0xff00_0000u32;

                let color_a = alpha | rgb;
                let color_b = alpha | ((!rgb) & 0x00ff_ffff);
                let vec_a = RGBA::from_packed(color_a).to_vec().m_data;
                let vec_b = RGBA::from_packed(color_b).to_vec().m_data;
                let grid_a: [f32; 4] = std::array::from_fn(|c| vec_a[c] * c_scale[c] + c_bias[c]);
                let grid_b: [f32; 4] = std::array::from_fn(|c| vec_b[c] * c_scale[c] + c_bias[c]);

                let mut face_levels = Vec::with_capacity(num_levels as usize);
                for level_ndx in 0..num_levels {
                    let level_w = (tex_width >> level_ndx).max(1);
                    let level_h = (tex_height >> level_ndx).max(1);
                    let level_d = match kind {
                        Kind::ThreeD => (tex_depth >> level_ndx).max(1),
                        Kind::Array => tex_layers,
                        _ => 1,
                    };
                    let cur_cell_size = (GRID_CELL_SIZE >> level_ndx).max(1); // Scale grid cell size for mipmaps.

                    let mut level = TextureLevel::new(tex_format, level_w as u32, level_h as u32, level_d as u32)?;
                    fill_with_grid(&mut level.get_access(), cur_cell_size as u32, grid_a, grid_b);
                    face_levels.push(level);
                }
                levels.push(face_levels);
            }

            let size_z = match kind {
                Kind::ThreeD => tex_depth,
                Kind::Array => tex_layers,
                _ => 1,
            };
            textures.push(UnitCaseTexture {
                kind,
                size: [tex_width, tex_height, size_z],
                params: TextureParameters {
                    internal_format,
                    wrap_mode_s,
                    wrap_mode_t,
                    wrap_mode_r,
                    min_filter,
                    mag_filter,
                },
                tex_format,
                transfer_format: transfer.format,
                transfer_type: transfer.data_type,
                levels,
            });
        }

        // Assign a texture index to each unit.
        let mut unit_textures: Vec<usize> = Vec::with_capacity(num_units as usize);

        // Every texture is used at least once.
        for i in 0..num_textures as usize {
            unit_textures.push(i);
        }

        // Assign a random texture to remaining units.
        while (unit_textures.len() as i32) < num_units {
            unit_textures.push(rnd.get_int(0, num_textures - 1) as usize);
        }

        rnd.shuffle(&mut unit_textures);

        // Generate information for shader.
        let mut unit_kinds = Vec::with_capacity(num_units as usize);
        let mut tex_scales = Vec::with_capacity(num_units as usize);
        let mut tex_biases = Vec::with_capacity(num_units as usize);
        let mut sampler_types_per_unit = Vec::with_capacity(num_units as usize);
        let mut sizes = Vec::with_capacity(num_units as usize);
        let mut num_2d_array_layers = Vec::new();

        for &tex_ndx in &unit_textures {
            let texture = &textures[tex_ndx];
            let fmt_info = get_texture_format_info(texture.tex_format);

            unit_kinds.push(texture.kind);
            if texture.kind == Kind::Array {
                num_2d_array_layers.push(texture.size[2]);
            }

            tex_scales.push(fmt_info.look_up_scale);
            tex_biases.push(fmt_info.look_up_bias);
            sampler_types_per_unit.push(sampler_type_for(texture.kind, texture.tex_format));
            // `texSizes`: the depth entry is only set for 3D textures.
            sizes.push([
                texture.size[0],
                texture.size[1],
                if texture.kind == Kind::ThreeD {
                    texture.size[2]
                } else {
                    0
                },
            ]);
        }

        // Create shader.
        let spec = MultiTexSpec::new(
            rnd.get_uint32(),
            unit_kinds,
            sampler_types_per_unit,
            tex_scales,
            tex_biases,
            sizes,
            &num_2d_array_layers,
        );

        Ok(CaseData {
            num_units,
            textures,
            unit_textures,
            spec,
        })
    }

    /// `upload2dTexture`/`uploadCubeTexture`/`upload2dArrayTexture`/`upload3dTexture`
    fn upload_texture(texture: &UnitCaseTexture, ctx: &mut dyn SglrContext) -> Result<(), TestError> {
        let internal_format = texture.params.internal_format;
        ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);

        for (face, face_levels) in texture.levels.iter().enumerate() {
            for (level_ndx, level) in face_levels.iter().enumerate() {
                let [width, height, depth] = level.size();
                let (width, height, depth) = (width as i32, height as i32, depth as i32);

                match texture.kind {
                    Kind::Tex2D => {
                        ctx.tex_image_2d(
                            glw::GL_TEXTURE_2D,
                            level_ndx as i32,
                            internal_format,
                            width,
                            height,
                            0,
                            texture.transfer_format,
                            texture.transfer_type,
                            Some(level.data()),
                        );
                        expect_no_error(ctx, "Set 2d texture image data")?;
                    }
                    Kind::Cube => {
                        ctx.tex_image_2d(
                            CUBE_FACE_TARGETS[face],
                            level_ndx as i32,
                            internal_format,
                            width,
                            height,
                            0,
                            texture.transfer_format,
                            texture.transfer_type,
                            Some(level.data()),
                        );
                        expect_no_error(ctx, "Set cube map image data")?;
                    }
                    Kind::Array => {
                        ctx.tex_image_3d(
                            glw::GL_TEXTURE_2D_ARRAY,
                            level_ndx as i32,
                            internal_format,
                            width,
                            height,
                            depth,
                            0,
                            texture.transfer_format,
                            texture.transfer_type,
                            Some(level.data()),
                        );
                        expect_no_error(ctx, "Set 2d array texture image data")?;
                    }
                    Kind::ThreeD => {
                        ctx.tex_image_3d(
                            glw::GL_TEXTURE_3D,
                            level_ndx as i32,
                            internal_format,
                            width,
                            height,
                            depth,
                            0,
                            texture.transfer_format,
                            texture.transfer_type,
                            Some(level.data()),
                        );
                        expect_no_error(ctx, "Set 3d texture image data")?;
                    }
                }
            }
        }
        Ok(())
    }

    /// `TextureUnitCase::render`
    fn render(data: &CaseData, ctx: &mut dyn SglrContext) -> Result<(), TestError> {
        // Setup textures.
        let num_textures = data.textures.len();
        // Same texture may be bound to multiple units, but we only want to set up parameters and data once per texture.
        let mut is_texture_set_up = vec![false; num_textures];

        let mut texture_gl_names = vec![0u32; num_textures];
        ctx.gen_textures(&mut texture_gl_names);
        expect_no_error(ctx, "Generate textures")?;

        for unit_ndx in 0..data.num_units as usize {
            let tex_ndx = data.unit_textures[unit_ndx];
            let texture = &data.textures[tex_ndx];
            let target = texture.kind.gl_target();
            let params = &texture.params;

            // Bind texture to unit.
            ctx.active_texture(glw::GL_TEXTURE0 + unit_ndx as u32);
            expect_no_error(ctx, "Set active texture")?;
            ctx.bind_texture(target, texture_gl_names[tex_ndx]);
            expect_no_error(ctx, "Bind texture")?;

            if !is_texture_set_up[tex_ndx] {
                // Binding this texture for first time, so set parameters and data.
                ctx.tex_parameteri(target, glw::GL_TEXTURE_WRAP_S, params.wrap_mode_s as i32);
                ctx.tex_parameteri(target, glw::GL_TEXTURE_WRAP_T, params.wrap_mode_t as i32);
                if texture.kind == Kind::ThreeD {
                    ctx.tex_parameteri(target, glw::GL_TEXTURE_WRAP_R, params.wrap_mode_r as i32);
                }
                ctx.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, params.min_filter as i32);
                ctx.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, params.mag_filter as i32);
                expect_no_error(ctx, "Set texture parameters")?;

                Self::upload_texture(texture, ctx)?;

                is_texture_set_up[tex_ndx] = true; // Don't set up this texture's parameters and data again later.
            }
        }

        expect_no_error(ctx, "Set textures")?;

        // Setup shader
        let shader_id = ctx.create_program(Box::new(MultiTexShader::new(&data.spec)));

        // Draw.
        ctx.clear_color(0.125, 0.25, 0.5, 1.0);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
        data.spec.set_uniforms(ctx, shader_id);
        draw_quad(ctx, shader_id, Vec3::new(-1.0, -1.0, 0.0), Vec3::new(1.0, 1.0, 0.0));
        expect_no_error(ctx, "Draw")?;

        // Delete previously generated texture names.
        ctx.delete_textures(&texture_gl_names);
        expect_no_error(ctx, "Delete textures")?;

        Ok(())
    }
}

/// `GLU_EXPECT_NO_ERROR(context.getError(), msg)`
fn expect_no_error(ctx: &mut dyn SglrContext, message: &str) -> Result<(), TestError> {
    let error = ctx.get_error();
    if error != glw::GL_NO_ERROR {
        return Err(TestError::Fail(format!("{message}: glGetError() returned {error:#x}")));
    }
    Ok(())
}

impl TestCase for TextureUnitCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_target = context.render_target();
        let mut rnd = Random::new(self.rand_seed);

        let mut data = self.init(context)?;

        let viewport_width = VIEWPORT_WIDTH.min(render_target.width);
        let viewport_height = VIEWPORT_HEIGHT.min(render_target.height);
        let viewport_x = rnd.get_int(0, render_target.width - viewport_width);
        let viewport_y = rnd.get_int(0, render_target.height - viewport_height);

        let mut gles3_frame = Surface::new(viewport_width, viewport_height);
        let mut ref_frame = Surface::new(viewport_width, viewport_height);

        // First we do some tricks to make the LODs safer wrt. precision issues. See MultiTexShader::makeSafeLods().
        data.spec.make_safe_lods((viewport_width, viewport_height));

        // Render using GLES3.
        {
            let mut gl_context = GLContext::new(
                &context.render_context,
                (viewport_x, viewport_y, viewport_width, viewport_height),
            );
            Self::render(&data, &mut gl_context)?;
            gl_context.read_pixels(&mut gles3_frame, 0, 0, viewport_width, viewport_height);
        }

        // Render reference image.
        {
            let mut ref_context = create_reference_context_rgb8(context, viewport_width, viewport_height, 0)?;
            Self::render(&data, &mut ref_context)?;
            ref_context.read_pixels(&mut ref_frame, 0, 0, viewport_width, viewport_height);
        }

        // Compare images.
        let threshold = 0.001f32;
        let is_ok = fuzzy_compare_ok(
            &ref_frame.get_const_access(),
            &gles3_frame.get_const_access(),
            threshold,
        )
        .unwrap_or(false);

        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Image comparison failed")
        })
    }
}

/// `TextureUnitTests::init`
pub fn create_tests() -> TestCaseGroup {
    const NUM_TESTS_PER_GROUP: i32 = 10;

    // Negative stands for the implementation-specified maximum.
    const UNIT_COUNTS: [i32; 4] = [2, 4, 8, -1];

    let mut group = TestCaseGroup::new("units");

    for &num_units in &UNIT_COUNTS {
        let count_group_name = format!(
            "{}_units",
            if num_units < 0 {
                "all".to_string()
            } else {
                num_units.to_string()
            }
        );
        let mut count_group = TestCaseGroup::new(&count_group_name);

        for (case_type, case_type_group_name) in [
            (CaseType::Only2d, "only_2d"),
            (CaseType::OnlyCube, "only_cube"),
            (CaseType::Only2dArray, "only_2d_array"),
            (CaseType::Only3d, "only_3d"),
            (CaseType::Mixed, "mixed"),
        ] {
            let mut case_type_group = TestCaseGroup::new(case_type_group_name);

            for test_ndx in 0..NUM_TESTS_PER_GROUP {
                case_type_group.add_child(Box::new(TextureUnitCase {
                    name: test_ndx.to_string(),
                    num_units_param: num_units,
                    case_type,
                    rand_seed: de_int32_hash(test_ndx),
                }) as Box<dyn TestCase>);
            }
            count_group.add_child(case_type_group);
        }
        group.add_child(count_group);
    }

    group
}
