// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderBallotTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream builds the pipelines in each case's constructor and compiles them in `iterate`; the tree here exists before any context does, so both happen in `iterate`. The `ShaderPipeline` subclass of `ShaderBallotFunctionReadTestCase` is the `with_buffer` flag of the one `ShaderPipeline` here.

use std::collections::BTreeMap;

use crate::glu::{self, Context, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup, pr, va};
use crate::glw::{self, GLuint};
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const SHADER_TYPES: [ShaderType; 6] = [
    ShaderType::Vertex,
    ShaderType::Fragment,
    ShaderType::Geometry,
    ShaderType::TessControl,
    ShaderType::TessEvaluation,
    ShaderType::Compute,
];

const READ_INVOCATION_SUFFIX: u32 = 0;
const READ_FIRST_INVOCATION_SUFFIX: u32 = 10;

const QUAD_INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];
const POSITION: [f32; 8] = [-1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0];
const TEX_COORD: [f32; 8] = [0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0];

const TESTED_HEAD_PART: &str =
    "#extension GL_ARB_shader_ballot : enable\n#extension GL_ARB_gpu_shader_int64 : enable\n";

const DISPLAY_VERTEX_SHADER: &str = "#version 450 core\n\
    in highp vec2 position;\n\
    in vec2 inTexcoord;\n\
    out vec2 texcoord;\n\
    void main()\n\
    {\n\
    \x20   texcoord = inTexcoord;\n\
    \x20   gl_Position = vec4(position, 0.0, 1.0);\n\
    }\n";

const DISPLAY_FRAGMENT_SHADER: &str = "#version 450 core\n\
    uniform sampler2D sampler;\n\
    in vec2 texcoord;\n\
    out vec4 color;\n\
    void main()\n\
    {\n\
    \x20   color = texture(sampler, texcoord);\n\
    }\n";

type SpecializationMap = BTreeMap<&'static str, String>;

/// `glu::Texture`
struct Texture<'gl> {
    gl: &'gl glw::Functions,
    id: GLuint,
}

impl<'gl> Texture<'gl> {
    fn new(gl: &'gl glw::Functions) -> Self {
        let mut id: GLuint = 0;
        // SAFETY: a current context and a live local.
        unsafe { gl.gen_textures(1, &mut id) };
        Self { gl, id }
    }
}

impl Drop for Texture<'_> {
    fn drop(&mut self) {
        // SAFETY: the texture generated in `new`, deleted once.
        unsafe { self.gl.delete_textures(1, &self.id) };
    }
}

