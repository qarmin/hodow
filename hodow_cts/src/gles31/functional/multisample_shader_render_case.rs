// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fMultisampleShaderRenderCase.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's `MultisampleRenderCase` is an abstract base class with an `init`/`iterate`
// split that the harness calls `m_numIterations` times. This harness calls `iterate`
// once, so the whole thing is one `run` function holding the resources as locals (their
// `Drop` is upstream's `deinit`) and looping over the iterations itself. What the
// subclasses override is a trait, `MultisampleRenderCaseBody`, whose methods carry
// upstream's own names.
//
// `tcu::TestLog::Image` output is dropped throughout: this runner has no image log and
// every verdict here comes from counting or comparing pixels, never from the image.

use std::collections::BTreeMap;
use std::ffi::{CString, c_void};

use crate::glu::{self, Context, GlslVersion};
use crate::glw::{self, GLenum, GLuint};
use crate::tcu::{Surface, TestError, TestOutcome, TestResult, TestStatus};

/// `MultisampleShaderRenderUtil::QualityWarning` - a result within specification but of
/// low quality, which upstream raises as an exception from `verifyImage`.
pub struct QualityWarning(pub String);

/// `MultisampleRenderCase::RenderTarget`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum RenderTarget {
    Default,
    Texture,
    Renderbuffer,
}

/// `MultisampleRenderCase::Attrib`
#[derive(Clone, Copy)]
pub struct Attrib {
    pub offset: i32,
    pub stride: i32,
}

/// What `MultisampleRenderCase::setupRenderData` fills in.
///
/// Upstream writes straight into the base class's members and uploads the buffer itself;
/// returning it keeps the one `glBufferData` call in the framework, where the buffer
/// object lives.
pub struct RenderData {
    /// `m_renderMode`
    pub render_mode: GLenum,
    /// `m_renderCount`
    pub render_count: i32,
    /// `m_renderSceneDescription`
    pub scene_description: String,
    /// `m_renderAttribs` - a `std::map` upstream, so the iteration order is by name.
    pub attribs: BTreeMap<String, Attrib>,
    /// The bytes `setupRenderData` uploads into `m_buffer`.
    pub vertices: Vec<f32>,
}

/// The fullscreen quad `MultisampleRenderCase::setupRenderData` uploads by default, and
/// also the one the MSAA texture resolve pass draws.
const FULLSCREEN_QUAD: [f32; 16] = [
    1.0, -1.0, 0.0, 1.0, //
    1.0, 1.0, 0.0, 1.0, //
    -1.0, -1.0, 0.0, 1.0, //
    -1.0, 1.0, 0.0, 1.0,
];

impl RenderData {
    /// The body of `MultisampleRenderCase::setupRenderData`.
    pub fn fullscreen_quad() -> Self {
        Self {
            render_mode: glw::GL_TRIANGLE_STRIP,
            render_count: 4,
            scene_description: "quad".to_string(),
            attribs: BTreeMap::from([(
                "a_position".to_string(),
                Attrib {
                    offset: 0,
                    stride: std::mem::size_of::<[f32; 4]>() as i32,
                },
            )]),
            vertices: FULLSCREEN_QUAD.to_vec(),
        }
    }
}

/// What the base class knows about the run in progress: upstream's `m_*` members that a
/// subclass hook reads.
pub struct CaseState {
    /// `m_numRequestedSamples`
    pub num_requested_samples: i32,
    /// `m_renderTarget`
    pub render_target: RenderTarget,
    /// `m_renderSize`
    pub render_size: i32,
    /// `m_numTargetSamples`
    pub num_target_samples: i32,
    /// `m_iteration`
    pub iteration: i32,
    /// `m_numIterations`
    pub num_iterations: i32,
    /// `m_context.getRenderTarget().getNumSamples()` - a hook that needs it has no
    /// `Context` of its own, and it is a fixed property of the run.
    pub default_framebuffer_samples: i32,
}

/// `MultisampleRenderCase`'s virtual methods.
///
/// Every default here is upstream's own default; a method upstream declares pure virtual
/// has no default.
pub trait MultisampleRenderCaseBody: Send + Sync {
    /// The part of a subclass's `init` that runs *before* `MultisampleRenderCase::init`:
    /// the extension/target requirements and the "test purpose and expectations" log.
    fn pre_init(&self, context: &Context, state: &CaseState) -> Result<(), TestError> {
        let _ = (context, state);
        Ok(())
    }

    /// The part of a subclass's `init` that runs *after* `MultisampleRenderCase::init`,
    /// i.e. once `m_numTargetSamples` is known. This is where `m_numIterations` is set.
    fn post_init(&self, state: &mut CaseState) -> Result<(), TestError> {
        let _ = state;
        Ok(())
    }

