// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsFboCompletenessTests.hpp / .cpp  (gls::fboc::)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream builds the whole case tree inside a live GL context, so its `fboc::Context`
// can hold `m_ctxFormats` - the format database filtered by the extensions this driver
// actually has. Here the tree is built with no driver at all, so `ctx_formats` is
// recomputed per case from the same static tables instead. Nothing is registered off
// it: `createRenderableTests` reads `m_allFormats` (every extension counted as present)
// and `getDefaultFormat` reads it at run time, inside `iterate`, where a context exists.
//
// `logFormatInfo`/`logFramebufferConfig` are not ported - they write to upstream's
// structured log, which this port does not have, and they decide nothing.

use std::sync::Arc;

use crate::gls::fbo_util::{
    ANY_FORMAT, Attachment, COLOR_RENDERABLE, Checker, DEPTH_RENDERABLE, FboBuilder, FormatDb, FormatEntry,
    FormatExtEntry, Image, ImageFormat, RENDERBUFFER_VALID, REQUIRED_RENDERABLE, STENCIL_RENDERABLE, TEXTURE_VALID,
    add_ext_formats, add_formats, format_flag, valid_status_codes,
};
use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLsizei};
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};

const fn sized(format: GLenum) -> ImageFormat {
    ImageFormat::sized(format)
}

const fn unsized_format(format: GLenum, unsized_type: GLenum) -> ImageFormat {
    ImageFormat::unsized_format(format, unsized_type)
}

// The extensions below are applicable both to ES2 and ES3.

// GL_OES_depth_texture
const OES_DEPTH_TEXTURE_FORMATS: &[ImageFormat] = &[
    unsized_format(glw::GL_DEPTH_COMPONENT, glw::GL_UNSIGNED_SHORT),
    unsized_format(glw::GL_DEPTH_COMPONENT, glw::GL_UNSIGNED_INT),
];

// GL_OES_packed_depth_stencil
const OES_PACKED_DEPTH_STENCIL_SIZED_FORMATS: &[ImageFormat] = &[sized(glw::GL_DEPTH24_STENCIL8)];
const OES_PACKED_DEPTH_STENCIL_TEX_FORMATS: &[ImageFormat] =
    &[unsized_format(glw::GL_DEPTH_STENCIL, glw::GL_UNSIGNED_INT_24_8)];

// GL_OES_required_internalformat - the same as the ES2 RBO formats, plus RGBA8 (even
// without OES_rgb8_rgba8).
const OES_REQUIRED_INTERNAL_FORMAT_COLOR_FORMATS: &[ImageFormat] = &[
    sized(glw::GL_RGB5_A1),
    sized(glw::GL_RGBA8),
    sized(glw::GL_RGBA4),
    sized(glw::GL_RGB565),
];

const OES_REQUIRED_INTERNAL_FORMAT_DEPTH_FORMATS: &[ImageFormat] = &[sized(glw::GL_DEPTH_COMPONENT16)];

// GL_EXT_color_buffer_half_float
const EXT_COLOR_BUFFER_HALF_FLOAT_FORMATS: &[ImageFormat] = &[
    sized(glw::GL_RGBA16F),
    sized(glw::GL_RGB16F),
    sized(glw::GL_RG16F),
    sized(glw::GL_R16F),
];

const OES_DEPTH24_SIZED_FORMATS: &[ImageFormat] = &[sized(glw::GL_DEPTH_COMPONENT24)];
const OES_DEPTH32_SIZED_FORMATS: &[ImageFormat] = &[sized(glw::GL_DEPTH_COMPONENT32)];

const OES_RGB8_RGBA8_RBO_FORMATS: &[ImageFormat] = &[sized(glw::GL_RGB8), sized(glw::GL_RGBA8)];

const OES_REQUIRED_INTERNAL_FORMAT_RGB8_COLOR_FORMAT: &[ImageFormat] = &[sized(glw::GL_RGB8)];

const EXT_TEXTURE_TYPE_2101010_REV_FORMATS: &[ImageFormat] = &[
    unsized_format(glw::GL_RGBA, glw::GL_UNSIGNED_INT_2_10_10_10_REV),
    unsized_format(glw::GL_RGB, glw::GL_UNSIGNED_INT_2_10_10_10_REV),
];

