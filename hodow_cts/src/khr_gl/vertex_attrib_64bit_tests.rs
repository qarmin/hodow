// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cVertexAttrib64BitTest.cpp
//   external/openglcts/modules/gl/gl4cVertexAttrib64BitTest.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `Base::RandomDouble` keeps its function-local static counter as a process-wide atomic, and `GetVertexAttribTest::vertexAttribute<SIZE>` / `checkVertexAttribLd<SIZE>` are const-generic over `SIZE`.
//
// All four cases: api_errors, get_vertex_attrib, limits_test (vertex_attrib_64bit_limits_tests.rs) and vao (vertex_attrib_64bit_vao_tests.rs).

use std::ffi::c_void;
use std::sync::atomic::{AtomicU16, Ordering};

use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLdouble, GLenum, GLint, GLsizeiptr, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const EXTENSION: &str = "GL_ARB_vertex_attrib_64bit";

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

/// `Base::RandomDouble`
fn random_double(min: GLdouble, max: GLdouble) -> GLdouble {
    const MAX_VALUE: u16 = 0x2000;
    static VALUE: AtomicU16 = AtomicU16::new(0x1234);

    let value = VALUE.load(Ordering::Relaxed);
    let fraction = f64::from(value) / f64::from(MAX_VALUE);
    let range = max - min;

    VALUE.store(if MAX_VALUE <= value { 0 } else { value + 1 }, Ordering::Relaxed);

    min + fraction * range
}

/// `Base::RequireExtension`
pub(super) fn require_extension(context: &Context, extension_name: &str) -> Result<(), TestError> {
    if !context.context_info.is_extension_supported(extension_name) {
        return Err(TestError::NotSupported(format!(
            "Required extension is not supported: {extension_name}"
        )));
    }
    Ok(())
}

/// `Base::GetMaxVertexAttribs`
pub(super) fn get_max_vertex_attribs(gl: &glw::Functions) -> Result<GLint, TestError> {
    let mut max_vertex_attribs: GLint = 0;
    gl_call!(
        gl,
        "GetIntegerv",
        gl.get_integerv(glw::GL_MAX_VERTEX_ATTRIBS, &mut max_vertex_attribs)
    );
    Ok(max_vertex_attribs)
}

