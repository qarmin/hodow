// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fFboSRGBWriteControlTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
//
// The whole group is ported: `framebuffer_srgb_enabled` (query), the four render cases
// (`..._col_attach`, `..._blend`, `..._render_target_ignore`, `..._copy_to_linear`) through a `Renderer`
// that keeps upstream's shape, and the negative `framebuffer_srgb_unsupported_enum`. The desktop
// `core(4, 5)` branches are not written, since this port only creates ES contexts. Upstream's
// `TestFramebuffer` branches on `GL_DRAW_BUFFER`/`GL_READ_BUFFER` as a framebuffer target, which no case
// ever passes; they are not written. Shader build info is not logged.

use crate::glu::texture_util::map_gl_internal_format;
use crate::glu::{
    self, Buffer, Context, Framebuffer, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup, Texture,
    VertexArray,
};
use crate::glw::{self, GLenum, GLsizeiptr};
use crate::tcu::pixel::{TextureLevel, linear_to_srgb};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::{TestError, TestOutcome, TestStatus};

type Vec4 = [f32; 4];

fn get_test_color_linear() -> Vec4 {
    [0.2, 0.3, 0.4, 1.0]
}

fn get_test_color_srgb() -> Vec4 {
    linear_to_srgb(get_test_color_linear())
}

fn get_test_color_blank() -> Vec4 {
    [0.0, 0.0, 0.0, 1.0]
}

fn get_epsilon_error() -> Vec4 {
    [0.005; 4]
}

/// `tcu::boolAll(tcu::lessThan(tcu::abs(a - b), getEpsilonError())) || tcu::boolAll(tcu::equal(a, b))`
fn colors_close(a: Vec4, b: Vec4) -> bool {
    let eps = get_epsilon_error();
    (0..4).all(|c| (a[c] - b[c]).abs() < eps[c]) || a == b
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum TextureSourcesType {
    Rgba,
    #[allow(dead_code)] // upstream declares it; no case selects it
    Srgba,
    Both,
    None,
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum FboType {
    Source,
    Destination,
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum RendererTask {
    Draw,
    Copy,
}

const TEST_TEXTURE_WIDTH: i32 = 128;
const TEST_TEXTURE_HEIGHT: i32 = 128;
const SAMPLING_TYPE_COUNT_MAX: i32 = 5;

/// `buildSamplingPassType`
fn build_sampling_pass_type(sampler_total: i32) -> String {
    let mut shader_fragment = String::new();

    for sampler_type_idx in 0..SAMPLING_TYPE_COUNT_MAX {
        shader_fragment.push_str(&format!("    if (uFunctionType == {sampler_type_idx}) \n    {{ \n"));

        for sampler_idx in 0..sampler_total {
            let call = match sampler_type_idx {
                0 => format!("texture(uTexture{sampler_idx}, vs_aTexCoord)"),
                1 => format!("textureLod(uTexture{sampler_idx}, vs_aTexCoord, 0.0f)"),
                2 => format!("textureGrad(uTexture{sampler_idx}, vs_aTexCoord, vec2(0.0f, 0.0f), vec2(0.0f, 0.0f))"),
                3 => format!("textureOffset(uTexture{sampler_idx}, vs_aTexCoord, ivec2(0.0f, 0.0f))"),
                _ => format!("textureProj(uTexture{sampler_idx}, vec3(vs_aTexCoord, 1.0f))"),
            };
            shader_fragment.push_str(&format!("        texelColor{sampler_idx} = {call}; \n"));
        }

        shader_fragment.push_str("    } \n");
    }

    shader_fragment
}

fn log_color(color_log_message: &str, result_color: Vec4) {
    log::info!(
        "{color_log_message} = ({}, {}, {}, {})",
        result_color[0],
        result_color[1],
        result_color[2],
        result_color[3]
    );
}

/// `TestFunction` - `None` is `TestFunction(false)`.
#[derive(Clone, Copy)]
struct TestFunction {
    function_name: &'static str,
    function_definition: &'static str,
}

/// `getFunctionBlendLinearToSRGBCheck`
fn get_function_blend_linear_to_srgb_check() -> TestFunction {
    TestFunction {
        function_name: "blendPlusLinearToSRGB",
        function_definition: "mediump vec4 blendPlusLinearToSRGB(in mediump vec4 colorSrc, in mediump vec4 colorDst) \n\
            { \n\
            \x20   const int MAX_VECTOR_SIZE = 4; \n\
            \x20   mediump vec4 colorConverted; \n\
            \x20   mediump vec4 colorBlended; \n\
            \x20   for (int idx = 0; idx < MAX_VECTOR_SIZE; idx++) \n\
            \x20   { \n\
            \x20       if (uBlendFunctionType == 0) \n\
            \x20       { \n\
            \x20           colorBlended[idx] = (colorSrc[idx] * uFactorSrc) + colorDst[idx] * uFactorDst; \n\
            \x20       } \n\
            \x20       if (uBlendFunctionType == 1) \n\
            \x20       { \n\
            \x20           colorBlended[idx] = (colorSrc[idx] * uFactorSrc) - (colorDst[idx] * uFactorDst); \n\
            \x20       } \n\
            if (uBlendFunctionType == 2) \n\
            \x20       { \n\
            \x20           colorBlended[idx] = (colorDst[idx] * uFactorDst) - (colorSrc[idx] * uFactorSrc); \n\
            \x20       } \n\
            \x20       if (colorBlended[idx] < 0.0031308f) \n\
            \x20       { \n\
            \x20           colorConverted[idx] = 12.92f * colorBlended[idx]; \n\
            \x20       } \n\
            \x20       else \n\
            \x20       { \n\
            \x20           colorConverted[idx] = 1.055f * pow(colorBlended[idx], 0.41666f) - 0.055f; \n\
            \x20       } \n\
            \x20   } \n\
            \x20   return colorConverted; \n\
            } \n",
    }
}

/// `FBOConfig`
#[derive(Clone, Copy)]
struct FboConfig {
    texture_internal_format: GLenum,
    texture_color: Vec4,
    fbo_target_type: GLenum,
    fbo_color_attachment: GLenum,
    fbo_type: FboType,
}

/// `BlendConfig`
#[derive(Clone, Copy)]
struct BlendConfig {
    equation: GLenum,
    func_src: GLenum,
    func_dst: GLenum,
}

/// `getBlendingConfigList`
fn get_blending_config_list() -> Vec<BlendConfig> {
    let mut configs = Vec::new();

    // add, subtract and reverse subtract function permutations
    for equation in [glw::GL_FUNC_ADD, glw::GL_FUNC_SUBTRACT, glw::GL_FUNC_REVERSE_SUBTRACT] {
        for (func_src, func_dst) in [
            (glw::GL_ONE, glw::GL_ONE),
            (glw::GL_ONE, glw::GL_ZERO),
            (glw::GL_ZERO, glw::GL_ONE),
            (glw::GL_ZERO, glw::GL_ZERO),
        ] {
            configs.push(BlendConfig {
                equation,
                func_src,
                func_dst,
            });
        }
    }

    configs
}

/// `TestRenderPassConfig`
#[derive(Clone)]
struct TestRenderPassConfig {
    texture_sources_type: TextureSourcesType,
    fbo_config_list: Vec<FboConfig>,
    framebuffer_srgb: bool,
    framebuffer_blend: bool,
    test_function: Option<TestFunction>,
    renderer_task: RendererTask,
}

/// `TestVertexData`
struct TestVertexData<'gl> {
    gl: &'gl glw::Functions,
    vao: VertexArray<'gl>,
    _vbo: Buffer<'gl>,
}

impl<'gl> TestVertexData<'gl> {
    fn new(gl: &'gl glw::Functions) -> Result<Self, TestError> {
        #[rustfmt::skip]
        let vertex_data: [f32; 30] = [
            // position                // texcoord
            -1.0, -1.0, 0.0, 0.0, 0.0, // bottom left corner
            1.0,  -1.0, 0.0, 1.0, 0.0, // bottom right corner
            1.0,  1.0,  0.0, 1.0, 1.0, // Top right corner

            -1.0, 1.0,  0.0, 0.0, 1.0, // top left corner
            1.0,  1.0,  0.0, 1.0, 1.0, // Top right corner
            -1.0, -1.0, 0.0, 0.0, 0.0  // bottom left corner
        ];

        let vao = VertexArray::new(gl);
        // SAFETY: a vertex array this object generated.
        unsafe { gl.bind_vertex_array(vao.get()) };

        let vbo = Buffer::new(gl);
        let stride = 5 * std::mem::size_of::<f32>() as i32;
        // SAFETY: a buffer this object generated and an array that outlives the upload.
        unsafe {
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo.get());

            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&vertex_data) as GLsizeiptr,
                vertex_data.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );

            gl.enable_vertex_attrib_array(0);
            gl.vertex_attrib_pointer(0, 3, glw::GL_FLOAT, glw::FALSE, stride, std::ptr::null());
            gl.enable_vertex_attrib_array(1);
            gl.vertex_attrib_pointer(
                1,
                2,
                glw::GL_FLOAT,
                glw::FALSE,
                stride,
                (3 * std::mem::size_of::<f32>()) as *const std::ffi::c_void,
            );

            gl.bind_vertex_array(0);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        }
        glu::expect_no_error(gl, "gl error during vertex data setup")?;

        Ok(Self { gl, vao, _vbo: vbo })
    }

    fn bind(&self) {
        // SAFETY: a vertex array this object owns.
        unsafe { self.gl.bind_vertex_array(self.vao.get()) };
    }

    fn unbind(&self) {
        // SAFETY: unbinding.
        unsafe { self.gl.bind_vertex_array(0) };
    }
}

