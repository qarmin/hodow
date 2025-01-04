// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fLifetimeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `ES3Types` extends the shared
// `gls::lifetime_tests::es2_types()` with four more object kinds (query, transform
// feedback, vertex array, sampler) and two more attachers (buffer/VAO,
// buffer/transform-feedback) - all of it specific to ES3, so it lives here rather
// than in the shared framework, exactly as upstream's `es3fLifetimeTests.cpp` keeps
// its own copy of `VertexArrayBinder`/`QueryBinder` rather than reusing the
// same-named, unused classes already sitting in `glsLifetimeTests.cpp` (see that
// shared file's own header for why those particular upstream classes are dead code
// and not ported at all).

use std::ffi::CString;
use std::sync::Arc;

use crate::gls::lifetime_tests as lt;
use crate::glu::{
    Buffer, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, TransformFeedback, VertexArray,
};
use crate::glw::{self, GLenum, GLfloat, GLint, GLuint};
use crate::tcu::{Random, Surface, TestError, TestOutcome, TestStatus};

// ---------------------------------------------------------------------------
// ES3-only binders
// ---------------------------------------------------------------------------

/// `VertexArrayBinder`
struct VertexArrayBinder;
impl lt::Binder for VertexArrayBinder {
    fn bind(&self, gl: &glw::Functions, name: GLuint) {
        // SAFETY: plain binding state change on a current context.
        unsafe { gl.bind_vertex_array(name) };
    }
    fn get_binding(&self, gl: &glw::Functions) -> GLuint {
        let mut ret: GLint = 0;
        // SAFETY: `GL_VERTEX_ARRAY_BINDING` is a single-integer query.
        unsafe { gl.get_integerv(glw::GL_VERTEX_ARRAY_BINDING, &mut ret) };
        ret as GLuint
    }
    fn gen_required(&self) -> bool {
        true
    }
}

/// `QueryBinder`
struct QueryBinder;
impl lt::Binder for QueryBinder {
    fn bind(&self, gl: &glw::Functions, name: GLuint) {
        // SAFETY: `GL_ANY_SAMPLES_PASSED` is always a legal query target on ES3.
        unsafe {
            if name != 0 {
                gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, name);
            } else {
                gl.end_query(glw::GL_ANY_SAMPLES_PASSED);
            }
        }
    }
    fn get_binding(&self, _gl: &glw::Functions) -> GLuint {
        0
    }
}

/// `SamplerBinder` - always targets texture unit 0, exactly as upstream does.
struct SamplerBinder;
impl lt::Binder for SamplerBinder {
    fn bind(&self, gl: &glw::Functions, name: GLuint) {
        // SAFETY: plain binding state change on a current context.
        unsafe { gl.bind_sampler(0, name) };
    }
    fn get_binding(&self, gl: &glw::Functions) -> GLuint {
        let mut arr = [0 as GLint; 32];
        // SAFETY: `GL_SAMPLER_BINDING` is queried per texture unit; `arr` covers every
        // unit this suite could plausibly have bound one at, matching upstream's own
        // fixed-size array.
        unsafe { gl.get_integerv(glw::GL_SAMPLER_BINDING, arr.as_mut_ptr()) };
        arr[0] as GLuint
    }
    fn gen_required(&self) -> bool {
        true
    }
}

// ---------------------------------------------------------------------------
// ScaleProgram
// ---------------------------------------------------------------------------

const NUM_COMPONENTS: GLint = 4;
const NUM_VERTICES: usize = 3;

const SCALE_VERTEX_SRC: &str = "#version 100\nattribute vec4 pos;\nuniform float scale;\nvoid main() { gl_Position = vec4(scale * pos.xy, pos.zw); }\n";
const SCALE_FRAGMENT_SRC: &str = "#version 100\nvoid main() { gl_FragColor = vec4(1.0, 0.0, 1.0, 1.0); }\n";

/// `ScaleProgram` - recompiled on each use rather than shared for a whole test-group
/// session the way upstream's single long-lived instance is: this port builds every
/// GL resource fresh inside `TestCase::iterate`, and a fixed, trivial GLSL pair
/// compiles identically (same attribute/uniform locations) every time on any one
/// driver within a run, so nothing here depends on two calls sharing one compile.
struct ScaleProgramHandle<'gl> {
    program: ShaderProgram<'gl>,
    scale_loc: GLint,
    pos_loc: GLint,
}

