// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsLifetimeTests.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream builds this framework out of a small object-oriented hierarchy
// (`Type`/`Binder`/`Attacher`/`InputAttacher`/`OutputAttacher`, each with several
// concrete C++ subclasses holding live references to each other) shared between the
// ES2 and ES3 modules; `ES3Types` is `ES2Types` plus four more object kinds and two
// more attachers. That shape survives here as traits (`LifetimeType`, `Binder`,
// `Attacher`, `InputAttacher`, `OutputAttacher`) plus `Arc<dyn Trait>` in place of a
// C++ reference - a plain borrow cannot express one object holding a reference to
// another that outlives it without also outliving the collection both live in, and
// `Rc` is the direct, low-ceremony way around that for objects with no real ownership
// story of their own (every method still takes the live `Context`/`gl` explicitly, so
// nothing here is holding a GL resource across a call).
//
// `TestLog`/`CallLogWrapper` (a running human-readable narration of every GL call and
// query result, meant for upstream's test-log viewer) is not ported - this project has
// no such viewer, and every other GLES test in this port skips it too; only the
// checks that decide Pass/Fail survive. `testDeletedBinding`/`testDeletedReattach`
// (declared as `LifeTest`/`AttachmentTest`-style test functions but never defined and
// never registered by `addTestCases`) and `Attacher::canAttachDeleted` (declared,
// overridden by two ES3 attachers, but never read anywhere) are upstream dead code and
// are not ported either.

use std::ffi::CString;
use std::sync::Arc;

use crate::glu::texture_util::TransferFormat;
use crate::glu::{Context, Framebuffer, RenderTarget, Renderbuffer, TestCase, TestCaseGroup, Texture, read_pixels};
use crate::glw::{self, GLchar, GLenum, GLint, GLuint};
use crate::tcu::image_compare::pixel_threshold_compare;
use crate::tcu::{RGBA, Random, Surface, TestError, TestOutcome, TestResult, TestStatus, de_string_hash};

/// `LifetimeTests::details::{VIEWPORT_SIZE, FRAMEBUFFER_SIZE}` enum in the upstream `.cpp`.
pub const VIEWPORT_SIZE: GLint = 128;
const FRAMEBUFFER_SIZE: GLint = 128;

/// `getInteger`
fn get_integer(gl: &glw::Functions, param: GLenum) -> GLint {
    let mut ret: GLint = 0;
    // SAFETY: `param` names a single-integer query; a driver that does not recognise it
    // raises an error and leaves `ret` at its initialised value instead of writing OOB.
    unsafe { gl.get_integerv(param, &mut ret) };
    ret
}

// ---------------------------------------------------------------------------
// Binder
// ---------------------------------------------------------------------------

/// `LifetimeTests::details::Binder`
pub trait Binder: Send + Sync {
    fn bind(&self, gl: &glw::Functions, name: GLuint);
    fn get_binding(&self, gl: &glw::Functions) -> GLuint;
    fn gen_required(&self) -> bool {
        true
    }
}

/// `LifetimeTests::details::BindFunc` - upstream's function-pointer-to-member; there
/// are only a handful of these across the whole suite, so an enum names them instead of
/// carrying an actual function pointer around.
#[derive(Clone, Copy)]
pub enum SimpleBindFn {
    Buffer,
    Texture,
    Renderbuffer,
    Framebuffer,
    TransformFeedback,
}

impl SimpleBindFn {
    fn call(self, gl: &glw::Functions, target: GLenum, name: GLuint) {
        // SAFETY: each variant names a real `glBind*` entry point taking exactly
        // `(target, name)`, called with a current context.
        unsafe {
            match self {
                Self::Buffer => gl.bind_buffer(target, name),
                Self::Texture => gl.bind_texture(target, name),
                Self::Renderbuffer => gl.bind_renderbuffer(target, name),
                Self::Framebuffer => gl.bind_framebuffer(target, name),
                Self::TransformFeedback => gl.bind_transform_feedback(target, name),
            }
        }
    }
}

/// `LifetimeTests::details::SimpleBinder`
pub struct SimpleBinder {
    pub bind_fn: SimpleBindFn,
    pub bind_target: GLenum,
    pub binding_param: GLenum,
    pub gen_required: bool,
}

impl Binder for SimpleBinder {
    fn bind(&self, gl: &glw::Functions, name: GLuint) {
        self.bind_fn.call(gl, self.bind_target, name);
    }
    fn get_binding(&self, gl: &glw::Functions) -> GLuint {
        get_integer(gl, self.binding_param) as GLuint
    }
    fn gen_required(&self) -> bool {
        self.gen_required
    }
}

// ---------------------------------------------------------------------------
// Type
// ---------------------------------------------------------------------------

/// `LifetimeTests::details::Type`. Named `LifetimeType` rather than `Type` so it does
/// not read as shadowing Rust's own type-system vocabulary.
pub trait LifetimeType: Send + Sync {
    fn gen_object(&self, gl: &glw::Functions) -> GLuint;
    fn release(&self, gl: &glw::Functions, name: GLuint);
    fn exists(&self, gl: &glw::Functions, name: GLuint) -> bool;
    fn is_delete_flagged(&self, _gl: &glw::Functions, _name: GLuint) -> bool {
        false
    }
    fn binder(&self) -> Option<Arc<dyn Binder>> {
        None
    }
    fn get_name(&self) -> &'static str;
    fn name_lingers(&self) -> bool {
        false
    }
    fn gen_creates(&self) -> bool {
        false
    }
}

#[derive(Clone, Copy)]
pub enum GenFn {
    Buffers,
    Textures,
    Renderbuffers,
    Framebuffers,
    Queries,
    TransformFeedbacks,
    VertexArrays,
    Samplers,
}

impl GenFn {
    fn call(self, gl: &glw::Functions) -> GLuint {
        let mut name: GLuint = 0;
        // SAFETY: one object is asked for and one `GLuint` of output is given.
        unsafe {
            match self {
                Self::Buffers => gl.gen_buffers(1, &mut name),
                Self::Textures => gl.gen_textures(1, &mut name),
                Self::Renderbuffers => gl.gen_renderbuffers(1, &mut name),
                Self::Framebuffers => gl.gen_framebuffers(1, &mut name),
                Self::Queries => gl.gen_queries(1, &mut name),
                Self::TransformFeedbacks => gl.gen_transform_feedbacks(1, &mut name),
                Self::VertexArrays => gl.gen_vertex_arrays(1, &mut name),
                Self::Samplers => gl.gen_samplers(1, &mut name),
            }
        }
        name
    }
}

#[derive(Clone, Copy)]
pub enum DeleteFn {
    Buffers,
    Textures,
    Renderbuffers,
    Framebuffers,
    Queries,
    TransformFeedbacks,
    VertexArrays,
    Samplers,
}

impl DeleteFn {
    fn call(self, gl: &glw::Functions, name: GLuint) {
        // SAFETY: `name` is a single name of this kind, real or not - every `glDelete*`
        // entry point silently ignores an unrecognised name.
        unsafe {
            match self {
                Self::Buffers => gl.delete_buffers(1, &name),
                Self::Textures => gl.delete_textures(1, &name),
                Self::Renderbuffers => gl.delete_renderbuffers(1, &name),
                Self::Framebuffers => gl.delete_framebuffers(1, &name),
                Self::Queries => gl.delete_queries(1, &name),
                Self::TransformFeedbacks => gl.delete_transform_feedbacks(1, &name),
                Self::VertexArrays => gl.delete_vertex_arrays(1, &name),
                Self::Samplers => gl.delete_samplers(1, &name),
            }
        }
    }
}

#[derive(Clone, Copy)]
pub enum ExistsFn {
    Buffer,
    Texture,
    Renderbuffer,
    Framebuffer,
    Query,
    TransformFeedback,
    VertexArray,
    Sampler,
}

