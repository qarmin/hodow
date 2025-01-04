// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fBufferMapTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `gls::BufferTestUtil` is
// `gls::buffer_test_util` here, and `ReferenceBuffer` is a plain `Vec<u8>` - upstream's
// wrapper exists only to hand out `getPtr(offset)`, which is a slice here.
//
// The seven case classes share the same three-step shape (fill a reference buffer, do
// something to a mapping of the GL buffer, verify), so they are one struct over a
// `MapCase` enum rather than seven, which keeps the shared preamble in one place.

use crate::gls::buffer_test_util::{
    BufferVerifier, VerifyType, WriteType, check_error, compare_byte_arrays, fill_with_random_bytes,
    get_buffer_target_name, get_usage_hint_name, write_buffer,
};
use crate::glu::{Buffer, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::tcu::random::de_string_hash;
use crate::tcu::{TestError, TestOutcome, TestStatus};

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

const USAGE_HINTS: [GLenum; 9] = [
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

/// `BufferMapTests::init`'s `bufferUses` - the three verify types the `.write` and
/// `.read_write` groups fan out over.
const BUFFER_USES: [(&str, VerifyType); 3] = [
    ("map_read", VerifyType::BufferReadMap),
    ("render_as_vertex_array", VerifyType::VertexArray),
    ("render_as_index_array", VerifyType::IndexArray),
];

/// The shared constants of the five cases that do not take a size from the group.
const INVALIDATE_BUFFER_SIZE: i32 = 1300;
const INVALIDATE_MAP_OFFSET: i32 = 200;
const INVALIDATE_MAP_SIZE: i32 = 1011;

/// Which of upstream's seven `BufferCase` subclasses this is.
enum MapCase {
    /// `BufferMapReadCase`
    Read {
        buffer_size: i32,
        map_offset: i32,
        map_size: i32,
        write: WriteType,
    },
    /// `BufferMapWriteCase`
    Write { size: i32, verify: VerifyType },
    /// `BufferPartialMapWriteCase`
    PartialWrite {
        buffer_size: i32,
        map_offset: i32,
        map_size: i32,
        verify: VerifyType,
    },
    /// `BufferMapInvalidateCase`
    Invalidate { partial_write: bool, verify: VerifyType },
    /// `BufferMapPartialInvalidateCase`
    PartialInvalidate { partial_write: bool, verify: VerifyType },
    /// `BufferMapExplicitFlushCase`
    ExplicitFlush { partial_write: bool, verify: VerifyType },
    /// `BufferMapUnsyncWriteCase`
    UnsyncWrite,
    /// `BufferMapReadWriteCase`
    ReadWrite {
        buffer_size: i32,
        map_offset: i32,
        map_size: i32,
        verify: VerifyType,
    },
}

struct BufferMapCase {
    name: String,
    buffer_target: GLenum,
    usage: GLenum,
    kind: MapCase,
}

/// `glMapBufferRange` plus the `TCU_CHECK(ptr)` upstream follows it with.
///
/// # Safety
/// The returned pointer is only valid until the matching `glUnmapBuffer`, and only for
/// `length` bytes.
unsafe fn map_range(
    gl: &glw::Functions,
    target: GLenum,
    offset: i32,
    length: i32,
    access: u32,
) -> Result<*mut std::ffi::c_void, TestError> {
    // SAFETY: the caller's range, which every caller here has just allocated.
    let ptr = unsafe { gl.map_buffer_range(target, offset as isize, length as isize, access) };
    check_error(gl)?;
    if ptr.is_null() {
        return Err(TestError::Fail("glMapBufferRange returned null".to_string()));
    }
    Ok(ptr)
}

/// Copies `src` into the mapping at `dst_offset` bytes past `ptr`.
///
/// # Safety
/// `ptr` must be a live mapping of at least `dst_offset + src.len()` bytes.
unsafe fn write_mapping(ptr: *mut std::ffi::c_void, dst_offset: i32, src: &[u8]) {
    // SAFETY: the caller guarantees the mapping covers the range.
    unsafe { std::ptr::copy_nonoverlapping(src.as_ptr(), ptr.cast::<u8>().add(dst_offset as usize), src.len()) };
}

impl BufferMapCase {
    /// `glBufferData` with either the reference contents or nothing, plus the error check.
    fn make_buffer<'gl>(
        &self,
        gl: &'gl glw::Functions,
        size: i32,
        data: Option<&[u8]>,
    ) -> Result<Buffer<'gl>, TestError> {
        let buf = Buffer::new(gl);
        // SAFETY: the pointer, where given, covers exactly `size` bytes.
        unsafe {
            gl.bind_buffer(self.buffer_target, buf.get());
            gl.buffer_data(
                self.buffer_target,
                size as isize,
                data.map_or(std::ptr::null(), |d| d.as_ptr().cast()),
                self.usage,
            );
        }
        check_error(gl)?;
        Ok(buf)
    }

    /// `BufferMapReadCase::iterate`
    fn iterate_read(
        &self,
        context: &Context,
        buffer_size: i32,
        map_offset: i32,
        map_size: i32,
        write: WriteType,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let data_seed = de_string_hash(&self.name);

        let mut ref_buf = vec![0u8; buffer_size as usize];
        fill_with_random_bytes(&mut ref_buf, data_seed);

        let buf = self.make_buffer(gl, buffer_size, None)?;
        write_buffer(gl, write, buf.get(), 0, &ref_buf, self.buffer_target)?;

        // SAFETY: the mapped range is inside the buffer allocated above, and is read
        // through a slice of exactly `map_size` before being unmapped.
        let is_ok = unsafe {
            gl.bind_buffer(self.buffer_target, buf.get());
            let ptr = map_range(gl, self.buffer_target, map_offset, map_size, glw::GL_MAP_READ_BIT)?;
            let mapped = std::slice::from_raw_parts(ptr.cast::<u8>(), map_size as usize);
            let is_ok = compare_byte_arrays(mapped, &ref_buf[map_offset as usize..(map_offset + map_size) as usize]);
            gl.unmap_buffer(self.buffer_target);
            check_error(gl)?;
            is_ok
        };

        Ok(is_ok)
    }

    /// `BufferMapWriteCase::iterate`
    fn iterate_write(&self, context: &Context, size: i32, verify: VerifyType) -> Result<bool, TestError> {
        let gl = context.gl();
        let verifier = BufferVerifier::new(gl, verify)?;
        let data_seed = de_string_hash(&self.name);

        let mut ref_buf = vec![0u8; size as usize];
        fill_with_random_bytes(&mut ref_buf, data_seed);

        let buf = self.make_buffer(gl, size, None)?;

        // SAFETY: the mapping covers the whole buffer just allocated.
        unsafe {
            let ptr = map_range(gl, self.buffer_target, 0, size, glw::GL_MAP_WRITE_BIT)?;
            // Upstream fills the mapping directly with the same seed rather than
            // copying the reference, which is the same bytes either way.
            write_mapping(ptr, 0, &ref_buf);
            gl.unmap_buffer(self.buffer_target);
        }
        check_error(gl)?;

        verifier.verify_with_target(context, buf.get(), &ref_buf, 0, size, self.buffer_target)
    }

    /// `BufferPartialMapWriteCase::iterate`
    fn iterate_partial_write(
        &self,
        context: &Context,
        buffer_size: i32,
        map_offset: i32,
        map_size: i32,
        verify: VerifyType,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let verifier = BufferVerifier::new(gl, verify)?;
        let data_seed = de_string_hash(&self.name);

        let mut ref_buf = vec![0u8; buffer_size as usize];
        fill_with_random_bytes(&mut ref_buf, data_seed);

        let buf = self.make_buffer(gl, buffer_size, Some(&ref_buf))?;

        // Do reference map.
        fill_with_random_bytes(
            &mut ref_buf[map_offset as usize..(map_offset + map_size) as usize],
            data_seed & 0xabcdef,
        );

        // SAFETY: the mapped range is inside the buffer allocated above.
        unsafe {
            let ptr = map_range(gl, self.buffer_target, map_offset, map_size, glw::GL_MAP_WRITE_BIT)?;
            write_mapping(ptr, 0, &ref_buf[map_offset as usize..(map_offset + map_size) as usize]);
            gl.unmap_buffer(self.buffer_target);
        }
        check_error(gl)?;

        verifier.verify_with_target(context, buf.get(), &ref_buf, 0, buffer_size, self.buffer_target)
    }

    /// `BufferMapInvalidateCase::iterate` and `BufferMapPartialInvalidateCase::iterate`,
    /// which differ only in the access bit and in what range they verify afterwards.
    fn iterate_invalidate(
        &self,
        context: &Context,
        partial_write: bool,
        verify: VerifyType,
        whole_buffer: bool,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let verifier = BufferVerifier::new(gl, verify)?;
        let data_seed = de_string_hash(&self.name);
        let map_write_offs = if partial_write { 91 } else { 0 };
        let written = INVALIDATE_MAP_OFFSET + map_write_offs;
        let (verify_offset, verify_size) = if whole_buffer {
            (written, INVALIDATE_MAP_SIZE - map_write_offs)
        } else {
            let offset = if partial_write { written } else { 0 };
            (offset, INVALIDATE_BUFFER_SIZE - offset)
        };
        let access = glw::GL_MAP_WRITE_BIT
            | if whole_buffer {
                glw::GL_MAP_INVALIDATE_BUFFER_BIT
            } else {
                glw::GL_MAP_INVALIDATE_RANGE_BIT
            };

        let mut ref_buf = vec![0u8; INVALIDATE_BUFFER_SIZE as usize];
        fill_with_random_bytes(&mut ref_buf, data_seed);

        let buf = self.make_buffer(gl, INVALIDATE_BUFFER_SIZE, Some(&ref_buf))?;

        // Do reference map.
        fill_with_random_bytes(
            &mut ref_buf[written as usize..(INVALIDATE_MAP_OFFSET + INVALIDATE_MAP_SIZE) as usize],
            data_seed & 0xabcdef,
        );

        // SAFETY: the mapped range is inside the buffer allocated above, and the write
        // starts `map_write_offs` into a mapping of `INVALIDATE_MAP_SIZE` bytes.
        unsafe {
            let ptr = map_range(
                gl,
                self.buffer_target,
                INVALIDATE_MAP_OFFSET,
                INVALIDATE_MAP_SIZE,
                access,
            )?;
            write_mapping(
                ptr,
                map_write_offs,
                &ref_buf[written as usize..(INVALIDATE_MAP_OFFSET + INVALIDATE_MAP_SIZE) as usize],
            );
            gl.unmap_buffer(self.buffer_target);
        }
        check_error(gl)?;

        verifier.verify_with_target(
            context,
            buf.get(),
            &ref_buf,
            verify_offset,
            verify_size,
            self.buffer_target,
        )
    }

    /// `BufferMapExplicitFlushCase::iterate`
    fn iterate_explicit_flush(
        &self,
        context: &Context,
        partial_write: bool,
        verify: VerifyType,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let verifier = BufferVerifier::new(gl, verify)?;
        let data_seed = de_string_hash(&self.name);
        let slice_a_offs = if partial_write { 1 } else { 0 };
        let slice_a_size = if partial_write { 96 } else { 473 };
        let slice_b_offs = if partial_write {
            503
        } else {
            slice_a_offs + slice_a_size
        };
        let slice_b_size = INVALIDATE_MAP_SIZE - slice_b_offs;

        let mut ref_buf = vec![0u8; INVALIDATE_BUFFER_SIZE as usize];
        fill_with_random_bytes(&mut ref_buf, data_seed);

        let buf = self.make_buffer(gl, INVALIDATE_BUFFER_SIZE, Some(&ref_buf))?;

        // Do reference map.
        fill_with_random_bytes(
            &mut ref_buf[INVALIDATE_MAP_OFFSET as usize..(INVALIDATE_MAP_OFFSET + INVALIDATE_MAP_SIZE) as usize],
            data_seed & 0xabcdef,
        );

        // SAFETY: the mapped range is inside the buffer allocated above, and both
        // flushed slices are inside the mapping.
        unsafe {
            let ptr = map_range(
                gl,
                self.buffer_target,
                INVALIDATE_MAP_OFFSET,
                INVALIDATE_MAP_SIZE,
                glw::GL_MAP_WRITE_BIT | glw::GL_MAP_FLUSH_EXPLICIT_BIT,
            )?;
            write_mapping(
                ptr,
                0,
                &ref_buf[INVALIDATE_MAP_OFFSET as usize..(INVALIDATE_MAP_OFFSET + INVALIDATE_MAP_SIZE) as usize],
            );

            gl.flush_mapped_buffer_range(self.buffer_target, slice_a_offs as isize, slice_a_size as isize);
            check_error(gl)?;
            gl.flush_mapped_buffer_range(self.buffer_target, slice_b_offs as isize, slice_b_size as isize);
            check_error(gl)?;

            gl.unmap_buffer(self.buffer_target);
        }
        check_error(gl)?;

        // Only the flushed slices are guaranteed to have reached the buffer.
        if partial_write {
            let a = verifier.verify_with_target(
                context,
                buf.get(),
                &ref_buf,
                INVALIDATE_MAP_OFFSET + slice_a_offs,
                slice_a_size,
                self.buffer_target,
            )?;
            let b = verifier.verify_with_target(
                context,
                buf.get(),
                &ref_buf,
                INVALIDATE_MAP_OFFSET + slice_b_offs,
                slice_b_size,
                self.buffer_target,
            )?;
            Ok(a && b)
        } else {
            verifier.verify_with_target(
                context,
                buf.get(),
                &ref_buf,
                INVALIDATE_MAP_OFFSET,
                INVALIDATE_MAP_SIZE,
                self.buffer_target,
            )
        }
    }

    /// `BufferMapUnsyncWriteCase::iterate`
    fn iterate_unsync_write(&self, context: &Context) -> Result<bool, TestError> {
        let gl = context.gl();
        let verifier = BufferVerifier::new(gl, VerifyType::VertexArray)?;
        let data_seed = de_string_hash(&self.name);
        let size = 1200;

        let mut ref_buf = vec![0u8; size as usize];
        fill_with_random_bytes(&mut ref_buf, data_seed);

        let buf = self.make_buffer(gl, size, Some(&ref_buf))?;

        // Use for rendering. \note ReadPixels() implies Finish.
        let mut is_ok = verifier.verify(context, buf.get(), &ref_buf, 0, size)?;

        // SAFETY: the mapping covers the whole buffer allocated above.
        unsafe {
            gl.bind_buffer(self.buffer_target, buf.get());
            let ptr = map_range(
                gl,
                self.buffer_target,
                0,
                size,
                glw::GL_MAP_WRITE_BIT | glw::GL_MAP_UNSYNCHRONIZED_BIT,
            )?;

            fill_with_random_bytes(&mut ref_buf, data_seed & 0xabcdef);
            write_mapping(ptr, 0, &ref_buf);

            gl.unmap_buffer(self.buffer_target);
            check_error(gl)?;

            // Synchronize.
            gl.finish();
        }

        is_ok = verifier.verify(context, buf.get(), &ref_buf, 0, size)? && is_ok;
        Ok(is_ok)
    }

    /// `BufferMapReadWriteCase::iterate`
    fn iterate_read_write(
        &self,
        context: &Context,
        buffer_size: i32,
        map_offset: i32,
        map_size: i32,
        verify: VerifyType,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let verifier = BufferVerifier::new(gl, verify)?;
        let data_seed = de_string_hash(&self.name);

        let mut ref_buf = vec![0u8; buffer_size as usize];
        fill_with_random_bytes(&mut ref_buf, data_seed);

        let buf = self.make_buffer(gl, buffer_size, Some(&ref_buf))?;

        // Verify before mapping.
        let mut is_ok =
            verifier.verify_with_target(context, buf.get(), &ref_buf, 0, buffer_size, self.buffer_target)?;

        // SAFETY: the mapped range is inside the buffer allocated above, and is both
        // read and written through slices of exactly `map_size`.
        unsafe {
            gl.bind_buffer(self.buffer_target, buf.get());
            let ptr = map_range(
                gl,
                self.buffer_target,
                map_offset,
                map_size,
                glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT,
            )?;

            // Compare mapped ptr.
            let mapped = std::slice::from_raw_parts(ptr.cast::<u8>(), map_size as usize);
            if !compare_byte_arrays(mapped, &ref_buf[map_offset as usize..(map_offset + map_size) as usize]) {
                is_ok = false;
            }

            fill_with_random_bytes(
                &mut ref_buf[map_offset as usize..(map_offset + map_size) as usize],
                data_seed & 0xabcdef,
            );
            write_mapping(ptr, 0, &ref_buf[map_offset as usize..(map_offset + map_size) as usize]);

            gl.unmap_buffer(self.buffer_target);
        }
        check_error(gl)?;

        // Compare final buffer.
        is_ok = verifier.verify_with_target(context, buf.get(), &ref_buf, 0, buffer_size, self.buffer_target)? && is_ok;
        Ok(is_ok)
    }
}

