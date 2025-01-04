// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayStencilAttachments.cpp
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayStencilAttachments.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `CubeMapArrayDataStorage` is a `Vec<u8>` with its dimensions. Quirks kept: the stencil fill indexes rows with the height, and the result rows are `y * height * 4` bytes apart (width == height in every configuration).

use super::TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLsizeiptr, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const N_COMPONENTS: u32 = 4;
const N_VERTICES_GS: u32 = 3;

/// `GEOMETRY_SHADER_EXTENSION_NOT_SUPPORTED`
const GEOMETRY_SHADER_EXTENSION_NOT_SUPPORTED: &str = "Geometry shader functionality not supported, skipping";

const FRAGMENT_SHADER_CODE: &str = "${VERSION}\n\n${TEXTURE_CUBE_MAP_ARRAY_REQUIRE}\n\nprecision highp float;\n\nlayout(location = 0) out vec4 color;\n\nvoid main()\n{\n    color = vec4(0, 1, 1, 0);\n}\n";

const VERTEX_SHADER_CODE: &str = "${VERSION}\n\n${TEXTURE_CUBE_MAP_ARRAY_REQUIRE}\n\nprecision highp float;\n\nin vec4 vertex_position;\n\nvoid main()\n{\n    gl_Position = vertex_position;\n}\n";

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

/// `CubeMapArrayDataStorage`
struct DataStorage {
    data: Vec<u8>,
    width: GLuint,
    height: GLuint,
    depth: GLuint,
}

impl DataStorage {
    fn new(width: GLuint, height: GLuint, depth: GLuint) -> Self {
        Self {
            data: vec![0u8; (width * height * depth * N_COMPONENTS) as usize],
            width,
            height,
            depth,
        }
    }

    fn array_size(&self) -> GLuint {
        self.width * self.height * self.depth * N_COMPONENTS
    }
}

/// `TextureCubeMapArrayStencilAttachments` (Test 3)
pub(super) struct StencilAttachments {
    pub(super) name: &'static str,
    pub(super) ext_params: ExtParameters,
    pub(super) immutable_storage: bool,
    pub(super) fbo_layered: bool,
}

#[derive(Default)]
struct Objects {
    fbo_draw_id: GLuint,
    fbo_read_id: GLuint,
    fragment_shader_id: GLuint,
    geometry_shader_id: GLuint,
    program_id: GLuint,
    texture_cube_array_stencil_id: GLuint,
    texture_cube_array_color_id: GLuint,
    vao_id: GLuint,
    vbo_id: GLuint,
    vertex_shader_id: GLuint,
}

struct Runner<'a> {
    context: &'a Context,
    test: &'a StencilAttachments,
    base: &'a TestCaseBase,
    o: Objects,
    data: Vec<DataStorage>,
}

/// `getGeometryShaderCode` without the support check
fn geometry_shader_template(max_vertices: &str, n_layers: &str) -> String {
    format!(
        "${{VERSION}}\n\n${{GEOMETRY_SHADER_REQUIRE}}\n\nlayout(triangles)                                       in;\nlayout(triangle_strip, max_vertices = {max_vertices}) out;\n\nvoid main(void)\n{{\n   int layer;\n\n   for (layer = 0; layer < {n_layers}; layer++)\n   {{\n       gl_Layer    = layer;\n       gl_Position = gl_in[0].gl_Position;\n       EmitVertex();\n\n       gl_Layer    = layer;\n       gl_Position = gl_in[1].gl_Position;\n       EmitVertex();\n\n       gl_Layer    = layer;\n       gl_Position = gl_in[2].gl_Position;\n       EmitVertex();\n\n       EndPrimitive();\n   }}\n}}\n"
    )
}

