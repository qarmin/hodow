// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cGPUShaderFP64Tests.cpp (GPUShaderFP64Test1)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The seventeen-case `switch` that every `verifyErrorGeneration...` function repeats is `UniformFunction::call`, and the 57 `m_po_*_uniform_location` members are the `locations` table (type name, plain location, array location). The scalar arguments of `glUniform{1,2,3,4}d` are always 0, 1, 2, 3 (upstream sometimes takes them from its data array; none of the checks reads them). The vertex shader is generated (scripts/gen_khr_fp64_state_query_shaders.py). The program and shader are `Drop`ped.

use std::ffi::CString;

use super::errors_shaders::VS_BODY;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLsizei, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const DOUBLE_DATA: [f64; 16] = [
    1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0,
];

/// `_uniform_function`
#[derive(Clone, Copy, PartialEq)]
enum UniformFunction {
    D1,
    D2,
    D3,
    D4,
    Dv1,
    Dv2,
    Dv3,
    Dv4,
    Matrix2,
    Matrix2x3,
    Matrix2x4,
    Matrix3,
    Matrix3x2,
    Matrix3x4,
    Matrix4,
    Matrix4x2,
    Matrix4x3,
}

use UniformFunction::*;

/// `UNIFORM_FUNCTION_FIRST` .. `UNIFORM_FUNCTION_COUNT`
const ALL_FUNCTIONS: [UniformFunction; 17] = [
    D1, D2, D3, D4, Dv1, Dv2, Dv3, Dv4, Matrix2, Matrix2x3, Matrix2x4, Matrix3, Matrix3x2, Matrix3x4, Matrix4,
    Matrix4x2, Matrix4x3,
];

/// The `*dv()` and `glUniformMatrix*()` functions, in the order of the arrays of upstream's count checks
const VECTOR_AND_MATRIX_FUNCTIONS: [UniformFunction; 13] = [
    Dv1, Dv2, Dv3, Dv4, Matrix2, Matrix2x3, Matrix2x4, Matrix3, Matrix3x2, Matrix3x4, Matrix4, Matrix4x2, Matrix4x3,
];

impl UniformFunction {
    /// `getUniformFunctionString`
    fn name(self) -> &'static str {
        match self {
            D1 => "glUniform1d",
            Dv1 => "glUniform1dv",
            D2 => "glUniform2d",
            Dv2 => "glUniform2dv",
            D3 => "glUniform3d",
            Dv3 => "glUniform3dv",
            D4 => "glUniform4d",
            Dv4 => "glUniform4dv",
            Matrix2 => "glUniformMatrix2dv",
            Matrix2x3 => "glUniformMatrix2x3dv",
            Matrix2x4 => "glUniformMatrix2x4dv",
            Matrix3 => "glUniformMatrix3dv",
            Matrix3x2 => "glUniformMatrix3x2dv",
            Matrix3x4 => "glUniformMatrix3x4dv",
            Matrix4 => "glUniformMatrix4dv",
            Matrix4x2 => "glUniformMatrix4x2dv",
            Matrix4x3 => "glUniformMatrix4x3dv",
        }
    }

    /// `isMatrixUniformFunction`
    fn is_matrix(self) -> bool {
        matches!(
            self,
            Matrix2 | Matrix2x3 | Matrix2x4 | Matrix3 | Matrix3x2 | Matrix3x4 | Matrix4 | Matrix4x2 | Matrix4x3
        )
    }

    /// The name of the uniform type this function is meant for
    fn matching_type(self) -> &'static str {
        match self {
            D1 | Dv1 => "double",
            D2 | Dv2 => "dvec2",
            D3 | Dv3 => "dvec3",
            D4 | Dv4 => "dvec4",
            Matrix2 => "dmat2",
            Matrix2x3 => "dmat2x3",
            Matrix2x4 => "dmat2x4",
            Matrix3 => "dmat3",
            Matrix3x2 => "dmat3x2",
            Matrix3x4 => "dmat3x4",
            Matrix4 => "dmat4",
            Matrix4x2 => "dmat4x2",
            Matrix4x3 => "dmat4x3",
        }
    }

    /// The `switch` every check repeats: the call itself, with `count` for the `*dv()` and matrix forms.
    fn call(self, gl: &glw::Functions, location: GLint, count: GLsizei) {
        let data = DOUBLE_DATA.as_ptr();
        match self {
            D1 => gl!(gl.uniform_1d(location, 0.0)),
            D2 => gl!(gl.uniform_2d(location, 0.0, 1.0)),
            D3 => gl!(gl.uniform_3d(location, 0.0, 1.0, 2.0)),
            D4 => gl!(gl.uniform_4d(location, 0.0, 1.0, 2.0, 3.0)),
            Dv1 => gl!(gl.uniform_1dv(location, count, data)),
            Dv2 => gl!(gl.uniform_2dv(location, count, data)),
            Dv3 => gl!(gl.uniform_3dv(location, count, data)),
            Dv4 => gl!(gl.uniform_4dv(location, count, data)),
            Matrix2 => gl!(gl.uniform_matrix_2dv(location, count, glw::FALSE, data)),
            Matrix2x3 => gl!(gl.uniform_matrix_2x_3dv(location, count, glw::FALSE, data)),
            Matrix2x4 => gl!(gl.uniform_matrix_2x_4dv(location, count, glw::FALSE, data)),
            Matrix3 => gl!(gl.uniform_matrix_3dv(location, count, glw::FALSE, data)),
            Matrix3x2 => gl!(gl.uniform_matrix_3x_2dv(location, count, glw::FALSE, data)),
            Matrix3x4 => gl!(gl.uniform_matrix_3x_4dv(location, count, glw::FALSE, data)),
            Matrix4 => gl!(gl.uniform_matrix_4dv(location, count, glw::FALSE, data)),
            Matrix4x2 => gl!(gl.uniform_matrix_4x_2dv(location, count, glw::FALSE, data)),
            Matrix4x3 => gl!(gl.uniform_matrix_4x_3dv(location, count, glw::FALSE, data)),
        }
    }
}

