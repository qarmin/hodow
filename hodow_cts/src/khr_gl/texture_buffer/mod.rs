// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_buffer/esextcTextureBufferTests.cpp
//   external/openglcts/modules/glesext/texture_buffer/esextcTextureBufferErrors.cpp
//   external/openglcts/modules/glesext/texture_buffer/esextcTextureBufferMAXSizeValidation.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Ported so far: texture_buffer_max_size (Test 2), texture_buffer_conv_int_to_float (Test 4, conv_int_to_float.rs), texture_buffer_atomic_functions (Test 5, atomic_functions.rs), texture_buffer_parameters (Test 6, parameters.rs), texture_buffer_errors (Test 7), the two texture_buffer_active_uniform_validation_* cases (Test 8, active_uniform_validation.rs), texture_buffer_buffer_parameters (Test 9, buffer_parameters.rs) and texture_buffer_precision (Test 10, precision.rs), texture_buffer_range (Test 3, range.rs) and the six texture_buffer_operations_* cases (Test 1, operations.rs); the group is complete, registered in upstream order. The ES-only multisample-array target of `errors` is never present on a desktop context and is left out.

use super::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLintptr, GLsizeiptr, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED: &str = "Texture buffer functionality not supported, skipping";

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $msg:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $msg)?;
    }};
}

mod active_uniform_validation;
mod atomic_functions;
mod buffer_parameters;
mod conv_int_to_float;
mod operations;
mod parameters;
mod precision;
mod range;

/// Number of components in computeSSBO.outValue vector
const N_VEC_COMPONENTS: usize = 3;

const MAX_SIZE_COMPUTE_SHADER_CODE: &str = concat!(
    "${VERSION}\n",
    "\n",
    "${TEXTURE_BUFFER_REQUIRE}\n",
    "\n",
    "precision highp float;\n",
    "\n",
    "uniform highp usamplerBuffer sampler_buffer;\n",
    "\n",
    "buffer ComputeSSBO\n",
    "{\n",
    "    uvec3 outValue;\n",
    "} computeSSBO;\n",
    "\n",
    "layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n",
    "\n",
    "void main(void)\n",
    "{\n",
    "    computeSSBO.outValue.x = uint( textureSize(sampler_buffer) );\n",
    "    computeSSBO.outValue.y = uint( texelFetch (sampler_buffer, 0).x );\n",
    "    computeSSBO.outValue.z = uint( texelFetch (sampler_buffer, int(computeSSBO.outValue.x) - 1 ).x );\n",
    "}\n",
);

/// `TextureBufferMAXSizeValidation`
struct MaxSizeValidation {
    ext_params: ExtParameters,
}

/// The members `initTest` fills and `deinit` releases.
#[derive(Default)]
struct MaxSizeObjects {
    cs_id: GLuint,
    max_tex_buffer_size: GLint,
    po_id: GLuint,
    ssbo_id: GLuint,
    tbo_id: GLuint,
    tbo_tex_id: GLuint,
}

