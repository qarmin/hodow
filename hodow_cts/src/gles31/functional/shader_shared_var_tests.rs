// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fShaderSharedVarTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::glu::{self, Buffer, Context, DataType, Precision, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};

/// `TYPE_FLOAT ..= TYPE_BOOL_VEC4`, which is the leading run of `ALL_DATA_TYPES` and is
/// the range `ShaderSharedVarTests::init` walks.
const BASIC_TYPES: &[DataType] = glu::shader_util::ALL_DATA_TYPES.split_at(25).0;

/// `MAX_VALUE_ARRAY_LENGTH` - `* 2 * sizeof(mat4) + sizeof(int)` = 481 uniform components
/// (the limit is 512).
const MAX_VALUE_ARRAY_LENGTH: i32 = 15;

fn product(v: [u32; 3]) -> u32 {
    v[0] * v[1] * v[2]
}

/// `SharedBasicVarCase`. `precision` is `None` where upstream passes `PRECISION_LAST`,
/// which is its way of saying "this type takes no precision qualifier".
struct SharedBasicVarCase {
    name: String,
    basic_type: DataType,
    precision: Option<Precision>,
    work_group_size: [u32; 3],
}

impl SharedBasicVarCase {
    /// `SharedBasicVarCase::init`'s shader source.
    fn gen_compute_source(&self) -> String {
        let val_array_length = MAX_VALUE_ARRAY_LENGTH.min(product(self.work_group_size) as i32);
        let prec_name = self.precision.map_or("", Precision::name);
        let type_name = self.basic_type.name();

        format!(
            "#version 310 es\n\
             layout (local_size_x = {}, local_size_y = {}, local_size_z = {}) in;\n\
             const uint LOCAL_SIZE = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_WorkGroupSize.z;\n\
             shared {prec_name} {type_name} s_var;\n\
             uniform {prec_name} {type_name} u_val[{val_array_length}];\n\
             uniform {prec_name} {type_name} u_ref[{val_array_length}];\n\
             uniform uint u_numIters;\n\
             layout(binding = 0) buffer Result\n\
             {{\n    \
             bool isOk[LOCAL_SIZE];\n\
             }};\n\
             \n\
             void main (void)\n\
             {{\n    \
             bool allOk = true;\n    \
             for (uint ndx = 0u; ndx < u_numIters; ndx++)\n    \
             {{\n        \
             if (ndx == gl_LocalInvocationIndex)\n            \
             s_var = u_val[ndx%uint(u_val.length())];\n\
             \n        \
             barrier();\n\
             \n        \
             if (s_var != u_ref[ndx%uint(u_ref.length())])\n            \
             allOk = false;\n\
             \n        \
             barrier();\n    \
             }}\n\
             \n    \
             isOk[gl_LocalInvocationIndex] = allOk;\n\
             }}\n",
            self.work_group_size[0], self.work_group_size[1], self.work_group_size[2],
        )
    }

    /// `SharedBasicVarCase::iterate`'s "Setup input values" block. `u_val` and `u_ref`
    /// get the same contents, which is what makes the shader's comparison a tautology
    /// on a working driver and a race detector on a broken one.
    fn set_input_uniforms(&self, gl: &glw::Functions, program: GLuint) {
        let num_values = product(self.work_group_size) as i32;
        let scalar_size = self.basic_type.scalar_size();

        // SAFETY: every upload below passes `num_values` elements of exactly the size
        // the entry point names, out of a vector of `num_values * scalar_size` scalars.
        unsafe {
            let val_loc = gl.get_uniform_location(program, c"u_val[0]".as_ptr());
            let ref_loc = gl.get_uniform_location(program, c"u_ref[0]".as_ptr());
            let iter_count_loc = gl.get_uniform_location(program, c"u_numIters".as_ptr());

            let locations = [val_loc, ref_loc];

            if self.basic_type.is_float_or_vec() || self.basic_type.is_matrix() {
                let max_int = if self.precision == Some(Precision::LowP) {
                    2
                } else {
                    1024
                };
                let min_int = -(num_values / 2).min(max_int);
                let values: Vec<f32> = (0..num_values * scalar_size)
                    .map(|ndx| (min_int + (ndx % (max_int - min_int + 1))) as f32)
                    .collect();

                for location in locations {
                    if self.basic_type.is_matrix() {
                        self.uniform_matrix(gl, location, num_values, &values);
                    } else {
                        match scalar_size {
                            1 => gl.uniform_1fv(location, num_values, values.as_ptr()),
                            2 => gl.uniform_2fv(location, num_values, values.as_ptr()),
                            3 => gl.uniform_3fv(location, num_values, values.as_ptr()),
                            _ => gl.uniform_4fv(location, num_values, values.as_ptr()),
                        }
                    }
                }
            } else if self.basic_type.is_int_or_ivec() {
                let max_int = if self.precision == Some(Precision::LowP) {
                    64
                } else {
                    1024
                };
                let min_int = -(num_values / 2).min(max_int);
                let values: Vec<i32> = (0..num_values * scalar_size)
                    .map(|ndx| min_int + (ndx % (max_int - min_int + 1)))
                    .collect();

                for location in locations {
                    Self::uniform_iv(gl, location, num_values, scalar_size, &values);
                }
            } else if self.basic_type.is_uint_or_uvec() {
                let max_int: u32 = if self.precision == Some(Precision::LowP) {
                    128
                } else {
                    1024
                };
                let values: Vec<u32> = (0..num_values * scalar_size)
                    .map(|ndx| ndx as u32 % (max_int + 1))
                    .collect();

                for location in locations {
                    match scalar_size {
                        1 => gl.uniform_1uiv(location, num_values, values.as_ptr()),
                        2 => gl.uniform_2uiv(location, num_values, values.as_ptr()),
                        3 => gl.uniform_3uiv(location, num_values, values.as_ptr()),
                        _ => gl.uniform_4uiv(location, num_values, values.as_ptr()),
                    }
                }
            } else {
                // Bools go through the integer entry points.
                let mut rnd = Random::new(0x324f);
                let values: Vec<i32> = (0..num_values * scalar_size)
                    .map(|_| i32::from(rnd.get_bool()))
                    .collect();

                for location in locations {
                    Self::uniform_iv(gl, location, num_values, scalar_size, &values);
                }
            }

            gl.uniform_1ui(iter_count_loc, product(self.work_group_size));
        }
    }

