// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fFboCompletenessTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The format tables are upstream's,
// entry for entry and in its order - `ImageFormat` ordering decides the order the
// `renderable.*` cases are registered in, so an omission moves case names around
// rather than only dropping one.

use std::sync::Arc;

use crate::gls::fbo_completeness_tests::{self as fboc, BuildCtx, FbocContext, MultiColorAtts};
use crate::gls::fbo_util::{
    Attachment, COLOR_RENDERABLE, Checker, CheckerState, DEPTH_RENDERABLE, FboBuilder, FormatDb, FormatEntry,
    FormatExtEntry, Image, ImageFormat, RENDERBUFFER_VALID, REQUIRED_RENDERABLE, STENCIL_RENDERABLE, TEXTURE_VALID,
    check_extension_support,
};
use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLsizei};
use crate::tcu::{TestOutcome, TestStatus};

const fn sized(format: GLenum) -> ImageFormat {
    ImageFormat::sized(format)
}

const fn unsized_format(format: GLenum, unsized_type: GLenum) -> ImageFormat {
    ImageFormat::unsized_format(format, unsized_type)
}

const ES2_COLOR_RENDERABLES: &[ImageFormat] = &[sized(glw::GL_RGBA4), sized(glw::GL_RGB5_A1), sized(glw::GL_RGB565)];

// GLES2 does not strictly allow these, but this seems to be a bug in the specification.
// For now, let's assume the unsized formats corresponding to the color-renderable sized
// formats are allowed. See https://cvs.khronos.org/bugzilla/show_bug.cgi?id=7333
const ES2_UNSIZED_COLOR_RENDERABLES: &[ImageFormat] = &[
    unsized_format(glw::GL_RGBA, glw::GL_UNSIGNED_SHORT_4_4_4_4),
    unsized_format(glw::GL_RGBA, glw::GL_UNSIGNED_SHORT_5_5_5_1),
    unsized_format(glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_6_5),
];

const ES2_DEPTH_RENDERABLES: &[ImageFormat] = &[sized(glw::GL_DEPTH_COMPONENT16)];

const ES2_STENCIL_RENDERABLES: &[ImageFormat] = &[sized(glw::GL_STENCIL_INDEX8)];

static ES2_FORMATS: &[FormatEntry] = &[
    FormatEntry {
        flags: COLOR_RENDERABLE | TEXTURE_VALID,
        formats: ES2_UNSIZED_COLOR_RENDERABLES,
    },
    FormatEntry {
        flags: REQUIRED_RENDERABLE | COLOR_RENDERABLE | RENDERBUFFER_VALID,
        formats: ES2_COLOR_RENDERABLES,
    },
    FormatEntry {
        flags: REQUIRED_RENDERABLE | DEPTH_RENDERABLE | RENDERBUFFER_VALID,
        formats: ES2_DEPTH_RENDERABLES,
    },
    FormatEntry {
        flags: REQUIRED_RENDERABLE | STENCIL_RENDERABLE | RENDERBUFFER_VALID,
        formats: ES2_STENCIL_RENDERABLES,
    },
];

// Only the extensions that are redundant in vanilla GLES3 live here; the ones applicable
// to both GLES2 and GLES3 are in `gls::fbo_completeness_tests`.

// GL_OES_texture_float
const OES_TEXTURE_FLOAT_FORMATS: &[ImageFormat] = &[
    unsized_format(glw::GL_RGBA, glw::GL_FLOAT),
    unsized_format(glw::GL_RGB, glw::GL_FLOAT),
];

// GL_OES_texture_half_float
const OES_TEXTURE_HALF_FLOAT_FORMATS: &[ImageFormat] = &[
    unsized_format(glw::GL_RGBA, glw::GL_HALF_FLOAT_OES),
    unsized_format(glw::GL_RGB, glw::GL_HALF_FLOAT_OES),
];

// GL_EXT_color_buffer_half_float
const EXT_COLOR_BUFFER_HALF_FLOAT_UNSIZED_REQUIRED: &[ImageFormat] =
    &[unsized_format(glw::GL_RGBA, glw::GL_HALF_FLOAT_OES)];

