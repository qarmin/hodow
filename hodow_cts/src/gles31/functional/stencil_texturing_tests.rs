// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fStencilTexturingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
// Upstream's image-set log entries (result/reference stencil buffers) are not written, the
// comparison prints its per-pixel messages only. Upstream's `glu::texSubImage2D/3D` is the
// local `tex_sub_image_2d`/`tex_sub_image_3d` here (tight pitch, transfer format taken from the level).

use crate::glu::texture_test_util::{LodMode, TextureType};
use crate::glu::texture_test_util_surface::{
    compute_fixed_point_threshold, compute_quad_tex_coord_cube_region, make_reference_params,
    verify_texture_result_cube,
};
use crate::glu::texture_util::{get_transfer_format, map_gl_internal_format};
use crate::glu::{self, Context, Framebuffer, Renderbuffer, TestCase, TestCaseGroup, Texture, pr, va};
use crate::glw::{self, GLenum};
use crate::tcu::pixel::{
    ConstPixelBufferAccess, CubeFace, DepthStencilMode, PixelBufferAccess, TextureLevel, clear_depth, clear_stencil,
    get_effective_depth_stencil_access, get_texture_format_bit_depth,
};
use crate::tcu::pixel_format::PixelFormat;
use crate::tcu::random::de_int32_hash;
use crate::tcu::surface::Surface;
use crate::tcu::tex_verifier::{LodPrecision, LookupPrecision};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::texture_cube::TextureCube;
use crate::tcu::vector::Vec2;
use crate::tcu::{TestError, TestOutcome, TestStatus};

type Rect = [i32; 4];

/// `genTestRects`
fn gen_test_rects(width: i32, height: i32) -> Vec<Rect> {
    let mut rects = Vec::new();
    let mut cur_width = width;
    let mut cur_height = height;
    let mut ndx = 0;

    loop {
        rects.push([width - cur_width, height - cur_height, cur_width, cur_height]);

        debug_assert!(cur_width >= 1 && cur_height >= 1);
        if cur_width == 1 && cur_height == 1 {
            break;
        } else if cur_height > 1 && (ndx % 2 == 0 || cur_width == 1) {
            cur_height -= 1;
        } else {
            cur_width -= 1;
        }

        ndx += 1;
    }
    rects
}

/// `rectsToTriangles` - positions are flattened (x, y) pairs.
fn rects_to_triangles(rects: &[Rect], width: i32, height: i32) -> (Vec<f32>, Vec<u16>) {
    let w = width as f32;
    let h = height as f32;
    let mut positions = Vec::with_capacity(rects.len() * 8);
    let mut indices = Vec::with_capacity(rects.len() * 6);

    for (rect_ndx, rect) in rects.iter().enumerate() {
        let [rx, ry, rw, rh] = *rect;

        let x0 = (rx * 2) as f32 / w - 1.0;
        let x1 = ((rx + rw) * 2) as f32 / w - 1.0;
        let y0 = (ry * 2) as f32 / h - 1.0;
        let y1 = ((ry + rh) * 2) as f32 / h - 1.0;

        positions.extend_from_slice(&[x0, y0, x1, y0, x0, y1, x1, y1]);

        let base = (rect_ndx * 4) as u16;
        indices.extend_from_slice(&[base, base + 1, base + 2, base + 2, base + 1, base + 3]);
    }
    (positions, indices)
}

/// `drawTestPattern`
fn draw_test_pattern(context: &Context, width: i32, height: i32) -> Result<(), TestError> {
    let gl = context.gl();
    let program = glu::ShaderProgram::new(
        gl,
        &glu::ProgramSources::default()
            .with(
                glu::ShaderType::Vertex,
                "#version 300 es\n\
                 in highp vec4 a_position;\n\
                 void main (void)\n\
                 {\n\
                 \tgl_Position = a_position;\n\
                 }\n",
            )
            .with(glu::ShaderType::Fragment, "#version 300 es\nvoid main (void) {}\n"),
    );
    if !program.is_ok() {
        return Err(TestError::Fail("Compile failed".to_string()));
    }

    // SAFETY: plain state setting on the current context.
    unsafe {
        gl.use_program(program.program());
        gl.viewport(0, 0, width, height);
        gl.clear(glw::GL_STENCIL_BUFFER_BIT);
        gl.enable(glw::GL_STENCIL_TEST);
        gl.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_INCR_WRAP);
        gl.stencil_func(glw::GL_ALWAYS, 0, !0u32);
    }
    glu::expect_no_error(gl, "State setup failed")?;

    let rects = gen_test_rects(width, height);
    let (positions, indices) = rects_to_triangles(&rects, width, height);

    let pos_binding = va::float("a_position", 2, (positions.len() / 2) as i32, 0, &positions);
    glu::draw(
        &context.render_context,
        program.program(),
        &[pos_binding],
        &pr::triangles(&indices),
    )?;

    // SAFETY: as above.
    unsafe { gl.disable(glw::GL_STENCIL_TEST) };
    Ok(())
}

