// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcPolygonOffsetClampTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the desktop-core branches are carried over (depth is read with glReadPixels, so the ES depth-readback program and its second framebuffer are not needed), and `init`/`deinit` are the two ends of `iterate`, since `TestCase` has no such hooks.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const POC_SHADER_VERSION_450CORE: &str = "#version 450 core\n\n";

const POC_VERTEX_COLOR: &str = "in highp vec3 vertex;\n\
    \n\
    void main()\n\
    {\n\
    \x20   gl_Position = vec4(vertex, 1);\n\
    }\n";

const POC_FRAGMENT_COLOR: &str = "out highp vec4 fragColor;\n\
    \n\
    void main()\n\
    {\n\
    \x20   fragColor = vec4(1, 1, 1, 1);\n\
    }\n";

/// `PolygonOffsetClampTestCaseBase::PolygonOffsetClampTestCaseBase` + `iterate`'s support check.
fn check_extension_supported(context: &Context) -> Result<(), TestError> {
    let supported = context.context_type().supports_core(4, 6)
        || context
            .context_info
            .is_extension_supported("GL_EXT_polygon_offset_clamp")
        || context
            .context_info
            .is_extension_supported("GL_ARB_polygon_offset_clamp");

    if supported {
        Ok(())
    } else {
        Err(TestError::NotSupported("Not supported".to_string()))
    }
}

/// `PolygonOffsetClampAvailabilityTestCase`
struct PolygonOffsetClampAvailabilityTestCase;

impl TestCase for PolygonOffsetClampAvailabilityTestCase {
    fn name(&self) -> &str {
        "PolygonOffsetClampAvailability"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_extension_supported(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        let mut boolean: glw::GLboolean = 0;
        gl_call!(
            gl,
            "getBooleanv error occurred",
            gl.get_booleanv(glw::GL_POLYGON_OFFSET_CLAMP_EXT, &mut boolean)
        );

        let mut integer: glw::GLint = 0;
        gl_call!(
            gl,
            "getBooleanv error occurred",
            gl.get_integerv(glw::GL_POLYGON_OFFSET_CLAMP_EXT, &mut integer)
        );

        let mut integer64: glw::GLint64 = 0;
        gl_call!(
            gl,
            "getBooleanv error occurred",
            gl.get_integer_64v(glw::GL_POLYGON_OFFSET_CLAMP_EXT, &mut integer64)
        );

        let mut float: glw::GLfloat = 0.0;
        gl_call!(
            gl,
            "getBooleanv error occurred",
            gl.get_floatv(glw::GL_POLYGON_OFFSET_CLAMP_EXT, &mut float)
        );

        let mut double: glw::GLdouble = 0.0;
        gl_call!(
            gl,
            "getBooleanv error occurred",
            gl.get_doublev(glw::GL_POLYGON_OFFSET_CLAMP_EXT, &mut double)
        );

        gl_call!(
            gl,
            "polygonOffsetClamp error occurred",
            gl.polygon_offset_clamp(1.0, 1.0, 0.5)
        );

        Ok(TestStatus::pass("Pass"))
    }
}

/// `PolygonOffsetClampValues`
#[derive(Clone, Copy)]
struct PolygonOffsetClampValues {
    factor: f32,
    units: f32,
    clamp: f32,
}

#[derive(Clone, Copy)]
enum ValueKind {
    MinMax,
    ZeroInfinity,
}

/// `PolygonOffsetClampMinMaxTestCase` / `PolygonOffsetClampZeroInfinityTestCase` on top of `PolygonOffsetClampValueTestCaseBase`.
struct PolygonOffsetClampValueTestCase {
    kind: ValueKind,
}

struct Targets {
    fbo: GLuint,
    depth_buf: GLuint,
    color_buf: GLuint,
}

impl PolygonOffsetClampValueTestCase {
    fn test_values(&self) -> Vec<PolygonOffsetClampValues> {
        match self.kind {
            ValueKind::MinMax => vec![
                // Min offset case
                PolygonOffsetClampValues {
                    factor: 0.0,
                    units: -5000.0,
                    clamp: -0.0001,
                },
                // Max offset case
                PolygonOffsetClampValues {
                    factor: 0.0,
                    units: 5000.0,
                    clamp: 0.0001,
                },
            ],
            ValueKind::ZeroInfinity => vec![
                // Min offset, zero clamp case
                PolygonOffsetClampValues {
                    factor: 0.0,
                    units: -1000.0,
                    clamp: 0.0,
                },
                // Min Offset, infinity clamp case
                PolygonOffsetClampValues {
                    factor: 0.0,
                    units: -1000.0,
                    clamp: -f32::INFINITY,
                },
                // Max offset, zero clamp case
                PolygonOffsetClampValues {
                    factor: 0.0,
                    units: 1000.0,
                    clamp: 0.0,
                },
                // Max Offset, infinity clamp case
                PolygonOffsetClampValues {
                    factor: 0.0,
                    units: 1000.0,
                    clamp: f32::INFINITY,
                },
            ],
        }
    }

