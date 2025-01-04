// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcShaderIntegerMixTests.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 Google Inc.
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's three `ShaderIntegerMixCase` subclasses are one enum here, each `test()` a method returning the verdict.

use crate::glu::{
    self, Context, GlslVersion, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, VertexArrayBinding, va,
};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

/// `shader_targets[]` - the shader stage and the body its `main` needs to be valid.
const SHADER_TARGETS: [(GLenum, &str); 2] = [
    (glw::GL_VERTEX_SHADER, "gl_Position = vec4(0);"),
    (glw::GL_FRAGMENT_SHADER, ""),
];

const DEFINE_SOURCE_TEMPLATE: &str = "${VERSION_DECL}\n\
    #extension GL_EXT_shader_integer_mix: require\n\
    \n\
    #if !defined GL_EXT_shader_integer_mix\n\
    #  error GL_EXT_shader_integer_mix is not defined\n\
    #elif GL_EXT_shader_integer_mix != 1\n\
    #  error GL_EXT_shader_integer_mix is not equal to 1\n\
    #endif\n\
    \n\
    void main(void) { ${BODY} }\n";

const PROTOTYPES_SOURCE_TEMPLATE: &str = "${VERSION_DECL}\n\
    ${EXTENSION_ENABLE}\n\
    \n\
    void main()\n\
    {\n\
    \x20   mix(ivec2(1), ivec2(2), bvec2(true));\n\
    \x20   mix(ivec3(1), ivec3(2), bvec3(true));\n\
    \x20   mix(ivec4(1), ivec4(2), bvec4(true));\n\
    \x20   mix(uvec2(1), uvec2(2), bvec2(true));\n\
    \x20   mix(uvec3(1), uvec3(2), bvec3(true));\n\
    \x20   mix(uvec4(1), uvec4(2), bvec4(true));\n\
    \x20   mix(bvec2(1), bvec2(0), bvec2(true));\n\
    \x20   mix(bvec3(1), bvec3(0), bvec3(true));\n\
    \x20   mix(bvec4(1), bvec4(0), bvec4(true));\n\
    \x20   ${BODY}\n\
    }\n";

const VS_TEMPLATE: &str = "${VERSION_DECL}\n\
    ${EXTENSION_ENABLE}\n\
    \n\
    in vec2 vertex;\n\
    in ivec4 vs_in_a;\n\
    in ivec4 vs_in_b;\n\
    in ivec4 vs_in_sel;\n\
    \n\
    flat out ivec4 fs_in_a;\n\
    flat out ivec4 fs_in_b;\n\
    flat out ivec4 fs_in_sel;\n\
    flat out ivec4 fs_in_result;\n\
    \n\
    void main()\n\
    {\n\
    \x20   fs_in_a = vs_in_a;\n\
    \x20   fs_in_b = vs_in_b;\n\
    \x20   fs_in_sel = vs_in_sel;\n\
    \n\
    \x20   ${TYPE} a = ${TYPE}(vs_in_a);\n\
    \x20   ${TYPE} b = ${TYPE}(vs_in_b);\n\
    \x20   bvec4 sel = bvec4(vs_in_sel);\n\
    \x20   fs_in_result = ivec4(mix(a, b, sel));\n\
    \n\
    \x20   gl_Position = vec4(vertex, 0, 1);\n\
    \x20   gl_PointSize = 4.;\n\
    }\n";

const FS_TEMPLATE: &str = "${VERSION_DECL}\n\
    ${EXTENSION_ENABLE}\n\
    \n\
    out ivec4 o;\n\
    \n\
    flat in ivec4 fs_in_a;\n\
    flat in ivec4 fs_in_b;\n\
    flat in ivec4 fs_in_sel;\n\
    flat in ivec4 fs_in_result;\n\
    \n\
    uniform bool use_vs_data;\n\
    \n\
    void main()\n\
    {\n\
    \x20   if (use_vs_data)\n\
    \x20       o = fs_in_result;\n\
    \x20   else {\n\
    \x20       ${TYPE} a = ${TYPE}(fs_in_a);\n\
    \x20       ${TYPE} b = ${TYPE}(fs_in_b);\n\
    \x20       bvec4 sel = bvec4(fs_in_sel);\n\
    \x20       o = ivec4(mix(a, b, sel));\n\
    \x20   }\n\
    }\n";

