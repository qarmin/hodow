// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fDebugMarkerTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `GL_EXT_debug_marker` is a Khronos "hint" extension - `glPushGroupMarkerEXT`/
// `glPopGroupMarkerEXT`/`glInsertEventMarkerEXT` carry no observable GL state at all, only a
// promise that they never raise an error, however they are called. That is genuinely all
// three cases check: `supported` that the extension string is present, `random` and
// `invalid` that a few thousand combined calls (fuzzed arguments, then a fixed set of
// edge cases - negative length, null pointer, both) leave `glGetError()` at `GL_NO_ERROR`.
// Upstream's own Android-mandatory branch of `checkSupport` (`TCU_THROW(TestError, ...)`
// instead of `NotSupportedError` when `DE_OS == DE_OS_ANDROID`) is not ported - this binary
// never runs as the Android CTS, so the plain "not supported" case is the only one that can
// ever apply here.

use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};

fn check_support(context: &Context) -> Result<(), TestError> {
    if !context.context_info.is_extension_supported("GL_EXT_debug_marker") {
        return Err(TestError::NotSupported(
            "GL_EXT_debug_marker is not supported".to_string(),
        ));
    }
    Ok(())
}

struct IsSupportedCase;

impl TestCase for IsSupportedCase {
    fn name(&self) -> &str {
        "supported"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_support(context)?;
        Ok(TestStatus::pass("GL_EXT_debug_marker is supported"))
    }
}

/// `CallType`
#[derive(Clone, Copy)]
enum CallType {
    PushGroup,
    PopGroup,
    InsertMarker,
}

const SIMPLE_CHARS: &[u8] = b"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ -_";

/// `getSimpleRndString`
fn get_simple_rnd_string(rnd: &mut Random, max_len: i32) -> Vec<u8> {
    let len = rnd.get_int(0, max_len);
    (0..len).map(|_| *rnd.choose(SIMPLE_CHARS)).collect()
}

/// `getComplexRndString` - arbitrary bytes, including embedded NULs and non-ASCII, since
/// the extension promises no error regardless of content as long as `length` is honest.
fn get_complex_rnd_string(rnd: &mut Random, max_len: i32) -> Vec<u8> {
    let len = rnd.get_int(0, max_len);
    (0..len).map(|_| rnd.get_uint8()).collect()
}

struct RandomCase;

impl TestCase for RandomCase {
    fn name(&self) -> &str {
        "random"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_support(context)?;

        let gl = context.gl();
        const NUM_ITERS: i32 = 1000;
        const MAX_MSG_LEN: i32 = 4096;
        let mut rnd = Random::new(0xaf829c0);

        for _ in 0..NUM_ITERS {
            let call_type = *rnd.choose(&[CallType::PushGroup, CallType::PopGroup, CallType::InsertMarker]);

            match call_type {
                CallType::PushGroup | CallType::InsertMarker => {
                    let null_terminate = rnd.get_bool();
                    let pass_length = rnd.get_bool();
                    let complex_msg = rnd.get_bool();
                    let mut message = if complex_msg {
                        get_complex_rnd_string(&mut rnd, MAX_MSG_LEN)
                    } else {
                        get_simple_rnd_string(&mut rnd, MAX_MSG_LEN)
                    };

                    // "If <length> is 0 then <marker> is assumed to be null-terminated."
                    if null_terminate || !pass_length {
                        message.push(0);
                    }

                    let length = if pass_length {
                        (if null_terminate {
                            message.len() - 1
                        } else {
                            message.len()
                        }) as i32
                    } else {
                        0
                    };

                    // SAFETY: `message` holds `length` valid bytes (plus, when
                    // `null_terminate`, one trailing NUL past it), matching what
                    // `glPushGroupMarkerEXT`/`glInsertEventMarkerEXT` are told through `length`.
                    unsafe {
                        if matches!(call_type, CallType::PushGroup) {
                            gl.push_group_marker_ext(length, message.as_ptr().cast());
                        } else {
                            gl.insert_event_marker_ext(length, message.as_ptr().cast());
                        }
                    }
                }
                CallType::PopGroup => {
                    // SAFETY: takes no pointer argument.
                    unsafe { gl.pop_group_marker_ext() };
                }
            }
        }

        // SAFETY: reads the error state only.
        let error = unsafe { gl.get_error() };
        if error != crate::glw::GL_NO_ERROR {
            return Ok(TestStatus::fail(format!(
                "Debug marker calls must not set error state (got {error:#x})"
            )));
        }

        Ok(TestStatus::pass("All calls passed"))
    }
}

struct InvalidCase;

impl TestCase for InvalidCase {
    fn name(&self) -> &str {
        "invalid"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_support(context)?;

        let gl = context.gl();
        log::info!("Note: GL_EXT_debug_marker calls must not report an error even if invalid arguments are supplied.");

        // SAFETY: `c"foo".as_ptr()` is a valid, NUL-terminated pointer for every call that
        // reads it at all (a negative length falls back to strlen-style null-termination,
        // per the extension's own spec quoted above); the `null()` calls are exactly what
        // upstream itself passes for the "no pointer" cases.
        unsafe {
            gl.push_group_marker_ext(-1, c"foo".as_ptr());
            gl.insert_event_marker_ext(-1, c"foo".as_ptr());
            gl.push_group_marker_ext(0, std::ptr::null());
            gl.insert_event_marker_ext(0, std::ptr::null());
            gl.push_group_marker_ext(-1, std::ptr::null());
            gl.insert_event_marker_ext(-1, std::ptr::null());
        }

        // SAFETY: reads the error state only.
        let error = unsafe { gl.get_error() };
        if error != crate::glw::GL_NO_ERROR {
            return Ok(TestStatus::fail(format!(
                "Debug marker calls must not set error state (got {error:#x})"
            )));
        }

        Ok(TestStatus::pass("All calls passed"))
    }
}

/// `createDebugMarkerTests`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("debug_marker");
    group.add_child(Box::new(IsSupportedCase) as Box<dyn TestCase>);
    group.add_child(Box::new(RandomCase) as Box<dyn TestCase>);
    group.add_child(Box::new(InvalidCase) as Box<dyn TestCase>);
    group
}
