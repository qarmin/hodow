// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl3cTransformFeedback3Tests.cpp
//   external/openglcts/modules/gl/gl3cTransformFeedback3Tests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `TransformFeedbackBaseTestCase::init` (which decides `m_testSupported`) is `prepare`, called from `check_support` and again by `iterate` for the specialization it leaves behind. Upstream compiles a checker `ShaderProgram` and then builds the same shaders by hand with `glTransformFeedbackVaryings` before linking; here one `ShaderProgram` with the varyings does both, so a failure to compile and a failure to link both fail the case. The vertex array and buffer of `createVertexBuffers` are guards released by `releaseVertexBuffers`' counterpart, drop.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

type Res<T> = Result<T, TestError>;

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const FLOAT_EPSILON: f32 = 1.0e-03;

/// Vertex shader source code for multiple streams transform feedback test.
const SHADER_MULT_STREAMS_VERT: &str =
    "${VERSION}\n    in vec4 vertex;\n    void main (void)\n    {\n        gl_Position = vertex;\n    }\n    ";

/// Geometry shader source code for multiple streams transform feedback test.
const SHADER_MULT_STREAMS_GEOM: &str = "${VERSION}\n    ${EXTENSION}\n    layout(points) in;\n    layout(points, max_vertices = 8) out;\n    layout(stream=0) out vec4 pos0;\n    layout(stream=1) out vec4 pos1;\n    void main() {\n        pos0 = vec4(0.1, 0.2, 0.3, 0.4) * gl_in[0].gl_Position;\n        gl_Position = vec4(0.9, 0.9, 0.0, 1.0) * gl_in[0].gl_Position;\n        EmitStreamVertex(0);\n        EndStreamPrimitive(0);\n        pos1 = vec4(-0.1, -0.2, -0.3, -0.4) * gl_in[0].gl_Position;\n        gl_Position = vec4(-0.9, -0.9, 0.0, 1.0) * gl_in[0].gl_Position;\n        EmitStreamVertex(1);\n        EndStreamPrimitive(1);\n    }\n    ";

const SHADER_VERT: &str = "${VERSION}\n    in vec4 vertex;\n    out vec4 value1;\n    out vec4 value2;\n    out vec4 value3;\n    out vec4 value4;\n    void main (void)\n    {\n        vec4 temp = vertex;\n        //temp.xyz *= 0.5;\n        gl_Position = temp;\n        value1 = abs(temp) * 1.0;\n        value2 = abs(temp) * 2.0;\n        value3 = abs(temp) * 3.0;\n        value4 = abs(temp) * 4.0;\n    }\n    ";

const SHADER_FRAG: &str = "${VERSION}\n    out vec4 FragColor;\n    void main (void)\n    {\n        FragColor = vec4(0.0, 0.0, 0.0, 1.0);\n    }\n    ";

const MULTIPLE_STREAMS_VARYINGS: [&str; 5] = [
    "pos0",
    "gl_SkipComponents4",
    "gl_NextBuffer",
    "gl_SkipComponents4",
    "pos1",
];

const SKIP_COMPONENTS_VARYINGS: [&str; 10] = [
    "gl_SkipComponents1",
    "value1",
    "gl_SkipComponents2",
    "gl_SkipComponents1",
    "value2",
    "gl_SkipComponents3",
    "gl_SkipComponents2",
    "value3",
    "gl_SkipComponents4",
    "value4",
];

const SKIP_MULTIPLE_BUFFERS_VARYINGS: [&str; 11] = [
    "gl_SkipComponents1",
    "value1",
    "gl_NextBuffer",
    "gl_SkipComponents2",
    "value2",
    "gl_NextBuffer",
    "gl_SkipComponents3",
    "value3",
    "gl_NextBuffer",
    "gl_SkipComponents4",
    "value4",
];

const MULTIPLE_STREAMS_VERTICES: [f32; 12] = [-1.0, -1.0, -1.0, 1.0, 1.0, -1.0, -2.0, 1.0, -1.0, 1.0, -3.0, 1.0];

