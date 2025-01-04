// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayGenerateMipMap.cpp
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayGenerateMipMap.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The non-filterable variant is not supported on a desktop context, upstream's `init` throws for it.

use super::{StorageType, TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const N_COMPONENTS: usize = 4;
const N_COLORS_PER_LAYER_FACE: usize = 2;

/// Two pattern colours for each layer-face
const LAYER_FACE_DATA: [[[u8; N_COMPONENTS]; N_COLORS_PER_LAYER_FACE]; 18] = [
    [[0, 0, 0, 0], [255, 255, 255, 255]],
    [[255, 0, 0, 0], [0, 255, 255, 255]],
    [[0, 255, 0, 0], [255, 0, 255, 255]],
    [[0, 0, 255, 0], [255, 255, 0, 255]],
    [[0, 0, 0, 255], [255, 255, 255, 0]],
    [[255, 255, 0, 0], [0, 0, 255, 255]],
    [[255, 0, 255, 0], [0, 255, 0, 255]],
    [[255, 0, 0, 255], [0, 255, 255, 0]],
    [[0, 255, 255, 0], [255, 0, 0, 255]],
    [[0, 255, 0, 255], [255, 0, 255, 0]],
    [[255, 255, 255, 0], [0, 0, 0, 255]],
    [[255, 255, 0, 255], [0, 0, 255, 0]],
    [[255, 255, 255, 255], [0, 0, 0, 0]],
    [[0, 0, 0, 255], [255, 0, 0, 0]],
    [[0, 0, 0, 255], [255, 255, 0, 0]],
    [[0, 0, 255, 0], [255, 255, 255, 0]],
    [[0, 255, 0, 0], [255, 255, 255, 255]],
    [[255, 0, 0, 0], [255, 0, 255, 255]],
];

/// `StorageConfig`: width, height, depth
const STORAGE_CONFIGS: [[GLint; 3]; 4] = [[64, 64, 18], [117, 117, 6], [256, 256, 6], [173, 173, 12]];

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

/// `getAmountOfLevelsForTexture`
fn amount_of_levels_for_texture(width: GLint, height: GLint) -> GLint {
    ((width.max(height) as f32).ln() / 2.0f32.ln()).floor() as GLint + 1
}

/// `TextureCubeMapArrayGenerateMipMapFilterable` (Test 7.1)
pub(super) struct Filterable {
    pub(super) name: &'static str,
    pub(super) ext_params: ExtParameters,
    pub(super) storage_type: StorageType,
}

/// `TextureCubeMapArrayGenerateMipMapNonFilterable` (Test 7.2)
pub(super) struct NonFilterable {
    pub(super) name: &'static str,
    pub(super) ext_params: ExtParameters,
    pub(super) storage_type: StorageType,
}

/// `generateTestData`: the expected pixels of layer-face `n_layer`
fn generate_test_data(n_layer: usize, width: usize, height: usize) -> Vec<u8> {
    let mut data = vec![0u8; width * height * N_COMPONENTS];
    for x in 0..width {
        for y in 0..height {
            for n_component in 0..N_COMPONENTS {
                let n_color = ((x % N_COLORS_PER_LAYER_FACE) + y) % N_COLORS_PER_LAYER_FACE;
                data[(y * width + x) * N_COMPONENTS + n_component] = LAYER_FACE_DATA[n_layer][n_color][n_component];
            }
        }
    }
    data
}

impl Filterable {
    fn run(
        &self,
        context: &Context,
        base: &TestCaseBase,
        fbo_id: &mut GLuint,
        textures: &mut Vec<GLuint>,
    ) -> Result<(), TestError> {
        let gl = context.gl();

        // `init`
        if !base.is_texture_cube_map_array_supported {
            return Err(TestError::NotSupported(
                TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        // `initTest`
        gl_call!(gl, "glPixelStorei() call(s) failed", {
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1);
            gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
        });

        for [width, height, depth] in STORAGE_CONFIGS {
            let mut to_id: GLuint = 0;
            gl_call!(gl, "glGenTextures() call failed", gl.gen_textures(1, &mut to_id));
            textures.push(to_id);
            gl_call!(
                gl,
                "glBindTexture() call failed",
                gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, to_id)
            );
            gl_call!(gl, "glTexParameteri() call(s) failed", {
                gl.tex_parameteri(
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    glw::GL_TEXTURE_MAG_FILTER,
                    glw::GL_LINEAR as GLint,
                );
                gl.tex_parameteri(
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    glw::GL_TEXTURE_MIN_FILTER,
                    glw::GL_LINEAR as GLint,
                );
            });

            if self.storage_type == StorageType::Mutable {
                gl_call!(
                    gl,
                    "glTexImage3D() call failed",
                    gl.tex_image_3d(
                        glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                        0,
                        glw::GL_RGBA8 as GLint,
                        width,
                        height,
                        depth,
                        0,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        std::ptr::null()
                    )
                );
            } else {
                gl_call!(
                    gl,
                    "glTexStorage3D() call failed",
                    gl.tex_storage_3d(
                        glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                        amount_of_levels_for_texture(width, height),
                        glw::GL_RGBA8,
                        width,
                        height,
                        depth
                    )
                );
            }
        }

        gl_call!(gl, "glGenFramebuffers() call failed", gl.gen_framebuffers(1, fbo_id));

        for (n_storage_config, ([width, height, depth], to_id)) in
            STORAGE_CONFIGS.into_iter().zip(textures.clone()).enumerate()
        {
            let levels = amount_of_levels_for_texture(width, height);
            gl_call!(
                gl,
                "glBindTexture() call failed",
                gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, to_id)
            );

            // fill each base layer-face with pattern data
            for n_layer_face in 0..depth {
                let data = generate_test_data(n_layer_face as usize, width as usize, height as usize);
                gl_call!(
                    gl,
                    "glTexSubImage3D() call failed",
                    gl.tex_sub_image_3d(
                        glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                        0,
                        0,
                        0,
                        n_layer_face,
                        width,
                        height,
                        1,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        data.as_ptr().cast()
                    )
                );
            }

            gl_call!(
                gl,
                "glGenerateMipmap() call failed",
                gl.generate_mipmap(glw::GL_TEXTURE_CUBE_MAP_ARRAY)
            );
            gl_call!(
                gl,
                "glBindFramebuffer() call failed",
                gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, *fbo_id)
            );

            let mut last_level_data_buffer = [0u8; N_COMPONENTS];
            let mut rendered = vec![0u8; (width * height) as usize * N_COMPONENTS];

            for n_layer_face in 0..depth {
                let reference = generate_test_data(n_layer_face as usize, width as usize, height as usize);

                gl_call!(
                    gl,
                    "glFramebufferTextureLayer() call failed.",
                    gl.framebuffer_texture_layer(
                        glw::GL_READ_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        to_id,
                        0,
                        n_layer_face
                    )
                );
                gl_call!(
                    gl,
                    "glReadPixels() call failed.",
                    gl.read_pixels(
                        0,
                        0,
                        width,
                        height,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        rendered.as_mut_ptr().cast()
                    )
                );

                // the base layer-face contents reported have to be as uploaded
                if reference != rendered {
                    log::info!(
                        "Data stored in base layer mip-map for storage config [{n_storage_config}]and layer-face index [{n_layer_face}] is different than was uploaded"
                    );
                    return Err(TestError::Fail("Invalid data found for base layer mip-map".to_string()));
                }

                // read from the last mip-map available for the layer-face
                gl_call!(
                    gl,
                    "glFramebufferTextureLayer() call failed.",
                    gl.framebuffer_texture_layer(
                        glw::GL_READ_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        to_id,
                        levels - 1,
                        n_layer_face
                    )
                );
                gl_call!(
                    gl,
                    "glReadPixels() call failed",
                    gl.read_pixels(
                        0,
                        0,
                        1,
                        1,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        last_level_data_buffer.as_mut_ptr().cast()
                    )
                );

                // the data of the last level must not equal either of the pattern colours
                for n_pattern_color in 0..N_COLORS_PER_LAYER_FACE {
                    if LAYER_FACE_DATA[n_layer_face as usize][n_pattern_color] == last_level_data_buffer {
                        log::info!(
                            "Texel stored in layer-face's smallest mip-map for storage config [{n_storage_config}]and layer-face index [{n_layer_face}]describes one of the colors used for the pattern used in base mip-map, which is invalid."
                        );
                        return Err(TestError::Fail(
                            "Invalid color found in the layer-face's smallest mip-map".to_string(),
                        ));
                    }
                }
            }
        }
        Ok(())
    }
}

impl TestCase for Filterable {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        let mut fbo_id: GLuint = 0;
        let mut textures: Vec<GLuint> = Vec::new();

        let outcome = self.run(context, &base, &mut fbo_id, &mut textures);

        // `deinit`
        let gl = context.gl();
        // SAFETY: resets bindings and deletes the names this test created, on the current context.
        unsafe {
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, 0);
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0);
            if fbo_id != 0 {
                gl.delete_framebuffers(1, &fbo_id);
            }
            for to_id in &textures {
                gl.delete_textures(1, to_id);
            }
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 4);
            gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 4);
        }

        outcome.map(|()| TestStatus::pass("Pass"))
    }
}

impl TestCase for NonFilterable {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        // `TestCaseBase::init()` does not fail; upstream's `init` then rejects every non-ES context before the extension check.
        let _ = TestCaseBase::init(context, self.ext_params);
        let _ = self.storage_type;
        Err(TestError::NotSupported(
            "The test can be run only in ES context".to_string(),
        ))
    }
}
