// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_buffer/esextcTextureBufferPrecision.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use super::TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, GlslVersion, TestCase};
use crate::glw::{self, GLenum, GLint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const CS_CODE_HEAD: &str = "${VERSION}\n\n${TEXTURE_BUFFER_REQUIRE}\n\n";
const CS_CODE_BODY: &str = "\nvoid main()\n{\n    computeSSBO.value = imageLoad(image_buffer, 0).x;\n}";
const FS_CODE_HEAD: &str = "${VERSION}\n\n${TEXTURE_BUFFER_REQUIRE}\n\n";
const FS_CODE_BODY: &str = "\nvoid main()\n{\n    color = texelFetch( sampler_buffer, 0 );\n}";

const CS_CODE_DECLARATION_WITHOUT_PRECISION: [&str; 3] = [
    concat!(
        "layout (r32f)  uniform  imageBuffer image_buffer;\n",
        "\n",
        "buffer ComputeSSBO\n",
        "{\n",
        "    float value;\n",
        "} computeSSBO;\n",
    ),
    concat!(
        "layout (r32i)  uniform iimageBuffer image_buffer;\n",
        "\n",
        "buffer ComputeSSBO\n",
        "{\n",
        "    int value;\n",
        "} computeSSBO;\n",
    ),
    concat!(
        "layout (r32ui) uniform uimageBuffer image_buffer;\n",
        "\n",
        "buffer ComputeSSBO\n",
        "{\n",
        "    uint value;\n",
        "} computeSSBO;\n",
    ),
];

const CS_CODE_DECLARATION_WITH_PRECISION: [&str; 3] = [
    concat!(
        "layout (r32f)  uniform highp  imageBuffer image_buffer;\n",
        "\n",
        "buffer ComputeSSBO\n",
        "{\n",
        "    float value;\n",
        "} computeSSBO;\n",
    ),
    concat!(
        "layout (r32i)  uniform highp iimageBuffer image_buffer;\n",
        "\n",
        "buffer ComputeSSBO\n",
        "{\n",
        "    int value;\n",
        "} computeSSBO;\n",
    ),
    concat!(
        "layout (r32ui) uniform highp uimageBuffer image_buffer;\n",
        "\n",
        "buffer ComputeSSBO\n",
        "{\n",
        "    uint value;\n",
        "} computeSSBO;\n",
    ),
];

const CS_CODE_GLOBAL_PRECISION: [&str; 3] = [
    "precision highp  imageBuffer;\n",
    "precision highp iimageBuffer;\n",
    "precision highp uimageBuffer;\n",
];

const FS_CODE_DECLARATION_WITHOUT_PRECISION: [&str; 3] = [
    concat!(
        "uniform  samplerBuffer sampler_buffer;\n",
        "\n",
        "layout(location = 0) out highp vec4 color;\n",
    ),
    concat!(
        "uniform isamplerBuffer sampler_buffer;\n",
        "\n",
        "layout(location = 0) out highp ivec4 color;\n",
    ),
    concat!(
        "uniform usamplerBuffer sampler_buffer;\n",
        "\n",
        "layout(location = 0) out highp uvec4 color;\n",
    ),
];

const FS_CODE_DECLARATION_WITH_PRECISION: [&str; 3] = [
    concat!(
        "uniform highp  samplerBuffer sampler_buffer;\n",
        "\n",
        "layout(location = 0) out highp vec4 color;\n",
    ),
    concat!(
        "uniform highp isamplerBuffer sampler_buffer;\n",
        "\n",
        "layout(location = 0) out highp ivec4 color;\n",
    ),
    concat!(
        "uniform highp usamplerBuffer sampler_buffer;\n",
        "\n",
        "layout(location = 0) out highp uvec4 color;\n",
    ),
];

const FS_CODE_GLOBAL_PRECISION: [&str; 3] = [
    "precision highp  samplerBuffer;\n",
    "precision highp isamplerBuffer;\n",
    "precision highp usamplerBuffer;\n",
];

/// `TextureBufferPrecision`
pub(super) struct Precision {
    pub(super) ext_params: ExtParameters,
}

impl Precision {
    /// The constructor's "Bug-15063": only GLSL 4.50 supports opaque types, so every desktop version is raised to it.
    fn effective_ext_params(&self) -> ExtParameters {
        let mut ext_params = self.ext_params;
        if ext_params.glsl_version >= GlslVersion::Glsl130 {
            ext_params.glsl_version = GlslVersion::Glsl450;
        }
        ext_params
    }

    /// `verifyShaderCompilationStatus`; the program and shader objects are always deleted again, as upstream's clean-up does.
    fn verify_shader_compilation_status(
        context: &Context,
        base: &TestCaseBase,
        shader_type: GLenum,
        sh_code_parts: &[&str],
        expected_status: GLint,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut test_passed = true;

        // SAFETY: object creation on the current context.
        let po_id = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "Could not create program object")?;

        // SAFETY: as above.
        let sh_id = unsafe { gl.create_shader(shader_type) };
        glu::expect_no_error(gl, "Could not create shader object")?;

        let result = (|| -> Result<(), TestError> {
            let shader_code = base.specialize_shader(sh_code_parts);
            let pointer = shader_code.as_ptr().cast::<glw::GLchar>();
            let length = shader_code.len() as GLint;

            // SAFETY: the source outlives the call and its length is passed explicitly.
            unsafe { gl.shader_source(sh_id, 1, &pointer, &length) };
            glu::expect_no_error(gl, "Could not set shader source")?;

            // SAFETY: a shader object created above.
            unsafe { gl.compile_shader(sh_id) };
            glu::expect_no_error(gl, "Failed to perform compilation of shader object")?;

            let mut compilation_status: GLint = glw::GL_FALSE as GLint;
            // SAFETY: one GLint out.
            unsafe { gl.get_shaderiv(sh_id, glw::GL_COMPILE_STATUS, &mut compilation_status) };
            glu::expect_no_error(gl, "Could not retrieve shader compilation status")?;

            if compilation_status != expected_status {
                test_passed = false;

                let mut info_log_length: GLint = 0;
                // SAFETY: one GLint out.
                unsafe { gl.get_shaderiv(sh_id, glw::GL_INFO_LOG_LENGTH, &mut info_log_length) };
                glu::expect_no_error(gl, "Could not get shader info log length")?;

                if info_log_length > 0 {
                    let mut info_log = vec![0u8; info_log_length as usize];
                    // SAFETY: the buffer holds `info_log_length` bytes.
                    unsafe {
                        gl.get_shader_info_log(
                            sh_id,
                            info_log_length,
                            std::ptr::null_mut(),
                            info_log.as_mut_ptr().cast(),
                        )
                    };

                    let end = info_log.iter().position(|&b| b == 0).unwrap_or(info_log.len());
                    log::info!(
                        "The following shader:\n\n{shader_code}\n\n did compile with result different than expected:\n{expected_status}\n\n Compilation info log: \n{}\n",
                        String::from_utf8_lossy(&info_log[..end])
                    );

                    glu::expect_no_error(gl, "Could not get shader info log")?;
                }
            }
            Ok(())
        })();

        // SAFETY: names created above.
        unsafe {
            gl.delete_program(po_id);
            gl.delete_shader(sh_id);
        }

        result?;
        Ok(test_passed)
    }
}