// expected values
const MULTIPLE_STREAMS_CORRECT: [f32; 24] = [
    -0.1, -0.2, -0.3, 0.4, 0.1, 0.2, 0.3, -0.4, 0.1, -0.2, -0.6, 0.4, -0.1, 0.2, 0.6, -0.4, -0.1, 0.2, -0.9, 0.4, 0.1,
    -0.2, 0.9, -0.4,
];

const SKIP_VERTICES: [f32; 24] = [
    -1.0, -1.0, -1.0, 1.0, 1.0, -1.0, -2.0, 1.0, -1.0, 1.0, -3.0, 1.0, 1.0, 1.0, 4.0, 1.0, -1.0, 1.0, 5.0, 1.0, 1.0,
    -1.0, 6.0, 1.0,
];

const SKIP_COMPONENTS_CORRECT: [f32; 174] = [
    -1.0, 1.0, 1.0, 1.0, 1.0, -6.0, -7.0, -8.0, 2.0, 2.0, 2.0, 2.0, -13.0, -14.0, -15.0, -16.0, -17.0, 3.0, 3.0, 3.0,
    3.0, -22.0, -23.0, -24.0, -25.0, 4.0, 4.0, 4.0, 4.0, -30.0, 1.0, 1.0, 2.0, 1.0, -35.0, -36.0, -37.0, 2.0, 2.0, 4.0,
    2.0, -42.0, -43.0, -44.0, -45.0, -46.0, 3.0, 3.0, 6.0, 3.0, -51.0, -52.0, -53.0, -54.0, 4.0, 4.0, 8.0, 4.0, -59.0,
    1.0, 1.0, 3.0, 1.0, -64.0, -65.0, -66.0, 2.0, 2.0, 6.0, 2.0, -71.0, -72.0, -73.0, -74.0, -75.0, 3.0, 3.0, 9.0, 3.0,
    -80.0, -81.0, -82.0, -83.0, 4.0, 4.0, 12.0, 4.0, -88.0, 1.0, 1.0, 4.0, 1.0, -93.0, -94.0, -95.0, 2.0, 2.0, 8.0,
    2.0, -100.0, -101.0, -102.0, -103.0, -104.0, 3.0, 3.0, 12.0, 3.0, -109.0, -110.0, -111.0, -112.0, 4.0, 4.0, 16.0,
    4.0, -117.0, 1.0, 1.0, 5.0, 1.0, -122.0, -123.0, -124.0, 2.0, 2.0, 10.0, 2.0, -129.0, -130.0, -131.0, -132.0,
    -133.0, 3.0, 3.0, 15.0, 3.0, -138.0, -139.0, -140.0, -141.0, 4.0, 4.0, 20.0, 4.0, -146.0, 1.0, 1.0, 6.0, 1.0,
    -151.0, -152.0, -153.0, 2.0, 2.0, 12.0, 2.0, -158.0, -159.0, -160.0, -161.0, -162.0, 3.0, 3.0, 18.0, 3.0, -167.0,
    -168.0, -169.0, -170.0, 4.0, 4.0, 24.0, 4.0,
];

const SKIP_BUFFERS_CORRECT_0: [f32; 30] = [
    -100.0, 1.0, 1.0, 1.0, 1.0, -105.0, 1.0, 1.0, 2.0, 1.0, -110.0, 1.0, 1.0, 3.0, 1.0, -115.0, 1.0, 1.0, 4.0, 1.0,
    -120.0, 1.0, 1.0, 5.0, 1.0, -125.0, 1.0, 1.0, 6.0, 1.0,
];

const SKIP_BUFFERS_CORRECT_1: [f32; 36] = [
    -100.0, -101.0, 2.0, 2.0, 2.0, 2.0, -106.0, -107.0, 2.0, 2.0, 4.0, 2.0, -112.0, -113.0, 2.0, 2.0, 6.0, 2.0, -118.0,
    -119.0, 2.0, 2.0, 8.0, 2.0, -124.0, -125.0, 2.0, 2.0, 10.0, 2.0, -130.0, -131.0, 2.0, 2.0, 12.0, 2.0,
];

