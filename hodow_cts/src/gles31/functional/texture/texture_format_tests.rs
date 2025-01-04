// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fTextureFormatTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
// All three sub-groups are ported: `unsized` and `sized.cube_array`
// (`TextureCubeArrayFormatCase`) and `buffer` (`TextureBufferFormatCase`, 54 cases).
//
// Narrowing: `glu::TextureCubeArray` (absent from `glu`) is raw GL here: `glTexImage3D` on
// `GL_TEXTURE_CUBE_MAP_ARRAY` with the host reference level's bytes, rendered through a
// single-purpose `samplerCubeArray` quad program and compared against
// `tcu::pixel::TextureCubeArrayView` (nearest only, which is all this test samples with).
// Upstream's `CONTINUE` per layer-face is a loop in one body. A format whose host-side
// reference level cannot be written (`TextureLevel::new` refuses its channel type) is
// reported NotSupported with that reason rather than failed.
//
// Narrowing (buffer): `glu::TextureBuffer` and `glsTextureTestUtil::TextureRenderer` are replaced
// by raw GL plus a single-purpose `samplerBuffer` quad program. The quad's 1D coordinate
// runs 0..width across a viewport exactly `width` pixels wide, so pixel x fetches texel
// x; the reference is the texel's `getPixel` value times the format's lookup scale plus
// bias, stored through a `SurfaceAccess` for the render target's own pixel format.

use crate::glu::texture_test_util::{
    SamplerType, compute_quad_tex_coord_1d, get_fetch_sampler_type, get_sampler_type, triangle_interpolate,
};
use crate::glu::texture_test_util_surface::{
    compare_images, compute_quad_tex_coord_cube_region, fill_with_component_gradients_old,
};
use crate::glu::texture_util::{get_transfer_format, map_gl_internal_format, map_gl_transfer_format};
use crate::glu::{
    self, ApiCase, Buffer, Context, ProgramSources, ShaderProgram, ShaderType, TestCaseGroup, Texture, VertexArray,
    add_api_case,
};
use crate::glw::{self, GLenum};
use crate::tcu::pixel::{
    ConstPixelBufferAccess, CubeFace, FilterMode, Sampler, TextureCubeArrayView, TextureLevel, get_texture_format_info,
};
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::surface_access::SurfaceAccess;
use crate::tcu::{Random, Vec2, Vec4, de_string_hash};

// ---------------------------------------------------------------------------------------
// TextureCubeArrayFormatCase
// ---------------------------------------------------------------------------------------

/// `TextureCubeArrayFormatCase`'s size and depth - every registration passes `64, 12`.
const CUBE_ARRAY_SIZE: i32 = 64;
const CUBE_ARRAY_DEPTH: i32 = 12;

/// `getCubeFaceFromNdx`
pub(super) fn cube_face_from_ndx(ndx: i32) -> CubeFace {
    match ndx {
        0 => CubeFace::PositiveX,
        1 => CubeFace::NegativeX,
        2 => CubeFace::PositiveY,
        3 => CubeFace::NegativeY,
        4 => CubeFace::PositiveZ,
        _ => CubeFace::NegativeZ,
    }
}

