// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderAtomicCounterOpsTests.cpp
//   external/openglcts/modules/gl/gl4cShaderAtomicCounterOpsTests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `AtomicOperation` class hierarchy is `AtomicOperation` over `OpKind`; `ShaderPipeline` is `Pipeline`, whose programs are built when it is tested rather than all up front in `init`. Upstream's `addOperation` walks `glu::SHADERTYPE_LAST`, which also covers the ray tracing and mesh stage numbers, so besides the six real stages it adds pipelines whose tested stage matches no shader (they build the same program without an atomic operation and trivially pass); that loop is kept. The extension check upstream does in `iterate` is `check_support`. `executeComputeShader` checks the program it built for the output pass, where upstream checks `m_program` a second time.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup, pr, va};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

type Res<T> = Result<T, TestError>;

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

// `glu::ShaderType` numbering, which `SHADERTYPE_LAST` counts through
const SHADERTYPE_VERTEX: usize = 0;
const SHADERTYPE_FRAGMENT: usize = 1;
const SHADERTYPE_GEOMETRY: usize = 2;
const SHADERTYPE_TESSELLATION_CONTROL: usize = 3;
const SHADERTYPE_TESSELLATION_EVALUATION: usize = 4;
const SHADERTYPE_COMPUTE: usize = 5;
const SHADERTYPE_LAST: usize = 14;

const VERTEX_SHADER: &str = "<version>\n<head>in highp vec2 inPosition;\nout highp vec3 vsPosition;\nout highp vec4 vsColor;\nvoid main()\n{\n    gl_Position = vec4(inPosition, 0.0, 1.0);\n    vsPosition = vec3(inPosition, 0.0);\n    vec4 outColor = vec4(1.0);\n<atomic_operation>    vsColor = outColor;\n}\n";
const FRAGMENT_SHADER: &str = "<version>\n<head>in highp vec4 gsColor;\nout highp vec4 fsColor;\nvoid main()\n{\n    vec4 outColor = gsColor; \n<atomic_operation>    fsColor = outColor;\n}\n";
const TESS_CONTROL_SHADER: &str = "<version>\n<head>layout(vertices = 3) out;\nin highp vec4 vsColor[];\nin highp vec3 vsPosition[];\nout highp vec3 tcsPosition[];\nout highp vec4 tcsColor[];\nvoid main()\n{\n    tcsPosition[gl_InvocationID] = vsPosition[gl_InvocationID];\n    vec4 outColor = vsColor[gl_InvocationID];\n<atomic_operation>    tcsColor[gl_InvocationID] = outColor;\n    gl_TessLevelInner[0] = 3;\n    gl_TessLevelOuter[0] = 3;\n    gl_TessLevelOuter[1] = 3;\n    gl_TessLevelOuter[2] = 3;\n}\n";
const TESS_EVALUATION_SHADER: &str = "<version>\n<head>layout(triangles, equal_spacing, cw) in;\nin highp vec3 tcsPosition[];\nin highp vec4 tcsColor[];\nout highp vec4 tesColor;\nvoid main()\n{\n    vec3 p0 = gl_TessCoord.x * tcsPosition[0];\n    vec3 p1 = gl_TessCoord.y * tcsPosition[1];\n    vec3 p2 = gl_TessCoord.z * tcsPosition[2];\n    vec4 outColor = tcsColor[0];\n<atomic_operation>    tesColor = outColor;\n    gl_Position = vec4(normalize(p0 + p1 + p2), 1.0);\n}\n";
const GEOMETRY_SHADER: &str = "<version>\n<head>layout(triangles) in;\nlayout(triangle_strip, max_vertices = 3) out;\nin highp vec4 tesColor[];\nout highp vec4 gsColor;\nvoid main()\n{\n    for (int i = 0; i<3; i++)\n    {\n        gl_Position = gl_in[i].gl_Position;\n        vec4 outColor = tesColor[i];\n<atomic_operation>        gsColor = outColor;\n        EmitVertex();\n    }\n    EndPrimitive();\n}\n";
const COMPUTE_SHADER: &str = "<version>\n<head>layout(rgba32f, binding = 2) writeonly uniform highp image2D destImage;\nlayout (local_size_x = 16, local_size_y = 16) in;\nvoid main (void)\n{\n    vec4 outColor = vec4(1.0);\n<atomic_operation>    imageStore(destImage, ivec2(gl_GlobalInvocationID.xy), outColor);\n}\n";

