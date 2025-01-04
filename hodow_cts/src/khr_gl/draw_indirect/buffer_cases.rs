// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gles31/es31cDrawIndirectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `CBufferBindRange` and `CBufferBindBase` are not ported: upstream defines them but registers neither.

use std::ffi::c_void;

use super::{
    DiResult, GL_FALSE_BYTE, GL_TRUE_BYTE, UINT_SIZE, add_case, binding_point_check, buffer_check, data_compare,
    data_compare_plain, data_gen, get_buffer_sub_data, get_data_size, state_validate,
};
use crate::glu::{Context, TestCaseGroup};
use crate::glw::{self, GLuint};
use crate::khr_gl::subcase::{Subcase, SubcaseResult};

fn bytes(words: usize) -> isize {
    (words * UINT_SIZE) as isize
}

/// `CDefaultBindingPoint`
struct DefaultBindingPoint;

impl Subcase for DefaultBindingPoint {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        Ok(binding_point_check(context.gl(), 0))
    }
}

/// `CZeroBindingPoint`
struct ZeroBindingPoint;

impl Subcase for ZeroBindingPoint {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, 0));
        Ok(binding_point_check(gl, 0))
    }
}

/// `CSingleBindingPoint`
#[derive(Default)]
struct SingleBindingPoint {
    buffer: GLuint,
}

impl Subcase for SingleBindingPoint {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, self.buffer));
        Ok(binding_point_check(gl, self.buffer))
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_buffers(1, &self.buffer));
        Ok(binding_point_check(gl, 0))
    }
}

/// `CMultiBindingPoint`
#[derive(Default)]
struct MultiBindingPoint {
    buffers: [GLuint; 10],
}

impl Subcase for MultiBindingPoint {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut result = DiResult::new();

        gl!(gl.gen_buffers(self.buffers.len() as i32, self.buffers.as_mut_ptr()));

        for &buffer in &self.buffers {
            gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, buffer));
            result.sub_result(binding_point_check(gl, buffer));
        }
        Ok(result.code())
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_buffers(self.buffers.len() as i32, self.buffers.as_ptr()));
        Ok(binding_point_check(gl, 0))
    }
}

/// `CDeleteBindingPoint`
#[derive(Default)]
struct DeleteBindingPoint {
    buffer: GLuint,
}

impl Subcase for DeleteBindingPoint {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, self.buffer));
        gl!(gl.delete_buffers(1, &self.buffer));
        Ok(binding_point_check(gl, 0))
    }
}

fn buffer_data(gl: &glw::Functions, data: &[u32], usage: u32) {
    gl!(gl.buffer_data(
        glw::GL_DRAW_INDIRECT_BUFFER,
        bytes(data.len()),
        data.as_ptr().cast(),
        usage
    ));
}

fn buffer_data_empty(gl: &glw::Functions, size: isize, usage: u32) {
    gl!(gl.buffer_data(glw::GL_DRAW_INDIRECT_BUFFER, size, std::ptr::null(), usage));
}

/// `CBufferData`
#[derive(Default)]
struct BufferData {
    buffers: [GLuint; 10],
}

impl Subcase for BufferData {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut result = DiResult::new();
        let target = glw::GL_DRAW_INDIRECT_BUFFER;

        let (data_width, data_height) = get_data_size(context);
        let (w, h) = (data_width as u32, data_height as u32);

        let mut data_test = vec![0u32; (w * h) as usize];

        gl!(gl.gen_buffers(self.buffers.len() as i32, self.buffers.as_mut_ptr()));

        let data_ref1 = data_gen(w, h, 0, 50);
        gl!(gl.bind_buffer(target, self.buffers[1]));
        buffer_data(gl, &data_ref1, glw::GL_DYNAMIC_DRAW);
        result.sub_result(binding_point_check(gl, self.buffers[1]));

        get_buffer_sub_data(gl, target, 0, &mut data_test);
        result.sub_result(data_compare_plain(&data_ref1, w, h, &data_test, w, h));

        let data_ref2 = data_gen(w, h, 10, 70);
        gl!(gl.bind_buffer(target, self.buffers[2]));
        buffer_data(gl, &data_ref2, glw::GL_STREAM_DRAW);
        result.sub_result(binding_point_check(gl, self.buffers[2]));

