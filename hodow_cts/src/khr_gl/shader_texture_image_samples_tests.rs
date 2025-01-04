// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderTextureImageSamplesTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The base class's members are the fields of `Objects`, released by its `Drop` where upstream calls `deinit`; the program/shader/buffer/texture objects are raw GL as upstream's.

use std::ffi::CString;

use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const EXTENSION: &str = "GL_ARB_shader_texture_image_samples";

#[derive(Clone, Copy, PartialEq, Eq)]
enum SamplerType {
    ISampler2DMS,
    ISampler2DMSArray,
    Sampler2DMS,
    Sampler2DMSArray,
    USampler2DMS,
    USampler2DMSArray,
}

const SAMPLER_TYPES: [SamplerType; 6] = [
    SamplerType::ISampler2DMS,
    SamplerType::ISampler2DMSArray,
    SamplerType::Sampler2DMS,
    SamplerType::Sampler2DMSArray,
    SamplerType::USampler2DMS,
    SamplerType::USampler2DMSArray,
];

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    Image,
    Texture,
}

const TO_DEPTH: i32 = 3;
const TO_HEIGHT: i32 = 4;
const TO_WIDTH: i32 = 8;

const CS_TEMPLATE_CODE: &str = "#version 430\n\n#extension GL_ARB_shader_texture_image_samples : require\n\nlayout(local_size_x = 1) in;\n\nbuffer Result\n{\n    int samples;\n};\n\nSAMPLER_TYPE data;\n\nvoid main()\n{\n    samples = SAMPLES_MODIFIER\n}\n";

/// The members of `ShaderTextureImageSamplesTestBase`; `deinit` is `Drop`.
struct Objects<'gl> {
    gl: &'gl glw::Functions,
    bo_id: GLuint,
    cs_id: GLuint,
    po_id: GLuint,
    to_id: GLuint,
}

impl<'gl> Objects<'gl> {
    fn new(gl: &'gl glw::Functions) -> Self {
        Self {
            gl,
            bo_id: 0,
            cs_id: 0,
            po_id: 0,
            to_id: 0,
        }
    }

    /// `ShaderTextureImageSamplesTestBase::buildComputeProgram`
    fn build_compute_program(
        &mut self,
        cs_body: &str,
        should_link_po: bool,
        should_succeed: bool,
    ) -> Result<bool, TestError> {
        let gl = self.gl;

        self.deinit_program_and_shader_objects();

        // SAFETY: plain object creation with a current context.
        self.cs_id = unsafe { gl.create_shader(glw::GL_COMPUTE_SHADER) };
        glu::expect_no_error(gl, "glCreateShader() call failed.")?;

        // SAFETY: as above.
        self.po_id = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "glCreateProgram() call failed.")?;

        let source = CString::new(cs_body).map_err(|_| TestError::Fail("Shader source contains a NUL".to_string()))?;
        let source_ptr = source.as_ptr();
        gl_call!(
            gl,
            "glShaderSource() call failed.",
            gl.shader_source(self.cs_id, 1, &source_ptr, std::ptr::null())
        );

        let mut compile_status = glw::GL_FALSE as GLint;
        gl_call!(gl, "glCompileShader() call failed.", gl.compile_shader(self.cs_id));
        gl_call!(
            gl,
            "glGetShaderiv() call failed.",
            gl.get_shaderiv(self.cs_id, glw::GL_COMPILE_STATUS, &mut compile_status)
        );

        if compile_status != glw::GL_TRUE as GLint {
            if should_succeed {
                return Err(TestError::Fail("Shader compilation failed.".to_string()));
            }
            return Ok(false);
        } else if !should_succeed {
            return Err(TestError::Fail(
                "Shader compilation has succeeded, even though it should not have.".to_string(),
            ));
        }

        if should_link_po {
            gl_call!(
                gl,
                "glAttachShader() call failed.",
                gl.attach_shader(self.po_id, self.cs_id)
            );

            let mut link_status = glw::GL_FALSE as GLint;
            gl_call!(gl, "glLinkProgram() call failed.", gl.link_program(self.po_id));
            gl_call!(
                gl,
                "glGetProgramiv() call failed.",
                gl.get_programiv(self.po_id, glw::GL_LINK_STATUS, &mut link_status)
            );

            if link_status != glw::GL_TRUE as GLint {
                if should_succeed {
                    return Err(TestError::Fail("Program linking failed.".to_string()));
                }
                return Ok(false);
            }
        }

