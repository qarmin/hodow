// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fNegativeComputeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `isContextTypeES` guards are
// resolved at port time - this port only ever runs an ES context - so those branches are
// unconditional here.

use crate::gles31::functional::negative_test_shared::{FunctionContainer, NegativeTestContext};
use crate::glu::{ProgramPipeline, ProgramSources, ShaderProgram, ShaderType};
use crate::glw::{self, GLint, GLintptr, GLuint};
use crate::tcu::TestError;

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

/// `computeShaderSource`
fn compute_shader_source(ctx: &NegativeTestContext<'_>) -> String {
    format!(
        "{}\nlayout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\nvoid main (void)\n{{\n}}\n",
        ctx.glsl_version_decl()
    )
}

/// `invalidComputeShaderSource` - the `-1` assigned to a `uint` is the deliberate error.
fn invalid_compute_shader_source(ctx: &NegativeTestContext<'_>) -> String {
    format!(
        "{}\nlayout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\nvoid main (void)\n{{\n    highp uint var = -1;\n}}\n",
        ctx.glsl_version_decl()
    )
}

/// `getResourceLimit`
fn resource_limit(ctx: &NegativeTestContext<'_>, resource: glw::GLenum) -> GLint {
    ctx.get_integer(resource)
}

/// `getResourceLimit` for an indexed limit.
fn indexed_limit(ctx: &mut NegativeTestContext<'_>, resource: glw::GLenum, index: GLuint) -> GLint {
    let mut value: GLint = 0;
    // SAFETY: one GLint out.
    unsafe { ctx.gl().get_integeri_v(resource, index, &mut value) };
    ctx.expect_error(glw::GL_NO_ERROR);
    value
}

/// `verifyLinkError`
fn verify_link_error(ctx: &mut NegativeTestContext<'_>, program: &ShaderProgram<'_>) {
    if program.program_info.ok {
        ctx.fail("Program was not expected to link.");
    }
}

/// `verifyCompileError`
fn verify_compile_error(ctx: &mut NegativeTestContext<'_>, program: &ShaderProgram<'_>, shader_type: ShaderType) {
    let compiled = program
        .shader_info
        .iter()
        .any(|(ty, info)| *ty == shader_type && info.ok);
    if compiled {
        ctx.fail("Program was not expected to compile.");
    }
}

/// `program.getProgramInfo().linkOk && program.getShaderInfo(type).compileOk`
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

/// `generateComputeShader`
fn generate_compute_shader(ctx: &NegativeTestContext<'_>, declarations: &str, body: &str) -> String {
    format!(
        "{}\nlayout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n{}\nvoid main (void)\n{{\n{}}}\n",
        ctx.glsl_version_decl(),
        declarations,
        body
    )
}

/// `genBuiltInSource` - the stage-specific preamble around the write-to-constant body.
fn gen_built_in_source(ctx: &NegativeTestContext<'_>, shader_type: ShaderType) -> String {
    let mut source = format!("{}\n", ctx.glsl_version_decl());
    let tess_extension = if ctx.context_supports(3, 2) {
        String::new()
    } else {
        "#extension GL_EXT_tessellation_shader : require\n".to_string()
    };

    match shader_type {
        ShaderType::Vertex | ShaderType::Fragment => {}
        ShaderType::Compute => source.push_str("layout (local_size_x = 1) in;\n"),
        ShaderType::Geometry => source.push_str("layout(points) in;\nlayout(line_strip, max_vertices = 3) out;\n"),
        ShaderType::TessControl => {
            source.push_str(&tess_extension);
            source.push_str("layout(vertices = 10) out;\n");
        }
        ShaderType::TessEvaluation => {
            source.push_str(&tess_extension);
            source.push_str("layout(triangles) in;\n");
        }
    }

    source.push_str(concat!(
        "\nvoid main(void)\n{\n",
        "    gl_MaxComputeWorkGroupCount       = ivec3(65535, 65535, 65535);\n",
        "    gl_MaxComputeWorkGroupCount       = ivec3(1024, 1024, 64);\n",
        "    gl_MaxComputeWorkGroupSize        = ivec3(512);\n",
        "    gl_MaxComputeUniformComponents    = 512;\n",
        "    gl_MaxComputeTextureImageUnits    = 16;\n",
        "    gl_MaxComputeImageUniforms        = 8;\n",
        "    gl_MaxComputeAtomicCounters       = 8;\n",
        "    gl_MaxComputeAtomicCounterBuffers = 1;\n",
        "}\n"
    ));

    source
}

