// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fProgramStateQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `specializeShader`'s
// `${GL_POSITION_REDECL}` is always empty here - it only fires on a desktop core
// profile, and this port is ES-only. `QUERY_PROGRAM_INTEGER_VEC3` and
// `verifyInfoLogQuery` are not in the group's `query_util`, so both are inlined
// below in the shape upstream's helpers have.

use crate::gls::state_query_util::{Guarded, QueryType, verify_state_program_integer};
use crate::glu::{ApiCase, ProgramSources, ShaderProgram, ShaderType, TestCaseGroup, add_api_case};
use crate::glw::{self, GLchar, GLenum, GLint, GLsizei, GLuint};

/// `getVerifierSuffix` - one suffix covers both `QUERY_PROGRAM_INTEGER` and
/// `QUERY_PROGRAM_INTEGER_VEC3` upstream.
const VERIFIER_SUFFIX: &str = "get_programiv";

/// `checkSupport` - ES 3.2 (the desktop GL 4.5 half is dropped, ES-only port).
fn check_support(case: &ApiCase<'_>) -> bool {
    case.context().context_type().supports(3, 2)
}

/// `specializeShader`
fn specialize(case: &ApiCase<'_>, code: &str) -> String {
    let version = case.context().context_type().glsl_version().declaration();
    let is_es32_or_gl45 = check_support(case);
    let geometry_require = if is_es32_or_gl45 {
        ""
    } else {
        "#extension GL_EXT_geometry_shader : require"
    };
    let tessellation_require = if is_es32_or_gl45 {
        ""
    } else {
        "#extension GL_EXT_tessellation_shader : require"
    };

    code.replace("${GLSL_VERSION_DECL}", version)
        .replace("${GEOMETRY_SHADER_REQUIRE}", geometry_require)
        .replace("${TESSELLATION_SHADER_REQUIRE}", tessellation_require)
        .replace("${GL_POSITION_REDECL}", "")
}

/// `glu::Program` - a bare program name, deleted on drop.
struct Program<'gl> {
    gl: &'gl glw::Functions,
    program: GLuint,
}

impl<'gl> Program<'gl> {
    fn new(gl: &'gl glw::Functions) -> Self {
        // SAFETY: a fresh program name.
        let program = unsafe { gl.create_program() };
        Self { gl, program }
    }

    fn get_program(&self) -> GLuint {
        self.program
    }
}

impl Drop for Program<'_> {
    fn drop(&mut self) {
        // SAFETY: this struct's own name, deleted exactly once.
        unsafe { self.gl.delete_program(self.program) };
    }
}

/// `glu::Shader` - one compiled shader, deleted on drop.
struct Shader<'gl> {
    gl: &'gl glw::Functions,
    shader: GLuint,
    compile_status: bool,
}

impl<'gl> Shader<'gl> {
    fn new(gl: &'gl glw::Functions, shader_type: ShaderType, source: &str) -> Self {
        // SAFETY: a fresh shader name; the source pointer/length pair describes a live
        // borrow that outlives the call.
        unsafe {
            let shader = gl.create_shader(shader_type.gl_enum());
            let bytes = source.as_bytes();
            let pointer = bytes.as_ptr().cast::<GLchar>();
            let length = bytes.len() as GLint;
            gl.shader_source(shader, 1, &raw const pointer, &raw const length);
            gl.compile_shader(shader);

            let mut status: GLint = 0;
            gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &raw mut status);
            Self {
                gl,
                shader,
                compile_status: status == GLint::from(glw::TRUE),
            }
        }
    }

    fn get_shader(&self) -> GLuint {
        self.shader
    }

    fn get_compile_status(&self) -> bool {
        self.compile_status
    }
}

impl Drop for Shader<'_> {
    fn drop(&mut self) {
        // SAFETY: this struct's own name, deleted exactly once.
        unsafe { self.gl.delete_shader(self.shader) };
    }
}

