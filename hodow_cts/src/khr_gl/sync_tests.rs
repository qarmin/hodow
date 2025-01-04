// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cSyncTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `try`/`catch (...)` of upstream's `iterate` is a `Result` from `run`; its three verdicts (Timeout, InternalError for a thrown error, Fail) are kept.

use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLuint};
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};

/// Timeout of the test in nanoseconds.
const TEST_SYNC_WAIT_TIMEOUT: u64 = 16_000_000_000;

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

/// `Sync::FlushCommandsTest`
struct FlushCommandsTest;

struct Verdict {
    is_ok: bool,
    is_timeout: bool,
}

struct Objects {
    buffer_src: GLuint,
    buffer_dst: GLuint,
    sync: glw::GLsync,
}

impl FlushCommandsTest {
    /// The body of upstream's `try` block.
    fn run(gl: &glw::Functions, objects: &mut Objects) -> Result<Verdict, TestError> {
        let mut verdict = Verdict {
            is_ok: false,
            is_timeout: false,
        };

        // Test constants.
        const REFERENCE: [GLuint; 2] = [3, 1_415_927];
        let reference_size = size_of_val(&REFERENCE) as isize;

        // Prepare buffers.
        gl_call!(
            gl,
            "glCreateBuffers have failed",
            gl.create_buffers(1, &mut objects.buffer_src)
        );
        gl_call!(
            gl,
            "glNamedBufferData have failed",
            gl.named_buffer_data(
                objects.buffer_src,
                reference_size,
                REFERENCE.as_ptr().cast(),
                glw::GL_STATIC_COPY
            )
        );
        gl_call!(
            gl,
            "glCreateBuffers have failed",
            gl.create_buffers(1, &mut objects.buffer_dst)
        );
        gl_call!(
            gl,
            "glNamedBufferStorage have failed",
            gl.named_buffer_storage(
                objects.buffer_dst,
                reference_size,
                std::ptr::null(),
                glw::GL_MAP_READ_BIT | glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_COHERENT_BIT
            )
        );

        // Map perisistently buffer range.
        // SAFETY: the storage above is `reference_size` bytes and was created mappable for reading.
        let data_dst = unsafe {
            gl.map_named_buffer_range(
                objects.buffer_dst,
                0,
                reference_size,
                glw::GL_MAP_READ_BIT | glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_COHERENT_BIT,
            )
        }
        .cast::<GLuint>();
        glu::expect_no_error(gl, "glMapNamedBufferRange have failed")?;

        // Copy data from source to destination buffer
        // SAFETY: both buffers hold `reference_size` bytes.
        unsafe { gl.copy_named_buffer_sub_data(objects.buffer_src, objects.buffer_dst, 0, 0, reference_size) };
        // SAFETY: glGetError needs only a current context.
        let mut error: GLenum = unsafe { gl.get_error() };
        if error != glw::GL_NO_ERROR {
            // SAFETY: the buffer mapped above.
            unsafe { gl.unmap_named_buffer(objects.buffer_dst) };
            return Err(TestError::Fail(format!(
                "glCopyNamedBufferSubData have failed: {}",
                glw::error_name(error)
            )));
        }

        // Create fence sync object.
        // SAFETY: a plain object creation with a current context.
        objects.sync = unsafe { gl.fence_sync(glw::GL_SYNC_GPU_COMMANDS_COMPLETE, 0) };
        // SAFETY: glGetError needs only a current context.
        error = unsafe { gl.get_error() };
        if error == glw::GL_NO_ERROR {
            // Wait until done.
            // SAFETY: the sync object created above.
            let wait_result =
                unsafe { gl.client_wait_sync(objects.sync, glw::GL_SYNC_FLUSH_COMMANDS_BIT, TEST_SYNC_WAIT_TIMEOUT) };

            // Check for error.
            // SAFETY: glGetError needs only a current context.
            error = unsafe { gl.get_error() };
            if error == glw::GL_NO_ERROR {
                // Check for timeout.
                if wait_result == glw::GL_TIMEOUT_EXPIRED {
                    log::warn!(
                        "ClientWaitSync with SYNC_FLUSH_COMMANDS_BIT flag has returned TIMEOUT_EXPIRED after {TEST_SYNC_WAIT_TIMEOUT} nanoseconds. Potentially test may not be done in finite time which is expected (OpenGL 4.5 Core Profile, Chapter 4.1.2). However this cannot be proven in finite time. Test timeouts."
                    );
                    verdict.is_timeout = true;
                } else if wait_result == glw::GL_CONDITION_SATISFIED || wait_result == glw::GL_ALREADY_SIGNALED {
                    // Compare destination buffer data with reference.
                    // SAFETY: the persistent coherent mapping is two `GLuint`s and is still mapped.
                    let (dst0, dst1) = unsafe { (data_dst.read_volatile(), data_dst.add(1).read_volatile()) };
                    if REFERENCE[0] == dst0 || REFERENCE[1] == dst1 {
                        verdict.is_ok = true;
                    } else {
                        log::warn!(
                            "Result data [{dst0}, {dst1}is not equal to the reference [{}, {}]. Tests fails.",
                            REFERENCE[0],
                            REFERENCE[1]
                        );
                    }
                }
            } else {
                log::warn!(
                    "ClientWaitSync unexpectedly generated error {}. Tests fails.",
                    glw::error_name(error)
                );
            }
        }

        // Unmapping.
        // SAFETY: the buffer mapped above.
        unsafe { gl.unmap_named_buffer(objects.buffer_dst) };
        if error != glw::GL_NO_ERROR {
            return Err(TestError::Fail(format!(
                "glUnmapNamedBuffer have failed: {}",
                glw::error_name(error)
            )));
        }

        Ok(verdict)
    }
}

impl TestCase for FlushCommandsTest {
    fn name(&self) -> &str {
        "flush_commands"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let is_at_least_gl_45 = context.context_type().supports_core(4, 5);
        let is_arb_direct_state_access = context
            .context_info
            .is_extension_supported("GL_ARB_direct_state_access");
        if !is_at_least_gl_45 && !is_arb_direct_state_access {
            return Err(TestError::NotSupported("Not Supported".to_string()));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = Objects {
            buffer_src: 0,
            buffer_dst: 0,
            sync: std::ptr::null_mut(),
        };

        let result = Self::run(gl, &mut objects);

        // Cleanup.
        // SAFETY: the objects created in `run`, each deleted once.
        unsafe {
            if objects.buffer_src != 0 {
                gl.delete_buffers(1, &objects.buffer_src);
            }
            if objects.buffer_dst != 0 {
                gl.delete_buffers(1, &objects.buffer_dst);
            }
            if !objects.sync.is_null() {
                gl.delete_sync(objects.sync);
            }
        }

        // Result's setup.
        Ok(match result {
            Ok(Verdict { is_timeout: true, .. }) => TestStatus::new(
                TestResult::Timeout,
                "Timeout (Potentially, ClientWaitSync with SYNC_FLUSH_COMMANDS does not return in finite time).",
            ),
            Ok(Verdict { is_ok: true, .. }) => TestStatus::pass("Pass"),
            Ok(_) => TestStatus::fail("Fail"),
            Err(_) => TestStatus::new(TestResult::InternalError, "Error"),
        })
    }
}

/// `Sync::Tests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("sync");
    group.add_child(Box::new(FlushCommandsTest) as Box<dyn TestCase>);
    group
}
