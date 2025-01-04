// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fNegativeAtomicCounterTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::gles31::functional::negative_test_shared::{FunctionContainer, NegativeTestContext};
use crate::glu::ShaderType;
use crate::glw;
use crate::tcu::TestError;

/// `TestCase`
#[derive(Clone, Copy, PartialEq, Eq)]
enum Case {
    LayoutLargeBinding,
    LayoutMediumpPrecision,
    LayoutLowpPrecision,
    LayoutBindingOffsetOverlap,
    LayoutBindingOmitted,
    Struct,
    BodyWrite,
    BodyDeclare,
}

/// `s_shaders`
const SHADERS: &[ShaderType] = &[
    ShaderType::Vertex,
    ShaderType::Fragment,
    ShaderType::Geometry,
    ShaderType::TessControl,
    ShaderType::TessEvaluation,
    ShaderType::Compute,
];

/// `genShaderSource` - pinned to `#version 310 es` upstream, on every context.
fn gen_shader_source(ctx: &NegativeTestContext<'_>, test: Case, ty: ShaderType) -> String {
    let max_buffers = ctx.get_integer(glw::GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS);
    let mut shader = String::from("#version 310 es\n");

    match ty {
        ShaderType::Geometry => {
            shader.push_str("#extension GL_EXT_geometry_shader : enable\n");
            shader.push_str("layout(max_vertices = 3) out;\n");
        }
        ShaderType::TessControl | ShaderType::TessEvaluation => {
            shader.push_str("#extension GL_EXT_tessellation_shader : enable\n");
        }
        _ => {}
    }

    match test {
        Case::LayoutLargeBinding => {
            shader.push_str(&format!(
                "layout (binding = {max_buffers}, offset = 0) uniform atomic_uint counter0;\n"
            ));
        }
        Case::LayoutMediumpPrecision => {
            shader.push_str("layout (binding = 1, offset = 0) mediump uniform atomic_uint counter0;\n");
        }
        Case::LayoutLowpPrecision => {
            shader.push_str("layout (binding = 1, offset = 0) lowp uniform atomic_uint counter0;\n");
        }
        Case::LayoutBindingOffsetOverlap => {
            shader.push_str("layout (binding = 1, offset = 0) uniform atomic_uint counter0;\nlayout (binding = 1, offset = 2) uniform atomic_uint counter1;\n");
        }
        Case::LayoutBindingOmitted => shader.push_str("layout (offset = 0) uniform atomic_uint counter0;\n"),
        Case::Struct => shader.push_str("struct\n{\n  int a;\n  atomic_uint counter;\n} S;\n"),
        Case::BodyWrite => shader.push_str("layout (binding = 1) uniform atomic_uint counter;\n"),
        Case::BodyDeclare => {}
    }

    shader.push_str("void main (void)\n{\n");

    match test {
        Case::BodyWrite => shader.push_str("counter = 1;\n"),
        Case::BodyDeclare => shader.push_str("atomic_uint counter;\n"),
        _ => {}
    }

    shader.push_str("}\n");
    shader
}

/// `iterateShaders`
fn iterate_shaders(ctx: &mut NegativeTestContext<'_>, test: Case) {
    for &shader_type in SHADERS {
        if ctx.is_shader_supported(shader_type) {
            ctx.begin_section(&format!("Verify shader: {}", shader_type.as_str()));
            let source = gen_shader_source(ctx, test, shader_type);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            ctx.end_section();
        }
    }
}

fn run(ctx: &mut NegativeTestContext<'_>, section: &str, tests: &[Case]) -> Result<(), TestError> {
    ctx.begin_section(section);
    for &test in tests {
        iterate_shaders(ctx, test);
    }
    ctx.end_section();
    Ok(())
}

fn atomic_max_counter_bindings(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    run(
        ctx,
        "It is a compile-time error to bind an atomic counter with a binding value greater than or equal to gl_MaxAtomicCounterBindings.",
        &[Case::LayoutLargeBinding],
    )
}

fn atomic_precision(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    run(
        ctx,
        "It is an error to declare an atomic type with a lowp or mediump precision.",
        &[Case::LayoutMediumpPrecision, Case::LayoutLowpPrecision],
    )
}

fn atomic_binding_offset_overlap(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    run(
        ctx,
        "Atomic counters may not have overlapping offsets in the same binding.",
        &[Case::LayoutBindingOffsetOverlap],
    )
}

fn atomic_binding_omitted(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    run(
        ctx,
        "Atomic counters must specify a binding point",
        &[Case::LayoutBindingOmitted],
    )
}

fn atomic_struct(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    run(ctx, "Structures may not have an atomic_uint variable.", &[Case::Struct])
}

fn atomic_body_write(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    run(
        ctx,
        "An atomic_uint variable cannot be directly written to.",
        &[Case::BodyWrite],
    )
}

fn atomic_body_declare(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    run(
        ctx,
        "An atomic_uint variable cannot be declared in local scope",
        &[Case::BodyDeclare],
    )
}

/// `getNegativeAtomicCounterTestFunctions`
pub static FUNCTIONS: &[FunctionContainer] = &[
    FunctionContainer {
        function: atomic_max_counter_bindings,
        name: "atomic_max_counter_bindings",
    },
    FunctionContainer {
        function: atomic_precision,
        name: "atomic_precision",
    },
    FunctionContainer {
        function: atomic_binding_offset_overlap,
        name: "atomic_binding_offset_overlap",
    },
    FunctionContainer {
        function: atomic_binding_omitted,
        name: "atomic_binding_omitted",
    },
    FunctionContainer {
        function: atomic_struct,
        name: "atomic_struct",
    },
    FunctionContainer {
        function: atomic_body_write,
        name: "atomic_body_write",
    },
    FunctionContainer {
        function: atomic_body_declare,
        name: "atomic_body_declare",
    },
];
