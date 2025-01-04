// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fVertexTextureTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `init`/`deinit` are folded into `iterate`
// (textures and program live for one call), so a case that fails still frees everything on
// drop. `PosTexCoordQuadGrid<TexType>` is one non-generic struct that carries 2 or 3 texture
// coordinate floats per vertex; the reference lookup goes through
// `glu::texture_test_util::exec_sample_*` (the host-side `Texture2D::sample`/`TextureCube::sample`
// equivalent, min filter for lod > 0 and mag filter otherwise).
// The MSAA NotSupported check runs at the top of `iterate`, before the shader is built.

use crate::gls::texture_test_util::RandomViewport;
use crate::glu::texture::Texture2D;
use crate::glu::texture_cube::TextureCube;
use crate::glu::texture_test_util::{LodMode, TextureType, exec_sample_2d, exec_sample_cube};
use crate::glu::texture_test_util_surface::{
    compare_images, compute_quad_tex_coord_cube, effective_levels, make_reference_params,
};
use crate::glu::{Context, ProgramSources, RenderContext, ShaderProgram, TestCase, TestCaseGroup, read_pixels};
use crate::glw;
use crate::tcu::pixel::{
    ConstPixelBufferAccess, CubeFace, fill_with_component_gradients2, fill_with_grid, get_texture_format_info,
};
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::vector::Vec4;
use crate::tcu::{TestError, TestOutcome, TestStatus, de_string_hash};

// The 2D case draws four images.
const MAX_2D_RENDER_WIDTH: i32 = 128 * 2;
const MAX_2D_RENDER_HEIGHT: i32 = 128 * 2;

// The cube map case draws four 3-by-2 image groups.
const MAX_CUBE_RENDER_WIDTH: i32 = 28 * 2 * 3;
const MAX_CUBE_RENDER_HEIGHT: i32 = 28 * 2 * 2;

const GRID_SIZE_2D: usize = 127;
const GRID_SIZE_CUBE: usize = 63;

pub(crate) const FACES: [CubeFace; 6] = [
    CubeFace::NegativeX,
    CubeFace::PositiveX,
    CubeFace::NegativeY,
    CubeFace::PositiveY,
    CubeFace::NegativeZ,
    CubeFace::PositiveZ,
];

// Helpers for making texture coordinates "safe", i.e. move them further from coordinate boundary.

/// Moves x towards the closest K+targetFraction, where K is an integer.
pub(crate) fn move_towards_fraction(x: f32, target_fraction: f32) -> f32 {
    let strictness = 0.5f32;
    let y = x + 0.5 - target_fraction;
    y.floor() + (y - y.floor()) * (1.0 - strictness) + strictness * 0.5 - 0.5 + target_fraction
}

pub(crate) fn safe_coord(raw: f32, scale: i32, fraction: f32) -> f32 {
    let scale_float = scale as f32;
    move_towards_fraction(raw * scale_float, fraction) / scale_float
}

fn safe_2d_tex_coords(raw: [f32; 2], texture_size: [i32; 2]) -> [f32; 2] {
    [
        safe_coord(raw[0], texture_size[0], 0.5),
        safe_coord(raw[1], texture_size[1], 0.5),
    ]
}

#[derive(Clone, Copy)]
pub(crate) struct Rect {
    pub(crate) x: i32,
    pub(crate) y: i32,
    pub(crate) w: i32,
    pub(crate) h: i32,
}

impl Rect {
    pub(crate) fn new(x: i32, y: i32, w: i32, h: i32) -> Self {
        Self { x, y, w, h }
    }
}

struct TexCoordParams {
    scale: [f32; 2],
    bias: [f32; 2],
    face: CubeFace,
}

/// A quad grid of size S is S*S quads of two triangles each; every quad owns its own 4
/// vertices so the texture coordinate is constant across it. `tex_dims` is 2 for a 2D
/// texture and 3 for a cube map.
pub(crate) struct PosTexCoordQuadGrid {
    pub(crate) grid_size: usize,
    pub(crate) tex_dims: usize,
    positions: Vec<[f32; 2]>,
    tex_coords: Vec<[f32; 3]>,
    indices: Vec<u16>,
}

impl PosTexCoordQuadGrid {
    /// The 2D and cube map constructors (`initializeTexCoords` specialisations of those two).
    fn new(
        grid_size: usize,
        render_size: [i32; 2],
        texture_size: [i32; 2],
        params: &TexCoordParams,
        tex_dims: usize,
        use_safe_tex_coords: bool,
    ) -> Self {
        if tex_dims == 2 {
            Self::with_tex_coords(grid_size, render_size, 2, |fx, fy| {
                let raw_coord = [
                    fx * params.scale[0] + params.bias[0],
                    fy * params.scale[1] + params.bias[1],
                ];
                let coord = if use_safe_tex_coords {
                    safe_2d_tex_coords(raw_coord, texture_size)
                } else {
                    raw_coord
                };
                [coord[0], coord[1], 0.0]
            })
        } else {
            let tex_boundaries = compute_quad_tex_coord_cube(params.face);
            let coord_a = [tex_boundaries[0], tex_boundaries[1], tex_boundaries[2]];
            let coord_b = [tex_boundaries[3], tex_boundaries[4], tex_boundaries[5]];
            let coord_c = [tex_boundaries[6], tex_boundaries[7], tex_boundaries[8]];
            let coord_ab: [f32; 3] = std::array::from_fn(|i| coord_b[i] - coord_a[i]);
            let coord_ac: [f32; 3] = std::array::from_fn(|i| coord_c[i] - coord_a[i]);

            Self::with_tex_coords(grid_size, render_size, 3, |fx, fy| {
                let raw_face_coord = [
                    params.scale[0] * fx + params.bias[0],
                    params.scale[1] * fy + params.bias[1],
                ];
                let safe_face_coord = if use_safe_tex_coords {
                    safe_2d_tex_coords(raw_face_coord, texture_size)
                } else {
                    raw_face_coord
                };
                std::array::from_fn(|i| {
                    coord_a[i] + coord_ac[i] * safe_face_coord[0] + coord_ab[i] * safe_face_coord[1]
                })
            })
        }
    }

