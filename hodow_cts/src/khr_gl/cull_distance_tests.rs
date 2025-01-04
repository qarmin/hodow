// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcCullDistance.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the desktop paths are ported (`m_isContextES` is always false in the roots that register this group), so the `specializationMap` is the desktop one and the `clipdistance_data<n>` attribute variant is absent. `Utilities::buildProgram` is `ShaderProgram::new`; the negative case builds a fresh program per iteration instead of re-linking one program object, which observes the same compile and link outcomes. `m_to_id`/`m_fbo_id`/`m_bo_id`/`m_vao_id` are guards local to `iterate`. The `DE_ASSERT` counters of `executeRenderTest` (debug builds only upstream) are not ported. `use_core_functionality` is evaluated when the case runs, since the context is not known when the tree is built.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

const MAX_COMBINED_CLIP_AND_CULL_DISTANCES: i32 = 8;
const TO_WIDTH: u32 = 512;
const TO_HEIGHT: u32 = 512;
const TO_PIXEL_DATA_CACHE_COLOR_COMPONENTS: usize = 4;

const DYNAMIC_ARRAY_SETTERS: &str = "\n\
#if TEMPLATE_N_GL_CLIPDISTANCE_ENTRIES\n\
     for (int n_clipdistance_entry = 0;\n\
          n_clipdistance_entry < TEMPLATE_N_GL_CLIPDISTANCE_ENTRIES;\n\
        ++n_clipdistance_entry)\n\
     {\n\
         ASSIGN_CLIP_DISTANCE(n_clipdistance_entry);\n\
     }\n\
#endif\n\
#if TEMPLATE_N_GL_CULLDISTANCE_ENTRIES \n\
     for (int n_culldistance_entry = 0;\n\
          n_culldistance_entry < TEMPLATE_N_GL_CULLDISTANCE_ENTRIES;\n\
        ++n_culldistance_entry)\n\
     {\n\
         ASSIGN_CULL_DISTANCE(n_culldistance_entry);\n\
     }\n\
#endif\n";

const FETCH_FUNCTION: &str = "highp float fetch()\n\
{\n\
    highp float sum = 0.0;\n\
\n\
TEMPLATE_SUM_SETTER\n\
    return sum / TEMPLATE_SUM_DIVIDER;\n\
}\n\
\n\
#define ASSIGN_RETURN_VALUE fetch()";

const FS_TEMPLATE: &str = "${VERSION}\n\
${EXTENSION}\n\
${PRECISION}\n\
\n\
TEMPLATE_REDECLARE_CLIPDISTANCE\n\
TEMPLATE_REDECLARE_CULLDISTANCE\n\
\n\
TEMPLATE_ASSIGN_RETURN_VALUE\n\
\n\
out vec4 out_fs;\n\
\n\
/* Fragment shader main function */\n\
void main()\n\
{\n\
    out_fs = vec4(ASSIGN_RETURN_VALUE, 1.0, 1.0, 1.0);\n\
}\n";

const GS_TEMPLATE: &str = "${GS_VERSION}\n\
${EXTENSION}\n\
${GS_EXTENSION}\n\
\n\
TEMPLATE_LAYOUT_IN\n\
TEMPLATE_LAYOUT_OUT\n\
\n\
TEMPLATE_REDECLARE_CLIPDISTANCE\n\
TEMPLATE_REDECLARE_CULLDISTANCE\n\
\n\
#define ASSIGN_CLIP_DISTANCE(IDX) TEMPLATE_ASSIGN_CLIP_DISTANCE\n\
#define ASSIGN_CULL_DISTANCE(IDX) TEMPLATE_ASSIGN_CULL_DISTANCE\n\
\n\
/* Geometry shader (passthrough) main function */\n\
void main()\n\
{\n\
    for (int n_vertex_index = 0;\n\
             n_vertex_index < gl_in.length();\n\
             n_vertex_index ++)\n\
    {\n\
        gl_Position = gl_in[n_vertex_index].gl_Position;\n\
\n\
        TEMPLATE_ARRAY_SETTERS\n\
\n\
        EmitVertex();\n\
    }\n\
\n\
    EndPrimitive();\n\
}\n";

const TC_TEMPLATE: &str = "${TS_VERSION}\n\
${EXTENSION}\n\
${TS_EXTENSION}\n\
\n\
TEMPLATE_LAYOUT_OUT\n\
\n\
out gl_PerVertex {\n\
TEMPLATE_REDECLARE_CLIPDISTANCE\n\
TEMPLATE_REDECLARE_CULLDISTANCE\n\
vec4 gl_Position;\n\
} gl_out[];\n\
\n\
#define ASSIGN_CLIP_DISTANCE(IDX) TEMPLATE_ASSIGN_CLIP_DISTANCE\n\
#define ASSIGN_CULL_DISTANCE(IDX) TEMPLATE_ASSIGN_CULL_DISTANCE\n\
\n\
/* Tesselation control shader main function */\n\
void main()\n\
{\n\
    gl_TessLevelInner[0] = 1.0;\n\
    gl_TessLevelInner[1] = 1.0;\n\
    gl_TessLevelOuter[0] = 1.0;\n\
    gl_TessLevelOuter[1] = 1.0;\n\
    gl_TessLevelOuter[2] = 1.0;\n\
    gl_TessLevelOuter[3] = 1.0;\n\
    /* Clipdistance and culldistance array setters */\n\
    {\n\
        TEMPLATE_ARRAY_SETTERS\n\
    }\n\
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n\
}\n";

const TE_TEMPLATE: &str = "${TS_VERSION}\n\
${EXTENSION}\n\
${TS_EXTENSION}\n\
\n\
TEMPLATE_LAYOUT_IN\n\
\n\
in gl_PerVertex {\n\
TEMPLATE_REDECLARE_IN_CLIPDISTANCE\n\
TEMPLATE_REDECLARE_IN_CULLDISTANCE\n\
vec4 gl_Position;\n\
} gl_in[];\n\
\n\
TEMPLATE_REDECLARE_CLIPDISTANCE\n\
TEMPLATE_REDECLARE_CULLDISTANCE\n\
\n\
#define ASSIGN_CLIP_DISTANCE(IDX) TEMPLATE_ASSIGN_CLIP_DISTANCE\n\
#define ASSIGN_CULL_DISTANCE(IDX) TEMPLATE_ASSIGN_CULL_DISTANCE\n\
\n\
/* Tesselation evaluation shader main function */\n\
void main()\n\
{\n\
    /* Clipdistance and culldistance array setters */\n\
    {\n\
        TEMPLATE_ARRAY_SETTERS\n\
    }\n\
    gl_Position = TEMPLATE_OUT_FORMULA;\n\
}\n";

const VS_TEMPLATE: &str = "${VERSION}\n\
${EXTENSION}\n\
\n\
TEMPLATE_CLIPDISTANCE_ATTRIB_DECLARATIONS\n\
TEMPLATE_CULLDISTANCE_ATTRIB_DECLARATIONS\n\
in vec2  position;\n\
\n\
TEMPLATE_REDECLARE_CLIPDISTANCE\n\
TEMPLATE_REDECLARE_CULLDISTANCE\n\
\n\
#define ASSIGN_CLIP_DISTANCE(IDX) TEMPLATE_ASSIGN_CLIP_DISTANCE\n\
#define ASSIGN_CULL_DISTANCE(IDX) TEMPLATE_ASSIGN_CULL_DISTANCE\n\
\n\
/* Vertex shader main function */\n\
void main()\n\
{\n\
    /* Clipdistance and culldistance array setters */\n\
    {\n\
        TEMPLATE_ARRAY_SETTERS\n\
    }\n\
    gl_Position = vec4(2.0 * position.x - 1.0, 2.0 * position.y - 1.0, 0.0, 1.0);\n\
}\n";

/// The desktop `specializationMap` of `CullDistanceTestBase`'s constructor.
fn base_specialization() -> Vec<(&'static str, String)> {
    vec![
        ("VERSION", "#version 150".to_string()),
        ("EXTENSION", "#extension GL_ARB_cull_distance : require".to_string()),
        ("PRECISION", String::new()),
        ("CS_VERSION", "#version 420 core".to_string()),
        (
            "CS_EXTENSION",
            "#extension GL_ARB_compute_shader : require\n#extension GL_ARB_shader_image_load_store : require"
                .to_string(),
        ),
        ("TS_VERSION", "#version 150".to_string()),
        ("GS_VERSION", "#version 150".to_string()),
        (
            "TS_EXTENSION",
            "#extension GL_ARB_tessellation_shader : require".to_string(),
        ),
        ("GS_EXTENSION", String::new()),
    ]
}

fn fail<T>(message: &str) -> Result<T, TestError> {
    Err(TestError::Fail(message.to_string()))
}

fn get_integer(gl: &glw::Functions, pname: glw::GLenum) -> i32 {
    let mut value = 0;
    // SAFETY: one GLint out.
    unsafe { gl.get_integerv(pname, &mut value) };
    value
}

fn has_compute(context: &Context) -> bool {
    context.context_type().supports_core(4, 3) || context.context_info.is_extension_supported("GL_ARB_compute_shader")
}

fn has_tessellation(context: &Context) -> bool {
    context.context_type().supports_core(4, 0)
        || context
            .context_info
            .is_extension_supported("GL_ARB_tessellation_shader")
}

fn build_program<'gl>(gl: &'gl glw::Functions, sources: &ProgramSources) -> Result<ShaderProgram<'gl>, TestError> {
    let program = ShaderProgram::new(gl, sources);
    if !program.is_ok() {
        return Err(TestError::Fail(format!(
            "Shader compilation or program linking has failed. {}",
            program.build_failure_summary().unwrap_or_default()
        )));
    }
    Ok(program)
}

// ---------------------------------------------------------------------------------------------
// APICoverageTest
// ---------------------------------------------------------------------------------------------