/// `verifyStateProgramIntegerVec3` - `query_util` has no VEC3 query type, so the one
/// place that needs it does the query and the compare here.
fn verify_state_program_integer_vec3(case: &mut ApiCase<'_>, program: GLuint, pname: GLenum, expected: [GLint; 3]) {
    let mut state = Guarded::<[GLint; 3]>::new();
    // SAFETY: three GLints out, guarded on both sides.
    unsafe {
        case.gl()
            .get_programiv(program, pname, state.as_mut_ptr().cast::<GLint>())
    };
    if !state.verify_validity(case) {
        return;
    }
    case.expect_error(glw::GL_NO_ERROR);

    if state.value() != expected {
        case.fail(
            format!("Expected {expected:?}, got {:?}", state.value()),
            "Got invalid state value",
        );
    }
}

const S_VTX_FRAG_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
    void main()\n\
    {\n\
    }\n";

/// `GeometryShaderCase::iterate`
fn geometry_shader_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    if !check_support(case)
        && !case
            .context()
            .context_info
            .is_extension_supported("GL_EXT_geometry_shader")
    {
        case.not_supported(
            "Geometry shader tests require GL_EXT_geometry_shader extension or an OpenGL ES 3.2 or higher context.",
        );
        return;
    }

    const S_GEOMETRY_TEMPLATE1: &str = "${GLSL_VERSION_DECL}\n\
        ${GEOMETRY_SHADER_REQUIRE}\n\
        layout(triangles) in;\
        layout(triangle_strip, max_vertices = 3) out;\n\
        void main()\n\
        {\n\
           EndPrimitive();\n\
        }\n";

    const S_GEOMETRY_TEMPLATE2: &str = "${GLSL_VERSION_DECL}\n\
        ${GEOMETRY_SHADER_REQUIRE}\n\
        layout(points) in;\
        layout(line_strip, max_vertices = 5) out;\n\
        void main()\n\
        {\n\
           EndPrimitive();\n\
        }\n";

    const S_GEOMETRY_TEMPLATE3: &str = "${GLSL_VERSION_DECL}\n\
        ${GEOMETRY_SHADER_REQUIRE}\n\
        layout(points) in;\
        layout(points, max_vertices = 50) out;\n\
        void main()\n\
        {\n\
           EndPrimitive();\n\
        }\n";

    let vtx_frag = specialize(case, S_VTX_FRAG_TEMPLATE);

    {
        case.section("triangles in, triangle strip out, 3 vertices");
        let sources = ProgramSources::default()
            .with(ShaderType::Vertex, vtx_frag.clone())
            .with(ShaderType::Fragment, vtx_frag.clone())
            .with(ShaderType::Geometry, specialize(case, S_GEOMETRY_TEMPLATE1));
        let program = ShaderProgram::new(case.gl(), &sources);
        if !program.is_ok() {
            case.fail("Compile failed".to_string(), "Compile failed");
            return;
        }
        let name = program.program();

        verify_state_program_integer(case, name, glw::GL_GEOMETRY_VERTICES_OUT, 3, verifier);
        verify_state_program_integer(
            case,
            name,
            glw::GL_GEOMETRY_INPUT_TYPE,
            glw::GL_TRIANGLES as GLint,
            verifier,
        );
        verify_state_program_integer(
            case,
            name,
            glw::GL_GEOMETRY_OUTPUT_TYPE,
            glw::GL_TRIANGLE_STRIP as GLint,
            verifier,
        );
        verify_state_program_integer(case, name, glw::GL_GEOMETRY_SHADER_INVOCATIONS, 1, verifier);
    }

    {
        case.section("points in, line strip out, 5 vertices");
        let sources = ProgramSources::default()
            .with(ShaderType::Vertex, vtx_frag.clone())
            .with(ShaderType::Fragment, vtx_frag.clone())
            .with(ShaderType::Geometry, specialize(case, S_GEOMETRY_TEMPLATE2));
        let program = ShaderProgram::new(case.gl(), &sources);
        if !program.is_ok() {
            case.fail("Compile failed".to_string(), "Compile failed");
            return;
        }
        let name = program.program();

        verify_state_program_integer(case, name, glw::GL_GEOMETRY_VERTICES_OUT, 5, verifier);
        verify_state_program_integer(
            case,
            name,
            glw::GL_GEOMETRY_INPUT_TYPE,
            glw::GL_POINTS as GLint,
            verifier,
        );
        verify_state_program_integer(
            case,
            name,
            glw::GL_GEOMETRY_OUTPUT_TYPE,
            glw::GL_LINE_STRIP as GLint,
            verifier,
        );
    }

    {
        case.section("points in, points out, 50 vertices");
        let sources = ProgramSources::default()
            .with(ShaderType::Vertex, vtx_frag.clone())
            .with(ShaderType::Fragment, vtx_frag.clone())
            .with(ShaderType::Geometry, specialize(case, S_GEOMETRY_TEMPLATE3));
        let program = ShaderProgram::new(case.gl(), &sources);
        if !program.is_ok() {
            case.fail("Compile failed".to_string(), "Compile failed");
            return;
        }
        let name = program.program();

        verify_state_program_integer(case, name, glw::GL_GEOMETRY_VERTICES_OUT, 50, verifier);
        verify_state_program_integer(
            case,
            name,
            glw::GL_GEOMETRY_INPUT_TYPE,
            glw::GL_POINTS as GLint,
            verifier,
        );
        verify_state_program_integer(
            case,
            name,
            glw::GL_GEOMETRY_OUTPUT_TYPE,
            glw::GL_POINTS as GLint,
            verifier,
        );
    }
}

