// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/texture/vktTextureMipmapTests.cpp (Texture2DMipmapTestInstance, getBasicTexCoord2D, getAffineTexCoord2D, populateTextureMipmappingTests' 2d coordinate type and bias groups)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream draws the sixteen cells of a 4x4 grid into one frame with a viewport each; every cell here is rendered into a target of its own
// size instead, which samples the same texels (the cell origin is an integer), and is verified on its own. Only the `2d` and `3d` coordinate type groups (basic, affine, projected) and `bias`, plus the 2d lod control groups, are ported:
// the cubemap group has the coordinate type groups and the lod controls; image_view_min_lod is ported (the integer_texel_coord cases run on a second Context with robustImageAccess2).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::test_util::{
    Program, QUAD_POSITIONS, RenderRequest, SamplerParams, ShaderParameters, TexKind, pixels_to_surface,
    reference_texture_2d, reference_texture_3d, reference_texture_cube, render_quad_2d,
};
use crate::generated::shaders::texture_mipmap_fetch_lod::{FETCH_LOD_2D, FETCH_LOD_3D};
use crate::generated::shaders::texture_mipmap_misc::PROJECTED_DERIVATIVES;
use crate::generated::shaders::texture_swizzle::{
    TSW_2D_FLOAT_BIAS_NONE, TSW_2D_FLOAT_NONE, TSW_3D_FLOAT_BIAS_NONE, TSW_3D_FLOAT_NONE, TSW_CUBE_FLOAT_BIAS_NONE,
    TSW_CUBE_FLOAT_NONE,
};
use crate::glu::texture_test_util::{
    LodMode, ReferenceParams, SamplerType, TextureType, compute_quad_tex_coord_2d, get_sampler_type,
};
use crate::glu::texture_test_util_surface::{
    compute_fixed_point_threshold, compute_quad_tex_coord_cube, get_bits_vec, get_compare_mask,
    verify_texture_result_2d, verify_texture_result_3d, verify_texture_result_cube,
};
use crate::tcu::pixel::{
    CompareMode, CubeFace, FilterMode, MipmapFilterMode, Sampler, WrapMode, clear, get_texture_format_info,
};
use crate::tcu::random::{Random, de_int32_hash, de_string_hash};
use crate::tcu::tex_verifier::{LodPrecision, LookupPrecision};
use crate::tcu::{PixelFormat, TestError, TestOutcome, TestStatus, Vec2, Vec4, map_vk_format};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::context::RobustnessFeatures;
use crate::vkt::tests::pipeline::image_util::create_test_texture;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum CoordType {
    Basic,
    BasicBias,
    Affine,
    Projected,
}

#[derive(Clone, Copy)]
struct MipMinFilter {
    name: &'static str,
    linear: bool,
    mip_linear: bool,
}

const MIN_FILTER_MODES: &[MipMinFilter] = &[
    MipMinFilter {
        name: "nearest_nearest",
        linear: false,
        mip_linear: false,
    },
    MipMinFilter {
        name: "linear_nearest",
        linear: true,
        mip_linear: false,
    },
    MipMinFilter {
        name: "nearest_linear",
        linear: false,
        mip_linear: true,
    },
    MipMinFilter {
        name: "linear_linear",
        linear: true,
        mip_linear: true,
    },
];

const WRAP_MODES: &[(&str, vk::SamplerAddressMode, WrapMode)] = &[
    ("clamp", vk::SamplerAddressMode::CLAMP_TO_EDGE, WrapMode::ClampToEdge),
    ("repeat", vk::SamplerAddressMode::REPEAT, WrapMode::Repeat),
    (
        "mirror",
        vk::SamplerAddressMode::MIRRORED_REPEAT,
        WrapMode::MirroredRepeat,
    ),
];

const TEX_2D_SIZES: &[(Option<&str>, u32, u32)] =
    &[(None, 64, 64), (Some("npot"), 63, 57), (Some("non_square"), 32, 64)];

/// `Texture2DMipmapTestCaseParameters`
#[derive(Clone, Copy)]
struct MipmapParameters {
    coord_type: CoordType,
    min_filter: MipMinFilter,
    wrap: (vk::SamplerAddressMode, WrapMode),
    width: u32,
    height: u32,
    use_compute: bool,
}

/// `getBasicTexCoord2D`: the bottom left and top right coordinates of a cell
fn basic_coords(cell_ndx: usize) -> (Vec2, Vec2) {
    const COORDS: [([f32; 2], [f32; 2]); 16] = [
        ([-0.1, 0.1], [0.8, 1.0]),
        ([-0.3, -0.6], [0.7, 0.4]),
        ([-0.3, 0.6], [0.7, -0.9]),
        ([-0.8, 0.6], [0.7, -0.9]),
        ([-0.5, -0.5], [1.5, 1.5]),
        ([1.0, -1.0], [-1.3, 1.0]),
        ([1.2, -1.0], [-1.3, 1.6]),
        ([2.2, -1.1], [-1.3, 0.8]),
        ([-1.5, 1.6], [1.7, -1.4]),
        ([2.0, 1.6], [2.3, -1.4]),
        ([1.3, -2.6], [-2.7, 2.9]),
        ([-0.8, -6.6], [6.0, -0.9]),
        ([-8.0, 9.0], [8.3, -7.0]),
        ([-16.0, 10.0], [18.3, 24.0]),
        ([30.2, 55.0], [-24.3, -1.6]),
        ([-33.2, 64.1], [32.1, -64.1]),
    ];
    let (bottom_left, top_right) = COORDS[cell_ndx];
    (
        Vec2::new(bottom_left[0], bottom_left[1]),
        Vec2::new(top_right[0], top_right[1]),
    )
}

/// `getBasicTexCoord2D` / `getAffineTexCoord2D`: the four `(s, t)` pairs of a cell's quad
fn cell_tex_coord(coord_type: CoordType, cell_ndx: usize) -> [f32; 8] {
    let (bottom_left, top_right) = basic_coords(cell_ndx);
    let mut coords = compute_quad_tex_coord_2d(bottom_left, top_right);
    if coord_type == CoordType::Affine {
        // Rotate based on cell index.
        let angle = 2.0 * std::f32::consts::PI * (cell_ndx as f32 / 16.0);
        let (sin, cos) = angle.sin_cos();
        // Second and third row are sheared.
        let shear_x = if (4..=11).contains(&cell_ndx) {
            (15 - cell_ndx) as f32 / 16.0
        } else {
            0.0
        };
        // rotationMatrix(angle) * shearMatrix((shearX, 0))
        let transform = [[cos, cos * shear_x - sin], [sin, sin * shear_x + cos]];
        for vertex in 0..4 {
            let (x, y) = (coords[2 * vertex], coords[2 * vertex + 1]);
            coords[2 * vertex] = transform[0][0] * x + transform[0][1] * y;
            coords[2 * vertex + 1] = transform[1][0] * x + transform[1][1] * y;
        }
    }
    coords
}

struct MipmapCase {
    name: String,
    params: MipmapParameters,
}

impl TestCase for MipmapCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.coord_type == CoordType::BasicBias {
            TSW_2D_FLOAT_BIAS_NONE.programs
        } else {
            TSW_2D_FLOAT_NONE.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MipmapInstance {
            context,
            params: self.params,
        })
    }
}

struct MipmapInstance<'a> {
    context: &'a Context<'a>,
    params: MipmapParameters,
}

