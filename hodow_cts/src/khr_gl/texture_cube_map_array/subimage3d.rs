// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArraySubImage3D.cpp
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArraySubImage3D.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use super::{StorageType, TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLsizeiptr, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const N_COMPONENTS: GLuint = 4;

/// Texture resolutions: width, height, depth
const RESOLUTIONS: [[GLuint; 3]; 4] = [[32, 32, 12], [64, 64, 12], [16, 16, 18], [16, 16, 24]];

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

/// `SubImage3DCopyParams`: the region of the cube map array to replace
#[derive(Clone, Copy, Default)]
struct CopyParams {
    xoffset: GLuint,
    yoffset: GLuint,
    zoffset: GLuint,
    width: GLuint,
    height: GLuint,
    depth: GLuint,
}

impl CopyParams {
    fn new(xoffset: GLuint, yoffset: GLuint, zoffset: GLuint, width: GLuint, height: GLuint, depth: GLuint) -> Self {
        Self {
            xoffset,
            yoffset,
            zoffset,
            width,
            height,
            depth,
        }
    }
}

/// `TextureCubeMapArraySubImage3D` (Test 5)
pub(super) struct SubImage3D {
    pub(super) ext_params: ExtParameters,
}

#[derive(Default)]
struct State {
    read_fbo_id: GLuint,
    pixel_buffer_id: GLuint,
    tex_cube_map_array_id: GLuint,
    tex_2d_id: GLuint,
    copy_data_buffer: Vec<GLuint>,
    expected_data_buffer: Vec<GLuint>,
}

struct Runner<'a> {
    context: &'a Context,
    state: State,
}