/// `renderTestPatternReference`
fn render_test_pattern_reference(dst: &mut PixelBufferAccess<'_>) {
    let stencil_bits = {
        let as_const = dst.as_const();
        get_texture_format_bit_depth(get_effective_depth_stencil_access(&as_const, DepthStencilMode::Stencil).format())
            [0]
    };
    let stencil_mask = (1u32 << stencil_bits) - 1;

    debug_assert!(dst.format().order == ChannelOrder::S || dst.format().order == ChannelOrder::DS);

    // clear depth and stencil
    if dst.format().order == ChannelOrder::DS {
        clear_depth(dst, 0.0);
    }
    clear_stencil(dst, 0);

    let [width, height, _] = dst.size();
    let rects = gen_test_rects(width as i32, height as i32);

    for rect in &rects {
        let x0 = rect[0] as u32;
        let y0 = rect[1] as u32;
        let x1 = x0 + rect[2] as u32;
        let y1 = y0 + rect[3] as u32;

        for y in y0..y1 {
            for x in x0..x1 {
                let old_val = dst.get_pix_stencil(x, y, 0);
                let new_val = (old_val + 1) & stencil_mask;

                dst.set_pix_stencil(new_val, x, y, 0);
            }
        }
    }
}

/// The program/state setup the three `blitStencilToColor*` functions share: bind `src_tex` on
/// unit 0 as `target` with nearest filtering and the stencil texture mode, draw one quad.
#[allow(clippy::too_many_arguments)]
fn blit_stencil_to_color(
    context: &Context,
    target: GLenum,
    src_tex: u32,
    sampler_type: &str,
    tex_coord_type: &str,
    frag_body: &str,
    positions: &[f32; 8],
    tex_coord: &[f32],
    tex_coord_components: i32,
    width: i32,
    height: i32,
) -> Result<(), TestError> {
    let gl = context.gl();
    let program = glu::ShaderProgram::new(
        gl,
        &glu::ProgramSources::default()
            .with(
                glu::ShaderType::Vertex,
                format!(
                    "#version 300 es\n\
                     in highp vec4 a_position;\n\
                     in highp {tex_coord_type} a_texCoord;\n\
                     out highp {tex_coord_type} v_texCoord;\n\
                     void main (void)\n\
                     {{\n\
                     \tgl_Position = a_position;\n\
                     \tv_texCoord = a_texCoord;\n\
                     }}\n"
                ),
            )
            .with(
                glu::ShaderType::Fragment,
                format!(
                    "#version 300 es\n\
                     uniform highp {sampler_type} u_sampler;\n\
                     in highp {tex_coord_type} v_texCoord;\n\
                     {frag_body}"
                ),
            ),
    );

    if !program.is_ok() {
        return Err(TestError::Fail("Compile failed".to_string()));
    }

    // SAFETY: plain state setting on the current context.
    unsafe {
        gl.active_texture(glw::GL_TEXTURE0);
        gl.bind_texture(target, src_tex);
        gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
        gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
        gl.tex_parameteri(target, glw::GL_DEPTH_STENCIL_TEXTURE_MODE, glw::GL_STENCIL_INDEX as i32);
    }
    glu::expect_no_error(gl, "Texture state setup failed")?;

    // SAFETY: a NUL-terminated name against the program just built.
    unsafe {
        gl.use_program(program.program());
        gl.uniform_1i(gl.get_uniform_location(program.program(), c"u_sampler".as_ptr()), 0);
    }
    glu::expect_no_error(gl, "Program setup failed")?;

    // SAFETY: as above.
    unsafe { gl.viewport(0, 0, width, height) };
    let vertex_arrays = [
        va::float("a_position", 2, 4, 0, positions),
        va::float("a_texCoord", tex_coord_components, 4, 0, tex_coord),
    ];
    let indices: [u16; 6] = [0, 1, 2, 2, 1, 3];
    glu::draw(
        &context.render_context,
        program.program(),
        &vertex_arrays,
        &pr::triangles(&indices),
    )
}

