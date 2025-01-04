// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayColorDepthAttachments.cpp
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayColorDepthAttachments.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Desktop only: the depth data is always verified (upstream skips it on ES contexts).

use super::TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `GEOMETRY_SHADER_EXTENSION_NOT_SUPPORTED`
const GEOMETRY_SHADER_EXTENSION_NOT_SUPPORTED: &str = "Geometry shader functionality not supported, skipping";

const FRAGMENT_SHADER_CODE: &str = "${VERSION}\n/* FS */\n\nprecision highp float;\n\nin flat int fs_in_color;\n\nlayout(location = 0) out int fs_out_color;\n\nvoid main()\n{\n    fs_out_color = fs_in_color;\n}\n\n";

const GEOMETRY_SHADER_CODE_PREAMBLE: &str = "${VERSION}\n/* Layered GS */\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout(points)                         in;\nlayout(triangle_strip, max_vertices=4) out;\n\n";

const GEOMETRY_SHADER_CODE_LAYERED: &str =
    "in  flat int vs_out_layer[];\n\nout flat int fs_in_color;\n\nvoid main()\n{\n    int   layer = vs_out_layer[0];\n";

const GEOMETRY_SHADER_CODE_NON_LAYERED: &str =
    "uniform  int uni_layer;\n\nout flat int fs_in_color;\n\nvoid main()\n{\n    int   layer = uni_layer;\n";

const GEOMETRY_SHADER_CODE_BODY: &str = ";\n    \n    // Left-Bottom\n    gl_Position = vec4(-1.0, -1.0, depth, 1);\n    gl_Layer    = layer;\n    fs_in_color = layer;\n    EmitVertex();\n    \n    // Left-Top\n    gl_Position = vec4(-1.0,  1.0, depth, 1);\n    gl_Layer    = layer;\n    fs_in_color = layer;\n    EmitVertex();\n    \n    // Right-Bottom\n    gl_Position = vec4( 1.0, -1.0, depth, 1);\n    gl_Layer    = layer;\n    fs_in_color = layer;\n    EmitVertex();\n    \n    // Right-Top\n    gl_Position = vec4( 1.0,  1.0, depth, 1);\n    gl_Layer    = layer;\n    fs_in_color = layer;\n    EmitVertex();\n    EndPrimitive();\n}\n\n";

const VERTEX_SHADER_CODE: &str = "${VERSION}\n/* VS */\n\nprecision highp float;\n\nflat out int vs_out_layer;\n\nvoid main()\n{\n    gl_PointSize = 1.0f;\n    vs_out_layer = gl_VertexID;\n}\n\n";

const COLOR_INTERNAL_FORMAT: GLenum = glw::GL_R32I;
const COLOR_FORMAT: GLenum = glw::GL_RED_INTEGER;
const COLOR_TYPE: GLenum = glw::GL_INT;
const DEPTH_FORMAT: GLenum = glw::GL_DEPTH_COMPONENT;

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

/// `_texture_size`
#[derive(Clone, Copy)]
struct TextureSize {
    size: GLuint,
    n_cubemaps: GLuint,
}

/// `verifyImage`
fn verify_image<T: PartialEq, const N: usize>(
    image_width: GLuint,
    image_height: GLuint,
    components: &[T; N],
    image: &[T],
) -> bool {
    let line_size = image_width as usize * N;
    for y in 0..image_height as usize {
        let line_offset = y * line_size;
        for x in 0..image_width as usize {
            let pixel_offset = line_offset + x * N;
            for component in 0..N {
                if image[pixel_offset + component] != components[component] {
                    return false;
                }
            }
        }
    }
    true
}

/// `TextureCubeMapArrayColorDepthAttachmentsTest` (Test 2)
pub(super) struct ColorDepthAttachments {
    pub(super) ext_params: ExtParameters,
}

#[derive(Default)]
struct Objects {
    vao_id: GLuint,
    color_texture_id: GLuint,
    depth_texture_id: GLuint,
    fragment_shader_id: GLuint,
    framebuffer_object_id: GLuint,
    layered_geometry_shader_id: GLuint,
    layered_program_id: GLuint,
    non_layered_geometry_shader_id: GLuint,
    non_layered_program_id: GLuint,
    non_layered_program_id_uni_layer_uniform_location: GLint,
    vertex_shader_id: GLuint,
}

struct Runner<'a> {
    context: &'a Context,
    base: &'a TestCaseBase,
    o: Objects,
    resolutions: Vec<TextureSize>,
    depth_internal_format: GLenum,
    depth_type: GLenum,
    n_invalid_color_checks: u32,
    n_invalid_depth_checks: u32,
}

