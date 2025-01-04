// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cTextureQueryLodTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The three upstream subclasses differ in the geometry, the texture and the sampler; they are the arms of `Dimension`. The 1D vertex list keeps upstream's thirteen floats (it is short of the sixteen its stride implies).

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

const VERTEX_SHADER_TXT: &str = "\n    #version 400 core\n    layout (location = 0) in vec3 aPos;\n    layout (location = 1) in ${texCoordType} aTexCoord;\n    uniform float scale;\n    out ${texCoordType} texCoord;\n    void main()\n    {\n        gl_Position = vec4(aPos * scale, 1.0);\n        texCoord = aTexCoord;\n    }\n    ";

const FRAGMENT_SHADER_TXT: &str = "\n    #version 400 core\n    #extension GL_ARB_texture_query_lod: require\n    out vec4 fragColor;\n    in ${texCoordType} texCoord;\n    uniform ${sampler} texture;\n    void main()\n    {\n        float lod = textureQueryLOD(texture, texCoord).x;\n        vec4 sampledColor = textureLod(texture, texCoord, lod);\n        fragColor = sampledColor;\n    }\n    ";

const WIDTH: i32 = 128;
const VIEW_PORT_WIDTH: i32 = 256;
const VIEW_PORT_HEIGHT: i32 = 256;

#[derive(Clone, Copy)]
enum Dimension {
    D1,
    D2,
    D3,
}

struct Geometry {
    vertices: Vec<f32>,
    indices: Vec<u32>,
    /// Floats per vertex, the stride in floats.
    stride: i32,
    /// Components of the texture coordinate attribute.
    tex_coord_components: i32,
}

impl Dimension {
    fn case_name(self) -> &'static str {
        match self {
            Self::D1 => "sampler1D_test",
            Self::D2 => "sampler2D_test",
            Self::D3 => "sampler3D_test",
        }
    }

    fn tex_coord_type(self) -> &'static str {
        match self {
            Self::D1 => "float",
            Self::D2 => "vec2",
            Self::D3 => "vec3",
        }
    }

    fn sampler(self) -> &'static str {
        match self {
            Self::D1 => "sampler1D",
            Self::D2 => "sampler2D",
            Self::D3 => "sampler3D",
        }
    }

    fn texture_type(self) -> GLenum {
        match self {
            Self::D1 => glw::GL_TEXTURE_1D,
            Self::D2 => glw::GL_TEXTURE_2D,
            Self::D3 => glw::GL_TEXTURE_3D,
        }
    }

    /// The `vertices` and `m_indices` each `createBuffers` builds.
    fn geometry(self) -> Geometry {
        match self {
            Self::D1 => Geometry {
                vertices: vec![-0.5, 0.0, 0.0, 0.0, 0.5, 0.0, 1.0, 0.5, 0.0, 1.0, -0.5, 0.0, 0.0],
                indices: vec![0, 1, 2, 2, 3, 0],
                stride: 3,
                tex_coord_components: 1,
            },
            Self::D2 => Geometry {
                vertices: vec![
                    -0.5, -0.5, 0.0, 0.0, 0.0, 0.5, -0.5, 0.0, 1.0, 0.0, 0.5, 0.5, 0.0, 1.0, 1.0, -0.5, 0.5, 0.0, 0.0,
                    1.0,
                ],
                indices: vec![0, 1, 2, 2, 3, 0],
                stride: 5,
                tex_coord_components: 2,
            },
            Self::D3 => Geometry {
                vertices: vec![
                    -0.5, -0.5, -0.5, 0.0, 0.0, 0.0, 0.5, -0.5, -0.5, 1.0, 0.0, 0.0, 0.5, 0.5, -0.5, 1.0, 1.0, 0.0,
                    -0.5, 0.5, -0.5, 0.0, 1.0, 0.0, -0.5, -0.5, 0.5, 0.0, 0.0, 1.0, 0.5, -0.5, 0.5, 1.0, 0.0, 1.0, 0.5,
                    0.5, 0.5, 1.0, 1.0, 1.0, -0.5, 0.5, 0.5, 0.0, 1.0, 1.0,
                ],
                indices: vec![
                    0, 1, 2, 2, 3, 0, 1, 5, 6, 6, 2, 1, 3, 2, 6, 6, 7, 3, 4, 0, 3, 3, 7, 4, 4, 5, 1, 1, 0, 4, 4, 7, 6,
                    6, 5, 4,
                ],
                stride: 6,
                tex_coord_components: 3,
            },
        }
    }
}

/// `calculateExpectedColor`
fn calculate_expected_color(scale: f32, texture_size: i32) -> [f32; 3] {
    let projected_size = scale;
    let log2_size = (texture_size as f32).log2();
    let lod = (texture_size as f32 * projected_size).log2().clamp(0.0, log2_size);
    let color_factor = lod / log2_size;
    [1.0 - color_factor, color_factor, 0.0]
}

struct TextureQueryLodBaseTest {
    dimension: Dimension,
}

