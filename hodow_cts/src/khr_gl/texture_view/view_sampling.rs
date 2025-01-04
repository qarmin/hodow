// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cTextureViewTests.cpp  (TextureViewTestViewSampling)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The GLSL string literals are in shaders.rs (generated); the C++ `static unsigned int seed` of getRandomReferenceColor is a field of the state, so every run starts from 195.

use std::ffi::CString;

use super::shaders::{
    self, FILLER_FS_BODY, FILLER_GS_BODY, FILLER_VS_BODY, FS_BODY, GS_BODY, TC_BODY, TE_BODY, VARYING_NAMES, VS_BODY,
};
use super::tables::texture_target_string;
use super::utilities::legal_texture_and_view_target_combinations;
use super::{check_texture_view_support, shader_source, uniform_location};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const REFERENCE_TEXTURE_DEPTH: u32 = 4;
const REFERENCE_TEXTURE_HEIGHT: u32 = 4;
const REFERENCE_TEXTURE_N_MIPMAPS: u32 = 3;
const REFERENCE_TEXTURE_WIDTH: u32 = 4;

/// `_reference_color_storage`; the hierarchy is layers -> faces -> mipmaps -> samples.
struct ReferenceColorStorage {
    data: Vec<[f32; 4]>,
    n_faces: u32,
    n_layers: u32,
    n_mipmaps: u32,
    n_samples: u32,
}

impl ReferenceColorStorage {
    fn index(&self, n_layer: u32, n_face: u32, n_mipmap: u32, n_sample: u32) -> usize {
        debug_assert!(n_face < self.n_faces);
        debug_assert!(n_layer < self.n_layers);
        debug_assert!(n_mipmap < self.n_mipmaps);
        debug_assert!(n_sample < self.n_samples);

        (n_layer * (self.n_faces * self.n_mipmaps * self.n_samples)
            + n_face * (self.n_mipmaps * self.n_samples)
            + n_mipmap * self.n_samples
            + n_sample) as usize
    }
}

/// The GL objects and iteration state of one run; `TextureViewTestViewSampling::deinit` is the `Drop`.
struct State<'gl> {
    gl: &'gl glw::Functions,
    bo_id: GLuint,
    fs_id: GLuint,
    gs_id: GLuint,
    po_id: GLuint,
    po_lod_location: GLint,
    po_n_face_location: GLint,
    po_reference_colors_location: GLint,
    po_z_float_location: GLint,
    po_z_int_location: GLint,
    tc_id: GLuint,
    te_id: GLuint,
    vs_id: GLuint,

    per_sample_filler_fs_id: GLuint,
    per_sample_filler_gs_id: GLuint,
    per_sample_filler_po_id: GLuint,
    per_sample_filler_po_layer_id_location: GLint,
    per_sample_filler_po_reference_colors_location: GLint,
    per_sample_filler_vs_id: GLuint,

    result_to_id: GLuint,
    to_id: GLuint,
    view_to_id: GLuint,

    fbo_id: GLuint,
    vao_id: GLuint,

    max_color_texture_samples_gl_value: GLint,

    iteration_parent_texture_depth: u32,
    iteration_parent_texture_n_levels: u32,
    iteration_parent_texture_n_samples: u32,
    iteration_parent_texture_target: GLenum,
    iteration_view_texture_minlayer: u32,
    iteration_view_texture_numlayers: u32,
    iteration_view_texture_minlevel: u32,
    iteration_view_texture_numlevels: u32,
    iteration_view_texture_target: GLenum,

    reference_color_storage: Option<ReferenceColorStorage>,
    seed: u32,
}

impl Drop for State<'_> {
    fn drop(&mut self) {
        self.deinit_iteration_specific_program_and_shader_objects();
        self.deinit_per_sample_filler_program_and_shader_objects();
        self.deinit_texture_objects();

        let gl = self.gl;
        // SAFETY: every name below was created by this state, is deleted once and zero names are skipped.
        unsafe {
            if self.bo_id != 0 {
                gl.delete_buffers(1, &self.bo_id);
            }
            if self.fbo_id != 0 {
                gl.delete_framebuffers(1, &self.fbo_id);
            }
            if self.vao_id != 0 {
                gl.delete_vertex_arrays(1, &self.vao_id);
            }

            gl.patch_parameteri(glw::GL_PATCH_VERTICES, 3);
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 4);
            gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 4);
        }
    }
}

impl<'gl> State<'gl> {
    fn new(gl: &'gl glw::Functions) -> Self {
        Self {
            gl,
            bo_id: 0,
            fs_id: 0,
            gs_id: 0,
            po_id: 0,
            po_lod_location: -1,
            po_n_face_location: -1,
            po_reference_colors_location: -1,
            po_z_float_location: -1,
            po_z_int_location: -1,
            tc_id: 0,
            te_id: 0,
            vs_id: 0,
            per_sample_filler_fs_id: 0,
            per_sample_filler_gs_id: 0,
            per_sample_filler_po_id: 0,
            per_sample_filler_po_layer_id_location: -1,
            per_sample_filler_po_reference_colors_location: -1,
            per_sample_filler_vs_id: 0,
            result_to_id: 0,
            to_id: 0,
            view_to_id: 0,
            fbo_id: 0,
            vao_id: 0,
            max_color_texture_samples_gl_value: 0,
            iteration_parent_texture_depth: 0,
            iteration_parent_texture_n_levels: 0,
            iteration_parent_texture_n_samples: 0,
            iteration_parent_texture_target: glw::GL_NONE,
            iteration_view_texture_minlayer: 0,
            iteration_view_texture_numlayers: 0,
            iteration_view_texture_minlevel: 0,
            iteration_view_texture_numlevels: 0,
            iteration_view_texture_target: glw::GL_NONE,
            reference_color_storage: None,
            seed: 195,
        }
    }

    /// `deinitIterationSpecificProgramAndShaderObjects`
    fn deinit_iteration_specific_program_and_shader_objects(&mut self) {
        let gl = self.gl;
        // SAFETY: the names are this state's own; zero names are skipped and each is deleted once.
        unsafe {
            for shader in [&mut self.fs_id, &mut self.gs_id] {
                if *shader != 0 {
                    gl.delete_shader(*shader);
                    *shader = 0;
                }
            }
            if self.po_id != 0 {
                gl.delete_program(self.po_id);
                self.po_id = 0;
            }
            for shader in [&mut self.tc_id, &mut self.te_id, &mut self.vs_id] {
                if *shader != 0 {
                    gl.delete_shader(*shader);
                    *shader = 0;
                }
            }
        }
    }

