// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fNegativeSampleVariablesTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Every case here expects a compile
// failure, so upstream's `ExpectResult` (which has no `PASS` caller) is gone.

use crate::gles31::functional::negative_test_shared::{FunctionContainer, NegativeTestContext};
use crate::glu::ShaderType;
use crate::tcu::TestError;

/// The four built-ins and the statement that touches each, shared by most cases here.
const BUILT_INS: &[(&str, &str)] = &[
    (
        "gl_SampleID",
        "    lowp int writeValue = 1; \n    gl_SampleID = writeValue; \n",
    ),
    (
        "gl_SamplePosition",
        "    mediump vec2 writeValue = vec2(1.0f, 1.0f); \n    gl_SamplePosition = writeValue; \n",
    ),
    (
        "gl_SampleMaskIn",
        "    lowp int writeValue = 1; \n    gl_SampleMaskIn[0] = writeValue; \n",
    ),
    ("gl_SampleMask", "    highp int readValue = gl_SampleMask[0]; \n"),
];

/// `getVersionAndExtension`
fn version_and_extension(ctx: &NegativeTestContext<'_>) -> String {
    let mut source = format!("{} \n", ctx.glsl_version_decl());
    if !ctx.context_supports(3, 2) {
        source.push_str("#extension GL_OES_sample_variables : require \n");
    }
    source
}

/// `checkSupported`
fn check_supported(ctx: &NegativeTestContext<'_>) -> Result<(), TestError> {
    if ctx.context_supports(3, 2) || ctx.is_extension_supported("GL_OES_sample_variables") {
        Ok(())
    } else {
        Err(TestError::NotSupported(
            "GL_OES_sample_variables is not supported.".to_string(),
        ))
    }
}

fn write_to_read_only_types(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_supported(ctx)?;

    for (built_in, body) in &BUILT_INS[..3] {
        let shader = format!(
            "{}layout (location = 0) out mediump vec4 fs_color; \nvoid main() \n{{ \n{body}    fs_color = vec4(1.0f, 0.0f, 0.0f, 1.0f); \n}} \n",
            version_and_extension(ctx)
        );

        ctx.begin_section(&format!(
            "OES_sample_variables: trying to write to built-in read-only variable{built_in}"
        ));
        ctx.verify_shader_does_not_compile(ShaderType::Fragment, &shader);
        ctx.end_section();
    }
    Ok(())
}

fn access_built_in_types_inside_other_shaders(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_supported(ctx)?;

    let tessellation = ctx.is_extension_supported("GL_EXT_tessellation_shader")
        || ctx.is_extension_supported("GL_OES_tessellation_shader");
    let geometry =
        ctx.is_extension_supported("GL_EXT_geometry_shader") || ctx.is_extension_supported("GL_OES_geometry_shader");
    if !tessellation || !geometry {
        return Err(TestError::NotSupported(
            "tessellation and geometry shader extensions not supported".to_string(),
        ));
    }

    // Each stage's own preamble and trailing statement; the built-in access goes between.
    let stages: [(ShaderType, &str, &str, &str); 4] = [
        (
            ShaderType::Vertex,
            "vertex",
            "",
            "    gl_Position = vec4(1.0f, 0.0f, 0.0f , 1.0f); \n",
        ),
        (
            ShaderType::TessControl,
            "tessellation control",
            "layout (vertices = 3) out; \n",
            "",
        ),
        (
            ShaderType::TessEvaluation,
            "tessellation evaluation",
            "layout (triangles, equal_spacing, ccw) in; \n",
            "",
        ),
        (
            ShaderType::Geometry,
            "geometry",
            "layout (triangles) in; \nlayout (triangle_strip, max_vertices = 32) out; \n",
            "",
        ),
    ];

    for (shader_type, stage_name, preamble, trailer) in stages {
        for (built_in, body) in BUILT_INS {
            let shader = format!(
                "{}{preamble}void main () \n{{ \n{body}{trailer}}} \n",
                version_and_extension(ctx)
            );

            ctx.begin_section(&format!(
                "OES_sample_variables: trying to use fragment shader built-in sampler variable {built_in} inside {stage_name} shader"
            ));
            ctx.verify_shader_does_not_compile(shader_type, &shader);
            ctx.end_section();
        }
    }
    Ok(())
}

fn index_outside_sample_mask_range(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_supported(ctx)?;

    let invalid_indices = [
        "    const highp int invalidIndex = (gl_MaxSamples + 31) / 32; \n",
        "    const highp int invalidIndex = -1; \n",
    ];

    for built_in in ["gl_SampleMask", "gl_SampleMaskIn"] {
        for invalid_index in invalid_indices {
            let shader = format!(
                "{}layout (location = 0) out mediump vec4 fs_color; \nvoid main() \n{{ \n{invalid_index}    highp int invalidValue = {built_in}[invalidIndex]; \n    fs_color = vec4(1.0f, 0.0f, 0.0f, 1.0f); \n}} \n",
                version_and_extension(ctx)
            );

            ctx.begin_section(&format!(
                "OES_sample_variables: using constant integral expression outside of {built_in} bounds"
            ));
            ctx.verify_shader_does_not_compile(ShaderType::Fragment, &shader);
            ctx.end_section();
        }
    }
    Ok(())
}

fn access_built_in_types_without_extension(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_supported(ctx)?;

    for (built_in, body) in BUILT_INS {
        let shader = format!(
            "#version 310 es \nlayout (location = 0) out mediump vec4 fs_color; \nvoid main() \n{{ \n{body}    fs_color = vec4(1.0f, 0.0f, 0.0f, 1.0f); \n}} \n"
        );

        ctx.begin_section(&format!(
            "OES_sample_variables: accessing built-in type {built_in} in shader version 310 ES without required extension"
        ));
        ctx.verify_shader_does_not_compile(ShaderType::Fragment, &shader);
        ctx.end_section();
    }
    Ok(())
}

fn redeclare_built_in_types(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_supported(ctx)?;

    for (built_in, _) in BUILT_INS {
        let shader = format!(
            "{}layout (location = 0) out mediump vec4 fs_color; \nuniform lowp int {built_in}; \nvoid main() \n{{ \n    if ({built_in} == 0) \n        fs_color = vec4(1.0f, 0.0f, 0.0f, 1.0f); \n    else \n        fs_color = vec4(0.0f, 1.0f, 0.0f, 1.0f); \n}} \n",
            version_and_extension(ctx)
        );

        ctx.begin_section(&format!("OES_sample_variables: redeclare built-in type {built_in}"));
        ctx.verify_shader_does_not_compile(ShaderType::Fragment, &shader);
        ctx.end_section();
    }
    Ok(())
}

/// `getNegativeSampleVariablesTestFunctions`
pub static FUNCTIONS: &[FunctionContainer] = &[
    FunctionContainer {
        function: write_to_read_only_types,
        name: "write_to_read_only_types",
    },
    FunctionContainer {
        function: access_built_in_types_inside_other_shaders,
        name: "access_built_in_types_inside_other_shaders",
    },
    FunctionContainer {
        function: index_outside_sample_mask_range,
        name: "index_outside_sample_mask_range",
    },
    FunctionContainer {
        function: access_built_in_types_without_extension,
        name: "access_built_in_types_without_extension",
    },
    FunctionContainer {
        function: redeclare_built_in_types,
        name: "redeclare_built_in_types",
    },
];
