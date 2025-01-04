// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cIndirectParametersTests.cpp
//   external/openglcts/modules/gl/gl4cIndirectParametersTests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `VertexArrayIndirectDrawingBaseCase` and its two subclasses are one case type over `Draw`; the support check upstream does in `iterate` (and `init` skips the setup on) is `check_support`. Four things upstream reads past the end of an array or through an unmapped pointer are not reproduced: the parameter buffer of the arrays case is uploaded as 100 `GLushort`s from a two-element array (here the rest is zero), the indirect buffer of the elements case as three commands from a two-command array (the third is zero), and `ParameterBufferOperationsCase` checks the copied value through the pointer of the earlier, already unmapped, parameter buffer mapping, where this reads it from the mapping of the buffer copied to, which is what the check is for.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

#[allow(dead_code)]
type Res<T> = Result<T, TestError>;

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const VERT_SHADER: &str = "#version 430\n\nin vec3 vertex;\n\nvoid main()\n{\n    gl_Position = vec4(vertex, 1);\n}\n";
const FRAG_SHADER: &str =
    "#version 430\n\nout vec4 fragColor;\n\nvoid main()\n{\n    fragColor = vec4(1, 1, 1, 0.5);\n}\n";

const VERTICES: [f32; 18] = [
    -1.0, -1.0, 0.0, -1.0, 1.0, 0.0, 0.0, -1.0, 0.0, 0.0, 1.0, 0.0, 1.0, -1.0, 0.0, 1.0, 1.0, 0.0,
];
const ELEMENTS: [u16; 6] = [0, 1, 2, 3, 4, 5];

// 4 vertices, 2 instanceCount, 0 first, 0 baseInstance; 4 vertices, 1 instanceCount, 2 first, 0 baseInstance
const DRAW_ARRAYS_INDIRECT: [[u32; 4]; 2] = [[4, 2, 0, 0], [4, 1, 2, 0]];
// 4 indices, 2 instanceCount, 0 firstIndex, 0 baseVertex, 0 baseInstance; 4 indices, 1 instanceCount, 2 firstIndex, 0 baseVertex, 0 baseInstance
const DRAW_ELEMENTS_INDIRECT: [[u32; 5]; 3] = [[4, 2, 0, 0, 0], [4, 1, 2, 0, 0], [0, 0, 0, 0, 0]];

fn indirect_parameters_supported(context: &Context) -> bool {
    context.context_type().supports_core(4, 6)
        || context
            .context_info
            .is_extension_supported("GL_ARB_indirect_parameters")
}

