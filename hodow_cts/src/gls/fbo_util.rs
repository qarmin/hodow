// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsFboUtil.hpp / .cpp  (gls::FboUtil::)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2013 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `config::Config` class
// hierarchy plus `dynamic_cast` becomes two enums (`Image`, `Attachment`) matched on,
// which is what every one of those casts was asking. `FboBuilder::makeConfig<T>` exists
// there only to own the heap allocations that hierarchy needs, so it has no counterpart.
// `logFramebufferConfig`/`logFormatInfo`/`ValidStatusCodes::logRules` are not ported -
// they write to upstream's structured test log, which this port does not have, and they
// decide nothing.

use std::collections::BTreeMap;

use crate::glu::{self, Context, TransferFormat};
use crate::glw::{self, GLenum, GLint, GLsizei, GLuint};
use crate::tcu::TestError;

/// `FboUtil::ImageFormat`
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Debug)]
pub struct ImageFormat {
    pub format: GLenum,
    /// Type if format is unsized, `GL_NONE` if sized.
    pub unsized_type: GLenum,
}

impl ImageFormat {
    pub const fn sized(format: GLenum) -> Self {
        Self {
            format,
            unsized_type: glw::GL_NONE,
        }
    }

    pub const fn unsized_format(format: GLenum, unsized_type: GLenum) -> Self {
        Self { format, unsized_type }
    }

    pub const fn none() -> Self {
        Self {
            format: glw::GL_NONE,
            unsized_type: glw::GL_NONE,
        }
    }
}

// `FboUtil::FormatFlags`
pub const ANY_FORMAT: u32 = 0;
pub const COLOR_RENDERABLE: u32 = 1 << 0;
pub const DEPTH_RENDERABLE: u32 = 1 << 1;
pub const STENCIL_RENDERABLE: u32 = 1 << 2;
pub const RENDERBUFFER_VALID: u32 = 1 << 3;
pub const TEXTURE_VALID: u32 = 1 << 4;
/// Without this, renderability is allowed, not required.
pub const REQUIRED_RENDERABLE: u32 = 1 << 5;

/// `FboUtil::formatFlag`
pub fn format_flag(context: GLenum) -> u32 {
    match context {
        glw::GL_NONE => 0,
        glw::GL_RENDERBUFFER => RENDERBUFFER_VALID,
        glw::GL_TEXTURE => TEXTURE_VALID,
        glw::GL_STENCIL_ATTACHMENT => STENCIL_RENDERABLE,
        glw::GL_DEPTH_ATTACHMENT => DEPTH_RENDERABLE,
        _ => COLOR_RENDERABLE,
    }
}

/// `getAttachmentRenderabilityFlag`
fn attachment_renderability_flag(attachment: GLenum) -> u32 {
    match attachment {
        glw::GL_STENCIL_ATTACHMENT => STENCIL_RENDERABLE,
        glw::GL_DEPTH_ATTACHMENT => DEPTH_RENDERABLE,
        _ => COLOR_RENDERABLE,
    }
}

/// `FboUtil::FormatDB`
///
/// `m_formatExtensions` is not kept: upstream reads it only from `logFormatInfo`.
#[derive(Default, Debug)]
pub struct FormatDb {
    format_flags: BTreeMap<ImageFormat, u32>,
}

impl FormatDb {
    /// `FormatDB::addCoreFormat`, which `addExtensionFormat` also does for its flags.
    pub fn add_format(&mut self, format: ImageFormat, new_flags: u32) {
        *self.format_flags.entry(format).or_insert(0) |= new_flags;
    }

    /// `FormatDB::getFormats`
    pub fn formats(&self, requirements: u32) -> Vec<ImageFormat> {
        self.format_flags
            .iter()
            .filter(|(_, flags)| *flags & requirements == requirements)
            .map(|(format, _)| *format)
            .collect()
    }

    /// `FormatDB::isKnownFormat`
    pub fn is_known_format(&self, format: ImageFormat) -> bool {
        self.format_flags.contains_key(&format)
    }

    /// `FormatDB::getFormatInfo`
    pub fn format_info(&self, format: ImageFormat) -> u32 {
        self.format_flags.get(&format).copied().unwrap_or(0)
    }