    /// `deinitPerSampleFillerProgramAndShaderObjects`
    fn deinit_per_sample_filler_program_and_shader_objects(&mut self) {
        let gl = self.gl;
        // SAFETY: the names are this state's own; zero names are skipped and each is deleted once.
        unsafe {
            for shader in [&mut self.per_sample_filler_fs_id, &mut self.per_sample_filler_gs_id] {
                if *shader != 0 {
                    gl.delete_shader(*shader);
                    *shader = 0;
                }
            }
            if self.per_sample_filler_po_id != 0 {
                gl.delete_program(self.per_sample_filler_po_id);
                self.per_sample_filler_po_id = 0;
            }
            if self.per_sample_filler_vs_id != 0 {
                gl.delete_shader(self.per_sample_filler_vs_id);
                self.per_sample_filler_vs_id = 0;
            }
        }
    }

    /// `deinitTextureObjects`
    fn deinit_texture_objects(&mut self) {
        let gl = self.gl;
        // SAFETY: the names are this state's own; zero names are skipped and each is deleted once.
        unsafe {
            for texture in [&mut self.result_to_id, &mut self.to_id, &mut self.view_to_id] {
                if *texture != 0 {
                    gl.delete_textures(1, texture);
                    *texture = 0;
                }
            }
        }
    }

    /// `getRandomReferenceColor`
    fn random_reference_color(&mut self) -> [f32; 4] {
        let seed = self.seed;
        let result = [
            (seed % 255) as f32 / 255.0,
            ((seed << 3) % 255) as f32 / 255.0,
            ((seed << 4) % 255) as f32 / 255.0,
            ((seed << 5) % 255) as f32 / 255.0,
        ];

        self.seed += 17;

        result
    }

    /// `getReferenceColor`
    fn reference_color(&self, mut n_layer: u32, mut n_face: u32, n_mipmap: u32, n_sample: u32) -> [f32; 4] {
        let storage = self
            .reference_color_storage
            .as_ref()
            .expect("reference colours are initialised before they are read");

        let is_parent_texture_cm_cma = self.iteration_parent_texture_target == glw::GL_TEXTURE_CUBE_MAP
            || self.iteration_parent_texture_target == glw::GL_TEXTURE_CUBE_MAP_ARRAY;
        let is_view_texture_cm_cma = self.iteration_view_texture_target == glw::GL_TEXTURE_CUBE_MAP
            || self.iteration_view_texture_target == glw::GL_TEXTURE_CUBE_MAP_ARRAY;

        if is_view_texture_cm_cma && !is_parent_texture_cm_cma {
            n_layer = n_layer * 6 + n_face;
            n_face = 0;
        } else if !is_view_texture_cm_cma && is_parent_texture_cm_cma {
            n_face = n_layer % 6;
            n_layer /= 6;
        }

        storage.data[storage.index(n_layer, n_face, n_mipmap, n_sample)]
    }

    /// `setReferenceColor`
    fn set_reference_color(&mut self, n_layer: u32, n_face: u32, n_mipmap: u32, n_sample: u32, color: [f32; 4]) {
        let storage = self
            .reference_color_storage
            .as_mut()
            .expect("reference colours are initialised before they are set");
        let index = storage.index(n_layer, n_face, n_mipmap, n_sample);

        storage.data[index] = color;
    }

    /// `resetReferenceColorStorage`
    fn reset_reference_color_storage(&mut self, n_layers: u32, n_faces: u32, n_mipmaps: u32, n_samples: u32) {
        debug_assert!(n_layers >= 1 && n_faces >= 1 && n_mipmaps >= 1 && n_samples >= 1);

        self.reference_color_storage = Some(ReferenceColorStorage {
            data: vec![[0.0; 4]; (n_layers * n_faces * n_mipmaps * n_samples) as usize],
            n_faces,
            n_layers,
            n_mipmaps,
            n_samples,
        });
    }

    /// `getMaxConformantSampleCount`
    fn max_conformant_sample_count(&self, context: &Context, target: GLenum) -> Result<GLint, TestError> {
        let gl = self.gl;
        let mut max_conformant_samples: GLint = 0;

        if context
            .context_info
            .is_extension_supported("GL_NV_internalformat_sample_query")
        {
            let mut gl_sample_counts: GLint = 0;
            gl_call!(
                gl,
                "glGetInternalformativ() failed for GL_NUM_SAMPLE_COUNTS pname",
                gl.get_internalformativ(
                    target,
                    glw::GL_RGBA8,
                    glw::GL_NUM_SAMPLE_COUNTS,
                    1,
                    &mut gl_sample_counts
                )
            );

            let mut gl_supported_samples = vec![0 as GLint; gl_sample_counts.max(0) as usize];

            gl_call!(
                gl,
                "glGetInternalformativ() failed for GL_SAMPLES pname",
                gl.get_internalformativ(
                    target,
                    glw::GL_RGBA8,
                    glw::GL_SAMPLES,
                    gl_sample_counts,
                    gl_supported_samples.as_mut_ptr()
                )
            );

            for samples in gl_supported_samples {
                let mut is_conformant: GLint = 0;
                gl_call!(
                    gl,
                    "glGetInternalformatSampleivNV() call(s) failed",
                    gl.get_internalformat_sampleiv_nv(
                        target,
                        glw::GL_RGBA8,
                        samples,
                        glw::GL_CONFORMANT_NV,
                        1,
                        &mut is_conformant
                    )
                );

                if is_conformant != 0 && samples > max_conformant_samples {
                    max_conformant_samples = samples;
                }
            }
        } else {
            gl_call!(
                gl,
                "glGetIntegerv() call failed for GL_MAX_COLOR_TEXTURE_SAMPLES pname.",
                gl.get_integerv(glw::GL_MAX_COLOR_TEXTURE_SAMPLES, &mut max_conformant_samples)
            );
        }

        Ok(max_conformant_samples)
    }