/// The quad program `TextureRenderer::renderQuad` builds for `TEXTURETYPE_CUBE_ARRAY`.
pub(super) fn cube_array_quad_program<'gl>(context: &'gl Context, sampler_type: SamplerType) -> ShaderProgram<'gl> {
    let (prefix, conversion) = match sampler_type {
        SamplerType::Int => ("i", "vec4"),
        SamplerType::Uint => ("u", "vec4"),
        _ => ("", ""),
    };
    let version = context.context_type().glsl_version().declaration();
    let extension = if context.context_type().supports(3, 2) {
        ""
    } else {
        "#extension GL_EXT_texture_cube_map_array : require\n"
    };

    let vertex = format!(
        "{version}\n\
         in highp vec4 a_position;\n\
         in highp vec4 a_texCoord;\n\
         out highp vec4 v_texCoord;\n\
         void main (void)\n\
         {{\n\
         \x20   gl_Position = a_position;\n\
         \x20   v_texCoord = a_texCoord;\n\
         }}\n"
    );
    let fragment = format!(
        "{version}\n\
         {extension}\
         uniform highp {prefix}samplerCubeArray u_sampler;\n\
         uniform highp vec4 u_colorScale;\n\
         uniform highp vec4 u_colorBias;\n\
         in highp vec4 v_texCoord;\n\
         layout(location = 0) out mediump vec4 o_color;\n\
         void main (void)\n\
         {{\n\
         \x20   o_color = {conversion}(texture(u_sampler, v_texCoord)) * u_colorScale + u_colorBias;\n\
         }}\n"
    );

    let sources = ProgramSources::default()
        .with(ShaderType::Vertex, vertex)
        .with(ShaderType::Fragment, fragment);
    ShaderProgram::new(context.gl(), &sources)
}

/// `computeQuadTexCoordCubeArray(dst, face, bottomLeft, topRight, layerRange)` with an
/// equal layer range - a cube quad, each vertex's fourth component being the layer.
fn compute_quad_tex_coord_cube_array(face: CubeFace, bottom_left: Vec2, top_right: Vec2, layer: f32) -> [f32; 16] {
    let cube = compute_quad_tex_coord_cube_region(face, bottom_left, top_right);
    std::array::from_fn(|i| if i % 4 == 3 { layer } else { cube[(i / 4) * 3 + i % 4] })
}

/// `sampleTexture(SurfaceAccess, TextureCubeArrayView, texCoord, params)` for a nearest,
/// seamless sampler: the quad's two triangles interpolate the 4D coordinate per pixel.
pub(super) fn sample_cube_array_reference(
    dst: &mut SurfaceAccess<'_>,
    level0: ConstPixelBufferAccess<'_>,
    tex_coord: &[f32; 16],
    sampler: &Sampler,
    color_scale: [f32; 4],
    color_bias: [f32; 4],
) {
    let view = TextureCubeArrayView { level0 };
    let (dw, dh) = (dst.get_width(), dst.get_height());

    for py in 0..dh {
        for px in 0..dw {
            let nx = (px as f32 + 0.5) / dw as f32;
            let ny = (py as f32 + 0.5) / dh as f32;

            let tri_ndx = usize::from(nx + ny >= 1.0);
            let tri_nx = if tri_ndx == 1 { 1.0 - nx } else { nx };
            let tri_ny = if tri_ndx == 1 { 1.0 - ny } else { ny };

            let coord: [f32; 4] = std::array::from_fn(|c| {
                let v = |vertex: usize| tex_coord[vertex * 4 + c];
                if tri_ndx == 0 {
                    triangle_interpolate(v(0), v(1), v(2), tri_nx, tri_ny)
                } else {
                    triangle_interpolate(v(3), v(2), v(1), tri_nx, tri_ny)
                }
            });

            let sample = view.sample(sampler, coord[0], coord[1], coord[2], coord[3]);
            let color: [f32; 4] = std::array::from_fn(|c| sample[c] * color_scale[c] + color_bias[c]);
            dst.set_pixel(Vec4::from_array(color), px, py);
        }
    }
}