struct Objects {
    vbo: GLuint,
    vao: GLuint,
    ebo: GLuint,
    texture: GLuint,
}

impl TextureQueryLodBaseTest {
    /// `createBuffers` of the base plus the subclass's own.
    fn create_buffers(&self, gl: &glw::Functions, objects: &mut Objects) -> Result<Vec<u32>, TestError> {
        let geometry = self.dimension.geometry();

        gl_call!(gl, "glGenBuffers failed", gl.gen_buffers(1, &mut objects.vbo));
        gl_call!(gl, "glGenBuffers failed", gl.gen_buffers(1, &mut objects.ebo));
        gl_call!(
            gl,
            "glGenVertexArrays failed",
            gl.gen_vertex_arrays(1, &mut objects.vao)
        );

        let float_size = size_of::<f32>() as i32;
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
                (geometry.vertices.len() * size_of::<f32>()) as isize,
                geometry.vertices.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );
        gl_call!(
            gl,
            "glBindBuffer failed",
            gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, objects.ebo)
        );
        gl_call!(
            gl,
            "glBufferData failed",
            gl.buffer_data(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                (geometry.indices.len() * size_of::<u32>()) as isize,
                geometry.indices.as_ptr().cast(),
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
                geometry.stride * float_size,
                std::ptr::null()
            )
        );
        gl_call!(gl, "glEnableVertexAttribArray failed", gl.enable_vertex_attrib_array(0));
        gl_call!(
            gl,
            "glVertexAttribPointer failed",
            gl.vertex_attrib_pointer(
                1,
                geometry.tex_coord_components,
                glw::GL_FLOAT,
                glw::FALSE,
                geometry.stride * float_size,
                (3 * size_of::<f32>()) as *const std::ffi::c_void
            )
        );
        gl_call!(gl, "glEnableVertexAttribArray failed", gl.enable_vertex_attrib_array(1));

        Ok(geometry.indices)
    }

    /// `createTexture`: one flat-coloured level per mip level, the colour moving from green to red with the level.
    fn create_texture(&self, gl: &glw::Functions, texture: &mut GLuint) -> Result<(), TestError> {
        let target = self.dimension.texture_type();
        let rgba = glw::GL_RGBA as i32;

        gl_call!(gl, "glGenTextures failed", gl.gen_textures(1, texture));
        gl_call!(gl, "glBindTexture failed", gl.bind_texture(target, *texture));

        let top_level = (WIDTH as f32).log2() as i32;
        for level in 0..=top_level {
            let mipmap_size = (WIDTH >> level).max(1);
            let texels = match self.dimension {
                Dimension::D1 => mipmap_size,
                Dimension::D2 => mipmap_size * mipmap_size,
                Dimension::D3 => mipmap_size * mipmap_size * mipmap_size,
            } as usize;

            let color_factor = level as f32 / (WIDTH as f32).log2();
            let r = (255.0 * color_factor) as u8;
            let g = (255.0 * (1.0 - color_factor)) as u8;
            let mipmap_data: Vec<u8> = (0..texels).flat_map(|_| [r, g, 0, 255]).collect();
            let pixels: *const std::ffi::c_void = mipmap_data.as_ptr().cast();

            match self.dimension {
                Dimension::D1 => gl_call!(
                    gl,
                    "glTexImage1D failed",
                    gl.tex_image_1d(
                        glw::GL_TEXTURE_1D,
                        level,
                        rgba,
                        mipmap_size,
                        0,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        pixels
                    )
                ),
                Dimension::D2 => gl_call!(
                    gl,
                    "glTexImage2D failed",
                    gl.tex_image_2d(
                        target,
                        level,
                        rgba,
                        mipmap_size,
                        mipmap_size,
                        0,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        pixels
                    )
                ),
                Dimension::D3 => gl_call!(
                    gl,
                    "glTexImage3D failed",
                    gl.tex_image_3d(
                        target,
                        level,
                        rgba,
                        mipmap_size,
                        mipmap_size,
                        mipmap_size,
                        0,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        pixels
                    )
                ),
            }
        }

        let parameter = |gl: &glw::Functions, pname: GLenum, value: GLenum| -> Result<(), TestError> {
            gl_call!(
                gl,
                "glTexParameteri failed",
                gl.tex_parameteri(target, pname, value as i32)
            );
            Ok(())
        };

        match self.dimension {
            Dimension::D1 => {
                parameter(gl, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR_MIPMAP_LINEAR)?;
                parameter(gl, glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR)?;
                parameter(gl, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE)?;
            }
            Dimension::D2 => {
                parameter(gl, glw::GL_TEXTURE_WRAP_S, glw::GL_REPEAT)?;
                parameter(gl, glw::GL_TEXTURE_WRAP_T, glw::GL_REPEAT)?;
                parameter(gl, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR_MIPMAP_LINEAR)?;
                parameter(gl, glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR)?;
            }
            Dimension::D3 => {
                parameter(gl, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR_MIPMAP_LINEAR)?;
                parameter(gl, glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR)?;
                parameter(gl, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE)?;
                parameter(gl, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE)?;
                parameter(gl, glw::GL_TEXTURE_WRAP_R, glw::GL_CLAMP_TO_EDGE)?;
            }
        }
        Ok(())
    }

    /// `verify`
    fn verify(gl: &glw::Functions, scale_loc: i32, index_count: i32) -> Result<bool, TestError> {
        let mut result = true;

        for i in 0..5 {
            let scale_value = 0.05 + 0.2 * i as f32;
            gl_call!(gl, "glUniform1f failed", gl.uniform_1f(scale_loc, scale_value));
            gl_call!(
                gl,
                "glDrawElements failed",
                gl.draw_elements(glw::GL_TRIANGLES, index_count, glw::GL_UNSIGNED_INT, std::ptr::null())
            );

            let mut pixel_data = [0u8; 4];
            gl_call!(
                gl,
                "glReadPixels failed",
                gl.read_pixels(
                    VIEW_PORT_WIDTH / 2,
                    VIEW_PORT_HEIGHT / 2,
                    1,
                    1,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    pixel_data.as_mut_ptr().cast()
                )
            );

            let expected_color = calculate_expected_color(scale_value, WIDTH);
            let expected = expected_color.map(|channel| (channel.clamp(0.0, 1.0) * 255.0) as u8);
            let tolerance = 15;

            let within =
                (0..3).all(|channel| (i32::from(pixel_data[channel]) - i32::from(expected[channel])).abs() < tolerance);
            result &= within;
        }

        Ok(result)
    }

    /// `test`
    fn test(&self, context: &Context, index_count: i32, objects: &Objects) -> Result<bool, TestError> {
        let gl = context.gl();

        gl_call!(gl, "glClear failed", gl.clear_color(0.2, 0.3, 0.3, 1.0));
        gl_call!(gl, "glClear failed", gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl_call!(
            gl,
            "glViewport failed",
            gl.viewport(0, 0, VIEW_PORT_WIDTH, VIEW_PORT_HEIGHT)
        );

        let vertex_shader_txt = StringTemplate::new(VERTEX_SHADER_TXT)
            .specialize(&[("texCoordType", self.dimension.tex_coord_type().to_string())])?;
        let fragment_shader_txt = StringTemplate::new(FRAGMENT_SHADER_TXT).specialize(&[
            ("texCoordType", self.dimension.tex_coord_type().to_string()),
            ("sampler", self.dimension.sampler().to_string()),
        ])?;
        let shader_program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vertex_shader_txt, fragment_shader_txt));
        if !shader_program.is_ok() {
            log::warn!("{}", shader_program.build_failure_summary().unwrap_or_default());
        }

        gl_call!(gl, "glUseProgram failed", gl.use_program(shader_program.program()));

        // SAFETY: NUL-terminated names and the program in use.
        let (texture_location, scale_loc) = unsafe {
            (
                gl.get_uniform_location(shader_program.program(), c"texture".as_ptr()),
                gl.get_uniform_location(shader_program.program(), c"scale".as_ptr()),
            )
        };
        gl_call!(gl, "glUniform1i failed", gl.uniform_1i(texture_location, 0));
        glu::expect_no_error(gl, "glGetUniformLocation failed")?;

        // SAFETY: the vertex array and texture generated for this case.
        unsafe {
            gl.bind_vertex_array(objects.vao);
            gl.bind_texture(self.dimension.texture_type(), objects.texture);
        }

        Self::verify(gl, scale_loc, index_count)
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
            if objects.ebo != 0 {
                gl.delete_buffers(1, &objects.ebo);
            }
            if objects.texture != 0 {
                gl.delete_textures(1, &objects.texture);
            }
        }
    }
}

impl TestCase for TextureQueryLodBaseTest {
    fn name(&self) -> &str {
        self.dimension.case_name()
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !context.context_info.is_extension_supported("GL_ARB_texture_query_lod") {
            return Err(TestError::NotSupported("Not supported".to_string()));
        }

        // Bail out if rendertarget is too small.
        let render_target = context.render_context.render_target();
        if render_target.width < VIEW_PORT_WIDTH || render_target.height < VIEW_PORT_HEIGHT {
            return Err(TestError::NotSupported("Too small viewport".to_string()));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = Objects {
            vbo: 0,
            vao: 0,
            ebo: 0,
            texture: 0,
        };

        let result = self.create_buffers(gl, &mut objects).and_then(|indices| {
            self.create_texture(gl, &mut objects.texture)?;
            self.test(context, indices.len() as i32, &objects)
        });
        Self::clean(gl, &objects);

        Ok(if result? {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `TextureQueryLodTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture_query_lod");
    for dimension in [Dimension::D1, Dimension::D2, Dimension::D3] {
        group.add_child(Box::new(TextureQueryLodBaseTest { dimension }) as Box<dyn TestCase>);
    }
    group
}