impl TestInstance for MipmapInstance<'_> {
    /// `Texture2DMipmapTestInstance`'s constructor and `iterate`, one target per grid cell
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let format = vk::Format::R8G8B8A8_UNORM;

        let mut texture = create_test_texture(
            format,
            vk::ImageViewType::_2D,
            [params.width as i32, params.height as i32, 1],
            1,
        )?;
        let num_levels = texture.get_num_levels();

        // Fill texture with colored grid.
        for level in 0..num_levels {
            let step = 0xffu32 / (num_levels as u32 - 1);
            let inc = (step * level as u32).clamp(0x00, 0xff);
            let dec = 0xff - inc;
            clear(
                &mut texture.get_level_mut(level, 0),
                [1.0, dec as f32 / 255.0, inc as f32 / 255.0, 1.0],
            );
        }

        // Bias values.
        const BIAS: [f32; 8] = [1.0, -2.0, 0.8, -0.5, 1.5, 0.9, 2.0, 4.0];
        // Projection values.
        const PROJECTIONS: [[f32; 4]; 4] = [
            [1.2, 1.0, 0.7, 1.0],
            [1.3, 0.8, 0.6, 2.0],
            [0.8, 1.0, 1.7, 0.6],
            [1.2, 1.0, 1.7, 1.5],
        ];

        let is_projected = params.coord_type == CoordType::Projected;
        let use_lod_bias = params.coord_type == CoordType::BasicBias;
        let sampler = SamplerParams {
            wrap_u: params.wrap.0,
            wrap_v: params.wrap.0,
            wrap_w: params.wrap.0,
            min_filter: if params.min_filter.linear {
                vk::Filter::LINEAR
            } else {
                vk::Filter::NEAREST
            },
            mag_filter: vk::Filter::NEAREST,
            mipmap_mode: if params.min_filter.mip_linear {
                vk::SamplerMipmapMode::LINEAR
            } else {
                vk::SamplerMipmapMode::NEAREST
            },
            min_lod: 0.0,
            max_lod: 1000.0,
            border_color: vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
            compare_op: None,
            unnormalized: false,
            non_seamless: false,
            max_anisotropy: None,
        };
        let tcu_sampler = Sampler {
            wrap_s: params.wrap.1,
            wrap_t: params.wrap.1,
            wrap_r: params.wrap.1,
            filter: if params.min_filter.linear {
                FilterMode::Linear
            } else {
                FilterMode::Nearest
            },
            normalized_coords: true,
            compare: CompareMode::None,
            compare_channel: 0,
            mip_filter: Some(if params.min_filter.mip_linear {
                MipmapFilterMode::Linear
            } else {
                MipmapFilterMode::Nearest
            }),
            seamless_cube_map: true,
        };
        let sampler_type = get_sampler_type(
            map_vk_format(format).ok_or_else(|| TestError::NotPorted("no texture format".to_string()))?,
        );
        if sampler_type != SamplerType::Float {
            return Err(TestError::NotPorted("non float sampler types".to_string()));
        }
        let reference = reference_texture_2d(&texture, params.width, params.height);

        // The viewport is divided into 4x4 grid; each cell is a target of the texture's size.
        let (cell_width, cell_height) = (params.width, params.height);
        for cell_ndx in 0..16usize {
            let tex_coord = cell_tex_coord(
                if use_lod_bias {
                    CoordType::Basic
                } else {
                    params.coord_type
                },
                cell_ndx,
            );

            let mut ref_params = ReferenceParams::new(TextureType::Texture2D, tcu_sampler, LodMode::Exact); // Use ideal lod.
            ref_params.mag_filter = Some(FilterMode::Nearest);
            ref_params.base.sampler_type = SamplerType::Float;
            ref_params.base.projected = is_projected;
            ref_params.base.use_bias = use_lod_bias;
            let w = PROJECTIONS[cell_ndx % PROJECTIONS.len()];
            if is_projected {
                ref_params.base.w = Vec4::new(w[0], w[1], w[2], w[3]);
            }
            if use_lod_bias {
                ref_params.base.bias = BIAS[cell_ndx % BIAS.len()];
            }

            // Projected: each vertex position is scaled by its w
            let mut positions = QUAD_POSITIONS;
            if is_projected {
                for vertex in 0..4 {
                    positions[4 * vertex] *= w[vertex];
                    positions[4 * vertex + 1] *= w[vertex];
                    positions[4 * vertex + 3] *= w[vertex];
                }
            }

            let request = RenderRequest {
                texture: &texture,
                format,
                aspect_mask: vk::ImageAspectFlags::COLOR,
                component_mapping: vk::ComponentMapping {
                    r: vk::ComponentSwizzle::R,
                    g: vk::ComponentSwizzle::G,
                    b: vk::ComponentSwizzle::B,
                    a: vk::ComponentSwizzle::A,
                },
                use_compute: params.use_compute,
                sparse: false,
                width: cell_width,
                height: cell_height,
                tex_width: params.width,
                tex_height: params.height,
                tex_depth: 1,
                kind: TexKind::D2,
                sampler,
                tex_coord: &tex_coord,
                positions,
                view_levels: None,
                view_min_lod: None,
                output_format: vk::Format::R8G8B8A8_UNORM,
                program: if use_lod_bias {
                    Program::FloatBias2D
                } else {
                    Program::Float2D
                },
                parameters: ShaderParameters {
                    bias: ref_params.base.bias,
                    reference: 0.0,
                    color_scale: [1.0; 4],
                    color_bias: [0.0; 4],
                    lod: 0,
                },
            };
            let pixels = render_quad_2d(context, &request, context.get_binary_collection())?;
            let rendered = pixels_to_surface(&pixels, cell_width, cell_height);

            // Compare this cell
            let pixel_format = PixelFormat::new(8, 8, 8, 8);
            let is_trilinear = params.min_filter.mip_linear;
            let color_bits = get_bits_vec(pixel_format).map(|bits| (bits - if is_trilinear { 2 } else { 1 }).max(0));
            let lookup_precision = LookupPrecision {
                coord_bits: [20, 20, 0],
                uvw_bits: [16, 16, 0], // Doesn't really matter since pixels are unicolored.
                color_threshold: compute_fixed_point_threshold(color_bits),
                color_mask: get_compare_mask(pixel_format),
                ..LookupPrecision::default()
            };
            let lod_precision = LodPrecision {
                derivate_bits: 10,
                lod_bits: if is_projected { 6 } else { 8 },
            };
            if !verify_texture_result_2d(
                &rendered,
                &reference,
                tex_coord,
                &ref_params,
                &lookup_precision,
                &lod_precision,
                pixel_format,
            )? {
                log::info!("ERROR: Image verification failed in cell {cell_ndx}");
                return Ok(TestStatus::fail("fail"));
            }
        }
        Ok(TestStatus::pass("pass"))
    }
}

fn add_case(group: &mut TestCaseGroup, name: String, params: MipmapParameters) {
    let mut params = params;
    group.add_child(Box::new(MipmapCase {
        name: name.clone(),
        params,
    }) as Box<dyn TestCase>);

    // Compute case.
    params.use_compute = true;
    group.add_child(Box::new(MipmapCase {
        name: format!("{name}_compute"),
        params,
    }) as Box<dyn TestCase>);
}

const TEX_3D_SIZES: &[(Option<&str>, u32, u32, u32)] = &[(None, 32, 32, 32), (Some("npot"), 33, 29, 27)];

/// `Texture3DMipmapTestCaseParameters`
#[derive(Clone, Copy)]
struct Mipmap3DParameters {
    coord_type: CoordType,
    min_filter: MipMinFilter,
    wrap: (vk::SamplerAddressMode, WrapMode),
    width: u32,
    height: u32,
    depth: u32,
    use_compute: bool,
}

/// `getBasicTexCoord3D`
fn basic_tex_coord_3d(cell_ndx: usize) -> [f32; 12] {
    // sScale, sBias, tScale, tBias, rScale, rBias
    const PARAMS: [[f32; 6]; 16] = [
        [0.9, -0.1, 0.7, 0.3, 0.8, 0.9],
        [1.2, -0.1, 1.1, 0.3, 1.0, 0.9],
        [1.5, 0.7, 0.9, -0.3, 1.1, 0.1],
        [1.2, 0.7, -2.3, -0.3, 1.1, 0.2],
        [1.1, 0.8, -1.3, -0.3, 2.9, 0.9],
        [3.4, 0.8, 4.0, 0.0, -3.3, -1.0],
        [-3.4, -0.1, -4.0, 0.0, -5.1, 1.0],
        [-4.0, -0.1, 3.4, 0.1, 5.7, 0.0],
        [-5.6, 0.0, 0.5, 1.2, 3.9, 4.0],
        [5.0, -2.0, 3.1, 1.2, 5.1, 0.2],
        [2.5, -2.0, 6.3, 3.0, 5.1, 0.2],
        [-8.3, 0.0, 7.1, 3.0, 2.0, 0.2],
        [3.8, 0.0, 9.7, 1.0, 7.0, 0.7],
        [13.3, 0.0, 7.1, 3.0, 2.0, 0.2],
        [16.0, 8.0, 12.7, 1.0, 17.1, 0.7],
        [15.3, 0.0, 20.1, 3.0, 33.0, 3.2],
    ];
    let [s_scale, s_bias, t_scale, t_bias, r_scale, r_bias] = PARAMS[cell_ndx % PARAMS.len()];
    [
        s_bias,
        t_bias,
        r_bias,
        s_bias,
        t_bias + t_scale,
        r_bias + r_scale * 0.5,
        s_bias + s_scale,
        t_bias,
        r_bias + r_scale * 0.5,
        s_bias + s_scale,
        t_bias + t_scale,
        r_bias + r_scale,
    ]
}

/// `getAffineTexCoord3D`: the basic coordinates rotated about X and then Y
fn affine_tex_coord_3d(cell_ndx: usize) -> [f32; 12] {
    let mut coords = basic_tex_coord_3d(cell_ndx);
    let angle_x = 2.0 * std::f32::consts::PI * (cell_ndx as f32 / 16.0);
    let angle_y = 1.0 + 2.0 * std::f32::consts::PI * (cell_ndx as f32 / 32.0);
    let (sx, cx) = angle_x.sin_cos();
    let (sy, cy) = angle_y.sin_cos();
    // rotationMatrixX(angleX) * rotationMatrixY(angleY)
    let rot_x = [[1.0, 0.0, 0.0], [0.0, cx, -sx], [0.0, sx, cx]];
    let rot_y = [[cy, 0.0, sy], [0.0, 1.0, 0.0], [-sy, 0.0, cy]];
    let mut matrix = [[0.0f32; 3]; 3];
    for (row, matrix_row) in matrix.iter_mut().enumerate() {
        for (col, value) in matrix_row.iter_mut().enumerate() {
            *value = (0..3).map(|k| rot_x[row][k] * rot_y[k][col]).sum();
        }
    }
    for vertex in 0..4 {
        let p = [coords[3 * vertex], coords[3 * vertex + 1], coords[3 * vertex + 2]];
        for (row, matrix_row) in matrix.iter().enumerate() {
            coords[3 * vertex + row] = matrix_row[0] * p[0] + matrix_row[1] * p[1] + matrix_row[2] * p[2];
        }
    }
    coords
}

struct Mipmap3DCase {
    name: String,
    params: Mipmap3DParameters,
}

impl TestCase for Mipmap3DCase {
    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn name(&self) -> &str {
        &self.name
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.coord_type == CoordType::BasicBias {
            TSW_3D_FLOAT_BIAS_NONE.programs
        } else {
            TSW_3D_FLOAT_NONE.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(Mipmap3DInstance {
            context,
            params: self.params,
        })
    }
}

struct Mipmap3DInstance<'a> {
    context: &'a Context<'a>,
    params: Mipmap3DParameters,
}

