// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl3cTextureFilterMinmaxTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The six `SupportedTextureType` subclasses are one struct with a `Kind`; upstream's `glu::Texture1D`/`1DArray`/`2D`/... plus `tcu::fillWithGrid` are replaced by the grid bytes they would upload, written straight into `glTexImage*` (no glu texture class exists for 1D and the arrays).

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, VertexArrayBinding, va};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const TEXTURE_FILTER_MINMAX_SIZE: i32 = 32;
const TEXTURE_FILTER_MINMAX_DOWNSCALE_FACTOR: f32 = 0.57;
const TEXTURE_FILTER_MINMAX_UPSCALE_FACTOR: f32 = 1.63;

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

/// `TextureFilterMinmaxUtils::TextureTestFlag`
const MINMAX: i32 = 1 << 0;
const EXCLUDE_3D: i32 = 1 << 2;
const EXCLUDE_CUBE: i32 = 1 << 3;

/// `TextureFilterMinmaxUtils::SupportedTextureDataType`
struct SupportedTextureDataType {
    format: GLenum,
    type_: GLenum,
    test_flags: i32,
}

impl SupportedTextureDataType {
    fn has_flag(&self, flag: i32) -> bool {
        (self.test_flags & flag) != 0
    }
}

/// `TextureFilterMinmaxUtils::ReductionModeParam`
struct ReductionModeParam {
    reduction_mode: GLint,
    query_test_only: bool,
}

#[derive(Clone, Copy, PartialEq)]
enum Kind {
    Texture1D,
    Texture1DArray,
    Texture2D,
    Texture2DArray,
    Texture3D,
    TextureCube,
}

/// `TextureFilterMinmaxUtils::SupportedTextureType` and its subclasses.
struct SupportedTextureType {
    kind: Kind,
    type_: GLenum,
    vertex_shader: String,
    fragment_shader: String,
    texture: GLuint,
}

/// Bytes `tcu::fillWithGrid(level, 4, colorA, colorB)` leaves in a level of `(width, height, depth)` texels, for a single-channel (R or D) `type_`. `inverted` swaps the two colours (the second level of the array textures).
fn grid_level(width: i32, height: i32, depth: i32, type_: GLenum, inverted: bool) -> Vec<u8> {
    const CELL_SIZE: i32 = 4;
    let mut data = Vec::new();
    for z in 0..depth {
        for y in 0..height {
            for x in 0..width {
                let mx = (x / CELL_SIZE) % 2;
                let my = (y / CELL_SIZE) % 2;
                let mz = (z / CELL_SIZE) % 2;
                let is_color_b = if height == 1 && depth == 1 {
                    mx != 0
                } else if depth == 1 {
                    (mx ^ my) != 0
                } else {
                    (mx ^ my ^ mz) != 0
                };
                let is_white = is_color_b == inverted;
                if type_ == glw::GL_FLOAT {
                    let value: f32 = if is_white { 1.0 } else { 0.0 };
                    data.extend_from_slice(&value.to_ne_bytes());
                } else {
                    data.push(if is_white { 255 } else { 0 });
                }
            }
        }
    }
    data
}

/// `computePixelStore` of `glu::Texture*::upload` for a one-channel format.
fn unpack_alignment(type_: GLenum) -> GLint {
    if type_ == glw::GL_FLOAT { 4 } else { 1 }
}

impl SupportedTextureType {
    fn new(kind: Kind, type_: GLenum, shader_texcoord_type: &str, shader_sampler_type: &str) -> Self {
        let vertex_shader = "#version 330 core\n\
            in highp vec2 position;\n\
            in <texcoord_type> inTexcoord;\n\
            out <texcoord_type> texcoord;\n\
            void main()\n\
            {\n\
            \x20   texcoord = inTexcoord;\n\
            \x20   gl_Position = vec4(position, 0.0, 1.0);\n\
            }\n"
        .replace("<texcoord_type>", shader_texcoord_type);

        let fragment_shader = "#version 330 core\n\
            uniform <sampler_type> sampler;\n\
            in <texcoord_type> texcoord;\n\
            out vec4 color;\n\
            void main()\n\
            {\n\
            \x20   color = texture(sampler, texcoord);\n\
            }\n"
        .replace("<texcoord_type>", shader_texcoord_type)
        .replace("<sampler_type>", shader_sampler_type);

        Self {
            kind,
            type_,
            vertex_shader,
            fragment_shader,
            texture: 0,
        }
    }