impl ExistsFn {
    fn call(self, gl: &glw::Functions, name: GLuint) -> bool {
        // SAFETY: every `glIs*` entry point accepts any `GLuint`, real or not.
        (unsafe {
            match self {
                Self::Buffer => gl.is_buffer(name),
                Self::Texture => gl.is_texture(name),
                Self::Renderbuffer => gl.is_renderbuffer(name),
                Self::Framebuffer => gl.is_framebuffer(name),
                Self::Query => gl.is_query(name),
                Self::TransformFeedback => gl.is_transform_feedback(name),
                Self::VertexArray => gl.is_vertex_array(name),
                Self::Sampler => gl.is_sampler(name),
            }
        }) != 0
    }
}

/// `LifetimeTests::details::SimpleType`
pub struct SimpleType {
    pub name: &'static str,
    pub gen_fn: GenFn,
    pub delete_fn: DeleteFn,
    pub exists_fn: ExistsFn,
    pub binder: Option<Arc<dyn Binder>>,
    pub gen_creates: bool,
}

impl LifetimeType for SimpleType {
    fn gen_object(&self, gl: &glw::Functions) -> GLuint {
        self.gen_fn.call(gl)
    }
    fn release(&self, gl: &glw::Functions, name: GLuint) {
        self.delete_fn.call(gl, name);
    }
    fn exists(&self, gl: &glw::Functions, name: GLuint) -> bool {
        self.exists_fn.call(gl, name)
    }
    fn binder(&self) -> Option<Arc<dyn Binder>> {
        self.binder.clone()
    }
    fn get_name(&self) -> &'static str {
        self.name
    }
    fn gen_creates(&self) -> bool {
        self.gen_creates
    }
}

/// `LifetimeTests::details::ProgramType`
pub struct ProgramType;

impl LifetimeType for ProgramType {
    fn gen_object(&self, gl: &glw::Functions) -> GLuint {
        // SAFETY: plain object creation on a current context.
        unsafe { gl.create_program() }
    }
    fn release(&self, gl: &glw::Functions, name: GLuint) {
        // SAFETY: `name` is a program name, real or not - `glDeleteProgram` on an
        // unrecognised name is a silent no-op.
        unsafe { gl.delete_program(name) };
    }
    fn exists(&self, gl: &glw::Functions, name: GLuint) -> bool {
        // SAFETY: as above.
        unsafe { gl.is_program(name) != 0 }
    }
    fn is_delete_flagged(&self, gl: &glw::Functions, name: GLuint) -> bool {
        let mut flagged: GLint = 0;
        // SAFETY: `GL_DELETE_STATUS` is a single-integer query on a program name.
        unsafe { gl.get_programiv(name, glw::GL_DELETE_STATUS, &mut flagged) };
        flagged != 0
    }
    fn get_name(&self) -> &'static str {
        "program"
    }
    fn name_lingers(&self) -> bool {
        true
    }
    fn gen_creates(&self) -> bool {
        true
    }
}

/// `LifetimeTests::details::ShaderType` - always a fragment shader, exactly like
/// upstream (`glCreateShader(GL_FRAGMENT_SHADER)`); which shader stage is irrelevant to
/// every check this file runs, so upstream never varies it.
pub struct ShaderType;

impl LifetimeType for ShaderType {
    fn gen_object(&self, gl: &glw::Functions) -> GLuint {
        // SAFETY: plain object creation on a current context.
        unsafe { gl.create_shader(glw::GL_FRAGMENT_SHADER) }
    }
    fn release(&self, gl: &glw::Functions, name: GLuint) {
        // SAFETY: as `ProgramType::release`.
        unsafe { gl.delete_shader(name) };
    }
    fn exists(&self, gl: &glw::Functions, name: GLuint) -> bool {
        // SAFETY: as above.
        unsafe { gl.is_shader(name) != 0 }
    }
    fn is_delete_flagged(&self, gl: &glw::Functions, name: GLuint) -> bool {
        let mut flagged: GLint = 0;
        // SAFETY: `GL_DELETE_STATUS` is a single-integer query on a shader name.
        unsafe { gl.get_shaderiv(name, glw::GL_DELETE_STATUS, &mut flagged) };
        flagged != 0
    }
    fn get_name(&self) -> &'static str {
        "shader"
    }
    fn name_lingers(&self) -> bool {
        true
    }
    fn gen_creates(&self) -> bool {
        true
    }
}

// ---------------------------------------------------------------------------
// Attacher / InputAttacher / OutputAttacher
// ---------------------------------------------------------------------------

/// `LifetimeTests::details::Attacher`. `attach`/`detach` are fallible here (unlike
/// upstream's `void`-returning virtuals) purely because the ES3 buffer/VAO and
/// buffer/transform-feedback attachers below need to build a GLSL program on first use
/// and a shader build is the one operation in this whole file that can genuinely fail
/// on a real driver; every other implementation always returns `Ok(())`.
pub trait Attacher: Send + Sync {
    fn init_attachment(&self, context: &Context, seed: u32, element: GLuint) -> Result<(), TestError>;
    fn attach(&self, context: &Context, element: GLuint, container: GLuint) -> Result<(), TestError>;
    fn detach(&self, context: &Context, element: GLuint, container: GLuint) -> Result<(), TestError>;
    fn get_attachment(&self, context: &Context, container: GLuint) -> GLuint;
    fn element_type(&self) -> Arc<dyn LifetimeType>;
    fn container_type(&self) -> Arc<dyn LifetimeType>;
}

/// `LifetimeTests::details::InputAttacher`
pub trait InputAttacher: Send + Sync {
    fn attacher(&self) -> Arc<dyn Attacher>;
    fn draw_container(&self, context: &Context, container: GLuint) -> Result<Surface, TestError>;
}

/// `LifetimeTests::details::OutputAttacher`
pub trait OutputAttacher: Send + Sync {
    fn attacher(&self) -> Arc<dyn Attacher>;
    fn setup_container(&self, context: &Context, seed: u32, container: GLuint) -> Result<(), TestError>;
    fn draw_attachment(&self, context: &Context, attachment: GLuint) -> Result<Surface, TestError>;
}

/// `setupFbo`
pub fn setup_fbo(context: &Context, seed: u32, fbo: GLuint) {
    let gl = context.gl();
    // SAFETY: plain framebuffer clears on a current context; `fbo` is a real
    // framebuffer name for the whole duration of this call.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);

        if seed == 0 {
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
        } else {
            let mut rnd = Random::new(seed);
            let width = rnd.get_int(0, FRAMEBUFFER_SIZE);
            let height = rnd.get_int(0, FRAMEBUFFER_SIZE);
            let x = rnd.get_int(0, FRAMEBUFFER_SIZE - width);
            let y = rnd.get_int(0, FRAMEBUFFER_SIZE - height);
            let r1 = rnd.get_float();
            let g1 = rnd.get_float();
            let b1 = rnd.get_float();
            let a1 = rnd.get_float();
            let r2 = rnd.get_float();
            let g2 = rnd.get_float();
            let b2 = rnd.get_float();
            let a2 = rnd.get_float();

            gl.clear_color(r1, g1, b1, a1);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            gl.scissor(x, y, width, height);
            gl.enable(glw::GL_SCISSOR_TEST);
            gl.clear_color(r2, g2, b2, a2);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            gl.disable(glw::GL_SCISSOR_TEST);
        }

        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
    }
}

/// `drawFbo`
fn draw_fbo(context: &Context, fbo: GLuint) -> Result<Surface, TestError> {
    let gl = context.gl();
    // SAFETY: `fbo` is a real framebuffer name for the duration of this call.
    unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo) };

    let mut dst = Surface::new(FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE);
    read_pixels(&context.render_context, 0, 0, &mut dst.get_access())?;

    // SAFETY: as above.
    unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };
    Ok(dst)
}

