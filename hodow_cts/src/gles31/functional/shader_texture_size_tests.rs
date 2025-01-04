// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fShaderTextureSizeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
//
// Upstream runs one texture size per `iterate()`; here the sizes are a loop. A
// `glu::OutOfMemoryError` becomes a `GL_OUT_OF_MEMORY` check after `glTexStorage*`.

use std::mem::size_of_val;

use crate::glu::{
    self, Buffer, Context, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup, Texture, VertexArray,
};
use crate::glw::{self, GLenum, GLint, GLsizeiptr, GLuint};
use crate::tcu::{Surface, TestError, TestOutcome, TestStatus};

const POSITION_VERTEX_SHADER_SOURCE: &str = "${GLSL_VERSION_DECL}\n\
    in highp vec4 a_position;\n\
    void main (void)\n\
    {\n\
    \tgl_Position = a_position;\n\
    }\n";

#[derive(Clone, Copy, PartialEq, Eq)]
enum TextureType {
    Float2D,
    Float2DArray,
    Int2D,
    Int2DArray,
    Uint2D,
    Uint2DArray,
}

/// `TextureSizeCase`
struct TextureSizeCase {
    name: String,
    texture_type: TextureType,
    num_samples: i32,
}

impl TextureSizeCase {
    fn is_array_type(&self) -> bool {
        matches!(
            self.texture_type,
            TextureType::Float2DArray | TextureType::Int2DArray | TextureType::Uint2DArray
        )
    }

    /// `getTextureGLTarget`
    fn texture_target(&self) -> GLenum {
        if self.is_array_type() {
            glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
        } else {
            glw::GL_TEXTURE_2D_MULTISAMPLE
        }
    }

    /// `getTextureGLInternalFormat`
    fn texture_internal_format(&self) -> GLenum {
        match self.texture_type {
            TextureType::Float2D | TextureType::Float2DArray => glw::GL_RGBA8,
            TextureType::Int2D | TextureType::Int2DArray => glw::GL_R8I,
            TextureType::Uint2D | TextureType::Uint2DArray => glw::GL_R8UI,
        }
    }

    /// `genFragmentSource`
    fn fragment_source(&self, context: &Context) -> String {
        let sampler_type = match self.texture_type {
            TextureType::Float2D => "sampler2DMS",
            TextureType::Float2DArray => "sampler2DMSArray",
            TextureType::Int2D => "isampler2DMS",
            TextureType::Int2DArray => "isampler2DMSArray",
            TextureType::Uint2D => "usampler2DMS",
            TextureType::Uint2DArray => "usampler2DMSArray",
        };
        let size_type = if self.is_array_type() { "ivec3" } else { "ivec2" };
        let supports_es32 = context.context_type().supports(3, 2);
        let extension_statement = if self.is_array_type() && !supports_es32 {
            "#extension GL_OES_texture_storage_multisample_2d_array : require\n"
        } else {
            ""
        };

        format!(
            "{}\n\
             {extension_statement}\
             layout(location = 0) out highp vec4 fragColor;\n\
             uniform highp {sampler_type} u_sampler;\n\
             uniform highp {size_type} u_size;\n\
             void main (void)\n\
             {{\n\
             \tconst highp vec4 okColor = vec4(0.0, 1.0, 0.0, 1.0);\n\
             \tconst highp vec4 failColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
             \tfragColor = (textureSize(u_sampler) == u_size) ? (okColor) : (failColor);\n\
             }}\n",
            context.context_type().glsl_version().declaration()
        )
    }

    /// `verifyImage`
    fn verify_image(context: &Context, dst: &Surface) -> bool {
        let pixel_format = context.render_target().pixel_format();
        let color_threshold_red = 1 << (8 - pixel_format.red_bits);
        let color_threshold_green = 1 << (8 - pixel_format.green_bits);
        let color_threshold_blue = 1 << (8 - pixel_format.blue_bits);
        let color = dst.get_pixel(0, 0);

        // green
        if color.get_red() < color_threshold_red
            && color.get_green() > 255 - color_threshold_green
            && color.get_blue() < color_threshold_blue
        {
            return true;
        }

        // red (image size incorrect) or anything else
        false
    }
}