impl TestCase for BufferMapCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let is_ok = match self.kind {
            MapCase::Read {
                buffer_size,
                map_offset,
                map_size,
                write,
            } => self.iterate_read(context, buffer_size, map_offset, map_size, write)?,
            MapCase::Write { size, verify } => self.iterate_write(context, size, verify)?,
            MapCase::PartialWrite {
                buffer_size,
                map_offset,
                map_size,
                verify,
            } => self.iterate_partial_write(context, buffer_size, map_offset, map_size, verify)?,
            MapCase::Invalidate { partial_write, verify } => {
                self.iterate_invalidate(context, partial_write, verify, true)?
            }
            MapCase::PartialInvalidate { partial_write, verify } => {
                self.iterate_invalidate(context, partial_write, verify, false)?
            }
            MapCase::ExplicitFlush { partial_write, verify } => {
                self.iterate_explicit_flush(context, partial_write, verify)?
            }
            MapCase::UnsyncWrite => self.iterate_unsync_write(context)?,
            MapCase::ReadWrite {
                buffer_size,
                map_offset,
                map_size,
                verify,
            } => self.iterate_read_write(context, buffer_size, map_offset, map_size, verify)?,
        };

        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Buffer verification failed")
        })
    }
}

fn case(name: String, buffer_target: GLenum, usage: GLenum, kind: MapCase) -> Box<dyn TestCase> {
    Box::new(BufferMapCase {
        name,
        buffer_target,
        usage,
        kind,
    })
}