    /// `genFragmentSource` - pure virtual upstream.
    fn gen_fragment_source(&self, context: &Context, state: &CaseState, num_target_samples: i32) -> String;

    /// `genVertexSource`
    fn gen_vertex_source(&self, context: &Context, state: &CaseState, num_target_samples: i32) -> String {
        let _ = (state, num_target_samples);
        gen_default_vertex_source(context)
    }

    /// `verifyImage` - pure virtual upstream.
    fn verify_image(&self, state: &CaseState, result_image: &Surface) -> Result<bool, QualityWarning>;

    /// `verifySampleBuffers` - upstream's default is `DE_ASSERT(false)`, reachable only
    /// with `FLAG_VERIFY_MSAA_TEXTURE_SAMPLE_BUFFERS` set and no override.
    fn verify_sample_buffers(&self, state: &CaseState, result_buffers: &[Surface]) -> Result<bool, QualityWarning> {
        let _ = (state, result_buffers);
        unreachable!("verifySampleBuffers with no override")
    }

    /// `setupRenderData`
    fn setup_render_data(&self, state: &CaseState) -> RenderData {
        let _ = state;
        RenderData::fullscreen_quad()
    }

    /// `preDraw` - `program` is upstream's `m_program->getProgram()`, which a hook that
    /// sets a uniform reaches through the base class.
    fn pre_draw(&self, context: &Context, state: &CaseState, program: GLuint) -> Result<(), TestError> {
        let _ = (context, state, program);
        Ok(())
    }

    /// `postDraw`
    fn post_draw(&self, context: &Context, state: &CaseState, program: GLuint) -> Result<(), TestError> {
        let _ = (context, state, program);
        Ok(())
    }

    /// `preTest`
    fn pre_test(&self, context: &Context, state: &CaseState) -> Result<(), TestError> {
        let _ = (context, state);
        Ok(())
    }

    /// `postTest` - `result` is `m_testCtx`, which `SampleMaskUniqueSetCase::postTest`
    /// sets directly because its verification spans every iteration.
    fn post_test(&self, context: &Context, state: &CaseState, result: &mut TestStatus) -> Result<(), TestError> {
        let _ = (context, state, result);
        Ok(())
    }

    /// `getIterationDescription` - upstream's default is `DE_ASSERT(false)`, reachable
    /// only once `m_numIterations > 1`, which only a subclass can arrange.
    fn get_iteration_description(&self, iteration: i32) -> String {
        let _ = iteration;
        unreachable!("getIterationDescription with no override")
    }
}

/// `MultisampleRenderCase`'s constructor arguments.
pub struct Config {
    /// `numSamples`
    pub num_samples: i32,
    /// `target`
    pub target: RenderTarget,
    /// `renderSize`
    pub render_size: i32,
    /// `FLAG_PER_ITERATION_SHADER`
    pub per_iteration_shader: bool,
    /// `FLAG_VERIFY_MSAA_TEXTURE_SAMPLE_BUFFERS`
    pub verify_msaa_texture_sample_buffers: bool,
}

impl Config {
    pub fn new(num_samples: i32, target: RenderTarget, render_size: i32) -> Self {
        Self {
            num_samples,
            target,
            render_size,
            per_iteration_shader: false,
            verify_msaa_texture_sample_buffers: false,
        }
    }
}

/// The `${GLSL_VERSION_DECL}` every shader here starts with.
///
/// Upstream runs the same substitution through `tcu::StringTemplate`; there is one key
/// and it is always this, so the template machinery buys nothing.
pub fn glsl_version_decl(context: &Context) -> &'static str {
    if context.context_type().supports(3, 2) {
        GlslVersion::Es320.declaration()
    } else {
        GlslVersion::Es310.declaration()
    }
}

/// `s_vertexSource`, specialized.
pub fn gen_default_vertex_source(context: &Context) -> String {
    format!(
        "{}\n\
         in highp vec4 a_position;\n\
         out highp vec4 v_position;\n\
         void main (void)\n\
         {{\n\
         \x20   gl_Position = a_position;\n\
         \x20   v_position = a_position;\n\
         }}",
        glsl_version_decl(context)
    )
}

