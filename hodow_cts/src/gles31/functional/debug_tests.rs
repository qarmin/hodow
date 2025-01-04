// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fDebugTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. All seven of upstream's sub-groups are
// ported: `state_query`, `negative_coverage`, `externally_generated`, `error_filters`,
// `error_groups`, `async` and `object_labels`.
//
// `error_filters`/`error_groups` are `FilterCase`/`GroupFilterCase`, which run a shuffled
// slice of the negative-test functions twice - once unfiltered and once with generated
// `glDebugMessageControl` filters in place - and compare how many of each message arrived
// against the reference run. That is `BaseCase`'s *counting* half (`MessageID`,
// `genFilters`/`applyFilters`/`isEnabled`, `verifyMessageCount`); `negative_test_shared`
// otherwise keeps only the "did *a* message arrive" half, which is why the two cases here
// run the functions themselves under `Reporting::Filter` rather than through
// `NegativeCase`.
//
// `async` reuses the same counting model with the *same* functions run twice - once with
// `GL_DEBUG_OUTPUT_SYNCHRONOUS` on to learn how many of each message to expect, then again
// with it off - so the only thing it needs beyond `FilterCase` is that the log-fetching
// half of it drains the message log from inside `expectMessage`, which is what
// `Reporting::Async` plus `NegativeTestContext::set_expect_message_hook` are for.
//
// `externally_generated` needs no counting at all: its three message functions insert a
// message and ask for it straight back through `expectMessage`, and `GroupCase` keeps its
// own single-message record because it is the one case here that checks a message's id and
// severity too.
//
// The sub-group list per reporting method is upstream's, in upstream's order. The ones whose
// port has not landed yet are listed as comments rather than dropped, so the gap is visible
// against `getNegative*TestFunctions()`.

use std::cell::RefCell;
use std::collections::{BTreeMap, BTreeSet};
use std::ffi::{CStr, CString, c_void};
use std::sync::{Mutex, MutexGuard};
use std::time::Duration;
use std::{fmt, ptr};

use crate::gles31::functional::negative_test_shared::{
    self, FunctionContainer, NegativeTestContext, Reporting, create_child_cases, is_khr_debug_supported,
};
use crate::gles31::functional::{
    negative_advanced_blend_equation_tests, negative_atomic_counter_tests, negative_buffer_api_tests,
    negative_compute_tests, negative_fragment_api_tests, negative_precise_tests, negative_sample_variables_tests,
    negative_shader_api_tests, negative_shader_directive_tests, negative_shader_framebuffer_fetch_tests,
    negative_shader_function_tests, negative_shader_image_load_store_tests, negative_shader_storage_tests,
    negative_ssbo_block_tests, negative_state_api_tests, negative_tessellation_tests, negative_texture_api_tests,
    negative_vertex_array_api_tests,
};
use crate::gls::state_query_util::{
    QueryType, verify_state_boolean, verify_state_integer, verify_state_integer_min, verify_state_pointer,
};
use crate::glu::{ApiCase, Context, TestCase, TestCaseGroup, add_api_case};
use crate::glw::{self, GLenum, GLint, GLsizei, GLsync, GLuint};
use crate::tcu::random::{Random, de_int32_hash, de_string_hash};
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome, TestResult};

/// One `callbacks` / `log` / `get_error` host group.
fn host_group(reporting: Reporting, name: &str) -> TestCaseGroup {
    let mut host = TestCaseGroup::new(name);

    host.add_child(create_child_cases(
        reporting,
        "buffer",
        negative_buffer_api_tests::FUNCTIONS,
    ));
    host.add_child(create_child_cases(
        reporting,
        "texture",
        negative_texture_api_tests::FUNCTIONS,
    ));
    host.add_child(create_child_cases(
        reporting,
        "shader",
        negative_shader_api_tests::FUNCTIONS,
    ));
    host.add_child(create_child_cases(
        reporting,
        "fragment",
        negative_fragment_api_tests::FUNCTIONS,
    ));
    host.add_child(create_child_cases(
        reporting,
        "vertex_array",
        negative_vertex_array_api_tests::FUNCTIONS,
    ));
    host.add_child(create_child_cases(
        reporting,
        "state",
        negative_state_api_tests::FUNCTIONS,
    ));
    host.add_child(create_child_cases(
        reporting,
        "atomic_counter",
        negative_atomic_counter_tests::FUNCTIONS,
    ));
    host.add_child(create_child_cases(
        reporting,
        "shader_image_load",
        negative_shader_image_load_store_tests::LOAD_FUNCTIONS,
    ));
    host.add_child(create_child_cases(
        reporting,
        "shader_image_store",
        negative_shader_image_load_store_tests::STORE_FUNCTIONS,
    ));
    host.add_child(create_child_cases(
        reporting,
        "shader_image_atomic",
        negative_shader_image_load_store_tests::ATOMIC_FUNCTIONS,
    ));
    host.add_child(create_child_cases(
        reporting,
        "shader_image_exchange",
        negative_shader_image_load_store_tests::ATOMIC_EXCHANGE_FUNCTIONS,
    ));
    host.add_child(create_child_cases(
        reporting,
        "shader_function",
        negative_shader_function_tests::FUNCTIONS,
    ));
    host.add_child(create_child_cases(
        reporting,
        "shader_directive",
        negative_shader_directive_tests::FUNCTIONS,
    ));
    host.add_child(create_child_cases(
        reporting,
        "ssbo_block",
        negative_ssbo_block_tests::FUNCTIONS,
    ));
    host.add_child(create_child_cases(
        reporting,
        "precise",
        negative_precise_tests::FUNCTIONS,
    ));
    host.add_child(create_child_cases(
        reporting,
        "advanced_blend",
        negative_advanced_blend_equation_tests::FUNCTIONS,
    ));
    host.add_child(create_child_cases(
        reporting,
        "shader_storage",
        negative_shader_storage_tests::FUNCTIONS,
    ));
    host.add_child(create_child_cases(
        reporting,
        "tessellation",
        negative_tessellation_tests::FUNCTIONS,
    ));
    host.add_child(create_child_cases(
        reporting,
        "oes_sample_variables",
        negative_sample_variables_tests::FUNCTIONS,
    ));
    host.add_child(create_child_cases(
        reporting,
        "compute",
        negative_compute_tests::FUNCTIONS,
    ));
    host.add_child(create_child_cases(
        reporting,
        "framebuffer_fetch",
        negative_shader_framebuffer_fetch_tests::FUNCTIONS,
    ));

    host
}

// ---------------------------------------------------------------------------------------
// state_query
// ---------------------------------------------------------------------------------------

/// `TCU_CHECK_AND_THROW(NotSupportedError, isKHRDebugSupported(m_context), ...)` - the
/// first line of every case in this file.
fn require_khr_debug(case: &mut ApiCase<'_>) -> bool {
    if is_khr_debug_supported(case.context()) {
        return true;
    }
    case.not_supported("GL_KHR_debug is not supported");
    false
}

/// `LimitQueryCase::iterate`
fn limit_query_case(case: &mut ApiCase<'_>, target: GLenum, limit: i32, verifier: QueryType) {
    if !require_khr_debug(case) {
        return;
    }
    verify_state_integer_min(case, target, limit, verifier);
}

/// `IsEnabledCase::iterate`
fn is_enabled_case(case: &mut ApiCase<'_>, target: GLenum, initial: bool, verifier: QueryType) {
    if !require_khr_debug(case) {
        return;
    }

    // check inital value
    verify_state_boolean(case, target, initial, verifier);

    // check toggle

    // SAFETY: a capability enum, on a context that has GL_KHR_debug.
    unsafe { case.gl().enable(target) };
    case.expect_no_error("glEnable");

    verify_state_boolean(case, target, true, verifier);

    // SAFETY: as above.
    unsafe { case.gl().disable(target) };
    case.expect_no_error("glDisable");

    verify_state_boolean(case, target, false, verifier);
}

/// `PositiveIntegerCase::iterate`
fn positive_integer_case(case: &mut ApiCase<'_>, target: GLenum, verifier: QueryType) {
    if !require_khr_debug(case) {
        return;
    }
    verify_state_integer_min(case, target, 0, verifier);
}

/// `GroupStackDepthQueryCase::iterate`
fn group_stack_depth_query_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    if !require_khr_debug(case) {
        return;
    }

    case.section("Initial");
    verify_state_integer(case, glw::GL_DEBUG_GROUP_STACK_DEPTH, 1, verifier);

    case.section("Scoped");
    // SAFETY: a NUL-terminated message with an explicit -1 length. The matching pop below
    // keeps the group stack balanced, which matters because this port does not reset debug
    // state between cases (see `debug_callback_function_case`).
    unsafe {
        case.gl()
            .push_debug_group(glw::GL_DEBUG_SOURCE_APPLICATION, 1, -1, c"Application group 1".as_ptr())
    };
    verify_state_integer(case, glw::GL_DEBUG_GROUP_STACK_DEPTH, 2, verifier);
    // SAFETY: as above.
    unsafe { case.gl().pop_debug_group() };
}

/// `emptyCallback` - registered only so that its address can be read back.
unsafe extern "C" fn empty_callback(
    _source: GLenum,
    _gltype: GLenum,
    _id: GLuint,
    _severity: GLenum,
    _length: GLsizei,
    _message: *const glw::GLchar,
    _user_param: *const c_void,
) {
    // empty
}

/// `DebugCallbackFunctionCase::iterate`
///
/// Note this leaves `empty_callback` registered, exactly as upstream's case does. Upstream's
/// `glu::resetState` clears it between cases; this port does not carry that section (see
/// `glu::state_reset`), so the two pointer cases must stay in upstream's registration order -
/// the function case reads the initial value before the user-param case sets one.
fn debug_callback_function_case(case: &mut ApiCase<'_>) {
    if !require_khr_debug(case) {
        return;
    }

    case.section("Initial");
    verify_state_pointer(case, glw::GL_DEBUG_CALLBACK_FUNCTION, ptr::null(), QueryType::Pointer);

    case.section("Set");
    // SAFETY: `empty_callback` has the GLDEBUGPROC signature and a `'static` address.
    unsafe { case.gl().debug_message_callback(Some(empty_callback), ptr::null()) };
    verify_state_pointer(
        case,
        glw::GL_DEBUG_CALLBACK_FUNCTION,
        empty_callback as *const c_void,
        QueryType::Pointer,
    );
}

/// `DebugCallbackUserParamCase::iterate`
fn debug_callback_user_param_case(case: &mut ApiCase<'_>) {
    if !require_khr_debug(case) {
        return;
    }

    case.section("Initial");
    verify_state_pointer(case, glw::GL_DEBUG_CALLBACK_USER_PARAM, ptr::null(), QueryType::Pointer);

    case.section("Set");
    // `(void *)(int *)0x123` upstream: never dereferenced, only stored and read back.
    let param = ptr::without_provenance::<c_void>(0x123);
    // SAFETY: as above; `empty_callback` ignores its user parameter.
    unsafe { case.gl().debug_message_callback(Some(empty_callback), param) };
    verify_state_pointer(case, glw::GL_DEBUG_CALLBACK_USER_PARAM, param, QueryType::Pointer);
}

/// `FOR_ALL_TYPES`
const ALL_TYPES: [QueryType; 4] = [
    QueryType::Boolean,
    QueryType::Integer,
    QueryType::Integer64,
    QueryType::Float,
];

/// `FOR_ALL_ENABLE_TYPES`
const ALL_ENABLE_TYPES: [QueryType; 5] = [
    QueryType::IsEnabled,
    QueryType::Boolean,
    QueryType::Integer,
    QueryType::Integer64,
    QueryType::Float,
];

/// `limits[]`
const LIMITS: [(&str, GLenum, i32); 4] = [
    ("max_debug_message_length", glw::GL_MAX_DEBUG_MESSAGE_LENGTH, 1),
    ("max_debug_logged_messages", glw::GL_MAX_DEBUG_LOGGED_MESSAGES, 1),
    ("max_debug_group_stack_depth", glw::GL_MAX_DEBUG_GROUP_STACK_DEPTH, 64),
    ("max_label_length", glw::GL_MAX_LABEL_LENGTH, 256),
];

