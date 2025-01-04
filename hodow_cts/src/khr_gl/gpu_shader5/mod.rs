// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/gpu_shader5/esextcGPUShader5Tests.cpp
//   external/openglcts/modules/glesext/gpu_shader5/esextcGPUShader5AtomicCountersArrayIndexing.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// All 22 cases of the group are registered; atomic_counters_array_indexing is the first group built on `esext::TestCaseBase`, which is what it is here to exercise. The other cases (written without compiling) are one file per upstream file next to this one and keep their GL object names in `common::Objects`.

/// A GL call with a current context and with pointers into live locals or buffers of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals or buffers of the right size.
        unsafe { $call }
    };
}

mod common;
mod fma_accuracy;
mod fma_precision;
mod images_array_indexing;
mod precise_qualifier;
mod sampler_array_indexing;
mod ssbo_array_indexing;
mod texture_gather_offset;
mod uniform_blocks_array_indexing;

use super::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::glu::{self, Context, GlslVersion, TestCase, TestCaseGroup};
use crate::glw::{self, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const GPU_SHADER5_EXTENSION_NOT_SUPPORTED: &str = "GPU shader5 functionality not supported, skipping";

const ATOMIC_COUNTERS_ARRAY_SIZE: usize = 4;

const COMPUTE_SHADER_CODE: &str = concat!(
    "${VERSION}\n",
    "\n",
    "${GPU_SHADER5_REQUIRE}\n",
    "\n",
    "layout (local_size_x = 2, local_size_y = 2) in;\n",
    "layout (binding      = 0, offset       = 0) uniform atomic_uint counters[4];\n",
    "\n",
    "void main(void)\n",
    "{\n",
    "    for (uint index = 0u; index <= 3u; ++index)\n",
    "    {\n",
    "        for (uint iteration = 0u; iteration <= gl_LocalInvocationID.x * 2u + gl_LocalInvocationID.y; ++iteration)\n",
    "        {\n",
    "            atomicCounterIncrement( counters[index] );\n",
    "        }\n",
    "    }\n",
    "}\n",
);

/// `GPUShader5AtomicCountersArrayIndexing`
struct AtomicCountersArrayIndexing {
    ext_params: ExtParameters,
    name: &'static str,
}

/// The GL objects `initTest` creates and `deinit` releases.
struct Objects {
    buffer_id: GLuint,
    compute_shader_id: GLuint,
    program_id: GLuint,
}

impl AtomicCountersArrayIndexing {
    /// `GPUShader5AtomicCountersArrayIndexing::initTest`
    fn init_test(&self, context: &Context, base: &TestCaseBase, objects: &mut Objects) -> Result<(), TestError> {
        let gl = context.gl();

        // Check if gpu_shader5 extension is supported.
        if !base.is_gpu_shader5_supported {
            return Err(TestError::NotSupported(GPU_SHADER5_EXTENSION_NOT_SUPPORTED.to_string()));
        }

        // Create program object from the supplied compute shader code.
        // SAFETY: object creation on the current context.
        unsafe { objects.program_id = gl.create_program() };
        glu::expect_no_error(gl, "Creating program object failed")?;

        // SAFETY: as above.
        unsafe { objects.compute_shader_id = gl.create_shader(glw::GL_COMPUTE_SHADER) };
        glu::expect_no_error(gl, "Creating compute shader object failed")?;

        let parts = [COMPUTE_SHADER_CODE];
        if !base
            .build_program(
                context,
                objects.program_id,
                &[ShaderBody::Source(objects.compute_shader_id, &parts)],
            )?
            .0
        {
            return Err(TestError::Fail("Could not create program object!".to_string()));
        }

        let buffer_data: [GLuint; ATOMIC_COUNTERS_ARRAY_SIZE] = std::array::from_fn(|index| index as GLuint);

        // SAFETY: a buffer name out, then calls on the buffer just bound; the data covers the size passed.
        unsafe {
            gl.gen_buffers(1, &mut objects.buffer_id);
            gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, objects.buffer_id);
            gl.buffer_data(
                glw::GL_ATOMIC_COUNTER_BUFFER,
                std::mem::size_of_val(&buffer_data) as isize,
                buffer_data.as_ptr().cast(),
                glw::GL_DYNAMIC_COPY,
            );
            gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, objects.buffer_id);
        }
        glu::expect_no_error(gl, "Could not setup buffer object!")?;

        Ok(())
    }

    /// `GPUShader5AtomicCountersArrayIndexing::deinit`
    fn deinit(context: &Context, objects: &mut Objects) {
        let gl = context.gl();

        // SAFETY: state resets and deletes of names this case created.
        unsafe {
            // Reset OpenGL ES state.
            gl.use_program(0);
            gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, 0);

            if objects.program_id != 0 {
                gl.delete_program(objects.program_id);
                objects.program_id = 0;
            }
            if objects.compute_shader_id != 0 {
                gl.delete_shader(objects.compute_shader_id);
                objects.compute_shader_id = 0;
            }
            if objects.buffer_id != 0 {
                gl.delete_buffers(1, &objects.buffer_id);
                objects.buffer_id = 0;
            }
        }
    }

    fn run(&self, context: &Context, base: &TestCaseBase, objects: &mut Objects) -> TestOutcome {
        self.init_test(context, base, objects)?;

        let gl = context.gl();

        // Do the computations.
        // SAFETY: a program this case built.
        unsafe { gl.use_program(objects.program_id) };
        glu::expect_no_error(gl, "Could not use program object!")?;

        // SAFETY: a compute dispatch of the program in use.
        unsafe { gl.dispatch_compute(10, 10, 1) };
        glu::expect_no_error(gl, "Failed to dispatch compute operation!")?;

        // Map the buffer object storage into user space.
        // SAFETY: a range inside the buffer bound to the target.
        let mapped = unsafe {
            gl.map_buffer_range(
                glw::GL_ATOMIC_COUNTER_BUFFER,
                0,
                (ATOMIC_COUNTERS_ARRAY_SIZE * std::mem::size_of::<GLuint>()) as isize,
                glw::GL_MAP_READ_BIT,
            )
        };
        glu::expect_no_error(gl, "Failed to map buffer range to client space!")?;
        if mapped.is_null() {
            return Err(TestError::Fail(
                "Failed to map buffer range to client space!".to_string(),
            ));
        }
        // SAFETY: the mapping holds ATOMIC_COUNTERS_ARRAY_SIZE GLuints until it is unmapped below; they are copied out first.
        let buffer_data: [GLuint; ATOMIC_COUNTERS_ARRAY_SIZE] =
            unsafe { std::slice::from_raw_parts(mapped.cast::<GLuint>(), ATOMIC_COUNTERS_ARRAY_SIZE) }
                .try_into()
                .expect("four counters");

        // Compare the result values with reference value.
        const EXPECTED_RESULT: GLuint = 1000;

        let passed = buffer_data[0] == EXPECTED_RESULT
            && buffer_data[1] == EXPECTED_RESULT + 1
            && buffer_data[2] == EXPECTED_RESULT + 2
            && buffer_data[3] == EXPECTED_RESULT + 3;
        if !passed {
            log::info!(
                "Invalid data rendered. Expected Data ({EXPECTED_RESULT}, {EXPECTED_RESULT}, {EXPECTED_RESULT}, {EXPECTED_RESULT}) Result Data ({} ,{} ,{} ,{})",
                buffer_data[0],
                buffer_data[1],
                buffer_data[2],
                buffer_data[3]
            );
        }

        // SAFETY: the buffer mapped above.
        unsafe { gl.unmap_buffer(glw::GL_ATOMIC_COUNTER_BUFFER) };
        glu::expect_no_error(gl, "Failed to unmap buffer!")?;

        if passed {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Fail"))
        }
    }
}