const EXT_COLOR_BUFFER_HALF_FLOAT_UNSIZED: &[ImageFormat] = &[
    unsized_format(glw::GL_RED, glw::GL_HALF_FLOAT_OES),
    unsized_format(glw::GL_RG, glw::GL_HALF_FLOAT_OES),
    unsized_format(glw::GL_RGB, glw::GL_HALF_FLOAT_OES),
    unsized_format(glw::GL_RGBA, glw::GL_HALF_FLOAT_OES),
];

// GL_EXT_sRGB_write_control
const EXT_SRGB_WRITE_CONTROL_FORMATS: &[ImageFormat] = &[sized(glw::GL_SRGB8_ALPHA8)];

// DEQP_gles3_core_no_extension_features
const ES3_NO_EXT_RBO_FORMATS: &[ImageFormat] = &[sized(glw::GL_RGB10_A2), sized(glw::GL_SRGB8_ALPHA8)];

const ES3_NO_EXT_TEXTURE_FORMATS: &[ImageFormat] = &[
    sized(glw::GL_R16F),
    sized(glw::GL_RG16F),
    sized(glw::GL_RGB16F),
    sized(glw::GL_RGBA16F),
    sized(glw::GL_R11F_G11F_B10F),
];

const ES3_NO_EXT_TEXTURE_COLOR_RENDERABLE_FORMATS: &[ImageFormat] = &[
    sized(glw::GL_R8),
    sized(glw::GL_RG8),
    sized(glw::GL_RGB8),
    sized(glw::GL_RGBA4),
    sized(glw::GL_RGB5_A1),
    sized(glw::GL_RGBA8),
    sized(glw::GL_RGB10_A2),
    sized(glw::GL_RGB565),
    sized(glw::GL_SRGB8_ALPHA8),
];

// With ES3 core and GL_EXT_color_buffer_float. Only the GLES2+exts subset of formats.
const ES3_NO_EXT_EXT_COLOR_BUFFER_FLOAT_FORMATS: &[ImageFormat] = &[
    sized(glw::GL_R11F_G11F_B10F),
    sized(glw::GL_RGBA16F),
    sized(glw::GL_RG16F),
    sized(glw::GL_R16F),
];

// With ES3 core and GL_OES_texture_stencil8.
const ES3_NO_EXT_OES_TEXTURE_STENCIL8_FORMATS: &[ImageFormat] = &[sized(glw::GL_STENCIL_INDEX8)];

// DEQP_gles3_core_changed_features
const ES3_NO_EXT_DEPTH_RENDERABLE: &[ImageFormat] = &[
    sized(glw::GL_DEPTH_COMPONENT16),
    sized(glw::GL_DEPTH_COMPONENT24),
    sized(glw::GL_DEPTH24_STENCIL8),
];

const ES3_NO_EXT_STENCIL_RENDERABLE: &[ImageFormat] = &[sized(glw::GL_DEPTH24_STENCIL8)];

