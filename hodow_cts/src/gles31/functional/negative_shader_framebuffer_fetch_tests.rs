// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fNegativeShaderFramebufferFetchTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `!isContextTypeES` early returns are
// resolved at port time - this port only ever runs an ES context.

use crate::gles31::functional::negative_test_shared::{FunctionContainer, NegativeTestContext};
use crate::glu::{ProgramSources, ShaderProgram, ShaderType};
use crate::tcu::TestError;

/// `vertexShaderSource`
fn vertex_shader_source(version: &str) -> String {
    format!("{version}\n\nvoid main (void)\n{{\n    gl_Position = vec4(0.0);\n}}\n")
}

/// `fragmentShaderSource`
fn fragment_shader_source(version: &str) -> String {
    format!(
        "{version}\nlayout(location = 0) out mediump vec4 fragColor;\n\nvoid main (void)\n{{\n    fragColor = vec4(1.0);\n}}\n"
    )
}

/// `checkFramebufferFetchSupport`
fn check_framebuffer_fetch_support(ctx: &NegativeTestContext<'_>) -> Result<(), TestError> {
    if ctx.is_extension_supported("GL_EXT_shader_framebuffer_fetch") {
        Ok(())
    } else {
        Err(TestError::NotSupported(
            "GL_EXT_shader_framebuffer_fetch not supported".to_string(),
        ))
    }
}

/// `verifyProgramError(PROGRAM_ERROR_LINK)`
fn verify_link_error(ctx: &mut NegativeTestContext<'_>, program: &ShaderProgram<'_>) {
    if program.program_info.ok {
        ctx.fail("Program was not expected to link.");
    }
}

/// `verifyProgramError(PROGRAM_ERROR_COMPILE_OR_LINK)`
fn verify_compile_or_link_error(
    ctx: &mut NegativeTestContext<'_>,
    program: &ShaderProgram<'_>,
    shader_type: ShaderType,
) {
    let compiled = program
        .shader_info
        .iter()
        .any(|(ty, info)| *ty == shader_type && info.ok);
    if program.program_info.ok && compiled {
        ctx.fail("Program was not expected to compile or link.");
    }
}

fn last_frag_data_not_defined(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_framebuffer_fetch_support(ctx)?;
    let version = ctx.glsl_version_decl();

    let fragment = format!(
        "{version}\n#extension GL_EXT_shader_framebuffer_fetch : require\nlayout(location = 0) out mediump vec4 fragColor;\n\nvoid main (void)\n{{\n    fragColor = gl_LastFragData[0];\n}}\n"
    );
    let program = ShaderProgram::new(
        ctx.gl(),
        &ProgramSources::vtx_frag(vertex_shader_source(version), fragment),
    );

    ctx.begin_section(
        "A link error is generated if the built-in fragment outputs of ES 2.0 are used in #version 300 es shaders",
    );
    verify_link_error(ctx, &program);
    ctx.end_section();
    Ok(())
}

/// Upstream returns before doing anything: the ES 1.00 shader it would build crashes some
/// drivers on an ES 3.1 context. Kept as a registered no-op so the case name still exists.
fn last_frag_data_readonly(_ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    Ok(())
}

fn invalid_inout_version(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_framebuffer_fetch_support(ctx)?;

    let fragment = "#version 100\n#extension GL_EXT_shader_framebuffer_fetch : require\ninout highp vec4 fragColor;\n\nvoid main (void)\n{\n    highp float product = dot(vec3(0.5), fragColor.rgb);\n    gl_FragColor = vec4(product);\n}\n";
    let program = ShaderProgram::new(
        ctx.gl(),
        &ProgramSources::vtx_frag(vertex_shader_source("#version 100"), fragment),
    );

    ctx.begin_section("A compile-time or link error is generated if user-defined inout arrays are used in earlier versions of GLSL before ES 3.0");
    verify_compile_or_link_error(ctx, &program, ShaderType::Fragment);
    ctx.end_section();
    Ok(())
}

fn invalid_redeclaration_inout(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_framebuffer_fetch_support(ctx)?;
    let version = ctx.glsl_version_decl();

    let fragment = format!(
        "{version}\n#extension GL_EXT_shader_framebuffer_fetch : require\nlayout(location = 0) out mediump vec4 fragColor;\ninout highp float gl_FragDepth;\n\nvoid main (void)\n{{\n    gl_FragDepth += 0.5f;\n    fragColor = vec4(1.0f);\n}}\n"
    );
    let program = ShaderProgram::new(
        ctx.gl(),
        &ProgramSources::vtx_frag(vertex_shader_source(version), fragment),
    );

    ctx.begin_section("A compile-time or link error is generated if re-declaring an existing fragment output such as gl_FragDepth as inout");
    verify_compile_or_link_error(ctx, &program, ShaderType::Fragment);
    ctx.end_section();
    Ok(())
}

fn invalid_vertex_inout(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_framebuffer_fetch_support(ctx)?;
    let version = ctx.glsl_version_decl();

    let vertex = format!(
        "{version}\n#extension GL_EXT_shader_framebuffer_fetch : require\ninout mediump vec4 v_color;\n\nvoid main (void)\n{{\n}}\n"
    );
    let program = ShaderProgram::new(
        ctx.gl(),
        &ProgramSources::vtx_frag(vertex, fragment_shader_source(version)),
    );

    ctx.begin_section(
        "A compile-time error or link error is generated if inout variables are declared in the vertex shader\n",
    );
    verify_compile_or_link_error(ctx, &program, ShaderType::Vertex);
    ctx.end_section();
    Ok(())
}

/// `getNegativeShaderFramebufferFetchTestFunctions`
pub static FUNCTIONS: &[FunctionContainer] = &[
    FunctionContainer {
        function: last_frag_data_not_defined,
        name: "last_frag_data_not_defined",
    },
    FunctionContainer {
        function: last_frag_data_readonly,
        name: "last_frag_data_readonly",
    },
    FunctionContainer {
        function: invalid_inout_version,
        name: "invalid_inout_version",
    },
    FunctionContainer {
        function: invalid_redeclaration_inout,
        name: "invalid_redeclaration_inout",
    },
    FunctionContainer {
        function: invalid_vertex_inout,
        name: "invalid_vertex_inout",
    },
];