struct CoverageStage {
    use_cs: bool,
    use_fs: bool,
    use_gs: bool,
    use_tc: bool,
    use_te: bool,
    use_vs: bool,
    fs_input: Option<&'static str>,
    gs_input: Option<&'static str>,
    tc_input: Option<&'static str>,
    te_input: Option<&'static str>,
    tf_output_name: Option<&'static str>,
    tf_mode: glw::GLenum,
    draw_call_mode: glw::GLenum,
    n_draw_call_vertices: i32,
}

const COVERAGE_STAGES: [CoverageStage; 5] = [
    // CS only test
    CoverageStage {
        use_cs: true,
        use_fs: false,
        use_gs: false,
        use_tc: false,
        use_te: false,
        use_vs: false,
        fs_input: None,
        gs_input: None,
        tc_input: None,
        te_input: None,
        tf_output_name: None,
        tf_mode: glw::GL_NONE,
        draw_call_mode: glw::GL_NONE,
        n_draw_call_vertices: 0,
    },
    // VS+GS+TC+TE+FS test
    CoverageStage {
        use_cs: false,
        use_fs: true,
        use_gs: true,
        use_tc: true,
        use_te: true,
        use_vs: true,
        fs_input: Some("out_gs"),
        gs_input: Some("out_te"),
        tc_input: Some("out_vs"),
        te_input: Some("out_tc"),
        tf_output_name: Some("out_gs"),
        tf_mode: glw::GL_TRIANGLES,
        draw_call_mode: glw::GL_PATCHES,
        n_draw_call_vertices: 3,
    },
    // VS+GS+FS test
    CoverageStage {
        use_cs: false,
        use_fs: true,
        use_gs: true,
        use_tc: false,
        use_te: false,
        use_vs: true,
        fs_input: Some("out_gs"),
        gs_input: Some("out_vs"),
        tc_input: None,
        te_input: None,
        tf_output_name: Some("out_gs"),
        tf_mode: glw::GL_TRIANGLES,
        draw_call_mode: glw::GL_POINTS,
        n_draw_call_vertices: 1,
    },
    // VS+TC+TE+FS test
    CoverageStage {
        use_cs: false,
        use_fs: true,
        use_gs: false,
        use_tc: true,
        use_te: true,
        use_vs: true,
        fs_input: Some("out_te"),
        gs_input: None,
        tc_input: Some("out_vs"),
        te_input: Some("out_tc"),
        tf_output_name: Some("out_te"),
        tf_mode: glw::GL_POINTS,
        draw_call_mode: glw::GL_PATCHES,
        n_draw_call_vertices: 3,
    },
    // VS test
    CoverageStage {
        use_cs: false,
        use_fs: false,
        use_gs: false,
        use_tc: false,
        use_te: false,
        use_vs: true,
        fs_input: Some("out_vs"),
        gs_input: None,
        tc_input: None,
        te_input: None,
        tf_output_name: Some("out_vs"),
        tf_mode: glw::GL_POINTS,
        draw_call_mode: glw::GL_POINTS,
        n_draw_call_vertices: 1,
    },
];

const COVERAGE_CS_TEMPLATE: &str = "${CS_VERSION}\n\
\n\
${EXTENSION}\n\
\n\
${CS_EXTENSION}\n\
\n\
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\
\n\
layout(r32i) uniform writeonly iimage2D result;\n\
\n\
void main()\n\
{\n\
    imageStore(result, ivec2(0),ivec4(TOKEN) );\n\
}\n";

const COVERAGE_FS_TEMPLATE: &str = "${VERSION}\n\
\n\
${EXTENSION}\n\
\n\
${PRECISION}\n\
\n\
flat in  int INPUT_FS_NAME;\n\
out int out_fs;\n\
\n\
void main()\n\
{\n\
    if (INPUT_FS_NAME == TOKEN)\n\
    {\n\
        out_fs = TOKEN;\n\
    }\n\
    else\n\
    {\n\
        out_fs = -1;\n\
    }\n\
}\n";

const COVERAGE_GS_TEMPLATE: &str = "${GS_VERSION}\n\
\n\
${EXTENSION}\n\
\n\
${GS_EXTENSION}\n\
\n\
flat in  int INPUT_GS_NAME[1];\n\
flat out int out_gs;\n\
\n\
layout(points)                           in;\n\
layout(triangle_strip, max_vertices = 4) out;\n\
\n\
void main()\n\
{\n\
    int result_value = (INPUT_GS_NAME[0] == TOKEN) ? TOKEN : -1;\n\
\n\
    gl_Position = vec4(-1.0, 1.0, 0.0, 1.0);\n\
    out_gs      = result_value;\n\
    EmitVertex();\n\
\n\
    gl_Position = vec4(-1.0, -1.0, 0.0, 1.0);\n\
    out_gs      = result_value;\n\
    EmitVertex();\n\
\n\
    gl_Position = vec4(1.0, 1.0, 0.0, 1.0);\n\
    out_gs      = result_value;\n\
    EmitVertex();\n\
\n\
    gl_Position = vec4(1.0, -1.0, 0.0, 1.0);\n\
    out_gs      = result_value;\n\
    EmitVertex();\n\
    EndPrimitive();\n\
}\n";

const COVERAGE_TC_TEMPLATE: &str = "${TS_VERSION}\n\
${EXTENSION}\n\
${TS_EXTENSION}\n\
\n\
layout(vertices = 1) out;\n\
\n\
flat in  int INPUT_TC_NAME[];\n\
flat out int out_tc       [];\n\
\n\
void main()\n\
{\n\
    int result_value = (INPUT_TC_NAME[0] == TOKEN) ? TOKEN : -1;\n\
\n\
    out_tc[gl_InvocationID]             = result_value;\n\
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n\
    gl_TessLevelInner[0]                = 1.0;\n\
    gl_TessLevelInner[1]                = 1.0;\n\
    gl_TessLevelOuter[0]                = 1.0;\n\
    gl_TessLevelOuter[1]                = 1.0;\n\
    gl_TessLevelOuter[2]                = 1.0;\n\
    gl_TessLevelOuter[3]                = 1.0;\n\
}\n";

const COVERAGE_TE_TEMPLATE: &str = "${TS_VERSION}\n\
${EXTENSION}\n\
${TS_EXTENSION}\n\
\n\
flat in  int INPUT_TE_NAME[];\n\
flat out int out_te;\n\
\n\
layout(isolines, point_mode) in;\n\
\n\
void main()\n\
{\n\
    int result_value = (INPUT_TE_NAME[0] == TOKEN) ? TOKEN : 0;\n\
\n\
    out_te = result_value;\n\
\n\
    gl_Position = vec4(0.0, 0.0, 0.0, 1.);\n\
}\n";

const COVERAGE_VS_TEMPLATE: &str = "${VERSION}\n\
\n\
${EXTENSION}\n\
\n\
flat out int out_vs;\n\
\n\
void main()\n\
{\n\
    gl_Position = vec4(0.0, 0.0, 0.0, 1.0);\n\
    out_vs      = TOKEN;\n\
}\n";