    /// `PolygonOffsetClampValueTestCaseBase::init`
    fn init(gl: &glw::Functions) -> Result<Targets, TestError> {
        let mut targets = Targets {
            fbo: 0,
            depth_buf: 0,
            color_buf: 0,
        };

        gl_call!(gl, "genTextures", gl.gen_textures(1, &mut targets.depth_buf));
        gl_call!(
            gl,
            "bindTexture",
            gl.bind_texture(glw::GL_TEXTURE_2D, targets.depth_buf)
        );
        gl_call!(
            gl,
            "texStorage2D",
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_DEPTH_COMPONENT16, 64, 64)
        );
        gl_call!(
            gl,
            "texParameteri",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32)
        );
        gl_call!(
            gl,
            "texParameteri",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32)
        );

        gl_call!(gl, "genTextures", gl.gen_textures(1, &mut targets.color_buf));
        gl_call!(
            gl,
            "bindTexture",
            gl.bind_texture(glw::GL_TEXTURE_2D, targets.color_buf)
        );
        gl_call!(
            gl,
            "texStorage2D",
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, 64, 64)
        );
        gl_call!(
            gl,
            "texParameteri",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32)
        );
        gl_call!(
            gl,
            "texParameteri",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32)
        );

        gl_call!(gl, "genFramebuffers", gl.gen_framebuffers(1, &mut targets.fbo));
        gl_call!(
            gl,
            "bindFramebuffer",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, targets.fbo)
        );
        gl_call!(
            gl,
            "framebufferTexture2D",
            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_DEPTH_ATTACHMENT,
                glw::GL_TEXTURE_2D,
                targets.depth_buf,
                0
            )
        );
        gl_call!(
            gl,
            "framebufferTexture2D",
            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                targets.color_buf,
                0
            )
        );

        // SAFETY: a plain state setter.
        unsafe { gl.viewport(0, 0, 64, 64) };
        Ok(targets)
    }

    /// `PolygonOffsetClampValueTestCaseBase::deinit`
    fn deinit(gl: &glw::Functions, targets: &Targets) -> Result<(), TestError> {
        gl_call!(gl, "bindFramebuffer", gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));

        // SAFETY: the names created in `init`, each deleted once; zero names are skipped like upstream does.
        unsafe {
            if targets.fbo != 0 {
                gl.delete_framebuffers(1, &targets.fbo);
            }
            if targets.depth_buf != 0 {
                gl.delete_textures(1, &targets.depth_buf);
            }
            if targets.color_buf != 0 {
                gl.delete_textures(1, &targets.color_buf);
            }
        }
        Ok(())
    }

    /// `PolygonOffsetClampValueTestCaseBase::readDepthValue`, core-profile branch.
    fn read_depth_value(gl: &glw::Functions) -> Result<f32, TestError> {
        let mut depth_value = 0.0f32;
        gl_call!(
            gl,
            "glReadPixels",
            gl.read_pixels(
                0,
                0,
                1,
                1,
                glw::GL_DEPTH_COMPONENT,
                glw::GL_FLOAT,
                std::ptr::from_mut(&mut depth_value).cast()
            )
        );
        Ok(depth_value)
    }

    /// `PolygonOffsetClampValueTestCaseBase::test`
    fn test(&self, context: &Context, targets: &Targets) -> TestOutcome {
        let gl = context.gl();
        let test_values = self.test_values();

        let vertices: [f32; 12] = [-1.0, -1.0, 0.0, -1.0, 1.0, 0.0, 1.0, -1.0, 0.0, 1.0, 1.0, 0.0];

        // Prepare shader program
        let vertex_color = format!("{POC_SHADER_VERSION_450CORE}{POC_VERTEX_COLOR}");
        let fragment_color = format!("{POC_SHADER_VERSION_450CORE}{POC_FRAGMENT_COLOR}");
        let test_program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vertex_color, fragment_color));
        if !test_program.is_ok() {
            log::warn!(
                "TestProgram build failed: {}",
                test_program.build_failure_summary().unwrap_or_default()
            );
            return Ok(TestStatus::fail("Fail"));
        }

        gl_call!(gl, "glUseProgram", gl.use_program(test_program.program()));

        let mut vao: GLuint = 0;
        let mut array_buffer: GLuint = 0;

        // Setup depth testing
        gl_call!(gl, "glEnable", gl.enable(glw::GL_DEPTH_TEST));
        gl_call!(gl, "glDepthFunc", gl.depth_func(glw::GL_ALWAYS));

        // Generate vertex array object
        gl_call!(gl, "glGenVertexArrays", gl.gen_vertex_arrays(1, &mut vao));
        gl_call!(gl, "glBindVertexArray", gl.bind_vertex_array(vao));

        // Setup vertex array buffer
        gl_call!(gl, "glGenBuffers", gl.gen_buffers(1, &mut array_buffer));
        gl_call!(gl, "glBindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, array_buffer));
        gl_call!(
            gl,
            "glBufferData",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(&vertices) as isize,
                vertices.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );

        // Setup vertex attrib pointer
        gl_call!(gl, "glEnableVertexAttribArray", gl.enable_vertex_attrib_array(0));
        gl_call!(
            gl,
            "glVertexAttribPointer",
            gl.vertex_attrib_pointer(0, 3, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null())
        );

        // Bind framebuffer for drawing
        gl_call!(
            gl,
            "glBindFramebuffer",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, targets.fbo)
        );

        let mut result = true;
        for (i, values) in test_values.iter().enumerate() {
            // Draw reference polygon
            gl_call!(gl, "glDisable", gl.disable(glw::GL_POLYGON_OFFSET_FILL));
            gl_call!(
                gl,
                "glClear",
                gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT)
            );
            gl_call!(gl, "glDrawArrays", gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

            // Get reference depth value
            let depth_value = Self::read_depth_value(gl)?;

            // Draw polygon with depth offset
            gl_call!(gl, "glEnable", gl.enable(glw::GL_POLYGON_OFFSET_FILL));
            gl_call!(
                gl,
                "glBindFramebuffer",
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, targets.fbo)
            );
            gl_call!(gl, "glPolygonOffset", gl.polygon_offset(values.factor, values.units));
            gl_call!(gl, "glDrawArrays", gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

            let depth_value_offset = Self::read_depth_value(gl)?;

            // Draw reference polygon
            gl_call!(gl, "glDisable", gl.disable(glw::GL_POLYGON_OFFSET_FILL));
            gl_call!(
                gl,
                "glBindFramebuffer",
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, targets.fbo)
            );
            gl_call!(
                gl,
                "glClear",
                gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT)
            );
            gl_call!(gl, "glDrawArrays", gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

            // Draw polygon with depth offset
            gl_call!(gl, "glEnable", gl.enable(glw::GL_POLYGON_OFFSET_FILL));
            gl_call!(
                gl,
                "glPolygonOffsetClamp",
                gl.polygon_offset_clamp(values.factor, values.units, values.clamp)
            );
            gl_call!(gl, "glDrawArrays", gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

            let depth_value_offset_clamp = Self::read_depth_value(gl)?;

            // Verify results
            result = result && self.verify(i, depth_value, depth_value_offset, depth_value_offset_clamp);
        }

        // Cleanup
        gl_call!(gl, "glDisableVertexAttribArray", gl.disable_vertex_attrib_array(0));
        gl_call!(gl, "glDeleteBuffers", gl.delete_buffers(1, &array_buffer));
        gl_call!(gl, "glDeleteVertexArrays", gl.delete_vertex_arrays(1, &vao));
        gl_call!(gl, "glDisable", gl.disable(glw::GL_POLYGON_OFFSET_FILL));

        Ok(if result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }

    /// `verify`
    fn verify(&self, case_no: usize, depth: f32, offset_depth: f32, offset_clamp_depth: f32) -> bool {
        match self.kind {
            ValueKind::MinMax => match case_no {
                // Min offset case
                0 => {
                    if depth <= offset_depth || depth <= offset_clamp_depth || offset_depth >= offset_clamp_depth {
                        log::warn!(
                            "PolygonOffsetClampEXT failed at MIN offset test. Expected result: refDepth[{depth}] > offsetClampDepth[{offset_clamp_depth}] > offsetDepth[{offset_depth}]"
                        );
                        return false;
                    }
                    true
                }
                // Max offset case
                1 => {
                    if depth >= offset_depth || depth >= offset_clamp_depth || offset_depth <= offset_clamp_depth {
                        log::warn!(
                            "PolygonOffsetClampEXT failed at MAX offset test. Expected result: refDepth[{depth}] < offsetClampDepth[{offset_clamp_depth}] < offsetDepth[{offset_depth}]"
                        );
                        return false;
                    }
                    true
                }
                // Undefined case
                _ => false,
            },
            ValueKind::ZeroInfinity => {
                if depth == offset_depth || depth == offset_clamp_depth || offset_depth != offset_clamp_depth {
                    log::warn!(
                        "PolygonOffsetClampEXT failed at Zero/Infinity offset clamp test. Expected result: refDepth[{depth}] != (offsetClampDepth[{offset_clamp_depth}] == offsetDepth[{offset_depth}])"
                    );
                    return false;
                }
                true
            }
        }
    }
}

impl TestCase for PolygonOffsetClampValueTestCase {
    fn name(&self) -> &str {
        match self.kind {
            ValueKind::MinMax => "PolygonOffsetClampMinMax",
            ValueKind::ZeroInfinity => "PolygonOffsetClampZeroInfinity",
        }
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_extension_supported(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let targets = Self::init(gl)?;
        let outcome = self.test(context, &targets);
        Self::deinit(gl, &targets)?;
        outcome
    }
}

/// `PolygonOffsetClamp::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("polygon_offset_clamp");
    group.add_child(Box::new(PolygonOffsetClampAvailabilityTestCase) as Box<dyn TestCase>);
    group.add_child(Box::new(PolygonOffsetClampValueTestCase {
        kind: ValueKind::MinMax,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(PolygonOffsetClampValueTestCase {
        kind: ValueKind::ZeroInfinity,
    }) as Box<dyn TestCase>);
    group
}
