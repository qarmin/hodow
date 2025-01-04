// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderImageLoadStoreTests.cpp  (ImageLoadStoreNonLayeredBindingTest)
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
const FRAGMENT_SHADER_CODE: &str = "#version 400 core\n#extension GL_ARB_shader_image_load_store : require\n\nprecision highp float;\n\nlayout(rgba8) writeonly uniform image2D u_destination_image;\nlayout(rgba8) readonly  uniform image2D u_source_image;\n\nvoid main()\n{\n    vec4 loaded_color = imageLoad (u_source_image,      ivec2(gl_FragCoord));\n                        imageStore(u_destination_image, ivec2(gl_FragCoord), loaded_color);\n\n    discard;\n}\n";

const VERTEX_BUFFER_DATA: [f32; 16] = [
    -1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
];

const N_COMPONENTS: usize = 4;

/// `GetLayersPerElement`
fn get_layers_per_element(target: GLenum) -> Result<u32, TestError> {
    match target {
        glw::GL_TEXTURE_2D_ARRAY | glw::GL_TEXTURE_3D => Ok(1),
        glw::GL_TEXTURE_CUBE_MAP | glw::GL_TEXTURE_CUBE_MAP_ARRAY => Ok(6),
        _ => Err(TestError::Fail("Not supported texture type".to_string())),
    }
}

/// `GetTotalNumberOfLayers`
fn get_total_number_of_layers(n_elements: u32, target: GLenum) -> Result<u32, TestError> {
    Ok(get_layers_per_element(target)? * n_elements)
}

/// The cube map faces in the order the texture data stores their layers.
const CUBE_FACES: [GLenum; 6] = [
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
];

/// `CreateRGBA8Texture`: the new texture, or the GL error that stopped it.
fn create_rgba8_texture(
    gl: &glw::Functions,
    edge: u32,
    target: GLenum,
    n_layers: u32,
    texture_data: &[u8],
) -> Result<GLuint, GLenum> {
    let mut texture_id: GLuint = 0;
    gl!(gl.gen_textures(1, &mut texture_id));
    let err = gl!(gl.get_error());
    if err != glw::GL_NO_ERROR {
        return Err(err);
    }

    gl!(gl.bind_texture(target, texture_id));
    let err = gl!(gl.get_error());
    if err != glw::GL_NO_ERROR {
        gl!(gl.delete_textures(1, &texture_id));
        return Err(err);
    }

    if target != glw::GL_TEXTURE_CUBE_MAP {
        gl!(gl.tex_image_3d(
            target,
            0,
            glw::GL_RGBA8 as GLint,
            edge as GLint,
            edge as GLint,
            n_layers as GLint,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            texture_data.as_ptr().cast()
        ));
    } else {
        let layer_size = edge as usize * edge as usize * N_COMPONENTS;
        for (index, face) in CUBE_FACES.into_iter().enumerate() {
            gl!(gl.tex_image_2d(
                face,
                0,
                glw::GL_RGBA8 as GLint,
                edge as GLint,
                edge as GLint,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                texture_data[index * layer_size..].as_ptr().cast()
            ));
        }
    }
    let err = gl!(gl.get_error());
    if err != glw::GL_NO_ERROR {
        gl!(gl.delete_textures(1, &texture_id));
        return Err(err);
    }

    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_BASE_LEVEL, 0));
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MAX_LEVEL, 0));
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as GLint));
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

/// `CreateRGBA8DestinationTexture`
fn create_rgba8_destination_texture(
    gl: &glw::Functions,
    edge: u32,
    n_elements: u32,
    target: GLenum,
) -> Result<GLuint, TestError> {
    let layer_size = edge as usize * edge as usize * N_COMPONENTS;
    let n_layers = get_total_number_of_layers(n_elements, target)?;
    let texture_data = vec![0u8; layer_size * n_layers as usize];
    expect_texture(
        create_rgba8_texture(gl, edge, target, n_layers, &texture_data),
        "Create2DR8UIDestinationTexture",
    )
}

/// `CreateRGBA8SourceTexture`
fn create_rgba8_source_texture(
    gl: &glw::Functions,
    edge: u32,
    n_elements: u32,
    target: GLenum,
) -> Result<GLuint, TestError> {
    let layer_size = edge as usize * edge as usize * N_COMPONENTS;
    let n_layers = get_total_number_of_layers(n_elements, target)?;
    let mut texture_data = vec![0u8; layer_size * n_layers as usize];
    let mut texel = [0u8, 0, 0, 0xaa];
    for layer in 0..n_layers as usize {
        let layer_offset = layer_size * layer;
        texel[2] = layer as u8;
        for y in 0..edge as usize {
            let line_offset = y * edge as usize * N_COMPONENTS + layer_offset;
            texel[1] = y as u8;
            for x in 0..edge as usize {
                let texel_offset = x * N_COMPONENTS + line_offset;
                texel[0] = x as u8;
                texture_data[texel_offset..texel_offset + N_COMPONENTS].copy_from_slice(&texel);
            }
        }
    }
    expect_texture(
        create_rgba8_texture(gl, edge, target, n_layers, &texture_data),
        "Create2DR8UISourceTexture",
    )
}

