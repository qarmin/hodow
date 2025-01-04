// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fBufferObjectQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Two verifiers as one enum, as in
// the GLES2 `boolean`/`integers` groups.

use crate::gls::state_query_util::Guarded;
use crate::glu::{ApiCase, TestCaseGroup, add_api_case};
use crate::glw::{self, GLenum};
use crate::tcu::Random;

#[derive(Clone, Copy, PartialEq, Eq)]
enum Verifier {
    GetBufferParameterI,
    GetBufferParameterI64,
}

const VERIFIERS: [Verifier; 2] = [Verifier::GetBufferParameterI, Verifier::GetBufferParameterI64];

impl Verifier {
    fn postfix(self) -> &'static str {
        match self {
            Self::GetBufferParameterI => "_getbufferparameteri",
            Self::GetBufferParameterI64 => "_getbufferparameteri64",
        }
    }

    /// `verifyInteger`
    fn verify_integer(self, case: &mut ApiCase<'_>, target: GLenum, name: GLenum, reference: i32) {
        self.verify_integer64(case, target, name, i64::from(reference));
    }

    /// `verifyInteger64` - the 32-bit verifier skips a reference outside GLint's
    /// range, since the converted value would say nothing.
    fn verify_integer64(self, case: &mut ApiCase<'_>, target: GLenum, name: GLenum, reference: i64) {
        let gl = case.gl();
        match self {
            Self::GetBufferParameterI => {
                let mut state = Guarded::<i32>::new();
                // SAFETY: one GLint out, guarded on both sides; a buffer is bound.
                unsafe { gl.get_buffer_parameteriv(target, name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                if !(i64::from(i32::MIN)..=i64::from(i32::MAX)).contains(&reference) {
                    return;
                }
                if i64::from(state.value()) != reference {
                    case.fail(
                        format!("expected {reference}; got {}", state.value()),
                        "Got invalid value",
                    );
                }
            }
            Self::GetBufferParameterI64 => {
                let mut state = Guarded::<i64>::new();
                // SAFETY: one GLint64 out, guarded on both sides; a buffer is bound.
                unsafe { gl.get_buffer_parameteri_64v(target, name, state.as_mut_ptr()) };
                if !state.verify_validity(case) {
                    return;
                }
                if state.value() != reference {
                    case.fail(
                        format!("expected {reference}; got {}", state.value()),
                        "Got invalid value",
                    );
                }
            }
        }
    }
}

/// `BufferCase::test` - the first four targets only, unless the case asks for all
/// eight (`m_testAllTargets`).
const BUFFER_TARGETS: [GLenum; 8] = [
    glw::GL_ARRAY_BUFFER,
    glw::GL_COPY_READ_BUFFER,
    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
    glw::GL_UNIFORM_BUFFER,
    glw::GL_COPY_WRITE_BUFFER,
    glw::GL_ELEMENT_ARRAY_BUFFER,
    glw::GL_PIXEL_PACK_BUFFER,
    glw::GL_PIXEL_UNPACK_BUFFER,
];

fn for_each_buffer_target(
    case: &mut ApiCase<'_>,
    test_all_targets: bool,
    mut body: impl FnMut(&mut ApiCase<'_>, GLenum),
) {
    let targets = if test_all_targets { BUFFER_TARGETS.len() } else { 4 };
    for target in BUFFER_TARGETS.into_iter().take(targets) {
        let gl = case.gl();
        let mut buffer = 0;
        // SAFETY: the name is this case's own and is deleted below.
        unsafe {
            gl.gen_buffers(1, &mut buffer);
            gl.bind_buffer(target, buffer);
        }
        case.expect_error(glw::GL_NO_ERROR);

        body(case, target);

        // SAFETY: as above.
        unsafe { gl.delete_buffers(1, &buffer) };
        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `BufferSizeCase`
fn buffer_size(case: &mut ApiCase<'_>, verifier: Verifier) {
    for_each_buffer_target(case, true, |case, target| {
        let gl = case.gl();
        let mut rnd = Random::new(0x00ab_cdef);

        verifier.verify_integer64(case, target, glw::GL_BUFFER_SIZE, 0);

        for _ in 0..16 {
            let len = rnd.get_int(0, 1024);
            // SAFETY: a null data pointer with a non-negative size only allocates.
            unsafe { gl.buffer_data(target, len as isize, std::ptr::null(), glw::GL_STREAM_DRAW) };
            case.expect_error(glw::GL_NO_ERROR);

            verifier.verify_integer64(case, target, glw::GL_BUFFER_SIZE, i64::from(len));
            case.expect_error(glw::GL_NO_ERROR);
        }
    });
}

/// `BufferUsageCase`
fn buffer_usage(case: &mut ApiCase<'_>, verifier: Verifier) {
    for_each_buffer_target(case, false, |case, target| {
        let gl = case.gl();

        verifier.verify_integer(case, target, glw::GL_BUFFER_USAGE, glw::GL_STATIC_DRAW as i32);

        const USAGES: [GLenum; 9] = [
            glw::GL_STREAM_DRAW,
            glw::GL_STREAM_READ,
            glw::GL_STREAM_COPY,
            glw::GL_STATIC_DRAW,
            glw::GL_STATIC_READ,
            glw::GL_STATIC_COPY,
            glw::GL_DYNAMIC_DRAW,
            glw::GL_DYNAMIC_READ,
            glw::GL_DYNAMIC_COPY,
        ];

        for usage in USAGES {
            // SAFETY: as above.
            unsafe { gl.buffer_data(target, 16, std::ptr::null(), usage) };
            case.expect_error(glw::GL_NO_ERROR);

            verifier.verify_integer(case, target, glw::GL_BUFFER_USAGE, usage as i32);
            case.expect_error(glw::GL_NO_ERROR);
        }
    });
}

/// `BufferAccessFlagsCase`
fn buffer_access_flags(case: &mut ApiCase<'_>, verifier: Verifier) {
    for_each_buffer_target(case, false, |case, target| {
        let gl = case.gl();

        verifier.verify_integer(case, target, glw::GL_BUFFER_ACCESS_FLAGS, 0);

        const R: u32 = glw::GL_MAP_READ_BIT;
        const W: u32 = glw::GL_MAP_WRITE_BIT;
        const IR: u32 = glw::GL_MAP_INVALIDATE_RANGE_BIT;
        const IB: u32 = glw::GL_MAP_INVALIDATE_BUFFER_BIT;
        const FE: u32 = glw::GL_MAP_FLUSH_EXPLICIT_BIT;
        const UN: u32 = glw::GL_MAP_UNSYNCHRONIZED_BIT;

        const ACCESS_FLAGS: [u32; 17] = [
            R,
            W,
            W | IR,
            W | IB,
            W | IR | IB,
            W | FE,
            W | FE | IR,
            W | FE | IB,
            W | FE | IR | IB,
            W | UN,
            W | UN | IR,
            W | UN | IB,
            W | UN | IR | IB,
            W | UN | FE,
            W | UN | FE | IR,
            W | UN | FE | IB,
            W | UN | FE | IR | IB,
        ];

        for flags in ACCESS_FLAGS {
            // SAFETY: the whole 16-byte allocation is mapped with a legal flag set.
            unsafe {
                gl.buffer_data(target, 16, std::ptr::null(), glw::GL_DYNAMIC_COPY);
                gl.map_buffer_range(target, 0, 16, flags);
            }
            case.expect_error(glw::GL_NO_ERROR);

            verifier.verify_integer(case, target, glw::GL_BUFFER_ACCESS_FLAGS, flags as i32);
            case.expect_error(glw::GL_NO_ERROR);

            // SAFETY: the buffer is mapped.
            unsafe { gl.unmap_buffer(target) };
            case.expect_error(glw::GL_NO_ERROR);
        }
    });
}

/// `BufferMappedCase`
fn buffer_mapped(case: &mut ApiCase<'_>, verifier: Verifier) {
    for_each_buffer_target(case, false, |case, target| {
        let gl = case.gl();

        verifier.verify_integer(case, target, glw::GL_BUFFER_MAPPED, i32::from(glw::FALSE));

        // SAFETY: as in `buffer_access_flags`.
        unsafe {
            gl.buffer_data(target, 16, std::ptr::null(), glw::GL_DYNAMIC_COPY);
            gl.map_buffer_range(target, 0, 16, glw::GL_MAP_WRITE_BIT);
        }
        case.expect_error(glw::GL_NO_ERROR);

        verifier.verify_integer(case, target, glw::GL_BUFFER_MAPPED, i32::from(glw::TRUE));
        case.expect_error(glw::GL_NO_ERROR);

        // SAFETY: the buffer is mapped.
        unsafe { gl.unmap_buffer(target) };
        case.expect_error(glw::GL_NO_ERROR);
    });
}

/// `BufferOffsetLengthCase`
fn buffer_map_offset_length(case: &mut ApiCase<'_>, verifier: Verifier) {
    for_each_buffer_target(case, false, |case, target| {
        let gl = case.gl();

        verifier.verify_integer(case, target, glw::GL_BUFFER_MAP_OFFSET, 0);
        verifier.verify_integer(case, target, glw::GL_BUFFER_MAP_LENGTH, 0);

        // SAFETY: a null data pointer only allocates.
        unsafe { gl.buffer_data(target, 16, std::ptr::null(), glw::GL_DYNAMIC_COPY) };

        const RANGES: [(i32, i32); 4] = [(0, 16), (4, 12), (0, 12), (8, 8)];

        for (offset, length) in RANGES {
            // SAFETY: the range is inside the 16-byte allocation.
            unsafe { gl.map_buffer_range(target, offset as isize, length as isize, glw::GL_MAP_WRITE_BIT) };
            case.expect_error(glw::GL_NO_ERROR);

            verifier.verify_integer(case, target, glw::GL_BUFFER_MAP_OFFSET, offset);
            verifier.verify_integer(case, target, glw::GL_BUFFER_MAP_LENGTH, length);
            case.expect_error(glw::GL_NO_ERROR);

            // SAFETY: the buffer is mapped.
            unsafe { gl.unmap_buffer(target) };
            case.expect_error(glw::GL_NO_ERROR);
        }
    });
}

/// `BufferPointerCase`
fn buffer_pointer(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let mut buffer = 0;
    // SAFETY: the name is this case's own and is deleted below.
    unsafe {
        gl.gen_buffers(1, &mut buffer);
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer);
    }
    case.expect_error(glw::GL_NO_ERROR);

    let mut initial_state = Guarded::<*mut std::ffi::c_void>::new();
    // SAFETY: one pointer out, guarded on both sides.
    unsafe {
        gl.get_buffer_pointerv(
            glw::GL_ARRAY_BUFFER,
            glw::GL_BUFFER_MAP_POINTER,
            initial_state.as_mut_ptr(),
        )
    };
    initial_state.verify_validity(case);
    if !initial_state.value().is_null() {
        case.fail(
            format!("expected null; got {:?}", initial_state.value()),
            "got invalid value",
        );
    }

    // SAFETY: the whole 8-byte allocation is mapped for reading.
    let map_pointer = unsafe {
        gl.buffer_data(glw::GL_ARRAY_BUFFER, 8, std::ptr::null(), glw::GL_DYNAMIC_COPY);
        gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 8, glw::GL_MAP_READ_BIT)
    };
    case.expect_error(glw::GL_NO_ERROR);

    let mut map_pointer_state = Guarded::<*mut std::ffi::c_void>::new();
    // SAFETY: one pointer out, guarded on both sides.
    unsafe {
        gl.get_buffer_pointerv(
            glw::GL_ARRAY_BUFFER,
            glw::GL_BUFFER_MAP_POINTER,
            map_pointer_state.as_mut_ptr(),
        )
    };
    map_pointer_state.verify_validity(case);
    if map_pointer_state.value() != map_pointer {
        case.fail(
            format!("expected {map_pointer:?}; got {:?}", map_pointer_state.value()),
            "got invalid value",
        );
    }

    // Upstream deletes the buffer while it is still mapped, which is legal.
    // SAFETY: as above.
    unsafe { gl.delete_buffers(1, &buffer) };
    case.expect_error(glw::GL_NO_ERROR);
}

/// `BufferObjectQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("buffer_object");

    for verifier in VERIFIERS {
        add_api_case(&mut group, format!("buffer_size{}", verifier.postfix()), move |case| {
            buffer_size(case, verifier)
        });
    }
    for verifier in VERIFIERS {
        add_api_case(&mut group, format!("buffer_usage{}", verifier.postfix()), move |case| {
            buffer_usage(case, verifier)
        });
    }
    for verifier in VERIFIERS {
        add_api_case(
            &mut group,
            format!("buffer_access_flags{}", verifier.postfix()),
            move |case| {
                buffer_access_flags(case, verifier);
            },
        );
    }
    for verifier in VERIFIERS {
        add_api_case(
            &mut group,
            format!("buffer_mapped{}", verifier.postfix()),
            move |case| buffer_mapped(case, verifier),
        );
    }
    for verifier in VERIFIERS {
        add_api_case(
            &mut group,
            format!("buffer_map_offset_length{}", verifier.postfix()),
            move |case| {
                buffer_map_offset_length(case, verifier);
            },
        );
    }

    add_api_case(&mut group, "buffer_pointer", buffer_pointer);

    group
}
