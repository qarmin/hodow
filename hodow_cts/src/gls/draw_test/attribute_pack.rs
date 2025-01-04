// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsDrawTest.cpp  (deqp::gls::AttributePack)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `AttributePack` owns the whole set of `AttributeArray`s plus the compiled
// `DrawTestShaderProgram` for one `DrawTestSpec`, against one of the two
// `sglr::Context`s (GL or reference) - `DrawTest` (not yet ported) builds two of
// these, one per context, and issues the identical sequence of calls through both.
//
// Several deliberate narrowings relative to upstream, each because something upstream
// leans on does not exist in this port (or exists in a different shape), not because
// the behaviour is out of scope:
//  - **No `tcu::TestContext`/`tcu::TestLog`.** Neither is ported anywhere in this crate
//    (confirmed by grep - no `struct TestContext`, no `struct TestLog` under `tcu/`),
//    which this port's `runner`/`report` modules evidently never needed before now.
//    Upstream's `m_testCtx`/`m_logEnabled` exist solely to print the
//    `DrawArraysIndirectCommand`/`DrawElementsIndirectCommand` byte layout as a
//    diagnostic *before* uploading it - dropping that print changes no GL state and no
//    rendered pixel, only what a human reading a log would see. Revisit if a future
//    piece needs `tcu::TestLog` for its own reasons; it would not change this file.
//  - **No `tcu::UVec2` for the screen size** - that type does not exist in
//    `tcu::vector` (only `IVec2/3/4`, `UVec3/4`, `Vec2/3/4` are defined; no `UVec2`).
//    `new` takes `screen_width: i32, screen_height: i32` directly rather than
//    constructing a two-component vector just to immediately call `.x()`/`.y()` on it.
//  - **No `glu::RenderContext` member** - the only thing upstream's `m_renderCtx` is
//    ever used for is `DrawTestShaderProgram`'s constructor, which (in this port) takes
//    a plain `glu::ContextType`, not a whole `&RenderContext` (see
//    `shader_program.rs`'s own `DrawTestShaderProgram::new`). Storing just the
//    `ContextType` avoids tying this struct's lifetime to a borrowed `RenderContext`
//    for no benefit - `RenderContext::context_type()` is how a caller gets one.
//  - **No raw `m_program: sglr::ShaderProgram*` member, and no `clearArrays`/destructor
//    delete for it.** `Context::create_program` already transfers ownership of the
//    `Box<dyn ShaderProgram>` into the context (see `sglr::context::Context::create_program`'s
//    own doc comment) - `Context::delete_program` is what frees it, so this struct only
//    ever needs to remember the program *id*, matching `m_programID` but not `m_program`.
//  - **`AttributeArray::destroy`/`AttributeArray::new` both take an explicit
//    `&mut dyn Context` parameter rather than storing one** (see that module's own top
//    doc comment for why), so neither this struct nor `AttributeArray` can implement
//    `Drop` - tearing anything down needs a live context to call into. `destroy(self,
//    ctx)` is the explicit replacement for `~AttributePack()`, the same shape
//    `AttributeArray::destroy` already established.
//  - **No `GLU_EXPECT_NO_ERROR` checks anywhere in this file** - `attribute_array.rs`'s
//    own top doc comment already established this precedent for exactly this call
//    shape (a `sglr::Context` call sequence), and this file follows it throughout.
//
// Everything else keeps upstream's shape and order as closely as Rust allows,
// including re-querying `getAttribLocation` in the post-draw disable loop rather than
// caching the locations the enable loop already computed (upstream does this too, and
// it is cheap enough on both `GLContext` and `ReferenceContext` that preserving the
// exact call sequence outweighs the micro-optimisation).

use super::attribute_array::AttributeArray;
use super::shader_program::DrawTestShaderProgram;
use super::spec::{DrawMethod, IndexType, Primitive, Storage, Target};
use crate::glu::ContextType;
use crate::glw;
use crate::sglr::context::Context;
use crate::tcu::surface::Surface;

/// `AttributePack`
pub struct AttributePack {
    context_type: ContextType,
    arrays: Vec<AttributeArray>,
    screen: Surface,
    use_vao: bool,
    program_id: u32,
    vao_id: u32,
}