/// `TextureCubeArrayFormatCase::init` + `iterate`. `data_type` is `Some` for the unsized
/// (implicit internal format) registrations.
fn cube_array_format_case(case: &mut ApiCase<'_>, name: &str, format: GLenum, data_type: Option<GLenum>) {
    let context = case.context();
    let gl = case.gl();

    // `checkSupport`
    let cube_map_array = context
        .context_info
        .is_extension_supported("GL_EXT_texture_cube_map_array")
        || context
            .context_info
            .is_extension_supported("GL_ARB_texture_cube_map_array");
    let srgb_r8 = context.context_info.is_extension_supported("GL_EXT_texture_sRGB_R8");
    let srgb_rg8 = context.context_info.is_extension_supported("GL_EXT_texture_sRGB_RG8");
    if !cube_map_array {
        case.not_supported("Cube map arrays not supported");
        return;
    }
    if format == glw::GL_SR8_EXT && !srgb_r8 {
        case.not_supported("texture srgb r8 not supported");
        return;
    }
    if format == glw::GL_SRG8_EXT && !srgb_rg8 {
        case.not_supported("texture srgb rg8 not supported");
        return;
    }

    let tex_format = match data_type {
        Some(data_type) => map_gl_transfer_format(format, data_type),
        None => map_gl_internal_format(format),
    };
    let Some(tex_format) = tex_format else {
        case.fail(format!("unmapped format 0x{format:04X}"), "unmapped format");
        return;
    };
    let transfer = match data_type {
        Some(data_type) => crate::glu::texture_util::TransferFormat { format, data_type },
        None => match get_transfer_format(tex_format) {
            Ok(transfer) => transfer,
            Err(e) => {
                case.not_supported(format!("no GL transfer format for the reference level: {e}"));
                return;
            }
        },
    };

    let spec = get_texture_format_info(tex_format);
    let mut level = match TextureLevel::new(
        tex_format,
        CUBE_ARRAY_SIZE as u32,
        CUBE_ARRAY_SIZE as u32,
        CUBE_ARRAY_DEPTH as u32,
    ) {
        Ok(level) => level,
        Err(e) => {
            case.not_supported(format!("host-side reference level cannot be written: {e}"));
            return;
        }
    };

    // Fill level 0.
    fill_with_component_gradients_old(&mut level.get_access(), spec.value_min, spec.value_max);

    let render_target = context.render_target();
    if render_target.width < CUBE_ARRAY_SIZE || render_target.height < CUBE_ARRAY_SIZE {
        case.not_supported(format!(
            "Render target must be at least {CUBE_ARRAY_SIZE}x{CUBE_ARRAY_SIZE}"
        ));
        return;
    }

    // `RandomViewport(renderTarget, size, size, deStringHash(getName()))`
    let mut rnd = Random::new(de_string_hash(name));
    let vp_x = rnd.get_int(0, render_target.width - CUBE_ARRAY_SIZE);
    let vp_y = rnd.get_int(0, render_target.height - CUBE_ARRAY_SIZE);

    let sampler_type = get_sampler_type(tex_format);
    let program = cube_array_quad_program(context, sampler_type);
    if !program.is_ok() {
        case.fail("Program compilation failed".to_string(), "Program compilation failed");
        return;
    }
    let program_id = program.program();

    // Upload texture data to GL, nearest neighbour filtering and clamp-to-edge.
    let texture = Texture::new(gl);
    let vao = VertexArray::new(gl);
    // SAFETY: names this case owns; the level's bytes outlive the upload.
    unsafe {
        gl.active_texture(glw::GL_TEXTURE0);
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, texture.get());
        gl.tex_image_3d(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            0,
            format as i32,
            CUBE_ARRAY_SIZE,
            CUBE_ARRAY_SIZE,
            CUBE_ARRAY_DEPTH,
            0,
            transfer.format,
            transfer.data_type,
            level.data().as_ptr().cast(),
        );
        gl.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            glw::GL_TEXTURE_WRAP_S,
            glw::GL_CLAMP_TO_EDGE as i32,
        );
        gl.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            glw::GL_TEXTURE_WRAP_T,
            glw::GL_CLAMP_TO_EDGE as i32,
        );
        gl.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST as i32,
        );
        gl.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            glw::GL_TEXTURE_MAG_FILTER,
            glw::GL_NEAREST as i32,
        );
        gl.bind_vertex_array(vao.get());
    }
    case.expect_no_error("Set texturing state");

    let mut sampler = Sampler::clamp_to_edge(FilterMode::Nearest);
    sampler.seamless_cube_map = true;
    sampler.normalized_coords = true;

    let base = render_target.pixel_format().get_color_threshold();
    let threshold = RGBA::new(
        base.get_red() + 1,
        base.get_green() + 1,
        base.get_blue() + 1,
        base.get_alpha() + 1,
    );
    let positions: [[f32; 2]; 4] = [[-1.0, -1.0], [-1.0, 1.0], [1.0, -1.0], [1.0, 1.0]];
    let quad_indices: [u16; 6] = [0, 1, 2, 2, 1, 3];

    for layer_face_ndx in 0..CUBE_ARRAY_DEPTH {
        let layer_ndx = layer_face_ndx / 6;
        let face = cube_face_from_ndx(layer_face_ndx % 6);

        // Layer here specifies the cube slice
        let tex_coord =
            compute_quad_tex_coord_cube_array(face, Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0), layer_ndx as f32);

        // Setup base viewport.
        // SAFETY: plain state setters and uniform writes on the program that linked.
        unsafe {
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
            gl.viewport(vp_x, vp_y, CUBE_ARRAY_SIZE, CUBE_ARRAY_SIZE);
            gl.use_program(program_id);
            gl.uniform_1i(gl.get_uniform_location(program_id, c"u_sampler".as_ptr()), 0);
            gl.uniform_4f(
                gl.get_uniform_location(program_id, c"u_colorScale".as_ptr()),
                spec.look_up_scale[0],
                spec.look_up_scale[1],
                spec.look_up_scale[2],
                spec.look_up_scale[3],
            );
            gl.uniform_4f(
                gl.get_uniform_location(program_id, c"u_colorBias".as_ptr()),
                spec.look_up_bias[0],
                spec.look_up_bias[1],
                spec.look_up_bias[2],
                spec.look_up_bias[3],
            );
        }

        // Draw.
        let bindings = [
            glu::va::float("a_position", 2, 4, 0, positions.as_flattened()),
            glu::va::float("a_texCoord", 4, 4, 0, &tex_coord),
        ];
        if let Err(e) = glu::draw(
            &context.render_context,
            program_id,
            &bindings,
            &glu::pr::triangles(&quad_indices),
        ) {
            case.fail(e.to_string(), "Draw failed");
            return;
        }

        let mut rendered_frame = Surface::new(CUBE_ARRAY_SIZE, CUBE_ARRAY_SIZE);
        if let Err(e) = glu::read_pixels(&context.render_context, vp_x, vp_y, &mut rendered_frame.get_access()) {
            case.fail(e.to_string(), "glReadPixels() failed");
            return;
        }

        // Compute reference.
        let mut reference_frame = Surface::new(CUBE_ARRAY_SIZE, CUBE_ARRAY_SIZE);
        {
            let mut reference_access = SurfaceAccess::new(&mut reference_frame, render_target.pixel_format());
            sample_cube_array_reference(
                &mut reference_access,
                level.get_const_access().into_effective_depth(),
                &tex_coord,
                &sampler,
                spec.look_up_scale,
                spec.look_up_bias,
            );
        }

        // Compare and log.
        let result = compare_images(&reference_frame, &rendered_frame, threshold);
        if !result.ok {
            case.fail(
                format!(
                    "Layer-face {layer_face_ndx}: image comparison failed, max diff {:?}",
                    result.max_diff
                ),
                "Image comparison failed",
            );
        }
    }

    case.expect_no_error("cube array format case");
}

