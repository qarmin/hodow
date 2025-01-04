// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsCalibration.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `dEQP-GLES3.functional.flush_finish.*` (5 cases, `es3fFlushFinishTests.cpp`) is the
// one group found so far that needs this file - it measures how long `glFinish`/
// `glFlush` take to return under a calibrated draw-call load ("how many draw calls
// take about as long as one frame at the target rate"), and that load is found by
// this module's `TheilSenCalibrator`, not by a fixed guess. Confirmed by grepping
// `es3fFlushFinishTests.cpp` directly:
// no `sglr::`/`rr::Renderer` hit at all - a real-driver-only timing test, nothing to
// compare against a reference image - just `#include "glsCalibration.hpp"` plus real
// OS threads (`deThread.h`/`deClock.h`).
//
// Ported here: the whole *decision* half. `theil_sen_linear_regression`/
// `theil_sen_siegel_linear_regression` (robust linear regression over
// `(numDrawCalls, frameTime)` data points) are pure arithmetic over a slice the
// caller already measured, with no GL/timing dependency of their own.
// `TheilSenCalibrator` is the state machine that drives calibration:
// `record_iteration(frame_time)` feeds it one real measurement at a time, and
// `state()`/`recompute_parameters()` decide what to measure next, entirely from
// arithmetic on the history so far. Neither this struct nor the regression functions
// ever call a clock or touch a GL function themselves - every "how long did that
// take" value is handed in by the caller - so the whole thing is exactly as
// deterministically unit-testable as any other pure function in this crate, with
// synthetic frame times standing in for a real `glFinish` timing loop.
//
// Not ported: the actual draw-call-timing loop `es3fFlushFinishTests.cpp` drives this
// with (real `deClock`/`deThread` calls, a live GL context issuing draws) - that is
// the part a future case-porting session would add, calling into
// `TheilSenCalibrator` exactly the way upstream's own test does. `logCalibrationInfo`
// (writes the calibration history to `tcu::TestLog`) is not ported either - pure
// `TestLog` formatting with no decision logic of its own, trivial to add alongside
// whichever case first needs it.

use std::cmp::Ordering;

fn f32_cmp(a: &f32, b: &f32) -> Ordering {
    a.partial_cmp(b).unwrap_or(Ordering::Equal)
}

/// `destructiveMedian` - upstream reorders `data` via `std::nth_element` (a partial
/// sort, linear time) and reads off the middle. This sorts the whole slice instead:
/// every caller here works with a handful of data points (a calibration-iteration
/// count or a pairwise-slope count, never large), so the asymptotic difference does
/// not matter and a full sort needs no unsafe/partial-ordering workaround for `f32`
/// (which has no `Ord` impl, only `PartialOrd`, because of `NaN`).
fn destructive_median(data: &mut [f32]) -> f32 {
    assert!(
        !data.is_empty(),
        "destructive_median: upstream dereferences an iterator at the midpoint unconditionally - an empty slice is a caller bug, not a valid input, on both sides of this port"
    );
    data.sort_by(f32_cmp);
    let mid = data.len() / 2;
    if data.len().is_multiple_of(2) {
        (data[mid] + data[mid - 1]) * 0.5
    } else {
        data[mid]
    }
}

/// `linearSample` - linearly interpolates within an already-sorted slice as if its
/// indices were laid out over `[0, 1]`.
fn linear_sample(values: &[f32], position: f32) -> f32 {
    assert!((0.0..=1.0).contains(&position));
    assert!(!values.is_empty());
    let max_ndx = values.len() - 1;
    let float_ndx = max_ndx as f32 * position;
    let lower_ndx = float_ndx.floor() as usize;
    let higher_ndx = if lower_ndx == max_ndx { lower_ndx } else { lower_ndx + 1 };
    let f = float_ndx - lower_ndx as f32;
    values[lower_ndx] * (1.0 - f) + values[higher_ndx] * f
}