    fn get_tex_coords(&self) -> Vec<f32> {
        match self.kind {
            Kind::Texture1D => vec![0.0, 0.0, 1.0, 1.0],
            Kind::Texture1DArray => vec![0.0, 0.5, 0.0, 0.5, 1.0, 0.5, 1.0, 0.5],
            Kind::Texture2D => vec![0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0],
            Kind::Texture2DArray | Kind::Texture3D => vec![0.0, 0.0, 0.5, 0.0, 1.0, 0.5, 1.0, 0.0, 0.5, 1.0, 1.0, 0.5],
            Kind::TextureCube => vec![1.0, 1.0, 0.0, -1.0, 1.0, 0.0, -1.0, -1.0, 0.0, 1.0, -1.0, 0.0],
        }
    }

    fn release(&mut self, gl: &glw::Functions) {
        if self.texture != 0 {
            // SAFETY: the texture generated by `generate`, deleted once.
            unsafe { gl.delete_textures(1, &self.texture) };
            self.texture = 0;
        }
    }

    /// `SupportedTextureType::generate` of the subclass for `self.kind`.
    fn generate(
        &mut self,
        gl: &glw::Functions,
        size: [i32; 3],
        format: GLenum,
        type_: GLenum,
        generate_mipmaps: bool,
    ) -> Result<(), TestError> {
        self.release(gl);
        // SAFETY: the name is written into a live field.
        unsafe { gl.gen_textures(1, &mut self.texture) };
        let target = self.type_;
        let level0 = |width, height, depth| grid_level(width, height, depth, type_, false);
        let level1 = |width, height, depth| grid_level(width, height, depth, type_, true);

        // SAFETY: `pixel_storei`/`bind_texture` need a current context only; every upload below passes a buffer sized for exactly the texels it declares, with the alignment set to the texel size.
        unsafe {
            gl.bind_texture(target, self.texture);
            gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, unpack_alignment(type_));
        }
        match self.kind {
            Kind::Texture1D => {
                let data = level0(size[0], 1, 1);
                // SAFETY: see above.
                unsafe {
                    gl.tex_image_1d(
                        target,
                        0,
                        format as GLint,
                        size[0],
                        0,
                        format,
                        type_,
                        data.as_ptr().cast(),
                    )
                };
            }
            Kind::Texture1DArray => {
                let data0 = level0(size[0], 2, 1);
                let data1 = level1(size[0] / 2, 2, 1);
                // SAFETY: see above.
                unsafe {
                    gl.tex_image_2d(
                        target,
                        0,
                        format as GLint,
                        size[0],
                        2,
                        0,
                        format,
                        type_,
                        data0.as_ptr().cast(),
                    );
                    gl.tex_image_2d(
                        target,
                        1,
                        format as GLint,
                        size[0] / 2,
                        2,
                        0,
                        format,
                        type_,
                        data1.as_ptr().cast(),
                    );
                }
            }
            Kind::Texture2D => {
                let data = level0(size[0], size[1], 1);
                // SAFETY: see above.
                unsafe {
                    gl.tex_image_2d(
                        target,
                        0,
                        format as GLint,
                        size[0],
                        size[1],
                        0,
                        format,
                        type_,
                        data.as_ptr().cast(),
                    )
                };
            }
            Kind::Texture2DArray => {
                let data0 = level0(size[0], size[1], 2);
                let data1 = level1(size[0] / 2, size[1] / 2, 2);
                // SAFETY: see above.
                unsafe {
                    gl.tex_image_3d(
                        target,
                        0,
                        format as GLint,
                        size[0],
                        size[1],
                        2,
                        0,
                        format,
                        type_,
                        data0.as_ptr().cast(),
                    );
                    gl.tex_image_3d(
                        target,
                        1,
                        format as GLint,
                        size[0] / 2,
                        size[1] / 2,
                        2,
                        0,
                        format,
                        type_,
                        data1.as_ptr().cast(),
                    );
                }
            }
            Kind::Texture3D => {
                let data = level0(size[0], size[1], size[2]);
                // SAFETY: see above.
                unsafe {
                    gl.tex_image_3d(
                        target,
                        0,
                        format as GLint,
                        size[0],
                        size[1],
                        size[2],
                        0,
                        format,
                        type_,
                        data.as_ptr().cast(),
                    )
                };
            }
            Kind::TextureCube => {
                let data = level0(size[0], size[0], 1);
                for face in 0..6 {
                    // SAFETY: see above.
                    unsafe {
                        gl.tex_image_2d(
                            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X + face,
                            0,
                            format as GLint,
                            size[0],
                            size[0],
                            0,
                            format,
                            type_,
                            data.as_ptr().cast(),
                        )
                    };
                }
            }
        }
        glu::expect_no_error(gl, "glu::Texture error occurred")?;

