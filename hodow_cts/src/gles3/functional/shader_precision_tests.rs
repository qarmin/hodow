// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fShaderPrecisionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's note: the floating-point case uses an R32UI render target and
// `floatBitsToUint()` in the shader to write out the bits of the result, since ES 3 core
// has no FP render target. Upstream then reads those bits back into a `vector<float>` and
// reads element 0 *as a float*, i.e. the bits go back to being the value the shader
// computed. This port reads into a `Vec<u32>` and says `f32::from_bits` where upstream
// says nothing, which is the same operation written down.
//
// Upstream builds the program and the framebuffer in `init` and runs `iterate` four
// times; the harness here has no iterate loop, so the four iterations are a loop inside
// `iterate` over one program and one framebuffer. The `Random` is seeded once from the
// case name and carried across all four, exactly as the member `m_rnd` is.

use crate::glu::{self, Context, Precision, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, pr, va};
use crate::glw::{self, GLenum};
use crate::tcu::pixel::f16_bits_to_f32;
use crate::tcu::{Random, TestError, TestOutcome, TestStatus, de_string_hash};

const FRAMEBUFFER_WIDTH: i32 = 32;
const FRAMEBUFFER_HEIGHT: i32 = 32;

/// `m_numTestsPerIter`
const NUM_TESTS_PER_ITER: i32 = 32;
/// `m_numIters`
const NUM_ITERS: i32 = 4;

const POSITION: [f32; 16] = [
    -1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
];
const INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];
const NUM_VERTICES: i32 = 4;

/// `tcu::Float32::exponent` - `isDenorm() ? 1 - ExponentBias : exponentBits() - ExponentBias`.
fn float32_exponent(value: f32) -> i32 {
    let bits = value.to_bits();
    let exponent_bits = ((bits >> 23) & 0xff) as i32;
    let mantissa_bits = bits & 0x007f_ffff;

    if exponent_bits == 0 && mantissa_bits != 0 {
        1 - 127
    } else {
        exponent_bits - 127
    }
}

/// `deSignExtendTo32`
fn de_sign_extend_to_32(value: i32, num_bits: i32) -> i32 {
    debug_assert!((1..=32).contains(&num_bits));

    if num_bits < 32 {
        let sign_set = (value as u32) & (1u32 << (num_bits - 1)) != 0;
        let mask = !((1u32 << num_bits) - 1);

        ((value as u32) | if sign_set { mask } else { 0 }) as i32
    } else {
        value
    }
}

/// `createFloatPrecisionEvalProgram`
fn create_float_precision_eval_program(precision: Precision, eval_op: &str, is_vertex_case: bool) -> ProgramSources {
    let type_name = "float";
    let out_type_name = "uint";
    let prec_name = precision.name();
    let mut vtx = String::new();
    let mut frag = String::new();

    vtx.push_str("#version 300 es\n");
    vtx.push_str("in highp vec4 a_position;\n");
    vtx.push_str(&format!("in {prec_name} {type_name} a_in0;\n"));
    vtx.push_str(&format!("in {prec_name} {type_name} a_in1;\n"));
    frag.push_str("#version 300 es\n");
    frag.push_str(&format!("layout(location = 0) out highp {out_type_name} o_out;\n"));

    if is_vertex_case {
        vtx.push_str(&format!("flat out {prec_name} {type_name} v_out;\n"));
        frag.push_str(&format!("flat in {prec_name} {type_name} v_out;\n"));
    } else {
        vtx.push_str(&format!("flat out {prec_name} {type_name} v_in0;\n"));
        vtx.push_str(&format!("flat out {prec_name} {type_name} v_in1;\n"));
        frag.push_str(&format!("flat in {prec_name} {type_name} v_in0;\n"));
        frag.push_str(&format!("flat in {prec_name} {type_name} v_in1;\n"));
    }

    vtx.push_str("\nvoid main (void)\n{\n");
    vtx.push_str("    gl_Position = a_position;\n");
    frag.push_str("\nvoid main (void)\n{\n");

    let in_prefix = if is_vertex_case { "a_" } else { "v_" };
    let op = if is_vertex_case { &mut vtx } else { &mut frag };
    op.push_str(&format!("\t{prec_name} {type_name} in0 = {in_prefix}in0;\n"));
    op.push_str(&format!("\t{prec_name} {type_name} in1 = {in_prefix}in1;\n"));

    if !is_vertex_case {
        op.push_str(&format!("\t{prec_name} {type_name} res;\n"));
    }

    op.push_str(&format!(
        "\t{} = {eval_op};\n",
        if is_vertex_case { "v_out" } else { "res" }
    ));

    if is_vertex_case {
        frag.push_str("    o_out = floatBitsToUint(v_out);\n");
    } else {
        vtx.push_str("    v_in0 = a_in0;\n");
        vtx.push_str("    v_in1 = a_in1;\n");
        frag.push_str("    o_out = floatBitsToUint(res);\n");
    }

    vtx.push_str("}\n");
    frag.push_str("}\n");

    ProgramSources::vtx_frag(vtx, frag)
}

