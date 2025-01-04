// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsVertexArrayTests.hpp / .cpp  (deqp::gls::ContextArray)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. See `super`'s own module doc comment
// for what this file covers and what is still deferred.
//
// **No `Array` base trait ported.** Upstream declares `Array` as an abstract base class
// with `ContextArray` as its one real subclass; nothing here needs dynamic dispatch
// across array implementations (there is only ever the one), so this is a concrete
// struct with no trait, matching `draw_test::attribute_array::AttributeArray`'s own
// precedent exactly (that file is the one real implementor of upstream's analogous
// `AttributeArray`-shaped base in `glsDrawTest.cpp`, and ports with no trait either).
//
// Same context-ownership shape `AttributeArray` already established, for the same
// reason: upstream stores `sglr::Context &m_ctx` as a member, set once at
// construction, but `ContextArrayPack` (not yet ported) will own several
// `ContextArray`s side by side and drive all of them through one shared
// `&mut dyn Context`, which a long-lived field would alias. Every method that needs
// the context takes one as a parameter instead, and `~ContextArray()`'s buffer
// deletion becomes an explicit `destroy(ctx)` rather than `Drop`.
//
// **No `GLU_EXPECT_NO_ERROR` checks** - same precedent as `attribute_array.rs`'s own
// top doc comment: `context_util.rs`'s `draw_quad_with_vao_buffers` already
// established that these are skipped for `sglr::Context` call sequences in this port.
//
// Byte buffers (`data`/`subdata`) take a `&[u8]` built by the caller, replacing
// upstream's `(size_t size, const char *data)` pair - same substitution
// `attribute_array.rs` already made, for the same reason (`RandomArrayGenerator`, not
// yet ported, is what will build that slice).
//
// **`Usage` is accepted but discarded**, exactly like `attribute_array.rs`'s own
// `set_data` - `Context::buffer_data` has no usage-hint parameter in this port (see
// that trait method's own doc comment), so there is nowhere to forward
// `usage.to_gl()` to.

use super::array::{InputType, OutputType, Storage, Target, Usage};
use crate::sglr::context::Context;

/// `ContextArray`
pub struct ContextArray {
    storage: Storage,
    gl_buffer: u32,

    bound: bool,
    attrib_ndx: i32,
    size: i32,
    /// Only populated for `Storage::User` - `m_data` upstream. Empty (and unread) for
    /// `Storage::Buffer`, where the real storage lives in the GL object `gl_buffer` names.
    data: Vec<u8>,
    component_count: i32,
    target: Target,
    input_type: InputType,
    output_type: OutputType,
    normalize: bool,
    stride: i32,
    offset: i32,
}

impl ContextArray {
    /// `ContextArray::ContextArray`
    pub fn new(ctx: &mut dyn Context, storage: Storage) -> Self {
        let mut gl_buffer = 0u32;
        if storage == Storage::Buffer {
            let mut out = [0u32; 1];
            ctx.gen_buffers(&mut out);
            gl_buffer = out[0];
        }

        Self {
            storage,
            gl_buffer,
            bound: false,
            attrib_ndx: 0,
            size: 0,
            data: Vec::new(),
            component_count: 1,
            target: Target::Array,
            input_type: InputType::Float,
            output_type: OutputType::Vec4,
            normalize: false,
            stride: 0,
            offset: 0,
        }
    }

    /// `~ContextArray` - see this module's top doc comment for why this is an explicit
    /// method rather than `Drop`.
    pub fn destroy(self, ctx: &mut dyn Context) {
        if self.storage == Storage::Buffer {
            ctx.delete_buffers(&[self.gl_buffer]);
        }
        // Storage::User: `self.data` is a plain `Vec<u8>` and frees itself on drop.
    }

    /// `ContextArray::data` - `bytes` replaces upstream's `(size_t size, const char
    /// *data)` pair; `usage` is accepted but discarded (see this module's top doc
    /// comment).
    pub fn data(&mut self, ctx: &mut dyn Context, target: Target, bytes: &[u8], usage: Usage) {
        self.size = bytes.len() as i32;
        self.target = target;
        let _ = usage;

        match self.storage {
            Storage::Buffer => {
                ctx.bind_buffer(target.to_gl(), self.gl_buffer);
                ctx.buffer_data(target.to_gl(), bytes.len() as isize, Some(bytes));
            }
            Storage::User => {
                self.data = bytes.to_vec();
            }
        }
    }

    /// `ContextArray::subdata`
    pub fn subdata(&mut self, ctx: &mut dyn Context, target: Target, offset: i32, bytes: &[u8]) {
        self.target = target;

        match self.storage {
            Storage::Buffer => {
                ctx.bind_buffer(target.to_gl(), self.gl_buffer);
                ctx.buffer_sub_data(target.to_gl(), offset as isize, bytes);
            }
            Storage::User => {
                let start = offset as usize;
                self.data[start..start + bytes.len()].copy_from_slice(bytes);
            }
        }
    }