/// The type names of every uniform the vertex shader declares, besides the sampler.
const UNIFORM_TYPES: [&str; 29] = [
    "bool", "bvec2", "bvec3", "bvec4", "dmat2", "dmat2x3", "dmat2x4", "dmat3", "dmat3x2", "dmat3x4", "dmat4",
    "dmat4x2", "dmat4x3", "double", "dvec2", "dvec3", "dvec4", "float", "int", "ivec2", "ivec3", "ivec4", "uint",
    "uvec2", "uvec3", "uvec4", "vec2", "vec3", "vec4",
];

/// The locations of the `m_po_*_uniform_location` members
struct Locations {
    /// (type name, location of the plain uniform, location of the array uniform), in `UNIFORM_TYPES` order
    uniforms: Vec<(&'static str, GLint, GLint)>,
    sampler: GLint,
}

impl Locations {
    fn single(&self, type_name: &str) -> GLint {
        self.uniforms
            .iter()
            .find(|entry| entry.0 == type_name)
            .expect("a declared uniform type")
            .1
    }

    fn array(&self, type_name: &str) -> GLint {
        self.uniforms
            .iter()
            .find(|entry| entry.0 == type_name)
            .expect("a declared uniform type")
            .2
    }

    fn singles(&self, type_names: &[&str]) -> Vec<GLint> {
        type_names.iter().map(|type_name| self.single(type_name)).collect()
    }

    /// `getUniformNameForLocation`
    fn name_for(&self, location: GLint) -> String {
        for (type_name, single, array) in &self.uniforms {
            if location == *array {
                return format!("uniform_{type_name}_arr");
            }
            if location == *single {
                return format!("uniform_{type_name}");
            }
        }
        "[?]".to_string()
    }

    /// `isMatrixUniform`
    fn is_matrix(&self, location: GLint) -> bool {
        [
            "dmat2", "dmat2x3", "dmat2x4", "dmat3", "dmat3x2", "dmat3x4", "dmat4", "dmat4x2", "dmat4x3",
        ]
        .iter()
        .any(|type_name| self.single(type_name) == location)
    }
}

/// `GPUShaderFP64Test1`'s program and vertex shader; `deinit` is `Drop`.
struct State<'a> {
    gl: &'a glw::Functions,
    po_id: GLuint,
    vs_id: GLuint,
    locations: Locations,
}

impl Drop for State<'_> {
    fn drop(&mut self) {
        let gl = self.gl;
        if self.po_id != 0 {
            gl!(gl.delete_program(self.po_id));
        }
        if self.vs_id != 0 {
            gl!(gl.delete_shader(self.vs_id));
        }
    }
}

