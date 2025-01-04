// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderViewportLayerArrayTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `CONTINUE` iterations (one per viewport / layer) are a loop inside `iterate`, and the framebuffers the layered cases create are deleted by `deinit` (upstream defines `deleteFBO` but never calls it).

use crate::glu::{self, Context, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup, va};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const EXTENSION: &str = "GL_ARB_shader_viewport_layer_array";

const OFFSET_VERTEX: i32 = 1;
const OFFSET_TESSELLATION: i32 = 2;
const OFFSET_GEOMETRY: i32 = 3;

const VS_TEMPLATE: &str = "#version 450 core\n\
    #extension GL_ARB_shader_viewport_layer_array: require\n\
    in highp vec2 inPosition;\n\
    in int in<var_name>;\n\
    in highp vec4 inColor;\n\
    out int vs<var_name>;\n\
    out highp vec3 vsPosition;\n\
    out highp vec4 vsColor;\n\
    void main()\n\
    {\n\
    \x20   gl_Position = vec4(inPosition, 0.0, 1.0);\n\
    \x20   gl_<var_name> = (in<var_name> + <viewport_layer_offset>) % <viewport_layer_max>;\n\
    \x20   vs<var_name> = in<var_name>;\n\
    \x20   vsPosition = vec3(inPosition, 0.0);\n\
    \x20   vsColor = inColor;\n\
    }\n";

const TCS_TEMPLATE: &str = "#version 450 core\n\
    layout(vertices = 3) out;\n\
    in highp vec3 vsPosition[];\n\
    in highp vec4 vsColor[];\n\
    in int vs<var_name>[];\n\
    out highp vec3 tcsPosition[];\n\
    out highp vec4 tcsColor[];\n\
    out int tcs<var_name>[];\n\
    void main()\n\
    {\n\
    \x20   tcsPosition[gl_InvocationID] = vsPosition[gl_InvocationID];\n\
    \x20   tcsColor[gl_InvocationID] = vsColor[gl_InvocationID];\n\
    \x20   tcs<var_name>[gl_InvocationID] = vs<var_name>[gl_InvocationID];\n\
    \x20   gl_TessLevelInner[0] = 3;\n\
    \x20   gl_TessLevelOuter[0] = 3;\n\
    \x20   gl_TessLevelOuter[1] = 3;\n\
    \x20   gl_TessLevelOuter[2] = 3;\n\
    }\n";

const TES_TEMPLATE: &str = "#version 450 core\n\
    #extension GL_ARB_shader_viewport_layer_array: require\n\
    layout(triangles, equal_spacing, cw) in;\n\
    in highp vec3 tcsPosition[];\n\
    in highp vec4 tcsColor[];\n\
    in int tcs<var_name>[];\n\
    out highp vec4 tesColor;\n\
    out highp int tes<var_name>;\n\
    void main()\n\
    {\n\
    \x20   vec3 p0 = gl_TessCoord.x * tcsPosition[0];\n\
    \x20   vec3 p1 = gl_TessCoord.y * tcsPosition[1];\n\
    \x20   vec3 p2 = gl_TessCoord.z * tcsPosition[2];\n\
    \x20   tesColor = tcsColor[0];\n\
    \x20   tes<var_name> = tcs<var_name>[0];\n\
    \x20   gl_<var_name> = (tcs<var_name>[0] + <viewport_layer_offset>) % <viewport_layer_max>;\n\
    \x20   gl_Position = vec4(normalize(p0 + p1 + p2), 1.0);\n\
    }\n";

const GS_TEMPLATE: &str = "#version 450 core\n\
    #extension GL_ARB_shader_viewport_layer_array: require\n\
    layout(triangles) in;\n\
    layout(triangle_strip, max_vertices = 3) out;\n\
    in highp vec4 tesColor[];\n\
    in int tes<var_name>[];\n\
    out highp vec4 gsColor;\n\
    void main()\n\
    {\n\
    \x20   for (int i = 0; i<3; i++)\n\
    \x20   {\n\
    \x20       gl_Position = gl_in[i].gl_Position;\n\
    \x20       gl_<var_name> = (tes<var_name>[i] + <viewport_layer_offset>) % <viewport_layer_max>;\n\
    \x20       gsColor = tesColor[i];\n\
    \x20       EmitVertex();\n\
    \x20   }\n\
    \x20   EndPrimitive();\n\
    }\n";

