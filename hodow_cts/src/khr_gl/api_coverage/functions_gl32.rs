// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcApiCoverageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. OpenGL 3.2 entry points; `glGetInteger64i_v`, `glFramebufferTexture`, the four base-vertex draws, `glProvokingVertex`, the multisample texture calls, `glGetMultisamplefv` and `glSampleMaski` are "not implemented yet" stubs upstream and are not listed here (`glGetInteger64i` is not even a key of upstream's map).

use super::Coverage;
use crate::tcu::TestError;
use crate::{glu, glw};

const EA_GET_BUFFER_PARAMETERI64V: [glw::GLenum; 6] = [
    glw::GL_BUFFER_MAP_LENGTH,
    glw::GL_BUFFER_MAP_OFFSET,
    glw::GL_BUFFER_MAPPED,
    glw::GL_BUFFER_ACCESS_FLAGS,
    glw::GL_BUFFER_USAGE,
    glw::GL_BUFFER_SIZE,
];

const EA_GET_INTEGER64V: [glw::GLenum; 5] = [
    glw::GL_MAX_ELEMENT_INDEX,
    glw::GL_MAX_SERVER_WAIT_TIMEOUT,
    glw::GL_MAX_UNIFORM_BLOCK_SIZE,
    glw::GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS,
    glw::GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS,
];

const EA_GET_SYNCIV: [glw::GLenum; 4] = [
    glw::GL_OBJECT_TYPE,
    glw::GL_SYNC_STATUS,
    glw::GL_SYNC_CONDITION,
    glw::GL_SYNC_FLAGS,
];