/// What distinguishes the `ShaderIntegerMix*Case` classes.
#[derive(Clone, Copy)]
enum Kind {
    /// `ShaderIntegerMixDefineCase`
    Define,
    /// `ShaderIntegerMixPrototypesCase` (use_extension, is_negative_testing)
    Prototypes {
        use_extension: bool,
        is_negative_testing: bool,
    },
    /// `ShaderIntegerMixRenderCase`, with the `type` its `mix()` parameters have.
    Render { type_name: &'static str },
}

/// `ShaderIntegerMixCase`
struct ShaderIntegerMixCase {
    name: String,
    glsl_version: GlslVersion,
    kind: Kind,
}

/// Compiles one shader of each stage out of `source_template` and reports how many compiled, the way `gl.getShaderiv(GL_COMPILE_STATUS)` answers.
fn compile_shader_source(gl: &glw::Functions, target: GLenum, code: &str) -> (GLuint, bool, String) {
    let mut compile_success: GLint = 0;
    let mut info_log = vec![0u8; 1000];

    // SAFETY: a shader created here, a source whose length is passed explicitly, and an info log buffer that is as long as the size handed over.
    let shader = unsafe {
        let shader = gl.create_shader(target);
        let pointer = code.as_ptr().cast::<glw::GLchar>();
        let length = code.len() as GLint;
        gl.shader_source(shader, 1, &pointer, &length);
        gl.compile_shader(shader);
        gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut compile_success);
        if compile_success == 0 {
            gl.get_shader_info_log(
                shader,
                info_log.len() as i32,
                std::ptr::null_mut(),
                info_log.as_mut_ptr().cast(),
            );
        }
        shader
    };

    let info_log = String::from_utf8_lossy(&info_log).trim_end_matches('\0').to_string();
    (shader, compile_success != 0, info_log)
}

impl ShaderIntegerMixCase {
    /// `ShaderIntegerMixDefineCase::test`
    fn test_define(&self, context: &Context) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut pass = true;

        let version = if self.glsl_version.is_es() {
            GlslVersion::Es300
        } else {
            GlslVersion::Glsl330
        };

        if !context.context_info.is_extension_supported("GL_EXT_shader_integer_mix") {
            return Err(TestError::NotSupported(
                "GL_EXT_shader_integer_mix is not supported".to_string(),
            ));
        }

        for (target, body) in SHADER_TARGETS {
            let args = [
                ("VERSION_DECL", version.declaration().to_string()),
                ("BODY", body.to_string()),
            ];
            let code = StringTemplate::new(DEFINE_SOURCE_TEMPLATE).specialize(&args)?;

            let (shader, compile_success, _) = compile_shader_source(gl, target, &code);
            // SAFETY: the shader was created by `compile_shader_source` and is deleted once.
            unsafe { gl.delete_shader(shader) };

            if !compile_success {
                pass = false;
            }
        }