        if generate_mipmaps && matches!(self.kind, Kind::Texture1D | Kind::Texture2D) {
            // SAFETY: the texture created above.
            unsafe { gl.generate_texture_mipmap(self.texture) };
        }

        // SAFETY: needs a current context only.
        unsafe { gl.active_texture(glw::GL_TEXTURE0) };
        Ok(())
    }

    /// `SupportedTextureType::renderToFBO`
    fn render_to_fbo(
        &self,
        context: &Context,
        result_texture_id: GLuint,
        size: [i32; 2],
        reduction_mode: GLint,
    ) -> Result<(), TestError> {
        let gl = context.gl();

        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_2D, result_texture_id)
        );
        gl_call!(
            gl,
            "glTexStorage2D() call failed.",
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, size[0], size[1])
        );

        let mut fbo: GLuint = 0;
        gl_call!(gl, "genFramebuffers error occurred", gl.gen_framebuffers(1, &mut fbo));
        gl_call!(
            gl,
            "bindFramebuffer error occurred",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo)
        );
        gl_call!(
            gl,
            "framebufferTexture2D error occurred",
            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                result_texture_id,
                0
            )
        );

        // SAFETY: needs a current context only.
        if unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::Fail("Incomplete framebuffer".to_string()));
        }

        // SAFETY: needs a current context only.
        unsafe { gl.viewport(0, 0, size[0], size[1]) };
        self.render_quad(context, reduction_mode)?;

        // SAFETY: the framebuffer generated above.
        unsafe { gl.delete_framebuffers(1, &fbo) };
        Ok(())
    }

    /// `SupportedTextureType::renderQuad`
    fn render_quad(&self, context: &Context, reduction_mode: GLint) -> Result<(), TestError> {
        let gl = context.gl();

        let quad_indices: [u16; 6] = [0, 1, 2, 2, 1, 3];
        let position: [f32; 8] = [-1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0];
        let tex_coords = self.get_tex_coords();

        let vertex_arrays: [VertexArrayBinding<'_>; 2] = [
            va::float("position", 2, 4, 0, &position),
            va::float("inTexcoord", 1, 4, 0, &tex_coords),
        ];

        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(self.type_, self.texture)
        );

        // SAFETY: needs a current context only.
        unsafe {
            gl.tex_parameteri(self.type_, glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR as GLint);
            gl.tex_parameteri(self.type_, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as GLint);
            gl.tex_parameteri(self.type_, glw::GL_TEXTURE_REDUCTION_MODE_ARB, reduction_mode);
        }

        let program = ShaderProgram::new(
            gl,
            &ProgramSources::vtx_frag(self.vertex_shader.clone(), self.fragment_shader.clone()),
        );
        if !program.is_ok() {
            return Err(TestError::Fail("Shader compilation failed".to_string()));
        }

        gl_call!(gl, "glUseProgram failed", gl.use_program(program.program()));

        // SAFETY: the program is linked and current.
        let location = unsafe { gl.get_uniform_location(program.program(), c"sampler".as_ptr()) };
        gl_call!(gl, "glUniform1i failed", gl.uniform_1i(location, 0));

        // SAFETY: needs a current context only.
        unsafe { gl.clear(glw::GL_COLOR_BUFFER_BIT) };

        glu::draw(
            &context.render_context,
            program.program(),
            &vertex_arrays,
            &glu::pr::triangle_strip(&quad_indices),
        )
    }
}

/// `TextureFilterMinmaxUtils`
struct TextureFilterMinmaxUtils {
    reduction_mode_params: Vec<ReductionModeParam>,
    supported_texture_data_types: Vec<SupportedTextureDataType>,
    supported_texture_types: Vec<SupportedTextureType>,
}