const FS_TEMPLATE: &str = "#version 450 core\n\
    in highp vec4 <input_color>;\n\
    out vec4 finalOutColor;\n\
    void main()\n\
    {\n\
    \x20   finalOutColor = <input_color>;\n\
    }\n";

/// `ShaderViewportLayerArrayUtils::ShaderPipeline`
struct ShaderPipeline<'gl> {
    program: Option<ShaderProgram<'gl>>,
    has_tessellation_shader: bool,
    has_geometry_shader: bool,
    viewport_layer_offset: i32,
    var_name: &'static str,
    vs: String,
    tcs: String,
    tes: String,
    gs: String,
    fs: String,
}

impl<'gl> ShaderPipeline<'gl> {
    fn new(
        tessellation_shader: bool,
        geometry_shader: bool,
        max_viewports_layers: i32,
        var_name: &'static str,
    ) -> Self {
        let viewport_layer_offset = if geometry_shader {
            OFFSET_GEOMETRY
        } else if tessellation_shader {
            OFFSET_TESSELLATION
        } else {
            OFFSET_VERTEX
        };

        let adapt = |shader: &str, offset: i32| {
            shader
                .replace("<var_name>", var_name)
                .replace("<viewport_layer_offset>", &offset.to_string())
                .replace("<viewport_layer_max>", &max_viewports_layers.to_string())
        };

        let input_color = if geometry_shader {
            "gsColor"
        } else if tessellation_shader {
            "tesColor"
        } else {
            "vsColor"
        };

        Self {
            program: None,
            has_tessellation_shader: tessellation_shader,
            has_geometry_shader: geometry_shader,
            viewport_layer_offset,
            var_name,
            vs: adapt(VS_TEMPLATE, OFFSET_VERTEX),
            tcs: adapt(TCS_TEMPLATE, 0),
            tes: adapt(TES_TEMPLATE, OFFSET_TESSELLATION),
            gs: adapt(GS_TEMPLATE, OFFSET_GEOMETRY),
            fs: FS_TEMPLATE.replace("<input_color>", input_color),
        }
    }

    /// `ShaderPipeline::create`
    fn create(&mut self, gl: &'gl glw::Functions) -> Result<(), TestError> {
        let mut sources = ProgramSources::default().with(ShaderType::Vertex, self.vs.clone());
        if self.has_tessellation_shader {
            sources = sources
                .with(ShaderType::TessControl, self.tcs.clone())
                .with(ShaderType::TessEvaluation, self.tes.clone());
        }
        if self.has_geometry_shader {
            sources = sources.with(ShaderType::Geometry, self.gs.clone());
        }
        sources = sources.with(ShaderType::Fragment, self.fs.clone());

        let program = ShaderProgram::new(gl, &sources);
        if !program.is_ok() {
            return Err(TestError::Fail("Shader compilation failed".to_string()));
        }
        self.program = Some(program);
        Ok(())
    }

    fn program_name(&self) -> GLuint {
        self.program.as_ref().map_or(0, |program| program.program())
    }

    /// `ShaderPipeline::use`
    fn use_program(&self, gl: &glw::Functions) -> Result<(), TestError> {
        gl_call!(gl, "glUseProgram failed", gl.use_program(self.program_name()));
        Ok(())
    }
}

/// `ShaderViewportLayerArrayUtils::renderQuad`
fn render_quad(
    context: &Context,
    pipeline: &ShaderPipeline<'_>,
    viewport_layer_index: i32,
    color: [f32; 4],
) -> Result<(), TestError> {
    let gl = context.gl();

    let quad_indices: [u16; 6] = [0, 1, 2, 2, 1, 3];
    let position: [f32; 8] = [-1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0];
    let viewport_layer_indices: [i32; 4] = [viewport_layer_index; 4];
    let colors: [f32; 16] = [
        color[0], color[1], color[2], color[3], color[0], color[1], color[2], color[3], color[0], color[1], color[2],
        color[3], color[0], color[1], color[2], color[3],
    ];

    let var_name = format!("in{}", pipeline.var_name);

    let vertex_arrays = [
        va::float("inPosition", 2, 4, 0, &position),
        va::int32(&var_name, 1, 4, 0, &viewport_layer_indices),
        va::float("inColor", 4, 4, 0, &colors),
    ];

    pipeline.use_program(gl)?;

    let primitive_list = if pipeline.has_tessellation_shader {
        glu::pr::patches(&quad_indices)
    } else {
        glu::pr::triangle_strip(&quad_indices)
    };

    glu::draw(
        &context.render_context,
        pipeline.program_name(),
        &vertex_arrays,
        &primitive_list,
    )?;

    glu::expect_no_error(gl, "glu::draw error")
}

