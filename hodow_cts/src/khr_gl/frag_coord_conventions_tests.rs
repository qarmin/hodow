// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcFragCoordConventionsTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts, desktop branches only (the ES branches need an ES context, which the KHR-GL roots never have). Upstream's `refColorsMultisample` is a mutable global the gather pass fills for the compare pass; here it is a local of `iterate`. `initEpsilon` is never called upstream, so the RGB10_A2 comparison there runs against uninitialised epsilons; they are zero here.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLuint};
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const NUM_SHADERS_MULTISAMPLE: usize = 2;
const NUM_SAMPLE_POINTS: usize = 4;
const OFFSET: i32 = 7;
const FBO_X: i32 = 512;
const FBO_Y: i32 = 512;

type SampleSet = [u32; NUM_SAMPLE_POINTS];

const REF_COLORS_MULTISAMPLE: [SampleSet; NUM_SHADERS_MULTISAMPLE] = [
    [0xff800404, 0xff8004fc, 0xff80fc04, 0xff80fcfc],
    [0xff800404, 0xff8004fc, 0xff80fc04, 0xff80fcfc],
];

const DEFAULT_QUAD: [f32; 16] = [
    -1.0, -1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
];

const CULL_QUAD: [f32; 32] = [
    -1.0, -1.0, 0.0, 1.0, 0.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, //
    -0.0, -1.0, 0.0, 1.0, -0.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
];

const DEFAULT_SHADER_VERT: &str = "${VERSION}\n\
    ${EXTENSION}\n\
    \n\
    layout (location = 0) in vec4 pos;\n\
    out vec4 i;\n\
    \n\
    uniform float windowWidth;\n\
    uniform float windowHeight;\n\
    uniform float n;\n\
    uniform float f;\n\
    \n\
    void main()\n\
    {\n\
    \x20 gl_Position = pos;\n\
    \x20 i = vec4((pos.x+1.0)*0.5*windowWidth, (pos.y+1.0)*0.5*windowHeight, (f-n)*0.5*pos.z + (f+n)*0.5, pos.w);\n\
    }\n";

const DEFAULT_SHADER_FRAG: &str = "${VERSION}\n\
    ${EXTENSION}\n\
    ${PRECISION}\n\
    \n\
    in vec4 i;\n\
    \n\
    ${COORD_LAYOUT}\n\
    layout (location = 0) out vec4 myColor;\n\
    \n\
    void main()\n\
    {\n\
    \x20   float w = float(gl_SampleID+1)/4.0;\n\
    \x20   w*=w;\n\
    \x20   myColor = i * vec4(gl_SamplePosition.x*w, gl_SamplePosition.y*w, 1.0, 1.0);\n\
    }\n";

const MULTISAMPLE_SHADER_FRAG: &str = "${VERSION}\n\
    ${EXTENSION}\n\
    ${PRECISION}\n\
    \n\
    in vec4 i;\n\
    \n\
    layout (location = 0) out vec4 myColor;\n\
    \n\
    void main()\n\
    {\n\
    \x20   float w = float(gl_SampleID+1)/4.0;\n\
    \x20   w*=w;\n\
    \x20   myColor = i * vec4(gl_SamplePosition.x*w, gl_SamplePosition.y*w, 1.0, 1.0);\n\
    }\n";

struct TestParams {
    index: usize,
    use_fbo: bool,
    use_cull: bool,
    scissor_test: bool,
    use_multisample: bool,
    gather_samples: bool,
    override_check_index: Option<usize>,
}

/// `FragCoordConventionsTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("frag_coord_conventions");
    group.add_child(Box::new(FragCoordConventionsMultisampleTestCase) as Box<dyn TestCase>);
    group
}

/// The `#extension` block and `gl_FragCoord` layout `init` picks, or `None` when the test is not supported.
fn desktop_specialization(context: &Context) -> Option<(&'static str, &'static str)> {
    let context_type = context.context_type();
    let info = &context.context_info;

    if context_type.supports_core(4, 0) {
        Some(("", ""))
    } else if context_type.supports_core(3, 3) {
        Some((
            "\n                #extension GL_ARB_sample_shading : enable\n                                               ",
            "",
        ))
    } else if context_type.supports_core(3, 0)
        && info.is_extension_supported("GL_ARB_fragment_coord_conventions")
        && info.is_extension_supported("GL_ARB_explicit_attrib_location")
        && info.is_extension_supported("GL_ARB_sample_shading")
    {
        Some((
            "\n                #extension GL_ARB_fragment_coord_conventions: require\n                #extension GL_ARB_explicit_attrib_location : enable\n                #extension GL_ARB_sample_shading : require\n                                               ",
            "layout (origin_upper_left,pixel_center_integer) in vec4 gl_FragCoord;",
        ))
    } else {
        None
    }
}

