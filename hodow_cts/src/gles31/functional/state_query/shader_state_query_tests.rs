// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fShaderStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `verifyInfoLogQuery`
// (glsStateQueryUtil) is not ported, so the info-log check is inlined here in the
// shape upstream's helper has: query the length, then read the log back into an
// oversized buffer and check the reported length against it.

use std::ffi::CString;

use crate::gls::state_query_util::Guarded;
use crate::glu::{ApiCase, ProgramSources, ShaderProgram, ShaderType, TestCaseGroup, add_api_case};
use crate::glw::{self, GLchar, GLenum, GLint, GLsizei, GLuint};

/// `brokenShaderSource`
fn broken_shader_source(case: &ApiCase<'_>) -> String {
    let version = case.context().context_type().glsl_version().declaration();
    format!("{version}\nbroken, this should not compile,\n{{")
}

/// One row of a `BaseTypeCase::getInfos()` table.
struct TestTypeInfo {
    gl_type: GLenum,
    declaration_str: &'static str,
    access_str: &'static str,
}

/// `BaseTypeCase::iterate`
fn base_type_case(
    case: &mut ApiCase<'_>,
    extension: Option<&str>,
    infos: &[TestTypeInfo],
    needs_fragment_images: bool,
) {
    let is_es32 = case.context().context_type().supports(3, 2);
    if let Some(extension) = extension
        && !is_es32
        && !case.context().context_info.is_extension_supported(extension)
    {
        case.not_supported(format!("Test requires {extension}"));
        return;
    }
    if needs_fragment_images && case.get_int(glw::GL_MAX_FRAGMENT_IMAGE_UNIFORMS) < 1 {
        case.not_supported("Test requires fragment images");
        return;
    }

    let version = case.context().context_type().glsl_version().declaration();

    for info in infos {
        case.section("Uniform type");

        let extension_statement = match extension {
            Some(extension) if !is_es32 => format!("#extension {extension} : require\n"),
            _ => String::new(),
        };
        let vertex_source =
            format!("{version}\nin highp vec4 a_position;\nvoid main(void)\n{{\n    gl_Position = a_position;\n}}\n");
        let fragment_source = format!(
            "{version}\n{extension_statement}{};\nlayout(location = 0) out highp vec4 dEQP_FragColor;\nvoid main(void)\n{{\n    dEQP_FragColor = vec4({});\n}}\n",
            info.declaration_str, info.access_str
        );

        let program = ShaderProgram::new(case.gl(), &ProgramSources::vtx_frag(vertex_source, fragment_source));
        if !program.is_ok() {
            case.fail("could not build shader".to_string(), "could not build shader");
            continue;
        }

        // only one uniform - uniform at index 0
        let mut uniforms: GLint = 0;
        // SAFETY: one integer out for a program this case owns.
        unsafe {
            case.gl()
                .get_programiv(program.program(), glw::GL_ACTIVE_UNIFORMS, &raw mut uniforms)
        };

        if uniforms != 1 {
            case.fail(
                format!("Unexpected GL_ACTIVE_UNIFORMS, expected 1, got {uniforms}"),
                "Unexpected GL_ACTIVE_UNIFORMS",
            );
        } else {
            let uniform_index: GLuint = 0;
            let mut uniform_type: GLint = 0;
            // SAFETY: one index in, one integer out.
            unsafe {
                case.gl().get_active_uniformsiv(
                    program.program(),
                    1,
                    &raw const uniform_index,
                    glw::GL_UNIFORM_TYPE,
                    &raw mut uniform_type,
                )
            };

            #[expect(clippy::cast_possible_wrap, reason = "a GL type enum always fits in a GLint")]
            let expected = info.gl_type as GLint;
            if uniform_type != expected {
                case.fail(
                    format!("Invalid type, expected {expected}, got {uniform_type}"),
                    "Invalid type",
                );
            }
        }

        case.expect_error(glw::GL_NO_ERROR);
    }
}