/// `glGetError`, the way every check reads the verdict of the call it just made
fn get_error(gl: &glw::Functions) -> GLenum {
    gl!(gl.get_error())
}

impl<'a> State<'a> {
    /// `initTest`
    fn new(gl: &'a glw::Functions) -> Result<Self, TestError> {
        let mut state = Self {
            gl,
            po_id: 0,
            vs_id: 0,
            locations: Locations {
                uniforms: Vec::new(),
                sampler: -1,
            },
        };

        state.po_id = gl!(gl.create_program());
        state.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateProgram / glCreateShader")?;

        let source = CString::new(VS_BODY).expect("shader source holds no nul byte");
        let sources = [source.as_ptr()];
        gl_call!(
            gl,
            "glShaderSource",
            gl.shader_source(state.vs_id, 1, sources.as_ptr(), std::ptr::null())
        );
        gl_call!(gl, "glCompileShader", gl.compile_shader(state.vs_id));

        let mut compile_status: GLint = glw::GL_FALSE as GLint;
        gl_call!(
            gl,
            "glGetShaderiv",
            gl.get_shaderiv(state.vs_id, glw::GL_COMPILE_STATUS, &mut compile_status)
        );
        if compile_status != glw::GL_TRUE as GLint {
            return Err(TestError::Fail("Shader compilation failed.".to_string()));
        }

        gl_call!(gl, "glAttachShader", gl.attach_shader(state.po_id, state.vs_id));
        gl_call!(gl, "glLinkProgram", gl.link_program(state.po_id));

        let mut link_status: GLint = glw::GL_FALSE as GLint;
        gl_call!(
            gl,
            "glGetProgramiv",
            gl.get_programiv(state.po_id, glw::GL_LINK_STATUS, &mut link_status)
        );
        if link_status != glw::GL_TRUE as GLint {
            return Err(TestError::Fail("Program linking failed.".to_string()));
        }

        let locate = |name: String| -> Result<GLint, TestError> {
            let name = CString::new(name).expect("no nul byte");
            let location = gl!(gl.get_uniform_location(state.po_id, name.as_ptr()));
            glu::expect_no_error(gl, "glGetUniformLocation")?;
            Ok(location)
        };

        let mut uniforms = Vec::new();
        for type_name in UNIFORM_TYPES {
            uniforms.push((
                type_name,
                locate(format!("uniform_{type_name}"))?,
                locate(format!("uniform_{type_name}_arr[0]"))?,
            ));
        }
        let sampler = locate("uniform_sampler".to_string())?;

        if sampler == -1 || uniforms.iter().any(|entry| entry.1 == -1 || entry.2 == -1) {
            return Err(TestError::Fail(
                "At last one of the required uniforms is considered inactive.".to_string(),
            ));
        }

        state.locations = Locations { uniforms, sampler };
        Ok(state)
    }

    /// `verifyErrorGenerationWhenUniformFunctionsCalledWithoutActivePO`
    fn verify_error_generation_when_uniform_functions_called_without_active_po(&self) -> bool {
        let gl = self.gl;
        let mut result = true;

        for function in ALL_FUNCTIONS {
            function.call(gl, self.locations.single(function.matching_type()), 1);

            let error_code = get_error(gl);
            if error_code != glw::GL_INVALID_OPERATION {
                log::info!(
                    "Implementation did not return GL_INVALID_OPERATION when {}() was called without an active program object",
                    function.name()
                );
                result = false;
            }
        }
        result
    }