        Ok(true)
    }

    /// `ShaderTextureImageSamplesTestBase::deinitProgramAndShaderObjects`
    fn deinit_program_and_shader_objects(&mut self) {
        // SAFETY: names this case created, each deleted once and zeroed.
        unsafe {
            if self.cs_id != 0 {
                self.gl.delete_shader(self.cs_id);
                self.cs_id = 0;
            }
            if self.po_id != 0 {
                self.gl.delete_program(self.po_id);
                self.po_id = 0;
            }
        }
    }

    /// `ShaderTextureImageSamplesTestBase::init` (after the extension check)
    fn allocate_result_buffer(&mut self) -> Result<(), TestError> {
        let gl = self.gl;

        gl_call!(gl, "glGenBuffers() call failed.", gl.gen_buffers(1, &mut self.bo_id));
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.bo_id)
        );
        gl_call!(
            gl,
            "glBufferData() call failed.",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of::<i32>() as isize,
                std::ptr::null(),
                glw::GL_STATIC_DRAW
            )
        );
        Ok(())
    }

    /// `ShaderTextureImageSamplesTestBase::executeFunctionalTest`
    fn execute_functional_test(&mut self, sampler_type: SamplerType, test_type: TestType) -> Result<(), TestError> {
        let gl = self.gl;

        self.deinit_program_and_shader_objects();

        let (samples_modifier_token_value, sampler_type_string, sampler_type_token_value) =
            match (test_type, sampler_type) {
                (TestType::Image, SamplerType::ISampler2DMS) => (
                    "imageSamples(data);\n",
                    "iimage2DMS",
                    "layout(rgba8i) uniform iimage2DMS",
                ),
                (TestType::Image, SamplerType::ISampler2DMSArray) => (
                    "imageSamples(data);\n",
                    "iimage2DMSArray",
                    "layout(rgba8i) uniform iimage2DMSArray",
                ),
                (TestType::Image, SamplerType::Sampler2DMS) => {
                    ("imageSamples(data);\n", "image2DMS", "layout(rgba8) uniform image2DMS")
                }
                (TestType::Image, SamplerType::Sampler2DMSArray) => (
                    "imageSamples(data);\n",
                    "image2DMSArray",
                    "layout(rgba8) uniform image2DMSArray",
                ),
                (TestType::Image, SamplerType::USampler2DMS) => (
                    "imageSamples(data);\n",
                    "uimage2DMS",
                    "layout(rgba8ui) uniform uimage2DMS",
                ),
                (TestType::Image, SamplerType::USampler2DMSArray) => (
                    "imageSamples(data);\n",
                    "uimage2DMSArray",
                    "layout(rgba8ui) uniform uimage2DMSArray",
                ),
                (TestType::Texture, SamplerType::ISampler2DMS) => {
                    ("textureSamples(data);\n", "isampler2DMS", "uniform isampler2DMS")
                }
                (TestType::Texture, SamplerType::ISampler2DMSArray) => (
                    "textureSamples(data);\n",
                    "isampler2DMSArray",
                    "uniform isampler2DMSArray",
                ),
                (TestType::Texture, SamplerType::Sampler2DMS) => {
                    ("textureSamples(data);\n", "sampler2DMS", "uniform sampler2DMS")
                }
                (TestType::Texture, SamplerType::Sampler2DMSArray) => (
                    "textureSamples(data);\n",
                    "sampler2DMSArray",
                    "uniform sampler2DMSArray",
                ),
                (TestType::Texture, SamplerType::USampler2DMS) => {
                    ("textureSamples(data);\n", "usampler2DMS", "uniform usampler2DMS")
                }
                (TestType::Texture, SamplerType::USampler2DMSArray) => (
                    "textureSamples(data);\n",
                    "usampler2DMSArray",
                    "uniform usampler2DMSArray",
                ),
            };

        let cs_body = CS_TEMPLATE_CODE
            .replace("SAMPLES_MODIFIER", samples_modifier_token_value)
            .replace("SAMPLER_TYPE", sampler_type_token_value);

        if !self.build_compute_program(&cs_body, true, true)? {
            return Err(TestError::Fail("Could not link a test program".to_string()));
        }

        gl_call!(
            gl,
            "glShaderStorageBlockBinding() call failed.",
            gl.shader_storage_block_binding(self.po_id, 0, 0)
        );
        gl_call!(
            gl,
            "glBindBufferBase() call failed.",
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.bo_id)
        );

        let texture_internalformat: GLenum = match sampler_type {
            SamplerType::ISampler2DMS | SamplerType::ISampler2DMSArray => glw::GL_RGBA8I,
            SamplerType::Sampler2DMS | SamplerType::Sampler2DMSArray => glw::GL_RGBA8,
            _ => glw::GL_RGBA8UI,
        };
        let texture_target: GLenum = match sampler_type {
            SamplerType::ISampler2DMS | SamplerType::Sampler2DMS | SamplerType::USampler2DMS => {
                glw::GL_TEXTURE_2D_MULTISAMPLE
            }
            _ => glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
        };

        let mut internalformat_n_samples_count: GLint = 0;
        gl_call!(
            gl,
            "glGetInternalformativ() call failed.",
            gl.get_internalformativ(
                texture_target,
                texture_internalformat,
                glw::GL_NUM_SAMPLE_COUNTS,
                1,
                &mut internalformat_n_samples_count
            )
        );

        if internalformat_n_samples_count < 1 {
            return Err(TestError::Fail(
                "Invalid value returned by glGetInternalformativ() for a GL_NUM_SAMPLE_COUNTS query".to_string(),
            ));
        }

        let mut internalformat_n_samples_data = vec![0 as GLint; internalformat_n_samples_count as usize];
        gl_call!(
            gl,
            "glGetInternalformativ() call failed.",
            gl.get_internalformativ(
                texture_target,
                texture_internalformat,
                glw::GL_SAMPLES,
                internalformat_n_samples_count,
                internalformat_n_samples_data.as_mut_ptr()
            )
        );

        for &samples in &internalformat_n_samples_data {
            if test_type == TestType::Image {
                let mut max_image_samples: GLint = 0;
                gl_call!(
                    gl,
                    "glGetIntegerv(GL_MAX_IMAGE_SAMPLES) call failed.",
                    gl.get_integerv(glw::GL_MAX_IMAGE_SAMPLES, &mut max_image_samples)
                );

                if samples > max_image_samples {
                    continue;
                }
            }

            gl_call!(gl, "glGenTextures() call failed.", gl.gen_textures(1, &mut self.to_id));
            gl_call!(
                gl,
                "glBindTexture() call failed.",
                gl.bind_texture(texture_target, self.to_id)
            );

            if texture_target == glw::GL_TEXTURE_2D_MULTISAMPLE {
                gl_call!(
                    gl,
                    "glTexStorage2DMultisample() call failed",
                    gl.tex_storage_2d_multisample(
                        texture_target,
                        samples,
                        texture_internalformat,
                        TO_WIDTH,
                        TO_HEIGHT,
                        glw::FALSE
                    )
                );
            } else {
                gl_call!(
                    gl,
                    "glTexStorage3DMultisample() call failed",
                    gl.tex_storage_3d_multisample(
                        texture_target,
                        samples,
                        texture_internalformat,
                        TO_WIDTH,
                        TO_HEIGHT,
                        TO_DEPTH,
                        glw::TRUE
                    )
                );
            }

            if test_type == TestType::Image {
                gl_call!(
                    gl,
                    "glBindImageTexture() call failed.",
                    gl.bind_image_texture(
                        0,
                        self.to_id,
                        0,
                        glw::FALSE,
                        0,
                        glw::GL_READ_ONLY,
                        texture_internalformat
                    )
                );
            }

            gl_call!(gl, "glUseProgram() call failed.", gl.use_program(self.po_id));
            gl_call!(gl, "glDispatchCompute() call failed.", gl.dispatch_compute(1, 1, 1));
            gl_call!(
                gl,
                "glMemoryBarrier() call failed.",
                gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT)
            );

            // SAFETY: the buffer bound to GL_ARRAY_BUFFER holds one int and is unmapped below.
            let bo_ptr = unsafe { gl.map_buffer(glw::GL_ARRAY_BUFFER, glw::GL_READ_ONLY) };
            glu::expect_no_error(gl, "glMapBuffer() call failed")?;
            if bo_ptr.is_null() {
                return Err(TestError::Fail("glMapBuffer() returned NULL".to_string()));
            }

            // SAFETY: non-null mapping of a buffer of `size_of::<i32>()` bytes.
            let reported = unsafe { bo_ptr.cast::<i32>().read_unaligned() };
            if reported != samples {
                log::error!(
                    "Value reported for the {sampler_type_string} test [{reported}]  is different from the expected one [{samples}]."
                );
                // SAFETY: the buffer is mapped.
                unsafe { gl.unmap_buffer(glw::GL_ARRAY_BUFFER) };
                return Err(TestError::Fail("Invalid value reported by ES SL function".to_string()));
            }

            gl_call!(gl, "glUnmapBuffer() call failed", gl.unmap_buffer(glw::GL_ARRAY_BUFFER));

            gl_call!(
                gl,
                "glDeleteTextures() call failed.",
                gl.delete_textures(1, &self.to_id)
            );
            self.to_id = 0;
        }

        Ok(())
    }
}