/// `IsEnabledCase::INITIAL_CTX_IS_DEBUG` / `INITIAL_FALSE`. The first is upstream's
/// `(getType().getFlags() & glu::CONTEXT_DEBUG) != 0`, which is always false here - this
/// port never asks for a debug context, the same conclusion `boolean_state_query_tests`
/// reaches for its own `debug_output` entry.
const IS_ENABLEDS: [(&str, GLenum, bool); 2] = [
    ("debug_output", glw::GL_DEBUG_OUTPUT, false),
    ("debug_output_synchronous", glw::GL_DEBUG_OUTPUT_SYNCHRONOUS, false),
];

/// `PositiveIntegerCase` targets, in upstream's registration order.
const POSITIVE_INTEGERS: [(&str, GLenum); 2] = [
    ("debug_logged_messages", glw::GL_DEBUG_LOGGED_MESSAGES),
    (
        "debug_next_logged_message_length",
        glw::GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH,
    ),
];

/// The `state_query` sub-group of `DebugTests::init`.
fn state_query_group() -> TestCaseGroup {
    let mut queries = TestCaseGroup::new("state_query");

    for (name, target, limit) in LIMITS {
        for verifier in ALL_TYPES {
            add_api_case(
                &mut queries,
                format!("{name}_{}", verifier.suffix()),
                move |case: &mut ApiCase<'_>| {
                    limit_query_case(case, target, limit, verifier);
                },
            );
        }
    }

    for (name, target, initial) in IS_ENABLEDS {
        for verifier in ALL_ENABLE_TYPES {
            add_api_case(
                &mut queries,
                format!("{name}_{}", verifier.suffix()),
                move |case: &mut ApiCase<'_>| {
                    is_enabled_case(case, target, initial, verifier);
                },
            );
        }
    }

    for (name, target) in POSITIVE_INTEGERS {
        for verifier in ALL_TYPES {
            add_api_case(
                &mut queries,
                format!("{name}_{}", verifier.suffix()),
                move |case: &mut ApiCase<'_>| {
                    positive_integer_case(case, target, verifier);
                },
            );
        }
    }

    for verifier in ALL_TYPES {
        add_api_case(
            &mut queries,
            format!("debug_group_stack_depth_{}", verifier.suffix()),
            move |case: &mut ApiCase<'_>| {
                group_stack_depth_query_case(case, verifier);
            },
        );
    }

    add_api_case(
        &mut queries,
        "debug_callback_function_getpointer",
        debug_callback_function_case,
    );
    add_api_case(
        &mut queries,
        "debug_callback_user_param_getpointer",
        debug_callback_user_param_case,
    );

    queries
}

// ---------------------------------------------------------------------------------------
// object_labels
// ---------------------------------------------------------------------------------------

/// The label every case in this group writes (`strlen` = 21). It is a `CStr` because most
/// of the writes pass a negative length, which makes the driver read it as a C string.
const LABEL_MSG: &CStr = c"This is a debug label";

/// `clipMsg` - the first 12 bytes of `LABEL_MSG`.
const CLIP_MSG: &CStr = c"This is a de";

/// The byte `deMemset(buffer, 'X', sizeof(buffer))` fills a read-back buffer with, so a
/// driver that writes nothing is distinguishable from one that writes an empty string.
const FILL: u8 = b'X';

/// `strcmp(msg, buffer)`'s view of a read-back buffer: everything before the first NUL.
///
/// A buffer with no NUL at all is returned whole, which then compares unequal to any
/// expected label. Upstream reads past the array there instead.
fn c_bytes(buffer: &[u8]) -> &[u8] {
    let end = buffer.iter().position(|b| *b == 0).unwrap_or(buffer.len());
    &buffer[..end]
}

/// The same thing, for a log line.
fn label_text(buffer: &[u8]) -> String {
    String::from_utf8_lossy(c_bytes(buffer)).into_owned()
}

/// `gl.objectLabel(identifier, object, length, label)`
fn object_label(case: &mut ApiCase<'_>, identifier: GLenum, object: GLuint, length: GLsizei, label: &CStr) {
    // SAFETY: `label` is NUL-terminated and outlives the call, and `length` is either a
    // negative value ("read it as a C string") or at most its length.
    unsafe { case.gl().object_label(identifier, object, length, label.as_ptr()) };
}

/// `gl.objectLabel(identifier, object, length, NULL)` - the clearing form.
fn clear_object_label(case: &mut ApiCase<'_>, identifier: GLenum, object: GLuint, length: GLsizei) {
    // SAFETY: a null label is what clears the label, per GL_KHR_debug.
    unsafe { case.gl().object_label(identifier, object, length, ptr::null()) };
}

/// `gl.objectPtrLabel(ptr, length, label)`
fn object_ptr_label(case: &mut ApiCase<'_>, sync: GLsync, length: GLsizei, label: &CStr) {
    // SAFETY: as `object_label`; `sync` is a live sync object.
    unsafe { case.gl().object_ptr_label(sync.cast_const(), length, label.as_ptr()) };
}

/// `gl.objectPtrLabel(ptr, length, NULL)`
fn clear_object_ptr_label(case: &mut ApiCase<'_>, sync: GLsync, length: GLsizei) {
    // SAFETY: as above.
    unsafe { case.gl().object_ptr_label(sync.cast_const(), length, ptr::null()) };
}

/// `gl.getObjectLabel(identifier, object, bufSize, &outlen, buffer)`.
///
/// `want_length` false is upstream's `nullptr` for `length`, which one sub-case of
/// `BufferLimitedLabelCase` passes to check the driver copes with it.
fn get_object_label(
    case: &mut ApiCase<'_>,
    identifier: GLenum,
    object: GLuint,
    buffer: &mut [u8],
    want_length: bool,
) -> GLsizei {
    let mut outlen: GLsizei = -1;
    let length_ptr = if want_length { &raw mut outlen } else { ptr::null_mut() };
    let buf_size = GLsizei::try_from(buffer.len()).expect("label buffer fits in a GLsizei");
    // SAFETY: `buffer` is `buf_size` bytes and the driver writes at most that many.
    unsafe {
        case.gl().get_object_label(
            identifier,
            object,
            buf_size,
            length_ptr,
            buffer.as_mut_ptr().cast::<glw::GLchar>(),
        );
    }
    outlen
}

/// `gl.getObjectPtrLabel(ptr, bufSize, &outlen, buffer)` - see `get_object_label`.
fn get_object_ptr_label(case: &mut ApiCase<'_>, sync: GLsync, buffer: &mut [u8], want_length: bool) -> GLsizei {
    let mut outlen: GLsizei = -1;
    let length_ptr = if want_length { &raw mut outlen } else { ptr::null_mut() };
    let buf_size = GLsizei::try_from(buffer.len()).expect("label buffer fits in a GLsizei");
    // SAFETY: as above.
    unsafe {
        case.gl().get_object_ptr_label(
            sync.cast_const(),
            buf_size,
            length_ptr,
            buffer.as_mut_ptr().cast::<glw::GLchar>(),
        );
    }
    outlen
}

/// `gl.getObjectLabel(identifier, object, 0, &outlen, NULL)` - the length-only query.
fn get_object_label_length(case: &mut ApiCase<'_>, identifier: GLenum, object: GLuint) -> GLsizei {
    let mut outlen: GLsizei = -1;
    // SAFETY: a null label with a zero buffer size asks for the length alone.
    unsafe {
        case.gl()
            .get_object_label(identifier, object, 0, &raw mut outlen, ptr::null_mut())
    };
    outlen
}

/// `gl.getObjectPtrLabel(ptr, 0, &outlen, NULL)`
fn get_object_ptr_label_length(case: &mut ApiCase<'_>, sync: GLsync) -> GLsizei {
    let mut outlen: GLsizei = -1;
    // SAFETY: as above.
    unsafe {
        case.gl()
            .get_object_ptr_label(sync.cast_const(), 0, &raw mut outlen, ptr::null_mut())
    };
    outlen
}

/// `gl.fenceSync(GL_SYNC_GPU_COMMANDS_COMPLETE, 0)`
fn fence_sync(case: &mut ApiCase<'_>) -> GLsync {
    // SAFETY: a sync object needs only a current ES 3.0+ context.
    let sync = unsafe { case.gl().fence_sync(glw::GL_SYNC_GPU_COMMANDS_COMPLETE, 0) };
    case.expect_no_error("fenceSync");
    sync
}

/// `gl.createShader(GL_FRAGMENT_SHADER)`
fn create_shader(case: &mut ApiCase<'_>) -> GLuint {
    // SAFETY: creating a shader object needs only a current context.
    let shader = unsafe { case.gl().create_shader(glw::GL_FRAGMENT_SHADER) };
    case.expect_no_error("createShader");
    shader
}

/// `gl.deleteShader(shader); gl.deleteSync(sync);` - how every case in this group ends.
fn delete_shader_and_sync(case: &mut ApiCase<'_>, shader: GLuint, sync: GLsync) {
    // SAFETY: both handles were created by this case and are not used afterwards.
    unsafe {
        case.gl().delete_shader(shader);
        case.gl().delete_sync(sync);
    }
}

/// The shared tail of every "the label should now be empty" check.
fn expect_empty_label(case: &mut ApiCase<'_>, outlen: GLsizei, buffer: &[u8]) {
    if outlen != 0 {
        case.fail(
            format!("'length' was not zero, got {outlen}"),
            "Got invalid label length",
        );
    } else if buffer[0] != 0 {
        case.fail(
            "label was not null terminated".to_string(),
            "Label was not null terminated",
        );
    }
}

/// `InitialLabelCase::iterate`
fn initial_label_case(case: &mut ApiCase<'_>) {
    if !require_khr_debug(case) {
        return;
    }

    let sync = fence_sync(case);
    let shader = create_shader(case);
    let mut buffer = [FILL; 64];

    {
        case.section("Shader object");
        buffer[0] = FILL;
        let outlen = get_object_label(case, glw::GL_SHADER, shader, &mut buffer, true);
        case.expect_no_error("getObjectLabel");
        expect_empty_label(case, outlen, &buffer);
    }

    {
        case.section("Sync object");
        buffer[0] = FILL;
        let outlen = get_object_ptr_label(case, sync, &mut buffer, true);
        case.expect_no_error("getObjectPtrLabel");
        expect_empty_label(case, outlen, &buffer);
    }

    delete_shader_and_sync(case, shader, sync);
}

/// `s_clearMethods[]` - "with NULL label and 0 / 1 / negative length".
const CLEAR_METHODS: [GLsizei; 3] = [0, 1, -1];

/// `ClearLabelCase::iterate`
fn clear_label_case(case: &mut ApiCase<'_>) {
    if !require_khr_debug(case) {
        return;
    }

    let sync = fence_sync(case);
    let shader = create_shader(case);
    let mut buffer = [FILL; 64];

    {
        case.section("Shader object");
        for length in CLEAR_METHODS {
            // -2 is upstream's literal: any negative length means "NUL-terminated".
            object_label(case, glw::GL_SHADER, shader, -2, LABEL_MSG);
            case.expect_no_error("objectLabel");

            clear_object_label(case, glw::GL_SHADER, shader, length);
            case.expect_no_error("objectLabel");

            buffer[0] = FILL;
            let outlen = get_object_label(case, glw::GL_SHADER, shader, &mut buffer, true);
            case.expect_no_error("getObjectLabel");
            expect_empty_label(case, outlen, &buffer);
        }
    }

    {
        case.section("Sync object");
        for length in CLEAR_METHODS {
            object_ptr_label(case, sync, -2, LABEL_MSG);
            case.expect_no_error("objectPtrLabel");

            clear_object_ptr_label(case, sync, length);
            case.expect_no_error("objectPtrLabel");

            buffer[0] = FILL;
            let outlen = get_object_ptr_label(case, sync, &mut buffer, true);
            case.expect_no_error("getObjectPtrLabel");
            expect_empty_label(case, outlen, &buffer);
        }
    }

    delete_shader_and_sync(case, shader, sync);
}

