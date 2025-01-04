// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderLayeredRenderingBoundaryCondition.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The base class and its four subclasses are one struct with a `Kind`; the virtual `getGeometryShaderCode`/`getFragmentShaderCode`/`getVertexShaderCode`/`getReferenceColor` and the constructor-set draw mode, point count and layered flag are `match`es on it.

use super::require_geometry_shader;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

const BASE_FS_CODE: &str = "${VERSION}\n\nprecision highp float;\n\nflat in  int  layer_id;\n     out vec4 color;\n\nvoid main()\n{\n    color = vec4(1, 1, 1, 1);\n}\n";
const BASE_VS_CODE: &str =
    "${VERSION}\n\nprecision highp float;\n\nflat out int layer_id;\n\nvoid main()\n{\n    layer_id = 0;\n}\n";
const VARIOUS_TEXTURES_FS_CODE: &str = "${VERSION}\n\nprecision highp float;\n\nflat in  int  layer_id;\nlayout(location=0) out vec4 color0;\nlayout(location=1) out vec4 color1;\n\nvoid main()\n{\n    vec4 color;\n    switch (layer_id)\n    {\n        case 0:  color = vec4(1, 0, 0, 1); break;\n        case 1:  color = vec4(0, 1, 0, 1); break;\n        case 2:  color = vec4(0, 0, 1, 1); break;\n        case 3:  color = vec4(1, 1, 1, 1); break;\n        default: color = vec4(0, 0, 0, 0); break;\n    }\n    color0 = color;\n    color1 = color;\n}\n";
const VARIOUS_TEXTURES_GS_CODE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\n#define MAX_VERTICES 16\n#define N_LAYERS     2\n\nlayout(points)                                    in;\nlayout(triangle_strip, max_vertices=MAX_VERTICES) out;\n\nprecision highp float;\n\nflat out int layer_id;\n\nvoid main()\n{\n    for (int n = 0;n < N_LAYERS;++n)\n    {\n        gl_Layer    = n;\n        layer_id    = gl_Layer;\n        gl_Position = vec4(1, 1, 0, 1);\n        EmitVertex();\n\n        gl_Layer    = n;\n        layer_id    = gl_Layer;\n        gl_Position = vec4(1, -1, 0, 1);\n        EmitVertex();\n\n        gl_Layer    = n;\n        layer_id    = gl_Layer;\n        gl_Position = vec4(-1, 1, 0, 1);\n        EmitVertex();\n\n        gl_Layer    = n;\n        layer_id    = gl_Layer;\n        gl_Position = vec4(-1, -1, 0, 1);\n        EmitVertex();\n\n        EndPrimitive();\n    }\n}\n";
const NO_GS_VS_CODE: &str = "${VERSION}\n\nprecision highp float;\n\nflat out int layer_id;\n\nvoid main()\n{\n    layer_id = 0;\n\n    switch (gl_VertexID)\n    {\n        case 0:  gl_Position = vec4(-1, -1, 0, 1); break;\n        case 1:  gl_Position = vec4(-1,  1, 0, 1); break;\n        case 2:  gl_Position = vec4( 1,  1, 0, 1); break;\n        default: gl_Position = vec4( 1, -1, 0, 1); break;\n    }\n}\n";
const NO_LAYER_SET_GS_CODE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\n#define MAX_VERTICES 4\n\nlayout(points)                                    in;\nlayout(triangle_strip, max_vertices=MAX_VERTICES) out;\n\nprecision highp float;\n\nflat out int layer_id;\n\nvoid main()\n{\n    layer_id    = 0;\n    gl_Position = vec4(1, 1, 0, 1);\n    EmitVertex();\n\n    layer_id    = 0;\n    gl_Position = vec4(1, -1, 0, 1);\n    EmitVertex();\n\n    layer_id    = 0;\n    gl_Position = vec4(-1, 1, 0, 1);\n    EmitVertex();\n\n    layer_id    = 0;\n    gl_Position = vec4(-1, -1, 0, 1);\n    EmitVertex();\n\n    EndPrimitive();\n}\n";
const NO_LAYERED_FBO_GS_CODE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\n#define MAX_VERTICES 4\n\nlayout(points)                                    in;\nlayout(triangle_strip, max_vertices=MAX_VERTICES) out;\n\nprecision highp float;\n\nflat out int layer_id;\n\nvoid main()\n{\n    gl_Layer = 1;\n\n    layer_id    = gl_Layer;\n    gl_Position = vec4(1, 1, 0, 1);\n    EmitVertex();\n\n    layer_id    = gl_Layer;\n    gl_Position = vec4(1, -1, 0, 1);\n    EmitVertex();\n\n    layer_id    = gl_Layer;\n    gl_Position = vec4(-1, 1, 0, 1);\n    EmitVertex();\n\n    layer_id    = gl_Layer;\n    gl_Position = vec4(-1, -1, 0, 1);\n    EmitVertex();\n\n    EndPrimitive();\n}\n";