/// `createIntUintPrecisionEvalProgram`
fn create_int_uint_precision_eval_program(
    type_name: &str,
    precision: Precision,
    eval_op: &str,
    is_vertex_case: bool,
) -> ProgramSources {
    let prec_name = precision.name();
    let mut vtx = String::new();
    let mut frag = String::new();

    vtx.push_str("#version 300 es\n");
    vtx.push_str("in highp vec4 a_position;\n");
    vtx.push_str(&format!("in {prec_name} {type_name} a_in0;\n"));
    vtx.push_str(&format!("in {prec_name} {type_name} a_in1;\n"));
    frag.push_str("#version 300 es\n");
    frag.push_str(&format!("layout(location = 0) out {prec_name} {type_name} o_out;\n"));

    if is_vertex_case {
        vtx.push_str(&format!("flat out {prec_name} {type_name} v_out;\n"));
        frag.push_str(&format!("flat in {prec_name} {type_name} v_out;\n"));
    } else {
        vtx.push_str(&format!("flat out {prec_name} {type_name} v_in0;\n"));
        vtx.push_str(&format!("flat out {prec_name} {type_name} v_in1;\n"));
        frag.push_str(&format!("flat in {prec_name} {type_name} v_in0;\n"));
        frag.push_str(&format!("flat in {prec_name} {type_name} v_in1;\n"));
    }

    vtx.push_str("\nvoid main (void)\n{\n");
    vtx.push_str("    gl_Position = a_position;\n");
    frag.push_str("\nvoid main (void)\n{\n");

    let in_prefix = if is_vertex_case { "a_" } else { "v_" };
    let op = if is_vertex_case { &mut vtx } else { &mut frag };
    op.push_str(&format!("\t{prec_name} {type_name} in0 = {in_prefix}in0;\n"));
    op.push_str(&format!("\t{prec_name} {type_name} in1 = {in_prefix}in1;\n"));
    op.push_str(&format!(
        "\t{}out = {eval_op};\n",
        if is_vertex_case { "v_" } else { "o_" }
    ));

    if is_vertex_case {
        frag.push_str("    o_out = v_out;\n");
    } else {
        vtx.push_str("    v_in0 = a_in0;\n");
        vtx.push_str("    v_in1 = a_in1;\n");
    }

    vtx.push_str("}\n");
    frag.push_str("}\n");

    ProgramSources::vtx_frag(vtx, frag)
}

/// The framebuffer half of every case's `init`, which differs only in the renderbuffer's
/// internal format.
fn create_framebuffer<'gl>(
    gl: &'gl glw::Functions,
    internal_format: GLenum,
) -> Result<(glu::Framebuffer<'gl>, glu::Renderbuffer<'gl>), TestError> {
    let framebuffer = glu::Framebuffer::new(gl);
    let renderbuffer = glu::Renderbuffer::new(gl);

    // SAFETY: two objects this call owns, and an internal format ES 3 requires to be
    // colour-renderable.
    unsafe {
        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, renderbuffer.get());
        gl.renderbuffer_storage(
            glw::GL_RENDERBUFFER,
            internal_format,
            FRAMEBUFFER_WIDTH,
            FRAMEBUFFER_HEIGHT,
        );

        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.get());
        gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            renderbuffer.get(),
        );
    }

    glu::expect_no_error(gl, "Post framebuffer setup")?;

    // SAFETY: the framebuffer just bound.
    let status = unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) };
    if status != glw::GL_FRAMEBUFFER_COMPLETE {
        return Err(TestError::Fail(format!(
            "Framebuffer is not complete, got {}",
            glw::error_name(status)
        )));
    }

    // SAFETY: unbinding to the default framebuffer is always valid.
    unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };

    Ok((framebuffer, renderbuffer))
}

/// `ShaderFloatPrecisionCase`
struct ShaderFloatPrecisionCase {
    name: String,
    op: &'static str,
    eval_func: fn(f64, f64) -> f64,
    precision: Precision,
    range_a: (f32, f32),
    range_b: (f32, f32),
    is_vertex_case: bool,
}