/// The shader parts of every stage, joined; `testedShader` gets the head, the extra declarations and the content snippet.
fn shader_sources(
    tested_shader: ShaderType,
    content_snippet: &str,
    additional_layout: &str,
    additional_functions: &str,
) -> [String; 6] {
    let tested = |stage: ShaderType, text: &'static str| if tested_shader == stage { text } else { "" };
    let head = |stage: ShaderType| tested(stage, TESTED_HEAD_PART);
    let layout = |stage: ShaderType| if tested_shader == stage { additional_layout } else { "" };
    let functions = |stage: ShaderType| {
        if tested_shader == stage {
            additional_functions
        } else {
            ""
        }
    };
    let content = |stage: ShaderType| if tested_shader == stage { content_snippet } else { "" };

    let vertex = [
        "#version 450 core\n",
        head(ShaderType::Vertex),
        "layout(location = 0) in highp vec2 inPosition;\n\
         layout(location = 0) flat out highp vec4 vsColor;\n\
         layout(location = 1) out highp vec3 vsPosition;\n",
        layout(ShaderType::Vertex),
        "\n",
        functions(ShaderType::Vertex),
        "\n",
        "void main()\n\
         {\n\
         \x20   gl_Position = vec4(inPosition, 0.0, 1.0);\n\
         \x20   vsPosition = vec3(inPosition, 0.0);\n\
         \x20   vec4 outColor = vec4(0.0); \n",
        content(ShaderType::Vertex),
        "    vsColor = outColor;\n}\n",
    ]
    .concat();

    let fragment = [
        "#version 450 core\n",
        head(ShaderType::Fragment),
        "layout(location = 0) in flat highp vec4 gsColor;\n\
         layout(location = 0) out highp vec4 fsColor;\n",
        layout(ShaderType::Fragment),
        "\n",
        functions(ShaderType::Fragment),
        "\n",
        "void main()\n\
         {\n\
         \x20   vec4 outColor = vec4(0.0); \n",
        if tested_shader == ShaderType::Fragment {
            content_snippet
        } else {
            "    outColor = gsColor;\n"
        },
        "    fsColor = outColor;\n}\n",
    ]
    .concat();

    let tess_control = [
        "#version 450 core\n",
        head(ShaderType::TessControl),
        "layout(vertices = 3) out;\n\
         layout(location = 0) in flat highp vec4 vsColor[];\n\
         layout(location = 1) in highp vec3 vsPosition[];\n\
         layout(location = 0) out flat highp vec4 tcsColor[];\n\
         layout(location = 1) out highp vec3 tcsPosition[];\n",
        layout(ShaderType::TessControl),
        "\n",
        functions(ShaderType::TessControl),
        "\n",
        "void main()\n\
         {\n\
         \x20   tcsPosition[gl_InvocationID] = vsPosition[gl_InvocationID];\n\
         \x20   vec4 outColor = vec4(0.0);\n",
        if tested_shader == ShaderType::TessControl {
            content_snippet
        } else {
            "    outColor = vsColor[gl_InvocationID];\n"
        },
        "    tcsColor[gl_InvocationID] = outColor;\n\
         \x20   gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n\
         \x20   gl_TessLevelInner[0] = 3;\n\
         \x20   gl_TessLevelInner[1] = 3;\n\
         \x20   gl_TessLevelOuter[0] = 3;\n\
         \x20   gl_TessLevelOuter[1] = 3;\n\
         \x20   gl_TessLevelOuter[2] = 3;\n\
         \x20   gl_TessLevelOuter[3] = 3;\n\
         }\n",
    ]
    .concat();

    let tess_evaluation = [
        "#version 450 core\n",
        head(ShaderType::TessEvaluation),
        "layout(triangles, equal_spacing, cw) in;\n\
         layout(location = 0) in flat highp vec4 tcsColor[];\n\
         layout(location = 1) in highp vec3 tcsPosition[];\n\
         layout(location = 0) out flat highp vec4 tesColor;\n",
        layout(ShaderType::TessEvaluation),
        "\n",
        functions(ShaderType::TessEvaluation),
        "\n",
        "void main()\n\
         {\n\
         \x20   float u = gl_TessCoord.x;\n\
         \x20   float v = gl_TessCoord.y;\n\
         \x20   float w = gl_TessCoord.z;\n\
         \x20   vec4 pos0 = gl_in[0].gl_Position;\n\
         \x20   vec4 pos1 = gl_in[1].gl_Position;\n\
         \x20   vec4 pos2 = gl_in[2].gl_Position;\n\
         \x20   gl_Position = u * pos0 + v * pos1 + w * pos2;\n\
         \x20   vec4 outColor = vec4(0.0);\n",
        if tested_shader == ShaderType::TessEvaluation {
            content_snippet
        } else {
            "    outColor = tcsColor[0];\n"
        },
        "    tesColor = outColor;\n}\n",
    ]
    .concat();

    let geometry = [
        "#version 450 core\n",
        head(ShaderType::Geometry),
        "layout(triangles) in;\n\
         layout(triangle_strip, max_vertices = 3) out;\n\
         layout(location = 0) in flat highp vec4 tesColor[];\n\
         layout(location = 0) out flat highp vec4 gsColor;\n",
        layout(ShaderType::Geometry),
        "\n",
        functions(ShaderType::Geometry),
        "\n",
        "void main()\n\
         {\n\
         \x20   vec4 outColor = vec4(0.0);\n",
        content(ShaderType::Geometry),
        "    for (int i = 0; i<3; i++)\n\
         \x20   {\n\
         \x20       gl_Position = gl_in[i].gl_Position;\n",
        if tested_shader == ShaderType::Geometry {
            ""
        } else {
            "        outColor = tesColor[i];\n"
        },
        "        gsColor = outColor;\n\
         \x20       EmitVertex();\n\
         \x20   }\n\
         \x20   EndPrimitive();\n\
         }\n",
    ]
    .concat();

    let compute = [
        "#version 450 core\n",
        head(ShaderType::Compute),
        "layout(rgba32f, binding = 1) writeonly uniform highp image2D destImage;\n\
         layout (local_size_x = 16, local_size_y = 16) in;\n",
        layout(ShaderType::Compute),
        "\n",
        functions(ShaderType::Compute),
        "\n",
        "void main (void)\n\
         {\n\
         vec4 outColor = vec4(0.0);\n",
        content(ShaderType::Compute),
        "imageStore(destImage, ivec2(gl_GlobalInvocationID.xy), outColor);\n}\n",
    ]
    .concat();

    [vertex, fragment, geometry, tess_control, tess_evaluation, compute]
}