/// `blitStencilToColor2D`
fn blit_stencil_to_color_2d(context: &Context, src_tex: u32, width: i32, height: i32) -> Result<(), TestError> {
    let positions = [-1.0f32, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0];
    let tex_coord = [0.0f32, 0.0, 1.0, 0.0, 0.0, 1.0, 1.0, 1.0];
    blit_stencil_to_color(
        context,
        glw::GL_TEXTURE_2D,
        src_tex,
        "usampler2D",
        "vec2",
        "layout(location = 0) out highp uint o_stencil;\n\
         void main (void)\n\
         {\n\
         \to_stencil = texture(u_sampler, v_texCoord).x;\n\
         }\n",
        &positions,
        &tex_coord,
        2,
        width,
        height,
    )
}

/// `blitStencilToColor2DArray`
fn blit_stencil_to_color_2d_array(
    context: &Context,
    src_tex: u32,
    width: i32,
    height: i32,
    level: i32,
) -> Result<(), TestError> {
    let positions = [-1.0f32, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0];
    let l = level as f32;
    let tex_coord = [0.0f32, 0.0, l, 1.0, 0.0, l, 0.0, 1.0, l, 1.0, 1.0, l];
    blit_stencil_to_color(
        context,
        glw::GL_TEXTURE_2D_ARRAY,
        src_tex,
        "usampler2DArray",
        "vec3",
        "layout(location = 0) out highp uint o_stencil;\n\
         void main (void)\n\
         {\n\
         \to_stencil = texture(u_sampler, v_texCoord).x;\n\
         }\n",
        &positions,
        &tex_coord,
        3,
        width,
        height,
    )
}

/// `blitStencilToColorCube`
fn blit_stencil_to_color_cube(
    context: &Context,
    src_tex: u32,
    tex_coord: &[f32; 12],
    width: i32,
    height: i32,
) -> Result<(), TestError> {
    let positions = [-1.0f32, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0];
    blit_stencil_to_color(
        context,
        glw::GL_TEXTURE_CUBE_MAP,
        src_tex,
        "usamplerCube",
        "vec3",
        "layout(location = 0) out highp vec4 o_color;\n\
         void main (void)\n\
         {\n\
         \to_color.x = float(texture(u_sampler, v_texCoord).x) / 255.0;\n\
         \to_color.yzw = vec3(0.0, 0.0, 1.0);\n\
         }\n",
        &positions,
        tex_coord,
        3,
        width,
        height,
    )
}

/// `compareStencilToRed`
fn compare_stencil_to_red(stencil_ref: &ConstPixelBufferAccess<'_>, result: &ConstPixelBufferAccess<'_>) -> bool {
    const MAX_PRINTS: i32 = 10;
    let mut num_failed = 0;
    let [width, height, _] = stencil_ref.size();

    debug_assert!(stencil_ref.format().order == ChannelOrder::S);
    debug_assert!(result.size()[0] == width && result.size()[1] == height);

    for y in 0..height {
        for x in 0..width {
            let ref_val = stencil_ref.get_pix_stencil(x, y, 0) as i32;
            let res = result.get_pixel_int(x, y, 0)[0];

            if ref_val != res {
                if num_failed < MAX_PRINTS {
                    log::warn!("ERROR: Expected {ref_val}, got {res} at ({x}, {y})");
                } else if num_failed == MAX_PRINTS {
                    log::warn!("...");
                }

                num_failed += 1;
            }
        }
    }

    log::info!(
        "Found {num_failed} faulty pixels, comparison {}",
        if num_failed == 0 { "passed." } else { "FAILED!" }
    );
    num_failed == 0
}

/// `compareRedChannel`
fn compare_red_channel(result: &ConstPixelBufferAccess<'_>, reference: i32) -> bool {
    const MAX_PRINTS: i32 = 10;
    let mut num_failed = 0;
    let [width, height, _] = result.size();

    for y in 0..height {
        for x in 0..width {
            let res = result.get_pixel_int(x, y, 0)[0];

            if reference != res {
                if num_failed < MAX_PRINTS {
                    log::warn!("ERROR: Expected {reference}, got {res} at ({x}, {y})");
                } else if num_failed == MAX_PRINTS {
                    log::warn!("...");
                }

                num_failed += 1;
            }
        }
    }

    log::info!(
        "Found {num_failed} faulty pixels, comparison {}",
        if num_failed == 0 { "passed." } else { "FAILED!" }
    );
    num_failed == 0
}

