// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fAtomicCounterTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The arithmetic in `check_path` and
// `check_uniqueness_and_linearity` is kept wrapping, as C++'s unsigned arithmetic is:
// a run where every value was masked out leaves `min_value > max_value`, and upstream's
// `maxValue - minValue + 1` wraps rather than trapping there.

use crate::glu::{self, Buffer, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::{TestOutcome, TestStatus};

/// `AtomicCounterTest::Operation`
const OPERATION_INC: u32 = 1 << 0;
const OPERATION_DEC: u32 = 1 << 1;
const OPERATION_GET: u32 = 1 << 2;

/// `AtomicCounterTest::OffsetType`
///
/// `Basic` is upstream's `OFFSETTYPE_BASIC`: it has shader-generation code but no test
/// registers it, and dropping it would renumber nothing but would make the re-sync diff
/// against `generateShaderSource` harder to read.
#[expect(
    dead_code,
    reason = "upstream declares and generates code for OFFSETTYPE_BASIC without registering a case"
)]
#[derive(Clone, Copy, PartialEq, Eq)]
enum OffsetType {
    None,
    Basic,
    Reverse,
    FirstAuto,
    DefaultAuto,
    ResetDefault,
    Invalid,
    InvalidOverlapping,
    InvalidDefault,
}

/// `AtomicCounterTest::BindingType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum BindingType {
    Basic,
    Invalid,
    InvalidDefault,
}

/// `AtomicCounterTest::TestSpec`
#[derive(Clone, Copy)]
struct TestSpec {
    atomic_counter_count: i32,
    operations: u32,
    call_count: i32,
    use_branches: bool,
    thread_count: i32,
    offset_type: OffsetType,
    binding_type: BindingType,
}

impl TestSpec {
    /// `AtomicCounterTest::getInitialValue`
    fn initial_value(&self) -> u32 {
        (self.call_count * self.thread_count + 1) as u32
    }

    /// `AtomicCounterTest::getOperationCount`
    fn operation_count(&self) -> i32 {
        let mut count = 0;

        if self.operations & OPERATION_INC != 0 {
            count += 1;
        }
        if self.operations & OPERATION_DEC != 0 {
            count += 1;
        }
        if self.operations == OPERATION_GET {
            count += 1;
        } else if self.operations & OPERATION_GET != 0 {
            count += 2;
        }

        count
    }

    /// True for the five specs whose shader is expected not to compile.
    fn expects_compile_failure(&self) -> bool {
        matches!(
            self.offset_type,
            OffsetType::Invalid | OffsetType::InvalidDefault | OffsetType::InvalidOverlapping
        ) || matches!(self.binding_type, BindingType::Invalid | BindingType::InvalidDefault)
    }

    /// Whether the shader emits a separate `preGet`/`postGet` pair rather than a single
    /// `get` array - upstream spells this `(operations & GET) != 0 && operations != GET`.
    fn has_pre_post_gets(&self) -> bool {
        self.operations & OPERATION_GET != 0 && self.operations != OPERATION_GET
    }
}

