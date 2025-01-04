// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fTextureFilteringTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream runs one `FilterCase` per `iterate()` call;
// here one `iterate()` loops over them, with the same verdict rule as `gles3/.../texture/filtering.rs`:
// a case failing both precision tiers is a Fail, otherwise any case passing only the lower tier is a
// QualityWarning. The whole `texture.filtering.cube_array` tree (formats 72, sizes 30, combinations 108,
// no_edges_visible 2) is ported. Rendering uses the raw GL cube array quad program of
// `texture_format_tests` instead of `gls::TextureRenderer` (which has no cube array program), and the
// cube array reference/verification is `glu::texture_test_util::{sample_texture_cube_array,
// compute_texture_lookup_diff_cube_array}`. A format whose host-side reference level cannot be written
// is reported as NotSupported with the reason.

use super::texture_format_tests::cube_array_quad_program;
use crate::gls::texture_test_util::RandomViewport;
use crate::glu::texture_test_util::{
    LodMode, TextureType, compute_texture_lookup_diff_cube_array, get_sampler_type, sample_texture_cube_array,
};
use crate::glu::texture_test_util_surface::{
    compute_quad_tex_coord_cube_region, effective_levels, fill_with_component_gradients_old, make_lookup_precision,
    make_reference_params,
};
use crate::glu::texture_util::{get_transfer_format, map_gl_internal_format};
use crate::glu::{self, Context, TestCase, TestCaseGroup, Texture, VertexArray};
use crate::glw;
use crate::tcu::pixel::{ConstPixelBufferAccess, CubeFace, TextureLevel, fill_with_grid, get_texture_format_info};
use crate::tcu::pixel_format::PixelFormat;
use crate::tcu::random::de_int32_hash;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::surface_access::SurfaceAccess;
use crate::tcu::tex_verifier::{LodPrecision, LookupPrecision};
use crate::tcu::vector::{Vec2, Vec4};
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus, de_string_hash};

const FACES: [CubeFace; 6] = [
    CubeFace::NegativeX,
    CubeFace::PositiveX,
    CubeFace::NegativeY,
    CubeFace::PositiveY,
    CubeFace::NegativeZ,
    CubeFace::PositiveZ,
];

/// `getFaceDesc`
fn face_desc(face: CubeFace) -> &'static str {
    match face {
        CubeFace::NegativeX => "-X",
        CubeFace::PositiveX => "+X",
        CubeFace::NegativeY => "-Y",
        CubeFace::PositiveY => "+Y",
        CubeFace::NegativeZ => "-Z",
        CubeFace::PositiveZ => "+Z",
    }
}

/// `computeQuadTexCoordCubeArray(dst, face, bottomLeft, topRight, layerRange)` - the cube region quad with
/// the layer coordinate as fourth component, interpolated from `layer_range.x` to `layer_range.y` over the
/// vertices when the two differ.
fn compute_quad_tex_coord_cube_array(
    face: CubeFace,
    bottom_left: Vec2,
    top_right: Vec2,
    layer_range: Vec2,
) -> [f32; 16] {
    let cube = compute_quad_tex_coord_cube_region(face, bottom_left, top_right);
    let l0 = layer_range.x();
    let l1 = layer_range.y();
    let q: [f32; 4] = if l0 != l1 {
        [l0, l0 * 0.5 + l1 * 0.5, l0 * 0.5 + l1 * 0.5, l1]
    } else {
        [l0; 4]
    };
    std::array::from_fn(|i| {
        if i % 4 == 3 {
            q[i / 4]
        } else {
            cube[(i / 4) * 3 + i % 4]
        }
    })
}

/// How a case did, ordered from best to worst.
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
enum Quality {
    High,
    Low,
    Fail,
}