const SIZE: i32 = 1019;
const PARTIAL_OFFS: i32 = 17;
const PARTIAL_SIZE: i32 = 501;

/// `BufferMapTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("map");
    group.add_child(create_read_group());
    group.add_child(create_write_group());
    group.add_child(create_read_write_group());
    group
}

/// `.read`
fn create_read_group() -> TestCaseGroup {
    let mut map_read_group = TestCaseGroup::new("read");

    // .[data src]
    for (name, write) in [
        ("sub_data", WriteType::BufferSubData),
        ("map_write", WriteType::BufferWriteMap),
    ] {
        let mut write_group = TestCaseGroup::new(name);

        for target in BUFFER_TARGETS {
            let hint = glw::GL_STATIC_READ;
            let target_name = get_buffer_target_name(target);

            write_group.add_child(case(
                format!("{target_name}_full"),
                target,
                hint,
                MapCase::Read {
                    buffer_size: SIZE,
                    map_offset: 0,
                    map_size: SIZE,
                    write,
                },
            ));
            write_group.add_child(case(
                format!("{target_name}_partial"),
                target,
                hint,
                MapCase::Read {
                    buffer_size: SIZE,
                    map_offset: PARTIAL_OFFS,
                    map_size: PARTIAL_SIZE,
                    write,
                },
            ));
        }

        map_read_group.add_child(write_group);
    }

    // .usage_hints
    let mut hints_group = TestCaseGroup::new("usage_hints");
    for target in BUFFER_TARGETS {
        for hint in USAGE_HINTS {
            let name = format!("{}_{}", get_buffer_target_name(target), get_usage_hint_name(hint));
            hints_group.add_child(case(
                name,
                target,
                hint,
                MapCase::Read {
                    buffer_size: SIZE,
                    map_offset: 0,
                    map_size: SIZE,
                    write: WriteType::BufferSubData,
                },
            ));
        }
    }
    map_read_group.add_child(hints_group);

    map_read_group
}