/// `AtomicCounterTest::generateShaderSource`
fn generate_shader_source(spec: &TestSpec) -> String {
    let mut src = String::from("#version 310 es\nlayout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n");

    // The default layout qualifier, where the spec asks for one.
    {
        let mut wrote_layout = false;

        if spec.binding_type == BindingType::InvalidDefault {
            src.push_str("layout(binding=10000");
            wrote_layout = true;
        }

        let default_offset = match spec.offset_type {
            OffsetType::DefaultAuto => Some(4),
            OffsetType::ResetDefault => Some(4 * spec.atomic_counter_count / 2),
            OffsetType::InvalidDefault => Some(1),
            _ => None,
        };

        if let Some(offset) = default_offset {
            src.push_str(if wrote_layout { ", " } else { "layout(binding=0, " });
            src.push_str(&format!("offset={offset}"));
            wrote_layout = true;
        }

        if wrote_layout {
            src.push_str(") uniform atomic_uint;\n");
        }
    }

    let array_len = spec.thread_count * spec.atomic_counter_count * spec.call_count;
    src.push_str("layout(binding = 1, std430) buffer Output {\n");

    if spec.has_pre_post_gets() {
        src.push_str(&format!("    uint preGet[{array_len}];\n"));
    }
    if spec.operations & OPERATION_INC != 0 {
        src.push_str(&format!("    uint increment[{array_len}];\n"));
    }
    if spec.operations & OPERATION_DEC != 0 {
        src.push_str(&format!("    uint decrement[{array_len}];\n"));
    }
    if spec.has_pre_post_gets() {
        src.push_str(&format!("    uint postGet[{array_len}];\n"));
    }
    if spec.operations == OPERATION_GET {
        src.push_str(&format!("    uint get[{array_len}];\n"));
    }

    src.push_str("} sb_in;\n\n");

    for counter_ndx in 0..spec.atomic_counter_count {
        let mut layout_started = false;

        if spec.offset_type == OffsetType::ResetDefault && counter_ndx == spec.atomic_counter_count / 2 {
            src.push_str("layout(binding=0, offset=0) uniform atomic_uint;\n");
        }

        match spec.binding_type {
            BindingType::Basic => {
                layout_started = true;
                src.push_str("layout(binding=0");
            }
            BindingType::Invalid => {
                layout_started = true;
                src.push_str("layout(binding=10000");
            }
            BindingType::InvalidDefault => {}
        }

        // `layout(` if nothing opened one yet, `, ` to continue the one that is open.
        let continue_layout = |src: &mut String| src.push_str(if layout_started { ", " } else { "layout(" });
        let close_layout = |src: &mut String| {
            if layout_started {
                src.push_str(") ");
            }
        };

        match spec.offset_type {
            OffsetType::None | OffsetType::InvalidDefault => {
                close_layout(&mut src);
                src.push_str(&format!("uniform atomic_uint counter{counter_ndx};\n"));
            }
            OffsetType::Basic => {
                continue_layout(&mut src);
                src.push_str(&format!(
                    "offset={}) uniform atomic_uint counter{counter_ndx};\n",
                    counter_ndx * 4
                ));
            }
            OffsetType::Invalid => {
                continue_layout(&mut src);
                src.push_str(&format!(
                    "offset={}) uniform atomic_uint counter{counter_ndx};\n",
                    1 + counter_ndx * 2
                ));
            }
            OffsetType::InvalidOverlapping => {
                continue_layout(&mut src);
                src.push_str(&format!("offset=0) uniform atomic_uint counter{counter_ndx};\n"));
            }
            OffsetType::Reverse => {
                continue_layout(&mut src);
                let reversed = spec.atomic_counter_count - counter_ndx - 1;
                src.push_str(&format!(
                    "offset={}) uniform atomic_uint counter{reversed};\n",
                    reversed * 4
                ));
            }
            OffsetType::FirstAuto => {
                if counter_ndx + 1 == spec.atomic_counter_count {
                    continue_layout(&mut src);
                    src.push_str("offset=0) uniform atomic_uint counter0;\n");
                } else if counter_ndx == 0 {
                    continue_layout(&mut src);
                    src.push_str("offset=4) uniform atomic_uint counter1;\n");
                } else {
                    close_layout(&mut src);
                    src.push_str(&format!("uniform atomic_uint counter{};\n", counter_ndx + 1));
                }
            }
            OffsetType::DefaultAuto => {
                if counter_ndx + 1 == spec.atomic_counter_count {
                    continue_layout(&mut src);
                    src.push_str("offset=0) uniform atomic_uint counter0;\n");
                } else {
                    close_layout(&mut src);
                    src.push_str(&format!("uniform atomic_uint counter{};\n", counter_ndx + 1));
                }
            }
            OffsetType::ResetDefault => {
                close_layout(&mut src);
                let half = spec.atomic_counter_count / 2;
                let named = if counter_ndx < half {
                    counter_ndx + half
                } else {
                    counter_ndx - half
                };
                src.push_str(&format!("uniform atomic_uint counter{named};\n"));
            }
        }
    }

    src.push_str("\nvoid main (void)\n{\n");

    if spec.call_count > 1 {
        src.push_str(&format!("\tfor (uint i = 0u; i < {}u; i++)\n", spec.call_count));
    }

    src.push_str("\t{\n\t\tuint id = (gl_GlobalInvocationID.x");
    if spec.call_count > 1 {
        src.push_str(&format!(" * {}u + i)", spec.call_count));
    } else {
        src.push(')');
    }
    if spec.atomic_counter_count > 1 {
        src.push_str(&format!(" * {}u", spec.atomic_counter_count));
    }
    src.push_str(";\n");

    // `gl_GlobalInvocationID.x` plus the per-call index, which is what every branch
    // predicate below alternates on.
    let branch_id = if spec.call_count > 1 { " + i" } else { "" };

    for counter_ndx in 0..spec.atomic_counter_count {
        if spec.has_pre_post_gets() {
            src.push_str(&format!(
                "\t\tsb_in.preGet[id + {counter_ndx}u] = atomicCounter(counter{counter_ndx});\n"
            ));
        }

        let inc_and_dec = spec.operations & (OPERATION_INC | OPERATION_DEC) == (OPERATION_INC | OPERATION_DEC);

        if spec.use_branches && inc_and_dec {
            src.push_str(&format!(
                "\t\tif (((gl_GlobalInvocationID.x{branch_id}) % 2u) == 0u)\n\
                 \t\t{{\n\
                 \t\t\tsb_in.increment[id + {counter_ndx}u] = atomicCounterIncrement(counter{counter_ndx});\n\
                 \t\t\tsb_in.decrement[id + {counter_ndx}u] = uint(-1);\n\
                 \t\t}}\n\
                 \t\telse\n\
                 \t\t{{\n\
                 \t\t\tsb_in.decrement[id + {counter_ndx}u] = atomicCounterDecrement(counter{counter_ndx}) + 1u;\n\
                 \t\t\tsb_in.increment[id + {counter_ndx}u] = uint(-1);\n\
                 \t\t}}\n"
            ));
        } else {
            if spec.operations & OPERATION_INC != 0 {
                if spec.use_branches {
                    src.push_str(&format!(
                        "\t\tif (((gl_GlobalInvocationID.x{branch_id}) % 2u) == 0u)\n\
                         \t\t{{\n\
                         \t\t\tsb_in.increment[id + {counter_ndx}u] = atomicCounterIncrement(counter{counter_ndx});\n\
                         \t\t}}\n\
                         \t\telse\n\
                         \t\t{{\n\
                         \t\t\tsb_in.increment[id + {counter_ndx}u] = uint(-1);\n\
                         \t\t}}\n"
                    ));
                } else {
                    src.push_str(&format!(
                        "\t\tsb_in.increment[id + {counter_ndx}u] = atomicCounterIncrement(counter{counter_ndx});\n"
                    ));
                }
            }

            if spec.operations & OPERATION_DEC != 0 {
                if spec.use_branches {
                    src.push_str(&format!(
                        "\t\tif (((gl_GlobalInvocationID.x{branch_id}) % 2u) == 0u)\n\
                         \t\t{{\n\
                         \t\t\tsb_in.decrement[id + {counter_ndx}u] = atomicCounterDecrement(counter{counter_ndx}) + 1u;\n\
                         \t\t}}\n\
                         \t\telse\n\
                         \t\t{{\n\
                         \t\t\tsb_in.decrement[id + {counter_ndx}u] = uint(-1);\n\
                         \t\t}}\n"
                    ));
                } else {
                    src.push_str(&format!("\t\tsb_in.decrement[id + {counter_ndx}u] = atomicCounterDecrement(counter{counter_ndx}) + 1u;\n"));
                }
            }
        }

        if spec.has_pre_post_gets() {
            src.push_str(&format!(
                "\t\tsb_in.postGet[id + {counter_ndx}u] = atomicCounter(counter{counter_ndx});\n"
            ));
        }

        if spec.operations == OPERATION_GET {
            if spec.use_branches {
                src.push_str(&format!(
                    "\t\tif (((gl_GlobalInvocationID.x{branch_id}) % 2u) == 0u)\n\
                     \t\t{{\n\
                     \t\t\tsb_in.get[id + {counter_ndx}u] = atomicCounter(counter{counter_ndx});\n\
                     \t\t}}\n\
                     \t\telse\n\
                     \t\t{{\n\
                     \t\t\tsb_in.get[id + {counter_ndx}u] = uint(-1);\n\
                     \t\t}}\n"
                ));
            } else {
                src.push_str(&format!(
                    "\t\tsb_in.get[id + {counter_ndx}u] = atomicCounter(counter{counter_ndx});\n"
                ));
            }
        }
    }

    src.push_str("\t}\n}\n");
    src
}

