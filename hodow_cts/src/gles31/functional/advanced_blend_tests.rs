// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fAdvancedBlendTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `AdvancedBlendCase` renders through
// plain client-side GL calls rather than through `gls::FragmentOpUtil::QuadRenderer` -
// upstream does the same, because unlike every other `FragmentOpUtil`-based case this
// one draws a variable number of overlapping quads sharing one index/vertex buffer
// triple, which the fixed four-vertex `QuadRenderer` cannot express. Upstream's
// `!glu::isContextTypeES` VAO branch has no counterpart here, as elsewhere in this
// port - this port only ever creates ES contexts, where the default VAO is legal.

use crate::gls::fragment_op_util::{IntegerQuad, ReferenceQuadRenderer, get_multisample_access};
use crate::gls::state_query_util::{
    QueryType, verify_state_boolean, verify_state_indexed_integer, verify_state_integer,
};
use crate::glu::{
    self, ApiCase, Buffer, Context, GlslVersion, ProgramSources, ShaderProgram, TestCaseGroup, add_api_case,
};
use crate::glw::{self, GLenum, GLuint};
use crate::rr::render_state::{BlendEquationAdvanced, BlendMode, FragmentOperationState};
use crate::sglr::reference_utils::map_gl_blend_equation_advanced;
use crate::tcu::TestError;
use crate::tcu::bilinear_image_compare::bilinear_compare;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel, clear};
use crate::tcu::pixel_format::PixelFormat;
use crate::tcu::random::{Random, de_int32_hash, de_string_hash};
use crate::tcu::string_template::StringTemplate;
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};

/// `s_blendEquations[]`
const BLEND_EQUATIONS: [GLenum; 15] = [
    glw::GL_MULTIPLY,
    glw::GL_SCREEN,
    glw::GL_OVERLAY,
    glw::GL_DARKEN,
    glw::GL_LIGHTEN,
    glw::GL_COLORDODGE,
    glw::GL_COLORBURN,
    glw::GL_HARDLIGHT,
    glw::GL_SOFTLIGHT,
    glw::GL_DIFFERENCE,
    glw::GL_EXCLUSION,
    glw::GL_HSL_HUE,
    glw::GL_HSL_SATURATION,
    glw::GL_HSL_COLOR,
    glw::GL_HSL_LUMINOSITY,
];

/// `BlendAdvancedCoherentStateCase::iterate`
fn blend_advanced_coherent_state_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    if !case
        .context()
        .context_info
        .is_extension_supported("GL_KHR_blend_equation_advanced_coherent")
    {
        case.not_supported("GL_KHR_blend_equation_advanced_coherent is not supported");
        return;
    }

    // check inital value
    case.section("Initial");
    verify_state_boolean(case, glw::GL_BLEND_ADVANCED_COHERENT_KHR, true, verifier);

    // check toggle
    case.section("Toggle");
    // SAFETY: a capability enum the extension above defines.
    unsafe { case.gl().disable(glw::GL_BLEND_ADVANCED_COHERENT_KHR) };
    case.expect_no_error("glDisable");

    verify_state_boolean(case, glw::GL_BLEND_ADVANCED_COHERENT_KHR, false, verifier);

    // SAFETY: as above.
    unsafe { case.gl().enable(glw::GL_BLEND_ADVANCED_COHERENT_KHR) };
    case.expect_no_error("glEnable");

    verify_state_boolean(case, glw::GL_BLEND_ADVANCED_COHERENT_KHR, true, verifier);
}

/// `contextSupports(es(3, 2))`, else `GL_KHR_blend_equation_advanced`.
fn has_advanced_blend(context: &Context) -> bool {
    context.context_type().supports(3, 2)
        || context
            .context_info
            .is_extension_supported("GL_KHR_blend_equation_advanced")
}

