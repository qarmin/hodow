//! Port of `gl4cDirectStateAccessVertexArraysTests.cpp` (`DirectStateAccess::VertexArrays`).

use std::ffi::{CString, c_void};

use super::common_bugs_tests::Shader;
use super::direct_state_access_tests::{check_dsa_support, clean_errors, dsa_outcome};
use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `CheckError` of every test of this file: the next error has to be `expected`.
fn check_error(gl: &glw::Functions, expected: glw::GLenum, log_message: &str) -> bool {
    // SAFETY: plain state query.
    let error = unsafe { gl.get_error() };
    if expected != error {
        log::info!("{log_message} {} was observed instead.", glw::error_name(error));
        return false;
    }
    true
}

fn first_unused_name(is_name: impl Fn(glw::GLuint) -> glw::GLboolean) -> glw::GLuint {
    let mut name: glw::GLuint = 0;
    loop {
        name += 1;
        if is_name(name) == 0 {
            return name;
        }
    }
}

fn not_a_vao(gl: &glw::Functions) -> glw::GLuint {
    // SAFETY: plain query.
    first_unused_name(|name| unsafe { gl.is_vertex_array(name) })
}

fn not_a_bo(gl: &glw::Functions) -> glw::GLuint {
    // SAFETY: plain query.
    first_unused_name(|name| unsafe { gl.is_buffer(name) })
}

fn get_integer(gl: &glw::Functions, pname: glw::GLenum, default: glw::GLint) -> glw::GLint {
    let mut value = default;
    // SAFETY: writes one integer to the live local.
    unsafe { gl.get_integerv(pname, &mut value) };
    value
}

fn create_vertex_array(gl: &glw::Functions, vao: &mut glw::GLuint) -> Result<(), TestError> {
    // SAFETY: the name is written to the live local.
    unsafe { gl.create_vertex_arrays(1, vao) };
    glu::expect_no_error(gl, "glCreateVertexArrays call failed.")
}

// ------------------------------------------------------------------------------------------------------------------

/// `VertexArrays::CreationTest`
struct VertexArraysCreationTest;

impl TestCase for VertexArraysCreationTest {
    fn name(&self) -> &str {
        "vertex_arrays_creation"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const COUNT: usize = 2;
        let gl = context.gl();
        let mut vertex_arrays_legacy = [0 as glw::GLuint; COUNT];
        let mut vertex_arrays_dsa = [0 as glw::GLuint; COUNT];

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: COUNT names are written to the live array.
            unsafe { gl.gen_vertex_arrays(COUNT as glw::GLsizei, vertex_arrays_legacy.as_mut_ptr()) };
            glu::expect_no_error(gl, "glGenVertexArrays have failed")?;

            for vertex_array in &vertex_arrays_legacy {
                // SAFETY: plain query.
                if unsafe { gl.is_vertex_array(*vertex_array) } != 0 {
                    is_ok = false;
                    log::info!("GenVertexArrays has created default objects, but it should create only a names.");
                }
            }

            // SAFETY: COUNT names are written to the live array.
            unsafe { gl.create_vertex_arrays(COUNT as glw::GLsizei, vertex_arrays_dsa.as_mut_ptr()) };
            glu::expect_no_error(gl, "glCreateVertexArrays have failed")?;

            for vertex_array in &vertex_arrays_dsa {
                // SAFETY: plain query.
                if unsafe { gl.is_vertex_array(*vertex_array) } == 0 {
                    is_ok = false;
                    log::info!("CreateVertexArrays has not created default objects.");
                }
            }
            Ok(is_ok)
        });

        for vertex_array in vertex_arrays_legacy.iter().chain(&vertex_arrays_dsa) {
            if *vertex_array != 0 {
                // SAFETY: deletes a name generated above.
                unsafe { gl.delete_vertex_arrays(1, vertex_array) };
            }
        }
        clean_errors(gl);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// `VertexArrays::DefaultsTest`
struct VertexArraysDefaultsTest;

impl VertexArraysDefaultsTest {
    fn check(
        gl: &glw::Functions,
        vao: glw::GLuint,
        pname: glw::GLenum,
        pname_name: &str,
        expected: glw::GLint,
    ) -> Result<bool, TestError> {
        let mut result: glw::GLint = 0;
        // SAFETY: writes one integer to the live local.
        unsafe { gl.get_vertex_arrayiv(vao, pname, &mut result) };
        glu::expect_no_error(gl, "glGetVertexArrayiv call failed.")?;
        if result != expected {
            log::info!("{pname_name} equal to {result}, but {expected} was expected.");
            return Ok(false);
        }
        Ok(true)
    }

    fn check_indexed(
        gl: &glw::Functions,
        vao: glw::GLuint,
        pname: glw::GLenum,
        pname_name: &str,
        index: glw::GLuint,
        expected: glw::GLint,
    ) -> Result<bool, TestError> {
        let mut result: glw::GLint = 0;
        // SAFETY: writes one integer to the live local.
        unsafe { gl.get_vertex_array_indexediv(vao, index, pname, &mut result) };
        glu::expect_no_error(gl, "glGetVertexArrayIndexediv call failed.")?;
        if result != expected {
            log::info!("{pname_name} equal to {result}, but {expected} was expected.");
            return Ok(false);
        }
        Ok(true)
    }

    fn check_indexed_64(
        gl: &glw::Functions,
        vao: glw::GLuint,
        pname: glw::GLenum,
        pname_name: &str,
        index: glw::GLuint,
        expected: glw::GLint64,
    ) -> Result<bool, TestError> {
        let mut result: glw::GLint64 = 0;
        // SAFETY: writes one 64-bit integer to the live local.
        unsafe { gl.get_vertex_array_indexed_64iv(vao, index, pname, &mut result) };
        glu::expect_no_error(gl, "glGetVertexArrayIndexed64iv call failed.")?;
        if result != expected {
            log::info!("{pname_name} equal to {result}, but {expected} was expected.");
            return Ok(false);
        }
        Ok(true)
    }
}

impl TestCase for VertexArraysDefaultsTest {
    fn name(&self) -> &str {
        "vertex_arrays_defaults"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut vao: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let max_attributes = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIBS, 8);
            glu::expect_no_error(gl, "glGetIntegerv call failed.")?;

            create_vertex_array(gl, &mut vao)?;
            let false_value = glw::GL_FALSE as glw::GLint;

            for i in 0..max_attributes as glw::GLuint {
                is_ok &= Self::check_indexed(
                    gl,
                    vao,
                    glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED,
                    "GL_VERTEX_ATTRIB_ARRAY_ENABLED",
                    i,
                    false_value,
                )?;
                is_ok &= Self::check_indexed(
                    gl,
                    vao,
                    glw::GL_VERTEX_ATTRIB_ARRAY_SIZE,
                    "GL_VERTEX_ATTRIB_ARRAY_SIZE",
                    i,
                    4,
                )?;
                is_ok &= Self::check_indexed(
                    gl,
                    vao,
                    glw::GL_VERTEX_ATTRIB_ARRAY_STRIDE,
                    "GL_VERTEX_ATTRIB_ARRAY_STRIDE",
                    i,
                    0,
                )?;
                is_ok &= Self::check_indexed(
                    gl,
                    vao,
                    glw::GL_VERTEX_ATTRIB_ARRAY_TYPE,
                    "GL_VERTEX_ATTRIB_ARRAY_TYPE",
                    i,
                    glw::GL_FLOAT as glw::GLint,
                )?;
                is_ok &= Self::check_indexed(
                    gl,
                    vao,
                    glw::GL_VERTEX_ATTRIB_ARRAY_NORMALIZED,
                    "GL_VERTEX_ATTRIB_ARRAY_NORMALIZED",
                    i,
                    false_value,
                )?;
                is_ok &= Self::check_indexed(
                    gl,
                    vao,
                    glw::GL_VERTEX_ATTRIB_ARRAY_INTEGER,
                    "GL_VERTEX_ATTRIB_ARRAY_INTEGER",
                    i,
                    false_value,
                )?;
                is_ok &= Self::check_indexed(
                    gl,
                    vao,
                    glw::GL_VERTEX_ATTRIB_ARRAY_DIVISOR,
                    "GL_VERTEX_ATTRIB_ARRAY_DIVISOR",
                    i,
                    0,
                )?;
                is_ok &= Self::check_indexed(
                    gl,
                    vao,
                    glw::GL_VERTEX_ATTRIB_ARRAY_LONG,
                    "GL_VERTEX_ATTRIB_ARRAY_LONG",
                    i,
                    false_value,
                )?;
                is_ok &= Self::check_indexed(
                    gl,
                    vao,
                    glw::GL_VERTEX_ATTRIB_RELATIVE_OFFSET,
                    "GL_VERTEX_ATTRIB_RELATIVE_OFFSET",
                    i,
                    0,
                )?;
                is_ok &=
                    Self::check_indexed_64(gl, vao, glw::GL_VERTEX_BINDING_OFFSET, "GL_VERTEX_BINDING_OFFSET", i, 0)?;
            }

            is_ok &= Self::check(
                gl,
                vao,
                glw::GL_ELEMENT_ARRAY_BUFFER_BINDING,
                "GL_ELEMENT_ARRAY_BUFFER_BINDING",
                0,
            )?;
            Ok(is_ok)
        });

        if vao != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_vertex_arrays(1, &vao) };
        }
        clean_errors(gl);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// `VertexArrays::CreationErrorTest`
struct VertexArraysCreationErrorTest;

impl TestCase for VertexArraysCreationErrorTest {
    fn name(&self) -> &str {
        "vertex_arrays_creation_error"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut negative_vao: glw::GLuint = 0;
        // SAFETY: a negative count is the error this call is expected to generate; nothing is written.
        unsafe { gl.create_vertex_arrays(-1, &mut negative_vao) };
        let is_ok = check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated if n is negative.",
        );
        clean_errors(gl);
        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

// ------------------------------------------------------------------------------------------------------------------

#[derive(Default)]
struct ErrorObjects {
    vao: glw::GLuint,
    bo: glw::GLuint,
}

/// The negative tests share one shape: a body that creates the objects it needs in [`ErrorObjects`] and returns the verdict.
struct VertexArraysErrorsTest {
    name: &'static str,
    body: fn(&glw::Functions, &mut ErrorObjects) -> Result<bool, TestError>,
}

impl TestCase for VertexArraysErrorsTest {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = ErrorObjects::default();

        let outcome = dsa_outcome(|| (self.body)(gl, &mut objects));

        // SAFETY: deletes names created by the body.
        unsafe {
            if objects.vao != 0 {
                gl.delete_vertex_arrays(1, &objects.vao);
            }
            if objects.bo != 0 {
                gl.delete_buffers(1, &objects.bo);
            }
        }
        clean_errors(gl);
        outcome
    }
}

fn enable_disable_attribute_errors(gl: &glw::Functions, o: &mut ErrorObjects) -> Result<bool, TestError> {
    let mut is_ok = true;
    let max_attributes = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIBS, 8);
    glu::expect_no_error(gl, "glGetIntegerv call failed.")?;
    create_vertex_array(gl, &mut o.vao)?;
    let vao = o.vao;
    let not_a_vao = not_a_vao(gl);

    // SAFETY: every call below is expected to fail validation.
    unsafe {
        gl.enable_vertex_array_attrib(0, not_a_vao);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by EnableVertexArrayAttrib if vaobj is not the name of an existing vertex array object.",
        );
        gl.disable_vertex_array_attrib(0, not_a_vao);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by DisableVertexArrayAttrib if vaobj is not the name of an existing vertex array object.",
        );
        gl.enable_vertex_array_attrib(max_attributes as glw::GLuint, vao);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_VALUE was not generated by EnableVertexArrayAttrib if index is equal to MAX_VERTEX_ATTRIBS.",
        );
        gl.disable_vertex_array_attrib(max_attributes as glw::GLuint, vao);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_VALUE was not generated by DisableVertexArrayAttrib if index is equal to MAX_VERTEX_ATTRIBS.",
        );
        gl.enable_vertex_array_attrib(max_attributes as glw::GLuint + 1, vao);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_VALUE was not generated by EnableVertexArrayAttrib if index is greater than MAX_VERTEX_ATTRIBS.",
        );
        gl.disable_vertex_array_attrib(max_attributes as glw::GLuint + 1, vao);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_VALUE was not generated by DisableVertexArrayAttrib if index is greater than MAX_VERTEX_ATTRIBS.",
        );
    }
    Ok(is_ok)
}