impl AttributePack {
    /// `AttributePack::AttributePack` - see this module's top doc comment for the
    /// `tcu::TestContext`/`glu::RenderContext`/`tcu::UVec2` narrowings.
    pub fn new(
        ctx: &mut dyn Context,
        context_type: ContextType,
        screen_width: i32,
        screen_height: i32,
        use_vao: bool,
    ) -> Self {
        let mut vao_id = 0u32;
        if use_vao {
            let mut out = [0u32; 1];
            ctx.gen_vertex_arrays(&mut out);
            vao_id = out[0];
        }

        Self {
            context_type,
            arrays: Vec::new(),
            screen: Surface::new(screen_width, screen_height),
            use_vao,
            program_id: 0,
            vao_id,
        }
    }

    /// `~AttributePack` - see this module's top doc comment for why this is an
    /// explicit method rather than `Drop`.
    pub fn destroy(mut self, ctx: &mut dyn Context) {
        self.clear_arrays(ctx);

        if self.program_id != 0 {
            ctx.delete_program(self.program_id);
        }

        if self.use_vao {
            ctx.delete_vertex_arrays(&[self.vao_id]);
        }
    }

    /// `AttributePack::getArray`
    pub fn array(&self, i: usize) -> &AttributeArray {
        &self.arrays[i]
    }

    /// `AttributePack::getArray` - the mutable form, for a caller that still needs to
    /// `set_data`/`setup_array` the array `new_array` just pushed.
    pub fn array_mut(&mut self, i: usize) -> &mut AttributeArray {
        &mut self.arrays[i]
    }

    /// `AttributePack::getArrayCount`
    pub fn array_count(&self) -> usize {
        self.arrays.len()
    }

    /// The compiled program id, 0 before the first `update_program` call - exposed so
    /// a caller (or a test) can tell whether `render` is ready to be called without
    /// tripping its own assertion.
    pub fn program_id(&self) -> u32 {
        self.program_id
    }

    /// `AttributePack::newArray`
    pub fn new_array(&mut self, ctx: &mut dyn Context, storage: Storage) {
        self.arrays.push(AttributeArray::new(ctx, storage));
    }

    /// `AttributePack::clearArrays`
    pub fn clear_arrays(&mut self, ctx: &mut dyn Context) {
        for array in self.arrays.drain(..) {
            array.destroy(ctx);
        }
    }

    /// `AttributePack::updateProgram`
    pub fn update_program(&mut self, ctx: &mut dyn Context) {
        if self.program_id != 0 {
            ctx.delete_program(self.program_id);
            self.program_id = 0;
        }

        let array_refs: Vec<&AttributeArray> = self.arrays.iter().collect();
        let program = DrawTestShaderProgram::new(self.context_type, &array_refs);
        self.program_id = ctx.create_program(Box::new(program));
    }