/// The values a call returned, split per operation. `uint(-1)` marks a call the shader
/// branched away from, and every check below skips those.
#[derive(Default)]
struct CallValues {
    increments: Vec<u32>,
    decrements: Vec<u32>,
    pre_gets: Vec<u32>,
    post_gets: Vec<u32>,
    gets: Vec<u32>,
}

/// `AtomicCounterTest::splitBuffer`
fn split_buffer(spec: &TestSpec, buffer: &[u32]) -> CallValues {
    let buffer_value_count = spec.call_count * spec.thread_count * spec.atomic_counter_count;
    let mut out = CallValues::default();

    // Where each array starts in the block, which follows the order they are declared in.
    let (first_pre_get, first_inc, first_dec, first_post_get, first_get) = match spec.operations {
        OPERATION_GET => (None, None, None, None, Some(0)),
        OPERATION_INC => (None, Some(0), None, None, None),
        OPERATION_DEC => (None, None, Some(0), None, None),
        ops if ops == OPERATION_GET | OPERATION_INC => (
            Some(0),
            Some(buffer_value_count),
            None,
            Some(buffer_value_count * 2),
            None,
        ),
        ops if ops == OPERATION_GET | OPERATION_DEC => (
            Some(0),
            None,
            Some(buffer_value_count),
            Some(buffer_value_count * 2),
            None,
        ),
        ops if ops == OPERATION_GET | OPERATION_DEC | OPERATION_INC => (
            Some(0),
            Some(buffer_value_count),
            Some(buffer_value_count * 2),
            Some(buffer_value_count * 3),
            None,
        ),
        ops if ops == OPERATION_DEC | OPERATION_INC => (None, Some(0), Some(buffer_value_count), None, None),
        _ => unreachable!("unknown operation combination"),
    };

    for thread_ndx in 0..spec.thread_count {
        for call_ndx in 0..spec.call_count {
            for counter_ndx in 0..spec.atomic_counter_count {
                let id = ((thread_ndx * spec.call_count) + call_ndx) * spec.atomic_counter_count + counter_ndx;

                for (first, dst) in [
                    (first_inc, &mut out.increments),
                    (first_dec, &mut out.decrements),
                    (first_pre_get, &mut out.pre_gets),
                    (first_post_get, &mut out.post_gets),
                    (first_get, &mut out.gets),
                ] {
                    if let Some(first) = first {
                        dst.push(buffer[(first + id) as usize]);
                    }
                }
            }
        }
    }

    out
}