    /// # Safety
    /// `values` must hold `num_values * scalar_size` elements.
    unsafe fn uniform_iv(gl: &glw::Functions, location: GLint, num_values: i32, scalar_size: i32, values: &[i32]) {
        // SAFETY: the caller's contract.
        unsafe {
            match scalar_size {
                1 => gl.uniform_1iv(location, num_values, values.as_ptr()),
                2 => gl.uniform_2iv(location, num_values, values.as_ptr()),
                3 => gl.uniform_3iv(location, num_values, values.as_ptr()),
                _ => gl.uniform_4iv(location, num_values, values.as_ptr()),
            }
        }
    }

    /// # Safety
    /// `values` must hold `num_values * scalar_size` floats.
    unsafe fn uniform_matrix(&self, gl: &glw::Functions, location: GLint, num_values: i32, values: &[f32]) {
        use DataType::*;
        let ptr = values.as_ptr();
        // SAFETY: the caller's contract, and the entry point matches `basic_type`.
        unsafe {
            match self.basic_type {
                FloatMat2 => gl.uniform_matrix_2fv(location, num_values, glw::FALSE, ptr),
                FloatMat2x3 => gl.uniform_matrix_2x_3fv(location, num_values, glw::FALSE, ptr),
                FloatMat2x4 => gl.uniform_matrix_2x_4fv(location, num_values, glw::FALSE, ptr),
                FloatMat3x2 => gl.uniform_matrix_3x_2fv(location, num_values, glw::FALSE, ptr),
                FloatMat3 => gl.uniform_matrix_3fv(location, num_values, glw::FALSE, ptr),
                FloatMat3x4 => gl.uniform_matrix_3x_4fv(location, num_values, glw::FALSE, ptr),
                FloatMat4x2 => gl.uniform_matrix_4x_2fv(location, num_values, glw::FALSE, ptr),
                FloatMat4x3 => gl.uniform_matrix_4x_3fv(location, num_values, glw::FALSE, ptr),
                _ => gl.uniform_matrix_4fv(location, num_values, glw::FALSE, ptr),
            }
        }
    }
}

