// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fNegativeShaderDirectiveTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Every shader here is deliberately written against `#version 310 es` without the
// `#extension` line the feature it uses needs, which is what makes it fail to compile.

use crate::gles31::functional::negative_test_shared::{FunctionContainer, NegativeTestContext};
use crate::glu::{ProgramSources, ShaderProgram, ShaderType};
use crate::tcu::TestError;

/// `verifyProgram(EXPECT_RESULT_FAIL)`
fn verify_program_does_not_link(ctx: &mut NegativeTestContext<'_>, sources: &ProgramSources) {
    let program = ShaderProgram::new(ctx.gl(), sources);
    if program.program_info.ok {
        ctx.fail("Program was not expected to link.");
    }
}

/// `verifyShader(EXPECT_RESULT_PASS)`
fn verify_shader_compiles(ctx: &mut NegativeTestContext<'_>, shader_type: ShaderType, source: &str) {
    if !ctx.compile_shader(shader_type, source) {
        ctx.fail("Shader did not compile.");
    }
}

/// The `void main() {}` vertex and fragment shader the two program cases pair their
/// stage under test with.
const SIMPLE_VTX_FRAG: &str = "#version 310 es\nvoid main()\n{\n}\n";

fn primitive_bounding_box(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if ctx.is_shader_supported(ShaderType::TessControl) {
        ctx.begin_section("GL_EXT_primitive_bounding_box features require enabling the extension in 310 es shaders.");
        let source = "#version 310 es\nvoid main()\n{\n    gl_BoundingBoxEXT[0] = vec4(0.0, 0.0, 0.0, 0.0);\n    gl_BoundingBoxEXT[1] = vec4(1.0, 1.0, 1.0, 1.0);\n}\n";
        ctx.verify_shader_does_not_compile(ShaderType::TessControl, source);
        ctx.end_section();
    }

    if ctx.context_supports(3, 2) {
        ctx.begin_section("gl_BoundingBox does not require the OES/EXT suffix in a 320 es shader.");
        verify_shader_compiles(
            ctx,
            ShaderType::TessControl,
            "#version 320 es\nlayout(vertices = 3) out;\nvoid main()\n{\n    gl_BoundingBox[0] = vec4(0.0, 0.0, 0.0, 0.0);\n    gl_BoundingBox[1] = vec4(0.0, 0.0, 0.0, 0.0);\n}\n",
        );
        ctx.end_section();

        ctx.begin_section("Invalid index used when assigning to gl_BoundingBox in 320 es shader.");
        ctx.verify_shader_does_not_compile(
            ShaderType::TessControl,
            "#version 320 es\nlayout(vertices = 3) out;\nvoid main()\n{\n    gl_BoundingBox[0] = vec4(0.0, 0.0, 0.0, 0.0);\n    gl_BoundingBox[2] = vec4(0.0, 0.0, 0.0, 0.0);\n}\n",
        );
        ctx.end_section();

        ctx.begin_section("Invalid type assignment to per-patch output array in 320 es shader.");
        ctx.verify_shader_does_not_compile(
            ShaderType::TessControl,
            "#version 320 es\nlayout(vertices = 3) out;\nvoid main()\n{\n    gl_BoundingBox[0] = ivec4(0, 0, 0, 0);\n    gl_BoundingBox[1] = ivec4(0, 0, 0, 0);\n}\n",
        );
        ctx.end_section();
    }
    Ok(())
}

fn blend_equation_advanced(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    const QUALIFIERS: &[&str] = &[
        "blend_support_multiply",
        "blend_support_screen",
        "blend_support_overlay",
        "blend_support_darken",
        "blend_support_lighten",
        "blend_support_colordodge",
        "blend_support_colorburn",
        "blend_support_hardlight",
        "blend_support_softlight",
        "blend_support_difference",
        "blend_support_exclusion",
        "blend_support_hsl_hue",
        "blend_support_hsl_saturation",
        "blend_support_hsl_color",
        "blend_support_hsl_luminosity",
    ];

    ctx.begin_section("GL_KHR_blend_equation_advanced features require enabling the extension in 310 es shaders.");
    for qualifier in QUALIFIERS {
        let source = format!("#version 310 es\nlayout({qualifier}) out;\nvoid main()\n{{\n}}\n");
        ctx.verify_shader_does_not_compile(ShaderType::Fragment, &source);
    }
    ctx.end_section();
    Ok(())
}

