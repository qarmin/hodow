// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fSRGBDecodeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
//
// Upstream's `SRGBTestCase` base class with virtual `setupTest`/`verifyResult`/`render` is a
// `Fixture` plus a `Kind` that selects those three here. Wrap/filter modes are carried as the
// GL enums they map to (`MIRRORED_REPEAT_GL` -> `GL_MIRRORED_REPEAT`, `LINEAR` -> `GL_LINEAR`).
// The desktop-GL-core branches (`#version 450`, `GL_FRAMEBUFFER_SRGB`) are not written: this
// port only creates ES contexts. Shader build info is not logged.

use std::ffi::CString;

use crate::glu::texture::Texture2D;
use crate::glu::{
    self, Buffer, Context, Framebuffer, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup, VertexArray,
};
use crate::glw::{self, GLenum, GLsizeiptr, GLuint};
use crate::tcu::pixel::{TextureLevel, linear_to_srgb, srgb_to_linear};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::{TestError, TestOutcome, TestStatus};

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum SrgbDecode {
    SkipDecode = 0,
    Decode = 1,
    DecodeDefault = 2,
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum SamplingType {
    Texture,
    TextureLod,
    TextureGrad,
    TextureOffset,
    TextureProj,
    TexelFetch,
    TexelFetchOffset,
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum SamplingGroup {
    Texture,
    TexelFetch,
}

/// `TEXTURESAMPLING_TEXTURE_START..TEXTURESAMPLING_TEXTURE_END`
const TEXTURE_SAMPLING_TYPES: [SamplingType; 5] = [
    SamplingType::Texture,
    SamplingType::TextureLod,
    SamplingType::TextureGrad,
    SamplingType::TextureOffset,
    SamplingType::TextureProj,
];
/// `TEXTURESAMPLING_TEXELFETCH_START..TEXTURESAMPLING_TEXELFETCH_END`
const TEXEL_FETCH_SAMPLING_TYPES: [SamplingType; 2] = [SamplingType::TexelFetch, SamplingType::TexelFetchOffset];

const EPSILON_ERROR_CPU: f32 = 0.005;
const TEST_WIDTH: u32 = 128;
const TEST_HEIGHT: u32 = 128;
const SAMPLING_X_POS: u32 = 0;
const SAMPLING_Y_POS: u32 = 0;

type Vec4 = [f32; 4];

fn color_reference_linear() -> Vec4 {
    [0.2, 0.3, 0.4, 1.0]
}

fn color_reference_srgb() -> Vec4 {
    linear_to_srgb(color_reference_linear())
}

fn color_green_pass() -> Vec4 {
    [0.0, 1.0, 0.0, 1.0]
}

const FUNCTION_DEFINITION_SRGB_TO_LINEAR_CHECK: &str = "mediump vec4 srgbToLinearCheck(in mediump vec4 texelSRGBA, in mediump vec4 texelLinear) \n\
    { \n\
    \x20   const int NUM_CHANNELS = 4;\
    \x20   mediump vec4 texelSRGBAConverted; \n\
    \x20   mediump vec4 epsilonErr = vec4(0.005); \n\
    \x20   mediump vec4 testResult; \n\
    \x20   for (int idx = 0; idx < NUM_CHANNELS; idx++) \n\
    \x20   { \n\
    \x20       texelSRGBAConverted[idx] = pow( (texelSRGBA[idx] + 0.055) / 1.055, 1.0 / 0.4116); \n\
    \x20   } \n\
    \x20   if ( all(lessThan(abs(texelSRGBAConverted - texelLinear), epsilonErr)) || all(equal(texelSRGBAConverted, texelLinear)) ) \n\
    \x20   { \n\
    \x20       return testResult = vec4(0.0, 1.0, 0.0, 1.0); \n\
    \x20   } \n\
    \x20   else \n\
    \x20   { \n\
    \x20       return testResult = vec4(1.0, 0.0, 0.0, 1.0); \n\
    \x20   } \n\
    } \n";

const FUNCTION_DEFINITION_EQUAL_CHECK: &str = "mediump vec4 colorsEqualCheck(in mediump vec4 colorA, in mediump vec4 colorB) \n\
    { \n\
    \x20   mediump vec4 epsilonErr = vec4(0.005); \n\
    \x20   mediump vec4 testResult; \n\
    \x20   if ( all(lessThan(abs(colorA - colorB), epsilonErr)) || all(equal(colorA, colorB)) ) \n\
    \x20   { \n\
    \x20       return testResult = vec4(0.0, 1.0, 0.0, 1.0); \n\
    \x20   } \n\
    \x20   else \n\
    \x20   { \n\
    \x20       return testResult = vec4(1.0, 0.0, 0.0, 1.0); \n\
    \x20   } \n\
    } \n";

/// `ComparisonFunction`
#[derive(Clone)]
struct ComparisonFunction {
    name: &'static str,
    parameters: i32,
    implementation: &'static str,
}

/// `FragmentShaderParameters`
#[derive(Clone)]
struct FragmentShaderParameters {
    output_total: i32,
    uniform_total: i32,
    sampling_type: SamplingType,
    function: Option<ComparisonFunction>,
    blend_required: bool,
    toggle_required: bool,
    uniforms_to_toggle: Vec<&'static str>,
}

impl FragmentShaderParameters {
    fn new(
        output_total: i32,
        uniform_total: i32,
        function: Option<ComparisonFunction>,
        blend_required: bool,
        toggle_required: bool,
    ) -> Self {
        Self {
            output_total,
            uniform_total,
            sampling_type: SamplingType::Texture,
            function,
            blend_required,
            toggle_required,
            uniforms_to_toggle: Vec::new(),
        }
    }
}

/// `UniformData`
struct UniformData {
    location: u32,
    name: String,
    toggle_decode: bool,
}

/// `SRGBTestSampler`
struct SrgbTestSampler<'gl> {
    gl: &'gl glw::Functions,
    handle: GLuint,
    texture_unit: u32,
    is_active: bool,
}

impl<'gl> SrgbTestSampler<'gl> {
    fn new(
        gl: &'gl glw::Functions,
        wrap_s: GLenum,
        wrap_t: GLenum,
        min_filter: GLenum,
        mag_filter: GLenum,
        decoding: SrgbDecode,
    ) -> Result<Self, TestError> {
        let mut handle = 0;
        // SAFETY: one sampler name of output, parameters are plain enums.
        unsafe {
            gl.gen_samplers(1, &mut handle);

            gl.sampler_parameteri(handle, glw::GL_TEXTURE_WRAP_S, wrap_s as i32);
            gl.sampler_parameteri(handle, glw::GL_TEXTURE_WRAP_T, wrap_t as i32);
            gl.sampler_parameteri(handle, glw::GL_TEXTURE_MIN_FILTER, min_filter as i32);
            gl.sampler_parameteri(handle, glw::GL_TEXTURE_MAG_FILTER, mag_filter as i32);
        }

        let mut sampler = Self {
            gl,
            handle,
            texture_unit: 0,
            is_active: false,
        };
        sampler.set_decode(decoding)?;
        Ok(sampler)
    }

    fn set_decode(&mut self, decoding: SrgbDecode) -> Result<(), TestError> {
        match decoding {
            SrgbDecode::SkipDecode => {
                // SAFETY: a sampler this object generated.
                unsafe {
                    self.gl.sampler_parameteri(
                        self.handle,
                        glw::GL_TEXTURE_SRGB_DECODE_EXT,
                        glw::GL_SKIP_DECODE_EXT as i32,
                    )
                };
                glu::expect_no_error(
                    self.gl,
                    "samplerParameteri(m_samplerID, GL_TEXTURE_SRGB_DECODE_EXT, GL_SKIP_DECODE_EXT)",
                )
            }
            SrgbDecode::Decode => {
                // SAFETY: as above.
                unsafe {
                    self.gl
                        .sampler_parameteri(self.handle, glw::GL_TEXTURE_SRGB_DECODE_EXT, glw::GL_DECODE_EXT as i32)
                };
                glu::expect_no_error(
                    self.gl,
                    "samplerParameteri(m_samplerID, GL_TEXTURE_SRGB_DECODE_EXT, GL_DECODE_EXT)",
                )
            }
            SrgbDecode::DecodeDefault => Err(TestError::InternalError(
                "sRGB texture sampler must have either GL_SKIP_DECODE_EXT or GL_DECODE_EXT settings".to_string(),
            )),
        }
    }

    fn bind_to_texture(&self) {
        // SAFETY: a sampler this object generated.
        unsafe { self.gl.bind_sampler(self.texture_unit, self.handle) };
    }
}

impl Drop for SrgbTestSampler<'_> {
    fn drop(&mut self) {
        // SAFETY: the sampler is this object's own and is deleted exactly once.
        unsafe { self.gl.delete_samplers(1, &self.handle) };
    }
}