/// `TessellationShaderCase::iterate`
fn tessellation_shader_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    if !check_support(case)
        && !case
            .context()
            .context_info
            .is_extension_supported("GL_EXT_tessellation_shader")
    {
        case.not_supported("Tessellation shader tests require GL_EXT_tessellation_shader extension or an OpenGL ES 3.2 or higher context.");
        return;
    }

    const S_TESS_CTRL_TEMPLATE1: &str = "${GLSL_VERSION_DECL}\n\
        ${TESSELLATION_SHADER_REQUIRE}\n\
        layout(vertices = 3) out;\n\
        void main()\n\
        {\n\
        }\n";

    const S_TESS_EVAL_TEMPLATE1: &str = "${GLSL_VERSION_DECL}\n\
        ${TESSELLATION_SHADER_REQUIRE}\n\
        layout(triangles, equal_spacing, cw) in;\n\
        void main()\n\
        {\n\
        }\n";

    const S_TESS_CTRL_TEMPLATE2: &str = "${GLSL_VERSION_DECL}\n\
        ${TESSELLATION_SHADER_REQUIRE}\n\
        layout(vertices = 5) out;\n\
        void main()\n\
        {\n\
        }\n";

    const S_TESS_EVAL_TEMPLATE2: &str = "${GLSL_VERSION_DECL}\n\
        ${TESSELLATION_SHADER_REQUIRE}\n\
        layout(quads, fractional_even_spacing, ccw) in;\n\
        void main()\n\
        {\n\
        }\n";

    const S_TESS_EVAL_TEMPLATE3: &str = "${GLSL_VERSION_DECL}\n\
        ${TESSELLATION_SHADER_REQUIRE}\n\
        layout(isolines, fractional_odd_spacing, ccw, point_mode) in;\n\
        void main()\n\
        {\n\
        }\n";

    let vtx_frag = specialize(case, S_VTX_FRAG_TEMPLATE);

    {
        case.section("3 vertices, triangles, equal_spacing, cw");
        let sources = ProgramSources::default()
            .with(ShaderType::Vertex, vtx_frag.clone())
            .with(ShaderType::Fragment, vtx_frag.clone())
            .with(ShaderType::TessControl, specialize(case, S_TESS_CTRL_TEMPLATE1))
            .with(ShaderType::TessEvaluation, specialize(case, S_TESS_EVAL_TEMPLATE1));
        let program = ShaderProgram::new(case.gl(), &sources);
        if !program.is_ok() {
            case.fail("Compile failed".to_string(), "Compile failed");
            return;
        }
        let name = program.program();

        verify_state_program_integer(case, name, glw::GL_TESS_CONTROL_OUTPUT_VERTICES, 3, verifier);
        verify_state_program_integer(case, name, glw::GL_TESS_GEN_MODE, glw::GL_TRIANGLES as GLint, verifier);
        verify_state_program_integer(case, name, glw::GL_TESS_GEN_SPACING, glw::GL_EQUAL as GLint, verifier);
        verify_state_program_integer(case, name, glw::GL_TESS_GEN_VERTEX_ORDER, glw::GL_CW as GLint, verifier);
        verify_state_program_integer(
            case,
            name,
            glw::GL_TESS_GEN_POINT_MODE,
            GLint::from(glw::FALSE),
            verifier,
        );
    }

    {
        case.section("5 vertices, quads, fractional_even_spacing, ccw");
        let sources = ProgramSources::default()
            .with(ShaderType::Vertex, vtx_frag.clone())
            .with(ShaderType::Fragment, vtx_frag.clone())
            .with(ShaderType::TessControl, specialize(case, S_TESS_CTRL_TEMPLATE2))
            .with(ShaderType::TessEvaluation, specialize(case, S_TESS_EVAL_TEMPLATE2));
        let program = ShaderProgram::new(case.gl(), &sources);
        if !program.is_ok() {
            case.fail("Compile failed".to_string(), "Compile failed");
            return;
        }
        let name = program.program();

        verify_state_program_integer(case, name, glw::GL_TESS_CONTROL_OUTPUT_VERTICES, 5, verifier);
        verify_state_program_integer(case, name, glw::GL_TESS_GEN_MODE, glw::GL_QUADS as GLint, verifier);
        verify_state_program_integer(
            case,
            name,
            glw::GL_TESS_GEN_SPACING,
            glw::GL_FRACTIONAL_EVEN as GLint,
            verifier,
        );
        verify_state_program_integer(
            case,
            name,
            glw::GL_TESS_GEN_VERTEX_ORDER,
            glw::GL_CCW as GLint,
            verifier,
        );
        verify_state_program_integer(
            case,
            name,
            glw::GL_TESS_GEN_POINT_MODE,
            GLint::from(glw::FALSE),
            verifier,
        );
    }

    {
        case.section("5 vertices, isolines, fractional_odd_spacing, ccw, point_mode");
        let sources = ProgramSources::default()
            .with(ShaderType::Vertex, vtx_frag.clone())
            .with(ShaderType::Fragment, vtx_frag.clone())
            .with(ShaderType::TessControl, specialize(case, S_TESS_CTRL_TEMPLATE2))
            .with(ShaderType::TessEvaluation, specialize(case, S_TESS_EVAL_TEMPLATE3));
        let program = ShaderProgram::new(case.gl(), &sources);
        if !program.is_ok() {
            case.fail("Compile failed".to_string(), "Compile failed");
            return;
        }
        let name = program.program();

        verify_state_program_integer(case, name, glw::GL_TESS_CONTROL_OUTPUT_VERTICES, 5, verifier);
        verify_state_program_integer(case, name, glw::GL_TESS_GEN_MODE, glw::GL_ISOLINES as GLint, verifier);
        verify_state_program_integer(
            case,
            name,
            glw::GL_TESS_GEN_SPACING,
            glw::GL_FRACTIONAL_ODD as GLint,
            verifier,
        );
        verify_state_program_integer(
            case,
            name,
            glw::GL_TESS_GEN_VERTEX_ORDER,
            glw::GL_CCW as GLint,
            verifier,
        );
        verify_state_program_integer(
            case,
            name,
            glw::GL_TESS_GEN_POINT_MODE,
            GLint::from(glw::TRUE),
            verifier,
        );
    }
}