fn sample_variables(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if !ctx.context_supports(3, 2) {
        return Err(TestError::NotSupported(
            "Test requires a context version 3.2 or higher.".to_string(),
        ));
    }

    const TESTS: &[&str] = &[
        "int sampleId = gl_SampleID;",
        "vec2 samplePos = gl_SamplePosition;",
        "int sampleMaskIn0 = gl_SampleMaskIn[0];",
        "int sampleMask0 = gl_SampleMask[0];",
        "int numSamples = gl_NumSamples;",
    ];

    ctx.begin_section("GL_OES_sample_variables features require enabling the extension in 310 es shaders.");
    for test in TESTS {
        let source = format!("#version 310 es\nprecision mediump float;\nvoid main()\n{{\n    {test}\n}}\n");
        ctx.verify_shader_does_not_compile(ShaderType::Fragment, &source);
    }
    ctx.end_section();
    Ok(())
}

fn shader_image_atomic(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    const TESTS: &[&str] = &[
        "imageAtomicAdd(u_image, ivec2(1, 1), 1u);",
        "imageAtomicMin(u_image, ivec2(1, 1), 1u);",
        "imageAtomicMax(u_image, ivec2(1, 1), 1u);",
        "imageAtomicAnd(u_image, ivec2(1, 1), 1u);",
        "imageAtomicOr(u_image, ivec2(1, 1), 1u);",
        "imageAtomicXor(u_image, ivec2(1, 1), 1u);",
        "imageAtomicExchange(u_image, ivec2(1, 1), 1u);",
        "imageAtomicCompSwap(u_image, ivec2(1, 1), 1u, 1u);",
    ];

    ctx.begin_section("GL_OES_shader_image_atomic features require enabling the extension in 310 es shaders.");
    for test in TESTS {
        let source = format!(
            "#version 310 es\nlayout(binding=0, r32ui) coherent uniform highp uimage2D u_image;\nprecision mediump float;\nvoid main()\n{{\n    {test}\n}}\n"
        );
        ctx.verify_shader_does_not_compile(ShaderType::Fragment, &source);
    }
    ctx.end_section();
    Ok(())
}

fn shader_multisample_interpolation(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    const SAMPLE_TESTS: &[&str] = &["sample in highp float v_var;", "sample out highp float v_var;"];
    const INTERPOLATE_AT_TESTS: &[&str] = &[
        "interpolateAtCentroid(interpolant);",
        "interpolateAtSample(interpolant, 1);",
        "interpolateAtOffset(interpolant, vec2(1.0, 0.0));",
    ];

    ctx.begin_section(
        "GL_OES_shader_multisample_interpolation features require enabling the extension in 310 es shaders.",
    );

    ctx.begin_section("Test sample in/out qualifiers.");
    for test in SAMPLE_TESTS {
        let source = format!("#version 310 es\n    {test}\nprecision mediump float;\nvoid main()\n{{\n}}\n");
        ctx.verify_shader_does_not_compile(ShaderType::Fragment, &source);
    }
    ctx.end_section();

    // \note upstream's second loop bounds itself by `s_sampleTests` while indexing
    // `s_interpolateAtTests`, so only the first two of the three ever run. Kept as is:
    // the third would fail the same way, and running it would be a third case's worth of
    // divergence from what upstream actually executes.
    ctx.begin_section("Test interpolateAt* functions.");
    for test in &INTERPOLATE_AT_TESTS[..SAMPLE_TESTS.len()] {
        let source = format!(
            "#version 310 es\nin mediump float interpolant;\nprecision mediump float;\nvoid main()\n{{\n    {test}\n}}\n"
        );
        ctx.verify_shader_does_not_compile(ShaderType::Fragment, &source);
    }
    ctx.end_section();

    ctx.end_section();
    Ok(())
}

fn texture_storage_multisample_2d_array(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    const SAMPLER_TYPES: &[&str] = &[
        "uniform mediump sampler2DMSArray u_sampler;",
        "uniform mediump isampler2DMSArray u_sampler;",
        "uniform mediump usampler2DMSArray u_sampler;",
    ];

    ctx.begin_section(
        "GL_OES_texture_storage_multisample_2d_array features require enabling the extension in 310 es shaders.",
    );
    for sampler in SAMPLER_TYPES {
        let source = format!("#version 310 es\n    {sampler}\nprecision mediump float;\nvoid main()\n{{\n}}\n");
        ctx.verify_shader_does_not_compile(ShaderType::Fragment, &source);
    }
    ctx.end_section();
    Ok(())
}

fn geometry_shader(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if !ctx.is_shader_supported(ShaderType::Geometry) {
        return Ok(());
    }

    let geometry = "#version 310 es\nlayout(points, invocations = 1) in;\nlayout(points, max_vertices = 3) out;\nprecision mediump float;\nvoid main()\n{\n    EmitVertex();\n    EndPrimitive();\n}\n";
    let sources = ProgramSources::vtx_frag(SIMPLE_VTX_FRAG, SIMPLE_VTX_FRAG).with(ShaderType::Geometry, geometry);

    ctx.begin_section("GL_EXT_geometry_shader features require enabling the extension in 310 es shaders.");
    verify_program_does_not_link(ctx, &sources);
    ctx.end_section();
    Ok(())
}

