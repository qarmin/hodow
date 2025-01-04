// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fVertexTextureTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `2d` and `cube` groups are
// `gles2::functional::texture::vertex` with `#version 300 es` shaders and an always-seamless
// cube sampler (the two files differ in nothing else). `Vertex2DArrayTextureCase` and
// `Vertex3DTextureCase` share one `VolumeTextureCase` here, since they differ only in the
// texture type, the lookup function and the lod formula; `init`/`deinit` are folded into
// `iterate`. `Mat3` is a row-major `[[f32; 3]; 3]` (tcu's `Mat3(const float *)` is row-major too).

use crate::gles2::functional::texture::vertex::{
    FRAGMENT_SHADER_ES3, MAG_FILTER_MODES, MIN_FILTER_MODES, PosTexCoordQuadGrid, Rect, WRAP_MODES,
    add_2d_and_cube_groups, build_program, compare_vertex_images, compute_reference, is_level_nearest, mul_add,
    render_cell, safe_coord,
};
use crate::gls::texture_test_util::RandomViewport;
use crate::glu::texture_2d_array::Texture2DArray;
use crate::glu::texture_3d::Texture3D;
use crate::glu::texture_test_util::{LodMode, TextureType, exec_sample_2d_array, exec_sample_3d};
use crate::glu::texture_test_util_surface::{
    effective_levels, fill_with_component_gradients_old, make_reference_params,
};
use crate::glu::{Context, RenderContext, TestCase, TestCaseGroup, read_pixels};
use crate::glw;
use crate::tcu::pixel::{ConstPixelBufferAccess, fill_with_grid, get_texture_format_info};
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::{TestError, TestOutcome, TestStatus, de_string_hash};

const WIDTH_2D_ARRAY: i32 = 128;
const HEIGHT_2D_ARRAY: i32 = 128;
const LAYERS_2D_ARRAY: i32 = 8;

const WIDTH_3D: i32 = 64;
const HEIGHT_3D: i32 = 64;
const DEPTH_3D: i32 = 64;

const MAX_2D_ARRAY_RENDER_WIDTH: i32 = 128 * 2;
const MAX_2D_ARRAY_RENDER_HEIGHT: i32 = 128 * 2;

const MAX_3D_RENDER_WIDTH: i32 = 128 * 2;
const MAX_3D_RENDER_HEIGHT: i32 = 128 * 2;

const GRID_SIZE_2D_ARRAY: usize = 127;
const GRID_SIZE_3D: usize = 127;

type Mat3 = [[f32; 3]; 3];

fn mat3_from_rows(data: [f32; 9]) -> Mat3 {
    [
        [data[0], data[1], data[2]],
        [data[3], data[4], data[5]],
        [data[6], data[7], data[8]],
    ]
}

fn mat3_mul(a: &Mat3, b: &Mat3) -> Mat3 {
    std::array::from_fn(|i| std::array::from_fn(|j| (0..3).map(|k| a[i][k] * b[k][j]).sum()))
}

fn mat3_mul_vec(m: &Mat3, v: [f32; 3]) -> [f32; 3] {
    std::array::from_fn(|i| m[i][0] * v[0] + m[i][1] * v[1] + m[i][2] * v[2])
}

const VERTEX_SHADER_2D_ARRAY: &str = "#version 300 es\n\
    in highp vec2 a_position;\n\
    in highp vec3 a_texCoord;\n\
    uniform highp sampler2DArray u_texture;\n\
    uniform highp float u_lod;\n\
    out mediump vec4 v_color;\n\
    \n\
    void main()\n\
    {\n\
    \tgl_Position = vec4(a_position, 0.0, 1.0);\n\
    \tv_color = textureLod(u_texture, a_texCoord, u_lod);\n\
    }\n";

