// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cGPUShaderFP64Tests.cpp (GPUShaderFP64Test9)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `getMatrixMultiplicationResult`'s nine copies of the same product are one loop over the GLSL matrices.

use std::ffi::CString;

use super::types::{ALL_TYPES, DoubleType, post_matrix_multiplication_type};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum OperationType {
    Addition,
    Division,
    Multiplication,
    Subtraction,
    PreDecrementation,
    PreIncrementation,
    PostDecrementation,
    PostIncrementation,
}

const OPERATION_TYPES: [OperationType; 8] = [
    OperationType::Addition,
    OperationType::Division,
    OperationType::Multiplication,
    OperationType::Subtraction,
    OperationType::PreDecrementation,
    OperationType::PreIncrementation,
    OperationType::PostDecrementation,
    OperationType::PostIncrementation,
];

impl OperationType {
    /// `getOperatorForOperationType`
    fn operator(self) -> &'static str {
        match self {
            Self::Addition => "+",
            Self::Division => "/",
            Self::Multiplication => "*",
            Self::Subtraction => "-",
            Self::PreDecrementation | Self::PostDecrementation => "--",
            Self::PreIncrementation | Self::PostIncrementation => "++",
        }
    }

    /// `getOperationTypeString`
    fn label(self) -> &'static str {
        match self {
            Self::Addition => "addition",
            Self::Division => "division",
            Self::Multiplication => "multiplication",
            Self::Subtraction => "subtraction",
            Self::PreDecrementation => "pre-decrementation",
            Self::PreIncrementation => "pre-incrementation",
            Self::PostDecrementation => "post-decrementation",
            Self::PostIncrementation => "post-incrementation",
        }
    }

    fn is_pre(self) -> bool {
        matches!(self, Self::PreDecrementation | Self::PreIncrementation)
    }

    fn is_post(self) -> bool {
        matches!(self, Self::PostDecrementation | Self::PostIncrementation)
    }
}

/// `GPUShaderFP64Test9::_test_case`
struct TestCaseDescriptor {
    operation_type: OperationType,
    result_variable_type: DoubleType,
    variable_type: DoubleType,
}

/// `getMatrixMultiplicationResult`: `a * b` for matrices whose data is given in the order the GLSL constructor takes it (column by column), returned the same way.
fn matrix_multiplication_result(a_type: DoubleType, a_data: &[f64], b_type: DoubleType, b_data: &[f64]) -> Vec<f64> {
    let (a_rows, a_columns) = (a_type.rows as usize, a_type.columns as usize);
    let (b_rows, b_columns) = (b_type.rows as usize, b_type.columns as usize);
    assert_eq!(a_columns, b_rows, "the matrices are not multipliable");

    let mut result = vec![0.0; a_rows * b_columns];
    for column in 0..b_columns {
        for row in 0..a_rows {
            result[column * a_rows + row] = (0..a_columns)
                .map(|k| a_data[k * a_rows + row] * b_data[column * b_rows + k])
                .sum();
        }
    }
    result
}

fn constructor_values(count: u32, value: impl Fn(u32) -> i64) -> String {
    (0..count)
        .map(|component| value(component).to_string())
        .collect::<Vec<_>>()
        .join(", ")
}

