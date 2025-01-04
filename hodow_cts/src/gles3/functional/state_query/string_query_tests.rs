// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fStringQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The ES-only port always takes upstream's `isES` branch: the reference prefixes are
// "OpenGL ES 3." and "OpenGL ES GLSL ES ", and `GL_EXTENSIONS` is never the
// deprecated-on-desktop null.

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

/// Parses `<prefix>major.minor`, returning `(major, minor)`.
///
/// Upstream reads it through an `istringstream` and fails if the stream ends up in a
/// bad state; the tokens it consumes are exactly the ones skipped here.
fn parse_version_string(case: &mut ApiCase<'_>, string: &str, prefix: &str, skip_tokens: usize) -> Option<(u32, u32)> {
    if !string.starts_with(prefix) {
        case.fail(
            format!("{string:?} does not start with {prefix:?}"),
            "Got invalid string prefix",
        );
        return None;
    }

    let mut tokens = string.split_whitespace().skip(skip_tokens);
    let version = match tokens.next() {
        Some(version) => version,
        None => {
            case.fail(format!("{string:?} has no version number"), "Got invalid string format");
            return None;
        }
    };

    // The number is `major.minor`, and anything may follow the minor digits (vendor
    // detail), which is why the minor part is parsed up to the first non-digit.
    let Some((major, rest)) = version.split_once('.') else {
        case.fail(
            format!("{version:?} has no version delimiter"),
            "Got invalid string format",
        );
        return None;
    };
    let minor: String = rest.chars().take_while(char::is_ascii_digit).collect();

    match (major.parse::<u32>(), minor.parse::<u32>()) {
        (Ok(major), Ok(minor)) => Some((major, minor)),
        _ => {
            case.fail(format!("{version:?} is not major.minor"), "Got invalid string format");
            None
        }
    }
}

fn version(case: &mut ApiCase<'_>) {
    let Some(string) = get_string(case, glw::GL_VERSION) else {
        return;
    };
    log::info!("{string}");
    // "OpenGL ES 3.y ..." - two tokens before the number.
    let Some((_, minor)) = parse_version_string(case, &string, "OpenGL ES 3.", 2) else {
        return;
    };

    let state_minor = case.get_int(glw::GL_MINOR_VERSION);
    if minor != state_minor as u32 {
        case.fail(
            format!("MINOR_VERSION is {state_minor}; string says {minor}"),
            "Got invalid version.",
        );
    }
}

fn shading_language_version(case: &mut ApiCase<'_>) {
    let Some(string) = get_string(case, glw::GL_SHADING_LANGUAGE_VERSION) else {
        return;
    };
    log::info!("{string}");
    // "OpenGL ES GLSL ES x.y ..." - four tokens before the number. Upstream also
    // insists on *two* minor digits here, unlike GL_VERSION's one.
    let Some(version) = string.split_whitespace().nth(4) else {
        case.fail(format!("{string:?} has no version number"), "Got invalid string format");
        return;
    };
    if parse_version_string(case, &string, "OpenGL ES GLSL ES ", 4).is_none() {
        return;
    }
    let minor_digits: String = version.chars().skip_while(|c| *c != '.').skip(1).take(2).collect();
    if minor_digits.len() != 2 || !minor_digits.chars().all(|c| c.is_ascii_digit()) {
        case.fail(
            format!("{version:?} minor version is not two digits"),
            "Got invalid string format",
        );
    }
}

/// `for (;;) { if (std::getline(stream, s, delim)) push(s); else break; }`
///
/// Not `split(delim)`: `getline` fails only when it extracts nothing *and* hits EOF, so
/// a string ending in one delimiter yields no trailing empty entry while one ending in
/// two does. Mesa's `GL_EXTENSIONS` string ends in a space, and counting that as an
/// extension made the count disagree with `GL_NUM_EXTENSIONS` by exactly one - the whole
/// difference between this case passing and failing.
fn split_like_getline(s: &str, delim: char) -> Vec<String> {
    let mut out = Vec::new();
    let mut rest = s;

    while !rest.is_empty() {
        match rest.find(delim) {
            Some(at) => {
                out.push(rest[..at].to_string());
                rest = &rest[at + delim.len_utf8()..];
            }
            None => {
                out.push(rest.to_string());
                break;
            }
        }
    }

    out
}

fn extensions(case: &mut ApiCase<'_>) {
    let Some(string) = get_string(case, glw::GL_EXTENSIONS) else {
        return;
    };

    let mut listed = split_like_getline(&string, ' ');
    for extension in &listed {
        log::info!("{extension}");
    }

    let gl = case.gl();
    let mut num_extensions = 0;
    // SAFETY: one GLint out.
    unsafe { gl.get_integerv(glw::GL_NUM_EXTENSIONS, &mut num_extensions) };
    case.expect_error(glw::GL_NO_ERROR);

    if listed.len() != num_extensions as usize {
        case.fail(
            format!("NUM_EXTENSIONS is {num_extensions}; got {} extensions", listed.len()),
            "Got non-consistent number of extensions",
        );
    }

    let mut indexed = Vec::with_capacity(num_extensions.max(0) as usize);
    for index in 0..num_extensions.max(0) {
        // SAFETY: index is below GL_NUM_EXTENSIONS, so the driver owns a string there.
        let ptr = unsafe { gl.get_stringi(glw::GL_EXTENSIONS, index as u32) };
        if ptr.is_null() {
            case.fail(
                format!("glGetStringi(GL_EXTENSIONS, {index}) returned null"),
                "Got invalid string",
            );
            return;
        }
        // SAFETY: non-null, driver-owned for the context's lifetime.
        indexed.push(unsafe { glw::string_from(ptr) });
    }

    // Everything GetStringi reports must be in GetString.
    for extension in &indexed {
        if !listed.iter().any(|listed| listed == extension) {
            case.fail(
                format!("extension {extension} found with GetStringi was not found in glGetString(GL_EXTENSIONS)"),
                "Extension query methods are not consistent.",
            );
        }
    }

    // And nothing else may be in GetString.
    for extension in &indexed {
        if let Some(pos) = listed.iter().position(|listed| listed == extension) {
            listed.remove(pos);
        }
    }

    if !listed.is_empty() {
        for extension in &listed {
            log::warn!(
                "// ERROR: extension \"{extension}\" found with GetString was not found with GetStringi(GL_EXTENSIONS, ind)"
            );
        }
        case.fail(
            "extension lists differ".to_string(),
            "Extension query methods are not consistent.",
        );
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