/// `verifyTextureResult` for a cube array.
#[allow(clippy::too_many_arguments)]
fn verify_texture_result_cube_array(
    result: &Surface,
    levels: &[ConstPixelBufferAccess<'_>],
    tex_coord: [f32; 16],
    sample_params: &crate::glu::texture_test_util::ReferenceParams,
    lookup_prec: &LookupPrecision,
    layer_coord_bits: i32,
    lod_prec: &LodPrecision,
    pixel_format: PixelFormat,
) -> Result<bool, TestError> {
    let mut reference = Surface::new(result.get_width(), result.get_height());
    let mut error_mask = Surface::new(result.get_width(), result.get_height());

    let eff = effective_levels(levels, sample_params);
    SurfaceAccess::new(&mut reference, pixel_format)
        .write_with(|access| sample_texture_cube_array(access, eff, tex_coord, sample_params))?;

    let num_failed = compute_texture_lookup_diff_cube_array(
        &result.get_const_access(),
        &reference.get_const_access(),
        &mut error_mask.get_access(),
        eff,
        tex_coord,
        sample_params,
        lookup_prec,
        layer_coord_bits,
        lod_prec,
    );
    Ok(num_failed == 0)
}

fn scale_bias(v: [f32; 4], scale: [f32; 4], bias: [f32; 4]) -> [f32; 4] {
    std::array::from_fn(|c| v[c] * scale[c] + bias[c])
}

struct TextureCubeArrayFilteringCase {
    name: String,
    min_filter: u32,
    mag_filter: u32,
    wrap_s: u32,
    wrap_t: u32,
    internal_format: u32,
    size: i32,
    depth: i32,
    only_sample_face_interior: bool,
}

/// One texture's host-side levels, `depth` slices each.
fn upload_levels(
    gl: &glw::Functions,
    texture: &Texture,
    levels: &[TextureLevel],
    internal_format: u32,
    transfer: crate::glu::texture_util::TransferFormat,
) {
    // SAFETY: the level bytes outlive the calls; names are owned by the caller.
    unsafe {
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, texture.get());
        gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
        for (level_ndx, level) in levels.iter().enumerate() {
            let [w, h, d] = level.get_const_access().size();
            gl.tex_image_3d(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                level_ndx as i32,
                internal_format as i32,
                w as i32,
                h as i32,
                d as i32,
                0,
                transfer.format,
                transfer.data_type,
                level.data().as_ptr().cast(),
            );
        }
        gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 4);
    }
}

impl TestCase for TextureCubeArrayFilteringCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let info = &context.context_info;
        if !context.context_type().supports(3, 2) && !info.is_extension_supported("GL_EXT_texture_cube_map_array") {
            return Err(TestError::NotSupported(
                "GL_EXT_texture_cube_map_array not supported".to_string(),
            ));
        }
        if self.internal_format == glw::GL_SR8_EXT && !info.is_extension_supported("GL_EXT_texture_sRGB_R8") {
            return Err(TestError::NotSupported(
                "GL_EXT_texture_sRGB_R8 not supported".to_string(),
            ));
        }
        if self.internal_format == glw::GL_SRG8_EXT && !info.is_extension_supported("GL_EXT_texture_sRGB_RG8") {
            return Err(TestError::NotSupported(
                "GL_EXT_texture_sRGB_RG8 not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let pixel_format = render_target.pixel_format();

        // `TextureCubeArrayFilteringCase::init`
        let tex_format = map_gl_internal_format(self.internal_format)
            .ok_or_else(|| TestError::InternalError(format!("unmapped format 0x{:04X}", self.internal_format)))?;
        let transfer = get_transfer_format(tex_format)
            .map_err(|e| TestError::NotSupported(format!("no GL transfer format for the reference level: {e}")))?;
        let fmt_info = get_texture_format_info(tex_format);
        let c_scale: [f32; 4] = std::array::from_fn(|c| fmt_info.value_max[c] - fmt_info.value_min[c]);
        let c_bias = fmt_info.value_min;
        let num_levels = (31 - (self.size as u32).leading_zeros()) as usize + 1;
        let num_layers = self.depth / 6;

        let new_levels = || -> Result<Vec<TextureLevel>, TestError> {
            (0..num_levels)
                .map(|level_ndx| {
                    let w = (self.size >> level_ndx).max(1) as u32;
                    TextureLevel::new(tex_format, w, w, self.depth as u32).map_err(|e| {
                        TestError::NotSupported(format!("host-side reference level cannot be written: {e}"))
                    })
                })
                .collect()
        };
        let mut gradient_levels = new_levels()?;
        let mut grid_levels = new_levels()?;

        const LEVEL_SWZ: [[usize; 4]; 4] = [[0, 1, 2, 3], [2, 1, 3, 0], [3, 0, 1, 2], [1, 3, 2, 0]];
        let swizzle = |v: [f32; 4], s: [usize; 4]| [v[s[0]], v[s[1]], v[s[2]], v[s[3]]];

        // Fill first gradient texture (gradient direction varies between layers).
        for level in gradient_levels.iter_mut() {
            let [w, h, _] = level.get_const_access().size();
            let mut access = level.get_access();
            for layer_face_ndx in 0..self.depth {
                let swz = LEVEL_SWZ[layer_face_ndx as usize % LEVEL_SWZ.len()];
                let g_min = scale_bias(swizzle([0.0, 0.0, 0.0, 1.0], swz), c_scale, c_bias);
                let g_max = scale_bias(swizzle([1.0, 1.0, 1.0, 0.0], swz), c_scale, c_bias);
                let mut sub = access.get_subregion(0, 0, layer_face_ndx as u32, w, h, 1);
                fill_with_component_gradients_old(&mut sub, g_min, g_max);
            }
        }

        // Fill second with grid texture (each layer has unique colors).
        for (level_ndx, level) in grid_levels.iter_mut().enumerate() {
            let [w, h, _] = level.get_const_access().size();
            let mut access = level.get_access();
            for layer_face_ndx in 0..self.depth {
                let step = 0x00ff_ffffu32 / (num_levels as u32 * self.depth as u32 - 1);
                let rgb = step.wrapping_mul(level_ndx as u32 + layer_face_ndx as u32 * num_levels as u32);
                let color_a = 0xff00_0000 | rgb;
                let color_b = 0xff00_0000 | !rgb;
                let mut sub = access.get_subregion(0, 0, layer_face_ndx as u32, w, h, 1);
                fill_with_grid(
                    &mut sub,
                    4,
                    scale_bias(RGBA::from_packed(color_a).to_vec().m_data, c_scale, c_bias),
                    scale_bias(RGBA::from_packed(color_b).to_vec().m_data, c_scale, c_bias),
                );
            }
        }

        // Upload.
        let gradient_gl = Texture::new(gl);
        let grid_gl = Texture::new(gl);
        upload_levels(gl, &gradient_gl, &gradient_levels, self.internal_format, transfer);
        upload_levels(gl, &grid_gl, &grid_levels, self.internal_format, transfer);
        glu::expect_no_error(gl, "Upload cube array textures")?;

        // Test cases: (texture index, bottom-left, top-right, layer range).
        let layers = num_layers as f32;
        let cases: Vec<(usize, Vec2, Vec2, Vec2)> = if self.only_sample_face_interior {
            vec![
                (
                    0,
                    Vec2::new(-0.8, -0.8),
                    Vec2::new(0.8, 0.8),
                    Vec2::new(-0.5, layers + 0.5),
                ), // minification
                (
                    0,
                    Vec2::new(0.5, 0.65),
                    Vec2::new(0.8, 0.8),
                    Vec2::new(-0.5, layers + 0.5),
                ), // magnification
                (
                    1,
                    Vec2::new(-0.8, -0.8),
                    Vec2::new(0.8, 0.8),
                    Vec2::new(layers + 0.5, -0.5),
                ), // minification
                (
                    1,
                    Vec2::new(0.2, 0.2),
                    Vec2::new(0.6, 0.5),
                    Vec2::new(layers + 0.5, -0.5),
                ), // magnification
            ]
        } else {
            let is_single_sample = render_target.num_samples == 0;
            let mut cases = Vec::new();
            // minification - w/ tweak to avoid hitting triangle edges with a face switchpoint in multisample configs
            if is_single_sample {
                cases.push((
                    0,
                    Vec2::new(-1.25, -1.2),
                    Vec2::new(1.2, 1.25),
                    Vec2::new(-0.5, layers + 0.5),
                ));
            } else {
                cases.push((
                    0,
                    Vec2::new(-1.19, -1.3),
                    Vec2::new(1.1, 1.35),
                    Vec2::new(-0.5, layers + 0.5),
                ));
            }
            cases.push((
                0,
                Vec2::new(0.8, 0.8),
                Vec2::new(1.25, 1.20),
                Vec2::new(-0.5, layers + 0.5),
            )); // magnification
            cases.push((
                1,
                Vec2::new(-1.19, -1.3),
                Vec2::new(1.1, 1.35),
                Vec2::new(layers + 0.5, -0.5),
            )); // minification
            cases.push((
                1,
                Vec2::new(-1.2, -1.1),
                Vec2::new(-0.8, -0.8),
                Vec2::new(layers + 0.5, -0.5),
            )); // magnification

            // Layer rounding - only in single-sample configs as multisample configs may produce smooth transition at the middle.
            if is_single_sample && num_layers > 1 {
                cases.push((
                    0,
                    Vec2::new(-2.0, -1.5),
                    Vec2::new(-0.1, 0.9),
                    Vec2::new(1.50001, 1.49999),
                ));
            }
            cases
        };

        let sampler_type = get_sampler_type(tex_format);
        let program = cube_array_quad_program(context, sampler_type);
        if !program.is_ok() {
            return Err(TestError::InternalError("Program compilation failed".to_string()));
        }
        let program_id = program.program();
        let vao = VertexArray::new(gl);
        // SAFETY: plain state setting on the current context.
        unsafe {
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_vertex_array(vao.get());
        }

        let viewport_size = 28;
        let positions: [[f32; 2]; 4] = [[-1.0, -1.0], [-1.0, 1.0], [1.0, -1.0], [1.0, 1.0]];
        let quad_indices: [u16; 6] = [0, 1, 2, 2, 1, 3];
        let is_nearest_only = self.min_filter == glw::GL_NEAREST && self.mag_filter == glw::GL_NEAREST;
        let mut worst = Quality::High;

        for (case_ndx, &(tex_ndx, bottom_left, top_right, layer_range)) in cases.iter().enumerate() {
            let (gl_texture, levels) = if tex_ndx == 0 {
                (&gradient_gl, &gradient_levels)
            } else {
                (&grid_gl, &grid_levels)
            };
            let viewport = RandomViewport::new(
                &render_target,
                viewport_size,
                viewport_size,
                de_string_hash(&self.name) ^ de_int32_hash(case_ndx as i32),
            );
            if viewport.width < viewport_size || viewport.height < viewport_size {
                return Err(TestError::NotSupported("Render target too small".to_string()));
            }

            // Params for reference computation.
            let mut ref_params = make_reference_params(
                TextureType::CubeArray,
                glw::GL_CLAMP_TO_EDGE,
                glw::GL_CLAMP_TO_EDGE,
                glw::GL_CLAMP_TO_EDGE,
                self.min_filter,
                self.mag_filter,
                LodMode::Exact,
            )?;
            ref_params.sampler.seamless_cube_map = true;
            ref_params.base.sampler_type = sampler_type;
            ref_params.base.color_bias = Vec4::from_array(fmt_info.look_up_bias);
            ref_params.base.color_scale = Vec4::from_array(fmt_info.look_up_scale);

            // SAFETY: plain state setting and uniform writes on the program that linked.
            unsafe {
                gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, gl_texture.get());
                gl.tex_parameteri(
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    glw::GL_TEXTURE_MIN_FILTER,
                    self.min_filter as i32,
                );
                gl.tex_parameteri(
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    glw::GL_TEXTURE_MAG_FILTER,
                    self.mag_filter as i32,
                );
                gl.tex_parameteri(
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    glw::GL_TEXTURE_WRAP_S,
                    self.wrap_s as i32,
                );
                gl.tex_parameteri(
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    glw::GL_TEXTURE_WRAP_T,
                    self.wrap_t as i32,
                );
                gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);
                gl.use_program(program_id);
                gl.uniform_1i(gl.get_uniform_location(program_id, c"u_sampler".as_ptr()), 0);
                let s = fmt_info.look_up_scale;
                let b = fmt_info.look_up_bias;
                gl.uniform_4f(
                    gl.get_uniform_location(program_id, c"u_colorScale".as_ptr()),
                    s[0],
                    s[1],
                    s[2],
                    s[3],
                );
                gl.uniform_4f(
                    gl.get_uniform_location(program_id, c"u_colorBias".as_ptr()),
                    b[0],
                    b[1],
                    b[2],
                    b[3],
                );
            }

            let level_accesses: Vec<ConstPixelBufferAccess<'_>> = levels.iter().map(|l| l.get_const_access()).collect();

            for &face in &FACES {
                let mut result = Surface::new(viewport.width, viewport.height);
                let tex_coord = compute_quad_tex_coord_cube_array(face, bottom_left, top_right, layer_range);
                let _ = face_desc(face);

                let bindings = [
                    glu::va::float("a_position", 2, 4, 0, positions.as_flattened()),
                    glu::va::float("a_texCoord", 4, 4, 0, &tex_coord),
                ];
                glu::draw(render_ctx, program_id, &bindings, &glu::pr::triangles(&quad_indices))
                    .map_err(|e| TestError::InternalError(e.to_string()))?;
                glu::expect_no_error(gl, "Draw")?;

                glu::read_pixels(render_ctx, viewport.x, viewport.y, &mut result.get_access())?;
                glu::expect_no_error(gl, "Read pixels")?;

                let scale = fmt_info.look_up_scale;
                let high = (
                    make_lookup_precision(pixel_format, is_nearest_only, scale, [10, 10, 10], [6, 6, 6]),
                    LodPrecision {
                        derivate_bits: 10,
                        lod_bits: 5,
                    },
                );
                let low = (
                    make_lookup_precision(pixel_format, is_nearest_only, scale, [10, 10, 10], [4, 4, 4]),
                    LodPrecision {
                        derivate_bits: 10,
                        lod_bits: 4,
                    },
                );

                let quality = if verify_texture_result_cube_array(
                    &result,
                    &level_accesses,
                    tex_coord,
                    &ref_params,
                    &high.0,
                    10,
                    &high.1,
                    pixel_format,
                )? {
                    Quality::High
                } else if verify_texture_result_cube_array(
                    &result,
                    &level_accesses,
                    tex_coord,
                    &ref_params,
                    &low.0,
                    10,
                    &low.1,
                    pixel_format,
                )? {
                    Quality::Low
                } else {
                    Quality::Fail
                };
                worst = worst.max(quality);
            }
        }

        match worst {
            Quality::Fail => Ok(TestStatus::fail("Image verification failed")),
            Quality::Low => Ok(TestStatus::new(
                TestResult::QualityWarning,
                "Low-quality filtering result",
            )),
            Quality::High => Ok(TestStatus::pass("Pass")),
        }
    }
}

