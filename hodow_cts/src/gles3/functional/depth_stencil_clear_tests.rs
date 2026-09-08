// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fDepthStencilClearTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `iterate` returns
// CONTINUE and is re-entered per iteration; here the iteration is a loop inside
// `iterate`. The visualisation program upstream builds in `init` is built once at the
// top of `iterate` instead, because a `TestCase` here is immutable and has no `init`
// phase - the GL calls, their order and the shaders are unchanged.
//
// Upstream keeps a separate, near-identical copy of this file per API module; this
// port does the same rather than sharing the ES 2.0 one, so that a re-sync that
// changes only one of them shows up as a difference here too.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::image_compare::pixel_threshold_compare;
use crate::tcu::pixel::{TextureLevel, clear};
use crate::tcu::random::{de_int32_hash, de_string_hash};
use crate::tcu::rgba::RGBA;
use crate::tcu::{ChannelOrder, ChannelType, IVec4, Random, Surface, TestError, TestOutcome, TestStatus, TextureFormat};

const STENCIL_STEPS: i32 = 32;
const DEPTH_STEPS: i32 = 32;

#[derive(Clone, Copy)]
struct Clear {
    clear_mask: u32,
    clear_depth: f32,
    clear_stencil: i32,

    use_scissor: bool,
    scissor: IVec4,

    depth_mask: bool,
    stencil_mask: u32,
}

/// `Clear::Clear` - upstream's default constructor, which every generated clear
/// overwrites field by field.
impl Default for Clear {
    fn default() -> Self {
        Self {
            clear_mask: 0,
            clear_depth: 0.0,
            clear_stencil: 0,
            use_scissor: false,
            scissor: IVec4::new(0, 0, 0, 0),
            depth_mask: false,
            stencil_mask: 0,
        }
    }
}

fn get_depth_format(depth_bits: i32) -> Result<TextureFormat, TestError> {
    match depth_bits {
        8 => Ok(TextureFormat::new(ChannelOrder::D, ChannelType::UNORM_INT8)),
        16 => Ok(TextureFormat::new(ChannelOrder::D, ChannelType::UNORM_INT16)),
        24 => Ok(TextureFormat::new(ChannelOrder::D, ChannelType::UNORM_INT24)),
        32 => Ok(TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT)),
        _ => Err(TestError::Fail("Can't map depth buffer format".to_string())),
    }
}

fn get_stencil_format(stencil_bits: i32) -> Result<TextureFormat, TestError> {
    match stencil_bits {
        8 => Ok(TextureFormat::new(ChannelOrder::S, ChannelType::UNSIGNED_INT8)),
        16 => Ok(TextureFormat::new(ChannelOrder::S, ChannelType::UNSIGNED_INT16)),
        24 => Ok(TextureFormat::new(ChannelOrder::S, ChannelType::UNSIGNED_INT24)),
        32 => Ok(TextureFormat::new(ChannelOrder::S, ChannelType::UNSIGNED_INT32)),
        _ => Err(TestError::Fail("Can't map depth buffer format".to_string())),
    }
}

/// `de::inBounds`
fn in_bounds(value: i32, low: i32, high: i32) -> bool {
    value >= low && value < high
}

#[derive(Clone, Copy)]
struct DepthStencilClearCase {
    name: &'static str,
    num_iters: i32,
    num_clears: i32,
    test_depth: bool,
    test_stencil: bool,
    test_scissor: bool,
    masked: bool,
}

impl DepthStencilClearCase {
    /// `DepthStencilClearCase::generateClears`
    fn generate_clears(&self, context: &Context, seed: u32) -> Vec<Clear> {
        let render_target = context.render_target();
        let width = render_target.width;
        let height = render_target.height;
        let mut rnd = Random::new(seed);

        let mut clears = vec![Clear::default(); self.num_clears as usize];

        for clear in &mut clears {
            if self.test_scissor {
                let w = rnd.get_int(1, width);
                let h = rnd.get_int(1, height);
                let x = rnd.get_int(0, width - w);
                let y = rnd.get_int(0, height - h);

                clear.use_scissor = true; // \todo [pyry] Should we randomize?
                clear.scissor = IVec4::new(x, y, w, h);
            } else {
                clear.use_scissor = false;
            }

            clear.clear_depth = rnd.get_float_range(-0.2, 1.2);
            clear.clear_stencil = rnd.get_uint32() as i32;

            clear.depth_mask = if self.masked { rnd.get_bool() } else { true };
            clear.stencil_mask = if self.masked { rnd.get_uint32() } else { 0xffffffff };

            if self.test_depth && self.test_stencil {
                clear.clear_mask = match rnd.get_int(0, 2) {
                    0 => glw::GL_DEPTH_BUFFER_BIT,
                    1 => glw::GL_STENCIL_BUFFER_BIT,
                    _ => glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT,
                };
            } else if self.test_depth {
                clear.clear_mask = glw::GL_DEPTH_BUFFER_BIT;
            } else {
                debug_assert!(self.test_stencil);
                clear.clear_mask = glw::GL_STENCIL_BUFFER_BIT;
            }
        }

        clears
    }