/// `APICoverageTest::test`, with `deinit`'s pack alignment restore done by the caller.
fn coverage_test(context: &Context) -> TestOutcome {
    let gl = context.gl();
    let specialization = base_specialization();

    let gl_max_cull_distances_value = get_integer(gl, glw::GL_MAX_CULL_DISTANCES);
    // SAFETY: no arguments.
    let error_code = unsafe { gl.get_error() };
    if error_code != glw::GL_NO_ERROR {
        log::info!(
            "glGetIntegerv() returned error code [{}] for GL_MAX_CULL_DISTANCES query instead of GL_NO_ERROR",
            glw::error_name(error_code)
        );
        return Ok(TestStatus::fail("Fail"));
    }

    let gl_max_combined_clip_and_cull_distances_value = get_integer(gl, glw::GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES);
    // SAFETY: no arguments.
    let error_code = unsafe { gl.get_error() };
    if error_code != glw::GL_NO_ERROR {
        log::info!(
            "glGetIntegerv() returned error code [{}] for GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES query instead of GL_NO_ERROR",
            glw::error_name(error_code)
        );
        return Ok(TestStatus::fail("Fail"));
    }

    // Before we proceed with the two other tests, initialize a buffer & a texture object we will need to capture data from the programs
    const BO_SIZE: usize = std::mem::size_of::<i32>() * 4 /* components */ * 4 /* result points */;
    let bo = glu::Buffer::new(gl);
    let fbo_draw = glu::Framebuffer::new(gl);
    let fbo_read = glu::Framebuffer::new(gl);
    let cs_to = glu::Texture::new(gl);
    let fbo_draw_to = glu::Texture::new(gl);
    let vao = glu::VertexArray::new(gl);
    glu::expect_no_error(
        gl,
        "glGenBuffers() / glGenFramebuffers() / glGenTextures() / glGenVertexArrays() call(s) failed.",
    )?;

    // SAFETY: names owned by the guards above; the buffer is allocated without data.
    unsafe {
        gl.bind_vertex_array(vao.get());
        glu::expect_no_error(gl, "glBindVertexArray() call failed.")?;

        gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, bo.get());
        gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, bo.get());
        glu::expect_no_error(gl, "glBindBuffer() or glBindBufferBase() call(s) failed.")?;

        gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            BO_SIZE as isize,
            std::ptr::null(),
            glw::GL_STATIC_DRAW,
        );
        glu::expect_no_error(gl, "glBufferData() call failed.")?;

        // CS, FBO
        for to_id in [cs_to.get(), fbo_draw_to.get()] {
            gl.bind_texture(glw::GL_TEXTURE_2D, to_id);
            glu::expect_no_error(gl, "glBindTexture() call failed.")?;

            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_R32I, 1, 1);
            glu::expect_no_error(gl, "glTexStorage2D() call failed.")?;
        }
    }

    if has_compute(context) {
        // SAFETY: a texture of the right format is bound to the image unit.
        unsafe { gl.bind_image_texture(0, cs_to.get(), 0, glw::FALSE, 0, glw::GL_WRITE_ONLY, glw::GL_R32I) };
        glu::expect_no_error(gl, "glBindImageTexture() call failed.")?;
    }

    // SAFETY: names owned by the guards above.
    unsafe {
        gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo_draw.get());
        glu::expect_no_error(gl, "glBindFramebuffer() call failed.")?;

        gl.framebuffer_texture_2d(
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            fbo_draw_to.get(),
            0,
        );
        glu::expect_no_error(gl, "glFramebufferTexture2D() call failed.")?;

        gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo_read.get());
        glu::expect_no_error(gl, "glBindFramebuffer() call failed.")?;

        gl.viewport(0, 0, 1, 1);
        glu::expect_no_error(gl, "glViewport() call failed.")?;

        gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1);
        glu::expect_no_error(gl, "glPixelStorei() call failed.")?;
    }

    // There are two new GL constants, where value we need to verify
    struct Run {
        essl_token_value: &'static str,
        gl_value: i32,
        min_value: i32,
        name: &'static str,
    }
    let runs = [
        Run {
            essl_token_value: "gl_MaxCullDistances",
            gl_value: gl_max_cull_distances_value,
            min_value: 8,
            name: "GL_MAX_CULL_DISTANCES",
        },
        Run {
            essl_token_value: "gl_MaxCombinedClipAndCullDistances",
            gl_value: gl_max_combined_clip_and_cull_distances_value,
            min_value: 8,
            name: "GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES",
        },
    ];

    for current_run in &runs {
        for current_stage in &COVERAGE_STAGES {
            // Check for OpenGL feature support
            if current_stage.use_cs && !has_compute(context) {
                continue; // no compute shader support
            }
            if (current_stage.use_tc || current_stage.use_te) && !has_tessellation(context) {
                continue; // no tessellation shader support
            }

            // Check that use of the GLSL built-in constant gl_MaxCullDistance in any shader stage (including compute shader) does not affect the shader compilation & program linking process.
            let stage_sources: [(ShaderType, &str, bool, Option<(&str, Option<&str>)>); 6] = [
                (ShaderType::Compute, COVERAGE_CS_TEMPLATE, current_stage.use_cs, None),
                (
                    ShaderType::Fragment,
                    COVERAGE_FS_TEMPLATE,
                    current_stage.use_fs,
                    Some(("INPUT_FS_NAME", current_stage.fs_input)),
                ),
                (
                    ShaderType::Geometry,
                    COVERAGE_GS_TEMPLATE,
                    current_stage.use_gs,
                    Some(("INPUT_GS_NAME", current_stage.gs_input)),
                ),
                (
                    ShaderType::TessControl,
                    COVERAGE_TC_TEMPLATE,
                    current_stage.use_tc,
                    Some(("INPUT_TC_NAME", current_stage.tc_input)),
                ),
                (
                    ShaderType::TessEvaluation,
                    COVERAGE_TE_TEMPLATE,
                    current_stage.use_te,
                    Some(("INPUT_TE_NAME", current_stage.te_input)),
                ),
                (ShaderType::Vertex, COVERAGE_VS_TEMPLATE, current_stage.use_vs, None),
            ];

            let mut sources = ProgramSources::default();
            for (shader_type, template, used, input) in stage_sources {
                if !used {
                    continue;
                }
                let mut body = StringTemplate::new(template).specialize(&specialization)?;
                body = body.replace("TOKEN", current_run.essl_token_value);
                if let Some((token, Some(value))) = input {
                    body = body.replace(token, value);
                }
                sources = sources.with(shader_type, body);
            }
            if let Some(tf_output_name) = current_stage.tf_output_name {
                sources = sources.with_transform_feedback(&[tf_output_name.to_string()], glw::GL_INTERLEAVED_ATTRIBS);
            }

            // Build the test program
            let program = build_program(gl, &sources)?;

            // Bind the test program
            // SAFETY: a linked program.
            unsafe { gl.use_program(program.program()) };
            glu::expect_no_error(gl, "glUseProgram() call failed.")?;

            // Execute the draw call. Transform Feed-back should be enabled for all iterations par the CS one, since we use a different tool to capture the result data in the latter case.
            if !current_stage.use_cs {
                // SAFETY: a transform feedback buffer is bound at index 0.
                unsafe {
                    gl.begin_transform_feedback(current_stage.tf_mode);
                    glu::expect_no_error(gl, "glBeginTransformFeedback() call failed.")?;

                    gl.draw_arrays(current_stage.draw_call_mode, 0, current_stage.n_draw_call_vertices);
                    glu::expect_no_error(gl, "glDrawArrays() call failed.")?;

                    gl.end_transform_feedback();
                    glu::expect_no_error(gl, "glEndTransformFeedback() call failed.")?;
                }
            } else {
                // SAFETY: a compute program is current.
                unsafe { gl.dispatch_compute(1, 1, 1) };
                glu::expect_no_error(gl, "glDispatchCompute() call failed.")?;
            }

            // Verify the result values
            if !current_stage.use_cs {
                // Retrieve the data captured by Transform Feedback
                // SAFETY: the buffer holds BO_SIZE bytes and four are mapped for reading.
                let result_value = unsafe {
                    let result_data_ptr = gl
                        .map_buffer_range(
                            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                            0,
                            std::mem::size_of::<u32>() as isize,
                            glw::GL_MAP_READ_BIT,
                        )
                        .cast::<i32>();
                    glu::expect_no_error(gl, "glMapBufferRange() call failed.")?;
                    if result_data_ptr.is_null() {
                        return fail("glMapBufferRange() returned NULL.");
                    }
                    let value = result_data_ptr.read();
                    gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER);
                    glu::expect_no_error(gl, "glUnmapBuffer() call failed.")?;
                    value
                };

                if result_value != current_run.gl_value {
                    log::info!(
                        "{} value [{}] does not match the one reported by glGetIntegerv() [{}]",
                        current_run.name,
                        result_value,
                        current_run.gl_value
                    );
                    return fail("GL constant value does not match the ES SL equivalent");
                }

                if result_value < current_run.min_value {
                    log::info!(
                        "{} value [{}] does not meet the minimum specification requirements [{}]",
                        current_run.name,
                        result_value,
                        current_run.min_value
                    );
                    return fail("GL constant value does not meet minimum specification requirements");
                }
            }

            // CS, FS write to separate textures
            for (n_stage_internal, to_id) in [cs_to.get(), fbo_draw_to.get()].into_iter().enumerate() {
                if (n_stage_internal == 0 && !current_stage.use_cs) || (n_stage_internal == 1 && !current_stage.use_fs)
                {
                    continue;
                }

                // Check the image data the test CS / FS should have written
                let mut result_value = 0i32;

                // NOTE: We're using our custom read framebuffer here, so we'll be reading from the texture, that the writes have been issued to earlier.
                // SAFETY: one GLint out for a 1x1 GL_RED_INTEGER read.
                unsafe {
                    gl.framebuffer_texture_2d(
                        glw::GL_READ_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        glw::GL_TEXTURE_2D,
                        to_id,
                        0,
                    );
                    glu::expect_no_error(gl, "glFramebufferTexture2D() call failed.")?;

                    gl.finish();
                    glu::expect_no_error(gl, "glMemoryBarrier() call failed.")?;

                    gl.read_pixels(
                        0,
                        0,
                        1,
                        1,
                        glw::GL_RED_INTEGER,
                        glw::GL_INT,
                        std::ptr::from_mut(&mut result_value).cast(),
                    );
                    glu::expect_no_error(gl, "glReadPixels() call failed.")?;
                }

                if result_value != current_run.gl_value {
                    log::info!(
                        "{} value accessible to the compute / fragment shader [{}] does not match the one reported by glGetIntegerv() [{}]",
                        current_run.name,
                        result_value,
                        current_run.gl_value
                    );
                    return fail("GL constant value does not match the ES SL equivalent");
                }

                if result_value < current_run.min_value {
                    log::info!(
                        "{} value accessible to the compute / fragment shader [{}] does not meet the minimum specification requirements [{}]",
                        current_run.name,
                        result_value,
                        current_run.min_value
                    );
                    return fail("GL constant value does not meet minimum specification requirements");
                }
            }

            // Clear the data buffer before we continue
            let bo_clear_data = [0u8; BO_SIZE];
            // SAFETY: `bo_clear_data` is BO_SIZE bytes, the size of the buffer.
            unsafe {
                gl.buffer_sub_data(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    0,
                    BO_SIZE as isize,
                    bo_clear_data.as_ptr().cast(),
                );
                glu::expect_no_error(gl, "glBufferSubData() call failed.")?;

                // Clear the texture mip-map before we continue
                let clear_values = [0i32; 4];
                gl.clear_bufferiv(glw::GL_COLOR, 0, clear_values.as_ptr());
                glu::expect_no_error(gl, "glClearBufferiv() call failed.")?;
            }

            // Release program before we move on to the next iteration (dropped here)
        }
    }

    Ok(TestStatus::pass("Pass"))
}

// ---------------------------------------------------------------------------------------------
// FunctionalTest
// ---------------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
enum PrimitiveMode {
    Lines,
    Points,
    Triangles,
}

impl PrimitiveMode {
    /// `primitiveModeToString`
    fn name(self) -> &'static str {
        match self {
            Self::Lines => "mode_lines",
            Self::Points => "mode_points",
            Self::Triangles => "mode_triangles",
        }
    }

    fn vertices(self) -> u32 {
        match self {
            Self::Lines => 2,
            Self::Points => 1,
            Self::Triangles => 3,
        }
    }

    fn sub_grid_cell_size(self) -> i32 {
        match self {
            Self::Lines => 8,
            Self::Points => 3,
            Self::Triangles => 8,
        }
    }

    fn gl_mode(self) -> glw::GLenum {
        match self {
            Self::Lines => glw::GL_LINES,
            Self::Points => glw::GL_POINTS,
            Self::Triangles => glw::GL_TRIANGLES,
        }
    }
}