/// `BlendEquationStateCase::iterate`
fn blend_equation_state_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    if !has_advanced_blend(case.context()) {
        case.not_supported("GL_KHR_blend_equation_advanced is not supported");
        return;
    }

    for equation in BLEND_EQUATIONS {
        // SAFETY: an equation enum the check above established the driver knows.
        unsafe { case.gl().blend_equation(equation) };
        case.expect_no_error("glBlendEquation");

        #[expect(
            clippy::cast_possible_wrap,
            reason = "upstream compares the GLenum against a GLint state"
        )]
        let expected = equation as i32;
        verify_state_integer(case, glw::GL_BLEND_EQUATION, expected, verifier);
    }
}

/// `BlendEquationIndexedStateCase::iterate`
///
/// Upstream's guard also accepts a desktop `core(4, 5)` context; this port only ever
/// creates ES contexts, so that branch cannot be reached and is not written out.
fn blend_equation_indexed_state_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    if !case.context().context_type().supports(3, 2) {
        if !case
            .context()
            .context_info
            .is_extension_supported("GL_KHR_blend_equation_advanced")
        {
            case.not_supported("GL_KHR_blend_equation_advanced is not supported");
            return;
        }
        if !case
            .context()
            .context_info
            .is_extension_supported("GL_EXT_draw_buffers_indexed")
        {
            case.not_supported("GL_EXT_draw_buffers_indexed is not supported");
            return;
        }
    }

    for equation in BLEND_EQUATIONS {
        // SAFETY: as `blend_equation_state_case`; draw buffer 2 always exists on a
        // context that has indexed draw buffers at all.
        unsafe { case.gl().blend_equationi(2, equation) };
        case.expect_no_error("glBlendEquationi");

        #[expect(
            clippy::cast_possible_wrap,
            reason = "upstream compares the GLenum against a GLint state"
        )]
        let expected = equation as i32;
        verify_state_indexed_integer(case, glw::GL_BLEND_EQUATION, 2, expected, verifier);
    }
}

/// `AdvancedBlendTests::init`'s `.state_query` sub-group.
fn state_query_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("state_query");

    for (name, verifier) in [
        ("blend_advanced_coherent_getboolean", QueryType::Boolean),
        ("blend_advanced_coherent_isenabled", QueryType::IsEnabled),
        ("blend_advanced_coherent_getinteger", QueryType::Integer),
        ("blend_advanced_coherent_getinteger64", QueryType::Integer64),
        ("blend_advanced_coherent_getfloat", QueryType::Float),
    ] {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            blend_advanced_coherent_state_case(case, verifier)
        });
    }

    for (name, verifier) in [
        ("blend_equation_getboolean", QueryType::Boolean),
        ("blend_equation_getinteger", QueryType::Integer),
        ("blend_equation_getinteger64", QueryType::Integer64),
        ("blend_equation_getfloat", QueryType::Float),
    ] {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            blend_equation_state_case(case, verifier)
        });
    }

    for (name, verifier) in [
        ("blend_equation_getbooleani_v", QueryType::IndexedBoolean),
        ("blend_equation_getintegeri_v", QueryType::IndexedInteger),
        ("blend_equation_getinteger64i_v", QueryType::IndexedInteger64),
    ] {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            blend_equation_indexed_state_case(case, verifier)
        });
    }

    group
}

const MAX_VIEWPORT_WIDTH: i32 = 128;
const MAX_VIEWPORT_HEIGHT: i32 = 128;
const NUM_ITERS: i32 = 5;

/// `RenderTargetType`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum RenderTargetType {
    /// Default framebuffer.
    Default,
    SrgbFbo,
    MsaaFbo,
}

