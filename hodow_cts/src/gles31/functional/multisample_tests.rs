// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fMultisampleTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// A genuinely different upstream file from the gles2/gles3 siblings of the same name -
// not `MultisampleCase`/`NumSamplesCase` at all, but `SamplePosQueryCase` (a single
// `glGetMultisamplefv(GL_SAMPLE_POSITION, ...)` range check) plus `DefaultFBOMultisampleCase`
// (a *different* harness, focused on `GL_SAMPLE_MASK`/`glSampleMaski` rather than
// `GL_SAMPLE_COVERAGE`, which gles2/gles3 already cover) and its four subclasses
// (`MaskInvertCase`, `MaskProportionalityCase`, `MaskConstancyCase`, `SampleMaskHighBitsCase`).
// All 8 cases are flat children of one `default_framebuffer` sub-group of `multisample` -
// confirmed against the real gles31 mustpass.
//
// `DefaultFBOMultisampleCase::renderTriangle` uploads through a real VBO/VAO
// (`glu::Buffer`/`glu::VertexArray`) rather than the client-side arrays the gles2/gles3
// siblings use directly - kept as upstream writes it rather than "simplified" to match
// the other two files, per the project's own rule of preserving upstream's shape.

use std::mem::size_of_val;

use crate::glu::{Buffer, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, VertexArray};
use crate::glw::{self, GLbitfield, GLuint};
use crate::tcu::image_compare::pixel_threshold_compare;
use crate::tcu::rgba::RGBA;
use crate::tcu::{Random, Surface, TestError, TestOutcome, TestStatus};

/// `deInt32Hash`
fn de_int32_hash(a: i32) -> u32 {
    let mut key = a as u32;
    key = (key ^ 61) ^ (key >> 16);
    key = key.wrapping_add(key << 3);
    key ^= key >> 4;
    key = key.wrapping_mul(0x27d4_eb2d);
    key ^= key >> 15;
    key
}

/// `deUint32Hash`
fn de_uint32_hash(v: u32) -> u32 {
    de_int32_hash(v as i32)
}

/// `deBitMask32` - callers here always stay inside `least_significant_bit_ndx == 0`, so
/// only the two branches that shape actually reaches are kept live; the third (a mask
/// based at a nonzero bit) is asserted-out upstream too and never called from this file.
fn de_bit_mask32(least_significant_bit_ndx: i32, num_bits: i32) -> u32 {
    if num_bits < 32 && least_significant_bit_ndx < 32 {
        ((1u32 << num_bits) - 1) << least_significant_bit_ndx as u32
    } else {
        debug_assert!(num_bits == 32 && least_significant_bit_ndx == 0);
        0xFFFF_FFFF
    }
}

/// `getEffectiveSampleMaskWordCount`
fn get_effective_sample_mask_word_count(highest_bit_ndx: i32) -> i32 {
    let mask_len = highest_bit_ndx + 1;
    (mask_len - 1) / 32 + 1
}

/// `genAllSetToNthBitSampleMask`
fn gen_all_set_to_nth_bit_sample_mask(nth_bit: i32) -> Vec<u32> {
    let num_words = get_effective_sample_mask_word_count(nth_bit - 1);
    let top_word_bits = nth_bit - (num_words - 1) * 32;
    let mut mask = vec![0xFFFF_FFFFu32; num_words as usize];
    let last = (num_words - 1) as usize;
    mask[last] = de_bit_mask32(0, top_word_bits);
    mask
}

/// `SamplePosQueryCase`
struct SamplePosQueryCase;

impl TestCase for SamplePosQueryCase {
    fn name(&self) -> &str {
        "sample_position"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_target = context.render_target();
        if render_target.num_samples == 0 {
            return Err(TestError::NotSupported("No multisample buffers".to_string()));
        }

        let gl = context.gl();
        let mut error = false;

        for ndx in 0..render_target.num_samples {
            let mut sample_pos = [0.0f32; 2];
            // SAFETY: `sample_pos` is a 2-float buffer, exactly what `GL_SAMPLE_POSITION`
            // writes.
            unsafe { gl.get_multisamplefv(glw::GL_SAMPLE_POSITION, ndx as GLuint, sample_pos.as_mut_ptr()) };
            crate::glu::expect_no_error(gl, "getMultisamplefv")?;

            if !(0.0..=1.0).contains(&sample_pos[0]) || !(0.0..=1.0).contains(&sample_pos[1]) {
                error = true;
            }
        }

        Ok(if !error {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Invalid sample pos")
        })
    }
}

