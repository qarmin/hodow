// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fBufferCopyTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `gls::BufferTestUtil` is the ES 2.0
// module's `buffer_test_util` here; upstream's `verify` target-hint argument is dropped
// because the vertex-array verifier `DE_UNREF`s it.

use crate::gles2::functional::buffer_test_util::{BufferVerifier, VerifyType, check_error, fill_with_random_bytes, get_buffer_target_name};
use crate::glu::{Buffer, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::tcu::random::{de_int32_hash, de_string_hash};
use crate::tcu::{TestOutcome, TestStatus};

const BUFFER_TARGETS: [GLenum; 8] = [
    glw::GL_ARRAY_BUFFER,
    glw::GL_COPY_READ_BUFFER,
    glw::GL_COPY_WRITE_BUFFER,
    glw::GL_ELEMENT_ARRAY_BUFFER,
    glw::GL_PIXEL_PACK_BUFFER,
    glw::GL_PIXEL_UNPACK_BUFFER,
    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
    glw::GL_UNIFORM_BUFFER,
];

struct BasicBufferCopyCase {
    name: String,
    src_target: GLenum,
    src_size: i32,
    src_hint: GLenum,
    dst_target: GLenum,
    dst_size: i32,
    dst_hint: GLenum,
    copy_src_offset: i32,
    copy_dst_offset: i32,
    copy_size: i32,
    verify: VerifyType,
}

impl TestCase for BasicBufferCopyCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let verifier = BufferVerifier::new(gl, self.verify)?;
        let src_seed = de_string_hash(&self.name) ^ 0xabcd;
        let dst_seed = de_string_hash(&self.name) ^ 0xef01;
        let mut is_ok = true;

        let mut src_ref = vec![0u8; self.src_size as usize];
        fill_with_random_bytes(&mut src_ref, src_seed);

        let mut dst_ref = vec![0u8; self.dst_size as usize];
        fill_with_random_bytes(&mut dst_ref, dst_seed);

        // Create source buffer and fill with data.
        let src_buf = Buffer::new(gl);
        // SAFETY: the data pointer covers exactly `src_size` bytes.
        unsafe {
            gl.bind_buffer(self.src_target, src_buf.get());
            gl.buffer_data(self.src_target, self.src_size as isize, src_ref.as_ptr().cast(), self.src_hint);
        }
        check_error(gl)?;

        // Create destination buffer and fill with data.
        let dst_buf = Buffer::new(gl);
        // SAFETY: the data pointer covers exactly `dst_size` bytes.
        unsafe {
            gl.bind_buffer(self.dst_target, dst_buf.get());
            gl.buffer_data(self.dst_target, self.dst_size as isize, dst_ref.as_ptr().cast(), self.dst_hint);
        }
        check_error(gl)?;

        // Verify both buffers before executing copy.
        is_ok = verifier.verify(context, src_buf.get(), &src_ref, 0, self.src_size)? && is_ok;
        is_ok = verifier.verify(context, dst_buf.get(), &dst_ref, 0, self.dst_size)? && is_ok;

        // Execute copy.
        {
            let src_start = self.copy_src_offset as usize;
            let dst_start = self.copy_dst_offset as usize;
            let len = self.copy_size as usize;
            let copied: Vec<u8> = src_ref[src_start..src_start + len].to_vec();
            dst_ref[dst_start..dst_start + len].copy_from_slice(&copied);
        }

        // SAFETY: both buffers exist and the copy range is inside both data stores.
        unsafe {
            gl.bind_buffer(self.src_target, src_buf.get());
            gl.bind_buffer(self.dst_target, dst_buf.get());
            gl.copy_buffer_sub_data(
                self.src_target,
                self.dst_target,
                self.copy_src_offset as isize,
                self.copy_dst_offset as isize,
                self.copy_size as isize,
            );
        }
        check_error(gl)?;

        // Verify both buffers after copy.
        is_ok = verifier.verify(context, src_buf.get(), &src_ref, 0, self.src_size)? && is_ok;
        is_ok = verifier.verify(context, dst_buf.get(), &dst_ref, 0, self.dst_size)? && is_ok;

        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Buffer verification failed")
        })
    }
}

/// Case B: same buffer, take range as parameter.
struct SingleBufferCopyCase {
    name: String,
    src_target: GLenum,
    dst_target: GLenum,
    hint: GLenum,
    verify: VerifyType,
}

