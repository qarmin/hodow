// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_border_clamp/esextcTextureBorderClampSamplingTexture.cpp
//   external/openglcts/modules/glesext/texture_border_clamp/esextcTextureBorderClampSamplingTexture.hpp
//   external/openglcts/modules/glesext/texture_border_clamp/esextcTextureBorderClampTests.cpp (the configurations)
//   external/openglcts/modules/glesext/texture_border_clamp/esextcTextureBorderClampCompressedResources.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The C++ template over (InputType, OutputType) becomes byte buffers: the input texture is always filled with zero, so only its size depends on the type, and results are read as bytes and widened to i64 per `out_type`.

use super::TEXTURE_BORDER_CLAMP_NOT_SUPPORTED;
use crate::generated::khr_border_clamp_compressed::{COMPRESSED_IMAGE_DATA_2D, COMPRESSED_IMAGE_DATA_2D_ARRAY};
use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLsizeiptr, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const TEXTURE_FLOAT_LINEAR_NOT_SUPPORTED: &str =
    "Floating point texture linear filtering functionality not supported, skipping";

/// `m_texture_unit`
const TEXTURE_UNIT: GLuint = 0;

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

/// `TestConfiguration`; the init value is zero and the expected value is zero in every upstream configuration, the expected border colour is 255.
#[derive(Clone, Copy)]
struct TestConfiguration {
    n_in_components: usize,
    n_out_components: usize,
    target: GLenum,
    input_internal_format: GLenum,
    output_internal_format: GLenum,
    filtering: GLenum,
    input_format: GLenum,
    output_format: GLenum,
    width: i32,
    height: i32,
    depth: i32,
    init_border_color: f32,
    input_type: GLenum,
    output_type: GLenum,
}

const EXPECTED_VALUE: i64 = 0;
const EXPECTED_BORDER_COLOR: i64 = 255;

impl TestConfiguration {
    fn input_type_size(&self) -> usize {
        match self.input_type {
            glw::GL_UNSIGNED_BYTE => 1,
            glw::GL_UNSIGNED_SHORT => 2,
            _ => 4,
        }
    }

    fn output_type_size(&self) -> usize {
        match self.output_type {
            glw::GL_UNSIGNED_BYTE => 1,
            _ => 4,
        }
    }

    /// `getStartingLayerIndex`
    fn starting_layer_index(&self) -> i32 {
        if self.target == glw::GL_TEXTURE_3D { -1 } else { 0 }
    }

    /// `getLastLayerIndex`
    fn last_layer_index(&self) -> i32 {
        if self.target == glw::GL_TEXTURE_3D {
            self.depth + 1
        } else {
            self.depth
        }
    }

    /// `getCoordinateValue`
    fn coordinate_value(&self, index: i32) -> f32 {
        match self.target {
            glw::GL_TEXTURE_2D => 0.0,
            glw::GL_TEXTURE_2D_ARRAY => index as f32,
            _ => index as f32 / self.depth as f32,
        }
    }
}

/// `TextureBorderClampSamplingTexture` (Test 7)
pub(super) struct SamplingTexture {
    name: &'static str,
    ext_params: ExtParameters,
    configuration: TestConfiguration,
}

#[derive(Default)]
struct State {
    vao_id: GLuint,
    sampler_id: GLuint,
    fbo_id: GLuint,
    position_vbo_id: GLuint,
    text_coord_vbo_id: GLuint,
    po_id: GLuint,
    vs_id: GLuint,
    fs_id: GLuint,
    input_to_id: GLuint,
    output_to_id: GLuint,
    attr_position_location: GLint,
    attr_texcoord_location: GLint,
}

impl State {
    fn new() -> Self {
        Self {
            attr_position_location: -1,
            attr_texcoord_location: -1,
            ..Default::default()
        }
    }
}

impl SamplingTexture {
    /// `getFragmentShaderCode`
    fn fragment_shader_code(&self) -> Result<String, TestError> {
        let c = &self.configuration;
        let sampler_prefix = match c.input_internal_format {
            glw::GL_RGBA32F
            | glw::GL_RGBA8
            | glw::GL_DEPTH_COMPONENT32F
            | glw::GL_DEPTH_COMPONENT16
            | glw::GL_COMPRESSED_RGBA8_ETC2_EAC => "",
            glw::GL_R32UI => "u",
            glw::GL_R32I => "i",
            _ => return Err(TestError::Fail("Not allowed internal format".to_string())),
        };

        let (coord_type, sampler_suffix) = match c.target {
            glw::GL_TEXTURE_2D => ("vec2", "sampler2D"),
            glw::GL_TEXTURE_2D_ARRAY => ("vec3", "sampler2DArray"),
            glw::GL_TEXTURE_3D => ("vec3", "sampler3D"),
            _ => return Err(TestError::Fail("Not allowed texture target!".to_string())),
        };
        let sampler_type = format!("{sampler_prefix}{sampler_suffix}");

        let (out_type, out_command) = match c.output_internal_format {
            glw::GL_RGBA8 => ("vec4", "texture(test_sampler, texture_coords_out)"),
            glw::GL_R8 => ("float", "texture(test_sampler, texture_coords_out).x"),
            glw::GL_R32UI => ("uint", "uint(texture(test_sampler, texture_coords_out).x)"),
            glw::GL_R32I => ("int", "int(texture(test_sampler, texture_coords_out).x)"),
            _ => return Err(TestError::Fail("Not allowed internal format!".to_string())),
        };

        Ok(format!(
            "${{VERSION}}\n\nprecision highp float;\nprecision highp {sampler_type};\n\nuniform {sampler_type} test_sampler;\nin  {coord_type} texture_coords_out;\nlayout(location = 0) out {out_type} color;\n\nvoid main()\n{{\n   color = {out_command};\n}}\n"
        ))
    }

