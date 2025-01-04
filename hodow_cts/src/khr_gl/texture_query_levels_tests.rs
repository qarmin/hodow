// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cTextureQueryLevelsTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream has one subclass per sampler type that only differs in the texture it creates, the sampler name and the extents; those are the fields of `Variant` and the arms of `create_texture`.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLuint};
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

const VERTEX_SHADER_TXT: &str = "\n    #version 400 core\n    layout (location = 0) in vec3 aPos;\n    void main()\n    {\n        gl_PointSize = 10.0f;\n        gl_Position = vec4(aPos, 1.0);\n    }\n    ";

const FRAGMENT_SHADER_TXT: &str = "\n    #version 400 core\n    #extension GL_ARB_texture_query_levels: require\n    out vec4 FragColor;\n    uniform ${sampler} texture;\n    uniform int expectedValue;\n    void main()\n    {\n        int levels = textureQueryLevels(texture);\n        if(levels == expectedValue)\n        {\n            FragColor = vec4(0.0, 1.0, 0.0, 1.0);//green\n        }\n        else\n        {\n            FragColor = vec4(1.0, 0.0, 0.0, 1.0);//red\n        }\n    }\n    ";

#[derive(Clone, Copy)]
enum TextureKind {
    Tex1D,
    Tex2D,
    Tex3D,
    Cube,
    Tex1DArray,
    Tex2DArray,
    CubeArray,
    Shadow1D,
    Shadow2D,
    ShadowCube,
    Shadow1DArray,
    Shadow2DArray,
    ShadowCubeArray,
}

struct Variant {
    case_name: &'static str,
    sampler: &'static str,
    texture_type: GLenum,
    /// `m_height`: 1 for the 1D samplers, otherwise the default of 32.
    height: i32,
    kind: TextureKind,
}

const WIDTH: i32 = 32;
const DEPTH: i32 = 32;

/// `1 + floor(log2(extent))`
fn levels_for(extent: i32) -> i32 {
    1 + extent.ilog2() as i32
}

impl Variant {
    /// `m_initialLevels` as each subclass computes it.
    fn initial_levels(&self) -> i32 {
        match self.kind {
            TextureKind::Tex2D
            | TextureKind::Tex2DArray
            | TextureKind::Shadow2D
            | TextureKind::Shadow2DArray
            | TextureKind::CubeArray
            | TextureKind::ShadowCubeArray => levels_for(WIDTH.max(self.height)),
            TextureKind::Tex3D => levels_for(WIDTH.max(self.height.max(DEPTH))),
            _ => levels_for(WIDTH),
        }
    }