/// `ShaderLogCase::init`
fn shader_log_supported(case: &mut ApiCase<'_>, shader_type: ShaderType) -> bool {
    let is_es32 = case.context().context_type().supports(3, 2);
    match shader_type {
        ShaderType::Vertex | ShaderType::Fragment | ShaderType::Compute => true,
        ShaderType::Geometry => {
            if case
                .context()
                .context_info
                .is_extension_supported("GL_EXT_geometry_shader")
                || is_es32
            {
                return true;
            }
            case.not_supported("Test requires GL_EXT_geometry_shader extension or an OpenGL ES 3.2 or higher context.");
            false
        }
        ShaderType::TessControl | ShaderType::TessEvaluation => {
            if case
                .context()
                .context_info
                .is_extension_supported("GL_EXT_tessellation_shader")
                || is_es32
            {
                return true;
            }
            case.not_supported(
                "Test requires GL_EXT_tessellation_shader extension or an OpenGL ES 3.2 or higher context.",
            );
            false
        }
    }
}

/// The buffer `verifyInfoLogQuery` reads the log back into.
const LOG_BUF_SIZE: usize = 2048;

/// `ShaderLogCase::iterate`
fn shader_log_case(case: &mut ApiCase<'_>, shader_type: ShaderType) {
    if !shader_log_supported(case, shader_type) {
        return;
    }

    case.section("Trying to compile broken shader source.");

    let source = broken_shader_source(case);
    let owned = CString::new(source).expect("no interior nul");
    let pointer: *const GLchar = owned.as_ptr();

    // SAFETY: a fresh shader name, one live null-terminated source string.
    let shader = unsafe { case.gl().create_shader(shader_type.gl_enum()) };
    case.expect_error(glw::GL_NO_ERROR);

    // SAFETY: as above; a null `length` means "null-terminated".
    unsafe {
        case.gl().shader_source(shader, 1, &raw const pointer, std::ptr::null());
        case.gl().compile_shader(shader);
    }
    case.expect_error(glw::GL_NO_ERROR);

    let mut log_len = Guarded::<GLint>::new();
    // SAFETY: one GLint out, guarded on both sides.
    unsafe {
        case.gl()
            .get_shaderiv(shader, glw::GL_INFO_LOG_LENGTH, log_len.as_mut_ptr())
    };
    if log_len.verify_validity(case) {
        // `verifyInfoLogQuery`: read the log into a larger buffer and check that the
        // returned length agrees with the length query.
        let mut buffer = vec![0 as GLchar; LOG_BUF_SIZE];
        let mut written: GLsizei = 0;
        // SAFETY: bufSize is the buffer's own length.
        unsafe {
            case.gl()
                .get_shader_info_log(shader, LOG_BUF_SIZE as GLsizei, &raw mut written, buffer.as_mut_ptr())
        };
        case.expect_error(glw::GL_NO_ERROR);

        if log_len.value() > 0 && written != log_len.value() - 1 && LOG_BUF_SIZE as GLint > log_len.value() {
            case.fail(
                format!("Expected {} (INFO_LOG_LENGTH - 1), got {written}", log_len.value() - 1),
                "Got invalid log length",
            );
        }
    }

    // SAFETY: this case's own shader name.
    unsafe { case.gl().delete_shader(shader) };
    case.expect_error(glw::GL_NO_ERROR);
}

/// `CoreSamplerTypeCase::getInfos`
fn core_sampler_types() -> Vec<TestTypeInfo> {
    vec![
        TestTypeInfo {
            gl_type: glw::GL_SAMPLER_2D_MULTISAMPLE,
            declaration_str: "uniform highp sampler2DMS u_sampler",
            access_str: "texelFetch(u_sampler, ivec2(gl_FragCoord.xy), 0)",
        },
        TestTypeInfo {
            gl_type: glw::GL_INT_SAMPLER_2D_MULTISAMPLE,
            declaration_str: "uniform highp isampler2DMS u_sampler",
            access_str: "texelFetch(u_sampler, ivec2(gl_FragCoord.xy), 0)",
        },
        TestTypeInfo {
            gl_type: glw::GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE,
            declaration_str: "uniform highp usampler2DMS u_sampler",
            access_str: "texelFetch(u_sampler, ivec2(gl_FragCoord.xy), 0)",
        },
    ]
}