/// `TestTexture2D`
struct TestTexture2D<'gl> {
    gl: &'gl glw::Functions,
    handle: Texture<'gl>,
    texture_unit: i32,
}

impl<'gl> TestTexture2D<'gl> {
    fn new(
        gl: &'gl glw::Functions,
        internal_format: GLenum,
        transfer_format: GLenum,
        transfer_type: GLenum,
        image_color: Vec4,
    ) -> Result<Self, TestError> {
        let format = map_gl_internal_format(internal_format)
            .ok_or_else(|| TestError::Fail(format!("unknown internal format {internal_format:#x}")))?;
        let mut image_data = TextureLevel::new(format, TEST_TEXTURE_WIDTH as u32, TEST_TEXTURE_HEIGHT as u32, 1)?;

        // fill image data with a solid test color
        {
            let mut access = image_data.get_access();
            for py in 0..TEST_TEXTURE_HEIGHT as u32 {
                for px in 0..TEST_TEXTURE_WIDTH as u32 {
                    access.set_pixel(image_color, px, py, 0);
                }
            }
        }

        let handle = Texture::new(gl);

        // SAFETY: a texture this object generated; the level data outlives the upload.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D, handle.get());
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_WRAP_S,
                glw::GL_MIRRORED_REPEAT as i32,
            );
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_WRAP_T,
                glw::GL_MIRRORED_REPEAT as i32,
            );
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);

            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                internal_format as i32,
                TEST_TEXTURE_WIDTH,
                TEST_TEXTURE_HEIGHT,
                0,
                transfer_format,
                transfer_type,
                image_data.data().as_ptr().cast(),
            );

            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
        }

        Ok(Self {
            gl,
            handle,
            texture_unit: 0,
        })
    }

    fn get_texture_unit(&self) -> i32 {
        self.texture_unit
    }

    fn get_handle(&self) -> u32 {
        self.handle.get()
    }

    fn bind(&mut self, texture_unit: i32) {
        self.texture_unit = texture_unit;
        // SAFETY: a texture this object owns.
        unsafe {
            self.gl.active_texture(glw::GL_TEXTURE0 + self.texture_unit as GLenum);
            self.gl.bind_texture(glw::GL_TEXTURE_2D, self.handle.get());
        }
    }

    fn unbind(&self) {
        // SAFETY: unbinding.
        unsafe { self.gl.bind_texture(glw::GL_TEXTURE_2D, 0) };
    }
}

/// `TestFramebuffer`
struct TestFramebuffer<'gl> {
    gl: &'gl glw::Functions,
    reference_source: Framebuffer<'gl>,
    target_type: GLenum,
    bound: bool,
    fbo_type: FboType,
    idx: usize,
    color_attachment: GLenum,
}