    /// `ContextArray::bind` - pure bookkeeping, no GL call (upstream's own body is
    /// exactly this: set the fields `glBind` later reads).
    #[allow(clippy::too_many_arguments)]
    pub fn bind(
        &mut self,
        attrib_ndx: i32,
        offset: i32,
        size: i32,
        input_type: InputType,
        output_type: OutputType,
        normalized: bool,
        stride: i32,
    ) {
        self.attrib_ndx = attrib_ndx;
        self.bound = true;
        self.component_count = size;
        self.input_type = input_type;
        self.output_type = output_type;
        self.normalize = normalized;
        self.stride = stride;
        self.offset = offset;
    }

    /// `ContextArray::bindIndexArray`
    pub fn bind_index_array(&self, ctx: &mut dyn Context, target: Target) {
        if self.storage == Storage::Buffer {
            ctx.bind_buffer(target.to_gl(), self.gl_buffer);
        }
        // Storage::User: upstream's own branch body is empty.
    }

    /// `ContextArray::unBind`
    pub fn un_bind(&mut self) {
        self.bound = false;
    }

    /// `ContextArray::glBind` - the real GL/`sglr::Context` call sequence, split out
    /// from `bind` (pure bookkeeping) the same way upstream splits them into two
    /// methods: `bind` is called while building up the array list, `glBind` once per
    /// draw from `ContextArrayPack::render` (not yet ported).
    pub fn gl_bind(&self, ctx: &mut dyn Context, loc: u32) {
        match self.storage {
            Storage::Buffer => {
                ctx.bind_buffer(self.target.to_gl(), self.gl_buffer);
                self.set_pointer(ctx, loc, self.offset as usize, false);
                ctx.bind_buffer(self.target.to_gl(), 0);
            }
            Storage::User => {
                ctx.bind_buffer(self.target.to_gl(), 0);
                let pointer = self.data.as_ptr() as usize + self.offset as usize;
                self.set_pointer(ctx, loc, pointer, true);
            }
        }
    }

    /// The `vertexAttribPointer`/`vertexAttribIPointer` branch shared by both storage
    /// kinds in upstream's `glBind` - factored out here since it is identical in both
    /// (only the `pointer`/`has_pointer` pair differs), rather than duplicated inline
    /// as upstream's own two copies are. `loc` is `glBind`'s own parameter (the real GL
    /// attribute location `ContextArrayPack::render` looked up via
    /// `getAttribLocation`) - **not** `self.attrib_ndx`, which is only the index used to
    /// name the generated shader input (`a_0`, `a_1`, ...) and is otherwise unrelated to
    /// where that input actually got bound.
    fn set_pointer(&self, ctx: &mut dyn Context, loc: u32, pointer: usize, has_pointer: bool) {
        if !self.input_type.is_float_type() {
            // Input is not a float type.
            if self.output_type.is_float_type() {
                // Output type is a float type.
                ctx.vertex_attrib_pointer(
                    loc,
                    self.component_count,
                    self.input_type.to_gl(),
                    self.normalize,
                    self.stride,
                    pointer,
                    has_pointer,
                );
            } else {
                // Output type is an int type.
                ctx.vertex_attrib_i_pointer(
                    loc,
                    self.component_count,
                    self.input_type.to_gl(),
                    self.stride,
                    pointer,
                    has_pointer,
                );
            }
        } else {
            // Input type is a float type; output type must be too.
            debug_assert!(self.output_type.is_float_type());
            ctx.vertex_attrib_pointer(
                loc,
                self.component_count,
                self.input_type.to_gl(),
                self.normalize,
                self.stride,
                pointer,
                has_pointer,
            );
        }
    }

    pub fn is_bound(&self) -> bool {
        self.bound
    }
    pub fn component_count(&self) -> i32 {
        self.component_count
    }
    pub fn target(&self) -> Target {
        self.target
    }
    pub fn input_type(&self) -> InputType {
        self.input_type
    }
    pub fn output_type(&self) -> OutputType {
        self.output_type
    }
    pub fn storage_type(&self) -> Storage {
        self.storage
    }
    pub fn normalized(&self) -> bool {
        self.normalize
    }
    pub fn stride(&self) -> i32 {
        self.stride
    }
    pub fn attrib_ndx(&self) -> i32 {
        self.attrib_ndx
    }
    pub fn set_attrib_ndx(&mut self, attrib_ndx: i32) {
        self.attrib_ndx = attrib_ndx;
    }

