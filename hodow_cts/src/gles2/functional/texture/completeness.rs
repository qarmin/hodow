// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fTextureCompletenessTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The two base classes
// (`Tex2DCompletenessCase`/`TexCubeCompletenessCase`, virtual `createTexture`) and their
// twelve subclasses are one `CompletenessCase` with a `Spec` enum; each `Spec` arm's body is
// the matching `createTexture`, which returns the colour the render has to come out as
// (black for an incomplete texture, blue where an extension or the case itself makes it
// complete - upstream's mutable `m_compareColor`).
//
// Three upstream quirks are kept on purpose: the cube wrap-mode, extra-level and
// empty-object cases bind the texture to `GL_TEXTURE_2D` while setting `GL_TEXTURE_CUBE_MAP`
// state (or the reverse), and every level of a case is uploaded from one `m_size`-sized
// buffer however small the level is.

use std::ffi::c_void;

use crate::gls::texture_test_util::TextureRenderer;
use crate::glu::shader_util::Precision;
use crate::glu::texture_test_util::{RenderParams, TextureType, compute_quad_tex_coord_2d};
use crate::glu::texture_test_util_surface::compute_quad_tex_coord_cube;
use crate::glu::texture_util::map_gl_transfer_format;
use crate::glu::{Context, GlslVersion, TestCase, TestCaseGroup, read_pixels};
use crate::glw;
use crate::tcu::pixel::{CubeFace, TextureLevel, clear};
use crate::tcu::random::Random;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::vector::Vec2;
use crate::tcu::{TestError, TestOutcome, TestStatus, de_string_hash};

const CUBE_TARGETS: [u32; 6] = [
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
];

const FACES: [CubeFace; 6] = [
    CubeFace::NegativeX,
    CubeFace::PositiveX,
    CubeFace::NegativeY,
    CubeFace::PositiveY,
    CubeFace::NegativeZ,
    CubeFace::PositiveZ,
];

type IVec2 = (i32, i32);

/// `deIsPowerOfTwo32` - note that it is true for 0.
fn de_is_power_of_two32(a: i32) -> bool {
    (a & a.wrapping_sub(1)) == 0
}

fn log2_floor(value: i32) -> i32 {
    31 - (value as u32).leading_zeros() as i32
}

fn num_levels_of(size: IVec2) -> i32 {
    1 + log2_floor(size.0).max(log2_floor(size.1))
}

/// `expectError`
fn expect_error(gl: &glw::Functions, expected: u32, message: &str) -> Result<(), TestError> {
    // SAFETY: glGetError takes no arguments.
    let error = unsafe { gl.get_error() };
    if error != expected {
        return Err(TestError::Fail(format!(
            "Got unexpected GL error: {message}: expected {expected:#x}, got {error:#x}"
        )));
    }
    Ok(())
}

/// `compareToConstantColor`
fn compare_to_constant_color(result: &Surface, color: RGBA) -> bool {
    (0..result.get_height()).all(|y| (0..result.get_width()).all(|x| result.get_pixel(x, y) == color))
}

/// The `m_size`-sized level buffer `levelData.setSize(...)` + `clear(..., Vec4(0, 0, 1, 1))` builds.
fn make_level_data(format: u32, size: IVec2) -> Result<TextureLevel, TestError> {
    let fmt = map_gl_transfer_format(format, glw::GL_UNSIGNED_BYTE)
        .ok_or_else(|| TestError::Fail(format!("unsupported transfer format {format:#x}")))?;
    let mut level = TextureLevel::new(fmt, size.0 as u32, size.1 as u32, 1)?;
    clear(&mut level.get_access(), [0.0, 0.0, 1.0, 1.0]);
    Ok(level)
}

fn tex_image(gl: &glw::Functions, target: u32, level: i32, format: u32, width: i32, height: i32, data: &TextureLevel) {
    // SAFETY: `data` is a live buffer; the uploads that are larger than it are upstream's own.
    unsafe {
        gl.tex_image_2d(
            target,
            level,
            format as i32,
            width,
            height,
            0,
            format,
            glw::GL_UNSIGNED_BYTE,
            data.data().as_ptr().cast::<c_void>(),
        )
    };
}

