// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fFlushFinishTests.cpp
//   modules/gles3/functional/es3fFlushFinishTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The two upstream files carry the same
// `FlushFinishCase` with different constants; the ES 3.0 one additionally calibrates the
// shader loop count (`u_numIters`), verifies the calibration and retries it. Both are one
// implementation here, selected by `FlushFinishEs`. `tcu::warmupCPU` is a 50 ms busy loop
// (upstream's does a fixed amount of arithmetic) and the watchdog is not touched - the
// calibration abort time uses upstream's default watchdog interval (30 s).

use std::sync::OnceLock;
use std::time::Instant;

use crate::gls::calibration::theil_sen_linear_regression;
use crate::glu::{Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::{Random, TestError, TestOutcome, TestResult, TestStatus};

/// `Box<dyn TestCase>`, which `add_child` needs (it does not unsize a `Box<Concrete>` itself).
fn boxed(case: impl TestCase + 'static) -> Box<dyn TestCase> {
    Box::new(case)
}

/// Which of the two upstream files a case set is generated from.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum FlushFinishEs {
    Es2,
    Es3,
}

struct Consts {
    max_viewport_size: i32,
    max_sample_duration_us: u64,
    wait_time_ms: u64,
    num_samples: usize,
    corr_threshold: f32,
}

impl FlushFinishEs {
    fn consts(self) -> Consts {
        match self {
            Self::Es2 => Consts {
                max_viewport_size: 128,
                max_sample_duration_us: 1000 * 1000,
                wait_time_ms: 1200,
                num_samples: 25,
                corr_threshold: 0.5,
            },
            Self::Es3 => Consts {
                max_viewport_size: 256,
                max_sample_duration_us: 150 * 1000,
                wait_time_ms: 200,
                num_samples: 50,
                corr_threshold: 0.3,
            },
        }
    }
}

const MIN_DRAW_CALL_COUNT: i32 = 10;
const MAX_DRAW_CALL_COUNT: i32 = 1 << 20;
const NUM_ITERS_IN_SHADER_ES2: i32 = 10;
const MAX_SHADER_ITER_COUNT: i32 = 1 << 10;
const NUM_VERIFICATION_SAMPLES: i32 = 3;
const MAX_CALIBRATION_ATTEMPTS: i32 = 5;
const WATCHDOG_INTERVAL_S: u64 = 30;

const NO_CORR_COEF_THRESHOLD: f32 = 0.1;
const FLUSH_COEF_THRESHOLD: f32 = 0.2;
const CALIBRATION_VERIFICATION_THRESHOLD: f32 = 0.10;

/// `deGetMicroseconds`
fn get_microseconds() -> u64 {
    static START: OnceLock<Instant> = OnceLock::new();
    START.get_or_init(Instant::now).elapsed().as_micros() as u64
}