    /// Exposed for tests/callers that need to read back what `data`/`subdata` stored
    /// for a `Storage::User` array (there is no GL object to query it back out of) -
    /// same reason `attribute_array.rs`'s own `user_data` exists.
    pub fn user_data(&self) -> &[u8] {
        &self.data
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::glw;
    use crate::sglr::reference_context::ReferenceContext;
    use crate::tcu::pixel::TextureLevel;
    use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};

    fn ctx() -> ReferenceContext {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let color = TextureLevel::new(format, 4, 4, 1).unwrap();
        ReferenceContext::new(16, color, None, 8)
    }

    #[test]
    fn user_storage_round_trips_through_data_and_subdata() {
        let mut cx = ctx();
        let mut arr = ContextArray::new(&mut cx, Storage::User);
        let bytes: [u8; 8] = [1, 2, 3, 4, 5, 6, 7, 8];
        arr.data(&mut cx, Target::Array, &bytes, Usage::StaticDraw);
        assert_eq!(arr.user_data(), &bytes);

        arr.subdata(&mut cx, Target::Array, 4, &[9, 9, 9, 9]);
        assert_eq!(arr.user_data(), &[1, 2, 3, 4, 9, 9, 9, 9]);
        arr.destroy(&mut cx);
    }

    #[test]
    fn buffer_storage_binds_and_uploads_through_the_context() {
        let mut cx = ctx();
        let mut arr = ContextArray::new(&mut cx, Storage::Buffer);
        let bytes: [u8; 4] = [9, 9, 9, 9];
        arr.data(&mut cx, Target::Array, &bytes, Usage::StaticDraw);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        // The GL buffer, not `self.data`, carries the payload for Storage::Buffer.
        assert!(arr.user_data().is_empty());
        arr.destroy(&mut cx);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
    }

    #[test]
    fn bind_is_pure_bookkeeping_and_sets_is_bound() {
        let mut cx = ctx();
        let mut arr = ContextArray::new(&mut cx, Storage::User);
        assert!(!arr.is_bound());
        arr.bind(2, 0, 4, InputType::Float, OutputType::Vec4, false, 16);
        assert!(arr.is_bound());
        assert_eq!(arr.attrib_ndx(), 2);
        assert_eq!(arr.component_count(), 4);
        assert_eq!(arr.stride(), 16);
        arr.destroy(&mut cx);
    }

    #[test]
    fn un_bind_clears_is_bound() {
        let mut cx = ctx();
        let mut arr = ContextArray::new(&mut cx, Storage::User);
        arr.bind(0, 0, 4, InputType::Float, OutputType::Vec4, false, 0);
        assert!(arr.is_bound());
        arr.un_bind();
        assert!(!arr.is_bound());
        arr.destroy(&mut cx);
    }

    #[test]
    fn gl_bind_buffer_storage_float_input_sets_up_a_vertex_attrib_pointer() {
        let mut cx = ctx();
        let mut arr = ContextArray::new(&mut cx, Storage::Buffer);
        let bytes: [u8; 16] = [0; 16];
        arr.data(&mut cx, Target::Array, &bytes, Usage::StaticDraw);
        arr.bind(0, 0, 4, InputType::Float, OutputType::Vec4, false, 16);
        arr.gl_bind(&mut cx, 0);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        arr.destroy(&mut cx);
    }

    #[test]
    fn gl_bind_user_storage_int_input_uses_the_i_pointer_path() {
        let mut cx = ctx();
        let mut arr = ContextArray::new(&mut cx, Storage::User);
        let bytes: [u8; 16] = [0; 16];
        arr.data(&mut cx, Target::Array, &bytes, Usage::StaticDraw);
        arr.bind(0, 0, 4, InputType::Int, OutputType::IVec4, false, 16);
        // Default VAO (client_vertex_array) accepts a user pointer with no buffer bound -
        // same precedent `attribute_array.rs`'s own equivalent test documents.
        arr.gl_bind(&mut cx, 0);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        arr.destroy(&mut cx);
    }

    #[test]
    fn bind_index_array_binds_the_buffer_for_storage_buffer_only() {
        let mut cx = ctx();
        let mut arr = ContextArray::new(&mut cx, Storage::Buffer);
        let bytes: [u8; 4] = [0; 4];
        arr.data(&mut cx, Target::ElementArray, &bytes, Usage::StaticDraw);
        arr.bind_index_array(&mut cx, Target::ElementArray);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        arr.destroy(&mut cx);

        // Storage::User: no GL call at all, so no error either way.
        let mut arr2 = ContextArray::new(&mut cx, Storage::User);
        arr2.data(&mut cx, Target::ElementArray, &bytes, Usage::StaticDraw);
        arr2.bind_index_array(&mut cx, Target::ElementArray);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        arr2.destroy(&mut cx);
    }
}