impl TextureFilterMinmaxUtils {
    fn new() -> Self {
        Self {
            reduction_mode_params: vec![
                ReductionModeParam {
                    reduction_mode: glw::GL_MIN as GLint,
                    query_test_only: false,
                },
                ReductionModeParam {
                    reduction_mode: glw::GL_WEIGHTED_AVERAGE_ARB as GLint,
                    query_test_only: false,
                },
                ReductionModeParam {
                    reduction_mode: glw::GL_MAX as GLint,
                    query_test_only: false,
                },
            ],
            supported_texture_data_types: vec![
                SupportedTextureDataType {
                    format: glw::GL_RED,
                    type_: glw::GL_FLOAT,
                    test_flags: MINMAX,
                },
                SupportedTextureDataType {
                    format: glw::GL_RED,
                    type_: glw::GL_UNSIGNED_BYTE,
                    test_flags: MINMAX,
                },
                SupportedTextureDataType {
                    format: glw::GL_DEPTH_COMPONENT,
                    type_: glw::GL_FLOAT,
                    test_flags: MINMAX | EXCLUDE_3D | EXCLUDE_CUBE,
                },
                SupportedTextureDataType {
                    format: glw::GL_DEPTH_COMPONENT,
                    type_: glw::GL_UNSIGNED_BYTE,
                    test_flags: MINMAX | EXCLUDE_3D | EXCLUDE_CUBE,
                },
            ],
            supported_texture_types: vec![
                SupportedTextureType::new(Kind::Texture1D, glw::GL_TEXTURE_1D, "float", "sampler1D"),
                SupportedTextureType::new(Kind::Texture1DArray, glw::GL_TEXTURE_1D_ARRAY, "vec2", "sampler1DArray"),
                SupportedTextureType::new(Kind::Texture2D, glw::GL_TEXTURE_2D, "vec2", "sampler2D"),
                SupportedTextureType::new(Kind::Texture2DArray, glw::GL_TEXTURE_2D_ARRAY, "vec3", "sampler2DArray"),
                SupportedTextureType::new(Kind::Texture3D, glw::GL_TEXTURE_3D, "vec3", "sampler3D"),
                SupportedTextureType::new(Kind::TextureCube, glw::GL_TEXTURE_CUBE_MAP, "vec3", "samplerCube"),
            ],
        }
    }

    fn release(&mut self, gl: &glw::Functions) {
        for texture_type in &mut self.supported_texture_types {
            texture_type.release(gl);
        }
    }

    /// `TextureFilterMinmaxUtils::getDataFromTexture`
    fn get_data_from_texture(
        gl: &glw::Functions,
        texture_id: GLuint,
        texture_size: [i32; 2],
        format: GLenum,
        type_: GLenum,
    ) -> Result<Vec<u32>, TestError> {
        let image_length = (texture_size[0] * texture_size[1]) as usize;
        let mut data: Vec<u32> = vec![0; image_length];

        gl_call!(
            gl,
            "bindTexture error occurred",
            gl.bind_texture(glw::GL_TEXTURE_2D, texture_id)
        );
        gl_call!(
            gl,
            "getTexImage error occurred",
            gl.get_tex_image(glw::GL_TEXTURE_2D, 0, format, type_, data.as_mut_ptr().cast())
        );

        Ok(data)
    }

    /// `TextureFilterMinmaxUtils::calcPixelSumValue`
    fn calc_pixel_sum_value(
        gl: &glw::Functions,
        texture_id: GLuint,
        texture_size: [i32; 2],
        format: GLenum,
        type_: GLenum,
    ) -> Result<u32, TestError> {
        let texture_data = Self::get_data_from_texture(gl, texture_id, texture_size, format, type_)?;

        // `tcu::RGBA(deUint32)`: the four channels are the four bytes of the word.
        let mut sum: u32 = 0;
        for texel in texture_data {
            sum += texel & 0xFF;
            sum += (texel >> 8) & 0xFF;
            sum += (texel >> 16) & 0xFF;
            sum += (texel >> 24) & 0xFF;
        }
        Ok(sum)
    }

