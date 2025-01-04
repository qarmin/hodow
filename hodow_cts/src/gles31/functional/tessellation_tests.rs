// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fTessellationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Five of this file's sub-groups are
// ported: `state_query`, `tesscoord`, `winding`, `fractional_spacing` and
// `primitive_discard`, plus two of `invariance`'s nine children
// (`tess_coord_component_range`, `one_minus_tess_coord_component`). The groups still
// missing (`invariance`'s other seven) compare a *rasterised image* against a reference drawn on
// the host, which this port does not have. `shader_input_output`, `misc_draw` and `user_defined_io`
// (reference PNGs) are in `tessellation_render_tests`.
//
// The render groups that are here need no such image. `winding` draws with face
// culling on, once per `glFrontFace` setting, and *counts* white and red pixels: the
// whole check is "a shape appeared" versus "everything was culled". `fractional_spacing`
// captures `gl_TessCoord.x` through transform feedback and checks the conditions the
// spec states on the resulting segment lengths - how many segments, that the two odd
// ones out are symmetric, and that their length falls monotonically with the fractional
// part of the level - all of which are relations between the driver's own answers rather
// than coordinates someone has to compute here. `tesscoord` captures the whole
// `gl_TessCoord` through transform feedback and compares it, as an unordered point set,
// against `generateReferenceTessCoords`; upstream additionally renders both sets into a
// 256x256 `tcu::Surface` and logs the two images, which is diagnostic output only - the
// verdict is the point-set comparison, so the drawing is left out. `primitive_discard`
// draws a 27x27 grid of patches, most of which have an outer level <= 0, checks the
// fed-back vertex count against `referenceVertexCount` and then only asks whether *some*
// lit pixel falls inside each surviving patch's rectangle and none outside the last one.
// The two `invariance` sub-groups check a property of each fed-back coordinate itself.

use crate::gls::state_query_util::{
    Guarded, QueriedState, QueryType, query_state, verify_state_boolean, verify_state_integer,
    verify_state_integer_min, verify_state_program_integer,
};
use crate::glu::{
    self, ApiCase, Context, ProgramSources, ShaderProgram, ShaderType, TestCaseGroup, VertexArray, add_api_case,
};
use crate::glw::{self, GLenum, GLint, GLsizei, GLuint};
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::vector::Vec3;
use crate::tcu::{Random, de_string_hash, to_string_f32};

/// `supportsES32orGL45`
///
/// Upstream also accepts a desktop `core(4, 5)` context; this port only ever creates ES
/// contexts, so that branch cannot be reached and is not written out. It is the same
/// condition that decides whether the `${GLSL_*}` substitutions below are non-empty.
pub(super) fn supports_es32(context: &Context) -> bool {
    context.context_type().supports(3, 2)
}

/// `checkTessellationSupport`
fn check_tessellation_support(case: &mut ApiCase<'_>) -> bool {
    if supports_es32(case.context())
        || case
            .context()
            .context_info
            .is_extension_supported("GL_EXT_tessellation_shader")
    {
        return true;
    }
    case.not_supported("GL_EXT_tessellation_shader is not supported");
    false
}

/// `specializeShader`
///
/// The `GLSL_PER_VERTEX_*` entries exist for a desktop GL 4.5 context and are empty on ES,
/// which is the only kind this port creates - so they are substituted away rather than
/// carried as a table.
pub(super) fn specialize_shader(context: &Context, code: &str) -> String {
    let tessellation_require = if supports_es32(context) {
        ""
    } else {
        "#extension GL_EXT_tessellation_shader : require"
    };

    code.replace(
        "${GLSL_VERSION_DECL}",
        context.context_type().glsl_version().declaration(),
    )
    .replace("${TESSELLATION_SHADER_REQUIRE}", tessellation_require)
    .replace("${GLSL_PER_VERTEX_OUT}", "")
    .replace("${GLSL_PER_VERTEX_IN_ARR}", "")
    .replace("${GLSL_PER_VERTEX_OUT_ARR}", "")
    .replace("${GLSL_PRECISE_PER_VERTEX_IN_ARR}", "")
    .replace("${GLSL_PRECISE_PER_VERTEX_OUT}", "")
    .replace(
        "${GPU_SHADER5_REQUIRE}",
        if supports_es32(context) {
            ""
        } else {
            "#extension GL_EXT_gpu_shader5 : require"
        },
    )
}

// ---------------------------------------------------------------------------------------
// limits
// ---------------------------------------------------------------------------------------

/// `LimitQueryCase::iterate`
fn limit_query_case(case: &mut ApiCase<'_>, target: GLenum, min_value: i32) {
    if !check_tessellation_support(case) {
        return;
    }

    verify_state_integer_min(case, target, min_value, QueryType::Integer);

    case.section("Alternative queries");
    verify_state_integer_min(case, target, min_value, QueryType::Boolean);
    verify_state_integer_min(case, target, min_value, QueryType::Integer64);
    verify_state_integer_min(case, target, min_value, QueryType::Float);
}

/// One guarded `glGetIntegerv`, answering `None` when the driver wrote nothing usable.
fn guarded_get_integer(case: &mut ApiCase<'_>, target: GLenum) -> Option<GLint> {
    let mut value = Guarded::<GLint>::new();
    // SAFETY: one integer output, guarded on both sides.
    unsafe { case.gl().get_integerv(target, value.as_mut_ptr()) };
    case.expect_no_error("glGetIntegerv");

    if value.verify_validity(case) {
        Some(value.value())
    } else {
        None
    }
}

/// `CombinedUniformLimitCase::iterate`
fn combined_uniform_limit_case(
    case: &mut ApiCase<'_>,
    combined: GLenum,
    num_blocks: GLenum,
    default_components: GLenum,
) {
    if !check_tessellation_support(case) {
        return;
    }

    case.section("The minimum value of the combined limit is <blocks> x MAX_UNIFORM_BLOCK_SIZE / 4 + <components>");

    let max_uniform_blocks = guarded_get_integer(case, num_blocks);
    let max_uniform_block_size = guarded_get_integer(case, glw::GL_MAX_UNIFORM_BLOCK_SIZE);
    let max_uniform_components = guarded_get_integer(case, default_components);

    let (Some(blocks), Some(block_size), Some(components)) =
        (max_uniform_blocks, max_uniform_block_size, max_uniform_components)
    else {
        return;
    };

    // Upstream does this in `int`. Done in `i64` and clamped here, because a driver
    // answering an absurd `MAX_UNIFORM_BLOCK_SIZE` would overflow the multiply, which is a
    // debug-build panic in Rust rather than upstream's silent wrap.
    let limit = i64::from(blocks) * i64::from(block_size) / 4 + i64::from(components);
    let limit = i32::try_from(limit).unwrap_or(i32::MAX);

    verify_state_integer_min(case, combined, limit, QueryType::Integer);

    case.section("Alternative queries");
    verify_state_integer_min(case, combined, limit, QueryType::Boolean);
    verify_state_integer_min(case, combined, limit, QueryType::Integer64);
    verify_state_integer_min(case, combined, limit, QueryType::Float);
}

/// `PatchVerticesStateCase::iterate`
fn patch_vertices_state_case(case: &mut ApiCase<'_>) {
    if !check_tessellation_support(case) {
        return;
    }

    // initial
    case.section("Initial value");
    verify_state_integer(case, glw::GL_PATCH_VERTICES, 3, QueryType::Integer);

    // bind
    case.section("After set");
    // SAFETY: the only `pname` this entry point takes, with a value inside the limit.
    unsafe { case.gl().patch_parameteri(glw::GL_PATCH_VERTICES, 22) };
    case.expect_no_error("glPatchParameteri");

    verify_state_integer(case, glw::GL_PATCH_VERTICES, 22, QueryType::Integer);

    // `verifyStateIntegerMin`, not `verifyStateInteger`, in upstream's alternative-query
    // section - kept, because for the boolean verifier the two differ.
    case.section("Alternative queries");
    verify_state_integer_min(case, glw::GL_PATCH_VERTICES, 22, QueryType::Boolean);
    verify_state_integer_min(case, glw::GL_PATCH_VERTICES, 22, QueryType::Integer64);
    verify_state_integer_min(case, glw::GL_PATCH_VERTICES, 22, QueryType::Float);
}

/// `PrimitiveRestartForPatchesSupportedCase::iterate`
fn primitive_restart_for_patches_supported_case(case: &mut ApiCase<'_>) {
    if !check_tessellation_support(case) {
        return;
    }

    let Some(QueriedState::Boolean(supported)) = query_state(
        case,
        QueryType::Boolean,
        glw::GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED,
    ) else {
        return;
    };

    case.section("Alternative types");
    verify_state_boolean(
        case,
        glw::GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED,
        supported,
        QueryType::Integer,
    );
    verify_state_boolean(
        case,
        glw::GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED,
        supported,
        QueryType::Integer64,
    );
    verify_state_boolean(
        case,
        glw::GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED,
        supported,
        QueryType::Float,
    );
}

// ---------------------------------------------------------------------------------------
// program states
// ---------------------------------------------------------------------------------------

/// `TessProgramQueryCase::getVertexSource`
const VERTEX_SOURCE: &str = "${GLSL_VERSION_DECL}\n\
    ${GLSL_PER_VERTEX_OUT}\n\
    void main (void)\n\
    {\n\
    \tgl_Position = vec4(float(gl_VertexID), float(gl_VertexID / 2), 0.0, 1.0);\n\
    }\n";

/// `TessProgramQueryCase::getFragmentSource`
const FRAGMENT_SOURCE: &str = "${GLSL_VERSION_DECL}\n\
    layout (location = 0) out mediump vec4 o_color;\n\
    void main (void)\n\
    {\n\
    \to_color = vec4(0.0, 1.0, 0.0, 1.0);\n\
    }\n";

/// `TessProgramQueryCase::getTessCtrlSource`
fn tess_ctrl_source(global_layouts: &str) -> String {
    format!(
        "${{GLSL_VERSION_DECL}}\n\
         ${{TESSELLATION_SHADER_REQUIRE}}\n\
         ${{GLSL_PER_VERTEX_IN_ARR}}\n\
         ${{GLSL_PER_VERTEX_OUT_ARR}}\n\
         {global_layouts};\n\
         void main (void)\n\
         {{\n\
         \tgl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n\
         \tgl_TessLevelInner[0] = 2.8;\n\
         \tgl_TessLevelInner[1] = 2.8;\n\
         \tgl_TessLevelOuter[0] = 2.8;\n\
         \tgl_TessLevelOuter[1] = 2.8;\n\
         \tgl_TessLevelOuter[2] = 2.8;\n\
         \tgl_TessLevelOuter[3] = 2.8;\n\
         }}\n"
    )
}

/// `TessProgramQueryCase::getTessEvalSource`
fn tess_eval_source(global_layouts: &str) -> String {
    format!(
        "${{GLSL_VERSION_DECL}}\n\
         ${{TESSELLATION_SHADER_REQUIRE}}\n\
         ${{GLSL_PER_VERTEX_IN_ARR}}\n\
         ${{GLSL_PER_VERTEX_OUT}}\n\
         {global_layouts};\n\
         void main (void)\n\
         {{\n\
         \tgl_Position = gl_TessCoord.x * gl_in[0].gl_Position\n\
         \t            + gl_TessCoord.y * gl_in[1].gl_Position\n\
         \t            + gl_TessCoord.y * gl_in[2].gl_Position\n\
         \t            + gl_TessCoord.z * gl_in[3].gl_Position;\n\
         }}\n"
    )
}

/// The four-stage program every `TessProgramQueryCase` subclass builds.
fn build_tess_program<'gl>(context: &'gl Context, ctrl_layout: &str, eval_layout: &str) -> ShaderProgram<'gl> {
    let sources = ProgramSources::default()
        .with(ShaderType::Vertex, specialize_shader(context, VERTEX_SOURCE))
        .with(ShaderType::Fragment, specialize_shader(context, FRAGMENT_SOURCE))
        .with(
            ShaderType::TessControl,
            specialize_shader(context, &tess_ctrl_source(ctrl_layout)),
        )
        .with(
            ShaderType::TessEvaluation,
            specialize_shader(context, &tess_eval_source(eval_layout)),
        );

    ShaderProgram::new(context.gl(), &sources)
}

/// `TessControlOutputVerticesCase::iterate`
fn tess_control_output_vertices_case(case: &mut ApiCase<'_>) {
    if !check_tessellation_support(case) {
        return;
    }

    let program = build_tess_program(case.context(), "layout(vertices=4) out", "layout(triangles) in");
    if !program.is_ok() {
        // `throw tcu::TestError("failed to build program")`, which is a Fail.
        case.fail("failed to build program".to_string(), "failed to build program");
        return;
    }

    verify_state_program_integer(
        case,
        program.program(),
        glw::GL_TESS_CONTROL_OUTPUT_VERTICES,
        4,
        QueryType::ProgramInteger,
    );
}

/// The shape shared by `TessGenModeQueryCase`, `TessGenSpacingQueryCase`,
/// `TessGenVertexOrderQueryCase` and `TessGenPointModeQueryCase`: one program per
/// evaluation-shader layout, then one program-integer query on it. Upstream writes the
/// four out in full; they differ only in the table and the `pname`.
fn tess_gen_query_case(case: &mut ApiCase<'_>, pname: GLenum, modes: &[(&str, GLint)]) {
    if !check_tessellation_support(case) {
        return;
    }

    for (layout, expected) in modes {
        let program = build_tess_program(case.context(), "layout(vertices=6) out", layout);
        if program.is_ok() {
            verify_state_program_integer(case, program.program(), pname, *expected, QueryType::ProgramInteger);
        } else {
            case.fail("failed to build program".to_string(), "failed to build program");
        }
    }
}

// ---------------------------------------------------------------------------------------
// resource queries
// ---------------------------------------------------------------------------------------

/// `ReferencedByTessellationQueryCase::getTessCtrlSource`
fn referenced_by_tess_ctrl_source(is_ctrl_case: bool) -> String {
    let uniform = if is_ctrl_case { "u_referenced" } else { "u_unreferenced" };
    format!(
        "${{GLSL_VERSION_DECL}}\n\
         ${{TESSELLATION_SHADER_REQUIRE}}\n\
         ${{GLSL_PER_VERTEX_IN_ARR}}\n\
         ${{GLSL_PER_VERTEX_OUT_ARR}}\n\
         layout(vertices = 3) out;\n\
         uniform highp vec4 {uniform};\n\
         void main (void)\n\
         {{\n\
         \tvec4 offset = {uniform};\n\
         \tgl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position + offset;\n\
         \tgl_TessLevelInner[0] = 2.8;\n\
         \tgl_TessLevelInner[1] = 2.8;\n\
         \tgl_TessLevelOuter[0] = 2.8;\n\
         \tgl_TessLevelOuter[1] = 2.8;\n\
         \tgl_TessLevelOuter[2] = 2.8;\n\
         \tgl_TessLevelOuter[3] = 2.8;\n\
         }}\n"
    )
}

/// `ReferencedByTessellationQueryCase::getTessEvalSource`
fn referenced_by_tess_eval_source(is_ctrl_case: bool) -> String {
    let uniform = if is_ctrl_case { "u_unreferenced" } else { "u_referenced" };
    format!(
        "${{GLSL_VERSION_DECL}}\n\
         ${{TESSELLATION_SHADER_REQUIRE}}\n\
         ${{GLSL_PER_VERTEX_IN_ARR}}\n\
         ${{GLSL_PER_VERTEX_OUT}}\n\
         layout(triangles) in;\n\
         uniform highp vec4 {uniform};\n\
         void main (void)\n\
         {{\n\
         \tvec4 offset = {uniform};\n\
         \tgl_Position = gl_TessCoord.x * gl_in[0].gl_Position\n\
         \t            + gl_TessCoord.y * gl_in[1].gl_Position\n\
         \t            + gl_TessCoord.z * gl_in[2].gl_Position\n\
         \t            + offset;\n\
         }}\n"
    )
}

/// `gl.glGetProgramResourceIndex`
fn program_resource_index(case: &mut ApiCase<'_>, program: GLuint, interface: GLenum, name: &str) -> Option<GLuint> {
    let c_name = std::ffi::CString::new(name).expect("a resource name has no interior NUL");
    // SAFETY: the name outlives the call.
    let index = unsafe {
        case.gl()
            .get_program_resource_index(program, interface, c_name.as_ptr())
    };

    if index == glw::GL_INVALID_INDEX {
        case.fail(
            "resourcePos was GL_INVALID_INDEX".to_string(),
            "resourcePos was GL_INVALID_INDEX",
        );
        return None;
    }
    Some(index)
}

/// `gl.glGetProgramResourceiv` for a fixed set of properties, answering what it wrote.
fn program_resource_properties<const N: usize>(
    case: &mut ApiCase<'_>,
    program: GLuint,
    interface: GLenum,
    index: GLuint,
    props: [GLenum; N],
) -> (GLsizei, [GLint; N]) {
    let mut length: GLsizei = 0;
    let mut values = [0; N];
    // SAFETY: `props` has `N` entries and `values` has room for `N` answers.
    unsafe {
        case.gl().get_program_resourceiv(
            program,
            interface,
            index,
            N as GLsizei,
            props.as_ptr(),
            N as GLsizei,
            &raw mut length,
            values.as_mut_ptr(),
        );
    }
    (length, values)
}

/// One of `ReferencedByTessellationQueryCase::iterate`'s two sections.
fn check_referenced_uniform(case: &mut ApiCase<'_>, program: GLuint, name: &str) {
    let props = [
        glw::GL_REFERENCED_BY_TESS_CONTROL_SHADER,
        glw::GL_REFERENCED_BY_TESS_EVALUATION_SHADER,
    ];

    let Some(index) = program_resource_index(case, program, glw::GL_UNIFORM, name) else {
        return;
    };

    let (length, referenced) = program_resource_properties(case, program, glw::GL_UNIFORM, index, props);
    case.expect_no_error("query resource");

    if length != 2 {
        case.fail("expected 2 param returns".to_string(), "expected 2 param returns");
    } else if referenced[0] + referenced[1] < 1 {
        case.fail(
            format!("{name} must be referenced by at least one stage"),
            "uniform was referenced by no stage",
        );
    }
}

/// `ReferencedByTessellationQueryCase::iterate`
fn referenced_by_tessellation_query_case(case: &mut ApiCase<'_>, is_ctrl_case: bool) {
    if !check_tessellation_support(case) {
        return;
    }

    let sources = ProgramSources::default()
        .with(ShaderType::Vertex, specialize_shader(case.context(), VERTEX_SOURCE))
        .with(ShaderType::Fragment, specialize_shader(case.context(), FRAGMENT_SOURCE))
        .with(
            ShaderType::TessControl,
            specialize_shader(case.context(), &referenced_by_tess_ctrl_source(is_ctrl_case)),
        )
        .with(
            ShaderType::TessEvaluation,
            specialize_shader(case.context(), &referenced_by_tess_eval_source(is_ctrl_case)),
        );
    let program = ShaderProgram::new(case.gl(), &sources);

    if !program.is_ok() {
        case.fail("failed to build program".to_string(), "failed to build program");
        return;
    }

    case.section("Unreferenced uniform u_unreferenced");
    check_referenced_uniform(case, program.program(), "u_unreferenced");

    case.section("Referenced uniform u_referenced");
    check_referenced_uniform(case, program.program(), "u_referenced");
}

/// `IsPerPatchQueryCase`'s tessellation control source.
const IS_PER_PATCH_CONTROL_SOURCE: &str = "${GLSL_VERSION_DECL}\n\
    ${TESSELLATION_SHADER_REQUIRE}\n\
    ${GLSL_PER_VERTEX_IN_ARR}\n\
    ${GLSL_PER_VERTEX_OUT_ARR}\n\
    layout(vertices = 3) out;\n\
    patch out highp vec4 v_perPatch;\n\
    out highp vec4 v_perVertex[];\n\
    void main (void)\n\
    {\n\
    \tgl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n\
    \tv_perPatch = gl_in[0].gl_Position;\n\
    \tv_perVertex[gl_InvocationID] = -gl_in[gl_InvocationID].gl_Position;\n\
    \tgl_TessLevelInner[0] = 2.8;\n\
    \tgl_TessLevelInner[1] = 2.8;\n\
    \tgl_TessLevelOuter[0] = 2.8;\n\
    \tgl_TessLevelOuter[1] = 2.8;\n\
    \tgl_TessLevelOuter[2] = 2.8;\n\
    \tgl_TessLevelOuter[3] = 2.8;\n\
    }\n";

/// One of `IsPerPatchQueryCase::iterate`'s two sections.
fn check_is_per_patch(case: &mut ApiCase<'_>, program: GLuint, name: &str, expected: GLint) {
    let Some(index) = program_resource_index(case, program, glw::GL_PROGRAM_OUTPUT, name) else {
        return;
    };

    let (length, values) =
        program_resource_properties(case, program, glw::GL_PROGRAM_OUTPUT, index, [glw::GL_IS_PER_PATCH]);
    case.expect_no_error("query resource");

    if length == 0 || values[0] != expected {
        let expected_name = if expected == GLint::from(glw::TRUE) {
            "GL_TRUE"
        } else {
            "GL_FALSE"
        };
        case.fail(format!("expected {expected_name}"), "Got invalid IS_PER_PATCH value");
    }
}

/// `IsPerPatchQueryCase::iterate`
fn is_per_patch_query_case(case: &mut ApiCase<'_>) {
    if !check_tessellation_support(case) {
        return;
    }

    let sources = ProgramSources::default()
        .with(
            ShaderType::TessControl,
            specialize_shader(case.context(), IS_PER_PATCH_CONTROL_SOURCE),
        )
        .separable();
    let program = ShaderProgram::new(case.gl(), &sources);

    if !program.is_ok() {
        case.fail("failed to build program".to_string(), "failed to build program");
        return;
    }

    case.section("Per patch v_perPatch");
    check_is_per_patch(case, program.program(), "v_perPatch", GLint::from(glw::TRUE));

    case.section("Per vertex v_perVertex");
    check_is_per_patch(case, program.program(), "v_perVertex", GLint::from(glw::FALSE));
}

// ---------------------------------------------------------------------------------------
// registration
// ---------------------------------------------------------------------------------------

/// `LimitQueryCase` entries: the "new limits" block, then the "modified limits" block.
const LIMITS: [(&str, GLenum, i32); 25] = [
    ("max_patch_vertices", glw::GL_MAX_PATCH_VERTICES, 32),
    ("max_tess_gen_level", glw::GL_MAX_TESS_GEN_LEVEL, 64),
    (
        "max_tess_control_uniform_components",
        glw::GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS,
        1024,
    ),
    (
        "max_tess_evaluation_uniform_components",
        glw::GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS,
        1024,
    ),
    (
        "max_tess_control_texture_image_units",
        glw::GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS,
        16,
    ),
    (
        "max_tess_evaluation_texture_image_units",
        glw::GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS,
        16,
    ),
    (
        "max_tess_control_output_components",
        glw::GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS,
        64,
    ),
    ("max_tess_patch_components", glw::GL_MAX_TESS_PATCH_COMPONENTS, 120),
    (
        "max_tess_control_total_output_components",
        glw::GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS,
        2048,
    ),
    (
        "max_tess_evaluation_output_components",
        glw::GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS,
        64,
    ),
    (
        "max_tess_control_uniform_blocks",
        glw::GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS,
        12,
    ),
    (
        "max_tess_evaluation_uniform_blocks",
        glw::GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS,
        12,
    ),
    (
        "max_tess_control_input_components",
        glw::GL_MAX_TESS_CONTROL_INPUT_COMPONENTS,
        64,
    ),
    (
        "max_tess_evaluation_input_components",
        glw::GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS,
        64,
    ),
    (
        "max_tess_control_atomic_counter_buffers",
        glw::GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS,
        0,
    ),
    (
        "max_tess_evaluation_atomic_counter_buffers",
        glw::GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS,
        0,
    ),
    (
        "max_tess_control_atomic_counters",
        glw::GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS,
        0,
    ),
    (
        "max_tess_evaluation_atomic_counters",
        glw::GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS,
        0,
    ),
    (
        "max_tess_control_image_uniforms",
        glw::GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS,
        0,
    ),
    (
        "max_tess_evaluation_image_uniforms",
        glw::GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS,
        0,
    ),
    (
        "max_tess_control_shader_storage_blocks",
        glw::GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS,
        0,
    ),
    (
        "max_tess_evaluation_shader_storage_blocks",
        glw::GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS,
        0,
    ),
    // modified limits
    ("max_uniform_buffer_bindings", glw::GL_MAX_UNIFORM_BUFFER_BINDINGS, 72),
    ("max_combined_uniform_blocks", glw::GL_MAX_COMBINED_UNIFORM_BLOCKS, 60),
    (
        "max_combined_texture_image_units",
        glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS,
        96,
    ),
];

/// `CombinedUniformLimitCase` entries.
const COMBINED_LIMITS: [(&str, GLenum, GLenum, GLenum); 2] = [
    (
        "max_combined_tess_control_uniform_components",
        glw::GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS,
        glw::GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS,
        glw::GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS,
    ),
    (
        "max_combined_tess_evaluation_uniform_components",
        glw::GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS,
        glw::GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS,
        glw::GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS,
    ),
];

/// `TessGenModeQueryCase`'s `s_modes[]`
const GEN_MODES: [(&str, GLint); 3] = [
    ("layout(triangles) in", glw::GL_TRIANGLES as GLint),
    ("layout(isolines) in", glw::GL_ISOLINES as GLint),
    ("layout(quads) in", glw::GL_QUADS as GLint),
];

/// `TessGenSpacingQueryCase`'s `s_modes[]`
const GEN_SPACINGS: [(&str, GLint); 4] = [
    ("layout(triangles) in", glw::GL_EQUAL as GLint),
    ("layout(triangles, equal_spacing) in", glw::GL_EQUAL as GLint),
    (
        "layout(triangles, fractional_even_spacing) in",
        glw::GL_FRACTIONAL_EVEN as GLint,
    ),
    (
        "layout(triangles, fractional_odd_spacing) in",
        glw::GL_FRACTIONAL_ODD as GLint,
    ),
];

/// `TessGenVertexOrderQueryCase`'s `s_modes[]`
const GEN_VERTEX_ORDERS: [(&str, GLint); 3] = [
    ("layout(triangles) in", glw::GL_CCW as GLint),
    ("layout(triangles, cw) in", glw::GL_CW as GLint),
    ("layout(triangles, ccw) in", glw::GL_CCW as GLint),
];

/// `TessGenPointModeQueryCase`'s `s_modes[]`
const GEN_POINT_MODES: [(&str, GLint); 2] = [
    ("layout(triangles) in", glw::GL_FALSE as GLint),
    ("layout(triangles, point_mode) in", glw::GL_TRUE as GLint),
];

