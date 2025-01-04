// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fTextureUnitTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `MultiTexShader` is built once per `render()` from a
// plain-data `MultiTexSpec` because `createProgram` moves the shader into the context; `init()` is the
// first half of `iterate()`. The per-unit `uniform mat3 u_transN` is declared as three `vec3` columns
// (`u_transN_c0..c2`) assembled with `mat3(...)` in the GLSL, since `sglr::Context` has no
// `uniformMatrix3fv`; the arithmetic is identical. `tcu::Texture2D`/`TextureCube` are plain
// `TextureLevel`s per (face, level), which is all this test reads out of them. Matrices are row-major
// `[[f32; 3]; 3]` like upstream's `tcu::Mat3(const float*)`.

use crate::gls::reference_context_buffers::create_reference_context_rgb8;
use crate::glu::shader_util::DataType;
use crate::glu::texture_util::map_gl_transfer_format;
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
use crate::sglr::reference_context::{ResolvedSampler, ResolvedSampler2D, ResolvedSamplerCube};
use crate::sglr::shader_program::{ShaderProgram, ShaderProgramBase, pdec};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::{TextureLevel, fill_with_grid, get_texture_format_info};
use crate::tcu::random::de_int32_hash;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::vector::{Vec3, Vec4};
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};

const VIEWPORT_WIDTH: i32 = 128;
const VIEWPORT_HEIGHT: i32 = 128;

const TEXTURE_WIDTH_2D: i32 = 128;
const TEXTURE_HEIGHT_2D: i32 = 128;

// Cube map texture size is larger in order to make minifications possible - otherwise would need to display different faces at same time.
const TEXTURE_WIDTH_CUBE: i32 = 256;
const TEXTURE_HEIGHT_CUBE: i32 = 256;

const GRID_CELL_SIZE: i32 = 8;

const TEST_FORMATS: [GLenum; 5] = [
    glw::GL_RGB,
    glw::GL_RGBA,
    glw::GL_ALPHA,
    glw::GL_LUMINANCE,
    glw::GL_LUMINANCE_ALPHA,
];

