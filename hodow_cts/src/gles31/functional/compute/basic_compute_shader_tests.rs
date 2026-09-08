// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fBasicComputeShaderTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Six of the eight image cases (copy_ssbo_to_image, image_atomic_op, image_barrier)
// are not ported yet and are deliberately not registered: a case in the tree that runs
// nothing would inflate the coverage number. Everything else in upstream's `basic`
// group is here, in upstream's order.

use crate::glu::objects::BufferMemMap;
use crate::glu::{self, Buffer, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, Texture};
use crate::glw::{self, GLuint};
use crate::tcu::{IVec2, IVec3, Random, TestError, TestOutcome, TestStatus, multiply_components};

/// The GLSL that every case in this group shares: the `#version` line, then a
/// `local_size` layout built from the case's own work-group shape.
fn shader_header(context: &Context, local_size: IVec3) -> String {
    format!(
        "{}\nlayout (local_size_x = {}, local_size_y = {}, local_size_z = {}) in;\n",
        context.context_type().glsl_version().declaration(),
        local_size.x(),
        local_size.y(),
        local_size.z()
    )
}

/// `gl.getProgramResourceIndex`
fn resource_index(gl: &glw::Functions, program: GLuint, program_interface: u32, name: &str) -> Result<GLuint, TestError> {
    let cname = std::ffi::CString::new(name).expect("resource names contain no interior nul");
    // SAFETY: the name is a valid C string that outlives the call, and the program is
    // one this case linked.
    let index = unsafe { gl.get_program_resource_index(program, program_interface, cname.as_ptr()) };
    glu::expect_no_error(gl, "glGetProgramResourceIndex()")?;
    if index == glw::GL_INVALID_INDEX {
        return Err(TestError::Fail(format!("the program has no {name} in interface 0x{program_interface:x}")));
    }
    Ok(index)
}

/// Compiles the program and reports upstream's `TCU_FAIL("Compile failed")` if the
/// driver would not build it.
fn build<'gl>(gl: &'gl glw::Functions, source: &str) -> Result<ShaderProgram<'gl>, TestError> {
    let program = ShaderProgram::new(gl, &ProgramSources::compute(source));
    if !program.is_ok() {
        return Err(TestError::Fail("Compile failed".to_string()));
    }
    Ok(program)
}

/// `EmptyComputeShaderCase`
struct EmptyComputeShaderCase;

impl TestCase for EmptyComputeShaderCase {
    fn name(&self) -> &str {
        "empty"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let source = format!(
            "{}\nlayout (local_size_x = 1) in;\nvoid main (void) {{}}\n",
            context.context_type().glsl_version().declaration()
        );
        let program = build(gl, &source)?;

        // SAFETY: the program linked, so dispatching it is a well-formed call; every
        // error it can produce is picked up by the check below.
        unsafe {
            gl.use_program(program.program());
            gl.dispatch_compute(1, 1, 1);
        }
        glu::expect_no_error(gl, "glDispatchCompute()")?;

        Ok(TestStatus::pass("Pass"))
    }
}

/// `UBOToSSBOInvertCase`
struct UboToSsboInvertCase {
    name: String,
    num_values: i32,
    local_size: IVec3,
    work_size: IVec3,
}

