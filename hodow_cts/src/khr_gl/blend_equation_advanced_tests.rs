// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcBlendEquationAdvancedTests.cpp
//   external/openglcts/modules/common/glcBlendEquationAdvancedTests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Desktop core only. `FBOSentry` is `FboSentry` (guards instead of a destructor); the whole `iterate` of each upstream class is one `Kind` of `BlendCase`, the support check of its start is `check_support`.
//
// Ported so far: coherent, preprocessor, BlendEquationSeparate, MRT, mismatching_qualifier, missing_qualifier, extension_directive, blend_all, blend_specific. test_coherency.

use super::blend_reference;
use crate::generated::khr_blend_colors;
use crate::glu::{self, Context, GlslVersion, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, pr, va};
use crate::glw;
use crate::tcu::{self, PixelFormat, RGBA, TestError, TestOutcome, TestStatus, Vec4};

const EXTENSION: &str = "GL_KHR_blend_equation_advanced";
const EXTENSION_COHERENT: &str = "GL_KHR_blend_equation_advanced_coherent";

const POS: [f32; 8] = [-1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0];
const INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];

const MODES: [glw::GLenum; 15] = [
    glw::GL_MULTIPLY_KHR,
    glw::GL_SCREEN_KHR,
    glw::GL_OVERLAY_KHR,
    glw::GL_DARKEN_KHR,
    glw::GL_LIGHTEN_KHR,
    glw::GL_COLORDODGE_KHR,
    glw::GL_COLORBURN_KHR,
    glw::GL_HARDLIGHT_KHR,
    glw::GL_SOFTLIGHT_KHR,
    glw::GL_DIFFERENCE_KHR,
    glw::GL_EXCLUSION_KHR,
    glw::GL_HSL_HUE_KHR,
    glw::GL_HSL_SATURATION_KHR,
    glw::GL_HSL_COLOR_KHR,
    glw::GL_HSL_LUMINOSITY_KHR,
];

/// `GetModeStr`
fn mode_str(mode: glw::GLenum) -> &'static str {
    match mode {
        glw::GL_MULTIPLY_KHR => "GL_MULTIPLY_KHR",
        glw::GL_SCREEN_KHR => "GL_SCREEN_KHR",
        glw::GL_OVERLAY_KHR => "GL_OVERLAY_KHR",
        glw::GL_DARKEN_KHR => "GL_DARKEN_KHR",
        glw::GL_LIGHTEN_KHR => "GL_LIGHTEN_KHR",
        glw::GL_COLORDODGE_KHR => "GL_COLORDODGE_KHR",
        glw::GL_COLORBURN_KHR => "GL_COLORBURN_KHR",
        glw::GL_HARDLIGHT_KHR => "GL_HARDLIGHT_KHR",
        glw::GL_SOFTLIGHT_KHR => "GL_SOFTLIGHT_KHR",
        glw::GL_DIFFERENCE_KHR => "GL_DIFFERENCE_KHR",
        glw::GL_EXCLUSION_KHR => "GL_EXCLUSION_KHR",
        glw::GL_HSL_HUE_KHR => "GL_HSL_HUE_KHR",
        glw::GL_HSL_SATURATION_KHR => "GL_HSL_SATURATION_KHR",
        glw::GL_HSL_COLOR_KHR => "GL_HSL_COLOR_KHR",
        glw::GL_HSL_LUMINOSITY_KHR => "GL_HSL_LUMINOSITY_KHR",
        _ => unreachable!("Blend mode not from GL_KHR_blend_equation_advanced."),
    }
}

/// `GetLayoutQualifierStr`
fn layout_qualifier_str(mode: glw::GLenum) -> &'static str {
    match mode {
        glw::GL_MULTIPLY_KHR => "blend_support_multiply",
        glw::GL_SCREEN_KHR => "blend_support_screen",
        glw::GL_OVERLAY_KHR => "blend_support_overlay",
        glw::GL_DARKEN_KHR => "blend_support_darken",
        glw::GL_LIGHTEN_KHR => "blend_support_lighten",
        glw::GL_COLORDODGE_KHR => "blend_support_colordodge",
        glw::GL_COLORBURN_KHR => "blend_support_colorburn",
        glw::GL_HARDLIGHT_KHR => "blend_support_hardlight",
        glw::GL_SOFTLIGHT_KHR => "blend_support_softlight",
        glw::GL_DIFFERENCE_KHR => "blend_support_difference",
        glw::GL_EXCLUSION_KHR => "blend_support_exclusion",
        glw::GL_HSL_HUE_KHR => "blend_support_hsl_hue",
        glw::GL_HSL_SATURATION_KHR => "blend_support_hsl_saturation",
        glw::GL_HSL_COLOR_KHR => "blend_support_hsl_color",
        glw::GL_HSL_LUMINOSITY_KHR => "blend_support_hsl_luminosity",
        _ => unreachable!("Blend mode not from GL_KHR_blend_equation_advanced."),
    }
}

/// `GetDef2DVtxSrc`
fn def_2d_vtx_src(glsl_version: GlslVersion) -> String {
    format!(
        "{}\nin highp vec2 aPos;\nvoid main() {{\n   gl_Position = vec4(aPos, 0.0, 1.0);\n}}\n",
        glsl_version.declaration()
    )
}