/// `genMSTextureResolverSource` - the default multisample resolve, i.e. average.
fn gen_ms_texture_resolver_source(
    context: &Context,
    render_size: i32,
    num_requested_samples: i32,
    num_target_samples: i32,
) -> String {
    let is_single_sample_target = num_requested_samples == 0;
    let sampler = if is_single_sample_target {
        "sampler2D"
    } else {
        "sampler2DMS"
    };

    let mut buf = format!(
        "{}\n\
         in mediump vec4 v_position;\n\
         layout(location = 0) out mediump vec4 fragColor;\n\
         uniform mediump {sampler} u_sampler;\n\
         void main (void)\n\
         {{\n\
         \x20   mediump vec2 relPosition = (v_position.xy + vec2(1.0, 1.0)) / 2.0;\n\
         \x20   mediump ivec2 fetchPos = ivec2(floor(relPosition * {render_size}.0));\n\
         \x20   mediump vec4 colorSum = vec4(0.0, 0.0, 0.0, 0.0);\n\
         \n",
        glsl_version_decl(context)
    );

    if is_single_sample_target {
        buf.push_str("    colorSum = texelFetch(u_sampler, fetchPos, 0);\n\n");
    } else {
        buf.push_str(&format!(
            "    for (int sampleNdx = 0; sampleNdx < {num_target_samples}; ++sampleNdx)\n\
             \x20       colorSum += texelFetch(u_sampler, fetchPos, sampleNdx);\n\
             \x20   colorSum /= {num_target_samples}.0;\n\
             \n"
        ));
    }

    buf.push_str("    fragColor = vec4(colorSum.xyz, 1.0);\n}\n");
    buf
}

/// `genMSTextureLayerFetchSource` - one sample layer per draw.
fn gen_ms_texture_layer_fetch_source(context: &Context, render_size: i32, num_requested_samples: i32) -> String {
    let sampler = if num_requested_samples == 0 {
        "sampler2D"
    } else {
        "sampler2DMS"
    };

    format!(
        "{}\n\
         in mediump vec4 v_position;\n\
         layout(location = 0) out mediump vec4 fragColor;\n\
         uniform mediump {sampler} u_sampler;\n\
         uniform mediump int u_sampleNdx;\n\
         void main (void)\n\
         {{\n\
         \x20   mediump vec2 relPosition = (v_position.xy + vec2(1.0, 1.0)) / 2.0;\n\
         \x20   mediump ivec2 fetchPos = ivec2(floor(relPosition * {render_size}.0));\n\
         \n\
         \x20   mediump vec4 color = texelFetch(u_sampler, fetchPos, u_sampleNdx);\n\
         \x20   fragColor = vec4(color.rgb, 1.0);\n\
         }}\n",
        glsl_version_decl(context)
    )
}

/// `getMaxConformantSampleCount`
fn get_max_conformant_sample_count(
    context: &Context,
    target: GLenum,
    internal_format: GLenum,
) -> Result<i32, TestError> {
    let gl = context.gl();
    let mut max_texture_samples = 0;

    if context
        .context_info
        .is_extension_supported("GL_NV_internalformat_sample_query")
    {
        let mut gl_sample_counts = 0;
        // SAFETY: a one-element query for a count.
        unsafe {
            gl.get_internalformativ(
                target,
                internal_format,
                glw::GL_NUM_SAMPLE_COUNTS,
                1,
                &mut gl_sample_counts,
            )
        };
        glu::expect_no_error(gl, "glGetInternalformativ() failed for GL_NUM_SAMPLE_COUNTS pname")?;

        let mut gl_supported_samples = vec![0i32; gl_sample_counts.max(0) as usize];
        // SAFETY: the array is sized from the count the driver just reported.
        unsafe {
            gl.get_internalformativ(
                target,
                internal_format,
                glw::GL_SAMPLES,
                gl_sample_counts,
                gl_supported_samples.as_mut_ptr(),
            )
        };

        for &samples in &gl_supported_samples {
            let mut is_conformant = 0;
            // SAFETY: the extension is present, so the entry point is loaded, and one
            // integer of output is asked for and given.
            unsafe {
                gl.get_internalformat_sampleiv_nv(
                    target,
                    internal_format,
                    samples,
                    glw::GL_CONFORMANT_NV,
                    1,
                    &mut is_conformant,
                )
            };
            glu::expect_no_error(gl, "glGetInternalformatSampleivNV() call(s) failed")?;

            if is_conformant != 0 && samples > max_texture_samples {
                max_texture_samples = samples;
            }
        }
    } else {
        // SAFETY: one integer of output, which is what GL_SAMPLES' first element is.
        unsafe { gl.get_internalformativ(target, internal_format, glw::GL_SAMPLES, 1, &mut max_texture_samples) };
    }

    Ok(max_texture_samples)
}

/// The resources `MultisampleRenderCase::init` creates and `deinit` destroys.
struct Resources<'gl> {
    buffer: glu::Buffer<'gl>,
    resolve_buffer: glu::Buffer<'gl>,
    render_vao: glu::VertexArray<'gl>,
    resolve_vao: Option<glu::VertexArray<'gl>>,
    fbo: Option<glu::Framebuffer<'gl>>,
    fbo_texture: Option<glu::Texture<'gl>>,
    fbo_rbo: Option<glu::Renderbuffer<'gl>>,
    resolve_fbo: Option<glu::Framebuffer<'gl>>,
    _resolve_fbo_texture: Option<glu::Texture<'gl>>,
    texture_sampler_program: Option<glu::ShaderProgram<'gl>>,
}