/// `AtomicCounterTest::getCountersValues` - the slice of `values` belonging to one counter.
fn counters_values(values: &[u32], ndx: i32, counter_count: i32) -> Vec<u32> {
    debug_assert!(values.len().is_multiple_of(counter_count as usize));
    (0..values.len() / counter_count as usize)
        .map(|value_ndx| values[value_ndx * counter_count as usize + ndx as usize])
        .collect()
}

/// `AtomicCounterTest::checkRange`
fn check_range(values: &[u32], min: &[u32], max: &[u32]) -> bool {
    let mut failed_count = 0;

    for (value_ndx, &value) in values.iter().enumerate() {
        if value != u32::MAX && !(min[value_ndx]..=max[value_ndx]).contains(&value) {
            if failed_count < 20 {
                log::warn!("Value {value} not in range [{}, {}].", min[value_ndx], max[value_ndx]);
            }
            failed_count += 1;
        }
    }

    if failed_count > 20 {
        log::warn!("Number of values not in range: {failed_count}, displaying first 20 values.");
    }

    failed_count == 0
}

/// `AtomicCounterTest::checkUniquenessAndLinearity`
fn check_uniqueness_and_linearity(values: &[u32]) -> bool {
    let mut min_value = u32::MAX;
    let mut max_value = 0u32;
    let mut failed_count = 0;

    debug_assert!(!values.is_empty());

    for &value in values {
        if value != u32::MAX {
            min_value = min_value.min(value);
            max_value = max_value.max(value);
        }
    }

    let mut counts = vec![0u32; max_value.wrapping_sub(min_value).wrapping_add(1) as usize];

    for &value in values {
        if value != u32::MAX {
            counts[(value - min_value) as usize] += 1;
        }
    }

    for (count_ndx, &count) in counts.iter().enumerate() {
        if count != 1 {
            if failed_count < 20 {
                log::warn!(
                    "Value {} is not unique. Returned {count} times.",
                    min_value as usize + count_ndx
                );
            }
            failed_count += 1;
        }
    }

    if failed_count > 20 {
        log::warn!("Number of values not unique: {failed_count}, displaying first 20 values.");
    }

    failed_count == 0
}

