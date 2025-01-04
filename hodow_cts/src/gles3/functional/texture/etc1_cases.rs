// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fTextureFormatTests.cpp (Texture2DFileCase, TextureCubeFileCase)
//   modules/gles2/functional/es2fTextureFormatTests.cpp (Compressed2DFormatCase, CompressedCubeFormatCase)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The two modules' ETC1 file cases are the same
// case up to the GLSL version/precision/seamless flag, so both share this one; the images come
// from `glu::etc1` instead of the test-data archive. `TextureCubeFileCase`'s per-face
// `iterate()` state machine is a plain loop over the six faces with the same viewport seeds.
// The ES 2.0 module's cases pass `Es100`/`MediumP`, the ES 3.0 module's `Es300`/`HighP`.

use crate::gls::texture_test_util::{RandomViewport, TextureRenderer};
use crate::glu::etc1::{ETC1_GL_FORMAT, ETC1_VK_FORMAT, Etc1Image};
use crate::glu::shader_util::Precision;
use crate::glu::texture::Texture2D;
use crate::glu::texture_cube::TextureCube;
use crate::glu::texture_test_util::{LodMode, TextureType, compute_quad_tex_coord_2d};
use crate::glu::texture_test_util_surface::{
    compare_images, compute_quad_tex_coord_cube, make_reference_params, sample_texture_2d_to_surface,
    sample_texture_cube_to_surface,
};
use crate::glu::{self, Context, GlslVersion, TestCase, read_pixels};
use crate::glw;
use crate::tcu::pixel::CubeFace;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::surface_access::SurfaceAccess;
use crate::tcu::vector::Vec2;
use crate::tcu::{TestOutcome, TestStatus, de_string_hash};

/// `tcu::CubeFace` order, which is the order the skybox files are listed in.
const FACES: [CubeFace; 6] = [
    CubeFace::NegativeX,
    CubeFace::PositiveX,
    CubeFace::NegativeY,
    CubeFace::PositiveY,
    CubeFace::NegativeZ,
    CubeFace::PositiveZ,
];

pub(crate) enum Etc1Source {
    /// One image per level.
    Tex2D(Vec<Etc1Image>),
    /// `[level][face]`, faces in `tcu::CubeFace` order.
    Cube(Vec<[Etc1Image; 6]>),
}

pub(crate) struct Etc1FileCase {
    pub(crate) name: String,
    pub(crate) source: Etc1Source,
    pub(crate) glsl_version: GlslVersion,
    pub(crate) precision: Precision,
    pub(crate) seamless_cube_map: bool,
}

fn set_nearest_clamp_state(context: &Context, target: u32) -> Result<(), crate::tcu::TestError> {
    let gl = context.gl();
    // SAFETY: plain state setting on the current context.
    unsafe {
        gl.active_texture(glw::GL_TEXTURE0);
        gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
        gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
        gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
        gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
    }
    glu::expect_no_error(gl, "Set texturing state")
}

fn verdict(is_ok: bool) -> TestOutcome {
    if is_ok {
        Ok(TestStatus::pass("Pass"))
    } else {
        Ok(TestStatus::fail("Image comparison failed"))
    }
}