impl Runner<'_> {
    /// `fillStencilData`
    fn fill_stencil_data(&mut self, test_index: usize) {
        let storage = &mut self.data[test_index];
        storage.data.fill(0);
        for depth_index in 0..storage.depth {
            for x in 0..storage.width {
                for y in storage.height / 2..storage.height {
                    let depth_position_in_array = storage.width * storage.height * N_COMPONENTS * depth_index;
                    let y_position_in_array = storage.height * N_COMPONENTS * y;
                    let x_position_in_array = N_COMPONENTS * x;
                    let index_array = (depth_position_in_array + y_position_in_array + x_position_in_array) as usize;
                    storage.data[index_array..index_array + N_COMPONENTS as usize].fill(1);
                }
            }
        }
    }

    /// `initTest`
    fn init_test(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();

        if !self.base.is_texture_cube_map_array_supported {
            return Err(TestError::NotSupported(
                TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }
        if !self.base.is_geometry_shader_extension_supported && self.test.fbo_layered {
            return Err(TestError::NotSupported(
                GEOMETRY_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        self.data = vec![
            DataStorage::new(64, 64, 18),
            DataStorage::new(117, 117, 6),
            DataStorage::new(256, 256, 6),
            DataStorage::new(173, 173, 12),
        ];

        // full screen square
        let vertices: [f32; 16] = [
            -1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
        ];

        // SAFETY: object creation and binding on the current context.
        unsafe {
            gl.gen_vertex_arrays(1, &mut self.o.vao_id);
            gl.bind_vertex_array(self.o.vao_id);
        }
        glu::expect_no_error(gl, "Could not create vertex array object")?;
        gl_call!(
            gl,
            "Could not generate buffer object!",
            gl.gen_buffers(1, &mut self.o.vbo_id)
        );
        gl_call!(
            gl,
            "Could not bind buffer object!",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.o.vbo_id)
        );
        gl_call!(
            gl,
            "Could not set data for buffer object!",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(&vertices) as GLsizeiptr,
                vertices.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );

        gl_call!(
            gl,
            "Could not generate framebuffer object!",
            gl.gen_framebuffers(1, &mut self.o.fbo_read_id)
        );
        gl_call!(
            gl,
            "Could not generate framebuffer object!",
            gl.gen_framebuffers(1, &mut self.o.fbo_draw_id)
        );

        gl_call!(gl, "Could not enable stencil test!", gl.enable(glw::GL_STENCIL_TEST));
        Ok(())
    }

    /// `buildAndUseProgram`
    fn build_and_use_program(&mut self, test_index: usize) -> Result<(), TestError> {
        let gl = self.context.gl();

        // SAFETY: object creation on the current context.
        self.o.program_id = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "Could not create a program object")?;
        // SAFETY: as above.
        self.o.fragment_shader_id = unsafe { gl.create_shader(glw::GL_FRAGMENT_SHADER) };
        glu::expect_no_error(gl, "Could not create a fragment shader object")?;
        // SAFETY: as above.
        self.o.vertex_shader_id = unsafe { gl.create_shader(glw::GL_VERTEX_SHADER) };
        glu::expect_no_error(gl, "Could not create a vertex shader object")?;

        let fragment_parts = [FRAGMENT_SHADER_CODE];
        let vertex_parts = [VERTEX_SHADER_CODE];

        if self.test.fbo_layered {
            let depth = self.data[test_index].depth;
            let geometry_shader_code =
                geometry_shader_template(&(depth * N_VERTICES_GS).to_string(), &depth.to_string());
            if !self.base.is_geometry_shader_extension_supported {
                return Err(TestError::NotSupported(
                    GEOMETRY_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
                ));
            }

            // SAFETY: object creation on the current context.
            self.o.geometry_shader_id = unsafe { gl.create_shader(self.base.gl_ext_tokens.geometry_shader) };
            glu::expect_no_error(gl, "Could not create a geometry shader object")?;

            let geometry_parts = [geometry_shader_code.as_str()];
            let built = self.base.build_program(
                self.context,
                self.o.program_id,
                &[
                    ShaderBody::Source(self.o.fragment_shader_id, &fragment_parts),
                    ShaderBody::Source(self.o.geometry_shader_id, &geometry_parts),
                    ShaderBody::Source(self.o.vertex_shader_id, &vertex_parts),
                ],
            )?;
            if !built.0 {
                return Err(TestError::Fail(
                    "Program could not have been created sucessfully from valid vertex/geometry/fragment shaders"
                        .to_string(),
                ));
            }
        } else {
            let built = self.base.build_program(
                self.context,
                self.o.program_id,
                &[
                    ShaderBody::Source(self.o.fragment_shader_id, &fragment_parts),
                    ShaderBody::Source(self.o.vertex_shader_id, &vertex_parts),
                ],
            )?;
            if !built.0 {
                return Err(TestError::Fail(
                    "Program could not have been created sucessfully from valid vertex/fragment shaders".to_string(),
                ));
            }
        }

        gl_call!(gl, "glUseProgram() call failed", gl.use_program(self.o.program_id));
        // SAFETY: a linked program and a NUL-terminated name.
        let pos_attrib = unsafe { gl.get_attrib_location(self.o.program_id, c"vertex_position".as_ptr()) };
        glu::expect_no_error(gl, "Could not get attribute location!")?;
        if pos_attrib == -1 {
            return Err(TestError::Fail(
                "vertex_position attribute is considered inactive".to_string(),
            ));
        }
        gl_call!(
            gl,
            "Could not configure vertex_position vertex attribute array",
            gl.vertex_attrib_pointer(pos_attrib as GLuint, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null())
        );
        gl_call!(
            gl,
            "Could not enable vertex attribute array!",
            gl.enable_vertex_attrib_array(pos_attrib as GLuint)
        );
        Ok(())
    }

    /// `createImmutableCubeArrayColor`, `createMutableCubeArrayColor`
    fn create_cube_array_color(&self, test_index: usize) -> Result<(), TestError> {
        let gl = self.context.gl();
        let storage = &self.data[test_index];
        if self.test.immutable_storage {
            gl_call!(
                gl,
                "Could not create an immutable color texture storage!",
                gl.tex_storage_3d(
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    1,
                    glw::GL_RGBA8,
                    storage.width as GLint,
                    storage.height as GLint,
                    storage.depth as GLint
                )
            );
        } else {
            gl_call!(
                gl,
                "Could not create a mutable color texture storage!",
                gl.tex_image_3d(
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    0,
                    glw::GL_RGBA8 as GLint,
                    storage.width as GLint,
                    storage.height as GLint,
                    storage.depth as GLint,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    storage.data.as_ptr().cast()
                )
            );
        }
        Ok(())
    }

    /// `createImmutableCubeArrayStencil`, `createMutableCubeArrayStencil`
    fn create_cube_array_stencil(&mut self, test_index: usize) -> Result<(), TestError> {
        let gl = self.context.gl();
        self.fill_stencil_data(test_index);
        let storage = &self.data[test_index];
        if self.test.immutable_storage {
            gl_call!(
                gl,
                "Could not create an immutable stencil texture storage!",
                gl.tex_storage_3d(
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    1,
                    glw::GL_DEPTH24_STENCIL8,
                    storage.width as GLint,
                    storage.height as GLint,
                    storage.depth as GLint
                )
            );
            gl_call!(
                gl,
                "Could not fill allocated texture storage with texture data!",
                gl.tex_sub_image_3d(
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    0,
                    0,
                    0,
                    0,
                    storage.width as GLint,
                    storage.height as GLint,
                    storage.depth as GLint,
                    glw::GL_DEPTH_STENCIL,
                    glw::GL_UNSIGNED_INT_24_8,
                    storage.data.as_ptr().cast()
                )
            );
        } else {
            gl_call!(
                gl,
                "Could not create a mutable stencil texture storage!",
                gl.tex_image_3d(
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    0,
                    glw::GL_DEPTH24_STENCIL8 as GLint,
                    storage.width as GLint,
                    storage.height as GLint,
                    storage.depth as GLint,
                    0,
                    glw::GL_DEPTH_STENCIL,
                    glw::GL_UNSIGNED_INT_24_8,
                    storage.data.as_ptr().cast()
                )
            );
        }
        Ok(())
    }

    /// `initTestIteration`
    fn init_test_iteration(&mut self, test_index: usize) -> Result<(), TestError> {
        let gl = self.context.gl();

        gl_call!(
            gl,
            "Could not generate texture object!",
            gl.gen_textures(1, &mut self.o.texture_cube_array_color_id)
        );
        gl_call!(
            gl,
            "Could not bind a texture object to GL_TEXTURE_CUBE_MAP_ARRAY_EXT target",
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, self.o.texture_cube_array_color_id)
        );
        self.create_cube_array_color(test_index)?;

        gl_call!(
            gl,
            "Could not generate texture object!",
            gl.gen_textures(1, &mut self.o.texture_cube_array_stencil_id)
        );
        gl_call!(
            gl,
            "Could not bind texture object to GL_TEXTURE_CUBE_MAP_ARRAY_EXT target",
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, self.o.texture_cube_array_stencil_id)
        );
        self.create_cube_array_stencil(test_index)?;

        gl_call!(
            gl,
            "Could not bind draw framebuffer!",
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, self.o.fbo_draw_id)
        );
        gl_call!(
            gl,
            "Could not set viewport",
            gl.viewport(
                0,
                0,
                self.data[test_index].width as GLint,
                self.data[test_index].height as GLint
            )
        );

        if self.test.fbo_layered {
            gl_call!(
                gl,
                "Error attaching texture to GL_COLOR_ATTACHMENT0!",
                gl.framebuffer_texture(
                    glw::GL_DRAW_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    self.o.texture_cube_array_color_id,
                    0
                )
            );
            gl_call!(
                gl,
                "Error attaching texture to GL_DEPTH_STENCIL_ATTACHMENT! ",
                gl.framebuffer_texture(
                    glw::GL_DRAW_FRAMEBUFFER,
                    glw::GL_DEPTH_STENCIL_ATTACHMENT,
                    self.o.texture_cube_array_stencil_id,
                    0
                )
            );
        } else {
            gl_call!(
                gl,
                "Error attaching texture layer 0 to GL_COLOR_ATTACHMENT0!",
                gl.framebuffer_texture_layer(
                    glw::GL_DRAW_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    self.o.texture_cube_array_color_id,
                    0,
                    0
                )
            );
            gl_call!(
                gl,
                "Error attaching texture layer 0 to GL_DEPTH_STENCIL_ATTACHMENT! ",
                gl.framebuffer_texture_layer(
                    glw::GL_DRAW_FRAMEBUFFER,
                    glw::GL_DEPTH_STENCIL_ATTACHMENT,
                    self.o.texture_cube_array_stencil_id,
                    0,
                    0
                )
            );
        }

        // SAFETY: plain status query.
        let status = unsafe { gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) };
        if status != glw::GL_FRAMEBUFFER_COMPLETE {
            let reason = match status {
                glw::GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT => "GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT",
                glw::GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS => "GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS",
                glw::GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT => "GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT",
                glw::GL_FRAMEBUFFER_UNSUPPORTED => "Error: GL_FRAMEBUFFER_UNSUPPORTED",
                _ => {
                    return Err(TestError::Fail(
                        "Framebuffer incomplete, status not recognized".to_string(),
                    ));
                }
            };
            return Err(TestError::Fail(format!("Framebuffer incomplete, status: {reason}")));
        }
        Ok(())
    }

    /// `readPixelsAndCompareWithExpectedResult`; true when the test has failed
    fn read_pixels_and_compare_with_expected_result(
        &self,
        test_index: usize,
        result_data: &mut [u8],
    ) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let storage = &self.data[test_index];
        let mut has_test_failed = false;

        gl_call!(
            gl,
            "Could not read pixel data from color buffer",
            gl.read_pixels(
                0,
                0,
                storage.width as GLint,
                storage.height as GLint,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                result_data.as_mut_ptr().cast()
            )
        );

        for y in 0..storage.height {
            // the lower half is filled with different data than the upper half
            let expected_data: [u8; 4] = if y >= storage.height / 2 {
                [0, 255, 255, 0]
            } else {
                [255, 0, 0, 255]
            };
            let data_row = (y * storage.height * 4) as usize;
            for x in 0..storage.width {
                let offset = data_row + (x * N_COMPONENTS) as usize;
                let data = &result_data[offset..offset + 4];
                if data != expected_data {
                    log::info!(
                        "Expected Data ( {},{},{},{}) Result Data ( {},{},{},{})",
                        expected_data[0],
                        expected_data[1],
                        expected_data[2],
                        expected_data[3],
                        data[0],
                        data[1],
                        data[2],
                        data[3]
                    );
                    has_test_failed = true;
                }
            }
        }
        Ok(has_test_failed)
    }

    /// `cleanAfterTest`
    fn clean_after_test(&mut self) {
        let gl = self.context.gl();
        // SAFETY: resets bindings and deletes names this test created, on the current context.
        unsafe {
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0);
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, 0);
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0);
            gl.use_program(0);

            if self.o.program_id != 0 {
                gl.delete_program(self.o.program_id);
                self.o.program_id = 0;
            }
            for id in [
                &mut self.o.fragment_shader_id,
                &mut self.o.geometry_shader_id,
                &mut self.o.vertex_shader_id,
            ] {
                if *id != 0 {
                    gl.delete_shader(*id);
                    *id = 0;
                }
            }
            for id in [
                &mut self.o.texture_cube_array_color_id,
                &mut self.o.texture_cube_array_stencil_id,
            ] {
                if *id != 0 {
                    gl.delete_textures(1, id);
                    *id = 0;
                }
            }
        }
    }

    /// `deinit`
    fn deinit(&mut self) {
        let gl = self.context.gl();
        // SAFETY: restores state on the current context.
        unsafe { gl.disable(glw::GL_STENCIL_TEST) };

        self.clean_after_test();
        // SAFETY: resets the binding and deletes names this test created.
        unsafe {
            gl.bind_vertex_array(0);
            if self.o.vbo_id != 0 {
                gl.delete_buffers(1, &self.o.vbo_id);
                self.o.vbo_id = 0;
            }
            for id in [&mut self.o.fbo_draw_id, &mut self.o.fbo_read_id] {
                if *id != 0 {
                    gl.delete_framebuffers(1, id);
                    *id = 0;
                }
            }
            if self.o.vao_id != 0 {
                gl.delete_vertex_arrays(1, &self.o.vao_id);
                self.o.vao_id = 0;
            }
        }
    }

    fn run(&mut self) -> Result<bool, TestError> {
        let gl = self.context.gl();

        self.init_test()?;

        gl_call!(
            gl,
            "Could not setup stencil function",
            gl.stencil_func(glw::GL_LESS, 0, 0xFF)
        );
        gl_call!(
            gl,
            "Could not setup stencil operation",
            gl.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_KEEP)
        );
        gl_call!(
            gl,
            "Could not set stencil color value!",
            gl.clear_color(1.0, 0.0, 0.0, 1.0)
        );

        let mut has_test_failed = false;

        for test_index in 0..self.data.len() {
            self.build_and_use_program(test_index)?;
            self.init_test_iteration(test_index)?;

            gl_call!(gl, "Could not clear color buffer", gl.clear(glw::GL_COLOR_BUFFER_BIT));
            gl_call!(gl, "Rendering failed!", gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

            let array_size = (self.data[test_index].array_size() / self.data[test_index].depth) as usize;
            let mut result_data = vec![0u8; array_size];
            gl_call!(
                gl,
                "Could not bind read framebuffer",
                gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, self.o.fbo_read_id)
            );

            if self.test.fbo_layered {
                for n_layer in 0..self.data[test_index].depth {
                    gl_call!(
                        gl,
                        "Could not attach texture layer to color attachment of read framebuffer",
                        gl.framebuffer_texture_layer(
                            glw::GL_READ_FRAMEBUFFER,
                            glw::GL_COLOR_ATTACHMENT0,
                            self.o.texture_cube_array_color_id,
                            0,
                            n_layer as GLint
                        )
                    );
                    has_test_failed =
                        self.read_pixels_and_compare_with_expected_result(test_index, &mut result_data)?;
                    if has_test_failed {
                        break;
                    }
                }
            } else {
                gl_call!(
                    gl,
                    "Could not attach texture layer to color attachment of read framebuffer",
                    gl.framebuffer_texture_layer(
                        glw::GL_READ_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        self.o.texture_cube_array_color_id,
                        0,
                        0
                    )
                );
                has_test_failed = self.read_pixels_and_compare_with_expected_result(test_index, &mut result_data)?;
            }

            self.clean_after_test();
            if has_test_failed {
                break;
            }
        }

        Ok(!has_test_failed)
    }
}

impl TestCase for StencilAttachments {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        let mut runner = Runner {
            context,
            test: self,
            base: &base,
            o: Objects::default(),
            data: Vec::new(),
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