static ES2_EXT_FORMATS: &[FormatExtEntry] = &[
    // The extension does not specify these to be color-renderable.
    FormatExtEntry {
        extensions: "GL_OES_texture_float",
        flags: TEXTURE_VALID,
        formats: OES_TEXTURE_FLOAT_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_OES_texture_half_float",
        flags: TEXTURE_VALID,
        formats: OES_TEXTURE_HALF_FLOAT_FORMATS,
    },
    // GL_EXT_color_buffer_half_float does say explicitly that the RGBA variant should be
    // renderable with GL_OES_texture_half_float, and other variants can be renderable.
    FormatExtEntry {
        extensions: "GL_OES_texture_half_float GL_EXT_color_buffer_half_float",
        flags: REQUIRED_RENDERABLE | COLOR_RENDERABLE,
        formats: EXT_COLOR_BUFFER_HALF_FLOAT_UNSIZED_REQUIRED,
    },
    FormatExtEntry {
        extensions: "GL_EXT_color_buffer_half_float",
        flags: COLOR_RENDERABLE,
        formats: EXT_COLOR_BUFFER_HALF_FLOAT_UNSIZED,
    },
    // GL_EXT_sRGB_write_control makes SRGB8_ALPHA8 color-renderable.
    FormatExtEntry {
        extensions: "GL_EXT_sRGB_write_control",
        flags: REQUIRED_RENDERABLE | TEXTURE_VALID | COLOR_RENDERABLE | RENDERBUFFER_VALID,
        formats: EXT_SRGB_WRITE_CONTROL_FORMATS,
    },
    // Since GLES3 is "backwards compatible" to GLES2, we might actually be running on a
    // GLES3 context. GLES3 added features to core with no corresponding GLES2 extension,
    // so some tests would produce wrong results (they use the rules of GLES2 and its
    // extensions). The `DEQP_*` pseudo-extensions require those features when the
    // context really is GLES3. Not all feature changes are listed - only those that
    // alter the GLES2 subset of the formats.
    FormatExtEntry {
        extensions: "DEQP_gles3_core_compatible",
        flags: REQUIRED_RENDERABLE | COLOR_RENDERABLE | RENDERBUFFER_VALID,
        formats: ES3_NO_EXT_RBO_FORMATS,
    },
    FormatExtEntry {
        extensions: "DEQP_gles3_core_compatible",
        flags: TEXTURE_VALID,
        formats: ES3_NO_EXT_TEXTURE_FORMATS,
    },
    FormatExtEntry {
        extensions: "DEQP_gles3_core_compatible",
        flags: REQUIRED_RENDERABLE | TEXTURE_VALID | COLOR_RENDERABLE | RENDERBUFFER_VALID,
        formats: ES3_NO_EXT_TEXTURE_COLOR_RENDERABLE_FORMATS,
    },
    FormatExtEntry {
        extensions: "DEQP_gles3_core_compatible GL_EXT_color_buffer_float",
        flags: REQUIRED_RENDERABLE | COLOR_RENDERABLE | RENDERBUFFER_VALID,
        formats: ES3_NO_EXT_EXT_COLOR_BUFFER_FLOAT_FORMATS,
    },
    FormatExtEntry {
        extensions: "DEQP_gles3_core_compatible GL_OES_texture_stencil8",
        flags: REQUIRED_RENDERABLE | STENCIL_RENDERABLE | TEXTURE_VALID,
        formats: ES3_NO_EXT_OES_TEXTURE_STENCIL8_FORMATS,
    },
    FormatExtEntry {
        extensions: "DEQP_gles3_core_compatible GL_OES_texture_half_float GL_EXT_color_buffer_half_float",
        flags: REQUIRED_RENDERABLE | COLOR_RENDERABLE,
        formats: OES_TEXTURE_HALF_FLOAT_FORMATS,
    },
    FormatExtEntry {
        extensions: "DEQP_gles3_core_compatible",
        flags: REQUIRED_RENDERABLE | DEPTH_RENDERABLE | RENDERBUFFER_VALID | TEXTURE_VALID,
        formats: ES3_NO_EXT_DEPTH_RENDERABLE,
    },
    FormatExtEntry {
        extensions: "DEQP_gles3_core_compatible",
        flags: REQUIRED_RENDERABLE | STENCIL_RENDERABLE | RENDERBUFFER_VALID | TEXTURE_VALID,
        formats: ES3_NO_EXT_STENCIL_RENDERABLE,
    },
];

/// `ES2Checker`
#[derive(Default)]
struct Es2Checker {
    /// The common width and height of images, `None` until the first one is seen.
    size: Option<(GLsizei, GLsizei)>,
}

impl Checker for Es2Checker {
    fn check(
        &mut self,
        state: &mut CheckerState,
        context: &Context,
        _formats: &FormatDb,
        _att_point: GLenum,
        _att: &Attachment,
        image: &Image,
    ) {
        // GLES2: "All attached images have the same width and height."
        match self.size {
            None => self.size = Some((image.width(), image.height())),
            Some((width, height)) => {
                if image.width() != width || image.height() != height {
                    // Since GLES3 is "backwards compatible" to GLES2, we might actually
                    // be running on a GLES3 context, where
                    // FRAMEBUFFER_INCOMPLETE_DIMENSIONS is not generated for attachments
                    // of different sizes.
                    if !check_extension_support(context, "DEQP_gles3_core_compatible") {
                        state.add_fbo_status(glw::GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS);
                    }
                }
            }
        }

        // GLES2, 4.4.5: "some implementations may not support rendering to particular
        // combinations of internal formats. If the combination of formats of the images
        // attached to a framebuffer object are not supported by the implementation, then
        // the framebuffer is not complete under the clause labeled
        // FRAMEBUFFER_UNSUPPORTED." Hence it is _always_ allowed to report it.
        state.add_potential_fbo_status(glw::GL_FRAMEBUFFER_UNSUPPORTED);
    }
}

