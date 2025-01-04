// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cTextureViewTests.cpp  (TextureViewTestViewClasses)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Raw texel reads go through `read_bytes`, which zero-fills past the end of a buffer where upstream reads whatever follows it. `Float10`/`Float11` of upstream are `unpack_small_float` (5 exponent bits, no sign).

use std::ffi::CString;

use super::tables::{
    Format, SamplerType, amount_of_components_for_internalformat, component_size_for_internalformat,
    format_of_internalformat, gl_format_of_internalformat, internalformat_string, is_internalformat_compressed,
    sampler_type_for_internalformat, type_compatible_with_internalformat,
};
use super::utilities::{
    glsl_data_type_for_sampler_type, glsl_type_for_sampler_type, is_internalformat_srgb,
    legal_texture_and_view_internalformat_combinations, texture_data_size,
};
use super::{check_texture_view_support, link_program, shader_source, uniform_location};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::float::Float16;
use crate::tcu::{TestError, TestOutcome, TestStatus};

const TEXTURE_HEIGHT: u32 = 4;
const TEXTURE_UNIT_FOR_PARENT_TEXTURE: GLenum = glw::GL_TEXTURE0;
const TEXTURE_UNIT_FOR_VIEW_TEXTURE: GLenum = glw::GL_TEXTURE1;
const TEXTURE_WIDTH: u32 = 4;

const VS_TEMPLATE_BODY: &str = "#version 400\n\nuniform TEXTURE_SAMPLER texture;\nuniform VIEW_SAMPLER    view;\n\nout TEXTURE_DATA_TYPE out_texture_data;\nout VIEW_DATA_TYPE    out_view_data;\n\nvoid main()\n{\n    ivec2 uv = ivec2(gl_VertexID % 4,\n                     gl_VertexID / 4);\n\n    out_texture_data = texelFetch(texture, uv, 0).TEXTURE_SWIZZLE;\n    out_view_data    = texelFetch(view,    uv, 0).VIEW_SWIZZLE;\n}\n";

/// `Float11`/`Float10`: an unsigned 5-bit exponent float with `mantissa_bits` of mantissa.
fn unpack_small_float(bits: u32, mantissa_bits: u32) -> f32 {
    let mantissa = bits & ((1 << mantissa_bits) - 1);
    let exponent = ((bits >> mantissa_bits) & 0x1f) as i32;
    let scale = (1u32 << mantissa_bits) as f32;

    if exponent == 0 {
        mantissa as f32 / scale * 2f32.powi(1 - 15)
    } else if exponent == 0x1f {
        if mantissa == 0 { f32::INFINITY } else { f32::NAN }
    } else {
        (1.0 + mantissa as f32 / scale) * 2f32.powi(exponent - 15)
    }
}

/// `N` bytes at `offset`, zero-filled where the buffer ends early.
fn read_bytes<const N: usize>(data: &[u8], offset: usize) -> [u8; N] {
    let mut result = [0u8; N];
    for (n, byte) in result.iter_mut().enumerate() {
        *byte = data.get(offset + n).copied().unwrap_or(0);
    }
    result
}

fn read_u32(data: &[u8], offset: usize) -> u32 {
    u32::from_ne_bytes(read_bytes::<4>(data, offset))
}

/// The reference components of one texel, in the array that matches the view's sampler type.
#[derive(Default)]
struct ReferenceComponents {
    float: [f32; 4],
    int: [i32; 4],
    uint: [u32; 4],
}

/// `getComponentDataForByteAlignedInternalformat`
fn component_data_for_byte_aligned_internalformat(
    data: &[u8],
    n_components: u32,
    component_sizes: &[u32; 4],
    format: Format,
    result: &mut ReferenceComponents,
) -> Result<(), TestError> {
    debug_assert!(component_sizes.iter().all(|size| size % 8 == 0));

    let unsupported_size = || TestError::Fail("Unsupported component size".to_string());
    let mut offset = 0usize;

    for n_component in 0..n_components as usize {
        match format {
            Format::Float => {
                result.float[n_component] = match component_sizes[n_component] {
                    16 => Float16::from_bits(u16::from_ne_bytes(read_bytes::<2>(data, offset))).as_float(),
                    32 => f32::from_ne_bytes(read_bytes::<4>(data, offset)),
                    _ => return Err(unsupported_size()),
                };
            }
            Format::SignedInteger => {
                result.int[n_component] = match component_sizes[n_component] {
                    8 => i8::from_ne_bytes(read_bytes::<1>(data, offset)) as i32,
                    16 => i16::from_ne_bytes(read_bytes::<2>(data, offset)) as i32,
                    32 => i32::from_ne_bytes(read_bytes::<4>(data, offset)),
                    _ => return Err(unsupported_size()),
                };
            }
            Format::Snorm => {
                result.float[n_component] = match component_sizes[n_component] {
                    8 => i8::from_ne_bytes(read_bytes::<1>(data, offset)) as f32 / 127.0,
                    16 => i16::from_ne_bytes(read_bytes::<2>(data, offset)) as f32 / 32767.0,
                    _ => return Err(unsupported_size()),
                };

                if result.float[n_component] < -1.0 {
                    result.float[n_component] = -1.0;
                }
            }
            Format::Unorm => {
                result.float[n_component] = match component_sizes[n_component] {
                    8 => u8::from_ne_bytes(read_bytes::<1>(data, offset)) as f32 / 255.0,
                    16 => u16::from_ne_bytes(read_bytes::<2>(data, offset)) as f32 / 65535.0,
                    _ => return Err(unsupported_size()),
                };
            }
            Format::UnsignedInteger => {
                result.uint[n_component] = match component_sizes[n_component] {
                    8 => u8::from_ne_bytes(read_bytes::<1>(data, offset)) as u32,
                    16 => u16::from_ne_bytes(read_bytes::<2>(data, offset)) as u32,
                    32 => u32::from_ne_bytes(read_bytes::<4>(data, offset)),
                    _ => return Err(unsupported_size()),
                };
            }
            Format::Rgbe => return Err(TestError::Fail("Unrecognized mip-map format".to_string())),
        }

        offset += (component_sizes[n_component] >> 3) as usize;
    }

    Ok(())
}