impl ShaderFloatPrecisionCase {
    /// `ShaderFloatPrecisionCase::compare`
    ///
    /// Comparison is done using a 64-bit reference value to accurately evaluate rounding
    /// mode error. If a 32-bit reference value is used, 2 bits of rounding error must be
    /// allowed. For mediump and lowp types the comparison currently allows 3 bits of
    /// rounding error: two bits from conversions and one from the actual operation.
    fn compare(&self, in0: f32, in1: f32, reference: f64, result: f32) -> bool {
        let mantissa_bits = if self.precision == Precision::HighP { 23 } else { 10 };
        let num_prec_bits = 52 - mantissa_bits;

        let in0_exp = float32_exponent(in0);
        let in1_exp = float32_exponent(in1);
        let res_exp = float32_exponent(result);
        // Lost due to mantissa shift.
        let num_lost_bits = (in0_exp - res_exp).max(in1_exp - res_exp).max(0);

        let rounding_ulp_error = if self.precision == Precision::HighP { 1 } else { 3 };
        let mask_bits = num_lost_bits + num_prec_bits;

        log::debug!(
            "Assuming {mantissa_bits} mantissa bits, {num_lost_bits} bits lost in operation, and {rounding_ulp_error} ULP rounding error."
        );

        let ref_bits = reference.to_bits();
        let res_bits = f64::from(result).to_bits();
        let accurate_ref_bits = if mask_bits < 64 { ref_bits >> mask_bits } else { 0 };
        let accurate_res_bits = if mask_bits < 64 { res_bits >> mask_bits } else { 0 };
        let ulp_diff = (accurate_ref_bits as i64 - accurate_res_bits as i64).unsigned_abs();

        if ulp_diff > rounding_ulp_error {
            log::warn!("ERROR: comparison failed! ULP diff (ignoring lost/undefined bits) = {ulp_diff}");
            false
        } else {
            true
        }
    }
}

impl TestCase for ShaderFloatPrecisionCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let mut rnd = Random::new(de_string_hash(&self.name));

        let program = ShaderProgram::new(
            gl,
            &create_float_precision_eval_program(self.precision, self.op, self.is_vertex_case),
        );
        if !program.is_ok() {
            return Err(TestError::Fail("Compile failed".to_string()));
        }

        let (framebuffer, _renderbuffer) = create_framebuffer(gl, glw::GL_R32UI)?;

        // Image read from GL. The R32UI target holds the bits of the result; upstream
        // reads them into a float array, which is what `f32::from_bits` says below.
        let mut pixels = vec![0u32; (FRAMEBUFFER_WIDTH * FRAMEBUFFER_HEIGHT * 4) as usize];
        let prog = program.program();

        // SAFETY: a linked program and a complete framebuffer.
        unsafe {
            gl.use_program(prog);
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.get());
        }
        glu::expect_no_error(gl, "After program setup")?;

        let mut status = TestStatus::pass("Pass");

        'iters: for iter_ndx in 0..NUM_ITERS {
            // Compute values and reference.
            for test_ndx in 0..NUM_TESTS_PER_ITER {
                let in0 = rnd.get_float_range(self.range_a.0, self.range_a.1);
                let in1 = rnd.get_float_range(self.range_b.0, self.range_b.1);
                let ref_d = (self.eval_func)(f64::from(in0), f64::from(in1));
                // Uses RTE rounding mode.
                let ref_f = ref_d as f32;

                log::debug!(
                    "iter {iter_ndx}, test {test_ndx}: in0 = {in0} / {:#x}, in1 = {in1} / {:#x}",
                    in0.to_bits(),
                    in1.to_bits()
                );
                log::debug!("  reference = {ref_f} / {:#x}", ref_f.to_bits());

                let in0_arr = [in0; NUM_VERTICES as usize];
                let in1_arr = [in1; NUM_VERTICES as usize];
                let vertex_arrays = [
                    va::float("a_position", 4, NUM_VERTICES, 0, &POSITION),
                    va::float("a_in0", 1, NUM_VERTICES, 0, &in0_arr),
                    va::float("a_in1", 1, NUM_VERTICES, 0, &in1_arr),
                ];

                glu::draw(render_ctx, prog, &vertex_arrays, &pr::triangles(&INDICES))?;
                // SAFETY: the buffer holds one RGBA32UI texel per pixel of the target.
                unsafe {
                    gl.read_pixels(
                        0,
                        0,
                        FRAMEBUFFER_WIDTH,
                        FRAMEBUFFER_HEIGHT,
                        glw::GL_RGBA_INTEGER,
                        glw::GL_UNSIGNED_INT,
                        pixels.as_mut_ptr().cast(),
                    );
                }
                glu::expect_no_error(gl, "After render")?;

                let result = f32::from_bits(pixels[0]);
                log::debug!("  result = {result} / {:#x}", pixels[0]);

                // Verify results
                if self.compare(in0, in1, ref_d, result) {
                    // Check that rest of pixels match to first one.
                    let first_pixel_bits = pixels[0];
                    let mut all_pixels_ok = true;

                    for y in 0..FRAMEBUFFER_HEIGHT {
                        for x in 0..FRAMEBUFFER_WIDTH {
                            let pixel_bits = pixels[((y * FRAMEBUFFER_WIDTH + x) * 4) as usize];

                            if pixel_bits != first_pixel_bits {
                                log::warn!("ERROR: Inconsistent results, got {pixel_bits:#x} at ({x}, {y})");
                                all_pixels_ok = false;
                            }
                        }

                        if !all_pixels_ok {
                            break;
                        }
                    }

                    if !all_pixels_ok {
                        status = TestStatus::fail("Inconsistent values in framebuffer");
                    }
                } else {
                    status = TestStatus::fail("Result comparison failed");
                }

                if status.is_fail() {
                    break 'iters;
                }
            }
        }

        // SAFETY: rebinding the default framebuffer is always valid.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };
        glu::expect_no_error(gl, "After iteration")?;

        Ok(status)
    }
}