fn element_buffer_errors(gl: &glw::Functions, o: &mut ErrorObjects) -> Result<bool, TestError> {
    let mut is_ok = true;
    create_vertex_array(gl, &mut o.vao)?;
    // SAFETY: the name is written to the live field.
    unsafe { gl.create_buffers(1, &mut o.bo) };
    glu::expect_no_error(gl, "glCreateBuffers call failed.")?;
    let (vao, bo) = (o.vao, o.bo);
    let not_a_vao = not_a_vao(gl);
    let not_a_bo = not_a_bo(gl);

    // SAFETY: every call below is expected to fail validation.
    unsafe {
        gl.vertex_array_element_buffer(not_a_vao, bo);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION error was not generated by VertexArrayElementBuffer if vaobj is not the name of an existing vertex array object.",
        );
        gl.vertex_array_element_buffer(vao, not_a_bo);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION error is generated by VertexArrayElementBuffer if buffer is not zero or the name of an existing buffer object.",
        );
    }
    Ok(is_ok)
}

fn vertex_buffers_errors(gl: &glw::Functions, o: &mut ErrorObjects) -> Result<bool, TestError> {
    let mut is_ok = true;
    let valid_offset: glw::GLintptr = 0;
    let valid_stride: glw::GLsizei = 1;

    create_vertex_array(gl, &mut o.vao)?;
    // SAFETY: the name is written to the live field.
    unsafe { gl.create_buffers(1, &mut o.bo) };
    glu::expect_no_error(gl, "glCreateBuffers call failed.")?;
    let (vao, bo) = (o.vao, o.bo);
    let not_a_vao = not_a_vao(gl);
    let not_a_bo = not_a_bo(gl);

    let max_vertex_attrib_bindings = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIB_BINDINGS, 16);
    let max_vertex_attrib_stride = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIB_STRIDE, 2048);
    glu::expect_no_error(gl, "glGetIntegerv call failed.")?;

    let invalid_offset: glw::GLintptr = -1;
    let invalid_stride_0: glw::GLsizei = -1;
    let invalid_stride_1: glw::GLsizei = max_vertex_attrib_stride + 1;
    let bindings = max_vertex_attrib_bindings as glw::GLuint;

    // SAFETY: every call below is expected to fail validation; the pointers refer to live locals holding one value each.
    unsafe {
        gl.vertex_array_vertex_buffer(not_a_vao, 0, bo, valid_offset, valid_stride);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by VertexArrayVertexBuffer if vaobj is not the name of an existing vertex array object.",
        );
        gl.vertex_array_vertex_buffers(not_a_vao, 0, 1, &bo, &valid_offset, &valid_stride);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by VertexArrayVertexBuffers if vaobj is not the name of an existing vertex array object.",
        );
        gl.vertex_array_vertex_buffer(vao, 0, not_a_bo, valid_offset, valid_stride);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by VertexArrayVertexBuffer if vaobj is not the name of an existing vertex array object.",
        );
        gl.vertex_array_vertex_buffers(vao, 0, 1, &not_a_bo, &valid_offset, &valid_stride);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by VertexArrayVertexBuffers if vaobj is not the name of an existing vertex array object.",
        );
        gl.vertex_array_vertex_buffer(vao, bindings, bo, valid_offset, valid_stride);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayVertexBuffer if bindingindex is equal to the value of MAX_VERTEX_ATTRIB_BINDINGS.",
        );
        gl.vertex_array_vertex_buffer(vao, bindings + 1, bo, valid_offset, valid_stride);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayVertexBuffer if bindingindex is greater than the value of MAX_VERTEX_ATTRIB_BINDINGS.",
        );
        gl.vertex_array_vertex_buffers(vao, bindings, 1, &bo, &valid_offset, &valid_stride);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by VertexArrayVertexBuffers if first+count is greater than the value of MAX_VERTEX_ATTRIB_BINDINGS.",
        );
        gl.vertex_array_vertex_buffer(vao, 0, bo, -1, valid_stride);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE is generated by VertexArrayVertexBuffer if offset less than zero.",
        );
        gl.vertex_array_vertex_buffer(vao, 0, bo, valid_offset, -1);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE is generated by VertexArrayVertexBuffer if stride is less than zero.",
        );
        gl.vertex_array_vertex_buffer(vao, 0, bo, valid_offset, max_vertex_attrib_stride + 1);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE is generated by VertexArrayVertexBuffer if stride is greater than the value of MAX_VERTEX_ATTRIB_STRIDE.",
        );
        gl.vertex_array_vertex_buffers(vao, 0, 1, &bo, &invalid_offset, &valid_stride);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE is generated by VertexArrayVertexBuffers if any value in offsets is negative.",
        );
        gl.vertex_array_vertex_buffers(vao, 0, 1, &bo, &valid_offset, &invalid_stride_0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE is generated by VertexArrayVertexBuffers if any value in strides is negative.",
        );
        gl.vertex_array_vertex_buffers(vao, 0, 1, &bo, &valid_offset, &invalid_stride_1);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE is generated by VertexArrayVertexBuffers if a value in strides is greater than the value of MAX_VERTEX_ATTRIB_STRIDE.",
        );
    }
    Ok(is_ok)
}

fn attribute_format_errors(gl: &glw::Functions, o: &mut ErrorObjects) -> Result<bool, TestError> {
    let mut is_ok = true;
    let accepted_types = [
        glw::GL_BYTE,
        glw::GL_SHORT,
        glw::GL_INT,
        glw::GL_FIXED,
        glw::GL_FLOAT,
        glw::GL_HALF_FLOAT,
        glw::GL_DOUBLE,
        glw::GL_UNSIGNED_BYTE,
        glw::GL_UNSIGNED_SHORT,
        glw::GL_UNSIGNED_INT,
        glw::GL_INT_2_10_10_10_REV,
        glw::GL_UNSIGNED_INT_2_10_10_10_REV,
        glw::GL_UNSIGNED_INT_10F_11F_11F_REV,
    ];
    let mut bad_type: glw::GLenum = 0;
    loop {
        bad_type += 1;
        if !accepted_types.contains(&bad_type) {
            break;
        }
    }

    create_vertex_array(gl, &mut o.vao)?;
    let vao = o.vao;
    let not_a_vao = not_a_vao(gl);
    let max_vertex_attribs = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIBS, 16);
    let max_vertex_attrib_relative_offset = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET, 2047);
    glu::expect_no_error(gl, "glGetIntegerv call failed.")?;
    let attribs = max_vertex_attribs as glw::GLuint;
    let relative_offset = max_vertex_attrib_relative_offset as glw::GLuint + 1;
    let (byte, double) = (glw::GL_BYTE, glw::GL_DOUBLE);
    let packed = glw::GL_UNSIGNED_INT_10F_11F_11F_REV;
    let bgra = glw::GL_BGRA as glw::GLint;

    // SAFETY: every call below is expected to fail validation.
    unsafe {
        gl.vertex_array_attrib_format(vao, attribs, 1, byte, glw::FALSE, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayAttribFormat if attribindex is equal to the value of MAX_VERTEX_ATTRIBS.",
        );
        gl.vertex_array_attrib_format(vao, attribs + 1, 1, byte, glw::FALSE, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayAttribFormat if attribindex is greater than the value of MAX_VERTEX_ATTRIBS.",
        );
        gl.vertex_array_attrib_i_format(vao, attribs, 1, byte, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayAttribIFormat if attribindex is equal to the value of MAX_VERTEX_ATTRIBS.",
        );
        gl.vertex_array_attrib_i_format(vao, attribs + 1, 1, byte, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayAttribIFormat if attribindex is greater than the value of MAX_VERTEX_ATTRIBS.",
        );
        gl.vertex_array_attrib_l_format(vao, attribs, 1, double, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayAttribLFormat if attribindex is equal to the value of MAX_VERTEX_ATTRIBS.",
        );
        gl.vertex_array_attrib_l_format(vao, attribs + 1, 1, double, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayAttribLFormat if attribindex is greater than the value of MAX_VERTEX_ATTRIBS.",
        );

        gl.vertex_array_attrib_format(vao, 0, 0, byte, glw::FALSE, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayAttrib*Format if size is not one of the accepted values (0).",
        );
        gl.vertex_array_attrib_format(vao, 0, 5, byte, glw::FALSE, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayAttrib*Format if size is not one of the accepted values (5).",
        );
        gl.vertex_array_attrib_i_format(vao, 0, 0, byte, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayAttribIFormat if size is not one of the accepted values (0).",
        );
        gl.vertex_array_attrib_i_format(vao, 0, 5, byte, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayAttribIFormat if size is not one of the accepted values (5).",
        );
        gl.vertex_array_attrib_l_format(vao, 0, 0, double, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayAttribLFormat if size is not one of the accepted values (0).",
        );
        gl.vertex_array_attrib_l_format(vao, 0, 5, double, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayAttribLFormat if size is not one of the accepted values (5).",
        );

        gl.vertex_array_attrib_format(vao, 0, 1, byte, glw::FALSE, relative_offset);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayAttrib*Format if relativeoffset is greater than the value of MAX_VERTEX_ATTRIB_RELATIVE_OFFSET.",
        );
        gl.vertex_array_attrib_i_format(vao, 0, 1, byte, relative_offset);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayAttribIFormat if relativeoffset is greater than the value of MAX_VERTEX_ATTRIB_RELATIVE_OFFSET.",
        );
        gl.vertex_array_attrib_l_format(vao, 0, 1, double, relative_offset);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayAttribLFormat if relativeoffset is greater than the value of MAX_VERTEX_ATTRIB_RELATIVE_OFFSET.",
        );

        gl.vertex_array_attrib_format(vao, 0, 1, bad_type, glw::FALSE, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_ENUM,
            "INVALID_ENUM was not generated by VertexArrayAttribFormat if type is not one of the accepted tokens.",
        );
        gl.vertex_array_attrib_i_format(vao, 0, 1, bad_type, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_ENUM,
            "INVALID_ENUM was not generated by VertexArrayAttribIFormat if type is not one of the accepted tokens.",
        );
        gl.vertex_array_attrib_l_format(vao, 0, 1, bad_type, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_ENUM,
            "INVALID_ENUM was not generated by VertexArrayAttribLFormat if type is not one of the accepted tokens.",
        );
        gl.vertex_array_attrib_i_format(vao, 0, 1, packed, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_ENUM,
            "INVALID_ENUM was not generated by VertexArrayAttribIFormat if type is UNSIGNED_INT_10F_11F_11F_REV.",
        );
        gl.vertex_array_attrib_l_format(vao, 0, 1, packed, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_ENUM,
            "INVALID_ENUM was not generated by VertexArrayAttribLFormat if type is UNSIGNED_INT_10F_11F_11F_REV.",
        );

        gl.vertex_array_attrib_format(not_a_vao, 0, 1, byte, glw::FALSE, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by VertexArrayAttribFormat if vaobj is not the name of an existing vertex array object.",
        );
        gl.vertex_array_attrib_i_format(not_a_vao, 0, 1, byte, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by VertexArrayAttribIFormat if vaobj is not the name of an existing vertex array object.",
        );
        gl.vertex_array_attrib_l_format(not_a_vao, 0, 1, double, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by VertexArrayAttribLFormat if vaobj is not the name of an existing vertex array object.",
        );

        gl.vertex_array_attrib_format(vao, 0, bgra, byte, glw::TRUE, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by VertexArrayAttribFormat if size is BGRA and type is not UNSIGNED_BYTE, INT_2_10_10_10_REV or UNSIGNED_INT_2_10_10_10_REV.",
        );
        gl.vertex_array_attrib_format(vao, 0, 1, glw::GL_INT_2_10_10_10_REV, glw::TRUE, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by VertexArrayAttribFormat if type is INT_2_10_10_10_REV and size is neither 4 nor BGRA.",
        );
        gl.vertex_array_attrib_format(vao, 0, 1, glw::GL_UNSIGNED_INT_2_10_10_10_REV, glw::TRUE, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by VertexArrayAttribFormat if type is UNSIGNED_INT_2_10_10_10_REV and size is neither 4 nor BGRA.",
        );
        gl.vertex_array_attrib_format(vao, 0, 1, packed, glw::TRUE, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by VertexArrayAttribFormat if type is UNSIGNED_INT_10F_11F_11F_REV and size is not 3.",
        );
        gl.vertex_array_attrib_format(vao, 0, bgra, glw::GL_UNSIGNED_BYTE, glw::FALSE, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by VertexArrayAttribFormat if size is BGRA and normalized is FALSE.",
        );
    }
    Ok(is_ok)
}