/// `ParameterBufferOperationsCase::iterate`
fn parameter_buffer_operations(context: &Context) -> TestOutcome {
    let gl = context.gl();
    let data: [GLint; 10] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    let sub_data: [GLint; 5] = [10, 11, 12, 13, 14];
    let exp_data: [GLint; 10] = [0, 1, 10, 11, 12, 13, 14, 7, 8, 9];
    let int_size = std::mem::size_of::<GLint>() as isize;
    let mut result = true;

    // Test buffer generating and binding
    let param_buffer = glu::Buffer::new(gl);
    glu::expect_no_error(gl, "glGenBuffers")?;
    gl_call!(
        gl,
        "glBindBuffer",
        gl.bind_buffer(glw::GL_PARAMETER_BUFFER_ARB, param_buffer.get())
    );
    let mut param_binding: GLint = 0;
    gl_call!(
        gl,
        "glGetIntegerv",
        gl.get_integerv(glw::GL_PARAMETER_BUFFER_BINDING_ARB, &mut param_binding)
    );
    if param_binding as GLuint != param_buffer.get() {
        result = false;
        log::info!("Buffer binding mismatch");
    } else {
        // Test filling buffer with data
        gl_call!(
            gl,
            "glBufferData",
            gl.buffer_data(
                glw::GL_PARAMETER_BUFFER_ARB,
                10 * int_size,
                data.as_ptr().cast(),
                glw::GL_DYNAMIC_DRAW
            )
        );
        gl_call!(
            gl,
            "glBufferData",
            gl.buffer_sub_data(
                glw::GL_PARAMETER_BUFFER_ARB,
                2 * int_size,
                5 * int_size,
                sub_data.as_ptr().cast()
            )
        );

        // Test buffer mapping
        // SAFETY: a bound buffer of ten GLints.
        let buffer = unsafe { gl.map_buffer(glw::GL_PARAMETER_BUFFER_ARB, glw::GL_READ_ONLY) };
        glu::expect_no_error(gl, "glMapBuffer")?;
        // SAFETY: the mapping covers the ten GLints the buffer was filled with.
        let mapped = unsafe { std::slice::from_raw_parts(buffer.cast::<GLint>(), 10) };
        if mapped != exp_data {
            result = false;
            log::info!("Buffer data mismatch");
        } else {
            let mut buffer_pointer: *mut std::ffi::c_void = std::ptr::null_mut();
            gl_call!(
                gl,
                "glGetBufferPointerv",
                gl.get_buffer_pointerv(
                    glw::GL_PARAMETER_BUFFER_ARB,
                    glw::GL_BUFFER_MAP_POINTER,
                    &mut buffer_pointer
                )
            );
            if buffer != buffer_pointer {
                result = false;
                log::info!("Buffer pointer mismatch");
            } else {
                let mut buffer_size: GLint = 0;
                let mut buffer_usage: GLint = 0;
                gl_call!(
                    gl,
                    "glGetBufferParameteriv",
                    gl.get_buffer_parameteriv(glw::GL_PARAMETER_BUFFER_ARB, glw::GL_BUFFER_SIZE, &mut buffer_size)
                );
                gl_call!(
                    gl,
                    "glGetBufferParameteriv",
                    gl.get_buffer_parameteriv(glw::GL_PARAMETER_BUFFER_ARB, glw::GL_BUFFER_USAGE, &mut buffer_usage)
                );
                if buffer_size as isize != 10 * int_size {
                    result = false;
                    log::info!("Buffer size mismatch");
                } else if buffer_usage != glw::GL_DYNAMIC_DRAW as GLint {
                    result = false;
                    log::info!("Buffer usage mismatch");
                }
            }
        }
        gl_call!(gl, "glUnmapBuffer", gl.unmap_buffer(glw::GL_PARAMETER_BUFFER_ARB));

        // Test buffer ranged mapping
        // SAFETY: a bound buffer of ten GLints, one mapped for writing.
        let buffer = unsafe {
            gl.map_buffer_range(
                glw::GL_PARAMETER_BUFFER_ARB,
                0,
                int_size,
                glw::GL_MAP_WRITE_BIT | glw::GL_MAP_FLUSH_EXPLICIT_BIT,
            )
        };
        glu::expect_no_error(gl, "glMapBufferRange")?;

        // Test buffer flushing
        // SAFETY: the mapping covers one GLint.
        unsafe { buffer.cast::<GLint>().write(100) };
        gl_call!(
            gl,
            "glFlushMappedBufferRange",
            gl.flush_mapped_buffer_range(glw::GL_PARAMETER_BUFFER_ARB, 0, int_size)
        );
        gl_call!(gl, "glUnmapBuffer", gl.unmap_buffer(glw::GL_PARAMETER_BUFFER_ARB));

        // Test buffers data copying
        let array_buffer = glu::Buffer::new(gl);
        glu::expect_no_error(gl, "glGenBuffers")?;
        gl_call!(
            gl,
            "glBindBuffer",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, array_buffer.get())
        );
        gl_call!(
            gl,
            "glBufferData",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                10 * int_size,
                data.as_ptr().cast(),
                glw::GL_DYNAMIC_DRAW
            )
        );
        gl_call!(
            gl,
            "glCopyBufferSubData",
            gl.copy_buffer_sub_data(glw::GL_PARAMETER_BUFFER_ARB, glw::GL_ARRAY_BUFFER, 0, 0, int_size)
        );
        // SAFETY: a bound buffer of ten GLints, one mapped for reading.
        let copied = unsafe { gl.map_buffer_range(glw::GL_ARRAY_BUFFER, 0, 1, glw::GL_MAP_READ_BIT) };
        glu::expect_no_error(gl, "glMapBufferRange")?;
        // SAFETY: the mapping covers the first byte, and the copied GLint was written at offset 0 of a ten GLint buffer.
        if unsafe { copied.cast::<GLint>().read() } != 100 {
            result = false;
            log::info!("Buffer copy operation failed");
        }
        gl_call!(gl, "glUnmapBuffer", gl.unmap_buffer(glw::GL_ARRAY_BUFFER));
    }

    Ok(if result {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Draw {
    Arrays,
    Elements,
}

/// `VertexArrayIndirectDrawingBaseCase::verify`'s pixel checks
fn verify_quads(context: &Context) -> bool {
    let gl = context.gl();
    let render_target = context.render_target();
    let (width, height) = (render_target.width, render_target.height);

    let mut pixels = vec![0u8; (width * height) as usize];
    // SAFETY: the buffer holds a whole GL_RED image of the render target's size.
    unsafe {
        gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1);
        gl.read_pixels(
            0,
            0,
            width,
            height,
            glw::GL_RED,
            glw::GL_UNSIGNED_BYTE,
            pixels.as_mut_ptr().cast(),
        );
        gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 4);
    }

    // Verify first quad
    for y in 2..height - 2 {
        for x in 2..width / 2 - 2 {
            let value = i32::from(pixels[(x + y * width) as usize]);
            // Support 5-bit precision for the framebuffer, re-quantized to 8-bits from glReadPixels.
            if !(189..=197).contains(&value) {
                log::info!(
                    "First quad verification failed. Wrong value read from framebuffer at {x}/{y} value: {value}, expected: <189-197>"
                );
                return false;
            }
        }
    }

    // Verify second quad
    for y in 2..height - 2 {
        for x in width / 2 + 2..width - 2 {
            let value = i32::from(pixels[(x + y * width) as usize]);
            if !(123..=132).contains(&value) {
                log::info!(
                    "Second quad verification failed. Wrong value read from framebuffer at {x}/{y} value: {value}, expected: <123-132>"
                );
                return false;
            }
        }
    }

    true
}