const SKIP_BUFFERS_CORRECT_2: [f32; 42] = [
    -100.0, -101.0, -102.0, 3.0, 3.0, 3.0, 3.0, -107.0, -108.0, -109.0, 3.0, 3.0, 6.0, 3.0, -114.0, -115.0, -116.0,
    3.0, 3.0, 9.0, 3.0, -121.0, -122.0, -123.0, 3.0, 3.0, 12.0, 3.0, -128.0, -129.0, -130.0, 3.0, 3.0, 15.0, 3.0,
    -135.0, -136.0, -137.0, 3.0, 3.0, 18.0, 3.0,
];

const SKIP_BUFFERS_CORRECT_3: [f32; 48] = [
    -100.0, -101.0, -102.0, -103.0, 4.0, 4.0, 4.0, 4.0, -108.0, -109.0, -110.0, -111.0, 4.0, 4.0, 8.0, 4.0, -116.0,
    -117.0, -118.0, -119.0, 4.0, 4.0, 12.0, 4.0, -124.0, -125.0, -126.0, -127.0, 4.0, 4.0, 16.0, 4.0, -132.0, -133.0,
    -134.0, -135.0, 4.0, 4.0, 20.0, 4.0, -140.0, -141.0, -142.0, -143.0, 4.0, 4.0, 24.0, 4.0,
];

/// What `TransformFeedbackBaseTestCase::init` and the specific `init` leave behind.
struct Prepared {
    specialization: Vec<(&'static str, String)>,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    MultipleStreams,
    SkipComponents,
    SkipMultipleBuffers,
}

impl Kind {
    fn name(self) -> &'static str {
        match self {
            Self::MultipleStreams => "multiple_streams",
            Self::SkipComponents => "skip_components",
            Self::SkipMultipleBuffers => "skip_multiple_buffers",
        }
    }

    fn varyings(self) -> Vec<String> {
        let names: &[&str] = match self {
            Self::MultipleStreams => &MULTIPLE_STREAMS_VARYINGS,
            Self::SkipComponents => &SKIP_COMPONENTS_VARYINGS,
            Self::SkipMultipleBuffers => &SKIP_MULTIPLE_BUFFERS_VARYINGS,
        };
        names.iter().map(|name| (*name).to_string()).collect()
    }
}

fn get_integer(gl: &glw::Functions, pname: GLenum) -> Res<GLint> {
    let mut value = 0;
    gl_call!(gl, "getIntegerv", gl.get_integerv(pname, &mut value));
    Ok(value)
}

/// `TransformFeedbackBaseTestCase::init` and, for the first case, `TransformFeedbackMultipleStreamsTestCase::init`; `None` is `!m_testSupported`.
fn prepare(context: &Context, kind: Kind) -> Res<Option<Prepared>> {
    let mut specialization = vec![("VERSION", "#version 150".to_string()), ("EXTENSION", String::new())];
    let context_type = context.context_type();
    let gl = context.gl();

    // This test should only be executed if we're running a GL>=3.0 context
    let mut test_supported = (context_type.supports_core(3, 0)
        && context
            .context_info
            .is_extension_supported("GL_ARB_transform_feedback3"))
        || context_type.supports_core(4, 0);

    if test_supported {
        test_supported = test_supported && get_integer(gl, glw::GL_MAX_TRANSFORM_FEEDBACK_BUFFERS)? >= 4;
        test_supported = test_supported && get_integer(gl, glw::GL_MAX_VERTEX_STREAMS)? >= 1;
    }

    if kind == Kind::MultipleStreams && test_supported {
        if context_type.supports_core(4, 0) {
            specialization = vec![("VERSION", "#version 400".to_string()), ("EXTENSION", String::new())];
        } else if !context.context_info.is_extension_supported("GL_ARB_gpu_shader5") {
            // 3.0 context supported, verify extension
            test_supported = false;
        } else {
            specialization[1].1 = "#extension GL_ARB_gpu_shader5 : enable".to_string();
        }

        // the test requires two vertex streams
        test_supported = test_supported && get_integer(gl, glw::GL_MAX_VERTEX_STREAMS)? >= 2;
    }

    Ok(test_supported.then_some(Prepared { specialization }))
}