/// `AtomicCounterTest::checkPath` - walks a possible interleaving of the increments and
/// decrements that starts at the initial value and ends at the counter's final value,
/// consuming every observed return value exactly once.
fn check_path(increments: &[u32], decrements: &[u32], initial_value: u32, spec: &TestSpec) -> bool {
    let branched_half = spec.thread_count * spec.call_count / 2;
    let branched_rest = spec.thread_count * spec.call_count - branched_half;
    let last_value = initial_value
        .wrapping_add(if spec.use_branches { branched_rest as u32 } else { 0 })
        .wrapping_sub(if spec.use_branches { branched_half as u32 } else { 0 });
    let mut is_ok = true;

    let mut min_value = u32::MAX;
    let mut max_value = 0u32;

    for &value in increments.iter().chain(decrements) {
        if value != u32::MAX {
            min_value = min_value.min(value);
            max_value = max_value.max(value);
        }
    }

    min_value = min_value.min(initial_value);
    max_value = max_value.max(initial_value);

    let size = max_value.wrapping_sub(min_value).wrapping_add(1);
    if size > 5000 {
        log::warn!("Test failed. Size is bigger than 5000 ({size}) what means driver implementation bug.");
        return false;
    }

    let mut increment_counts = vec![0u32; size as usize];
    let mut decrement_counts = vec![0u32; size as usize];

    for &value in increments {
        if value != u32::MAX {
            increment_counts[(value - min_value) as usize] += 1;
        }
    }
    for &value in decrements {
        if value != u32::MAX {
            decrement_counts[(value - min_value) as usize] += 1;
        }
    }

    let mut pos = initial_value.wrapping_sub(min_value) as i32;
    let last_pos = last_value.wrapping_sub(min_value) as i32;

    while increment_counts[pos as usize] + decrement_counts[pos as usize] != 0 {
        if increment_counts[pos as usize] > 0 && pos >= last_pos {
            // If we can increment and incrementing would move us away from the result
            // value, increment.
            increment_counts[pos as usize] -= 1;
            pos += 1;
        } else if decrement_counts[pos as usize] > 0 {
            // If we can, decrement.
            decrement_counts[pos as usize] -= 1;
            pos -= 1;
        } else if increment_counts[pos as usize] > 0 {
            // If incrementing moves closer to the result value and we cannot decrement,
            // increment.
            increment_counts[pos as usize] -= 1;
            pos += 1;
        } else {
            unreachable!("the loop condition guarantees one of the branches above");
        }

        if pos < 0 || pos >= increment_counts.len() as i32 {
            break;
        }
    }

    if min_value.wrapping_add(pos as u32) != last_value {
        is_ok = false;
    }

    if increment_counts.iter().any(|&c| c != 0) || decrement_counts.iter().any(|&c| c != 0) {
        is_ok = false;
    }

    is_ok
}

struct AtomicCounterTest {
    name: String,
    spec: TestSpec,
}

impl AtomicCounterTest {
    /// `AtomicCounterTest::checkAndLogCounterValues`
    fn check_and_log_counter_values(&self, counters: &[u32]) -> bool {
        let spec = &self.spec;
        let mut is_ok = true;

        for (counter_ndx, &value) in counters.iter().enumerate() {
            let initial_value = spec.initial_value();
            let total = (spec.thread_count * spec.call_count) as u32;
            let half = (spec.thread_count * spec.call_count / 2) as u32;
            let branched_rest = total - half;

            let has_inc = spec.operations & OPERATION_INC != 0;
            let has_dec = spec.operations & OPERATION_DEC != 0;

            let expected_value = match (has_inc, has_dec) {
                (true, false) => initial_value.wrapping_add(if spec.use_branches { branched_rest } else { total }),
                (false, true) => initial_value.wrapping_sub(if spec.use_branches { branched_rest } else { total }),
                (true, true) => initial_value
                    .wrapping_add(if spec.use_branches { branched_rest } else { 0 })
                    .wrapping_sub(if spec.use_branches { half } else { 0 }),
                (false, false) => initial_value,
            };

            log::info!(
                "atomic_uint counter{counter_ndx} initial value: {initial_value}, value: {value}, expected: {expected_value}{}",
                if value == expected_value { "" } else { ", failed!" }
            );

            if value != expected_value {
                is_ok = false;
            }
        }

        is_ok
    }