const OES_REQUIRED_INTERNAL_FORMAT_10BIT_COLOR_FORMATS: &[ImageFormat] =
    &[sized(glw::GL_RGB10_A2), sized(glw::GL_RGB10)];

const EXT_TEXTURE_RG_RBO_FORMATS: &[ImageFormat] = &[sized(glw::GL_R8), sized(glw::GL_RG8)];

const EXT_TEXTURE_RG_TEX_FORMATS: &[ImageFormat] = &[
    unsized_format(glw::GL_RED, glw::GL_UNSIGNED_BYTE),
    unsized_format(glw::GL_RG, glw::GL_UNSIGNED_BYTE),
];

const EXT_TEXTURE_RG_FLOAT_TEX_FORMATS: &[ImageFormat] = &[
    unsized_format(glw::GL_RED, glw::GL_FLOAT),
    unsized_format(glw::GL_RG, glw::GL_FLOAT),
];

const EXT_TEXTURE_RG_HALF_FLOAT_TEX_FORMATS: &[ImageFormat] = &[
    unsized_format(glw::GL_RED, glw::GL_HALF_FLOAT_OES),
    unsized_format(glw::GL_RG, glw::GL_HALF_FLOAT_OES),
];

const NV_PACKED_FLOAT_RBO_FORMATS: &[ImageFormat] = &[sized(glw::GL_R11F_G11F_B10F)];
const NV_PACKED_FLOAT_TEX_FORMATS: &[ImageFormat] =
    &[unsized_format(glw::GL_RGB, glw::GL_UNSIGNED_INT_10F_11F_11F_REV)];

const EXT_SRGB_RBO_FORMATS: &[ImageFormat] = &[sized(glw::GL_SRGB8_ALPHA8)];
const EXT_SRGB_RENDERABLE_TEX_FORMATS: &[ImageFormat] = &[unsized_format(glw::GL_SRGB_ALPHA, glw::GL_UNSIGNED_BYTE)];
const EXT_SRGB_NON_RENDERABLE_TEX_FORMATS: &[ImageFormat] = &[unsized_format(glw::GL_SRGB, glw::GL_UNSIGNED_BYTE)];

const NV_SRGB_FORMATS_RBO_FORMATS: &[ImageFormat] = &[sized(glw::GL_SRGB8)];

// The extension does not actually require any unsized format to be renderable, but the
// renderability of the unsized SRGB,UBYTE internalformat-type pair is implied.
const NV_SRGB_FORMATS_TEXTURE_FORMATS: &[ImageFormat] = &[
    sized(glw::GL_SRGB8),
    unsized_format(glw::GL_SRGB, glw::GL_UNSIGNED_BYTE),
];

const OES_RGB8_RGBA8_TEX_FORMATS: &[ImageFormat] = &[
    unsized_format(glw::GL_RGB, glw::GL_UNSIGNED_BYTE),
    unsized_format(glw::GL_RGBA, glw::GL_UNSIGNED_BYTE),
];

const EXT_TEXTURE_SRGB_R8_FORMATS: &[ImageFormat] = &[sized(glw::GL_SR8_EXT)];
const EXT_TEXTURE_SRGB_RG8_FORMATS: &[ImageFormat] = &[sized(glw::GL_SRG8_EXT)];
const QCOM_RENDER_SRGB_R8_RG8_FORMATS: &[ImageFormat] = &[sized(glw::GL_SR8_EXT), sized(glw::GL_SRG8_EXT)];

const EXT_TEXTURE_FORMAT_BGRA8888_FORMATS: &[ImageFormat] = &[sized(glw::GL_BGRA), sized(glw::GL_BGRA8_EXT)];