impl MaxSizeValidation {
    /// `initTest`
    fn init_test(context: &Context, base: &TestCaseBase, objects: &mut MaxSizeObjects) -> Result<(), TestError> {
        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;

        if !base.is_texture_buffer_supported {
            return Err(TestError::NotSupported(
                TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        gl_call!(
            gl,
            "Error getting gl parameter value!",
            gl.get_integerv(tokens.max_texture_buffer_size, &mut objects.max_tex_buffer_size)
        );

        let size = objects.max_tex_buffer_size as GLsizeiptr;

        gl_call!(
            gl,
            "Error generating buffer object!",
            gl.gen_buffers(1, &mut objects.tbo_id)
        );
        gl_call!(
            gl,
            "Error binding buffer object!",
            gl.bind_buffer(tokens.texture_buffer, objects.tbo_id)
        );
        gl_call!(
            gl,
            "Error allocating buffer object's data store!",
            gl.buffer_data(tokens.texture_buffer, size, std::ptr::null(), glw::GL_DYNAMIC_DRAW)
        );

        // SAFETY: a write mapping of the whole store just allocated.
        let buf = unsafe { gl.map_buffer_range(tokens.texture_buffer, 0, size, glw::GL_MAP_WRITE_BIT) };
        glu::expect_no_error(
            gl,
            "Error mapping buffer object's data store to client's address space!",
        )?;
        if buf.is_null() {
            return Err(TestError::Fail(
                "Error mapping buffer object's data store to client's address space!".to_string(),
            ));
        }

        // SAFETY: the mapping is `size` bytes long until it is unmapped below.
        let mapped = unsafe { std::slice::from_raw_parts_mut(buf.cast::<u8>(), objects.max_tex_buffer_size as usize) };
        for (i, byte) in mapped.iter_mut().enumerate() {
            *byte = (i % 256) as u8;
        }

        gl_call!(
            gl,
            "Error ummapping buffer object's data store from client's address space!",
            gl.unmap_buffer(tokens.texture_buffer)
        );

        gl_call!(
            gl,
            "Error generating texture object!",
            gl.gen_textures(1, &mut objects.tbo_tex_id)
        );
        gl_call!(
            gl,
            "Error asetting active texture unit!",
            gl.active_texture(glw::GL_TEXTURE0)
        );
        gl_call!(
            gl,
            "Error binding texture object!",
            gl.bind_texture(tokens.texture_buffer, objects.tbo_tex_id)
        );

        gl_call!(
            gl,
            "Error binding buffer object as data store for texture buffer!",
            gl.tex_buffer(tokens.texture_buffer, glw::GL_R8UI, objects.tbo_id)
        );

        // SAFETY: object creation on the current context.
        unsafe { objects.po_id = gl.create_program() };
        glu::expect_no_error(gl, "Error creating program object!")?;

        // SAFETY: as above.
        unsafe { objects.cs_id = gl.create_shader(glw::GL_COMPUTE_SHADER) };
        glu::expect_no_error(gl, "Error creating shader object!")?;

        let parts = [MAX_SIZE_COMPUTE_SHADER_CODE];
        if !base
            .build_program(context, objects.po_id, &[ShaderBody::Source(objects.cs_id, &parts)])?
            .0
        {
            return Err(TestError::Fail(
                "Could not create program from valid compute shader object!".to_string(),
            ));
        }

        gl_call!(
            gl,
            "Error generating buffer object!",
            gl.gen_buffers(1, &mut objects.ssbo_id)
        );
        gl_call!(
            gl,
            "Error binding  buffer object!",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, objects.ssbo_id)
        );
        gl_call!(
            gl,
            "Error generating buffer object!",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                (N_VEC_COMPONENTS * size_of::<GLuint>()) as GLsizeiptr,
                std::ptr::null(),
                glw::GL_DYNAMIC_COPY
            )
        );
        Ok(())
    }

    /// `deinit`
    fn deinit(context: &Context, base: &TestCaseBase, objects: &mut MaxSizeObjects) {
        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;

        // SAFETY: state resets and deletes of names this case created.
        unsafe {
            gl.use_program(0);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            gl.bind_buffer(tokens.texture_buffer, 0);
            gl.bind_texture(tokens.texture_buffer, 0);
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, 0);

            if objects.cs_id != 0 {
                gl.delete_shader(objects.cs_id);
                objects.cs_id = 0;
            }
            if objects.po_id != 0 {
                gl.delete_program(objects.po_id);
                objects.po_id = 0;
            }
            if objects.ssbo_id != 0 {
                gl.delete_buffers(1, &objects.ssbo_id);
                objects.ssbo_id = 0;
            }
            if objects.tbo_id != 0 {
                gl.delete_buffers(1, &objects.tbo_id);
                objects.tbo_id = 0;
            }
            if objects.tbo_tex_id != 0 {
                gl.delete_textures(1, &objects.tbo_tex_id);
                objects.tbo_tex_id = 0;
            }
        }
    }