    /// Every `(format, flags)` pair, for copying one database into another.
    pub fn entries(&self) -> impl Iterator<Item = (ImageFormat, u32)> + '_ {
        self.format_flags.iter().map(|(format, flags)| (*format, *flags))
    }
}

/// `FboUtil::FormatEntry` - one flag set over a list of formats.
pub struct FormatEntry {
    pub flags: u32,
    pub formats: &'static [ImageFormat],
}

/// `FboUtil::FormatExtEntry` - the same, gated on a space-separated extension list.
pub struct FormatExtEntry {
    pub extensions: &'static str,
    pub flags: u32,
    pub formats: &'static [ImageFormat],
}

/// `FboUtil::checkExtensionSupport` - accepts `GL_*` and the `DEQP_*` pseudo-extensions.
///
/// The `DEQP_*` ones ask the driver's own `GL_MAJOR_VERSION` rather than the requested
/// context version, which is what makes an ES 2.0 context on ES 3 hardware follow the
/// ES 3 rules here. See `glu::Context::is_gles_compatible`.
pub fn check_extension_support(context: &Context, extension: &str) -> bool {
    if extension.starts_with("GL_") {
        context.context_info.is_extension_supported(extension)
    } else if extension == "DEQP_gles3_core_compatible" {
        context.is_gles_compatible(3, 0)
    } else {
        debug_assert!(extension == "DEQP_gles31_core_compatible", "unknown pseudo-extension");
        context.is_gles_compatible(3, 1)
    }
}

/// `FboUtil::addFormats`
pub fn add_formats(db: &mut FormatDb, entries: &[FormatEntry]) {
    for entry in entries {
        for format in entry.formats {
            db.add_format(*format, entry.flags);
        }
    }
}

/// `FboUtil::addExtFormats`. `context` is `None` for upstream's "all formats" database,
/// which records what *any* extension could make legal.
pub fn add_ext_formats(db: &mut FormatDb, entries: &[FormatExtEntry], context: Option<&Context>) {
    for entry in entries {
        let supported = match context {
            None => true,
            Some(context) => entry
                .extensions
                .split_whitespace()
                .all(|ext| check_extension_support(context, ext)),
        };

        if supported {
            for format in entry.formats {
                db.add_format(*format, entry.flags);
            }
        }
    }
}

/// `FboUtil::transferImageFormat`
pub fn transfer_image_format(img_format: ImageFormat) -> Result<TransferFormat, TestError> {
    if img_format.unsized_type == glw::GL_NONE {
        let tex_format = glu::texture_util::map_gl_internal_format(img_format.format).ok_or_else(|| {
            TestError::Fail(format!(
                "no texture format for GL internal format {:#x}",
                img_format.format
            ))
        })?;
        glu::get_transfer_format(tex_format)
    } else {
        Ok(TransferFormat {
            format: img_format.format,
            data_type: img_format.unsized_type,
        })
    }
}

/// `FboUtil::config::Image` and its five subclasses.
#[derive(Clone, Copy, Debug)]
pub enum Image {
    Renderbuffer {
        internal_format: ImageFormat,
        width: GLsizei,
        height: GLsizei,
        num_samples: GLsizei,
    },
    Texture2D {
        internal_format: ImageFormat,
        width: GLsizei,
        height: GLsizei,
        num_levels: GLint,
    },
    TextureCubeMap {
        internal_format: ImageFormat,
        width: GLsizei,
        height: GLsizei,
        num_levels: GLint,
    },
    Texture3D {
        internal_format: ImageFormat,
        width: GLsizei,
        height: GLsizei,
        num_levels: GLint,
        num_layers: GLsizei,
    },
    Texture2DArray {
        internal_format: ImageFormat,
        width: GLsizei,
        height: GLsizei,
        num_levels: GLint,
        num_layers: GLsizei,
    },
}

impl Image {
    pub fn internal_format(&self) -> ImageFormat {
        match self {
            Self::Renderbuffer { internal_format, .. }
            | Self::Texture2D { internal_format, .. }
            | Self::TextureCubeMap { internal_format, .. }
            | Self::Texture3D { internal_format, .. }
            | Self::Texture2DArray { internal_format, .. } => *internal_format,
        }
    }