/// `buildTransformFeedbackProgram`, after the shaders are specialized.
fn build_transform_feedback_program<'gl>(
    gl: &'gl glw::Functions,
    vertex: &str,
    geometry: Option<&str>,
    fragment: Option<&str>,
    varyings: &[String],
) -> Res<ShaderProgram<'gl>> {
    let mut sources = ProgramSources::default().with(ShaderType::Vertex, vertex);
    if let Some(geometry) = geometry {
        sources = sources.with(ShaderType::Geometry, geometry);
    }
    if let Some(fragment) = fragment {
        sources = sources.with(ShaderType::Fragment, fragment);
    }
    sources = sources.with_transform_feedback(varyings, glw::GL_INTERLEAVED_ATTRIBS);

    let program = ShaderProgram::new(gl, &sources);
    if !program.is_ok() {
        return Err(TestError::Fail(format!(
            "Failed to compile or link the transform feedback program. {}",
            program.build_failure_summary().unwrap_or_default()
        )));
    }

    // SAFETY: a linked program.
    unsafe { gl.use_program(program.program()) };
    Ok(program)
}

/// `createVertexBuffers` - the vertex array and buffer related to the program, released when dropped (`releaseVertexBuffers`).
struct VertexBuffers<'a> {
    gl: &'a glw::Functions,
    vao: glu::VertexArray<'a>,
    vbo: glu::Buffer<'a>,
}

impl<'a> VertexBuffers<'a> {
    fn new(gl: &'a glw::Functions, program: GLuint, verts: &[f32]) -> Res<Self> {
        let buffers = Self {
            gl,
            vao: glu::VertexArray::new(gl),
            vbo: glu::Buffer::new(gl),
        };
        glu::expect_no_error(gl, "genVertexArrays")?;
        gl_call!(gl, "bindVertexArray", gl.bind_vertex_array(buffers.vao.get()));
        glu::expect_no_error(gl, "genBuffers")?;
        gl_call!(
            gl,
            "bindBuffer",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffers.vbo.get())
        );
        gl_call!(
            gl,
            "bufferData",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(verts) as isize,
                verts.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );
        gl_call!(gl, "useProgram", gl.use_program(program));

        // SAFETY: a linked program and a NUL-terminated name.
        let loc_vertices = unsafe { gl.get_attrib_location(program, c"vertex".as_ptr()) };
        glu::expect_no_error(gl, "getAttribLocation")?;
        if loc_vertices != -1 {
            gl_call!(gl, "enableVertexAttribArray", gl.enable_vertex_attrib_array(0));
            gl_call!(
                gl,
                "vertexAttribPointer",
                gl.vertex_attrib_pointer(
                    loc_vertices as GLuint,
                    4,
                    glw::GL_FLOAT,
                    glw::FALSE,
                    0,
                    std::ptr::null()
                )
            );
        }
        Ok(buffers)
    }
}

impl Drop for VertexBuffers<'_> {
    fn drop(&mut self) {
        // SAFETY: a current context.
        unsafe { self.gl.disable_vertex_attrib_array(0) };
    }
}

/// creates transform feedback buffer at certain index. leaves buffer bound
fn create_transform_buffer(gl: &glw::Functions, size: i32, buffer: GLuint, index: GLuint) -> Res<()> {
    gl_call!(gl, "bindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer));
    gl_call!(
        gl,
        "bufferData",
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            size as isize,
            std::ptr::null(),
            glw::GL_STATIC_READ
        )
    );
    gl_call!(
        gl,
        "bindBufferBase",
        gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, index, buffer)
    );
    gl_call!(gl, "bindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
    Ok(())
}

