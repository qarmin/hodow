// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcGLSLVectorConstructorTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 Google Inc.
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The per-type `std::function` generators became a match on the type name; `tcu::StringTemplate` became four plain replacements.

use crate::glu::{self, Context, GlslVersion, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, pr, va};
use crate::glw;
use crate::tcu::{TestError, TestOutcome, TestStatus};

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    VertexShaderError,
    FragmentShaderError,
    VertexShader,
    FragmentShader,
}

/// `TestDefinition`
struct TestDefinition {
    output_types: &'static [&'static str],
    input_type_lists: &'static [&'static [&'static str]],
    extra_fields: &'static str,
}

const TESTS: [TestDefinition; 3] = [
    TestDefinition {
        output_types: &["vec2", "vec3", "vec4"],
        input_type_lists: &[
            &["mat2"],
            &["mat2x3"],
            &["mat2x4"],
            &["mat3"],
            &["mat3x2"],
            &["mat3x4"],
            &["mat4"],
            &["mat4x2"],
            &["mat4x3"],
            &["float", "mat2"],
            &["float", "mat2x3"],
            &["float", "mat2x4"],
            &["float", "mat3"],
            &["float", "mat3x2"],
            &["float", "mat3x4"],
            &["float", "mat4"],
            &["float", "mat4x2"],
            &["float", "mat4x3"],
        ],
        extra_fields: "const float errorBound = 1.0E-5;\n",
    },
    TestDefinition {
        output_types: &["ivec2", "ivec3", "ivec4"],
        input_type_lists: &[
            &["mat2"],
            &["mat2x3"],
            &["mat2x4"],
            &["mat3"],
            &["mat3x2"],
            &["mat3x4"],
            &["mat4"],
            &["mat4x2"],
            &["mat4x3"],
            &["int", "mat2"],
            &["int", "mat2x3"],
            &["int", "mat2x4"],
            &["int", "mat3"],
            &["int", "mat3x2"],
            &["int", "mat3x4"],
            &["int", "mat4"],
            &["int", "mat4x2"],
            &["int", "mat4x3"],
        ],
        extra_fields: "",
    },
    TestDefinition {
        output_types: &["bvec2", "bvec3", "bvec4"],
        input_type_lists: &[
            &["mat2"],
            &["mat2x3"],
            &["mat2x4"],
            &["mat3"],
            &["mat3x2"],
            &["mat3x4"],
            &["mat4"],
            &["mat4x2"],
            &["mat4x3"],
            &["bool", "mat2"],
            &["bool", "mat2x3"],
            &["bool", "mat2x4"],
            &["bool", "mat3"],
            &["bool", "mat3x2"],
            &["bool", "mat3x4"],
            &["bool", "mat4"],
            &["bool", "mat4x2"],
            &["bool", "mat4x3"],
        ],
        extra_fields: "",
    },
];

/// `TestParams`
struct TestParams {
    name: String,
    test_type: TestType,
    output_type: &'static str,
    input_types: Vec<&'static str>,
    extra_fields: &'static str,
}

/// `generateTestParams`
fn generate_test_params() -> Vec<TestParams> {
    let mut result = Vec::with_capacity(64);
    for test in &TESTS {
        for &output_type in test.output_types {
            for &input_types in test.input_type_lists {
                let mut test_name = format!("{output_type}_from");
                for input_type in input_types {
                    test_name.push('_');
                    test_name.push_str(input_type);
                }
                let test_name_invalid_vs = format!("{test_name}_{}_invalid_vs", input_types[0]);
                let test_name_invalid_fs = format!("{test_name}_{}_invalid_fs", input_types[0]);

                result.push(TestParams {
                    name: format!("{test_name}_vs"),
                    test_type: TestType::VertexShader,
                    output_type,
                    input_types: input_types.to_vec(),
                    extra_fields: test.extra_fields,
                });
                result.push(TestParams {
                    name: format!("{test_name}_fs"),
                    test_type: TestType::FragmentShader,
                    output_type,
                    input_types: input_types.to_vec(),
                    extra_fields: test.extra_fields,
                });

                let mut fail_input_types = input_types.to_vec();
                fail_input_types.push(input_types[0]);
                result.push(TestParams {
                    name: test_name_invalid_vs,
                    test_type: TestType::VertexShaderError,
                    output_type,
                    input_types: fail_input_types.clone(),
                    extra_fields: test.extra_fields,
                });
                result.push(TestParams {
                    name: test_name_invalid_fs,
                    test_type: TestType::FragmentShaderError,
                    output_type,
                    input_types: fail_input_types,
                    extra_fields: test.extra_fields,
                });
            }
        }
    }
    result
}