    /// `AttributePack::render`
    #[allow(clippy::too_many_arguments)]
    pub fn render(
        &mut self,
        ctx: &mut dyn Context,
        primitive: Primitive,
        draw_method: DrawMethod,
        first_vertex: i32,
        vertex_count: i32,
        index_type: IndexType,
        index_offset: usize,
        range_start: u32,
        range_end: u32,
        instance_count: i32,
        indirect_offset: usize,
        base_vertex: i32,
        coord_scale: f32,
        color_scale: f32,
        index_array: Option<&AttributeArray>,
    ) {
        assert!(
            self.program_id != 0,
            "AttributePack::render called before update_program"
        );

        ctx.viewport(0, 0, self.screen.get_width(), self.screen.get_height());
        ctx.clear_color(0.0, 0.0, 0.0, 1.0);
        ctx.clear(glw::GL_COLOR_BUFFER_BIT);

        ctx.use_program(self.program_id);

        let coord_scale_loc = ctx.get_uniform_location(self.program_id, "u_coordScale");
        ctx.uniform1f(coord_scale_loc, coord_scale);
        let color_scale_loc = ctx.get_uniform_location(self.program_id, "u_colorScale");
        ctx.uniform1f(color_scale_loc, color_scale);

        if self.use_vao {
            ctx.bind_vertex_array(self.vao_id);
        }

        if let Some(index_array) = index_array {
            index_array.bind_index_array(ctx, Target::ElementArray);
        }

        for (array_ndx, array) in self.arrays.iter().enumerate() {
            let loc = ctx.get_attrib_location(self.program_id, &format!("a_{array_ndx}")) as u32;

            if array.is_bound() {
                ctx.enable_vertex_attrib_array(loc);
            }

            array.bind_attribute(ctx, loc);
        }

        match draw_method {
            DrawMethod::DrawArrays => {
                ctx.draw_arrays(primitive.to_gl(), first_vertex, vertex_count);
            }
            DrawMethod::DrawArraysInstanced => {
                ctx.draw_arrays_instanced(primitive.to_gl(), first_vertex, vertex_count, instance_count);
            }
            DrawMethod::DrawElements => {
                ctx.draw_elements(primitive.to_gl(), vertex_count, index_type.to_gl(), index_offset);
            }
            DrawMethod::DrawElementsRanged => {
                ctx.draw_range_elements(
                    primitive.to_gl(),
                    range_start,
                    range_end,
                    vertex_count,
                    index_type.to_gl(),
                    index_offset,
                );
            }
            DrawMethod::DrawElementsInstanced => {
                ctx.draw_elements_instanced(
                    primitive.to_gl(),
                    vertex_count,
                    index_type.to_gl(),
                    index_offset,
                    instance_count,
                );
            }
            DrawMethod::DrawArraysIndirect => {
                let buffer =
                    build_draw_arrays_indirect_command(vertex_count, instance_count, first_vertex, indirect_offset);
                let mut names = [0u32];
                ctx.gen_buffers(&mut names);
                ctx.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, names[0]);
                ctx.buffer_data(glw::GL_DRAW_INDIRECT_BUFFER, buffer.len() as isize, Some(&buffer));
                ctx.draw_arrays_indirect(primitive.to_gl(), indirect_offset);
                ctx.delete_buffers(&names);
            }
            DrawMethod::DrawElementsIndirect => {
                let buffer = build_draw_elements_indirect_command(
                    vertex_count,
                    instance_count,
                    index_offset,
                    index_type,
                    base_vertex,
                    indirect_offset,
                );
                let mut names = [0u32];
                ctx.gen_buffers(&mut names);
                ctx.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, names[0]);
                ctx.buffer_data(glw::GL_DRAW_INDIRECT_BUFFER, buffer.len() as isize, Some(&buffer));
                ctx.draw_elements_indirect(primitive.to_gl(), index_type.to_gl(), indirect_offset);
                ctx.delete_buffers(&names);
            }
            DrawMethod::DrawElementsBaseVertex => {
                ctx.draw_elements_base_vertex(
                    primitive.to_gl(),
                    vertex_count,
                    index_type.to_gl(),
                    index_offset,
                    base_vertex,
                );
            }
            DrawMethod::DrawElementsInstancedBaseVertex => {
                ctx.draw_elements_instanced_base_vertex(
                    primitive.to_gl(),
                    vertex_count,
                    index_type.to_gl(),
                    index_offset,
                    instance_count,
                    base_vertex,
                );
            }
            DrawMethod::DrawElementsRangedBaseVertex => {
                ctx.draw_range_elements_base_vertex(
                    primitive.to_gl(),
                    range_start,
                    range_end,
                    vertex_count,
                    index_type.to_gl(),
                    index_offset,
                    base_vertex,
                );
            }
            DrawMethod::Last => unreachable!("DrawMethod::Last is never a real draw method"),
        }

        for (array_ndx, array) in self.arrays.iter().enumerate() {
            if array.is_bound() {
                let loc = ctx.get_attrib_location(self.program_id, &format!("a_{array_ndx}")) as u32;
                ctx.disable_vertex_attrib_array(loc);
            }
        }

        if self.use_vao {
            ctx.bind_vertex_array(0);
        }

        ctx.use_program(0);

        let (width, height) = (self.screen.get_width(), self.screen.get_height());
        ctx.read_pixels(&mut self.screen, 0, 0, width, height);
    }

    /// `AttributePack::getSurface`
    pub fn surface(&self) -> &Surface {
        &self.screen
    }
}