/// `stencilToUnorm8`
fn stencil_to_unorm8(src: &TextureCube, dst: &mut TextureCube) {
    for level_ndx in 0..src.num_levels() {
        if src.is_level_empty(level_ndx) {
            continue;
        }
        dst.alloc_level(level_ndx);

        for face in ALL_FACES {
            let src_level = src.face_level(face, level_ndx);
            let mut dst_level = dst.face_level_mut(face, level_ndx);

            for y in 0..src.size() {
                for x in 0..src.size() {
                    dst_level.set_pixel(
                        [src_level.get_pix_stencil(x, y, 0) as f32 / 255.0, 0.0, 0.0, 1.0],
                        x,
                        y,
                        0,
                    );
                }
            }
        }
    }
}

const ALL_FACES: [CubeFace; 6] = [
    CubeFace::NegativeX,
    CubeFace::PositiveX,
    CubeFace::NegativeY,
    CubeFace::PositiveY,
    CubeFace::NegativeZ,
    CubeFace::PositiveZ,
];

/// `glu::getGLCubeFace`
fn get_gl_cube_face(face: CubeFace) -> GLenum {
    match face {
        CubeFace::NegativeX => glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
        CubeFace::PositiveX => glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
        CubeFace::NegativeY => glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
        CubeFace::PositiveY => glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
        CubeFace::NegativeZ => glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
        CubeFace::PositiveZ => glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
    }
}

fn transfer_alignment(pixel_size: u32) -> i32 {
    if pixel_size.is_power_of_two() {
        pixel_size.min(8) as i32
    } else {
        1
    }
}

/// `glu::texSubImage2D` for a tightly packed level.
fn tex_sub_image_2d(
    gl: &glw::Functions,
    target: GLenum,
    level: i32,
    x: i32,
    y: i32,
    access: &ConstPixelBufferAccess<'_>,
) -> Result<(), TestError> {
    let format = access.format();
    let transfer = get_transfer_format(format)?;
    let pixel_size = format
        .pixel_size()
        .ok_or_else(|| TestError::InternalError("pixel size".to_string()))?;
    let [width, height, _] = access.size();
    // SAFETY: the level is tightly packed, so it holds exactly `width * height` texels of this transfer format.
    unsafe {
        gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, transfer_alignment(pixel_size));
        gl.tex_sub_image_2d(
            target,
            level,
            x,
            y,
            width as i32,
            height as i32,
            transfer.format,
            transfer.data_type,
            access.raw().as_ptr().cast(),
        );
    }
    Ok(())
}

/// `glu::texSubImage3D` for a tightly packed level.
fn tex_sub_image_3d(
    gl: &glw::Functions,
    target: GLenum,
    level: i32,
    access: &ConstPixelBufferAccess<'_>,
) -> Result<(), TestError> {
    let format = access.format();
    let transfer = get_transfer_format(format)?;
    let pixel_size = format
        .pixel_size()
        .ok_or_else(|| TestError::InternalError("pixel size".to_string()))?;
    let [width, height, depth] = access.size();
    // SAFETY: as in `tex_sub_image_2d`, with `depth` slices.
    unsafe {
        gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, transfer_alignment(pixel_size));
        gl.tex_sub_image_3d(
            target,
            level,
            0,
            0,
            0,
            width as i32,
            height as i32,
            depth as i32,
            transfer.format,
            transfer.data_type,
            access.raw().as_ptr().cast(),
        );
    }
    Ok(())
}

/// `checkDepthStencilFormatSupport`
fn check_depth_stencil_format_support(context: &Context, format: GLenum) -> Result<(), TestError> {
    if format == glw::GL_STENCIL_INDEX8 {
        let req_ext = "GL_OES_texture_stencil8";
        if !context.context_type().supports(3, 2) && !context.context_info.is_extension_supported(req_ext) {
            return Err(TestError::NotSupported(format!("GL_STENCIL_INDEX8 requires {req_ext}")));
        }
    } else {
        debug_assert!(format == glw::GL_DEPTH32F_STENCIL8 || format == glw::GL_DEPTH24_STENCIL8);
    }
    Ok(())
}

/// `checkFramebufferStatus`
fn check_framebuffer_status(gl: &glw::Functions) -> Result<(), TestError> {
    // SAFETY: a plain query on the current context.
    let status = unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) };

    if status == glw::GL_FRAMEBUFFER_UNSUPPORTED {
        Err(TestError::NotSupported(
            "Unsupported framebuffer configuration".to_string(),
        ))
    } else if status != glw::GL_FRAMEBUFFER_COMPLETE {
        Err(TestError::Fail(format!("Incomplete framebuffer: {status:#x}")))
    } else {
        Ok(())
    }
}

