// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fIndirectComputeDispatchTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::glu::objects::BufferMemMap;
use crate::glu::{self, Buffer, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus, UVec3};

const RESULT_BLOCK_BASE_SIZE: i32 = (3 + 1) * size_of::<u32>() as i32; // uvec3 + uint
const RESULT_BLOCK_EXPECTED_COUNT_OFFSET: usize = 0;
const RESULT_BLOCK_NUM_PASSED_OFFSET: usize = 3 * size_of::<u32>();

const INDIRECT_COMMAND_SIZE: isize = 3 * size_of::<u32>() as isize;

/// `GenBuffer`
#[derive(Clone, Copy)]
enum GenBuffer {
    Upload,
    Compute,
}

/// `genVerifySources`. Upstream specializes a `tcu::StringTemplate`; the GLES half of
/// this port builds its GLSL with `format!` instead, since none of it is precompiled.
fn gen_verify_source(work_group_size: UVec3) -> String {
    format!(
        "#version 310 es\n\
         layout(local_size_x = {}, local_size_y = {}, local_size_z = {}) in;\n\
         layout(binding = 0, std430) buffer Result\n\
         {{\n\
         \x20   uvec3           expectedGroupCount;\n\
         \x20   coherent uint   numPassed;\n\
         }} result;\n\
         void main (void)\n\
         {{\n\
         \x20   if (all(equal(result.expectedGroupCount, gl_NumWorkGroups)))\n\
         \x20       atomicAdd(result.numPassed, 1u);\n\
         }}\n",
        work_group_size.x(),
        work_group_size.y(),
        work_group_size.z()
    )
}

/// `getResultBlockAlignedSize`
fn get_result_block_aligned_size(gl: &glw::Functions) -> i32 {
    let base_size = RESULT_BLOCK_BASE_SIZE;
    let mut alignment = 0;
    // SAFETY: one integer of output for a one-value query.
    unsafe { gl.get_integerv(glw::GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT, &mut alignment) };

    if alignment == 0 || (base_size % alignment == 0) {
        base_size
    } else {
        (base_size / alignment + 1) * alignment
    }
}

/// `computeInvocationCount`
fn compute_invocation_count(work_group_size: UVec3, num_work_groups: UVec3) -> u32 {
    let num_invocations_per_group = work_group_size.x() * work_group_size.y() * work_group_size.z();
    let num_groups = num_work_groups.x() * num_work_groups.y() * num_work_groups.z();

    num_invocations_per_group * num_groups
}

/// `IndirectDispatchCase::DispatchCommand`
struct DispatchCommand {
    offset: isize,
    num_work_groups: UVec3,
}

/// `IndirectDispatchCase`, and with it `SingleDispatchCase`/`MultiDispatchCase`/
/// `MultiDispatchReuseCommandCase` - upstream's three subclasses only fill the same
/// three members in their constructors, so they are the registration below rather
/// than types of their own.
struct IndirectDispatchCase {
    name: String,
    gen_buffer: GenBuffer,
    buffer_size: usize,
    work_group_size: UVec3,
    commands: Vec<DispatchCommand>,
}

