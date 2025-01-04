// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcShaderMultisampleInterpolationTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The Khronos copy, which is not the ES test in `gles31::functional::shader_multisample_interpolation_tests` (that one runs on `MultisampleShaderRenderUtil`). The read-back and the sample-count check are shared with `sample_variables_tests`, which has the same code in upstream. The GLSL ES 3.10 branches are not carried over (desktop roots).

use std::collections::BTreeSet;

use super::sample_variables_tests::{TexKind, check_max_samples, read_back};
use crate::glu::{self, Context, GlslVersion, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, pr, va};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const WIDTH: i32 = 8;
const HEIGHT: i32 = 8;

const QUAD_INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];
const POSITION: [f32; 8] = [-1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0];

/// `specializeVersion`; the `OES_*` extension lines are empty on desktop GLSL.
fn specialize_version(
    source: &str,
    version: GlslVersion,
    sampler: &str,
    out_type: &str,
    qualifier: &str,
    assignment: &str,
    condition: &str,
) -> Result<String, TestError> {
    StringTemplate::new(source).specialize(&[
        ("VERSION_DECL", version.declaration().to_string()),
        ("SAMPLER", sampler.to_string()),
        ("OUT_TYPE", out_type.to_string()),
        ("QUALIFIER", qualifier.to_string()),
        ("ASSIGNMENT", assignment.to_string()),
        ("CONDITION", condition.to_string()),
        ("OES_SMI_EN", String::new()),
        ("OES_SMI_RQ", String::new()),
        ("OES_SMI_CH", String::new()),
        ("OES_SV_EN", String::new()),
    ])
}

/// The ordering key of upstream's `operator<(Vec4, Vec4)`: only y and x take part, so texels with the same y and x are one element of the `std::set` in `countUniquePixels`.
fn position_key(pixel: [f32; 4]) -> (u32, u32) {
    (pixel[1].to_bits(), pixel[0].to_bits())
}

/// `ShaderMultisampleInterpolationApiCase`
struct ShaderMultisampleInterpolationApiCase {
    glsl_version: GlslVersion,
}