fn set_state(gl: &glw::Functions, target: u32, wrap_s: u32, wrap_t: u32, min_filter: u32) {
    // SAFETY: plain state setting on the current context.
    unsafe {
        gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_S, wrap_s as i32);
        gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_T, wrap_t as i32);
        gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, min_filter as i32);
        gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
    }
}

#[derive(Clone, Copy)]
enum Spec {
    Size2D {
        size: IVec2,
        invalid_level_size: IVec2,
        invalid_level_ndx: i32,
    },
    Format2D {
        size: IVec2,
        format: u32,
        invalid_format: u32,
        invalid_level_ndx: i32,
    },
    MissingLevel2D {
        size: IVec2,
        missing_level_ndx: i32,
    },
    WrapMode2D {
        size: IVec2,
        wrap_t: u32,
        wrap_s: u32,
    },
    ExtraLevel2D {
        size: IVec2,
    },
    EmptyObject2D,
    /// `invalid_face: None` is upstream's `tcu::CUBEFACE_LAST`: every face.
    SizeCube {
        size: IVec2,
        invalid_level_size: IVec2,
        invalid_level_ndx: i32,
        invalid_face: Option<usize>,
    },
    FormatCube {
        size: IVec2,
        format: u32,
        invalid_format: u32,
        invalid_face: Option<usize>,
    },
    MissingLevelCube {
        size: IVec2,
        invalid_level_ndx: i32,
        invalid_face: Option<usize>,
    },
    WrapModeCube {
        size: IVec2,
        wrap_t: u32,
        wrap_s: u32,
    },
    ExtraLevelCube {
        size: IVec2,
    },
    EmptyObjectCube,
}

impl Spec {
    fn is_cube(self) -> bool {
        matches!(
            self,
            Spec::SizeCube { .. }
                | Spec::FormatCube { .. }
                | Spec::MissingLevelCube { .. }
                | Spec::WrapModeCube { .. }
                | Spec::ExtraLevelCube { .. }
                | Spec::EmptyObjectCube
        )
    }
}

struct CompletenessCase {
    name: String,
    spec: Spec,
}

impl CompletenessCase {
    /// `createTexture` of the matching upstream subclass; returns `m_compareColor`.
    fn create_texture(&self, context: &Context, texture: u32) -> Result<RGBA, TestError> {
        let gl = context.gl();
        let info = &context.context_info;
        let mut compare_color = RGBA::new(0, 0, 0, 255);
        let blue = RGBA::new(0, 0, 255, 255);

        // SAFETY: plain state setting on the current context.
        unsafe { gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1) };

        match self.spec {
            Spec::Size2D {
                size,
                invalid_level_size,
                invalid_level_ndx,
            } => {
                const RELAXING_EXTENSIONS: [&str; 2] = ["GL_OES_texture_npot", "GL_NV_texture_npot_2D_mipmap"];
                let relaxing_extension = RELAXING_EXTENSIONS.iter().find(|ext| info.is_extension_supported(ext));

                // SAFETY: plain state setting on the current context.
                unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, texture) };
                set_state(
                    gl,
                    glw::GL_TEXTURE_2D,
                    glw::GL_REPEAT,
                    glw::GL_REPEAT,
                    glw::GL_NEAREST_MIPMAP_NEAREST,
                );
                crate::glu::expect_no_error(gl, "Set texturing state")?;

                let level_data = make_level_data(glw::GL_RGBA, size)?;
                for level_ndx in 0..num_levels_of(size) {
                    let level_w = if level_ndx == invalid_level_ndx {
                        invalid_level_size.0
                    } else {
                        (size.0 >> level_ndx).max(1)
                    };
                    let level_h = if level_ndx == invalid_level_ndx {
                        invalid_level_size.1
                    } else {
                        (size.1 >> level_ndx).max(1)
                    };

                    tex_image(
                        gl,
                        glw::GL_TEXTURE_2D,
                        level_ndx,
                        glw::GL_RGBA,
                        level_w,
                        level_h,
                        &level_data,
                    );

                    let invalid_npot_level = relaxing_extension.is_none()
                        && level_ndx > 0
                        && (!de_is_power_of_two32(level_w) || !de_is_power_of_two32(level_h));
                    expect_error(
                        gl,
                        if invalid_npot_level {
                            glw::GL_INVALID_VALUE
                        } else {
                            glw::GL_NO_ERROR
                        },
                        "glTexImage2D()",
                    )?;
                }