/// The shape every `exceed_*` case has: build one compute program whose declarations go
/// one past a queried limit, then require that it fail to link.
fn exceed_limit(ctx: &mut NegativeTestContext<'_>, section: &str, declarations: &str, body: &str) {
    let source = generate_compute_shader(ctx, declarations, body);
    let program = ShaderProgram::new(ctx.gl(), &ProgramSources::compute(source));

    ctx.begin_section(section);
    verify_link_error(ctx, &program);
    ctx.end_section();
}

fn exceed_uniform_block_limit(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let count = resource_limit(ctx, glw::GL_MAX_COMPUTE_UNIFORM_BLOCKS) + 1;
    let decl = format!("layout(std140, binding = 0) uniform Block\n{{\n    highp vec4 val;\n}} block[{count}];\n");
    exceed_limit(
        ctx,
        "Link error is generated if a compute shader exceeds GL_MAX_COMPUTE_UNIFORM_BLOCKS.",
        &decl,
        "",
    );
    Ok(())
}

fn exceed_shader_storage_block_limit(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let count = resource_limit(ctx, glw::GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS) + 1;
    let decl = format!("layout(std140, binding = 0) buffer Block\n{{\n    highp vec4 val;\n}} block[{count}];\n");
    exceed_limit(
        ctx,
        "Link error is generated if compute shader exceeds GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS.",
        &decl,
        "",
    );
    Ok(())
}

fn exceed_texture_image_units_limit(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let limit = resource_limit(ctx, glw::GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS) + 1;
    let decl = format!(
        "layout(binding = 0) uniform highp sampler2D u_sampler[{n}];\n\nlayout(binding = 0) buffer Output {{\n    vec4 values[ {n} ];\n}} sb_out;\n",
        n = limit + 1
    );
    let mut body = String::new();
    for i in 0..=limit {
        body.push_str(&format!(
            "   sb_out.values[{i}] = texture(u_sampler[{i}], vec2(1.0f));\n"
        ));
    }

    let source = generate_compute_shader(ctx, &decl, &body);
    let program = ShaderProgram::new(ctx.gl(), &ProgramSources::compute(source));

    log::debug!("Possible link error is generated if compute shader exceeds GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS.");

    if program.program_info.ok {
        log::warn!("Quality Warning: program was not expected to link.");
        // SAFETY: the program is this function's own and linked.
        unsafe { ctx.gl().use_program(program.program()) };
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section(
            "GL_INVALID_OPERATION error is generated if the sum of the number of active samplers for each active program exceeds the maximum number of texture image units allowed",
        );
        // SAFETY: a dispatch of one group needs only an active program.
        unsafe { ctx.gl().dispatch_compute(1, 1, 1) };
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();
    }
    Ok(())
}

fn exceed_image_uniforms_limit(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let limit = resource_limit(ctx, glw::GL_MAX_COMPUTE_IMAGE_UNIFORMS);
    let decl = format!(
        "layout(rgba8, binding = 0) uniform readonly highp image2D u_image[{n}];\n\nlayout(binding = 0) buffer Output {{\n    float values[{n}];\n}} sb_out;\n",
        n = limit + 1
    );
    let mut body = String::new();
    for i in 0..=limit {
        body.push_str(&format!(
            "    sb_out.values[{i}]  = imageLoad(u_image[{i}], ivec2(gl_GlobalInvocationID.xy)).x;\n"
        ));
    }
    exceed_limit(
        ctx,
        "Link error is generated if compute shader exceeds GL_MAX_COMPUTE_IMAGE_UNIFORMS.",
        &decl,
        &body,
    );
    Ok(())
}