/// `TessellationTests::init`'s `state_query` sub-group.
fn state_query_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("state_query");

    for (name, target, min_value) in LIMITS {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            limit_query_case(case, target, min_value)
        });
    }

    for (name, combined, num_blocks, default_components) in COMBINED_LIMITS {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            combined_uniform_limit_case(case, combined, num_blocks, default_components);
        });
    }

    // features
    add_api_case(
        &mut group,
        "primitive_restart_for_patches_supported",
        primitive_restart_for_patches_supported_case,
    );

    // states
    add_api_case(&mut group, "patch_vertices", patch_vertices_state_case);

    // program states
    add_api_case(
        &mut group,
        "tess_control_output_vertices",
        tess_control_output_vertices_case,
    );
    add_api_case(&mut group, "tess_gen_mode", |case: &mut ApiCase<'_>| {
        tess_gen_query_case(case, glw::GL_TESS_GEN_MODE, &GEN_MODES);
    });
    add_api_case(&mut group, "tess_gen_spacing", |case: &mut ApiCase<'_>| {
        tess_gen_query_case(case, glw::GL_TESS_GEN_SPACING, &GEN_SPACINGS);
    });
    add_api_case(&mut group, "tess_gen_vertex_order", |case: &mut ApiCase<'_>| {
        tess_gen_query_case(case, glw::GL_TESS_GEN_VERTEX_ORDER, &GEN_VERTEX_ORDERS);
    });
    add_api_case(&mut group, "tess_gen_point_mode", |case: &mut ApiCase<'_>| {
        tess_gen_query_case(case, glw::GL_TESS_GEN_POINT_MODE, &GEN_POINT_MODES);
    });

    // resource queries
    add_api_case(
        &mut group,
        "referenced_by_tess_control_shader",
        |case: &mut ApiCase<'_>| {
            referenced_by_tessellation_query_case(case, true);
        },
    );
    add_api_case(
        &mut group,
        "referenced_by_tess_evaluation_shader",
        |case: &mut ApiCase<'_>| {
            referenced_by_tessellation_query_case(case, false);
        },
    );
    add_api_case(&mut group, "is_per_patch", is_per_patch_query_case);

    group
}

// ---------------------------------------------------------------------------------------
// winding
// ---------------------------------------------------------------------------------------

/// `Winding`
#[derive(Clone, Copy, PartialEq, Eq)]
enum Winding {
    Ccw,
    Cw,
}

impl Winding {
    /// `getWindingShaderName`
    const fn shader_name(self) -> &'static str {
        match self {
            Self::Ccw => "ccw",
            Self::Cw => "cw",
        }
    }
}

/// `TessPrimitiveType`, in upstream's enum order - the `tesscoord` registration loop
/// runs over the whole enum, `winding`'s skips `isolines`.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum TessPrimitiveType {
    Triangles,
    Quads,
    Isolines,
}

impl TessPrimitiveType {
    /// `getTessPrimitiveTypeShaderName`
    pub(super) const fn shader_name(self) -> &'static str {
        match self {
            Self::Triangles => "triangles",
            Self::Quads => "quads",
            Self::Isolines => "isolines",
        }
    }

    /// `numInnerTessellationLevels`
    const fn num_inner_levels(self) -> usize {
        match self {
            Self::Triangles => 1,
            Self::Quads => 2,
            Self::Isolines => 0,
        }
    }

    /// `numOuterTessellationLevels`
    const fn num_outer_levels(self) -> usize {
        match self {
            Self::Triangles => 3,
            Self::Quads => 4,
            Self::Isolines => 2,
        }
    }
}

/// `WindingCase::RENDER_SIZE`
const WINDING_RENDER_SIZE: i32 = 64;

/// `WindingCase::init`'s four shader templates, in upstream's order.
fn winding_program<'gl>(
    context: &'gl Context,
    primitive_type: TessPrimitiveType,
    winding: Winding,
) -> ShaderProgram<'gl> {
    const VERTEX_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n${GLSL_PER_VERTEX_OUT}\n\nvoid main (void)\n{\n}\n";
    const TESS_CONTROL_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         ${TESSELLATION_SHADER_REQUIRE}\n\
         ${GLSL_PER_VERTEX_IN_ARR}\n\
         ${GLSL_PER_VERTEX_OUT_ARR}\n\
         \n\
         layout (vertices = 1) out;\n\
         \n\
         void main (void)\n\
         {\n\
         \tgl_TessLevelInner[0] = 5.0;\n\
         \tgl_TessLevelInner[1] = 5.0;\n\
         \n\
         \tgl_TessLevelOuter[0] = 5.0;\n\
         \tgl_TessLevelOuter[1] = 5.0;\n\
         \tgl_TessLevelOuter[2] = 5.0;\n\
         \tgl_TessLevelOuter[3] = 5.0;\n\
         }\n";
    const FRAGMENT_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         \n\
         layout (location = 0) out mediump vec4 o_color;\n\
         \n\
         void main (void)\n\
         {\n\
         \to_color = vec4(1.0);\n\
         }\n";

    // `getTessellationEvaluationInLayoutString(m_primitiveType, m_winding)`
    let in_layout = format!(
        "layout ({}, {}) in;\n",
        primitive_type.shader_name(),
        winding.shader_name()
    );
    let tess_eval_template = format!(
        "${{GLSL_VERSION_DECL}}\n\
         ${{TESSELLATION_SHADER_REQUIRE}}\n\
         ${{GLSL_PER_VERTEX_IN_ARR}}\n\
         ${{GLSL_PER_VERTEX_OUT}}\n\
         \n\
         {in_layout}\n\
         void main (void)\n\
         {{\n\
         \tgl_Position = vec4(gl_TessCoord.xy*2.0 - 1.0, 0.0, 1.0);\n\
         }}\n"
    );

    let sources = ProgramSources::default()
        .with(ShaderType::Vertex, specialize_shader(context, VERTEX_TEMPLATE))
        .with(
            ShaderType::TessControl,
            specialize_shader(context, TESS_CONTROL_TEMPLATE),
        )
        .with(
            ShaderType::TessEvaluation,
            specialize_shader(context, &tess_eval_template),
        )
        .with(ShaderType::Fragment, specialize_shader(context, FRAGMENT_TEMPLATE));

    ShaderProgram::new(context.gl(), &sources)
}

/// `WindingCase::init` + `WindingCase::iterate`.
fn winding_case(case: &mut ApiCase<'_>, name: &str, primitive_type: TessPrimitiveType, winding: Winding) {
    if !check_tessellation_support(case) {
        return;
    }

    // `checkRenderTargetSize`
    let render_target = case.context().render_target();
    if render_target.width < WINDING_RENDER_SIZE || render_target.height < WINDING_RENDER_SIZE {
        case.not_supported(format!(
            "Render target width and height must be at least {WINDING_RENDER_SIZE}"
        ));
        return;
    }

    let context = case.context();
    let gl = case.gl();
    let program = winding_program(context, primitive_type, winding);
    if !program.is_ok() {
        // `TCU_FAIL("Program compilation failed")`
        case.fail("Program compilation failed".to_string(), "Program compilation failed");
        return;
    }

    // `RandomViewport(renderTarget, RENDER_SIZE, RENDER_SIZE, deStringHash(getName()))`
    let width = WINDING_RENDER_SIZE.min(render_target.width);
    let height = WINDING_RENDER_SIZE.min(render_target.height);
    let mut rnd = Random::new(de_string_hash(name));
    let vp_x = rnd.get_int(0, render_target.width - width);
    let vp_y = rnd.get_int(0, render_target.height - height);

    let vao = VertexArray::new(gl);

    // SAFETY: plain state setters plus one patch draw through a program that built.
    unsafe {
        gl.viewport(vp_x, vp_y, width, height);
        gl.clear_color(1.0, 0.0, 0.0, 1.0);
        gl.use_program(program.program());
        gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1);
        gl.enable(glw::GL_CULL_FACE);
        gl.bind_vertex_array(vao.get());
    }

    log::debug!("Face culling enabled");

    for front_face_winding in [Winding::Ccw, Winding::Cw] {
        log::debug!(
            "Setting glFrontFace({})",
            if front_face_winding == Winding::Cw {
                "GL_CW"
            } else {
                "GL_CCW"
            }
        );

        // SAFETY: as above.
        unsafe {
            gl.front_face(if front_face_winding == Winding::Cw {
                glw::GL_CW
            } else {
                glw::GL_CCW
            });
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            gl.draw_arrays(glw::GL_PATCHES, 0, 1);
        }
        case.expect_no_error("Draw failed");

        let mut rendered = Surface::new(width, height);
        if let Err(e) = glu::read_pixels(&context.render_context, vp_x, vp_y, &mut rendered.get_access()) {
            case.fail(e.to_string(), "Image verification failed");
            return;
        }

        if !verify_winding_image(case, &rendered, primitive_type, winding == front_face_winding) {
            return;
        }
    }
}

/// The pixel-counting half of `WindingCase::iterate`. Returns false on the first
/// failure, which is where upstream `break`s out of the winding loop.
fn verify_winding_image(
    case: &mut ApiCase<'_>,
    rendered: &Surface,
    primitive_type: TessPrimitiveType,
    front_facing: bool,
) -> bool {
    let total_num_pixels = rendered.get_width() * rendered.get_height();
    let bad_pixel_tolerance = if primitive_type == TessPrimitiveType::Triangles {
        5 * rendered.get_width().max(rendered.get_height())
    } else {
        0
    };

    let white = RGBA::new(255, 255, 255, 255);
    let red = RGBA::new(255, 0, 0, 255);
    let mut num_white_pixels = 0;
    let mut num_red_pixels = 0;
    for y in 0..rendered.get_height() {
        for x in 0..rendered.get_width() {
            num_white_pixels += i32::from(rendered.get_pixel(x, y) == white);
            num_red_pixels += i32::from(rendered.get_pixel(x, y) == red);
        }
    }

    log::debug!("Note: got {num_white_pixels} white and {num_red_pixels} red pixels");

    let other = total_num_pixels - num_white_pixels - num_red_pixels;
    if other > bad_pixel_tolerance {
        case.fail(
            format!("Got {other} other than white or red pixels (maximum tolerance {bad_pixel_tolerance})"),
            "Image verification failed",
        );
        return false;
    }

    if front_facing {
        match primitive_type {
            TessPrimitiveType::Triangles => {
                if (num_white_pixels - total_num_pixels / 2).abs() > bad_pixel_tolerance {
                    case.fail(
                        format!(
                            "wrong number of white pixels; expected approximately {}",
                            total_num_pixels / 2
                        ),
                        "Image verification failed",
                    );
                    return false;
                }
            }
            TessPrimitiveType::Quads => {
                if num_white_pixels != total_num_pixels {
                    case.fail(
                        "expected only white pixels (full-viewport quad)".to_string(),
                        "Image verification failed",
                    );
                    return false;
                }
            }
            // Upstream's `DE_ASSERT(false)`; `WindingCase`'s own constructor asserts the
            // type is triangles or quads, and `winding_group` never builds another.
            TessPrimitiveType::Isolines => unreachable!("WindingCase is never given isolines"),
        }
    } else if num_white_pixels != 0 {
        case.fail(
            "expected only red pixels (everything culled)".to_string(),
            "Image verification failed",
        );
        return false;
    }

    true
}

/// `TessellationTests::init`'s `.winding` sub-group.
fn winding_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("winding");

    for primitive_type in [TessPrimitiveType::Triangles, TessPrimitiveType::Quads] {
        for winding in [Winding::Ccw, Winding::Cw] {
            let name = format!("{}_{}", primitive_type.shader_name(), winding.shader_name());
            let case_name = name.clone();
            add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
                winding_case(case, &case_name, primitive_type, winding)
            });
        }
    }

    group
}

// ---------------------------------------------------------------------------------------
// Shared by `fractional_spacing` and `tesscoord`: spacing modes, tessellation-level
// rounding and the transform-feedback handler.
// ---------------------------------------------------------------------------------------

/// `SpacingMode`, in upstream's enum order - `FractionalSpacingModeCase` asserts it is
/// given one of the two fractional ones, `TessCoordCase` runs over the whole enum.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum SpacingMode {
    Equal,
    FractionalOdd,
    FractionalEven,
}

impl SpacingMode {
    /// `getSpacingModeShaderName`
    pub(super) const fn shader_name(self) -> &'static str {
        match self {
            Self::Equal => "equal_spacing",
            Self::FractionalOdd => "fractional_odd_spacing",
            Self::FractionalEven => "fractional_even_spacing",
        }
    }
}

/// `getClampedTessLevel`
fn get_clamped_tess_level(mode: SpacingMode, tess_level: f32) -> f32 {
    match mode {
        SpacingMode::Equal | SpacingMode::FractionalOdd => tess_level.max(1.0),
        SpacingMode::FractionalEven => tess_level.max(2.0),
    }
}

/// `getRoundedTessLevel`
#[expect(
    clippy::cast_possible_truncation,
    reason = "upstream's own `(int)deFloatCeil(...)`; the level is well under i32"
)]
fn get_rounded_tess_level(mode: SpacingMode, clamped_tess_level: f32) -> i32 {
    let result = clamped_tess_level.ceil() as i32;
    match mode {
        SpacingMode::Equal => result,
        SpacingMode::FractionalOdd => result + 1 - result % 2,
        SpacingMode::FractionalEven => result + result % 2,
    }
}

/// `getClampedRoundedTessLevel`
pub(super) fn get_clamped_rounded_tess_level(mode: SpacingMode, tess_level: f32) -> i32 {
    get_rounded_tess_level(mode, get_clamped_tess_level(mode, tess_level))
}

/// `numVerticesPerPrimitive`
fn num_vertices_per_primitive(primitive_type_gl: GLenum) -> usize {
    match primitive_type_gl {
        glw::GL_POINTS => 1,
        glw::GL_LINES => 2,
        glw::GL_TRIANGLES => 3,
        // Upstream's `DE_ASSERT(false); return -1;` - no call site passes anything else.
        _ => unreachable!("numVerticesPerPrimitive is only called with points, lines or triangles"),
    }
}

/// `outputPrimitiveTypeGL`
pub(super) fn output_primitive_type_gl(tess_prim_type: TessPrimitiveType, use_point_mode: bool) -> GLenum {
    if use_point_mode {
        return glw::GL_POINTS;
    }
    match tess_prim_type {
        TessPrimitiveType::Triangles | TessPrimitiveType::Quads => glw::GL_TRIANGLES,
        TessPrimitiveType::Isolines => glw::GL_LINES,
    }
}

/// `TransformFeedbackHandler<AttribType>` - the transform-feedback object, its buffer and
/// the primitives-written query, plus the one render this file does through them.
///
/// Upstream's template parameter is the varying's C++ type (`float` for
/// `fractional_spacing`, `Vec3` for `tesscoord`); here it is the varying's float-component
/// count, and the readback stays a flat `Vec<f32>` the caller groups. Both instantiations
/// are float-typed, so one struct with a component count is the whole difference and it
/// keeps the buffer sizing in one place.
pub(super) struct TransformFeedbackHandler<'gl> {
    gl: &'gl glw::Functions,
    tf: crate::glu::objects::TransformFeedback<'gl>,
    tf_buffer: glu::Buffer<'gl>,
    tf_prim_query: crate::glu::objects::Query<'gl>,
    varying_components: usize,
}

/// `TransformFeedbackHandler::Result`
pub(super) struct TransformFeedbackResult {
    pub(super) num_primitives: i32,
    pub(super) varying: Vec<f32>,
}

impl<'gl> TransformFeedbackHandler<'gl> {
    pub(super) fn new(gl: &'gl glw::Functions, varying_components: usize, max_num_vertices: i32) -> Self {
        let handler = Self {
            gl,
            tf: crate::glu::objects::TransformFeedback::new(gl),
            tf_buffer: glu::Buffer::new(gl),
            tf_prim_query: crate::glu::objects::Query::new(gl),
            varying_components,
        };

        // \note Room for 1 extra triangle, to detect if GL returns too many primitives.
        let buffer_size =
            isize::try_from(max_num_vertices + 3).unwrap_or(0) * (varying_components * size_of::<f32>()) as isize;

        // SAFETY: a buffer this handler owns, sized from the caller's vertex count.
        unsafe {
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, handler.tf_buffer.get());
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                buffer_size,
                std::ptr::null(),
                glw::GL_DYNAMIC_READ,
            );
        }

        handler
    }

    /// `renderAndGetPrimitives`
    pub(super) fn render_and_get_primitives(
        &self,
        context: &Context,
        program: GLuint,
        tf_prim_type_gl: GLenum,
        bindings: &[glu::VertexArrayBinding<'_>],
        num_vertices: i32,
    ) -> Result<TransformFeedbackResult, crate::tcu::TestError> {
        let gl = self.gl;

        // SAFETY: every object below is this handler's own.
        unsafe {
            gl.bind_transform_feedback(glw::GL_TRANSFORM_FEEDBACK, self.tf.get());
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.tf_buffer.get());
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.tf_buffer.get());

            gl.begin_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, self.tf_prim_query.get());
            gl.begin_transform_feedback(tf_prim_type_gl);
        }

        let draw_result = glu::draw(
            &context.render_context,
            program,
            bindings,
            &glu::pr::list(glu::PrimitiveType::Patches, num_vertices),
        );

        // SAFETY: as above - and the feedback has to be ended even if the draw failed.
        unsafe {
            gl.end_transform_feedback();
            gl.end_query(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN);
        }
        draw_result?;
        glu::expect_no_error(gl, "Draw failed")?;

        // `getQueryResult`
        let mut num_prims_written = u32::MAX;
        // SAFETY: one GLuint out, on a query that has just ended.
        unsafe { gl.get_query_objectuiv(self.tf_prim_query.get(), glw::GL_QUERY_RESULT, &mut num_prims_written) };
        if num_prims_written == u32::MAX {
            return Err(crate::tcu::TestError::Fail("query result was not written".to_string()));
        }

        // `readDataMapped`
        let num_elems =
            num_prims_written as usize * num_vertices_per_primitive(tf_prim_type_gl) * self.varying_components;
        let num_bytes = isize::try_from(num_elems * size_of::<f32>()).unwrap_or(0);
        let Some(map) = crate::glu::objects::BufferMemMap::new(
            gl,
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            num_bytes,
            glw::GL_MAP_READ_BIT,
        ) else {
            return Err(crate::tcu::TestError::Fail(
                "glMapBufferRange(GL_TRANSFORM_FEEDBACK_BUFFER) returned null".to_string(),
            ));
        };
        // SAFETY: `num_elems` tightly packed floats inside the range just mapped for reading.
        let varying = unsafe { map.read_strided::<f32>(0, size_of::<f32>(), num_elems) };
        drop(map);

        Ok(TransformFeedbackResult {
            num_primitives: i32::try_from(num_prims_written).unwrap_or(i32::MAX),
            varying,
        })
    }
}

// ---------------------------------------------------------------------------------------
// fractional_spacing
// ---------------------------------------------------------------------------------------

/// `VerifyFractionalSpacingSingleInternal::Segment`
#[derive(Clone, Copy)]
struct Segment {
    index: i32,
    length: f32,
}

/// `verifyFractionalSpacingSingle`
///
/// Returns `None` on failure (upstream's `false`), else the
/// `(additionalSegmentLength, additionalSegmentLocation)` pair it writes out.
fn verify_fractional_spacing_single(spacing_mode: SpacingMode, tess_level: f32, coords: &[f32]) -> Option<(f32, i32)> {
    let clamped_level = get_clamped_tess_level(spacing_mode, tess_level);
    let final_level = get_rounded_tess_level(spacing_mode, clamped_level);
    let mut sorted_coords = coords.to_vec();
    sorted_coords.sort_by(f32::total_cmp);
    let fail_note =
        format!("Note: tessellation level is {tess_level}\nNote: sorted coordinates are:\n    {sorted_coords:?}");

    if i32::try_from(coords.len()).unwrap_or(i32::MAX) != final_level + 1 {
        log::warn!(
            "Failure: number of vertices is {}; expected {} (clamped tessellation level is {clamped_level}); final level (clamped level rounded up to {}) is {final_level} and should equal the number of segments, i.e. number of vertices minus 1\n{fail_note}",
            coords.len(),
            final_level + 1,
            if spacing_mode == SpacingMode::FractionalEven {
                "even"
            } else {
                "odd"
            }
        );
        return None;
    }

    if sorted_coords[0] != 0.0 || *sorted_coords.last()? != 1.0 {
        log::warn!("Failure: smallest coordinate should be 0.0 and biggest should be 1.0\n{fail_note}");
        return None;
    }

    let segments: Vec<Segment> = (0..final_level as usize)
        .map(|i| Segment {
            index: i32::try_from(i).unwrap_or(i32::MAX),
            length: sorted_coords[i + 1] - sorted_coords[i],
        })
        .collect();

    // Divide segments to two different groups based on length.
    let mut segments_a: Vec<Segment> = vec![segments[0]];
    let mut segments_b: Vec<Segment> = Vec::new();

    for seg in &segments[1..] {
        const EPSILON: f32 = 0.001;

        if (seg.length - segments_a[0].length).abs() < EPSILON {
            segments_a.push(*seg);
        } else if segments_b.is_empty() || (seg.length - segments_b[0].length).abs() < EPSILON {
            segments_b.push(*seg);
        } else {
            log::warn!(
                "Failure: couldn't divide segments to 2 groups by length; e.g. segment of length {} isn't approximately equal to either {} or {}\n{fail_note}",
                seg.length,
                segments_a[0].length,
                segments_b[0].length
            );
            return None;
        }
    }

    if clamped_level == final_level as f32 {
        // All segments should be of equal length.
        if !segments_a.is_empty() && !segments_b.is_empty() {
            log::warn!(
                "Failure: clamped and final tessellation level are equal, but not all segments are of equal length.\n{fail_note}"
            );
            return None;
        }
    }

    if segments_a.is_empty() || segments_b.is_empty() {
        // All segments have same length. This is ok.
        let length = if segments.len() == 1 { -1.0 } else { segments[0].length };
        return Some((length, -1));
    }

    if segments_a.len() != 2 && segments_b.len() != 2 {
        log::warn!(
            "Failure: when dividing the segments to 2 groups by length, neither of the two groups has exactly 2 or 0 segments in it\n{fail_note}"
        );
        return None;
    }

    // For convenience, arrange so that the 2-segment group is segmentsB.
    if segments_b.len() != 2 {
        std::mem::swap(&mut segments_a, &mut segments_b);
    }

    // \note For 4-segment lines both segmentsA and segmentsB have 2 segments each.
    //         Thus, we can't be sure which ones were meant as the additional segments.
    //         We give the benefit of the doubt by assuming that they're the shorter
    //         ones (as they should).
    if segments_a.len() == 2 {
        // We have 2 segmentsA and 2 segmentsB, ensure segmentsB has the shorter lengths
        if segments_b[0].length > segments_a[0].length {
            std::mem::swap(&mut segments_a, &mut segments_b);
        }
    } else if segments_b[0].length > segments_a[0].length + 0.001 {
        log::warn!("Failure: the two additional segments are longer than the other segments\n{fail_note}");
        return None;
    }

    // Check that the additional segments are placed symmetrically.
    if segments_b[0].index + segments_b[1].index + 1 != i32::try_from(segments.len()).unwrap_or(i32::MAX) {
        log::warn!(
            "Failure: the two additional segments aren't placed symmetrically; one is at index {} and other is at index {} (note: the two indexes should sum to {}, i.e. numberOfSegments-1)\n{fail_note}",
            segments_b[0].index,
            segments_b[1].index,
            segments.len() - 1
        );
        return None;
    }

    let location = if segments_a.len() == 2 {
        // \note -1 when can't reliably decide which ones are the additional segments, a or b.
        if segments_b[0].length < segments_a[0].length - 0.001 {
            segments_b[0].index.min(segments_b[1].index)
        } else {
            -1
        }
    } else {
        segments_b[0].index.min(segments_b[1].index)
    };

    Some((segments_b[0].length, location))
}

/// `VerifyFractionalSpacingMultipleInternal::LineData`
#[derive(Clone, Copy)]
struct LineData {
    tess_level: f32,
    additional_segment_length: f32,
    additional_segment_location: i32,
}

/// `verifyFractionalSpacingMultiple` - the conditions that need more than one line.
fn verify_fractional_spacing_multiple(spacing_mode: SpacingMode, line_datas: &[LineData]) -> bool {
    let mut sorted_by_level = line_datas.to_vec();
    sorted_by_level.sort_by(|a, b| a.tess_level.total_cmp(&b.tess_level));

    // Check that lines with identical clamped tessellation levels have identical additionalSegmentLocation.
    for window in sorted_by_level.windows(2) {
        let (prev_data, cur_data) = (window[0], window[1]);

        if cur_data.additional_segment_location < 0 || prev_data.additional_segment_location < 0 {
            continue; // Unknown locations, skip.
        }

        if get_clamped_tess_level(spacing_mode, cur_data.tess_level)
            == get_clamped_tess_level(spacing_mode, prev_data.tess_level)
            && cur_data.additional_segment_location != prev_data.additional_segment_location
        {
            log::warn!(
                "Failure: additional segments not located identically for two edges with identical clamped tessellation levels\nNote: tessellation levels are {} and {} (clamped level {}); but first additional segments located at indices {} and {}, respectively",
                cur_data.tess_level,
                prev_data.tess_level,
                get_clamped_tess_level(spacing_mode, cur_data.tess_level),
                cur_data.additional_segment_location,
                prev_data.additional_segment_location
            );
            return false;
        }
    }

    // Check that, among lines with same clamped rounded tessellation level, additionalSegmentLength
    // is monotonically decreasing with "clampedRoundedTessLevel - clampedTessLevel" (the "fraction").
    for window in sorted_by_level.windows(2) {
        let (prev_data, cur_data) = (window[0], window[1]);

        if cur_data.additional_segment_length < 0.0 || prev_data.additional_segment_length < 0.0 {
            continue; // Unknown segment lengths, skip.
        }

        let cur_clamped_level = get_clamped_tess_level(spacing_mode, cur_data.tess_level);
        let prev_clamped_level = get_clamped_tess_level(spacing_mode, prev_data.tess_level);
        let cur_final_level = get_rounded_tess_level(spacing_mode, cur_clamped_level);
        let prev_final_level = get_rounded_tess_level(spacing_mode, prev_clamped_level);

        if cur_final_level != prev_final_level {
            continue;
        }

        if cur_data.additional_segment_length < prev_data.additional_segment_length
            || (cur_clamped_level == prev_clamped_level
                && cur_data.additional_segment_length != prev_data.additional_segment_length)
        {
            log::warn!(
                "Failure: additional segment length isn't monotonically decreasing with the fraction <n> - <f>, among edges with same final tessellation level\nNote: two edges have tessellation levels {} and {} respectively, clamped {prev_clamped_level} and {cur_clamped_level}, final {prev_final_level} and {cur_final_level}; fractions are {} and {}, but resulted in segment lengths {} and {}",
                prev_data.tess_level,
                cur_data.tess_level,
                prev_final_level as f32 - prev_clamped_level,
                cur_final_level as f32 - cur_clamped_level,
                prev_data.additional_segment_length,
                cur_data.additional_segment_length
            );
            return false;
        }
    }

    true
}

/// `FractionalSpacingModeCase::RENDER_SIZE`
const FRACTIONAL_SPACING_RENDER_SIZE: i32 = 16;