/// `unsized` sub-group - `texFormats`, each registered `_cube_array_pot` and `_cube_array_npot`.
fn unsized_group() -> TestCaseGroup {
    const TEX_FORMATS: [(&str, GLenum, GLenum); 8] = [
        ("alpha", glw::GL_ALPHA, glw::GL_UNSIGNED_BYTE),
        ("luminance", glw::GL_LUMINANCE, glw::GL_UNSIGNED_BYTE),
        ("luminance_alpha", glw::GL_LUMINANCE_ALPHA, glw::GL_UNSIGNED_BYTE),
        ("rgb_unsigned_short_5_6_5", glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_6_5),
        ("rgb_unsigned_byte", glw::GL_RGB, glw::GL_UNSIGNED_BYTE),
        (
            "rgba_unsigned_short_4_4_4_4",
            glw::GL_RGBA,
            glw::GL_UNSIGNED_SHORT_4_4_4_4,
        ),
        (
            "rgba_unsigned_short_5_5_5_1",
            glw::GL_RGBA,
            glw::GL_UNSIGNED_SHORT_5_5_5_1,
        ),
        ("rgba_unsigned_byte", glw::GL_RGBA, glw::GL_UNSIGNED_BYTE),
    ];

    let mut group = TestCaseGroup::new("unsized");
    for (name_base, format, data_type) in TEX_FORMATS {
        for suffix in ["pot", "npot"] {
            let case_name = format!("{name_base}_cube_array_{suffix}");
            let seed_name = case_name.clone();
            add_api_case(&mut group, case_name, move |case: &mut ApiCase<'_>| {
                cube_array_format_case(case, &seed_name, format, Some(data_type))
            });
        }
    }
    group
}