impl<'gl> TestFramebuffer<'gl> {
    fn new(
        gl: &'gl glw::Functions,
        target_type: GLenum,
        color_attachment: GLenum,
        texture_attachment_handle: u32,
        fbo_type: FboType,
        idx: usize,
    ) -> Result<Self, TestError> {
        let reference_source = Framebuffer::new(gl);

        // SAFETY: a framebuffer this object generated and a texture the caller owns.
        unsafe {
            gl.bind_framebuffer(target_type, reference_source.get());

            gl.framebuffer_texture_2d(
                target_type,
                color_attachment,
                glw::GL_TEXTURE_2D,
                texture_attachment_handle,
                0,
            );
        }

        // SAFETY: a plain query.
        if unsafe { gl.check_framebuffer_status(target_type) } != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::Fail(
                "m_gl->checkFramebufferStatus(m_targetType) == GL_FRAMEBUFFER_COMPLETE".to_string(),
            ));
        }

        // SAFETY: unbinding.
        unsafe { gl.bind_framebuffer(target_type, 0) };

        Ok(Self {
            gl,
            reference_source,
            target_type,
            bound: false,
            fbo_type,
            idx,
            color_attachment,
        })
    }

    fn bind(&mut self) {
        if !self.bound {
            // SAFETY: a framebuffer this object owns.
            unsafe { self.gl.bind_framebuffer(self.target_type, self.reference_source.get()) };
            self.bound = true;
        }
    }

    fn unbind(&mut self) {
        if self.bound {
            // SAFETY: unbinding.
            unsafe { self.gl.bind_framebuffer(self.target_type, 0) };
            self.bound = false;
        }
    }
}

/// `TestShaderProgram`
struct TestShaderProgram<'gl> {
    gl: &'gl glw::Functions,
    reference_source: ShaderProgram<'gl>,
}

impl<'gl> TestShaderProgram<'gl> {
    fn new(
        gl: &'gl glw::Functions,
        sampler_total: i32,
        test_function: Option<TestFunction>,
    ) -> Result<Self, TestError> {
        let shader_vertex = "#version 310 es \n\
            layout (location = 0) in mediump vec3 aPosition; \n\
            layout (location = 1) in mediump vec2 aTexCoord; \n\
            out mediump vec2 vs_aTexCoord; \n\
            void main () \n\
            { \n\
            \x20   gl_Position = vec4(aPosition, 1.0f); \n\
            \x20   vs_aTexCoord = aTexCoord; \n\
            } \n";

        let mut shader_fragment = String::from(
            "#version 310 es \nin mediump vec2 vs_aTexCoord; \nlayout (location = 0) out mediump vec4 fs_aColor0; \n",
        );

        for sampler_idx in 0..sampler_total {
            shader_fragment.push_str(&format!("uniform sampler2D uTexture{sampler_idx}; \n"));
        }

        shader_fragment.push_str("uniform int uFunctionType; \n");

        if let Some(function) = test_function {
            shader_fragment.push_str("uniform int uBlendFunctionType; \nuniform mediump float uFactorSrc; \nuniform mediump float uFactorDst; \n");
            shader_fragment.push_str(function.function_definition);
        }

        shader_fragment.push_str("void main () \n{ \n");

        for sampler_idx in 0..sampler_total {
            shader_fragment.push_str(&format!(
                "    mediump vec4 texelColor{sampler_idx} = vec4(0.0f, 0.0f, 0.0f, 1.0f); \n"
            ));
        }

        shader_fragment.push_str(&build_sampling_pass_type(sampler_total));

        if let Some(function) = test_function {
            shader_fragment.push_str(&format!(
                "    fs_aColor0 = {}(texelColor0, texelColor1); \n",
                function.function_name
            ));
        } else {
            shader_fragment.push_str("    fs_aColor0 = texelColor0; \n");
        }

        shader_fragment.push_str("} \n");

        let reference_source = ShaderProgram::new(
            gl,
            &ProgramSources::default()
                .with(ShaderType::Vertex, shader_vertex)
                .with(ShaderType::Fragment, shader_fragment),
        );
        if !reference_source.is_ok() {
            return Err(TestError::Fail(
                "Failed to compile shaders and link program".to_string(),
            ));
        }

        Ok(Self { gl, reference_source })
    }

    fn get_handle(&self) -> u32 {
        self.reference_source.program()
    }

    fn use_program(&self) {
        // SAFETY: a program this object owns.
        unsafe { self.gl.use_program(self.get_handle()) };
    }

    fn unuse(&self) {
        // SAFETY: unbinding.
        unsafe { self.gl.use_program(0) };
    }
}

/// `Renderer`
struct Renderer<'a> {
    context: &'a Context,
    gl: &'a glw::Functions,
    vertex_data: TestVertexData<'a>,
    blend_config_list: Vec<BlendConfig>,
    texture_source_list: Vec<TestTexture2D<'a>>,
    render_pass_config: Option<TestRenderPassConfig>,
    fbo_texture_list: Vec<TestTexture2D<'a>>,
    shader_program: Option<TestShaderProgram<'a>>,
    framebuffer_list: Vec<TestFramebuffer<'a>>,
    results_list_pre_draw: Vec<Vec4>,
    results_list_post_draw: Vec<Vec4>,
    render_pass: usize,
    samplers_required: i32,
    has_function: bool,
    sampling_type: i32,
    blend_iteration: usize,
    framebuffer_blend_enabled: bool,
    framebuffer_srgb_enabled: bool,
}

impl<'a> Renderer<'a> {
    fn new(context: &'a Context) -> Result<Self, TestError> {
        let gl = context.gl();
        let texture_linear = TestTexture2D::new(
            gl,
            glw::GL_RGBA8,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            get_test_color_linear(),
        )?;
        let texture_srgb = TestTexture2D::new(
            gl,
            glw::GL_SRGB8_ALPHA8,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            get_test_color_linear(),
        )?;

        Ok(Self {
            context,
            gl,
            vertex_data: TestVertexData::new(gl)?,
            blend_config_list: get_blending_config_list(),
            texture_source_list: vec![texture_linear, texture_srgb],
            render_pass_config: None,
            fbo_texture_list: Vec::new(),
            shader_program: None,
            framebuffer_list: Vec::new(),
            results_list_pre_draw: Vec::new(),
            results_list_post_draw: Vec::new(),
            render_pass: 0,
            samplers_required: 0,
            has_function: false,
            sampling_type: 0,
            blend_iteration: 0,
            framebuffer_blend_enabled: false,
            framebuffer_srgb_enabled: false,
        })
    }