/// `getFboAttachment` - note the early `return 0` leaves `fbo` still bound to
/// `GL_FRAMEBUFFER` rather than restoring binding `0`, exactly as upstream's does;
/// `glu::reset_state_es` runs after every GL case in this port, which is what makes
/// that safe to leave as found rather than "fixed" into a different call shape.
fn get_fbo_attachment(gl: &glw::Functions, fbo: GLuint, required_type: GLenum) -> GLuint {
    let mut type_: GLint = 0;
    // SAFETY: `fbo` is a real framebuffer name; `GL_COLOR_ATTACHMENT0`'s object-type
    // query is always valid to ask, attached or not.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.get_framebuffer_attachment_parameteriv(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
            &mut type_,
        );
    }

    if type_ as GLenum != required_type || type_ as GLenum == glw::GL_NONE {
        return 0;
    }

    let mut name: GLint = 0;
    // SAFETY: the object-type query above just confirmed an attachment of
    // `required_type` is present, so its name is valid to query too.
    unsafe {
        gl.get_framebuffer_attachment_parameteriv(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
            &mut name,
        );
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
    }
    name as GLuint
}

/// `fbo_attacher_init_attachment` - the shared body of `FboAttacher::initAttachment`,
/// parameterised over the one thing that differs between a texture and a renderbuffer
/// attachment: how to give the freshly bound element its storage.
fn fbo_attacher_init_attachment(
    context: &Context,
    element_type: &dyn LifetimeType,
    init_storage: fn(&Context) -> Result<(), TestError>,
    attach: fn(&Context, GLuint, GLuint) -> Result<(), TestError>,
    detach: fn(&Context, GLuint, GLuint) -> Result<(), TestError>,
    seed: u32,
    element: GLuint,
) -> Result<(), TestError> {
    let gl = context.gl();
    let binder = element_type
        .binder()
        .expect("every fbo attachment element type is bindable");
    let fbo = Framebuffer::new(gl);

    binder.bind(gl, element);
    let storage_result = init_storage(context);
    binder.bind(gl, 0);
    storage_result?;

    attach(context, element, fbo.get())?;
    setup_fbo(context, seed, fbo.get());
    detach(context, element, fbo.get())?;
    Ok(())
}

// -- Texture/FBO attachment --------------------------------------------------

fn texture_fbo_attach(context: &Context, texture: GLuint, fbo: GLuint) -> Result<(), TestError> {
    let gl = context.gl();
    // SAFETY: `texture`/`fbo` are real names for the duration of this call.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            texture,
            0,
        );
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
    }
    Ok(())
}

fn texture_fbo_detach(context: &Context, _texture: GLuint, fbo: GLuint) -> Result<(), TestError> {
    let gl = context.gl();
    // SAFETY: as above.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_TEXTURE_2D, 0, 0);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
    }
    Ok(())
}

fn is_texture_format_color_renderable(context: &Context, format: TransferFormat) -> Result<bool, TestError> {
    let gl = context.gl();
    let mut cur_fbo: GLint = 0;
    let mut cur_tex: GLint = 0;
    // SAFETY: single-integer queries, always valid.
    unsafe {
        gl.get_integerv(glw::GL_FRAMEBUFFER_BINDING, &mut cur_fbo);
        gl.get_integerv(glw::GL_TEXTURE_BINDING_2D, &mut cur_tex);
    }

    // RAII in place of upstream's manual try/catch cleanup: whichever way this function
    // returns, `test_tex`/`test_fbo` are deleted going out of scope.
    let test_tex = Texture::new(gl);
    let test_fbo = Framebuffer::new(gl);
    let status;
    // SAFETY: `test_tex`/`test_fbo` are this call's own fresh objects.
    unsafe {
        gl.bind_texture(glw::GL_TEXTURE_2D, test_tex.get());
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            format.format as GLint,
            FRAMEBUFFER_SIZE,
            FRAMEBUFFER_SIZE,
            0,
            format.format,
            format.data_type,
            std::ptr::null(),
        );

        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, test_fbo.get());
        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            test_tex.get(),
            0,
        );

        status = gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);

        gl.bind_texture(glw::GL_TEXTURE_2D, cur_tex as GLuint);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, cur_fbo as GLuint);
    }

    match status {
        glw::GL_FRAMEBUFFER_COMPLETE => Ok(true),
        glw::GL_FRAMEBUFFER_UNSUPPORTED => Ok(false),
        other => Err(TestError::Fail(format!(
            "glCheckFramebufferStatus() returned invalid result code {}",
            glw::error_name(other)
        ))),
    }
}

/// `getRenderableColorTextureFormat` - note this asks what the context was *requested*
/// as (`context.context_type().supports(3, 0)`, upstream's `contextSupports(renderCtx.
/// getType(), ...)`), not what the driver reports it actually is
/// (`Context::is_es3_compatible`, which several other GL tests in this port use
/// instead and deliberately for a different reason - see that method's own doc comment).
fn get_renderable_color_texture_format(context: &Context) -> Result<TransferFormat, TestError> {
    if context.context_type().supports(3, 0) {
        return Ok(TransferFormat {
            format: glw::GL_RGBA,
            data_type: glw::GL_UNSIGNED_SHORT_4_4_4_4,
        });
    }

    let candidates = [
        TransferFormat {
            format: glw::GL_RGBA,
            data_type: glw::GL_UNSIGNED_SHORT_4_4_4_4,
        },
        TransferFormat {
            format: glw::GL_RGBA,
            data_type: glw::GL_UNSIGNED_SHORT_5_5_5_1,
        },
        TransferFormat {
            format: glw::GL_RGB,
            data_type: glw::GL_UNSIGNED_SHORT_5_6_5,
        },
        TransferFormat {
            format: glw::GL_RGBA,
            data_type: glw::GL_UNSIGNED_BYTE,
        },
    ];
    for candidate in candidates {
        if is_texture_format_color_renderable(context, candidate)? {
            return Ok(candidate);
        }
    }
    Ok(TransferFormat {
        format: glw::GL_NONE,
        data_type: glw::GL_NONE,
    })
}

fn texture_init_storage(context: &Context) -> Result<(), TestError> {
    let format = get_renderable_color_texture_format(context)?;
    if format.format == glw::GL_NONE {
        return Err(TestError::NotSupported(
            "No renderable texture format found".to_string(),
        ));
    }
    let gl = context.gl();
    // SAFETY: whatever texture the caller bound before calling this is the one this
    // sizes; `pixels = null` leaves the storage's contents unspecified, matching
    // upstream (this attacher only ever draws over the whole thing afterwards).
    unsafe {
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            format.format as GLint,
            FRAMEBUFFER_SIZE,
            FRAMEBUFFER_SIZE,
            0,
            format.format,
            format.data_type,
            std::ptr::null(),
        );
    }
    Ok(())
}

/// `TextureFboAttacher`
pub struct TextureFboAttacher {
    pub element_type: Arc<dyn LifetimeType>,
    pub container_type: Arc<dyn LifetimeType>,
}

impl Attacher for TextureFboAttacher {
    fn init_attachment(&self, context: &Context, seed: u32, element: GLuint) -> Result<(), TestError> {
        fbo_attacher_init_attachment(
            context,
            self.element_type.as_ref(),
            texture_init_storage,
            texture_fbo_attach,
            texture_fbo_detach,
            seed,
            element,
        )
    }
    fn attach(&self, context: &Context, element: GLuint, container: GLuint) -> Result<(), TestError> {
        texture_fbo_attach(context, element, container)
    }
    fn detach(&self, context: &Context, element: GLuint, container: GLuint) -> Result<(), TestError> {
        texture_fbo_detach(context, element, container)
    }
    fn get_attachment(&self, context: &Context, container: GLuint) -> GLuint {
        get_fbo_attachment(context.gl(), container, glw::GL_TEXTURE)
    }
    fn element_type(&self) -> Arc<dyn LifetimeType> {
        self.element_type.clone()
    }
    fn container_type(&self) -> Arc<dyn LifetimeType> {
        self.container_type.clone()
    }
}