                // A relaxing extension can make the NPOT mipmap complete.
                if (!de_is_power_of_two32(size.0) || !de_is_power_of_two32(size.1)) && relaxing_extension.is_some() {
                    compare_color = blue;
                }
            }
            Spec::Format2D {
                size,
                format,
                invalid_format,
                invalid_level_ndx,
            } => {
                let level_data = make_level_data(format, size)?;

                // SAFETY: plain state setting on the current context.
                unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, texture) };
                set_state(
                    gl,
                    glw::GL_TEXTURE_2D,
                    glw::GL_REPEAT,
                    glw::GL_REPEAT,
                    glw::GL_NEAREST_MIPMAP_NEAREST,
                );

                for level_ndx in 0..num_levels_of(size) {
                    let level_w = (size.0 >> level_ndx).max(1);
                    let level_h = (size.1 >> level_ndx).max(1);
                    let level_format = if level_ndx == invalid_level_ndx {
                        invalid_format
                    } else {
                        format
                    };
                    tex_image(
                        gl,
                        glw::GL_TEXTURE_2D,
                        level_ndx,
                        level_format,
                        level_w,
                        level_h,
                        &level_data,
                    );
                }
                crate::glu::expect_no_error(gl, "Set texturing state")?;
            }
            Spec::MissingLevel2D {
                size,
                missing_level_ndx,
            } => {
                // SAFETY: plain state setting on the current context.
                unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, texture) };
                set_state(
                    gl,
                    glw::GL_TEXTURE_2D,
                    glw::GL_REPEAT,
                    glw::GL_REPEAT,
                    glw::GL_NEAREST_MIPMAP_NEAREST,
                );

                let level_data = make_level_data(glw::GL_RGBA, size)?;
                for level_ndx in 0..num_levels_of(size) {
                    let level_w = (size.0 >> level_ndx).max(1);
                    let level_h = (size.1 >> level_ndx).max(1);

                    // Skip specified level.
                    if level_ndx != missing_level_ndx {
                        tex_image(
                            gl,
                            glw::GL_TEXTURE_2D,
                            level_ndx,
                            glw::GL_RGBA,
                            level_w,
                            level_h,
                            &level_data,
                        );
                    }
                }
                crate::glu::expect_no_error(gl, "Set texturing state")?;
            }
            Spec::WrapMode2D { size, wrap_t, wrap_s } => {
                // SAFETY: plain state setting on the current context.
                unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, texture) };
                set_state(gl, glw::GL_TEXTURE_2D, wrap_s, wrap_t, glw::GL_NEAREST);

                let level_data = make_level_data(glw::GL_RGBA, size)?;
                tex_image(gl, glw::GL_TEXTURE_2D, 0, glw::GL_RGBA, size.0, size.1, &level_data);
                crate::glu::expect_no_error(gl, "Set texturing state")?;

                if info.is_extension_supported("GL_OES_texture_npot") {
                    compare_color = blue;
                }
            }
            Spec::ExtraLevel2D { size } => {
                // SAFETY: plain state setting on the current context.
                unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, texture) };
                set_state(
                    gl,
                    glw::GL_TEXTURE_2D,
                    glw::GL_REPEAT,
                    glw::GL_REPEAT,
                    glw::GL_NEAREST_MIPMAP_NEAREST,
                );

                let num_levels = num_levels_of(size);
                let level_data = make_level_data(glw::GL_RGBA, size)?;
                for level_ndx in 0..num_levels {
                    let level_w = (size.0 >> level_ndx).max(1);
                    let level_h = (size.1 >> level_ndx).max(1);
                    tex_image(
                        gl,
                        glw::GL_TEXTURE_2D,
                        level_ndx,
                        glw::GL_RGBA,
                        level_w,
                        level_h,
                        &level_data,
                    );
                }

                // Specify extra level.
                tex_image(gl, glw::GL_TEXTURE_2D, num_levels + 1, glw::GL_RGBA, 1, 1, &level_data);

                compare_color = blue;
                crate::glu::expect_no_error(gl, "Set texturing state")?;
            }
            Spec::EmptyObject2D => {
                // SAFETY: plain state setting on the current context.
                unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, texture) };
                set_state(
                    gl,
                    glw::GL_TEXTURE_2D,
                    glw::GL_REPEAT,
                    glw::GL_REPEAT,
                    glw::GL_NEAREST_MIPMAP_NEAREST,
                );
                crate::glu::expect_no_error(gl, "Set texturing state")?;
            }
            Spec::SizeCube {
                size,
                invalid_level_size,
                invalid_level_ndx,
                invalid_face,
            } => {
                let full_npot_support = info.is_extension_supported("GL_OES_texture_npot");

                // SAFETY: plain state setting on the current context.
                unsafe { gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture) };
                set_state(
                    gl,
                    glw::GL_TEXTURE_CUBE_MAP,
                    glw::GL_REPEAT,
                    glw::GL_REPEAT,
                    glw::GL_NEAREST_MIPMAP_NEAREST,
                );
                crate::glu::expect_no_error(gl, "Set texturing state")?;

                let level_data = make_level_data(glw::GL_RGBA, size)?;
                for level_ndx in 0..num_levels_of(size) {
                    for (target_ndx, &target) in CUBE_TARGETS.iter().enumerate() {
                        let mut level_w = (size.0 >> level_ndx).max(1);
                        let mut level_h = (size.1 >> level_ndx).max(1);

                        if level_ndx == invalid_level_ndx && invalid_face.is_none_or(|face| face == target_ndx) {
                            level_w = invalid_level_size.0;
                            level_h = invalid_level_size.1;
                        }

                        tex_image(gl, target, level_ndx, glw::GL_RGBA, level_w, level_h, &level_data);

                        let invalid_npot_level = !full_npot_support
                            && level_ndx > 0
                            && (!de_is_power_of_two32(level_w) || !de_is_power_of_two32(level_h));
                        expect_error(
                            gl,
                            if invalid_npot_level {
                                glw::GL_INVALID_VALUE
                            } else {
                                glw::GL_NO_ERROR
                            },
                            "glTexImage2D()",
                        )?;
                    }
                }
            }
            Spec::FormatCube {
                size,
                format,
                invalid_format,
                invalid_face,
            } => {
                // SAFETY: plain state setting on the current context.
                unsafe { gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture) };
                set_state(
                    gl,
                    glw::GL_TEXTURE_CUBE_MAP,
                    glw::GL_REPEAT,
                    glw::GL_REPEAT,
                    glw::GL_NEAREST_MIPMAP_NEAREST,
                );

                let level_data = make_level_data(glw::GL_RGBA, size)?;
                for level_ndx in 0..num_levels_of(size) {
                    let level_w = (size.0 >> level_ndx).max(1);
                    let level_h = (size.1 >> level_ndx).max(1);

                    for (target_ndx, &target) in CUBE_TARGETS.iter().enumerate() {
                        let mut level_format = format;
                        if level_ndx == 0 && invalid_face.is_none_or(|face| face == target_ndx) {
                            level_format = invalid_format;
                        }
                        tex_image(gl, target, level_ndx, level_format, level_w, level_h, &level_data);
                    }
                }
                crate::glu::expect_no_error(gl, "Set texturing state")?;
            }
            Spec::MissingLevelCube {
                size,
                invalid_level_ndx,
                invalid_face,
            } => {
                // SAFETY: plain state setting on the current context.
                unsafe { gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture) };
                set_state(
                    gl,
                    glw::GL_TEXTURE_CUBE_MAP,
                    glw::GL_REPEAT,
                    glw::GL_REPEAT,
                    glw::GL_NEAREST_MIPMAP_NEAREST,
                );

                let level_data = make_level_data(glw::GL_RGBA, size)?;
                for level_ndx in 0..num_levels_of(size) {
                    let level_w = if level_ndx == invalid_level_ndx {
                        size.0
                    } else {
                        (size.0 >> level_ndx).max(1)
                    };
                    let level_h = if level_ndx == invalid_level_ndx {
                        size.1
                    } else {
                        (size.1 >> level_ndx).max(1)
                    };

                    if level_ndx != invalid_level_ndx || invalid_face.is_some() {
                        for (target_ndx, &target) in CUBE_TARGETS.iter().enumerate() {
                            // If single cubeface is specified then skip only that one.
                            if invalid_face != Some(target_ndx) {
                                tex_image(gl, target, level_ndx, glw::GL_RGBA, level_w, level_h, &level_data);
                            }
                        }
                    }
                }
                crate::glu::expect_no_error(gl, "Set texturing state")?;
            }
            Spec::WrapModeCube { size, wrap_t, wrap_s } => {
                // \note upstream binds GL_TEXTURE_2D here and sets GL_TEXTURE_CUBE_MAP state.
                // SAFETY: plain state setting on the current context.
                unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, texture) };
                set_state(gl, glw::GL_TEXTURE_CUBE_MAP, wrap_s, wrap_t, glw::GL_NEAREST);

                let level_data = make_level_data(glw::GL_RGBA, size)?;
                for &target in &CUBE_TARGETS {
                    tex_image(gl, target, 0, glw::GL_RGBA, size.0, size.1, &level_data);
                }
                crate::glu::expect_no_error(gl, "Set texturing state")?;

                if info.is_extension_supported("GL_OES_texture_npot") {
                    compare_color = blue;
                }
            }
            Spec::ExtraLevelCube { size } => {
                // \note upstream binds GL_TEXTURE_2D and sets GL_TEXTURE_2D state here.
                // SAFETY: plain state setting on the current context.
                unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, texture) };
                set_state(
                    gl,
                    glw::GL_TEXTURE_2D,
                    glw::GL_REPEAT,
                    glw::GL_REPEAT,
                    glw::GL_NEAREST_MIPMAP_NEAREST,
                );

                let num_levels = num_levels_of(size);
                let level_data = make_level_data(glw::GL_RGBA, size)?;
                for level_ndx in 0..num_levels {
                    let level_w = (size.0 >> level_ndx).max(1);
                    let level_h = (size.1 >> level_ndx).max(1);
                    for &target in &CUBE_TARGETS {
                        tex_image(gl, target, level_ndx, glw::GL_RGBA, level_w, level_h, &level_data);
                    }
                }

                // Specify extra level.
                for &target in &CUBE_TARGETS {
                    tex_image(gl, target, num_levels + 1, glw::GL_RGBA, 1, 1, &level_data);
                }

                compare_color = blue;
                crate::glu::expect_no_error(gl, "Set texturing state")?;
            }
            Spec::EmptyObjectCube => {
                // \note upstream binds GL_TEXTURE_2D and sets GL_TEXTURE_2D state here.
                // SAFETY: plain state setting on the current context.
                unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, texture) };
                set_state(
                    gl,
                    glw::GL_TEXTURE_2D,
                    glw::GL_REPEAT,
                    glw::GL_REPEAT,
                    glw::GL_NEAREST_MIPMAP_NEAREST,
                );
                crate::glu::expect_no_error(gl, "Set texturing state")?;
            }
        }

        Ok(compare_color)
    }
}

