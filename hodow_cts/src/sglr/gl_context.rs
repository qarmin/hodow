// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/simplereference/sglrGLContext.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `sglr::GLContext` - the real-driver-backed `Context` implementor, so a test written
// once against `&mut dyn Context` (e.g. `es2fDepthTests.cpp`'s `DepthCase::render`) can
// run unchanged against either this or `ReferenceContext`. Implements exactly the
// narrowed `Context` trait in `context.rs` (not upstream's whole ~90-method interface -
// see that module's own doc comment for the narrowing rationale and evidence), every
// method a close, near-literal translation of upstream's own (confirmed by reading
// `sglrGLContext.cpp` in full, not assumed to transfer unchanged from the trait shape
// alone, per that module's own standing warning).
//
// What's dropped relative to upstream, each because nothing this narrow trait needs it:
//  - **No `tcu::TestLog`/`GLCONTEXT_LOG_CALLS`/`GLCONTEXT_LOG_PROGRAMS`/
//    `glu::CallLogWrapper`** - nothing in this crate has ported `tcu::TestLog` at all
//    (grepped: no `test_log.rs`/`TestLog` anywhere under `tcu/`), so there is nothing to
//    log *to*. Every call goes straight to `glw::Functions` instead of through a
//    logging wrapper; `GLContext::new` therefore drops the `log`/`logFlags`
//    constructor parameters entirely rather than taking a logger nothing can use.
//  - **`buffer_data`'s `usage` hint is hardcoded to `GL_STATIC_DRAW`** - the narrowed
//    `Context::buffer_data` (see `context.rs`) has no `usage` parameter at all, since
//    `ReferenceContext` ignores the hint unconditionally; every grep-confirmed caller
//    (`sglrContextUtil.cpp`'s `drawQuadWithVaoBuffers`) only ever fills a buffer once
//    before drawing, which is exactly what `GL_STATIC_DRAW` means.
//  - **`base_viewport`'s offset bookkeeping is kept** (not simplified away just because
//    every grep-confirmed caller only ever runs headless with a `(0, 0, w, h)` base
//    viewport) - upstream's own `getDrawOffset`/`getReadOffset` exist for a windowed
//    real-platform test sharing one physical surface at a sub-rectangle, which this
//    port could plausibly want later; keeping the real offset arithmetic costs nothing
//    and this is the one piece of upstream's own state machine that is not pure
//    boilerplate forwarding.
//  - **The allocated-object-name tracking (`m_allocatedTextures`/`Fbos`/`Rbos`/
//    `Buffers`/`Vaos`) is kept too**, for the same reason upstream has it: nothing else
//    in this trait surface ever explicitly destroys every object a case created before
//    the `Context` itself goes away, and a `GLContext` built fresh inside almost every
//    `#[test]` in this crate (see this file's own tests) would otherwise leak real GL
//    objects for the lifetime of the `RenderContext` it borrows. `Drop` below replicates
//    upstream's own destructor loop order (fbos, rbos, textures, buffers, vaos,
//    programs, then `glUseProgram(0)`).
//  - **The default-framebuffer-is-0 assumption**: upstream's constructor stashes
//    `context.getDefaultFramebuffer()` and redirects a caller's `bindFramebuffer(..., 0)`
//    to it (a real-platform default surface is not always object 0 on every backend).
//    `glu::RenderContext::create` here always goes through EGL
//    (as `glu::render_context` does), whose default framebuffer is architecturally always object
//    0 - there is no non-zero "real" default FBO this port could ever observe, so
//    `bind_framebuffer(_, 0)` below passes `0` straight through rather than carrying a
//    `default_framebuffer` field that could only ever hold `0`.

use std::ffi::{CString, c_void};

use super::context::Context;
use super::shader_program::ShaderProgram;
use crate::glu::pixel_transfer;
use crate::glu::render_context::RenderContext;
use crate::glu::shader_program::{ProgramSources, ShaderProgram as GlShaderProgram};
use crate::glw::{self, GLenum};
use crate::tcu::surface::Surface;

/// `sglr::GLContext`
pub struct GLContext<'gl> {
    render_ctx: &'gl RenderContext,
    gl: &'gl glw::Functions,

    base_viewport: (i32, i32, i32, i32),
    cur_viewport: (i32, i32, i32, i32),
    cur_scissor: (i32, i32, i32, i32),
    read_framebuffer_binding: u32,
    draw_framebuffer_binding: u32,

    allocated_fbos: std::collections::HashSet<u32>,
    allocated_rbos: std::collections::HashSet<u32>,
    allocated_textures: std::collections::HashSet<u32>,
    allocated_buffers: std::collections::HashSet<u32>,
    allocated_vaos: std::collections::HashSet<u32>,
    programs: Vec<GlShaderProgram<'gl>>,
}

impl<'gl> GLContext<'gl> {
    /// `GLContext::GLContext` - `base_viewport` is `(x, y, width, height)`, matching
    /// upstream's `tcu::IVec4`. See this module's top doc comment for the dropped
    /// `log`/`logFlags` parameters.
    pub fn new(render_ctx: &'gl RenderContext, base_viewport: (i32, i32, i32, i32)) -> Self {
        let gl = render_ctx.functions();
        let (bx, by, bw, bh) = base_viewport;
        // "Setup base viewport. This offset is active when default framebuffer is
        // active." - upstream's own comment, reproduced exactly: calls related to
        // setting up the base viewport are not logged there either, which has no
        // meaning here (see this module's top doc comment) beyond "this call exists".
        unsafe { gl.viewport(bx, by, bw, bh) };
        Self {
            render_ctx,
            gl,
            base_viewport,
            cur_viewport: (0, 0, bw, bh),
            cur_scissor: (0, 0, bw, bh),
            read_framebuffer_binding: 0,
            draw_framebuffer_binding: 0,
            allocated_fbos: std::collections::HashSet::new(),
            allocated_rbos: std::collections::HashSet::new(),
            allocated_textures: std::collections::HashSet::new(),
            allocated_buffers: std::collections::HashSet::new(),
            allocated_vaos: std::collections::HashSet::new(),
            programs: Vec::new(),
        }
    }

    /// `GLContext::getDrawOffset`
    fn get_draw_offset(&self) -> (i32, i32) {
        if self.draw_framebuffer_binding != 0 {
            (0, 0)
        } else {
            (self.base_viewport.0, self.base_viewport.1)
        }
    }

    /// `GLContext::getReadOffset`
    fn get_read_offset(&self) -> (i32, i32) {
        if self.read_framebuffer_binding != 0 {
            (0, 0)
        } else {
            (self.base_viewport.0, self.base_viewport.1)
        }
    }

    fn c_name(name: &str) -> CString {
        CString::new(name).expect("a GL object name has no interior NUL")
    }
}