// -- Renderbuffer/FBO attachment ---------------------------------------------

fn rbo_fbo_attach(context: &Context, rbo: GLuint, fbo: GLuint) -> Result<(), TestError> {
    let gl = context.gl();
    // SAFETY: `rbo`/`fbo` are real names for the duration of this call.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rbo,
        );
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
    }
    Ok(())
}

fn rbo_fbo_detach(context: &Context, _rbo: GLuint, fbo: GLuint) -> Result<(), TestError> {
    let gl = context.gl();
    // SAFETY: as above.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, glw::GL_RENDERBUFFER, 0);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
    }
    Ok(())
}

fn is_renderbuffer_format_color_renderable(context: &Context, format: GLenum) -> Result<bool, TestError> {
    let gl = context.gl();
    let mut cur_fbo: GLint = 0;
    let mut cur_rbo: GLint = 0;
    // SAFETY: single-integer queries, always valid.
    unsafe {
        gl.get_integerv(glw::GL_FRAMEBUFFER_BINDING, &mut cur_fbo);
        gl.get_integerv(glw::GL_RENDERBUFFER_BINDING, &mut cur_rbo);
    }

    let test_rbo = Renderbuffer::new(gl);
    let test_fbo = Framebuffer::new(gl);
    let status;
    // SAFETY: `test_rbo`/`test_fbo` are this call's own fresh objects.
    unsafe {
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, test_rbo.get());
        gl.renderbuffer_storage(glw::GL_RENDERBUFFER, format, FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE);

        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, test_fbo.get());
        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            test_rbo.get(),
        );

        status = gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);

        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, cur_rbo as GLuint);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, cur_fbo as GLuint);
    }

    match status {
        glw::GL_FRAMEBUFFER_COMPLETE => Ok(true),
        glw::GL_FRAMEBUFFER_UNSUPPORTED => Ok(false),
        other => Err(TestError::Fail(format!(
            "glCheckFramebufferStatus() returned invalid result code {}",
            glw::error_name(other)
        ))),
    }
}

fn get_renderable_color_renderbuffer_format(context: &Context) -> Result<GLenum, TestError> {
    if context.context_type().supports(3, 0) {
        return Ok(glw::GL_RGBA4);
    }
    let candidates = [glw::GL_RGBA4, glw::GL_RGB5_A1, glw::GL_RGB565];
    for candidate in candidates {
        if is_renderbuffer_format_color_renderable(context, candidate)? {
            return Ok(candidate);
        }
    }
    Ok(glw::GL_NONE)
}

/// Unlike `texture_init_storage`'s `NotSupported`, upstream throws a plain
/// `TestError` (a Fail, not a skip) when no renderable renderbuffer format turns up -
/// kept as found rather than homogenized with the texture path.
fn rbo_init_storage(context: &Context) -> Result<(), TestError> {
    let format = get_renderable_color_renderbuffer_format(context)?;
    if format == glw::GL_NONE {
        return Err(TestError::Fail(
            "No color-renderable renderbuffer format found".to_string(),
        ));
    }
    let gl = context.gl();
    // SAFETY: whatever renderbuffer the caller bound before calling this is the one
    // this sizes.
    unsafe { gl.renderbuffer_storage(glw::GL_RENDERBUFFER, format, FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE) };
    Ok(())
}

/// `RboFboAttacher`
pub struct RboFboAttacher {
    pub element_type: Arc<dyn LifetimeType>,
    pub container_type: Arc<dyn LifetimeType>,
}

impl Attacher for RboFboAttacher {
    fn init_attachment(&self, context: &Context, seed: u32, element: GLuint) -> Result<(), TestError> {
        fbo_attacher_init_attachment(
            context,
            self.element_type.as_ref(),
            rbo_init_storage,
            rbo_fbo_attach,
            rbo_fbo_detach,
            seed,
            element,
        )
    }
    fn attach(&self, context: &Context, element: GLuint, container: GLuint) -> Result<(), TestError> {
        rbo_fbo_attach(context, element, container)
    }
    fn detach(&self, context: &Context, element: GLuint, container: GLuint) -> Result<(), TestError> {
        rbo_fbo_detach(context, element, container)
    }
    fn get_attachment(&self, context: &Context, container: GLuint) -> GLuint {
        get_fbo_attachment(context.gl(), container, glw::GL_RENDERBUFFER)
    }
    fn element_type(&self) -> Arc<dyn LifetimeType> {
        self.element_type.clone()
    }
    fn container_type(&self) -> Arc<dyn LifetimeType> {
        self.container_type.clone()
    }
}

/// `FboInputAttacher` - generic over which kind of `FboAttacher` it wraps, exactly like
/// upstream's own (it takes any `FboAttacher &`).
pub struct FboInputAttacher {
    pub attacher: Arc<dyn Attacher>,
}

impl InputAttacher for FboInputAttacher {
    fn attacher(&self) -> Arc<dyn Attacher> {
        self.attacher.clone()
    }
    fn draw_container(&self, context: &Context, fbo: GLuint) -> Result<Surface, TestError> {
        draw_fbo(context, fbo)
    }
}

/// `FboOutputAttacher`
pub struct FboOutputAttacher {
    pub attacher: Arc<dyn Attacher>,
}

impl OutputAttacher for FboOutputAttacher {
    fn attacher(&self) -> Arc<dyn Attacher> {
        self.attacher.clone()
    }
    fn setup_container(&self, context: &Context, seed: u32, fbo: GLuint) -> Result<(), TestError> {
        setup_fbo(context, seed, fbo);
        Ok(())
    }
    fn draw_attachment(&self, context: &Context, element: GLuint) -> Result<Surface, TestError> {
        let fbo = Framebuffer::new(context.gl());
        self.attacher.attach(context, element, fbo.get())?;
        let surface = draw_fbo(context, fbo.get());
        self.attacher.detach(context, element, fbo.get())?;
        surface
    }
}

// -- Shader/program attachment -----------------------------------------------

const LIFETIME_VERTEX_SRC: &str =
    "#version 100\nattribute vec2 pos;\nvoid main() { gl_Position = vec4(pos.xy, 0.0, 1.0); }\n";
const LIFETIME_FRAGMENT_SRC: &str = "#version 100\nvoid main() { gl_FragColor = vec4(1.0); }\n";

/// `CheckedShader` - a standalone compiled shader, deleted when it goes out of scope.
/// Not `glu::ShaderProgram`: that always builds and links a brand-new program, and
/// `ShaderProgramInputAttacher::draw_container` below needs to attach one fresh
/// vertex shader to a *pre-existing* program that already carries the fragment shader
/// this suite's own attachment machinery put there.
struct CheckedShader<'gl> {
    gl: &'gl glw::Functions,
    shader: GLuint,
}

impl<'gl> CheckedShader<'gl> {
    fn new(gl: &'gl glw::Functions, shader_type: GLenum, source: &str) -> Result<Self, TestError> {
        // SAFETY: plain object creation on a current context.
        let shader = unsafe { gl.create_shader(shader_type) };
        let bytes = source.as_bytes();
        let ptr = bytes.as_ptr().cast::<GLchar>();
        let len = bytes.len() as GLint;
        // SAFETY: `ptr`/`len` describe `source`'s own bytes, alive for this call.
        unsafe {
            gl.shader_source(shader, 1, &ptr, &len);
            gl.compile_shader(shader);
        }
        let mut status: GLint = 0;
        // SAFETY: `GL_COMPILE_STATUS` is a single-integer query on a shader name.
        unsafe { gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut status) };
        if status == 0 {
            // SAFETY: `shader` is this call's own fresh object, being abandoned.
            unsafe { gl.delete_shader(shader) };
            return Err(TestError::Fail("a lifetime-test shader failed to compile".to_string()));
        }
        Ok(Self { gl, shader })
    }

    fn get(&self) -> GLuint {
        self.shader
    }
}