/// `fboc::s_esExtFormats` - the extension formats both ES2 and ES3 add to their own.
pub static ES_EXT_FORMATS: &[FormatExtEntry] = &[
    FormatExtEntry {
        extensions: "GL_OES_depth_texture",
        flags: REQUIRED_RENDERABLE | DEPTH_RENDERABLE | TEXTURE_VALID,
        formats: OES_DEPTH_TEXTURE_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_OES_packed_depth_stencil",
        flags: REQUIRED_RENDERABLE | DEPTH_RENDERABLE | STENCIL_RENDERABLE | RENDERBUFFER_VALID,
        formats: OES_PACKED_DEPTH_STENCIL_SIZED_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_OES_packed_depth_stencil GL_OES_required_internalformat",
        flags: TEXTURE_VALID,
        formats: OES_PACKED_DEPTH_STENCIL_SIZED_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_OES_packed_depth_stencil GL_OES_depth_texture",
        flags: DEPTH_RENDERABLE | STENCIL_RENDERABLE | TEXTURE_VALID,
        formats: OES_PACKED_DEPTH_STENCIL_TEX_FORMATS,
    },
    // The ANGLE extension incorporates GL_OES_depth_texture/GL_OES_packed_depth_stencil.
    FormatExtEntry {
        extensions: "GL_ANGLE_depth_texture",
        flags: REQUIRED_RENDERABLE | DEPTH_RENDERABLE | TEXTURE_VALID,
        formats: OES_DEPTH_TEXTURE_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_OES_packed_depth_stencil GL_ANGLE_depth_texture",
        flags: DEPTH_RENDERABLE | STENCIL_RENDERABLE | TEXTURE_VALID,
        formats: OES_PACKED_DEPTH_STENCIL_TEX_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_OES_texture_half_float GL_EXT_color_buffer_half_float",
        flags: REQUIRED_RENDERABLE | COLOR_RENDERABLE | RENDERBUFFER_VALID,
        formats: EXT_COLOR_BUFFER_HALF_FLOAT_FORMATS,
    },
    // OES_required_internalformat doesn't actually specify that these are renderable,
    // since it was written against ES 1.1. Allow but don't require RGBA8 to be
    // color-renderable if OES_rgb8_rgba8 is not present.
    FormatExtEntry {
        extensions: "GL_OES_required_internalformat",
        flags: COLOR_RENDERABLE | TEXTURE_VALID,
        formats: OES_REQUIRED_INTERNAL_FORMAT_COLOR_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_OES_required_internalformat",
        flags: DEPTH_RENDERABLE | TEXTURE_VALID,
        formats: OES_REQUIRED_INTERNAL_FORMAT_DEPTH_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_EXT_texture_rg",
        flags: REQUIRED_RENDERABLE | COLOR_RENDERABLE | RENDERBUFFER_VALID | TEXTURE_VALID,
        formats: EXT_TEXTURE_RG_RBO_FORMATS,
    },
    // These are not specified to be color-renderable, but the wording is exactly as
    // ambiguous as the wording in the ES2 spec.
    FormatExtEntry {
        extensions: "GL_EXT_texture_rg",
        flags: COLOR_RENDERABLE | TEXTURE_VALID,
        formats: EXT_TEXTURE_RG_TEX_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_EXT_texture_rg GL_OES_texture_float",
        flags: COLOR_RENDERABLE | TEXTURE_VALID,
        formats: EXT_TEXTURE_RG_FLOAT_TEX_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_EXT_texture_rg GL_OES_texture_half_float",
        flags: COLOR_RENDERABLE | TEXTURE_VALID,
        formats: EXT_TEXTURE_RG_HALF_FLOAT_TEX_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_NV_packed_float",
        flags: COLOR_RENDERABLE | TEXTURE_VALID,
        formats: NV_PACKED_FLOAT_TEX_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_NV_packed_float GL_EXT_color_buffer_half_float",
        flags: REQUIRED_RENDERABLE | COLOR_RENDERABLE | RENDERBUFFER_VALID,
        formats: NV_PACKED_FLOAT_RBO_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_EXT_sRGB",
        flags: COLOR_RENDERABLE | TEXTURE_VALID,
        formats: EXT_SRGB_RENDERABLE_TEX_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_EXT_sRGB",
        flags: TEXTURE_VALID,
        formats: EXT_SRGB_NON_RENDERABLE_TEX_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_EXT_sRGB",
        flags: REQUIRED_RENDERABLE | COLOR_RENDERABLE | RENDERBUFFER_VALID,
        formats: EXT_SRGB_RBO_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_NV_sRGB_formats",
        flags: REQUIRED_RENDERABLE | COLOR_RENDERABLE | RENDERBUFFER_VALID,
        formats: NV_SRGB_FORMATS_RBO_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_NV_sRGB_formats",
        flags: REQUIRED_RENDERABLE | COLOR_RENDERABLE | TEXTURE_VALID,
        formats: NV_SRGB_FORMATS_TEXTURE_FORMATS,
    },
    // In Khronos bug 7333 discussion, the consensus is that these texture formats, at
    // least, should be color-renderable. Still, that cannot be found in any extension
    // spec, so only allow it, do not require it.
    FormatExtEntry {
        extensions: "GL_OES_rgb8_rgba8",
        flags: COLOR_RENDERABLE | TEXTURE_VALID,
        formats: OES_RGB8_RGBA8_TEX_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_OES_rgb8_rgba8",
        flags: REQUIRED_RENDERABLE | COLOR_RENDERABLE | RENDERBUFFER_VALID,
        formats: OES_RGB8_RGBA8_RBO_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_OES_rgb8_rgba8 GL_OES_required_internalformat",
        flags: TEXTURE_VALID,
        formats: OES_REQUIRED_INTERNAL_FORMAT_RGB8_COLOR_FORMAT,
    },
    // The depth-renderability of the depth RBO formats is not explicitly spelled out,
    // but all renderbuffer formats are meant to be renderable.
    FormatExtEntry {
        extensions: "GL_OES_depth24",
        flags: REQUIRED_RENDERABLE | DEPTH_RENDERABLE | RENDERBUFFER_VALID,
        formats: OES_DEPTH24_SIZED_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_OES_depth24 GL_OES_required_internalformat GL_OES_depth_texture",
        flags: TEXTURE_VALID,
        formats: OES_DEPTH24_SIZED_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_OES_depth32",
        flags: REQUIRED_RENDERABLE | DEPTH_RENDERABLE | RENDERBUFFER_VALID,
        formats: OES_DEPTH32_SIZED_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_OES_depth32 GL_OES_required_internalformat GL_OES_depth_texture",
        flags: TEXTURE_VALID,
        formats: OES_DEPTH32_SIZED_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_EXT_texture_type_2_10_10_10_REV",
        flags: TEXTURE_VALID, // explicitly unrenderable
        formats: EXT_TEXTURE_TYPE_2101010_REV_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_EXT_texture_type_2_10_10_10_REV GL_OES_required_internalformat",
        flags: TEXTURE_VALID, // explicitly unrenderable
        formats: OES_REQUIRED_INTERNAL_FORMAT_10BIT_COLOR_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_EXT_texture_sRGB_R8",
        flags: TEXTURE_VALID,
        formats: EXT_TEXTURE_SRGB_R8_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_EXT_texture_sRGB_RG8",
        flags: TEXTURE_VALID,
        formats: EXT_TEXTURE_SRGB_RG8_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_QCOM_render_sRGB_R8_RG8",
        flags: REQUIRED_RENDERABLE | COLOR_RENDERABLE | RENDERBUFFER_VALID | TEXTURE_VALID,
        formats: QCOM_RENDER_SRGB_R8_RG8_FORMATS,
    },
    FormatExtEntry {
        extensions: "GL_EXT_texture_format_BGRA8888",
        flags: REQUIRED_RENDERABLE | COLOR_RENDERABLE | RENDERBUFFER_VALID | TEXTURE_VALID,
        formats: EXT_TEXTURE_FORMAT_BGRA8888_FORMATS,
    },
];