fn attribute_binding_errors(gl: &glw::Functions, o: &mut ErrorObjects) -> Result<bool, TestError> {
    let mut is_ok = true;
    create_vertex_array(gl, &mut o.vao)?;
    let vao = o.vao;
    let not_a_vao = not_a_vao(gl);
    let max_vertex_attribs = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIBS, 16) as glw::GLuint;
    let max_vertex_attrib_bindings = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIB_BINDINGS, 16) as glw::GLuint;
    glu::expect_no_error(gl, "glGetIntegerv call failed.")?;

    // SAFETY: every call below is expected to fail validation.
    unsafe {
        gl.vertex_array_attrib_binding(not_a_vao, 0, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by VertexArrayAttribBinding if vaobj is not the name of an existing vertex array object.",
        );
        gl.vertex_array_attrib_binding(vao, max_vertex_attribs, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayAttribBinding if attribindex is equal to the value of MAX_VERTEX_ATTRIBS.",
        );
        gl.vertex_array_attrib_binding(vao, max_vertex_attribs + 1, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayAttribBinding if attribindex is greater than the value of MAX_VERTEX_ATTRIBS.",
        );
        gl.vertex_array_attrib_binding(vao, 0, max_vertex_attrib_bindings);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayAttribBinding if bindingindex is equal to the value of MAX_VERTEX_ATTRIB_BINDINGS.",
        );
        gl.vertex_array_attrib_binding(vao, 0, max_vertex_attrib_bindings + 1);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayAttribBinding if bindingindex is greater than the value of MAX_VERTEX_ATTRIB_BINDINGS.",
        );
    }
    Ok(is_ok)
}

fn attribute_binding_divisor_errors(gl: &glw::Functions, o: &mut ErrorObjects) -> Result<bool, TestError> {
    let mut is_ok = true;
    create_vertex_array(gl, &mut o.vao)?;
    let vao = o.vao;
    let not_a_vao = not_a_vao(gl);
    let max_vertex_attrib_bindings = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIB_BINDINGS, 16) as glw::GLuint;
    glu::expect_no_error(gl, "glGetIntegerv call failed.")?;

    // SAFETY: every call below is expected to fail validation.
    unsafe {
        gl.vertex_array_binding_divisor(not_a_vao, 0, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION was not generated by VertexArrayBindingDivisor if vaobj is not the name of an existing vertex array object.",
        );
        gl.vertex_array_binding_divisor(vao, max_vertex_attrib_bindings, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayBindingDivisor if bindingindex is equal to the value of MAX_VERTEX_ATTRIB_BINDINGS.",
        );
        gl.vertex_array_binding_divisor(vao, max_vertex_attrib_bindings + 1, 0);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_VALUE,
            "INVALID_VALUE was not generated by VertexArrayBindingDivisor if bindingindex is greater than the value of MAX_VERTEX_ATTRIB_BINDINGS.",
        );
    }
    Ok(is_ok)
}

fn get_vertex_array_errors(gl: &glw::Functions, o: &mut ErrorObjects) -> Result<bool, TestError> {
    let mut is_ok = true;
    let mut storage: glw::GLint = 0;
    create_vertex_array(gl, &mut o.vao)?;
    let vao = o.vao;
    let not_a_vao = not_a_vao(gl);

    // SAFETY: every call below is expected to fail validation; the pointer refers to a live integer.
    unsafe {
        gl.get_vertex_arrayiv(not_a_vao, glw::GL_ELEMENT_ARRAY_BUFFER_BINDING, &mut storage);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION error was not generated by GetVertexArrayiv if vaobj is not the name of an existing vertex array object.",
        );
        gl.get_vertex_arrayiv(vao, glw::GL_ELEMENT_ARRAY_BUFFER_BINDING + 1, &mut storage);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_ENUM,
            "INVALID_ENUM error was not generated by GetVertexArrayiv if pname is not ELEMENT_ARRAY_BUFFER_BINDING.",
        );
    }
    Ok(is_ok)
}

fn get_vertex_array_indexed_errors(gl: &glw::Functions, o: &mut ErrorObjects) -> Result<bool, TestError> {
    let mut is_ok = true;
    let mut storage: glw::GLint = 0;
    let mut storage64: glw::GLint64 = 0;
    let accepted_pnames = [
        glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED,
        glw::GL_VERTEX_ATTRIB_ARRAY_SIZE,
        glw::GL_VERTEX_ATTRIB_ARRAY_STRIDE,
        glw::GL_VERTEX_ATTRIB_ARRAY_TYPE,
        glw::GL_VERTEX_ATTRIB_ARRAY_NORMALIZED,
        glw::GL_VERTEX_ATTRIB_ARRAY_INTEGER,
        glw::GL_VERTEX_ATTRIB_ARRAY_LONG,
        glw::GL_VERTEX_ATTRIB_ARRAY_DIVISOR,
        glw::GL_VERTEX_ATTRIB_RELATIVE_OFFSET,
    ];
    let mut bad_pname: glw::GLenum = 0;
    loop {
        bad_pname += 1;
        if !accepted_pnames.contains(&bad_pname) {
            break;
        }
    }

    create_vertex_array(gl, &mut o.vao)?;
    let vao = o.vao;
    let not_a_vao = not_a_vao(gl);

    // SAFETY: every call below is expected to fail validation; the pointers refer to live integers.
    unsafe {
        gl.get_vertex_array_indexediv(not_a_vao, 0, glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED, &mut storage);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION error was not generated by GetVertexArrayIndexediv if vaobj is not the name of an existing vertex array object.",
        );
        gl.get_vertex_array_indexed_64iv(not_a_vao, 0, glw::GL_VERTEX_BINDING_OFFSET, &mut storage64);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "INVALID_OPERATION error was not generated by GetVertexArrayIndexed64iv if vaobj is not the name of an existing vertex array object.",
        );
        gl.get_vertex_array_indexediv(vao, 0, bad_pname, &mut storage);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_ENUM,
            "INVALID_ENUM error was not generated by GetVertexArrayIndexediv if pname is not one of the valid values.",
        );
        gl.get_vertex_array_indexed_64iv(vao, 0, glw::GL_VERTEX_BINDING_OFFSET + 1, &mut storage64);
        is_ok &= check_error(
            gl,
            glw::GL_INVALID_ENUM,
            "INVALID_ENUM error was not generated by GetVertexArrayIndexed64iv if pname is not VERTEX_BINDING_OFFSET.",
        );
    }
    Ok(is_ok)
}

// ------------------------------------------------------------------------------------------------------------------
// Shared by the functional tests: a transform-feedback program, the feedback buffer and the draw-and-read step.

const FRAGMENT_SHADER: &str = "#version 450\n\nout vec4 color;\n\nvoid main()\n{\n    color = vec4(1.0);}\n";

/// The `PrepareProgram`/`BuildProgram` member of the functional tests: a failure deletes the program and is rethrown.
fn build_program(
    gl: &glw::Functions,
    vertex_shader: &str,
    fragment_shader: &str,
    xfb_varying: &str,
    attribute_bindings: &[(glw::GLuint, String)],
) -> Result<glw::GLuint, TestError> {
    // SAFETY: plain object creation with a current context.
    let po = unsafe { gl.create_program() };
    let result = (|| -> Result<(), TestError> {
        glu::expect_no_error(gl, "glCreateProgram call failed.")?;

        let mut shaders = Vec::new();
        for (source, shader_type) in [
            (vertex_shader, glw::GL_VERTEX_SHADER),
            (fragment_shader, glw::GL_FRAGMENT_SHADER),
        ] {
            let shader = Shader::new(gl, shader_type)?;
            // SAFETY: both objects are alive.
            unsafe { gl.attach_shader(po, shader.id) };
            glu::expect_no_error(gl, "glAttachShader call failed.")?;
            shader.source(&[source])?;
            if !shader.compile()? {
                log::info!("Shader type {shader_type:#x} compilation failed. Shader source code:\n{source}");
                return Err(TestError::Fail("shader compilation failed".to_string()));
            }
            shaders.push(shader);
        }

        let xfb_varying = CString::new(xfb_varying).expect("no NUL in the name");
        let varyings = [xfb_varying.as_ptr()];
        // SAFETY: one live NUL-terminated name is passed.
        unsafe { gl.transform_feedback_varyings(po, 1, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS) };
        glu::expect_no_error(gl, "glTransformFeedbackVaryings call failed.")?;

        for (index, attribute) in attribute_bindings {
            let attribute = CString::new(attribute.as_str()).expect("no NUL in the name");
            // SAFETY: the name is a live NUL-terminated string.
            unsafe { gl.bind_attrib_location(po, *index, attribute.as_ptr()) };
            glu::expect_no_error(gl, "glBindAttribLocation call failed.")?;
        }

        // SAFETY: the program is alive.
        unsafe { gl.link_program(po) };
        glu::expect_no_error(gl, "glTransformFeedbackVaryings call failed.")?;
        let mut status = glw::GL_FALSE as glw::GLint;
        // SAFETY: writes one integer to the live local.
        unsafe { gl.get_programiv(po, glw::GL_LINK_STATUS, &mut status) };
        if status != glw::GL_TRUE as glw::GLint {
            log::info!("Program linking failed.");
            return Err(TestError::Fail("program link failed".to_string()));
        }
        for shader in &shaders {
            // SAFETY: both objects are alive.
            unsafe { gl.detach_shader(po, shader.id) };
            glu::expect_no_error(gl, "glDetachShader call failed.")?;
        }
        Ok(())
    })();

    if let Err(error) = result {
        // SAFETY: deletes the program created above.
        unsafe { gl.delete_program(po) };
        return Err(error);
    }
    Ok(po)
}