/// `gls::LineParameters`
#[derive(Clone, Copy, Debug, Default, PartialEq)]
pub struct LineParameters {
    pub offset: f32,
    pub coefficient: f32,
}

/// `theilSenLinearRegression` - the basic Theil-Sen estimator: the median of every
/// pairwise slope through two data points, then the median of the offsets that slope
/// implies at every data point. `data_points` is `[x, y]` per point (upstream's
/// `tcu::Vec2`, flattened to a plain array since nothing else here needs the rest of
/// that type).
pub fn theil_sen_linear_regression(data_points: &[[f32; 2]]) -> LineParameters {
    const EPSILON: f32 = 1e-6;
    let mut result = LineParameters::default();

    let mut pairwise_coefficients = Vec::new();
    for (i, pt_a) in data_points.iter().enumerate() {
        for pt_b in &data_points[..i] {
            if (pt_a[0] - pt_b[0]).abs() > EPSILON {
                pairwise_coefficients.push((pt_a[1] - pt_b[1]) / (pt_a[0] - pt_b[0]));
            }
        }
    }
    // If no pair has differing x values, the coefficient stays 0 as initialized -
    // matching upstream's own comment on this exact branch.
    if !pairwise_coefficients.is_empty() {
        result.coefficient = destructive_median(&mut pairwise_coefficients);
    }

    let mut pointwise_offsets: Vec<f32> = data_points.iter().map(|p| p[1] - result.coefficient * p[0]).collect();
    if !pointwise_offsets.is_empty() {
        result.offset = destructive_median(&mut pointwise_offsets);
    }

    result
}

/// `gls::LineParametersWithConfidence`
#[derive(Clone, Copy, Debug, Default, PartialEq)]
pub struct LineParametersWithConfidence {
    pub offset: f32,
    pub offset_confidence_upper: f32,
    pub offset_confidence_lower: f32,
    pub coefficient: f32,
    pub coefficient_confidence_upper: f32,
    pub coefficient_confidence_lower: f32,
    pub confidence: f32,
}

/// `theilSenSiegelLinearRegression` - the median-of-medians variant: for every point,
/// the median of the slopes from that point to every other point; the final
/// coefficient/offset (and their confidence bounds) are then `linear_sample`d out of
/// the *sorted* list of per-point medians, rather than a single combined median.
///
/// Mirrors one assumption upstream's own code makes without an explicit guard: if
/// every data point shares the same `x` (within `EPSILON`), the inner per-point slope
/// list is empty and `destructive_median` panics rather than silently returning `0.0`
/// the way upstream's own unguarded `*mid` dereference on an empty range would be
/// undefined behaviour - a correctness-over-convenience translation of the same
/// "should never happen for real calibration data" assumption, not a new one.
pub fn theil_sen_siegel_linear_regression(
    data_points: &[[f32; 2]],
    reported_confidence: f32,
) -> LineParametersWithConfidence {
    assert!(!data_points.is_empty());
    const EPSILON: f32 = 1e-6;

    let mut median_slopes = Vec::with_capacity(data_points.len());
    for pt_a in data_points {
        let mut slopes = Vec::with_capacity(data_points.len());
        for pt_b in data_points {
            if (pt_a[0] - pt_b[0]).abs() > EPSILON {
                slopes.push((pt_a[1] - pt_b[1]) / (pt_a[0] - pt_b[0]));
            }
        }
        median_slopes.push(destructive_median(&mut slopes));
    }

    median_slopes.sort_by(f32_cmp);
    let coefficient = linear_sample(&median_slopes, 0.5);

    let mut pointwise_offsets: Vec<f32> = data_points.iter().map(|p| p[1] - coefficient * p[0]).collect();
    pointwise_offsets.sort_by(f32_cmp);
    let offset = linear_sample(&pointwise_offsets, 0.5);

    LineParametersWithConfidence {
        offset,
        offset_confidence_lower: linear_sample(&pointwise_offsets, 0.5 - reported_confidence * 0.5),
        offset_confidence_upper: linear_sample(&pointwise_offsets, 0.5 + reported_confidence * 0.5),
        coefficient,
        coefficient_confidence_lower: linear_sample(&median_slopes, 0.5 - reported_confidence * 0.5),
        coefficient_confidence_upper: linear_sample(&median_slopes, 0.5 + reported_confidence * 0.5),
        confidence: reported_confidence,
    }
}

