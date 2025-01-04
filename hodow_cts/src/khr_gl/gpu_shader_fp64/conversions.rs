// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cGPUShaderFP64Tests.cpp (GPUShaderFP64Test5)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. A Rust `as` cast from a negative float to `u32` is 0, which is also what the upstream comment about the expected values assumes.

use std::ffi::CString;

use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

/// The base values of the test spec
const BASE_VALUES: [f32; 5] = [-25.12065, 0.0, 0.001, 1.0, 256.789];

#[derive(Clone, Copy, PartialEq, Eq)]
enum BaseKind {
    Bool,
    Int,
    Uint,
    Float,
    Double,
}

/// `Utils::_variable_type`: the GLSL name, the shape and the base type
#[derive(Clone, Copy)]
struct Type {
    name: &'static str,
    columns: u32,
    rows: u32,
    base: BaseKind,
}

impl Type {
    fn components(self) -> usize {
        (self.columns * self.rows) as usize
    }

    fn is_matrix(self) -> bool {
        self.columns > 1
    }

    /// `getVariableTypeString(getBaseVariableType(type))`
    fn base_name(self) -> &'static str {
        match self.base {
            BaseKind::Bool => "bool",
            BaseKind::Int => "int",
            BaseKind::Uint => "uint",
            BaseKind::Float => "float",
            BaseKind::Double => "double",
        }
    }
}