fn gen_bound_buffer(gl: &glw::Functions, target: glw::GLenum, buffer: &mut glw::GLuint) -> Result<(), TestError> {
    // SAFETY: the name is written to the live local and then bound.
    unsafe {
        gl.gen_buffers(1, buffer);
        glu::expect_no_error(gl, "glGenBuffers call failed.")?;
        gl.bind_buffer(target, *buffer);
        glu::expect_no_error(gl, "glBindBuffer call failed.")?;
    }
    Ok(())
}

fn buffer_data_static<T>(gl: &glw::Functions, target: glw::GLenum, data: &[T]) -> Result<(), TestError> {
    // SAFETY: the pointer and size describe the slice.
    unsafe {
        gl.buffer_data(
            target,
            std::mem::size_of_val(data) as glw::GLsizeiptr,
            data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        )
    };
    glu::expect_no_error(gl, "glBufferData call failed.")
}

/// `PrepareXFB`: a read-only feedback buffer of `count` integers bound to index 0.
fn prepare_xfb(gl: &glw::Functions, bo_xfb: &mut glw::GLuint, count: usize) -> Result<(), TestError> {
    gen_bound_buffer(gl, glw::GL_TRANSFORM_FEEDBACK_BUFFER, bo_xfb)?;
    // SAFETY: the buffer is bound; no initial data is passed.
    unsafe {
        gl.buffer_storage(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            (count * std::mem::size_of::<glw::GLint>()) as glw::GLsizeiptr,
            std::ptr::null(),
            glw::GL_MAP_READ_BIT,
        );
        glu::expect_no_error(gl, "glBufferStorage call failed.")?;
        gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, *bo_xfb);
        glu::expect_no_error(gl, "glBindBufferBase call failed.")?;
    }
    Ok(())
}

/// The tail of every `DrawAndCheck`: end feedback, read `count` integers from the mapped buffer.
fn end_xfb_and_read(gl: &glw::Functions, count: usize) -> Result<Vec<glw::GLint>, TestError> {
    // SAFETY: the mapping holds the `count` integers of the feedback buffer and is read before it is unmapped.
    unsafe {
        gl.end_transform_feedback();
        glu::expect_no_error(gl, "glEndTransformFeedback call failed.")?;

        let result_ptr = gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY) as *const glw::GLint;
        glu::expect_no_error(gl, "glMapBuffer call failed.")?;
        let result = std::slice::from_raw_parts(result_ptr, count).to_vec();
        gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER);
        glu::expect_no_error(gl, "glUnmapBuffer call failed.")?;
        Ok(result)
    }
}

fn begin_xfb_points(gl: &glw::Functions, po: glw::GLuint, vao: glw::GLuint) -> Result<(), TestError> {
    // SAFETY: plain state changes.
    unsafe {
        gl.use_program(po);
        glu::expect_no_error(gl, "glUseProgram call failed.")?;
        gl.bind_vertex_array(vao);
        glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
        gl.begin_transform_feedback(glw::GL_POINTS);
        glu::expect_no_error(gl, "glBeginTransformFeedback call failed.")?;
    }
    Ok(())
}

/// The `Clean` shared by the functional tests (program, vertex array, buffers).
fn clean_objects(gl: &glw::Functions, po: &mut glw::GLuint, vao: &mut glw::GLuint, buffers: &mut [glw::GLuint]) {
    // SAFETY: deletes names created by the test.
    unsafe {
        gl.use_program(0);
        if *po != 0 {
            gl.delete_program(*po);
            *po = 0;
        }
        if *vao != 0 {
            gl.delete_vertex_arrays(1, vao);
            *vao = 0;
        }
        for buffer in buffers {
            if *buffer != 0 {
                gl.delete_buffers(1, buffer);
                *buffer = 0;
            }
        }
    }
    clean_errors(gl);
}

// ------------------------------------------------------------------------------------------------------------------

/// `VertexArrays::EnableDisableAttributesTest`
struct VertexArraysEnableDisableAttributesTest;

#[derive(Default)]
struct EnableDisableObjects {
    po_even: glw::GLuint,
    po_odd: glw::GLuint,
    vao: glw::GLuint,
    bo: glw::GLuint,
    bo_xfb: glw::GLuint,
}

impl VertexArraysEnableDisableAttributesTest {
    const VERTEX_SHADER_TEMPLATE: &'static str =
        "#version 450\n\nDECLARATION_TEMPLATEout int sum;\n\nvoid main()\n{\nCOPY_TEMPLATE}\n";

    fn prepare_program(
        gl: &glw::Functions,
        max_attributes: glw::GLint,
        bind_even_or_odd: bool,
    ) -> Result<glw::GLuint, TestError> {
        let mut declarations = String::new();
        let mut copies = String::from("    sum = 0;\n");
        let mut bindings = Vec::new();
        for i in (bind_even_or_odd as glw::GLint..max_attributes).step_by(2) {
            declarations.push_str(&format!("in int a_{i};\n"));
            copies.push_str(&format!("    sum += a_{i};\n"));
            bindings.push((i as glw::GLuint, format!("a_{i}")));
        }
        let vs_source = Self::VERTEX_SHADER_TEMPLATE
            .replace("DECLARATION_TEMPLATE", &declarations)
            .replace("COPY_TEMPLATE", &copies);
        build_program(gl, &vs_source, FRAGMENT_SHADER, "sum", &bindings)
    }

    fn prepare_vao(
        gl: &glw::Functions,
        o: &mut EnableDisableObjects,
        max_attributes: glw::GLint,
    ) -> Result<(), TestError> {
        // SAFETY: the name is written to the live field and then bound.
        unsafe {
            gl.gen_vertex_arrays(1, &mut o.vao);
            glu::expect_no_error(gl, "glGenVertexArrays call failed.")?;
            gl.bind_vertex_array(o.vao);
            glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
        }
        gen_bound_buffer(gl, glw::GL_ARRAY_BUFFER, &mut o.bo)?;

        let reference_data: Vec<glw::GLint> = (0..max_attributes).collect();
        buffer_data_static(gl, glw::GL_ARRAY_BUFFER, &reference_data)?;

        for i in 0..max_attributes {
            let stride = (std::mem::size_of::<glw::GLint>() * max_attributes as usize) as glw::GLsizei;
            let offset = i as usize * std::mem::size_of::<glw::GLint>();
            // SAFETY: the offset is relative to the bound array buffer.
            unsafe { gl.vertex_attrib_i_pointer(i as glw::GLuint, 1, glw::GL_INT, stride, offset as *const c_void) };
            glu::expect_no_error(gl, "glVertexAttribIPointer call failed.")?;
        }
        Ok(())
    }

    fn turn_on_attributes(
        gl: &glw::Functions,
        vao: glw::GLuint,
        max_attributes: glw::GLint,
        enable_even: bool,
        enable_odd: bool,
    ) -> Result<bool, TestError> {
        // SAFETY: plain state change.
        unsafe { gl.bind_vertex_array(0) };
        glu::expect_no_error(gl, "glBindVertexArray call failed.")?;

        for i in 0..max_attributes {
            let mut disable = true;
            let enable = if i % 2 != 0 { enable_odd } else { enable_even };
            if enable {
                // SAFETY: plain state change.
                unsafe { gl.enable_vertex_array_attrib(vao, i as glw::GLuint) };
                // SAFETY: plain state query.
                let error = unsafe { gl.get_error() };
                if error != glw::GL_NO_ERROR {
                    log::info!("{} when called with VAO {vao} and index {i}.", glw::error_name(error));
                    return Ok(false);
                }
                disable = false;
            }

            if disable {
                // SAFETY: plain state change.
                unsafe { gl.disable_vertex_array_attrib(vao, i as glw::GLuint) };
                // SAFETY: plain state query.
                let error = unsafe { gl.get_error() };
                if error != glw::GL_NO_ERROR {
                    log::info!("{} when called with VAO {vao} and index {i}.", glw::error_name(error));
                    return Ok(false);
                }
            }
        }

        // SAFETY: plain state change.
        unsafe { gl.bind_vertex_array(vao) };
        glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
        Ok(true)
    }

    fn draw_and_check(
        gl: &glw::Functions,
        o: &EnableDisableObjects,
        max_attributes: glw::GLint,
        bind_even_or_odd: bool,
    ) -> Result<bool, TestError> {
        begin_xfb_points(gl, if bind_even_or_odd { o.po_odd } else { o.po_even }, o.vao)?;
        // SAFETY: draws one point into the feedback buffer.
        unsafe { gl.draw_arrays(glw::GL_POINTS, 0, 1) };
        glu::expect_no_error(gl, "glDrawArrays call failed.")?;
        let result = end_xfb_and_read(gl, 1)?[0];

        let reference_sum: glw::GLint = (bind_even_or_odd as glw::GLint..max_attributes).step_by(2).sum();
        Ok(reference_sum == result)
    }
}

impl TestCase for VertexArraysEnableDisableAttributesTest {
    fn name(&self) -> &str {
        "vertex_arrays_enable_disable_attributes"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut o = EnableDisableObjects::default();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let max_attributes = get_integer(gl, glw::GL_MAX_VERTEX_ATTRIBS, 16);
            glu::expect_no_error(gl, "glGetIntegerv(GL_MAX_VERTEX_ATTRIBS, ...) have failed")?;

            o.po_even = Self::prepare_program(gl, max_attributes, false)?;
            o.po_odd = Self::prepare_program(gl, max_attributes, true)?;
            Self::prepare_vao(gl, &mut o, max_attributes)?;
            prepare_xfb(gl, &mut o.bo_xfb, 1)?;

            is_ok &= Self::turn_on_attributes(gl, o.vao, max_attributes, true, false)?;
            is_ok &= Self::draw_and_check(gl, &o, max_attributes, false)?;
            is_ok &= Self::turn_on_attributes(gl, o.vao, max_attributes, false, true)?;
            is_ok &= Self::draw_and_check(gl, &o, max_attributes, true)?;
            Ok(is_ok)
        });

        // SAFETY: deletes names created by the test.
        unsafe {
            gl.use_program(0);
            for po in [o.po_even, o.po_odd] {
                if po != 0 {
                    gl.delete_program(po);
                }
            }
        }
        let mut no_program: glw::GLuint = 0;
        clean_objects(gl, &mut no_program, &mut o.vao, &mut [o.bo, o.bo_xfb]);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// `VertexArrays::ElementBufferTest`
struct VertexArraysElementBufferTest;

impl VertexArraysElementBufferTest {
    const VERTEX_SHADER: &'static str =
        "#version 450\n\nin int a;out int result;\n\nvoid main()\n{\n    gl_Position = vec4(1.0);\n    result = a;}\n";
}

