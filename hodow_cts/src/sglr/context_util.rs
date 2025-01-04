// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/simplereference/sglrContextUtil.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `drawQuad` is the one helper both `es2fDepthTests.cpp` and `es2fStencilTests.cpp`
// draw every quad through: two triangles covering `[p0, p1]` (a z-interpolated
// diagonal, same vertex layout upstream uses), bound through a VAO + two buffer
// objects (position, index).
//
// **Only the VAO/buffer-object path is ported** (`drawQuadWithVaoBuffers`). Upstream's
// dispatcher additionally picks a client-memory-pointer path
// (`drawQuadWithClientPointers`) for a plain ES2/ES3.0 context, since `GL_OES_vertex_
// array_object` is an optional extension there on a real driver. That distinction only
// matters for `sglr::GLContext` (not ported this session - see `context.rs`'s own
// module doc comment): `sglr::ReferenceContext`, the only `Context` implementor that
// exists here, supports VAOs and buffer objects unconditionally regardless of which
// GLES version a case is nominally testing, and produces an identical reference image
// either way - there is no behavioural difference for this port to dispatch on yet.
// `draw_quad` (the public, upstream-matching name) therefore always calls
// `draw_quad_with_vao_buffers`. Revisit once `GLContext` exists: at that point the
// real dispatch rule (`glu::isContextTypeGLCore(ctxType) || contextSupports(ctxType,
// es(3, 1))`) starts to matter, and `ReferenceContext::draw_elements` would also need a
// client-memory-index draw path (it currently requires a bound `GL_ELEMENT_ARRAY_BUFFER`
// - see that method's own doc comment) before `drawQuadWithClientPointers` could be
// ported at all.

use super::context::Context;
use crate::glw;
use crate::tcu::vector::Vec3;

/// `sglr::drawQuad`
pub fn draw_quad(ctx: &mut dyn Context, program: u32, p0: Vec3, p1: Vec3) {
    draw_quad_with_vao_buffers(ctx, program, p0, p1);
}

/// `sglr::drawQuadWithVaoBuffers`
pub fn draw_quad_with_vao_buffers(ctx: &mut dyn Context, program: u32, p0: Vec3, p1: Vec3) {
    let hz = (p0.z() + p1.z()) * 0.5;
    #[rustfmt::skip]
    let position: [f32; 16] = [
        p0.x(), p0.y(), p0.z(), 1.0,
        p0.x(), p1.y(), hz,     1.0,
        p1.x(), p0.y(), hz,     1.0,
        p1.x(), p1.y(), p1.z(), 1.0,
    ];
    let coord: [f32; 8] = [0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0];
    let indices: [u16; 6] = [0, 1, 2, 2, 1, 3];

    let pos_loc = ctx.get_attrib_location(program, "a_position");
    let coord_loc = ctx.get_attrib_location(program, "a_coord");

    let mut vao_id = [0u32; 1];
    let mut buf_ids = [0u32; 2];

    ctx.gen_vertex_arrays(&mut vao_id);
    ctx.bind_vertex_array(vao_id[0]);

    ctx.gen_buffers(&mut buf_ids);

    ctx.use_program(program);
    assert!(pos_loc >= 0, "TCU_CHECK(posLoc >= 0)");
    {
        ctx.bind_buffer(glw::GL_ARRAY_BUFFER, buf_ids[0]);
        let bytes =
            unsafe { std::slice::from_raw_parts(position.as_ptr().cast::<u8>(), std::mem::size_of_val(&position)) };
        ctx.buffer_data(glw::GL_ARRAY_BUFFER, bytes.len() as isize, Some(bytes));

        ctx.enable_vertex_attrib_array(pos_loc as u32);
        ctx.vertex_attrib_pointer(pos_loc as u32, 4, glw::GL_FLOAT, false, 0, 0, false);

        ctx.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
    }

    if coord_loc >= 0 {
        ctx.bind_buffer(glw::GL_ARRAY_BUFFER, buf_ids[1]);
        let bytes = unsafe { std::slice::from_raw_parts(coord.as_ptr().cast::<u8>(), std::mem::size_of_val(&coord)) };
        ctx.buffer_data(glw::GL_ARRAY_BUFFER, bytes.len() as isize, Some(bytes));

        ctx.enable_vertex_attrib_array(coord_loc as u32);
        ctx.vertex_attrib_pointer(coord_loc as u32, 2, glw::GL_FLOAT, false, 0, 0, false);

        ctx.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
    }

    {
        let mut ndx_id = [0u32; 1];
        ctx.gen_buffers(&mut ndx_id);

        ctx.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, ndx_id[0]);
        let bytes =
            unsafe { std::slice::from_raw_parts(indices.as_ptr().cast::<u8>(), std::mem::size_of_val(&indices)) };
        ctx.buffer_data(glw::GL_ELEMENT_ARRAY_BUFFER, bytes.len() as isize, Some(bytes));

        ctx.draw_elements(glw::GL_TRIANGLES, indices.len() as i32, glw::GL_UNSIGNED_SHORT, 0);

        ctx.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0);
        ctx.delete_buffers(&ndx_id);
    }

    ctx.delete_buffers(&buf_ids);
    ctx.delete_vertex_arrays(&vao_id);
}
