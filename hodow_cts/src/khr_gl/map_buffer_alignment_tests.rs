// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cMapBufferAlignmentTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream deletes the buffer in a `catch` and rethrows as `TCU_FAIL`; here the loop body is a closure whose error is the same Fail, with the buffer deleted afterwards.

use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `MapBufferAlignment::Query`
struct Query;

impl Query {
    const MIN_MAP_BUFFER_ALIGNMENT: GLint = 64;
}

impl TestCase for Query {
    fn name(&self) -> &str {
        "query"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut min_map_buffer_alignment: GLint = 0;
        // SAFETY: one GLint out.
        unsafe { gl.get_integerv(glw::GL_MIN_MAP_BUFFER_ALIGNMENT, &mut min_map_buffer_alignment) };
        glu::expect_no_error(gl, "GetIntegerv")?;

        if Self::MIN_MAP_BUFFER_ALIGNMENT > min_map_buffer_alignment {
            Ok(TestStatus::fail("Fail"))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

/// `MapBufferAlignment::BufferEnums`
struct BufferEnums {
    target: GLenum,
    max_size: GLenum,
}

/// `MapBufferAlignment::Functional`
struct Functional;

const STORAGE_FLAGS: [GLenum; 24] = [
    glw::GL_MAP_READ_BIT,
    glw::GL_MAP_WRITE_BIT,
    glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT,
    glw::GL_DYNAMIC_STORAGE_BIT | glw::GL_MAP_READ_BIT,
    glw::GL_DYNAMIC_STORAGE_BIT | glw::GL_MAP_WRITE_BIT,
    glw::GL_DYNAMIC_STORAGE_BIT | glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT,
    glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_READ_BIT,
    glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_WRITE_BIT,
    glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT,
    glw::GL_MAP_PERSISTENT_BIT | glw::GL_DYNAMIC_STORAGE_BIT | glw::GL_MAP_READ_BIT,
    glw::GL_MAP_PERSISTENT_BIT | glw::GL_DYNAMIC_STORAGE_BIT | glw::GL_MAP_WRITE_BIT,
    glw::GL_MAP_PERSISTENT_BIT | glw::GL_DYNAMIC_STORAGE_BIT | glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT,
    glw::GL_MAP_COHERENT_BIT | glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_READ_BIT,
    glw::GL_MAP_COHERENT_BIT | glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_WRITE_BIT,
    glw::GL_MAP_COHERENT_BIT | glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_READ_BIT | glw::GL_MAP_WRITE_BIT,
    glw::GL_MAP_COHERENT_BIT | glw::GL_MAP_PERSISTENT_BIT | glw::GL_DYNAMIC_STORAGE_BIT | glw::GL_MAP_READ_BIT,
    glw::GL_MAP_COHERENT_BIT | glw::GL_MAP_PERSISTENT_BIT | glw::GL_DYNAMIC_STORAGE_BIT | glw::GL_MAP_WRITE_BIT,
    glw::GL_MAP_COHERENT_BIT
        | glw::GL_MAP_PERSISTENT_BIT
        | glw::GL_DYNAMIC_STORAGE_BIT
        | glw::GL_MAP_READ_BIT
        | glw::GL_MAP_WRITE_BIT,
    glw::GL_CLIENT_STORAGE_BIT | glw::GL_MAP_COHERENT_BIT | glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_READ_BIT,
    glw::GL_CLIENT_STORAGE_BIT | glw::GL_MAP_COHERENT_BIT | glw::GL_MAP_PERSISTENT_BIT | glw::GL_MAP_WRITE_BIT,
    glw::GL_CLIENT_STORAGE_BIT
        | glw::GL_MAP_COHERENT_BIT
        | glw::GL_MAP_PERSISTENT_BIT
        | glw::GL_MAP_READ_BIT
        | glw::GL_MAP_WRITE_BIT,
    glw::GL_CLIENT_STORAGE_BIT
        | glw::GL_MAP_COHERENT_BIT
        | glw::GL_MAP_PERSISTENT_BIT
        | glw::GL_DYNAMIC_STORAGE_BIT
        | glw::GL_MAP_READ_BIT,
    glw::GL_CLIENT_STORAGE_BIT
        | glw::GL_MAP_COHERENT_BIT
        | glw::GL_MAP_PERSISTENT_BIT
        | glw::GL_DYNAMIC_STORAGE_BIT
        | glw::GL_MAP_WRITE_BIT,
    glw::GL_CLIENT_STORAGE_BIT
        | glw::GL_MAP_COHERENT_BIT
        | glw::GL_MAP_PERSISTENT_BIT
        | glw::GL_DYNAMIC_STORAGE_BIT
        | glw::GL_MAP_READ_BIT
        | glw::GL_MAP_WRITE_BIT,
];

const BUFFERS: [BufferEnums; 14] = [
    BufferEnums {
        target: glw::GL_ARRAY_BUFFER,
        max_size: glw::GL_MAX_VARYING_COMPONENTS,
    },
    BufferEnums {
        target: glw::GL_ATOMIC_COUNTER_BUFFER,
        max_size: glw::GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE,
    },
    BufferEnums {
        target: glw::GL_COPY_READ_BUFFER,
        max_size: 0,
    },
    BufferEnums {
        target: glw::GL_COPY_WRITE_BUFFER,
        max_size: 0,
    },
    BufferEnums {
        target: glw::GL_DISPATCH_INDIRECT_BUFFER,
        max_size: 0,
    },
    BufferEnums {
        target: glw::GL_DRAW_INDIRECT_BUFFER,
        max_size: 0,
    },
    BufferEnums {
        target: glw::GL_ELEMENT_ARRAY_BUFFER,
        max_size: glw::GL_MAX_ELEMENTS_INDICES,
    },
    BufferEnums {
        target: glw::GL_PIXEL_PACK_BUFFER,
        max_size: 0,
    },
    BufferEnums {
        target: glw::GL_PIXEL_UNPACK_BUFFER,
        max_size: 0,
    },
    BufferEnums {
        target: glw::GL_QUERY_BUFFER,
        max_size: 0,
    },
    BufferEnums {
        target: glw::GL_SHADER_STORAGE_BUFFER,
        max_size: glw::GL_MAX_SHADER_STORAGE_BLOCK_SIZE,
    },
    BufferEnums {
        target: glw::GL_TEXTURE_BUFFER,
        max_size: glw::GL_MAX_TEXTURE_BUFFER_SIZE,
    },
    BufferEnums {
        target: glw::GL_TRANSFORM_FEEDBACK_BUFFER,
        max_size: glw::GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS,
    },
    BufferEnums {
        target: glw::GL_UNIFORM_BUFFER,
        max_size: glw::GL_MAX_UNIFORM_BLOCK_SIZE,
    },
];

impl TestCase for Functional {
    fn name(&self) -> &str {
        "functional"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !context.context_info.is_extension_supported("GL_ARB_buffer_storage") {
            return Err(TestError::NotSupported(
                "GL_ARB_buffer_storage not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut buffer_id: GLuint = 0;

        // Get min alignment.
        let mut min_map_buffer_alignment: GLint = 0;
        // SAFETY: one GLint out.
        unsafe { gl.get_integerv(glw::GL_MIN_MAP_BUFFER_ALIGNMENT, &mut min_map_buffer_alignment) };
        glu::expect_no_error(gl, "GetIntegerv")?;

        // Prepare storage and data.
        let buffer_data_size = 2 * min_map_buffer_alignment as usize;
        let buffer_data: Vec<u8> = (0..buffer_data_size).map(|i| i as u8).collect();

        let mut test_result = true;

        let mut run = || -> Result<(), TestError> {
            for buffer in &BUFFERS {
                let mut buffer_size = buffer_data_size as GLint;

                // Get max size.
                if buffer.max_size != 0 {
                    // SAFETY: one GLint out.
                    unsafe { gl.get_integerv(buffer.max_size, &mut buffer_size) };
                    glu::expect_no_error(gl, "GetIntegerv")?;
                }

                match buffer.max_size {
                    glw::GL_MAX_VARYING_COMPONENTS | glw::GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS => {
                        buffer_size *= std::mem::size_of::<f32>() as GLint
                    }
                    glw::GL_MAX_ELEMENTS_INDICES => buffer_size *= std::mem::size_of::<GLuint>() as GLint,
                    _ => {}
                }

                buffer_size = buffer_size.min(buffer_data_size as GLint);
                let offset = (buffer_size - 1).min(min_map_buffer_alignment - 1) as GLuint;

                for storage_set in STORAGE_FLAGS {
                    // SAFETY: a buffer name out, then calls on the buffer bound to `buffer.target`; the data pointer covers `buffer_size` bytes.
                    unsafe {
                        // Prepare buffer.
                        gl.gen_buffers(1, &mut buffer_id);
                        glu::expect_no_error(gl, "GenBuffers")?;

                        gl.bind_buffer(buffer.target, buffer_id);
                        glu::expect_no_error(gl, "BindBuffer")?;

                        gl.buffer_storage(
                            buffer.target,
                            buffer_size as isize,
                            buffer_data.as_ptr().cast(),
                            storage_set,
                        );
                        glu::expect_no_error(gl, "BufferStorage")?;

                        // Test MapBuffer.
                        let map_buffer_access = if storage_set & glw::GL_MAP_READ_BIT == 0 {
                            glw::GL_WRITE_ONLY
                        } else if storage_set & glw::GL_MAP_WRITE_BIT == 0 {
                            glw::GL_READ_ONLY
                        } else {
                            glw::GL_READ_WRITE
                        };

                        let map_buffer_ptr = gl.map_buffer(buffer.target, map_buffer_access).cast::<u8>();
                        glu::expect_no_error(gl, "MapBuffer")?;

                        if map_buffer_access != glw::GL_WRITE_ONLY && !map_buffer_ptr.is_null() {
                            let mapped = std::slice::from_raw_parts(map_buffer_ptr, buffer_size as usize);
                            if mapped != &buffer_data[..buffer_size as usize] {
                                test_result = false;
                            }
                        }

                        gl.unmap_buffer(buffer.target);
                        glu::expect_no_error(gl, "UnmapBuffer")?;

                        // Test MapBufferRange.
                        const MAP_BUFFER_RANGE_ACCESS_MASK: GLenum =
                            glw::GL_DYNAMIC_STORAGE_BIT | glw::GL_CLIENT_STORAGE_BIT;
                        let map_buffer_range_access = storage_set & !MAP_BUFFER_RANGE_ACCESS_MASK;

                        let map_buffer_range_ptr = gl
                            .map_buffer_range(
                                buffer.target,
                                offset as isize,
                                (buffer_size as GLuint - offset) as isize,
                                map_buffer_range_access,
                            )
                            .cast::<u8>();
                        glu::expect_no_error(gl, "MapBufferRange")?;

                        if map_buffer_range_access & glw::GL_MAP_READ_BIT != 0 && !map_buffer_range_ptr.is_null() {
                            let length = buffer_size as usize - offset as usize;
                            let mapped = std::slice::from_raw_parts(map_buffer_range_ptr, length);
                            if mapped != &buffer_data[offset as usize..offset as usize + length] {
                                test_result = false;
                            }
                        }

                        gl.unmap_buffer(buffer.target);
                        glu::expect_no_error(gl, "UnmapBuffer")?;

                        gl.bind_buffer(buffer.target, 0);
                        glu::expect_no_error(gl, "BindBuffer")?;

                        // Remove buffer.
                        gl.delete_buffers(1, &buffer_id);
                        glu::expect_no_error(gl, "DeleteBuffers")?;
                        buffer_id = 0;

                        // Verify that pointers are properly aligned.
                        if (map_buffer_ptr as isize) % min_map_buffer_alignment as isize != 0 {
                            test_result = false;
                            break;
                        }
                        if ((map_buffer_range_ptr as isize) - offset as isize) % min_map_buffer_alignment as isize != 0
                        {
                            test_result = false;
                            break;
                        }
                    }
                }
            }
            Ok(())
        };

        if let Err(error) = run() {
            if buffer_id != 0 {
                // SAFETY: the name generated above and not yet deleted.
                unsafe { gl.delete_buffers(1, &buffer_id) };
                glu::expect_no_error(gl, "DeleteBuffers")?;
            }
            return Err(TestError::Fail(error.to_string()));
        }

        if test_result {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Fail"))
        }
    }
}

/// `MapBufferAlignmentTests`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("map_buffer_alignment");
    group.add_child(Box::new(Query) as Box<dyn TestCase>);
    group.add_child(Box::new(Functional) as Box<dyn TestCase>);
    group
}