/// The identical check both halves of `SpecifyWithLengthCase` make on the clipped label.
fn expect_clipped_label(case: &mut ApiCase<'_>, outlen: GLsizei, buffer: &[u8]) {
    if outlen != 12 {
        case.fail(format!("'length' was not 12, got {outlen}"), "Got invalid label length");
    } else if c_bytes(buffer) != CLIP_MSG.to_bytes() {
        case.fail(
            format!(
                "Query returned wrong string: expected \"{}\" but got \"{}\"",
                CLIP_MSG.to_string_lossy(),
                label_text(buffer)
            ),
            "Query returned wrong label",
        );
    }
}

/// `SpecifyWithLengthCase::iterate`
fn specify_with_length_case(case: &mut ApiCase<'_>) {
    if !require_khr_debug(case) {
        return;
    }

    let sync = fence_sync(case);
    let shader = create_shader(case);
    let mut buffer = [FILL; 64];

    {
        case.section("Shader object");
        object_label(case, glw::GL_SHADER, shader, 12, LABEL_MSG);
        case.expect_no_error("objectLabel");

        buffer.fill(FILL);
        let outlen = get_object_label(case, glw::GL_SHADER, shader, &mut buffer, true);
        case.expect_no_error("getObjectLabel");
        expect_clipped_label(case, outlen, &buffer);
    }

    {
        case.section("Sync object");
        object_ptr_label(case, sync, 12, LABEL_MSG);
        case.expect_no_error("objectPtrLabel");

        buffer.fill(FILL);
        let outlen = get_object_ptr_label(case, sync, &mut buffer, true);
        case.expect_no_error("getObjectPtrLabel");
        expect_clipped_label(case, outlen, &buffer);
    }

    {
        case.section("ZeroSized");
        object_label(case, glw::GL_SHADER, shader, 0, LABEL_MSG);
        case.expect_no_error("objectLabel");

        buffer.fill(FILL);
        let outlen = get_object_label(case, glw::GL_SHADER, shader, &mut buffer, true);
        case.expect_no_error("getObjectLabel");
        expect_empty_label(case, outlen, &buffer);
    }

    delete_shader_and_sync(case, shader, sync);
}

/// The four `BufferLimitedLabelCase` sub-sections. Upstream writes the shader and the sync
/// half out in full and they differ only in which entry point reads the label back, so this
/// port passes that in: `read` takes the destination buffer (whose length is the `bufSize`
/// upstream passes) and whether to ask for the length, and answers `outlen`.
fn buffer_limited_checks(
    case: &mut ApiCase<'_>,
    entry_point: &str,
    read: &dyn Fn(&mut ApiCase<'_>, &mut [u8], bool) -> GLsizei,
) {
    let mut buffer = [FILL; 64];

    {
        case.section("Query All");
        buffer.fill(FILL);
        let outlen = read(case, &mut buffer[..22], true);
        case.expect_no_error(entry_point);

        if outlen != 21 {
            case.fail(format!("'length' was not 21, got {outlen}"), "Got invalid label length");
        } else if buffer[21] != 0 {
            case.fail(
                "Buffer was not null-terminated".to_string(),
                "Buffer was not null-terminated",
            );
        } else if buffer[22] != FILL {
            case.fail(
                "Query wrote over buffer bound".to_string(),
                "Query wrote over buffer bound",
            );
        } else if c_bytes(&buffer) != LABEL_MSG.to_bytes() {
            case.fail(
                format!("Query returned string: \"{}\"", label_text(&buffer)),
                "Query returned wrong label",
            );
        }
    }
    {
        case.section("Query all without size");
        buffer.fill(FILL);
        read(case, &mut buffer[..22], false);
        case.expect_no_error(entry_point);

        if c_bytes(&buffer).len() != 21 {
            case.fail("Buffer length was not 21".to_string(), "Buffer length was not 21");
        } else if buffer[21] != 0 {
            case.fail(
                "Buffer was not null-terminated".to_string(),
                "Buffer was not null-terminated",
            );
        } else if buffer[22] != FILL {
            case.fail(
                "Query wrote over buffer bound".to_string(),
                "Query wrote over buffer bound",
            );
        } else if c_bytes(&buffer) != LABEL_MSG.to_bytes() {
            case.fail(
                format!("Query returned string: \"{}\"", label_text(&buffer)),
                "Query returned wrong label",
            );
        }
    }
    {
        case.section("Query substring");
        buffer.fill(FILL);
        let outlen = read(case, &mut buffer[..2], true);
        case.expect_no_error(entry_point);

        if outlen != 1 {
            case.fail(format!("'length' was not 1, got {outlen}"), "Got invalid label length");
        } else if buffer[1] != 0 {
            case.fail(
                "Buffer was not null-terminated".to_string(),
                "Buffer was not null-terminated",
            );
        } else if buffer[2] != FILL {
            case.fail(
                "Query wrote over buffer bound".to_string(),
                "Query wrote over buffer bound",
            );
        } else if !LABEL_MSG.to_bytes().starts_with(c_bytes(&buffer)) {
            case.fail(
                format!("Query returned string: \"{}\"", label_text(&buffer)),
                "Query returned wrong label",
            );
        }
    }
    {
        case.section("Query one character");
        buffer.fill(FILL);
        let outlen = read(case, &mut buffer[..1], true);
        case.expect_no_error(entry_point);

        if outlen != 0 {
            case.fail(format!("'length' was not 0, got {outlen}"), "Got invalid label length");
        } else if buffer[0] != 0 {
            case.fail(
                "Buffer was not null-terminated".to_string(),
                "Buffer was not null-terminated",
            );
        } else if buffer[1] != FILL {
            case.fail(
                "Query wrote over buffer bound".to_string(),
                "Query wrote over buffer bound",
            );
        }
    }
}

/// `BufferLimitedLabelCase::iterate`
fn buffer_limited_label_case(case: &mut ApiCase<'_>) {
    if !require_khr_debug(case) {
        return;
    }

    let sync = fence_sync(case);
    let shader = create_shader(case);

    {
        case.section("Shader object");
        object_label(case, glw::GL_SHADER, shader, -1, LABEL_MSG);
        case.expect_no_error("objectLabel");

        buffer_limited_checks(case, "getObjectLabel", &|case, buffer, want_length| {
            get_object_label(case, glw::GL_SHADER, shader, buffer, want_length)
        });
    }

    {
        case.section("Sync object");
        object_ptr_label(case, sync, -1, LABEL_MSG);
        case.expect_no_error("objectPtrLabel");

        buffer_limited_checks(case, "getObjectPtrLabel", &|case, buffer, want_length| {
            get_object_ptr_label(case, sync, buffer, want_length)
        });
    }

    delete_shader_and_sync(case, shader, sync);
}

/// The four identical read-back checks inside `LabelMaxSizeCase::iterate`.
fn check_max_size_readback(case: &mut ApiCase<'_>, outlen: GLsizei, read_buffer: &[u8], max_label_len: GLsizei) {
    let expected = max_label_len - 1;
    if outlen != expected {
        case.fail(
            format!("'length' was not {expected}, got {outlen}"),
            "Got invalid label length",
        );
    } else if read_buffer[expected as usize] != 0 {
        case.fail(
            "Buffer was not null-terminated".to_string(),
            "Buffer was not null-terminated",
        );
    }
}

/// `LabelMaxSizeCase::iterate`
fn label_max_size_case(case: &mut ApiCase<'_>) {
    if !require_khr_debug(case) {
        return;
    }

    let mut max_label_len: GLint = -1;
    // SAFETY: one integer output.
    unsafe { case.gl().get_integerv(glw::GL_MAX_LABEL_LENGTH, &mut max_label_len) };
    case.expect_no_error("GL_MAX_LABEL_LENGTH");

    log::debug!("GL_MAX_LABEL_LENGTH = {max_label_len}");

    if max_label_len < 256 {
        // `throw tcu::TestError`, which is a Fail.
        case.fail(
            "maxLabelLen was less than required (256)".to_string(),
            "maxLabelLen was less than required (256)",
        );
        return;
    }
    if max_label_len > 8192 {
        log::debug!("GL_MAX_LABEL_LENGTH is very large. Application having larger labels is unlikely, skipping test.");
        return;
    }

    let len = max_label_len as usize;
    let sync = fence_sync(case);
    let shader = create_shader(case);

    // Upstream's `buffer`: `maxLabelLen` bytes of 'X' with the last one replaced by NUL,
    // i.e. a C string of `maxLabelLen - 1` characters.
    let label = CString::new(vec![FILL; len - 1]).expect("no interior NUL in a run of 'X'");

    {
        case.section("Shader object");
        let mut read_buffer = vec![FILL; len];

        object_label(case, glw::GL_SHADER, shader, -1, &label);
        case.expect_no_error("objectLabel");

        let outlen = get_object_label(case, glw::GL_SHADER, shader, &mut read_buffer, true);
        case.expect_no_error("getObjectLabel");
        check_max_size_readback(case, outlen, &read_buffer, max_label_len);

        object_label(case, glw::GL_SHADER, shader, max_label_len - 1, &label);
        case.expect_no_error("objectLabel");

        read_buffer[len - 1] = FILL;
        let outlen = get_object_label(case, glw::GL_SHADER, shader, &mut read_buffer, true);
        case.expect_no_error("getObjectLabel");
        check_max_size_readback(case, outlen, &read_buffer, max_label_len);
    }

    {
        case.section("Sync object");
        let mut read_buffer = vec![FILL; len];

        object_ptr_label(case, sync, -1, &label);
        case.expect_no_error("objectPtrLabel");

        let outlen = get_object_ptr_label(case, sync, &mut read_buffer, true);
        case.expect_no_error("getObjectPtrLabel");
        check_max_size_readback(case, outlen, &read_buffer, max_label_len);

        object_ptr_label(case, sync, max_label_len - 1, &label);
        case.expect_no_error("objectPtrLabel");

        read_buffer[len - 1] = FILL;
        let outlen = get_object_ptr_label(case, sync, &mut read_buffer, true);
        case.expect_no_error("getObjectPtrLabel");
        check_max_size_readback(case, outlen, &read_buffer, max_label_len);
    }

    delete_shader_and_sync(case, shader, sync);
}

/// `LabelLengthCase::iterate`
fn label_length_case(case: &mut ApiCase<'_>) {
    if !require_khr_debug(case) {
        return;
    }

    let sync = fence_sync(case);
    let shader = create_shader(case);

    {
        case.section("Shader object");
        let outlen = get_object_label_length(case, glw::GL_SHADER, shader);
        case.expect_no_error("getObjectLabel");
        if outlen != 0 {
            case.fail(format!("'length' was not 0, got {outlen}"), "Got invalid label length");
        }

        object_label(case, glw::GL_SHADER, shader, -1, LABEL_MSG);
        case.expect_no_error("objectLabel");

        let outlen = get_object_label_length(case, glw::GL_SHADER, shader);
        case.expect_no_error("getObjectLabel");
        if outlen != 21 {
            case.fail(format!("'length' was not 21, got {outlen}"), "Got invalid label length");
        }
    }

    {
        case.section("Sync object");
        let outlen = get_object_ptr_label_length(case, sync);
        case.expect_no_error("getObjectPtrLabel");
        if outlen != 0 {
            case.fail(format!("'length' was not 0, got {outlen}"), "Got invalid label length");
        }

        object_ptr_label(case, sync, -1, LABEL_MSG);
        case.expect_no_error("objectPtrLabel");

        let outlen = get_object_ptr_label_length(case, sync);
        case.expect_no_error("getObjectPtrLabel");
        if outlen != 21 {
            case.fail(format!("'length' was not 21, got {outlen}"), "Got invalid label length");
        }
    }

    delete_shader_and_sync(case, shader, sync);
}

/// `LabelCase::iterate`'s object-creation switch.
fn create_labeled_object(case: &mut ApiCase<'_>, identifier: GLenum) -> GLuint {
    let gl = case.gl();
    let mut object: GLuint = 0;

    // SAFETY: each arm creates one object of the matching kind and leaves nothing bound.
    // The bind/unbind pairs are upstream's, and exist because several ES object kinds only
    // come into existence on first bind.
    unsafe {
        match identifier {
            glw::GL_BUFFER => {
                gl.gen_buffers(1, &mut object);
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, object);
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            }
            glw::GL_SHADER => object = gl.create_shader(glw::GL_FRAGMENT_SHADER),
            glw::GL_PROGRAM => object = gl.create_program(),
            glw::GL_QUERY => {
                gl.gen_queries(1, &mut object);
                gl.begin_query(glw::GL_ANY_SAMPLES_PASSED, object); // Create
                gl.end_query(glw::GL_ANY_SAMPLES_PASSED); // Cleanup
            }
            glw::GL_PROGRAM_PIPELINE => {
                gl.gen_program_pipelines(1, &mut object);
                gl.bind_program_pipeline(object); // Create
                gl.bind_program_pipeline(0); // Cleanup
            }
            glw::GL_TRANSFORM_FEEDBACK => {
                gl.gen_transform_feedbacks(1, &mut object);
                gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, object);
                gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, 0);
            }
            glw::GL_SAMPLER => {
                gl.gen_samplers(1, &mut object);
                gl.bind_sampler(0, object);
                gl.bind_sampler(0, 0);
            }
            glw::GL_TEXTURE => {
                gl.gen_textures(1, &mut object);
                gl.bind_texture(glw::GL_TEXTURE_2D, object);
                gl.bind_texture(glw::GL_TEXTURE_2D, 0);
            }
            glw::GL_RENDERBUFFER => {
                gl.gen_renderbuffers(1, &mut object);
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, object);
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
            }
            // `getDefaultFramebuffer()` upstream; every surface this port creates is 0.
            glw::GL_FRAMEBUFFER => {
                gl.gen_framebuffers(1, &mut object);
                gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, object);
                gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0);
            }
            _ => unreachable!("Invalid identifier"),
        }
    }

    object
}