/// The `DrawArraysIndirectCommand` upstream builds inline in `render`'s
/// `DRAWMETHOD_DRAWARRAYS_INDIRECT` branch: `{ count, primCount, first,
/// reservedMustBeZero }`, four `u32`s, written at `indirect_offset` into a buffer that
/// is otherwise zero-filled padding up to that point (matching upstream's own
/// `new uint8_t[sizeof(DrawCommand) + indirectOffset]`, which leaves the leading bytes
/// uninitialised - zero-filling instead is strictly safer and does not change what the
/// driver reads, since it never reads before `indirect_offset`).
fn build_draw_arrays_indirect_command(
    vertex_count: i32,
    instance_count: i32,
    first_vertex: i32,
    indirect_offset: usize,
) -> Vec<u8> {
    let mut buffer = vec![0u8; indirect_offset + 16];
    let cmd = indirect_offset;
    buffer[cmd..cmd + 4].copy_from_slice(&(vertex_count as u32).to_ne_bytes());
    buffer[cmd + 4..cmd + 8].copy_from_slice(&(instance_count as u32).to_ne_bytes());
    buffer[cmd + 8..cmd + 12].copy_from_slice(&(first_vertex as u32).to_ne_bytes());
    buffer[cmd + 12..cmd + 16].copy_from_slice(&0u32.to_ne_bytes());
    buffer
}

