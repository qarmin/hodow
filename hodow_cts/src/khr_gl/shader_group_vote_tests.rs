// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcShaderGroupVoteTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Desktop only (the ES work-group height of 8 is not carried over). Upstream builds the shader list in each case's constructor and compiles it in `init`; the tree here exists before any context does, so the list is built and compiled in `iterate`, with the same specialization map.

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

/// `WorkGroupSize`, desktop height.
const WORK_GROUP_WIDTH: i32 = 16;
const WORK_GROUP_HEIGHT: i32 = 16;

type SpecializationMap = BTreeMap<&'static str, String>;

fn specialize_shader(template: &str, map: &SpecializationMap) -> Result<String, TestError> {
    let params: Vec<(&str, String)> = map.iter().map(|(key, value)| (*key, value.clone())).collect();
    StringTemplate::new(template).specialize(&params)
}

/// `ShaderGroupVoteTestCaseBase::ComputeShader`
struct ComputeShader {
    name: &'static str,
    shader: String,
    /// `None` is upstream's `m_compileOnly`.
    desired_color: Option<[i32; 4]>,
}

impl ComputeShader {
    /// `create`
    fn create<'gl>(&self, context: &'gl Context) -> Result<ShaderProgram<'gl>, TestError> {
        let program = ShaderProgram::new(
            context.gl(),
            &ProgramSources::default().with(ShaderType::Compute, self.shader.as_str()),
        );
        if !program.is_ok() {
            log::warn!("{}{}", self.shader, program.build_failure_summary().unwrap_or_default());
            return Err(TestError::Fail("Shader compilation failed".to_string()));
        }
        Ok(program)
    }

    /// `execute`
    fn execute(&self, context: &Context, program: &ShaderProgram<'_>) -> Result<(), TestError> {
        if self.desired_color.is_none() {
            return Ok(());
        }

        let gl = context.gl();
        let mut output_texture: GLuint = 0;
        gl_call!(gl, "glGenTextures", gl.gen_textures(1, &mut output_texture));

        gl_call!(gl, "clearColor", gl.clear_color(0.5, 0.5, 0.5, 1.0));
        gl_call!(gl, "clear", gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl_call!(gl, "useProgram failed", gl.use_program(program.program()));

        // output image
        gl_call!(gl, "bindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, output_texture));
        gl_call!(
            gl,
            "texStorage2D",
            gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                1,
                glw::GL_RGBA8,
                WORK_GROUP_WIDTH,
                WORK_GROUP_HEIGHT
            )
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
            "bindImageTexture failed",
            gl.bind_image_texture(2, output_texture, 0, glw::FALSE, 0, glw::GL_READ_WRITE, glw::GL_RGBA8)
        );

        // dispatch compute
        gl_call!(gl, "dispatchCompute failed", gl.dispatch_compute(1, 1, 1));

        let version_declaration = context.context_type().glsl_version().declaration();

        // render output texture
        let vs = format!(
            "{version_declaration}\n\
             in highp vec2 position;\n\
             in highp vec2 inTexcoord;\n\
             out highp vec2 texcoord;\n\
             void main()\n\
             {{\n\
             \x20   texcoord = inTexcoord;\n\
             \x20   gl_Position = vec4(position, 0.0, 1.0);\n\
             }}\n"
        );
        let fs = format!(
            "{version_declaration}\n\
             uniform highp sampler2D sampler;\n\
             in highp vec2 texcoord;\n\
             out highp vec4 color;\n\
             void main()\n\
             {{\n\
             \x20   color = texture(sampler, texcoord);\n\
             }}\n"
        );

        let render_shader = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vs, fs));
        if !render_shader.is_ok() {
            return Err(TestError::Fail("Shader compilation failed".to_string()));
        }

        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_2D, output_texture)
        );
        gl_call!(
            gl,
            "texParameteri",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32)
        );
        gl_call!(
            gl,
            "texParameteri failed",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32)
        );

        gl_call!(gl, "useProgram failed", gl.use_program(render_shader.program()));
        // SAFETY: a NUL-terminated name and a program that was just built.
        let location = unsafe { gl.get_uniform_location(render_shader.program(), c"sampler".as_ptr()) };
        gl_call!(gl, "glUniform1i failed", gl.uniform_1i(location, 0));

        const QUAD_INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];
        const POSITION: [f32; 8] = [-1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0];
        const TEX_COORD: [f32; 8] = [0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0];
        let vertex_arrays = [
            va::float("position", 2, 4, 0, &POSITION),
            va::float("inTexcoord", 2, 4, 0, &TEX_COORD),
        ];

        gl_call!(gl, "viewport", gl.viewport(0, 0, WORK_GROUP_WIDTH, WORK_GROUP_HEIGHT));
        glu::draw(
            &context.render_context,
            render_shader.program(),
            &vertex_arrays,
            &pr::triangle_strip(&QUAD_INDICES),
        )?;
        glu::expect_no_error(gl, "glu::draw error")?;

        gl_call!(gl, "glFlush", gl.flush());

        // SAFETY: the texture created above, deleted once.
        unsafe { gl.delete_textures(1, &output_texture) };
        Ok(())
    }

    /// `validate`
    fn validate(&self, context: &Context) -> Result<(), TestError> {
        let Some(desired_color) = self.desired_color else {
            return Ok(());
        };

        if !Self::validate_screen_pixels(context, desired_color)? {
            return Err(TestError::Fail(format!("Validation failed for {} test", self.name)));
        }
        Ok(())
    }

    /// `validateScreenPixels`
    fn validate_screen_pixels(context: &Context, desired_color: [i32; 4]) -> Result<bool, TestError> {
        let gl = context.gl();
        let total_size = (WORK_GROUP_WIDTH * WORK_GROUP_HEIGHT * 4) as usize;
        let mut pixels = vec![128u8; total_size];

        // read pixels
        gl_call!(
            gl,
            "glReadPixels",
            gl.read_pixels(
                0,
                0,
                WORK_GROUP_WIDTH,
                WORK_GROUP_HEIGHT,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                pixels.as_mut_ptr().cast()
            )
        );

        // compare pixels to desired color
        Ok(pixels.chunks_exact(4).all(|pixel| {
            i32::from(pixel[0]) == desired_color[0]
                && i32::from(pixel[1]) == desired_color[1]
                && i32::from(pixel[2]) == desired_color[2]
        }))
    }
}