impl Drop for CheckedShader<'_> {
    fn drop(&mut self) {
        // SAFETY: `self.shader` is this wrapper's own and is deleted exactly once.
        unsafe { self.gl.delete_shader(self.shader) };
    }
}

fn shader_program_init_attachment(context: &Context, seed: u32, shader: GLuint) -> Result<(), TestError> {
    let mut rnd = Random::new(seed);
    // `floatToString(rnd.getFloat(), 4)` - four decimal places, which is also what
    // guarantees a `.` survives even when the value happens to round to a whole number
    // (a bare "0" is not a valid GLSL `float` literal).
    let red = rnd.get_float();
    let green = rnd.get_float();
    let blue = rnd.get_float();
    let source =
        format!("#version 100\nvoid main() {{ gl_FragColor = vec4({red:.4}, {green:.4}, {blue:.4}, 1.0); }}\n");

    let gl = context.gl();
    let bytes = source.as_bytes();
    let ptr = bytes.as_ptr().cast::<GLchar>();
    let len = bytes.len() as GLint;
    // SAFETY: `ptr`/`len` describe `source`'s own bytes, alive for this call; `shader`
    // is a real shader name for its whole duration.
    unsafe {
        gl.shader_source(shader, 1, &ptr, &len);
        gl.compile_shader(shader);
    }
    let mut status: GLint = 0;
    // SAFETY: as above.
    unsafe { gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut status) };
    if status == 0 {
        return Err(TestError::Fail(
            "shader_program attachment's fragment shader failed to compile".to_string(),
        ));
    }
    Ok(())
}

fn shader_program_attach(context: &Context, shader: GLuint, program: GLuint) -> Result<(), TestError> {
    // SAFETY: `shader`/`program` are real names for the duration of this call.
    unsafe { context.gl().attach_shader(program, shader) };
    Ok(())
}

fn shader_program_detach(context: &Context, shader: GLuint, program: GLuint) -> Result<(), TestError> {
    // SAFETY: as above.
    unsafe { context.gl().detach_shader(program, shader) };
    Ok(())
}

fn shader_program_get_attachment(context: &Context, program: GLuint) -> GLuint {
    let gl = context.gl();
    let mut shaders = [0 as GLuint; 2];
    let mut num_shaders: GLint = 0;
    // SAFETY: `shaders` has room for the `2` objects requested.
    unsafe { gl.get_attached_shaders(program, 2, &mut num_shaders, shaders.as_mut_ptr()) };

    let count = num_shaders.clamp(0, 2) as usize;
    for &shader in &shaders[..count] {
        let mut shader_type: GLint = 0;
        // SAFETY: `shader` is one of the names the driver itself just reported.
        unsafe { gl.get_shaderiv(shader, glw::GL_SHADER_TYPE, &mut shader_type) };
        if shader_type as GLenum == glw::GL_FRAGMENT_SHADER {
            return shader;
        }
    }
    0
}

/// `ShaderProgramAttacher`
pub struct ShaderProgramAttacher {
    pub element_type: Arc<dyn LifetimeType>,
    pub container_type: Arc<dyn LifetimeType>,
}

impl Attacher for ShaderProgramAttacher {
    fn init_attachment(&self, context: &Context, seed: u32, element: GLuint) -> Result<(), TestError> {
        shader_program_init_attachment(context, seed, element)
    }
    fn attach(&self, context: &Context, element: GLuint, container: GLuint) -> Result<(), TestError> {
        shader_program_attach(context, element, container)
    }
    fn detach(&self, context: &Context, element: GLuint, container: GLuint) -> Result<(), TestError> {
        shader_program_detach(context, element, container)
    }
    fn get_attachment(&self, context: &Context, container: GLuint) -> GLuint {
        shader_program_get_attachment(context, container)
    }
    fn element_type(&self) -> Arc<dyn LifetimeType> {
        self.element_type.clone()
    }
    fn container_type(&self) -> Arc<dyn LifetimeType> {
        self.container_type.clone()
    }
}

/// `ShaderProgramInputAttacher`
pub struct ShaderProgramInputAttacher {
    pub attacher: Arc<dyn Attacher>,
}

impl InputAttacher for ShaderProgramInputAttacher {
    fn attacher(&self) -> Arc<dyn Attacher> {
        self.attacher.clone()
    }
    fn draw_container(&self, context: &Context, program: GLuint) -> Result<Surface, TestError> {
        let gl = context.gl();
        let mut rnd = Random::new(program);
        let vtx_shader = CheckedShader::new(gl, glw::GL_VERTEX_SHADER, LIFETIME_VERTEX_SRC)?;
        let viewport = random_viewport(context.render_target(), VIEWPORT_SIZE, VIEWPORT_SIZE, &mut rnd);

        // SAFETY: `program` is a real, already-linked-once program name; attaching a
        // second shader and relinking is ordinary GL use.
        unsafe {
            gl.attach_shader(program, vtx_shader.get());
            gl.link_program(program);
        }
        let mut link_status: GLint = 0;
        // SAFETY: `GL_LINK_STATUS` is a single-integer query on a program name.
        unsafe { gl.get_programiv(program, glw::GL_LINK_STATUS, &mut link_status) };
        if link_status == 0 {
            return Err(TestError::Fail(
                "failed to link program with a temporary vertex shader".to_string(),
            ));
        }

        set_viewport(gl, &viewport);

        // SAFETY: `program` just linked successfully.
        unsafe { gl.use_program(program) };
        let pos_name = CString::new("pos").expect("no interior NUL");
        // SAFETY: `program` is current.
        let pos_loc = unsafe { gl.get_attrib_location(program, pos_name.as_ptr()) };
        if pos_loc < 0 {
            return Err(TestError::Fail("linked program has no `pos` attribute".to_string()));
        }

        const VERTICES: [f32; 6] = [-1.0, 0.0, 1.0, 1.0, 0.0, -1.0];
        // SAFETY: `VERTICES` outlives this call, `pos_loc` is a real enabled attribute.
        unsafe {
            gl.enable_vertex_attrib_array(pos_loc as GLuint);
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT);
            gl.vertex_attrib_pointer(
                pos_loc as GLuint,
                2,
                glw::GL_FLOAT,
                glw::GL_FALSE as glw::GLboolean,
                0,
                VERTICES.as_ptr().cast(),
            );
            gl.draw_arrays(glw::GL_TRIANGLES, 0, 3);
            gl.disable_vertex_attrib_array(pos_loc as GLuint);
            gl.use_program(0);
        }

        let dst = read_rectangle(&context.render_context, &viewport)?;

        // SAFETY: `vtx_shader` is still attached to `program` from above.
        unsafe { gl.detach_shader(program, vtx_shader.get()) };

        Ok(dst)
    }
}

// ---------------------------------------------------------------------------
// Viewport helpers
// ---------------------------------------------------------------------------

/// `LifetimeTests::details::Rectangle`
pub struct Rectangle {
    pub x: GLint,
    pub y: GLint,
    pub width: GLint,
    pub height: GLint,
}

/// `randomViewport`
pub fn random_viewport(target: RenderTarget, max_width: GLint, max_height: GLint, rnd: &mut Random) -> Rectangle {
    let width = target.width.min(max_width);
    let x_off = rnd.get_int(0, target.width - width);
    let height = target.height.min(max_height);
    let y_off = rnd.get_int(0, target.height - height);
    Rectangle {
        x: x_off,
        y: y_off,
        width,
        height,
    }
}

/// `setViewport`
pub fn set_viewport(gl: &glw::Functions, rect: &Rectangle) {
    // SAFETY: plain viewport state, no pointers involved.
    unsafe { gl.viewport(rect.x, rect.y, rect.width, rect.height) };
}