/// `LabelCase::iterate`'s cleanup switch.
fn delete_labeled_object(case: &mut ApiCase<'_>, identifier: GLenum, object: GLuint) {
    let gl = case.gl();
    // SAFETY: `object` was created above by the matching arm and is not used afterwards.
    unsafe {
        match identifier {
            glw::GL_BUFFER => gl.delete_buffers(1, &object),
            glw::GL_SHADER => gl.delete_shader(object),
            glw::GL_PROGRAM => gl.delete_program(object),
            glw::GL_QUERY => gl.delete_queries(1, &object),
            glw::GL_PROGRAM_PIPELINE => gl.delete_program_pipelines(1, &object),
            glw::GL_TRANSFORM_FEEDBACK => gl.delete_transform_feedbacks(1, &object),
            glw::GL_SAMPLER => gl.delete_samplers(1, &object),
            glw::GL_TEXTURE => gl.delete_textures(1, &object),
            glw::GL_RENDERBUFFER => gl.delete_renderbuffers(1, &object),
            glw::GL_FRAMEBUFFER => gl.delete_framebuffers(1, &object),
            _ => unreachable!("Invalid identifier"),
        }
    }
}

/// The verdict both `LabelCase` and `SyncLabelCase` reach from the read-back buffer.
fn check_whole_label(case: &mut ApiCase<'_>, outlen: GLsizei, buffer: &[u8]) {
    if outlen == 0 {
        case.fail(
            "Failed to query debug label from object".to_string(),
            "Failed to query debug label from object",
        );
    } else if c_bytes(buffer) != LABEL_MSG.to_bytes() {
        case.fail(
            format!(
                "Query returned wrong string: expected \"{}\" but got \"{}\"",
                LABEL_MSG.to_string_lossy(),
                label_text(buffer)
            ),
            "Query returned wrong label",
        );
    }
}

/// `LabelCase::iterate`
fn label_case(case: &mut ApiCase<'_>, identifier: GLenum) {
    if !require_khr_debug(case) {
        return;
    }

    let object = create_labeled_object(case, identifier);

    object_label(case, identifier, object, -1, LABEL_MSG);

    let mut buffer = [FILL; 64];
    let outlen = get_object_label(case, identifier, object, &mut buffer, true);
    check_whole_label(case, outlen, &buffer);

    delete_labeled_object(case, identifier, object);
}

/// `SyncLabelCase::iterate`
fn sync_label_case(case: &mut ApiCase<'_>) {
    if !require_khr_debug(case) {
        return;
    }

    let sync = fence_sync(case);

    object_ptr_label(case, sync, -1, LABEL_MSG);

    let mut buffer = [FILL; 64];
    let outlen = get_object_ptr_label(case, sync, &mut buffer, true);
    check_whole_label(case, outlen, &buffer);

    // SAFETY: the sync object is not used afterwards.
    unsafe { case.gl().delete_sync(sync) };
}

/// `cases[]` - the object kinds `LabelCase` covers, in upstream's order.
const LABEL_OBJECTS: [(GLenum, &str); 10] = [
    (glw::GL_BUFFER, "buffer"),
    (glw::GL_SHADER, "shader"),
    (glw::GL_PROGRAM, "program"),
    (glw::GL_QUERY, "query"),
    (glw::GL_PROGRAM_PIPELINE, "program_pipeline"),
    (glw::GL_TRANSFORM_FEEDBACK, "transform_feedback"),
    (glw::GL_SAMPLER, "sampler"),
    (glw::GL_TEXTURE, "texture"),
    (glw::GL_RENDERBUFFER, "renderbuffer"),
    (glw::GL_FRAMEBUFFER, "framebuffer"),
];

/// The `object_labels` sub-group of `DebugTests::init`.
fn object_labels_group() -> TestCaseGroup {
    let mut labels = TestCaseGroup::new("object_labels");

    add_api_case(&mut labels, "initial", initial_label_case);
    add_api_case(&mut labels, "clearing", clear_label_case);
    add_api_case(&mut labels, "specify_with_length", specify_with_length_case);
    add_api_case(&mut labels, "buffer_limited_query", buffer_limited_label_case);
    add_api_case(&mut labels, "max_label_length", label_max_size_case);
    add_api_case(&mut labels, "query_length_only", label_length_case);

    for (identifier, name) in LABEL_OBJECTS {
        add_api_case(&mut labels, name, move |case: &mut ApiCase<'_>| {
            label_case(case, identifier)
        });
    }
    add_api_case(&mut labels, "sync", sync_label_case);

    labels
}

/// `s_debugTypes`, paired with the name `glu::getDebugMessageTypeName` gives it - the
/// message text these cases insert quotes it, so the pairing is the upstream shape.
const DEBUG_TYPES: [(GLenum, &str); 9] = [
    (glw::GL_DEBUG_TYPE_ERROR, "GL_DEBUG_TYPE_ERROR"),
    (
        glw::GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR,
        "GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR",
    ),
    (
        glw::GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR,
        "GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR",
    ),
    (glw::GL_DEBUG_TYPE_PORTABILITY, "GL_DEBUG_TYPE_PORTABILITY"),
    (glw::GL_DEBUG_TYPE_PERFORMANCE, "GL_DEBUG_TYPE_PERFORMANCE"),
    (glw::GL_DEBUG_TYPE_OTHER, "GL_DEBUG_TYPE_OTHER"),
    (glw::GL_DEBUG_TYPE_MARKER, "GL_DEBUG_TYPE_MARKER"),
    (glw::GL_DEBUG_TYPE_PUSH_GROUP, "GL_DEBUG_TYPE_PUSH_GROUP"),
    (glw::GL_DEBUG_TYPE_POP_GROUP, "GL_DEBUG_TYPE_POP_GROUP"),
];

/// `s_debugSeverities`, with `glu::getDebugMessageSeverityName`'s names.
const DEBUG_SEVERITIES: [(GLenum, &str); 4] = [
    (glw::GL_DEBUG_SEVERITY_HIGH, "GL_DEBUG_SEVERITY_HIGH"),
    (glw::GL_DEBUG_SEVERITY_MEDIUM, "GL_DEBUG_SEVERITY_MEDIUM"),
    (glw::GL_DEBUG_SEVERITY_LOW, "GL_DEBUG_SEVERITY_LOW"),
    (glw::GL_DEBUG_SEVERITY_NOTIFICATION, "GL_DEBUG_SEVERITY_NOTIFICATION"),
];

/// `glu::getDebugMessageSourceStr`
fn debug_source_str(value: GLenum) -> String {
    match value {
        glw::GL_DEBUG_SOURCE_API => "GL_DEBUG_SOURCE_API".to_string(),
        glw::GL_DEBUG_SOURCE_WINDOW_SYSTEM => "GL_DEBUG_SOURCE_WINDOW_SYSTEM".to_string(),
        glw::GL_DEBUG_SOURCE_SHADER_COMPILER => "GL_DEBUG_SOURCE_SHADER_COMPILER".to_string(),
        glw::GL_DEBUG_SOURCE_THIRD_PARTY => "GL_DEBUG_SOURCE_THIRD_PARTY".to_string(),
        glw::GL_DEBUG_SOURCE_APPLICATION => "GL_DEBUG_SOURCE_APPLICATION".to_string(),
        glw::GL_DEBUG_SOURCE_OTHER => "GL_DEBUG_SOURCE_OTHER".to_string(),
        glw::GL_DONT_CARE => "GL_DONT_CARE".to_string(),
        other => format!("{other:#x}"),
    }
}

/// `glu::getDebugMessageTypeStr`
fn debug_type_str(value: GLenum) -> String {
    if value == glw::GL_DONT_CARE {
        return "GL_DONT_CARE".to_string();
    }
    DEBUG_TYPES
        .iter()
        .find(|(ty, _)| *ty == value)
        .map_or_else(|| format!("{value:#x}"), |(_, name)| (*name).to_string())
}

/// `glu::getDebugMessageSeverityStr`
fn debug_severity_str(value: GLenum) -> String {
    if value == glw::GL_DONT_CARE {
        return "GL_DONT_CARE".to_string();
    }
    DEBUG_SEVERITIES
        .iter()
        .find(|(sev, _)| *sev == value)
        .map_or_else(|| format!("{value:#x}"), |(_, name)| (*name).to_string())
}

/// `emitMessages`
fn emit_messages(ctx: &mut NegativeTestContext<'_>, source: GLenum) {
    for (ty, type_name) in DEBUG_TYPES {
        for (severity, severity_name) in DEBUG_SEVERITIES {
            let msg = format!("Application generated message with type {type_name} and severity {severity_name}");
            let msg = CString::new(msg).expect("no interior NUL in a generated message");

            // Use severity as ID, guaranteed unique
            // SAFETY: a null-terminated message (hence the `-1` length) with an
            // application/third-party source, which `glDebugMessageInsert` accepts.
            unsafe {
                ctx.gl()
                    .debug_message_insert(source, ty, severity, severity, -1, msg.as_ptr())
            };
            ctx.expect_message(source, ty);
        }
    }
}

/// `application_messages`
fn application_messages(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("Messages with source of GL_DEBUG_SOURCE_APPLICATION");
    emit_messages(ctx, glw::GL_DEBUG_SOURCE_APPLICATION);
    ctx.end_section();
    Ok(())
}

/// `thirdparty_messages`
fn thirdparty_messages(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("Messages with source of GL_DEBUG_SOURCE_THIRD_PARTY");
    emit_messages(ctx, glw::GL_DEBUG_SOURCE_THIRD_PARTY);
    ctx.end_section();
    Ok(())
}

/// `gl.glPushDebugGroup(source, id, -1, message)`
fn push_debug_group(ctx: &mut NegativeTestContext<'_>, source: GLenum, id: GLuint, message: &CStr) {
    // SAFETY: a null-terminated message (hence the `-1` length).
    unsafe { ctx.gl().push_debug_group(source, id, -1, message.as_ptr()) };
}

