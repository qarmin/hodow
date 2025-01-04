// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fShaderStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts, transcribed from the GLES2 sibling
// plus the ES 3.0 differences: `#version 300 es` sources with a `layout(location = 0)
// out` fragment output, the integer/unsigned current-vertex-attrib setters, the
// integer vertex-array pointer states, the instancing divisor, unsigned uniforms, and
// a per-VAO pass on every vertex-array state.
//
// Two things in here are easy to get wrong when reading the C++, both noted in the
// GLES2 sibling and reproduced deliberately:
//
//   - `char buffer[2048] = {'x'}` sets buffer[0] to 'x' and the other 2047 bytes to
//     zero, which is what makes the "did the driver write a terminator" checks work.
//   - `INFO_LOG_LENGTH` and `SHADER_SOURCE_LENGTH` *include* the null terminator while
//     the `length` written by the matching getter does *not*.
//
// Every upstream case in `es3fShaderStateQueryTests.cpp` is ported here.

use std::ffi::{CString, c_void};

use crate::gls::state_query_util::Guarded;
use crate::glu::shader_program::{ProgramSources, ShaderProgram};
use crate::glu::{ApiCase, ApiCaseFn, TestCaseGroup, add_api_case, add_api_cases};
use crate::glw::{self, GLenum, GLfloat, GLint, GLsizei, GLuint};
use crate::tcu::Random;

const COMMON_TEST_VERT_SOURCE: &str = "#version 300 es\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n}\n";
const COMMON_TEST_FRAG_SOURCE: &str = "#version 300 es\nlayout(location = 0) out mediump vec4 fragColor;\nvoid main (void)\n{\n    fragColor = vec4(0.0);\n}\n";
const BROKEN_SHADER: &str = "#version 300 es\nbroken, this should not compile!\n\n";

/// `linkErrorVtxSource` / `linkErrorFrgSource` - each compiles, but the fragment shader
/// reads a varying the vertex shader does not write and redeclares a uniform with a
/// different type, so the link fails.
const LINK_ERROR_VERT_SOURCE: &str = "#version 300 es\nin highp vec4 a_pos;\nuniform highp vec4 u_uniform;\nvoid main ()\n{\n    gl_Position = a_pos + u_uniform;\n}\n";
const LINK_ERROR_FRAG_SOURCE: &str = "#version 300 es\nin highp vec4 v_missingVar;\nuniform highp int u_uniform;\nlayout(location = 0) out mediump vec4 fragColor;\nvoid main ()\n{\n    fragColor = v_missingVar + vec4(float(u_uniform));\n}\n";

/// `char buffer[2048] = {'x'}` - see the note at the top of this file.
fn new_char_buffer() -> Vec<u8> {
    let mut buffer = vec![0u8; 2048];
    buffer[0] = b'x';
    buffer
}

/// `glShaderSource` with owned sources, since GL only borrows the pointers.
fn shader_source(case: &ApiCase<'_>, shader: GLuint, sources: &[&str]) {
    let owned: Vec<CString> = sources
        .iter()
        .map(|source| CString::new(*source).expect("no interior nul"))
        .collect();
    let pointers: Vec<*const glw::GLchar> = owned.iter().map(|source| source.as_ptr()).collect();
    // SAFETY: `count` matches the array, every pointer is a live null-terminated string
    // for the duration of the call, and a null `length` means "all null-terminated".
    unsafe {
        case.gl()
            .shader_source(shader, pointers.len() as GLsizei, pointers.as_ptr(), std::ptr::null())
    };
}

fn uniform_location(case: &ApiCase<'_>, program: GLuint, name: &str) -> GLint {
    let name = CString::new(name).expect("no interior nul");
    // SAFETY: a live null-terminated name; a missing uniform answers -1.
    unsafe { case.gl().get_uniform_location(program, name.as_ptr()) }
}

/// `roundGLfloatToNearestIntegerUp` - rounds x.1 to x+1.
fn round_up(value: GLfloat) -> GLint {
    #[expect(clippy::cast_possible_truncation, reason = "upstream's own (GLint)ceil(val)")]
    let rounded = value.ceil() as GLint;
    rounded
}

/// `roundGLfloatToNearestIntegerDown` - rounds x.9 to x.
fn round_down(value: GLfloat) -> GLint {
    #[expect(clippy::cast_possible_truncation, reason = "upstream's own (GLint)floor(val)")]
    let rounded = value.floor() as GLint;
    rounded
}

/// `checkIntEquals`
fn check_int_equals(case: &mut ApiCase<'_>, got: GLint, expected: GLint) -> bool {
    if got != expected {
        case.fail(format!("Expected {expected}; got {got}"), "got invalid value");
        return false;
    }
    true
}

/// `checkPointerEquals`
fn check_pointer_equals(case: &mut ApiCase<'_>, got: *mut c_void, expected: *mut c_void) {
    if got != expected {
        case.fail(format!("Expected {expected:p}; got {got:p}"), "got invalid value");
    }
}

/// `verifyShaderParam`
fn verify_shader_param(case: &mut ApiCase<'_>, shader: GLuint, pname: GLenum, reference: GLint) {
    let mut state = Guarded::<GLint>::new();
    // SAFETY: one GLint out, guarded on both sides.
    unsafe { case.gl().get_shaderiv(shader, pname, state.as_mut_ptr()) };
    if state.verify_validity(case) {
        check_int_equals(case, state.value(), reference);
    }
}

/// `verifyProgramParam`
fn verify_program_param(case: &mut ApiCase<'_>, program: GLuint, pname: GLenum, reference: GLint) -> bool {
    let mut state = Guarded::<GLint>::new();
    // SAFETY: as above.
    unsafe { case.gl().get_programiv(program, pname, state.as_mut_ptr()) };
    if state.verify_validity(case) {
        return check_int_equals(case, state.value(), reference);
    }
    false
}

/// `verifyCurrentVertexAttribf`
fn verify_current_vertex_attribf(case: &mut ApiCase<'_>, index: GLuint, reference: [GLfloat; 4]) {
    let mut attrib_value = Guarded::<[GLfloat; 4]>::new();
    // SAFETY: `CURRENT_VERTEX_ATTRIB` writes exactly four floats.
    unsafe {
        case.gl().get_vertex_attribfv(
            index,
            glw::GL_CURRENT_VERTEX_ATTRIB,
            attrib_value.as_mut_ptr().cast::<GLfloat>(),
        )
    };

    attrib_value.verify_validity(case);

    if attrib_value.value() != reference {
        case.fail(
            format!("Expected {reference:?}; got {:?}", attrib_value.value()),
            "got invalid attribute value",
        );
    }
}

/// `verifyCurrentVertexAttribIi`
fn verify_current_vertex_attrib_ii(case: &mut ApiCase<'_>, index: GLuint, reference: [GLint; 4]) {
    let mut attrib_value = Guarded::<[GLint; 4]>::new();
    // SAFETY: four GLints out, guarded on both sides.
    unsafe {
        case.gl().get_vertex_attrib_iiv(
            index,
            glw::GL_CURRENT_VERTEX_ATTRIB,
            attrib_value.as_mut_ptr().cast::<GLint>(),
        )
    };

    attrib_value.verify_validity(case);

    if attrib_value.value() != reference {
        case.fail(
            format!("Expected {reference:?}; got {:?}", attrib_value.value()),
            "got invalid attribute value",
        );
    }
}

/// `verifyCurrentVertexAttribIui`
fn verify_current_vertex_attrib_iui(case: &mut ApiCase<'_>, index: GLuint, reference: [GLuint; 4]) {
    let mut attrib_value = Guarded::<[GLuint; 4]>::new();
    // SAFETY: four GLuints out, guarded on both sides.
    unsafe {
        case.gl().get_vertex_attrib_iuiv(
            index,
            glw::GL_CURRENT_VERTEX_ATTRIB,
            attrib_value.as_mut_ptr().cast::<GLuint>(),
        )
    };

    attrib_value.verify_validity(case);

    if attrib_value.value() != reference {
        case.fail(
            format!("Expected {reference:?}; got {:?}", attrib_value.value()),
            "got invalid attribute value",
        );
    }
}

/// `verifyCurrentVertexAttribConversion` - the same state read as integers, which the
/// driver may round either way.
fn verify_current_vertex_attrib_conversion(case: &mut ApiCase<'_>, index: GLuint, reference: [GLfloat; 4]) {
    let mut attrib_value = Guarded::<[GLint; 4]>::new();
    // SAFETY: as above, four integers.
    unsafe {
        case.gl().get_vertex_attribiv(
            index,
            glw::GL_CURRENT_VERTEX_ATTRIB,
            attrib_value.as_mut_ptr().cast::<GLint>(),
        )
    };

    attrib_value.verify_validity(case);

    let min = reference.map(round_down);
    let max = reference.map(round_up);
    let value = attrib_value.value();

    if (0..4).any(|ndx| value[ndx] < min[ndx] || value[ndx] > max[ndx]) {
        case.fail(
            format!("expected in range {min:?}..={max:?}; got {value:?}; Input={reference:?}"),
            "Got invalid attribute value",
        );
    }
}

/// `verifyVertexAttrib`
fn verify_vertex_attrib(case: &mut ApiCase<'_>, index: GLuint, pname: GLenum, reference: GLint) {
    let mut state = Guarded::<GLint>::new();
    // SAFETY: every pname used here writes one GLint.
    unsafe { case.gl().get_vertex_attribiv(index, pname, state.as_mut_ptr()) };
    if state.verify_validity(case) {
        check_int_equals(case, state.value(), reference);
    }
}

/// `verifyUniformValue{1,2,3,4}f`
fn verify_uniform_value_f<const N: usize>(
    case: &mut ApiCase<'_>,
    program: GLuint,
    location: GLint,
    reference: [GLfloat; N],
) {
    let mut state = Guarded::<[GLfloat; N]>::new();
    // SAFETY: `N` matches the uniform's component count at every call site.
    unsafe {
        case.gl()
            .get_uniformfv(program, location, state.as_mut_ptr().cast::<GLfloat>())
    };
    if !state.verify_validity(case) {
        return;
    }
    if state.value() != reference {
        case.fail(
            format!("expected {reference:?}; got {:?}", state.value()),
            "Got invalid uniform value",
        );
    }
}

/// `verifyUniformValue{1,2,3,4}i`
fn verify_uniform_value_i<const N: usize>(
    case: &mut ApiCase<'_>,
    program: GLuint,
    location: GLint,
    reference: [GLint; N],
) {
    let mut state = Guarded::<[GLint; N]>::new();
    // SAFETY: as above.
    unsafe {
        case.gl()
            .get_uniformiv(program, location, state.as_mut_ptr().cast::<GLint>())
    };
    if !state.verify_validity(case) {
        return;
    }
    if state.value() != reference {
        case.fail(
            format!("expected {reference:?}; got {:?}", state.value()),
            "Got invalid uniform value",
        );
    }
}

/// `verifyUniformValue{1,2,3,4}ui`
fn verify_uniform_value_ui<const N: usize>(
    case: &mut ApiCase<'_>,
    program: GLuint,
    location: GLint,
    reference: [GLuint; N],
) {
    let mut state = Guarded::<[GLuint; N]>::new();
    // SAFETY: as above.
    unsafe {
        case.gl()
            .get_uniformuiv(program, location, state.as_mut_ptr().cast::<GLuint>())
    };
    if !state.verify_validity(case) {
        return;
    }
    if state.value() != reference {
        case.fail(
            format!("expected {reference:?}; got {:?}", state.value()),
            "Got invalid uniform value",
        );
    }
}

/// `verifyUniformMatrixValues<N>`
///
/// `SIZE` is `N * N`, spelled out because an array length cannot be computed from a
/// const parameter on stable Rust; every call site passes the matching pair.
fn verify_uniform_matrix_values<const N: usize, const SIZE: usize>(
    case: &mut ApiCase<'_>,
    program: GLuint,
    location: GLint,
    values: &[GLfloat],
    transpose: bool,
) {
    debug_assert_eq!(N * N, SIZE);

    let mut state = Guarded::<[GLfloat; SIZE]>::new();
    // SAFETY: `SIZE` is the matrix's component count.
    unsafe {
        case.gl()
            .get_uniformfv(program, location, state.as_mut_ptr().cast::<GLfloat>())
    };
    if !state.verify_validity(case) {
        return;
    }
    let state = state.value();

    for y in 0..N {
        for x in 0..N {
            let ref_index = y * N + x;
            let state_index = if transpose { x * N + y } else { y * N + x };

            if values[ref_index] != state[state_index] {
                case.fail(
                    format!(
                        "at index [{y}][{x}] expected {}; got {}",
                        values[ref_index], state[state_index]
                    ),
                    "Got invalid uniform value",
                );
            }
        }
    }
}

/// `requireShaderCompiler` - upstream throws `tcu::NotSupportedError`, which leaves
/// `test()` at once; a returned `false` is how a caller does the same thing.
fn require_shader_compiler(case: &mut ApiCase<'_>) -> bool {
    let mut state = Guarded::<glw::GLboolean>::new();
    // SAFETY: one GLboolean out.
    unsafe { case.gl().get_booleanv(glw::GL_SHADER_COMPILER, state.as_mut_ptr()) };

    if !state.verify_validity(case) || state.value() != glw::TRUE {
        case.not_supported("Test requires SHADER_COMPILER = TRUE");
        return false;
    }
    true
}

/// Compiles a vertex and a fragment shader from the given sources and returns both
/// names. The caller deletes them, as upstream's cases do.
fn create_compiled_pair(case: &mut ApiCase<'_>, vertex: &str, fragment: &str) -> (GLuint, GLuint) {
    let gl = case.gl();
    // SAFETY: both names are returned to the caller, which deletes them.
    let (shader_vert, shader_frag) = unsafe {
        (
            gl.create_shader(glw::GL_VERTEX_SHADER),
            gl.create_shader(glw::GL_FRAGMENT_SHADER),
        )
    };

    shader_source(case, shader_vert, &[vertex]);
    shader_source(case, shader_frag, &[fragment]);

    // SAFETY: both shaders have source attached.
    unsafe {
        gl.compile_shader(shader_vert);
        gl.compile_shader(shader_frag);
    }
    case.expect_error(glw::GL_NO_ERROR);

    (shader_vert, shader_frag)
}