/// `MSArraySamplerTypeCase::getInfos`
fn ms_array_sampler_types() -> Vec<TestTypeInfo> {
    vec![
        TestTypeInfo {
            gl_type: glw::GL_SAMPLER_2D_MULTISAMPLE_ARRAY,
            declaration_str: "uniform highp sampler2DMSArray u_sampler",
            access_str: "texelFetch(u_sampler, ivec3(gl_FragCoord.xyz), 0)",
        },
        TestTypeInfo {
            gl_type: glw::GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY,
            declaration_str: "uniform highp isampler2DMSArray u_sampler",
            access_str: "texelFetch(u_sampler, ivec3(gl_FragCoord.xyz), 0)",
        },
        TestTypeInfo {
            gl_type: glw::GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY,
            declaration_str: "uniform highp usampler2DMSArray u_sampler",
            access_str: "texelFetch(u_sampler, ivec3(gl_FragCoord.xyz), 0)",
        },
    ]
}

/// `TextureBufferSamplerTypeCase::getInfos`
fn texture_buffer_sampler_types() -> Vec<TestTypeInfo> {
    vec![
        TestTypeInfo {
            gl_type: glw::GL_SAMPLER_BUFFER,
            declaration_str: "uniform highp samplerBuffer u_sampler",
            access_str: "texelFetch(u_sampler, int(gl_FragCoord.x))",
        },
        TestTypeInfo {
            gl_type: glw::GL_INT_SAMPLER_BUFFER,
            declaration_str: "uniform highp isamplerBuffer u_sampler",
            access_str: "texelFetch(u_sampler, int(gl_FragCoord.x))",
        },
        TestTypeInfo {
            gl_type: glw::GL_UNSIGNED_INT_SAMPLER_BUFFER,
            declaration_str: "uniform highp usamplerBuffer u_sampler",
            access_str: "texelFetch(u_sampler, int(gl_FragCoord.x))",
        },
    ]
}

/// `TextureBufferImageTypeCase::getInfos`
fn texture_buffer_image_types() -> Vec<TestTypeInfo> {
    vec![
        TestTypeInfo {
            gl_type: glw::GL_IMAGE_BUFFER,
            declaration_str: "layout(binding=0, rgba8) readonly uniform highp imageBuffer u_image",
            access_str: "imageLoad(u_image, int(gl_FragCoord.x))",
        },
        TestTypeInfo {
            gl_type: glw::GL_INT_IMAGE_BUFFER,
            declaration_str: "layout(binding=0, r32i) readonly uniform highp iimageBuffer u_image",
            access_str: "imageLoad(u_image, int(gl_FragCoord.x))",
        },
        TestTypeInfo {
            gl_type: glw::GL_UNSIGNED_INT_IMAGE_BUFFER,
            declaration_str: "layout(binding=0, r32ui) readonly uniform highp uimageBuffer u_image",
            access_str: "imageLoad(u_image, int(gl_FragCoord.x))",
        },
    ]
}