    /// `getVertexShaderCode`
    fn vertex_shader_code(&self) -> Result<String, TestError> {
        let (coord_type, coord_assignment) = match self.configuration.target {
            glw::GL_TEXTURE_2D => ("vec2", "texture_coords_in"),
            glw::GL_TEXTURE_2D_ARRAY | glw::GL_TEXTURE_3D => ("vec3", "vec3(texture_coords_in, layer)"),
            _ => return Err(TestError::Fail("Not allowed texture target!".to_string())),
        };

        Ok(format!(
            "${{VERSION}}\n\nprecision highp float;\n\nlayout (location = 0) in vec4 vertex_position_in;\nlayout (location = 1) in vec2 texture_coords_in;\nout {coord_type} texture_coords_out;\nuniform float layer;\n\nvoid main()\n{{\n    gl_Position = vertex_position_in;\n    texture_coords_out = {coord_assignment};\n}}\n"
        ))
    }

    /// `createTextures`
    fn create_textures(&self, gl: &glw::Functions, s: &mut State) -> Result<(), TestError> {
        let c = &self.configuration;

        gl_call!(
            gl,
            "Error generating texture object!",
            gl.gen_textures(1, &mut s.input_to_id)
        );
        gl_call!(
            gl,
            "Error binding texture object!",
            gl.bind_texture(c.target, s.input_to_id)
        );

        let texels_number = (c.width * c.height * c.depth) as usize;
        // `setInitData` fills every texel with zero.
        let input_data = vec![0u8; c.n_in_components * texels_number * c.input_type_size()];
        let compressed = c.input_internal_format == glw::GL_COMPRESSED_RGBA8_ETC2_EAC;

        match c.target {
            glw::GL_TEXTURE_2D => {
                gl_call!(gl, "Error allocating storage for texture object!", gl.tex_storage_2d(c.target, 1, c.input_internal_format, c.width, c.height));

                if compressed {
                    gl_call!(
                        gl,
                        "Error filling texture with compressed data!",
                        gl.compressed_tex_sub_image_2d(
                            c.target,
                            0,
                            0,
                            0,
                            c.width,
                            c.height,
                            c.input_internal_format,
                            COMPRESSED_IMAGE_DATA_2D.len() as i32,
                            COMPRESSED_IMAGE_DATA_2D.as_ptr().cast()
                        )
                    );
                } else {
                    gl_call!(
                        gl,
                        "Error filling texture with data!",
                        gl.tex_sub_image_2d(c.target, 0, 0, 0, c.width, c.height, c.input_format, c.input_type, input_data.as_ptr().cast())
                    );
                }
            }
            glw::GL_TEXTURE_2D_ARRAY | glw::GL_TEXTURE_3D => {
                gl_call!(gl, "Error allocating storage for texture object!", gl.tex_storage_3d(c.target, 1, c.input_internal_format, c.width, c.height, c.depth));

                if compressed {
                    gl_call!(
                        gl,
                        "Error filling texture with compressed data!",
                        gl.compressed_tex_sub_image_3d(
                            c.target,
                            0,
                            0,
                            0,
                            0,
                            c.width,
                            c.height,
                            c.depth,
                            c.input_internal_format,
                            COMPRESSED_IMAGE_DATA_2D_ARRAY.len() as i32,
                            COMPRESSED_IMAGE_DATA_2D_ARRAY.as_ptr().cast()
                        )
                    );
                } else {
                    gl_call!(
                        gl,
                        "Error filling texture with data!",
                        gl.tex_sub_image_3d(c.target, 0, 0, 0, 0, c.width, c.height, c.depth, c.input_format, c.input_type, input_data.as_ptr().cast())
                    );
                }
            }
            _ => return Err(TestError::Fail("Test parameters can contain only following targets: GL_TEXTURE_2D, GL_TEXTURE_2D_ARRAY, GL_TEXTURE_3D!".to_string())),
        }

        gl_call!(
            gl,
            "Error generating texture object!",
            gl.gen_textures(1, &mut s.output_to_id)
        );
        gl_call!(
            gl,
            "Error binding texture object!",
            gl.bind_texture(glw::GL_TEXTURE_2D, s.output_to_id)
        );
        gl_call!(
            gl,
            "Error allocating storage for texture object!",
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, c.output_internal_format, c.width, c.height)
        );
        Ok(())
    }

    /// `initTest`
    fn init_test(&self, context: &Context, base: &TestCaseBase, s: &mut State) -> Result<(), TestError> {
        let c = &self.configuration;
        if !base.is_texture_border_clamp_supported {
            return Err(TestError::NotSupported(TEXTURE_BORDER_CLAMP_NOT_SUPPORTED.to_string()));
        }
        if !base.is_texture_float_linear_supported
            && c.filtering == glw::GL_LINEAR
            && (c.input_internal_format == glw::GL_RGBA32F || c.input_internal_format == glw::GL_DEPTH_COMPONENT32F)
        {
            return Err(TestError::NotSupported(TEXTURE_FLOAT_LINEAR_NOT_SUPPORTED.to_string()));
        }

        let gl = context.gl();

        gl_call!(
            gl,
            "Could not generate vertex array object",
            gl.gen_vertex_arrays(1, &mut s.vao_id)
        );
        gl_call!(gl, "Error binding vertex array object!", gl.bind_vertex_array(s.vao_id));
        gl_call!(
            gl,
            "Error generating sampler object!",
            gl.gen_samplers(1, &mut s.sampler_id)
        );
        gl_call!(
            gl,
            "Error generating framebuffer object!",
            gl.gen_framebuffers(1, &mut s.fbo_id)
        );
        gl_call!(
            gl,
            "Error setting clear color value!",
            gl.clear_color(0.5, 0.5, 0.5, 1.0)
        );

        let vertices: [f32; 16] = [
            -1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
        ];
        let coords: [f32; 8] = [-1.0, -1.0, -1.0, 2.0, 2.0, -1.0, 2.0, 2.0];

        gl_call!(
            gl,
            "Error generating buffer object!",
            gl.gen_buffers(1, &mut s.position_vbo_id)
        );
        gl_call!(
            gl,
            "Error binding buffer object!",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, s.position_vbo_id)
        );
        gl_call!(
            gl,
            "Error setting data for buffer object!",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&vertices) as GLsizeiptr,
                vertices.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );

        gl_call!(
            gl,
            "Error generating buffer object!",
            gl.gen_buffers(1, &mut s.text_coord_vbo_id)
        );
        gl_call!(
            gl,
            "Error binding buffer object!",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, s.text_coord_vbo_id)
        );
        gl_call!(
            gl,
            "Error seting data for buffer object!",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&coords) as GLsizeiptr,
                coords.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );

        // SAFETY: object creation on the current context.
        unsafe {
            s.po_id = gl.create_program();
            s.vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
            s.fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
        }

        let vs_code = self.vertex_shader_code()?;
        let fs_code = self.fragment_shader_code()?;
        let vs_parts = [vs_code.as_str()];
        let fs_parts = [fs_code.as_str()];
        if !base
            .build_program(
                context,
                s.po_id,
                &[
                    ShaderBody::Source(s.fs_id, &fs_parts),
                    ShaderBody::Source(s.vs_id, &vs_parts),
                ],
            )?
            .0
        {
            return Err(TestError::Fail(
                "Program could not have been created sucessfully from a valid vertex/fragment shader!".to_string(),
            ));
        }

        self.create_textures(gl, s)
    }

    /// `checkNearest`
    fn check_nearest(&self, buffer: &[i64], expected_value: i64, expected_border_color: i64, layer: i32) -> bool {
        let c = &self.configuration;
        let width = c.width as usize;
        let height = c.height as usize;
        let out_components = c.n_out_components;
        let compared = out_components.min(c.n_in_components);
        let out_row_width = width * out_components;

        let center_point = (width / 2, height / 2);
        for i in 0..compared {
            let index = center_point.1 * out_row_width + center_point.0 * out_components + i;
            if buffer[index] != expected_value {
                log::info!(
                    "Wrong value for layer ({layer}) at point (x,y)  = ({},{}) , component ({i})\nExpected value [{expected_value}]\nResult   value [{}]\n",
                    center_point.0,
                    center_point.1,
                    buffer[index]
                );
                return false;
            }
        }

        let border_points: [(usize, usize); 8] = [
            (width / 6, height / 6),
            (width / 2, height / 6),
            ((width as f64 / 6.0 * 5.0) as usize, height / 6),
            (width / 6, height / 2),
            ((width as f64 / 6.0 * 5.0) as usize, height / 2),
            (width / 6, (height as f64 / 6.0 * 5.0) as usize),
            (width / 2, (height as f64 / 6.0 * 5.0) as usize),
            (
                (width as f64 / 6.0 * 5.0) as usize,
                (height as f64 / 6.0 * 5.0) as usize,
            ),
        ];

        for (x, y) in border_points {
            for i in 0..compared {
                let index = y * out_row_width + x * out_components + i;
                if buffer[index] != expected_border_color {
                    log::info!(
                        "Wrong value for layer ({layer}) at point (x,y)  = ({x},{y}) , component ({i})\nExpected value [{expected_border_color}]\nResult   value [{}]\n",
                        buffer[index]
                    );
                    return false;
                }
            }
        }

        true
    }

    /// `checkLinear`; unsigned 32-bit results never compare as decreasing, as in the C++ unsigned subtraction.
    fn check_linear(&self, buffer: &[i64], layer: i32) -> bool {
        let c = &self.configuration;
        let w = c.width as usize;
        let h = c.height as usize;
        let center_x = w / 2;
        let center_y = h / 2;
        let step_x = w / 3;
        let step_y = h / 3;
        let out_components = c.n_out_components;
        let compared = out_components.min(c.n_in_components);
        let out_row_width = w * out_components;
        let decreasing = |next: i64, current: i64| c.output_type != glw::GL_UNSIGNED_INT && next - current < 0;

        if c.target != glw::GL_TEXTURE_3D {
            let texture_samples: [[usize; 2]; 4] = [
                [center_x + w / 6, center_y],
                [center_x - w / 6, center_y],
                [center_x, center_y + h / 6],
                [center_x, center_y - h / 6],
            ];
            for sample in texture_samples {
                for comp in 0..compared {
                    if buffer[sample[1] * out_row_width + sample[0] * out_components + comp] != 0 {
                        log::info!("Texture sample at (x, y) = ({},{}) not black\n", sample[0], sample[1]);
                        return false;
                    }
                }
            }
        }

        for y in center_y..center_y + step_y {
            for comp in 0..compared {
                let index = y * out_row_width + center_x * out_components + comp;
                if decreasing(buffer[index + out_row_width], buffer[index]) {
                    log::info!(
                        "For layer ({layer}) when moving from center point  (x, y)  = ({center_x},{center_y}) to the bottom\nat point (x, y)  = ({center_x},{y}) - texel values stopped to be monotonically increasing\n"
                    );
                    return false;
                }
            }
        }

        let mut y = center_y;
        while y > center_y - step_y {
            for comp in 0..compared {
                let index = y * out_row_width + center_x * out_components + comp;
                if decreasing(buffer[index - out_row_width], buffer[index]) {
                    log::info!(
                        "For layer ({layer}) when moving from center point  (x, y)  = ({center_x},{center_y}) to the top\nat point (x, y)  = ({center_x},{y})- texel values stopped to be monotonically increasing\n"
                    );
                    return false;
                }
            }
            y -= 1;
        }

        // The index arithmetic of the right and left walks (`centerY + x * out_components`) is upstream's, kept as written.
        for x in center_x..center_x + step_x {
            for comp in 0..compared {
                let index = center_y + x * out_components + comp;
                if decreasing(buffer[index + out_components], buffer[index]) {
                    log::info!(
                        "For layer ({layer}) when moving from center point  (x, y) = ({center_x},{center_y}) to the right\nat point (x, y)  = ({x},{center_y})- texel values stopped to be monotonically increasing\n"
                    );
                    return false;
                }
            }
        }

        let mut x = center_y;
        while x > center_x - step_x {
            for comp in 0..compared {
                let index = center_y + x * out_components + comp;
                if decreasing(buffer[index - out_components], buffer[index]) {
                    log::info!(
                        "For layer ({layer}) when moving from center point  (x, y) = ({center_x},{center_y}) to the left\nat point (x, y)  = ({x},{center_y})- texel values stopped to be monotonically increasing\n"
                    );
                    return false;
                }
            }
            x -= 1;
        }

        true
    }

    /// `checkResult`
    fn check_result(
        &self,
        gl: &glw::Functions,
        s: &State,
        expected_value: i64,
        expected_border_color: i64,
        layer: i32,
    ) -> Result<bool, TestError> {
        let c = &self.configuration;

        gl_call!(
            gl,
            "Error binding framebuffer object!",
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, s.fbo_id)
        );

        let count = (c.width * c.height) as usize * c.n_out_components;
        let mut raw = vec![0u8; count * c.output_type_size()];
        gl_call!(
            gl,
            "Error reading pixels from color buffer",
            gl.read_pixels(
                0,
                0,
                c.width,
                c.height,
                c.output_format,
                c.output_type,
                raw.as_mut_ptr().cast()
            )
        );

        let result_data: Vec<i64> = match c.output_type {
            glw::GL_UNSIGNED_BYTE => raw.iter().map(|&v| i64::from(v)).collect(),
            glw::GL_INT => raw
                .chunks_exact(4)
                .map(|v| i64::from(i32::from_ne_bytes([v[0], v[1], v[2], v[3]])))
                .collect(),
            _ => raw
                .chunks_exact(4)
                .map(|v| i64::from(u32::from_ne_bytes([v[0], v[1], v[2], v[3]])))
                .collect(),
        };

        Ok(if c.filtering == glw::GL_NEAREST {
            self.check_nearest(&result_data, expected_value, expected_border_color, layer)
        } else {
            self.check_linear(&result_data, layer)
        })
    }

    /// `iterate` after `initTest`
    fn run(&self, context: &Context, base: &TestCaseBase, s: &mut State) -> Result<bool, TestError> {
        self.init_test(context, base, s)?;

        let gl = context.gl();
        let c = &self.configuration;
        let tokens = &base.gl_ext_tokens;
        let mut test_result = true;

        gl_call!(gl, "Error using program!", gl.use_program(s.po_id));

        gl_call!(
            gl,
            "Could not bind buffer object!",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, s.position_vbo_id)
        );
        // SAFETY: a linked program and a NUL-terminated name.
        s.attr_position_location = unsafe { gl.get_attrib_location(s.po_id, c"vertex_position_in".as_ptr()) };
        glu::expect_no_error(gl, "Could not get attribute location!")?;
        gl_call!(
            gl,
            "Could not set vertex attribute pointer!",
            gl.vertex_attrib_pointer(
                s.attr_position_location as GLuint,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                std::ptr::null()
            )
        );
        gl_call!(
            gl,
            "Could not enable vertex attribute array!",
            gl.enable_vertex_attrib_array(s.attr_position_location as GLuint)
        );

        gl_call!(
            gl,
            "Could not bind buffer object!",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, s.text_coord_vbo_id)
        );
        // SAFETY: as above.
        s.attr_texcoord_location = unsafe { gl.get_attrib_location(s.po_id, c"texture_coords_in".as_ptr()) };
        glu::expect_no_error(gl, "Could not get attribute location!")?;
        gl_call!(
            gl,
            "Could not set vertex attribute pointer!",
            gl.vertex_attrib_pointer(
                s.attr_texcoord_location as GLuint,
                2,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                std::ptr::null()
            )
        );
        gl_call!(
            gl,
            "Could not enable vertex attribute array!",
            gl.enable_vertex_attrib_array(s.attr_texcoord_location as GLuint)
        );

        gl_call!(
            gl,
            "Error setting active texture unit!",
            gl.active_texture(glw::GL_TEXTURE0)
        );
        gl_call!(gl, "Error binding texture!", gl.bind_texture(c.target, s.input_to_id));

        // SAFETY: a linked program and a NUL-terminated name.
        let sampler_location = unsafe { gl.get_uniform_location(s.po_id, c"test_sampler".as_ptr()) };
        glu::expect_no_error(gl, "Erros getting sampler location!")?;
        gl_call!(
            gl,
            "Could not bind sampler location to texture unit!",
            gl.uniform_1i(sampler_location, TEXTURE_UNIT as GLint)
        );
        gl_call!(
            gl,
            "Could not bind sampler object to texture unit!",
            gl.bind_sampler(TEXTURE_UNIT, s.sampler_id)
        );

        match c.input_internal_format {
            glw::GL_RGBA32F
            | glw::GL_RGBA8
            | glw::GL_DEPTH_COMPONENT32F
            | glw::GL_DEPTH_COMPONENT16
            | glw::GL_COMPRESSED_RGBA8_ETC2_EAC => {
                let val = c.init_border_color;
                let border_color = [val; 4];
                // SAFETY: four floats, the size of a border colour.
                unsafe { gl.sampler_parameterfv(s.sampler_id, tokens.texture_border_color, border_color.as_ptr()) };
            }
            glw::GL_R32UI => {
                let border_color = [c.init_border_color as GLuint; 4];
                // SAFETY: four uints.
                unsafe { gl.sampler_parameter_iuiv(s.sampler_id, tokens.texture_border_color, border_color.as_ptr()) };
            }
            glw::GL_R32I => {
                let border_color = [c.init_border_color as GLint; 4];
                // SAFETY: four ints.
                unsafe { gl.sampler_parameter_iiv(s.sampler_id, tokens.texture_border_color, border_color.as_ptr()) };
            }
            _ => {
                return Err(TestError::Fail(
                    "Unsupported sized internal format. Should never happen!".to_string(),
                ));
            }
        }
        glu::expect_no_error(gl, "Error setting border color parameter!")?;

        gl_call!(
            gl,
            "Error setting GL_TEXTURE_WRAP_S parameter!",
            gl.sampler_parameteri(s.sampler_id, glw::GL_TEXTURE_WRAP_S, tokens.clamp_to_border as GLint)
        );
        gl_call!(
            gl,
            "Error setting GL_TEXTURE_WRAP_R parameter!",
            gl.sampler_parameteri(s.sampler_id, glw::GL_TEXTURE_WRAP_R, tokens.clamp_to_border as GLint)
        );
        gl_call!(
            gl,
            "Error setting GL_TEXTURE_WRAP_T parameter!",
            gl.sampler_parameteri(s.sampler_id, glw::GL_TEXTURE_WRAP_T, tokens.clamp_to_border as GLint)
        );

        gl_call!(
            gl,
            "Error setting value for GL_TEXTURE_MAG_FILTER parameter!",
            gl.sampler_parameteri(s.sampler_id, glw::GL_TEXTURE_MAG_FILTER, c.filtering as GLint)
        );
        gl_call!(
            gl,
            "Error setting value for GL_TEXTURE_MIN_FILTER parameter!",
            gl.sampler_parameteri(s.sampler_id, glw::GL_TEXTURE_MIN_FILTER, c.filtering as GLint)
        );

        for i in c.starting_layer_index()..c.last_layer_index() {
            // SAFETY: a linked program and a NUL-terminated name.
            let layer_location = unsafe { gl.get_uniform_location(s.po_id, c"layer".as_ptr()) };
            glu::expect_no_error(gl, "Error getting layer uniform location!")?;
            gl_call!(
                gl,
                "Error setting layer uniform variable!",
                gl.uniform_1f(layer_location, c.coordinate_value(i))
            );

            gl_call!(
                gl,
                "Error binding framebuffer object!",
                gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, s.fbo_id)
            );
            gl_call!(gl, "Error setting view port!", gl.viewport(0, 0, c.width, c.height));
            gl_call!(
                gl,
                "Could not attach texture object to GL_COLOR_ATTACHMENT0!",
                gl.framebuffer_texture_2d(
                    glw::GL_DRAW_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_TEXTURE_2D,
                    s.output_to_id,
                    0
                )
            );

            // SAFETY: plain status query.
            let status = unsafe { gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) };
            if status != glw::GL_FRAMEBUFFER_COMPLETE {
                let reason = match status {
                    glw::GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT => "GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT",
                    glw::GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS => "GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS",
                    glw::GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT => "GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT",
                    glw::GL_FRAMEBUFFER_UNSUPPORTED => "GL_FRAMEBUFFER_UNSUPPORTED",
                    _ => "status not recognized",
                };
                return Err(TestError::Fail(format!("Framebuffer incomplete, status: {reason}")));
            }

            gl_call!(gl, "Error clearing color buffer", gl.clear(glw::GL_COLOR_BUFFER_BIT));
            gl_call!(gl, "Rendering failed!", gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

            let expected_color = match c.target {
                glw::GL_TEXTURE_3D if !(i > -1 && i < c.depth) => EXPECTED_BORDER_COLOR,
                _ => EXPECTED_VALUE,
            };

            if !self.check_result(gl, s, expected_color, EXPECTED_BORDER_COLOR, i)? {
                test_result = false;
            }
        }

        Ok(test_result)
    }

    /// `deinit`
    fn deinit(&self, gl: &glw::Functions, s: &mut State) {
        // SAFETY: state resets and deletes of names this case created, on the current context.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
            gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, 0);
            gl.bind_texture(glw::GL_TEXTURE_3D, 0);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            gl.bind_sampler(TEXTURE_UNIT, 0);
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0);
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, 0);
            gl.bind_vertex_array(0);

            if s.attr_position_location != -1 {
                gl.disable_vertex_attrib_array(s.attr_position_location as GLuint);
                s.attr_position_location = -1;
            }
            if s.attr_texcoord_location != -1 {
                gl.disable_vertex_attrib_array(s.attr_texcoord_location as GLuint);
                s.attr_texcoord_location = -1;
            }

            gl.use_program(0);

            if s.fbo_id != 0 {
                gl.delete_framebuffers(1, &s.fbo_id);
                s.fbo_id = 0;
            }
            if s.po_id != 0 {
                gl.delete_program(s.po_id);
                s.po_id = 0;
            }
            if s.fs_id != 0 {
                gl.delete_shader(s.fs_id);
                s.fs_id = 0;
            }
            if s.vs_id != 0 {
                gl.delete_shader(s.vs_id);
                s.vs_id = 0;
            }
            if s.input_to_id != 0 {
                gl.delete_textures(1, &s.input_to_id);
                s.input_to_id = 0;
            }
            if s.output_to_id != 0 {
                gl.delete_textures(1, &s.output_to_id);
                s.output_to_id = 0;
            }
            if s.sampler_id != 0 {
                gl.delete_samplers(1, &s.sampler_id);
                s.sampler_id = 0;
            }
            if s.position_vbo_id != 0 {
                gl.delete_buffers(1, &s.position_vbo_id);
                s.position_vbo_id = 0;
            }
            if s.text_coord_vbo_id != 0 {
                gl.delete_buffers(1, &s.text_coord_vbo_id);
                s.text_coord_vbo_id = 0;
            }
            if s.vao_id != 0 {
                gl.delete_vertex_arrays(1, &s.vao_id);
                s.vao_id = 0;
            }
        }
    }
}