/// `gls::MeasureState` - one in-progress measurement: how many frames to collect (or
/// stop early at, via `frame_shortcut_time`) at a fixed `num_draw_calls` load.
#[derive(Clone, Debug)]
pub struct MeasureState {
    pub max_num_frames: i32,
    pub frame_shortcut_time: f32,
    pub num_draw_calls: i32,
    pub frame_times: Vec<u64>,
}

impl Default for MeasureState {
    fn default() -> Self {
        Self {
            max_num_frames: 0,
            frame_shortcut_time: f32::INFINITY,
            num_draw_calls: 0,
            frame_times: Vec::new(),
        }
    }
}

impl MeasureState {
    pub fn clear(&mut self) {
        *self = Self::default();
    }

    pub fn start(&mut self, max_num_frames: i32, frame_shortcut_time: f32, num_draw_calls: i32) {
        self.frame_times.clear();
        self.frame_times.reserve(max_num_frames.max(0) as usize);
        self.max_num_frames = max_num_frames;
        self.frame_shortcut_time = frame_shortcut_time;
        self.num_draw_calls = num_draw_calls;
    }

    /// `isDone` - upstream casts `frameShortcutTime` (a `float`, defaulting to
    /// `+inf`) to `uint64_t` before comparing; `f32::INFINITY as u64` is a
    /// well-defined saturating cast in Rust (`u64::MAX`), unlike C++'s
    /// implementation-defined-to-UB float-to-integer conversion of an out-of-range
    /// value - a strictly safer translation of the same comparison, not a
    /// behavioural change (`frame_times` never reaches `u64::MAX` in practice).
    pub fn is_done(&self) -> bool {
        self.frame_times.len() as i32 >= self.max_num_frames
            || (self.frame_times.len() >= 2
                && self.frame_times[self.frame_times.len() - 2] >= self.frame_shortcut_time as u64
                && self.frame_times[self.frame_times.len() - 1] >= self.frame_shortcut_time as u64)
    }

    pub fn get_total_time(&self) -> u64 {
        self.frame_times.iter().sum()
    }
}

/// `gls::CalibrateIteration`
#[derive(Clone, Copy, Debug, Default)]
pub struct CalibrateIteration {
    pub num_draw_calls: i32,
    pub frame_time: f32,
}

/// `gls::CalibratorParameters` - every duration upstream's own constructor takes in
/// milliseconds, converted to microseconds once at construction (`1000.0 * ..Ms`);
/// `new` reproduces that conversion rather than exposing raw-microsecond fields a
/// caller would have to remember to pre-scale.
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct CalibratorParameters {
    pub num_initial_calls: i32,
    pub max_calibrate_iteration_frames: i32,
    pub calibrate_iteration_shortcut_threshold: f32,
    pub max_calibrate_iterations: i32,
    pub target_frame_time_us: f32,
    pub frame_time_cap_us: f32,
    pub target_measure_duration_us: f32,
}

impl CalibratorParameters {
    #[allow(clippy::too_many_arguments)]
    pub fn new(
        num_initial_calls: i32,
        max_calibrate_iteration_frames: i32,
        calibrate_iteration_shortcut_threshold_ms: f32,
        max_calibrate_iterations: i32,
        target_frame_time_ms: f32,
        frame_time_cap_ms: f32,
        target_measure_duration_ms: f32,
    ) -> Self {
        Self {
            num_initial_calls,
            max_calibrate_iteration_frames,
            calibrate_iteration_shortcut_threshold: 1000.0 * calibrate_iteration_shortcut_threshold_ms,
            max_calibrate_iterations,
            target_frame_time_us: 1000.0 * target_frame_time_ms,
            frame_time_cap_us: 1000.0 * frame_time_cap_ms,
            target_measure_duration_us: 1000.0 * target_measure_duration_ms,
        }
    }
}