/// `fboc::Context`, minus the parts that need a live driver.
pub struct FbocContext {
    /// `m_coreFormats` - the API's own formats, no extensions.
    pub core_formats: FormatDb,
    /// `m_allFormats` - the same plus every extension format, whether present or not.
    pub all_formats: FormatDb,
    /// The extension entries `ctx_formats` filters at run time.
    ext_entries: Vec<&'static [FormatExtEntry]>,
    /// `m_haveMultiColorAtts`. ES 3 has them in core; ES 2 needs an extension, and
    /// that question cannot be asked until a context exists.
    multi_color_atts: MultiColorAtts,
    /// `CheckerFactory::createChecker`
    checker_factory: fn() -> Box<dyn Checker>,
}

/// How `Context::haveMultiColorAtts` is answered for this API.
pub enum MultiColorAtts {
    Core,
    Extension(&'static str),
}

impl FbocContext {
    /// `Context::Context` plus `addFormats`/`addExtFormats`, which upstream's two
    /// `TestGroup` constructors call right after it.
    pub fn new(
        core_entries: &[&'static [FormatEntry]],
        ext_entries: &[&'static [FormatExtEntry]],
        multi_color_atts: MultiColorAtts,
        checker_factory: fn() -> Box<dyn Checker>,
    ) -> Self {
        let mut core_formats = FormatDb::default();
        let mut all_formats = FormatDb::default();

        for entries in core_entries {
            add_formats(&mut core_formats, entries);
            add_formats(&mut all_formats, entries);
        }
        for entries in ext_entries {
            add_ext_formats(&mut all_formats, entries, None);
        }

        Self {
            core_formats,
            all_formats,
            ext_entries: ext_entries.to_vec(),
            multi_color_atts,
            checker_factory,
        }
    }

    /// `m_ctxFormats` - core plus the extension formats this driver really has.
    pub fn ctx_formats(&self, context: &Context) -> FormatDb {
        let mut db = FormatDb::default();
        // `addFormats` ran over the core entries for all three databases, and
        // `core_formats` is exactly their union, so copying it is the same thing.
        for (format, flags) in self.core_formats.entries() {
            db.add_format(format, flags);
        }
        for entries in &self.ext_entries {
            add_ext_formats(&mut db, entries, Some(context));
        }
        db
    }

    pub fn have_multi_color_atts(&self, context: &Context) -> bool {
        match self.multi_color_atts {
            MultiColorAtts::Core => true,
            MultiColorAtts::Extension(name) => context.context_info.is_extension_supported(name),
        }
    }
}

/// What `TestBase::iterate` hands to `build`: upstream reaches all of this through
/// `m_ctx` and `getContext().getRenderContext()`.
pub struct BuildCtx<'a> {
    pub fboc: &'a FbocContext,
    pub ctx_formats: &'a FormatDb,
    pub context: &'a Context,
}

impl BuildCtx<'_> {
    pub fn gl(&self) -> &glw::Functions {
        self.context.gl()
    }