/// `ShaderBallotBaseTestCase::ShaderPipeline` (and, with `with_buffer`, `ShaderBallotFunctionReadTestCase::ShaderPipeline`)
struct ShaderPipeline {
    tested_shader: ShaderType,
    file_name_suffix_offset: u32,
    shaders: [String; 6],
    specialization_map: SpecializationMap,
    with_buffer: bool,
}

/// `m_programRender` and `m_programCompute`
struct Programs<'gl> {
    render: ShaderProgram<'gl>,
    compute: ShaderProgram<'gl>,
}

impl ShaderPipeline {
    fn new(tested_shader: ShaderType, content_snippet: &str, specialization_map: SpecializationMap) -> Self {
        Self {
            tested_shader,
            file_name_suffix_offset: 0,
            shaders: shader_sources(tested_shader, content_snippet, "", ""),
            specialization_map,
            with_buffer: false,
        }
    }

    fn new_read(
        tested_shader: ShaderType,
        additional_layout: &str,
        additional_functions: &str,
        content_snippet: &str,
        file_name_suffix_offset: u32,
    ) -> Self {
        Self {
            tested_shader,
            file_name_suffix_offset,
            shaders: shader_sources(tested_shader, content_snippet, additional_layout, additional_functions),
            specialization_map: SpecializationMap::new(),
            with_buffer: true,
        }
    }

    /// `TestCaseBase::specializeShader` on the parts of one stage
    fn specialized(&self, shader_type: ShaderType) -> Result<String, TestError> {
        let params: Vec<(&str, String)> = self
            .specialization_map
            .iter()
            .map(|(key, value)| (*key, value.clone()))
            .collect();
        StringTemplate::new(self.shaders[shader_type as usize].as_str()).specialize(&params)
    }