        get_buffer_sub_data(gl, target, 0, &mut data_test);
        result.sub_result(data_compare_plain(&data_ref2, w, h, &data_test, w, h));

        gl!(gl.bind_buffer(target, self.buffers[3]));
        buffer_data_empty(gl, 300, glw::GL_STATIC_DRAW);
        result.sub_result(binding_point_check(gl, self.buffers[3]));

        gl!(gl.bind_buffer(target, self.buffers[4]));
        buffer_data_empty(gl, 400, glw::GL_DYNAMIC_READ);
        result.sub_result(binding_point_check(gl, self.buffers[4]));

        let data_ref5 = data_gen(w, h, 0, 50);
        gl!(gl.bind_buffer(target, self.buffers[5]));
        buffer_data(gl, &data_ref5, glw::GL_STREAM_READ);
        result.sub_result(binding_point_check(gl, self.buffers[5]));

        get_buffer_sub_data(gl, target, 0, &mut data_test);
        result.sub_result(data_compare_plain(&data_ref5, w, h, &data_test, w, h));

        let data_ref6 = data_gen(w, h, 10, 40);
        gl!(gl.bind_buffer(target, self.buffers[6]));
        buffer_data(gl, &data_ref6, glw::GL_STATIC_READ);
        result.sub_result(binding_point_check(gl, self.buffers[6]));

        get_buffer_sub_data(gl, target, 0, &mut data_test);
        result.sub_result(data_compare_plain(&data_ref6, w, h, &data_test, w, h));

        let data_ref7 = data_gen(w, h, 4, 70);
        gl!(gl.bind_buffer(target, self.buffers[7]));
        buffer_data(gl, &data_ref7, glw::GL_DYNAMIC_COPY);
        result.sub_result(binding_point_check(gl, self.buffers[7]));

        get_buffer_sub_data(gl, target, 0, &mut data_test);
        result.sub_result(data_compare_plain(&data_ref7, w, h, &data_test, w, h));

        gl!(gl.bind_buffer(target, self.buffers[8]));
        buffer_data_empty(gl, 800, glw::GL_STREAM_COPY);
        result.sub_result(binding_point_check(gl, self.buffers[8]));

        let mut data_ref9 = data_gen(w, h, 18, 35);
        gl!(gl.bind_buffer(target, self.buffers[9]));
        buffer_data(gl, &data_ref9, glw::GL_STATIC_COPY);
        result.sub_result(binding_point_check(gl, self.buffers[9]));

        get_buffer_sub_data(gl, target, 0, &mut data_test);
        result.sub_result(data_compare_plain(&data_ref9, w, h, &data_test, w, h));

        // reallocation: same size
        buffer_data(gl, &data_ref9, glw::GL_STATIC_COPY);
        get_buffer_sub_data(gl, target, 0, &mut data_test);
        result.sub_result(data_compare_plain(&data_ref9, w, h, &data_test, w, h));

        // reallocation: larger size
        data_ref9 = data_gen(w * 2, h * 2, 18, 35);
        data_test.resize(data_ref9.len(), 0);
        buffer_data(gl, &data_ref9, glw::GL_STATIC_COPY);
        get_buffer_sub_data(gl, target, 0, &mut data_test);
        result.sub_result(data_compare_plain(&data_ref9, w * 2, h * 2, &data_test, w * 2, h * 2));

        // reallocation: smaller size
        data_ref9 = data_gen(w / 2, h / 2, 18, 35);
        data_test.resize(data_ref9.len(), 0);
        buffer_data(gl, &data_ref9, glw::GL_STATIC_COPY);
        get_buffer_sub_data(gl, target, 0, &mut data_test);
        result.sub_result(data_compare_plain(&data_ref9, w / 2, h / 2, &data_test, w / 2, h / 2));

        Ok(result.code())
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_buffers(self.buffers.len() as i32, self.buffers.as_ptr()));
        Ok(binding_point_check(gl, 0))
    }
}

/// `CBufferSubData`
#[derive(Default)]
struct BufferSubData {
    buffer: GLuint,
}

