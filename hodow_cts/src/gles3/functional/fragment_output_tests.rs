// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFragmentOutputTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// This group needs no reference rasteriser even though it draws: the geometry is a grid
// of quads whose vertices carry the values under test, and `render_*_reference` walks
// the same grid on the host and interpolates the same way. What is under test is the
// fragment-output plumbing - the conversion into each attachment's format - not the
// rasterisation.
//
// `FboTestUtil::getFormatName` is not ported: it is the lowercased `GL_*` enum name,
// which `glu::texture_format_name` already answers, the same way `gls::fboc` builds its
// case names.

use crate::glu::{self, Context, DataType, Precision, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLuint};
use crate::tcu::image_compare::{float_threshold_compare, float_ulp_threshold_compare, int_threshold_compare};
use crate::tcu::pixel::{
    ConstPixelBufferAccess, PixelBufferAccess, get_texture_format_bit_depth, get_texture_format_info, linear_to_srgb,
};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureChannelClass, TextureFormat};
use crate::tcu::{Random, TestError, TestOutcome, TestStatus, UVec4};

/// `BufferSpec`
#[derive(Clone, Copy)]
struct BufferSpec {
    format: GLenum,
    width: i32,
    height: i32,
    samples: i32,
}

/// `FragmentOutput`
#[derive(Clone, Copy)]
struct FragmentOutput {
    ty: DataType,
    precision: Precision,
    location: i32,
    /// 0 if not an array.
    array_length: i32,
}

impl FragmentOutput {
    fn new(ty: DataType, precision: Precision, location: i32) -> Self {
        Self {
            ty,
            precision,
            location,
            array_length: 0,
        }
    }

    fn array(ty: DataType, precision: Precision, location: i32, array_length: i32) -> Self {
        Self {
            ty,
            precision,
            location,
            array_length,
        }
    }

    fn num_vecs(&self) -> i32 {
        if self.array_length > 0 { self.array_length } else { 1 }
    }
}

/// `createProgram`
fn create_program_sources(outputs: &[FragmentOutput]) -> ProgramSources {
    let mut vtx = String::from("#version 300 es\nin highp vec4 a_position;\n");
    let mut frag = String::from("#version 300 es\n");

    // Input-output declarations.
    for (out_ndx, output) in outputs.iter().enumerate() {
        let is_array = output.array_length > 0;
        let type_name = output.ty.name();
        let output_prec = output.precision.name();
        let is_float = output.ty.is_float_or_vec();
        // An integer varying cannot be interpolated, and a float one is interpolated at
        // highp so the comparison threshold does not have to allow for the varying's own
        // precision on top of the output's.
        let interp = if is_float { "smooth" } else { "flat" };
        let interp_prec = if is_float { "highp" } else { output_prec };

        if is_array {
            for elem_ndx in 0..output.array_length {
                vtx.push_str(&format!(
                    "in {interp_prec} {type_name} in{out_ndx}_{elem_ndx};\n{interp} out {interp_prec} {type_name} var{out_ndx}_{elem_ndx};\n"
                ));
                frag.push_str(&format!(
                    "{interp} in {interp_prec} {type_name} var{out_ndx}_{elem_ndx};\n"
                ));
            }
            frag.push_str(&format!(
                "layout(location = {}) out {output_prec} {type_name} out{out_ndx}[{}];\n",
                output.location, output.array_length
            ));
        } else {
            vtx.push_str(&format!(
                "in {interp_prec} {type_name} in{out_ndx};\n{interp} out {interp_prec} {type_name} var{out_ndx};\n"
            ));
            frag.push_str(&format!(
                "{interp} in {interp_prec} {type_name} var{out_ndx};\nlayout(location = {}) out {output_prec} {type_name} out{out_ndx};\n",
                output.location
            ));
        }
    }

    vtx.push_str("\nvoid main()\n{\n    gl_Position = a_position;\n");
    frag.push_str("\nvoid main()\n{\n");

    // Copy body.
    for (out_ndx, output) in outputs.iter().enumerate() {
        if output.array_length > 0 {
            for elem_ndx in 0..output.array_length {
                vtx.push_str(&format!("\tvar{out_ndx}_{elem_ndx} = in{out_ndx}_{elem_ndx};\n"));
                frag.push_str(&format!("\tout{out_ndx}[{elem_ndx}] = var{out_ndx}_{elem_ndx};\n"));
            }
        } else {
            vtx.push_str(&format!("\tvar{out_ndx} = in{out_ndx};\n"));
            frag.push_str(&format!("\tout{out_ndx} = var{out_ndx};\n"));
        }
    }

    vtx.push_str("}\n");
    frag.push_str("}\n");

    ProgramSources::vtx_frag(vtx, frag)
}

/// `getFloatRange` - not quite the full ranges, as upstream notes.
fn float_range(precision: Precision) -> (f32, f32) {
    match precision {
        Precision::LowP => (-2.0, 2.0),
        Precision::MediumP => (-16000.0, 16000.0),
        Precision::HighP => (-1e35, 1e35),
    }
}

/// `getIntRange`
fn int_range(precision: Precision) -> (i32, i32) {
    match precision {
        Precision::LowP => (-(1 << 7), (1 << 7) - 1),
        Precision::MediumP => (-(1 << 15), (1 << 15) - 1),
        Precision::HighP => (i32::MIN, i32::MAX),
    }
}