/// `busyWait`
fn busy_wait(milliseconds: u64) {
    let start_time = get_microseconds();
    let mut v = 2.0f32;

    loop {
        for _ in 0..10 {
            v = std::hint::black_box(v).sin();
        }

        if get_microseconds() - start_time >= 1000 * milliseconds {
            break;
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum ExpectedBehavior {
    CoefLessThan,
    CoefGreaterThan,
}

#[derive(Clone, Copy)]
enum WaitKind {
    Wait,
    Flush,
    FlushWait,
    Finish,
    FinishWait,
}

#[derive(Clone, Copy, Default)]
struct Sample {
    num_draw_calls: i32,
    submit_time: u64,
    wait_time: u64,
    read_pixels_time: u64,
}

#[derive(Clone, Copy, Default)]
struct CalibrationParams {
    max_draw_calls: i32,
    num_iters_in_shader: i32,
}

/// `CalibrationFailedException`
struct CalibrationFailed(String);

/// `FlushFinishCase` and its five subclasses.
struct FlushFinishCase {
    es: FlushFinishEs,
    name: &'static str,
    kind: WaitKind,
    wait_behavior: ExpectedBehavior,
    wait_threshold: f32,
    read_behavior: ExpectedBehavior,
    read_threshold: f32,
}

struct Rendering<'a> {
    context: &'a Context,
    program: ShaderProgram<'a>,
    iter_count_loc: i32,
}

impl FlushFinishCase {
    fn build_program<'a>(&self, context: &'a Context) -> Result<ShaderProgram<'a>, TestError> {
        let (vert, frag) = match self.es {
            FlushFinishEs::Es2 => (
                "attribute highp vec4 a_position;\n\
                 varying highp vec4 v_coord;\n\
                 void main (void)\n\
                 {\n\
                 \x20   gl_Position = a_position;\n\
                 \x20   v_coord = a_position;\n\
                 }\n"
                .to_string(),
                format!(
                    "uniform mediump int u_numIters;\n\
                     varying mediump vec4 v_coord;\n\
                     void main (void)\n\
                     {{\n\
                     \x20   highp vec4 color = v_coord;\n\
                     \x20   for (int i = 0; i < {NUM_ITERS_IN_SHADER_ES2}; i++)\n\
                     \x20       color = sin(color);\n\
                     \x20   gl_FragColor = color;\n\
                     }}\n"
                ),
            ),
            FlushFinishEs::Es3 => (
                "#version 300 es\n\
                 in highp vec4 a_position;\n\
                 out highp vec4 v_coord;\n\
                 void main (void)\n\
                 {\n\
                 \x20   gl_Position = a_position;\n\
                 \x20   v_coord = a_position;\n\
                 }\n"
                .to_string(),
                "#version 300 es\n\
                 uniform highp int u_numIters;\n\
                 in highp vec4 v_coord;\n\
                 out mediump vec4 o_color;\n\
                 void main (void)\n\
                 {\n\
                 \x20   highp vec4 color = v_coord;\n\
                 \x20   for (int i = 0; i < u_numIters; i++)\n\
                 \x20       color = sin(color);\n\
                 \x20   o_color = color;\n\
                 }\n"
                .to_string(),
            ),
        };

        let program = ShaderProgram::new(context.gl(), &ProgramSources::vtx_frag(&vert, &frag));
        if !program.is_ok() {
            return Err(TestError::Fail("Compile failed".to_string()));
        }
        Ok(program)
    }

    fn wait_for_gl(&self, context: &Context) {
        let gl = context.gl();
        let wait_ms = self.es.consts().wait_time_ms;
        // SAFETY: argument-less synchronisation calls with a current context.
        unsafe {
            match self.kind {
                WaitKind::Wait => busy_wait(wait_ms),
                WaitKind::Flush => gl.flush(),
                WaitKind::FlushWait => {
                    gl.flush();
                    busy_wait(wait_ms);
                }
                WaitKind::Finish => gl.finish(),
                WaitKind::FinishWait => {
                    gl.finish();
                    busy_wait(wait_ms);
                }
            }
        }
    }

    /// `FlushFinishCase::setupRenderState`
    fn setup_render_state(&self, r: &Rendering<'_>) -> Result<(), TestError> {
        let gl = r.context.gl();
        let render_target = r.context.render_target();
        let max = self.es.consts().max_viewport_size;
        // SAFETY: a program this case built.
        let pos_loc = unsafe { gl.get_attrib_location(r.program.program(), c"a_position".as_ptr()) };
        let viewport_w = render_target.width.min(max);
        let viewport_h = render_target.height.min(max);

        static S_POSITIONS: [f32; 8] = [-1.0, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0];

        if pos_loc < 0 {
            return Err(TestError::Fail("a_position is not an active attribute".to_string()));
        }

        // SAFETY: client-side vertex data in a static array that outlives every draw.
        unsafe {
            gl.viewport(0, 0, viewport_w, viewport_h);
            gl.use_program(r.program.program());
            gl.enable_vertex_attrib_array(pos_loc as u32);
            gl.vertex_attrib_pointer(
                pos_loc as u32,
                2,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                S_POSITIONS.as_ptr().cast(),
            );
            gl.enable(glw::GL_BLEND);
            gl.blend_func(glw::GL_ONE, glw::GL_ONE);
            gl.blend_equation(glw::GL_FUNC_ADD);
        }
        crate::glu::expect_no_error(gl, "Failed to set up render state")
    }

    fn set_shader_iter_count(&self, r: &Rendering<'_>, num_iters: i32) {
        if self.es == FlushFinishEs::Es3 {
            // SAFETY: a uniform location of the program in use.
            unsafe { r.context.gl().uniform_1i(r.iter_count_loc, num_iters) };
        }
    }

    /// `FlushFinishCase::render`
    fn render(&self, r: &Rendering<'_>, num_draw_calls: i32) {
        let gl = r.context.gl();
        const INDICES: [u8; 6] = [0, 1, 2, 2, 1, 3];

        // SAFETY: client-side index data in a static array.
        unsafe {
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
            for _ in 0..num_draw_calls {
                gl.draw_elements(
                    glw::GL_TRIANGLES,
                    INDICES.len() as i32,
                    glw::GL_UNSIGNED_BYTE,
                    INDICES.as_ptr().cast(),
                );
            }
        }
    }

    /// `FlushFinishCase::readPixels`
    fn read_pixels(&self, r: &Rendering<'_>) {
        let mut tmp = [0u8; 4];
        // SAFETY: a 1x1 RGBA8 readback into a 4-byte array.
        unsafe {
            r.context
                .gl()
                .read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, tmp.as_mut_ptr().cast())
        };
        std::hint::black_box(tmp);
    }

    /// Doubling search up to `target_us`, then the linear estimate upstream uses; shared by
    /// both calibration steps. `time_one` renders `count` units and returns the end time and
    /// the read duration.
    fn search_count(
        &self,
        target_us: u64,
        max_count: i32,
        calibrate_start: u64,
        abort_after_us: Option<u64>,
        mut time_one: impl FnMut(i32) -> (u64, u64),
    ) -> Result<i32, CalibrationFailed> {
        let mut prev_duration = 0u64;
        let mut prev_count = 1i32;
        let mut cur_count = 1i32;

        loop {
            let (end_time, cur_duration) = time_one(cur_count);

            if cur_duration > target_us {
                if cur_count > 1 {
                    // Compute final count by using linear estimation.
                    let a = (cur_duration as i64 - prev_duration as i64) as f32 / (cur_count - prev_count) as f32;
                    let b = prev_duration as f32 - a * prev_count as f32;
                    let est = (target_us as f32 - b) / a;

                    cur_count = (est.floor() as i32).clamp(1, max_count);
                }
                // else: Settle on 1.
                return Ok(cur_count);
            } else if cur_count >= max_count {
                return Ok(cur_count); // Settle on maximum.
            } else if abort_after_us.is_some_and(|limit| end_time - calibrate_start > limit) {
                // Calibration is taking longer than expected. This can be due to eager draw call execution.
                return Err(CalibrationFailed(
                    "Calibration failed, target duration not reached within expected time".to_string(),
                ));
            } else {
                prev_count = cur_count;
                prev_duration = cur_duration;
                cur_count *= 2;
            }
        }
    }

    /// `FlushFinishCase::calibrate`
    fn calibrate(&self, r: &Rendering<'_>) -> Result<CalibrationParams, CalibrationFailed> {
        let consts = self.es.consts();
        let calibrate_start = get_microseconds();
        let max_calibrate_duration_us = WATCHDOG_INTERVAL_S / 3 * 1000 * 1000;
        let mut params = CalibrationParams::default();

        if self.es == FlushFinishEs::Es3 {
            // Step 1: find iteration count that results in rougly 1/10th of target maximum sample duration.
            let target_duration_us = consts.max_sample_duration_us / 100;
            params.num_iters_in_shader = self.search_count(
                target_duration_us,
                MAX_SHADER_ITER_COUNT,
                calibrate_start,
                Some(max_calibrate_duration_us),
                |count| {
                    self.set_shader_iter_count(r, count);
                    self.render(r, 1); // Submit time is ignored
                    let start_time = get_microseconds();
                    self.read_pixels(r);
                    let end_time = get_microseconds();
                    (end_time, end_time - start_time)
                },
            )?;
        } else {
            params.num_iters_in_shader = NUM_ITERS_IN_SHADER_ES2;
        }

        // Step 2 (the only step in ES 2.0): find draw call count that results in desired maximum time.
        self.set_shader_iter_count(r, params.num_iters_in_shader);
        let abort = if self.es == FlushFinishEs::Es3 {
            Some(max_calibrate_duration_us)
        } else {
            None
        };
        params.max_draw_calls = self.search_count(
            consts.max_sample_duration_us,
            MAX_DRAW_CALL_COUNT,
            calibrate_start,
            abort,
            |count| {
                self.render(r, count); // Submit time is ignored
                let start_time = get_microseconds();
                self.read_pixels(r);
                let end_time = get_microseconds();
                (end_time, end_time - start_time)
            },
        )?;

        // Quick check.
        if params.max_draw_calls < MIN_DRAW_CALL_COUNT {
            return Err(CalibrationFailed(
                "Calibration failed, maximum draw call count is too low".to_string(),
            ));
        }

        Ok(params)
    }

    /// `FlushFinishCase::verifyCalibration`
    fn verify_calibration(&self, r: &Rendering<'_>, params: &CalibrationParams) -> Result<(), CalibrationFailed> {
        self.set_shader_iter_count(r, params.num_iters_in_shader);

        for _ in 0..NUM_VERIFICATION_SAMPLES {
            self.render(r, params.max_draw_calls);

            let read_start_time = get_microseconds();
            self.read_pixels(r);

            let render_duration = get_microseconds() - read_start_time;
            let relative_delta = (render_duration as f64 / self.es.consts().max_sample_duration_us as f64) as f32 - 1.0;

            if !(-CALIBRATION_VERIFICATION_THRESHOLD..CALIBRATION_VERIFICATION_THRESHOLD).contains(&relative_delta) {
                return Err(CalibrationFailed(format!(
                    "ERROR: Unstable performance, got {render_duration} us read time, {:.1}% diff to estimated {} us",
                    relative_delta * 100.0,
                    self.es.consts().max_sample_duration_us
                )));
            }
        }
        Ok(())
    }

    /// `FlushFinishCase::analyzeResults`
    fn analyze_results(&self, samples: &[Sample], calibration_params: &CalibrationParams) -> TestStatus {
        let consts = self.es.consts();
        let wait_times: Vec<[f32; 2]> = samples
            .iter()
            .map(|s| [s.num_draw_calls as f32, s.wait_time as f32])
            .collect();
        let read_times: Vec<[f32; 2]> = samples
            .iter()
            .map(|s| [s.num_draw_calls as f32, s.read_pixels_time as f32])
            .collect();
        let wait_line = theil_sen_linear_regression(&wait_times);
        let read_line = theil_sen_linear_regression(&read_times);
        let norm_wait_coef =
            wait_line.coefficient * calibration_params.max_draw_calls as f32 / consts.max_sample_duration_us as f32;
        let norm_read_coef =
            read_line.coefficient * calibration_params.max_draw_calls as f32 / consts.max_sample_duration_us as f32;
        let mut all_ok = true;

        for ndx in 0..2 {
            let coef = if ndx == 0 { norm_wait_coef } else { norm_read_coef };
            let behavior = if ndx == 0 {
                self.wait_behavior
            } else {
                self.read_behavior
            };
            let threshold = if ndx == 0 {
                self.wait_threshold
            } else {
                self.read_threshold
            };
            let is_ok = match behavior {
                ExpectedBehavior::CoefGreaterThan => coef > threshold,
                ExpectedBehavior::CoefLessThan => coef < threshold,
            };

            if !is_ok {
                all_ok = false;
            }
        }

        if all_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::new(TestResult::CompatibilityWarning, "Suspicious performance behavior")
        }
    }
}