/// `ExtractTextureData`
fn extract_texture_data(
    gl: &glw::Functions,
    texture_id: GLuint,
    edge: u32,
    n_layers: u32,
    target: GLenum,
) -> Result<Vec<u8>, TestError> {
    let texture_data_size = edge as usize * edge as usize * n_layers as usize * N_COMPONENTS;
    let mut texture_data = vec![0u8; texture_data_size];

    gl!(gl.bind_texture(target, texture_id));
    glu::expect_no_error(gl, "BindTexture")?;
    if target != glw::GL_TEXTURE_CUBE_MAP {
        gl!(gl.get_tex_image(
            target,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            texture_data.as_mut_ptr().cast()
        ));
    } else {
        let layer_size = edge as usize * edge as usize * N_COMPONENTS;
        for (index, face) in CUBE_FACES.into_iter().enumerate() {
            gl!(gl.get_tex_image(
                face,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                texture_data[index * layer_size..].as_mut_ptr().cast()
            ));
        }
    }
    glu::expect_no_error(gl, "GetTexImage")?;
    Ok(texture_data)
}

/// `CompareRGBA8Textures`
fn compare_rgba8_textures(
    gl: &glw::Functions,
    left_texture_id: GLuint,
    right_texture_id: GLuint,
    edge: u32,
    n_layers: u32,
    target: GLenum,
) -> Result<bool, TestError> {
    let left_texture_data = extract_texture_data(gl, left_texture_id, edge, n_layers, target)?;
    let right_texture_data = extract_texture_data(gl, right_texture_id, edge, n_layers, target)?;
    Ok(left_texture_data == right_texture_data)
}

/// `BindTextureToImage`
fn bind_texture_to_image(
    gl: &glw::Functions,
    program_id: GLuint,
    texture_id: GLuint,
    image_unit: GLuint,
    layer: GLuint,
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
        0,
        glw::FALSE,
        layer as GLint,
        glw::GL_READ_WRITE,
        glw::GL_RGBA8
    ));
    glu::expect_no_error(gl, "BindImageTexture")?;

    gl!(gl.uniform_1i(image_uniform_location, image_unit as GLint));
    glu::expect_no_error(gl, "Uniform1i")?;
    Ok(())
}

/// 2 ImageLoadStoreNonLayeredBindingTest
#[derive(Default)]
pub(super) struct ImageLoadStoreNonLayeredBindingTest {
    destination_texture_id: GLuint,
    program_id: GLuint,
    source_texture_id: GLuint,
    vertex_array_object_id: GLuint,
    vertex_buffer_id: GLuint,
    /// (edge, n_elements, target)
    texture_shape_definitions: Vec<(u32, u32, GLenum)>,
}

impl ImageLoadStoreNonLayeredBindingTest {
    /// `CopyRGBA8TextureLayer`
    fn copy_rgba8_texture_layer(
        &self,
        gl: &glw::Functions,
        destination_texture_id: GLuint,
        source_texture_id: GLuint,
        layer: GLuint,
    ) -> Result<(), TestError> {
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
            destination_texture_id,
            0,
            layer,
            "u_destination_image",
        )?;
        bind_texture_to_image(gl, self.program_id, source_texture_id, 1, layer, "u_source_image")?;

        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        glu::expect_no_error(gl, "DrawArrays")?;
        Ok(())
    }
}

impl Subcase for ImageLoadStoreNonLayeredBindingTest {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut is_program_correct = true;

        let (width, height) = window_size(context);
        let texture_edge = 64.min(height.min(width)) as u32;
        self.texture_shape_definitions
            .push((texture_edge, 6, glw::GL_TEXTURE_2D_ARRAY));
        self.texture_shape_definitions
            .push((texture_edge, 6, glw::GL_TEXTURE_3D));
        self.texture_shape_definitions
            .push((texture_edge, 1, glw::GL_TEXTURE_CUBE_MAP));
        self.texture_shape_definitions
            .push((texture_edge, 3, glw::GL_TEXTURE_CUBE_MAP_ARRAY));

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

        for &(edge, n_elements, target) in &self.texture_shape_definitions {
            let n_layers = get_total_number_of_layers(n_elements, target)?;

            self.destination_texture_id = create_rgba8_destination_texture(gl, edge, n_elements, target)?;
            self.source_texture_id = create_rgba8_source_texture(gl, edge, n_elements, target)?;

            for layer in 0..n_layers {
                self.copy_rgba8_texture_layer(gl, self.destination_texture_id, self.source_texture_id, layer)?;
            }
            gl!(gl.memory_barrier(glw::GL_TEXTURE_UPDATE_BARRIER_BIT));

            if !compare_rgba8_textures(
                gl,
                self.destination_texture_id,
                self.source_texture_id,
                edge,
                n_layers,
                target,
            )? {
                let texture_type = match target {
                    glw::GL_TEXTURE_2D_ARRAY => "2d array",
                    glw::GL_TEXTURE_3D => "3d",
                    glw::GL_TEXTURE_CUBE_MAP => "Cube map",
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY => "Cube map array",
                    _ => "",
                };
                log::info!(
                    "Copy  with imageLoad and imageStore failed for texture type: {texture_type}. Source and destination textures are different"
                );
                result = false;
            }

            gl!(gl.delete_textures(1, &self.destination_texture_id));
            gl!(gl.delete_textures(1, &self.source_texture_id));
            self.destination_texture_id = 0;
            self.source_texture_id = 0;
        }

        Ok(if result { NO_ERROR } else { ERROR })
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, 0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_3D, 0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, 0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.use_program(0));

        if self.program_id != 0 {
            gl!(gl.delete_program(self.program_id));
            self.program_id = 0;
        }
        if self.destination_texture_id != 0 {
            gl!(gl.delete_textures(1, &self.destination_texture_id));
            self.destination_texture_id = 0;
        }
        if self.source_texture_id != 0 {
            gl!(gl.delete_textures(1, &self.source_texture_id));
            self.source_texture_id = 0;
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