/// `SRGBTestTexture` (only `TEXTURETYPE_2D` exists upstream)
struct SrgbTestTexture<'gl> {
    gl: &'gl glw::Functions,
    source: Texture2D<'gl>,
    wrap_s: GLenum,
    wrap_t: GLenum,
    min_filter: GLenum,
    mag_filter: GLenum,
    decoding: SrgbDecode,
}

impl<'gl> SrgbTestTexture<'gl> {
    #[allow(clippy::too_many_arguments)]
    fn new(
        context: &'gl Context,
        internal_format: GLenum,
        width: u32,
        height: u32,
        color: Vec4,
        wrap_s: GLenum,
        wrap_t: GLenum,
        min_filter: GLenum,
        mag_filter: GLenum,
        decoding: SrgbDecode,
    ) -> Result<Self, TestError> {
        let gl = context.gl();
        let mut texture = Self {
            gl,
            source: Texture2D::new_sized(&context.render_context, internal_format, width, height)?,
            wrap_s,
            wrap_t,
            min_filter,
            mag_filter,
            decoding,
        };
        texture.set_color(width, height, color);
        Ok(texture)
    }

    fn target(&self) -> GLenum {
        glw::GL_TEXTURE_2D
    }

    fn handle(&self) -> GLuint {
        self.source.gl_texture()
    }

    fn set_parameters(&mut self) -> Result<(), TestError> {
        // SAFETY: a texture this object owns.
        unsafe {
            self.gl.bind_texture(self.target(), self.handle());

            self.gl
                .tex_parameteri(self.target(), glw::GL_TEXTURE_WRAP_S, self.wrap_s as i32);
            self.gl
                .tex_parameteri(self.target(), glw::GL_TEXTURE_WRAP_T, self.wrap_t as i32);
            self.gl
                .tex_parameteri(self.target(), glw::GL_TEXTURE_MIN_FILTER, self.min_filter as i32);
            self.gl
                .tex_parameteri(self.target(), glw::GL_TEXTURE_MAG_FILTER, self.mag_filter as i32);

            self.gl.bind_texture(self.target(), 0);
        }

        self.set_decode(self.decoding)
    }

    fn set_decode(&mut self, decoding: SrgbDecode) -> Result<(), TestError> {
        // SAFETY: a texture this object owns.
        unsafe { self.gl.bind_texture(self.target(), self.handle()) };

        match decoding {
            SrgbDecode::SkipDecode => {
                // SAFETY: as above.
                unsafe {
                    self.gl.tex_parameteri(
                        self.target(),
                        glw::GL_TEXTURE_SRGB_DECODE_EXT,
                        glw::GL_SKIP_DECODE_EXT as i32,
                    )
                };
                glu::expect_no_error(
                    self.gl,
                    "glTexParameteri(this->getGLTargetType(), GL_TEXTURE_SRGB_DECODE_EXT, GL_SKIP_DECODE_EXT)",
                )?;
            }
            SrgbDecode::Decode => {
                // SAFETY: as above.
                unsafe {
                    self.gl.tex_parameteri(
                        self.target(),
                        glw::GL_TEXTURE_SRGB_DECODE_EXT,
                        glw::GL_DECODE_EXT as i32,
                    )
                };
                glu::expect_no_error(
                    self.gl,
                    "glTexParameteri(this->getGLTargetType(), GL_TEXTURE_SRGB_DECODE_EXT, GL_DECODE_EXT)",
                )?;
            }
            SrgbDecode::DecodeDefault => {
                // do not use srgb decode options. Set to default
            }
        }

        // SAFETY: as above.
        unsafe { self.gl.bind_texture(self.target(), 0) };

        self.decoding = decoding;
        Ok(())
    }

    fn upload(&self) -> Result<(), TestError> {
        // SAFETY: a current context whose entry points the texture's own `gl` loaded.
        unsafe { self.source.upload() }
    }