    /// `AtomicCounterTest::checkAndLogCallValues`
    fn check_and_log_call_values(&self, values: &CallValues) -> bool {
        let spec = &self.spec;
        let mut is_ok = true;

        for counter_ndx in 0..spec.atomic_counter_count {
            let counter_increments = counters_values(&values.increments, counter_ndx, spec.atomic_counter_count);
            let counter_decrements = counters_values(&values.decrements, counter_ndx, spec.atomic_counter_count);
            let counter_pre_gets = counters_values(&values.pre_gets, counter_ndx, spec.atomic_counter_count);
            let counter_post_gets = counters_values(&values.post_gets, counter_ndx, spec.atomic_counter_count);

            if spec.operations == OPERATION_GET {
                // \note upstream walks the whole `gets` array here rather than this
                // counter's slice of it; every counter holds the same value, so the
                // verdict is the same either way.
                let mut changed_values = 0;

                for &value in &values.gets {
                    if (!spec.use_branches || value != u32::MAX) && value != spec.initial_value() {
                        if changed_values < 20 {
                            log::warn!(
                                "atomicCounter(counter{counter_ndx}) returned {value} expected {}",
                                spec.initial_value()
                            );
                        }
                        is_ok = false;
                        changed_values += 1;
                    }
                }

                if changed_values == 0 {
                    log::info!(
                        "All values returned by atomicCounter(counter{counter_ndx}) match initial value {}.",
                        spec.initial_value()
                    );
                } else if changed_values > 20 {
                    log::warn!(
                        "Total number of invalid values returned by atomicCounter(counter{counter_ndx}) {changed_values} displaying first 20 values."
                    );
                }
            } else if spec.operations & (OPERATION_INC | OPERATION_DEC) == (OPERATION_INC | OPERATION_DEC) {
                if check_path(&counter_increments, &counter_decrements, spec.initial_value(), spec) {
                    log::info!(
                        "Found possible order of calls to atomicCounterIncrement(counter{counter_ndx}) and atomicCounterDecrement(counter{counter_ndx})."
                    );
                } else {
                    is_ok = false;
                    log::warn!(
                        "No possible order of calls to atomicCounterIncrement(counter{counter_ndx}) and atomicCounterDecrement(counter{counter_ndx}) found."
                    );
                }
            } else if spec.operations & OPERATION_INC != 0 {
                if check_uniqueness_and_linearity(&counter_increments) {
                    log::info!("atomicCounterIncrement(counter{counter_ndx}) returned only unique values.");
                } else {
                    is_ok = false;
                    log::warn!("atomicCounterIncrement(counter{counter_ndx}) returned non unique values.");
                }

                if is_ok && spec.operations & OPERATION_GET != 0 {
                    if check_range(&counter_increments, &counter_pre_gets, &counter_post_gets) {
                        log::info!(
                            "atomicCounterIncrement(counter{counter_ndx}) returned only values between previous and next call to atomicCounter(counter{counter_ndx})."
                        );
                    } else {
                        is_ok = false;
                        log::warn!(
                            "atomicCounterIncrement(counter{counter_ndx}) returned value that is not between previous and next call to atomicCounter(counter{counter_ndx})."
                        );
                    }
                }
            } else if spec.operations & OPERATION_DEC != 0 {
                if check_uniqueness_and_linearity(&counter_decrements) {
                    log::info!("atomicCounterDecrement(counter{counter_ndx}) returned only unique values.");
                } else {
                    is_ok = false;
                    log::warn!("atomicCounterDecrement(counter{counter_ndx}) returned non unique values.");
                }

                if is_ok && spec.operations & OPERATION_GET != 0 {
                    // Decrementing runs the other way, so the bounds swap.
                    if check_range(&counter_decrements, &counter_post_gets, &counter_pre_gets) {
                        log::info!(
                            "atomicCounterDecrement(counter{counter_ndx}) returned only values between previous and next call to atomicCounter(counter{counter_ndx})."
                        );
                    } else {
                        is_ok = false;
                        log::warn!(
                            "atomicCounterDecrement(counter{counter_ndx}) returned value that is not between previous and next call to atomicCounter(counter{counter_ndx})."
                        );
                    }
                }
            }
        }

        is_ok
    }
}