impl TestCase for CompletenessCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let viewport_width = 64.min(render_target.width);
        let viewport_height = 64.min(render_target.height);
        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es100, Precision::MediumP);
        let mut rendered_frame = Surface::new(viewport_width, viewport_height);
        let mut random = Random::new(de_string_hash(&self.name));

        if !self.spec.is_cube() {
            let offset_x = random.get_int(0, render_target.width - viewport_width);
            let offset_y = random.get_int(0, render_target.height - viewport_height);
            let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));

            // SAFETY: plain state setting on the current context.
            unsafe { gl.viewport(offset_x, offset_y, viewport_width, viewport_height) };

            let mut texture = 0u32;
            // SAFETY: one texture name is written.
            unsafe { gl.gen_textures(1, &mut texture) };
            let compare_color = self.create_texture(context, texture);

            let result = compare_color.and_then(|compare_color| {
                renderer.render_quad(0, &tex_coord, &RenderParams::new(TextureType::Texture2D))?;
                read_pixels(render_ctx, offset_x, offset_y, &mut rendered_frame.get_access())?;
                Ok(compare_to_constant_color(&rendered_frame, compare_color))
            });

            // SAFETY: one texture name is read.
            unsafe { gl.delete_textures(1, &texture) };
            let is_ok = result?;
            return if is_ok {
                Ok(TestStatus::pass("Pass"))
            } else {
                Ok(TestStatus::fail("Image comparison failed"))
            };
        }

        let offset_x = random.get_int(0, 0.max(render_target.width - 64));
        let offset_y = random.get_int(0, 0.max(render_target.height - 64));
        let mut all_faces_ok = true;

        let mut texture = 0u32;
        // SAFETY: one texture name is written.
        unsafe { gl.gen_textures(1, &mut texture) };
        let compare_color = self.create_texture(context, texture);

        let result = compare_color.and_then(|compare_color| {
            for &face in &FACES {
                let tex_coord = compute_quad_tex_coord_cube(face);
                // SAFETY: plain state setting on the current context.
                unsafe { gl.viewport(offset_x, offset_y, viewport_width, viewport_height) };
                renderer.render_quad(0, &tex_coord, &RenderParams::new(TextureType::Cube))?;
                read_pixels(render_ctx, offset_x, offset_y, &mut rendered_frame.get_access())?;
                if !compare_to_constant_color(&rendered_frame, compare_color) {
                    all_faces_ok = false;
                }
            }
            Ok(())
        });

        // SAFETY: one texture name is read.
        unsafe { gl.delete_textures(1, &texture) };
        result?;
        if all_faces_ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Image comparison failed"))
        }
    }
}