    fn init(&mut self, render_pass_config: &TestRenderPassConfig, renderpass: usize) -> Result<(), TestError> {
        self.render_pass_config = Some(render_pass_config.clone());
        self.render_pass = renderpass;

        self.create_fbo_with_color_attachment(&render_pass_config.fbo_config_list)?;

        if render_pass_config.texture_sources_type != TextureSourcesType::None {
            self.samplers_required = match render_pass_config.texture_sources_type {
                TextureSourcesType::Rgba | TextureSourcesType::Srgba => 1,
                TextureSourcesType::Both => 2,
                TextureSourcesType::None => unreachable!(),
            };

            self.shader_program = Some(TestShaderProgram::new(
                self.gl,
                self.samplers_required,
                render_pass_config.test_function,
            )?);
            self.has_function = render_pass_config.test_function.is_some();
        } else {
            self.shader_program = None;
        }
        Ok(())
    }

    fn deinit(&mut self) {
        self.shader_program = None;

        self.fbo_texture_list.clear();
        self.framebuffer_list.clear();
    }

    fn get_blend_config_count(&self) -> usize {
        self.blend_config_list.len()
    }

    /// `copyFrameBufferTexture`
    fn copy_frame_buffer_texture(
        &mut self,
        src_px: i32,
        src_py: i32,
        dst_px: i32,
        dst_py: i32,
    ) -> Result<(), TestError> {
        let gl = self.gl;
        let mut fbo_src_idx = usize::MAX;
        let mut fbo_dst_idx = usize::MAX;
        let mut fbo_src_col_attachment = glw::GL_NONE;
        let mut fbo_dst_col_attachment = glw::GL_NONE;

        for idx in 0..self.framebuffer_list.len() {
            self.framebuffer_list[idx].bind();
        }

        // cache fbo attachments and idx locations
        for idx in 0..self.framebuffer_list.len() {
            if self.framebuffer_list[idx].fbo_type == FboType::Source {
                fbo_src_idx = self.framebuffer_list[idx].idx;
                fbo_src_col_attachment = self.framebuffer_list[fbo_src_idx].color_attachment;
            }
            if self.framebuffer_list[idx].fbo_type == FboType::Destination {
                fbo_dst_idx = self.framebuffer_list[idx].idx;
                fbo_dst_col_attachment = self.framebuffer_list[fbo_dst_idx].color_attachment;
            }
        }

        for framebuffer in &mut self.framebuffer_list {
            framebuffer.unbind();
        }

        // store texel data from both src and dst before performing the copy
        self.results_list_pre_draw.resize(2, [0.0; 4]);
        self.framebuffer_list[fbo_src_idx].bind();
        self.results_list_pre_draw[0] = self.read_texels(0, 0, fbo_src_col_attachment)?;
        self.framebuffer_list[fbo_src_idx].unbind();
        self.framebuffer_list[fbo_dst_idx].target_type = glw::GL_READ_FRAMEBUFFER;
        self.framebuffer_list[fbo_dst_idx].bind();
        self.results_list_pre_draw[1] = self.read_texels(0, 0, fbo_dst_col_attachment)?;
        self.framebuffer_list[fbo_dst_idx].unbind();
        self.framebuffer_list[fbo_dst_idx].target_type = glw::GL_DRAW_FRAMEBUFFER;

        self.framebuffer_list[fbo_src_idx].bind();
        self.framebuffer_list[fbo_dst_idx].bind();

        self.enable_framebuffer_srgb();
        self.enable_framebuffer_blend();

        // SAFETY: the source and destination framebuffers are bound to the read and draw targets.
        unsafe {
            gl.blit_framebuffer(
                src_px,
                src_py,
                TEST_TEXTURE_WIDTH,
                TEST_TEXTURE_HEIGHT,
                dst_px,
                dst_py,
                TEST_TEXTURE_WIDTH,
                TEST_TEXTURE_HEIGHT,
                glw::GL_COLOR_BUFFER_BIT,
                glw::GL_NEAREST,
            );
        }

        self.results_list_post_draw.resize(2, [0.0; 4]);
        self.results_list_post_draw[0] = self.read_texels(0, 0, fbo_src_col_attachment)?;
        self.framebuffer_list[fbo_src_idx].unbind();
        self.framebuffer_list[fbo_dst_idx].unbind();

        self.framebuffer_list[fbo_dst_idx].target_type = glw::GL_READ_FRAMEBUFFER;
        self.framebuffer_list[fbo_dst_idx].bind();
        self.results_list_post_draw[1] = self.read_texels(0, 0, fbo_dst_col_attachment)?;
        self.framebuffer_list[fbo_dst_idx].unbind();
        Ok(())
    }

    /// `draw`
    fn draw(&mut self) -> Result<(), TestError> {
        let gl = self.gl;
        let config = self.render_pass_config.clone().expect("init() was called");

        if config.texture_sources_type == TextureSourcesType::None {
            return Err(TestError::InternalError(
                "Error: Attempted to draw with no texture sources".to_string(),
            ));
        }

        // resize results storage with each render pass
        self.results_list_pre_draw.resize(self.render_pass + 1, [0.0; 4]);
        self.results_list_post_draw.resize(self.render_pass + 1, [0.0; 4]);

        self.shader_program
            .as_ref()
            .expect("a shader program for a drawing pass")
            .use_program();
        self.vertex_data.bind();

        for framebuffer in &mut self.framebuffer_list {
            framebuffer.bind();
        }

        self.bind_all_required_source_textures(config.texture_sources_type);
        self.bind_active_textures_samplers()?;

        self.enable_framebuffer_srgb();
        self.enable_framebuffer_blend();

        self.results_list_pre_draw[self.render_pass] = self.read_texels(0, 0, glw::GL_COLOR_ATTACHMENT0)?;
        self.set_shader_program_sampling_type(self.sampling_type);
        if self.has_function {
            self.set_shader_blend_function_type();
            self.set_shader_blend_src_dst_values()?;
        }

        // SAFETY: a six-vertex draw with the vertex data bound above.
        unsafe { gl.draw_arrays(glw::GL_TRIANGLES, 0, 6) };

        self.results_list_post_draw[self.render_pass] = self.read_texels(0, 0, glw::GL_COLOR_ATTACHMENT0)?;
        self.log_state(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, self.sampling_type)?;

        for texture in &self.texture_source_list {
            texture.unbind();
        }
        for framebuffer in &mut self.framebuffer_list {
            framebuffer.unbind();
        }
        self.vertex_data.unbind();
        self.shader_program
            .as_ref()
            .expect("a shader program for a drawing pass")
            .unuse();
        Ok(())
    }