/// `ProgramSeparableCase::iterate`
fn program_separable_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    const VTX_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
        out highp vec4 v_color;\n\
        ${GL_POSITION_REDECL}\n\
        void main()\n\
        {\n\
            gl_Position = vec4(float(gl_VertexID) * 0.5, float(gl_VertexID+1) * 0.5, 0.0, 1.0);\n\
            v_color = vec4(float(gl_VertexID), 1.0, 0.0, 1.0);\n\
        }\n";
    const FRAG_TEMPLATE: &str = "${GLSL_VERSION_DECL}\n\
        in highp vec4 v_color;\n\
        layout(location=0) out highp vec4 o_color;\n\
        void main()\n\
        {\n\
            o_color = v_color;\n\
        }\n";

    let vtx_source = specialize(case, VTX_TEMPLATE);
    let frag_source = specialize(case, FRAG_TEMPLATE);
    let vtx_shader = Shader::new(case.gl(), ShaderType::Vertex, &vtx_source);
    let frg_shader = Shader::new(case.gl(), ShaderType::Fragment, &frag_source);

    if !vtx_shader.get_compile_status() || !frg_shader.get_compile_status() {
        case.fail("failed to build shaders".to_string(), "failed to build shaders");
        return;
    }

    {
        case.section("Initial");
        let program = Program::new(case.gl());
        verify_state_program_integer(case, program.get_program(), glw::GL_PROGRAM_SEPARABLE, 0, verifier);
    }

    for (section, separable, expected) in [
        ("SetFalse", GLint::from(glw::FALSE), 0),
        ("SetTrue", GLint::from(glw::TRUE), GLint::from(glw::TRUE)),
    ] {
        case.section(section);
        let program = Program::new(case.gl());
        let mut link_status: GLint = 0;

        // SAFETY: every name is one this case owns.
        unsafe {
            case.gl().attach_shader(program.get_program(), vtx_shader.get_shader());
            case.gl().attach_shader(program.get_program(), frg_shader.get_shader());
            case.gl()
                .program_parameteri(program.get_program(), glw::GL_PROGRAM_SEPARABLE, separable);
            case.gl().link_program(program.get_program());
        }
        case.expect_error(glw::GL_NO_ERROR);

        // SAFETY: one GLint out.
        unsafe {
            case.gl()
                .get_programiv(program.get_program(), glw::GL_LINK_STATUS, &raw mut link_status)
        };
        case.expect_error(glw::GL_NO_ERROR);

        // SAFETY: detaching a shader this case attached.
        unsafe {
            case.gl().detach_shader(program.get_program(), vtx_shader.get_shader());
            case.gl().detach_shader(program.get_program(), frg_shader.get_shader());
        }

        if link_status != GLint::from(glw::TRUE) {
            case.fail("failed to link program".to_string(), "failed to link program");
            return;
        }

        verify_state_program_integer(
            case,
            program.get_program(),
            glw::GL_PROGRAM_SEPARABLE,
            expected,
            verifier,
        );
    }
}