impl TestCase for SharedBasicVarCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let program = ShaderProgram::new(gl, &ProgramSources::compute(self.gen_compute_source()));
        if !program.is_ok() {
            return Err(TestError::Fail("Compile failed".to_string()));
        }
        let program_id = program.program();

        // SAFETY: the program linked, and `Result` is declared in it.
        let out_block_ndx =
            unsafe { gl.get_program_resource_index(program_id, glw::GL_SHADER_STORAGE_BLOCK, c"Result".as_ptr()) };
        let out_block_info =
            glu::get_program_interface_block_info(gl, program_id, glw::GL_SHADER_STORAGE_BLOCK, out_block_ndx)?;
        let data_size = out_block_info.data_size as usize;

        // SAFETY: the program links; every uniform the setter names is declared in it.
        unsafe { gl.use_program(program_id) };
        self.set_input_uniforms(gl, program_id);
        glu::expect_no_error(gl, "Input value setup failed")?;

        // Setup output buffer.
        let output_buffer = Buffer::new(gl);
        let empty_data = vec![0u8; data_size];
        // SAFETY: the upload covers exactly the block's size.
        unsafe {
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, output_buffer.get());
            gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                data_size as isize,
                empty_data.as_ptr().cast(),
                glw::GL_STATIC_READ,
            );
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, output_buffer.get());
            glu::expect_no_error(gl, "Output buffer setup failed")?;

            gl.dispatch_compute(1, 1, 1);
        }

        // Read back and compare.
        let num_values = product(self.work_group_size) as usize;
        let out_var_info = glu::get_program_interface_variable_info(
            gl,
            program_id,
            glw::GL_BUFFER_VARIABLE,
            out_block_info.active_variables[0] as GLuint,
        )?;

        // SAFETY: the mapping covers the whole block and is copied out before the unmap.
        let result = unsafe {
            let res_ptr = gl.map_buffer_range(
                glw::GL_SHADER_STORAGE_BUFFER,
                0,
                data_size as isize,
                glw::GL_MAP_READ_BIT,
            );
            glu::expect_no_error(gl, "glMapBufferRange()")?;
            if res_ptr.is_null() {
                return Err(TestError::Fail("glMapBufferRange returned null".to_string()));
            }
            let result = std::slice::from_raw_parts(res_ptr.cast::<u8>(), data_size).to_vec();
            gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER);
            glu::expect_no_error(gl, "glUnmapBuffer()")?;
            result
        };

        const MAX_ERR_MSG: usize = 10;
        let mut num_failed = 0;

        for ndx in 0..num_values {
            let at = out_var_info.offset as usize + out_var_info.array_stride as usize * ndx;
            let res_val = i32::from_ne_bytes(result[at..at + 4].try_into().expect("four bytes inside the block"));

            if res_val == 0 {
                if num_failed < MAX_ERR_MSG {
                    log::warn!("ERROR: isOk[{ndx}] = {res_val} != true");
                } else if num_failed == MAX_ERR_MSG {
                    log::warn!("...");
                }
                num_failed += 1;
            }
        }

        log::info!("{} / {num_values} values passed", num_values - num_failed);

        Ok(if num_failed == 0 {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Comparison failed")
        })
    }
}

fn case(
    name: String,
    basic_type: DataType,
    precision: Option<Precision>,
    work_group_size: [u32; 3],
) -> Box<dyn TestCase> {
    Box::new(SharedBasicVarCase {
        name,
        basic_type,
        precision,
        work_group_size,
    })
}

/// `ShaderSharedVarTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shared_var");

    // .basic_type - `TYPE_FLOAT` through `TYPE_BOOL_VEC4`, which is the leading run of
    // `ALL_DATA_TYPES`. Upstream also skips doubles and non-matrix types wider than a
    // vec4; neither exists in that run, so neither filter is ported.
    let mut basic_type_group = TestCaseGroup::new("basic_type");
    for &basic_type in BASIC_TYPES {
        if basic_type.is_bool_or_bvec() {
            basic_type_group.add_child(case(basic_type.name().to_string(), basic_type, None, [2, 1, 3]));
        } else {
            for precision in [Precision::LowP, Precision::MediumP, Precision::HighP] {
                let name = format!("{}_{}", basic_type.name(), precision.name());
                basic_type_group.add_child(case(name, basic_type, Some(precision), [2, 1, 3]));
            }
        }
    }
    group.add_child(basic_type_group);

    // .work_group_size
    const WORK_GROUP_SIZES: [([u32; 3], &str); 7] = [
        ([1, 1, 1], "1_1_1"),
        ([64, 1, 1], "64_1_1"),
        ([1, 64, 1], "1_64_1"),
        ([1, 1, 64], "1_1_64"),
        ([128, 1, 1], "128_1_1"),
        ([1, 128, 1], "1_128_1"),
        ([13, 2, 4], "13_2_4"),
    ];

    let mut work_group_size_group = TestCaseGroup::new("work_group_size");
    for ty in [DataType::Float, DataType::FloatVec4, DataType::FloatMat4] {
        for (size, size_name) in WORK_GROUP_SIZES {
            let name = format!("{}_{size_name}", ty.name());
            work_group_size_group.add_child(case(name, ty, Some(Precision::HighP), size));
        }
    }
    group.add_child(work_group_size_group);

    // .atomic
    group.add_child(super::shader_atomic_op_tests::create_tests(
        "atomic",
        super::shader_atomic_op_tests::AtomicOperandType::SharedVariable,
    ));

    group
}