    /// The shared constructor: positions, indices, and one texture coordinate per quad from
    /// `tex_coord(x / gridSize, y / gridSize)`, repeated over the quad's 4 vertices.
    pub(crate) fn with_tex_coords(
        grid_size: usize,
        render_size: [i32; 2],
        tex_dims: usize,
        tex_coord: impl Fn(f32, f32) -> [f32; 3],
    ) -> Self {
        debug_assert!(grid_size > 0 && grid_size * grid_size <= u16::MAX as usize + 1);

        let grid_size_float = grid_size as f32;
        let mut positions: Vec<[f32; 2]> = Vec::with_capacity(grid_size * grid_size * 4);
        let mut tex_coords: Vec<[f32; 3]> = Vec::with_capacity(grid_size * grid_size * 4);
        let mut indices: Vec<u16> = Vec::with_capacity(grid_size * grid_size * 6);

        for y in 0..grid_size {
            for x in 0..grid_size {
                let fx0 = x as f32 / grid_size_float;
                let fx1 = (x + 1) as f32 / grid_size_float;
                let fy0 = y as f32 / grid_size_float;
                let fy1 = (y + 1) as f32 / grid_size_float;

                let quad_vertices = [[fx0, fy0], [fx1, fy0], [fx0, fy1], [fx1, fy1]];

                let first_ndx = positions.len();

                for v in &quad_vertices {
                    let safe = [
                        safe_coord(v[0], render_size[0], 0.0),
                        safe_coord(v[1], render_size[1], 0.0),
                    ];
                    positions.push([safe[0] * 2.0 - 1.0, safe[1] * 2.0 - 1.0]);
                }

                indices.push(first_ndx as u16);
                indices.push((first_ndx + 1) as u16);
                indices.push((first_ndx + 2) as u16);

                indices.push((first_ndx + 1) as u16);
                indices.push((first_ndx + 3) as u16);
                indices.push((first_ndx + 2) as u16);
            }
        }

        for y in 0..grid_size {
            for x in 0..grid_size {
                let coord = tex_coord(x as f32 / grid_size_float, y as f32 / grid_size_float);
                for _ in 0..4 {
                    tex_coords.push(coord);
                }
            }
        }

        debug_assert_eq!(positions.len(), grid_size * grid_size * 4);
        debug_assert_eq!(indices.len(), grid_size * grid_size * 6);
        debug_assert_eq!(tex_coords.len(), grid_size * grid_size * 4);

        Self {
            grid_size,
            tex_dims,
            positions,
            tex_coords,
            indices,
        }
    }

    /// `getQuadLDRU` - (leftX, downY, rightX, upY)
    pub(crate) fn quad_ldru(&self, col: usize, row: usize) -> [f32; 4] {
        let ndx00 = (row * self.grid_size + col) * 4;
        let ndx11 = ndx00 + 3;
        [
            self.positions[ndx00][0],
            self.positions[ndx00][1],
            self.positions[ndx11][0],
            self.positions[ndx11][1],
        ]
    }

    pub(crate) fn quad_tex_coord(&self, col: usize, row: usize) -> [f32; 3] {
        self.tex_coords[(row * self.grid_size + col) * 4]
    }

    fn num_indices(&self) -> usize {
        self.grid_size * self.grid_size * 3 * 2
    }

    fn position_data(&self) -> Vec<f32> {
        self.positions.iter().flat_map(|p| p.iter().copied()).collect()
    }

    fn tex_coord_data(&self) -> Vec<f32> {
        self.tex_coords
            .iter()
            .flat_map(|t| t[..self.tex_dims].iter().copied())
            .collect()
    }
}

pub(crate) fn is_level_nearest(filter: u32) -> bool {
    filter == glw::GL_NEAREST || filter == glw::GL_NEAREST_MIPMAP_NEAREST || filter == glw::GL_NEAREST_MIPMAP_LINEAR
}

