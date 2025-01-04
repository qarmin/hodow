// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayImageTextureSize.cpp
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayImageTextureSize.hpp
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArrayImageTextureSizeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The class hierarchy (Base, TFBase, RTBase and the six leaves) is one `Runner` switching on `Kind`; desktop only, so mutable storage is always tested. The Tests class that adds the six cases is `create_tests` in mod.rs.

use super::{StorageType, TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `GEOMETRY_SHADER_EXTENSION_NOT_SUPPORTED`
const GEOMETRY_SHADER_EXTENSION_NOT_SUPPORTED: &str = "Geometry shader functionality not supported, skipping";
/// `TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED`
const TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED: &str = "Tessellation shader functionality not supported, skipping";

const N_LAYERS_PER_CUBE: GLuint = 6;
const N_TEXTURE_COMPONENTS: usize = 4;
const N_VARYINGS: usize = 2;
const N_TF_COMPONENTS: usize = 3;

/// `resolutionArray`: width, height, depth
const RESOLUTION_ARRAY: [[GLuint; 3]; 4] = [[32, 32, 18], [64, 64, 6], [128, 128, 12], [256, 256, 12]];

const NOOP_FRAGMENT_SHADER_CODE: &str = "${VERSION}\n\nprecision highp float;\n\nvoid main()\n{\n}\n";

const POSITION_ONLY_VERTEX_SHADER_CODE: &str =
    "${VERSION}\n\nprecision highp float;\n\nvoid main()\n{\n    gl_Position      = vec4(0.0f,0.0f,0.0f,0.0f);\n}\n";

const TF_VERTEX_SHADER_CODE: &str = "${VERSION}\n\n${TEXTURE_CUBE_MAP_ARRAY_REQUIRE}\n\nprecision highp float;\n\nuniform highp samplerCubeArray       texture_std_sampler;\nuniform highp samplerCubeArrayShadow texture_shw_sampler;\n\nlayout (location = 0) out flat uvec3 texture_std_size;\nlayout (location = 1) out flat uvec3 texture_shw_size;\n\nvoid main()\n{\n    gl_PointSize = 1.0f;\n\n    texture_std_size = uvec3( textureSize(texture_std_sampler, 0) );\n    texture_shw_size = uvec3( textureSize(texture_shw_sampler, 0) );\n    gl_Position      = vec4(0.0f,0.0f,0.0f,0.0f);\n}\n";

const GEOMETRY_SHADER_CODE: &str = "${VERSION}\n\n${GEOMETRY_SHADER_ENABLE}\n${TEXTURE_CUBE_MAP_ARRAY_REQUIRE}\n\nprecision highp float;\n\nuniform highp samplerCubeArray       texture_std_sampler;\nuniform highp samplerCubeArrayShadow texture_shw_sampler;\n\nlayout (location = 0) out flat uvec3 texture_std_size;\nlayout (location = 1) out flat uvec3 texture_shw_size;\n\nlayout(points)                 in;\nlayout(points, max_vertices=1) out;\n\nvoid main()\n{\n    texture_std_size = uvec3( textureSize(texture_std_sampler, 0) );\n    texture_shw_size = uvec3( textureSize(texture_shw_sampler, 0) );\n    gl_Position      = vec4(0.0f,0.0f,0.0f,0.0f);\n    EmitVertex();\n    EndPrimitive();\n}\n";

const TESS_CONTROL_SHADER_CODE: &str = "${VERSION}\n\n${TESSELLATION_SHADER_ENABLE}\n${TEXTURE_CUBE_MAP_ARRAY_REQUIRE}\n\nprecision highp float;\n\nuniform highp samplerCubeArray       texture_std_sampler;\nuniform highp samplerCubeArrayShadow texture_shw_sampler;\n\nlayout (location = 0) out flat uvec3 texture_std_size_array[];\nlayout (location = 1) out flat uvec3 texture_shw_size_array[];\n\nlayout (vertices = 1) out;\n\nvoid main()\n{\n    gl_TessLevelInner[0] = 1.0;\n    gl_TessLevelInner[1] = 1.0;\n    gl_TessLevelOuter[0] = 1.0;\n    gl_TessLevelOuter[1] = 1.0;\n    gl_TessLevelOuter[2] = 1.0;\n    gl_TessLevelOuter[3] = 1.0;\n    texture_std_size_array[gl_InvocationID]    = uvec3( textureSize(texture_std_sampler, 0) );\n    texture_shw_size_array[gl_InvocationID]    = uvec3( textureSize(texture_shw_sampler, 0) );\n    gl_out[gl_InvocationID].gl_Position        = vec4(0.0f,0.0f,0.0f,0.0f);\n}\n";

const TESS_EVALUATION_SHADER_FOR_CONTROL_CODE: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n\nlayout(isolines, point_mode) in;\n\nin layout(location = 0) flat uvec3 texture_std_size_array[];\nin layout(location = 1) flat uvec3 texture_shw_size_array[];\n\nout flat uvec3 texture_std_size;\nout flat uvec3 texture_shw_size;\n\nvoid main()\n{\n    texture_std_size = texture_std_size_array[0];\n    texture_shw_size = texture_shw_size_array[0];\n    gl_Position      = vec4(0.0f,0.0f,0.0f,0.0f);\n}\n";

const TESS_CONTROL_SHADER_FOR_EVALUATION_CODE: &str = "${VERSION}\n\n${TESSELLATION_SHADER_ENABLE}\n\nprecision highp float;\n\nlayout (vertices = 1) out;\n\nvoid main()\n{\n    gl_TessLevelInner[0] = 1.0;\n    gl_TessLevelInner[1] = 1.0;\n    gl_TessLevelOuter[0] = 1.0;\n    gl_TessLevelOuter[1] = 1.0;\n    gl_TessLevelOuter[2] = 1.0;\n    gl_TessLevelOuter[3] = 1.0;\n    gl_out[gl_InvocationID].gl_Position = vec4(0.0f,0.0f,0.0f,0.0f);\n}\n";

const TESS_EVALUATION_SHADER_CODE: &str = "${VERSION}\n\n${TESSELLATION_SHADER_REQUIRE}\n${TEXTURE_CUBE_MAP_ARRAY_REQUIRE}\n\nlayout(isolines, point_mode) in;\n\nuniform highp samplerCubeArray       texture_std_sampler;\nuniform highp samplerCubeArrayShadow texture_shw_sampler;\n\nlayout (location = 0) out flat uvec3 texture_std_size;\nlayout (location = 1) out flat uvec3 texture_shw_size;\n\nvoid main()\n{\n    texture_std_size   = uvec3( textureSize(texture_std_sampler, 0) );\n    texture_shw_size   = uvec3( textureSize(texture_shw_sampler, 0) );\n    gl_Position        = vec4(0.0f,0.0f,0.0f,0.0f);\n}\n";

const RT_VERTEX_SHADER_CODE: &str = "${VERSION}\n\nprecision highp float;\n\nvoid main()\n{\n    gl_PointSize = 1.0f;\n    gl_Position = vec4(0, 0, 0, 1.0f);\n}\n";

const RT_FRAGMENT_SHADER_CODE: &str = "${VERSION}\n\n${TEXTURE_CUBE_MAP_ARRAY_REQUIRE}\n\nprecision highp float;\n\nuniform highp samplerCubeArray       texture_std_sampler;\nuniform highp samplerCubeArrayShadow texture_shw_sampler;\n\nlayout (location = 0) out uvec4 texture_std_size;\nlayout (location = 1) out uvec4 texture_shw_size;\n\nvoid main()\n{\n    texture_std_size = uvec4( textureSize(texture_std_sampler, 0), 0 );\n    texture_shw_size = uvec4( textureSize(texture_shw_sampler, 0), 0 );\n}\n";

const COMPUTE_SHADER_CODE: &str = "${VERSION}\n\n${TEXTURE_CUBE_MAP_ARRAY_REQUIRE}\n\nprecision highp float;\n\nlayout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\n                               uniform highp samplerCubeArray       texture_std_sampler;\n                               uniform highp samplerCubeArrayShadow texture_shw_sampler;\nlayout(rgba32f,  binding = 0)  writeonly uniform highp imageCubeArray         texture_img_sampler;\n\nlayout (rgba32ui, binding = 1) uniform highp writeonly uimage2D image_std_size;\nlayout (rgba32ui, binding = 2) uniform highp writeonly uimage2D image_shw_size;\nlayout (rgba32ui, binding = 3) uniform highp writeonly uimage2D image_img_size;\n\nvoid main(void)\n{\n    imageStore(image_std_size, ivec2(0,0),  uvec4(uvec3( textureSize(texture_std_sampler, 0)), 0) );\n    imageStore(image_shw_size, ivec2(0,0),  uvec4(uvec3( textureSize(texture_shw_sampler, 0)), 0) );\n    imageStore(image_img_size, ivec2(0,0),  uvec4(uvec3( imageSize  (texture_img_sampler)), 0) );\n}\n";

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        glu::expect_no_error($gl, $name)?;
    }};
}