    /// `DepthStencilClearCase::renderGL`
    fn render_gl(&self, context: &Context, vis_program: &ShaderProgram<'_>, dst: &mut Surface, clears: &[Clear]) -> Result<(), TestError> {
        let gl = context.gl();
        const INDICES: [u8; 6] = [0, 1, 2, 2, 1, 3];

        // SAFETY: every call below is an ES 2.0 state setter or a draw from a
        // client-side array that outlives the call, with a current context.
        unsafe {
            let color_loc = gl.get_uniform_location(vis_program.program(), c"u_color".as_ptr());
            let position_loc = gl.get_attrib_location(vis_program.program(), c"a_position".as_ptr());

            // Clear with default values.
            gl.clear_depthf(1.0);
            gl.clear_stencil(0);
            gl.clear_color(1.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

            glu::expect_no_error(gl, "Before clears")?;

            for clear in clears {
                if clear.use_scissor {
                    gl.enable(glw::GL_SCISSOR_TEST);
                    gl.scissor(clear.scissor.x(), clear.scissor.y(), clear.scissor.z(), clear.scissor.w());
                }

                // Clear values.
                gl.clear_depthf(clear.clear_depth);
                gl.clear_stencil(clear.clear_stencil);

                // Masks.
                gl.depth_mask(if clear.depth_mask { glw::TRUE } else { glw::FALSE });
                gl.stencil_mask(clear.stencil_mask);

                // Execute clear.
                gl.clear(clear.clear_mask);

                if clear.use_scissor {
                    gl.disable(glw::GL_SCISSOR_TEST);
                }
            }

            // Restore default masks.
            gl.depth_mask(glw::TRUE);
            gl.stencil_mask(0xffffffff);

            glu::expect_no_error(gl, "After clears")?;

            gl.use_program(vis_program.program());
            gl.enable_vertex_attrib_array(position_loc as u32);

            // Visualize depth / stencil buffers.
            if self.test_depth {
                let num_steps = DEPTH_STEPS;
                let step = 2.0 / num_steps as f32;

                gl.enable(glw::GL_DEPTH_TEST);
                gl.depth_func(glw::GL_LESS);
                gl.depth_mask(glw::FALSE);
                gl.color_mask(glw::FALSE, glw::FALSE, glw::TRUE, glw::FALSE);

                for ndx in 0..num_steps {
                    let d = -1.0 + step * ndx as f32;
                    let c = ndx as f32 / (num_steps - 1) as f32;
                    let pos: [f32; 12] = [-1.0, -1.0, d, -1.0, 1.0, d, 1.0, -1.0, d, 1.0, 1.0, d];

                    gl.uniform_4f(color_loc, 0.0, 0.0, c, 1.0);
                    gl.vertex_attrib_pointer(position_loc as u32, 3, glw::GL_FLOAT, glw::FALSE, 0, pos.as_ptr().cast());
                    gl.draw_elements(glw::GL_TRIANGLES, INDICES.len() as i32, glw::GL_UNSIGNED_BYTE, INDICES.as_ptr().cast());
                }

                gl.disable(glw::GL_DEPTH_TEST);
                gl.depth_mask(glw::TRUE);

                glu::expect_no_error(gl, "After depth visualization")?;
            }

            if self.test_stencil {
                let num_steps = STENCIL_STEPS;
                let num_values = 1 << context.render_target().stencil_bits; // 2^bits
                let step = num_values / num_steps;

                gl.enable(glw::GL_STENCIL_TEST);
                gl.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_KEEP);
                gl.color_mask(glw::FALSE, glw::TRUE, glw::FALSE, glw::FALSE);

                const POS: [f32; 8] = [-1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0];
                gl.vertex_attrib_pointer(position_loc as u32, 2, glw::GL_FLOAT, glw::FALSE, 0, POS.as_ptr().cast());

                for ndx in 0..num_steps {
                    let s = step * ndx;
                    let c = ndx as f32 / (num_steps - 1) as f32;

                    gl.stencil_func(glw::GL_LEQUAL, s, 0xff);
                    gl.uniform_4f(color_loc, 0.0, c, 0.0, 1.0);
                    gl.draw_elements(glw::GL_TRIANGLES, INDICES.len() as i32, glw::GL_UNSIGNED_BYTE, INDICES.as_ptr().cast());
                }

                gl.disable(glw::GL_STENCIL_TEST);

                glu::expect_no_error(gl, "After stencil visualization")?;
            }

            // Restore color mask (changed by visualization).
            gl.color_mask(glw::TRUE, glw::TRUE, glw::TRUE, glw::TRUE);
        }

        glu::read_pixels(&context.render_context, 0, 0, &mut dst.get_access())
    }