        Ok(pass)
    }

    /// `ShaderIntegerMixPrototypesCase::test`
    fn test_prototypes(
        &self,
        context: &Context,
        use_extension: bool,
        is_negative_testing: bool,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut pass = true;

        let version;
        let extension_enable;

        if use_extension {
            version = if self.glsl_version.is_es() {
                GlslVersion::Es300
            } else {
                GlslVersion::Glsl330
            };
            extension_enable = "#extension GL_EXT_shader_integer_mix: enable";

            if !context.context_info.is_extension_supported("GL_EXT_shader_integer_mix") {
                return Err(TestError::NotSupported(
                    "GL_EXT_shader_integer_mix is not supported".to_string(),
                ));
            }
        } else if is_negative_testing {
            version = if self.glsl_version.is_es() {
                GlslVersion::Es300
            } else {
                GlslVersion::Glsl330
            };
            extension_enable = "";
        } else {
            version = self.glsl_version;
            extension_enable = "";
            let first_supported = if self.glsl_version.is_es() {
                GlslVersion::Es310
            } else {
                GlslVersion::Glsl450
            };
            if self.glsl_version < first_supported {
                return Err(TestError::NotSupported(
                    "mix() with integer types is not part of this GLSL version".to_string(),
                ));
            }
        }

        for (target, body) in SHADER_TARGETS {
            let args = [
                ("VERSION_DECL", version.declaration().to_string()),
                ("EXTENSION_ENABLE", extension_enable.to_string()),
                ("BODY", body.to_string()),
            ];
            let code = StringTemplate::new(PROTOTYPES_SOURCE_TEMPLATE).specialize(&args)?;

            let (shader, compile_success, info_log) = compile_shader_source(gl, target, &code);

            if is_negative_testing {
                if compile_success {
                    // SAFETY: the shader was created by `compile_shader_source` and is deleted once.
                    unsafe { gl.delete_shader(shader) };
                    return Err(TestError::Fail(
                        "The shader compilation was expected to fail, but it was successful.".to_string(),
                    ));
                }
            } else if !compile_success {
                log::warn!("shader compile failed:\n{info_log}\n{code}");
                pass = false;
            }

            // SAFETY: the shader was created by `compile_shader_source` and is deleted once.
            unsafe { gl.delete_shader(shader) };
        }

        Ok(pass)
    }

    /// `ShaderIntegerMixRenderCase::test`
    #[allow(clippy::too_many_lines)]
    fn test_render(&self, context: &Context, type_name: &str) -> Result<bool, TestError> {
        const WIDTH: i32 = 8 * 8;
        const HEIGHT: i32 = 8 * 8;
        const NUM_POINTS: usize = 256;

        let gl = context.gl();
        let mut pass = true;
        let is_es = self.glsl_version.is_es();

        let extension_enable = if (is_es && self.glsl_version < GlslVersion::Es310) || !is_es {
            // For versions that do not support this feature in Core it must be exposed via an extension.
            if !context.context_info.is_extension_supported("GL_EXT_shader_integer_mix") {
                return Err(TestError::NotSupported(
                    "GL_EXT_shader_integer_mix is not supported".to_string(),
                ));
            }
            "#extension GL_EXT_shader_integer_mix: enable"
        } else {
            ""
        };

        // Generate the specialization of the shader for the specific type being tested.
        let args = [
            ("VERSION_DECL", self.glsl_version.declaration().to_string()),
            ("EXTENSION_ENABLE", extension_enable.to_string()),
            ("TYPE", type_name.to_string()),
        ];
        let vs_code = StringTemplate::new(VS_TEMPLATE).specialize(&args)?;
        let fs_code = StringTemplate::new(FS_TEMPLATE).specialize(&args)?;

        let prog = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vs_code, fs_code));

        if !prog.is_ok() {
            return Err(TestError::Fail("Compile failed".to_string()));
        }

        if !is_es {
            // SAFETY: plain state setting.
            unsafe { gl.enable(glw::GL_PROGRAM_POINT_SIZE) };
        }

        // Generate an integer FBO for rendering.
        let mut fbo: GLuint = 0;
        let mut tex: GLuint = 0;

        // SAFETY: one object requested into one `GLuint` each, and the texture is allocated without data.
        unsafe {
            gl.gen_textures(1, &mut tex);
            gl.bind_texture(glw::GL_TEXTURE_2D, tex);
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA32I as GLint,
                WIDTH,
                HEIGHT,
                0,
                glw::GL_RGBA_INTEGER,
                glw::GL_INT,
                std::ptr::null(),
            );
            gl.bind_texture(glw::GL_TEXTURE_2D, 0);

            gl.gen_framebuffers(1, &mut fbo);
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo);
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo);
            gl.framebuffer_texture_2d(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                tex,
                0,
            );
        }

        glu::expect_no_error(gl, "Creation of rendering FBO failed.")?;

        // SAFETY: the framebuffer bound above.
        if unsafe { gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::Fail("Framebuffer not complete.".to_string()));
        }

        // SAFETY: plain state setting.
        unsafe { gl.viewport(0, 0, WIDTH, HEIGHT) };

        // Fill a VBO with some vertex data.
        let mut point_indices = [0u16; NUM_POINTS];
        let mut vertex = [0f32; NUM_POINTS * 2];
        let mut a = [0i32; NUM_POINTS * 4];
        let mut b = [0i32; NUM_POINTS * 4];
        let mut sel = [0i32; NUM_POINTS * 4];
        let mut expected = [[0i32; 4]; NUM_POINTS];

        for i in 0..NUM_POINTS {
            point_indices[i] = i as u16;

            let x = (i as i32 / 16) * (WIDTH / 16) + (4 / 2);
            let y = (i as i32 % 16) * (HEIGHT / 16) + (4 / 2);

            vertex[i * 2] = x as f32 * 2.0 / WIDTH as f32 - 1.0;
            vertex[i * 2 + 1] = y as f32 * 2.0 / HEIGHT as f32 - 1.0;

            let n = i as i32;
            a[i * 4] = n;
            a[i * 4 + 1] = n * 5;
            a[i * 4 + 2] = n * 7;
            a[i * 4 + 3] = n * 11;

            b[i * 4] = !a[i * 4 + 3];
            b[i * 4 + 1] = !a[i * 4 + 2];
            b[i * 4 + 2] = !a[i * 4 + 1];
            b[i * 4 + 3] = !a[i * 4];

            for k in 0..4 {
                sel[i * 4 + k] = (n >> k) & 1;
                expected[i][k] = if sel[i * 4 + k] != 0 {
                    b[i * 4 + k]
                } else {
                    a[i * 4 + k]
                };
            }
        }

        // Mask off all but the least significant bit for boolean types.
        if type_name.starts_with('b') {
            for i in 0..a.len() {
                a[i] &= 1;
                b[i] &= 1;

                for k in 0..4 {
                    expected[i / 4][k] &= 1;
                }
            }
        }

        let vertex_arrays: [VertexArrayBinding<'_>; 4] = [
            va::float("vertex", 2, NUM_POINTS as i32, 0, &vertex),
            va::int32("vs_in_a", 4, NUM_POINTS as i32, 0, &a),
            va::int32("vs_in_b", 4, NUM_POINTS as i32, 0, &b),
            va::int32("vs_in_sel", 4, NUM_POINTS as i32, 0, &sel),
        ];
        let points = glu::PrimitiveList {
            type_: glu::PrimitiveType::Points,
            num_elements: NUM_POINTS as i32,
            indices: Some(&point_indices),
        };

        // Render and verify the results. Rendering happens twice. The first time, use_vs_data is false, and the mix() result from the fragment shader is used. The second time, use_vs_data is true, and the mix() result from the vertex
        // shader is used.
        // SAFETY: a NUL-terminated name and a program that was just built.
        let loc = unsafe { gl.get_uniform_location(prog.program(), c"use_vs_data".as_ptr()) };
        // SAFETY: a program that was just built.
        unsafe { gl.use_program(prog.program()) };

        const CLEAR: [GLint; 4] = [1, 2, 3, 4];
        // SAFETY: four `GLint`s for a `GL_COLOR` clear of draw buffer 0 of an integer framebuffer.
        unsafe { gl.clear_bufferiv(glw::GL_COLOR, 0, CLEAR.as_ptr()) };

        for (use_vs_data, stage) in [(0, "Fragment"), (1, "Vertex")] {
            // SAFETY: a location of the program in use.
            unsafe { gl.uniform_1i(loc, use_vs_data) };
            glu::draw(&context.render_context, prog.program(), &vertex_arrays, &points)?;

            for i in 0..NUM_POINTS {
                let x = ((vertex[i * 2] + 1.0) * WIDTH as f32 / 2.0) as i32;
                let y = ((vertex[i * 2 + 1] + 1.0) * HEIGHT as f32 / 2.0) as i32;

                pass = probe_pixel(context, stage, x, y, expected[i]) && pass;
            }
        }

        // SAFETY: the objects created above, each deleted once.
        unsafe {
            gl.delete_framebuffers(1, &fbo);
            gl.delete_textures(1, &tex);
        }

        Ok(pass)
    }
}