/// `getReadbufferBits` for the colour sizes, desktop branch of `getBits`.
fn get_readbuffer_bits(gl: &glw::Functions, pname: glw::GLenum) -> Result<i32, TestError> {
    let mut fbo: glw::GLint = 0;
    gl_call!(
        gl,
        "getIntegerv",
        gl.get_integerv(glw::GL_READ_FRAMEBUFFER_BINDING, &mut fbo)
    );

    let mut color_attachment: glw::GLint = 0;
    gl_call!(
        gl,
        "getIntegerv",
        gl.get_integerv(glw::GL_READ_BUFFER, &mut color_attachment)
    );

    let color_attachment = match color_attachment as glw::GLenum {
        glw::GL_BACK => glw::GL_BACK_LEFT,
        glw::GL_FRONT => glw::GL_FRONT_LEFT,
        other => other,
    };

    let size_pname = match pname {
        glw::GL_RED_BITS => glw::GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE,
        glw::GL_GREEN_BITS => glw::GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE,
        glw::GL_BLUE_BITS => glw::GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE,
        _ => glw::GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE,
    };

    let mut value: glw::GLint = 0;
    gl_call!(
        gl,
        "getFramebufferAttachmentParameteriv",
        gl.get_framebuffer_attachment_parameteriv(glw::GL_READ_FRAMEBUFFER, color_attachment, size_pname, &mut value)
    );
    Ok(value)
}

/// `FragCoordConventionsMultisampleTestCase`
struct FragCoordConventionsMultisampleTestCase;

impl FragCoordConventionsMultisampleTestCase {
    /// `checkColor`
    fn check_color(gl: &glw::Functions, x: i32, y: i32, reference: u32) -> Result<bool, TestError> {
        let mut mask: u32 = 0xFFFFFFFF;
        let bits = [
            get_readbuffer_bits(gl, glw::GL_RED_BITS)?,
            get_readbuffer_bits(gl, glw::GL_GREEN_BITS)?,
            get_readbuffer_bits(gl, glw::GL_BLUE_BITS)?,
            get_readbuffer_bits(gl, glw::GL_ALPHA_BITS)?,
        ];

        if bits == [10, 10, 10, 2] {
            let mut temp_color: u32 = 0;
            gl_call!(
                gl,
                "readPixels",
                gl.read_pixels(
                    x,
                    y,
                    1,
                    1,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_INT_2_10_10_10_REV,
                    std::ptr::from_mut(&mut temp_color).cast()
                )
            );

            let color_ref = [
                (reference & 0xFF) as f32 / 255.0,
                (reference >> 8 & 0xFF) as f32 / 255.0,
                (reference >> 16 & 0xFF) as f32 / 255.0,
                (reference >> 24 & 0xFF) as f32 / 255.0,
            ];
            let color = [
                (temp_color & 0x3FF) as f32 / 1023.0,
                (temp_color >> 10 & 0x3FF) as f32 / 1023.0,
                (temp_color >> 20 & 0x3FF) as f32 / 1023.0,
                (temp_color >> 30 & 0x3) as f32 / 3.0,
            ];

            if color
                .iter()
                .zip(&color_ref)
                .any(|(actual, expected)| (actual - expected).abs() > 0.0)
            {
                log::info!("Reference and actual values don't match.");
                return Ok(false);
            }
        } else {
            for (channel, &channel_bits) in bits.iter().enumerate() {
                if channel_bits < 8 {
                    mask &= !(((1u32 << (8 - channel_bits)) - 1) << (8 * channel));
                }
            }

            let mut color = [0u8; 4];
            gl_call!(
                gl,
                "readPixels",
                gl.read_pixels(
                    x,
                    y,
                    1,
                    1,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    color.as_mut_ptr().cast()
                )
            );

            let actual = u32::from(color[0])
                + (u32::from(color[1]) << 8)
                + (u32::from(color[2]) << 16)
                + (u32::from(color[3]) << 24);

            log::info!("Reference color at ({x},{y}): {reference:x}, actual color: {actual:x}");

            if (actual & mask) != (reference & mask) {
                log::info!("Reference and actual values don't match.");
                return Ok(false);
            }
        }
        Ok(true)
    }