impl<'gl> ScaleProgramHandle<'gl> {
    fn new(gl: &'gl glw::Functions) -> Result<Self, TestError> {
        let sources = ProgramSources::vtx_frag(SCALE_VERTEX_SRC, SCALE_FRAGMENT_SRC)
            .with_transform_feedback(&["gl_Position".to_string()], glw::GL_INTERLEAVED_ATTRIBS);
        let program = ShaderProgram::new(gl, &sources);
        if !program.is_ok() {
            return Err(TestError::Fail(
                program
                    .build_failure_summary()
                    .unwrap_or_else(|| "ScaleProgram failed to build".to_string()),
            ));
        }
        let scale_name = CString::new("scale").expect("no interior NUL");
        let pos_name = CString::new("pos").expect("no interior NUL");
        // SAFETY: `program` just linked successfully.
        let scale_loc = unsafe { gl.get_uniform_location(program.program(), scale_name.as_ptr()) };
        // SAFETY: as above.
        let pos_loc = unsafe { gl.get_attrib_location(program.program(), pos_name.as_ptr()) };
        Ok(Self {
            program,
            scale_loc,
            pos_loc,
        })
    }

    /// `ScaleProgram::setPos`
    fn set_pos(&self, gl: &glw::Functions, buffer: GLuint, vao: GLuint) {
        // SAFETY: `buffer`/`vao` are real names for the duration of this call.
        unsafe {
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer);
            gl.bind_vertex_array(vao);
            gl.vertex_attrib_pointer(
                self.pos_loc as GLuint,
                NUM_COMPONENTS,
                glw::GL_FLOAT,
                glw::GL_FALSE as glw::GLboolean,
                0,
                std::ptr::null(),
            );
            gl.bind_vertex_array(0);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        }
    }

    /// `ScaleProgram::draw` - `read` replaces upstream's nullable `Surface *dst`; the
    /// early return upstream takes when starting transform feedback fails
    /// (`GL_INVALID_OPERATION`) skips its own final `glBindVertexArray(0)` too, which
    /// is preserved here rather than "fixed" into an unconditional unbind, since the
    /// one real call site that passes `tf = true` (`BufferTfOutputAttacher::
    /// setup_container`) also passes `read = false`, so nothing this port checks can
    /// ever observe the difference.
    fn draw(
        &self,
        context: &Context,
        vao: GLuint,
        scale: GLfloat,
        tf: bool,
        read: bool,
    ) -> Result<Option<Surface>, TestError> {
        let gl = context.gl();
        let mut rnd = Random::new(vao);
        let viewport = lt::random_viewport(context.render_target(), lt::VIEWPORT_SIZE, lt::VIEWPORT_SIZE, &mut rnd);
        lt::set_viewport(gl, &viewport);

        // SAFETY: `vao` is a real vertex array name; `self.program`'s locations were
        // queried straight from this same linked program.
        unsafe {
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT);
            gl.bind_vertex_array(vao);
            gl.enable_vertex_attrib_array(self.pos_loc as GLuint);
            gl.use_program(self.program.program());
            gl.uniform_1f(self.scale_loc, scale);
        }

        if tf {
            // SAFETY: as above.
            unsafe { gl.begin_transform_feedback(glw::GL_TRIANGLES) };
            // SAFETY: `glGetError` needs only a current context.
            if unsafe { gl.get_error() } == glw::GL_INVALID_OPERATION {
                return Ok(None);
            }
        }

        // SAFETY: as above.
        unsafe { gl.draw_arrays(glw::GL_TRIANGLES, 0, 3) };
        crate::glu::expect_no_error(gl, "glDrawArrays")?;
        if tf {
            // SAFETY: transform feedback is active from the successful `begin` above.
            unsafe { gl.end_transform_feedback() };
        }

        let result = if read {
            Some(lt::read_rectangle(&context.render_context, &viewport)?)
        } else {
            None
        };
        // SAFETY: as above.
        unsafe { gl.bind_vertex_array(0) };
        Ok(result)
    }
}

// ---------------------------------------------------------------------------
// Buffer/VAO attachment (input)
// ---------------------------------------------------------------------------

static VARR_DATA: [GLfloat; NUM_VERTICES * NUM_COMPONENTS as usize] =
    [-1.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0, 0.0, -1.0, 0.0, 1.0];