/// `ShaderIntPrecisionCase`
struct ShaderIntPrecisionCase {
    name: String,
    op: &'static str,
    eval_func: fn(i64, i64) -> i64,
    precision: Precision,
    bits: i32,
    range_a: (i32, i32),
    range_b: (i32, i32),
    is_vertex_case: bool,
}

impl TestCase for ShaderIntPrecisionCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let mut rnd = Random::new(de_string_hash(&self.name));

        let program = ShaderProgram::new(
            gl,
            &create_int_uint_precision_eval_program("int", self.precision, self.op, self.is_vertex_case),
        );
        if !program.is_ok() {
            return Err(TestError::Fail("Compile failed".to_string()));
        }

        let (framebuffer, _renderbuffer) = create_framebuffer(gl, glw::GL_R32I)?;

        log::debug!("Number of accurate bits assumed = {}", self.bits);

        let mask: u32 = if self.bits == 32 {
            0xffff_ffff
        } else {
            (1u32 << self.bits) - 1
        };
        let mut pixels = vec![0i32; (FRAMEBUFFER_WIDTH * FRAMEBUFFER_HEIGHT * 4) as usize];
        let prog = program.program();

        // \todo [2012-05-03 pyry] A bit hacky. getInt() should work fine with ranges like this.
        let is_max_range_a = self.range_a == (i32::MIN, i32::MAX);
        let is_max_range_b = self.range_b == (i32::MIN, i32::MAX);

        // SAFETY: a linked program and a complete framebuffer.
        unsafe {
            gl.use_program(prog);
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.get());
        }
        glu::expect_no_error(gl, "After program setup")?;

        for iter_ndx in 0..NUM_ITERS {
            // Compute values and reference.
            for test_ndx in 0..NUM_TESTS_PER_ITER {
                let raw0 = if is_max_range_a {
                    rnd.get_uint32() as i32
                } else {
                    rnd.get_int(self.range_a.0, self.range_a.1)
                };
                let raw1 = if is_max_range_b {
                    rnd.get_uint32() as i32
                } else {
                    rnd.get_int(self.range_b.0, self.range_b.1)
                };
                let in0 = de_sign_extend_to_32((raw0 as u32 & mask) as i32, self.bits);
                let in1 = de_sign_extend_to_32((raw1 as u32 & mask) as i32, self.bits);
                // Upstream keeps `refMasked` as an `int` that is already masked, so
                // comparing the masked pixel against it as a `u32` is the same test.
                let ref_masked = ((self.eval_func)(i64::from(in0), i64::from(in1)) as u64 & u64::from(mask)) as u32;
                let ref_out = de_sign_extend_to_32(ref_masked as i32, self.bits);

                log::debug!(
                    "iter {iter_ndx}, test {test_ndx}: in0 = {in0}, in1 = {in1}, ref out = {ref_out} / {ref_masked:#x}"
                );

                let in0_arr = [in0; NUM_VERTICES as usize];
                let in1_arr = [in1; NUM_VERTICES as usize];
                let vertex_arrays = [
                    va::float("a_position", 4, NUM_VERTICES, 0, &POSITION),
                    va::int32("a_in0", 1, NUM_VERTICES, 0, &in0_arr),
                    va::int32("a_in1", 1, NUM_VERTICES, 0, &in1_arr),
                ];

                glu::draw(render_ctx, prog, &vertex_arrays, &pr::triangles(&INDICES))?;
                // SAFETY: the buffer holds one RGBA32I texel per pixel of the target.
                unsafe {
                    gl.read_pixels(
                        0,
                        0,
                        FRAMEBUFFER_WIDTH,
                        FRAMEBUFFER_HEIGHT,
                        glw::GL_RGBA_INTEGER,
                        glw::GL_INT,
                        pixels.as_mut_ptr().cast(),
                    );
                }
                glu::expect_no_error(gl, "After render")?;

                // Compare pixels.
                for y in 0..FRAMEBUFFER_HEIGHT {
                    for x in 0..FRAMEBUFFER_WIDTH {
                        let cmp_out = pixels[((y * FRAMEBUFFER_WIDTH + x) * 4) as usize];
                        let cmp_masked = cmp_out as u32 & mask;

                        if cmp_masked != ref_masked {
                            log::warn!("Comparison failed (at {x}, {y}): got {cmp_out} / {:#x}", cmp_out as u32);
                            // SAFETY: rebinding the default framebuffer is always valid.
                            unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };
                            return Ok(TestStatus::fail("Fail"));
                        }
                    }
                }
            }
        }

        // SAFETY: rebinding the default framebuffer is always valid.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };
        glu::expect_no_error(gl, "After iteration")?;

        Ok(TestStatus::pass("Pass"))
    }
}