impl Subcase for BufferSubData {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut result = DiResult::new();
        let target = glw::GL_DRAW_INDIRECT_BUFFER;

        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer(target, self.buffer));

        let (data_width, data_height) = get_data_size(context);
        let (w, h) = (data_width as u32, data_height as u32);
        let mut data_ref = data_gen(w, h, 4, 70);
        buffer_data_empty(gl, bytes(data_ref.len()), glw::GL_DYNAMIC_DRAW);
        gl!(gl.buffer_sub_data(target, 0, bytes(data_ref.len()), data_ref.as_ptr().cast()));

        let mut data_test = vec![0u32; (w * h) as usize];
        get_buffer_sub_data(gl, target, 0, &mut data_test);
        result.sub_result(data_compare_plain(&data_ref, w, h, &data_test, w, h));

        let data_sub_ref = data_gen(w / 2, h / 2, 80, 90);
        gl!(gl.buffer_sub_data(target, 4, bytes(data_sub_ref.len()), data_sub_ref.as_ptr().cast()));
        data_ref[1..1 + data_sub_ref.len()].copy_from_slice(&data_sub_ref);

        get_buffer_sub_data(gl, target, 0, &mut data_test);
        result.sub_result(data_compare_plain(&data_ref, w, h, &data_test, w, h));

        Ok(result.code())
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_buffers(1, &self.buffer));
        Ok(binding_point_check(gl, 0))
    }
}

/// Unmaps and checks the result the way each mapping block of the cases below does.
fn unmap_expecting_true(gl: &glw::Functions, result: &mut DiResult, strict_true: bool) {
    let unmapped = gl!(gl.unmap_buffer(glw::GL_DRAW_INDIRECT_BUFFER));
    let failed = if strict_true {
        unmapped != GL_TRUE_BYTE
    } else {
        unmapped == GL_FALSE_BYTE
    };
    if failed {
        result.error("glUnmapBuffer(GL_DRAW_INDIRECT_BUFFER) returned GL_FALSE, expected GL_TRUE");
    }
}

/// `CBufferMap`
#[derive(Default)]
struct BufferMap {
    buffer: GLuint,
}

impl Subcase for BufferMap {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut result = DiResult::new();
        let target = glw::GL_DRAW_INDIRECT_BUFFER;

        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer(target, self.buffer));

        let (data_width, data_height) = get_data_size(context);
        let (w, h) = (data_width as u32, data_height as u32);
        let data_ref = data_gen(w, h, 30, 50);
        buffer_data(gl, &data_ref, glw::GL_DYNAMIC_DRAW);
        let size = bytes(data_ref.len());

        result.sub_result(state_validate(gl, GL_FALSE_BYTE, glw::GL_READ_WRITE, 0, 0, 0));

        let buf = gl!(gl.map_buffer(target, glw::GL_READ_ONLY));
        if buf.is_null() {
            result.error("glMapBuffer(GL_DRAW_INDIRECT_BUFFER, GL_READ_ONLY) returned NULL");
        } else {
            result.sub_result(buffer_check(&data_ref, w, h, buf, w, h, 0, 0));
            result.sub_result(state_validate(
                gl,
                GL_TRUE_BYTE,
                glw::GL_READ_ONLY,
                glw::GL_MAP_READ_BIT,
                0,
                size,
            ));
            unmap_expecting_true(gl, &mut result, false);
            result.sub_result(state_validate(gl, GL_FALSE_BYTE, glw::GL_READ_WRITE, 0, 0, 0));
        }

        let buf = gl!(gl.map_buffer(target, glw::GL_WRITE_ONLY));
        if buf.is_null() {
            result.error("glMapBuffer(GL_DRAW_INDIRECT_BUFFER, GL_WRITE_ONLY) returned NULL");
        } else {
            result.sub_result(state_validate(
                gl,
                GL_TRUE_BYTE,
                glw::GL_WRITE_ONLY,
                glw::GL_MAP_WRITE_BIT,
                0,
                size,
            ));
            // SAFETY: the whole buffer of `data_ref.len()` words is mapped for writing.
            unsafe { std::ptr::copy_nonoverlapping(data_ref.as_ptr(), buf.cast::<u32>(), data_ref.len()) };
            unmap_expecting_true(gl, &mut result, true);
            result.sub_result(state_validate(gl, GL_FALSE_BYTE, glw::GL_READ_WRITE, 0, 0, 0));
        }

        let buf = gl!(gl.map_buffer(target, glw::GL_READ_WRITE));
        if buf.is_null() {
            result.error("glMapBuffer(GL_DRAW_INDIRECT_BUFFER, GL_READ_WRITE) returned NULL");
        } else {
            result.sub_result(buffer_check(&data_ref, w, h, buf, w, h, 0, 0));
            result.sub_result(state_validate(
                gl,
                GL_TRUE_BYTE,
                glw::GL_READ_WRITE,
                glw::GL_MAP_WRITE_BIT | glw::GL_MAP_READ_BIT,
                0,
                size,
            ));
            unmap_expecting_true(gl, &mut result, false);
            result.sub_result(state_validate(gl, GL_FALSE_BYTE, glw::GL_READ_WRITE, 0, 0, 0));
        }

        Ok(result.code())
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_buffers(1, &self.buffer));
        Ok(binding_point_check(gl, 0))
    }
}