const TEST_DATA_TYPES: [GLenum; 4] = [
    glw::GL_UNSIGNED_BYTE,
    glw::GL_UNSIGNED_SHORT_5_6_5,
    glw::GL_UNSIGNED_SHORT_4_4_4_4,
    glw::GL_UNSIGNED_SHORT_5_5_5_1,
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

fn log2_floor(value: i32) -> i32 {
    31 - (value as u32).leading_zeros() as i32
}

// Row-major 3x3 matrices.

type Mat3 = [[f32; 3]; 3];

fn mat_mul(a: &Mat3, b: &Mat3) -> Mat3 {
    std::array::from_fn(|r| std::array::from_fn(|c| (0..3).map(|k| a[r][k] * b[k][c]).sum::<f32>()))
}

fn mat_vec(m: &Mat3, v: [f32; 3]) -> [f32; 3] {
    std::array::from_fn(|r| m[r][0] * v[0] + m[r][1] * v[1] + m[r][2] * v[2])
}

fn mat_scaled(m: &Mat3, s: f32) -> Mat3 {
    std::array::from_fn(|r| std::array::from_fn(|c| m[r][c] * s))
}

/// `tcu::Mat3(const float*)`: row-major.
fn mat_from(data: [f32; 9]) -> Mat3 {
    [
        [data[0], data[1], data[2]],
        [data[3], data[4], data[5]],
        [data[6], data[7], data[8]],
    ]
}

/// Column `c` of `m`, as `getColumnMajorData()` lays it out.
fn mat_column(m: &Mat3, c: usize) -> [f32; 3] {
    [m[0][c], m[1][c], m[2][c]]
}

fn generate_multi_tex_fragment_shader(unit_is_2d: &[bool]) -> String {
    // The fragment shader calculates the average of a set of textures.
    let num_units = unit_is_2d.len();
    let mut samplers_str = String::new();
    let mut matrices_str = String::new();
    let mut lookups_str = String::new();

    let color_multiplier = format!("(1.0/{num_units}.0)");

    for (ndx, &is_2d) in unit_is_2d.iter().enumerate() {
        let sampler_name = format!("u_sampler{ndx}");
        let transformation_name = format!("u_trans{ndx}");
        let sampler_type = if is_2d { "sampler2D" } else { "samplerCube" };
        let lookup_func = if is_2d { "texture2D" } else { "textureCube" };

        samplers_str += &format!("uniform mediump {sampler_type} {sampler_name};\n");
        for col in 0..3 {
            matrices_str += &format!("uniform mediump vec3 {transformation_name}_c{col};\n");
        }

        let mut lookup_coord = format!(
            "mat3({transformation_name}_c0, {transformation_name}_c1, {transformation_name}_c2)*vec3(v_coord, 1.0)"
        );
        if is_2d {
            lookup_coord = format!("vec2({lookup_coord})");
        }

        lookups_str += &format!("\tcolor += {color_multiplier}*{lookup_func}({sampler_name}, {lookup_coord});\n");
    }

    format!(
        "{samplers_str}{matrices_str}varying mediump vec2 v_coord;\n\
         \n\
         void main (void)\n\
         {{\n\
         \x20   mediump vec4 color = vec4(0.0);\n\
         {lookups_str}\
         \x20   gl_FragColor = color;\n\
         }}\n"
    )
}

fn generate_shader_program_declaration(unit_is_2d: &[bool]) -> pdec::ShaderProgramDeclaration {
    let mut decl = pdec::ShaderProgramDeclaration::new()
        .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
        .vertex_attribute(pdec::VertexAttribute::new("a_coord", GenericVecType::Float))
        .vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float))
        .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float));

    for (ndx, &is_2d) in unit_is_2d.iter().enumerate() {
        decl = decl.uniform(pdec::Uniform::new(
            format!("u_sampler{ndx}"),
            if is_2d {
                DataType::Sampler2D
            } else {
                DataType::SamplerCube
            },
        ));
        for col in 0..3 {
            decl = decl.uniform(pdec::Uniform::new(format!("u_trans{ndx}_c{col}"), DataType::FloatVec3));
        }
    }

    decl.vertex_source(
        "attribute highp vec4 a_position;\n\
         attribute mediump vec2 a_coord;\n\
         varying mediump vec2 v_coord;\n\
         \n\
         void main (void)\n\
         {\n\
         \x20   gl_Position = a_position;\n\
         \x20   v_coord = a_coord;\n\
         }\n"
        .to_string(),
    )
    .fragment_source(generate_multi_tex_fragment_shader(unit_is_2d))
}

/// Calculates values to be used in `calculate_lod_max`/`min`.
fn calculate_lod_derivate_parts(transformation: &Mat3) -> [f32; 4] {
    // Calculate transformed coordinates of three corners.
    let trans00 = mat_vec(transformation, [0.0, 0.0, 1.0]);
    let trans01 = mat_vec(transformation, [0.0, 1.0, 1.0]);
    let trans10 = mat_vec(transformation, [1.0, 0.0, 1.0]);

    [
        trans10[0] - trans00[0],
        trans01[0] - trans00[0],
        trans10[1] - trans00[1],
        trans01[1] - trans00[1],
    ]
}

/// The four terms both lod bounds are made of.
fn lod_derivates(
    derivate_parts: &[f32; 4],
    texture_size: (i32, i32),
    screen_derivate: (f32, f32),
) -> (f32, f32, f32, f32) {
    let dudx = derivate_parts[0] * texture_size.0 as f32 * screen_derivate.0;
    let dudy = derivate_parts[1] * texture_size.0 as f32 * screen_derivate.1;
    let dvdx = derivate_parts[2] * texture_size.1 as f32 * screen_derivate.0;
    let dvdy = derivate_parts[3] * texture_size.1 as f32 * screen_derivate.1;
    (dudx, dudy, dvdx, dvdy)
}

/// Calculates the maximum allowed lod from derivates
fn calculate_lod_max(derivate_parts: &[f32; 4], texture_size: (i32, i32), screen_derivate: (f32, f32)) -> f32 {
    let (dudx, dudy, dvdx, dvdy) = lod_derivates(derivate_parts, texture_size, screen_derivate);
    (dudx.abs().max(dudy.abs()) + dvdx.abs().max(dvdy.abs())).log2()
}