impl IndirectDispatchCase {
    /// `createCmdBufferUpload`
    unsafe fn create_cmd_buffer_upload(&self, gl: &glw::Functions, buffer: GLuint) {
        let mut data = vec![0u8; self.buffer_size];

        for command in &self.commands {
            assert!(command.offset >= 0);
            assert_eq!(command.offset as usize % size_of::<u32>(), 0);
            assert!(command.offset + INDIRECT_COMMAND_SIZE <= self.buffer_size as isize);

            let offset = command.offset as usize;
            for (index, count) in command.num_work_groups.m_data.iter().enumerate() {
                data[offset + index * 4..offset + index * 4 + 4].copy_from_slice(&count.to_ne_bytes());
            }
        }

        unsafe {
            gl.bind_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, buffer);
            gl.buffer_data(glw::GL_DISPATCH_INDIRECT_BUFFER, data.len() as isize, data.as_ptr().cast(), glw::GL_STATIC_DRAW);
        }
    }

    /// `createCmdBufferCompute`
    unsafe fn create_cmd_buffer_compute(&self, gl: &glw::Functions, buffer: GLuint) -> Result<(), TestError> {
        let mut src = String::from(
            "#version 310 es\n\
             layout(local_size_x = 1) in;\n\
             layout(std430, binding = 1) buffer Out\n\
             {\n\
             \x20   highp uint data[];\n\
             };\n\
             void writeCmd (highp uint offset, uvec3 numWorkGroups)\n\
             {\n\
             \x20   data[offset+0u] = numWorkGroups.x;\n\
             \x20   data[offset+1u] = numWorkGroups.y;\n\
             \x20   data[offset+2u] = numWorkGroups.z;\n\
             }\n",
        );

        for cmd_ndx in 0..self.commands.len() {
            src += &format!("layout(location = {cmd_ndx}) uniform highp uint u_offset{cmd_ndx};\n");
        }

        src += "void main (void)\n{\n";

        for (cmd_ndx, command) in self.commands.iter().enumerate() {
            src += &format!(
                "\twriteCmd(u_offset{cmd_ndx}, uvec3({}u, {}u, {}u));\n",
                command.num_work_groups.x(),
                command.num_work_groups.y(),
                command.num_work_groups.z()
            );
        }

        src += "}\n";

        {
            let program = ShaderProgram::new(gl, &ProgramSources::compute(&src));

            if !program.is_ok() {
                return Err(TestError::Fail("Compile failed".to_string()));
            }

            unsafe {
                gl.use_program(program.program());

                for (cmd_ndx, command) in self.commands.iter().enumerate() {
                    let offs = (command.offset / 4) as u32;
                    assert_eq!(offs as isize * 4, command.offset);
                    gl.uniform_1ui(cmd_ndx as i32, offs);
                }
                glu::expect_no_error(gl, "Setting offset uniforms failed")?;

                gl.bind_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, buffer);
                gl.buffer_data(glw::GL_DISPATCH_INDIRECT_BUFFER, self.buffer_size as isize, std::ptr::null(), glw::GL_STATIC_DRAW);
                gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, buffer);
                glu::expect_no_error(gl, "Buffer setup failed")?;

                gl.dispatch_compute(1, 1, 1);
                glu::expect_no_error(gl, "glDispatchCompute() failed")?;

                gl.memory_barrier(glw::GL_COMMAND_BARRIER_BIT);
                glu::expect_no_error(gl, "glMemoryBarrier(GL_COMMAND_BARRIER_BIT) failed")?;
            }
        }

        Ok(())
    }

    /// `createCommandBuffer`
    unsafe fn create_command_buffer(&self, gl: &glw::Functions, buffer: GLuint) -> Result<(), TestError> {
        match self.gen_buffer {
            GenBuffer::Upload => unsafe { self.create_cmd_buffer_upload(gl, buffer) },
            GenBuffer::Compute => unsafe { self.create_cmd_buffer_compute(gl, buffer)? },
        }
        Ok(())
    }

    /// `createResultBuffer`
    unsafe fn create_result_buffer(&self, gl: &glw::Functions, buffer: GLuint) {
        let result_block_size = get_result_block_aligned_size(gl) as usize;
        let result_buffer_size = result_block_size * self.commands.len();
        let mut data = vec![0u8; result_buffer_size];

        for (cmd_ndx, command) in self.commands.iter().enumerate() {
            let dst = result_block_size * cmd_ndx;

            for (index, count) in command.num_work_groups.m_data.iter().enumerate() {
                let at = dst + RESULT_BLOCK_EXPECTED_COUNT_OFFSET + index * 4;
                data[at..at + 4].copy_from_slice(&count.to_ne_bytes());
            }
            let at = dst + RESULT_BLOCK_NUM_PASSED_OFFSET;
            data[at..at + 4].copy_from_slice(&0u32.to_ne_bytes());
        }

        unsafe {
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer);
            gl.buffer_data(glw::GL_SHADER_STORAGE_BUFFER, data.len() as isize, data.as_ptr().cast(), glw::GL_STATIC_READ);
        }
    }

    /// `verifyResultBuffer`. Upstream unmaps the buffer in a `catch (...)` and again
    /// after it; `BufferMemMap` does that on drop either way.
    unsafe fn verify_result_buffer(&self, gl: &glw::Functions, buffer: GLuint) -> Result<bool, TestError> {
        let result_block_size = get_result_block_aligned_size(gl) as usize;
        let result_buffer_size = result_block_size * self.commands.len();
        let mut all_ok = true;

        unsafe {
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer);
            let map = BufferMemMap::new(gl, glw::GL_SHADER_STORAGE_BUFFER, 0, result_buffer_size as isize, glw::GL_MAP_READ_BIT);
            glu::expect_no_error(gl, "glMapBufferRange() failed")?;
            let map = map.ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;

            let num_passed: Vec<u32> = map.read_strided(RESULT_BLOCK_NUM_PASSED_OFFSET, result_block_size, self.commands.len());

            for (cmd_ndx, command) in self.commands.iter().enumerate() {
                let expected_count = compute_invocation_count(self.work_group_size, command.num_work_groups);

                // Verify numPassed.
                if num_passed[cmd_ndx] != expected_count {
                    log::error!(
                        "ERROR: got invalid result for invocation {cmd_ndx}: got numPassed = {}, expected {expected_count}",
                        num_passed[cmd_ndx]
                    );
                    all_ok = false;
                }
            }
        }

        glu::expect_no_error(gl, "glUnmapBuffer() failed")?;

        Ok(all_ok)
    }
}