/// `FractionalSpacingModeCase::genTessLevelCases`
fn gen_fractional_spacing_tess_level_cases() -> Vec<f32> {
    let mut result = Vec::new();

    // Ranges [7.0 .. 8.0), [8.0 .. 9.0) and [9.0 .. 10.0)
    const NUM_SAMPLES_PER_RANGE: i32 = 10;
    for range_start in [7.0_f32, 8.0, 9.0] {
        for i in 0..NUM_SAMPLES_PER_RANGE {
            result.push(range_start + i as f32 / NUM_SAMPLES_PER_RANGE as f32);
        }
    }

    // 0.3, 1.3, 2.3,  ... , 62.3
    for i in 0..=62 {
        result.push(i as f32 + 0.3);
    }

    result
}

/// `FractionalSpacingModeCase::init`'s four shader templates, in upstream's order.
fn fractional_spacing_program<'gl>(context: &'gl Context, spacing: SpacingMode) -> ShaderProgram<'gl> {
    const VERTEX_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n${GLSL_PER_VERTEX_OUT}\n\nvoid main (void)\n{\n}\n";
    const TESS_CONTROL_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         ${TESSELLATION_SHADER_REQUIRE}\n\
         ${GLSL_PER_VERTEX_IN_ARR}\n\
         ${GLSL_PER_VERTEX_OUT_ARR}\n\
         \n\
         layout (vertices = 1) out;\n\
         \n\
         uniform mediump float u_tessLevelOuter1;\n\
         \n\
         void main (void)\n\
         {\n\
         \tgl_TessLevelOuter[0] = 1.0;\n\
         \tgl_TessLevelOuter[1] = u_tessLevelOuter1;\n\
         }\n";
    const FRAGMENT_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         \n\
         layout (location = 0) out mediump vec4 o_color;\n\
         \n\
         void main (void)\n\
         {\n\
         \to_color = vec4(1.0);\n\
         }\n";

    // `getTessellationEvaluationInLayoutString(TESSPRIMITIVETYPE_ISOLINES, m_spacing, true)`
    let in_layout = format!("layout (isolines, {}, point_mode) in;\n", spacing.shader_name());
    let tess_eval_template = format!(
        "${{GLSL_VERSION_DECL}}\n\
         ${{TESSELLATION_SHADER_REQUIRE}}\n\
         ${{GLSL_PER_VERTEX_IN_ARR}}\n\
         ${{GLSL_PER_VERTEX_OUT}}\n\
         \n\
         {in_layout}\n\
         out highp float out_te_tessCoord;\n\
         \n\
         void main (void)\n\
         {{\n\
         \tout_te_tessCoord = gl_TessCoord.x;\n\
         \tgl_Position = vec4(gl_TessCoord.xy*1.6 - 0.8, 0.0, 1.0);\n\
         }}\n"
    );

    let sources = ProgramSources::default()
        .with(ShaderType::Vertex, specialize_shader(context, VERTEX_TEMPLATE))
        .with(
            ShaderType::TessControl,
            specialize_shader(context, TESS_CONTROL_TEMPLATE),
        )
        .with(
            ShaderType::TessEvaluation,
            specialize_shader(context, &tess_eval_template),
        )
        .with(ShaderType::Fragment, specialize_shader(context, FRAGMENT_TEMPLATE))
        .with_transform_feedback(&["out_te_tessCoord".to_string()], glw::GL_INTERLEAVED_ATTRIBS);

    ShaderProgram::new(context.gl(), &sources)
}

/// `FractionalSpacingModeCase::init` + `FractionalSpacingModeCase::iterate`.
fn fractional_spacing_mode_case(case: &mut ApiCase<'_>, name: &str, spacing: SpacingMode) {
    if !check_tessellation_support(case) {
        return;
    }

    // `checkRenderTargetSize`
    let render_target = case.context().render_target();
    if render_target.width < FRACTIONAL_SPACING_RENDER_SIZE || render_target.height < FRACTIONAL_SPACING_RENDER_SIZE {
        case.not_supported(format!(
            "Render target width and height must be at least {FRACTIONAL_SPACING_RENDER_SIZE}"
        ));
        return;
    }

    let context = case.context();
    let gl = case.gl();
    let program = fractional_spacing_program(context, spacing);
    if !program.is_ok() {
        // `TCU_FAIL("Program compilation failed")`
        case.fail("Program compilation failed".to_string(), "Program compilation failed");
        return;
    }
    let program_gl = program.program();

    // SAFETY: a name from a program that linked.
    let tess_level_outer1_loc = unsafe { gl.get_uniform_location(program_gl, c"u_tessLevelOuter1".as_ptr()) };

    // Second outer tessellation levels.
    let tess_level_cases = gen_fractional_spacing_tess_level_cases();
    let max_level = tess_level_cases.iter().copied().fold(f32::NEG_INFINITY, f32::max);
    let max_num_vertices = 1 + get_clamped_rounded_tess_level(spacing, max_level);

    let handler = TransformFeedbackHandler::new(gl, 1, max_num_vertices);

    // `RandomViewport(renderTarget, RENDER_SIZE, RENDER_SIZE, deStringHash(getName()))`
    let width = FRACTIONAL_SPACING_RENDER_SIZE.min(render_target.width);
    let height = FRACTIONAL_SPACING_RENDER_SIZE.min(render_target.height);
    let mut rnd = Random::new(de_string_hash(name));
    let vp_x = rnd.get_int(0, render_target.width - width);
    let vp_y = rnd.get_int(0, render_target.height - height);

    // SAFETY: plain state setters on a program that linked.
    unsafe {
        gl.viewport(vp_x, vp_y, width, height);
        gl.use_program(program_gl);
        gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1);
    }

    let mut line_datas = Vec::with_capacity(tess_level_cases.len());

    for &outer_level1 in &tess_level_cases {
        // SAFETY: a location from this program, or -1, which is a no-op.
        unsafe { gl.uniform_1f(tess_level_outer1_loc, outer_level1) };
        case.expect_no_error("Setup failed");

        let tf_result = match handler.render_and_get_primitives(context, program_gl, glw::GL_POINTS, &[], 1) {
            Ok(result) => result,
            Err(e) => {
                case.fail(e.to_string(), "Invalid tessellation coordinates");
                return;
            }
        };
        debug_assert_eq!(tf_result.num_primitives as usize, tf_result.varying.len());

        let Some((additional_segment_length, additional_segment_location)) =
            verify_fractional_spacing_single(spacing, outer_level1, &tf_result.varying)
        else {
            case.fail(
                format!("fractional spacing check failed at tessellation level {outer_level1}"),
                "Invalid tessellation coordinates",
            );
            return;
        };

        line_datas.push(LineData {
            tess_level: outer_level1,
            additional_segment_length,
            additional_segment_location,
        });
    }

    if !verify_fractional_spacing_multiple(spacing, &line_datas) {
        case.fail(
            "fractional spacing check failed across tessellation levels".to_string(),
            "Invalid tessellation coordinates",
        );
    }
}

/// `TessellationTests::init`'s `.fractional_spacing` sub-group.
fn fractional_spacing_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fractional_spacing");

    for (name, spacing) in [
        ("odd", SpacingMode::FractionalOdd),
        ("even", SpacingMode::FractionalEven),
    ] {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            fractional_spacing_mode_case(case, name, spacing)
        });
    }

    group
}

// ---------------------------------------------------------------------------------------
// tesscoord
// ---------------------------------------------------------------------------------------

/// `generateReferenceTriangleTessCoords`
///
/// \note The tessellation coordinates generated by this function could break some of the
/// rules given in the spec (e.g. it may not exactly hold that u+v+w == 1.0f, or
/// [uvw] + (1.0f-[uvw]) == 1.0f).
fn generate_reference_triangle_tess_coords(
    spacing_mode: SpacingMode,
    inner: i32,
    outer0: i32,
    outer1: i32,
    outer2: i32,
) -> Vec<Vec3> {
    let mut tess_coords = Vec::new();

    if inner == 1 {
        if outer0 == 1 && outer1 == 1 && outer2 == 1 {
            tess_coords.push(Vec3::new(1.0, 0.0, 0.0));
            tess_coords.push(Vec3::new(0.0, 1.0, 0.0));
            tess_coords.push(Vec3::new(0.0, 0.0, 1.0));
            return tess_coords;
        }
        return generate_reference_triangle_tess_coords(
            spacing_mode,
            if spacing_mode == SpacingMode::FractionalOdd {
                3
            } else {
                2
            },
            outer0,
            outer1,
            outer2,
        );
    }

    for i in 0..outer0 {
        let v = i as f32 / outer0 as f32;
        tess_coords.push(Vec3::new(0.0, v, 1.0 - v));
    }
    for i in 0..outer1 {
        let v = i as f32 / outer1 as f32;
        tess_coords.push(Vec3::new(1.0 - v, 0.0, v));
    }
    for i in 0..outer2 {
        let v = i as f32 / outer2 as f32;
        tess_coords.push(Vec3::new(v, 1.0 - v, 0.0));
    }

    let num_inner_triangles = inner / 2;
    for inner_triangle_ndx in 0..num_inner_triangles {
        let cur_inner_triangle_level = inner - 2 * (inner_triangle_ndx + 1);

        if cur_inner_triangle_level == 0 {
            tess_coords.push(Vec3::splat(1.0 / 3.0));
        } else {
            let min_uvw = (2 * (inner_triangle_ndx + 1)) as f32 / (3 * inner) as f32;
            let max_uvw = 1.0 - 2.0 * min_uvw;
            let corners = [
                Vec3::new(max_uvw, min_uvw, min_uvw),
                Vec3::new(min_uvw, max_uvw, min_uvw),
                Vec3::new(min_uvw, min_uvw, max_uvw),
            ];

            for i in 0..cur_inner_triangle_level {
                let f = i as f32 / cur_inner_triangle_level as f32;
                for j in 0..3 {
                    tess_coords.push(corners[j] * (1.0 - f) + corners[(j + 1) % 3] * f);
                }
            }
        }
    }

    tess_coords
}

/// `generateReferenceQuadTessCoords`
///
/// \note The tessellation coordinates generated by this function could break some of the
/// rules given in the spec (e.g. it may not exactly hold that [uv] + (1.0f-[uv]) == 1.0f).
fn generate_reference_quad_tess_coords(
    spacing_mode: SpacingMode,
    inner0: i32,
    inner1: i32,
    outer0: i32,
    outer1: i32,
    outer2: i32,
    outer3: i32,
) -> Vec<Vec3> {
    let mut tess_coords = Vec::new();

    if inner0 == 1 || inner1 == 1 {
        if inner0 == 1 && inner1 == 1 && outer0 == 1 && outer1 == 1 && outer2 == 1 && outer3 == 1 {
            tess_coords.push(Vec3::new(0.0, 0.0, 0.0));
            tess_coords.push(Vec3::new(1.0, 0.0, 0.0));
            tess_coords.push(Vec3::new(0.0, 1.0, 0.0));
            tess_coords.push(Vec3::new(1.0, 1.0, 0.0));
            return tess_coords;
        }
        let bumped = if spacing_mode == SpacingMode::FractionalOdd {
            3
        } else {
            2
        };
        return generate_reference_quad_tess_coords(
            spacing_mode,
            if inner0 > 1 { inner0 } else { bumped },
            if inner1 > 1 { inner1 } else { bumped },
            outer0,
            outer1,
            outer2,
            outer3,
        );
    }

    for i in 0..outer0 {
        let v = i as f32 / outer0 as f32;
        tess_coords.push(Vec3::new(0.0, v, 0.0));
    }
    for i in 0..outer1 {
        let v = i as f32 / outer1 as f32;
        tess_coords.push(Vec3::new(1.0 - v, 0.0, 0.0));
    }
    for i in 0..outer2 {
        let v = i as f32 / outer2 as f32;
        tess_coords.push(Vec3::new(1.0, 1.0 - v, 0.0));
    }
    for i in 0..outer3 {
        let v = i as f32 / outer3 as f32;
        tess_coords.push(Vec3::new(v, 1.0, 0.0));
    }

    for inner_vtx_y in 0..inner1 - 1 {
        for inner_vtx_x in 0..inner0 - 1 {
            tess_coords.push(Vec3::new(
                (inner_vtx_x + 1) as f32 / inner0 as f32,
                (inner_vtx_y + 1) as f32 / inner1 as f32,
                0.0,
            ));
        }
    }

    tess_coords
}

/// `generateReferenceIsolineTessCoords`
///
/// \note As above, the generated coordinates could break some of the rules given in the spec.
fn generate_reference_isoline_tess_coords(outer0: i32, outer1: i32) -> Vec<Vec3> {
    let mut tess_coords = Vec::new();

    for y in 0..outer0 {
        for x in 0..outer1 + 1 {
            tess_coords.push(Vec3::new(x as f32 / outer1 as f32, y as f32 / outer0 as f32, 0.0));
        }
    }

    tess_coords
}

/// `getClampedRoundedTriangleTessLevels`
fn get_clamped_rounded_triangle_tess_levels(
    spacing_mode: SpacingMode,
    inner_src: &[f32; 2],
    outer_src: &[f32; 4],
) -> (i32, [i32; 3]) {
    let inner = get_clamped_rounded_tess_level(spacing_mode, inner_src[0]);
    let outer = std::array::from_fn(|i| get_clamped_rounded_tess_level(spacing_mode, outer_src[i]));
    (inner, outer)
}

/// `getClampedRoundedQuadTessLevels`
fn get_clamped_rounded_quad_tess_levels(
    spacing_mode: SpacingMode,
    inner_src: &[f32; 2],
    outer_src: &[f32; 4],
) -> ([i32; 2], [i32; 4]) {
    let inner = std::array::from_fn(|i| get_clamped_rounded_tess_level(spacing_mode, inner_src[i]));
    let outer = std::array::from_fn(|i| get_clamped_rounded_tess_level(spacing_mode, outer_src[i]));
    (inner, outer)
}

/// `getClampedRoundedIsolineTessLevels` - the first level is always rounded as if the
/// spacing were equal, which is what the spec says for isolines.
fn get_clamped_rounded_isoline_tess_levels(spacing_mode: SpacingMode, outer_src: &[f32; 4]) -> [i32; 2] {
    [
        get_clamped_rounded_tess_level(SpacingMode::Equal, outer_src[0]),
        get_clamped_rounded_tess_level(spacing_mode, outer_src[1]),
    ]
}

/// `isPatchDiscarded`
fn is_patch_discarded(primitive_type: TessPrimitiveType, outer_levels: &[f32; 4]) -> bool {
    outer_levels[..primitive_type.num_outer_levels()]
        .iter()
        .any(|&level| level <= 0.0)
}

/// `generateReferenceTessCoords`
///
/// Upstream's `DE_ASSERT`s on the fractional spacing modes only restate what
/// `TessCoordCase::genTessLevelCases` has already rounded the levels to, so they are not
/// carried over - an assert here would fire on data this file itself produced, never on
/// anything the driver said.
fn generate_reference_tess_coords(
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    inner_levels: &[f32; 2],
    outer_levels: &[f32; 4],
) -> Vec<Vec3> {
    if is_patch_discarded(primitive_type, outer_levels) {
        return Vec::new();
    }

    match primitive_type {
        TessPrimitiveType::Triangles => {
            let (inner, outer) = get_clamped_rounded_triangle_tess_levels(spacing_mode, inner_levels, outer_levels);
            generate_reference_triangle_tess_coords(spacing_mode, inner, outer[0], outer[1], outer[2])
        }
        TessPrimitiveType::Quads => {
            let (inner, outer) = get_clamped_rounded_quad_tess_levels(spacing_mode, inner_levels, outer_levels);
            generate_reference_quad_tess_coords(
                spacing_mode,
                inner[0],
                inner[1],
                outer[0],
                outer[1],
                outer[2],
                outer[3],
            )
        }
        TessPrimitiveType::Isolines => {
            let outer = get_clamped_rounded_isoline_tess_levels(spacing_mode, outer_levels);
            generate_reference_isoline_tess_coords(outer[0], outer[1])
        }
    }
}

/// `referenceTriangleNonPointModePrimitiveCount`
fn reference_triangle_non_point_mode_primitive_count(
    spacing_mode: SpacingMode,
    inner: i32,
    outer0: i32,
    outer1: i32,
    outer2: i32,
) -> i32 {
    if inner == 1 {
        if outer0 == 1 && outer1 == 1 && outer2 == 1 {
            return 1;
        }
        return reference_triangle_non_point_mode_primitive_count(
            spacing_mode,
            if spacing_mode == SpacingMode::FractionalOdd {
                3
            } else {
                2
            },
            outer0,
            outer1,
            outer2,
        );
    }

    let mut result = outer0 + outer1 + outer2;

    let num_inner_triangles = inner / 2;
    for inner_triangle_ndx in 0..num_inner_triangles {
        let cur_inner_triangle_level = inner - 2 * (inner_triangle_ndx + 1);

        if cur_inner_triangle_level == 1 {
            result += 4;
        } else {
            result += 2 * 3 * cur_inner_triangle_level;
        }
    }

    result
}

/// `referenceQuadNonPointModePrimitiveCount`
fn reference_quad_non_point_mode_primitive_count(
    spacing_mode: SpacingMode,
    inner0: i32,
    inner1: i32,
    outer0: i32,
    outer1: i32,
    outer2: i32,
    outer3: i32,
) -> i32 {
    if inner0 == 1 || inner1 == 1 {
        if inner0 == 1 && inner1 == 1 && outer0 == 1 && outer1 == 1 && outer2 == 1 && outer3 == 1 {
            return 2;
        }
        let bumped = if spacing_mode == SpacingMode::FractionalOdd {
            3
        } else {
            2
        };
        return reference_quad_non_point_mode_primitive_count(
            spacing_mode,
            if inner0 > 1 { inner0 } else { bumped },
            if inner1 > 1 { inner1 } else { bumped },
            outer0,
            outer1,
            outer2,
            outer3,
        );
    }

    2 * (inner0 - 2) * (inner1 - 2) + 2 * (inner0 - 2) + 2 * (inner1 - 2) + outer0 + outer1 + outer2 + outer3
}

/// `referenceIsolineNonPointModePrimitiveCount`
const fn reference_isoline_non_point_mode_primitive_count(outer0: i32, outer1: i32) -> i32 {
    outer0 * outer1
}

/// `referencePointModePrimitiveCount`
fn reference_point_mode_primitive_count(
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    inner_levels: &[f32; 2],
    outer_levels: &[f32; 4],
) -> i32 {
    if is_patch_discarded(primitive_type, outer_levels) {
        return 0;
    }

    let len = match primitive_type {
        TessPrimitiveType::Triangles => {
            let (inner, outer) = get_clamped_rounded_triangle_tess_levels(spacing_mode, inner_levels, outer_levels);
            generate_reference_triangle_tess_coords(spacing_mode, inner, outer[0], outer[1], outer[2]).len()
        }
        TessPrimitiveType::Quads => {
            let (inner, outer) = get_clamped_rounded_quad_tess_levels(spacing_mode, inner_levels, outer_levels);
            generate_reference_quad_tess_coords(
                spacing_mode,
                inner[0],
                inner[1],
                outer[0],
                outer[1],
                outer[2],
                outer[3],
            )
            .len()
        }
        TessPrimitiveType::Isolines => {
            let outer = get_clamped_rounded_isoline_tess_levels(spacing_mode, outer_levels);
            generate_reference_isoline_tess_coords(outer[0], outer[1]).len()
        }
    };

    i32::try_from(len).unwrap_or(i32::MAX)
}

/// `referenceNonPointModePrimitiveCount`
fn reference_non_point_mode_primitive_count(
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    inner_levels: &[f32; 2],
    outer_levels: &[f32; 4],
) -> i32 {
    if is_patch_discarded(primitive_type, outer_levels) {
        return 0;
    }

    match primitive_type {
        TessPrimitiveType::Triangles => {
            let (inner, outer) = get_clamped_rounded_triangle_tess_levels(spacing_mode, inner_levels, outer_levels);
            reference_triangle_non_point_mode_primitive_count(spacing_mode, inner, outer[0], outer[1], outer[2])
        }
        TessPrimitiveType::Quads => {
            let (inner, outer) = get_clamped_rounded_quad_tess_levels(spacing_mode, inner_levels, outer_levels);
            reference_quad_non_point_mode_primitive_count(
                spacing_mode,
                inner[0],
                inner[1],
                outer[0],
                outer[1],
                outer[2],
                outer[3],
            )
        }
        TessPrimitiveType::Isolines => {
            let outer = get_clamped_rounded_isoline_tess_levels(spacing_mode, outer_levels);
            reference_isoline_non_point_mode_primitive_count(outer[0], outer[1])
        }
    }
}

/// `referencePrimitiveCount`
fn reference_primitive_count(
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    use_point_mode: bool,
    inner_levels: &[f32; 2],
    outer_levels: &[f32; 4],
) -> i32 {
    if use_point_mode {
        reference_point_mode_primitive_count(primitive_type, spacing_mode, inner_levels, outer_levels)
    } else {
        reference_non_point_mode_primitive_count(primitive_type, spacing_mode, inner_levels, outer_levels)
    }
}

/// `referenceVertexCount`
pub(super) fn reference_vertex_count(
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    use_point_mode: bool,
    inner_levels: &[f32; 2],
    outer_levels: &[f32; 4],
) -> i32 {
    reference_primitive_count(primitive_type, spacing_mode, use_point_mode, inner_levels, outer_levels)
        * i32::try_from(num_vertices_per_primitive(output_primitive_type_gl(
            primitive_type,
            use_point_mode,
        )))
        .unwrap_or(1)
}

/// `oneWayComparePointSets` - check that all points in `subset` are (approximately)
/// present also in `superset`.
///
/// Upstream additionally paints every unmatched point into a `tcu::Surface` and logs the
/// two visualizations as images; this runner has no image log, and the verdict comes only
/// from `numFailuresDetected`, so the drawing is left out.
fn one_way_compare_point_sets(subset: &[Vec3], superset: &[Vec3], subset_name: &str, superset_name: &str) -> bool {
    // `sorted(superset, vec3XLessThan)`
    let mut superset_sorted = superset.to_vec();
    superset_sorted.sort_by(|a, b| a.x().partial_cmp(&b.x()).unwrap_or(std::cmp::Ordering::Equal));

    const EPSILON: f32 = 0.01;
    const MAX_NUM_FAILURE_PRINTS: i32 = 5;
    let mut num_failures_detected = 0;

    for sub_pt in subset {
        // Binary search the index of the first point in supersetSorted with x in the
        // [subPt.x() - epsilon, subPt.x() + epsilon] range.
        let match_min = *sub_pt - EPSILON;
        let match_max = *sub_pt + EPSILON;
        let first_candidate_ndx = superset_sorted.partition_point(|p| p.x() < match_min.x());

        let match_found = superset_sorted[first_candidate_ndx..]
            .iter()
            .take_while(|super_pt| super_pt.x() <= match_max.x())
            .any(|super_pt| (0..3).all(|i| super_pt[i] >= match_min[i] && super_pt[i] <= match_max[i]));

        if !match_found {
            num_failures_detected += 1;
            if num_failures_detected < MAX_NUM_FAILURE_PRINTS {
                log::warn!(
                    "Failure: no matching {superset_name} point found for {subset_name} point {}",
                    vec_to_string(&sub_pt.m_data)
                );
            } else if num_failures_detected == MAX_NUM_FAILURE_PRINTS {
                log::warn!("Note: More errors follow");
            }
        }
    }

    num_failures_detected == 0
}

/// `compareTessCoords`
fn compare_tess_coords(ref_coords: &[Vec3], res_coords: &[Vec3]) -> bool {
    // Check that all points in reference also exist in result.
    let mut success = one_way_compare_point_sets(ref_coords, res_coords, "reference", "result");
    // Check that all points in result also exist in reference.
    success = one_way_compare_point_sets(res_coords, ref_coords, "result", "reference") && success;
    success
}

/// `tcu::operator<<(ostream, Vector<float, N>)`
fn vec_to_string(components: &[f32]) -> String {
    format!(
        "({})",
        components
            .iter()
            .map(|&v| to_string_f32(v))
            .collect::<Vec<_>>()
            .join(", ")
    )
}

/// `elemsStr`, for the one wrap-free float-slice use `tessellationLevelsString` makes of it.
fn elems_str(values: &[f32]) -> String {
    let body = values.iter().map(|&v| to_string_f32(v)).collect::<Vec<_>>().join(", ");
    format!("{{ {body} }}")
}

/// `tessellationLevelsString(inner, outer)` - the overload that prints all six levels
/// whatever the primitive type is.
fn tessellation_levels_string_all(inner: &[f32], outer: &[f32]) -> String {
    format!("inner: {}, outer: {}", elems_str(inner), elems_str(outer))
}

/// `tessellationLevelsString(inner, outer, primType)`
fn tessellation_levels_string(inner: &[f32; 2], outer: &[f32; 4], primitive_type: TessPrimitiveType) -> String {
    format!(
        "inner: {}, outer: {}",
        elems_str(&inner[..primitive_type.num_inner_levels()]),
        elems_str(&outer[..primitive_type.num_outer_levels()])
    )
}

/// `TessCoordCase::RENDER_SIZE`
const TESS_COORD_RENDER_SIZE: i32 = 16;

/// `TessCoordCase::TessLevels`
#[derive(Clone, Copy)]
struct TessLevels {
    inner: [f32; 2],
    outer: [f32; 4],
}

/// `TessCoordCase::genTessLevelCases`
fn gen_tess_coord_tess_level_cases(primitive_type: TessPrimitiveType, spacing: SpacingMode) -> Vec<TessLevels> {
    const RAW_TESS_LEVEL_CASES: [TessLevels; 9] = [
        TessLevels {
            inner: [1.0, 1.0],
            outer: [1.0, 1.0, 1.0, 1.0],
        },
        TessLevels {
            inner: [63.0, 24.0],
            outer: [15.0, 42.0, 10.0, 12.0],
        },
        TessLevels {
            inner: [3.0, 2.0],
            outer: [6.0, 8.0, 7.0, 9.0],
        },
        TessLevels {
            inner: [4.0, 6.0],
            outer: [2.0, 3.0, 1.0, 4.0],
        },
        TessLevels {
            inner: [2.0, 2.0],
            outer: [6.0, 8.0, 7.0, 9.0],
        },
        TessLevels {
            inner: [5.0, 6.0],
            outer: [1.0, 1.0, 1.0, 1.0],
        },
        TessLevels {
            inner: [1.0, 6.0],
            outer: [2.0, 3.0, 1.0, 4.0],
        },
        TessLevels {
            inner: [5.0, 1.0],
            outer: [2.0, 3.0, 1.0, 4.0],
        },
        TessLevels {
            inner: [5.2, 1.6],
            outer: [2.9, 3.4, 1.5, 4.1],
        },
    ];

    if spacing == SpacingMode::Equal {
        return RAW_TESS_LEVEL_CASES.to_vec();
    }

    let mut result = Vec::with_capacity(RAW_TESS_LEVEL_CASES.len());

    for mut cur in RAW_TESS_LEVEL_CASES {
        for level in &mut cur.inner {
            *level = get_clamped_rounded_tess_level(spacing, *level) as f32;
        }
        for level in &mut cur.outer {
            *level = get_clamped_rounded_tess_level(spacing, *level) as f32;
        }

        match primitive_type {
            TessPrimitiveType::Triangles => {
                if (cur.outer[0] > 1.0 || cur.outer[1] > 1.0 || cur.outer[2] > 1.0) && cur.inner[0] == 1.0 {
                    cur.inner[0] = get_clamped_rounded_tess_level(spacing, cur.inner[0] + 0.1) as f32;
                }
            }
            TessPrimitiveType::Quads => {
                if cur.outer[0] > 1.0 || cur.outer[1] > 1.0 || cur.outer[2] > 1.0 || cur.outer[3] > 1.0 {
                    if cur.inner[0] == 1.0 {
                        cur.inner[0] = get_clamped_rounded_tess_level(spacing, cur.inner[0] + 0.1) as f32;
                    }
                    if cur.inner[1] == 1.0 {
                        cur.inner[1] = get_clamped_rounded_tess_level(spacing, cur.inner[1] + 0.1) as f32;
                    }
                }
            }
            TessPrimitiveType::Isolines => {}
        }

        result.push(cur);
    }

    result
}

