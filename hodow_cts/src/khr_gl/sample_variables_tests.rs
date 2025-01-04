// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcSampleVariablesTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. This is the Khronos copy, a different implementation from `gles31::functional::sample_variable_tests` (it renders one quad and resolves the samples into a wide renderbuffer). The `verification` group exists only for GLSL ES 3.10 and is added only then; `${OES_SV_RQ}` and `${OES_SV_EN}` are the extension lines upstream sets for GLSL ES 3.10 and are empty otherwise. The read-back goes through plain `glReadPixels` in the four formats instead of `tcu::TextureLevel`, whose integer channel types are not writable here; upstream reads the integer formats that way too. Sample masks are drawn from `Random::new(0)`, upstream's default base seed.

use std::collections::BTreeSet;

use crate::glu::{self, Context, GlslVersion, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, pr, va};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{Random, StringTemplate, TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const SAMPLE_MASKS: usize = 8;

const QUAD_INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];
const POSITION: [f32; 8] = [-1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0];

/// `specializeVersion`
fn specialize_version(source: &str, version: GlslVersion, sampler: &str, out_type: &str) -> Result<String, TestError> {
    StringTemplate::new(source).specialize(&[
        ("VERSION_DECL", version.declaration().to_string()),
        ("SAMPLER", sampler.to_string()),
        ("OUT_TYPE", out_type.to_string()),
        (
            "OES_SV_RQ",
            if matches!(version, GlslVersion::Es310) {
                "#extension GL_OES_sample_variables : require\n".to_string()
            } else {
                String::new()
            },
        ),
        (
            "OES_SV_EN",
            if matches!(version, GlslVersion::Es310) {
                "#extension GL_OES_sample_variables : enable\n".to_string()
            } else {
                String::new()
            },
        ),
    ])
}

fn build_program<'gl>(
    gl: &'gl glw::Functions,
    vss: &str,
    fss: &str,
    version: GlslVersion,
    sampler: &str,
    out_type: &str,
) -> Result<ShaderProgram<'gl>, TestError> {
    let program = ShaderProgram::new(
        gl,
        &ProgramSources::vtx_frag(
            specialize_version(vss, version, sampler, out_type)?,
            specialize_version(fss, version, sampler, out_type)?,
        ),
    );
    if !program.is_ok() {
        log::warn!("{}", program.build_failure_summary().unwrap_or_default());
        return Err(TestError::Fail("Compile failed".to_string()));
    }
    Ok(program)
}

const RESOLVE_VSS: &str =
    "${VERSION_DECL}\nin highp vec2 a_position;\nvoid main(void)\n{\n   gl_Position = vec4(a_position, 0.0, 1.0);\n}\n";

fn resolve_fss(vec4_only: bool) -> &'static str {
    if vec4_only {
        "${VERSION_DECL}\nuniform highp sampler2D u_tex;\nuniform highp sampler2DMS u_texMS;\nuniform int u_samples;\nlayout(location = 0) out highp vec4 o_color;\nvoid main(void)\n{\n    if (u_samples > 0) {\n        ivec2 coord = ivec2(int(gl_FragCoord.x) / u_samples, gl_FragCoord.y);\n        int sampleId = int(gl_FragCoord.x) % u_samples;\n        o_color = texelFetch(u_texMS, coord, sampleId);\n    } else {\n        ivec2 coord = ivec2(gl_FragCoord.x, gl_FragCoord.y);\n        o_color = texelFetch(u_tex, coord, 0);\n    }\n}\n"
    } else {
        "${VERSION_DECL}\nuniform highp ${SAMPLER} u_tex;\nuniform highp ${SAMPLER}MS u_texMS;\nuniform int u_samples;\nlayout(location = 0) out highp ${OUT_TYPE} o_color;\nvoid main(void)\n{\n    if (u_samples > 0) {\n        ivec2 coord = ivec2(int(gl_FragCoord.x) / u_samples, gl_FragCoord.y);\n        int sampleId = int(gl_FragCoord.x) % u_samples;\n        o_color = texelFetch(u_texMS, coord, sampleId);\n    } else {\n        ivec2 coord = ivec2(gl_FragCoord.x, gl_FragCoord.y);\n       o_color = texelFetch(u_tex, coord, 0);\n    }\n}\n"
    }
}