/// `readRectangle`
pub fn read_rectangle(render_context: &crate::glu::RenderContext, rect: &Rectangle) -> Result<Surface, TestError> {
    let mut dst = Surface::new(rect.width, rect.height);
    read_pixels(render_context, rect.x, rect.y, &mut dst.get_access())?;
    Ok(dst)
}

// ---------------------------------------------------------------------------
// Name (RAII gen+release)
// ---------------------------------------------------------------------------

/// `LifetimeTests::details::Name` - generates (or, via `with_name`, just remembers) an
/// object name and releases it when this guard drops, whether or not the name was ever
/// actually valid.
struct NameGuard<'gl> {
    type_: Arc<dyn LifetimeType>,
    gl: &'gl glw::Functions,
    name: GLuint,
}

impl<'gl> NameGuard<'gl> {
    fn new(type_: Arc<dyn LifetimeType>, gl: &'gl glw::Functions) -> Self {
        let name = type_.gen_object(gl);
        Self { type_, gl, name }
    }
    fn with_name(type_: Arc<dyn LifetimeType>, gl: &'gl glw::Functions, name: GLuint) -> Self {
        Self { type_, gl, name }
    }
    fn get(&self) -> GLuint {
        self.name
    }
}

impl Drop for NameGuard<'_> {
    fn drop(&mut self) {
        self.type_.release(self.gl, self.name);
    }
}

/// `replaceName` (the `TestLog &` upstream threads through purely to narrate the choice
/// is dropped along with every other log call in this port).
fn replace_name(gl: &glw::Functions, type_: &dyn LifetimeType, old_name: GLuint) -> GLuint {
    let gen_required = type_.binder().map(|b| b.gen_required()).unwrap_or(true);
    if gen_required { type_.gen_object(gl) } else { old_name }
}

// ---------------------------------------------------------------------------
// ResultCollector
// ---------------------------------------------------------------------------

/// `LifetimeTests::details::ResultCollector`, minus the `warn` half - nothing in this
/// file ever calls it, so it is not ported.
struct ResultCollector {
    result: TestResult,
    message: String,
}

impl ResultCollector {
    fn new() -> Self {
        Self {
            result: TestResult::Pass,
            message: "Pass".to_string(),
        }
    }

    fn check(&mut self, cond: bool, msg: &str) -> bool {
        if !cond {
            self.fail(msg);
        }
        cond
    }

    fn fail(&mut self, msg: &str) {
        if self.result == TestResult::Pass {
            self.result = TestResult::Fail;
            self.message = msg.to_string();
        } else {
            self.result = TestResult::Fail;
            self.message = "Multiple problems, see log for details".to_string();
        }
    }

    fn into_status(self) -> TestStatus {
        TestStatus::new(self.result, self.message)
    }
}

// ---------------------------------------------------------------------------
// LifeTest cases: gen / delete / bind / delete_bound / bind_no_gen / delete_used
// ---------------------------------------------------------------------------

struct GenCase {
    type_: Arc<dyn LifetimeType>,
}

impl TestCase for GenCase {
    fn name(&self) -> &str {
        self.type_.get_name()
    }
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut errors = ResultCollector::new();
        let guard = NameGuard::new(self.type_.clone(), gl);
        if self.type_.gen_creates() {
            errors.check(
                self.type_.exists(gl, guard.get()),
                "Gen* should have created an object, but didn't",
            );
        } else {
            errors.check(
                !self.type_.exists(gl, guard.get()),
                "Gen* should not have created an object, but did",
            );
        }
        Ok(errors.into_status())
    }
}

struct DeleteCase {
    type_: Arc<dyn LifetimeType>,
}

impl TestCase for DeleteCase {
    fn name(&self) -> &str {
        self.type_.get_name()
    }
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut errors = ResultCollector::new();
        let name = self.type_.gen_object(gl);
        self.type_.release(gl, name);
        errors.check(!self.type_.exists(gl, name), "Object still exists after deletion");
        Ok(errors.into_status())
    }
}

struct BindCase {
    type_: Arc<dyn LifetimeType>,
}

impl TestCase for BindCase {
    fn name(&self) -> &str {
        self.type_.get_name()
    }
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut errors = ResultCollector::new();
        let binder = self.type_.binder().expect("`bind` group only contains bindable types");
        let guard = NameGuard::new(self.type_.clone(), gl);

        binder.bind(gl, guard.get());
        // SAFETY: `glGetError` needs only a current context.
        let err = unsafe { gl.get_error() };
        if err != glw::GL_NO_ERROR {
            return Ok(TestStatus::fail(format!("Bind failed: {}", glw::error_name(err))));
        }
        errors.check(
            self.type_.exists(gl, guard.get()),
            "Object does not exist after binding",
        );
        binder.bind(gl, 0);
        Ok(errors.into_status())
    }
}

struct DeleteBoundCase {
    type_: Arc<dyn LifetimeType>,
}

impl TestCase for DeleteBoundCase {
    fn name(&self) -> &str {
        self.type_.get_name()
    }
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let id = self.type_.gen_object(gl);
        let mut errors = ResultCollector::new();
        let binder = self
            .type_
            .binder()
            .expect("`delete_bound` group only contains bindable types");

        binder.bind(gl, id);
        self.type_.release(gl, id);

        if self.type_.name_lingers() {
            errors.check(
                unsafe { gl.get_error() } == glw::GL_NO_ERROR,
                "Deleting bound object failed",
            );
            errors.check(
                binder.get_binding(gl) == id,
                "Deleting bound object did not retain binding",
            );
            errors.check(self.type_.exists(gl, id), "Deleting bound object made its name invalid");
            errors.check(
                self.type_.is_delete_flagged(gl, id),
                "Deleting bound object did not flag the object for deletion",
            );
            binder.bind(gl, 0);
        } else {
            errors.check(
                unsafe { gl.get_error() } == glw::GL_NO_ERROR,
                "Deleting bound object failed",
            );
            errors.check(
                binder.get_binding(gl) == 0,
                "Deleting bound object did not remove binding",
            );
            errors.check(
                !self.type_.exists(gl, id),
                "Deleting bound object did not make its name invalid",
            );
            binder.bind(gl, 0);
        }

        errors.check(binder.get_binding(gl) == 0, "Unbinding didn't remove binding");
        errors.check(
            !self.type_.exists(gl, id),
            "Name is still valid after deleting and unbinding",
        );
        Ok(errors.into_status())
    }
}

struct BindNoGenCase {
    type_: Arc<dyn LifetimeType>,
}

impl TestCase for BindNoGenCase {
    fn name(&self) -> &str {
        self.type_.get_name()
    }
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut rnd = Random::new(de_string_hash(self.name()));
        let mut errors = ResultCollector::new();
        let id = rnd.get_uint32();

        if !errors.check(!self.type_.exists(gl, id), "Randomly chosen identifier already exists") {
            return Ok(errors.into_status());
        }

        let binder = self
            .type_
            .binder()
            .expect("`bind_no_gen` group only contains bindable types");
        let guard = NameGuard::with_name(self.type_.clone(), gl, id);
        binder.bind(gl, guard.get());

        if binder.gen_required() {
            errors.check(
                unsafe { gl.get_error() } == glw::GL_INVALID_OPERATION,
                "Did not fail when binding a name not generated by Gen* call",
            );
            errors.check(
                !self.type_.exists(gl, guard.get()),
                "Bind* created an object for a name not generated by a Gen* call",
            );
        } else {
            errors.check(
                unsafe { gl.get_error() } == glw::GL_NO_ERROR,
                "Failed when binding a name not generated by Gen* call",
            );
            errors.check(
                self.type_.exists(gl, guard.get()),
                "Object was not created by the Bind* call",
            );
        }
        Ok(errors.into_status())
    }
}

/// `LifeTest::testDeleteUsed` - hardcoded to `program`, the only type upstream ever
/// registers this test for.
struct DeleteUsedCase;