    pub fn width(&self) -> GLsizei {
        match self {
            Self::Renderbuffer { width, .. }
            | Self::Texture2D { width, .. }
            | Self::TextureCubeMap { width, .. }
            | Self::Texture3D { width, .. }
            | Self::Texture2DArray { width, .. } => *width,
        }
    }

    pub fn height(&self) -> GLsizei {
        match self {
            Self::Renderbuffer { height, .. }
            | Self::Texture2D { height, .. }
            | Self::TextureCubeMap { height, .. }
            | Self::Texture3D { height, .. }
            | Self::Texture2DArray { height, .. } => *height,
        }
    }

    /// `config::imageNumSamples` - zero for anything that is not a renderbuffer.
    pub fn num_samples(&self) -> GLsizei {
        match self {
            Self::Renderbuffer { num_samples, .. } => *num_samples,
            _ => 0,
        }
    }

    /// `TextureLayered::numLayers`, or `None` for the non-layered images.
    pub fn num_layers(&self) -> Option<GLsizei> {
        match self {
            Self::Texture3D { num_layers, .. } | Self::Texture2DArray { num_layers, .. } => Some(*num_layers),
            _ => None,
        }
    }

    fn num_levels(&self) -> GLint {
        match self {
            Self::Renderbuffer { .. } => 1,
            Self::Texture2D { num_levels, .. }
            | Self::TextureCubeMap { num_levels, .. }
            | Self::Texture3D { num_levels, .. }
            | Self::Texture2DArray { num_levels, .. } => *num_levels,
        }
    }

    /// `config::glTarget`
    fn gl_target(&self) -> GLenum {
        match self {
            Self::Renderbuffer { .. } => glw::GL_RENDERBUFFER,
            Self::Texture2D { .. } => glw::GL_TEXTURE_2D,
            Self::TextureCubeMap { .. } => glw::GL_TEXTURE_CUBE_MAP,
            Self::Texture3D { .. } => glw::GL_TEXTURE_3D,
            Self::Texture2DArray { .. } => glw::GL_TEXTURE_2D_ARRAY,
        }
    }
}

/// `FboUtil::config::Attachment` and its three subclasses.
#[derive(Clone, Copy, Debug)]
pub enum Attachment {
    Renderbuffer {
        image_name: GLuint,
    },
    TextureFlat {
        image_name: GLuint,
        level: GLint,
        tex_target: GLenum,
    },
    TextureLayer {
        image_name: GLuint,
        level: GLint,
        layer: GLsizei,
    },
}

impl Attachment {
    pub fn image_name(&self) -> GLuint {
        match self {
            Self::Renderbuffer { image_name }
            | Self::TextureFlat { image_name, .. }
            | Self::TextureLayer { image_name, .. } => *image_name,
        }
    }

    /// `config::attachmentType`
    pub fn attachment_type(&self) -> GLenum {
        match self {
            Self::Renderbuffer { .. } => glw::GL_RENDERBUFFER,
            _ => glw::GL_TEXTURE,
        }
    }

    /// `config::textureLayer` - zero for a flat attachment.
    fn texture_layer(&self) -> GLsizei {
        match self {
            Self::TextureLayer { layer, .. } => *layer,
            _ => 0,
        }
    }
}

/// `FboUtil::config::Framebuffer`
#[derive(Default, Debug)]
pub struct FramebufferConfig {
    pub attachments: BTreeMap<GLenum, Attachment>,
    pub textures: BTreeMap<GLuint, Image>,
    pub rbos: BTreeMap<GLuint, Image>,
}

impl FramebufferConfig {
    /// `Framebuffer::getImage`
    pub fn image(&self, ty: GLenum, img_name: GLuint) -> Option<&Image> {
        match ty {
            glw::GL_TEXTURE => self.textures.get(&img_name),
            _ => self.rbos.get(&img_name),
        }
    }
}

/// `FboUtil::FboBuilder` - the configuration plus the GL objects it created.
pub struct FboBuilder<'gl> {
    gl: &'gl glw::Functions,
    target: GLenum,
    /// The first GL error encountered.
    error: GLenum,
    pub config: FramebufferConfig,
}