/// Binds the sampler units for the resolve pass and draws the quad.
fn draw_resolve(context: &Context, program: &ShaderProgram<'_>, samples: GLint) -> Result<(), TestError> {
    let gl = context.gl();
    let program_id = program.program();

    gl_call!(gl, "useProgram", gl.use_program(program_id));
    let uniform = |name: &std::ffi::CStr| -> GLint {
        // SAFETY: a NUL-terminated name and the program in use.
        unsafe { gl.get_uniform_location(program_id, name.as_ptr()) }
    };
    gl_call!(gl, "uniform", gl.uniform_1i(uniform(c"u_samples"), samples));
    if samples > 0 {
        // only MS sampler needed, TU 1 is not used
        gl_call!(gl, "uniform", gl.uniform_1i(uniform(c"u_tex"), 1));
        gl_call!(gl, "uniform", gl.uniform_1i(uniform(c"u_texMS"), 0));
    } else {
        // only non-MS sampler needed, TU 1 is not used
        gl_call!(gl, "uniform", gl.uniform_1i(uniform(c"u_tex"), 0));
        gl_call!(gl, "uniform", gl.uniform_1i(uniform(c"u_texMS"), 1));
    }

    let vertex_arrays = [va::float("a_position", 2, 4, 0, &POSITION)];
    glu::draw(
        &context.render_context,
        program_id,
        &vertex_arrays,
        &pr::triangle_strip(&QUAD_INDICES),
    )?;
    glu::expect_no_error(gl, "Draw quad")
}

#[derive(Clone, Copy, PartialEq)]
pub(super) enum TexKind {
    Unorm8,
    Signed8,
    Unsigned8,
    Float32,
}

/// `SampleShadingMaskCase`
struct SampleShadingMaskCase {
    case_name: String,
    glsl_version: GlslVersion,
    internal_format: GLenum,
    tex_kind: TexKind,
    sampler: &'static str,
    out_type: &'static str,
    samples: GLint,
    sample_mask: u32,
}

const MASK_WIDTH: i32 = 16;
const MASK_HEIGHT: i32 = 16;

/// The texels of the bound framebuffer as floats (`tcu::Vec4`), `width * height` of them.
pub(super) fn read_back(
    gl: &glw::Functions,
    tex_kind: TexKind,
    width: i32,
    height: i32,
) -> Result<Vec<[f32; 4]>, TestError> {
    let count = (width * height) as usize;
    match tex_kind {
        TexKind::Signed8 => {
            let mut data = vec![0 as GLint; count * 4];
            gl_call!(
                gl,
                "glReadPixels",
                gl.read_pixels(
                    0,
                    0,
                    width,
                    height,
                    glw::GL_RGBA_INTEGER,
                    glw::GL_INT,
                    data.as_mut_ptr().cast()
                )
            );
            Ok(data
                .chunks_exact(4)
                .map(|texel| [texel[0] as f32, texel[1] as f32, texel[2] as f32, texel[3] as f32])
                .collect())
        }
        TexKind::Unsigned8 => {
            let mut data = vec![0 as GLuint; count * 4];
            gl_call!(
                gl,
                "glReadPixels",
                gl.read_pixels(
                    0,
                    0,
                    width,
                    height,
                    glw::GL_RGBA_INTEGER,
                    glw::GL_UNSIGNED_INT,
                    data.as_mut_ptr().cast()
                )
            );
            Ok(data
                .chunks_exact(4)
                .map(|texel| [texel[0] as f32, texel[1] as f32, texel[2] as f32, texel[3] as f32])
                .collect())
        }
        TexKind::Unorm8 => {
            let mut data = vec![0u8; count * 4];
            gl_call!(
                gl,
                "glReadPixels",
                gl.read_pixels(
                    0,
                    0,
                    width,
                    height,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    data.as_mut_ptr().cast()
                )
            );
            Ok(data
                .chunks_exact(4)
                .map(|texel| {
                    [
                        f32::from(texel[0]) / 255.0,
                        f32::from(texel[1]) / 255.0,
                        f32::from(texel[2]) / 255.0,
                        f32::from(texel[3]) / 255.0,
                    ]
                })
                .collect())
        }
        TexKind::Float32 => {
            let mut data = vec![0f32; count * 4];
            gl_call!(
                gl,
                "glReadPixels",
                gl.read_pixels(
                    0,
                    0,
                    width,
                    height,
                    glw::GL_RGBA,
                    glw::GL_FLOAT,
                    data.as_mut_ptr().cast()
                )
            );
            Ok(data
                .chunks_exact(4)
                .map(|texel| [texel[0], texel[1], texel[2], texel[3]])
                .collect())
        }
    }
}