/// `initBuffer` - shared by both ES3 attachers below, exactly as upstream shares one
/// free function between `BufferVAOAttacher::initAttachment` and
/// `BufferTfAttacher::initAttachment`.
fn init_buffer(gl: &glw::Functions, seed: u32, usage: GLenum, buffer: GLuint) {
    // SAFETY: `buffer` is a real buffer name for the duration of this call.
    unsafe { gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer) };
    if seed == 0 {
        // SAFETY: `VARR_DATA` outlives this call.
        unsafe {
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&VARR_DATA) as glw::GLsizeiptr,
                VARR_DATA.as_ptr().cast(),
                usage,
            )
        };
    } else {
        let mut rnd = Random::new(seed);
        let mut data = [0.0 as GLfloat; NUM_VERTICES * NUM_COMPONENTS as usize];
        for vertex in 0..NUM_VERTICES {
            let base = vertex * NUM_COMPONENTS as usize;
            data[base] = 2.0 * (rnd.get_float() - 0.5);
            data[base + 1] = 2.0 * (rnd.get_float() - 0.5);
            data[base + 2] = 0.0;
            data[base + 3] = 1.0;
        }
        // SAFETY: `data` outlives this call.
        unsafe {
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&data) as glw::GLsizeiptr,
                data.as_ptr().cast(),
                usage,
            )
        };
    }
    // SAFETY: plain binding state change.
    unsafe { gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0) };
}

/// `BufferVAOAttacher`
struct BufferVAOAttacher {
    element_type: Arc<dyn lt::LifetimeType>,
    container_type: Arc<dyn lt::LifetimeType>,
}

impl lt::Attacher for BufferVAOAttacher {
    fn init_attachment(&self, context: &Context, seed: u32, buffer: GLuint) -> Result<(), TestError> {
        init_buffer(context.gl(), seed, glw::GL_STATIC_DRAW, buffer);
        Ok(())
    }
    fn attach(&self, context: &Context, buffer: GLuint, vao: GLuint) -> Result<(), TestError> {
        let gl = context.gl();
        let program = ScaleProgramHandle::new(gl)?;
        program.set_pos(gl, buffer, vao);
        Ok(())
    }
    fn detach(&self, context: &Context, _buffer: GLuint, vao: GLuint) -> Result<(), TestError> {
        self.attach(context, 0, vao)
    }
    fn get_attachment(&self, context: &Context, vao: GLuint) -> GLuint {
        let gl = context.gl();
        let mut name: GLint = 0;
        // SAFETY: `vao` is a real vertex array name; attribute index `0` is upstream's
        // own hardcoded choice (the shader's only attribute), not `self`'s own
        // `pos_loc` - kept exactly as found.
        unsafe {
            gl.bind_vertex_array(vao);
            gl.get_vertex_attribiv(0, glw::GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING, &mut name);
            gl.bind_vertex_array(0);
        }
        name as GLuint
    }
    fn element_type(&self) -> Arc<dyn lt::LifetimeType> {
        self.element_type.clone()
    }
    fn container_type(&self) -> Arc<dyn lt::LifetimeType> {
        self.container_type.clone()
    }
}

/// `BufferVAOInputAttacher`
struct BufferVAOInputAttacher {
    attacher: Arc<dyn lt::Attacher>,
}

impl lt::InputAttacher for BufferVAOInputAttacher {
    fn attacher(&self) -> Arc<dyn lt::Attacher> {
        self.attacher.clone()
    }
    fn draw_container(&self, context: &Context, vao: GLuint) -> Result<Surface, TestError> {
        let program = ScaleProgramHandle::new(context.gl())?;
        Ok(program
            .draw(context, vao, 1.0, false, true)?
            .expect("draw with read=true and tf=false always returns a surface"))
    }
}

// ---------------------------------------------------------------------------
// Buffer/transform-feedback attachment (output)
// ---------------------------------------------------------------------------

/// `BufferTfAttacher`
struct BufferTfAttacher {
    element_type: Arc<dyn lt::LifetimeType>,
    container_type: Arc<dyn lt::LifetimeType>,
}

impl lt::Attacher for BufferTfAttacher {
    fn init_attachment(&self, context: &Context, seed: u32, buffer: GLuint) -> Result<(), TestError> {
        init_buffer(context.gl(), seed, glw::GL_DYNAMIC_READ, buffer);
        Ok(())
    }
    fn attach(&self, context: &Context, buffer: GLuint, tf: GLuint) -> Result<(), TestError> {
        let gl = context.gl();
        // SAFETY: `buffer`/`tf` are real names for the duration of this call.
        unsafe {
            gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tf);
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, buffer);
            gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, 0);
        }
        Ok(())
    }
    fn detach(&self, context: &Context, _buffer: GLuint, tf: GLuint) -> Result<(), TestError> {
        let gl = context.gl();
        // SAFETY: as above.
        unsafe {
            gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tf);
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0);
            gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, 0);
        }
        Ok(())
    }
    fn get_attachment(&self, context: &Context, tf: GLuint) -> GLuint {
        let gl = context.gl();
        let mut ret: GLint = 0;
        // SAFETY: `tf` is a real transform feedback object name.
        unsafe {
            gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tf);
            gl.get_integeri_v(glw::GL_TRANSFORM_FEEDBACK_BUFFER_BINDING, 0, &mut ret);
            gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, 0);
        }
        ret as GLuint
    }
    fn element_type(&self) -> Arc<dyn lt::LifetimeType> {
        self.element_type.clone()
    }
    fn container_type(&self) -> Arc<dyn lt::LifetimeType> {
        self.container_type.clone()
    }
}