    /// The texture/data-type pairs the rendering and support cases walk, in upstream's loop order.
    fn pairs(&self) -> impl Iterator<Item = (usize, &SupportedTextureDataType)> {
        self.supported_texture_types
            .iter()
            .enumerate()
            .flat_map(move |(index, texture_type)| {
                self.supported_texture_data_types
                    .iter()
                    .filter(move |data_type| {
                        data_type.has_flag(MINMAX)
                            && !(data_type.has_flag(EXCLUDE_3D) && texture_type.type_ == glw::GL_TEXTURE_3D)
                            && !(data_type.has_flag(EXCLUDE_CUBE) && texture_type.type_ == glw::GL_TEXTURE_CUBE_MAP)
                    })
                    .map(move |data_type| (index, data_type))
            })
    }
}

fn check_support_minmax(context: &Context) -> Result<(), TestError> {
    if !context
        .context_info
        .is_extension_supported("GL_ARB_texture_filter_minmax")
    {
        return Err(TestError::NotSupported("Not Supported".to_string()));
    }
    Ok(())
}

/// `glu::Sampler` and `glu::Texture2D(format, type, 32, 32)` after `upload()` with no level allocated: only a texture name bound to `GL_TEXTURE_2D`.
fn create_bound_texture_2d(gl: &glw::Functions, type_: GLenum) -> Result<GLuint, TestError> {
    let mut texture: GLuint = 0;
    // SAFETY: the name is written into a live local; the rest needs a current context only.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, unpack_alignment(type_));
    }
    glu::expect_no_error(gl, "glu::Texture2D error occurred")?;
    Ok(texture)
}

/// `TextureFilterMinmaxParameterQueriesTestCase`
struct TextureFilterMinmaxParameterQueriesTestCase;

impl TextureFilterMinmaxParameterQueriesTestCase {
    fn test_reduction_mode_queries_default_values(
        gl: &glw::Functions,
        utils: &TextureFilterMinmaxUtils,
    ) -> Result<(), TestError> {
        let mut sampler: GLuint = 0;
        gl_call!(gl, "glu::Sampler error occurred", gl.gen_samplers(1, &mut sampler));
        let result = Self::default_values_body(gl, utils, sampler);
        // SAFETY: the sampler generated above.
        unsafe { gl.delete_samplers(1, &sampler) };
        result
    }

    fn default_values_body(
        gl: &glw::Functions,
        utils: &TextureFilterMinmaxUtils,
        sampler: GLuint,
    ) -> Result<(), TestError> {
        let weighted_average = glw::GL_WEIGHTED_AVERAGE_ARB as GLint;
        let mut params: GLint = 0;

        gl_call!(
            gl,
            "getSamplerParameteriv error occurred",
            gl.get_sampler_parameteriv(sampler, glw::GL_TEXTURE_REDUCTION_MODE_ARB, &mut params)
        );
        if params != weighted_average {
            return Err(TestError::Fail(
                "getSamplerParameteriv value mismatch with expected default".to_string(),
            ));
        }

        for texture_type in &utils.supported_texture_types {
            gl_call!(
                gl,
                "getTexParameteriv error occurred",
                gl.get_tex_parameteriv(texture_type.type_, glw::GL_TEXTURE_REDUCTION_MODE_ARB, &mut params)
            );
            if params != weighted_average {
                return Err(TestError::Fail(
                    "getTexParameteriv value mismatch with expected default".to_string(),
                ));
            }

            gl_call!(
                gl,
                "getTexParameterIiv error occurred",
                gl.get_tex_parameter_iiv(texture_type.type_, glw::GL_TEXTURE_REDUCTION_MODE_ARB, &mut params)
            );
            if params != weighted_average {
                return Err(TestError::Fail(
                    "getTexParameterIiv value mismatch with expected default".to_string(),
                ));
            }
        }

        for data_type in &utils.supported_texture_data_types {
            let texture = create_bound_texture_2d(gl, data_type.type_)?;
            let result = (|| -> Result<(), TestError> {
                gl_call!(
                    gl,
                    "getTextureParameteriv error occurred",
                    gl.get_texture_parameteriv(texture, glw::GL_TEXTURE_REDUCTION_MODE_ARB, &mut params)
                );
                if params != weighted_average {
                    return Err(TestError::Fail(
                        "getTextureParameteriv value mismatch with expected default".to_string(),
                    ));
                }

                gl_call!(
                    gl,
                    "getTextureParameterIiv error occurred",
                    gl.get_texture_parameter_iiv(texture, glw::GL_TEXTURE_REDUCTION_MODE_ARB, &mut params)
                );
                if params != weighted_average {
                    return Err(TestError::Fail(
                        "getTextureParameterIiv value mismatch with expected default".to_string(),
                    ));
                }
                Ok(())
            })();
            // SAFETY: the texture generated above.
            unsafe { gl.delete_textures(1, &texture) };
            result?;
        }
        Ok(())
    }