    /// `DepthStencilClearCase::renderReference`
    fn render_reference(&self, context: &Context, dst: &mut Surface, clears: &[Clear]) -> Result<(), TestError> {
        let render_target = context.render_target();

        // Clear surface to red.
        clear(&mut dst.get_access(), RGBA::red().to_vec().m_data);

        if self.test_depth {
            // Simulated depth buffer span.
            let mut depth_buf_row = TextureLevel::new(get_depth_format(render_target.depth_bits)?, dst.get_width() as u32, 1, 1)?;
            let mut row_access = depth_buf_row.get_access();

            for y in 0..dst.get_height() {
                // Clear to default value.
                for x in 0..row_access.size()[0] {
                    row_access.set_pixel([1.0; 4], x, 0, 0);
                }

                // Execute clears.
                for clear in clears {
                    // Clear / mask test.
                    if (clear.clear_mask & glw::GL_DEPTH_BUFFER_BIT) == 0 || !clear.depth_mask {
                        continue;
                    }

                    let clear_rect = if clear.use_scissor {
                        clear.scissor
                    } else {
                        IVec4::new(0, 0, dst.get_width(), dst.get_height())
                    };

                    // Intersection test.
                    if !in_bounds(y, clear_rect.y(), clear_rect.y() + clear_rect.w()) {
                        continue;
                    }

                    for x in clear_rect.x()..clear_rect.x() + clear_rect.z() {
                        row_access.set_pix_depth(clear.clear_depth.clamp(0.0, 1.0), x as u32, 0, 0);
                    }
                }

                // Map to colors.
                for x in 0..dst.get_width() {
                    let depth = row_access.get_pix_depth(x as u32, 0, 0);
                    let step = (depth * DEPTH_STEPS as f32).floor() / (DEPTH_STEPS - 1) as f32;
                    let old_color = dst.get_pixel(x, y);
                    let new_color = RGBA::new(old_color.get_red(), old_color.get_green(), round_to_int(step * 255.0).clamp(0, 255), old_color.get_alpha());

                    dst.set_pixel(x, y, new_color);
                }
            }
        }

        if self.test_stencil {
            // Simulated stencil buffer span.
            let stencil_bits = render_target.stencil_bits;
            let mut depth_buf_row = TextureLevel::new(get_stencil_format(stencil_bits)?, dst.get_width() as u32, 1, 1)?;
            let mut row_access = depth_buf_row.get_access();
            let buf_mask = (1u32 << stencil_bits) - 1;

            for y in 0..dst.get_height() {
                // Clear to default value.
                for x in 0..row_access.size()[0] {
                    row_access.set_pix_stencil(0, x, 0, 0);
                }

                // Execute clears.
                for clear in clears {
                    // Clear / mask test.
                    if (clear.clear_mask & glw::GL_STENCIL_BUFFER_BIT) == 0 || clear.stencil_mask == 0 {
                        continue;
                    }

                    let clear_rect = if clear.use_scissor {
                        clear.scissor
                    } else {
                        IVec4::new(0, 0, dst.get_width(), dst.get_height())
                    };

                    // Intersection test.
                    if !in_bounds(y, clear_rect.y(), clear_rect.y() + clear_rect.w()) {
                        continue;
                    }

                    for x in clear_rect.x()..clear_rect.x() + clear_rect.z() {
                        let old_val = row_access.get_pix_stencil(x as u32, 0, 0);
                        let new_val = ((old_val & !clear.stencil_mask) | (clear.clear_stencil as u32 & clear.stencil_mask)) & buf_mask;
                        row_access.set_pix_stencil(new_val, x as u32, 0, 0);
                    }
                }

                // Map to colors.
                for x in 0..dst.get_width() {
                    let stencil = row_access.get_pix_stencil(x as u32, 0, 0);
                    let step = (stencil / ((1u32 << stencil_bits) / STENCIL_STEPS as u32)) as f32 / (STENCIL_STEPS - 1) as f32;
                    let old_color = dst.get_pixel(x, y);
                    let new_color = RGBA::new(old_color.get_red(), round_to_int(step * 255.0).clamp(0, 255), old_color.get_blue(), old_color.get_alpha());

                    dst.set_pixel(x, y, new_color);
                }
            }
        }

        Ok(())
    }
}