/// `BufferTfOutputAttacher`
struct BufferTfOutputAttacher {
    attacher: Arc<dyn lt::Attacher>,
}

impl lt::OutputAttacher for BufferTfOutputAttacher {
    fn attacher(&self) -> Arc<dyn lt::Attacher> {
        self.attacher.clone()
    }
    fn setup_container(&self, context: &Context, seed: u32, tf: GLuint) -> Result<(), TestError> {
        let gl = context.gl();
        let pos_buf = Buffer::new(gl);
        let vao = VertexArray::new(gl);

        init_buffer(gl, seed, glw::GL_STATIC_DRAW, pos_buf.get());
        let program = ScaleProgramHandle::new(gl)?;
        program.set_pos(gl, pos_buf.get(), vao.get());

        // SAFETY: `tf` is a real transform feedback object name.
        unsafe { gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tf) };
        program.draw(context, vao.get(), -1.0, true, false)?;
        // SAFETY: as above.
        unsafe { gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, 0) };
        Ok(())
    }
    fn draw_attachment(&self, context: &Context, buffer: GLuint) -> Result<Surface, TestError> {
        let gl = context.gl();
        let vao = VertexArray::new(gl);
        let program = ScaleProgramHandle::new(gl)?;
        program.set_pos(gl, buffer, vao.get());
        Ok(program
            .draw(context, vao.get(), 1.0, false, true)?
            .expect("draw with read=true and tf=false always returns a surface"))
    }
}

// ---------------------------------------------------------------------------
// ES3Types
// ---------------------------------------------------------------------------

/// `ES3Types`
pub fn es3_types() -> lt::LifetimeTypes {
    let mut base = lt::es2_types();

    let query_bind: Arc<dyn lt::Binder> = Arc::new(QueryBinder);
    let query_type: Arc<dyn lt::LifetimeType> = Arc::new(lt::SimpleType {
        name: "query",
        gen_fn: lt::GenFn::Queries,
        delete_fn: lt::DeleteFn::Queries,
        exists_fn: lt::ExistsFn::Query,
        binder: Some(query_bind),
        gen_creates: false,
    });

    let tf_bind: Arc<dyn lt::Binder> = Arc::new(lt::SimpleBinder {
        bind_fn: lt::SimpleBindFn::TransformFeedback,
        bind_target: glw::GL_TRANSFORM_FEEDBACK,
        binding_param: glw::GL_TRANSFORM_FEEDBACK_BINDING,
        gen_required: true,
    });
    let tf_type: Arc<dyn lt::LifetimeType> = Arc::new(lt::SimpleType {
        name: "transform_feedback",
        gen_fn: lt::GenFn::TransformFeedbacks,
        delete_fn: lt::DeleteFn::TransformFeedbacks,
        exists_fn: lt::ExistsFn::TransformFeedback,
        binder: Some(tf_bind),
        gen_creates: false,
    });

    let varr_bind: Arc<dyn lt::Binder> = Arc::new(VertexArrayBinder);
    let varr_type: Arc<dyn lt::LifetimeType> = Arc::new(lt::SimpleType {
        name: "vertex_array",
        gen_fn: lt::GenFn::VertexArrays,
        delete_fn: lt::DeleteFn::VertexArrays,
        exists_fn: lt::ExistsFn::VertexArray,
        binder: Some(varr_bind),
        gen_creates: false,
    });

    let sampler_bind: Arc<dyn lt::Binder> = Arc::new(SamplerBinder);
    let sampler_type: Arc<dyn lt::LifetimeType> = Arc::new(lt::SimpleType {
        name: "sampler",
        gen_fn: lt::GenFn::Samplers,
        delete_fn: lt::DeleteFn::Samplers,
        exists_fn: lt::ExistsFn::Sampler,
        binder: Some(sampler_bind),
        gen_creates: true,
    });

    // `buffer` is `es2_types()`'s own first entry - see that function's own return order.
    let buffer_type = base.types[0].clone();

    let buf_varr_att: Arc<dyn lt::Attacher> = Arc::new(BufferVAOAttacher {
        element_type: buffer_type.clone(),
        container_type: varr_type.clone(),
    });
    let buf_varr_in: Arc<dyn lt::InputAttacher> = Arc::new(BufferVAOInputAttacher {
        attacher: buf_varr_att.clone(),
    });

    let buf_tf_att: Arc<dyn lt::Attacher> = Arc::new(BufferTfAttacher {
        element_type: buffer_type,
        container_type: tf_type.clone(),
    });
    let buf_tf_out: Arc<dyn lt::OutputAttacher> = Arc::new(BufferTfOutputAttacher {
        attacher: buf_tf_att.clone(),
    });

    base.types.extend([query_type, tf_type, varr_type, sampler_type]);
    base.attachers.push(buf_varr_att);
    base.attachers.push(buf_tf_att);
    base.in_attachers.push(buf_varr_in);
    base.out_attachers.push(buf_tf_out);

    base
}

