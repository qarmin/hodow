// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fGeometryShaderTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
//
// Ported here: `query` (29), `negative` (44) and `vertex_transform_feedback` (12); `input`,
// `conversion`, `emit` and `varying` live in `geometry_shading_render_tests.rs` (host-emulated
// geometry reference). `geometry_*_invocations` and `draw_*_instances_*` (instanced) are there too; so are the VaryingOutputCount cases. `layered` lives in `geometry_shading_layered_tests.rs`.
//
// `NegativeDrawCase` builds an `sglr::ShaderProgram` upstream and draws through
// `sglr::GLContext`, whose calls reach the driver unchanged; here the same program is a
// plain `glu::ShaderProgram` and the draw goes straight to `glw::Functions`.

use std::ffi::{CString, c_void};
use std::mem::size_of_val;

use crate::gls::state_query_util::{
    Guarded, QueriedState, QueryType, query_state, verify_state_integer, verify_state_integer_min,
};
use crate::glu::{
    self, ApiCase, Buffer, Context, Framebuffer, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup,
    Texture, VertexArray, add_api_case,
};
use crate::glw::{self, GLenum, GLint, GLsizeiptr, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `specializeShader`
pub(crate) fn specialize_shader(code: &str, context: &Context) -> String {
    let supports_es32 = context.context_type().supports(3, 2);

    code.replace(
        "${GLSL_VERSION_DECL}",
        context.context_type().glsl_version().declaration(),
    )
    .replace(
        "${GLSL_EXT_GEOMETRY_SHADER}",
        if supports_es32 {
            ""
        } else {
            "#extension GL_EXT_geometry_shader : require\n"
        },
    )
    .replace(
        "${GLSL_OES_TEXTURE_STORAGE_MULTISAMPLE}",
        if supports_es32 {
            ""
        } else {
            "#extension GL_OES_texture_storage_multisample_2d_array : require\n"
        },
    )
}

/// `checkSupport`
pub(crate) fn check_support(context: &Context) -> bool {
    context.context_type().supports(3, 2) || context.context_info.is_extension_supported("GL_EXT_geometry_shader")
}

/// `checkSupport`, reported on an `ApiCase`.
fn require_geometry_shader(case: &mut ApiCase<'_>) -> bool {
    if check_support(case.context()) {
        return true;
    }
    case.not_supported("Tests require GL_EXT_geometry_shader extension or higher context version.");
    false
}

pub(crate) const COMMON_VERTEX_SOURCE: &str = "${GLSL_VERSION_DECL}\n\
    in highp vec4 a_position;\n\
    in highp vec4 a_color;\n\
    out highp vec4 v_geom_FragColor;\n\
    void main (void)\n\
    {\n\
    \tgl_Position = a_position;\n\
    \tgl_PointSize = 1.0;\n\
    \tv_geom_FragColor = a_color;\n\
    }\n";

pub(crate) const COMMON_FRAGMENT_SOURCE: &str = "${GLSL_VERSION_DECL}\n\
    layout(location = 0) out mediump vec4 fragColor;\n\
    in mediump vec4 v_frag_FragColor;\n\
    void main (void)\n\
    {\n\
    \tfragColor = v_frag_FragColor;\n\
    }\n";

pub(crate) const EXPAND_GEOMETRY_BODY: &str = "in highp vec4 v_geom_FragColor[];\n\
    out highp vec4 v_frag_FragColor;\n\
    \n\
    void main (void)\n\
    {\n\
    \tconst highp vec4 offset0 = vec4(-0.07, -0.01, 0.0, 0.0);\n\
    \tconst highp vec4 offset1 = vec4( 0.03, -0.03, 0.0, 0.0);\n\
    \tconst highp vec4 offset2 = vec4(-0.01,  0.08, 0.0, 0.0);\n\
    \t      highp vec4 yoffset = float(gl_PrimitiveIDIn) * vec4(0.02, 0.1, 0.0, 0.0);\n\
    \n\
    \tfor (highp int ndx = 0; ndx < gl_in.length(); ndx++)\n\
    \t{\n\
    \t\tgl_Position = gl_in[ndx].gl_Position + offset0 + yoffset;\n\
    \t\tgl_PrimitiveID = gl_PrimitiveIDIn;\n\
    \t\tv_frag_FragColor = v_geom_FragColor[ndx];\n\
    \t\tEmitVertex();\n\
    \n\
    \t\tgl_Position = gl_in[ndx].gl_Position + offset1 + yoffset;\n\
    \t\tgl_PrimitiveID = gl_PrimitiveIDIn;\n\
    \t\tv_frag_FragColor = v_geom_FragColor[ndx];\n\
    \t\tEmitVertex();\n\
    \n\
    \t\tgl_Position = gl_in[ndx].gl_Position + offset2 + yoffset;\n\
    \t\tgl_PrimitiveID = gl_PrimitiveIDIn;\n\
    \t\tv_frag_FragColor = v_geom_FragColor[ndx];\n\
    \t\tEmitVertex();\n\
    \t\tEndPrimitive();\n\
    \t}\n\
    }\n";

fn primitive_type_to_string(primitive: GLenum) -> &'static str {
    match primitive {
        glw::GL_POINTS => "points",
        glw::GL_LINES => "lines",
        glw::GL_LINE_LOOP => "line_loop",
        glw::GL_LINE_STRIP => "line_strip",
        glw::GL_LINES_ADJACENCY => "lines_adjacency",
        glw::GL_LINE_STRIP_ADJACENCY => "line_strip_adjacency",
        glw::GL_TRIANGLES => "triangles",
        glw::GL_TRIANGLE_STRIP => "triangle_strip",
        glw::GL_TRIANGLE_FAN => "triangle_fan",
        glw::GL_TRIANGLES_ADJACENCY => "triangles_adjacency",
        glw::GL_TRIANGLE_STRIP_ADJACENCY => "triangle_strip_adjacency",
        other => panic!("unexpected primitive type {other:#x}"),
    }
}

/// `inputTypeToGLString(mapGLGeometryShaderInputType(inputType))`
pub(crate) fn input_type_to_glsl_string(input_type: GLenum) -> &'static str {
    match input_type {
        glw::GL_POINTS => "points",
        glw::GL_LINES => "lines",
        glw::GL_LINES_ADJACENCY => "lines_adjacency",
        glw::GL_TRIANGLES => "triangles",
        glw::GL_TRIANGLES_ADJACENCY => "triangles_adjacency",
        other => panic!("unexpected geometry shader input type {other:#x}"),
    }
}

/// `VertexExpanderShader::calcOutputVertices`
pub(crate) fn expander_output_vertices(input_type: GLenum) -> i32 {
    match input_type {
        glw::GL_POINTS => 3,
        glw::GL_LINES => 2 * 3,
        glw::GL_LINES_ADJACENCY => 4 * 3,
        glw::GL_TRIANGLES => 3 * 3,
        glw::GL_TRIANGLES_ADJACENCY => 6 * 3,
        other => panic!("unexpected geometry shader input type {other:#x}"),
    }
}

// ---------------------------------------------------------------------------------------
// negative
// ---------------------------------------------------------------------------------------

/// `NegativeDrawCase::iterate` - a primitive that does not match the geometry shader's
/// input type must fail the draw with `GL_INVALID_OPERATION`.
fn negative_draw_case(case: &mut ApiCase<'_>, input_type: GLenum, input_primitives: GLenum) {
    if !require_geometry_shader(case) {
        return;
    }

    let context = case.context();
    let gl = case.gl();
    let geometry_source = specialize_shader(
        &format!(
            "${{GLSL_VERSION_DECL}}\n${{GLSL_EXT_GEOMETRY_SHADER}}layout({}) in;\nlayout(points, max_vertices = {}) out;\n{}",
            input_type_to_glsl_string(input_type),
            expander_output_vertices(input_type),
            EXPAND_GEOMETRY_BODY
        ),
        context,
    );
    let sources = ProgramSources::default()
        .with(ShaderType::Vertex, specialize_shader(COMMON_VERTEX_SOURCE, context))
        .with(ShaderType::Fragment, specialize_shader(COMMON_FRAGMENT_SOURCE, context))
        .with(ShaderType::Geometry, geometry_source);
    let program = ShaderProgram::new(gl, &sources);
    if !program.is_ok() {
        case.fail("could not build program".to_string(), "could not build program");
        return;
    }

    // SAFETY: NUL-terminated name against the program just built.
    let attr_pos_loc = unsafe { gl.get_attrib_location(program.program(), c"a_position".as_ptr()) } as GLuint;
    let vertex_pos_data: [f32; 4] = [0.0, 0.0, 0.0, 1.0];

    let vao = VertexArray::new(gl);
    let vertex_pos_buf = Buffer::new(gl);

    // SAFETY: names this case generated, an array that outlives the upload, and a program
    // that linked.
    unsafe {
        gl.bind_vertex_array(vao.get());

        gl.bind_buffer(glw::GL_ARRAY_BUFFER, vertex_pos_buf.get());
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            size_of_val(&vertex_pos_data) as GLsizeiptr,
            vertex_pos_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );
        gl.vertex_attrib_pointer(attr_pos_loc, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
        gl.enable_vertex_attrib_array(attr_pos_loc);

        gl.clear_color(0.0, 0.0, 0.0, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);

        gl.viewport(0, 0, 1, 1);

        gl.use_program(program.program());
    }

    // no errors before
    case.expect_no_error("before draw");

    // SAFETY: the mismatched primitive is the point of the case.
    unsafe { gl.draw_arrays(input_primitives, 0, 1) };
    // SAFETY: glGetError needs only a current context.
    let error_code = unsafe { gl.get_error() };
    if error_code != glw::GL_INVALID_OPERATION {
        case.fail(
            format!("Expected GL_INVALID_OPERATION, got {}", glw::error_name(error_code)),
            "Got wrong error code",
        );
    }

    // SAFETY: restoring the bindings.
    unsafe {
        gl.use_program(0);
        gl.disable_vertex_attrib_array(attr_pos_loc);
    }
}