impl Runner<'_> {
    /// `configureDataBuffer`
    fn configure_data_buffer(
        &mut self,
        width: GLuint,
        height: GLuint,
        depth: GLuint,
        copy_params: &CopyParams,
        clear_value: GLuint,
    ) {
        let mut copy_data =
            vec![clear_value; (copy_params.width * copy_params.height * copy_params.depth * N_COMPONENTS) as usize];
        let mut index = 0;
        for zoffset in copy_params.zoffset..copy_params.zoffset + copy_params.depth {
            for yoffset in copy_params.yoffset..copy_params.yoffset + copy_params.height {
                for xoffset in copy_params.xoffset..copy_params.xoffset + copy_params.width {
                    for component in 0..N_COMPONENTS {
                        copy_data[index] =
                            (zoffset * width * height + yoffset * width + xoffset) * N_COMPONENTS + component;
                        index += 1;
                    }
                }
            }
        }
        self.state.copy_data_buffer = copy_data;

        let mut expected = vec![clear_value; (width * height * depth * N_COMPONENTS) as usize];
        for zoffset in copy_params.zoffset..copy_params.zoffset + copy_params.depth {
            for yoffset in copy_params.yoffset..copy_params.yoffset + copy_params.height {
                for xoffset in copy_params.xoffset..copy_params.xoffset + copy_params.width {
                    let base = ((zoffset * width * height + yoffset * width + xoffset) * N_COMPONENTS) as usize;
                    for component in 0..N_COMPONENTS {
                        expected[base + component as usize] =
                            (zoffset * width * height + yoffset * width + xoffset) * N_COMPONENTS + component;
                    }
                }
            }
        }
        self.state.expected_data_buffer = expected;
    }

    /// `configurePixelUnpackBuffer`
    fn configure_pixel_unpack_buffer(&mut self, copy_params: &CopyParams) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(
            gl,
            "Could not generate buffer object!",
            gl.gen_buffers(1, &mut self.state.pixel_buffer_id)
        );
        gl_call!(
            gl,
            "Could not bind buffer object!",
            gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, self.state.pixel_buffer_id)
        );
        gl_call!(
            gl,
            "Could not fill buffer object's data store with data!",
            gl.buffer_data(
                glw::GL_PIXEL_UNPACK_BUFFER,
                (copy_params.width * copy_params.height * copy_params.depth * N_COMPONENTS) as GLsizeiptr
                    * std::mem::size_of::<GLuint>() as GLsizeiptr,
                self.state.copy_data_buffer.as_ptr().cast(),
                glw::GL_STATIC_READ
            )
        );
        gl_call!(
            gl,
            "Could not bind buffer object!",
            gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0)
        );
        Ok(())
    }

    /// `clearCubeMapArrayTexture`
    fn clear_cube_map_array_texture(
        &self,
        width: GLuint,
        height: GLuint,
        depth: GLuint,
        clear_value: GLuint,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();
        let data_buffer = vec![clear_value; (width * height * depth * N_COMPONENTS) as usize];
        gl_call!(
            gl,
            "Error filling texture object's data store with data",
            gl.tex_sub_image_3d(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                0,
                0,
                0,
                0,
                width as GLint,
                height as GLint,
                depth as GLint,
                glw::GL_RGBA_INTEGER,
                glw::GL_UNSIGNED_INT,
                data_buffer.as_ptr().cast()
            )
        );
        Ok(())
    }

    /// `configureCubeMapArrayTexture`
    fn configure_cube_map_array_texture(
        &mut self,
        width: GLuint,
        height: GLuint,
        depth: GLuint,
        storage_type: StorageType,
        clear_value: GLuint,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(
            gl,
            "Error generating texture object!",
            gl.gen_textures(1, &mut self.state.tex_cube_map_array_id)
        );
        gl_call!(
            gl,
            "Error binding texture object!",
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, self.state.tex_cube_map_array_id)
        );

        if storage_type == StorageType::Mutable {
            gl_call!(
                gl,
                "Error setting texture parameter.",
                gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP_ARRAY, glw::GL_TEXTURE_BASE_LEVEL, 0)
            );
            gl_call!(
                gl,
                "Error setting texture parameter.",
                gl.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP_ARRAY, glw::GL_TEXTURE_MAX_LEVEL, 0)
            );
            let data_buffer = vec![clear_value; (width * height * depth * N_COMPONENTS) as usize];
            gl_call!(
                gl,
                "Error allocating texture object's data store",
                gl.tex_image_3d(
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    0,
                    glw::GL_RGBA32UI as GLint,
                    width as GLint,
                    height as GLint,
                    depth as GLint,
                    0,
                    glw::GL_RGBA_INTEGER,
                    glw::GL_UNSIGNED_INT,
                    data_buffer.as_ptr().cast()
                )
            );
        } else {
            gl_call!(
                gl,
                "Error allocating texture object's data store",
                gl.tex_storage_3d(
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    1,
                    glw::GL_RGBA32UI,
                    width as GLint,
                    height as GLint,
                    depth as GLint
                )
            );
            self.clear_cube_map_array_texture(width, height, depth, clear_value)?;
        }
        Ok(())
    }

    /// `configure2DTexture`
    fn configure_2d_texture(&mut self, copy_params: &CopyParams) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(
            gl,
            "Could not generate texture object!",
            gl.gen_textures(1, &mut self.state.tex_2d_id)
        );
        gl_call!(
            gl,
            "Could not bind texture object!",
            gl.bind_texture(glw::GL_TEXTURE_2D, self.state.tex_2d_id)
        );
        gl_call!(
            gl,
            "Error allocating texture object's data store",
            gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                1,
                glw::GL_RGBA32UI,
                copy_params.width as GLint,
                copy_params.height as GLint
            )
        );
        gl_call!(
            gl,
            "Error filling texture object's data store with data",
            gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                copy_params.width as GLint,
                copy_params.height as GLint,
                glw::GL_RGBA_INTEGER,
                glw::GL_UNSIGNED_INT,
                self.state.copy_data_buffer.as_ptr().cast()
            )
        );
        Ok(())
    }

    /// `texSubImage3D`; a null `data` reads from the bound pixel unpack buffer
    fn tex_sub_image_3d(&self, copy_params: &CopyParams, data: *const std::ffi::c_void) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(
            gl,
            "Error filling texture object's data store with data",
            gl.tex_sub_image_3d(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                0,
                copy_params.xoffset as GLint,
                copy_params.yoffset as GLint,
                copy_params.zoffset as GLint,
                copy_params.width as GLint,
                copy_params.height as GLint,
                copy_params.depth as GLint,
                glw::GL_RGBA_INTEGER,
                glw::GL_UNSIGNED_INT,
                data
            )
        );
        Ok(())
    }

    /// `copyTexSubImage3D`
    fn copy_tex_sub_image_3d(&self, copy_params: &CopyParams) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(
            gl,
            "Could not attach texture object to framebuffer's attachment",
            gl.framebuffer_texture_2d(
                glw::GL_READ_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                self.state.tex_2d_id,
                0
            )
        );
        TestCaseBase::check_framebuffer_status(self.context, glw::GL_READ_FRAMEBUFFER)?;
        gl_call!(
            gl,
            "Error filling texture object's data store with data",
            gl.copy_tex_sub_image_3d(
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                0,
                copy_params.xoffset as GLint,
                copy_params.yoffset as GLint,
                copy_params.zoffset as GLint,
                0,
                0,
                copy_params.width as GLint,
                copy_params.height as GLint
            )
        );
        Ok(())
    }

    /// `checkResults`
    fn check_results(&self, width: GLuint, height: GLuint, depth: GLuint) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let n_elements = (width * height * depth * N_COMPONENTS) as usize;
        let mut result_data_buffer = vec![0 as GLuint; n_elements];

        for layer_nr in 0..depth {
            gl_call!(
                gl,
                "Could not attach texture object to framebuffer's attachment",
                gl.framebuffer_texture_layer(
                    glw::GL_READ_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    self.state.tex_cube_map_array_id,
                    0,
                    layer_nr as GLint
                )
            );
            TestCaseBase::check_framebuffer_status(self.context, glw::GL_READ_FRAMEBUFFER)?;
            let offset = (layer_nr * width * height * N_COMPONENTS) as usize;
            gl_call!(
                gl,
                "Could not read pixels from framebuffer's attachment!",
                gl.read_pixels(
                    0,
                    0,
                    width as GLint,
                    height as GLint,
                    glw::GL_RGBA_INTEGER,
                    glw::GL_UNSIGNED_INT,
                    result_data_buffer[offset..].as_mut_ptr().cast()
                )
            );
        }
        Ok(result_data_buffer == self.state.expected_data_buffer)
    }

    fn log_failure(what: &str, width: GLuint, height: GLuint, depth: GLuint, copy_params: &CopyParams) {
        log::info!(
            "{what}\nTexture Cube Map Array Dimensions (width, height, depth) ({width},{height},{depth})\nTexture Cube Map Array Offsets (xoffset, yoffset, zoffset) ({},{},{})\nTexture Cube Map Array Copy Size (width, height, depth) ({},{},{})\n",
            copy_params.xoffset,
            copy_params.yoffset,
            copy_params.zoffset,
            copy_params.width,
            copy_params.height,
            copy_params.depth
        );
    }

    /// `testTexSubImage3D`
    fn test_tex_sub_image_3d(
        &self,
        width: GLuint,
        height: GLuint,
        depth: GLuint,
        copy_params: &CopyParams,
        test_passed: &mut bool,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();

        self.clear_cube_map_array_texture(width, height, depth, 0)?;
        self.tex_sub_image_3d(copy_params, self.state.copy_data_buffer.as_ptr().cast())?;
        if !self.check_results(width, height, depth)? {
            Self::log_failure(
                "glTexSubImage3D failed to copy data to texture cube map array's data store from client's memory",
                width,
                height,
                depth,
                copy_params,
            );
            *test_passed = false;
        }

        self.clear_cube_map_array_texture(width, height, depth, 0)?;
        gl_call!(
            gl,
            "Error binding buffer object!",
            gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, self.state.pixel_buffer_id)
        );
        self.tex_sub_image_3d(copy_params, std::ptr::null())?;
        if !self.check_results(width, height, depth)? {
            Self::log_failure(
                "glTexSubImage3D failed to copy data to texture cube map array's data store from GL_PIXEL_UNPACK_BUFFER",
                width,
                height,
                depth,
                copy_params,
            );
            *test_passed = false;
        }
        gl_call!(
            gl,
            "Error binding buffer object!",
            gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0)
        );
        Ok(())
    }

    /// `testCopyTexSubImage3D`
    fn test_copy_tex_sub_image_3d(
        &self,
        width: GLuint,
        height: GLuint,
        depth: GLuint,
        copy_params: &CopyParams,
        test_passed: &mut bool,
    ) -> Result<(), TestError> {
        self.clear_cube_map_array_texture(width, height, depth, 0)?;
        self.copy_tex_sub_image_3d(copy_params)?;
        if !self.check_results(width, height, depth)? {
            Self::log_failure(
                "glCopyTexSubImage3D failed to copy data to texture cube map array's data store",
                width,
                height,
                depth,
                copy_params,
            );
            *test_passed = false;
        }
        Ok(())
    }

    /// `deletePixelUnpackBuffer`
    fn delete_pixel_unpack_buffer(&mut self) {
        let gl = self.context.gl();
        // SAFETY: resets the binding and deletes the name this test created.
        unsafe {
            gl.bind_buffer(glw::GL_PIXEL_UNPACK_BUFFER, 0);
            if self.state.pixel_buffer_id != 0 {
                gl.delete_buffers(1, &self.state.pixel_buffer_id);
                self.state.pixel_buffer_id = 0;
            }
        }
    }

    /// `deleteCubeMapArrayTexture`
    fn delete_cube_map_array_texture(&mut self) {
        let gl = self.context.gl();
        // SAFETY: resets the binding and deletes the name this test created.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0);
            if self.state.tex_cube_map_array_id != 0 {
                gl.delete_textures(1, &self.state.tex_cube_map_array_id);
                self.state.tex_cube_map_array_id = 0;
            }
        }
    }

    /// `delete2DTexture`
    fn delete_2d_texture(&mut self) {
        let gl = self.context.gl();
        // SAFETY: resets the binding and deletes the name this test created.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
            if self.state.tex_2d_id != 0 {
                gl.delete_textures(1, &self.state.tex_2d_id);
                self.state.tex_2d_id = 0;
            }
        }
    }

    /// `deinit`
    fn deinit(&mut self) {
        let gl = self.context.gl();
        // SAFETY: resets the binding and deletes the name this test created.
        unsafe {
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, 0);
            if self.state.read_fbo_id != 0 {
                gl.delete_framebuffers(1, &self.state.read_fbo_id);
                self.state.read_fbo_id = 0;
            }
        }
        self.delete_pixel_unpack_buffer();
        self.delete_cube_map_array_texture();
        self.delete_2d_texture();
    }

    fn run(&mut self, base: &TestCaseBase) -> Result<bool, TestError> {
        let gl = self.context.gl();

        // `initTest`
        if !base.is_texture_cube_map_array_supported {
            return Err(TestError::NotSupported(
                TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }
        gl_call!(
            gl,
            "Error generating frame buffer object!",
            gl.gen_framebuffers(1, &mut self.state.read_fbo_id)
        );
        gl_call!(
            gl,
            "Error binding frame buffer object!",
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, self.state.read_fbo_id)
        );

        let mut test_passed = true;

        for storage_type in [StorageType::Mutable, StorageType::Immutable] {
            for [width, height, depth] in RESOLUTIONS {
                self.configure_cube_map_array_texture(width, height, depth, storage_type, 0)?;

                // a single whole layer-face at index 0 should be replaced (both functions)
                let mut copy_params = CopyParams::new(0, 0, 0, width, height, 1);
                self.configure_data_buffer(width, height, depth, &copy_params, 0);
                self.configure_pixel_unpack_buffer(&copy_params)?;
                self.configure_2d_texture(&copy_params)?;
                self.test_tex_sub_image_3d(width, height, depth, &copy_params, &mut test_passed)?;
                self.test_copy_tex_sub_image_3d(width, height, depth, &copy_params, &mut test_passed)?;
                self.delete_pixel_unpack_buffer();
                self.delete_2d_texture();

                // a region of a layer-face at index 0 should be replaced (both functions)
                copy_params = CopyParams::new(width / 2, height / 2, 0, width / 2, height / 2, 1);
                self.configure_data_buffer(width, height, depth, &copy_params, 0);
                self.configure_pixel_unpack_buffer(&copy_params)?;
                self.configure_2d_texture(&copy_params)?;
                self.test_tex_sub_image_3d(width, height, depth, &copy_params, &mut test_passed)?;
                self.test_copy_tex_sub_image_3d(width, height, depth, &copy_params, &mut test_passed)?;
                self.delete_pixel_unpack_buffer();
                self.delete_2d_texture();

                // 6 layer-faces making up a single layer, then making up two different layers, whole and limited to a quad (glTexSubImage3D() only)
                for copy_params in [
                    CopyParams::new(0, 0, 0, width, height, 6),
                    CopyParams::new(0, 0, 3, width, height, 6),
                    CopyParams::new(width / 2, height / 2, 0, width / 2, height / 2, 6),
                    CopyParams::new(width / 2, height / 2, 3, width / 2, height / 2, 6),
                ] {
                    self.configure_data_buffer(width, height, depth, &copy_params, 0);
                    self.configure_pixel_unpack_buffer(&copy_params)?;
                    self.test_tex_sub_image_3d(width, height, depth, &copy_params, &mut test_passed)?;
                    self.delete_pixel_unpack_buffer();
                }

                self.delete_cube_map_array_texture();
            }
        }

        Ok(test_passed)
    }
}

impl TestCase for SubImage3D {
    fn name(&self) -> &str {
        "subimage3D"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        let mut runner = Runner {
            context,
            state: State::default(),
        };

        let outcome = runner.run(&base);
        runner.deinit();

        Ok(if outcome? {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}
