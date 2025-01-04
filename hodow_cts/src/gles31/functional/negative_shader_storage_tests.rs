// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fNegativeShaderStorageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream indexes its sources by the GL
// shader enum and converts back and forth with `getGLUShaderType`; here `glu::ShaderType`
// is the only spelling, so those two conversions are gone.

use crate::gles31::functional::negative_test_shared::{FunctionContainer, NegativeTestContext};
use crate::glu::{ProgramSources, ShaderProgram, ShaderType};
use crate::glw;
use crate::tcu::TestError;

/// `verifyProgram`
fn verify_program(ctx: &mut NegativeTestContext<'_>, sources: &ProgramSources) {
    let program = ShaderProgram::new(ctx.gl(), sources);
    if program.program_info.ok {
        ctx.fail("Program was not expected to link.");
    }
}

/// `getShaderExtensionDeclaration`
fn shader_extension_declaration(ctx: &NegativeTestContext<'_>, shader_type: ShaderType) -> &'static str {
    if ctx.context_supports(3, 2) {
        return "";
    }

    match shader_type {
        ShaderType::TessControl | ShaderType::TessEvaluation => "#extension GL_EXT_tessellation_shader : require\n",
        ShaderType::Geometry => "#extension GL_EXT_geometry_shader : require\n",
        _ => "",
    }
}

/// `getMaxSSBlockSizeEnum`
fn max_ss_block_size_enum(shader_type: ShaderType) -> glw::GLenum {
    match shader_type {
        ShaderType::Vertex => glw::GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS,
        ShaderType::Fragment => glw::GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS,
        ShaderType::TessControl => glw::GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS,
        ShaderType::TessEvaluation => glw::GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS,
        ShaderType::Geometry => glw::GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS,
        ShaderType::Compute => glw::GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS,
    }
}

/// `getMaxSSBlockSize`
fn max_ss_block_size(ctx: &NegativeTestContext<'_>, shader_type: ShaderType) -> i32 {
    ctx.get_integer(max_ss_block_size_enum(shader_type))
}

/// `genBlockSource`
fn gen_block_source(ctx: &NegativeTestContext<'_>, num_ss_blocks: i64, shader_type: ShaderType) -> String {
    let mut source = format!(
        "{}\n{}",
        ctx.glsl_version_decl(),
        shader_extension_declaration(ctx, shader_type)
    );

    match shader_type {
        ShaderType::Vertex | ShaderType::Fragment => {}
        ShaderType::Compute => source.push_str("layout (local_size_x = 1) in;\n"),
        ShaderType::Geometry => source.push_str("layout(points) in;\nlayout(line_strip, max_vertices = 3) out;\n"),
        ShaderType::TessControl => source.push_str("layout(vertices = 10) out;\n"),
        ShaderType::TessEvaluation => source.push_str("layout(triangles) in;\n"),
    }

    source.push_str(&format!(
        "\nlayout(std430, binding = 0) buffer Block {{\n    int value;\n}} sb_in[{num_ss_blocks}];\nvoid main(void) {{ sb_in[0].value = 1; }}\n"
    ));

    source
}

/// `genCommonSource`
fn gen_common_source(ctx: &NegativeTestContext<'_>, shader_type: ShaderType) -> String {
    let mut source = format!(
        "{}\n{}",
        ctx.glsl_version_decl(),
        shader_extension_declaration(ctx, shader_type)
    );

    match shader_type {
        ShaderType::TessControl => source.push_str("layout(vertices = 3) out;\nvoid main() {}\n"),
        ShaderType::TessEvaluation => source.push_str("layout(triangles, equal_spacing, cw) in;\nvoid main() {}\n"),
        _ => source.push_str("void main() {}\n"),
    }

    source
}

/// `genMaxSSBlocksSource` - appends a shader declaring exactly the per-stage limit and
/// answers how many blocks that was.
fn gen_max_ss_blocks_source(
    ctx: &NegativeTestContext<'_>,
    shader_type: ShaderType,
    sources: ProgramSources,
) -> (ProgramSources, i32) {
    let max_ss_blocks = max_ss_block_size(ctx, shader_type);
    let source = gen_block_source(ctx, i64::from(max_ss_blocks), shader_type);
    (sources.with(shader_type, source), max_ss_blocks)
}

fn block_number_limits(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let shader_types = [
        ShaderType::Vertex,
        ShaderType::Fragment,
        ShaderType::TessControl,
        ShaderType::TessEvaluation,
        ShaderType::Geometry,
        ShaderType::Compute,
    ];

    let vert_source = gen_common_source(ctx, ShaderType::Vertex);
    let frag_source = gen_common_source(ctx, ShaderType::Fragment);
    let tess_control_source = gen_common_source(ctx, ShaderType::TessControl);
    let tess_eval_source = gen_common_source(ctx, ShaderType::TessEvaluation);

    for shader_type in shader_types {
        ctx.begin_section("maxShaderStorageBlocks: Exceed limits");

        if !ctx.is_shader_supported(shader_type) {
            ctx.end_section();
            continue;
        }

        let max_ss_blocks = max_ss_block_size(ctx, shader_type);
        if max_ss_blocks == 0 {
            ctx.end_section();
            continue;
        }

        let source = gen_block_source(ctx, i64::from(max_ss_blocks) + 1, shader_type);
        let sources = match shader_type {
            ShaderType::Vertex => ProgramSources::vtx_frag(source, frag_source.clone()),
            ShaderType::Fragment => ProgramSources::vtx_frag(vert_source.clone(), source),
            ShaderType::TessControl => ProgramSources::vtx_frag(vert_source.clone(), frag_source.clone())
                .with(ShaderType::TessControl, source)
                .with(ShaderType::TessEvaluation, tess_eval_source.clone()),
            ShaderType::TessEvaluation => ProgramSources::vtx_frag(vert_source.clone(), frag_source.clone())
                .with(ShaderType::TessControl, tess_control_source.clone())
                .with(ShaderType::TessEvaluation, source),
            ShaderType::Geometry => {
                ProgramSources::vtx_frag(vert_source.clone(), frag_source.clone()).with(ShaderType::Geometry, source)
            }
            ShaderType::Compute => ProgramSources::compute(source),
        };

        verify_program(ctx, &sources);
        ctx.end_section();
    }
    Ok(())
}

fn max_combined_block_number_limit(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    ctx.begin_section("maxCombinedShaderStorageBlocks: Exceed limits");

    let mut sources = ProgramSources::default();
    let mut combined = 0;

    for shader_type in [ShaderType::Vertex, ShaderType::Fragment] {
        let (next, count) = gen_max_ss_blocks_source(ctx, shader_type, sources);
        sources = next;
        combined += count;
    }

    if ctx.is_shader_supported(ShaderType::TessControl) && ctx.is_shader_supported(ShaderType::TessEvaluation) {
        for shader_type in [ShaderType::TessControl, ShaderType::TessEvaluation] {
            let (next, count) = gen_max_ss_blocks_source(ctx, shader_type, sources);
            sources = next;
            combined += count;
        }
    }

    if ctx.is_shader_supported(ShaderType::Geometry) {
        let (next, count) = gen_max_ss_blocks_source(ctx, ShaderType::Geometry, sources);
        sources = next;
        combined += count;
    }

    let max_combined = ctx.get_integer(glw::GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS);
    log::debug!("GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS: {max_combined}");
    log::debug!("Combined shader storage blocks: {combined}");

    if combined > max_combined {
        verify_program(ctx, &sources);
    } else {
        log::debug!("Test skipped: Combined shader storage blocks < GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS: ");
    }

    ctx.end_section();
    Ok(())
}

/// `getNegativeShaderStorageTestFunctions`
pub static FUNCTIONS: &[FunctionContainer] = &[
    FunctionContainer {
        function: block_number_limits,
        name: "block_number_limits",
    },
    FunctionContainer {
        function: max_combined_block_number_limit,
        name: "max_combined_block_number_limit",
    },
];