    fn test_reduction_mode_queries(
        gl: &glw::Functions,
        utils: &TextureFilterMinmaxUtils,
        pname: GLint,
    ) -> Result<(), TestError> {
        let mut sampler: GLuint = 0;
        gl_call!(gl, "glu::Sampler error occurred", gl.gen_samplers(1, &mut sampler));
        let result = Self::queries_body(gl, utils, sampler, pname);
        // SAFETY: the sampler generated above.
        unsafe { gl.delete_samplers(1, &sampler) };
        result
    }

    fn queries_body(
        gl: &glw::Functions,
        utils: &TextureFilterMinmaxUtils,
        sampler: GLuint,
        pname: GLint,
    ) -> Result<(), TestError> {
        gl_call!(
            gl,
            "samplerParameteri error occurred",
            gl.sampler_parameteri(sampler, glw::GL_TEXTURE_REDUCTION_MODE_ARB, pname)
        );

        for texture_type in &utils.supported_texture_types {
            gl_call!(
                gl,
                "texParameteriv error occurred",
                gl.tex_parameteriv(texture_type.type_, glw::GL_TEXTURE_REDUCTION_MODE_ARB, &pname)
            );
            gl_call!(
                gl,
                "texParameterIiv error occurred",
                gl.tex_parameter_iiv(texture_type.type_, glw::GL_TEXTURE_REDUCTION_MODE_ARB, &pname)
            );
        }

        for data_type in &utils.supported_texture_data_types {
            let texture = create_bound_texture_2d(gl, data_type.type_)?;
            let result = (|| -> Result<(), TestError> {
                gl_call!(
                    gl,
                    "textureParameteriv error occurred",
                    gl.texture_parameteriv(texture, glw::GL_TEXTURE_REDUCTION_MODE_ARB, &pname)
                );
                gl_call!(
                    gl,
                    "textureParameterIiv error occurred",
                    gl.texture_parameter_iiv(texture, glw::GL_TEXTURE_REDUCTION_MODE_ARB, &pname)
                );
                Ok(())
            })();
            // SAFETY: the texture generated above.
            unsafe { gl.delete_textures(1, &texture) };
            result?;
        }
        Ok(())
    }

    fn run(gl: &glw::Functions) -> Result<(), TestError> {
        let utils = TextureFilterMinmaxUtils::new();

        Self::test_reduction_mode_queries_default_values(gl, &utils)?;

        for param in &utils.reduction_mode_params {
            Self::test_reduction_mode_queries(gl, &utils, param.reduction_mode)?;
        }
        Ok(())
    }
}