const QUAD_INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];
const POSITION: [f32; 8] = [-1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0];
const TEX_COORD: [f32; 8] = [0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0];

#[derive(Clone, Copy)]
enum OpKind {
    Add,
    Subtract,
    Min,
    Max,
    And,
    Or,
    Xor,
    Exchange,
    CompSwap,
}

/// `AtomicOperation` and its subclasses
struct AtomicOperation {
    kind: OpKind,
    function: &'static str,
    input_value: u32,
    param_value: u32,
    compare_value: u32,
    test_return_value: bool,
}

impl AtomicOperation {
    fn new(kind: OpKind, input_value: u32, param_value: u32, compare_value: u32) -> Self {
        let (function, test_return_value) = match kind {
            OpKind::Add => ("atomicCounterAdd", true),
            OpKind::Subtract => ("atomicCounterSubtract", true),
            OpKind::Min => ("atomicCounterMin", false),
            OpKind::Max => ("atomicCounterMax", false),
            OpKind::And => ("atomicCounterAnd", false),
            OpKind::Or => ("atomicCounterOr", false),
            OpKind::Xor => ("atomicCounterXor", false),
            OpKind::Exchange => ("atomicCounterExchange", false),
            OpKind::CompSwap => ("atomicCounterCompSwap", false),
        };
        Self {
            kind,
            function,
            input_value,
            param_value,
            compare_value,
            test_return_value,
        }
    }

    fn iterate(&self, input: u32) -> u32 {
        let (param, compare) = (self.param_value, self.compare_value);
        match self.kind {
            OpKind::Add => input.wrapping_add(param),
            OpKind::Subtract => input.wrapping_sub(param),
            OpKind::Min => input.min(param),
            OpKind::Max => input.max(param),
            OpKind::And => input & param,
            OpKind::Or => input | param,
            OpKind::Xor => input ^ param,
            OpKind::Exchange => param,
            OpKind::CompSwap => {
                if input == compare {
                    param
                } else {
                    input
                }
            }
        }
    }

    fn get_result(&self, iterations: u32) -> u32 {
        (0..iterations).fold(self.input_value, |result, _| self.iterate(result))
    }
}

/// `ShaderPipeline::prepareShader`: the first occurrence of the tag
fn prepare_shader(shader: &mut String, tag: &str, value: &str) {
    if let Some(tag_pos) = shader.find(tag) {
        shader.replace_range(tag_pos..tag_pos + tag.len(), value);
    }
}

/// `ShaderPipeline`'s constructor: the shaders of the pipeline testing `tested_shader`
fn pipeline_shaders(tested_shader: usize, op: &AtomicOperation, context_gl46: bool) -> [String; 6] {
    let mut shaders = [
        VERTEX_SHADER,
        FRAGMENT_SHADER,
        GEOMETRY_SHADER,
        TESS_CONTROL_SHADER,
        TESS_EVALUATION_SHADER,
        COMPUTE_SHADER,
    ]
    .map(str::to_string);

    // prepare shaders
    let postfix = if context_gl46 { "" } else { "ARB" };
    let mut atomic_operation = format!("uint returned = {}{postfix}(counter, ", op.function);
    if op.compare_value != 0 {
        atomic_operation.push_str(&format!("{}u, ", op.compare_value));
    }
    atomic_operation.push_str(&format!("{}u);\n", op.param_value));
    atomic_operation.push_str("uint after = atomicCounter(counter);\n");
    if op.test_return_value {
        atomic_operation.push_str("if(after == returned) outColor = vec4(0.0f);\n");
    }
    atomic_operation.push_str("atomicCounterIncrement(calls);\n");

    let (version_string, head_string) = if context_gl46 {
        (
            "#version 460 core",
            "layout (binding=0) uniform atomic_uint counter;\nlayout (binding=1) uniform atomic_uint calls;\n",
        )
    } else {
        (
            "#version 450 core",
            "#extension GL_ARB_shader_atomic_counters: enable\n#extension GL_ARB_shader_atomic_counter_ops: enable\nlayout (binding=0) uniform atomic_uint counter;\nlayout (binding=1) uniform atomic_uint calls;\n",
        )
    };

    // the `glu::ShaderType` order is vertex, fragment, geometry, tessellation control, tessellation evaluation, compute
    for (i, shader) in shaders.iter_mut().enumerate() {
        prepare_shader(shader, "<version>", version_string);
        prepare_shader(shader, "<head>", if i == tested_shader { head_string } else { "" });
        prepare_shader(
            shader,
            "<atomic_operation>",
            if i == tested_shader { &atomic_operation } else { "" },
        );
    }
    shaders
}