fn negative_group() -> TestCaseGroup {
    struct Conversion {
        input_type: GLenum,
        primitive_type: GLenum,
    }

    const LEGAL_CONVERSIONS: [Conversion; 11] = [
        Conversion {
            input_type: glw::GL_POINTS,
            primitive_type: glw::GL_POINTS,
        },
        Conversion {
            input_type: glw::GL_LINES,
            primitive_type: glw::GL_LINES,
        },
        Conversion {
            input_type: glw::GL_LINES,
            primitive_type: glw::GL_LINE_LOOP,
        },
        Conversion {
            input_type: glw::GL_LINES,
            primitive_type: glw::GL_LINE_STRIP,
        },
        Conversion {
            input_type: glw::GL_LINES_ADJACENCY,
            primitive_type: glw::GL_LINES_ADJACENCY,
        },
        Conversion {
            input_type: glw::GL_LINES_ADJACENCY,
            primitive_type: glw::GL_LINE_STRIP_ADJACENCY,
        },
        Conversion {
            input_type: glw::GL_TRIANGLES,
            primitive_type: glw::GL_TRIANGLES,
        },
        Conversion {
            input_type: glw::GL_TRIANGLES,
            primitive_type: glw::GL_TRIANGLE_STRIP,
        },
        Conversion {
            input_type: glw::GL_TRIANGLES,
            primitive_type: glw::GL_TRIANGLE_FAN,
        },
        Conversion {
            input_type: glw::GL_TRIANGLES_ADJACENCY,
            primitive_type: glw::GL_TRIANGLES_ADJACENCY,
        },
        Conversion {
            input_type: glw::GL_TRIANGLES_ADJACENCY,
            primitive_type: glw::GL_TRIANGLE_STRIP_ADJACENCY,
        },
    ];

    const INPUT_TYPES: [GLenum; 5] = [
        glw::GL_POINTS,
        glw::GL_LINES,
        glw::GL_LINES_ADJACENCY,
        glw::GL_TRIANGLES,
        glw::GL_TRIANGLES_ADJACENCY,
    ];

    const PRIMITIVE_TYPES: [GLenum; 11] = [
        glw::GL_POINTS,
        glw::GL_LINES,
        glw::GL_LINE_LOOP,
        glw::GL_LINE_STRIP,
        glw::GL_LINES_ADJACENCY,
        glw::GL_LINE_STRIP_ADJACENCY,
        glw::GL_TRIANGLES,
        glw::GL_TRIANGLE_STRIP,
        glw::GL_TRIANGLE_FAN,
        glw::GL_TRIANGLES_ADJACENCY,
        glw::GL_TRIANGLE_STRIP_ADJACENCY,
    ];

    let mut group = TestCaseGroup::new("negative");

    for input_type in INPUT_TYPES {
        for primitive_type in PRIMITIVE_TYPES {
            let name = format!(
                "type_{}_primitive_{}",
                input_type_to_glsl_string(input_type),
                primitive_type_to_string(primitive_type)
            );

            let is_legal = LEGAL_CONVERSIONS
                .iter()
                .any(|c| c.input_type == input_type && c.primitive_type == primitive_type);

            // only illegal
            if !is_legal {
                add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
                    negative_draw_case(case, input_type, primitive_type)
                });
            }
        }
    }

    group
}

// ---------------------------------------------------------------------------------------
// query
// ---------------------------------------------------------------------------------------

const PROGRAM_QUERY_VERTEX_SOURCE: &str = "${GLSL_VERSION_DECL}\n\
    void main ()\n\
    {\n\
    \tgl_Position = vec4(0.0, 0.0, 0.0, 0.0);\n\
    }\n";

const PROGRAM_QUERY_FRAGMENT_SOURCE: &str = "${GLSL_VERSION_DECL}\n\
    layout(location = 0) out mediump vec4 fragColor;\n\
    void main ()\n\
    {\n\
    \tfragColor = vec4(0.0, 0.0, 0.0, 0.0);\n\
    }\n";

const PROGRAM_QUERY_GEOMETRY_BODY: &str = "void main ()\n\
    {\n\
    \tgl_Position = vec4(0.0, 0.0, 0.0, 0.0);\n\
    \tEmitVertex();\n\
    }\n";

/// `GeometryProgramQueryCase::ProgramCase`
struct ProgramQueryCase {
    description: &'static str,
    header: &'static str,
    value: i32,
}

/// `GeometryProgramQueryCase::expectProgramValue`
fn expect_program_value(case: &mut ApiCase<'_>, target: GLenum, program: GLuint, value: i32) {
    let mut state = Guarded::<GLint>::new();
    // SAFETY: one integer output, guarded on both sides.
    unsafe { case.gl().get_programiv(program, target, state.as_mut_ptr()) };
    case.expect_no_error("getProgramiv");

    if !state.verify_validity(case) {
        return;
    }

    if state.value() != value {
        case.fail(format!("Expected {value}, got {}", state.value()), "got invalid value");
    }
}

/// `GeometryProgramQueryCase::expectQueryError`
fn expect_query_error(case: &mut ApiCase<'_>, target: GLenum, program: GLuint) {
    let mut unused: GLint = 0;
    // SAFETY: one integer output; the query is expected to be refused.
    let error_code = unsafe {
        case.gl().get_programiv(program, target, &mut unused);
        case.gl().get_error()
    };

    if error_code != glw::GL_INVALID_OPERATION {
        case.fail(
            format!("Expected INVALID_OPERATION, got {}", glw::error_name(error_code)),
            "got unexpected error code",
        );
    }
}

/// `glu::Shader` built by hand: compile one stage and answer its name, or `None` on failure.
fn compile_shader_raw(gl: &glw::Functions, shader_type: GLenum, source: &str) -> Option<GLuint> {
    let c_source = CString::new(source).expect("shader source has no interior NUL");
    // SAFETY: a fresh shader name, a NUL-terminated source that outlives the call.
    unsafe {
        let shader = gl.create_shader(shader_type);
        let ptr = c_source.as_ptr();
        gl.shader_source(shader, 1, &ptr, std::ptr::null());
        gl.compile_shader(shader);

        let mut status: GLint = 0;
        gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut status);
        if status == 0 {
            gl.delete_shader(shader);
            return None;
        }
        Some(shader)
    }
}

/// `GeometryProgramQueryCase::iterate`
fn geometry_program_query_case(case: &mut ApiCase<'_>, target: GLenum, cases: &[ProgramQueryCase]) {
    if !require_geometry_shader(case) {
        return;
    }

    let context = case.context();
    let gl = case.gl();
    let supports_es32 = context.context_type().supports(3, 2);
    let vertex_source = specialize_shader(PROGRAM_QUERY_VERTEX_SOURCE, context);
    let fragment_source = specialize_shader(PROGRAM_QUERY_FRAGMENT_SOURCE, context);

    // default cases
    for program_case in cases {
        log::debug!("Case: {}", program_case.description);
        let geometry_source = format!("{}{}", program_case.header, PROGRAM_QUERY_GEOMETRY_BODY);
        let sources = ProgramSources::default()
            .with(ShaderType::Vertex, vertex_source.clone())
            .with(ShaderType::Fragment, fragment_source.clone())
            .with(ShaderType::Geometry, specialize_shader(&geometry_source, context));
        let program = ShaderProgram::new(gl, &sources);

        expect_program_value(case, target, program.program(), program_case.value);
    }

    // no geometry shader -case (INVALID OP)
    {
        let sources = ProgramSources::default()
            .with(ShaderType::Vertex, vertex_source.clone())
            .with(ShaderType::Fragment, fragment_source.clone());
        let program = ShaderProgram::new(gl, &sources);

        expect_query_error(case, target, program.program());
    }

    // not linked -case (INVALID OP)
    {
        let geometry_source = format!(
            "{}\n{}layout (triangles) in;\nlayout (points, max_vertices = 3) out;\n{}",
            context.context_type().glsl_version().declaration(),
            if supports_es32 {
                ""
            } else {
                "#extension GL_EXT_geometry_shader : require\n"
            },
            PROGRAM_QUERY_GEOMETRY_BODY
        );

        let vertex_shader = compile_shader_raw(gl, glw::GL_VERTEX_SHADER, &vertex_source);
        let fragment_shader = compile_shader_raw(gl, glw::GL_FRAGMENT_SHADER, &fragment_source);
        let geometry_shader = compile_shader_raw(gl, glw::GL_GEOMETRY_SHADER, &geometry_source);

        let (Some(vertex_shader), Some(fragment_shader), Some(geometry_shader)) =
            (vertex_shader, fragment_shader, geometry_shader)
        else {
            // `throw tcu::TestError("Failed to compile shader")`
            case.fail("Failed to compile shader".to_string(), "Failed to compile shader");
            return;
        };

        // SAFETY: names created above; the program is deliberately never linked.
        let program = unsafe {
            let program = gl.create_program();
            gl.attach_shader(program, vertex_shader);
            gl.attach_shader(program, fragment_shader);
            gl.attach_shader(program, geometry_shader);
            program
        };

        expect_query_error(case, target, program);

        // SAFETY: the names created above.
        unsafe {
            gl.delete_program(program);
            gl.delete_shader(vertex_shader);
            gl.delete_shader(fragment_shader);
            gl.delete_shader(geometry_shader);
        }
    }
}