/// `push_pop_messages`
fn push_pop_messages(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("Push/Pop Debug Group");

    push_debug_group(ctx, glw::GL_DEBUG_SOURCE_APPLICATION, 1, c"Application group 1");
    ctx.expect_message(glw::GL_DEBUG_SOURCE_APPLICATION, glw::GL_DEBUG_TYPE_PUSH_GROUP);
    push_debug_group(ctx, glw::GL_DEBUG_SOURCE_APPLICATION, 2, c"Application group 1-1");
    ctx.expect_message(glw::GL_DEBUG_SOURCE_APPLICATION, glw::GL_DEBUG_TYPE_PUSH_GROUP);
    push_debug_group(ctx, glw::GL_DEBUG_SOURCE_APPLICATION, 3, c"Application group 1-1-1");
    ctx.expect_message(glw::GL_DEBUG_SOURCE_APPLICATION, glw::GL_DEBUG_TYPE_PUSH_GROUP);
    pop_debug_group(ctx);
    ctx.expect_message(glw::GL_DEBUG_SOURCE_APPLICATION, glw::GL_DEBUG_TYPE_POP_GROUP);
    pop_debug_group(ctx);
    ctx.expect_message(glw::GL_DEBUG_SOURCE_APPLICATION, glw::GL_DEBUG_TYPE_POP_GROUP);

    push_debug_group(ctx, glw::GL_DEBUG_SOURCE_APPLICATION, 4, c"Application group 1-2");
    ctx.expect_message(glw::GL_DEBUG_SOURCE_APPLICATION, glw::GL_DEBUG_TYPE_PUSH_GROUP);
    pop_debug_group(ctx);
    ctx.expect_message(glw::GL_DEBUG_SOURCE_APPLICATION, glw::GL_DEBUG_TYPE_POP_GROUP);

    push_debug_group(ctx, glw::GL_DEBUG_SOURCE_THIRD_PARTY, 4, c"3rd Party group 1-3");
    ctx.expect_message(glw::GL_DEBUG_SOURCE_THIRD_PARTY, glw::GL_DEBUG_TYPE_PUSH_GROUP);
    pop_debug_group(ctx);
    ctx.expect_message(glw::GL_DEBUG_SOURCE_THIRD_PARTY, glw::GL_DEBUG_TYPE_POP_GROUP);
    pop_debug_group(ctx);
    ctx.expect_message(glw::GL_DEBUG_SOURCE_APPLICATION, glw::GL_DEBUG_TYPE_POP_GROUP);

    push_debug_group(ctx, glw::GL_DEBUG_SOURCE_THIRD_PARTY, 4, c"3rd Party group 2");
    ctx.expect_message(glw::GL_DEBUG_SOURCE_THIRD_PARTY, glw::GL_DEBUG_TYPE_PUSH_GROUP);
    pop_debug_group(ctx);
    ctx.expect_message(glw::GL_DEBUG_SOURCE_THIRD_PARTY, glw::GL_DEBUG_TYPE_POP_GROUP);

    ctx.end_section();
    Ok(())
}

/// `gl.glPopDebugGroup()`
fn pop_debug_group(ctx: &mut NegativeTestContext<'_>) {
    // SAFETY: every call here pops a group this case pushed.
    unsafe { ctx.gl().pop_debug_group() };
}

/// `getUserMessageFuncs`
static USER_MESSAGE_FUNCS: [FunctionContainer; 3] = [
    FunctionContainer {
        function: application_messages,
        name: "application_messages",
    },
    FunctionContainer {
        function: thirdparty_messages,
        name: "third_party_messages",
    },
    FunctionContainer {
        function: push_pop_messages,
        name: "push_pop_stack",
    },
];

/// `MessageData` - the whole of one debug message, which `GroupCase` checks in full
/// (`negative_test_shared`'s own copy carries only the source/type/text half, because
/// that is all `expectMessage` ever compares).
#[derive(Default)]
struct GroupMessage {
    source: GLenum,
    ty: GLenum,
    id: GLuint,
    severity: GLenum,
    message: String,
}

/// `BaseCase::callbackHandle` for `GroupCase::callback`.
///
/// # Safety
/// `user_param` must be the `*mut GroupMessage` handed to `glDebugMessageCallback`, and
/// the driver must keep its own contract about `message`/`length`.
unsafe extern "C" fn group_callback(
    source: GLenum,
    ty: GLenum,
    id: GLuint,
    severity: GLenum,
    length: GLsizei,
    message: *const glw::GLchar,
    user_param: *const c_void,
) {
    // SAFETY: the caller's contract - this is the pointer passed to
    // `glDebugMessageCallback`, and it outlives every call the driver can make.
    let dst = unsafe { &mut *(user_param as *mut GroupMessage) };
    // SAFETY: the driver promises `length` bytes at `message`, or a null-terminated
    // string when `length` is negative.
    let text = unsafe {
        if message.is_null() {
            String::new()
        } else if length < 0 {
            CStr::from_ptr(message).to_string_lossy().into_owned()
        } else {
            String::from_utf8_lossy(std::slice::from_raw_parts(message.cast::<u8>(), length as usize)).into_owned()
        }
    };

    *dst = GroupMessage {
        source,
        ty,
        id,
        severity,
        message: text,
    };
}

/// `BaseCase::verifyMessage(message, source, type, id, severity)`, over
/// `verifyMessageExists`, `verifyMessageString` and `verifyMessageGroup`.
fn verify_group_message(
    results: &mut ResultCollector,
    message: &GroupMessage,
    source: GLenum,
    ty: GLenum,
    id: GLuint,
    severity: GLenum,
) {
    // `verifyMessageExists`
    if message.source == glw::GL_NONE || message.ty == glw::GL_NONE {
        // `isDebugContext()` is false here - this port never asks for a debug context -
        // so upstream's own downgrade to a warning applies.
        results.add_result(
            TestResult::QualityWarning,
            "Verification accuracy is lacking without a debug context".to_string(),
        );
        return;
    }

    // `verifyMessageString`
    log::debug!("Driver says: \"{}\"", message.message);
    if message.message.is_empty() {
        results.add_result(TestResult::QualityWarning, "Empty message".to_string());
    }

    // `verifyMessageGroup`
    if message.source != source {
        results.add_result(TestResult::Fail, "Incorrect message source".to_string());
        log::warn!(
            "Message source was {} when it should have been {}",
            debug_source_str(message.source),
            debug_source_str(source)
        );
    }
    if message.ty != ty {
        results.add_result(TestResult::Fail, "Incorrect message type".to_string());
        log::warn!(
            "Message type was {} when it should have been {}",
            debug_type_str(message.ty),
            debug_type_str(ty)
        );
    }

    if message.id != id {
        results.add_result(TestResult::Fail, "Incorrect message id".to_string());
        log::warn!("Message id was {} when it should have been {id}", message.id);
    }
    if message.severity != severity {
        results.add_result(TestResult::Fail, "Incorrect message severity".to_string());
        log::warn!(
            "Message severity was {} when it should have been {}",
            debug_severity_str(message.severity),
            debug_severity_str(severity)
        );
    }
}

/// `GroupCase` - push/pop message generation with full message output checking.
struct GroupCase;

impl TestCase for GroupCase {
    fn name(&self) -> &str {
        "push_pop_consistency"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if is_khr_debug_supported(context) {
            Ok(())
        } else {
            Err(TestError::NotSupported("GL_KHR_debug is not supported".to_string()))
        }
    }

    /// `GroupCase::iterate`
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut results = ResultCollector::new("// ERROR: ");
        // Boxed so the address handed to the driver stays put for the whole case.
        let last_message = Box::new(GroupMessage::default());

        // SAFETY: the callback pointer below is handed a `GroupMessage` that outlives
        // every call the driver can make, and is unregistered before this returns.
        unsafe {
            gl.enable(glw::GL_DEBUG_OUTPUT);
            gl.enable(glw::GL_DEBUG_OUTPUT_SYNCHRONOUS);
            // disable all
            gl.debug_message_control(
                glw::GL_DONT_CARE,
                glw::GL_DONT_CARE,
                glw::GL_DONT_CARE,
                0,
                ptr::null(),
                glw::FALSE,
            );
            // enable API errors
            gl.debug_message_control(
                glw::GL_DEBUG_SOURCE_API,
                glw::GL_DEBUG_TYPE_ERROR,
                glw::GL_DONT_CARE,
                0,
                ptr::null(),
                glw::TRUE,
            );
            // enable application messages
            gl.debug_message_control(
                glw::GL_DEBUG_SOURCE_APPLICATION,
                glw::GL_DONT_CARE,
                glw::GL_DONT_CARE,
                0,
                ptr::null(),
                glw::TRUE,
            );
            // enable third party messages
            gl.debug_message_control(
                glw::GL_DEBUG_SOURCE_THIRD_PARTY,
                glw::GL_DONT_CARE,
                glw::GL_DONT_CARE,
                0,
                ptr::null(),
                glw::TRUE,
            );
            gl.debug_message_callback(Some(group_callback), ptr::addr_of!(*last_message).cast());
        }

        for (source, id) in [
            (glw::GL_DEBUG_SOURCE_APPLICATION, 1234),
            (glw::GL_DEBUG_SOURCE_THIRD_PARTY, 4231),
        ] {
            // SAFETY: a null-terminated message (hence the `-1` length), and every push
            // below is popped before the case ends.
            unsafe { gl.push_debug_group(source, id, -1, c"Pushed debug stack".as_ptr()) };
            verify_group_message(
                &mut results,
                &last_message,
                source,
                glw::GL_DEBUG_TYPE_PUSH_GROUP,
                id,
                glw::GL_DEBUG_SEVERITY_NOTIFICATION,
            );
            // SAFETY: as above.
            unsafe { gl.pop_debug_group() };
            verify_group_message(
                &mut results,
                &last_message,
                source,
                glw::GL_DEBUG_TYPE_POP_GROUP,
                id,
                glw::GL_DEBUG_SEVERITY_NOTIFICATION,
            );
        }

        // SAFETY: as above; unregistering is what makes the borrow above end here.
        unsafe {
            gl.debug_message_callback(None, ptr::null());
            gl.disable(glw::GL_DEBUG_OUTPUT_SYNCHRONOUS);
            gl.disable(glw::GL_DEBUG_OUTPUT);
        }

        Ok(results.to_status())
    }
}

// ---------------------------------------------------------------------------------------
// error_filters / error_groups
// ---------------------------------------------------------------------------------------

/// `MessageID` - what uniquely identifies a debug message.
///
/// The field order is upstream's `operator<` (source, then type, then id): the derived
/// `Ord` is what puts `tempMessageIds`/`counts` in the order `std::set`/`std::map` puts
/// them, and `genFilters` indexes the message ids by position, so this order decides
/// which filters a case generates.
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
struct MessageId {
    source: GLenum,
    ty: GLenum,
    id: GLuint,
}

impl fmt::Display for MessageId {
    /// `operator<<(std::ostream&, const MessageID&)`
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(
            f,
            "{}, {}, {}",
            debug_source_str(self.source),
            debug_type_str(self.ty),
            self.id
        )
    }
}

/// `MessageData` - all the information in a single debug message.
#[derive(Clone)]
struct FilterMessage {
    id: MessageId,
    severity: GLenum,
    /// `FilterCase` counts messages and never looks at their text, so nothing reads
    /// this. Kept because upstream's `MessageData` carries it, and dropping it would
    /// make the callback below stop reading the driver's string at all - which is
    /// itself worth exercising.
    #[allow(dead_code)]
    message: String,
}

/// `FilterCase::MessageFilter`
#[derive(Clone)]
struct MessageFilter {
    source: GLenum,
    ty: GLenum,
    severity: GLenum,
    ids: Vec<GLuint>,
    enabled: bool,
}

impl MessageFilter {
    /// `MessageFilter()` - the default constructor, which enables everything.
    fn enable_all() -> Self {
        Self {
            source: glw::GL_DONT_CARE,
            ty: glw::GL_DONT_CARE,
            severity: glw::GL_DONT_CARE,
            ids: Vec::new(),
            enabled: true,
        }
    }
}

/// `FilterCase::m_currentErrors` - what the callback collects, `None` outside a
/// `genMessages` run. A `RefCell` because the driver calls back while the case holds
/// only a shared reference to this, so no `&mut` may exist across a GL call.
#[derive(Default)]
struct MessageSink {
    current: RefCell<Option<Vec<FilterMessage>>>,
}

