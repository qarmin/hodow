// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fNegativeTessellationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `${GLSL_PER_VERTEX_*}` placeholders
// upstream substitutes are only ever non-empty on a desktop-GL context, so they are gone
// here along with the `!isContextTypeES` branches.

use crate::gles31::functional::negative_test_shared::{BAD_ENUM, FunctionContainer, NegativeTestContext};
use crate::glu::{ProgramPipeline, ProgramSources, ShaderProgram, ShaderType};
use crate::glw::{self, GLint};
use crate::tcu::TestError;

/// `GLSL_TESS_EXTENSION_STRING`
fn tess_extension(ctx: &NegativeTestContext<'_>) -> &'static str {
    if ctx.context_supports(3, 2) {
        ""
    } else {
        "#extension GL_EXT_tessellation_shader : require"
    }
}

/// `vertexShaderSource`
fn vertex_shader_source(ctx: &NegativeTestContext<'_>) -> String {
    format!(
        "{}\n\nvoid main (void)\n{{\n    gl_Position = vec4(0.0);\n}}\n",
        ctx.glsl_version_decl()
    )
}

/// `fragmentShaderSource`
fn fragment_shader_source(ctx: &NegativeTestContext<'_>) -> String {
    format!(
        "{}\nprecision mediump float;\nlayout(location = 0) out mediump vec4 fragColor;\n\nvoid main (void)\n{{\n    fragColor = vec4(1.0);\n}}\n",
        ctx.glsl_version_decl()
    )
}

/// `tessControlShaderSource`
fn tess_control_shader_source(ctx: &NegativeTestContext<'_>) -> String {
    format!(
        "{}\n{}\n\nlayout (vertices=3) out;\n\nvoid main()\n{{\n    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n}}\n",
        ctx.glsl_version_decl(),
        tess_extension(ctx)
    )
}

/// `tessEvalShaderSource`
fn tess_eval_shader_source(ctx: &NegativeTestContext<'_>) -> String {
    format!(
        "{}\n{}\n\nlayout(triangles) in;\n\nvoid main()\n{{\n    gl_Position = gl_TessCoord[0] * gl_in[0].gl_Position;\n}}\n",
        ctx.glsl_version_decl(),
        tess_extension(ctx)
    )
}

/// `checkTessellationSupport`
fn check_tessellation_support(ctx: &NegativeTestContext<'_>) -> Result<(), TestError> {
    if ctx.is_extension_supported("GL_EXT_tessellation_shader") {
        Ok(())
    } else {
        Err(TestError::NotSupported(
            "GL_EXT_tessellation_shader not supported".to_string(),
        ))
    }
}

/// `makeTessPipelineSources` - an empty tessellation source means "omit that stage",
/// which is what the `single_tessellation_stage` variants are built from.
fn tess_pipeline_sources(
    ctx: &NegativeTestContext<'_>,
    tess_ctrl: Option<String>,
    tess_eval: Option<String>,
) -> ProgramSources {
    let mut sources = ProgramSources::vtx_frag(vertex_shader_source(ctx), fragment_shader_source(ctx));
    if let Some(source) = tess_ctrl {
        sources = sources.with(ShaderType::TessControl, source);
    }
    if let Some(source) = tess_eval {
        sources = sources.with(ShaderType::TessEvaluation, source);
    }
    sources
}

/// `glDrawArrays(mode, 0, 3)` with no vertex data bound - every draw here is rejected by
/// the program-state validation that precedes the fetch.
fn draw_three(ctx: &NegativeTestContext<'_>, mode: glw::GLenum) {
    // SAFETY: no attribute array is enabled, so nothing is read even if the draw proceeds.
    unsafe { ctx.gl().draw_arrays(mode, 0, 3) };
}

fn single_tessellation_stage(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_tessellation_support(ctx)?;
    let require_tes = !ctx.is_extension_supported("GL_NV_gpu_shader5");

    {
        let program = ShaderProgram::new(
            ctx.gl(),
            &tess_pipeline_sources(ctx, Some(tess_control_shader_source(ctx)), None),
        );

        ctx.begin_section(
            "A link error is generated if a non-separable program has a tessellation control shader but no tessellation evaluation shader, unless GL_NV_gpu_shader5 is supported.",
        );
        if require_tes && program.is_ok() {
            ctx.fail("Program was not expected to link");
        } else if !require_tes && !program.is_ok() {
            ctx.fail("Program was expected to link");
        }
        ctx.end_section();
    }

    {
        let program = ShaderProgram::new(
            ctx.gl(),
            &tess_pipeline_sources(ctx, Some(tess_control_shader_source(ctx)), None).separable(),
        );
        if !program.is_ok() {
            return Err(TestError::Fail("failed to build program".to_string()));
        }

        // SAFETY: the program is this function's own.
        unsafe { ctx.gl().use_program(program.program()) };
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_OPERATION is generated if current program state has tessellation control shader but no tessellation evaluation shader, unless GL_NV_gpu_shader5 is supported.");
        draw_three(ctx, glw::GL_PATCHES);
        ctx.expect_error(if require_tes {
            glw::GL_INVALID_OPERATION
        } else {
            glw::GL_NO_ERROR
        });
        ctx.end_section();

        // SAFETY: as above.
        unsafe { ctx.gl().use_program(0) };
    }

    {
        let program = ShaderProgram::new(
            ctx.gl(),
            &tess_pipeline_sources(ctx, None, Some(tess_eval_shader_source(ctx))),
        );

        ctx.begin_section("A link error is generated if a non-separable program has a tessellation evaluation shader but no tessellation control shader.");
        if program.is_ok() {
            ctx.fail("Program was not expected to link");
        }
        ctx.end_section();
    }

    {
        let program = ShaderProgram::new(
            ctx.gl(),
            &tess_pipeline_sources(ctx, None, Some(tess_eval_shader_source(ctx))).separable(),
        );
        if !program.is_ok() {
            return Err(TestError::Fail("failed to build program".to_string()));
        }

        // SAFETY: as above.
        unsafe { ctx.gl().use_program(program.program()) };
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_OPERATION is generated if current program state has tessellation evaluation shader but no tessellation control shader.");
        draw_three(ctx, glw::GL_PATCHES);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        // SAFETY: as above.
        unsafe { ctx.gl().use_program(0) };
    }
    Ok(())
}

fn invalid_primitive_mode(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_tessellation_support(ctx)?;

    let program = ShaderProgram::new(
        ctx.gl(),
        &tess_pipeline_sources(
            ctx,
            Some(tess_control_shader_source(ctx)),
            Some(tess_eval_shader_source(ctx)),
        ),
    );

    // SAFETY: the program is this function's own.
    unsafe { ctx.gl().use_program(program.program()) };
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section(
        "GL_INVALID_OPERATION is generated if tessellation is active and primitive mode is not GL_PATCHES.",
    );
    draw_three(ctx, glw::GL_TRIANGLES);
    ctx.expect_error(glw::GL_INVALID_OPERATION);
    ctx.end_section();

    // SAFETY: as above.
    unsafe { ctx.gl().use_program(0) };
    Ok(())
}

fn tessellation_not_active(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_tessellation_support(ctx)?;

    let tess_err = if ctx.is_extension_supported("GL_NV_gpu_shader5") {
        glw::GL_NO_ERROR
    } else {
        glw::GL_INVALID_OPERATION
    };
    let program = ShaderProgram::new(ctx.gl(), &tess_pipeline_sources(ctx, None, None));

    // SAFETY: the program is this function's own.
    unsafe { ctx.gl().use_program(program.program()) };
    ctx.expect_error(glw::GL_NO_ERROR);

    ctx.begin_section("GL_INVALID_OPERATION is generated if tessellation is not active and primitive mode is GL_PATCHES, unless GL_NV_gpu_shader5 is supported.");
    draw_three(ctx, glw::GL_PATCHES);
    ctx.expect_error(tess_err);
    ctx.end_section();

    // SAFETY: as above.
    unsafe { ctx.gl().use_program(0) };
    Ok(())
}

fn invalid_program_state(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_tessellation_support(ctx)?;

    let pipeline = ProgramPipeline::new(ctx.gl());
    let frag_program = ShaderProgram::new(
        ctx.gl(),
        &ProgramSources::default()
            .separable()
            .with(ShaderType::Fragment, fragment_shader_source(ctx)),
    );
    let tess_ctrl_program = ShaderProgram::new(
        ctx.gl(),
        &ProgramSources::default()
            .separable()
            .with(ShaderType::TessControl, tess_control_shader_source(ctx)),
    );
    let tess_eval_program = ShaderProgram::new(
        ctx.gl(),
        &ProgramSources::default()
            .separable()
            .with(ShaderType::TessEvaluation, tess_eval_shader_source(ctx)),
    );

    if !frag_program.is_ok() || !tess_ctrl_program.is_ok() || !tess_eval_program.is_ok() {
        return Err(TestError::Fail("failed to build program".to_string()));
    }

    // SAFETY: every object below is this function's own.
    unsafe {
        ctx.gl().bind_program_pipeline(pipeline.get());
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.gl()
            .use_program_stages(pipeline.get(), glw::GL_FRAGMENT_SHADER_BIT, frag_program.program());
        ctx.gl().use_program_stages(
            pipeline.get(),
            glw::GL_TESS_CONTROL_SHADER_BIT,
            tess_ctrl_program.program(),
        );
        ctx.gl().use_program_stages(
            pipeline.get(),
            glw::GL_TESS_EVALUATION_SHADER_BIT,
            tess_eval_program.program(),
        );
        ctx.expect_error(glw::GL_NO_ERROR);
    }

    ctx.begin_section("GL_INVALID_OPERATION is generated if tessellation is active and vertex shader is missing.");
    draw_three(ctx, glw::GL_PATCHES);
    ctx.expect_error(glw::GL_INVALID_OPERATION);
    ctx.end_section();

    // SAFETY: as above.
    unsafe { ctx.gl().bind_program_pipeline(0) };
    ctx.expect_error(glw::GL_NO_ERROR);
    Ok(())
}

fn tessellation_control_invalid_vertex_count(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_tessellation_support(ctx)?;

    ctx.begin_section("Output vertex count exceeds GL_MAX_PATCH_VERTICES.");
    let max_patch_vertices = ctx.get_integer(glw::GL_MAX_PATCH_VERTICES);
    ctx.expect_error(glw::GL_NO_ERROR);

    let tess_control = format!(
        "{}\n{}\nlayout (vertices={}) out;\nvoid main()\n{{\n    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n}}\n",
        ctx.glsl_version_decl(),
        tess_extension(ctx),
        max_patch_vertices + 1
    );

    let program = ShaderProgram::new(
        ctx.gl(),
        &tess_pipeline_sources(ctx, Some(tess_control), Some(tess_eval_shader_source(ctx))),
    );
    if program.program_info.ok {
        ctx.fail("Program was not expected to link");
    }

    ctx.end_section();
    Ok(())
}

/// `invalid_get_programiv`, registered upstream as `get_programiv`.
fn get_programiv(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_tessellation_support(ctx)?;

    let queries = [
        (glw::GL_TESS_CONTROL_OUTPUT_VERTICES, "GL_TESS_CONTROL_OUTPUT_VERTICES"),
        (glw::GL_TESS_GEN_MODE, "GL_TESS_GEN_MODE"),
        (glw::GL_TESS_GEN_SPACING, "GL_TESS_GEN_SPACING"),
        (glw::GL_TESS_GEN_VERTEX_ORDER, "GL_TESS_GEN_VERTEX_ORDER"),
        (glw::GL_TESS_GEN_POINT_MODE, "GL_TESS_GEN_POINT_MODE"),
    ];
    let mut params = [0 as GLint; 1];

    // SAFETY: the program is this function's own and is deleted at the end; each query
    // writes a single GLint.
    unsafe {
        let program = ctx.gl().create_program();

        for (pname, name) in queries {
            ctx.begin_section(&format!(
                "GL_INVALID_OPERATION is generated if {name} is queried for a program which has not been linked properly."
            ));
            ctx.gl().get_programiv(program, pname, params.as_mut_ptr());
            ctx.expect_error(glw::GL_INVALID_OPERATION);
            ctx.end_section();
        }

        ctx.gl().delete_program(program);
    }
    Ok(())
}

/// `invalid_patch_parameteri`, registered upstream as `invalid_program_queries`.
fn invalid_program_queries(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    check_tessellation_support(ctx)?;

    // SAFETY: as above.
    unsafe {
        ctx.begin_section("GL_INVALID_ENUM is generated if pname is not GL_PATCH_VERTICES.");
        ctx.gl().patch_parameteri(BAD_ENUM, 1);
        ctx.expect_error(glw::GL_INVALID_ENUM);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_VALUE is generated if value is less than or equal to zero.");
        ctx.gl().patch_parameteri(glw::GL_PATCH_VERTICES, 0);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        let max_patch_vertices = ctx.get_integer(glw::GL_MAX_PATCH_VERTICES);
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_VALUE is generated if value is greater than GL_MAX_PATCH_VERTICES.");
        ctx.gl()
            .patch_parameteri(glw::GL_PATCH_VERTICES, max_patch_vertices + 1);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    Ok(())
}

/// `getNegativeTessellationTestFunctions`
pub static FUNCTIONS: &[FunctionContainer] = &[
    FunctionContainer {
        function: single_tessellation_stage,
        name: "single_tessellation_stage",
    },
    FunctionContainer {
        function: invalid_primitive_mode,
        name: "invalid_primitive_mode",
    },
    FunctionContainer {
        function: tessellation_not_active,
        name: "tessellation_not_active",
    },
    FunctionContainer {
        function: invalid_program_state,
        name: "invalid_program_state",
    },
    FunctionContainer {
        function: get_programiv,
        name: "get_programiv",
    },
    FunctionContainer {
        function: invalid_program_queries,
        name: "invalid_program_queries",
    },
    FunctionContainer {
        function: tessellation_control_invalid_vertex_count,
        name: "tessellation_control_invalid_vertex_count",
    },
];
