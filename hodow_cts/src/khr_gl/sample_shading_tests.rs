// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gles31/es31cSampleShadingTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the desktop half is ported (GLSL 4.00 and up): the `GL_OES_sample_shading` and `GL_EXT_color_buffer_float` checks upstream makes for ES 3.10 are not reachable. The multisample-format probe of the float formats lives in `check_support`, as it precedes every resource in upstream's `iterate`. The read-back reuses the one of the sample-variables port. Upstream's `operator<(Vec4, Vec4)` looks at y and x only, so the unique-pixel count keys on those two.

use std::collections::BTreeSet;

use super::sample_variables_tests::{TexKind, read_back};
use crate::glu::{self, Context, GlslVersion, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, pr, va};
use crate::glw::{self, GLenum, GLfloat, GLint, GLuint};
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const WIDTH: i32 = 16;
const HEIGHT: i32 = 16;
const MAX_SAMPLES: GLint = 4;

const QUAD_INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];
const POSITION: [f32; 8] = [-1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0];

/// `specializeVersion`
fn specialize_version(source: &str, version: GlslVersion, sampler: &str, out_type: &str) -> Result<String, TestError> {
    StringTemplate::new(source).specialize(&[
        ("VERSION_DECL", version.declaration().to_string()),
        ("SAMPLER", sampler.to_string()),
        ("OUT_TYPE", out_type.to_string()),
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

/// `SampleShadingApiCaseGroup::SampleShadingApiCase`
struct SampleShadingApiCase;

impl TestCase for SampleShadingApiCase {
    fn name(&self) -> &str {
        "verify"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut is_ok = true;

        let tests: [(GLfloat, GLfloat); 4] = [(0.0, 0.0), (0.5, 0.5), (-1.0, 0.0), (2.0, 1.0)];
        for (input, expected) in tests {
            // SAFETY: a plain state call and a one-float query.
            let result = unsafe {
                gl.min_sample_shading(input);
                let mut result: GLfloat = -1.0;
                gl.get_floatv(glw::GL_MIN_SAMPLE_SHADING_VALUE, &mut result);
                result
            };
            if result != expected {
                is_ok = false;
            }
        }

        // SAFETY: plain state calls.
        unsafe {
            gl.enable(glw::GL_SAMPLE_SHADING);
            if gl.is_enabled(glw::GL_SAMPLE_SHADING) == glw::FALSE {
                is_ok = false;
            }
            gl.disable(glw::GL_SAMPLE_SHADING);
            if gl.is_enabled(glw::GL_SAMPLE_SHADING) != glw::FALSE {
                is_ok = false;
            }

            gl.min_sample_shading(0.0);
        }

        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `SampleShadingRenderCase`
struct SampleShadingRenderCase {
    name: &'static str,
    glsl_version: GlslVersion,
    internal_format: GLenum,
    tex_kind: TexKind,
    sampler: &'static str,
    out_type: &'static str,
    min: GLfloat,
    max: GLfloat,
    sample_shading: GLfloat,
}

impl SampleShadingRenderCase {
    /// The `maxSamples` of upstream's `iterate`, `None` meaning the format has no multisample support (a NotSupported).
    fn max_samples(&self, gl: &glw::Functions) -> Option<GLint> {
        let mut max_samples: GLint = 0;
        if self.tex_kind == TexKind::Float32 {
            // SAFETY: a plain query, one integer.
            unsafe {
                gl.get_internalformativ(
                    glw::GL_TEXTURE_2D_MULTISAMPLE,
                    self.internal_format,
                    glw::GL_SAMPLES,
                    1,
                    &mut max_samples,
                )
            };
            if max_samples == 0 {
                return None;
            }
        } else if matches!(self.tex_kind, TexKind::Signed8 | TexKind::Unsigned8) {
            // SAFETY: a plain query, one integer.
            unsafe { gl.get_integerv(glw::GL_MAX_INTEGER_SAMPLES, &mut max_samples) };
        } else {
            // SAFETY: a plain query, one integer.
            unsafe { gl.get_integerv(glw::GL_MAX_SAMPLES, &mut max_samples) };
        }
        Some(max_samples)
    }
}

/// `countUniquePixels`
fn count_unique_pixels(pixels: &[[f32; 4]]) -> usize {
    // Adding 0.0 turns -0.0 into 0.0, so that the bit patterns compare as the values do.
    let unique: BTreeSet<(u32, u32)> = pixels
        .iter()
        .map(|pixel| ((pixel[1] + 0.0).to_bits(), (pixel[0] + 0.0).to_bits()))
        .collect();
    unique.len()
}

impl TestCase for SampleShadingRenderCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if self.max_samples(context.gl()).is_none() {
            return Err(TestError::NotSupported(
                "Multisample is not supported on this format".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut is_ok = true;

        let max_samples = self.max_samples(gl).unwrap_or(0);
        let samples = max_samples.min(MAX_SAMPLES);

        let mut tex: GLuint = 0;
        gl_call!(gl, "glGenTextures", gl.gen_textures(1, &mut tex));
        gl_call!(
            gl,
            "glBindTexture",
            gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, tex)
        );
        gl_call!(
            gl,
            "glTexStorage2DMultisample",
            gl.tex_storage_2d_multisample(
                glw::GL_TEXTURE_2D_MULTISAMPLE,
                samples,
                self.internal_format,
                WIDTH,
                HEIGHT,
                glw::FALSE
            )
        );

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
            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D_MULTISAMPLE,
                tex,
                0
            )
        );
        gl_call!(gl, "glViewport", gl.viewport(0, 0, WIDTH, HEIGHT));

        gl_call!(gl, "glMinSampleShading", gl.min_sample_shading(self.sample_shading));
        gl_call!(gl, "glEnable", gl.enable(glw::GL_SAMPLE_SHADING));

        {
            const VSS: &str = "${VERSION_DECL}\nin highp vec2 a_position;\nin highp vec4 a_color;\nout highp vec4 v_color;\nvoid main (void)\n{\n   gl_Position = vec4(a_position, 0.0, 1.0);\n   v_color = a_color;\n}\n";
            const FSS: &str = "${VERSION_DECL}\nin highp vec4 v_color;\nlayout(location = 0) out highp ${OUT_TYPE} o_color;\nvoid main (void)\n{\n   o_color = ${OUT_TYPE}(v_color.x, v_color.y, 0.0, 0.0);\n}\n";

            let program = build_program(gl, VSS, FSS, self.glsl_version, self.sampler, self.out_type)?;

            let color: [f32; 16] = [
                self.min, self.min, 0.0, 1.0, self.min, self.max, 0.0, 1.0, self.max, self.min, 0.0, 1.0, self.max,
                self.max, 0.0, 1.0,
            ];

            gl_call!(gl, "glUseProgram", gl.use_program(program.program()));

            let vertex_arrays = [
                va::float("a_position", 2, 4, 0, &POSITION),
                va::float("a_color", 4, 4, 0, &color),
            ];
            glu::draw(
                &context.render_context,
                program.program(),
                &vertex_arrays,
                &pr::triangle_strip(&QUAD_INDICES),
            )?;
            glu::expect_no_error(gl, "Draw quad")?;
        }
        gl_call!(gl, "glMinSampleShading", gl.min_sample_shading(0.0));
        gl_call!(gl, "glDisable", gl.disable(glw::GL_SAMPLE_SHADING));
        gl_call!(gl, "glBindFramebuffer", gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
        gl_call!(gl, "glDeleteFramebuffers", gl.delete_framebuffers(1, &fbo_ms));

        let width = WIDTH * samples;

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
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, self.internal_format, width, HEIGHT)
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
        gl_call!(gl, "glViewport", gl.viewport(0, 0, width, HEIGHT));

        {
            const VSS: &str = "${VERSION_DECL}\nin highp vec2 a_position;\nvoid main(void)\n{\n   gl_Position = vec4(a_position, 0.0, 1.0);\n}\n";
            const FSS: &str = "${VERSION_DECL}\nuniform highp ${SAMPLER} u_tex;\nuniform int u_samples;\nlayout(location = 0) out highp ${OUT_TYPE} o_color;\nvoid main(void)\n{\n   ivec2 coord = ivec2(int(gl_FragCoord.x) / u_samples, gl_FragCoord.y);\n   int sampleId = int(gl_FragCoord.x) % u_samples;\n   o_color = texelFetch(u_tex, coord, sampleId);\n}\n";

            let program = build_program(gl, VSS, FSS, self.glsl_version, self.sampler, self.out_type)?;
            let program_id = program.program();

            gl_call!(gl, "glUseProgram", gl.use_program(program_id));
            // SAFETY: NUL-terminated names and the program in use.
            let (samples_location, tex_location) = unsafe {
                (
                    gl.get_uniform_location(program_id, c"u_samples".as_ptr()),
                    gl.get_uniform_location(program_id, c"u_tex".as_ptr()),
                )
            };
            gl_call!(gl, "glUniform1i", gl.uniform_1i(samples_location, samples));
            gl_call!(gl, "glUniform1i", gl.uniform_1i(tex_location, 0));

            let vertex_arrays = [va::float("a_position", 2, 4, 0, &POSITION)];
            glu::draw(
                &context.render_context,
                program_id,
                &vertex_arrays,
                &pr::triangle_strip(&QUAD_INDICES),
            )?;
            glu::expect_no_error(gl, "Draw quad")?;
        }

        let result = read_back(gl, self.tex_kind, width, HEIGHT)?;
        let unique_pixels = count_unique_pixels(&result) as i32;

        let scaled = (samples as f32 * self.sample_shading) as i32;
        let expected_unique = WIDTH
            * HEIGHT
            * if scaled < 1 {
                1
            } else if scaled > samples {
                samples
            } else {
                scaled
            };
        if unique_pixels < expected_unique {
            is_ok = false;
        }

        // SAFETY: the objects created above, each deleted once.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            gl.delete_framebuffers(1, &fbo);

            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
            gl.delete_renderbuffers(1, &rbo);

            gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, 0);
            gl.delete_textures(1, &tex);
        }

        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `SampleShadingTests::init`
pub fn create_tests(glsl_version: GlslVersion) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("sample_shading");

    // sample_shading.api
    let mut api_group = TestCaseGroup::new("api");
    api_group.add_child(Box::new(SampleShadingApiCase) as Box<dyn TestCase>);
    group.add_child(api_group);

    // sample_shading.render
    let mut render_group = TestCaseGroup::new("render");
    let formats: [(&str, GLenum, TexKind, &'static str, &'static str, GLfloat, GLfloat); 4] = [
        ("rgba8", glw::GL_RGBA8, TexKind::Unorm8, "sampler2DMS", "vec4", 0.0, 1.0),
        (
            "rgba8i",
            glw::GL_RGBA8I,
            TexKind::Signed8,
            "isampler2DMS",
            "ivec4",
            -128.0,
            127.0,
        ),
        (
            "rgba8ui",
            glw::GL_RGBA8UI,
            TexKind::Unsigned8,
            "usampler2DMS",
            "uvec4",
            0.0,
            255.0,
        ),
        (
            "rgba32f",
            glw::GL_RGBA32F,
            TexKind::Float32,
            "sampler2DMS",
            "vec4",
            0.0,
            1.0,
        ),
    ];
    for (format_name, internal_format, tex_kind, sampler, out_type, min, max) in formats {
        let mut format_group = TestCaseGroup::new(format_name);
        for (name, sample_shading) in [("full", 1.0), ("half", 0.5), ("none", 0.0)] {
            format_group.add_child(Box::new(SampleShadingRenderCase {
                name,
                glsl_version,
                internal_format,
                tex_kind,
                sampler,
                out_type,
                min,
                max,
                sample_shading,
            }) as Box<dyn TestCase>);
        }
        render_group.add_child(format_group);
    }
    group.add_child(render_group);

    group
}