const SHADER_INVOCATIONS_CASES: [ProgramQueryCase; 2] = [
    ProgramQueryCase {
        description: "Default value",
        header: "${GLSL_VERSION_DECL}\n${GLSL_EXT_GEOMETRY_SHADER}layout (triangles) in;\nlayout (points, max_vertices = 3) out;\n",
        value: 1,
    },
    ProgramQueryCase {
        description: "Value declared",
        header: "${GLSL_VERSION_DECL}\n${GLSL_EXT_GEOMETRY_SHADER}layout (triangles, invocations=2) in;\nlayout (points, max_vertices = 3) out;\n",
        value: 2,
    },
];

const SHADER_VERTICES_CASES: [ProgramQueryCase; 1] = [ProgramQueryCase {
    description: "max_vertices = 1",
    header: "${GLSL_VERSION_DECL}\n${GLSL_EXT_GEOMETRY_SHADER}layout (triangles) in;\nlayout (points, max_vertices = 1) out;\n",
    value: 1,
}];

const SHADER_INPUT_CASES: [ProgramQueryCase; 3] = [
    ProgramQueryCase {
        description: "Triangles",
        header: "${GLSL_VERSION_DECL}\n${GLSL_EXT_GEOMETRY_SHADER}layout (triangles) in;\nlayout (points, max_vertices = 3) out;\n",
        value: glw::GL_TRIANGLES as i32,
    },
    ProgramQueryCase {
        description: "Lines",
        header: "${GLSL_VERSION_DECL}\n${GLSL_EXT_GEOMETRY_SHADER}layout (lines) in;\nlayout (points, max_vertices = 3) out;\n",
        value: glw::GL_LINES as i32,
    },
    ProgramQueryCase {
        description: "Points",
        header: "${GLSL_VERSION_DECL}\n${GLSL_EXT_GEOMETRY_SHADER}layout (points) in;\nlayout (points, max_vertices = 3) out;\n",
        value: glw::GL_POINTS as i32,
    },
];

const SHADER_OUTPUT_CASES: [ProgramQueryCase; 3] = [
    ProgramQueryCase {
        description: "Triangle strip",
        header: "${GLSL_VERSION_DECL}\n${GLSL_EXT_GEOMETRY_SHADER}layout (triangles) in;\nlayout (triangle_strip, max_vertices = 3) out;\n",
        value: glw::GL_TRIANGLE_STRIP as i32,
    },
    ProgramQueryCase {
        description: "Lines",
        header: "${GLSL_VERSION_DECL}\n${GLSL_EXT_GEOMETRY_SHADER}layout (triangles) in;\nlayout (line_strip, max_vertices = 3) out;\n",
        value: glw::GL_LINE_STRIP as i32,
    },
    ProgramQueryCase {
        description: "Points",
        header: "${GLSL_VERSION_DECL}\n${GLSL_EXT_GEOMETRY_SHADER}layout (triangles) in;\nlayout (points, max_vertices = 3) out;\n",
        value: glw::GL_POINTS as i32,
    },
];

/// `ImplementationLimitCase::iterate`
fn implementation_limit_case(case: &mut ApiCase<'_>, target: GLenum, min_value: i32) {
    if !require_geometry_shader(case) {
        return;
    }

    verify_state_integer_min(case, target, min_value, QueryType::Integer);

    case.section("Alternative queries");
    verify_state_integer_min(case, target, min_value, QueryType::Boolean);
    verify_state_integer_min(case, target, min_value, QueryType::Integer64);
    verify_state_integer_min(case, target, min_value, QueryType::Float);
}

/// `GeometryProgramLimitCase::iterate`
fn geometry_program_limit_case(case: &mut ApiCase<'_>, api_name: GLenum, glsl_name: &str, min_limit: i32) {
    if !require_geometry_shader(case) {
        return;
    }

    let context = case.context();
    let gl = case.gl();

    // query limit
    let limit = {
        let mut state = Guarded::<GLint>::new();
        // SAFETY: one integer output, guarded on both sides.
        unsafe { gl.get_integerv(api_name, state.as_mut_ptr()) };
        case.expect_no_error("getIntegerv()");

        if !state.verify_validity(case) {
            return;
        }

        if state.value() < min_limit {
            case.fail(
                format!("Minimum value = {min_limit}, got {}", state.value()),
                "Minimum value check failed",
            );
            return;
        }

        let limit = state.value();

        // verify other getters
        case.section("Alternative queries");
        verify_state_integer(case, api_name, limit, QueryType::Boolean);
        verify_state_integer(case, api_name, limit, QueryType::Integer64);
        verify_state_integer(case, api_name, limit, QueryType::Float);
        limit
    };

    // verify limit is the same in GLSL
    let vertex_source = "${GLSL_VERSION_DECL}\n\
        void main ()\n\
        {\n\
        \tgl_Position = vec4(0.0, 0.0, 0.0, 0.0);\n\
        }\n";
    let fragment_source = "${GLSL_VERSION_DECL}\n\
        layout(location = 0) out mediump vec4 fragColor;\n\
        void main ()\n\
        {\n\
        \tfragColor = vec4(0.0, 0.0, 0.0, 0.0);\n\
        }\n";
    let geometry_source = format!(
        "${{GLSL_VERSION_DECL}}\n\
         ${{GLSL_EXT_GEOMETRY_SHADER}}\
         layout(points) in;\n\
         layout(points, max_vertices = 1) out;\n\
         void main ()\n\
         {{\n\
         \t// Building the shader will fail if the constant value is not the expected\n\
         \tconst mediump int cArraySize = (gl_{glsl_name} == {limit}) ? (1) : (-1);\n\
         \tfloat[cArraySize] fArray;\n\
         \tfArray[0] = 0.0f;\n\
         \tgl_Position = vec4(0.0, 0.0, 0.0, fArray[0]);\n\
         \tEmitVertex();\n\
         }}\n"
    );

    let sources = ProgramSources::default()
        .with(ShaderType::Vertex, specialize_shader(vertex_source, context))
        .with(ShaderType::Fragment, specialize_shader(fragment_source, context))
        .with(ShaderType::Geometry, specialize_shader(&geometry_source, context));
    let program = ShaderProgram::new(gl, &sources);

    if !program.is_ok() {
        // compile failed, assume static assert failed
        case.fail("Shader build failed".to_string(), "Shader build failed");
    }
}

/// `LayerProvokingVertexQueryCase::iterate`
fn layer_provoking_vertex_query_case(case: &mut ApiCase<'_>) {
    if !require_geometry_shader(case) {
        return;
    }

    let Some(QueriedState::Integer(value)) = query_state(case, QueryType::Integer, glw::GL_LAYER_PROVOKING_VERTEX)
    else {
        return;
    };
    let value = value as GLenum;

    // This port only creates ES contexts, so upstream's `core(3, 2)` branch (which also
    // accepts `GL_PROVOKING_VERTEX`) cannot be reached.
    if value != glw::GL_FIRST_VERTEX_CONVENTION
        && value != glw::GL_LAST_VERTEX_CONVENTION
        && value != glw::GL_UNDEFINED_VERTEX
    {
        case.fail(
            format!("getInteger(GL_LAYER_PROVOKING_VERTEX) returned illegal value. Got {value}\nExpected any of {{FIRST_VERTEX_CONVENTION, LAST_VERTEX_CONVENTION, UNDEFINED_VERTEX}}."),
            "got unexpected provoking vertex value",
        );
    }

    case.section("Alternative queries");
    verify_state_integer(case, glw::GL_LAYER_PROVOKING_VERTEX, value as i32, QueryType::Boolean);
    verify_state_integer(case, glw::GL_LAYER_PROVOKING_VERTEX, value as i32, QueryType::Integer64);
    verify_state_integer(case, glw::GL_LAYER_PROVOKING_VERTEX, value as i32, QueryType::Float);
}

/// `PrimitivesGeneratedQueryCase::QueryTest`
#[derive(Clone, Copy, PartialEq, Eq)]
enum PrimitivesGeneratedTest {
    NoGeometry,
    NoAmplification,
    Amplification,
    PartialPrimitives,
    Instanced,
}