    fn set_color(&mut self, width: u32, height: u32, color: Vec4) {
        // SAFETY: a texture this object owns.
        unsafe { self.gl.bind_texture(self.target(), self.handle()) };

        self.source.ref_texture_mut().alloc_level(0);

        {
            let mut level = self.source.ref_texture_mut().level_mut(0);
            for py in 0..height {
                for px in 0..width {
                    level.set_pixel(color, px, py, 0);
                }
            }
        }

        // SAFETY: as above.
        unsafe { self.gl.bind_texture(self.target(), 0) };
    }
}

/// `SRGBTestProgram`
struct SrgbTestProgram<'gl> {
    program: ShaderProgram<'gl>,
    uniform_data_list: Vec<UniformData>,
    blend_required: bool,
}

impl<'gl> SrgbTestProgram<'gl> {
    fn new(gl: &'gl glw::Functions, params: &FragmentShaderParameters) -> Result<Self, TestError> {
        // default vertex shader used in all tests
        let shader_vertex = "#version 310 es\n\
            layout (location = 0) in mediump vec3 aPosition; \n\
            layout (location = 1) in mediump vec2 aTexCoord; \n\
            out mediump vec2 vs_aTexCoord; \n\
            void main () \n\
            { \n\
            \x20   gl_Position = vec4(aPosition, 1.0); \n\
            \x20   vs_aTexCoord = aTexCoord; \n\
            } \n";
        let shader_fragment = Self::gen_fragment_shader(params);

        let program = ShaderProgram::new(
            gl,
            &ProgramSources::default()
                .with(ShaderType::Vertex, shader_vertex)
                .with(ShaderType::Fragment, shader_fragment),
        );
        if !program.is_ok() {
            return Err(TestError::Fail(
                "Failed to compile shaders and link program".to_string(),
            ));
        }

        let mut active_uniforms = 0;
        let mut max_len = 0;
        // SAFETY: plain queries against the program just linked.
        unsafe {
            gl.get_programiv(program.program(), glw::GL_ACTIVE_UNIFORM_MAX_LENGTH, &mut max_len);
            gl.get_programiv(program.program(), glw::GL_ACTIVE_UNIFORMS, &mut active_uniforms);
        }

        let mut uniform_data_list = Vec::new();
        let mut uniform_name = vec![0u8; max_len.max(1) as usize];
        for idx in 0..active_uniforms {
            let mut size = 0;
            let mut type_ = 0;
            // SAFETY: the name buffer is `max_len` bytes, which is what the query is told.
            let location = unsafe {
                gl.get_active_uniform(
                    program.program(),
                    idx as GLuint,
                    max_len,
                    std::ptr::null_mut(),
                    &mut size,
                    &mut type_,
                    uniform_name.as_mut_ptr().cast(),
                );
                gl.get_uniform_location(program.program(), uniform_name.as_ptr().cast())
            };
            let name_len = uniform_name.iter().position(|&b| b == 0).unwrap_or(uniform_name.len());
            uniform_data_list.push(UniformData {
                location: location as GLuint,
                name: String::from_utf8_lossy(&uniform_name[..name_len]).into_owned(),
                toggle_decode: false,
            });
        }

        Ok(Self {
            program,
            uniform_data_list,
            blend_required: false,
        })
    }

    fn set_uniform_toggle(&mut self, location: i32, toggle_decode_value: bool) -> Result<(), TestError> {
        if !self.uniform_data_list.is_empty() && location >= 0 && (location as usize) < self.uniform_data_list.len() {
            self.uniform_data_list[location as usize].toggle_decode = toggle_decode_value;
            Ok(())
        } else {
            Err(TestError::Fail(
                "Error: Uniform location not found. glGetActiveUniforms returned uniforms incorrectly ".to_string(),
            ))
        }
    }

    fn get_uniform_location(&self, name: &str) -> Result<i32, TestError> {
        for data in &self.uniform_data_list {
            if data.name == name {
                return Ok(data.location as i32);
            }
        }

        Err(TestError::Fail(
            "Error: If name correctly requested then glGetActiveUniforms() returned active uniform data incorrectly"
                .to_string(),
        ))
    }

    fn handle(&self) -> GLuint {
        self.program.program()
    }

    /// `genFunctionCall`
    fn gen_function_call(sampling_type: SamplingType, uniform_idx: i32) -> String {
        let mut call = format!("    mediump vec4 texelColor{uniform_idx} = ");

        match sampling_type {
            SamplingType::Texture => call.push_str(&format!("texture(uTexture{uniform_idx}, vs_aTexCoord); \n")),
            SamplingType::TextureLod => {
                call.push_str(&format!("textureLod(uTexture{uniform_idx}, vs_aTexCoord, 0.0); \n"))
            }
            SamplingType::TextureGrad => call.push_str(&format!(
                "textureGrad(uTexture{uniform_idx}, vs_aTexCoord, vec2(0.0, 0.0), vec2(0.0, 0.0)); \n"
            )),
            SamplingType::TextureOffset => call.push_str(&format!(
                "textureOffset(uTexture{uniform_idx}, vs_aTexCoord, ivec2(0.0, 0.0)); \n"
            )),
            SamplingType::TextureProj => call.push_str(&format!(
                "textureProj(uTexture{uniform_idx}, vec3(vs_aTexCoord, 1.0)); \n"
            )),
            SamplingType::TexelFetch => call.push_str(&format!(
                "texelFetch(uTexture{uniform_idx}, ivec2(vs_aTexCoord), 0); \n"
            )),
            SamplingType::TexelFetchOffset => call.push_str(&format!(
                "texelFetchOffset(uTexture{uniform_idx}, ivec2(vs_aTexCoord), 0, ivec2(0.0, 0.0)); \n"
            )),
        }

        call
    }