fn exceed_shared_memory_size_limit(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let limit = resource_limit(ctx, glw::GL_MAX_COMPUTE_SHARED_MEMORY_SIZE);
    let elements = limit as i64 / std::mem::size_of::<GLuint>() as i64;
    let decl = format!(
        "shared uint values[{}];\n\nlayout(binding = 0) buffer Output {{\n    uint values;\n}} sb_out;\n",
        elements + 1
    );
    let body = format!("    sb_out.values = values[{elements}];\n");
    exceed_limit(
        ctx,
        "Link error is generated if compute shader exceeds GL_MAX_COMPUTE_SHARED_MEMORY_SIZE.",
        &decl,
        &body,
    );
    Ok(())
}

fn exceed_uniform_components_limit(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let limit = resource_limit(ctx, glw::GL_MAX_COMPUTE_UNIFORM_COMPONENTS);
    let decl = format!(
        "uniform highp uint u_value[{}];\n\nlayout(binding = 0) buffer Output {{\n    uint values[2];\n}} sb_out;\n",
        limit + 1
    );
    let body = format!("    sb_out.values[0] = u_value[{limit}];\n    sb_out.values[1] = u_value[0];\n");
    exceed_limit(
        ctx,
        "Link error is generated if compute shader exceeds GL_MAX_COMPUTE_UNIFORM_COMPONENTS.",
        &decl,
        &body,
    );
    Ok(())
}

fn exceed_atomic_counter_buffer_limit(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let limit = resource_limit(ctx, glw::GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS);
    let mut decl = String::new();
    let mut body = String::new();

    for i in 0..=limit {
        decl.push_str(&format!("layout(binding = {i}) uniform atomic_uint u_atomic{i};\n"));
        if i == 0 {
            body.push_str(&format!("    uint oldVal = atomicCounterIncrement(u_atomic{i});\n"));
        } else {
            body.push_str(&format!("    oldVal = atomicCounterIncrement(u_atomic{i});\n"));
        }
    }
    body.push_str("    sb_out.value = oldVal;\n");
    decl.push_str("\nlayout(binding = 0) buffer Output {\n    uint value;\n} sb_out;\n");

    exceed_limit(
        ctx,
        "Link error is generated if compute shader exceeds GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS.",
        &decl,
        &body,
    );
    Ok(())
}

fn exceed_atomic_counters_limit(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let binding = std::mem::size_of::<GLuint>() as GLint * resource_limit(ctx, glw::GL_MAX_COMPUTE_ATOMIC_COUNTERS);
    let decl = format!(
        "layout(binding = 0, offset = 0) uniform atomic_uint u_atomic0;\nlayout(binding = {binding}, offset = 0) uniform atomic_uint u_atomic1;\n\nlayout(binding = 0) buffer Output {{\n    uint value;\n}} sb_out;\n"
    );
    let body = "    uint oldVal = 0u;\n    oldVal = atomicCounterIncrement(u_atomic0);\n    oldVal = atomicCounterIncrement(u_atomic1);\n    sb_out.value = oldVal;\n";

    exceed_limit(
        ctx,
        "Link error is generated if compute shader exceeds GL_MAX_COMPUTE_ATOMIC_COUNTERS.",
        &decl,
        body,
    );
    Ok(())
}