fn verdict(compare_ok: bool) -> TestOutcome {
    Ok(if compare_ok {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Image comparison failed")
    })
}

fn uint_rgba_level(width: u32, height: u32) -> Result<TextureLevel, TestError> {
    TextureLevel::new(
        TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT32),
        width,
        height,
        1,
    )
}

fn stencil_level(width: u32, height: u32) -> Result<TextureLevel, TestError> {
    TextureLevel::new(
        TextureFormat::new(ChannelOrder::S, ChannelType::UNSIGNED_INT8),
        width,
        height,
        1,
    )
}

fn upload_format(format: GLenum) -> Result<TextureFormat, TestError> {
    map_gl_internal_format(format)
        .ok_or_else(|| TestError::InternalError(format!("unmapped internal format {format:#x}")))
}

/// Attaches a fresh `format`-sized `GL_R32UI`/`internal_format` renderbuffer as the colour target.
fn attach_color_renderbuffer(
    gl: &glw::Functions,
    fbo: &Framebuffer,
    color_buf: &Renderbuffer,
    internal_format: GLenum,
    width: i32,
    height: i32,
) {
    // SAFETY: names this case generated.
    unsafe {
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, color_buf.get());
        gl.renderbuffer_storage(glw::GL_RENDERBUFFER, internal_format, width, height);

        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            color_buf.get(),
        );
    }
}

/// `UploadTex2DCase::iterate`
fn upload_tex_2d(context: &Context, format: GLenum) -> TestOutcome {
    let gl = context.gl();
    let width = 129;
    let height = 113;
    let fbo = Framebuffer::new(gl);
    let color_buf = Renderbuffer::new(gl);
    let depth_stencil_tex = Texture::new(gl);
    let mut upload_level = TextureLevel::new(upload_format(format)?, width, height, 1)?;
    let mut read_level = uint_rgba_level(width, height)?;
    let mut stencil_only_level = stencil_level(width, height)?;

    check_depth_stencil_format_support(context, format)?;

    render_test_pattern_reference(&mut upload_level.get_access());
    render_test_pattern_reference(&mut stencil_only_level.get_access());

    // SAFETY: names this case generated.
    unsafe {
        gl.bind_texture(glw::GL_TEXTURE_2D, depth_stencil_tex.get());
        gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, format, width as i32, height as i32);
    }
    tex_sub_image_2d(gl, glw::GL_TEXTURE_2D, 0, 0, 0, &upload_level.get_const_access())?;
    glu::expect_no_error(gl, "Uploading texture data failed")?;

    attach_color_renderbuffer(gl, &fbo, &color_buf, glw::GL_R32UI, width as i32, height as i32);
    check_framebuffer_status(gl)?;

    blit_stencil_to_color_2d(context, depth_stencil_tex.get(), width as i32, height as i32)?;
    glu::read_pixels(&context.render_context, 0, 0, &mut read_level.get_access())?;

    verdict(compare_stencil_to_red(
        &stencil_only_level.get_const_access(),
        &read_level.get_const_access(),
    ))
}

/// `UploadTex2DArrayCase::iterate`
fn upload_tex_2d_array(context: &Context, format: GLenum) -> TestOutcome {
    let gl = context.gl();
    let width = 41u32;
    let height = 13u32;
    let levels = 7u32;
    let ptrn_level = 3u32;
    let fbo = Framebuffer::new(gl);
    let color_buf = Renderbuffer::new(gl);
    let depth_stencil_tex = Texture::new(gl);
    let mut upload_level = TextureLevel::new(upload_format(format)?, width, height, levels)?;

    check_depth_stencil_format_support(context, format)?;

    {
        let mut access = upload_level.get_access();
        for level_ndx in 0..levels {
            let mut level_access = access.get_subregion(0, 0, level_ndx, width, height, 1);

            if level_ndx == ptrn_level {
                render_test_pattern_reference(&mut level_access);
            } else {
                clear_stencil(&mut level_access, level_ndx);
            }
        }
    }

    // SAFETY: names this case generated.
    unsafe {
        gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, depth_stencil_tex.get());
        gl.tex_storage_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            1,
            format,
            width as i32,
            height as i32,
            levels as i32,
        );
    }
    tex_sub_image_3d(gl, glw::GL_TEXTURE_2D_ARRAY, 0, &upload_level.get_const_access())?;
    glu::expect_no_error(gl, "Uploading texture data failed")?;

    attach_color_renderbuffer(gl, &fbo, &color_buf, glw::GL_R32UI, width as i32, height as i32);
    check_framebuffer_status(gl)?;

    let mut read_level = uint_rgba_level(width, height)?;
    let mut all_levels_ok = true;

    for level_ndx in 0..levels {
        log::info!("Level {level_ndx}");

        blit_stencil_to_color_2d_array(
            context,
            depth_stencil_tex.get(),
            width as i32,
            height as i32,
            level_ndx as i32,
        )?;
        glu::read_pixels(&context.render_context, 0, 0, &mut read_level.get_access())?;

        let level_ok = if level_ndx == ptrn_level {
            let mut reference = stencil_level(width, height)?;
            render_test_pattern_reference(&mut reference.get_access());

            compare_stencil_to_red(&reference.get_const_access(), &read_level.get_const_access())
        } else {
            compare_red_channel(&read_level.get_const_access(), level_ndx as i32)
        };

        if !level_ok {
            all_levels_ok = false;
            break;
        }
    }

    verdict(all_levels_ok)
}