    /// `TestBase::getDefaultFormat`
    pub fn default_format(&self, att_point: GLenum, buf_type: GLenum) -> Result<ImageFormat, TestError> {
        if buf_type == glw::GL_NONE {
            return Ok(ImageFormat::none());
        }

        // Prefer a standard format, if there is one, but if not, use a format provided
        // by an extension.
        let requirements = format_flag(att_point) | format_flag(buf_type);
        let format = self
            .fboc
            .core_formats
            .formats(requirements)
            .first()
            .copied()
            .or_else(|| self.ctx_formats.formats(requirements).first().copied());

        format.ok_or_else(|| TestError::NotSupported("Unsupported attachment kind for attachment point".to_string()))
    }

    /// `fboc::makeAttachment`, which calls `makeImage` on the way.
    pub fn make_attachment(
        &self,
        buf_type: GLenum,
        format: ImageFormat,
        width: GLsizei,
        height: GLsizei,
        builder: &mut FboBuilder,
    ) -> Option<Attachment> {
        match buf_type {
            glw::GL_NONE => None,
            glw::GL_RENDERBUFFER => {
                let image_name = builder.gl_create_rbo(Image::Renderbuffer {
                    internal_format: format,
                    width,
                    height,
                    num_samples: 0,
                });
                Some(Attachment::Renderbuffer { image_name })
            }
            _ => {
                let image_name = builder.gl_create_texture(Image::Texture2D {
                    internal_format: format,
                    width,
                    height,
                    num_levels: 1,
                });
                Some(Attachment::TextureFlat {
                    image_name,
                    level: 0,
                    tex_target: glw::GL_TEXTURE_2D,
                })
            }
        }
    }