    /// `ShaderBallotBaseTestCase::createShaderPrograms`
    fn create_shader_programs<'gl>(&self, context: &'gl Context) -> Result<Programs<'gl>, TestError> {
        let mut sources_render = ProgramSources::default();
        for shader_type in &SHADER_TYPES[..5] {
            sources_render = sources_render.with(*shader_type, self.specialized(*shader_type)?);
        }

        let program_render = ShaderProgram::new(context.gl(), &sources_render);
        if !program_render.is_ok() {
            return Err(TestError::Fail("Shader compilation failed".to_string()));
        }

        let sources_compute =
            ProgramSources::default().with(ShaderType::Compute, self.specialized(ShaderType::Compute)?);
        let program_compute = ShaderProgram::new(context.gl(), &sources_compute);
        if !program_compute.is_ok() {
            return Err(TestError::Fail("Shader compilation failed".to_string()));
        }

        Ok(Programs {
            render: program_render,
            compute: program_compute,
        })
    }

    /// `test`
    fn test(&self, context: &Context, programs: &Programs<'_>) -> Result<(), TestError> {
        if self.tested_shader == ShaderType::Compute {
            self.execute_compute_shader(context, programs)
        } else {
            self.render_quad(context, programs)
        }
    }

    /// `use`
    fn use_program(&self, context: &Context, programs: &Programs<'_>) -> Result<(), TestError> {
        let gl = context.gl();
        gl_call!(gl, "glUseProgram failed", gl.use_program(programs.render.program()));
        Ok(())
    }

    /// `createAndBindBuffer` of the read test
    fn create_and_bind_buffer(context: &Context) -> GLuint {
        let gl = context.gl();
        const ELEMS: u32 = 128;
        let data1: Vec<GLuint> = (0..ELEMS).map(|i| i % 64).collect();
        let size = (ELEMS as usize * size_of::<GLuint>()) as glw::GLsizeiptr;
        let mut buffer: GLuint = 0;

        // SAFETY: a current context; `data1` holds `size` bytes.
        unsafe {
            gl.gen_buffers(1, &mut buffer);
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer);
            gl.buffer_data(
                glw::GL_SHADER_STORAGE_BUFFER,
                size,
                data1.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, buffer);
        }
        buffer
    }

    /// `destroyBuffer` of the read test
    fn destroy_buffer(context: &Context, buffer: GLuint) {
        let gl = context.gl();
        // SAFETY: a current context; the buffer made by `create_and_bind_buffer`.
        unsafe {
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0);
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, 0);
            gl.delete_buffers(1, &buffer);
        }
    }

    /// `renderQuad`
    fn render_quad(&self, context: &Context, programs: &Programs<'_>) -> Result<(), TestError> {
        let gl = context.gl();
        let vertex_arrays = [va::float("inPosition", 2, 4, 0, &POSITION)];

        self.use_program(context, programs)?;

        let buffer = self.with_buffer.then(|| Self::create_and_bind_buffer(context));

        let draw_result = glu::draw(
            &context.render_context,
            programs.render.program(),
            &vertex_arrays,
            &pr::patches(&QUAD_INDICES),
        );
        // SAFETY: glGetError needs nothing but a current context.
        let draw_status = unsafe { gl.get_error() };

        if let Some(buffer) = buffer {
            Self::destroy_buffer(context, buffer);
        }
        draw_result?;

        if draw_status != glw::GL_NO_ERROR {
            return Err(TestError::Fail(format!(
                "glu::draw error: got GL error 0x{draw_status:04x}"
            )));
        }
        Ok(())
    }

    /// `executeComputeShader`
    fn execute_compute_shader(&self, context: &Context, programs: &Programs<'_>) -> Result<(), TestError> {
        let gl = context.gl();
        let output_texture = Texture::new(gl);
        let render_target = context.render_target();
        let (width, height) = if self.with_buffer {
            (render_target.width, render_target.height)
        } else {
            (16, 16)
        };

        gl_call!(gl, "useProgram", gl.use_program(programs.compute.program()));

        // output image
        gl_call!(
            gl,
            "bindTexture",
            gl.bind_texture(glw::GL_TEXTURE_2D, output_texture.id)
        );
        gl_call!(
            gl,
            "texStorage2D",
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, width, height)
        );
        gl_call!(
            gl,
            "texParameteri",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32)
        );
        gl_call!(
            gl,
            "Uploading image data failed",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32)
        );

        // bind image
        gl_call!(
            gl,
            "Image setup failed",
            gl.bind_image_texture(
                1,
                output_texture.id,
                0,
                glw::FALSE,
                0,
                glw::GL_READ_WRITE,
                glw::GL_RGBA8
            )
        );

        // create buffer
        let buffer = self.with_buffer.then(|| Self::create_and_bind_buffer(context));

        // dispatch compute
        let (groups_x, groups_y) = if self.with_buffer {
            (width as u32, height as u32)
        } else {
            (1, 1)
        };
        gl_call!(gl, "glDispatchCompute()", gl.dispatch_compute(groups_x, groups_y, 1));
        gl_call!(
            gl,
            "glMemoryBarrier()",
            gl.memory_barrier(glw::GL_TEXTURE_FETCH_BARRIER_BIT)
        );

        if let Some(buffer) = buffer {
            Self::destroy_buffer(context, buffer);
        }

        // render output texture
        let render_program = ShaderProgram::new(
            gl,
            &ProgramSources::vtx_frag(DISPLAY_VERTEX_SHADER, DISPLAY_FRAGMENT_SHADER),
        );

        if !(if self.with_buffer {
            render_program.is_ok()
        } else {
            programs.render.is_ok()
        }) {
            return Err(TestError::Fail("Shader compilation failed".to_string()));
        }

        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_2D, output_texture.id)
        );

        // SAFETY: a current context.
        unsafe {
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
            gl.use_program(render_program.program());
        }

        // SAFETY: a NUL-terminated name and a program that was just built.
        let location = unsafe { gl.get_uniform_location(render_program.program(), c"sampler".as_ptr()) };
        gl_call!(gl, "glUniform1i failed", gl.uniform_1i(location, 0));

        let vertex_arrays = [
            va::float("position", 2, 4, 0, &POSITION),
            va::float("inTexcoord", 2, 4, 0, &TEX_COORD),
        ];

        if self.with_buffer {
            // SAFETY: a current context.
            unsafe { gl.viewport(0, 0, width, height) };
        }

        glu::draw(
            &context.render_context,
            render_program.program(),
            &vertex_arrays,
            &pr::triangle_strip(&QUAD_INDICES),
        )?;
        glu::expect_no_error(gl, "glu::draw error")?;
        Ok(())
    }
}