/// `CBufferGetPointerv`
#[derive(Default)]
struct BufferGetPointerv {
    buffer: GLuint,
}

impl Subcase for BufferGetPointerv {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut result = DiResult::new();
        let target = glw::GL_DRAW_INDIRECT_BUFFER;

        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer(target, self.buffer));

        let (data_width, data_height) = get_data_size(context);
        let (w, h) = (data_width as u32, data_height as u32);
        let data_ref = data_gen(w, h, 30, 50);
        buffer_data(gl, &data_ref, glw::GL_DYNAMIC_DRAW);

        let mut ptr: *mut c_void = std::ptr::null_mut();
        gl!(gl.get_buffer_pointerv(target, glw::GL_BUFFER_MAP_POINTER, &mut ptr));

        if !ptr.is_null() {
            result.error("glGetBufferPointerv(GL_DRAW_INDIRECT_BUFFER, GL_BUFFER_MAP_POINTER) returned invalid pointer, expected: NULL");
        }

        let buf = gl!(gl.map_buffer_range(target, 0, bytes(data_ref.len()), glw::GL_MAP_READ_BIT));
        if buf.is_null() {
            result.error("glMapBufferRange(GL_DRAW_INDIRECT_BUFFER, GL_MAP_READ_BIT) returned NULL");
            return Ok(result.code());
        }

        gl!(gl.get_buffer_pointerv(target, glw::GL_BUFFER_MAP_POINTER, &mut ptr));

        if ptr.is_null() {
            result.error("glGetBufferPointerv(GL_DRAW_INDIRECT_BUFFER, GL_BUFFER_MAP_POINTER) returned NULL");
        } else {
            result.sub_result(buffer_check(&data_ref, w, h, ptr, w, h, 0, 0));
        }

        if ptr != buf {
            result.error("glGetBufferPointerv(GL_DRAW_INDIRECT_BUFFER, GL_BUFFER_MAP_POINTER) different pointer than glMapBuffer(GL_DRAW_INDIRECT_BUFFER)");
        }

        unmap_expecting_true(gl, &mut result, false);

        Ok(result.code())
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_buffers(1, &self.buffer));
        Ok(binding_point_check(gl, 0))
    }
}

/// `CBufferMapRange`
#[derive(Default)]
struct BufferMapRange {
    buffer: GLuint,
}