/// `UploadTexCubeCase::iterate`
fn upload_tex_cube(context: &Context, format: GLenum) -> TestOutcome {
    let gl = context.gl();
    let size = 64u32;
    let render_width = 128;
    let render_height = 128;
    let fbo = Framebuffer::new(gl);
    let color_buf = Renderbuffer::new(gl);
    let depth_stencil_tex = Texture::new(gl);
    let mut tex_data = TextureCube::new(upload_format(format)?, size);
    let mut result = Surface::new(render_width, render_height);

    check_depth_stencil_format_support(context, format)?;

    tex_data.alloc_level(0);
    for (face_ndx, face) in ALL_FACES.into_iter().enumerate() {
        let stencil_val = 42 * face_ndx as u32;
        clear_stencil(&mut tex_data.face_level_mut(face, 0), stencil_val);
    }

    let tex_coord = compute_quad_tex_coord_cube_region(CubeFace::NegativeX, Vec2::new(-1.5, -1.3), Vec2::new(1.3, 1.4));

    // SAFETY: names this case generated.
    unsafe {
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, depth_stencil_tex.get());
        gl.tex_storage_2d(glw::GL_TEXTURE_CUBE_MAP, 1, format, size as i32, size as i32);
    }

    for face in ALL_FACES {
        tex_sub_image_2d(gl, get_gl_cube_face(face), 0, 0, 0, &tex_data.face_level(face, 0))?;
    }

    glu::expect_no_error(gl, "Uploading texture data failed")?;

    attach_color_renderbuffer(gl, &fbo, &color_buf, glw::GL_RGBA8, render_width, render_height);
    check_framebuffer_status(gl)?;

    blit_stencil_to_color_cube(
        context,
        depth_stencil_tex.get(),
        &tex_coord,
        render_width,
        render_height,
    )?;
    glu::read_pixels(&context.render_context, 0, 0, &mut result.get_access())?;

    let mut red_tex = TextureCube::new(TextureFormat::new(ChannelOrder::R, ChannelType::UNORM_INT8), size);
    let sample_params = make_reference_params(
        TextureType::Cube,
        glw::GL_CLAMP_TO_EDGE,
        glw::GL_CLAMP_TO_EDGE,
        glw::GL_CLAMP_TO_EDGE,
        glw::GL_NEAREST,
        glw::GL_NEAREST,
        LodMode::Exact,
    )?;
    let lookup_prec = LookupPrecision {
        color_mask: [true; 4],
        color_threshold: compute_fixed_point_threshold([8, 8, 8, 8]),
        coord_bits: [22, 22, 22],
        uvw_bits: [5, 5, 0],
        ..Default::default()
    };
    let lod_prec = LodPrecision {
        lod_bits: 7,
        derivate_bits: 16,
    };

    stencil_to_unorm8(&tex_data, &mut red_tex);

    let compare_ok = verify_texture_result_cube(
        &result,
        &red_tex,
        tex_coord,
        &sample_params,
        &lookup_prec,
        &lod_prec,
        PixelFormat::new(8, 8, 8, 8),
    )?;
    verdict(compare_ok)
}