/// `GetSolidShader`
fn solid_shader(layout_qualifier: Option<&str>, glsl_version: &str, extension_directive: &str) -> String {
    let layout_qualifier = match layout_qualifier {
        Some(qualifier) => format!("layout ({qualifier}) out;"),
        None => String::new(),
    };

    format!(
        "{glsl_version}\n{extension_directive}\n\nprecision highp float;\n\n{layout_qualifier}\nlayout (location = 0) out vec4 oCol;\n\nuniform vec4 uSrcCol;\n\nvoid main (void) {{\n   oCol = uSrcCol;\n}}\n"
    )
}

/// `FBOSentry` - an FBO with one or two renderbuffer colour attachments, bound and sized for the viewport.
struct FboSentry<'gl> {
    _fbo: glu::Framebuffer<'gl>,
    _rbo0: glu::Renderbuffer<'gl>,
    _rbo1: glu::Renderbuffer<'gl>,
}

impl<'gl> FboSentry<'gl> {
    fn new(
        gl: &'gl glw::Functions,
        width: i32,
        height: i32,
        fmt0: glw::GLenum,
        fmt1: glw::GLenum,
    ) -> Result<Self, TestError> {
        let sentry = Self {
            _fbo: glu::Framebuffer::new(gl),
            _rbo0: glu::Renderbuffer::new(gl),
            _rbo1: glu::Renderbuffer::new(gl),
        };

        // SAFETY: the names are owned by `sentry`.
        let (status, error) = unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, sentry._fbo.get());

            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, sentry._rbo0.get());
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, fmt0, width, height);
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                sentry._rbo0.get(),
            );

            if fmt1 != glw::GL_NONE {
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, sentry._rbo1.get());
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, fmt1, width, height);
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT1,
                    glw::GL_RENDERBUFFER,
                    sentry._rbo1.get(),
                );
            }

            let status = gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
            (status, gl.get_error())
        };
        if error != glw::GL_NO_ERROR || status != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::Fail("Framebuffer failed".to_string()));
        }

        // SAFETY: plain state calls.
        unsafe {
            gl.viewport(0, 0, width, height);
            gl.scissor(0, 0, width, height);
        }

        Ok(sentry)
    }
}

fn status_of(passed: bool, fail_message: &str) -> TestStatus {
    if passed {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail(fail_message)
    }
}

fn get_error(gl: &glw::Functions) -> glw::GLenum {
    // SAFETY: no arguments.
    unsafe { gl.get_error() }
}

fn uniform_location(gl: &glw::Functions, program: &ShaderProgram<'_>, name: &std::ffi::CStr) -> glw::GLint {
    // SAFETY: a NUL-terminated name and a linked program.
    unsafe { gl.get_uniform_location(program.program(), name.as_ptr()) }
}

fn read_pixel_0_0(gl: &glw::Functions) -> Result<[u8; 4], TestError> {
    let mut result = [1u8, 2, 3, 4];
    // SAFETY: four bytes of output for one RGBA8 pixel.
    unsafe {
        gl.read_pixels(
            0,
            0,
            1,
            1,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            result.as_mut_ptr().cast(),
        )
    };
    glu::expect_no_error(gl, "Read pixels failed")?;
    Ok(result)
}

fn build_vtx_frag<'gl>(
    gl: &'gl glw::Functions,
    glsl_version: GlslVersion,
    fragment: &str,
) -> Result<ShaderProgram<'gl>, TestError> {
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(def_2d_vtx_src(glsl_version), fragment));
    if !program.is_ok() {
        return Err(TestError::Fail(program.build_failure_summary().map_or_else(
            || "Compile failed".to_string(),
            |summary| format!("Compile failed: {summary}"),
        )));
    }
    Ok(program)
}