    /// `TestBase::attachTargetToNew`
    pub fn attach_target_to_new(
        &self,
        target: GLenum,
        buf_type: GLenum,
        format: ImageFormat,
        width: GLsizei,
        height: GLsizei,
        builder: &mut FboBuilder,
    ) -> Result<(), TestError> {
        let img_fmt = if format.format == glw::GL_NONE {
            self.default_format(target, buf_type)?
        } else {
            format
        };

        let att = self.make_attachment(buf_type, img_fmt, width, height, builder);
        builder.gl_attach(target, att);
        Ok(())
    }
}

/// `TestBase::build`, which every case in these groups overrides and nothing else.
pub trait FboSetup: Send + Sync {
    fn build(&self, bc: &BuildCtx, builder: &mut FboBuilder) -> Result<(), TestError>;
}

/// `fboc::TestBase` / `fboc::ParamTest` - the case that builds an FBO, then compares
/// what the driver said against the set of answers the spec allows.
pub struct FboCompletenessCase {
    name: String,
    fboc: Arc<FbocContext>,
    setup: Box<dyn FboSetup>,
}

impl FboCompletenessCase {
    pub fn boxed(
        name: impl Into<String>,
        fboc: &Arc<FbocContext>,
        setup: impl FboSetup + 'static,
    ) -> Box<dyn TestCase> {
        Box::new(Self {
            name: name.into(),
            fboc: Arc::clone(fboc),
            setup: Box::new(setup),
        })
    }
}

impl TestCase for FboCompletenessCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `TestBase::iterate`
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let ctx_formats = self.fboc.ctx_formats(context);
        let bc = BuildCtx {
            fboc: &self.fboc,
            ctx_formats: &ctx_formats,
            context,
        };

        let fbo = glu::Framebuffer::new(gl);
        let mut builder = FboBuilder::new(gl, fbo.get(), glw::GL_FRAMEBUFFER);

        self.setup.build(&bc, &mut builder)?;

        let mut checker = (self.fboc.checker_factory)();
        let reference = valid_status_codes(checker.as_mut(), context, &ctx_formats, &builder.config);
        let error_code = builder.error();

        // \todo [2013-12-04 lauri] Check if drawing operations succeed.

        if error_code != glw::GL_NO_ERROR {
            log::info!("Received {} (during FBO initialization).", glw::error_name(error_code));

            if reference.is_error_code_valid(error_code) {
                Ok(TestStatus::pass("Pass"))
            } else if reference.is_error_code_required(glw::GL_NO_ERROR) {
                Ok(TestStatus::fail(format!(
                    "Expected no error but got {}",
                    glw::error_name(error_code)
                )))
            } else {
                Ok(TestStatus::fail("Got wrong error code"))
            }
        } else {
            // SAFETY: the framebuffer built above is still bound.
            let fbo_status = unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) };
            let valid_status = reference.is_fbo_status_valid(fbo_status);

            log::info!("Received {fbo_status:#x}.");

            if !valid_status {
                if fbo_status == glw::GL_FRAMEBUFFER_COMPLETE {
                    Ok(TestStatus::fail("Framebuffer checked as complete, expected incomplete"))
                } else if reference.is_fbo_status_required(glw::GL_FRAMEBUFFER_COMPLETE) {
                    Ok(TestStatus::fail("Framebuffer checked is incomplete, expected complete"))
                } else {
                    // An incomplete status is allowed, but not _this_ incomplete status.
                    Ok(TestStatus::fail(
                        "Framebuffer checked as incomplete, but with wrong status",
                    ))
                }
            } else if fbo_status == glw::GL_FRAMEBUFFER_UNSUPPORTED {
                // The spec requires "when both depth and stencil attachments are
                // present, implementations are only required to support framebuffer
                // objects where both attachments refer to the same image", so returning
                // GL_FRAMEBUFFER_UNSUPPORTED is acceptable and cannot fail the case.
                Ok(TestStatus::pass("Pass"))
            } else if fbo_status != glw::GL_FRAMEBUFFER_COMPLETE
                && reference.is_fbo_status_valid(glw::GL_FRAMEBUFFER_COMPLETE)
            {
                Ok(TestStatus::new(
                    TestResult::QualityWarning,
                    "Framebuffer object could have checked as complete but did not.",
                ))
            } else {
                Ok(TestStatus::pass("Pass"))
            }
        }
    }
}