impl<'gl> FboBuilder<'gl> {
    pub fn new(gl: &'gl glw::Functions, fbo: GLuint, target: GLenum) -> Self {
        // SAFETY: the framebuffer name is the caller's own.
        unsafe { gl.bind_framebuffer(target, fbo) };
        Self {
            gl,
            target,
            error: glw::GL_NO_ERROR,
            config: FramebufferConfig::default(),
        }
    }

    pub fn error(&self) -> GLenum {
        self.error
    }

    fn check_error(&mut self) {
        // SAFETY: glGetError needs only a current context.
        let error = unsafe { self.gl.get_error() };
        if error != glw::GL_NO_ERROR && self.error == glw::GL_NO_ERROR {
            self.error = error;
        }
    }

    /// `config::glInitFlat`
    fn gl_init_flat(&self, cfg: &Image, target: GLenum) {
        let Ok(format) = transfer_image_format(cfg.internal_format()) else {
            return;
        };
        let (mut w, mut h) = (cfg.width(), cfg.height());

        for level in 0..cfg.num_levels() {
            // SAFETY: a null pixel pointer only allocates, which is what upstream does.
            unsafe {
                self.gl.tex_image_2d(
                    target,
                    level,
                    cfg.internal_format().format as GLint,
                    w,
                    h,
                    0,
                    format.format,
                    format.data_type,
                    std::ptr::null(),
                );
            }
            w = 1.max(w / 2);
            h = 1.max(h / 2);
        }
    }

    /// `config::glInitLayered`
    fn gl_init_layered(&self, cfg: &Image, depth_divider: GLint) {
        let Ok(format) = transfer_image_format(cfg.internal_format()) else {
            return;
        };
        let (mut w, mut h) = (cfg.width(), cfg.height());
        let mut depth = cfg.num_layers().unwrap_or(1);

        for level in 0..cfg.num_levels() {
            // SAFETY: as above.
            unsafe {
                self.gl.tex_image_3d(
                    cfg.gl_target(),
                    level,
                    cfg.internal_format().format as GLint,
                    w,
                    h,
                    depth,
                    0,
                    format.format,
                    format.data_type,
                    std::ptr::null(),
                );
            }
            w = 1.max(w / 2);
            h = 1.max(h / 2);
            depth = 1.max(depth / depth_divider);
        }
    }

    /// `config::glCreate`
    fn gl_create(&mut self, cfg: &Image) -> GLuint {
        let mut name = 0;

        // SAFETY: one object is asked for and one GLuint of output is given; every
        // subsequent call names that object.
        unsafe {
            match cfg {
                Image::Renderbuffer {
                    internal_format,
                    width,
                    height,
                    num_samples,
                } => {
                    self.gl.gen_renderbuffers(1, &mut name);
                    self.gl.bind_renderbuffer(glw::GL_RENDERBUFFER, name);

                    if *num_samples == 0 {
                        self.gl
                            .renderbuffer_storage(glw::GL_RENDERBUFFER, internal_format.format, *width, *height);
                    } else {
                        self.gl.renderbuffer_storage_multisample(
                            glw::GL_RENDERBUFFER,
                            *num_samples,
                            internal_format.format,
                            *width,
                            *height,
                        );
                    }

                    self.gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
                }
                _ => {
                    self.gl.gen_textures(1, &mut name);
                    self.gl.bind_texture(cfg.gl_target(), name);

                    // `config::glInit`
                    match cfg {
                        Image::Texture2D { .. } => self.gl_init_flat(cfg, cfg.gl_target()),
                        Image::TextureCubeMap { .. } => {
                            for face in CUBE_MAP_FACES {
                                self.gl_init_flat(cfg, face);
                            }
                        }
                        Image::Texture3D { .. } => self.gl_init_layered(cfg, 2),
                        _ => self.gl_init_layered(cfg, 1),
                    }

                    self.gl.bind_texture(cfg.gl_target(), 0);
                }
            }
        }

        name
    }

    /// `FboBuilder::glCreateTexture`
    pub fn gl_create_texture(&mut self, tex_cfg: Image) -> GLuint {
        let name = self.gl_create(&tex_cfg);
        self.check_error();
        self.config.textures.insert(name, tex_cfg);
        name
    }

    /// `FboBuilder::glCreateRbo`
    pub fn gl_create_rbo(&mut self, rb_cfg: Image) -> GLuint {
        let name = self.gl_create(&rb_cfg);
        self.check_error();
        self.config.rbos.insert(name, rb_cfg);
        name
    }

