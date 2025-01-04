// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fShaderStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The last and the largest of the `state_query` sub-groups, and the only one that
// compiles shaders. Two things in here are easy to get wrong when reading the C++:
//
//   - `char buffer[2048] = {'x'}` sets buffer[0] to 'x' and **the other 2047 bytes to
//     zero**, which is what makes the "did the driver write a terminator" checks work
//     at all - they only ever look at buffer[0], buffer[written] and buffer[2047].
//     `new_char_buffer` reproduces exactly that, deliberately.
//   - `INFO_LOG_LENGTH` and `SHADER_SOURCE_LENGTH` *include* the null terminator while
//     the `length` written by `glGetShaderInfoLog`/`glGetShaderSource` does *not*. Every
//     off-by-one in this file is upstream's, on purpose.

use std::ffi::{CString, c_void};

use crate::gls::state_query_util::Guarded;
use crate::glu::shader_program::{ProgramSources, ShaderProgram};
use crate::glu::{ApiCase, ApiCaseFn, TestCaseGroup, add_api_case, add_api_cases};
use crate::glw::{self, GLenum, GLfloat, GLint, GLsizei, GLuint};
use crate::tcu::Random;

const COMMON_TEST_VERT_SOURCE: &str = "void main (void)\n{\n\tgl_Position = vec4(0.0);\n}\n";
const COMMON_TEST_FRAG_SOURCE: &str = "void main (void)\n{\n\tgl_FragColor = vec4(0.0);\n}\n";
const BROKEN_SHADER: &str = "broken, this should not compile!\n\n";

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

/// `checkIntEquals` - returns whether the value matched, which the program-parameter
/// helper below needs in order to skip a check that cannot mean anything.
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

/// `verifyUniformValue{1,2,3,4}f` and `verifyUniformValues<Count>`, which differ only in
/// how many components they read.
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