struct Pipeline {
    tested_shader: usize,
    operation: usize,
    shaders: [String; 6],
}

impl Pipeline {
    /// `ShaderPipeline::create`, `use`, `test`, `renderQuad` and `executeComputeShader`
    fn test(&self, context: &Context) -> Res<()> {
        let gl = context.gl();
        let sources = [
            (ShaderType::Vertex, SHADERTYPE_VERTEX),
            (ShaderType::Fragment, SHADERTYPE_FRAGMENT),
            (ShaderType::Geometry, SHADERTYPE_GEOMETRY),
            (ShaderType::TessControl, SHADERTYPE_TESSELLATION_CONTROL),
            (ShaderType::TessEvaluation, SHADERTYPE_TESSELLATION_EVALUATION),
        ]
        .into_iter()
        .fold(ProgramSources::default(), |sources, (shader_type, index)| {
            sources.with(shader_type, self.shaders[index].as_str())
        });
        let program = ShaderProgram::new(gl, &sources);
        if !program.is_ok() {
            return Err(TestError::Fail("Shader compilation failed".to_string()));
        }
        let program_compute = ShaderProgram::new(
            gl,
            &ProgramSources::default().with(ShaderType::Compute, self.shaders[SHADERTYPE_COMPUTE].as_str()),
        );
        if !program_compute.is_ok() {
            return Err(TestError::Fail("Shader compilation failed".to_string()));
        }

        // SAFETY: a current context.
        unsafe {
            gl.clear_color(0.5, 0.5, 0.5, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }

        if self.tested_shader == SHADERTYPE_COMPUTE {
            Self::execute_compute_shader(context, &program_compute)?;
        } else {
            Self::render_quad(context, &program)?;
        }
        // SAFETY: a current context.
        unsafe { gl.flush() };
        Ok(())
    }

    fn render_quad(context: &Context, program: &ShaderProgram<'_>) -> Res<()> {
        let gl = context.gl();
        gl_call!(gl, "glUseProgram failed", gl.use_program(program.program()));
        glu::draw(
            &context.render_context,
            program.program(),
            &[va::float("inPosition", 2, 4, 0, &POSITION)],
            &pr::patches(&QUAD_INDICES),
        )?;
        glu::expect_no_error(gl, "glu::draw error")?;
        gl_call!(
            gl,
            "glMemoryBarrier() error",
            gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT)
        );
        Ok(())
    }