pub(crate) fn set_pixel_colors(quad_colors: &[[f32; 4]], region: Rect, grid: &PosTexCoordQuadGrid, dst: &mut Surface) {
    let grid_size = grid.grid_size;

    for y in 0..grid_size {
        for x in 0..grid_size {
            let color = quad_colors[y * grid_size + x];
            let ldru = grid.quad_ldru(x, y).map(|v| v * 0.5 + 0.5); // [-1, 1] -> [0, 1]
            let ix0 = (ldru[0] * region.w as f32 - 0.5).ceil() as i32;
            let ix1 = (ldru[2] * region.w as f32 - 0.5).ceil() as i32;
            let iy0 = (ldru[1] * region.h as f32 - 0.5).ceil() as i32;
            let iy1 = (ldru[3] * region.h as f32 - 0.5).ceil() as i32;
            let rgba = RGBA::from_vec(Vec4::new(color[0], color[1], color[2], color[3]));

            for iy in iy0..iy1 {
                for ix in ix0..ix1 {
                    debug_assert!(ix + region.x >= 0 && ix + region.x < dst.get_width());
                    debug_assert!(iy + region.y >= 0 && iy + region.y < dst.get_height());

                    dst.set_pixel(ix + region.x, iy + region.y, rgba);
                }
            }
        }
    }
}

/// `computeReference` - `sample` gets the quad's texture coordinate (`tex_dims` floats).
pub(crate) fn compute_reference(
    sample: impl Fn(&[f32]) -> [f32; 4],
    grid: &PosTexCoordQuadGrid,
    dst: &mut Surface,
    dst_region: Rect,
) {
    let grid_size = grid.grid_size;
    let mut quad_colors = vec![[0.0f32; 4]; grid_size * grid_size];

    for y in 0..grid_size {
        for x in 0..grid_size {
            let coord = grid.quad_tex_coord(x, y);
            quad_colors[y * grid_size + x] = sample(&coord[..grid.tex_dims]);
        }
    }

    set_pixel_colors(&quad_colors, dst_region, grid, dst);
}

pub(crate) fn compare_vertex_images(context: &Context, reference: &Surface, result: &Surface) -> bool {
    let threshold = context.render_target().pixel_format().get_color_threshold() + RGBA::new(15, 15, 15, 15);
    compare_images(reference, result, threshold).ok
}

const VERTEX_SHADER_2D: &str = "attribute highp vec2 a_position;\n\
    attribute highp vec2 a_texCoord;\n\
    uniform highp sampler2D u_texture;\n\
    uniform highp float u_lod;\n\
    varying mediump vec4 v_color;\n\
    \n\
    void main()\n\
    {\n\
    \tgl_Position = vec4(a_position, 0.0, 1.0);\n\
    \tv_color = texture2DLod(u_texture, a_texCoord, u_lod);\n\
    }\n";

const VERTEX_SHADER_CUBE: &str = "attribute highp vec2 a_position;\n\
    attribute highp vec3 a_texCoord;\n\
    uniform highp samplerCube u_texture;\n\
    uniform highp float u_lod;\n\
    varying mediump vec4 v_color;\n\
    \n\
    void main()\n\
    {\n\
    \tgl_Position = vec4(a_position, 0.0, 1.0);\n\
    \tv_color = textureCubeLod(u_texture, a_texCoord, u_lod);\n\
    }\n";

const VERTEX_SHADER_2D_ES3: &str = "#version 300 es\n\
    in highp vec2 a_position;\n\
    in highp vec2 a_texCoord;\n\
    uniform highp sampler2D u_texture;\n\
    uniform highp float u_lod;\n\
    out mediump vec4 v_color;\n\
    \n\
    void main()\n\
    {\n\
    \tgl_Position = vec4(a_position, 0.0, 1.0);\n\
    \tv_color = textureLod(u_texture, a_texCoord, u_lod);\n\
    }\n";

const VERTEX_SHADER_CUBE_ES3: &str = "#version 300 es\n\
    in highp vec2 a_position;\n\
    in highp vec3 a_texCoord;\n\
    uniform highp samplerCube u_texture;\n\
    uniform highp float u_lod;\n\
    out mediump vec4 v_color;\n\
    \n\
    void main()\n\
    {\n\
    \tgl_Position = vec4(a_position, 0.0, 1.0);\n\
    \tv_color = textureLod(u_texture, a_texCoord, u_lod);\n\
    }\n";

pub(crate) const FRAGMENT_SHADER_ES3: &str = "#version 300 es\n\
    layout(location = 0) out mediump vec4 dEQP_FragColor;\n\
    in mediump vec4 v_color;\n\
    \n\
    void main()\n\
    {\n\
    \tdEQP_FragColor = v_color;\n\
    }\n";

const FRAGMENT_SHADER: &str = "varying mediump vec4 v_color;\n\
    \n\
    void main()\n\
    {\n\
    \tgl_FragColor = v_color;\n\
    }\n";

/// The common head of both `init`s: MSAA check, then build the program, telling "no vertex
/// texture units" (NotSupported) apart from a real compile failure.
pub(crate) fn build_program<'gl>(
    context: &'gl Context,
    vertex_shader: &str,
    fragment_shader: &str,
) -> Result<ShaderProgram<'gl>, TestError> {
    if context.render_target().num_samples != 0 {
        return Err(TestError::NotSupported(
            "MSAA config not supported by this test".to_string(),
        ));
    }

    let gl = context.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vertex_shader, fragment_shader));

    if !program.is_ok() {
        let mut max_vertex_textures: glw::GLint = 0;
        // SAFETY: one query, one GLint of output.
        unsafe { gl.get_integerv(glw::GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS, &mut max_vertex_textures) };

        if max_vertex_textures < 1 {
            return Err(TestError::NotSupported(
                "Vertex texture image units not supported".to_string(),
            ));
        }
        return Err(TestError::Fail("Failed to compile shader".to_string()));
    }

    Ok(program)
}