/// The sample-count part of both Khronos copies' `iterate` (the multisample texture's format decides which limit applies).
pub(super) fn check_max_samples(
    gl: &glw::Functions,
    tex_kind: TexKind,
    internal_format: GLenum,
    samples: GLint,
) -> Result<(), TestError> {
    let mut max_samples: GLint = 0;
    if tex_kind == TexKind::Float32 {
        // SAFETY: a plain query, one integer.
        unsafe {
            gl.get_internalformativ(
                glw::GL_TEXTURE_2D_MULTISAMPLE,
                internal_format,
                glw::GL_SAMPLES,
                1,
                &mut max_samples,
            )
        };
        if samples > max_samples {
            return Err(TestError::NotSupported(
                "Test sample count greater than samples that the format supports".to_string(),
            ));
        }
    } else if matches!(tex_kind, TexKind::Signed8 | TexKind::Unsigned8) {
        // SAFETY: a plain query, one integer.
        unsafe { gl.get_integerv(glw::GL_MAX_INTEGER_SAMPLES, &mut max_samples) };
        if samples > max_samples {
            return Err(TestError::NotSupported(
                "Test sample count greater than MAX_INTEGER_SAMPLES".to_string(),
            ));
        }
    } else {
        // SAFETY: a plain query, one integer.
        unsafe { gl.get_integerv(glw::GL_MAX_SAMPLES, &mut max_samples) };
        if samples > max_samples {
            return Err(TestError::NotSupported(
                "Test sample count greater than MAX_SAMPLES".to_string(),
            ));
        }
    }
    Ok(())
}