    fn execute_compute_shader(context: &Context, program_compute: &ShaderProgram<'_>) -> Res<()> {
        let gl = context.gl();
        let output_texture = glu::Texture::new(gl);
        gl_call!(gl, "glUseProgram failed", gl.use_program(program_compute.program()));

        // output image
        gl_call!(
            gl,
            "glBindTexture",
            gl.bind_texture(glw::GL_TEXTURE_2D, output_texture.get())
        );
        gl_call!(
            gl,
            "glTexStorage2D",
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA32F, 16, 16)
        );
        gl_call!(
            gl,
            "glTexParameteri",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint)
        );
        gl_call!(
            gl,
            "Uploading image data failed",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint)
        );

        // bind image
        gl_call!(
            gl,
            "Image setup failed",
            gl.bind_image_texture(
                2,
                output_texture.get(),
                0,
                glw::FALSE,
                0,
                glw::GL_READ_WRITE,
                glw::GL_RGBA32F
            )
        );

        // dispatch compute
        gl_call!(gl, "glDispatchCompute() error", gl.dispatch_compute(1, 1, 1));
        gl_call!(
            gl,
            "glMemoryBarrier() error",
            gl.memory_barrier(glw::GL_TEXTURE_FETCH_BARRIER_BIT)
        );

        // render output texture
        let vs = "#version 450 core\nin highp vec2 position;\nin vec2 inTexcoord;\nout vec2 texcoord;\nvoid main()\n{\n    texcoord = inTexcoord;\n    gl_Position = vec4(position, 0.0, 1.0);\n}\n";
        let fs = "#version 450 core\nuniform sampler2D sampler;\nin vec2 texcoord;\nout vec4 color;\nvoid main()\n{\n    color = texture(sampler, texcoord);\n}\n";
        let render_shader = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vs, fs));
        if !render_shader.is_ok() {
            return Err(TestError::Fail("Shader compilation failed".to_string()));
        }

        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_2D, output_texture.get())
        );
        gl_call!(
            gl,
            "texParameteri failed",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint)
        );
        gl_call!(
            gl,
            "texParameteri failed",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint)
        );
        gl_call!(gl, "useProgram failed", gl.use_program(render_shader.program()));
        // SAFETY: a linked program and a NUL-terminated name.
        let location = unsafe { gl.get_uniform_location(render_shader.program(), c"sampler".as_ptr()) };
        gl_call!(gl, "glUniform1i failed", gl.uniform_1i(location, 0));

        glu::draw(
            &context.render_context,
            render_shader.program(),
            &[
                va::float("position", 2, 4, 0, &POSITION),
                va::float("inTexcoord", 2, 4, 0, &TEX_COORD),
            ],
            &pr::triangle_strip(&QUAD_INDICES),
        )?;
        glu::expect_no_error(gl, "glu::draw error")
    }
}

#[derive(Clone, Copy)]
enum Kind {
    AdditionSubtraction,
    MinMax,
    Bitwise,
    Exchange,
}

impl Kind {
    fn name(self) -> &'static str {
        match self {
            Self::AdditionSubtraction => "ShaderAtomicCounterOpsAdditionSubstractionTestCase",
            Self::MinMax => "ShaderAtomicCounterOpsMinMaxTestCase",
            Self::Bitwise => "ShaderAtomicCounterOpsBitwiseTestCase",
            Self::Exchange => "ShaderAtomicCounterOpsExchangeTestCase",
        }
    }

    /// `setOperations`
    fn operations(self) -> Vec<AtomicOperation> {
        match self {
            Self::AdditionSubtraction => {
                let (input, param) = (12, 4);
                vec![
                    AtomicOperation::new(OpKind::Add, input, param, 0),
                    AtomicOperation::new(OpKind::Subtract, input, param, 0),
                ]
            }
            Self::MinMax => {
                let input = 12;
                let params = [4, 16];
                vec![
                    AtomicOperation::new(OpKind::Min, input, params[0], 0),
                    AtomicOperation::new(OpKind::Min, input, params[1], 0),
                    AtomicOperation::new(OpKind::Max, input, params[0], 0),
                    AtomicOperation::new(OpKind::Max, input, params[1], 0),
                ]
            }
            Self::Bitwise => {
                let input = 0x2ED; // 0b1011101101
                let param = 0x3A9; // 0b1110101001
                vec![
                    AtomicOperation::new(OpKind::And, input, param, 0),
                    AtomicOperation::new(OpKind::Or, input, param, 0),
                    AtomicOperation::new(OpKind::Xor, input, param, 0),
                ]
            }
            Self::Exchange => {
                let (input, param) = (5, 10);
                let compare = [5, 20];
                vec![
                    AtomicOperation::new(OpKind::Exchange, input, param, 0),
                    AtomicOperation::new(OpKind::CompSwap, input, param, compare[0]),
                    AtomicOperation::new(OpKind::CompSwap, input, param, compare[1]),
                ]
            }
        }
    }
}