/// `ShaderUintPrecisionCase`
struct ShaderUintPrecisionCase {
    name: String,
    op: &'static str,
    eval_func: fn(u32, u32) -> u32,
    precision: Precision,
    bits: i32,
    range_a: (u32, u32),
    range_b: (u32, u32),
    is_vertex_case: bool,
}

impl TestCase for ShaderUintPrecisionCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let mut rnd = Random::new(de_string_hash(&self.name));

        let program = ShaderProgram::new(
            gl,
            &create_int_uint_precision_eval_program("uint", self.precision, self.op, self.is_vertex_case),
        );
        if !program.is_ok() {
            return Err(TestError::Fail("Compile failed".to_string()));
        }

        let (framebuffer, _renderbuffer) = create_framebuffer(gl, glw::GL_R32UI)?;

        log::debug!("Number of accurate bits assumed = {}", self.bits);

        let mask: u32 = if self.bits == 32 {
            0xffff_ffff
        } else {
            (1u32 << self.bits) - 1
        };
        let mut pixels = vec![0u32; (FRAMEBUFFER_WIDTH * FRAMEBUFFER_HEIGHT * 4) as usize];
        let prog = program.program();

        // \todo [2012-05-03 pyry] A bit hacky.
        let is_max_range_a = self.range_a == (0, 0xffff_ffff);
        let is_max_range_b = self.range_b == (0, 0xffff_ffff);

        // SAFETY: a linked program and a complete framebuffer.
        unsafe {
            gl.use_program(prog);
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer.get());
        }
        glu::expect_no_error(gl, "After program setup")?;

        for iter_ndx in 0..NUM_ITERS {
            // Compute values and reference.
            for test_ndx in 0..NUM_TESTS_PER_ITER {
                let in0 = if is_max_range_a {
                    rnd.get_uint32()
                } else {
                    self.range_a.0 + rnd.get_uint32() % (self.range_a.1 - self.range_a.0 + 1)
                } & mask;
                let in1 = if is_max_range_b {
                    rnd.get_uint32()
                } else {
                    self.range_b.0 + rnd.get_uint32() % (self.range_b.1 - self.range_b.0 + 1)
                } & mask;
                let ref_out = (self.eval_func)(in0, in1) & mask;

                log::debug!("iter {iter_ndx}, test {test_ndx}: in0 = {in0:#x}, in1 = {in1:#x}, ref out = {ref_out:#x}");

                let in0_arr = [in0; NUM_VERTICES as usize];
                let in1_arr = [in1; NUM_VERTICES as usize];
                let vertex_arrays = [
                    va::float("a_position", 4, NUM_VERTICES, 0, &POSITION),
                    va::uint32("a_in0", 1, NUM_VERTICES, 0, &in0_arr),
                    va::uint32("a_in1", 1, NUM_VERTICES, 0, &in1_arr),
                ];

                glu::draw(render_ctx, prog, &vertex_arrays, &pr::triangles(&INDICES))?;
                // SAFETY: the buffer holds one RGBA32UI texel per pixel of the target.
                unsafe {
                    gl.read_pixels(
                        0,
                        0,
                        FRAMEBUFFER_WIDTH,
                        FRAMEBUFFER_HEIGHT,
                        glw::GL_RGBA_INTEGER,
                        glw::GL_UNSIGNED_INT,
                        pixels.as_mut_ptr().cast(),
                    );
                }
                glu::expect_no_error(gl, "After render")?;

                // Compare pixels.
                for y in 0..FRAMEBUFFER_HEIGHT {
                    for x in 0..FRAMEBUFFER_WIDTH {
                        let cmp_out = pixels[((y * FRAMEBUFFER_WIDTH + x) * 4) as usize];
                        let cmp_masked = cmp_out & mask;

                        if cmp_masked != ref_out {
                            log::warn!("Comparison failed (at {x}, {y}): got {cmp_out:#x}");
                            // SAFETY: rebinding the default framebuffer is always valid.
                            unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };
                            return Ok(TestStatus::fail("Fail"));
                        }
                    }
                }
            }
        }

        // SAFETY: rebinding the default framebuffer is always valid.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };
        glu::expect_no_error(gl, "After iteration")?;

        Ok(TestStatus::pass("Pass"))
    }
}