impl TestCase for VertexArraysElementBufferTest {
    fn name(&self) -> &str {
        "vertex_arrays_element_buffer"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let (mut po, mut vao, mut bo_array, mut bo_elements, mut bo_xfb) = (
            0 as glw::GLuint,
            0 as glw::GLuint,
            0 as glw::GLuint,
            0 as glw::GLuint,
            0 as glw::GLuint,
        );

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            po = build_program(gl, Self::VERTEX_SHADER, FRAGMENT_SHADER, "result", &[])?;

            // PrepareVAO
            // SAFETY: the name is written to the live local and then bound.
            unsafe {
                gl.gen_vertex_arrays(1, &mut vao);
                glu::expect_no_error(gl, "glGenVertexArrays call failed.")?;
                gl.bind_vertex_array(vao);
                glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
            }
            gen_bound_buffer(gl, glw::GL_ARRAY_BUFFER, &mut bo_array)?;
            buffer_data_static(gl, glw::GL_ARRAY_BUFFER, &[2 as glw::GLint, 1, 0])?;
            let attribute = CString::new("a").expect("no NUL in the name");
            // SAFETY: the name is a live NUL-terminated string; the offset is relative to the bound array buffer.
            unsafe {
                let location = gl.get_attrib_location(po, attribute.as_ptr()) as glw::GLuint;
                gl.vertex_attrib_i_pointer(location, 1, glw::GL_INT, 0, std::ptr::null());
                glu::expect_no_error(gl, "glVertexAttribIPointer call failed.")?;
                gl.enable_vertex_attrib_array(0);
                glu::expect_no_error(gl, "glEnableVertexAttribArray call failed.")?;
                gl.bind_vertex_array(0);
                glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
            }

            gen_bound_buffer(gl, glw::GL_ELEMENT_ARRAY_BUFFER, &mut bo_elements)?;
            buffer_data_static(gl, glw::GL_ELEMENT_ARRAY_BUFFER, &[2 as glw::GLuint, 1, 0])?;
            // SAFETY: plain state change; the call is checked right below.
            unsafe { gl.vertex_array_element_buffer(vao, bo_elements) };
            // SAFETY: plain state query.
            let error = unsafe { gl.get_error() };
            if error != glw::GL_NO_ERROR {
                log::info!("{}error. Test fails.", glw::error_name(error));
                is_ok = false;
            }

            prepare_xfb(gl, &mut bo_xfb, 3)?;

            // DrawAndCheck
            begin_xfb_points(gl, po, vao)?;
            // SAFETY: the element buffer holds three indices.
            unsafe { gl.draw_elements(glw::GL_POINTS, 3, glw::GL_UNSIGNED_INT, std::ptr::null()) };
            glu::expect_no_error(gl, "glDrawArrays call failed.")?;
            let result = end_xfb_and_read(gl, 3)?;
            for (i, value) in result.iter().enumerate() {
                if i as glw::GLint != *value {
                    log::info!("Element buffer test failed: result[{i}] is {value}.");
                    is_ok = false;
                    break;
                }
            }
            Ok(is_ok)
        });

        clean_objects(gl, &mut po, &mut vao, &mut [bo_array, bo_elements, bo_xfb]);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// The `T` of the templated helpers of `AttributeFormatTest`.
trait AttributeScalar: Copy + Default + std::fmt::Display + std::ops::Add<Output = Self> {
    /// `NormalizationScaleFactor<T>`
    const NORMALIZATION_SCALE_FACTOR: f64;

    /// The C++ cast `(T)(value)`.
    fn from_f64(value: f64) -> Self;

    fn compare(a: Self, b: Self) -> bool;
}

macro_rules! impl_attribute_scalar_int {
    ($($t:ty => $scale:expr),* $(,)?) => {$(
        impl AttributeScalar for $t {
            const NORMALIZATION_SCALE_FACTOR: f64 = $scale;

            fn from_f64(value: f64) -> Self {
                value as $t
            }

            fn compare(a: Self, b: Self) -> bool {
                a == b
            }
        }
    )*};
}

impl_attribute_scalar_int!(
    glw::GLubyte => 16.0,
    glw::GLbyte => 8.0,
    glw::GLushort => 4096.0,
    glw::GLshort => 2048.0,
    glw::GLuint => 268435456.0,
    glw::GLint => 134217728.0,
);

macro_rules! impl_attribute_scalar_float {
    ($($t:ty),*) => {$(
        impl AttributeScalar for $t {
            const NORMALIZATION_SCALE_FACTOR: f64 = 1.0;

            fn from_f64(value: f64) -> Self {
                value as $t
            }

            fn compare(a: Self, b: Self) -> bool {
                (a - b).abs() < 0.03125
            }
        }
    )*};
}

impl_attribute_scalar_float!(glw::GLfloat, glw::GLdouble);

#[derive(Clone, Copy, PartialEq)]
enum AttributeFormatFunction {
    Float,
    Double,
    Integer,
}

/// `VertexArrays::AttributeFormatTest`
struct VertexArraysAttributeFormatTest;

#[derive(Default)]
struct AttributeFormatObjects {
    po: glw::GLuint,
    vao: glw::GLuint,
    bo_array: glw::GLuint,
    bo_xfb: glw::GLuint,
}

impl VertexArraysAttributeFormatTest {
    const VERTEX_SHADER_HEAD: &'static str = "#version 450\n\n";
    const VERTEX_SHADER_BODY: &'static str =
        "\nvoid main()\n{\n    gl_Position = vec4(1.0);\n    result = a_0 + a_1;}\n";

    fn vertex_shader_declaration(function: AttributeFormatFunction, size: usize) -> String {
        let type_name = match (function, size) {
            (AttributeFormatFunction::Float, 1) => "float",
            (AttributeFormatFunction::Float, 2) => "vec2",
            (AttributeFormatFunction::Float, 3) => "vec3",
            (AttributeFormatFunction::Float, _) => "vec4",
            (AttributeFormatFunction::Double, 1) => "double",
            (AttributeFormatFunction::Double, 2) => "dvec2",
            (AttributeFormatFunction::Double, 3) => "dvec3",
            (AttributeFormatFunction::Double, _) => "dvec4",
            (AttributeFormatFunction::Integer, 1) => "int",
            (AttributeFormatFunction::Integer, 2) => "ivec2",
            (AttributeFormatFunction::Integer, 3) => "ivec3",
            (AttributeFormatFunction::Integer, _) => "ivec4",
        };
        format!("in  {type_name} a_0;in  {type_name} a_1;out {type_name} result;\n")
    }

    fn prepare_program(
        gl: &glw::Functions,
        o: &mut AttributeFormatObjects,
        size: usize,
        function: AttributeFormatFunction,
    ) -> Result<(), TestError> {
        let vertex_shader = format!(
            "{}{}{}",
            Self::VERTEX_SHADER_HEAD,
            Self::vertex_shader_declaration(function, size),
            Self::VERTEX_SHADER_BODY
        );
        o.po = build_program(gl, &vertex_shader, FRAGMENT_SHADER, "result", &[])?;
        Ok(())
    }

    fn array_data<T: AttributeScalar>(scale: f64) -> [T; 16] {
        std::array::from_fn(|i| T::from_f64(i as f64 * scale))
    }

    fn prepare_vao<T: AttributeScalar>(
        gl: &glw::Functions,
        o: &mut AttributeFormatObjects,
        size: usize,
        type_gl_name: glw::GLenum,
        normalized: bool,
        function: AttributeFormatFunction,
    ) -> Result<bool, TestError> {
        // SAFETY: the name is written to the live field and then bound.
        unsafe {
            gl.gen_vertex_arrays(1, &mut o.vao);
            glu::expect_no_error(gl, "glGenVertexArrays call failed.")?;
            gl.bind_vertex_array(o.vao);
            glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
        }

        let scale = if normalized { T::NORMALIZATION_SCALE_FACTOR } else { 1.0 };
        let array_data = Self::array_data::<T>(scale);
        gen_bound_buffer(gl, glw::GL_ARRAY_BUFFER, &mut o.bo_array)?;
        buffer_data_static(gl, glw::GL_ARRAY_BUFFER, &array_data)?;

        let a_0 = CString::new("a_0").expect("no NUL in the name");
        let a_1 = CString::new("a_1").expect("no NUL in the name");
        let element_size = std::mem::size_of::<T>();
        // SAFETY: the names are live NUL-terminated strings.
        unsafe {
            let location_0 = gl.get_attrib_location(o.po, a_0.as_ptr()) as glw::GLuint;
            let location_1 = gl.get_attrib_location(o.po, a_1.as_ptr()) as glw::GLuint;
            gl.vertex_attrib_binding(location_0, 0);
            glu::expect_no_error(gl, "glVertexAttribBinding call failed.")?;
            gl.vertex_attrib_binding(location_1, 1);
            glu::expect_no_error(gl, "glVertexAttribBinding call failed.")?;

            for location in [location_0, location_1] {
                match function {
                    AttributeFormatFunction::Float => gl.vertex_array_attrib_format(
                        o.vao,
                        location,
                        size as glw::GLint,
                        type_gl_name,
                        normalized as glw::GLboolean,
                        0,
                    ),
                    AttributeFormatFunction::Double => {
                        gl.vertex_array_attrib_l_format(o.vao, location, size as glw::GLint, type_gl_name, 0)
                    }
                    AttributeFormatFunction::Integer => {
                        gl.vertex_array_attrib_i_format(o.vao, location, size as glw::GLint, type_gl_name, 0)
                    }
                }
            }

            let error = gl.get_error();
            if error != glw::GL_NO_ERROR {
                let function_name = match function {
                    AttributeFormatFunction::Float => "VertexArrayAttribFormat",
                    AttributeFormatFunction::Double => "VertexArrayAttribLFormat",
                    AttributeFormatFunction::Integer => "VertexArrayAttribIFormat",
                };
                log::info!(
                    "{function_name} has unexpectedly generated {} error for test with size = {size}, type = {type_gl_name:#x}, normalized = {normalized}. Test fails.",
                    glw::error_name(error)
                );
                return Ok(false);
            }

            let stride = (element_size * size * 2) as glw::GLsizei;
            gl.bind_vertex_buffer(0, o.bo_array, 0, stride);
            gl.bind_vertex_buffer(1, o.bo_array, (size * element_size) as glw::GLintptr, stride);
            glu::expect_no_error(gl, "glBufferData call failed.")?;
            gl.enable_vertex_attrib_array(0);
            glu::expect_no_error(gl, "glEnableVertexAttribArray call failed.")?;
            gl.enable_vertex_attrib_array(1);
            glu::expect_no_error(gl, "glEnableVertexAttribArray call failed.")?;
            gl.bind_vertex_array(0);
            glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
        }
        Ok(true)
    }

    fn draw_and_check<T: AttributeScalar>(
        gl: &glw::Functions,
        o: &AttributeFormatObjects,
        size: usize,
        normalized: bool,
    ) -> Result<bool, TestError> {
        begin_xfb_points(gl, o.po, o.vao)?;
        // SAFETY: draws two points into the feedback buffer.
        unsafe { gl.draw_arrays(glw::GL_POINTS, 0, 2) };
        glu::expect_no_error(gl, "glDrawArrays call failed.")?;

        let mut result = [T::default(); 8];
        // SAFETY: the mapping holds size * 2 values of T and is read before it is unmapped.
        unsafe {
            gl.end_transform_feedback();
            glu::expect_no_error(gl, "glEndTransformFeedback call failed.")?;
            let result_ptr = gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY) as *const T;
            glu::expect_no_error(gl, "glMapBuffer call failed.")?;
            for (i, value) in result.iter_mut().enumerate().take(size * 2) {
                *value = result_ptr.add(i).read_unaligned();
            }
            gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER);
            glu::expect_no_error(gl, "glUnmapBuffer call failed.")?;
        }

        let scale = if normalized { 1.0 / 16.0 } else { 1.0 };
        let array_data = Self::array_data::<T>(scale);
        let mut reference = [T::default(); 8];
        for i in 0..2 {
            for j in 0..size {
                reference[i * size + j] = array_data[i * size * 2 + j] + array_data[i * size * 2 + j + size];
            }
        }

        for i in 0..size * 2 {
            if !T::compare(reference[i], result[i]) {
                let reference_str: Vec<String> = reference[..size * 2].iter().map(|value| value.to_string()).collect();
                let result_str: Vec<String> = result[..size * 2].iter().map(|value| value.to_string()).collect();
                log::info!(
                    "Attribute format test failed (size {size}, normalized {normalized}): the result was [ {} ], but [ {} ] was expected.",
                    result_str.join(", "),
                    reference_str.join(", ")
                );
                return Ok(false);
            }
        }
        Ok(true)
    }

    fn clean_program(gl: &glw::Functions, o: &mut AttributeFormatObjects) {
        // SAFETY: deletes the program created by the test.
        unsafe {
            gl.use_program(0);
            if o.po != 0 {
                gl.delete_program(o.po);
                o.po = 0;
            }
        }
    }

    fn clean_vao(gl: &glw::Functions, o: &mut AttributeFormatObjects) {
        // SAFETY: deletes names created by the test.
        unsafe {
            if o.vao != 0 {
                gl.delete_vertex_arrays(1, &o.vao);
                o.vao = 0;
            }
            if o.bo_array != 0 {
                gl.delete_buffers(1, &o.bo_array);
                o.bo_array = 0;
            }
        }
    }

    /// One `PrepareVAO<V>` / `DrawAndCheck<R>` / `CleanVAO` round.
    fn round<V: AttributeScalar, R: AttributeScalar>(
        gl: &glw::Functions,
        o: &mut AttributeFormatObjects,
        size: usize,
        type_gl_name: glw::GLenum,
        normalized: bool,
        function: AttributeFormatFunction,
    ) -> Result<bool, TestError> {
        let mut is_ok = Self::prepare_vao::<V>(gl, o, size, type_gl_name, normalized, function)?;
        is_ok &= Self::draw_and_check::<R>(gl, o, size, normalized)?;
        Self::clean_vao(gl, o);
        Ok(is_ok)
    }
}