/// `.write`
fn create_write_group() -> TestCaseGroup {
    let mut map_write_group = TestCaseGroup::new("write");

    // .[verify type]
    for (name, verify) in BUFFER_USES {
        let mut use_group = TestCaseGroup::new(name);

        for target in BUFFER_TARGETS {
            let hint = glw::GL_STATIC_DRAW;
            let target_name = get_buffer_target_name(target);

            use_group.add_child(case(
                format!("{target_name}_full"),
                target,
                hint,
                MapCase::Write { size: SIZE, verify },
            ));
            use_group.add_child(case(
                format!("{target_name}_partial"),
                target,
                hint,
                MapCase::PartialWrite {
                    buffer_size: SIZE,
                    map_offset: PARTIAL_OFFS,
                    map_size: PARTIAL_SIZE,
                    verify,
                },
            ));
        }

        map_write_group.add_child(use_group);
    }

    // .usage_hints
    let mut hints_group = TestCaseGroup::new("usage_hints");
    for target in BUFFER_TARGETS {
        for hint in USAGE_HINTS {
            let name = format!("{}_{}", get_buffer_target_name(target), get_usage_hint_name(hint));
            hints_group.add_child(case(
                name,
                target,
                hint,
                MapCase::Write {
                    size: SIZE,
                    verify: VerifyType::VertexArray,
                },
            ));
        }
    }
    map_write_group.add_child(hints_group);

    // .invalidate / .partial_invalidate / .explicit_flush - the same two-case shape
    // over every target, differing only in the map bit and the suffix pair.
    for (group_name, suffixes) in [
        ("invalidate", ["_write_all", "_write_partial"]),
        ("partial_invalidate", ["_write_all", "_write_partial"]),
        ("explicit_flush", ["_all", "_partial"]),
    ] {
        let mut sub_group = TestCaseGroup::new(group_name);

        for target in BUFFER_TARGETS {
            let hint = glw::GL_STATIC_DRAW;
            let target_name = get_buffer_target_name(target);

            for (suffix, partial_write) in suffixes.into_iter().zip([false, true]) {
                let verify = VerifyType::VertexArray;
                let kind = match group_name {
                    "invalidate" => MapCase::Invalidate { partial_write, verify },
                    "partial_invalidate" => MapCase::PartialInvalidate { partial_write, verify },
                    _ => MapCase::ExplicitFlush { partial_write, verify },
                };
                sub_group.add_child(case(format!("{target_name}{suffix}"), target, hint, kind));
            }
        }

        map_write_group.add_child(sub_group);
    }

    // .unsynchronized
    let mut unsync_group = TestCaseGroup::new("unsynchronized");
    for target in BUFFER_TARGETS {
        unsync_group.add_child(case(
            get_buffer_target_name(target).to_string(),
            target,
            glw::GL_STATIC_DRAW,
            MapCase::UnsyncWrite,
        ));
    }
    map_write_group.add_child(unsync_group);

    map_write_group
}