const VERTEX_SHADER_3D: &str = "#version 300 es\n\
    in highp vec2 a_position;\n\
    in highp vec3 a_texCoord;\n\
    uniform highp sampler3D u_texture;\n\
    uniform highp float u_lod;\n\
    out mediump vec4 v_color;\n\
    \n\
    void main()\n\
    {\n\
    \tgl_Position = vec4(a_position, 0.0, 1.0);\n\
    \tv_color = textureLod(u_texture, a_texCoord, u_lod);\n\
    }\n";

fn log2_floor(value: i32) -> usize {
    (31 - (value as u32).leading_zeros()) as usize
}

/// The gradient and grid fills `init` applies to both volume-like textures. `levels` yields
/// each level's writable access for texture `i`.
fn fill_textures(
    num_levels: usize,
    format_info: crate::tcu::pixel::TextureFormatInfo,
    mut with_level: impl FnMut(usize, usize, &mut dyn FnMut(&mut crate::tcu::pixel::PixelBufferAccess<'_>)),
) {
    let c_bias = format_info.value_min;
    let c_scale: [f32; 4] = std::array::from_fn(|i| format_info.value_max[i] - format_info.value_min[i]);

    // Fill first with gradient texture.
    for level_ndx in 0..num_levels {
        let g_min = mul_add([-0.5, -0.5, -0.5, 2.0], c_scale, c_bias);
        let g_max = mul_add([1.0, 1.0, 1.0, 0.0], c_scale, c_bias);
        with_level(0, level_ndx, &mut |level| {
            fill_with_component_gradients_old(level, g_min, g_max)
        });
    }

    // Fill second with grid texture.
    for level_ndx in 0..num_levels {
        let step = 0x00ff_ffffu32 / num_levels as u32;
        let rgb = step.wrapping_mul(level_ndx as u32);
        let color_a = 0xff00_0000u32 | rgb;
        let color_b = 0xff00_0000u32 | !rgb;
        let a = mul_add(RGBA::from_packed(color_a).to_vec().m_data, c_scale, c_bias);
        let b = mul_add(RGBA::from_packed(color_b).to_vec().m_data, c_scale, c_bias);
        with_level(1, level_ndx, &mut |level| fill_with_grid(level, 4, a, b));
    }
}

fn make_2d_array_textures(render_ctx: &RenderContext) -> Result<Vec<Texture2DArray<'_>>, TestError> {
    let mut textures = Vec::with_capacity(2);
    for _ in 0..2 {
        textures.push(Texture2DArray::new(
            render_ctx,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            WIDTH_2D_ARRAY as u32,
            HEIGHT_2D_ARRAY as u32,
            LAYERS_2D_ARRAY as u32,
        )?);
    }

    let num_levels = log2_floor(WIDTH_2D_ARRAY.max(HEIGHT_2D_ARRAY)) + 1;
    let format_info = get_texture_format_info(textures[0].ref_texture().format());

    fill_textures(num_levels, format_info, |tex_ndx, level_ndx, f| {
        textures[tex_ndx].ref_texture_mut().alloc_level(level_ndx);
        let mut level = textures[tex_ndx].ref_texture_mut().level_mut(level_ndx);
        f(&mut level);
    });

    for tex in &textures {
        // SAFETY: a current context; `tex` outlives the upload.
        unsafe { tex.upload()? };
    }

    Ok(textures)
}

fn make_3d_textures(render_ctx: &RenderContext) -> Result<Vec<Texture3D<'_>>, TestError> {
    let mut textures = Vec::with_capacity(2);
    for _ in 0..2 {
        textures.push(Texture3D::new(
            render_ctx,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            WIDTH_3D as u32,
            HEIGHT_3D as u32,
            DEPTH_3D as u32,
        )?);
    }

    let num_levels = log2_floor(WIDTH_3D.max(HEIGHT_3D).max(DEPTH_3D)) + 1;
    let format_info = get_texture_format_info(textures[0].ref_texture().format());

    fill_textures(num_levels, format_info, |tex_ndx, level_ndx, f| {
        textures[tex_ndx].ref_texture_mut().alloc_level(level_ndx);
        let mut level = textures[tex_ndx].ref_texture_mut().level_mut(level_ndx);
        f(&mut level);
    });

    for tex in &textures {
        // SAFETY: a current context; `tex` outlives the upload.
        unsafe { tex.upload()? };
    }

    Ok(textures)
}