const WIDTH: GLint = 4;
const HEIGHT: GLint = 4;
const MAX_DEPTH: GLint = 4;
const TEXTURE_COMPONENTS: usize = 4;

const GREEN_COLOR: [u8; 4] = [0, 255, 0, 255];
const RED_COLOR: [u8; 4] = [255, 0, 0, 255];
const WHITE_COLOR: [u8; 4] = [255, 255, 255, 255];

#[derive(Clone, Copy)]
pub(super) enum Kind {
    VariousTextures,
    NoGs,
    NoLayerSet,
    NoLayeredFbo,
}

struct TextureInfo {
    depth: GLint,
    draw_buffer: GLenum,
    id: GLuint,
    texture_target: GLenum,
}

/// `GeometryShaderLayeredRenderingBoundaryCondition`
pub(super) struct LayeredRenderingBoundaryCondition {
    pub ext_params: ExtParameters,
    pub kind: Kind,
}

#[derive(Default)]
struct Resources {
    fbo_draw_id: GLuint,
    fbo_read_id: GLuint,
    fs_id: GLuint,
    gs_id: GLuint,
    po_id: GLuint,
    vao_id: GLuint,
    vs_id: GLuint,
    texture_ids: Vec<(GLenum, GLuint)>,
}

/// `comparePixels`
fn compare_pixels(
    width: GLint,
    height: GLint,
    pixel_size: GLint,
    texture_data: &[u8],
    reference_pixel: &[u8],
    attachment: usize,
    layer: u32,
) -> bool {
    let row_width = (pixel_size * width) as usize;
    for y in 0..height as usize {
        for x in 0..width as usize {
            let rendered_data = &texture_data[y * row_width + x * TEXTURE_COMPONENTS..][..TEXTURE_COMPONENTS];
            if reference_pixel[..TEXTURE_COMPONENTS] != *rendered_data {
                log::info!(
                    "Rendered data for [x={x} y={y} attachment={attachment} layer={layer}] [{}, {}, {}, {}] are different from reference data [{}, {}, {}, {}] !",
                    rendered_data[0],
                    rendered_data[1],
                    rendered_data[2],
                    rendered_data[3],
                    reference_pixel[0],
                    reference_pixel[1],
                    reference_pixel[2],
                    reference_pixel[3]
                );
                return false;
            }
        }
    }
    true
}

impl LayeredRenderingBoundaryCondition {
    fn textures_info(&self) -> Vec<TextureInfo> {
        let texture = |depth: GLint, draw_buffer: GLenum| TextureInfo {
            depth,
            draw_buffer,
            id: 0,
            texture_target: glw::GL_TEXTURE_3D,
        };
        match self.kind {
            Kind::VariousTextures => vec![
                texture(2, glw::GL_COLOR_ATTACHMENT0),
                texture(4, glw::GL_COLOR_ATTACHMENT1),
            ],
            Kind::NoGs | Kind::NoLayerSet | Kind::NoLayeredFbo => vec![texture(4, glw::GL_COLOR_ATTACHMENT0)],
        }
    }

    fn draw_mode(&self) -> GLenum {
        match self.kind {
            Kind::NoGs => glw::GL_TRIANGLE_FAN,
            _ => glw::GL_POINTS,
        }
    }