    /// `createTexture`
    fn create_texture(&self, gl: &glw::Functions, texture: &mut GLuint) -> Result<(), TestError> {
        let (width, height) = (WIDTH, self.height);
        let target = self.texture_type;

        gl_call!(gl, "glGenTextures failed", gl.gen_textures(1, texture));
        gl_call!(gl, "glBindTexture failed", gl.bind_texture(target, *texture));

        let color_bytes = |count: i32| vec![255u8; count as usize];
        let depth_floats = |count: i32| vec![1.0f32; count as usize];
        let rgb = glw::GL_RGB as i32;
        let depth16 = glw::GL_DEPTH_COMPONENT16 as i32;

        match self.kind {
            TextureKind::Tex1D => {
                let data = color_bytes(width * 4);
                gl_call!(
                    gl,
                    "glTexImage1D failed",
                    gl.tex_image_1d(
                        target,
                        0,
                        rgb,
                        width,
                        0,
                        glw::GL_RGB,
                        glw::GL_UNSIGNED_BYTE,
                        data.as_ptr().cast()
                    )
                );
            }
            TextureKind::Tex2D => {
                let data = color_bytes(width * height * 3);
                gl_call!(
                    gl,
                    "glTexImage2D failed",
                    gl.tex_image_2d(
                        target,
                        0,
                        rgb,
                        width,
                        height,
                        0,
                        glw::GL_RGB,
                        glw::GL_UNSIGNED_BYTE,
                        data.as_ptr().cast()
                    )
                );
            }
            TextureKind::Tex3D => {
                let data = color_bytes(width * height * DEPTH * 3);
                gl_call!(
                    gl,
                    "glTexImage2D failed",
                    gl.tex_image_3d(
                        target,
                        0,
                        rgb,
                        width,
                        height,
                        DEPTH,
                        0,
                        glw::GL_RGB,
                        glw::GL_UNSIGNED_BYTE,
                        data.as_ptr().cast()
                    )
                );
            }
            TextureKind::Cube => {
                let data = color_bytes(width * height * 3);
                for i in 0..6 {
                    gl_call!(
                        gl,
                        "glTexImage2D failed",
                        gl.tex_image_2d(
                            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X + i,
                            0,
                            rgb,
                            width,
                            height,
                            0,
                            glw::GL_RGB,
                            glw::GL_UNSIGNED_BYTE,
                            data.as_ptr().cast()
                        )
                    );
                }
            }
            TextureKind::Tex1DArray => {
                let layers = 4;
                let data = color_bytes(width * layers * 3);
                gl_call!(
                    gl,
                    "glTexImage1D failed",
                    gl.tex_image_2d(
                        target,
                        0,
                        rgb,
                        width,
                        layers,
                        0,
                        glw::GL_RGB,
                        glw::GL_UNSIGNED_BYTE,
                        data.as_ptr().cast()
                    )
                );
            }
            TextureKind::Tex2DArray => {
                let layers = 4;
                let data = color_bytes(width * height * layers * 3);
                gl_call!(
                    gl,
                    "glTexImage1D failed",
                    gl.tex_image_3d(
                        target,
                        0,
                        rgb,
                        width,
                        height,
                        layers,
                        0,
                        glw::GL_RGB,
                        glw::GL_UNSIGNED_BYTE,
                        data.as_ptr().cast()
                    )
                );
            }
            TextureKind::CubeArray => {
                let layers = 2;
                let data = color_bytes(width * height * layers * 6 * 3);
                gl_call!(
                    gl,
                    "glTexImage1D failed",
                    gl.tex_image_3d(
                        target,
                        0,
                        rgb,
                        width,
                        height,
                        layers * 6,
                        0,
                        glw::GL_RGB,
                        glw::GL_UNSIGNED_BYTE,
                        data.as_ptr().cast()
                    )
                );
            }
            TextureKind::Shadow1D => {
                let data = depth_floats(width);
                gl_call!(
                    gl,
                    "glTexImage1D failed",
                    gl.tex_image_1d(
                        target,
                        0,
                        depth16,
                        width,
                        0,
                        glw::GL_DEPTH_COMPONENT,
                        glw::GL_FLOAT,
                        data.as_ptr().cast()
                    )
                );
            }
            TextureKind::Shadow2D => {
                let data = depth_floats(width * height);
                gl_call!(
                    gl,
                    "glTexImage1D failed",
                    gl.tex_image_2d(
                        target,
                        0,
                        depth16,
                        width,
                        height,
                        0,
                        glw::GL_DEPTH_COMPONENT,
                        glw::GL_FLOAT,
                        data.as_ptr().cast()
                    )
                );
            }
            TextureKind::ShadowCube => {
                let data = depth_floats(width * height);
                for i in 0..6 {
                    gl_call!(
                        gl,
                        "glTexImage2D failed",
                        gl.tex_image_2d(
                            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X + i,
                            0,
                            depth16,
                            width,
                            height,
                            0,
                            glw::GL_DEPTH_COMPONENT,
                            glw::GL_FLOAT,
                            data.as_ptr().cast()
                        )
                    );
                }
            }
            TextureKind::Shadow1DArray => {
                let layers = 4;
                let data = depth_floats(width * layers);
                gl_call!(
                    gl,
                    "glTexImage1D failed",
                    gl.tex_image_2d(
                        target,
                        0,
                        depth16,
                        width,
                        layers,
                        0,
                        glw::GL_DEPTH_COMPONENT,
                        glw::GL_FLOAT,
                        data.as_ptr().cast()
                    )
                );
            }
            TextureKind::Shadow2DArray => {
                let layers = 4;
                let data = depth_floats(width * height * layers);
                gl_call!(
                    gl,
                    "glTexImage1D failed",
                    gl.tex_image_3d(
                        target,
                        0,
                        depth16,
                        width,
                        height,
                        layers,
                        0,
                        glw::GL_DEPTH_COMPONENT,
                        glw::GL_FLOAT,
                        data.as_ptr().cast()
                    )
                );
            }
            TextureKind::ShadowCubeArray => {
                let layers = 4;
                let data = depth_floats(width * height * layers * 6);
                // SAFETY: the pixel buffer holds `width * height * layers * 6` floats, as the call reads; upstream does not check this call's error.
                unsafe {
                    gl.tex_image_3d(
                        target,
                        0,
                        depth16,
                        width,
                        height,
                        layers * 6,
                        0,
                        glw::GL_DEPTH_COMPONENT,
                        glw::GL_FLOAT,
                        data.as_ptr().cast(),
                    )
                };
            }
        }

        if matches!(
            self.kind,
            TextureKind::Shadow1D
                | TextureKind::Shadow2D
                | TextureKind::ShadowCube
                | TextureKind::Shadow1DArray
                | TextureKind::Shadow2DArray
                | TextureKind::ShadowCubeArray
        ) {
            gl_call!(
                gl,
                "glTextureParameteri failed",
                gl.tex_parameteri(
                    target,
                    glw::GL_TEXTURE_COMPARE_MODE,
                    glw::GL_COMPARE_REF_TO_TEXTURE as i32
                )
            );
            gl_call!(
                gl,
                "glTextureParameteri failed",
                gl.tex_parameteri(target, glw::GL_TEXTURE_COMPARE_FUNC, glw::GL_LEQUAL as i32)
            );
        }

        gl_call!(gl, "glGenerateMipmap failed", gl.generate_mipmap(target));
        Ok(())
    }
}