/// `TessCoordCase::init`'s four shader templates, in upstream's order.
fn tess_coord_program<'gl>(
    context: &'gl Context,
    primitive_type: TessPrimitiveType,
    spacing: SpacingMode,
) -> ShaderProgram<'gl> {
    const VERTEX_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n${GLSL_PER_VERTEX_OUT}\n\nvoid main (void)\n{\n}\n";
    const TESS_CONTROL_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         ${TESSELLATION_SHADER_REQUIRE}\n\
         ${GLSL_PER_VERTEX_IN_ARR}\n\
         ${GLSL_PER_VERTEX_OUT_ARR}\n\
         \n\
         layout (vertices = 1) out;\n\
         \n\
         uniform mediump float u_tessLevelInner0;\n\
         uniform mediump float u_tessLevelInner1;\n\
         \n\
         uniform mediump float u_tessLevelOuter0;\n\
         uniform mediump float u_tessLevelOuter1;\n\
         uniform mediump float u_tessLevelOuter2;\n\
         uniform mediump float u_tessLevelOuter3;\n\
         \n\
         void main (void)\n\
         {\n\
         \tgl_TessLevelInner[0] = u_tessLevelInner0;\n\
         \tgl_TessLevelInner[1] = u_tessLevelInner1;\n\
         \n\
         \tgl_TessLevelOuter[0] = u_tessLevelOuter0;\n\
         \tgl_TessLevelOuter[1] = u_tessLevelOuter1;\n\
         \tgl_TessLevelOuter[2] = u_tessLevelOuter2;\n\
         \tgl_TessLevelOuter[3] = u_tessLevelOuter3;\n\
         }\n";
    const FRAGMENT_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         \n\
         layout (location = 0) out mediump vec4 o_color;\n\
         \n\
         void main (void)\n\
         {\n\
         \to_color = vec4(1.0);\n\
         }\n";

    // `getTessellationEvaluationInLayoutString(m_primitiveType, m_spacing, true)`
    let in_layout = format!(
        "layout ({}, {}, point_mode) in;\n",
        primitive_type.shader_name(),
        spacing.shader_name()
    );
    let tess_eval_template = format!(
        "${{GLSL_VERSION_DECL}}\n\
         ${{TESSELLATION_SHADER_REQUIRE}}\n\
         ${{GLSL_PER_VERTEX_IN_ARR}}\n\
         ${{GLSL_PER_VERTEX_OUT}}\n\
         \n\
         {in_layout}\n\
         out highp vec3 out_te_tessCoord;\n\
         \n\
         void main (void)\n\
         {{\n\
         \tout_te_tessCoord = gl_TessCoord;\n\
         \tgl_Position = vec4(gl_TessCoord.xy*1.6 - 0.8, 0.0, 1.0);\n\
         }}\n"
    );

    let sources = ProgramSources::default()
        .with(ShaderType::Vertex, specialize_shader(context, VERTEX_TEMPLATE))
        .with(
            ShaderType::TessControl,
            specialize_shader(context, TESS_CONTROL_TEMPLATE),
        )
        .with(
            ShaderType::TessEvaluation,
            specialize_shader(context, &tess_eval_template),
        )
        .with(ShaderType::Fragment, specialize_shader(context, FRAGMENT_TEMPLATE))
        .with_transform_feedback(&["out_te_tessCoord".to_string()], glw::GL_INTERLEAVED_ATTRIBS);

    ShaderProgram::new(context.gl(), &sources)
}

/// `TessCoordCase::init` + `TessCoordCase::iterate`.
fn tess_coord_case(case: &mut ApiCase<'_>, name: &str, primitive_type: TessPrimitiveType, spacing: SpacingMode) {
    if !check_tessellation_support(case) {
        return;
    }

    // `checkRenderTargetSize`
    let render_target = case.context().render_target();
    if render_target.width < TESS_COORD_RENDER_SIZE || render_target.height < TESS_COORD_RENDER_SIZE {
        case.not_supported(format!(
            "Render target width and height must be at least {TESS_COORD_RENDER_SIZE}"
        ));
        return;
    }

    let context = case.context();
    let gl = case.gl();
    let program = tess_coord_program(context, primitive_type, spacing);
    if !program.is_ok() {
        // `TCU_FAIL("Program compilation failed")`
        case.fail("Program compilation failed".to_string(), "Program compilation failed");
        return;
    }
    let program_gl = program.program();

    // SAFETY: names from a program that linked; an absent uniform yields -1, a no-op below.
    let (inner0_loc, inner1_loc, outer0_loc, outer1_loc, outer2_loc, outer3_loc) = unsafe {
        (
            gl.get_uniform_location(program_gl, c"u_tessLevelInner0".as_ptr()),
            gl.get_uniform_location(program_gl, c"u_tessLevelInner1".as_ptr()),
            gl.get_uniform_location(program_gl, c"u_tessLevelOuter0".as_ptr()),
            gl.get_uniform_location(program_gl, c"u_tessLevelOuter1".as_ptr()),
            gl.get_uniform_location(program_gl, c"u_tessLevelOuter2".as_ptr()),
            gl.get_uniform_location(program_gl, c"u_tessLevelOuter3".as_ptr()),
        )
    };

    let tess_level_cases = gen_tess_coord_tess_level_cases(primitive_type, spacing);
    let case_references: Vec<Vec<Vec3>> = tess_level_cases
        .iter()
        .map(|levels| generate_reference_tess_coords(primitive_type, spacing, &levels.inner, &levels.outer))
        .collect();

    let max_num_vertices = case_references.iter().map(Vec::len).max().unwrap_or(0);
    let handler = TransformFeedbackHandler::new(gl, 3, i32::try_from(max_num_vertices).unwrap_or(i32::MAX));

    let mut success = true;

    // `RandomViewport(renderTarget, RENDER_SIZE, RENDER_SIZE, deStringHash(getName()))`
    let width = TESS_COORD_RENDER_SIZE.min(render_target.width);
    let height = TESS_COORD_RENDER_SIZE.min(render_target.height);
    let mut rnd = Random::new(de_string_hash(name));
    let vp_x = rnd.get_int(0, render_target.width - width);
    let vp_y = rnd.get_int(0, render_target.height - height);

    // SAFETY: plain state setters on a program that linked.
    unsafe {
        gl.viewport(vp_x, vp_y, width, height);
        gl.use_program(program_gl);
        gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1);
    }

    for (levels, tess_coords_ref) in tess_level_cases.iter().zip(&case_references) {
        log::info!(
            "Tessellation levels: {}",
            tessellation_levels_string(&levels.inner, &levels.outer, primitive_type)
        );

        // SAFETY: locations from this program, or -1, which is a no-op.
        unsafe {
            gl.uniform_1f(inner0_loc, levels.inner[0]);
            gl.uniform_1f(inner1_loc, levels.inner[1]);
            gl.uniform_1f(outer0_loc, levels.outer[0]);
            gl.uniform_1f(outer1_loc, levels.outer[1]);
            gl.uniform_1f(outer2_loc, levels.outer[2]);
            gl.uniform_1f(outer3_loc, levels.outer[3]);
        }
        case.expect_no_error("Setup failed");

        let tf_result = match handler.render_and_get_primitives(context, program_gl, glw::GL_POINTS, &[], 1) {
            Ok(result) => result,
            Err(e) => {
                case.fail(e.to_string(), "Invalid tessellation coordinates");
                return;
            }
        };

        if tf_result.num_primitives as usize != tess_coords_ref.len() {
            log::warn!(
                "Failure: GL reported GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN to be {}, reference value is {} (logging further info anyway)",
                tf_result.num_primitives,
                tess_coords_ref.len()
            );
            success = false;
        } else {
            log::info!(
                "Note: GL reported GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN to be {}",
                tf_result.num_primitives
            );
        }

        let (res_lanes, _) = tf_result.varying.as_chunks::<3>();
        let res_coords: Vec<Vec3> = res_lanes.iter().copied().map(Vec3::from_array).collect();
        success = compare_tess_coords(tess_coords_ref, &res_coords) && success;

        if !success {
            break;
        }
        log::info!("All OK");
    }

    if !success {
        case.fail(
            "tessellation coordinates did not match the reference".to_string(),
            "Invalid tessellation coordinates",
        );
    }
}

/// `TessellationTests::init`'s `.tesscoord` sub-group.
fn tess_coord_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("tesscoord");

    for primitive_type in [
        TessPrimitiveType::Triangles,
        TessPrimitiveType::Quads,
        TessPrimitiveType::Isolines,
    ] {
        for spacing in [
            SpacingMode::Equal,
            SpacingMode::FractionalOdd,
            SpacingMode::FractionalEven,
        ] {
            let name = format!("{}_{}", primitive_type.shader_name(), spacing.shader_name());
            let case_name = name.clone();
            add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
                tess_coord_case(case, &case_name, primitive_type, spacing)
            });
        }
    }

    group
}

// ---------------------------------------------------------------------------------------
// primitive_discard
// ---------------------------------------------------------------------------------------

/// `PrimitiveDiscardCase::RENDER_SIZE`
const PRIMITIVE_DISCARD_RENDER_SIZE: i32 = 256;

/// Tess levels, scale, offset - `numAttribsPerPrimitive` in `PrimitiveDiscardCase::iterate`.
const NUM_ATTRIBS_PER_PRIMITIVE: usize = 6 + 2 + 2;

/// `PrimitiveDiscardCase::genAttributes`
///
/// Generate input attributes (tessellation levels, and position scale and offset) for a
/// number of primitives. Each primitive has a different combination of tessellation
/// levels; each level is either a valid value or an "invalid" value (negative or zero,
/// chosen from `invalidTessLevelChoices`).
///
/// \note The attributes are generated in such an order that all of the valid attribute
/// tuples come before the first invalid one both in the result vector, and when scanning
/// the resulting 2d grid of primitives is scanned in y-major order. This makes
/// verification somewhat simpler.
fn gen_primitive_discard_attributes() -> Vec<f32> {
    const BASE_TESS_LEVELS: [f32; 6] = [3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
    const INVALID_TESS_LEVEL_CHOICES: [f32; 2] = [-0.42, 0.0];
    const NUM_CHOICES: usize = 1 + INVALID_TESS_LEVEL_CHOICES.len();

    let mut choices = [[0.0f32; NUM_CHOICES]; 6];
    for (level_ndx, level_choices) in choices.iter_mut().enumerate() {
        for (choice_ndx, choice) in level_choices.iter_mut().enumerate() {
            *choice = if choice_ndx == 0 {
                BASE_TESS_LEVELS[level_ndx]
            } else {
                INVALID_TESS_LEVEL_CHOICES[choice_ndx - 1]
            };
        }
    }

    let mut result = Vec::new();

    // sqrt(numChoices**6) == sqrt(number of primitives)
    let num_cols = NUM_CHOICES.pow(6 / 2);
    let num_rows = num_cols;
    let mut index = 0usize;
    let mut i = [0usize; 6];

    // We could do this with some generic combination-generation function, but meh, it's not that bad.
    for i2 in 0..NUM_CHOICES {
        // First  outer
        i[2] = i2;
        for i3 in 0..NUM_CHOICES {
            // Second outer
            i[3] = i3;
            for i4 in 0..NUM_CHOICES {
                // Third  outer
                i[4] = i4;
                for i5 in 0..NUM_CHOICES {
                    // Fourth outer
                    i[5] = i5;
                    for i0 in 0..NUM_CHOICES {
                        // First  inner
                        i[0] = i0;
                        for i1 in 0..NUM_CHOICES {
                            // Second inner
                            i[1] = i1;

                            for j in 0..6 {
                                result.push(choices[j][i[j]]);
                            }

                            let col = index % num_cols;
                            let row = index / num_cols;
                            // Position scale.
                            result.push(2.0 / num_cols as f32);
                            result.push(2.0 / num_rows as f32);
                            // Position offset.
                            result.push(col as f32 / num_cols as f32 * 2.0 - 1.0);
                            result.push(row as f32 / num_rows as f32 * 2.0 - 1.0);

                            index += 1;
                        }
                    }
                }
            }
        }
    }

    result
}

/// `PrimitiveDiscardCase::init`'s four shader templates, in upstream's order.
fn primitive_discard_program<'gl>(
    context: &'gl Context,
    primitive_type: TessPrimitiveType,
    spacing: SpacingMode,
    winding: Winding,
    use_point_mode: bool,
) -> ShaderProgram<'gl> {
    const VERTEX_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         ${GLSL_PER_VERTEX_OUT}\n\
         \n\
         in highp float in_v_attr;\n\
         out highp float in_tc_attr;\n\
         \n\
         void main (void)\n\
         {\n\
         \tin_tc_attr = in_v_attr;\n\
         }\n";
    const TESS_CONTROL_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         ${TESSELLATION_SHADER_REQUIRE}\n\
         ${GLSL_PER_VERTEX_IN_ARR}\n\
         ${GLSL_PER_VERTEX_OUT_ARR}\n\
         \n\
         layout (vertices = 1) out;\n\
         \n\
         in highp float in_tc_attr[];\n\
         \n\
         patch out highp vec2 in_te_positionScale;\n\
         patch out highp vec2 in_te_positionOffset;\n\
         \n\
         void main (void)\n\
         {\n\
         \tin_te_positionScale  = vec2(in_tc_attr[6], in_tc_attr[7]);\n\
         \tin_te_positionOffset = vec2(in_tc_attr[8], in_tc_attr[9]);\n\
         \n\
         \tgl_TessLevelInner[0] = in_tc_attr[0];\n\
         \tgl_TessLevelInner[1] = in_tc_attr[1];\n\
         \n\
         \tgl_TessLevelOuter[0] = in_tc_attr[2];\n\
         \tgl_TessLevelOuter[1] = in_tc_attr[3];\n\
         \tgl_TessLevelOuter[2] = in_tc_attr[4];\n\
         \tgl_TessLevelOuter[3] = in_tc_attr[5];\n\
         }\n";
    const FRAGMENT_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         \n\
         layout (location = 0) out mediump vec4 o_color;\n\
         \n\
         void main (void)\n\
         {\n\
         \to_color = vec4(1.0);\n\
         }\n";

    // `getTessellationEvaluationInLayoutString(m_primitiveType, m_spacing, m_winding, m_usePointMode)`
    let in_layout = format!(
        "layout ({}, {}, {}{}) in;\n",
        primitive_type.shader_name(),
        spacing.shader_name(),
        winding.shader_name(),
        if use_point_mode { ", point_mode" } else { "" }
    );
    let tess_eval_template = format!(
        "${{GLSL_VERSION_DECL}}\n\
         ${{TESSELLATION_SHADER_REQUIRE}}\n\
         ${{GLSL_PER_VERTEX_IN_ARR}}\n\
         ${{GLSL_PER_VERTEX_OUT}}\n\
         \n\
         {in_layout}\n\
         patch in highp vec2 in_te_positionScale;\n\
         patch in highp vec2 in_te_positionOffset;\n\
         \n\
         out highp vec3 out_te_tessCoord;\n\
         \n\
         void main (void)\n\
         {{\n\
         \tout_te_tessCoord = gl_TessCoord;\n\
         \tgl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);\n\
         }}\n"
    );

    let sources = ProgramSources::default()
        .with(ShaderType::Vertex, specialize_shader(context, VERTEX_TEMPLATE))
        .with(
            ShaderType::TessControl,
            specialize_shader(context, TESS_CONTROL_TEMPLATE),
        )
        .with(
            ShaderType::TessEvaluation,
            specialize_shader(context, &tess_eval_template),
        )
        .with(ShaderType::Fragment, specialize_shader(context, FRAGMENT_TEMPLATE))
        .with_transform_feedback(&["out_te_tessCoord".to_string()], glw::GL_INTERLEAVED_ATTRIBS);

    ShaderProgram::new(context.gl(), &sources)
}

/// The per-patch halves of one `PrimitiveDiscardCase` attribute tuple.
fn patch_levels(attributes: &[f32], patch_ndx: usize) -> (&[f32; 2], &[f32; 4]) {
    let attr = &attributes[NUM_ATTRIBS_PER_PRIMITIVE * patch_ndx..];
    (
        attr[0..2].try_into().expect("two inner levels"),
        attr[2..6].try_into().expect("four outer levels"),
    )
}

/// The pixel-checking half of `PrimitiveDiscardCase::iterate`. Returns false on the first
/// failure, which is where upstream `return STOP`s.
fn verify_primitive_discard_image(
    case: &mut ApiCase<'_>,
    pixels: &Surface,
    attributes: &[f32],
    primitive_type: TessPrimitiveType,
    is_msaa: bool,
) -> bool {
    let num_primitives = attributes.len() / NUM_ATTRIBS_PER_PRIMITIVE;
    let black = RGBA::new(0, 0, 0, 255);
    let white = RGBA::new(255, 255, 255, 255);

    // Check that white pixels are found around every non-discarded patch, and that only
    // black pixels are found after the last non-discarded patch.
    let mut last_white_pixel_row = 0;
    let mut second_to_last_white_pixel_row = 0;
    let mut last_white_pixel_column_on_second_to_last_white_pixel_row = 0;

    for patch_ndx in 0..num_primitives {
        let attr = &attributes[NUM_ATTRIBS_PER_PRIMITIVE * patch_ndx..];
        let (_, outer_levels) = patch_levels(attributes, patch_ndx);
        let valid_levels = !is_patch_discarded(primitive_type, outer_levels);

        if !valid_levels {
            // First discarded primitive patch; the remaining are guaranteed to be discarded ones as well.
            for y in 0..pixels.get_height() {
                for x in 0..pixels.get_width() {
                    let outside_every_patch = y > last_white_pixel_row
                        || (y > second_to_last_white_pixel_row
                            && x > last_white_pixel_column_on_second_to_last_white_pixel_row);
                    if outside_every_patch && pixels.get_pixel(x, y) != black {
                        let area = if last_white_pixel_column_on_second_to_last_white_pixel_row < pixels.get_width() - 1
                        {
                            format!(
                                "y > {last_white_pixel_row} || (y > {second_to_last_white_pixel_row} && x > {last_white_pixel_column_on_second_to_last_white_pixel_row})"
                            )
                        } else {
                            format!("y > {last_white_pixel_row}")
                        };
                        log::warn!(
                            "Failure: expected all pixels to be black in the area {area} (they all correspond to patches that should be discarded)"
                        );
                        log::warn!("Note: pixel ({x}, {y}) isn't black");
                        case.fail(
                            "a pixel outside every non-discarded patch is not black".to_string(),
                            "Image verification failed",
                        );
                        return false;
                    }
                }
            }

            return true;
        }

        // Not a discarded patch; check that at least one white pixel is found in its area.
        let scale = &attr[6..8];
        let offset = &attr[8..10];
        let x0 = ((offset[0] + 1.0) * 0.5 * pixels.get_width() as f32) as i32 - 1;
        let x1 = ((scale[0] + offset[0] + 1.0) * 0.5 * pixels.get_width() as f32) as i32 + 1;
        let y0 = ((offset[1] + 1.0) * 0.5 * pixels.get_height() as f32) as i32 - 1;
        let y1 = ((scale[1] + offset[1] + 1.0) * 0.5 * pixels.get_height() as f32) as i32 + 1;
        let mut pixel_ok = false;

        if y1 > last_white_pixel_row {
            second_to_last_white_pixel_row = last_white_pixel_row;
            last_white_pixel_row = y1;
        }
        last_white_pixel_column_on_second_to_last_white_pixel_row = x1;

        'search: for y in y0..=y1 {
            for x in x0..=x1 {
                if x < 0 || x >= pixels.get_width() || y < 0 || y >= pixels.get_height() {
                    continue;
                }

                let hit = if is_msaa {
                    pixels.get_pixel(x, y) != black
                } else {
                    pixels.get_pixel(x, y) == white
                };
                if hit {
                    pixel_ok = true;
                    break 'search;
                }
            }
        }

        if !pixel_ok {
            log::warn!(
                "Failure: expected at least one {} pixel in the rectangle [x0={x0}, y0={y0}, x1={x1}, y1={y1}]",
                if is_msaa { "non-black" } else { "white" }
            );
            // Upstream logs `tessellationLevelsString(&attr[0], &attr[1])`, i.e. the outer
            // levels read one element early; kept as-is so the two logs line up.
            log::warn!(
                "Note: the rectangle approximately corresponds to the patch with these tessellation levels: {}",
                tessellation_levels_string_all(&attr[0..2], &attr[1..5])
            );
            case.fail(
                "no lit pixel inside a patch that should not have been discarded".to_string(),
                "Image verification failed",
            );
            return false;
        }
    }

    true
}

/// `PrimitiveDiscardCase::init` + `PrimitiveDiscardCase::iterate`.
fn primitive_discard_case(
    case: &mut ApiCase<'_>,
    name: &str,
    primitive_type: TessPrimitiveType,
    spacing: SpacingMode,
    winding: Winding,
    use_point_mode: bool,
) {
    if !check_tessellation_support(case) {
        return;
    }

    // `checkRenderTargetSize`
    let render_target = case.context().render_target();
    if render_target.width < PRIMITIVE_DISCARD_RENDER_SIZE || render_target.height < PRIMITIVE_DISCARD_RENDER_SIZE {
        case.not_supported(format!(
            "Render target width and height must be at least {PRIMITIVE_DISCARD_RENDER_SIZE}"
        ));
        return;
    }

    let context = case.context();
    let gl = case.gl();
    let program = primitive_discard_program(context, primitive_type, spacing, winding, use_point_mode);
    if !program.is_ok() {
        // `TCU_FAIL("Program compilation failed")`
        case.fail("Program compilation failed".to_string(), "Program compilation failed");
        return;
    }
    let program_gl = program.program();

    let attributes = gen_primitive_discard_attributes();
    let num_primitives = attributes.len() / NUM_ATTRIBS_PER_PRIMITIVE;

    // `RandomViewport(renderTarget, RENDER_SIZE, RENDER_SIZE, deStringHash(getName()))`
    let width = PRIMITIVE_DISCARD_RENDER_SIZE.min(render_target.width);
    let height = PRIMITIVE_DISCARD_RENDER_SIZE.min(render_target.height);
    let mut rnd = Random::new(de_string_hash(name));
    let vp_x = rnd.get_int(0, render_target.width - width);
    let vp_y = rnd.get_int(0, render_target.height - height);

    // SAFETY: plain state setters on a program that linked.
    unsafe {
        gl.use_program(program_gl);
        gl.viewport(vp_x, vp_y, width, height);
        gl.patch_parameteri(
            glw::GL_PATCH_VERTICES,
            i32::try_from(NUM_ATTRIBS_PER_PRIMITIVE).unwrap_or(0),
        );

        gl.clear_color(0.0, 0.0, 0.0, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
    }

    // Upstream's `DE_ASSERT` that all discarded patches come after the last non-discarded
    // patch is the invariant `genAttributes` is written to hold; it is checked here rather
    // than asserted, since the verification below depends on it.
    let mut discarded_patch_encountered = false;
    for patch_ndx in 0..num_primitives {
        let (_, outer_levels) = patch_levels(&attributes, patch_ndx);
        let discard = is_patch_discarded(primitive_type, outer_levels);
        debug_assert!(
            discard || !discarded_patch_encountered,
            "a valid patch follows a discarded one"
        );
        discarded_patch_encountered = discard;
    }

    let num_vertices_in_draw_call: i32 = (0..num_primitives)
        .map(|patch_ndx| {
            let (inner_levels, outer_levels) = patch_levels(&attributes, patch_ndx);
            reference_vertex_count(primitive_type, spacing, use_point_mode, inner_levels, outer_levels)
        })
        .sum();

    log::info!(
        "Note: rendering {num_primitives} patches; first patches have valid relevant outer levels, but later patches have one or more invalid (i.e. less than or equal to 0.0) relevant outer levels"
    );

    let handler = TransformFeedbackHandler::new(gl, 3, num_vertices_in_draw_call);
    let bindings = [glu::va::float(
        "in_v_attr",
        1,
        i32::try_from(attributes.len()).unwrap_or(i32::MAX),
        0,
        &attributes,
    )];
    let tf_result = match handler.render_and_get_primitives(
        context,
        program_gl,
        output_primitive_type_gl(primitive_type, use_point_mode),
        &bindings,
        i32::try_from(attributes.len()).unwrap_or(i32::MAX),
    ) {
        Ok(result) => result,
        Err(e) => {
            case.fail(e.to_string(), "Wrong number of tessellation coordinates");
            return;
        }
    };

    let mut pixels = Surface::new(width, height);
    if let Err(e) = glu::read_pixels(&context.render_context, vp_x, vp_y, &mut pixels.get_access()) {
        case.fail(e.to_string(), "Image verification failed");
        return;
    }

    let num_varying_vertices = tf_result.varying.len() / 3;
    if num_varying_vertices != num_vertices_in_draw_call as usize {
        log::warn!(
            "Failure: expected {num_vertices_in_draw_call} vertices from transform feedback, got {num_varying_vertices}"
        );
        case.fail(
            format!(
                "expected {num_vertices_in_draw_call} vertices from transform feedback, got {num_varying_vertices}"
            ),
            "Wrong number of tessellation coordinates",
        );
        return;
    }

    verify_primitive_discard_image(
        case,
        &pixels,
        &attributes,
        primitive_type,
        render_target.num_samples > 1,
    );
}

/// `TessellationTests::init`'s `.primitive_discard` sub-group.
fn primitive_discard_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("primitive_discard");

    for primitive_type in [
        TessPrimitiveType::Triangles,
        TessPrimitiveType::Quads,
        TessPrimitiveType::Isolines,
    ] {
        for spacing in [
            SpacingMode::Equal,
            SpacingMode::FractionalOdd,
            SpacingMode::FractionalEven,
        ] {
            for winding in [Winding::Ccw, Winding::Cw] {
                for use_point_mode in [false, true] {
                    let name = format!(
                        "{}_{}_{}{}",
                        primitive_type.shader_name(),
                        spacing.shader_name(),
                        winding.shader_name(),
                        if use_point_mode { "_point_mode" } else { "" }
                    );
                    let case_name = name.clone();
                    add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
                        primitive_discard_case(case, &case_name, primitive_type, spacing, winding, use_point_mode);
                    });
                }
            }
        }
    }

    group
}