/// `TextureCompletenessTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("completeness");
    let mut tex2d = TestCaseGroup::new("2d");
    let mut cube = TestCaseGroup::new("cube");
    let case = |name: &str, spec: Spec| {
        Box::new(CompletenessCase {
            name: name.to_string(),
            spec,
        }) as Box<dyn TestCase>
    };

    // Texture 2D size.
    tex2d.add_child(case(
        "npot_size",
        Spec::Size2D {
            size: (255, 255),
            invalid_level_size: (255, 255),
            invalid_level_ndx: 0,
        },
    ));
    tex2d.add_child(case(
        "npot_size_level_0",
        Spec::Size2D {
            size: (256, 256),
            invalid_level_size: (255, 255),
            invalid_level_ndx: 0,
        },
    ));
    tex2d.add_child(case(
        "npot_size_level_1",
        Spec::Size2D {
            size: (256, 256),
            invalid_level_size: (127, 127),
            invalid_level_ndx: 1,
        },
    ));
    tex2d.add_child(case(
        "not_positive_level_0",
        Spec::Size2D {
            size: (256, 256),
            invalid_level_size: (0, 0),
            invalid_level_ndx: 0,
        },
    ));

    // Texture 2D format.
    tex2d.add_child(case(
        "format_mismatch_rgb_rgba",
        Spec::Format2D {
            size: (128, 128),
            format: glw::GL_RGB,
            invalid_format: glw::GL_RGBA,
            invalid_level_ndx: 1,
        },
    ));
    tex2d.add_child(case(
        "format_mismatch_rgba_rgb",
        Spec::Format2D {
            size: (128, 128),
            format: glw::GL_RGBA,
            invalid_format: glw::GL_RGB,
            invalid_level_ndx: 1,
        },
    ));
    tex2d.add_child(case(
        "format_mismatch_luminance_luminance_alpha",
        Spec::Format2D {
            size: (128, 128),
            format: glw::GL_LUMINANCE,
            invalid_format: glw::GL_LUMINANCE_ALPHA,
            invalid_level_ndx: 1,
        },
    ));
    tex2d.add_child(case(
        "format_mismatch_luminance_alpha_luminance",
        Spec::Format2D {
            size: (128, 128),
            format: glw::GL_LUMINANCE_ALPHA,
            invalid_format: glw::GL_LUMINANCE,
            invalid_level_ndx: 1,
        },
    ));

    // Texture 2D missing level.
    tex2d.add_child(case(
        "missing_level_1",
        Spec::MissingLevel2D {
            size: (128, 128),
            missing_level_ndx: 1,
        },
    ));
    tex2d.add_child(case(
        "missing_level_3",
        Spec::MissingLevel2D {
            size: (128, 128),
            missing_level_ndx: 3,
        },
    ));
    tex2d.add_child(case(
        "last_level_missing",
        Spec::MissingLevel2D {
            size: (128, 64),
            missing_level_ndx: log2_floor(128).max(log2_floor(64)),
        },
    ));

    // Texture 2D wrap modes.
    tex2d.add_child(case(
        "npot_t_repeat",
        Spec::WrapMode2D {
            size: (127, 127),
            wrap_t: glw::GL_CLAMP_TO_EDGE,
            wrap_s: glw::GL_REPEAT,
        },
    ));
    tex2d.add_child(case(
        "npot_s_repeat",
        Spec::WrapMode2D {
            size: (127, 127),
            wrap_t: glw::GL_REPEAT,
            wrap_s: glw::GL_CLAMP_TO_EDGE,
        },
    ));
    tex2d.add_child(case(
        "npot_all_repeat",
        Spec::WrapMode2D {
            size: (127, 127),
            wrap_t: glw::GL_REPEAT,
            wrap_s: glw::GL_REPEAT,
        },
    ));
    tex2d.add_child(case(
        "npot_mirrored_repeat",
        Spec::WrapMode2D {
            size: (127, 127),
            wrap_t: glw::GL_MIRRORED_REPEAT,
            wrap_s: glw::GL_MIRRORED_REPEAT,
        },
    ));
    tex2d.add_child(case(
        "repeat_width_npot",
        Spec::WrapMode2D {
            size: (127, 128),
            wrap_t: glw::GL_REPEAT,
            wrap_s: glw::GL_REPEAT,
        },
    ));
    tex2d.add_child(case(
        "repeat_height_npot",
        Spec::WrapMode2D {
            size: (128, 127),
            wrap_t: glw::GL_REPEAT,
            wrap_s: glw::GL_REPEAT,
        },
    ));

    // Texture 2D extra level.
    tex2d.add_child(case("extra_level", Spec::ExtraLevel2D { size: (64, 64) }));

    // Texture 2D empty object.
    tex2d.add_child(case("empty_object", Spec::EmptyObject2D));

    // Cube size.
    cube.add_child(case(
        "npot_size_level_0",
        Spec::SizeCube {
            size: (64, 64),
            invalid_level_size: (63, 63),
            invalid_level_ndx: 0,
            invalid_face: None,
        },
    ));
    cube.add_child(case(
        "npot_size_level_1",
        Spec::SizeCube {
            size: (64, 64),
            invalid_level_size: (31, 31),
            invalid_level_ndx: 1,
            invalid_face: None,
        },
    ));
    cube.add_child(case(
        "npot_size_level_0_pos_x",
        Spec::SizeCube {
            size: (64, 64),
            invalid_level_size: (63, 63),
            invalid_level_ndx: 0,
            invalid_face: Some(1),
        },
    ));
    cube.add_child(case(
        "npot_size_level_1_neg_x",
        Spec::SizeCube {
            size: (64, 64),
            invalid_level_size: (31, 31),
            invalid_level_ndx: 1,
            invalid_face: Some(0),
        },
    ));
    cube.add_child(case(
        "not_positive_level_0",
        Spec::SizeCube {
            size: (64, 64),
            invalid_level_size: (0, 0),
            invalid_level_ndx: 0,
            invalid_face: None,
        },
    ));

    // Cube format.
    cube.add_child(case(
        "format_mismatch_rgb_rgba_level_0",
        Spec::FormatCube {
            size: (64, 64),
            format: glw::GL_RGB,
            invalid_format: glw::GL_RGBA,
            invalid_face: None,
        },
    ));
    cube.add_child(case(
        "format_mismatch_rgba_rgb_level_0",
        Spec::FormatCube {
            size: (64, 64),
            format: glw::GL_RGBA,
            invalid_format: glw::GL_RGB,
            invalid_face: None,
        },
    ));
    cube.add_child(case(
        "format_mismatch_luminance_luminance_alpha_level_0",
        Spec::FormatCube {
            size: (64, 64),
            format: glw::GL_LUMINANCE,
            invalid_format: glw::GL_LUMINANCE_ALPHA,
            invalid_face: None,
        },
    ));
    cube.add_child(case(
        "format_mismatch_luminance_alpha_luminance_level_0",
        Spec::FormatCube {
            size: (64, 64),
            format: glw::GL_LUMINANCE_ALPHA,
            invalid_format: glw::GL_LUMINANCE,
            invalid_face: None,
        },
    ));
    cube.add_child(case(
        "format_mismatch_rgb_rgba_level_0_pos_z",
        Spec::FormatCube {
            size: (64, 64),
            format: glw::GL_RGB,
            invalid_format: glw::GL_RGBA,
            invalid_face: Some(5),
        },
    ));
    cube.add_child(case(
        "format_mismatch_rgba_rgb_level_0_neg_z",
        Spec::FormatCube {
            size: (64, 64),
            format: glw::GL_RGBA,
            invalid_format: glw::GL_RGB,
            invalid_face: Some(4),
        },
    ));

    // Cube missing level.
    cube.add_child(case(
        "missing_level_1",
        Spec::MissingLevelCube {
            size: (64, 64),
            invalid_level_ndx: 1,
            invalid_face: None,
        },
    ));
    cube.add_child(case(
        "missing_level_3",
        Spec::MissingLevelCube {
            size: (64, 64),
            invalid_level_ndx: 3,
            invalid_face: None,
        },
    ));
    cube.add_child(case(
        "missing_level_1_pos_y",
        Spec::MissingLevelCube {
            size: (64, 64),
            invalid_level_ndx: 1,
            invalid_face: Some(3),
        },
    ));
    cube.add_child(case(
        "missing_level_3_neg_y",
        Spec::MissingLevelCube {
            size: (64, 64),
            invalid_level_ndx: 3,
            invalid_face: Some(2),
        },
    ));

    // Cube wrap modes.
    cube.add_child(case(
        "npot_t_repeat",
        Spec::WrapModeCube {
            size: (127, 127),
            wrap_t: glw::GL_CLAMP_TO_EDGE,
            wrap_s: glw::GL_REPEAT,
        },
    ));
    cube.add_child(case(
        "npot_s_repeat",
        Spec::WrapModeCube {
            size: (127, 127),
            wrap_t: glw::GL_REPEAT,
            wrap_s: glw::GL_CLAMP_TO_EDGE,
        },
    ));
    cube.add_child(case(
        "npot_all_repeat",
        Spec::WrapModeCube {
            size: (127, 127),
            wrap_t: glw::GL_REPEAT,
            wrap_s: glw::GL_REPEAT,
        },
    ));
    cube.add_child(case(
        "npot_mirrored_repeat",
        Spec::WrapModeCube {
            size: (127, 127),
            wrap_t: glw::GL_MIRRORED_REPEAT,
            wrap_s: glw::GL_MIRRORED_REPEAT,
        },
    ));

    // Cube extra level.
    cube.add_child(case("extra_level", Spec::ExtraLevelCube { size: (64, 64) }));

    // Cube empty object.
    cube.add_child(case("empty_object", Spec::EmptyObjectCube));

    group.add_child(tex2d);
    group.add_child(cube);
    group
}
