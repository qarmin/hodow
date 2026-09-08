// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fStringQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The version strings have a format the specification mandates, and the two cases
// that check it are worth more than they look: a driver whose `GL_VERSION` does not
// start with "OpenGL ES " or whose version number will not parse breaks every tool
// that keys off it, this one included.

use crate::glu::{ApiCase, ApiCaseFn, TestCaseGroup, add_api_cases};
use crate::glw::{self, GLenum};

/// Reads one of the driver's strings, or `None` when it answered null.
fn get_string(case: &mut ApiCase<'_>, name: GLenum) -> Option<String> {
    let gl = case.gl();
    // SAFETY: glGetString returns a driver-owned null-terminated string, or null.
    let ptr = unsafe { gl.get_string(name) };
    if ptr.is_null() {
        case.fail(format!("glGetString({name:#x}) returned null"), "Got invalid string");
        return None;
    }
    // SAFETY: the pointer is non-null and the driver owns the string for the lifetime
    // of the context.
    Some(unsafe { glw::string_from(ptr) })
}

fn renderer(case: &mut ApiCase<'_>) {
    if let Some(string) = get_string(case, glw::GL_RENDERER) {
        log::info!("{string}");
    }
}

fn vendor(case: &mut ApiCase<'_>) {
    if let Some(string) = get_string(case, glw::GL_VENDOR) {
        log::info!("{string}");
    }
}

/// Parses `<prefix>major.minor`, which is what both version strings must start with.
///
/// Upstream reads it through an `istringstream` and fails if the stream ends up in a
/// bad state; the tokens it consumes are exactly the ones skipped here.
fn check_version_string(case: &mut ApiCase<'_>, string: &str, prefix: &str, skip_tokens: usize) {
    if !string.starts_with(prefix) {
        case.fail(format!("{string:?} does not start with {prefix:?}"), "Got invalid string prefix");
        return;
    }

    let mut tokens = string.split_whitespace().skip(skip_tokens);
    let Some(version) = tokens.next() else {
        case.fail(format!("{string:?} has no version number"), "Got invalid string format");
        return;
    };

    // The number is `major.minor`, and anything may follow the minor digits (vendor
    // detail), which is why the minor part is parsed up to the first non-digit.
    let Some((major, rest)) = version.split_once('.') else {
        case.fail(format!("{version:?} has no version delimiter"), "Got invalid string format");
        return;
    };
    let minor: String = rest.chars().take_while(char::is_ascii_digit).collect();

    if major.parse::<u32>().is_err() || minor.is_empty() || minor.parse::<u32>().is_err() {
        case.fail(format!("{version:?} is not major.minor"), "Got invalid string format");
    }
}

fn version(case: &mut ApiCase<'_>) {
    let Some(string) = get_string(case, glw::GL_VERSION) else {
        return;
    };
    log::info!("{string}");
    // "OpenGL ES x.y ..." - two tokens before the number.
    check_version_string(case, &string, "OpenGL ES ", 2);
}

fn shading_language_version(case: &mut ApiCase<'_>) {
    let Some(string) = get_string(case, glw::GL_SHADING_LANGUAGE_VERSION) else {
        return;
    };
    log::info!("{string}");
    // "OpenGL ES GLSL ES x.y ..." - four tokens before the number.
    check_version_string(case, &string, "OpenGL ES GLSL ES ", 4);
}

fn extensions(case: &mut ApiCase<'_>) {
    if let Some(string) = get_string(case, glw::GL_EXTENSIONS) {
        for extension in string.split_whitespace() {
            log::info!("{extension}");
        }
    }
}

/// `StringQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("string");
    let cases: &[(&'static str, ApiCaseFn)] = &[
        ("renderer", renderer),
        ("vendor", vendor),
        ("version", version),
        ("shading_language_version", shading_language_version),
        ("extensions", extensions),
    ];
    add_api_cases(&mut group, cases);
    group
}