    fn n_points(&self) -> GLint {
        match self.kind {
            Kind::NoGs => 4,
            _ => 1,
        }
    }

    fn is_fbo_layered(&self) -> bool {
        !matches!(self.kind, Kind::NoLayeredFbo)
    }

    fn geometry_shader_code(&self) -> Option<&'static str> {
        match self.kind {
            Kind::VariousTextures => Some(VARIOUS_TEXTURES_GS_CODE),
            Kind::NoGs => None,
            Kind::NoLayerSet => Some(NO_LAYER_SET_GS_CODE),
            Kind::NoLayeredFbo => Some(NO_LAYERED_FBO_GS_CODE),
        }
    }

    fn fragment_shader_code(&self) -> &'static str {
        match self.kind {
            Kind::VariousTextures => VARIOUS_TEXTURES_FS_CODE,
            _ => BASE_FS_CODE,
        }
    }

    fn vertex_shader_code(&self) -> &'static str {
        match self.kind {
            Kind::NoGs => NO_GS_VS_CODE,
            _ => BASE_VS_CODE,
        }
    }

    fn reference_color(&self, layer_index: u32) -> [u8; 4] {
        match self.kind {
            Kind::VariousTextures => match layer_index {
                0 => RED_COLOR,
                1 => GREEN_COLOR,
                _ => [0; 4],
            },
            Kind::NoGs | Kind::NoLayerSet | Kind::NoLayeredFbo => {
                if layer_index == 0 {
                    WHITE_COLOR
                } else {
                    [0; 4]
                }
            }
        }
    }

    fn init_test(
        &self,
        context: &Context,
        base: &TestCaseBase,
        resources: &mut Resources,
        textures: &mut [TextureInfo],
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let fs_code = self.fragment_shader_code();
        let gs_code = self.geometry_shader_code();
        let vs_code = self.vertex_shader_code();

        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        resources.gs_id = gl!(gl.create_shader(base.gl_ext_tokens.geometry_shader));
        resources.po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "Error creating program/shader objects.")?;

        let gs_body = match &gs_code {
            Some(code) => ShaderBody::Source(resources.gs_id, std::slice::from_ref(code)),
            None => ShaderBody::Skip,
        };
        let (built, _) = base.build_program(
            context,
            resources.po_id,
            &[
                ShaderBody::Source(resources.fs_id, &[fs_code]),
                gs_body,
                ShaderBody::Source(resources.vs_id, &[vs_code]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Could not create a program object from a valid vertex/geometry/fragment shader!".to_string(),
            ));
        }

        gl!(gl.gen_framebuffers(1, &mut resources.fbo_read_id));
        gl!(gl.gen_framebuffers(1, &mut resources.fbo_draw_id));
        glu::expect_no_error(gl, "Error creating framebuffer objects!")?;

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        glu::expect_no_error(gl, "Error creating vertex array object!")?;

        for texture in textures.iter_mut() {
            gl!(gl.gen_textures(1, &mut texture.id));
            resources.texture_ids.push((texture.texture_target, texture.id));
        }
        glu::expect_no_error(gl, "Error creating texture objects!")
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        require_geometry_shader(&base)?;

        let mut textures = self.textures_info();
        self.init_test(context, &base, resources, &mut textures)?;

        gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, resources.fbo_draw_id));

        let mut buffer = [0u8; (WIDTH * HEIGHT * MAX_DEPTH) as usize * TEXTURE_COMPONENTS];

        for texture in &textures {
            gl!(gl.bind_texture(texture.texture_target, texture.id));
            gl!(gl.tex_storage_3d(texture.texture_target, 1, glw::GL_RGBA8, WIDTH, HEIGHT, texture.depth));
            gl!(gl.tex_sub_image_3d(
                texture.texture_target,
                0,
                0,
                0,
                0,
                WIDTH,
                HEIGHT,
                texture.depth,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                buffer.as_ptr().cast()
            ));
            glu::expect_no_error(gl, "Error configuring a texture object!")?;
        }

        let draw_buffers: Vec<GLenum> = textures.iter().map(|texture| texture.draw_buffer).collect();
        gl!(gl.draw_buffers(draw_buffers.len() as i32, draw_buffers.as_ptr()));
        glu::expect_no_error(gl, "Error setting draw buffers!")?;

        for (i, texture) in textures.iter().enumerate() {
            if self.is_fbo_layered() {
                gl!(gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, texture.draw_buffer, texture.id, 0));
            } else {
                gl!(gl.framebuffer_texture_layer(
                    glw::GL_DRAW_FRAMEBUFFER,
                    texture.draw_buffer,
                    texture.id,
                    0,
                    i as GLint
                ));
            }
            glu::expect_no_error(gl, "Error configuring framebuffer objects!")?;
        }

        let fbo_completeness = gl!(gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER));
        if fbo_completeness != glw::GL_FRAMEBUFFER_COMPLETE {
            log::info!("Draw FBO is incomplete: [{fbo_completeness}]");
            return Err(TestError::Fail("Draw FBO is incomplete.".to_string()));
        }

        gl!(gl.viewport(0, 0, WIDTH, HEIGHT));
        glu::expect_no_error(gl, "Error setting up viewport!")?;

        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Error configuring vertex array object!")?;

        gl!(gl.use_program(resources.po_id));
        glu::expect_no_error(gl, "Error using program object!")?;

        gl!(gl.draw_arrays(self.draw_mode(), 0, self.n_points()));
        glu::expect_no_error(gl, "Rendering failed!")?;

        // Bind read framebuffer object.
        gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, resources.fbo_read_id));

        let min_depth = textures.iter().map(|texture| texture.depth).min().unwrap_or(0) as u32;

        for (n_texture, texture) in textures.iter().enumerate() {
            for n_layer in 0..min_depth {
                // Configure read FBO's color attachment
                gl!(gl.framebuffer_texture_layer(
                    glw::GL_READ_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    texture.id,
                    0,
                    n_layer as GLint
                ));
                glu::expect_no_error(gl, "Could not set up read framebuffer!")?;

                let fbo_completeness = gl!(gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER));
                if fbo_completeness != glw::GL_FRAMEBUFFER_COMPLETE {
                    log::info!("Read FBO is incomplete: [{fbo_completeness}]");
                    return Err(TestError::Fail("Read FBO is incomplete.".to_string()));
                }

                gl!(gl.viewport(0, 0, WIDTH, HEIGHT));
                gl!(gl.read_pixels(
                    0,
                    0,
                    WIDTH,
                    HEIGHT,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    buffer.as_mut_ptr().cast()
                ));
                glu::expect_no_error(gl, "Could not read pixels using glReadPixels()")?;

                let expected_data = self.reference_color(n_layer);
                if !compare_pixels(
                    WIDTH,
                    HEIGHT,
                    TEXTURE_COMPONENTS as GLint,
                    &buffer,
                    &expected_data,
                    n_texture,
                    n_layer,
                ) {
                    return Ok(TestStatus::fail("Fail"));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for LayeredRenderingBoundaryCondition {
    fn name(&self) -> &str {
        match self.kind {
            Kind::VariousTextures => "layered_rendering_boundary_condition_various_textures",
            Kind::NoGs => "layered_rendering_boundary_condition_no_gs",
            Kind::NoLayerSet => "layered_rendering_boundary_condition_no_default_layer",
            Kind::NoLayeredFbo => "layered_rendering_boundary_condition_no_layered_fbo",
        }
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        // deinit
        gl!(gl.use_program(0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0));
        gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, 0));
        for (target, _) in &resources.texture_ids {
            gl!(gl.bind_texture(*target, 0));
        }
        if resources.po_id != 0 {
            gl!(gl.delete_program(resources.po_id));
        }
        for shader in [resources.fs_id, resources.gs_id, resources.vs_id] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        for (_, id) in &resources.texture_ids {
            gl!(gl.delete_textures(1, id));
        }
        for fbo in [resources.fbo_read_id, resources.fbo_draw_id] {
            if fbo != 0 {
                gl!(gl.delete_framebuffers(1, &fbo));
            }
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        outcome
    }
}