fn program_not_active(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let pipeline = ProgramPipeline::new(ctx.gl());
    let vert_program = ShaderProgram::new(
        ctx.gl(),
        &ProgramSources::default()
            .separable()
            .with(ShaderType::Vertex, vertex_shader_source(ctx)),
    );
    let frag_program = ShaderProgram::new(
        ctx.gl(),
        &ProgramSources::default()
            .separable()
            .with(ShaderType::Fragment, fragment_shader_source(ctx)),
    );

    if !vert_program.is_ok() || !frag_program.is_ok() {
        return Err(TestError::InternalError("failed to build program".to_string()));
    }

    // SAFETY: every object below is this function's own; a dispatch with no compute stage
    // is the error under test and performs no work.
    unsafe {
        ctx.gl().bind_program_pipeline(pipeline.get());
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("Program not set at all");
        ctx.begin_section("GL_INVALID_OPERATION is generated by glDispatchCompute if there is no active program for the compute shader stage.");
        ctx.gl().dispatch_compute(1, 1, 1);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated by glDispatchComputeIndirect if there is no active program for the compute shader stage.");
        ctx.gl().dispatch_compute_indirect(0 as GLintptr);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();
        ctx.end_section();

        ctx.begin_section("Program contains graphic pipeline stages");
        ctx.gl()
            .use_program_stages(pipeline.get(), glw::GL_VERTEX_SHADER_BIT, vert_program.program());
        ctx.gl()
            .use_program_stages(pipeline.get(), glw::GL_FRAGMENT_SHADER_BIT, frag_program.program());
        ctx.expect_error(glw::GL_NO_ERROR);

        ctx.begin_section("GL_INVALID_OPERATION is generated by glDispatchCompute if there is no active program for the compute shader stage.");
        ctx.gl().dispatch_compute(1, 1, 1);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        ctx.begin_section("GL_INVALID_OPERATION is generated by glDispatchComputeIndirect if there is no active program for the compute shader stage.");
        ctx.gl().dispatch_compute_indirect(0 as GLintptr);
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();
        ctx.end_section();

        ctx.gl().bind_program_pipeline(0);
        ctx.expect_error(glw::GL_NO_ERROR);
    }
    Ok(())
}

fn invalid_program_query(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let mut data = [0 as GLint; 3];

    ctx.begin_section("Compute shader that does not link");
    {
        let program = ShaderProgram::new(ctx.gl(), &ProgramSources::compute(invalid_compute_shader_source(ctx)));
        if program.is_ok() {
            return Err(TestError::InternalError("program should not of built".to_string()));
        }

        ctx.begin_section("GL_INVALID_OPERATION is generated if GL_COMPUTE_WORK_GROUP_SIZE is queried for a program which has not been linked properly.");
        // SAFETY: GL_COMPUTE_WORK_GROUP_SIZE writes three GLints, which is what `data` is.
        unsafe {
            ctx.gl()
                .get_programiv(program.program(), glw::GL_COMPUTE_WORK_GROUP_SIZE, data.as_mut_ptr());
        }
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        // SAFETY: unbinding needs only a current context.
        unsafe { ctx.gl().use_program(0) };
    }
    ctx.end_section();

    ctx.begin_section("Compute shader not present");
    {
        let program = ShaderProgram::new(
            ctx.gl(),
            &ProgramSources::vtx_frag(vertex_shader_source(ctx), fragment_shader_source(ctx)),
        );
        if !program.is_ok() {
            return Err(TestError::InternalError("failed to build program".to_string()));
        }

        ctx.begin_section("GL_INVALID_OPERATION is generated if GL_COMPUTE_WORK_GROUP_SIZE is queried for a program which has not been linked properly.");
        // SAFETY: as above.
        unsafe {
            ctx.gl()
                .get_programiv(program.program(), glw::GL_COMPUTE_WORK_GROUP_SIZE, data.as_mut_ptr());
        }
        ctx.expect_error(glw::GL_INVALID_OPERATION);
        ctx.end_section();

        // SAFETY: as above.
        unsafe { ctx.gl().use_program(0) };
    }
    ctx.end_section();
    Ok(())
}