/// The `DrawElementsIndirectCommand`: `{ count, primCount, firstIndex, baseVertex,
/// reservedMustBeZero }` - `firstIndex` is `index_offset` (a byte offset, matching
/// every other draw call's own `indices_offset` convention in this port) divided by
/// the index type's own byte size, exactly as upstream's
/// `offsetAsInteger / gls::DrawTestSpec::indexTypeSize(indexType)` does.
fn build_draw_elements_indirect_command(
    vertex_count: i32,
    instance_count: i32,
    index_offset: usize,
    index_type: IndexType,
    base_vertex: i32,
    indirect_offset: usize,
) -> Vec<u8> {
    let first_index = (index_offset / index_type.size() as usize) as u32;
    let mut buffer = vec![0u8; indirect_offset + 20];
    let cmd = indirect_offset;
    buffer[cmd..cmd + 4].copy_from_slice(&(vertex_count as u32).to_ne_bytes());
    buffer[cmd + 4..cmd + 8].copy_from_slice(&(instance_count as u32).to_ne_bytes());
    buffer[cmd + 8..cmd + 12].copy_from_slice(&first_index.to_ne_bytes());
    buffer[cmd + 12..cmd + 16].copy_from_slice(&base_vertex.to_ne_bytes());
    buffer[cmd + 16..cmd + 20].copy_from_slice(&0u32.to_ne_bytes());
    buffer
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::gls::draw_test::spec::{InputType, OutputType, Usage};
    use crate::glu::render_context::ApiType;
    use crate::rr::generic_vector::GenericVec4;
    use crate::sglr::reference_context::ReferenceContext;
    use crate::tcu::pixel::TextureLevel;
    use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};

    fn es2() -> ContextType {
        ContextType { api: ApiType::es(2, 0) }
    }

    /// Same three-line helper `attribute_array.rs`'s own tests use.
    fn ctx() -> ReferenceContext {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let color = TextureLevel::new(format, 8, 8, 1).unwrap();
        ReferenceContext::new(16, color, None, 8)
    }

    #[test]
    fn new_array_and_clear_arrays_track_the_count() {
        let mut cx = ctx();
        let mut pack = AttributePack::new(&mut cx, es2(), 8, 8, false);
        assert_eq!(pack.array_count(), 0);

        pack.new_array(&mut cx, Storage::User);
        pack.new_array(&mut cx, Storage::User);
        assert_eq!(pack.array_count(), 2);

        pack.clear_arrays(&mut cx);
        assert_eq!(pack.array_count(), 0);

        pack.destroy(&mut cx);
    }

    #[test]
    fn update_program_assigns_a_nonzero_program_id() {
        let mut cx = ctx();
        let mut pack = AttributePack::new(&mut cx, es2(), 8, 8, false);
        assert_eq!(pack.program_id(), 0);

        pack.new_array(&mut cx, Storage::User);
        pack.array_mut(0).setup_array(
            false,
            0,
            2,
            InputType::Float,
            OutputType::Vec2,
            false,
            0,
            0,
            GenericVec4::zero(),
            true,
            false,
        );

        pack.update_program(&mut cx);
        assert_ne!(pack.program_id(), 0);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        pack.destroy(&mut cx);
    }

    #[test]
    #[should_panic(expected = "update_program")]
    fn render_panics_if_update_program_was_never_called() {
        let mut cx = ctx();
        let mut pack = AttributePack::new(&mut cx, es2(), 8, 8, false);
        pack.render(
            &mut cx,
            Primitive::Points,
            DrawMethod::DrawArrays,
            0,
            1,
            IndexType::Short,
            0,
            0,
            0,
            1,
            0,
            0,
            1.0,
            1.0,
            None,
        );
    }

    #[test]
    fn render_draw_arrays_points_reports_no_gl_error() {
        let mut cx = ctx();
        // `use_vao = true`: a non-default VAO refuses a client/user pointer unless an
        // array buffer is bound (`ReferenceContext::vertex_attrib_pointer`'s own
        // `vertex_array_binding.is_some() && array_buffer_binding.is_none() &&
        // has_pointer` check), so this test's attribute has to be `Storage::Buffer` -
        // the realistic `AttributePack` configuration anyway (a core-profile-style
        // driver test always goes through a real buffer object).
        let mut pack = AttributePack::new(&mut cx, es2(), 8, 8, true);

        // One position attribute: a single vec2 vertex at the origin.
        pack.new_array(&mut cx, Storage::Buffer);
        let position_data: [f32; 2] = [0.0, 0.0];
        pack.array_mut(0).set_data(
            &mut cx,
            Target::Array,
            bytemuck_f32_bytes(&position_data),
            Usage::StaticDraw,
        );
        pack.array_mut(0).setup_array(
            true,
            0,
            2,
            InputType::Float,
            OutputType::Vec2,
            false,
            0,
            0,
            GenericVec4::zero(),
            true,
            false,
        );

        pack.update_program(&mut cx);
        assert_ne!(pack.program_id(), 0);

        pack.render(
            &mut cx,
            Primitive::Points,
            DrawMethod::DrawArrays,
            0,
            1,
            IndexType::Short,
            0,
            0,
            0,
            1,
            0,
            0,
            1.0,
            1.0,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        pack.destroy(&mut cx);
    }

    /// Reinterprets an `f32` slice as the raw bytes `AttributeArray::set_data` wants -
    /// a three-line local helper rather than pulling in a `bytemuck`-style crate for
    /// one test's fixture data.
    fn bytemuck_f32_bytes(values: &[f32]) -> &[u8] {
        // SAFETY: `f32` has no padding/alignment requirement stricter than `u8`, and
        // the resulting slice's lifetime is tied to `values`' own borrow.
        unsafe { std::slice::from_raw_parts(values.as_ptr().cast::<u8>(), std::mem::size_of_val(values)) }
    }

    #[test]
    fn build_draw_arrays_indirect_command_lays_out_the_four_fields_at_the_offset() {
        let buffer = build_draw_arrays_indirect_command(5, 2, 3, 4);
        assert_eq!(buffer.len(), 20);
        assert_eq!(
            u32::from_ne_bytes(buffer[0..4].try_into().unwrap()),
            0,
            "padding before the offset stays zero"
        );
        assert_eq!(u32::from_ne_bytes(buffer[4..8].try_into().unwrap()), 5, "count");
        assert_eq!(u32::from_ne_bytes(buffer[8..12].try_into().unwrap()), 2, "primCount");
        assert_eq!(u32::from_ne_bytes(buffer[12..16].try_into().unwrap()), 3, "first");
        assert_eq!(
            u32::from_ne_bytes(buffer[16..20].try_into().unwrap()),
            0,
            "reservedMustBeZero"
        );
    }

    #[test]
    fn build_draw_elements_indirect_command_divides_the_byte_offset_by_the_index_size() {
        // index_offset = 12 bytes, IndexType::Short (2 bytes) -> firstIndex = 6.
        let buffer = build_draw_elements_indirect_command(7, 1, 12, IndexType::Short, -2, 0);
        assert_eq!(buffer.len(), 20);
        assert_eq!(u32::from_ne_bytes(buffer[0..4].try_into().unwrap()), 7, "count");
        assert_eq!(u32::from_ne_bytes(buffer[4..8].try_into().unwrap()), 1, "primCount");
        assert_eq!(u32::from_ne_bytes(buffer[8..12].try_into().unwrap()), 6, "firstIndex");
        assert_eq!(i32::from_ne_bytes(buffer[12..16].try_into().unwrap()), -2, "baseVertex");
        assert_eq!(
            u32::from_ne_bytes(buffer[16..20].try_into().unwrap()),
            0,
            "reservedMustBeZero"
        );
    }
}
