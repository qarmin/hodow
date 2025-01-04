// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fNegativePreciseTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::gles31::functional::negative_test_shared::{FunctionContainer, NegativeTestContext};
use crate::glu::ShaderType;
use crate::tcu::TestError;

/// `TestPrecise`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestPrecise {
    Variable,
    Function,
    Argument,
}

/// `s_shaderTypes`
const SHADER_TYPES: &[ShaderType] = &[
    ShaderType::Vertex,
    ShaderType::Fragment,
    ShaderType::Geometry,
    ShaderType::Compute,
    ShaderType::TessControl,
    ShaderType::TessEvaluation,
];

/// `generateShaderSource`
fn generate_shader_source(ctx: &NegativeTestContext<'_>, shader_type: ShaderType, test: TestPrecise) -> String {
    let mut source = format!(
        "{}\n{}",
        ctx.glsl_version_decl(),
        ctx.extension_directive("GL_EXT_gpu_shader5")
    );

    match shader_type {
        ShaderType::Geometry => {
            source.push_str(&ctx.extension_directive("GL_EXT_geometry_shader"));
            source.push_str("layout(max_vertices = 5) out;\n");
        }
        ShaderType::TessControl => {
            source.push_str(&ctx.extension_directive("GL_EXT_tessellation_shader"));
            source.push_str("layout(vertices = 3) out;\n");
        }
        ShaderType::TessEvaluation => {
            source.push_str(&ctx.extension_directive("GL_EXT_tessellation_shader"));
            source.push_str("layout(triangles, equal_spacing, cw) in;\n");
        }
        _ => {}
    }

    match test {
        TestPrecise::Function => source.push_str("\nvoid precise()\n{\n}\n"),
        TestPrecise::Argument => source.push_str("\nvoid example(int precise)\n{\n}\n"),
        TestPrecise::Variable => {}
    }

    source.push_str("void main()\n{\n");
    if test == TestPrecise::Variable {
        source.push_str("    int precise = 1;\n");
    }
    source.push_str("}\n");

    source
}

/// `checkSupport`
fn check_support(ctx: &NegativeTestContext<'_>) -> Result<(), TestError> {
    if ctx.is_extension_supported("GL_EXT_gpu_shader5") || ctx.context_supports(3, 2) {
        Ok(())
    } else {
        Err(TestError::NotSupported(
            "This test requires support for the extension GL_EXT_gpu_shader5 or context version 3.2 or higher."
                .to_string(),
        ))
    }
}

fn run(ctx: &mut NegativeTestContext<'_>, section: &str, test: TestPrecise) -> Result<(), TestError> {
    check_support(ctx)?;

    ctx.begin_section(section);
    for &shader_type in SHADER_TYPES {
        if ctx.is_shader_supported(shader_type) {
            let source = generate_shader_source(ctx, shader_type, test);
            ctx.verify_shader_does_not_compile(shader_type, &source);
        }
    }
    ctx.end_section();
    Ok(())
}

fn precise_as_variable_name(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    run(
        ctx,
        "Test that precise cannot be used as a variable name.",
        TestPrecise::Variable,
    )
}

fn precise_as_function_name(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    run(
        ctx,
        "Test that precise cannot be used as a function name.",
        TestPrecise::Function,
    )
}

fn precise_as_function_argument(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    run(
        ctx,
        "Test that precise cannot be used as a argument name.",
        TestPrecise::Argument,
    )
}

/// `getNegativePreciseTestFunctions`
pub static FUNCTIONS: &[FunctionContainer] = &[
    FunctionContainer {
        function: precise_as_variable_name,
        name: "precise_as_variable_name",
    },
    FunctionContainer {
        function: precise_as_function_name,
        name: "precise_as_function_name",
    },
    FunctionContainer {
        function: precise_as_function_argument,
        name: "precise_as_function_argument",
    },
];