    /// `FboBuilder::glAttach`
    pub fn gl_attach(&mut self, att_point: GLenum, att: Option<Attachment>) {
        // SAFETY: every name below is one this builder created.
        unsafe {
            match att {
                None => self
                    .gl
                    .framebuffer_renderbuffer(self.target, att_point, glw::GL_RENDERBUFFER, 0),
                Some(Attachment::Renderbuffer { image_name }) => {
                    self.gl
                        .framebuffer_renderbuffer(self.target, att_point, glw::GL_RENDERBUFFER, image_name);
                }
                Some(Attachment::TextureFlat {
                    image_name,
                    level,
                    tex_target,
                }) => self
                    .gl
                    .framebuffer_texture_2d(self.target, att_point, tex_target, image_name, level),
                Some(Attachment::TextureLayer {
                    image_name,
                    level,
                    layer,
                }) => {
                    self.gl
                        .framebuffer_texture_layer(self.target, att_point, image_name, level, layer);
                }
            }
        }

        self.check_error();

        match att {
            None => {
                self.config.attachments.remove(&att_point);
            }
            Some(att) => {
                self.config.attachments.insert(att_point, att);
            }
        }
    }
}

impl Drop for FboBuilder<'_> {
    fn drop(&mut self) {
        // SAFETY: every name is one this builder created and is deleted exactly once.
        unsafe {
            for name in self.config.textures.keys() {
                self.gl.delete_textures(1, name);
            }
            for name in self.config.rbos.keys() {
                self.gl.delete_renderbuffers(1, name);
            }
            self.gl.bind_framebuffer(self.target, 0);
        }
    }
}

/// The six cube map faces, in the order `config::glInit` walks them.
const CUBE_MAP_FACES: [GLenum; 6] = [
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
];

/// `FboUtil::ValidStatusCodes`
#[derive(Default, Debug)]
pub struct ValidStatusCodes {
    /// Allowed GL errors; `GL_NO_ERROR` is not among them.
    error_codes: Vec<GLenum>,
    /// Allowed FBO error statuses; `GL_FRAMEBUFFER_COMPLETE` is not among them.
    error_statuses: Vec<GLenum>,
    /// True if `(GL_NO_ERROR && GL_FRAMEBUFFER_COMPLETE)` is allowed.
    allow_complete: bool,
}

impl ValidStatusCodes {
    pub fn is_fbo_status_valid(&self, fbo_status: GLenum) -> bool {
        if fbo_status == glw::GL_FRAMEBUFFER_COMPLETE {
            self.allow_complete
        } else {
            self.error_statuses.contains(&fbo_status)
        }
    }

    pub fn is_fbo_status_required(&self, fbo_status: GLenum) -> bool {
        if fbo_status == glw::GL_FRAMEBUFFER_COMPLETE {
            self.allow_complete && self.error_statuses.is_empty()
        } else {
            // fbo_status is the only allowed error status and succeeding is forbidden.
            !self.allow_complete && self.error_statuses.len() == 1 && self.error_statuses[0] == fbo_status
        }
    }

    pub fn is_error_code_valid(&self, error_code: GLenum) -> bool {
        if error_code == glw::GL_NO_ERROR {
            self.error_codes.is_empty()
        } else {
            self.error_codes.contains(&error_code)
        }
    }

    pub fn is_error_code_required(&self, error_code: GLenum) -> bool {
        if self.error_codes.is_empty() && error_code == glw::GL_NO_ERROR {
            true
        } else {
            self.error_codes.len() == 1 && self.error_codes[0] == error_code
        }
    }

    fn add_violation(dst: &mut Vec<GLenum>, code: GLenum) {
        if !dst.contains(&code) {
            dst.push(code);
        }
    }
}

/// `FboUtil::Checker` - the accumulating half, which upstream puts in the base class.
#[derive(Default, Debug)]
pub struct CheckerState {
    pub status_codes: ValidStatusCodes,
}

impl CheckerState {
    pub fn new() -> Self {
        Self {
            status_codes: ValidStatusCodes {
                allow_complete: true,
                ..Default::default()
            },
        }
    }