struct TextureQueryLevelsBaseTest {
    variant: Variant,
}

/// The objects `createBuffers`/`createTexture` make.
struct Objects {
    vbo: GLuint,
    vao: GLuint,
    texture: GLuint,
}

impl TextureQueryLevelsBaseTest {
    /// `createBuffers`
    fn create_buffers(gl: &glw::Functions, objects: &mut Objects) -> Result<(), TestError> {
        let vertices: [f32; 3] = [0.0, 0.0, 0.0];

        gl_call!(gl, "glGenBuffers failed", gl.gen_buffers(1, &mut objects.vbo));
        gl_call!(
            gl,
            "glGenVertexArrays failed",
            gl.gen_vertex_arrays(1, &mut objects.vao)
        );
        gl_call!(gl, "glBindVertexArray failed", gl.bind_vertex_array(objects.vao));
        gl_call!(
            gl,
            "glBindBuffer failed",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, objects.vbo)
        );
        gl_call!(
            gl,
            "glBufferData failed",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(&vertices) as isize,
                vertices.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );
        gl_call!(
            gl,
            "glVertexAttribPointer failed",
            gl.vertex_attrib_pointer(
                0,
                3,
                glw::GL_FLOAT,
                glw::FALSE,
                3 * size_of::<f32>() as i32,
                std::ptr::null()
            )
        );
        gl_call!(gl, "glEnableVertexAttribArray failed", gl.enable_vertex_attrib_array(0));
        Ok(())
    }

    /// `verify`
    fn verify(&self, gl: &glw::Functions) -> Result<bool, TestError> {
        let mut pixel = [0u8; 4];
        gl_call!(
            gl,
            "glReadPixels failed",
            gl.read_pixels(
                WIDTH / 2,
                self.variant.height / 2,
                1,
                1,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                pixel.as_mut_ptr().cast()
            )
        );

        Ok(pixel == [0, 255, 0, 255])
    }

    /// `test`
    fn test(&self, context: &Context) -> Result<bool, TestError> {
        let gl = context.gl();
        let initial_levels = self.variant.initial_levels();
        let texture_type = self.variant.texture_type;

        gl_call!(gl, "glClear failed", gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl_call!(gl, "glViewport failed", gl.viewport(0, 0, WIDTH, self.variant.height));

        let fragment_shader_txt =
            StringTemplate::new(FRAGMENT_SHADER_TXT).specialize(&[("sampler", self.variant.sampler.to_string())])?;
        let shader_program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_TXT, fragment_shader_txt));
        if !shader_program.is_ok() {
            log::warn!("{}", shader_program.build_failure_summary().unwrap_or_default());
        }

        gl_call!(gl, "glUseProgram failed", gl.use_program(shader_program.program()));

        // SAFETY: NUL-terminated names and the program in use.
        let (texture_location, expected_value_location) = unsafe {
            (
                gl.get_uniform_location(shader_program.program(), c"texture".as_ptr()),
                gl.get_uniform_location(shader_program.program(), c"expectedValue".as_ptr()),
            )
        };
        gl_call!(gl, "glUniform1i failed", gl.uniform_1i(texture_location, 0));
        gl_call!(
            gl,
            "glUniform1i failed",
            gl.uniform_1i(expected_value_location, initial_levels)
        );

        gl_call!(gl, "glEnable", gl.enable(glw::GL_PROGRAM_POINT_SIZE));
        gl_call!(gl, "glDrawArrays failed", gl.draw_arrays(glw::GL_POINTS, 0, 1));

        let mut result = self.verify(gl)?;

        gl_call!(
            gl,
            "glTexParameteri failed",
            gl.tex_parameteri(texture_type, glw::GL_TEXTURE_BASE_LEVEL, 0)
        );
        gl_call!(
            gl,
            "glTexParameteri failed",
            gl.tex_parameteri(texture_type, glw::GL_TEXTURE_MAX_LEVEL, initial_levels - 2)
        );

        gl_call!(
            gl,
            "glUniform1i failed",
            gl.uniform_1i(expected_value_location, initial_levels - 1)
        );
        gl_call!(gl, "glDrawArrays failed", gl.draw_arrays(glw::GL_POINTS, 0, 1));

        result &= self.verify(gl)?;

        gl_call!(
            gl,
            "glTexParameteri failed",
            gl.tex_parameteri(texture_type, glw::GL_TEXTURE_BASE_LEVEL, 2)
        );
        gl_call!(
            gl,
            "glTexParameteri failed",
            gl.tex_parameteri(texture_type, glw::GL_TEXTURE_MAX_LEVEL, 1000)
        );

        gl_call!(
            gl,
            "glUniform1i failed",
            gl.uniform_1i(expected_value_location, initial_levels - 2)
        );
        gl_call!(gl, "glDrawArrays failed", gl.draw_arrays(glw::GL_POINTS, 0, 1));

        result &= self.verify(gl)?;

        Ok(result)
    }

    /// `clean`
    fn clean(gl: &glw::Functions, objects: &Objects) {
        // SAFETY: names this case generated, each deleted once.
        unsafe {
            if objects.vao != 0 {
                gl.delete_vertex_arrays(1, &objects.vao);
            }
            if objects.vbo != 0 {
                gl.delete_buffers(1, &objects.vbo);
            }
            if objects.texture != 0 {
                gl.delete_textures(1, &objects.texture);
            }
        }
    }
}