impl TestCase for AtomicCounterTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `AtomicCounterTest::iterate`
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let spec = &self.spec;
        let program = ShaderProgram::new(gl, &ProgramSources::compute(generate_shader_source(spec)));

        if spec.expects_compile_failure() {
            return Ok(if program.is_ok() {
                log::warn!("Expected program to fail, but compilation passed.");
                TestStatus::fail("Compile succeeded")
            } else {
                log::info!("Compilation failed as expected.");
                TestStatus::pass("Compile failed")
            });
        } else if !program.is_ok() {
            log::warn!("Compile failed.");
            return Ok(TestStatus::fail("Compile failed"));
        }

        let counter_buffer_size = spec.atomic_counter_count * 4;
        let sso_size = spec.atomic_counter_count * spec.call_count * spec.thread_count * 4 * spec.operation_count();

        let counter_buffer = Buffer::new(gl);
        let output_buffer = Buffer::new(gl);
        let counter_init = vec![spec.initial_value(); spec.atomic_counter_count as usize];

        // SAFETY: every upload below covers exactly the range it names, and the two
        // read-backs map the same ranges and copy out before unmapping.
        unsafe {
            gl.use_program(program.program());
            glu::expect_no_error(gl, "glUseProgram()")?;

            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, output_buffer.get());
            gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                sso_size as isize,
                std::ptr::null(),
                glw::GL_STATIC_DRAW,
            );
            glu::expect_no_error(gl, "Failed to create output buffer")?;

            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, counter_buffer.get());
            gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                counter_buffer_size as isize,
                counter_init.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
            glu::expect_no_error(gl, "Failed to create buffer for atomic counters")?;

            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, output_buffer.get());
            glu::expect_no_error(gl, "Failed to setup output buffer")?;

            gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, counter_buffer.get());
            glu::expect_no_error(gl, "Failed to setup atomic counter buffer")?;

            gl.dispatch_compute(spec.thread_count as u32, 1, 1);
            glu::expect_no_error(gl, "glDispatchCompute()")?;

            gl.finish();
            glu::expect_no_error(gl, "glFinish()")?;
        }

        let output = read_back_u32(gl, output_buffer.get(), (sso_size / 4) as usize)?;
        let counters = read_back_u32(gl, counter_buffer.get(), spec.atomic_counter_count as usize)?;

        let mut is_ok = self.check_and_log_counter_values(&counters);
        if !self.check_and_log_call_values(&split_buffer(spec, &output)) {
            is_ok = false;
        }

        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `iterate`'s two identical read-back blocks.
fn read_back_u32(gl: &glw::Functions, buffer: glw::GLuint, count: usize) -> Result<Vec<u32>, crate::tcu::TestError> {
    // SAFETY: the mapping covers exactly `count` u32s of the buffer just written, and
    // is copied out before the unmap.
    unsafe {
        gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer);
        glu::expect_no_error(gl, "glBindBuffer()")?;

        let ptr = gl.map_buffer_range(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            (count * 4) as isize,
            glw::GL_MAP_READ_BIT,
        );
        glu::expect_no_error(gl, "glMapBufferRange()")?;
        if ptr.is_null() {
            return Err(crate::tcu::TestError::Fail(
                "glMapBufferRange returned null".to_string(),
            ));
        }

        let mut out = vec![0u32; count];
        std::ptr::copy_nonoverlapping(ptr.cast::<u8>(), out.as_mut_ptr().cast::<u8>(), count * 4);

        if gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER) == glw::FALSE {
            glu::expect_no_error(gl, "glUnmapBuffer()")?;
            return Err(crate::tcu::TestError::Fail("Mapped buffer corrupted".to_string()));
        }

        gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0);
        glu::expect_no_error(gl, "glBindBuffer()")?;

        Ok(out)
    }
}

/// `specToTestName`
fn spec_to_test_name(spec: &TestSpec) -> String {
    format!(
        "{}_{}_{}_{}_{}_{}",
        spec.atomic_counter_count,
        if spec.atomic_counter_count == 1 {
            "counter"
        } else {
            "counters"
        },
        spec.call_count,
        if spec.call_count == 1 { "call" } else { "calls" },
        spec.thread_count,
        if spec.thread_count == 1 { "thread" } else { "threads" },
    )
}

/// `operationToName`
fn operation_to_name(operations: u32, use_branch: bool) -> String {
    let mut parts = Vec::new();

    if operations & OPERATION_GET != 0 {
        parts.push("get");
    }
    if operations & OPERATION_INC != 0 {
        parts.push("inc");
    }
    if operations & OPERATION_DEC != 0 {
        parts.push("dec");
    }
    if use_branch {
        parts.push("branch");
    }

    parts.join("_")
}

/// `layoutTypesToName`, for the `BINDINGTYPE_BASIC` offsets the layout group registers.
fn offset_type_to_name(offset_type: OffsetType) -> &'static str {
    match offset_type {
        OffsetType::Basic => "basic_offset",
        OffsetType::Reverse => "reverse_offset",
        OffsetType::Invalid => "invalid_offset",
        OffsetType::FirstAuto => "first_offset_set",
        OffsetType::DefaultAuto => "default_offset_set",
        OffsetType::ResetDefault => "reset_default_offset",
        _ => "",
    }
}

fn case(spec: TestSpec, name: String) -> Box<dyn TestCase> {
    Box::new(AtomicCounterTest { name, spec })
}