/// `PrimitivesGeneratedQueryCase::genProgram`
fn primitives_generated_program<'gl>(context: &'gl Context, test: PrimitivesGeneratedTest) -> ShaderProgram<'gl> {
    let vertex_source = "${GLSL_VERSION_DECL}\n\
        in highp vec4 a_position;\n\
        in highp vec4 a_one;\n\
        out highp vec4 v_one;\n\
        void main (void)\n\
        {\n\
        \tgl_Position = a_position;\n\
        \tv_one = a_one;\n\
        }\n";
    let fragment_source = "${GLSL_VERSION_DECL}\n\
        layout(location = 0) out mediump vec4 fragColor;\n\
        void main (void)\n\
        {\n\
        \tfragColor = vec4(1.0, 1.0, 1.0, 1.0);\n\
        }\n";

    let mut sources = ProgramSources::default()
        .with(ShaderType::Vertex, specialize_shader(vertex_source, context))
        .with(ShaderType::Fragment, specialize_shader(fragment_source, context));

    if test != PrimitivesGeneratedTest::NoGeometry {
        let mut geometry_source = format!(
            "${{GLSL_VERSION_DECL}}\n\
             ${{GLSL_EXT_GEOMETRY_SHADER}}\
             layout(points{}) in;\n\
             layout(triangle_strip, max_vertices = 7) out;\n\
             in highp vec4 v_one[];\n\
             void main (void)\n\
             {{\n\
             \t// always taken\n\
             \tif (v_one[0].x != 0.0)\n\
             \t{{\n\
             \t\tgl_Position = gl_in[0].gl_Position + vec4(0.0, 0.1, 0.0, 0.0);\n\
             \t\tEmitVertex();\n\
             \t\tgl_Position = gl_in[0].gl_Position + vec4(0.1, 0.0, 0.0, 0.0);\n\
             \t\tEmitVertex();\n\
             \t\tgl_Position = gl_in[0].gl_Position - vec4(0.1, 0.0, 0.0, 0.0);\n\
             \t\tEmitVertex();\n\
             \t\tEndPrimitive();\n\
             \t}}\n",
            if test == PrimitivesGeneratedTest::Instanced {
                ", invocations = 3"
            } else {
                ""
            }
        );

        match test {
            PrimitivesGeneratedTest::Amplification => geometry_source.push_str(
                "\n\
                 \t// always taken\n\
                 \tif (v_one[0].y != 0.0)\n\
                 \t{\n\
                 \t\tgl_Position = gl_in[0].gl_Position + vec4(0.0, 0.1, 0.0, 0.0);\n\
                 \t\tEmitVertex();\n\
                 \t\tgl_Position = gl_in[0].gl_Position + vec4(0.1, 0.0, 0.0, 0.0);\n\
                 \t\tEmitVertex();\n\
                 \t\tgl_Position = gl_in[0].gl_Position - vec4(0.0, 0.1, 0.0, 0.0);\n\
                 \t\tEmitVertex();\n\
                 \t\tgl_Position = gl_in[0].gl_Position - vec4(0.1, 0.0, 0.0, 0.0);\n\
                 \t\tEmitVertex();\n\
                 \t}\n",
            ),
            PrimitivesGeneratedTest::PartialPrimitives => geometry_source.push_str(
                "\n\
                 \t// always taken\n\
                 \tif (v_one[0].y != 0.0)\n\
                 \t{\n\
                 \t\tgl_Position = gl_in[0].gl_Position + vec4(0.0, 0.1, 0.0, 0.0);\n\
                 \t\tEmitVertex();\n\
                 \t\tgl_Position = gl_in[0].gl_Position + vec4(0.1, 0.0, 0.0, 0.0);\n\
                 \t\tEmitVertex();\n\
                 \n\
                 \t\t// never taken\n\
                 \t\tif (v_one[0].z < 0.0)\n\
                 \t\t{\n\
                 \t\t\tgl_Position = gl_in[0].gl_Position - vec4(0.1, 0.0, 0.0, 0.0);\n\
                 \t\t\tEmitVertex();\n\
                 \t\t}\n\
                 \t}\n",
            ),
            PrimitivesGeneratedTest::Instanced => geometry_source.push_str(
                "\n\
                 \t// taken once\n\
                 \tif (v_one[0].y > float(gl_InvocationID) + 0.5)\n\
                 \t{\n\
                 \t\tgl_Position = gl_in[0].gl_Position + vec4(0.0, 0.1, 0.0, 0.0);\n\
                 \t\tEmitVertex();\n\
                 \t\tgl_Position = gl_in[0].gl_Position + vec4(0.1, 0.0, 0.0, 0.0);\n\
                 \t\tEmitVertex();\n\
                 \t\tgl_Position = gl_in[0].gl_Position - vec4(0.1, 0.0, 0.0, 0.0);\n\
                 \t\tEmitVertex();\n\
                 \t}\n",
            ),
            PrimitivesGeneratedTest::NoGeometry | PrimitivesGeneratedTest::NoAmplification => {}
        }

        geometry_source.push_str("}\n");
        sources = sources.with(ShaderType::Geometry, specialize_shader(&geometry_source, context));
    }

    ShaderProgram::new(context.gl(), &sources)
}

/// `PrimitivesGeneratedQueryCase::iterate`
fn primitives_generated_query_case(case: &mut ApiCase<'_>, test: PrimitivesGeneratedTest) {
    if !require_geometry_shader(case) {
        return;
    }

    let program = primitives_generated_program(case.context(), test);
    if !program.is_ok() {
        case.fail("could not build program".to_string(), "could not build program");
        return;
    }

    let gl = case.gl();
    let mut primitives_generated: GLuint = 0xDEBADBAD;

    #[rustfmt::skip]
    let vertex_data: [[f32; 4]; 16] = [
        [0.0, 0.0, 0.0, 1.0], [1.0, 1.0, 1.0, 1.0],
        [0.1, 0.0, 0.0, 1.0], [1.0, 1.0, 1.0, 1.0],
        [0.2, 0.0, 0.0, 1.0], [1.0, 1.0, 1.0, 1.0],
        [0.3, 0.0, 0.0, 1.0], [1.0, 1.0, 1.0, 1.0],
        [0.4, 0.0, 0.0, 1.0], [1.0, 1.0, 1.0, 1.0],
        [0.5, 0.0, 0.0, 1.0], [1.0, 1.0, 1.0, 1.0],
        [0.6, 0.0, 0.0, 1.0], [1.0, 1.0, 1.0, 1.0],
        [0.7, 0.0, 0.0, 1.0], [1.0, 1.0, 1.0, 1.0],
    ];

    let vao = VertexArray::new(gl);
    let buffer = Buffer::new(gl);
    let mut query: GLuint = 0;
    // SAFETY: one query name of output, and NUL-terminated attribute names against a linked program.
    let (position_location, one_location) = unsafe {
        gl.gen_queries(1, &mut query);
        (
            gl.get_attrib_location(program.program(), c"a_position".as_ptr()),
            gl.get_attrib_location(program.program(), c"a_one".as_ptr()),
        )
    };

    // SAFETY: names this case generated, an array that outlives the upload, and a linked program.
    unsafe {
        gl.bind_vertex_array(vao.get());

        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer.get());
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            size_of_val(&vertex_data) as GLsizeiptr,
            vertex_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );

        let stride = 2 * size_of::<[f32; 4]>() as i32;
        gl.vertex_attrib_pointer(
            position_location as GLuint,
            4,
            glw::GL_FLOAT,
            glw::FALSE,
            stride,
            std::ptr::null(),
        );
        gl.enable_vertex_attrib_array(position_location as GLuint);

        if one_location != -1 {
            gl.vertex_attrib_pointer(
                one_location as GLuint,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                stride,
                size_of::<[f32; 4]>() as *const c_void,
            );
            gl.enable_vertex_attrib_array(one_location as GLuint);
        }

        gl.use_program(program.program());
    }
    case.expect_no_error("setup render");

    // SAFETY: the query and program set up above.
    unsafe {
        gl.begin_query(glw::GL_PRIMITIVES_GENERATED, query);
        gl.draw_arrays(glw::GL_POINTS, 0, 8);
        gl.end_query(glw::GL_PRIMITIVES_GENERATED);
    }
    case.expect_no_error("render and query");

    // SAFETY: one unsigned integer of output.
    unsafe { gl.get_query_objectuiv(query, glw::GL_QUERY_RESULT, &mut primitives_generated) };
    case.expect_no_error("get query result");

    let expected_generated = match test {
        PrimitivesGeneratedTest::Amplification => 3 * 8,
        PrimitivesGeneratedTest::Instanced => 8 * (3 + 1),
        _ => 8,
    };

    if expected_generated != primitives_generated {
        case.fail(
            format!("Got unexpected result for GL_PRIMITIVES_GENERATED. Expected {expected_generated}, got {primitives_generated}"),
            "got wrong result for GL_PRIMITIVES_GENERATED",
        );
    }

    // SAFETY: the query created above.
    unsafe { gl.delete_queries(1, &query) };
}

/// `GL_CURRENT_QUERY` for `GL_PRIMITIVES_GENERATED` (`verifyStateQueryInteger` with `QUERY_QUERY`).
fn verify_current_query(case: &mut ApiCase<'_>, expected: GLuint) {
    let mut state = Guarded::<GLint>::new();
    // SAFETY: one integer output, guarded on both sides.
    unsafe {
        case.gl()
            .get_queryiv(glw::GL_PRIMITIVES_GENERATED, glw::GL_CURRENT_QUERY, state.as_mut_ptr())
    };
    case.expect_no_error("glGetQueryiv");

    if state.verify_validity(case) && state.value() as GLuint != expected {
        case.fail(
            format!("Expected {expected}, got {}", state.value()),
            "got invalid value",
        );
    }
}

