// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderImageLoadStoreTests.cpp  (ImageLoadStoreIncompleteTexturesTest)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `GLU_EXPECT_NO_ERROR` is `glu::expect_no_error(..)?`, `tcu::InternalError` is `TestError::Fail`. Written without compiling.

use std::ffi::CString;

use super::base::*;
use crate::glu::{self, Context};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::subcase::{ERROR, NO_ERROR, Subcase, SubcaseResult};
use crate::tcu::TestError;

const VERTEX_SHADER_CODE: &str = "#version 400 core\n#extension GL_ARB_shader_image_load_store : require\n\nprecision highp float;\n\nin vec4 vs_in_position;\n\nvoid main()\n{\n    gl_Position = vs_in_position;\n}\n";
const FRAGMENT_SHADER_CODE: &str = "#version 400 core\n#extension GL_ARB_shader_image_load_store : require\n\nprecision highp float;\n\nlayout(rgba8) writeonly uniform image2D u_complete_destination_image;\nlayout(rgba8) readonly  uniform image2D u_complete_source_image;\nlayout(rgba8) writeonly uniform image2D u_incomplete_destination_image;\nlayout(rgba8) readonly  uniform image2D u_incomplete_source_image;\n\nvoid main()\n{\n    vec4 complete_loaded_color   = imageLoad (u_complete_source_image,   ivec2(gl_FragCoord));\n    vec4 incomplete_loaded_color = imageLoad (u_incomplete_source_image, ivec2(gl_FragCoord));\n    imageStore(u_complete_destination_image,\n               ivec2(gl_FragCoord),\n               incomplete_loaded_color);\n    imageStore(u_incomplete_destination_image,\n               ivec2(gl_FragCoord),\n               complete_loaded_color);\n\n    discard;\n}\n";

const VERTEX_BUFFER_DATA: [f32; 16] = [
    -1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
];

const COMPLETE_DESTINATION_MAGIC_NUMBER: u8 = 0x11;
const COMPLETE_SOURCE_MAGIC_NUMBER: u8 = 0x22;
const INCOMPLETE_DESTINATION_MAGIC_NUMBER: u8 = 0x33;
const INCOMPLETE_SOURCE_MAGIC_NUMBER: u8 = 0x44;

const N_COMPONENTS: usize = 4;

/// `SetTexel`
fn set_texel(texel: &mut [u8], x_coordinate: u8, y_coordinate: u8, magic_number: u8) {
    texel[0] = x_coordinate;
    texel[1] = y_coordinate;
    texel[2] = magic_number;
    texel[3] = 0xcc;
}

/// The texture data both `Create2DRGBA8*Texture` functions upload.
fn texture_data_for(texture_edge: u32, magic_number: u8) -> Vec<u8> {
    let edge = texture_edge as usize;
    let mut texture_data = vec![0u8; edge * edge * N_COMPONENTS];
    for y in 0..edge {
        let line_offset = y * edge * N_COMPONENTS;
        for x in 0..edge {
            let texel_offset = x * N_COMPONENTS + line_offset;
            set_texel(&mut texture_data[texel_offset..], x as u8, y as u8, magic_number);
        }
    }
    texture_data
}

/// `Create2DRGBA8CompleteTexture` (`complete`) and `Create2DRGBA8IncompleteTexture`: the new texture, or the GL error that stopped it.
fn create_2d_rgba8_texture(
    gl: &glw::Functions,
    texture_edge: u32,
    magic_number: u8,
    complete: bool,
) -> Result<GLuint, GLenum> {
    let texture_data = texture_data_for(texture_edge, magic_number);
    let mut texture_id: GLuint = 0;
    gl!(gl.gen_textures(1, &mut texture_id));
    let err = gl!(gl.get_error());
    if err != glw::GL_NO_ERROR {
        return Err(err);
    }

    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture_id));
    let err = gl!(gl.get_error());
    if err != glw::GL_NO_ERROR {
        gl!(gl.delete_textures(1, &texture_id));
        return Err(err);
    }

    gl!(gl.tex_image_2d(
        glw::GL_TEXTURE_2D,
        0,
        glw::GL_RGBA8 as GLint,
        texture_edge as GLint,
        texture_edge as GLint,
        0,
        glw::GL_RGBA,
        glw::GL_UNSIGNED_BYTE,
        texture_data.as_ptr().cast()
    ));
    let err = gl!(gl.get_error());
    if err != glw::GL_NO_ERROR {
        gl!(gl.delete_textures(1, &texture_id));
        return Err(err);
    }

    gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_BASE_LEVEL, 0));
    if complete {
        gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_LEVEL, 0));
        gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as GLint));
    } else {
        gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_LEVEL, 7));
        gl!(gl.tex_parameteri(
            glw::GL_TEXTURE_2D,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST_MIPMAP_LINEAR as GLint
        ));
    }
    let err = gl!(gl.get_error());
    if err != glw::GL_NO_ERROR {
        gl!(gl.delete_textures(1, &texture_id));
        return Err(err);
    }

    Ok(texture_id)
}