impl TestInstance for Mipmap3DInstance<'_> {
    /// `Texture3DMipmapTestInstance`'s constructor and `iterate`, one target per grid cell
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let format = vk::Format::R8G8B8A8_UNORM;
        let tex_format = map_vk_format(format).ok_or_else(|| TestError::NotPorted("no texture format".to_string()))?;
        let format_info = get_texture_format_info(tex_format);
        let (c_scale, c_bias) = (format_info.look_up_scale, format_info.look_up_bias);

        let mut texture = create_test_texture(
            format,
            vk::ImageViewType::_3D,
            [params.width as i32, params.height as i32, params.depth as i32],
            1,
        )?;
        let num_levels = texture.get_num_levels();

        // Fill texture with colored grid.
        for level in 0..num_levels {
            let step = 0xffu32 / (num_levels as u32 - 1);
            let inc = (step * level as u32).clamp(0x00, 0xff);
            let dec = 0xff - inc;
            let color = [inc as f32 / 255.0, dec as f32 / 255.0, 1.0, 1.0];
            clear(
                &mut texture.get_level_mut(level, 0),
                std::array::from_fn(|c| color[c] * c_scale[c] + c_bias[c]),
            );
        }

        const BIAS: [f32; 8] = [1.0, -2.0, 0.8, -0.5, 1.5, 0.9, 2.0, 4.0];
        const PROJECTIONS: [[f32; 4]; 4] = [
            [1.2, 1.0, 0.7, 1.0],
            [1.3, 0.8, 0.6, 2.0],
            [0.8, 1.0, 1.7, 0.6],
            [1.2, 1.0, 1.7, 1.5],
        ];
        let is_projected = params.coord_type == CoordType::Projected;
        let use_lod_bias = params.coord_type == CoordType::BasicBias;
        let sampler = SamplerParams {
            wrap_u: params.wrap.0,
            wrap_v: params.wrap.0,
            wrap_w: params.wrap.0,
            min_filter: if params.min_filter.linear {
                vk::Filter::LINEAR
            } else {
                vk::Filter::NEAREST
            },
            mag_filter: vk::Filter::NEAREST,
            mipmap_mode: if params.min_filter.mip_linear {
                vk::SamplerMipmapMode::LINEAR
            } else {
                vk::SamplerMipmapMode::NEAREST
            },
            min_lod: 0.0,
            max_lod: 1000.0,
            border_color: vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
            compare_op: None,
            unnormalized: false,
            non_seamless: false,
            max_anisotropy: None,
        };
        let tcu_sampler = Sampler {
            wrap_s: params.wrap.1,
            wrap_t: params.wrap.1,
            wrap_r: params.wrap.1,
            filter: if params.min_filter.linear {
                FilterMode::Linear
            } else {
                FilterMode::Nearest
            },
            normalized_coords: true,
            compare: CompareMode::None,
            compare_channel: 0,
            mip_filter: Some(if params.min_filter.mip_linear {
                MipmapFilterMode::Linear
            } else {
                MipmapFilterMode::Nearest
            }),
            seamless_cube_map: true,
        };
        let reference = reference_texture_3d(&texture, params.width, params.height, params.depth);

        // The viewport is divided into 4x4 grid; each cell is a target of the texture's width and height.
        let (cell_width, cell_height) = (params.width, params.height);
        for cell_ndx in 0..16usize {
            let tex_coord = if params.coord_type == CoordType::Affine {
                affine_tex_coord_3d(cell_ndx)
            } else {
                basic_tex_coord_3d(cell_ndx)
            };

            let mut ref_params = ReferenceParams::new(TextureType::Texture3D, tcu_sampler, LodMode::Exact);
            ref_params.mag_filter = Some(FilterMode::Nearest);
            ref_params.base.sampler_type = get_sampler_type(tex_format);
            ref_params.base.color_bias = Vec4::new(c_bias[0], c_bias[1], c_bias[2], c_bias[3]);
            ref_params.base.color_scale = Vec4::new(c_scale[0], c_scale[1], c_scale[2], c_scale[3]);
            ref_params.base.use_bias = use_lod_bias;
            ref_params.base.projected = is_projected;
            let w = PROJECTIONS[cell_ndx % PROJECTIONS.len()];
            if is_projected {
                ref_params.base.w = Vec4::new(w[0], w[1], w[2], w[3]);
            }
            if use_lod_bias {
                ref_params.base.bias = BIAS[cell_ndx % BIAS.len()];
            }

            let mut positions = QUAD_POSITIONS;
            if is_projected {
                for vertex in 0..4 {
                    positions[4 * vertex] *= w[vertex];
                    positions[4 * vertex + 1] *= w[vertex];
                    positions[4 * vertex + 3] *= w[vertex];
                }
            }

            let request = RenderRequest {
                texture: &texture,
                format,
                aspect_mask: vk::ImageAspectFlags::COLOR,
                component_mapping: vk::ComponentMapping {
                    r: vk::ComponentSwizzle::R,
                    g: vk::ComponentSwizzle::G,
                    b: vk::ComponentSwizzle::B,
                    a: vk::ComponentSwizzle::A,
                },
                use_compute: params.use_compute,
                sparse: false,
                width: cell_width,
                height: cell_height,
                tex_width: params.width,
                tex_height: params.height,
                tex_depth: params.depth,
                kind: TexKind::D3,
                sampler,
                tex_coord: &tex_coord,
                positions,
                view_levels: None,
                view_min_lod: None,
                output_format: vk::Format::R8G8B8A8_UNORM,
                program: if use_lod_bias {
                    Program::FloatBias3D
                } else {
                    Program::Float3D
                },
                parameters: ShaderParameters {
                    bias: ref_params.base.bias,
                    reference: 0.0,
                    color_scale: c_scale,
                    color_bias: c_bias,
                    lod: 0,
                },
            };
            let pixels = render_quad_2d(context, &request, context.get_binary_collection())?;
            let rendered = pixels_to_surface(&pixels, cell_width, cell_height);

            // Compare this cell
            let pixel_format = PixelFormat::new(8, 8, 8, 8);
            let is_trilinear = params.min_filter.mip_linear;
            let color_bits = get_bits_vec(pixel_format).map(|bits| (bits - if is_trilinear { 2 } else { 1 }).max(0));
            let lookup_precision = LookupPrecision {
                coord_bits: [20, 20, 20],
                uvw_bits: [16, 16, 16], // Doesn't really matter since pixels are unicolored.
                color_threshold: compute_fixed_point_threshold(color_bits),
                color_mask: get_compare_mask(pixel_format),
                ..LookupPrecision::default()
            };
            let lod_precision = LodPrecision {
                derivate_bits: 10,
                lod_bits: if is_projected { 6 } else { 8 },
            };
            if !verify_texture_result_3d(
                &rendered,
                &reference,
                tex_coord,
                &ref_params,
                &lookup_precision,
                &lod_precision,
                pixel_format,
            )? {
                log::info!("ERROR: Image verification failed in cell {cell_ndx}");
                return Ok(TestStatus::fail("fail"));
            }
        }
        Ok(TestStatus::pass("pass"))
    }
}

/// `populateTextureMipmappingTests`, the `3d` coordinate type and `bias` groups
fn create_mipmap_3d_tests() -> TestCaseGroup {
    let mut group_3d = TestCaseGroup::new("3d");
    for (coord_type, coord_name) in [
        (CoordType::Basic, "basic"),
        (CoordType::Affine, "affine"),
        (CoordType::Projected, "projected"),
    ] {
        let mut coord_type_group = TestCaseGroup::new(coord_name);
        for &min_filter in MIN_FILTER_MODES {
            for &(wrap_name, wrap_vk, wrap_tcu) in WRAP_MODES {
                // Add other size variants to basic cases only.
                let size_end = if coord_type == CoordType::Basic {
                    TEX_3D_SIZES.len()
                } else {
                    1
                };
                // Upstream never resets `useCompute` inside the size loop: from the second size on both cases of a pair run on the compute backend.
                let mut use_compute = false;
                for &(size_name, width, height, depth) in &TEX_3D_SIZES[..size_end] {
                    let mut name = format!("{}_{wrap_name}", min_filter.name);
                    if let Some(size_name) = size_name {
                        name.push('_');
                        name.push_str(size_name);
                    }
                    let mut params = Mipmap3DParameters {
                        coord_type,
                        min_filter,
                        wrap: (wrap_vk, wrap_tcu),
                        width,
                        height,
                        depth,
                        use_compute,
                    };
                    coord_type_group.add_child(Box::new(Mipmap3DCase {
                        name: name.clone(),
                        params,
                    }) as Box<dyn TestCase>);

                    // Compute case.
                    use_compute = true;
                    params.use_compute = true;
                    coord_type_group.add_child(Box::new(Mipmap3DCase {
                        name: format!("{name}_compute"),
                        params,
                    }) as Box<dyn TestCase>);
                }
            }
        }
        group_3d.add_child(coord_type_group);
    }

    // 3D bias variants.
    let mut bias_group = TestCaseGroup::new("bias");
    for &min_filter in MIN_FILTER_MODES {
        let mut params = Mipmap3DParameters {
            coord_type: CoordType::BasicBias,
            min_filter,
            wrap: (vk::SamplerAddressMode::REPEAT, WrapMode::Repeat),
            width: 32,
            height: 32,
            depth: 32,
            use_compute: false,
        };
        bias_group.add_child(Box::new(Mipmap3DCase {
            name: min_filter.name.to_string(),
            params,
        }) as Box<dyn TestCase>);
        params.use_compute = true;
        bias_group.add_child(Box::new(Mipmap3DCase {
            name: format!("{}_compute", min_filter.name),
            params,
        }) as Box<dyn TestCase>);
    }
    group_3d.add_child(bias_group);
    group_3d.add_child(create_lod_control_group("min_lod", LodControl::MinLod, true));
    group_3d.add_child(create_lod_control_group("max_lod", LodControl::MaxLod, true));
    group_3d.add_child(create_lod_control_group("base_level", LodControl::BaseLevel, true));
    group_3d.add_child(create_lod_control_group("max_level", LodControl::MaxLevel, true));
    let mut group_3d_image_view_min_lod = TestCaseGroup::new("image_view_min_lod");
    group_3d_image_view_min_lod.add_child(create_lod_control_group("min_lod", LodControl::ImageViewMinLod, true));
    group_3d_image_view_min_lod.add_child(create_lod_control_group(
        "base_level",
        LodControl::ImageViewMinLodBaseLevel,
        true,
    ));
    group_3d.add_child(group_3d_image_view_min_lod);
    group_3d
}

/// `getMinLodForCell`
fn min_lod_for_cell(cell_ndx: usize) -> f32 {
    const VALUES: [f32; 16] = [
        1.0, 3.5, 2.0, -2.0, 0.0, 3.0, 10.0, 4.8, 5.8, 5.7, -1.9, 4.0, 6.5, 7.1, -1e10, 1000.0,
    ];
    VALUES[cell_ndx % VALUES.len()]
}