/// `ShaderIntegerMixRenderCase::probe_pixel`
fn probe_pixel(context: &Context, stage: &str, x: i32, y: i32, expected: [i32; 4]) -> bool {
    let mut pixel = [0i32; 4];

    // SAFETY: the destination holds the four `GLint`s one `GL_RGBA_INTEGER`/`GL_INT` pixel needs.
    unsafe {
        context
            .gl()
            .read_pixels(x, y, 1, 1, glw::GL_RGBA_INTEGER, glw::GL_INT, pixel.as_mut_ptr().cast())
    };

    if expected != pixel {
        log::warn!("{stage} shader failed at pixel ({x}, {y}).  Got {pixel:?}, expected {expected:?}).");
        return false;
    }

    true
}

impl TestCase for ShaderIntegerMixCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `ShaderIntegerMixCase::iterate`
    fn iterate(&self, context: &Context) -> TestOutcome {
        let pass = match self.kind {
            Kind::Define => self.test_define(context)?,
            Kind::Prototypes {
                use_extension,
                is_negative_testing,
            } => self.test_prototypes(context, use_extension, is_negative_testing)?,
            Kind::Render { type_name } => self.test_render(context, type_name)?,
        };

        Ok(if pass {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `ShaderIntegerMixTests::init`
pub fn create_tests(glsl_version: GlslVersion) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_integer_mix");
    let mut add = |name: &str, kind: Kind| {
        group.add_child(Box::new(ShaderIntegerMixCase {
            name: name.to_string(),
            glsl_version,
            kind,
        }) as Box<dyn TestCase>);
    };

    add("define", Kind::Define);
    add(
        "prototypes-extension",
        Kind::Prototypes {
            use_extension: true,
            is_negative_testing: false,
        },
    );
    add(
        "prototypes",
        Kind::Prototypes {
            use_extension: false,
            is_negative_testing: false,
        },
    );
    add(
        "prototypes-negative",
        Kind::Prototypes {
            use_extension: false,
            is_negative_testing: true,
        },
    );

    for type_name in ["ivec4", "uvec4", "bvec4"] {
        add(&format!("mix-{type_name}"), Kind::Render { type_name });
    }

    group
}