impl TestCase for FlushFinishCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let consts = self.es.consts();
        let mut samples = vec![Sample::default(); consts.num_samples];

        let program = self.build_program(context)?;
        let iter_count_loc = if self.es == FlushFinishEs::Es3 {
            // SAFETY: a program this case built.
            let loc = unsafe {
                context
                    .gl()
                    .get_uniform_location(program.program(), c"u_numIters".as_ptr())
            };
            if loc < 0 {
                return Err(TestError::Fail("u_numIters is not an active uniform".to_string()));
            }
            loc
        } else {
            0
        };
        let r = Rendering {
            context,
            program,
            iter_count_loc,
        };

        // `tcu::warmupCPU`
        busy_wait(50);

        self.setup_render_state(&r)?;

        // Do one full render cycle.
        self.set_shader_iter_count(&r, 1);
        self.render(&r, 1);
        self.read_pixels(&r);

        // Calibrate.
        let params = if self.es == FlushFinishEs::Es3 {
            let mut calibration_round_ndx = 0;
            loop {
                let attempt = self
                    .calibrate(&r)
                    .and_then(|params| self.verify_calibration(&r, &params).map(|()| params));
                match attempt {
                    Ok(params) => break params,
                    Err(CalibrationFailed(reason)) => {
                        if calibration_round_ndx >= MAX_CALIBRATION_ATTEMPTS {
                            return Ok(TestStatus::new(TestResult::CompatibilityWarning, reason));
                        }
                        calibration_round_ndx += 1;
                    }
                }
            }
        } else {
            match self.calibrate(&r) {
                Ok(params) => params,
                Err(CalibrationFailed(reason)) => return Ok(TestStatus::new(TestResult::CompatibilityWarning, reason)),
            }
        };

        // Do measurement.
        {
            let mut rnd = Random::new(123);

            self.set_shader_iter_count(&r, params.num_iters_in_shader);

            for sample in &mut samples {
                let draw_call_count = rnd.get_int(1, params.max_draw_calls);
                let submit_start_time = get_microseconds();

                self.render(&r, draw_call_count);

                let wait_start_time = get_microseconds();
                self.wait_for_gl(context);

                let read_start_time = get_microseconds();
                self.read_pixels(&r);
                let read_finish_time = get_microseconds();

                sample.num_draw_calls = draw_call_count;
                sample.submit_time = wait_start_time - submit_start_time;
                sample.wait_time = read_start_time - wait_start_time;
                sample.read_pixels_time = read_finish_time - read_start_time;
            }
        }

        // Analyze - sets test case result.
        Ok(self.analyze_results(&samples, &params))
    }
}