fn invalid_dispatch_compute_indirect(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let program = ShaderProgram::new(ctx.gl(), &ProgramSources::compute(compute_shader_source(ctx)));
    if !program.is_ok() {
        return Err(TestError::InternalError("failed to build program".to_string()));
    }

    /// The `{numGroupsX, numGroupsY, numGroupsZ}` an indirect dispatch reads.
    const DATA: [GLuint; 3] = [0, 0, 0];
    const DATA_SIZE: isize = std::mem::size_of::<[GLuint; 3]>() as isize;

    // SAFETY: as above; every buffer is this function's own and gets `DATA_SIZE` bytes
    // from a source of exactly that size.
    unsafe {
        ctx.gl().use_program(program.program());
        ctx.expect_error(glw::GL_NO_ERROR);

        {
            let mut buffer: GLuint = 0;
            ctx.gl().gen_buffers(1, &mut buffer);
            ctx.gl().bind_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, 0);
            ctx.expect_error(glw::GL_NO_ERROR);

            ctx.begin_section("GL_INVALID_OPERATION is generated by glDispatchComputeIndirect if zero is bound to GL_DISPATCH_INDIRECT_BUFFER.");
            ctx.gl().dispatch_compute_indirect(0 as GLintptr);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
            ctx.end_section();

            ctx.gl().delete_buffers(1, &buffer);
        }

        {
            let mut buffer: GLuint = 0;
            ctx.gl().gen_buffers(1, &mut buffer);
            ctx.expect_error(glw::GL_NO_ERROR);

            ctx.gl().bind_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, buffer);
            ctx.expect_error(glw::GL_NO_ERROR);

            ctx.gl().buffer_data(
                glw::GL_DISPATCH_INDIRECT_BUFFER,
                DATA_SIZE,
                DATA.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
            ctx.expect_error(glw::GL_NO_ERROR);

            ctx.begin_section("GL_INVALID_OPERATION is generated by glDispatchComputeIndirect if data is sourced beyond the end of the buffer object.");
            ctx.gl().dispatch_compute_indirect((1 << 10) as GLintptr);
            ctx.expect_error(glw::GL_INVALID_OPERATION);
            ctx.end_section();

            ctx.gl().bind_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, 0);
            ctx.gl().delete_buffers(1, &buffer);
        }

        ctx.begin_section(
            "GL_INVALID_VALUE is generated by glDispatchComputeIndirect if the value of indirect is less than zero.",
        );
        ctx.gl().dispatch_compute_indirect(-1 as GLintptr);
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();

        {
            let mut buffer: GLuint = 0;
            ctx.gl().gen_buffers(1, &mut buffer);
            ctx.expect_error(glw::GL_NO_ERROR);

            ctx.gl().bind_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, buffer);
            ctx.expect_error(glw::GL_NO_ERROR);

            ctx.gl().buffer_data(
                glw::GL_DISPATCH_INDIRECT_BUFFER,
                DATA_SIZE,
                DATA.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
            ctx.expect_error(glw::GL_NO_ERROR);

            ctx.begin_section("GL_INVALID_VALUE is generated by glDispatchComputeIndirect if indirect is not a multiple of the size, in basic machine units, of uint.");
            ctx.gl().dispatch_compute_indirect(DATA_SIZE + 1);
            ctx.expect_error(glw::GL_INVALID_VALUE);
            ctx.end_section();

            ctx.gl().bind_buffer(glw::GL_DISPATCH_INDIRECT_BUFFER, 0);
            ctx.gl().delete_buffers(1, &buffer);
        }
    }
    Ok(())
}