/// `BaseCase::callbackHandle` for `FilterCase::callback`.
///
/// # Safety
/// `user_param` must be the `*const MessageSink` handed to `glDebugMessageCallback`, and
/// the driver must keep its own contract about `message`/`length`.
unsafe extern "C" fn filter_callback(
    source: GLenum,
    ty: GLenum,
    id: GLuint,
    severity: GLenum,
    length: GLsizei,
    message: *const glw::GLchar,
    user_param: *const c_void,
) {
    // SAFETY: the caller's contract - this is the pointer passed to
    // `glDebugMessageCallback`, and it outlives every call the driver can make.
    let sink = unsafe { &*(user_param as *const MessageSink) };
    // SAFETY: the driver promises `length` bytes at `message`, or a null-terminated
    // string when `length` is negative.
    let text = unsafe {
        if message.is_null() {
            String::new()
        } else if length < 0 {
            CStr::from_ptr(message).to_string_lossy().into_owned()
        } else {
            String::from_utf8_lossy(std::slice::from_raw_parts(message.cast::<u8>(), length as usize)).into_owned()
        }
    };

    if let Some(list) = sink.current.borrow_mut().as_mut() {
        list.push(FilterMessage {
            id: MessageId { source, ty, id },
            severity,
            message: text,
        });
    }
}

/// `BaseCase::VerificationResult`
struct VerificationResult {
    result: TestResult,
    result_message: String,
    log_message: String,
}

/// `BaseCase::verifyMessageCount`
///
/// Nothing requires an implementation to produce the same messages on every run, so this
/// splits them into deterministic and non-deterministic. Only a deterministic message -
/// an application/third-party one, or an API/shader-compiler *error* - can fail the case
/// on a count mismatch; a window-system or "other" message cannot affect it at all. A
/// message that arrived while a filter said it should not, on the other hand, is always
/// a failure. See upstream for the per-type rationale.
fn verify_message_count(
    id: MessageId,
    severity: GLenum,
    ref_count: i32,
    res_count: i32,
    message_enabled: bool,
) -> VerificationResult {
    // This message should not be filtered out
    if message_enabled {
        if res_count != ref_count {
            let is_deterministic = id.source == glw::GL_DEBUG_SOURCE_APPLICATION
                || id.source == glw::GL_DEBUG_SOURCE_THIRD_PARTY
                || ((id.source == glw::GL_DEBUG_SOURCE_API || id.source == glw::GL_DEBUG_SOURCE_SHADER_COMPILER)
                    && id.ty == glw::GL_DEBUG_TYPE_ERROR);

            let can_ignore = id.source == glw::GL_DEBUG_SOURCE_WINDOW_SYSTEM || id.source == glw::GL_DEBUG_SOURCE_OTHER;

            let counts = format!(
                "({id}) with {} (got {res_count}, expected {ref_count})",
                debug_severity_str(severity)
            );

            if is_deterministic {
                if res_count > ref_count {
                    VerificationResult {
                        result: TestResult::Fail,
                        result_message: "Extra instances of a deterministic message were present".to_string(),
                        log_message: format!("Extra instances of message were found: {counts}"),
                    }
                } else {
                    VerificationResult {
                        result: TestResult::Fail,
                        result_message: "Message missing".to_string(),
                        log_message: format!("Instances of message were missing: {counts}"),
                    }
                }
            } else if !can_ignore {
                if res_count > ref_count {
                    VerificationResult {
                        result: TestResult::QualityWarning,
                        result_message: "Extra instances of a message were present".to_string(),
                        log_message: format!(
                            "Extra instances of message were found but the message is non-deterministic(warning): {counts}"
                        ),
                    }
                } else {
                    VerificationResult {
                        result: TestResult::QualityWarning,
                        result_message: "Message missing".to_string(),
                        log_message: format!(
                            "Instances of message were missing but the message is non-deterministic(warning): {counts}"
                        ),
                    }
                }
            } else if res_count > ref_count {
                VerificationResult {
                    result: TestResult::Pass,
                    result_message: String::new(),
                    log_message: format!(
                        "Extra instances of message were found but the message is non-deterministic(ignored): {counts}"
                    ),
                }
            } else {
                VerificationResult {
                    result: TestResult::Pass,
                    result_message: String::new(),
                    log_message: format!(
                        "Instances of message were missing but the message is non-deterministic(ignored): {counts}"
                    ),
                }
            }
        } else {
            // Passed as appropriate
            VerificationResult {
                result: TestResult::Pass,
                result_message: String::new(),
                log_message: format!(
                    "Message was found when expected: ({id}) with {}",
                    debug_severity_str(severity)
                ),
            }
        }
    }
    // Message should be filtered out
    else if res_count == 0 {
        // Filtered out
        VerificationResult {
            result: TestResult::Pass,
            result_message: String::new(),
            log_message: format!(
                "Message was excluded correctly:  ({id}) with {}",
                debug_severity_str(severity)
            ),
        }
    } else if ref_count == 0 {
        // Only present in filtered run (ERROR)
        VerificationResult {
            result: TestResult::Fail,
            result_message: "A message was not filtered out".to_string(),
            log_message: format!(
                "A message was not excluded as it should have been: ({id}) with {}. This message was not present in the reference run",
                debug_severity_str(severity)
            ),
        }
    } else {
        // Present in both runs (ERROR)
        VerificationResult {
            result: TestResult::Fail,
            result_message: "A message was not filtered out".to_string(),
            log_message: format!(
                "A message was not excluded as it should have been: ({id}) with {}",
                debug_severity_str(severity)
            ),
        }
    }
}

/// `FilterCase::MessageMeta`
#[derive(Default, Clone, Copy)]
struct MessageMeta {
    ref_count: i32,
    res_count: i32,
    severity: GLenum,
}

/// The half of upstream's `FilterCase` that is mutable state.
///
/// `TestCase::iterate` takes `&self` in this port, so what upstream keeps in the case
/// object (`m_currentErrors`, `m_results`) lives in the call frame instead. The methods
/// below are `FilterCase`'s, one for one, and `GroupFilterCase` reuses them exactly as
/// upstream's subclass does.
struct FilterRun<'a> {
    context: &'a Context,
    name: &'a str,
    funcs: &'a [negative_test_shared::TestFunc],
    sink: &'a MessageSink,
    results: ResultCollector,
}

impl FilterRun<'_> {
    /// `FilterCase::genMessages`
    fn gen_messages(&mut self, use_log: bool, desc: &str) -> Result<Vec<FilterMessage>, TestError> {
        // `tcu::ScopedLogSection section(log, "message gen", desc)`. `use_log` is
        // upstream's `DebugMessageTestContext(..., enableLog)`: it only decides whether
        // the run narrates itself, never a verdict.
        if use_log {
            log::debug!("message gen: {desc}");
        }

        let mut context = NegativeTestContext::new(self.context, Reporting::Filter);

        *self.sink.current.borrow_mut() = Some(Vec::new());

        let mut error = None;
        for func in self.funcs {
            if let Err(err) = func(&mut context) {
                error = Some(err);
                break;
            }
        }

        self.results.merge(context.results());

        let messages = self.sink.current.borrow_mut().take().unwrap_or_default();

        match error {
            Some(err) => Err(err),
            None => Ok(messages),
        }
    }

    /// `FilterCase::genFilters`
    fn gen_filters(
        &self,
        messages: &[FilterMessage],
        initial: Vec<MessageFilter>,
        seed: u32,
        iterations: i32,
    ) -> Vec<MessageFilter> {
        let mut rng = Random::new(seed ^ de_int32_hash(de_string_hash(self.name) as i32));

        if messages.is_empty() {
            return initial;
        }

        let mut temp_message_ids = BTreeSet::new();
        let mut temp_sources = BTreeSet::new();
        let mut temp_types = BTreeSet::new();
        let mut temp_severities = BTreeSet::new();

        for msg in messages {
            temp_message_ids.insert(msg.id);
            temp_sources.insert(msg.id.source);
            temp_types.insert(msg.id.ty);
            temp_severities.insert(msg.severity);
        }

        // Fetchable by index
        let message_ids: Vec<MessageId> = temp_message_ids.into_iter().collect();
        let sources: Vec<GLenum> = temp_sources.into_iter().collect();
        let types: Vec<GLenum> = temp_types.into_iter().collect();
        let severities: Vec<GLenum> = temp_severities.into_iter().collect();

        let mut filters = initial;

        for _ in 0..iterations {
            // Distribute so that per-message randomization (the default branch) is prevalent
            match rng.get_int(0, 8) {
                0 => {
                    let source = sources[rng.get_int(0, sources.len() as i32 - 1) as usize];
                    let enabled = rng.get_bool();

                    filters.push(MessageFilter {
                        source,
                        ty: glw::GL_DONT_CARE,
                        severity: glw::GL_DONT_CARE,
                        ids: Vec::new(),
                        enabled,
                    });
                }
                1 => {
                    let ty = types[(rng.get_uint32() as usize) % types.len()];
                    let enabled = rng.get_bool();

                    filters.push(MessageFilter {
                        source: glw::GL_DONT_CARE,
                        ty,
                        severity: glw::GL_DONT_CARE,
                        ids: Vec::new(),
                        enabled,
                    });
                }
                2 => {
                    let severity = severities[(rng.get_uint32() as usize) % severities.len()];
                    let enabled = rng.get_bool();

                    filters.push(MessageFilter {
                        source: glw::GL_DONT_CARE,
                        ty: glw::GL_DONT_CARE,
                        severity,
                        ids: Vec::new(),
                        enabled,
                    });
                }
                _ => {
                    let start = rng.get_int(0, message_ids.len() as i32) as usize;

                    for itr in 0..4 {
                        let id = message_ids[(start + itr) % message_ids.len()];
                        let enabled = rng.get_bool();

                        filters.push(MessageFilter {
                            source: id.source,
                            ty: id.ty,
                            severity: glw::GL_DONT_CARE,
                            ids: vec![id.id],
                            enabled,
                        });
                    }
                }
            }
        }

        filters
    }

    /// `FilterCase::applyFilters`
    fn apply_filters(&self, filters: &[MessageFilter]) {
        let gl = self.context.gl();

        for filter in filters {
            if filter.ids.is_empty() {
                log::debug!(
                    "Setting messages with source {}, type {} and severity {} to {}",
                    debug_source_str(filter.source),
                    debug_type_str(filter.ty),
                    debug_severity_str(filter.severity),
                    if filter.enabled { "enabled" } else { "disabled" }
                );
            } else {
                for id in &filter.ids {
                    log::debug!(
                        "Setting message ({}) to {}",
                        MessageId {
                            source: filter.source,
                            ty: filter.ty,
                            id: *id,
                        },
                        if filter.enabled { "enabled" } else { "disabled" }
                    );
                }
            }

            // SAFETY: `ids` is `ids.len()` elements long, and a null pointer is what the
            // entry point wants when the list is empty.
            unsafe {
                gl.debug_message_control(
                    filter.source,
                    filter.ty,
                    filter.severity,
                    filter.ids.len() as GLsizei,
                    if filter.ids.is_empty() {
                        ptr::null()
                    } else {
                        filter.ids.as_ptr()
                    },
                    if filter.enabled { glw::TRUE } else { glw::FALSE },
                );
            }
        }
    }

    /// `FilterCase::isEnabled`
    fn is_enabled(filters: &[MessageFilter], id: MessageId, severity: GLenum) -> bool {
        let mut retval = true;

        for filter in filters {
            if filter.ids.is_empty() {
                if filter.source != glw::GL_DONT_CARE && filter.source != id.source {
                    continue;
                }
                if filter.ty != glw::GL_DONT_CARE && filter.ty != id.ty {
                    continue;
                }
                if filter.severity != glw::GL_DONT_CARE && filter.severity != severity {
                    continue;
                }
            } else {
                debug_assert!(filter.source != glw::GL_DONT_CARE);
                debug_assert!(filter.ty != glw::GL_DONT_CARE);
                debug_assert!(filter.severity == glw::GL_DONT_CARE);

                if filter.source != id.source || filter.ty != id.ty {
                    continue;
                }
                if !filter.ids.contains(&id.id) {
                    continue;
                }
            }

            retval = filter.enabled;
        }

        retval
    }

    /// `FilterCase::verify`
    fn verify(&mut self, ref_messages: &[FilterMessage], res_messages: &[FilterMessage], filters: &[MessageFilter]) {
        // A `BTreeMap` because upstream's `std::map<MessageID, MessageMeta>` is what
        // decides the order the counts are reported and checked in.
        let mut counts: BTreeMap<MessageId, MessageMeta> = BTreeMap::new();

        log::debug!("verification: Verifying");

        // Gather message counts & severities, report severity mismatches if found
        let mut severity_changed = false;
        for (messages, is_ref) in [(ref_messages, true), (res_messages, false)] {
            for msg in messages {
                let meta = counts.entry(msg.id).or_default();

                if meta.severity != glw::GL_NONE && meta.severity != msg.severity {
                    log::warn!(
                        "A message has variable severity between instances: ({}) with severity {} and {}",
                        msg.id,
                        debug_severity_str(meta.severity),
                        debug_severity_str(msg.severity)
                    );
                    severity_changed = true;
                }

                if is_ref {
                    meta.ref_count += 1;
                } else {
                    meta.res_count += 1;
                }
                meta.severity = msg.severity;
            }
        }

        if severity_changed {
            self.results.add_result(
                TestResult::Fail,
                "Message severity changed between instances of the same message".to_string(),
            );
        }

        for (id, meta) in &counts {
            let enabled = Self::is_enabled(filters, *id, meta.severity);
            let result = verify_message_count(*id, meta.severity, meta.ref_count, meta.res_count, enabled);

            log::debug!("{}", result.log_message);

            if result.result != TestResult::Pass {
                self.results.add_result(result.result, result.result_message);
            }
        }
    }
}