/// `ShaderViewportLayerArrayUtils::validateColor`
fn validate_color(rendered_color: [f32; 4], reference_color: [f32; 4]) -> bool {
    let epsilon = 1.1f32 / 31.0f32;
    (0..4).all(|i| (rendered_color[i] - reference_color[i]).abs() < epsilon)
}

fn read_pixel(gl: &glw::Functions, x: i32, y: i32) -> Result<[f32; 4], TestError> {
    let mut rgba = [-1.0f32; 4];
    gl_call!(
        gl,
        "ReadPixels",
        gl.read_pixels(x, y, 1, 1, glw::GL_RGBA, glw::GL_FLOAT, rgba.as_mut_ptr().cast())
    );
    Ok(rgba)
}

fn clear_black(gl: &glw::Functions) -> Result<(), TestError> {
    gl_call!(gl, "ClearColor", gl.clear_color(0.0, 0.0, 0.0, 1.0));
    gl_call!(gl, "Clear", gl.clear(glw::GL_COLOR_BUFFER_BIT));
    Ok(())
}

fn check_extension(context: &Context) -> Result<(), TestError> {
    if context.context_info.is_extension_supported(EXTENSION) {
        Ok(())
    } else {
        Err(TestError::NotSupported("Not supported".to_string()))
    }
}

fn restore_viewport(context: &Context) -> Result<(), TestError> {
    let gl = context.gl();
    let render_target = context.render_target();
    gl_call!(
        gl,
        "Viewport",
        gl.viewport(0, 0, render_target.width, render_target.height)
    );
    Ok(())
}

/// Runs `deinit` after `body` whichever way it ended, as the framework does upstream; the body's verdict wins.
fn with_deinit(context: &Context, body: impl FnOnce() -> TestOutcome) -> TestOutcome {
    let outcome = body();
    let deinit = restore_viewport(context);
    match outcome {
        Ok(status) => deinit.map(|()| status),
        Err(error) => Err(error),
    }
}

fn create_pipelines<'gl>(
    gl: &'gl glw::Functions,
    max: i32,
    var_name: &'static str,
) -> Result<Vec<ShaderPipeline<'gl>>, TestError> {
    let mut pipelines = vec![
        ShaderPipeline::new(false, false, max, var_name),
        ShaderPipeline::new(true, false, max, var_name),
        ShaderPipeline::new(true, true, max, var_name),
    ];
    for pipeline in &mut pipelines {
        pipeline.create(gl)?;
    }
    Ok(pipelines)
}

/// `ShaderViewportIndexTestCase`
struct ShaderViewportIndexTestCase;

impl ShaderViewportIndexTestCase {
    /// `createMaxViewports`; returns the count and the `(x, y, w, h)` of each viewport.
    fn create_max_viewports(context: &Context) -> Result<(i32, Vec<[f32; 4]>), TestError> {
        let gl = context.gl();
        let target_width = context.render_target().width as f32;

        let mut max_viewports: GLint = 0;
        gl_call!(
            gl,
            "GetIntegerv error",
            gl.get_integerv(glw::GL_MAX_VIEWPORTS, &mut max_viewports)
        );

        let viewport_data_size = 4usize;
        let mut data = vec![0.0f32; max_viewports as usize * viewport_data_size];
        let mut viewport_data = Vec::new();

        let viewport_width = 16.0f32;
        let viewport_height = 16.0f32;

        let mut current_x = 0;
        let mut current_y = 0;
        for i in 0..max_viewports as usize {
            let mut x = current_x as f32 * viewport_width;
            if x > (target_width - viewport_width) {
                x = 0.0;
                current_x = 0;
                current_y += 1;
            }
            let y = current_y as f32 * viewport_height;

            data[i * viewport_data_size] = x;
            data[i * viewport_data_size + 1] = y;
            data[i * viewport_data_size + 2] = viewport_width;
            data[i * viewport_data_size + 3] = viewport_height;

            viewport_data.push([x, y, viewport_width, viewport_height]);

            current_x += 1;
        }

        gl_call!(
            gl,
            "ViewportArrayv",
            gl.viewport_arrayv(0, max_viewports, data.as_ptr())
        );

        Ok((max_viewports, viewport_data))
    }