/// `PrimitivesGeneratedQueryObjectQueryCase::iterate`
fn primitives_generated_query_object_query_case(case: &mut ApiCase<'_>) {
    if !require_geometry_shader(case) {
        return;
    }

    let gl = case.gl();
    let mut query: GLuint = 0;

    verify_current_query(case, 0);

    // SAFETY: one query name of output.
    unsafe { gl.gen_queries(1, &mut query) };
    case.expect_no_error("glGenQueries");

    // SAFETY: the query just generated.
    unsafe { gl.begin_query(glw::GL_PRIMITIVES_GENERATED, query) };
    case.expect_no_error("beginQuery");

    verify_current_query(case, query);

    // SAFETY: ends the query begun above.
    unsafe { gl.end_query(glw::GL_PRIMITIVES_GENERATED) };
    case.expect_no_error("endQuery");

    // SAFETY: the query created above.
    unsafe { gl.delete_queries(1, &query) };
}

/// `FramebufferDefaultLayersCase::iterate`
fn framebuffer_default_layers_case(case: &mut ApiCase<'_>) {
    if !require_geometry_shader(case) {
        return;
    }

    let gl = case.gl();

    {
        case.section("Default value");
        let fbo = Framebuffer::new(gl);
        let mut default_layers: GLint = -1;

        // SAFETY: a framebuffer name this case generated, one integer of output.
        unsafe {
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo.get());
            gl.get_framebuffer_parameteriv(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_FRAMEBUFFER_DEFAULT_LAYERS,
                &mut default_layers,
            );
        }
        case.expect_no_error("getFramebufferParameteriv");

        if default_layers != 0 {
            case.fail(
                format!("Error, expected 0, got {default_layers}"),
                "invalid layer count",
            );
        }
    }

    {
        case.section("Set default layers to 12");
        let fbo = Framebuffer::new(gl);
        let mut default_layers: GLint = -1;

        // SAFETY: a framebuffer name this case generated, one integer of output.
        unsafe {
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo.get());
            gl.framebuffer_parameteri(glw::GL_DRAW_FRAMEBUFFER, glw::GL_FRAMEBUFFER_DEFAULT_LAYERS, 12);
            gl.get_framebuffer_parameteriv(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_FRAMEBUFFER_DEFAULT_LAYERS,
                &mut default_layers,
            );
        }
        case.expect_no_error("getFramebufferParameteriv");

        if default_layers != 12 {
            case.fail(
                format!("Error, expected 12, got {default_layers}"),
                "invalid layer count",
            );
        }
    }
}

/// Allocates a 32x32x32 RGBA8 texture with nearest filtering on `target`.
fn tex_image_3d_nearest(gl: &glw::Functions, target: GLenum, texture: GLuint) {
    // SAFETY: a texture name the caller generated.
    unsafe {
        gl.bind_texture(target, texture);
        gl.tex_image_3d(
            target,
            0,
            glw::GL_RGBA8 as i32,
            32,
            32,
            32,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            std::ptr::null(),
        );
        gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
        gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
    }
}

/// `FramebufferAttachmentLayeredCase::iterate`
fn framebuffer_attachment_layered_case(case: &mut ApiCase<'_>) {
    if !require_geometry_shader(case) {
        return;
    }

    #[derive(Clone, Copy, PartialEq, Eq)]
    enum CaseType {
        Texture3D,
        Texture2DArray,
        TextureCube,
        Texture2DMsArray,
        Texture3DLayer,
        Texture2DArrayLayer,
    }

    const TEXTURE_TYPES: [(&str, bool, CaseType); 6] = [
        ("3D texture", true, CaseType::Texture3D),
        ("2D array", true, CaseType::Texture2DArray),
        ("Cube map", true, CaseType::TextureCube),
        ("2D multisample array", true, CaseType::Texture2DMsArray),
        ("3D texture layer ", false, CaseType::Texture3DLayer),
        ("2D array layer ", false, CaseType::Texture2DArrayLayer),
    ];

    let context = case.context();
    let gl = case.gl();

    for (description, expect_layered, texture_type) in TEXTURE_TYPES {
        case.section(description);
        let fbo = Framebuffer::new(gl);
        let texture = Texture::new(gl);
        let mut layered: GLint = -1;

        // SAFETY: a framebuffer name this case generated.
        unsafe { gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo.get()) };

        match texture_type {
            CaseType::Texture3D | CaseType::Texture3DLayer => {
                tex_image_3d_nearest(gl, glw::GL_TEXTURE_3D, texture.get());

                // SAFETY: the texture and framebuffer set up above.
                unsafe {
                    if texture_type == CaseType::Texture3D {
                        gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, texture.get(), 0);
                    } else {
                        gl.framebuffer_texture_layer(
                            glw::GL_DRAW_FRAMEBUFFER,
                            glw::GL_COLOR_ATTACHMENT0,
                            texture.get(),
                            0,
                            2,
                        );
                    }
                }
            }
            CaseType::Texture2DArray | CaseType::Texture2DArrayLayer => {
                tex_image_3d_nearest(gl, glw::GL_TEXTURE_2D_ARRAY, texture.get());

                // SAFETY: the texture and framebuffer set up above.
                unsafe {
                    if texture_type == CaseType::Texture2DArray {
                        gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, texture.get(), 0);
                    } else {
                        gl.framebuffer_texture_layer(
                            glw::GL_DRAW_FRAMEBUFFER,
                            glw::GL_COLOR_ATTACHMENT0,
                            texture.get(),
                            0,
                            3,
                        );
                    }
                }
            }
            CaseType::TextureCube => {
                // SAFETY: the texture and framebuffer set up above.
                unsafe {
                    gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture.get());
                    for face in 0..6 {
                        gl.tex_image_2d(
                            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X + face,
                            0,
                            glw::GL_RGBA8 as i32,
                            32,
                            32,
                            0,
                            glw::GL_RGBA,
                            glw::GL_UNSIGNED_BYTE,
                            std::ptr::null(),
                        );
                    }
                    gl.tex_parameteri(
                        glw::GL_TEXTURE_CUBE_MAP,
                        glw::GL_TEXTURE_MAG_FILTER,
                        glw::GL_NEAREST as i32,
                    );
                    gl.tex_parameteri(
                        glw::GL_TEXTURE_CUBE_MAP,
                        glw::GL_TEXTURE_MIN_FILTER,
                        glw::GL_NEAREST as i32,
                    );
                    gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, texture.get(), 0);
                }
            }
            CaseType::Texture2DMsArray => {
                let support_es32 = context.context_type().supports(3, 2);

                // check extension
                if !(support_es32
                    && context
                        .context_info
                        .is_extension_supported("GL_OES_texture_storage_multisample_2d_array"))
                {
                    log::debug!(
                        "Context is not equal or greather than 3.2 and GL_OES_texture_storage_multisample_2d_array not supported, skipping."
                    );
                    continue;
                }

                // SAFETY: the texture and framebuffer set up above.
                unsafe {
                    gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, texture.get());
                    gl.tex_storage_3d_multisample(
                        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
                        1,
                        glw::GL_RGBA8,
                        32,
                        32,
                        32,
                        glw::FALSE,
                    );
                    gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, texture.get(), 0);
                }
            }
        }

        case.expect_no_error("setup attachment");

        // SAFETY: one integer of output.
        unsafe {
            gl.get_framebuffer_attachment_parameteriv(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_FRAMEBUFFER_ATTACHMENT_LAYERED,
                &mut layered,
            );
        }
        case.expect_no_error("getFramebufferParameteriv");

        if layered != glw::GL_TRUE as GLint && layered != glw::GL_FALSE as GLint {
            case.fail(format!("Error, expected boolean, got {layered}"), "invalid boolean");
        } else if (layered == glw::GL_TRUE as GLint) != expect_layered {
            case.fail(
                format!(
                    "Error, expected {}, got {layered}",
                    if expect_layered { "GL_TRUE" } else { "GL_FALSE" }
                ),
                "invalid layer count",
            );
        }
    }
}

/// `FramebufferIncompleteLayereTargetsCase::iterate`
fn framebuffer_incomplete_layer_targets_case(case: &mut ApiCase<'_>) {
    if !require_geometry_shader(case) {
        return;
    }

    let gl = case.gl();

    // Layered and non-layered
    {
        case.section("Layered and non-layered");
        let fbo = Framebuffer::new(gl);
        let texture0 = Texture::new(gl);
        let texture1 = Texture::new(gl);

        tex_image_3d_nearest(gl, glw::GL_TEXTURE_2D_ARRAY, texture0.get());
        tex_image_3d_nearest(gl, glw::GL_TEXTURE_2D_ARRAY, texture1.get());

        // SAFETY: names this case generated.
        unsafe {
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo.get());
            gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, texture0.get(), 0);
            gl.framebuffer_texture_layer(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT1,
                texture1.get(),
                0,
                0,
            );
        }
        case.expect_no_error("setup fbo");

        // SAFETY: a complete or incomplete framebuffer is equally answerable.
        let fbo_status = unsafe { gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) };
        if fbo_status != glw::GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS {
            case.fail(
                format!("Error, expected GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS, got {fbo_status:#x}"),
                "invalid layer count",
            );
        }
    }

    // Different target
    {
        case.section("Different target");
        let fbo = Framebuffer::new(gl);
        let texture0 = Texture::new(gl);
        let texture1 = Texture::new(gl);

        tex_image_3d_nearest(gl, glw::GL_TEXTURE_2D_ARRAY, texture0.get());
        tex_image_3d_nearest(gl, glw::GL_TEXTURE_3D, texture1.get());

        // SAFETY: names this case generated.
        unsafe {
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo.get());
            gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, texture0.get(), 0);
            gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT1, texture1.get(), 0);
        }
        case.expect_no_error("setup fbo");

        // SAFETY: a complete or incomplete framebuffer is equally answerable.
        let fbo_status = unsafe { gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) };
        if fbo_status != glw::GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS {
            case.fail(
                format!("Error, expected GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS, got {fbo_status:#x}"),
                "invalid layer count",
            );
        }
    }
}