impl TestCase for Precision {
    fn name(&self) -> &str {
        "texture_buffer_precision"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let ext_params = self.effective_ext_params();
        let base = TestCaseBase::init(context, ext_params);

        if !base.is_texture_buffer_supported {
            return Err(TestError::NotSupported(
                TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        let context_type = context.context_type();
        let mut test_passed = true;
        let expected_fail = (if base.glsl_version.is_es() {
            glw::GL_FALSE
        } else {
            glw::GL_TRUE
        }) as GLint;

        if context_type.supports_core(4, 5) || context_type.supports(3, 1) {
            for i in 0..3 {
                let without_precision = [CS_CODE_HEAD, CS_CODE_DECLARATION_WITHOUT_PRECISION[i], CS_CODE_BODY];
                let with_precision = [CS_CODE_HEAD, CS_CODE_DECLARATION_WITH_PRECISION[i], CS_CODE_BODY];
                let with_global_precision = [
                    CS_CODE_HEAD,
                    CS_CODE_GLOBAL_PRECISION[i],
                    CS_CODE_DECLARATION_WITHOUT_PRECISION[i],
                    CS_CODE_BODY,
                ];

                test_passed = Self::verify_shader_compilation_status(
                    context,
                    &base,
                    glw::GL_COMPUTE_SHADER,
                    &without_precision,
                    expected_fail,
                )? && test_passed;
                test_passed = Self::verify_shader_compilation_status(
                    context,
                    &base,
                    glw::GL_COMPUTE_SHADER,
                    &with_precision,
                    glw::GL_TRUE as GLint,
                )? && test_passed;
                test_passed = Self::verify_shader_compilation_status(
                    context,
                    &base,
                    glw::GL_COMPUTE_SHADER,
                    &with_global_precision,
                    glw::GL_TRUE as GLint,
                )? && test_passed;
            }
        }

        for i in 0..3 {
            let without_precision = [FS_CODE_HEAD, FS_CODE_DECLARATION_WITHOUT_PRECISION[i], FS_CODE_BODY];
            let with_precision = [FS_CODE_HEAD, FS_CODE_DECLARATION_WITH_PRECISION[i], FS_CODE_BODY];
            let with_global_precision = [
                FS_CODE_HEAD,
                FS_CODE_GLOBAL_PRECISION[i],
                FS_CODE_DECLARATION_WITHOUT_PRECISION[i],
                FS_CODE_BODY,
            ];

            test_passed = Self::verify_shader_compilation_status(
                context,
                &base,
                glw::GL_FRAGMENT_SHADER,
                &without_precision,
                expected_fail,
            )? && test_passed;
            test_passed = Self::verify_shader_compilation_status(
                context,
                &base,
                glw::GL_FRAGMENT_SHADER,
                &with_precision,
                glw::GL_TRUE as GLint,
            )? && test_passed;
            test_passed = Self::verify_shader_compilation_status(
                context,
                &base,
                glw::GL_FRAGMENT_SHADER,
                &with_global_precision,
                glw::GL_TRUE as GLint,
            )? && test_passed;
        }

        Ok(if test_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}