/// `getMaxLodForCell`
fn max_lod_for_cell(cell_ndx: usize) -> f32 {
    const VALUES: [f32; 17] = [
        0.0, 0.2, 0.7, 0.4, 1.3, 0.0, 0.5, 1.2, -2.0, 1.0, 0.1, 0.3, 2.7, 1.2, 10.0, -1000.0, 1e10,
    ];
    VALUES[cell_ndx % VALUES.len()]
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum LodControl {
    MinLod,
    MaxLod,
    BaseLevel,
    MaxLevel,
    ImageViewMinLod,
    ImageViewMinLodBaseLevel,
    ImageViewMinLodIntTexCoord,
    ImageViewMinLodBaseLevelIntTexCoord,
}

impl LodControl {
    fn is_image_view_min_lod(self) -> bool {
        matches!(
            self,
            LodControl::ImageViewMinLod
                | LodControl::ImageViewMinLodBaseLevel
                | LodControl::ImageViewMinLodIntTexCoord
                | LodControl::ImageViewMinLodBaseLevelIntTexCoord
        )
    }

    /// `TEST_IMAGE_VIEW_MINLOD_INT_TEX_COORD` and its base level twin: `texelFetch` on a device with robustImageAccess2
    fn is_int_tex_coord(self) -> bool {
        matches!(
            self,
            LodControl::ImageViewMinLodIntTexCoord | LodControl::ImageViewMinLodBaseLevelIntTexCoord
        )
    }
}

/// `getLodTexelFetch` of the integer texel coordinate instances
fn lod_texel_fetch_for_cell(cell_ndx: usize, base_level: i32, max_level: i32) -> i32 {
    let mut rnd = Random::new(cell_ndx as u32 + 1);
    rnd.get_int(base_level, max_level) - base_level
}

/// The two features of `Texture{2D,3D}ImageViewMinLodIntTexCoordTest::checkSupport` beyond the plain min lod ones
fn check_robust_image_access2_support(context: &Context<'_>) -> Result<(), TestError> {
    if !context.is_device_functionality_supported("VK_KHR_robustness2")
        && !context.is_device_functionality_supported("VK_EXT_robustness2")
    {
        return Err(TestError::NotSupported(
            "VK_KHR_robustness2 and VK_EXT_robustness2 are not supported".to_string(),
        ));
    }
    let mut robustness2_features = vk::PhysicalDeviceRobustness2FeaturesEXT::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut robustness2_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    if robustness2_features.robust_image_access2 == vk::FALSE {
        return Err(TestError::NotSupported(
            "robustImageAccess2 feature not supported".to_string(),
        ));
    }
    Ok(())
}

/// `getImageViewMinLod` of every `Texture*ImageViewMinLod*TestInstance`
fn image_view_min_lod_for_cell(cell_ndx: usize, base_level: i32, max_level: i32) -> f32 {
    let mut rnd = Random::new(cell_ndx as u32 + 1);
    // baselevel + 1.0 as minimum, to test that minLod is working. If we go over the maximum, use that instead.
    let min_value = (base_level as f32 + 1.0).min(max_level as f32);
    rnd.get_float_range(min_value, max_level as f32)
}

/// `checkTextureSupport` for a test type other than `TEST_NORMAL`
fn check_image_view_min_lod_support(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_image_view_min_lod")?;
    let mut min_lod_features = vk::PhysicalDeviceImageViewMinLodFeaturesEXT::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut min_lod_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    if min_lod_features.min_lod == vk::FALSE {
        return Err(TestError::NotSupported(
            "VK_EXT_image_view_min_lod minLod feature not supported".to_string(),
        ));
    }
    Ok(())
}

#[derive(Clone, Copy)]
struct LodControlParameters {
    control: LodControl,
    min_filter: MipMinFilter,
    use_compute: bool,
    three_d: bool,
}

struct LodControlCase {
    name: String,
    params: LodControlParameters,
}

impl TestCase for LodControlCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.params.control.is_image_view_min_lod() {
            check_image_view_min_lod_support(context)?;
        }
        if self.params.control.is_int_tex_coord() {
            check_robust_image_access2_support(context)?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match (self.params.three_d, self.params.control.is_int_tex_coord()) {
            (true, true) => FETCH_LOD_3D.programs,
            (false, true) => FETCH_LOD_2D.programs,
            (true, false) => TSW_3D_FLOAT_NONE.programs,
            (false, false) => TSW_2D_FLOAT_NONE.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(LodControlInstance {
            context,
            params: self.params,
        })
    }
}

struct LodControlInstance<'a> {
    context: &'a Context<'a>,
    params: LodControlParameters,
}

impl TestInstance for LodControlInstance<'_> {
    /// `Texture{2D,3D}LodControlTestInstance`'s constructor and `iterate`, one target per grid cell
    fn iterate(&mut self) -> TestOutcome {
        let params = self.params;
        // The integer texel coordinate cases read out of range levels, which is only defined with robustImageAccess2
        let robust_context;
        let context: &Context<'_> = if params.control.is_int_tex_coord() {
            robust_context = Context::new_with_robustness(
                self.context.get_platform(),
                self.context.get_physical_device(),
                self.context.get_binary_collection(),
                RobustnessFeatures {
                    robust_image_access2: true,
                    ..Default::default()
                },
            )?;
            &robust_context
        } else {
            self.context
        };
        let three_d = params.three_d;
        let format = vk::Format::R8G8B8A8_UNORM;
        let tex_format = map_vk_format(format).ok_or_else(|| TestError::NotPorted("no texture format".to_string()))?;
        let format_info = get_texture_format_info(tex_format);
        let (c_scale, c_bias) = if three_d {
            (format_info.look_up_scale, format_info.look_up_bias)
        } else {
            ([1.0; 4], [0.0; 4])
        };
        let (tex_width, tex_height, tex_depth) = if three_d { (32u32, 32u32, 32u32) } else { (64, 64, 1) };

        let view_type = if three_d {
            vk::ImageViewType::_3D
        } else {
            vk::ImageViewType::_2D
        };
        let mut texture = create_test_texture(
            format,
            view_type,
            [tex_width as i32, tex_height as i32, tex_depth as i32],
            1,
        )?;
        let num_levels = texture.get_num_levels();
        // Fill texture with colored grid.
        for level in 0..num_levels {
            let step = 0xffu32 / (num_levels as u32 - 1);
            let inc = (step * level as u32).clamp(0x00, 0xff);
            let dec = 0xff - inc;
            let color = [1.0, dec as f32 / 255.0, inc as f32 / 255.0, 1.0];
            clear(
                &mut texture.get_level_mut(level, 0),
                std::array::from_fn(|c| color[c] * c_scale[c] + c_bias[c]),
            );
        }
        let reference_2d = if three_d {
            None
        } else {
            Some(reference_texture_2d(&texture, tex_width, tex_height))
        };
        let reference_3d = if three_d {
            Some(reference_texture_3d(&texture, tex_width, tex_height, tex_depth))
        } else {
            None
        };

        // The 3D group clamps to edge, the 2D one repeats
        let (tcu_wrap, vk_wrap) = if three_d {
            (WrapMode::ClampToEdge, vk::SamplerAddressMode::CLAMP_TO_EDGE)
        } else {
            (WrapMode::Repeat, vk::SamplerAddressMode::REPEAT)
        };
        let tcu_sampler = Sampler {
            wrap_s: tcu_wrap,
            wrap_t: tcu_wrap,
            wrap_r: tcu_wrap,
            filter: if params.min_filter.linear {
                FilterMode::Linear
            } else {
                FilterMode::Nearest
            },
            normalized_coords: true,
            compare: CompareMode::None,
            compare_channel: 0,
            mip_filter: Some(if params.min_filter.mip_linear {
                MipmapFilterMode::Linear
            } else {
                MipmapFilterMode::Nearest
            }),
            seamless_cube_map: true,
        };
        let mut ref_params = ReferenceParams::new(
            if three_d {
                TextureType::Texture3D
            } else {
                TextureType::Texture2D
            },
            tcu_sampler,
            LodMode::Exact,
        );
        ref_params.mag_filter = Some(FilterMode::Nearest);
        ref_params.base.sampler_type = get_sampler_type(tex_format);
        ref_params.base.color_bias = Vec4::new(c_bias[0], c_bias[1], c_bias[2], c_bias[3]);
        ref_params.base.color_scale = Vec4::new(c_scale[0], c_scale[1], c_scale[2], c_scale[3]);
        ref_params.max_level = (tex_width.max(tex_height).max(tex_depth)).ilog2() as i32;

        let is_trilinear = params.min_filter.mip_linear;
        let pixel_format = PixelFormat::new(8, 8, 8, 8);
        let color_bits = get_bits_vec(pixel_format).map(|bits| (bits - if is_trilinear { 2 } else { 1 }).max(0));
        let lookup_precision = LookupPrecision {
            coord_bits: if three_d { [20, 20, 20] } else { [20, 20, 0] },
            uvw_bits: if three_d { [16, 16, 16] } else { [16, 16, 0] }, // Doesn't really matter since pixels are unicolored.
            color_threshold: compute_fixed_point_threshold(color_bits),
            color_mask: get_compare_mask(pixel_format),
            ..LookupPrecision::default()
        };
        let lod_precision = LodPrecision {
            derivate_bits: 10,
            lod_bits: 8,
        };
        let (base_hash_xor, max_hash_xor) = if three_d {
            (0x0073_47e9u32, 0x0091_11e7u32)
        } else {
            (0xac2f_274a, 0x082c_fa4e)
        };

        let verify_cell = |ref_params: &ReferenceParams,
                           rendered: &crate::tcu::Surface,
                           tex_coord: &[f32]|
         -> Result<bool, TestError> {
            if let Some(reference) = &reference_3d {
                let coords: [f32; 12] = tex_coord.try_into().expect("a 3D cell has twelve coordinates");
                verify_texture_result_3d(
                    rendered,
                    reference,
                    coords,
                    ref_params,
                    &lookup_precision,
                    &lod_precision,
                    pixel_format,
                )
            } else if let Some(reference) = &reference_2d {
                let coords: [f32; 8] = tex_coord.try_into().expect("a 2D cell has eight coordinates");
                verify_texture_result_2d(
                    rendered,
                    reference,
                    coords,
                    ref_params,
                    &lookup_precision,
                    &lod_precision,
                    pixel_format,
                )
            } else {
                unreachable!("one of the two reference textures is built")
            }
        };
        let mut deferred_cells: Vec<(ReferenceParams, crate::tcu::Surface, Vec<f32>)> = Vec::new();

        // Viewport is divided into 4x4 grid; each cell is a target of the texture's width and height.
        for cell_ndx in 0..16usize {
            // getReferenceParams (the fields it does not set keep what an earlier cell left, as upstream's shared params do)
            match params.control {
                LodControl::MinLod | LodControl::ImageViewMinLod => ref_params.min_lod = min_lod_for_cell(cell_ndx),
                LodControl::MaxLod => ref_params.max_lod = max_lod_for_cell(cell_ndx),
                LodControl::ImageViewMinLodIntTexCoord => {}
                LodControl::BaseLevel
                | LodControl::ImageViewMinLodBaseLevel
                | LodControl::ImageViewMinLodBaseLevelIntTexCoord => {
                    let hash = de_int32_hash(cell_ndx as i32) ^ de_string_hash(params.min_filter.name) ^ base_hash_xor;
                    ref_params.base_level = (hash % num_levels as u32) as i32;
                }
                LodControl::MaxLevel => {
                    let hash = de_int32_hash(cell_ndx as i32) ^ de_string_hash(params.min_filter.name) ^ max_hash_xor;
                    ref_params.max_level = (hash % num_levels as u32) as i32;
                }
            }
            if params.control.is_image_view_min_lod() {
                ref_params.image_view_min_lod =
                    image_view_min_lod_for_cell(cell_ndx, ref_params.base_level, ref_params.max_level);
            }
            if params.control.is_int_tex_coord() {
                ref_params.base.sampler_type = SamplerType::FetchFloat;
                ref_params.lod_texel_fetch =
                    lod_texel_fetch_for_cell(cell_ndx, ref_params.base_level, ref_params.max_level);
            }

            let sampler = SamplerParams {
                wrap_u: vk_wrap,
                wrap_v: vk_wrap,
                wrap_w: vk_wrap,
                min_filter: if params.min_filter.linear {
                    vk::Filter::LINEAR
                } else {
                    vk::Filter::NEAREST
                },
                mag_filter: vk::Filter::NEAREST,
                mipmap_mode: if params.min_filter.mip_linear {
                    vk::SamplerMipmapMode::LINEAR
                } else {
                    vk::SamplerMipmapMode::NEAREST
                },
                min_lod: ref_params.min_lod,
                max_lod: ref_params.max_lod,
                border_color: vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
                compare_op: None,
                unnormalized: false,
                non_seamless: false,
                max_anisotropy: None,
            };
            let tex_coord_2d;
            let tex_coord_3d;
            let tex_coord: &[f32] = if three_d {
                tex_coord_3d = basic_tex_coord_3d(cell_ndx);
                &tex_coord_3d
            } else {
                let (coord_bl, coord_tr) = basic_coords(cell_ndx);
                tex_coord_2d = compute_quad_tex_coord_2d(coord_bl, coord_tr);
                &tex_coord_2d
            };
            let request = RenderRequest {
                texture: &texture,
                format,
                aspect_mask: vk::ImageAspectFlags::COLOR,
                component_mapping: vk::ComponentMapping {
                    r: vk::ComponentSwizzle::R,
                    g: vk::ComponentSwizzle::G,
                    b: vk::ComponentSwizzle::B,
                    a: vk::ComponentSwizzle::A,
                },
                use_compute: params.use_compute,
                sparse: false,
                width: tex_width,
                height: tex_height,
                tex_width,
                tex_height,
                tex_depth,
                kind: if three_d { TexKind::D3 } else { TexKind::D2 },
                sampler,
                tex_coord,
                positions: QUAD_POSITIONS,
                view_levels: Some((ref_params.base_level as u32, ref_params.max_level as u32)),
                view_min_lod: params
                    .control
                    .is_image_view_min_lod()
                    .then_some(ref_params.image_view_min_lod),
                output_format: vk::Format::R8G8B8A8_UNORM,
                program: match (three_d, params.control.is_int_tex_coord()) {
                    (true, true) => Program::Fetch3D,
                    (false, true) => Program::Fetch2D,
                    (true, false) => Program::Float3D,
                    (false, false) => Program::Float2D,
                },
                parameters: ShaderParameters {
                    bias: 0.0,
                    reference: 0.0,
                    color_scale: c_scale,
                    color_bias: c_bias,
                    lod: if params.control.is_int_tex_coord() {
                        ref_params.lod_texel_fetch
                    } else {
                        0
                    },
                },
            };
            let pixels = render_quad_2d(context, &request, context.get_binary_collection())?;
            let rendered = pixels_to_surface(&pixels, tex_width, tex_height);

            if params.control.is_image_view_min_lod() {
                // The integer texel coordinate cells are verified over the whole 0..1 range, whatever was rendered
                let verify_coords = if !params.control.is_int_tex_coord() {
                    tex_coord.to_vec()
                } else if three_d {
                    vec![0.0, 0.0, 0.0, 0.0, 1.0, 0.5, 1.0, 0.0, 0.5, 1.0, 1.0, 1.0]
                } else {
                    compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0)).to_vec()
                };
                deferred_cells.push((ref_params, rendered, verify_coords));
                continue;
            }
            if !verify_cell(&ref_params, &rendered, tex_coord)? {
                log::info!("ERROR: Image verification failed in cell {cell_ndx}");
                return Ok(TestStatus::fail("fail"));
            }
        }
        if params.control.is_image_view_min_lod() {
            let mut all_ok = true;
            for (cell_params, rendered, tex_coord) in &deferred_cells {
                all_ok &= verify_cell(cell_params, rendered, tex_coord)?;
            }
            // The floor of minLod is also a valid reading of the spec (compareAndLogImages with IMAGEVIEWMINLODMODE_ALTERNATIVE).
            if !all_ok && ref_params.image_view_min_lod > 0.0 {
                all_ok = true;
                for (cell_params, rendered, tex_coord) in &deferred_cells {
                    let mut alternative = *cell_params;
                    alternative.image_view_min_lod_alternative = true;
                    all_ok &= verify_cell(&alternative, rendered, tex_coord)?;
                }
            }
            if !all_ok {
                log::info!("ERROR: Image verification failed");
                return Ok(TestStatus::fail("fail"));
            }
        }
        Ok(TestStatus::pass("pass"))
    }
}