fn collect_array_levels(tex: &crate::tcu::texture_2d_array::Texture2DArray) -> Vec<ConstPixelBufferAccess<'_>> {
    (0..tex.num_levels())
        .take_while(|&l| !tex.is_level_empty(l))
        .map(|l| tex.level(l))
        .collect()
}

fn collect_3d_levels(tex: &crate::tcu::texture_3d::Texture3D) -> Vec<ConstPixelBufferAccess<'_>> {
    (0..tex.num_levels())
        .take_while(|&l| !tex.is_level_empty(l))
        .map(|l| tex.level(l))
        .collect()
}

/// `Vertex2DArrayTextureCase::calculateLod` / `Vertex3DTextureCase::calculateLod`; `src_size`
/// is (width, height, depth), the depth term only counting for 3D.
fn calculate_lod(transf: &Mat3, dst_size: [f32; 2], src_size: [i32; 3], is_3d: bool) -> f32 {
    // Calculate transformed coordinates of three screen corners.
    let trans00 = mat3_mul_vec(transf, [0.0, 0.0, 1.0]);
    let trans01 = mat3_mul_vec(transf, [0.0, 1.0, 1.0]);
    let trans10 = mat3_mul_vec(transf, [1.0, 0.0, 1.0]);

    // Derivates.
    let dudx = (trans10[0] - trans00[0]) * src_size[0] as f32 / dst_size[0];
    let dudy = (trans01[0] - trans00[0]) * src_size[0] as f32 / dst_size[1];
    let dvdx = (trans10[1] - trans00[1]) * src_size[1] as f32 / dst_size[0];
    let dvdy = (trans01[1] - trans00[1]) * src_size[1] as f32 / dst_size[1];
    let (dwdx, dwdy) = if is_3d {
        (
            (trans10[2] - trans00[2]) * src_size[2] as f32 / dst_size[0],
            (trans01[2] - trans00[2]) * src_size[2] as f32 / dst_size[1],
        )
    } else {
        (0.0, 0.0)
    };

    (dudx * dudx + dvdx * dvdx + dwdx * dwdx)
        .max(dudy * dudy + dvdy * dvdy + dwdy * dwdy)
        .sqrt()
        .log2()
}

struct VolumeTextureCase {
    is_array: bool,
    name: String,
    min_filter: u32,
    mag_filter: u32,
    wrap_s: u32,
    wrap_t: u32,
    wrap_r: u32,
}