fn get_integer(gl: &glw::Functions, pname: glw::GLenum) -> GLint {
    let mut value = 1;
    // SAFETY: one GLint out.
    unsafe { gl.get_integerv(pname, &mut value) };
    value
}

/// `fillAtomicCounterBuffer`
fn fill_atomic_counter_buffer(
    gl: &glw::Functions,
    atomic_counter_buffer: GLuint,
    calls_buffer: GLuint,
    input_value: u32,
) -> Res<()> {
    for (buffer, value) in [(atomic_counter_buffer, input_value), (calls_buffer, 0)] {
        gl_call!(
            gl,
            "bindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, buffer)
        );
        // SAFETY: the buffer holds one GLuint.
        let data_ptr = unsafe {
            gl.map_buffer_range(
                glw::GL_ATOMIC_COUNTER_BUFFER,
                0,
                4,
                glw::GL_MAP_WRITE_BIT | glw::GL_MAP_INVALIDATE_BUFFER_BIT | glw::GL_MAP_UNSYNCHRONIZED_BIT,
            )
        };
        glu::expect_no_error(gl, "mapBufferRange() call failed.")?;
        if data_ptr.is_null() {
            return Err(TestError::Fail("mapBufferRange() returned NULL.".to_string()));
        }
        // SAFETY: the mapping covers one GLuint.
        unsafe { data_ptr.cast::<u32>().write(value) };
        gl_call!(
            gl,
            "unmapBuffer() call failed.",
            gl.unmap_buffer(glw::GL_ATOMIC_COUNTER_BUFFER)
        );
    }
    Ok(())
}

fn read_counter(gl: &glw::Functions, buffer: GLuint) -> Res<u32> {
    gl_call!(
        gl,
        "bindBuffer() call failed.",
        gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, buffer)
    );
    // SAFETY: the buffer holds one GLuint.
    let data_ptr = unsafe { gl.map_buffer_range(glw::GL_ATOMIC_COUNTER_BUFFER, 0, 4, glw::GL_MAP_READ_BIT) };
    glu::expect_no_error(gl, "mapBufferRange() call failed.")?;
    if data_ptr.is_null() {
        return Err(TestError::Fail("mapBufferRange() returned NULL.".to_string()));
    }
    // SAFETY: the mapping covers one GLuint.
    let value = unsafe { data_ptr.cast::<u32>().read() };
    gl_call!(
        gl,
        "unmapBuffer() call failed.",
        gl.unmap_buffer(glw::GL_ATOMIC_COUNTER_BUFFER)
    );
    Ok(value)
}

/// `validateColor`
fn validate_color(tested_color: [f32; 4], desired_color: [f32; 4]) -> bool {
    let epsilon = 1.1f32 / 31.0; // Accommodate framebuffers with 5-bit channels.
    (0..3).all(|c| (tested_color[c] - desired_color[c]).abs() < epsilon)
}

/// `validateScreenPixels`
fn validate_screen_pixels(context: &Context, desired_color: [f32; 4], ignored_color: [f32; 4]) -> bool {
    let gl = context.gl();
    let render_target = context.render_target();
    let (width, height) = (render_target.width, render_target.height);

    let mut pixels = vec![-1.0f32; (width * height * 4) as usize];
    // read pixels
    // SAFETY: the buffer holds a whole RGBA float image of the render target's size.
    unsafe {
        gl.read_pixels(
            0,
            0,
            width,
            height,
            glw::GL_RGBA,
            glw::GL_FLOAT,
            pixels.as_mut_ptr().cast(),
        )
    };

    // validate pixels
    let mut rendered = false;
    for x in 0..width {
        for y in 0..height {
            let mapped_pixel_position = (y * width + x) as usize;
            let color: [f32; 4] = std::array::from_fn(|c| pixels[mapped_pixel_position * 4 + c]);
            if !validate_color(color, ignored_color) {
                rendered = true;
                if !validate_color(color, desired_color) {
                    return false;
                }
            }
        }
    }
    rendered
}

struct AtomicCounterOpsCase {
    kind: Kind,
}