impl TestCase for ShaderMultisampleInterpolationApiCase {
    fn name(&self) -> &str {
        "api"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut is_ok = true;

        const VSS: &str = "${VERSION_DECL}\n${OES_SMI_RQ}in highp vec4 a_position;\nin highp vec4 a_color;\nsample out highp vec4 v_color;\nvoid main()\n{\n    gl_Position = a_position;\n}\n";
        const FSS_REQUIRE: &str = "${VERSION_DECL}\n${OES_SMI_RQ}sample in highp vec4 v_color;\nout highp vec4 o_color;\nvoid main()\n{\n    o_color = v_color;\n}\n";
        const FSS_ENABLE: &str = "${VERSION_DECL}\n${OES_SMI_EN}sample in highp vec4 v_color;\nout highp vec4 o_color;\nvoid main()\n{\n${OES_SMI_CH}    o_color = v_color;\n}\n";

        for fss in [FSS_REQUIRE, FSS_ENABLE] {
            let program = ShaderProgram::new(
                gl,
                &ProgramSources::vtx_frag(
                    specialize_version(VSS, self.glsl_version, "", "", "", "", "")?,
                    specialize_version(fss, self.glsl_version, "", "", "", "", "")?,
                ),
            );
            if !program.is_ok() {
                log::warn!("{}", program.build_failure_summary().unwrap_or_default());
                return Err(TestError::Fail("Compile failed".to_string()));
            }
        }

        let mut min_fragment_interpolation_offset: f32 = 0.0;
        // SAFETY: a plain query, one float.
        unsafe {
            gl.get_floatv(
                glw::GL_MIN_FRAGMENT_INTERPOLATION_OFFSET,
                &mut min_fragment_interpolation_offset,
            )
        };
        if min_fragment_interpolation_offset > -0.5 {
            is_ok = false;
        }

        let mut fragment_interpolation_offset_bits: GLint = 0;
        // SAFETY: a plain query, one integer.
        unsafe {
            gl.get_integerv(
                glw::GL_FRAGMENT_INTERPOLATION_OFFSET_BITS,
                &mut fragment_interpolation_offset_bits,
            )
        };
        if fragment_interpolation_offset_bits < 4 {
            is_ok = false;
        }
        let ulp = 1.0 / 2.0f32.powf(fragment_interpolation_offset_bits as f32);

        let mut max_fragment_interpolation_offset: f32 = 0.0;
        // SAFETY: a plain query, one float.
        unsafe {
            gl.get_floatv(
                glw::GL_MAX_FRAGMENT_INTERPOLATION_OFFSET,
                &mut max_fragment_interpolation_offset,
            )
        };
        if max_fragment_interpolation_offset < 0.5 - ulp {
            is_ok = false;
        }

        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `ShaderMultisampleInterpolationBaseCase`
struct ShaderMultisampleInterpolationBaseCase {
    case_name: &'static str,
    glsl_version: GlslVersion,
    qualifier: &'static str,
    assignment: &'static str,
    condition: &'static str,
    unique: bool,
    internal_format: GLenum,
    tex_kind: TexKind,
    sampler: &'static str,
    out_type: &'static str,
    min: f32,
    max: f32,
    samples: GLint,
}

impl TestCase for ShaderMultisampleInterpolationBaseCase {
    fn name(&self) -> &str {
        self.case_name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        // The desktop contexts are core profiles, so rgba32f is always renderable.
        check_max_samples(context.gl(), self.tex_kind, self.internal_format, self.samples)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut is_ok = true;

        // Create a multisample texture.
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
                self.samples,
                self.internal_format,
                WIDTH,
                HEIGHT,
                glw::FALSE
            )
        );

        // Create a framebuffer with the texture attached.
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

        {
            // Draw with one of the fragment input qualifiers and with one of the interpolate functions. Cross-check the result in the shader and output the final interpolated value.
            const VSS: &str = "${VERSION_DECL}\n${OES_SMI_RQ}layout(location = 0) in highp vec2 a_position;\nlayout(location = 1) in highp vec4 a_color;\nout highp vec4 v_colorBase;\n${QUALIFIER} out highp vec4 v_color;\nvoid main()\n{\n    v_colorBase = a_color;\n    v_color = a_color;\n    gl_Position = vec4(a_position, 0.0, 1.0);\n}\n";
            const FSS: &str = "${VERSION_DECL}\n${OES_SMI_RQ}${OES_SV_EN}in highp vec4 v_colorBase;\n${QUALIFIER} in highp vec4 v_color;\nlayout(location = 0) out highp ${OUT_TYPE} o_color;\nvoid main()\n{\n    highp vec4 temp = ${ASSIGNMENT};\n    bool condition = ${CONDITION};\n    o_color = ${OUT_TYPE}(temp.x, temp.y, condition, 1);\n}\n";

            let program = ShaderProgram::new(
                gl,
                &ProgramSources::vtx_frag(
                    specialize_version(
                        VSS,
                        self.glsl_version,
                        self.sampler,
                        self.out_type,
                        self.qualifier,
                        self.assignment,
                        self.condition,
                    )?,
                    specialize_version(
                        FSS,
                        self.glsl_version,
                        self.sampler,
                        self.out_type,
                        self.qualifier,
                        self.assignment,
                        self.condition,
                    )?,
                ),
            );
            if !program.is_ok() {
                log::warn!("{}", program.build_failure_summary().unwrap_or_default());
                return Err(TestError::Fail("Compile failed".to_string()));
            }

            let color: [f32; 16] = [
                self.min, self.min, 0.0, 1.0, self.min, self.max, 0.0, 1.0, self.max, self.min, 0.0, 1.0, self.max,
                self.max, 0.0, 1.0,
            ];

            gl_call!(gl, "useProgram", gl.use_program(program.program()));

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

        gl_call!(gl, "glBindFramebuffer", gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
        gl_call!(gl, "glDeleteFramebuffers", gl.delete_framebuffers(1, &fbo_ms));

        let width = WIDTH * self.samples;

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
            // Resolve the mutli-sample texture into a render-buffer sized such that the width can hold all samples of a pixel.
            const VSS: &str = "${VERSION_DECL}\nin highp vec2 a_position;\nvoid main(void)\n{\n   gl_Position = vec4(a_position, 0.0, 1.0);\n}\n";
            const FSS: &str = "${VERSION_DECL}\nuniform highp ${SAMPLER}MS u_texMS;\nuniform int u_samples;\nlayout(location = 0) out highp ${OUT_TYPE} o_color;\nvoid main(void)\n{\n    ivec2 coord = ivec2(int(gl_FragCoord.x) / u_samples, gl_FragCoord.y);\n    int sampleId = int(gl_FragCoord.x) % u_samples;\n    o_color = texelFetch(u_texMS, coord, sampleId);\n}\n";

            let program = ShaderProgram::new(
                gl,
                &ProgramSources::vtx_frag(
                    specialize_version(VSS, self.glsl_version, self.sampler, self.out_type, "", "", "")?,
                    specialize_version(FSS, self.glsl_version, self.sampler, self.out_type, "", "", "")?,
                ),
            );
            if !program.is_ok() {
                log::warn!("{}", program.build_failure_summary().unwrap_or_default());
                return Err(TestError::Fail("Compile failed".to_string()));
            }

            gl_call!(gl, "useProgram", gl.use_program(program.program()));
            // SAFETY: NUL-terminated names and the program in use.
            let (samples_location, tex_location) = unsafe {
                (
                    gl.get_uniform_location(program.program(), c"u_samples".as_ptr()),
                    gl.get_uniform_location(program.program(), c"u_texMS".as_ptr()),
                )
            };
            gl_call!(gl, "uniform", gl.uniform_1i(samples_location, self.samples));
            gl_call!(gl, "uniform", gl.uniform_1i(tex_location, 0));

            let vertex_arrays = [va::float("a_position", 2, 4, 0, &POSITION)];
            glu::draw(
                &context.render_context,
                program.program(),
                &vertex_arrays,
                &pr::triangle_strip(&QUAD_INDICES),
            )?;
            glu::expect_no_error(gl, "Draw quad")?;
        }

        // Verify the results.
        let result = read_back(gl, self.tex_kind, width, HEIGHT)?;
        let unique_pixels = result
            .iter()
            .map(|pixel| position_key(*pixel))
            .collect::<BTreeSet<_>>()
            .len() as i32;

        let expected_unique = WIDTH * HEIGHT * if self.unique { self.samples } else { 1 };
        if unique_pixels < expected_unique {
            // There are duplicate pixel values meaning interpolation didn't work as expected.
            is_ok = false;
        }
        for y in 0..HEIGHT {
            for x in 0..width {
                let pixel = if matches!(self.tex_kind, TexKind::Signed8 | TexKind::Unsigned8) {
                    // upstream indexes the integer read-back this way, `y * WIDTH + x`
                    result[(y * WIDTH + x) as usize]
                } else {
                    result[(y * width + x) as usize]
                };
                if pixel[2] != 1.0 {
                    // The ${CONDITION} check in the shader failed.
                    is_ok = false;
                }
            }
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

/// `ShaderMultisampleInterpolationTests::init`
pub fn create_tests(glsl_version: GlslVersion) -> TestCaseGroup {
    let samples: [(&'static str, GLint); 3] = [("samples_1", 1), ("samples_2", 2), ("samples_4", 4)];

    let mut group = TestCaseGroup::new("shader_multisample_interpolation");

    // shader_multisample_interpolation.api
    let mut api_group = TestCaseGroup::new("api");
    api_group.add_child(Box::new(ShaderMultisampleInterpolationApiCase { glsl_version }) as Box<dyn TestCase>);
    group.add_child(api_group);

    // name, qualifier, assignment, condition, unique
    let cases: [(&'static str, &'static str, &'static str, &'static str, bool); 9] = [
        ("base", "", "v_color", "true", false),
        ("sample", "sample", "v_color", "true", true),
        ("centroid", "centroid", "v_color", "true", false),
        (
            "interpolate_at_sample",
            "",
            "interpolateAtSample(v_colorBase, gl_SampleID)",
            "true",
            true,
        ),
        (
            "interpolate_at_sample_check",
            "sample",
            "interpolateAtSample(v_colorBase, gl_SampleID)",
            "temp == v_color",
            true,
        ),
        (
            "interpolate_at_centroid",
            "",
            "interpolateAtCentroid(v_colorBase)",
            "true",
            false,
        ),
        (
            "interpolate_at_centroid_check",
            "centroid",
            "interpolateAtCentroid(v_colorBase)",
            "temp == v_color",
            false,
        ),
        (
            "interpolate_at_offset",
            "",
            "interpolateAtOffset(v_colorBase, gl_SamplePosition - 0.5)",
            "true",
            true,
        ),
        (
            "interpolate_at_offset_check",
            "sample",
            "interpolateAtOffset(v_colorBase, gl_SamplePosition - 0.5)",
            "temp == v_color",
            true,
        ),
    ];

    // shader_multisample_interpolation.render
    let mut render_group = TestCaseGroup::new("render");
    for (case_name, qualifier, assignment, condition, unique) in cases {
        let mut case_group = TestCaseGroup::new(case_name);

        // name, internal format, texture kind, sampler, out type, min, max
        let formats: [(&'static str, GLenum, TexKind, &'static str, &'static str, f32, f32); 4] = [
            ("rgba8", glw::GL_RGBA8, TexKind::Unorm8, "sampler2D", "vec4", 0.0, 1.0),
            (
                "rgba8i",
                glw::GL_RGBA8I,
                TexKind::Signed8,
                "isampler2D",
                "ivec4",
                -128.0,
                127.0,
            ),
            (
                "rgba8ui",
                glw::GL_RGBA8UI,
                TexKind::Unsigned8,
                "usampler2D",
                "uvec4",
                0.0,
                255.0,
            ),
            (
                "rgba32f",
                glw::GL_RGBA32F,
                TexKind::Float32,
                "sampler2D",
                "vec4",
                0.0,
                1.0,
            ),
        ];
        for (format_name, internal_format, tex_kind, sampler, out_type, min, max) in formats {
            let mut format_group = TestCaseGroup::new(format_name);

            for (sample_name, sample_count) in samples {
                format_group.add_child(Box::new(ShaderMultisampleInterpolationBaseCase {
                    case_name: sample_name,
                    glsl_version,
                    qualifier,
                    assignment,
                    condition,
                    unique,
                    internal_format,
                    tex_kind,
                    sampler,
                    out_type,
                    min,
                    max,
                    samples: sample_count,
                }) as Box<dyn TestCase>);
            }

            case_group.add_child(format_group);
        }

        render_group.add_child(case_group);
    }
    group.add_child(render_group);

    group
}