/// copies data from transform feedback buffer; `None` when the mapping fails
fn read_buffer(gl: &glw::Functions, size: i32, buffer: GLuint) -> Res<Option<Vec<f32>>> {
    gl_call!(
        gl,
        "bindBufferRange",
        gl.bind_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, buffer, 0, size as isize)
    );
    // SAFETY: the range was just bound with this size.
    let ret = unsafe {
        gl.map_buffer_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            size as isize,
            glw::GL_MAP_READ_BIT,
        )
    };
    glu::expect_no_error(gl, "mapBufferRange")?;
    if ret.is_null() {
        return Ok(None);
    }

    let mut data = vec![0.0f32; size as usize / std::mem::size_of::<f32>()];
    // SAFETY: the mapping covers `size` bytes and `data` holds at least that many.
    unsafe {
        std::ptr::copy_nonoverlapping(
            ret.cast::<u8>(),
            data.as_mut_ptr().cast::<u8>(),
            data.len() * std::mem::size_of::<f32>(),
        )
    };
    gl_call!(gl, "unmapBuffer", gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
    Ok(Some(data))
}

/// compares contents of two arrays
fn compare_arrays(d1: &[f32], d2: &[f32]) -> bool {
    if d1.len() != d2.len() {
        log::info!("compareArrays:arrays are different sizes ({}, {})", d1.len(), d2.len());
        return false;
    }

    for (i, (a, b)) in d1.iter().zip(d2).enumerate() {
        if (a - b).abs() > FLOAT_EPSILON {
            log::info!("compareArrays(GLfloat):index {i} value {a} != {b}");
            return false;
        }
    }
    true
}

fn status(ret: bool) -> TestOutcome {
    Ok(if ret {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

fn begin_discarding(gl: &glw::Functions) -> Res<()> {
    gl_call!(gl, "enable", gl.enable(glw::GL_RASTERIZER_DISCARD));
    gl_call!(gl, "clearColor", gl.clear_color(0.1, 0.0, 0.5, 1.0));
    gl_call!(
        gl,
        "clear",
        gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT)
    );
    Ok(())
}

/// `TransformFeedbackMultipleStreamsTestCase::iterate`
fn multiple_streams(context: &Context, prepared: &Prepared) -> TestOutcome {
    let gl = context.gl();
    let mut ret = true;

    // setup shader program
    let vshader = StringTemplate::new(SHADER_MULT_STREAMS_VERT).specialize(&prepared.specialization)?;
    let gshader = StringTemplate::new(SHADER_MULT_STREAMS_GEOM).specialize(&prepared.specialization)?;
    let program =
        build_transform_feedback_program(gl, &vshader, Some(&gshader), None, &Kind::MultipleStreams.varyings())?;

    let _vertex_buffers = VertexBuffers::new(gl, program.program(), &MULTIPLE_STREAMS_VERTICES)?;

    let buffer = glu::Buffer::new(gl);
    glu::expect_no_error(gl, "genBuffers")?;
    let buffer_size = std::mem::size_of_val(&MULTIPLE_STREAMS_CORRECT) as i32;
    create_transform_buffer(gl, buffer_size, buffer.get(), 0)?;
    let query = glu::Query::new(gl);
    glu::expect_no_error(gl, "genQueries")?;

    begin_discarding(gl)?;
    gl_call!(
        gl,
        "bindBufferRange",
        gl.bind_buffer_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            buffer.get(),
            0,
            buffer_size as isize
        )
    );
    gl_call!(
        gl,
        "bindBufferRange",
        gl.bind_buffer_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            1,
            buffer.get(),
            0,
            buffer_size as isize
        )
    );
    gl_call!(
        gl,
        "beginQueryIndexed",
        gl.begin_query_indexed(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, 0, query.get())
    );
    gl_call!(
        gl,
        "beginTransformFeedback",
        gl.begin_transform_feedback(glw::GL_POINTS)
    );
    gl_call!(gl, "drawArrays", gl.draw_arrays(glw::GL_POINTS, 0, 3));
    gl_call!(gl, "endTransformFeedback", gl.end_transform_feedback());
    gl_call!(
        gl,
        "endQueryIndexed",
        gl.end_query_indexed(glw::GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN, 0)
    );
    gl_call!(gl, "disable", gl.disable(glw::GL_RASTERIZER_DISCARD));

    let data = read_buffer(gl, buffer_size, buffer.get())?;
    if data.is_none() {
        log::info!("Reading result buffer failed!");
        ret = false;
    }

    let mut queryresult: GLuint = 0;
    gl_call!(
        gl,
        "getQueryObjectuiv",
        gl.get_query_objectuiv(query.get(), glw::GL_QUERY_RESULT, &mut queryresult)
    );
    if queryresult as usize != MULTIPLE_STREAMS_VERTICES.len() / 4 {
        log::info!("Transform feedback query result not as expected!");
        ret = false;
    }

    if let (true, Some(data)) = (ret, &data)
        && !compare_arrays(&data[..4 * 3 * 2], &MULTIPLE_STREAMS_CORRECT)
    {
        log::info!("Result comparison failed!");
        ret = false;
    }

    status(ret)
}