impl Coverage<'_> {
    pub(super) fn run_func_gl32(&self, name: &str) -> Option<Result<bool, TestError>> {
        Some(match name {
            "glGetBufferParameteri64v" => self.get_buffer_parameteri64v(),
            "glProgramParameteri" => self.program_parameteri(),
            "glFenceSync" => self.fence_sync(),
            "glIsSync" => self.is_sync(),
            "glDeleteSync" => self.delete_sync(),
            "glClientWaitSync" => self.client_wait_sync(),
            "glWaitSync" => self.wait_sync(),
            "glGetInteger64v" => self.get_integer64v(),
            "glGetSynciv" => self.get_synciv(),
            _ => return None,
        })
    }

    /// `TestCoverageGLCallGetBufferParameteri64v`
    fn get_buffer_parameteri64v(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut cb: glw::GLuint = 0;
        let data = [0u32; 64];
        let mut param: glw::GLint64 = 0;

        // SAFETY: `data` holds the 64 bytes uploaded and `param` receives one 64-bit value per query.
        unsafe {
            let _ = gl.get_error();

            gl.gen_buffers(1, &mut cb);
            glu::expect_no_error(gl, "genBuffers")?;
            gl.bind_buffer(glw::GL_PIXEL_PACK_BUFFER, cb);
            glu::expect_no_error(gl, "bindBuffer")?;
            gl.buffer_data(glw::GL_PIXEL_PACK_BUFFER, 64, data.as_ptr().cast(), glw::GL_STATIC_COPY);
            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("GetBufferParameteri64v", "Buffer creation failure");
                return Ok(false);
            }

            for pname in EA_GET_BUFFER_PARAMETERI64V {
                gl.get_buffer_parameteri_64v(glw::GL_PIXEL_PACK_BUFFER, pname, &mut param);
                if gl.get_error() != glw::GL_NO_ERROR {
                    success = false;
                }
            }

            if !success {
                self.fail_msg("GetBufferParameteri64v", "Failed");
            }

            if param != 64 {
                self.fail_msg("GetBufferParameteri64v", "Incorrect return value");
                success = false;
            }

            gl.delete_buffers(1, &cb);
            glu::expect_no_error(gl, "deleteBuffers")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallProgramParameteri`
    fn program_parameteri(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: plain handles and integers.
        unsafe {
            let _ = gl.get_error();

            let program = self.create_default_program(0)?;

            if program == -1 {
                self.fail_msg("ProgramParameteri", "Program create Failed");
                return Ok(false);
            }

            gl.program_parameteri(
                program as glw::GLuint,
                glw::GL_PROGRAM_BINARY_RETRIEVABLE_HINT,
                glw::GL_TRUE as glw::GLint,
            );

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("ProgramParameteri", "Failed");
                success = false;
            }

            gl.delete_program(program as glw::GLuint);
            glu::expect_no_error(gl, "deleteProgram")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallFenceSync`
    fn fence_sync(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: sync objects are opaque handles; a failed creation hands back null, which deleteSync ignores.
        unsafe {
            let _ = gl.get_error();

            let sobj1 = gl.fence_sync(glw::GL_SYNC_GPU_COMMANDS_COMPLETE, 0);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("FenceSync", "Failed (1)");
                success = false;
            }

            let sobj2 = gl.fence_sync(glw::GL_SYNC_GPU_COMMANDS_COMPLETE, 1);

            if gl.get_error() != glw::GL_INVALID_VALUE {
                self.fail_msg("FenceSync", "Failed (2)");
                success = false;
            }

            gl.delete_sync(sobj1);
            glu::expect_no_error(gl, "deleteSync")?;
            gl.delete_sync(sobj2);
            glu::expect_no_error(gl, "deleteSync")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallIsSync`
    fn is_sync(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: opaque sync handle.
        unsafe {
            let _ = gl.get_error();

            let sobj = gl.fence_sync(glw::GL_SYNC_GPU_COMMANDS_COMPLETE, 0);
            glu::expect_no_error(gl, "fenceSync")?;

            if gl.is_sync(sobj) == glw::FALSE || gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("IsSync", "Sync creation failed");
                success = false;
            }

            gl.delete_sync(sobj);
            glu::expect_no_error(gl, "deleteSync")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallDeleteSync`
    fn delete_sync(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: opaque sync handle.
        unsafe {
            let _ = gl.get_error();

            let sobj = gl.fence_sync(glw::GL_SYNC_GPU_COMMANDS_COMPLETE, 0);
            glu::expect_no_error(gl, "fenceSync")?;

            gl.delete_sync(sobj);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("DeleteSync", "Failed");
                success = false;
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallClientWaitSync`
    fn client_wait_sync(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: opaque sync handle.
        unsafe {
            let _ = gl.get_error();

            gl.finish();
            glu::expect_no_error(gl, "finish")?;

            let sobj = gl.fence_sync(glw::GL_SYNC_GPU_COMMANDS_COMPLETE, 0);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("ClientWaitSync", "Sync create failed");
                success = false;
            }

            let mut sresult = gl.client_wait_sync(sobj, 0, 1_000_000_000);

            if gl.get_error() != glw::GL_NO_ERROR || sresult == glw::GL_WAIT_FAILED {
                self.fail_msg("ClientWaitSync", "Failed (1)");
                success = false;
            }

            sresult = gl.client_wait_sync(sobj, glw::GL_SYNC_FLUSH_COMMANDS_BIT, 1_000_000_000);

            if gl.get_error() != glw::GL_NO_ERROR || sresult == glw::GL_WAIT_FAILED {
                self.fail_msg("ClientWaitSync", "Failed (2)");
                success = false;
            }

            gl.delete_sync(sobj);
            glu::expect_no_error(gl, "deleteSync")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallWaitSync`
    fn wait_sync(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;

        // SAFETY: opaque sync handle.
        unsafe {
            let _ = gl.get_error();

            let sobj = gl.fence_sync(glw::GL_SYNC_GPU_COMMANDS_COMPLETE, 0);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("WaitSync", "Sync create failed");
                success = false;
            }

            gl.wait_sync(sobj, 0, glw::GL_TIMEOUT_IGNORED);

            if gl.get_error() != glw::GL_NO_ERROR {
                self.fail_msg("WaitSync", "Failed (1)");
                success = false;
            }

            gl.wait_sync(sobj, 0, 1_000_000_000);

            if gl.get_error() != glw::GL_INVALID_VALUE {
                self.fail_msg("WaitSync", "Failed (2)");
                success = false;
            }

            gl.delete_sync(sobj);
            glu::expect_no_error(gl, "deleteSync")?;
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetInteger64v`
    fn get_integer64v(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut value: glw::GLint64 = 0;

        // SAFETY: one 64-bit value per query.
        unsafe {
            let _ = gl.get_error();

            for pname in EA_GET_INTEGER64V {
                gl.get_integer_64v(pname, &mut value);
                if gl.get_error() != glw::GL_NO_ERROR {
                    self.fail_msg("GetInteger64v", &format!("Failed 0x{pname:x}"));
                    success = false;
                }
            }
        }

        Ok(success)
    }

    /// `TestCoverageGLCallGetSynciv`
    fn get_synciv(&self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut success = true;
        let mut length: glw::GLsizei = 0;
        let mut value: glw::GLint = 0;

        // SAFETY: one value is requested and one is written.
        unsafe {
            let _ = gl.get_error();

            let sobj = gl.fence_sync(glw::GL_SYNC_GPU_COMMANDS_COMPLETE, 0);

            for pname in EA_GET_SYNCIV {
                gl.get_synciv(sobj, pname, 1, &mut length, &mut value);
                if gl.get_error() != glw::GL_NO_ERROR {
                    self.fail_msg("GetSynciv", &format!("Failed 0x{pname:x}"));
                    success = false;
                }
            }

            gl.delete_sync(sobj);
            glu::expect_no_error(gl, "deleteSync")?;
        }

        Ok(success)
    }
}