/// `CubeArraySamplerTypeCase::getInfos`
fn cube_array_sampler_types() -> Vec<TestTypeInfo> {
    vec![
        TestTypeInfo {
            gl_type: glw::GL_SAMPLER_CUBE_MAP_ARRAY,
            declaration_str: "uniform highp samplerCubeArray u_sampler",
            access_str: "texture(u_sampler, gl_FragCoord.xxyz)",
        },
        TestTypeInfo {
            gl_type: glw::GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW,
            declaration_str: "uniform highp samplerCubeArrayShadow u_sampler",
            access_str: "texture(u_sampler, gl_FragCoord.xxyz, 0.5)",
        },
        TestTypeInfo {
            gl_type: glw::GL_INT_SAMPLER_CUBE_MAP_ARRAY,
            declaration_str: "uniform highp isamplerCubeArray u_sampler",
            access_str: "texture(u_sampler, gl_FragCoord.xxyz)",
        },
        TestTypeInfo {
            gl_type: glw::GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY,
            declaration_str: "uniform highp usamplerCubeArray u_sampler",
            access_str: "texture(u_sampler, gl_FragCoord.xxyz)",
        },
    ]
}

/// `CubeArrayImageTypeCase::getInfos`
fn cube_array_image_types() -> Vec<TestTypeInfo> {
    vec![
        TestTypeInfo {
            gl_type: glw::GL_IMAGE_CUBE_MAP_ARRAY,
            declaration_str: "layout(binding=0, rgba8) readonly uniform highp imageCubeArray u_image",
            access_str: "imageLoad(u_image, ivec3(gl_FragCoord.xyx))",
        },
        TestTypeInfo {
            gl_type: glw::GL_INT_IMAGE_CUBE_MAP_ARRAY,
            declaration_str: "layout(binding=0, r32i) readonly uniform highp iimageCubeArray u_image",
            access_str: "imageLoad(u_image, ivec3(gl_FragCoord.xyx))",
        },
        TestTypeInfo {
            gl_type: glw::GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY,
            declaration_str: "layout(binding=0, r32ui) readonly uniform highp uimageCubeArray u_image",
            access_str: "imageLoad(u_image, ivec3(gl_FragCoord.xyx))",
        },
    ]
}

/// `ShaderStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader");

    add_api_case(&mut group, "sampler_type", |case: &mut ApiCase<'_>| {
        base_type_case(case, None, &core_sampler_types(), false);
    });
    add_api_case(
        &mut group,
        "sampler_type_multisample_array",
        |case: &mut ApiCase<'_>| {
            base_type_case(
                case,
                Some("GL_OES_texture_storage_multisample_2d_array"),
                &ms_array_sampler_types(),
                false,
            );
        },
    );
    add_api_case(&mut group, "sampler_type_texture_buffer", |case: &mut ApiCase<'_>| {
        base_type_case(
            case,
            Some("GL_EXT_texture_buffer"),
            &texture_buffer_sampler_types(),
            false,
        );
    });
    add_api_case(&mut group, "image_type_texture_buffer", |case: &mut ApiCase<'_>| {
        base_type_case(case, Some("GL_EXT_texture_buffer"), &texture_buffer_image_types(), true);
    });
    add_api_case(&mut group, "sampler_type_cube_array", |case: &mut ApiCase<'_>| {
        base_type_case(
            case,
            Some("GL_EXT_texture_cube_map_array"),
            &cube_array_sampler_types(),
            false,
        );
    });
    add_api_case(&mut group, "image_type_cube_array", |case: &mut ApiCase<'_>| {
        base_type_case(
            case,
            Some("GL_EXT_texture_cube_map_array"),
            &cube_array_image_types(),
            true,
        );
    });

    // Shader info log tests. There are similar tests in the gles3 module, but the
    // gles31 module may use a different shader compiler with different INFO_LOG bugs.
    for (name, shader_type) in [
        ("info_log_vertex", ShaderType::Vertex),
        ("info_log_fragment", ShaderType::Fragment),
        ("info_log_geometry", ShaderType::Geometry),
        ("info_log_tess_ctrl", ShaderType::TessControl),
        ("info_log_tess_eval", ShaderType::TessEvaluation),
        ("info_log_compute", ShaderType::Compute),
    ] {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            shader_log_case(case, shader_type)
        });
    }

    group
}