/// `FunctionalTest::_test_item`; `use_core_functionality` is `is_core` for the items that ask for it.
#[derive(Clone, Copy)]
struct TestItem {
    test_id: i32,
    redeclare_clipdistances_array: bool,
    redeclare_culldistances_array: bool,
    dynamic_index_writes: bool,
    use_passthrough_gs: bool,
    use_passthrough_ts: bool,
    use_core_functionality_if_core: bool,
    fetch_culldistances: bool,
}

#[allow(clippy::too_many_arguments)]
const fn item(
    test_id: i32,
    redeclare_clipdistances_array: bool,
    redeclare_culldistances_array: bool,
    dynamic_index_writes: bool,
    use_passthrough_gs: bool,
    use_passthrough_ts: bool,
    use_core_functionality_if_core: bool,
    fetch_culldistances: bool,
) -> TestItem {
    TestItem {
        test_id,
        redeclare_clipdistances_array,
        redeclare_culldistances_array,
        dynamic_index_writes,
        use_passthrough_gs,
        use_passthrough_ts,
        use_core_functionality_if_core,
        fetch_culldistances,
    }
}

const TEST_ITEMS: [TestItem; 9] = [
    // Use the basic outline to test the basic functionality of cull distances.
    item(0, true, true, false, false, false, true, false),
    // Use the basic outline but don't redeclare gl_ClipDistance with a size.
    item(1, false, true, false, false, false, true, false),
    // Use the basic outline but don't redeclare gl_CullDistance with a size.
    item(2, true, false, false, false, false, true, false),
    // Use the basic outline but don't redeclare either gl_ClipDistance or gl_CullDistance with a size.
    item(3, false, false, false, false, false, true, false),
    // Use the basic outline but use dynamic indexing when writing the elements of the gl_ClipDistance and gl_CullDistance arrays.
    item(4, true, true, true, false, false, true, false),
    // Use the basic outline but add a geometry shader to the program that simply passes through all written clip and cull distances.
    item(5, true, true, false, true, false, true, false),
    // Use the basic outline but add a tessellation control and tessellation evaluation shader to the program which simply pass through all written clip and cull distances.
    item(6, true, true, false, false, true, true, false),
    // Test that using #extension with GL_ARB_cull_distance allows using the feature even with an earlier version of GLSL. Also test that the extension name is available as preprocessor #define.
    item(7, true, true, false, false, false, false, false),
    // Use a program that has only a vertex shader and a fragment shader, the fragment shader outputs the cull distances written by the vertex shader by reading them from the built-in array gl_CullDistance.
    item(8, true, true, false, false, false, false, true),
];

struct BuildParams {
    clipdistances_array_size: u32,
    culldistances_array_size: u32,
    dynamic_index_writes: bool,
    primitive_mode: PrimitiveMode,
    redeclare_clipdistances: bool,
    redeclare_culldistances: bool,
    use_core_functionality: bool,
    use_gs: bool,
    use_ts: bool,
    fetch_culldistance_from_fs: bool,
}

/// `FunctionalTest::buildPO`
fn build_po<'gl>(gl: &'gl glw::Functions, p: &BuildParams) -> Result<ShaderProgram<'gl>, TestError> {
    let clip_size = p.clipdistances_array_size;
    let cull_size = p.culldistances_array_size;
    // Avoid zero-sized array compilation error
    let clipdistances_input_size = if clip_size > 0 { clip_size } else { 1 };
    let culldistances_input_size = if cull_size > 0 { cull_size } else { 1 };

    let mut specialization = base_specialization();
    let (version, extension) = if !p.use_core_functionality {
        (
            "#version 150",
            "#extension GL_ARB_cull_distance : require\n\n#ifndef GL_ARB_cull_distance\n    #error GL_ARB_cull_distance is undefined\n#endif\n",
        )
    } else {
        ("#version 450", "")
    };
    for (key, value) in specialization.iter_mut() {
        match *key {
            "VERSION" | "TS_VERSION" | "GS_VERSION" => *value = version.to_string(),
            "EXTENSION" => *value = extension.to_string(),
            _ => {}
        }
    }

    let shaders = [
        (ShaderType::Fragment, FS_TEMPLATE, true),
        (ShaderType::Geometry, GS_TEMPLATE, p.use_gs),
        (ShaderType::TessControl, TC_TEMPLATE, p.use_ts),
        (ShaderType::TessEvaluation, TE_TEMPLATE, p.use_ts),
        (ShaderType::Vertex, VS_TEMPLATE, true),
    ];

    let mut sources = ProgramSources::default();

    // Construct shader bodies out of templates
    for (shader_type, shader_template, used) in shaders {
        if !used {
            continue;
        }

        let mut shader_source = StringTemplate::new(shader_template).specialize(&specialization)?;

        // Shader-specific actions
        match shader_type {
            ShaderType::Fragment => {
                if p.fetch_culldistance_from_fs {
                    shader_source = shader_source.replace("TEMPLATE_ASSIGN_RETURN_VALUE", FETCH_FUNCTION);

                    let mut fetch_sum_setters = String::new();
                    for i in 0..clip_size {
                        fetch_sum_setters.push_str(&format!("    sum += abs(gl_ClipDistance[{i}]) * {}.0;\n", i + 1));
                    }

                    fetch_sum_setters.push('\n');

                    for i in 0..cull_size {
                        fetch_sum_setters.push_str(&format!(
                            "    sum += abs(gl_CullDistance[{i}]) * {}.0;\n",
                            i + 1 + clip_size
                        ));
                    }

                    shader_source = shader_source.replace("TEMPLATE_SUM_SETTER", &fetch_sum_setters);
                    shader_source = shader_source.replace(
                        "TEMPLATE_SUM_DIVIDER",
                        &format!("{}.0", (clip_size + cull_size) * (clip_size + cull_size + 1)),
                    );
                } else {
                    shader_source =
                        shader_source.replace("TEMPLATE_ASSIGN_RETURN_VALUE", "#define ASSIGN_RETURN_VALUE 1.0");
                }
            }

            ShaderType::Geometry => {
                shader_source = shader_source.replace(
                    "TEMPLATE_ASSIGN_CLIP_DISTANCE",
                    "gl_ClipDistance[IDX] = gl_in[n_vertex_index].gl_ClipDistance[IDX]",
                );
                shader_source = shader_source.replace(
                    "TEMPLATE_ASSIGN_CULL_DISTANCE",
                    "gl_CullDistance[IDX] = gl_in[n_vertex_index].gl_CullDistance[IDX]",
                );

                let (layout_in, layout_out) = match p.primitive_mode {
                    PrimitiveMode::Lines => (
                        "layout(lines)                        in;",
                        "layout(line_strip, max_vertices = 2) out;",
                    ),
                    PrimitiveMode::Points => (
                        "layout(points)                   in;",
                        "layout(points, max_vertices = 1) out;",
                    ),
                    PrimitiveMode::Triangles => (
                        "layout(triangles)                        in;",
                        "layout(triangle_strip, max_vertices = 3) out;",
                    ),
                };
                shader_source = shader_source.replace("TEMPLATE_LAYOUT_IN", layout_in);
                shader_source = shader_source.replace("TEMPLATE_LAYOUT_OUT", layout_out);
            }

            ShaderType::TessControl => {
                shader_source = shader_source.replace(
                    "TEMPLATE_ASSIGN_CLIP_DISTANCE",
                    "gl_out[gl_InvocationID].gl_ClipDistance[IDX] = gl_in[gl_InvocationID].gl_ClipDistance[IDX]",
                );
                shader_source = shader_source.replace(
                    "TEMPLATE_ASSIGN_CULL_DISTANCE",
                    "gl_out[gl_InvocationID].gl_CullDistance[IDX] = gl_in[gl_InvocationID].gl_CullDistance[IDX]",
                );

                let layout_out = match p.primitive_mode {
                    PrimitiveMode::Lines => "layout(vertices = 2) out;",
                    PrimitiveMode::Points => "layout(vertices = 1) out;",
                    PrimitiveMode::Triangles => "layout(vertices = 3) out;",
                };
                shader_source = shader_source.replace("TEMPLATE_LAYOUT_OUT", layout_out);
            }

            ShaderType::TessEvaluation => {
                let (layout_in, out_formula, clip, cull) = match p.primitive_mode {
                    PrimitiveMode::Lines => (
                        "layout(isolines) in;",
                        "mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x)",
                        "gl_ClipDistance[IDX] = mix(gl_in[0].gl_ClipDistance[IDX], gl_in[1].gl_ClipDistance[IDX], gl_TessCoord.x)",
                        "gl_CullDistance[IDX] = mix(gl_in[0].gl_CullDistance[IDX], gl_in[1].gl_CullDistance[IDX], gl_TessCoord.x)",
                    ),
                    PrimitiveMode::Points => (
                        "layout(isolines, point_mode) in;",
                        "gl_in[0].gl_Position",
                        "gl_ClipDistance[IDX] = gl_in[0].gl_ClipDistance[IDX]",
                        "gl_CullDistance[IDX] = gl_in[0].gl_CullDistance[IDX]",
                    ),
                    PrimitiveMode::Triangles => (
                        "layout(triangles) in;",
                        "vec4(mat3(gl_in[0].gl_Position.xyz, gl_in[1].gl_Position.xyz, gl_in[2].gl_Position.xyz) * gl_TessCoord, 1.0)",
                        "gl_ClipDistance[IDX] = dot(vec3(gl_in[0].gl_ClipDistance[IDX], gl_in[1].gl_ClipDistance[IDX], gl_in[2].gl_ClipDistance[IDX]), gl_TessCoord)",
                        "gl_CullDistance[IDX] = dot(vec3(gl_in[0].gl_CullDistance[IDX], gl_in[1].gl_CullDistance[IDX], gl_in[2].gl_CullDistance[IDX]), gl_TessCoord)",
                    ),
                };
                shader_source = shader_source.replace("TEMPLATE_LAYOUT_IN", layout_in);
                shader_source = shader_source.replace("TEMPLATE_OUT_FORMULA", out_formula);
                shader_source = shader_source.replace("TEMPLATE_ASSIGN_CLIP_DISTANCE", clip);
                shader_source = shader_source.replace("TEMPLATE_ASSIGN_CULL_DISTANCE", cull);
            }

            ShaderType::Vertex => {
                shader_source = shader_source.replace(
                    "TEMPLATE_CLIPDISTANCE_ATTRIB_DECLARATIONS",
                    &format!("in float clipdistance_data[{clipdistances_input_size}];\n"),
                );
                shader_source = shader_source.replace(
                    "TEMPLATE_CULLDISTANCE_ATTRIB_DECLARATIONS",
                    &format!("in float culldistance_data[{culldistances_input_size}];\n"),
                );
                shader_source = shader_source.replace(
                    "TEMPLATE_ASSIGN_CLIP_DISTANCE",
                    "gl_ClipDistance[IDX] = clipdistance_data[IDX]",
                );
                shader_source = shader_source.replace(
                    "TEMPLATE_ASSIGN_CULL_DISTANCE",
                    "gl_CullDistance[IDX] = culldistance_data[IDX]",
                );
            }

            ShaderType::Compute => return fail("Unknown shader type"),
        }

        // Adjust clipdistances declaration
        let mut clipdistance_array_declaration = String::new();
        let mut clipdistance_in_array_declaration = String::new();
        if p.redeclare_clipdistances && clip_size > 0 {
            match shader_type {
                ShaderType::Fragment => {
                    if p.fetch_culldistance_from_fs {
                        clipdistance_array_declaration = format!("in float gl_ClipDistance[{clip_size}];");
                    }
                }
                ShaderType::TessControl => {
                    clipdistance_array_declaration = format!("float gl_ClipDistance[{clip_size}];");
                }
                _ => {
                    clipdistance_array_declaration = format!("out float gl_ClipDistance[{clip_size}];");
                    clipdistance_in_array_declaration = format!("in float gl_ClipDistance[{clip_size}];");
                }
            }
        }
        shader_source = shader_source.replace("TEMPLATE_REDECLARE_CLIPDISTANCE", &clipdistance_array_declaration);
        shader_source = shader_source.replace("TEMPLATE_REDECLARE_IN_CLIPDISTANCE", &clipdistance_in_array_declaration);

        // Adjust culldistances declaration
        let mut culldistance_array_declaration = String::new();
        let mut culldistance_in_array_declaration = String::new();
        if p.redeclare_culldistances && cull_size > 0 {
            match shader_type {
                ShaderType::Fragment => {
                    if p.fetch_culldistance_from_fs {
                        culldistance_array_declaration = format!("in float gl_CullDistance[{cull_size}];");
                    }
                }
                ShaderType::TessControl => {
                    culldistance_array_declaration = format!("float gl_CullDistance[{cull_size}];");
                }
                _ => {
                    culldistance_array_declaration = format!("out float gl_CullDistance[{cull_size}];");
                    culldistance_in_array_declaration = format!("in float gl_CullDistance[{cull_size}];");
                }
            }
        }
        shader_source = shader_source.replace("TEMPLATE_REDECLARE_CULLDISTANCE", &culldistance_array_declaration);
        shader_source = shader_source.replace("TEMPLATE_REDECLARE_IN_CULLDISTANCE", &culldistance_in_array_declaration);

        // Adjust clip/cull distances setters
        let array_setters = if p.dynamic_index_writes {
            DYNAMIC_ARRAY_SETTERS
                .replace("TEMPLATE_N_GL_CLIPDISTANCE_ENTRIES", &clip_size.to_string())
                .replace("TEMPLATE_N_GL_CULLDISTANCE_ENTRIES", &cull_size.to_string())
        } else {
            let mut static_array_setters = String::from("\n");
            for clipdistances_array_entry in 0..clip_size {
                static_array_setters.push_str(&format!("        ASSIGN_CLIP_DISTANCE({clipdistances_array_entry});\n"));
            }
            static_array_setters.push('\n');
            for culldistances_array_entry in 0..cull_size {
                static_array_setters.push_str(&format!("        ASSIGN_CULL_DISTANCE({culldistances_array_entry});\n"));
            }
            static_array_setters
        };
        shader_source = shader_source.replace("TEMPLATE_ARRAY_SETTERS", &array_setters);

        sources = sources.with(shader_type, shader_source);
    }

    build_program(gl, &sources)
}