/// `ShaderTypeCase`
fn shader_type(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    for shader_type in [glw::GL_VERTEX_SHADER, glw::GL_FRAGMENT_SHADER] {
        // SAFETY: a legal shader type; the name is deleted below.
        let shader = unsafe { gl.create_shader(shader_type) };
        verify_shader_param(case, shader, glw::GL_SHADER_TYPE, shader_type as GLint);
        // SAFETY: the name is this case's own.
        unsafe { gl.delete_shader(shader) };
    }
}

/// `ShaderCompileStatusCase`
fn shader_compile_status(case: &mut ApiCase<'_>) {
    if !require_shader_compiler(case) {
        return;
    }

    let gl = case.gl();
    // SAFETY: both names are deleted below.
    let (shader_vert, shader_frag) = unsafe {
        (
            gl.create_shader(glw::GL_VERTEX_SHADER),
            gl.create_shader(glw::GL_FRAGMENT_SHADER),
        )
    };

    verify_shader_param(case, shader_vert, glw::GL_COMPILE_STATUS, glw::GL_FALSE as GLint);
    verify_shader_param(case, shader_frag, glw::GL_COMPILE_STATUS, glw::GL_FALSE as GLint);

    shader_source(case, shader_vert, &[COMMON_TEST_VERT_SOURCE]);
    shader_source(case, shader_frag, &[COMMON_TEST_FRAG_SOURCE]);

    // SAFETY: both shaders have source attached.
    unsafe {
        gl.compile_shader(shader_vert);
        gl.compile_shader(shader_frag);
    }
    case.expect_error(glw::GL_NO_ERROR);

    verify_shader_param(case, shader_vert, glw::GL_COMPILE_STATUS, glw::GL_TRUE as GLint);
    verify_shader_param(case, shader_frag, glw::GL_COMPILE_STATUS, glw::GL_TRUE as GLint);

    // SAFETY: as above.
    unsafe {
        gl.delete_shader(shader_vert);
        gl.delete_shader(shader_frag);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `ShaderInfoLogCase`
fn shader_info_log_length(case: &mut ApiCase<'_>) {
    if !require_shader_compiler(case) {
        return;
    }

    let gl = case.gl();
    // INFO_LOG_LENGTH is 0 by default and it includes the null terminator.
    // SAFETY: the name is deleted on every path below.
    let shader = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
    verify_shader_param(case, shader, glw::GL_INFO_LOG_LENGTH, 0);

    shader_source(case, shader, &[BROKEN_SHADER]);
    // SAFETY: the source will not compile, which is the point.
    unsafe { gl.compile_shader(shader) };
    case.expect_error(glw::GL_NO_ERROR);

    let mut log_length = Guarded::<GLint>::new();
    // SAFETY: one GLint out.
    unsafe { gl.get_shaderiv(shader, glw::GL_INFO_LOG_LENGTH, log_length.as_mut_ptr()) };
    if !log_length.verify_validity(case) || log_length.value() == 0 {
        // A driver is allowed to have nothing to say about a broken shader.
        // SAFETY: as above.
        unsafe { gl.delete_shader(shader) };
        return;
    }
    let log_length = log_length.value();

    // check normal case
    {
        let mut buffer = new_char_buffer();
        let buffer_len = buffer.len();
        let mut written: GLsizei = 0; // does not include the null terminator

        // SAFETY: the buffer is `buffer_len` bytes and `written` is one GLsizei.
        unsafe {
            gl.get_shader_info_log(
                shader,
                buffer_len as GLsizei,
                &raw mut written,
                buffer.as_mut_ptr().cast::<glw::GLchar>(),
            )
        };

        if log_length <= buffer_len as GLint && written != log_length - 1 {
            case.fail(
                format!("Expected length {}; got {written}", log_length - 1),
                "got invalid log length",
            );
        }

        let terminator = if log_length < buffer_len as GLint {
            match usize::try_from(written) {
                Ok(index) if index < buffer_len => Some(index),
                _ => {
                    case.fail(
                        format!("Reported write length {written} is not within the buffer"),
                        "got invalid log length",
                    );
                    None
                }
            }
        } else {
            Some(buffer_len - 1)
        };

        if let Some(terminator) = terminator
            && buffer[terminator] != 0
        {
            case.fail(
                format!("Expected null terminator, got {}", buffer[terminator]),
                "got invalid log terminator",
            );
        }
    }

    // check with too small buffer
    {
        let mut buffer = new_char_buffer();
        let mut written: GLsizei = 0;

        // SAFETY: a buffer size of 1 is legal and asks for the terminator only.
        unsafe { gl.get_shader_info_log(shader, 1, &raw mut written, buffer.as_mut_ptr().cast::<glw::GLchar>()) };

        if written != 0 {
            case.fail(format!("Expected length 0; got {written}"), "got invalid log length");
        }
        if buffer[0] != 0 {
            case.fail(
                format!("Expected null terminator, got {}", buffer[0]),
                "got invalid log terminator",
            );
        }
    }

    // SAFETY: as above.
    unsafe { gl.delete_shader(shader) };
    case.expect_error(glw::GL_NO_ERROR);
}

/// `ShaderSourceCase`
fn shader_source_length(case: &mut ApiCase<'_>) {
    if !require_shader_compiler(case) {
        return;
    }

    let gl = case.gl();
    // SHADER_SOURCE_LENGTH does include the 0-terminator.
    // SAFETY: the name is deleted below.
    let shader = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
    verify_shader_param(case, shader, glw::GL_SHADER_SOURCE_LENGTH, 0);

    let source_len = BROKEN_SHADER.len() as GLint;

    // check the SHADER_SOURCE_LENGTH
    {
        shader_source(case, shader, &[BROKEN_SHADER]);
        case.expect_error(glw::GL_NO_ERROR);

        let mut length = Guarded::<GLint>::new();
        // SAFETY: one GLint out.
        unsafe { gl.get_shaderiv(shader, glw::GL_SHADER_SOURCE_LENGTH, length.as_mut_ptr()) };
        length.verify_validity(case);

        let reference_length = source_len + 1; // including the null terminator
        if length.value() != reference_length {
            case.fail(
                format!("Expected length {reference_length}; got {}", length.value()),
                "got invalid source length",
            );
        }
    }

    // check the concat source SHADER_SOURCE_LENGTH
    {
        shader_source(case, shader, &[BROKEN_SHADER, BROKEN_SHADER]);
        case.expect_error(glw::GL_NO_ERROR);

        let mut length = Guarded::<GLint>::new();
        // SAFETY: as above.
        unsafe { gl.get_shaderiv(shader, glw::GL_SHADER_SOURCE_LENGTH, length.as_mut_ptr()) };
        length.verify_validity(case);

        let reference_length = 2 * source_len + 1; // including the null terminator
        if length.value() != reference_length {
            case.fail(
                format!("Expected length {reference_length}; got {}", length.value()),
                "got invalid source length",
            );
        }
    }

    // check the string length
    {
        let mut buffer = new_char_buffer();
        let buffer_len = buffer.len();
        debug_assert!(buffer_len > 2 * BROKEN_SHADER.len());

        let mut written: GLsizei = 0; // not including the null terminator
        // SAFETY: the buffer is `buffer_len` bytes and `written` is one GLsizei.
        unsafe {
            gl.get_shader_source(
                shader,
                buffer_len as GLsizei,
                &raw mut written,
                buffer.as_mut_ptr().cast::<glw::GLchar>(),
            )
        };

        let reference_length = 2 * source_len;
        if written == reference_length {
            if buffer[reference_length as usize] != 0 {
                case.fail(
                    format!("Expected null terminator at {reference_length}"),
                    "did not get a null terminator",
                );
            }
        } else {
            case.fail(
                format!("Expected write length {reference_length}; got {written}"),
                "got invalid source length",
            );
        }
    }

    // check with small buffer
    {
        let mut buffer = new_char_buffer();
        let mut written: GLsizei = 0;

        // SAFETY: a buffer size of 1 asks for the terminator only.
        unsafe { gl.get_shader_source(shader, 1, &raw mut written, buffer.as_mut_ptr().cast::<glw::GLchar>()) };

        if written != 0 {
            case.fail(
                format!("Expected write length 0; got {written}"),
                "got invalid source length",
            );
        }
        if buffer[0] != 0 {
            case.fail(
                format!("Expected null terminator; got={}", buffer[0]),
                "got invalid terminator",
            );
        }
    }

    // SAFETY: as above.
    unsafe { gl.delete_shader(shader) };
    case.expect_error(glw::GL_NO_ERROR);
}

/// `DeleteStatusCase` - a shader or program still in use is only flagged for deletion.
fn delete_status(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let (shader_vert, shader_frag) = create_compiled_pair(case, COMMON_TEST_VERT_SOURCE, COMMON_TEST_FRAG_SOURCE);

    verify_shader_param(case, shader_vert, glw::GL_COMPILE_STATUS, glw::GL_TRUE as GLint);
    verify_shader_param(case, shader_frag, glw::GL_COMPILE_STATUS, glw::GL_TRUE as GLint);

    // SAFETY: both shaders compiled; the program is deleted below.
    let shader_prog = unsafe {
        let program = gl.create_program();
        gl.attach_shader(program, shader_vert);
        gl.attach_shader(program, shader_frag);
        gl.link_program(program);
        program
    };
    case.expect_error(glw::GL_NO_ERROR);

    verify_program_param(case, shader_prog, glw::GL_LINK_STATUS, glw::GL_TRUE as GLint);

    verify_shader_param(case, shader_vert, glw::GL_DELETE_STATUS, glw::GL_FALSE as GLint);
    verify_shader_param(case, shader_frag, glw::GL_DELETE_STATUS, glw::GL_FALSE as GLint);
    verify_program_param(case, shader_prog, glw::GL_DELETE_STATUS, glw::GL_FALSE as GLint);
    case.expect_error(glw::GL_NO_ERROR);

    // The program stays alive after glDeleteProgram because it is the current one.
    // SAFETY: every name is this case's own.
    unsafe {
        gl.use_program(shader_prog);
        gl.delete_shader(shader_vert);
        gl.delete_shader(shader_frag);
        gl.delete_program(shader_prog);
    }
    case.expect_error(glw::GL_NO_ERROR);

    verify_shader_param(case, shader_vert, glw::GL_DELETE_STATUS, glw::GL_TRUE as GLint);
    verify_shader_param(case, shader_frag, glw::GL_DELETE_STATUS, glw::GL_TRUE as GLint);
    verify_program_param(case, shader_prog, glw::GL_DELETE_STATUS, glw::GL_TRUE as GLint);
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: unbinding lets the driver finish the deletion.
    unsafe { gl.use_program(0) };
    case.expect_error(glw::GL_NO_ERROR);
}

/// `glGetIntegerv(GL_MAX_VERTEX_ATTRIBS)`, defaulting to 16 exactly as upstream's
/// pre-initialised local does.
fn attribute_count(case: &ApiCase<'_>) -> GLint {
    let mut count = 16;
    // SAFETY: one GLint out.
    unsafe { case.gl().get_integerv(glw::GL_MAX_VERTEX_ATTRIBS, &raw mut count) };
    count
}

/// `CurrentVertexAttribInitialCase`
fn current_vertex_attrib_initial(case: &mut ApiCase<'_>) {
    for index in 0..attribute_count(case) {
        let mut attrib_value = Guarded::<[GLfloat; 4]>::new();
        // SAFETY: four floats out, guarded on both sides.
        unsafe {
            case.gl().get_vertex_attribfv(
                index as GLuint,
                glw::GL_CURRENT_VERTEX_ATTRIB,
                attrib_value.as_mut_ptr().cast::<GLfloat>(),
            );
        }
        attrib_value.verify_validity(case);

        if attrib_value.value() != [0.0, 0.0, 0.0, 1.0] {
            case.fail(
                format!("Expected [0, 0, 0, 1]; got {:?}", attrib_value.value()),
                "got invalid attribute value",
            );
        }
    }
}

/// The four `glVertexAttrib{1,2,3,4}f` passes both float current-vertex-attrib cases
/// make, in the same order and with the same defaults for the components not written.
fn for_each_vertex_attrib_write(
    case: &mut ApiCase<'_>,
    mut verify: impl FnMut(&mut ApiCase<'_>, GLuint, [GLfloat; 4]),
) {
    let count = attribute_count(case);
    let mut rnd = Random::new(0x00ab_cdef);
    let gl = case.gl();

    for index in 0..count {
        let v = [0; 4].map(|_: i32| rnd.get_float_range(-64000.0, 64000.0));
        // SAFETY: `index` is below MAX_VERTEX_ATTRIBS.
        unsafe { gl.vertex_attrib_4f(index as GLuint, v[0], v[1], v[2], v[3]) };
        verify(case, index as GLuint, v);
    }
    for index in 0..count {
        let v = [0; 3].map(|_: i32| rnd.get_float_range(-64000.0, 64000.0));
        // SAFETY: as above.
        unsafe { gl.vertex_attrib_3f(index as GLuint, v[0], v[1], v[2]) };
        verify(case, index as GLuint, [v[0], v[1], v[2], 1.0]);
    }
    for index in 0..count {
        let v = [0; 2].map(|_: i32| rnd.get_float_range(-64000.0, 64000.0));
        // SAFETY: as above.
        unsafe { gl.vertex_attrib_2f(index as GLuint, v[0], v[1]) };
        verify(case, index as GLuint, [v[0], v[1], 0.0, 1.0]);
    }
    for index in 0..count {
        let x = rnd.get_float_range(-64000.0, 64000.0);
        // SAFETY: as above.
        unsafe { gl.vertex_attrib_1f(index as GLuint, x) };
        verify(case, index as GLuint, [x, 0.0, 0.0, 1.0]);
    }
}

/// `CurrentVertexAttribFloatCase`
fn current_vertex_attrib_float(case: &mut ApiCase<'_>) {
    for_each_vertex_attrib_write(case, verify_current_vertex_attribf);
}

/// `CurrentVertexAttribConversionCase`
fn current_vertex_attrib_float_to_int(case: &mut ApiCase<'_>) {
    for_each_vertex_attrib_write(case, verify_current_vertex_attrib_conversion);
}

/// `CurrentVertexAttribIntCase`
fn current_vertex_attrib_int(case: &mut ApiCase<'_>) {
    let count = attribute_count(case);
    let mut rnd = Random::new(0x00ab_cdef);
    let gl = case.gl();

    for index in 0..count {
        let v = [0; 4].map(|_: i32| rnd.get_int(-64000, 64000));
        // SAFETY: `index` is below MAX_VERTEX_ATTRIBS.
        unsafe { gl.vertex_attrib_i_4i(index as GLuint, v[0], v[1], v[2], v[3]) };
        verify_current_vertex_attrib_ii(case, index as GLuint, v);
    }
}

/// `CurrentVertexAttribUintCase`
fn current_vertex_attrib_uint(case: &mut ApiCase<'_>) {
    let count = attribute_count(case);
    let mut rnd = Random::new(0x00ab_cdef);
    let gl = case.gl();

    for index in 0..count {
        let v = [0; 4].map(|_: i32| rnd.get_int(0, 64000) as GLuint);
        // SAFETY: as above.
        unsafe { gl.vertex_attrib_i_4ui(index as GLuint, v[0], v[1], v[2], v[3]) };
        verify_current_vertex_attrib_iui(case, index as GLuint, v);
    }
}

/// `ProgramInfoLogCase` - `link_error` picks upstream's `BUILDERROR_LINK` sources,
/// which compile but cannot be linked together.
fn program_info_log_length(case: &mut ApiCase<'_>, link_error: bool) {
    let gl = case.gl();
    let (vert_source, frag_source) = if link_error {
        (LINK_ERROR_VERT_SOURCE, LINK_ERROR_FRAG_SOURCE)
    } else {
        (BROKEN_SHADER, BROKEN_SHADER)
    };
    let (shader_vert, shader_frag) = create_compiled_pair(case, vert_source, frag_source);

    // SAFETY: the program is deleted below.
    let program = unsafe {
        let program = gl.create_program();
        gl.attach_shader(program, shader_vert);
        gl.attach_shader(program, shader_frag);
        gl.link_program(program);
        program
    };

    let mut log_length = Guarded::<GLint>::new();
    // SAFETY: one GLint out.
    unsafe { gl.get_programiv(program, glw::GL_INFO_LOG_LENGTH, log_length.as_mut_ptr()) };
    log_length.verify_validity(case);
    let log_length = log_length.value();

    // Query to large buffer: INFO_LOG_LENGTH == GetProgramInfoLog len + 1.
    {
        case.section("Query to large buffer");
        let mut buffer = new_char_buffer();
        let buffer_len = buffer.len();
        let mut written: GLsizei = 0;

        // SAFETY: the buffer is `buffer_len` bytes and `written` is one GLsizei.
        unsafe {
            gl.get_program_info_log(
                program,
                buffer_len as GLsizei,
                &raw mut written,
                buffer.as_mut_ptr().cast::<glw::GLchar>(),
            )
        };

        if log_length != 0 && written + 1 != log_length {
            case.fail(
                format!("Expected INFO_LOG_LENGTH {}; got {log_length}", written + 1),
                "got invalid log length",
            );
        } else if log_length != 0 {
            match usize::try_from(written) {
                Ok(index) if index < buffer_len && buffer[index] != 0 => {
                    case.fail(
                        format!("Expected null terminator at index {written}"),
                        "missing null terminator",
                    );
                }
                Ok(_) => {}
                Err(_) => case.fail(
                    format!("Reported write length {written} is not within the buffer"),
                    "got invalid log length",
                ),
            }
        }
    }

    // Query all into an exactly-right-sized buffer.
    if 2048 > log_length {
        case.section("Query all to exactly right sized buffer");
        let mut buffer = new_char_buffer();
        let buffer_len = buffer.len();
        let mut written: GLsizei = 0;

        // SAFETY: `log_length` is at most the buffer's size, checked just above.
        unsafe {
            gl.get_program_info_log(
                program,
                log_length,
                &raw mut written,
                buffer.as_mut_ptr().cast::<glw::GLchar>(),
            )
        };

        if log_length != 0 && written + 1 != log_length {
            case.fail(
                format!("Expected INFO_LOG_LENGTH {}; got {log_length}", written + 1),
                "got invalid log length",
            );
        } else if log_length != 0 {
            match usize::try_from(written) {
                Ok(index) if index < buffer_len && buffer[index] != 0 => {
                    case.fail(
                        format!("Expected null terminator at index {written}"),
                        "missing null terminator",
                    );
                }
                Ok(_) => {}
                Err(_) => case.fail(
                    format!("Reported write length {written} is not within the buffer"),
                    "got invalid log length",
                ),
            }
        }
    }

    // Query none.
    {
        case.section("Query none");
        let mut buffer = new_char_buffer();
        let mut written: GLsizei = 0;

        // SAFETY: a buffer size of 1 asks for the terminator only.
        unsafe { gl.get_program_info_log(program, 1, &raw mut written, buffer.as_mut_ptr().cast::<glw::GLchar>()) };

        if written != 0 {
            case.fail(
                format!("Expected write length 0; got {written}"),
                "got invalid log length",
            );
        }
    }

    // SAFETY: every name is this case's own.
    unsafe {
        gl.delete_shader(shader_vert);
        gl.delete_shader(shader_frag);
        gl.delete_program(program);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `ProgramValidateStatusCase` - once with a program that links and once with one that
/// cannot, since VALIDATE_STATUS has to follow LINK_STATUS.
fn program_validate_status(case: &mut ApiCase<'_>) {
    for (frag_source, expected) in [
        (COMMON_TEST_FRAG_SOURCE, glw::GL_TRUE as GLint),
        (BROKEN_SHADER, glw::GL_FALSE as GLint),
    ] {
        let gl = case.gl();
        let (shader_vert, shader_frag) = create_compiled_pair(case, COMMON_TEST_VERT_SOURCE, frag_source);

        // SAFETY: the program is deleted below.
        let program = unsafe {
            let program = gl.create_program();
            gl.attach_shader(program, shader_vert);
            gl.attach_shader(program, shader_frag);
            gl.link_program(program);
            program
        };
        case.expect_error(glw::GL_NO_ERROR);

        verify_shader_param(case, shader_vert, glw::GL_COMPILE_STATUS, glw::GL_TRUE as GLint);
        verify_shader_param(case, shader_frag, glw::GL_COMPILE_STATUS, expected);
        verify_program_param(case, program, glw::GL_LINK_STATUS, expected);

        // SAFETY: a live program name.
        unsafe { gl.validate_program(program) };
        verify_program_param(case, program, glw::GL_VALIDATE_STATUS, expected);

        // SAFETY: every name is this case's own.
        unsafe {
            gl.delete_shader(shader_vert);
            gl.delete_shader(shader_frag);
            gl.delete_program(program);
        }
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `ProgramAttachedShadersCase`
fn program_attached_shaders(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let (shader_vert, shader_frag) = create_compiled_pair(case, COMMON_TEST_VERT_SOURCE, COMMON_TEST_FRAG_SOURCE);

    // SAFETY: the program is deleted below.
    let program = unsafe { gl.create_program() };
    verify_program_param(case, program, glw::GL_ATTACHED_SHADERS, 0);
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: both shaders are live and not yet attached.
    unsafe { gl.attach_shader(program, shader_vert) };
    verify_program_param(case, program, glw::GL_ATTACHED_SHADERS, 1);
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
    unsafe { gl.attach_shader(program, shader_frag) };
    verify_program_param(case, program, glw::GL_ATTACHED_SHADERS, 2);
    case.expect_error(glw::GL_NO_ERROR);

    // check GetAttachedShaders
    {
        let mut shaders = [0u32; 2];
        let mut count: GLsizei = 0;
        // SAFETY: the array holds two names and `count` is one GLsizei.
        unsafe { gl.get_attached_shaders(program, 2, &raw mut count, shaders.as_mut_ptr()) };

        if count != 2 {
            case.fail(format!("Expected 2; got {count}"), "got wrong shader count");
        }
        if shaders != [shader_vert, shader_frag] && shaders != [shader_frag, shader_vert] {
            case.fail(
                format!(
                    "Expected {{{shader_vert}, {shader_frag}}}; got {{{}, {}}}",
                    shaders[0], shaders[1]
                ),
                "got wrong shader count",
            );
        }
    }

    // check GetAttachedShaders with too small buffer
    {
        let mut shaders = [0u32; 2];
        let mut count: GLsizei = 0;

        // SAFETY: asking for zero names writes none.
        unsafe { gl.get_attached_shaders(program, 0, &raw mut count, shaders.as_mut_ptr()) };
        if count != 0 {
            case.fail(format!("Expected 0; got {count}"), "got wrong shader count");
        }

        count = 0;
        // SAFETY: asking for one name writes at most one.
        unsafe { gl.get_attached_shaders(program, 1, &raw mut count, shaders.as_mut_ptr()) };
        if count != 1 {
            case.fail(format!("Expected 1; got {count}"), "got wrong shader count");
        }
    }

    // SAFETY: every name is this case's own.
    unsafe {
        gl.delete_shader(shader_vert);
        gl.delete_shader(shader_frag);
        gl.delete_program(program);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `ProgramActiveUniformNameCase`
fn program_active_uniform_name(case: &mut ApiCase<'_>) {
    const UNIFORM_NAMES: [&str; 3] = ["uniformNameWithLength23", "uniformVec2", "uniformMat4"];

    let test_vert_source = "#version 300 es\n\
                            uniform highp float uniformNameWithLength23;\n\
                            uniform highp vec2 uniformVec2;\n\
                            uniform highp mat4 uniformMat4;\n\
                            void main (void)\n\
                            {\n\
                            \tgl_Position = vec4(0.0) + vec4(uniformNameWithLength23) + vec4(uniformVec2.x) + vec4(uniformMat4[2][3]);\n\
                            }\n";

    let gl = case.gl();
    let (shader_vert, shader_frag) = create_compiled_pair(case, test_vert_source, COMMON_TEST_FRAG_SOURCE);

    // SAFETY: the program is deleted below.
    let program = unsafe {
        let program = gl.create_program();
        gl.attach_shader(program, shader_vert);
        gl.attach_shader(program, shader_frag);
        gl.link_program(program);
        program
    };
    case.expect_error(glw::GL_NO_ERROR);

    verify_program_param(case, program, glw::GL_ACTIVE_UNIFORMS, 3);
    // ACTIVE_UNIFORM_MAX_LENGTH includes the null terminator.
    verify_program_param(
        case,
        program,
        glw::GL_ACTIVE_UNIFORM_MAX_LENGTH,
        UNIFORM_NAMES[0].len() as GLint + 1,
    );
    case.expect_error(glw::GL_NO_ERROR);

    let owned: Vec<CString> = UNIFORM_NAMES
        .iter()
        .map(|name| CString::new(*name).expect("no interior nul"))
        .collect();
    let pointers: Vec<*const glw::GLchar> = owned.iter().map(|name| name.as_ptr()).collect();
    let mut uniform_indices = Guarded::<[GLuint; 3]>::new();
    // SAFETY: three live null-terminated names in, three indices out.
    unsafe {
        gl.get_uniform_indices(
            program,
            3,
            pointers.as_ptr(),
            uniform_indices.as_mut_ptr().cast::<GLuint>(),
        );
    }
    uniform_indices.verify_validity(case);
    let uniform_indices = uniform_indices.value();

    // check name lengths
    for (ndx, name) in UNIFORM_NAMES.iter().enumerate() {
        let uniform_index = uniform_indices[ndx];
        let mut uniform_name_len = Guarded::<GLint>::new();
        // SAFETY: one index in, one GLint out.
        unsafe {
            gl.get_active_uniformsiv(
                program,
                1,
                &raw const uniform_index,
                glw::GL_UNIFORM_NAME_LENGTH,
                uniform_name_len.as_mut_ptr(),
            );
        }
        uniform_name_len.verify_validity(case);

        let reference_length = name.len() as GLint + 1; // with the null terminator
        if reference_length != uniform_name_len.value() {
            case.fail(
                format!("Expected {reference_length}, got {}", uniform_name_len.value()),
                "got wrong uniform name length",
            );
        }
    }

    // check names
    for (ndx, name) in UNIFORM_NAMES.iter().enumerate() {
        let mut buffer = new_char_buffer();
        let buffer_len = buffer.len();
        let uniform_index = uniform_indices[ndx];

        let mut written: GLint = 0; // null terminator not included
        let mut size: GLint = 0;
        let mut type_: GLenum = 0;
        // SAFETY: the buffer is `buffer_len` bytes and the three out-parameters are one
        // value each.
        unsafe {
            gl.get_active_uniform(
                program,
                uniform_index,
                buffer_len as GLsizei,
                &raw mut written,
                &raw mut size,
                &raw mut type_,
                buffer.as_mut_ptr().cast::<glw::GLchar>(),
            );
        }

        let reference_length = name.len() as GLint;
        if reference_length != written {
            case.fail(
                format!("Expected {reference_length}, got {written}"),
                "got wrong uniform name length",
            );
        }

        // and with too small buffer
        written = 0;
        // SAFETY: a buffer size of 1 asks for the terminator only.
        unsafe {
            gl.get_active_uniform(
                program,
                uniform_index,
                1,
                &raw mut written,
                &raw mut size,
                &raw mut type_,
                buffer.as_mut_ptr().cast::<glw::GLchar>(),
            );
        }

        if written != 0 {
            case.fail(format!("Expected 0, got {written}"), "got wrong uniform name length");
        }
    }

    // SAFETY: every name is this case's own.
    unsafe {
        gl.delete_shader(shader_vert);
        gl.delete_shader(shader_frag);
        gl.delete_program(program);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `PointerData` - one `glVertexAttribPointer` call's arguments.
#[derive(Clone, Copy)]
struct PointerData {
    size: GLint,
    type_: GLenum,
    stride: GLsizei,
    normalized: glw::GLboolean,
    /// Index into the case's `vertexData`, since a Rust local's address cannot be a
    /// `const` the way upstream's array-of-pointers is a stack initialiser.
    offset: usize,
}

impl PointerData {
    const fn plain(size: GLint, type_: GLenum) -> Self {
        Self {
            size,
            type_,
            stride: 0,
            normalized: glw::FALSE,
            offset: 0,
        }
    }
}

/// Upstream's "DefaultVAO" pass: one `glVertexAttribPointer` per row, then one state
/// check. `integer` selects `glVertexAttribIPointer` instead, which upstream uses for
/// its second block in the type/stride/normalized/integer cases.
fn pointer_pass(
    case: &mut ApiCase<'_>,
    pname: GLenum,
    pointers: &[PointerData],
    integer: bool,
    reference: impl Fn(&PointerData) -> GLint,
) {
    let vertex_data = [0.0f32; 4]; // never accessed

    for pointer in pointers {
        let gl = case.gl();
        // SAFETY: attribute 0 always exists. The pointer is never dereferenced - no draw
        // call happens in this group - which is why a stack address is fine here.
        unsafe {
            let address = vertex_data.as_ptr().add(pointer.offset).cast::<c_void>();
            if integer {
                gl.vertex_attrib_i_pointer(0, pointer.size, pointer.type_, pointer.stride, address);
            } else {
                gl.vertex_attrib_pointer(
                    0,
                    pointer.size,
                    pointer.type_,
                    pointer.normalized,
                    pointer.stride,
                    address,
                );
            }
        }
        case.expect_error(glw::GL_NO_ERROR);

        verify_vertex_attrib(case, 0, pname, reference(pointer));
    }
}

/// Upstream's "WithVAO" pass: the state is per vertex-array object, so two of them get
/// different values and each is read back.
fn vao_pair_pass(
    case: &mut ApiCase<'_>,
    pname: GLenum,
    initial: GLint,
    first: PointerData,
    second: PointerData,
    reference: impl Fn(&PointerData) -> GLint,
) {
    let gl = case.gl();

    let mut vaos = [0u32; 2];
    let mut buffer = 0;
    // SAFETY: fresh names, all deleted below; a bound buffer makes the null pointer an
    // offset rather than an address.
    unsafe {
        gl.gen_vertex_arrays(2, vaos.as_mut_ptr());
        gl.gen_buffers(1, &raw mut buffer);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer);
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: the name was just generated.
    unsafe { gl.bind_vertex_array(vaos[0]) };
    verify_vertex_attrib(case, 0, pname, initial);
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: attribute 0 always exists; the pointer is an offset into the bound buffer.
    unsafe {
        gl.vertex_attrib_pointer(
            0,
            first.size,
            first.type_,
            first.normalized,
            first.stride,
            std::ptr::null(),
        )
    };
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
    unsafe { gl.bind_vertex_array(vaos[1]) };
    // SAFETY: as above.
    unsafe {
        gl.vertex_attrib_pointer(
            0,
            second.size,
            second.type_,
            second.normalized,
            second.stride,
            std::ptr::null(),
        )
    };
    case.expect_error(glw::GL_NO_ERROR);

    verify_vertex_attrib(case, 0, pname, reference(&second));
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
    unsafe { gl.bind_vertex_array(vaos[0]) };
    verify_vertex_attrib(case, 0, pname, reference(&first));
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: every name is this case's own.
    unsafe {
        gl.delete_vertex_arrays(2, vaos.as_ptr());
        gl.delete_buffers(1, &raw const buffer);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `VertexAttributeSizeCase`
fn vertex_attrib_size(case: &mut ApiCase<'_>) {
    const POINTERS: [PointerData; 8] = [
        PointerData::plain(4, glw::GL_FLOAT),
        PointerData::plain(3, glw::GL_FLOAT),
        PointerData::plain(2, glw::GL_FLOAT),
        PointerData::plain(1, glw::GL_FLOAT),
        PointerData::plain(4, glw::GL_INT),
        PointerData::plain(3, glw::GL_INT),
        PointerData::plain(2, glw::GL_INT),
        PointerData::plain(1, glw::GL_INT),
    ];

    case.section("Test with default VAO");
    pointer_pass(case, glw::GL_VERTEX_ATTRIB_ARRAY_SIZE, &POINTERS, false, |pointer| {
        pointer.size
    });

    case.section("Test with VAO");
    vao_pair_pass(
        case,
        glw::GL_VERTEX_ATTRIB_ARRAY_SIZE,
        4,
        POINTERS[0],
        POINTERS[1],
        |pointer| pointer.size,
    );
}

/// The eleven `glVertexAttribPointer` types ES 3.0 accepts.
const ALL_POINTER_TYPES: [PointerData; 11] = [
    PointerData::plain(1, glw::GL_BYTE),
    PointerData::plain(1, glw::GL_SHORT),
    PointerData::plain(1, glw::GL_INT),
    PointerData::plain(1, glw::GL_FIXED),
    PointerData::plain(1, glw::GL_FLOAT),
    PointerData::plain(1, glw::GL_HALF_FLOAT),
    PointerData::plain(1, glw::GL_UNSIGNED_BYTE),
    PointerData::plain(1, glw::GL_UNSIGNED_SHORT),
    PointerData::plain(1, glw::GL_UNSIGNED_INT),
    PointerData::plain(4, glw::GL_INT_2_10_10_10_REV),
    PointerData::plain(4, glw::GL_UNSIGNED_INT_2_10_10_10_REV),
];

/// The six integer types `glVertexAttribIPointer` accepts.
const INTEGER_POINTER_TYPES: [PointerData; 6] = [
    PointerData::plain(1, glw::GL_BYTE),
    PointerData::plain(1, glw::GL_SHORT),
    PointerData::plain(1, glw::GL_INT),
    PointerData::plain(1, glw::GL_UNSIGNED_BYTE),
    PointerData::plain(1, glw::GL_UNSIGNED_SHORT),
    PointerData::plain(1, glw::GL_UNSIGNED_INT),
];

/// `VertexAttributeTypeCase`
fn vertex_attrib_type(case: &mut ApiCase<'_>) {
    case.section("Test with default VAO");
    pointer_pass(
        case,
        glw::GL_VERTEX_ATTRIB_ARRAY_TYPE,
        &ALL_POINTER_TYPES,
        false,
        |pointer| pointer.type_ as GLint,
    );
    pointer_pass(
        case,
        glw::GL_VERTEX_ATTRIB_ARRAY_TYPE,
        &INTEGER_POINTER_TYPES,
        true,
        |pointer| pointer.type_ as GLint,
    );

    case.section("Test with VAO");
    vao_pair_pass(
        case,
        glw::GL_VERTEX_ATTRIB_ARRAY_TYPE,
        glw::GL_FLOAT as GLint,
        ALL_POINTER_TYPES[0],
        ALL_POINTER_TYPES[1],
        |pointer| pointer.type_ as GLint,
    );
}

/// `VertexAttributeStrideCase`
fn vertex_attrib_stride(case: &mut ApiCase<'_>) {
    const ROWS: [(GLint, GLenum, GLsizei); 9] = [
        (1, glw::GL_FLOAT, 0),
        (1, glw::GL_FLOAT, 1),
        (1, glw::GL_FLOAT, 4),
        (1, glw::GL_HALF_FLOAT, 0),
        (1, glw::GL_HALF_FLOAT, 1),
        (1, glw::GL_HALF_FLOAT, 4),
        (1, glw::GL_FIXED, 0),
        (1, glw::GL_FIXED, 1),
        (1, glw::GL_FIXED, 4),
    ];
    const INTEGER_ROWS: [(GLint, GLenum, GLsizei); 6] = [
        (1, glw::GL_INT, 0),
        (1, glw::GL_INT, 1),
        (1, glw::GL_INT, 4),
        (1, glw::GL_UNSIGNED_INT, 0),
        (1, glw::GL_UNSIGNED_INT, 1),
        (1, glw::GL_UNSIGNED_INT, 4),
    ];

    let make = |rows: &[(GLint, GLenum, GLsizei)]| -> Vec<PointerData> {
        rows.iter()
            .map(|(size, type_, stride)| PointerData {
                size: *size,
                type_: *type_,
                stride: *stride,
                normalized: glw::FALSE,
                offset: 0,
            })
            .collect()
    };

    case.section("Test with default VAO");
    let pointers = make(&ROWS);
    pointer_pass(case, glw::GL_VERTEX_ATTRIB_ARRAY_STRIDE, &pointers, false, |pointer| {
        pointer.stride
    });
    let integer_pointers = make(&INTEGER_ROWS);
    pointer_pass(
        case,
        glw::GL_VERTEX_ATTRIB_ARRAY_STRIDE,
        &integer_pointers,
        true,
        |pointer| pointer.stride,
    );

    case.section("Test with VAO");
    vao_pair_pass(
        case,
        glw::GL_VERTEX_ATTRIB_ARRAY_STRIDE,
        0,
        pointers[0],
        pointers[1],
        |pointer| pointer.stride,
    );
}

/// `VertexAttributeNormalizedCase`
fn vertex_attrib_normalized(case: &mut ApiCase<'_>) {
    let mut pointers = Vec::new();
    for normalized in [glw::FALSE, glw::TRUE] {
        for row in [
            (1, glw::GL_BYTE),
            (1, glw::GL_SHORT),
            (1, glw::GL_INT),
            (1, glw::GL_UNSIGNED_BYTE),
            (1, glw::GL_UNSIGNED_SHORT),
            (1, glw::GL_UNSIGNED_INT),
            (4, glw::GL_INT_2_10_10_10_REV),
            (4, glw::GL_UNSIGNED_INT_2_10_10_10_REV),
        ] {
            pointers.push(PointerData {
                size: row.0,
                type_: row.1,
                stride: 0,
                normalized,
                offset: 0,
            });
        }
    }

    case.section("Test with default VAO");
    pointer_pass(
        case,
        glw::GL_VERTEX_ATTRIB_ARRAY_NORMALIZED,
        &pointers,
        false,
        |pointer| GLint::from(pointer.normalized),
    );
    // An integer pointer is never normalized.
    pointer_pass(
        case,
        glw::GL_VERTEX_ATTRIB_ARRAY_NORMALIZED,
        &INTEGER_POINTER_TYPES,
        true,
        |_| glw::GL_FALSE as GLint,
    );

    case.section("Test with VAO");
    vao_pair_pass(
        case,
        glw::GL_VERTEX_ATTRIB_ARRAY_NORMALIZED,
        glw::GL_FALSE as GLint,
        pointers[0],
        pointers[8],
        |pointer| GLint::from(pointer.normalized),
    );
}

/// `VertexAttributeIntegerCase` - VERTEX_ATTRIB_ARRAY_INTEGER is false for every
/// `glVertexAttribPointer` type and true for every `glVertexAttribIPointer` one.
fn vertex_attrib_integer(case: &mut ApiCase<'_>) {
    case.section("Test with default VAO");
    pointer_pass(
        case,
        glw::GL_VERTEX_ATTRIB_ARRAY_INTEGER,
        &ALL_POINTER_TYPES,
        false,
        |_| glw::GL_FALSE as GLint,
    );
    pointer_pass(
        case,
        glw::GL_VERTEX_ATTRIB_ARRAY_INTEGER,
        &INTEGER_POINTER_TYPES,
        true,
        |_| glw::GL_TRUE as GLint,
    );

    case.section("Test with VAO");
    let gl = case.gl();
    let mut vaos = [0u32; 2];
    let mut buffer = 0;
    // SAFETY: fresh names, all deleted below.
    unsafe {
        gl.gen_vertex_arrays(2, vaos.as_mut_ptr());
        gl.gen_buffers(1, &raw mut buffer);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer);
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: the names were just generated; the pointer is an offset into the buffer.
    unsafe {
        gl.bind_vertex_array(vaos[0]);
        gl.vertex_attrib_i_pointer(0, 1, glw::GL_INT, 0, std::ptr::null());
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
    unsafe {
        gl.bind_vertex_array(vaos[1]);
        gl.vertex_attrib_pointer(0, 1, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
    }
    case.expect_error(glw::GL_NO_ERROR);

    verify_vertex_attrib(case, 0, glw::GL_VERTEX_ATTRIB_ARRAY_INTEGER, glw::GL_FALSE as GLint);

    // SAFETY: as above.
    unsafe { gl.bind_vertex_array(vaos[0]) };
    verify_vertex_attrib(case, 0, glw::GL_VERTEX_ATTRIB_ARRAY_INTEGER, glw::GL_TRUE as GLint);

    // SAFETY: every name is this case's own.
    unsafe {
        gl.delete_vertex_arrays(2, vaos.as_ptr());
        gl.delete_buffers(1, &raw const buffer);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `VertexAttributeEnabledCase`
fn vertex_attrib_array_enabled(case: &mut ApiCase<'_>) {
    let gl = case.gl();

    case.section("Test with default VAO");
    verify_vertex_attrib(case, 0, glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED, glw::GL_FALSE as GLint);
    // SAFETY: attribute 0 always exists.
    unsafe { gl.enable_vertex_attrib_array(0) };
    verify_vertex_attrib(case, 0, glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED, glw::GL_TRUE as GLint);
    // SAFETY: as above.
    unsafe { gl.disable_vertex_attrib_array(0) };
    verify_vertex_attrib(case, 0, glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED, glw::GL_FALSE as GLint);

    case.section("Test with VAO");
    let mut vaos = [0u32; 2];
    // SAFETY: fresh names, deleted below.
    unsafe { gl.gen_vertex_arrays(2, vaos.as_mut_ptr()) };
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: the names were just generated.
    unsafe {
        gl.bind_vertex_array(vaos[0]);
        gl.enable_vertex_attrib_array(0);
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
    unsafe {
        gl.bind_vertex_array(vaos[1]);
        gl.disable_vertex_attrib_array(0);
    }
    case.expect_error(glw::GL_NO_ERROR);

    verify_vertex_attrib(case, 0, glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED, glw::GL_FALSE as GLint);
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
    unsafe { gl.bind_vertex_array(vaos[0]) };
    verify_vertex_attrib(case, 0, glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED, glw::GL_TRUE as GLint);
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: the names are this case's own.
    unsafe { gl.delete_vertex_arrays(2, vaos.as_ptr()) };
    case.expect_error(glw::GL_NO_ERROR);
}

/// `VertexAttributeDivisorCase`
fn vertex_attrib_array_divisor(case: &mut ApiCase<'_>) {
    let gl = case.gl();

    case.section("Test with default VAO");
    verify_vertex_attrib(case, 0, glw::GL_VERTEX_ATTRIB_ARRAY_DIVISOR, 0);
    // SAFETY: attribute 0 always exists.
    unsafe { gl.vertex_attrib_divisor(0, 1) };
    verify_vertex_attrib(case, 0, glw::GL_VERTEX_ATTRIB_ARRAY_DIVISOR, 1);
    // SAFETY: as above.
    unsafe { gl.vertex_attrib_divisor(0, 5) };
    verify_vertex_attrib(case, 0, glw::GL_VERTEX_ATTRIB_ARRAY_DIVISOR, 5);

    case.section("Test with VAO");
    let mut vaos = [0u32; 2];
    // SAFETY: fresh names, deleted below.
    unsafe { gl.gen_vertex_arrays(2, vaos.as_mut_ptr()) };
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: the names were just generated.
    unsafe {
        gl.bind_vertex_array(vaos[0]);
        gl.vertex_attrib_divisor(0, 1);
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
    unsafe {
        gl.bind_vertex_array(vaos[1]);
        gl.vertex_attrib_divisor(0, 5);
    }
    case.expect_error(glw::GL_NO_ERROR);

    verify_vertex_attrib(case, 0, glw::GL_VERTEX_ATTRIB_ARRAY_DIVISOR, 5);
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
    unsafe { gl.bind_vertex_array(vaos[0]) };
    verify_vertex_attrib(case, 0, glw::GL_VERTEX_ATTRIB_ARRAY_DIVISOR, 1);
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: the names are this case's own.
    unsafe { gl.delete_vertex_arrays(2, vaos.as_ptr()) };
    case.expect_error(glw::GL_NO_ERROR);
}

/// `VertexAttributeBufferBindingCase`
fn vertex_attrib_array_buffer_binding(case: &mut ApiCase<'_>) {
    let gl = case.gl();

    case.section("Test with default VAO");
    verify_vertex_attrib(case, 0, glw::GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING, 0);

    let mut buffer_id = 0;
    // SAFETY: the name is this case's own and is deleted below.
    unsafe {
        gl.gen_buffers(1, &raw mut buffer_id);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer_id);
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: with a buffer bound the pointer is an offset, not an address.
    unsafe { gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null()) };
    case.expect_error(glw::GL_NO_ERROR);

    verify_vertex_attrib(case, 0, glw::GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING, buffer_id as GLint);

    case.section("Test with VAO");
    let mut vaos = [0u32; 2];
    // SAFETY: fresh names, deleted below.
    unsafe { gl.gen_vertex_arrays(2, vaos.as_mut_ptr()) };
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: the names were just generated; the buffer above is still live.
    unsafe {
        gl.bind_vertex_array(vaos[0]);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer_id);
        gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
    }
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above; the second VAO keeps the default binding of zero.
    unsafe { gl.bind_vertex_array(vaos[1]) };
    verify_vertex_attrib(case, 0, glw::GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING, 0);

    // SAFETY: as above.
    unsafe { gl.bind_vertex_array(vaos[0]) };
    verify_vertex_attrib(case, 0, glw::GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING, buffer_id as GLint);

    // SAFETY: every name is this case's own.
    unsafe {
        gl.delete_vertex_arrays(2, vaos.as_ptr());
        gl.delete_buffers(1, &raw const buffer_id);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `VertexAttributePointerCase` - the one state in this group that is a pointer.
fn vertex_attrib_pointerv(case: &mut ApiCase<'_>) {
    let gl = case.gl();

    let mut initial_state = Guarded::<*mut c_void>::new();
    // SAFETY: one pointer out, guarded on both sides.
    unsafe { gl.get_vertex_attrib_pointerv(0, glw::GL_VERTEX_ATTRIB_ARRAY_POINTER, initial_state.as_mut_ptr()) };
    initial_state.verify_validity(case);
    check_pointer_equals(case, initial_state.value(), std::ptr::null_mut());

    let vertex_data = [0.0f32; 4]; // never accessed
    const ROWS: [(GLint, GLenum, usize); 10] = [
        (1, glw::GL_BYTE, 2),
        (1, glw::GL_SHORT, 1),
        (1, glw::GL_INT, 2),
        (1, glw::GL_FIXED, 1),
        (1, glw::GL_FLOAT, 0),
        (1, glw::GL_HALF_FLOAT, 3),
        (1, glw::GL_FLOAT, 2),
        (1, glw::GL_UNSIGNED_SHORT, 0),
        (4, glw::GL_UNSIGNED_INT_2_10_10_10_REV, 1),
        (4, glw::GL_UNSIGNED_SHORT, 2),
    ];

    for (size, type_, offset) in ROWS {
        // SAFETY: the pointer is never dereferenced - it is only set and read back.
        let pointer = unsafe { vertex_data.as_ptr().add(offset).cast::<c_void>() };
        // SAFETY: as above; attribute 0 always exists.
        unsafe { gl.vertex_attrib_pointer(0, size, type_, glw::FALSE, 0, pointer) };
        case.expect_error(glw::GL_NO_ERROR);

        let mut state = Guarded::<*mut c_void>::new();
        // SAFETY: one pointer out.
        unsafe { gl.get_vertex_attrib_pointerv(0, glw::GL_VERTEX_ATTRIB_ARRAY_POINTER, state.as_mut_ptr()) };
        state.verify_validity(case);
        check_pointer_equals(case, state.value(), pointer.cast_mut());
    }
}

/// Builds a program from the two sources and runs `body` with it current, or fails the
/// case if it will not compile - the shared opening of every `uniform_value_*` case.
fn with_program(case: &mut ApiCase<'_>, vertex: &str, fragment: &str, body: impl FnOnce(&mut ApiCase<'_>, GLuint)) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vertex, fragment));
    if !program.is_ok() {
        case.fail("Failed to compile shader".to_string(), "Failed to compile shader");
        return;
    }

    // SAFETY: the program linked.
    unsafe { gl.use_program(program.program()) };
    case.expect_error(glw::GL_NO_ERROR);

    body(case, program.program());

    // SAFETY: unbinding before the program is dropped, as upstream does.
    unsafe { gl.use_program(0) };
    case.expect_error(glw::GL_NO_ERROR);
}

/// `UniformValueFloatCase`
fn uniform_value_float(case: &mut ApiCase<'_>) {
    let test_vert_source = "#version 300 es\n\
                            uniform highp float floatUniform;\n\
                            uniform highp vec2 float2Uniform;\n\
                            uniform highp vec3 float3Uniform;\n\
                            uniform highp vec4 float4Uniform;\n\
                            void main (void)\n\
                            {\n\
                            \tgl_Position = vec4(floatUniform + float2Uniform.x + float3Uniform.x + float4Uniform.x);\n\
                            }\n";

    with_program(case, test_vert_source, COMMON_TEST_FRAG_SOURCE, |case, program| {
        let gl = case.gl();

        let location = uniform_location(case, program, "floatUniform");
        // SAFETY: the location matches the uniform's type at every call below.
        unsafe { gl.uniform_1f(location, 1.0) };
        verify_uniform_value_f(case, program, location, [1.0]);

        let location = uniform_location(case, program, "float2Uniform");
        // SAFETY: as above.
        unsafe { gl.uniform_2f(location, 1.0, 2.0) };
        verify_uniform_value_f(case, program, location, [1.0, 2.0]);

        let location = uniform_location(case, program, "float3Uniform");
        // SAFETY: as above.
        unsafe { gl.uniform_3f(location, 1.0, 2.0, 3.0) };
        verify_uniform_value_f(case, program, location, [1.0, 2.0, 3.0]);

        let location = uniform_location(case, program, "float4Uniform");
        // SAFETY: as above.
        unsafe { gl.uniform_4f(location, 1.0, 2.0, 3.0, 4.0) };
        verify_uniform_value_f(case, program, location, [1.0, 2.0, 3.0, 4.0]);
    });
}

/// `UniformValueIntCase`
fn uniform_value_int(case: &mut ApiCase<'_>) {
    let test_vert_source = "#version 300 es\n\
                            uniform highp int intUniform;\n\
                            uniform highp ivec2 int2Uniform;\n\
                            uniform highp ivec3 int3Uniform;\n\
                            uniform highp ivec4 int4Uniform;\n\
                            void main (void)\n\
                            {\n\
                            \tgl_Position = vec4(float(intUniform + int2Uniform.x + int3Uniform.x + int4Uniform.x));\n\
                            }\n";

    with_program(case, test_vert_source, COMMON_TEST_FRAG_SOURCE, |case, program| {
        let gl = case.gl();

        let location = uniform_location(case, program, "intUniform");
        // SAFETY: the location matches the uniform's type at every call below.
        unsafe { gl.uniform_1i(location, 1) };
        verify_uniform_value_i(case, program, location, [1]);

        let location = uniform_location(case, program, "int2Uniform");
        // SAFETY: as above.
        unsafe { gl.uniform_2i(location, 1, 2) };
        verify_uniform_value_i(case, program, location, [1, 2]);

        let location = uniform_location(case, program, "int3Uniform");
        // SAFETY: as above.
        unsafe { gl.uniform_3i(location, 1, 2, 3) };
        verify_uniform_value_i(case, program, location, [1, 2, 3]);

        let location = uniform_location(case, program, "int4Uniform");
        // SAFETY: as above.
        unsafe { gl.uniform_4i(location, 1, 2, 3, 4) };
        verify_uniform_value_i(case, program, location, [1, 2, 3, 4]);
    });
}

/// `UniformValueUintCase` - new in ES 3.0.
fn uniform_value_uint(case: &mut ApiCase<'_>) {
    let test_vert_source = "#version 300 es\n\
                            uniform highp uint uintUniform;\n\
                            uniform highp uvec2 uint2Uniform;\n\
                            uniform highp uvec3 uint3Uniform;\n\
                            uniform highp uvec4 uint4Uniform;\n\
                            void main (void)\n\
                            {\n\
                            \tgl_Position = vec4(float(uintUniform + uint2Uniform.x + uint3Uniform.x + uint4Uniform.x));\n\
                            }\n";

    with_program(case, test_vert_source, COMMON_TEST_FRAG_SOURCE, |case, program| {
        let gl = case.gl();

        let location = uniform_location(case, program, "uintUniform");
        // SAFETY: the location matches the uniform's type at every call below.
        unsafe { gl.uniform_1ui(location, 1) };
        verify_uniform_value_ui(case, program, location, [1]);

        let location = uniform_location(case, program, "uint2Uniform");
        // SAFETY: as above.
        unsafe { gl.uniform_2ui(location, 1, 2) };
        verify_uniform_value_ui(case, program, location, [1, 2]);

        let location = uniform_location(case, program, "uint3Uniform");
        // SAFETY: as above.
        unsafe { gl.uniform_3ui(location, 1, 2, 3) };
        verify_uniform_value_ui(case, program, location, [1, 2, 3]);

        let location = uniform_location(case, program, "uint4Uniform");
        // SAFETY: as above.
        unsafe { gl.uniform_4ui(location, 1, 2, 3, 4) };
        verify_uniform_value_ui(case, program, location, [1, 2, 3, 4]);
    });
}

/// `UniformValueBooleanCase` - a bool uniform reads back as exactly 0 or 1, whatever it
/// was set from, which is the whole point of the three passes.
fn uniform_value_boolean(case: &mut ApiCase<'_>) {
    let test_vert_source = "#version 300 es\n\
                            uniform bool boolUniform;\n\
                            uniform bvec2 bool2Uniform;\n\
                            uniform bvec3 bool3Uniform;\n\
                            uniform bvec4 bool4Uniform;\n\
                            void main (void)\n\
                            {\n\
                            \tgl_Position = vec4(float(boolUniform) + float(bool2Uniform.x) + float(bool3Uniform.x) + float(bool4Uniform.x));\n\
                            }\n";

    with_program(case, test_vert_source, COMMON_TEST_FRAG_SOURCE, |case, program| {
        let gl = case.gl();

        // int conversion
        let location = uniform_location(case, program, "boolUniform");
        // SAFETY: the location matches the uniform's component count at every call below.
        unsafe { gl.uniform_1i(location, 1) };
        verify_uniform_value_i(case, program, location, [1]);

        let location = uniform_location(case, program, "bool2Uniform");
        // SAFETY: as above.
        unsafe { gl.uniform_2i(location, 1, 2) };
        verify_uniform_value_i(case, program, location, [1, 1]);

        let location = uniform_location(case, program, "bool3Uniform");
        // SAFETY: as above.
        unsafe { gl.uniform_3i(location, 0, 1, 2) };
        verify_uniform_value_i(case, program, location, [0, 1, 1]);

        let location = uniform_location(case, program, "bool4Uniform");
        // SAFETY: as above.
        unsafe { gl.uniform_4i(location, 1, 0, 1, -1) };
        verify_uniform_value_i(case, program, location, [1, 0, 1, 1]);

        // uint conversion
        let location = uniform_location(case, program, "boolUniform");
        // SAFETY: as above.
        unsafe { gl.uniform_1ui(location, 1) };
        verify_uniform_value_i(case, program, location, [1]);

        let location = uniform_location(case, program, "bool2Uniform");
        // SAFETY: as above.
        unsafe { gl.uniform_2ui(location, 1, 2) };
        verify_uniform_value_i(case, program, location, [1, 1]);

        let location = uniform_location(case, program, "bool3Uniform");
        // SAFETY: as above.
        unsafe { gl.uniform_3ui(location, 0, 1, 2) };
        verify_uniform_value_i(case, program, location, [0, 1, 1]);

        let location = uniform_location(case, program, "bool4Uniform");
        // SAFETY: as above.
        unsafe { gl.uniform_4ui(location, 1, 0, 1, 3) };
        verify_uniform_value_i(case, program, location, [1, 0, 1, 1]);

        // float conversion
        let location = uniform_location(case, program, "boolUniform");
        // SAFETY: as above.
        unsafe { gl.uniform_1f(location, 1.0) };
        verify_uniform_value_i(case, program, location, [1]);

        let location = uniform_location(case, program, "bool2Uniform");
        // SAFETY: as above.
        unsafe { gl.uniform_2f(location, 1.0, 0.1) };
        verify_uniform_value_i(case, program, location, [1, 1]);

        let location = uniform_location(case, program, "bool3Uniform");
        // SAFETY: as above.
        unsafe { gl.uniform_3f(location, 0.0, 0.1, -0.1) };
        verify_uniform_value_i(case, program, location, [0, 1, 1]);

        let location = uniform_location(case, program, "bool4Uniform");
        // SAFETY: as above.
        unsafe { gl.uniform_4f(location, 1.0, 0.0, 0.1, -0.9) };
        verify_uniform_value_i(case, program, location, [1, 0, 1, 1]);
    });
}

/// `UniformValueSamplerCase`
fn uniform_value_sampler(case: &mut ApiCase<'_>) {
    let test_frag_source = "#version 300 es\n\
                            uniform highp sampler2D uniformSampler;\n\
                            layout(location = 0) out mediump vec4 fragColor;\n\
                            void main (void)\n\
                            {\n\
                            \tfragColor = vec4(texture(uniformSampler, vec2(0.0, 0.0)).x);\n\
                            }\n";

    with_program(case, COMMON_TEST_VERT_SOURCE, test_frag_source, |case, program| {
        let location = uniform_location(case, program, "uniformSampler");
        // SAFETY: a sampler uniform takes one integer texture unit.
        unsafe { case.gl().uniform_1i(location, 1) };
        verify_uniform_value_i(case, program, location, [1]);
    });
}

/// `UniformValueArrayCase` - each element of an array uniform has its own location, and
/// the value written through the array's own location has to show up at all of them.
fn uniform_value_array(case: &mut ApiCase<'_>) {
    #[rustfmt::skip]
    const UNIFORM_VALUE: [GLfloat; 5 * 4] = [
        -1.0, 0.1, 4.0, 800.0, 13.0, 55.0, 12.0, 91.0, -55.1, 1.1,
        98.0, 19.0, 41.0, 65.0, 4.0, 12.2, 95.0, 77.0, 32.0, 48.0,
    ];

    let test_vert_source = "#version 300 es\n\
                            uniform highp float arrayUniform[5];\n\
                            uniform highp vec2 array2Uniform[5];\n\
                            uniform highp vec3 array3Uniform[5];\n\
                            uniform highp vec4 array4Uniform[5];\n\
                            void main (void)\n\
                            {\n\
                            \tgl_Position = \n\
                            \t\t+ vec4(arrayUniform[0] + arrayUniform[1] + arrayUniform[2] + arrayUniform[3] + arrayUniform[4])\n\
                            \t\t+ vec4(array2Uniform[0].x + array2Uniform[1].x + array2Uniform[2].x + array2Uniform[3].x + array2Uniform[4].x)\n\
                            \t\t+ vec4(array3Uniform[0].x + array3Uniform[1].x + array3Uniform[2].x + array3Uniform[3].x + array3Uniform[4].x)\n\
                            \t\t+ vec4(array4Uniform[0].x + array4Uniform[1].x + array4Uniform[2].x + array4Uniform[3].x + array4Uniform[4].x);\n\
                            }\n";

    with_program(case, test_vert_source, COMMON_TEST_FRAG_SOURCE, |case, program| {
        let gl = case.gl();

        let location = uniform_location(case, program, "arrayUniform");
        // SAFETY: five floats from a 20-float array.
        unsafe { gl.uniform_1fv(location, 5, UNIFORM_VALUE.as_ptr()) };
        case.expect_error(glw::GL_NO_ERROR);

        for (element, value) in UNIFORM_VALUE.iter().take(5).enumerate() {
            let location = uniform_location(case, program, &format!("arrayUniform[{element}]"));
            verify_uniform_value_f(case, program, location, [*value]);
        }
        case.expect_error(glw::GL_NO_ERROR);

        let location = uniform_location(case, program, "array2Uniform");
        // SAFETY: five vec2s, i.e. ten floats from the same array.
        unsafe { gl.uniform_2fv(location, 5, UNIFORM_VALUE.as_ptr()) };
        case.expect_error(glw::GL_NO_ERROR);

        for element in 0..5 {
            let location = uniform_location(case, program, &format!("array2Uniform[{element}]"));
            verify_uniform_value_f(
                case,
                program,
                location,
                [UNIFORM_VALUE[2 * element], UNIFORM_VALUE[2 * element + 1]],
            );
        }
        case.expect_error(glw::GL_NO_ERROR);

        let location = uniform_location(case, program, "array3Uniform");
        // SAFETY: five vec3s, i.e. fifteen floats.
        unsafe { gl.uniform_3fv(location, 5, UNIFORM_VALUE.as_ptr()) };
        case.expect_error(glw::GL_NO_ERROR);

        for element in 0..5 {
            let location = uniform_location(case, program, &format!("array3Uniform[{element}]"));
            verify_uniform_value_f(
                case,
                program,
                location,
                [
                    UNIFORM_VALUE[3 * element],
                    UNIFORM_VALUE[3 * element + 1],
                    UNIFORM_VALUE[3 * element + 2],
                ],
            );
        }
        case.expect_error(glw::GL_NO_ERROR);

        let location = uniform_location(case, program, "array4Uniform");
        // SAFETY: five vec4s, i.e. the whole array.
        unsafe { gl.uniform_4fv(location, 5, UNIFORM_VALUE.as_ptr()) };
        case.expect_error(glw::GL_NO_ERROR);

        for element in 0..5 {
            let location = uniform_location(case, program, &format!("array4Uniform[{element}]"));
            verify_uniform_value_f(
                case,
                program,
                location,
                [
                    UNIFORM_VALUE[4 * element],
                    UNIFORM_VALUE[4 * element + 1],
                    UNIFORM_VALUE[4 * element + 2],
                    UNIFORM_VALUE[4 * element + 3],
                ],
            );
        }
        case.expect_error(glw::GL_NO_ERROR);
    });
}

/// `UniformValueMatrixCase`
fn uniform_value_matrix(case: &mut ApiCase<'_>) {
    #[rustfmt::skip]
    const MATRIX_VALUES: [GLfloat; 4 * 4] = [
        -1.0, 0.1, 4.0, 800.0,
        13.0, 55.0, 12.0, 91.0,
        -55.1, 1.1, 98.0, 19.0,
        41.0, 65.0, 4.0, 12.2,
    ];

    let test_vert_source = "#version 300 es\n\
                            uniform highp mat2 mat2Uniform;\n\
                            uniform highp mat3 mat3Uniform;\n\
                            uniform highp mat4 mat4Uniform;\n\
                            void main (void)\n\
                            {\n\
                            \tgl_Position = vec4(mat2Uniform[0][0] + mat3Uniform[0][0] + mat4Uniform[0][0]);\n\
                            }\n";

    with_program(case, test_vert_source, COMMON_TEST_FRAG_SOURCE, |case, program| {
        let gl = case.gl();

        // The values of the matrix are returned in column major order but they can be
        // given in either order.
        let location = uniform_location(case, program, "mat2Uniform");
        // SAFETY: one mat2, i.e. four floats from a 16-float array.
        unsafe { gl.uniform_matrix_2fv(location, 1, glw::FALSE, MATRIX_VALUES.as_ptr()) };
        verify_uniform_matrix_values::<2, 4>(case, program, location, &MATRIX_VALUES, false);

        let location = uniform_location(case, program, "mat3Uniform");
        // SAFETY: one mat3, i.e. nine floats.
        unsafe { gl.uniform_matrix_3fv(location, 1, glw::FALSE, MATRIX_VALUES.as_ptr()) };
        verify_uniform_matrix_values::<3, 9>(case, program, location, &MATRIX_VALUES, false);

        let location = uniform_location(case, program, "mat4Uniform");
        // SAFETY: one mat4, i.e. the whole array.
        unsafe { gl.uniform_matrix_4fv(location, 1, glw::FALSE, MATRIX_VALUES.as_ptr()) };
        verify_uniform_matrix_values::<4, 16>(case, program, location, &MATRIX_VALUES, false);
    });
}

/// `PrecisionFormatCase::RequiredFormat` - the range and precision the specification
/// requires of each precision qualifier.
#[derive(Clone, Copy)]
struct RequiredFormat {
    negative_range: GLint,
    positive_range: GLint,
    precision: GLint,
}

/// `PrecisionFormatCase::getRequiredFormat`
fn required_format(precision_type: GLenum) -> RequiredFormat {
    const REQUIREMENTS: [RequiredFormat; 6] = [
        RequiredFormat {
            negative_range: 0,
            positive_range: 0,
            precision: 8,
        }, // lowp float
        RequiredFormat {
            negative_range: 13,
            positive_range: 13,
            precision: 10,
        }, // mediump float
        RequiredFormat {
            negative_range: 61,
            positive_range: 61,
            precision: 16,
        }, // highp float
        RequiredFormat {
            negative_range: 7,
            positive_range: 7,
            precision: 0,
        }, // lowp int
        RequiredFormat {
            negative_range: 9,
            positive_range: 9,
            precision: 0,
        }, // mediump int
        RequiredFormat {
            negative_range: 15,
            positive_range: 15,
            precision: 0,
        }, // highp int
    ];

    let ndx = (precision_type - glw::GL_LOW_FLOAT) as usize;
    debug_assert!(ndx < REQUIREMENTS.len());
    REQUIREMENTS[ndx]
}

/// `PrecisionFormatCase`
fn precision_format(case: &mut ApiCase<'_>, shader_type: GLenum, precision_type: GLenum) {
    let expected = required_format(precision_type);
    let mut error = false;

    let gl = case.gl();
    let mut shader_compiler = Guarded::<glw::GLboolean>::new();
    let mut range = Guarded::<[GLint; 2]>::new();
    let mut precision = Guarded::<GLint>::new();

    // requires SHADER_COMPILER = true
    // SAFETY: one GLboolean out.
    unsafe { gl.get_booleanv(glw::GL_SHADER_COMPILER, shader_compiler.as_mut_ptr()) };
    case.expect_error(glw::GL_NO_ERROR);

    if !shader_compiler.verify_validity(case) {
        return;
    }
    if shader_compiler.value() != glw::TRUE {
        case.not_supported("SHADER_COMPILER = TRUE required");
        return;
    }

    // query values
    // SAFETY: `range` is two GLints and `precision` one, both guarded on both sides.
    unsafe {
        gl.get_shader_precision_format(
            shader_type,
            precision_type,
            range.as_mut_ptr().cast::<GLint>(),
            precision.as_mut_ptr(),
        );
    }
    case.expect_error(glw::GL_NO_ERROR);

    if !range.verify_validity(case) || !precision.verify_validity(case) {
        return;
    }

    let range = range.value();
    let precision = precision.value();
    log::debug!(
        "range[0] = {}\nrange[1] = {}\nprecision = {precision}",
        range[0],
        range[1]
    );

    // ES 3.0 requires highp in the fragment shader, so unlike ES 2.0 there is no
    // "not supported" escape hatch here.
    if range[0] < expected.negative_range {
        log::warn!(
            "// ERROR: Invalid range[0], expected greater or equal to {}",
            expected.negative_range
        );
        error = true;
    }
    if range[1] < expected.positive_range {
        log::warn!(
            "// ERROR: Invalid range[1], expected greater or equal to {}",
            expected.positive_range
        );
        error = true;
    }
    if precision < expected.precision {
        log::warn!(
            "// ERROR: Invalid precision, expected greater or equal to {}",
            expected.precision
        );
        error = true;
    }

    if error {
        case.fail(
            "range or precision below the required minimum".to_string(),
            "Got invalid precision/range",
        );
    }
}

/// `verifyActiveUniformParam`
fn verify_active_uniform_param(
    case: &mut ApiCase<'_>,
    program: GLuint,
    index: GLuint,
    pname: GLenum,
    reference: GLint,
) {
    let mut state = Guarded::<GLint>::new();
    // SAFETY: one index in, one GLint out, guarded on both sides.
    unsafe {
        case.gl()
            .get_active_uniformsiv(program, 1, &raw const index, pname, state.as_mut_ptr())
    };
    case.expect_error(glw::GL_NO_ERROR);
    if state.verify_validity(case) {
        check_int_equals(case, state.value(), reference);
    }
}

/// One row of `ProgramUniformCase`'s `uniformTypes` table.
struct UniformTypeInfo {
    declaration: &'static str,
    post_declaration: &'static str,
    precision: &'static str,
    layout: &'static str,
    getter: &'static str,
    gl_type: GLenum,
    size: GLint,
    is_row_major: GLint,
}

/// `ProgramUniformCase`
fn program_active_uniform_types(case: &mut ApiCase<'_>) {
    const F: GLint = 0;
    let uniform_types: &[UniformTypeInfo] = &[
        UniformTypeInfo {
            declaration: "float",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "uniformValue",
            gl_type: glw::GL_FLOAT,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "float[2]",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "uniformValue[1]",
            gl_type: glw::GL_FLOAT,
            size: 2,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "vec2",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "uniformValue.x",
            gl_type: glw::GL_FLOAT_VEC2,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "vec3",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "uniformValue.x",
            gl_type: glw::GL_FLOAT_VEC3,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "vec4",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "uniformValue.x",
            gl_type: glw::GL_FLOAT_VEC4,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "int",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(uniformValue)",
            gl_type: glw::GL_INT,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "ivec2",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(uniformValue.x)",
            gl_type: glw::GL_INT_VEC2,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "ivec3",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(uniformValue.x)",
            gl_type: glw::GL_INT_VEC3,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "ivec4",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(uniformValue.x)",
            gl_type: glw::GL_INT_VEC4,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "uint",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(uniformValue)",
            gl_type: glw::GL_UNSIGNED_INT,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "uvec2",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(uniformValue.x)",
            gl_type: glw::GL_UNSIGNED_INT_VEC2,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "uvec3",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(uniformValue.x)",
            gl_type: glw::GL_UNSIGNED_INT_VEC3,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "uvec4",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(uniformValue.x)",
            gl_type: glw::GL_UNSIGNED_INT_VEC4,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "bool",
            post_declaration: "",
            precision: "",
            layout: "",
            getter: "float(uniformValue)",
            gl_type: glw::GL_BOOL,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "bvec2",
            post_declaration: "",
            precision: "",
            layout: "",
            getter: "float(uniformValue.x)",
            gl_type: glw::GL_BOOL_VEC2,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "bvec3",
            post_declaration: "",
            precision: "",
            layout: "",
            getter: "float(uniformValue.x)",
            gl_type: glw::GL_BOOL_VEC3,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "bvec4",
            post_declaration: "",
            precision: "",
            layout: "",
            getter: "float(uniformValue.x)",
            gl_type: glw::GL_BOOL_VEC4,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "mat2",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(uniformValue[0][0])",
            gl_type: glw::GL_FLOAT_MAT2,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "mat3",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(uniformValue[0][0])",
            gl_type: glw::GL_FLOAT_MAT3,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "mat4",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(uniformValue[0][0])",
            gl_type: glw::GL_FLOAT_MAT4,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "mat2x3",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(uniformValue[0][0])",
            gl_type: glw::GL_FLOAT_MAT2x3,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "mat2x4",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(uniformValue[0][0])",
            gl_type: glw::GL_FLOAT_MAT2x4,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "mat3x2",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(uniformValue[0][0])",
            gl_type: glw::GL_FLOAT_MAT3x2,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "mat3x4",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(uniformValue[0][0])",
            gl_type: glw::GL_FLOAT_MAT3x4,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "mat4x2",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(uniformValue[0][0])",
            gl_type: glw::GL_FLOAT_MAT4x2,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "mat4x3",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(uniformValue[0][0])",
            gl_type: glw::GL_FLOAT_MAT4x3,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "sampler2D",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(textureSize(uniformValue,0).r)",
            gl_type: glw::GL_SAMPLER_2D,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "sampler3D",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(textureSize(uniformValue,0).r)",
            gl_type: glw::GL_SAMPLER_3D,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "samplerCube",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(textureSize(uniformValue,0).r)",
            gl_type: glw::GL_SAMPLER_CUBE,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "sampler2DShadow",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(textureSize(uniformValue,0).r)",
            gl_type: glw::GL_SAMPLER_2D_SHADOW,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "sampler2DArray",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(textureSize(uniformValue,0).r)",
            gl_type: glw::GL_SAMPLER_2D_ARRAY,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "sampler2DArrayShadow",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(textureSize(uniformValue,0).r)",
            gl_type: glw::GL_SAMPLER_2D_ARRAY_SHADOW,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "samplerCubeShadow",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(textureSize(uniformValue,0).r)",
            gl_type: glw::GL_SAMPLER_CUBE_SHADOW,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "isampler2D",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(textureSize(uniformValue,0).r)",
            gl_type: glw::GL_INT_SAMPLER_2D,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "isampler3D",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(textureSize(uniformValue,0).r)",
            gl_type: glw::GL_INT_SAMPLER_3D,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "isamplerCube",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(textureSize(uniformValue,0).r)",
            gl_type: glw::GL_INT_SAMPLER_CUBE,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "isampler2DArray",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(textureSize(uniformValue,0).r)",
            gl_type: glw::GL_INT_SAMPLER_2D_ARRAY,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "usampler2D",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(textureSize(uniformValue,0).r)",
            gl_type: glw::GL_UNSIGNED_INT_SAMPLER_2D,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "usampler3D",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(textureSize(uniformValue,0).r)",
            gl_type: glw::GL_UNSIGNED_INT_SAMPLER_3D,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "usamplerCube",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(textureSize(uniformValue,0).r)",
            gl_type: glw::GL_UNSIGNED_INT_SAMPLER_CUBE,
            size: 1,
            is_row_major: F,
        },
        UniformTypeInfo {
            declaration: "usampler2DArray",
            post_declaration: "",
            precision: "highp",
            layout: "",
            getter: "float(textureSize(uniformValue,0).r)",
            gl_type: glw::GL_UNSIGNED_INT_SAMPLER_2D_ARRAY,
            size: 1,
            is_row_major: F,
        },
    ];

    const VERT_SOURCE: &str = "#version 300 es\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n}\n";

    let gl = case.gl();
    // SAFETY: three fresh names, all deleted below.
    let (shader_vert, shader_frag, program) = unsafe {
        (
            gl.create_shader(glw::GL_VERTEX_SHADER),
            gl.create_shader(glw::GL_FRAGMENT_SHADER),
            gl.create_program(),
        )
    };

    // SAFETY: both shaders are live.
    unsafe {
        gl.attach_shader(program, shader_vert);
        gl.attach_shader(program, shader_frag);
    }

    shader_source(case, shader_vert, &[VERT_SOURCE]);
    // SAFETY: the vertex shader has source attached.
    unsafe { gl.compile_shader(shader_vert) };
    case.expect_error(glw::GL_NO_ERROR);

    for info in uniform_types {
        case.section(&format!(
            "Verify type of {} variable{}",
            info.declaration, info.post_declaration
        ));

        let fragment_source = format!(
            "#version 300 es\n{}uniform {} {} uniformValue{};\nlayout(location = 0) out mediump vec4 fragColor;\nvoid main (void)\n{{\n    fragColor = vec4({});\n}}\n",
            info.layout, info.precision, info.declaration, info.post_declaration, info.getter
        );
        shader_source(case, shader_frag, &[&fragment_source]);

        // SAFETY: the fragment shader has source attached; both are attached to the program.
        unsafe {
            gl.compile_shader(shader_frag);
            gl.link_program(program);
        }

        if verify_program_param(case, program, glw::GL_LINK_STATUS, GLint::from(glw::TRUE)) {
            let name = CString::new("uniformValue").expect("no interior nul");
            let pointer: *const glw::GLchar = name.as_ptr();
            let mut uniform_index = Guarded::<GLuint>::new();
            // SAFETY: one live null-terminated name, one GLuint out, guarded on both sides.
            unsafe { gl.get_uniform_indices(program, 1, &raw const pointer, uniform_index.as_mut_ptr()) };
            if !uniform_index.verify_validity(case) {
                continue;
            }

            let index = uniform_index.value();
            #[expect(clippy::cast_possible_wrap, reason = "a GL type enum always fits in a GLint")]
            let expected_type = info.gl_type as GLint;
            verify_active_uniform_param(case, program, index, glw::GL_UNIFORM_TYPE, expected_type);
            verify_active_uniform_param(case, program, index, glw::GL_UNIFORM_SIZE, info.size);
            verify_active_uniform_param(case, program, index, glw::GL_UNIFORM_IS_ROW_MAJOR, info.is_row_major);
        }
    }

    // SAFETY: names this case owns, deleted once.
    unsafe {
        gl.delete_shader(shader_vert);
        gl.delete_shader(shader_frag);
        gl.delete_program(program);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `verifyActiveUniformBlockParam`
fn verify_active_uniform_block_param(
    case: &mut ApiCase<'_>,
    program: GLuint,
    block: GLuint,
    pname: GLenum,
    reference: GLint,
) {
    let mut state = Guarded::<GLint>::new();
    // SAFETY: one GLint out, guarded on both sides.
    unsafe {
        case.gl()
            .get_active_uniform_blockiv(program, block, pname, state.as_mut_ptr())
    };
    case.expect_error(glw::GL_NO_ERROR);
    if state.verify_validity(case) {
        check_int_equals(case, state.value(), reference);
    }
}

/// `ProgramActiveUniformBlocksCase`
fn program_active_uniform_blocks(case: &mut ApiCase<'_>) {
    const TEST_VERT_SOURCE: &str = "#version 300 es\nuniform longlongUniformBlockName {highp vec2 vector2;} longlongUniformInstanceName;\nuniform shortUniformBlockName {highp vec2 vector2;highp vec4 vector4;} shortUniformInstanceName;\nvoid main (void)\n{\n    gl_Position = shortUniformInstanceName.vector4 + vec4(longlongUniformInstanceName.vector2.x) + vec4(shortUniformInstanceName.vector2.x);\n}\n";
    const TEST_FRAG_SOURCE: &str = "#version 300 es\nuniform longlongUniformBlockName {highp vec2 vector2;} longlongUniformInstanceName;\nlayout(location = 0) out mediump vec4 fragColor;void main (void)\n{\n    fragColor = vec4(longlongUniformInstanceName.vector2.y);\n}\n";

    const LONG_BLOCK: &str = "longlongUniformBlockName";
    const SHORT_BLOCK: &str = "shortUniformBlockName";

    let (shader_vert, shader_frag) = create_compiled_pair(case, TEST_VERT_SOURCE, TEST_FRAG_SOURCE);
    let gl = case.gl();

    // SAFETY: a fresh program name; both shaders are live.
    let program = unsafe { gl.create_program() };
    // SAFETY: as above.
    unsafe {
        gl.attach_shader(program, shader_vert);
        gl.attach_shader(program, shader_frag);
        gl.link_program(program);
    }
    case.expect_error(glw::GL_NO_ERROR);

    verify_shader_param(case, shader_vert, glw::GL_COMPILE_STATUS, GLint::from(glw::TRUE));
    verify_shader_param(case, shader_frag, glw::GL_COMPILE_STATUS, GLint::from(glw::TRUE));
    verify_program_param(case, program, glw::GL_LINK_STATUS, GLint::from(glw::TRUE));

    verify_program_param(case, program, glw::GL_ACTIVE_UNIFORM_BLOCKS, 2);
    // Including the null terminator.
    verify_program_param(
        case,
        program,
        glw::GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH,
        LONG_BLOCK.len() as GLint + 1,
    );
    case.expect_error(glw::GL_NO_ERROR);

    let long_name = CString::new(LONG_BLOCK).expect("no interior nul");
    let short_name = CString::new(SHORT_BLOCK).expect("no interior nul");
    // SAFETY: both names are live null-terminated strings.
    let (long_block_index, short_block_index) = unsafe {
        (
            gl.get_uniform_block_index(program, long_name.as_ptr()),
            gl.get_uniform_block_index(program, short_name.as_ptr()),
        )
    };

    let uniform_names = [
        "longlongUniformBlockName.vector2",
        "shortUniformBlockName.vector2",
        "shortUniformBlockName.vector4",
    ];
    let owned: Vec<CString> = uniform_names
        .iter()
        .map(|name| CString::new(*name).expect("no interior nul"))
        .collect();
    let pointers: Vec<*const glw::GLchar> = owned.iter().map(|name| name.as_ptr()).collect();

    let mut uniform_indices = Guarded::<[GLuint; 3]>::new();
    let mut uniforms_block_indices = Guarded::<[GLint; 3]>::new();

    // SAFETY: `count` matches both the name array and the output array; guarded.
    unsafe {
        gl.get_uniform_indices(
            program,
            3,
            pointers.as_ptr(),
            uniform_indices.as_mut_ptr().cast::<GLuint>(),
        )
    };
    let indices_ok = uniform_indices.verify_validity(case);
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
    unsafe {
        gl.get_active_uniformsiv(
            program,
            3,
            uniform_indices.value().as_ptr(),
            glw::GL_UNIFORM_BLOCK_INDEX,
            uniforms_block_indices.as_mut_ptr().cast::<GLint>(),
        )
    };
    if uniforms_block_indices.verify_validity(case) {
        case.expect_error(glw::GL_NO_ERROR);
        let got = uniforms_block_indices.value();
        #[expect(clippy::cast_possible_wrap, reason = "a GL block index always fits in a GLint")]
        let long_i = long_block_index as GLint;
        #[expect(clippy::cast_possible_wrap, reason = "a GL block index always fits in a GLint")]
        let short_i = short_block_index as GLint;
        if got[0] != long_i || got[1] != short_i || got[2] != short_i {
            case.fail(
                format!("Expected [{long_i}, {short_i}, {short_i}]; got {got:?}"),
                "got wrong uniform block index",
            );
        }
    }

    // Including the null terminator.
    verify_active_uniform_block_param(
        case,
        program,
        long_block_index,
        glw::GL_UNIFORM_BLOCK_NAME_LENGTH,
        LONG_BLOCK.len() as GLint + 1,
    );
    verify_active_uniform_block_param(
        case,
        program,
        short_block_index,
        glw::GL_UNIFORM_BLOCK_NAME_LENGTH,
        SHORT_BLOCK.len() as GLint + 1,
    );
    case.expect_error(glw::GL_NO_ERROR);

    verify_active_uniform_block_param(
        case,
        program,
        long_block_index,
        glw::GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER,
        GLint::from(glw::TRUE),
    );
    verify_active_uniform_block_param(
        case,
        program,
        long_block_index,
        glw::GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER,
        GLint::from(glw::TRUE),
    );
    verify_active_uniform_block_param(
        case,
        program,
        short_block_index,
        glw::GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER,
        GLint::from(glw::TRUE),
    );
    verify_active_uniform_block_param(
        case,
        program,
        short_block_index,
        glw::GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER,
        GLint::from(glw::FALSE),
    );
    case.expect_error(glw::GL_NO_ERROR);

    verify_active_uniform_block_param(
        case,
        program,
        long_block_index,
        glw::GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS,
        1,
    );
    verify_active_uniform_block_param(
        case,
        program,
        short_block_index,
        glw::GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS,
        2,
    );
    case.expect_error(glw::GL_NO_ERROR);

    {
        let mut block_uniforms = Guarded::<GLint>::new();
        // SAFETY: one GLint out, guarded on both sides.
        unsafe {
            gl.get_active_uniform_blockiv(
                program,
                long_block_index,
                glw::GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS,
                block_uniforms.as_mut_ptr(),
            )
        };
        block_uniforms.verify_validity(case);

        // Upstream reads two indices only when the block reports two active uniforms,
        // which this block never does (it has one) - kept verbatim.
        if block_uniforms.value() == 2 && indices_ok {
            let mut block_uniform_indices = Guarded::<[GLint; 2]>::new();
            // SAFETY: two GLints out, guarded on both sides.
            unsafe {
                gl.get_active_uniform_blockiv(
                    program,
                    long_block_index,
                    glw::GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES,
                    block_uniform_indices.as_mut_ptr().cast::<GLint>(),
                )
            };
            if block_uniform_indices.verify_validity(case) {
                let got = block_uniform_indices.value();
                let expected = uniform_indices.value();
                #[expect(clippy::cast_sign_loss, reason = "a returned uniform index is never negative")]
                let (g0, g1) = (got[0] as GLuint, got[1] as GLuint);
                if (g0 != expected[0] || g1 != expected[1]) && (g1 != expected[0] || g0 != expected[1]) {
                    case.fail(
                        format!(
                            "Expected {{{}, {}}}; got {{{}, {}}}",
                            expected[0], expected[1], got[0], got[1]
                        ),
                        "got wrong uniform indices",
                    );
                }
            }
        }
    }

    {
        let mut buffer = new_char_buffer();
        let mut written: GLsizei = 0;
        // SAFETY: bufSize is the buffer's own length.
        unsafe {
            gl.get_active_uniform_block_name(
                program,
                long_block_index,
                buffer.len() as GLsizei,
                &raw mut written,
                buffer.as_mut_ptr().cast::<glw::GLchar>(),
            )
        };
        check_int_equals(case, written, LONG_BLOCK.len() as GLint);

        written = 0;
        // SAFETY: as above.
        unsafe {
            gl.get_active_uniform_block_name(
                program,
                short_block_index,
                buffer.len() as GLsizei,
                &raw mut written,
                buffer.as_mut_ptr().cast::<glw::GLchar>(),
            )
        };
        check_int_equals(case, written, SHORT_BLOCK.len() as GLint);

        // And one with too small a buffer.
        written = 0;
        // SAFETY: bufSize 1 is within the buffer.
        unsafe {
            gl.get_active_uniform_block_name(
                program,
                long_block_index,
                1,
                &raw mut written,
                buffer.as_mut_ptr().cast::<glw::GLchar>(),
            )
        };
        check_int_equals(case, written, 0);
    }

    case.expect_error(glw::GL_NO_ERROR);
    // SAFETY: names this case owns, deleted once.
    unsafe {
        gl.delete_shader(shader_vert);
        gl.delete_shader(shader_frag);
        gl.delete_program(program);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `ProgramBinaryCase`
fn program_binary(case: &mut ApiCase<'_>) {
    let (shader_vert, shader_frag) = create_compiled_pair(case, COMMON_TEST_VERT_SOURCE, COMMON_TEST_FRAG_SOURCE);
    let gl = case.gl();

    // SAFETY: a fresh program name; both shaders are live.
    let program = unsafe { gl.create_program() };
    // SAFETY: as above.
    unsafe {
        gl.attach_shader(program, shader_vert);
        gl.attach_shader(program, shader_frag);
        gl.link_program(program);
    }
    case.expect_error(glw::GL_NO_ERROR);

    verify_program_param(
        case,
        program,
        glw::GL_PROGRAM_BINARY_RETRIEVABLE_HINT,
        GLint::from(glw::FALSE),
    );

    // SAFETY: a legal hint on a program this case owns.
    unsafe { gl.program_parameteri(program, glw::GL_PROGRAM_BINARY_RETRIEVABLE_HINT, GLint::from(glw::TRUE)) };
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above.
    unsafe { gl.link_program(program) };
    case.expect_error(glw::GL_NO_ERROR);

    verify_program_param(
        case,
        program,
        glw::GL_PROGRAM_BINARY_RETRIEVABLE_HINT,
        GLint::from(glw::TRUE),
    );

    // PROGRAM_BINARY_LENGTH only has to be written to - its value is driver-specific.
    let mut program_length = Guarded::<GLint>::new();
    // SAFETY: one GLint out, guarded on both sides.
    unsafe { gl.get_programiv(program, glw::GL_PROGRAM_BINARY_LENGTH, program_length.as_mut_ptr()) };
    case.expect_error(glw::GL_NO_ERROR);
    program_length.verify_validity(case);

    // SAFETY: names this case owns, deleted once.
    unsafe {
        gl.delete_shader(shader_vert);
        gl.delete_shader(shader_frag);
        gl.delete_program(program);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `TransformFeedbackCase`
fn transform_feedback(case: &mut ApiCase<'_>) {
    const TF_VERT_SOURCE: &str = "#version 300 es\nout highp vec4 tfOutput2withLongName;\nvoid main (void)\n{\n    gl_Position = vec4(0.0);\n    tfOutput2withLongName = vec4(0.0);\n}\n";
    const TF_FRAG_SOURCE: &str = "#version 300 es\nlayout(location = 0) out highp vec4 fragColor;\nvoid main (void)\n{\n    fragColor = vec4(0.0);\n}\n";

    let gl = case.gl();
    // SAFETY: three fresh names, all deleted below.
    let (shader_vert, shader_frag, shader_prog) = unsafe {
        (
            gl.create_shader(glw::GL_VERTEX_SHADER),
            gl.create_shader(glw::GL_FRAGMENT_SHADER),
            gl.create_program(),
        )
    };

    verify_program_param(
        case,
        shader_prog,
        glw::GL_TRANSFORM_FEEDBACK_BUFFER_MODE,
        glw::GL_INTERLEAVED_ATTRIBS as GLint,
    );

    shader_source(case, shader_vert, &[TF_VERT_SOURCE]);
    shader_source(case, shader_frag, &[TF_FRAG_SOURCE]);

    // SAFETY: both shaders have source attached.
    unsafe {
        gl.compile_shader(shader_vert);
        gl.compile_shader(shader_frag);
    }

    verify_shader_param(case, shader_vert, glw::GL_COMPILE_STATUS, GLint::from(glw::TRUE));
    verify_shader_param(case, shader_frag, glw::GL_COMPILE_STATUS, GLint::from(glw::TRUE));

    // SAFETY: both shaders are live.
    unsafe {
        gl.attach_shader(shader_prog, shader_vert);
        gl.attach_shader(shader_prog, shader_frag);
    }

    const LONGEST_OUTPUT: &str = "tfOutput2withLongName";
    let outputs = ["gl_Position", LONGEST_OUTPUT];

    for buffer_mode in [glw::GL_SEPARATE_ATTRIBS, glw::GL_INTERLEAVED_ATTRIBS] {
        let owned: Vec<CString> = outputs
            .iter()
            .map(|name| CString::new(*name).expect("no interior nul"))
            .collect();
        let pointers: Vec<*const glw::GLchar> = owned.iter().map(|name| name.as_ptr()).collect();
        // SAFETY: `count` matches the array and every pointer is live for the call.
        unsafe {
            gl.transform_feedback_varyings(shader_prog, pointers.len() as GLsizei, pointers.as_ptr(), buffer_mode);
            gl.link_program(shader_prog);
        }
        case.expect_error(glw::GL_NO_ERROR);

        verify_program_param(case, shader_prog, glw::GL_LINK_STATUS, GLint::from(glw::TRUE));
        verify_program_param(
            case,
            shader_prog,
            glw::GL_TRANSFORM_FEEDBACK_BUFFER_MODE,
            buffer_mode as GLint,
        );
    }

    verify_program_param(case, shader_prog, glw::GL_TRANSFORM_FEEDBACK_VARYINGS, 2);

    {
        let mut max_output_len = Guarded::<GLint>::new();
        // SAFETY: one GLint out, guarded on both sides.
        unsafe {
            gl.get_programiv(
                shader_prog,
                glw::GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH,
                max_output_len.as_mut_ptr(),
            )
        };
        if max_output_len.verify_validity(case) {
            // Does include the null terminator.
            let reference_length = LONGEST_OUTPUT.len() as GLint + 1;
            check_int_equals(case, max_output_len.value(), reference_length);
        }
    }

    {
        let mut varyings = Guarded::<GLint>::new();
        // SAFETY: one GLint out, guarded on both sides.
        unsafe { gl.get_programiv(shader_prog, glw::GL_TRANSFORM_FEEDBACK_VARYINGS, varyings.as_mut_ptr()) };
        if varyings.verify_validity(case) {
            for index in 0..varyings.value() {
                let mut buffer = new_char_buffer();
                let mut written: GLsizei = 0;
                let mut size: GLint = 0;
                let mut var_type: GLenum = 0;
                // SAFETY: bufSize is the buffer's own length; three scalars out.
                unsafe {
                    gl.get_transform_feedback_varying(
                        shader_prog,
                        index as GLuint,
                        buffer.len() as GLsizei,
                        &raw mut written,
                        &raw mut size,
                        &raw mut var_type,
                        buffer.as_mut_ptr().cast::<glw::GLchar>(),
                    )
                };

                if (written as usize) < buffer.len() && buffer[written as usize] != 0 {
                    case.fail("Expected null terminator".to_string(), "got invalid string terminator");
                }

                // Same query with a one-byte buffer must write nothing.
                written = 0;
                // SAFETY: bufSize 1 is within the buffer.
                unsafe {
                    gl.get_transform_feedback_varying(
                        shader_prog,
                        index as GLuint,
                        1,
                        &raw mut written,
                        &raw mut size,
                        &raw mut var_type,
                        buffer.as_mut_ptr().cast::<glw::GLchar>(),
                    )
                };
                if written != 0 {
                    case.fail(format!("Expected 0; got {written}"), "got invalid write length");
                }
            }
        }
    }

    // SAFETY: names this case owns, deleted once.
    unsafe {
        gl.delete_shader(shader_vert);
        gl.delete_shader(shader_frag);
        gl.delete_program(shader_prog);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `ActiveAttributesCase`
fn active_attributes(case: &mut ApiCase<'_>) {
    const TEST_VERT_SOURCE: &str = "#version 300 es\nin highp vec2 longInputAttributeName;\nin highp vec2 shortName;\nvoid main (void)\n{\n    gl_Position = longInputAttributeName.yxxy + shortName.xyxy;\n}\n";
    const TEST_FRAG_SOURCE: &str = "#version 300 es\nlayout(location = 0) out mediump vec4 fragColor;void main (void)\n{\n    fragColor = vec4(0.0);\n}\n";

    let (shader_vert, shader_frag) = create_compiled_pair(case, TEST_VERT_SOURCE, TEST_FRAG_SOURCE);
    let gl = case.gl();

    // SAFETY: a fresh program name; both shaders are live.
    let program = unsafe { gl.create_program() };
    // SAFETY: as above.
    unsafe {
        gl.attach_shader(program, shader_vert);
        gl.attach_shader(program, shader_frag);
        gl.link_program(program);
    }
    case.expect_error(glw::GL_NO_ERROR);

    verify_program_param(case, program, glw::GL_ACTIVE_ATTRIBUTES, 2);
    // Does include the null terminator.
    verify_program_param(
        case,
        program,
        glw::GL_ACTIVE_ATTRIBUTE_MAX_LENGTH,
        "longInputAttributeName".len() as GLint + 1,
    );

    for attribute_ndx in 0..2u32 {
        let mut buffer = new_char_buffer();
        let mut written: GLsizei = 0;
        let mut size: GLint = 0;
        let mut attr_type: GLenum = 0;
        // SAFETY: bufSize is the buffer's own length; three scalars out.
        unsafe {
            gl.get_active_attrib(
                program,
                attribute_ndx,
                buffer.len() as GLsizei,
                &raw mut written,
                &raw mut size,
                &raw mut attr_type,
                buffer.as_mut_ptr().cast::<glw::GLchar>(),
            )
        };
        case.expect_error(glw::GL_NO_ERROR);

        let name = String::from_utf8_lossy(&buffer[..buffer.iter().position(|b| *b == 0).unwrap_or(buffer.len())])
            .into_owned();
        // `written` does NOT include the null terminator.
        if name.starts_with("longInputAttributeName") {
            check_int_equals(case, written, "longInputAttributeName".len() as GLint);
        } else if name.starts_with("shortName") {
            check_int_equals(case, written, "shortName".len() as GLint);
        } else {
            case.fail(
                format!("Got unexpected attribute name: {name}"),
                "got invalid attribute name",
            );
        }
    }

    // SAFETY: names this case owns, deleted once.
    unsafe {
        gl.delete_shader(shader_vert);
        gl.delete_shader(shader_frag);
        gl.delete_program(program);
    }
    case.expect_error(glw::GL_NO_ERROR);
}

/// `ShaderStateQueryTests::init`, in upstream's order and under upstream's names.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader");

    let cases: &[(&'static str, ApiCaseFn)] = &[
        // shader
        ("shader_type", shader_type),
        ("shader_compile_status", shader_compile_status),
        ("shader_info_log_length", shader_info_log_length),
        ("shader_source_length", shader_source_length),
        // shader and program
        ("delete_status", delete_status),
        // vertex-attrib
        ("current_vertex_attrib_initial", current_vertex_attrib_initial),
        ("current_vertex_attrib_float", current_vertex_attrib_float),
        ("current_vertex_attrib_int", current_vertex_attrib_int),
        ("current_vertex_attrib_uint", current_vertex_attrib_uint),
        ("current_vertex_attrib_float_to_int", current_vertex_attrib_float_to_int),
        // program
        ("program_validate_status", program_validate_status),
        ("program_attached_shaders", program_attached_shaders),
        ("program_active_uniform_name", program_active_uniform_name),
        ("program_active_uniform_types", program_active_uniform_types),
        ("program_active_uniform_blocks", program_active_uniform_blocks),
        ("program_binary", program_binary),
        // transform feedback
        ("transform_feedback", transform_feedback),
        // attribute related
        ("active_attributes", active_attributes),
        // attribute related
        ("vertex_attrib_size", vertex_attrib_size),
        ("vertex_attrib_type", vertex_attrib_type),
        ("vertex_attrib_stride", vertex_attrib_stride),
        ("vertex_attrib_normalized", vertex_attrib_normalized),
        ("vertex_attrib_integer", vertex_attrib_integer),
        ("vertex_attrib_array_enabled", vertex_attrib_array_enabled),
        ("vertex_attrib_array_divisor", vertex_attrib_array_divisor),
        ("vertex_attrib_array_buffer_binding", vertex_attrib_array_buffer_binding),
        ("vertex_attrib_pointerv", vertex_attrib_pointerv),
        // uniform values
        ("uniform_value_float", uniform_value_float),
        ("uniform_value_int", uniform_value_int),
        ("uniform_value_uint", uniform_value_uint),
        ("uniform_value_boolean", uniform_value_boolean),
        ("uniform_value_sampler", uniform_value_sampler),
        ("uniform_value_array", uniform_value_array),
        ("uniform_value_matrix", uniform_value_matrix),
    ];
    add_api_cases(&mut group, cases);

    // The two program info log cases differ only in how the build is made to fail.
    add_api_case(&mut group, "program_info_log_length", |case| {
        program_info_log_length(case, false)
    });
    add_api_case(&mut group, "program_info_log_length_link_error", |case| {
        program_info_log_length(case, true)
    });

    // precision format query
    for (stage_name, shader_type) in [("vertex", glw::GL_VERTEX_SHADER), ("fragment", glw::GL_FRAGMENT_SHADER)] {
        for (precision_name, precision_type) in [
            ("lowp_float", glw::GL_LOW_FLOAT),
            ("mediump_float", glw::GL_MEDIUM_FLOAT),
            ("highp_float", glw::GL_HIGH_FLOAT),
            ("lowp_int", glw::GL_LOW_INT),
            ("mediump_int", glw::GL_MEDIUM_INT),
            ("highp_int", glw::GL_HIGH_INT),
        ] {
            add_api_case(
                &mut group,
                format!("precision_{stage_name}_{precision_name}"),
                move |case| {
                    precision_format(case, shader_type, precision_type);
                },
            );
        }
    }

    group
}