impl TestCase for SampleShadingMaskCase {
    fn name(&self) -> &str {
        &self.case_name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        // The desktop contexts are core profiles, so rgba32f is always renderable.
        check_max_samples(context.gl(), self.tex_kind, self.internal_format, self.samples)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut is_ok = true;

        // Create a multisample texture, or a regular texture if samples is zero.
        let mut tex: GLuint = 0;
        gl_call!(gl, "glGenTextures", gl.gen_textures(1, &mut tex));
        let target;
        if self.samples != 0 {
            target = glw::GL_TEXTURE_2D_MULTISAMPLE;
            gl_call!(gl, "glBindTexture", gl.bind_texture(target, tex));
            gl_call!(
                gl,
                "glTexStorage2DMultisample",
                gl.tex_storage_2d_multisample(
                    glw::GL_TEXTURE_2D_MULTISAMPLE,
                    self.samples,
                    self.internal_format,
                    MASK_WIDTH,
                    MASK_HEIGHT,
                    glw::FALSE
                )
            );
        } else {
            target = glw::GL_TEXTURE_2D;
            gl_call!(gl, "glBindTexture", gl.bind_texture(target, tex));
            gl_call!(
                gl,
                "glTexStorage2D",
                gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, self.internal_format, MASK_WIDTH, MASK_HEIGHT)
            );
            if matches!(self.tex_kind, TexKind::Signed8 | TexKind::Unsigned8 | TexKind::Float32) {
                gl_call!(
                    gl,
                    "glTexParameteri",
                    gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32)
                );
                gl_call!(
                    gl,
                    "glTexParameteri",
                    gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32)
                );
            }
        }

        // Create a framebuffer with the texture attached and clear to "green".
        let mut fbo_ms: GLuint = 0;
        gl_call!(gl, "glGenFramebuffers", gl.gen_framebuffers(1, &mut fbo_ms));
        gl_call!(
            gl,
            "glBindFramebuffer",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_ms)
        );
        gl_call!(
            gl,
            "glFramebufferTexture2D",
            gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, target, tex, 0)
        );
        gl_call!(gl, "glViewport", gl.viewport(0, 0, MASK_WIDTH, MASK_HEIGHT));
        match self.tex_kind {
            TexKind::Signed8 => {
                let color: [GLint; 4] = [0, 1, 0, 1];
                gl_call!(
                    gl,
                    "glClearBufferiv",
                    gl.clear_bufferiv(glw::GL_COLOR, 0, color.as_ptr())
                );
            }
            TexKind::Unsigned8 => {
                let color: [GLuint; 4] = [0, 1, 0, 1];
                gl_call!(
                    gl,
                    "glClearBufferuiv",
                    gl.clear_bufferuiv(glw::GL_COLOR, 0, color.as_ptr())
                );
            }
            _ => {
                let color: [f32; 4] = [0.0, 1.0, 0.0, 1.0];
                gl_call!(
                    gl,
                    "glClearBufferfv",
                    gl.clear_bufferfv(glw::GL_COLOR, 0, color.as_ptr())
                );
            }
        }

        {
            // Draw a quad setting all samples to "red". We only expect "red" to be written if the sample mask bit for that sample is 1.
            const VSS: &str = "${VERSION_DECL}\nin highp vec2 a_position;\nvoid main()\n{\n   gl_Position = vec4(a_position, 0.0, 1.0);\n}\n";
            const FSS: &str = "${VERSION_DECL}\n${OES_SV_RQ}layout(location = 0) out highp ${OUT_TYPE} o_color;\nuniform int u_sampleMask;\nvoid main()\n{\n    for (int i = 0; i < (gl_NumSamples + 31) / 32; ++i) {\n        gl_SampleMask[i] = u_sampleMask & gl_SampleMaskIn[i];\n    }\n    o_color = ${OUT_TYPE}(1, 0, 0, 1);\n}\n";

            let program = build_program(gl, VSS, FSS, self.glsl_version, self.sampler, self.out_type)?;

            gl_call!(gl, "useProgram", gl.use_program(program.program()));
            // SAFETY: a NUL-terminated name and the program in use.
            let location = unsafe { gl.get_uniform_location(program.program(), c"u_sampleMask".as_ptr()) };
            gl_call!(gl, "uniform", gl.uniform_1i(location, self.sample_mask as GLint));

            let vertex_arrays = [va::float("a_position", 2, 4, 0, &POSITION)];
            glu::draw(
                &context.render_context,
                program.program(),
                &vertex_arrays,
                &pr::triangle_strip(&QUAD_INDICES),
            )?;
            glu::expect_no_error(gl, "Draw quad")?;
        }

        gl_call!(gl, "glBindFramebuffer", gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
        gl_call!(gl, "glDeleteFramebuffers", gl.delete_framebuffers(1, &fbo_ms));

        let width = MASK_WIDTH * if self.samples != 0 { self.samples } else { 1 };

        let mut rbo: GLuint = 0;
        gl_call!(gl, "glGenRenderbuffers", gl.gen_renderbuffers(1, &mut rbo));
        gl_call!(
            gl,
            "glBindRenderbuffer",
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo)
        );
        gl_call!(
            gl,
            "glRenderbufferStorage",
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, self.internal_format, width, MASK_HEIGHT)
        );

        let mut fbo: GLuint = 0;
        gl_call!(gl, "glGenFramebuffers", gl.gen_framebuffers(1, &mut fbo));
        gl_call!(gl, "glBindFramebuffer", gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo));
        gl_call!(
            gl,
            "glFramebufferRenderbuffer",
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                rbo
            )
        );
        gl_call!(gl, "glViewport", gl.viewport(0, 0, width, MASK_HEIGHT));

        {
            // Resolve the multi-sample texture into a render-buffer sized such that the width can hold all samples of a pixel.
            let program = build_program(
                gl,
                RESOLVE_VSS,
                resolve_fss(false),
                self.glsl_version,
                self.sampler,
                self.out_type,
            )?;
            draw_resolve(context, &program, self.samples)?;
        }

        let result = read_back(gl, self.tex_kind, width, MASK_HEIGHT)?;

        for y in 0..MASK_HEIGHT {
            for x in 0..MASK_WIDTH {
                let samples = if self.samples != 0 { self.samples } else { 1 };
                for sample in 0..samples {
                    let pixel = if matches!(self.tex_kind, TexKind::Signed8 | TexKind::Unsigned8) {
                        // upstream indexes the integer read-back this way, `y * WIDTH + x * samples + sample`
                        result[(y * MASK_WIDTH + x * samples + sample) as usize]
                    } else {
                        result[(y * width + x * samples + sample) as usize]
                    };

                    // Make sure only those samples where the sample mask bit is non-zero have the "red" pixel values.
                    if self.samples == 0 || (self.sample_mask & (1 << sample)) != 0 {
                        if pixel != [1.0, 0.0, 0.0, 1.0] {
                            is_ok = false;
                        }
                    } else if pixel != [0.0, 1.0, 0.0, 1.0] {
                        is_ok = false;
                    }
                }
            }
        }

        // SAFETY: the objects created above, each deleted once.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            gl.delete_framebuffers(1, &fbo);
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
            gl.delete_renderbuffers(1, &rbo);
            gl.bind_texture(target, 0);
            gl.delete_textures(1, &tex);
        }

        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `SampleShadingPositionCase`