/// What `configureVAO` leaves in `m_bo_data`, `m_render_primitives`, `m_render_vertices` and `m_sub_grid_cell_size`.
struct Geometry {
    bo_data: Vec<f32>,
    render_primitives: i32,
    render_vertices: i32,
    sub_grid_cell_size: i32,
}

/// The data generation half of `FunctionalTest::configureVAO` - see the grid description upstream.
fn generate_geometry(
    clipdistances_array_size: u32,
    culldistances_array_size: u32,
    primitive_mode: PrimitiveMode,
) -> Result<Geometry, TestError> {
    let n_sub_grid_cells: u32 = 3;
    let sub_grid_cell_size = primitive_mode.sub_grid_cell_size();
    let grid_cell_size = n_sub_grid_cells as i32 * sub_grid_cell_size;
    let n_primitive_vertices = primitive_mode.vertices();

    let n_grid_cells_x = if culldistances_array_size != 0 {
        culldistances_array_size
    } else {
        1
    };
    let n_grid_cells_y = if clipdistances_array_size != 0 {
        clipdistances_array_size
    } else {
        1
    };
    let n_pervertex_float_attributes = clipdistances_array_size + culldistances_array_size + 2 + 2;
    let n_primitives_total = n_grid_cells_x * n_sub_grid_cells * n_grid_cells_y * n_sub_grid_cells;
    let n_vertices_total = n_primitives_total * n_primitive_vertices;

    let s = sub_grid_cell_size;
    // vertex offsets to subgrid cell origin, then pixel offsets
    let offsets_line_draw_x = [1, s - 1];
    let offsets_line_draw_y = [1, s - 1];
    let offsets_line_checkpoint_x = [1, s - 2];
    let offsets_line_checkpoint_y = [1, s - 2];
    let offsets_point = [1];
    let offsets_triangle_draw_x = [1, s - 1, s - 1];
    let offsets_triangle_draw_y = [1, s - 1, 1];
    let offsets_triangle_checkpoint_x = [1, s - 2, s - 2];
    let offsets_triangle_checkpoint_y = [1, s - 2, 1];
    let offsets_pixel_center_x = if primitive_mode == PrimitiveMode::Points {
        0.5f32
    } else {
        0.0
    };
    let offsets_pixel_center_y = offsets_pixel_center_x;

    let mut bo_data: Vec<f32> = Vec::with_capacity((n_vertices_total * n_pervertex_float_attributes) as usize);

    // Generate test data for cell_y-th clip distance
    for cell_y in 0..n_grid_cells_y {
        // Generate test data for cell_x-th cull distance
        for cell_x in 0..n_grid_cells_x {
            // Check clip distance sub cases: positive for all vertices, negative for 0th vertex, negative for all vertices
            for n_sub_cell_y in 0..n_sub_grid_cells {
                // Check cull distance sub cases, the same three
                for n_sub_cell_x in 0..n_sub_grid_cells {
                    // Generate vertices in primitive
                    for n_primitive_vertex in 0..n_primitive_vertices {
                        // Fill in clipdistance array for the n_primitive_vertex vertex in primitive
                        for n_clipdistance_entry in 0..clipdistances_array_size {
                            let distance_value = if n_clipdistance_entry == cell_y {
                                // The primitive vertex should be affected by the clip distance
                                let negative = match n_sub_cell_y {
                                    0 => false,
                                    1 => n_primitive_vertex == 0,
                                    2 => true,
                                    _ => return fail("Invalid subgrid cell index"),
                                };

                                (if negative { -1.0f32 } else { 1.0f32 }) * (n_clipdistance_entry + 1) as f32
                            } else {
                                // For clip distances other than tested: assign positive value to avoid its influence.
                                (clipdistances_array_size + n_clipdistance_entry + 1) as f32
                            };

                            bo_data.push(distance_value / clipdistances_array_size as f32);
                        }

                        // Fill in culldistance array for the n_primitive_vertex vertex in primitive
                        for n_culldistance_entry in 0..culldistances_array_size {
                            let distance_value = if n_culldistance_entry == cell_x {
                                // The primitive vertex should be affected by the cull distance
                                let negative = match n_sub_cell_x {
                                    0 => false,
                                    1 => n_primitive_vertex == 0,
                                    2 => true,
                                    _ => return fail("Invalid subgrid cell index"),
                                };

                                (if negative { -1.0f32 } else { 1.0f32 }) * (n_culldistance_entry + 1) as f32
                            } else if n_primitive_vertices > 1 && n_primitive_vertex == 0 {
                                // For cull distances other than tested: assign 0th vertex negative value, to check absence of between-distances influence.
                                -((culldistances_array_size + n_culldistance_entry + 1) as f32)
                            } else {
                                // This culldistance is out of interest: assign positive value.
                                (culldistances_array_size + n_culldistance_entry + 1) as f32
                            };

                            bo_data.push(distance_value / culldistances_array_size as f32);
                        }

                        // Generate primitve vertex draw and checkpoint coordinates
                        let v = n_primitive_vertex as usize;
                        let (
                            vertex_draw_pixel_offset_x,
                            vertex_draw_pixel_offset_y,
                            vertex_checkpoint_pixel_offset_x,
                            vertex_checkpoint_pixel_offset_y,
                        ) = match primitive_mode {
                            PrimitiveMode::Lines => (
                                offsets_line_draw_x[v],
                                offsets_line_draw_y[v],
                                offsets_line_checkpoint_x[v],
                                offsets_line_checkpoint_y[v],
                            ),
                            PrimitiveMode::Points => {
                                (offsets_point[v], offsets_point[v], offsets_point[v], offsets_point[v])
                            }
                            PrimitiveMode::Triangles => (
                                offsets_triangle_draw_x[v],
                                offsets_triangle_draw_y[v],
                                offsets_triangle_checkpoint_x[v],
                                offsets_triangle_checkpoint_y[v],
                            ),
                        };

                        // Origin of sub_cell
                        let sub_cell_origin_x =
                            (cell_x as i32) * grid_cell_size + (n_sub_cell_x as i32) * sub_grid_cell_size;
                        let sub_cell_origin_y =
                            (cell_y as i32) * grid_cell_size + (n_sub_cell_y as i32) * sub_grid_cell_size;
                        // Normalized texture coordinates of vertex draw position.
                        let x = ((sub_cell_origin_x + vertex_draw_pixel_offset_x) as f32 + offsets_pixel_center_x)
                            / TO_WIDTH as f32;
                        let y = ((sub_cell_origin_y + vertex_draw_pixel_offset_y) as f32 + offsets_pixel_center_y)
                            / TO_HEIGHT as f32;
                        // Normalized texture coordinates of vertex checkpoint position.
                        let checkpoint_x =
                            (sub_cell_origin_x + vertex_checkpoint_pixel_offset_x) as f32 / TO_WIDTH as f32;
                        let checkpoint_y =
                            (sub_cell_origin_y + vertex_checkpoint_pixel_offset_y) as f32 / TO_HEIGHT as f32;

                        // Add vertex draw coordinates into buffer.
                        bo_data.push(x);
                        bo_data.push(y);

                        // Add vertex checkpoint coordinates into buffer.
                        bo_data.push(checkpoint_x);
                        bo_data.push(checkpoint_y);
                    }
                }
            }
        }
    }

    // Quick check: make sure we pushed required amount of data
    if bo_data.len() != (n_vertices_total * n_pervertex_float_attributes) as usize {
        return fail("Generated vertex data has an unexpected size");
    }

    Ok(Geometry {
        bo_data,
        render_primitives: n_primitives_total as i32,
        render_vertices: n_vertices_total as i32,
        sub_grid_cell_size,
    })
}