const DEFAULT_VERTEX_SHADER: &str =
    "${GLSL_VERSION}\nin vec4 vPosition;\nvoid main()\n{\n    gl_Position = vPosition;\n}\n";

const DEFAULT_FRAGMENT_SHADER: &str = "${GLSL_VERSION}\nprecision mediump float;\nin vec4 vColor;\nout vec4 my_FragColor;\nvoid main() {\n    my_FragColor = vColor;\n}\n";

const VERTEX_SHADER_TEMPLATE: &str = "${GLSL_VERSION}\nin vec4 vPosition;\nprecision mediump int;\nprecision mediump float;\nconst vec4 green = vec4(0.0, 1.0, 0.0, 1.0);\nconst vec4 red      = vec4(1.0, 0.0, 0.0, 1.0);\n${TEST_CONSTANTS}out vec4 vColor;\nvoid main() {\n    ${TEST_CODE}\n    if ${TEST_CONDITION}\n        vColor = green;\n    else\n        vColor = red;\n    gl_Position = vPosition;\n}\n";

const FRAGMENT_SHADER_TEMPLATE: &str = "${GLSL_VERSION}\nprecision mediump int;\nprecision mediump float;\nconst vec4 green = vec4(0.0, 1.0, 0.0, 1.0);\nconst vec4 red      = vec4(1.0, 0.0, 0.0, 1.0);\n${TEST_CONSTANTS}out vec4 my_FragColor;\nvoid main() {\n    ${TEST_CODE}\n    if ${TEST_CONDITION}\n        my_FragColor = green;\n    else\n        my_FragColor = red;\n}\n";

/// `testConditions`; an unknown type gets the empty string, as `find() != end()` does upstream.
fn test_condition(output_type: &str) -> &'static str {
    match output_type {
        "vec2" => "(abs(v[0] - 0.0) <= errorBound && abs(v[1] - 1.0) <= errorBound)",
        "vec3" => "(abs(v[0] - 0.0) <= errorBound && abs(v[1] - 1.0) <= errorBound && abs(v[2] - 2.0) <= errorBound)",
        "vec4" => {
            "(abs(v[0] - 0.0) <= errorBound && abs(v[1] - 1.0) <= errorBound && abs(v[2] - 2.0) <= errorBound && abs(v[3] - 3.0) <= errorBound)"
        }
        "ivec2" => "(v[0] == 0 && v[1] == 1)",
        "ivec3" => "(v[0] == 0 && v[1] == 1 && v[2] == 2)",
        "ivec4" => "(v[0] == 0 && v[1] == 1 && v[2] == 2 && v[3] == 3)",
        "bvec2" => "(v[0] == false && v[1] == true)",
        "bvec3" => "(v[0] == false && v[1] == true && v[2] == true)",
        "bvec4" => "(v[0] == false && v[1] == true && v[2] == true && v[3] == true)",
        _ => "",
    }
}

#[derive(Clone, Copy)]
enum ValueKind {
    Float,
    Int,
    Bool,
}

/// `dataTypeInfos` - the element count, how one element is written, and whether the type is spelled as a constructor call.
struct DataTypeInfo {
    num_elements: usize,
    value_kind: ValueKind,
    is_constructor: bool,
}