    /// `initIterationSpecificProgramObject`
    fn init_iteration_specific_program_object(&mut self) -> Result<(), TestError> {
        let gl = self.gl;

        self.deinit_iteration_specific_program_and_shader_objects();

        // SAFETY: plain object creation with a current context.
        unsafe {
            self.fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            self.gs_id = gl.create_shader(glw::GL_GEOMETRY_SHADER);
            self.tc_id = gl.create_shader(glw::GL_TESS_CONTROL_SHADER);
            self.te_id = gl.create_shader(glw::GL_TESS_EVALUATION_SHADER);
            self.vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
        }
        crate::glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;

        // SAFETY: plain object creation with a current context.
        self.po_id = unsafe { gl.create_program() };
        crate::glu::expect_no_error(gl, "glCreateProgram() call(s) failed.")?;

        let n_samples = self.iteration_parent_texture_n_samples.to_string();
        let strings = shaders::sampler_strings(self.iteration_view_texture_target)?;

        let build = |template: &str, sample_fetch: &str| {
            template
                .replace("N_SAMPLES", &n_samples)
                .replace("SAMPLER_DECLARATIONS", strings.declarations)
                .replace("SAMPLE_FETCH", sample_fetch)
        };

        let vs_string = build(VS_BODY, strings.sample_fetch);
        let tc_string = build(TC_BODY, strings.sample_fetch);
        let te_string = build(TE_BODY, strings.sample_fetch);
        let gs_string = build(GS_BODY, strings.sample_fetch);
        let fs_string = build(FS_BODY, strings.sample_fetch_fs);

        shader_source(gl, self.fs_id, &fs_string, "glShaderSource() call(s) failed.")?;
        shader_source(gl, self.gs_id, &gs_string, "glShaderSource() call(s) failed.")?;
        shader_source(gl, self.tc_id, &tc_string, "glShaderSource() call(s) failed.")?;
        shader_source(gl, self.te_id, &te_string, "glShaderSource() call(s) failed.")?;
        shader_source(gl, self.vs_id, &vs_string, "glShaderSource() call(s) failed.")?;

        let so_ids = [self.fs_id, self.gs_id, self.tc_id, self.te_id, self.vs_id];
        let shader_sources = [&fs_string, &gs_string, &tc_string, &te_string, &vs_string];

        for (so_id, source) in so_ids.into_iter().zip(shader_sources) {
            let mut compile_status = glw::GL_FALSE as GLint;

            gl_call!(gl, "glCompileShader() call failed.", gl.compile_shader(so_id));
            gl_call!(
                gl,
                "glGetShaderiv() call failed.",
                gl.get_shaderiv(so_id, glw::GL_COMPILE_STATUS, &mut compile_status)
            );

            if compile_status != glw::GL_TRUE as GLint {
                let mut temp = [0u8; 1024];
                // SAFETY: the buffer is 1024 bytes long, as passed.
                unsafe { gl.get_shader_info_log(so_id, 1024, std::ptr::null_mut(), temp.as_mut_ptr().cast()) };
                let end = temp.iter().position(|&byte| byte == 0).unwrap_or(temp.len());

                log::info!(
                    "Shader compilation error log:\n{}\nShader source:\n{source}",
                    String::from_utf8_lossy(&temp[..end])
                );

                return Err(TestError::Fail("Shader compilation failed".to_string()));
            }

            gl_call!(gl, "glAttachShader() call failed", gl.attach_shader(self.po_id, so_id));
        }

        let varying_names: Vec<CString> = VARYING_NAMES
            .iter()
            .map(|name| CString::new(*name).expect("no NUL"))
            .collect();
        let varying_name_ptrs: Vec<_> = varying_names.iter().map(|name| name.as_ptr()).collect();
        gl_call!(
            gl,
            "glTransformFeedbackVaryings() call failed.",
            gl.transform_feedback_varyings(
                self.po_id,
                varying_name_ptrs.len() as GLint,
                varying_name_ptrs.as_ptr(),
                glw::GL_INTERLEAVED_ATTRIBS
            )
        );

        let mut link_status = glw::GL_FALSE as GLint;
        gl_call!(gl, "glLinkProgram() call failed.", gl.link_program(self.po_id));
        gl_call!(
            gl,
            "glGetProgramiv() call failed.",
            gl.get_programiv(self.po_id, glw::GL_LINK_STATUS, &mut link_status)
        );

        if link_status != glw::GL_TRUE as GLint {
            return Err(TestError::Fail("Program linking failed.".to_string()));
        }

        self.po_lod_location = uniform_location(gl, self.po_id, "lod");
        self.po_n_face_location = uniform_location(gl, self.po_id, "n_face");
        self.po_reference_colors_location = uniform_location(gl, self.po_id, "reference_colors");
        self.po_z_float_location = uniform_location(gl, self.po_id, "z_float");
        self.po_z_int_location = uniform_location(gl, self.po_id, "z_int");

        if self.po_reference_colors_location == -1 {
            return Err(TestError::Fail(
                "reference_colors is considered an inactive uniform which is invalid.".to_string(),
            ));
        }

        Ok(())
    }

    /// `initParentTextureContents`
    fn init_parent_texture_contents(&mut self) -> Result<(), TestError> {
        const CM_TEXTURE_TARGETS: [GLenum; 6] = [
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
        ];
        let gl = self.gl;

        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(self.iteration_parent_texture_target, self.to_id)
        );

        let is_arrayed_texture_target = self.iteration_parent_texture_target == glw::GL_TEXTURE_1D_ARRAY
            || self.iteration_parent_texture_target == glw::GL_TEXTURE_2D_ARRAY
            || self.iteration_parent_texture_target == glw::GL_TEXTURE_CUBE_MAP_ARRAY;
        let is_multisampled_texture_target = self.iteration_parent_texture_target == glw::GL_TEXTURE_2D_MULTISAMPLE
            || self.iteration_parent_texture_target == glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY;