/// `ShaderBallotBaseTestCase::validateColor`
fn validate_color(tested_color: [f32; 4], desired_color: [f32; 4]) -> bool {
    const EPSILON: f32 = 0.008;
    tested_color
        .iter()
        .zip(&desired_color)
        .all(|(tested, desired)| (tested - desired).abs() < EPSILON)
}

/// `ShaderBallotBaseTestCase::validateScreenPixels`
fn validate_screen_pixels(context: &Context, desired_color: [f32; 4], ignored_color: [f32; 4]) -> bool {
    let gl = context.gl();
    let render_target = context.render_target();
    let (width, height) = (render_target.width, render_target.height);

    let mut pixels = vec![-1.0f32; width as usize * height as usize * 4];

    // SAFETY: `pixels` holds width * height RGBA floats.
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

    let mut rendered = false;
    for pixel in pixels.chunks_exact(4) {
        let color = [pixel[0], pixel[1], pixel[2], pixel[3]];
        if !validate_color(color, ignored_color) {
            rendered = true;
            if !validate_color(color, desired_color) {
                return false;
            }
        }
    }

    rendered
}

/// `ShaderBallotBaseTestCase::validateScreenPixelsSameColor`
fn validate_screen_pixels_same_color(context: &Context, ignored_color: [f32; 4]) -> bool {
    let gl = context.gl();
    let mut top_left_pixel = [-1.0f32; 4];

    // SAFETY: one RGBA float pixel.
    unsafe {
        gl.read_pixels(
            0,
            0,
            1,
            1,
            glw::GL_RGBA,
            glw::GL_FLOAT,
            top_left_pixel.as_mut_ptr().cast(),
        )
    };

    validate_screen_pixels(context, top_left_pixel, ignored_color)
}

fn check_ballot_support(context: &Context) -> Result<(), TestError> {
    if !context.context_info.is_extension_supported("GL_ARB_shader_ballot")
        || !context.context_info.is_extension_supported("GL_ARB_gpu_shader_int64")
    {
        return Err(TestError::NotSupported(
            "GL_ARB_shader_ballot or GL_ARB_gpu_shader_int64 not supported".to_string(),
        ));
    }
    Ok(())
}