impl TestCase for UboToSsboInvertCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let source = format!(
            "{header}\
             uniform Input {{\n    uint values[{num}];\n}} ub_in;\n\
             layout(binding = 1) buffer Output {{\n    uint values[{num}];\n}} sb_out;\n\
             void main (void) {{\n\
             \x20   uvec3 size           = gl_NumWorkGroups * gl_WorkGroupSize;\n\
             \x20   uint numValuesPerInv = uint(ub_in.values.length()) / (size.x*size.y*size.z);\n\
             \x20   uint groupNdx        = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;\n\
             \x20   uint offset          = numValuesPerInv*groupNdx;\n\
             \n\
             \x20   for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)\n\
             \x20       sb_out.values[offset + ndx] = ~ub_in.values[offset + ndx];\n\
             }}\n",
            header = shader_header(context, self.local_size),
            num = self.num_values,
        );

        let program = build(gl, &source)?;
        let input_buffer = Buffer::new(gl);
        let output_buffer = Buffer::new(gl);

        let mut rnd = Random::new(0x111223f);
        let input_values: Vec<u32> = (0..self.num_values).map(|_| rnd.get_uint32()).collect();

        log::debug!("Work groups: {:?}", self.work_size.m_data);

        // SAFETY: every object below was created by this case, and each call's
        // arguments come from the driver's own interface queries.
        unsafe {
            gl.use_program(program.program());

            // Input buffer setup
            {
                let block_index = resource_index(gl, program.program(), glw::GL_UNIFORM_BLOCK, "Input")?;
                let block_info = glu::get_program_interface_block_info(gl, program.program(), glw::GL_UNIFORM_BLOCK, block_index)?;
                let value_index = resource_index(gl, program.program(), glw::GL_UNIFORM, "Input.values")?;
                let value_info = glu::get_program_interface_variable_info(gl, program.program(), glw::GL_UNIFORM, value_index)?;

                gl.bind_buffer(glw::GL_UNIFORM_BUFFER, input_buffer.get());
                gl.buffer_data(glw::GL_UNIFORM_BUFFER, block_info.data_size as isize, std::ptr::null(), glw::GL_STATIC_DRAW);

                {
                    let map = BufferMemMap::new(gl, glw::GL_UNIFORM_BUFFER, 0, block_info.data_size as isize, glw::GL_MAP_WRITE_BIT)
                        .ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;
                    let count = (value_info.array_size as usize).min(input_values.len());
                    map.write_strided(value_info.offset as usize, value_info.array_stride as usize, &input_values[..count]);
                }

                gl.uniform_block_binding(program.program(), block_index, 0);
                gl.bind_buffer_base(glw::GL_UNIFORM_BUFFER, 0, input_buffer.get());
                glu::expect_no_error(gl, "Input buffer setup failed")?;
            }

            // Output buffer setup
            {
                let block_index = resource_index(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, "Output")?;
                let block_size = glu::get_program_resource_int(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, block_index, glw::GL_BUFFER_DATA_SIZE)?;

                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, output_buffer.get());
                gl.buffer_data(glw::GL_SHADER_STORAGE_BUFFER, block_size as isize, std::ptr::null(), glw::GL_STREAM_READ);
                gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, output_buffer.get());
                glu::expect_no_error(gl, "Output buffer setup failed")?;
            }

            // Dispatch compute workload
            gl.dispatch_compute(self.work_size.x() as u32, self.work_size.y() as u32, self.work_size.z() as u32);
            glu::expect_no_error(gl, "glDispatchCompute()")?;

            // Read back and compare
            {
                let block_index = resource_index(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, "Output")?;
                let block_size = glu::get_program_resource_int(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, block_index, glw::GL_BUFFER_DATA_SIZE)?;
                let value_index = resource_index(gl, program.program(), glw::GL_BUFFER_VARIABLE, "Output.values")?;
                let value_info = glu::get_program_interface_variable_info(gl, program.program(), glw::GL_BUFFER_VARIABLE, value_index)?;
                let map = BufferMemMap::new(gl, glw::GL_SHADER_STORAGE_BUFFER, 0, block_size as isize, glw::GL_MAP_READ_BIT)
                    .ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;

                if value_info.array_size as usize != input_values.len() {
                    return Err(TestError::Fail(format!(
                        "Output.values has {} elements, expected {}",
                        value_info.array_size,
                        input_values.len()
                    )));
                }

                let results: Vec<u32> = map.read_strided(value_info.offset as usize, value_info.array_stride as usize, value_info.array_size as usize);
                for (ndx, (res, input)) in results.iter().zip(&input_values).enumerate() {
                    if *res != !*input {
                        return Err(TestError::Fail(format!("Comparison failed for Output.values[{ndx}]")));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `CopyInvertSSBOCase`
struct CopyInvertSsboCase {
    name: String,
    num_values: i32,
    local_size: IVec3,
    work_size: IVec3,
}

impl TestCase for CopyInvertSsboCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let source = format!(
            "{header}\
             layout(binding = 0) buffer Input {{\n    uint values[{num}];\n}} sb_in;\n\
             layout (binding = 1) buffer Output {{\n    uint values[{num}];\n}} sb_out;\n\
             void main (void) {{\n\
             \x20   uvec3 size           = gl_NumWorkGroups * gl_WorkGroupSize;\n\
             \x20   uint numValuesPerInv = uint(sb_in.values.length()) / (size.x*size.y*size.z);\n\
             \x20   uint groupNdx        = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;\n\
             \x20   uint offset          = numValuesPerInv*groupNdx;\n\
             \n\
             \x20   for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)\n\
             \x20       sb_out.values[offset + ndx] = ~sb_in.values[offset + ndx];\n\
             }}\n",
            header = shader_header(context, self.local_size),
            num = self.num_values,
        );

        let program = build(gl, &source)?;
        let input_buffer = Buffer::new(gl);
        let output_buffer = Buffer::new(gl);

        let mut rnd = Random::new(0x124fef);
        let input_values: Vec<u32> = (0..self.num_values).map(|_| rnd.get_uint32()).collect();

        log::debug!("Work groups: {:?}", self.work_size.m_data);

        // SAFETY: as in `UboToSsboInvertCase`.
        unsafe {
            gl.use_program(program.program());

            // Input buffer setup
            {
                let block_index = resource_index(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, "Input")?;
                let block_info = glu::get_program_interface_block_info(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, block_index)?;
                let value_index = resource_index(gl, program.program(), glw::GL_BUFFER_VARIABLE, "Input.values")?;
                let value_info = glu::get_program_interface_variable_info(gl, program.program(), glw::GL_BUFFER_VARIABLE, value_index)?;

                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, input_buffer.get());
                gl.buffer_data(glw::GL_SHADER_STORAGE_BUFFER, block_info.data_size as isize, std::ptr::null(), glw::GL_STATIC_DRAW);

                if value_info.array_size as usize != input_values.len() {
                    return Err(TestError::Fail(format!(
                        "Input.values has {} elements, expected {}",
                        value_info.array_size,
                        input_values.len()
                    )));
                }

                {
                    let map = BufferMemMap::new(gl, glw::GL_SHADER_STORAGE_BUFFER, 0, block_info.data_size as isize, glw::GL_MAP_WRITE_BIT)
                        .ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;
                    map.write_strided(value_info.offset as usize, value_info.array_stride as usize, &input_values);
                }

                gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, block_info.buffer_binding, input_buffer.get());
                glu::expect_no_error(gl, "Input buffer setup failed")?;
            }

            // Output buffer setup
            {
                let block_index = resource_index(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, "Output")?;
                let block_info = glu::get_program_interface_block_info(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, block_index)?;

                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, output_buffer.get());
                gl.buffer_data(glw::GL_SHADER_STORAGE_BUFFER, block_info.data_size as isize, std::ptr::null(), glw::GL_STREAM_READ);
                gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, block_info.buffer_binding, output_buffer.get());
                glu::expect_no_error(gl, "Output buffer setup failed")?;
            }

            // Dispatch compute workload
            gl.dispatch_compute(self.work_size.x() as u32, self.work_size.y() as u32, self.work_size.z() as u32);
            glu::expect_no_error(gl, "glDispatchCompute()")?;

            // Read back and compare
            {
                let block_index = resource_index(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, "Output")?;
                let block_size = glu::get_program_resource_int(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, block_index, glw::GL_BUFFER_DATA_SIZE)?;
                let value_index = resource_index(gl, program.program(), glw::GL_BUFFER_VARIABLE, "Output.values")?;
                let value_info = glu::get_program_interface_variable_info(gl, program.program(), glw::GL_BUFFER_VARIABLE, value_index)?;
                let map = BufferMemMap::new(gl, glw::GL_SHADER_STORAGE_BUFFER, 0, block_size as isize, glw::GL_MAP_READ_BIT)
                    .ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;

                if value_info.array_size as usize != input_values.len() {
                    return Err(TestError::Fail(format!(
                        "Output.values has {} elements, expected {}",
                        value_info.array_size,
                        input_values.len()
                    )));
                }

                let results: Vec<u32> = map.read_strided(value_info.offset as usize, value_info.array_stride as usize, value_info.array_size as usize);
                for (ndx, (res, input)) in results.iter().zip(&input_values).enumerate() {
                    if *res != !*input {
                        return Err(TestError::Fail(format!("Comparison failed for Output.values[{ndx}]")));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `InvertSSBOInPlaceCase`
struct InvertSsboInPlaceCase {
    name: String,
    num_values: i32,
    is_sized: bool,
    local_size: IVec3,
    work_size: IVec3,
}

impl TestCase for InvertSsboInPlaceCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let size = if self.is_sized { self.num_values.to_string() } else { String::new() };
        let source = format!(
            "{header}\
             layout(binding = 0) buffer InOut {{\n    uint values[{size}];\n}} sb_inout;\n\
             void main (void) {{\n\
             \x20   uvec3 size           = gl_NumWorkGroups * gl_WorkGroupSize;\n\
             \x20   uint numValuesPerInv = uint(sb_inout.values.length()) / (size.x*size.y*size.z);\n\
             \x20   uint groupNdx        = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;\n\
             \x20   uint offset          = numValuesPerInv*groupNdx;\n\
             \n\
             \x20   for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)\n\
             \x20       sb_inout.values[offset + ndx] = ~sb_inout.values[offset + ndx];\n\
             }}\n",
            header = shader_header(context, self.local_size),
        );

        let program = build(gl, &source)?;
        let output_buffer = Buffer::new(gl);

        // SAFETY: as above.
        unsafe {
            let value_index = resource_index(gl, program.program(), glw::GL_BUFFER_VARIABLE, "InOut.values")?;
            let value_info = glu::get_program_interface_variable_info(gl, program.program(), glw::GL_BUFFER_VARIABLE, value_index)?;
            let block_size = value_info.array_stride * self.num_values;

            let mut rnd = Random::new(0x82ce7f);
            let input_values: Vec<u32> = (0..self.num_values).map(|_| rnd.get_uint32()).collect();

            let expected_array_size = if self.is_sized { self.num_values as u32 } else { 0 };
            if value_info.array_size != expected_array_size {
                return Err(TestError::Fail(format!(
                    "InOut.values reports an array size of {}, expected {expected_array_size}",
                    value_info.array_size
                )));
            }

            log::debug!("Work groups: {:?}", self.work_size.m_data);

            gl.use_program(program.program());

            // Output buffer setup
            {
                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, output_buffer.get());
                gl.buffer_data(glw::GL_SHADER_STORAGE_BUFFER, block_size as isize, std::ptr::null(), glw::GL_STREAM_DRAW);

                {
                    let map = BufferMemMap::new(gl, glw::GL_SHADER_STORAGE_BUFFER, 0, block_size as isize, glw::GL_MAP_WRITE_BIT)
                        .ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;
                    map.write_strided(value_info.offset as usize, value_info.array_stride as usize, &input_values);
                }

                gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, output_buffer.get());
                glu::expect_no_error(gl, "Buffer setup failed")?;
            }

            // Dispatch compute workload
            gl.dispatch_compute(self.work_size.x() as u32, self.work_size.y() as u32, self.work_size.z() as u32);
            glu::expect_no_error(gl, "glDispatchCompute()")?;

            // Read back and compare
            {
                let map = BufferMemMap::new(gl, glw::GL_SHADER_STORAGE_BUFFER, 0, block_size as isize, glw::GL_MAP_READ_BIT)
                    .ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;
                let results: Vec<u32> = map.read_strided(value_info.offset as usize, value_info.array_stride as usize, input_values.len());
                for (ndx, (res, input)) in results.iter().zip(&input_values).enumerate() {
                    if *res != !*input {
                        return Err(TestError::Fail(format!("Comparison failed for InOut.values[{ndx}]")));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `WriteToMultipleSSBOCase`
struct WriteToMultipleSsboCase {
    name: String,
    num_values: i32,
    is_sized: bool,
    local_size: IVec3,
    work_size: IVec3,
}

impl TestCase for WriteToMultipleSsboCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let size = if self.is_sized { self.num_values.to_string() } else { String::new() };
        let source = format!(
            "{header}\
             layout(binding = 0) buffer Out0 {{\n    uint values[{size}];\n}} sb_out0;\n\
             layout(binding = 1) buffer Out1 {{\n    uint values[{size}];\n}} sb_out1;\n\
             void main (void) {{\n\
             \x20   uvec3 size      = gl_NumWorkGroups * gl_WorkGroupSize;\n\
             \x20   uint groupNdx   = size.x*size.y*gl_GlobalInvocationID.z + size.x*gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;\n\
             \n\
             \x20   {{\n\
             \x20       uint numValuesPerInv = uint(sb_out0.values.length()) / (size.x*size.y*size.z);\n\
             \x20       uint offset          = numValuesPerInv*groupNdx;\n\
             \n\
             \x20       for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)\n\
             \x20           sb_out0.values[offset + ndx] = offset + ndx;\n\
             \x20   }}\n\
             \x20   {{\n\
             \x20       uint numValuesPerInv = uint(sb_out1.values.length()) / (size.x*size.y*size.z);\n\
             \x20       uint offset          = numValuesPerInv*groupNdx;\n\
             \n\
             \x20       for (uint ndx = 0u; ndx < numValuesPerInv; ndx++)\n\
             \x20           sb_out1.values[offset + ndx] = uint(sb_out1.values.length()) - offset - ndx;\n\
             \x20   }}\n\
             }}\n",
            header = shader_header(context, self.local_size),
        );

        let program = build(gl, &source)?;
        let output_buffer0 = Buffer::new(gl);
        let output_buffer1 = Buffer::new(gl);

        // SAFETY: as above.
        unsafe {
            let value0_index = resource_index(gl, program.program(), glw::GL_BUFFER_VARIABLE, "Out0.values")?;
            let value0_info = glu::get_program_interface_variable_info(gl, program.program(), glw::GL_BUFFER_VARIABLE, value0_index)?;
            let block0_size = value0_info.array_stride * self.num_values;

            let value1_index = resource_index(gl, program.program(), glw::GL_BUFFER_VARIABLE, "Out1.values")?;
            let value1_info = glu::get_program_interface_variable_info(gl, program.program(), glw::GL_BUFFER_VARIABLE, value1_index)?;
            let block1_size = value1_info.array_stride * self.num_values;

            let expected_array_size = if self.is_sized { self.num_values as u32 } else { 0 };
            for (which, info) in [("Out0", &value0_info), ("Out1", &value1_info)] {
                if info.array_size != expected_array_size {
                    return Err(TestError::Fail(format!(
                        "{which}.values reports an array size of {}, expected {expected_array_size}",
                        info.array_size
                    )));
                }
            }

            log::debug!("Work groups: {:?}", self.work_size.m_data);

            gl.use_program(program.program());

            // Output buffer setup
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, output_buffer0.get());
            gl.buffer_data(glw::GL_SHADER_STORAGE_BUFFER, block0_size as isize, std::ptr::null(), glw::GL_STREAM_DRAW);
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, output_buffer0.get());
            glu::expect_no_error(gl, "Buffer setup failed")?;

            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, output_buffer1.get());
            gl.buffer_data(glw::GL_SHADER_STORAGE_BUFFER, block1_size as isize, std::ptr::null(), glw::GL_STREAM_DRAW);
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, output_buffer1.get());
            glu::expect_no_error(gl, "Buffer setup failed")?;

            // Dispatch compute workload
            gl.dispatch_compute(self.work_size.x() as u32, self.work_size.y() as u32, self.work_size.z() as u32);
            glu::expect_no_error(gl, "glDispatchCompute()")?;

            // Read back and compare
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, output_buffer0.get());
            {
                let map = BufferMemMap::new(gl, glw::GL_SHADER_STORAGE_BUFFER, 0, block0_size as isize, glw::GL_MAP_READ_BIT)
                    .ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;
                let results: Vec<u32> = map.read_strided(value0_info.offset as usize, value0_info.array_stride as usize, self.num_values as usize);
                for (ndx, res) in results.iter().enumerate() {
                    let reference = ndx as u32;
                    if *res != reference {
                        return Err(TestError::Fail(format!("Comparison failed for Out0.values[{ndx}] res={res} ref={reference}")));
                    }
                }
            }

            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, output_buffer1.get());
            {
                let map = BufferMemMap::new(gl, glw::GL_SHADER_STORAGE_BUFFER, 0, block1_size as isize, glw::GL_MAP_READ_BIT)
                    .ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;
                let results: Vec<u32> = map.read_strided(value1_info.offset as usize, value1_info.array_stride as usize, self.num_values as usize);
                for (ndx, res) in results.iter().enumerate() {
                    let reference = self.num_values as u32 - ndx as u32;
                    if *res != reference {
                        return Err(TestError::Fail(format!("Comparison failed for Out1.values[{ndx}] res={res} ref={reference}")));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `SSBOLocalBarrierCase`
struct SsboLocalBarrierCase {
    name: String,
    local_size: IVec3,
    work_size: IVec3,
}

impl TestCase for SsboLocalBarrierCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let output_buffer = Buffer::new(gl);
        let work_group_size = multiply_components(self.local_size);
        let work_group_count = multiply_components(self.work_size);
        let num_values = work_group_size * work_group_count;

        let source = format!(
            "{header}\
             layout(binding = 0) buffer Output {{\n    coherent uint values[{num_values}];\n}} sb_out;\n\n\
             shared uint offsets[{work_group_size}];\n\n\
             void main (void) {{\n\
             \x20   uint localSize  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_WorkGroupSize.z;\n\
             \x20   uint globalNdx  = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;\n\
             \x20   uint globalOffs = localSize*globalNdx;\n\
             \x20   uint localOffs  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_LocalInvocationID.z + gl_WorkGroupSize.x*gl_LocalInvocationID.y + gl_LocalInvocationID.x;\n\
             \n\
             \x20   sb_out.values[globalOffs + localOffs] = globalOffs;\n\
             \x20   memoryBarrierBuffer();\n\
             \x20   barrier();\n\
             \x20   sb_out.values[globalOffs + ((localOffs+1u)%localSize)] += localOffs;\n\
             \x20   memoryBarrierBuffer();\n\
             \x20   barrier();\n\
             \x20   sb_out.values[globalOffs + ((localOffs+2u)%localSize)] += localOffs;\n\
             }}\n",
            header = shader_header(context, self.local_size),
        );

        let program = build(gl, &source)?;

        log::debug!("Work groups: {:?}", self.work_size.m_data);

        // SAFETY: as above.
        unsafe {
            gl.use_program(program.program());

            // Output buffer setup
            {
                let block_index = resource_index(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, "Output")?;
                let block_size = glu::get_program_resource_int(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, block_index, glw::GL_BUFFER_DATA_SIZE)?;

                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, output_buffer.get());
                gl.buffer_data(glw::GL_SHADER_STORAGE_BUFFER, block_size as isize, std::ptr::null(), glw::GL_STREAM_READ);
                gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, output_buffer.get());
                glu::expect_no_error(gl, "Output buffer setup failed")?;
            }

            // Dispatch compute workload
            gl.dispatch_compute(self.work_size.x() as u32, self.work_size.y() as u32, self.work_size.z() as u32);
            glu::expect_no_error(gl, "glDispatchCompute()")?;

            // Read back and compare
            {
                let block_index = resource_index(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, "Output")?;
                let block_size = glu::get_program_resource_int(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, block_index, glw::GL_BUFFER_DATA_SIZE)?;
                let value_index = resource_index(gl, program.program(), glw::GL_BUFFER_VARIABLE, "Output.values")?;
                let value_info = glu::get_program_interface_variable_info(gl, program.program(), glw::GL_BUFFER_VARIABLE, value_index)?;
                let map = BufferMemMap::new(gl, glw::GL_SHADER_STORAGE_BUFFER, 0, block_size as isize, glw::GL_MAP_READ_BIT)
                    .ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;

                let results: Vec<u32> = map.read_strided(value_info.offset as usize, value_info.array_stride as usize, num_values as usize);

                for group_ndx in 0..work_group_count {
                    for local_offs in 0..work_group_size {
                        let global_offs = group_ndx * work_group_size;
                        let res = results[(global_offs + local_offs) as usize];
                        // Each invocation adds its own index to its two neighbours, so
                        // the value at one slot is the base plus the two indices that
                        // wrote to it - which for the first slots wrap round the group.
                        let offs0 = if local_offs - 1 < 0 {
                            (local_offs + work_group_size - 1) % work_group_size
                        } else {
                            (local_offs - 1) % work_group_size
                        };
                        let offs1 = if local_offs - 2 < 0 {
                            (local_offs + work_group_size - 2) % work_group_size
                        } else {
                            (local_offs - 2) % work_group_size
                        };
                        let reference = (global_offs + offs0 + offs1) as u32;

                        if res != reference {
                            return Err(TestError::Fail(format!("Comparison failed for Output.values[{}]", global_offs + local_offs)));
                        }
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `SSBOBarrierCase`
struct SsboBarrierCase {
    name: String,
    work_size: IVec3,
}

impl TestCase for SsboBarrierCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let declaration = context.context_type().glsl_version().declaration();

        let source0 = format!(
            "{declaration}\n\
             layout (local_size_x = 1) in;\n\
             uniform uint u_baseVal;\n\
             layout(binding = 1) buffer Output {{\n    uint values[];\n}};\n\
             void main (void) {{\n\
             \x20   uint offset = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;\n\
             \x20   values[offset] = u_baseVal+offset;\n\
             }}\n"
        );

        let source1 = format!(
            "{declaration}\n\
             layout (local_size_x = 1) in;\n\
             uniform uint u_baseVal;\n\
             layout(binding = 1) buffer Input {{\n    uint values[];\n}};\n\
             layout(binding = 0) buffer Output {{\n    coherent uint sum;\n}};\n\
             void main (void) {{\n\
             \x20   uint offset = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;\n\
             \x20   uint value  = values[offset];\n\
             \x20   atomicAdd(sum, value);\n\
             }}\n"
        );

        let program0 = build(gl, &source0)?;
        let program1 = build(gl, &source1)?;
        let temp_buffer = Buffer::new(gl);
        let output_buffer = Buffer::new(gl);
        let base_value: u32 = 127;

        log::debug!("Work groups: {:?}", self.work_size.m_data);

        // SAFETY: as above.
        unsafe {
            // Temp buffer setup
            {
                let value_index = resource_index(gl, program0.program(), glw::GL_BUFFER_VARIABLE, "values[0]")?;
                let value_info = glu::get_program_interface_variable_info(gl, program0.program(), glw::GL_BUFFER_VARIABLE, value_index)?;
                let buffer_size = value_info.array_stride * multiply_components(self.work_size);

                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, temp_buffer.get());
                gl.buffer_data(glw::GL_SHADER_STORAGE_BUFFER, buffer_size as isize, std::ptr::null(), glw::GL_STATIC_DRAW);
                gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, temp_buffer.get());
                glu::expect_no_error(gl, "Temp buffer setup failed")?;
            }

            // Output buffer setup
            {
                let block_index = resource_index(gl, program1.program(), glw::GL_SHADER_STORAGE_BLOCK, "Output")?;
                let block_size = glu::get_program_resource_int(gl, program1.program(), glw::GL_SHADER_STORAGE_BLOCK, block_index, glw::GL_BUFFER_DATA_SIZE)?;

                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, output_buffer.get());
                gl.buffer_data(glw::GL_SHADER_STORAGE_BUFFER, block_size as isize, std::ptr::null(), glw::GL_STREAM_READ);

                {
                    let map = BufferMemMap::new(gl, glw::GL_SHADER_STORAGE_BUFFER, 0, block_size as isize, glw::GL_MAP_WRITE_BIT)
                        .ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;
                    map.get().write_bytes(0, block_size as usize);
                }

                gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, output_buffer.get());
                glu::expect_no_error(gl, "Output buffer setup failed")?;
            }

            // Dispatch compute workload
            let base_val_name = std::ffi::CString::new("u_baseVal").expect("no interior nul");
            gl.use_program(program0.program());
            gl.uniform_1ui(gl.get_uniform_location(program0.program(), base_val_name.as_ptr()), base_value);
            gl.dispatch_compute(self.work_size.x() as u32, self.work_size.y() as u32, self.work_size.z() as u32);
            gl.memory_barrier(glw::GL_SHADER_STORAGE_BARRIER_BIT);
            gl.use_program(program1.program());
            gl.dispatch_compute(self.work_size.x() as u32, self.work_size.y() as u32, self.work_size.z() as u32);
            glu::expect_no_error(gl, "Failed to dispatch commands")?;

            // Read back and compare
            {
                let block_index = resource_index(gl, program1.program(), glw::GL_SHADER_STORAGE_BLOCK, "Output")?;
                let block_size = glu::get_program_resource_int(gl, program1.program(), glw::GL_SHADER_STORAGE_BLOCK, block_index, glw::GL_BUFFER_DATA_SIZE)?;
                let value_index = resource_index(gl, program1.program(), glw::GL_BUFFER_VARIABLE, "sum")?;
                let value_info = glu::get_program_interface_variable_info(gl, program1.program(), glw::GL_BUFFER_VARIABLE, value_index)?;
                let map = BufferMemMap::new(gl, glw::GL_SHADER_STORAGE_BUFFER, 0, block_size as isize, glw::GL_MAP_READ_BIT)
                    .ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;

                let res: u32 = map.read_strided::<u32>(value_info.offset as usize, 0, 1)[0];
                let reference: u32 = (0..multiply_components(self.work_size)).map(|ndx| base_value + ndx as u32).sum();

                if res != reference {
                    log::error!("ERROR: comparison failed, expected {reference}, got {res}");
                    return Err(TestError::Fail("Comparison failed".to_string()));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `BasicSharedVarCase`
struct BasicSharedVarCase {
    name: String,
    local_size: IVec3,
    work_size: IVec3,
}

impl TestCase for BasicSharedVarCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let output_buffer = Buffer::new(gl);
        let work_group_size = multiply_components(self.local_size);
        let work_group_count = multiply_components(self.work_size);
        let num_values = work_group_size * work_group_count;

        let source = format!(
            "{header}\
             layout(binding = 0) buffer Output {{\n    uint values[{num_values}];\n}} sb_out;\n\n\
             shared uint offsets[{work_group_size}];\n\n\
             void main (void) {{\n\
             \x20   uint localSize  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_WorkGroupSize.z;\n\
             \x20   uint globalNdx  = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;\n\
             \x20   uint globalOffs = localSize*globalNdx;\n\
             \x20   uint localOffs  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_LocalInvocationID.z + gl_WorkGroupSize.x*gl_LocalInvocationID.y + gl_LocalInvocationID.x;\n\
             \n\
             \x20   offsets[localSize-localOffs-1u] = globalOffs + localOffs*localOffs;\n\
             \x20   barrier();\n\
             \x20   sb_out.values[globalOffs + localOffs] = offsets[localOffs];\n\
             }}\n",
            header = shader_header(context, self.local_size),
        );

        let program = build(gl, &source)?;

        log::debug!("Work groups: {:?}", self.work_size.m_data);

        // SAFETY: as above.
        unsafe {
            gl.use_program(program.program());

            // Output buffer setup
            {
                let block_index = resource_index(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, "Output")?;
                let block_size = glu::get_program_resource_int(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, block_index, glw::GL_BUFFER_DATA_SIZE)?;

                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, output_buffer.get());
                gl.buffer_data(glw::GL_SHADER_STORAGE_BUFFER, block_size as isize, std::ptr::null(), glw::GL_STREAM_READ);
                gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, output_buffer.get());
                glu::expect_no_error(gl, "Output buffer setup failed")?;
            }

            // Dispatch compute workload
            gl.dispatch_compute(self.work_size.x() as u32, self.work_size.y() as u32, self.work_size.z() as u32);
            glu::expect_no_error(gl, "glDispatchCompute()")?;

            // Read back and compare
            {
                let block_index = resource_index(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, "Output")?;
                let block_size = glu::get_program_resource_int(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, block_index, glw::GL_BUFFER_DATA_SIZE)?;
                let value_index = resource_index(gl, program.program(), glw::GL_BUFFER_VARIABLE, "Output.values")?;
                let value_info = glu::get_program_interface_variable_info(gl, program.program(), glw::GL_BUFFER_VARIABLE, value_index)?;
                let map = BufferMemMap::new(gl, glw::GL_SHADER_STORAGE_BUFFER, 0, block_size as isize, glw::GL_MAP_READ_BIT)
                    .ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;

                let results: Vec<u32> = map.read_strided(value_info.offset as usize, value_info.array_stride as usize, num_values as usize);

                for group_ndx in 0..work_group_count {
                    for local_offs in 0..work_group_size {
                        let global_offs = group_ndx * work_group_size;
                        let res = results[(global_offs + local_offs) as usize];
                        let mirrored = work_group_size - local_offs - 1;
                        let reference = (global_offs + mirrored * mirrored) as u32;

                        if res != reference {
                            return Err(TestError::Fail(format!("Comparison failed for Output.values[{}]", global_offs + local_offs)));
                        }
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `SharedVarAtomicOpCase`
struct SharedVarAtomicOpCase {
    name: String,
    local_size: IVec3,
    work_size: IVec3,
}

impl TestCase for SharedVarAtomicOpCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let output_buffer = Buffer::new(gl);
        let work_group_size = multiply_components(self.local_size);
        let work_group_count = multiply_components(self.work_size);
        let num_values = work_group_size * work_group_count;

        let source = format!(
            "{header}\
             layout(binding = 0) buffer Output {{\n    uint values[{num_values}];\n}} sb_out;\n\n\
             shared uint count;\n\n\
             void main (void) {{\n\
             \x20   uint localSize  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_WorkGroupSize.z;\n\
             \x20   uint globalNdx  = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;\n\
             \x20   uint globalOffs = localSize*globalNdx;\n\
             \n\
             \x20   count = 0u;\n\
             \x20   barrier();\n\
             \x20   uint oldVal = atomicAdd(count, 1u);\n\
             \x20   sb_out.values[globalOffs+oldVal] = oldVal+1u;\n\
             }}\n",
            header = shader_header(context, self.local_size),
        );

        let program = build(gl, &source)?;

        log::debug!("Work groups: {:?}", self.work_size.m_data);

        // SAFETY: as above.
        unsafe {
            gl.use_program(program.program());

            // Output buffer setup
            {
                let block_index = resource_index(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, "Output")?;
                let block_size = glu::get_program_resource_int(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, block_index, glw::GL_BUFFER_DATA_SIZE)?;

                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, output_buffer.get());
                gl.buffer_data(glw::GL_SHADER_STORAGE_BUFFER, block_size as isize, std::ptr::null(), glw::GL_STREAM_READ);
                gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, output_buffer.get());
                glu::expect_no_error(gl, "Output buffer setup failed")?;
            }

            // Dispatch compute workload
            gl.dispatch_compute(self.work_size.x() as u32, self.work_size.y() as u32, self.work_size.z() as u32);
            glu::expect_no_error(gl, "glDispatchCompute()")?;

            // Read back and compare
            {
                let block_index = resource_index(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, "Output")?;
                let block_size = glu::get_program_resource_int(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, block_index, glw::GL_BUFFER_DATA_SIZE)?;
                let value_index = resource_index(gl, program.program(), glw::GL_BUFFER_VARIABLE, "Output.values")?;
                let value_info = glu::get_program_interface_variable_info(gl, program.program(), glw::GL_BUFFER_VARIABLE, value_index)?;
                let map = BufferMemMap::new(gl, glw::GL_SHADER_STORAGE_BUFFER, 0, block_size as isize, glw::GL_MAP_READ_BIT)
                    .ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;

                let results: Vec<u32> = map.read_strided(value_info.offset as usize, value_info.array_stride as usize, num_values as usize);

                for group_ndx in 0..work_group_count {
                    for local_offs in 0..work_group_size {
                        let global_offs = group_ndx * work_group_size;
                        let res = results[(global_offs + local_offs) as usize];
                        let reference = (local_offs + 1) as u32;

                        if res != reference {
                            return Err(TestError::Fail(format!("Comparison failed for Output.values[{}]", global_offs + local_offs)));
                        }
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `CopyImageToSSBOCase`
struct CopyImageToSSBOCase {
    name: String,
    local_size: IVec2,
    image_size: IVec2,
}

impl TestCase for CopyImageToSSBOCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        assert_eq!(self.image_size.x() % self.local_size.x(), 0);
        assert_eq!(self.image_size.y() % self.local_size.y(), 0);

        let source = format!(
            "{version}\n\
             layout (local_size_x = {local_x}, local_size_y = {local_y}) in;\n\
             layout(r32ui, binding = 1) readonly uniform highp uimage2D u_srcImg;\n\
             layout(binding = 0) buffer Output {{\n    uint values[{num_values}];\n}} sb_out;\n\n\
             void main (void) {{\n\
             \x20   uint stride = gl_NumWorkGroups.x*gl_WorkGroupSize.x;\n\
             \x20   uint value  = imageLoad(u_srcImg, ivec2(gl_GlobalInvocationID.xy)).x;\n\
             \x20   sb_out.values[gl_GlobalInvocationID.y*stride + gl_GlobalInvocationID.x] = value;\n\
             }}\n",
            version = context.context_type().glsl_version().declaration(),
            local_x = self.local_size.x(),
            local_y = self.local_size.y(),
            num_values = self.image_size.x() * self.image_size.y(),
        );

        let gl = context.gl();
        let output_buffer = Buffer::new(gl);
        let input_texture = Texture::new(gl);
        let program = build(gl, &source)?;
        let work_size = IVec2::new(self.image_size.x() / self.local_size.x(), self.image_size.y() / self.local_size.y());
        let mut rnd = Random::new(0xab2c7);
        let mut input_values = vec![0u32; (self.image_size.x() * self.image_size.y()) as usize];

        log::debug!("Work groups: {:?}", work_size.m_data);

        // SAFETY: a current context; every pointer below is to a live local.
        unsafe {
            gl.use_program(program.program());

            // Input values
            for value in &mut input_values {
                *value = rnd.get_uint32();
            }

            // Input image setup
            gl.bind_texture(glw::GL_TEXTURE_2D, input_texture.get());
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_R32UI, self.image_size.x(), self.image_size.y());
            gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                self.image_size.x(),
                self.image_size.y(),
                glw::GL_RED_INTEGER,
                glw::GL_UNSIGNED_INT,
                input_values.as_ptr().cast(),
            );
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
            glu::expect_no_error(gl, "Uploading image data failed")?;

            // Bind to unit 1
            gl.bind_image_texture(1, input_texture.get(), 0, glw::FALSE, 0, glw::GL_READ_ONLY, glw::GL_R32UI);
            glu::expect_no_error(gl, "Image setup failed")?;

            // Output buffer setup
            {
                let block_index = resource_index(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, "Output")?;
                let block_size = glu::get_program_resource_int(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, block_index, glw::GL_BUFFER_DATA_SIZE)?;

                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, output_buffer.get());
                gl.buffer_data(glw::GL_SHADER_STORAGE_BUFFER, block_size as isize, std::ptr::null(), glw::GL_STREAM_READ);
                gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, output_buffer.get());
                glu::expect_no_error(gl, "Output buffer setup failed")?;
            }

            // Dispatch compute workload
            gl.dispatch_compute(work_size.x() as u32, work_size.y() as u32, 1);
            glu::expect_no_error(gl, "glDispatchCompute()")?;

            // Read back and compare
            {
                let block_index = resource_index(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, "Output")?;
                let block_size = glu::get_program_resource_int(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, block_index, glw::GL_BUFFER_DATA_SIZE)?;
                let value_index = resource_index(gl, program.program(), glw::GL_BUFFER_VARIABLE, "Output.values")?;
                let value_info = glu::get_program_interface_variable_info(gl, program.program(), glw::GL_BUFFER_VARIABLE, value_index)?;
                let map = BufferMemMap::new(gl, glw::GL_SHADER_STORAGE_BUFFER, 0, block_size as isize, glw::GL_MAP_READ_BIT)
                    .ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;

                if value_info.array_size as usize != input_values.len() {
                    return Err(TestError::Fail(format!(
                        "Output.values has {} elements, expected {}",
                        value_info.array_size,
                        input_values.len()
                    )));
                }

                let results: Vec<u32> = map.read_strided(value_info.offset as usize, value_info.array_stride as usize, value_info.array_size as usize);

                for (ndx, (&res, &reference)) in results.iter().zip(input_values.iter()).enumerate() {
                    if res != reference {
                        return Err(TestError::Fail(format!("Comparison failed for Output.values[{ndx}]")));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `AtomicCounterCase`
struct AtomicCounterCase {
    name: String,
    local_size: IVec3,
    work_size: IVec3,
}

impl TestCase for AtomicCounterCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let output_buffer = Buffer::new(gl);
        let counter_buffer = Buffer::new(gl);
        let work_group_size = multiply_components(self.local_size);
        let work_group_count = multiply_components(self.work_size);
        let num_values = work_group_size * work_group_count;

        let source = format!(
            "{header}\
             layout(binding = 0) buffer Output {{\n    uint values[{num_values}];\n}} sb_out;\n\n\
             layout(binding = 0, offset = 0) uniform atomic_uint u_count;\n\n\
             void main (void) {{\n\
             \x20   uint localSize  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_WorkGroupSize.z;\n\
             \x20   uint globalNdx  = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;\n\
             \x20   uint globalOffs = localSize*globalNdx;\n\
             \x20   uint localOffs  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_LocalInvocationID.z + gl_WorkGroupSize.x*gl_LocalInvocationID.y + gl_LocalInvocationID.x;\n\
             \n\
             \x20   uint oldVal = atomicCounterIncrement(u_count);\n\
             \x20   sb_out.values[globalOffs+localOffs] = oldVal;\n\
             }}\n",
            header = shader_header(context, self.local_size),
        );

        let program = build(gl, &source)?;

        log::debug!("Work groups: {:?}", self.work_size.m_data);

        // SAFETY: as above.
        unsafe {
            gl.use_program(program.program());

            // Atomic counter buffer setup
            {
                let uniform_index = resource_index(gl, program.program(), glw::GL_UNIFORM, "u_count")?;
                let buffer_index =
                    glu::program_interface_query::get_program_resource_uint(gl, program.program(), glw::GL_UNIFORM, uniform_index, glw::GL_ATOMIC_COUNTER_BUFFER_INDEX)?;
                let buffer_size =
                    glu::program_interface_query::get_program_resource_uint(gl, program.program(), glw::GL_ATOMIC_COUNTER_BUFFER, buffer_index, glw::GL_BUFFER_DATA_SIZE)?;

                gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, counter_buffer.get());
                gl.buffer_data(glw::GL_ATOMIC_COUNTER_BUFFER, buffer_size as isize, std::ptr::null(), glw::GL_STREAM_READ);

                {
                    let map = BufferMemMap::new(gl, glw::GL_ATOMIC_COUNTER_BUFFER, 0, buffer_size as isize, glw::GL_MAP_WRITE_BIT)
                        .ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;
                    map.get().write_bytes(0, buffer_size as usize);
                }

                gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, counter_buffer.get());
                glu::expect_no_error(gl, "Atomic counter buffer setup failed")?;
            }

            // Output buffer setup
            {
                let block_index = resource_index(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, "Output")?;
                let block_size = glu::get_program_resource_int(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, block_index, glw::GL_BUFFER_DATA_SIZE)?;

                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, output_buffer.get());
                gl.buffer_data(glw::GL_SHADER_STORAGE_BUFFER, block_size as isize, std::ptr::null(), glw::GL_STREAM_READ);
                gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, output_buffer.get());
                glu::expect_no_error(gl, "Output buffer setup failed")?;
            }

            // Dispatch compute workload
            gl.dispatch_compute(self.work_size.x() as u32, self.work_size.y() as u32, self.work_size.z() as u32);
            glu::expect_no_error(gl, "glDispatchCompute()")?;

            // Read back and compare the atomic counter
            {
                let uniform_index = resource_index(gl, program.program(), glw::GL_UNIFORM, "u_count")?;
                let uniform_offset = glu::program_interface_query::get_program_resource_uint(gl, program.program(), glw::GL_UNIFORM, uniform_index, glw::GL_OFFSET)?;
                let buffer_index =
                    glu::program_interface_query::get_program_resource_uint(gl, program.program(), glw::GL_UNIFORM, uniform_index, glw::GL_ATOMIC_COUNTER_BUFFER_INDEX)?;
                let buffer_size =
                    glu::program_interface_query::get_program_resource_uint(gl, program.program(), glw::GL_ATOMIC_COUNTER_BUFFER, buffer_index, glw::GL_BUFFER_DATA_SIZE)?;
                let map = BufferMemMap::new(gl, glw::GL_ATOMIC_COUNTER_BUFFER, 0, buffer_size as isize, glw::GL_MAP_READ_BIT)
                    .ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;

                let res = map.read_strided::<u32>(uniform_offset as usize, 0, 1)[0];
                if res != num_values as u32 {
                    return Err(TestError::Fail("Invalid atomic counter value".to_string()));
                }
            }

            // Read back and compare the SSBO
            {
                let block_index = resource_index(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, "Output")?;
                let block_size = glu::get_program_resource_int(gl, program.program(), glw::GL_SHADER_STORAGE_BLOCK, block_index, glw::GL_BUFFER_DATA_SIZE)?;
                let value_index = resource_index(gl, program.program(), glw::GL_BUFFER_VARIABLE, "Output.values")?;
                let value_info = glu::get_program_interface_variable_info(gl, program.program(), glw::GL_BUFFER_VARIABLE, value_index)?;
                let map = BufferMemMap::new(gl, glw::GL_SHADER_STORAGE_BUFFER, 0, block_size as isize, glw::GL_MAP_READ_BIT)
                    .ok_or_else(|| TestError::Fail("glMapBufferRange() returned null".to_string()))?;

                let results: Vec<u32> = map.read_strided(value_info.offset as usize, value_info.array_stride as usize, num_values as usize);

                // Which invocation got which counter value is not defined, so the check
                // is that every value is in range and that the whole set sums to the
                // sum of 0..numValues - i.e. each value appeared exactly once.
                let mut value_sum: u32 = 0;
                let mut reference_sum: u32 = 0;
                for (val_ndx, res) in results.iter().enumerate() {
                    value_sum = value_sum.wrapping_add(*res);
                    reference_sum = reference_sum.wrapping_add(val_ndx as u32);

                    if *res >= num_values as u32 {
                        return Err(TestError::Fail(format!("Comparison failed for Output.values[{val_ndx}]")));
                    }
                }

                if value_sum != reference_sum {
                    return Err(TestError::Fail("Total sum of values in Output.values doesn't match".to_string()));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `BasicComputeShaderTests::init` - the same cases in the same order as upstream,
/// minus the eight image ones noted at the top of this file.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("basic");

    group.add_child(Box::new(EmptyComputeShaderCase) as Box<dyn TestCase>);

    for (name, num_values, local_size, work_size) in [
        ("ubo_to_ssbo_single_invocation", 256, IVec3::new(1, 1, 1), IVec3::new(1, 1, 1)),
        ("ubo_to_ssbo_single_group", 1024, IVec3::new(2, 1, 4), IVec3::new(1, 1, 1)),
        ("ubo_to_ssbo_multiple_invocations", 1024, IVec3::new(1, 1, 1), IVec3::new(2, 4, 1)),
        ("ubo_to_ssbo_multiple_groups", 1024, IVec3::new(1, 4, 2), IVec3::new(2, 2, 4)),
    ] {
        group.add_child(Box::new(UboToSsboInvertCase {
            name: name.to_string(),
            num_values,
            local_size,
            work_size,
        }) as Box<dyn TestCase>);
    }

    for (name, num_values, local_size, work_size) in [
        ("copy_ssbo_single_invocation", 256, IVec3::new(1, 1, 1), IVec3::new(1, 1, 1)),
        ("copy_ssbo_multiple_invocations", 1024, IVec3::new(1, 1, 1), IVec3::new(2, 4, 1)),
        ("copy_ssbo_multiple_groups", 1024, IVec3::new(1, 4, 2), IVec3::new(2, 2, 4)),
    ] {
        group.add_child(Box::new(CopyInvertSsboCase {
            name: name.to_string(),
            num_values,
            local_size,
            work_size,
        }) as Box<dyn TestCase>);
    }

    for (name, num_values, is_sized, local_size, work_size) in [
        ("ssbo_rw_single_invocation", 256, true, IVec3::new(1, 1, 1), IVec3::new(1, 1, 1)),
        ("ssbo_rw_multiple_groups", 1024, true, IVec3::new(1, 4, 2), IVec3::new(2, 2, 4)),
        ("ssbo_unsized_arr_single_invocation", 256, false, IVec3::new(1, 1, 1), IVec3::new(1, 1, 1)),
        ("ssbo_unsized_arr_multiple_groups", 1024, false, IVec3::new(1, 4, 2), IVec3::new(2, 2, 4)),
    ] {
        group.add_child(Box::new(InvertSsboInPlaceCase {
            name: name.to_string(),
            num_values,
            is_sized,
            local_size,
            work_size,
        }) as Box<dyn TestCase>);
    }

    for (name, num_values, is_sized, local_size, work_size) in [
        ("write_multiple_arr_single_invocation", 256, true, IVec3::new(1, 1, 1), IVec3::new(1, 1, 1)),
        ("write_multiple_arr_multiple_groups", 1024, true, IVec3::new(1, 4, 2), IVec3::new(2, 2, 4)),
        ("write_multiple_unsized_arr_single_invocation", 256, false, IVec3::new(1, 1, 1), IVec3::new(1, 1, 1)),
        ("write_multiple_unsized_arr_multiple_groups", 1024, false, IVec3::new(1, 4, 2), IVec3::new(2, 2, 4)),
    ] {
        group.add_child(Box::new(WriteToMultipleSsboCase {
            name: name.to_string(),
            num_values,
            is_sized,
            local_size,
            work_size,
        }) as Box<dyn TestCase>);
    }

    for (name, local_size, work_size) in [
        ("ssbo_local_barrier_single_invocation", IVec3::new(1, 1, 1), IVec3::new(1, 1, 1)),
        ("ssbo_local_barrier_single_group", IVec3::new(3, 2, 5), IVec3::new(1, 1, 1)),
        ("ssbo_local_barrier_multiple_groups", IVec3::new(3, 4, 1), IVec3::new(2, 7, 3)),
    ] {
        group.add_child(Box::new(SsboLocalBarrierCase {
            name: name.to_string(),
            local_size,
            work_size,
        }) as Box<dyn TestCase>);
    }

    for (name, work_size) in [("ssbo_cmd_barrier_single", IVec3::new(1, 1, 1)), ("ssbo_cmd_barrier_multiple", IVec3::new(11, 5, 7))] {
        group.add_child(Box::new(SsboBarrierCase {
            name: name.to_string(),
            work_size,
        }) as Box<dyn TestCase>);
    }

    for (name, local_size, work_size) in [
        ("shared_var_single_invocation", IVec3::new(1, 1, 1), IVec3::new(1, 1, 1)),
        ("shared_var_single_group", IVec3::new(3, 2, 5), IVec3::new(1, 1, 1)),
        ("shared_var_multiple_invocations", IVec3::new(1, 1, 1), IVec3::new(2, 5, 4)),
        ("shared_var_multiple_groups", IVec3::new(3, 4, 1), IVec3::new(2, 7, 3)),
    ] {
        group.add_child(Box::new(BasicSharedVarCase {
            name: name.to_string(),
            local_size,
            work_size,
        }) as Box<dyn TestCase>);
    }

    for (name, local_size, work_size) in [
        ("shared_atomic_op_single_invocation", IVec3::new(1, 1, 1), IVec3::new(1, 1, 1)),
        ("shared_atomic_op_single_group", IVec3::new(3, 2, 5), IVec3::new(1, 1, 1)),
        ("shared_atomic_op_multiple_invocations", IVec3::new(1, 1, 1), IVec3::new(2, 5, 4)),
        ("shared_atomic_op_multiple_groups", IVec3::new(3, 4, 1), IVec3::new(2, 7, 3)),
    ] {
        group.add_child(Box::new(SharedVarAtomicOpCase {
            name: name.to_string(),
            local_size,
            work_size,
        }) as Box<dyn TestCase>);
    }

    for (name, local_size, image_size) in [
        ("copy_image_to_ssbo_small", IVec2::new(1, 1), IVec2::new(64, 64)),
        ("copy_image_to_ssbo_large", IVec2::new(2, 4), IVec2::new(512, 512)),
    ] {
        group.add_child(Box::new(CopyImageToSSBOCase {
            name: name.to_string(),
            local_size,
            image_size,
        }) as Box<dyn TestCase>);
    }

    for (name, local_size, work_size) in [
        ("atomic_counter_single_invocation", IVec3::new(1, 1, 1), IVec3::new(1, 1, 1)),
        ("atomic_counter_single_group", IVec3::new(3, 2, 5), IVec3::new(1, 1, 1)),
        ("atomic_counter_multiple_invocations", IVec3::new(1, 1, 1), IVec3::new(2, 5, 4)),
        ("atomic_counter_multiple_groups", IVec3::new(3, 4, 1), IVec3::new(2, 7, 3)),
    ] {
        group.add_child(Box::new(AtomicCounterCase {
            name: name.to_string(),
            local_size,
            work_size,
        }) as Box<dyn TestCase>);
    }

    group
}