/// `AtomicCounterTests::AtomicCounterTests`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("atomic_counter");

    // Runtime use tests.
    {
        const COUNTER_COUNTS: [i32; 3] = [1, 4, 8];
        const CALL_COUNTS: [i32; 3] = [1, 5, 100];
        const THREAD_COUNTS: [i32; 3] = [1, 10, 5000];
        const OPERATIONS: [u32; 7] = [
            OPERATION_GET,
            OPERATION_INC,
            OPERATION_DEC,
            OPERATION_INC | OPERATION_GET,
            OPERATION_DEC | OPERATION_GET,
            OPERATION_INC | OPERATION_DEC,
            OPERATION_INC | OPERATION_DEC | OPERATION_GET,
        ];

        for operation in OPERATIONS {
            for branch in 0..2 {
                let use_branches = branch == 1;
                let mut operation_group = TestCaseGroup::new(operation_to_name(operation, use_branches));

                for counter_count in COUNTER_COUNTS {
                    for call_count in CALL_COUNTS {
                        for thread_count in THREAD_COUNTS {
                            if thread_count * call_count * counter_count > 10000 {
                                continue;
                            }
                            if use_branches && thread_count * call_count == 1 {
                                continue;
                            }

                            let spec = TestSpec {
                                atomic_counter_count: counter_count,
                                operations: operation,
                                call_count,
                                use_branches,
                                thread_count,
                                binding_type: BindingType::Basic,
                                offset_type: OffsetType::None,
                            };
                            operation_group.add_child(case(spec, spec_to_test_name(&spec)));
                        }
                    }
                }

                group.add_child(operation_group);
            }
        }
    }

    // Layout qualifier tests.
    {
        const COUNTER_COUNTS: [i32; 2] = [1, 8];
        const CALL_COUNTS: [i32; 2] = [1, 5];
        const THREAD_COUNTS: [i32; 2] = [1, 1000];
        const OPERATIONS: [u32; 3] = [
            OPERATION_INC | OPERATION_GET,
            OPERATION_DEC | OPERATION_GET,
            OPERATION_INC | OPERATION_DEC,
        ];
        const OFFSET_TYPES: [OffsetType; 4] = [
            OffsetType::Reverse,
            OffsetType::FirstAuto,
            OffsetType::DefaultAuto,
            OffsetType::ResetDefault,
        ];

        let mut layout_group = TestCaseGroup::new("layout");

        for offset_type in OFFSET_TYPES {
            let mut layout_qualifier_group = TestCaseGroup::new(offset_type_to_name(offset_type));

            for operation in OPERATIONS {
                let mut operation_group = TestCaseGroup::new(operation_to_name(operation, false));

                for counter_count in COUNTER_COUNTS {
                    // Each of these offset schemes needs more than one counter to say
                    // anything, and `first_offset_set` needs a third to have a counter
                    // that keeps the implicit offset.
                    let min_counters = if offset_type == OffsetType::FirstAuto { 3 } else { 2 };
                    if counter_count < min_counters {
                        continue;
                    }

                    for call_count in CALL_COUNTS {
                        for thread_count in THREAD_COUNTS {
                            let spec = TestSpec {
                                atomic_counter_count: counter_count,
                                operations: operation,
                                call_count,
                                use_branches: false,
                                thread_count,
                                binding_type: BindingType::Basic,
                                offset_type,
                            };
                            operation_group.add_child(case(spec, spec_to_test_name(&spec)));
                        }
                    }
                }

                layout_qualifier_group.add_child(operation_group);
            }

            layout_group.add_child(layout_qualifier_group);
        }

        // .invalid
        {
            let mut invalid_group = TestCaseGroup::new("invalid");
            let base = TestSpec {
                atomic_counter_count: 1,
                operations: OPERATION_INC,
                call_count: 1,
                use_branches: false,
                thread_count: 1,
                binding_type: BindingType::Basic,
                offset_type: OffsetType::None,
            };

            invalid_group.add_child(case(
                TestSpec {
                    binding_type: BindingType::Invalid,
                    ..base
                },
                "invalid_binding".to_string(),
            ));
            invalid_group.add_child(case(
                TestSpec {
                    binding_type: BindingType::InvalidDefault,
                    ..base
                },
                "invalid_default_binding".to_string(),
            ));
            invalid_group.add_child(case(
                TestSpec {
                    offset_type: OffsetType::Invalid,
                    ..base
                },
                "invalid_offset_align".to_string(),
            ));
            invalid_group.add_child(case(
                TestSpec {
                    atomic_counter_count: 2,
                    offset_type: OffsetType::InvalidOverlapping,
                    ..base
                },
                "invalid_offset_overlap".to_string(),
            ));
            invalid_group.add_child(case(
                TestSpec {
                    offset_type: OffsetType::InvalidDefault,
                    ..base
                },
                "invalid_default_offset".to_string(),
            ));

            layout_group.add_child(invalid_group);
        }

        group.add_child(layout_group);
    }

    group
}