/// `getUintRange`
fn uint_range(precision: Precision) -> (u32, u32) {
    match precision {
        Precision::LowP => (0, (1 << 8) - 1),
        Precision::MediumP => (0, (1 << 16) - 1),
        Precision::HighP => (0, u32::MAX),
    }
}

/// `s_swizzles`
const SWIZZLES: [[usize; 4]; 8] = [
    [0, 1, 2, 3],
    [1, 2, 3, 0],
    [2, 3, 0, 1],
    [3, 0, 1, 2],
    [3, 2, 1, 0],
    [2, 1, 0, 3],
    [1, 0, 3, 2],
    [0, 3, 2, 1],
];

/// `swizzleVec`
fn swizzle_vec<T: Copy>(vec: [T; 4], swz_ndx: usize) -> [T; 4] {
    let swz = SWIZZLES[swz_ndx % SWIZZLES.len()];
    [vec[swz[0]], vec[swz[1]], vec[swz[2]], vec[swz[3]]]
}

/// `readVec4`, on a flat scalar run.
fn read_vec4(values: &[f32], base: usize, num_components: usize) -> [f32; 4] {
    std::array::from_fn(|i| if i < num_components { values[base + i] } else { 0.0 })
}

fn read_ivec4(values: &[i32], base: usize, num_components: usize) -> [i32; 4] {
    std::array::from_fn(|i| if i < num_components { values[base + i] } else { 0 })
}

/// `renderFloatReference` - the same barycentric interpolation the rasteriser does over
/// this grid, which is only well defined because every quad is split the same way the
/// index list splits it.
fn render_float_reference(
    dst: &mut PixelBufferAccess<'_>,
    grid_width: i32,
    grid_height: i32,
    num_components: i32,
    vertices: &[f32],
) {
    let is_srgb = dst.format().order.is_srgb();
    let [width, height, _] = dst.size();
    let cell_w = width as f32 / (grid_width - 1) as f32;
    let cell_h = height as f32 / (grid_height - 1) as f32;
    let nc = num_components as usize;

    for y in 0..height {
        for x in 0..width {
            let cell_x = ((x as f32 / cell_w).floor() as i32).clamp(0, grid_width - 2);
            let cell_y = ((y as f32 / cell_h).floor() as i32).clamp(0, grid_height - 2);
            let xf = (x as f32 - cell_x as f32 * cell_w + 0.5) / cell_w;
            let yf = (y as f32 - cell_y as f32 * cell_h + 0.5) / cell_h;

            let at = |cy: i32, cx: i32| ((cy * grid_width + cx) as usize) * nc;
            let v00 = read_vec4(vertices, at(cell_y, cell_x), nc);
            let v01 = read_vec4(vertices, at(cell_y + 1, cell_x), nc);
            let v10 = read_vec4(vertices, at(cell_y, cell_x + 1), nc);
            let v11 = read_vec4(vertices, at(cell_y + 1, cell_x + 1), nc);

            let tri = xf + yf >= 1.0;
            let (v0, v1, v2) = if tri { (v11, v01, v10) } else { (v00, v10, v01) };
            let s = if tri { 1.0 - xf } else { xf };
            let t = if tri { 1.0 - yf } else { yf };

            let color: [f32; 4] = std::array::from_fn(|i| v0[i] + (v1[i] - v0[i]) * s + (v2[i] - v0[i]) * t);
            dst.set_pixel(if is_srgb { linear_to_srgb(color) } else { color }, x, y, 0);
        }
    }
}

/// `renderIntReference` - flat-shaded, so the value is the one the provoking vertex of
/// the cell carries.
fn render_int_reference(
    dst: &mut PixelBufferAccess<'_>,
    grid_width: i32,
    grid_height: i32,
    num_components: i32,
    vertices: &[i32],
) -> bool {
    let [width, height, _] = dst.size();
    let cell_w = width as f32 / (grid_width - 1) as f32;
    let cell_h = height as f32 / (grid_height - 1) as f32;
    let nc = num_components as usize;
    let mut ok = true;

    for y in 0..height {
        for x in 0..width {
            let cell_x = ((x as f32 / cell_w).floor() as i32).clamp(0, grid_width - 2);
            let cell_y = ((y as f32 / cell_h).floor() as i32).clamp(0, grid_height - 2);
            let c = read_ivec4(vertices, ((cell_y * grid_width + cell_x + 1) as usize) * nc, nc);
            ok &= dst.set_pixel_int(c, x, y, 0);
        }
    }

    ok
}

/// `getFramebufferReadFormat` - `glReadPixels` reads a colour attachment through one of
/// four canonical formats, whatever the attachment's own is.
fn framebuffer_read_format(format: TextureFormat) -> TextureFormat {
    let type_ = match format.type_.channel_class() {
        TextureChannelClass::FloatingPoint => ChannelType::FLOAT,
        TextureChannelClass::SignedFixedPoint | TextureChannelClass::UnsignedFixedPoint => ChannelType::UNORM_INT8,
        TextureChannelClass::UnsignedInteger => ChannelType::UNSIGNED_INT32,
        _ => ChannelType::SIGNED_INT32,
    };
    TextureFormat {
        order: ChannelOrder::RGBA,
        type_,
    }
}