/// `ReferencedByGeometryShaderCase::iterate`
fn referenced_by_geometry_shader_case(case: &mut ApiCase<'_>) {
    if !require_geometry_shader(case) {
        return;
    }

    let context = case.context();
    let gl = case.gl();
    let vertex_source = "${GLSL_VERSION_DECL}\n\
        uniform highp vec4 u_position;\n\
        void main (void)\n\
        {\n\
        \tgl_Position = u_position;\n\
        }\n";
    let fragment_source = "${GLSL_VERSION_DECL}\n\
        layout(location = 0) out mediump vec4 fragColor;\n\
        void main (void)\n\
        {\n\
        \tfragColor = vec4(1.0, 1.0, 1.0, 1.0);\n\
        }\n";
    let geometry_source = "${GLSL_VERSION_DECL}\n\
        ${GLSL_EXT_GEOMETRY_SHADER}\
        layout(points) in;\n\
        layout(points, max_vertices=1) out;\n\
        uniform highp vec4 u_offset;\n\
        void main (void)\n\
        {\n\
        \tgl_Position = gl_in[0].gl_Position + u_offset;\n\
        \tEmitVertex();\n\
        }\n";

    let sources = ProgramSources::default()
        .with(ShaderType::Vertex, specialize_shader(vertex_source, context))
        .with(ShaderType::Fragment, specialize_shader(fragment_source, context))
        .with(ShaderType::Geometry, specialize_shader(geometry_source, context));
    let program = ShaderProgram::new(gl, &sources);

    case.section("Referenced uniform u_offset");
    let props: [GLenum; 1] = [glw::GL_REFERENCED_BY_GEOMETRY_SHADER];
    let mut length: i32 = 0;
    let mut referenced: GLint = 0;

    // SAFETY: a NUL-terminated name, one property and one answer of room.
    let resource_pos =
        unsafe { gl.get_program_resource_index(program.program(), glw::GL_UNIFORM, c"u_offset".as_ptr()) };
    // SAFETY: as above.
    unsafe {
        gl.get_program_resourceiv(
            program.program(),
            glw::GL_UNIFORM,
            resource_pos,
            1,
            props.as_ptr(),
            1,
            &raw mut length,
            &raw mut referenced,
        );
    }
    case.expect_no_error("query resource");

    if length == 0 || referenced != glw::GL_TRUE as GLint {
        case.fail("Error, expected GL_TRUE.".to_string(), "got unexpected value");
    }
}

/// `CombinedGeometryUniformLimitCase::iterate`
fn combined_geometry_uniform_limit_case(case: &mut ApiCase<'_>) {
    if !require_geometry_shader(case) {
        return;
    }

    let gl = case.gl();
    let guarded = |case: &mut ApiCase<'_>, target: GLenum| -> Option<GLint> {
        let mut state = Guarded::<GLint>::new();
        // SAFETY: one integer output, guarded on both sides.
        unsafe { gl.get_integerv(target, state.as_mut_ptr()) };
        case.expect_no_error("glGetIntegerv");
        if state.verify_validity(case) {
            Some(state.value())
        } else {
            None
        }
    };

    let max_uniform_blocks = guarded(case, glw::GL_MAX_GEOMETRY_UNIFORM_BLOCKS);
    let max_uniform_block_size = guarded(case, glw::GL_MAX_UNIFORM_BLOCK_SIZE);
    let max_uniform_components = guarded(case, glw::GL_MAX_GEOMETRY_UNIFORM_COMPONENTS);

    let (Some(blocks), Some(block_size), Some(components)) =
        (max_uniform_blocks, max_uniform_block_size, max_uniform_components)
    else {
        return;
    };

    let limit = i64::from(blocks) * i64::from(block_size) / 4 + i64::from(components);
    let limit = i32::try_from(limit).unwrap_or(i32::MAX);

    verify_state_integer_min(
        case,
        glw::GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS,
        limit,
        QueryType::Integer,
    );

    case.section("Alternative queries");
    verify_state_integer_min(
        case,
        glw::GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS,
        limit,
        QueryType::Boolean,
    );
    verify_state_integer_min(
        case,
        glw::GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS,
        limit,
        QueryType::Integer64,
    );
    verify_state_integer_min(
        case,
        glw::GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS,
        limit,
        QueryType::Float,
    );
}

fn query_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("query");

    // limits with a corresponding glsl constant
    const PROGRAM_LIMITS: [(&str, GLenum, &str, i32); 9] = [
        (
            "max_geometry_input_components",
            glw::GL_MAX_GEOMETRY_INPUT_COMPONENTS,
            "MaxGeometryInputComponents",
            64,
        ),
        (
            "max_geometry_output_components",
            glw::GL_MAX_GEOMETRY_OUTPUT_COMPONENTS,
            "MaxGeometryOutputComponents",
            64,
        ),
        (
            "max_geometry_image_uniforms",
            glw::GL_MAX_GEOMETRY_IMAGE_UNIFORMS,
            "MaxGeometryImageUniforms",
            0,
        ),
        (
            "max_geometry_texture_image_units",
            glw::GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS,
            "MaxGeometryTextureImageUnits",
            16,
        ),
        (
            "max_geometry_output_vertices",
            glw::GL_MAX_GEOMETRY_OUTPUT_VERTICES,
            "MaxGeometryOutputVertices",
            256,
        ),
        (
            "max_geometry_total_output_components",
            glw::GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS,
            "MaxGeometryTotalOutputComponents",
            1024,
        ),
        (
            "max_geometry_uniform_components",
            glw::GL_MAX_GEOMETRY_UNIFORM_COMPONENTS,
            "MaxGeometryUniformComponents",
            1024,
        ),
        (
            "max_geometry_atomic_counters",
            glw::GL_MAX_GEOMETRY_ATOMIC_COUNTERS,
            "MaxGeometryAtomicCounters",
            0,
        ),
        (
            "max_geometry_atomic_counter_buffers",
            glw::GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS,
            "MaxGeometryAtomicCounterBuffers",
            0,
        ),
    ];
    for (name, api_name, glsl_name, limit) in PROGRAM_LIMITS {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            geometry_program_limit_case(case, api_name, glsl_name, limit)
        });
    }

    // program queries
    add_api_case(&mut group, "geometry_linked_vertices_out", |case: &mut ApiCase<'_>| {
        geometry_program_query_case(case, glw::GL_GEOMETRY_LINKED_VERTICES_OUT_EXT, &SHADER_VERTICES_CASES);
    });
    add_api_case(&mut group, "geometry_linked_input_type", |case: &mut ApiCase<'_>| {
        geometry_program_query_case(case, glw::GL_GEOMETRY_LINKED_INPUT_TYPE_EXT, &SHADER_INPUT_CASES);
    });
    add_api_case(&mut group, "geometry_linked_output_type", |case: &mut ApiCase<'_>| {
        geometry_program_query_case(case, glw::GL_GEOMETRY_LINKED_OUTPUT_TYPE_EXT, &SHADER_OUTPUT_CASES);
    });
    add_api_case(&mut group, "geometry_shader_invocations", |case: &mut ApiCase<'_>| {
        geometry_program_query_case(case, glw::GL_GEOMETRY_SHADER_INVOCATIONS, &SHADER_INVOCATIONS_CASES);
    });

    // limits
    for (name, target, min_value) in [
        (
            "max_geometry_shader_invocations",
            glw::GL_MAX_GEOMETRY_SHADER_INVOCATIONS,
            32,
        ),
        ("max_geometry_uniform_blocks", glw::GL_MAX_GEOMETRY_UNIFORM_BLOCKS, 12),
        (
            "max_geometry_shader_storage_blocks",
            glw::GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS,
            0,
        ),
    ] {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            implementation_limit_case(case, target, min_value)
        });
    }

    // layer_provoking_vertex_ext
    add_api_case(&mut group, "layer_provoking_vertex", layer_provoking_vertex_query_case);

    // primitives_generated
    for (name, test) in [
        ("primitives_generated_no_geometry", PrimitivesGeneratedTest::NoGeometry),
        (
            "primitives_generated_no_amplification",
            PrimitivesGeneratedTest::NoAmplification,
        ),
        (
            "primitives_generated_amplification",
            PrimitivesGeneratedTest::Amplification,
        ),
        (
            "primitives_generated_partial_primitives",
            PrimitivesGeneratedTest::PartialPrimitives,
        ),
        ("primitives_generated_instanced", PrimitivesGeneratedTest::Instanced),
    ] {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            primitives_generated_query_case(case, test)
        });
    }

    add_api_case(
        &mut group,
        "primitives_generated",
        primitives_generated_query_object_query_case,
    );

    // fbo
    add_api_case(&mut group, "max_framebuffer_layers", |case: &mut ApiCase<'_>| {
        implementation_limit_case(case, glw::GL_MAX_FRAMEBUFFER_LAYERS, 256);
    });
    add_api_case(
        &mut group,
        "framebuffer_default_layers",
        framebuffer_default_layers_case,
    );
    add_api_case(
        &mut group,
        "framebuffer_attachment_layered",
        framebuffer_attachment_layered_case,
    );
    add_api_case(
        &mut group,
        "framebuffer_incomplete_layer_targets",
        framebuffer_incomplete_layer_targets_case,
    );

    // resource query
    add_api_case(
        &mut group,
        "referenced_by_geometry_shader",
        referenced_by_geometry_shader_case,
    );

    // combined limits
    add_api_case(
        &mut group,
        "max_combined_geometry_uniform_components",
        combined_geometry_uniform_limit_case,
    );

    group
}

