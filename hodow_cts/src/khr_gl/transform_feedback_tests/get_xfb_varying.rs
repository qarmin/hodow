// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl3cTransformFeedbackTests.cpp  (CheckGetXFBVarying)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use super::{Sources, build_program, internal_error, itoa, preprocess_code, verdict};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLchar, GLenum, GLint, GLsizei, GLuint};
use crate::tcu::{TestError, TestOutcome};

const GENERIC_FRAGMENT_SHADER: &str = "#version 130\n\nout vec4 color;\n\nvoid main()\n{\n    color = vec4(1.0);\n}\n";

/// `CheckGetXFBVarying::ShaderCase`
struct ShaderCase {
    vertex_shader: &'static str,
    geometry_shader: Option<&'static str>,
}

const SHADER_CASES: [ShaderCase; 2] = [
    ShaderCase {
        vertex_shader: "#version 130\n\nTEMPLATE_OUTPUT_DECLARATIONS\nvoid main()\n{\n    gl_Position = vec4(1.0);\nTEMPLATE_OUTPUT_SETTERS}\n",
        geometry_shader: None,
    },
    ShaderCase {
        vertex_shader: "#version 130\n\nvoid main()\n{\n}\n",
        geometry_shader: Some(
            "#version 150\n\nlayout(points) in;\nlayout(points, max_vertices = 1) out;\n\nTEMPLATE_OUTPUT_DECLARATIONS\nvoid main()\n{\n    gl_Position = vec4(1.0);\nTEMPLATE_OUTPUT_SETTERS    EmitVertex();\n}\n",
        ),
    },
];

/// `CheckGetXFBVarying::VaryingType`
struct VaryingType {
    type_: GLenum,
    name: &'static str,
    components_count: GLuint,
    float_component: bool,
}

const VARYING_TYPES: [VaryingType; 15] = [
    VaryingType {
        type_: glw::GL_FLOAT,
        name: "float",
        components_count: 1,
        float_component: true,
    },
    VaryingType {
        type_: glw::GL_FLOAT_VEC2,
        name: "vec2",
        components_count: 2,
        float_component: true,
    },
    VaryingType {
        type_: glw::GL_FLOAT_VEC3,
        name: "vec3",
        components_count: 3,
        float_component: true,
    },
    VaryingType {
        type_: glw::GL_FLOAT_VEC4,
        name: "vec4",
        components_count: 4,
        float_component: true,
    },
    VaryingType {
        type_: glw::GL_INT,
        name: "int",
        components_count: 1,
        float_component: false,
    },
    VaryingType {
        type_: glw::GL_INT_VEC2,
        name: "ivec2",
        components_count: 2,
        float_component: false,
    },
    VaryingType {
        type_: glw::GL_INT_VEC3,
        name: "ivec3",
        components_count: 3,
        float_component: false,
    },
    VaryingType {
        type_: glw::GL_INT_VEC4,
        name: "ivec4",
        components_count: 4,
        float_component: false,
    },
    VaryingType {
        type_: glw::GL_UNSIGNED_INT,
        name: "uint",
        components_count: 1,
        float_component: false,
    },
    VaryingType {
        type_: glw::GL_UNSIGNED_INT_VEC2,
        name: "uvec2",
        components_count: 2,
        float_component: false,
    },
    VaryingType {
        type_: glw::GL_UNSIGNED_INT_VEC3,
        name: "uvec3",
        components_count: 3,
        float_component: false,
    },
    VaryingType {
        type_: glw::GL_UNSIGNED_INT_VEC4,
        name: "uvec4",
        components_count: 4,
        float_component: false,
    },
    VaryingType {
        type_: glw::GL_FLOAT_MAT2,
        name: "mat2",
        components_count: 4,
        float_component: true,
    },
    VaryingType {
        type_: glw::GL_FLOAT_MAT3,
        name: "mat3",
        components_count: 9,
        float_component: true,
    },
    VaryingType {
        type_: glw::GL_FLOAT_MAT4,
        name: "mat4",
        components_count: 16,
        float_component: true,
    },
];

const CAPTURE_WAYS: [GLenum; 2] = [glw::GL_INTERLEAVED_ATTRIBS, glw::GL_SEPARATE_ATTRIBS];

/// The limits `CheckGetXFBVarying::fetchLimits` reads.
struct Limits {
    max_xfb_interleaved_components: GLint,
    max_xfb_separate_attributes: GLint,
    max_xfb_separate_components: GLint,
    max_varying_components: GLint,
    max_varying_vectors: GLint,
    max_geometry_total_output_components: GLint,
}