/// `ComputeWorkGroupSizeCase::iterate`
fn compute_work_group_size_case(case: &mut ApiCase<'_>) {
    const S_COMPUTE_TEMPLATE_1D: &str = "${GLSL_VERSION_DECL}\n\
        layout (local_size_x = 3) in;\n\
        layout(binding = 0) buffer Output\n\
        {\n\
            highp float val;\n\
        } sb_out;\n\
        \n\
        void main (void)\n\
        {\n\
            sb_out.val = 1.0;\n\
        }\n";
    const S_COMPUTE_TEMPLATE_2D: &str = "${GLSL_VERSION_DECL}\n\
        layout (local_size_x = 3, local_size_y = 2) in;\n\
        layout(binding = 0) buffer Output\n\
        {\n\
            highp float val;\n\
        } sb_out;\n\
        \n\
        void main (void)\n\
        {\n\
            sb_out.val = 1.0;\n\
        }\n";
    const S_COMPUTE_TEMPLATE_3D: &str = "${GLSL_VERSION_DECL}\n\
        layout (local_size_x = 3, local_size_y = 2, local_size_z = 4) in;\n\
        layout(binding = 0) buffer Output\n\
        {\n\
            highp float val;\n\
        } sb_out;\n\
        \n\
        void main (void)\n\
        {\n\
            sb_out.val = 1.0;\n\
        }\n";

    // Upstream's third section is spelled "TreeDimensional"; only the log name.
    for (section, template, expected) in [
        ("1D", S_COMPUTE_TEMPLATE_1D, [3, 1, 1]),
        ("2D", S_COMPUTE_TEMPLATE_2D, [3, 2, 1]),
        ("3D", S_COMPUTE_TEMPLATE_3D, [3, 2, 4]),
    ] {
        case.section(section);
        let sources = ProgramSources::compute(specialize(case, template));
        let program = ShaderProgram::new(case.gl(), &sources);
        if !program.is_ok() {
            case.fail("failed to build program".to_string(), "failed to build program");
            return;
        }

        verify_state_program_integer_vec3(case, program.program(), glw::GL_COMPUTE_WORK_GROUP_SIZE, expected);
    }
}