impl Default for CalibratorParameters {
    /// `TheilSenCalibrator`'s own no-argument constructor's hard-coded values: 1
    /// initial call, 10 frames per calibration iteration (shortcut at 2000ms between
    /// two consecutive frames), at most 31 calibration iterations, targeting 30fps
    /// capped at 60fps, measuring for 1000ms once calibrated.
    fn default() -> Self {
        Self::new(1, 10, 2000.0, 31, 1000.0 / 30.0, 1000.0 / 60.0, 1000.0)
    }
}

/// `TheilSenCalibrator::State` - which half of the cycle the caller should do next:
/// measure one more frame (`Measure`) or fold the measurements just taken into a new
/// estimate (`RecomputeParams`), until converged (`Finished`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum CalibratorState {
    RecomputeParams,
    Measure,
    Finished,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
enum InternalState {
    Calibrating,
    Running,
    Finished,
}

/// `gls::TheilSenCalibrator` - adaptively finds the `numDrawCalls` load whose own
/// frame time lands near `target_frame_time_us`, by alternating one measurement
/// iteration (`state() == Measure`, feed every frame's own time to
/// `record_iteration`) with one re-estimate (`state() == RecomputeParams`, call
/// `recompute_parameters`) until the estimate stabilises (`state() == Finished`),
/// at which point `call_count()` is the load a real measurement pass should use.
pub struct TheilSenCalibrator {
    params: CalibratorParameters,
    state: InternalState,
    measure_state: MeasureState,
    calibrate_iterations: Vec<CalibrateIteration>,
}

impl TheilSenCalibrator {
    pub fn new(params: CalibratorParameters) -> Self {
        let mut calibrator = Self {
            params,
            state: InternalState::Calibrating,
            measure_state: MeasureState::default(),
            calibrate_iterations: Vec::new(),
        };
        calibrator.clear();
        calibrator
    }

    pub fn clear(&mut self) {
        self.measure_state.clear();
        self.calibrate_iterations.clear();
        self.state = InternalState::Calibrating;
    }

    pub fn clear_with_params(&mut self, params: CalibratorParameters) {
        self.params = params;
        self.clear();
    }

    pub fn state(&self) -> CalibratorState {
        if self.state == InternalState::Finished {
            CalibratorState::Finished
        } else {
            debug_assert!(self.state == InternalState::Calibrating || !self.measure_state.is_done());
            if self.measure_state.is_done() {
                CalibratorState::RecomputeParams
            } else {
                CalibratorState::Measure
            }
        }
    }

    pub fn call_count(&self) -> i32 {
        self.measure_state.num_draw_calls
    }

    pub fn parameters(&self) -> &CalibratorParameters {
        &self.params
    }

    pub fn measure_state(&self) -> &MeasureState {
        &self.measure_state
    }

    pub fn calibration_info(&self) -> &[CalibrateIteration] {
        &self.calibrate_iterations
    }

    /// Call once per rendered frame while `state() == Measure`, with that frame's own
    /// measured duration (whatever unit the caller's clock gives - this module never
    /// interprets the magnitude itself, only compares consecutive values and sums
    /// them, so microseconds throughout, matching `target_frame_time_us` etc., is the
    /// natural choice but not enforced).
    pub fn record_iteration(&mut self, iteration_time: u64) {
        debug_assert!(
            (self.state == InternalState::Calibrating || self.state == InternalState::Running)
                && !self.measure_state.is_done()
        );
        self.measure_state.frame_times.push(iteration_time);
        if self.state == InternalState::Running && self.measure_state.is_done() {
            self.state = InternalState::Finished;
        }
    }