/// `clearUndefined` - the channels the shader did not write hold whatever the driver
/// left there, so both sides are forced to the same value before comparing.
fn clear_undefined(access: &mut PixelBufferAccess<'_>, num_valid_channels: i32) -> bool {
    let [width, height, _] = access.size();
    let channel_class = access.format().type_.channel_class();
    let mut ok = true;

    for y in 0..height {
        for x in 0..width {
            match channel_class {
                TextureChannelClass::FloatingPoint => {
                    let src = access.as_const().get_pixel(x, y, 0);
                    let mut dst = [0.0, 0.0, 0.0, 1.0];
                    let valid = num_valid_channels as usize;
                    dst[..valid].copy_from_slice(&src[..valid]);
                    access.set_pixel(dst, x, y, 0);
                }
                _ => {
                    let bit_depth = get_texture_format_bit_depth(access.format());
                    let src = access.as_const().get_pixel_int(x, y, 0);
                    let mut dst = [0, 0, 0, ((1i64 << bit_depth[3]) - 1) as i32];
                    let valid = num_valid_channels as usize;
                    dst[..valid].copy_from_slice(&src[..valid]);
                    ok &= access.set_pixel_int(dst, x, y, 0);
                }
            }
        }
    }

    ok
}

/// `AttachmentData`
struct AttachmentData {
    /// Actual format of the attachment.
    format: TextureFormat,
    /// Used for reference rendering.
    reference_format: TextureFormat,
    read_format: TextureFormat,
    num_written_channels: i32,
    out_precision: Precision,
    rendered_data: Vec<u8>,
    reference_data: Vec<u8>,
}

/// `FragmentOutputCase`
struct FragmentOutputCase {
    name: String,
    fbo_spec: Vec<BufferSpec>,
    outputs: Vec<FragmentOutput>,
}

/// `deAlign32`
fn align32(value: i32, alignment: i32) -> i32 {
    (value + alignment - 1) / alignment * alignment
}

impl TestCase for FragmentOutputCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        // `FragmentOutputCase::init`'s first loop.
        for spec in &self.fbo_spec {
            if !glu::texture_util::is_sized_format_color_renderable(&context.context_info, spec.format) {
                return Err(TestError::NotSupported("Unsupported attachment format".to_string()));
            }
        }
        Ok(())
    }

    /// `FragmentOutputCase::init` followed by `iterate`.
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let program = ShaderProgram::new(gl, &create_program_sources(&self.outputs));
        if !program.is_ok() {
            return Err(TestError::Fail("Compile failed".to_string()));
        }

        // Create framebuffer.
        let framebuffer = glu::Framebuffer::new(gl);
        let renderbuffers: Vec<glu::Renderbuffer> =
            (0..self.fbo_spec.len()).map(|_| glu::Renderbuffer::new(gl)).collect();

        // SAFETY: each renderbuffer is this case's own, and each attachment point is
        // below GL_MAX_COLOR_ATTACHMENTS for every spec these cases build.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.get());

            for (buf_ndx, (rbo, spec)) in renderbuffers.iter().zip(&self.fbo_spec).enumerate() {
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo.get());
                gl.renderbuffer_storage_multisample(
                    glw::GL_RENDERBUFFER,
                    spec.samples,
                    spec.format,
                    spec.width,
                    spec.height,
                );
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0 + buf_ndx as GLenum,
                    glw::GL_RENDERBUFFER,
                    rbo.get(),
                );
            }
            glu::expect_no_error(gl, "After framebuffer setup")?;

            let fbo_status = gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
            if fbo_status == glw::GL_FRAMEBUFFER_UNSUPPORTED {
                return Err(TestError::NotSupported("Framebuffer not supported".to_string()));
            } else if fbo_status != glw::GL_FRAMEBUFFER_COMPLETE {
                return Err(TestError::Fail(format!("Incomplete framebuffer: {fbo_status:#x}")));
            }
        }

        let result = self.run(context, &program, framebuffer.get());

        // The framebuffer is this case's own; leaving it bound would be reported against
        // the next case, which `glu::reset_state_es` would fix but only after the fact.
        // SAFETY: unbinding needs only a current context.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };

        result
    }
}