/// `MultiDraw{Arrays,Elements}IndirectCountCase::verifyErrors`
fn verify_errors(gl: &glw::Functions, draw: Draw) -> bool {
    let name = if draw == Draw::Arrays {
        "MultiDrawArraysIndirectCount"
    } else {
        "MultiDrawElementIndirectCount"
    };
    let mut result = true;

    let mut call = |step: i32, drawcount: isize, maxdrawcount: i32, expected: u32| {
        // SAFETY: the buffers the draw reads were set up before; the errors are what is under test.
        unsafe {
            match draw {
                Draw::Arrays => gl.multi_draw_arrays_indirect_count(
                    glw::GL_TRIANGLE_STRIP,
                    std::ptr::null(),
                    drawcount,
                    maxdrawcount,
                    0,
                ),
                Draw::Elements => gl.multi_draw_elements_indirect_count(
                    glw::GL_TRIANGLE_STRIP,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null(),
                    drawcount,
                    maxdrawcount,
                    0,
                ),
            }
        }
        // SAFETY: no arguments.
        let error_code = unsafe { gl.get_error() };
        if error_code != expected {
            log::info!("{name} error verifying failed ({step}). Expected code: {expected}, current code: {error_code}");
            result = false;
        }
    };

    // INVALID_VALUE - drawcount offset not multiple of 4
    call(1, 2, 1, glw::GL_INVALID_VALUE);
    // INVALID_OPERATION - maxdrawcount greater then parameter buffer size
    call(2, 0, 4, glw::GL_INVALID_OPERATION);

    // SAFETY: a current context.
    unsafe { gl.bind_buffer(glw::GL_PARAMETER_BUFFER_ARB, 0) };
    // INVALID_OPERATION - GL_PARAMETER_BUFFER_ARB not bound
    call(
        3,
        0,
        if draw == Draw::Arrays { 2 } else { 3 },
        glw::GL_INVALID_OPERATION,
    );

    result
}