impl TestCase for IndirectDispatchCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let program = ShaderProgram::new(gl, &ProgramSources::compute(gen_verify_source(self.work_group_size)));

        let cmd_buffer = Buffer::new(gl);
        let result_buffer = Buffer::new(gl);

        if !program.is_ok() {
            return Err(TestError::Fail("Compile failed".to_string()));
        }

        log::debug!("GL_DISPATCH_INDIRECT_BUFFER size = {}", self.buffer_size);
        log::debug!("Indirect Dispatch Commands ({} in total)", self.commands.len());
        for (cmd_ndx, command) in self.commands.iter().enumerate() {
            log::debug!("{cmd_ndx}: offset = {}, numWorkGroups = {:?}", command.offset, command.num_work_groups.m_data);
        }

        // SAFETY: a current context; every pointer below is to a live local.
        unsafe {
            self.create_result_buffer(gl, result_buffer.get());
            self.create_command_buffer(gl, cmd_buffer.get())?;

            gl.use_program(program.program());
            gl.bind_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, cmd_buffer.get());
            glu::expect_no_error(gl, "State setup failed")?;

            {
                let result_block_aligned_size = get_result_block_aligned_size(gl);
                let mut cur_offset = 0;

                for command in &self.commands {
                    gl.bind_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, 0, result_buffer.get(), cur_offset, result_block_aligned_size as isize);
                    gl.dispatch_compute_indirect(command.offset);

                    cur_offset += result_block_aligned_size as isize;
                }
            }

            glu::expect_no_error(gl, "glDispatchComputeIndirect() failed")?;

            if self.verify_result_buffer(gl, result_buffer.get())? {
                Ok(TestStatus::pass("Pass"))
            } else {
                Ok(TestStatus::fail("Invalid values in result buffer"))
            }
        }
    }
}