/// `setupShaderInputs` (minus the texture binding, which differs by target) + `renderCell`'s draw.
#[allow(clippy::too_many_arguments)]
pub(crate) fn render_cell(
    gl: &glw::Functions,
    program: &ShaderProgram<'_>,
    tex_target: u32,
    gl_texture: u32,
    wrap_s: u32,
    wrap_t: u32,
    wrap_r: Option<u32>,
    min_filter: u32,
    mag_filter: u32,
    lod: f32,
    grid: &PosTexCoordQuadGrid,
) {
    let program_id = program.program();
    let positions = grid.position_data();
    let tex_coords = grid.tex_coord_data();

    // SAFETY: `positions`/`tex_coords`/`grid.indices` outlive the draw call; the attribute
    // pointers describe exactly their layout (2 and `tex_dims` floats per vertex) and the
    // draw reads `num_indices()` u16 indices, all of which index into the vertex arrays.
    unsafe {
        let position_loc = gl.get_attrib_location(program_id, c"a_position".as_ptr());
        if position_loc != -1 {
            gl.enable_vertex_attrib_array(position_loc as u32);
            gl.vertex_attrib_pointer(
                position_loc as u32,
                2,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                positions.as_ptr().cast(),
            );
        }

        let tex_coord_loc = gl.get_attrib_location(program_id, c"a_texCoord".as_ptr());
        if tex_coord_loc != -1 {
            gl.enable_vertex_attrib_array(tex_coord_loc as u32);
            gl.vertex_attrib_pointer(
                tex_coord_loc as u32,
                grid.tex_dims as i32,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                tex_coords.as_ptr().cast(),
            );
        }

        let lod_loc = gl.get_uniform_location(program_id, c"u_lod".as_ptr());
        if lod_loc != -1 {
            gl.uniform_1f(lod_loc, lod);
        }

        gl.active_texture(glw::GL_TEXTURE0);
        gl.bind_texture(tex_target, gl_texture);
        gl.tex_parameteri(tex_target, glw::GL_TEXTURE_WRAP_S, wrap_s as i32);
        gl.tex_parameteri(tex_target, glw::GL_TEXTURE_WRAP_T, wrap_t as i32);
        if let Some(wrap_r) = wrap_r {
            gl.tex_parameteri(tex_target, glw::GL_TEXTURE_WRAP_R, wrap_r as i32);
        }
        gl.tex_parameteri(tex_target, glw::GL_TEXTURE_MIN_FILTER, min_filter as i32);
        gl.tex_parameteri(tex_target, glw::GL_TEXTURE_MAG_FILTER, mag_filter as i32);

        let tex_loc = gl.get_uniform_location(program_id, c"u_texture".as_ptr());
        if tex_loc != -1 {
            gl.uniform_1i(tex_loc, 0);
        }

        gl.draw_elements(
            glw::GL_TRIANGLES,
            grid.num_indices() as i32,
            glw::GL_UNSIGNED_SHORT,
            grid.indices.as_ptr().cast(),
        );

        if position_loc != -1 {
            gl.disable_vertex_attrib_array(position_loc as u32);
        }
        if tex_coord_loc != -1 {
            gl.disable_vertex_attrib_array(tex_coord_loc as u32);
        }
    }
}

pub(crate) struct Render {
    pub(crate) region: Rect,
    pub(crate) texture_ndx: usize,
    pub(crate) tex_coord_scale: [f32; 2],
    pub(crate) tex_coord_offset: [f32; 2],
}

pub(crate) fn lod_for(tex_scale: [f32; 2], dst_size: [f32; 2], src_size: [f32; 2]) -> f32 {
    let size_ratio = [
        tex_scale[0] * src_size[0] / dst_size[0],
        tex_scale[1] * src_size[1] / dst_size[1],
    ];
    // In this particular case dv/dx and du/dy are zero, simplifying the expression.
    size_ratio[0].max(size_ratio[1]).log2()
}

fn collect_levels_2d(tex: &crate::tcu::texture_2d::Texture2D) -> Vec<ConstPixelBufferAccess<'_>> {
    (0..tex.num_levels())
        .take_while(|&l| !tex.is_level_empty(l))
        .map(|l| tex.level(l))
        .collect()
}

fn collect_levels_cube(tex: &crate::tcu::texture_cube::TextureCube) -> Vec<ConstPixelBufferAccess<'_>> {
    (0..tex.num_levels())
        .take_while(|&l| !tex.is_level_empty(l))
        .map(|l| tex.level(l))
        .collect()
}

pub(crate) fn mul_add(v: [f32; 4], scale: [f32; 4], bias: [f32; 4]) -> [f32; 4] {
    std::array::from_fn(|i| v[i] * scale[i] + bias[i])
}