impl Runner<'_> {
    /// `configureLayeredFramebufferAttachment`
    fn configure_layered_framebuffer_attachment(
        &self,
        texture_id: GLuint,
        should_use_as_color_attachment: bool,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();
        let attachment = if should_use_as_color_attachment {
            glw::GL_COLOR_ATTACHMENT0
        } else {
            glw::GL_DEPTH_ATTACHMENT
        };

        gl_call!(
            gl,
            "glBindFramebuffer() call failed.",
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, self.o.framebuffer_object_id)
        );
        gl_call!(
            gl,
            "glFramebufferTextureEXT() call failed.",
            gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, attachment, texture_id, 0)
        );
        Ok(())
    }

    /// `configureNonLayeredFramebufferAttachment`
    fn configure_non_layered_framebuffer_attachment(
        &self,
        texture_id: GLuint,
        n_layer: GLuint,
        should_use_as_color_attachment: bool,
        should_update_draw_framebuffer: bool,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();
        let attachment_type = if should_use_as_color_attachment {
            glw::GL_COLOR_ATTACHMENT0
        } else {
            glw::GL_DEPTH_ATTACHMENT
        };
        let framebuffer_target = if should_update_draw_framebuffer {
            glw::GL_DRAW_FRAMEBUFFER
        } else {
            glw::GL_READ_FRAMEBUFFER
        };

        gl_call!(
            gl,
            "glBindFramebuffer() call failed.",
            gl.bind_framebuffer(framebuffer_target, self.o.framebuffer_object_id)
        );
        gl_call!(
            gl,
            "glFramebufferTextureLayer() call failed.",
            gl.framebuffer_texture_layer(framebuffer_target, attachment_type, texture_id, 0, n_layer as GLint)
        );
        Ok(())
    }

    /// `deinit`
    fn deinit(&mut self) {
        if !self.base.is_texture_cube_map_array_supported || !self.base.is_geometry_shader_extension_supported {
            return;
        }
        let gl = self.context.gl();

        let (color, depth) = (self.o.color_texture_id, self.o.depth_texture_id);
        let _ = self.release_and_detach_texture_object(color, true);
        let _ = self.release_and_detach_texture_object(depth, false);
        self.o.color_texture_id = 0;
        self.o.depth_texture_id = 0;

        // SAFETY: restores state and deletes names this test created, on the current context.
        unsafe {
            gl.use_program(0);
            gl.bind_vertex_array(0);

            for id in [
                &mut self.o.fragment_shader_id,
                &mut self.o.layered_geometry_shader_id,
                &mut self.o.non_layered_geometry_shader_id,
                &mut self.o.vertex_shader_id,
            ] {
                if *id != 0 {
                    gl.delete_shader(*id);
                    *id = 0;
                }
            }
            for id in [&mut self.o.layered_program_id, &mut self.o.non_layered_program_id] {
                if *id != 0 {
                    gl.delete_program(*id);
                    *id = 0;
                }
            }
            if self.o.framebuffer_object_id != 0 {
                gl.delete_framebuffers(1, &self.o.framebuffer_object_id);
                self.o.framebuffer_object_id = 0;
            }
            if self.o.vao_id != 0 {
                gl.delete_vertex_arrays(1, &self.o.vao_id);
                self.o.vao_id = 0;
            }
        }
    }

    /// `determineSupportedDepthFormat`
    fn determine_supported_depth_format(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();

        self.depth_internal_format = glw::GL_DEPTH_COMPONENT16;
        self.depth_type = glw::GL_UNSIGNED_SHORT;

        loop {
            self.generate_and_configure_texture_objects(8, 1, false)?;

            self.configure_non_layered_framebuffer_attachment(self.o.color_texture_id, 0, true, true)?;
            self.configure_non_layered_framebuffer_attachment(self.o.depth_texture_id, 0, false, true)?;

            // SAFETY: plain status query.
            let framebuffer_status = unsafe { gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) };
            if framebuffer_status == glw::GL_FRAMEBUFFER_COMPLETE {
                return Ok(());
            }

            match self.depth_internal_format {
                glw::GL_DEPTH_COMPONENT16 => {
                    self.depth_internal_format = glw::GL_DEPTH_COMPONENT24;
                    self.depth_type = glw::GL_UNSIGNED_INT;
                }
                glw::GL_DEPTH_COMPONENT24 => {
                    self.depth_internal_format = glw::GL_DEPTH_COMPONENT32F;
                    self.depth_type = glw::GL_FLOAT;
                }
                glw::GL_DEPTH_COMPONENT32F => {
                    return Err(TestError::NotSupported(
                        "Implementation does not support any known depth format".to_string(),
                    ));
                }
                _ => return Err(TestError::Fail("Unrecognized depth internalformat".to_string())),
            }
        }
    }

    /// `draw`
    fn draw(&self, texture_size: TextureSize) -> Result<(), TestError> {
        let gl = self.context.gl();

        gl_call!(
            gl,
            "glViewport() call failed.",
            gl.viewport(0, 0, texture_size.size as GLint, texture_size.size as GLint)
        );
        gl_call!(
            gl,
            "glClear() call failed.",
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT)
        );
        gl_call!(
            gl,
            "drawArrays",
            gl.draw_arrays(glw::GL_POINTS, 0, (texture_size.n_cubemaps * 6) as GLint)
        );
        Ok(())
    }

    /// `generateAndConfigureTextureObjects`
    fn generate_and_configure_texture_objects(
        &mut self,
        texture_width: GLuint,
        n_cubemaps: GLuint,
        should_generate_mutable_textures: bool,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();

        let (color, depth) = (self.o.color_texture_id, self.o.depth_texture_id);
        self.release_and_detach_texture_object(color, true)?;
        self.release_and_detach_texture_object(depth, false)?;

        // SAFETY: names are written into the two fields.
        unsafe {
            gl.gen_textures(1, &mut self.o.color_texture_id);
            gl.gen_textures(1, &mut self.o.depth_texture_id);
        }
        glu::expect_no_error(gl, "glGenTextures() call(s) failed")?;

        if should_generate_mutable_textures {
            self.prepare_mutable_texture_object(self.o.color_texture_id, texture_width, n_cubemaps, true)?;
            self.prepare_mutable_texture_object(self.o.depth_texture_id, texture_width, n_cubemaps, false)?;
        } else {
            self.prepare_immutable_texture_object(self.o.color_texture_id, texture_width, n_cubemaps, true)?;
            self.prepare_immutable_texture_object(self.o.depth_texture_id, texture_width, n_cubemaps, false)?;
        }
        Ok(())
    }

    /// `initTest`
    fn init_test(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();

        if !self.base.is_texture_cube_map_array_supported {
            return Err(TestError::NotSupported(
                TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }
        if !self.base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                GEOMETRY_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        gl_call!(
            gl,
            "Could not generate vertex array object",
            gl.gen_vertex_arrays(1, &mut self.o.vao_id)
        );
        gl_call!(
            gl,
            "Error binding vertex array object!",
            gl.bind_vertex_array(self.o.vao_id)
        );
        gl_call!(
            gl,
            "genFramebuffers",
            gl.gen_framebuffers(1, &mut self.o.framebuffer_object_id)
        );

        self.determine_supported_depth_format()?;

        let depth_calculation_code = match self.depth_internal_format {
            glw::GL_DEPTH_COMPONENT16 => "-1.0 + float(2 * layer) / float(0xffff)",
            glw::GL_DEPTH_COMPONENT24 => "-1.0 + float(2 * layer) / float(0xffffff)",
            glw::GL_DEPTH_COMPONENT32F => "-1.0 + float(2 * layer) / 256.0",
            _ => return Err(TestError::Fail("Unrecognized depth internal format".to_string())),
        };

        // SAFETY: object creation on the current context.
        unsafe {
            self.o.fragment_shader_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            self.o.layered_geometry_shader_id = gl.create_shader(self.base.gl_ext_tokens.geometry_shader);
            self.o.non_layered_geometry_shader_id = gl.create_shader(self.base.gl_ext_tokens.geometry_shader);
            self.o.vertex_shader_id = gl.create_shader(glw::GL_VERTEX_SHADER);
        }
        glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;

        // SAFETY: object creation on the current context.
        unsafe {
            self.o.layered_program_id = gl.create_program();
            self.o.non_layered_program_id = gl.create_program();
        }
        glu::expect_no_error(gl, "glCreateProgram() call(s) failed")?;

        let layered_geometry_shader_parts = [
            GEOMETRY_SHADER_CODE_PREAMBLE,
            GEOMETRY_SHADER_CODE_LAYERED,
            "    float depth = ",
            depth_calculation_code,
            GEOMETRY_SHADER_CODE_BODY,
        ];
        let non_layered_geometry_shader_parts = [
            GEOMETRY_SHADER_CODE_PREAMBLE,
            GEOMETRY_SHADER_CODE_NON_LAYERED,
            "    float depth = ",
            depth_calculation_code,
            GEOMETRY_SHADER_CODE_BODY,
        ];
        let fragment_parts = [FRAGMENT_SHADER_CODE];
        let vertex_parts = [VERTEX_SHADER_CODE];

        let built = self.base.build_program(
            self.context,
            self.o.layered_program_id,
            &[
                ShaderBody::Source(self.o.fragment_shader_id, &fragment_parts),
                ShaderBody::Source(self.o.layered_geometry_shader_id, &layered_geometry_shader_parts),
                ShaderBody::Source(self.o.vertex_shader_id, &vertex_parts),
            ],
        )?;
        if !built.0 {
            return Err(TestError::Fail(
                "Could not build layered-case program object".to_string(),
            ));
        }

        let built = self.base.build_program(
            self.context,
            self.o.non_layered_program_id,
            &[
                ShaderBody::Source(self.o.fragment_shader_id, &fragment_parts),
                ShaderBody::Source(
                    self.o.non_layered_geometry_shader_id,
                    &non_layered_geometry_shader_parts,
                ),
                ShaderBody::Source(self.o.vertex_shader_id, &vertex_parts),
            ],
        )?;
        if !built.0 {
            return Err(TestError::Fail(
                "Could not build non-layered-case program object".to_string(),
            ));
        }

        // SAFETY: a linked program and a NUL-terminated name.
        self.o.non_layered_program_id_uni_layer_uniform_location =
            unsafe { gl.get_uniform_location(self.o.non_layered_program_id, c"uni_layer".as_ptr()) };
        // SAFETY: plain error query.
        if self.o.non_layered_program_id_uni_layer_uniform_location == -1
            || unsafe { gl.get_error() } != glw::GL_NO_ERROR
        {
            return Err(TestError::Fail(
                "Could not retrieve location of uni_layer uniform for non-layered program".to_string(),
            ));
        }
        Ok(())
    }

    /// `prepareImmutableTextureObject`
    fn prepare_immutable_texture_object(
        &self,
        texture_id: GLuint,
        texture_size: GLuint,
        n_cubemaps: GLuint,
        should_take_color_texture_properties: bool,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();
        let internal_format = if should_take_color_texture_properties {
            COLOR_INTERNAL_FORMAT
        } else {
            self.depth_internal_format
        };

        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, texture_id)
        );
        gl_call!(
            gl,
            "glTexStorage3D() call failed.",
            gl.tex_storage_3d(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                1,
                internal_format,
                texture_size as GLint,
                texture_size as GLint,
                (n_cubemaps * 6) as GLint
            )
        );
        Ok(())
    }

    /// `prepareMutableTextureObject`
    fn prepare_mutable_texture_object(
        &self,
        texture_id: GLuint,
        texture_size: GLuint,
        n_cubemaps: GLuint,
        should_take_color_texture_properties: bool,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();
        let (internal_format, format, type_) = if should_take_color_texture_properties {
            (COLOR_INTERNAL_FORMAT, COLOR_FORMAT, COLOR_TYPE)
        } else {
            (self.depth_internal_format, DEPTH_FORMAT, self.depth_type)
        };

        gl_call!(
            gl,
            "glBindTexture() call failed",
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, texture_id)
        );
        gl_call!(
            gl,
            "glTexImage3D() call failed",
            gl.tex_image_3d(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                0,
                internal_format as GLint,
                texture_size as GLint,
                texture_size as GLint,
                (n_cubemaps * 6) as GLint,
                0,
                format,
                type_,
                std::ptr::null()
            )
        );
        gl_call!(
            gl,
            "glTexParameteri() call failed",
            gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP_ARRAY, glw::GL_TEXTURE_MAX_LEVEL, 0)
        );
        Ok(())
    }

    /// `releaseAndDetachTextureObject`
    fn release_and_detach_texture_object(
        &self,
        texture_id: GLuint,
        is_color_attachment: bool,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();
        let attachment = if is_color_attachment {
            glw::GL_COLOR_ATTACHMENT0
        } else {
            glw::GL_DEPTH_ATTACHMENT
        };

        gl_call!(
            gl,
            "glBindFramebuffer() call failed.",
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, self.o.framebuffer_object_id)
        );
        gl_call!(
            gl,
            "glFramebufferTexture2D() call failed.",
            gl.framebuffer_texture_2d(glw::GL_DRAW_FRAMEBUFFER, attachment, glw::GL_TEXTURE_2D, 0, 0)
        );
        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0)
        );
        gl_call!(
            gl,
            "glDeleteTextures() call failed.",
            gl.delete_textures(1, &texture_id)
        );
        Ok(())
    }

    /// The color and depth verification both rendering tests end with.
    fn verify_layer_face(&mut self, texture_size: TextureSize, n_layer_face: GLuint) -> Result<(), TestError> {
        self.configure_non_layered_framebuffer_attachment(self.o.color_texture_id, n_layer_face, true, false)?;
        self.configure_non_layered_framebuffer_attachment(self.o.depth_texture_id, n_layer_face, false, false)?;

        let is_color_data_ok = self.verify_color_data(texture_size, n_layer_face)?;
        let is_depth_data_ok = match self.depth_internal_format {
            glw::GL_DEPTH_COMPONENT16 => self.verify_depth16_data(texture_size, n_layer_face)?,
            glw::GL_DEPTH_COMPONENT24 => self.verify_depth24_data(texture_size, n_layer_face)?,
            glw::GL_DEPTH_COMPONENT32F => self.verify_depth32f_data(texture_size, n_layer_face)?,
            _ => return Err(TestError::Fail("Unrecognized depth internalformat".to_string())),
        };

        if !is_color_data_ok {
            self.n_invalid_color_checks += 1;
        }
        if !is_depth_data_ok {
            self.n_invalid_depth_checks += 1;
        }
        Ok(())
    }

    /// `testLayeredRendering`
    fn test_layered_rendering(
        &mut self,
        texture_size: TextureSize,
        should_use_mutable_textures: bool,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();

        self.generate_and_configure_texture_objects(
            texture_size.size,
            texture_size.n_cubemaps,
            should_use_mutable_textures,
        )?;

        self.configure_layered_framebuffer_attachment(self.o.color_texture_id, true)?;
        self.configure_layered_framebuffer_attachment(self.o.depth_texture_id, false)?;

        gl_call!(
            gl,
            "glUseProgram() call failed.",
            gl.use_program(self.o.layered_program_id)
        );

        self.draw(texture_size)?;

        self.configure_layered_framebuffer_attachment(0, true)?;
        self.configure_layered_framebuffer_attachment(0, false)?;

        gl_call!(
            gl,
            "glBindFramebuffer() call failed.",
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0)
        );
        gl_call!(
            gl,
            "glBindFramebuffer() call failed.",
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, self.o.framebuffer_object_id)
        );

        for n_layer_face in 0..texture_size.n_cubemaps * 6 {
            self.verify_layer_face(texture_size, n_layer_face)?;
        }
        Ok(())
    }

    /// `testNonLayeredRendering`
    fn test_non_layered_rendering(
        &mut self,
        texture_size: TextureSize,
        should_use_mutable_texture: bool,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();

        gl_call!(
            gl,
            "glUseProgram() call failed.",
            gl.use_program(self.o.non_layered_program_id)
        );

        self.generate_and_configure_texture_objects(
            texture_size.size,
            texture_size.n_cubemaps,
            should_use_mutable_texture,
        )?;

        for n_layer_face in 0..texture_size.n_cubemaps * 6 {
            self.configure_non_layered_framebuffer_attachment(self.o.color_texture_id, n_layer_face, true, true)?;
            self.configure_non_layered_framebuffer_attachment(self.o.depth_texture_id, n_layer_face, false, true)?;

            gl_call!(
                gl,
                "glUniform1i() call failed.",
                gl.uniform_1i(
                    self.o.non_layered_program_id_uni_layer_uniform_location,
                    n_layer_face as GLint
                )
            );

            self.draw(texture_size)?;

            self.configure_non_layered_framebuffer_attachment(0, 0, true, true)?;
            self.configure_non_layered_framebuffer_attachment(0, 0, false, true)?;

            gl_call!(
                gl,
                "glBindFramebuffer() call failed.",
                gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0)
            );
            gl_call!(
                gl,
                "glBindFramebuffer() call failed.",
                gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, self.o.framebuffer_object_id)
            );

            self.verify_layer_face(texture_size, n_layer_face)?;
        }
        Ok(())
    }

    /// `verifyColorData`
    fn verify_color_data(&self, texture_size: TextureSize, n_layer: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let mut result_data = vec![0u32; (texture_size.size * texture_size.size * 4) as usize];

        gl_call!(
            gl,
            "glReadPixels() call failed",
            gl.read_pixels(
                0,
                0,
                texture_size.size as GLint,
                texture_size.size as GLint,
                glw::GL_RGBA_INTEGER,
                COLOR_TYPE,
                result_data.as_mut_ptr().cast()
            )
        );

        Ok(verify_image::<u32, 4>(
            texture_size.size,
            texture_size.size,
            &[n_layer, 0, 0, 1],
            &result_data,
        ))
    }

    /// `verifyDepth16Data`
    fn verify_depth16_data(&self, texture_size: TextureSize, n_layer: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let expected_value = n_layer as u16;
        let mut result_data = vec![0u16; (texture_size.size * texture_size.size) as usize];

        gl_call!(
            gl,
            "glPixelStorei() call failed",
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 2)
        );
        gl_call!(
            gl,
            "glReadPixels() call failed",
            gl.read_pixels(
                0,
                0,
                texture_size.size as GLint,
                texture_size.size as GLint,
                DEPTH_FORMAT,
                self.depth_type,
                result_data.as_mut_ptr().cast()
            )
        );

        let result = verify_image::<u16, 1>(texture_size.size, texture_size.size, &[expected_value], &result_data);

        gl_call!(
            gl,
            "glPixelStorei() call failed",
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 4)
        );
        Ok(result)
    }

    /// `verifyDepth24Data`
    fn verify_depth24_data(&self, texture_size: TextureSize, n_layer: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let expected_value = n_layer << 8;
        let mut result_data = vec![0u32; (texture_size.size * texture_size.size) as usize];

        gl_call!(
            gl,
            "glReadPixels() call failed",
            gl.read_pixels(
                0,
                0,
                texture_size.size as GLint,
                texture_size.size as GLint,
                DEPTH_FORMAT,
                self.depth_type,
                result_data.as_mut_ptr().cast()
            )
        );

        Ok(verify_image::<u32, 1>(
            texture_size.size,
            texture_size.size,
            &[expected_value],
            &result_data,
        ))
    }

    /// `verifyDepth32FData`
    fn verify_depth32f_data(&self, texture_size: TextureSize, n_layer: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let expected_value = n_layer as f32 / 256.0;
        let mut result_data = vec![0f32; (texture_size.size * texture_size.size) as usize];

        gl_call!(
            gl,
            "glReadPixels() call failed",
            gl.read_pixels(
                0,
                0,
                texture_size.size as GLint,
                texture_size.size as GLint,
                DEPTH_FORMAT,
                self.depth_type,
                result_data.as_mut_ptr().cast()
            )
        );

        Ok(verify_image::<f32, 1>(
            texture_size.size,
            texture_size.size,
            &[expected_value],
            &result_data,
        ))
    }

    fn run(&mut self) -> Result<bool, TestError> {
        let gl = self.context.gl();

        self.init_test()?;

        gl_call!(gl, "glClearColor() call failed.", gl.clear_color(0.0, 0.0, 0.0, 0.0));
        gl_call!(gl, "glClearDepthf() call failed.", gl.clear_depthf(1.0));
        gl_call!(gl, "glEnable() call failed", gl.enable(glw::GL_DEPTH_TEST));

        for texture_size in self.resolutions.clone() {
            self.test_non_layered_rendering(texture_size, false)?;
            self.test_non_layered_rendering(texture_size, true)?;
            self.test_layered_rendering(texture_size, false)?;
            self.test_layered_rendering(texture_size, true)?;
        }

        Ok(self.n_invalid_color_checks == 0 && self.n_invalid_depth_checks == 0)
    }
}

impl TestCase for ColorDepthAttachments {
    fn name(&self) -> &str {
        "color_depth_attachments"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        let mut runner = Runner {
            context,
            base: &base,
            o: Objects::default(),
            resolutions: vec![
                TextureSize { size: 8, n_cubemaps: 8 },
                TextureSize {
                    size: 64,
                    n_cubemaps: 3,
                },
                TextureSize {
                    size: 117,
                    n_cubemaps: 1,
                },
                TextureSize {
                    size: 256,
                    n_cubemaps: 1,
                },
                TextureSize {
                    size: 173,
                    n_cubemaps: 3,
                },
            ],
            depth_internal_format: 0,
            depth_type: 0,
            n_invalid_color_checks: 0,
            n_invalid_depth_checks: 0,
        };

        let outcome = runner.run();
        runner.deinit();

        Ok(if outcome? {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}
