// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fBufferWriteTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `BasicBufferSubDataCase` is not
// ported: upstream declares it and registers it nowhere. `RandomBufferWriteCase`'s
// `init`/`deinit` fold into the top and bottom of `iterate`, since the iteration that
// upstream drives by returning CONTINUE is a loop here. The case bodies are the ES 2.0
// ones - upstream's two files differ only in the target/hint tables and in the `verify`
// target hint, which `gls`'s vertex-array verifier `DE_UNREF`s - so `gls::BufferTestUtil`
// here is the ES 2.0 module's `buffer_test_util`.

use crate::gles2::functional::buffer_test_util::{BufferVerifier, VerifyType, check_error, fill_with_random_bytes, get_buffer_target_name, get_usage_hint_name};
use crate::glu::{Buffer, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::tcu::random::{de_int32_hash, de_string_hash};
use crate::tcu::{Random, TestOutcome, TestStatus};

const ES3_BUFFER_TARGETS: [GLenum; 8] = [
    glw::GL_ARRAY_BUFFER,
    glw::GL_COPY_READ_BUFFER,
    glw::GL_COPY_WRITE_BUFFER,
    glw::GL_ELEMENT_ARRAY_BUFFER,
    glw::GL_PIXEL_PACK_BUFFER,
    glw::GL_PIXEL_UNPACK_BUFFER,
    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
    glw::GL_UNIFORM_BUFFER,
];

const ES3_USAGE_HINTS: [GLenum; 9] = [
    glw::GL_STREAM_DRAW,
    glw::GL_STREAM_READ,
    glw::GL_STREAM_COPY,
    glw::GL_STATIC_DRAW,
    glw::GL_STATIC_READ,
    glw::GL_STATIC_COPY,
    glw::GL_DYNAMIC_DRAW,
    glw::GL_DYNAMIC_READ,
    glw::GL_DYNAMIC_COPY,
];

/// `DataStoreSpec`
#[derive(Clone, Copy)]
struct DataStoreSpec {
    target: GLenum,
    usage: GLenum,
    size: i32,
}

impl DataStoreSpec {
    const fn new(target: GLenum, usage: GLenum, size: i32) -> Self {
        Self { target, usage, size }
    }
}

/// A `(start, len)` byte range. Upstream carries these in a `tcu::IVec2`; the two
/// components are named `x()` and `y()` there, and this keeps the same accessors.
type Range = crate::tcu::IVec2;

/// `de::inRange` - inclusive on both ends, unlike `de::inBounds`.
fn in_range(value: i32, low: i32, high: i32) -> bool {
    value >= low && value <= high
}

fn ranges_intersect(a: Range, b: Range) -> bool {
    in_range(a.x(), b.x(), b.x() + b.y()) || in_range(a.x() + a.y(), b.x(), b.x() + b.y()) || in_range(b.x(), a.x(), a.x() + a.y()) || in_range(b.x() + b.y(), a.x(), a.x() + a.y())
}

fn union_ranges(a: Range, b: Range) -> Range {
    debug_assert!(ranges_intersect(a, b));

    let start = a.x().min(b.x());
    let end = (a.x() + a.y()).max(b.x() + b.y());

    Range::new(start, end - start)
}

/// Updates range list (start, len) with a new range.
fn add_range_to_list(old_list: &[Range], new_range: Range) -> Vec<Range> {
    debug_assert!(new_range.y() > 0);

    let mut new_list = Vec::new();
    let mut iter = 0;

    // Append ranges that end before the new range.
    while iter < old_list.len() && old_list[iter].x() + old_list[iter].y() < new_range.x() {
        new_list.push(old_list[iter]);
        iter += 1;
    }

    // Join any ranges that intersect new range
    {
        let mut cur_range = new_range;
        while iter < old_list.len() && ranges_intersect(cur_range, old_list[iter]) {
            cur_range = union_ranges(cur_range, old_list[iter]);
            iter += 1;
        }

        new_list.push(cur_range);
    }

    // Append remaining ranges.
    while iter < old_list.len() {
        new_list.push(old_list[iter]);
        iter += 1;
    }

    new_list
}

struct BasicBufferDataCase {
    name: String,
    target: GLenum,
    usage: GLenum,
    size: i32,
    verify: VerifyType,
}

impl TestCase for BasicBufferDataCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let data_seed = de_string_hash(&self.name) ^ 0x125;
        let verifier = BufferVerifier::new(gl, self.verify)?;
        let mut ref_buf = vec![0u8; self.size as usize];

        fill_with_random_bytes(&mut ref_buf, data_seed);

        let buf = Buffer::new(gl);
        // SAFETY: the data pointer covers exactly `size` bytes.
        unsafe {
            gl.bind_buffer(self.target, buf.get());
            gl.buffer_data(self.target, self.size as isize, ref_buf.as_ptr().cast(), self.usage);
        }

        check_error(gl)?;

        let is_ok = verifier.verify(context, buf.get(), &ref_buf, 0, self.size)?;

        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Buffer verification failed")
        })
    }
}