// ---------------------------------------------------------------------------
// delete_active.transform_feedback
// ---------------------------------------------------------------------------

const XFB_VERTEX_SRC: &str = "#version 300 es\nvoid main ()\n{\n    gl_Position = vec4(float(gl_VertexID) / 2.0, float(gl_VertexID % 2) / 2.0, 0.0, 1.0);\n}\n";
const XFB_FRAGMENT_SRC: &str = "#version 300 es\nlayout(location=0) out mediump vec4 dEQP_FragColor;\nvoid main ()\n{\n    dEQP_FragColor = vec4(1.0, 1.0, 0.0, 1.0);\n}\n";

/// `TfDeleteActiveTest` - the one `lifetime` test in this port that is not built out of
/// the shared `gls::lifetime_tests` framework, exactly as upstream keeps it as a
/// standalone `TestCase` rather than another `LifeTest`/`AttachmentTest` variant.
struct TfDeleteActiveTest;

impl TestCase for TfDeleteActiveTest {
    fn name(&self) -> &str {
        "transform_feedback"
    }
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        let sources = ProgramSources::vtx_frag(XFB_VERTEX_SRC, XFB_FRAGMENT_SRC)
            .with_transform_feedback(&["gl_Position".to_string()], glw::GL_INTERLEAVED_ATTRIBS);
        let program = ShaderProgram::new(gl, &sources);
        if !program.is_ok() {
            return Err(TestError::Fail(
                program
                    .build_failure_summary()
                    .unwrap_or_else(|| "failed to build program".to_string()),
            ));
        }

        let buf = Buffer::new(gl);
        let tf = TransformFeedback::new(gl);

        // SAFETY: `program`/`tf`/`buf` are all real, freshly created names.
        unsafe {
            gl.use_program(program.program());
            gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, tf.get());
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, buf.get());
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                (3 * NUM_COMPONENTS as usize * std::mem::size_of::<GLfloat>()) as glw::GLsizeiptr,
                std::ptr::null(),
                glw::GL_DYNAMIC_COPY,
            );
        }
        crate::glu::expect_no_error(gl, "transform feedback setup")?;

        // SAFETY: `tf` is currently bound.
        unsafe { gl.begin_transform_feedback(glw::GL_TRIANGLES) };

        // The check this whole case exists for: deleting the *active* transform
        // feedback object must fail with `GL_INVALID_OPERATION` and leave it alive -
        // `tf`'s own `Drop` deletes it for real once it is no longer active, below.
        // SAFETY: `tf.get()` names a real, currently active transform feedback object.
        let delete_failed_as_expected = unsafe {
            gl.delete_transform_feedbacks(1, &tf.get());
            gl.get_error() == glw::GL_INVALID_OPERATION
        };

        // SAFETY: transform feedback is active from the successful `begin` above.
        unsafe { gl.end_transform_feedback() };
        crate::glu::expect_no_error(gl, "glEndTransformFeedback")?;

        if delete_failed_as_expected {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail(
                "Deleting active transform feedback did not produce GL_INVALID_OPERATION",
            ))
        }
    }
}

// ---------------------------------------------------------------------------

/// `TestGroup::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("lifetime");
    let types = es3_types();
    lt::add_test_cases(&mut group, &types);

    let mut delete_active = TestCaseGroup::new("delete_active");
    delete_active.add_child(Box::new(TfDeleteActiveTest) as Box<dyn TestCase>);
    group.add_child(delete_active);

    group
}