/// `ActiveAtomicCounterBuffersCase::iterate`
fn active_atomic_counter_buffers_case(case: &mut ApiCase<'_>, verifier: QueryType) {
    const S_COMPUTE_TEMPLATE0: &str = "${GLSL_VERSION_DECL}\n\
        layout (local_size_x = 3) in;\n\
        layout(binding = 0) buffer Output\n\
        {\n\
            highp float val;\n\
        } sb_out;\n\
        \n\
        void main (void)\n\
        {\n\
            sb_out.val = 1.0;\n\
        }\n";
    const S_COMPUTE_TEMPLATE1: &str = "${GLSL_VERSION_DECL}\n\
        layout (local_size_x = 3) in;\n\
        layout(binding = 0) uniform highp atomic_uint u_counters[2];\n\
        layout(binding = 0) buffer Output\n\
        {\n\
            highp float val;\n\
        } sb_out;\n\
        \n\
        void main (void)\n\
        {\n\
            sb_out.val = float(atomicCounterIncrement(u_counters[0])) + float(atomicCounterIncrement(u_counters[1]));\n\
        }\n";

    {
        case.section("Initial");
        let program = Program::new(case.gl());
        verify_state_program_integer(
            case,
            program.get_program(),
            glw::GL_ACTIVE_ATOMIC_COUNTER_BUFFERS,
            0,
            verifier,
        );
    }

    for (section, template, expected) in [
        ("No buffers", S_COMPUTE_TEMPLATE0, 0),
        ("One buffer", S_COMPUTE_TEMPLATE1, 1),
    ] {
        case.section(section);
        let sources = ProgramSources::compute(specialize(case, template));
        let program = ShaderProgram::new(case.gl(), &sources);
        if !program.is_ok() {
            case.fail("failed to build program".to_string(), "failed to build program");
            return;
        }

        verify_state_program_integer(
            case,
            program.program(),
            glw::GL_ACTIVE_ATOMIC_COUNTER_BUFFERS,
            expected,
            verifier,
        );
    }
}

/// `ProgramLogCase::BuildErrorType`
#[derive(Clone, Copy)]
enum BuildErrorType {
    VertexFragment,
    Compute,
    Geometry,
    Tessellation,
}

/// The buffer `verifyInfoLogQuery` reads the log back into.
const LOG_BUF_SIZE: usize = 2048;