/// `isDebugContext()` - this port never asks for a `glu::CONTEXT_DEBUG` context, so the
/// answer is fixed. Upstream downgrades the "no messages at all" verdict to a warning in
/// exactly that case.
const IS_DEBUG_CONTEXT: bool = false;

/// The common prologue of `FilterCase::iterate` and `GroupFilterCase::iterate`.
fn begin_filter_run(context: &Context, sink: &MessageSink) {
    // SAFETY: the callback pointer is a `MessageSink` that outlives every call the driver
    // can make, and `end_filter_run` unregisters it before the case returns.
    unsafe {
        let gl = context.gl();
        gl.enable(glw::GL_DEBUG_OUTPUT);
        gl.enable(glw::GL_DEBUG_OUTPUT_SYNCHRONOUS);
        gl.debug_message_callback(Some(filter_callback), ptr::addr_of!(*sink).cast());
        gl.debug_message_control(
            glw::GL_DONT_CARE,
            glw::GL_DONT_CARE,
            glw::GL_DONT_CARE,
            0,
            ptr::null(),
            glw::TRUE,
        );
    }
}

/// The `catch (...)` epilogue both filter cases share.
fn end_filter_run(context: &Context) {
    // SAFETY: as above; unregistering is what ends the driver's borrow of the sink.
    unsafe {
        let gl = context.gl();
        gl.disable(glw::GL_DEBUG_OUTPUT_SYNCHRONOUS);
        gl.disable(glw::GL_DEBUG_OUTPUT);
        gl.debug_message_callback(None, ptr::null());
    }
}

/// `FilterCase` - `glDebugMessageControl` usage.
struct FilterCase {
    name: String,
    funcs: Vec<negative_test_shared::TestFunc>,
    /// `GroupFilterCase`, which is the same case wrapped in two nested debug groups.
    /// One struct rather than upstream's subclass because the two `iterate`s differ only
    /// in that nesting, and the rest of `FilterCase` is shared verbatim either way.
    use_groups: bool,
}

impl TestCase for FilterCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if is_khr_debug_supported(context) {
            Ok(())
        } else {
            Err(TestError::NotSupported("GL_KHR_debug is not supported".to_string()))
        }
    }

    /// `FilterCase::iterate` / `GroupFilterCase::iterate`
    fn iterate(&self, context: &Context) -> TestOutcome {
        let sink = MessageSink::default();
        let mut run = FilterRun {
            context,
            name: &self.name,
            funcs: &self.funcs,
            sink: &sink,
            results: ResultCollector::new("// ERROR: "),
        };

        begin_filter_run(context, &sink);

        let result = if self.use_groups {
            run.run_with_groups()
        } else {
            run.run_flat()
        };

        end_filter_run(context);

        result?;
        Ok(run.results.to_status())
    }
}

impl FilterRun<'_> {
    /// The body of `FilterCase::iterate`.
    fn run_flat(&mut self) -> Result<(), TestError> {
        let ref_messages = self.gen_messages(true, "Reference run")?;
        let base_filter = MessageFilter::enable_all();
        let base_seed = de_string_hash(self.name) ^ BASE_SEED;
        let filters = self.gen_filters(&ref_messages, vec![base_filter], base_seed, 4);

        self.apply_filters(&filters);

        // Generate errors
        let filtered_messages = self.gen_messages(false, "Filtered run")?;

        // Verify
        self.verify(&ref_messages, &filtered_messages, &filters);

        if !IS_DEBUG_CONTEXT && ref_messages.is_empty() {
            self.results.add_result(
                TestResult::QualityWarning,
                "Verification accuracy is lacking without a debug context".to_string(),
            );
        }

        Ok(())
    }

    /// The body of `GroupFilterCase::iterate`.
    fn run_with_groups(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();

        // Generate reference (all errors)
        let ref_messages = self.gen_messages(true, "Reference run")?;
        let base_seed = de_string_hash(self.name) ^ BASE_SEED;
        let base_filter = MessageFilter::enable_all();
        let filter0 = self.gen_filters(&ref_messages, vec![base_filter], base_seed, 4);

        self.apply_filters(&filter0);

        let mut res_messages0 = self.gen_messages(false, "Filtered run, default debug group")?;

        // Initial verification
        self.verify(&ref_messages, &res_messages0, &filter0);

        {
            // Generate reference (filters inherited from parent)
            let filter1_base = self.gen_filters(&ref_messages, Vec::new(), base_seed ^ 0xDEAD_BEEF, 4);
            let filter1_full = join(&filter0, &filter1_base);
            log::debug!("Pushing Debug Group");

            // SAFETY: a null-terminated name (hence the `-1` length); every push below is
            // popped again before this returns.
            unsafe { gl.push_debug_group(glw::GL_DEBUG_SOURCE_APPLICATION, 1, -1, c"Test Group".as_ptr()) };
            self.apply_filters(&filter1_base);

            // First nested verification
            let mut res_messages1 = self.gen_messages(false, "Filtered run, pushed one debug group")?;
            self.verify(&ref_messages, &res_messages1, &filter1_full);

            {
                // Generate reference (filters iherited again)
                let filter2_base = self.gen_filters(&ref_messages, Vec::new(), base_seed ^ 0x4321_1234, 4);
                let filter2_full = join(&filter1_full, &filter2_base);
                log::debug!("Pushing Debug Group");

                // SAFETY: as above.
                unsafe { gl.push_debug_group(glw::GL_DEBUG_SOURCE_APPLICATION, 1, -1, c"Nested Test Group".as_ptr()) };
                self.apply_filters(&filter2_base);

                // Second nested verification
                let res_messages2 = self.gen_messages(false, "Filtered run, pushed two debug groups")?;
                self.verify(&ref_messages, &res_messages2, &filter2_full);

                // SAFETY: as above.
                unsafe { gl.pop_debug_group() };
            }

            // First restore verification
            res_messages1 = self.gen_messages(false, "Filtered run, popped second debug group")?;
            self.verify(&ref_messages, &res_messages1, &filter1_full);

            // SAFETY: as above.
            unsafe { gl.pop_debug_group() };
        }

        // restore verification
        res_messages0 = self.gen_messages(false, "Filtered run, popped first debug group")?;
        self.verify(&ref_messages, &res_messages0, &filter0);

        if !IS_DEBUG_CONTEXT && ref_messages.is_empty() {
            self.results.add_result(
                TestResult::QualityWarning,
                "Verification accuracy is lacking without a debug context".to_string(),
            );
        }

        Ok(())
    }
}

/// `join`
fn join(a: &[MessageFilter], b: &[MessageFilter]) -> Vec<MessageFilter> {
    let mut retval = Vec::with_capacity(a.len() + b.len());
    retval.extend_from_slice(a);
    retval.extend_from_slice(b);
    retval
}

/// `AsyncCase::MessageCount`
#[derive(Default, Clone, Copy)]
struct MessageCount {
    received: i32,
    expected: i32,
}

/// `AsyncCase::VerifyState`
#[derive(Clone, Copy, PartialEq, Eq)]
enum VerifyState {
    Pass,
    Minimum,
    Fail,
}

/// `AsyncCase::m_counts`, behind `AsyncCase::m_mutex`.
///
/// A `Mutex` rather than the `RefCell` `FilterCase`'s sink uses: this case turns
/// `GL_DEBUG_OUTPUT_SYNCHRONOUS` off for its result run, which is exactly the permission
/// a driver needs to call back from a thread of its own, and is what upstream's
/// `de::Mutex` guards against too.
#[derive(Default)]
struct AsyncSink {
    counts: Mutex<BTreeMap<MessageId, MessageCount>>,
}

impl AsyncSink {
    /// The lock is only ever held for a map update, and nothing between `lock` and
    /// `unlock` can panic, so a poisoned lock cannot mean stale data here.
    fn counts(&self) -> MutexGuard<'_, BTreeMap<MessageId, MessageCount>> {
        self.counts.lock().unwrap_or_else(|poisoned| poisoned.into_inner())
    }
}

/// `BaseCase::callbackHandle` for `AsyncCase::callback`.
///
/// # Safety
/// `user_param` must be the `*const AsyncSink` handed to `glDebugMessageCallback`.
unsafe extern "C" fn async_callback(
    source: GLenum,
    ty: GLenum,
    id: GLuint,
    severity: GLenum,
    length: GLsizei,
    message: *const glw::GLchar,
    user_param: *const c_void,
) {
    let _ = (severity, length, message);

    // SAFETY: the caller's contract - this is the pointer passed to
    // `glDebugMessageCallback`, and it outlives every call the driver can make.
    let sink = unsafe { &*(user_param as *const AsyncSink) };

    sink.counts().entry(MessageId { source, ty, id }).or_default().received += 1;
}

/// `AsyncCase::fetchLogMessages`
///
/// Note that we can never guarantee getting all messages back when using logs/fetching as
/// the GL may create more than its log size limit during an arbitrary period of time.
fn fetch_log_messages(gl: &glw::Functions, sink: &AsyncSink) {
    let mut num_msg = 0;
    // SAFETY: one GLint out.
    unsafe { gl.get_integerv(glw::GL_DEBUG_LOGGED_MESSAGES, &mut num_msg) };

    for _ in 0..num_msg {
        let mut msg_len = 0;
        // SAFETY: one GLint out.
        unsafe { gl.get_integerv(glw::GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH, &mut msg_len) };

        // Upstream's two `TCU_CHECK_MSG`es, which throw out of `expectMessage`. Nothing
        // can unwind out of this port's hook, so a driver answering with nonsense stops
        // the fetch instead and the case fails on the messages it then never counts.
        if !(0..100_000).contains(&msg_len) {
            log::error!("Message length out of range: {msg_len}");
            return;
        }

        let mut buf = vec![0u8; msg_len as usize];
        let mut source = 0;
        let mut ty = 0;
        let mut id = 0;
        let mut severity = 0;
        let mut out_len = msg_len;

        // SAFETY: one message is asked for and the buffer holds the length the driver
        // just reported for it.
        unsafe {
            gl.get_debug_message_log(
                1,
                msg_len,
                &mut source,
                &mut ty,
                &mut id,
                &mut severity,
                &mut out_len,
                buf.as_mut_ptr().cast(),
            );
        }

        sink.counts().entry(MessageId { source, ty, id }).or_default().received += 1;
    }
}

/// `AsyncCase::verify`
fn verify_async(sink: &AsyncSink, uselog: bool) -> VerifyState {
    let mut retval = VerifyState::Pass;
    let counts = sink.counts();

    for (id, count) in counts.iter() {
        let ref_count = count.expected;
        let res_count = count.received;
        let enabled = true;

        let result = verify_message_count(*id, glw::GL_DONT_CARE, ref_count, res_count, enabled);

        if uselog {
            log::debug!("{}", result.log_message);
        }

        if result.result == TestResult::Fail {
            retval = VerifyState::Fail;
        } else if result.result != TestResult::Pass && retval == VerifyState::Pass {
            retval = VerifyState::Minimum;
        }
    }

    retval
}