#[derive(Clone, Copy)]
enum Kind {
    Availability,
    AllInvocations,
    AnyInvocation,
    AllInvocationsEqual,
    WithVariables,
}

const FUNCTION_SHADER_BASE: &str = "${VERSION}\n\
    ${GROUP_VOTE_EXTENSION}\n\
    layout(rgba8, binding = 2) writeonly uniform highp image2D destImage;\n\
    layout(local_size_x = ${SIZE_X}, local_size_y = ${SIZE_Y}) in;\n\
    void main (void)\n\
    {\n\
    \x20   bool result = ${FUNC}${EXT_TYPE}(${FUNC_PARAMETER});\n\
    \x20   vec4 outColor = vec4(vec3(result ? 1.0 : 0.0), 1.0);\n\
    \x20   imageStore(destImage, ivec2(gl_GlobalInvocationID.xy), outColor);\n\
    }\n";

const AVAILABILITY_SHADER: &str = "${VERSION}\n\
    ${GROUP_VOTE_EXTENSION}\n\
    layout(rgba8, binding = 2) writeonly uniform highp image2D destImage;\n\
    layout(local_size_x = ${SIZE_X}, local_size_y = ${SIZE_Y}) in;\n\
    void main (void)\n\
    {\n\
    \x20   vec4 outColor = vec4(0.0);\n\
    \x20   outColor.r = allInvocations${EXT_TYPE}(true) ? 1.0 : 0.0;\n\
    \x20   outColor.g = anyInvocation${EXT_TYPE}(true) ? 1.0 : 0.0;\n\
    \x20   outColor.b = allInvocationsEqual${EXT_TYPE}(true) ? 1.0 : 0.0;\n\
    \x20   imageStore(destImage, ivec2(gl_GlobalInvocationID.xy), outColor);\n\
    }\n";

const VARIABLES_SHADER_BASE: &str = "${VERSION}\n\
    ${GROUP_VOTE_EXTENSION}\n\
    layout(rgba8, binding = 2) writeonly uniform highp image2D destImage;\n\
    layout(local_size_x = ${SIZE_X}, local_size_y = ${SIZE_Y}) in;\n\
    void main (void)\n\
    {\n\
    \x20   bool result = ${EXPRESSION};\n\
    \x20   vec4 outColor = vec4(vec3(result ? 1.0 : 0.0), 1.0);\n\
    \x20   imageStore(destImage, ivec2(gl_GlobalInvocationID.xy), outColor);\n\
    }\n";

/// `ShaderGroupVoteTestCaseBase`, one case per `Kind`.
struct ShaderGroupVoteCase {
    case_name: &'static str,
    kind: Kind,
}

/// The extension (if any) the context needs, and the specialization map built from it.
fn specialization_map(context: &Context) -> (SpecializationMap, Option<&'static str>) {
    let mut map = SpecializationMap::new();
    map.insert(
        "VERSION",
        context.context_type().glsl_version().declaration().to_string(),
    );
    map.insert("SIZE_X", WORK_GROUP_WIDTH.to_string());
    map.insert("SIZE_Y", WORK_GROUP_HEIGHT.to_string());

    if context.context_type().supports_core(4, 6) {
        map.insert("GROUP_VOTE_EXTENSION", String::new());
        map.insert("EXT_TYPE", String::new());
        (map, None)
    } else {
        map.insert(
            "GROUP_VOTE_EXTENSION",
            "#extension GL_ARB_shader_group_vote : enable".to_string(),
        );
        map.insert("EXT_TYPE", "ARB".to_string());
        (map, Some("GL_ARB_shader_group_vote"))
    }
}

