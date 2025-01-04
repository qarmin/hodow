// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fSSBOArrayLengthTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream splits the work across
// `init`/`iterate` because it caches the program between iterations; there is one
// iteration, so it is one `iterate` here.

use crate::glu::{self, Buffer, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `SSBOArrayLengthCase::s_fixedBufferSize`
const FIXED_BUFFER_SIZE: i32 = 16;

/// `SSBOArrayLengthCase::ArrayAccess`
#[derive(Clone, Copy, PartialEq, Eq)]
enum ArrayAccess {
    Default,
    WriteOnly,
    ReadOnly,
}

struct SsboArrayLengthCase {
    name: String,
    access: ArrayAccess,
    sized: bool,
}

impl SsboArrayLengthCase {
    /// `SSBOArrayLengthCase::genComputeSource`
    fn gen_compute_source(&self) -> String {
        let qualifier = match self.access {
            ArrayAccess::ReadOnly => "readonly ",
            ArrayAccess::WriteOnly => "writeonly ",
            ArrayAccess::Default => "",
        };
        let size = if self.sized {
            FIXED_BUFFER_SIZE.to_string()
        } else {
            String::new()
        };

        let mut src = format!(
            "#version 310 es\n\
             layout(local_size_x = 1, local_size_y = 1) in;\n\
             layout(std430) buffer;\n\
             \n\
             layout(binding = 0) buffer Out\n\
             {{\n    \
             int outLength;\n    \
             uint unused;\n\
             }} sb_out;\n\
             layout(binding = 1) {qualifier}buffer Target\n\
             {{\n    \
             float array[{size}];\n\
             }} sb_target;\n\n\
             void main (void)\n\
             {{\n"
        );

        // read
        if matches!(self.access, ArrayAccess::ReadOnly | ArrayAccess::Default) {
            src.push_str("    sb_out.unused = uint(sb_target.array[1]);\n");
        }

        // write
        if matches!(self.access, ArrayAccess::WriteOnly | ArrayAccess::Default) {
            src.push_str("    sb_target.array[2] = float(sb_out.unused);\n");
        }

        // actual test
        src.push_str("\n    sb_out.outLength = sb_target.array.length();\n}\n");
        src
    }
}

/// One `glGetProgramResourceiv` property of one buffer variable, plus the checks
/// `SSBOArrayLengthCase::init` wraps it in.
fn check_buffer_var_property(
    gl: &glw::Functions,
    program: GLuint,
    name: &std::ffi::CStr,
    prop: GLenum,
    expected: GLint,
) -> Result<(), TestError> {
    // SAFETY: the program linked; an unknown name answers GL_INVALID_INDEX, which is
    // checked before the property query.
    let index = unsafe { gl.get_program_resource_index(program, glw::GL_BUFFER_VARIABLE, name.as_ptr()) };
    if index == glw::GL_INVALID_INDEX {
        return Err(TestError::Fail(format!(
            "Failed to find {} variable",
            name.to_string_lossy()
        )));
    }

    let mut result: GLint = 0;
    // SAFETY: one property is asked for and one GLint of output is given.
    unsafe {
        gl.get_program_resourceiv(
            program,
            glw::GL_BUFFER_VARIABLE,
            index,
            1,
            &prop,
            1,
            std::ptr::null_mut(),
            &mut result,
        );
    }

    if result != expected {
        return Err(TestError::Fail(format!(
            "Unexpected property {prop:#x} for {}: got {result}, expected {expected}",
            name.to_string_lossy()
        )));
    }

    Ok(())
}

impl TestCase for SsboArrayLengthCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let program = ShaderProgram::new(gl, &ProgramSources::compute(self.gen_compute_source()));
        if !program.is_ok() {
            return Err(TestError::Fail("Failed to build shader".to_string()));
        }
        let program_id = program.program();

        const INVALID_VALUES: [u32; 2] = [0xFFFFFFFF, 0xAAAAAAAA];
        let output_buffer = Buffer::new(gl);
        let target_buffer = Buffer::new(gl);

        // SAFETY: the upload covers exactly the two u32s it points at.
        unsafe {
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, output_buffer.get());
            gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                std::mem::size_of_val(&INVALID_VALUES) as isize,
                INVALID_VALUES.as_ptr().cast(),
                glw::GL_DYNAMIC_COPY,
            );
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, target_buffer.get());
            glu::expect_no_error(gl, "create buffers")?;

            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, output_buffer.get());
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, target_buffer.get());
            glu::expect_no_error(gl, "bind buffers")?;
        }

        // Check the ssbo has the expected layout.
        check_buffer_var_property(gl, program_id, c"Out.outLength", glw::GL_OFFSET, 0)?;
        check_buffer_var_property(gl, program_id, c"Out.unused", glw::GL_OFFSET, 4)?;
        check_buffer_var_property(gl, program_id, c"Target.array", glw::GL_ARRAY_STRIDE, 4)?;

        log::info!("Allocating float memory buffer with {FIXED_BUFFER_SIZE} elements.");

        // SAFETY: a null data pointer only allocates.
        unsafe {
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, target_buffer.get());
            gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                FIXED_BUFFER_SIZE as isize * 4,
                std::ptr::null(),
                glw::GL_DYNAMIC_COPY,
            );
            glu::expect_no_error(gl, "update buffer")?;
        }

        log::info!("Running compute shader.");

        // SAFETY: the program links and the two bindings it declares are bound above.
        unsafe {
            gl.use_program(program_id);
            gl.dispatch_compute(1, 1, 1);
            glu::expect_no_error(gl, "dispatch")?;
        }

        // SAFETY: the mapping covers the first u32 of the output buffer, and is read
        // through before being unmapped.
        let length = unsafe {
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, output_buffer.get());
            let ptr = gl.map_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, 0, 4, glw::GL_MAP_READ_BIT);
            glu::expect_no_error(gl, "map")?;
            if ptr.is_null() {
                return Err(TestError::Fail("mapBufferRange returned NULL".to_string()));
            }

            let length = ptr.cast::<u32>().read_unaligned();

            if gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER) == glw::FALSE {
                return Err(TestError::Fail("unmapBuffer returned false".to_string()));
            }
            glu::expect_no_error(gl, "unmap")?;

            length
        };

        if length != FIXED_BUFFER_SIZE as u32 {
            log::warn!("ERROR: Length returned was {length}, expected {FIXED_BUFFER_SIZE}");
            return Ok(TestStatus::fail("Fail"));
        }

        log::info!("Length returned was correct.");
        Ok(TestStatus::pass("Pass"))
    }
}

/// `SSBOArrayLengthTests::init`
pub fn create_tests() -> TestCaseGroup {
    const QUALIFIERS: [(ArrayAccess, &str); 3] = [
        (ArrayAccess::Default, ""),
        (ArrayAccess::WriteOnly, "writeonly_"),
        (ArrayAccess::ReadOnly, "readonly_"),
    ];

    let mut group = TestCaseGroup::new("array_length");

    for sized in [true, false] {
        for (access, qualifier_name) in QUALIFIERS {
            let name = format!("{}{qualifier_name}array", if sized { "sized_" } else { "unsized_" });
            group.add_child(Box::new(SsboArrayLengthCase { name, access, sized }) as Box<dyn TestCase>);
        }
    }

    group
}