struct RecreateBufferDataStoreCase {
    name: String,
    specs: Vec<DataStoreSpec>,
    verify: VerifyType,
}

impl TestCase for RecreateBufferDataStoreCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let base_seed = de_string_hash(&self.name) ^ 0xbeef;
        let verifier = BufferVerifier::new(gl, self.verify)?;
        let buf = Buffer::new(gl);

        let mut result = TestStatus::pass("Pass");

        for spec in &self.specs {
            let mut ref_buf = vec![0u8; spec.size as usize];
            fill_with_random_bytes(&mut ref_buf, base_seed ^ de_int32_hash(spec.size + spec.target as i32 + spec.usage as i32));

            // SAFETY: the data pointer covers exactly `spec.size` bytes.
            unsafe {
                gl.bind_buffer(spec.target, buf.get());
                gl.buffer_data(spec.target, spec.size as isize, ref_buf.as_ptr().cast(), spec.usage);
            }

            check_error(gl)?;

            let iter_ok = verifier.verify(context, buf.get(), &ref_buf, 0, spec.size)?;

            if !iter_ok {
                result = TestStatus::fail("Fail");
                break;
            }
        }

        Ok(result)
    }
}

struct SubDataToUndefinedCase {
    name: String,
    target: GLenum,
    usage: GLenum,
    size: i32,
    ranges: Vec<Range>,
    verify: VerifyType,
}

impl TestCase for SubDataToUndefinedCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let data_seed = de_string_hash(&self.name);
        let verifier = BufferVerifier::new(gl, self.verify)?;
        let mut ref_buf = vec![0u8; self.size as usize];
        let mut is_ok = true;
        let mut defined_ranges: Vec<Range> = Vec::new();

        let buf = Buffer::new(gl);
        // SAFETY: a data store of `size` bytes with no initial contents.
        unsafe {
            gl.bind_buffer(self.target, buf.get());
            gl.buffer_data(self.target, self.size as isize, std::ptr::null(), self.usage);
        }

        check_error(gl)?;

        // Fill specified ranges with glBufferSubData()
        for range in &self.ranges {
            let start = range.x() as usize;
            let len = range.y() as usize;
            fill_with_random_bytes(&mut ref_buf[start..start + len], data_seed ^ de_int32_hash(range.x() + range.y()));
            // SAFETY: the pointer covers exactly the range being uploaded, which is
            // inside the store specified above.
            unsafe { gl.buffer_sub_data(self.target, range.x() as isize, range.y() as isize, ref_buf[start..].as_ptr().cast()) };

            // Mark range as defined
            defined_ranges = add_range_to_list(&defined_ranges, *range);
        }

        // Verify defined parts
        for range in &defined_ranges {
            if !verifier.verify(context, buf.get(), &ref_buf, range.x(), range.y())? {
                is_ok = false;
            }
        }

        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Buffer verification failed")
        })
    }
}

/// `deRoundFloatToInt32`
fn round_to_int(value: f32) -> i32 {
    (value + 0.5).floor() as i32
}

struct RandomBufferWriteCase {
    name: String,
    seed: u32,
}