    /// `createFBOwithColorAttachment`
    fn create_fbo_with_color_attachment(&mut self, fbo_config_list: &[FboConfig]) -> Result<(), TestError> {
        for (idx, fbo_config) in fbo_config_list.iter().enumerate() {
            let texture = TestTexture2D::new(
                self.gl,
                fbo_config.texture_internal_format,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                fbo_config.texture_color,
            )?;

            let framebuffer = TestFramebuffer::new(
                self.gl,
                fbo_config.fbo_target_type,
                fbo_config.fbo_color_attachment,
                texture.get_handle(),
                fbo_config.fbo_type,
                idx,
            )?;
            self.fbo_texture_list.push(texture);
            self.framebuffer_list.push(framebuffer);
        }
        Ok(())
    }

    fn set_shader_program_sampling_type(&self, sampler_idx: i32) {
        let program = self
            .shader_program
            .as_ref()
            .expect("a shader program for a drawing pass")
            .get_handle();
        // SAFETY: a NUL-terminated name against the program in use.
        unsafe {
            let location = self.gl.get_uniform_location(program, c"uFunctionType".as_ptr());
            self.gl.uniform_1i(location, sampler_idx);
        }
    }

    fn set_shader_blend_function_type(&self) {
        let equation = self.blend_config_list[self.blend_iteration].equation;
        let function = match equation {
            glw::GL_FUNC_ADD => 0,
            glw::GL_FUNC_SUBTRACT => 1,
            glw::GL_FUNC_REVERSE_SUBTRACT => 2,
            _ => -1,
        };

        let program = self
            .shader_program
            .as_ref()
            .expect("a shader program for a drawing pass")
            .get_handle();
        // SAFETY: a NUL-terminated name against the program in use.
        unsafe {
            let location = self.gl.get_uniform_location(program, c"uBlendFunctionType".as_ptr());
            self.gl.uniform_1i(location, function);
        }
    }

    fn set_shader_blend_src_dst_values(&self) -> Result<(), TestError> {
        let config = self.blend_config_list[self.blend_iteration];
        let func_src = if config.func_src == glw::GL_ONE { 1.0f32 } else { 0.0 };
        let func_dst = if config.func_dst == glw::GL_ONE { 1.0f32 } else { 0.0 };
        let program = self
            .shader_program
            .as_ref()
            .expect("a shader program for a drawing pass")
            .get_handle();

        // SAFETY: NUL-terminated names against the program in use.
        unsafe {
            let location_src = self.gl.get_uniform_location(program, c"uFactorSrc".as_ptr());
            self.gl.uniform_1f(location_src, func_src);
        }
        glu::expect_no_error(self.gl, "glUniform1f()")?;

        // SAFETY: as above.
        unsafe {
            let location_dst = self.gl.get_uniform_location(program, c"uFactorDst".as_ptr());
            self.gl.uniform_1f(location_dst, func_dst);
        }
        glu::expect_no_error(self.gl, "glUniform1f()")
    }

    fn bind_active_textures_samplers(&self) -> Result<(), TestError> {
        let program = self
            .shader_program
            .as_ref()
            .expect("a shader program for a drawing pass")
            .get_handle();

        for idx in 0..self.samplers_required as usize {
            let uniform_name = std::ffi::CString::new(format!("uTexture{idx}")).expect("no interior NUL");
            // SAFETY: a NUL-terminated name against the program in use.
            unsafe {
                let location = self.gl.get_uniform_location(program, uniform_name.as_ptr());
                self.gl
                    .uniform_1i(location, self.texture_source_list[idx].get_texture_unit());
            }
            glu::expect_no_error(self.gl, "glGetUniformLocation()")?;
        }
        Ok(())
    }

    fn bind_all_required_source_textures(&mut self, textures_required: TextureSourcesType) {
        match textures_required {
            TextureSourcesType::Rgba => self.texture_source_list[0].bind(0),
            TextureSourcesType::Srgba => self.texture_source_list[1].bind(0),
            TextureSourcesType::Both => {
                self.texture_source_list[0].bind(0);
                self.texture_source_list[1].bind(1);
            }
            TextureSourcesType::None => unreachable!("Error: Invalid sources requested in bind all"),
        }
    }

    fn enable_framebuffer_srgb(&self) {
        // SAFETY: plain state setting on the current context.
        unsafe {
            if self.framebuffer_srgb_enabled {
                self.gl.enable(glw::GL_FRAMEBUFFER_SRGB);
            } else {
                self.gl.disable(glw::GL_FRAMEBUFFER_SRGB);
            }
        }
    }

    fn enable_framebuffer_blend(&self) {
        let mut message = String::from("Blend settings = ");

        if self.framebuffer_blend_enabled {
            let config = self.blend_config_list[self.blend_iteration];
            // SAFETY: plain state setting on the current context.
            unsafe {
                self.gl.enable(glw::GL_BLEND);
                self.gl.blend_equation(config.equation);
                self.gl.blend_func(config.func_src, config.func_dst);
            }

            let equation = match config.equation {
                glw::GL_FUNC_ADD => "GL_FUNC_ADD",
                glw::GL_FUNC_SUBTRACT => "GL_FUNC_SUBTRACT",
                glw::GL_FUNC_REVERSE_SUBTRACT => "GL_FUNC_REVERSE_SUBTRACT",
                _ => "",
            };
            let src = if config.func_src == glw::GL_ONE {
                "GL_ONE"
            } else {
                "GL_ZERO"
            };
            let dst = if config.func_dst == glw::GL_ONE {
                "GL_ONE"
            } else {
                "GL_ZERO"
            };

            message.push_str(&format!(
                "Enabled: equation = {equation}, func src = {src}, func dst = {dst}"
            ));
        } else {
            // SAFETY: plain state setting on the current context.
            unsafe { self.gl.disable(glw::GL_BLEND) };
            message.push_str("Disabled");
        }

        log::info!("{message}");
    }

    /// `isFramebufferAttachmentSRGB`
    fn is_framebuffer_attachment_srgb(&self, target_type: GLenum, attachment: GLenum) -> Result<bool, TestError> {
        let mut encoding_type = 0;

        // SAFETY: one integer of output for a single-value query.
        unsafe {
            self.gl.get_framebuffer_attachment_parameteriv(
                target_type,
                attachment,
                glw::GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING,
                &mut encoding_type,
            )
        };
        glu::expect_no_error(self.gl, "glGetNamedFramebufferAttachmentParameteriv()")?;

        match encoding_type as GLenum {
            glw::GL_SRGB => Ok(true),
            glw::GL_LINEAR => Ok(false),
            _ => Err(TestError::InternalError(
                "Error: Color attachment format not recognised".to_string(),
            )),
        }
    }