// ---------------------------------------------------------------------------------------
// invariance.tess_coord_component_range / invariance.one_minus_tess_coord_component
//
// The other seven `invariance` sub-groups derive from bases that read the framebuffer or
// compare rasterised images; these two are `TessCoordComponentInvarianceCase`, which only
// looks at what transform feedback gave back.
// ---------------------------------------------------------------------------------------

/// `TessCoordComponentInvarianceCase::RENDER_SIZE`
const TESS_COORD_COMPONENT_RENDER_SIZE: i32 = 16;

/// Which of the two `TessCoordComponentInvarianceCase` subclasses a case is.
///
/// Upstream's two subclasses override nothing but the two virtuals below, so one enum
/// stands in for the pair rather than a trait object - the only thing the base would gain
/// from dynamic dispatch here is a second file's worth of boilerplate.
#[derive(Clone, Copy, PartialEq, Eq)]
enum TessCoordComponentCheck {
    /// `TessCoordComponentRangeCase` - invariance rule #8, first part.
    Range,
    /// `OneMinusTessCoordComponentCase` - invariance rule #8, second part.
    OneMinus,
}

impl TessCoordComponentCheck {
    /// `tessEvalOutputComponentStatements`
    fn tess_eval_output_component_statements(
        self,
        tess_coord_component_name: &str,
        output_component_name: &str,
    ) -> String {
        match self {
            Self::Range => format!("\t{output_component_name} = {tess_coord_component_name};\n"),
            Self::OneMinus => format!(
                "    {{\n        float oneMinusComp = 1.0 - {tess_coord_component_name};\n        {output_component_name} = {tess_coord_component_name} + oneMinusComp;\n    }}\n"
            ),
        }
    }

    /// `checkTessCoordComponent`, including the failure message it logs itself.
    fn check(self, component: f32) -> bool {
        match self {
            Self::Range => {
                if !(0.0..=1.0).contains(&component) {
                    log::warn!("Failure: tess coord component isn't in range [0,1]");
                    return false;
                }
                true
            }
            Self::OneMinus => {
                if component != 1.0 {
                    log::warn!(
                        "Failure: comp + (1.0-comp) doesn't equal 1.0 for some component of tessellation coordinate"
                    );
                    return false;
                }
                true
            }
        }
    }
}

/// `TessCoordComponentInvarianceCase::genTessLevelCases`
fn gen_tess_coord_component_tess_level_cases(num_cases: usize) -> Vec<f32> {
    let mut rnd = Random::new(123);
    let mut result = Vec::with_capacity(num_cases * 6);

    for _ in 0..num_cases {
        for _ in 0..6 {
            result.push(rnd.get_float_range(1.0, 63.0));
        }
    }

    result
}

/// `TessCoordComponentInvarianceCase::init`'s four shader templates, in upstream's order.
fn tess_coord_component_invariance_program<'gl>(
    context: &'gl Context,
    check: TessCoordComponentCheck,
    primitive_type: TessPrimitiveType,
    spacing: SpacingMode,
    winding: Winding,
    use_point_mode: bool,
) -> ShaderProgram<'gl> {
    const VERTEX_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         ${GLSL_PER_VERTEX_OUT}\n\
         \n\
         in highp float in_v_attr;\n\
         out highp float in_tc_attr;\n\
         \n\
         void main (void)\n\
         {\n\
         \tin_tc_attr = in_v_attr;\n\
         }\n";
    const TESS_CONTROL_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         ${TESSELLATION_SHADER_REQUIRE}\n\
         ${GLSL_PER_VERTEX_IN_ARR}\n\
         ${GLSL_PER_VERTEX_OUT_ARR}\n\
         \n\
         layout (vertices = 1) out;\n\
         \n\
         in highp float in_tc_attr[];\n\
         \n\
         void main (void)\n\
         {\n\
         \tgl_TessLevelInner[0] = in_tc_attr[0];\n\
         \tgl_TessLevelInner[1] = in_tc_attr[1];\n\
         \n\
         \tgl_TessLevelOuter[0] = in_tc_attr[2];\n\
         \tgl_TessLevelOuter[1] = in_tc_attr[3];\n\
         \tgl_TessLevelOuter[2] = in_tc_attr[4];\n\
         \tgl_TessLevelOuter[3] = in_tc_attr[5];\n\
         }\n";
    const FRAGMENT_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         \n\
         layout (location = 0) out mediump vec4 o_color;\n\
         \n\
         in highp vec4 in_f_color;\n\
         \n\
         void main (void)\n\
         {\n\
         \to_color = in_f_color;\n\
         }\n";

    // `getTessellationEvaluationInLayoutString(m_primitiveType, m_spacing, m_winding, m_usePointMode)`
    let in_layout = format!(
        "layout ({}, {}, {}{}) in;\n",
        primitive_type.shader_name(),
        spacing.shader_name(),
        winding.shader_name(),
        if use_point_mode { ", point_mode" } else { "" }
    );
    let z_statements = if primitive_type == TessPrimitiveType::Triangles {
        check.tess_eval_output_component_statements("gl_TessCoord.z", "out_te_output.z")
    } else {
        "    out_te_output.z = 0.0f;\n".to_string()
    };
    let tess_eval_template = format!(
        "${{GLSL_VERSION_DECL}}\n\
         ${{TESSELLATION_SHADER_REQUIRE}}\n\
         ${{GLSL_PER_VERTEX_IN_ARR}}\n\
         ${{GLSL_PER_VERTEX_OUT}}\n\
         \n\
         {in_layout}\n\
         out highp vec4 in_f_color;\n\
         out highp vec3 out_te_output;\n\
         \n\
         void main (void)\n\
         {{\n\
         {x_statements}{y_statements}{z_statements}\
         \tgl_Position = vec4(gl_TessCoord.xy, 0.0, 1.0);\n\
         \tin_f_color = vec4(1.0);\n\
         }}\n",
        x_statements = check.tess_eval_output_component_statements("gl_TessCoord.x", "out_te_output.x"),
        y_statements = check.tess_eval_output_component_statements("gl_TessCoord.y", "out_te_output.y"),
    );

    let sources = ProgramSources::default()
        .with(ShaderType::Vertex, specialize_shader(context, VERTEX_TEMPLATE))
        .with(
            ShaderType::TessControl,
            specialize_shader(context, TESS_CONTROL_TEMPLATE),
        )
        .with(
            ShaderType::TessEvaluation,
            specialize_shader(context, &tess_eval_template),
        )
        .with(ShaderType::Fragment, specialize_shader(context, FRAGMENT_TEMPLATE))
        .with_transform_feedback(&["out_te_output".to_string()], glw::GL_INTERLEAVED_ATTRIBS);

    ShaderProgram::new(context.gl(), &sources)
}

/// `TessCoordComponentInvarianceCase::init` + `TessCoordComponentInvarianceCase::iterate`.
fn tess_coord_component_invariance_case(
    case: &mut ApiCase<'_>,
    name: &str,
    check: TessCoordComponentCheck,
    primitive_type: TessPrimitiveType,
    spacing: SpacingMode,
    winding: Winding,
    use_point_mode: bool,
) {
    if !check_tessellation_support(case) {
        return;
    }

    // `checkRenderTargetSize`
    let render_target = case.context().render_target();
    if render_target.width < TESS_COORD_COMPONENT_RENDER_SIZE || render_target.height < TESS_COORD_COMPONENT_RENDER_SIZE
    {
        case.not_supported(format!(
            "Render target width and height must be at least {TESS_COORD_COMPONENT_RENDER_SIZE}"
        ));
        return;
    }

    let context = case.context();
    let gl = case.gl();
    let program =
        tess_coord_component_invariance_program(context, check, primitive_type, spacing, winding, use_point_mode);
    if !program.is_ok() {
        // `TCU_FAIL("Program compilation failed")`
        case.fail("Program compilation failed".to_string(), "Program compilation failed");
        return;
    }
    let program_gl = program.program();

    const NUM_TESS_LEVEL_CASES: usize = 32;
    let tess_levels = gen_tess_coord_component_tess_level_cases(NUM_TESS_LEVEL_CASES);

    // `RandomViewport(renderTarget, RENDER_SIZE, RENDER_SIZE, deStringHash(getName()))`
    let width = TESS_COORD_COMPONENT_RENDER_SIZE.min(render_target.width);
    let height = TESS_COORD_COMPONENT_RENDER_SIZE.min(render_target.height);
    let mut rnd = Random::new(de_string_hash(name));
    let vp_x = rnd.get_int(0, render_target.width - width);
    let vp_y = rnd.get_int(0, render_target.height - height);

    // SAFETY: plain state setters on a program that linked.
    unsafe {
        gl.use_program(program_gl);
        gl.viewport(vp_x, vp_y, width, height);
        gl.patch_parameteri(glw::GL_PATCH_VERTICES, 6);
    }

    // Compute the number vertices in the largest draw call, so we can allocate the TF buffer just once.
    let max_num_vertices_in_draw_call = (0..NUM_TESS_LEVEL_CASES)
        .map(|i| {
            let inner: &[f32; 2] = tess_levels[6 * i..6 * i + 2].try_into().expect("two inner levels");
            let outer: &[f32; 4] = tess_levels[6 * i + 2..6 * i + 6].try_into().expect("four outer levels");
            reference_vertex_count(primitive_type, spacing, use_point_mode, inner, outer)
        })
        .max()
        .unwrap_or(0);

    let handler = TransformFeedbackHandler::new(gl, 3, max_num_vertices_in_draw_call);
    let num_comps = if primitive_type == TessPrimitiveType::Triangles {
        3
    } else {
        2
    };

    for tess_level_case_ndx in 0..NUM_TESS_LEVEL_CASES {
        let levels = &tess_levels[6 * tess_level_case_ndx..6 * tess_level_case_ndx + 6];
        log::info!(
            "Testing with tessellation levels: {}",
            tessellation_levels_string_all(&levels[0..2], &levels[2..6])
        );

        let bindings = [glu::va::float("in_v_attr", 1, 6, 0, levels)];
        let tf_result = match handler.render_and_get_primitives(
            context,
            program_gl,
            output_primitive_type_gl(primitive_type, use_point_mode),
            &bindings,
            6,
        ) {
            Ok(result) => result,
            Err(e) => {
                case.fail(e.to_string(), "Invalid tessellation coordinate component");
                return;
            }
        };

        let (vertices, _) = tf_result.varying.as_chunks::<3>();
        for (vtx_ndx, vec) in vertices.iter().enumerate() {
            for &component in &vec[..num_comps] {
                if !check.check(component) {
                    let printed = vec_to_string(&vec[..num_comps]);
                    log::warn!("Note: output value at index {vtx_ndx} is {printed}");
                    case.fail(
                        format!("output value at index {vtx_ndx} is {printed}"),
                        "Invalid tessellation coordinate component",
                    );
                    return;
                }
            }
        }
    }
}

// ---------------------------------------------------------------------------------------
// invariance.primitive_set
// ---------------------------------------------------------------------------------------

/// `PrimitiveSetInvarianceCase::RENDER_SIZE`
const PRIMITIVE_SET_RENDER_SIZE: i32 = 16;

/// `PrimitiveSetInvarianceCase::TessLevels`
#[derive(Clone, Copy)]
struct InvarianceTessLevels {
    inner: [f32; 2],
    outer: [f32; 4],
}

impl InvarianceTessLevels {
    /// `TessLevels::description`
    fn description(&self) -> String {
        tessellation_levels_string_all(&self.inner, &self.outer)
    }
}

/// `PrimitiveSetInvarianceCase::LevelCase`
///
/// `mem` is upstream's "subclass-defined arbitrary piece of data", passed through to
/// `compare`. Only `outer_triangle_set` sets it, to the outer edge index the case varies.
struct InvarianceLevelCase {
    levels: Vec<InvarianceTessLevels>,
    mem: i32,
}

impl InvarianceLevelCase {
    fn single(levels: InvarianceTessLevels) -> Self {
        Self {
            levels: vec![levels],
            mem: 0,
        }
    }

    /// The `tessLevelsStr` `iterate` logs: one line per level set, each preceded by a
    /// newline when there is more than one.
    fn description(&self) -> String {
        let multiple = self.levels.len() > 1;
        self.levels
            .iter()
            .map(|levels| {
                if multiple {
                    format!("\n{}", levels.description())
                } else {
                    levels.description()
                }
            })
            .collect()
    }
}

/// `PrimitiveSetInvarianceCase::genTessLevelCases`
fn gen_primitive_set_tess_level_cases() -> Vec<InvarianceLevelCase> {
    const BASIC_TESS_LEVEL_CASES: [InvarianceTessLevels; 9] = [
        InvarianceTessLevels {
            inner: [1.0, 1.0],
            outer: [1.0, 1.0, 1.0, 1.0],
        },
        InvarianceTessLevels {
            inner: [63.0, 24.0],
            outer: [15.0, 42.0, 10.0, 12.0],
        },
        InvarianceTessLevels {
            inner: [3.0, 2.0],
            outer: [6.0, 8.0, 7.0, 9.0],
        },
        InvarianceTessLevels {
            inner: [4.0, 6.0],
            outer: [2.0, 3.0, 1.0, 4.0],
        },
        InvarianceTessLevels {
            inner: [2.0, 2.0],
            outer: [6.0, 8.0, 7.0, 9.0],
        },
        InvarianceTessLevels {
            inner: [5.0, 6.0],
            outer: [1.0, 1.0, 1.0, 1.0],
        },
        InvarianceTessLevels {
            inner: [1.0, 6.0],
            outer: [2.0, 3.0, 1.0, 4.0],
        },
        InvarianceTessLevels {
            inner: [5.0, 1.0],
            outer: [2.0, 3.0, 1.0, 4.0],
        },
        InvarianceTessLevels {
            inner: [5.2, 1.6],
            outer: [2.9, 3.4, 1.5, 4.1],
        },
    ];

    let mut result: Vec<InvarianceLevelCase> = BASIC_TESS_LEVEL_CASES
        .iter()
        .copied()
        .map(InvarianceLevelCase::single)
        .collect();

    let mut rnd = Random::new(123);
    for _ in 0..10 {
        let mut levels = InvarianceTessLevels {
            inner: [0.0; 2],
            outer: [0.0; 4],
        };
        for value in &mut levels.inner {
            *value = rnd.get_float_range(1.0, 16.0);
        }
        for value in &mut levels.outer {
            *value = rnd.get_float_range(1.0, 16.0);
        }
        result.push(InvarianceLevelCase::single(levels));
    }

    result
}

/// `InvariantInnerTriangleSetCase::genTessLevelCases`
///
/// Each base case becomes one level case of four, the later three differing only in levels
/// the inner triangle set must not depend on. Upstream's `de::Random rnd(123)` is a second
/// stream, independent of the one the base used for its own ten random level sets.
fn gen_inner_triangle_set_tess_level_cases(primitive_type: TessPrimitiveType) -> Vec<InvarianceLevelCase> {
    const NUM_SUB_CASES: usize = 4;

    let base_results = gen_primitive_set_tess_level_cases();
    let mut result = Vec::with_capacity(base_results.len());
    let mut rnd = Random::new(123);

    for base in &base_results {
        let mut levels = base.levels[0];
        let mut level_case = InvarianceLevelCase {
            levels: Vec::with_capacity(NUM_SUB_CASES),
            mem: 0,
        };

        for _ in 0..NUM_SUB_CASES {
            level_case.levels.push(levels);

            for value in &mut levels.outer {
                *value = rnd.get_float_range(2.0, 16.0);
            }
            if primitive_type == TessPrimitiveType::Triangles {
                levels.inner[1] = rnd.get_float_range(2.0, 16.0);
            }
        }

        result.push(level_case);
    }

    result
}

/// `InvariantOuterTriangleSetCase::genTessLevelCases`
///
/// One level case per (base case, outer edge), each of four sub-cases that vary every outer
/// level *except* the edge's own. A base case whose inner level is 1.0 has no inner region
/// to separate the outer triangles from, and is dropped.
fn gen_outer_triangle_set_tess_level_cases(primitive_type: TessPrimitiveType) -> Vec<InvarianceLevelCase> {
    const NUM_SUB_CASES_PER_EDGE: usize = 4;

    let num_edges = match primitive_type {
        TessPrimitiveType::Triangles => 3,
        TessPrimitiveType::Quads => 4,
        TessPrimitiveType::Isolines => unreachable!("outer_triangle_set registers triangles and quads only"),
    };

    let base_result = gen_primitive_set_tess_level_cases();
    let mut result = Vec::new();
    let mut rnd = Random::new(123);

    for base_case in &base_result {
        let base = base_case.levels[0];
        if base.inner[0] == 1.0 || (primitive_type == TessPrimitiveType::Quads && base.inner[1] == 1.0) {
            continue;
        }

        for edge_ndx in 0..num_edges {
            let mut levels = base;
            let mut level_case = InvarianceLevelCase {
                levels: Vec::with_capacity(NUM_SUB_CASES_PER_EDGE),
                mem: i32::try_from(edge_ndx).unwrap_or(0),
            };

            for _ in 0..NUM_SUB_CASES_PER_EDGE {
                level_case.levels.push(levels);

                for (i, value) in levels.outer.iter_mut().enumerate() {
                    if i != edge_ndx {
                        *value = rnd.get_float_range(2.0, 16.0);
                    }
                }
                if primitive_type == TessPrimitiveType::Triangles {
                    levels.inner[1] = rnd.get_float_range(2.0, 16.0);
                }
            }

            result.push(level_case);
        }
    }

    result
}

/// `de::floatToString(value, 2)`
fn float_to_string_2(value: f32) -> String {
    format!("{value:.2}")
}

/// `PrimitiveSetInvarianceCase::init`'s program build, for one (constant expression,
/// winding) pair.
fn primitive_set_program<'gl>(
    context: &'gl Context,
    primitive_type: TessPrimitiveType,
    spacing: SpacingMode,
    winding: Winding,
    use_point_mode: bool,
    constant_expr_case_ndx: i32,
) -> ShaderProgram<'gl> {
    let float_lit01 = float_to_string_2(10.0 / (constant_expr_case_ndx as f32 + 10.0));

    const VERTEX_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         ${GLSL_PER_VERTEX_OUT}\n\
         \n\
         in highp float in_v_attr;\n\
         out highp float in_tc_attr;\n\
         \n\
         void main (void)\n\
         {\n\
         \tin_tc_attr = in_v_attr;\n\
         }\n";

    let tess_control_template = format!(
        "${{GLSL_VERSION_DECL}}\n\
         ${{TESSELLATION_SHADER_REQUIRE}}\n\
         ${{GLSL_PER_VERTEX_IN_ARR}}\n\
         ${{GLSL_PER_VERTEX_OUT_ARR}}\n\
         \n\
         layout (vertices = {}) out;\n\
         \n\
         in highp float in_tc_attr[];\n\
         \n\
         patch out highp float in_te_positionOffset;\n\
         \n\
         void main (void)\n\
         {{\n\
         \tin_te_positionOffset = in_tc_attr[6];\n\
         \n\
         \tgl_TessLevelInner[0] = in_tc_attr[0];\n\
         \tgl_TessLevelInner[1] = in_tc_attr[1];\n\
         \n\
         \tgl_TessLevelOuter[0] = in_tc_attr[2];\n\
         \tgl_TessLevelOuter[1] = in_tc_attr[3];\n\
         \tgl_TessLevelOuter[2] = in_tc_attr[4];\n\
         \tgl_TessLevelOuter[3] = in_tc_attr[5];\n\
         }}\n",
        constant_expr_case_ndx + 1
    );

    // `getTessellationEvaluationInLayoutString(primType, spacing, winding, usePointMode)`
    let in_layout = format!(
        "layout ({}, {}, {}{}) in;\n",
        primitive_type.shader_name(),
        spacing.shader_name(),
        winding.shader_name(),
        if use_point_mode { ", point_mode" } else { "" }
    );

    let tess_eval_template = format!(
        "${{GLSL_VERSION_DECL}}\n\
         ${{TESSELLATION_SHADER_REQUIRE}}\n\
         ${{GLSL_PER_VERTEX_IN_ARR}}\n\
         ${{GLSL_PER_VERTEX_OUT}}\n\
         \n\
         {in_layout}\n\
         patch in highp float in_te_positionOffset;\n\
         \n\
         out highp vec4 in_f_color;\n\
         invariant out highp vec3 out_te_tessCoord;\n\
         \n\
         void main (void)\n\
         {{\n\
         \tgl_Position = vec4(gl_TessCoord.xy*{float_lit01} - in_te_positionOffset + float(gl_PrimitiveID)*0.1, 0.0, 1.0);\n\
         \tin_f_color = vec4({float_lit01});\n\
         \tout_te_tessCoord = gl_TessCoord;\n\
         }}\n"
    );

    const FRAGMENT_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         \n\
         layout (location = 0) out mediump vec4 o_color;\n\
         \n\
         in highp vec4 in_f_color;\n\
         \n\
         void main (void)\n\
         {\n\
         \to_color = in_f_color;\n\
         }\n";

    let sources = ProgramSources::default()
        .with(ShaderType::Vertex, specialize_shader(context, VERTEX_TEMPLATE))
        .with(
            ShaderType::TessControl,
            specialize_shader(context, &tess_control_template),
        )
        .with(
            ShaderType::TessEvaluation,
            specialize_shader(context, &tess_eval_template),
        )
        .with(ShaderType::Fragment, specialize_shader(context, FRAGMENT_TEMPLATE))
        .with_transform_feedback(&["out_te_tessCoord".to_string()], glw::GL_INTERLEAVED_ATTRIBS);

    ShaderProgram::new(context.gl(), &sources)
}

/// `InvariantPrimitiveSetCase::compare`
fn compare_primitive_sets(coords_a: &[Vec3], coords_b: &[Vec3]) -> bool {
    for (vtx_ndx, (a, b)) in coords_a.iter().zip(coords_b).enumerate() {
        if a != b {
            log::warn!("Failure: tessellation coordinate at index {vtx_ndx} differs between two programs");
            log::warn!(
                "Note: the coordinate is {} for the first program and {} for the other",
                vec_to_string(&a.m_data),
                vec_to_string(&b.m_data)
            );
            return false;
        }
    }
    true
}

/// `PrimitiveSetInvarianceCase::WindingUsage`
#[derive(Clone, Copy, PartialEq, Eq)]
enum WindingUsage {
    Ccw,
    Cw,
    Vary,
}

impl WindingUsage {
    /// The `windings` vector `PrimitiveSetInvarianceCase::init` builds from it.
    fn windings(self) -> &'static [Winding] {
        match self {
            Self::Ccw => &[Winding::Ccw],
            Self::Cw => &[Winding::Cw],
            Self::Vary => &[Winding::Ccw, Winding::Cw],
        }
    }
}

/// `PrimitiveSetInvarianceCase`'s `m_primitiveType` / `m_spacing` / `m_usePointMode` /
/// `m_windingUsage`, which every subclass fixes in its constructor.
#[derive(Clone, Copy)]
struct PrimitiveSetInvarianceSpec {
    primitive_type: TessPrimitiveType,
    spacing: SpacingMode,
    use_point_mode: bool,
    winding_usage: WindingUsage,
}

/// `PrimitiveSetInvarianceCase::compare`, the pure virtual each subclass overrides.
///
/// `&dyn Fn` rather than an `fn` pointer because both real overrides close over
/// `m_primitiveType` to pick their triangle predicate.
type InvarianceCompareFn<'a> = &'a dyn Fn(&[Vec3], &[Vec3], i32) -> bool;