impl TestCase for Etc1FileCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let mut renderer = TextureRenderer::new(render_ctx, self.glsl_version, self.precision);
        let threshold = render_target.pixel_format().get_color_threshold() + RGBA::new(1, 1, 1, 1);

        match &self.source {
            Etc1Source::Tex2D(levels) => {
                // `Texture2DFileCase::init`
                let data: Vec<&[u8]> = levels.iter().map(|image| image.data).collect();
                let texture = Texture2D::new_compressed_with_gl_format(
                    render_ctx,
                    &context.context_info,
                    ETC1_VK_FORMAT,
                    Some(ETC1_GL_FORMAT),
                    levels[0].width,
                    levels[0].height,
                    &data,
                )?;
                // SAFETY: a current context; `texture` outlives the upload.
                unsafe { texture.upload_compressed()? };

                let viewport = RandomViewport::new(
                    &render_target,
                    texture.ref_texture().width() as i32,
                    texture.ref_texture().height() as i32,
                    de_string_hash(&self.name),
                );
                let mut rendered_frame = Surface::new(viewport.width, viewport.height);
                let mut reference_frame = Surface::new(viewport.width, viewport.height);
                let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));
                let ref_params = make_reference_params(
                    TextureType::Texture2D,
                    glw::GL_CLAMP_TO_EDGE,
                    glw::GL_CLAMP_TO_EDGE,
                    glw::GL_CLAMP_TO_EDGE,
                    glw::GL_NEAREST,
                    glw::GL_NEAREST,
                    LodMode::Exact,
                )?;

                // SAFETY: plain state setting on the current context.
                unsafe {
                    gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);
                    gl.active_texture(glw::GL_TEXTURE0);
                    gl.bind_texture(glw::GL_TEXTURE_2D, texture.gl_texture());
                }
                set_nearest_clamp_state(context, glw::GL_TEXTURE_2D)?;

                renderer.render_quad(0, &tex_coord, &ref_params.base)?;
                read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;
                glu::expect_no_error(gl, "glReadPixels()")?;

                let mut dst = SurfaceAccess::new(&mut reference_frame, render_target.pixel_format());
                sample_texture_2d_to_surface(&mut dst, texture.ref_texture(), tex_coord, &ref_params)?;

                verdict(compare_images(&reference_frame, &rendered_frame, threshold).ok)
            }
            Etc1Source::Cube(levels) => {
                // `TextureCubeFileCase::init`: `TextureCube::new_compressed` takes the faces in `ALL_FACES` order.
                let level_data: Vec<[&[u8]; 6]> = levels
                    .iter()
                    .map(|faces| {
                        std::array::from_fn(|i| {
                            let upstream_ndx = FACES
                                .iter()
                                .position(|&f| f == crate::glu::texture_cube::ALL_FACES[i])
                                .expect("every face is in FACES");
                            faces[upstream_ndx].data
                        })
                    })
                    .collect();
                let texture = TextureCube::new_compressed_with_gl_format(
                    render_ctx,
                    &context.context_info,
                    ETC1_VK_FORMAT,
                    Some(ETC1_GL_FORMAT),
                    levels[0][0].width,
                    &level_data,
                )?;
                // SAFETY: a current context; `texture` outlives the upload.
                unsafe { texture.upload_compressed()? };

                let size = texture.ref_texture().size() as i32;
                let mut is_ok = true;

                for (face_ndx, &face) in FACES.iter().enumerate() {
                    let viewport = RandomViewport::new(
                        &render_target,
                        size,
                        size,
                        de_string_hash(&self.name).wrapping_add(face_ndx as u32),
                    );
                    let mut rendered_frame = Surface::new(viewport.width, viewport.height);
                    let mut reference_frame = Surface::new(viewport.width, viewport.height);
                    let tex_coord = compute_quad_tex_coord_cube(face);
                    let mut ref_params = make_reference_params(
                        TextureType::Cube,
                        glw::GL_CLAMP_TO_EDGE,
                        glw::GL_CLAMP_TO_EDGE,
                        glw::GL_CLAMP_TO_EDGE,
                        glw::GL_NEAREST,
                        glw::GL_NEAREST,
                        LodMode::Exact,
                    )?;
                    ref_params.sampler.seamless_cube_map = self.seamless_cube_map;

                    // SAFETY: plain state setting on the current context.
                    unsafe {
                        gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);
                        gl.active_texture(glw::GL_TEXTURE0);
                        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture.gl_texture());
                    }
                    set_nearest_clamp_state(context, glw::GL_TEXTURE_CUBE_MAP)?;

                    renderer.render_quad(0, &tex_coord, &ref_params.base)?;
                    read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;
                    glu::expect_no_error(gl, "glReadPixels()")?;

                    let mut dst = SurfaceAccess::new(&mut reference_frame, render_target.pixel_format());
                    sample_texture_cube_to_surface(&mut dst, texture.ref_texture(), tex_coord, &ref_params)?;

                    if !compare_images(&reference_frame, &rendered_frame, threshold).ok {
                        is_ok = false;
                    }
                }

                verdict(is_ok)
            }
        }
    }
}

/// The four cases both modules' format groups add for `GL_ETC1_RGB8_OES`: `etc1_2d_pot`, `etc1_2d_npot`,
/// `etc1_cube_pot` and `etc1_cube_npot`.
pub(crate) fn etc1_format_cases(
    glsl_version: GlslVersion,
    precision: Precision,
    seamless_cube_map: bool,
) -> Vec<Box<dyn TestCase>> {
    use crate::glu::etc1::{photo_mip_levels, photo_npot, skybox_npot_levels, skybox_pot_levels};

    let case = |name: &str, source: Etc1Source| {
        Box::new(Etc1FileCase {
            name: name.to_string(),
            source,
            glsl_version,
            precision,
            seamless_cube_map,
        }) as Box<dyn TestCase>
    };

    vec![
        case("etc1_2d_pot", Etc1Source::Tex2D(photo_mip_levels())),
        case("etc1_2d_npot", Etc1Source::Tex2D(vec![photo_npot()])),
        case("etc1_cube_pot", Etc1Source::Cube(skybox_pot_levels())),
        case("etc1_cube_npot", Etc1Source::Cube(skybox_npot_levels())),
    ]
}