fn invalid_maximum_work_group_counts(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let program = ShaderProgram::new(ctx.gl(), &ProgramSources::compute(compute_shader_source(ctx)));
    if !program.is_ok() {
        return Err(TestError::InternalError("failed to build program".to_string()));
    }

    // SAFETY: a dispatch the driver rejects for an out-of-range group count does no work.
    unsafe { ctx.gl().use_program(program.program()) };
    ctx.expect_error(glw::GL_NO_ERROR);

    for (axis, name) in [(0, 'x'), (1, 'y'), (2, 'z')] {
        let count = indexed_limit(ctx, glw::GL_MAX_COMPUTE_WORK_GROUP_COUNT, axis);
        ctx.begin_section(&format!(
            "GL_INVALID_VALUE is generated by glDispatchCompute if <numGroups{}> array is larger than the maximum work group count for the {name} dimension.",
            name.to_ascii_uppercase()
        ));
        let groups = [
            if axis == 0 { count as GLuint + 1 } else { 1 },
            if axis == 1 { count as GLuint + 1 } else { 1 },
            if axis == 2 { count as GLuint + 1 } else { 1 },
        ];
        // SAFETY: as above.
        unsafe { ctx.gl().dispatch_compute(groups[0], groups[1], groups[2]) };
        ctx.expect_error(glw::GL_INVALID_VALUE);
        ctx.end_section();
    }
    Ok(())
}

fn invalid_maximum_work_group_sizes(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let max_x = indexed_limit(ctx, glw::GL_MAX_COMPUTE_WORK_GROUP_SIZE, 0);
    let max_y = indexed_limit(ctx, glw::GL_MAX_COMPUTE_WORK_GROUP_SIZE, 1);
    let max_z = indexed_limit(ctx, glw::GL_MAX_COMPUTE_WORK_GROUP_SIZE, 2);
    let _max_invocations = ctx.get_integer(glw::GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS);
    ctx.expect_error(glw::GL_NO_ERROR);

    let cases = [
        (max_x + 1, 1, 1),
        (1, max_y + 1, 1),
        (1, 1, max_z + 1),
        (max_x, max_y, max_z),
    ];

    for (index, (x, y, z)) in cases.iter().enumerate() {
        let source = format!(
            "{}\nlayout(local_size_x = {x}, local_size_y = {y}, local_size_z = {z}) in;\nvoid main (void)\n{{\n}}\n",
            ctx.glsl_version_decl()
        );
        let program = ShaderProgram::new(ctx.gl(), &ProgramSources::compute(source));

        if index == cases.len() - 1 {
            ctx.begin_section("A compile time or link error is generated if the maximum number of invocations in a single local work group (product of the three dimensions) is greater than GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS.");
            verify_compile_or_link_error(ctx, &program, ShaderType::Compute);
        } else {
            ctx.begin_section("A compile time error is generated if the fixed local group size of the shader in any dimension is greater than the maximum supported.");
            verify_compile_error(ctx, &program, ShaderType::Compute);
        }
        ctx.end_section();
    }
    Ok(())
}

fn invalid_layout_qualifiers(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let version = ctx.glsl_version_decl();

    {
        let source = format!("{version}\nvoid main (void)\n{{\n}}\n");
        let program = ShaderProgram::new(ctx.gl(), &ProgramSources::compute(source));
        ctx.begin_section("A link error is generated if the compute shader program does not contain an input layout qualifier specifying a fixed local group size.");
        verify_link_error(ctx, &program);
        ctx.end_section();
    }

    {
        let source = format!(
            "{version}\nlayout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\nlayout(local_size_x = 2, local_size_y = 2, local_size_z = 2) in;\nvoid main (void)\n{{\n}}\n"
        );
        let program = ShaderProgram::new(ctx.gl(), &ProgramSources::compute(source));
        ctx.begin_section("A compile-time error is generated if a local work group size qualifier is declared more than once in the same shader.");
        verify_compile_error(ctx, &program, ShaderType::Compute);
        ctx.end_section();
    }

    {
        let source = format!(
            "{version}\nout mediump vec4 fragColor;\n\nlayout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\nvoid main (void)\n{{\n}}\n"
        );
        let program = ShaderProgram::new(ctx.gl(), &ProgramSources::compute(source));
        ctx.begin_section(
            "A compile-time error is generated if a user defined output variable is declared in a compute shader.",
        );
        verify_compile_error(ctx, &program, ShaderType::Compute);
        ctx.end_section();
    }

    {
        let source = format!(
            "{version}\nuvec3 gl_NumWorkGroups;\nuvec3 gl_WorkGroupSize;\nuvec3 gl_WorkGroupID;\nuvec3 gl_LocalInvocationID;\nuvec3 gl_GlobalInvocationID;\nuvec3 gl_LocalInvocationIndex;\n\nlayout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\nvoid main (void)\n{{\n}}\n"
        );
        let program = ShaderProgram::new(ctx.gl(), &ProgramSources::compute(source));
        ctx.begin_section(
            "A compile time or link error is generated if compute shader built-in variables are redeclared.",
        );
        verify_compile_or_link_error(ctx, &program, ShaderType::Compute);
        ctx.end_section();
    }
    Ok(())
}