/// Calculates the minimum allowed lod from derivates
fn calculate_lod_min(derivate_parts: &[f32; 4], texture_size: (i32, i32), screen_derivate: (f32, f32)) -> f32 {
    let (dudx, dudy, dvdx, dvdy) = lod_derivates(derivate_parts, texture_size, screen_derivate);
    dudx.abs().max(dudy.abs()).max(dvdx.abs().max(dvdy.abs())).log2()
}

/// What `MultiTexShader`'s constructor generates; the shader itself is built from it for each context.
#[derive(Clone)]
struct MultiTexSpec {
    unit_is_2d: Vec<bool>,
    transformations: Vec<Mat3>,
    /// Parts of lod derivates; computed in the constructor, used by `make_safe_lods`.
    lod_derivate_parts: Vec<[f32; 4]>,
}

impl MultiTexSpec {
    /// `MultiTexShader::MultiTexShader`
    fn new(rand_seed: u32, unit_is_2d: Vec<bool>) -> Self {
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
        let num_units = unit_is_2d.len();
        let mut transformations = Vec::with_capacity(num_units);
        let mut lod_derivate_parts = Vec::with_capacity(num_units);

        for &is_2d in &unit_is_2d {
            if is_2d {
                let rot_angle = rnd.get_float_range(0.0, 2.0 * std::f32::consts::PI);
                let x_scale_factor = rnd.get_float_range(0.7, 1.5);
                let y_scale_factor = rnd.get_float_range(0.7, 1.5);
                let x_shear_amount = rnd.get_float_range(0.0, 0.5);
                let y_shear_amount = rnd.get_float_range(0.0, 0.5);
                let x_translation_amount = rnd.get_float_range(-0.5, 0.5);
                let y_translation_amount = rnd.get_float_range(-0.5, 0.5);

                // For temporarily centering the coordinates to get nicer transformations.
                let temp_offset = mat_from([1.0, 0.0, -0.5, 0.0, 1.0, -0.5, 0.0, 0.0, 1.0]);
                let rot_transf = mat_from([
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
                let scale_transf = mat_from([x_scale_factor, 0.0, 0.0, 0.0, y_scale_factor, 0.0, 0.0, 0.0, 1.0]);
                let x_shear_transf = mat_from([1.0, x_shear_amount, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0]);
                let y_shear_transf = mat_from([1.0, 0.0, 0.0, y_shear_amount, 1.0, 0.0, 0.0, 0.0, 1.0]);
                let translation_transf = mat_from([
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
                let neg_temp_offset = mat_scaled(&temp_offset, -1.0);
                let mut transformation = mat_mul(&temp_offset, &translation_transf);
                for next in [
                    &rot_transf,
                    &scale_transf,
                    &x_shear_transf,
                    &y_shear_transf,
                    &neg_temp_offset,
                ] {
                    transformation = mat_mul(&transformation, next);
                }

                lod_derivate_parts.push(calculate_lod_derivate_parts(&transformation));
                transformations.push(transformation);
            } else {
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
                let planar_trans = mat_from(planar_trans_data); // Planar, face-agnostic transformation.
                // Final transformation from planar to cube map coordinates, including the transformation just generated.
                let final_trans = mat_mul(&mat_from(CUBE_TRANSFORMS[face_ndx]), &planar_trans);

                lod_derivate_parts.push(calculate_lod_derivate_parts(&planar_trans));
                transformations.push(final_trans);
            }
        }

        Self {
            unit_is_2d,
            transformations,
            lod_derivate_parts,
        }
    }

    /// `MultiTexShader::makeSafeLods` - modifies texture coordinates so that LODs aren't too close to x.5 or 0.0.
    fn make_safe_lods(&mut self, texture_sizes: &[(i32, i32)], viewport_size: (i32, i32)) {
        let shrink_scale_mat = mat_from([0.95, 0.0, 0.0, 0.0, 0.95, 0.0, 0.0, 0.0, 1.0]);
        let screen_derivate = (1.0 / viewport_size.0 as f32, 1.0 / viewport_size.1 as f32);

        for unit_ndx in 0..self.unit_is_2d.len() {
            // As long as LOD is too close to 0.0 or is positive and too close to a something-and-a-half (0.5, 1.5, 2.5 etc) or allowed lod range could round to different levels, zoom in a little to get a safer LOD.
            loop {
                let threshold = 0.1f32;
                let epsilon = 0.01f32;

                let lod_max = calculate_lod_max(
                    &self.lod_derivate_parts[unit_ndx],
                    texture_sizes[unit_ndx],
                    screen_derivate,
                );
                let lod_min = calculate_lod_min(
                    &self.lod_derivate_parts[unit_ndx],
                    texture_sizes[unit_ndx],
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
                    self.transformations[unit_ndx] = mat_mul(&shrink_scale_mat, &self.transformations[unit_ndx]);
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
        for ndx in 0..self.unit_is_2d.len() {
            let sampler_loc = ctx.get_uniform_location(program, &format!("u_sampler{ndx}"));
            ctx.uniform1i(sampler_loc, ndx as i32);
            for col in 0..3 {
                let loc = ctx.get_uniform_location(program, &format!("u_trans{ndx}_c{col}"));
                ctx.uniform3fv(loc, 1, &mat_column(&self.transformations[ndx], col));
            }
        }
    }
}

enum UnitSampler {
    Unbound,
    Tex2D(ResolvedSampler2D),
    Cube(ResolvedSamplerCube),
}

struct MultiTexShader {
    base: ShaderProgramBase,
    spec: MultiTexSpec,
    samplers: Vec<UnitSampler>,
}

impl MultiTexShader {
    fn new(spec: &MultiTexSpec) -> Self {
        let base = ShaderProgramBase::new(&generate_shader_program_declaration(&spec.unit_is_2d));
        let samplers = spec.unit_is_2d.iter().map(|_| UnitSampler::Unbound).collect();
        Self {
            base,
            spec: spec.clone(),
            samplers,
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
        let num_units = self.spec.unit_is_2d.len();
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
                let transformed: [[f32; 3]; 4] =
                    std::array::from_fn(|f| mat_vec(transformation, [tex_coords[f][0], tex_coords[f][1], 1.0]));

                for frag_ndx in 0..4usize {
                    // Fragment ndx = x + 2 * y within the quad.
                    let (dx_other, dy_other) = (frag_ndx ^ 1, frag_ndx ^ 2);
                    let dfdx: [f32; 3] = std::array::from_fn(|c| transformed[frag_ndx][c] - transformed[dx_other][c]);
                    let dfdy: [f32; 3] = std::array::from_fn(|c| transformed[frag_ndx][c] - transformed[dy_other][c]);
                    let t = transformed[frag_ndx];

                    let sample = match &self.samplers[unit_ndx] {
                        UnitSampler::Tex2D(sampler) => {
                            sampler.sample_2d_quad(t[0], t[1], (dfdx[0], dfdx[1]), (dfdy[0], dfdy[1]))
                        }
                        UnitSampler::Cube(sampler) => sampler.sample_cube_quad4(&transformed, frag_ndx, 0.0),
                        UnitSampler::Unbound => [0.0; 4],
                    };

                    // Add to sum
                    for c in 0..4 {
                        out_colors[frag_ndx][c] += color_multiplier * sample[c];
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
                        Some(s) => match (self.spec.unit_is_2d[ndx], s.as_2d(), s.as_cube()) {
                            (true, Some(s2d), _) => UnitSampler::Tex2D(s2d.clone()),
                            (false, _, Some(scube)) => UnitSampler::Cube(scube.clone()),
                            _ => UnitSampler::Unbound,
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
    Mixed,
}

struct TextureParameters {
    format: GLenum,
    data_type: GLenum,
    wrap_mode_s: GLenum,
    wrap_mode_t: GLenum,
    min_filter: GLenum,
    mag_filter: GLenum,
}

struct UnitCaseTexture {
    is_2d: bool,
    size: i32,
    params: TextureParameters,
    /// `[face][level]`; one face for a 2D texture, six for a cube map.
    levels: Vec<Vec<TextureLevel>>,
}

impl UnitCaseTexture {
    fn gl_type(&self) -> GLenum {
        if self.is_2d {
            glw::GL_TEXTURE_2D
        } else {
            glw::GL_TEXTURE_CUBE_MAP
        }
    }
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
            // Either fixed or randomized target types (2d or cube), and randomized parameters for every texture.
            let is_2d = match self.case_type {
                CaseType::Only2d => true,
                CaseType::OnlyCube => false,
                CaseType::Mixed => rnd.get_bool(),
            };

            let tex_width = if is_2d { TEXTURE_WIDTH_2D } else { TEXTURE_WIDTH_CUBE };
            let tex_height = if is_2d { TEXTURE_HEIGHT_2D } else { TEXTURE_HEIGHT_CUBE };
            assert!(tex_width == tex_height);
            let mipmaps = (tex_width as u32).is_power_of_two() && (tex_height as u32).is_power_of_two();
            let num_levels = if mipmaps {
                log2_floor(tex_width.max(tex_height)) + 1
            } else {
                1
            };

            let wrap_mode_s = TEST_WRAP_MODES[rnd.get_int(0, TEST_WRAP_MODES.len() as i32 - 1) as usize];
            let wrap_mode_t = TEST_WRAP_MODES[rnd.get_int(0, TEST_WRAP_MODES.len() as i32 - 1) as usize];
            let mag_filter = TEST_MAG_FILTERS[rnd.get_int(0, TEST_MAG_FILTERS.len() as i32 - 1) as usize];
            let data_type = TEST_DATA_TYPES[rnd.get_int(0, TEST_DATA_TYPES.len() as i32 - 1) as usize];

            // Certain minification filters are only used when using mipmaps.
            let min_filter = if mipmaps {
                TEST_MIN_FILTERS[rnd.get_int(0, TEST_MIN_FILTERS.len() as i32 - 1) as usize]
            } else {
                TEST_NON_MIPMAP_MIN_FILTERS[rnd.get_int(0, TEST_NON_MIPMAP_MIN_FILTERS.len() as i32 - 1) as usize]
            };

            // Format may depend on data type.
            let format = if data_type == glw::GL_UNSIGNED_SHORT_5_6_5 {
                glw::GL_RGB
            } else if data_type == glw::GL_UNSIGNED_SHORT_4_4_4_4 || data_type == glw::GL_UNSIGNED_SHORT_5_5_5_1 {
                glw::GL_RGBA
            } else {
                TEST_FORMATS[rnd.get_int(0, TEST_FORMATS.len() as i32 - 1) as usize]
            };

            let tex_format = map_gl_transfer_format(format, data_type).ok_or_else(|| {
                TestError::Fail(format!("unsupported (format, type) pair ({format:#x}, {data_type:#x})"))
            })?;
            let fmt_info = get_texture_format_info(tex_format);
            let c_bias = fmt_info.value_min;
            let c_scale: [f32; 4] = std::array::from_fn(|c| fmt_info.value_max[c] - fmt_info.value_min[c]);

            // Fill with grid texture.
            let num_faces = if is_2d { 1 } else { 6 };
            let mut levels = Vec::with_capacity(num_faces);

            for _ in 0..num_faces {
                let rgb = rnd.get_uint32() & 0x00ff_ffff;
                let mut alpha0 = 0xff00_0000u32;
                let mut alpha1 = 0xff00_0000u32;

                if format == glw::GL_ALPHA {
                    // This needs alpha to be visible.
                    alpha0 &= rnd.get_uint32();
                    alpha1 = !alpha0;
                }

                let color_a = alpha0 | rgb;
                let color_b = alpha1 | !rgb;
                let vec_a = RGBA::from_packed(color_a).to_vec().m_data;
                let vec_b = RGBA::from_packed(color_b).to_vec().m_data;
                let grid_a: [f32; 4] = std::array::from_fn(|c| vec_a[c] * c_scale[c] + c_bias[c]);
                let grid_b: [f32; 4] = std::array::from_fn(|c| vec_b[c] * c_scale[c] + c_bias[c]);

                let mut face_levels = Vec::with_capacity(num_levels as usize);
                for level_ndx in 0..num_levels {
                    let level_size = (tex_width >> level_ndx).max(1);
                    let cur_cell_size = (GRID_CELL_SIZE >> level_ndx).max(1); // Scale grid cell size for mipmaps.

                    let mut level = TextureLevel::new(tex_format, level_size as u32, level_size as u32, 1)?;
                    fill_with_grid(&mut level.get_access(), cur_cell_size as u32, grid_a, grid_b);
                    face_levels.push(level);
                }
                levels.push(face_levels);
            }

            textures.push(UnitCaseTexture {
                is_2d,
                size: tex_width,
                params: TextureParameters {
                    format,
                    data_type,
                    wrap_mode_s,
                    wrap_mode_t,
                    min_filter,
                    mag_filter,
                },
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

        // Create shader.
        let unit_is_2d: Vec<bool> = unit_textures.iter().map(|&tex_ndx| textures[tex_ndx].is_2d).collect();
        let spec = MultiTexSpec::new(rnd.get_uint32(), unit_is_2d);

        Ok(CaseData {
            num_units,
            textures,
            unit_textures,
            spec,
        })
    }

    /// `TextureUnitCase::render`
    fn render(data: &CaseData, ctx: &mut dyn SglrContext) -> Result<(), TestError> {
        // Setup textures.
        let num_textures = data.textures.len();
        // Same texture may be bound to multiple units, but we only want to set up parameters and data once per texture.
        let mut is_texture_set_up = vec![false; num_textures];

        let mut texture_gl_names = vec![0u32; num_textures];
        ctx.gen_textures(&mut texture_gl_names);

        for unit_ndx in 0..data.num_units as usize {
            let tex_ndx = data.unit_textures[unit_ndx];
            let texture = &data.textures[tex_ndx];
            let target = texture.gl_type();
            let params = &texture.params;

            // Bind texture to unit.
            ctx.active_texture(glw::GL_TEXTURE0 + unit_ndx as u32);
            ctx.bind_texture(target, texture_gl_names[tex_ndx]);

            if !is_texture_set_up[tex_ndx] {
                // Binding this texture for first time, so set parameters and data.
                ctx.tex_parameteri(target, glw::GL_TEXTURE_WRAP_S, params.wrap_mode_s as i32);
                ctx.tex_parameteri(target, glw::GL_TEXTURE_WRAP_T, params.wrap_mode_t as i32);
                ctx.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, params.min_filter as i32);
                ctx.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, params.mag_filter as i32);

                ctx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);

                for (face, face_levels) in texture.levels.iter().enumerate() {
                    let face_target = if texture.is_2d {
                        glw::GL_TEXTURE_2D
                    } else {
                        CUBE_FACE_TARGETS[face]
                    };
                    for (level_ndx, level) in face_levels.iter().enumerate() {
                        let level_size = (texture.size >> level_ndx).max(1);
                        ctx.tex_image_2d(
                            face_target,
                            level_ndx as i32,
                            params.format,
                            level_size,
                            level_size,
                            0,
                            params.format,
                            params.data_type,
                            Some(level.data()),
                        );
                    }
                }

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

        let mut gles2_frame = Surface::new(viewport_width, viewport_height);
        let mut ref_frame = Surface::new(viewport_width, viewport_height);

        {
            // First we do some tricks to make the LODs safer wrt. precision issues. See MultiTexShader::makeSafeLods().
            let tex_sizes: Vec<(i32, i32)> = data
                .unit_textures
                .iter()
                .map(|&tex_ndx| {
                    let texture = &data.textures[tex_ndx];
                    (texture.size, texture.size)
                })
                .collect();

            data.spec.make_safe_lods(&tex_sizes, (viewport_width, viewport_height));
        }

        // Render using GLES2.
        {
            let mut gl_context = GLContext::new(
                &context.render_context,
                (viewport_x, viewport_y, viewport_width, viewport_height),
            );
            Self::render(&data, &mut gl_context)?;
            gl_context.read_pixels(&mut gles2_frame, 0, 0, viewport_width, viewport_height);
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
            &gles2_frame.get_const_access(),
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