impl Subcase for BufferMapRange {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut result = DiResult::new();
        let target = glw::GL_DRAW_INDIRECT_BUFFER;

        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer(target, self.buffer));

        let (data_width, data_height) = get_data_size(context);
        let (w, h) = (data_width as u32, data_height as u32);
        let data_ref = data_gen(w, h, 30, 50);
        buffer_data(gl, &data_ref, glw::GL_DYNAMIC_DRAW);
        let len = data_ref.len();

        result.sub_result(state_validate(gl, GL_FALSE_BYTE, glw::GL_READ_WRITE, 0, 0, 0));

        let buf = gl!(gl.map_buffer_range(target, 0, bytes(len), glw::GL_MAP_READ_BIT));
        if buf.is_null() {
            result.error("glMapBuffer(GL_DRAW_INDIRECT_BUFFER, GL_MAP_READ_BIT) returned NULL");
        } else {
            result.sub_result(buffer_check(&data_ref, w, h, buf, w, h, 0, 0));
            result.sub_result(state_validate(
                gl,
                GL_TRUE_BYTE,
                glw::GL_READ_ONLY,
                glw::GL_MAP_READ_BIT,
                0,
                bytes(len),
            ));
            unmap_expecting_true(gl, &mut result, false);
            result.sub_result(state_validate(gl, GL_FALSE_BYTE, glw::GL_READ_WRITE, 0, 0, 0));
        }

        let buf = gl!(gl.map_buffer_range(target, 0, bytes(len / 2), glw::GL_MAP_READ_BIT));
        if buf.is_null() {
            result.error("glMapBufferRange(GL_DRAW_INDIRECT_BUFFER, GL_MAP_READ_BIT) returned NULL");
        } else {
            result.sub_result(buffer_check(&data_ref, w, h / 2, buf, w, h / 2, 0, 0));
            result.sub_result(state_validate(
                gl,
                GL_TRUE_BYTE,
                glw::GL_READ_ONLY,
                glw::GL_MAP_READ_BIT,
                0,
                bytes(len / 2),
            ));
            unmap_expecting_true(gl, &mut result, false);
            result.sub_result(state_validate(gl, GL_FALSE_BYTE, glw::GL_READ_WRITE, 0, 0, 0));
        }

        let buf = gl!(gl.map_buffer_range(target, bytes(len / 4), bytes(len / 2), glw::GL_MAP_READ_BIT));
        if buf.is_null() {
            result.error("glMapBufferRange(GL_DRAW_INDIRECT_BUFFER, GL_MAP_READ_BIT) returned NULL");
        } else {
            result.sub_result(buffer_check(&data_ref, w, h / 2, buf, w, h / 2, h / 4, 0));
            result.sub_result(state_validate(
                gl,
                GL_TRUE_BYTE,
                glw::GL_READ_ONLY,
                glw::GL_MAP_READ_BIT,
                bytes(len / 4),
                bytes(len / 2),
            ));
            unmap_expecting_true(gl, &mut result, false);
            result.sub_result(state_validate(gl, GL_FALSE_BYTE, glw::GL_READ_WRITE, 0, 0, 0));
        }

        Ok(result.code())
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_buffers(1, &self.buffer));
        Ok(binding_point_check(gl, 0))
    }
}

/// `CBufferFlushMappedRange`
#[derive(Default)]
struct BufferFlushMappedRange {
    buffer: GLuint,
}

impl Subcase for BufferFlushMappedRange {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut result = DiResult::new();
        let target = glw::GL_DRAW_INDIRECT_BUFFER;

        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer(target, self.buffer));

        let (data_width, data_height) = get_data_size(context);
        let (w, h) = (data_width as u32, data_height as u32);
        let data_ref = data_gen(w, h, 1, 1000);
        let data_ref2 = data_gen(w, h, 1000, 2000);

        let half_size = (h / 2 * w) as usize;
        let quarter_size = (h / 4 * w) as usize;

        buffer_data(gl, &data_ref, glw::GL_DYNAMIC_DRAW);

        result.sub_result(state_validate(gl, GL_FALSE_BYTE, glw::GL_READ_WRITE, 0, 0, 0));

        let buf = gl!(gl.map_buffer_range(
            target,
            bytes(quarter_size),
            bytes(half_size),
            glw::GL_MAP_WRITE_BIT | glw::GL_MAP_FLUSH_EXPLICIT_BIT
        ));

        if buf.is_null() {
            result.error("glMapBufferRange(GL_DRAW_INDIRECT_BUFFER, GL_MAP_WRITE_BIT) returned NULL");
        } else {
            result.sub_result(state_validate(
                gl,
                GL_TRUE_BYTE,
                glw::GL_WRITE_ONLY,
                glw::GL_MAP_WRITE_BIT | glw::GL_MAP_FLUSH_EXPLICIT_BIT,
                bytes(quarter_size),
                bytes(half_size),
            ));

            // SAFETY: `half_size` words are mapped for writing, and `data_ref2` holds at least `quarter_size + half_size` words.
            unsafe { std::ptr::copy_nonoverlapping(data_ref2[quarter_size..].as_ptr(), buf.cast::<u32>(), half_size) };
            gl!(gl.flush_mapped_buffer_range(target, 0, bytes(half_size)));

            unmap_expecting_true(gl, &mut result, false);
            result.sub_result(state_validate(gl, GL_FALSE_BYTE, glw::GL_READ_WRITE, 0, 0, 0));
        }

        let mut data_test = vec![0u32; (w * h) as usize];
        get_buffer_sub_data(gl, target, 0, &mut data_test);

        result.sub_result(data_compare_plain(&data_ref, w, h / 4, &data_test, w, h / 4));
        result.sub_result(data_compare(&data_ref2, w, h / 2, &data_test, w, h / 2, h / 4, h / 4));
        result.sub_result(data_compare(
            &data_ref,
            w,
            h / 4,
            &data_test,
            w,
            h / 4,
            h * 3 / 4,
            h * 3 / 4,
        ));

        Ok(result.code())
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_buffers(1, &self.buffer));
        Ok(binding_point_check(gl, 0))
    }
}