/// `PrimitiveSetInvarianceCase::init` + `::iterate`.
fn primitive_set_invariance_case(
    case: &mut ApiCase<'_>,
    name: &str,
    spec: PrimitiveSetInvarianceSpec,
    gen_tess_level_cases: &dyn Fn() -> Vec<InvarianceLevelCase>,
    compare: InvarianceCompareFn<'_>,
) {
    let PrimitiveSetInvarianceSpec {
        primitive_type,
        spacing,
        use_point_mode,
        winding_usage,
    } = spec;

    if !check_tessellation_support(case) {
        return;
    }

    // `checkRenderTargetSize`
    let render_target = case.context().render_target();
    if render_target.width < PRIMITIVE_SET_RENDER_SIZE || render_target.height < PRIMITIVE_SET_RENDER_SIZE {
        case.not_supported(format!(
            "Render target width and height must be at least {PRIMITIVE_SET_RENDER_SIZE}"
        ));
        return;
    }

    let context = case.context();
    let gl = case.gl();

    // `numDifferentConstantExprCases`
    const NUM_DIFFERENT_CONSTANT_EXPR_CASES: i32 = 2;
    // `m_programs`, each entry carrying the winding its `Program::description` prints.
    let mut programs: Vec<(Winding, ShaderProgram<'_>)> = Vec::new();

    for constant_expr_case_ndx in 0..NUM_DIFFERENT_CONSTANT_EXPR_CASES {
        for &winding in winding_usage.windings() {
            let program = primitive_set_program(
                context,
                primitive_type,
                spacing,
                winding,
                use_point_mode,
                constant_expr_case_ndx,
            );
            if !program.is_ok() {
                // `TCU_FAIL("Program compilation failed")`
                case.fail("Program compilation failed".to_string(), "Program compilation failed");
                return;
            }
            if !programs.is_empty() {
                log::info!(
                    "Note: program {} is similar to above, except some constants are different, and: winding mode {}",
                    programs.len(),
                    winding.shader_name()
                );
            }
            programs.push((winding, program));
        }
    }

    let tess_level_cases = gen_tess_level_cases();
    let primitive_counts: Vec<Vec<i32>> = tess_level_cases
        .iter()
        .map(|level_case| {
            level_case
                .levels
                .iter()
                .map(|levels| {
                    reference_primitive_count(primitive_type, spacing, use_point_mode, &levels.inner, &levels.outer)
                })
                .collect()
        })
        .collect();
    let max_num_primitives = primitive_counts.iter().flatten().copied().max().unwrap_or(-1);

    let primitive_type_gl = output_primitive_type_gl(primitive_type, use_point_mode);
    let handler = TransformFeedbackHandler::new(
        gl,
        3,
        2 * max_num_primitives * i32::try_from(num_vertices_per_primitive(primitive_type_gl)).unwrap_or(1),
    );

    // `RandomViewport(renderTarget, RENDER_SIZE, RENDER_SIZE, deStringHash(getName()))`
    let width = PRIMITIVE_SET_RENDER_SIZE.min(render_target.width);
    let height = PRIMITIVE_SET_RENDER_SIZE.min(render_target.height);
    let mut rnd = Random::new(de_string_hash(name));
    let vp_x = rnd.get_int(0, render_target.width - width);
    let vp_y = rnd.get_int(0, render_target.height - height);

    // SAFETY: plain state setters.
    unsafe {
        gl.viewport(vp_x, vp_y, width, height);
        gl.patch_parameteri(glw::GL_PATCH_VERTICES, 7);
    }

    for (tess_level_case_ndx, level_case) in tess_level_cases.iter().enumerate() {
        let mut first_prim_vertices: Vec<Vec3> = Vec::new();

        log::info!("Tessellation level sets: {}", level_case.description());

        for (sub_ndx, levels) in level_case.levels.iter().enumerate() {
            let inner = levels.inner;
            let outer = levels.outer;
            let attribute: [f32; 2 * 7] = [
                inner[0], inner[1], outer[0], outer[1], outer[2], outer[3], 0.0, //
                inner[0], inner[1], outer[0], outer[1], outer[2], outer[3], 0.5,
            ];
            let bindings = [glu::va::float(
                "in_v_attr",
                1,
                i32::try_from(attribute.len()).unwrap_or(i32::MAX),
                0,
                &attribute,
            )];

            for (program_ndx, (_, program)) in programs.iter().enumerate() {
                let program_gl = program.program();
                // SAFETY: a program that linked.
                unsafe { gl.use_program(program_gl) };

                let tf_result = match handler.render_and_get_primitives(
                    context,
                    program_gl,
                    primitive_type_gl,
                    &bindings,
                    attribute.len() as i32,
                ) {
                    Ok(result) => result,
                    Err(e) => {
                        case.fail(e.to_string(), "Invalid set of primitives");
                        return;
                    }
                };

                let expected_primitives = 2 * primitive_counts[tess_level_case_ndx][sub_ndx];
                if tf_result.num_primitives != expected_primitives {
                    log::warn!(
                        "Failure: GL reported GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN to be {}, reference value is {expected_primitives}",
                        tf_result.num_primitives
                    );
                    case.fail("wrong number of primitives".to_string(), "Invalid set of primitives");
                    return;
                }

                let (lanes, _) = tf_result.varying.as_chunks::<3>();
                let vertices: Vec<Vec3> = lanes.iter().copied().map(Vec3::from_array).collect();
                let half = vertices.len() / 2;
                let (prim0_vertices, prim1_vertices) = vertices.split_at(half);

                for (vtx_ndx, (a, b)) in prim0_vertices.iter().zip(prim1_vertices).enumerate() {
                    if a != b {
                        log::warn!(
                            "Failure: tessellation coordinate at index {vtx_ndx} differs between two primitives drawn in one draw call"
                        );
                        log::warn!(
                            "Note: the coordinate is {} for the first primitive and {} for the second",
                            vec_to_string(&a.m_data),
                            vec_to_string(&b.m_data)
                        );
                        log::warn!(
                            "Note: tessellation levels for both primitives were: {}",
                            tessellation_levels_string_all(&inner, &outer)
                        );
                        case.fail(
                            "coordinates differ between two primitives of one draw".to_string(),
                            "Invalid set of primitives",
                        );
                        return;
                    }
                }

                if program_ndx == 0 && sub_ndx == 0 {
                    first_prim_vertices = prim0_vertices.to_vec();
                } else if !compare(&first_prim_vertices, prim0_vertices, level_case.mem) {
                    log::warn!(
                        "Note: comparison of tessellation coordinates failed; comparison was made between following cases:\n\
                     \x20 - case A: program 0, tessellation levels: {}\n\
                     \x20 - case B: program {program_ndx}, tessellation levels: {}",
                        level_case.levels[0].description(),
                        levels.description()
                    );
                    case.fail(
                        "coordinates differ between two programs".to_string(),
                        "Invalid set of primitives",
                    );
                    return;
                }
            }
        }
    }
}

/// `TessellationTests::init`'s `.invariance.primitive_set` sub-group.
fn invariant_primitive_set_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("primitive_set");

    for primitive_type in [
        TessPrimitiveType::Triangles,
        TessPrimitiveType::Quads,
        TessPrimitiveType::Isolines,
    ] {
        for spacing in [
            SpacingMode::Equal,
            SpacingMode::FractionalOdd,
            SpacingMode::FractionalEven,
        ] {
            for winding in [Winding::Ccw, Winding::Cw] {
                for use_point_mode in [false, true] {
                    let name = format!(
                        "{}_{}_{}{}",
                        primitive_type.shader_name(),
                        spacing.shader_name(),
                        winding.shader_name(),
                        if use_point_mode { "_point_mode" } else { "" }
                    );
                    let case_name = name.clone();
                    let winding_usage = if winding == Winding::Ccw {
                        WindingUsage::Ccw
                    } else {
                        WindingUsage::Cw
                    };
                    add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
                        let spec = PrimitiveSetInvarianceSpec {
                            primitive_type,
                            spacing,
                            use_point_mode,
                            winding_usage,
                        };
                        primitive_set_invariance_case(
                            case,
                            &case_name,
                            spec,
                            &gen_primitive_set_tess_level_cases,
                            &|a, b, _mem| compare_primitive_sets(a, b),
                        );
                    });
                }
            }
        }
    }

    group
}

// ---------------------------------------------------------------------------------------
// invariance.outer_edge_division
// ---------------------------------------------------------------------------------------

/// `OuterEdgeDescription` - an outer edge of a triangle, quad or isolines, described by
/// the index of a u/v/w coordinate and the coordinate's value along that edge.
struct OuterEdgeDescription {
    constant_coordinate_index: usize,
    /// `constantCoordinateValueChoices` and `numConstantCoordinateValueChoices` in one:
    /// the slice's own length is the count.
    constant_coordinate_value_choices: &'static [f32],
}

impl OuterEdgeDescription {
    /// `OuterEdgeDescription::description`
    fn description(&self) -> String {
        const COORDINATE_NAMES: [&str; 3] = ["u", "v", "w"];
        self.constant_coordinate_value_choices
            .iter()
            .map(|&value| {
                format!(
                    "{}={}",
                    COORDINATE_NAMES[self.constant_coordinate_index],
                    to_string_f32(value)
                )
            })
            .collect::<Vec<_>>()
            .join(" or ")
    }

    /// `OuterEdgeDescription::contains`
    fn contains(&self, v: Vec3) -> bool {
        self.constant_coordinate_value_choices
            .iter()
            .any(|&value| v.m_data[self.constant_coordinate_index] == value)
    }
}

/// `outerEdgeDescriptions`
fn outer_edge_descriptions(prim_type: TessPrimitiveType) -> &'static [OuterEdgeDescription] {
    const TRIANGLE: [OuterEdgeDescription; 3] = [
        OuterEdgeDescription {
            constant_coordinate_index: 0,
            constant_coordinate_value_choices: &[0.0],
        },
        OuterEdgeDescription {
            constant_coordinate_index: 1,
            constant_coordinate_value_choices: &[0.0],
        },
        OuterEdgeDescription {
            constant_coordinate_index: 2,
            constant_coordinate_value_choices: &[0.0],
        },
    ];
    const QUAD: [OuterEdgeDescription; 4] = [
        OuterEdgeDescription {
            constant_coordinate_index: 0,
            constant_coordinate_value_choices: &[0.0],
        },
        OuterEdgeDescription {
            constant_coordinate_index: 1,
            constant_coordinate_value_choices: &[0.0],
        },
        OuterEdgeDescription {
            constant_coordinate_index: 0,
            constant_coordinate_value_choices: &[1.0],
        },
        OuterEdgeDescription {
            constant_coordinate_index: 1,
            constant_coordinate_value_choices: &[1.0],
        },
    ];
    const ISOLINES: [OuterEdgeDescription; 1] = [OuterEdgeDescription {
        constant_coordinate_index: 0,
        constant_coordinate_value_choices: &[0.0, 1.0],
    }];

    match prim_type {
        TessPrimitiveType::Triangles => &TRIANGLE,
        TessPrimitiveType::Quads => &QUAD,
        TessPrimitiveType::Isolines => &ISOLINES,
    }
}

/// `generateRandomPatchTessLevels`
fn generate_random_patch_tess_levels(
    num_patches: usize,
    constant_outer_level_index: usize,
    constant_outer_level: f32,
    rnd: &mut Random,
) -> Vec<f32> {
    let mut tess_levels = vec![0.0f32; num_patches * 6];

    for patch_ndx in 0..num_patches {
        for j in 0..2 {
            tess_levels[patch_ndx * 6 + j] = rnd.get_float_range(1.0, 62.0);
        }
        for j in 0..4 {
            tess_levels[patch_ndx * 6 + 2 + j] = if j == constant_outer_level_index {
                constant_outer_level
            } else {
                rnd.get_float_range(1.0, 62.0)
            };
        }
    }

    tess_levels
}

/// `multiplePatchReferenceVertexCount`
fn multiple_patch_reference_vertex_count(
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    use_point_mode: bool,
    levels: &[f32],
    num_patches: usize,
) -> i32 {
    (0..num_patches)
        .map(|patch_ndx| {
            let inner = [levels[6 * patch_ndx], levels[6 * patch_ndx + 1]];
            let outer = [
                levels[6 * patch_ndx + 2],
                levels[6 * patch_ndx + 3],
                levels[6 * patch_ndx + 4],
                levels[6 * patch_ndx + 5],
            ];
            reference_vertex_count(primitive_type, spacing_mode, use_point_mode, &inner, &outer)
        })
        .sum()
}

/// `VecLexLessThan<3>` - the strict lexicographic order `std::set<Vec3, ...>` uses.
fn vec3_lex_less_than(a: &Vec3, b: &Vec3) -> std::cmp::Ordering {
    for i in 0..3 {
        match a.m_data[i].partial_cmp(&b.m_data[i]) {
            Some(std::cmp::Ordering::Equal) | None => {}
            Some(other) => return other,
        }
    }
    std::cmp::Ordering::Equal
}

/// `std::set<Vec3, VecLexLessThan<3>>::insert`, on a vector kept in that order.
fn insert_vec3_set(set: &mut Vec<Vec3>, value: Vec3) {
    match set.binary_search_by(|probe| vec3_lex_less_than(probe, &value)) {
        Ok(_) => {}
        Err(pos) => set.insert(pos, value),
    }
}

/// `containerStr(vertices, 5, indent)` for a set of `Vec3`.
fn vec3_container_str(values: &[Vec3], wrap_length: usize, num_indentation_spaces: usize) -> String {
    let base_indentation = " ".repeat(num_indentation_spaces);
    let mut result = String::from("{");
    let mut length = 0;

    for (index, value) in values.iter().enumerate() {
        let element = format!("{}{}", if index > 0 { "," } else { "" }, vec_to_string(&value.m_data));
        length += element.len();
        result.push_str(&element);
        result.push_str(if length > wrap_length { "\n" } else { " " });
        if length > wrap_length {
            result.push_str(&base_indentation);
            length = 0;
        }
    }

    result.push('}');
    result
}

/// `InvariantOuterEdgeCase::RENDER_SIZE`
const OUTER_EDGE_RENDER_SIZE: i32 = 16;

/// `InvariantOuterEdgeCase::init`'s program build, for one (winding, point mode) pair.
fn outer_edge_program<'gl>(
    context: &'gl Context,
    primitive_type: TessPrimitiveType,
    spacing: SpacingMode,
    winding: Winding,
    use_point_mode: bool,
    program_ndx: i32,
) -> ShaderProgram<'gl> {
    let float_lit01 = float_to_string_2(10.0 / (program_ndx as f32 + 10.0));

    const VERTEX_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         ${GLSL_PER_VERTEX_OUT}\n\
         \n\
         in highp float in_v_attr;\n\
         out highp float in_tc_attr;\n\
         \n\
         void main (void)\n\
         {\n\
         \tin_tc_attr = in_v_attr;\n\
         }\n";

    let tess_control_template = format!(
        "${{GLSL_VERSION_DECL}}\n\
         ${{TESSELLATION_SHADER_REQUIRE}}\n\
         ${{GLSL_PER_VERTEX_IN_ARR}}\n\
         ${{GLSL_PER_VERTEX_OUT_ARR}}\n\
         \n\
         layout (vertices = {}) out;\n\
         \n\
         in highp float in_tc_attr[];\n\
         \n\
         void main (void)\n\
         {{\n\
         \tgl_TessLevelInner[0] = in_tc_attr[0];\n\
         \tgl_TessLevelInner[1] = in_tc_attr[1];\n\
         \n\
         \tgl_TessLevelOuter[0] = in_tc_attr[2];\n\
         \tgl_TessLevelOuter[1] = in_tc_attr[3];\n\
         \tgl_TessLevelOuter[2] = in_tc_attr[4];\n\
         \tgl_TessLevelOuter[3] = in_tc_attr[5];\n\
         }}\n",
        program_ndx + 1
    );

    let in_layout = format!(
        "layout ({}, {}, {}{}) in;\n",
        primitive_type.shader_name(),
        spacing.shader_name(),
        winding.shader_name(),
        if use_point_mode { ", point_mode" } else { "" }
    );

    let tess_eval_template = format!(
        "${{GLSL_VERSION_DECL}}\n\
         ${{TESSELLATION_SHADER_REQUIRE}}\n\
         ${{GLSL_PER_VERTEX_IN_ARR}}\n\
         ${{GLSL_PER_VERTEX_OUT}}\n\
         \n\
         {in_layout}\n\
         out highp vec4 in_f_color;\n\
         invariant out highp vec3 out_te_tessCoord;\n\
         \n\
         void main (void)\n\
         {{\n\
         \tgl_Position = vec4(gl_TessCoord.xy*{float_lit01} - {float_lit01}*0.5, 0.0, 1.0);\n\
         \tin_f_color = vec4({float_lit01});\n\
         \tout_te_tessCoord = gl_TessCoord;\n\
         }}\n"
    );

    const FRAGMENT_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         \n\
         layout (location = 0) out mediump vec4 o_color;\n\
         \n\
         in highp vec4 in_f_color;\n\
         \n\
         void main (void)\n\
         {\n\
         \to_color = in_f_color;\n\
         }\n";

    let sources = ProgramSources::default()
        .with(ShaderType::Vertex, specialize_shader(context, VERTEX_TEMPLATE))
        .with(
            ShaderType::TessControl,
            specialize_shader(context, &tess_control_template),
        )
        .with(
            ShaderType::TessEvaluation,
            specialize_shader(context, &tess_eval_template),
        )
        .with(ShaderType::Fragment, specialize_shader(context, FRAGMENT_TEMPLATE))
        .with_transform_feedback(&["out_te_tessCoord".to_string()], glw::GL_INTERLEAVED_ATTRIBS);

    ShaderProgram::new(context.gl(), &sources)
}

/// `InvariantOuterEdgeCase::init` + `::iterate`
fn invariant_outer_edge_case(
    case: &mut ApiCase<'_>,
    name: &str,
    primitive_type: TessPrimitiveType,
    spacing: SpacingMode,
) {
    if !check_tessellation_support(case) {
        return;
    }

    // `checkRenderTargetSize`
    let render_target = case.context().render_target();
    if render_target.width < OUTER_EDGE_RENDER_SIZE || render_target.height < OUTER_EDGE_RENDER_SIZE {
        case.not_supported(format!(
            "Render target width and height must be at least {OUTER_EDGE_RENDER_SIZE}"
        ));
        return;
    }

    let context = case.context();
    let gl = case.gl();

    // `m_programs`: one per (winding, point mode) pair, in upstream's loop order.
    let mut programs: Vec<(Winding, bool, ShaderProgram<'_>)> = Vec::new();
    for winding in [Winding::Ccw, Winding::Cw] {
        for use_point_mode in [false, true] {
            let program_ndx = i32::try_from(programs.len()).unwrap_or(0);
            let program = outer_edge_program(context, primitive_type, spacing, winding, use_point_mode, program_ndx);
            if !program.is_ok() {
                case.fail("Program compilation failed".to_string(), "Program compilation failed");
                return;
            }
            if program_ndx > 0 {
                log::info!(
                    "Note: program {program_ndx} is similar to above, except some constants are different, and: {}",
                    program_description(winding, use_point_mode)
                );
            }
            programs.push((winding, use_point_mode, program));
        }
    }

    const SINGLE_OUTER_EDGE_LEVELS: [f32; 12] = [1.0, 1.2, 1.9, 2.3, 2.8, 3.3, 3.8, 10.2, 1.6, 24.4, 24.7, 63.0];
    const NUM_PATCHES_PER_DRAW_CALL: usize = 10;
    let edge_descriptions = outer_edge_descriptions(primitive_type);

    // Compute the number vertices in the largest draw call, so we can allocate the TF buffer just once.
    let max_num_vertices_in_draw_call = {
        let mut rnd = Random::new(123);
        // outer-edge index doesn't affect vertex count
        let patch_tess_levels =
            generate_random_patch_tess_levels(NUM_PATCHES_PER_DRAW_CALL, 0, SINGLE_OUTER_EDGE_LEVELS[11], &mut rnd);
        [false, true]
            .into_iter()
            .map(|use_point_mode| {
                multiple_patch_reference_vertex_count(
                    primitive_type,
                    spacing,
                    use_point_mode,
                    &patch_tess_levels,
                    NUM_PATCHES_PER_DRAW_CALL,
                )
            })
            .max()
            .unwrap_or(0)
    };

    let handler = TransformFeedbackHandler::new(gl, 3, max_num_vertices_in_draw_call);

    // `RandomViewport(renderTarget, RENDER_SIZE, RENDER_SIZE, deStringHash(getName()))`
    let width = OUTER_EDGE_RENDER_SIZE.min(render_target.width);
    let height = OUTER_EDGE_RENDER_SIZE.min(render_target.height);
    let mut rnd = Random::new(de_string_hash(name));
    let vp_x = rnd.get_int(0, render_target.width - width);
    let vp_y = rnd.get_int(0, render_target.height - height);

    // SAFETY: plain state setters.
    unsafe {
        gl.viewport(vp_x, vp_y, width, height);
        gl.patch_parameteri(glw::GL_PATCH_VERTICES, 6);
    }

    for (outer_edge_index, edge_desc) in edge_descriptions.iter().enumerate() {
        for outer_edge_level in SINGLE_OUTER_EDGE_LEVELS {
            let mut level_rnd = Random::new(123);
            let patch_tess_levels = generate_random_patch_tess_levels(
                NUM_PATCHES_PER_DRAW_CALL,
                outer_edge_index,
                outer_edge_level,
                &mut level_rnd,
            );
            let bindings = [glu::va::float(
                "in_v_attr",
                1,
                i32::try_from(patch_tess_levels.len()).unwrap_or(i32::MAX),
                0,
                &patch_tess_levels,
            )];
            // Vertices of the outer edge of the first patch of the first program's draw
            // call; used for comparison with other patches.
            let mut first_outer_edge_vertices: Vec<Vec3> = Vec::new();

            log::info!(
                "Testing with outer tessellation level {} for the {} edge, and with various levels for other edges, and with all programs",
                to_string_f32(outer_edge_level),
                edge_desc.description()
            );

            for (program_ndx, (winding, use_point_mode, program)) in programs.iter().enumerate() {
                let program_gl = program.program();
                // SAFETY: a program that linked.
                unsafe { gl.use_program(program_gl) };

                let tf_result = match handler.render_and_get_primitives(
                    context,
                    program_gl,
                    output_primitive_type_gl(primitive_type, *use_point_mode),
                    &bindings,
                    i32::try_from(patch_tess_levels.len()).unwrap_or(i32::MAX),
                ) {
                    Ok(result) => result,
                    Err(e) => {
                        case.fail(e.to_string(), "Invalid set of vertices");
                        return;
                    }
                };

                let (lanes, _) = tf_result.varying.as_chunks::<3>();
                let vertices: Vec<Vec3> = lanes.iter().copied().map(Vec3::from_array).collect();
                let ref_num_vertices = multiple_patch_reference_vertex_count(
                    primitive_type,
                    spacing,
                    *use_point_mode,
                    &patch_tess_levels,
                    NUM_PATCHES_PER_DRAW_CALL,
                );
                let mut num_vertices_read = 0usize;

                if vertices.len() as i32 != ref_num_vertices {
                    log::warn!(
                        "Failure: the number of vertices returned by transform feedback is {}, expected {ref_num_vertices}",
                        vertices.len()
                    );
                    log::warn!(
                        "Note: rendered {NUM_PATCHES_PER_DRAW_CALL} patches in one draw call; tessellation levels for each patch are (in order [inner0, inner1, outer0, outer1, outer2, outer3]):\n{}",
                        float_container_str(&patch_tess_levels, 6)
                    );
                    case.fail("wrong number of vertices".to_string(), "Invalid set of vertices");
                    return;
                }

                // Check the vertices of each patch.
                for patch_ndx in 0..NUM_PATCHES_PER_DRAW_CALL {
                    let inner_levels = [patch_tess_levels[6 * patch_ndx], patch_tess_levels[6 * patch_ndx + 1]];
                    let outer_levels = [
                        patch_tess_levels[6 * patch_ndx + 2],
                        patch_tess_levels[6 * patch_ndx + 3],
                        patch_tess_levels[6 * patch_ndx + 4],
                        patch_tess_levels[6 * patch_ndx + 5],
                    ];
                    let patch_num_vertices =
                        reference_vertex_count(primitive_type, spacing, *use_point_mode, &inner_levels, &outer_levels)
                            as usize;
                    let mut outer_edge_vertices: Vec<Vec3> = Vec::new();

                    // We're interested in just the vertices on the current outer edge.
                    for vtx in &vertices[num_vertices_read..num_vertices_read + patch_num_vertices] {
                        if edge_desc.contains(*vtx) {
                            insert_vec3_set(&mut outer_edge_vertices, *vtx);
                        }
                    }

                    // Check that the outer edge contains an appropriate number of vertices.
                    let ref_num_vertices_on_outer_edge = 1 + get_clamped_rounded_tess_level(spacing, outer_edge_level);
                    if outer_edge_vertices.len() as i32 != ref_num_vertices_on_outer_edge {
                        log::warn!(
                            "Failure: the number of vertices on outer edge is {}, expected {ref_num_vertices_on_outer_edge}",
                            outer_edge_vertices.len()
                        );
                        log::warn!(
                            "Note: vertices on the outer edge are:\n{}",
                            vec3_container_str(&outer_edge_vertices, 5, 0)
                        );
                        log::warn!(
                            "Note: the following parameters were used: {}, tessellation levels: {}",
                            program_description(*winding, *use_point_mode),
                            tessellation_levels_string_all(&inner_levels, &outer_levels)
                        );
                        case.fail(
                            "wrong number of vertices on the outer edge".to_string(),
                            "Invalid set of vertices",
                        );
                        return;
                    }

                    // Compare the vertices to those of the first patch (unless this is the first patch).
                    if program_ndx == 0 && patch_ndx == 0 {
                        first_outer_edge_vertices = outer_edge_vertices;
                    } else if first_outer_edge_vertices != outer_edge_vertices {
                        log::warn!(
                            "Failure: vertices generated for the edge differ between the following cases:\n\
                             \x20 - case A: {}, tessellation levels: {}\n\
                             \x20 - case B: {}, tessellation levels: {}",
                            program_description(programs[0].0, programs[0].1),
                            tessellation_levels_string_all(&patch_tess_levels[0..2], &patch_tess_levels[2..6]),
                            program_description(*winding, *use_point_mode),
                            tessellation_levels_string_all(&inner_levels, &outer_levels)
                        );
                        log::warn!(
                            "Note: resulting vertices for the edge for the cases were:\n  - case A: {}\n  - case B: {}",
                            vec3_container_str(&first_outer_edge_vertices, 5, 14),
                            vec3_container_str(&outer_edge_vertices, 5, 14)
                        );
                        case.fail(
                            "edge vertices differ between cases".to_string(),
                            "Invalid set of vertices",
                        );
                        return;
                    }

                    num_vertices_read += patch_num_vertices;
                }
            }
        }
    }
}

/// `InvariantOuterEdgeCase::Program::description`
fn program_description(winding: Winding, use_point_mode: bool) -> String {
    format!(
        "winding mode {}, {}use point mode",
        winding.shader_name(),
        if use_point_mode { "" } else { "don't " }
    )
}

/// `containerStr(patchTessLevels, 6)` for a slice of floats.
fn float_container_str(values: &[f32], wrap_length: usize) -> String {
    let mut result = String::from("{");
    let mut length = 0;

    for (index, value) in values.iter().enumerate() {
        let element = format!("{}{}", if index > 0 { "," } else { "" }, to_string_f32(*value));
        length += element.len();
        result.push_str(&element);
        if length > wrap_length {
            result.push('\n');
            length = 0;
        } else {
            result.push(' ');
        }
    }

    result.push('}');
    result
}

/// `TessellationTests::init`'s `.invariance.outer_edge_division` sub-group.
fn invariant_outer_edge_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("outer_edge_division");

    for primitive_type in [TessPrimitiveType::Triangles, TessPrimitiveType::Quads] {
        for spacing in [
            SpacingMode::Equal,
            SpacingMode::FractionalOdd,
            SpacingMode::FractionalEven,
        ] {
            let name = format!("{}_{}", primitive_type.shader_name(), spacing.shader_name());
            let case_name = name.clone();
            add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
                invariant_outer_edge_case(case, &case_name, primitive_type, spacing);
            });
        }
    }

    group
}

/// `compareTriangleSets`, the `ConstantUnaryPredicate<..., true>` instantiation.
fn compare_triangle_sets(coords_a: &[Vec3], coords_b: &[Vec3]) -> bool {
    compare_triangle_sets_filtered(coords_a, coords_b, |_| true, None)
}

/// `compareTriangleSets`
///
/// Compare triangle sets, ignoring triangle order and vertex order within triangle, and
/// possibly exclude some triangles too. `is_triangle_relevant` sees each triangle with its
/// vertices in the order the driver emitted them, before the sort - upstream applies the
/// predicate first for the same reason: `IsQuadTriangleOnOuterEdge` walks the vertices as a
/// cycle, which sorting would destroy.
fn compare_triangle_sets_filtered(
    coords_a: &[Vec3],
    coords_b: &[Vec3],
    is_triangle_relevant: impl Fn(&[Vec3; 3]) -> bool,
    ignored_triangle_description: Option<&str>,
) -> bool {
    debug_assert!(coords_a.len().is_multiple_of(3) && coords_b.len().is_multiple_of(3));

    // `std::set<Triangle, LexCompare<Triangle, 3, VecLexLessThan<3>>>`
    let to_triangle_set = |coords: &[Vec3]| -> Vec<[Vec3; 3]> {
        let mut triangles: Vec<[Vec3; 3]> = Vec::new();
        let (tris, _) = coords.as_chunks::<3>();
        for tri in tris {
            if !is_triangle_relevant(tri) {
                continue;
            }
            let mut triangle = *tri;
            triangle.sort_by(vec3_lex_less_than);
            match triangles.binary_search_by(|probe| triangle_lex_less_than(probe, &triangle)) {
                Ok(_) => {}
                Err(pos) => triangles.insert(pos, triangle),
            }
        }
        triangles
    };

    let triangles_a = to_triangle_set(coords_a);
    let triangles_b = to_triangle_set(coords_b);

    for index in 0..triangles_a.len().max(triangles_b.len()) {
        let a = triangles_a.get(index);
        let b = triangles_b.get(index);

        if a != b {
            let ignored = match ignored_triangle_description {
                Some(description) => format!(", and {description}"),
                None => String::new(),
            };
            log::warn!(
                "Failure: triangle sets in two cases are not equal (when ignoring triangle and vertex order{ignored})"
            );

            let a_first = match (a, b) {
                (Some(a), Some(b)) => triangle_lex_less_than(a, b) == std::cmp::Ordering::Less,
                (Some(_), None) => true,
                _ => false,
            };
            if a_first {
                log::warn!(
                    "Note: e.g. triangle {} exists for first case but not for second",
                    triangle_to_string(a.expect("a is present"))
                );
            } else {
                log::warn!(
                    "Note: e.g. triangle {} exists for second case but not for first",
                    triangle_to_string(b.expect("b is present"))
                );
            }

            return false;
        }
    }

    true
}