    /// `readTexels`
    fn read_texels(&self, px: i32, py: i32, mode: GLenum) -> Result<Vec4, TestError> {
        let mut texture_read = TextureLevel::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            TEST_TEXTURE_WIDTH as u32,
            TEST_TEXTURE_HEIGHT as u32,
            1,
        )?;

        // SAFETY: plain state setting.
        unsafe { self.gl.read_buffer(mode) };
        glu::read_pixels(&self.context.render_context, px, py, &mut texture_read.get_access())?;
        glu::expect_no_error(self.gl, "glReadPixels()")?;
        Ok(texture_read.get_const_access().get_pixel(px as u32, py as u32, 0))
    }

    /// `logState`
    fn log_state(&self, target_type: GLenum, attachment: GLenum, sampling_type: i32) -> Result<(), TestError> {
        let fbo_attachment_srgb = self.is_framebuffer_attachment_srgb(target_type, attachment)?;
        log::info!(
            "getFramebufferAttachmentParameteriv() check = {}",
            if fbo_attachment_srgb { "GL_SRGB" } else { "GL_LINEAR" }
        );

        log_color(
            "Framebuffer color attachment value BEFORE draw call",
            self.results_list_pre_draw[self.render_pass],
        );
        log_color(
            "Framebuffer color attachment value AFTER draw call",
            self.results_list_post_draw[self.render_pass],
        );

        let type_name = match sampling_type {
            0 => "texture()",
            1 => "textureLOD()",
            2 => "textureGrad()",
            3 => "textureOffset()",
            4 => "textureProj()",
            _ => return Err(TestError::InternalError("Error: Sampling type unregonised".to_string())),
        };
        log::info!("Sampling type = {type_name}");

        log::info!(
            "Framebuffer SRGB = {}",
            if self.framebuffer_srgb_enabled {
                "enabled"
            } else {
                "disabled"
            }
        );
        Ok(())
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum RenderKind {
    ColAttach,
    ToggleBlend,
    RenderTargetIgnore,
    CopyToLinear,
}

/// The `setupTest` of each `FboSRGBTestCase` subclass.
fn setup_test(kind: RenderKind) -> Vec<TestRenderPassConfig> {
    match kind {
        RenderKind::ColAttach => {
            // TEST INFO:
            // Check if FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING  set to SRGB and FRAMEBUFFER_SRGB_EXT enabled, destination colors are converted from SRGB to linear
            // before and after blending, finally the result is converted back to SRGB for storage

            // NOTE:
            // if fbo pre-draw color set to linaer, color values get linearlized "twice"
            // (0.2f, 0.3f, 0.4f, 1.0f) when sampled i.e. converted in shader = (0.0331048f, 0.073239f, 0.132868f)
            // resulting in the follolwing blending equation (0.2f, 0.3f, 0.4f 1.0f) + (0.0331048, 0.073239, 0.132868) = (0.521569f, 0.647059f, 0.756863f, 1.0f)
            let fbo_config0 = FboConfig {
                texture_internal_format: glw::GL_SRGB8_ALPHA8,
                texture_color: get_test_color_linear(),
                fbo_target_type: glw::GL_FRAMEBUFFER,
                fbo_color_attachment: glw::GL_COLOR_ATTACHMENT0,
                fbo_type: FboType::Source,
            };
            let fbo_config1 = FboConfig {
                texture_internal_format: glw::GL_RGBA8,
                texture_color: get_test_color_linear(),
                fbo_target_type: glw::GL_FRAMEBUFFER,
                fbo_color_attachment: glw::GL_COLOR_ATTACHMENT0,
                fbo_type: FboType::Source,
            };

            vec![
                TestRenderPassConfig {
                    texture_sources_type: TextureSourcesType::Rgba,
                    fbo_config_list: vec![fbo_config0],
                    framebuffer_srgb: true,
                    framebuffer_blend: true,
                    test_function: None,
                    renderer_task: RendererTask::Draw,
                },
                TestRenderPassConfig {
                    texture_sources_type: TextureSourcesType::Both,
                    fbo_config_list: vec![fbo_config1],
                    framebuffer_srgb: false,
                    framebuffer_blend: false,
                    test_function: Some(get_function_blend_linear_to_srgb_check()),
                    renderer_task: RendererTask::Draw,
                },
            ]
        }
        RenderKind::ToggleBlend => {
            //    TEST INFO:
            //    Test to check if changing FRAMEBUFFER_SRGB_EXT from enabled to disabled. Enabled should produce SRGB color whilst disabled
            //    should produce linear color. Test conducted with blending disabled.
            let fbo_config0 = FboConfig {
                texture_internal_format: glw::GL_SRGB8_ALPHA8,
                texture_color: get_test_color_linear(),
                fbo_target_type: glw::GL_FRAMEBUFFER,
                fbo_color_attachment: glw::GL_COLOR_ATTACHMENT0,
                fbo_type: FboType::Destination,
            };

            vec![
                TestRenderPassConfig {
                    texture_sources_type: TextureSourcesType::Rgba,
                    fbo_config_list: vec![fbo_config0],
                    framebuffer_srgb: true,
                    framebuffer_blend: false,
                    test_function: None,
                    renderer_task: RendererTask::Draw,
                },
                TestRenderPassConfig {
                    texture_sources_type: TextureSourcesType::Rgba,
                    fbo_config_list: vec![fbo_config0],
                    framebuffer_srgb: false,
                    framebuffer_blend: false,
                    test_function: None,
                    renderer_task: RendererTask::Draw,
                },
            ]
        }
        RenderKind::RenderTargetIgnore => {
            // TEST INFO:
            // Check if render targets that are non-RGB ignore the state of GL_FRAMEBUFFER_SRGB_EXT. Rendering to an fbo with non-sRGB color
            // attachment should ignore color space conversion, producing linear color.
            let fbo_config0 = FboConfig {
                texture_internal_format: glw::GL_RGBA8,
                texture_color: get_test_color_blank(),
                fbo_target_type: glw::GL_FRAMEBUFFER,
                fbo_color_attachment: glw::GL_COLOR_ATTACHMENT0,
                fbo_type: FboType::Destination,
            };

            vec![TestRenderPassConfig {
                texture_sources_type: TextureSourcesType::Rgba,
                fbo_config_list: vec![fbo_config0],
                framebuffer_srgb: true,
                framebuffer_blend: false,
                test_function: None,
                renderer_task: RendererTask::Draw,
            }]
        }
        RenderKind::CopyToLinear => {
            // TEST INFO:
            // Check if copying from an fbo with an sRGB color attachment to an fbo with a linear color attachment with FRAMEBUFFER_EXT enabled results in
            // an sRGB to linear conversion
            let fbo_configs = vec![
                FboConfig {
                    texture_internal_format: glw::GL_SRGB8_ALPHA8,
                    texture_color: get_test_color_srgb(),
                    fbo_target_type: glw::GL_READ_FRAMEBUFFER,
                    fbo_color_attachment: glw::GL_COLOR_ATTACHMENT0,
                    fbo_type: FboType::Source,
                },
                FboConfig {
                    texture_internal_format: glw::GL_RGBA8,
                    texture_color: get_test_color_blank(),
                    fbo_target_type: glw::GL_DRAW_FRAMEBUFFER,
                    fbo_color_attachment: glw::GL_COLOR_ATTACHMENT0,
                    fbo_type: FboType::Destination,
                },
            ];

            vec![TestRenderPassConfig {
                texture_sources_type: TextureSourcesType::None,
                fbo_config_list: fbo_configs,
                framebuffer_srgb: true,
                framebuffer_blend: false,
                test_function: None,
                renderer_task: RendererTask::Copy,
            }]
        }
    }
}

/// The `verifyResult` of each `FboSRGBTestCase` subclass.
fn verify_result(kind: RenderKind, results_pre_draw: &[Vec4], results_post_draw: &[Vec4]) -> bool {
    match kind {
        RenderKind::ColAttach => colors_close(results_post_draw[0], results_post_draw[1]),
        RenderKind::ToggleBlend => {
            (0..4).any(|c| (results_post_draw[0][c] - results_post_draw[1][c]).abs() > get_epsilon_error()[c])
        }
        RenderKind::RenderTargetIgnore => colors_close(results_post_draw[0], get_test_color_linear()),
        RenderKind::CopyToLinear => {
            log_color("pre-copy source fbo color values", results_pre_draw[0]);
            log_color("pre-copy destination fbo color values", results_pre_draw[1]);
            log_color("post-copy source fbo color values", results_post_draw[0]);
            log_color("post-copy destination fbo color values", results_post_draw[1]);

            colors_close(results_post_draw[1], get_test_color_linear())
        }
    }
}

/// `FboSRGBTestCase`
struct FboSrgbTestCase {
    name: &'static str,
    kind: RenderKind,
}

impl TestCase for FboSrgbTestCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `FboSRGBTestCase::init`
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        // extensions requirements for test
        if !context.context_type().supports(3, 2) {
            return Err(TestError::NotSupported(
                "Test requires a context version equal or higher than 3.2".to_string(),
            ));
        }

        if !context.context_info.is_extension_supported("GL_EXT_sRGB_write_control") {
            return Err(TestError::NotSupported(
                "Test requires extension GL_EXT_sRGB_write_control".to_string(),
            ));
        }

        if !context
            .context_info
            .is_extension_supported("GL_EXT_texture_sRGB_decode")
        {
            return Err(TestError::NotSupported(
                "Test requires GL_EXT_texture_sRGB_decode extension".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_pass_config_list = setup_test(self.kind);
        let testcase_requires_blend = render_pass_config_list.iter().any(|config| config.framebuffer_blend);

        let mut renderer = Renderer::new(context)?;

        // loop through each sampling type
        for sampling_idx in 0..SAMPLING_TYPE_COUNT_MAX {
            renderer.sampling_type = sampling_idx;

            // loop through each blend configuration
            for blend_idx in 0..renderer.get_blend_config_count() {
                // loop through each render pass
                for (render_pass_idx, render_pass_config) in render_pass_config_list.iter().enumerate() {
                    renderer.init(render_pass_config, render_pass_idx)?;

                    if render_pass_config.framebuffer_blend {
                        renderer.blend_iteration = blend_idx;
                        renderer.framebuffer_blend_enabled = true;
                    } else {
                        renderer.framebuffer_blend_enabled = false;
                    }

                    renderer.framebuffer_srgb_enabled = render_pass_config.framebuffer_srgb;

                    match render_pass_config.renderer_task {
                        RendererTask::Draw => renderer.draw()?,
                        RendererTask::Copy => renderer.copy_frame_buffer_texture(0, 0, 0, 0)?,
                    }

                    renderer.deinit();
                } // render passes

                let results_pre_draw = renderer.results_list_pre_draw.clone();
                let results_post_draw = renderer.results_list_post_draw.clone();

                if !verify_result(self.kind, &results_pre_draw, &results_post_draw) {
                    return Ok(TestStatus::fail("Result verification failed"));
                }

                if !testcase_requires_blend {
                    break;
                }
            } // blend configs
        } // sampling types

        Ok(TestStatus::pass("Pass"))
    }
}

/// `FboSRGBQueryCase`
struct FboSrgbQueryCase {
    name: &'static str,
}

impl TestCase for FboSrgbQueryCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        // extension requirements for test
        if !context.context_info.is_extension_supported("GL_EXT_sRGB_write_control") {
            return Err(TestError::NotSupported(
                "Test requires extension GL_EXT_sRGB_write_control".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        // TEST INFO:
        // API tests which check when querying FRAMEBUFFER_SRGB_EXT capability returns the correct information when using glEnabled() or glDisabled()
        let gl = context.gl();
        let msg_part = ", after disabling = ";

        for idx in 0..5 {
            let mut message = String::from("Results: After Enabling = ");

            // SAFETY: plain state setting on the current context.
            unsafe { gl.enable(glw::GL_FRAMEBUFFER_SRGB) };

            // SAFETY: one value of output for each single-value query.
            let pass = unsafe {
                match idx {
                    // QUERYTYPE_ISENABLED
                    0 => {
                        let enabled0 = gl.is_enabled(glw::GL_FRAMEBUFFER_SRGB);
                        gl.disable(glw::GL_FRAMEBUFFER_SRGB);
                        let enabled1 = gl.is_enabled(glw::GL_FRAMEBUFFER_SRGB);

                        message.push_str(&format!("{}{msg_part}{}", enabled0 as f32, enabled1 as f32));
                        enabled0 != 0 && enabled1 == 0
                    }
                    // QUERYTYPE_BOOLEAN
                    1 => {
                        let mut enabled = [0u8; 2];
                        gl.get_booleanv(glw::GL_FRAMEBUFFER_SRGB, &mut enabled[0]);
                        gl.disable(glw::GL_FRAMEBUFFER_SRGB);
                        gl.get_booleanv(glw::GL_FRAMEBUFFER_SRGB, &mut enabled[1]);

                        message.push_str(&format!("{}{msg_part}{}", enabled[0] as f32, enabled[1] as f32));
                        enabled[0] != 0 && enabled[1] == 0
                    }
                    // QUERYTYPE_FLOAT
                    2 => {
                        let mut enabled = [0.0f32; 2];
                        gl.get_floatv(glw::GL_FRAMEBUFFER_SRGB, &mut enabled[0]);
                        gl.disable(glw::GL_FRAMEBUFFER_SRGB);
                        gl.get_floatv(glw::GL_FRAMEBUFFER_SRGB, &mut enabled[1]);

                        message.push_str(&format!("{}{msg_part}{}", enabled[0], enabled[1]));
                        (enabled[0] as i32) != 0 && (enabled[1] as i32) == 0
                    }
                    // QUERYTYPE_INT
                    3 => {
                        let mut enabled = [0i32; 2];
                        gl.get_integerv(glw::GL_FRAMEBUFFER_SRGB, &mut enabled[0]);
                        gl.disable(glw::GL_FRAMEBUFFER_SRGB);
                        gl.get_integerv(glw::GL_FRAMEBUFFER_SRGB, &mut enabled[1]);

                        message.push_str(&format!("{}{msg_part}{}", enabled[0] as f32, enabled[1] as f32));
                        enabled[0] != 0 && enabled[1] == 0
                    }
                    // QUERYTYPE_INT64
                    _ => {
                        let mut enabled = [0i64; 2];
                        gl.get_integer_64v(glw::GL_FRAMEBUFFER_SRGB, &mut enabled[0]);
                        gl.disable(glw::GL_FRAMEBUFFER_SRGB);
                        gl.get_integer_64v(glw::GL_FRAMEBUFFER_SRGB, &mut enabled[1]);

                        message.push_str(&format!("{}{msg_part}{}", enabled[0] as f32, enabled[1] as f32));
                        enabled[0] != 0 && enabled[1] == 0
                    }
                }
            };

            log::info!("{message}");

            if !pass {
                return Ok(TestStatus::fail("Result verification failed"));
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `FboSRGBUnsupportedEnumCase`
struct FboSrgbUnsupportedEnumCase {
    name: &'static str,
}

impl FboSrgbUnsupportedEnumCase {
    /// `isInvalidEnum`
    fn is_invalid_enum(gl: &glw::Functions, function_name: &str) -> bool {
        log::info!("Checking call to {function_name}");

        // SAFETY: a plain error query.
        let error = unsafe { gl.get_error() };

        if error != glw::GL_INVALID_ENUM {
            log::warn!(
                " returned wrong value [{error:#x}, expected {:#x}]",
                glw::GL_INVALID_ENUM
            );
            return false;
        }

        true
    }
}

impl TestCase for FboSrgbUnsupportedEnumCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        // extension requirements for test
        if context.context_info.is_extension_supported("GL_EXT_sRGB_write_control") {
            return Err(TestError::NotSupported(
                "Test requires extension GL_EXT_sRGB_write_control to be unsupported".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        // TEST INFO:
        // API tests that check calls using enum GL_FRAMEBUFFER_SRGB return GL_INVALID_ENUM  when GL_EXT_sRGB_write_control is not supported
        let gl = context.gl();
        let mut all_pass = true;

        log::info!(
            "Check calls using enum GL_FRAMEBUFFER_SRGB return GL_INVALID_ENUM  when GL_EXT_sRGB_write_control is not supported\n\n"
        );

        // SAFETY: each call is a plain state call or a single-value query with one value of output.
        unsafe {
            gl.enable(glw::GL_FRAMEBUFFER_SRGB);
            all_pass &= Self::is_invalid_enum(gl, "glEnable()");

            gl.disable(glw::GL_FRAMEBUFFER_SRGB);
            all_pass &= Self::is_invalid_enum(gl, "glDisable()");

            gl.is_enabled(glw::GL_FRAMEBUFFER_SRGB);
            all_pass &= Self::is_invalid_enum(gl, "glIsEnabled()");

            let mut b_enabled = glw::FALSE;
            gl.get_booleanv(glw::GL_FRAMEBUFFER_SRGB, &mut b_enabled);
            all_pass &= Self::is_invalid_enum(gl, "glGetBooleanv()");

            let mut f_enabled = 0.0f32;
            gl.get_floatv(glw::GL_FRAMEBUFFER_SRGB, &mut f_enabled);
            all_pass &= Self::is_invalid_enum(gl, "glGetFloatv()");

            let mut i_enabled = 0i32;
            gl.get_integerv(glw::GL_FRAMEBUFFER_SRGB, &mut i_enabled);
            all_pass &= Self::is_invalid_enum(gl, "glGetIntegerv()");

            let mut l_enabled = 0i64;
            gl.get_integer_64v(glw::GL_FRAMEBUFFER_SRGB, &mut l_enabled);
            all_pass &= Self::is_invalid_enum(gl, "glGetInteger64v()");
        }

        Ok(if all_pass {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `FboSRGBWriteControlTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("srgb_write_control");

    group.add_child(Box::new(FboSrgbQueryCase {
        name: "framebuffer_srgb_enabled",
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(FboSrgbTestCase {
        name: "framebuffer_srgb_enabled_col_attach",
        kind: RenderKind::ColAttach,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(FboSrgbTestCase {
        name: "framebuffer_srgb_enabled_blend",
        kind: RenderKind::ToggleBlend,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(FboSrgbTestCase {
        name: "framebuffer_srgb_enabled_render_target_ignore",
        kind: RenderKind::RenderTargetIgnore,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(FboSrgbTestCase {
        name: "framebuffer_srgb_enabled_copy_to_linear",
        kind: RenderKind::CopyToLinear,
    }) as Box<dyn TestCase>);

    // negative
    group.add_child(Box::new(FboSrgbUnsupportedEnumCase {
        name: "framebuffer_srgb_unsupported_enum",
    }) as Box<dyn TestCase>);

    group
}
