// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fBufferTestUtil.cpp / .hpp  (BufferTestUtil::)
//   framework/common/tcuRandomValueIterator.hpp             (fillWithRandomBytes)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `compareByteArrays` is not ported -
// it exists for the buffer *read* groups, which are not ported yet, and it is pure
// logging. `BufferVerifierBase`'s virtual dispatch is one enum here, since the two
// verifiers share their whole interface and upstream's `BufferVerifier` already exists
// only to own one of them.

use crate::glu::{self, Context, ProgramSources, ShaderProgram};
use crate::glw::{self, GLenum, GLuint};
use crate::tcu::image_compare::pixel_threshold_compare;
use crate::tcu::rgba::RGBA;
use crate::tcu::{Random, Surface, TestError, Vec2, Vec3};

/// Quad size in `VertexArrayVerifier`
const VERIFY_QUAD_SIZE: i32 = 8;
/// Maximum number of lines per one draw in `IndexArrayVerifier`
const MAX_LINES_PER_INDEX_ARRAY_DRAW: i32 = 128;
const INDEX_ARRAY_DRAW_VIEWPORT_WIDTH: i32 = 128;
const INDEX_ARRAY_DRAW_VIEWPORT_HEIGHT: i32 = 128;

/// `BufferTestUtil::fillWithRandomBytes`
///
/// Upstream goes through `tcu::RandomValueIterator<uint8_t>`, whose specialisation is
/// one `getUint32()` per byte - the low byte of each draw, not four bytes per draw.
pub fn fill_with_random_bytes(dst: &mut [u8], seed: u32) {
    let mut rnd = Random::new(seed);
    for byte in dst.iter_mut() {
        *byte = rnd.get_uint32() as u8;
    }
}

/// `BufferTestUtil::getBufferTargetName` - the whole `glsBufferTestUtil.cpp` table, so
/// the ES 3.0 groups that reuse this module can name their targets too.
pub fn get_buffer_target_name(target: GLenum) -> &'static str {
    match target {
        glw::GL_ARRAY_BUFFER => "array",
        glw::GL_COPY_READ_BUFFER => "copy_read",
        glw::GL_COPY_WRITE_BUFFER => "copy_write",
        glw::GL_ELEMENT_ARRAY_BUFFER => "element_array",
        glw::GL_PIXEL_PACK_BUFFER => "pixel_pack",
        glw::GL_PIXEL_UNPACK_BUFFER => "pixel_unpack",
        glw::GL_TEXTURE_BUFFER => "texture",
        glw::GL_TRANSFORM_FEEDBACK_BUFFER => "transform_feedback",
        glw::GL_UNIFORM_BUFFER => "uniform",
        _ => unreachable!("unknown buffer target"),
    }
}

/// `BufferTestUtil::getUsageHintName`
pub fn get_usage_hint_name(hint: GLenum) -> &'static str {
    match hint {
        glw::GL_STREAM_DRAW => "stream_draw",
        glw::GL_STREAM_READ => "stream_read",
        glw::GL_STREAM_COPY => "stream_copy",
        glw::GL_STATIC_DRAW => "static_draw",
        glw::GL_STATIC_READ => "static_read",
        glw::GL_STATIC_COPY => "static_copy",
        glw::GL_DYNAMIC_DRAW => "dynamic_draw",
        glw::GL_DYNAMIC_READ => "dynamic_read",
        glw::GL_DYNAMIC_COPY => "dynamic_copy",
        _ => unreachable!("unknown usage hint"),
    }
}

/// `BufferCase::checkError`
pub fn check_error(gl: &glw::Functions) -> Result<(), TestError> {
    // SAFETY: glGetError needs only a current context.
    let err = unsafe { gl.get_error() };
    if err != glw::GL_NO_ERROR {
        return Err(TestError::Fail(format!("Got {}", glw::error_name(err))));
    }
    Ok(())
}

/// `BufferTestUtil::VerifyType`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum VerifyType {
    VertexArray,
    IndexArray,
}

/// `BufferTestUtil::BufferVerifier` - owns the program its verifier draws with.
pub struct BufferVerifier<'gl> {
    verify_type: VerifyType,
    program: ShaderProgram<'gl>,
    pos_loc: GLuint,
    /// `a_byteVec` for the vertex-array verifier, `a_color` for the index-array one.
    data_loc: GLuint,
}