    /// `gatherColor`
    fn gather_color(gl: &glw::Functions, x: i32, y: i32, reference: &mut u32) -> Result<bool, TestError> {
        let mut color = [0u8; 4];
        gl_call!(
            gl,
            "readPixels",
            gl.read_pixels(
                x,
                y,
                1,
                1,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                color.as_mut_ptr().cast()
            )
        );

        let actual = u32::from(color[0])
            + (u32::from(color[1]) << 8)
            + (u32::from(color[2]) << 16)
            + (u32::from(color[3]) << 24);

        log::info!("Gather color at ({x},{y}): {actual:x}");

        *reference = actual;
        Ok(true)
    }

    /// `drawQuad`
    fn draw_quad(
        gl: &glw::Functions,
        program: &ShaderProgram<'_>,
        params: &TestParams,
        window_width: i32,
        window_height: i32,
    ) -> Result<bool, TestError> {
        let n = 0.0f32;
        let f = 1.0f32;

        log::info!("Case {}", params.index);

        gl_call!(gl, "disable", gl.disable(glw::GL_SCISSOR_TEST));

        gl_call!(gl, "viewport", gl.viewport(0, 0, window_width, window_height));
        gl_call!(gl, "clearColor", gl.clear_color(0.6, 0.4, 0.6, 1.0));
        gl_call!(
            gl,
            "clear",
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT)
        );

        if params.scissor_test {
            gl_call!(gl, "scissor", gl.scissor(5, window_height - 15, 10, 10));
            gl_call!(gl, "enable", gl.enable(glw::GL_SCISSOR_TEST));
        }

        let shader = program.program();

        gl_call!(gl, "useProgram", gl.use_program(shader));

        // SAFETY: a NUL-terminated name.
        let loc_window_width = unsafe { gl.get_uniform_location(shader, c"windowWidth".as_ptr()) };
        glu::expect_no_error(gl, "getUniformLocation")?;

        log::info!("Uniform windowWidth: {window_width} (loc: {loc_window_width})");
        if loc_window_width == -1 {
            log::info!("windowWidth wasnt found, may have been optimised away");
        } else {
            gl_call!(gl, "uniform1f", gl.uniform_1f(loc_window_width, window_width as f32));
        }

        // SAFETY: a NUL-terminated name.
        let loc_window_height = unsafe { gl.get_uniform_location(shader, c"windowHeight".as_ptr()) };
        glu::expect_no_error(gl, "getUniformLocation")?;

        log::info!("Uniform windowHeight: {window_height} (loc: {loc_window_height})");
        if loc_window_height == -1 {
            log::info!("windowHeight wasnt found, may have been optimised away");
        } else {
            gl_call!(gl, "uniform1f", gl.uniform_1f(loc_window_height, window_height as f32));
        }

        // SAFETY: a NUL-terminated name.
        let loc_n = unsafe { gl.get_uniform_location(shader, c"n".as_ptr()) };
        glu::expect_no_error(gl, "getUniformLocation")?;

        log::info!("Uniform n: {n} (loc: {loc_n})");

        if loc_n == -1 {
            log::info!("Error while setting uniform n");
            return Ok(false);
        }
        gl_call!(gl, "uniform1f", gl.uniform_1f(loc_n, n));

        // SAFETY: a NUL-terminated name.
        let loc_f = unsafe { gl.get_uniform_location(shader, c"f".as_ptr()) };
        glu::expect_no_error(gl, "getUniformLocation")?;

        log::info!("Uniform f: {f} (loc: {loc_f})");

        if loc_f == -1 {
            log::info!("Error while setting uniform f");
            return Ok(false);
        }
        gl_call!(gl, "uniform1f", gl.uniform_1f(loc_f, f));

        gl_call!(gl, "depthRange", gl.depth_range(f64::from(n), f64::from(f)));

        // SAFETY: a NUL-terminated name.
        let attrib = unsafe { gl.get_attrib_location(shader, c"pos".as_ptr()) };
        glu::expect_no_error(gl, "getAttribLocation")?;

        log::info!("attrib: {attrib}");

        if attrib == -1 {
            log::info!("Error getting attribute location");
            return Ok(false);
        }

        gl_call!(
            gl,
            "vertexAttribPointer",
            gl.vertex_attrib_pointer(attrib as GLuint, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null())
        );
        gl_call!(
            gl,
            "enableVertexAttribArray",
            gl.enable_vertex_attrib_array(attrib as GLuint)
        );

