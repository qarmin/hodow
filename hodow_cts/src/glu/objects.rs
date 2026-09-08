// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluObjectWrapper.hpp / .cpp  (glu::ObjectWrapper and the
//   DECLARE_OBJECT_WRAPPER instantiations)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream generates these with a
// macro over (gen, delete) function pairs; this does the same, so adding a wrapper
// stays one line here as it is one line there.

use crate::glw::{self, GLuint};

macro_rules! object_wrapper {
    ($name:ident, $gen:ident, $delete:ident, $what:literal) => {
        #[doc = concat!("`glu::", stringify!($name), "` - a GL ", $what, " deleted when it goes out of scope.")]
        pub struct $name<'gl> {
            gl: &'gl glw::Functions,
            name: GLuint,
        }

        impl<'gl> $name<'gl> {
            pub fn new(gl: &'gl glw::Functions) -> Self {
                let mut name = 0;
                // SAFETY: one object is asked for and one GLuint of output is given.
                unsafe { gl.$gen(1, &mut name) };
                Self { gl, name }
            }

            /// Upstream spells this `*object`.
            pub fn get(&self) -> GLuint {
                self.name
            }
        }

        impl Drop for $name<'_> {
            fn drop(&mut self) {
                // SAFETY: the name is this wrapper's own and is deleted exactly once.
                unsafe { self.gl.$delete(1, &self.name) };
            }
        }
    };
}

object_wrapper!(Buffer, gen_buffers, delete_buffers, "buffer");
object_wrapper!(Texture, gen_textures, delete_textures, "texture");
object_wrapper!(Framebuffer, gen_framebuffers, delete_framebuffers, "framebuffer");
object_wrapper!(Renderbuffer, gen_renderbuffers, delete_renderbuffers, "renderbuffer");
object_wrapper!(VertexArray, gen_vertex_arrays, delete_vertex_arrays, "vertex array");
object_wrapper!(Query, gen_queries, delete_queries, "query object");
object_wrapper!(ProgramPipeline, gen_program_pipelines, delete_program_pipelines, "program pipeline");

/// `BufferMemMap` from the ES 3.1 test modules - a mapped buffer range, unmapped on
/// drop.
///
/// It is declared in more than one upstream test file (each with its own copy); one
/// copy here serves all of them.
pub struct BufferMemMap<'gl> {
    gl: &'gl glw::Functions,
    target: u32,
    pointer: *mut std::ffi::c_void,
}

impl<'gl> BufferMemMap<'gl> {
    /// Maps `size` bytes at `offset`. `None` means the driver refused the map, which
    /// upstream turns into a failure through `TCU_CHECK`.
    pub fn new(gl: &'gl glw::Functions, target: u32, offset: isize, size: isize, access: u32) -> Option<Self> {
        // SAFETY: the range is the caller's, and a driver that rejects it answers null
        // rather than writing anywhere.
        let pointer = unsafe { gl.map_buffer_range(target, offset, size, access) };
        (!pointer.is_null()).then_some(Self { gl, target, pointer })
    }

    pub fn get(&self) -> *mut std::ffi::c_void {
        self.pointer
    }

    /// Reads `count` values of `T` from the mapping, `stride` bytes apart, starting at
    /// `offset` - which is how every SSBO check in the ES 3.1 tests reads its results,
    /// because the layout comes from the interface query rather than from Rust.
    ///
    /// # Safety
    /// `offset + stride * count` must stay inside the mapped range, and the mapping
    /// must have been made readable.
    pub unsafe fn read_strided<T: Copy>(&self, offset: usize, stride: usize, count: usize) -> Vec<T> {
        (0..count)
            .map(|index| unsafe { self.pointer.byte_add(offset + stride * index).cast::<T>().read_unaligned() })
            .collect()
    }

    /// The mirror of `read_strided`.
    ///
    /// # Safety
    /// As above, for a mapping made writable.
    pub unsafe fn write_strided<T: Copy>(&self, offset: usize, stride: usize, values: &[T]) {
        for (index, value) in values.iter().enumerate() {
            unsafe { self.pointer.byte_add(offset + stride * index).cast::<T>().write_unaligned(*value) };
        }
    }
}

impl Drop for BufferMemMap<'_> {
    fn drop(&mut self) {
        // SAFETY: the target still holds the buffer this mapping was made from - the
        // tests never rebind it while a map is live, exactly as upstream does not.
        unsafe { self.gl.unmap_buffer(self.target) };
    }
}