/// `DefaultFBOMultisampleCase` - the shared harness the other four cases in this file
/// build on. A different shape from `gles2`/`gles3`'s own `MultisampleCase`: it targets
/// `GL_SAMPLE_MASK` rather than `GL_SAMPLE_COVERAGE`, and uploads geometry through a real
/// VBO/VAO instead of a client-side array.
struct MultisampleHarness<'gl> {
    gl: &'gl glw::Functions,
    program: ShaderProgram<'gl>,
    attr_position_loc: GLuint,
    attr_color_loc: GLuint,
    num_samples: i32,
    viewport_size: i32,
    render_width: i32,
    render_height: i32,
    viewport_x: i32,
    viewport_y: i32,
    rnd: Random,
}

impl<'gl> MultisampleHarness<'gl> {
    /// `DefaultFBOMultisampleCase::DefaultFBOMultisampleCase` + `::init`.
    fn new(context: &'gl Context, name: &str, desired_viewport_size: i32) -> Result<Self, TestError> {
        let gl = context.gl();
        let render_target = context.render_target();

        if render_target.num_samples <= 1 {
            return Err(TestError::NotSupported("No multisample buffers".to_string()));
        }

        let glsl_version = context.context_type().glsl_version().declaration();
        let vert_source = format!(
            "{glsl_version}\n\
            in highp vec4 a_position;\n\
            in mediump vec4 a_color;\n\
            out mediump vec4 v_color;\n\
            void main()\n\
            {{\n    \
            gl_Position = a_position;\n    \
            v_color = a_color;\n\
            }}\n"
        );
        let frag_source = format!(
            "{glsl_version}\n\
            in mediump vec4 v_color;\n\
            layout(location = 0) out mediump vec4 o_color;\n\
            void main()\n\
            {{\n    \
            o_color = v_color;\n\
            }}\n"
        );

        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(&vert_source, &frag_source));
        if !program.is_ok() {
            return Err(TestError::Fail("Failed to compile program".to_string()));
        }
        // SAFETY: `program` just linked successfully.
        let (attr_position_loc, attr_color_loc) = unsafe {
            (
                gl.get_attrib_location(program.program(), c"a_position".as_ptr()) as GLuint,
                gl.get_attrib_location(program.program(), c"a_color".as_ptr()) as GLuint,
            )
        };

        let mut num_samples: i32 = 0;
        // SAFETY: one property is asked for and one GLint of output is given.
        unsafe { gl.get_integerv(glw::GL_SAMPLES, &mut num_samples) };
        crate::glu::expect_no_error(gl, "getIntegerv(GL_SAMPLES)")?;