/// The GL objects and buffers of one run; `TextureViewTestViewClasses::deinit` is the `Drop`.
struct State<'gl> {
    gl: &'gl glw::Functions,
    bo_id: GLuint,
    po_id: GLuint,
    to_id: GLuint,
    to_temp_id: GLuint,
    vao_id: GLuint,
    view_to_id: GLuint,
    vs_id: GLuint,

    decompressed_mipmap_data: Vec<u8>,
    mipmap_data: Vec<u8>,

    bo_size: u32,
    has_test_failed: bool,
    view_data_offset: u32,
}

impl Drop for State<'_> {
    fn drop(&mut self) {
        let gl = self.gl;
        // SAFETY: every name below was created by this state, is deleted once and zero names are skipped.
        unsafe {
            if self.bo_id != 0 {
                gl.delete_buffers(1, &self.bo_id);
            }
            if self.po_id != 0 {
                gl.delete_program(self.po_id);
            }
            if self.to_id != 0 {
                gl.delete_textures(1, &self.to_id);
            }
            if self.to_temp_id != 0 {
                gl.delete_textures(1, &self.to_temp_id);
            }
            if self.vao_id != 0 {
                gl.delete_vertex_arrays(1, &self.vao_id);
            }
            if self.view_to_id != 0 {
                gl.delete_textures(1, &self.view_to_id);
            }
            if self.vs_id != 0 {
                gl.delete_shader(self.vs_id);
            }

            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 4);
            gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 4);

            // Upstream "restores rasterization" with glEnable.
            gl.enable(glw::GL_RASTERIZER_DISCARD);
        }
    }
}

impl<'gl> State<'gl> {
    fn new(gl: &'gl glw::Functions) -> Self {
        Self {
            gl,
            bo_id: 0,
            po_id: 0,
            to_id: 0,
            to_temp_id: 0,
            vao_id: 0,
            view_to_id: 0,
            vs_id: 0,
            decompressed_mipmap_data: Vec::new(),
            mipmap_data: Vec::new(),
            bo_size: 0,
            has_test_failed: false,
            view_data_offset: 0,
        }
    }

    /// `initBufferObject`
    fn init_buffer_object(
        &mut self,
        texture_internalformat: GLenum,
        view_internalformat: GLenum,
    ) -> Result<(), TestError> {
        let gl = self.gl;

        let parent_texture_n_components = amount_of_components_for_internalformat(texture_internalformat)?;
        let view_texture_n_components = amount_of_components_for_internalformat(view_internalformat)?;

        let float_size = std::mem::size_of::<f32>() as u32;
        self.bo_size = parent_texture_n_components * float_size * TEXTURE_HEIGHT * TEXTURE_WIDTH
            + view_texture_n_components * float_size * TEXTURE_HEIGHT * TEXTURE_WIDTH;

        gl_call!(
            gl,
            "glBufferData() call failed.",
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                self.bo_size as isize,
                std::ptr::null(),
                glw::GL_STATIC_DRAW
            )
        );

        self.view_data_offset = parent_texture_n_components * float_size * TEXTURE_HEIGHT * TEXTURE_WIDTH;

