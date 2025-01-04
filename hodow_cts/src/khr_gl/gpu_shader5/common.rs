// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/gpu_shader5/*.cpp  (the `initTest` / `deinit` bookkeeping every case repeats)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Written without compiling. Every upstream case keeps its GL object names in members and its `deinit` resets a few bindings and deletes what is non-zero; here the names are collected in `Objects` and `release` does the same for all of them, after the case ended however it ended.

use super::GPU_SHADER5_EXTENSION_NOT_SUPPORTED;
use crate::glu::Context;
use crate::glw::{self, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome};

/// `if (!m_is_gpu_shader5_supported) throw tcu::NotSupportedError(...)`
pub(super) fn require_gpu_shader5(base: &TestCaseBase) -> Result<(), TestError> {
    if !base.is_gpu_shader5_supported {
        return Err(TestError::NotSupported(GPU_SHADER5_EXTENSION_NOT_SUPPORTED.to_string()));
    }
    Ok(())
}

/// The GL names a case created, deleted by `release`.
#[derive(Default)]
pub(super) struct Objects {
    pub programs: Vec<GLuint>,
    pub shaders: Vec<GLuint>,
    pub buffers: Vec<GLuint>,
    pub textures: Vec<GLuint>,
    pub framebuffers: Vec<GLuint>,
    pub vertex_arrays: Vec<GLuint>,
    pub renderbuffers: Vec<GLuint>,
    pub samplers: Vec<GLuint>,
}

impl Objects {
    /// `deinit`: resets the bindings the cases touch, then deletes every name.
    pub fn release(&mut self, context: &Context) {
        let gl = context.gl();

        // SAFETY: state resets and deletes of names the case created, on the current context.
        unsafe {
            gl.use_program(0);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            gl.bind_buffer(glw::GL_UNIFORM_BUFFER, 0);
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0);
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            gl.bind_vertex_array(0);

            for program in self.programs.drain(..) {
                gl.delete_program(program);
            }
            for shader in self.shaders.drain(..) {
                gl.delete_shader(shader);
            }
            if !self.buffers.is_empty() {
                gl.delete_buffers(self.buffers.len() as i32, self.buffers.as_ptr());
                self.buffers.clear();
            }
            if !self.textures.is_empty() {
                gl.delete_textures(self.textures.len() as i32, self.textures.as_ptr());
                self.textures.clear();
            }
            if !self.framebuffers.is_empty() {
                gl.delete_framebuffers(self.framebuffers.len() as i32, self.framebuffers.as_ptr());
                self.framebuffers.clear();
            }
            if !self.renderbuffers.is_empty() {
                gl.delete_renderbuffers(self.renderbuffers.len() as i32, self.renderbuffers.as_ptr());
                self.renderbuffers.clear();
            }
            if !self.samplers.is_empty() {
                gl.delete_samplers(self.samplers.len() as i32, self.samplers.as_ptr());
                self.samplers.clear();
            }
            if !self.vertex_arrays.is_empty() {
                gl.delete_vertex_arrays(self.vertex_arrays.len() as i32, self.vertex_arrays.as_ptr());
                self.vertex_arrays.clear();
            }
        }
    }
}

/// Runs a case body and `deinit`s afterwards, whatever the body returned.
pub(super) fn run_case(
    context: &Context,
    ext_params: ExtParameters,
    body: impl FnOnce(&Context, &TestCaseBase, &mut Objects) -> TestOutcome,
) -> TestOutcome {
    let base = TestCaseBase::init(context, ext_params);
    let mut objects = Objects::default();

    let outcome = body(context, &base, &mut objects);
    objects.release(context);
    outcome
}

/// The C library's `rand()` as glibc implements it (the TYPE_3 additive feedback generator), started with `srand(seed)`: upstream cases draw their texture coordinates and some offsets from the unseeded one.
pub(super) struct CRand {
    table: [u32; 31],
    front: usize,
    rear: usize,
}

impl CRand {
    pub fn new(seed: u32) -> Self {
        let mut table = [0u32; 31];
        table[0] = if seed == 0 { 1 } else { seed };

        for i in 1..31 {
            let word = table[i - 1] as i32 as i64;
            let mut value = (16807 * word) % 2147483647;
            if value < 0 {
                value += 2147483647;
            }
            table[i] = value as u32;
        }

        let mut generator = Self {
            table,
            front: 3,
            rear: 0,
        };
        for _ in 0..310 {
            generator.next();
        }
        generator
    }

    /// One value from `[0, 2^31)`.
    pub fn next(&mut self) -> i32 {
        self.table[self.front] = self.table[self.front].wrapping_add(self.table[self.rear]);
        let result = self.table[self.front] >> 1;

        self.front = (self.front + 1) % 31;
        self.rear = (self.rear + 1) % 31;

        result as i32
    }
}