    /// `verifyErrorGenerationWhenCallingSizeMismatchedUniformFunctions`
    fn verify_error_generation_when_calling_size_mismatched_uniform_functions(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut result = true;

        // (function, uniform type, count)
        let checks: [(UniformFunction, &str, GLsizei); 24] = [
            (D2, "double", 0),
            (Dv2, "double", 2),
            (D3, "double", 0),
            (Dv3, "double", 2),
            (D4, "double", 0),
            (Dv4, "double", 2),
            (D1, "dvec2", 0),
            (Dv1, "dvec2", 2),
            (D3, "dvec2", 0),
            (Dv3, "dvec2", 2),
            (D4, "dvec2", 0),
            (Dv4, "dvec2", 2),
            (D1, "dvec3", 0),
            (Dv1, "dvec3", 2),
            (D2, "dvec3", 0),
            (Dv2, "dvec3", 2),
            (D4, "dvec3", 0),
            (Dv4, "dvec3", 2),
            (D1, "dvec4", 0),
            (Dv1, "dvec4", 2),
            (D2, "dvec4", 0),
            (Dv2, "dvec4", 2),
            (D3, "dvec4", 0),
            (Dv3, "dvec4", 2),
        ];

        gl_call!(gl, "glUseProgram", gl.use_program(self.po_id));

        for (n_check, (function, type_name, uniform_count)) in checks.into_iter().enumerate() {
            function.call(gl, self.locations.single(type_name), uniform_count);

            let error_code = get_error(gl);
            if error_code != glw::GL_INVALID_OPERATION {
                log::info!(
                    "{}() function did not generate GL_INVALID_OPERATION error when called for a uniform of incompatible size. (check index: {n_check})",
                    function.name()
                );
                result = false;
            }
        }
        Ok(result)
    }

    /// `verifyErrorGenerationWhenCallingTypeMismatchedUniformFunctions`
    fn verify_error_generation_when_calling_type_mismatched_uniform_functions(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut result = true;
        let nondouble_uniform_locations = self.locations.singles(&[
            "bool", "bvec2", "bvec3", "bvec4", "float", "int", "ivec2", "ivec3", "ivec4", "uint", "uvec2", "uvec3",
            "uvec4", "vec2", "vec3", "vec4",
        ]);

        gl_call!(gl, "glUseProgram", gl.use_program(self.po_id));

        for uniform_location in nondouble_uniform_locations {
            for function in ALL_FUNCTIONS {
                function.call(gl, uniform_location, 1);

                let error_code = get_error(gl);
                if error_code != glw::GL_INVALID_OPERATION {
                    log::info!(
                        "{}() function did not generate GL_INVALID_OPERATION error when called for a uniform of incompatible type.",
                        function.name()
                    );
                    result = false;
                }
            }
        }
        Ok(result)
    }

    /// `verifyErrorGenerationWhenCallingMismatchedDoubleUniformFunctions`
    fn verify_error_generation_when_calling_mismatched_double_uniform_functions(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut result = true;
        let double_uniform_types = [
            "dmat2", "dmat2x3", "dmat2x4", "dmat3", "dmat3x2", "dmat3x4", "dmat4", "dmat4x2", "dmat4x3", "double",
            "dvec2", "dvec3", "dvec4",
        ];

        gl_call!(gl, "glUseProgram", gl.use_program(self.po_id));

        for type_name in double_uniform_types {
            let uniform_location = self.locations.single(type_name);

            for function in ALL_FUNCTIONS {
                // The function that is meant for the uniform's type is not an error
                if function.matching_type() == type_name {
                    continue;
                }

                function.call(gl, uniform_location, 1);

                let error_code = get_error(gl);
                if error_code != glw::GL_INVALID_OPERATION {
                    log::info!(
                        "Invalid error [{error_code}] was generated when a mismatched double-precision uniform function {}() was used to configure uniform {}.",
                        function.name(),
                        self.locations.name_for(uniform_location)
                    );
                    result = false;
                }
            }
        }
        Ok(result)
    }

    /// `verifyErrorGenerationWhenCallingDoubleUniformFunctionsWithInvalidLocation`
    fn verify_error_generation_when_calling_double_uniform_functions_with_invalid_location(&self) -> bool {
        let gl = self.gl;
        let mut result = true;

        let valid_uniform_location = self
            .locations
            .uniforms
            .iter()
            .flat_map(|entry| [entry.1, entry.2])
            .fold(-1, GLint::max);
        let invalid_uniform_location = valid_uniform_location + 1;

        for function in ALL_FUNCTIONS {
            function.call(gl, invalid_uniform_location, 1);

            let error_code = get_error(gl);
            if error_code != glw::GL_INVALID_OPERATION {
                log::info!(
                    "Function {}() did not generate an error when passed an invalid uniform location different from -1.",
                    function.name()
                );
                result = false;
            }
        }
        result
    }

