// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsDrawTest.cpp  (deqp::gls::AttributeArray, anonymous-namespace)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's `AttributeArray` stores `sglr::Context &m_ctx` as a member, set once at
// construction. That shape does not translate: `AttributePack` (not yet ported) will
// own several `AttributeArray`s side by side and drive all of them through one shared
// `&mut dyn Context`, which a long-lived `&mut dyn Context` field on each array would
// alias. Every method that needs the context takes one as a parameter instead - the
// same shape `sglr::context_util::draw_quad_with_vao_buffers` already established for
// exactly this trait. `~AttributeArray()`'s buffer deletion becomes an explicit
// `destroy(ctx)` for the same reason: `Drop` cannot be given a context to call into.
//
// **No `GLU_EXPECT_NO_ERROR` checks.** Upstream asserts `glGetError() == GL_NO_ERROR`
// after every call that can fail, throwing `tcu::TestError` otherwise. `context_util.rs`'s
// own `draw_quad_with_vao_buffers` already established the precedent of skipping these
// for `sglr::Context` call sequences in this port (see that file for a case with the
// identical trait and the identical omission) - plumbing a `Result` through every leaf
// setter here for a class of error no in-scope caller is expected to trigger is not
// worth the signature noise it would add everywhere `AttributeArray` is used.
//
// Byte buffers (`data`/`bufferData`) are built into a `&[u8]` by the caller rather than
// the `(size_t size, const char *data)` pair upstream takes - `RandomArrayGenerator`
// (not yet ported) is what will build that slice, the same shape every other sglr-facing
// helper in this port uses (`context_util::draw_quad_with_vao_buffers`'s own
// `std::slice::from_raw_parts` calls, done once there rather than at every call site).

use super::spec::{InputType, OutputType, Storage, Target, Usage};
use crate::glw;
use crate::rr::generic_vector::GenericVec4;
use crate::sglr::context::Context;

/// `AttributeArray`
pub struct AttributeArray {
    storage: Storage,
    gl_buffer: u32,

    size: i32,
    /// Only populated for `Storage::User` - `m_data` upstream. Empty (and unread) for
    /// `Storage::Buffer`, where the real storage lives in the GL object `gl_buffer` names.
    data: Vec<u8>,
    component_count: i32,
    bound: bool,
    target: Target,
    input_type: InputType,
    output_type: OutputType,
    normalize: bool,
    stride: i32,
    offset: i32,
    default_attrib: GenericVec4,
    instance_divisor: i32,
    is_position_attr: bool,
    bgra_order: bool,
}