fn create_lod_control_group(name: &str, control: LodControl, three_d: bool) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    for &min_filter in MIN_FILTER_MODES {
        let mut params = LodControlParameters {
            control,
            min_filter,
            use_compute: false,
            three_d,
        };
        group.add_child(Box::new(LodControlCase {
            name: min_filter.name.to_string(),
            params,
        }) as Box<dyn TestCase>);

        // Compute case.
        params.use_compute = true;
        group.add_child(Box::new(LodControlCase {
            name: format!("{}_compute", min_filter.name),
            params,
        }) as Box<dyn TestCase>);

        // The same through texelFetch with integer texel coordinates, for the image view min lod groups.
        let int_control = match control {
            LodControl::ImageViewMinLod => LodControl::ImageViewMinLodIntTexCoord,
            LodControl::ImageViewMinLodBaseLevel => LodControl::ImageViewMinLodBaseLevelIntTexCoord,
            _ => continue,
        };
        params.control = int_control;
        params.use_compute = false;
        group.add_child(Box::new(LodControlCase {
            name: format!("{}_integer_texel_coord", min_filter.name),
            params,
        }) as Box<dyn TestCase>);
        params.use_compute = true;
        group.add_child(Box::new(LodControlCase {
            name: format!("{}_integer_texel_coord_compute", min_filter.name),
            params,
        }) as Box<dyn TestCase>);
    }
    group
}

/// `randomPartition`
fn random_partition(dst: &mut Vec<[u32; 4]>, rnd: &mut Random, x: u32, y: u32, width: u32, height: u32) {
    let min_width = 8;
    let min_height = 8;
    let partition = rnd.get_float() > 0.4;
    let partition_x = partition && width > min_width && rnd.get_bool();
    let partition_y = partition && height > min_height && !partition_x;

    if partition_x {
        let split = (width as i32 / 2 + rnd.get_int(-(width as i32) / 4, width as i32 / 4)) as u32;
        random_partition(dst, rnd, x, y, split, height);
        random_partition(dst, rnd, x + split, y, width - split, height);
    } else if partition_y {
        let split = (height as i32 / 2 + rnd.get_int(-(height as i32) / 4, height as i32 / 4)) as u32;
        random_partition(dst, rnd, x, y, width, split);
        random_partition(dst, rnd, x, y + split, width, height - split);
    } else {
        dst.push([x, y, width, height]);
    }
}

/// `computeGridLayout`
fn compute_grid_layout(width: u32, height: u32) -> Vec<[u32; 4]> {
    let mut rnd = Random::new(7);
    let mut layout = Vec::new();
    random_partition(&mut layout, &mut rnd, 0, 0, width, height);
    layout
}

/// `TextureCubeMipmapTestCaseParameters`
#[derive(Clone, Copy)]
struct MipmapCubeParameters {
    coord_type: CoordType,
    min_filter: MipMinFilter,
    mag_linear: bool,
    wrap: (vk::SamplerAddressMode, WrapMode),
    use_compute: bool,
}

struct MipmapCubeCase {
    name: String,
    params: MipmapCubeParameters,
}

impl TestCase for MipmapCubeCase {
    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn name(&self) -> &str {
        &self.name
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.coord_type == CoordType::BasicBias {
            TSW_CUBE_FLOAT_BIAS_NONE.programs
        } else {
            TSW_CUBE_FLOAT_NONE.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MipmapCubeInstance {
            context,
            params: self.params,
        })
    }
}

struct MipmapCubeInstance<'a> {
    context: &'a Context<'a>,
    params: MipmapCubeParameters,
}