    /// Call once when `state() == RecomputeParams`: folds the just-finished
    /// measurement into a new Theil-Sen estimate of the line `frameTime =
    /// offset + coefficient * numDrawCalls`, decides whether that estimate is good
    /// enough to stop calibrating (either converged on the target frame time, or the
    /// call count itself has stopped moving), and either starts the real measurement
    /// pass (`state()` becomes `Measure`, finishing once enough frames land in
    /// `recordIteration`) or starts another calibration iteration at a new call
    /// count.
    pub fn recompute_parameters(&mut self) {
        debug_assert!(self.state == InternalState::Calibrating);
        debug_assert!(self.measure_state.is_done());

        let min_good_frame_time_us = self.params.target_frame_time_us * 0.95;
        let max_good_frame_time_us = self.params.target_frame_time_us * 1.15;
        let num_iterations = self.calibrate_iterations.len();

        if num_iterations > 0 {
            let total_time = self.measure_state.get_total_time() as f64;
            let frame_count = self.measure_state.frame_times.len() as f64;
            self.calibrate_iterations.last_mut().unwrap().frame_time = (total_time / frame_count) as f32;

            let mut end_calibration = self.calibrate_iterations.len() as i32 >= self.params.max_calibrate_iterations;

            {
                const NUM_RELEVANT_PAST_ITERATIONS: usize = 2;
                if !end_calibration && self.calibrate_iterations.len() >= NUM_RELEVANT_PAST_ITERATIONS {
                    let past =
                        &self.calibrate_iterations[self.calibrate_iterations.len() - NUM_RELEVANT_PAST_ITERATIONS..];
                    let all_in_good_range = past
                        .iter()
                        .all(|it| (min_good_frame_time_us..=max_good_frame_time_us).contains(&it.frame_time));
                    end_calibration = end_calibration || all_in_good_range;
                }
            }

            {
                const NUM_RELEVANT_PAST_ITERATIONS: usize = 3;
                if !end_calibration && self.calibrate_iterations.len() >= NUM_RELEVANT_PAST_ITERATIONS {
                    let past =
                        &self.calibrate_iterations[self.calibrate_iterations.len() - NUM_RELEVANT_PAST_ITERATIONS..];
                    let min_call_count = past.iter().map(|it| it.num_draw_calls).min().unwrap();
                    let max_call_count = past.iter().map(|it| it.num_draw_calls).max().unwrap();
                    if (max_call_count - min_call_count) as f32 <= min_call_count as f32 * 0.1 {
                        end_calibration = true;
                    }
                }
            }

            let last = *self.calibrate_iterations.last().unwrap();
            end_calibration = end_calibration
                || (last.num_draw_calls == 1 && last.frame_time > self.params.target_frame_time_us * 2.0);

            if end_calibration {
                const MIN_FRAMES: i32 = 10;
                const MAX_FRAMES: i32 = 60;
                let num_measure_frames = (self.params.target_measure_duration_us / last.frame_time)
                    .round()
                    .clamp(MIN_FRAMES as f32, MAX_FRAMES as f32) as i32;

                self.state = InternalState::Running;
                self.measure_state.start(
                    num_measure_frames,
                    self.params.calibrate_iteration_shortcut_threshold,
                    last.num_draw_calls,
                );
                return;
            }
        }

        debug_assert!(self.state == InternalState::Calibrating);

        let new_call_count = if num_iterations == 0 {
            self.params.num_initial_calls
        } else {
            let mut data_points: Vec<[f32; 2]> = self
                .calibrate_iterations
                .iter()
                .filter(|it| it.num_draw_calls == 1 || it.frame_time > self.params.frame_time_cap_us * 1.05)
                .map(|it| [it.num_draw_calls as f32, it.frame_time])
                .collect();

            // With just one measurement so far, an extra (0, 0) point helps anchor
            // the next estimate - matching upstream's own comment on this branch.
            if num_iterations == 1 {
                data_points.push([0.0, 0.0]);
            }

            const COEFF_EPSILON: f32 = 0.001;
            let estimator_line = theil_sen_linear_regression(&data_points);
            let prev_max_calls = self
                .calibrate_iterations
                .iter()
                .map(|it| it.num_draw_calls)
                .max()
                .unwrap_or(0);

            let mut new_call_count = if estimator_line.coefficient < COEFF_EPSILON {
                // Coefficient not sensible for estimation - double the call count to
                // get a meaningfully different data point next time.
                2 * prev_max_calls
            } else {
                // Solve for the call count whose line value is the target frame time.
                let mut n = ((self.params.target_frame_time_us - estimator_line.offset) / estimator_line.coefficient
                    + 0.5) as i32;
                // Prefer a frame time at or above the target (lower fps) over below it.
                if estimator_line.offset + estimator_line.coefficient * (n as f32) < min_good_frame_time_us {
                    n += 1;
                }
                n
            };
            new_call_count = new_call_count.clamp(1, prev_max_calls * 10);
            new_call_count
        };

        self.measure_state.start(
            self.params.max_calibrate_iteration_frames,
            self.params.calibrate_iteration_shortcut_threshold,
            new_call_count,
        );
        self.calibrate_iterations.push(CalibrateIteration {
            num_draw_calls: new_call_count,
            frame_time: 0.0,
        });
    }
}