impl TestCase for VolumeTextureCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();

        // `init`
        let program = build_program(
            context,
            if self.is_array {
                VERTEX_SHADER_2D_ARRAY
            } else {
                VERTEX_SHADER_3D
            },
            FRAGMENT_SHADER_ES3,
        )?;
        let array_textures;
        let volume_textures;
        let gl_ids: [u32; 2];
        let levels: [Vec<ConstPixelBufferAccess<'_>>; 2];
        let src_size: [i32; 3];
        if self.is_array {
            array_textures = make_2d_array_textures(render_ctx)?;
            gl_ids = [array_textures[0].gl_texture(), array_textures[1].gl_texture()];
            levels = [
                collect_array_levels(array_textures[0].ref_texture()),
                collect_array_levels(array_textures[1].ref_texture()),
            ];
            src_size = [WIDTH_2D_ARRAY, HEIGHT_2D_ARRAY, LAYERS_2D_ARRAY];
        } else {
            volume_textures = make_3d_textures(render_ctx)?;
            gl_ids = [volume_textures[0].gl_texture(), volume_textures[1].gl_texture()];
            levels = [
                collect_3d_levels(volume_textures[0].ref_texture()),
                collect_3d_levels(volume_textures[1].ref_texture()),
            ];
            src_size = [WIDTH_3D, HEIGHT_3D, DEPTH_3D];
        }

        // `iterate`
        let (max_width, max_height) = if self.is_array {
            (MAX_2D_ARRAY_RENDER_WIDTH, MAX_2D_ARRAY_RENDER_HEIGHT)
        } else {
            (MAX_3D_RENDER_WIDTH, MAX_3D_RENDER_HEIGHT)
        };
        let viewport = RandomViewport::new(&render_target, max_width, max_height, de_string_hash(&self.name));
        let viewport_width = viewport.width;
        let viewport_height = viewport.height;

        // SAFETY: plain state setting on the current context.
        unsafe {
            gl.use_program(program.program());
            // Clear.
            gl.clear_color(0.125, 0.25, 0.5, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }

        // Divide viewport into 4 cells.
        let left_width = viewport_width / 2;
        let right_width = viewport_width - left_width;
        let bottom_height = viewport_height / 2;
        let top_height = viewport_height - bottom_height;

        // Shear by layer count (or to get all slices visible).
        let shear_data: [f32; 9] = if self.is_array {
            [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, LAYERS_2D_ARRAY as f32, 0.0, 0.0]
        } else {
            [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0, 1.0, 0.0]
        };

        // Minification and magnification transformations.
        let tex_min_transf_data: [f32; 9] = if self.is_array {
            [2.1, 0.0, -0.3, 0.0, 2.1, -0.3, 0.0, 0.0, 1.0]
        } else {
            [2.2, 0.0, -0.3, 0.0, 2.2, -0.3, 0.0, 0.0, 1.0]
        };
        let tex_mag_transf_data: [f32; 9] = [0.4, 0.0, 0.8, 0.0, 0.4, 0.8, 0.0, 0.0, 1.0];

        // Transformation matrices for minification and magnification.
        let shear = mat3_from_rows(shear_data);
        let tex_min_transf = mat3_mul(&shear, &mat3_from_rows(tex_min_transf_data));
        let tex_mag_transf = mat3_mul(&shear, &mat3_from_rows(tex_mag_transf_data));

        // Surface for the reference image.
        let mut ref_image = Surface::new(viewport_width, viewport_height);

        let renders = [
            (Rect::new(0, 0, left_width, bottom_height), 0usize, tex_min_transf),
            (Rect::new(left_width, 0, right_width, bottom_height), 0, tex_mag_transf),
            (Rect::new(0, bottom_height, left_width, top_height), 1, tex_min_transf),
            (
                Rect::new(left_width, bottom_height, right_width, top_height),
                1,
                tex_mag_transf,
            ),
        ];

        let (tex_type, tex_target) = if self.is_array {
            (TextureType::Texture2DArray, glw::GL_TEXTURE_2D_ARRAY)
        } else {
            (TextureType::Texture3D, glw::GL_TEXTURE_3D)
        };
        let wrap_r_for_sampler = if self.is_array { self.wrap_t } else { self.wrap_r };
        let ref_params = make_reference_params(
            tex_type,
            self.wrap_s,
            self.wrap_t,
            wrap_r_for_sampler,
            self.min_filter,
            self.mag_filter,
            LodMode::Exact,
        )?;
        let grid_size = if self.is_array {
            GRID_SIZE_2D_ARRAY
        } else {
            GRID_SIZE_3D
        };
        let safe_fractions: [f32; 3] = if self.is_array {
            [0.5, 0.5, 0.0]
        } else {
            [0.5, 0.5, 0.5]
        };

        for (region, texture_ndx, transform) in &renders {
            let lod = calculate_lod(transform, [region.w as f32, region.h as f32], src_size, !self.is_array);
            let use_safe_tex_coords = is_level_nearest(if lod > 0.0 { self.min_filter } else { self.mag_filter });
            let grid = PosTexCoordQuadGrid::with_tex_coords(grid_size, [region.w, region.h], 3, |fx, fy| {
                let raw = mat3_mul_vec(transform, [fx, fy, 1.0]);
                if use_safe_tex_coords {
                    std::array::from_fn(|i| safe_coord(raw[i], src_size[i], safe_fractions[i]))
                } else {
                    raw
                }
            });

            // SAFETY: plain state setting on the current context.
            unsafe { gl.viewport(viewport.x + region.x, viewport.y + region.y, region.w, region.h) };
            render_cell(
                gl,
                &program,
                tex_target,
                gl_ids[*texture_ndx],
                self.wrap_s,
                self.wrap_t,
                if self.is_array { None } else { Some(self.wrap_r) },
                self.min_filter,
                self.mag_filter,
                lod,
                &grid,
            );

            // `computeReferenceCell`
            let used = effective_levels(&levels[*texture_ndx], &ref_params);
            if self.is_array {
                compute_reference(
                    |c| exec_sample_2d_array(used, &ref_params, c[0], c[1], c[2], lod),
                    &grid,
                    &mut ref_image,
                    *region,
                );
            } else {
                compute_reference(
                    |c| exec_sample_3d(used, &ref_params, c[0], c[1], c[2], lod),
                    &grid,
                    &mut ref_image,
                    *region,
                );
            }
        }

        // Read back rendered results.
        let mut res_image = Surface::new(viewport_width, viewport_height);
        read_pixels(render_ctx, viewport.x, viewport.y, &mut res_image.get_access())?;

        // SAFETY: plain state setting on the current context.
        unsafe { gl.use_program(0) };

        // Compare and log.
        if compare_vertex_images(context, &ref_image, &res_image) {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Image comparison failed"))
        }
    }
}