fn expect_texture(result: Result<GLuint, GLenum>, message: &str) -> Result<GLuint, TestError> {
    result.map_err(|err| TestError::Fail(format!("{message} returned {}", glw::error_name(err))))
}

/// `BindTextureToImage`
fn bind_texture_to_image(
    gl: &glw::Functions,
    program_id: GLuint,
    texture_id: GLuint,
    level: GLint,
    image_unit: GLuint,
    uniform_name: &str,
) -> Result<(), TestError> {
    let image_uniform_location = uniform_location(gl, program_id, uniform_name);
    glu::expect_no_error(gl, "GetUniformLocation")?;
    if image_uniform_location == -1 {
        return Err(TestError::Fail(format!(
            "Uniform location is not available: {uniform_name}"
        )));
    }

    gl!(gl.bind_image_texture(
        image_unit,
        texture_id,
        level,
        glw::FALSE,
        0,
        glw::GL_READ_WRITE,
        glw::GL_RGBA8
    ));
    glu::expect_no_error(gl, "BindImageTexture")?;

    gl!(gl.uniform_1i(image_uniform_location, image_unit as GLint));
    glu::expect_no_error(gl, "Uniform1i")?;
    Ok(())
}

/// 3 ImageLoadStoreIncompleteTexturesTest
#[derive(Default)]
pub(super) struct ImageLoadStoreIncompleteTexturesTest {
    texture_edge: u32,
    complete_destination_texture_id: GLuint,
    complete_source_texture_id: GLuint,
    incomplete_destination_texture_id: GLuint,
    incomplete_source_texture_id: GLuint,
    program_id: GLuint,
    vertex_array_object_id: GLuint,
    vertex_buffer_id: GLuint,
}

impl ImageLoadStoreIncompleteTexturesTest {
    /// `CheckIfTextureIsBlack`
    fn check_if_texture_is_black(&self, gl: &glw::Functions, texture_id: GLuint) -> Result<bool, TestError> {
        let texture_data_size = (self.texture_edge * self.texture_edge) as usize * N_COMPONENTS;
        let mut texture_data = vec![0u8; texture_data_size];

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture_id));
        glu::expect_no_error(gl, "BindTexture")?;
        gl!(gl.get_tex_image(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            texture_data.as_mut_ptr().cast()
        ));
        glu::expect_no_error(gl, "GetTexImage")?;

        Ok(texture_data.iter().all(|&byte| byte == 0))
    }

    /// `CheckIfTextureWasModified`
    fn check_if_texture_was_modified(
        &self,
        gl: &glw::Functions,
        texture_id: GLuint,
        magic_number: u8,
    ) -> Result<bool, TestError> {
        let expected_texture_data = texture_data_for(self.texture_edge, magic_number);
        let mut texture_data = vec![0u8; expected_texture_data.len()];

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture_id));
        glu::expect_no_error(gl, "BindTexture")?;
        gl!(gl.get_tex_image(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            texture_data.as_mut_ptr().cast()
        ));
        glu::expect_no_error(gl, "GetTexImage")?;

        Ok(texture_data != expected_texture_data)
    }

    /// `Copy2DRGBA8Textures`
    fn copy_2d_rgba8_textures(&self, gl: &glw::Functions) -> Result<(), TestError> {
        gl!(gl.use_program(self.program_id));
        glu::expect_no_error(gl, "UseProgram")?;

        gl!(gl.bind_vertex_array(self.vertex_array_object_id));
        glu::expect_no_error(gl, "BindVertexArray")?;

        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vertex_buffer_id));
        glu::expect_no_error(gl, "BindBuffer")?;

        let name = CString::new("vs_in_position").expect("no NUL");
        let position_attribute_location = gl!(gl.get_attrib_location(self.program_id, name.as_ptr()));
        glu::expect_no_error(gl, "GetAttribLocation")?;
        if position_attribute_location == -1 {
            return Err(TestError::Fail(
                "Attribute location is not available: vs_in_position".to_string(),
            ));
        }
        gl!(gl.vertex_attrib_pointer(
            position_attribute_location as GLuint,
            4,
            glw::GL_FLOAT,
            glw::FALSE,
            0,
            std::ptr::null()
        ));
        glu::expect_no_error(gl, "VertexAttribPointer")?;
        gl!(gl.enable_vertex_attrib_array(position_attribute_location as GLuint));
        glu::expect_no_error(gl, "EnableVertexAttribArray")?;

        bind_texture_to_image(
            gl,
            self.program_id,
            self.complete_destination_texture_id,
            0,
            0,
            "u_complete_destination_image",
        )?;
        bind_texture_to_image(
            gl,
            self.program_id,
            self.complete_source_texture_id,
            0,
            1,
            "u_complete_source_image",
        )?;
        bind_texture_to_image(
            gl,
            self.program_id,
            self.incomplete_destination_texture_id,
            2,
            2,
            "u_incomplete_destination_image",
        )?;
        bind_texture_to_image(
            gl,
            self.program_id,
            self.incomplete_source_texture_id,
            2,
            3,
            "u_incomplete_source_image",
        )?;

        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        glu::expect_no_error(gl, "DrawArrays")?;
        Ok(())
    }
}