    fn run(context: &Context) -> TestOutcome {
        let gl = context.gl();

        let (max_viewports, viewport_data) = Self::create_max_viewports(context)?;
        let pipelines = create_pipelines(gl, max_viewports, "ViewportIndex")?;

        let background_color = [0.0f32, 0.0, 0.0, 1.0];

        for current_viewport in 0..max_viewports {
            let render_color = [(current_viewport + 1) as f32 / max_viewports as f32, 0.0f32, 0.0, 1.0];

            for pipeline in &pipelines {
                clear_black(gl)?;
                render_quad(context, pipeline, current_viewport, render_color)?;
                gl_call!(gl, "Flush", gl.flush());

                let current_viewport_with_offset = (current_viewport + pipeline.viewport_layer_offset) % max_viewports;

                for (i, viewport) in viewport_data.iter().enumerate() {
                    let center_x = viewport[0] + viewport[2] * 0.5;
                    let center_y = viewport[1] + viewport[3] * 0.5;
                    let expected = if i == current_viewport_with_offset as usize {
                        render_color
                    } else {
                        background_color
                    };

                    let rgba = read_pixel(gl, center_x as GLint, center_y as GLint)?;
                    if !validate_color(rgba, expected) {
                        return Err(TestError::Fail(
                            "Expected pixel color did not match rendered one.".to_string(),
                        ));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for ShaderViewportIndexTestCase {
    fn name(&self) -> &str {
        "ShaderViewportIndexTestCase"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_extension(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        with_deinit(context, || Self::run(context))
    }
}

/// `ShaderLayerFramebufferTestCaseBase` and its two subclasses; `layered` selects `...LayeredTestCase`.
struct ShaderLayerFramebufferTestCase {
    layered: bool,
}

/// `m_texture`, `m_fbos` and `m_mainFbo`
#[derive(Default)]
struct Fbos {
    texture: GLuint,
    fbos: Vec<GLuint>,
    main_fbo: GLuint,
}

const FBO_SIZE: i32 = 512;

impl ShaderLayerFramebufferTestCase {
    fn layers_num(&self) -> i32 {
        if self.layered { 4 } else { 1 }
    }

    /// `ShaderLayerFramebufferLayeredTestCase::createFBO`
    fn create_layered_fbo(gl: &glw::Functions, layers_num: i32, fbos: &mut Fbos) -> Result<(), TestError> {
        gl_call!(gl, "GenTextures", gl.gen_textures(1, &mut fbos.texture));
        gl_call!(
            gl,
            "bindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_3D, fbos.texture)
        );
        gl_call!(
            gl,
            "texImage3D() call failed.",
            gl.tex_image_3d(
                glw::GL_TEXTURE_3D,
                0,
                glw::GL_RGBA8 as GLint,
                FBO_SIZE,
                FBO_SIZE,
                layers_num,
                0,
                glw::GL_RGBA,
                glw::GL_FLOAT,
                std::ptr::null()
            )
        );

        gl_call!(
            gl,
            "genFramebuffers() call failed.",
            gl.gen_framebuffers(1, &mut fbos.main_fbo)
        );
        gl_call!(
            gl,
            "bindFramebuffer() call failed.",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbos.main_fbo)
        );
        gl_call!(
            gl,
            "framebufferTexture() call failed.",
            gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, fbos.texture, 0)
        );

        for i in 0..layers_num {
            let mut layer_fbo: GLuint = 0;

            gl_call!(
                gl,
                "genFramebuffers() call failed.",
                gl.gen_framebuffers(1, &mut layer_fbo)
            );
            fbos.fbos.push(layer_fbo);
            gl_call!(
                gl,
                "bindFramebuffer() call failed.",
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, layer_fbo)
            );
            gl_call!(
                gl,
                "framebufferTextureLayer() call failed.",
                gl.framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, fbos.texture, 0, i)
            );
        }
        Ok(())
    }

    /// `ShaderLayerFramebufferNonLayeredTestCase::createFBO`
    fn create_non_layered_fbo(gl: &glw::Functions, fbos: &mut Fbos) -> Result<(), TestError> {
        gl_call!(gl, "GenTextures", gl.gen_textures(1, &mut fbos.texture));
        gl_call!(
            gl,
            "bindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_2D, fbos.texture)
        );
        gl_call!(
            gl,
            "texImage2D() call failed.",
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA8 as GLint,
                FBO_SIZE,
                FBO_SIZE,
                0,
                glw::GL_RGBA,
                glw::GL_FLOAT,
                std::ptr::null()
            )
        );

        gl_call!(
            gl,
            "genFramebuffers() call failed.",
            gl.gen_framebuffers(1, &mut fbos.main_fbo)
        );
        gl_call!(
            gl,
            "bindFramebuffer() call failed.",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbos.main_fbo)
        );
        gl_call!(
            gl,
            "framebufferTexture() call failed.",
            gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, fbos.texture, 0)
        );

        fbos.fbos.push(fbos.main_fbo);
        Ok(())
    }