/// `MultisampleRenderCase::iterate`, plus the `init` it is always preceded by.
///
/// The verdict starts at Pass exactly as upstream's `iterate` sets it on the first
/// iteration; a later iteration can only make it worse, since nothing ever sets it back
/// to Pass.
pub fn run(context: &Context, config: &Config, body: &dyn MultisampleRenderCaseBody) -> TestOutcome {
    let gl = context.gl();
    let render_size = config.render_size;
    let verify_texture_sample_buffers =
        config.verify_msaa_texture_sample_buffers && config.target == RenderTarget::Texture;

    let mut state = CaseState {
        num_requested_samples: config.num_samples,
        render_target: config.target,
        render_size,
        num_target_samples: -1,
        iteration: 0,
        num_iterations: 1,
        default_framebuffer_samples: context.render_target().num_samples,
    };

    body.pre_init(context, &state)?;

    // MultisampleRenderCase::init - requirements

    match config.target {
        RenderTarget::Default => {
            let target = context.render_target();
            if target.width < render_size || target.height < render_size {
                return Err(TestError::NotSupported(format!(
                    "Test requires render target with size {render_size}x{render_size} or greater"
                )));
            }
        }
        RenderTarget::Texture => {
            let max_texture_samples =
                get_max_conformant_sample_count(context, glw::GL_TEXTURE_2D_MULTISAMPLE, glw::GL_RGBA8)?;
            if config.num_samples > max_texture_samples {
                return Err(TestError::NotSupported("Sample count not supported".to_string()));
            }
        }
        RenderTarget::Renderbuffer => {
            let max_rbo_samples = get_max_conformant_sample_count(context, glw::GL_RENDERBUFFER, glw::GL_RGBA8)?;
            if config.num_samples > max_rbo_samples {
                return Err(TestError::NotSupported("Sample count not supported".to_string()));
            }
        }
    }

    // resources

    let mut res = Resources {
        buffer: glu::Buffer::new(gl),
        resolve_buffer: glu::Buffer::new(gl),
        render_vao: glu::VertexArray::new(gl),
        resolve_vao: None,
        fbo: None,
        fbo_texture: None,
        fbo_rbo: None,
        resolve_fbo: None,
        _resolve_fbo_texture: None,
        texture_sampler_program: None,
    };
    glu::expect_no_error(gl, "gen buf")?;

    let render_data = body.setup_render_data(&state);
    // SAFETY: the buffer this call owns, and a slice whose byte length is computed from
    // its own element count.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, res.buffer.get());
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(render_data.vertices.as_slice()) as isize,
            render_data.vertices.as_ptr().cast::<c_void>(),
            glw::GL_STATIC_DRAW,
        );
    }
    glu::expect_no_error(gl, "setup data")?;

    // buffer for MSAA texture resolving
    // SAFETY: as above, for a constant-size quad.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, res.resolve_buffer.get());
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(&FULLSCREEN_QUAD) as isize,
            FULLSCREEN_QUAD.as_ptr().cast::<c_void>(),
            glw::GL_STATIC_DRAW,
        );
    }
    glu::expect_no_error(gl, "setup data")?;

    // msaa targets

    let mut queried_sample_count = -1;

    if config.target == RenderTarget::Texture {
        let texture_target = if config.num_samples == 0 {
            glw::GL_TEXTURE_2D
        } else {
            glw::GL_TEXTURE_2D_MULTISAMPLE
        };

        res.resolve_vao = Some(glu::VertexArray::new(gl));
        glu::expect_no_error(gl, "gen vao")?;

        let fbo_texture = glu::Texture::new(gl);
        // SAFETY: a texture this call owns; the storage call matches the target it was
        // bound to.
        unsafe {
            gl.bind_texture(texture_target, fbo_texture.get());
            if config.num_samples == 0 {
                gl.tex_storage_2d(texture_target, 1, glw::GL_RGBA8, render_size, render_size);
                gl.tex_parameteri(texture_target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
                gl.tex_parameteri(texture_target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
            } else {
                gl.tex_storage_2d_multisample(
                    texture_target,
                    config.num_samples,
                    glw::GL_RGBA8,
                    render_size,
                    render_size,
                    glw::GL_FALSE as glw::GLboolean,
                );
            }
        }
        glu::expect_no_error(gl, "gen tex")?;

        let fbo = glu::Framebuffer::new(gl);
        // SAFETY: the framebuffer and texture this call owns.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                texture_target,
                fbo_texture.get(),
                0,
            );
        }
        glu::expect_no_error(gl, "gen fbo")?;

        // SAFETY: the framebuffer just bound.
        if unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::Fail("fbo not complete".to_string()));
        }

        if config.num_samples != 0 {
            // for shader
            // SAFETY: a single-valued level parameter on the bound multisample texture.
            unsafe {
                gl.get_tex_level_parameteriv(
                    glw::GL_TEXTURE_2D_MULTISAMPLE,
                    0,
                    glw::GL_TEXTURE_SAMPLES,
                    &mut queried_sample_count,
                )
            };

            // logging
            log::info!(
                "Asked for {} samples, got {queried_sample_count} samples.",
                config.num_samples
            );

            // sanity
            if queried_sample_count < config.num_samples {
                return Err(TestError::Fail("Got less texture samples than asked for".to_string()));
            }
        }

        // texture sampler shader
        let sampler_fragment_source = if verify_texture_sample_buffers {
            gen_ms_texture_layer_fetch_source(context, render_size, config.num_samples)
        } else {
            gen_ms_texture_resolver_source(context, render_size, config.num_samples, queried_sample_count)
        };
        let program = glu::ShaderProgram::new(
            gl,
            &glu::ProgramSources::vtx_frag(gen_default_vertex_source(context), sampler_fragment_source),
        );
        if !program.is_ok() {
            return Err(TestError::Fail("could not build program".to_string()));
        }

        res.fbo = Some(fbo);
        res.fbo_texture = Some(fbo_texture);
        res.texture_sampler_program = Some(program);
    } else if config.target == RenderTarget::Renderbuffer {
        let fbo_rbo = glu::Renderbuffer::new(gl);
        // SAFETY: a renderbuffer this call owns and a colour-renderable format.
        unsafe {
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, fbo_rbo.get());
            gl.renderbuffer_storage_multisample(
                glw::GL_RENDERBUFFER,
                config.num_samples,
                glw::GL_RGBA8,
                render_size,
                render_size,
            );
        }
        glu::expect_no_error(gl, "gen rbo")?;

        let fbo = glu::Framebuffer::new(gl);
        // SAFETY: the framebuffer and renderbuffer this call owns.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                fbo_rbo.get(),
            );
        }
        glu::expect_no_error(gl, "gen fbo")?;

        // SAFETY: the framebuffer just bound.
        if unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::Fail("fbo not complete".to_string()));
        }

        // logging
        // SAFETY: a single-valued renderbuffer parameter on the bound renderbuffer.
        unsafe {
            gl.get_renderbuffer_parameteriv(
                glw::GL_RENDERBUFFER,
                glw::GL_RENDERBUFFER_SAMPLES,
                &mut queried_sample_count,
            )
        };
        log::info!(
            "Asked for {} samples, got {queried_sample_count} samples.",
            config.num_samples
        );

        // sanity
        if queried_sample_count < config.num_samples {
            return Err(TestError::Fail(
                "Got less renderbuffer samples samples than asked for".to_string(),
            ));
        }

        res.fbo = Some(fbo);
        res.fbo_rbo = Some(fbo_rbo);
    }

    // fbo for resolving the multisample fbo
    if config.target != RenderTarget::Default {
        let resolve_fbo_texture = glu::Texture::new(gl);
        // SAFETY: a texture this call owns.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D, resolve_fbo_texture.get());
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, render_size, render_size);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
        }
        glu::expect_no_error(gl, "gen tex")?;

        let resolve_fbo = glu::Framebuffer::new(gl);
        // SAFETY: the framebuffer and texture this call owns.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, resolve_fbo.get());
            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                resolve_fbo_texture.get(),
                0,
            );
        }
        glu::expect_no_error(gl, "gen fbo")?;

        // SAFETY: the framebuffer just bound.
        if unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::Fail("resolve fbo not complete".to_string()));
        }

        res.resolve_fbo = Some(resolve_fbo);
        res._resolve_fbo_texture = Some(resolve_fbo_texture);
    }

    // create verifier shader and set targetSampleCount

    state.num_target_samples = match config.target {
        RenderTarget::Texture if config.num_samples == 0 => 1,
        RenderTarget::Texture | RenderTarget::Renderbuffer => queried_sample_count.max(1),
        RenderTarget::Default => context.render_target().num_samples.max(1),
    };

    let mut program = if config.per_iteration_shader {
        None
    } else {
        let p = build_render_program(context, body, &state)?;
        Some(p)
    };

    body.post_init(&mut state)?;

    // MultisampleRenderCase::iterate

    let mut result = TestStatus::pass("Pass");
    body.pre_test(context, &state)?;

    for iteration in 0..state.num_iterations {
        state.iteration = iteration;

        if config.per_iteration_shader {
            program = Some(build_render_program(context, body, &state)?);
        }

        let program_ref = program.as_ref().expect("render program");
        draw_one_iteration(
            context,
            config,
            body,
            &state,
            &res,
            &render_data,
            program_ref,
            verify_texture_sample_buffers,
            &mut result,
        )?;
    }

    body.post_test(context, &state, &mut result)?;

    Ok(result)
}