impl TestCase for SamplingTexture {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let mut state = State::new();

        let outcome = self.run(context, &base, &mut state);
        self.deinit(gl, &mut state);

        Ok(if outcome? {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

#[allow(clippy::too_many_arguments)]
fn configuration(
    n_in_components: usize,
    n_out_components: usize,
    target: GLenum,
    input_internal_format: GLenum,
    output_internal_format: GLenum,
    filtering: GLenum,
    input_format: GLenum,
    output_format: GLenum,
    size: i32,
    depth: i32,
    init_border_color: f32,
    input_type: GLenum,
    output_type: GLenum,
) -> TestConfiguration {
    TestConfiguration {
        n_in_components,
        n_out_components,
        target,
        input_internal_format,
        output_internal_format,
        filtering,
        input_format,
        output_format,
        width: size,
        height: size,
        depth,
        init_border_color,
        input_type,
        output_type,
    }
}

/// The sampling cases `TextureBorderClampTests::init` adds straight to its own group; the order is upstream's (nearest, then linear, each over 2D, 2D array, 3D).
pub(super) fn add_tests(group: &mut TestCaseGroup, ext_params: ExtParameters) {
    use glw::{GL_INT, GL_UNSIGNED_BYTE, GL_UNSIGNED_INT, GL_UNSIGNED_SHORT};

    let mut add = |name: &'static str, configuration: TestConfiguration| {
        group.add_child(Box::new(SamplingTexture {
            name,
            ext_params,
            configuration,
        }) as Box<dyn TestCase>);
    };

    let (t2d, t2da, t3d) = (glw::GL_TEXTURE_2D, glw::GL_TEXTURE_2D_ARRAY, glw::GL_TEXTURE_3D);
    let (nearest, linear) = (glw::GL_NEAREST, glw::GL_LINEAR);
    let etc2 = glw::GL_COMPRESSED_RGBA8_ETC2_EAC;
    let (rgba, red, red_int, rgba_int, depth_comp) = (
        glw::GL_RGBA,
        glw::GL_RED,
        glw::GL_RED_INTEGER,
        glw::GL_RGBA_INTEGER,
        glw::GL_DEPTH_COMPONENT,
    );

    // Nearest, GL_TEXTURE_2D
    add(
        "Texture2DRGBA32F",
        configuration(
            4,
            4,
            t2d,
            glw::GL_RGBA32F,
            glw::GL_RGBA8,
            nearest,
            rgba,
            rgba,
            256,
            1,
            1.0,
            glw::GL_FLOAT,
            GL_UNSIGNED_BYTE,
        ),
    );
    add(
        "Texture2DR32I",
        configuration(
            1,
            4,
            t2d,
            glw::GL_R32I,
            glw::GL_R32I,
            nearest,
            red_int,
            rgba_int,
            256,
            1,
            255.0,
            GL_INT,
            GL_INT,
        ),
    );
    add(
        "Texture2DR32UI",
        configuration(
            1,
            4,
            t2d,
            glw::GL_R32UI,
            glw::GL_R32UI,
            nearest,
            red_int,
            rgba_int,
            256,
            1,
            255.0,
            GL_UNSIGNED_INT,
            GL_UNSIGNED_INT,
        ),
    );
    add(
        "Texture2DRGBA8",
        configuration(
            4,
            4,
            t2d,
            glw::GL_RGBA8,
            glw::GL_RGBA8,
            nearest,
            rgba,
            rgba,
            256,
            1,
            255.0,
            GL_UNSIGNED_BYTE,
            GL_UNSIGNED_BYTE,
        ),
    );
    add(
        "Texture2DDC32F",
        configuration(
            1,
            1,
            t2d,
            glw::GL_DEPTH_COMPONENT32F,
            glw::GL_R8,
            nearest,
            depth_comp,
            red,
            256,
            1,
            255.0,
            glw::GL_FLOAT,
            GL_UNSIGNED_BYTE,
        ),
    );
    add(
        "Texture2DDC16",
        configuration(
            1,
            1,
            t2d,
            glw::GL_DEPTH_COMPONENT16,
            glw::GL_R8,
            nearest,
            depth_comp,
            red,
            256,
            1,
            255.0,
            GL_UNSIGNED_SHORT,
            GL_UNSIGNED_BYTE,
        ),
    );
    add(
        "Texture2DCompressed",
        configuration(
            4,
            4,
            t2d,
            etc2,
            glw::GL_RGBA8,
            nearest,
            rgba,
            rgba,
            64,
            1,
            1.0,
            glw::GL_FLOAT,
            GL_UNSIGNED_BYTE,
        ),
    );

    // Nearest, GL_TEXTURE_2D_ARRAY
    add(
        "Texture2DArrayRGBA32F",
        configuration(
            4,
            4,
            t2da,
            glw::GL_RGBA32F,
            glw::GL_RGBA8,
            nearest,
            rgba,
            rgba,
            256,
            6,
            1.0,
            glw::GL_FLOAT,
            GL_UNSIGNED_BYTE,
        ),
    );
    add(
        "Texture2DArrayR32I",
        configuration(
            1,
            4,
            t2da,
            glw::GL_R32I,
            glw::GL_R32I,
            nearest,
            red_int,
            rgba_int,
            256,
            6,
            255.0,
            GL_INT,
            GL_INT,
        ),
    );
    add(
        "Texture2DArrayR32UI",
        configuration(
            1,
            4,
            t2da,
            glw::GL_R32UI,
            glw::GL_R32UI,
            nearest,
            red_int,
            rgba_int,
            256,
            6,
            255.0,
            GL_UNSIGNED_INT,
            GL_UNSIGNED_INT,
        ),
    );
    add(
        "Texture2DArrayRGBA8",
        configuration(
            4,
            4,
            t2da,
            glw::GL_RGBA8,
            glw::GL_RGBA8,
            nearest,
            rgba,
            rgba,
            256,
            6,
            255.0,
            GL_UNSIGNED_BYTE,
            GL_UNSIGNED_BYTE,
        ),
    );
    add(
        "Texture2DArrayCompressed",
        configuration(
            4,
            4,
            t2da,
            etc2,
            glw::GL_RGBA8,
            nearest,
            rgba,
            rgba,
            64,
            6,
            1.0,
            glw::GL_FLOAT,
            GL_UNSIGNED_BYTE,
        ),
    );

    // Nearest, GL_TEXTURE_3D
    add(
        "Texture3DRGBA32F",
        configuration(
            4,
            4,
            t3d,
            glw::GL_RGBA32F,
            glw::GL_RGBA8,
            nearest,
            rgba,
            rgba,
            256,
            6,
            1.0,
            glw::GL_FLOAT,
            GL_UNSIGNED_BYTE,
        ),
    );
    add(
        "Texture3DR32I",
        configuration(
            1,
            4,
            t3d,
            glw::GL_R32I,
            glw::GL_R32I,
            nearest,
            red_int,
            rgba_int,
            256,
            6,
            255.0,
            GL_INT,
            GL_INT,
        ),
    );
    add(
        "Texture3DR32UI",
        configuration(
            1,
            4,
            t3d,
            glw::GL_R32UI,
            glw::GL_R32UI,
            nearest,
            red_int,
            rgba_int,
            256,
            6,
            255.0,
            GL_UNSIGNED_INT,
            GL_UNSIGNED_INT,
        ),
    );
    add(
        "Texture3DRGBA8",
        configuration(
            4,
            4,
            t3d,
            glw::GL_RGBA8,
            glw::GL_RGBA8,
            nearest,
            rgba,
            rgba,
            256,
            6,
            255.0,
            GL_UNSIGNED_BYTE,
            GL_UNSIGNED_BYTE,
        ),
    );

    // Linear, GL_TEXTURE_2D
    add(
        "Texture2DRGBA32FLinear",
        configuration(
            4,
            4,
            t2d,
            glw::GL_RGBA32F,
            glw::GL_RGBA8,
            linear,
            rgba,
            rgba,
            256,
            1,
            1.0,
            glw::GL_FLOAT,
            GL_UNSIGNED_BYTE,
        ),
    );
    add(
        "Texture2DRGBA8Linear",
        configuration(
            4,
            4,
            t2d,
            glw::GL_RGBA8,
            glw::GL_RGBA8,
            linear,
            rgba,
            rgba,
            256,
            1,
            255.0,
            GL_UNSIGNED_BYTE,
            GL_UNSIGNED_BYTE,
        ),
    );
    add(
        "Texture2DDC32FLinear",
        configuration(
            1,
            1,
            t2d,
            glw::GL_DEPTH_COMPONENT32F,
            glw::GL_R8,
            linear,
            depth_comp,
            red,
            256,
            1,
            255.0,
            glw::GL_FLOAT,
            GL_UNSIGNED_BYTE,
        ),
    );
    add(
        "Texture2DDC16Linear",
        configuration(
            1,
            1,
            t2d,
            glw::GL_DEPTH_COMPONENT16,
            glw::GL_R8,
            linear,
            depth_comp,
            red,
            256,
            1,
            255.0,
            GL_UNSIGNED_SHORT,
            GL_UNSIGNED_BYTE,
        ),
    );
    add(
        "Texture2DCompressedLinear",
        configuration(
            4,
            4,
            t2d,
            etc2,
            glw::GL_RGBA8,
            linear,
            rgba,
            rgba,
            64,
            1,
            1.0,
            glw::GL_FLOAT,
            GL_UNSIGNED_BYTE,
        ),
    );

    // Linear, GL_TEXTURE_2D_ARRAY
    add(
        "Texture2DArrayRGBA32FLinear",
        configuration(
            4,
            4,
            t2da,
            glw::GL_RGBA32F,
            glw::GL_RGBA8,
            linear,
            rgba,
            rgba,
            256,
            6,
            1.0,
            glw::GL_FLOAT,
            GL_UNSIGNED_BYTE,
        ),
    );
    add(
        "Texture2DArrayRGBA8Linear",
        configuration(
            4,
            4,
            t2da,
            glw::GL_RGBA8,
            glw::GL_RGBA8,
            linear,
            rgba,
            rgba,
            256,
            6,
            255.0,
            GL_UNSIGNED_BYTE,
            GL_UNSIGNED_BYTE,
        ),
    );
    add(
        "Texture2DArrayCompressedLinear",
        configuration(
            4,
            4,
            t2da,
            etc2,
            glw::GL_RGBA8,
            linear,
            rgba,
            rgba,
            64,
            6,
            1.0,
            glw::GL_FLOAT,
            GL_UNSIGNED_BYTE,
        ),
    );

    // Linear, GL_TEXTURE_3D
    add(
        "Texture3DRGBA32FLinear",
        configuration(
            4,
            4,
            t3d,
            glw::GL_RGBA32F,
            glw::GL_RGBA8,
            linear,
            rgba,
            rgba,
            256,
            6,
            1.0,
            glw::GL_FLOAT,
            GL_UNSIGNED_BYTE,
        ),
    );
    add(
        "Texture3DRGBA8Linear",
        configuration(
            4,
            4,
            t3d,
            glw::GL_RGBA8,
            glw::GL_RGBA8,
            linear,
            rgba,
            rgba,
            256,
            6,
            255.0,
            GL_UNSIGNED_BYTE,
            GL_UNSIGNED_BYTE,
        ),
    );
}