    fn run(context: &Context, base: &TestCaseBase, objects: &mut MaxSizeObjects) -> TestOutcome {
        Self::init_test(context, base, objects)?;

        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;
        let mut test_result = true;

        let mut texture_offset: GLint = -1;
        gl_call!(
            gl,
            "Error getting texture buffer offset parameter value!",
            gl.get_tex_level_parameteriv(
                tokens.texture_buffer,
                0,
                tokens.texture_buffer_offset,
                &mut texture_offset
            )
        );

        let expected_offset = 0;
        if expected_offset != texture_offset {
            log::info!(
                "Expected GL_TEXTURE_BUFFER_OFFSET_EXT parameter value : {expected_offset}\nResult   GL_TEXTURE_BUFFER_OFFSET_EXT parameter value : {texture_offset}\n"
            );
            test_result = false;
        }

        let mut texture_size: GLint = 0;
        gl_call!(
            gl,
            "Error getting texture buffer paramter value!",
            gl.get_tex_level_parameteriv(tokens.texture_buffer, 0, tokens.texture_buffer_size, &mut texture_size)
        );

        let expected_size = objects.max_tex_buffer_size;
        if expected_size != texture_size {
            log::info!(
                "Expected GL_TEXTURE_BUFFER_SIZE_EXT parameter value : {expected_size}\nResult   GL_TEXTURE_BUFFER_SIZE_EXT parameter value : {texture_size}\n"
            );
            test_result = false;
        }

        gl_call!(gl, "Error setting program!", gl.use_program(objects.po_id));
        gl_call!(
            gl,
            "Could not bind buffer object to shader storage binding point!",
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, objects.ssbo_id)
        );
        gl_call!(
            gl,
            "Error activating texture unit!",
            gl.active_texture(glw::GL_TEXTURE0)
        );
        gl_call!(
            gl,
            "Error binding texture object!",
            gl.bind_texture(tokens.texture_buffer, objects.tbo_tex_id)
        );

        // SAFETY: a NUL-terminated name on the program in use.
        let location = unsafe { gl.get_uniform_location(objects.po_id, c"sampler_buffer".as_ptr()) };
        glu::expect_no_error(gl, "Error getting uniform location!")?;