impl TestCase for RandomBufferWriteCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        // Parameters.
        let num_iterations = 5;
        let uploads_per_iteration = 7;
        let min_size = 12;
        let max_size = 32 * 1024;
        let respecify_probability = 0.07;
        let respecify_data_probability = 0.2;

        const BUFFER_TARGETS: [GLenum; 8] = ES3_BUFFER_TARGETS;
        const USAGE_HINTS: [GLenum; 9] = ES3_USAGE_HINTS;

        let gl = context.gl();
        let buffer = Buffer::new(gl);
        let verifier = BufferVerifier::new(gl, VerifyType::VertexArray)?;
        let mut ref_buffer: Vec<u8> = Vec::new();
        let mut valid_ranges: Vec<Range> = Vec::new();
        let mut cur_size = 0;
        let mut result = TestStatus::pass("Pass");

        for iter_ndx in 0..num_iterations {
            let mut iter_ok = true;
            let mut cur_bound_target = glw::GL_NONE;
            let mut rnd = Random::new(self.seed ^ de_int32_hash(iter_ndx) ^ 0xacf92e);

            for _upload_ndx in 0..uploads_per_iteration {
                let target = BUFFER_TARGETS[rnd.get_int(0, BUFFER_TARGETS.len() as i32 - 1) as usize];
                let respecify = cur_size == 0 || rnd.get_float() < respecify_probability;

                if target != cur_bound_target {
                    // SAFETY: binding the buffer this case owns.
                    unsafe { gl.bind_buffer(target, buffer.get()) };
                    cur_bound_target = target;
                }

                if respecify {
                    let size = rnd.get_int(min_size, max_size);
                    let hint = USAGE_HINTS[rnd.get_int(0, USAGE_HINTS.len() as i32 - 1) as usize];
                    let fill_with_data = rnd.get_float() < respecify_data_probability;

                    ref_buffer.resize(size as usize, 0);
                    if fill_with_data {
                        fill_with_random_bytes(&mut ref_buffer[..size as usize], rnd.get_uint32());
                    }

                    // SAFETY: the data pointer, when given, covers exactly `size` bytes.
                    unsafe {
                        let data = if fill_with_data { ref_buffer.as_ptr().cast() } else { std::ptr::null() };
                        gl.buffer_data(target, size as isize, data, hint);
                    }

                    valid_ranges.clear();
                    if fill_with_data {
                        valid_ranges.push(Range::new(0, size));
                    }

                    cur_size = size;
                } else {
                    // \note Non-uniform size distribution.
                    let size = round_to_int(cur_size as f32 * rnd.get_float_range(0.0, 0.7).powf(3.0)).clamp(min_size, cur_size);
                    let offset = rnd.get_int(0, cur_size - size);

                    fill_with_random_bytes(&mut ref_buffer[offset as usize..(offset + size) as usize], rnd.get_uint32());
                    // SAFETY: as above, for a range inside the current store.
                    unsafe { gl.buffer_sub_data(target, offset as isize, size as isize, ref_buffer[offset as usize..].as_ptr().cast()) };

                    valid_ranges = add_range_to_list(&valid_ranges, Range::new(offset, size));
                }
            }

            check_error(gl)?;

            // Verify valid ranges.
            for range in &valid_ranges {
                if !verifier.verify(context, buffer.get(), &ref_buffer, range.x(), range.y())? {
                    result = TestStatus::fail("Buffer verification failed");
                    iter_ok = false;
                    break;
                }
            }

            if !iter_ok {
                break;
            }
        }

        Ok(result)
    }
}