struct SampleShadingPositionCase {
    case_name: &'static str,
    glsl_version: GlslVersion,
    samples: GLint,
    fixed_sample_locations: bool,
}

const POSITION_WIDTH: i32 = 8;
const POSITION_HEIGHT: i32 = 8;

/// The ordering key of upstream's `operator<(Vec4, Vec4)`: only y and x take part, so two texels with the same y and x are one element of a `std::set`.
fn position_key(pixel: [f32; 4]) -> (u32, u32) {
    (pixel[1].to_bits(), pixel[0].to_bits())
}

impl TestCase for SampleShadingPositionCase {
    fn name(&self) -> &str {
        self.case_name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let mut max_samples: GLint = 0;
        // SAFETY: a plain query, one integer.
        unsafe { context.gl().get_integerv(glw::GL_MAX_SAMPLES, &mut max_samples) };
        if self.samples > max_samples {
            return Err(TestError::NotSupported(
                "Test sample count great than MAX_SAMPLES".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut is_ok = true;

        // Create a multisample texture, or a regular texture if samples is zero.
        let mut tex: GLuint = 0;
        gl_call!(gl, "glGenTextures", gl.gen_textures(1, &mut tex));
        let target;
        if self.samples != 0 {
            target = glw::GL_TEXTURE_2D_MULTISAMPLE;
            gl_call!(gl, "glBindTexture", gl.bind_texture(target, tex));
            gl_call!(
                gl,
                "glTexStorage2DMultisample",
                gl.tex_storage_2d_multisample(
                    glw::GL_TEXTURE_2D_MULTISAMPLE,
                    self.samples,
                    glw::GL_RGBA8,
                    POSITION_WIDTH,
                    POSITION_HEIGHT,
                    if self.fixed_sample_locations {
                        glw::TRUE
                    } else {
                        glw::FALSE
                    }
                )
            );
        } else {
            target = glw::GL_TEXTURE_2D;
            gl_call!(gl, "glBindTexture", gl.bind_texture(target, tex));
            gl_call!(
                gl,
                "glTexStorage2D",
                gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, POSITION_WIDTH, POSITION_HEIGHT)
            );
        }

        // Attach the texture to the framebuffer to render to it.
        let mut fbo_ms: GLuint = 0;
        gl_call!(gl, "glGenFramebuffers", gl.gen_framebuffers(1, &mut fbo_ms));
        gl_call!(
            gl,
            "glBindFramebuffer",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_ms)
        );
        gl_call!(
            gl,
            "glFramebufferTexture2D",
            gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, target, tex, 0)
        );
        gl_call!(gl, "glViewport", gl.viewport(0, 0, POSITION_WIDTH, POSITION_HEIGHT));

        // Save all the sample positions for this multisample framebuffer.
        let mut sample_positions: Vec<[f32; 4]> = Vec::new();
        if self.samples != 0 {
            for sample in 0..self.samples {
                let mut position = [0f32; 2];
                // SAFETY: two floats are written for GL_SAMPLE_POSITION.
                unsafe { gl.get_multisamplefv(glw::GL_SAMPLE_POSITION, sample as GLuint, position.as_mut_ptr()) };
                sample_positions.push([position[0], position[1], 0.0, 1.0]);
            }
        }

        {
            // Render all the sample positions to each pixel sample.
            const VSS: &str = "${VERSION_DECL}\nin highp vec2 a_position;\nvoid main()\n{\n   gl_Position = vec4(a_position, 0.0, 1.0);\n}\n";
            const FSS: &str = "${VERSION_DECL}\n${OES_SV_RQ}layout(location = 0) out highp vec4 o_color;\nvoid main()\n{\n    o_color = vec4(gl_SamplePosition, 0, 1);\n}\n";

            let program = build_program(gl, VSS, FSS, self.glsl_version, "", "")?;
            gl_call!(gl, "useProgram", gl.use_program(program.program()));

            let vertex_arrays = [va::float("a_position", 2, 4, 0, &POSITION)];
            glu::draw(
                &context.render_context,
                program.program(),
                &vertex_arrays,
                &pr::triangle_strip(&QUAD_INDICES),
            )?;
            glu::expect_no_error(gl, "Draw quad")?;
        }

        gl_call!(gl, "glBindFramebuffer", gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
        gl_call!(gl, "glDeleteFramebuffers", gl.delete_framebuffers(1, &fbo_ms));

        // Create a regular non-multisample render buffer to resolve to multisample texture into. The width is increased to save all samples of the pixel.
        let width = POSITION_WIDTH * if self.samples != 0 { self.samples } else { 1 };

        let mut rbo: GLuint = 0;
        gl_call!(gl, "glGenRenderbuffers", gl.gen_renderbuffers(1, &mut rbo));
        gl_call!(
            gl,
            "glBindRenderbuffer",
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo)
        );
        gl_call!(
            gl,
            "glRenderbufferStorage",
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, width, POSITION_HEIGHT)
        );