/// `sized.cube_array` sub-group - `sizedColorFormats` then `sizedDepthStencilFormats`.
fn sized_cube_array_group() -> TestCaseGroup {
    const SIZED_FORMATS: &[(&str, GLenum)] = &[
        ("rgba32f", glw::GL_RGBA32F),
        ("rgba32i", glw::GL_RGBA32I),
        ("rgba32ui", glw::GL_RGBA32UI),
        ("rgba16f", glw::GL_RGBA16F),
        ("rgba16i", glw::GL_RGBA16I),
        ("rgba16ui", glw::GL_RGBA16UI),
        ("rgba8", glw::GL_RGBA8),
        ("rgba8i", glw::GL_RGBA8I),
        ("rgba8ui", glw::GL_RGBA8UI),
        ("srgb_r8", glw::GL_SR8_EXT),
        ("srgb_rg8", glw::GL_SRG8_EXT),
        ("srgb8_alpha8", glw::GL_SRGB8_ALPHA8),
        ("rgb10_a2", glw::GL_RGB10_A2),
        ("rgb10_a2ui", glw::GL_RGB10_A2UI),
        ("rgba4", glw::GL_RGBA4),
        ("rgb5_a1", glw::GL_RGB5_A1),
        ("rgba8_snorm", glw::GL_RGBA8_SNORM),
        ("rgb8", glw::GL_RGB8),
        ("rgb565", glw::GL_RGB565),
        ("r11f_g11f_b10f", glw::GL_R11F_G11F_B10F),
        ("rgb32f", glw::GL_RGB32F),
        ("rgb32i", glw::GL_RGB32I),
        ("rgb32ui", glw::GL_RGB32UI),
        ("rgb16f", glw::GL_RGB16F),
        ("rgb16i", glw::GL_RGB16I),
        ("rgb16ui", glw::GL_RGB16UI),
        ("rgb8_snorm", glw::GL_RGB8_SNORM),
        ("rgb8i", glw::GL_RGB8I),
        ("rgb8ui", glw::GL_RGB8UI),
        ("srgb8", glw::GL_SRGB8),
        ("rgb9_e5", glw::GL_RGB9_E5),
        ("rg32f", glw::GL_RG32F),
        ("rg32i", glw::GL_RG32I),
        ("rg32ui", glw::GL_RG32UI),
        ("rg16f", glw::GL_RG16F),
        ("rg16i", glw::GL_RG16I),
        ("rg16ui", glw::GL_RG16UI),
        ("rg8", glw::GL_RG8),
        ("rg8i", glw::GL_RG8I),
        ("rg8ui", glw::GL_RG8UI),
        ("rg8_snorm", glw::GL_RG8_SNORM),
        ("r32f", glw::GL_R32F),
        ("r32i", glw::GL_R32I),
        ("r32ui", glw::GL_R32UI),
        ("r16f", glw::GL_R16F),
        ("r16i", glw::GL_R16I),
        ("r16ui", glw::GL_R16UI),
        ("r8", glw::GL_R8),
        ("r8i", glw::GL_R8I),
        ("r8ui", glw::GL_R8UI),
        ("r8_snorm", glw::GL_R8_SNORM),
    ];
    const SIZED_DEPTH_STENCIL_FORMATS: &[(&str, GLenum)] = &[
        ("depth_component32f", glw::GL_DEPTH_COMPONENT32F),
        ("depth_component24", glw::GL_DEPTH_COMPONENT24),
        ("depth_component16", glw::GL_DEPTH_COMPONENT16),
        ("depth32f_stencil8", glw::GL_DEPTH32F_STENCIL8),
        ("depth24_stencil8", glw::GL_DEPTH24_STENCIL8),
    ];

    let mut group = TestCaseGroup::new("cube_array");
    for &(name_base, internal_format) in SIZED_FORMATS.iter().chain(SIZED_DEPTH_STENCIL_FORMATS.iter()) {
        for suffix in ["pot", "npot"] {
            let case_name = format!("{name_base}_{suffix}");
            let seed_name = case_name.clone();
            add_api_case(&mut group, case_name, move |case: &mut ApiCase<'_>| {
                cube_array_format_case(case, &seed_name, internal_format, None)
            });
        }
    }
    group
}