fn data_type_info(type_name: &str) -> DataTypeInfo {
    let (num_elements, value_kind) = match type_name {
        "float" => (1, ValueKind::Float),
        "vec2" => (2, ValueKind::Float),
        "vec3" => (3, ValueKind::Float),
        "vec4" => (4, ValueKind::Float),
        "int" => (1, ValueKind::Int),
        "ivec2" => (2, ValueKind::Int),
        "ivec3" => (3, ValueKind::Int),
        "ivec4" => (4, ValueKind::Int),
        "bool" => (1, ValueKind::Bool),
        "bvec2" => (2, ValueKind::Bool),
        "bvec3" => (3, ValueKind::Bool),
        "bvec4" => (4, ValueKind::Bool),
        "mat2" => (4, ValueKind::Float),
        "mat2x3" => (6, ValueKind::Float),
        "mat2x4" => (8, ValueKind::Float),
        "mat3" => (9, ValueKind::Float),
        "mat3x2" => (6, ValueKind::Float),
        "mat3x4" => (12, ValueKind::Float),
        "mat4" => (16, ValueKind::Float),
        "mat4x2" => (8, ValueKind::Float),
        "mat4x3" => (12, ValueKind::Float),
        other => panic!("unknown data type {other}"),
    };
    let is_constructor = !matches!(type_name, "float" | "int" | "bool");
    DataTypeInfo {
        num_elements,
        value_kind,
        is_constructor,
    }
}

fn generate_value(out: &mut String, kind: ValueKind, index: usize) {
    match kind {
        ValueKind::Float => out.push_str(&format!("{index}.0")),
        ValueKind::Int => out.push_str(&index.to_string()),
        ValueKind::Bool => out.push_str(if index != 0 { "true" } else { "false" }),
    }
}

/// `generateTestCode`
fn generate_test_code(output_type: &str, input_types: &[&str]) -> String {
    let output_type_info = data_type_info(output_type);
    let mut output = format!("{output_type} v = ");
    if output_type_info.is_constructor {
        output.push_str(output_type);
        output.push('(');
    }
    let mut output_elements_remaining = output_type_info.num_elements as i32;
    let mut output_element_index = 0usize;
    for &input_type in input_types {
        if output_elements_remaining <= 0 {
            break;
        }
        let input_type_info = data_type_info(input_type);

        if output_element_index > 0 {
            output.push_str(", ");
        }
        if input_type_info.is_constructor {
            output.push_str(input_type);
            output.push('(');
        }
        for j in 0..input_type_info.num_elements {
            if j > 0 {
                output.push_str(", ");
            }
            generate_value(&mut output, input_type_info.value_kind, output_element_index);
            output_element_index += 1;
            output_elements_remaining -= 1;
        }
        if input_type_info.is_constructor {
            output.push(')');
        }
    }
    if output_type_info.is_constructor {
        output.push(')');
    }
    output.push(';');
    output
}

/// `replacePlaceholders`
fn replace_placeholders(shader_template: &str, params: &TestParams, glsl_version: GlslVersion) -> String {
    shader_template
        .replace("${GLSL_VERSION}", glsl_version.declaration())
        .replace("${TEST_CONSTANTS}", params.extra_fields)
        .replace(
            "${TEST_CODE}",
            &generate_test_code(params.output_type, &params.input_types),
        )
        .replace("${TEST_CONDITION}", test_condition(params.output_type))
}

const POSITIONS: [f32; 8] = [-1.0, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0];
const INDICES: [u16; 4] = [0, 1, 2, 3];

const RENDERTARGET_WIDTH: i32 = 16;
const RENDERTARGET_HEIGHT: i32 = 16;

/// `GLSLVectorConstructorTestCase`
struct GlslVectorConstructorTestCase {
    name: String,
    test_type: TestType,
    vertex_shader: String,
    fragment_shader: String,
}

impl GlslVectorConstructorTestCase {
    fn new(glsl_version: GlslVersion, params: &TestParams) -> Self {
        let (vertex_shader, fragment_shader) = match params.test_type {
            TestType::VertexShaderError | TestType::VertexShader => (
                replace_placeholders(VERTEX_SHADER_TEMPLATE, params, glsl_version),
                replace_placeholders(DEFAULT_FRAGMENT_SHADER, params, glsl_version),
            ),
            TestType::FragmentShaderError | TestType::FragmentShader => (
                replace_placeholders(DEFAULT_VERTEX_SHADER, params, glsl_version),
                replace_placeholders(FRAGMENT_SHADER_TEMPLATE, params, glsl_version),
            ),
        };
        Self {
            name: params.name.clone(),
            test_type: params.test_type,
            vertex_shader,
            fragment_shader,
        }
    }
}