    pub fn add_gl_error(&mut self, error: GLenum) {
        ValidStatusCodes::add_violation(&mut self.status_codes.error_codes, error);
        self.status_codes.allow_complete = false;
    }

    pub fn add_potential_gl_error(&mut self, error: GLenum) {
        ValidStatusCodes::add_violation(&mut self.status_codes.error_codes, error);
    }

    pub fn add_fbo_status(&mut self, status: GLenum) {
        ValidStatusCodes::add_violation(&mut self.status_codes.error_statuses, status);
        self.status_codes.allow_complete = false;
    }

    pub fn add_potential_fbo_status(&mut self, status: GLenum) {
        ValidStatusCodes::add_violation(&mut self.status_codes.error_statuses, status);
    }
}

/// `FboUtil::Checker::check` - the per-API half, which upstream makes virtual.
pub trait Checker {
    fn check(
        &mut self,
        state: &mut CheckerState,
        context: &Context,
        formats: &FormatDb,
        att_point: GLenum,
        att: &Attachment,
        image: &Image,
    );
}

/// `config::checkAttachmentCompleteness` - GLES2 4.4.5 / GLES3 4.4.4, "Framebuffer
/// attachment completeness".
fn check_attachment_completeness(
    state: &mut CheckerState,
    attachment: &Attachment,
    att_point: GLenum,
    image: &Image,
    db: &FormatDb,
) {
    // GLES3: the attached layer of a 3D or 2D array texture must be smaller than the
    // texture's depth / number of layers.
    if attachment.attachment_type() == glw::GL_TEXTURE
        && let Some(num_layers) = image.num_layers()
        && attachment.texture_layer() >= num_layers
    {
        state.add_fbo_status(glw::GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT);
    }

    // "The width and height of image are non-zero."
    if image.width() == 0 || image.height() == 0 {
        state.add_fbo_status(glw::GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT);
    }

    // Check for renderability.
    if db.is_known_format(image.internal_format()) {
        let flags = db.format_info(image.internal_format());

        // If the format does not have the proper renderability flag, the completeness
        // check _must_ fail.
        if flags & attachment_renderability_flag(att_point) == 0 {
            state.add_fbo_status(glw::GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT);
        } else if flags & REQUIRED_RENDERABLE == 0 {
            // If the format is only optionally renderable, the check _can_ fail.
            state.add_potential_fbo_status(glw::GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT);
        }
    } else {
        state.add_fbo_status(glw::GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT);
    }
}

/// `FboVerifier::validStatusCodes` - the set of status codes `glCheckFramebufferStatus`
/// is allowed to return on a conforming implementation for this configuration.
pub fn valid_status_codes(
    checker: &mut dyn Checker,
    context: &Context,
    formats: &FormatDb,
    fbo_config: &FramebufferConfig,
) -> ValidStatusCodes {
    let mut state = CheckerState::new();

    for texture in fbo_config.textures.values() {
        let bad = if formats.is_known_format(texture.internal_format()) {
            formats.format_info(texture.internal_format()) & TEXTURE_VALID == 0
        } else {
            // Either a sized format that does not exist, or an illegal unsized pair.
            true
        };

        if bad {
            state.add_gl_error(glw::GL_INVALID_ENUM);
            state.add_gl_error(glw::GL_INVALID_OPERATION);
            state.add_gl_error(glw::GL_INVALID_VALUE);
        }
    }

    for rbo in fbo_config.rbos.values() {
        let bad = if formats.is_known_format(rbo.internal_format()) {
            formats.format_info(rbo.internal_format()) & RENDERBUFFER_VALID == 0
        } else {
            true
        };

        if bad {
            state.add_gl_error(glw::GL_INVALID_ENUM);
        }
    }

    // "There is at least one image attached to the framebuffer."
    if fbo_config.attachments.is_empty() {
        state.add_fbo_status(glw::GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT);
    }

    for (att_point, att) in &fbo_config.attachments {
        let Some(image) = fbo_config.image(att.attachment_type(), att.image_name()) else {
            continue;
        };
        let image = *image;

        check_attachment_completeness(&mut state, att, *att_point, &image, formats);
        checker.check(&mut state, context, formats, *att_point, att, &image);
    }

    state.status_codes
}