// ---------------------------------------------------------------------------------------
// vertex_transform_feedback
// ---------------------------------------------------------------------------------------

#[derive(Clone, Copy, PartialEq, Eq)]
#[allow(clippy::enum_variant_names)]
enum FeedbackMethod {
    DrawArrays,
    DrawArraysInstanced,
    DrawArraysIndirect,
    DrawElements,
    DrawElementsInstanced,
    DrawElementsIndirect,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum FeedbackPrimitive {
    LineLoop,
    LineStrip,
    TriangleStrip,
    TriangleFan,
    Points,
}

impl FeedbackPrimitive {
    /// `VertexFeedbackCase::getOutputPrimitive`
    fn output_primitive(self) -> GLenum {
        match self {
            Self::LineLoop => glw::GL_LINE_LOOP,
            Self::LineStrip => glw::GL_LINE_STRIP,
            Self::TriangleStrip => glw::GL_TRIANGLE_STRIP,
            Self::TriangleFan => glw::GL_TRIANGLE_FAN,
            Self::Points => glw::GL_POINTS,
        }
    }

    /// `VertexFeedbackCase::getBasePrimitive`
    fn base_primitive(self) -> GLenum {
        match self {
            Self::LineLoop | Self::LineStrip => glw::GL_LINES,
            Self::TriangleStrip | Self::TriangleFan => glw::GL_TRIANGLES,
            Self::Points => glw::GL_POINTS,
        }
    }
}

/// `VertexFeedbackCase`
struct VertexFeedbackCase {
    name: String,
    method: FeedbackMethod,
    output: FeedbackPrimitive,
}

impl TestCase for VertexFeedbackCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !check_support(context) {
            return Err(TestError::NotSupported(
                "Tests require GL_EXT_geometry_shader extension or higher context version.".to_string(),
            ));
        }
        Ok(())
    }

    /// `VertexFeedbackCase::init` plus `iterate`.
    fn iterate(&self, context: &Context) -> TestOutcome {
        self.check_support(context)?;

        let gl = context.gl();
        let output_primitive = self.output.output_primitive();
        let base_primitive = self.output.base_primitive();

        let element_data: [u16; 4] = [0, 1, 2, 3];
        let array_data: [[f32; 4]; 4] = [
            [0.0, 0.0, 0.0, 0.0],
            [1.0, 0.0, 0.0, 0.0],
            [2.0, 0.0, 0.0, 0.0],
            [3.0, 0.0, 0.0, 0.0],
        ];
        let offset_data: [[f32; 4]; 4] = [[0.0; 4]; 4];
        let feedback_size = 8 * size_of::<[f32; 4]>();

        let vao = VertexArray::new(gl);
        let element_buf = Buffer::new(gl);
        let array_buf = Buffer::new(gl);
        let offset_buf = Buffer::new(gl);
        let feedback_buf = Buffer::new(gl);
        let indirect_buf = Buffer::new(gl);

        // SAFETY: names this case generated and arrays that outlive each upload.
        unsafe {
            gl.bind_vertex_array(vao.get());
        }
        glu::expect_no_error(gl, "set up vao")?;

        // SAFETY: as above.
        unsafe {
            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, element_buf.get());
            gl.buffer_data(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                size_of_val(&element_data) as GLsizeiptr,
                element_data.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
        }
        glu::expect_no_error(gl, "gen buf")?;

        // SAFETY: as above.
        unsafe {
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, array_buf.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(&array_data) as GLsizeiptr,
                array_data.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
        }
        glu::expect_no_error(gl, "gen buf")?;

        // SAFETY: as above.
        unsafe {
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, offset_buf.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(&offset_data) as GLsizeiptr,
                offset_data.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
        }
        glu::expect_no_error(gl, "gen buf")?;

        // SAFETY: as above.
        unsafe {
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, feedback_buf.get());
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                feedback_size as GLsizeiptr,
                std::ptr::null(),
                glw::GL_DYNAMIC_COPY,
            );
        }
        glu::expect_no_error(gl, "gen buf")?;

        let vertex_source = "${GLSL_VERSION_DECL}\n\
            in highp vec4 a_position;\n\
            in highp vec4 a_offset;\n\
            out highp vec4 tf_value;\n\
            void main (void)\n\
            {\n\
            \tgl_Position = a_position;\n\
            \ttf_value = a_position + a_offset;\n\
            }\n";
        let fragment_source = "${GLSL_VERSION_DECL}\n\
            layout(location = 0) out mediump vec4 fragColor;\n\
            void main (void)\n\
            {\n\
            \tfragColor = vec4(1.0);\n\
            }\n";
        let sources = ProgramSources::default()
            .with(ShaderType::Vertex, specialize_shader(vertex_source, context))
            .with(ShaderType::Fragment, specialize_shader(fragment_source, context))
            .with_transform_feedback(&["tf_value".to_string()], glw::GL_INTERLEAVED_ATTRIBS);
        let program = ShaderProgram::new(gl, &sources);
        if !program.is_ok() {
            return Err(TestError::Fail("could not build program".to_string()));
        }

        // SAFETY: NUL-terminated names against the program just built.
        let (pos_location, offset_location) = unsafe {
            (
                gl.get_attrib_location(program.program(), c"a_position".as_ptr()),
                gl.get_attrib_location(program.program(), c"a_offset".as_ptr()),
            )
        };

        if pos_location == -1 {
            return Err(TestError::Fail("a_position location was -1".to_string()));
        }
        if offset_location == -1 {
            return Err(TestError::Fail("a_offset location was -1".to_string()));
        }

        // SAFETY: the buffers and program set up above.
        unsafe {
            gl.use_program(program.program());

            gl.bind_buffer(glw::GL_ARRAY_BUFFER, array_buf.get());
            gl.vertex_attrib_pointer(
                pos_location as GLuint,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                std::ptr::null(),
            );
            gl.enable_vertex_attrib_array(pos_location as GLuint);

            gl.bind_buffer(glw::GL_ARRAY_BUFFER, offset_buf.get());
            gl.vertex_attrib_pointer(
                offset_location as GLuint,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                std::ptr::null(),
            );
            gl.enable_vertex_attrib_array(offset_location as GLuint);

            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, feedback_buf.get());
        }
        glu::expect_no_error(gl, "bind buffer base")?;

        // SAFETY: a feedback buffer is bound to index 0 and the program declares its varying.
        unsafe { gl.begin_transform_feedback(base_primitive) };
        glu::expect_no_error(gl, "beginTransformFeedback")?;

        // SAFETY: attribute and index buffers are bound; indirect commands are uploaded below.
        unsafe {
            match self.method {
                FeedbackMethod::DrawArrays => gl.draw_arrays(output_primitive, 0, 4),
                FeedbackMethod::DrawArraysInstanced => {
                    gl.vertex_attrib_divisor(offset_location as GLuint, 2);
                    gl.draw_arrays_instanced(output_primitive, 0, 3, 2);
                }
                FeedbackMethod::DrawElements => {
                    gl.draw_elements(output_primitive, 4, glw::GL_UNSIGNED_SHORT, std::ptr::null())
                }
                FeedbackMethod::DrawElementsInstanced => {
                    gl.draw_elements_instanced(output_primitive, 3, glw::GL_UNSIGNED_SHORT, std::ptr::null(), 2)
                }
                FeedbackMethod::DrawArraysIndirect => {
                    // count, instanceCount, first, reservedMustBeZero
                    let params: [u32; 4] = [4, 1, 0, 0];

                    gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, indirect_buf.get());
                    gl.buffer_data(
                        glw::GL_DRAW_INDIRECT_BUFFER,
                        size_of_val(&params) as GLsizeiptr,
                        params.as_ptr().cast(),
                        glw::GL_STATIC_DRAW,
                    );
                    gl.draw_arrays_indirect(output_primitive, std::ptr::null());
                }
                FeedbackMethod::DrawElementsIndirect => {
                    // count, instanceCount, firstIndex, baseVertex, reservedMustBeZero
                    let params: [u32; 5] = [4, 1, 0, 0, 0];

                    gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, indirect_buf.get());
                    gl.buffer_data(
                        glw::GL_DRAW_INDIRECT_BUFFER,
                        size_of_val(&params) as GLsizeiptr,
                        params.as_ptr().cast(),
                        glw::GL_STATIC_DRAW,
                    );
                    gl.draw_elements_indirect(output_primitive, glw::GL_UNSIGNED_SHORT, std::ptr::null());
                }
            }
        }
        glu::expect_no_error(gl, "draw")?;

        // SAFETY: ends the feedback begun above.
        unsafe { gl.end_transform_feedback() };
        glu::expect_no_error(gl, "endTransformFeedback")?;

        Ok(TestStatus::pass("Pass"))
    }
}