fn make_checker() -> Box<dyn Checker> {
    Box::<Es2Checker>::default()
}

/// `SupportedCombinationTest` - the one case here that overrides `iterate` rather than
/// `build`, because it tries combinations until one of them is complete.
struct SupportedCombinationTest {
    fboc: Arc<FbocContext>,
}

impl SupportedCombinationTest {
    /// `SupportedCombinationTest::formatKind`
    fn format_kind(&self, fmt: ImageFormat) -> GLenum {
        if fmt.format == glw::GL_NONE {
            return glw::GL_NONE;
        }

        let flags = self.fboc.core_formats.format_info(fmt);
        let rbo = flags & RENDERBUFFER_VALID != 0;
        // Exactly one of renderbuffer and texture is supported by vanilla GLES2 formats.
        debug_assert_eq!(rbo, flags & TEXTURE_VALID == 0);

        if rbo { glw::GL_RENDERBUFFER } else { glw::GL_TEXTURE }
    }

    /// `SupportedCombinationTest::tryCombination`
    fn try_combination(&self, bc: &BuildCtx, color: ImageFormat, depth: ImageFormat, stencil: ImageFormat) -> bool {
        let gl = bc.gl();
        let fbo = glu::Framebuffer::new(gl);
        let mut builder = FboBuilder::new(gl, fbo.get(), glw::GL_FRAMEBUFFER);

        for (att_point, format) in [
            (glw::GL_COLOR_ATTACHMENT0, color),
            (glw::GL_DEPTH_ATTACHMENT, depth),
            (glw::GL_STENCIL_ATTACHMENT, stencil),
        ] {
            if bc
                .attach_target_to_new(att_point, self.format_kind(format), format, 64, 64, &mut builder)
                .is_err()
            {
                return false;
            }
        }

        // SAFETY: the framebuffer built above is still bound.
        unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) == glw::GL_FRAMEBUFFER_COMPLETE }
    }
}

impl TestCase for SupportedCombinationTest {
    fn name(&self) -> &str {
        "exists_supported"
    }

    /// `SupportedCombinationTest::iterate`
    fn iterate(&self, context: &Context) -> TestOutcome {
        let ctx_formats = self.fboc.ctx_formats(context);
        let bc = BuildCtx {
            fboc: &self.fboc,
            ctx_formats: &ctx_formats,
            context,
        };

        let db = &self.fboc.core_formats;
        let none = ImageFormat::none();
        // `none` sorts first: `GL_NONE` is 0 and `Formats` is an ordered set.
        let with_none = |mut formats: Vec<ImageFormat>| {
            formats.insert(0, none);
            formats
        };
        let color_fmts = with_none(db.formats(COLOR_RENDERABLE));
        let depth_fmts = with_none(db.formats(DEPTH_RENDERABLE));
        let stencil_fmts = with_none(db.formats(STENCIL_RENDERABLE));

        // Upstream's loop only breaks out of the innermost level, so it keeps trying
        // combinations after the first success and reports the last one's result.
        let mut succ = false;
        for color in &color_fmts {
            for depth in &depth_fmts {
                for stencil in &stencil_fmts {
                    succ = self.try_combination(&bc, *color, *depth, *stencil);
                    if succ {
                        break;
                    }
                }
            }
        }

        if succ {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("No supported format combination found"))
        }
    }
}

/// `TestGroup::init`
pub fn create_tests() -> TestCaseGroup {
    let fboc = Arc::new(FbocContext::new(
        &[ES2_FORMATS],
        &[fboc::ES_EXT_FORMATS, ES2_EXT_FORMATS],
        MultiColorAtts::Extension("GL_NV_fbo_color_attachments"),
        make_checker,
    ));

    let mut group = TestCaseGroup::new("completeness");
    group.add_child(fboc::create_renderable_tests(&fboc));

    let mut att_comb_tests = fboc::create_attachment_tests(&fboc);
    att_comb_tests.add_child(Box::new(SupportedCombinationTest {
        fboc: Arc::clone(&fboc),
    }) as Box<dyn TestCase>);
    group.add_child(att_comb_tests);

    group.add_child(fboc::create_size_tests(&fboc));
    group
}