        Ok(())
    }

    /// `initProgramObject`
    fn init_program_object(
        &mut self,
        texture_internalformat: GLenum,
        view_internalformat: GLenum,
    ) -> Result<(), TestError> {
        let gl = self.gl;

        let swizzle = |n_components: u32| match n_components {
            4 => "xyzw",
            3 => "xyz",
            2 => "xy",
            _ => "x",
        };

        let texture_n_components = amount_of_components_for_internalformat(texture_internalformat)?;
        let texture_sampler_type = sampler_type_for_internalformat(texture_internalformat)?;
        let texture_sampler_data_type_glsl =
            glsl_data_type_for_sampler_type(texture_sampler_type, texture_n_components)?;
        let texture_sampler_glsl = glsl_type_for_sampler_type(texture_sampler_type);
        let texture_swizzle_glsl = swizzle(texture_n_components);

        let view_n_components = amount_of_components_for_internalformat(view_internalformat)?;
        let view_sampler_type = sampler_type_for_internalformat(view_internalformat)?;
        let view_sampler_data_type_glsl = glsl_data_type_for_sampler_type(view_sampler_type, view_n_components)?;
        let view_sampler_glsl = glsl_type_for_sampler_type(view_sampler_type);
        let view_swizzle_glsl = swizzle(view_n_components);

        let vs_body = VS_TEMPLATE_BODY
            .replace("TEXTURE_DATA_TYPE", texture_sampler_data_type_glsl)
            .replace("TEXTURE_SAMPLER", texture_sampler_glsl)
            .replace("TEXTURE_SWIZZLE", texture_swizzle_glsl)
            .replace("VIEW_DATA_TYPE", view_sampler_data_type_glsl)
            .replace("VIEW_SAMPLER", view_sampler_glsl)
            .replace("VIEW_SWIZZLE", view_swizzle_glsl);

        shader_source(gl, self.vs_id, &vs_body, "glShaderSource() call failed.")?;

        gl_call!(gl, "glCompileShader() call failed.", gl.compile_shader(self.vs_id));

        let mut compile_status = glw::GL_FALSE as GLint;
        gl_call!(
            gl,
            "glGetShaderiv() call failed.",
            gl.get_shaderiv(self.vs_id, glw::GL_COMPILE_STATUS, &mut compile_status)
        );

        if compile_status != glw::GL_TRUE as GLint {
            return Err(TestError::Fail("Shader compilation failed".to_string()));
        }

        let varying_names = [
            CString::new("out_texture_data").expect("no NUL"),
            CString::new("out_view_data").expect("no NUL"),
        ];
        let varying_name_ptrs = [varying_names[0].as_ptr(), varying_names[1].as_ptr()];
        gl_call!(
            gl,
            "glTransformFeedbackVaryings() call failed.",
            gl.transform_feedback_varyings(self.po_id, 2, varying_name_ptrs.as_ptr(), glw::GL_SEPARATE_ATTRIBS)
        );

        gl_call!(gl, "glBindBufferRange() call(s) failed.", {
            gl.bind_buffer_range(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                0,
                self.bo_id,
                0,
                self.view_data_offset as isize,
            );
            gl.bind_buffer_range(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                1,
                self.bo_id,
                self.view_data_offset as isize,
                (self.bo_size - self.view_data_offset) as isize,
            );
        });

        link_program(gl, self.po_id, "glLinkProgram() call failed.")?;

        let texture_uniform_location = uniform_location(gl, self.po_id, "texture");
        let view_uniform_location = uniform_location(gl, self.po_id, "view");

        if texture_uniform_location == -1 {
            return Err(TestError::Fail(
                "'texture' uniform is considered inactive which is invalid".to_string(),
            ));
        }

        if view_uniform_location == -1 {
            return Err(TestError::Fail(
                "'view' uniform is considered inactive which is invalid".to_string(),
            ));
        }

        gl_call!(gl, "glUseProgram() call failed.", gl.use_program(self.po_id));

        gl_call!(gl, "glUniform1i() call(s) failed.", {
            gl.uniform_1i(
                texture_uniform_location,
                (TEXTURE_UNIT_FOR_PARENT_TEXTURE - glw::GL_TEXTURE0) as GLint,
            );
            gl.uniform_1i(
                view_uniform_location,
                (TEXTURE_UNIT_FOR_VIEW_TEXTURE - glw::GL_TEXTURE0) as GLint,
            );
        });

        Ok(())
    }

    /// `initTest`
    fn init_test(&mut self) -> Result<(), TestError> {
        let gl = self.gl;

        gl_call!(gl, "glGenBuffers() call failed.", gl.gen_buffers(1, &mut self.bo_id));

        // SAFETY: plain object creation with a current context.
        self.po_id = unsafe { gl.create_program() };
        crate::glu::expect_no_error(gl, "glCreateProgram() call failed.")?;

        gl_call!(
            gl,
            "glGenVertexArrays() call failed.",
            gl.gen_vertex_arrays(1, &mut self.vao_id)
        );

        // SAFETY: plain object creation with a current context.
        self.vs_id = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
        crate::glu::expect_no_error(gl, "glCreateShader() call failed.")?;

        gl_call!(
            gl,
            "glAttachShader() call failed.",
            gl.attach_shader(self.po_id, self.vs_id)
        );

        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.bo_id)
        );
        gl_call!(
            gl,
            "glBindBufferBase() call failed.",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.bo_id)
        );

        gl_call!(
            gl,
            "glBindVertexArray() call failed.",
            gl.bind_vertex_array(self.vao_id)
        );

        gl_call!(gl, "glPixelStorei() call(s) failed.", {
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1);
            gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
        });

        gl_call!(
            gl,
            "glEnable(GL_RASTERIZER_DISCARD) call failed.",
            gl.enable(glw::GL_RASTERIZER_DISCARD)
        );

        Ok(())
    }

    /// `initTextureObject`
    fn init_texture_object(
        &mut self,
        should_init_parent_texture: bool,
        texture_internalformat: GLenum,
        view_internalformat: GLenum,
    ) -> Result<(), TestError> {
        let cached_view_internalformat = view_internalformat;
        let mut view_internalformat = view_internalformat;
        let gl = self.gl;

        let existing = if should_init_parent_texture {
            self.to_id
        } else {
            self.view_to_id
        };
        if existing != 0 {
            gl_call!(gl, "glDeleteTextures() call failed.", gl.delete_textures(1, &existing));
            if should_init_parent_texture {
                self.to_id = 0;
            } else {
                self.view_to_id = 0;
            }
        }

        let mut new_id: GLuint = 0;
        gl_call!(gl, "glGenTextures() call failed.", gl.gen_textures(1, &mut new_id));
        if should_init_parent_texture {
            self.to_id = new_id;
        } else {
            self.view_to_id = new_id;
        }

        if should_init_parent_texture {
            gl_call!(
                gl,
                "glBindTexture() call failed.",
                gl.bind_texture(glw::GL_TEXTURE_2D, new_id)
            );
            gl_call!(
                gl,
                "glTexStorage2D() call failed.",
                gl.tex_storage_2d(
                    glw::GL_TEXTURE_2D,
                    1,
                    texture_internalformat,
                    TEXTURE_WIDTH as GLint,
                    TEXTURE_HEIGHT as GLint
                )
            );
        } else {
            gl_call!(
                gl,
                "glTextureView() call failed.",
                gl.texture_view(
                    self.view_to_id,
                    glw::GL_TEXTURE_2D,
                    self.to_id,
                    view_internalformat,
                    0,
                    1,
                    0,
                    1
                )
            );
            gl_call!(
                gl,
                "glBindTexture() call failed.",
                gl.bind_texture(glw::GL_TEXTURE_2D, self.view_to_id)
            );
        }

        if should_init_parent_texture {
            let is_compressed = is_internalformat_compressed(texture_internalformat);

            let internalformat_to_use = if is_compressed {
                let format = format_of_internalformat(texture_internalformat)?;
                let internalformat_to_use = if format == Format::Float {
                    glw::GL_RGBA32F
                } else {
                    glw::GL_RGBA8
                };
                view_internalformat = internalformat_to_use;
                internalformat_to_use
            } else {
                texture_internalformat
            };

            let format_to_use = gl_format_of_internalformat(internalformat_to_use)?;
            let mut type_to_use = type_compatible_with_internalformat(internalformat_to_use)?;
            let view_type = type_compatible_with_internalformat(view_internalformat)?;

            match texture_internalformat {
                glw::GL_R11F_G11F_B10F => type_to_use = glw::GL_UNSIGNED_INT_10F_11F_11F_REV,
                glw::GL_RGB9_E5 => type_to_use = glw::GL_UNSIGNED_INT_5_9_9_9_REV,
                glw::GL_RGB10_A2 => type_to_use = glw::GL_UNSIGNED_INT_2_10_10_10_REV,
                _ => {}
            }

            let mipmap_raw_size =
                texture_data_size(internalformat_to_use, type_to_use, TEXTURE_WIDTH, TEXTURE_HEIGHT)? as usize;

            self.mipmap_data = vec![0u8; mipmap_raw_size];

            match view_type {
                glw::GL_BYTE => {
                    for (i, chunk) in self.mipmap_data.chunks_exact_mut(1).enumerate() {
                        chunk.copy_from_slice(&(i as u32).wrapping_sub(128).to_ne_bytes()[..1]);
                    }
                }
                glw::GL_SHORT => {
                    for (i, chunk) in self.mipmap_data.chunks_exact_mut(2).enumerate() {
                        // 0xC000 = (fp16) -2 makes this non de-norm
                        chunk.copy_from_slice(&((i as u32).wrapping_sub(0xC000) as u16).to_ne_bytes());
                    }
                }
                glw::GL_INT => {
                    for (i, chunk) in self.mipmap_data.chunks_exact_mut(4).enumerate() {
                        chunk.copy_from_slice(&(i as u32).wrapping_sub(128).to_ne_bytes());
                    }
                }
                glw::GL_UNSIGNED_BYTE => {
                    for (i, chunk) in self.mipmap_data.chunks_exact_mut(1).enumerate() {
                        chunk[0] = i as u8;
                    }
                }
                glw::GL_UNSIGNED_SHORT => {
                    for (i, chunk) in self.mipmap_data.chunks_exact_mut(2).enumerate() {
                        chunk.copy_from_slice(&(i as u16).to_ne_bytes());
                    }
                }
                glw::GL_UNSIGNED_INT => {
                    for (i, chunk) in self.mipmap_data.chunks_exact_mut(4).enumerate() {
                        chunk.copy_from_slice(&(i as u32).to_ne_bytes());
                    }
                }
                glw::GL_UNSIGNED_INT_24_8 => {
                    for (i, chunk) in self.mipmap_data.chunks_exact_mut(4).enumerate() {
                        chunk.copy_from_slice(&(((i as u32) << 8) | 0xaa).to_ne_bytes());
                    }
                }
                glw::GL_FLOAT_32_UNSIGNED_INT_24_8_REV => {
                    for (i, chunk) in self.mipmap_data.chunks_exact_mut(8).enumerate() {
                        chunk[..4].copy_from_slice(&((i as f32) - 128.0).to_ne_bytes());
                        chunk[4..].copy_from_slice(&(((i as u32) << 8) | 0xaa).to_ne_bytes());
                    }
                }
                glw::GL_HALF_FLOAT => {
                    for (i, chunk) in self.mipmap_data.chunks_exact_mut(2).enumerate() {
                        chunk.copy_from_slice(&Float16::new(i as f32 - 128.0).bits().to_ne_bytes());
                    }
                }
                glw::GL_FLOAT => {
                    let offset = if cached_view_internalformat == glw::GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT {
                        0.0
                    } else {
                        -128.0
                    };

                    for (i, chunk) in self.mipmap_data.chunks_exact_mut(4).enumerate() {
                        chunk.copy_from_slice(&(i as f32 + offset).to_ne_bytes());
                    }
                }
                glw::GL_UNSIGNED_INT_2_10_10_10_REV => {
                    for (i, chunk) in self.mipmap_data.chunks_exact_mut(4).enumerate() {
                        let i = i as u32;
                        chunk.copy_from_slice(&(i | (i << 8) | (i << 16)).to_ne_bytes());
                    }
                }
                _ => return Err(TestError::Fail("Unrecognized texture view type".to_string())),
            }

            let mut image_size_to_use: u32 = 0;
            let mut use_compressed_tex_sub_image_2d_call = false;

            // Signed and unsigned BPTC float encodings differ, so the data is compressed with the view's internalformat first.
            if (cached_view_internalformat == glw::GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT
                || cached_view_internalformat == glw::GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT)
                && cached_view_internalformat != texture_internalformat
            {
                gl_call!(
                    gl,
                    "glGenTextures() call failed.",
                    gl.gen_textures(1, &mut self.to_temp_id)
                );
                gl_call!(
                    gl,
                    "glBindTexture() call failed.",
                    gl.bind_texture(glw::GL_TEXTURE_2D, self.to_temp_id)
                );

                gl_call!(
                    gl,
                    "glTexStorage2D() call failed.",
                    gl.tex_storage_2d(
                        glw::GL_TEXTURE_2D,
                        1,
                        cached_view_internalformat,
                        TEXTURE_WIDTH as GLint,
                        TEXTURE_HEIGHT as GLint
                    )
                );

                gl_call!(
                    gl,
                    "glTexSubImage2D() call failed.",
                    gl.tex_sub_image_2d(
                        glw::GL_TEXTURE_2D,
                        0,
                        0,
                        0,
                        TEXTURE_WIDTH as GLint,
                        TEXTURE_HEIGHT as GLint,
                        glw::GL_RGB,
                        glw::GL_FLOAT,
                        self.mipmap_data.as_ptr().cast()
                    )
                );

                gl_call!(
                    gl,
                    "glGetCompressedTexImage() call failed.",
                    gl.get_compressed_tex_image(glw::GL_TEXTURE_2D, 0, self.mipmap_data.as_mut_ptr().cast())
                );

                gl_call!(
                    gl,
                    "glDeleteTextures() call failed.",
                    gl.delete_textures(1, &self.to_temp_id)
                );
                self.to_temp_id = 0;

                gl_call!(
                    gl,
                    "glBindTexture() call failed.",
                    gl.bind_texture(glw::GL_TEXTURE_2D, self.to_id)
                );

                image_size_to_use = TEXTURE_WIDTH.div_ceil(4) * TEXTURE_HEIGHT.div_ceil(4) * 16;
                use_compressed_tex_sub_image_2d_call = true;
            }

            if use_compressed_tex_sub_image_2d_call {
                gl_call!(
                    gl,
                    "glCompressedTexSubImage2D() call failed.",
                    gl.compressed_tex_sub_image_2d(
                        glw::GL_TEXTURE_2D,
                        0,
                        0,
                        0,
                        TEXTURE_WIDTH as GLint,
                        TEXTURE_HEIGHT as GLint,
                        texture_internalformat,
                        image_size_to_use as GLint,
                        self.mipmap_data.as_ptr().cast()
                    )
                );
            } else {
                gl_call!(
                    gl,
                    "glTexSubImage2D() call failed.",
                    gl.tex_sub_image_2d(
                        glw::GL_TEXTURE_2D,
                        0,
                        0,
                        0,
                        TEXTURE_WIDTH as GLint,
                        TEXTURE_HEIGHT as GLint,
                        format_to_use,
                        type_to_use,
                        self.mipmap_data.as_ptr().cast()
                    )
                );
            }
        }

        gl_call!(gl, "glTexParameteri() call(s) failed.", {
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_BASE_LEVEL, 0);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_LEVEL, 0);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_WRAP_S,
                glw::GL_CLAMP_TO_EDGE as GLint,
            );
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_WRAP_T,
                glw::GL_CLAMP_TO_EDGE as GLint,
            );
        });

        Ok(())
    }

    /// `verifyResultData`: `texture_data` and `view_data` are what the vertex shader captured from the parent texture and the view.
    fn verify_result_data(
        &mut self,
        texture_internalformat: GLenum,
        view_internalformat: GLenum,
        texture_data: &[u8],
        view_data: &[u8],
    ) -> Result<(), TestError> {
        let gl = self.gl;
        let texture_internalformat_string = internalformat_string(texture_internalformat)?;
        let view_internalformat_string = internalformat_string(view_internalformat)?;

        let offset = self.view_data_offset as usize;
        let mut has_failed = false;
        let mut use_decompressed = false;

        // When the view part is shorter than the texture part, upstream's memcmp runs past the buffer; the data cannot be equal then.
        let data_matches = view_data.len() >= offset && texture_data[..offset] == view_data[..offset];

        if !data_matches {
            let mut can_continue = true;

            let is_view_internalformat_compressed = is_internalformat_compressed(view_internalformat);

            let n_view_components = amount_of_components_for_internalformat(view_internalformat)?;
            let texture_format = format_of_internalformat(texture_internalformat)?;
            let mut view_component_sizes = [0u32; 4];
            let view_format = format_of_internalformat(view_internalformat)?;

            let n_bits_per_view_texel: u32 = if !is_view_internalformat_compressed {
                view_component_sizes = component_size_for_internalformat(view_internalformat)?;
                view_component_sizes.iter().sum()
            } else if texture_internalformat == glw::GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT
                || texture_internalformat == glw::GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT
            {
                for size in view_component_sizes.iter_mut().take(n_view_components as usize) {
                    *size = 32;
                }
                32 * n_view_components
            } else {
                for size in view_component_sizes.iter_mut().take(n_view_components as usize) {
                    *size = 8;
                }
                8 * n_view_components
            };

            if is_view_internalformat_compressed {
                self.decompressed_mipmap_data =
                    vec![0u8; (TEXTURE_WIDTH * TEXTURE_HEIGHT * (n_bits_per_view_texel >> 3)) as usize];

                let mut reference_tex_id = self.to_id;

                // The signed and unsigned BPTC encodings are incompatible, so the view holds the right encoding for the expected results.
                if texture_internalformat == glw::GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT
                    || texture_internalformat == glw::GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT
                {
                    reference_tex_id = self.view_to_id;
                }

                gl_call!(
                    gl,
                    "glBindTexture() call failed.",
                    gl.bind_texture(glw::GL_TEXTURE_2D, reference_tex_id)
                );

                let format = match n_view_components {
                    4 => glw::GL_RGBA,
                    3 => glw::GL_RGB,
                    2 => glw::GL_RG,
                    _ => glw::GL_RED,
                };
                let type_ = match texture_format {
                    Format::Snorm => glw::GL_BYTE,
                    Format::Float => glw::GL_FLOAT,
                    _ => glw::GL_UNSIGNED_BYTE,
                };

                gl_call!(
                    gl,
                    "glGetTexImage() call failed.",
                    gl.get_tex_image(
                        glw::GL_TEXTURE_2D,
                        0,
                        format,
                        type_,
                        self.decompressed_mipmap_data.as_mut_ptr().cast()
                    )
                );

                use_decompressed = true;
            }

            let mipmap_data: &[u8] = if use_decompressed {
                &self.decompressed_mipmap_data
            } else {
                &self.mipmap_data
            };
            let view_sampler_type = sampler_type_for_internalformat(view_internalformat)?;

            let mut n_texel = 0u32;
            while n_texel < TEXTURE_HEIGHT * TEXTURE_WIDTH && can_continue {
                let mipmap_texel_offset = (n_bits_per_view_texel >> 3) as usize * n_texel as usize;
                let mut reference = ReferenceComponents::default();
                let mut view_components_float = [0f32; 4];
                let mut view_components_int = [0i32; 4];
                let mut view_components_uint = [0u32; 4];

                let view_texel_offset = std::mem::size_of::<f32>() * n_view_components as usize * n_texel as usize;
                for n_component in 0..n_view_components as usize {
                    let component_offset = view_texel_offset + n_component * std::mem::size_of::<f32>();
                    let bytes = read_bytes::<4>(view_data, component_offset);

                    match view_sampler_type {
                        SamplerType::Float => view_components_float[n_component] = f32::from_ne_bytes(bytes),
                        SamplerType::SignedInteger => view_components_int[n_component] = i32::from_ne_bytes(bytes),
                        SamplerType::UnsignedInteger => view_components_uint[n_component] = u32::from_ne_bytes(bytes),
                    }
                }

                let invalid_sampler_type =
                    || TestError::Fail("Internal error: invalid sampler type requested".to_string());

                if view_internalformat == glw::GL_R11F_G11F_B10F {
                    let reference_data = read_u32(mipmap_data, mipmap_texel_offset);
                    let red_component = reference_data & ((1 << 11) - 1);
                    let green_component = (reference_data >> 11) & ((1 << 11) - 1);
                    let blue_component = (reference_data >> 22) & ((1 << 10) - 1);

                    if view_sampler_type == SamplerType::Float {
                        reference.float[0] = unpack_small_float(red_component, 6);
                        reference.float[1] = unpack_small_float(green_component, 6);
                        reference.float[2] = unpack_small_float(blue_component, 5);
                    } else {
                        return Err(invalid_sampler_type());
                    }
                } else if view_internalformat == glw::GL_RGB9_E5 {
                    let reference_data = read_u32(mipmap_data, mipmap_texel_offset);
                    let exponent = (reference_data >> 27) & ((1 << 5) - 1);
                    let red_component = reference_data & ((1 << 9) - 1);
                    let green_component = (reference_data >> 9) & ((1 << 9) - 1);
                    let blue_component = (reference_data >> 18) & ((1 << 9) - 1);

                    let shared_exponent = 2f32.powf((exponent as i32 - 15 - 9) as f32);

                    if view_sampler_type == SamplerType::Float {
                        reference.float[0] = red_component as f32 * shared_exponent;
                        reference.float[1] = green_component as f32 * shared_exponent;
                        reference.float[2] = blue_component as f32 * shared_exponent;
                    } else {
                        return Err(invalid_sampler_type());
                    }
                } else if view_internalformat == glw::GL_RGB10_A2 {
                    let reference_data = read_u32(mipmap_data, mipmap_texel_offset);
                    let mask_rgb = (1u32 << 10) - 1;
                    let mask_a = (1u32 << 2) - 1;

                    if view_sampler_type == SamplerType::Float {
                        reference.float[0] = (reference_data & mask_rgb) as f32 / mask_rgb as f32;
                        reference.float[1] = ((reference_data >> 10) & mask_rgb) as f32 / mask_rgb as f32;
                        reference.float[2] = ((reference_data >> 20) & mask_rgb) as f32 / mask_rgb as f32;
                        reference.float[3] = ((reference_data >> 30) & mask_a) as f32 / mask_a as f32;
                    } else {
                        return Err(invalid_sampler_type());
                    }
                } else if view_internalformat == glw::GL_RGB10_A2UI {
                    let reference_data = read_u32(mipmap_data, mipmap_texel_offset);
                    let mask_rgb = (1u32 << 10) - 1;
                    let mask_a = (1u32 << 2) - 1;

                    if view_sampler_type == SamplerType::UnsignedInteger {
                        reference.uint[0] = reference_data & mask_rgb;
                        reference.uint[1] = (reference_data >> 10) & mask_rgb;
                        reference.uint[2] = (reference_data >> 20) & mask_rgb;
                        reference.uint[3] = (reference_data >> 30) & mask_a;
                    } else {
                        return Err(invalid_sampler_type());
                    }
                } else if view_internalformat == glw::GL_RG16F {
                    if view_sampler_type == SamplerType::Float {
                        reference.float[0] =
                            Float16::from_bits(u16::from_ne_bytes(read_bytes::<2>(mipmap_data, mipmap_texel_offset)))
                                .as_float();
                        reference.float[1] = Float16::from_bits(u16::from_ne_bytes(read_bytes::<2>(
                            mipmap_data,
                            mipmap_texel_offset + 2,
                        )))
                        .as_float();
                    } else {
                        return Err(invalid_sampler_type());
                    }
                } else {
                    let texel_data = mipmap_data.get(mipmap_texel_offset..).unwrap_or(&[]);
                    component_data_for_byte_aligned_internalformat(
                        texel_data,
                        n_view_components,
                        &view_component_sizes,
                        view_format,
                        &mut reference,
                    )?;
                }

                for n_component in 0..n_view_components as usize {
                    // A view in the sRGB colour space over a linear texture needs the reference moved back into linear space (8.14 of the GL 4.4 spec); alpha is excluded.
                    if is_internalformat_srgb(view_internalformat) && !is_internalformat_srgb(texture_internalformat) {
                        debug_assert!(view_sampler_type == SamplerType::Float);

                        if n_component != 3 {
                            if reference.float[n_component] <= 0.04045 {
                                reference.float[n_component] /= 12.92;
                            } else {
                                reference.float[n_component] =
                                    ((reference.float[n_component] + 0.055) / 1.055).powf(2.4);
                            }
                        }
                    }

                    let epsilon_float = 1.0 / (((1i64 << (view_component_sizes[n_component] - 1)) - 1) as f32);
                    let epsilon_int = 1;
                    let epsilon_uint = 1;

                    match view_sampler_type {
                        SamplerType::Float => {
                            if (reference.float[n_component] - view_components_float[n_component]).abs() > epsilon_float
                            {
                                has_failed = true;
                            }
                        }
                        SamplerType::SignedInteger => {
                            let larger_value = reference.int[n_component].max(view_components_int[n_component]);
                            let smaller_value = reference.int[n_component].min(view_components_int[n_component]);

                            if larger_value.wrapping_sub(smaller_value) > epsilon_int {
                                has_failed = true;
                            }
                        }
                        SamplerType::UnsignedInteger => {
                            let larger_value = reference.uint[n_component].max(view_components_uint[n_component]);
                            let smaller_value = reference.uint[n_component].min(view_components_uint[n_component]);

                            if larger_value - smaller_value > epsilon_uint {
                                has_failed = true;
                            }
                        }
                    }

                    if has_failed {
                        can_continue = false;

                        let (x, y) = (n_texel % TEXTURE_WIDTH, n_texel / TEXTURE_HEIGHT);

                        match view_sampler_type {
                            SamplerType::Float => log::info!(
                                "Invalid data sampled from a texture view [{view_internalformat_string}] created from a texture object[{texture_internalformat_string}] at texel ({x}, {y}): expected:({}, {}, {}, {}) found:({}, {}, {}, {}).",
                                reference.float[0],
                                reference.float[1],
                                reference.float[2],
                                reference.float[3],
                                view_components_float[0],
                                view_components_float[1],
                                view_components_float[2],
                                view_components_float[3]
                            ),
                            SamplerType::SignedInteger => log::info!(
                                "Invalid data sampled from a signed integer texture view [{view_internalformat_string}] created from a texture object[{texture_internalformat_string}] at texel ({x}, {y}): expected:({}, {}, {}, {}) found:({}, {}, {}, {}).",
                                reference.int[0],
                                reference.int[1],
                                reference.int[2],
                                reference.int[3],
                                view_components_int[0],
                                view_components_int[1],
                                view_components_int[2],
                                view_components_int[3]
                            ),
                            SamplerType::UnsignedInteger => log::info!(
                                "Invalid data sampled from an unsigned integer texture view [{view_internalformat_string}] created from a texture object[{texture_internalformat_string}] at texel ({x}, {y}): expected:({}, {}, {}, {}) found:({}, {}, {}, {}).",
                                reference.uint[0],
                                reference.uint[1],
                                reference.uint[2],
                                reference.uint[3],
                                view_components_uint[0],
                                view_components_uint[1],
                                view_components_uint[2],
                                view_components_uint[3]
                            ),
                        }

                        break;
                    }
                }

                n_texel += 1;
            }
        }

        if has_failed {
            log::info!(
                "Invalid data read from a view of internalformat [{view_internalformat_string}] created from a texture of internalformat [{texture_internalformat_string}]. Byte streams follow:"
            );

            let mipmap_data: &[u8] = if use_decompressed {
                &self.decompressed_mipmap_data
            } else {
                &self.mipmap_data
            };
            let hex = |data: &[u8]| {
                (0..offset)
                    .map(|n| format!("0x{:02x}", data.get(n).copied().unwrap_or(0)))
                    .collect::<Vec<_>>()
                    .join("|")
            };

            log::info!(
                "Mip-map data: [{}]\nSampled view data: [{}]\n",
                hex(mipmap_data),
                hex(view_data)
            );

            // Failing is deferred until every combination ran.
            self.has_test_failed = true;
        } else {
            log::info!(
                "Correct data read from a view of internalformat [{view_internalformat_string}] created from a texture of internalformat [{texture_internalformat_string}]"
            );
        }

        Ok(())
    }
}