fn gpu_shader_5(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_EXT_gpu_shader5 features require enabling the extension in 310 es shaders.");

    ctx.begin_section("Testing the precise qualifier.");
    ctx.verify_shader_does_not_compile(
        ShaderType::Fragment,
        "#version 310 es\nvoid main()\n{\n    int low = 0;\n    int high = 10;\n    precise int middle = low + ((high - low) / 2);\n}\n",
    );
    ctx.end_section();

    ctx.begin_section("Testing fused multiply-add.");
    ctx.verify_shader_does_not_compile(
        ShaderType::Fragment,
        "#version 310 es\nin mediump float v_var;void main()\n{\n    float fmaResult = fma(v_var, v_var, v_var);}\n",
    );
    ctx.end_section();

    ctx.begin_section("Testing textureGatherOffsets.");
    ctx.verify_shader_does_not_compile(
        ShaderType::Fragment,
        "#version 310 es\nuniform mediump sampler2D u_tex;\nvoid main()\n{\n    highp vec2 coords = vec2(0.0, 1.0);\n    const ivec2 offsets[4] = ivec2[](ivec2(0,0), ivec2(1, 0), ivec2(0, 1), ivec2(1, 1));\n    textureGatherOffsets(u_tex, coords, offsets);\n}\n",
    );
    ctx.end_section();

    ctx.end_section();
    Ok(())
}

fn shader_io_blocks(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("GL_EXT_shader_io_blocks features require enabling the extension in 310 es shaders.");
    ctx.verify_shader_does_not_compile(
        ShaderType::Fragment,
        "#version 310 es\nin Data\n{\n    mediump vec3 a;\n} data;\nvoid main()\n{\n}\n",
    );
    ctx.end_section();
    Ok(())
}

fn tessellation_shader(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if !ctx.is_shader_supported(ShaderType::TessControl) {
        return Ok(());
    }

    let tess_control = "#version 310 es\nlayout(vertices = 3) out;\nvoid main()\n{\n}\n";
    let tess_evaluation = "#version 310 es\nlayout(triangles, equal_spacing, cw) in;\nvoid main()\n{\n}\n";
    let sources = ProgramSources::vtx_frag(SIMPLE_VTX_FRAG, SIMPLE_VTX_FRAG)
        .with(ShaderType::TessControl, tess_control)
        .with(ShaderType::TessEvaluation, tess_evaluation);

    ctx.begin_section("GL_EXT_tessellation_shader features require enabling the extension in 310 es shaders.");
    verify_program_does_not_link(ctx, &sources);
    ctx.end_section();
    Ok(())
}

fn texture_buffer(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    const TYPES: &[&str] = &[
        "uniform mediump samplerBuffer",
        "uniform mediump isamplerBuffer",
        "uniform mediump usamplerBuffer",
        "layout(rgba32f) uniform mediump writeonly imageBuffer",
        "layout(rgba32i) uniform mediump writeonly iimageBuffer",
        "layout(rgba32ui) uniform mediump writeonly uimageBuffer",
    ];

    ctx.begin_section("GL_EXT_texture_buffer features require enabling the extension in 310 es shaders.");
    for ty in TYPES {
        let source = format!("#version 310 es\n{ty} u_buffer;\nvoid main()\n{{\n}}\n");
        ctx.verify_shader_does_not_compile(ShaderType::Fragment, &source);
    }
    ctx.end_section();
    Ok(())
}

fn texture_cube_map_array(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    const TYPES: &[&str] = &[
        "uniform mediump samplerCubeArray",
        "uniform mediump isamplerCubeArray",
        "uniform mediump usamplerCubeArray",
        "uniform mediump samplerCubeArrayShadow",
        "layout(rgba32f) uniform mediump writeonly imageCubeArray",
        "layout(rgba32i) uniform mediump writeonly iimageCubeArray",
        "layout(rgba32ui) uniform mediump writeonly uimageCubeArray",
    ];

    ctx.begin_section("GL_EXT_texture_cube_map_array features require enabling the extension in 310 es shaders.");
    for ty in TYPES {
        let source = format!("#version 310 es\n{ty} u_cube;\nvoid main()\n{{\n}}\n");
        ctx.verify_shader_does_not_compile(ShaderType::Fragment, &source);
    }
    ctx.end_section();
    Ok(())
}