        if !is_arrayed_texture_target && !is_multisampled_texture_target {
            debug_assert!(self.iteration_parent_texture_depth >= 1);
            debug_assert!(self.iteration_parent_texture_n_levels >= 1);

            let mut texture_targets = [
                self.iteration_parent_texture_target,
                glw::GL_NONE,
                glw::GL_NONE,
                glw::GL_NONE,
                glw::GL_NONE,
                glw::GL_NONE,
            ];
            let mut n_texture_targets = 1usize;

            if self.iteration_parent_texture_target == glw::GL_TEXTURE_CUBE_MAP {
                texture_targets = CM_TEXTURE_TARGETS;
                n_texture_targets = CM_TEXTURE_TARGETS.len();
            }

            self.reset_reference_color_storage(
                self.iteration_parent_texture_depth,
                n_texture_targets as u32,
                self.iteration_parent_texture_n_levels,
                1,
            );

            for (n_texture_target, texture_target) in texture_targets.into_iter().take(n_texture_targets).enumerate() {
                for n_layer in 0..self.iteration_parent_texture_depth {
                    let n_mipmaps_for_layer = if texture_target == glw::GL_TEXTURE_3D {
                        self.iteration_parent_texture_n_levels - n_layer
                    } else {
                        self.iteration_parent_texture_n_levels
                    };

                    for n_mipmap in 0..n_mipmaps_for_layer {
                        match texture_target {
                            glw::GL_TEXTURE_1D => {
                                gl_call!(
                                    gl,
                                    "glFramebufferTexture1D() call failed.",
                                    gl.framebuffer_texture_1d(
                                        glw::GL_DRAW_FRAMEBUFFER,
                                        glw::GL_COLOR_ATTACHMENT0,
                                        glw::GL_TEXTURE_1D,
                                        self.to_id,
                                        n_mipmap as GLint
                                    )
                                );
                            }
                            glw::GL_TEXTURE_2D
                            | glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X
                            | glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y
                            | glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z
                            | glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X
                            | glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y
                            | glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z
                            | glw::GL_TEXTURE_RECTANGLE => {
                                gl_call!(
                                    gl,
                                    "glFramebufferTexture2D() call failed.",
                                    gl.framebuffer_texture_2d(
                                        glw::GL_DRAW_FRAMEBUFFER,
                                        glw::GL_COLOR_ATTACHMENT0,
                                        texture_target,
                                        self.to_id,
                                        n_mipmap as GLint
                                    )
                                );
                            }
                            glw::GL_TEXTURE_3D => {
                                gl_call!(
                                    gl,
                                    "glFramebufferTexture3D() call failed.",
                                    gl.framebuffer_texture_3d(
                                        glw::GL_DRAW_FRAMEBUFFER,
                                        glw::GL_COLOR_ATTACHMENT0,
                                        glw::GL_TEXTURE_3D,
                                        self.to_id,
                                        n_mipmap as GLint,
                                        n_layer as GLint
                                    )
                                );
                            }
                            _ => return Err(TestError::Fail("Unrecognized texture target".to_string())),
                        }

                        let reference_color = self.random_reference_color();
                        self.set_reference_color(n_layer, n_texture_target as u32, n_mipmap, 0, reference_color);

                        gl_call!(
                            gl,
                            "glClearColor() call failed.",
                            gl.clear_color(
                                reference_color[0],
                                reference_color[1],
                                reference_color[2],
                                reference_color[3]
                            )
                        );
                        gl_call!(gl, "glClear() call failed.", gl.clear(glw::GL_COLOR_BUFFER_BIT));
                    }
                }
            }
        } else {
            debug_assert!(is_arrayed_texture_target || is_multisampled_texture_target);
            debug_assert!(self.iteration_parent_texture_depth >= 1);
            debug_assert!(self.iteration_parent_texture_n_levels >= 1);

            let n_faces: u32 = if self.iteration_parent_texture_target == glw::GL_TEXTURE_CUBE_MAP_ARRAY {
                6
            } else {
                1
            };

            self.reset_reference_color_storage(
                self.iteration_parent_texture_depth / n_faces,
                n_faces,
                self.iteration_parent_texture_n_levels,
                self.max_color_texture_samples_gl_value as u32,
            );

            let mut reference_colors = vec![0f32; 4 * self.max_color_texture_samples_gl_value as usize];

            gl_call!(
                gl,
                "glUseProgram() call failed.",
                gl.use_program(self.per_sample_filler_po_id)
            );

            for n_layer in 0..self.iteration_parent_texture_depth / n_faces {
                for n_face in 0..n_faces {
                    for n_mipmap in 0..self.iteration_parent_texture_n_levels {
                        if self.iteration_parent_texture_target != glw::GL_TEXTURE_2D_MULTISAMPLE {
                            gl_call!(
                                gl,
                                "glFramebufferTextureLayer() call failed.",
                                gl.framebuffer_texture(
                                    glw::GL_DRAW_FRAMEBUFFER,
                                    glw::GL_COLOR_ATTACHMENT0,
                                    self.to_id,
                                    n_mipmap as GLint
                                )
                            );
                        } else {
                            debug_assert!(self.iteration_parent_texture_depth == 1);
                            gl_call!(
                                gl,
                                "glFramebufferTexture2D() call failed.",
                                gl.framebuffer_texture_2d(
                                    glw::GL_DRAW_FRAMEBUFFER,
                                    glw::GL_COLOR_ATTACHMENT0,
                                    self.iteration_parent_texture_target,
                                    self.to_id,
                                    n_mipmap as GLint
                                )
                            );
                        }

                        let n_samples = if is_multisampled_texture_target {
                            self.max_color_texture_samples_gl_value as u32
                        } else {
                            1
                        };

                        for n_sample in 0..n_samples {
                            let reference_color = self.random_reference_color();

                            reference_colors[4 * n_sample as usize..4 * n_sample as usize + 4]
                                .copy_from_slice(&reference_color);

                            self.set_reference_color(n_layer, n_face, n_mipmap, n_sample, reference_color);
                        }

                        gl_call!(
                            gl,
                            "glUniform4fv() call failed.",
                            gl.uniform_4fv(
                                self.per_sample_filler_po_reference_colors_location,
                                n_samples as GLint,
                                reference_colors.as_ptr()
                            )
                        );

                        let layer_id = n_layer * n_faces + n_face;
                        gl_call!(
                            gl,
                            "glUniform1i() call failed.",
                            gl.uniform_1i(self.per_sample_filler_po_layer_id_location, layer_id as GLint)
                        );

                        gl_call!(gl, "glDrawArrays() call failed.", gl.draw_arrays(glw::GL_POINTS, 0, 1));
                    }
                }
            }
        }