impl<'gl> BufferVerifier<'gl> {
    pub fn new(gl: &'gl glw::Functions, verify_type: VerifyType) -> Result<Self, TestError> {
        let sources = match verify_type {
            VerifyType::VertexArray => ProgramSources::vtx_frag(
                "attribute highp vec2 a_position;\nattribute mediump vec3 a_byteVec;\nvarying mediump vec3 v_byteVec;\nvoid main (void)\n{\n    gl_Position = vec4(a_position, 0.0, 1.0);\n    v_byteVec = a_byteVec;\n}\n",
                "varying mediump vec3 v_byteVec;\nvoid main (void)\n{\n    gl_FragColor = vec4(v_byteVec, 1.0);\n}\n",
            ),
            VerifyType::IndexArray => ProgramSources::vtx_frag(
                "attribute highp vec2 a_position;\nattribute mediump vec3 a_color;\nvarying mediump vec3 v_color;\nvoid main (void)\n{\n    gl_Position = vec4(a_position, 0.0, 1.0);\n    v_color = a_color;\n}\n",
                "varying mediump vec3 v_color;\nvoid main (void)\n{\n    gl_FragColor = vec4(v_color, 1.0);\n}\n",
            ),
        };
        let program = ShaderProgram::new(gl, &sources);
        if !program.is_ok() {
            return Err(TestError::Fail("Compile failed".to_string()));
        }

        let data_name = match verify_type {
            VerifyType::VertexArray => c"a_byteVec",
            VerifyType::IndexArray => c"a_color",
        };
        // SAFETY: the program linked, and both names are declared in its vertex shader.
        let (pos_loc, data_loc) = unsafe {
            (
                gl.get_attrib_location(program.program(), c"a_position".as_ptr()),
                gl.get_attrib_location(program.program(), data_name.as_ptr()),
            )
        };

        Ok(Self {
            verify_type,
            program,
            pos_loc: pos_loc as GLuint,
            data_loc: data_loc as GLuint,
        })
    }

    /// `BufferVerifier::getMinSize`
    pub fn min_size(&self) -> i32 {
        match self.verify_type {
            VerifyType::VertexArray => 3 * 4,
            VerifyType::IndexArray => 2,
        }
    }

    /// `BufferVerifier::verify`. The offset is applied to the reference pointer as well.
    pub fn verify(&self, context: &Context, buffer: GLuint, reference: &[u8], offset: i32, num_bytes: i32) -> Result<bool, TestError> {
        debug_assert!(num_bytes >= self.min_size());
        match self.verify_type {
            VerifyType::VertexArray => self.verify_as_vertex_array(context, buffer, reference, offset, num_bytes),
            VerifyType::IndexArray => self.verify_as_index_array(context, buffer, reference, offset, num_bytes),
        }
    }

    /// `VertexArrayVerifier::verify`
    fn verify_as_vertex_array(&self, context: &Context, buffer: GLuint, ref_ptr: &[u8], offset: i32, num_bytes: i32) -> Result<bool, TestError> {
        let gl = context.gl();
        let render_target = context.render_target();
        let num_bytes_in_vtx = 3;
        let num_bytes_in_quad = num_bytes_in_vtx * 4;
        let max_quads_x = 128.min(render_target.width / VERIFY_QUAD_SIZE);
        let max_quads_y = 128.min(render_target.height / VERIFY_QUAD_SIZE);
        let max_quads_per_batch = max_quads_x * max_quads_y;
        let mut num_verified = 0;
        let program = self.program.program();
        let threshold = render_target.pixel_format().get_color_threshold() + RGBA::new(4, 4, 4, 4);
        let mut is_ok = true;

        let mut rendered = Surface::new(0, 0);
        let mut reference = Surface::new(0, 0);

        debug_assert!(num_bytes >= num_bytes_in_quad); // Can't render full quad with smaller buffers.

        let positions = compute_positions(max_quads_x, max_quads_y);
        let indices = compute_indices(max_quads_x, max_quads_y);

        // SAFETY: every draw below reads from client arrays that outlive it, or from
        // the buffer bound to GL_ARRAY_BUFFER at an offset inside the range the caller
        // has already specified.
        unsafe {
            // Reset buffer bindings.
            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);

            // Setup rendering state.
            gl.viewport(0, 0, max_quads_x * VERIFY_QUAD_SIZE, max_quads_y * VERIFY_QUAD_SIZE);
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.use_program(program);
            gl.enable_vertex_attrib_array(self.pos_loc);
            gl.vertex_attrib_pointer(self.pos_loc, 2, glw::GL_FLOAT, glw::FALSE, 0, positions.as_ptr().cast());
            gl.enable_vertex_attrib_array(self.data_loc);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer);