impl FragmentOutputCase {
    /// `FragmentOutputCase::iterate`
    fn run(&self, context: &Context, program: &ShaderProgram, framebuffer: GLuint) -> TestOutcome {
        let gl = context.gl();

        // Compute grid size and index list.
        const MIN_CELL_SIZE: i32 = 8;
        let min_buf_w = self
            .fbo_spec
            .iter()
            .map(|s| s.width)
            .min()
            .expect("at least one attachment");
        let min_buf_h = self
            .fbo_spec
            .iter()
            .map(|s| s.height)
            .min()
            .expect("at least one attachment");
        let grid_width = (min_buf_w / MIN_CELL_SIZE).clamp(1, 255) + 1;
        let grid_height = (min_buf_h / MIN_CELL_SIZE).clamp(1, 255) + 1;
        let num_vertices = grid_width * grid_height;
        let num_quads = (grid_width - 1) * (grid_height - 1);
        let num_indices = num_quads * 6;

        const READ_ALIGNMENT: i32 = 4;
        let viewport_w = min_buf_w;
        let viewport_h = min_buf_h;
        let num_attachments = self.fbo_spec.len();

        // Initialize attachment data.
        let mut attachments: Vec<AttachmentData> = Vec::with_capacity(num_attachments);
        for spec in &self.fbo_spec {
            let tex_fmt = glu::texture_util::map_gl_internal_format(spec.format)
                .ok_or_else(|| TestError::Fail(format!("no texture format for {:#x}", spec.format)))?;
            let chn_class = tex_fmt.type_.channel_class();
            let is_fixed_point = matches!(
                chn_class,
                TextureChannelClass::SignedFixedPoint | TextureChannelClass::UnsignedFixedPoint
            );

            // Fixed-point formats use a float reference to enable more accurate result
            // verification.
            let ref_fmt = if is_fixed_point {
                TextureFormat {
                    order: tex_fmt.order,
                    type_: ChannelType::FLOAT,
                }
            } else {
                tex_fmt
            };
            let read_fmt = framebuffer_read_format(tex_fmt);
            let pixels = (spec.width * spec.height) as usize;

            attachments.push(AttachmentData {
                format: tex_fmt,
                reference_format: ref_fmt,
                read_format: read_fmt,
                num_written_channels: 0,
                out_precision: Precision::HighP,
                rendered_data: vec![0u8; read_fmt.pixel_size().expect("canonical read format") as usize * pixels],
                reference_data: vec![0u8; ref_fmt.pixel_size().expect("renderable format") as usize * pixels],
            });
        }

        // Initialize indices.
        let mut indices = vec![0u16; num_indices as usize];
        for quad_ndx in 0..num_quads {
            let quad_y = quad_ndx / (grid_width - 1);
            let quad_x = quad_ndx - quad_y * (grid_width - 1);
            let base = quad_ndx as usize * 6;

            indices[base] = (quad_x + quad_y * grid_width) as u16;
            indices[base + 1] = (quad_x + (quad_y + 1) * grid_width) as u16;
            indices[base + 2] = (quad_x + quad_y * grid_width + 1) as u16;
            indices[base + 3] = indices[base + 1];
            indices[base + 4] = (quad_x + (quad_y + 1) * grid_width + 1) as u16;
            indices[base + 5] = indices[base + 2];
        }

        let mut positions = vec![0.0f32; num_vertices as usize * 4];
        for y in 0..grid_height {
            for x in 0..grid_width {
                let xf = x as f32 / (grid_width - 1) as f32;
                let yf = y as f32 / (grid_height - 1) as f32;
                let base = (y * grid_width + x) as usize * 4;

                positions[base] = 2.0 * xf - 1.0;
                positions[base + 1] = 2.0 * yf - 1.0;
                positions[base + 2] = 0.0;
                positions[base + 3] = 1.0;
            }
        }

        // Initialize input vectors. Each is a run of 32-bit words, read back as floats,
        // ints or uints according to the output's own type.
        let mut inputs: Vec<Vec<u32>> = Vec::new();
        {
            let mut cur_in_vec = 0usize;
            for output in &self.outputs {
                let num_scalars = output.ty.scalar_size() as usize;

                for vec_ndx in 0..output.num_vecs() {
                    let location = (output.location + vec_ndx) as usize;
                    attachments[location].num_written_channels = num_scalars as i32;
                    attachments[location].out_precision = output.precision;

                    let mut values = vec![0u32; num_vertices as usize * num_scalars];

                    if output.ty.is_float_or_vec() {
                        let (range_min, range_max) = float_range(output.precision);
                        // Floating-point precision conversion is not well defined, so
                        // the range has to be the intersection of the data type's and
                        // the render target's.
                        let fmt_info = get_texture_format_info(attachments[location].format);
                        let min_val: [f32; 4] = std::array::from_fn(|i| range_min.max(fmt_info.value_min[i]));
                        let max_val: [f32; 4] = std::array::from_fn(|i| range_max.min(fmt_info.value_max[i]));

                        for y in 0..grid_height {
                            for x in 0..grid_width {
                                let xf = x as f32 / (grid_width - 1) as f32;
                                let yf = y as f32 / (grid_height - 1) as f32;
                                let f0 = (xf + yf) * 0.5;
                                let f1 = 0.5 + (xf - yf) * 0.5;
                                let f = swizzle_vec([f0, f1, 1.0 - f0, 1.0 - f1], cur_in_vec);
                                let base = (y * grid_width + x) as usize * num_scalars;

                                for ndx in 0..num_scalars {
                                    values[base + ndx] =
                                        (min_val[ndx] + (max_val[ndx] - min_val[ndx]) * f[ndx]).to_bits();
                                }
                            }
                        }
                    } else if output.ty.is_int_or_ivec() {
                        let (range_min, range_max) = int_range(output.precision);
                        // Limit to the range of the output format, as the conversion
                        // mode is not specified.
                        let fmt_bits = get_texture_format_bit_depth(attachments[location].format);
                        let min_val: [i32; 4] = std::array::from_fn(|i| {
                            if fmt_bits[i] <= 0 {
                                range_min
                            } else {
                                range_min.max(-(1i64 << (fmt_bits[i] - 1).clamp(0, 256)) as i32)
                            }
                        });
                        let max_val: [i32; 4] = std::array::from_fn(|i| {
                            if fmt_bits[i] <= 0 {
                                range_max
                            } else {
                                range_max.min(((1i64 << (fmt_bits[i] - 1).clamp(0, 256)) - 1) as i32)
                            }
                        });

                        let range_div = swizzle_vec(
                            [grid_width - 1, grid_height - 1, grid_width - 1, grid_height - 1],
                            cur_in_vec,
                        );
                        let step: [i32; 4] = std::array::from_fn(|i| {
                            ((max_val[i] as i64 - min_val[i] as i64) / range_div[i] as i64) as i32
                        });

                        for y in 0..grid_height {
                            for x in 0..grid_width {
                                let ix = grid_width - x - 1;
                                let iy = grid_height - y - 1;
                                let s = swizzle_vec([x, y, ix, iy], cur_in_vec);
                                let base = (y * grid_width + x) as usize * num_scalars;

                                for ndx in 0..num_scalars {
                                    values[base + ndx] =
                                        min_val[ndx].wrapping_add(step[ndx].wrapping_mul(s[ndx])) as u32;
                                }
                            }
                        }
                    } else {
                        let (_, range_max) = uint_range(output.precision);
                        let fmt_bits = get_texture_format_bit_depth(attachments[location].format);
                        let max_val: [u32; 4] =
                            std::array::from_fn(|i| range_max.min(((1u64 << fmt_bits[i].max(0)) - 1) as u32));

                        let range_div = swizzle_vec(
                            [grid_width - 1, grid_height - 1, grid_width - 1, grid_height - 1],
                            cur_in_vec,
                        );
                        let step: [u32; 4] = std::array::from_fn(|i| max_val[i] / range_div[i] as u32);

                        for y in 0..grid_height {
                            for x in 0..grid_width {
                                let ix = grid_width - x - 1;
                                let iy = grid_height - y - 1;
                                let s = swizzle_vec([x as u32, y as u32, ix as u32, iy as u32], cur_in_vec);
                                let base = (y * grid_width + x) as usize * num_scalars;

                                for ndx in 0..num_scalars {
                                    values[base + ndx] = step[ndx].wrapping_mul(s[ndx]);
                                }
                            }
                        }
                    }

                    inputs.push(values);
                    cur_in_vec += 1;
                }
            }
        }

        let draw_buffers: Vec<GLenum> = (0..num_attachments)
            .map(|ndx| glw::GL_COLOR_ATTACHMENT0 + ndx as GLenum)
            .collect();

        // SAFETY: every client array below outlives the draw that reads it, and the
        // index list stays inside the vertex count the position array carries.
        unsafe {
            gl.use_program(program.program());
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer);
            gl.viewport(0, 0, viewport_w, viewport_h);
            gl.draw_buffers(draw_buffers.len() as i32, draw_buffers.as_ptr());
            // Dithering causes issues with unorm formats. Those issues could be worked
            // around in the threshold, but it makes validation less accurate.
            gl.disable(glw::GL_DITHER);
            glu::expect_no_error(gl, "After program setup")?;

            let mut cur_in_vec = 0usize;
            for (output_ndx, output) in self.outputs.iter().enumerate() {
                let is_array = output.array_length > 0;
                let is_float = output.ty.is_float_or_vec();
                let scalar_size = output.ty.scalar_size();
                let gl_scalar_type = if is_float {
                    glw::GL_FLOAT
                } else if output.ty.is_int_or_ivec() {
                    glw::GL_INT
                } else {
                    glw::GL_UNSIGNED_INT
                };

                for vec_ndx in 0..output.num_vecs() {
                    let name = if is_array {
                        format!("in{output_ndx}_{vec_ndx}")
                    } else {
                        format!("in{output_ndx}")
                    };
                    let c_name = std::ffi::CString::new(name.as_str()).expect("generated name has no interior nul");
                    let loc = gl.get_attrib_location(program.program(), c_name.as_ptr());

                    if loc >= 0 {
                        gl.enable_vertex_attrib_array(loc as GLuint);
                        let ptr = inputs[cur_in_vec].as_ptr().cast();
                        if is_float {
                            gl.vertex_attrib_pointer(loc as GLuint, scalar_size, gl_scalar_type, glw::FALSE, 0, ptr);
                        } else {
                            gl.vertex_attrib_i_pointer(loc as GLuint, scalar_size, gl_scalar_type, 0, ptr);
                        }
                    } else {
                        log::warn!("Warning: No location for attribute '{name}' found.");
                    }

                    cur_in_vec += 1;
                }
            }

            let pos_loc = gl.get_attrib_location(program.program(), c"a_position".as_ptr());
            if pos_loc < 0 {
                return Err(TestError::Fail("no location for a_position".to_string()));
            }
            gl.enable_vertex_attrib_array(pos_loc as GLuint);
            gl.vertex_attrib_pointer(
                pos_loc as GLuint,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                positions.as_ptr().cast(),
            );
            glu::expect_no_error(gl, "After attribute setup")?;

            gl.draw_elements(
                glw::GL_TRIANGLES,
                num_indices,
                glw::GL_UNSIGNED_SHORT,
                indices.as_ptr().cast(),
            );
            glu::expect_no_error(gl, "glDrawElements")?;
        }