/// `RenderTex2DCase::iterate`
fn render_tex_2d(context: &Context, format: GLenum) -> TestOutcome {
    let gl = context.gl();
    let width = 117u32;
    let height = 193u32;
    let fbo = Framebuffer::new(gl);
    let color_buf = Renderbuffer::new(gl);
    let depth_stencil_tex = Texture::new(gl);
    let mut result = uint_rgba_level(width, height)?;
    let mut reference = stencil_level(width, height)?;

    check_depth_stencil_format_support(context, format)?;

    // SAFETY: names this case generated.
    unsafe {
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, color_buf.get());
        gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_R32UI, width as i32, height as i32);

        gl.bind_texture(glw::GL_TEXTURE_2D, depth_stencil_tex.get());
        gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, format, width as i32, height as i32);

        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            color_buf.get(),
        );
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_STENCIL_ATTACHMENT,
            glw::GL_TEXTURE_2D,
            depth_stencil_tex.get(),
            0,
        );
    }
    check_framebuffer_status(gl)?;

    draw_test_pattern(context, width as i32, height as i32)?;

    // SAFETY: detaching with the name 0.
    unsafe {
        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_STENCIL_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            0,
        )
    };
    check_framebuffer_status(gl)?;

    blit_stencil_to_color_2d(context, depth_stencil_tex.get(), width as i32, height as i32)?;
    glu::read_pixels(&context.render_context, 0, 0, &mut result.get_access())?;

    render_test_pattern_reference(&mut reference.get_access());

    verdict(compare_stencil_to_red(
        &reference.get_const_access(),
        &result.get_const_access(),
    ))
}

/// `ClearTex2DCase::iterate`
fn clear_tex_2d(context: &Context, format: GLenum) -> TestOutcome {
    let gl = context.gl();
    let width = 125u32;
    let height = 117u32;
    let cell_size = 8u32;
    let fbo = Framebuffer::new(gl);
    let color_buf = Renderbuffer::new(gl);
    let depth_stencil_tex = Texture::new(gl);
    let mut result = uint_rgba_level(width, height)?;
    let mut reference = stencil_level(width, height)?;

    check_depth_stencil_format_support(context, format)?;

    // SAFETY: names this case generated.
    unsafe {
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, color_buf.get());
        gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_R32UI, width as i32, height as i32);

        gl.bind_texture(glw::GL_TEXTURE_2D, depth_stencil_tex.get());
        gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, format, width as i32, height as i32);

        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            color_buf.get(),
        );
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_STENCIL_ATTACHMENT,
            glw::GL_TEXTURE_2D,
            depth_stencil_tex.get(),
            0,
        );
    }
    check_framebuffer_status(gl)?;

    // SAFETY: plain state setting on the current context.
    unsafe { gl.enable(glw::GL_SCISSOR_TEST) };

    {
        let mut reference_access = reference.get_access();
        let mut y = 0;
        while y < height {
            let mut x = 0;
            while x < width {
                let clear_w = cell_size.min(width - x);
                let clear_h = cell_size.min(height - y);
                let stencil = ((de_int32_hash(x as i32) ^ de_int32_hash(y as i32)) & 0xff) as i32;

                // SAFETY: as above.
                unsafe {
                    gl.clear_stencil(stencil);
                    gl.scissor(x as i32, y as i32, clear_w as i32, clear_h as i32);
                    gl.clear(glw::GL_STENCIL_BUFFER_BIT);
                }

                clear_stencil(
                    &mut reference_access.get_subregion(x, y, 0, clear_w, clear_h, 1),
                    stencil as u32,
                );

                x += cell_size;
            }
            y += cell_size;
        }
    }

    // SAFETY: as above.
    unsafe {
        gl.disable(glw::GL_SCISSOR_TEST);

        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_STENCIL_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            0,
        );
    }
    check_framebuffer_status(gl)?;

    blit_stencil_to_color_2d(context, depth_stencil_tex.get(), width as i32, height as i32)?;
    glu::read_pixels(&context.render_context, 0, 0, &mut result.get_access())?;

    verdict(compare_stencil_to_red(
        &reference.get_const_access(),
        &result.get_const_access(),
    ))
}