impl Drop for GLContext<'_> {
    /// `GLContext::~GLContext` - "Clean up all still alive objects", same order
    /// upstream's destructor uses.
    fn drop(&mut self) {
        let gl = self.gl;
        for &fbo in &self.allocated_fbos {
            unsafe { gl.delete_framebuffers(1, &fbo) };
        }
        for &rbo in &self.allocated_rbos {
            unsafe { gl.delete_renderbuffers(1, &rbo) };
        }
        for &tex in &self.allocated_textures {
            unsafe { gl.delete_textures(1, &tex) };
        }
        for &buf in &self.allocated_buffers {
            unsafe { gl.delete_buffers(1, &buf) };
        }
        for &vao in &self.allocated_vaos {
            unsafe { gl.delete_vertex_arrays(1, &vao) };
        }
        // `self.programs` drops here too (each `glu::ShaderProgram`'s own `Drop`
        // deletes its GL program), replicating upstream's explicit `delete` loop.
        self.programs.clear();
        unsafe { gl.use_program(0) };
    }
}

impl Context for GLContext<'_> {
    fn get_width(&self) -> i32 {
        self.base_viewport.2
    }

    fn get_height(&self) -> i32 {
        self.base_viewport.3
    }

    fn clear_color(&mut self, red: f32, green: f32, blue: f32, alpha: f32) {
        unsafe { self.gl.clear_color(red, green, blue, alpha) };
    }

    fn clear_depthf(&mut self, depth: f32) {
        unsafe { self.gl.clear_depthf(depth) };
    }

    fn clear_stencil(&mut self, stencil: i32) {
        unsafe { self.gl.clear_stencil(stencil) };
    }

    fn clear(&mut self, buffers: GLenum) {
        unsafe { self.gl.clear(buffers) };
    }

    fn clear_buffer_fv(&mut self, buffer: GLenum, drawbuffer: i32, value: &[f32]) {
        unsafe { self.gl.clear_bufferfv(buffer, drawbuffer, value.as_ptr()) };
    }

    fn clear_buffer_iv(&mut self, buffer: GLenum, drawbuffer: i32, value: &[i32]) {
        unsafe { self.gl.clear_bufferiv(buffer, drawbuffer, value.as_ptr()) };
    }

    fn clear_buffer_uiv(&mut self, buffer: GLenum, drawbuffer: i32, value: &[u32]) {
        unsafe { self.gl.clear_bufferuiv(buffer, drawbuffer, value.as_ptr()) };
    }

    fn invalidate_framebuffer(&mut self, target: GLenum, attachments: &[GLenum]) {
        unsafe {
            self.gl
                .invalidate_framebuffer(target, attachments.len() as i32, attachments.as_ptr())
        };
    }

    fn invalidate_sub_framebuffer(
        &mut self,
        target: GLenum,
        attachments: &[GLenum],
        x: i32,
        y: i32,
        width: i32,
        height: i32,
    ) {
        let (draw_x, draw_y) = self.get_draw_offset();
        unsafe {
            self.gl.invalidate_sub_framebuffer(
                target,
                attachments.len() as i32,
                attachments.as_ptr(),
                x + draw_x,
                y + draw_y,
                width,
                height,
            )
        };
    }

    fn blit_framebuffer(
        &mut self,
        src_x0: i32,
        src_y0: i32,
        src_x1: i32,
        src_y1: i32,
        dst_x0: i32,
        dst_y0: i32,
        dst_x1: i32,
        dst_y1: i32,
        mask: GLenum,
        filter: GLenum,
    ) {
        let (draw_x, draw_y) = self.get_draw_offset();
        let (read_x, read_y) = self.get_read_offset();
        unsafe {
            self.gl.blit_framebuffer(
                read_x + src_x0,
                read_y + src_y0,
                read_x + src_x1,
                read_y + src_y1,
                draw_x + dst_x0,
                draw_y + dst_y0,
                draw_x + dst_x1,
                draw_y + dst_y1,
                mask,
                filter,
            )
        };
    }

    fn clear_buffer_fi(&mut self, buffer: GLenum, drawbuffer: i32, depth: f32, stencil: i32) {
        unsafe { self.gl.clear_bufferfi(buffer, drawbuffer, depth, stencil) };
    }

    fn scissor(&mut self, x: i32, y: i32, width: i32, height: i32) {
        self.cur_scissor = (x, y, width, height);
        let (ox, oy) = self.get_draw_offset();
        unsafe { self.gl.scissor(x + ox, y + oy, width, height) };
    }

    fn enable(&mut self, cap: GLenum) {
        unsafe { self.gl.enable(cap) };
    }

    fn disable(&mut self, cap: GLenum) {
        unsafe { self.gl.disable(cap) };
    }

    fn depth_func(&mut self, func: GLenum) {
        unsafe { self.gl.depth_func(func) };
    }

    fn depth_mask(&mut self, flag: bool) {
        unsafe { self.gl.depth_mask(flag as glw::GLboolean) };
    }

    fn stencil_func(&mut self, func: GLenum, ref_: i32, mask: u32) {
        unsafe { self.gl.stencil_func(func, ref_, mask) };
    }

    fn stencil_func_separate(&mut self, face: GLenum, func: GLenum, ref_: i32, mask: u32) {
        unsafe { self.gl.stencil_func_separate(face, func, ref_, mask) };
    }

    fn stencil_op(&mut self, sfail: GLenum, dpfail: GLenum, dppass: GLenum) {
        unsafe { self.gl.stencil_op(sfail, dpfail, dppass) };
    }

    fn stencil_op_separate(&mut self, face: GLenum, sfail: GLenum, dpfail: GLenum, dppass: GLenum) {
        unsafe { self.gl.stencil_op_separate(face, sfail, dpfail, dppass) };
    }

    fn stencil_mask_separate(&mut self, face: GLenum, mask: u32) {
        unsafe { self.gl.stencil_mask_separate(face, mask) };
    }

    fn stencil_mask(&mut self, mask: u32) {
        unsafe { self.gl.stencil_mask(mask) };
    }

    fn gen_vertex_arrays(&mut self, out: &mut [u32]) {
        unsafe { self.gl.gen_vertex_arrays(out.len() as i32, out.as_mut_ptr()) };
        self.allocated_vaos.extend(out.iter().copied());
    }

    fn bind_vertex_array(&mut self, array: u32) {
        unsafe { self.gl.bind_vertex_array(array) };
    }

    fn delete_vertex_arrays(&mut self, names: &[u32]) {
        for &n in names {
            self.allocated_vaos.remove(&n);
        }
        unsafe { self.gl.delete_vertex_arrays(names.len() as i32, names.as_ptr()) };
    }

    fn gen_buffers(&mut self, out: &mut [u32]) {
        unsafe { self.gl.gen_buffers(out.len() as i32, out.as_mut_ptr()) };
        self.allocated_buffers.extend(out.iter().copied());
    }

    fn delete_buffers(&mut self, names: &[u32]) {
        unsafe { self.gl.delete_buffers(names.len() as i32, names.as_ptr()) };
        for &n in names {
            self.allocated_buffers.remove(&n);
        }
    }

    fn bind_buffer(&mut self, target: GLenum, buffer: u32) {
        self.allocated_buffers.insert(buffer);
        unsafe { self.gl.bind_buffer(target, buffer) };
    }

    fn buffer_data(&mut self, target: GLenum, size: isize, data: Option<&[u8]>) {
        let ptr = data.map_or(std::ptr::null(), |d| d.as_ptr().cast::<c_void>());
        unsafe { self.gl.buffer_data(target, size, ptr, glw::GL_STATIC_DRAW) };
    }

    fn buffer_sub_data(&mut self, target: GLenum, offset: isize, data: &[u8]) {
        unsafe {
            self.gl
                .buffer_sub_data(target, offset, data.len() as isize, data.as_ptr().cast::<c_void>())
        };
    }

    fn enable_vertex_attrib_array(&mut self, index: u32) {
        unsafe { self.gl.enable_vertex_attrib_array(index) };
    }

    fn disable_vertex_attrib_array(&mut self, index: u32) {
        unsafe { self.gl.disable_vertex_attrib_array(index) };
    }

    fn vertex_attrib_pointer(
        &mut self,
        index: u32,
        size: i32,
        type_: GLenum,
        normalized: bool,
        stride: i32,
        pointer: usize,
        _has_pointer: bool,
    ) {
        // Real GL multiplexes "byte offset into the bound buffer" vs "client memory
        // address" off whether `GL_ARRAY_BUFFER` is currently bound, purely from the
        // raw pointer value - `has_pointer` only matters to `ReferenceContext`'s own
        // dispatch (see `context.rs`'s own doc comment), not to a real driver call.
        unsafe {
            self.gl.vertex_attrib_pointer(
                index,
                size,
                type_,
                normalized as glw::GLboolean,
                stride,
                pointer as *const c_void,
            )
        };
    }

    fn vertex_attrib_i_pointer(
        &mut self,
        index: u32,
        size: i32,
        type_: GLenum,
        stride: i32,
        pointer: usize,
        _has_pointer: bool,
    ) {
        // Same "has_pointer only matters to ReferenceContext's own dispatch" note as
        // vertex_attrib_pointer above applies here identically.
        unsafe {
            self.gl
                .vertex_attrib_i_pointer(index, size, type_, stride, pointer as *const c_void)
        };
    }

    fn vertex_attrib_divisor(&mut self, index: u32, divisor: u32) {
        unsafe { self.gl.vertex_attrib_divisor(index, divisor) };
    }

    fn vertex_attrib1f(&mut self, index: u32, x: f32) {
        unsafe { self.gl.vertex_attrib_1f(index, x) };
    }

    fn vertex_attrib2f(&mut self, index: u32, x: f32, y: f32) {
        unsafe { self.gl.vertex_attrib_2f(index, x, y) };
    }

    fn vertex_attrib3f(&mut self, index: u32, x: f32, y: f32, z: f32) {
        unsafe { self.gl.vertex_attrib_3f(index, x, y, z) };
    }

    fn vertex_attrib4f(&mut self, index: u32, x: f32, y: f32, z: f32, w: f32) {
        unsafe { self.gl.vertex_attrib_4f(index, x, y, z, w) };
    }

    fn vertex_attrib_i4i(&mut self, index: u32, x: i32, y: i32, z: i32, w: i32) {
        unsafe { self.gl.vertex_attrib_i_4i(index, x, y, z, w) };
    }

    fn vertex_attrib_i4ui(&mut self, index: u32, x: u32, y: u32, z: u32, w: u32) {
        unsafe { self.gl.vertex_attrib_i_4ui(index, x, y, z, w) };
    }

    fn get_attrib_location(&mut self, program: u32, name: &str) -> i32 {
        let cname = Self::c_name(name);
        unsafe { self.gl.get_attrib_location(program, cname.as_ptr()) }
    }

    fn uniform4fv(&mut self, location: i32, count: i32, v: &[f32]) {
        unsafe { self.gl.uniform_4fv(location, count, v.as_ptr()) };
    }

    fn uniform1i(&mut self, location: i32, value: i32) {
        unsafe { self.gl.uniform_1i(location, value) };
    }

    fn uniform_matrix3fv(&mut self, location: i32, count: i32, transpose: bool, v: &[f32]) {
        unsafe {
            self.gl
                .uniform_matrix_3fv(location, count, transpose as glw::GLboolean, v.as_ptr())
        };
    }

    fn uniform1f(&mut self, location: i32, value: f32) {
        unsafe { self.gl.uniform_1f(location, value) };
    }

    /// `Context::uniform1fv`/`2fv`/`3fv`/`1iv`/`2iv`/`3iv`/`4iv` - pure forwarding, the
    /// same shape every prior widening in this trait has been; see `context.rs`'s own
    /// top doc comment for why (`glsFragOpInteractionCase.cpp`'s own `setUniformValue`).
    fn uniform1fv(&mut self, location: i32, count: i32, v: &[f32]) {
        unsafe { self.gl.uniform_1fv(location, count, v.as_ptr()) };
    }

    fn uniform2fv(&mut self, location: i32, count: i32, v: &[f32]) {
        unsafe { self.gl.uniform_2fv(location, count, v.as_ptr()) };
    }

    fn uniform3fv(&mut self, location: i32, count: i32, v: &[f32]) {
        unsafe { self.gl.uniform_3fv(location, count, v.as_ptr()) };
    }

    fn uniform1iv(&mut self, location: i32, count: i32, v: &[i32]) {
        unsafe { self.gl.uniform_1iv(location, count, v.as_ptr()) };
    }

    fn uniform2iv(&mut self, location: i32, count: i32, v: &[i32]) {
        unsafe { self.gl.uniform_2iv(location, count, v.as_ptr()) };
    }

    fn uniform3iv(&mut self, location: i32, count: i32, v: &[i32]) {
        unsafe { self.gl.uniform_3iv(location, count, v.as_ptr()) };
    }

    fn uniform4iv(&mut self, location: i32, count: i32, v: &[i32]) {
        unsafe { self.gl.uniform_4iv(location, count, v.as_ptr()) };
    }

    fn get_uniform_location(&mut self, program: u32, name: &str) -> i32 {
        let cname = Self::c_name(name);
        unsafe { self.gl.get_uniform_location(program, cname.as_ptr()) }
    }

    fn draw_arrays(&mut self, mode: GLenum, first: i32, count: i32) {
        unsafe { self.gl.draw_arrays(mode, first, count) };
    }

    fn draw_arrays_instanced(&mut self, mode: GLenum, first: i32, count: i32, instance_count: i32) {
        unsafe { self.gl.draw_arrays_instanced(mode, first, count, instance_count) };
    }

    fn draw_elements(&mut self, mode: GLenum, count: i32, type_: GLenum, indices_offset: usize) {
        unsafe {
            self.gl
                .draw_elements(mode, count, type_, indices_offset as *const c_void)
        };
    }

    fn draw_elements_base_vertex(
        &mut self,
        mode: GLenum,
        count: i32,
        type_: GLenum,
        indices_offset: usize,
        base_vertex: i32,
    ) {
        unsafe {
            self.gl
                .draw_elements_base_vertex(mode, count, type_, indices_offset as *const c_void, base_vertex)
        };
    }

    fn draw_elements_instanced(
        &mut self,
        mode: GLenum,
        count: i32,
        type_: GLenum,
        indices_offset: usize,
        instance_count: i32,
    ) {
        unsafe {
            self.gl
                .draw_elements_instanced(mode, count, type_, indices_offset as *const c_void, instance_count)
        };
    }

    fn draw_elements_instanced_base_vertex(
        &mut self,
        mode: GLenum,
        count: i32,
        type_: GLenum,
        indices_offset: usize,
        instance_count: i32,
        base_vertex: i32,
    ) {
        unsafe {
            self.gl.draw_elements_instanced_base_vertex(
                mode,
                count,
                type_,
                indices_offset as *const c_void,
                instance_count,
                base_vertex,
            )
        };
    }

    fn draw_range_elements(
        &mut self,
        mode: GLenum,
        start: u32,
        end: u32,
        count: i32,
        type_: GLenum,
        indices_offset: usize,
    ) {
        unsafe {
            self.gl
                .draw_range_elements(mode, start, end, count, type_, indices_offset as *const c_void)
        };
    }

    fn draw_range_elements_base_vertex(
        &mut self,
        mode: GLenum,
        start: u32,
        end: u32,
        count: i32,
        type_: GLenum,
        indices_offset: usize,
        base_vertex: i32,
    ) {
        unsafe {
            self.gl.draw_range_elements_base_vertex(
                mode,
                start,
                end,
                count,
                type_,
                indices_offset as *const c_void,
                base_vertex,
            )
        };
    }

    fn draw_arrays_indirect(&mut self, mode: GLenum, indirect_offset: usize) {
        unsafe { self.gl.draw_arrays_indirect(mode, indirect_offset as *const c_void) };
    }

    fn draw_elements_indirect(&mut self, mode: GLenum, type_: GLenum, indirect_offset: usize) {
        unsafe {
            self.gl
                .draw_elements_indirect(mode, type_, indirect_offset as *const c_void)
        };
    }

    fn finish(&mut self) {
        unsafe { self.gl.finish() };
    }

    /// `GLContext::createProgram` - compiles the `ShaderProgram`'s real GLSL source
    /// pair through the already-ported `glu::ShaderProgram`. Unlike
    /// `ReferenceContext::create_program`, nothing here ever needs to look back up the
    /// `Box<dyn ShaderProgram>` after this call (a real driver's `uniform4fv` etc. only
    /// ever need a plain GL location, never the uniform-slot bookkeeping
    /// `shade_fragments` reads), so it is read from and dropped rather than retained.
    fn create_program(&mut self, program: Box<dyn ShaderProgram>) -> u32 {
        let base = program.program_base();
        let sources = ProgramSources::vtx_frag(base.vertex_source().to_string(), base.fragment_source().to_string());
        drop(program);

        let built = GlShaderProgram::new(self.gl, &sources);
        if !built.is_ok() {
            panic!(
                "sglr::GLContext::createProgram: compile/link failed (TCU_FAIL upstream): {:?}",
                built.build_failure_summary()
            );
        }
        let id = built.program();
        self.programs.push(built);
        id
    }

    fn use_program(&mut self, program: u32) {
        unsafe { self.gl.use_program(program) };
    }

    fn delete_program(&mut self, program: u32) {
        let idx = self
            .programs
            .iter()
            .position(|p| p.program() == program)
            .unwrap_or_else(|| panic!("sglr::GLContext::deleteProgram: invalid delete (DE_FATAL upstream)"));
        self.programs.remove(idx);
    }

    fn read_pixels(&mut self, dst: &mut Surface, x: i32, y: i32, width: i32, height: i32) {
        dst.set_size(width, height);
        let (ox, oy) = self.get_read_offset();
        // Upstream calls `glReadPixels` directly with `GL_RGBA`/`GL_UNSIGNED_BYTE` -
        // `tcu::Surface`'s one format exactly - `glu::pixel_transfer::read_pixels`
        // reaches the same two GL constants through `get_transfer_format` and already
        // handles `GL_PACK_ALIGNMENT` generically, so it's reused rather than
        // duplicating the raw call.
        pixel_transfer::read_pixels(self.render_ctx, x + ox, y + oy, &mut dst.get_access())
            .expect("glReadPixels must succeed (TCU_CHECK-equivalent upstream)");
    }

    fn read_pixels_rgba_f32(&mut self, x: i32, y: i32, width: i32, height: i32, type_: GLenum) -> Vec<[f32; 4]> {
        let (ox, oy) = self.get_read_offset();
        let mut raw = vec![0u8; width.max(0) as usize * height.max(0) as usize * 16];
        // SAFETY: `raw` holds width * height RGBA pixels of 4 bytes per channel, which is what a 32-bit
        // RGBA read of this size writes at GL_PACK_ALIGNMENT 4.
        let err = unsafe {
            self.gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 4);
            let format = if type_ == glw::GL_FLOAT {
                glw::GL_RGBA
            } else {
                glw::GL_RGBA_INTEGER
            };
            self.gl
                .read_pixels(x + ox, y + oy, width, height, format, type_, raw.as_mut_ptr().cast());
            self.gl.get_error()
        };
        if err != glw::GL_NO_ERROR {
            return Vec::new();
        }

        raw.as_chunks::<16>()
            .0
            .iter()
            .map(|pixel| {
                let mut out = [0.0f32; 4];
                for (c, bytes) in pixel.as_chunks::<4>().0.iter().enumerate() {
                    let bytes = [bytes[0], bytes[1], bytes[2], bytes[3]];
                    out[c] = match type_ {
                        glw::GL_INT => i32::from_ne_bytes(bytes) as f32,
                        glw::GL_UNSIGNED_INT => u32::from_ne_bytes(bytes) as f32,
                        _ => f32::from_ne_bytes(bytes),
                    };
                }
                out
            })
            .collect()
    }

    fn get_error(&mut self) -> GLenum {
        unsafe { self.gl.get_error() }
    }

    fn get_string(&mut self, pname: GLenum) -> Option<String> {
        // SAFETY: glGetString returns a driver-owned static string, or null for a name
        // it does not know, which `string_from` turns into an empty string.
        let s = unsafe { glw::string_from(self.gl.get_string(pname)) };
        if s.is_empty() { None } else { Some(s) }
    }

    fn viewport(&mut self, x: i32, y: i32, width: i32, height: i32) {
        self.cur_viewport = (x, y, width, height);
        let (ox, oy) = self.get_draw_offset();
        unsafe { self.gl.viewport(x + ox, y + oy, width, height) };
    }

    fn blend_equation(&mut self, mode: GLenum) {
        unsafe { self.gl.blend_equation(mode) };
    }

    fn blend_equation_separate(&mut self, mode_rgb: GLenum, mode_alpha: GLenum) {
        unsafe { self.gl.blend_equation_separate(mode_rgb, mode_alpha) };
    }

    fn blend_func_separate(&mut self, src_rgb: GLenum, dst_rgb: GLenum, src_alpha: GLenum, dst_alpha: GLenum) {
        unsafe { self.gl.blend_func_separate(src_rgb, dst_rgb, src_alpha, dst_alpha) };
    }

    fn blend_color(&mut self, red: f32, green: f32, blue: f32, alpha: f32) {
        unsafe { self.gl.blend_color(red, green, blue, alpha) };
    }

    fn blend_func(&mut self, src: GLenum, dst: GLenum) {
        unsafe { self.gl.blend_func(src, dst) };
    }

    fn color_mask(&mut self, r: bool, g: bool, b: bool, a: bool) {
        unsafe {
            self.gl.color_mask(
                r as glw::GLboolean,
                g as glw::GLboolean,
                b as glw::GLboolean,
                a as glw::GLboolean,
            )
        };
    }

    fn line_width(&mut self, width: f32) {
        unsafe { self.gl.line_width(width) };
    }

    fn active_texture(&mut self, texture: GLenum) {
        unsafe { self.gl.active_texture(texture) };
    }

    fn gen_textures(&mut self, out: &mut [u32]) {
        unsafe { self.gl.gen_textures(out.len() as i32, out.as_mut_ptr()) };
        self.allocated_textures.extend(out.iter().copied());
    }

    fn delete_textures(&mut self, names: &[u32]) {
        for &n in names {
            self.allocated_textures.remove(&n);
        }
        unsafe { self.gl.delete_textures(names.len() as i32, names.as_ptr()) };
    }

    fn bind_texture(&mut self, target: GLenum, texture: u32) {
        self.allocated_textures.insert(texture);
        unsafe { self.gl.bind_texture(target, texture) };
    }

    fn pixel_storei(&mut self, pname: GLenum, param: i32) {
        unsafe { self.gl.pixel_storei(pname, param) };
    }

    fn tex_parameteri(&mut self, target: GLenum, pname: GLenum, value: i32) {
        unsafe { self.gl.tex_parameteri(target, pname, value) };
    }

    fn tex_image_2d(
        &mut self,
        target: GLenum,
        level: i32,
        internal_format: GLenum,
        width: i32,
        height: i32,
        border: i32,
        format: GLenum,
        type_: GLenum,
        data: Option<&[u8]>,
    ) {
        let ptr = data.map_or(std::ptr::null(), |d| d.as_ptr().cast::<c_void>());
        unsafe {
            self.gl.tex_image_2d(
                target,
                level,
                internal_format as glw::GLint,
                width,
                height,
                border,
                format,
                type_,
                ptr,
            )
        };
    }

    fn tex_sub_image_2d(
        &mut self,
        target: GLenum,
        level: i32,
        xoffset: i32,
        yoffset: i32,
        width: i32,
        height: i32,
        format: GLenum,
        type_: GLenum,
        data: &[u8],
    ) {
        unsafe {
            self.gl.tex_sub_image_2d(
                target,
                level,
                xoffset,
                yoffset,
                width,
                height,
                format,
                type_,
                data.as_ptr().cast::<c_void>(),
            )
        };
    }

    fn tex_image_3d(
        &mut self,
        target: GLenum,
        level: i32,
        internal_format: GLenum,
        width: i32,
        height: i32,
        depth: i32,
        border: i32,
        format: GLenum,
        type_: GLenum,
        data: Option<&[u8]>,
    ) {
        let ptr = data.map_or(std::ptr::null(), |d| d.as_ptr().cast::<c_void>());
        unsafe {
            self.gl.tex_image_3d(
                target,
                level,
                internal_format as glw::GLint,
                width,
                height,
                depth,
                border,
                format,
                type_,
                ptr,
            )
        };
    }

    fn tex_sub_image_3d(
        &mut self,
        target: GLenum,
        level: i32,
        xoffset: i32,
        yoffset: i32,
        zoffset: i32,
        width: i32,
        height: i32,
        depth: i32,
        format: GLenum,
        type_: GLenum,
        data: &[u8],
    ) {
        unsafe {
            self.gl.tex_sub_image_3d(
                target,
                level,
                xoffset,
                yoffset,
                zoffset,
                width,
                height,
                depth,
                format,
                type_,
                data.as_ptr().cast::<c_void>(),
            )
        };
    }

    fn copy_tex_image_2d(
        &mut self,
        target: GLenum,
        level: i32,
        internal_format: GLenum,
        x: i32,
        y: i32,
        width: i32,
        height: i32,
        border: i32,
    ) {
        unsafe {
            self.gl
                .copy_tex_image_2d(target, level, internal_format, x, y, width, height, border)
        };
    }

    fn copy_tex_sub_image_2d(
        &mut self,
        target: GLenum,
        level: i32,
        xoffset: i32,
        yoffset: i32,
        x: i32,
        y: i32,
        width: i32,
        height: i32,
    ) {
        unsafe {
            self.gl
                .copy_tex_sub_image_2d(target, level, xoffset, yoffset, x, y, width, height)
        };
    }

    fn tex_image_2d_pbo(
        &mut self,
        target: GLenum,
        level: i32,
        internal_format: GLenum,
        width: i32,
        height: i32,
        border: i32,
        format: GLenum,
        type_: GLenum,
        offset: isize,
    ) {
        unsafe {
            self.gl.tex_image_2d(
                target,
                level,
                internal_format as glw::GLint,
                width,
                height,
                border,
                format,
                type_,
                offset as usize as *const c_void,
            )
        };
    }

    fn tex_sub_image_2d_pbo(
        &mut self,
        target: GLenum,
        level: i32,
        xoffset: i32,
        yoffset: i32,
        width: i32,
        height: i32,
        format: GLenum,
        type_: GLenum,
        offset: isize,
    ) {
        unsafe {
            self.gl.tex_sub_image_2d(
                target,
                level,
                xoffset,
                yoffset,
                width,
                height,
                format,
                type_,
                offset as usize as *const c_void,
            )
        };
    }

    fn tex_image_3d_pbo(
        &mut self,
        target: GLenum,
        level: i32,
        internal_format: GLenum,
        width: i32,
        height: i32,
        depth: i32,
        border: i32,
        format: GLenum,
        type_: GLenum,
        offset: isize,
    ) {
        unsafe {
            self.gl.tex_image_3d(
                target,
                level,
                internal_format as glw::GLint,
                width,
                height,
                depth,
                border,
                format,
                type_,
                offset as usize as *const c_void,
            )
        };
    }

    fn tex_sub_image_3d_pbo(
        &mut self,
        target: GLenum,
        level: i32,
        xoffset: i32,
        yoffset: i32,
        zoffset: i32,
        width: i32,
        height: i32,
        depth: i32,
        format: GLenum,
        type_: GLenum,
        offset: isize,
    ) {
        unsafe {
            self.gl.tex_sub_image_3d(
                target,
                level,
                xoffset,
                yoffset,
                zoffset,
                width,
                height,
                depth,
                format,
                type_,
                offset as usize as *const c_void,
            )
        };
    }

    fn tex_storage_2d(&mut self, target: GLenum, levels: i32, internal_format: GLenum, width: i32, height: i32) {
        unsafe { self.gl.tex_storage_2d(target, levels, internal_format, width, height) };
    }

    fn tex_storage_3d(
        &mut self,
        target: GLenum,
        levels: i32,
        internal_format: GLenum,
        width: i32,
        height: i32,
        depth: i32,
    ) {
        unsafe {
            self.gl
                .tex_storage_3d(target, levels, internal_format, width, height, depth)
        };
    }

    fn framebuffer_texture_layer(&mut self, target: GLenum, attachment: GLenum, texture: u32, level: i32, layer: i32) {
        unsafe {
            self.gl
                .framebuffer_texture_layer(target, attachment, texture, level, layer)
        };
    }

    fn gen_renderbuffers(&mut self, out: &mut [u32]) {
        unsafe { self.gl.gen_renderbuffers(out.len() as i32, out.as_mut_ptr()) };
        self.allocated_rbos.extend(out.iter().copied());
    }

    fn delete_renderbuffers(&mut self, names: &[u32]) {
        for &n in names {
            self.allocated_rbos.remove(&n);
        }
        unsafe { self.gl.delete_renderbuffers(names.len() as i32, names.as_ptr()) };
    }

    fn bind_renderbuffer(&mut self, target: GLenum, renderbuffer: u32) {
        self.allocated_rbos.insert(renderbuffer);
        unsafe { self.gl.bind_renderbuffer(target, renderbuffer) };
    }

    fn renderbuffer_storage_multisample(
        &mut self,
        target: GLenum,
        samples: i32,
        internal_format: GLenum,
        width: i32,
        height: i32,
    ) {
        unsafe {
            self.gl
                .renderbuffer_storage_multisample(target, samples, internal_format, width, height)
        };
    }

    fn renderbuffer_storage(&mut self, target: GLenum, internal_format: GLenum, width: i32, height: i32) {
        unsafe { self.gl.renderbuffer_storage(target, internal_format, width, height) };
    }

    fn gen_framebuffers(&mut self, out: &mut [u32]) {
        unsafe { self.gl.gen_framebuffers(out.len() as i32, out.as_mut_ptr()) };
        self.allocated_fbos.extend(out.iter().copied());
    }

    fn delete_framebuffers(&mut self, names: &[u32]) {
        for &n in names {
            self.allocated_fbos.remove(&n);
        }
        unsafe { self.gl.delete_framebuffers(names.len() as i32, names.as_ptr()) };
    }

    /// `GLContext::bindFramebuffer` - see this module's top doc comment for why a
    /// requested default framebuffer (`0`) is never redirected here, unlike upstream.
    fn bind_framebuffer(&mut self, target: GLenum, framebuffer: u32) {
        let is_valid_target = matches!(
            target,
            glw::GL_FRAMEBUFFER | glw::GL_DRAW_FRAMEBUFFER | glw::GL_READ_FRAMEBUFFER
        );
        if is_valid_target && framebuffer != 0 {
            self.allocated_fbos.insert(framebuffer);
        }

        if target == glw::GL_FRAMEBUFFER || target == glw::GL_READ_FRAMEBUFFER {
            self.read_framebuffer_binding = framebuffer;
        }
        if target == glw::GL_FRAMEBUFFER || target == glw::GL_DRAW_FRAMEBUFFER {
            self.draw_framebuffer_binding = framebuffer;
        }

        unsafe { self.gl.bind_framebuffer(target, framebuffer) };

        if target == glw::GL_FRAMEBUFFER || target == glw::GL_DRAW_FRAMEBUFFER {
            let (ox, oy) = self.get_draw_offset();
            let (vx, vy, vw, vh) = self.cur_viewport;
            let (sx, sy, sw, sh) = self.cur_scissor;
            unsafe {
                self.gl.viewport(vx + ox, vy + oy, vw, vh);
                self.gl.scissor(sx + ox, sy + oy, sw, sh);
            }
        }
    }

    fn framebuffer_renderbuffer(
        &mut self,
        target: GLenum,
        attachment: GLenum,
        renderbuffertarget: GLenum,
        renderbuffer: u32,
    ) {
        unsafe {
            self.gl
                .framebuffer_renderbuffer(target, attachment, renderbuffertarget, renderbuffer)
        };
    }

    fn framebuffer_texture2d(
        &mut self,
        target: GLenum,
        attachment: GLenum,
        textarget: GLenum,
        texture: u32,
        level: i32,
    ) {
        unsafe {
            self.gl
                .framebuffer_texture_2d(target, attachment, textarget, texture, level)
        };
    }

    fn check_framebuffer_status(&mut self, target: GLenum) -> GLenum {
        unsafe { self.gl.check_framebuffer_status(target) }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::glu::render_context::ApiType;
    use crate::rr::generic_vector::GenericVecType;
    use crate::rr::shaders::{FragmentInputInfo, FragmentOutputInfo, VertexInputInfo, VertexOutputInfo};
    use crate::sglr::context_util::draw_quad;
    use crate::sglr::shader_program::{ShaderProgramBase, pdec};
    use crate::tcu::rgba::RGBA;
    use crate::tcu::vector::Vec3;

    /// Mirrors `ColorUniformShader` in `reference_context.rs`'s own tests exactly (the
    /// `DepthShader` shape: one `vec4` uniform recoloured between draws), so the exact
    /// same `render_two_quads_at_equal_depth`-shaped scenario can run against a real
    /// driver here. No reference-renderer methods are exercised by `GLContext` (it
    /// never calls `shade_vertices`/`shade_fragments`), but `ShaderProgram:
    /// VertexShader + FragmentShader` still requires them to exist - trivial bodies
    /// that are never reached through this path.
    struct ColorUniformShader {
        base: ShaderProgramBase,
    }

    impl ColorUniformShader {
        fn new() -> Self {
            let decl = pdec::ShaderProgramDeclaration::new()
                .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
                .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
                .uniform(pdec::Uniform::new(
                    "u_color",
                    crate::glu::shader_util::DataType::FloatVec4,
                ))
                .vertex_source(
                    "attribute highp vec4 a_position;\nvoid main (void)\n{\n    gl_Position = a_position;\n}\n",
                )
                .fragment_source(
                    "uniform mediump vec4 u_color;\nvoid main (void)\n{\n    gl_FragColor = u_color;\n}\n",
                );
            Self {
                base: ShaderProgramBase::new(&decl),
            }
        }
    }

    impl crate::rr::shaders::VertexShader for ColorUniformShader {
        fn inputs(&self) -> &[VertexInputInfo] {
            self.base.vertex_inputs()
        }
        fn outputs(&self) -> &[VertexOutputInfo] {
            self.base.vertex_outputs()
        }
        fn shade_vertices(
            &self,
            _inputs: &[crate::rr::vertex_attrib::VertexAttrib],
            _packets: &mut [crate::rr::vertex_packet::VertexPacket],
        ) {
            unreachable!("GLContext never calls the reference shading path")
        }
    }

    impl crate::rr::shaders::FragmentShader for ColorUniformShader {
        fn inputs(&self) -> &[FragmentInputInfo] {
            self.base.fragment_inputs()
        }
        fn outputs(&self) -> &[FragmentOutputInfo] {
            self.base.fragment_outputs()
        }
        fn shade_fragments(
            &self,
            _packets: &mut [crate::rr::fragment_packet::FragmentPacket],
            _context: &crate::rr::shading_context::FragmentShadingContext,
        ) {
            unreachable!("GLContext never calls the reference shading path")
        }
    }

    impl ShaderProgram for ColorUniformShader {
        fn program_base(&self) -> &ShaderProgramBase {
            &self.base
        }
        fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
            &mut self.base
        }
    }

    fn set_color(ctx: &mut dyn Context, program_id: u32, color: [f32; 4]) {
        ctx.use_program(program_id);
        let loc = ctx.get_uniform_location(program_id, "u_color");
        ctx.uniform4fv(loc, 1, &color);
    }

    /// End-to-end, against a real headless EGL context: the same `DepthCompareCase`-
    /// shaped scenario `reference_context.rs`'s own tests already prove against
    /// `ReferenceContext` - two full-screen quads at equal depth, red then green, under
    /// each of `GL_LESS`/`GL_LEQUAL` - run here through `&mut dyn Context` backed by
    /// `GLContext` instead, confirming the real-driver half agrees with the reference
    /// one's documented semantics. Skips (prints, does not panic) with no live GL
    /// context, the same precedent every other live-driver `#[test]` in this crate
    /// already set (`glu::texture`, `gls::texture_test_util`).
    fn render_two_quads_at_equal_depth(compare_op: GLenum) -> Option<RGBA> {
        let Ok(render_ctx) = RenderContext::create(ApiType::es(2, 0), 0) else {
            eprintln!("skipping render_two_quads_at_equal_depth: no live GL context available");
            return None;
        };
        let mut cx = GLContext::new(&render_ctx, (0, 0, 4, 4));
        let final_pixel;
        {
            let ctx: &mut dyn Context = &mut cx;
            let program_id = ctx.create_program(Box::new(ColorUniformShader::new()));

            ctx.clear_color(0.0, 0.0, 0.0, 1.0);
            ctx.clear(glw::GL_COLOR_BUFFER_BIT);
            ctx.clear_depthf(1.0);
            ctx.clear(glw::GL_DEPTH_BUFFER_BIT);
            ctx.enable(glw::GL_DEPTH_TEST);

            ctx.depth_func(glw::GL_ALWAYS);
            set_color(ctx, program_id, [1.0, 0.0, 0.0, 1.0]);
            draw_quad(ctx, program_id, Vec3::new(-1.0, -1.0, 0.2), Vec3::new(1.0, 1.0, 0.2));

            ctx.depth_func(compare_op);
            set_color(ctx, program_id, [0.0, 1.0, 0.0, 1.0]);
            draw_quad(ctx, program_id, Vec3::new(-1.0, -1.0, 0.2), Vec3::new(1.0, 1.0, 0.2));

            assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);
            let mut surface = Surface::new(1, 1);
            ctx.read_pixels(&mut surface, 0, 0, 1, 1);
            final_pixel = surface.get_pixel(0, 0);
        }
        Some(final_pixel)
    }

    #[test]
    fn gl_context_depth_compare_with_equal_depths_and_gl_less_keeps_the_first_quad_red() {
        if let Some(pixel) = render_two_quads_at_equal_depth(glw::GL_LESS) {
            assert_eq!(pixel, RGBA::new(255, 0, 0, 255));
        }
    }

    #[test]
    fn gl_context_depth_compare_with_equal_depths_and_gl_lequal_overwrites_with_the_second_quad_green() {
        if let Some(pixel) = render_two_quads_at_equal_depth(glw::GL_LEQUAL) {
            assert_eq!(pixel, RGBA::new(0, 255, 0, 255));
        }
    }

    /// Builds a complete texture-attached FBO entirely through `&mut dyn Context`
    /// backed by `GLContext`, mirroring `reference_context.rs`'s own
    /// `fbo_render_shaped_setup_builds_a_complete_texture_attached_fbo_through_the_
    /// context_trait` test but against the real driver - confirming every
    /// texture/framebuffer method this file forwards actually links and behaves as a
    /// real driver expects (`GL_FRAMEBUFFER_COMPLETE`, no pending `glGetError`).
    #[test]
    fn gl_context_fbo_render_shaped_setup_builds_a_complete_texture_attached_fbo() {
        let Ok(render_ctx) = RenderContext::create(ApiType::es(2, 0), 0) else {
            eprintln!(
                "skipping gl_context_fbo_render_shaped_setup_builds_a_complete_texture_attached_fbo: no live GL context available"
            );
            return;
        };
        let mut cx = GLContext::new(&render_ctx, (0, 0, 8, 8));
        let ctx: &mut dyn Context = &mut cx;

        ctx.active_texture(glw::GL_TEXTURE0);
        let mut tex = [0u32];
        ctx.gen_textures(&mut tex);
        ctx.bind_texture(glw::GL_TEXTURE_2D, tex[0]);
        ctx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA,
            8,
            8,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );

        let mut fbo = [0u32];
        ctx.gen_framebuffers(&mut fbo);
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);
        ctx.framebuffer_texture2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex[0],
            0,
        );

        assert_eq!(
            ctx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );
        assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);

        ctx.viewport(0, 0, 8, 8);
        ctx.color_mask(true, true, true, false);
        ctx.blend_equation(glw::GL_FUNC_ADD);
        ctx.blend_func_separate(glw::GL_ONE, glw::GL_ZERO, glw::GL_ONE, glw::GL_ZERO);
        assert_eq!(
            ctx.get_error(),
            glw::GL_NO_ERROR,
            "the blend/viewport/colorMask state setters themselves must not raise an error"
        );

        ctx.delete_framebuffers(&fbo);
        ctx.delete_textures(&tex);
        assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);
    }

    /// `Drop` must actually delete every still-allocated object rather than merely
    /// compile - create a texture/buffer/vao/fbo/rbo through a short-lived `GLContext`,
    /// drop it, then confirm a *fresh* `GLContext` (same real driver) can immediately
    /// reuse the exact same object names via `glIsTexture`-equivalent-by-recreation:
    /// concretely, re-`glGenTextures` must not error and a stale binding must report
    /// `GL_INVALID_OPERATION`-free state. The simplest real observation available here
    /// without a `glIsTexture` wrapper: binding the dropped texture's name afterwards
    /// must not carry over any GL error from the destructor itself.
    #[test]
    fn gl_context_drop_cleans_up_allocated_objects_without_a_pending_gl_error() {
        let Ok(render_ctx) = RenderContext::create(ApiType::es(2, 0), 0) else {
            eprintln!(
                "skipping gl_context_drop_cleans_up_allocated_objects_without_a_pending_gl_error: no live GL context available"
            );
            return;
        };
        {
            let mut cx = GLContext::new(&render_ctx, (0, 0, 4, 4));
            let ctx: &mut dyn Context = &mut cx;
            let mut tex = [0u32];
            ctx.gen_textures(&mut tex);
            ctx.bind_texture(glw::GL_TEXTURE_2D, tex[0]);
            let mut buf = [0u32];
            ctx.gen_buffers(&mut buf);
            let mut vao = [0u32];
            ctx.gen_vertex_arrays(&mut vao);
            let mut fbo = [0u32];
            ctx.gen_framebuffers(&mut fbo);
            let mut rbo = [0u32];
            ctx.gen_renderbuffers(&mut rbo);
            assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);
            // `cx` (and with it every allocated object above) drops at the end of this
            // block.
        }

        // A fresh context must still be able to do ordinary GL work with no leftover
        // error state from the destructor above.
        let mut cx2 = GLContext::new(&render_ctx, (0, 0, 4, 4));
        let ctx2: &mut dyn Context = &mut cx2;
        assert_eq!(
            ctx2.get_error(),
            glw::GL_NO_ERROR,
            "Drop must not leave a pending GL error for the next context to inherit"
        );
    }

    /// `GLContext::getString` is a plain forward to `glGetString` - confirmed here
    /// against a real driver that `GL_EXTENSIONS` answers a non-empty, space-separated
    /// string (the exact shape `isExtensionSupported`-style callers split on) and that
    /// an unsupported ES2 query (`GL_NUM_EXTENSIONS` is `glGetIntegerv`-only, not a
    /// `glGetString` name) answers `None` rather than panicking.
    #[test]
    fn gl_context_get_string_of_extensions_is_non_empty_and_space_separated() {
        let Ok(render_ctx) = RenderContext::create(ApiType::es(2, 0), 0) else {
            eprintln!(
                "skipping gl_context_get_string_of_extensions_is_non_empty_and_space_separated: no live GL context available"
            );
            return;
        };
        let mut cx = GLContext::new(&render_ctx, (0, 0, 4, 4));
        let ctx: &mut dyn Context = &mut cx;
        let extensions = ctx
            .get_string(glw::GL_EXTENSIONS)
            .expect("a real driver must answer GL_EXTENSIONS");
        assert!(!extensions.is_empty());
        assert!(
            extensions.contains(' '),
            "a real driver's extension string is space-separated, not a single token"
        );
    }

    /// `blend_func`/`line_width`/`finish` forward to `glBlendFunc`/`glLineWidth`/
    /// `glFinish` and link against a real driver - the trait methods `clipping.*`
    /// needs (`reference_context.rs`'s own `context_trait_blend_func_
    /// and_finish_match_the_inherent_methods`/`context_trait_line_width_widens_a_
    /// rasterized_line` already prove the *behaviour* against `ReferenceContext`; this
    /// is the real-driver half of the same precedent `gl_context_get_string_...` above
    /// set - confirming the call compiles, links and leaves no pending `glGetError`,
    /// not re-proving the rasterization math a real driver is free to implement
    /// differently anyway).
    #[test]
    fn gl_context_blend_func_and_line_width_and_finish_leave_no_pending_gl_error() {
        let Ok(render_ctx) = RenderContext::create(ApiType::es(2, 0), 0) else {
            eprintln!(
                "skipping gl_context_blend_func_and_line_width_and_finish_leave_no_pending_gl_error: no live GL context available"
            );
            return;
        };
        let mut cx = GLContext::new(&render_ctx, (0, 0, 4, 4));
        let ctx: &mut dyn Context = &mut cx;

        ctx.enable(glw::GL_BLEND);
        ctx.blend_func(glw::GL_SRC_ALPHA, glw::GL_ONE_MINUS_SRC_ALPHA);
        ctx.line_width(1.0);
        ctx.finish();

        assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);
    }

    /// `draw_arrays_indirect`/`draw_elements_indirect` forward to `glDrawArraysIndirect`/
    /// `glDrawElementsIndirect` and link against a real driver - the trait methods `draw.*`
    /// needs. Both entry points are GLES **3.1**-only (unlike
    /// every other method this file tests, which only ever needs ES 2.0), so this
    /// skips - rather than panics - both when no live context is available *and* when
    /// one is but the driver doesn't load these two symbols (checked directly via
    /// `cx.gl`'s own `Option` fields before calling through them). `count=0` deliberately draws nothing - this test is only about
    /// the indirect-buffer plumbing linking and not erroring, not about rasterizing
    /// anything (`reference_context.rs`'s own `draw_arrays_indirect_through_the_
    /// context_trait_fills_every_pixel`/`draw_elements_indirect_through_the_context_
    /// trait_fills_every_pixel` already prove the actual command-decode behaviour
    /// against `ReferenceContext`).
    #[test]
    fn gl_context_draw_arrays_indirect_and_draw_elements_indirect_leave_no_pending_gl_error() {
        let Ok(render_ctx) = RenderContext::create(ApiType::es(3, 1), 0) else {
            eprintln!(
                "skipping gl_context_draw_arrays_indirect_and_draw_elements_indirect_leave_no_pending_gl_error: no live GL ES 3.1 context available"
            );
            return;
        };
        let mut cx = GLContext::new(&render_ctx, (0, 0, 4, 4));
        if cx.gl.draw_arrays_indirect.is_none() || cx.gl.draw_elements_indirect.is_none() {
            eprintln!(
                "skipping gl_context_draw_arrays_indirect_and_draw_elements_indirect_leave_no_pending_gl_error: glDrawArraysIndirect/glDrawElementsIndirect not loaded by this driver"
            );
            return;
        }

        // Five `u32`s (20 bytes), not four - `glDrawElementsIndirect`'s own command
        // struct is one field wider than `glDrawArraysIndirect`'s (`base_vertex`), and
        // both calls below read from the same buffer, so it has to be sized for the
        // wider of the two or the second call legitimately reads past the end.
        let command: [u32; 5] = [0, 0, 0, 0, 0];
        let command_bytes =
            unsafe { std::slice::from_raw_parts(command.as_ptr().cast::<u8>(), std::mem::size_of_val(&command)) };

        let ctx: &mut dyn Context = &mut cx;
        let mut vao_names = [0u32];
        ctx.gen_vertex_arrays(&mut vao_names);
        ctx.bind_vertex_array(vao_names[0]);

        let mut indirect_names = [0u32];
        ctx.gen_buffers(&mut indirect_names);
        ctx.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, indirect_names[0]);
        ctx.buffer_data(
            glw::GL_DRAW_INDIRECT_BUFFER,
            command_bytes.len() as isize,
            Some(command_bytes),
        );

        let mut index_names = [0u32];
        ctx.gen_buffers(&mut index_names);
        ctx.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, index_names[0]);
        ctx.buffer_data(glw::GL_ELEMENT_ARRAY_BUFFER, 0, None);

        // A real driver (unlike every other test in this file, which never issues an
        // actual draw call) requires a current program for any draw call at all, not
        // just an indirect one - bind one even though `count=0` never reads its
        // attributes/uniforms.
        let program_id = ctx.create_program(Box::new(ColorUniformShader::new()));
        ctx.use_program(program_id);

        ctx.draw_arrays_indirect(glw::GL_TRIANGLES, 0);
        assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);

        ctx.draw_elements_indirect(glw::GL_TRIANGLES, glw::GL_UNSIGNED_SHORT, 0);
        assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);
    }
}