impl TestCase for TextureQueryLevelsBaseTest {
    fn name(&self) -> &str {
        self.variant.case_name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if context
            .context_info
            .is_extension_supported("GL_ARB_texture_query_levels")
        {
            Ok(())
        } else {
            Err(TestError::NotSupported("Not supported".to_string()))
        }
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = Objects {
            vbo: 0,
            vao: 0,
            texture: 0,
        };

        let result = Self::create_buffers(gl, &mut objects)
            .and_then(|()| self.variant.create_texture(gl, &mut objects.texture))
            .and_then(|()| self.test(context));
        Self::clean(gl, &objects);

        Ok(if result? {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `TextureQueryLevelsTests::init`
pub fn create_tests() -> TestCaseGroup {
    use TextureKind::*;
    let variants = [
        ("sampler1D_test", "sampler1D", glw::GL_TEXTURE_1D, 1, Tex1D),
        ("sampler2D_test", "sampler2D", glw::GL_TEXTURE_2D, 32, Tex2D),
        ("sampler3D_test", "sampler3D", glw::GL_TEXTURE_3D, 32, Tex3D),
        ("samplerCube_test", "samplerCube", glw::GL_TEXTURE_CUBE_MAP, 32, Cube),
        (
            "sampler1DArray_test",
            "sampler1DArray",
            glw::GL_TEXTURE_1D_ARRAY,
            1,
            Tex1DArray,
        ),
        (
            "sampler2DArray_test",
            "sampler2DArray",
            glw::GL_TEXTURE_2D_ARRAY,
            32,
            Tex2DArray,
        ),
        (
            "samplerCubeArray_test",
            "samplerCubeArray",
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            32,
            CubeArray,
        ),
        (
            "sampler1DShadow_test",
            "sampler1DShadow",
            glw::GL_TEXTURE_1D,
            1,
            Shadow1D,
        ),
        (
            "sampler2DShadow_test",
            "sampler2DShadow",
            glw::GL_TEXTURE_2D,
            32,
            Shadow2D,
        ),
        (
            "samplerCubeShadow_test",
            "samplerCubeShadow",
            glw::GL_TEXTURE_CUBE_MAP,
            32,
            ShadowCube,
        ),
        (
            "sampler1DArrayShadow_test",
            "sampler1DArrayShadow",
            glw::GL_TEXTURE_1D_ARRAY,
            1,
            Shadow1DArray,
        ),
        (
            "sampler2DArrayShadow_test",
            "sampler2DArrayShadow",
            glw::GL_TEXTURE_2D_ARRAY,
            32,
            Shadow2DArray,
        ),
        (
            "samplerCubeArrayShadow_test",
            "samplerCubeArrayShadow",
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            32,
            ShadowCubeArray,
        ),
    ];

    let mut group = TestCaseGroup::new("texture_query_levels");
    for (case_name, sampler, texture_type, height, kind) in variants {
        group.add_child(Box::new(TextureQueryLevelsBaseTest {
            variant: Variant {
                case_name,
                sampler,
                texture_type,
                height,
                kind,
            },
        }) as Box<dyn TestCase>);
    }
    group
}