        let viewport_size = desired_viewport_size.min(render_target.width).min(render_target.height);
        let mut harness = Self {
            gl,
            program,
            attr_position_loc,
            attr_color_loc,
            num_samples,
            viewport_size,
            render_width: render_target.width,
            render_height: render_target.height,
            viewport_x: 0,
            viewport_y: 0,
            rnd: Random::new(crate::tcu::de_string_hash(name)),
        };
        harness.randomize_viewport();
        Ok(harness)
    }

    /// `DefaultFBOMultisampleCase::randomizeViewport`
    fn randomize_viewport(&mut self) {
        self.viewport_x = self.rnd.get_int(0, self.render_width - self.viewport_size);
        self.viewport_y = self.rnd.get_int(0, self.render_height - self.viewport_size);
        // SAFETY: takes plain integers only.
        unsafe {
            self.gl
                .viewport(self.viewport_x, self.viewport_y, self.viewport_size, self.viewport_size)
        };
    }

    /// `DefaultFBOMultisampleCase::renderTriangle(Vec2, Vec2, Vec2, Vec4, Vec4, Vec4)` -
    /// through a real VBO/VAO, matching upstream exactly (see the file header).
    fn render_triangle_colors(
        &self,
        p0: [f32; 2],
        p1: [f32; 2],
        p2: [f32; 2],
        c0: [f32; 4],
        c1: [f32; 4],
        c2: [f32; 4],
    ) {
        let positions: [f32; 12] = [p0[0], p0[1], 0.0, 1.0, p1[0], p1[1], 0.0, 1.0, p2[0], p2[1], 0.0, 1.0];
        let colors: [f32; 12] = std::array::from_fn(|i| [c0, c1, c2][i / 4][i % 4]);

        let vtx_buf = Buffer::new(self.gl);
        let col_buf = Buffer::new(self.gl);
        let vao = VertexArray::new(self.gl);

        // SAFETY: `positions`/`colors` are each uploaded in full before the draw call
        // that reads them back out of the buffers just filled.
        unsafe {
            self.gl.bind_vertex_array(vao.get());

            self.gl.bind_buffer(glw::GL_ARRAY_BUFFER, vtx_buf.get());
            self.gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(&positions) as isize,
                positions.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
            self.gl.enable_vertex_attrib_array(self.attr_position_loc);
            self.gl.vertex_attrib_pointer(
                self.attr_position_loc,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                std::ptr::null(),
            );

            self.gl.bind_buffer(glw::GL_ARRAY_BUFFER, col_buf.get());
            self.gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(&colors) as isize,
                colors.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
            self.gl.enable_vertex_attrib_array(self.attr_color_loc);
            self.gl
                .vertex_attrib_pointer(self.attr_color_loc, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());

            self.gl.use_program(self.program.program());
            self.gl.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        }
    }

    /// `DefaultFBOMultisampleCase::renderTriangle(Vec2, Vec2, Vec2, Vec4)` - single colour.
    fn render_triangle(&self, p0: [f32; 2], p1: [f32; 2], p2: [f32; 2], color: [f32; 4]) {
        self.render_triangle_colors(p0, p1, p2, color, color, color);
    }

    /// `DefaultFBOMultisampleCase::renderQuad(Vec2 x4, Vec4 x4)`
    fn render_quad_colors(&self, p: [[f32; 2]; 4], c: [[f32; 4]; 4]) {
        self.render_triangle_colors(p[0], p[1], p[2], c[0], c[1], c[2]);
        self.render_triangle_colors(p[2], p[1], p[3], c[2], c[1], c[3]);
    }

    /// `DefaultFBOMultisampleCase::renderQuad(Vec2 x4, Vec4)` - single colour.
    fn render_quad(&self, p: [[f32; 2]; 4], color: [f32; 4]) {
        self.render_quad_colors(p, [color, color, color, color]);
    }

    /// `DefaultFBOMultisampleCase::readImage`
    fn read_image(&self, context: &Context, dst: &mut Surface) -> Result<(), TestError> {
        crate::glu::read_pixels(
            &context.render_context,
            self.viewport_x,
            self.viewport_y,
            &mut dst.get_access(),
        )
    }
}

/// `MaskInvertCase::drawPattern`
fn draw_mask_invert_pattern(harness: &MultisampleHarness, invert: bool) {
    const NUM_TRIANGLES: i32 = 25;
    let word_count = get_effective_sample_mask_word_count(harness.num_samples - 1);
    let final_word_bits = harness.num_samples - 32 * ((harness.num_samples - 1) / 32);
    let final_word_mask = de_bit_mask32(0, final_word_bits);

    for tri_ndx in 0..NUM_TRIANGLES {
        let angle0 = 2.0 * std::f32::consts::PI * tri_ndx as f32 / NUM_TRIANGLES as f32;
        let angle1 = 2.0 * std::f32::consts::PI * (tri_ndx as f32 + 0.5) / NUM_TRIANGLES as f32;
        let t = tri_ndx as f32 / NUM_TRIANGLES as f32;
        let color = [0.4 + t * 0.6, 0.5 + t * 0.3, 0.6 - t * 0.5, 0.7 - t * 0.7];

        for word_ndx in 0..word_count {
            let raw_mask = de_uint32_hash((word_ndx * 32 + tri_ndx) as u32);
            let mask = if invert { !raw_mask } else { raw_mask };
            let is_final_word = word_ndx + 1 == word_count;
            let mask_mask: GLbitfield = if is_final_word { final_word_mask } else { 0xFFFF_FFFF };
            // SAFETY: takes plain integers only.
            unsafe { harness.gl.sample_maski(word_ndx as GLuint, mask & mask_mask) };
        }

        harness.render_triangle(
            [0.0, 0.0],
            [angle0.cos() * 0.95, angle0.sin() * 0.95],
            [angle1.cos() * 0.95, angle1.sin() * 0.95],
            color,
        );
    }
}