// `tcu::add`/`sub`/`mul`/`div`, instantiated at the three element types the tables use.
// The unsigned ones wrap, which is what C++ unsigned arithmetic does.
fn add_f64(a: f64, b: f64) -> f64 {
    a + b
}
fn sub_f64(a: f64, b: f64) -> f64 {
    a - b
}
fn mul_f64(a: f64, b: f64) -> f64 {
    a * b
}
fn div_f64(a: f64, b: f64) -> f64 {
    a / b
}

fn add_i64(a: i64, b: i64) -> i64 {
    a + b
}
fn sub_i64(a: i64, b: i64) -> i64 {
    a - b
}
fn mul_i64(a: i64, b: i64) -> i64 {
    a * b
}
fn div_i64(a: i64, b: i64) -> i64 {
    a / b
}

fn add_u32(a: u32, b: u32) -> u32 {
    a.wrapping_add(b)
}
fn sub_u32(a: u32, b: u32) -> u32 {
    a.wrapping_sub(b)
}
fn mul_u32(a: u32, b: u32) -> u32 {
    a.wrapping_mul(b)
}
fn div_u32(a: u32, b: u32) -> u32 {
    a / b
}

struct FloatCase {
    name: &'static str,
    op: &'static str,
    eval_func: fn(f64, f64) -> f64,
    precision: Precision,
    range_a: (f32, f32),
    range_b: (f32, f32),
}

struct IntCase {
    name: &'static str,
    op: &'static str,
    eval_func: fn(i64, i64) -> i64,
    precision: Precision,
    bits: i32,
    range_a: (i32, i32),
    range_b: (i32, i32),
}

struct UintCase {
    name: &'static str,
    op: &'static str,
    eval_func: fn(u32, u32) -> u32,
    precision: Precision,
    bits: i32,
    range_a: (u32, u32),
    range_b: (u32, u32),
}