#[derive(Clone, Copy)]
enum Kind {
    Availability,
    Bitmasks,
    FunctionBallot,
    FunctionRead,
}

const AVAILABILITY_SNIPPET: &str = "    float red = gl_SubGroupSizeARB / 64.0f;\n\
    \x20   float green = 1.0f - (gl_SubGroupInvocationARB / float(gl_SubGroupSizeARB));\n\
    \x20   float blue = float(ballotARB(true) % 256) / 256.0f;\n\
    \x20   outColor = readInvocationARB(vec4(red, green, blue, 1.0f), gl_SubGroupInvocationARB);\n";

const BITMASKS_SNIPPET: &str = "    uint64_t mask = 0;\n\
    \x20   for(uint i = 0; i < gl_SubGroupSizeARB; ++i)\n\
    \x20   {\n\
    \x20       if(i ${MASK_OPERATOR} gl_SubGroupInvocationARB)\n\
    \x20           mask = mask | (1ul << i);\n\
    \x20   }\n\
    \x20   float color = (${MASK_VAR} ^ mask) == 0ul ? 1.0 : 0.0;\n\
    \x20   outColor = vec4(color, color, color, 1.0);\n";

const BALLOT_FALSE_SNIPPET: &str = "    uint64_t result = ballotARB(false);\n\
    \x20   float color = result == 0ul ? 1.0 : 0.0;\n\
    \x20   outColor = vec4(color, color, color, 1.0);\n";

const BALLOT_TRUE_SNIPPET: &str = "    uint64_t result = ballotARB(true);\n\
    \x20   float color = result != 0ul ? 1.0 : 0.0;\n\
    \x20   uint64_t invocationBit = 1ul << gl_SubGroupInvocationARB;\n\
    \x20   color *= float(invocationBit & result);\n\
    \x20   outColor = vec4(color, color, color, 1.0);\n";

const BALLOT_MIXED_SNIPPET: &str = "    bool param = (gl_SubGroupInvocationARB % 2) == 0ul;\n\
    \x20   uint64_t result = ballotARB(param);\n\
    \x20   float color = (param && result != 0ul) || !param ? 1.0 : 0.0;\n\
    \x20   outColor = vec4(color, color, color, 1.0);\n";

const READ_ADDITIONAL_FUNCTIONS: &str = r#"
    bool subgroupBallotBitExtract(uint64_t value, uint index)
    {
        if (index >= 64)
            return false;
        const uint64_t mask = 1ul << index;
        if (bool((value & mask)) == true)
            return true;
        return false;
    }
    "#;

const READ_ADDITIONAL_LAYOUT: &str = r#"
    layout(std430, binding = 0) readonly buffer buffer1
    {
        uint data1[];
    };
    "#;