/// `TransformFeedbackSkipComponentsTestCase::iterate`
fn skip_components(context: &Context, prepared: &Prepared) -> TestOutcome {
    let gl = context.gl();
    let mut ret = true;

    // setup shader program
    let vshader = StringTemplate::new(SHADER_VERT).specialize(&prepared.specialization)?;
    let fshader = StringTemplate::new(SHADER_FRAG).specialize(&prepared.specialization)?;
    let program =
        build_transform_feedback_program(gl, &vshader, None, Some(&fshader), &Kind::SkipComponents.varyings())?;

    // total number of componenets
    let number_of_components: usize = 4 * 4 + 1 + 2 + 3 + 4 + 1 + 2; // values, skipped components

    let _vertex_buffers = VertexBuffers::new(gl, program.program(), &SKIP_VERTICES)?;

    let buffer = glu::Buffer::new(gl);
    glu::expect_no_error(gl, "genBuffers")?;
    create_transform_buffer(
        gl,
        (std::mem::size_of::<f32>() * 4 * 6 * number_of_components) as i32,
        buffer.get(),
        0,
    )?;

    let buffer_data: Vec<f32> = (0..6 * number_of_components).map(|i| -1.0 - i as f32).collect();
    gl_call!(gl, "bindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer.get()));
    gl_call!(
        gl,
        "bufferData",
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(buffer_data.as_slice()) as isize,
            buffer_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        )
    );
    gl_call!(gl, "bindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    begin_discarding(gl)?;
    gl_call!(
        gl,
        "bindBufferBase",
        gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, buffer.get())
    );
    gl_call!(
        gl,
        "beginTransformFeedback",
        gl.begin_transform_feedback(glw::GL_TRIANGLES)
    );
    gl_call!(gl, "drawArrays", gl.draw_arrays(glw::GL_TRIANGLES, 0, 6));
    gl_call!(gl, "endTransformFeedback", gl.end_transform_feedback());
    gl_call!(gl, "disable", gl.disable(glw::GL_RASTERIZER_DISCARD));

    let data = read_buffer(
        gl,
        (std::mem::size_of::<f32>() * 6 * number_of_components) as i32,
        buffer.get(),
    )?;
    match &data {
        None => {
            log::info!("Reading result buffer failed!");
            ret = false;
        }
        Some(data) => {
            if !compare_arrays(&data[..SKIP_COMPONENTS_CORRECT.len()], &SKIP_COMPONENTS_CORRECT) {
                log::info!("Result comparison failed!");
                ret = false;
            }
        }
    }

    status(ret)
}