impl AttributeArray {
    /// `AttributeArray::AttributeArray`
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
            size: 0,
            data: Vec::new(),
            component_count: 1,
            bound: false,
            target: Target::Array,
            input_type: InputType::Float,
            output_type: OutputType::Vec4,
            normalize: false,
            stride: 0,
            offset: 0,
            default_attrib: GenericVec4::zero(),
            instance_divisor: 0,
            is_position_attr: false,
            bgra_order: false,
        }
    }

    /// `~AttributeArray` - see this module's top doc comment for why this is an
    /// explicit method rather than `Drop`.
    pub fn destroy(self, ctx: &mut dyn Context) {
        if self.storage == Storage::Buffer {
            ctx.delete_buffers(&[self.gl_buffer]);
        }
        // Storage::User: `self.data` is a plain `Vec<u8>` and frees itself on drop.
    }

    /// `AttributeArray::data` - `bytes` replaces upstream's `(size_t size, const char
    /// *data)` pair (see this module's top doc comment).
    pub fn set_data(&mut self, ctx: &mut dyn Context, target: Target, bytes: &[u8], usage: Usage) {
        self.size = bytes.len() as i32;
        self.target = target;

        match self.storage {
            Storage::Buffer => {
                ctx.bind_buffer(target.to_gl(), self.gl_buffer);
                ctx.buffer_data(target.to_gl(), bytes.len() as isize, Some(bytes));
                let _ = usage; // `Context::buffer_data` has no usage-hint parameter here - see its own doc comment.
            }
            Storage::User => {
                self.data = bytes.to_vec();
            }
            Storage::Last => unreachable!("AttributeArray storage must be User or Buffer"),
        }
    }

    /// `AttributeArray::setupArray`
    #[allow(clippy::too_many_arguments)]
    pub fn setup_array(
        &mut self,
        bound: bool,
        offset: i32,
        size: i32,
        input_type: InputType,
        output_type: OutputType,
        normalized: bool,
        stride: i32,
        instance_divisor: i32,
        default_attrib: GenericVec4,
        is_position_attr: bool,
        bgra_component_order: bool,
    ) {
        self.component_count = size;
        self.bound = bound;
        self.input_type = input_type;
        self.output_type = output_type;
        self.normalize = normalized;
        self.stride = stride;
        self.offset = offset;
        self.default_attrib = default_attrib;
        self.instance_divisor = instance_divisor;
        self.is_position_attr = is_position_attr;
        self.bgra_order = bgra_component_order;
    }

    /// `AttributeArray::bindAttribute`
    pub fn bind_attribute(&self, ctx: &mut dyn Context, loc: u32) {
        if !self.bound {
            match self.input_type {
                InputType::Float => {
                    let attr = self.default_attrib.get_float();
                    match self.component_count {
                        1 => ctx.vertex_attrib1f(loc, attr.x()),
                        2 => ctx.vertex_attrib2f(loc, attr.x(), attr.y()),
                        3 => ctx.vertex_attrib3f(loc, attr.x(), attr.y(), attr.z()),
                        4 => ctx.vertex_attrib4f(loc, attr.x(), attr.y(), attr.z(), attr.w()),
                        _ => debug_assert!(false, "AttributeArray: component_count must be 1..=4"),
                    }
                }
                InputType::Int => {
                    let attr = self.default_attrib.get_int();
                    ctx.vertex_attrib_i4i(loc, attr.x(), attr.y(), attr.z(), attr.w());
                }
                InputType::UnsignedInt => {
                    let attr = self.default_attrib.get_uint();
                    ctx.vertex_attrib_i4ui(loc, attr.x(), attr.y(), attr.z(), attr.w());
                }
                _ => debug_assert!(false, "AttributeArray: unexpected default-attribute input type"),
            }
            return;
        }

        // `basePtr`/the final `pointer`+`has_pointer` pair - see this module's top doc
        // comment on why `Context::vertex_attrib_pointer` takes them split out rather
        // than a nullable `*const u8`.
        let (pointer, has_pointer): (usize, bool) = match self.storage {
            Storage::Buffer => {
                ctx.bind_buffer(self.target.to_gl(), self.gl_buffer);
                (self.offset as usize, false)
            }
            Storage::User => {
                ctx.bind_buffer(self.target.to_gl(), 0);
                (self.data.as_ptr() as usize + self.offset as usize, true)
            }
            Storage::Last => unreachable!("AttributeArray storage must be User or Buffer"),
        };

        if !self.input_type.is_float_type() {
            // Input is not a float type.
            if self.output_type.is_float_type() {
                let size: i32 = if self.bgra_order {
                    glw::GL_BGRA as i32
                } else {
                    self.component_count
                };
                debug_assert!(!(self.bgra_order && self.component_count != 4));

                // Output type is a float type.
                ctx.vertex_attrib_pointer(
                    loc,
                    size,
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

        if self.instance_divisor != 0 {
            ctx.vertex_attrib_divisor(loc, self.instance_divisor as u32);
        }
    }

    /// `AttributeArray::bindIndexArray`
    pub fn bind_index_array(&self, ctx: &mut dyn Context, target: Target) {
        match self.storage {
            Storage::User => {}
            Storage::Buffer => ctx.bind_buffer(target.to_gl(), self.gl_buffer),
            Storage::Last => unreachable!("AttributeArray storage must be User or Buffer"),
        }
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
    pub fn is_bound(&self) -> bool {
        self.bound
    }
    pub fn is_position_attribute(&self) -> bool {
        self.is_position_attr
    }

    /// Exposed for tests/callers that need to read back what `set_data` stored for a
    /// `Storage::User` array (there is no GL object to query it back out of).
    pub fn user_data(&self) -> &[u8] {
        &self.data
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::sglr::reference_context::ReferenceContext;
    use crate::tcu::pixel::TextureLevel;
    use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};

    fn ctx() -> ReferenceContext {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let color = TextureLevel::new(format, 4, 4, 1).unwrap();
        ReferenceContext::new(16, color, None, 8)
    }

    #[test]
    fn user_storage_round_trips_through_set_data() {
        let mut cx = ctx();
        let mut arr = AttributeArray::new(&mut cx, Storage::User);
        let bytes: [u8; 8] = [1, 2, 3, 4, 5, 6, 7, 8];
        arr.set_data(&mut cx, Target::Array, &bytes, Usage::StaticDraw);
        assert_eq!(arr.user_data(), &bytes);
        arr.destroy(&mut cx);
    }

    #[test]
    fn buffer_storage_binds_and_uploads_through_the_context() {
        let mut cx = ctx();
        let mut arr = AttributeArray::new(&mut cx, Storage::Buffer);
        let bytes: [u8; 4] = [9, 9, 9, 9];
        arr.set_data(&mut cx, Target::Array, &bytes, Usage::StaticDraw);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        // The GL buffer, not `self.data`, carries the payload for Storage::Buffer.
        assert!(arr.user_data().is_empty());
        arr.destroy(&mut cx);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
    }

    #[test]
    fn unbound_float_attribute_writes_the_current_generic_value() {
        let mut cx = ctx();
        let mut arr = AttributeArray::new(&mut cx, Storage::User);
        let default_attrib = GenericVec4::from_float(crate::tcu::vector::Vec4::new(1.0, 2.0, 3.0, 4.0));
        arr.setup_array(
            false,
            0,
            4,
            InputType::Float,
            OutputType::Vec4,
            false,
            0,
            0,
            default_attrib,
            true,
            false,
        );
        arr.bind_attribute(&mut cx, 0);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        arr.destroy(&mut cx);
    }

    #[test]
    fn bound_buffer_attribute_sets_up_a_vertex_attrib_pointer() {
        let mut cx = ctx();
        let mut arr = AttributeArray::new(&mut cx, Storage::Buffer);
        let bytes: [u8; 16] = [0; 16];
        arr.set_data(&mut cx, Target::Array, &bytes, Usage::StaticDraw);
        arr.setup_array(
            true,
            0,
            4,
            InputType::Float,
            OutputType::Vec4,
            false,
            16,
            0,
            GenericVec4::zero(),
            true,
            false,
        );
        arr.bind_attribute(&mut cx, 0);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        arr.destroy(&mut cx);
    }

    #[test]
    fn bound_user_pointer_int_input_uses_the_i_pointer_path() {
        let mut cx = ctx();
        let mut arr = AttributeArray::new(&mut cx, Storage::User);
        let bytes: [u8; 16] = [0; 16];
        arr.set_data(&mut cx, Target::Array, &bytes, Usage::StaticDraw);
        arr.setup_array(
            true,
            0,
            4,
            InputType::Int,
            OutputType::IVec4,
            false,
            16,
            0,
            GenericVec4::zero(),
            false,
            false,
        );
        // Default VAO (client_vertex_array) accepts a user pointer with no buffer bound.
        arr.bind_attribute(&mut cx, 0);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        arr.destroy(&mut cx);
    }

    #[test]
    fn instance_divisor_is_forwarded_when_nonzero() {
        let mut cx = ctx();
        let mut arr = AttributeArray::new(&mut cx, Storage::Buffer);
        let bytes: [u8; 16] = [0; 16];
        arr.set_data(&mut cx, Target::Array, &bytes, Usage::StaticDraw);
        arr.setup_array(
            true,
            0,
            4,
            InputType::Float,
            OutputType::Vec4,
            false,
            16,
            2,
            GenericVec4::zero(),
            true,
            false,
        );
        arr.bind_attribute(&mut cx, 0);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        arr.destroy(&mut cx);
    }
}