        let mut fbo: GLuint = 0;
        gl_call!(gl, "glGenFramebuffers", gl.gen_framebuffers(1, &mut fbo));
        gl_call!(gl, "glBindFramebuffer", gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo));
        gl_call!(
            gl,
            "glFramebufferRenderbuffer",
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                rbo
            )
        );
        gl_call!(gl, "glViewport", gl.viewport(0, 0, width, POSITION_HEIGHT));

        {
            // Resolve the multisample texture to the renderbuffer.
            let program = build_program(gl, RESOLVE_VSS, resolve_fss(true), self.glsl_version, "", "")?;
            draw_resolve(context, &program, self.samples)?;
        }

        // Read the renderbuffer pixels and verify we get back what we're expecting.
        let mut bytes = vec![0u8; (width * POSITION_HEIGHT * 4) as usize];
        gl_call!(
            gl,
            "glReadPixels",
            gl.read_pixels(
                0,
                0,
                width,
                POSITION_HEIGHT,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                bytes.as_mut_ptr().cast()
            )
        );
        let pixel_at = |x: i32, y: i32| -> [f32; 4] {
            let offset = ((y * width + x) * 4) as usize;
            [
                f32::from(bytes[offset]) / 255.0,
                f32::from(bytes[offset + 1]) / 255.0,
                f32::from(bytes[offset + 2]) / 255.0,
                f32::from(bytes[offset + 3]) / 255.0,
            ]
        };

        if self.samples != 0 {
            // If m_fixedSampleLocations are used make sure the first pixel's samples all match the SAMPLE_POSITION state saved earlier.
            let mut fixed_sample_locations: BTreeSet<(u32, u32)> = BTreeSet::new();
            if self.fixed_sample_locations {
                for sample in 0..self.samples {
                    let pixel = pixel_at(sample, 0);
                    fixed_sample_locations.insert(position_key(pixel));
                    if (pixel[0] - sample_positions[sample as usize][0]).abs() > 0.01
                        || (pixel[1] - sample_positions[sample as usize][1]).abs() > 0.01
                    {
                        is_ok = false;
                    }
                }
            }

            // Verify all samples of every pixel to make sure each position is unique.
            for y in 0..POSITION_HEIGHT {
                for x in 0..POSITION_WIDTH {
                    let mut unique_pixels: BTreeSet<(u32, u32)> = BTreeSet::new();
                    for sample in 0..self.samples {
                        unique_pixels.insert(position_key(pixel_at(x * self.samples + sample, y)));
                    }
                    if unique_pixels.len() as GLint != self.samples {
                        is_ok = false;
                    }
                    // For the m_fixedSampleLocations case make sure each position matches the sample positions of pixel(0, 0) saved earlier.
                    if self.fixed_sample_locations && fixed_sample_locations != unique_pixels {
                        is_ok = false;
                    }
                }
            }
        } else {
            // For the non-multisample case make sure all the positions are (0.5,0.5).
            for y in 0..POSITION_HEIGHT {
                for x in 0..width {
                    let pixel = pixel_at(x, y);
                    if (pixel[0] - 0.5).abs() > 0.01
                        || (pixel[1] - 0.5).abs() > 0.01
                        || pixel[2] != 0.0
                        || pixel[3] != 1.0
                    {
                        is_ok = false;
                    }
                }
            }
        }

        // SAFETY: the objects created above, each deleted once.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            gl.delete_framebuffers(1, &fbo);
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
            gl.delete_renderbuffers(1, &rbo);
            gl.bind_texture(target, 0);
            gl.delete_textures(1, &tex);
        }

        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `SampleShadingExtensionCase`
