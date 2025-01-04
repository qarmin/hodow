// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/gpu_shader5/esextcGPUShader5FmaPrecision.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Written without compiling; the GL object bookkeeping is `common::Objects`. The CPU reference for the round-toward-zero pass is emulated in software (upstream sets the FPU rounding mode with deSetRoundingMode): the product is exact in f64 and each result is truncated toward zero to f32. `RAND_MAX` is glibc's.

use std::ffi::CString;

use super::common::{Objects, require_gpu_shader5, run_case};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, RandomFormula, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `GPUShader5FmaPrecision<S>`; `n_components` is the `INPUT_DATA_TYPE` (1 to 4).
pub(super) struct FmaPrecision {
    pub ext_params: ExtParameters,
    pub name: &'static str,
    pub n_components: usize,
}

const N_ELEMENTS: usize = 100;
const AMPLITUDE: f32 = 100.0;
const RAND_MAX: GLuint = 2147483647;

const FRAGMENT_SHADER_CODE: &str =
    "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\n\nvoid main(void)\n{\n}\n";

/// `deFloatSign`
fn float_sign(value: f32) -> f32 {
    if value == 0.0 {
        0.0
    } else if value > 0.0 {
        1.0
    } else {
        -1.0
    }
}

/// An exactly representable value rounded to a 32-bit float toward zero.
fn round_to_zero(value: f64) -> f32 {
    let nearest = value as f32;

    if (nearest as f64).abs() > value.abs() {
        f32::from_bits(nearest.to_bits() - 1)
    } else {
        nearest
    }
}

impl FmaPrecision {
    /// `generateVertexShaderCode`
    fn vertex_shader_code(&self) -> Result<String, TestError> {
        let type_name = match self.n_components {
            1 => "float",
            2 => "vec2",
            3 => "vec3",
            4 => "vec4",
            _ => return Err(TestError::Fail("Incorrect variable type!".to_string())),
        };

        Ok(format!(
            "${{VERSION}}\n\n${{GPU_SHADER5_REQUIRE}}\n\nprecision highp float;\n\nlayout(location = 0) in {type_name} a;\nlayout(location = 1) in {type_name} b;\nlayout(location = 2) in {type_name} c;\n\nlayout(location = 0) out {type_name} resultFma;\nlayout(location = 1) precise out {type_name} resultStd;\n\n\nvoid main()\n{{\n    resultFma = fma(a,b,c);\n    resultStd = a * b + c;\n}}\n"
        ))
    }

    /// `generateData`: three arrays of `N_ELEMENTS * n_components` values.
    fn generate_data(&self) -> (Vec<f32>, Vec<f32>, Vec<f32>) {
        let size = N_ELEMENTS * self.n_components;
        let mut data_a = vec![0.0f32; size];
        let mut data_b = vec![0.0f32; size];
        let mut data_c = vec![0.0f32; size];

        // Initialize with 1, because the same sequence of random values is wanted on every run
        let mut random = RandomFormula::default();
        random.random_seed(1);

        let next_value = |random: &mut RandomFormula| {
            random.random_formula(RAND_MAX) as f32 / (RAND_MAX as f32 / (AMPLITUDE * 2.0)) - AMPLITUDE
        };

        for i in 0..N_ELEMENTS {
            for j in 0..self.n_components {
                let mut a = next_value(&mut random);
                let b = next_value(&mut random);
                let mut c = next_value(&mut random);

                // If values are of opposite sign, catastrophic cancellation is possible. Scale down one of the terms so that either |a*b| < 0.5*|c| or |c| < 0.5 * |a*b|, so that the result is no smaller than half of the larger of a*b or c.
                let axb = a * b;
                if float_sign(axb) != float_sign(c) {
                    if axb.abs() >= c.abs() && axb.abs() <= 2.0 * c.abs() {
                        c /= 2.0;
                    } else if c.abs() >= axb.abs() && c.abs() <= 2.0 * axb.abs() {
                        a /= 2.0;
                    }
                }

                data_a[i * self.n_components + j] = a;
                data_b[i * self.n_components + j] = b;
                data_c[i * self.n_components + j] = c;
            }
        }

        (data_a, data_b, data_c)
    }

