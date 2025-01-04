// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsFragmentOpUtil.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The pair that makes a fragment-operation test verifiable without a rasteriser: one
// renderer draws a screen-aligned quad with GL, the other walks the same quad's pixels
// on the host and pushes each one through `rr::FragmentProcessor`. Both see the same
// interpolated colour, so the only thing under test is what the driver does *after*
// interpolation.

use crate::glu::{self, ProgramSources, ShaderProgram};
use crate::glw::{self, GLuint};
use crate::rr::fragment_operations::{Fragment, FragmentProcessor};
use crate::rr::render_state::{FaceType, FragmentOperationState};
use crate::tcu::defs::TestError;
use crate::tcu::pixel::PixelBufferAccess;

/// `gls::FragmentOpUtil::triQuadInterpolate`
fn tri_quad_interpolate_f32(values: &[f32; 4], x_factor: f32, y_factor: f32) -> f32 {
    if x_factor + y_factor < 1.0 {
        values[0] + (values[2] - values[0]) * x_factor + (values[1] - values[0]) * y_factor
    } else {
        values[3] + (values[1] - values[3]) * (1.0 - x_factor) + (values[2] - values[3]) * (1.0 - y_factor)
    }
}

/// `gls::FragmentOpUtil::triQuadInterpolate`, the `tcu::Vec4` instantiation.
fn tri_quad_interpolate_vec4(values: &[[f32; 4]; 4], x_factor: f32, y_factor: f32) -> [f32; 4] {
    let mut result = [0.0f32; 4];
    for c in 0..4 {
        result[c] = tri_quad_interpolate_f32(
            &[values[0][c], values[1][c], values[2][c], values[3][c]],
            x_factor,
            y_factor,
        );
    }
    result
}

/// `gls::FragmentOpUtil::Quad`
#[derive(Debug, Clone, Copy)]
pub struct Quad {
    pub pos_a: [f32; 2],
    pub pos_b: [f32; 2],
    /// Normalized device coordinates (range [-1, 1]).
    /// In order (A.x, A.y), (A.x, B.y), (B.x, A.y), (B.x, B.y)
    pub color: [[f32; 4]; 4],
    pub color1: [[f32; 4]; 4],
    pub depth: [f32; 4],
}

impl Default for Quad {
    fn default() -> Self {
        Self {
            pos_a: [-1.0, -1.0],
            pos_b: [1.0, 1.0],
            color: [[0.0; 4]; 4],
            color1: [[0.0; 4]; 4],
            depth: [0.0; 4],
        }
    }
}

/// `gls::FragmentOpUtil::IntegerQuad`
#[derive(Debug, Clone, Copy)]
pub struct IntegerQuad {
    pub pos_a: [i32; 2],
    pub pos_b: [i32; 2],
    /// Viewport coordinates (depth in range [0, 1]).
    /// In order (A.x, A.y), (A.x, B.y), (B.x, A.y), (B.x, B.y)
    pub color: [[f32; 4]; 4],
    pub color1: [[f32; 4]; 4],
    pub depth: [f32; 4],
}

impl Default for IntegerQuad {
    fn default() -> Self {
        Self {
            pos_a: [0, 0],
            pos_b: [1, 1],
            color: [[0.0; 4]; 4],
            color1: [[0.0; 4]; 4],
            depth: [0.0; 4],
        }
    }
}

// GLSL ES 1.0 shaders
const GLSL1_VERT_SRC: &str = "attribute highp vec4 a_position;\n\
                              attribute mediump vec4 a_color;\n\
                              varying mediump vec4 v_color;\n\
                              void main()\n\
                              {\n\
                              \tgl_Position = a_position;\n\
                              \tv_color = a_color;\n\
                              }\n";
const GLSL1_FRAG_SRC: &str = "varying mediump vec4 v_color;\n\
                              void main()\n\
                              {\n\
                              \tgl_FragColor = v_color;\n\
                              }\n";

// GLSL ES 3.0 shaders
const GLSL3_VERT_SRC: &str = "#version 300 es\n\
                              in highp vec4 a_position;\n\
                              in mediump vec4 a_color;\n\
                              out mediump vec4 v_color;\n\
                              void main()\n\
                              {\n\
                              \tgl_Position = a_position;\n\
                              \tv_color = a_color;\n\
                              }\n";