    /// `verifyErrorGenerationWhenCallingDoubleUniformFunctionsWithNegativeCount`
    fn verify_error_generation_when_calling_double_uniform_functions_with_negative_count(&self) -> bool {
        let gl = self.gl;
        let mut result = true;

        for function in VECTOR_AND_MATRIX_FUNCTIONS {
            function.call(gl, self.locations.array(function.matching_type()), -1);

            let error_code = get_error(gl);
            if error_code != glw::GL_INVALID_VALUE {
                log::info!(
                    "Function {}() was called with a negative count argument but did not generate a GL_INVALID_VALUE error",
                    function.name()
                );
                result = false;
            }
        }
        result
    }

    /// `verifyErrorGenerationWhenCallingDoubleUniformFunctionsWithInvalidCount`
    fn verify_error_generation_when_calling_double_uniform_functions_with_invalid_count(&self) -> bool {
        let gl = self.gl;
        let mut result = true;

        for function in VECTOR_AND_MATRIX_FUNCTIONS {
            for type_name in UNIFORM_TYPES {
                let uniform_location = self.locations.single(type_name);
                let is_matrix_uniform = self.locations.is_matrix(uniform_location);

                if is_matrix_uniform != function.is_matrix() {
                    continue;
                }

                function.call(gl, uniform_location, 2);

                let error_code = get_error(gl);
                if error_code != glw::GL_INVALID_OPERATION {
                    log::info!(
                        "Function {}() was called with an invalid count argument but did not generate a GL_INVALID_OPERATION error",
                        function.name()
                    );
                    result = false;
                }
            }
        }
        result
    }

    /// `verifyErrorGenerationWhenCallingDoubleUniformFunctionsForSamplers`
    fn verify_error_generation_when_calling_double_uniform_functions_for_samplers(&self) -> bool {
        let gl = self.gl;
        let mut result = true;

        for function in ALL_FUNCTIONS {
            function.call(gl, self.locations.sampler, 1);

            let error_code = get_error(gl);
            if error_code != glw::GL_INVALID_OPERATION {
                log::info!(
                    "Function {}() did not generate an error when applied against a sampler uniform.",
                    function.name()
                );
                result = false;
            }
        }
        result
    }

    /// `verifyErrorGenerationWhenCallingDoubleUniformFunctionsForBooleans`
    fn verify_error_generation_when_calling_double_uniform_functions_for_booleans(&self) -> bool {
        let gl = self.gl;
        let mut result = true;
        let uniform_locations: Vec<GLint> = ["bool", "bvec2", "bvec3", "bvec4"]
            .into_iter()
            .flat_map(|type_name| [self.locations.array(type_name), self.locations.single(type_name)])
            .collect();

        for function in ALL_FUNCTIONS {
            for &uniform_location in &uniform_locations {
                function.call(gl, uniform_location, 1);

                let error_code = get_error(gl);
                if error_code != glw::GL_INVALID_OPERATION {
                    log::info!(
                        "Function {}() did not generate an error when applied against a boolean uniform.",
                        function.name()
                    );
                    result = false;
                }
            }
        }
        result
    }
}

/// `GPUShaderFP64Test1`
pub(super) struct Errors;

impl TestCase for Errors {
    fn name(&self) -> &str {
        "errors"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut has_test_passed = true;

        if !context.context_info.is_extension_supported("GL_ARB_gpu_shader_fp64") {
            return Err(TestError::NotSupported(
                "GL_ARB_gpu_shader_fp64 is not supported.".to_string(),
            ));
        }

        let state = State::new(gl)?;

        has_test_passed &= state.verify_error_generation_when_uniform_functions_called_without_active_po();
        has_test_passed &= state.verify_error_generation_when_calling_size_mismatched_uniform_functions()?;
        has_test_passed &= state.verify_error_generation_when_calling_type_mismatched_uniform_functions()?;
        has_test_passed &= state.verify_error_generation_when_calling_mismatched_double_uniform_functions()?;
        has_test_passed &= state.verify_error_generation_when_calling_double_uniform_functions_with_invalid_location();
        has_test_passed &= state.verify_error_generation_when_calling_double_uniform_functions_with_negative_count();
        has_test_passed &= state.verify_error_generation_when_calling_double_uniform_functions_with_invalid_count();
        has_test_passed &= state.verify_error_generation_when_calling_double_uniform_functions_for_samplers();
        has_test_passed &= state.verify_error_generation_when_calling_double_uniform_functions_for_booleans();

        Ok(if has_test_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}