    /// `genFragmentShader`
    fn gen_fragment_shader(params: &FragmentShaderParameters) -> String {
        // if comparison function is present resulting shader requires precisely one output
        debug_assert!(!(params.function.is_some() && params.output_total != 1));
        // function parameters must equal the number of uniforms i.e. textures passed into the function
        debug_assert!(
            params
                .function
                .as_ref()
                .is_none_or(|f| f.parameters == params.uniform_total)
        );
        // fragment shader cannot contain more outputs than the number of texture uniforms
        debug_assert!(params.output_total <= params.uniform_total);

        let mut source = String::from("#version 310 es\nin mediump vec2 vs_aTexCoord; \n");

        for output in 0..params.output_total {
            source.push_str(&format!(
                "layout (location = {output}) out mediump vec4 fs_aColor{output}; \n"
            ));
        }

        for uniform in 0..params.uniform_total {
            source.push_str(&format!("uniform sampler2D uTexture{uniform}; \n"));
        }

        if let Some(function) = &params.function {
            source.push_str(function.implementation);
        }

        source.push_str("void main () \n{ \n");

        for uniform_idx in 0..params.uniform_total {
            source.push_str(&Self::gen_function_call(params.sampling_type, uniform_idx));
        }

        if let Some(function) = &params.function {
            let function_parameters = match function.parameters {
                1 => "(texelColor0)",
                _ => "(texelColor0, texelColor1)",
            };

            source.push_str(&format!(
                "    fs_aColor0 = {}{}; \n",
                function.name, function_parameters
            ));
        } else {
            for output in 0..params.output_total {
                source.push_str(&format!("    fs_aColor{output} = texelColor{output}; \n"));
            }
        }

        source.push_str("} \n");
        source
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Kind {
    TextureDecodeSkipped,
    TextureDecodeEnabled,
    TexelFetchDecodeSkipped,
    GpuConversionDecodeEnabled,
    DecodeToggled,
    DecodeMultipleTextures,
    DecodeSampler,
}

/// `SRGBTestCase`'s state, minus the test-node part.
struct Fixture<'a> {
    context: &'a Context,
    gl: &'a glw::Functions,
    internal_format: GLenum,
    framebuffer: Framebuffer<'a>,
    texture_source_list: Vec<SrgbTestTexture<'a>>,
    sampler_list: Vec<SrgbTestSampler<'a>>,
    render_buffer_list: Vec<GLuint>,
    texture_result_list: Vec<TextureLevel>,
    result_output_total: i32,
    result_texture_format: TextureFormat,
    vao: Option<VertexArray<'a>>,
    vertex_data: Option<Buffer<'a>>,
    shader_parameters_list: Vec<FragmentShaderParameters>,
    shader_program_list: Vec<SrgbTestProgram<'a>>,
    sampling_group: SamplingGroup,
    px: u32,
    py: u32,
}

impl Drop for Fixture<'_> {
    fn drop(&mut self) {
        for render_buffer in &self.render_buffer_list {
            // SAFETY: names this fixture generated, deleted exactly once.
            unsafe { self.gl.delete_renderbuffers(1, render_buffer) };
        }
    }
}

impl<'a> Fixture<'a> {
    fn new(context: &'a Context, internal_format: GLenum) -> Self {
        let gl = context.gl();
        Self {
            context,
            gl,
            internal_format,
            framebuffer: Framebuffer::new(gl),
            texture_source_list: Vec::new(),
            sampler_list: Vec::new(),
            render_buffer_list: Vec::new(),
            texture_result_list: Vec::new(),
            result_output_total: 0,
            result_texture_format: TextureFormat::new(ChannelOrder::sRGBA, ChannelType::UNORM_INT8),
            vao: None,
            vertex_data: None,
            shader_parameters_list: Vec::new(),
            shader_program_list: Vec::new(),
            sampling_group: SamplingGroup::Texture,
            px: 0,
            py: 0,
        }
    }

    fn add_texture(&mut self, width: u32, height: u32, color: Vec4, decoding: SrgbDecode) -> Result<(), TestError> {
        let texture = SrgbTestTexture::new(
            self.context,
            self.internal_format,
            width,
            height,
            color,
            glw::GL_MIRRORED_REPEAT,
            glw::GL_MIRRORED_REPEAT,
            glw::GL_LINEAR,
            glw::GL_LINEAR,
            decoding,
        )?;
        self.texture_source_list.push(texture);
        Ok(())
    }

    fn add_sampler(&mut self, decoding: SrgbDecode) -> Result<(), TestError> {
        let sampler = SrgbTestSampler::new(
            self.gl,
            glw::GL_MIRRORED_REPEAT,
            glw::GL_MIRRORED_REPEAT,
            glw::GL_LINEAR,
            glw::GL_LINEAR,
            decoding,
        )?;
        self.sampler_list.push(sampler);
        Ok(())
    }

    fn add_shader_program(&mut self, shader_parameters: FragmentShaderParameters) {
        self.result_output_total = shader_parameters.output_total;
        self.shader_parameters_list.push(shader_parameters);
    }

    fn set_sampling_locations(&mut self, px: u32, py: u32) {
        self.px = px;
        self.py = py;
    }

    fn bind_sampler_to_texture(&mut self, sampler_idx: usize, texture_unit: GLenum) {
        self.sampler_list[sampler_idx].texture_unit = texture_unit - glw::GL_TEXTURE0;
    }

    fn activate_sampler(&mut self, sampler_idx: usize, active: bool) {
        self.sampler_list[sampler_idx].is_active = active;
    }

    /// `genShaderPrograms`
    fn gen_shader_programs(&mut self, sampling_type: SamplingType) -> Result<(), TestError> {
        for params_idx in 0..self.shader_parameters_list.len() {
            self.shader_parameters_list[params_idx].sampling_type = sampling_type;
            let params = self.shader_parameters_list[params_idx].clone();
            let mut shader_program = SrgbTestProgram::new(self.gl, &params)?;

            if params.blend_required {
                shader_program.blend_required = true;
            }

            if params.toggle_required {
                for uniform_name in &params.uniforms_to_toggle {
                    let location = shader_program.get_uniform_location(uniform_name)?;
                    shader_program.set_uniform_toggle(location, true)?;
                }
            }

            self.shader_program_list.push(shader_program);
        }
        Ok(())
    }

    fn delete_shader_programs(&mut self) {
        self.shader_program_list.clear();
    }

    /// `readResultTextures`
    fn read_result_textures(&mut self) -> Result<(), TestError> {
        let render_target = self.context.render_target();
        let width = render_target.width as u32;
        let height = render_target.height as u32;

        // SAFETY: a framebuffer this fixture owns.
        unsafe { self.gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.framebuffer.get()) };

        self.texture_result_list.clear();

        for render_buffer_idx in 0..self.render_buffer_list.len() {
            // SAFETY: a colour attachment this fixture created.
            unsafe {
                self.gl
                    .read_buffer(glw::GL_COLOR_ATTACHMENT0 + render_buffer_idx as GLenum)
            };
            let mut level = TextureLevel::new(self.result_texture_format, width, height, 1)?;
            glu::read_pixels(&self.context.render_context, 0, 0, &mut level.get_access())?;
            glu::expect_no_error(self.gl, "glReadPixels()")?;
            self.texture_result_list.push(level);
        }