/// The program build `init` and `drawOneIteration` share.
fn build_render_program<'gl>(
    context: &'gl Context,
    body: &dyn MultisampleRenderCaseBody,
    state: &CaseState,
) -> Result<glu::ShaderProgram<'gl>, TestError> {
    let program = glu::ShaderProgram::new_reporting_build_failure(
        context.gl(),
        &glu::ProgramSources::vtx_frag(
            body.gen_vertex_source(context, state, state.num_target_samples),
            body.gen_fragment_source(context, state, state.num_target_samples),
        ),
    );

    if !program.is_ok() {
        return Err(TestError::Fail("could not build program".to_string()));
    }
    Ok(program)
}

/// `MultisampleRenderCase::drawOneIteration`
#[expect(
    clippy::too_many_arguments,
    reason = "upstream reads these off the base class; here they are the base class"
)]
fn draw_one_iteration(
    context: &Context,
    config: &Config,
    body: &dyn MultisampleRenderCaseBody,
    state: &CaseState,
    res: &Resources<'_>,
    render_data: &RenderData,
    program: &glu::ShaderProgram<'_>,
    verify_texture_sample_buffers: bool,
    result: &mut TestStatus,
) -> Result<(), TestError> {
    let gl = context.gl();
    let render_size = config.render_size;

    if state.num_iterations > 1 {
        log::info!(
            "Iteration {}/{}: {}",
            state.iteration + 1,
            state.num_iterations,
            body.get_iteration_description(state.iteration)
        );
    }

    // render
    {
        if config.target == RenderTarget::Texture || config.target == RenderTarget::Renderbuffer {
            // SAFETY: the framebuffer this case owns.
            unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, res.fbo.as_ref().expect("fbo").get()) };
            glu::expect_no_error(gl, "bind fbo")?;

            log::info!("Rendering {} with render shader to fbo.", render_data.scene_description);
        } else {
            log::info!(
                "Rendering {} with render shader to default framebuffer.",
                render_data.scene_description
            );
        }

        // SAFETY: plain state setters.
        unsafe {
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            gl.viewport(0, 0, render_size, render_size);
        }
        glu::expect_no_error(gl, "clear")?;

        // SAFETY: the vertex array and buffer this case owns.
        unsafe {
            gl.bind_vertex_array(res.render_vao.get());
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, res.buffer.get());
        }

        // set attribs
        for (name, attrib) in &render_data.attribs {
            let c_name = CString::new(name.as_str()).expect("attribute name");
            // SAFETY: a NUL-terminated name; an attribute the program does not declare
            // answers -1, which is checked before it is used.
            let location = unsafe { gl.get_attrib_location(program.program(), c_name.as_ptr()) };

            if location != -1 {
                // SAFETY: the offset and stride address the buffer just bound, which
                // `setup_render_data` filled.
                unsafe {
                    gl.vertex_attrib_pointer(
                        location as u32,
                        4,
                        glw::GL_FLOAT,
                        glw::GL_FALSE as glw::GLboolean,
                        attrib.stride,
                        attrib.offset as usize as *const c_void,
                    );
                    gl.enable_vertex_attrib_array(location as u32);
                }
            }
        }
        glu::expect_no_error(gl, "set attrib")?;

        // SAFETY: a linked program and a draw whose vertex count is the case's own.
        unsafe { gl.use_program(program.program()) };
        body.pre_draw(context, state, program.program())?;
        // SAFETY: as above.
        unsafe { gl.draw_arrays(render_data.render_mode, 0, render_data.render_count) };
        body.post_draw(context, state, program.program())?;
        // SAFETY: unbinding.
        unsafe {
            gl.use_program(0);
            gl.bind_vertex_array(0);
        }
        glu::expect_no_error(gl, "draw")?;

        if config.target == RenderTarget::Texture || config.target == RenderTarget::Renderbuffer {
            // SAFETY: unbinding.
            unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };
        }
    }

    // read
    match config.target {
        RenderTarget::Default => {
            let mut result_image = Surface::new(render_size, render_size);

            log::info!("Reading pixels from default framebuffer.");

            // default directly
            glu::read_pixels(&context.render_context, 0, 0, &mut result_image.get_access())?;
            glu::expect_no_error(gl, "read pixels")?;

            verify_result_image_and_set_result(body, state, &result_image, result);
        }
        RenderTarget::Renderbuffer => {
            let mut result_image = Surface::new(render_size, render_size);

            // rbo by blitting to non-multisample fbo

            log::info!("Blitting result from fbo to single sample fbo. (Resolve multisample)");

            // SAFETY: two framebuffers this case owns, with the same size and format.
            unsafe {
                gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, res.fbo.as_ref().expect("fbo").get());
                gl.bind_framebuffer(
                    glw::GL_DRAW_FRAMEBUFFER,
                    res.resolve_fbo.as_ref().expect("resolve fbo").get(),
                );
                gl.blit_framebuffer(
                    0,
                    0,
                    render_size,
                    render_size,
                    0,
                    0,
                    render_size,
                    render_size,
                    glw::GL_COLOR_BUFFER_BIT,
                    glw::GL_NEAREST,
                );
            }
            glu::expect_no_error(gl, "blit resolve")?;

            log::info!("Reading pixels from single sample framebuffer.");

            // SAFETY: the resolve target just written.
            unsafe {
                gl.bind_framebuffer(
                    glw::GL_READ_FRAMEBUFFER,
                    res.resolve_fbo.as_ref().expect("resolve fbo").get(),
                )
            };
            glu::read_pixels(&context.render_context, 0, 0, &mut result_image.get_access())?;
            glu::expect_no_error(gl, "read pixels")?;

            // SAFETY: unbinding.
            unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };

            verify_result_image_and_set_result(body, state, &result_image, result);
        }
        RenderTarget::Texture if !verify_texture_sample_buffers => {
            let sampler_program = res.texture_sampler_program.as_ref().expect("sampler program");
            // SAFETY: NUL-terminated names against a linked program.
            let (pos_location, sampler_location) = unsafe {
                (
                    gl.get_attrib_location(sampler_program.program(), c"a_position".as_ptr()),
                    gl.get_uniform_location(sampler_program.program(), c"u_sampler".as_ptr()),
                )
            };
            let texture_target = if config.num_samples == 0 {
                glw::GL_TEXTURE_2D
            } else {
                glw::GL_TEXTURE_2D_MULTISAMPLE
            };
            let mut result_image = Surface::new(render_size, render_size);

            if config.num_samples != 0 {
                log::info!("Using sampler shader to sample the multisample texture to single sample framebuffer.");
            } else {
                log::info!("Drawing texture to single sample framebuffer. Using sampler shader.");
            }

            if sampler_location == -1 {
                return Err(TestError::Fail("Location u_sampler was -1.".to_string()));
            }

            // resolve multisample texture by averaging
            // SAFETY: plain state setters.
            unsafe {
                gl.clear_color(0.0, 0.0, 0.0, 1.0);
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
                gl.viewport(0, 0, render_size, render_size);
            }
            glu::expect_no_error(gl, "clear")?;

            // SAFETY: the resolve vao/buffer this case owns, holding a 4-vertex quad.
            unsafe {
                gl.bind_vertex_array(res.resolve_vao.as_ref().expect("resolve vao").get());
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, res.resolve_buffer.get());
                gl.vertex_attrib_pointer(
                    pos_location as u32,
                    4,
                    glw::GL_FLOAT,
                    glw::GL_FALSE as glw::GLboolean,
                    0,
                    std::ptr::null(),
                );
                gl.enable_vertex_attrib_array(pos_location as u32);
            }
            glu::expect_no_error(gl, "set attrib")?;

            // SAFETY: the texture this case owns.
            unsafe {
                gl.active_texture(glw::GL_TEXTURE0);
                gl.bind_texture(texture_target, res.fbo_texture.as_ref().expect("fbo texture").get());
            }
            glu::expect_no_error(gl, "bind tex")?;

            // SAFETY: a linked program, a sampler uniform whose location was checked,
            // and a framebuffer this case owns.
            unsafe {
                gl.use_program(sampler_program.program());
                gl.uniform_1i(sampler_location, 0);

                gl.bind_framebuffer(
                    glw::GL_FRAMEBUFFER,
                    res.resolve_fbo.as_ref().expect("resolve fbo").get(),
                );
                gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);

                gl.use_program(0);
                gl.bind_vertex_array(0);
            }
            glu::expect_no_error(gl, "draw")?;

            log::info!("Reading pixels from single sample framebuffer.");

            glu::read_pixels(&context.render_context, 0, 0, &mut result_image.get_access())?;
            glu::expect_no_error(gl, "read pixels")?;

            // SAFETY: unbinding.
            unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };

            verify_result_image_and_set_result(body, state, &result_image, result);
        }
        RenderTarget::Texture => {
            let sampler_program = res.texture_sampler_program.as_ref().expect("sampler program");
            // SAFETY: NUL-terminated names against a linked program.
            let (pos_location, sampler_location, sample_location) = unsafe {
                (
                    gl.get_attrib_location(sampler_program.program(), c"a_position".as_ptr()),
                    gl.get_uniform_location(sampler_program.program(), c"u_sampler".as_ptr()),
                    gl.get_uniform_location(sampler_program.program(), c"u_sampleNdx".as_ptr()),
                )
            };
            let texture_target = if config.num_samples == 0 {
                glw::GL_TEXTURE_2D
            } else {
                glw::GL_TEXTURE_2D_MULTISAMPLE
            };

            if config.num_samples != 0 {
                log::info!("Reading multisample texture sample buffers.");
            } else {
                log::info!("Reading texture.");
            }

            if sampler_location == -1 {
                return Err(TestError::Fail("Location u_sampler was -1.".to_string()));
            }
            if sample_location == -1 {
                return Err(TestError::Fail("Location u_sampleNdx was -1.".to_string()));
            }

            let mut result_buffers: Vec<Surface> = (0..state.num_target_samples)
                .map(|_| Surface::new(render_size, render_size))
                .collect();

            // read sample buffers to different surfaces
            // SAFETY: plain state setters.
            unsafe {
                gl.clear_color(0.0, 0.0, 0.0, 1.0);
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
                gl.viewport(0, 0, render_size, render_size);
            }
            glu::expect_no_error(gl, "clear")?;

            // SAFETY: the resolve vao/buffer this case owns, holding a 4-vertex quad.
            unsafe {
                gl.bind_vertex_array(res.resolve_vao.as_ref().expect("resolve vao").get());
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, res.resolve_buffer.get());
                gl.vertex_attrib_pointer(
                    pos_location as u32,
                    4,
                    glw::GL_FLOAT,
                    glw::GL_FALSE as glw::GLboolean,
                    0,
                    std::ptr::null(),
                );
                gl.enable_vertex_attrib_array(pos_location as u32);
            }
            glu::expect_no_error(gl, "set attrib")?;

            // SAFETY: the texture this case owns.
            unsafe {
                gl.active_texture(glw::GL_TEXTURE0);
                gl.bind_texture(texture_target, res.fbo_texture.as_ref().expect("fbo texture").get());
            }
            glu::expect_no_error(gl, "bind tex")?;

            // SAFETY: a framebuffer this case owns and a linked program.
            unsafe {
                gl.bind_framebuffer(
                    glw::GL_FRAMEBUFFER,
                    res.resolve_fbo.as_ref().expect("resolve fbo").get(),
                );
                gl.use_program(sampler_program.program());
                gl.uniform_1i(sampler_location, 0);
            }

            log::info!("Reading sample buffers");

            for (sample_ndx, buffer) in result_buffers.iter_mut().enumerate() {
                // SAFETY: a sample index below the target's sample count.
                unsafe {
                    gl.uniform_1i(sample_location, sample_ndx as i32);
                    gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);
                }
                glu::expect_no_error(gl, "draw")?;

                glu::read_pixels(&context.render_context, 0, 0, &mut buffer.get_access())?;
                glu::expect_no_error(gl, "read pixels")?;
            }

            // SAFETY: unbinding.
            unsafe {
                gl.use_program(0);
                gl.bind_vertex_array(0);
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            }

            // verify sample buffers
            verify_result_buffers_and_set_result(body, state, &result_buffers, result);
        }
    }

    Ok(())
}