/// `getVertexShaderBody`
fn vertex_shader_body(test_case: &mut TestCaseDescriptor) -> String {
    let variable_type = test_case.variable_type;
    let n_variable_components = variable_type.components();
    let mut result_variable_type_string = variable_type.name.to_string();

    // If we are to multiply matrices, we will need to use a different type for the result variable if either of the matrices is not square.
    if test_case.operation_type == OperationType::Multiplication && variable_type.is_matrix() {
        let result_variable_type = post_matrix_multiplication_type(variable_type, variable_type.transposed());
        result_variable_type_string = result_variable_type.name.to_string();
        test_case.result_variable_type = result_variable_type;
    }

    let mut result = format!(
        "#version 400\n\nout {result_variable_type_string} result;\nout ivec2 result_lt;\nout ivec2 result_lte;\nout ivec2 result_gt;\nout ivec2 result_gte;\nvoid main()\n{{\n"
    );

    // Form reference values
    result.push_str(&format!(
        "{0} reference1 = {0}({1});\n",
        variable_type.name,
        constructor_values(n_variable_components, |n| i64::from(n) + 1)
    ));

    // single- and double-precision cases
    for n_ref2_case in 0..2 {
        let mut compatible_variable_type = variable_type;
        if compatible_variable_type.is_matrix() && test_case.operation_type == OperationType::Multiplication {
            compatible_variable_type = compatible_variable_type.transposed();
        }

        let ref2_variable_type = if n_ref2_case == 0 {
            compatible_variable_type.fp_name()
        } else {
            compatible_variable_type.name.to_string()
        };
        let ref2_variable_name = if n_ref2_case == 0 { "reference2f" } else { "reference2" };
        result.push_str(&format!(
            "{ref2_variable_type} {ref2_variable_name} = {ref2_variable_type}({});\n",
            constructor_values(n_variable_components, |n| i64::from(n_variable_components)
                - (i64::from(n) + 1))
        ));
    }

    // Add actual body
    result.push_str("\nresult = ");
    let operation_type = test_case.operation_type;
    if operation_type.is_pre() {
        result.push_str(operation_type.operator());
    }
    result.push_str("reference1 ");
    if operation_type.is_pre() || operation_type.is_post() {
        if operation_type.is_post() {
            result.push_str(operation_type.operator());
        }
    } else {
        result.push_str(&format!("{} reference2", operation_type.operator()));
    }
    result.push_str(";\n");

    if variable_type.is_scalar() {
        result.push_str(
            "result_lt [0] = (reference1 <  reference2)  ? 1 : 0;\nresult_lt [1] = (reference1 <  reference2f) ? 1 : 0;\nresult_lte[0] = (reference1 <= reference2)  ? 1 : 0;\nresult_lte[1] = (reference1 <= reference2f) ? 1 : 0;\nresult_gt [0] = (reference1 >  reference2)  ? 1 : 0;\nresult_gt [1] = (reference1 >  reference2f) ? 1 : 0;\nresult_gte[0] = (reference1 >= reference2)  ? 1 : 0;\nresult_gte[1] = (reference1 >= reference2f) ? 1 : 0;\n",
        );
    } else {
        result.push_str("result_lt [0] = 1;\nresult_lt [1] = 1;\nresult_lte[0] = 1;\nresult_lte[1] = 1;\nresult_gt [0] = 1;\nresult_gt [1] = 1;\nresult_gte[0] = 1;\nresult_gte[1] = 1;\n");
    }

    result.push_str("}\n");
    result
}