    /// `deleteFBO`; the non-layered case's main FBO is its only entry of `fbos`, so it is deleted once.
    fn delete_fbo(gl: &glw::Functions, fbos: &Fbos, layered: bool) {
        // SAFETY: names this case created, deleted once; the default framebuffer is bound first so none of them is still current.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            gl.delete_framebuffers(1, &fbos.main_fbo);
            if layered {
                for fbo in &fbos.fbos {
                    gl.delete_framebuffers(1, fbo);
                }
            }
            gl.delete_textures(1, &fbos.texture);
        }
    }

    fn run(&self, context: &Context, fbos: &mut Fbos) -> TestOutcome {
        let gl = context.gl();
        let layers_num = self.layers_num();

        if self.layered {
            Self::create_layered_fbo(gl, layers_num, fbos)?;
        } else {
            Self::create_non_layered_fbo(gl, fbos)?;
        }

        let pipelines = create_pipelines(gl, layers_num, "Layer")?;

        gl_call!(gl, "Viewport", gl.viewport(0, 0, FBO_SIZE, FBO_SIZE));

        for current_layer in 0..layers_num {
            let render_color = [(current_layer + 1) as f32 / layers_num as f32, 0.0f32, 0.0, 1.0];

            for pipeline in &pipelines {
                gl_call!(
                    gl,
                    "BindFramebuffer",
                    gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbos.main_fbo)
                );

                clear_black(gl)?;
                render_quad(context, pipeline, current_layer, render_color)?;
                gl_call!(gl, "Flush", gl.flush());

                let current_layer_with_offset = (current_layer + pipeline.viewport_layer_offset) % layers_num;

                gl_call!(
                    gl,
                    "bindFramebuffer() call failed.",
                    gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbos.fbos[current_layer_with_offset as usize])
                );

                let rgba = read_pixel(gl, FBO_SIZE / 2, FBO_SIZE / 2)?;
                if !validate_color(rgba, render_color) {
                    return Err(TestError::Fail(
                        "Expected pixel color did not match rendered one.".to_string(),
                    ));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for ShaderLayerFramebufferTestCase {
    fn name(&self) -> &str {
        if self.layered {
            "ShaderLayerFramebufferLayeredTestCase"
        } else {
            "ShaderLayerFramebufferNonLayeredTestCase"
        }
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_extension(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut fbos = Fbos::default();
        let outcome = with_deinit(context, || self.run(context, &mut fbos));
        Self::delete_fbo(context.gl(), &fbos, self.layered);
        outcome
    }
}

/// `ShaderViewportLayerArray::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_viewport_layer_array");
    group.add_child(Box::new(ShaderViewportIndexTestCase) as Box<dyn TestCase>);
    group.add_child(Box::new(ShaderLayerFramebufferTestCase { layered: true }) as Box<dyn TestCase>);
    group.add_child(Box::new(ShaderLayerFramebufferTestCase { layered: false }) as Box<dyn TestCase>);
    group
}