/// The prologue of `AsyncCase::iterate`, up to the reference run.
fn begin_async_run(gl: &glw::Functions, sink: &AsyncSink, use_callbacks: bool) {
    // SAFETY: the callback pointer is an `AsyncSink` that outlives every call the driver
    // can make, and `end_async_run` unregisters it before the case returns.
    unsafe {
        // Clear log from earlier messages
        let mut num_messages = 0;
        gl.get_integerv(glw::GL_DEBUG_LOGGED_MESSAGES, &mut num_messages);
        gl.get_debug_message_log(
            num_messages as GLuint,
            0,
            ptr::null_mut(),
            ptr::null_mut(),
            ptr::null_mut(),
            ptr::null_mut(),
            ptr::null_mut(),
            ptr::null_mut(),
        );

        gl.enable(glw::GL_DEBUG_OUTPUT);
        gl.enable(glw::GL_DEBUG_OUTPUT_SYNCHRONOUS);
        gl.debug_message_control(
            glw::GL_DONT_CARE,
            glw::GL_DONT_CARE,
            glw::GL_DONT_CARE,
            0,
            ptr::null(),
            glw::FALSE,
        );

        // Some messages could be dependent on the value of DEBUG_OUTPUT_SYNCHRONOUS so only use API errors which should be generated in all cases
        gl.debug_message_control(
            glw::GL_DEBUG_SOURCE_API,
            glw::GL_DEBUG_TYPE_ERROR,
            glw::GL_DONT_CARE,
            0,
            ptr::null(),
            glw::TRUE,
        );

        if use_callbacks {
            // will use log otherwise
            gl.debug_message_callback(Some(async_callback), ptr::addr_of!(*sink).cast());
        } else {
            gl.debug_message_callback(None, ptr::null());
        }
    }
}

/// The epilogue of `AsyncCase::iterate`.
fn end_async_run(gl: &glw::Functions) {
    // SAFETY: as above; unregistering is what ends the driver's borrow of the sink.
    unsafe {
        gl.debug_message_callback(None, ptr::null());
        // Upstream only disables `GL_DEBUG_OUTPUT` here, because the result run has
        // already turned synchronous output off - but its "nothing to verify" early exit
        // never gets that far and leaks the enable into whatever case runs next.
        gl.disable(glw::GL_DEBUG_OUTPUT_SYNCHRONOUS);
        gl.disable(glw::GL_DEBUG_OUTPUT);
    }
}

/// `AsyncCase` - asynchronous debug output.
struct AsyncCase {
    name: String,
    funcs: Vec<negative_test_shared::TestFunc>,
    use_callbacks: bool,
}

impl TestCase for AsyncCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if is_khr_debug_supported(context) {
            Ok(())
        } else {
            Err(TestError::NotSupported("GL_KHR_debug is not supported".to_string()))
        }
    }

    /// `AsyncCase::iterate`
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let sink = AsyncSink::default();
        let mut results = ResultCollector::new("// ERROR: ");

        begin_async_run(gl, &sink, self.use_callbacks);

        // `AsyncCase::expectMessage`. Only the log-fetching half has a body, and it is
        // installed as a hook because the counters belong to the case, not to the
        // negative-test context.
        let fetch = || fetch_log_messages(gl, &sink);
        let mut context_holder = NegativeTestContext::new(context, Reporting::Async);
        if !self.use_callbacks {
            context_holder.set_expect_message_hook(&fetch);
        }

        let result = self.run(gl, &sink, &mut context_holder, &mut results);

        results.merge(context_holder.results());
        end_async_run(gl);

        result?;
        Ok(results.to_status())
    }
}

impl AsyncCase {
    /// The body of `AsyncCase::iterate`, split out so `iterate` unregisters the callback
    /// and folds the context's results back on every path out, an error included.
    fn run(
        &self,
        gl: &glw::Functions,
        sink: &AsyncSink,
        context: &mut NegativeTestContext<'_>,
        results: &mut ResultCollector,
    ) -> Result<(), TestError> {
        const MAX_WAIT: i32 = 10000; // ms
        const WARN_WAIT: i32 = 100;

        // Reference run (synchronous)
        {
            log::debug!("reference run: Reference run (synchronous)");

            for func in &self.funcs {
                func(context)?;
            }
        }

        if sink.counts().is_empty() {
            if !IS_DEBUG_CONTEXT {
                results.add_result(
                    TestResult::QualityWarning,
                    "Need debug context to guarantee implementation behaviour (see command line options)".to_string(),
                );
            }

            log::debug!("Reference run produced no messages, nothing to verify");
            return Ok(());
        }

        for count in sink.counts().values_mut() {
            count.expected = count.received;
            count.received = 0;
        }

        // SAFETY: a plain enable/disable pair.
        unsafe { gl.disable(glw::GL_DEBUG_OUTPUT_SYNCHRONOUS) };

        // Result run (async)
        for func in &self.funcs {
            func(context)?;
        }

        // Repatedly try verification, new results may be added to m_receivedMessages at any time
        {
            log::debug!("result run: Result run (asynchronous)");
            let mut last_timely_state = VerifyState::Fail;
            let mut waited = 0;

            loop {
                let pass = verify_async(sink, false);
                let wait = 50.max(waited >> 2);

                // Pass (possibly due to time limit)
                if pass == VerifyState::Pass || (pass == VerifyState::Minimum && waited >= MAX_WAIT) {
                    verify_async(sink, true); // log

                    // State changed late
                    if waited >= WARN_WAIT && last_timely_state != pass {
                        results.add_result(
                            TestResult::QualityWarning,
                            "Async messages were returned to application somewhat slowly".to_string(),
                        );
                    }

                    log::debug!("Passed after ~{waited}ms of waiting");
                    break;
                }
                // fail
                else if waited >= MAX_WAIT {
                    verify_async(sink, true); // log

                    log::debug!("Waited for ~{waited}ms without getting all expected messages");
                    results.add_result(
                        TestResult::Fail,
                        "Async messages were not returned to application within a reasonable timeframe".to_string(),
                    );
                    break;
                }

                if waited < WARN_WAIT {
                    last_timely_state = pass;
                }

                std::thread::sleep(Duration::from_millis(wait as u64));
                waited += wait;

                if !self.use_callbacks {
                    fetch_log_messages(gl, sink);
                }
            }
        }

        Ok(())
    }
}

/// `m_testCtx.getCommandLine().getBaseSeed()` - deqp's `--deqp-base-seed`, which defaults
/// to 0 and which this port has no option for. It is XORed into every seed below, so it
/// has to be written down for the generated filters to match upstream's.
const BASE_SEED: u32 = 0;

/// `allFuncs` - the buffer, texture and user-message functions, shuffled once with
/// `de::Random(0x53941903 ^ baseSeed)`. `error_filters`, `error_groups` and `async` all
/// slice this one shuffled list, so which functions a `case_N` runs depends on the order
/// of `FUNCTIONS` in the two negative-test modules as much as on the shuffle.
fn shuffled_error_funcs() -> Vec<negative_test_shared::TestFunc> {
    let mut rng = Random::new(0x5394_1903 ^ BASE_SEED);
    let mut all_funcs: Vec<negative_test_shared::TestFunc> = negative_buffer_api_tests::FUNCTIONS
        .iter()
        .chain(negative_texture_api_tests::FUNCTIONS.iter())
        .chain(USER_MESSAGE_FUNCS.iter())
        .map(|container| container.function)
        .collect();

    rng.shuffle(&mut all_funcs);
    all_funcs
}

/// One `case_N` of `error_filters` or `error_groups`: four functions off the shuffled
/// list, plus one user-message function, which produce lots of different message types.
fn filter_case_funcs(
    all_funcs: &[negative_test_shared::TestFunc],
    case_ndx: usize,
    error_funcs_per_case: usize,
) -> Vec<negative_test_shared::TestFunc> {
    let start = case_ndx * error_funcs_per_case;
    let end = ((case_ndx + 1) * error_funcs_per_case).min(all_funcs.len());
    let mut funcs = all_funcs[start..end].to_vec();

    // These produce lots of different message types, thus always include at least one when testing filtering
    funcs.push(USER_MESSAGE_FUNCS[case_ndx % USER_MESSAGE_FUNCS.len()].function);
    funcs
}

/// The `error_filters` sub-group of `DebugTests::init`.
fn error_filters_group(all_funcs: &[negative_test_shared::TestFunc]) -> TestCaseGroup {
    let mut filtering = TestCaseGroup::new("error_filters");
    const ERROR_FUNCS_PER_CASE: usize = 4;
    const MAX_FILTERING_CASE_COUNT: usize = 32;
    let case_count = all_funcs.len().div_ceil(ERROR_FUNCS_PER_CASE);

    for case_ndx in 0..case_count.min(MAX_FILTERING_CASE_COUNT) {
        filtering.add_child(Box::new(FilterCase {
            name: format!("case_{case_ndx}"),
            funcs: filter_case_funcs(all_funcs, case_ndx, ERROR_FUNCS_PER_CASE),
            use_groups: false,
        }) as Box<dyn TestCase>);
    }

    filtering
}

/// The `error_groups` sub-group of `DebugTests::init`.
fn error_groups_group(all_funcs: &[negative_test_shared::TestFunc]) -> TestCaseGroup {
    let mut groups = TestCaseGroup::new("error_groups");
    const ERROR_FUNCS_PER_CASE: usize = 4;
    const MAX_FILTERING_CASE_COUNT: usize = 16;
    let case_count = all_funcs.len().div_ceil(ERROR_FUNCS_PER_CASE);

    for case_ndx in 0..case_count.min(MAX_FILTERING_CASE_COUNT) {
        groups.add_child(Box::new(FilterCase {
            name: format!("case_{case_ndx}"),
            funcs: filter_case_funcs(all_funcs, case_ndx, ERROR_FUNCS_PER_CASE),
            use_groups: true,
        }) as Box<dyn TestCase>);
    }

    groups
}

/// The `async` sub-group of `DebugTests::init`.
///
/// Two functions per case and no user-message function appended, unlike the two filtering
/// groups above: these count what the driver reports, so a case wants only messages the
/// driver itself generates.
fn async_group(all_funcs: &[negative_test_shared::TestFunc]) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("async");
    const ERROR_FUNCS_PER_CASE: usize = 2;
    const MAX_ASYNC_CASE_COUNT: usize = 16;
    let case_count = all_funcs.len().div_ceil(ERROR_FUNCS_PER_CASE);

    for case_ndx in 0..case_count.min(MAX_ASYNC_CASE_COUNT) {
        let start = case_ndx * ERROR_FUNCS_PER_CASE;
        let end = ((case_ndx + 1) * ERROR_FUNCS_PER_CASE).min(all_funcs.len());
        let use_callbacks = case_ndx & 0x1 != 0;

        group.add_child(Box::new(AsyncCase {
            name: format!("case_{case_ndx}{}", if use_callbacks { "_callback" } else { "_log" }),
            funcs: all_funcs[start..end].to_vec(),
            use_callbacks,
        }) as Box<dyn TestCase>);
    }

    group
}

/// The `externally_generated` sub-group of `DebugTests::init`.
fn externally_generated_group() -> TestCaseGroup {
    let mut host = create_child_cases(Reporting::Callback, "externally_generated", &USER_MESSAGE_FUNCS);
    host.add_child(Box::new(GroupCase) as Box<dyn TestCase>);
    host
}

/// `DebugTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("debug");

    group.add_child(state_query_group());

    let mut negative = TestCaseGroup::new("negative_coverage");
    negative.add_child(host_group(Reporting::Callback, "callbacks"));
    negative.add_child(host_group(Reporting::Log, "log"));
    negative.add_child(host_group(Reporting::GetError, "get_error"));
    group.add_child(negative);

    group.add_child(externally_generated_group());

    {
        let all_funcs = shuffled_error_funcs();

        group.add_child(error_filters_group(&all_funcs));
        group.add_child(error_groups_group(&all_funcs));
        group.add_child(async_group(&all_funcs));
    }

    group.add_child(object_labels_group());
    group
}