/// `CheckGetXFBVarying`
pub(super) struct CheckGetXFBVarying;

impl CheckGetXFBVarying {
    /// `CheckGetXFBVarying::numberOfAttributes`, in the unsigned arithmetic of upstream.
    fn number_of_attributes(limits: &Limits, capture_way: usize, shader_case: usize, varying_type: usize) -> GLuint {
        let max_total_components = ((if SHADER_CASES[shader_case].geometry_shader.is_none() {
            limits.max_varying_components
        } else {
            limits.max_geometry_total_output_components
        }) as GLuint)
            .wrapping_sub(4);
        let attribute_components = VARYING_TYPES[varying_type].components_count;
        let max_xfb_components = if CAPTURE_WAYS[capture_way] == glw::GL_INTERLEAVED_ATTRIBS {
            limits.max_xfb_interleaved_components as GLuint
        } else {
            attribute_components.wrapping_mul(limits.max_xfb_separate_components as GLuint)
        };

        if CAPTURE_WAYS[capture_way] == glw::GL_SEPARATE_ATTRIBS
            && attribute_components > limits.max_xfb_separate_components as GLuint
        {
            return 0;
        }

        let mut number_of_attributes = max_xfb_components / attribute_components;

        if CAPTURE_WAYS[capture_way] == glw::GL_SEPARATE_ATTRIBS
            && number_of_attributes > limits.max_xfb_separate_attributes as GLuint
        {
            number_of_attributes = limits.max_xfb_separate_attributes as GLuint;
        }

        if number_of_attributes.wrapping_mul(attribute_components) > max_total_components {
            number_of_attributes = max_total_components / attribute_components;
        }

        if attribute_components <= 4 {
            if number_of_attributes > limits.max_varying_vectors as GLuint {
                number_of_attributes = limits.max_varying_vectors as GLuint;
            }
        } else if number_of_attributes > limits.max_varying_vectors as GLuint / 4 {
            number_of_attributes = limits.max_varying_vectors as GLuint / 4;
        }

        number_of_attributes
    }

    /// `CheckGetXFBVarying::buildProgram`
    fn build_program(
        context: &Context,
        capture_way: usize,
        shader_case: usize,
        varying_type: usize,
        number_of_attributes: GLuint,
    ) -> Result<GLuint, TestError> {
        let gl = context.gl();
        let mut declarations = String::new();
        let mut setters = String::new();
        let mut varyings: Vec<String> = Vec::new();

        for i in 0..number_of_attributes {
            let varying = format!("result_{}", itoa(i as GLint));
            let type_ = &VARYING_TYPES[varying_type];

            declarations.push_str(&format!("out {} {varying};\n", type_.name));
            setters.push_str(&format!(
                "    {varying} = {}(2{});\n",
                type_.name,
                if type_.float_component { ".0" } else { "" }
            ));
            varyings.push(varying);
        }

        let case = &SHADER_CASES[shader_case];
        let xfb_shader = case.geometry_shader.unwrap_or(case.vertex_shader);
        let xfb_shader = preprocess_code(xfb_shader, "TEMPLATE_OUTPUT_DECLARATIONS", &declarations);
        let xfb_shader = preprocess_code(&xfb_shader, "TEMPLATE_OUTPUT_SETTERS", &setters);

        let varying_refs: Vec<&str> = varyings.iter().map(String::as_str).collect();
        let sources = match case.geometry_shader {
            None => Sources {
                vertex: Some(&xfb_shader),
                fragment: Some(GENERIC_FRAGMENT_SHADER),
                ..Sources::default()
            },
            Some(_) => Sources {
                geometry: Some(&xfb_shader),
                vertex: Some(case.vertex_shader),
                fragment: Some(GENERIC_FRAGMENT_SHADER),
                ..Sources::default()
            },
        };

        let program = build_program(gl, &sources, &varying_refs, CAPTURE_WAYS[capture_way]);

        if program == 0 {
            log::info!(
                "Building program has failed.\nVertex shader:\n{}Geometry shader:\n{}Fragment shader:\n{GENERIC_FRAGMENT_SHADER}",
                sources.vertex.unwrap_or(""),
                sources.geometry.unwrap_or("")
            );
            return internal_error();
        }

        Ok(program)
    }