impl TestInstance for MipmapCubeInstance<'_> {
    /// `TextureCubeMipmapTestInstance`'s constructor and `iterate`, one target per cell of the random grid
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let format = vk::Format::R8G8B8A8_UNORM;
        let size = 64u32;

        let mut texture = create_test_texture(format, vk::ImageViewType::CUBE, [size as i32, size as i32, 1], 1)?;
        let num_levels = texture.get_num_levels();

        // Fill texture with colored grid.
        for face in 0..6u32 {
            for level in 0..num_levels {
                let step = 0xffu32 / (num_levels as u32 - 1);
                let inc = (step * level as u32).clamp(0x00, 0xff);
                let dec = 0xff - inc;
                // (red, green, blue) of the packed 0xAABBGGRR-style constant `(r << 16) | (g << 8) | b` read back as a tcu::RGBA
                let rgb = match face {
                    0 => (inc << 16) | (dec << 8) | 255,
                    1 => (255 << 16) | (inc << 8) | dec,
                    2 => (dec << 16) | (255 << 8) | inc,
                    3 => (dec << 16) | (inc << 8) | 255,
                    4 => (255 << 16) | (dec << 8) | inc,
                    _ => (inc << 16) | (255 << 8) | dec,
                };
                let color = [
                    (rgb & 0xff) as f32 / 255.0,
                    ((rgb >> 8) & 0xff) as f32 / 255.0,
                    ((rgb >> 16) & 0xff) as f32 / 255.0,
                    1.0,
                ];
                clear(&mut texture.get_level_mut(level, face), color);
            }
        }
        let reference = reference_texture_cube(&texture, size);

        let is_projected = params.coord_type == CoordType::Projected;
        let use_lod_bias = params.coord_type == CoordType::BasicBias;
        let sampler = SamplerParams {
            wrap_u: params.wrap.0,
            wrap_v: params.wrap.0,
            wrap_w: params.wrap.0,
            min_filter: if params.min_filter.linear {
                vk::Filter::LINEAR
            } else {
                vk::Filter::NEAREST
            },
            mag_filter: if params.mag_linear {
                vk::Filter::LINEAR
            } else {
                vk::Filter::NEAREST
            },
            mipmap_mode: if params.min_filter.mip_linear {
                vk::SamplerMipmapMode::LINEAR
            } else {
                vk::SamplerMipmapMode::NEAREST
            },
            min_lod: 0.0,
            max_lod: 1000.0,
            border_color: vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
            compare_op: None,
            unnormalized: false,
            non_seamless: false,
            max_anisotropy: None,
        };
        let tcu_sampler = Sampler {
            wrap_s: params.wrap.1,
            wrap_t: params.wrap.1,
            wrap_r: params.wrap.1,
            filter: if params.min_filter.linear {
                FilterMode::Linear
            } else {
                FilterMode::Nearest
            },
            normalized_coords: true,
            compare: CompareMode::None,
            compare_channel: 0,
            mip_filter: Some(if params.min_filter.mip_linear {
                MipmapFilterMode::Linear
            } else {
                MipmapFilterMode::Nearest
            }),
            seamless_cube_map: true,
        };
        let tex_format = map_vk_format(format).ok_or_else(|| TestError::NotPorted("no texture format".to_string()))?;

        const BIAS: [f32; 8] = [1.0, -2.0, 0.8, -0.5, 1.5, 0.9, 2.0, 4.0];
        // Projection values: less aggressive than in the 2D case due to smaller quads.
        const PROJECTIONS: [[f32; 4]; 4] = [
            [1.2, 1.0, 0.7, 1.0],
            [1.3, 0.8, 0.6, 1.1],
            [0.8, 1.0, 1.2, 0.8],
            [1.2, 1.0, 1.3, 0.9],
        ];
        // Compute grid.
        let grid_layout = compute_grid_layout(size * 2, size * 2);
        for (cell_ndx, &[_, _, cell_width, cell_height]) in grid_layout.iter().enumerate() {
            let cube_face = [
                CubeFace::NegativeX,
                CubeFace::PositiveX,
                CubeFace::NegativeY,
                CubeFace::PositiveY,
                CubeFace::NegativeZ,
                CubeFace::PositiveZ,
            ][cell_ndx % 6];
            let tex_coord = compute_quad_tex_coord_cube(cube_face);

            let mut ref_params = ReferenceParams::new(TextureType::Cube, tcu_sampler, LodMode::Exact); // Use ideal lod.
            ref_params.mag_filter = Some(if params.mag_linear {
                FilterMode::Linear
            } else {
                FilterMode::Nearest
            });
            ref_params.base.sampler_type = get_sampler_type(tex_format);
            ref_params.base.use_bias = use_lod_bias;
            ref_params.base.projected = is_projected;
            let w = PROJECTIONS[cell_ndx % PROJECTIONS.len()];
            if is_projected {
                ref_params.base.w = Vec4::new(w[0], w[1], w[2], w[3]);
            }
            if use_lod_bias {
                ref_params.base.bias = BIAS[cell_ndx % BIAS.len()];
            }

            let mut positions = QUAD_POSITIONS;
            if is_projected {
                for vertex in 0..4 {
                    positions[4 * vertex] *= w[vertex];
                    positions[4 * vertex + 1] *= w[vertex];
                    positions[4 * vertex + 3] *= w[vertex];
                }
            }

            let request = RenderRequest {
                texture: &texture,
                format,
                aspect_mask: vk::ImageAspectFlags::COLOR,
                component_mapping: vk::ComponentMapping {
                    r: vk::ComponentSwizzle::R,
                    g: vk::ComponentSwizzle::G,
                    b: vk::ComponentSwizzle::B,
                    a: vk::ComponentSwizzle::A,
                },
                use_compute: params.use_compute,
                sparse: false,
                width: cell_width,
                height: cell_height,
                tex_width: size,
                tex_height: size,
                tex_depth: 6,
                kind: TexKind::Cube,
                sampler,
                tex_coord: &tex_coord,
                positions,
                view_levels: None,
                view_min_lod: None,
                output_format: vk::Format::R8G8B8A8_UNORM,
                program: if use_lod_bias {
                    Program::FloatBiasCube
                } else {
                    Program::FloatCube
                },
                parameters: ShaderParameters {
                    bias: ref_params.base.bias,
                    reference: 0.0,
                    color_scale: [1.0; 4],
                    color_bias: [0.0; 4],
                    lod: 0,
                },
            };
            let pixels = render_quad_2d(context, &request, context.get_binary_collection())?;
            let rendered = pixels_to_surface(&pixels, cell_width, cell_height);

            // Compare this cell
            let pixel_format = PixelFormat::new(8, 8, 8, 8);
            let color_bits = get_bits_vec(pixel_format).map(|bits| (bits - 2).max(0));
            let lookup_precision = LookupPrecision {
                color_mask: get_compare_mask(pixel_format),
                color_threshold: compute_fixed_point_threshold(color_bits),
                coord_bits: if is_projected { [8; 3] } else { [10; 3] },
                uvw_bits: [5, 5, 0],
                ..LookupPrecision::default()
            };
            let lod_precision = LodPrecision {
                derivate_bits: 10,
                lod_bits: if is_projected { 3 } else { 6 },
            };
            if !verify_texture_result_cube(
                &rendered,
                &reference,
                tex_coord,
                &ref_params,
                &lookup_precision,
                &lod_precision,
                pixel_format,
            )? {
                log::info!("ERROR: Image verification failed in cell {cell_ndx}");
                return Ok(TestStatus::fail("fail"));
            }
        }
        Ok(TestStatus::pass("pass"))
    }
}

struct CubeLodControlCase {
    name: String,
    params: LodControlParameters,
}

impl TestCase for CubeLodControlCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.params.control.is_image_view_min_lod() {
            check_image_view_min_lod_support(context)?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        TSW_CUBE_FLOAT_NONE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CubeLodControlInstance {
            context,
            params: self.params,
        })
    }
}

struct CubeLodControlInstance<'a> {
    context: &'a Context<'a>,
    params: LodControlParameters,
}