impl TestCase for VertexArraysAttributeFormatTest {
    fn name(&self) -> &str {
        "vertex_arrays_attribute_format"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut o = AttributeFormatObjects::default();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            // The widest type (double) times the maximum number of components.
            prepare_xfb(gl, &mut o.bo_xfb, 8 * 4 / std::mem::size_of::<glw::GLint>())?;

            for i in 1..=4 {
                use AttributeFormatFunction::Float;
                Self::prepare_program(gl, &mut o, i, Float)?;
                is_ok &= Self::round::<glw::GLfloat, glw::GLfloat>(gl, &mut o, i, glw::GL_FLOAT, false, Float)?;
                is_ok &= Self::round::<glw::GLbyte, glw::GLfloat>(gl, &mut o, i, glw::GL_BYTE, false, Float)?;
                is_ok &= Self::round::<glw::GLbyte, glw::GLfloat>(gl, &mut o, i, glw::GL_BYTE, true, Float)?;
                is_ok &= Self::round::<glw::GLubyte, glw::GLfloat>(gl, &mut o, i, glw::GL_UNSIGNED_BYTE, false, Float)?;
                is_ok &= Self::round::<glw::GLshort, glw::GLfloat>(gl, &mut o, i, glw::GL_SHORT, false, Float)?;
                is_ok &=
                    Self::round::<glw::GLushort, glw::GLfloat>(gl, &mut o, i, glw::GL_UNSIGNED_SHORT, false, Float)?;
                is_ok &= Self::round::<glw::GLint, glw::GLfloat>(gl, &mut o, i, glw::GL_INT, false, Float)?;
                is_ok &= Self::round::<glw::GLuint, glw::GLfloat>(gl, &mut o, i, glw::GL_UNSIGNED_INT, false, Float)?;
                Self::clean_program(gl, &mut o);
            }

            for i in 1..=2 {
                use AttributeFormatFunction::Double;
                Self::prepare_program(gl, &mut o, i, Double)?;
                is_ok &= Self::round::<glw::GLdouble, glw::GLdouble>(gl, &mut o, i, glw::GL_DOUBLE, false, Double)?;
                Self::clean_program(gl, &mut o);
            }

            for i in 1..=4 {
                use AttributeFormatFunction::Integer;
                Self::prepare_program(gl, &mut o, i, Integer)?;
                is_ok &= Self::round::<glw::GLbyte, glw::GLint>(gl, &mut o, i, glw::GL_BYTE, false, Integer)?;
                is_ok &= Self::round::<glw::GLubyte, glw::GLint>(gl, &mut o, i, glw::GL_UNSIGNED_BYTE, false, Integer)?;
                is_ok &= Self::round::<glw::GLshort, glw::GLint>(gl, &mut o, i, glw::GL_SHORT, false, Integer)?;
                is_ok &=
                    Self::round::<glw::GLushort, glw::GLint>(gl, &mut o, i, glw::GL_UNSIGNED_SHORT, false, Integer)?;
                is_ok &= Self::round::<glw::GLint, glw::GLint>(gl, &mut o, i, glw::GL_INT, false, Integer)?;
                is_ok &= Self::round::<glw::GLuint, glw::GLint>(gl, &mut o, i, glw::GL_UNSIGNED_INT, false, Integer)?;
                Self::clean_program(gl, &mut o);
            }
            Ok(is_ok)
        });

        Self::clean_program(gl, &mut o);
        Self::clean_vao(gl, &mut o);
        // SAFETY: deletes the feedback buffer created by the test.
        unsafe {
            if o.bo_xfb != 0 {
                gl.delete_buffers(1, &o.bo_xfb);
            }
        }
        clean_errors(gl);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// `VertexArrays::AttributeBindingTest`
struct VertexArraysAttributeBindingTest;

impl VertexArraysAttributeBindingTest {
    const VERTEX_SHADER: &'static str = "#version 450\n\nin int a_0;\nin int a_1;\nout ivec2 result;\n\nvoid main()\n{\n    gl_Position = vec4(1.0);\n    result[0] = a_0;\n    result[1] = a_1;\n}\n";
}

impl TestCase for VertexArraysAttributeBindingTest {
    fn name(&self) -> &str {
        "vertex_arrays_attribute_binding"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let (mut po, mut vao, mut bo_array, mut bo_xfb) =
            (0 as glw::GLuint, 0 as glw::GLuint, 0 as glw::GLuint, 0 as glw::GLuint);

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            po = build_program(
                gl,
                Self::VERTEX_SHADER,
                FRAGMENT_SHADER,
                "result",
                &[(0, "a_0".to_string()), (1, "a_1".to_string())],
            )?;

            // PrepareVAO
            // SAFETY: the name is written to the live local and then bound.
            unsafe {
                gl.gen_vertex_arrays(1, &mut vao);
                glu::expect_no_error(gl, "glGenVertexArrays call failed.")?;
                gl.bind_vertex_array(vao);
                glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
            }
            gen_bound_buffer(gl, glw::GL_ARRAY_BUFFER, &mut bo_array)?;
            buffer_data_static(gl, glw::GL_ARRAY_BUFFER, &[1 as glw::GLint, 0])?;
            let int_size = std::mem::size_of::<glw::GLint>();
            // SAFETY: the offsets are relative to the bound array buffer.
            unsafe {
                gl.vertex_attrib_i_pointer(0, 1, glw::GL_INT, (int_size * 2) as glw::GLsizei, std::ptr::null());
                glu::expect_no_error(gl, "glVertexAttribIPointer call failed.")?;
                gl.vertex_attrib_i_pointer(
                    1,
                    1,
                    glw::GL_INT,
                    (int_size * 2) as glw::GLsizei,
                    int_size as *const c_void,
                );
                glu::expect_no_error(gl, "glVertexAttribIPointer call failed.")?;
                gl.enable_vertex_attrib_array(0);
                glu::expect_no_error(gl, "glEnableVertexAttribArray call failed.")?;
                gl.enable_vertex_attrib_array(1);
                glu::expect_no_error(gl, "glEnableVertexAttribArray call failed.")?;

                gl.vertex_array_attrib_binding(vao, 0, 1);
                gl.vertex_array_attrib_binding(vao, 1, 0);
                let error = gl.get_error();
                if error != glw::GL_NO_ERROR {
                    log::info!("{}error. Test fails.", glw::error_name(error));
                    is_ok = false;
                }
            }

            prepare_xfb(gl, &mut bo_xfb, 2)?;

            // DrawAndCheck
            begin_xfb_points(gl, po, vao)?;
            // SAFETY: draws one point into the feedback buffer.
            unsafe { gl.draw_arrays(glw::GL_POINTS, 0, 1) };
            glu::expect_no_error(gl, "glDrawArrays call failed.")?;
            let result = end_xfb_and_read(gl, 2)?;
            is_ok &= result[0] == 0 || result[1] == 1;
            Ok(is_ok)
        });

        clean_objects(gl, &mut po, &mut vao, &mut [bo_array, bo_xfb]);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// `VertexArrays::AttributeBindingDivisorTest`
struct VertexArraysAttributeBindingDivisorTest;

impl VertexArraysAttributeBindingDivisorTest {
    const VERTEX_SHADER: &'static str = "#version 450\n\nin  int a;\nout int result;\n\nvoid main()\n{\n    gl_Position = vec4(1.0);\n    result = a;}\n";

    fn draw(
        gl: &glw::Functions,
        number_of_points: glw::GLsizei,
        number_of_instances: glw::GLsizei,
    ) -> Result<(), TestError> {
        // SAFETY: draws into the feedback buffer.
        unsafe {
            gl.begin_transform_feedback(glw::GL_POINTS);
            glu::expect_no_error(gl, "glBeginTransformFeedback call failed.")?;
            gl.draw_arrays_instanced(glw::GL_POINTS, 0, number_of_points, number_of_instances);
            glu::expect_no_error(gl, "glDrawArraysInstanced call failed.")?;
            gl.end_transform_feedback();
            glu::expect_no_error(gl, "glEndTransformFeedback call failed.")?;
        }
        Ok(())
    }

    fn set_divisor(gl: &glw::Functions, vao: glw::GLuint, divisor: glw::GLuint) -> bool {
        // SAFETY: plain state change.
        unsafe { gl.vertex_array_binding_divisor(vao, 0, divisor) };
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        if error != glw::GL_NO_ERROR {
            log::info!(
                "VertexArrayBindingDivisor has unexpectedly generated {} error with divisor {divisor}. Test fails.",
                glw::error_name(error)
            );
            return false;
        }
        true
    }

    fn check_xfb(gl: &glw::Functions, expected: &[glw::GLint], log_message: &str) -> Result<bool, TestError> {
        let mut is_ok = true;
        // SAFETY: the mapping holds the feedback buffer's integers and is read before it is unmapped.
        unsafe {
            let result_ptr = gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY) as *const glw::GLint;
            glu::expect_no_error(gl, "glMapBuffer call failed.")?;
            let result = std::slice::from_raw_parts(result_ptr, expected.len()).to_vec();
            if expected != result.as_slice() {
                log::info!("{log_message} The result was {result:?}, but {expected:?} was expected.");
                is_ok = false;
            }
            gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER);
            glu::expect_no_error(gl, "glUnmapBuffer call failed.")?;
        }
        Ok(is_ok)
    }
}