/// `fboc::formatName` - `getTextureFormatName` lowercased with the `GL_` cut off, plus
/// the type for an unsized format. This is the whole of a `renderable.*` case name, so
/// it has to agree with upstream character for character.
pub fn format_name(format: ImageFormat) -> String {
    let fmt_str =
        glu::texture_format_name(format.format).expect("format in the database has a name")[3..].to_lowercase();

    if format.unsized_type != glw::GL_NONE {
        let type_str = glu::type_name(format.unsized_type).expect("unsized type has a name")[3..].to_lowercase();
        format!("{fmt_str}_{type_str}")
    } else {
        fmt_str
    }
}

/// `fboc::RenderableTest`
struct RenderableTest {
    att_point: GLenum,
    buf_type: GLenum,
    format: ImageFormat,
}

impl FboSetup for RenderableTest {
    fn build(&self, bc: &BuildCtx, builder: &mut FboBuilder) -> Result<(), TestError> {
        bc.attach_target_to_new(self.att_point, self.buf_type, self.format, 64, 64, builder)
    }
}

/// `fboc::attTypeName`
fn att_type_name(buf_type: GLenum) -> &'static str {
    match buf_type {
        glw::GL_NONE => "none",
        glw::GL_RENDERBUFFER => "rbo",
        _ => "tex",
    }
}

/// `fboc::AttachmentTest` - combinations of different kinds of attachments.
struct AttachmentTest {
    color0_kind: GLenum,
    colorn_kind: GLenum,
    depth_kind: GLenum,
    stencil_kind: GLenum,
}

impl AttachmentTest {
    /// `AttachmentTest::makeDepthAndStencil`
    fn make_depth_and_stencil(&self, bc: &BuildCtx, builder: &mut FboBuilder) -> Result<(), TestError> {
        if self.stencil_kind == self.depth_kind {
            // If there is a common stencil+depth format, try to use a common image for
            // both attachments.
            let flags = DEPTH_RENDERABLE | STENCIL_RENDERABLE | format_flag(self.stencil_kind);
            if let Some(format) = bc.fboc.core_formats.formats(flags).first().copied() {
                let att = bc.make_attachment(self.depth_kind, format, 64, 64, builder);
                builder.gl_attach(glw::GL_DEPTH_ATTACHMENT, att);
                builder.gl_attach(glw::GL_STENCIL_ATTACHMENT, att);
                return Ok(());
            }
        }

        // Either the kinds were separate, or a suitable format was not found. Create
        // separate images.
        bc.attach_target_to_new(
            glw::GL_STENCIL_ATTACHMENT,
            self.stencil_kind,
            ImageFormat::none(),
            64,
            64,
            builder,
        )?;
        bc.attach_target_to_new(
            glw::GL_DEPTH_ATTACHMENT,
            self.depth_kind,
            ImageFormat::none(),
            64,
            64,
            builder,
        )
    }
}

impl FboSetup for AttachmentTest {
    fn build(&self, bc: &BuildCtx, builder: &mut FboBuilder) -> Result<(), TestError> {
        bc.attach_target_to_new(
            glw::GL_COLOR_ATTACHMENT0,
            self.color0_kind,
            ImageFormat::none(),
            64,
            64,
            builder,
        )?;

        if self.colorn_kind != glw::GL_NONE {
            if !bc.fboc.have_multi_color_atts(bc.context) {
                return Err(TestError::NotSupported(
                    "Multiple attachments not supported".to_string(),
                ));
            }

            let mut max_attachments = 1;
            // SAFETY: one GLint out.
            unsafe {
                bc.gl()
                    .get_integerv(glw::GL_MAX_COLOR_ATTACHMENTS, &mut max_attachments)
            };
            glu::expect_no_error(bc.gl(), "Couldn't read GL_MAX_COLOR_ATTACHMENTS")?;

            for i in 1..max_attachments {
                bc.attach_target_to_new(
                    glw::GL_COLOR_ATTACHMENT0 + i as GLenum,
                    self.colorn_kind,
                    ImageFormat::none(),
                    64,
                    64,
                    builder,
                )?;
            }
        }

        self.make_depth_and_stencil(bc, builder)
    }
}