const GLSL3_FRAG_SRC: &str = "#version 300 es\n\
                              in mediump vec4 v_color;\n\
                              layout(location = 0) out mediump vec4 o_color;\n\
                              void main()\n\
                              {\n\
                              \to_color = v_color;\n\
                              }\n";

/// The `glu::GLSLVersion` values `QuadRenderer` accepts. Upstream also has the GLSL 3.30
/// pair, for the desktop `blend_func_extended` tests; there is no desktop GL root here.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum QuadRendererGlslVersion {
    Es100,
    Es300,
}

/// `gls::FragmentOpUtil::QuadRenderer`
pub struct QuadRenderer<'gl> {
    program: ShaderProgram<'gl>,
    position_loc: i32,
    color_loc: i32,
}

impl<'gl> QuadRenderer<'gl> {
    /// `QuadRenderer::QuadRenderer` - upstream takes the `glu::RenderContext` and asks
    /// it for the functions; one step shorter here, since nothing else of the context
    /// is used.
    pub fn new(gl: &'gl glw::Functions, glsl_version: QuadRendererGlslVersion) -> Result<Self, TestError> {
        let (vert_src, frag_src) = match glsl_version {
            QuadRendererGlslVersion::Es100 => (GLSL1_VERT_SRC, GLSL1_FRAG_SRC),
            QuadRendererGlslVersion::Es300 => (GLSL3_VERT_SRC, GLSL3_FRAG_SRC),
        };

        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vert_src, frag_src));
        if !program.is_ok() {
            return Err(TestError::Fail("Failed to compile program".to_string()));
        }

        // SAFETY: a linked program of this renderer's own.
        let (position_loc, color_loc) = unsafe {
            (
                gl.get_attrib_location(program.program(), c"a_position".as_ptr()),
                gl.get_attrib_location(program.program(), c"a_color".as_ptr()),
            )
        };

        if position_loc < 0 || color_loc < 0 {
            return Err(TestError::Fail("Invalid attribute locations".to_string()));
        }

        Ok(Self {
            program,
            position_loc,
            color_loc,
        })
    }

    /// `QuadRenderer::render`
    pub fn render(&self, gl: &glw::Functions, quad: &Quad) {
        #[rustfmt::skip]
        let position: [f32; 16] = [
            quad.pos_a[0], quad.pos_a[1], quad.depth[0], 1.0,
            quad.pos_a[0], quad.pos_b[1], quad.depth[1], 1.0,
            quad.pos_b[0], quad.pos_a[1], quad.depth[2], 1.0,
            quad.pos_b[0], quad.pos_b[1], quad.depth[3], 1.0,
        ];
        const INDICES: [u8; 6] = [0, 2, 1, 1, 2, 3];

        let colors: [f32; 16] = {
            let mut flat = [0.0f32; 16];
            for (i, c) in quad.color.iter().enumerate() {
                flat[i * 4..i * 4 + 4].copy_from_slice(c);
            }
            flat
        };

        // SAFETY: client-side arrays of exactly the four vertices the indices address,
        // against this renderer's own linked program.
        unsafe {
            gl.use_program(self.program.program());

            gl.enable_vertex_attrib_array(self.position_loc as GLuint);
            gl.vertex_attrib_pointer(
                self.position_loc as GLuint,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                position.as_ptr().cast(),
            );
            gl.enable_vertex_attrib_array(self.color_loc as GLuint);
            gl.vertex_attrib_pointer(
                self.color_loc as GLuint,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                colors.as_ptr().cast(),
            );

            gl.draw_elements(
                glw::GL_TRIANGLES,
                INDICES.len() as i32,
                glw::GL_UNSIGNED_BYTE,
                INDICES.as_ptr().cast(),
            );

            gl.disable_vertex_attrib_array(self.position_loc as GLuint);
            gl.disable_vertex_attrib_array(self.color_loc as GLuint);
        }
        let _ = glu::expect_no_error(gl, "QuadRenderer::render");
    }
}

/// `gls::FragmentOpUtil::ReferenceQuadRenderer`
pub struct ReferenceQuadRenderer {
    fragment_buffer: Vec<Fragment>,
    fragment_processor: FragmentProcessor,
}

impl Default for ReferenceQuadRenderer {
    fn default() -> Self {
        Self::new()
    }
}

/// `ReferenceQuadRenderer::MAX_FRAGMENT_BUFFER_SIZE`
const MAX_FRAGMENT_BUFFER_SIZE: usize = 1024;