/// `TextureViewTestViewClasses`
pub(super) struct ViewClasses;

impl TestCase for ViewClasses {
    fn name(&self) -> &str {
        "view_classes"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        check_texture_view_support(context)?;

        let mut state = State::new(gl);
        state.init_test()?;

        for (texture_internalformat, view_internalformat) in legal_texture_and_view_internalformat_combinations() {
            state.init_texture_object(true, texture_internalformat, view_internalformat)?;
            state.init_texture_object(false, texture_internalformat, view_internalformat)?;

            state.init_buffer_object(texture_internalformat, view_internalformat)?;

            state.init_program_object(texture_internalformat, view_internalformat)?;

            gl_call!(
                gl,
                "glActiveTexture() call failed.",
                gl.active_texture(TEXTURE_UNIT_FOR_PARENT_TEXTURE)
            );
            gl_call!(
                gl,
                "glBindTexture() call failed.",
                gl.bind_texture(glw::GL_TEXTURE_2D, state.to_id)
            );

            gl_call!(
                gl,
                "glActiveTexture() call failed.",
                gl.active_texture(TEXTURE_UNIT_FOR_VIEW_TEXTURE)
            );
            gl_call!(
                gl,
                "glBindTexture() call failed.",
                gl.bind_texture(glw::GL_TEXTURE_2D, state.view_to_id)
            );

            gl_call!(
                gl,
                "glBeginTransformFeedback() call failed.",
                gl.begin_transform_feedback(glw::GL_POINTS)
            );
            gl_call!(
                gl,
                "glDrawArrays() call failed.",
                gl.draw_arrays(glw::GL_POINTS, 0, (TEXTURE_WIDTH * TEXTURE_HEIGHT) as GLint)
            );
            gl_call!(gl, "glEndTransformFeedback() call failed.", gl.end_transform_feedback());

            // SAFETY: the buffer holds bo_size bytes, see init_buffer_object; it stays mapped until the unmap below.
            let result_bo_data_ptr =
                unsafe { gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY) } as *const u8;
            crate::glu::expect_no_error(gl, "glMapBuffer() call failed.")?;

            if result_bo_data_ptr.is_null() {
                return Err(TestError::Fail(
                    "glMapBuffer() did not generate an error but returned a NULL pointer".to_string(),
                ));
            }

            // SAFETY: see the mapping above.
            let result_bo_data = unsafe { std::slice::from_raw_parts(result_bo_data_ptr, state.bo_size as usize) };
            let result_texture_data = &result_bo_data[..state.view_data_offset as usize];
            let result_view_data = &result_bo_data[state.view_data_offset as usize..];

            state.verify_result_data(
                texture_internalformat,
                view_internalformat,
                result_texture_data,
                result_view_data,
            )?;

            gl_call!(
                gl,
                "glUnmapBuffer() call failed.",
                gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER)
            );
        }

        if state.has_test_failed {
            Ok(TestStatus::fail("Fail"))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}