/// `FlushFinishTests::init`
pub fn create_tests(es: FlushFinishEs) -> TestCaseGroup {
    use ExpectedBehavior::{CoefGreaterThan, CoefLessThan};

    let corr = es.consts().corr_threshold;
    let cases = [
        // name, kind, wait behaviour, wait threshold, read behaviour, read threshold
        (
            "wait",
            WaitKind::Wait,
            CoefLessThan,
            NO_CORR_COEF_THRESHOLD,
            CoefGreaterThan,
            -1000.0, /* practically nothing is expected */
        ),
        (
            "flush",
            WaitKind::Flush,
            CoefLessThan,
            FLUSH_COEF_THRESHOLD,
            CoefGreaterThan,
            corr,
        ),
        (
            "flush_wait",
            WaitKind::FlushWait,
            CoefLessThan,
            FLUSH_COEF_THRESHOLD,
            CoefLessThan,
            NO_CORR_COEF_THRESHOLD,
        ),
        (
            "finish",
            WaitKind::Finish,
            CoefGreaterThan,
            corr,
            CoefLessThan,
            NO_CORR_COEF_THRESHOLD,
        ),
        (
            "finish_wait",
            WaitKind::FinishWait,
            CoefGreaterThan,
            corr,
            CoefLessThan,
            NO_CORR_COEF_THRESHOLD,
        ),
    ];

    let mut group = TestCaseGroup::new("flush_finish");
    for (name, kind, wait_behavior, wait_threshold, read_behavior, read_threshold) in cases {
        group.add_child(boxed(FlushFinishCase {
            es,
            name,
            kind,
            wait_behavior,
            wait_threshold,
            read_behavior,
            read_threshold,
        }));
    }
    group
}