impl TestInstance for CubeLodControlInstance<'_> {
    /// `TextureCubeLodControlTestInstance`'s constructor and `iterate`, one target per cell of the random grid
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let format = vk::Format::R8G8B8A8_UNORM;
        let size = 64u32;
        let tex_format = map_vk_format(format).ok_or_else(|| TestError::NotPorted("no texture format".to_string()))?;

        let mut texture = create_test_texture(format, vk::ImageViewType::CUBE, [size as i32, size as i32, 1], 1)?;
        let num_levels = texture.get_num_levels();

        // Fill texture with colored grid.
        for face in 0..6u32 {
            for level in 0..num_levels {
                let step = 0xffu32 / (num_levels as u32 - 1);
                let inc = (step * level as u32).clamp(0x00, 0xff);
                let dec = 0xff - inc;
                let rgb = match face {
                    0 => (inc << 16) | (dec << 8) | 255,
                    1 => (255 << 16) | (inc << 8) | dec,
                    2 => (dec << 16) | (255 << 8) | inc,
                    3 => (dec << 16) | (inc << 8) | 255,
                    4 => (255 << 16) | (dec << 8) | inc,
                    _ => (inc << 16) | (255 << 8) | dec,
                };
                let color = [
                    (rgb & 0xff) as f32 / 255.0,
                    ((rgb >> 8) & 0xff) as f32 / 255.0,
                    ((rgb >> 16) & 0xff) as f32 / 255.0,
                    1.0,
                ];
                clear(&mut texture.get_level_mut(level, face), color);
            }
        }
        let reference = reference_texture_cube(&texture, size);

        let tcu_sampler = Sampler {
            wrap_s: WrapMode::ClampToEdge,
            wrap_t: WrapMode::ClampToEdge,
            wrap_r: WrapMode::ClampToEdge,
            filter: if params.min_filter.linear {
                FilterMode::Linear
            } else {
                FilterMode::Nearest
            },
            normalized_coords: true,
            compare: CompareMode::None,
            compare_channel: 0,
            mip_filter: Some(if params.min_filter.mip_linear {
                MipmapFilterMode::Linear
            } else {
                MipmapFilterMode::Nearest
            }),
            seamless_cube_map: true,
        };
        let mut ref_params = ReferenceParams::new(TextureType::Cube, tcu_sampler, LodMode::Exact);
        ref_params.mag_filter = Some(FilterMode::Nearest);
        ref_params.base.sampler_type = get_sampler_type(tex_format);
        ref_params.max_level = size.ilog2() as i32;

        let pixel_format = PixelFormat::new(8, 8, 8, 8);
        let color_bits = get_bits_vec(pixel_format).map(|bits| (bits - 2).max(0));
        let lookup_precision = LookupPrecision {
            color_mask: get_compare_mask(pixel_format),
            color_threshold: compute_fixed_point_threshold(color_bits),
            coord_bits: [10; 3],
            uvw_bits: [5, 5, 0],
            ..LookupPrecision::default()
        };
        let lod_precision = LodPrecision {
            derivate_bits: 10,
            lod_bits: 6,
        };

        let verify_cell = |ref_params: &ReferenceParams,
                           rendered: &crate::tcu::Surface,
                           tex_coord: [f32; 12]|
         -> Result<bool, TestError> {
            verify_texture_result_cube(
                rendered,
                &reference,
                tex_coord,
                ref_params,
                &lookup_precision,
                &lod_precision,
                pixel_format,
            )
        };
        let mut deferred_cells: Vec<(ReferenceParams, crate::tcu::Surface, [f32; 12])> = Vec::new();
        let grid_layout = compute_grid_layout(size * 2, size * 2);
        for (cell_ndx, &[_, _, cell_width, cell_height]) in grid_layout.iter().enumerate() {
            let cube_face = [
                CubeFace::NegativeX,
                CubeFace::PositiveX,
                CubeFace::NegativeY,
                CubeFace::PositiveY,
                CubeFace::NegativeZ,
                CubeFace::PositiveZ,
            ][cell_ndx % 6];
            let tex_coord = compute_quad_tex_coord_cube(cube_face);

            match params.control {
                LodControl::MinLod | LodControl::ImageViewMinLod => ref_params.min_lod = min_lod_for_cell(cell_ndx),
                LodControl::MaxLod => ref_params.max_lod = max_lod_for_cell(cell_ndx),
                LodControl::BaseLevel | LodControl::ImageViewMinLodBaseLevel => {
                    let hash = de_int32_hash(cell_ndx as i32) ^ de_string_hash(params.min_filter.name) ^ 0x023f_ae13;
                    ref_params.base_level = (hash % num_levels as u32) as i32;
                }
                LodControl::ImageViewMinLodIntTexCoord | LodControl::ImageViewMinLodBaseLevelIntTexCoord => {
                    unreachable!("the cube map groups have no integer texel coordinate cases")
                }
                LodControl::MaxLevel => {
                    let hash = de_int32_hash(cell_ndx as i32) ^ de_string_hash(params.min_filter.name) ^ 0x0097_4e21;
                    ref_params.max_level = (hash % num_levels as u32) as i32;
                }
            }
            if params.control.is_image_view_min_lod() {
                ref_params.image_view_min_lod =
                    image_view_min_lod_for_cell(cell_ndx, ref_params.base_level, ref_params.max_level);
            }

            let sampler = SamplerParams {
                wrap_u: vk::SamplerAddressMode::CLAMP_TO_EDGE,
                wrap_v: vk::SamplerAddressMode::CLAMP_TO_EDGE,
                wrap_w: vk::SamplerAddressMode::CLAMP_TO_EDGE,
                min_filter: if params.min_filter.linear {
                    vk::Filter::LINEAR
                } else {
                    vk::Filter::NEAREST
                },
                mag_filter: vk::Filter::NEAREST,
                mipmap_mode: if params.min_filter.mip_linear {
                    vk::SamplerMipmapMode::LINEAR
                } else {
                    vk::SamplerMipmapMode::NEAREST
                },
                min_lod: ref_params.min_lod,
                max_lod: ref_params.max_lod,
                border_color: vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
                compare_op: None,
                unnormalized: false,
                non_seamless: false,
                max_anisotropy: None,
            };
            let request = RenderRequest {
                texture: &texture,
                format,
                aspect_mask: vk::ImageAspectFlags::COLOR,
                component_mapping: vk::ComponentMapping {
                    r: vk::ComponentSwizzle::R,
                    g: vk::ComponentSwizzle::G,
                    b: vk::ComponentSwizzle::B,
                    a: vk::ComponentSwizzle::A,
                },
                use_compute: params.use_compute,
                sparse: false,
                width: cell_width,
                height: cell_height,
                tex_width: size,
                tex_height: size,
                tex_depth: 6,
                kind: TexKind::Cube,
                sampler,
                tex_coord: &tex_coord,
                positions: QUAD_POSITIONS,
                view_levels: Some((ref_params.base_level as u32, ref_params.max_level as u32)),
                view_min_lod: params
                    .control
                    .is_image_view_min_lod()
                    .then_some(ref_params.image_view_min_lod),
                output_format: vk::Format::R8G8B8A8_UNORM,
                program: Program::FloatCube,
                parameters: ShaderParameters {
                    bias: 0.0,
                    reference: 0.0,
                    color_scale: [1.0; 4],
                    color_bias: [0.0; 4],
                    lod: 0,
                },
            };
            let pixels = render_quad_2d(context, &request, context.get_binary_collection())?;
            let rendered = pixels_to_surface(&pixels, cell_width, cell_height);

            if params.control.is_image_view_min_lod() {
                deferred_cells.push((ref_params, rendered, tex_coord));
                continue;
            }
            if !verify_cell(&ref_params, &rendered, tex_coord)? {
                log::info!("ERROR: Image verification failed in cell {cell_ndx}");
                return Ok(TestStatus::fail("fail"));
            }
        }
        if params.control.is_image_view_min_lod() {
            let mut all_ok = true;
            for (cell_params, rendered, tex_coord) in &deferred_cells {
                all_ok &= verify_cell(cell_params, rendered, *tex_coord)?;
            }
            // The floor of minLod is also a valid reading of the spec (compareAndLogImages with IMAGEVIEWMINLODMODE_ALTERNATIVE).
            if !all_ok && ref_params.image_view_min_lod > 0.0 {
                all_ok = true;
                for (cell_params, rendered, tex_coord) in &deferred_cells {
                    let mut alternative = *cell_params;
                    alternative.image_view_min_lod_alternative = true;
                    all_ok &= verify_cell(&alternative, rendered, *tex_coord)?;
                }
            }
            if !all_ok {
                log::info!("ERROR: Image verification failed");
                return Ok(TestStatus::fail("fail"));
            }
        }
        Ok(TestStatus::pass("pass"))
    }
}

struct CubeProjectedDerivativesCase;

impl TestCase for CubeProjectedDerivativesCase {
    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn name(&self) -> &str {
        "projected_derivatives"
    }

    fn programs(&self) -> BinaryCollection {
        PROJECTED_DERIVATIVES.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CubeProjectedDerivativesInstance { context })
    }
}

struct CubeProjectedDerivativesInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for CubeProjectedDerivativesInstance<'_> {
    /// `TextureCubeProjectedDerivativesTestInstance::iterate` (the sampler's `reductionMode` MIN is left out: it only reduces linear taps and the filters are nearest)
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let size = 256u32;
        let format = vk::Format::R8G8B8A8_UNORM;
        let mut texture = create_test_texture(format, vk::ImageViewType::CUBE, [size as i32, size as i32, 1], 1)?;

        // Packed ABGR, as tcu::RGBA reads them
        let face_colors: [u32; 6] = [0xff0000ff, 0xffffff00, 0xff00ff00, 0xffff00ff, 0xffff0000, 0xff00ffff];
        let corner_directions: [[f32; 2]; 4] = {
            let n = std::f32::consts::FRAC_1_SQRT_2;
            [[-n, n], [n, n], [n, -n], [-n, -n]]
        };
        let epsilon = 0.01f32;

        // assign to each subsequent mip level half of RGB values
        for face in 0..6u32 {
            let mut channels = [
                face_colors[face as usize] & 0xff,
                (face_colors[face as usize] >> 8) & 0xff,
                (face_colors[face as usize] >> 16) & 0xff,
            ];
            for level in 0..9usize {
                clear(
                    &mut texture.get_level_mut(level, face),
                    [
                        channels[0] as f32 / 255.0,
                        channels[1] as f32 / 255.0,
                        channels[2] as f32 / 255.0,
                        1.0,
                    ],
                );
                for channel in &mut channels {
                    *channel /= 2;
                }
            }
        }

        let mut pass = true;
        let v = 0.02f32;
        let sampler = SamplerParams {
            wrap_u: vk::SamplerAddressMode::CLAMP_TO_EDGE,
            wrap_v: vk::SamplerAddressMode::CLAMP_TO_EDGE,
            wrap_w: vk::SamplerAddressMode::CLAMP_TO_EDGE,
            min_filter: vk::Filter::NEAREST,
            mag_filter: vk::Filter::NEAREST,
            mipmap_mode: vk::SamplerMipmapMode::NEAREST,
            min_lod: -1000.0,
            max_lod: 1000.0,
            border_color: vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
            compare_op: None,
            unnormalized: false,
            non_seamless: false,
            max_anisotropy: None,
        };

        for face_ndx in 0..6u32 {
            let cube_face = [
                CubeFace::NegativeX,
                CubeFace::PositiveX,
                CubeFace::NegativeY,
                CubeFace::PositiveY,
                CubeFace::NegativeZ,
                CubeFace::PositiveZ,
            ][face_ndx as usize];
            let tex_coord = compute_quad_tex_coord_cube(cube_face);

            // all permutations of three component vectors consisting of -1 and +1
            for permutation_ndx in 0..8u32 {
                let dsign: [i32; 3] = [
                    (permutation_ndx & 1) as i32 * 2 - 1,
                    ((permutation_ndx & 2) == 2) as i32 * 2 - 1,
                    ((permutation_ndx & 4) == 4) as i32 * 2 - 1,
                ];
                // -1 for the face at odd index (-X, -Y, -Z) and +1 at even index (+X, +Y, +Z)
                let face_sign = 1 - 2 * (face_ndx as i32 % 2);

                let direction: [i32; 2] = if face_ndx < 2 {
                    [dsign[2] * dsign[0], dsign[1] * dsign[0] * face_sign]
                } else if face_ndx < 4 {
                    [face_sign * (2 * (dsign[0] == dsign[1]) as i32 - 1), dsign[1] * dsign[2]]
                } else {
                    [dsign[0] * -dsign[2], dsign[1] * dsign[2] * face_sign]
                };
                let direction_length = ((direction[0] * direction[0] + direction[1] * direction[1]) as f32).sqrt();
                let expected_gradient_direction = [
                    direction[0] as f32 / direction_length,
                    direction[1] as f32 / direction_length,
                ];

                for use_dy in [false, true] {
                    // the derivatives travel through the colorBias uniform, the fourth component picks dx or dy
                    let d = [dsign[0] as f32 * v, dsign[1] as f32 * v, dsign[2] as f32 * v];
                    let request = RenderRequest {
                        texture: &texture,
                        format,
                        aspect_mask: vk::ImageAspectFlags::COLOR,
                        component_mapping: vk::ComponentMapping {
                            r: vk::ComponentSwizzle::R,
                            g: vk::ComponentSwizzle::G,
                            b: vk::ComponentSwizzle::B,
                            a: vk::ComponentSwizzle::A,
                        },
                        use_compute: false,
                        sparse: false,
                        width: size,
                        height: size,
                        tex_width: size,
                        tex_height: size,
                        tex_depth: 6,
                        kind: TexKind::Cube,
                        sampler,
                        tex_coord: &tex_coord,
                        positions: QUAD_POSITIONS,
                        view_levels: None,
                        view_min_lod: None,
                        output_format: vk::Format::R8G8B8A8_UNORM,
                        program: Program::FloatCube,
                        parameters: ShaderParameters {
                            bias: 0.0,
                            reference: 0.0,
                            color_scale: [1.0; 4],
                            color_bias: [d[0], d[1], d[2], if use_dy { 1.0 } else { 0.0 }],
                            lod: 0,
                        },
                    };
                    let pixels = render_quad_2d(context, &request, context.get_binary_collection())?;
                    let rendered = pixels_to_surface(&pixels, size, size);
                    // all channels summed, to compare the gradient of a face in one number
                    let sum_rgba = |x: i32, y: i32| {
                        let c = rendered.get_pixel(x, y);
                        c.get_red() + c.get_green() + c.get_blue()
                    };

                    let c0 = 0i32;
                    let c1 = size as i32 - c0 - 1;
                    let corner_values = [sum_rgba(c0, c0), sum_rgba(c1, c0), sum_rgba(c1, c1), sum_rgba(c0, c1)];
                    let min_value = *corner_values.iter().min().expect("four corners");
                    let max_value = *corner_values.iter().max().expect("four corners");

                    // weighted sum of the directions to all corners
                    let mut result_gradient_direction = [0.0f32; 2];
                    for (value, corner_direction) in corner_values.iter().zip(&corner_directions) {
                        let weight = (value - min_value) as f32 / max_value as f32;
                        result_gradient_direction[0] += corner_direction[0] * (1.0 - weight);
                        result_gradient_direction[1] += corner_direction[1] * (1.0 - weight);
                    }
                    let result_length = (result_gradient_direction[0] * result_gradient_direction[0]
                        + result_gradient_direction[1] * result_gradient_direction[1])
                        .sqrt();
                    result_gradient_direction = [
                        result_gradient_direction[0] / result_length,
                        result_gradient_direction[1] / result_length,
                    ];

                    // the cosine of the two directions should be close to 1
                    let dot = expected_gradient_direction[0] * result_gradient_direction[0]
                        + expected_gradient_direction[1] * result_gradient_direction[1];
                    if dot < 1.0 - epsilon {
                        pass = false;
                        log::info!(
                            "Wrong gradient direction at face: {face_ndx} at derivative {d:?} for {}. Expected gradient direction {expected_gradient_direction:?} got {result_gradient_direction:?}",
                            if use_dy { "dy" } else { "dx" }
                        );
                    }

                    // gradient continuity and monotonicity: each fragment on the diagonal is not larger than the first
                    let step = [direction[0], -direction[1]];
                    let mut curr = [
                        if step[0] > 0 { 0 } else { size as i32 - 1 },
                        if step[1] > 0 { 0 } else { size as i32 - 1 },
                    ];
                    // (upstream never updates lastValue: its `currValue = lastValue` assigns the wrong way round)
                    let last_value = sum_rgba(curr[0], curr[1]);
                    for _ in 1..size - 1 {
                        curr = [curr[0] + step[0], curr[1] + step[1]];
                        let curr_value = sum_rgba(curr[0], curr[1]);
                        if curr_value > last_value {
                            pass = false;
                            log::info!(
                                "Gradient for face: {face_ndx} at derivative {d:?} for {} has correct direction {expected_gradient_direction:?} but is not monotonic at fragment {curr:?}",
                                if use_dy { "dy" } else { "dx" }
                            );
                            break;
                        }
                    }
                }
            }
        }

        if pass {
            Ok(TestStatus::pass("pass"))
        } else {
            Ok(TestStatus::fail("fail"))
        }
    }
}