impl ReferenceQuadRenderer {
    pub fn new() -> Self {
        Self {
            fragment_buffer: Vec::with_capacity(MAX_FRAGMENT_BUFFER_SIZE),
            fragment_processor: FragmentProcessor::new(),
        }
    }

    /// `ReferenceQuadRenderer::flushFragmentBuffer`
    fn flush_fragment_buffer(
        &mut self,
        color_buffer: &mut PixelBufferAccess<'_>,
        depth_buffer: Option<&mut PixelBufferAccess<'_>>,
        stencil_buffer: Option<&mut PixelBufferAccess<'_>>,
        face_type: FaceType,
        state: &FragmentOperationState,
    ) {
        self.fragment_processor.render(
            color_buffer,
            depth_buffer,
            stencil_buffer,
            &self.fragment_buffer,
            face_type,
            state,
        );
        self.fragment_buffer.clear();
    }

    /// `ReferenceQuadRenderer::render`
    ///
    /// All three buffers are the multisample-indexed accesses `get_multisample_access`
    /// builds; `None` is how the C++'s default-constructed empty access is spelled.
    pub fn render(
        &mut self,
        color_buffer: &mut PixelBufferAccess<'_>,
        depth_buffer: Option<&mut PixelBufferAccess<'_>>,
        stencil_buffer: Option<&mut PixelBufferAccess<'_>>,
        quad: &IntegerQuad,
        state: &FragmentOperationState,
    ) {
        let mut depth_buffer = depth_buffer;
        let mut stencil_buffer = stencil_buffer;
        let flip_x = quad.pos_a[0] > quad.pos_b[0];
        let flip_y = quad.pos_a[1] > quad.pos_b[1];
        let face_type = if flip_x == flip_y {
            FaceType::Front
        } else {
            FaceType::Back
        };
        let x_first = if flip_x { quad.pos_b[0] } else { quad.pos_a[0] };
        let x_last = if flip_x { quad.pos_a[0] } else { quad.pos_b[0] };
        let y_first = if flip_y { quad.pos_b[1] } else { quad.pos_a[1] };
        let y_last = if flip_y { quad.pos_a[1] } else { quad.pos_b[1] };
        let width = (x_last - x_first + 1) as f32;
        let height = (y_last - y_first + 1) as f32;

        for y in y_first..=y_last {
            // Interpolation factor for y.
            let mut y_ratio = (0.5 + (y - y_first) as f32) / height;
            if flip_y {
                y_ratio = 1.0 - y_ratio;
            }

            for x in x_first..=x_last {
                // Interpolation factor for x.
                let mut x_ratio = (0.5 + (x - x_first) as f32) / width;
                if flip_x {
                    x_ratio = 1.0 - x_ratio;
                }

                let color = tri_quad_interpolate_vec4(&quad.color, x_ratio, y_ratio);
                let color1 = tri_quad_interpolate_vec4(&quad.color1, x_ratio, y_ratio);
                let depth = tri_quad_interpolate_f32(&quad.depth, x_ratio, y_ratio);

                // Interpolated color and depth.

                if self.fragment_buffer.len() >= MAX_FRAGMENT_BUFFER_SIZE {
                    self.flush_fragment_buffer(
                        color_buffer,
                        depth_buffer.as_deref_mut(),
                        stencil_buffer.as_deref_mut(),
                        face_type,
                        state,
                    );
                }

                self.fragment_buffer
                    .push(Fragment::single_sampled([x, y], color, color1, 1, depth));
            }
        }

        self.flush_fragment_buffer(color_buffer, depth_buffer, stencil_buffer, face_type, state);
    }
}

/// `gls::FragmentOpUtil::getMultisampleAccess` - takes a normally-indexed 2d pixel
/// buffer and returns an access over the same memory using the multisample indexing
/// convention (x = sample index, y and z = the pixel's x and y).
pub fn get_multisample_access<'a>(original: PixelBufferAccess<'a>) -> PixelBufferAccess<'a> {
    let format = original.format();
    let [width, height, _] = original.size();
    let [_, row_pitch, _] = original.pitch();
    let pixel_size = format.pixel_size().expect("a storable format") as usize;
    PixelBufferAccess::new_with_pitch(
        format,
        [1, width, height],
        [pixel_size, pixel_size, row_pitch],
        original.into_raw_mut(),
    )
}