/// The leaf classes of upstream's hierarchy.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Kind {
    TfVertex,
    TfGeometry,
    TfTessControl,
    TfTessEvaluation,
    RtFragment,
    RtCompute,
}

impl Kind {
    fn is_transform_feedback(self) -> bool {
        matches!(
            self,
            Kind::TfVertex | Kind::TfGeometry | Kind::TfTessControl | Kind::TfTessEvaluation
        )
    }
}

/// `TextureCubeMapArrayTextureSize*` (Test 10)
pub(super) struct ImageTextureSize {
    pub(super) name: &'static str,
    pub(super) ext_params: ExtParameters,
    pub(super) kind: Kind,
}

#[derive(Default)]
struct Objects {
    po_id: GLuint,
    to_std_id: GLuint,
    to_shw_id: GLuint,
    vao_id: GLuint,
    tf_bo_id: GLuint,
    read_fbo_id: GLuint,
    rt_std_id: GLuint,
    rt_shw_id: GLuint,
    draw_fbo_id: GLuint,
    rt_img_id: GLuint,
    to_img_id: GLuint,
    vs_id: GLuint,
    gs_id: GLuint,
    tcs_id: GLuint,
    tes_id: GLuint,
    fs_id: GLuint,
    cs_id: GLuint,
}

struct Runner<'a> {
    context: &'a Context,
    test: &'a ImageTextureSize,
    base: &'a TestCaseBase,
    o: Objects,
}