        gl_call!(gl, "disable", gl.disable(glw::GL_DEPTH_TEST));
        gl_call!(gl, "drawArrays", gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        if params.use_cull {
            gl_call!(gl, "drawArrays", gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 4, 4));
        }

        Ok(true)
    }

    /// `doQuadCase`
    fn do_quad_case(
        context: &Context,
        program: &ShaderProgram<'_>,
        params: &TestParams,
        ref_colors: &mut [SampleSet; NUM_SHADERS_MULTISAMPLE],
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut fbo: GLuint = 0;
        let mut fbo_ms: GLuint = 0;
        let mut rbo: GLuint = 0;
        let mut rbo_ms: GLuint = 0;
        let mut vao: GLuint = 0;
        let mut vbo: GLuint = 0;

        let mut window_width = context.render_target().width;
        let mut window_height = context.render_target().height;

        gl_call!(gl, "genVertexArrays", gl.gen_vertex_arrays(1, &mut vao));
        gl_call!(gl, "bindVertexArray", gl.bind_vertex_array(vao));

        gl_call!(gl, "genBuffers", gl.gen_buffers(1, &mut vbo));
        gl_call!(gl, "bindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo));

        if params.use_cull {
            gl_call!(
                gl,
                "bufferData",
                gl.buffer_data(
                    glw::GL_ARRAY_BUFFER,
                    size_of_val(&CULL_QUAD) as glw::GLsizeiptr,
                    CULL_QUAD.as_ptr().cast(),
                    glw::GL_STATIC_DRAW
                )
            );
        } else {
            gl_call!(
                gl,
                "bufferData",
                gl.buffer_data(
                    glw::GL_ARRAY_BUFFER,
                    size_of_val(&DEFAULT_QUAD) as glw::GLsizeiptr,
                    DEFAULT_QUAD.as_ptr().cast(),
                    glw::GL_STATIC_DRAW
                )
            );
        }

        if params.use_fbo {
            gl_call!(gl, "genFramebuffers", gl.gen_framebuffers(1, &mut fbo));
            gl_call!(gl, "bindFramebuffer", gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo));

            gl_call!(gl, "genRenderbuffers", gl.gen_renderbuffers(1, &mut rbo));
            gl_call!(gl, "bindRenderbuffer", gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo));
            gl_call!(
                gl,
                "renderbufferStorage",
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, FBO_X, FBO_Y)
            );
            gl_call!(
                gl,
                "framebufferRenderbuffer",
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    rbo
                )
            );

            if params.use_multisample {
                gl_call!(gl, "genFramebuffers", gl.gen_framebuffers(1, &mut fbo_ms));
                gl_call!(gl, "bindFramebuffer", gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_ms));

                gl_call!(gl, "genRenderbuffers", gl.gen_renderbuffers(1, &mut rbo_ms));
                gl_call!(
                    gl,
                    "bindRenderbuffer",
                    gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo_ms)
                );
                gl_call!(
                    gl,
                    "renderbufferStorageMultisample",
                    gl.renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, 4, glw::GL_RGBA8, FBO_X, FBO_Y)
                );
                gl_call!(
                    gl,
                    "framebufferRenderbuffer",
                    gl.framebuffer_renderbuffer(
                        glw::GL_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        glw::GL_RENDERBUFFER,
                        rbo_ms
                    )
                );
                gl_call!(gl, "enable", gl.enable(glw::GL_MULTISAMPLE));
            }

            window_width = FBO_X;
            window_height = FBO_Y;
        }

        let mut result = Self::draw_quad(gl, program, params, window_width, window_height)?;
        if !result {
            return Ok(false);
        }

        if params.use_fbo && params.use_multisample {
            gl_call!(
                gl,
                "bindFramebuffer",
                gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo_ms)
            );
            gl_call!(
                gl,
                "bindFramebuffer",
                gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo)
            );
            gl_call!(
                gl,
                "blitFramebuffer",
                gl.blit_framebuffer(
                    0,
                    0,
                    window_width,
                    window_height,
                    0,
                    0,
                    window_width,
                    window_height,
                    glw::GL_COLOR_BUFFER_BIT,
                    glw::GL_NEAREST
                )
            );
            gl_call!(gl, "bindFramebuffer", gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo));
        }

        if params.scissor_test {
            result &= Self::check_color(gl, 10, window_height - 15 - 3, 0xff996699)?;
            result &= Self::check_color(gl, 10, window_height - 15 + 3, ref_colors[params.index][0])?;
            result &= Self::check_color(gl, 10, window_height - 5 - 3, ref_colors[params.index][1])?;
            result &= Self::check_color(gl, 10, window_height - 5 + 3, 0xff996699)?;
            result &= Self::check_color(gl, 3, window_height - 10, 0xff996699)?;
            result &= Self::check_color(gl, 18, window_height - 10, 0xff996699)?;
        } else {
            let i = params.override_check_index.unwrap_or(params.index);

            if params.gather_samples {
                result &= Self::gather_color(gl, OFFSET, OFFSET, &mut ref_colors[i][0])?;
                result &= Self::gather_color(gl, window_width - OFFSET, OFFSET, &mut ref_colors[i][1])?;
                result &= Self::gather_color(gl, OFFSET, window_height - OFFSET, &mut ref_colors[i][2])?;
                result &= Self::gather_color(gl, window_width - OFFSET, window_height - OFFSET, &mut ref_colors[i][3])?;
            } else {
                result &= Self::check_color(gl, OFFSET, OFFSET, ref_colors[i][0])?;
                result &= Self::check_color(gl, window_width - OFFSET, OFFSET, ref_colors[i][1])?;
                result &= Self::check_color(gl, OFFSET, window_height - OFFSET, ref_colors[i][2])?;
                result &= Self::check_color(gl, window_width - OFFSET, window_height - OFFSET, ref_colors[i][3])?;
            }
        }

        if params.use_fbo {
            gl_call!(gl, "bindFramebuffer", gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
            gl_call!(gl, "deleteRenderbuffers", gl.delete_renderbuffers(1, &rbo));
            gl_call!(gl, "deleteFramebuffers", gl.delete_framebuffers(1, &fbo));

            if params.use_multisample {
                gl_call!(gl, "deleteRenderbuffers", gl.delete_renderbuffers(1, &rbo_ms));
                gl_call!(gl, "deleteFramebuffers", gl.delete_framebuffers(1, &fbo_ms));
            }
        }

        gl_call!(gl, "deleteBuffers", gl.delete_buffers(1, &vbo));
        gl_call!(gl, "deleteVertexArrays", gl.delete_vertex_arrays(1, &vao));

        Ok(result)
    }

    /// The program building half of `init`.
    fn make_program<'gl>(
        gl: &'gl glw::Functions,
        vs: &str,
        fs: &str,
        specialization: &[(&str, String)],
    ) -> Result<ShaderProgram<'gl>, TestError> {
        let vert_shader = StringTemplate::new(vs).specialize(specialization)?;
        let frag_shader = StringTemplate::new(fs).specialize(specialization)?;

        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vert_shader, frag_shader));

        if !program.is_ok() {
            log::info!(
                "Shader build failed.\n{}",
                program.build_failure_summary().unwrap_or_default()
            );
            return Err(TestError::Fail("Invalid program".to_string()));
        }
        Ok(program)
    }
}