/// The GL half of `FunctionalTest::configureVAO`: upload `m_bo_data` and bind the attributes to `program`.
fn configure_vao(
    gl: &glw::Functions,
    program: &ShaderProgram<'_>,
    bo: &glu::Buffer<'_>,
    vao: &glu::VertexArray<'_>,
    clipdistances_array_size: u32,
    culldistances_array_size: u32,
    geometry: &Geometry,
) -> Result<(), TestError> {
    let n_pervertex_float_attributes = clipdistances_array_size + culldistances_array_size + 2 + 2;

    // SAFETY: `bo_data` outlives the upload, and every attribute offset lies inside one vertex of the stride.
    unsafe {
        // Copy the data to the buffer object
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, bo.get());
        glu::expect_no_error(gl, "glBindBuffer() call failed.")?;

        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(geometry.bo_data.as_slice()) as isize,
            geometry.bo_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );
        glu::expect_no_error(gl, "glBufferData() call failed.")?;

        // Retrieve clipdistance and culldistance attribute locations
        gl.bind_vertex_array(vao.get());
        glu::expect_no_error(gl, "glBindVertexArray() call failed.")?;

        let po_position_location = gl.get_attrib_location(program.program(), c"position".as_ptr());
        glu::expect_no_error(gl, "glGetAttribLocation() call(s) failed.")?;
        if po_position_location == -1 {
            return fail("The position attribute is not active");
        }

        let mut current_offset: usize = 0;
        let stride = (n_pervertex_float_attributes as usize * std::mem::size_of::<f32>()) as i32;

        gl.bind_vertex_array(vao.get());
        glu::expect_no_error(gl, "glBindVertexArray() call failed.")?;

        let attribute_arrays = [
            ("clipdistance_data", clipdistances_array_size),
            ("culldistance_data", culldistances_array_size),
        ];
        for (prefix, array_size) in attribute_arrays {
            for n_entry in 0..array_size {
                let atrib_name =
                    std::ffi::CString::new(format!("{prefix}[{n_entry}]")).expect("attribute name holds no nul byte");

                let location = gl.get_attrib_location(program.program(), atrib_name.as_ptr());
                if location == -1 {
                    return Err(TestError::Fail(format!(
                        "The {prefix}[{n_entry}] attribute is not active"
                    )));
                }

                gl.vertex_attrib_pointer(
                    location as u32,
                    1,
                    glw::GL_FLOAT,
                    glw::FALSE,
                    stride,
                    current_offset as *const std::ffi::c_void,
                );
                glu::expect_no_error(gl, "glVertexAttribPointer() call failed.")?;

                gl.enable_vertex_attrib_array(location as u32);
                glu::expect_no_error(gl, "glEnableVertexAttribArray() call failed.")?;

                current_offset += std::mem::size_of::<f32>();
            }
        }

        gl.vertex_attrib_pointer(
            po_position_location as u32,
            2,
            glw::GL_FLOAT,
            glw::FALSE,
            stride,
            current_offset as *const std::ffi::c_void,
        );
        glu::expect_no_error(gl, "glVertexAttribPointer() call failed")?;

        gl.enable_vertex_attrib_array(po_position_location as u32);
        glu::expect_no_error(gl, "glEnableVertexAttribArray() call failed")?;
    }

    Ok(())
}