        // Read all attachment points.
        for (ndx, attachment) in attachments.iter_mut().enumerate() {
            let transfer_fmt = glu::get_transfer_format(attachment.read_format)?;
            let spec = self.fbo_spec[ndx];
            let row_pitch = align32(
                attachment.read_format.pixel_size().expect("canonical read format") as i32 * spec.width,
                READ_ALIGNMENT,
            ) as usize;

            // SAFETY: the destination holds `width * height` pixels of the read format,
            // which is what the range asked for below fits in.
            unsafe {
                gl.read_buffer(glw::GL_COLOR_ATTACHMENT0 + ndx as GLenum);
                gl.read_pixels(
                    0,
                    0,
                    min_buf_w,
                    min_buf_h,
                    transfer_fmt.format,
                    transfer_fmt.data_type,
                    attachment.rendered_data.as_mut_ptr().cast(),
                );
            }
            glu::expect_no_error(gl, "glReadPixels")?;

            let pixel_pitch = attachment.read_format.pixel_size().expect("canonical read format") as usize;
            let mut rendered = PixelBufferAccess::new_with_pitch(
                attachment.read_format,
                [spec.width as u32, spec.height as u32, 1],
                [pixel_pitch, row_pitch, row_pitch * spec.height as usize],
                &mut attachment.rendered_data,
            );

            if !clear_undefined(&mut rendered, attachment.num_written_channels) {
                return Err(TestError::Fail(
                    "unsupported channel type in the read-back format".to_string(),
                ));
            }
        }