impl TestCase for TextureFilterMinmaxParameterQueriesTestCase {
    fn name(&self) -> &str {
        "TextureFilterMinmaxParameterQueries"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_support_minmax(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        Self::run(context.gl())?;
        Ok(TestStatus::pass("Pass"))
    }
}

/// `TextureFilterMinmaxFilteringTestCaseBase` and its three subclasses.
struct TextureFilterMinmaxFilteringTestCase {
    name: &'static str,
    render_scale: f32,
    mipmapping: bool,
}

impl TextureFilterMinmaxFilteringTestCase {
    fn run(&self, context: &Context, utils: &mut TextureFilterMinmaxUtils) -> Result<(), TestError> {
        let gl = context.gl();

        let pairs: Vec<(usize, GLenum, GLenum)> = utils
            .pairs()
            .map(|(index, data_type)| (index, data_type.format, data_type.type_))
            .collect();
        let reduction_modes: Vec<GLint> = utils
            .reduction_mode_params
            .iter()
            .filter(|param| !param.query_test_only)
            .map(|param| param.reduction_mode)
            .collect();

        for (texture_type_index, format, type_) in pairs {
            let mut reduction_mode_texel_sums: Vec<(GLint, u32)> = Vec::new();

            for &reduction_mode in &reduction_modes {
                let scaled = (TEXTURE_FILTER_MINMAX_SIZE as f32 * self.render_scale) as i32;
                let scaled_texture_size = [scaled, scaled];

                let texture_type = &mut utils.supported_texture_types[texture_type_index];
                texture_type.generate(gl, [TEXTURE_FILTER_MINMAX_SIZE; 3], format, type_, self.mipmapping)?;

                let mut result_texture_id: GLuint = 0;
                gl_call!(
                    gl,
                    "glGenTextures() call failed.",
                    gl.gen_textures(1, &mut result_texture_id)
                );

                let result = texture_type
                    .render_to_fbo(context, result_texture_id, scaled_texture_size, reduction_mode)
                    .and_then(|()| {
                        TextureFilterMinmaxUtils::calc_pixel_sum_value(
                            gl,
                            result_texture_id,
                            scaled_texture_size,
                            glw::GL_RED,
                            glw::GL_UNSIGNED_BYTE,
                        )
                    });
                // SAFETY: the texture generated above.
                unsafe { gl.delete_textures(1, &result_texture_id) };
                reduction_mode_texel_sums.push((reduction_mode, result?));
            }

            let sum_of = |mode: GLenum| {
                reduction_mode_texel_sums
                    .iter()
                    .find(|(m, _)| *m == mode as GLint)
                    .map_or(0, |(_, sum)| *sum)
            };

            if sum_of(glw::GL_MIN) >= sum_of(glw::GL_WEIGHTED_AVERAGE_ARB) {
                return Err(TestError::Fail(
                    "Sum of texels for GL_MIN should be smaller than for GL_WEIGHTED_AVERAGE_ARB".to_string(),
                ));
            }

            if sum_of(glw::GL_MAX) <= sum_of(glw::GL_WEIGHTED_AVERAGE_ARB) {
                return Err(TestError::Fail(
                    "Sum of texels for GL_MAX should be greater than for GL_WEIGHTED_AVERAGE_ARB".to_string(),
                ));
            }
        }
        Ok(())
    }
}

impl TestCase for TextureFilterMinmaxFilteringTestCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_support_minmax(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut utils = TextureFilterMinmaxUtils::new();
        let result = self.run(context, &mut utils);
        utils.release(context.gl());
        result?;
        Ok(TestStatus::pass("Pass"))
    }
}

/// `TextureFilterMinmaxSupportTestCase`
struct TextureFilterMinmaxSupportTestCase;

impl TestCase for TextureFilterMinmaxSupportTestCase {
    fn name(&self) -> &str {
        "TextureFilterMinmaxSupport"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_support_minmax(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let utils = TextureFilterMinmaxUtils::new();

        for (texture_type_index, data_type) in utils.pairs() {
            let mut params: GLint = 0;
            gl_call!(
                gl,
                "getInternalformativ() call failed.",
                gl.get_internalformativ(
                    utils.supported_texture_types[texture_type_index].type_,
                    data_type.format,
                    glw::GL_TEXTURE_REDUCTION_MODE_ARB,
                    size_of::<GLint>() as i32,
                    &mut params
                )
            );
            if params == 0 {
                return Err(TestError::Fail("GetInternalformativ incorrect value".to_string()));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `TextureFilterMinmax::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture_filter_minmax_tests");
    group.add_child(Box::new(TextureFilterMinmaxParameterQueriesTestCase) as Box<dyn TestCase>);
    group.add_child(Box::new(TextureFilterMinmaxFilteringTestCase {
        name: "TextureFilterMinmaxMinificationFiltering",
        render_scale: TEXTURE_FILTER_MINMAX_DOWNSCALE_FACTOR,
        mipmapping: false,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(TextureFilterMinmaxFilteringTestCase {
        name: "TextureFilterMinmaxMagnificationFiltering",
        render_scale: TEXTURE_FILTER_MINMAX_UPSCALE_FACTOR,
        mipmapping: false,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(TextureFilterMinmaxFilteringTestCase {
        name: "TextureFilterMinmaxMipmapMinificationFiltering",
        render_scale: TEXTURE_FILTER_MINMAX_DOWNSCALE_FACTOR,
        mipmapping: true,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(TextureFilterMinmaxSupportTestCase) as Box<dyn TestCase>);
    group
}