impl Drop for Objects<'_> {
    fn drop(&mut self) {
        self.deinit_program_and_shader_objects();

        // SAFETY: names this case created, each deleted once.
        unsafe {
            if self.bo_id != 0 {
                self.gl.delete_buffers(1, &self.bo_id);
            }
            if self.to_id != 0 {
                self.gl.delete_textures(1, &self.to_id);
            }
        }
    }
}

fn check_extension(context: &Context) -> Result<(), TestError> {
    if context.context_info.is_extension_supported(EXTENSION) {
        Ok(())
    } else {
        Err(TestError::NotSupported(
            "GL_ARB_shader_texture_image_samples extension is not supported.".to_string(),
        ))
    }
}

/// `ShaderTextureImageSampleFunctionalTest`
struct FunctionalTest {
    name: &'static str,
    type_to_test: TestType,
}

impl TestCase for FunctionalTest {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_extension(context)?;

        if self.type_to_test == TestType::Image {
            let gl = context.gl();
            let mut max_image_samples: GLint = 0;
            gl_call!(
                gl,
                "glGetIntegerv() call failed.",
                gl.get_integerv(glw::GL_MAX_IMAGE_SAMPLES, &mut max_image_samples)
            );

            if max_image_samples == 0 {
                return Err(TestError::NotSupported("GL_MAX_IMAGE_SAMPLES == 0".to_string()));
            }
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut objects = Objects::new(context.gl());
        objects.allocate_result_buffer()?;

        for sampler_type in SAMPLER_TYPES {
            objects.execute_functional_test(sampler_type, self.type_to_test)?;
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `ShaderTextureImageSamplesGLSLExtensionEnableTest` / `...RequireTest`
struct GlslExtensionTest {
    name: &'static str,
    cs_body: &'static str,
    failure: &'static str,
}

impl TestCase for GlslExtensionTest {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_extension(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut objects = Objects::new(context.gl());
        objects.allocate_result_buffer()?;

        if !objects.build_compute_program(self.cs_body, false, true)? {
            return Err(TestError::Fail(self.failure.to_string()));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `ShaderTextureImageSamplesTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_texture_image_samples_tests");
    group.add_child(Box::new(FunctionalTest {
        name: "image_functional_test",
        type_to_test: TestType::Image,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(FunctionalTest {
        name: "texture_functional_test",
        type_to_test: TestType::Texture,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(GlslExtensionTest {
        name: "glsl_extension_enable",
        cs_body: "#version 440\n\n#extension GL_ARB_shader_texture_image_samples : enable\n\nvoid main()\n{\n#ifndef GL_ARB_shader_texture_image_samples\n    force_compilation_error\n#endif\n}\n",
        failure: "GL_ARB_shader_image_load_store preprocessor #define is not set to the value of 1",
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(GlslExtensionTest {
        name: "glsl_extension_require",
        cs_body: "#version 440\n\n#extension GL_ARB_shader_texture_image_samples : require\n\nvoid main()\n{\n}\n",
        failure: "A valid compute program has failed to build",
    }) as Box<dyn TestCase>);
    group
}