/// `MaskInvertCase`
struct MaskInvertCase;

impl TestCase for MaskInvertCase {
    fn name(&self) -> &str {
        "sample_mask_sum_of_inverses"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut harness = MultisampleHarness::new(context, self.name(), 256)?;

        let mut max_sample_mask_words: i32 = 0;
        // SAFETY: one property is asked for and one GLint of output is given.
        unsafe {
            harness
                .gl
                .get_integerv(glw::GL_MAX_SAMPLE_MASK_WORDS, &mut max_sample_mask_words)
        };
        if get_effective_sample_mask_word_count(harness.num_samples - 1) > max_sample_mask_words {
            return Err(TestError::NotSupported(
                "Test requires larger GL_MAX_SAMPLE_MASK_WORDS".to_string(),
            ));
        }

        harness.randomize_viewport();

        // SAFETY: plain state.
        unsafe {
            harness.gl.enable(glw::GL_BLEND);
            harness.gl.blend_equation(glw::GL_FUNC_ADD);
            harness.gl.blend_func(glw::GL_ONE, glw::GL_ONE);

            harness.gl.clear_color(0.0, 0.0, 0.0, 0.0);
            harness.gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }
        draw_mask_invert_pattern(&harness, false);
        let mut no_sample_mask_img = Surface::new(harness.viewport_size, harness.viewport_size);
        harness.read_image(context, &mut no_sample_mask_img)?;

        // SAFETY: plain state.
        unsafe {
            harness.gl.clear(glw::GL_COLOR_BUFFER_BIT);
            harness.gl.enable(glw::GL_SAMPLE_MASK);
        }
        draw_mask_invert_pattern(&harness, false);
        draw_mask_invert_pattern(&harness, true);
        let mut sample_mask_img = Surface::new(harness.viewport_size, harness.viewport_size);
        harness.read_image(context, &mut sample_mask_img)?;

        let result = pixel_threshold_compare(&no_sample_mask_img, &sample_mask_img, RGBA::new(0, 0, 0, 0));
        Ok(if result.ok {
            TestStatus::pass("Passed")
        } else {
            TestStatus::fail("Failed")
        })
    }
}

/// `MaskProportionalityCase`
struct MaskProportionalityCase;

impl TestCase for MaskProportionalityCase {
    fn name(&self) -> &str {
        "proportionality_sample_mask"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut harness = MultisampleHarness::new(context, self.name(), 32)?;

        let mut max_sample_mask_words: i32 = 0;
        // SAFETY: one property is asked for and one GLint of output is given.
        unsafe {
            harness
                .gl
                .get_integerv(glw::GL_MAX_SAMPLE_MASK_WORDS, &mut max_sample_mask_words)
        };
        if get_effective_sample_mask_word_count(harness.num_samples - 1) > max_sample_mask_words {
            return Err(TestError::NotSupported(
                "Test requires larger GL_MAX_SAMPLE_MASK_WORDS".to_string(),
            ));
        }

        // SAFETY: plain state.
        unsafe { harness.gl.enable(glw::GL_SAMPLE_MASK) };

        let num_iterations = harness.num_samples + 1;
        // \note Using the same viewport for every iteration since coverage mask may
        // depend on window-relative pixel coordinate.
        harness.randomize_viewport();

        let mut previous_iteration_color_sum: i64 = -1;
        let word_count = get_effective_sample_mask_word_count(harness.num_samples - 1);

        for current_iteration in 0..num_iterations {
            let num_pixels = harness.viewport_size as i64 * harness.viewport_size as i64;

            // SAFETY: plain state.
            unsafe {
                harness.gl.color_mask(glw::TRUE, glw::TRUE, glw::TRUE, glw::TRUE);
                harness.gl.clear_color(0.0, 0.0, 0.0, 1.0);
                harness.gl.clear(glw::GL_COLOR_BUFFER_BIT);
            }

            let sample_mask = gen_all_set_to_nth_bit_sample_mask(current_iteration);
            for word_ndx in 0..word_count {
                let mask = sample_mask.get(word_ndx as usize).copied().unwrap_or(0);
                // SAFETY: takes plain integers only.
                unsafe { harness.gl.sample_maski(word_ndx as GLuint, mask) };
            }

            harness.render_quad(
                [[-1.0, -1.0], [1.0, -1.0], [-1.0, 1.0], [1.0, 1.0]],
                [1.0, 0.0, 0.0, 1.0],
            );

            let mut rendered_img = Surface::new(harness.viewport_size, harness.viewport_size);
            harness.read_image(context, &mut rendered_img)?;

            let mut sum_red: i64 = 0;
            for y in 0..rendered_img.get_height() {
                for x in 0..rendered_img.get_width() {
                    sum_red += rendered_img.get_pixel(x, y).get_red() as i64;
                }
            }

            if sum_red < previous_iteration_color_sum {
                return Ok(TestStatus::fail("Failed"));
            }
            if current_iteration == 0 && sum_red != 0 {
                return Ok(TestStatus::fail("Failed"));
            }
            if current_iteration == num_iterations - 1 && sum_red != 0xff * num_pixels {
                return Ok(TestStatus::fail("Failed"));
            }

            previous_iteration_color_sum = sum_red;
        }

        Ok(TestStatus::pass("Passed"))
    }
}

