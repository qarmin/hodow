// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cGPUShaderFP64Tests.cpp (the shader objects, `initTest` and `executeIteration` of GPUShaderFP64Test6 and GPUShaderFP64Test8)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The two tests carry the same six shader object members and the same compile loop; here they are one `ShaderStages`.

use std::ffi::CString;

use crate::glu::Context;
use crate::glw::{self, GLuint};
use crate::tcu::TestError;

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

/// The order of `so_ids[]`: compute, fragment, geometry, tessellation control, tessellation evaluation, vertex.
pub(super) const STAGE_NAMES: [&str; 6] = [
    "Compute shader",
    "Fragment shader",
    "Geometry shader",
    "Tessellation control shader",
    "Tessellation evaluation shader",
    "Vertex shader",
];

/// The six shader objects (`m_cs_id` ... `m_vs_id`); the compute shader is 0 when it is not supported.
#[derive(Default)]
pub(super) struct ShaderStages {
    ids: [GLuint; 6],
}

impl ShaderStages {
    /// `initTest`
    pub(super) fn new(context: &Context) -> Result<Self, TestError> {
        let gl = context.gl();
        let mut stages = Self::default();

        // Compute shader support and GL 4.2 required
        if context.context_info.is_extension_supported("GL_ARB_compute_shader")
            && context.context_type().supports_core(4, 2)
        {
            stages.ids[0] = gl!(gl.create_shader(glw::GL_COMPUTE_SHADER));
        }
        stages.ids[1] = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        stages.ids[2] = gl!(gl.create_shader(glw::GL_GEOMETRY_SHADER));
        stages.ids[3] = gl!(gl.create_shader(glw::GL_TESS_CONTROL_SHADER));
        stages.ids[4] = gl!(gl.create_shader(glw::GL_TESS_EVALUATION_SHADER));
        stages.ids[5] = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        crate::glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;
        Ok(stages)
    }

    /// The `deinit` of both tests
    pub(super) fn delete(&mut self, gl: &glw::Functions) {
        for id in &mut self.ids {
            if *id != 0 {
                gl!(gl.delete_shader(*id));
                *id = 0;
            }
        }
    }

    /// `initIteration`: hand each stage its body, in the order of `STAGE_NAMES`.
    pub(super) fn set_sources(&self, gl: &glw::Functions, bodies: &[String; 6]) -> Result<(), TestError> {
        for (id, body) in self.ids.iter().zip(bodies) {
            // m_cs_id is initialized only if compute_shader is supported
            if *id == 0 {
                continue;
            }
            let source = CString::new(body.as_str()).expect("shader source holds no nul byte");
            let sources = [source.as_ptr()];
            gl!(gl.shader_source(*id, 1, sources.as_ptr(), std::ptr::null()));
        }
        crate::glu::expect_no_error(gl, "glShaderSource() call(s) failed.")
    }

    /// `executeIteration`: compile every stage and check that each of them compiled (`expect_success`) or did not, logging the bodies of the stages that did the wrong thing.
    pub(super) fn execute_iteration(
        &self,
        gl: &glw::Functions,
        bodies: &[String; 6],
        expect_success: bool,
    ) -> Result<bool, TestError> {
        let mut result = true;

        for (index, &id) in self.ids.iter().enumerate() {
            // Skip compute shader if it is not supported
            if id == 0 {
                continue;
            }

            gl!(gl.compile_shader(id));
            crate::glu::expect_no_error(gl, "glCompileShader() call failed.")?;

            let mut compile_status = if expect_success {
                glw::GL_FALSE as glw::GLint
            } else {
                glw::GL_TRUE as glw::GLint
            };
            gl!(gl.get_shaderiv(id, glw::GL_COMPILE_STATUS, &mut compile_status));
            crate::glu::expect_no_error(gl, "glGetShaderiv() call failed.")?;

            let compiled = compile_status == glw::GL_TRUE as glw::GLint;
            if compiled != expect_success {
                if expect_success {
                    log::info!(
                        "{} has not compiled successfully, even though the shader is valid. Following is shader's body:\n{}",
                        STAGE_NAMES[index],
                        bodies[index]
                    );
                } else {
                    log::info!(
                        "{} has been compiled successfully, even though the shader was malformed. Following is shader body:\n{}",
                        STAGE_NAMES[index],
                        bodies[index]
                    );
                }
                result = false;
            }
        }
        Ok(result)
    }
}