const fn ty(name: &'static str, columns: u32, rows: u32, base: BaseKind) -> Type {
    Type {
        name,
        columns,
        rows,
        base,
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestCaseType {
    Explicit,
    Implicit,
}

struct TestCaseDescriptor {
    type_: TestCaseType,
    src_type: Type,
    dst_type: Type,
    shader_body: String,
}

/// `m_swizzle_matrix[dst components - 1][src components - 1]`, as the swizzle string ("" is `SWIZZLE_TYPE_NONE`)
const SWIZZLE_MATRIX: [[&str; 4]; 4] = [
    ["", "y", "z", "w"],
    ["", "yx", "zy", "wx"],
    ["", "yxx", "xzy", "xwzy"],
    ["", "yxxy", "xzxy", "xzyw"],
];

/// `getSwizzleTypeProperties`: the component indices a swizzle string selects
fn swizzle_component_order(swizzle_string: &str) -> Vec<usize> {
    swizzle_string
        .chars()
        .map(|component| match component {
            'x' => 0,
            'y' => 1,
            'z' => 2,
            'w' => 3,
            _ => unreachable!("only xyzw swizzles are used"),
        })
        .collect()
}

/// `getVertexShaderBody`
fn vertex_shader_body(test_case: &TestCaseDescriptor) -> String {
    let (src, dst) = (test_case.src_type, test_case.dst_type);
    let n_dst_components = dst.components();
    let n_src_components = src.components();

    let mut result = String::from("#version 420\n\n");

    // Boolean output variables are not supported
    if dst.base == BaseKind::Bool {
        result.push_str("out int result;\n");
    } else {
        result.push_str(&format!("out {} result;\n", dst.name));
    }

    // Use ints for bools. We will cast them to bool in the code later.
    if src.base == BaseKind::Bool {
        result.push_str("in int base_value;\n");
    } else {
        result.push_str(&format!("in {} base_value;\n", src.base_name()));
    }

    result.push_str(&format!("void main()\n{{\n{} lside_value = ", src.name));
    if src.base == BaseKind::Bool {
        result.push_str(&format!("{}(0 != ", src.name));
    } else {
        result.push_str(&format!("{}(", src.name));
    }

    if src.base != BaseKind::Bool {
        let components: Vec<String> = (0..n_src_components)
            .map(|n_component| format!("base_value + {n_component}"))
            .collect();
        result.push_str(&components.join(", "));
    } else {
        result.push_str("base_value");
    }
    result.push_str(");\n");

    // Perform the casting operation. Add swizzle operator if possible.
    if dst.base == BaseKind::Bool {
        if test_case.type_ == TestCaseType::Explicit {
            result.push_str("result = (bool(lside_value) == false) ? 0 : 1");
        } else {
            result.push_str("result = (lside_value == false) ? 0 : 1");
        }
    } else if test_case.type_ == TestCaseType::Explicit {
        result.push_str(&format!("result = {}(lside_value)", dst.name));
    } else {
        result.push_str("result = lside_value");
    }

    if n_src_components > 1 && !src.is_matrix() {
        let swizzle_string = SWIZZLE_MATRIX[n_dst_components - 1][n_src_components - 1];
        if !swizzle_string.is_empty() {
            result.push('.');
            result.push_str(swizzle_string);
        }
    }

    result.push_str(";\n}\n");
    result
}

/// `verifyXFBData`
fn verify_xfb_data(data: &[u8], test_case: &TestCaseDescriptor) -> bool {
    let base_dst_type = test_case.dst_type.base;
    let base_src_type = test_case.src_type.base;
    const EPSILON: f32 = 1e-5;
    let n_result_components = test_case.dst_type.components();
    let n_src_components = test_case.src_type.components();
    let mut result = true;
    let mut traveller = 0usize;

    let mut swizzle_order: Vec<usize> = Vec::new();
    if !test_case.src_type.is_matrix() {
        swizzle_order = swizzle_component_order(SWIZZLE_MATRIX[n_result_components - 1][n_src_components - 1]);
    }

    let cast_kind = if test_case.type_ == TestCaseType::Explicit {
        "explicit"
    } else {
        "implicit"
    };

    for &base_value in &BASE_VALUES {
        for n_result_component in 0..n_result_components {
            let n_swizzled_component = if swizzle_order.is_empty() {
                n_result_component
            } else {
                swizzle_order[n_result_component]
            };

            match base_dst_type {
                BaseKind::Bool | BaseKind::Int => {
                    let ref_expected_value = f64::from(base_value) + f64::from(n_swizzled_component as f32);
                    let mut expected_value = ref_expected_value;
                    let result_value = i32::from_ne_bytes(data[traveller..traveller + 4].try_into().expect("4 bytes"));
                    if base_dst_type == BaseKind::Bool && expected_value != 0.0 {
                        expected_value = 1.0;
                    }
                    if result_value != expected_value as i32 {
                        log::info!(
                            "Invalid boolean/integer value obtained when doing an {cast_kind} cast from GLSL type [{}], component index: [{n_swizzled_component}], value: [{ref_expected_value}] to GLSL type [{}], retrieved value: [{result_value}], expected value: [{}], shader used:\n{}",
                            test_case.src_type.name,
                            test_case.dst_type.name,
                            expected_value as i32,
                            test_case.shader_body
                        );
                        result = false;
                    }
                    traveller += 4;
                }
                BaseKind::Double => {
                    let ref_expected_value = f64::from(base_value) + n_swizzled_component as f64;
                    let mut expected_value = ref_expected_value;
                    let result_value = f64::from_ne_bytes(data[traveller..traveller + 8].try_into().expect("8 bytes"));
                    match base_src_type {
                        BaseKind::Bool => expected_value = if expected_value as i32 != 0 { 1.0 } else { 0.0 },
                        BaseKind::Int => expected_value = f64::from(expected_value as i32),
                        BaseKind::Uint => {
                            // Negative values in the base values array become zero when converted to unsigned int, and the shader then adds to that zero: replicate the sequence of conversions.
                            if expected_value < 0.0 {
                                expected_value = f64::from(base_value as u32) + n_swizzled_component as f64;
                            }
                            expected_value = f64::from(expected_value as u32);
                        }
                        _ => {}
                    }
                    traveller += 8;
                    if (result_value - expected_value).abs() > f64::from(EPSILON) {
                        log::info!(
                            "Invalid double-precision floating-point value obtained when doing an {cast_kind} cast from GLSL type [{}], component index: [{n_swizzled_component}], value: [{ref_expected_value}] to GLSL type [{}], retrieved value: [{result_value:.16}], expected value: [{expected_value:.16}], shader used:\n{}",
                            test_case.src_type.name,
                            test_case.dst_type.name,
                            test_case.shader_body
                        );
                        result = false;
                    }
                }
                BaseKind::Float => {
                    let ref_expected_value = base_value + n_swizzled_component as f32;
                    let mut expected_value = ref_expected_value;
                    let result_value = f32::from_ne_bytes(data[traveller..traveller + 4].try_into().expect("4 bytes"));
                    match base_src_type {
                        BaseKind::Bool => expected_value = if expected_value != 0.0 { 1.0 } else { 0.0 },
                        BaseKind::Int => expected_value = (expected_value as i32) as f32,
                        BaseKind::Uint => expected_value = (expected_value as u32) as f32,
                        _ => {}
                    }
                    traveller += 4;
                    if (result_value - expected_value).abs() > EPSILON {
                        log::info!(
                            "Invalid single-precision floating-point value obtained when doing an {cast_kind} cast from GLSL type [{}], component index: [{n_swizzled_component}], value: [{ref_expected_value}] to GLSL type [{}], retrieved value: [{result_value:.16}], expected value: [{expected_value:.16}], shader used:\n{}",
                            test_case.src_type.name,
                            test_case.dst_type.name,
                            test_case.shader_body
                        );
                        result = false;
                    }
                }
                BaseKind::Uint => {
                    let ref_expected_value = f64::from(base_value) + f64::from(n_swizzled_component as f32);
                    let expected_value = ref_expected_value;
                    let result_value = u32::from_ne_bytes(data[traveller..traveller + 4].try_into().expect("4 bytes"));
                    traveller += 4;
                    if result_value != expected_value as u32 {
                        // It is undefined to convert a negative floating-point value to an uint.
                        if expected_value < 0.0 {
                            continue;
                        }
                        log::info!(
                            "Invalid unsigned integer value obtained when doing an {cast_kind} cast from GLSL type [{}], component index: [{n_swizzled_component}], value: [{ref_expected_value}] to GLSL type [{}], retrieved value: [{result_value}], expected value: [{}], shader used:\n{}",
                            test_case.src_type.name,
                            test_case.dst_type.name,
                            expected_value as u32,
                            test_case.shader_body
                        );
                        result = false;
                    }
                }
            }
        }
    }
    result
}

/// The iteration array: the implicit casts, then the explicit ones
fn test_cases() -> Vec<TestCaseDescriptor> {
    use BaseKind::{Bool, Double, Float, Int, Uint};
    let implicit_pairs: [(Type, Type); 21] = [
        (ty("int", 1, 1, Int), ty("double", 1, 1, Double)),
        (ty("ivec2", 1, 2, Int), ty("dvec2", 1, 2, Double)),
        (ty("ivec3", 1, 3, Int), ty("dvec3", 1, 3, Double)),
        (ty("ivec4", 1, 4, Int), ty("dvec4", 1, 4, Double)),
        (ty("uint", 1, 1, Uint), ty("double", 1, 1, Double)),
        (ty("uvec2", 1, 2, Uint), ty("dvec2", 1, 2, Double)),
        (ty("uvec3", 1, 3, Uint), ty("dvec3", 1, 3, Double)),
        (ty("uvec4", 1, 4, Uint), ty("dvec4", 1, 4, Double)),
        (ty("float", 1, 1, Float), ty("double", 1, 1, Double)),
        (ty("vec2", 1, 2, Float), ty("dvec2", 1, 2, Double)),
        (ty("vec3", 1, 3, Float), ty("dvec3", 1, 3, Double)),
        (ty("vec4", 1, 4, Float), ty("dvec4", 1, 4, Double)),
        (ty("mat2", 2, 2, Float), ty("dmat2", 2, 2, Double)),
        (ty("mat3", 3, 3, Float), ty("dmat3", 3, 3, Double)),
        (ty("mat4", 4, 4, Float), ty("dmat4", 4, 4, Double)),
        (ty("mat2x3", 2, 3, Float), ty("dmat2x3", 2, 3, Double)),
        (ty("mat2x4", 2, 4, Float), ty("dmat2x4", 2, 4, Double)),
        (ty("mat3x2", 3, 2, Float), ty("dmat3x2", 3, 2, Double)),
        (ty("mat3x4", 3, 4, Float), ty("dmat3x4", 3, 4, Double)),
        (ty("mat4x2", 4, 2, Float), ty("dmat4x2", 4, 2, Double)),
        (ty("mat4x3", 4, 3, Float), ty("dmat4x3", 4, 3, Double)),
    ];
    let explicit_pairs: [(Type, Type); 8] = [
        (ty("int", 1, 1, Int), ty("double", 1, 1, Double)),
        (ty("uint", 1, 1, Uint), ty("double", 1, 1, Double)),
        (ty("float", 1, 1, Float), ty("double", 1, 1, Double)),
        (ty("double", 1, 1, Double), ty("int", 1, 1, Int)),
        (ty("double", 1, 1, Double), ty("uint", 1, 1, Uint)),
        (ty("double", 1, 1, Double), ty("float", 1, 1, Float)),
        (ty("double", 1, 1, Double), ty("bool", 1, 1, Bool)),
        (ty("bool", 1, 1, Bool), ty("double", 1, 1, Double)),
    ];

    let descriptor = |type_, (src_type, dst_type)| TestCaseDescriptor {
        type_,
        src_type,
        dst_type,
        shader_body: String::new(),
    };
    implicit_pairs
        .into_iter()
        .map(|pair| descriptor(TestCaseType::Implicit, pair))
        .chain(
            explicit_pairs
                .into_iter()
                .map(|pair| descriptor(TestCaseType::Explicit, pair)),
        )
        .collect()
}

/// `GPUShaderFP64Test5`
pub(super) struct Conversions;

#[derive(Default)]
struct Resources {
    base_value_bo_id: GLuint,
    vao_id: GLuint,
    xfb_bo_id: GLuint,
    po_id: GLuint,
    vs_id: GLuint,
}

impl Conversions {
    /// `initTest`
    fn init_test(context: &Context, resources: &mut Resources) -> Result<(), TestError> {
        let gl = context.gl();

        gl!(gl.gen_buffers(1, &mut resources.base_value_bo_id));
        gl!(gl.gen_buffers(1, &mut resources.xfb_bo_id));
        glu::expect_no_error(gl, "glGenBuffers() call(s) failed.")?;

        // All iterations will never eat up more than 1 double and as many points are drawn as there are base values.
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.base_value_bo_id));
        glu::expect_no_error(gl, "glBindBuffer() call failed.")?;
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            (std::mem::size_of::<f64>() * BASE_VALUES.len()) as isize,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "glBufferData() call failed.")?;

        // Each XFBed value can take up to 16 components (eg. mat4) and be of double type (eg. dmat4)
        let xfb_bo_size = std::mem::size_of::<f64>() * 16 * BASE_VALUES.len();
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, resources.xfb_bo_id));
        glu::expect_no_error(gl, "glBindBuffer() call failed.")?;
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.xfb_bo_id));
        glu::expect_no_error(gl, "glBindBufferBase() call failed.")?;
        gl!(gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            xfb_bo_size as isize,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "glBufferData() call failed.")?;

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        glu::expect_no_error(gl, "glGenVertexArrays() call failed.")?;
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "glBindVertexArray() call failed.")
    }

    /// `initIteration`: returns the location of the `base_value` attribute
    fn init_iteration(
        context: &Context,
        resources: &mut Resources,
        test_case: &mut TestCaseDescriptor,
    ) -> Result<GLint, TestError> {
        let gl = context.gl();

        resources.po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "glCreateProgram() call failed.")?;
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        glu::expect_no_error(gl, "glCreateShader() call failed.")?;

        let body = vertex_shader_body(test_case);
        let source = CString::new(body.as_str()).expect("shader source holds no nul byte");
        let sources = [source.as_ptr()];
        gl!(gl.shader_source(resources.vs_id, 1, sources.as_ptr(), std::ptr::null()));
        glu::expect_no_error(gl, "glShaderSource() call failed.")?;

        // Store it in the test case descriptor for logging purposes
        test_case.shader_body = body;

        let mut compile_status = glw::GL_FALSE as GLint;
        gl!(gl.compile_shader(resources.vs_id));
        glu::expect_no_error(gl, "glCompileShader() call failed.")?;
        gl!(gl.get_shaderiv(resources.vs_id, glw::GL_COMPILE_STATUS, &mut compile_status));
        glu::expect_no_error(gl, "glGetShaderiv() call failed.")?;
        if compile_status != glw::GL_TRUE as GLint {
            return Err(TestError::Fail("Shader compilation failed".to_string()));
        }

        gl!(gl.attach_shader(resources.po_id, resources.vs_id));
        glu::expect_no_error(gl, "glAttachShader() call failed.")?;

        let xfb_varying_name = CString::new("result").expect("no nul byte");
        let varyings = [xfb_varying_name.as_ptr()];
        gl!(gl.transform_feedback_varyings(resources.po_id, 1, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS));
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() call failed.")?;

        let mut link_status = glw::GL_FALSE as GLint;
        gl!(gl.link_program(resources.po_id));
        glu::expect_no_error(gl, "glLinkProgram() call failed.")?;
        gl!(gl.get_programiv(resources.po_id, glw::GL_LINK_STATUS, &mut link_status));
        glu::expect_no_error(gl, "glGetProgramiv() call failed.")?;
        if link_status != glw::GL_TRUE as GLint {
            return Err(TestError::Fail("Program linking failed".to_string()));
        }

        let attribute_name = CString::new("base_value").expect("no nul byte");
        let location = gl!(gl.get_attrib_location(resources.po_id, attribute_name.as_ptr()));
        glu::expect_no_error(gl, "getAttribLocation() call failed.")?;
        if location == -1 {
            return Err(TestError::Fail(
                "'base_value' is considered an inactive attribute which is invalid.".to_string(),
            ));
        }
        Ok(location)
    }

    /// `deinitInteration`
    fn deinit_iteration(gl: &glw::Functions, resources: &mut Resources) {
        if resources.po_id != 0 {
            gl!(gl.delete_program(resources.po_id));
            resources.po_id = 0;
        }
        if resources.vs_id != 0 {
            gl!(gl.delete_shader(resources.vs_id));
            resources.vs_id = 0;
        }
    }

    /// `executeIteration`
    fn execute_iteration(
        context: &Context,
        resources: &Resources,
        base_value_attribute_location: GLint,
        test_case: &TestCaseDescriptor,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let location = base_value_attribute_location as GLuint;

        // Convert the base values array to the type of input attribute we'll be using for the iteration. Bools are represented by ints, since bool varyings are not allowed.
        let base_value_kind = if test_case.src_type.base == BaseKind::Bool {
            BaseKind::Int
        } else {
            test_case.src_type.base
        };
        let mut base_value_data: Vec<u8> = Vec::new();
        for &base_value in &BASE_VALUES {
            match base_value_kind {
                BaseKind::Double => base_value_data.extend_from_slice(&f64::from(base_value).to_ne_bytes()),
                BaseKind::Float => base_value_data.extend_from_slice(&base_value.to_ne_bytes()),
                BaseKind::Int | BaseKind::Bool => base_value_data.extend_from_slice(&(base_value as i32).to_ne_bytes()),
                BaseKind::Uint => base_value_data.extend_from_slice(&(base_value as u32).to_ne_bytes()),
            }
        }

        // Update buffer object storage with the data we've just finished preparing.
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.base_value_bo_id));
        glu::expect_no_error(gl, "glBindBuffer() call failed.")?;
        gl!(gl.buffer_sub_data(
            glw::GL_ARRAY_BUFFER,
            0,
            base_value_data.len() as isize,
            base_value_data.as_ptr().cast()
        ));
        glu::expect_no_error(gl, "glBufferSubData() call failed.")?;

        // Configure vertex attribute array corresponding to 'base_value' attribute, so that the new data is interpreted correctly.
        match base_value_kind {
            BaseKind::Float => {
                gl!(gl.vertex_attrib_pointer(location, 1, glw::GL_FLOAT, 0, 0, std::ptr::null()));
                glu::expect_no_error(gl, "glVertexAttribPointer() call failed.")?;
            }
            BaseKind::Int | BaseKind::Uint => {
                let data_type = if base_value_kind == BaseKind::Int {
                    glw::GL_INT
                } else {
                    glw::GL_UNSIGNED_INT
                };
                gl!(gl.vertex_attrib_i_pointer(location, 1, data_type, 0, std::ptr::null()));
                glu::expect_no_error(gl, "glVertexAttribIPointer() call failed.")?;
            }
            _ => {
                gl!(gl.vertex_attrib_l_pointer(location, 1, glw::GL_DOUBLE, 0, std::ptr::null()));
                glu::expect_no_error(gl, "glVertxAttribLPointer() call failed.")?;
            }
        }

        gl!(gl.enable_vertex_attrib_array(location));
        glu::expect_no_error(gl, "glEnableVertexAttribArray() call failed.")?;

        // Execute the draw call
        gl!(gl.use_program(resources.po_id));
        glu::expect_no_error(gl, "glUseProgram() call failed.")?;

        gl!(gl.begin_transform_feedback(glw::GL_POINTS));
        glu::expect_no_error(gl, "glBeginTransformFeedback() call failed.")?;
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, BASE_VALUES.len() as glw::GLsizei));
        glu::expect_no_error(gl, "glDrawArrays() call failed.")?;
        gl!(gl.end_transform_feedback());
        glu::expect_no_error(gl, "glEndTransformFeedback() call failed.")?;

        // Map the XFB buffer object into process space
        let xfb_data_ptr = gl!(gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY)).cast::<u8>();
        glu::expect_no_error(gl, "glMapBuffer() call failed.")?;
        if xfb_data_ptr.is_null() {
            return Err(TestError::Fail("glMapBuffer() returned NULL.".to_string()));
        }

        let xfb_bo_size = std::mem::size_of::<f64>() * 16 * BASE_VALUES.len();
        // SAFETY: the buffer was allocated with `xfb_bo_size` bytes in `init_test` and stays mapped until the unmap below.
        let xfb_data = unsafe { std::slice::from_raw_parts(xfb_data_ptr, xfb_bo_size) }.to_vec();
        let result = verify_xfb_data(&xfb_data, test_case);

        gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
        glu::expect_no_error(gl, "glUnmapBuffer() call failed.")?;
        Ok(result)
    }

    fn run(context: &Context, resources: &mut Resources) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut has_test_passed = true;

        Self::init_test(context, resources)?;

        for mut test_case in test_cases() {
            let outcome = Self::init_iteration(context, resources, &mut test_case)
                .and_then(|location| Self::execute_iteration(context, resources, location, &test_case));
            // Release the GL Resource for this sub test
            Self::deinit_iteration(gl, resources);
            has_test_passed &= outcome?;
        }
        Ok(has_test_passed)
    }
}

impl TestCase for Conversions {
    fn name(&self) -> &str {
        "conversions"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        if !context.context_info.is_extension_supported("GL_ARB_gpu_shader_fp64") {
            return Err(TestError::NotSupported(
                "GL_ARB_gpu_shader_fp64 is not supported.".to_string(),
            ));
        }
        if !context
            .context_info
            .is_extension_supported("GL_ARB_vertex_attrib_64bit")
        {
            return Err(TestError::NotSupported(
                "GL_ARB_vertex_attrib_64bit is not supported.".to_string(),
            ));
        }

        let gl = context.gl();
        let mut resources = Resources::default();
        let result = Self::run(context, &mut resources);

        // deinit
        if resources.base_value_bo_id != 0 {
            gl!(gl.delete_buffers(1, &resources.base_value_bo_id));
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        if resources.xfb_bo_id != 0 {
            gl!(gl.delete_buffers(1, &resources.xfb_bo_id));
        }
        Self::deinit_iteration(gl, &mut resources);

        Ok(if result? {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}