/// `getEquationName` - also each case's own leaf name.
fn equation_name(mode: GLenum) -> &'static str {
    match mode {
        glw::GL_MULTIPLY => "multiply",
        glw::GL_SCREEN => "screen",
        glw::GL_OVERLAY => "overlay",
        glw::GL_DARKEN => "darken",
        glw::GL_LIGHTEN => "lighten",
        glw::GL_COLORDODGE => "colordodge",
        glw::GL_COLORBURN => "colorburn",
        glw::GL_HARDLIGHT => "hardlight",
        glw::GL_SOFTLIGHT => "softlight",
        glw::GL_DIFFERENCE => "difference",
        glw::GL_EXCLUSION => "exclusion",
        glw::GL_HSL_HUE => "hsl_hue",
        glw::GL_HSL_SATURATION => "hsl_saturation",
        glw::GL_HSL_COLOR => "hsl_color",
        glw::GL_HSL_LUMINOSITY => "hsl_luminosity",
        _ => unreachable!("not one of BLEND_EQUATIONS"),
    }
}

/// `getBlendLayoutQualifier`
fn blend_layout_qualifier(equation: BlendEquationAdvanced) -> &'static str {
    match equation {
        BlendEquationAdvanced::Multiply => "blend_support_multiply",
        BlendEquationAdvanced::Screen => "blend_support_screen",
        BlendEquationAdvanced::Overlay => "blend_support_overlay",
        BlendEquationAdvanced::Darken => "blend_support_darken",
        BlendEquationAdvanced::Lighten => "blend_support_lighten",
        BlendEquationAdvanced::ColorDodge => "blend_support_colordodge",
        BlendEquationAdvanced::ColorBurn => "blend_support_colorburn",
        BlendEquationAdvanced::HardLight => "blend_support_hardlight",
        BlendEquationAdvanced::SoftLight => "blend_support_softlight",
        BlendEquationAdvanced::Difference => "blend_support_difference",
        BlendEquationAdvanced::Exclusion => "blend_support_exclusion",
        BlendEquationAdvanced::HslHue => "blend_support_hsl_hue",
        BlendEquationAdvanced::HslSaturation => "blend_support_hsl_saturation",
        BlendEquationAdvanced::HslColor => "blend_support_hsl_color",
        BlendEquationAdvanced::HslLuminosity => "blend_support_hsl_luminosity",
    }
}

/// `getBlendProgramSrc`
fn blend_program_src(equation: BlendEquationAdvanced, supports_es32: bool) -> Result<ProgramSources, TestError> {
    const VERT_SRC: &str = "${GLSL_VERSION_DECL}\n\
                            in highp vec4 a_position;\n\
                            in mediump vec4 a_color;\n\
                            out mediump vec4 v_color;\n\
                            void main()\n\
                            {\n\
                            \tgl_Position = a_position;\n\
                            \tv_color = a_color;\n\
                            }\n";
    const FRAG_SRC: &str = "${GLSL_VERSION_DECL}\n\
                            ${EXTENSION}\
                            in mediump vec4 v_color;\n\
                            layout(${SUPPORT_QUALIFIER}) out;\n\
                            layout(location = 0) out mediump vec4 o_color;\n\
                            void main()\n\
                            {\n\
                            \to_color = v_color;\n\
                            }\n";

    let args = [
        (
            "GLSL_VERSION_DECL",
            (if supports_es32 {
                GlslVersion::Es320
            } else {
                GlslVersion::Es310
            })
            .declaration()
            .to_string(),
        ),
        (
            "EXTENSION",
            (if supports_es32 {
                "\n".to_string()
            } else {
                "#extension GL_KHR_blend_equation_advanced : require\n".to_string()
            }),
        ),
        ("SUPPORT_QUALIFIER", blend_layout_qualifier(equation).to_string()),
    ];

    let vertex = StringTemplate::new(VERT_SRC).specialize(&args)?;
    let fragment = StringTemplate::new(FRAG_SRC).specialize(&args)?;
    Ok(ProgramSources::vtx_frag(vertex, fragment))
}

/// `randomColor` - upstream notes the spec assumes premultiplied inputs.
fn random_color(rnd: &mut Random) -> [f32; 4] {
    const RGB_VALUES: [f32; 11] = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
    const ALPHA_VALUES: [f32; 10] = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];

    let a = *rnd.choose(&ALPHA_VALUES);
    let r = a * *rnd.choose(&RGB_VALUES);
    let g = a * *rnd.choose(&RGB_VALUES);
    let b = a * *rnd.choose(&RGB_VALUES);
    [r, g, b, a]
}