fn multi_draw_indirect_count(context: &Context, draw: Draw) -> TestOutcome {
    let gl = context.gl();

    // init: Generate vertex array object
    let vao = glu::VertexArray::new(gl);
    glu::expect_no_error(gl, "glGenVertexArrays")?;
    gl_call!(gl, "glBindVertexArray", gl.bind_vertex_array(vao.get()));

    // Setup vertex array buffer
    let array_buffer = glu::Buffer::new(gl);
    glu::expect_no_error(gl, "glGenBuffers")?;
    gl_call!(
        gl,
        "glBindBuffer",
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, array_buffer.get())
    );
    gl_call!(
        gl,
        "glBufferData",
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(&VERTICES) as isize,
            VERTICES.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        )
    );

    // Setup element array buffer
    let element_buffer = glu::Buffer::new(gl);
    if draw == Draw::Elements {
        glu::expect_no_error(gl, "glGenBuffers")?;
        gl_call!(
            gl,
            "glBindBuffer",
            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, element_buffer.get())
        );
        gl_call!(
            gl,
            "glBufferData",
            gl.buffer_data(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                std::mem::size_of_val(&ELEMENTS) as isize,
                ELEMENTS.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );
    }

    // Setup indirect command buffer
    let draw_indirect_buffer = glu::Buffer::new(gl);
    glu::expect_no_error(gl, "glGenBuffers")?;
    gl_call!(
        gl,
        "glBindBuffer",
        gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, draw_indirect_buffer.get())
    );
    let commands: Vec<u8> = match draw {
        Draw::Arrays => DRAW_ARRAYS_INDIRECT
            .iter()
            .flatten()
            .flat_map(|v| v.to_ne_bytes())
            .collect(),
        Draw::Elements => DRAW_ELEMENTS_INDIRECT
            .iter()
            .flatten()
            .flat_map(|v| v.to_ne_bytes())
            .collect(),
    };
    gl_call!(
        gl,
        "glBufferData",
        gl.buffer_data(
            glw::GL_DRAW_INDIRECT_BUFFER,
            commands.len() as isize,
            commands.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        )
    );

    // Setup parameter buffer
    let parameter_buffer = glu::Buffer::new(gl);
    glu::expect_no_error(gl, "glGenBuffers")?;
    gl_call!(
        gl,
        "glBindBuffer",
        gl.bind_buffer(glw::GL_PARAMETER_BUFFER_ARB, parameter_buffer.get())
    );
    let parameters: Vec<u8> = {
        let mut bytes: Vec<u8> = [2u16, 1].iter().flat_map(|v| v.to_ne_bytes()).collect();
        if draw == Draw::Arrays {
            bytes.resize(100 * std::mem::size_of::<u16>(), 0);
        }
        bytes
    };
    gl_call!(
        gl,
        "glBufferData",
        gl.buffer_data(
            glw::GL_PARAMETER_BUFFER_ARB,
            parameters.len() as isize,
            parameters.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        )
    );

    // draw
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERT_SHADER, FRAG_SHADER));
    if !program.is_ok() {
        log::info!(
            "Shader build failed.\n{}",
            program.build_failure_summary().unwrap_or_default()
        );
        return Ok(TestStatus::fail("Fail"));
    }

    gl_call!(gl, "glUseProgram", gl.use_program(program.program()));
    // SAFETY: a current context.
    unsafe {
        gl.clear_color(0.0, 0.0, 0.0, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
        gl.enable(glw::GL_BLEND);
        gl.blend_func(glw::GL_SRC_ALPHA, glw::GL_ONE_MINUS_SRC_ALPHA);
    }
    gl_call!(gl, "glEnableVertexAttribArray", gl.enable_vertex_attrib_array(0));
    gl_call!(
        gl,
        "glVertexAttribPointer",
        gl.vertex_attrib_pointer(0, 3, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null())
    );
    match draw {
        Draw::Arrays => gl_call!(
            gl,
            "glMultiDrawArraysIndirectCountARB",
            gl.multi_draw_arrays_indirect_count(glw::GL_TRIANGLE_STRIP, std::ptr::null(), 0, 2, 0)
        ),
        Draw::Elements => gl_call!(
            gl,
            "glMultiDrawElementsIndirectCountARB",
            gl.multi_draw_elements_indirect_count(
                glw::GL_TRIANGLE_STRIP,
                glw::GL_UNSIGNED_SHORT,
                std::ptr::null(),
                0,
                2,
                0
            )
        ),
    }
    gl_call!(gl, "glDisableVertexAttribArray", gl.disable_vertex_attrib_array(0));
    // SAFETY: a current context.
    unsafe { gl.disable(glw::GL_BLEND) };

    // verify
    let passed = verify_quads(context) && verify_errors(gl, draw);
    Ok(if passed {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

enum Kind {
    ParameterBufferOperations,
    MultiDrawIndirectCount(Draw),
}

struct IndirectParametersCase {
    name: &'static str,
    kind: Kind,
}

impl TestCase for IndirectParametersCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !indirect_parameters_supported(context) {
            return Err(TestError::NotSupported("Not Supported".to_string()));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        match self.kind {
            Kind::ParameterBufferOperations => parameter_buffer_operations(context),
            Kind::MultiDrawIndirectCount(draw) => multi_draw_indirect_count(context, draw),
        }
    }
}

/// `IndirectParametersTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("indirect_parameters_tests");
    for (name, kind) in [
        ("ParameterBufferOperations", Kind::ParameterBufferOperations),
        (
            "MultiDrawArraysIndirectCount",
            Kind::MultiDrawIndirectCount(Draw::Arrays),
        ),
        (
            "MultiDrawElementsIndirectCount",
            Kind::MultiDrawIndirectCount(Draw::Elements),
        ),
    ] {
        group.add_child(Box::new(IndirectParametersCase { name, kind }) as Box<dyn TestCase>);
    }
    group
}