/// `verifyXFBData`
fn verify_xfb_data(test_case: &TestCaseDescriptor, xfb_data: &[u8]) -> bool {
    const EPSILON: f64 = 1e-5;
    let n_result_components = test_case.result_variable_type.components() as usize;
    let mut result = true;

    let xfb_double = |index: usize| f64::from_ne_bytes(xfb_data[index * 8..index * 8 + 8].try_into().expect("8 bytes"));
    let int_base = n_result_components * 8;
    let xfb_int = |index: usize| {
        i32::from_ne_bytes(
            xfb_data[int_base + index * 4..int_base + index * 4 + 4]
                .try_into()
                .expect("4 bytes"),
        )
    };
    // result_lt, result_lte, result_gt and result_gte are two ints each, one for the double-precision and one for the cast comparison
    let (lt, lte, gt, gte) = (
        [xfb_int(0), xfb_int(1)],
        [xfb_int(2), xfb_int(3)],
        [xfb_int(4), xfb_int(5)],
        [xfb_int(6), xfb_int(7)],
    );

    // Prepare reference values
    let modifier: i64 = match test_case.operation_type {
        OperationType::PreIncrementation | OperationType::PostIncrementation => 1,
        OperationType::PreDecrementation | OperationType::PostDecrementation => -1,
        _ => 0,
    };
    let variable_type = test_case.variable_type;
    let mut reference1: Vec<f64> = Vec::new();
    let mut reference2: Vec<f64> = Vec::new();

    if variable_type.is_matrix() {
        // Matrices may be of different sizes so we need to compute the reference values separately for each matrix
        let matrix_a_type = variable_type;
        let matrix_b_type = variable_type.transposed();
        let n_matrix_a_components = matrix_a_type.components() as i64;
        let n_matrix_b_components = matrix_b_type.components() as i64;

        reference1.extend((0..n_matrix_a_components).map(|n| (modifier + n + 1) as f64));
        reference2.extend((0..n_matrix_b_components).map(|n| (n_matrix_b_components - (n + 1)) as f64));
    } else {
        // Generate as many components as will be expected for the result variable
        for n_result_component in 0..n_result_components as i64 {
            reference1.push((modifier + n_result_component + 1) as f64);
            reference2.push((n_result_components as i64 - (n_result_component + 1)) as f64);
        }
    }

    // Verify the result value(s)
    if test_case.operation_type == OperationType::Multiplication && variable_type.is_matrix() {
        // Matrix multiplication
        let matrix_a_type = variable_type;
        let matrix_b_type = variable_type.transposed();
        let expected_result_data = matrix_multiplication_result(matrix_a_type, &reference1, matrix_b_type, &reference2);

        for n_component in 0..n_result_components {
            if (xfb_double(n_component) - expected_result_data[n_component]).abs() > EPSILON {
                let expected: Vec<String> = expected_result_data[..n_result_components]
                    .iter()
                    .map(f64::to_string)
                    .collect();
                let retrieved: Vec<String> = (0..n_result_components).map(|n| xfb_double(n).to_string()).collect();
                log::info!(
                    "Data returned for {} * {} matrix multiplication was incorrect; expected:({}), retrieved:({})",
                    matrix_a_type.name,
                    matrix_b_type.name,
                    expected.join(", "),
                    retrieved.join(", ")
                );
                result = false;
                break;
            }
        }
    } else {
        for n_component in 0..n_result_components {
            let mut expected_value = reference1[n_component];
            match test_case.operation_type {
                OperationType::Addition => expected_value += reference2[n_component],
                OperationType::Division => expected_value /= reference2[n_component],
                OperationType::Multiplication => expected_value *= reference2[n_component],
                OperationType::Subtraction => expected_value -= reference2[n_component],
                // Modifier already applied
                OperationType::PreDecrementation | OperationType::PreIncrementation => {}
                // Need to reverse the modification for the purpose of the following check
                OperationType::PostDecrementation | OperationType::PostIncrementation => {
                    expected_value -= modifier as f64
                }
            }

            if (xfb_double(n_component) - expected_value).abs() > EPSILON {
                log::info!(
                    "Value(s) generated for variable type [{}] and operation type [{}] were found invalid.",
                    variable_type.name,
                    test_case.operation_type.label()
                );
                result = false;
                break;
            }
        }
    }

    // Verify the comparison operation results
    if variable_type.is_scalar() {
        let (r1, r2) = (reference1[0], reference2[0]);
        let r2_cast = f64::from(r2 as f32);
        let expected_result_lt = [r1 < r2, r1 < r2_cast];
        let expected_result_lte = [r1 <= r2, r1 <= r2_cast];
        let expected_result_gt = [r1 > r2, r1 > r2_cast];
        let expected_result_gte = [r1 >= r2, r1 >= r2_cast];

        let operation = test_case.operation_type.label();
        let checks: [(&str, [i32; 2], [bool; 2]); 4] = [
            ("lower-than", lt, expected_result_lt),
            ("lower-than-or-equal", lte, expected_result_lte),
            ("greater-than", gt, expected_result_gt),
            ("greater-than-or-equal", gte, expected_result_gte),
        ];
        for (name, found, expected) in checks {
            if (found[0] != 0) != expected[0] || (found[1] != 0) != expected[1] {
                // Upstream reports the lower-than values in all four messages.
                log::info!(
                    "Values reported for {name} operator used for variable type [{}]and operation type [{operation}]was found invalid; expected:({}, {}); found:({}, {}).",
                    variable_type.name,
                    expected_result_lt[0],
                    expected_result_lt[1],
                    lt[0],
                    lt[1]
                );
                result = false;
            }
        }
    } else if lt != [1, 1] || lte != [1, 1] || gt != [1, 1] || gte != [1, 1] {
        log::info!(
            "Invalid value was reported for matrix variable type, for which  operator checks are not executed; variable type [{}]and operation type [{}]",
            variable_type.name,
            test_case.operation_type.label()
        );
        result = false;
    }

    result
}