/// `ProgramLogCase::init` + `iterate` + `getProgramSources`
fn program_log_case(case: &mut ApiCase<'_>, error_type: BuildErrorType) {
    let supports_es32_or_gl45 = check_support(case);
    match error_type {
        BuildErrorType::VertexFragment | BuildErrorType::Compute => {}
        BuildErrorType::Geometry => {
            if !supports_es32_or_gl45
                && !case
                    .context()
                    .context_info
                    .is_extension_supported("GL_EXT_geometry_shader")
            {
                case.not_supported("Test requires GL_EXT_geometry_shader extension");
                return;
            }
        }
        BuildErrorType::Tessellation => {
            if !supports_es32_or_gl45
                && !case
                    .context()
                    .context_info
                    .is_extension_supported("GL_EXT_tessellation_shader")
            {
                case.not_supported("Test requires GL_EXT_tessellation_shader extension");
                return;
            }
        }
    }

    const VERTEX_TEMPLATE1: &str = "${GLSL_VERSION_DECL}\n\
        in highp vec4 a_pos;\n\
        uniform highp vec4 u_uniform;\n\
        void main()\n\
        {\n\
            gl_Position = a_pos + u_uniform;\n\
        }\n";
    const VERTEX_TEMPLATE2: &str = "${GLSL_VERSION_DECL}\n\
        in highp vec4 a_pos;\n\
        void main()\n\
        {\n\
            gl_Position = a_pos;\n\
        }\n";
    const FRAGMENT_TEMPLATE1: &str = "${GLSL_VERSION_DECL}\n\
        in highp vec4 v_missingVar;\n\
        uniform highp int u_uniform;\n\
        layout(location = 0) out mediump vec4 fragColor;\n\
        void main()\n\
        {\n\
            fragColor = v_missingVar + vec4(float(u_uniform));\n\
        }\n";
    const FRAGMENT_TEMPLATE2: &str = "${GLSL_VERSION_DECL}\n\
        layout(location = 0) out mediump vec4 fragColor;\n\
        void main()\n\
        {\n\
            fragColor = vec4(1.0);\n\
        }\n";
    const COMPUTE_TEMPLATE1: &str = "${GLSL_VERSION_DECL}\n\
        layout (binding = 0) buffer IOBuffer { highp float buf_var; };\n\
        uniform highp vec4 u_uniform;\n\
        void main()\n\
        {\n\
            buf_var = u_uniform.x;\n\
        }\n";
    const GEOMETRY_TEMPLATE1: &str = "${GLSL_VERSION_DECL}\n\
        ${GEOMETRY_SHADER_REQUIRE}\n\
        layout(triangles) in;\n\
        layout(max_vertices=1, points) out;\n\
        in highp vec4 v_missingVar[];\n\
        uniform highp int u_uniform;\n\
        void main()\n\
        {\n\
            gl_Position = gl_in[0].gl_Position + v_missingVar[2] + vec4(float(u_uniform));\n\
            EmitVertex();\n\
        }\n";
    // The missing semicolon on the gl_out assignment is upstream's - the case wants a
    // program that fails to build.
    const TESS_CTRL_TEMPLATE1: &str = "${GLSL_VERSION_DECL}\n\
        ${TESSELLATION_SHADER_REQUIRE}\n\
        layout(vertices=2) out;\
        patch out highp vec2 vp_var;\n\
        void main()\n\
        {\n\
            gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position\n\
            gl_TessLevelOuter[0] = 0.8;\n\
            gl_TessLevelOuter[1] = 0.8;\n\
            if (gl_InvocationID == 0)\n\
                vp_var = gl_in[gl_InvocationID].gl_Position.xy;\n\
        }\n";
    const TESS_EVAL_TEMPLATE1: &str = "${GLSL_VERSION_DECL}\n\
        ${TESSELLATION_SHADER_REQUIRE}\n\
        layout(isolines) in;\
        in highp float vp_var[];\n\
        void main()\n\
        {\n\
            gl_Position = gl_in[gl_InvocationID].gl_Position + vec4(vp_var[1]);\n\
        }\n";

    let sources = match error_type {
        BuildErrorType::VertexFragment => ProgramSources::default()
            .with(ShaderType::Vertex, specialize(case, VERTEX_TEMPLATE1))
            .with(ShaderType::Fragment, specialize(case, FRAGMENT_TEMPLATE1)),
        BuildErrorType::Compute => ProgramSources::compute(specialize(case, COMPUTE_TEMPLATE1)),
        BuildErrorType::Geometry => ProgramSources::default()
            .with(ShaderType::Vertex, specialize(case, VERTEX_TEMPLATE1))
            .with(ShaderType::Geometry, specialize(case, GEOMETRY_TEMPLATE1))
            .with(ShaderType::Fragment, specialize(case, FRAGMENT_TEMPLATE2)),
        BuildErrorType::Tessellation => ProgramSources::default()
            .with(ShaderType::Vertex, specialize(case, VERTEX_TEMPLATE2))
            .with(ShaderType::TessControl, specialize(case, TESS_CTRL_TEMPLATE1))
            .with(ShaderType::TessEvaluation, specialize(case, TESS_EVAL_TEMPLATE1))
            .with(ShaderType::Fragment, specialize(case, FRAGMENT_TEMPLATE2)),
    };

    let program = ShaderProgram::new(case.gl(), &sources);
    let mut log_len = Guarded::<GLint>::new();

    case.section("Trying to link a broken program.");

    // SAFETY: one GLint out, guarded on both sides.
    unsafe {
        case.gl()
            .get_programiv(program.program(), glw::GL_INFO_LOG_LENGTH, log_len.as_mut_ptr())
    };

    if log_len.verify_validity(case) {
        let mut buffer = vec![0 as GLchar; LOG_BUF_SIZE];
        let mut written: GLsizei = 0;
        // SAFETY: bufSize is the buffer's own length.
        unsafe {
            case.gl().get_program_info_log(
                program.program(),
                LOG_BUF_SIZE as GLsizei,
                &raw mut written,
                buffer.as_mut_ptr(),
            )
        };
        case.expect_error(glw::GL_NO_ERROR);

        if log_len.value() > 0 && written != log_len.value() - 1 && LOG_BUF_SIZE as GLint > log_len.value() {
            case.fail(
                format!("Expected {} (INFO_LOG_LENGTH - 1), got {written}", log_len.value() - 1),
                "Got invalid log length",
            );
        }
    }
}