/// `VertexTextureTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("vertex");

    // 2D and cube map groups, and their filtering and wrap sub-groups.
    add_2d_and_cube_groups(&mut group, true);

    for (group_name, is_array) in [("2d_array", true), ("3d", false)] {
        let mut kind_group = TestCaseGroup::new(group_name);
        let mut filtering_group = TestCaseGroup::new("filtering");
        let mut wrap_group = TestCaseGroup::new("wrap");

        for &(min_name, min_filter) in &MIN_FILTER_MODES {
            for &(mag_name, mag_filter) in &MAG_FILTER_MODES {
                for &(wrap_name, wrap_mode) in &WRAP_MODES {
                    let name = format!("{min_name}_{mag_name}_{wrap_name}");
                    filtering_group.add_child(Box::new(VolumeTextureCase {
                        is_array,
                        name,
                        min_filter,
                        mag_filter,
                        wrap_s: wrap_mode,
                        wrap_t: wrap_mode,
                        wrap_r: wrap_mode,
                    }) as Box<dyn TestCase>);
                }
            }
        }

        for &(wrap_s_name, wrap_s) in &WRAP_MODES {
            for &(wrap_t_name, wrap_t) in &WRAP_MODES {
                if is_array {
                    let name = format!("{wrap_s_name}_{wrap_t_name}");
                    wrap_group.add_child(Box::new(VolumeTextureCase {
                        is_array,
                        name,
                        min_filter: glw::GL_LINEAR_MIPMAP_LINEAR,
                        mag_filter: glw::GL_LINEAR,
                        wrap_s,
                        wrap_t,
                        wrap_r: wrap_t,
                    }) as Box<dyn TestCase>);
                } else {
                    for &(wrap_r_name, wrap_r) in &WRAP_MODES {
                        let name = format!("{wrap_s_name}_{wrap_t_name}_{wrap_r_name}");
                        wrap_group.add_child(Box::new(VolumeTextureCase {
                            is_array,
                            name,
                            min_filter: glw::GL_LINEAR_MIPMAP_LINEAR,
                            mag_filter: glw::GL_LINEAR,
                            wrap_s,
                            wrap_t,
                            wrap_r,
                        }) as Box<dyn TestCase>);
                    }
                }
            }
        }

        kind_group.add_child(filtering_group);
        kind_group.add_child(wrap_group);
        group.add_child(kind_group);
    }

    group
}