    /// Reads back the buffer bound to the transform feedback target.
    fn read_results(&self, context: &Context, buffer_id: GLuint) -> Result<Vec<f32>, TestError> {
        let gl = context.gl();
        let size = N_ELEMENTS * self.n_components;

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, buffer_id));
        glu::expect_no_error(gl, "glBindBuffer() call failed")?;

        let mapped = gl!(gl.map_buffer_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            (size * std::mem::size_of::<f32>()) as isize,
            glw::GL_MAP_READ_BIT
        ));
        glu::expect_no_error(gl, "Error mapping buffer object's data to client space!")?;
        if mapped.is_null() {
            return Err(TestError::Fail(
                "Error mapping buffer object's data to client space!".to_string(),
            ));
        }
        // SAFETY: `size` floats were mapped for reading; they are copied out before the unmap below.
        let result = unsafe { std::slice::from_raw_parts(mapped.cast::<f32>(), size) }.to_vec();

        gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
        glu::expect_no_error(gl, "Error unmapping buffer object's data!")?;

        Ok(result)
    }

    fn run(&self, context: &Context, base: &TestCaseBase, objects: &mut Objects) -> TestOutcome {
        let gl = context.gl();
        let size = N_ELEMENTS * self.n_components;

        // initTest
        require_gpu_shader5(base)?;

        let (data_a, data_b, data_c) = self.generate_data();

        let fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        let vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        objects.shaders.extend([fs_id, vs_id]);
        glu::expect_no_error(gl, "Could not create shader objects!")?;

        let po_id = gl!(gl.create_program());
        objects.programs.push(po_id);
        glu::expect_no_error(gl, "Could not create program object!")?;

        // Set up transform feedback
        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glEnable(GL_RASTERIZER_DISCARD) call failed")?;

        let varyings = [
            CString::new("resultFma").expect("no nul byte"),
            CString::new("resultStd").expect("no nul byte"),
        ];
        let varying_pointers = [varyings[0].as_ptr(), varyings[1].as_ptr()];

        gl!(gl.transform_feedback_varyings(po_id, 2, varying_pointers.as_ptr(), glw::GL_SEPARATE_ATTRIBS));
        glu::expect_no_error(gl, "glTransformFeedbackVaryings() failed")?;

        let vs_code = self.vertex_shader_code()?;

        let (built, _) = base.build_program(
            context,
            po_id,
            &[
                ShaderBody::Source(fs_id, &[FRAGMENT_SHADER_CODE]),
                ShaderBody::Source(vs_id, &[vs_code.as_str()]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Could not create a program from valid vertex/fragment shader!".to_string(),
            ));
        }

        // Create and bind vertex array object
        let mut vao_id: GLuint = 0;
        gl!(gl.gen_vertex_arrays(1, &mut vao_id));
        objects.vertex_arrays.push(vao_id);
        gl!(gl.bind_vertex_array(vao_id));
        glu::expect_no_error(gl, "Error configuring vertex array object!")?;

        // Configure buffer objects with input data
        let mut input_buffer_ids = [0 as GLuint; 3];
        for (buffer_id, data) in input_buffer_ids.iter_mut().zip([&data_a, &data_b, &data_c]) {
            gl!(gl.gen_buffers(1, buffer_id));
            objects.buffers.push(*buffer_id);
            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, *buffer_id));
            gl!(gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                (size * std::mem::size_of::<f32>()) as isize,
                data.as_ptr().cast(),
                glw::GL_STATIC_READ
            ));
            glu::expect_no_error(gl, "Error configuring buffer object!")?;
        }

        gl!(gl.use_program(po_id));
        glu::expect_no_error(gl, "Could not use program!")?;

        // Configure vertex attrib pointers
        for (name, buffer_id) in ["a", "b", "c"].into_iter().zip(input_buffer_ids) {
            let attribute_name = CString::new(name).expect("no nul byte");
            let attribute_location = gl!(gl.get_attrib_location(po_id, attribute_name.as_ptr()));
            glu::expect_no_error(gl, "glGetAttribLocation() failed")?;

            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer_id));
            gl!(gl.vertex_attrib_pointer(
                attribute_location as GLuint,
                self.n_components as GLint,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                std::ptr::null()
            ));
            gl!(gl.enable_vertex_attrib_array(attribute_location as GLuint));
            glu::expect_no_error(gl, "Error configuring input vertex data attrib pointer!")?;
        }

        // Configure buffer objects for captured results
        let mut vbo_result_fma_id: GLuint = 0;
        let mut vbo_result_std_id: GLuint = 0;
        for buffer_id in [&mut vbo_result_fma_id, &mut vbo_result_std_id] {
            gl!(gl.gen_buffers(1, buffer_id));
            objects.buffers.push(*buffer_id);
            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, *buffer_id));
            gl!(gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                (size * std::mem::size_of::<f32>()) as isize,
                std::ptr::null(),
                glw::GL_DYNAMIC_COPY
            ));
            glu::expect_no_error(gl, "Error configuring buffer object!")?;
        }

        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, vbo_result_fma_id));
        glu::expect_no_error(gl, "Error binding buffer object to transform feedback binding point!")?;

        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 1, vbo_result_std_id));
        glu::expect_no_error(gl, "Error binding buffer object to transform feedback binding point!")?;

        // iterate: render
        gl!(gl.begin_transform_feedback(glw::GL_POINTS));
        glu::expect_no_error(gl, "glBeginTransformFeedback() call failed")?;

        gl!(gl.draw_arrays(glw::GL_POINTS, 0, N_ELEMENTS as GLint));
        glu::expect_no_error(gl, "Rendering failed!")?;

        gl!(gl.end_transform_feedback());
        glu::expect_no_error(gl, "glEndTransformFeedback() call failed")?;

        // Retrieve the result data
        let result_fma = self.read_results(context, vbo_result_fma_id)?;
        let result_std = self.read_results(context, vbo_result_std_id)?;

        // Execute the algorithm from the shader on the CPU, with round-to-nearest-even and with round-to-zero
        let mut result_cpu_rne = vec![0.0f32; size];
        let mut result_cpu_rtz = vec![0.0f32; size];

        for index in 0..size {
            result_cpu_rne[index] = data_a[index] * data_b[index] + data_c[index];

            let product = round_to_zero(data_a[index] as f64 * data_b[index] as f64);
            result_cpu_rtz[index] = round_to_zero(product as f64 + data_c[index] as f64);
        }

        // Check results
        let results_cpu = [&result_cpu_rne, &result_cpu_rtz];
        let mut test_failed = true;

        for results in results_cpu {
            if !test_failed {
                break;
            }

            let mut rounding_mode_failed = false;

            for i in 0..N_ELEMENTS {
                for j in 0..self.n_components {
                    // Convert float to int bitwise
                    let cpu_temp = results[i * self.n_components + j].to_bits() as i32;
                    let fma_temp = result_fma[i * self.n_components + j].to_bits() as i32;
                    let std_temp = result_std[i * self.n_components + j].to_bits() as i32;

                    let diff_cpu_fma = (cpu_temp.wrapping_sub(fma_temp)).unsigned_abs() > 2;
                    let diff_cpu_std = (cpu_temp.wrapping_sub(std_temp)).unsigned_abs() > 2;
                    let diff_fma_std = (fma_temp.wrapping_sub(std_temp)).unsigned_abs() > 2;

                    if diff_cpu_fma || diff_cpu_std || diff_fma_std {
                        rounding_mode_failed = true;
                        break;
                    }
                }

                if rounding_mode_failed {
                    break;
                }

                test_failed = false;
            }
        }

        if test_failed {
            log::info!(
                "The values of resultStd[i] & 0xFFFFFFFE and resultFma[i] & 0xFFFFFFFE and resultCPU[i] & 0xFFFFFFFE are not bitwise equal for i = 0..99\n"
            );

            return Ok(TestStatus::fail("Fail"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for FmaPrecision {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        run_case(context, self.ext_params, |context, base, objects| {
            self.run(context, base, objects)
        })
    }
}