/// `FunctionalTest::executeRenderTest`
#[allow(clippy::too_many_arguments)]
fn execute_render_test(
    gl: &glw::Functions,
    program: &ShaderProgram<'_>,
    geometry: &Geometry,
    clipdistances_array_size: u32,
    culldistances_array_size: u32,
    primitive_mode: PrimitiveMode,
    use_tesselation: bool,
    fetch_culldistance_from_fs: bool,
) -> Result<(), TestError> {
    let primitive_vertices_count = primitive_mode.vertices();
    let stride_in_floats = (clipdistances_array_size + culldistances_array_size + 2 + 2) as usize;
    let clip_size = clipdistances_array_size as usize;
    let cull_size = culldistances_array_size as usize;
    let bo_data = &geometry.bo_data;
    let sub_grid_cell_size = geometry.sub_grid_cell_size;

    let mut mode = primitive_mode.gl_mode();

    // SAFETY: a current context; the draw uses the program and the attribute arrays set up by `configure_vao`.
    unsafe {
        if use_tesselation {
            mode = glw::GL_PATCHES;

            gl.patch_parameteri(glw::GL_PATCH_VERTICES, primitive_vertices_count as i32);
            glu::expect_no_error(gl, "glPatchParameteri() call failed.")?;
        }

        gl.clear(glw::GL_COLOR_BUFFER_BIT);
        glu::expect_no_error(gl, "glClear() call failed.")?;

        gl.use_program(program.program());
        glu::expect_no_error(gl, "glUseProgram() call failed.")?;

        for n_clipdistance_entry in 0..clipdistances_array_size {
            gl.enable(glw::GL_CLIP_DISTANCE0 + n_clipdistance_entry);
            glu::expect_no_error(gl, "gl.enable(GL_CLIP_DISTANCE)() call failed.")?;
        }

        gl.draw_arrays(mode, 0, geometry.render_vertices);
        glu::expect_no_error(gl, "glDrawArray() call(s) failed.")?;

        for n_clipdistance_entry in 0..clipdistances_array_size {
            gl.disable(glw::GL_CLIP_DISTANCE0 + n_clipdistance_entry);
            glu::expect_no_error(gl, "gl.disable(GL_CLIP_DISTANCE)() call failed.")?;
        }

        gl.use_program(0);
        glu::expect_no_error(gl, "glUseProgram() call failed.")?;
    }

    // Read generated texture into m_to_pixel_data_cache
    let mut to_pixel_data_cache =
        vec![0.0f32; TO_WIDTH as usize * TO_HEIGHT as usize * TO_PIXEL_DATA_CACHE_COLOR_COMPONENTS];
    // SAFETY: the buffer holds a whole RGBA float image of the texture's size.
    unsafe {
        gl.read_pixels(
            0,
            0,
            TO_WIDTH as i32,
            TO_HEIGHT as i32,
            glw::GL_RGBA,
            glw::GL_FLOAT,
            to_pixel_data_cache.as_mut_ptr().cast(),
        )
    };
    glu::expect_no_error(gl, "glReadPixels() call failed.")?;

    let read_red_pixel_value = |x: i32, y: i32| -> f32 {
        to_pixel_data_cache[(TO_WIDTH as i32 * y + x) as usize * TO_PIXEL_DATA_CACHE_COLOR_COMPONENTS]
    };
    let checkpoint_of = |base_index_of_vertex: usize| -> (i32, i32) {
        let checkpoint_position_index = base_index_of_vertex + clip_size + cull_size + 2;
        (
            (TO_WIDTH as f32 * bo_data[checkpoint_position_index]) as i32,
            (TO_HEIGHT as f32 * bo_data[checkpoint_position_index + 1]) as i32,
        )
    };

    for n_primitive_index in 0..geometry.render_primitives as usize {
        let base_index_of_primitive = n_primitive_index * primitive_vertices_count as usize * stride_in_floats;
        let mut primitive_culled = false;
        let mut primitive_culled_by_distance: i32 = -1;

        // Check the bounding box is clear
        let (checkpoint_x, checkpoint_y) = checkpoint_of(base_index_of_primitive);
        let origin_x = checkpoint_x - 1;
        let origin_y = checkpoint_y - 1;
        for pixel_offset in 0..sub_grid_cell_size {
            if read_red_pixel_value(origin_x + pixel_offset, origin_y) != 0.0 {
                return fail("Top edge of bounding box is overwritten");
            }

            if read_red_pixel_value(origin_x + sub_grid_cell_size - 1, origin_y + pixel_offset) != 0.0 {
                return fail("Right edge of bounding box is overwritten");
            }

            if read_red_pixel_value(
                origin_x + sub_grid_cell_size - 1 - pixel_offset,
                origin_y + sub_grid_cell_size - 1,
            ) != 0.0
            {
                return fail("Bottom edge of bounding box is overwritten");
            }

            if read_red_pixel_value(origin_x, origin_y + sub_grid_cell_size - 1 - pixel_offset) != 0.0 {
                return fail("Left edge of bounding box is overwritten");
            }
        }

        // Determine if primitive has been culled
        for n_culldistance_entry in 0..cull_size {
            let mut distance_negative_in_all_primitive_vertices = true;

            for n_primitive_vertex in 0..primitive_vertices_count as usize {
                let base_index_of_vertex_internal = base_index_of_primitive + n_primitive_vertex * stride_in_floats;
                let culldistance_array_offset = base_index_of_vertex_internal + clip_size;

                if bo_data[culldistance_array_offset + n_culldistance_entry] >= 0.0 {
                    // Primitive is not culled, due to one of its distances is not negative
                    distance_negative_in_all_primitive_vertices = false;

                    // Skip left vertices for this distance
                    break;
                }
            }

            // The distance is negative in all primitive vertices, so this distance culls the primitive
            if distance_negative_in_all_primitive_vertices {
                primitive_culled = true;
                primitive_culled_by_distance = n_culldistance_entry as i32;

                // Skip left distances from check
                break;
            }
        }

        // Validate culling
        if primitive_culled {
            // Check whether primitive was culled and all its vertices are invisible
            for n_primitive_vertex in 0..primitive_vertices_count as usize {
                let base_index_of_vertex_internal = base_index_of_primitive + n_primitive_vertex * stride_in_floats;
                let (checkpoint_x_internal, checkpoint_y_internal) = checkpoint_of(base_index_of_vertex_internal);
                let vertex_color_red_value = read_red_pixel_value(checkpoint_x_internal, checkpoint_y_internal);

                // Make sure vertex is invisible
                if vertex_color_red_value != 0.0 {
                    log::info!(
                        "Primitive number [{n_primitive_index}] should be culled by distance [{primitive_culled_by_distance}]but primitive vertex at ({checkpoint_x},{checkpoint_y}) is visible."
                    );

                    return fail("Primitive is expected to be culled, but one of its vertices is visible.");
                }
            }

            // Primitive is culled, no reason to check clipping
            continue;
        }

        let mut all_vertices_are_clipped = true;

        for n_primitive_vertex in 0..primitive_vertices_count as usize {
            let base_index_of_vertex_internal = base_index_of_primitive + n_primitive_vertex * stride_in_floats;
            let clipdistance_array_index = base_index_of_vertex_internal;
            let (checkpoint_x_internal, checkpoint_y_internal) = checkpoint_of(base_index_of_vertex_internal);
            let vertex_clipdistance_array = &bo_data[clipdistance_array_index..];
            let mut vertex_clipped = false;
            let mut vertex_clipped_by_distance = 0;
            let vertex_color_red_value = read_red_pixel_value(checkpoint_x_internal, checkpoint_y_internal);

            // Check whether pixel should be clipped
            for n_clipdistance_entry in 0..clip_size {
                if vertex_clipdistance_array[n_clipdistance_entry] < 0.0 {
                    vertex_clipped = true;
                    vertex_clipped_by_distance = n_clipdistance_entry;

                    break;
                }
            }

            all_vertices_are_clipped &= vertex_clipped;

            // Validate whether real data same as expected
            if vertex_clipped {
                if vertex_color_red_value != 0.0 {
                    log::info!(
                        "In primitive number [{n_primitive_index}] vertex at ({checkpoint_x},{checkpoint_y}) should be clipped by distance [{vertex_clipped_by_distance}] (distance value [{}])",
                        vertex_clipdistance_array[vertex_clipped_by_distance]
                    );

                    return fail("Vertex is expected to be clipped and invisible, while it is visible.");
                }
            } else if vertex_color_red_value == 0.0 {
                log::info!(
                    "In primitive number [{n_primitive_index}] vertex at ({checkpoint_x},{checkpoint_y}) should not be clipped."
                );

                return fail("Vertex is unexpectedly clipped or invisible");
            }
        }

        if !all_vertices_are_clipped {
            // Check fetched values from the shader (Point 2 of Basic Outline : "Use program that...")
            if fetch_culldistance_from_fs {
                for n_primitive_vertex in 0..primitive_vertices_count as usize {
                    // Get shader output value
                    let base_index_of_vertex_internal = base_index_of_primitive + n_primitive_vertex * stride_in_floats;
                    let culldistances_index = base_index_of_vertex_internal + clip_size;
                    let (checkpoint_x_internal, checkpoint_y_internal) = checkpoint_of(base_index_of_vertex_internal);
                    let vertex_color_red_value = read_red_pixel_value(checkpoint_x_internal, checkpoint_y_internal);

                    // Calculate culldistances check sum hash
                    let mut sum = 0.0f32;

                    for n_clipdistance_entry in 0..clip_size {
                        sum += bo_data[base_index_of_vertex_internal + n_clipdistance_entry].abs()
                            * (n_clipdistance_entry + 1) as f32;
                    }

                    for n_culldistance_entry in 0..cull_size {
                        sum += bo_data[culldistances_index + n_culldistance_entry].abs()
                            * (n_culldistance_entry + 1 + clip_size) as f32;
                    }

                    // limit sum and return
                    let mut sum_hash = sum / ((clip_size + cull_size) * (clip_size + cull_size + 1)) as f32;

                    sum_hash = if sum_hash < 1.0 { sum_hash } else { 1.0 };

                    // Compare against setup value, precision 4 / 65535
                    let precision_error = 0.000061036f64;
                    if f64::from((vertex_color_red_value - sum_hash).abs()) > precision_error {
                        log::info!(
                            "Primitive number [{n_primitive_index}] should have culldistance hash sum {sum_hash}but primitive vertex at ({checkpoint_x},{checkpoint_y}) has sum hash equal to {vertex_color_red_value}"
                        );

                        return fail("Culled distances returned from fragment shader dose not match expected values.");
                    }
                }
            }
        }
    }

    Ok(())
}

/// `FunctionalTest::test`
fn functional_test(
    context: &Context,
    test_item: &TestItem,
    primitive_mode: PrimitiveMode,
    iteration: i32,
) -> TestOutcome {
    let gl = context.gl();
    let is_core = context.context_type().supports_core(4, 5);

    // Retrieve important GL constant values
    let gl_max_clip_distances_value = get_integer(gl, glw::GL_MAX_CLIP_DISTANCES);
    let gl_max_combined_clip_and_cull_distances_value = get_integer(gl, glw::GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES);
    let gl_max_cull_distances_value = get_integer(gl, glw::GL_MAX_CULL_DISTANCES);
    glu::expect_no_error(gl, "glGetIntegerv() call(s) failed.")?;

    if iteration > gl_max_combined_clip_and_cull_distances_value {
        return Err(TestError::NotSupported("Not supported".to_string()));
    }

    // Check for OpenGL feature support
    if test_item.use_passthrough_ts && !has_tessellation(context) {
        return Err(TestError::NotSupported("Not supported".to_string()));
    }

    if test_item.fetch_culldistances && primitive_mode != PrimitiveMode::Points {
        return Err(TestError::NotSupported("Not supported".to_string()));
    }

    let mut clipdistances_array_size = 0u32;
    if iteration != 0 && iteration <= gl_max_clip_distances_value {
        clipdistances_array_size = iteration as u32;
    }

    let culldistances_array_size =
        if (gl_max_combined_clip_and_cull_distances_value - iteration) < gl_max_cull_distances_value {
            (gl_max_combined_clip_and_cull_distances_value - iteration) as u32
        } else {
            gl_max_cull_distances_value as u32
        };

    if clipdistances_array_size == 0 && culldistances_array_size == 0 {
        // Skip the empty iteration
        return Err(TestError::NotSupported("Not supported".to_string()));
    }

    let to = glu::Texture::new(gl);
    glu::expect_no_error(gl, "glGenTextures() call failed.")?;
    // SAFETY: names owned by the guards of this function.
    unsafe {
        gl.bind_texture(glw::GL_TEXTURE_2D, to.get());
        glu::expect_no_error(gl, "glBindTexture() call failed.")?;

        gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_R32F, TO_WIDTH as i32, TO_HEIGHT as i32);
        glu::expect_no_error(gl, "glTexStorage2D() call failed.")?;
    }

    // Set up the draw/read FBO
    let fbo = glu::Framebuffer::new(gl);
    glu::expect_no_error(gl, "glGenFramebuffers() call failed.")?;
    // SAFETY: names owned by the guards of this function.
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
        glu::expect_no_error(gl, "glBindFramebuffer() call failed.")?;

        gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            to.get(),
            0,
        );
        glu::expect_no_error(gl, "glFramebufferTexture2D() call failed.")?;
    }

    // Prepare a buffer object
    let bo = glu::Buffer::new(gl);
    glu::expect_no_error(gl, "glGenBuffers() call failed.")?;

    // Prepare a VAO. We will configure separately for each iteration.
    let vao = glu::VertexArray::new(gl);
    glu::expect_no_error(gl, "glGenVertexArrays() call failed.")?;

    // SAFETY: a current context.
    unsafe {
        gl.viewport(0, 0, TO_WIDTH as i32, TO_HEIGHT as i32);
        glu::expect_no_error(gl, "glViewport() call failed.")?;

        gl.clear_color(0.0, 0.0, 0.0, 1.0);
        glu::expect_no_error(gl, "glClearColor() call failed.")?;
    }

    // Create a program to run
    let program = build_po(
        gl,
        &BuildParams {
            clipdistances_array_size,
            culldistances_array_size,
            dynamic_index_writes: test_item.dynamic_index_writes,
            primitive_mode,
            redeclare_clipdistances: test_item.redeclare_clipdistances_array,
            redeclare_culldistances: test_item.redeclare_culldistances_array,
            use_core_functionality: test_item.use_core_functionality_if_core && is_core,
            use_gs: test_item.use_passthrough_gs,
            use_ts: test_item.use_passthrough_ts,
            fetch_culldistance_from_fs: test_item.fetch_culldistances,
        },
    )?;

    // Initialize VAO data
    let geometry = generate_geometry(clipdistances_array_size, culldistances_array_size, primitive_mode)?;
    configure_vao(
        gl,
        &program,
        &bo,
        &vao,
        clipdistances_array_size,
        culldistances_array_size,
        &geometry,
    )?;

    // Run GLSL program and check results
    execute_render_test(
        gl,
        &program,
        &geometry,
        clipdistances_array_size,
        culldistances_array_size,
        primitive_mode,
        test_item.use_passthrough_ts,
        test_item.fetch_culldistances,
    )?;

    Ok(TestStatus::pass("Pass"))
}