/// `LexCompare<Triangle, 3, VecLexLessThan<3>>`
fn triangle_lex_less_than(a: &[Vec3; 3], b: &[Vec3; 3]) -> std::cmp::Ordering {
    for i in 0..3 {
        match vec3_lex_less_than(&a[i], &b[i]) {
            std::cmp::Ordering::Equal => {}
            other => return other,
        }
    }
    std::cmp::Ordering::Equal
}

/// `tcu::operator<<(ostream, Vector<Vec3, 3>)`
fn triangle_to_string(triangle: &[Vec3; 3]) -> String {
    format!(
        "({})",
        triangle
            .iter()
            .map(|v| vec_to_string(&v.m_data))
            .collect::<Vec<_>>()
            .join(", ")
    )
}

/// The constructor arguments the three triangle-set subclasses share: point mode off and
/// winding varying, since all three assert that winding does not change the triangle set.
fn triangle_set_spec(primitive_type: TessPrimitiveType, spacing: SpacingMode) -> PrimitiveSetInvarianceSpec {
    PrimitiveSetInvarianceSpec {
        primitive_type,
        spacing,
        use_point_mode: false,
        winding_usage: WindingUsage::Vary,
    }
}

/// `InvariantInnerTriangleSetCase::IsInnerTriangleTriangle`
///
/// A triangle none of whose vertices lies on a barycentric axis, i.e. one of the inner ring.
fn is_inner_triangle_triangle(vertices: &[Vec3; 3]) -> bool {
    !vertices.iter().any(|vertex| vertex.m_data.contains(&0.0))
}

/// `InvariantInnerTriangleSetCase::IsInnerQuadTriangle`
///
/// The quad equivalent: only u and v are meaningful, and both bounds are outer edges.
fn is_inner_quad_triangle(vertices: &[Vec3; 3]) -> bool {
    !vertices.iter().any(|vertex| {
        vertex.m_data[..2]
            .iter()
            .any(|&component| component == 0.0 || component == 1.0)
    })
}

/// `InvariantOuterTriangleSetCase::IsTriangleTriangleOnOuterEdge`
fn is_triangle_triangle_on_outer_edge(vertices: &[Vec3; 3], edge_ndx: usize) -> bool {
    if !vertices.iter().any(|vertex| vertex.m_data[edge_ndx] == 0.0) {
        return false;
    }

    // The centroid decides which edge an outer triangle belongs to: one touching vertex is
    // not enough, since a triangle can touch two edges at a corner.
    let mut avg = [0.0f32; 3];
    for (component, value) in avg.iter_mut().enumerate() {
        *value = (vertices[0].m_data[component] + vertices[1].m_data[component] + vertices[2].m_data[component]) / 3.0;
    }

    avg[edge_ndx] < avg[(edge_ndx + 1) % 3] && avg[edge_ndx] < avg[(edge_ndx + 2) % 3]
}

/// `InvariantOuterTriangleSetCase::IsQuadTriangleOnOuterEdge`
fn is_quad_triangle_on_outer_edge(vertices: &[Vec3; 3], edge_ndx: usize) -> bool {
    // `onEdge`
    let on_edge = |vertex: &Vec3| vertex.m_data[edge_ndx % 2] == if edge_ndx <= 1 { 0.0 } else { 1.0 };
    // `onAnyEdge`
    let on_any_edge = |vertex: &Vec3| {
        let d = vertex.m_data;
        d[0] == 0.0 || d[0] == 1.0 || d[1] == 0.0 || d[1] == 1.0
    };

    for v in 0..3 {
        let a = &vertices[v];
        let b = &vertices[(v + 1) % 3];
        let c = &vertices[(v + 2) % 3];

        if on_edge(a) && on_edge(b) {
            return true;
        }
        // A triangle with only its opposite vertex on the edge still belongs to it when the
        // other two are interior and share the edge's coordinate.
        if on_edge(c) && !on_any_edge(a) && !on_any_edge(b) && a.m_data[edge_ndx % 2] == b.m_data[edge_ndx % 2] {
            return true;
        }
    }

    false
}

/// `TessellationTests::init`'s `.invariance.inner_triangle_set` sub-group.
///
/// `InvariantInnerTriangleSetCase` - invariance rule #6: the set of *inner* triangles
/// depends only on the inner levels, the primitive type and the spacing, so the outer
/// levels are varied across the four sub-cases and the outer triangles are excluded.
fn invariant_inner_triangle_set_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("inner_triangle_set");

    for primitive_type in [TessPrimitiveType::Triangles, TessPrimitiveType::Quads] {
        for spacing in [
            SpacingMode::Equal,
            SpacingMode::FractionalOdd,
            SpacingMode::FractionalEven,
        ] {
            let name = format!("{}_{}", primitive_type.shader_name(), spacing.shader_name());
            let case_name = name.clone();
            add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
                let compare = |coords_a: &[Vec3], coords_b: &[Vec3], _mem: i32| {
                    let relevant: fn(&[Vec3; 3]) -> bool = match primitive_type {
                        TessPrimitiveType::Triangles => is_inner_triangle_triangle,
                        TessPrimitiveType::Quads => is_inner_quad_triangle,
                        TessPrimitiveType::Isolines => {
                            unreachable!("inner_triangle_set registers triangles and quads only")
                        }
                    };
                    compare_triangle_sets_filtered(coords_a, coords_b, relevant, Some("outer triangles"))
                };
                let spec = triangle_set_spec(primitive_type, spacing);
                primitive_set_invariance_case(
                    case,
                    &case_name,
                    spec,
                    &|| gen_inner_triangle_set_tess_level_cases(primitive_type),
                    &compare,
                );
            });
        }
    }

    group
}

/// `TessellationTests::init`'s `.invariance.outer_triangle_set` sub-group.
///
/// `InvariantOuterTriangleSetCase` - invariance rule #7: the triangles along one outer edge
/// depend only on that edge's own outer level (plus the inner levels), so every *other*
/// outer level is varied and every triangle not on the edge under test is excluded.
fn invariant_outer_triangle_set_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("outer_triangle_set");

    for primitive_type in [TessPrimitiveType::Triangles, TessPrimitiveType::Quads] {
        for spacing in [
            SpacingMode::Equal,
            SpacingMode::FractionalOdd,
            SpacingMode::FractionalEven,
        ] {
            let name = format!("{}_{}", primitive_type.shader_name(), spacing.shader_name());
            let case_name = name.clone();
            add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
                let compare = |coords_a: &[Vec3], coords_b: &[Vec3], mem: i32| {
                    let edge_ndx = usize::try_from(mem).unwrap_or(0);
                    let description = format!(
                        "inner triangles, and outer triangles corresponding to other edge than edge {}",
                        outer_edge_descriptions(primitive_type)[edge_ndx].description()
                    );
                    match primitive_type {
                        TessPrimitiveType::Triangles => compare_triangle_sets_filtered(
                            coords_a,
                            coords_b,
                            |tri| is_triangle_triangle_on_outer_edge(tri, edge_ndx),
                            Some(&description),
                        ),
                        TessPrimitiveType::Quads => compare_triangle_sets_filtered(
                            coords_a,
                            coords_b,
                            |tri| is_quad_triangle_on_outer_edge(tri, edge_ndx),
                            Some(&description),
                        ),
                        TessPrimitiveType::Isolines => {
                            unreachable!("outer_triangle_set registers triangles and quads only")
                        }
                    }
                };
                let spec = triangle_set_spec(primitive_type, spacing);
                primitive_set_invariance_case(
                    case,
                    &case_name,
                    spec,
                    &|| gen_outer_triangle_set_tess_level_cases(primitive_type),
                    &compare,
                );
            });
        }
    }

    group
}

/// `TessellationTests::init`'s `.invariance.triangle_set` sub-group.
///
/// `InvariantTriangleSetCase` - winding varies, point mode is off, and the comparison
/// ignores triangle and vertex order.
fn invariant_triangle_set_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("triangle_set");

    for primitive_type in [TessPrimitiveType::Triangles, TessPrimitiveType::Quads] {
        for spacing in [
            SpacingMode::Equal,
            SpacingMode::FractionalOdd,
            SpacingMode::FractionalEven,
        ] {
            let name = format!("{}_{}", primitive_type.shader_name(), spacing.shader_name());
            let case_name = name.clone();
            add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
                let spec = triangle_set_spec(primitive_type, spacing);
                primitive_set_invariance_case(
                    case,
                    &case_name,
                    spec,
                    &gen_primitive_set_tess_level_cases,
                    &|a, b, _mem| compare_triangle_sets(a, b),
                );
            });
        }
    }

    group
}

// ---------------------------------------------------------------------------------------
// invariance.outer_edge_symmetry
// ---------------------------------------------------------------------------------------

/// `tcu::select(trueVal, falseVal, singleTrueMask<3>(index))`
fn single_true_select_vec3(true_val: f32, false_val: f32, index: usize) -> Vec3 {
    let mut result = [false_val; 3];
    result[index] = true_val;
    Vec3::from_array(result)
}

/// `SymmetricOuterEdgeCase::init`'s program.
fn symmetric_outer_edge_program<'gl>(
    context: &'gl Context,
    primitive_type: TessPrimitiveType,
    spacing: SpacingMode,
    winding: Winding,
    use_point_mode: bool,
) -> ShaderProgram<'gl> {
    const VERTEX_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         \n\
         ${GLSL_PER_VERTEX_OUT}\n\
         in highp float in_v_attr;\n\
         out highp float in_tc_attr;\n\
         \n\
         void main (void)\n\
         {\n\
         \tin_tc_attr = in_v_attr;\n\
         }\n";

    const TESS_CONTROL_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         ${TESSELLATION_SHADER_REQUIRE}\n\
         ${GLSL_PER_VERTEX_IN_ARR}\n\
         ${GLSL_PER_VERTEX_OUT_ARR}\n\
         \n\
         layout (vertices = 1) out;\n\
         \n\
         in highp float in_tc_attr[];\n\
         \n\
         void main (void)\n\
         {\n\
         \tgl_TessLevelInner[0] = in_tc_attr[0];\n\
         \tgl_TessLevelInner[1] = in_tc_attr[1];\n\
         \n\
         \tgl_TessLevelOuter[0] = in_tc_attr[2];\n\
         \tgl_TessLevelOuter[1] = in_tc_attr[3];\n\
         \tgl_TessLevelOuter[2] = in_tc_attr[4];\n\
         \tgl_TessLevelOuter[3] = in_tc_attr[5];\n\
         }\n";

    let mirror_body = match primitive_type {
        TessPrimitiveType::Triangles => {
            "    float x = gl_TessCoord.x;\n\
             \x20   float y = gl_TessCoord.y;\n\
             \x20   float z = gl_TessCoord.z;\n\
             \x20   // Mirror one half of each outer edge onto the other half, except the endpoints (because they belong to two edges)\n\
             \x20   out_te_tessCoord_isMirrored = z == 0.0 && x > 0.5 && x != 1.0 ? vec4(1.0-x,  1.0-y,    0.0, 1.0)\n\
             \x20                               : y == 0.0 && z > 0.5 && z != 1.0 ? vec4(1.0-x,    0.0,  1.0-z, 1.0)\n\
             \x20                               : x == 0.0 && y > 0.5 && y != 1.0 ? vec4(  0.0,  1.0-y,  1.0-z, 1.0)\n\
             \x20                               : vec4(x, y, z, 0.0);\n"
        }
        TessPrimitiveType::Quads => {
            "    float x = gl_TessCoord.x;\n\
             \x20   float y = gl_TessCoord.y;\n\
             \x20   // Mirror one half of each outer edge onto the other half, except the endpoints (because they belong to two edges)\n\
             \x20   out_te_tessCoord_isMirrored = (x == 0.0 || x == 1.0) && y > 0.5 && y != 1.0 ? vec4(    x, 1.0-y, 0.0, 1.0)\n\
             \x20                               : (y == 0.0 || y == 1.0) && x > 0.5 && x != 1.0 ? vec4(1.0-x,     y, 0.0, 1.0)\n\
             \x20                               : vec4(x, y, 0.0, 0.0);\n"
        }
        TessPrimitiveType::Isolines => {
            "    float x = gl_TessCoord.x;\n\
             \x20   float y = gl_TessCoord.y;\n\
             \x20   // Mirror one half of each outer edge onto the other half\n\
             \x20   out_te_tessCoord_isMirrored = (x == 0.0 || x == 1.0) && y > 0.5 ? vec4(x, 1.0-y, 0.0, 1.0)\n\
             \x20                               : vec4(x, y, 0.0, 0.0f);\n"
        }
    };

    let in_layout = format!(
        "layout ({}, {}, {}{}) in;\n",
        primitive_type.shader_name(),
        spacing.shader_name(),
        winding.shader_name(),
        if use_point_mode { ", point_mode" } else { "" }
    );

    let tess_eval_template = format!(
        "${{GLSL_VERSION_DECL}}\n\
         ${{TESSELLATION_SHADER_REQUIRE}}\n\
         ${{GLSL_PER_VERTEX_IN_ARR}}\n\
         ${{GLSL_PER_VERTEX_OUT}}\n\
         \n\
         {in_layout}\n\
         out highp vec4 in_f_color;\n\
         out highp vec4 out_te_tessCoord_isMirrored;\n\
         \n\
         void main (void)\n\
         {{\n\
         {mirror_body}\n\
         \x20   gl_Position = vec4(gl_TessCoord.xy, 0.0, 1.0);\n\
         \x20   in_f_color = vec4(1.0);\n\
         }}\n"
    );

    const FRAGMENT_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         \n\
         layout (location = 0) out mediump vec4 o_color;\n\
         \n\
         in highp vec4 in_f_color;\n\
         \n\
         void main (void)\n\
         {\n\
         \to_color = in_f_color;\n\
         }\n";

    let sources = ProgramSources::default()
        .with(ShaderType::Vertex, specialize_shader(context, VERTEX_TEMPLATE))
        .with(
            ShaderType::TessControl,
            specialize_shader(context, TESS_CONTROL_TEMPLATE),
        )
        .with(
            ShaderType::TessEvaluation,
            specialize_shader(context, &tess_eval_template),
        )
        .with(ShaderType::Fragment, specialize_shader(context, FRAGMENT_TEMPLATE))
        .with_transform_feedback(
            &["out_te_tessCoord_isMirrored".to_string()],
            glw::GL_INTERLEAVED_ATTRIBS,
        );

    ShaderProgram::new(context.gl(), &sources)
}

/// `SymmetricOuterEdgeCase::init` + `::iterate`
fn symmetric_outer_edge_case(
    case: &mut ApiCase<'_>,
    name: &str,
    primitive_type: TessPrimitiveType,
    spacing: SpacingMode,
    winding: Winding,
    use_point_mode: bool,
) {
    if !check_tessellation_support(case) {
        return;
    }

    // `checkRenderTargetSize`
    let render_target = case.context().render_target();
    if render_target.width < OUTER_EDGE_RENDER_SIZE || render_target.height < OUTER_EDGE_RENDER_SIZE {
        case.not_supported(format!(
            "Render target width and height must be at least {OUTER_EDGE_RENDER_SIZE}"
        ));
        return;
    }

    let context = case.context();
    let gl = case.gl();

    let program = symmetric_outer_edge_program(context, primitive_type, spacing, winding, use_point_mode);
    if !program.is_ok() {
        case.fail("Program compilation failed".to_string(), "Program compilation failed");
        return;
    }
    let program_gl = program.program();

    const SINGLE_OUTER_EDGE_LEVELS: [f32; 12] = [1.0, 1.2, 1.9, 2.3, 2.8, 3.3, 3.8, 10.2, 1.6, 24.4, 24.7, 63.0];
    let edge_descriptions = outer_edge_descriptions(primitive_type);

    // Compute the number vertices in the largest draw call, so we can allocate the TF buffer just once.
    let max_num_vertices_in_draw_call = {
        let mut rnd = Random::new(123);
        // outer-edge index doesn't affect vertex count
        let patch_tess_levels = generate_random_patch_tess_levels(1, 0, SINGLE_OUTER_EDGE_LEVELS[11], &mut rnd);
        reference_vertex_count(
            primitive_type,
            spacing,
            use_point_mode,
            &[patch_tess_levels[0], patch_tess_levels[1]],
            &[
                patch_tess_levels[2],
                patch_tess_levels[3],
                patch_tess_levels[4],
                patch_tess_levels[5],
            ],
        )
    };

    let handler = TransformFeedbackHandler::new(gl, 4, max_num_vertices_in_draw_call);

    // `RandomViewport(renderTarget, RENDER_SIZE, RENDER_SIZE, deStringHash(getName()))`
    let width = OUTER_EDGE_RENDER_SIZE.min(render_target.width);
    let height = OUTER_EDGE_RENDER_SIZE.min(render_target.height);
    let mut rnd = Random::new(de_string_hash(name));
    let vp_x = rnd.get_int(0, render_target.width - width);
    let vp_y = rnd.get_int(0, render_target.height - height);

    // SAFETY: plain state setters.
    unsafe {
        gl.viewport(vp_x, vp_y, width, height);
        gl.patch_parameteri(glw::GL_PATCH_VERTICES, 6);
    }

    for (outer_edge_index, edge_desc) in edge_descriptions.iter().enumerate() {
        for outer_edge_level in SINGLE_OUTER_EDGE_LEVELS {
            let mut level_rnd = Random::new(123);
            let patch_tess_levels =
                generate_random_patch_tess_levels(1, outer_edge_index, outer_edge_level, &mut level_rnd);
            let inner_levels = [patch_tess_levels[0], patch_tess_levels[1]];
            let outer_levels = [
                patch_tess_levels[2],
                patch_tess_levels[3],
                patch_tess_levels[4],
                patch_tess_levels[5],
            ];
            let bindings = [glu::va::float(
                "in_v_attr",
                1,
                i32::try_from(patch_tess_levels.len()).unwrap_or(i32::MAX),
                0,
                &patch_tess_levels,
            )];

            log::info!(
                "Testing with outer tessellation level {} for the {} edge, and with various levels for other edges",
                to_string_f32(outer_edge_level),
                edge_desc.description()
            );

            // SAFETY: a program that linked.
            unsafe { gl.use_program(program_gl) };

            let tf_result = match handler.render_and_get_primitives(
                context,
                program_gl,
                output_primitive_type_gl(primitive_type, use_point_mode),
                &bindings,
                i32::try_from(patch_tess_levels.len()).unwrap_or(i32::MAX),
            ) {
                Ok(result) => result,
                Err(e) => {
                    case.fail(e.to_string(), "Invalid set of vertices");
                    return;
                }
            };

            let (lanes, _) = tf_result.varying.as_chunks::<4>();
            let ref_num_vertices =
                reference_vertex_count(primitive_type, spacing, use_point_mode, &inner_levels, &outer_levels);

            if lanes.len() as i32 != ref_num_vertices {
                log::warn!(
                    "Failure: the number of vertices returned by transform feedback is {}, expected {ref_num_vertices}",
                    lanes.len()
                );
                log::warn!(
                    "Note: rendered 1 patch, tessellation levels are (in order [inner0, inner1, outer0, outer1, outer2, outer3]):\n{}",
                    float_container_str(&patch_tess_levels, 6)
                );
                case.fail("wrong number of vertices".to_string(), "Invalid set of vertices");
                return;
            }

            // Check the vertices.
            let mut non_mirrored_edge_vertices: Vec<Vec3> = Vec::new();
            let mut mirrored_edge_vertices: Vec<Vec3> = Vec::new();

            // We're interested in just the vertices on the current outer edge.
            for lane in &lanes[..ref_num_vertices as usize] {
                let vtx = Vec3::from_array([lane[0], lane[1], lane[2]]);
                if !edge_desc.contains(vtx) {
                    continue;
                }

                // Ignore the middle vertex of the outer edge, as it's exactly at the mirroring point;
                // for isolines, also ignore (0, 0) and (1, 0) because there's no mirrored counterpart for them.
                let is_ignored = match primitive_type {
                    TessPrimitiveType::Triangles => {
                        vtx == single_true_select_vec3(0.0, 0.5, edge_desc.constant_coordinate_index)
                    }
                    TessPrimitiveType::Quads => {
                        let middle = single_true_select_vec3(
                            edge_desc.constant_coordinate_value_choices[0],
                            0.5,
                            edge_desc.constant_coordinate_index,
                        );
                        vtx.m_data[0] == middle.m_data[0] && vtx.m_data[1] == middle.m_data[1]
                    }
                    TessPrimitiveType::Isolines => {
                        vtx == Vec3::from_array([0.0, 0.5, 0.0])
                            || vtx == Vec3::from_array([1.0, 0.5, 0.0])
                            || vtx == Vec3::from_array([0.0, 0.0, 0.0])
                            || vtx == Vec3::from_array([1.0, 0.0, 0.0])
                    }
                };
                if is_ignored {
                    continue;
                }

                let is_mirrored = lane[3] > 0.5;
                if is_mirrored {
                    insert_vec3_set(&mut mirrored_edge_vertices, vtx);
                } else {
                    insert_vec3_set(&mut non_mirrored_edge_vertices, vtx);
                }
            }

            if primitive_type != TessPrimitiveType::Isolines {
                // Check that both endpoints are present. Note that endpoints aren't mirrored by the shader, since they belong to more than one edge.
                let (endpoint_a, endpoint_b) = match primitive_type {
                    TessPrimitiveType::Triangles => (
                        single_true_select_vec3(1.0, 0.0, (edge_desc.constant_coordinate_index + 1) % 3),
                        single_true_select_vec3(1.0, 0.0, (edge_desc.constant_coordinate_index + 2) % 3),
                    ),
                    // Upstream assigns only `.xy()` of a default-constructed `Vec3`, so z is 0.
                    _ => {
                        let choice = edge_desc.constant_coordinate_value_choices[0];
                        let a = single_true_select_vec3(choice, 0.0, edge_desc.constant_coordinate_index);
                        let b = single_true_select_vec3(choice, 1.0, edge_desc.constant_coordinate_index);
                        (
                            Vec3::from_array([a.m_data[0], a.m_data[1], 0.0]),
                            Vec3::from_array([b.m_data[0], b.m_data[1], 0.0]),
                        )
                    }
                };

                if !non_mirrored_edge_vertices.contains(&endpoint_a)
                    || !non_mirrored_edge_vertices.contains(&endpoint_b)
                {
                    log::warn!(
                        "Failure: edge doesn't contain both endpoints, {} and {}",
                        vec_to_string(&endpoint_a.m_data),
                        vec_to_string(&endpoint_b.m_data)
                    );
                    log::warn!(
                        "Note: non-mirrored vertices:\n{}\nmirrored vertices:\n{}",
                        vec3_container_str(&non_mirrored_edge_vertices, 5, 0),
                        vec3_container_str(&mirrored_edge_vertices, 5, 0)
                    );
                    case.fail("edge is missing an endpoint".to_string(), "Invalid set of vertices");
                    return;
                }
                non_mirrored_edge_vertices.retain(|v| *v != endpoint_a && *v != endpoint_b);
            }

            if non_mirrored_edge_vertices != mirrored_edge_vertices {
                log::warn!(
                    "Failure: the set of mirrored edges isn't equal to the set of non-mirrored edges (ignoring endpoints and possible middle)"
                );
                log::warn!(
                    "Note: non-mirrored vertices:\n{}\nmirrored vertices:\n{}",
                    vec3_container_str(&non_mirrored_edge_vertices, 5, 0),
                    vec3_container_str(&mirrored_edge_vertices, 5, 0)
                );
                case.fail(
                    "mirrored and non-mirrored vertex sets differ".to_string(),
                    "Invalid set of vertices",
                );
                return;
            }
        }
    }
}

/// `TessellationTests::init`'s `.invariance.outer_edge_symmetry` sub-group.
fn symmetric_outer_edge_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("outer_edge_symmetry");

    for primitive_type in [
        TessPrimitiveType::Triangles,
        TessPrimitiveType::Quads,
        TessPrimitiveType::Isolines,
    ] {
        for spacing in [
            SpacingMode::Equal,
            SpacingMode::FractionalOdd,
            SpacingMode::FractionalEven,
        ] {
            for winding in [Winding::Ccw, Winding::Cw] {
                for use_point_mode in [false, true] {
                    let name = format!(
                        "{}_{}_{}{}",
                        primitive_type.shader_name(),
                        spacing.shader_name(),
                        winding.shader_name(),
                        if use_point_mode { "_point_mode" } else { "" }
                    );
                    let case_name = name.clone();
                    add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
                        symmetric_outer_edge_case(case, &case_name, primitive_type, spacing, winding, use_point_mode);
                    });
                }
            }
        }
    }

    group
}

// ---------------------------------------------------------------------------------------
// invariance.outer_edge_index_independence
// ---------------------------------------------------------------------------------------