/// `BaseLevelCase::iterate`
fn base_level(context: &Context, format: GLenum) -> TestOutcome {
    let gl = context.gl();
    let width = 128u32;
    let height = 128u32;
    let level_ndx = 2u32;
    let level_width = width >> level_ndx;
    let level_height = height >> level_ndx;
    let fbo = Framebuffer::new(gl);
    let color_buf = Renderbuffer::new(gl);
    let depth_stencil_tex = Texture::new(gl);
    let mut upload_level = TextureLevel::new(upload_format(format)?, level_width, level_height, 1)?;
    let mut read_level = uint_rgba_level(level_width, level_height)?;
    let mut stencil_only_level = stencil_level(level_width, level_height)?;

    check_depth_stencil_format_support(context, format)?;

    log::info!("GL_TEXTURE_BASE_LEVEL = {level_ndx}");

    render_test_pattern_reference(&mut upload_level.get_access());
    render_test_pattern_reference(&mut stencil_only_level.get_access());

    // SAFETY: names this case generated.
    unsafe {
        gl.bind_texture(glw::GL_TEXTURE_2D, depth_stencil_tex.get());
        gl.tex_storage_2d(
            glw::GL_TEXTURE_2D,
            (width.max(height).ilog2() + 1) as i32,
            format,
            width as i32,
            height as i32,
        );
        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_BASE_LEVEL, level_ndx as i32);
    }
    tex_sub_image_2d(
        gl,
        glw::GL_TEXTURE_2D,
        level_ndx as i32,
        0,
        0,
        &upload_level.get_const_access(),
    )?;
    glu::expect_no_error(gl, "Uploading texture data failed")?;

    attach_color_renderbuffer(
        gl,
        &fbo,
        &color_buf,
        glw::GL_R32UI,
        level_width as i32,
        level_height as i32,
    );
    check_framebuffer_status(gl)?;

    blit_stencil_to_color_2d(
        context,
        depth_stencil_tex.get(),
        level_width as i32,
        level_height as i32,
    )?;
    glu::read_pixels(&context.render_context, 0, 0, &mut read_level.get_access())?;

    verdict(compare_stencil_to_red(
        &stencil_only_level.get_const_access(),
        &read_level.get_const_access(),
    ))
}

struct StencilTexturingCase {
    name: &'static str,
    format: GLenum,
    run: fn(&Context, GLenum) -> TestOutcome,
}

impl TestCase for StencilTexturingCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        (self.run)(context, self.format)
    }
}

fn case(name: &'static str, format: GLenum, run: fn(&Context, GLenum) -> TestOutcome) -> Box<dyn TestCase> {
    Box::new(StencilTexturingCase { name, format, run })
}

/// `StencilTexturingTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("stencil_texturing");

    // .format
    {
        let mut format_group = TestCaseGroup::new("format");

        format_group.add_child(case("depth32f_stencil8_2d", glw::GL_DEPTH32F_STENCIL8, upload_tex_2d));
        format_group.add_child(case(
            "depth32f_stencil8_2d_array",
            glw::GL_DEPTH32F_STENCIL8,
            upload_tex_2d_array,
        ));
        format_group.add_child(case(
            "depth32f_stencil8_cube",
            glw::GL_DEPTH32F_STENCIL8,
            upload_tex_cube,
        ));
        format_group.add_child(case("depth24_stencil8_2d", glw::GL_DEPTH24_STENCIL8, upload_tex_2d));
        format_group.add_child(case(
            "depth24_stencil8_2d_array",
            glw::GL_DEPTH24_STENCIL8,
            upload_tex_2d_array,
        ));
        format_group.add_child(case("depth24_stencil8_cube", glw::GL_DEPTH24_STENCIL8, upload_tex_cube));

        // OES_texture_stencil8
        format_group.add_child(case("stencil_index8_2d", glw::GL_STENCIL_INDEX8, upload_tex_2d));
        format_group.add_child(case(
            "stencil_index8_2d_array",
            glw::GL_STENCIL_INDEX8,
            upload_tex_2d_array,
        ));
        format_group.add_child(case("stencil_index8_cube", glw::GL_STENCIL_INDEX8, upload_tex_cube));

        group.add_child(format_group);
    }

    // .render
    {
        let mut render_group = TestCaseGroup::new("render");

        render_group.add_child(case("depth32f_stencil8_clear", glw::GL_DEPTH32F_STENCIL8, clear_tex_2d));
        render_group.add_child(case("depth32f_stencil8_draw", glw::GL_DEPTH32F_STENCIL8, render_tex_2d));
        render_group.add_child(case("depth24_stencil8_clear", glw::GL_DEPTH24_STENCIL8, clear_tex_2d));
        render_group.add_child(case("depth24_stencil8_draw", glw::GL_DEPTH24_STENCIL8, render_tex_2d));

        group.add_child(render_group);
    }

    // .misc
    {
        let mut misc_group = TestCaseGroup::new("misc");

        misc_group.add_child(case("base_level", glw::GL_DEPTH24_STENCIL8, base_level));

        group.add_child(misc_group);
    }

    group
}