/// `ShaderPrecisionTests::init`
pub fn create_tests() -> TestCaseGroup {
    // Exp = Emax-2, Mantissa = 0
    let min_f32 = f32::from_bits((1u32 << 31) | (0xfdu32 << 23));
    let max_f32 = f32::from_bits(0xfdu32 << 23);
    let min_f16 = f16_bits_to_f32((1u16 << 15) | (0x1du16 << 10));
    let max_f16 = f16_bits_to_f32(0x1du16 << 10);
    let full_range_32f = (min_f32, max_f32);
    let full_range_16f = (min_f16, max_f16);
    let full_range_32i = (i32::MIN, i32::MAX);
    let full_range_16i = (-(1 << 15), (1 << 15) - 1);
    let full_range_8i = (-(1 << 7), (1 << 7) - 1);
    let full_range_32u = (0u32, 0xffff_ffffu32);
    let full_range_16u = (0u32, 0xffffu32);
    let full_range_8u = (0u32, 0xffu32);

    // \note Right now it is not programmatically verified that the results shouldn't end
    //       up being inf/nan but actual values used are ok.

    let float_cases = [
        // Name          Op           Eval     Precision           RangeA              RangeB
        FloatCase {
            name: "highp_add",
            op: "in0 + in1",
            eval_func: add_f64,
            precision: Precision::HighP,
            range_a: full_range_32f,
            range_b: full_range_32f,
        },
        FloatCase {
            name: "highp_sub",
            op: "in0 - in1",
            eval_func: sub_f64,
            precision: Precision::HighP,
            range_a: full_range_32f,
            range_b: full_range_32f,
        },
        FloatCase {
            name: "highp_mul",
            op: "in0 * in1",
            eval_func: mul_f64,
            precision: Precision::HighP,
            range_a: (-1e5, 1e5),
            range_b: (-1e5, 1e5),
        },
        FloatCase {
            name: "highp_div",
            op: "in0 / in1",
            eval_func: div_f64,
            precision: Precision::HighP,
            range_a: (-1e5, 1e5),
            range_b: (-1e5, 1e5),
        },
        FloatCase {
            name: "mediump_add",
            op: "in0 + in1",
            eval_func: add_f64,
            precision: Precision::MediumP,
            range_a: full_range_16f,
            range_b: full_range_16f,
        },
        FloatCase {
            name: "mediump_sub",
            op: "in0 - in1",
            eval_func: sub_f64,
            precision: Precision::MediumP,
            range_a: full_range_16f,
            range_b: full_range_16f,
        },
        FloatCase {
            name: "mediump_mul",
            op: "in0 * in1",
            eval_func: mul_f64,
            precision: Precision::MediumP,
            range_a: (-1e2, 1e2),
            range_b: (-1e2, 1e2),
        },
        FloatCase {
            name: "mediump_div",
            op: "in0 / in1",
            eval_func: div_f64,
            precision: Precision::MediumP,
            range_a: (-1e2, 1e2),
            range_b: (-1e2, 1e2),
        },
    ];

    let int_cases = [
        // Name          Op           Eval     Precision            Bits  RangeA           RangeB
        IntCase {
            name: "highp_add",
            op: "in0 + in1",
            eval_func: add_i64,
            precision: Precision::HighP,
            bits: 32,
            range_a: full_range_32i,
            range_b: full_range_32i,
        },
        IntCase {
            name: "highp_sub",
            op: "in0 - in1",
            eval_func: sub_i64,
            precision: Precision::HighP,
            bits: 32,
            range_a: full_range_32i,
            range_b: full_range_32i,
        },
        IntCase {
            name: "highp_mul",
            op: "in0 * in1",
            eval_func: mul_i64,
            precision: Precision::HighP,
            bits: 32,
            range_a: full_range_32i,
            range_b: full_range_32i,
        },
        IntCase {
            name: "highp_div",
            op: "in0 / in1",
            eval_func: div_i64,
            precision: Precision::HighP,
            bits: 32,
            range_a: full_range_32i,
            range_b: (-10000, -1),
        },
        IntCase {
            name: "mediump_add",
            op: "in0 + in1",
            eval_func: add_i64,
            precision: Precision::MediumP,
            bits: 16,
            range_a: full_range_16i,
            range_b: full_range_16i,
        },
        IntCase {
            name: "mediump_sub",
            op: "in0 - in1",
            eval_func: sub_i64,
            precision: Precision::MediumP,
            bits: 16,
            range_a: full_range_16i,
            range_b: full_range_16i,
        },
        IntCase {
            name: "mediump_mul",
            op: "in0 * in1",
            eval_func: mul_i64,
            precision: Precision::MediumP,
            bits: 16,
            range_a: full_range_16i,
            range_b: full_range_16i,
        },
        IntCase {
            name: "mediump_div",
            op: "in0 / in1",
            eval_func: div_i64,
            precision: Precision::MediumP,
            bits: 16,
            range_a: full_range_16i,
            range_b: (1, 1000),
        },
        IntCase {
            name: "lowp_add",
            op: "in0 + in1",
            eval_func: add_i64,
            precision: Precision::LowP,
            bits: 8,
            range_a: full_range_8i,
            range_b: full_range_8i,
        },
        IntCase {
            name: "lowp_sub",
            op: "in0 - in1",
            eval_func: sub_i64,
            precision: Precision::LowP,
            bits: 8,
            range_a: full_range_8i,
            range_b: full_range_8i,
        },
        IntCase {
            name: "lowp_mul",
            op: "in0 * in1",
            eval_func: mul_i64,
            precision: Precision::LowP,
            bits: 8,
            range_a: full_range_8i,
            range_b: full_range_8i,
        },
        IntCase {
            name: "lowp_div",
            op: "in0 / in1",
            eval_func: div_i64,
            precision: Precision::LowP,
            bits: 8,
            range_a: full_range_8i,
            range_b: (-50, -1),
        },
    ];

    let uint_cases = [
        // Name          Op           Eval     Precision            Bits  RangeA           RangeB
        UintCase {
            name: "highp_add",
            op: "in0 + in1",
            eval_func: add_u32,
            precision: Precision::HighP,
            bits: 32,
            range_a: full_range_32u,
            range_b: full_range_32u,
        },
        UintCase {
            name: "highp_sub",
            op: "in0 - in1",
            eval_func: sub_u32,
            precision: Precision::HighP,
            bits: 32,
            range_a: full_range_32u,
            range_b: full_range_32u,
        },
        UintCase {
            name: "highp_mul",
            op: "in0 * in1",
            eval_func: mul_u32,
            precision: Precision::HighP,
            bits: 32,
            range_a: full_range_32u,
            range_b: full_range_32u,
        },
        UintCase {
            name: "highp_div",
            op: "in0 / in1",
            eval_func: div_u32,
            precision: Precision::HighP,
            bits: 32,
            range_a: full_range_32u,
            range_b: (1, 10000),
        },
        UintCase {
            name: "mediump_add",
            op: "in0 + in1",
            eval_func: add_u32,
            precision: Precision::MediumP,
            bits: 16,
            range_a: full_range_16u,
            range_b: full_range_16u,
        },
        UintCase {
            name: "mediump_sub",
            op: "in0 - in1",
            eval_func: sub_u32,
            precision: Precision::MediumP,
            bits: 16,
            range_a: full_range_16u,
            range_b: full_range_16u,
        },
        UintCase {
            name: "mediump_mul",
            op: "in0 * in1",
            eval_func: mul_u32,
            precision: Precision::MediumP,
            bits: 16,
            range_a: full_range_16u,
            range_b: full_range_16u,
        },
        UintCase {
            name: "mediump_div",
            op: "in0 / in1",
            eval_func: div_u32,
            precision: Precision::MediumP,
            bits: 16,
            range_a: full_range_16u,
            range_b: (1, 1000),
        },
        UintCase {
            name: "lowp_add",
            op: "in0 + in1",
            eval_func: add_u32,
            precision: Precision::LowP,
            bits: 8,
            range_a: full_range_8u,
            range_b: full_range_8u,
        },
        UintCase {
            name: "lowp_sub",
            op: "in0 - in1",
            eval_func: sub_u32,
            precision: Precision::LowP,
            bits: 8,
            range_a: full_range_8u,
            range_b: full_range_8u,
        },
        UintCase {
            name: "lowp_mul",
            op: "in0 * in1",
            eval_func: mul_u32,
            precision: Precision::LowP,
            bits: 8,
            range_a: full_range_8u,
            range_b: full_range_8u,
        },
        UintCase {
            name: "lowp_div",
            op: "in0 / in1",
            eval_func: div_u32,
            precision: Precision::LowP,
            bits: 8,
            range_a: full_range_8u,
            range_b: (1, 50),
        },
    ];

    let mut group = TestCaseGroup::new("precision");

    let mut float_group = TestCaseGroup::new("float");
    for case in &float_cases {
        for is_vertex_case in [true, false] {
            float_group.add_child(Box::new(ShaderFloatPrecisionCase {
                name: format!("{}_{}", case.name, if is_vertex_case { "vertex" } else { "fragment" }),
                op: case.op,
                eval_func: case.eval_func,
                precision: case.precision,
                range_a: case.range_a,
                range_b: case.range_b,
                is_vertex_case,
            }) as Box<dyn TestCase>);
        }
    }
    group.add_child(float_group);

    let mut int_group = TestCaseGroup::new("int");
    for case in &int_cases {
        for is_vertex_case in [true, false] {
            int_group.add_child(Box::new(ShaderIntPrecisionCase {
                name: format!("{}_{}", case.name, if is_vertex_case { "vertex" } else { "fragment" }),
                op: case.op,
                eval_func: case.eval_func,
                precision: case.precision,
                bits: case.bits,
                range_a: case.range_a,
                range_b: case.range_b,
                is_vertex_case,
            }) as Box<dyn TestCase>);
        }
    }
    group.add_child(int_group);

    let mut uint_group = TestCaseGroup::new("uint");
    for case in &uint_cases {
        for is_vertex_case in [true, false] {
            uint_group.add_child(Box::new(ShaderUintPrecisionCase {
                name: format!("{}_{}", case.name, if is_vertex_case { "vertex" } else { "fragment" }),
                op: case.op,
                eval_func: case.eval_func,
                precision: case.precision,
                bits: case.bits,
                range_a: case.range_a,
                range_b: case.range_b,
                is_vertex_case,
            }) as Box<dyn TestCase>);
        }
    }
    group.add_child(uint_group);

    group
}