/// `GPUShaderFP64Test9`
pub(super) struct Operators;

#[derive(Default)]
struct Resources {
    po_id: GLuint,
    xfb_bo_id: GLuint,
    vao_id: GLuint,
    vs_id: GLuint,
}

impl Operators {
    /// `initTest`
    fn init_test(context: &Context, resources: &mut Resources) -> Result<(), TestError> {
        let gl = context.gl();

        // Create program & vertex shader objects
        resources.po_id = gl!(gl.create_program());
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateProgram() or glCreateShader() call failed.")?;

        // Attach the shader to the program
        gl!(gl.attach_shader(resources.po_id, resources.vs_id));
        glu::expect_no_error(gl, "glAttachShader() call failed.")?;

        // Set up a buffer object
        gl!(gl.gen_buffers(1, &mut resources.xfb_bo_id));
        glu::expect_no_error(gl, "glGenBuffers() call failed.")?;
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, resources.xfb_bo_id));
        glu::expect_no_error(gl, "glBindBuffer() call failed.")?;
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.xfb_bo_id));
        glu::expect_no_error(gl, "glBindBufferBase() call failed.")?;

        // Set up a vertex array object
        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        glu::expect_no_error(gl, "glGenVertexArrays() call failed.")?;
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "glBindVertexArray() call failed.")
    }

    /// `initTestIteration`
    fn init_test_iteration(
        context: &Context,
        resources: &Resources,
        test_case: &mut TestCaseDescriptor,
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let vs_body = vertex_shader_body(test_case);

        // Try to compile the shader
        let source = CString::new(vs_body).expect("shader source holds no nul byte");
        let sources = [source.as_ptr()];
        gl!(gl.shader_source(resources.vs_id, 1, sources.as_ptr(), std::ptr::null()));
        glu::expect_no_error(gl, "glShaderSource() call failed.")?;
        gl!(gl.compile_shader(resources.vs_id));
        glu::expect_no_error(gl, "glCompileShader() call failed.")?;

        let mut compile_status = glw::GL_FALSE as glw::GLint;
        gl!(gl.get_shaderiv(resources.vs_id, glw::GL_COMPILE_STATUS, &mut compile_status));
        glu::expect_no_error(gl, "glGetShaderiv() call failed.")?;
        if compile_status != glw::GL_TRUE as glw::GLint {
            return Err(TestError::Fail("Test shader compilation failed.".to_string()));
        }

        // Configure XFB
        let xfb_names: Vec<CString> = ["result", "result_lt", "result_lte", "result_gt", "result_gte"]
            .iter()
            .map(|name| CString::new(*name).expect("no nul byte"))
            .collect();
        let xfb_name_pointers: Vec<*const glw::GLchar> = xfb_names.iter().map(|name| name.as_ptr()).collect();
        gl!(gl.transform_feedback_varyings(
            resources.po_id,
            xfb_name_pointers.len() as glw::GLsizei,
            xfb_name_pointers.as_ptr(),
            glw::GL_INTERLEAVED_ATTRIBS
        ));
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() call failed.")?;

        // Try to link the program
        let mut link_status = glw::GL_FALSE as glw::GLint;
        gl!(gl.link_program(resources.po_id));
        glu::expect_no_error(gl, "glLinkProgram() call failed.")?;
        gl!(gl.get_programiv(resources.po_id, glw::GL_LINK_STATUS, &mut link_status));
        glu::expect_no_error(gl, "glGetProgramiv() call failed.")?;
        if link_status != glw::GL_TRUE as glw::GLint {
            return Err(TestError::Fail("Test program linking failure".to_string()));
        }

        // Set up XFB BO data storage
        let result_variable_size = test_case.result_variable_type.components() as usize * std::mem::size_of::<f64>();
        let xfb_bo_size = result_variable_size + std::mem::size_of::<i32>() * 2 /* ivec2s */ * 4; /* result_ output variables */
        gl!(gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            xfb_bo_size as isize,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "glBufferData() call failed.")
    }

    /// `executeTestIteration`
    fn execute_test_iteration(
        context: &Context,
        resources: &Resources,
        test_case: &TestCaseDescriptor,
    ) -> Result<bool, TestError> {
        let gl = context.gl();

        gl!(gl.use_program(resources.po_id));
        glu::expect_no_error(gl, "glUseProgram() call failed.")?;

        // Draw a single point with XFB enabled
        gl!(gl.begin_transform_feedback(glw::GL_POINTS));
        glu::expect_no_error(gl, "glBeginTransformFeedback() call failed.")?;
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
        glu::expect_no_error(gl, "glDrawArrays() call failed.")?;
        gl!(gl.end_transform_feedback());
        glu::expect_no_error(gl, "glEndTransformFeedback() call failed.")?;

        // Map the XFB BO into process space
        let xfb_data_ptr = gl!(gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY)).cast::<u8>();
        glu::expect_no_error(gl, "glMapBuffer() call failed.")?;
        if xfb_data_ptr.is_null() {
            return Err(TestError::Fail("glMapBuffer() returned NULL.".to_string()));
        }

        let size = test_case.result_variable_type.components() as usize * std::mem::size_of::<f64>()
            + std::mem::size_of::<i32>() * 2 * 4;
        // SAFETY: the buffer holds `size` bytes (see `init_test_iteration`) and stays mapped until the unmap below.
        let xfb_data = unsafe { std::slice::from_raw_parts(xfb_data_ptr, size) }.to_vec();
        let result = verify_xfb_data(test_case, &xfb_data);

        gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
        glu::expect_no_error(gl, "glUnmapBuffer() call failed.")?;
        Ok(result)
    }

    fn run(context: &Context, resources: &mut Resources) -> Result<bool, TestError> {
        let mut has_test_passed = true;

        Self::init_test(context, resources)?;

        // Iterate through all variable types we want to test
        for variable_type in ALL_TYPES {
            // Iterate through all operation types we want to check
            for operation_type in OPERATION_TYPES {
                let mut test_case = TestCaseDescriptor {
                    operation_type,
                    result_variable_type: variable_type,
                    variable_type,
                };

                Self::init_test_iteration(context, resources, &mut test_case)?;
                has_test_passed &= Self::execute_test_iteration(context, resources, &test_case)?;
            }
        }
        Ok(has_test_passed)
    }
}

impl TestCase for Operators {
    fn name(&self) -> &str {
        "operators"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        if !context.context_info.is_extension_supported("GL_ARB_gpu_shader_fp64") {
            return Err(TestError::NotSupported(
                "GL_ARB_gpu_shader_fp64 is not supported.".to_string(),
            ));
        }

        let gl = context.gl();
        let mut resources = Resources::default();
        let result = Self::run(context, &mut resources);

        // deinit
        if resources.po_id != 0 {
            gl!(gl.delete_program(resources.po_id));
        }
        if resources.xfb_bo_id != 0 {
            gl!(gl.delete_buffers(1, &resources.xfb_bo_id));
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        if resources.vs_id != 0 {
            gl!(gl.delete_shader(resources.vs_id));
        }

        Ok(if result? {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}