        Ok(())
    }

    /// `initPerSampleFillerProgramObject`
    fn init_per_sample_filler_program_object(&mut self) -> Result<(), TestError> {
        let gl = self.gl;

        debug_assert!(self.max_color_texture_samples_gl_value != 0);

        // SAFETY: plain object creation with a current context.
        unsafe {
            self.per_sample_filler_fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            self.per_sample_filler_gs_id = gl.create_shader(glw::GL_GEOMETRY_SHADER);
            self.per_sample_filler_vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
        }
        crate::glu::expect_no_error(gl, "glCreateShader() call(s) failed.")?;

        // SAFETY: plain object creation with a current context.
        self.per_sample_filler_po_id = unsafe { gl.create_program() };
        crate::glu::expect_no_error(gl, "glCreateProgram() call failed.")?;

        let fs_body_string =
            FILLER_FS_BODY.replace("N_MAX_SAMPLES", &self.max_color_texture_samples_gl_value.to_string());

        shader_source(
            gl,
            self.per_sample_filler_fs_id,
            &fs_body_string,
            "glShaderSource() call failed.",
        )?;
        shader_source(
            gl,
            self.per_sample_filler_gs_id,
            FILLER_GS_BODY,
            "glShaderSource() call failed.",
        )?;
        shader_source(
            gl,
            self.per_sample_filler_vs_id,
            FILLER_VS_BODY,
            "glShaderSource() call failed.",
        )?;

        gl_call!(gl, "glAttachShader() call(s) failed.", {
            gl.attach_shader(self.per_sample_filler_po_id, self.per_sample_filler_fs_id);
            gl.attach_shader(self.per_sample_filler_po_id, self.per_sample_filler_gs_id);
            gl.attach_shader(self.per_sample_filler_po_id, self.per_sample_filler_vs_id);
        });

        for so_id in [
            self.per_sample_filler_fs_id,
            self.per_sample_filler_gs_id,
            self.per_sample_filler_vs_id,
        ] {
            let mut compile_status = glw::GL_FALSE as GLint;

            gl_call!(gl, "glCompileShader() call failed.", gl.compile_shader(so_id));
            gl_call!(
                gl,
                "glGetShaderiV() call failed.",
                gl.get_shaderiv(so_id, glw::GL_COMPILE_STATUS, &mut compile_status)
            );

            if compile_status != glw::GL_TRUE as GLint {
                return Err(TestError::Fail("Shader compilation failed.".to_string()));
            }
        }

        let mut link_status = glw::GL_FALSE as GLint;
        gl_call!(
            gl,
            "glLinkProgram() call failed.",
            gl.link_program(self.per_sample_filler_po_id)
        );
        gl_call!(
            gl,
            "glGetProgramiv() call failed.",
            gl.get_programiv(self.per_sample_filler_po_id, glw::GL_LINK_STATUS, &mut link_status)
        );

        if link_status != glw::GL_TRUE as GLint {
            return Err(TestError::Fail("Program linking failed.".to_string()));
        }

        self.per_sample_filler_po_layer_id_location = uniform_location(gl, self.per_sample_filler_po_id, "layer_id");
        self.per_sample_filler_po_reference_colors_location =
            uniform_location(gl, self.per_sample_filler_po_id, "reference_colors[0]");

        if self.per_sample_filler_po_layer_id_location == -1 {
            return Err(TestError::Fail(
                "layer_id uniform is considered inactive which is invalid".to_string(),
            ));
        }

        if self.per_sample_filler_po_reference_colors_location == -1 {
            return Err(TestError::Fail(
                "reference_colors uniform is considered inactive which is invalid".to_string(),
            ));
        }

        Ok(())
    }

    /// `initTest`
    fn init_test(&mut self) -> Result<(), TestError> {
        let gl = self.gl;

        gl_call!(gl, "glGenBuffers() call failed.", gl.gen_buffers(1, &mut self.bo_id));
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.bo_id)
        );
        gl_call!(
            gl,
            "glBufferData() call failed.",
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                (6 * (4 * std::mem::size_of::<i32>())) as isize,
                std::ptr::null(),
                glw::GL_STATIC_DRAW
            )
        );

        gl_call!(
            gl,
            "glGenFramebuffers() call failed.",
            gl.gen_framebuffers(1, &mut self.fbo_id)
        );
        gl_call!(
            gl,
            "glBindFramebuffer() call failed.",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo_id)
        );

        gl_call!(
            gl,
            "glGenVertexArrays() call failed.",
            gl.gen_vertex_arrays(1, &mut self.vao_id)
        );
        gl_call!(
            gl,
            "glBindVertexArray() call failed.",
            gl.bind_vertex_array(self.vao_id)
        );

        gl_call!(
            gl,
            "glGenTextures() call failed.",
            gl.gen_textures(1, &mut self.result_to_id)
        );
        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_2D, self.result_to_id)
        );
        gl_call!(
            gl,
            "glTexStorage2D() call failed.",
            gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                1,
                glw::GL_RGBA8,
                REFERENCE_TEXTURE_WIDTH as GLint,
                REFERENCE_TEXTURE_HEIGHT as GLint
            )
        );

        gl_call!(
            gl,
            "glGetIntegerv() call failed for GL_MAX_COLOR_TEXTURE_SAMPLES pname.",
            gl.get_integerv(
                glw::GL_MAX_COLOR_TEXTURE_SAMPLES,
                &mut self.max_color_texture_samples_gl_value
            )
        );

        gl_call!(gl, "glPixelStorei() call(s) failed.", {
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1);
            gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
        });

        gl_call!(
            gl,
            "glPatchParameteri() call failed.",
            gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1)
        );

        Ok(())
    }

    /// `initTextureObject`
    fn init_texture_object(
        &mut self,
        context: &Context,
        is_view_texture: bool,
        texture_target: GLenum,
        view_texture_target: GLenum,
    ) -> Result<(), TestError> {
        let gl = self.gl;

        debug_assert!(texture_target != glw::GL_TEXTURE_BUFFER);
        debug_assert!(view_texture_target != glw::GL_TEXTURE_BUFFER);

        let mut texture_depth = if view_texture_target == glw::GL_TEXTURE_CUBE_MAP_ARRAY {
            13
        } else if view_texture_target == glw::GL_TEXTURE_CUBE_MAP {
            7
        } else {
            REFERENCE_TEXTURE_DEPTH
        };

        if texture_target == glw::GL_TEXTURE_CUBE_MAP_ARRAY {
            texture_depth = 6 * 3;
        }

        let existing = if is_view_texture { self.view_to_id } else { self.to_id };
        if existing != 0 {
            gl_call!(gl, "glDeleteTextures() call failed.", gl.delete_textures(1, &existing));
        }

        let mut new_id: GLuint = 0;
        gl_call!(gl, "glGenTextures() call failed.", gl.gen_textures(1, &mut new_id));
        if is_view_texture {
            self.view_to_id = new_id;
        } else {
            self.to_id = new_id;
        }

        if is_view_texture {
            let minlevel: u32;
            let numlayers: u32;
            let mut numlevels: u32 = 2;
            let is_texture_arrayed_texture_target = texture_target == glw::GL_TEXTURE_1D_ARRAY
                || texture_target == glw::GL_TEXTURE_2D_ARRAY
                || texture_target == glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
                || texture_target == glw::GL_TEXTURE_CUBE_MAP_ARRAY;
            let is_texture_cube_map_texture_target = texture_target == glw::GL_TEXTURE_CUBE_MAP;
            let is_texture_multisample_texture_target = texture_target == glw::GL_TEXTURE_2D_MULTISAMPLE
                || texture_target == glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY;
            let is_texture_rectangle_texture_target = texture_target == glw::GL_TEXTURE_RECTANGLE;
            let is_view_arrayed_texture_target = view_texture_target == glw::GL_TEXTURE_1D_ARRAY
                || view_texture_target == glw::GL_TEXTURE_2D_ARRAY
                || view_texture_target == glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
                || view_texture_target == glw::GL_TEXTURE_CUBE_MAP_ARRAY;
            let is_view_cube_map_texture_target = view_texture_target == glw::GL_TEXTURE_CUBE_MAP;
            let is_view_cube_map_array_texture_target = view_texture_target == glw::GL_TEXTURE_CUBE_MAP_ARRAY;

            if is_texture_multisample_texture_target || is_texture_rectangle_texture_target {
                minlevel = 0;
                numlevels = 1;
            } else {
                minlevel = 1;
            }

            let minlayer: u32 = if is_texture_arrayed_texture_target
                || (!is_texture_cube_map_texture_target && is_view_cube_map_texture_target)
                || (!is_texture_cube_map_texture_target && is_view_cube_map_array_texture_target)
            {
                1
            } else {
                0
            };

            if !is_texture_cube_map_texture_target && is_view_cube_map_array_texture_target {
                numlayers = 12;
            } else if is_view_cube_map_texture_target || is_view_cube_map_array_texture_target {
                numlayers = 6;
            } else if is_view_arrayed_texture_target {
                if is_texture_arrayed_texture_target || is_texture_cube_map_texture_target {
                    numlayers = 2;
                } else {
                    numlayers = 1;
                }
            } else {
                numlayers = 1;
            }

            gl_call!(
                gl,
                "glTextureView() call failed.",
                gl.texture_view(
                    self.view_to_id,
                    view_texture_target,
                    self.to_id,
                    glw::GL_RGBA8,
                    minlevel,
                    numlevels,
                    minlayer,
                    numlayers
                )
            );

            self.iteration_view_texture_minlayer = minlayer;
            self.iteration_view_texture_minlevel = minlevel;
            self.iteration_view_texture_numlayers = numlayers;
            self.iteration_view_texture_numlevels = numlevels;
            self.iteration_view_texture_target = view_texture_target;

            log::info!(
                "Created a view for texture target [{}] from a parent texture target [{}] using arguments: minlayer:[{minlayer}] minlevel:[{minlevel}] numlayers:[{numlayers}] numlevels:[{numlevels}].",
                texture_target_string(view_texture_target),
                texture_target_string(texture_target)
            );

            gl_call!(
                gl,
                "glBindTexture() call failed.",
                gl.bind_texture(view_texture_target, self.view_to_id)
            );
        } else {
            self.iteration_parent_texture_depth = 1;
            self.iteration_parent_texture_n_levels = 1;
            self.iteration_parent_texture_n_samples = 1;

            gl_call!(
                gl,
                "glBindTexture() call failed.",
                gl.bind_texture(texture_target, self.to_id)
            );

            if texture_target == glw::GL_TEXTURE_2D_MULTISAMPLE
                || texture_target == glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
            {
                self.max_color_texture_samples_gl_value = self.max_conformant_sample_count(context, texture_target)?;
            } else {
                gl_call!(
                    gl,
                    "glGetIntegerv() call failed for GL_MAX_COLOR_TEXTURE_SAMPLES pname.",
                    gl.get_integerv(
                        glw::GL_MAX_COLOR_TEXTURE_SAMPLES,
                        &mut self.max_color_texture_samples_gl_value
                    )
                );
            }

            let target_name = texture_target_string(texture_target);
            let n_mipmaps = REFERENCE_TEXTURE_N_MIPMAPS as GLint;
            let width = REFERENCE_TEXTURE_WIDTH as GLint;
            let height = REFERENCE_TEXTURE_HEIGHT as GLint;
            let depth = texture_depth as GLint;

            match texture_target {
                glw::GL_TEXTURE_1D => {
                    gl_call!(
                        gl,
                        "glTexStorage1D() call failed.",
                        gl.tex_storage_1d(texture_target, n_mipmaps, glw::GL_RGBA8, width)
                    );

                    self.iteration_parent_texture_n_levels = REFERENCE_TEXTURE_N_MIPMAPS;

                    log::info!(
                        "Created an immutable parent texture object for texture target [{target_name}] of levels:[{n_mipmaps}] width:[{width}]."
                    );
                }
                glw::GL_TEXTURE_1D_ARRAY => {
                    gl_call!(
                        gl,
                        "glTexStorage2D() call failed.",
                        gl.tex_storage_2d(texture_target, n_mipmaps, glw::GL_RGBA8, width, depth)
                    );

                    self.iteration_parent_texture_depth = texture_depth;
                    self.iteration_parent_texture_n_levels = REFERENCE_TEXTURE_N_MIPMAPS;

                    log::info!(
                        "Created an immutable parent texture object for texture target [{target_name}] of depth:[{depth}] levels:[{n_mipmaps}] width:[{width}]."
                    );
                }
                glw::GL_TEXTURE_CUBE_MAP | glw::GL_TEXTURE_2D => {
                    gl_call!(
                        gl,
                        "glTexStorage2D() call failed.",
                        gl.tex_storage_2d(texture_target, n_mipmaps, glw::GL_RGBA8, width, height)
                    );
                    self.iteration_parent_texture_n_levels = REFERENCE_TEXTURE_N_MIPMAPS;

                    log::info!(
                        "Created an immutable parent texture object for texture target [{target_name}] of levels:[{n_mipmaps}] width:[{width}] height:[{height}]."
                    );
                }
                glw::GL_TEXTURE_RECTANGLE => {
                    gl_call!(
                        gl,
                        "glTexStorage2D() call failed.",
                        gl.tex_storage_2d(texture_target, 1, glw::GL_RGBA8, width, height)
                    );

                    log::info!(
                        "Created an immutable parent texture object for texture target [{target_name}] of levels:1 width:[{width}] height:[{height}]."
                    );
                }
                glw::GL_TEXTURE_2D_ARRAY => {
                    gl_call!(
                        gl,
                        "glTexStorage3D() call failed.",
                        gl.tex_storage_3d(texture_target, n_mipmaps, glw::GL_RGBA8, width, height, depth)
                    );

                    self.iteration_parent_texture_depth = texture_depth;
                    self.iteration_parent_texture_n_levels = REFERENCE_TEXTURE_N_MIPMAPS;

                    log::info!(
                        "Created an immutable parent texture object for texture target [{target_name}] of depth:[{depth}] levels:[{n_mipmaps}] width:[{width}] height:[{height}]."
                    );
                }
                glw::GL_TEXTURE_2D_MULTISAMPLE => {
                    gl_call!(
                        gl,
                        "glTexStorage2DMultisample() call failed.",
                        gl.tex_storage_2d_multisample(
                            texture_target,
                            self.max_color_texture_samples_gl_value,
                            glw::GL_RGBA8,
                            width,
                            height,
                            glw::TRUE
                        )
                    );
                    self.iteration_parent_texture_n_samples = self.max_color_texture_samples_gl_value as u32;

                    log::info!(
                        "Created an immutable parent texture object for texture target [{target_name}] of samples:[{}] width:[{width}] height:[{height}].",
                        self.max_color_texture_samples_gl_value
                    );
                }
                glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => {
                    gl_call!(
                        gl,
                        "glTexStorage3DMultisample() call failed.",
                        gl.tex_storage_3d_multisample(
                            texture_target,
                            self.max_color_texture_samples_gl_value,
                            glw::GL_RGBA8,
                            width,
                            height,
                            depth,
                            glw::TRUE
                        )
                    );

                    self.iteration_parent_texture_depth = texture_depth;
                    self.iteration_parent_texture_n_samples = self.max_color_texture_samples_gl_value as u32;

                    log::info!(
                        "Created an immutable parent texture object for texture target [{target_name}] of samples:[{}] width:[{width}] height:[{height}] depth:[{depth}].",
                        self.max_color_texture_samples_gl_value
                    );
                }
                glw::GL_TEXTURE_3D | glw::GL_TEXTURE_CUBE_MAP_ARRAY => {
                    gl_call!(
                        gl,
                        "glTexStorage3D() call failed.",
                        gl.tex_storage_3d(texture_target, n_mipmaps, glw::GL_RGBA8, width, height, depth)
                    );

                    self.iteration_parent_texture_depth = texture_depth;
                    self.iteration_parent_texture_n_levels = REFERENCE_TEXTURE_N_MIPMAPS;

                    log::info!(
                        "Created an immutable parent texture object for texture target [{target_name}] of levels:[{n_mipmaps}] width:[{width}] height:[{height}] depth:[{depth}]."
                    );
                }
                _ => return Err(TestError::Fail("Unrecognized texture target.".to_string())),
            }

            self.iteration_parent_texture_target = texture_target;
        }

        if texture_target != glw::GL_TEXTURE_2D_MULTISAMPLE
            && texture_target != glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
            && texture_target != glw::GL_TEXTURE_RECTANGLE
        {
            gl_call!(gl, "glTexParameteri() call(s) failed.", {
                gl.tex_parameteri(texture_target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
                gl.tex_parameteri(
                    texture_target,
                    glw::GL_TEXTURE_MIN_FILTER,
                    glw::GL_NEAREST_MIPMAP_NEAREST as GLint,
                );
            });
        }

        Ok(())
    }

    /// `executeTest`
    fn execute_test(&mut self) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut result = true;

        gl_call!(
            gl,
            "glActiveTexture() call failed.",
            gl.active_texture(glw::GL_TEXTURE0)
        );
        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(self.iteration_view_texture_target, self.view_to_id)
        );

        gl_call!(
            gl,
            "glBindBufferBase() call failed.",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.bo_id)
        );

        gl_call!(gl, "glUseProgram() call failed.", gl.use_program(self.po_id));

        gl_call!(
            gl,
            "glBindFramebuffer() call failed.",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo_id)
        );
        gl_call!(
            gl,
            "glFramebufferTexture2D() call failed.",
            gl.framebuffer_texture_2d(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                self.result_to_id,
                0
            )
        );

        let mut reference_color_data = vec![0f32; self.iteration_parent_texture_n_samples as usize * 4];

        let is_view_cm_cma = self.iteration_view_texture_target == glw::GL_TEXTURE_CUBE_MAP
            || self.iteration_view_texture_target == glw::GL_TEXTURE_CUBE_MAP_ARRAY;

        let mut n_current_layer = self.iteration_view_texture_minlayer;
        while n_current_layer < self.iteration_view_texture_minlayer + self.iteration_view_texture_numlayers && result {
            let (n_texture_face, n_texture_layer, n_view_face, n_view_layer) = if is_view_cm_cma {
                (
                    n_current_layer % 6,
                    n_current_layer / 6,
                    (n_current_layer - self.iteration_view_texture_minlayer) % 6,
                    (n_current_layer - self.iteration_view_texture_minlayer) / 6,
                )
            } else {
                (0, n_current_layer, 0, n_current_layer)
            };

            if self.po_z_float_location != -1 {
                let mut z = 0.0f32;

                if (!is_view_cm_cma && self.iteration_view_texture_numlayers > 1)
                    || (is_view_cm_cma && self.iteration_view_texture_numlayers > 6)
                {
                    if is_view_cm_cma {
                        z = n_view_layer as f32 / (self.iteration_view_texture_numlayers / 6 - 1) as f32;
                    } else if self.iteration_view_texture_numlayers > 1 {
                        z = n_view_layer.wrapping_sub(self.iteration_view_texture_minlayer) as f32
                            / (self.iteration_view_texture_numlayers - 1) as f32;
                    }
                }

                gl_call!(
                    gl,
                    "glUniform1f() call failed.",
                    gl.uniform_1f(self.po_z_float_location, z)
                );
            }

            if self.po_z_int_location != -1 {
                debug_assert!(!is_view_cm_cma);
                gl_call!(
                    gl,
                    "glUniform1i() call failed.",
                    gl.uniform_1i(
                        self.po_z_int_location,
                        (n_current_layer - self.iteration_view_texture_minlayer) as GLint
                    )
                );
            }

            if self.po_n_face_location != -1 {
                gl_call!(
                    gl,
                    "glUniform1i() call failed.",
                    gl.uniform_1i(self.po_n_face_location, n_view_face as GLint)
                );
            }

            let mut n_mipmap = self.iteration_view_texture_minlevel;
            while n_mipmap < self.iteration_view_texture_minlevel + self.iteration_view_texture_numlevels && result {
                if self.po_lod_location != -1 {
                    gl_call!(
                        gl,
                        "glUniform1i() call failed.",
                        gl.uniform_1f(
                            self.po_lod_location,
                            (n_mipmap - self.iteration_view_texture_minlevel) as f32
                        )
                    );
                }

                for n_sample in 0..self.iteration_parent_texture_n_samples {
                    let reference_color = self.reference_color(n_texture_layer, n_texture_face, n_mipmap, n_sample);

                    reference_color_data[4 * n_sample as usize..4 * n_sample as usize + 4]
                        .copy_from_slice(&reference_color);
                }

                gl_call!(
                    gl,
                    "glUniform4fv() call failed.",
                    gl.uniform_4fv(
                        self.po_reference_colors_location,
                        self.iteration_parent_texture_n_samples as GLint,
                        reference_color_data.as_ptr()
                    )
                );

                gl_call!(
                    gl,
                    "glBindTexture() call failed.",
                    gl.bind_texture(self.iteration_view_texture_target, self.view_to_id)
                );

                gl_call!(
                    gl,
                    "glBeginTransformFeedback() call failed.",
                    gl.begin_transform_feedback(glw::GL_TRIANGLES)
                );
                gl_call!(gl, "glDrawArrays() call failed.", gl.draw_arrays(glw::GL_PATCHES, 0, 1));
                gl_call!(gl, "glEndTransformFeedback() call failed.", gl.end_transform_feedback());

                // SAFETY: the transform feedback buffer holds 6 vertices of 4 integers each, see init_test.
                let bo_storage_ptr =
                    unsafe { gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY) } as *const GLint;
                crate::glu::expect_no_error(gl, "glMapBuffer() call failed.")?;

                if bo_storage_ptr.is_null() {
                    return Err(TestError::Fail(
                        "glMapBuffer() call succeeded but the pointer returned is NULL".to_string(),
                    ));
                }

                // SAFETY: see the mapping above.
                let bo_storage = unsafe { std::slice::from_raw_parts(bo_storage_ptr, 6 * 4) }.to_vec();

                let mut n_vertex = 0;
                while n_vertex < 6 && result {
                    let vertex_data = &bo_storage[n_vertex * 4..n_vertex * 4 + 4];

                    if vertex_data[0] != 1 {
                        log::info!("Invalid data was sampled in vertex shader stage.");
                        result = false;
                    }

                    if vertex_data[1] != 1 {
                        log::info!("Invalid data was sampled in tessellation control shader stage.");
                        result = false;
                    }

                    if vertex_data[2] != 1 {
                        log::info!("Invalid data was sampled in tessellation evaluation shader stage.");
                        result = false;
                    }

                    if vertex_data[3] != 1 {
                        log::info!("Invalid data was sampled in geometry shader stage.");
                        result = false;
                    }

                    n_vertex += 1;
                }

                gl_call!(
                    gl,
                    "glUnmapBuffer() call failed.",
                    gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER)
                );

                let mut result_data = vec![0u8; (REFERENCE_TEXTURE_WIDTH * REFERENCE_TEXTURE_HEIGHT * 4) as usize];
                gl_call!(
                    gl,
                    "glBindTexture() call failed for GL_TEXTURE_2D texture target.",
                    gl.bind_texture(glw::GL_TEXTURE_2D, self.result_to_id)
                );
                gl_call!(
                    gl,
                    "glGetTexImage() call failed.",
                    gl.get_tex_image(
                        glw::GL_TEXTURE_2D,
                        0,
                        glw::GL_RGBA,
                        glw::GL_UNSIGNED_BYTE,
                        result_data.as_mut_ptr().cast()
                    )
                );

                let mut fs_result = true;
                let mut y = 0;
                while y < REFERENCE_TEXTURE_HEIGHT as usize && fs_result {
                    let row_offset = REFERENCE_TEXTURE_WIDTH as usize * y * 4;
                    let mut x = 0;

                    while x < REFERENCE_TEXTURE_WIDTH as usize && fs_result {
                        let pixel = &result_data[row_offset + x * 4..row_offset + x * 4 + 4];

                        if pixel.iter().any(|&component| component != 255) {
                            log::info!("Invalid data was sampled at ({x}, {y}) in fragment shader stage.");
                            fs_result = false;
                        }

                        x += 1;
                    }

                    y += 1;
                }

                if !fs_result {
                    result = false;
                }

                n_mipmap += 1;
            }

            n_current_layer += 1;
        }

        Ok(result)
    }
}

/// `TextureViewTestViewSampling`
pub(super) struct ViewSampling;

impl TestCase for ViewSampling {
    fn name(&self) -> &str {
        "view_sampling"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut has_failed = false;

        check_texture_view_support(context)?;

        let mut state = State::new(gl);

        state.init_test()?;
        state.init_per_sample_filler_program_object()?;

        for (parent_texture_target, view_texture_target) in legal_texture_and_view_target_combinations() {
            state.init_texture_object(context, false, parent_texture_target, view_texture_target)?;
            state.init_texture_object(context, true, parent_texture_target, view_texture_target)?;
            state.init_parent_texture_contents()?;

            state.init_iteration_specific_program_object()?;

            if !state.execute_test()? {
                has_failed = true;
                log::info!("Test case failed.");
            } else {
                log::info!("Test case succeeded.");
            }
        }

        if !has_failed {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Fail"))
        }
    }
}