#[derive(Clone, Copy)]
enum Kind {
    CoherentEnable,
    Preprocessor(Option<&'static str>),
    BlendEquationSeparate(glw::GLenum),
    Mrt {
        array: bool,
    },
    Missing {
        mode: glw::GLenum,
        layout_qualifier: Option<&'static str>,
    },
    ExtensionDirective(&'static str),
    Blend {
        mode: glw::GLenum,
        all_qualifier: bool,
    },
    Coherency {
        repeat_count: usize,
        mixed: bool,
    },
}

struct BlendCase {
    name: String,
    glsl_version: GlslVersion,
    kind: Kind,
}

impl TestCase for BlendCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !context.context_info.is_extension_supported(EXTENSION) {
            return Err(TestError::NotSupported(EXTENSION.to_string()));
        }
        if matches!(self.kind, Kind::CoherentEnable) && !context.context_info.is_extension_supported(EXTENSION_COHERENT)
        {
            return Err(TestError::NotSupported(EXTENSION_COHERENT.to_string()));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        match self.kind {
            Kind::CoherentEnable => coherent_enable(context),
            Kind::Preprocessor(behaviour) => preprocessor(context, self.glsl_version, behaviour),
            Kind::BlendEquationSeparate(mode) => blend_equation_separate(context, mode),
            Kind::Mrt { array } => mrt(context, self.glsl_version, array),
            Kind::Missing { mode, layout_qualifier } => missing(context, self.glsl_version, mode, layout_qualifier),
            Kind::ExtensionDirective(behaviour) => extension_directive(context, self.glsl_version, behaviour),
            Kind::Blend { mode, all_qualifier } => blend_test(context, self.glsl_version, mode, all_qualifier),
            Kind::Coherency { repeat_count, mixed } => {
                coherent_blend_test(context, self.glsl_version, repeat_count, mixed)
            }
        }
    }
}

/// `CoherentEnableCase::iterate`
fn coherent_enable(context: &Context) -> TestOutcome {
    let gl = context.gl();
    let is_enabled = || {
        // SAFETY: plain state query.
        unsafe { gl.is_enabled(glw::GL_BLEND_ADVANCED_COHERENT_KHR) }
    };

    let mut res = Vec::new();
    res.push(is_enabled() == glw::TRUE);
    res.push(get_error(gl) == glw::GL_NO_ERROR);

    // SAFETY: plain state call.
    unsafe { gl.disable(glw::GL_BLEND_ADVANCED_COHERENT_KHR) };
    res.push(get_error(gl) == glw::GL_NO_ERROR);
    res.push(is_enabled() == glw::FALSE);
    res.push(get_error(gl) == glw::GL_NO_ERROR);

    // SAFETY: plain state call.
    unsafe { gl.enable(glw::GL_BLEND_ADVANCED_COHERENT_KHR) };
    res.push(get_error(gl) == glw::GL_NO_ERROR);
    res.push(is_enabled() == glw::TRUE);
    res.push(get_error(gl) == glw::GL_NO_ERROR);

    Ok(status_of(res.iter().all(|ok| *ok), "Fail"))
}

/// `PreprocessorCase::iterate`
fn preprocessor(context: &Context, glsl_version: GlslVersion, behaviour: Option<&str>) -> TestOutcome {
    let gl = context.gl();
    let dim = 4;

    let _fbo = FboSentry::new(gl, dim, dim, glw::GL_RGBA8, glw::GL_NONE)?;
    // SAFETY: plain state calls.
    unsafe {
        gl.clear_color(0.125, 0.125, 0.125, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
    }

    let extension_directive = match behaviour {
        Some(behaviour) => format!("#extension GL_KHR_blend_equation_advanced : {behaviour}"),
        None => String::new(),
    };
    let frg_src = format!(
        "{}\n{extension_directive}\nprecision highp float;\n\nuniform vec4 uDefined;\nuniform vec4 uNonDefined;\n\nuniform int  uValue;\n\nlayout(location = 0) out vec4 oCol;\n\nvoid main (void) {{\n    vec4 col = uNonDefined;\n#if defined(GL_KHR_blend_equation_advanced)\n    int val = GL_KHR_blend_equation_advanced;\n    if (uValue == val) {{\n        col = uDefined;\n    }}\n#endif\n    oCol = col;\n}}\n",
        glsl_version.declaration()
    );

    let program = build_vtx_frag(gl, glsl_version, &frg_src)?;
    // SAFETY: the program linked.
    unsafe { gl.use_program(program.program()) };
    glu::expect_no_error(gl, "Program failed")?;

    // SAFETY: the locations come from the program in use.
    unsafe {
        gl.uniform_1i(uniform_location(gl, &program, c"uValue"), 1);
        gl.uniform_4f(uniform_location(gl, &program, c"uDefined"), 0.0, 1.0, 0.0, 1.0);
        gl.uniform_4f(uniform_location(gl, &program, c"uNonDefined"), 1.0, 0.0, 1.0, 1.0);
    }
    glu::expect_no_error(gl, "Uniforms failed")?;

    let pos_binding = va::float("aPos", 2, 4, 0, &POS);
    glu::draw(
        &context.render_context,
        program.program(),
        &[pos_binding],
        &pr::triangles(&INDICES),
    )?;
    glu::expect_no_error(gl, "Draw failed")?;

    let result = read_pixel_0_0(gl)?;
    Ok(status_of(result == [0, 255, 0, 255], "Fail"))
}

/// `ModeCase::iterate`
fn blend_equation_separate(context: &Context, mode: glw::GLenum) -> TestOutcome {
    let gl = context.gl();
    let get_integer = |pname: glw::GLenum| {
        let mut value = glw::GL_NONE as glw::GLint;
        // SAFETY: one GLint out.
        unsafe { gl.get_integerv(pname, &mut value) };
        value
    };

    // SAFETY: plain state call.
    unsafe { gl.blend_equation_separate(mode, glw::GL_FUNC_ADD) };
    let mut rgb_ok = get_error(gl) == glw::GL_INVALID_ENUM;
    rgb_ok = rgb_ok && get_integer(glw::GL_BLEND_EQUATION_RGB) == glw::GL_FUNC_ADD as glw::GLint;

    // SAFETY: plain state call.
    unsafe { gl.blend_equation_separate(glw::GL_FUNC_ADD, mode) };
    let mut alpha_ok = get_error(gl) == glw::GL_INVALID_ENUM;
    alpha_ok = alpha_ok && get_integer(glw::GL_BLEND_EQUATION_ALPHA) == glw::GL_FUNC_ADD as glw::GLint;

    Ok(status_of(rgb_ok && alpha_ok, "Fail"))
}

/// `MRTCase::iterate`
fn mrt(context: &Context, glsl_version: GlslVersion, array: bool) -> TestOutcome {
    let gl = context.gl();

    let (outputs, writes) = if array {
        (
            "layout (location = 0) out vec4 oCol[2];\n",
            "   oCol[0] = uMultCol;\n   oCol[1] = uMultCol;\n",
        )
    } else {
        (
            "layout (location = 0) out vec4 oCol0;\nlayout (location = 1) out vec4 oCol1;\n",
            "   oCol0 = uMultCol;\n   oCol1 = uMultCol;\n",
        )
    };
    let frg_src = format!(
        "{}\n#extension GL_KHR_blend_equation_advanced : require\n\nprecision highp float;\nlayout (blend_support_multiply) out;\n{outputs}\nuniform vec4 uMultCol;\n\nvoid main (void) {{\n{writes}}}\n",
        glsl_version.declaration()
    );

    let _fbo = FboSentry::new(gl, 4, 4, glw::GL_RGBA8, glw::GL_RGBA8)?;

    let bufs = [glw::GL_COLOR_ATTACHMENT0, glw::GL_COLOR_ATTACHMENT1];
    // SAFETY: two enums are read.
    unsafe { gl.draw_buffers(2, bufs.as_ptr()) };

    // SAFETY: plain state calls.
    unsafe {
        gl.clear_color(1.0, 1.0, 1.0, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
    }

    let program = build_vtx_frag(gl, glsl_version, &frg_src)?;
    // SAFETY: the program linked.
    unsafe { gl.use_program(program.program()) };
    glu::expect_no_error(gl, "Program failed")?;

    // SAFETY: plain state calls.
    unsafe {
        gl.disable(glw::GL_DITHER);
        gl.enable(glw::GL_BLEND);
        gl.blend_equation(glw::GL_DARKEN_KHR);
    }
    glu::expect_no_error(gl, "BlendEquation failed")?;

    // SAFETY: the location comes from the program in use.
    unsafe { gl.uniform_4f(uniform_location(gl, &program, c"uMultCol"), 0.0, 0.0, 0.0, 1.0) };
    glu::expect_no_error(gl, "Uniforms failed")?;

    let vbo = glu::Buffer::new(gl);
    let vao = glu::VertexArray::new(gl);
    // SAFETY: the names are owned by the guards above; `POS` is read for its own size.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo.get());
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(&POS) as glw::GLsizeiptr,
            POS.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );

        gl.bind_vertex_array(vao.get());
        let loc = gl.get_attrib_location(program.program(), c"aPos".as_ptr());
        gl.enable_vertex_attrib_array(loc as u32);
        gl.vertex_attrib_pointer(loc as u32, 2, glw::GL_FLOAT, glw::FALSE, 8, std::ptr::null());
    }
    glu::expect_no_error(gl, "Attributes failed")?;

    // SAFETY: four vertices are bound; the client-side index pointer is rejected before any read.
    let mut error_ok = unsafe {
        gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);
        get_error(gl) == glw::GL_INVALID_OPERATION
    };
    // SAFETY: as above.
    unsafe { gl.draw_elements(glw::GL_TRIANGLES, 6, glw::GL_UNSIGNED_SHORT, INDICES.as_ptr().cast()) };
    error_ok = error_ok && get_error(gl) == glw::GL_INVALID_OPERATION;