        // Render reference images.
        {
            let mut cur_in_ndx = 0usize;
            for output in &self.outputs {
                let is_float = output.ty.is_float_or_vec();
                let scalar_size = output.ty.scalar_size();

                for vec_ndx in 0..output.num_vecs() {
                    let location = (output.location + vec_ndx) as usize;
                    let buf_w = self.fbo_spec[location].width;
                    let buf_h = self.fbo_spec[location].height;
                    let attachment = &mut attachments[location];
                    let mut buf = PixelBufferAccess::new(
                        attachment.reference_format,
                        [buf_w as u32, buf_h as u32, 1],
                        &mut attachment.reference_data,
                    );
                    let mut viewport_buf = buf.get_subregion(0, 0, 0, viewport_w as u32, viewport_h as u32, 1);

                    if is_float {
                        // The 32-bit words carry floats for a float output.
                        let floats: Vec<f32> = inputs[cur_in_ndx].iter().map(|w| f32::from_bits(*w)).collect();
                        render_float_reference(&mut viewport_buf, grid_width, grid_height, scalar_size, &floats);
                    } else {
                        let ints: Vec<i32> = inputs[cur_in_ndx].iter().map(|w| *w as i32).collect();
                        if !render_int_reference(&mut viewport_buf, grid_width, grid_height, scalar_size, &ints) {
                            return Err(TestError::Fail(
                                "unsupported channel type in the reference format".to_string(),
                            ));
                        }
                    }

                    cur_in_ndx += 1;
                }
            }
        }

        // Compare all images.
        let mut all_levels_ok = true;
        for (attach_ndx, attachment) in attachments.iter().enumerate() {
            let spec = self.fbo_spec[attach_ndx];
            let num_valid_channels = attachment.num_written_channels;
            let cmp_mask: [bool; 4] = std::array::from_fn(|i| num_valid_channels > i as i32);
            let pixel_pitch = attachment.read_format.pixel_size().expect("canonical read format") as usize;
            let row_pitch = align32(pixel_pitch as i32 * spec.width, READ_ALIGNMENT) as usize;

            let rendered = ConstPixelBufferAccess::new_with_pitch(
                attachment.read_format,
                [spec.width as u32, spec.height as u32, 1],
                [pixel_pitch, row_pitch, row_pitch * spec.height as usize],
                &attachment.rendered_data,
            );
            let reference = ConstPixelBufferAccess::new(
                attachment.reference_format,
                [spec.width as u32, spec.height as u32, 1],
                &attachment.reference_data,
            );

            log::info!(
                "Attachment {attach_ndx}: {num_valid_channels} channels have defined values and used for comparison"
            );

            let is_ok = match attachment.format.type_.channel_class() {
                TextureChannelClass::FloatingPoint => {
                    // 4 ULP interpolation threshold; interpolation is always in highp.
                    const INTERP_THRESHOLD: u32 = 4;

                    // 1 ULP rounding error is allowed for the smaller float formats.
                    let format_threshold: [u32; 4] = match attachment.format.type_ {
                        ChannelType::FLOAT => [0; 4],
                        ChannelType::HALF_FLOAT => [1 << (23 - 10); 4],
                        ChannelType::UNSIGNED_INT_11F_11F_10F_REV => [1 << (23 - 6), 1 << (23 - 6), 1 << (23 - 5), 0],
                        _ => return Err(TestError::Fail("unexpected floating-point channel type".to_string())),
                    };

                    // 1 ULP rounding error for the highp -> output precision cast.
                    let out_type_threshold: u32 = match attachment.out_precision {
                        Precision::LowP => 1 << (23 - 8),
                        Precision::MediumP => 1 << (23 - 10),
                        Precision::HighP => 0,
                    };

                    let final_threshold: [u32; 4] = std::array::from_fn(|i| {
                        if cmp_mask[i] {
                            format_threshold[i].max(INTERP_THRESHOLD.max(out_type_threshold))
                        } else {
                            u32::MAX
                        }
                    });

                    let result = float_ulp_threshold_compare(&reference, &rendered, UVec4::from_array(final_threshold));
                    if !result.ok {
                        log::warn!(
                            "Attachment {attach_ndx}: max ULP difference {:?}, threshold {final_threshold:?}",
                            result.max_diff.m_data
                        );
                    }
                    result.ok
                }

                TextureChannelClass::UnsignedFixedPoint => {
                    // glReadPixels allows only 8 bits to be read, so RGB10_A2 loses some
                    // bits on the way out and the threshold has to allow for it.
                    let bits = get_texture_format_bit_depth(attachment.format).map(|b| b.min(8));
                    let threshold: [f32; 4] = std::array::from_fn(|i| {
                        if cmp_mask[i] {
                            1.0 / ((1i32 << bits[i]) - 1) as f32
                        } else {
                            2.0
                        }
                    });

                    let result = float_threshold_compare(&reference, &rendered, threshold);
                    if !result.ok {
                        log::warn!(
                            "Attachment {attach_ndx}: max difference {:?}, threshold {threshold:?}",
                            result.max_diff
                        );
                    }
                    result.ok
                }

                TextureChannelClass::SignedInteger | TextureChannelClass::UnsignedInteger => {
                    let threshold: [u32; 4] = std::array::from_fn(|i| if cmp_mask[i] { 0 } else { u32::MAX });
                    let result = int_threshold_compare(&reference, &rendered, UVec4::from_array(threshold));
                    if !result.ok {
                        log::warn!("Attachment {attach_ndx}: max difference {:?}", result.max_diff.m_data);
                    }
                    result.ok
                }

                _ => return Err(TestError::Fail("Unsupported comparison".to_string())),
            };

            if !is_ok {
                all_levels_ok = false;
            }
        }