/// `.read_write`
fn create_read_write_group() -> TestCaseGroup {
    let mut map_read_write_group = TestCaseGroup::new("read_write");

    // .[verify type]
    for (name, verify) in BUFFER_USES {
        let mut use_group = TestCaseGroup::new(name);

        for target in BUFFER_TARGETS {
            let hint = glw::GL_STATIC_DRAW;
            let target_name = get_buffer_target_name(target);

            use_group.add_child(case(
                format!("{target_name}_full"),
                target,
                hint,
                MapCase::ReadWrite {
                    buffer_size: SIZE,
                    map_offset: 0,
                    map_size: SIZE,
                    verify,
                },
            ));
            use_group.add_child(case(
                format!("{target_name}_partial"),
                target,
                hint,
                MapCase::ReadWrite {
                    buffer_size: SIZE,
                    map_offset: PARTIAL_OFFS,
                    map_size: PARTIAL_SIZE,
                    verify,
                },
            ));
        }

        map_read_write_group.add_child(use_group);
    }

    // .usage_hints
    let mut hints_group = TestCaseGroup::new("usage_hints");
    for target in BUFFER_TARGETS {
        for hint in USAGE_HINTS {
            let name = format!("{}_{}", get_buffer_target_name(target), get_usage_hint_name(hint));
            hints_group.add_child(case(
                name,
                target,
                hint,
                MapCase::ReadWrite {
                    buffer_size: SIZE,
                    map_offset: 0,
                    map_size: SIZE,
                    verify: VerifyType::VertexArray,
                },
            ));
        }
    }
    map_read_write_group.add_child(hints_group);

    map_read_write_group
}