    /// `CheckGetXFBVarying::check`
    fn check(
        context: &Context,
        program: GLuint,
        capture_way: usize,
        varying_type: usize,
        number_of_attributes: GLuint,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut max_length: GLuint = 0;

        for i in 0..number_of_attributes {
            const BUF_SIZE: GLsizei = 18;
            let mut length: GLsizei = 0;
            let mut size: GLsizei = 0;
            let mut type_: GLenum = glw::GL_NONE;
            let mut name = [0 as GLchar; BUF_SIZE as usize];

            gl_call!(
                gl,
                "glGetTransformFeedbackVarying call failed.",
                gl.get_transform_feedback_varying(
                    program,
                    i,
                    BUF_SIZE,
                    &mut length,
                    &mut size,
                    &mut type_,
                    name.as_mut_ptr()
                )
            );

            max_length = max_length.max(length as GLuint);

            if length == 0 {
                return Ok(false);
            }

            let bytes: Vec<u8> = name
                .iter()
                .take_while(|&&byte| byte != 0)
                .map(|&byte| byte as u8)
                .collect();
            let varying = String::from_utf8_lossy(&bytes);

            if varying != format!("result_{}", itoa(i as GLint)) {
                return Ok(false);
            }

            if size != 1 {
                return Ok(false);
            }

            if type_ != VARYING_TYPES[varying_type].type_ {
                return Ok(false);
            }
        }

        let mut xfb_varyings: GLint = 0;
        let mut xfb_mode: GLint = 0;
        let mut xfb_varying_max_length: GLint = 0;

        gl_call!(gl, "glGetProgramiv call failed.", {
            gl.get_programiv(program, glw::GL_TRANSFORM_FEEDBACK_VARYINGS, &mut xfb_varyings);
            gl.get_programiv(program, glw::GL_TRANSFORM_FEEDBACK_BUFFER_MODE, &mut xfb_mode);
            gl.get_programiv(
                program,
                glw::GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH,
                &mut xfb_varying_max_length,
            );
        });

        if xfb_varyings as GLuint != number_of_attributes {
            return Ok(false);
        }

        if xfb_mode as GLenum != CAPTURE_WAYS[capture_way] {
            return Ok(false);
        }

        if (xfb_varying_max_length as GLuint) < max_length {
            return Ok(false);
        }

        Ok(true)
    }
}

impl TestCase for CheckGetXFBVarying {
    fn name(&self) -> &str {
        "get_xfb_varying"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let context_type = context.context_type();
        let is_at_least_gl_30 = context_type.supports_core(3, 0);
        let is_at_least_gl_32 = context_type.supports_core(3, 2);
        let is_ext_tf_1 = context.context_info.is_extension_supported("GL_EXT_transform_feedback");
        let is_arb_gs_4 = context.context_info.is_extension_supported("GL_ARB_geometry_shader4");

        let mut is_ok = true;

        if (is_at_least_gl_30 || is_ext_tf_1) && (is_at_least_gl_32 || is_arb_gs_4) {
            let mut limits = Limits {
                max_xfb_interleaved_components: 0,
                max_xfb_separate_attributes: 0,
                max_xfb_separate_components: 0,
                max_varying_components: 0,
                max_varying_vectors: 0,
                max_geometry_total_output_components: 0,
            };

            gl_call!(gl, "glGetIntegerv call failed.", {
                gl.get_integerv(
                    glw::GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS,
                    &mut limits.max_xfb_interleaved_components,
                );
                gl.get_integerv(
                    glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS,
                    &mut limits.max_xfb_separate_attributes,
                );
                gl.get_integerv(
                    glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS,
                    &mut limits.max_xfb_separate_components,
                );
                gl.get_integerv(glw::GL_MAX_VARYING_COMPONENTS, &mut limits.max_varying_components);
                gl.get_integerv(glw::GL_MAX_VARYING_VECTORS, &mut limits.max_varying_vectors);
                gl.get_integerv(
                    glw::GL_MAX_GEOMETRY_OUTPUT_COMPONENTS,
                    &mut limits.max_geometry_total_output_components,
                );
            });

            for i in 0..CAPTURE_WAYS.len() {
                for j in 0..SHADER_CASES.len() {
                    for k in 0..VARYING_TYPES.len() {
                        if !is_ok {
                            continue;
                        }

                        let n = Self::number_of_attributes(&limits, i, j, k);

                        if n != 0 {
                            let program = Self::build_program(context, i, j, k, n)?;
                            is_ok = is_ok && program != 0;
                            let checked = Self::check(context, program, i, k, n);
                            is_ok = is_ok && checked?;

                            gl_call!(gl, "glDeleteProgram call failed.", gl.delete_program(program));
                        }
                    }
                }
            }
        }

        if is_ok {
            log::info!("Test checking Get Transform Feedback Varying have passed.");
        }

        verdict(is_ok)
    }
}