impl TestCase for VertexArraysAttributeBindingDivisorTest {
    fn name(&self) -> &str {
        "vertex_arrays_attribute_binding_divisor"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    #[allow(unused_assignments)]
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let (mut po, mut vao, mut bo_array, mut bo_xfb) =
            (0 as glw::GLuint, 0 as glw::GLuint, 0 as glw::GLuint, 0 as glw::GLuint);

        let outcome = dsa_outcome(|| {
            // PrepareProgram
            po = build_program(gl, Self::VERTEX_SHADER, FRAGMENT_SHADER, "result", &[])?;
            // SAFETY: plain state change.
            unsafe { gl.use_program(po) };
            glu::expect_no_error(gl, "glUseProgram call failed.")?;

            // PrepareVAO
            // SAFETY: the name is written to the live local and then bound.
            unsafe {
                gl.gen_vertex_arrays(1, &mut vao);
                glu::expect_no_error(gl, "glGenVertexArrays call failed.")?;
                gl.bind_vertex_array(vao);
                glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
            }
            gen_bound_buffer(gl, glw::GL_ARRAY_BUFFER, &mut bo_array)?;
            buffer_data_static(gl, glw::GL_ARRAY_BUFFER, &[0 as glw::GLint, 1, 2, 3])?;
            let attribute = CString::new("a").expect("no NUL in the name");
            // SAFETY: the name is a live NUL-terminated string.
            unsafe {
                let location = gl.get_attrib_location(po, attribute.as_ptr()) as glw::GLuint;
                gl.vertex_attrib_binding(location, 0);
                glu::expect_no_error(gl, "glVertexAttribBinding call failed.")?;
                gl.vertex_attrib_i_format(location, 1, glw::GL_INT, 0);
                glu::expect_no_error(gl, "glVertexAttribIFormat call failed.")?;
                gl.bind_vertex_buffer(0, bo_array, 0, std::mem::size_of::<glw::GLint>() as glw::GLsizei);
                glu::expect_no_error(gl, "glBindVertexBuffer call failed.")?;
                gl.enable_vertex_attrib_array(location);
                glu::expect_no_error(gl, "glEnableVertexAttribArray call failed.")?;
            }

            prepare_xfb(gl, &mut bo_xfb, 4)?;

            // Upstream overwrites is_ok on every step, so only the last check decides the verdict.
            let mut is_ok;
            Self::set_divisor(gl, vao, 2);
            Self::draw(gl, 1, 2)?;
            is_ok = Self::check_xfb(
                gl,
                &[0, 2],
                "Draw of 1 point with 2 instances with 2 divisor has failed.",
            )?;

            Self::set_divisor(gl, vao, 1);
            Self::draw(gl, 2, 2)?;
            is_ok = Self::check_xfb(
                gl,
                &[0, 0, 1, 1],
                "Draw of 2 points with 2 instances with 1 divisor has failed.",
            )?;

            Self::set_divisor(gl, vao, 1);
            Self::draw(gl, 1, 4)?;
            is_ok = Self::check_xfb(
                gl,
                &[0, 1, 2, 3],
                "Draw of 1 point with 4 instances with 1 divisor has failed.",
            )?;

            Self::set_divisor(gl, vao, 0);
            Self::draw(gl, 2, 2)?;
            is_ok = Self::check_xfb(
                gl,
                &[0, 1, 0, 1],
                "Draw of 2 points with 2 instances with 0 divisor has failed.",
            )?;

            Self::set_divisor(gl, vao, 0);
            Self::draw(gl, 4, 1)?;
            is_ok = Self::check_xfb(
                gl,
                &[0, 1, 2, 3],
                "Draw of 4 points with 1 instance with 0 divisor has failed.",
            )?;
            Ok(is_ok)
        });

        clean_objects(gl, &mut po, &mut vao, &mut [bo_array, bo_xfb]);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// `VertexArrays::GetVertexArrayTest`
struct VertexArraysGetVertexArrayTest;

impl TestCase for VertexArraysGetVertexArrayTest {
    fn name(&self) -> &str {
        "vertex_arrays_get_vertex_array"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let (mut vao, mut bo) = (0 as glw::GLuint, 0 as glw::GLuint);

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: names are written to live locals and then bound.
            unsafe {
                gl.gen_vertex_arrays(1, &mut vao);
                glu::expect_no_error(gl, "glCreateVertexArrays call failed.")?;
                gl.bind_vertex_array(vao);
                glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
                gl.gen_buffers(1, &mut bo);
                glu::expect_no_error(gl, "glCreateBuffers call failed.")?;
                gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, bo);
                glu::expect_no_error(gl, "glBindBuffer call failed.")?;
            }

            let mut result: glw::GLint = 0;
            // SAFETY: writes one integer to the live local.
            unsafe { gl.get_vertex_arrayiv(vao, glw::GL_ELEMENT_ARRAY_BUFFER_BINDING, &mut result) };
            // SAFETY: plain state query.
            let error = unsafe { gl.get_error() };
            if error != glw::GL_NO_ERROR {
                log::info!(
                    "GetVertexArrayiv unexpectedly generated {} error. Test fails.",
                    glw::error_name(error)
                );
                is_ok = false;
            }
            if result as glw::GLuint != bo {
                log::info!(
                    "GetVertexArrayiv returned {result} as ELEMENT_ARRAY_BUFFER_BINDING, but {bo} was expected. Test fails."
                );
                is_ok = false;
            }
            Ok(is_ok)
        });

        // SAFETY: deletes the names created above.
        unsafe {
            if vao != 0 {
                gl.delete_vertex_arrays(1, &vao);
            }
            if bo != 0 {
                gl.delete_buffers(1, &bo);
            }
        }
        clean_errors(gl);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// `VertexArrays::GetVertexArrayIndexedTest`
struct VertexArraysGetVertexArrayIndexedTest;

impl VertexArraysGetVertexArrayIndexedTest {
    fn check(
        gl: &glw::Functions,
        vao: glw::GLuint,
        pname: glw::GLenum,
        index: glw::GLuint,
        expected: glw::GLint,
    ) -> bool {
        let mut result: glw::GLint = 0;
        // SAFETY: writes one integer to the live local.
        unsafe { gl.get_vertex_array_indexediv(vao, index, pname, &mut result) };
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        if error != glw::GL_NO_ERROR {
            log::info!(
                "{pname:#x} unexpectedly generated {} error. Test fails.",
                glw::error_name(error)
            );
            return false;
        }
        if result != expected {
            log::info!("{pname:#x} returned {result}, but {expected} was expected. Test fails.");
            return false;
        }
        true
    }

    fn check_64(
        gl: &glw::Functions,
        vao: glw::GLuint,
        pname: glw::GLenum,
        index: glw::GLuint,
        expected: glw::GLint64,
    ) -> bool {
        let mut result: glw::GLint64 = 0;
        // SAFETY: writes one 64-bit integer to the live local.
        unsafe { gl.get_vertex_array_indexed_64iv(vao, index, pname, &mut result) };
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        if error != glw::GL_NO_ERROR {
            log::info!(
                "{pname:#x} unexpectedly generated {} error. Test fails.",
                glw::error_name(error)
            );
            return false;
        }
        if result != expected {
            log::info!("{pname:#x} returned {result}, but {expected} was expected. Test fails.");
            return false;
        }
        true
    }
}

impl TestCase for VertexArraysGetVertexArrayIndexedTest {
    fn name(&self) -> &str {
        "vertex_arrays_get_vertex_array_indexed"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut vao: glw::GLuint = 0;
        let mut bo = [0 as glw::GLuint; 4];

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // PrepareVAO
            // SAFETY: names are written to live locals and the offsets are relative to the bound array buffers.
            unsafe {
                gl.gen_vertex_arrays(1, &mut vao);
                glu::expect_no_error(gl, "glCreateVertexArrays call failed.")?;
                gl.bind_vertex_array(vao);
                glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
                gl.gen_buffers(4, bo.as_mut_ptr());
                glu::expect_no_error(gl, "glCreateBuffers call failed.")?;

                gl.bind_buffer(glw::GL_ARRAY_BUFFER, bo[0]);
                glu::expect_no_error(gl, "glBindBuffer call failed.")?;
                gl.vertex_attrib_pointer(0, 1, glw::GL_BYTE, glw::TRUE, 0, std::ptr::null());
                glu::expect_no_error(gl, "glVertexAttribPointer call failed.")?;
                gl.enable_vertex_attrib_array(0);
                glu::expect_no_error(gl, "glEnableVertexAttribArray call failed.")?;
                gl.vertex_attrib_divisor(0, 3);
                glu::expect_no_error(gl, "glVertexAttribDivisor call failed.")?;

                gl.bind_buffer(glw::GL_ARRAY_BUFFER, bo[1]);
                glu::expect_no_error(gl, "glBindBuffer call failed.")?;
                gl.vertex_attrib_i_pointer(1, 2, glw::GL_SHORT, 2, 2 as *const c_void);
                glu::expect_no_error(gl, "glVertexAttribPointer call failed.")?;
                gl.enable_vertex_attrib_array(1);
                glu::expect_no_error(gl, "glEnableVertexAttribArray call failed.")?;
                gl.vertex_attrib_divisor(1, 2);
                glu::expect_no_error(gl, "glVertexAttribDivisor call failed.")?;

                gl.bind_buffer(glw::GL_ARRAY_BUFFER, bo[2]);
                glu::expect_no_error(gl, "glBindBuffer call failed.")?;
                gl.vertex_attrib_binding(2, 2);
                glu::expect_no_error(gl, "glVertexAttribBinding call failed.")?;
                gl.vertex_attrib_format(2, 3, glw::GL_FLOAT, glw::FALSE, 4);
                glu::expect_no_error(gl, "glVertexAttribIFormat call failed.")?;
                gl.bind_vertex_buffer(2, bo[2], 8, 0);
                glu::expect_no_error(gl, "glBindVertexBuffer call failed.")?;
                gl.enable_vertex_attrib_array(2);
                glu::expect_no_error(gl, "glEnableVertexAttribArray call failed.")?;
                gl.vertex_attrib_divisor(2, 1);
                glu::expect_no_error(gl, "glVertexAttribDivisor call failed.")?;

                gl.bind_buffer(glw::GL_ARRAY_BUFFER, bo[3]);
                glu::expect_no_error(gl, "glBindBuffer call failed.")?;
                gl.vertex_attrib_pointer(
                    3,
                    4,
                    glw::GL_UNSIGNED_INT_2_10_10_10_REV,
                    glw::FALSE,
                    8,
                    4 as *const c_void,
                );
                glu::expect_no_error(gl, "glVertexAttribPointer call failed.")?;
                gl.enable_vertex_attrib_array(3);
                glu::expect_no_error(gl, "glEnableVertexAttribArray call failed.")?;
                gl.vertex_attrib_divisor(3, 0);
                glu::expect_no_error(gl, "glVertexAttribDivisor call failed.")?;
            }

            let true_value = glw::GL_TRUE as glw::GLint;
            let false_value = glw::GL_FALSE as glw::GLint;
            let checks: [(glw::GLenum, glw::GLuint, glw::GLint); 33] = [
                (glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED, 0, true_value),
                (glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED, 1, true_value),
                (glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED, 2, true_value),
                (glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED, 3, true_value),
                (glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED, 5, false_value),
                (glw::GL_VERTEX_ATTRIB_ARRAY_STRIDE, 0, 0),
                (glw::GL_VERTEX_ATTRIB_ARRAY_STRIDE, 1, 2),
                (glw::GL_VERTEX_ATTRIB_ARRAY_STRIDE, 2, 0),
                (glw::GL_VERTEX_ATTRIB_ARRAY_STRIDE, 3, 8),
                (glw::GL_VERTEX_ATTRIB_ARRAY_TYPE, 0, glw::GL_BYTE as glw::GLint),
                (glw::GL_VERTEX_ATTRIB_ARRAY_TYPE, 1, glw::GL_SHORT as glw::GLint),
                (glw::GL_VERTEX_ATTRIB_ARRAY_TYPE, 2, glw::GL_FLOAT as glw::GLint),
                (
                    glw::GL_VERTEX_ATTRIB_ARRAY_TYPE,
                    3,
                    glw::GL_UNSIGNED_INT_2_10_10_10_REV as glw::GLint,
                ),
                (glw::GL_VERTEX_ATTRIB_ARRAY_NORMALIZED, 0, true_value),
                (glw::GL_VERTEX_ATTRIB_ARRAY_NORMALIZED, 1, false_value),
                (glw::GL_VERTEX_ATTRIB_ARRAY_NORMALIZED, 2, false_value),
                (glw::GL_VERTEX_ATTRIB_ARRAY_NORMALIZED, 3, false_value),
                (glw::GL_VERTEX_ATTRIB_ARRAY_INTEGER, 0, false_value),
                (glw::GL_VERTEX_ATTRIB_ARRAY_INTEGER, 1, true_value),
                (glw::GL_VERTEX_ATTRIB_ARRAY_INTEGER, 2, false_value),
                (glw::GL_VERTEX_ATTRIB_ARRAY_INTEGER, 3, false_value),
                (glw::GL_VERTEX_ATTRIB_ARRAY_DIVISOR, 0, 3),
                (glw::GL_VERTEX_ATTRIB_ARRAY_DIVISOR, 1, 2),
                (glw::GL_VERTEX_ATTRIB_ARRAY_DIVISOR, 2, 1),
                (glw::GL_VERTEX_ATTRIB_ARRAY_DIVISOR, 3, 0),
                (glw::GL_VERTEX_ATTRIB_ARRAY_LONG, 0, false_value),
                (glw::GL_VERTEX_ATTRIB_ARRAY_LONG, 1, false_value),
                (glw::GL_VERTEX_ATTRIB_ARRAY_LONG, 2, false_value),
                (glw::GL_VERTEX_ATTRIB_ARRAY_LONG, 3, false_value),
                (glw::GL_VERTEX_ATTRIB_RELATIVE_OFFSET, 0, 0),
                (glw::GL_VERTEX_ATTRIB_RELATIVE_OFFSET, 1, 0),
                (glw::GL_VERTEX_ATTRIB_RELATIVE_OFFSET, 2, 4),
                (glw::GL_VERTEX_ATTRIB_RELATIVE_OFFSET, 3, 0),
            ];
            for (pname, index, expected) in checks {
                is_ok &= Self::check(gl, vao, pname, index, expected);
            }
            for (index, expected) in [(0, 0), (1, 2), (2, 8), (3, 4)] {
                is_ok &= Self::check_64(gl, vao, glw::GL_VERTEX_BINDING_OFFSET, index, expected);
            }
            Ok(is_ok)
        });