impl TestCase for TextureSizeCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let supports_es32 = context.context_type().supports(3, 2);
        if self.is_array_type()
            && !supports_es32
            && !context
                .context_info
                .is_extension_supported("GL_OES_texture_storage_multisample_2d_array")
        {
            return Err(TestError::NotSupported(
                "Test requires OES_texture_storage_multisample_2d_array extension".to_string(),
            ));
        }

        let render_target = context.render_target();
        if render_target.width < 1 || render_target.height < 1 {
            return Err(TestError::NotSupported(
                "rendertarget size must be at least 1x1".to_string(),
            ));
        }
        Ok(())
    }

    /// `TextureSizeCase::init` plus every `iterate()` round.
    fn iterate(&self, context: &Context) -> TestOutcome {
        self.check_support(context)?;

        const TEST_SIZES_2D: [[i32; 2]; 7] = [[1, 1], [1, 4], [4, 8], [21, 11], [107, 254], [-1, 3], [3, -1]];
        const TEST_SIZES_3D: [[i32; 3]; 8] = [
            [1, 1, 1],
            [1, 4, 7],
            [4, 8, 12],
            [21, 11, 9],
            [107, 254, 2],
            [-1, 3, 3],
            [3, -1, 3],
            [4, 4, -1],
        ];
        let fullscreen_quad: [[f32; 4]; 4] = [
            [-1.0, 1.0, 0.0, 1.0],
            [-1.0, -1.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
            [1.0, -1.0, 0.0, 1.0],
        ];

        let gl = context.gl();

        let mut max_texture_size: GLint = 0;
        let mut max_texture_layers: GLint = 0;
        let mut max_samples: GLint = 0;

        // SAFETY: one integer of output each.
        unsafe {
            gl.get_integerv(glw::GL_MAX_TEXTURE_SIZE, &mut max_texture_size);
            gl.get_integerv(glw::GL_MAX_ARRAY_TEXTURE_LAYERS, &mut max_texture_layers);
            gl.get_internalformativ(
                self.texture_target(),
                self.texture_internal_format(),
                glw::GL_SAMPLES,
                1,
                &mut max_samples,
            );
        }

        if self.num_samples > max_samples {
            return Err(TestError::NotSupported("sample count is not supported".to_string()));
        }

        // gen shade
        let sources = ProgramSources::default()
            .with(
                ShaderType::Vertex,
                POSITION_VERTEX_SHADER_SOURCE.replace(
                    "${GLSL_VERSION_DECL}",
                    context.context_type().glsl_version().declaration(),
                ),
            )
            .with(ShaderType::Fragment, self.fragment_source(context));
        let shader = ShaderProgram::new(gl, &sources);
        if !shader.is_ok() {
            return Err(TestError::Fail("shader build failed".to_string()));
        }

        // gen buffer
        let vbo = Buffer::new(gl);
        // SAFETY: a buffer name this case generated and an array that outlives the upload.
        unsafe {
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(&fullscreen_quad) as GLsizeiptr,
                fullscreen_quad.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
        }
        let vao = VertexArray::new(gl);

        // gen iterations
        let mut iterations: Vec<[i32; 3]> = Vec::new();
        if !self.is_array_type() {
            for size in TEST_SIZES_2D {
                if size[0] <= max_texture_size && size[1] <= max_texture_size {
                    let w = if size[0] < 0 { max_texture_size } else { size[0] };
                    let h = if size[1] < 0 { max_texture_size } else { size[1] };

                    iterations.push([w, h, 0]);
                }
            }
        } else {
            for size in TEST_SIZES_3D {
                if size[0] <= max_texture_size && size[1] <= max_texture_size && size[2] <= max_texture_layers {
                    let w = if size[0] < 0 { max_texture_size } else { size[0] };
                    let h = if size[1] < 0 { max_texture_size } else { size[1] };
                    let d = if size[2] < 0 { max_texture_layers } else { size[2] };

                    iterations.push([w, h, d]);
                }
            }
        }

        // SAFETY: NUL-terminated names against the program just built.
        let (position_loc, shader_sampler_loc, shader_size_loc) = unsafe {
            (
                gl.get_attrib_location(shader.program(), c"a_position".as_ptr()),
                gl.get_uniform_location(shader.program(), c"u_sampler".as_ptr()),
                gl.get_uniform_location(shader.program(), c"u_size".as_ptr()),
            )
        };

        let mut all_iterations_passed = true;
        let mut all_cases_skipped = true;

        for size in iterations {
            let texture_target = self.texture_target();
            let mut skip_test = false;
            let mut result = Surface::new(1, 1);

            // createTexture
            let texture = Texture::new(gl);
            // SAFETY: a texture name this case generated.
            unsafe { gl.bind_texture(texture_target, texture.get()) };
            glu::expect_no_error(gl, "texture gen")?;

            // SAFETY: storage for the texture bound above.
            unsafe {
                if !self.is_array_type() {
                    gl.tex_storage_2d_multisample(
                        texture_target,
                        self.num_samples,
                        self.texture_internal_format(),
                        size[0],
                        size[1],
                        glw::FALSE,
                    );
                } else {
                    gl.tex_storage_3d_multisample(
                        texture_target,
                        self.num_samples,
                        self.texture_internal_format(),
                        size[0],
                        size[1],
                        size[2],
                        glw::FALSE,
                    );
                }
            }
            // SAFETY: glGetError needs only a current context.
            let storage_error = unsafe { gl.get_error() };
            if storage_error == glw::GL_OUT_OF_MEMORY {
                skip_test = true;
            } else if storage_error != glw::GL_NO_ERROR {
                return Err(TestError::Fail(format!(
                    "texStorage returned {}",
                    glw::error_name(storage_error)
                )));
            }

            if !skip_test {
                // runShader
                glu::expect_no_error(gl, "preclear")?;
                // SAFETY: plain state setting.
                unsafe {
                    gl.viewport(0, 0, 1, 1);
                    gl.clear_color(0.0, 0.0, 0.0, 1.0);
                    gl.clear(glw::GL_COLOR_BUFFER_BIT);
                }
                glu::expect_no_error(gl, "clear")?;

                // SAFETY: the buffer, program and texture set up above.
                unsafe {
                    gl.bind_vertex_array(vao.get());

                    gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo.get());
                    gl.vertex_attrib_pointer(
                        position_loc as GLuint,
                        4,
                        glw::GL_FLOAT,
                        glw::FALSE,
                        0,
                        std::ptr::null(),
                    );
                    gl.enable_vertex_attrib_array(position_loc as GLuint);
                }
                glu::expect_no_error(gl, "vertexAttrib")?;

                // SAFETY: a linked program and the uniform locations queried from it.
                unsafe {
                    gl.use_program(shader.program());
                    gl.uniform_1i(shader_sampler_loc, 0);
                    if self.is_array_type() {
                        gl.uniform_3iv(shader_size_loc, 1, size.as_ptr());
                    } else {
                        gl.uniform_2iv(shader_size_loc, 1, size.as_ptr());
                    }
                }
                glu::expect_no_error(gl, "setup program")?;

                // SAFETY: the texture created above.
                unsafe { gl.bind_texture(texture_target, texture.get()) };
                glu::expect_no_error(gl, "bindtex")?;

                // SAFETY: draws the quad set up above.
                unsafe { gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4) };
                glu::expect_no_error(gl, "drawArrays")?;

                // SAFETY: unbinding.
                unsafe {
                    gl.disable_vertex_attrib_array(position_loc as GLuint);
                    gl.use_program(0);
                    gl.bind_vertex_array(0);
                }
                glu::expect_no_error(gl, "cleanup")?;

                // SAFETY: nothing but a current context.
                unsafe { gl.finish() };
                glu::read_pixels(&context.render_context, 0, 0, &mut result.get_access())?;
                glu::expect_no_error(gl, "readPixels")?;
            }

            // free resources
            drop(texture);
            glu::expect_no_error(gl, "texture delete")?;

            // queried value was correct?
            if !skip_test {
                all_cases_skipped = false;

                if !Self::verify_image(context, &result) {
                    all_iterations_passed = false;
                }
            }
        }

        if !all_iterations_passed {
            Ok(TestStatus::fail("Got invalid texture size"))
        } else if all_cases_skipped {
            Ok(TestStatus::fail("All test texture creations failed"))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

/// `ShaderTextureSizeTests::init`
pub fn create_tests() -> TestCaseGroup {
    const SAMPLER_TYPES: [(TextureType, &str); 6] = [
        (TextureType::Float2D, "texture_2d"),
        (TextureType::Float2DArray, "texture_2d_array"),
        (TextureType::Int2D, "texture_int_2d"),
        (TextureType::Int2DArray, "texture_int_2d_array"),
        (TextureType::Uint2D, "texture_uint_2d"),
        (TextureType::Uint2DArray, "texture_uint_2d_array"),
    ];

    const SAMPLE_COUNTS: [i32; 2] = [1, 4];

    let mut group = TestCaseGroup::new("texture_size");

    for (texture_type, type_name) in SAMPLER_TYPES {
        for num_samples in SAMPLE_COUNTS {
            let name = format!("samples_{num_samples}_{type_name}");
            group.add_child(Box::new(TextureSizeCase {
                name,
                texture_type,
                num_samples,
            }) as Box<dyn TestCase>);
        }
    }

    group
}