        Ok(if all_levels_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Image comparison failed")
        })
    }
}

fn case(name: String, fbo_spec: Vec<BufferSpec>, outputs: Vec<FragmentOutput>) -> Box<dyn TestCase> {
    Box::new(FragmentOutputCase {
        name,
        fbo_spec,
        outputs,
    })
}

/// `FboTestUtil::getFormatName` - the lowercased enum name minus `GL_`.
fn format_name(format: GLenum) -> String {
    glu::texture_format_name(format).expect("every format these cases use has a name")[3..].to_lowercase()
}

const REQUIRED_FLOAT_FORMATS: [GLenum; 7] = [
    glw::GL_RGBA32F,
    glw::GL_RGBA16F,
    glw::GL_R11F_G11F_B10F,
    glw::GL_RG32F,
    glw::GL_RG16F,
    glw::GL_R32F,
    glw::GL_R16F,
];

const REQUIRED_FIXED_FORMATS: [GLenum; 9] = [
    glw::GL_RGBA8,
    glw::GL_SRGB8_ALPHA8,
    glw::GL_RGB10_A2,
    glw::GL_RGBA4,
    glw::GL_RGB5_A1,
    glw::GL_RGB8,
    glw::GL_RGB565,
    glw::GL_RG8,
    glw::GL_R8,
];

const REQUIRED_INT_FORMATS: [GLenum; 9] = [
    glw::GL_RGBA32I,
    glw::GL_RGBA16I,
    glw::GL_RGBA8I,
    glw::GL_RG32I,
    glw::GL_RG16I,
    glw::GL_RG8I,
    glw::GL_R32I,
    glw::GL_R16I,
    glw::GL_R8I,
];

const REQUIRED_UINT_FORMATS: [GLenum; 10] = [
    glw::GL_RGBA32UI,
    glw::GL_RGBA16UI,
    glw::GL_RGBA8UI,
    glw::GL_RGB10_A2UI,
    glw::GL_RG32UI,
    glw::GL_RG16UI,
    glw::GL_RG8UI,
    glw::GL_R32UI,
    glw::GL_R16UI,
    glw::GL_R8UI,
];

const PRECISIONS: [Precision; 3] = [Precision::LowP, Precision::MediumP, Precision::HighP];

/// The four vector widths each format/precision pair is tested at, and the suffix each
/// gets in the case name.
const FLOAT_TYPES: [(DataType, &str); 4] = [
    (DataType::Float, "float"),
    (DataType::FloatVec2, "vec2"),
    (DataType::FloatVec3, "vec3"),
    (DataType::FloatVec4, "vec4"),
];
const INT_TYPES: [(DataType, &str); 4] = [
    (DataType::Int, "int"),
    (DataType::IntVec2, "ivec2"),
    (DataType::IntVec3, "ivec3"),
    (DataType::IntVec4, "ivec4"),
];
const UINT_TYPES: [(DataType, &str); 4] = [
    (DataType::Uint, "uint"),
    (DataType::UintVec2, "uvec2"),
    (DataType::UintVec3, "uvec3"),
    (DataType::UintVec4, "uvec4"),
];

/// One `basic`/`array` sub-group: every format crossed with every precision and every
/// vector width. `num_targets` is 1 for `basic` and the array length for `array`.
fn add_format_group(
    parent: &mut TestCaseGroup,
    name: &str,
    formats: &[GLenum],
    types: &[(DataType, &str); 4],
    num_targets: i32,
) {
    const WIDTH: i32 = 64;
    const HEIGHT: i32 = 64;
    const SAMPLES: i32 = 0;

    let mut group = TestCaseGroup::new(name);

    for format in formats {
        let fmt_name = format_name(*format);
        let fbo_spec: Vec<BufferSpec> = (0..num_targets.max(1))
            .map(|_| BufferSpec {
                format: *format,
                width: WIDTH,
                height: HEIGHT,
                samples: SAMPLES,
            })
            .collect();

        for prec in PRECISIONS {
            for (ty, type_name) in types {
                let case_name = format!("{fmt_name}_{}_{type_name}", prec.name());
                let output = if num_targets > 1 {
                    FragmentOutput::array(*ty, prec, 0, num_targets)
                } else {
                    FragmentOutput::new(*ty, prec, 0)
                };
                group.add_child(case(case_name, fbo_spec.clone(), vec![output]));
            }
        }
    }

    parent.add_child(group);
}