/// `BufferWriteTests::init`
pub fn create_tests() -> TestCaseGroup {
    const BUFFER_TARGETS: [GLenum; 8] = ES3_BUFFER_TARGETS;
    const USAGE_HINTS: [GLenum; 9] = ES3_USAGE_HINTS;

    let mut group = TestCaseGroup::new("write");

    // .basic
    {
        let mut basic_group = TestCaseGroup::new("basic");

        for target in BUFFER_TARGETS {
            for usage in USAGE_HINTS {
                let size = 1020;
                let verify = VerifyType::VertexArray;
                let name = format!("{}_{}", get_buffer_target_name(target), get_usage_hint_name(usage));

                basic_group.add_child(Box::new(BasicBufferDataCase {
                    name,
                    target,
                    usage,
                    size,
                    verify,
                }) as Box<dyn TestCase>);
            }
        }

        group.add_child(basic_group);
    }


    // .recreate_store
    {
        let mut recreate_store_group = TestCaseGroup::new("recreate_store");

        let mut recreate_store_case = |name: &str, specs: &[DataStoreSpec]| {
            recreate_store_group.add_child(Box::new(RecreateBufferDataStoreCase {
                name: name.to_string(),
                specs: specs.to_vec(),
                verify: VerifyType::VertexArray,
            }) as Box<dyn TestCase>);
        };

        // Recreate with identical parameters
        recreate_store_case(
            "identical_1",
            &[
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_STATIC_DRAW, 996),
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_STATIC_DRAW, 996),
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_STATIC_DRAW, 996),
            ],
        );

        // Recreate with identical parameters
        recreate_store_case(
            "identical_2",
            &[
                DataStoreSpec::new(glw::GL_COPY_WRITE_BUFFER, glw::GL_STATIC_DRAW, 72),
                DataStoreSpec::new(glw::GL_COPY_WRITE_BUFFER, glw::GL_STATIC_DRAW, 72),
                DataStoreSpec::new(glw::GL_COPY_WRITE_BUFFER, glw::GL_STATIC_DRAW, 72),
            ],
        );

        // Recreate with different target
        recreate_store_case(
            "different_target",
            &[
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_STATIC_DRAW, 504),
                DataStoreSpec::new(glw::GL_COPY_READ_BUFFER, glw::GL_STATIC_DRAW, 504),
                DataStoreSpec::new(glw::GL_COPY_WRITE_BUFFER, glw::GL_STATIC_DRAW, 504),
                DataStoreSpec::new(glw::GL_ELEMENT_ARRAY_BUFFER, glw::GL_STATIC_DRAW, 504),
                DataStoreSpec::new(glw::GL_PIXEL_PACK_BUFFER, glw::GL_STATIC_DRAW, 504),
                DataStoreSpec::new(glw::GL_PIXEL_UNPACK_BUFFER, glw::GL_STATIC_DRAW, 504),
                DataStoreSpec::new(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_STATIC_DRAW, 504),
                DataStoreSpec::new(glw::GL_UNIFORM_BUFFER, glw::GL_STATIC_DRAW, 504),
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_STATIC_DRAW, 504),
            ],
        );

        // Recreate with different usage
        recreate_store_case(
            "different_usage",
            &[
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_STREAM_DRAW, 1644),
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_STREAM_COPY, 1644),
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_STATIC_READ, 1644),
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_STREAM_READ, 1644),
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_DYNAMIC_COPY, 1644),
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_STATIC_COPY, 1644),
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_DYNAMIC_READ, 1644),
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_DYNAMIC_DRAW, 1644),
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_STATIC_DRAW, 1644),
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_STREAM_DRAW, 1644),
            ],
        );

        // Recreate with different size
        recreate_store_case(
            "different_size",
            &[
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_STREAM_DRAW, 1024),
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_STREAM_DRAW, 12),
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_STREAM_DRAW, 3327),
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_STREAM_DRAW, 92),
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_STREAM_DRAW, 123795),
                DataStoreSpec::new(glw::GL_ARRAY_BUFFER, glw::GL_STREAM_DRAW, 571),
            ],
        );

        // Random cases.
        {
            let num_random_cases = 4;
            let num_uploads_per_case = 10;
            let min_size = 12;
            let max_size = 65536;
            let verify = VerifyType::VertexArray;
            let mut rnd = Random::new(23921);

            for case_ndx in 0..num_random_cases {
                let specs: Vec<DataStoreSpec> = (0..num_uploads_per_case)
                    .map(|_| DataStoreSpec {
                        target: BUFFER_TARGETS[rnd.get_int(0, BUFFER_TARGETS.len() as i32 - 1) as usize],
                        usage: USAGE_HINTS[rnd.get_int(0, USAGE_HINTS.len() as i32 - 1) as usize],
                        size: rnd.get_int(min_size, max_size),
                    })
                    .collect();

                recreate_store_group.add_child(Box::new(RecreateBufferDataStoreCase {
                    name: format!("random_{}", case_ndx + 1),
                    specs,
                    verify,
                }) as Box<dyn TestCase>);
            }
        }

        group.add_child(recreate_store_group);
    }

    // .basic_subdata
    //
    // Upstream registers `BasicBufferDataCase` here too, not `BasicBufferSubDataCase`,
    // so these cases are byte for byte the `basic` ones (same names, hence the same
    // data seed). Porting the sub-data case instead would disagree with `deqp-gles2`.
    {
        let mut basic_group = TestCaseGroup::new("basic_subdata");

        for target in BUFFER_TARGETS {
            for usage in USAGE_HINTS {
                let size = 1020;
                let verify = VerifyType::VertexArray;
                let name = format!("{}_{}", get_buffer_target_name(target), get_usage_hint_name(usage));

                basic_group.add_child(Box::new(BasicBufferDataCase {
                    name,
                    target,
                    usage,
                    size,
                    verify,
                }) as Box<dyn TestCase>);
            }
        }

        group.add_child(basic_group);
    }

    // .partial_specify
    {
        let mut partial_specify_group = TestCaseGroup::new("partial_specify");

        let mut partial_specify_case = |name: &str, target: GLenum, usage: GLenum, size: i32, ranges: &[Range]| {
            partial_specify_group.add_child(Box::new(SubDataToUndefinedCase {
                name: name.to_string(),
                target,
                usage,
                size,
                ranges: ranges.to_vec(),
                verify: VerifyType::VertexArray,
            }) as Box<dyn TestCase>);
        };

        // Whole buffer specification with single glBufferSubData()
        partial_specify_case("whole_1", glw::GL_ARRAY_BUFFER, glw::GL_STATIC_DRAW, 996, &[Range::new(0, 996)]);
        // Whole buffer specification with two calls
        partial_specify_case(
            "whole_2",
            glw::GL_UNIFORM_BUFFER,
            glw::GL_DYNAMIC_READ,
            1728,
            &[Range::new(729, 999), Range::new(0, 729)],
        );
        // Whole buffer specification with three calls
        partial_specify_case(
            "whole_3",
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            glw::GL_STREAM_COPY,
            1944,
            &[Range::new(0, 421), Range::new(1421, 523), Range::new(421, 1000)],
        );
        // Whole buffer specification with three calls
        partial_specify_case(
            "whole_4",
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            glw::GL_STREAM_COPY,
            1200,
            &[Range::new(0, 500), Range::new(429, 200), Range::new(513, 687)],
        );

        // Low part of buffer specified with single call
        partial_specify_case("low_1", glw::GL_ELEMENT_ARRAY_BUFFER, glw::GL_DYNAMIC_DRAW, 1000, &[Range::new(0, 513)]);
        // Low part of buffer specified with two calls
        partial_specify_case("low_2", glw::GL_COPY_READ_BUFFER, glw::GL_DYNAMIC_COPY, 996, &[Range::new(0, 98), Range::new(98, 511)]);
        // Low part of buffer specified with two calls
        partial_specify_case("low_3", glw::GL_COPY_READ_BUFFER, glw::GL_DYNAMIC_COPY, 1200, &[Range::new(0, 591), Range::new(371, 400)]);

        // High part of buffer specified with single call
        partial_specify_case("high_1", glw::GL_COPY_WRITE_BUFFER, glw::GL_STATIC_COPY, 1000, &[Range::new(500, 500)]);
        // High part of buffer specified with two calls
        partial_specify_case(
            "high_2",
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            glw::GL_STREAM_DRAW,
            1200,
            &[Range::new(600, 123), Range::new(723, 477)],
        );
        // High part of buffer specified with two calls
        partial_specify_case(
            "high_3",
            glw::GL_PIXEL_PACK_BUFFER,
            glw::GL_STREAM_READ,
            1200,
            &[Range::new(600, 200), Range::new(601, 599)],
        );

        // Middle part of buffer specified with single call
        partial_specify_case("middle_1", glw::GL_PIXEL_UNPACK_BUFFER, glw::GL_STREAM_READ, 2500, &[Range::new(1000, 799)]);
        // Middle part of buffer specified with two calls
        partial_specify_case(
            "middle_2",
            glw::GL_ELEMENT_ARRAY_BUFFER,
            glw::GL_STATIC_DRAW,
            2500,
            &[Range::new(780, 220), Range::new(1000, 500)],
        );
        // Middle part of buffer specified with two calls
        partial_specify_case("middle_3", glw::GL_ARRAY_BUFFER, glw::GL_STREAM_READ, 2500, &[Range::new(780, 321), Range::new(1000, 501)]);

        group.add_child(partial_specify_group);
    }

    // .random
    {
        let mut random_group = TestCaseGroup::new("random");

        for i in 0..10 {
            random_group.add_child(Box::new(RandomBufferWriteCase {
                name: i.to_string(),
                seed: de_int32_hash(i),
            }) as Box<dyn TestCase>);
        }

        group.add_child(random_group);
    }

    group
}