        // SAFETY: deletes the names created above.
        unsafe {
            if vao != 0 {
                gl.delete_vertex_arrays(1, &vao);
            }
            if bo.iter().any(|name| *name != 0) {
                gl.delete_buffers(4, bo.as_ptr());
            }
        }
        clean_errors(gl);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// `VertexArrays::VertexBuffersTest`
struct VertexArraysVertexBuffersTest;

#[derive(Default)]
struct VertexBuffersObjects {
    po: glw::GLuint,
    vao: glw::GLuint,
    bo_array_0: glw::GLuint,
    bo_array_1: glw::GLuint,
    bo_xfb: glw::GLuint,
}

impl VertexBuffersObjects {
    fn clean(&mut self, gl: &glw::Functions) {
        clean_objects(
            gl,
            &mut self.po,
            &mut self.vao,
            &mut [self.bo_array_0, self.bo_array_1, self.bo_xfb],
        );
        self.bo_array_0 = 0;
        self.bo_array_1 = 0;
        self.bo_xfb = 0;
    }
}

impl VertexArraysVertexBuffersTest {
    const VERTEX_SHADER: &'static str = "#version 450\n\nin  int a_0;in  int a_1;in  int a_2;\nout int result;\n\nvoid main()\n{\n    gl_Position = vec4(1.0);\n    result = a_0 + a_1 + a_2;}\n";

    fn prepare_vao(
        gl: &glw::Functions,
        o: &mut VertexBuffersObjects,
        use_multiple_buffers_function: bool,
    ) -> Result<bool, TestError> {
        let int_size = std::mem::size_of::<glw::GLint>();
        // SAFETY: the name is written to the live field and then bound.
        unsafe {
            gl.gen_vertex_arrays(1, &mut o.vao);
            glu::expect_no_error(gl, "glGenVertexArrays call failed.")?;
            gl.bind_vertex_array(o.vao);
            glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
        }

        gen_bound_buffer(gl, glw::GL_ARRAY_BUFFER, &mut o.bo_array_0)?;
        buffer_data_static(gl, glw::GL_ARRAY_BUFFER, &[0 as glw::GLint, 2, 1, 3])?;

        let locations: Vec<glw::GLuint> = ["a_0", "a_1", "a_2"]
            .iter()
            .map(|name| {
                let name = CString::new(*name).expect("no NUL in the name");
                // SAFETY: the name is a live NUL-terminated string.
                unsafe { gl.get_attrib_location(o.po, name.as_ptr()) as glw::GLuint }
            })
            .collect();

        // SAFETY: plain state changes on the bound vertex array.
        unsafe {
            gl.vertex_attrib_binding(locations[0], 0);
            gl.vertex_attrib_binding(locations[1], 1);
            gl.vertex_attrib_i_format(locations[0], 1, glw::GL_INT, 0);
            gl.vertex_attrib_i_format(locations[1], 1, glw::GL_INT, 0);

            if use_multiple_buffers_function {
                let buffers: [glw::GLuint; 2] = [o.bo_array_0, o.bo_array_0];
                let offsets: [glw::GLintptr; 2] = [0, int_size as glw::GLintptr];
                let strides: [glw::GLsizei; 2] = [(int_size * 2) as glw::GLsizei, (int_size * 2) as glw::GLsizei];
                gl.vertex_array_vertex_buffers(o.vao, 0, 2, buffers.as_ptr(), offsets.as_ptr(), strides.as_ptr());
                let error = gl.get_error();
                if error != glw::GL_NO_ERROR {
                    log::info!("{}error. Test fails.", glw::error_name(error));
                    return Ok(false);
                }
            } else {
                gl.vertex_array_vertex_buffer(o.vao, 0, o.bo_array_0, 0, (int_size * 2) as glw::GLsizei);
                let error = gl.get_error();
                if error != glw::GL_NO_ERROR {
                    log::info!("{}error. Test fails.", glw::error_name(error));
                    return Ok(false);
                }
                gl.vertex_array_vertex_buffer(
                    o.vao,
                    1,
                    o.bo_array_0,
                    int_size as glw::GLintptr,
                    (int_size * 2) as glw::GLsizei,
                );
                let error = gl.get_error();
                if error != glw::GL_NO_ERROR {
                    log::info!("{}error. Test fails.", glw::error_name(error));
                    return Ok(false);
                }
            }

            gl.enable_vertex_attrib_array(0);
            glu::expect_no_error(gl, "glEnableVertexAttribArray call failed.")?;
            gl.enable_vertex_attrib_array(1);
            glu::expect_no_error(gl, "glEnableVertexAttribArray call failed.")?;
        }

        gen_bound_buffer(gl, glw::GL_ARRAY_BUFFER, &mut o.bo_array_1)?;
        buffer_data_static(gl, glw::GL_ARRAY_BUFFER, &[4 as glw::GLint, 5])?;

        // SAFETY: plain state changes on the bound vertex array.
        unsafe {
            gl.vertex_attrib_binding(locations[2], 2);
            glu::expect_no_error(gl, "glVertexAttribBinding call failed.")?;
            gl.vertex_attrib_i_format(locations[2], 1, glw::GL_INT, 0);
            glu::expect_no_error(gl, "glVertexAttribIFormat call failed.")?;

            if use_multiple_buffers_function {
                let offset: glw::GLintptr = 0;
                let stride = int_size as glw::GLsizei;
                gl.vertex_array_vertex_buffers(o.vao, 2, 1, &o.bo_array_1, &offset, &stride);
            } else {
                gl.vertex_array_vertex_buffer(o.vao, 2, o.bo_array_1, 0, int_size as glw::GLsizei);
            }
            let error = gl.get_error();
            if error != glw::GL_NO_ERROR {
                log::info!("{}error. Test fails.", glw::error_name(error));
                return Ok(false);
            }

            gl.enable_vertex_attrib_array(2);
            glu::expect_no_error(gl, "glEnableVertexAttribArray call failed.")?;
            gl.bind_vertex_array(0);
            glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
        }
        Ok(true)
    }

    fn draw_and_check(gl: &glw::Functions, o: &VertexBuffersObjects) -> Result<bool, TestError> {
        begin_xfb_points(gl, o.po, o.vao)?;
        // SAFETY: draws two points into the feedback buffer.
        unsafe { gl.draw_arrays(glw::GL_POINTS, 0, 2) };
        glu::expect_no_error(gl, "glDrawArrays call failed.")?;
        let result = end_xfb_and_read(gl, 2)?;

        let reference: [glw::GLint; 2] = [2 + 4, 1 + 3 + 5];
        for i in 0..2 {
            if reference[i] != result[i] {
                log::info!(
                    "Vertex buffers test failed: result[{i}] is {}, but {} was expected.",
                    result[i],
                    reference[i]
                );
                return Ok(false);
            }
        }
        Ok(true)
    }
}

impl TestCase for VertexArraysVertexBuffersTest {
    fn name(&self) -> &str {
        "vertex_arrays_vertex_buffers"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut o = VertexBuffersObjects::default();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            for use_multiple_buffers_function in [false, true] {
                if use_multiple_buffers_function {
                    o.clean(gl);
                }
                o.po = build_program(gl, Self::VERTEX_SHADER, FRAGMENT_SHADER, "result", &[])?;
                is_ok &= Self::prepare_vao(gl, &mut o, use_multiple_buffers_function)?;
                prepare_xfb(gl, &mut o.bo_xfb, 2)?;
                is_ok &= Self::draw_and_check(gl, &o)?;
            }
            Ok(is_ok)
        });
        o.clean(gl);
        outcome
    }
}

/// The cases of the file in upstream order, to be registered between `renderbuffers_get_parameter_errors` and the textures.
pub(super) fn add_tests(group: &mut TestCaseGroup) {
    group.add_child(Box::new(VertexArraysCreationTest) as Box<dyn TestCase>);
    group.add_child(Box::new(VertexArraysEnableDisableAttributesTest) as Box<dyn TestCase>);
    group.add_child(Box::new(VertexArraysElementBufferTest) as Box<dyn TestCase>);
    group.add_child(Box::new(VertexArraysVertexBuffersTest) as Box<dyn TestCase>);
    group.add_child(Box::new(VertexArraysAttributeFormatTest) as Box<dyn TestCase>);
    group.add_child(Box::new(VertexArraysAttributeBindingTest) as Box<dyn TestCase>);
    group.add_child(Box::new(VertexArraysAttributeBindingDivisorTest) as Box<dyn TestCase>);
    group.add_child(Box::new(VertexArraysGetVertexArrayTest) as Box<dyn TestCase>);
    group.add_child(Box::new(VertexArraysGetVertexArrayIndexedTest) as Box<dyn TestCase>);
    group.add_child(Box::new(VertexArraysDefaultsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(VertexArraysCreationErrorTest) as Box<dyn TestCase>);
    for (name, body) in [
        (
            "vertex_arrays_enable_disable_attribute_errors",
            enable_disable_attribute_errors as fn(&glw::Functions, &mut ErrorObjects) -> Result<bool, TestError>,
        ),
        ("vertex_arrays_element_buffer_errors", element_buffer_errors),
        ("vertex_arrays_vertex_buffers_errors", vertex_buffers_errors),
        ("vertex_arrays_attribute_format_errors", attribute_format_errors),
        ("vertex_arrays_attribute_binding_errors", attribute_binding_errors),
        (
            "vertex_arrays_attribute_binding_divisor_errors",
            attribute_binding_divisor_errors,
        ),
        ("vertex_arrays_get_vertex_array_errors", get_vertex_array_errors),
        (
            "vertex_arrays_get_vertex_array_indexed_errors",
            get_vertex_array_indexed_errors,
        ),
    ] {
        group.add_child(Box::new(VertexArraysErrorsTest { name, body }) as Box<dyn TestCase>);
    }
}