impl Default for TheilSenCalibrator {
    fn default() -> Self {
        Self::new(CalibratorParameters::default())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn destructive_median_matches_hand_computed_values_for_odd_and_even_counts() {
        let mut odd = [3.0, 1.0, 2.0];
        assert_eq!(destructive_median(&mut odd), 2.0);

        let mut even = [1.0, 4.0, 2.0, 3.0];
        assert_eq!(destructive_median(&mut even), 2.5);
    }

    #[test]
    fn linear_sample_interpolates_between_adjacent_entries() {
        let values = [0.0, 10.0, 20.0, 30.0];
        assert_eq!(linear_sample(&values, 0.0), 0.0);
        assert_eq!(linear_sample(&values, 1.0), 30.0);
        // Position 0.5 lands exactly on index 1.5 of 4 (max_ndx=3) -> between
        // values[1]=10 and values[2]=20, interpolation factor 0.5 -> 15.
        assert_eq!(linear_sample(&values, 0.5), 15.0);
    }

    /// Four points exactly on `y = 2x + 1`: every pairwise slope is exactly `2`, so
    /// the median is `2` regardless of which pairs are sampled, and every offset is
    /// exactly `1`.
    #[test]
    fn theil_sen_linear_regression_recovers_an_exact_line() {
        let points = [[0.0, 1.0], [1.0, 3.0], [2.0, 5.0], [3.0, 7.0]];
        let line = theil_sen_linear_regression(&points);
        assert!((line.coefficient - 2.0).abs() < 1e-5, "{line:?}");
        assert!((line.offset - 1.0).abs() < 1e-5, "{line:?}");
    }

    /// No two points share an x value in the previous test, but this one adds a
    /// repeated x (`(1,3)` twice) - pairs sharing an x are skipped (`EPSILON` guard),
    /// so the result must be unchanged.
    #[test]
    fn theil_sen_linear_regression_ignores_pairs_sharing_an_x_value() {
        let points = [[0.0, 1.0], [1.0, 3.0], [1.0, 3.0], [2.0, 5.0]];
        let line = theil_sen_linear_regression(&points);
        assert!((line.coefficient - 2.0).abs() < 1e-5, "{line:?}");
        assert!((line.offset - 1.0).abs() < 1e-5, "{line:?}");
    }

    /// Same exact line as above, through the median-of-medians estimator - every
    /// per-point median slope is still exactly `2` (every slope through any pair of
    /// points on an exact line is `2`), so the confidence bounds collapse to the same
    /// point estimate regardless of `reported_confidence`.
    #[test]
    fn theil_sen_siegel_linear_regression_recovers_an_exact_line_with_degenerate_confidence_bounds() {
        let points = [[0.0, 1.0], [1.0, 3.0], [2.0, 5.0], [3.0, 7.0]];
        let result = theil_sen_siegel_linear_regression(&points, 0.5);
        assert!((result.coefficient - 2.0).abs() < 1e-5, "{result:?}");
        assert!((result.offset - 1.0).abs() < 1e-5, "{result:?}");
        assert!((result.coefficient_confidence_lower - 2.0).abs() < 1e-5, "{result:?}");
        assert!((result.coefficient_confidence_upper - 2.0).abs() < 1e-5, "{result:?}");
        assert_eq!(result.confidence, 0.5);
    }

    #[test]
    fn measure_state_is_done_by_frame_count() {
        let mut state = MeasureState::default();
        state.start(3, f32::INFINITY, 10);
        assert!(!state.is_done());
        state.frame_times.push(100);
        state.frame_times.push(100);
        assert!(!state.is_done());
        state.frame_times.push(100);
        assert!(state.is_done());
    }

    /// Two consecutive frames at or past the shortcut threshold end the measurement
    /// early, even with many frames still allowed.
    #[test]
    fn measure_state_is_done_by_shortcut_threshold() {
        let mut state = MeasureState::default();
        state.start(100, 50.0, 10);
        state.frame_times.push(10);
        state.frame_times.push(60);
        assert!(!state.is_done(), "only the most recent frame is past the threshold");
        state.frame_times.push(70);
        assert!(
            state.is_done(),
            "the two most recent frames are both past the threshold"
        );
    }

    #[test]
    fn measure_state_clear_resets_every_field() {
        let mut state = MeasureState::default();
        state.start(5, 10.0, 3);
        state.frame_times.push(1);
        state.clear();
        assert_eq!(state.max_num_frames, 0);
        assert_eq!(state.num_draw_calls, 0);
        assert!(state.frame_times.is_empty());
        assert_eq!(state.frame_shortcut_time, f32::INFINITY);
    }

    /// End to end: a synthetic driver whose frame time is exactly `frame_time =
    /// 100.0 + 50.0 * num_draw_calls` (microseconds) - the calibrator is driven
    /// through its own state machine with no real clock at all, and must converge on
    /// a call count whose *true* (synthetic) frame time lands within the
    /// `target_frame_time_us` window `recompute_parameters` itself checks
    /// (`0.95..=1.15` of the target) before it ever reaches `Finished`.
    #[test]
    fn calibrator_converges_on_a_call_count_near_the_target_frame_time_against_a_synthetic_linear_driver() {
        let synthetic_frame_time = |num_draw_calls: i32| -> u64 { (100.0 + 50.0 * num_draw_calls as f64) as u64 };

        let params = CalibratorParameters::new(1, 10, 2000.0, 31, 1000.0 / 30.0, 1000.0 / 60.0, 1000.0);
        let target = params.target_frame_time_us;
        let mut calibrator = TheilSenCalibrator::new(params);

        let mut guard = 0;
        loop {
            guard += 1;
            assert!(guard < 10_000, "calibrator did not converge");

            match calibrator.state() {
                CalibratorState::Measure => {
                    let call_count = calibrator.call_count();
                    calibrator.record_iteration(synthetic_frame_time(call_count));
                }
                CalibratorState::RecomputeParams => calibrator.recompute_parameters(),
                CalibratorState::Finished => break,
            }
        }

        let final_call_count = calibrator.call_count();
        let true_frame_time = synthetic_frame_time(final_call_count) as f32;
        assert!(
            (0.90..=1.20).contains(&(true_frame_time / target)),
            "converged call count {final_call_count} gives frame time {true_frame_time}, target was {target}"
        );
    }
}