/// `getLinearAccess` - upstream's sRGB target holds encoded bytes it never decodes for
/// the comparison; this only relabels the format the same way, rather than reaching for
/// `srgb_to_linear`. Everything else is compared as raw UNORM_INT8 bytes on both sides.
fn get_linear_access(access: ConstPixelBufferAccess<'_>) -> ConstPixelBufferAccess<'_> {
    if access.format().order == ChannelOrder::sRGBA {
        let size = access.size();
        ConstPixelBufferAccess::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            size,
            access.into_raw(),
        )
    } else {
        access
    }
}

/// Deletes the (possibly zero) FBO/RBO/resolve-FBO/resolve-RBO objects a case created -
/// `AdvancedBlendCase::deinit`'s `if (m_colorRbo || m_fbo)` guard.
fn delete_fbo_objects(
    gl: &glw::Functions,
    color_rbo: GLuint,
    fbo: GLuint,
    resolve_color_rbo: GLuint,
    resolve_fbo: GLuint,
) {
    if color_rbo == 0 && fbo == 0 {
        return;
    }
    // SAFETY: every id here is either 0 (checked before use) or an object this case
    // itself created earlier in the same call.
    unsafe {
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        if color_rbo != 0 {
            gl.delete_renderbuffers(1, &color_rbo);
        }
        if fbo != 0 {
            gl.delete_framebuffers(1, &fbo);
        }
        if resolve_color_rbo != 0 {
            gl.delete_renderbuffers(1, &resolve_color_rbo);
        }
        if resolve_fbo != 0 {
            gl.delete_framebuffers(1, &resolve_fbo);
        }
    }
}

const SINGLE_QUAD_POS: [[f32; 2]; 4] = [[-1.0, -1.0], [-1.0, 1.0], [1.0, -1.0], [1.0, 1.0]];
const SINGLE_QUAD_INDICES: [u16; 6] = [0, 2, 1, 1, 2, 3];