impl TestCase for FragCoordConventionsMultisampleTestCase {
    fn name(&self) -> &str {
        "multisample"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if desktop_specialization(context).is_none() {
            return Err(TestError::NotSupported(
                "Test frag_coord_conventions.multisample is not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let Some((extension, coord_layout)) = desktop_specialization(context) else {
            return Err(TestError::NotSupported(
                "Test frag_coord_conventions.multisample is not supported".to_string(),
            ));
        };

        let specialization = [
            (
                "VERSION",
                context.context_type().glsl_version().declaration().to_string(),
            ),
            ("PRECISION", String::new()),
            ("COORD_LAYOUT", coord_layout.to_string()),
            ("EXTENSION", extension.to_string()),
        ];

        let programs = [
            Self::make_program(gl, DEFAULT_SHADER_VERT, DEFAULT_SHADER_FRAG, &specialization)?,
            Self::make_program(gl, DEFAULT_SHADER_VERT, MULTISAMPLE_SHADER_FRAG, &specialization)?,
        ];

        let mut ref_colors = REF_COLORS_MULTISAMPLE;
        let mut ret = true;
        let mut params = TestParams {
            index: 0,
            use_fbo: true,
            use_multisample: true,
            use_cull: false,
            scissor_test: false,
            gather_samples: true,
            override_check_index: None,
        };

        for (s, program) in programs.iter().enumerate() {
            params.index = s;
            ret &= Self::do_quad_case(context, program, &params, &mut ref_colors)?;

            log::info!("Case {s} result {}\n----------", u8::from(ret));

            // switch to compare mode after first pass
            if params.gather_samples {
                params.gather_samples = false;
                params.override_check_index = Some(s);
            }
        }

        if ret {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Fail"))
        }
    }
}