/// The `FUNC`/`FUNC_PARAMETER` pair of one function-test shader, specialized into the base.
fn push_function_shader(
    shaders: &mut Vec<ComputeShader>,
    map: &mut SpecializationMap,
    name: &'static str,
    func: &'static str,
    parameter: &'static str,
    desired_color: Option<[i32; 4]>,
) -> Result<(), TestError> {
    map.insert("FUNC", func.to_string());
    map.insert("FUNC_PARAMETER", parameter.to_string());
    shaders.push(ComputeShader {
        name,
        shader: specialize_shader(FUNCTION_SHADER_BASE, map)?,
        desired_color,
    });
    Ok(())
}

impl ShaderGroupVoteCase {
    fn shaders(&self, mut map: SpecializationMap) -> Result<Vec<ComputeShader>, TestError> {
        const WHITE: Option<[i32; 4]> = Some([255, 255, 255, 255]);
        const BLACK: Option<[i32; 4]> = Some([0, 0, 0, 255]);

        let mut shaders = Vec::new();

        match self.kind {
            Kind::Availability => {
                let shader = specialize_shader(AVAILABILITY_SHADER, &map)?;
                shaders.push(ComputeShader {
                    name: "availability",
                    shader,
                    desired_color: None,
                });
            }
            Kind::AllInvocations => push_function_shader(
                &mut shaders,
                &mut map,
                "allInvocationsARB",
                "allInvocations",
                "true",
                WHITE,
            )?,
            Kind::AnyInvocation => push_function_shader(
                &mut shaders,
                &mut map,
                "anyInvocationARB",
                "anyInvocation",
                "false",
                BLACK,
            )?,
            Kind::AllInvocationsEqual => {
                push_function_shader(
                    &mut shaders,
                    &mut map,
                    "allInvocationsEqualARB",
                    "allInvocationsEqual",
                    "true",
                    WHITE,
                )?;
                push_function_shader(
                    &mut shaders,
                    &mut map,
                    "allInvocationsEqualARB",
                    "allInvocationsEqual",
                    "false",
                    WHITE,
                )?;
            }
            Kind::WithVariables => {
                // first specialization EXPRESSION and then whole shader
                let expressions: [(&str, &str, Option<[i32; 4]>); 3] = [
                    (
                        "allInvocations${EXT_TYPE}((gl_LocalInvocationIndex % 2u) == 1u) && anyInvocation${EXT_TYPE}((gl_LocalInvocationIndex % 2u) == 0u) && anyInvocation${EXT_TYPE}((gl_LocalInvocationIndex % 2u) == 1u)",
                        "allInvocations",
                        BLACK,
                    ),
                    (
                        "anyInvocation${EXT_TYPE}(gl_LocalInvocationIndex < 256u)",
                        "anyInvocation",
                        WHITE,
                    ),
                    (
                        "allInvocationsEqual${EXT_TYPE}(gl_WorkGroupID.x == 0u)",
                        "anyInvocation",
                        WHITE,
                    ),
                ];
                for (expression, name, desired_color) in expressions {
                    let specialized = specialize_shader(expression, &map)?;
                    map.insert("EXPRESSION", specialized);
                    shaders.push(ComputeShader {
                        name,
                        shader: specialize_shader(VARIABLES_SHADER_BASE, &map)?,
                        desired_color,
                    });
                }
            }
        }

        Ok(shaders)
    }
}

impl TestCase for ShaderGroupVoteCase {
    fn name(&self) -> &str {
        self.case_name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let (_, required_extension) = specialization_map(context);
        match required_extension {
            Some(extension) if !context.context_info.is_extension_supported(extension) => {
                Err(TestError::NotSupported("Not supported".to_string()))
            }
            _ => Ok(()),
        }
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let (map, _) = specialization_map(context);
        let shaders = self.shaders(map)?;

        let programs = shaders
            .iter()
            .map(|shader| shader.create(context))
            .collect::<Result<Vec<_>, _>>()?;

        for (shader, program) in shaders.iter().zip(&programs) {
            shader.execute(context, program)?;
            shader.validate(context)?;
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `ShaderGroupVote::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_group_vote");
    for (case_name, kind) in [
        ("availability", Kind::Availability),
        ("all_invocations", Kind::AllInvocations),
        ("any_invocation", Kind::AnyInvocation),
        ("all_invocations_equal", Kind::AllInvocationsEqual),
        ("invocations_with_variables", Kind::WithVariables),
    ] {
        group.add_child(Box::new(ShaderGroupVoteCase { case_name, kind }) as Box<dyn TestCase>);
    }
    group
}