        gl_call!(
            gl,
            "Error setting value for uniform location!",
            gl.uniform_1i(location, 0)
        );
        gl_call!(gl, "Error running compute shader!", gl.dispatch_compute(1, 1, 1));
        gl_call!(
            gl,
            "Error setting memory barrier!",
            gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT)
        );

        // SAFETY: a read mapping of the three uints the shader wrote.
        let mapped = unsafe {
            gl.map_buffer_range(
                glw::GL_SHADER_STORAGE_BUFFER,
                0,
                (N_VEC_COMPONENTS * size_of::<GLuint>()) as GLsizeiptr,
                glw::GL_MAP_READ_BIT,
            )
        };
        glu::expect_no_error(gl, "Error mapping buffer object to client's address space!")?;
        if mapped.is_null() {
            return Err(TestError::Fail(
                "Error mapping buffer object to client's address space!".to_string(),
            ));
        }
        // SAFETY: the mapping holds N_VEC_COMPONENTS GLuints until it is unmapped below; they are copied out first.
        let result: [GLuint; N_VEC_COMPONENTS] =
            unsafe { std::slice::from_raw_parts(mapped.cast::<GLuint>(), N_VEC_COMPONENTS) }
                .try_into()
                .expect("three components");

        let expected_value = (objects.max_tex_buffer_size - 1) as GLuint % 256;
        if result[0] != objects.max_tex_buffer_size as GLuint || result[1] != 0 || result[2] != expected_value {
            log::info!(
                "Result is different than expected\nExpected size:                            {}\nResult value  (textureSize):              {}\nExpected Value (for index 0)              {}\nResult value                              {}\nExpectedValue (for last index)            {}\nResult value                              {}\n",
                objects.max_tex_buffer_size,
                result[0],
                0,
                result[1],
                expected_value,
                result[2]
            );
            test_result = false;
        }

        // SAFETY: the buffer mapped above.
        unsafe { gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER) };

        Ok(if test_result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestCase for MaxSizeValidation {
    fn name(&self) -> &str {
        "texture_buffer_max_size"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        let mut objects = MaxSizeObjects::default();

        let outcome = Self::run(context, &base, &mut objects);
        Self::deinit(context, &base, &mut objects);
        outcome
    }
}

/// Size of buffer object's data store: 256 texels of four GLints.
const ERRORS_BO_SIZE: GLint = (256 * 4 * size_of::<GLint>()) as GLint;

/// `TextureBufferErrors`
struct Errors {
    ext_params: ExtParameters,
}

/// The members `initTest` fills and `deinit` releases.
#[derive(Default)]
struct ErrorsObjects {
    bo_id: GLuint,
    tex_id: GLuint,
    texture_targets: Vec<GLenum>,
}

impl Errors {
    /// `initTest`
    fn init_test(context: &Context, base: &TestCaseBase, objects: &mut ErrorsObjects) -> Result<(), TestError> {
        if !base.is_texture_buffer_supported {
            return Err(TestError::NotSupported(
                TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;

        gl_call!(
            gl,
            "Could not generate texture object!",
            gl.gen_textures(1, &mut objects.tex_id)
        );
        gl_call!(
            gl,
            "Could not bind texture object!",
            gl.bind_texture(tokens.texture_buffer, objects.tex_id)
        );
        gl_call!(
            gl,
            "Could not generate buffer object!",
            gl.gen_buffers(1, &mut objects.bo_id)
        );
        gl_call!(
            gl,
            "Could not bind buffer object!",
            gl.bind_buffer(tokens.texture_buffer, objects.bo_id)
        );
        gl_call!(
            gl,
            "Could not allocate buffer object's data store",
            gl.buffer_data(
                tokens.texture_buffer,
                ERRORS_BO_SIZE as GLsizeiptr,
                std::ptr::null(),
                glw::GL_STATIC_READ
            )
        );

        objects.texture_targets.push(glw::GL_TEXTURE_2D);
        objects.texture_targets.push(glw::GL_TEXTURE_2D_ARRAY);
        objects.texture_targets.push(glw::GL_TEXTURE_3D);
        objects.texture_targets.push(glw::GL_TEXTURE_CUBE_MAP);

        if base.is_texture_cube_map_array_supported {
            objects.texture_targets.push(glw::GL_TEXTURE_CUBE_MAP_ARRAY);
        }

        if base.is_texture_storage_multisample_supported {
            objects.texture_targets.push(glw::GL_TEXTURE_2D_MULTISAMPLE);
        }

        Ok(())
    }

    /// `deinit`
    fn deinit(context: &Context, base: &TestCaseBase, objects: &mut ErrorsObjects) {
        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;

        // SAFETY: state resets and deletes of names this case created.
        unsafe {
            gl.bind_texture(tokens.texture_buffer, 0);
            gl.bind_buffer(tokens.texture_buffer, 0);

            if objects.tex_id != 0 {
                gl.delete_textures(1, &objects.tex_id);
                objects.tex_id = 0;
            }
            if objects.bo_id != 0 {
                gl.delete_buffers(1, &objects.bo_id);
                objects.bo_id = 0;
            }
        }
    }

    /// `verifyError`
    fn verify_error(gl: &glw::Functions, expected_error: GLenum, description: &str) -> bool {
        // SAFETY: glGetError needs only a current context.
        let error_code = unsafe { gl.get_error() };

        if error_code != expected_error {
            log::info!("{description}");
            return false;
        }
        true
    }

    fn run(context: &Context, base: &TestCaseBase, objects: &mut ErrorsObjects) -> TestOutcome {
        Self::init_test(context, base, objects)?;

        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;
        let bo_id = objects.bo_id;
        let bo_size = ERRORS_BO_SIZE;
        let range_size = bo_size as GLsizeiptr;

        let mut test_passed = true;

        // INVALID_ENUM if target is not TEXTURE_BUFFER_EXT.
        for &target in &objects.texture_targets {
            // SAFETY: invalid-argument calls are the point of the case; they only set a GL error.
            unsafe { gl.tex_buffer(target, glw::GL_RGBA32I, bo_id) };
            test_passed = Self::verify_error(
                gl,
                glw::GL_INVALID_ENUM,
                "Expected GL_INVALID_ENUM was not returned when wrong texture target was used in glTexBufferEXT.",
            ) && test_passed;

            // SAFETY: as above.
            unsafe { gl.tex_buffer_range(target, glw::GL_RGBA32I, bo_id, 0, range_size) };
            test_passed = Self::verify_error(
                gl,
                glw::GL_INVALID_ENUM,
                "Expected GL_INVALID_ENUM was not returned when wrong texture target was used in glTexBufferRangeEXT.",
            ) && test_passed;
        }

        // INVALID_ENUM if internal format is not one of the sized internal formats of the extension.
        // SAFETY: as above.
        unsafe { gl.tex_buffer(tokens.texture_buffer, glw::GL_DEPTH_COMPONENT32F, bo_id) };
        test_passed = Self::verify_error(
            gl,
            glw::GL_INVALID_ENUM,
            "Expected GL_INVALID_ENUM was not returned when wrong sized internal format was used in glTexBufferEXT.",
        ) && test_passed;

        // SAFETY: as above.
        unsafe { gl.tex_buffer_range(tokens.texture_buffer, glw::GL_DEPTH_COMPONENT32F, bo_id, 0, range_size) };
        test_passed = Self::verify_error(
            gl,
            glw::GL_INVALID_ENUM,
            "Expected GL_INVALID_ENUM was not returned when wrong sized internal format was used in glTexBufferRangeEXT.",
        ) && test_passed;

        // INVALID_OPERATION if buffer is non-zero, but not the name of an existing buffer object.
        // SAFETY: as above.
        unsafe { gl.tex_buffer(tokens.texture_buffer, glw::GL_RGBA32I, bo_id + 1) };
        test_passed = Self::verify_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "Expected GL_INVALID_OPERATION was not returned when non-existing buffer object was used in glTexBufferEXT.",
        ) && test_passed;

        // SAFETY: as above.
        unsafe { gl.tex_buffer_range(tokens.texture_buffer, glw::GL_RGBA32I, bo_id + 1, 0, range_size) };
        test_passed = Self::verify_error(
            gl,
            glw::GL_INVALID_OPERATION,
            "Expected GL_INVALID_OPERATION was not returned when non-existing buffer object was used in glTexBufferRangeEXT.",
        ) && test_passed;

        // INVALID_VALUE if offset is negative.
        // SAFETY: as above.
        unsafe { gl.tex_buffer_range(tokens.texture_buffer, glw::GL_RGBA32I, bo_id, -16, range_size) };
        test_passed = Self::verify_error(
            gl,
            glw::GL_INVALID_VALUE,
            "Expected INVALID_VALUE was not returned when negative offset was used in glTexBufferRangeEXT.",
        ) && test_passed;

        // INVALID_VALUE if size is less than or equal to zero.
        // SAFETY: as above.
        unsafe { gl.tex_buffer_range(tokens.texture_buffer, glw::GL_RGBA32I, bo_id, 0, 0) };
        test_passed = Self::verify_error(
            gl,
            glw::GL_INVALID_VALUE,
            "Expected INVALID_VALUE was not returned when 0 size was used in glTexBufferRangeEXT.",
        ) && test_passed;

        // SAFETY: as above.
        unsafe { gl.tex_buffer_range(tokens.texture_buffer, glw::GL_RGBA32I, bo_id, 0, -1) };
        test_passed = Self::verify_error(
            gl,
            glw::GL_INVALID_VALUE,
            "Expected INVALID_VALUE was not returned when negative size was used in glTexBufferRangeEXT.",
        ) && test_passed;

        // INVALID_VALUE if offset + size is greater than the value of BUFFER_SIZE.
        // SAFETY: as above.
        unsafe {
            gl.tex_buffer_range(
                tokens.texture_buffer,
                glw::GL_RGBA32I,
                bo_id,
                (bo_size / 2) as GLintptr,
                range_size,
            )
        };
        test_passed = Self::verify_error(
            gl,
            glw::GL_INVALID_VALUE,
            "Expected INVALID_VALUE was not returned when offset + size is greater than BUFFER_SIZE",
        ) && test_passed;

        // INVALID_VALUE if offset is not an integer multiple of TEXTURE_BUFFER_OFFSET_ALIGNMENT_EXT.
        let mut texture_buffer_offset_alignment: GLint = 0;
        // SAFETY: the pointer refers to a live GLint.
        unsafe {
            gl.get_integerv(
                tokens.texture_buffer_offset_alignment,
                &mut texture_buffer_offset_alignment,
            )
        };

        if texture_buffer_offset_alignment > 1 {
            // SAFETY: as above.
            unsafe {
                gl.tex_buffer_range(
                    tokens.texture_buffer,
                    glw::GL_RGBA32I,
                    bo_id,
                    (texture_buffer_offset_alignment / 2) as GLintptr,
                    (bo_size - texture_buffer_offset_alignment / 2) as GLsizeiptr,
                )
            };
            test_passed = Self::verify_error(
                gl,
                glw::GL_INVALID_VALUE,
                "Expected INVALID_VALUE was not returned when improperly aligned offset was used in glTexBufferRangeEXT.",
            ) && test_passed;
        }

        Ok(if test_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestCase for Errors {
    fn name(&self) -> &str {
        "texture_buffer_errors"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        let mut objects = ErrorsObjects::default();

        let outcome = Self::run(context, &base, &mut objects);
        Self::deinit(context, &base, &mut objects);
        outcome
    }
}

/// `TextureBufferTests::init` - the cases ported so far, in upstream's order.
pub fn create_tests(ext_params: ExtParameters) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture_buffer");
    for variant in [
        operations::Variant::BufferObjectLoad,
        operations::Variant::CpuWrites,
        operations::Variant::FramebufferReadBack,
        operations::Variant::TransformFeedback,
        operations::Variant::ImageStore,
        operations::Variant::SsboWrites,
    ] {
        group.add_child(Box::new(operations::Operations { ext_params, variant }) as Box<dyn TestCase>);
    }
    group.add_child(Box::new(MaxSizeValidation { ext_params }) as Box<dyn TestCase>);
    group.add_child(Box::new(range::TextureBufferRange { ext_params }) as Box<dyn TestCase>);
    group.add_child(Box::new(conv_int_to_float::ParamValueIntToFloatConversion { ext_params }) as Box<dyn TestCase>);
    group.add_child(Box::new(atomic_functions::AtomicFunctions { ext_params }) as Box<dyn TestCase>);
    group.add_child(Box::new(parameters::Parameters { ext_params }) as Box<dyn TestCase>);
    group.add_child(Box::new(Errors { ext_params }) as Box<dyn TestCase>);
    group.add_child(Box::new(active_uniform_validation::ActiveUniformValidation {
        ext_params,
        variant: active_uniform_validation::Variant::VertexFragment,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(active_uniform_validation::ActiveUniformValidation {
        ext_params,
        variant: active_uniform_validation::Variant::Compute,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(buffer_parameters::BufferParameters { ext_params }) as Box<dyn TestCase>);
    group.add_child(Box::new(precision::Precision { ext_params }) as Box<dyn TestCase>);
    group
}