    if !error_ok {
        log::info!("DrawArrays/DrawElements didn't produce error.");
    }

    let mut contents_ok = true;
    for i in 0..2 {
        // SAFETY: plain state call.
        unsafe { gl.read_buffer(bufs[0]) };
        let result = read_pixel_0_0(gl)?;
        if result != [255, 255, 255, 255] {
            contents_ok = false;
            log::info!("Buffer {i} contents changed: {result:?} expected: [255, 255, 255, 255]");
        }
    }

    Ok(status_of(error_ok && contents_ok, "Fail"))
}

/// `MissingCase::iterate`
fn missing(
    context: &Context,
    glsl_version: GlslVersion,
    mode: glw::GLenum,
    layout_qualifier: Option<&str>,
) -> TestOutcome {
    let gl = context.gl();
    let _fbo = FboSentry::new(gl, 4, 4, glw::GL_RGBA8, glw::GL_NONE)?;

    // SAFETY: plain state calls.
    unsafe {
        gl.clear_color(1.0, 1.0, 1.0, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
    }

    let frg_src = solid_shader(
        layout_qualifier,
        glsl_version.declaration(),
        "#extension GL_KHR_blend_equation_advanced : require",
    );
    let program = build_vtx_frag(gl, glsl_version, &frg_src)?;
    // SAFETY: the program linked.
    unsafe { gl.use_program(program.program()) };
    glu::expect_no_error(gl, "Program failed")?;

    // SAFETY: plain state calls.
    unsafe {
        gl.disable(glw::GL_DITHER);
        gl.enable(glw::GL_BLEND);
        gl.blend_equation(mode);
    }
    glu::expect_no_error(gl, "BlendEquation failed")?;

    // SAFETY: the location comes from the program in use.
    unsafe { gl.uniform_4f(uniform_location(gl, &program, c"uSrcCol"), 0.0, 0.0, 0.0, 1.0) };
    glu::expect_no_error(gl, "Uniform failed")?;

    let pos_binding = va::float("aPos", 2, 4, 0, &POS);
    glu::draw(
        &context.render_context,
        program.program(),
        &[pos_binding],
        &pr::triangles(&INDICES),
    )?;

    Ok(status_of(get_error(gl) == glw::GL_INVALID_OPERATION, "Fail"))
}

/// `ExtensionDirectiveTestCase::iterate`
fn extension_directive(context: &Context, glsl_version: GlslVersion, behaviour: &str) -> TestOutcome {
    let gl = context.gl();
    let (require_info_log, require_compile) = match behaviour {
        "disable" => (true, false),
        _ => (false, true),
    };

    let _fbo = FboSentry::new(gl, 4, 4, glw::GL_RGBA8, glw::GL_NONE)?;

    // SAFETY: plain state calls.
    unsafe {
        gl.clear_color(1.0, 1.0, 1.0, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
    }

    let directive = format!("#extension GL_KHR_blend_equation_advanced : {behaviour}");
    let frg_src = solid_shader(Some("blend_support_multiply"), glsl_version.declaration(), &directive);
    let sources = ProgramSources::vtx_frag(def_2d_vtx_src(glsl_version), frg_src);
    let program = if require_compile {
        ShaderProgram::new(gl, &sources)
    } else {
        ShaderProgram::new_expecting_build_failure(gl, &sources)
    };

    let info_log_ok = !require_info_log
        || program
            .shader_info
            .iter()
            .find(|(shader_type, _)| *shader_type == glu::ShaderType::Fragment)
            .is_some_and(|(_, info)| !info.info_log.is_empty());
    if !program.is_ok() {
        if require_compile {
            return Err(TestError::Fail("Compile failed".to_string()));
        }
        return Ok(status_of(info_log_ok, "Fail. Expected info log."));
    }
    // SAFETY: the program linked.
    unsafe { gl.use_program(program.program()) };
    glu::expect_no_error(gl, "Program failed")?;

    if !info_log_ok {
        return Ok(TestStatus::fail("Fail. No warnings were generated."));
    }

    // SAFETY: plain state calls.
    unsafe {
        gl.disable(glw::GL_DITHER);
        gl.enable(glw::GL_BLEND);
        gl.blend_equation(glw::GL_MULTIPLY_KHR);
    }
    glu::expect_no_error(gl, "BlendEquation failed")?;

    // SAFETY: the location comes from the program in use.
    unsafe { gl.uniform_4f(uniform_location(gl, &program, c"uSrcCol"), 0.0, 0.0, 0.0, 1.0) };
    glu::expect_no_error(gl, "Uniform failed")?;

    let pos_binding = va::float("aPos", 2, 4, 0, &POS);
    glu::draw(
        &context.render_context,
        program.program(),
        &[pos_binding],
        &pr::triangles(&INDICES),
    )?;
    glu::expect_no_error(gl, "Draw failed")?;

    let result = read_pixel_0_0(gl)?;
    Ok(status_of(result == [0, 0, 0, 255], "Fail"))
}

/// `PixelFormat::convertChannel`, private upstream and in `tcu::PixelFormat` here.
fn convert_channel(val: i32, bits: i32) -> i32 {
    if bits == 0 {
        0
    } else if bits == 1 {
        if val & 0x80 != 0 { 0xff } else { 0 }
    } else if bits < 8 {
        let int_comp = val >> (8 - bits);
        let fract_comp = (int_comp << (24 - bits)) | (int_comp << (24 - 2 * bits)) | (int_comp << (24 - 3 * bits));
        (int_comp << (8 - bits)) | (fract_comp >> (bits + 16))
    } else {
        val
    }
}

/// `PixelFormat::convertColor`
fn convert_color(pf: &PixelFormat, col: RGBA) -> RGBA {
    RGBA::new(
        convert_channel(col.get_red(), pf.red_bits),
        convert_channel(col.get_green(), pf.green_bits),
        convert_channel(col.get_blue(), pf.blue_bits),
        if pf.alpha_bits != 0 {
            convert_channel(col.get_alpha(), pf.alpha_bits)
        } else {
            0xff
        },
    )
}

/// `MaskChannels`
fn mask_channels(pf: &PixelFormat, v: [f32; 4]) -> [f32; 4] {
    [
        if pf.red_bits > 0 { v[0] } else { 0.0 },
        if pf.green_bits > 0 { v[1] } else { 0.0 },
        if pf.blue_bits > 0 { v[2] } else { 0.0 },
        if pf.alpha_bits > 0 { v[3] } else { 1.0 },
    ]
}

/// `QuantizeChannels`
fn quantize_channels(pf: &PixelFormat, v: [f32; 4]) -> [f32; 4] {
    let max_channel = [
        (1i32 << pf.red_bits) as f32 - 1.0,
        (1i32 << pf.green_bits) as f32 - 1.0,
        (1i32 << pf.blue_bits) as f32 - 1.0,
        (1i32 << pf.alpha_bits) as f32 - 1.0,
    ];
    let quantize = |i: usize| (v[i] * max_channel[i]) as u32 as f32 / max_channel[i];
    [
        quantize(0),
        quantize(1),
        quantize(2),
        if pf.alpha_bits != 0 { quantize(3) } else { 1.0 },
    ]
}

/// `BlendTest::getTestColors`
fn get_test_colors(pf: &PixelFormat, colors: &[f32], index: usize) -> ([f32; 4], [f32; 4]) {
    let s = &colors[8 * index..8 * index + 8];
    let clamp = |v: [f32; 4]| v.map(|c| c.clamp(0.0, 1.0));
    let src = clamp(mask_channels(pf, [s[0], s[1], s[2], s[3]]));
    let dst = clamp(mask_channels(pf, [s[4], s[5], s[6], s[7]]));
    (src, quantize_channels(pf, dst))
}

fn rgba_of(v: [f32; 4]) -> RGBA {
    RGBA::from_vec(Vec4::new(v[0], v[1], v[2], v[3]))
}

/// `BlendTestCaseGroup::BlendTest::iterate`
fn blend_test(context: &Context, glsl_version: GlslVersion, mode: glw::GLenum, use_all_qualifier: bool) -> TestOutcome {
    let gl = context.gl();
    let rt = context.render_target();
    let pf = rt.pixel_format();

    let hue_or_saturation = mode == glw::GL_HSL_HUE_KHR || mode == glw::GL_HSL_SATURATION_KHR;
    let use_rgb10a2_data =
        hue_or_saturation && pf.red_bits == 10 && pf.green_bits == 10 && pf.blue_bits == 10 && pf.alpha_bits == 2;
    let colors: &[f32] = if use_rgb10a2_data {
        &khr_blend_colors::RGB10A2
    } else {
        &khr_blend_colors::COMMON
    };
    let num_colors = colors.len() / 8;

    let layout_qualifier = if use_all_qualifier {
        "blend_support_all_equations"
    } else {
        layout_qualifier_str(mode)
    };
    let frg_src = solid_shader(
        Some(layout_qualifier),
        glsl_version.declaration(),
        "#extension GL_KHR_blend_equation_advanced : require",
    );
    let program = build_vtx_frag(gl, glsl_version, &frg_src)?;
    // SAFETY: the program linked.
    unsafe { gl.use_program(program.program()) };
    glu::expect_no_error(gl, "Program failed")?;

    let pos_binding = [va::float("aPos", 2, 4, 0, &POS)];

    // SAFETY: plain state calls.
    unsafe {
        gl.disable(glw::GL_DITHER);
        gl.enable(glw::GL_SCISSOR_TEST);
        gl.enable(glw::GL_BLEND);
        gl.blend_equation(mode);
    }
    glu::expect_no_error(gl, "BlendEquation failed")?;

    let need_barrier = !context.context_info.is_extension_supported(EXTENSION_COHERENT);

    for color_index in 0..num_colors {
        let (src_col, dst_col) = get_test_colors(&pf, colors, color_index);

        let y = color_index as i32 / rt.width;
        let x = color_index as i32 % rt.width;
        // SAFETY: plain state calls.
        unsafe {
            gl.scissor(x, y, 1, 1);
            gl.clear_color(dst_col[0], dst_col[1], dst_col[2], dst_col[3]);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            if need_barrier {
                gl.blend_barrier();
            }
            gl.uniform_4f(
                uniform_location(gl, &program, c"uSrcCol"),
                src_col[0],
                src_col[1],
                src_col[2],
                src_col[3],
            );
        }
        glu::expect_no_error(gl, "Uniforms failed")?;

        glu::draw(
            &context.render_context,
            program.program(),
            &pos_binding,
            &pr::triangles(&INDICES),
        )?;
        glu::expect_no_error(gl, "Draw failed")?;
        if need_barrier {
            // SAFETY: plain state call.
            unsafe { gl.blend_barrier() };
        }
    }

    let w = rt.width;
    let h = rt.height;
    let mut result_bytes = vec![0u8; 4 * (w * h) as usize];
    // SAFETY: the buffer holds w * h RGBA8 pixels.
    unsafe {
        gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1);
        gl.read_pixels(
            0,
            0,
            w,
            h,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            result_bytes.as_mut_ptr().cast(),
        );
    }
    glu::expect_no_error(gl, "Read pixels failed")?;

    let mut pass = true;
    for color_index in 0..num_colors {
        let (src_col, dst_col) = get_test_colors(&pf, colors, color_index);

        let y = color_index as i32 / w;
        let x = color_index as i32 % w;

        let ref_col = blend_reference::blend_mode(mode, &src_col, &dst_col);
        let reference = convert_color(&pf, rgba_of(ref_col));
        let offset = 4 * (x + w * y) as usize;
        let res = RGBA::new(
            result_bytes[offset] as i32,
            result_bytes[offset + 1] as i32,
            result_bytes[offset + 2] as i32,
            result_bytes[offset + 3] as i32,
        );
        let tmp = pf.get_color_threshold();
        let threshold = RGBA::new(
            (2 + 2 * tmp.get_red()).min(255),
            (2 + 2 * tmp.get_green()).min(255),
            (2 + 2 * tmp.get_blue()).min(255),
            (2 + 2 * tmp.get_alpha()).min(255),
        );
        let pixel_ok = tcu::rgba::compare_threshold(reference, res, threshold);
        pass = pass && pixel_ok;
        if !pixel_ok {
            log::info!(
                "({x},{y})  ({color_index}) Exceeds: {threshold:?} diff:{:?}  res:{res:?}  ref:{reference:?}  dst:{:?}  src:{:?}",
                tcu::rgba::compute_abs_diff(reference, res),
                rgba_of(dst_col),
                rgba_of(src_col)
            );
        }
    }

    Ok(status_of(pass, "results differ"))
}

struct BlendStep {
    mode: glw::GLenum,
    src: [f32; 4],
}

const fn step(mode: glw::GLenum, r: f32, g: f32, b: f32, a: f32) -> BlendStep {
    BlendStep {
        mode,
        src: [r, g, b, a],
    }
}

const S_MIXED: [BlendStep; 11] = [
    step(glw::GL_LIGHTEN_KHR, 0.250, 0.375, 1.000, 1.000),
    step(glw::GL_OVERLAY_KHR, 1.000, 1.000, 1.000, 1.000),
    step(glw::GL_HARDLIGHT_KHR, 0.750, 0.750, 0.250, 1.000),
    step(glw::GL_DARKEN_KHR, 0.250, 0.250, 0.250, 1.000),
    step(glw::GL_COLORDODGE_KHR, 0.750, 0.875, 1.000, 1.000),
    step(glw::GL_MULTIPLY_KHR, 0.500, 0.500, 0.500, 1.000),
    step(glw::GL_SCREEN_KHR, 0.500, 0.500, 0.500, 1.000),
    step(glw::GL_DARKEN_KHR, 0.250, 0.500, 0.500, 1.000),
    step(glw::GL_DIFFERENCE_KHR, 0.000, 0.875, 0.125, 1.000),
    step(glw::GL_EXCLUSION_KHR, 1.000, 0.500, 0.750, 1.000),
    step(glw::GL_DARKEN_KHR, 0.125, 0.125, 0.125, 1.000),
];

const S_MULTIPLY: [BlendStep; 7] = [
    step(glw::GL_LIGHTEN_KHR, 1.000, 1.000, 1.000, 1.000),
    step(glw::GL_MULTIPLY_KHR, 0.500, 0.500, 0.500, 1.000),
    step(glw::GL_MULTIPLY_KHR, 0.500, 0.500, 0.500, 1.000),
    step(glw::GL_MULTIPLY_KHR, 0.500, 0.500, 0.500, 1.000),
    step(glw::GL_MULTIPLY_KHR, 0.500, 0.500, 0.500, 1.000),
    step(glw::GL_MULTIPLY_KHR, 0.500, 0.500, 0.500, 1.000),
    step(glw::GL_MULTIPLY_KHR, 0.500, 0.500, 0.500, 1.000),
];

/// `CoherentBlendTestCaseGroup::CoherentBlendTest::iterate`
fn coherent_blend_test(context: &Context, glsl_version: GlslVersion, repeat_count: usize, mixed: bool) -> TestOutcome {
    const DIM: i32 = 1024;
    let gl = context.gl();
    let rt = context.render_target();
    let pf = rt.pixel_format();
    let steps: &[BlendStep] = if mixed { &S_MIXED } else { &S_MULTIPLY };

    let need_barrier = !context.context_info.is_extension_supported(EXTENSION_COHERENT);

    let mut dst_col: [f32; 4] = [0.0; 4];

    let _fbo = FboSentry::new(gl, DIM, DIM, glw::GL_RGBA8, glw::GL_NONE)?;

    let frg_src = solid_shader(
        Some("blend_support_all_equations"),
        glsl_version.declaration(),
        "#extension GL_KHR_blend_equation_advanced : require",
    );
    let program = build_vtx_frag(gl, glsl_version, &frg_src)?;
    // SAFETY: the program linked.
    unsafe { gl.use_program(program.program()) };
    glu::expect_no_error(gl, "Program failed")?;

    let pos_binding = [va::float("aPos", 2, 4, 0, &POS)];

    // SAFETY: plain state calls.
    unsafe {
        gl.disable(glw::GL_DITHER);
        gl.enable(glw::GL_BLEND);
        gl.clear_color(dst_col[0], dst_col[1], dst_col[2], dst_col[3]);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
        if need_barrier {
            gl.blend_barrier();
        }
    }

    for _ in 0..repeat_count {
        for s in steps {
            dst_col = blend_reference::blend_mode(s.mode, &s.src, &dst_col);

            // SAFETY: plain state call.
            unsafe { gl.blend_equation(s.mode) };
            glu::expect_no_error(gl, "BlendEquation failed")?;

            // SAFETY: the program is in use.
            unsafe {
                gl.uniform_4f(
                    uniform_location(gl, &program, c"uSrcCol"),
                    s.src[0],
                    s.src[1],
                    s.src[2],
                    s.src[3],
                )
            };
            glu::expect_no_error(gl, "Uniforms failed")?;

            glu::draw(
                &context.render_context,
                program.program(),
                &pos_binding,
                &pr::triangles(&INDICES),
            )?;
            glu::expect_no_error(gl, "Draw failed")?;

            if need_barrier {
                // SAFETY: plain state call.
                unsafe { gl.blend_barrier() };
            }
        }
    }

    let mut result = vec![0u8; 4 * (DIM * DIM) as usize];
    // SAFETY: the buffer holds DIM * DIM RGBA8 pixels.
    unsafe {
        gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1);
        gl.read_pixels(
            0,
            0,
            DIM,
            DIM,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            result.as_mut_ptr().cast(),
        );
    }
    glu::expect_no_error(gl, "Read pixels failed")?;

    let res = RGBA::new(result[0] as i32, result[1] as i32, result[2] as i32, result[3] as i32);
    let reference = convert_color(&pf, rgba_of(dst_col));
    let tmp = pf.get_color_threshold();
    let threshold = RGBA::new(
        (2 * tmp.get_red()).min(255),
        (2 * tmp.get_green()).min(255),
        (2 * tmp.get_blue()).min(255),
        (2 * tmp.get_alpha()).min(255),
    );
    let first_ok = tcu::rgba::compare_threshold(reference, res, threshold);

    let all_same = (0..(DIM * (DIM - 1)) as usize).all(|i| result[..4] == result[i * 4..i * 4 + 4]);

    let pass = first_ok && all_same;
    if !pass {
        log::info!(
            "Exceeds: {threshold:?} diff:{:?}  res:{res:?}  ref:{:?}",
            tcu::rgba::compute_abs_diff(reference, res),
            rgba_of(dst_col)
        );
    }

    Ok(status_of(pass, "results differ"))
}