            while num_verified < num_bytes {
                let num_remaining = num_bytes - num_verified;
                let is_leftover_batch = num_remaining < num_bytes_in_quad;
                let num_bytes_to_verify = if is_leftover_batch {
                    num_bytes_in_quad
                } else {
                    (max_quads_per_batch * num_bytes_in_quad).min(num_remaining - num_remaining % num_bytes_in_quad)
                };
                let cur_offset = if is_leftover_batch { num_bytes - num_bytes_in_quad } else { num_verified };
                let num_quads = num_bytes_to_verify / num_bytes_in_quad;
                let num_cols = max_quads_x.min(num_quads);
                let num_rows = num_quads / max_quads_x + i32::from(num_quads % max_quads_x != 0);

                // Render batch.
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
                gl.vertex_attrib_pointer(
                    self.data_loc,
                    3,
                    glw::GL_UNSIGNED_BYTE,
                    glw::TRUE,
                    0,
                    (offset + cur_offset) as usize as *const std::ffi::c_void,
                );
                gl.draw_elements(glw::GL_TRIANGLES, num_quads * 6, glw::GL_UNSIGNED_SHORT, indices.as_ptr().cast());

                render_quad_grid_reference(&mut reference, num_quads, num_cols, &ref_ptr[(offset + cur_offset) as usize..]);

                rendered.set_size(num_cols * VERIFY_QUAD_SIZE, num_rows * VERIFY_QUAD_SIZE);
                glu::read_pixels(&context.render_context, 0, 0, &mut rendered.get_access())?;

                if !pixel_threshold_compare(&reference, &rendered, threshold).ok {
                    is_ok = false;
                    break;
                }

                num_verified += if is_leftover_batch { num_remaining } else { num_bytes_to_verify };
            }