fn make_2d_textures(render_ctx: &RenderContext) -> Result<Vec<Texture2D<'_>>, TestError> {
    // Compute suitable power-of-two sizes (for mipmaps).
    let tex_width = ((MAX_2D_RENDER_WIDTH / 2) as u32).next_power_of_two() as i32;
    let tex_height = ((MAX_2D_RENDER_HEIGHT / 2) as u32).next_power_of_two() as i32;

    let mut textures = Vec::with_capacity(2);
    for _ in 0..2 {
        textures.push(Texture2D::new(
            render_ctx,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            tex_width as u32,
            tex_height as u32,
        )?);
    }

    let mipmaps = (tex_width as u32).is_power_of_two() && (tex_height as u32).is_power_of_two();
    let num_levels = if mipmaps {
        (31 - (tex_width.max(tex_height) as u32).leading_zeros()) as usize + 1
    } else {
        1
    };
    let fmt_info = get_texture_format_info(textures[0].ref_texture().format());
    let c_bias = fmt_info.value_min;
    let c_scale: [f32; 4] = std::array::from_fn(|i| fmt_info.value_max[i] - fmt_info.value_min[i]);

    // Fill first with gradient texture.
    for level_ndx in 0..num_levels {
        let g_min = mul_add([-0.5, -0.5, -0.5, 2.0], c_scale, c_bias);
        let g_max = mul_add([1.0, 1.0, 1.0, 0.0], c_scale, c_bias);

        textures[0].ref_texture_mut().alloc_level(level_ndx);
        let mut level = textures[0].ref_texture_mut().level_mut(level_ndx);
        fill_with_component_gradients2(&mut level, g_min, g_max);
    }

    // Fill second with grid texture.
    for level_ndx in 0..num_levels {
        let step = 0x00ff_ffffu32 / num_levels as u32;
        let rgb = step.wrapping_mul(level_ndx as u32);
        let color_a = 0xff00_0000u32 | rgb;
        let color_b = 0xff00_0000u32 | !rgb;

        textures[1].ref_texture_mut().alloc_level(level_ndx);
        let mut level = textures[1].ref_texture_mut().level_mut(level_ndx);
        fill_with_grid(
            &mut level,
            4,
            mul_add(RGBA::from_packed(color_a).to_vec().m_data, c_scale, c_bias),
            mul_add(RGBA::from_packed(color_b).to_vec().m_data, c_scale, c_bias),
        );
    }

    // Upload.
    for tex in &textures {
        // SAFETY: a current context; `tex` outlives the upload.
        unsafe { tex.upload()? };
    }

    Ok(textures)
}

fn make_cube_textures(render_ctx: &RenderContext) -> Result<Vec<TextureCube<'_>>, TestError> {
    // Compute suitable power-of-two sizes (for mipmaps).
    let tex_width = ((MAX_CUBE_RENDER_WIDTH / 3 / 2) as u32).next_power_of_two() as i32;

    let mut textures = Vec::with_capacity(2);
    for _ in 0..2 {
        textures.push(TextureCube::new(
            render_ctx,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            tex_width as u32,
        )?);
    }

    let mipmaps = (tex_width as u32).is_power_of_two();
    let num_levels = if mipmaps {
        (31 - (tex_width as u32).leading_zeros()) as usize + 1
    } else {
        1
    };
    let fmt_info = get_texture_format_info(textures[0].ref_texture().format());
    let c_bias = fmt_info.value_min;
    let c_scale: [f32; 4] = std::array::from_fn(|i| fmt_info.value_max[i] - fmt_info.value_min[i]);

    // Fill first with gradient texture.
    const GRADIENTS: [([f32; 4], [f32; 4]); 6] = [
        ([-1.0, -1.0, -1.0, 2.0], [1.0, 1.0, 1.0, 0.0]), // negative x
        ([0.0, -1.0, -1.0, 2.0], [1.0, 1.0, 1.0, 0.0]),  // positive x
        ([-1.0, 0.0, -1.0, 2.0], [1.0, 1.0, 1.0, 0.0]),  // negative y
        ([-1.0, -1.0, 0.0, 2.0], [1.0, 1.0, 1.0, 0.0]),  // positive y
        ([-1.0, -1.0, -1.0, 0.0], [1.0, 1.0, 1.0, 1.0]), // negative z
        ([0.0, 0.0, 0.0, 2.0], [1.0, 1.0, 1.0, 0.0]),    // positive z
    ];
    for (face_ndx, &face) in FACES.iter().enumerate() {
        for level_ndx in 0..num_levels {
            // `allocLevel(face, level)` allocates the whole level once; later faces find it there.
            if textures[0].ref_texture().is_level_empty(level_ndx) {
                textures[0].ref_texture_mut().alloc_level(level_ndx);
            }
            let mut level = textures[0].ref_texture_mut().face_level_mut(face, level_ndx);
            fill_with_component_gradients2(
                &mut level,
                mul_add(GRADIENTS[face_ndx].0, c_scale, c_bias),
                mul_add(GRADIENTS[face_ndx].1, c_scale, c_bias),
            );
        }
    }

    // Fill second with grid texture.
    for (face_ndx, &face) in FACES.iter().enumerate() {
        for level_ndx in 0..num_levels {
            let step = 0x00ff_ffffu32 / (num_levels as u32 * 6);
            let rgb = step.wrapping_mul(level_ndx as u32).wrapping_mul(face_ndx as u32);
            let color_a = 0xff00_0000u32 | rgb;
            let color_b = 0xff00_0000u32 | !rgb;

            if textures[1].ref_texture().is_level_empty(level_ndx) {
                textures[1].ref_texture_mut().alloc_level(level_ndx);
            }
            let mut level = textures[1].ref_texture_mut().face_level_mut(face, level_ndx);
            fill_with_grid(
                &mut level,
                4,
                mul_add(RGBA::from_packed(color_a).to_vec().m_data, c_scale, c_bias),
                mul_add(RGBA::from_packed(color_b).to_vec().m_data, c_scale, c_bias),
            );
        }
    }

    // Upload.
    for tex in &textures {
        // SAFETY: a current context; `tex` outlives the upload.
        unsafe { tex.upload()? };
    }

    Ok(textures)
}