/// `AdvancedBlendCase::iterate`, run for `NUM_ITERS` iterations the way upstream is
/// re-entered `NUM_ITERS` times - `init`'s program/FBO setup happens once here too,
/// ahead of the loop, rather than once per `ApiCase` (there being no separate `init`).
#[expect(
    clippy::too_many_lines,
    reason = "one-to-one with a single upstream `iterate`, which is the same shape"
)]
fn advanced_blend_case(
    case: &mut ApiCase<'_>,
    mode: GLenum,
    overdraw_count: i32,
    coherent: bool,
    rt_type: RenderTargetType,
) {
    let coherent_supported = case
        .context()
        .context_info
        .is_extension_supported("GL_KHR_blend_equation_advanced_coherent");
    let supports_es32 = case.context().context_type().supports(3, 2);

    if !supports_es32
        && !case
            .context()
            .context_info
            .is_extension_supported("GL_KHR_blend_equation_advanced")
    {
        case.not_supported("GL_KHR_blend_equation_advanced is not supported");
        return;
    }
    if coherent && !coherent_supported {
        case.not_supported("GL_KHR_blend_equation_advanced_coherent is not supported");
        return;
    }
    if case.gl().blend_barrier.is_none() {
        case.fail("glBlendBarrier is not loaded".to_string(), "Fail");
        return;
    }

    let Some(equation) = map_gl_blend_equation_advanced(mode) else {
        case.fail("unmapped blend equation".to_string(), "Fail");
        return;
    };

    let render_target = case.context().render_target();
    let use_fbo = rt_type != RenderTargetType::Default;
    let use_srgb = rt_type == RenderTargetType::SrgbFbo;

    let render_width = if use_fbo {
        2 * MAX_VIEWPORT_WIDTH
    } else {
        render_target.width
    };
    let render_height = if use_fbo {
        2 * MAX_VIEWPORT_HEIGHT
    } else {
        render_target.height
    };
    let viewport_width = render_width.min(MAX_VIEWPORT_WIDTH);
    let viewport_height = render_height.min(MAX_VIEWPORT_HEIGHT);

    let sources = match blend_program_src(equation, supports_es32) {
        Ok(s) => s,
        Err(e) => {
            case.fail(e.to_string(), "Fail");
            return;
        }
    };

    let gl = case.gl();
    let program = ShaderProgram::new(gl, &sources);
    if !program.is_ok() {
        case.fail("Compile failed".to_string(), "Compile failed");
        return;
    }

    let ref_order = if use_srgb {
        ChannelOrder::sRGBA
    } else {
        ChannelOrder::RGBA
    };
    let mut ref_color_buffer = match TextureLevel::new(
        TextureFormat::new(ref_order, ChannelType::UNORM_INT8),
        viewport_width as u32,
        viewport_height as u32,
        1,
    ) {
        Ok(l) => l,
        Err(e) => {
            case.fail(e.to_string(), "Fail");
            return;
        }
    };

    let mut color_rbo: GLuint = 0;
    let mut fbo: GLuint = 0;
    let mut resolve_color_rbo: GLuint = 0;
    let mut resolve_fbo: GLuint = 0;

    if use_fbo {
        let format = if use_srgb { glw::GL_SRGB8_ALPHA8 } else { glw::GL_RGBA8 };
        let num_samples = if rt_type == RenderTargetType::MsaaFbo { 4 } else { 0 };

        // SAFETY: plain object creation and binding on a current context.
        unsafe {
            gl.gen_renderbuffers(1, &mut color_rbo);
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, color_rbo);
            gl.renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, num_samples, format, render_width, render_height);
        }
        if let Err(e) = glu::expect_no_error(gl, "Failed to create color RBO") {
            case.fail(e.to_string(), "Fail");
            delete_fbo_objects(gl, color_rbo, fbo, resolve_color_rbo, resolve_fbo);
            return;
        }

        // SAFETY: as above.
        unsafe {
            gl.gen_framebuffers(1, &mut fbo);
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                color_rbo,
            );
        }
        if let Err(e) = glu::expect_no_error(gl, "Failed to create FBO") {
            case.fail(e.to_string(), "Fail");
            delete_fbo_objects(gl, color_rbo, fbo, resolve_color_rbo, resolve_fbo);
            return;
        }
        // SAFETY: needs only a bound framebuffer target.
        if unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE {
            case.fail("framebuffer incomplete".to_string(), "Fail");
            delete_fbo_objects(gl, color_rbo, fbo, resolve_color_rbo, resolve_fbo);
            return;
        }

        if num_samples > 0 {
            // SAFETY: as above.
            unsafe {
                gl.gen_renderbuffers(1, &mut resolve_color_rbo);
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, resolve_color_rbo);
                gl.renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, 0, format, render_width, render_height);
            }
            if let Err(e) = glu::expect_no_error(gl, "Failed to create resolve color RBO") {
                case.fail(e.to_string(), "Fail");
                delete_fbo_objects(gl, color_rbo, fbo, resolve_color_rbo, resolve_fbo);
                return;
            }

            // SAFETY: as above.
            unsafe {
                gl.gen_framebuffers(1, &mut resolve_fbo);
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, resolve_fbo);
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    resolve_color_rbo,
                );
            }
            if let Err(e) = glu::expect_no_error(gl, "Failed to create FBO") {
                case.fail(e.to_string(), "Fail");
                delete_fbo_objects(gl, color_rbo, fbo, resolve_color_rbo, resolve_fbo);
                return;
            }
            if unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE {
                case.fail("resolve framebuffer incomplete".to_string(), "Fail");
                delete_fbo_objects(gl, color_rbo, fbo, resolve_color_rbo, resolve_fbo);
                return;
            }

            // SAFETY: as above.
            unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo) };
        }
    }

    let program_id = program.program();
    // SAFETY: names of a program this case just linked.
    let (pos_loc, color_loc) = unsafe {
        (
            gl.get_attrib_location(program_id, c"a_position".as_ptr()),
            gl.get_attrib_location(program_id, c"a_color".as_ptr()),
        )
    };
    if pos_loc < 0 || color_loc < 0 {
        case.fail("invalid attribute locations".to_string(), "Fail");
        delete_fbo_objects(gl, color_rbo, fbo, resolve_color_rbo, resolve_fbo);
        return;
    }

    let requires_resolve = rt_type == RenderTargetType::MsaaFbo;
    let num_quads = overdraw_count + 1;
    let mut reference_renderer = ReferenceQuadRenderer::new();

    for iter_ndx in 0..NUM_ITERS {
        let mut rnd = Random::new(de_string_hash(equation_name(mode)) ^ de_int32_hash(iter_ndx));
        let viewport_x = rnd.get_int(0, render_width - viewport_width);
        let viewport_y = rnd.get_int(0, render_height - viewport_height);

        let colors: Vec<[f32; 4]> = (0..num_quads * 4).map(|_| random_color(&mut rnd)).collect();
        let mut positions: Vec<[f32; 2]> = Vec::with_capacity((num_quads * 4) as usize);
        let mut indices: Vec<u16> = Vec::with_capacity((num_quads * 6) as usize);
        for quad_ndx in 0..num_quads {
            positions.extend_from_slice(&SINGLE_QUAD_POS);
            for ndx in SINGLE_QUAD_INDICES {
                indices.push((quad_ndx * 4) as u16 + ndx);
            }
        }

        // Render with GL.
        {
            let index_buffer = Buffer::new(gl);
            let position_buffer = Buffer::new(gl);
            let color_buffer_obj = Buffer::new(gl);

            // SAFETY: client-side arrays sized exactly to what is uploaded, against
            // buffers this call just created.
            unsafe {
                gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, index_buffer.get());
                gl.buffer_data(
                    glw::GL_ELEMENT_ARRAY_BUFFER,
                    size_of_val(indices.as_slice()) as isize,
                    indices.as_ptr().cast(),
                    glw::GL_STATIC_DRAW,
                );

                gl.bind_buffer(glw::GL_ARRAY_BUFFER, position_buffer.get());
                gl.buffer_data(
                    glw::GL_ARRAY_BUFFER,
                    size_of_val(positions.as_slice()) as isize,
                    positions.as_ptr().cast(),
                    glw::GL_STATIC_DRAW,
                );
                gl.enable_vertex_attrib_array(pos_loc as GLuint);
                gl.vertex_attrib_pointer(pos_loc as GLuint, 2, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());

                gl.bind_buffer(glw::GL_ARRAY_BUFFER, color_buffer_obj.get());
                gl.buffer_data(
                    glw::GL_ARRAY_BUFFER,
                    size_of_val(colors.as_slice()) as isize,
                    colors.as_ptr().cast(),
                    glw::GL_STATIC_DRAW,
                );
                gl.enable_vertex_attrib_array(color_loc as GLuint);
                gl.vertex_attrib_pointer(color_loc as GLuint, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            }
            if let Err(e) = glu::expect_no_error(gl, "Failed to create buffers") {
                case.fail(e.to_string(), "Fail");
                break;
            }

            // SAFETY: plain draw state on a current context; `mode` was checked against
            // `map_gl_blend_equation_advanced` above.
            unsafe {
                gl.use_program(program_id);
                gl.viewport(viewport_x, viewport_y, viewport_width, viewport_height);
                gl.blend_equation(mode);

                // \note coherent extension enables GL_BLEND_ADVANCED_COHERENT_KHR by default.
                if coherent {
                    gl.enable(glw::GL_BLEND_ADVANCED_COHERENT_KHR);
                } else if coherent_supported {
                    gl.disable(glw::GL_BLEND_ADVANCED_COHERENT_KHR);
                }
            }
            if let Err(e) = glu::expect_no_error(gl, "Failed to set render state") {
                case.fail(e.to_string(), "Fail");
                break;
            }

            // SAFETY: as above; `indices`/`num_quads` agree with the bound element buffer.
            unsafe {
                gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

                gl.disable(glw::GL_BLEND);
                gl.draw_elements(glw::GL_TRIANGLES, 6, glw::GL_UNSIGNED_SHORT, std::ptr::null());
                gl.enable(glw::GL_BLEND);

                if !coherent {
                    gl.blend_barrier();
                }

                if coherent {
                    gl.draw_elements(
                        glw::GL_TRIANGLES,
                        6 * (num_quads - 1),
                        glw::GL_UNSIGNED_SHORT,
                        (6 * size_of::<u16>()) as *const _,
                    );
                } else {
                    for quad_ndx in 1..num_quads {
                        gl.draw_elements(
                            glw::GL_TRIANGLES,
                            6,
                            glw::GL_UNSIGNED_SHORT,
                            ((quad_ndx * 6) as usize * size_of::<u16>()) as *const _,
                        );
                        gl.blend_barrier();
                    }
                }

                gl.flush();
            }
            if let Err(e) = glu::expect_no_error(gl, "Render failed") {
                case.fail(e.to_string(), "Fail");
                break;
            }
        }

        // Render reference.
        {
            let mut reference_state = FragmentOperationState::default();

            if !use_fbo && render_target.pixel_format().alpha_bits == 0 {
                // Emulate lack of alpha by clearing to 1 and masking out alpha writes.
                clear(&mut ref_color_buffer.get_access(), [0.0, 0.0, 0.0, 1.0]);
                reference_state.color_mask = [true, true, true, false];
            }

            reference_state.blend_equation_advanced = Some(equation);

            let mut quad = IntegerQuad {
                pos_a: [0, 0],
                pos_b: [viewport_width - 1, viewport_height - 1],
                ..Default::default()
            };

            for quad_ndx in 0..num_quads {
                reference_state.blend_mode = if quad_ndx == 0 {
                    BlendMode::None
                } else {
                    BlendMode::Advanced
                };
                for c in 0..4usize {
                    quad.color[c] = colors[(4 * quad_ndx) as usize + c];
                }
                reference_renderer.render(
                    &mut get_multisample_access(ref_color_buffer.get_access()),
                    None,
                    None,
                    &quad,
                    &reference_state,
                );
            }
        }

        if requires_resolve {
            // SAFETY: `resolve_fbo` was created above whenever `requires_resolve` holds.
            unsafe {
                gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, resolve_fbo);
                gl.blit_framebuffer(
                    0,
                    0,
                    render_width,
                    render_height,
                    0,
                    0,
                    render_width,
                    render_height,
                    glw::GL_COLOR_BUFFER_BIT,
                    glw::GL_NEAREST,
                );
            }
            if let Err(e) = glu::expect_no_error(gl, "Resolve blit failed") {
                case.fail(e.to_string(), "Fail");
                break;
            }
            // SAFETY: as above.
            unsafe { gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, resolve_fbo) };
        }

        let mut rendered_img = match TextureLevel::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            viewport_width as u32,
            viewport_height as u32,
            1,
        ) {
            Ok(l) => l,
            Err(e) => {
                case.fail(e.to_string(), "Fail");
                break;
            }
        };
        if let Err(e) = glu::pixel_transfer::read_pixels(
            &case.context().render_context,
            viewport_x,
            viewport_y,
            &mut rendered_img.get_access(),
        ) {
            case.fail(e.to_string(), "Fail");
            break;
        }

        if requires_resolve {
            // SAFETY: `fbo` was created above whenever this case uses an FBO at all.
            unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo) };
        }

        let is_hsl_mode = matches!(
            equation,
            BlendEquationAdvanced::HslHue
                | BlendEquationAdvanced::HslSaturation
                | BlendEquationAdvanced::HslColor
                | BlendEquationAdvanced::HslLuminosity
        );

        let compare_pass = if is_hsl_mode {
            // Compensate for more demanding HSL code by using fuzzy comparison.
            match fuzzy_compare_ok(
                &get_linear_access(ref_color_buffer.get_const_access()),
                &rendered_img.get_const_access(),
                0.002,
            ) {
                Some(ok) => ok,
                None => {
                    case.fail("unsupported format for fuzzy compare".to_string(), "Fail");
                    break;
                }
            }
        } else {
            let base = (if use_fbo {
                PixelFormat::new(8, 8, 8, 8)
            } else {
                render_target.pixel_format()
            })
            .get_color_threshold();
            let bias = 3 * overdraw_count;
            let scale = |v: i32| -> u8 { (((v as u32 * 5) / 2) + bias as u32).min(255) as u8 };
            let threshold = [
                scale(base.get_red()),
                scale(base.get_green()),
                scale(base.get_blue()),
                scale(base.get_alpha()),
            ];

            bilinear_compare(
                &get_linear_access(ref_color_buffer.get_const_access()),
                &rendered_img.get_const_access(),
                None,
                threshold,
            )
        };

        if !compare_pass {
            case.fail("Image comparison failed".to_string(), "Image comparison failed");
            break;
        }
    }

    delete_fbo_objects(gl, color_rbo, fbo, resolve_color_rbo, resolve_fbo);
}