// ---------------------------------------------------------------------------------------
// TextureBufferFormatCase
// ---------------------------------------------------------------------------------------

/// `bufferColorFormats`
const BUFFER_COLOR_FORMATS: [(&str, GLenum); 27] = [
    ("r8", glw::GL_R8),
    ("r16f", glw::GL_R16F),
    ("r32f", glw::GL_R32F),
    ("r8i", glw::GL_R8I),
    ("r16i", glw::GL_R16I),
    ("r32i", glw::GL_R32I),
    ("r8ui", glw::GL_R8UI),
    ("r16ui", glw::GL_R16UI),
    ("r32ui", glw::GL_R32UI),
    ("rg8", glw::GL_RG8),
    ("rg16f", glw::GL_RG16F),
    ("rg32f", glw::GL_RG32F),
    ("rg8i", glw::GL_RG8I),
    ("rg16i", glw::GL_RG16I),
    ("rg32i", glw::GL_RG32I),
    ("rg8ui", glw::GL_RG8UI),
    ("rg16ui", glw::GL_RG16UI),
    ("rg32ui", glw::GL_RG32UI),
    ("rgba8", glw::GL_RGBA8),
    ("rgba16f", glw::GL_RGBA16F),
    ("rgba32f", glw::GL_RGBA32F),
    ("rgba8i", glw::GL_RGBA8I),
    ("rgba16i", glw::GL_RGBA16I),
    ("rgba32i", glw::GL_RGBA32I),
    ("rgba8ui", glw::GL_RGBA8UI),
    ("rgba16ui", glw::GL_RGBA16UI),
    ("rgba32ui", glw::GL_RGBA32UI),
];

/// The quad program `TextureRenderer::renderQuad` builds for `TEXTURETYPE_BUFFER`.
fn buffer_quad_program<'gl>(context: &'gl Context, sampler_type: SamplerType) -> ShaderProgram<'gl> {
    let (prefix, conversion) = match sampler_type {
        SamplerType::FetchInt => ("i", "vec4"),
        SamplerType::FetchUint => ("u", "vec4"),
        _ => ("", ""),
    };
    let version = context.context_type().glsl_version().declaration();
    let extension = if context.context_type().supports(3, 2) {
        ""
    } else {
        "#extension GL_EXT_texture_buffer : require\n"
    };

    let vertex = format!(
        "{version}\n\
         in highp vec4 a_position;\n\
         in highp float a_texCoord;\n\
         out highp float v_texCoord;\n\
         void main (void)\n\
         {{\n\
         \x20   gl_Position = a_position;\n\
         \x20   v_texCoord = a_texCoord;\n\
         }}\n"
    );
    let fragment = format!(
        "{version}\n\
         {extension}\
         uniform highp {prefix}samplerBuffer u_sampler;\n\
         uniform highp vec4 u_colorScale;\n\
         uniform highp vec4 u_colorBias;\n\
         in highp float v_texCoord;\n\
         layout(location = 0) out mediump vec4 o_color;\n\
         void main (void)\n\
         {{\n\
         \x20   o_color = {conversion}(texelFetch(u_sampler, int(floor(v_texCoord)))) * u_colorScale + u_colorBias;\n\
         }}\n"
    );

    let sources = ProgramSources::default()
        .with(ShaderType::Vertex, vertex)
        .with(ShaderType::Fragment, fragment);
    ShaderProgram::new(context.gl(), &sources)
}