/// `ProgramStateQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("program");

    let verifier = QueryType::ProgramInteger;

    add_api_case(
        &mut group,
        format!("program_separable_{VERIFIER_SUFFIX}"),
        move |case: &mut ApiCase<'_>| {
            program_separable_case(case, verifier);
        },
    );
    add_api_case(
        &mut group,
        format!("compute_work_group_size_{VERIFIER_SUFFIX}"),
        compute_work_group_size_case,
    );
    add_api_case(
        &mut group,
        format!("active_atomic_counter_buffers_{VERIFIER_SUFFIX}"),
        move |case: &mut ApiCase<'_>| active_atomic_counter_buffers_case(case, verifier),
    );
    add_api_case(
        &mut group,
        format!("geometry_shader_state_{VERIFIER_SUFFIX}"),
        move |case: &mut ApiCase<'_>| {
            geometry_shader_case(case, verifier);
        },
    );
    // Upstream spells this "tesselation" (one l) in the case name.
    add_api_case(
        &mut group,
        format!("tesselation_shader_state_{VERIFIER_SUFFIX}"),
        move |case: &mut ApiCase<'_>| {
            tessellation_shader_case(case, verifier);
        },
    );

    for (name, error_type) in [
        ("info_log_vertex_fragment_link_fail", BuildErrorType::VertexFragment),
        ("info_log_compute_link_fail", BuildErrorType::Compute),
        ("info_log_geometry_link_fail", BuildErrorType::Geometry),
        ("info_log_tessellation_link_fail", BuildErrorType::Tessellation),
    ] {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            program_log_case(case, error_type)
        });
    }

    group
}