impl TestCase for SingleBufferCopyCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        struct CopyRange {
            src_offset: i32,
            dst_offset: i32,
            copy_size: i32,
        }

        const COPY_RANGES: [CopyRange; 4] = [
            // Non-adjecent, from low to high.
            CopyRange { src_offset: 57, dst_offset: 701, copy_size: 101 },
            // Non-adjecent, from high to low.
            CopyRange { src_offset: 640, dst_offset: 101, copy_size: 101 },
            // Lower half to upper half.
            CopyRange { src_offset: 0, dst_offset: 500, copy_size: 500 },
            // Upper half to lower half.
            CopyRange { src_offset: 500, dst_offset: 0, copy_size: 500 },
        ];

        let size = 1000;
        let gl = context.gl();
        let verifier = BufferVerifier::new(gl, self.verify)?;
        let base_seed = de_string_hash(&self.name);
        let mut is_ok = true;

        let mut ref_buf = vec![0u8; size as usize];

        // Create buffer.
        let buf = Buffer::new(gl);
        // SAFETY: binding the buffer this case owns.
        unsafe { gl.bind_buffer(self.src_target, buf.get()) };

        for (ndx, range) in COPY_RANGES.iter().enumerate() {
            if !is_ok {
                break;
            }

            fill_with_random_bytes(&mut ref_buf, base_seed ^ de_int32_hash(ndx as i32));

            // Fill with data.
            // SAFETY: the data pointer covers exactly `size` bytes.
            unsafe {
                gl.bind_buffer(self.src_target, buf.get());
                gl.buffer_data(self.src_target, size as isize, ref_buf.as_ptr().cast(), self.hint);
            }
            check_error(gl)?;

            // Execute copy.
            {
                let src_start = range.src_offset as usize;
                let dst_start = range.dst_offset as usize;
                let len = range.copy_size as usize;
                let copied: Vec<u8> = ref_buf[src_start..src_start + len].to_vec();
                ref_buf[dst_start..dst_start + len].copy_from_slice(&copied);
            }

            // SAFETY: both targets have the same buffer bound and the range is inside it.
            unsafe {
                gl.bind_buffer(self.dst_target, buf.get());
                gl.copy_buffer_sub_data(
                    self.src_target,
                    self.dst_target,
                    range.src_offset as isize,
                    range.dst_offset as isize,
                    range.copy_size as isize,
                );
            }
            check_error(gl)?;

            // Verify buffer after copy.
            is_ok = verifier.verify(context, buf.get(), &ref_buf, 0, size)? && is_ok;
        }

        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Buffer verification failed")
        })
    }
}

/// `BufferCopyTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("copy");

    // .basic
    {
        let mut basic_group = TestCaseGroup::new("basic");

        for (src_ndx, src_target) in BUFFER_TARGETS.iter().copied().enumerate() {
            for (dst_ndx, dst_target) in BUFFER_TARGETS.iter().copied().enumerate() {
                if src_ndx == dst_ndx {
                    continue;
                }

                let size = 1017;
                let hint = glw::GL_STATIC_DRAW;
                let verify = VerifyType::VertexArray;
                let name = format!("{}_{}", get_buffer_target_name(src_target), get_buffer_target_name(dst_target));

                basic_group.add_child(Box::new(BasicBufferCopyCase {
                    name,
                    src_target,
                    src_size: size,
                    src_hint: hint,
                    dst_target,
                    dst_size: size,
                    dst_hint: hint,
                    copy_src_offset: 0,
                    copy_dst_offset: 0,
                    copy_size: size,
                    verify,
                }) as Box<dyn TestCase>);
            }
        }

        group.add_child(basic_group);
    }

    // .subrange
    {
        let mut subrange_group = TestCaseGroup::new("subrange");

        struct SubrangeCase {
            name: &'static str,
            src_size: i32,
            dst_size: i32,
            src_offset: i32,
            dst_offset: i32,
            copy_size: i32,
        }

        const CASES: [SubrangeCase; 7] = [
            SubrangeCase { name: "middle", src_size: 1000, dst_size: 1000, src_offset: 250, dst_offset: 250, copy_size: 500 },
            SubrangeCase { name: "small_to_large", src_size: 100, dst_size: 1000, src_offset: 0, dst_offset: 409, copy_size: 100 },
            SubrangeCase { name: "large_to_small", src_size: 1000, dst_size: 100, src_offset: 409, dst_offset: 0, copy_size: 100 },
            SubrangeCase { name: "low_to_high_1", src_size: 1000, dst_size: 1000, src_offset: 0, dst_offset: 500, copy_size: 500 },
            SubrangeCase { name: "low_to_high_2", src_size: 997, dst_size: 1027, src_offset: 0, dst_offset: 701, copy_size: 111 },
            SubrangeCase { name: "high_to_low_1", src_size: 1000, dst_size: 1000, src_offset: 500, dst_offset: 0, copy_size: 500 },
            SubrangeCase { name: "high_to_low_2", src_size: 1027, dst_size: 997, src_offset: 701, dst_offset: 17, copy_size: 111 },
        ];

        for case in &CASES {
            let src_target = glw::GL_COPY_READ_BUFFER;
            let dst_target = glw::GL_COPY_WRITE_BUFFER;
            let hint = glw::GL_STATIC_DRAW;
            let verify = VerifyType::VertexArray;

            subrange_group.add_child(Box::new(BasicBufferCopyCase {
                name: case.name.to_string(),
                src_target,
                src_size: case.src_size,
                src_hint: hint,
                dst_target,
                dst_size: case.dst_size,
                dst_hint: hint,
                copy_src_offset: case.src_offset,
                copy_dst_offset: case.dst_offset,
                copy_size: case.copy_size,
                verify,
            }) as Box<dyn TestCase>);
        }

        group.add_child(subrange_group);
    }

    // .single_buffer
    {
        let mut single_buf_group = TestCaseGroup::new("single_buffer");

        for (src_ndx, src_target) in BUFFER_TARGETS.iter().copied().enumerate() {
            for (dst_ndx, dst_target) in BUFFER_TARGETS.iter().copied().enumerate() {
                if src_ndx == dst_ndx {
                    continue;
                }

                let hint = glw::GL_STATIC_DRAW;
                let verify = VerifyType::VertexArray;
                let name = format!("{}_{}", get_buffer_target_name(src_target), get_buffer_target_name(dst_target));

                single_buf_group.add_child(Box::new(SingleBufferCopyCase {
                    name,
                    src_target,
                    dst_target,
                    hint,
                    verify,
                }) as Box<dyn TestCase>);
            }
        }

        group.add_child(single_buf_group);
    }

    group
}