/// `IndirectComputeDispatchTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("indirect_dispatch");

    for (gen_name, gen_buffer) in [("upload_buffer", GenBuffer::Upload), ("gen_in_compute", GenBuffer::Compute)] {
        let mut gen_group = TestCaseGroup::new(gen_name);

        for (name, buffer_size, offset, work_group_size, num_work_groups) in [
            ("single_invocation", INDIRECT_COMMAND_SIZE, 0, UVec3::new(1, 1, 1), UVec3::new(1, 1, 1)),
            ("multiple_groups", INDIRECT_COMMAND_SIZE, 0, UVec3::new(1, 1, 1), UVec3::new(2, 3, 5)),
            ("multiple_groups_multiple_invocations", INDIRECT_COMMAND_SIZE, 0, UVec3::new(2, 3, 1), UVec3::new(1, 2, 3)),
            ("small_offset", 16 + INDIRECT_COMMAND_SIZE, 16, UVec3::new(1, 1, 1), UVec3::new(1, 1, 1)),
            ("large_offset", 2 << 20, (1 << 20) + 12, UVec3::new(1, 1, 1), UVec3::new(1, 1, 1)),
            ("large_offset_multiple_invocations", 2 << 20, (1 << 20) + 12, UVec3::new(2, 3, 1), UVec3::new(1, 2, 3)),
            ("empty_command", INDIRECT_COMMAND_SIZE, 0, UVec3::new(1, 1, 1), UVec3::new(0, 0, 0)),
        ] {
            gen_group.add_child(Box::new(IndirectDispatchCase {
                name: name.to_string(),
                gen_buffer,
                buffer_size: buffer_size as usize,
                work_group_size,
                commands: vec![DispatchCommand { offset, num_work_groups }],
            }) as Box<dyn TestCase>);
        }

        // `MultiDispatchCase`
        gen_group.add_child(Box::new(IndirectDispatchCase {
            name: "multi_dispatch".to_string(),
            gen_buffer,
            buffer_size: 1 << 10,
            work_group_size: UVec3::new(3, 1, 2),
            commands: vec![
                DispatchCommand {
                    offset: 0,
                    num_work_groups: UVec3::new(1, 1, 1),
                },
                DispatchCommand {
                    offset: INDIRECT_COMMAND_SIZE,
                    num_work_groups: UVec3::new(2, 1, 1),
                },
                DispatchCommand {
                    offset: 104,
                    num_work_groups: UVec3::new(1, 3, 1),
                },
                DispatchCommand {
                    offset: 40,
                    num_work_groups: UVec3::new(1, 1, 7),
                },
                DispatchCommand {
                    offset: 52,
                    num_work_groups: UVec3::new(1, 1, 4),
                },
            ],
        }) as Box<dyn TestCase>);

        // `MultiDispatchReuseCommandCase`
        gen_group.add_child(Box::new(IndirectDispatchCase {
            name: "multi_dispatch_reuse_command".to_string(),
            gen_buffer,
            buffer_size: 1 << 10,
            work_group_size: UVec3::new(3, 1, 2),
            commands: vec![
                DispatchCommand {
                    offset: 0,
                    num_work_groups: UVec3::new(1, 1, 1),
                },
                DispatchCommand {
                    offset: 0,
                    num_work_groups: UVec3::new(1, 1, 1),
                },
                DispatchCommand {
                    offset: 0,
                    num_work_groups: UVec3::new(1, 1, 1),
                },
                DispatchCommand {
                    offset: 104,
                    num_work_groups: UVec3::new(1, 3, 1),
                },
                DispatchCommand {
                    offset: 104,
                    num_work_groups: UVec3::new(1, 3, 1),
                },
                DispatchCommand {
                    offset: 52,
                    num_work_groups: UVec3::new(1, 1, 4),
                },
                DispatchCommand {
                    offset: 52,
                    num_work_groups: UVec3::new(1, 1, 4),
                },
            ],
        }) as Box<dyn TestCase>);

        group.add_child(gen_group);
    }

    group
}