impl TestCase for AtomicCountersArrayIndexing {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        let mut objects = Objects {
            buffer_id: 0,
            compute_shader_id: 0,
            program_id: 0,
        };

        // `deinit` runs however the case ended, as the runner calls it after `iterate` upstream.
        let outcome = self.run(context, &base, &mut objects);
        Self::deinit(context, &mut objects);
        outcome
    }
}

/// `GPUShader5Tests::init` - the cases ported so far, in upstream's order.
pub fn create_tests(ext_params: ExtParameters) -> TestCaseGroup {
    use texture_gather_offset::{Case, TextureGatherOffset};

    let mut group = TestCaseGroup::new("gpu_shader5");

    // Sampler Array Indexing (Test 1), Images Array Indexing (Test 2)
    group.add_child(Box::new(sampler_array_indexing::SamplerArrayIndexing { ext_params }) as Box<dyn TestCase>);
    group.add_child(Box::new(images_array_indexing::ImagesArrayIndexing { ext_params }) as Box<dyn TestCase>);

    // Atomic Counters Array Indexing (Test 3)
    group.add_child(Box::new(AtomicCountersArrayIndexing {
        ext_params,
        name: "atomic_counters_array_indexing",
    }) as Box<dyn TestCase>);

    // Uniform Blocks Array Indexing (Test 4)
    group.add_child(
        Box::new(uniform_blocks_array_indexing::UniformBlocksArrayIndexing { ext_params }) as Box<dyn TestCase>,
    );

    // SSBO Array Indexing (Test 5), applicable only to OpenGL 4.x
    if ext_params.glsl_version >= GlslVersion::Glsl430 {
        group.add_child(Box::new(ssbo_array_indexing::SsboArrayIndexing { ext_params }) as Box<dyn TestCase>);
    }

    // GPUShader5 Precise Qualifier (Test 6), accuracy of the fma function (Test 7)
    group.add_child(Box::new(precise_qualifier::PreciseQualifier { ext_params }) as Box<dyn TestCase>);
    group.add_child(Box::new(fma_accuracy::FmaAccuracy { ext_params }) as Box<dyn TestCase>);

    // fma precision (Test 8)
    for (name, n_components) in [
        ("fma_precision_float", 1),
        ("fma_precision_vec2", 2),
        ("fma_precision_vec3", 3),
        ("fma_precision_vec4", 4),
    ] {
        group.add_child(Box::new(fma_precision::FmaPrecision {
            ext_params,
            name,
            n_components,
        }) as Box<dyn TestCase>);
    }

    // Texture gather offset (Tests 9, 10 and 11)
    for (name, case) in [
        ("texture_gather_offset_color_repeat", Case::Color2DRepeat),
        ("texture_gather_offset_color_array", Case::Color2DArray),
        ("texture_gather_offsets_color", Case::Color2DOffsets),
        ("texture_gather_offset_depth_repeat", Case::Depth2DRepeat),
        ("texture_gather_offset_depth_repeat_y", Case::Depth2DRepeatY),
        ("texture_gather_offset_depth_array", Case::Depth2DArray),
        ("texture_gather_offsets_depth", Case::Depth2DOffsets),
        (
            "texture_gather_offset_color_clamp_to_border",
            Case::Color2DClampToBorder,
        ),
        ("texture_gather_offset_color_clamp_to_edge", Case::Color2DClampToEdge),
        ("texture_gather_offset_depth_clamp_border", Case::Depth2DClampToBorder),
        ("texture_gather_offset_depth_clamp_edge", Case::Depth2DClampToEdge),
    ] {
        group.add_child(Box::new(TextureGatherOffset { ext_params, name, case }) as Box<dyn TestCase>);
    }

    group
}