        // SAFETY: as above.
        unsafe { self.gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };
        Ok(())
    }

    /// `storeResultPixels`
    fn store_result_pixels(&self) -> Vec<Vec4> {
        let mut result_pixel_data = Vec::new();

        for (idx, level) in self.texture_result_list.iter().enumerate() {
            result_pixel_data.push(level.get_const_access().get_pixel(self.px, self.py, 0));
            Self::log_color("Result color: ", idx as i32, result_pixel_data[idx]);
        }

        // log error rate (threshold)
        log::info!(
            "Epsilon error: ({EPSILON_ERROR_CPU}, {EPSILON_ERROR_CPU}, {EPSILON_ERROR_CPU}, {EPSILON_ERROR_CPU})"
        );
        result_pixel_data
    }

    /// `toggleDecode`
    fn toggle_decode(&mut self, toggles: &[bool]) -> Result<(), TestError> {
        debug_assert!(toggles.len() <= self.texture_source_list.len());

        for (uniform_idx, &toggle) in toggles.iter().enumerate() {
            if toggle {
                if self.texture_source_list[uniform_idx].decoding == SrgbDecode::DecodeDefault {
                    // cannot toggle default
                    continue;
                }

                // toggle sRGB decode values (ignoring value if set to default)
                let next = match self.texture_source_list[uniform_idx].decoding {
                    SrgbDecode::SkipDecode => SrgbDecode::Decode,
                    _ => SrgbDecode::SkipDecode,
                };
                self.texture_source_list[uniform_idx].set_decode(next)?;
            }
        }
        Ok(())
    }

    fn log_color(message: &str, color_idx: i32, color: Vec4) {
        log::info!(
            "{message}{color_idx} = ({}, {}, {}, {})",
            color[0],
            color[1],
            color[2],
            color[3]
        );
    }

    /// `formatReferenceColor`
    fn format_reference_color(&self, mut reference_color: Vec4) -> Vec4 {
        match self.internal_format {
            glw::GL_SRGB8_ALPHA8 => reference_color,
            glw::GL_SRG8_EXT => {
                // zero unwanted color channels
                reference_color[2] = 0.0;
                reference_color
            }
            glw::GL_SR8_EXT => {
                // zero unwanted color channels
                reference_color[1] = 0.0;
                reference_color[2] = 0.0;
                reference_color
            }
            _ => reference_color,
        }
    }

    /// The per-texture part of both `render` variants.
    fn bind_textures_and_samplers(&self, program_handle: GLuint) -> Result<(), TestError> {
        for (texture_source_idx, texture) in self.texture_source_list.iter().enumerate() {
            let name = CString::new(format!("uTexture{texture_source_idx}")).expect("no interior NUL");
            // SAFETY: a texture and program this fixture owns, a NUL-terminated name.
            let sampler_uniform_location = unsafe {
                self.gl.active_texture(glw::GL_TEXTURE0 + texture_source_idx as GLenum);
                self.gl.bind_texture(texture.target(), texture.handle());
                self.gl.get_uniform_location(program_handle, name.as_ptr())
            };
            if sampler_uniform_location == -1 {
                return Err(TestError::Fail(
                    "samplerUniformLocationID != (glw::GLuint)-1".to_string(),
                ));
            }
            // SAFETY: as above.
            unsafe { self.gl.uniform_1i(sampler_uniform_location, texture_source_idx as i32) };
        }

        for sampler in &self.sampler_list {
            if sampler.is_active {
                sampler.bind_to_texture();
            }
        }
        Ok(())
    }

    fn unbind_after_render(&self) {
        // SAFETY: plain unbinds.
        unsafe {
            for texture in &self.texture_source_list {
                self.gl.bind_texture(texture.target(), 0);
            }
            self.gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            self.gl.bind_vertex_array(0);
            self.gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        }
    }

    fn vao_handle(&self) -> GLuint {
        self.vao.as_ref().map_or(0, VertexArray::get)
    }

    /// `render` - the default implementation, which only uses one program.
    fn render(&self) -> Result<(), TestError> {
        // SAFETY: names this fixture owns.
        unsafe {
            self.gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.framebuffer.get());
            self.gl.bind_vertex_array(self.vao_handle());

            self.gl.use_program(self.shader_program_list[0].handle());
        }

        self.bind_textures_and_samplers(self.shader_program_list[0].handle())?;

        // SAFETY: as above.
        unsafe { self.gl.draw_arrays(glw::GL_TRIANGLES, 0, 6) };

        self.unbind_after_render();
        Ok(())
    }

    /// `DecodeToggledCase::render` - switches between shader programs, toggling texture sRGB
    /// decode state between draw calls.
    fn render_toggled(&mut self) -> Result<(), TestError> {
        // SAFETY: names this fixture owns.
        unsafe {
            self.gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.framebuffer.get());
            self.gl.bind_vertex_array(self.vao_handle());
        }

        for program_idx in 0..self.shader_program_list.len() {
            let handle = self.shader_program_list[program_idx].handle();
            let toggles: Vec<bool> = self.shader_program_list[program_idx]
                .uniform_data_list
                .iter()
                .map(|u| u.toggle_decode)
                .collect();

            // SAFETY: a program this fixture owns.
            unsafe { self.gl.use_program(handle) };

            self.toggle_decode(&toggles)?;

            self.bind_textures_and_samplers(handle)?;

            // SAFETY: plain state setting and a draw of the bound vertex array.
            unsafe {
                if self.shader_program_list[program_idx].blend_required {
                    self.gl.enable(glw::GL_BLEND);
                    self.gl.blend_equation(glw::GL_MAX);
                    self.gl.blend_func(glw::GL_ONE, glw::GL_ONE);
                } else {
                    self.gl.disable(glw::GL_BLEND);
                }

                self.gl.draw_arrays(glw::GL_TRIANGLES, 0, 6);
            }

            // reset sRGB decode state on textures
            self.toggle_decode(&toggles)?;
        }

        self.unbind_after_render();
        Ok(())
    }

    fn upload_textures(&mut self) -> Result<(), TestError> {
        for texture in &mut self.texture_source_list {
            texture.upload()?;
            texture.set_parameters()?;
        }
        Ok(())
    }

    /// `initFrameBuffer`
    fn init_frame_buffer(&mut self) -> Result<(), TestError> {
        let render_target = self.context.render_target();
        let width = render_target.width;
        let height = render_target.height;
        let gl = self.gl;

        if self.result_output_total == 0 {
            return Err(TestError::InternalError(
                "SRGBTestExecutor must have at least 1 rendered result".to_string(),
            ));
        }

        // SAFETY: a framebuffer this fixture owns.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.framebuffer.get()) };

        debug_assert!(self.render_buffer_list.is_empty());
        for output_idx in 0..self.result_output_total {
            let mut render_buffer = 0;
            // SAFETY: one renderbuffer name of output; storage and attachment on it.
            unsafe {
                gl.gen_renderbuffers(1, &mut render_buffer);
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, render_buffer);
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_SRGB8_ALPHA8, width, height);
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0 + output_idx as GLenum,
                    glw::GL_RENDERBUFFER,
                    render_buffer,
                );
            }
            self.render_buffer_list.push(render_buffer);
            glu::expect_no_error(gl, "Create and setup renderbuffer object")?;
        }
        // SAFETY: a plain query.
        if unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::Fail(
                "gl.checkFramebufferStatus(GL_FRAMEBUFFER) == GL_FRAMEBUFFER_COMPLETE".to_string(),
            ));
        }

        let render_buffer_targets: Vec<GLenum> = (0..self.render_buffer_list.len())
            .map(|idx| glw::GL_COLOR_ATTACHMENT0 + idx as GLenum)
            .collect();
        // SAFETY: `n` entries of a live vector.
        unsafe { gl.draw_buffers(render_buffer_targets.len() as i32, render_buffer_targets.as_ptr()) };
        glu::expect_no_error(gl, "glDrawBuffer()")?;

        // SAFETY: unbinding.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };
        Ok(())
    }

    /// `initVertexData`
    fn init_vertex_data(&mut self) {
        let gl = self.gl;

        #[rustfmt::skip]
        let square_vertex_data: [f32; 30] = [
            // position                // texcoord
            -1.0, -1.0, 0.0, 0.0, 0.0, // bottom left corner
            1.0,  -1.0, 0.0, 1.0, 0.0, // bottom right corner
            1.0,  1.0,  0.0, 1.0, 1.0, // Top right corner

            -1.0, 1.0,  0.0, 0.0, 1.0, // top left corner
            1.0,  1.0,  0.0, 1.0, 1.0, // Top right corner
            -1.0, -1.0, 0.0, 0.0, 0.0  // bottom left corner
        ];

        debug_assert!(self.vao.is_none());
        let vao = VertexArray::new(gl);
        let vertex_data = Buffer::new(gl);

        let stride = 5 * std::mem::size_of::<f32>() as i32;
        // SAFETY: names this fixture just generated, and an array that outlives the upload.
        unsafe {
            gl.bind_vertex_array(vao.get());

            gl.bind_buffer(glw::GL_ARRAY_BUFFER, vertex_data.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&square_vertex_data) as GLsizeiptr,
                square_vertex_data.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );

            gl.vertex_attrib_pointer(0, 3, glw::GL_FLOAT, glw::FALSE, stride, std::ptr::null());
            gl.enable_vertex_attrib_array(0);
            gl.vertex_attrib_pointer(
                1,
                2,
                glw::GL_FLOAT,
                glw::FALSE,
                stride,
                (3 * std::mem::size_of::<f32>()) as *const std::ffi::c_void,
            );
            gl.enable_vertex_attrib_array(1);

            gl.bind_vertex_array(0);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        }

        self.vao = Some(vao);
        self.vertex_data = Some(vertex_data);
    }

    /// Each case's `setupTest`.
    fn setup_test(&mut self, kind: Kind) -> Result<(), TestError> {
        let linear = color_reference_linear();

        match kind {
            Kind::TextureDecodeSkipped => {
                // TEST STEPS:
                //    - create and set texture to DECODE_SKIP_EXT
                //    - store texture on GPU
                //    - in fragment shader, sample the texture using texture*() and render texel values to a color attachment in the FBO
                //    - on the host, read back the pixel values into a tcu::TextureLevel
                //    - analyse the texel values, expecting them in sRGB format i.e. linear space decoding was skipped
                let shader_parameters = FragmentShaderParameters::new(1, 1, None, false, false);

                self.add_texture(TEST_WIDTH, TEST_HEIGHT, linear, SrgbDecode::SkipDecode)?;

                self.add_shader_program(shader_parameters);
                self.set_sampling_locations(SAMPLING_X_POS, SAMPLING_Y_POS);

                self.sampling_group = SamplingGroup::Texture;
            }
            Kind::TextureDecodeEnabled => {
                // TEST STEPS:
                //    - create and set texture to DECODE_EXT
                //    - store texture on GPU
                //    - in fragment shader, sample the texture using texture*() and render texel values to a color attachment in the FBO
                //    - on the host, read back the pixel values into a tcu::TextureLevel
                //    - analyse the texel values, expecting them in lRGB format i.e. linear space decoding was enabled
                let shader_parameters = FragmentShaderParameters::new(1, 1, None, false, false);

                self.add_texture(TEST_WIDTH, TEST_HEIGHT, linear, SrgbDecode::Decode)?;

                self.add_shader_program(shader_parameters);

                self.set_sampling_locations(SAMPLING_X_POS, SAMPLING_Y_POS);

                self.sampling_group = SamplingGroup::Texture;
            }
            Kind::TexelFetchDecodeSkipped => {
                // TEST STEPS:
                //    - create and set texture to DECODE_SKIP_EXT
                //    - store texture on GPU
                //    - in fragment shader, sample the texture using texelFetch*() and render texel values to a color attachment in the FBO
                //    - on the host, read back the pixel values into a tcu::TextureLevel
                //    - analyse the texel values, expecting them in lRGB format i.e. linear space decoding is always enabled with texelFetch*()
                let shader_parameters = FragmentShaderParameters::new(1, 1, None, false, false);

                self.add_texture(TEST_WIDTH, TEST_HEIGHT, linear, SrgbDecode::SkipDecode)?;

                self.add_shader_program(shader_parameters);

                self.set_sampling_locations(SAMPLING_X_POS, SAMPLING_Y_POS);

                self.sampling_group = SamplingGroup::TexelFetch;
            }
            Kind::GpuConversionDecodeEnabled => {
                // TEST STEPS:
                //    - create and set texture_a to DECODE_SKIP_EXT and texture_b to default
                //    - store textures on GPU
                //    - in fragment shader, sample both textures using texture*() and manually perform sRGB to lRGB conversion on texture_b
                //    - in fragment shader, compare converted texture_b with texture_a
                //    - render green image for pass or red for fail
                let comparison_function = ComparisonFunction {
                    name: "srgbToLinearCheck",
                    parameters: 2,
                    implementation: FUNCTION_DEFINITION_SRGB_TO_LINEAR_CHECK,
                };

                let shader_parameters = FragmentShaderParameters::new(1, 2, Some(comparison_function), false, false);

                self.add_texture(TEST_WIDTH, TEST_HEIGHT, linear, SrgbDecode::SkipDecode)?;

                self.add_texture(TEST_WIDTH, TEST_HEIGHT, linear, SrgbDecode::DecodeDefault)?;

                self.add_shader_program(shader_parameters);

                self.set_sampling_locations(SAMPLING_X_POS, SAMPLING_Y_POS);

                self.sampling_group = SamplingGroup::Texture;
            }
            Kind::DecodeToggled => {
                // TEST STEPS:
                //    - create and set texture_a to DECODE_SKIP_EXT and texture_b to DECODE_EXT
                //    - create and use two seperate shader programs, program_a and program_b, each using different fragment shaders
                //    - store texture_a and texture_b on GPU
                // FIRST PASS:
                //    - use program_a
                //    - in fragment shader, sample both textures using texture*() and manually perform sRGB to lRGB conversion on texture_a
                //    - in fragment shader, test converted texture_a value with texture_b
                //    - render green image for pass or red for fail
                //    - store result in a color attachement 0
                // TOGGLE STAGE
                //    - during rendering, toggle texture_a from DECODE_SKIP_EXT to DECODE_EXT
                // SECOND PASS:
                //    - use program_b
                //    - in fragment shader, sample both textures using texture*() and manually perform equality check. Both should be linear
                //    - blend first pass result with second pass. Anything but a green result equals fail
                let srgb_to_linear_function = ComparisonFunction {
                    name: "srgbToLinearCheck",
                    parameters: 2,
                    implementation: FUNCTION_DEFINITION_SRGB_TO_LINEAR_CHECK,
                };
                let colors_equal_function = ComparisonFunction {
                    name: "colorsEqualCheck",
                    parameters: 2,
                    implementation: FUNCTION_DEFINITION_EQUAL_CHECK,
                };

                let shader_parameters_a =
                    FragmentShaderParameters::new(1, 2, Some(srgb_to_linear_function), false, false);
                let mut shader_parameters_b =
                    FragmentShaderParameters::new(1, 2, Some(colors_equal_function), true, true);

                // need to specify which texture uniform to toggle DECODE_EXT/SKIP_DECODE_EXT
                shader_parameters_b.uniforms_to_toggle.push("uTexture0");

                self.add_texture(TEST_WIDTH, TEST_HEIGHT, linear, SrgbDecode::SkipDecode)?;

                self.add_texture(TEST_WIDTH, TEST_HEIGHT, linear, SrgbDecode::Decode)?;

                self.add_shader_program(shader_parameters_a);
                self.add_shader_program(shader_parameters_b);

                self.set_sampling_locations(SAMPLING_X_POS, SAMPLING_Y_POS);
                self.sampling_group = SamplingGroup::Texture;
            }
            Kind::DecodeMultipleTextures => {
                // TEST STEPS:
                //    - create and set texture_a to DECODE_SKIP_EXT and texture_b to DECODE_EXT
                //    - upload textures to the GPU and bind to seperate uniform variables
                //    - sample both textures using texture*()
                //    - read texel values back to the CPU
                //    - compare the texel values, both should be different from each other
                let shader_parameters = FragmentShaderParameters::new(2, 2, None, false, false);

                self.add_texture(TEST_WIDTH, TEST_HEIGHT, linear, SrgbDecode::SkipDecode)?;

                self.add_texture(TEST_WIDTH, TEST_HEIGHT, linear, SrgbDecode::Decode)?;

                self.add_shader_program(shader_parameters);

                self.set_sampling_locations(SAMPLING_X_POS, SAMPLING_Y_POS);
                self.sampling_group = SamplingGroup::Texture;
            }
            Kind::DecodeSampler => {
                // TEST STEPS:
                //    - create and set texture_a to DECODE_SKIP_EXT
                //    - upload texture to the GPU and bind to sampler
                //    - sample texture using texture*()
                //    - read texel values back to the CPU
                //    - compare the texel values, should be in sampler format (linear)
                let shader_parameters = FragmentShaderParameters::new(1, 1, None, false, false);

                self.add_texture(TEST_WIDTH, TEST_HEIGHT, linear, SrgbDecode::SkipDecode)?;

                self.add_sampler(SrgbDecode::Decode)?;

                self.add_shader_program(shader_parameters);

                self.bind_sampler_to_texture(0, glw::GL_TEXTURE0);
                self.activate_sampler(0, true);

                self.set_sampling_locations(SAMPLING_X_POS, SAMPLING_Y_POS);
                self.sampling_group = SamplingGroup::Texture;
            }
        }
        Ok(())
    }

    /// Each case's `verifyResult`.
    fn verify_result(&mut self, kind: Kind) -> Result<bool, TestError> {
        const RESULT_COLOR_IDX: usize = 0;

        self.read_result_textures()?;
        let pixel_result_list = self.store_result_pixels();

        match kind {
            Kind::TextureDecodeSkipped => {
                let pixel_converted = srgb_to_linear(pixel_result_list[RESULT_COLOR_IDX]);
                let pixel_reference = self.format_reference_color(color_reference_linear());
                let pixel_expected = self.format_reference_color(color_reference_srgb());

                Self::log_color("Expected color: ", RESULT_COLOR_IDX as i32, pixel_expected);

                // result color 0 should be sRGB. Compare with linear reference color
                if colors_close(pixel_converted, pixel_reference) {
                    log::info!("sRGB as expected");
                    Ok(true)
                } else {
                    log::info!("not sRGB as expected");
                    Ok(false)
                }
            }
            Kind::TextureDecodeEnabled => {
                let pixel_converted = linear_to_srgb(pixel_result_list[RESULT_COLOR_IDX]);
                let pixel_reference = self.format_reference_color(color_reference_srgb());
                let pixel_expected = self.format_reference_color(color_reference_linear());

                Self::log_color("Expected color: ", RESULT_COLOR_IDX as i32, pixel_expected);

                // result color 0 should be SRGB. Compare with sRGB reference color
                if colors_close(pixel_converted, pixel_reference) {
                    log::info!("linear as expected");
                    Ok(true)
                } else {
                    log::info!("not linear as expected");
                    Ok(false)
                }
            }
            Kind::TexelFetchDecodeSkipped => {
                let pixel_reference = self.format_reference_color(color_reference_linear());
                let pixel_expected = pixel_reference;

                Self::log_color("Expected color: ", RESULT_COLOR_IDX as i32, pixel_expected);

                // result color 0 should be linear due to automatic conversion via texelFetch*(). Compare with linear reference color
                if colors_close(pixel_result_list[0], pixel_reference) {
                    log::info!("linear as expected");
                    Ok(true)
                } else {
                    log::info!("not linear as expected");
                    Ok(false)
                }
            }
            Kind::GpuConversionDecodeEnabled | Kind::DecodeToggled => {
                Self::log_color("Expected color: ", RESULT_COLOR_IDX as i32, color_green_pass());

                // result color returned from GPU is either green (pass) or fail (red)
                if pixel_result_list[RESULT_COLOR_IDX] == color_green_pass() {
                    log::info!("returned pass color from GPU");
                    Ok(true)
                } else {
                    log::info!("returned fail color from GPU");
                    Ok(false)
                }
            }
            Kind::DecodeMultipleTextures => {
                let pixel_expected0 = self.format_reference_color(color_reference_srgb());
                let pixel_expected1 = self.format_reference_color(color_reference_linear());

                Self::log_color("Expected color: ", RESULT_COLOR_IDX as i32, pixel_expected0);
                Self::log_color("Expected color: ", RESULT_COLOR_IDX as i32 + 1, pixel_expected1);

                //    check if the two textures have different values i.e. uTexture0 = sRGB and uTexture1 = linear
                if pixel_result_list[RESULT_COLOR_IDX] != pixel_result_list[RESULT_COLOR_IDX + 1] {
                    log::info!("texel values are different");
                    Ok(true)
                } else {
                    log::info!("texel values are equal");
                    Ok(false)
                }
            }
            Kind::DecodeSampler => {
                let pixel_converted = linear_to_srgb(pixel_result_list[RESULT_COLOR_IDX]);
                let pixel_reference = self.format_reference_color(color_reference_srgb());
                let pixel_expected = self.format_reference_color(color_reference_linear());

                Self::log_color("Expected color: ", RESULT_COLOR_IDX as i32, pixel_expected);

                //    texture was rendered using a sampler object with setting DECODE_EXT, therefore, results should be linear
                if colors_close(pixel_converted, pixel_reference) {
                    log::info!("linear as expected");
                    Ok(true)
                } else {
                    log::info!("not linear as expected");
                    Ok(false)
                }
            }
        }
    }

    /// `SRGBTestCase::iterate`
    fn iterate(&mut self, kind: Kind) -> TestOutcome {
        self.setup_test(kind)?;

        let sampling_types: &[SamplingType] = match self.sampling_group {
            SamplingGroup::Texture => &TEXTURE_SAMPLING_TYPES,
            SamplingGroup::TexelFetch => &TEXEL_FETCH_SAMPLING_TYPES,
        };

        self.init_vertex_data();
        self.init_frame_buffer()?;

        // loop through all sampling types in the required sampling group, performing individual tests for each
        for &sampling_type in sampling_types {
            self.gen_shader_programs(sampling_type)?;
            self.upload_textures()?;
            if kind == Kind::DecodeToggled {
                self.render_toggled()?;
            } else {
                self.render()?;
            }

            let result = self.verify_result(kind);

            self.delete_shader_programs();

            if !result? {
                return Ok(TestStatus::fail("Result verification failed"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `all(lessThan(abs(a - b), epsilon)) || all(equal(a, b))`
fn colors_close(a: Vec4, b: Vec4) -> bool {
    (0..4).all(|c| (a[c] - b[c]).abs() < EPSILON_ERROR_CPU) || a == b
}

/// `SRGBTestCase::init`'s extension requirements, then one of the seven case classes.
struct SrgbTestCase {
    name: &'static str,
    internal_format: GLenum,
    kind: Kind,
}

impl TestCase for SrgbTestCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        // extension requirements for test
        if self.internal_format == glw::GL_SRGB8_ALPHA8
            && !context
                .context_info
                .is_extension_supported("GL_EXT_texture_sRGB_decode")
        {
            return Err(TestError::NotSupported(
                "Test requires GL_EXT_texture_sRGB_decode extension".to_string(),
            ));
        }

        if self.internal_format == glw::GL_SRG8_EXT
            && !context.context_info.is_extension_supported("GL_EXT_texture_sRGB_RG8")
        {
            return Err(TestError::NotSupported(
                "Test requires GL_EXT_texture_sRGB_RG8 extension".to_string(),
            ));
        }

        if self.internal_format == glw::GL_SR8_EXT
            && !context.context_info.is_extension_supported("GL_EXT_texture_sRGB_R8")
        {
            return Err(TestError::NotSupported(
                "Test requires GL_EXT_texture_sRGB_R8 extension".to_string(),
            ));
        }

        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        Fixture::new(context, self.internal_format).iterate(self.kind)
    }
}

/// `SRGBDecodeTests::init` (the group is named `skip_decode`)
fn create_skip_decode_tests() -> TestCaseGroup {
    let test_group_config_list: [(&str, GLenum); 3] = [
        ("srgba8", glw::GL_SRGB8_ALPHA8),
        ("srg8", glw::GL_SRG8_EXT),
        ("sr8", glw::GL_SR8_EXT),
    ];

    let mut group = TestCaseGroup::new("skip_decode");

    // create groups for all desired internal formats, adding test cases to each
    for (name, internal_format) in test_group_config_list {
        let mut test_group = TestCaseGroup::new(name);

        let cases: [(&'static str, Kind); 7] = [
            ("skipped", Kind::TextureDecodeSkipped),
            ("enabled", Kind::TextureDecodeEnabled),
            ("texel_fetch", Kind::TexelFetchDecodeSkipped),
            ("conversion_gpu", Kind::GpuConversionDecodeEnabled),
            ("toggled", Kind::DecodeToggled),
            ("multiple_textures", Kind::DecodeMultipleTextures),
            ("using_sampler", Kind::DecodeSampler),
        ];
        for (case_name, kind) in cases {
            test_group.add_child(Box::new(SrgbTestCase {
                name: case_name,
                internal_format,
                kind,
            }) as Box<dyn TestCase>);
        }

        group.add_child(test_group);
    }

    group
}

/// `SRGBTextureDecodeTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("srgb_texture_decode");
    group.add_child(create_skip_decode_tests());
    group
}