/// `MaskConstancyCase::CaseBits` - this file only ever constructs a case with
/// `CASEBIT_SAMPLE_MASK` set (`DE_ASSERT(m_isSampleMaskCase)` upstream - the non-sample-mask
/// combinations are already covered by gles2/gles3's own `MaskConstancyCase`), so that bit
/// is not a field here at all; the other three still vary per case.
struct MaskConstancyCase {
    name: &'static str,
    is_alpha_to_coverage: bool,
    is_sample_coverage: bool,
    is_inverted_sample_coverage: bool,
}

impl TestCase for MaskConstancyCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut harness = MultisampleHarness::new(context, self.name, 256)?;

        let mut max_sample_mask_words: i32 = 0;
        // SAFETY: one property is asked for and one GLint of output is given.
        unsafe {
            harness
                .gl
                .get_integerv(glw::GL_MAX_SAMPLE_MASK_WORDS, &mut max_sample_mask_words)
        };
        if get_effective_sample_mask_word_count(harness.num_samples - 1) > max_sample_mask_words {
            return Err(TestError::NotSupported(
                "Test requires larger GL_MAX_SAMPLE_MASK_WORDS".to_string(),
            ));
        }

        harness.randomize_viewport();

        // SAFETY: plain state.
        unsafe {
            harness.gl.clear_color(0.0, 0.0, 0.0, 1.0);
            harness.gl.clear(glw::GL_COLOR_BUFFER_BIT);

            if self.is_alpha_to_coverage {
                harness.gl.enable(glw::GL_SAMPLE_ALPHA_TO_COVERAGE);
                harness.gl.color_mask(glw::TRUE, glw::TRUE, glw::TRUE, glw::FALSE);
            }
            if self.is_sample_coverage {
                harness.gl.enable(glw::GL_SAMPLE_COVERAGE);
            }
            harness.gl.enable(glw::GL_SAMPLE_MASK);
        }

        let num_quad_rows_cols = harness.num_samples * 4;
        let word_count = get_effective_sample_mask_word_count(harness.num_samples - 1);
        let final_word_bits = harness.num_samples - 32 * ((harness.num_samples - 1) / 32);
        let final_word_mask = de_bit_mask32(0, final_word_bits);

        for row in 0..num_quad_rows_cols {
            for col in 0..num_quad_rows_cols {
                let x0 = col as f32 / num_quad_rows_cols as f32 * 2.0 - 1.0;
                let x1 = (col + 1) as f32 / num_quad_rows_cols as f32 * 2.0 - 1.0;
                let y0 = row as f32 / num_quad_rows_cols as f32 * 2.0 - 1.0;
                let y1 = (row + 1) as f32 / num_quad_rows_cols as f32 * 2.0 - 1.0;

                let base_green = [0.0, 1.0, 0.0, 0.0];
                let base_red = [1.0, 0.0, 0.0, 0.0];
                let alpha0_w = if self.is_alpha_to_coverage {
                    col as f32 / (num_quad_rows_cols - 1) as f32
                } else {
                    1.0
                };
                let alpha1_w = if self.is_alpha_to_coverage {
                    row as f32 / (num_quad_rows_cols - 1) as f32
                } else {
                    1.0
                };
                let alpha0 = [0.0, 0.0, 0.0, alpha0_w];
                let alpha1 = [0.0, 0.0, 0.0, alpha1_w];

                if self.is_sample_coverage {
                    let value =
                        (row * num_quad_rows_cols + col) as f32 / (num_quad_rows_cols * num_quad_rows_cols - 1) as f32;
                    let coverage = if self.is_inverted_sample_coverage {
                        1.0 - value
                    } else {
                        value
                    };
                    // SAFETY: takes plain floats/an enum-like boolean.
                    unsafe {
                        harness.gl.sample_coverage(
                            coverage,
                            if self.is_inverted_sample_coverage {
                                glw::TRUE
                            } else {
                                glw::FALSE
                            },
                        )
                    };
                }

                for word_ndx in 0..word_count {
                    let mask = de_uint32_hash(((col << (harness.num_samples / 2)) ^ row) as u32);
                    let is_final_word = word_ndx + 1 == word_count;
                    let mask_mask: GLbitfield = if is_final_word { final_word_mask } else { 0xFFFF_FFFF };
                    // SAFETY: takes plain integers only.
                    unsafe { harness.gl.sample_maski(word_ndx as GLuint, mask & mask_mask) };
                }

                let add = |a: [f32; 4], b: [f32; 4]| [a[0] + b[0], a[1] + b[1], a[2] + b[2], a[3] + b[3]];
                let quad_p = [[x0, y0], [x1, y0], [x0, y1], [x1, y1]];
                harness.render_quad_colors(
                    quad_p,
                    [
                        add(base_green, alpha0),
                        add(base_green, alpha1),
                        add(base_green, alpha0),
                        add(base_green, alpha1),
                    ],
                );
                harness.render_quad_colors(
                    quad_p,
                    [
                        add(base_red, alpha0),
                        add(base_red, alpha1),
                        add(base_red, alpha0),
                        add(base_red, alpha1),
                    ],
                );
            }
        }

        let mut rendered_img = Surface::new(harness.viewport_size, harness.viewport_size);
        harness.read_image(context, &mut rendered_img)?;

        for y in 0..rendered_img.get_height() {
            for x in 0..rendered_img.get_width() {
                if rendered_img.get_pixel(x, y).get_green() > 0 {
                    return Ok(TestStatus::fail("Failed"));
                }
            }
        }

        Ok(TestStatus::pass("Passed"))
    }
}