/// `executeAccessingBoundingBoxType`
fn execute_accessing_bounding_box_type(ctx: &mut NegativeTestContext<'_>, built_in: &str, version: &str, es31: bool) {
    let extension_prim = if es31 {
        "#extension GL_EXT_primitive_bounding_box : require\n"
    } else {
        ""
    };
    let extension_tess = if es31 {
        "#extension GL_EXT_tessellation_shader : require\n"
    } else {
        ""
    };

    ctx.begin_section(&format!("cannot access built-in type {built_in}[] in vertex shader"));
    let source = format!(
        "{version}{extension_prim}void main()\n{{\n    {built_in}[0] = vec4(1.0, 1.0, 1.0, 1.0);\n    gl_Position = {built_in}[0];\n}}\n"
    );
    ctx.verify_shader_does_not_compile(ShaderType::Vertex, &source);
    ctx.end_section();

    if ctx.is_shader_supported(ShaderType::TessEvaluation) {
        ctx.begin_section(&format!(
            "cannot access built-in type {built_in}[] in tessellation evaluation shader"
        ));
        let source = format!(
            "{version}{extension_prim}{extension_tess}layout (triangles, equal_spacing, ccw) in;\nvoid main()\n{{\n    {built_in}[0] = vec4(1.0, 1.0, 1.0, 1.0);\n    gl_Position = (    gl_TessCoord.x * {built_in}[0] +\n                    gl_TessCoord.y * {built_in}[0] +\n                    gl_TessCoord.z * {built_in}[0]);\n}}\n"
        );
        ctx.verify_shader_does_not_compile(ShaderType::TessEvaluation, &source);
        ctx.end_section();
    }

    if ctx.is_shader_supported(ShaderType::Geometry) {
        ctx.begin_section(&format!("cannot access built-in type {built_in}[] in geometry shader"));
        let source = format!(
            "{version}{extension_prim}layout (triangles) in;\nlayout (triangle_strip, max_vertices = 3) out;\nvoid main()\n{{\n    {built_in}[0] = vec4(1.0, 1.0, 1.0, 1.0);\n    for (int idx = 0; idx < 3; idx++)\n    {{\n        gl_Position = gl_in[idx].gl_Position * {built_in}[0];\n        EmitVertex();\n    }}\n    EndPrimitive();\n}}\n"
        );
        ctx.verify_shader_does_not_compile(ShaderType::Geometry, &source);
        ctx.end_section();
    }

    ctx.begin_section(&format!("cannot access built-in type {built_in}[] in fragment shader"));
    let source = format!(
        "{version}{extension_prim}layout (location = 0) out mediump vec4 fs_colour;\nvoid main()\n{{\n    {built_in}[0] = vec4(1.0, 1.0, 1.0, 1.0);\n    fs_colour = {built_in}[0];\n}}\n"
    );
    ctx.verify_shader_does_not_compile(ShaderType::Fragment, &source);
    ctx.end_section();
}

fn accessing_bounding_box_type(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    // The built-in loses its EXT suffix in ES 3.2, where it became core.
    if ctx.context_supports(3, 2) {
        execute_accessing_bounding_box_type(ctx, "gl_BoundingBox", "#version 320 es\n", false);
    } else {
        execute_accessing_bounding_box_type(ctx, "gl_BoundingBoxEXT", "#version 310 es\n", true);
    }
    Ok(())
}

/// `getNegativeShaderDirectiveTestFunctions`
pub static FUNCTIONS: &[FunctionContainer] = &[
    FunctionContainer {
        function: primitive_bounding_box,
        name: "primitive_bounding_box",
    },
    FunctionContainer {
        function: blend_equation_advanced,
        name: "blend_equation_advanced",
    },
    FunctionContainer {
        function: sample_variables,
        name: "sample_variables",
    },
    FunctionContainer {
        function: shader_image_atomic,
        name: "shader_image_atomic",
    },
    FunctionContainer {
        function: shader_multisample_interpolation,
        name: "shader_multisample_interpolation",
    },
    FunctionContainer {
        function: texture_storage_multisample_2d_array,
        name: "texture_storage_multisample_2d_array",
    },
    FunctionContainer {
        function: geometry_shader,
        name: "geometry_shader",
    },
    FunctionContainer {
        function: gpu_shader_5,
        name: "gpu_shader_5",
    },
    FunctionContainer {
        function: shader_io_blocks,
        name: "shader_io_blocks",
    },
    FunctionContainer {
        function: tessellation_shader,
        name: "tessellation_shader",
    },
    FunctionContainer {
        function: texture_buffer,
        name: "texture_buffer",
    },
    FunctionContainer {
        function: texture_cube_map_array,
        name: "texture_cube_map_array",
    },
    FunctionContainer {
        function: accessing_bounding_box_type,
        name: "accessing_bounding_box_type",
    },
];