fn invalid_write_built_in_constants(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    let tessellation = ctx.is_extension_supported("GL_EXT_tessellation_shader")
        || ctx.is_extension_supported("GL_OES_tessellation_shader");
    let geometry =
        ctx.is_extension_supported("GL_EXT_geometry_shader") || ctx.is_extension_supported("GL_OES_geometry_shader");
    if !tessellation || !geometry {
        return Err(TestError::NotSupported(
            "tessellation and geometry shader extensions not supported".to_string(),
        ));
    }

    ctx.begin_section(
        "A compile time is generated if compute built-in constants provided in all shaders are written to.",
    );
    for shader_type in [
        ShaderType::Vertex,
        ShaderType::Fragment,
        ShaderType::TessControl,
        ShaderType::TessEvaluation,
        ShaderType::Geometry,
        ShaderType::Compute,
    ] {
        let source = gen_built_in_source(ctx, shader_type);
        let program = ShaderProgram::new(
            ctx.gl(),
            &ProgramSources::default().separable().with(shader_type, source),
        );
        verify_compile_error(ctx, &program, shader_type);
    }
    ctx.end_section();
    Ok(())
}

/// `getNegativeComputeTestFunctions`
pub static FUNCTIONS: &[FunctionContainer] = &[
    FunctionContainer {
        function: program_not_active,
        name: "program_not_active",
    },
    FunctionContainer {
        function: invalid_program_query,
        name: "invalid_program_query",
    },
    FunctionContainer {
        function: invalid_dispatch_compute_indirect,
        name: "invalid_dispatch_compute_indirect",
    },
    FunctionContainer {
        function: invalid_maximum_work_group_counts,
        name: "invalid_maximum_work_group_counts",
    },
    FunctionContainer {
        function: invalid_maximum_work_group_sizes,
        name: "invalid_maximum_work_group_sizes",
    },
    FunctionContainer {
        function: invalid_layout_qualifiers,
        name: "invalid_layout_qualifiers",
    },
    FunctionContainer {
        function: invalid_write_built_in_constants,
        name: "invalid_write_built_in_constants",
    },
    FunctionContainer {
        function: exceed_uniform_block_limit,
        name: "exceed_uniform_block_limit",
    },
    FunctionContainer {
        function: exceed_shader_storage_block_limit,
        name: "exceed_shader_storage_block_limit",
    },
    FunctionContainer {
        function: exceed_texture_image_units_limit,
        name: "exceed_texture_image_units_limit",
    },
    FunctionContainer {
        function: exceed_image_uniforms_limit,
        name: "exceed_image_uniforms_limit",
    },
    FunctionContainer {
        function: exceed_shared_memory_size_limit,
        name: "exceed_shared_memory_size_limit",
    },
    FunctionContainer {
        function: exceed_uniform_components_limit,
        name: "exceed_uniform_components_limit",
    },
    FunctionContainer {
        function: exceed_atomic_counter_buffer_limit,
        name: "exceed_atomic_counter_buffer_limit",
    },
    FunctionContainer {
        function: exceed_atomic_counters_limit,
        name: "exceed_atomic_counters_limit",
    },
];