/// `SampleMaskHighBitsCase`
struct SampleMaskHighBitsCase;

impl TestCase for SampleMaskHighBitsCase {
    fn name(&self) -> &str {
        "sample_mask_non_effective_bits"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut harness = MultisampleHarness::new(context, self.name(), 256)?;

        let mut max_sample_mask_words: i32 = 0;
        // SAFETY: one property is asked for and one GLint of output is given.
        unsafe {
            harness
                .gl
                .get_integerv(glw::GL_MAX_SAMPLE_MASK_WORDS, &mut max_sample_mask_words)
        };
        if get_effective_sample_mask_word_count(harness.num_samples - 1) > max_sample_mask_words {
            return Err(TestError::NotSupported(
                "Test requires larger GL_MAX_SAMPLE_MASK_WORDS".to_string(),
            ));
        }

        let mut rnd = Random::new(12345);

        if harness.num_samples % 32 == 0 {
            // Sample count is a multiple of the word size - no unused high bits in the
            // sample mask exist to test.
            return Ok(TestStatus::pass("Skipped"));
        }

        harness.randomize_viewport();

        // SAFETY: plain state.
        unsafe {
            harness.gl.clear_color(0.0, 0.0, 0.0, 1.0);
            harness.gl.clear(glw::GL_COLOR_BUFFER_BIT);
            harness.gl.enable(glw::GL_SAMPLE_MASK);
        }

        let num_quad_rows_cols = harness.num_samples * 4;
        let word_count = get_effective_sample_mask_word_count(harness.num_samples - 1);
        let final_word_bits = harness.num_samples - 32 * ((harness.num_samples - 1) / 32);
        let final_word_mask = de_bit_mask32(0, final_word_bits);

        for row in 0..num_quad_rows_cols {
            for col in 0..num_quad_rows_cols {
                let x0 = col as f32 / num_quad_rows_cols as f32 * 2.0 - 1.0;
                let x1 = (col + 1) as f32 / num_quad_rows_cols as f32 * 2.0 - 1.0;
                let y0 = row as f32 / num_quad_rows_cols as f32 * 2.0 - 1.0;
                let y1 = (row + 1) as f32 / num_quad_rows_cols as f32 * 2.0 - 1.0;
                let base_green = [0.0, 1.0, 0.0, 1.0];
                let base_red = [1.0, 0.0, 0.0, 1.0];
                let quad_p = [[x0, y0], [x1, y0], [x0, y1], [x1, y1]];

                for word_ndx in 0..word_count {
                    let mask = de_uint32_hash(((col << (harness.num_samples / 2)) ^ row) as u32);
                    let is_final_word = word_ndx + 1 == word_count;
                    let mask_mask: GLbitfield = if is_final_word { final_word_mask } else { 0xFFFF_FFFF };
                    let high_bits = rnd.get_uint32();
                    // SAFETY: takes plain integers only.
                    unsafe {
                        harness
                            .gl
                            .sample_maski(word_ndx as GLuint, (mask & mask_mask) | (high_bits & !mask_mask))
                    };
                }
                harness.render_quad(quad_p, base_green);

                for word_ndx in 0..word_count {
                    let mask = de_uint32_hash(((col << (harness.num_samples / 2)) ^ row) as u32);
                    let is_final_word = word_ndx + 1 == word_count;
                    let mask_mask: GLbitfield = if is_final_word { final_word_mask } else { 0xFFFF_FFFF };
                    let high_bits = rnd.get_uint32();
                    // SAFETY: takes plain integers only.
                    unsafe {
                        harness
                            .gl
                            .sample_maski(word_ndx as GLuint, (mask & mask_mask) | (high_bits & !mask_mask))
                    };
                }
                harness.render_quad(quad_p, base_red);
            }
        }

        let mut rendered_img = Surface::new(harness.viewport_size, harness.viewport_size);
        harness.read_image(context, &mut rendered_img)?;

        for y in 0..rendered_img.get_height() {
            for x in 0..rendered_img.get_width() {
                if rendered_img.get_pixel(x, y).get_green() > 0 {
                    return Ok(TestStatus::fail("Unused mask bits modified mask"));
                }
            }
        }

        Ok(TestStatus::pass("Passed"))
    }
}