/// `requireShaderCompiler` - upstream throws `tcu::NotSupportedError` here, which leaves
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

        // check lengths are consistent
        if log_length <= buffer_len as GLint && written != log_length - 1 {
            case.fail(
                format!("Expected length {}; got {written}", log_length - 1),
                "got invalid log length",
            );
        }

        // check null-terminator, either at end of buffer or at buffer[written]
        let terminator = if log_length < buffer_len as GLint {
            // Unlike the C++, which indexes with whatever the driver reported, a
            // nonsense `written` is reported rather than read out of bounds.
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

    // The program stays alive after glDeleteProgram because it is the current one, which
    // is exactly the state DELETE_STATUS exists to report.
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

/// The four `glVertexAttrib{1,2,3,4}f` passes both current-vertex-attrib cases make, in
/// the same order and with the same defaults for the components not written.
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

/// `ProgramInfoLogCase`
fn program_info_log_length(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let (shader_vert, shader_frag) = create_compiled_pair(case, BROKEN_SHADER, BROKEN_SHADER);

    // SAFETY: the program is deleted below; linking two broken shaders is the point.
    let program = unsafe {
        let program = gl.create_program();
        gl.attach_shader(program, shader_vert);
        gl.attach_shader(program, shader_frag);
        gl.link_program(program);
        program
    };

    // check INFO_LOG_LENGTH == GetProgramInfoLog len
    {
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

        let mut log_length = Guarded::<GLint>::new();
        // SAFETY: one GLint out.
        unsafe { gl.get_programiv(program, glw::GL_INFO_LOG_LENGTH, log_length.as_mut_ptr()) };
        log_length.verify_validity(case);

        // INFO_LOG_LENGTH contains the 0-terminator, the written length does not.
        if log_length.value() != 0 && written + 1 != log_length.value() {
            case.fail(
                format!("Expected INFO_LOG_LENGTH {}; got {}", written + 1, log_length.value()),
                "got invalid log length",
            );
        }
    }

    // check GetProgramInfoLog works with too small buffer
    {
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

    // check ATTACHED_SHADERS
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
        // shaders are the attached shaders?
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

    let test_vert_source = "uniform highp float uniformNameWithLength23;\n\
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
    // including a null terminator
    verify_program_param(
        case,
        program,
        glw::GL_ACTIVE_UNIFORM_MAX_LENGTH,
        UNIFORM_NAMES[0].len() as GLint + 1,
    );
    case.expect_error(glw::GL_NO_ERROR);

    // check names
    for ndx in 0..UNIFORM_NAMES.len() {
        let mut buffer = new_char_buffer();
        let buffer_len = buffer.len();

        let mut written: GLsizei = 0; // null terminator not included
        let mut size: GLint = 0;
        let mut type_: GLenum = 0;
        // SAFETY: the buffer is `buffer_len` bytes; the three out-parameters are scalars.
        unsafe {
            gl.get_active_uniform(
                program,
                ndx as GLuint,
                buffer_len as GLsizei,
                &raw mut written,
                &raw mut size,
                &raw mut type_,
                buffer.as_mut_ptr().cast::<glw::GLchar>(),
            );
        }

        // find matching uniform
        {
            let end = match usize::try_from(written) {
                Ok(end) if end < buffer_len => end,
                // Upstream's fallback for a driver that filled the whole buffer.
                _ => 1,
            };
            let uniform_name = String::from_utf8_lossy(&buffer[..end]).into_owned();

            if !UNIFORM_NAMES.contains(&uniform_name.as_str()) {
                case.fail(
                    format!("Got unknown uniform name: {uniform_name}"),
                    "got wrong uniform name",
                );
            }
        }

        // and with too small buffer
        written = 0;
        // SAFETY: a buffer size of 1 asks for the terminator only.
        unsafe {
            gl.get_active_uniform(
                program,
                ndx as GLuint,
                1,
                &raw mut written,
                &raw mut size,
                &raw mut type_,
                buffer.as_mut_ptr().cast::<glw::GLchar>(),
            );
        }

        if written != 0 {
            case.fail(format!("Expected 0 got {written}"), "got wrong uniform name length");
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

/// One row of `ProgramUniformCase`'s table: a uniform declaration and the
/// `UNIFORM_TYPE`/`UNIFORM_SIZE` the driver must report for it.
struct UniformType {
    declaration: &'static str,
    post_declaration: &'static str,
    precision: &'static str,
    getter: &'static str,
    type_: GLenum,
    size: GLint,
}

/// `ProgramUniformCase` - every uniform type ES 2.0 has, one relink each.
fn program_active_uniform_types(case: &mut ApiCase<'_>) {
    const UNIFORM_TYPES: &[UniformType] = &[
        UniformType {
            declaration: "float",
            post_declaration: "",
            precision: "highp",
            getter: "uniformValue",
            type_: glw::GL_FLOAT,
            size: 1,
        },
        UniformType {
            declaration: "float",
            post_declaration: "[2]",
            precision: "highp",
            getter: "uniformValue[1]",
            type_: glw::GL_FLOAT,
            size: 2,
        },
        UniformType {
            declaration: "vec2",
            post_declaration: "",
            precision: "highp",
            getter: "uniformValue.x",
            type_: glw::GL_FLOAT_VEC2,
            size: 1,
        },
        UniformType {
            declaration: "vec3",
            post_declaration: "",
            precision: "highp",
            getter: "uniformValue.x",
            type_: glw::GL_FLOAT_VEC3,
            size: 1,
        },
        UniformType {
            declaration: "vec4",
            post_declaration: "",
            precision: "highp",
            getter: "uniformValue.x",
            type_: glw::GL_FLOAT_VEC4,
            size: 1,
        },
        UniformType {
            declaration: "int",
            post_declaration: "",
            precision: "highp",
            getter: "float(uniformValue)",
            type_: glw::GL_INT,
            size: 1,
        },
        UniformType {
            declaration: "ivec2",
            post_declaration: "",
            precision: "highp",
            getter: "float(uniformValue.x)",
            type_: glw::GL_INT_VEC2,
            size: 1,
        },
        UniformType {
            declaration: "ivec3",
            post_declaration: "",
            precision: "highp",
            getter: "float(uniformValue.x)",
            type_: glw::GL_INT_VEC3,
            size: 1,
        },
        UniformType {
            declaration: "ivec4",
            post_declaration: "",
            precision: "highp",
            getter: "float(uniformValue.x)",
            type_: glw::GL_INT_VEC4,
            size: 1,
        },
        UniformType {
            declaration: "bool",
            post_declaration: "",
            precision: "",
            getter: "float(uniformValue)",
            type_: glw::GL_BOOL,
            size: 1,
        },
        UniformType {
            declaration: "bvec2",
            post_declaration: "",
            precision: "",
            getter: "float(uniformValue.x)",
            type_: glw::GL_BOOL_VEC2,
            size: 1,
        },
        UniformType {
            declaration: "bvec3",
            post_declaration: "",
            precision: "",
            getter: "float(uniformValue.x)",
            type_: glw::GL_BOOL_VEC3,
            size: 1,
        },
        UniformType {
            declaration: "bvec4",
            post_declaration: "",
            precision: "",
            getter: "float(uniformValue.x)",
            type_: glw::GL_BOOL_VEC4,
            size: 1,
        },
        UniformType {
            declaration: "mat2",
            post_declaration: "",
            precision: "highp",
            getter: "float(uniformValue[0][0])",
            type_: glw::GL_FLOAT_MAT2,
            size: 1,
        },
        UniformType {
            declaration: "mat3",
            post_declaration: "",
            precision: "highp",
            getter: "float(uniformValue[0][0])",
            type_: glw::GL_FLOAT_MAT3,
            size: 1,
        },
        UniformType {
            declaration: "mat4",
            post_declaration: "",
            precision: "highp",
            getter: "float(uniformValue[0][0])",
            type_: glw::GL_FLOAT_MAT4,
            size: 1,
        },
        UniformType {
            declaration: "sampler2D",
            post_declaration: "",
            precision: "highp",
            getter: "float(texture2D(uniformValue, vec2(0.0, 0.0)).r)",
            type_: glw::GL_SAMPLER_2D,
            size: 1,
        },
        UniformType {
            declaration: "samplerCube",
            post_declaration: "",
            precision: "highp",
            getter: "float(textureCube(uniformValue, vec3(0.0, 0.0, 0.0)).r)",
            type_: glw::GL_SAMPLER_CUBE,
            size: 1,
        },
    ];

    let gl = case.gl();
    // SAFETY: all three names are deleted below.
    let (shader_vert, shader_frag, program) = unsafe {
        (
            gl.create_shader(glw::GL_VERTEX_SHADER),
            gl.create_shader(glw::GL_FRAGMENT_SHADER),
            gl.create_program(),
        )
    };

    // SAFETY: both shaders are live and not yet attached.
    unsafe {
        gl.attach_shader(program, shader_vert);
        gl.attach_shader(program, shader_frag);
    }

    shader_source(case, shader_vert, &[COMMON_TEST_VERT_SOURCE]);
    // SAFETY: the vertex shader has source attached and never changes again.
    unsafe { gl.compile_shader(shader_vert) };
    case.expect_error(glw::GL_NO_ERROR);

    for uniform in UNIFORM_TYPES {
        case.section(&format!(
            "Verify type of {}{} variable",
            uniform.declaration, uniform.post_declaration
        ));

        // gen fragment shader
        let frag = format!(
            "uniform {} {} uniformValue{};\nvoid main (void)\n{{\n\tgl_FragColor = vec4({});\n}}\n",
            uniform.precision, uniform.declaration, uniform.post_declaration, uniform.getter
        );
        shader_source(case, shader_frag, &[&frag]);

        // compile & link
        // SAFETY: the fragment shader has fresh source; both are attached to the program.
        unsafe {
            gl.compile_shader(shader_frag);
            gl.link_program(program);
        }

        // test
        if verify_program_param(case, program, glw::GL_LINK_STATUS, glw::GL_TRUE as GLint) {
            let index = 0; // first and only active uniform

            let mut written: GLsizei = 0;
            let mut size: GLint = 0;
            let mut type_: GLenum = 0;
            // A buffer size of 0 means the name is not written at all, so no buffer is
            // needed - upstream passes one anyway and relies on the same rule.
            // SAFETY: the three out-parameters are scalars; `name` is never written.
            unsafe {
                gl.get_active_uniform(
                    program,
                    index,
                    0,
                    &raw mut written,
                    &raw mut size,
                    &raw mut type_,
                    std::ptr::null_mut(),
                );
            }

            check_int_equals(case, type_ as GLint, uniform.type_ as GLint);
            check_int_equals(case, size, uniform.size);
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

/// `ActiveAttributesCase`
fn active_attributes(case: &mut ApiCase<'_>) {
    const LONG_NAME: &str = "longInputAttributeName";
    const SHORT_NAME: &str = "shortName";

    let test_vert_source = "attribute highp vec2 longInputAttributeName;\n\
                            attribute highp vec2 shortName;\n\
                            void main (void)\n\
                            {\n\
                            \tgl_Position = longInputAttributeName.yxxy + shortName.xyxy;\n\
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

    verify_program_param(case, program, glw::GL_ACTIVE_ATTRIBUTES, 2);
    // does include the null terminator
    verify_program_param(
        case,
        program,
        glw::GL_ACTIVE_ATTRIBUTE_MAX_LENGTH,
        LONG_NAME.len() as GLint + 1,
    );

    // check names
    for attribute_ndx in 0..2 {
        let mut buffer = new_char_buffer();
        let buffer_len = buffer.len();

        let mut written: GLsizei = 0;
        let mut size: GLint = 0;
        let mut type_: GLenum = 0;
        // SAFETY: the buffer is `buffer_len` bytes; the rest are scalars.
        unsafe {
            gl.get_active_attrib(
                program,
                attribute_ndx,
                buffer_len as GLsizei,
                &raw mut written,
                &raw mut size,
                &raw mut type_,
                buffer.as_mut_ptr().cast::<glw::GLchar>(),
            );
        }
        case.expect_error(glw::GL_NO_ERROR);

        // `written` does NOT include the null terminator.
        let name = String::from_utf8_lossy(&buffer).into_owned();
        if name.starts_with(LONG_NAME) {
            check_int_equals(case, written, LONG_NAME.len() as GLint);
        } else if name.starts_with(SHORT_NAME) {
            check_int_equals(case, written, SHORT_NAME.len() as GLint);
        } else {
            case.fail("Got unexpected attribute name.".to_string(), "got unexpected name");
        }
    }

    // and with too short buffer
    {
        let mut buffer = new_char_buffer();
        let mut written: GLsizei = 0;
        let mut size: GLint = 0;
        let mut type_: GLenum = 0;

        // SAFETY: a buffer size of 1 asks for the terminator only.
        unsafe {
            gl.get_active_attrib(
                program,
                0,
                1,
                &raw mut written,
                &raw mut size,
                &raw mut type_,
                buffer.as_mut_ptr().cast::<glw::GLchar>(),
            );
        }
        case.expect_error(glw::GL_NO_ERROR);
        check_int_equals(case, written, 0);
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
struct PointerData {
    size: GLint,
    type_: GLenum,
    stride: GLsizei,
    normalized: glw::GLboolean,
    /// Index into the case's `vertexData`, since a Rust local's address cannot be a
    /// `const` the way upstream's array-of-pointers is a stack initialiser.
    offset: usize,
}

/// Calls `glVertexAttribPointer` for each row and checks one attribute parameter after
/// each - the shared body of the five `vertex_attrib_*` cases.
fn vertex_attrib_pointer_cases(
    case: &mut ApiCase<'_>,
    pname: GLenum,
    pointers: &[PointerData],
    reference: impl Fn(&PointerData) -> GLint,
) {
    let vertex_data = [0.0f32; 4]; // never accessed

    for pointer in pointers {
        let gl = case.gl();
        // SAFETY: attribute 0 always exists. The pointer is never dereferenced - no draw
        // call happens in this group - which is why a stack address is fine here.
        unsafe {
            gl.vertex_attrib_pointer(
                0,
                pointer.size,
                pointer.type_,
                pointer.normalized,
                pointer.stride,
                vertex_data.as_ptr().add(pointer.offset).cast::<c_void>(),
            );
        }
        case.expect_error(glw::GL_NO_ERROR);

        verify_vertex_attrib(case, 0, pname, reference(pointer));
    }
}

/// `VertexAttributeSizeCase`
fn vertex_attrib_size(case: &mut ApiCase<'_>) {
    let pointers: Vec<PointerData> = [glw::GL_FLOAT, glw::GL_SHORT]
        .into_iter()
        .flat_map(|type_| {
            (1..=4).rev().map(move |size| PointerData {
                size,
                type_,
                stride: 0,
                normalized: glw::FALSE,
                offset: 0,
            })
        })
        .collect();

    vertex_attrib_pointer_cases(case, glw::GL_VERTEX_ATTRIB_ARRAY_SIZE, &pointers, |pointer| {
        pointer.size
    });
}

/// `VertexAttributeTypeCase`
fn vertex_attrib_type(case: &mut ApiCase<'_>) {
    let pointers: Vec<PointerData> = [
        glw::GL_BYTE,
        glw::GL_UNSIGNED_BYTE,
        glw::GL_SHORT,
        glw::GL_UNSIGNED_SHORT,
        glw::GL_FIXED,
        glw::GL_FLOAT,
    ]
    .into_iter()
    .map(|type_| PointerData {
        size: 1,
        type_,
        stride: 0,
        normalized: glw::FALSE,
        offset: 0,
    })
    .collect();

    vertex_attrib_pointer_cases(case, glw::GL_VERTEX_ATTRIB_ARRAY_TYPE, &pointers, |pointer| {
        pointer.type_ as GLint
    });
}

/// `VertexAttributeStrideCase`
fn vertex_attrib_stride(case: &mut ApiCase<'_>) {
    const ROWS: [(GLint, GLenum, GLsizei); 15] = [
        (1, glw::GL_FLOAT, 0),
        (1, glw::GL_FLOAT, 1),
        (1, glw::GL_FLOAT, 4),
        (1, glw::GL_SHORT, 0),
        (1, glw::GL_SHORT, 1),
        (1, glw::GL_SHORT, 4),
        (1, glw::GL_FIXED, 0),
        (1, glw::GL_FIXED, 1),
        (1, glw::GL_FIXED, 4),
        (1, glw::GL_BYTE, 0),
        (1, glw::GL_UNSIGNED_SHORT, 1),
        (1, glw::GL_UNSIGNED_SHORT, 4),
        (4, glw::GL_UNSIGNED_BYTE, 0),
        (4, glw::GL_UNSIGNED_BYTE, 1),
        (4, glw::GL_UNSIGNED_BYTE, 4),
    ];

    let pointers: Vec<PointerData> = ROWS
        .into_iter()
        .map(|(size, type_, stride)| PointerData {
            size,
            type_,
            stride,
            normalized: glw::FALSE,
            offset: 0,
        })
        .collect();

    vertex_attrib_pointer_cases(case, glw::GL_VERTEX_ATTRIB_ARRAY_STRIDE, &pointers, |pointer| {
        pointer.stride
    });
}

/// `VertexAttributeNormalizedCase`
fn vertex_attrib_normalized(case: &mut ApiCase<'_>) {
    let pointers: Vec<PointerData> = [glw::FALSE, glw::TRUE]
        .into_iter()
        .flat_map(|normalized| {
            [
                glw::GL_BYTE,
                glw::GL_SHORT,
                glw::GL_UNSIGNED_BYTE,
                glw::GL_UNSIGNED_SHORT,
            ]
            .into_iter()
            .map(move |type_| PointerData {
                size: 1,
                type_,
                stride: 0,
                normalized,
                offset: 0,
            })
        })
        .collect();

    vertex_attrib_pointer_cases(case, glw::GL_VERTEX_ATTRIB_ARRAY_NORMALIZED, &pointers, |pointer| {
        GLint::from(pointer.normalized)
    });
}

/// `VertexAttributeEnabledCase`
fn vertex_attrib_array_enabled(case: &mut ApiCase<'_>) {
    let gl = case.gl();

    verify_vertex_attrib(case, 0, glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED, glw::GL_FALSE as GLint);
    // SAFETY: attribute 0 always exists.
    unsafe { gl.enable_vertex_attrib_array(0) };
    verify_vertex_attrib(case, 0, glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED, glw::GL_TRUE as GLint);
    // SAFETY: as above.
    unsafe { gl.disable_vertex_attrib_array(0) };
    verify_vertex_attrib(case, 0, glw::GL_VERTEX_ATTRIB_ARRAY_ENABLED, glw::GL_FALSE as GLint);
}

/// `VertexAttributeBufferBindingCase`
fn vertex_attrib_array_buffer_binding(case: &mut ApiCase<'_>) {
    let gl = case.gl();

    // initial
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

    // SAFETY: as above.
    unsafe { gl.delete_buffers(1, &raw const buffer_id) };
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
        (1, glw::GL_FIXED, 2),
        (1, glw::GL_FIXED, 1),
        (1, glw::GL_FLOAT, 0),
        (1, glw::GL_FLOAT, 3),
        (1, glw::GL_FLOAT, 2),
        (1, glw::GL_UNSIGNED_SHORT, 0),
        (4, glw::GL_UNSIGNED_SHORT, 1),
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
    let test_vert_source = "uniform highp float floatUniform;\n\
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
    let test_vert_source = "uniform highp int intUniform;\n\
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

/// `UniformValueBooleanCase` - a bool uniform reads back as exactly 0 or 1, whatever it
/// was set from, which is the whole point of the two passes.
fn uniform_value_boolean(case: &mut ApiCase<'_>) {
    let test_vert_source = "uniform bool boolUniform;\n\
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
    let test_frag_source = "uniform highp sampler2D uniformSampler;\n\
                            void main (void)\n\
                            {\n\
                            \tgl_FragColor = vec4(texture2D(uniformSampler, vec2(0.0, 0.0)).x);\n\
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

    let test_vert_source = "uniform highp float arrayUniform[5];\
                            uniform highp vec2 array2Uniform[5];\
                            uniform highp vec3 array3Uniform[5];\
                            uniform highp vec4 array4Uniform[5];\
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

    let test_vert_source = "uniform highp mat2 mat2Uniform;\
                            uniform highp mat3 mat3Uniform;\
                            uniform highp mat4 mat4Uniform;\
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
///
/// For example highp float: range (-2^62, 2^62) => min = -2^62 + e, max = 2^62 - e.
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

    // special case for highp and fragment shader
    if shader_type == glw::GL_FRAGMENT_SHADER
        && (precision_type == glw::GL_HIGH_FLOAT || precision_type == glw::GL_HIGH_INT)
        && range == [0, 0]
        && precision == 0
    {
        // not supported is a valid return value
        return;
    }

    // verify the returned values
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

/// `ShaderStateQueryTests::init`
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
        ("current_vertex_attrib_float_to_int", current_vertex_attrib_float_to_int),
        // program
        ("program_info_log_length", program_info_log_length),
        ("program_validate_status", program_validate_status),
        ("program_attached_shaders", program_attached_shaders),
        ("program_active_uniform_name", program_active_uniform_name),
        ("program_active_uniform_types", program_active_uniform_types),
        // attribute related
        ("active_attributes", active_attributes),
        ("vertex_attrib_size", vertex_attrib_size),
        ("vertex_attrib_type", vertex_attrib_type),
        ("vertex_attrib_stride", vertex_attrib_stride),
        ("vertex_attrib_normalized", vertex_attrib_normalized),
        ("vertex_attrib_array_enabled", vertex_attrib_array_enabled),
        ("vertex_attrib_array_buffer_binding", vertex_attrib_array_buffer_binding),
        ("vertex_attrib_pointerv", vertex_attrib_pointerv),
        // uniform values
        ("uniform_value_float", uniform_value_float),
        ("uniform_value_int", uniform_value_int),
        ("uniform_value_boolean", uniform_value_boolean),
        ("uniform_value_sampler", uniform_value_sampler),
        ("uniform_value_array", uniform_value_array),
        ("uniform_value_matrix", uniform_value_matrix),
    ];
    add_api_cases(&mut group, cases);

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