// ---------------------------------------------------------------------------------------------
// NegativeTest
// ---------------------------------------------------------------------------------------------

const NEGATIVE_FS_BODY: &str = "${VERSION}\n\
${PRECISION}\n\
void main()\n\
{\n\
}\n";

const NEGATIVE_VS_BODY_PREAMBLE: &str = "${VERSION}\n\
\n\
${EXTENSION}\n\
\n";

const NEGATIVE_VS_BODY_MAIN: &str = "#ifdef REDECLARE_OUTPUT_VARIABLES\n\
    out float gl_ClipDistance[N_GL_CLIPDISTANCE_ENTRIES];\n\
    out float gl_CullDistance[N_GL_CULLDISTANCE_ENTRIES];\n\
#endif\n\
\n\
void main()\n\
{\n\
#ifdef DYNAMIC_INDEX_BASED_WRITES\n\
    for (int n_clipdistance_entry = 0;\n\
             n_clipdistance_entry < N_GL_CLIPDISTANCE_ENTRIES;\n\
           ++n_clipdistance_entry)\n\
    {\n\
        gl_ClipDistance[n_clipdistance_entry] = float(n_clipdistance_entry) / float(N_GL_CLIPDISTANCE_ENTRIES);\n\
    }\n\
\n\
    for (int n_culldistance_entry = 0;\n\
             n_culldistance_entry < N_GL_CULLDISTANCE_ENTRIES;\n\
           ++n_culldistance_entry)\n\
    {\n\
        gl_CullDistance[n_culldistance_entry] = float(n_culldistance_entry) / float(N_GL_CULLDISTANCE_ENTRIES);\n\
    }\n\
#else\n\
    INSERT_STATIC_WRITES\n\
#endif\n\
}\n";

/// `NegativeTest::getTestDescription`
fn negative_test_description(
    n_test_iteration: usize,
    should_redeclare_output_variables: bool,
    use_dynamic_index_based_writes: bool,
) -> String {
    format!(
        "Test iteration [{n_test_iteration}] which uses a vertex shader that:\n\n{}{}",
        if should_redeclare_output_variables {
            "* redeclares gl_ClipDistance and gl_CullDistance arrays\n"
        } else {
            "* does not redeclare gl_ClipDistance and gl_CullDistance arrays\n"
        },
        if use_dynamic_index_based_writes {
            "* uses dynamic index-based writes\n"
        } else {
            "* uses static writes\n"
        }
    )
}

/// `NegativeTest::test`
fn negative_test(context: &Context) -> TestOutcome {
    let gl = context.gl();
    let specialization = base_specialization();

    // It only makes sense to run this test if GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES is lower than a sum of GL_MAX_CLIP_DISTANCES and GL_MAX_CLIP_CULL_DISTANCES.
    let gl_max_clip_distances_value = get_integer(gl, glw::GL_MAX_CLIP_DISTANCES);
    let gl_max_combined_clip_and_cull_distances_value = get_integer(gl, glw::GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES);
    let gl_max_cull_distances_value = get_integer(gl, glw::GL_MAX_CULL_DISTANCES);

    if gl_max_clip_distances_value + gl_max_cull_distances_value < gl_max_combined_clip_and_cull_distances_value {
        log::info!(
            "GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES is larger than or equal to the sum of GL_MAX_CLIP_DISTANCES and GL_MAX_CULL_DISTANCES. Skipping."
        );
        return Ok(TestStatus::pass("Pass"));
    }

    let n_gl_clipdistance_array_items = gl_max_clip_distances_value;
    let n_gl_culldistance_array_items = gl_max_combined_clip_and_cull_distances_value - gl_max_clip_distances_value + 1;

    // Form the "static write" shader body part.
    let static_write_shader_body_part = format!(
        "gl_ClipDistance[{n_gl_clipdistance_array_items}] = 0.0f;\ngl_CullDistance[{n_gl_culldistance_array_items}] = 0.0f;\n"
    );

    let fs_body_spec = StringTemplate::new(NEGATIVE_FS_BODY).specialize(&specialization)?;

    // (should_redeclare_output_variables, use_dynamic_index_based_writes): Negative Test 1, 2 and 3
    let test_items = [(true, false), (false, false), (false, true)];

    for (n_test_item, (should_redeclare_output_variables, use_dynamic_index_based_writes)) in
        test_items.into_iter().enumerate()
    {
        // Prepare vertex shader body
        let vs_body_header = StringTemplate::new(NEGATIVE_VS_BODY_PREAMBLE).specialize(&specialization)?;
        let mut vs_body_string = format!("{vs_body_header}\n");
        if should_redeclare_output_variables {
            vs_body_string.push_str("#define REDECLARE_OUTPUT_VARIABLES\n");
        }
        if use_dynamic_index_based_writes {
            vs_body_string.push_str("#define DYNAMIC_INDEX_BASED_WRITES\n");
        }
        vs_body_string.push_str(NEGATIVE_VS_BODY_MAIN);

        // Replace tokens with meaningful values
        vs_body_string =
            vs_body_string.replace("N_GL_CLIPDISTANCE_ENTRIES", &n_gl_clipdistance_array_items.to_string());
        vs_body_string =
            vs_body_string.replace("N_GL_CULLDISTANCE_ENTRIES", &n_gl_culldistance_array_items.to_string());
        vs_body_string = vs_body_string.replace("INSERT_STATIC_WRITES", &static_write_shader_body_part);

        let program = ShaderProgram::new_expecting_build_failure(
            gl,
            &ProgramSources::vtx_frag(vs_body_string, fs_body_spec.clone()),
        );
        let compiled =
            |shader_type: ShaderType| program.shader_info.iter().any(|(t, info)| *t == shader_type && info.ok);

        if !compiled(ShaderType::Fragment) {
            return fail("Fragment shader failed to compile.");
        }

        let description = negative_test_description(
            n_test_item,
            should_redeclare_output_variables,
            use_dynamic_index_based_writes,
        );

        // Try to compile the vertex shader
        if !compiled(ShaderType::Vertex) {
            let log = program
                .shader_info
                .iter()
                .find(|(t, _)| *t == ShaderType::Vertex)
                .map(|(_, info)| info.info_log.as_str())
                .unwrap_or_default();
            log::info!("{description}has failed (as expected) to compile with the following info log:\n\n{log}");

            // Move on to the next iteration
            continue;
        }

        // Try to link the program object
        if program.program_info.ok {
            log::info!("{description}has linked successfully which is invalid!");

            return fail("Program object has linked successfully, even though the process should have failed.");
        }

        log::info!(
            "{description}has failed (as expected) to link with the following info log:\n\n{}",
            program.program_info.info_log
        );
    }

    Ok(TestStatus::pass("Pass"))
}

// ---------------------------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------------------------

enum Kind {
    Coverage,
    Functional {
        test_item: TestItem,
        primitive_mode: PrimitiveMode,
        iteration: i32,
    },
    Negative,
}

struct CullDistanceCase {
    name: String,
    kind: Kind,
}

impl TestCase for CullDistanceCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `CullDistanceTestBase::iterate`'s extension check
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !(context.context_type().supports_core(4, 5)
            || context.context_info.is_extension_supported("GL_ARB_cull_distance"))
        {
            return Err(TestError::NotSupported(
                "GL_ARB_clip_distance is not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        match &self.kind {
            Kind::Coverage => {
                let outcome = coverage_test(context);
                // `deinit`: restore default pack alignment value
                // SAFETY: a current context.
                unsafe { context.gl().pixel_storei(glw::GL_PACK_ALIGNMENT, 4) };
                outcome
            }
            Kind::Functional {
                test_item,
                primitive_mode,
                iteration,
            } => functional_test(context, test_item, *primitive_mode, *iteration),
            Kind::Negative => negative_test(context),
        }
    }
}

/// `CullDistance::Tests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("cull_distance");
    group.add_child(Box::new(CullDistanceCase {
        name: "coverage".to_string(),
        kind: Kind::Coverage,
    }) as Box<dyn TestCase>);

    // addFunctionalTest
    for test_item in TEST_ITEMS {
        for primitive_mode in [PrimitiveMode::Lines, PrimitiveMode::Points, PrimitiveMode::Triangles] {
            // Iterate over a set of gl_ClipDistances[] and gl_CullDistances[] array sizes
            for iteration in 0..MAX_COMBINED_CLIP_AND_CULL_DISTANCES {
                let name = format!(
                    "functional_test_item_{}_primitive_{}_max_culldist_{}",
                    test_item.test_id,
                    primitive_mode.name(),
                    iteration
                );
                group.add_child(Box::new(CullDistanceCase {
                    name,
                    kind: Kind::Functional {
                        test_item,
                        primitive_mode,
                        iteration,
                    },
                }) as Box<dyn TestCase>);
            }
        }
    }

    group.add_child(Box::new(CullDistanceCase {
        name: "negative".to_string(),
        kind: Kind::Negative,
    }) as Box<dyn TestCase>);
    group
}