/// `CBufferCopySubData`
#[derive(Default)]
struct BufferCopySubData {
    buffers: [GLuint; 2],
}

impl Subcase for BufferCopySubData {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut result = DiResult::new();
        let (data_width, data_height) = get_data_size(context);
        let (w, h) = (data_width as u32, data_height as u32);
        let mut data_test = vec![0u32; (w * h) as usize];

        gl!(gl.gen_buffers(2, self.buffers.as_mut_ptr()));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.buffers[0]));

        let data_ref1 = data_gen(w, h, 1, 100);
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            bytes(data_ref1.len()),
            data_ref1.as_ptr().cast(),
            glw::GL_DYNAMIC_DRAW
        ));

        get_buffer_sub_data(gl, glw::GL_ARRAY_BUFFER, 0, &mut data_test);
        result.sub_result(data_compare_plain(&data_ref1, w, h, &data_test, w, h));

        gl!(gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, self.buffers[1]));

        let data_ref2 = data_gen(w, h, 10, 30);
        buffer_data(gl, &data_ref2, glw::GL_DYNAMIC_DRAW);

        get_buffer_sub_data(gl, glw::GL_DRAW_INDIRECT_BUFFER, 0, &mut data_test);
        result.sub_result(data_compare_plain(&data_ref2, w, h, &data_test, w, h));

        gl!(gl.copy_buffer_sub_data(
            glw::GL_ARRAY_BUFFER,
            glw::GL_DRAW_INDIRECT_BUFFER,
            0,
            0,
            bytes(data_test.len())
        ));

        get_buffer_sub_data(gl, glw::GL_DRAW_INDIRECT_BUFFER, 0, &mut data_test);
        result.sub_result(data_compare_plain(&data_ref1, w, h, &data_test, w, h));

        buffer_data(gl, &data_ref2, glw::GL_DYNAMIC_DRAW);

        get_buffer_sub_data(gl, glw::GL_DRAW_INDIRECT_BUFFER, 0, &mut data_test);
        result.sub_result(data_compare_plain(&data_ref2, w, h, &data_test, w, h));

        gl!(gl.copy_buffer_sub_data(
            glw::GL_DRAW_INDIRECT_BUFFER,
            glw::GL_ARRAY_BUFFER,
            0,
            0,
            bytes(data_test.len())
        ));

        get_buffer_sub_data(gl, glw::GL_ARRAY_BUFFER, 0, &mut data_test);
        result.sub_result(data_compare_plain(&data_ref2, w, h, &data_test, w, h));

        Ok(result.code())
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_buffers(2, self.buffers.as_ptr()));
        Ok(binding_point_check(gl, 0))
    }
}

pub(super) fn add_binding_and_buffer_cases(group: &mut TestCaseGroup) {
    add_case(group, "basic-binding-default", || Box::new(DefaultBindingPoint));
    add_case(group, "basic-binding-zero", || Box::new(ZeroBindingPoint));
    add_case(group, "basic-binding-single", || Box::<SingleBindingPoint>::default());
    add_case(group, "basic-binding-multi", || Box::<MultiBindingPoint>::default());
    add_case(group, "basic-binding-delete", || Box::<DeleteBindingPoint>::default());

    add_case(group, "basic-buffer-data", || Box::<BufferData>::default());
    add_case(group, "basic-buffer-subData", || Box::<BufferSubData>::default());
    add_case(group, "basic-buffer-unMap", || Box::<BufferMap>::default());
    add_case(group, "basic-buffer-getPointerv", || {
        Box::<BufferGetPointerv>::default()
    });
    add_case(group, "basic-buffer-mapRange", || Box::<BufferMapRange>::default());
    add_case(group, "basic-buffer-flushMappedRange", || {
        Box::<BufferFlushMappedRange>::default()
    });
    add_case(group, "basic-buffer-copySubData", || {
        Box::<BufferCopySubData>::default()
    });
}