impl AtomicCounterOpsCase {
    fn gl46(context: &Context) -> bool {
        context.context_type().supports_core(4, 6)
    }
}

impl TestCase for AtomicCounterOpsCase {
    fn name(&self) -> &str {
        self.kind.name()
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !Self::gl46(context)
            && (!context
                .context_info
                .is_extension_supported("GL_ARB_shader_atomic_counters")
                || !context
                    .context_info
                    .is_extension_supported("GL_ARB_shader_atomic_counter_ops"))
        {
            return Err(TestError::NotSupported("Not supported".to_string()));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let context_gl46 = Self::gl46(context);

        // init: generate atomic counter buffer and the calls buffer
        let atomic_counter_buffer = glu::Buffer::new(gl);
        glu::expect_no_error(gl, "genBuffers() call failed.")?;
        gl_call!(
            gl,
            "bindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, atomic_counter_buffer.get())
        );
        gl_call!(
            gl,
            "bufferData() call failed.",
            gl.buffer_data(glw::GL_ATOMIC_COUNTER_BUFFER, 4, std::ptr::null(), glw::GL_DYNAMIC_DRAW)
        );
        let calls_buffer = glu::Buffer::new(gl);
        glu::expect_no_error(gl, "genBuffers() call failed.")?;
        gl_call!(
            gl,
            "bindBuffer() call failed.",
            gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, calls_buffer.get())
        );
        gl_call!(
            gl,
            "bufferData() call failed.",
            gl.buffer_data(glw::GL_ATOMIC_COUNTER_BUFFER, 4, std::ptr::null(), glw::GL_DYNAMIC_DRAW)
        );

        // setup tested atomic operations: addOperation
        let operations = self.kind.operations();
        let mut pipelines = Vec::new();
        for (operation_index, operation) in operations.iter().enumerate() {
            for i in 0..SHADERTYPE_LAST {
                let max_atomic_buffers = match i {
                    SHADERTYPE_VERTEX => get_integer(gl, glw::GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS),
                    SHADERTYPE_GEOMETRY => get_integer(gl, glw::GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS),
                    SHADERTYPE_TESSELLATION_CONTROL => get_integer(gl, glw::GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS),
                    SHADERTYPE_TESSELLATION_EVALUATION => {
                        get_integer(gl, glw::GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS)
                    }
                    // rest of the stages must support atomics
                    _ => 1,
                };
                if max_atomic_buffers < 1 {
                    continue;
                }
                pipelines.push(Pipeline {
                    tested_shader: i,
                    operation: operation_index,
                    shaders: pipeline_shaders(i, operation, context_gl46),
                });
            }
        }

        for pipeline in &pipelines {
            let operation = &operations[pipeline.operation];

            fill_atomic_counter_buffer(
                gl,
                atomic_counter_buffer.get(),
                calls_buffer.get(),
                operation.input_value,
            )?;

            // bindBuffers
            gl_call!(
                gl,
                "bindBufferBase() call failed.",
                gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, atomic_counter_buffer.get())
            );
            gl_call!(
                gl,
                "bindBufferBase() call failed.",
                gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 1, calls_buffer.get())
            );

            pipeline.test(context)?;

            // checkAtomicCounterBuffer
            let final_value = read_counter(gl, atomic_counter_buffer.get())?;
            let number_of_calls = read_counter(gl, calls_buffer.get())?;
            if final_value != operation.get_result(number_of_calls) {
                return Err(TestError::Fail(format!(
                    "Result of atomic operation was different than expected ({}).",
                    operation.function
                )));
            }

            if !validate_screen_pixels(context, [1.0; 4], [0.5; 4]) {
                return Err(TestError::Fail(format!(
                    "Result of atomic operation return value was different than expected ({}).",
                    operation.function
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `ShaderAtomicCounterOps::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_atomic_counter_ops_tests");
    for kind in [Kind::AdditionSubtraction, Kind::MinMax, Kind::Bitwise, Kind::Exchange] {
        group.add_child(Box::new(AtomicCounterOpsCase { kind }) as Box<dyn TestCase>);
    }
    group
}