struct Vertex2DTextureCase {
    es3: bool,
    name: String,
    min_filter: u32,
    mag_filter: u32,
    wrap_s: u32,
    wrap_t: u32,
}

impl TestCase for Vertex2DTextureCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();

        // `Vertex2DTextureCase::init`
        let program = if self.es3 {
            build_program(context, VERTEX_SHADER_2D_ES3, FRAGMENT_SHADER_ES3)?
        } else {
            build_program(context, VERTEX_SHADER_2D, FRAGMENT_SHADER)?
        };
        let textures = make_2d_textures(render_ctx)?;

        // `Vertex2DTextureCase::iterate`
        let viewport = RandomViewport::new(
            &render_target,
            MAX_2D_RENDER_WIDTH,
            MAX_2D_RENDER_HEIGHT,
            de_string_hash(&self.name),
        );
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

        // Texture scaling and offsetting vectors.
        let tex_min_scale = [1.8f32, 1.8];
        let tex_min_offset = [-0.3f32, -0.2];
        let tex_mag_scale = [0.3f32, 0.3];
        let tex_mag_offset = [0.9f32, 0.8];

        // Surface for the reference image.
        let mut ref_image = Surface::new(viewport_width, viewport_height);

        let renders = [
            Render {
                region: Rect::new(0, 0, left_width, bottom_height),
                texture_ndx: 0,
                tex_coord_scale: tex_min_scale,
                tex_coord_offset: tex_min_offset,
            },
            Render {
                region: Rect::new(left_width, 0, right_width, bottom_height),
                texture_ndx: 0,
                tex_coord_scale: tex_mag_scale,
                tex_coord_offset: tex_mag_offset,
            },
            Render {
                region: Rect::new(0, bottom_height, left_width, top_height),
                texture_ndx: 1,
                tex_coord_scale: tex_min_scale,
                tex_coord_offset: tex_min_offset,
            },
            Render {
                region: Rect::new(left_width, bottom_height, right_width, top_height),
                texture_ndx: 1,
                tex_coord_scale: tex_mag_scale,
                tex_coord_offset: tex_mag_offset,
            },
        ];

        let ref_params = make_reference_params(
            TextureType::Texture2D,
            self.wrap_s,
            self.wrap_t,
            self.wrap_s,
            self.min_filter,
            self.mag_filter,
            LodMode::Exact,
        )?;

        for rend in &renders {
            let ref_texture = textures[rend.texture_ndx].ref_texture();
            let src_size = [ref_texture.width() as f32, ref_texture.height() as f32];
            let lod = lod_for(
                rend.tex_coord_scale,
                [rend.region.w as f32, rend.region.h as f32],
                src_size,
            );
            let use_safe_tex_coords = is_level_nearest(if lod > 0.0 { self.min_filter } else { self.mag_filter });
            let grid = PosTexCoordQuadGrid::new(
                GRID_SIZE_2D,
                [rend.region.w, rend.region.h],
                [ref_texture.width() as i32, ref_texture.height() as i32],
                &TexCoordParams {
                    scale: rend.tex_coord_scale,
                    bias: rend.tex_coord_offset,
                    face: CubeFace::NegativeX,
                },
                2,
                use_safe_tex_coords,
            );

            // SAFETY: plain state setting on the current context.
            unsafe {
                gl.viewport(
                    viewport.x + rend.region.x,
                    viewport.y + rend.region.y,
                    rend.region.w,
                    rend.region.h,
                )
            };
            render_cell(
                gl,
                &program,
                glw::GL_TEXTURE_2D,
                textures[rend.texture_ndx].gl_texture(),
                self.wrap_s,
                self.wrap_t,
                None,
                self.min_filter,
                self.mag_filter,
                lod,
                &grid,
            );

            // `computeReferenceCell`
            let levels = collect_levels_2d(ref_texture);
            let used = effective_levels(&levels, &ref_params);
            compute_reference(
                |c| exec_sample_2d(used, &ref_params, c[0], c[1], lod),
                &grid,
                &mut ref_image,
                rend.region,
            );
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

struct VertexCubeTextureCase {
    es3: bool,
    name: String,
    min_filter: u32,
    mag_filter: u32,
    wrap_s: u32,
    wrap_t: u32,
}

impl TestCase for VertexCubeTextureCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();

        // `VertexCubeTextureCase::init`
        let is_es3_capable = self.es3 || context.is_es3_compatible();
        let program = if self.es3 {
            build_program(context, VERTEX_SHADER_CUBE_ES3, FRAGMENT_SHADER_ES3)?
        } else {
            build_program(context, VERTEX_SHADER_CUBE, FRAGMENT_SHADER)?
        };
        let textures = make_cube_textures(render_ctx)?;

        // `VertexCubeTextureCase::iterate`
        let viewport = RandomViewport::new(
            &render_target,
            MAX_CUBE_RENDER_WIDTH,
            MAX_CUBE_RENDER_HEIGHT,
            de_string_hash(&self.name),
        );
        let viewport_width = viewport.width;
        let viewport_height = viewport.height;

        // SAFETY: plain state setting on the current context.
        unsafe {
            gl.use_program(program.program());
            // Clear.
            gl.clear_color(0.125, 0.25, 0.5, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }

        // Divide viewport into 4 areas.
        let left_width = viewport_width / 2;
        let right_width = viewport_width - left_width;
        let bottom_height = viewport_height / 2;
        let top_height = viewport_height - bottom_height;

        // Texture scaling and offsetting vectors.
        let tex_min_scale = [1.0f32, 1.0];
        let tex_min_offset = [0.0f32, 0.0];
        let tex_mag_scale = [0.3f32, 0.3];
        let tex_mag_offset = [0.5f32, 0.3];

        // Surface for the reference image.
        let mut ref_image = Surface::new(viewport_width, viewport_height);

        let mut ref_params = make_reference_params(
            TextureType::Cube,
            self.wrap_s,
            self.wrap_t,
            self.wrap_s,
            self.min_filter,
            self.mag_filter,
            LodMode::Exact,
        )?;
        ref_params.sampler.seamless_cube_map = is_es3_capable;

        // Each of the four areas is divided into 6 cells.
        let def_cell_width = viewport_width / 2 / 3;
        let def_cell_height = viewport_height / 2 / 2;

        for (i, &face) in FACES.iter().enumerate() {
            let i = i as i32;
            let cell_offset_x = def_cell_width * (i % 3);
            let cell_offset_y = def_cell_height * (i / 3);
            let is_rightmost_cell = i == 2 || i == 5;
            let is_top_cell = i >= 3;
            let left_cell_width = if is_rightmost_cell {
                left_width - cell_offset_x
            } else {
                def_cell_width
            };
            let right_cell_width = if is_rightmost_cell {
                right_width - cell_offset_x
            } else {
                def_cell_width
            };
            let bottom_cell_height = if is_top_cell {
                bottom_height - cell_offset_y
            } else {
                def_cell_height
            };
            let top_cell_height = if is_top_cell {
                top_height - cell_offset_y
            } else {
                def_cell_height
            };

            let renders = [
                Render {
                    region: Rect::new(cell_offset_x, cell_offset_y, left_cell_width, bottom_cell_height),
                    texture_ndx: 0,
                    tex_coord_scale: tex_min_scale,
                    tex_coord_offset: tex_min_offset,
                },
                Render {
                    region: Rect::new(
                        cell_offset_x + left_width,
                        cell_offset_y,
                        right_cell_width,
                        bottom_cell_height,
                    ),
                    texture_ndx: 0,
                    tex_coord_scale: tex_mag_scale,
                    tex_coord_offset: tex_mag_offset,
                },
                Render {
                    region: Rect::new(
                        cell_offset_x,
                        cell_offset_y + bottom_height,
                        left_cell_width,
                        top_cell_height,
                    ),
                    texture_ndx: 1,
                    tex_coord_scale: tex_min_scale,
                    tex_coord_offset: tex_min_offset,
                },
                Render {
                    region: Rect::new(
                        cell_offset_x + left_width,
                        cell_offset_y + bottom_height,
                        right_cell_width,
                        top_cell_height,
                    ),
                    texture_ndx: 1,
                    tex_coord_scale: tex_mag_scale,
                    tex_coord_offset: tex_mag_offset,
                },
            ];

            for rend in &renders {
                let ref_texture = textures[rend.texture_ndx].ref_texture();
                let size = ref_texture.size() as i32;
                let lod = lod_for(
                    rend.tex_coord_scale,
                    [rend.region.w as f32, rend.region.h as f32],
                    [size as f32, size as f32],
                );
                let use_safe_tex_coords = is_level_nearest(if lod > 0.0 { self.min_filter } else { self.mag_filter });
                let grid = PosTexCoordQuadGrid::new(
                    GRID_SIZE_CUBE,
                    [rend.region.w, rend.region.h],
                    [size, size],
                    &TexCoordParams {
                        scale: rend.tex_coord_scale,
                        bias: rend.tex_coord_offset,
                        face,
                    },
                    3,
                    use_safe_tex_coords,
                );

                // SAFETY: plain state setting on the current context.
                unsafe {
                    gl.viewport(
                        viewport.x + rend.region.x,
                        viewport.y + rend.region.y,
                        rend.region.w,
                        rend.region.h,
                    )
                };
                render_cell(
                    gl,
                    &program,
                    glw::GL_TEXTURE_CUBE_MAP,
                    textures[rend.texture_ndx].gl_texture(),
                    self.wrap_s,
                    self.wrap_t,
                    None,
                    self.min_filter,
                    self.mag_filter,
                    lod,
                    &grid,
                );

                // `computeReferenceCell`
                let levels = collect_levels_cube(ref_texture);
                let used = effective_levels(&levels, &ref_params);
                compute_reference(
                    |c| exec_sample_cube(used, &ref_params, c[0], c[1], c[2], lod),
                    &grid,
                    &mut ref_image,
                    rend.region,
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

pub(crate) const WRAP_MODES: [(&str, u32); 3] = [
    ("clamp", glw::GL_CLAMP_TO_EDGE),
    ("repeat", glw::GL_REPEAT),
    ("mirror", glw::GL_MIRRORED_REPEAT),
];

pub(crate) const MIN_FILTER_MODES: [(&str, u32); 6] = [
    ("nearest", glw::GL_NEAREST),
    ("linear", glw::GL_LINEAR),
    ("nearest_mipmap_nearest", glw::GL_NEAREST_MIPMAP_NEAREST),
    ("linear_mipmap_nearest", glw::GL_LINEAR_MIPMAP_NEAREST),
    ("nearest_mipmap_linear", glw::GL_NEAREST_MIPMAP_LINEAR),
    ("linear_mipmap_linear", glw::GL_LINEAR_MIPMAP_LINEAR),
];

pub(crate) const MAG_FILTER_MODES: [(&str, u32); 2] = [("nearest", glw::GL_NEAREST), ("linear", glw::GL_LINEAR)];

/// `VertexTextureTests::init` of the ES 2.0 module.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("vertex");
    add_2d_and_cube_groups(&mut group, false);
    group
}

/// The `2d` and `cube` groups of `VertexTextureTests::init`; the ES 3.0 module's are the
/// same cases with `#version 300 es` shaders and an always-seamless cube sampler.
pub(crate) fn add_2d_and_cube_groups(group: &mut TestCaseGroup, es3: bool) {
    let mut group_2d = TestCaseGroup::new("2d");
    let mut group_cube = TestCaseGroup::new("cube");
    let mut filtering_2d = TestCaseGroup::new("filtering");
    let mut wrap_2d = TestCaseGroup::new("wrap");
    let mut filtering_cube = TestCaseGroup::new("filtering");
    let mut wrap_cube = TestCaseGroup::new("wrap");

    // 2D cases.
    for &(min_name, min_filter) in &MIN_FILTER_MODES {
        for &(mag_name, mag_filter) in &MAG_FILTER_MODES {
            for &(wrap_name, wrap_mode) in &WRAP_MODES {
                let name = format!("{min_name}_{mag_name}_{wrap_name}");
                filtering_2d.add_child(Box::new(Vertex2DTextureCase {
                    es3,
                    name,
                    min_filter,
                    mag_filter,
                    wrap_s: wrap_mode,
                    wrap_t: wrap_mode,
                }) as Box<dyn TestCase>);
            }
        }
    }

    for &(wrap_s_name, wrap_s) in &WRAP_MODES {
        for &(wrap_t_name, wrap_t) in &WRAP_MODES {
            let name = format!("{wrap_s_name}_{wrap_t_name}");
            wrap_2d.add_child(Box::new(Vertex2DTextureCase {
                es3,
                name,
                min_filter: glw::GL_LINEAR_MIPMAP_LINEAR,
                mag_filter: glw::GL_LINEAR,
                wrap_s,
                wrap_t,
            }) as Box<dyn TestCase>);
        }
    }

    // Cube map cases.
    for &(min_name, min_filter) in &MIN_FILTER_MODES {
        for &(mag_name, mag_filter) in &MAG_FILTER_MODES {
            for &(wrap_name, wrap_mode) in &WRAP_MODES {
                let name = format!("{min_name}_{mag_name}_{wrap_name}");
                filtering_cube.add_child(Box::new(VertexCubeTextureCase {
                    es3,
                    name,
                    min_filter,
                    mag_filter,
                    wrap_s: wrap_mode,
                    wrap_t: wrap_mode,
                }) as Box<dyn TestCase>);
            }
        }
    }

    for &(wrap_s_name, wrap_s) in &WRAP_MODES {
        for &(wrap_t_name, wrap_t) in &WRAP_MODES {
            let name = format!("{wrap_s_name}_{wrap_t_name}");
            wrap_cube.add_child(Box::new(VertexCubeTextureCase {
                es3,
                name,
                min_filter: glw::GL_LINEAR_MIPMAP_LINEAR,
                mag_filter: glw::GL_LINEAR,
                wrap_s,
                wrap_t,
            }) as Box<dyn TestCase>);
        }
    }

    group_2d.add_child(filtering_2d);
    group_2d.add_child(wrap_2d);
    group_cube.add_child(filtering_cube);
    group_cube.add_child(wrap_cube);
    group.add_child(group_2d);
    group.add_child(group_cube);
}