/// `createRandomCase`
fn create_random_case(min_render_targets: i32, max_render_targets: i32, seed: u32) -> Box<dyn TestCase> {
    const OUTPUT_TYPES: [DataType; 12] = [
        DataType::Float,
        DataType::FloatVec2,
        DataType::FloatVec3,
        DataType::FloatVec4,
        DataType::Int,
        DataType::IntVec2,
        DataType::IntVec3,
        DataType::IntVec4,
        DataType::Uint,
        DataType::UintVec2,
        DataType::UintVec3,
        DataType::UintVec4,
    ];
    const FLOAT_FORMATS: [GLenum; 16] = [
        glw::GL_RGBA32F,
        glw::GL_RGBA16F,
        glw::GL_R11F_G11F_B10F,
        glw::GL_RG32F,
        glw::GL_RG16F,
        glw::GL_R32F,
        glw::GL_R16F,
        glw::GL_RGBA8,
        glw::GL_SRGB8_ALPHA8,
        glw::GL_RGB10_A2,
        glw::GL_RGBA4,
        glw::GL_RGB5_A1,
        glw::GL_RGB8,
        glw::GL_RGB565,
        glw::GL_RG8,
        glw::GL_R8,
    ];

    let mut rnd = Random::new(seed);
    let mut outputs = Vec::new();
    let mut targets = Vec::new();
    let mut out_types = Vec::new();

    let num_targets = rnd.get_int(min_render_targets, max_render_targets);
    // \todo [2012-04-10 pyry] Separate randomized sizes per target?
    const WIDTH: i32 = 128;
    const HEIGHT: i32 = 64;
    const SAMPLES: i32 = 0;

    // Compute outputs.
    let mut cur_loc = 0;
    while cur_loc < num_targets {
        let use_array = rnd.get_float() < 0.3;
        let max_array_len = num_targets - cur_loc;
        let array_len = if use_array { rnd.get_int(1, max_array_len) } else { 0 };
        let basic_type = *rnd.choose(&OUTPUT_TYPES);
        let precision = *rnd.choose(&PRECISIONS);
        let num_locations = if use_array { array_len } else { 1 };

        outputs.push(FragmentOutput::array(basic_type, precision, cur_loc, array_len));
        for _ in 0..num_locations {
            out_types.push(basic_type);
        }

        cur_loc += num_locations;
    }

    // Compute buffers.
    while targets.len() < num_targets as usize {
        let out_type = out_types[targets.len()];
        let format = if out_type.is_float_or_vec() {
            *rnd.choose(&FLOAT_FORMATS)
        } else if out_type.is_int_or_ivec() {
            *rnd.choose(&REQUIRED_INT_FORMATS)
        } else {
            *rnd.choose(&RANDOM_UINT_FORMATS)
        };

        targets.push(BufferSpec {
            format,
            width: WIDTH,
            height: HEIGHT,
            samples: SAMPLES,
        });
    }

    case(seed.to_string(), targets, outputs)
}

/// `createRandomCase`'s `uintFormats`, which is the same list as `requiredUintFormats`
/// but is its own array upstream and could drift from it on a re-sync.
const RANDOM_UINT_FORMATS: [GLenum; 10] = REQUIRED_UINT_FORMATS;

/// `FragmentOutputTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut root = TestCaseGroup::new("fragment_out");

    // .basic
    let mut basic_group = TestCaseGroup::new("basic");
    add_format_group(&mut basic_group, "float", &REQUIRED_FLOAT_FORMATS, &FLOAT_TYPES, 1);
    add_format_group(&mut basic_group, "fixed", &REQUIRED_FIXED_FORMATS, &FLOAT_TYPES, 1);
    add_format_group(&mut basic_group, "int", &REQUIRED_INT_FORMATS, &INT_TYPES, 1);
    add_format_group(&mut basic_group, "uint", &REQUIRED_UINT_FORMATS, &UINT_TYPES, 1);
    root.add_child(basic_group);

    // .array
    const NUM_TARGETS: i32 = 3;
    let mut array_group = TestCaseGroup::new("array");
    add_format_group(
        &mut array_group,
        "float",
        &REQUIRED_FLOAT_FORMATS,
        &FLOAT_TYPES,
        NUM_TARGETS,
    );
    add_format_group(
        &mut array_group,
        "fixed",
        &REQUIRED_FIXED_FORMATS,
        &FLOAT_TYPES,
        NUM_TARGETS,
    );
    add_format_group(&mut array_group, "int", &REQUIRED_INT_FORMATS, &INT_TYPES, NUM_TARGETS);
    add_format_group(
        &mut array_group,
        "uint",
        &REQUIRED_UINT_FORMATS,
        &UINT_TYPES,
        NUM_TARGETS,
    );
    root.add_child(array_group);

    // .random
    let mut random_group = TestCaseGroup::new("random");
    for seed in 0..100 {
        random_group.add_child(create_random_case(2, 4, seed));
    }
    root.add_child(random_group);

    root
}
