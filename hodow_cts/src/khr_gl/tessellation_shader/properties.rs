// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderProperties.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use super::TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `TessellationShaderPropertiesDefaultContextWideValues`
pub(super) struct DefaultContextWideValues {
    pub ext_params: ExtParameters,
}

impl TestCase for DefaultContextWideValues {
    fn name(&self) -> &str {
        "default_values_of_context_wide_properties"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        if !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        let epsilon = 1e-5_f32;
        // pname, number of components, default value; the last two are only applicable to desktop OpenGL.
        let property_value_data: [GLint; 9] = [
            base.gl_ext_tokens.patch_vertices as GLint,
            1,
            3,
            glw::GL_PATCH_DEFAULT_OUTER_LEVEL as GLint,
            4,
            1,
            glw::GL_PATCH_DEFAULT_INNER_LEVEL as GLint,
            2,
            1,
        ];
        let n_properties = if context.context_type().api.desktop { 3 } else { 1 };

        for n_property in 0..n_properties {
            let mut bool_value = [glw::GL_FALSE as glw::GLboolean; 4];
            let mut float_value = [0.0_f32; 4];
            let mut int_value = [0 as GLint; 4];

            let pname = property_value_data[n_property * 3] as glw::GLenum;
            let n_components = property_value_data[n_property * 3 + 1] as usize;
            let expected_value = property_value_data[n_property * 3 + 2];

            gl!(gl.get_booleanv(pname, bool_value.as_mut_ptr()));
            glu::expect_no_error(gl, "glGetBooleanv() failed.")?;
            gl!(gl.get_floatv(pname, float_value.as_mut_ptr()));
            glu::expect_no_error(gl, "glGetFloatv() failed.")?;
            gl!(gl.get_integerv(pname, int_value.as_mut_ptr()));
            glu::expect_no_error(gl, "glGetIntegerv() failed.")?;

            let expected_bool = if expected_value != 0 {
                glw::GL_TRUE as glw::GLboolean
            } else {
                glw::GL_FALSE as glw::GLboolean
            };

            if bool_value[..n_components].iter().any(|value| *value != expected_bool) {
                log::info!("glGetBooleanv() called for pname {pname} reported invalid value.");
                return Err(TestError::Fail("Invalid value reported by glGetBooleanv()".to_string()));
            }
            if int_value[..n_components].iter().any(|value| *value != expected_value) {
                log::info!("glGetIntegerv() called for pname {pname} reported invalid value.");
                return Err(TestError::Fail("Invalid value reported by glGetIntegerv()".to_string()));
            }
            if float_value[..n_components]
                .iter()
                .any(|value| (value - expected_value as f32).abs() > epsilon)
            {
                log::info!("glGetFloatv() called for pname {pname} reported invalid value.");
                return Err(TestError::Fail("Invalid value reported by glGetFloatv()".to_string()));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

const BODY_FS: &str = "${VERSION}\n\nvoid main()\n{\n}\n";
const BODY_VS: &str = "${VERSION}\n\nvoid main()\n{\n}\n";

fn tc_body(vertices: u32) -> String {
    format!(
        "${{VERSION}}\n${{TESSELLATION_SHADER_REQUIRE}}\n\nlayout(vertices={vertices}) out;\n\nvoid main()\n{{\n    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n}}\n"
    )
}

fn te_body(layout: &str) -> String {
    format!(
        "${{VERSION}}\n${{TESSELLATION_SHADER_REQUIRE}}\n\nlayout({layout}) in;\n\nvoid main()\n{{\n    gl_Position = gl_in[0].gl_Position;\n}}\n"
    )
}

#[derive(Default)]
struct Resources {
    fs_id: GLuint,
    po_id: GLuint,
    tc_id: GLuint,
    te_id: GLuint,
    vs_id: GLuint,
}

/// `TessellationShaderPropertiesProgramObject`
pub(super) struct ProgramObject {
    pub ext_params: ExtParameters,
}

fn shader_source_specialized(gl: &glw::Functions, base: &TestCaseBase, shader: GLuint, parts: &[&str]) {
    let merged = base.specialize_shader(parts);
    let pointer = merged.as_ptr().cast::<glw::GLchar>();
    let length = merged.len() as GLint;
    gl!(gl.shader_source(shader, 1, &pointer, &length));
}

fn compile_status(gl: &glw::Functions, shader: GLuint) -> GLint {
    let mut status = glw::GL_FALSE as GLint;
    gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut status));
    status
}

impl ProgramObject {
    /// `initTest`
    fn init_test(&self, context: &Context, base: &TestCaseBase, resources: &mut Resources) -> Result<(), TestError> {
        let gl = context.gl();
        if !base.is_tessellation_shader_supported {
            return Ok(());
        }

        resources.po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() failed")?;

        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.tc_id = gl!(gl.create_shader(base.gl_ext_tokens.tess_control_shader));
        resources.te_id = gl!(gl.create_shader(base.gl_ext_tokens.tess_evaluation_shader));
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateShader() failed")?;

        gl!(gl.attach_shader(resources.po_id, resources.fs_id));
        gl!(gl.attach_shader(resources.po_id, resources.tc_id));
        gl!(gl.attach_shader(resources.po_id, resources.te_id));
        gl!(gl.attach_shader(resources.po_id, resources.vs_id));
        glu::expect_no_error(gl, "glAttachShader() failed")?;

        shader_source_specialized(gl, base, resources.fs_id, &[BODY_FS]);
        shader_source_specialized(gl, base, resources.vs_id, &[BODY_VS]);
        glu::expect_no_error(gl, "glShaderSource() failed")?;

        gl!(gl.compile_shader(resources.fs_id));
        gl!(gl.compile_shader(resources.vs_id));
        glu::expect_no_error(gl, "glCompileShader() failed")?;

        let fs_compile_status = compile_status(gl, resources.fs_id);
        let vs_compile_status = compile_status(gl, resources.vs_id);
        glu::expect_no_error(gl, "glGetShaderiv() failed")?;

        if fs_compile_status != glw::GL_TRUE as GLint {
            return Err(TestError::Fail("Could not compile fragment shader".to_string()));
        }
        if vs_compile_status != glw::GL_TRUE as GLint {
            return Err(TestError::Fail("Could not compile vertex shader".to_string()));
        }
        Ok(())
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let tokens = base.gl_ext_tokens;

        if !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        self.init_test(context, &base, resources)?;

        let (tc_1, te_1) = (tc_body(4), te_body("quads"));
        let (tc_2, te_2) = (tc_body(16), te_body("isolines, fractional_even_spacing, cw"));
        let (tc_3, te_3) = (
            tc_body(32),
            te_body("triangles, fractional_odd_spacing, ccw, point_mode"),
        );
        let (tc_4, te_4) = (tc_body(8), te_body("quads, equal_spacing, ccw, point_mode"));

        struct Test<'a> {
            expected_control_output_vertices_value: GLint,
            expected_gen_mode_value: GLuint,
            expected_gen_point_mode_value: GLuint,
            expected_gen_spacing_value: GLuint,
            expected_gen_vertex_order_value: GLuint,
            tc_body: &'a str,
            te_body: &'a str,
        }
        let tests = [
            Test {
                expected_control_output_vertices_value: 4,
                expected_gen_mode_value: tokens.quads,
                expected_gen_point_mode_value: glw::GL_FALSE as GLuint,
                expected_gen_spacing_value: glw::GL_EQUAL,
                expected_gen_vertex_order_value: glw::GL_CCW,
                tc_body: &tc_1,
                te_body: &te_1,
            },
            Test {
                expected_control_output_vertices_value: 16,
                expected_gen_mode_value: tokens.isolines,
                expected_gen_point_mode_value: glw::GL_FALSE as GLuint,
                expected_gen_spacing_value: tokens.fractional_even,
                expected_gen_vertex_order_value: glw::GL_CW,
                tc_body: &tc_2,
                te_body: &te_2,
            },
            Test {
                expected_control_output_vertices_value: 32,
                expected_gen_mode_value: glw::GL_TRIANGLES,
                expected_gen_point_mode_value: glw::GL_TRUE as GLuint,
                expected_gen_spacing_value: tokens.fractional_odd,
                expected_gen_vertex_order_value: glw::GL_CCW,
                tc_body: &tc_3,
                te_body: &te_3,
            },
            Test {
                expected_control_output_vertices_value: 8,
                expected_gen_mode_value: tokens.quads,
                expected_gen_point_mode_value: glw::GL_TRUE as GLuint,
                expected_gen_spacing_value: glw::GL_EQUAL,
                expected_gen_vertex_order_value: glw::GL_CCW,
                tc_body: &tc_4,
                te_body: &te_4,
            },
        ];

        for test in &tests {
            shader_source_specialized(gl, &base, resources.tc_id, &[test.tc_body]);
            shader_source_specialized(gl, &base, resources.te_id, &[test.te_body]);
            glu::expect_no_error(gl, "glShaderSource() failed")?;

            gl!(gl.compile_shader(resources.tc_id));
            gl!(gl.compile_shader(resources.te_id));
            glu::expect_no_error(gl, "glCompileShader() failed")?;

            let tc_compile_status = compile_status(gl, resources.tc_id);
            let te_compile_status = compile_status(gl, resources.te_id);
            glu::expect_no_error(gl, "glGetShaderiv() failed")?;

            if tc_compile_status != glw::GL_TRUE as GLint {
                return Err(TestError::Fail(
                    "Could not compile tessellation control shader".to_string(),
                ));
            }
            if te_compile_status != glw::GL_TRUE as GLint {
                return Err(TestError::Fail(
                    "Could not compile tessellation evaluation shader".to_string(),
                ));
            }

            let mut link_status = glw::GL_FALSE as GLint;
            gl!(gl.link_program(resources.po_id));
            glu::expect_no_error(gl, "glLinkProgram() failed")?;
            gl!(gl.get_programiv(resources.po_id, glw::GL_LINK_STATUS, &mut link_status));
            glu::expect_no_error(gl, "glGetProgramiv() failed")?;
            if link_status != glw::GL_TRUE as GLint {
                return Err(TestError::Fail("Program linking failed".to_string()));
            }

            let mut control_output_vertices_value: GLint = 0;
            let mut gen_mode_value = glw::GL_NONE as GLint;
            let mut gen_spacing_value = glw::GL_NONE as GLint;
            let mut gen_vertex_order_value = glw::GL_NONE as GLint;
            let mut gen_point_mode_value = glw::GL_NONE as GLint;

            gl!(gl.get_programiv(
                resources.po_id,
                tokens.tess_control_output_vertices,
                &mut control_output_vertices_value
            ));
            gl!(gl.get_programiv(resources.po_id, tokens.tess_gen_mode, &mut gen_mode_value));
            gl!(gl.get_programiv(resources.po_id, tokens.tess_gen_spacing, &mut gen_spacing_value));
            gl!(gl.get_programiv(resources.po_id, tokens.tess_gen_point_mode, &mut gen_point_mode_value));
            gl!(gl.get_programiv(
                resources.po_id,
                tokens.tess_gen_vertex_order,
                &mut gen_vertex_order_value
            ));
            glu::expect_no_error(gl, "glGetProgramiv() for tessellation-specific properties failed.")?;

            if control_output_vertices_value != test.expected_control_output_vertices_value {
                log::info!(
                    "Invalid value reported for GL_TESS_CONTROL_OUTPUT_VERTICES_EXT property;  expected: {}, retrieved: {control_output_vertices_value}",
                    test.expected_control_output_vertices_value
                );
                return Err(TestError::Fail(
                    "Invalid value reported for GL_TESS_CONTROL_OUTPUT_VERTICES_EXT property.".to_string(),
                ));
            }
            if gen_mode_value as GLuint != test.expected_gen_mode_value {
                log::info!(
                    "Invalid value reported for GL_TESS_GEN_MODE_EXT property;  expected: {}, retrieved: {gen_mode_value}",
                    test.expected_gen_mode_value
                );
                return Err(TestError::Fail(
                    "Invalid value reported for GL_TESS_GEN_MODE_EXT property.".to_string(),
                ));
            }
            if gen_spacing_value as GLuint != test.expected_gen_spacing_value {
                log::info!(
                    "Invalid value reported for GL_TESS_GEN_SPACING_EXT property;  expected: {}, retrieved: {gen_spacing_value}",
                    test.expected_gen_spacing_value
                );
                return Err(TestError::Fail(
                    "Invalid value reported for GL_TESS_GEN_SPACING_EXT property.".to_string(),
                ));
            }
            if gen_point_mode_value as GLuint != test.expected_gen_point_mode_value {
                log::info!(
                    "Invalid value reported for GL_TESS_GEN_POINT_MODE_EXT property;  expected: {}, retrieved: {gen_point_mode_value}",
                    test.expected_gen_point_mode_value
                );
                return Err(TestError::Fail(
                    "Invalid value reported for GL_TESS_GEN_POINT_MODE_EXT property.".to_string(),
                ));
            }
            if gen_vertex_order_value as GLuint != test.expected_gen_vertex_order_value {
                log::info!(
                    "Invalid value reported for GL_TESS_GEN_VERTEX_ORDER_EXT property;  expected: {}, retrieved: {gen_vertex_order_value}",
                    test.expected_gen_vertex_order_value
                );
                return Err(TestError::Fail(
                    "Invalid value reported for GL_TESS_GEN_VERTEX_ORDER_EXT property.".to_string(),
                ));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for ProgramObject {
    fn name(&self) -> &str {
        "program_object_properties"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        if resources.fs_id != 0 {
            gl!(gl.delete_shader(resources.fs_id));
        }
        if resources.po_id != 0 {
            gl!(gl.delete_program(resources.po_id));
        }
        if resources.tc_id != 0 {
            gl!(gl.delete_shader(resources.tc_id));
        }
        if resources.te_id != 0 {
            gl!(gl.delete_shader(resources.te_id));
        }
        if resources.vs_id != 0 {
            gl!(gl.delete_shader(resources.vs_id));
        }
        outcome
    }
}