/// `MultisampleRenderCase::verifyResultImageAndSetResult`
fn verify_result_image_and_set_result(
    body: &dyn MultisampleRenderCaseBody,
    state: &CaseState,
    result_image: &Surface,
    result: &mut TestStatus,
) {
    match body.verify_image(state, result_image) {
        Ok(true) => {}
        Ok(false) => *result = TestStatus::fail("Image verification failed"),
        Err(QualityWarning(message)) => set_quality_warning(&message, result),
    }
}

/// `MultisampleRenderCase::verifyResultBuffersAndSetResult`
fn verify_result_buffers_and_set_result(
    body: &dyn MultisampleRenderCaseBody,
    state: &CaseState,
    result_buffers: &[Surface],
    result: &mut TestStatus,
) {
    match body.verify_sample_buffers(state, result_buffers) {
        Ok(true) => {}
        Ok(false) => *result = TestStatus::fail("Image verification failed"),
        Err(QualityWarning(message)) => set_quality_warning(&message, result),
    }
}

/// The `catch (const QualityWarning &ex)` both of the two above share.
fn set_quality_warning(message: &str, result: &mut TestStatus) {
    log::warn!("Quality warning, error = {message}");

    // Failures are more important than warnings
    if result.code() == TestResult::Pass {
        *result = TestStatus::new(TestResult::QualityWarning, message);
    }
}