impl TestCase for DeleteUsedCase {
    fn name(&self) -> &str {
        "program"
    }
    fn iterate(&self, context: &Context) -> TestOutcome {
        use crate::glu::{ProgramSources, ShaderProgram};

        let gl = context.gl();
        let mut errors = ResultCollector::new();
        let program_id;
        {
            let sources = ProgramSources::vtx_frag(LIFETIME_VERTEX_SRC, LIFETIME_FRAGMENT_SRC);
            let program = ShaderProgram::new(gl, &sources);
            if !program.is_ok() {
                return Err(TestError::Fail(
                    program
                        .build_failure_summary()
                        .unwrap_or_else(|| "failed to build program".to_string()),
                ));
            }
            program_id = program.program();
            // SAFETY: `program_id` just linked successfully.
            unsafe { gl.use_program(program_id) };
            // `program` drops here: `glDeleteShader` x2 + `glDeleteProgram`, all while
            // `program_id` is still the current program - it must be flagged for
            // deletion rather than actually removed.
        }

        // SAFETY: `program_id` was a real program name a moment ago.
        if unsafe { gl.is_program(program_id) } == 0 {
            return Err(TestError::Fail(
                "program name became invalid immediately after being deleted while current".to_string(),
            ));
        }
        let mut delete_flagged: GLint = 0;
        // SAFETY: `GL_DELETE_STATUS` is a single-integer query on a program name.
        unsafe { gl.get_programiv(program_id, glw::GL_DELETE_STATUS, &mut delete_flagged) };
        errors.check(delete_flagged != 0, "Program object was not flagged as deleted");

        // SAFETY: makes no program current, always valid.
        unsafe { gl.use_program(0) };
        errors.check(
            unsafe { gl.is_program(program_id) } == 0,
            "Deleted program name still valid after being made non-current",
        );
        Ok(errors.into_status())
    }
}

// ---------------------------------------------------------------------------
// AttachmentTest / InputAttachmentTest / OutputAttachmentTest
// ---------------------------------------------------------------------------

fn attacher_name(attacher: &dyn Attacher) -> String {
    format!(
        "{}_{}",
        attacher.element_type().get_name(),
        attacher.container_type().get_name()
    )
}

/// `AttachmentTest::testDeletedNames` - the only `AttachmentTest` test function
/// upstream's own `addTestCases` ever registers (`testDeletedBinding`/
/// `testDeletedReattach` are declared but neither defined nor used, see this file's
/// header comment).
struct AttachmentTest {
    name: String,
    attacher: Arc<dyn Attacher>,
}

impl TestCase for AttachmentTest {
    fn name(&self) -> &str {
        &self.name
    }
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let elem_type = self.attacher.element_type();
        let container_type = self.attacher.container_type();
        let container = NameGuard::new(container_type, gl);
        let mut errors = ResultCollector::new();
        let element_id;

        {
            let element = NameGuard::new(elem_type.clone(), gl);
            element_id = element.get();
            self.attacher.init_attachment(context, 0, element_id)?;
            self.attacher.attach(context, element_id, container.get())?;
            errors.check(
                self.attacher.get_attachment(context, container.get()) == element_id,
                "Attachment name not returned by query even before deletion.",
            );
        }

        // "Such a container or other context may continue using the object, and may
        // still contain state identifying its name as being currently bound" -
        // interpreted, as upstream does, as: whenever the container has a deleted
        // object attached to it, a query returns that object's former name.
        errors.check(
            self.attacher.get_attachment(context, container.get()) == element_id,
            "Attachment name not returned by query after attachment was deleted.",
        );

        if elem_type.name_lingers() {
            errors.check(
                elem_type.exists(gl, element_id),
                "Attached object name no longer valid after deletion.",
            );
        } else {
            errors.check(
                !elem_type.exists(gl, element_id),
                "Attached object name still valid after deletion.",
            );
        }

        self.attacher.detach(context, element_id, container.get())?;
        errors.check(
            self.attacher.get_attachment(context, container.get()) == 0,
            "Attachment name returned by query even after detachment.",
        );
        errors.check(
            !elem_type.exists(gl, element_id),
            "Deleted attached object name still usable after detachment.",
        );

        Ok(errors.into_status())
    }
}

struct InputAttachmentTest {
    name: String,
    input_attacher: Arc<dyn InputAttacher>,
}

impl TestCase for InputAttachmentTest {
    fn name(&self) -> &str {
        &self.name
    }
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let attacher = self.input_attacher.attacher();
        let container_type = attacher.container_type();
        let element_type = attacher.element_type();
        let mut rnd = Random::new(de_string_hash(&self.name));
        let ref_seed = rnd.get_uint32();
        let new_seed = rnd.get_uint32();
        let mut errors = ResultCollector::new();

        let container = NameGuard::new(container_type, gl);
        let element_id;
        let ref_surface;
        {
            let element = NameGuard::new(element_type.clone(), gl);
            element_id = element.get();
            attacher.init_attachment(context, ref_seed, element_id)?;
            attacher.attach(context, element_id, container.get())?;
            ref_surface = self.input_attacher.draw_container(context, container.get())?;
            // `element` drops here: the attachment is deleted while still attached.
        }

        let del_surface;
        {
            let new_id = replace_name(gl, element_type.as_ref(), element_id);
            let _new_guard = NameGuard::with_name(element_type.clone(), gl, new_id);

            attacher.init_attachment(context, new_seed, new_id)?;

            del_surface = self.input_attacher.draw_container(context, container.get())?;
            attacher.detach(context, element_id, container.get())?;

            attacher.attach(context, new_id, container.get())?;
            let _ = self.input_attacher.draw_container(context, container.get())?;
            attacher.detach(context, new_id, container.get())?;
        }

        let cmp = pixel_threshold_compare(&ref_surface, &del_surface, RGBA::new(0, 0, 0, 0));
        errors.check(
            cmp.ok,
            "Writing to a fresh object modified the container with a deleted attachment.",
        );

        Ok(errors.into_status())
    }
}

struct OutputAttachmentTest {
    name: String,
    output_attacher: Arc<dyn OutputAttacher>,
}

impl TestCase for OutputAttachmentTest {
    fn name(&self) -> &str {
        &self.name
    }
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let attacher = self.output_attacher.attacher();
        let container_type = attacher.container_type();
        let element_type = attacher.element_type();
        let mut rnd = Random::new(de_string_hash(&self.name));
        let ref_seed = rnd.get_uint32();
        let new_seed = rnd.get_uint32();
        let mut errors = ResultCollector::new();

        let container = NameGuard::new(container_type, gl);
        let element_id;
        {
            let element = NameGuard::new(element_type.clone(), gl);
            element_id = element.get();
            attacher.init_attachment(context, 0, element_id)?;
            attacher.attach(context, element_id, container.get())?;

            self.output_attacher
                .setup_container(context, ref_seed, container.get())?;
            let _ = self.output_attacher.draw_attachment(context, element_id)?;
            // `element` drops here: the attachment is deleted while still attached.
        }

        let new_surface;
        let del_surface;
        {
            let new_id = replace_name(gl, element_type.as_ref(), element_id);
            let _new_guard = NameGuard::with_name(element_type.clone(), gl, new_id);

            attacher.init_attachment(context, new_seed, new_id)?;
            new_surface = self.output_attacher.draw_attachment(context, new_id)?;

            self.output_attacher
                .setup_container(context, ref_seed, container.get())?;
            del_surface = self.output_attacher.draw_attachment(context, new_id)?;
        }
        attacher.detach(context, element_id, container.get())?;

        let cmp = pixel_threshold_compare(&new_surface, &del_surface, RGBA::new(0, 0, 0, 0));
        errors.check(
            cmp.ok,
            "Writing to container with deleted attachment modified a new object.",
        );

        Ok(errors.into_status())
    }
}

// ---------------------------------------------------------------------------
// Types collection + registration
// ---------------------------------------------------------------------------