fn storage_name(stor_type: StorageType) -> &'static str {
    if stor_type == StorageType::Mutable {
        "MUTABLE"
    } else {
        "IMMUTABLE"
    }
}

impl Runner<'_> {
    /// `initTest`
    fn init_test(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();

        if !self.base.is_texture_cube_map_array_supported {
            return Err(TestError::NotSupported(
                TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED.to_string(),
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

        // SAFETY: object creation on the current context.
        self.o.po_id = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "Could not create program object.")?;

        self.configure_program()?;
        self.configure_test_specific_objects()
    }

    /// `configureProgram` of the leaf classes
    fn configure_program(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();
        let kind = self.test.kind;

        if kind == Kind::TfGeometry && !self.base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                GEOMETRY_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }
        if matches!(kind, Kind::TfTessControl | Kind::TfTessEvaluation) && !self.base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        if kind.is_transform_feedback() {
            let varyings = [c"texture_std_size".as_ptr(), c"texture_shw_size".as_ptr()];
            gl_call!(
                gl,
                "Error setting transform feedback varyings.",
                gl.transform_feedback_varyings(
                    self.o.po_id,
                    N_VARYINGS as GLint,
                    varyings.as_ptr(),
                    glw::GL_INTERLEAVED_ATTRIBS
                )
            );
        }

        let ext = &self.base.gl_ext_tokens;
        let fail_shader = "Could not create shader object.";
        let fail_program = "Could not compile/link program object from valid shader code.";

        let new_shader = |shader_type: GLenum| -> Result<GLuint, TestError> {
            // SAFETY: object creation on the current context.
            let id = unsafe { gl.create_shader(shader_type) };
            glu::expect_no_error(gl, fail_shader)?;
            Ok(id)
        };

        let built = match kind {
            Kind::TfVertex => {
                self.o.vs_id = new_shader(glw::GL_VERTEX_SHADER)?;
                self.o.fs_id = new_shader(glw::GL_FRAGMENT_SHADER)?;
                let (vs_parts, fs_parts) = ([TF_VERTEX_SHADER_CODE], [NOOP_FRAGMENT_SHADER_CODE]);
                self.base
                    .build_program(
                        self.context,
                        self.o.po_id,
                        &[
                            ShaderBody::Source(self.o.fs_id, &fs_parts),
                            ShaderBody::Source(self.o.vs_id, &vs_parts),
                        ],
                    )?
                    .0
            }
            Kind::TfGeometry => {
                self.o.vs_id = new_shader(glw::GL_VERTEX_SHADER)?;
                self.o.gs_id = new_shader(ext.geometry_shader)?;
                self.o.fs_id = new_shader(glw::GL_FRAGMENT_SHADER)?;
                let (vs_parts, gs_parts, fs_parts) = (
                    [POSITION_ONLY_VERTEX_SHADER_CODE],
                    [GEOMETRY_SHADER_CODE],
                    [NOOP_FRAGMENT_SHADER_CODE],
                );
                let stages = [
                    ShaderBody::Source(self.o.fs_id, &fs_parts),
                    ShaderBody::Source(self.o.gs_id, &gs_parts),
                    ShaderBody::Source(self.o.vs_id, &vs_parts),
                ];
                self.base.build_program(self.context, self.o.po_id, &stages)?.0
            }
            Kind::TfTessControl | Kind::TfTessEvaluation => {
                self.o.vs_id = new_shader(glw::GL_VERTEX_SHADER)?;
                self.o.tcs_id = new_shader(ext.tess_control_shader)?;
                self.o.tes_id = new_shader(ext.tess_evaluation_shader)?;
                self.o.fs_id = new_shader(glw::GL_FRAGMENT_SHADER)?;
                let control = kind == Kind::TfTessControl;
                let (vs_parts, fs_parts) = ([POSITION_ONLY_VERTEX_SHADER_CODE], [NOOP_FRAGMENT_SHADER_CODE]);
                let tcs_parts = [if control {
                    TESS_CONTROL_SHADER_CODE
                } else {
                    TESS_CONTROL_SHADER_FOR_EVALUATION_CODE
                }];
                let tes_parts = [if control {
                    TESS_EVALUATION_SHADER_FOR_CONTROL_CODE
                } else {
                    TESS_EVALUATION_SHADER_CODE
                }];
                let stages = [
                    ShaderBody::Source(self.o.fs_id, &fs_parts),
                    ShaderBody::Source(self.o.tcs_id, &tcs_parts),
                    ShaderBody::Source(self.o.tes_id, &tes_parts),
                    ShaderBody::Source(self.o.vs_id, &vs_parts),
                ];
                self.base.build_program(self.context, self.o.po_id, &stages)?.0
            }
            Kind::RtFragment => {
                self.o.vs_id = new_shader(glw::GL_VERTEX_SHADER)?;
                self.o.fs_id = new_shader(glw::GL_FRAGMENT_SHADER)?;
                let (vs_parts, fs_parts) = ([RT_VERTEX_SHADER_CODE], [RT_FRAGMENT_SHADER_CODE]);
                self.base
                    .build_program(
                        self.context,
                        self.o.po_id,
                        &[
                            ShaderBody::Source(self.o.fs_id, &fs_parts),
                            ShaderBody::Source(self.o.vs_id, &vs_parts),
                        ],
                    )?
                    .0
            }
            Kind::RtCompute => {
                self.o.cs_id = new_shader(glw::GL_COMPUTE_SHADER)?;
                let cs_parts = [COMPUTE_SHADER_CODE];
                self.base
                    .build_program(
                        self.context,
                        self.o.po_id,
                        &[ShaderBody::Source(self.o.cs_id, &cs_parts)],
                    )?
                    .0
            }
        };
        if !built {
            return Err(TestError::Fail(fail_program.to_string()));
        }
        Ok(())
    }

    /// `ReadBack 2D RGBA32UI 1x1 texture`: the part of `configureTestSpecificObjects` shared by the render-target kinds
    fn create_result_texture(&self, id: &mut GLuint, texture_unit: GLenum) -> Result<(), TestError> {
        let gl = self.context.gl();
        let rt_data = [0u32; 4];

        gl_call!(gl, "Error generating texture object!", gl.gen_textures(1, id));
        gl_call!(gl, "Error active texture unit!", gl.active_texture(texture_unit));
        gl_call!(
            gl,
            "Error binding texture object!",
            gl.bind_texture(glw::GL_TEXTURE_2D, *id)
        );
        gl_call!(
            gl,
            "Error allocating storage for texture object!",
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA32UI, 1, 1)
        );
        gl_call!(
            gl,
            "Error filling texture object's data store with data!",
            gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                1,
                1,
                glw::GL_RGBA_INTEGER,
                glw::GL_UNSIGNED_INT,
                rt_data.as_ptr().cast()
            )
        );
        gl_call!(
            gl,
            "Error setting texture object's filter mode!",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint)
        );
        gl_call!(
            gl,
            "Error setting texture object's filter mode!",
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint)
        );
        Ok(())
    }

    /// `configureTestSpecificObjects`
    fn configure_test_specific_objects(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();
        let kind = self.test.kind;

        if kind.is_transform_feedback() {
            let buffer_data = [0i32; N_VARYINGS * N_TF_COMPONENTS];

            gl_call!(
                gl,
                "Error generating buffer object.",
                gl.gen_buffers(1, &mut self.o.tf_bo_id)
            );
            gl_call!(
                gl,
                "Error binding buffer object.",
                gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.o.tf_bo_id)
            );
            gl_call!(
                gl,
                "Error allocating buffer object's data store.",
                gl.buffer_data(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    std::mem::size_of_val(&buffer_data) as glw::GLsizeiptr,
                    buffer_data.as_ptr().cast(),
                    glw::GL_DYNAMIC_COPY
                )
            );
            gl_call!(
                gl,
                "Error binding buffer object to transform feedback binding point.",
                gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.o.tf_bo_id)
            );
            return Ok(());
        }

        let mut rt_std_id = 0;
        self.create_result_texture(&mut rt_std_id, glw::GL_TEXTURE0)?;
        self.o.rt_std_id = rt_std_id;
        let mut rt_shw_id = 0;
        self.create_result_texture(&mut rt_shw_id, glw::GL_TEXTURE1)?;
        self.o.rt_shw_id = rt_shw_id;

        gl_call!(
            gl,
            "Error generating frame buffer object!",
            gl.gen_framebuffers(1, &mut self.o.read_fbo_id)
        );

        if kind == Kind::RtFragment {
            gl_call!(
                gl,
                "Error generating frame buffer object!",
                gl.gen_framebuffers(1, &mut self.o.draw_fbo_id)
            );
        } else {
            let mut rt_img_id = 0;
            self.create_result_texture(&mut rt_img_id, glw::GL_TEXTURE2)?;
            self.o.rt_img_id = rt_img_id;

            gl_call!(
                gl,
                "Error binding texture object to image unit",
                gl.bind_image_texture(
                    1,
                    self.o.rt_std_id,
                    0,
                    glw::FALSE,
                    0,
                    glw::GL_WRITE_ONLY,
                    glw::GL_RGBA32UI
                )
            );
            gl_call!(
                gl,
                "Error binding texture object to image unit",
                gl.bind_image_texture(
                    2,
                    self.o.rt_shw_id,
                    0,
                    glw::FALSE,
                    0,
                    glw::GL_WRITE_ONLY,
                    glw::GL_RGBA32UI
                )
            );
            gl_call!(
                gl,
                "Error binding texture object to image unit",
                gl.bind_image_texture(
                    3,
                    self.o.rt_img_id,
                    0,
                    glw::FALSE,
                    0,
                    glw::GL_WRITE_ONLY,
                    glw::GL_RGBA32UI
                )
            );
        }
        Ok(())
    }

    /// `deleteTestSpecificObjects`
    fn delete_test_specific_objects(&mut self) {
        let gl = self.context.gl();
        // SAFETY: restores state and deletes names this test created, on the current context.
        unsafe {
            if self.test.kind.is_transform_feedback() {
                gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0);
                gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0);

                if self.o.tf_bo_id != 0 {
                    gl.delete_buffers(1, &self.o.tf_bo_id);
                    self.o.tf_bo_id = 0;
                }
                return;
            }

            if self.test.kind == Kind::RtFragment {
                gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0);
                if self.o.draw_fbo_id != 0 {
                    gl.delete_framebuffers(1, &self.o.draw_fbo_id);
                    self.o.draw_fbo_id = 0;
                }
            } else {
                gl.active_texture(glw::GL_TEXTURE2);
                gl.bind_texture(glw::GL_TEXTURE_2D, 0);
                if self.o.rt_img_id != 0 {
                    gl.delete_textures(1, &self.o.rt_img_id);
                    self.o.rt_img_id = 0;
                }
            }

            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, 0);
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
            gl.active_texture(glw::GL_TEXTURE1);
            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
            gl.active_texture(glw::GL_TEXTURE0);

            if self.o.read_fbo_id != 0 {
                gl.delete_framebuffers(1, &self.o.read_fbo_id);
                self.o.read_fbo_id = 0;
            }
            for id in [&mut self.o.rt_std_id, &mut self.o.rt_shw_id] {
                if *id != 0 {
                    gl.delete_textures(1, id);
                    *id = 0;
                }
            }
        }
    }

    /// `createCubeMapArrayTexture`
    fn create_cube_map_array_texture(
        &self,
        width: GLuint,
        height: GLuint,
        depth: GLuint,
        stor_type: StorageType,
        shadow: bool,
    ) -> Result<GLuint, TestError> {
        let gl = self.context.gl();
        let target = glw::GL_TEXTURE_CUBE_MAP_ARRAY;
        let (w, h, d) = (width as GLint, height as GLint, depth as GLint);

        let mut saved_tex_id: GLint = 0;
        // SAFETY: one GLint out.
        unsafe { gl.get_integerv(glw::GL_TEXTURE_BINDING_CUBE_MAP_ARRAY, &mut saved_tex_id) };

        let mut tex_id: GLuint = 0;
        gl_call!(gl, "Error generating texture object.", gl.gen_textures(1, &mut tex_id));
        gl_call!(gl, "Error binding texture object.", gl.bind_texture(target, tex_id));

        let (internal_format, format, type_) = if shadow {
            (glw::GL_DEPTH_COMPONENT32F, glw::GL_DEPTH_COMPONENT, glw::GL_FLOAT)
        } else {
            (glw::GL_RGBA32F, glw::GL_RGBA, glw::GL_FLOAT)
        };

        if stor_type == StorageType::Immutable {
            // SAFETY: texture parameter calls on the bound texture.
            unsafe {
                if shadow {
                    gl.tex_parameteri(
                        target,
                        glw::GL_TEXTURE_COMPARE_MODE,
                        glw::GL_COMPARE_REF_TO_TEXTURE as GLint,
                    );
                    gl.tex_parameteri(target, glw::GL_TEXTURE_COMPARE_FUNC, glw::GL_LESS as GLint);
                }
                gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
                gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
            }
            glu::expect_no_error(gl, "Error setting texture parameter.")?;

            gl_call!(
                gl,
                "Error creating immutable texture storage.",
                gl.tex_storage_3d(target, 1, internal_format, w, h, d)
            );
        } else {
            let data = vec![0f32; (width * height * depth) as usize * N_TEXTURE_COMPONENTS];

            // SAFETY: texture parameter calls on the bound texture.
            unsafe {
                if shadow {
                    gl.tex_parameteri(
                        target,
                        glw::GL_TEXTURE_COMPARE_MODE,
                        glw::GL_COMPARE_REF_TO_TEXTURE as GLint,
                    );
                    gl.tex_parameteri(target, glw::GL_TEXTURE_COMPARE_FUNC, glw::GL_LESS as GLint);
                }
                gl.tex_parameteri(target, glw::GL_TEXTURE_BASE_LEVEL, 0);
                gl.tex_parameteri(target, glw::GL_TEXTURE_MAX_LEVEL, 0);
                gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
                gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
            }
            glu::expect_no_error(gl, "Error setting texture parameter.")?;

            gl_call!(
                gl,
                "Error creating mutable texture storage.",
                gl.tex_image_3d(
                    target,
                    0,
                    internal_format as GLint,
                    w,
                    h,
                    d,
                    0,
                    format,
                    type_,
                    data.as_ptr().cast()
                )
            );
        }

        gl_call!(
            gl,
            "Error binding texture object.",
            gl.bind_texture(target, saved_tex_id as GLuint)
        );
        Ok(tex_id)
    }

    /// `configureTextures`
    fn configure_textures(
        &mut self,
        width: GLuint,
        height: GLuint,
        depth: GLuint,
        stor_type: StorageType,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();

        self.o.to_std_id = self.create_cube_map_array_texture(width, height, depth, stor_type, false)?;
        self.o.to_shw_id = self.create_cube_map_array_texture(width, height, depth, stor_type, true)?;

        gl_call!(gl, "Error binding texture object!", gl.active_texture(glw::GL_TEXTURE0));
        gl_call!(
            gl,
            "Error binding texture object!",
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, self.o.to_std_id)
        );
        gl_call!(gl, "Error binding texture object!", gl.active_texture(glw::GL_TEXTURE1));
        gl_call!(
            gl,
            "Error binding texture object!",
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, self.o.to_shw_id)
        );

        if self.test.kind.is_transform_feedback() {
            let buffer_data = [0i32; N_VARYINGS * N_TF_COMPONENTS];
            gl_call!(
                gl,
                "Error filling buffer object's data store with data.",
                gl.buffer_sub_data(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    0,
                    std::mem::size_of_val(&buffer_data) as glw::GLintptr,
                    buffer_data.as_ptr().cast()
                )
            );
        } else if self.test.kind == Kind::RtCompute {
            self.o.to_img_id = self.create_cube_map_array_texture(width, height, depth, stor_type, false)?;

            gl_call!(gl, "Error binding texture object!", gl.active_texture(glw::GL_TEXTURE2));
            gl_call!(
                gl,
                "Error binding texture object!",
                gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, self.o.to_img_id)
            );
            gl_call!(
                gl,
                "Error binding texture object to image unit",
                gl.bind_image_texture(0, self.o.to_img_id, 0, glw::TRUE, 0, glw::GL_READ_ONLY, glw::GL_RGBA32F)
            );
        }
        Ok(())
    }

    /// `deleteTextures`
    fn delete_textures(&mut self) {
        let gl = self.context.gl();
        // SAFETY: resets bindings and deletes names this test created, on the current context.
        unsafe {
            if self.test.kind == Kind::RtCompute {
                gl.active_texture(glw::GL_TEXTURE2);
                gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0);
                if self.o.to_img_id != 0 {
                    gl.delete_textures(1, &self.o.to_img_id);
                    self.o.to_img_id = 0;
                }
            }

            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0);
            gl.active_texture(glw::GL_TEXTURE1);
            gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0);
            gl.active_texture(glw::GL_TEXTURE0);

            for id in [&mut self.o.to_std_id, &mut self.o.to_shw_id] {
                if *id != 0 {
                    gl.delete_textures(1, id);
                    *id = 0;
                }
            }
        }
    }

    /// `configureUniforms`
    fn configure_uniforms(&self) -> Result<(), TestError> {
        let gl = self.context.gl();

        for (name, unit) in [(c"texture_std_sampler", 0), (c"texture_shw_sampler", 1)] {
            // SAFETY: a linked program and a NUL-terminated name.
            let location = unsafe { gl.get_uniform_location(self.o.po_id, name.as_ptr()) };
            glu::expect_no_error(gl, "Error getting sampler location!")?;

            gl_call!(
                gl,
                "Error binding sampler to texture unit!",
                gl.uniform_1i(location, unit)
            );
        }
        Ok(())
    }

    /// `runShaders`
    fn run_shaders(&self) -> Result<(), TestError> {
        let gl = self.context.gl();
        let ext = &self.base.gl_ext_tokens;

        match self.test.kind {
            Kind::TfVertex | Kind::TfGeometry => {
                gl_call!(
                    gl,
                    "Error beginning transform feedback.",
                    gl.begin_transform_feedback(glw::GL_POINTS)
                );
                gl_call!(gl, "Rendering failed!", gl.draw_arrays(glw::GL_POINTS, 0, 1));
                gl_call!(gl, "Error ending transform feedback.", gl.end_transform_feedback());
            }
            Kind::TfTessControl | Kind::TfTessEvaluation => {
                gl_call!(
                    gl,
                    "Error beginning transform feedback.",
                    gl.begin_transform_feedback(glw::GL_POINTS)
                );
                gl_call!(
                    gl,
                    "Setting number of vertices per patch failed",
                    gl.patch_parameteri(ext.patch_vertices, 1)
                );
                gl_call!(gl, "Rendering failed!", gl.draw_arrays(ext.patches, 0, 1));
                gl_call!(
                    gl,
                    "Setting number of vertices per patch failed",
                    gl.patch_parameteri(ext.patch_vertices, 3)
                );
                gl_call!(gl, "Error ending transform feedback.", gl.end_transform_feedback());
            }
            Kind::RtFragment => {
                gl_call!(
                    gl,
                    "Error binding framebuffer object",
                    gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, self.o.draw_fbo_id)
                );
                gl_call!(
                    gl,
                    "Error attaching texture to GL_COLOR_ATTACHMENT0",
                    gl.framebuffer_texture_2d(
                        glw::GL_DRAW_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        glw::GL_TEXTURE_2D,
                        self.o.rt_std_id,
                        0
                    )
                );
                gl_call!(
                    gl,
                    "Error attaching texture to GL_COLOR_ATTACHMENT0",
                    gl.framebuffer_texture_2d(
                        glw::GL_DRAW_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT1,
                        glw::GL_TEXTURE_2D,
                        self.o.rt_shw_id,
                        0
                    )
                );

                TestCaseBase::check_framebuffer_status(self.context, glw::GL_DRAW_FRAMEBUFFER)?;

                let draw_buffers = [glw::GL_COLOR_ATTACHMENT0, glw::GL_COLOR_ATTACHMENT1];
                gl_call!(
                    gl,
                    "Error setting draw buffers",
                    gl.draw_buffers(2, draw_buffers.as_ptr())
                );

                let mut viewport_size = [0 as GLint; 4];
                // SAFETY: four GLints out.
                unsafe { gl.get_integerv(glw::GL_VIEWPORT, viewport_size.as_mut_ptr()) };
                gl_call!(gl, "Setting viewport", gl.viewport(0, 0, 1, 1));

                gl_call!(gl, "Rendering failed!", gl.draw_arrays(glw::GL_POINTS, 0, 1));

                gl_call!(
                    gl,
                    "Setting viewport",
                    gl.viewport(viewport_size[0], viewport_size[1], viewport_size[2], viewport_size[3])
                );
            }
            Kind::RtCompute => {
                gl_call!(gl, "Error executing compute shader", gl.dispatch_compute(1, 1, 1));
                gl_call!(
                    gl,
                    "Error setting memory barrier!",
                    gl.memory_barrier(glw::GL_FRAMEBUFFER_BARRIER_BIT)
                );
            }
        }
        Ok(())
    }

    /// One `read_size[0..3] != width, height, depth / 6` comparison, with upstream's log text on a mismatch.
    fn size_matches(
        what: &str,
        stor_type: StorageType,
        read_size: &[u32],
        width: GLuint,
        height: GLuint,
        depth: GLuint,
    ) -> bool {
        let layers = depth / N_LAYERS_PER_CUBE;
        if read_size[0] != width || read_size[1] != height || read_size[2] != layers {
            log::info!(
                "Storage Type: {}\n{what} returned wrong values of [width][height][layers]. They are equal to[{}][{}][{}] but should be [{width}][{height}][{layers}].",
                storage_name(stor_type),
                read_size[0],
                read_size[1],
                read_size[2]
            );
            return false;
        }
        true
    }

    /// Attaches `texture_id` to the read framebuffer and reads its single texel.
    fn read_result_texture(&self, texture_id: GLuint) -> Result<[u32; 4], TestError> {
        let gl = self.context.gl();
        let mut read_size = [0u32; 4];

        gl_call!(
            gl,
            "Error attaching texture to frame buffer",
            gl.framebuffer_texture_2d(
                glw::GL_READ_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                texture_id,
                0
            )
        );
        TestCaseBase::check_framebuffer_status(self.context, glw::GL_READ_FRAMEBUFFER)?;
        gl_call!(
            gl,
            "Error reading pixles from frame buffer!",
            gl.read_pixels(
                0,
                0,
                1,
                1,
                glw::GL_RGBA_INTEGER,
                glw::GL_UNSIGNED_INT,
                read_size.as_mut_ptr().cast()
            )
        );
        Ok(read_size)
    }

    /// `checkResults`
    fn check_results(
        &self,
        width: GLuint,
        height: GLuint,
        depth: GLuint,
        stor_type: StorageType,
    ) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let mut test_passed = true;

        if self.test.kind.is_transform_feedback() {
            let size = (N_VARYINGS * N_TF_COMPONENTS * std::mem::size_of::<u32>()) as glw::GLsizeiptr;
            // SAFETY: maps the transform feedback buffer this test allocated with that size.
            let temp_buff =
                unsafe { gl.map_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, size, glw::GL_MAP_READ_BIT) };
            glu::expect_no_error(
                gl,
                "Error mapping buffer object's data store to client's address space.",
            )?;
            if temp_buff.is_null() {
                return Err(TestError::Fail(
                    "Error mapping buffer object's data store to client's address space.".to_string(),
                ));
            }

            let mut read_size = [0u32; N_VARYINGS * N_TF_COMPONENTS];
            // SAFETY: the mapping is `size` bytes, which is exactly this array.
            let n_read = read_size.len();
            read_size.copy_from_slice(unsafe { std::slice::from_raw_parts(temp_buff.cast::<u32>(), n_read) });

            gl_call!(
                gl,
                "Error ummapping transform feedback buffer.",
                gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER)
            );

            if !Self::size_matches(
                "textureSize() for samplerCubeArray",
                stor_type,
                &read_size[0..3],
                width,
                height,
                depth,
            ) {
                test_passed = false;
            }
            if !Self::size_matches(
                "textureSize() for samplerCubeArrayShadow",
                stor_type,
                &read_size[3..6],
                width,
                height,
                depth,
            ) {
                test_passed = false;
            }
            return Ok(test_passed);
        }

        gl_call!(
            gl,
            "Error binding read framebuffer",
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, self.o.read_fbo_id)
        );

        let read_size = self.read_result_texture(self.o.rt_std_id)?;
        if !Self::size_matches(
            "textureSize() for samplerCubeArray",
            stor_type,
            &read_size,
            width,
            height,
            depth,
        ) {
            test_passed = false;
        }

        let read_size = self.read_result_texture(self.o.rt_shw_id)?;
        if !Self::size_matches(
            "textureSize() for samplerCubeArrayShadow",
            stor_type,
            &read_size,
            width,
            height,
            depth,
        ) {
            test_passed = false;
        }

        if self.test.kind == Kind::RtCompute {
            let read_size = self.read_result_texture(self.o.rt_img_id)?;
            if !Self::size_matches(
                "imageSize() for imageCubeArray",
                stor_type,
                &read_size,
                width,
                height,
                depth,
            ) {
                test_passed = false;
            }
        }
        Ok(test_passed)
    }

    /// `deinit`
    fn deinit(&mut self) {
        let gl = self.context.gl();
        // SAFETY: restores state on the current context.
        unsafe {
            gl.use_program(0);
            gl.bind_vertex_array(0);
        }

        self.delete_test_specific_objects();

        // SAFETY: deletes names this test created, on the current context.
        unsafe {
            for id in [
                &mut self.o.vs_id,
                &mut self.o.gs_id,
                &mut self.o.tcs_id,
                &mut self.o.tes_id,
                &mut self.o.fs_id,
                &mut self.o.cs_id,
            ] {
                if *id != 0 {
                    gl.delete_shader(*id);
                    *id = 0;
                }
            }
            if self.o.po_id != 0 {
                gl.delete_program(self.o.po_id);
                self.o.po_id = 0;
            }
            if self.o.vao_id != 0 {
                gl.delete_vertex_arrays(1, &self.o.vao_id);
                self.o.vao_id = 0;
            }
        }

        self.delete_textures();
    }

    fn run(&mut self) -> Result<bool, TestError> {
        let gl = self.context.gl();

        self.init_test()?;

        let mut test_passed = true;

        gl_call!(gl, "Could not set active program object.", gl.use_program(self.o.po_id));

        for stor_type in [StorageType::Mutable, StorageType::Immutable] {
            for [width, height, depth] in RESOLUTION_ARRAY {
                self.configure_textures(width, height, depth, stor_type)?;
                self.configure_uniforms()?;
                self.run_shaders()?;

                if !self.check_results(width, height, depth, stor_type)? {
                    test_passed = false;
                }

                self.delete_textures();
            }
        }
        Ok(test_passed)
    }
}

impl TestCase for ImageTextureSize {
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