fn case(name: impl Into<String>, glsl_version: GlslVersion, kind: Kind) -> Box<dyn TestCase> {
    Box::new(BlendCase {
        name: name.into(),
        glsl_version,
        kind,
    })
}

/// `BlendEquationAdvancedTests::init`
pub fn create_tests(glsl_version: GlslVersion) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("blend_equation_advanced");

    let mut coherent = TestCaseGroup::new("coherent");
    coherent.add_child(case("enableDisable", glsl_version, Kind::CoherentEnable));
    group.add_child(coherent);

    let mut preprocessor = TestCaseGroup::new("preprocessor");
    for behaviour in [None, Some("require"), Some("enable"), Some("warn"), Some("disable")] {
        preprocessor.add_child(case(
            behaviour.unwrap_or("none"),
            glsl_version,
            Kind::Preprocessor(behaviour),
        ));
    }
    group.add_child(preprocessor);

    let mut separate = TestCaseGroup::new("BlendEquationSeparate");
    for mode in MODES {
        separate.add_child(case(mode_str(mode), glsl_version, Kind::BlendEquationSeparate(mode)));
    }
    group.add_child(separate);

    let mut mrt_group = TestCaseGroup::new("MRT");
    mrt_group.add_child(case("MRT_array", glsl_version, Kind::Mrt { array: true }));
    mrt_group.add_child(case("MRT_separate", glsl_version, Kind::Mrt { array: false }));
    group.add_child(mrt_group);

    let mut mismatching = TestCaseGroup::new("mismatching_qualifier");
    for (i, mode) in MODES.into_iter().enumerate() {
        let qualifier = layout_qualifier_str(MODES[(i + 1) % MODES.len()]);
        mismatching.add_child(case(
            mode_str(mode),
            glsl_version,
            Kind::Missing {
                mode,
                layout_qualifier: Some(qualifier),
            },
        ));
    }
    group.add_child(mismatching);

    let mut missing_group = TestCaseGroup::new("missing_qualifier");
    for mode in MODES {
        missing_group.add_child(case(
            mode_str(mode),
            glsl_version,
            Kind::Missing {
                mode,
                layout_qualifier: None,
            },
        ));
    }
    group.add_child(missing_group);

    let mut directive = TestCaseGroup::new("extension_directive");
    for behaviour in ["disable", "enable", "warn"] {
        directive.add_child(case(
            format!("extension_directive_{behaviour}"),
            glsl_version,
            Kind::ExtensionDirective(behaviour),
        ));
    }
    group.add_child(directive);

    for (name, all_qualifier) in [("blend_all", true), ("blend_specific", false)] {
        let mut blends = TestCaseGroup::new(name);
        for mode in MODES {
            let case_name = if all_qualifier {
                format!("{}_all_qualifier", mode_str(mode))
            } else {
                mode_str(mode).to_string()
            };
            blends.add_child(case(case_name, glsl_version, Kind::Blend { mode, all_qualifier }));
        }
        group.add_child(blends);
    }

    let mut coherency = TestCaseGroup::new("test_coherency");
    coherency.add_child(case(
        "mixedSequence",
        glsl_version,
        Kind::Coherency {
            repeat_count: 4,
            mixed: true,
        },
    ));
    coherency.add_child(case(
        "multiplySequence",
        glsl_version,
        Kind::Coherency {
            repeat_count: 1,
            mixed: false,
        },
    ));
    group.add_child(coherency);

    group
}