/// `TransformFeedbackSkipMultipleBuffersTestCase::iterate`
fn skip_multiple_buffers(context: &Context, prepared: &Prepared) -> TestOutcome {
    let gl = context.gl();
    let mut ret = true;

    // setup shader program
    let vshader = StringTemplate::new(SHADER_VERT).specialize(&prepared.specialization)?;
    let fshader = StringTemplate::new(SHADER_FRAG).specialize(&prepared.specialization)?;
    let program = build_transform_feedback_program(
        gl,
        &vshader,
        None,
        Some(&fshader),
        &Kind::SkipMultipleBuffers.varyings(),
    )?;

    let _vertex_buffers = VertexBuffers::new(gl, program.program(), &SKIP_VERTICES)?;

    // (width, height, expected values) of each buffer
    let type_tests: [(usize, usize, &[f32]); 4] = [
        (5, 6, &SKIP_BUFFERS_CORRECT_0 as &[f32]),
        (6, 6, &SKIP_BUFFERS_CORRECT_1 as &[f32]),
        (7, 6, &SKIP_BUFFERS_CORRECT_2 as &[f32]),
        (8, 6, &SKIP_BUFFERS_CORRECT_3 as &[f32]),
    ];

    let buffer_data: Vec<f32> = (0..6 * 12).map(|i| -100.0 - i as f32).collect();

    let buffers = [
        glu::Buffer::new(gl),
        glu::Buffer::new(gl),
        glu::Buffer::new(gl),
        glu::Buffer::new(gl),
    ];
    glu::expect_no_error(gl, "genBuffers")?;
    for (i, &(w, h, _)) in type_tests.iter().enumerate() {
        let bytecount = (std::mem::size_of::<f32>() * w * h) as i32;
        create_transform_buffer(gl, bytecount, buffers[i].get(), 0)?;

        gl_call!(gl, "bindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffers[i].get()));
        gl_call!(
            gl,
            "bufferData",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                bytecount as isize,
                buffer_data.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );
        gl_call!(gl, "bindBuffer", gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
    }

    begin_discarding(gl)?;
    for (i, buffer) in buffers.iter().enumerate() {
        gl_call!(
            gl,
            "bindBufferBase",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, i as GLuint, buffer.get())
        );
    }
    gl_call!(
        gl,
        "beginTransformFeedback",
        gl.begin_transform_feedback(glw::GL_TRIANGLES)
    );
    gl_call!(gl, "drawArrays", gl.draw_arrays(glw::GL_TRIANGLES, 0, 6));
    gl_call!(gl, "endTransformFeedback", gl.end_transform_feedback());
    gl_call!(gl, "disable", gl.disable(glw::GL_RASTERIZER_DISCARD));

    for (i, &(w, h, values)) in type_tests.iter().enumerate() {
        let Some(data) = read_buffer(gl, (std::mem::size_of::<f32>() * w * h) as i32, buffers[i].get())? else {
            ret = false;
            log::info!("Reading result buffer[ {i}] failed!");
            break;
        };

        if !compare_arrays(&data[..w * h], values) {
            ret = false;
            log::info!("Result comparison at buffer index {i} failed!");
            break;
        }
    }

    status(ret)
}

struct TransformFeedback3Case {
    kind: Kind,
}

impl TestCase for TransformFeedback3Case {
    fn name(&self) -> &str {
        self.kind.name()
    }

    /// `!m_testSupported`, which upstream reports from `iterate`.
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if prepare(context, self.kind)?.is_none() {
            return Err(TestError::NotSupported(format!(
                "Test {} is not supported",
                self.kind.name()
            )));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let Some(prepared) = prepare(context, self.kind)? else {
            return Err(TestError::NotSupported(format!(
                "Test {} is not supported",
                self.kind.name()
            )));
        };
        match self.kind {
            Kind::MultipleStreams => multiple_streams(context, &prepared),
            Kind::SkipComponents => skip_components(context, &prepared),
            Kind::SkipMultipleBuffers => skip_multiple_buffers(context, &prepared),
        }
    }
}

/// `TransformFeedback3Tests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("transform_feedback3");
    for kind in [Kind::MultipleStreams, Kind::SkipComponents, Kind::SkipMultipleBuffers] {
        group.add_child(Box::new(TransformFeedback3Case { kind }) as Box<dyn TestCase>);
    }
    group
}