/// Registers one `(name, mode)` case in each of the six render groups - `AdvancedBlendTests::init`'s `for (modeNdx ...)` loop.
fn add_render_cases(
    basic: &mut TestCaseGroup,
    srgb: &mut TestCaseGroup,
    msaa: &mut TestCaseGroup,
    barrier: &mut TestCaseGroup,
    coherent: &mut TestCaseGroup,
    coherent_msaa: &mut TestCaseGroup,
) {
    for mode in BLEND_EQUATIONS {
        let name = equation_name(mode);
        add_api_case(basic, name, move |case: &mut ApiCase<'_>| {
            advanced_blend_case(case, mode, 1, false, RenderTargetType::Default)
        });
        add_api_case(srgb, name, move |case: &mut ApiCase<'_>| {
            advanced_blend_case(case, mode, 1, false, RenderTargetType::SrgbFbo)
        });
        add_api_case(msaa, name, move |case: &mut ApiCase<'_>| {
            advanced_blend_case(case, mode, 1, false, RenderTargetType::MsaaFbo)
        });
        add_api_case(barrier, name, move |case: &mut ApiCase<'_>| {
            advanced_blend_case(case, mode, 4, false, RenderTargetType::Default)
        });
        add_api_case(coherent, name, move |case: &mut ApiCase<'_>| {
            advanced_blend_case(case, mode, 4, true, RenderTargetType::Default)
        });
        add_api_case(coherent_msaa, name, move |case: &mut ApiCase<'_>| {
            advanced_blend_case(case, mode, 4, true, RenderTargetType::MsaaFbo)
        });
    }
}

/// `AdvancedBlendTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("blend_equation_advanced");
    group.add_child(state_query_group());

    let mut basic = TestCaseGroup::new("basic");
    let mut srgb = TestCaseGroup::new("srgb");
    let mut msaa = TestCaseGroup::new("msaa");
    let mut barrier = TestCaseGroup::new("barrier");
    let mut coherent = TestCaseGroup::new("coherent");
    let mut coherent_msaa = TestCaseGroup::new("coherent_msaa");

    add_render_cases(
        &mut basic,
        &mut srgb,
        &mut msaa,
        &mut barrier,
        &mut coherent,
        &mut coherent_msaa,
    );

    group.add_child(basic);
    group.add_child(srgb);
    group.add_child(msaa);
    group.add_child(barrier);
    group.add_child(coherent);
    group.add_child(coherent_msaa);
    group
}