/// `deRoundFloatToInt32` - round half away from zero, which is not what Rust's
/// `f32::round` does for a negative half but is what upstream's reference expects.
fn round_to_int(value: f32) -> i32 {
    (value + 0.5).floor() as i32
}

impl TestCase for DepthStencilClearCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let render_target = context.render_target();
        let width = render_target.width;
        let height = render_target.height;
        let threshold = render_target.pixel_format().get_color_threshold() + RGBA::new(1, 1, 1, 1);

        if (self.test_depth && render_target.depth_bits == 0) || (self.test_stencil && render_target.stencil_bits == 0) {
            return Err(TestError::NotSupported("No depth/stencil buffers".to_string()));
        }

        let vis_program = ShaderProgram::new(
            gl,
            &ProgramSources::vtx_frag(
                // Vertex shader.
                "#version 300 es\nin highp vec4 a_position;\nvoid main (void)\n{\n    gl_Position = a_position;\n}\n",
                // Fragment shader.
                "#version 300 es\nuniform mediump vec4 u_color;\nlayout(location = 0) out mediump vec4 o_color;\nvoid main (void)\n{\n    o_color = u_color;\n}\n",
            ),
        );

        if !vis_program.is_ok() {
            return Err(TestError::Fail("Compile failed".to_string()));
        }

        let mut result = TestStatus::pass("Pass");

        for cur_iter in 0..self.num_iters {
            let mut result_surface = Surface::new(width, height);
            let mut reference = Surface::new(width, height);

            let clears = self.generate_clears(context, de_string_hash(self.name) ^ de_int32_hash(cur_iter));
            self.render_gl(context, &vis_program, &mut result_surface, &clears)?;
            self.render_reference(context, &mut reference, &clears)?;

            let comparison = pixel_threshold_compare(&reference, &result_surface, threshold);

            if !comparison.ok {
                let d = comparison.max_diff.m_data;
                result = TestStatus::fail(format!(
                    "Image comparison failed: max difference = ({}, {}, {}, {}), threshold = {threshold}",
                    d[0], d[1], d[2], d[3]
                ));
                break;
            }
        }

        Ok(result)
    }
}

/// `DepthStencilClearTests::init`
pub fn create_tests() -> TestCaseGroup {
    //                                            name                              iters  clears  depth  stencil  scissor  masked
    #[rustfmt::skip]
    const CASES: &[DepthStencilClearCase] = &[
        DepthStencilClearCase { name: "depth",                          num_iters: 4, num_clears: 2,  test_depth: true,  test_stencil: false, test_scissor: false, masked: false },
        DepthStencilClearCase { name: "depth_scissored",                num_iters: 4, num_clears: 16, test_depth: true,  test_stencil: false, test_scissor: true,  masked: false },
        DepthStencilClearCase { name: "depth_scissored_masked",         num_iters: 4, num_clears: 16, test_depth: true,  test_stencil: false, test_scissor: true,  masked: true  },

        DepthStencilClearCase { name: "stencil",                        num_iters: 4, num_clears: 2,  test_depth: false, test_stencil: true,  test_scissor: false, masked: false },
        DepthStencilClearCase { name: "stencil_masked",                 num_iters: 4, num_clears: 8,  test_depth: false, test_stencil: true,  test_scissor: false, masked: true  },
        DepthStencilClearCase { name: "stencil_scissored",              num_iters: 4, num_clears: 16, test_depth: false, test_stencil: true,  test_scissor: true,  masked: false },
        DepthStencilClearCase { name: "stencil_scissored_masked",       num_iters: 4, num_clears: 16, test_depth: false, test_stencil: true,  test_scissor: true,  masked: true  },

        DepthStencilClearCase { name: "depth_stencil",                  num_iters: 4, num_clears: 2,  test_depth: true,  test_stencil: true,  test_scissor: false, masked: false },
        DepthStencilClearCase { name: "depth_stencil_masked",           num_iters: 4, num_clears: 8,  test_depth: true,  test_stencil: true,  test_scissor: false, masked: true  },
        DepthStencilClearCase { name: "depth_stencil_scissored",        num_iters: 4, num_clears: 16, test_depth: true,  test_stencil: true,  test_scissor: true,  masked: false },
        DepthStencilClearCase { name: "depth_stencil_scissored_masked", num_iters: 4, num_clears: 16, test_depth: true,  test_stencil: true,  test_scissor: true,  masked: true  },
    ];

    let mut group = TestCaseGroup::new("depth_stencil_clear");
    for case in CASES {
        group.add_child(Box::new(*case) as Box<dyn TestCase>);
    }
    group
}