struct SampleShadingExtensionCase {
    glsl_version: GlslVersion,
}

impl TestCase for SampleShadingExtensionCase {
    fn name(&self) -> &str {
        "extension"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let is_at_least_gl_45 = context.context_type().supports_core(4, 5);
        let is_arb_es31_compatibility = context
            .context_info
            .is_extension_supported("GL_ARB_ES3_1_compatibility");
        let is_oes_sample_variables = context.context_info.is_extension_supported("GL_OES_sample_variables");
        if !(is_at_least_gl_45 || is_arb_es31_compatibility || is_oes_sample_variables) {
            return Err(TestError::NotSupported(
                "GL_ARB_ES3_1_compatibility or GL_OES_sample_variables".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let vss = "${VERSION_DECL}\nin highp vec4 a_position;\nvoid main()\n{\n    gl_Position = a_position;\n}\n";
        let fss_require = "${VERSION_DECL}\n${OES_SV_RQ}out highp vec4 o_color;\nvoid main()\n{\n    for (int i = 0; i < (gl_MaxSamples + 31) / 32; ++i) {\n        gl_SampleMask[i] = gl_SampleMaskIn[i];\n    }\n    o_color = vec4(gl_SampleID, gl_SamplePosition.x, gl_SamplePosition.y, 1);\n}\n";
        let fss_enable = "${VERSION_DECL}\n${OES_SV_EN}out highp vec4 o_color;\nvoid main()\n{\n#if !GL_OES_sample_variables\n    this is broken\n#endif\n    for (int i = 0; i < (gl_MaxSamples + 31) / 32; ++i) {\n        gl_SampleMask[i] = gl_SampleMaskIn[i];\n    }\n    o_color = vec4(gl_SampleID, gl_SamplePosition.x, gl_SamplePosition.y, 1);\n}\n";

        let _program_require = build_program(gl, vss, fss_require, self.glsl_version, "", "")?;
        let _program_enable = build_program(gl, vss, fss_enable, self.glsl_version, "", "")?;
        Ok(TestStatus::pass("Pass"))
    }
}

/// `SampleVariablesTests::init`
pub fn create_tests(glsl_version: GlslVersion) -> TestCaseGroup {
    let mut rnd = Random::new(0);
    let mut group = TestCaseGroup::new("sample_variables");

    // sample_variables.extension
    if matches!(glsl_version, GlslVersion::Es310) {
        let mut extension_case_group = TestCaseGroup::new("verification");
        extension_case_group.add_child(Box::new(SampleShadingExtensionCase { glsl_version }) as Box<dyn TestCase>);
        group.add_child(extension_case_group);
    }

    let samples: [(&str, GLint); 5] = [
        ("samples_0", 0),
        ("samples_1", 1),
        ("samples_2", 2),
        ("samples_4", 4),
        ("samples_8", 8),
    ];

    // sample_variables.mask
    let mut mask_group = TestCaseGroup::new("mask");
    let formats: [(&str, GLenum, TexKind, &'static str, &'static str); 4] = [
        ("rgba8", glw::GL_RGBA8, TexKind::Unorm8, "sampler2D", "vec4"),
        ("rgba8i", glw::GL_RGBA8I, TexKind::Signed8, "isampler2D", "ivec4"),
        ("rgba8ui", glw::GL_RGBA8UI, TexKind::Unsigned8, "usampler2D", "uvec4"),
        ("rgba32f", glw::GL_RGBA32F, TexKind::Float32, "sampler2D", "vec4"),
    ];
    for (format_name, internal_format, tex_kind, sampler, out_type) in formats {
        let mut mask_format_group = TestCaseGroup::new(format_name);

        for (sample_name, sample_count) in samples {
            let mut mask_format_sample_group = TestCaseGroup::new(sample_name);

            let case = |name: String, sample_mask: u32| -> Box<dyn TestCase> {
                Box::new(SampleShadingMaskCase {
                    case_name: name,
                    glsl_version,
                    internal_format,
                    tex_kind,
                    sampler,
                    out_type,
                    samples: sample_count,
                    sample_mask,
                })
            };

            mask_format_sample_group.add_child(case("mask_zero".to_string(), 0));
            for mask in 0..SAMPLE_MASKS {
                mask_format_sample_group.add_child(case(format!("mask_{mask}"), rnd.get_uint32()));
            }

            mask_format_group.add_child(mask_format_sample_group);
        }

        mask_group.add_child(mask_format_group);
    }
    group.add_child(mask_group);

    // sample_variables.position
    let mut position_group = TestCaseGroup::new("position");
    for (fixed_name, fixed_sample_locations) in [("non-fixed", false), ("fixed", true)] {
        let mut position_fixed_group = TestCaseGroup::new(fixed_name);
        for (sample_name, sample_count) in samples {
            position_fixed_group.add_child(Box::new(SampleShadingPositionCase {
                case_name: sample_name,
                glsl_version,
                samples: sample_count,
                fixed_sample_locations,
            }) as Box<dyn TestCase>);
        }
        position_group.add_child(position_fixed_group);
    }
    group.add_child(position_group);

    group
}