impl Subcase for ImageLoadStoreIncompleteTexturesTest {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut is_program_correct = true;

        // clean previous error
        gl!(gl.get_error());

        let (width, height) = window_size(context);
        self.texture_edge = 64.min(height.min(width)) as u32;

        self.complete_destination_texture_id = expect_texture(
            create_2d_rgba8_texture(gl, self.texture_edge, COMPLETE_DESTINATION_MAGIC_NUMBER, true),
            "Create2DRGBA8CompleteTexture",
        )?;
        self.complete_source_texture_id = expect_texture(
            create_2d_rgba8_texture(gl, self.texture_edge, COMPLETE_SOURCE_MAGIC_NUMBER, true),
            "Create2DRGBA8CompleteTexture",
        )?;
        self.incomplete_destination_texture_id = expect_texture(
            create_2d_rgba8_texture(gl, self.texture_edge, INCOMPLETE_DESTINATION_MAGIC_NUMBER, false),
            "Create2DRGBA8IncompleteTexture",
        )?;
        self.incomplete_source_texture_id = expect_texture(
            create_2d_rgba8_texture(gl, self.texture_edge, INCOMPLETE_SOURCE_MAGIC_NUMBER, false),
            "Create2DRGBA8IncompleteTexture",
        )?;

        gl!(gl.gen_buffers(1, &mut self.vertex_buffer_id));
        glu::expect_no_error(gl, "GenBuffers")?;
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.vertex_buffer_id));
        glu::expect_no_error(gl, "BindBuffer")?;
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(&VERTEX_BUFFER_DATA) as isize,
            VERTEX_BUFFER_DATA.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "BufferData")?;

        gl!(gl.gen_vertex_arrays(1, &mut self.vertex_array_object_id));
        glu::expect_no_error(gl, "GenVertexArrays")?;

        self.program_id = build_program_5(
            gl,
            Some(VERTEX_SHADER_CODE),
            None,
            None,
            None,
            Some(FRAGMENT_SHADER_CODE),
            Some(&mut is_program_correct),
        );
        if !is_program_correct {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut result = true;

        self.copy_2d_rgba8_textures(gl)?;
        gl!(gl.memory_barrier(glw::GL_ALL_BARRIER_BITS));

        if !self.check_if_texture_was_modified(
            gl,
            self.incomplete_destination_texture_id,
            INCOMPLETE_DESTINATION_MAGIC_NUMBER,
        )? {
            log::info!("Problem with imageStore, operation modified contents of incomplete texture");
            result = false;
        }
        if !self.check_if_texture_is_black(gl, self.complete_destination_texture_id)? {
            log::info!("Problem with imageLoad, operation returned non 0 result for incomplete texture");
            result = false;
        }

        Ok(if result { NO_ERROR } else { ERROR })
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.use_program(0));

        if self.program_id != 0 {
            gl!(gl.delete_program(self.program_id));
            self.program_id = 0;
        }
        for texture in [
            &mut self.complete_destination_texture_id,
            &mut self.complete_source_texture_id,
            &mut self.incomplete_destination_texture_id,
            &mut self.incomplete_source_texture_id,
        ] {
            if *texture != 0 {
                gl!(gl.delete_textures(1, texture));
                *texture = 0;
            }
        }
        if self.vertex_array_object_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &self.vertex_array_object_id));
            self.vertex_array_object_id = 0;
        }
        if self.vertex_buffer_id != 0 {
            gl!(gl.delete_buffers(1, &self.vertex_buffer_id));
            self.vertex_buffer_id = 0;
        }
        Ok(NO_ERROR)
    }
}