fn create_cube_lod_control_group(name: &str, control: LodControl) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    for &min_filter in MIN_FILTER_MODES {
        let mut params = LodControlParameters {
            control,
            min_filter,
            use_compute: false,
            three_d: false,
        };
        group.add_child(Box::new(CubeLodControlCase {
            name: min_filter.name.to_string(),
            params,
        }) as Box<dyn TestCase>);

        params.use_compute = true;
        group.add_child(Box::new(CubeLodControlCase {
            name: format!("{}_compute", min_filter.name),
            params,
        }) as Box<dyn TestCase>);
    }
    group
}

/// `populateTextureMipmappingTests`, the `cubemap` coordinate type groups
fn create_mipmap_cube_tests() -> TestCaseGroup {
    let mut group_cube = TestCaseGroup::new("cubemap");
    for (coord_type, coord_name) in [
        (CoordType::Basic, "basic"),
        (CoordType::Projected, "projected"),
        (CoordType::BasicBias, "bias"),
    ] {
        let mut coord_type_group = TestCaseGroup::new(coord_name);
        for &min_filter in MIN_FILTER_MODES {
            for (mag_name, mag_linear) in [("nearest", false), ("linear", true)] {
                for &(wrap_name, wrap_vk, wrap_tcu) in WRAP_MODES {
                    let mut params = MipmapCubeParameters {
                        coord_type,
                        min_filter,
                        mag_linear,
                        wrap: (wrap_vk, wrap_tcu),
                        use_compute: false,
                    };
                    let name = format!("{}_{mag_name}_{wrap_name}", min_filter.name);
                    coord_type_group.add_child(Box::new(MipmapCubeCase {
                        name: name.clone(),
                        params,
                    }) as Box<dyn TestCase>);

                    // Compute case - skipped for projected and bias coordinate types, due to inacurate calculations.
                    if matches!(coord_type, CoordType::Projected | CoordType::BasicBias) {
                        continue;
                    }
                    params.use_compute = true;
                    coord_type_group.add_child(Box::new(MipmapCubeCase {
                        name: format!("{name}_compute"),
                        params,
                    }) as Box<dyn TestCase>);
                }
            }
        }
        group_cube.add_child(coord_type_group);
    }
    group_cube.add_child(create_cube_lod_control_group("min_lod", LodControl::MinLod));
    group_cube.add_child(create_cube_lod_control_group("max_lod", LodControl::MaxLod));
    group_cube.add_child(create_cube_lod_control_group("base_level", LodControl::BaseLevel));
    group_cube.add_child(create_cube_lod_control_group("max_level", LodControl::MaxLevel));
    let mut group_cube_image_view_min_lod = TestCaseGroup::new("image_view_min_lod");
    group_cube_image_view_min_lod.add_child(create_cube_lod_control_group("min_lod", LodControl::ImageViewMinLod));
    group_cube_image_view_min_lod.add_child(create_cube_lod_control_group(
        "base_level",
        LodControl::ImageViewMinLodBaseLevel,
    ));
    group_cube.add_child(group_cube_image_view_min_lod);
    let mut group_cube_misc = TestCaseGroup::new("misc");
    group_cube_misc.add_child(Box::new(CubeProjectedDerivativesCase) as Box<dyn TestCase>);
    group_cube.add_child(group_cube_misc);
    group_cube
}

/// `populateTextureMipmappingTests`, the `2d` coordinate type and `bias` groups, below a `mipmap` group
pub fn create_texture_mipmapping_tests() -> TestCaseGroup {
    let mut group_2d = TestCaseGroup::new("2d");
    for (coord_type, coord_name) in [
        (CoordType::Basic, "basic"),
        (CoordType::Affine, "affine"),
        (CoordType::Projected, "projected"),
    ] {
        let mut coord_type_group = TestCaseGroup::new(coord_name);
        for &min_filter in MIN_FILTER_MODES {
            for &(wrap_name, wrap_vk, wrap_tcu) in WRAP_MODES {
                // Add non_square variants to basic cases only.
                let size_end = if coord_type == CoordType::Basic {
                    TEX_2D_SIZES.len()
                } else {
                    1
                };
                for &(size_name, width, height) in &TEX_2D_SIZES[..size_end] {
                    let params = MipmapParameters {
                        coord_type,
                        min_filter,
                        wrap: (wrap_vk, wrap_tcu),
                        width,
                        height,
                        use_compute: false,
                    };
                    let mut name = format!("{}_{wrap_name}", min_filter.name);
                    if let Some(size_name) = size_name {
                        name.push('_');
                        name.push_str(size_name);
                    }
                    add_case(&mut coord_type_group, name, params);
                }
            }
        }
        group_2d.add_child(coord_type_group);
    }

    // 2D bias variants.
    let mut bias_group = TestCaseGroup::new("bias");
    for &min_filter in MIN_FILTER_MODES {
        let params = MipmapParameters {
            coord_type: CoordType::BasicBias,
            min_filter,
            wrap: (vk::SamplerAddressMode::REPEAT, WrapMode::Repeat),
            width: 64,
            height: 64,
            use_compute: false,
        };
        add_case(&mut bias_group, min_filter.name.to_string(), params);
    }
    group_2d.add_child(bias_group);
    group_2d.add_child(create_lod_control_group("min_lod", LodControl::MinLod, false));
    group_2d.add_child(create_lod_control_group("max_lod", LodControl::MaxLod, false));
    group_2d.add_child(create_lod_control_group("base_level", LodControl::BaseLevel, false));
    group_2d.add_child(create_lod_control_group("max_level", LodControl::MaxLevel, false));
    let mut group_2d_image_view_min_lod = TestCaseGroup::new("image_view_min_lod");
    group_2d_image_view_min_lod.add_child(create_lod_control_group("min_lod", LodControl::ImageViewMinLod, false));
    group_2d_image_view_min_lod.add_child(create_lod_control_group(
        "base_level",
        LodControl::ImageViewMinLodBaseLevel,
        false,
    ));
    group_2d.add_child(group_2d_image_view_min_lod);

    let mut mipmap = TestCaseGroup::new("mipmap");
    mipmap.add_child(group_2d);
    mipmap.add_child(create_mipmap_cube_tests());
    mipmap.add_child(create_mipmap_3d_tests());
    mipmap
}