/// `OuterEdgeVertexSetIndexIndependenceCase::init`'s program.
///
/// It is `SymmetricOuterEdgeCase`'s program without the mirroring: the TES feeds back
/// `gl_TessCoord` itself.
fn outer_edge_index_independence_program<'gl>(
    context: &'gl Context,
    primitive_type: TessPrimitiveType,
    spacing: SpacingMode,
    winding: Winding,
    use_point_mode: bool,
) -> ShaderProgram<'gl> {
    const VERTEX_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         ${GLSL_PER_VERTEX_OUT}\n\
         \n\
         in highp float in_v_attr;\n\
         out highp float in_tc_attr;\n\
         \n\
         void main (void)\n\
         {\n\
         \tin_tc_attr = in_v_attr;\n\
         }\n";

    const TESS_CONTROL_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         ${TESSELLATION_SHADER_REQUIRE}\n\
         ${GLSL_PER_VERTEX_IN_ARR}\n\
         ${GLSL_PER_VERTEX_OUT_ARR}\n\
         \n\
         layout (vertices = 1) out;\n\
         \n\
         in highp float in_tc_attr[];\n\
         \n\
         void main (void)\n\
         {\n\
         \tgl_TessLevelInner[0] = in_tc_attr[0];\n\
         \tgl_TessLevelInner[1] = in_tc_attr[1];\n\
         \n\
         \tgl_TessLevelOuter[0] = in_tc_attr[2];\n\
         \tgl_TessLevelOuter[1] = in_tc_attr[3];\n\
         \tgl_TessLevelOuter[2] = in_tc_attr[4];\n\
         \tgl_TessLevelOuter[3] = in_tc_attr[5];\n\
         }\n";

    let in_layout = format!(
        "layout ({}, {}, {}{}) in;\n",
        primitive_type.shader_name(),
        spacing.shader_name(),
        winding.shader_name(),
        if use_point_mode { ", point_mode" } else { "" }
    );

    // Upstream's `out_te_tessCoord = gl_TessCoord;` has no trailing newline, so the
    // `gl_Position` assignment shares its line. Kept, since the driver's compiler sees
    // exactly what upstream's does.
    let tess_eval_template = format!(
        "${{GLSL_VERSION_DECL}}\n\
         ${{TESSELLATION_SHADER_REQUIRE}}\n\
         ${{GLSL_PER_VERTEX_IN_ARR}}\n\
         ${{GLSL_PER_VERTEX_OUT}}\n\
         \n\
         {in_layout}\n\
         out highp vec4 in_f_color;\n\
         out highp vec3 out_te_tessCoord;\n\
         \n\
         void main (void)\n\
         {{\n\
         \x20   out_te_tessCoord = gl_TessCoord;\x20   gl_Position = vec4(gl_TessCoord.xy, 0.0, 1.0);\n\
         \x20   in_f_color = vec4(1.0);\n\
         }}\n"
    );

    const FRAGMENT_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         \n\
         layout (location = 0) out mediump vec4 o_color;\n\
         \n\
         in highp vec4 in_f_color;\n\
         \n\
         void main (void)\n\
         {\n\
         \to_color = in_f_color;\n\
         }\n";

    let sources = ProgramSources::default()
        .with(ShaderType::Vertex, specialize_shader(context, VERTEX_TEMPLATE))
        .with(
            ShaderType::TessControl,
            specialize_shader(context, TESS_CONTROL_TEMPLATE),
        )
        .with(
            ShaderType::TessEvaluation,
            specialize_shader(context, &tess_eval_template),
        )
        .with(ShaderType::Fragment, specialize_shader(context, FRAGMENT_TEMPLATE))
        .with_transform_feedback(&["out_te_tessCoord".to_string()], glw::GL_INTERLEAVED_ATTRIBS);

    ShaderProgram::new(context.gl(), &sources)
}

/// `OuterEdgeVertexSetIndexIndependenceCase::init` + `::iterate`
fn outer_edge_index_independence_case(
    case: &mut ApiCase<'_>,
    name: &str,
    primitive_type: TessPrimitiveType,
    spacing: SpacingMode,
    winding: Winding,
    use_point_mode: bool,
) {
    if !check_tessellation_support(case) {
        return;
    }

    // `checkRenderTargetSize`
    let render_target = case.context().render_target();
    if render_target.width < OUTER_EDGE_RENDER_SIZE || render_target.height < OUTER_EDGE_RENDER_SIZE {
        case.not_supported(format!(
            "Render target width and height must be at least {OUTER_EDGE_RENDER_SIZE}"
        ));
        return;
    }

    let context = case.context();
    let gl = case.gl();

    let program = outer_edge_index_independence_program(context, primitive_type, spacing, winding, use_point_mode);
    if !program.is_ok() {
        case.fail("Program compilation failed".to_string(), "Program compilation failed");
        return;
    }
    let program_gl = program.program();

    const SINGLE_OUTER_EDGE_LEVELS: [f32; 12] = [1.0, 1.2, 1.9, 2.3, 2.8, 3.3, 3.8, 10.2, 1.6, 24.4, 24.7, 63.0];
    let edge_descriptions = outer_edge_descriptions(primitive_type);

    // `RandomViewport(renderTarget, RENDER_SIZE, RENDER_SIZE, deStringHash(getName()))`
    let width = OUTER_EDGE_RENDER_SIZE.min(render_target.width);
    let height = OUTER_EDGE_RENDER_SIZE.min(render_target.height);
    let mut rnd = Random::new(de_string_hash(name));
    let vp_x = rnd.get_int(0, render_target.width - width);
    let vp_y = rnd.get_int(0, render_target.height - height);

    // SAFETY: a program that linked, then plain state setters.
    unsafe {
        gl.use_program(program_gl);
        gl.viewport(vp_x, vp_y, width, height);
        gl.patch_parameteri(glw::GL_PATCH_VERTICES, 6);
    }

    // Compute the number vertices in the largest draw call, so we can allocate the TF buffer just once.
    let max_num_vertices_in_draw_call = {
        let mut rnd = Random::new(123);
        // outer-edge index doesn't affect vertex count
        let patch_tess_levels = generate_random_patch_tess_levels(1, 0, SINGLE_OUTER_EDGE_LEVELS[11], &mut rnd);
        reference_vertex_count(
            primitive_type,
            spacing,
            use_point_mode,
            &[patch_tess_levels[0], patch_tess_levels[1]],
            &[
                patch_tess_levels[2],
                patch_tess_levels[3],
                patch_tess_levels[4],
                patch_tess_levels[5],
            ],
        )
    };

    let handler = TransformFeedbackHandler::new(gl, 3, max_num_vertices_in_draw_call);

    for outer_edge_level in SINGLE_OUTER_EDGE_LEVELS {
        let mut first_edge_vertices: Vec<Vec3> = Vec::new();

        for (outer_edge_index, edge_desc) in edge_descriptions.iter().enumerate() {
            let mut level_rnd = Random::new(123);
            let patch_tess_levels =
                generate_random_patch_tess_levels(1, outer_edge_index, outer_edge_level, &mut level_rnd);
            let bindings = [glu::va::float(
                "in_v_attr",
                1,
                i32::try_from(patch_tess_levels.len()).unwrap_or(i32::MAX),
                0,
                &patch_tess_levels,
            )];

            log::info!(
                "Testing with outer tessellation level {} for the {} edge, and with various levels for other edges",
                to_string_f32(outer_edge_level),
                edge_desc.description()
            );

            let tf_result = match handler.render_and_get_primitives(
                context,
                program_gl,
                output_primitive_type_gl(primitive_type, use_point_mode),
                &bindings,
                i32::try_from(patch_tess_levels.len()).unwrap_or(i32::MAX),
            ) {
                Ok(result) => result,
                Err(e) => {
                    case.fail(e.to_string(), "Invalid set of vertices");
                    return;
                }
            };

            let (lanes, _) = tf_result.varying.as_chunks::<3>();
            let ref_num_vertices = reference_vertex_count(
                primitive_type,
                spacing,
                use_point_mode,
                &[patch_tess_levels[0], patch_tess_levels[1]],
                &[
                    patch_tess_levels[2],
                    patch_tess_levels[3],
                    patch_tess_levels[4],
                    patch_tess_levels[5],
                ],
            );

            if lanes.len() as i32 != ref_num_vertices {
                log::warn!(
                    "Failure: the number of vertices returned by transform feedback is {}, expected {ref_num_vertices}",
                    lanes.len()
                );
                log::warn!(
                    "Note: rendered 1 patch, tessellation levels are (in order [inner0, inner1, outer0, outer1, outer2, outer3]):\n{}",
                    float_container_str(&patch_tess_levels, 6)
                );
                case.fail("wrong number of vertices".to_string(), "Invalid set of vertices");
                return;
            }

            // Get the vertices on the current outer edge.
            let mut current_edge_vertices: Vec<Vec3> = Vec::new();
            for lane in &lanes[..ref_num_vertices as usize] {
                let vtx = Vec3::from_array(*lane);
                if !edge_desc.contains(vtx) {
                    continue;
                }

                // Swizzle components to match the order of the first edge.
                let swizzled = match (primitive_type, outer_edge_index) {
                    (TessPrimitiveType::Triangles, 0) => vtx,
                    (TessPrimitiveType::Triangles, 1) => {
                        Vec3::from_array([vtx.m_data[1], vtx.m_data[0], vtx.m_data[2]])
                    }
                    (TessPrimitiveType::Triangles, 2) => {
                        Vec3::from_array([vtx.m_data[2], vtx.m_data[1], vtx.m_data[0]])
                    }
                    (TessPrimitiveType::Quads, 0 | 2) => Vec3::from_array([vtx.m_data[1], 0.0, 0.0]),
                    (TessPrimitiveType::Quads, 1 | 3) => Vec3::from_array([vtx.m_data[0], 0.0, 0.0]),
                    _ => Vec3::from_array([-1.0, -1.0, -1.0]),
                };
                insert_vec3_set(&mut current_edge_vertices, swizzled);
            }

            if outer_edge_index == 0 {
                first_edge_vertices = current_edge_vertices;
            } else if current_edge_vertices != first_edge_vertices {
                // Compare vertices of this edge to those of the first edge.
                let swizzle_desc = match (primitive_type, outer_edge_index) {
                    (TessPrimitiveType::Triangles, 1) => "(y, x, z)",
                    (TessPrimitiveType::Triangles, 2) => "(z, y, x)",
                    (TessPrimitiveType::Quads, 1 | 3) => "(x, 0)",
                    (TessPrimitiveType::Quads, 2) => "(y, 0)",
                    _ => "(null)",
                };

                log::warn!(
                    "Failure: the set of vertices on the {} edge doesn't match the set of vertices on the {} edge",
                    edge_desc.description(),
                    edge_descriptions[0].description()
                );
                log::warn!(
                    "Note: set of vertices on {} edge, components swizzled like {swizzle_desc} to match component order on first edge:\n{}\non {} edge:\n{}",
                    edge_desc.description(),
                    vec3_container_str(&current_edge_vertices, 5, 0),
                    edge_descriptions[0].description(),
                    vec3_container_str(&first_edge_vertices, 5, 0)
                );
                case.fail(
                    "edge vertex sets differ between edges".to_string(),
                    "Invalid set of vertices",
                );
                return;
            }
        }
    }
}

/// `TessellationTests::init`'s `.invariance.outer_edge_index_independence` sub-group.
fn outer_edge_index_independence_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("outer_edge_index_independence");

    for primitive_type in [TessPrimitiveType::Triangles, TessPrimitiveType::Quads] {
        for spacing in [
            SpacingMode::Equal,
            SpacingMode::FractionalOdd,
            SpacingMode::FractionalEven,
        ] {
            for winding in [Winding::Ccw, Winding::Cw] {
                for use_point_mode in [false, true] {
                    let name = format!(
                        "{}_{}_{}{}",
                        primitive_type.shader_name(),
                        spacing.shader_name(),
                        winding.shader_name(),
                        if use_point_mode { "_point_mode" } else { "" }
                    );
                    let case_name = name.clone();
                    add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
                        outer_edge_index_independence_case(
                            case,
                            &case_name,
                            primitive_type,
                            spacing,
                            winding,
                            use_point_mode,
                        );
                    });
                }
            }
        }
    }

    group
}

/// `TessellationTests::init`'s `.invariance` sub-group, holding the seven of its nine
/// children that need no rendered reference.
fn invariance_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("invariance");

    group.add_child(invariant_primitive_set_group());
    group.add_child(invariant_outer_edge_group());
    group.add_child(symmetric_outer_edge_group());
    group.add_child(outer_edge_index_independence_group());
    group.add_child(invariant_triangle_set_group());
    group.add_child(invariant_inner_triangle_set_group());
    group.add_child(invariant_outer_triangle_set_group());

    // Upstream registers all nine sub-groups before filling any of them, in this order:
    // primitive_set, outer_edge_division, outer_edge_symmetry,
    // outer_edge_index_independence, triangle_set, inner_triangle_set,
    // outer_triangle_set, tess_coord_component_range, one_minus_tess_coord_component -
    // which is the order they are added in here.
    for (group_name, check) in [
        ("tess_coord_component_range", TessCoordComponentCheck::Range),
        ("one_minus_tess_coord_component", TessCoordComponentCheck::OneMinus),
    ] {
        let mut sub_group = TestCaseGroup::new(group_name);

        for primitive_type in [
            TessPrimitiveType::Triangles,
            TessPrimitiveType::Quads,
            TessPrimitiveType::Isolines,
        ] {
            for spacing in [
                SpacingMode::Equal,
                SpacingMode::FractionalOdd,
                SpacingMode::FractionalEven,
            ] {
                for winding in [Winding::Ccw, Winding::Cw] {
                    for use_point_mode in [false, true] {
                        let name = format!(
                            "{}_{}_{}{}",
                            primitive_type.shader_name(),
                            spacing.shader_name(),
                            winding.shader_name(),
                            if use_point_mode { "_point_mode" } else { "" }
                        );
                        let case_name = name.clone();
                        add_api_case(&mut sub_group, name, move |case: &mut ApiCase<'_>| {
                            tess_coord_component_invariance_case(
                                case,
                                &case_name,
                                check,
                                primitive_type,
                                spacing,
                                winding,
                                use_point_mode,
                            );
                        });
                    }
                }
            }
        }

        group.add_child(sub_group);
    }

    group
}

// ---------------------------------------------------------------------------------------
// common_edge
// ---------------------------------------------------------------------------------------

/// `CommonEdgeCase::RENDER_SIZE`
const COMMON_EDGE_RENDER_SIZE: i32 = 256;

/// `checkGPUShader5Support`
fn check_gpu_shader5_support(case: &mut ApiCase<'_>) -> bool {
    if supports_es32(case.context()) || case.context().context_info.is_extension_supported("GL_EXT_gpu_shader5") {
        return true;
    }
    case.not_supported("GL_EXT_gpu_shader5 is not supported");
    false
}

/// `CommonEdgeCase::init`'s four shader templates, in upstream's order.
fn common_edge_program<'gl>(
    context: &'gl Context,
    primitive_type: TessPrimitiveType,
    spacing: SpacingMode,
    precise: bool,
) -> ShaderProgram<'gl> {
    const VERTEX_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         ${GLSL_PER_VERTEX_OUT}\n\
         \n\
         in highp vec2 in_v_position;\n\
         in highp float in_v_tessParam;\n\
         \n\
         out highp vec2 in_tc_position;\n\
         out highp float in_tc_tessParam;\n\
         \n\
         void main (void)\n\
         {\n\
         \x20   in_tc_position = in_v_position;\n\
         \x20   in_tc_tessParam = in_v_tessParam;\n\
         }\n";
    const FRAGMENT_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
         \n\
         layout (location = 0) out mediump vec4 o_color;\n\
         \n\
         in mediump vec4 in_f_color;\n\
         \n\
         void main (void)\n\
         {\n\
         \x20   o_color = in_f_color;\n\
         }\n";

    let gpu_shader5 = if precise { "${GPU_SHADER5_REQUIRE}\n" } else { "" };
    let is_triangles = primitive_type == TessPrimitiveType::Triangles;

    let outer_levels = if is_triangles {
        "    gl_TessLevelOuter[0] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[1] + in_tc_tessParam[2]);\n\
         \x20   gl_TessLevelOuter[1] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[2] + in_tc_tessParam[0]);\n\
         \x20   gl_TessLevelOuter[2] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[0] + in_tc_tessParam[1]);\n"
    } else {
        "    gl_TessLevelOuter[0] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[0] + in_tc_tessParam[2]);\n\
         \x20   gl_TessLevelOuter[1] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[1] + in_tc_tessParam[0]);\n\
         \x20   gl_TessLevelOuter[2] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[3] + in_tc_tessParam[1]);\n\
         \x20   gl_TessLevelOuter[3] = 1.0 + 59.0 * 0.5 * (in_tc_tessParam[2] + in_tc_tessParam[3]);\n"
    };

    let tess_control_template = format!(
        "${{GLSL_VERSION_DECL}}\n\
         ${{TESSELLATION_SHADER_REQUIRE}}\n\
         {gpu_shader5}${{GLSL_PER_VERTEX_IN_ARR}}\n\
         ${{GLSL_PER_VERTEX_OUT_ARR}}\n\
         \n\
         layout (vertices = {}) out;\n\
         \n\
         in highp vec2 in_tc_position[];\n\
         in highp float in_tc_tessParam[];\n\
         \n\
         out highp vec2 in_te_position[];\n\
         \n\
         {}void main (void)\n\
         {{\n\
         \x20   in_te_position[gl_InvocationID] = in_tc_position[gl_InvocationID];\n\
         \n\
         \x20   gl_TessLevelInner[0] = 5.0;\n\
         \x20   gl_TessLevelInner[1] = 5.0;\n\
         \n\
         {outer_levels}}}\n",
        if is_triangles { "3" } else { "4" },
        if precise { "precise gl_TessLevelOuter;\n\n" } else { "" }
    );

    let position_code = if is_triangles {
        "    highp vec2 pos = gl_TessCoord.x*in_te_position[0] + gl_TessCoord.y*in_te_position[1] + gl_TessCoord.z*in_te_position[2];\n\
         \n\
         \x20   highp float f = sqrt(3.0 * min(gl_TessCoord.x, min(gl_TessCoord.y, gl_TessCoord.z))) * 0.5 + 0.5;\n\
         \x20   in_f_color = vec4(gl_TessCoord*f, 1.0);\n"
            .to_string()
    } else {
        let pos = if precise {
            "    highp vec2 a = (1.0-gl_TessCoord.x)*(1.0-gl_TessCoord.y)*in_te_position[0];\n\
             \x20   highp vec2 b = (    gl_TessCoord.x)*(1.0-gl_TessCoord.y)*in_te_position[1];\n\
             \x20   highp vec2 c = (1.0-gl_TessCoord.x)*(    gl_TessCoord.y)*in_te_position[2];\n\
             \x20   highp vec2 d = (    gl_TessCoord.x)*(    gl_TessCoord.y)*in_te_position[3];\n\
             \x20   highp vec2 pos = a+b+c+d;\n"
        } else {
            "    highp vec2 pos = (1.0-gl_TessCoord.x)*(1.0-gl_TessCoord.y)*in_te_position[0]\n\
             \x20                  + (    gl_TessCoord.x)*(1.0-gl_TessCoord.y)*in_te_position[1]\n\
             \x20                  + (1.0-gl_TessCoord.x)*(    gl_TessCoord.y)*in_te_position[2]\n\
             \x20                  + (    gl_TessCoord.x)*(    gl_TessCoord.y)*in_te_position[3];\n"
        };
        format!(
            "{pos}\n\
             \x20   highp float f = sqrt(1.0 - 2.0 * max(abs(gl_TessCoord.x - 0.5), abs(gl_TessCoord.y - 0.5)))*0.5 + 0.5;\n\
             \x20   in_f_color = vec4(0.1, gl_TessCoord.xy*f, 1.0);\n"
        )
    };

    let tess_eval_template = format!(
        "${{GLSL_VERSION_DECL}}\n\
         ${{TESSELLATION_SHADER_REQUIRE}}\n\
         {gpu_shader5}${{GLSL_PRECISE_PER_VERTEX_IN_ARR}}\n\
         ${{GLSL_PRECISE_PER_VERTEX_OUT}}\n\
         \n\
         layout ({}, {}) in;\n\
         \n\
         in highp vec2 in_te_position[];\n\
         \n\
         out mediump vec4 in_f_color;\n\
         \n\
         {}void main (void)\n\
         {{\n\
         {position_code}\
         \n\
         \x20   // Offset the position slightly, based on the parity of the bits in the float representation.\n\
         \x20   // This is done to detect possible small differences in edge vertex positions between patches.\n\
         \x20   uvec2 bits = floatBitsToUint(pos);\n\
         \x20   uint numBits = 0u;\n\
         \x20   for (uint i = 0u; i < 32u; i++)\n\
         \x20       numBits += ((bits[0] >> i) & 1u) + ((bits[1] >> i) & 1u);\n\
         \x20   pos += float(numBits&1u)*0.04;\n\
         \n\
         \x20   gl_Position = vec4(pos, 0.0, 1.0);\n\
         }}\n",
        primitive_type.shader_name(),
        spacing.shader_name(),
        if precise { "precise gl_Position;\n\n" } else { "" }
    );

    let sources = ProgramSources::default()
        .with(ShaderType::Vertex, specialize_shader(context, VERTEX_TEMPLATE))
        .with(
            ShaderType::TessControl,
            specialize_shader(context, &tess_control_template),
        )
        .with(
            ShaderType::TessEvaluation,
            specialize_shader(context, &tess_eval_template),
        )
        .with(ShaderType::Fragment, specialize_shader(context, FRAGMENT_TEMPLATE));

    ShaderProgram::new(context.gl(), &sources)
}

/// `CommonEdgeCase::init` + `iterate`.
fn common_edge_case(
    case: &mut ApiCase<'_>,
    name: &str,
    primitive_type: TessPrimitiveType,
    spacing: SpacingMode,
    precise: bool,
) {
    if !check_tessellation_support(case) {
        return;
    }
    if precise && !check_gpu_shader5_support(case) {
        return;
    }

    // `checkRenderTargetSize`
    let render_target = case.context().render_target();
    if render_target.width < COMMON_EDGE_RENDER_SIZE || render_target.height < COMMON_EDGE_RENDER_SIZE {
        case.not_supported(format!(
            "Render target width and height must be at least {COMMON_EDGE_RENDER_SIZE}"
        ));
        return;
    }

    let context = case.context();
    let gl = case.gl();
    let program = common_edge_program(context, primitive_type, spacing, precise);
    if !program.is_ok() {
        case.fail("Program compilation failed".to_string(), "Program compilation failed");
        return;
    }
    let program_gl = program.program();

    // `RandomViewport(renderTarget, RENDER_SIZE, RENDER_SIZE, deStringHash(getName()))`
    let width = COMMON_EDGE_RENDER_SIZE.min(render_target.width);
    let height = COMMON_EDGE_RENDER_SIZE.min(render_target.height);
    let mut rnd = Random::new(de_string_hash(name));
    let vp_x = rnd.get_int(0, render_target.width - width);
    let vp_y = rnd.get_int(0, render_target.height - height);

    let is_triangles = primitive_type == TessPrimitiveType::Triangles;
    let grid_width = 4usize;
    let grid_height = 4usize;
    let num_vertices = (grid_width + 1) * (grid_height + 1);
    let mut grid_pos_comps: Vec<f32> = Vec::with_capacity(2 * num_vertices);
    let mut grid_tess_params: Vec<f32> = Vec::with_capacity(num_vertices);
    let mut grid_indices: Vec<u16> = Vec::new();

    for i in 0..=grid_height {
        for j in 0..=grid_width {
            grid_pos_comps.push(-1.0 + 2.0 * (j as f32 + 0.5) / (grid_width + 1) as f32);
            grid_pos_comps.push(-1.0 + 2.0 * (i as f32 + 0.5) / (grid_height + 1) as f32);
            grid_tess_params.push((i * (grid_width + 1) + j) as f32 / (num_vertices - 1) as f32);
        }
    }

    // Generate patch vertex indices.
    // \note If CASETYPE_BASIC, the vertices are ordered such that when multiple
    //         triangles/quads share a vertex, it's at the same index for everyone.
    if is_triangles {
        for i in 0..grid_height {
            for j in 0..grid_width {
                let corners = [
                    (i * (grid_width + 1) + j) as u16,
                    (i * (grid_width + 1) + j + 1) as u16,
                    ((i + 1) * (grid_width + 1) + j) as u16,
                    ((i + 1) * (grid_width + 1) + j + 1) as u16,
                ];

                let second_triangle_vertex_index_offset = usize::from(precise);

                for k in 0..3 {
                    grid_indices.push(corners[(k + i + (2 - j % 3)) % 3]);
                }
                for k in 0..3 {
                    grid_indices.push(corners[(k + 2 + i + (2 - j % 3) + second_triangle_vertex_index_offset) % 3 + 1]);
                }
            }
        }
    } else {
        for i in 0..grid_height {
            for j in 0..grid_width {
                // \note The vertices are ordered such that when multiple quads
                //         share a vertices, it's at the same index for everyone.
                for m in 0..2 {
                    for n in 0..2 {
                        grid_indices.push(((i + (i + m) % 2) * (grid_width + 1) + j + (j + n) % 2) as u16);
                    }
                }

                if precise && (i + j) % 2 == 0 {
                    let len = grid_indices.len();
                    grid_indices[len - 4..].reverse();
                }
            }
        }
    }

    // SAFETY: plain state setters on a program that linked.
    unsafe {
        gl.viewport(vp_x, vp_y, width, height);
        gl.clear_color(0.0, 0.0, 0.0, 1.0);
        gl.use_program(program_gl);

        gl.patch_parameteri(glw::GL_PATCH_VERTICES, if is_triangles { 3 } else { 4 });
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
    }

    let vao = VertexArray::new(gl);
    // SAFETY: a VAO this case owns.
    unsafe { gl.bind_vertex_array(vao.get()) };

    let bindings = [
        glu::va::float("in_v_position", 2, num_vertices as i32, 0, &grid_pos_comps),
        glu::va::float("in_v_tessParam", 1, num_vertices as i32, 0, &grid_tess_params),
    ];
    if let Err(e) = glu::draw(
        &context.render_context,
        program_gl,
        &bindings,
        &glu::pr::patches(&grid_indices),
    ) {
        case.fail(e.to_string(), "Draw failed");
        return;
    }
    case.expect_no_error("Draw failed");

    let mut rendered = Surface::new(width, height);
    if let Err(e) = glu::read_pixels(&context.render_context, vp_x, vp_y, &mut rendered.get_access()) {
        case.fail(e.to_string(), "Image verification failed");
        return;
    }

    // Ad-hoc result verification - check that a certain rectangle in the image contains no black pixels.
    let start_x = (0.15 * rendered.get_width() as f32) as i32;
    let end_x = (0.85 * rendered.get_width() as f32) as i32;
    let start_y = (0.15 * rendered.get_height() as f32) as i32;
    let end_y = (0.85 * rendered.get_height() as f32) as i32;

    for y in start_y..end_y {
        for x in start_x..end_x {
            let pixel = rendered.get_pixel(x, y);

            if pixel.get_red() == 0 && pixel.get_green() == 0 && pixel.get_blue() == 0 {
                log::warn!(
                    "Failure: there seem to be cracks in the rendered result; pixel with zero r, g and b channels found at ({x}, {y})"
                );
                case.fail(
                    "there seem to be cracks in the rendered result".to_string(),
                    "Image verification failed",
                );
                return;
            }
        }
    }

    log::debug!("Success: there seem to be no cracks in the rendered result");
}

fn common_edge_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("common_edge");

    for precise in [false, true] {
        for primitive_type in [TessPrimitiveType::Triangles, TessPrimitiveType::Quads] {
            for spacing in [
                SpacingMode::Equal,
                SpacingMode::FractionalOdd,
                SpacingMode::FractionalEven,
            ] {
                let name = format!(
                    "{}_{}{}",
                    primitive_type.shader_name(),
                    spacing.shader_name(),
                    if precise { "_precise" } else { "" }
                );
                let case_name = name.clone();
                add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
                    common_edge_case(case, &case_name, primitive_type, spacing, precise)
                });
            }
        }
    }

    group
}

/// `TessellationTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("tessellation");
    group.add_child(state_query_group());
    group.add_child(tess_coord_group());
    group.add_child(winding_group());
    group.add_child(common_edge_group());
    group.add_child(fractional_spacing_group());
    group.add_child(primitive_discard_group());
    group.add_child(invariance_group());
    group.add_child(super::tessellation_render_tests::shader_input_output_group());
    group.add_child(super::tessellation_render_tests::misc_draw_group());
    group.add_child(super::tessellation_render_tests::user_defined_io_group());
    group
}