/// `fboc::EmptyImageTest`
struct EmptyImageTest;

impl FboSetup for EmptyImageTest {
    fn build(&self, bc: &BuildCtx, builder: &mut FboBuilder) -> Result<(), TestError> {
        bc.attach_target_to_new(
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            ImageFormat::none(),
            0,
            0,
            builder,
        )
    }
}

/// `fboc::DistinctSizeTest`
struct DistinctSizeTest;

impl FboSetup for DistinctSizeTest {
    fn build(&self, bc: &BuildCtx, builder: &mut FboBuilder) -> Result<(), TestError> {
        bc.attach_target_to_new(
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            ImageFormat::none(),
            64,
            64,
            builder,
        )?;
        bc.attach_target_to_new(
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            ImageFormat::none(),
            128,
            128,
            builder,
        )
    }
}

/// The three attachment points `createRenderableTests` iterates.
const ATT_POINTS: [(GLenum, &str); 3] = [
    (glw::GL_COLOR_ATTACHMENT0, "color0"),
    (glw::GL_STENCIL_ATTACHMENT, "stencil"),
    (glw::GL_DEPTH_ATTACHMENT, "depth"),
];

/// `Context::createRenderableTests`
pub fn create_renderable_tests(fboc: &Arc<FbocContext>) -> TestCaseGroup {
    let mut renderable_tests = TestCaseGroup::new("renderable");
    let mut rb_renderable_tests = TestCaseGroup::new("renderbuffer");
    let mut tex_renderable_tests = TestCaseGroup::new("texture");

    // At each attachment point, iterate through all the possible formats to detect both
    // false positives and false negatives.
    let formats = fboc.all_formats.formats(ANY_FORMAT);

    for (att_point, name) in ATT_POINTS {
        let mut rb_att_tests = TestCaseGroup::new(name);
        let mut tex_att_tests = TestCaseGroup::new(name);

        for format in &formats {
            let case_name = format_name(*format);
            rb_att_tests.add_child(FboCompletenessCase::boxed(
                case_name.clone(),
                fboc,
                RenderableTest {
                    att_point,
                    buf_type: glw::GL_RENDERBUFFER,
                    format: *format,
                },
            ));
            tex_att_tests.add_child(FboCompletenessCase::boxed(
                case_name,
                fboc,
                RenderableTest {
                    att_point,
                    buf_type: glw::GL_TEXTURE,
                    format: *format,
                },
            ));
        }

        rb_renderable_tests.add_child(rb_att_tests);
        tex_renderable_tests.add_child(tex_att_tests);
    }

    renderable_tests.add_child(rb_renderable_tests);
    renderable_tests.add_child(tex_renderable_tests);
    renderable_tests
}

/// `Context::createAttachmentTests`
pub fn create_attachment_tests(fboc: &Arc<FbocContext>) -> TestCaseGroup {
    const BUF_TYPES: [GLenum; 3] = [glw::GL_NONE, glw::GL_RENDERBUFFER, glw::GL_TEXTURE];

    let mut group = TestCaseGroup::new("attachment_combinations");

    for col0 in BUF_TYPES {
        for coln in BUF_TYPES {
            for dep in BUF_TYPES {
                for stc in BUF_TYPES {
                    let name = format!(
                        "{}_{}_{}_{}",
                        att_type_name(col0),
                        att_type_name(coln),
                        att_type_name(dep),
                        att_type_name(stc)
                    );
                    group.add_child(FboCompletenessCase::boxed(
                        name,
                        fboc,
                        AttachmentTest {
                            color0_kind: col0,
                            colorn_kind: coln,
                            depth_kind: dep,
                            stencil_kind: stc,
                        },
                    ));
                }
            }
        }
    }

    group
}

/// `Context::createSizeTests`
pub fn create_size_tests(fboc: &Arc<FbocContext>) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("size");
    group.add_child(FboCompletenessCase::boxed("zero", fboc, EmptyImageTest));
    group.add_child(FboCompletenessCase::boxed("distinct", fboc, DistinctSizeTest));
    group
}