            gl.disable_vertex_attrib_array(self.pos_loc);
            gl.disable_vertex_attrib_array(self.data_loc);
        }

        Ok(is_ok)
    }

    /// `IndexArrayVerifier::verify`
    fn verify_as_index_array(&self, context: &Context, buffer: GLuint, ref_ptr: &[u8], offset: i32, num_bytes: i32) -> Result<bool, TestError> {
        let gl = context.gl();
        let render_target = context.render_target();
        let viewport_w = INDEX_ARRAY_DRAW_VIEWPORT_WIDTH.min(render_target.width);
        let viewport_h = INDEX_ARRAY_DRAW_VIEWPORT_HEIGHT.min(render_target.height);
        let min_bytes_per_batch = 2;
        let threshold = RGBA::new(0, 0, 0, 0);

        let mut fetched_pos = vec![Vec2::new(0.0, 0.0); MAX_LINES_PER_INDEX_ARRAY_DRAW as usize + 1];
        let mut fetched_color = vec![Vec3::new(0.0, 0.0, 0.0); MAX_LINES_PER_INDEX_ARRAY_DRAW as usize + 1];

        let mut index_buffer_img = Surface::new(viewport_w, viewport_h);
        let mut reference_img = Surface::new(viewport_w, viewport_h);

        let mut num_verified = 0;
        let mut is_ok = true;

        let positions = compute_index_verifier_positions();
        let colors = compute_index_verifier_colors();

        // SAFETY: as in the vertex-array verifier; every index the manual fetch reads
        // is one byte, so it cannot leave the 256-entry position and colour arrays.
        unsafe {
            // Reset buffer bindings.
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, buffer);

            // Setup rendering state.
            gl.viewport(0, 0, viewport_w, viewport_h);
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.use_program(self.program.program());
            gl.enable_vertex_attrib_array(self.pos_loc);
            gl.enable_vertex_attrib_array(self.data_loc);
            gl.enable(glw::GL_BLEND);
            gl.blend_func(glw::GL_ONE, glw::GL_ONE);
            gl.blend_equation(glw::GL_FUNC_ADD);

            while num_verified < num_bytes {
                let num_remaining = num_bytes - num_verified;
                let is_leftover_batch = num_remaining < min_bytes_per_batch;
                let num_bytes_to_verify = if is_leftover_batch {
                    min_bytes_per_batch
                } else {
                    (MAX_LINES_PER_INDEX_ARRAY_DRAW + 1).min(num_remaining)
                };
                let cur_offset = if is_leftover_batch { num_bytes - min_bytes_per_batch } else { num_verified };

                // Step 1: Render using index buffer.
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
                gl.vertex_attrib_pointer(self.pos_loc, 2, glw::GL_FLOAT, glw::FALSE, 0, positions.as_ptr().cast());
                gl.vertex_attrib_pointer(self.data_loc, 3, glw::GL_FLOAT, glw::FALSE, 0, colors.as_ptr().cast());
                gl.draw_elements(
                    glw::GL_LINE_STRIP,
                    num_bytes_to_verify,
                    glw::GL_UNSIGNED_BYTE,
                    (offset + cur_offset) as usize as *const std::ffi::c_void,
                );
                glu::read_pixels(&context.render_context, 0, 0, &mut index_buffer_img.get_access())?;

                // Step 2: Do manual fetch and render without index buffer.
                let batch_indices = &ref_ptr[(offset + cur_offset) as usize..(offset + cur_offset + num_bytes_to_verify) as usize];
                for (i, &index) in batch_indices.iter().enumerate() {
                    fetched_pos[i] = positions[index as usize];
                    fetched_color[i] = colors[index as usize];
                }

                gl.clear(glw::GL_COLOR_BUFFER_BIT);
                gl.vertex_attrib_pointer(self.pos_loc, 2, glw::GL_FLOAT, glw::FALSE, 0, fetched_pos.as_ptr().cast());
                gl.vertex_attrib_pointer(self.data_loc, 3, glw::GL_FLOAT, glw::FALSE, 0, fetched_color.as_ptr().cast());
                gl.draw_arrays(glw::GL_LINE_STRIP, 0, num_bytes_to_verify);
                glu::read_pixels(&context.render_context, 0, 0, &mut reference_img.get_access())?;

                if !pixel_threshold_compare(&reference_img, &index_buffer_img, threshold).ok {
                    is_ok = false;
                    break;
                }

                num_verified += if is_leftover_batch { num_remaining } else { num_bytes_to_verify };
            }
        }

        Ok(is_ok)
    }
}

fn compute_positions(grid_size_x: i32, grid_size_y: i32) -> Vec<Vec2> {
    let mut positions = vec![Vec2::new(0.0, 0.0); (grid_size_x * grid_size_y * 4) as usize];

    for y in 0..grid_size_y {
        for x in 0..grid_size_x {
            let sx0 = x as f32 / grid_size_x as f32;
            let sy0 = y as f32 / grid_size_y as f32;
            let sx1 = (x + 1) as f32 / grid_size_x as f32;
            let sy1 = (y + 1) as f32 / grid_size_y as f32;
            let fx0 = 2.0 * sx0 - 1.0;
            let fy0 = 2.0 * sy0 - 1.0;
            let fx1 = 2.0 * sx1 - 1.0;
            let fy1 = 2.0 * sy1 - 1.0;
            let base_ndx = ((y * grid_size_x + x) * 4) as usize;

            positions[base_ndx] = Vec2::new(fx0, fy0);
            positions[base_ndx + 1] = Vec2::new(fx0, fy1);
            positions[base_ndx + 2] = Vec2::new(fx1, fy0);
            positions[base_ndx + 3] = Vec2::new(fx1, fy1);
        }
    }

    positions
}