/// `LifetimeTests::details::Types` - just the four collections upstream's own base
/// class exposes; nothing here needs the pure-virtual `getProgramType` (`DeleteUsedCase`
/// above is hardcoded to "program" instead, see its own doc comment).
pub struct LifetimeTypes {
    pub types: Vec<Arc<dyn LifetimeType>>,
    pub attachers: Vec<Arc<dyn Attacher>>,
    pub in_attachers: Vec<Arc<dyn InputAttacher>>,
    pub out_attachers: Vec<Arc<dyn OutputAttacher>>,
}

/// `ES2Types` - lives in the shared framework (as it does upstream) so `ES3Types`, in
/// the gles3 module, can build on top of it.
pub fn es2_types() -> LifetimeTypes {
    let buffer_bind: Arc<dyn Binder> = Arc::new(SimpleBinder {
        bind_fn: SimpleBindFn::Buffer,
        bind_target: glw::GL_ARRAY_BUFFER,
        binding_param: glw::GL_ARRAY_BUFFER_BINDING,
        gen_required: false,
    });
    let buffer_type: Arc<dyn LifetimeType> = Arc::new(SimpleType {
        name: "buffer",
        gen_fn: GenFn::Buffers,
        delete_fn: DeleteFn::Buffers,
        exists_fn: ExistsFn::Buffer,
        binder: Some(buffer_bind),
        gen_creates: false,
    });

    let texture_bind: Arc<dyn Binder> = Arc::new(SimpleBinder {
        bind_fn: SimpleBindFn::Texture,
        bind_target: glw::GL_TEXTURE_2D,
        binding_param: glw::GL_TEXTURE_BINDING_2D,
        gen_required: false,
    });
    let texture_type: Arc<dyn LifetimeType> = Arc::new(SimpleType {
        name: "texture",
        gen_fn: GenFn::Textures,
        delete_fn: DeleteFn::Textures,
        exists_fn: ExistsFn::Texture,
        binder: Some(texture_bind),
        gen_creates: false,
    });

    let rbo_bind: Arc<dyn Binder> = Arc::new(SimpleBinder {
        bind_fn: SimpleBindFn::Renderbuffer,
        bind_target: glw::GL_RENDERBUFFER,
        binding_param: glw::GL_RENDERBUFFER_BINDING,
        gen_required: false,
    });
    let rbo_type: Arc<dyn LifetimeType> = Arc::new(SimpleType {
        name: "renderbuffer",
        gen_fn: GenFn::Renderbuffers,
        delete_fn: DeleteFn::Renderbuffers,
        exists_fn: ExistsFn::Renderbuffer,
        binder: Some(rbo_bind),
        gen_creates: false,
    });

    let fbo_bind: Arc<dyn Binder> = Arc::new(SimpleBinder {
        bind_fn: SimpleBindFn::Framebuffer,
        bind_target: glw::GL_FRAMEBUFFER,
        binding_param: glw::GL_FRAMEBUFFER_BINDING,
        gen_required: false,
    });
    let fbo_type: Arc<dyn LifetimeType> = Arc::new(SimpleType {
        name: "framebuffer",
        gen_fn: GenFn::Framebuffers,
        delete_fn: DeleteFn::Framebuffers,
        exists_fn: ExistsFn::Framebuffer,
        binder: Some(fbo_bind),
        gen_creates: false,
    });

    let shader_type: Arc<dyn LifetimeType> = Arc::new(ShaderType);
    let program_type: Arc<dyn LifetimeType> = Arc::new(ProgramType);

    let tex_fbo_att: Arc<dyn Attacher> = Arc::new(TextureFboAttacher {
        element_type: texture_type.clone(),
        container_type: fbo_type.clone(),
    });
    let rbo_fbo_att: Arc<dyn Attacher> = Arc::new(RboFboAttacher {
        element_type: rbo_type.clone(),
        container_type: fbo_type.clone(),
    });
    let shader_att: Arc<dyn Attacher> = Arc::new(ShaderProgramAttacher {
        element_type: shader_type.clone(),
        container_type: program_type.clone(),
    });

    let tex_fbo_in: Arc<dyn InputAttacher> = Arc::new(FboInputAttacher {
        attacher: tex_fbo_att.clone(),
    });
    let rbo_fbo_in: Arc<dyn InputAttacher> = Arc::new(FboInputAttacher {
        attacher: rbo_fbo_att.clone(),
    });
    let shader_in: Arc<dyn InputAttacher> = Arc::new(ShaderProgramInputAttacher {
        attacher: shader_att.clone(),
    });

    let tex_fbo_out: Arc<dyn OutputAttacher> = Arc::new(FboOutputAttacher {
        attacher: tex_fbo_att.clone(),
    });
    let rbo_fbo_out: Arc<dyn OutputAttacher> = Arc::new(FboOutputAttacher {
        attacher: rbo_fbo_att.clone(),
    });

    LifetimeTypes {
        types: vec![buffer_type, texture_type, rbo_type, fbo_type, shader_type, program_type],
        attachers: vec![tex_fbo_att, rbo_fbo_att, shader_att],
        in_attachers: vec![tex_fbo_in, rbo_fbo_in, shader_in],
        out_attachers: vec![tex_fbo_out, rbo_fbo_out],
    }
}

fn create_life_test_group(
    name: &'static str,
    need_bind: bool,
    types: &[Arc<dyn LifetimeType>],
    make_case: fn(Arc<dyn LifetimeType>) -> Box<dyn TestCase>,
) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    for type_ in types {
        if !need_bind || type_.binder().is_some() {
            group.add_child(make_case(type_.clone()));
        }
    }
    group
}

/// `LifetimeTests::details::addTestCases`
pub fn add_test_cases(group: &mut TestCaseGroup, types: &LifetimeTypes) {
    group.add_child(create_life_test_group("gen", false, &types.types, |t| {
        Box::new(GenCase { type_: t })
    }));
    group.add_child(create_life_test_group("delete", false, &types.types, |t| {
        Box::new(DeleteCase { type_: t })
    }));
    group.add_child(create_life_test_group("bind", true, &types.types, |t| {
        Box::new(BindCase { type_: t })
    }));
    group.add_child(create_life_test_group("delete_bound", true, &types.types, |t| {
        Box::new(DeleteBoundCase { type_: t })
    }));
    group.add_child(create_life_test_group("bind_no_gen", true, &types.types, |t| {
        Box::new(BindNoGenCase { type_: t })
    }));

    let mut delete_used = TestCaseGroup::new("delete_used");
    delete_used.add_child(Box::new(DeleteUsedCase) as Box<dyn TestCase>);
    group.add_child(delete_used);

    let mut attach = TestCaseGroup::new("attach");

    let mut deleted_name = TestCaseGroup::new("deleted_name");
    for attacher in &types.attachers {
        let name = attacher_name(attacher.as_ref());
        deleted_name.add_child(Box::new(AttachmentTest {
            name,
            attacher: attacher.clone(),
        }) as Box<dyn TestCase>);
    }
    attach.add_child(deleted_name);

    let mut deleted_input = TestCaseGroup::new("deleted_input");
    for in_attacher in &types.in_attachers {
        let name = attacher_name(in_attacher.attacher().as_ref());
        deleted_input.add_child(Box::new(InputAttachmentTest {
            name,
            input_attacher: in_attacher.clone(),
        }) as Box<dyn TestCase>);
    }
    attach.add_child(deleted_input);

    let mut deleted_output = TestCaseGroup::new("deleted_output");
    for out_attacher in &types.out_attachers {
        let name = attacher_name(out_attacher.attacher().as_ref());
        deleted_output.add_child(Box::new(OutputAttachmentTest {
            name,
            output_attacher: out_attacher.clone(),
        }) as Box<dyn TestCase>);
    }
    attach.add_child(deleted_output);

    group.add_child(attach);
}