/// `TextureBufferFormatCase::init` + `iterate`
fn texture_buffer_format_case(case: &mut ApiCase<'_>, name: &str, internal_format: GLenum, width: i32) {
    let context = case.context();
    let gl = case.gl();

    let Some(fmt) = map_gl_internal_format(internal_format) else {
        case.fail(
            format!("unmapped internal format 0x{internal_format:04X}"),
            "unmapped format",
        );
        return;
    };
    let spec = get_texture_format_info(fmt);
    let color_a = [
        spec.value_min[0],
        spec.value_max[1],
        spec.value_min[2],
        spec.value_max[3],
    ];
    let color_b = [
        spec.value_max[0],
        spec.value_min[1],
        spec.value_max[2],
        spec.value_min[3],
    ];

    if !context.context_type().supports(3, 2)
        && !context.context_info.is_extension_supported("GL_OES_texture_buffer")
        && !context.context_info.is_extension_supported("GL_EXT_texture_buffer")
        && !context
            .context_info
            .is_extension_supported("GL_ARB_texture_buffer_object")
    {
        case.not_supported("Texture buffers not supported");
        return;
    }

    let mut max_texture_buffer_size = 0;
    // SAFETY: one GLint out.
    unsafe { gl.get_integerv(glw::GL_MAX_TEXTURE_BUFFER_SIZE, &mut max_texture_buffer_size) };
    if max_texture_buffer_size <= 0 {
        case.not_supported("GL_MAX_TEXTURE_BUFFER_SIZE > 0 required");
        return;
    }

    // `glu::TextureBuffer(renderCtx, format, width * pixelSize)`: the reference texture is
    // `width` texels, clamped to the implementation limit by `getTextureBufferEffectiveRefTexture`.
    let effective_width = width.min(max_texture_buffer_size);
    let mut texture_level = match TextureLevel::new(fmt, effective_width as u32, 1, 1) {
        Ok(level) => level,
        Err(e) => {
            case.fail(e.to_string(), "could not build the reference texture");
            return;
        }
    };
    fill_with_component_gradients_old(&mut texture_level.get_access(), color_a, color_b);

    let render_target = context.render_target();
    if render_target.width < width {
        case.not_supported(format!("Render target width must be at least {width}"));
        return;
    }

    // `RandomViewport(renderTarget, width, 1, deStringHash(getName()))`
    let mut rnd = Random::new(de_string_hash(name));
    let vp_x = rnd.get_int(0, render_target.width - width);
    let vp_y = rnd.get_int(0, render_target.height - 1);

    let sampler_type = get_fetch_sampler_type(fmt);
    let program = buffer_quad_program(context, sampler_type);
    if !program.is_ok() {
        case.fail("Program compilation failed".to_string(), "Program compilation failed");
        return;
    }
    let program_id = program.program();

    let tex_coord = compute_quad_tex_coord_1d(0.0, effective_width as f32);
    let positions: [[f32; 2]; 4] = [[-1.0, -1.0], [-1.0, 1.0], [1.0, -1.0], [1.0, 1.0]];
    let quad_indices: [u16; 6] = [0, 1, 2, 2, 1, 3];

    // SAFETY: plain state setters.
    unsafe {
        gl.clear_color(0.125, 0.25, 0.5, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
        gl.viewport(vp_x, vp_y, width, 1);
    }

    // Upload texture data to GL.
    let data_buffer = Buffer::new(gl);
    let texture = Texture::new(gl);
    let vao = VertexArray::new(gl);
    // SAFETY: names this case owns; the texel bytes outlive the upload.
    unsafe {
        gl.bind_buffer(glw::GL_TEXTURE_BUFFER, data_buffer.get());
        gl.buffer_data(
            glw::GL_TEXTURE_BUFFER,
            texture_level.data().len() as isize,
            texture_level.data().as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );

        // Bind to unit 0.
        gl.active_texture(glw::GL_TEXTURE0);
        gl.bind_texture(glw::GL_TEXTURE_BUFFER, texture.get());
        gl.tex_buffer(glw::GL_TEXTURE_BUFFER, internal_format, data_buffer.get());
        gl.bind_vertex_array(vao.get());
    }
    case.expect_no_error("Set texturing state");

    // Draw.
    let bindings = [
        glu::va::float("a_position", 2, 4, 0, positions.as_flattened()),
        glu::va::float("a_texCoord", 1, 4, 0, &tex_coord),
    ];
    // SAFETY: a location of the program that linked.
    unsafe {
        gl.use_program(program_id);
        gl.uniform_1i(gl.get_uniform_location(program_id, c"u_sampler".as_ptr()), 0);
        gl.uniform_4f(
            gl.get_uniform_location(program_id, c"u_colorScale".as_ptr()),
            spec.look_up_scale[0],
            spec.look_up_scale[1],
            spec.look_up_scale[2],
            spec.look_up_scale[3],
        );
        gl.uniform_4f(
            gl.get_uniform_location(program_id, c"u_colorBias".as_ptr()),
            spec.look_up_bias[0],
            spec.look_up_bias[1],
            spec.look_up_bias[2],
            spec.look_up_bias[3],
        );
    }
    if let Err(e) = glu::draw(
        &context.render_context,
        program_id,
        &bindings,
        &glu::pr::triangles(&quad_indices),
    ) {
        case.fail(e.to_string(), "Draw failed");
        return;
    }

    let mut rendered_frame = Surface::new(width, 1);
    if let Err(e) = glu::read_pixels(&context.render_context, vp_x, vp_y, &mut rendered_frame.get_access()) {
        case.fail(e.to_string(), "glReadPixels() failed");
        return;
    }
    case.expect_no_error("glReadPixels()");

    // Compute reference.
    let pixel_format = render_target.pixel_format();
    let mut reference_frame = Surface::new(width, 1);
    {
        let mut reference_access = SurfaceAccess::new(&mut reference_frame, pixel_format);
        let texels = texture_level.get_const_access();
        for x in 0..width {
            let texel = texels.get_pixel(x as u32, 0, 0);
            let color: [f32; 4] = std::array::from_fn(|c| texel[c] * spec.look_up_scale[c] + spec.look_up_bias[c]);
            reference_access.set_pixel(Vec4::from_array(color), x, 0);
        }
    }

    // Compare and log.
    let base = pixel_format.get_color_threshold();
    let threshold = RGBA::new(
        base.get_red() + 1,
        base.get_green() + 1,
        base.get_blue() + 1,
        base.get_alpha() + 1,
    );
    let result = compare_images(&reference_frame, &rendered_frame, threshold);
    if !result.ok {
        case.fail(
            format!("Image comparison failed, max diff {:?}", result.max_diff),
            "Image comparison failed",
        );
    }
}

fn buffer_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("buffer");

    for (name_base, internal_format) in BUFFER_COLOR_FORMATS {
        for (suffix, width) in [("pot", 64), ("npot", 112)] {
            let case_name = format!("{name_base}_{suffix}");
            let seed_name = case_name.clone();
            add_api_case(&mut group, case_name, move |case: &mut ApiCase<'_>| {
                texture_buffer_format_case(case, &seed_name, internal_format, width)
            });
        }
    }

    group
}

/// `TextureFormatTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("format");
    group.add_child(unsized_group());
    let mut sized = TestCaseGroup::new("sized");
    sized.add_child(sized_cube_array_group());
    group.add_child(sized);
    group.add_child(buffer_group());
    group
}