/// `MultisampleTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("multisample");
    let mut default_framebuffer = TestCaseGroup::new("default_framebuffer");

    default_framebuffer.add_child(Box::new(SamplePosQueryCase) as Box<dyn TestCase>);
    default_framebuffer.add_child(Box::new(MaskInvertCase) as Box<dyn TestCase>);
    default_framebuffer.add_child(Box::new(MaskProportionalityCase) as Box<dyn TestCase>);
    default_framebuffer.add_child(Box::new(MaskConstancyCase {
        name: "constancy_sample_mask",
        is_alpha_to_coverage: false,
        is_sample_coverage: false,
        is_inverted_sample_coverage: false,
    }) as Box<dyn TestCase>);
    default_framebuffer.add_child(Box::new(MaskConstancyCase {
        name: "constancy_alpha_to_coverage_sample_mask",
        is_alpha_to_coverage: true,
        is_sample_coverage: false,
        is_inverted_sample_coverage: false,
    }) as Box<dyn TestCase>);
    default_framebuffer.add_child(Box::new(MaskConstancyCase {
        name: "constancy_sample_coverage_sample_mask",
        is_alpha_to_coverage: false,
        is_sample_coverage: true,
        is_inverted_sample_coverage: false,
    }) as Box<dyn TestCase>);
    default_framebuffer.add_child(Box::new(MaskConstancyCase {
        name: "constancy_alpha_to_coverage_sample_coverage_sample_mask",
        is_alpha_to_coverage: true,
        is_sample_coverage: true,
        is_inverted_sample_coverage: false,
    }) as Box<dyn TestCase>);
    default_framebuffer.add_child(Box::new(SampleMaskHighBitsCase) as Box<dyn TestCase>);

    group.add_child(default_framebuffer);
    group
}