/// `VertexFeedbackOverflowCase`
struct VertexFeedbackOverflowCase {
    name: String,
    draw_elements: bool,
}

impl TestCase for VertexFeedbackOverflowCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !check_support(context) {
            return Err(TestError::NotSupported(
                "Tests require GL_EXT_geometry_shader extension or higher context version.".to_string(),
            ));
        }
        Ok(())
    }

    /// `VertexFeedbackOverflowCase::init` plus `iterate`.
    fn iterate(&self, context: &Context) -> TestOutcome {
        self.check_support(context)?;

        let gl = context.gl();
        let element_data: [u16; 6] = [0, 1, 2, 0, 1, 2];
        let array_data: [[f32; 4]; 4] = [[1.0; 4]; 4];

        let vao = VertexArray::new(gl);
        let element_buf = Buffer::new(gl);
        let array_buf = Buffer::new(gl);
        let feedback_buf = Buffer::new(gl);

        // SAFETY: names this case generated and arrays that outlive each upload.
        unsafe { gl.bind_vertex_array(vao.get()) };
        glu::expect_no_error(gl, "set up vao")?;

        if self.draw_elements {
            // SAFETY: as above.
            unsafe {
                gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, element_buf.get());
                gl.buffer_data(
                    glw::GL_ELEMENT_ARRAY_BUFFER,
                    size_of_val(&element_data) as GLsizeiptr,
                    element_data.as_ptr().cast(),
                    glw::GL_STATIC_DRAW,
                );
            }
            glu::expect_no_error(gl, "gen buf")?;
        }

        // SAFETY: as above.
        unsafe {
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, array_buf.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(&array_data) as GLsizeiptr,
                array_data.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
        }
        glu::expect_no_error(gl, "gen buf")?;

        {
            let feedback_count = 5 * 4; // 5x vec4
            let initial_buffer_contents = vec![-1.0f32; feedback_count];

            // Filling feedback buffer with unused value (-1.0).
            // SAFETY: a vector that outlives the upload.
            unsafe {
                gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, feedback_buf.get());
                gl.buffer_data(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    size_of_val(initial_buffer_contents.as_slice()) as GLsizeiptr,
                    initial_buffer_contents.as_ptr().cast(),
                    glw::GL_DYNAMIC_COPY,
                );
            }
            glu::expect_no_error(gl, "gen buf")?;
        }

        let vertex_source = "${GLSL_VERSION_DECL}\n\
            in highp vec4 a_position;\n\
            void main (void)\n\
            {\n\
            \tgl_Position = a_position;\n\
            }\n";
        let fragment_source = "${GLSL_VERSION_DECL}\n\
            layout(location = 0) out mediump vec4 fragColor;\n\
            void main (void)\n\
            {\n\
            \tfragColor = vec4(1.0);\n\
            }\n";
        let sources = ProgramSources::default()
            .with(ShaderType::Vertex, specialize_shader(vertex_source, context))
            .with(ShaderType::Fragment, specialize_shader(fragment_source, context))
            .with_transform_feedback(&["gl_Position".to_string()], glw::GL_INTERLEAVED_ATTRIBS);
        let program = ShaderProgram::new(gl, &sources);
        if !program.is_ok() {
            return Err(TestError::Fail("could not build program".to_string()));
        }

        // SAFETY: NUL-terminated name against the program just built.
        let pos_location = unsafe { gl.get_attrib_location(program.program(), c"a_position".as_ptr()) };
        if pos_location == -1 {
            return Err(TestError::Fail("a_position location was -1".to_string()));
        }

        // SAFETY: the buffers and program set up above.
        unsafe {
            gl.use_program(program.program());

            gl.bind_buffer(glw::GL_ARRAY_BUFFER, array_buf.get());
            gl.vertex_attrib_pointer(
                pos_location as GLuint,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                std::ptr::null(),
            );
            gl.enable_vertex_attrib_array(pos_location as GLuint);
        }

        if self.draw_elements {
            // SAFETY: the element buffer uploaded above.
            unsafe { gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, element_buf.get()) };
            glu::expect_no_error(gl, "bind buffers")?;
        }

        // SAFETY: the feedback buffer uploaded above.
        unsafe { gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, feedback_buf.get()) };
        glu::expect_no_error(gl, "bind buffer base")?;

        // Capturing 2 triangles.
        // SAFETY: feedback is bound; the draw covers two triangles.
        unsafe {
            gl.begin_transform_feedback(glw::GL_TRIANGLES);

            if self.draw_elements {
                gl.draw_elements(glw::GL_TRIANGLES, 6, glw::GL_UNSIGNED_SHORT, std::ptr::null());
            } else {
                gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);
            }

            gl.end_transform_feedback();
        }
        glu::expect_no_error(gl, "capture")?;

        // Verifying final triangle was not partially written to the feedback buffer.
        let mut feedback = [0.0f32; 5 * 4];
        // SAFETY: maps exactly the 80 bytes the buffer was allocated with, for reading.
        unsafe {
            let ptr = gl.map_buffer_range(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                0,
                size_of_val(&feedback) as GLsizeiptr,
                glw::GL_MAP_READ_BIT,
            );
            glu::expect_no_error(gl, "mapBufferRange")?;
            if ptr.is_null() {
                return Err(TestError::Fail("mapBufferRange returned null".to_string()));
            }

            std::ptr::copy_nonoverlapping(ptr as *const f32, feedback.as_mut_ptr(), feedback.len());

            if gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER) != glw::TRUE {
                return Err(TestError::Fail("unmapBuffer returned false".to_string()));
            }
        }

        let mut error = false;

        // Verify vertices 0 - 2, then 3 - 4.
        for vertex in 0..5 {
            let expected = if vertex < 3 { 1.0 } else { -1.0 };
            for component in 0..4 {
                let value = feedback[vertex * 4 + component];
                if value != expected {
                    log::warn!(
                        "Feedback buffer vertex {vertex}, component {component}: unexpected value, expected {expected}, got {value}"
                    );
                    error = true;
                }
            }
        }

        if error {
            Ok(TestStatus::fail("Feedback result validation failed"))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

fn feedback_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("vertex_transform_feedback");

    for (name, method, output) in [
        (
            "capture_vertex_line_loop",
            FeedbackMethod::DrawArrays,
            FeedbackPrimitive::LineLoop,
        ),
        (
            "capture_vertex_line_strip",
            FeedbackMethod::DrawArrays,
            FeedbackPrimitive::LineStrip,
        ),
        (
            "capture_vertex_triangle_strip",
            FeedbackMethod::DrawArrays,
            FeedbackPrimitive::TriangleStrip,
        ),
        (
            "capture_vertex_triangle_fan",
            FeedbackMethod::DrawArrays,
            FeedbackPrimitive::TriangleFan,
        ),
        (
            "capture_vertex_draw_arrays",
            FeedbackMethod::DrawArrays,
            FeedbackPrimitive::Points,
        ),
        (
            "capture_vertex_draw_arrays_instanced",
            FeedbackMethod::DrawArraysInstanced,
            FeedbackPrimitive::Points,
        ),
        (
            "capture_vertex_draw_arrays_indirect",
            FeedbackMethod::DrawArraysIndirect,
            FeedbackPrimitive::Points,
        ),
        (
            "capture_vertex_draw_elements",
            FeedbackMethod::DrawElements,
            FeedbackPrimitive::Points,
        ),
        (
            "capture_vertex_draw_elements_instanced",
            FeedbackMethod::DrawElementsInstanced,
            FeedbackPrimitive::Points,
        ),
        (
            "capture_vertex_draw_elements_indirect",
            FeedbackMethod::DrawElementsIndirect,
            FeedbackPrimitive::Points,
        ),
    ] {
        group.add_child(Box::new(VertexFeedbackCase {
            name: name.to_string(),
            method,
            output,
        }) as Box<dyn TestCase>);
    }

    group.add_child(Box::new(VertexFeedbackOverflowCase {
        name: "capture_vertex_draw_arrays_overflow_single_buffer".to_string(),
        draw_elements: false,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(VertexFeedbackOverflowCase {
        name: "capture_vertex_draw_elements_overflow_single_buffer".to_string(),
        draw_elements: true,
    }) as Box<dyn TestCase>);

    group
}

/// `GeometryShaderTests::init`, restricted to the groups that are ported here, in
/// upstream's order.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("geometry_shading");
    group.add_child(query_group());
    for render_group in super::geometry_shading_render_tests::create_render_groups() {
        group.add_child(render_group);
    }
    group.add_child(super::geometry_shading_layered_tests::create_layered_group());
    {
        let mut instanced = TestCaseGroup::new("instanced");
        super::geometry_shading_render_tests::add_invocation_cases(&mut instanced);
        super::geometry_shading_layered_tests::add_instanced_layered_cases(&mut instanced);
        super::geometry_shading_render_tests::add_invocation_varying_output_count_cases(&mut instanced);
        super::geometry_shading_render_tests::add_draw_instanced_cases(&mut instanced);
        group.add_child(instanced);
    }
    group.add_child(negative_group());
    group.add_child(feedback_group());
    group
}