/// `Base::IterateStop`
pub(super) fn iterate_stop(result: bool) -> TestOutcome {
    Ok(if result {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

#[derive(Clone, Copy)]
enum Kind {
    ApiErrors,
    GetVertexAttrib,
}

struct VertexAttrib64BitTest {
    name: &'static str,
    kind: Kind,
}

/// `ApiErrorsTest::verifyError`
fn verify_error(gl: &glw::Functions, expected_error: GLenum, function_name: &str, result: &mut bool) {
    // SAFETY: reads the error flag of the current context.
    let error = unsafe { gl.get_error() };
    if expected_error != error {
        log::info!(
            "Error\nGetError returned: {}\nExpected: {}\nOperation: {function_name}",
            glw::error_name(error),
            glw::error_name(expected_error)
        );
        *result = false;
    }
}

/// `ApiErrorsTest::invalidEnum`
fn invalid_enum(gl: &glw::Functions, result: &mut bool) {
    let type_array: [GLenum; 12] = [
        glw::GL_BYTE,
        glw::GL_UNSIGNED_BYTE,
        glw::GL_SHORT,
        glw::GL_UNSIGNED_SHORT,
        glw::GL_INT,
        glw::GL_UNSIGNED_INT,
        glw::GL_HALF_FLOAT,
        glw::GL_FLOAT,
        glw::GL_FIXED,
        glw::GL_INT_2_10_10_10_REV,
        glw::GL_UNSIGNED_INT_2_10_10_10_REV,
        glw::GL_UNSIGNED_INT_10F_11F_11F_REV,
    ];

    for type_ in type_array {
        // SAFETY: the call is made to fail validation; the pointer is NULL.
        unsafe { gl.vertex_attrib_l_pointer(1, 4, type_, 0, std::ptr::null()) };
        verify_error(
            gl,
            glw::GL_INVALID_ENUM,
            &format!("VertexAttribLPointer(..., {type_:#x} /* type */, ...)"),
            result,
        );
    }

    // SAFETY: as above.
    unsafe { gl.vertex_attrib_l_pointer(1, 4, glw::GL_DOUBLE, 0, std::ptr::null()) };
    verify_error(
        gl,
        glw::GL_NO_ERROR,
        "VertexAttribLPointer(..., GL_DOUBLE /* type */, ...)",
        result,
    );
}

/// `ApiErrorsTest::invalidOperation`
fn invalid_operation(gl: &glw::Functions, result: &mut bool) -> Result<(), TestError> {
    let pointer_array: [usize; 3] = [1, 4, (-16isize) as usize];

    gl_call!(gl, "BindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    for pointer in pointer_array {
        // SAFETY: with no buffer bound a non-NULL pointer is rejected before it is read.
        unsafe { gl.vertex_attrib_l_pointer(1, 4, glw::GL_DOUBLE, 0, pointer as *const c_void) };
        verify_error(
            gl,
            glw::GL_INVALID_OPERATION,
            &format!("VertexAttribLPointer(..., {pointer:#x} /* pointer */)"),
            result,
        );
    }
    Ok(())
}

/// `ApiErrorsTest::invalidValue`
fn invalid_value(gl: &glw::Functions, result: &mut bool) -> Result<(), TestError> {
    let max_vertex_attribs = get_max_vertex_attribs(gl)? as GLuint;
    let vector: [GLdouble; 4] = [0.0; 4];

    // a) <index> greater than or equal to GL_MAX_VERTEX_ATTRIBS, the two indices checked back to back for each entry point
    let indices = [
        (max_vertex_attribs, "GL_MAX_VERTEX_ATTRIBS"),
        (max_vertex_attribs + 1, "GL_MAX_VERTEX_ATTRIBS + 1"),
    ];
    let mut check_index = |function: &str, call: &dyn Fn(GLuint)| {
        for (index, label) in indices {
            call(index);
            verify_error(gl, glw::GL_INVALID_VALUE, &format!("{function}({label}, ...)"), result);
        }
    };

    // SAFETY (all calls below): made to fail validation on the current context; `vector` holds four doubles.
    check_index("VertexAttribL1d", &|index| unsafe { gl.vertex_attrib_l_1d(index, 0.0) });
    check_index("VertexAttribL2d", &|index| unsafe {
        gl.vertex_attrib_l_2d(index, 0.0, 0.0)
    });
    check_index("VertexAttribL3d", &|index| unsafe {
        gl.vertex_attrib_l_3d(index, 0.0, 0.0, 0.0)
    });
    check_index("VertexAttribL4d", &|index| unsafe {
        gl.vertex_attrib_l_4d(index, 0.0, 0.0, 0.0, 0.0)
    });
    check_index("VertexAttribL1dv", &|index| unsafe {
        gl.vertex_attrib_l_1dv(index, vector.as_ptr())
    });
    check_index("VertexAttribL2dv", &|index| unsafe {
        gl.vertex_attrib_l_2dv(index, vector.as_ptr())
    });
    check_index("VertexAttribL3dv", &|index| unsafe {
        gl.vertex_attrib_l_3dv(index, vector.as_ptr())
    });
    check_index("VertexAttribL4dv", &|index| unsafe {
        gl.vertex_attrib_l_4dv(index, vector.as_ptr())
    });
    check_index("VertexAttribLPointer", &|index| unsafe {
        gl.vertex_attrib_l_pointer(index, 4, glw::GL_DOUBLE, 0, std::ptr::null())
    });

    // c) <size> is not 1, 2, 3 or 4
    for size in [0, 5] {
        // SAFETY: as above.
        unsafe { gl.vertex_attrib_l_pointer(1, size, glw::GL_DOUBLE, 0, std::ptr::null()) };
        verify_error(
            gl,
            glw::GL_INVALID_VALUE,
            &format!("VertexAttribLPointer(..., {size} /* size */, ...)"),
            result,
        );
    }

    // d) <stride> is negative
    for stride in [-1, -4] {
        // SAFETY: as above.
        unsafe { gl.vertex_attrib_l_pointer(1, 4, glw::GL_DOUBLE, stride, std::ptr::null()) };
        verify_error(
            gl,
            glw::GL_INVALID_VALUE,
            &format!("VertexAttribLPointer(..., {stride} /* stride */, ...)"),
            result,
        );
    }
    Ok(())
}

/// `ApiErrorsTest::iterate` (the VAO is deleted whether or not an error escaped, as `deinit` does)
fn api_errors(context: &Context) -> TestOutcome {
    let gl = context.gl();
    let mut vertex_array_object_id: GLuint = 0;

    let outcome = (|| -> TestOutcome {
        let mut result = true;

        require_extension(context, EXTENSION)?;

        gl_call!(
            gl,
            "GenVertexArrays",
            gl.gen_vertex_arrays(1, &mut vertex_array_object_id)
        );
        gl_call!(gl, "BindVertexArray", gl.bind_vertex_array(vertex_array_object_id));

        invalid_enum(gl, &mut result);
        invalid_operation(gl, &mut result)?;
        invalid_value(gl, &mut result)?;

        iterate_stop(result)
    })();

    if vertex_array_object_id != 0 {
        // SAFETY: deletes the name this test created, on the current context.
        unsafe {
            gl.bind_vertex_array(0);
            gl.delete_vertex_arrays(1, &vertex_array_object_id);
        }
    }
    outcome
}

/// `GetVertexAttribTest::vertexAttribute<SIZE>`
struct VertexAttribute<const SIZE: usize> {
    array: [GLdouble; SIZE],
}

impl<const SIZE: usize> VertexAttribute<SIZE> {
    fn new(min: GLdouble, max: GLdouble) -> Self {
        let mut array = [0.0; SIZE];
        for value in &mut array {
            *value = random_double(min, max);
        }
        Self { array }
    }

    /// `vertexAttribLd<SIZE>`
    fn set_d(&self, gl: &glw::Functions, index: GLuint) {
        // SAFETY: plain state call on the current context.
        unsafe {
            match SIZE {
                1 => gl.vertex_attrib_l_1d(index, self.array[0]),
                2 => gl.vertex_attrib_l_2d(index, self.array[0], self.array[1]),
                3 => gl.vertex_attrib_l_3d(index, self.array[0], self.array[1], self.array[2]),
                _ => gl.vertex_attrib_l_4d(index, self.array[0], self.array[1], self.array[2], self.array[3]),
            }
        }
    }

    /// `vertexAttribLdv<SIZE>`
    fn set_dv(&self, gl: &glw::Functions, index: GLuint) {
        // SAFETY: `array` holds `SIZE` doubles, the number the entry point reads.
        unsafe {
            match SIZE {
                1 => gl.vertex_attrib_l_1dv(index, self.array.as_ptr()),
                2 => gl.vertex_attrib_l_2dv(index, self.array.as_ptr()),
                3 => gl.vertex_attrib_l_3dv(index, self.array.as_ptr()),
                _ => gl.vertex_attrib_l_4dv(index, self.array.as_ptr()),
            }
        }
    }
}

const GET_EPSILON: GLdouble = 0.0;
const GET_N_ITERATIONS: u32 = 128;
const GET_MIN: GLdouble = -16.384;
const GET_MAX: GLdouble = 16.384;

/// `GetVertexAttribTest::compareDoubles`
fn compare_doubles(a: &[GLdouble], b: &[GLdouble]) -> bool {
    a.iter()
        .zip(b)
        .all(|(&a, &b)| !(b > a + GET_EPSILON || b < a - GET_EPSILON))
}

/// `GetVertexAttribTest::logError`
fn log_error(set_values: &[GLdouble], get_values: &[GLdouble], function_name: &str, index: GLuint) {
    let join = |values: &[GLdouble]| values.iter().map(|v| format!("{v:.24}")).collect::<Vec<_>>().join(", ");
    log::info!(
        "Error\nValues set with {function_name} [{}]\nValues got with GetVertexAttribLdv [{}]\nIndex: {index}",
        join(set_values),
        join(get_values)
    );
}

/// `GetVertexAttribTest::verifyResults(set_values, ...)`
fn verify_set_results(
    gl: &glw::Functions,
    set_values: &[GLdouble],
    index: GLuint,
    function_name: &str,
) -> Result<bool, TestError> {
    let mut results: [GLdouble; 4] = [0.0; 4];

    gl_call!(
        gl,
        "GetVertexAttribLdv",
        gl.get_vertex_attrib_ldv(index, glw::GL_CURRENT_VERTEX_ATTRIB, results.as_mut_ptr())
    );

    if !compare_doubles(set_values, &results[..set_values.len()]) {
        log_error(set_values, &results[..set_values.len()], function_name, index);
        return Ok(false);
    }
    Ok(true)
}

/// `GetVertexAttribTest::verifyResults(index, pname, expected_value)`
fn verify_pointer_results(
    gl: &glw::Functions,
    index: GLuint,
    pname: GLenum,
    expected_value: GLint,
) -> Result<bool, TestError> {
    let mut params_get_vertex_attribiv: GLint = 0;
    let mut params_get_vertex_attrib_ldv: GLdouble = 0.0;

    gl_call!(
        gl,
        "GetVertexAttribiv",
        gl.get_vertex_attribiv(index, pname, &mut params_get_vertex_attribiv)
    );
    gl_call!(
        gl,
        "GetVertexAttribLdv",
        gl.get_vertex_attrib_ldv(index, pname, &mut params_get_vertex_attrib_ldv)
    );

    if expected_value != params_get_vertex_attribiv || f64::from(expected_value) != params_get_vertex_attrib_ldv {
        log::info!(
            "Error\nGetVertexAttribiv({index}/* index */, {pname:#x}/* pname */)\nResult: {params_get_vertex_attribiv}\nGetVertexAttribLdv({index}/* index */, {pname:#x}/* pname */)\nResult: {params_get_vertex_attrib_ldv}\nExpected: {expected_value}"
        );
        return Ok(false);
    }
    Ok(true)
}

/// `GetVertexAttribTest::checkVertexAttribLd<SIZE>` and `checkVertexAttribLdv<SIZE>`
fn check_vertex_attrib_l<const SIZE: usize>(
    gl: &glw::Functions,
    index: GLuint,
    vector_form: bool,
    result: &mut bool,
) -> Result<(), TestError> {
    let function_name = format!("VertexAttribL{SIZE}{}", if vector_form { "dv" } else { "d" });

    for _ in 0..GET_N_ITERATIONS {
        let vertex_attribute = VertexAttribute::<SIZE>::new(GET_MIN, GET_MAX);

        if vector_form {
            vertex_attribute.set_dv(gl, index);
        } else {
            vertex_attribute.set_d(gl, index);
        }
        glu::expect_no_error(gl, &function_name)?;

        if !verify_set_results(gl, &vertex_attribute.array, index, &function_name)? {
            *result = false;
            return Ok(());
        }
    }
    Ok(())
}

/// `GetVertexAttribTest::checkVertexAttribLPointer`
fn check_vertex_attrib_l_pointer(
    gl: &glw::Functions,
    index: GLuint,
    vertex_array_object_id: GLuint,
    buffer_object_id: GLuint,
    result: &mut bool,
) -> Result<(), TestError> {
    const MAX_SIZE: GLint = 4;
    const MAX_STRIDE: glw::GLsizei = 16;

    gl_call!(gl, "BindVertexArray", gl.bind_vertex_array(vertex_array_object_id));
    gl_call!(gl, "BindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer_object_id));

    for size in 1..=MAX_SIZE {
        for stride in 0..MAX_STRIDE {
            gl_call!(gl, "BindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer_object_id));
            gl_call!(
                gl,
                "VertexAttribLPointer",
                gl.vertex_attrib_l_pointer(index, size, glw::GL_DOUBLE, stride, std::ptr::null())
            );
            gl_call!(gl, "BindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

            let expectations: [(GLenum, GLint); 8] = [
                (glw::GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING, buffer_object_id as GLint),
                (glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED, glw::GL_FALSE as GLint),
                (glw::GL_VERTEX_ATTRIB_ARRAY_SIZE, size),
                (glw::GL_VERTEX_ATTRIB_ARRAY_STRIDE, stride),
                (glw::GL_VERTEX_ATTRIB_ARRAY_TYPE, glw::GL_DOUBLE as GLint),
                (glw::GL_VERTEX_ATTRIB_ARRAY_NORMALIZED, glw::GL_FALSE as GLint),
                (glw::GL_VERTEX_ATTRIB_ARRAY_INTEGER, glw::GL_FALSE as GLint),
                (glw::GL_VERTEX_ATTRIB_ARRAY_DIVISOR, 0),
            ];
            for (pname, expected_value) in expectations {
                if !verify_pointer_results(gl, index, pname, expected_value)? {
                    *result = false;
                }
            }
        }
    }
    Ok(())
}

/// `GetVertexAttribTest::iterate` (the objects are deleted whether or not an error escaped, as `deinit` does)
fn get_vertex_attrib(context: &Context) -> TestOutcome {
    let gl = context.gl();
    let mut buffer_object_id: GLuint = 0;
    let mut vertex_array_object_id: GLuint = 0;

    let outcome = (|| -> TestOutcome {
        let mut result = true;

        require_extension(context, EXTENSION)?;

        // `initTest`
        gl_call!(gl, "GenBuffers", gl.gen_buffers(1, &mut buffer_object_id));
        gl_call!(gl, "BindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer_object_id));
        gl_call!(
            gl,
            "BufferStorage",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                (16 * std::mem::size_of::<GLdouble>()) as GLsizeiptr,
                std::ptr::null(),
                glw::GL_DYNAMIC_DRAW
            )
        );
        gl_call!(
            gl,
            "GenVertexArrays",
            gl.gen_vertex_arrays(1, &mut vertex_array_object_id)
        );
        let max_vertex_attribs = get_max_vertex_attribs(gl)?;

        for i in 1..max_vertex_attribs as GLuint {
            check_vertex_attrib_l::<1>(gl, i, false, &mut result)?;
            check_vertex_attrib_l::<2>(gl, i, false, &mut result)?;
            check_vertex_attrib_l::<3>(gl, i, false, &mut result)?;
            check_vertex_attrib_l::<4>(gl, i, false, &mut result)?;
            check_vertex_attrib_l::<1>(gl, i, true, &mut result)?;
            check_vertex_attrib_l::<2>(gl, i, true, &mut result)?;
            check_vertex_attrib_l::<3>(gl, i, true, &mut result)?;
            check_vertex_attrib_l::<4>(gl, i, true, &mut result)?;
            check_vertex_attrib_l_pointer(gl, i, vertex_array_object_id, buffer_object_id, &mut result)?;
        }

        iterate_stop(result)
    })();

    // SAFETY: deletes the names this test created, on the current context.
    unsafe {
        if buffer_object_id != 0 {
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            gl.delete_buffers(1, &buffer_object_id);
        }
        if vertex_array_object_id != 0 {
            gl.bind_vertex_array(0);
            gl.delete_vertex_arrays(1, &vertex_array_object_id);
        }
    }
    outcome
}

impl TestCase for VertexAttrib64BitTest {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        match self.kind {
            Kind::ApiErrors => api_errors(context),
            Kind::GetVertexAttrib => get_vertex_attrib(context),
        }
    }
}

/// `VertexAttrib64BitTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("vertex_attrib_64bit");
    for (name, kind) in [
        ("api_errors", Kind::ApiErrors),
        ("get_vertex_attrib", Kind::GetVertexAttrib),
    ] {
        group.add_child(Box::new(VertexAttrib64BitTest { name, kind }) as Box<dyn TestCase>);
    }
    group.add_child(Box::new(super::vertex_attrib_64bit_limits_tests::LimitTest) as Box<dyn TestCase>);
    group.add_child(Box::new(super::vertex_attrib_64bit_vao_tests::VaoTest) as Box<dyn TestCase>);
    group
}