fn compute_indices(grid_size_x: i32, grid_size_y: i32) -> Vec<u16> {
    let mut indices = vec![0u16; (3 * 2 * grid_size_x * grid_size_y) as usize];

    for quad_ndx in 0..(grid_size_x * grid_size_y) as usize {
        let v00 = quad_ndx * 4;
        let v01 = quad_ndx * 4 + 1;
        let v10 = quad_ndx * 4 + 2;
        let v11 = quad_ndx * 4 + 3;

        indices[quad_ndx * 6] = v10 as u16;
        indices[quad_ndx * 6 + 1] = v00 as u16;
        indices[quad_ndx * 6 + 2] = v01 as u16;

        indices[quad_ndx * 6 + 3] = v10 as u16;
        indices[quad_ndx * 6 + 4] = v01 as u16;
        indices[quad_ndx * 6 + 5] = v11 as u16;
    }

    indices
}

fn fetch_vtx_color(ptr: &[u8], vtx_ndx: usize) -> [f32; 4] {
    RGBA::new(ptr[vtx_ndx * 3] as i32, ptr[vtx_ndx * 3 + 1] as i32, ptr[vtx_ndx * 3 + 2] as i32, 255)
        .to_vec()
        .m_data
}

fn render_quad_grid_reference(dst: &mut Surface, num_quads: i32, row_length: i32, in_ptr: &[u8]) {
    dst.set_size(
        row_length * VERIFY_QUAD_SIZE,
        (num_quads / row_length + i32::from(num_quads % row_length != 0)) * VERIFY_QUAD_SIZE,
    );

    let mut dst_access = dst.get_access();
    crate::tcu::pixel::clear_int(&mut dst_access, [0, 0, 0, 0xff]);

    for quad_ndx in 0..num_quads {
        let x0 = (quad_ndx % row_length) * VERIFY_QUAD_SIZE;
        let y0 = (quad_ndx / row_length) * VERIFY_QUAD_SIZE;
        let v00 = fetch_vtx_color(in_ptr, quad_ndx as usize * 4);
        let v10 = fetch_vtx_color(in_ptr, quad_ndx as usize * 4 + 1);
        let v01 = fetch_vtx_color(in_ptr, quad_ndx as usize * 4 + 2);
        let v11 = fetch_vtx_color(in_ptr, quad_ndx as usize * 4 + 3);

        for y in 0..VERIFY_QUAD_SIZE {
            for x in 0..VERIFY_QUAD_SIZE {
                let fx = (x as f32 + 0.5) / VERIFY_QUAD_SIZE as f32;
                let fy = (y as f32 + 0.5) / VERIFY_QUAD_SIZE as f32;

                let tri = fx + fy <= 1.0;
                let tx = if tri { fx } else { 1.0 - fx };
                let ty = if tri { fy } else { 1.0 - fy };
                let t0 = if tri { v00 } else { v11 };
                let t1 = if tri { v01 } else { v10 };
                let t2 = if tri { v10 } else { v01 };
                let mut color = [0.0f32; 4];
                for c in 0..4 {
                    color[c] = t0[c] + (t1[c] - t0[c]) * tx + (t2[c] - t0[c]) * ty;
                }

                dst_access.set_pixel(color, (x0 + x) as u32, (y0 + y) as u32, 0);
            }
        }
    }
}

fn compute_index_verifier_positions() -> Vec<Vec2> {
    let num_pos_x = 16;
    let num_pos_y = 16;
    let mut dst = vec![Vec2::new(0.0, 0.0); num_pos_x * num_pos_y];

    for y in 0..num_pos_y {
        for x in 0..num_pos_x {
            let xf = x as f32 / (num_pos_x - 1) as f32;
            let yf = y as f32 / (num_pos_y - 1) as f32;

            dst[y * num_pos_x + x] = Vec2::new(2.0 * xf - 1.0, 2.0 * yf - 1.0);
        }
    }

    dst
}

fn compute_index_verifier_colors() -> Vec<Vec3> {
    let num_colors = 256;
    let min_val = 0.1;
    let max_val = 0.5;
    let mut rnd = Random::new(0xabc231);

    (0..num_colors)
        .map(|_| {
            let x = rnd.get_float_range(min_val, max_val);
            let y = rnd.get_float_range(min_val, max_val);
            let z = rnd.get_float_range(min_val, max_val);
            Vec3::new(x, y, z)
        })
        .collect()
}