/// `GLSLVectorConstructorTestCase::setupRenderTarget`
fn setup_render_target(gl: &glw::Functions, fbo: &glu::Framebuffer, rbo: &glu::Renderbuffer) -> Result<(), TestError> {
    // SAFETY: names owned by the two guards, on a current context; the draw buffer array and the clear colour outlive their calls.
    unsafe {
        glu::expect_no_error(gl, "GenFramebuffers")?;
        glu::expect_no_error(gl, "GenRenderBuffers")?;

        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo.get());
        glu::expect_no_error(gl, "BindRenderBuffer")?;

        gl.renderbuffer_storage(
            glw::GL_RENDERBUFFER,
            glw::GL_RGBA8,
            RENDERTARGET_WIDTH,
            RENDERTARGET_HEIGHT,
        );
        glu::expect_no_error(gl, "RenderBufferStorage")?;

        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
        glu::expect_no_error(gl, "BindFrameBuffer")?;

        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rbo.get(),
        );
        glu::expect_no_error(gl, "FrameBufferRenderBuffer")?;

        let draw_buffer: glw::GLenum = glw::GL_COLOR_ATTACHMENT0;
        gl.draw_buffers(1, &draw_buffer);
        glu::expect_no_error(gl, "DrawBuffers")?;

        let clear_color: [f32; 4] = [0.0, 0.0, 0.0, 0.0];
        gl.clear_bufferfv(glw::GL_COLOR, 0, clear_color.as_ptr());
        glu::expect_no_error(gl, "ClearBuffers")?;

        gl.viewport(0, 0, RENDERTARGET_WIDTH, RENDERTARGET_HEIGHT);
        glu::expect_no_error(gl, "Viewport")?;
    }
    Ok(())
}

impl TestCase for GlslVectorConstructorTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let fbo = glu::Framebuffer::new(gl);
        let rbo = glu::Renderbuffer::new(gl);

        setup_render_target(gl, &fbo, &rbo)?;

        let sources = ProgramSources::vtx_frag(self.vertex_shader.clone(), self.fragment_shader.clone());
        let program = match self.test_type {
            TestType::VertexShaderError | TestType::FragmentShaderError => {
                ShaderProgram::new_expecting_build_failure(gl, &sources)
            }
            TestType::VertexShader | TestType::FragmentShader => {
                ShaderProgram::new_reporting_build_failure(gl, &sources)
            }
        };
        if !program.is_ok() {
            return match self.test_type {
                TestType::VertexShaderError | TestType::FragmentShaderError => Ok(TestStatus::pass("Pass")),
                _ => Err(TestError::Fail(format!(
                    "Shader compilation failed:\nVertex shader:\n{}\nFragment shader:\n{}",
                    self.vertex_shader, self.fragment_shader
                ))),
            };
        }

        let vertex_arrays = [va::float("vPosition", 2, (POSITIONS.len() / 2) as i32, 0, &POSITIONS)];

        // SAFETY: a program that built.
        unsafe { gl.use_program(program.program()) };
        glu::expect_no_error(gl, "glUseProgram failed")?;

        // SAFETY: a clear of the bound frame buffer.
        unsafe { gl.clear(glw::GL_COLOR_BUFFER_BIT) };

        glu::draw(
            &context.render_context,
            program.program(),
            &vertex_arrays,
            &pr::triangle_strip(&INDICES),
        )?;

        let mut fb_data = vec![0u8; (RENDERTARGET_WIDTH * RENDERTARGET_HEIGHT * 4) as usize];
        // SAFETY: `fb_data` holds width x height RGBA8 pixels, which is what is read back.
        unsafe {
            gl.read_pixels(
                0,
                0,
                RENDERTARGET_WIDTH,
                RENDERTARGET_HEIGHT,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                fb_data.as_mut_ptr().cast(),
            );
        }
        glu::expect_no_error(gl, "glReadPixels")?;

        let expected_color = [0u8, 255, 0, 255];
        let pass = fb_data.chunks_exact(4).all(|pixel| *pixel == expected_color);

        if pass {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Pixel mismatch; vector initialization failed"))
        }
    }
}

/// `GLSLVectorConstructorTests`
pub fn create_tests(glsl_version: GlslVersion) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("glsl_constructors");
    for params in generate_test_params() {
        group.add_child(Box::new(GlslVectorConstructorTestCase::new(glsl_version, &params)) as Box<dyn TestCase>);
    }
    group
}