/// `TextureFilteringTests::init`
pub fn create_tests() -> TestCaseGroup {
    const WRAP_MODES: [(&str, u32); 3] = [
        ("clamp", glw::GL_CLAMP_TO_EDGE),
        ("repeat", glw::GL_REPEAT),
        ("mirror", glw::GL_MIRRORED_REPEAT),
    ];
    const MIN_FILTER_MODES: [(&str, u32); 6] = [
        ("nearest", glw::GL_NEAREST),
        ("linear", glw::GL_LINEAR),
        ("nearest_mipmap_nearest", glw::GL_NEAREST_MIPMAP_NEAREST),
        ("linear_mipmap_nearest", glw::GL_LINEAR_MIPMAP_NEAREST),
        ("nearest_mipmap_linear", glw::GL_NEAREST_MIPMAP_LINEAR),
        ("linear_mipmap_linear", glw::GL_LINEAR_MIPMAP_LINEAR),
    ];
    const MAG_FILTER_MODES: [(&str, u32); 2] = [("nearest", glw::GL_NEAREST), ("linear", glw::GL_LINEAR)];
    const SIZES_CUBE_ARRAY: [(i32, i32); 5] = [(8, 6), (64, 12), (128, 12), (7, 12), (63, 18)];
    const FILTERABLE_FORMATS_BY_TYPE: [(&str, u32); 12] = [
        ("rgba16f", glw::GL_RGBA16F),
        ("r11f_g11f_b10f", glw::GL_R11F_G11F_B10F),
        ("rgb9_e5", glw::GL_RGB9_E5),
        ("rgba8", glw::GL_RGBA8),
        ("rgba8_snorm", glw::GL_RGBA8_SNORM),
        ("rgb565", glw::GL_RGB565),
        ("rgba4", glw::GL_RGBA4),
        ("rgb5_a1", glw::GL_RGB5_A1),
        ("sr8", glw::GL_SR8_EXT),
        ("srg8", glw::GL_SRG8_EXT),
        ("srgb8_alpha8", glw::GL_SRGB8_ALPHA8),
        ("rgb10_a2", glw::GL_RGB10_A2),
    ];

    let boxed = |case: TextureCubeArrayFilteringCase| Box::new(case) as Box<dyn TestCase>;
    let is_mipmap = |min_filter: u32| min_filter != glw::GL_NEAREST && min_filter != glw::GL_LINEAR;
    let mag_for = |min_filter: u32| {
        if is_mipmap(min_filter) {
            glw::GL_LINEAR
        } else {
            min_filter
        }
    };

    let mut group = TestCaseGroup::new("filtering");
    let mut group_cube_array = TestCaseGroup::new("cube_array");

    // Formats.
    {
        let mut formats_group = TestCaseGroup::new("formats");
        for &(format_name, format) in &FILTERABLE_FORMATS_BY_TYPE {
            for &(filter_name, min_filter) in &MIN_FILTER_MODES {
                formats_group.add_child(boxed(TextureCubeArrayFilteringCase {
                    name: format!("{format_name}_{filter_name}"),
                    min_filter,
                    mag_filter: mag_for(min_filter),
                    wrap_s: glw::GL_REPEAT,
                    wrap_t: glw::GL_REPEAT,
                    internal_format: format,
                    size: 64,
                    depth: 12,
                    only_sample_face_interior: false,
                }));
            }
        }
        group_cube_array.add_child(formats_group);
    }

    // Sizes.
    {
        let mut sizes_group = TestCaseGroup::new("sizes");
        for &(size, depth) in &SIZES_CUBE_ARRAY {
            for &(filter_name, min_filter) in &MIN_FILTER_MODES {
                sizes_group.add_child(boxed(TextureCubeArrayFilteringCase {
                    name: format!("{size}x{size}x{depth}_{filter_name}"),
                    min_filter,
                    mag_filter: mag_for(min_filter),
                    wrap_s: glw::GL_REPEAT,
                    wrap_t: glw::GL_REPEAT,
                    internal_format: glw::GL_RGBA8,
                    size,
                    depth,
                    only_sample_face_interior: false,
                }));
            }
        }
        group_cube_array.add_child(sizes_group);
    }

    // Wrap modes.
    {
        let mut combinations_group = TestCaseGroup::new("combinations");
        for &(min_name, min_filter) in &MIN_FILTER_MODES {
            for &(mag_name, mag_filter) in &MAG_FILTER_MODES {
                for &(wrap_s_name, wrap_s) in &WRAP_MODES {
                    for &(wrap_t_name, wrap_t) in &WRAP_MODES {
                        combinations_group.add_child(boxed(TextureCubeArrayFilteringCase {
                            name: format!("{min_name}_{mag_name}_{wrap_s_name}_{wrap_t_name}"),
                            min_filter,
                            mag_filter,
                            wrap_s,
                            wrap_t,
                            internal_format: glw::GL_RGBA8,
                            size: 63,
                            depth: 12,
                            only_sample_face_interior: false,
                        }));
                    }
                }
            }
        }
        group_cube_array.add_child(combinations_group);
    }

    // Cases with no visible cube edges.
    {
        let mut only_face_interior_group = TestCaseGroup::new("no_edges_visible");
        for is_linear in [false, true] {
            let filter = if is_linear { glw::GL_LINEAR } else { glw::GL_NEAREST };
            only_face_interior_group.add_child(boxed(TextureCubeArrayFilteringCase {
                name: if is_linear { "linear" } else { "nearest" }.to_string(),
                min_filter: filter,
                mag_filter: filter,
                wrap_s: glw::GL_REPEAT,
                wrap_t: glw::GL_REPEAT,
                internal_format: glw::GL_RGBA8,
                size: 63,
                depth: 12,
                only_sample_face_interior: true,
            }));
        }
        group_cube_array.add_child(only_face_interior_group);
    }

    group.add_child(group_cube_array);
    group
}