const READ_FIRST_SNIPPET: &str = r#"
    const uint sgSize = gl_SubGroupSizeARB;
    const uint sgInvocation = gl_SubGroupInvocationARB;
    uint tempRes = 0;
    uint firstActive = sgSize;
    uint64_t mask = ballotARB(true);
    for (uint i = 0; i < sgSize; i++)
    {
        if (subgroupBallotBitExtract(mask, i))
        {
            firstActive = i;
            break;
        }
    }
    tempRes |= (readFirstInvocationARB(data1[sgInvocation]) == data1[firstActive]) ? 0x1 : 0;
    // make the firstActive invocation inactive now
    if (firstActive != sgInvocation)
    {
        mask = ballotARB(true);
        for (uint i = 0; i < sgSize; i++)
        {
            if (subgroupBallotBitExtract(mask, i))
            {
                firstActive = i;
                break;
            }
        }
        tempRes |= (readFirstInvocationARB(data1[sgInvocation]) == data1[firstActive]) ? 0x2 : 0;
    }
    else
    {
        // the firstActive invocation didn't partake in the second result so set it to true
        tempRes |= 0x2;
    }
    outColor = (0x3 == tempRes) ? vec4(1.0, 1.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
    "#;

fn read_snippet() -> String {
    let mut snippet = String::from(
        r#"
    const uint64_t mask = ballotARB(true);
    const uint sgSize = gl_SubGroupSizeARB;
    const uint sgInvocation = gl_SubGroupInvocationARB;
    float tempRes = 1.0;
    uint ops[64];
    const uint d = data1[sgInvocation];
"#,
    );
    for i in 0..64 {
        snippet.push_str(&format!("    ops[{i}] = readInvocationARB(d, {i}u);\n"));
    }
    snippet.push_str(
        r#"    for (int id = 0; id < sgSize; id++)
    {
        if (subgroupBallotBitExtract(mask, id) && ops[id] != data1[id])
        {
            tempRes = 0.0;
        }
    }
    outColor = vec4(tempRes, tempRes, tempRes, 1.0);
    "#,
    );
    snippet
}

/// The four `ShaderBallot*TestCase` classes
struct ShaderBallotCase {
    case_name: &'static str,
    kind: Kind,
}

impl ShaderBallotCase {
    /// The constructor of each upstream case
    fn pipelines(&self) -> Vec<ShaderPipeline> {
        let mut pipelines = Vec::new();

        match self.kind {
            Kind::Availability => {
                for tested_shader in SHADER_TYPES {
                    pipelines.push(ShaderPipeline::new(
                        tested_shader,
                        AVAILABILITY_SNIPPET,
                        SpecializationMap::new(),
                    ));
                }
            }
            Kind::Bitmasks => {
                const MASK_VARS: [(&str, &str); 5] = [
                    ("gl_SubGroupEqMaskARB", "=="),
                    ("gl_SubGroupGeMaskARB", ">="),
                    ("gl_SubGroupGtMaskARB", ">"),
                    ("gl_SubGroupLeMaskARB", "<="),
                    ("gl_SubGroupLtMaskARB", "<"),
                ];
                for (mask_var, mask_operator) in MASK_VARS {
                    for tested_shader in SHADER_TYPES {
                        let mut spec_map = SpecializationMap::new();
                        spec_map.insert("MASK_VAR", mask_var.to_string());
                        spec_map.insert("MASK_OPERATOR", mask_operator.to_string());
                        pipelines.push(ShaderPipeline::new(tested_shader, BITMASKS_SNIPPET, spec_map));
                    }
                }
            }
            Kind::FunctionBallot => {
                for tested_shader in SHADER_TYPES {
                    for snippet in [BALLOT_FALSE_SNIPPET, BALLOT_TRUE_SNIPPET, BALLOT_MIXED_SNIPPET] {
                        pipelines.push(ShaderPipeline::new(tested_shader, snippet, SpecializationMap::new()));
                    }
                }
            }
            Kind::FunctionRead => {
                let read = read_snippet();
                for tested_shader in SHADER_TYPES {
                    pipelines.push(ShaderPipeline::new_read(
                        tested_shader,
                        READ_ADDITIONAL_LAYOUT,
                        READ_ADDITIONAL_FUNCTIONS,
                        &read,
                        READ_INVOCATION_SUFFIX,
                    ));
                    pipelines.push(ShaderPipeline::new_read(
                        tested_shader,
                        READ_ADDITIONAL_LAYOUT,
                        READ_ADDITIONAL_FUNCTIONS,
                        READ_FIRST_SNIPPET,
                        READ_FIRST_INVOCATION_SUFFIX,
                    ));
                }
            }
        }

        pipelines
    }

    /// The `iterate` loop shared by the first three cases
    fn iterate_validating(
        &self,
        context: &Context,
        pipelines: &[ShaderPipeline],
        programs: &[Programs<'_>],
    ) -> TestOutcome {
        let gl = context.gl();

        for (pipeline, programs) in pipelines.iter().zip(programs) {
            match self.kind {
                Kind::Availability => gl_call!(gl, "clearColor", gl.clear_color(0.0, 0.0, 0.0, 1.0)),
                _ => gl_call!(gl, "clearColor", gl.clear_color(1.0, 0.0, 0.0, 1.0)),
            }
            gl_call!(gl, "clear", gl.clear(glw::GL_COLOR_BUFFER_BIT));

            pipeline.test(context, programs)?;

            gl_call!(gl, "flush", gl.flush());

            let message = match self.kind {
                Kind::Availability => continue,
                Kind::Bitmasks => "Bitmask value is not correct",
                _ => "Value returned from ballotARB function is not correct",
            };
            if !validate_screen_pixels(context, [1.0, 1.0, 1.0, 1.0], [1.0, 0.0, 0.0, 1.0]) {
                return Err(TestError::Fail(message.to_string()));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// `ShaderBallotFunctionReadTestCase::iterate` after the programs exist
    fn iterate_read(&self, context: &Context, pipelines: &[ShaderPipeline], programs: &[Programs<'_>]) -> TestOutcome {
        let gl = context.gl();
        let render_target = context.render_target();

        let mut failed_shaders: Vec<ShaderType> = Vec::new();

        gl_call!(
            gl,
            "viewport",
            gl.viewport(0, 0, render_target.width, render_target.height)
        );

        for (index, (pipeline, programs)) in pipelines.iter().zip(programs).enumerate() {
            let c = (index + 1) as f32 / (pipelines.len() * 2) as f32;
            gl_call!(gl, "clearColor", gl.clear_color(c, c, c, 1.0));
            let clear_color = [c, c, c, 1.0];

            gl_call!(gl, "clear", gl.clear(glw::GL_COLOR_BUFFER_BIT));

            pipeline.test(context, programs)?;

            gl_call!(gl, "flush", gl.flush());

            let mut top_left_pixel = [-1.0f32; 4];
            // SAFETY: one RGBA float pixel.
            unsafe {
                gl.read_pixels(
                    0,
                    0,
                    1,
                    1,
                    glw::GL_RGBA,
                    glw::GL_FLOAT,
                    top_left_pixel.as_mut_ptr().cast(),
                )
            };

            if !validate_screen_pixels_same_color(context, clear_color) {
                failed_shaders.push(pipeline.tested_shader);
            }
        }

        if failed_shaders.is_empty() {
            return Ok(TestStatus::pass("Pass"));
        }

        let function = if pipelines[0].file_name_suffix_offset == READ_INVOCATION_SUFFIX {
            "readInvocation()"
        } else {
            "readFirstInvocation()"
        };
        let names: Vec<&str> = failed_shaders.iter().map(|shader_type| shader_type.as_str()).collect();
        Ok(TestStatus::fail(format!(
            "{function} failed in the following shader(s): {}",
            names.join(", ")
        )))
    }
}

impl TestCase for ShaderBallotCase {
    fn name(&self) -> &str {
        self.case_name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_ballot_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let pipelines = self.pipelines();
        let programs = pipelines
            .iter()
            .map(|pipeline| pipeline.create_shader_programs(context))
            .collect::<Result<Vec<_>, _>>()?;

        match self.kind {
            Kind::FunctionRead => self.iterate_read(context, &pipelines, &programs),
            _ => self.iterate_validating(context, &pipelines, &programs),
        }
    }
}

/// `ShaderBallotTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_ballot_tests");
    for (case_name, kind) in [
        ("ShaderBallotAvailability", Kind::Availability),
        ("ShaderBallotBitmasks", Kind::Bitmasks),
        ("ShaderBallotFunctionBallot", Kind::FunctionBallot),
        ("ShaderBallotFunctionRead", Kind::FunctionRead),
    ] {
        group.add_child(Box::new(ShaderBallotCase { case_name, kind }) as Box<dyn TestCase>);
    }
    group
}
