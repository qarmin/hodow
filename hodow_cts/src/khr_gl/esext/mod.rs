// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/esextcTestCaseBase.cpp / .hpp   (glcts::TestCaseBase, ExtParameters)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's `TestCaseBase` is a base class: the derived case's `init` runs `initExtensions` and `initGLSLSpecializationMap`, which fill members the rest of the case then reads. A case here is
// immutable and gets its `Context` only in `iterate`, so the same state is a value, `TestCaseBase`, built there by `TestCaseBase::init`. The variadic `buildProgram` overloads (one to five shaders)
// are one slice-taking `build_program`.

use crate::generated::ext_tokens::GlExtTokens;
use crate::glu::{self, Context, GlslVersion};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{StringTemplate, TestError};

/// `glcts::ExtensionName`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum ExtensionName {
    ShaderImageAtomic,
    ShaderIoBlocks,
    GeometryShader,
    GeometryPointSize,
    TessellationShader,
    TessellationPointSize,
    TextureBuffer,
    TextureCubeMapArray,
    GpuShader5,
    ViewportArray,
}

/// `glcts::ExtensionType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum ExtensionType {
    /// Not an extension (part of this version of OpenGL or OpenGL ES).
    None,
    /// EXT multivendor extension.
    Ext,
    /// OES Khronos extension.
    Oes,
}

/// `glcts::ExtensionBehavior`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum ExtensionBehavior {
    Disable,
    Warn,
    Enable,
    Require,
}

/// `glcts::ExtParameters` - what a package says about the groups it registers: the GLSL version their shaders use, and which family of extension names they test.
#[derive(Clone, Copy, Debug)]
pub struct ExtParameters {
    pub glsl_version: GlslVersion,
    pub ext_type: ExtensionType,
}

impl ExtParameters {
    pub const fn new(glsl_version: GlslVersion, ext_type: ExtensionType) -> Self {
        Self { glsl_version, ext_type }
    }
}

/// `TestCaseBase::m_epsilon_float`
pub const EPSILON_FLOAT: f32 = 0.0001;

/// The part of a shader `buildProgramVA` is given for one stage.
#[derive(Clone, Copy)]
pub enum ShaderBody<'a> {
    /// `sh_id == 0`: skip this stage.
    Skip,
    /// `sh_parts == 0`: the shader object is already compiled, attach it.
    Compiled(GLuint),
    /// Source in parts, concatenated and specialized, then compiled.
    Source(GLuint, &'a [&'a str]),
}

/// What `TestCaseBase::init` establishes, plus the helpers that read it.
pub struct TestCaseBase {
    pub glsl_version: GlslVersion,
    pub ext_type: ExtensionType,
    specialization_map: Vec<(&'static str, String)>,

    pub is_framebuffer_no_attachments_supported: bool,
    pub is_geometry_shader_extension_supported: bool,
    pub is_geometry_shader_point_size_supported: bool,
    pub is_gpu_shader5_supported: bool,
    pub is_program_interface_query_supported: bool,
    pub is_shader_image_load_store_supported: bool,
    pub is_shader_image_atomic_supported: bool,
    pub is_texture_storage_multisample_supported: bool,
    pub is_texture_storage_multisample_2d_array_supported: bool,
    pub is_tessellation_shader_supported: bool,
    pub is_tessellation_shader_point_size_supported: bool,
    pub is_texture_cube_map_array_supported: bool,
    pub is_texture_border_clamp_supported: bool,
    pub is_texture_buffer_supported: bool,
    pub is_viewport_array_supported: bool,
    pub is_fragment_shading_rate_supported: bool,
    pub is_fragment_shading_rate_primitive_supported: bool,
    pub is_fragment_shading_rate_attachment_supported: bool,
    pub is_multiview_ovr_supported: bool,
    pub is_texture_float_linear_supported: bool,

    /// `m_glExtTokens`
    pub gl_ext_tokens: GlExtTokens,
}

/// `getShaderTypeName`
fn shader_type_name(shader_type: GLenum) -> &'static str {
    match shader_type {
        glw::GL_VERTEX_SHADER => "Vertex shader",
        glw::GL_TESS_CONTROL_SHADER => "Tessellation control shader",
        glw::GL_TESS_EVALUATION_SHADER => "Tessellation evaluation shader",
        glw::GL_GEOMETRY_SHADER => "Geometry shader",
        glw::GL_FRAGMENT_SHADER => "Fragment shader",
        glw::GL_COMPUTE_SHADER => "Compute shader",
        _ => "??? shader",
    }
}

impl TestCaseBase {
    /// `TestCaseBase::TestCaseBase` + `init`: the extension flags and the specialization map for this context.
    pub fn init(context: &Context, ext_params: ExtParameters) -> Self {
        let mut base = Self {
            glsl_version: ext_params.glsl_version,
            ext_type: ext_params.ext_type,
            specialization_map: Vec::new(),
            is_framebuffer_no_attachments_supported: false,
            is_geometry_shader_extension_supported: false,
            is_geometry_shader_point_size_supported: false,
            is_gpu_shader5_supported: false,
            is_program_interface_query_supported: false,
            is_shader_image_load_store_supported: false,
            is_shader_image_atomic_supported: false,
            is_texture_storage_multisample_supported: false,
            is_texture_storage_multisample_2d_array_supported: false,
            is_tessellation_shader_supported: false,
            is_tessellation_shader_point_size_supported: false,
            is_texture_cube_map_array_supported: false,
            is_texture_border_clamp_supported: false,
            is_texture_buffer_supported: false,
            is_viewport_array_supported: false,
            is_fragment_shading_rate_supported: false,
            is_fragment_shading_rate_primitive_supported: false,
            is_fragment_shading_rate_attachment_supported: false,
            is_multiview_ovr_supported: false,
            is_texture_float_linear_supported: false,
            gl_ext_tokens: GlExtTokens::init(context.context_type()),
        };
        base.init_extensions(context);
        base.init_glsl_specialization_map(context);
        base
    }

    /// `TestCaseBase::isExtensionSupported`
    pub fn is_extension_supported(context: &Context, ext_name: &str) -> bool {
        context.context_info.is_extension_supported(ext_name)
    }

    /// `TestCaseBase::initExtensions` - which of the extensions' functionality this context has, either in core or through the extension.
    fn init_extensions(&mut self, context: &Context) {
        let context_type = context.context_type();
        let ext = |name: &str| Self::is_extension_supported(context, name);

        // OpenGL 4.0 or higher is minimum expectation for any of these tests.
        if context_type.supports_core(4, 0) {
            self.is_geometry_shader_extension_supported = true;
            self.is_geometry_shader_point_size_supported = true;
            self.is_gpu_shader5_supported = true;
            self.is_tessellation_shader_supported = true;
            self.is_tessellation_shader_point_size_supported = true;
            self.is_texture_cube_map_array_supported = true;
            self.is_texture_border_clamp_supported = true;
            self.is_texture_buffer_supported = true;
            self.is_texture_float_linear_supported = true;
            self.is_shader_image_atomic_supported = context_type.supports_core(4, 2);
            self.is_texture_storage_multisample_2d_array_supported = context_type.supports_core(4, 3);
            self.is_framebuffer_no_attachments_supported = context_type.supports_core(4, 3);
            self.is_program_interface_query_supported = context_type.supports_core(4, 3);
            self.is_texture_storage_multisample_supported = context_type.supports_core(4, 3);
            self.is_shader_image_load_store_supported = context_type.supports_core(4, 2);
            self.is_viewport_array_supported = context_type.supports_core(4, 1);
            self.is_multiview_ovr_supported = ext("GL_OVR_multiview");
            self.is_fragment_shading_rate_supported = ext("GL_EXT_fragment_shading_rate");
            self.is_fragment_shading_rate_primitive_supported = ext("GL_EXT_fragment_shading_rate_primitive");
            self.is_fragment_shading_rate_attachment_supported = ext("GL_EXT_fragment_shading_rate_attachment");
        } else if context_type.supports(3, 2) {
            self.is_geometry_shader_extension_supported = true;
            self.is_gpu_shader5_supported = true;
            self.is_tessellation_shader_supported = true;
            self.is_texture_cube_map_array_supported = true;
            self.is_texture_border_clamp_supported = true;
            self.is_texture_buffer_supported = true;
            self.is_shader_image_atomic_supported = true;
            self.is_texture_storage_multisample_2d_array_supported = true;
            self.is_framebuffer_no_attachments_supported = true;
            self.is_program_interface_query_supported = true;
            self.is_texture_storage_multisample_supported = true;
            self.is_shader_image_load_store_supported = true;
            self.is_geometry_shader_point_size_supported =
                ext("GL_OES_geometry_point_size") || ext("GL_EXT_geometry_point_size");
            self.is_tessellation_shader_point_size_supported =
                ext("GL_OES_tessellation_point_size") || ext("GL_EXT_tessellation_point_size");
            self.is_viewport_array_supported = ext("GL_OES_viewport_array");
            self.is_texture_float_linear_supported = ext("GL_OES_texture_float_linear");
        } else {
            // ES 3.1 core functionality is assumed.
            debug_assert!(context_type.supports(3, 1));

            // These are part of ES 3.1.
            self.is_framebuffer_no_attachments_supported = true;
            self.is_program_interface_query_supported = true;
            self.is_texture_storage_multisample_supported = true;
            self.is_shader_image_load_store_supported = true;

            // AEP extensions - either test OES variants or EXT variants.
            if self.ext_type == ExtensionType::Oes {
                self.is_geometry_shader_extension_supported = ext("GL_OES_geometry_shader");
                self.is_geometry_shader_point_size_supported = ext("GL_OES_geometry_point_size");
                self.is_gpu_shader5_supported = ext("GL_OES_gpu_shader5");
                self.is_tessellation_shader_supported = ext("GL_OES_tessellation_shader");
                self.is_tessellation_shader_point_size_supported = ext("GL_OES_tessellation_point_size");
                self.is_texture_cube_map_array_supported = ext("GL_OES_texture_cube_map_array");
                self.is_texture_border_clamp_supported = ext("GL_OES_texture_border_clamp");
                self.is_texture_buffer_supported = ext("GL_OES_texture_buffer");
            } else {
                debug_assert!(self.ext_type == ExtensionType::Ext);

                self.is_geometry_shader_extension_supported = ext("GL_EXT_geometry_shader");
                self.is_geometry_shader_point_size_supported = ext("GL_EXT_geometry_point_size");
                self.is_gpu_shader5_supported = ext("GL_EXT_gpu_shader5");
                self.is_tessellation_shader_supported = ext("GL_EXT_tessellation_shader");
                self.is_tessellation_shader_point_size_supported = ext("GL_EXT_tessellation_point_size");
                self.is_texture_cube_map_array_supported = ext("GL_EXT_texture_cube_map_array");
                self.is_texture_border_clamp_supported = ext("GL_EXT_texture_border_clamp");
                self.is_texture_buffer_supported = ext("GL_EXT_texture_buffer");
                self.is_fragment_shading_rate_supported = ext("GL_EXT_fragment_shading_rate");
                self.is_fragment_shading_rate_primitive_supported = ext("GL_EXT_fragment_shading_rate_primitive");
                self.is_fragment_shading_rate_attachment_supported = ext("GL_EXT_fragment_shading_rate_attachment");
            }

            // Other ES 3.1 extensions.
            self.is_shader_image_atomic_supported = ext("GL_OES_shader_image_atomic");
            self.is_texture_storage_multisample_2d_array_supported = ext("GL_OES_texture_storage_multisample_2d_array");
            self.is_viewport_array_supported = ext("GL_OES_viewport_array");
            self.is_multiview_ovr_supported = ext("GL_OVR_multiview");
            self.is_texture_float_linear_supported = ext("GL_OES_texture_float_linear");
        }
    }

    /// `TestCaseBase::initGLSLSpecializationMap`
    fn init_glsl_specialization_map(&mut self, context: &Context) {
        use ExtensionBehavior::{Enable, Require};
        use ExtensionName::*;

        let mut map: Vec<(&'static str, String)> = vec![("VERSION", self.glsl_version.declaration().to_string())];
        for (enable_key, require_key, name) in [
            ("SHADER_IO_BLOCKS_ENABLE", "SHADER_IO_BLOCKS_REQUIRE", ShaderIoBlocks),
            ("GEOMETRY_SHADER_ENABLE", "GEOMETRY_SHADER_REQUIRE", GeometryShader),
            (
                "GEOMETRY_POINT_SIZE_ENABLE",
                "GEOMETRY_POINT_SIZE_REQUIRE",
                GeometryPointSize,
            ),
            (
                "TESSELLATION_SHADER_ENABLE",
                "TESSELLATION_SHADER_REQUIRE",
                TessellationShader,
            ),
            (
                "TESSELLATION_POINT_SIZE_ENABLE",
                "TESSELLATION_POINT_SIZE_REQUIRE",
                TessellationPointSize,
            ),
            ("GPU_SHADER5_ENABLE", "GPU_SHADER5_REQUIRE", GpuShader5),
            ("TEXTURE_BUFFER_ENABLE", "TEXTURE_BUFFER_REQUIRE", TextureBuffer),
            (
                "TEXTURE_CUBE_MAP_ARRAY_ENABLE",
                "TEXTURE_CUBE_MAP_ARRAY_REQUIRE",
                TextureCubeMapArray,
            ),
            (
                "SHADER_IMAGE_ATOMIC_ENABLE",
                "SHADER_IMAGE_ATOMIC_REQUIRE",
                ShaderImageAtomic,
            ),
            ("VIEWPORT_ARRAY_ENABLE", "VIEWPORT_ARRAY_REQUIRE", ViewportArray),
        ] {
            map.push((
                enable_key,
                self.glsl_ext_directive(context, self.ext_type, name, Enable),
            ));
            map.push((
                require_key,
                self.glsl_ext_directive(context, self.ext_type, name, Require),
            ));
        }

        if context.context_type().api.desktop {
            map.push((
                "IN_PER_VERTEX_DECL_ARRAY",
                "in gl_PerVertex {\n    vec4 gl_Position;\n} gl_in[];\n".to_string(),
            ));
            map.push((
                "IN_PER_VERTEX_DECL_ARRAY_POINT_SIZE",
                "in gl_PerVertex {\n    vec4 gl_Position;\n    float gl_PointSize;\n} gl_in[];\n".to_string(),
            ));
            map.push((
                "OUT_PER_VERTEX_DECL",
                "out gl_PerVertex {\n    vec4 gl_Position;\n};\n".to_string(),
            ));
            map.push((
                "OUT_PER_VERTEX_DECL_POINT_SIZE",
                "out gl_PerVertex {\n    vec4 gl_Position;\n    float gl_PointSize;\n};\n".to_string(),
            ));
            map.push((
                "OUT_PER_VERTEX_DECL_ARRAY",
                "out gl_PerVertex {\n    vec4 gl_Position;\n} gl_out[];\n".to_string(),
            ));
            map.push((
                "OUT_PER_VERTEX_DECL_ARRAY_POINT_SIZE",
                "out gl_PerVertex {\n    vec4 gl_Position;\n    float gl_PointSize;\n} gl_out[];\n".to_string(),
            ));
            map.push((
                "IN_DATA_DECL",
                "in Data {\n    vec4 pos;\n} input_data[1];\n".to_string(),
            ));
            map.push((
                "POSITION_WITH_IN_DATA",
                "gl_Position = input_data[0].pos;\n".to_string(),
            ));
        } else {
            for key in [
                "IN_PER_VERTEX_DECL_ARRAY",
                "IN_PER_VERTEX_DECL_ARRAY_POINT_SIZE",
                "OUT_PER_VERTEX_DECL",
                "OUT_PER_VERTEX_DECL_POINT_SIZE",
                "OUT_PER_VERTEX_DECL_ARRAY",
                "OUT_PER_VERTEX_DECL_ARRAY_POINT_SIZE",
                "IN_DATA_DECL",
            ] {
                map.push((key, "\n".to_string()));
            }
            map.push((
                "POSITION_WITH_IN_DATA",
                "gl_Position = gl_in[0].gl_Position;\n".to_string(),
            ));
        }

        self.specialization_map = map;
    }

    /// `TestCaseBase::getGLSLExtDirective`
    pub fn glsl_ext_directive(
        &self,
        context: &Context,
        mut ext_type: ExtensionType,
        name: ExtensionName,
        behavior: ExtensionBehavior,
    ) -> String {
        if ext_type == ExtensionType::None
            && name != ExtensionName::GeometryPointSize
            && name != ExtensionName::TessellationPointSize
        {
            return String::new();
        }

        if name == ExtensionName::ShaderImageAtomic {
            // There is no EXT version of shader_image_atomic; use OES.
            ext_type = ExtensionType::Oes;
        }

        if name == ExtensionName::TessellationPointSize {
            // There is no core version of tessellation_point_size, use OES or EXT.
            if Self::is_extension_supported(context, "GL_OES_tessellation_point_size") {
                ext_type = ExtensionType::Oes;
            } else if Self::is_extension_supported(context, "GL_EXT_tessellation_point_size") {
                ext_type = ExtensionType::Ext;
            } else {
                return String::new();
            }
        }

        if name == ExtensionName::GeometryPointSize {
            // There is no core version of geometry_point_size, use OES or EXT.
            if Self::is_extension_supported(context, "GL_OES_geometry_point_size") {
                ext_type = ExtensionType::Oes;
            } else if Self::is_extension_supported(context, "GL_EXT_geometry_point_size") {
                ext_type = ExtensionType::Ext;
            } else {
                return String::new();
            }
        }

        let type_str = match ext_type {
            ExtensionType::Ext => "EXT_",
            ExtensionType::Oes => "OES_",
            ExtensionType::None => return "#error unknown extension type\n".to_string(),
        };
        let name_str = match name {
            ExtensionName::ShaderImageAtomic => "shader_image_atomic",
            ExtensionName::ShaderIoBlocks => "shader_io_blocks",
            ExtensionName::GeometryShader => "geometry_shader",
            ExtensionName::GeometryPointSize => "geometry_point_size",
            ExtensionName::TessellationShader => "tessellation_shader",
            ExtensionName::TessellationPointSize => "tessellation_point_size",
            ExtensionName::TextureBuffer => "texture_buffer",
            ExtensionName::TextureCubeMapArray => "texture_cube_map_array",
            ExtensionName::GpuShader5 => "gpu_shader5",
            ExtensionName::ViewportArray => "viewport_array",
        };
        let behavior_str = match behavior {
            ExtensionBehavior::Disable => "disable",
            ExtensionBehavior::Warn => "warn",
            ExtensionBehavior::Enable => "enable",
            ExtensionBehavior::Require => "require",
        };

        format!("#extension GL_{type_str}{name_str} : {behavior_str}")
    }

    /// `TestCaseBase::specializeShader`
    pub fn specialize_shader(&self, code: &[&str]) -> String {
        let merged: String = code.concat();
        let params: Vec<(&str, String)> = self
            .specialization_map
            .iter()
            .map(|(key, value)| (*key, value.clone()))
            .collect();
        StringTemplate::new(merged)
            .specialize(&params)
            .unwrap_or_else(|e| panic!("shader template: {e}"))
    }

    /// `TestCaseBase::buildProgramVA` and the `buildProgram` overloads over it: compiles each stage that has source, attaches every stage, links. `Ok(true)` is a program that built;
    /// the second value is upstream's `out_has_compilation_failed`.
    pub fn build_program(
        &self,
        context: &Context,
        po_id: GLuint,
        stages: &[ShaderBody<'_>],
    ) -> Result<(bool, bool), TestError> {
        let gl = context.gl();
        let mut attached: Vec<GLuint> = Vec::new();

        // Shaders compilation.
        let mut compilation_status: GLint = glw::GL_FALSE as GLint;

        for stage in stages {
            let (sh_id, source) = match *stage {
                ShaderBody::Skip => continue,
                ShaderBody::Compiled(id) => (id, None),
                ShaderBody::Source(id, parts) => (id, Some(parts)),
            };
            if sh_id == 0 {
                continue;
            }

            if let Some(parts) = source {
                let merged = self.specialize_shader(parts);
                let pointer = merged.as_ptr().cast::<glw::GLchar>();
                let length = merged.len() as GLint;

                // SAFETY: a shader object the caller created, and a source that outlives the calls; its length is passed explicitly.
                unsafe {
                    gl.shader_source(sh_id, 1, &pointer, &length);
                    glu::expect_no_error(gl, "glShaderSource() failed!")?;

                    gl.compile_shader(sh_id);
                    glu::expect_no_error(gl, "glCompileShader() failed!")?;

                    gl.get_shaderiv(sh_id, glw::GL_COMPILE_STATUS, &mut compilation_status);
                    glu::expect_no_error(gl, "glGetShaderiv() failed!")?;
                }

                if compilation_status != glw::GL_TRUE as GLint {
                    let mut shader_type: GLint = 0;
                    let info_log = self.get_info_log(context, LogType::Shader, sh_id)?;
                    // SAFETY: one GLint out.
                    unsafe { gl.get_shaderiv(sh_id, glw::GL_SHADER_TYPE, &mut shader_type) };
                    let shader_type_str = shader_type_name(shader_type as GLenum);

                    log::info!(
                        "{shader_type_str} compilation failure:\n\n{info_log}\n\n{shader_type_str} source:\n\n{merged}\n\n"
                    );
                    break;
                }
            }

            // SAFETY: a program and a shader object the caller created.
            unsafe { gl.attach_shader(po_id, sh_id) };
            glu::expect_no_error(gl, "glAttachShader(VERTEX_SHADER) call failed")?;

            attached.push(sh_id);
        }

        let has_compilation_failed = compilation_status == glw::GL_FALSE as GLint;
        if compilation_status != glw::GL_TRUE as GLint {
            return Ok((false, has_compilation_failed));
        }

        // Linking the program.
        let mut link_status: GLint = glw::GL_FALSE as GLint;
        // SAFETY: a program the caller created.
        unsafe {
            gl.link_program(po_id);
            glu::expect_no_error(gl, "glLinkProgram() failed!")?;

            gl.get_programiv(po_id, glw::GL_LINK_STATUS, &mut link_status);
            glu::expect_no_error(gl, "glGetProgramiv() failed!")?;
        }

        if link_status != glw::GL_TRUE as GLint {
            // Dump link log.
            let link_log = self.get_info_log(context, LogType::Program, po_id)?;
            log::info!("Link failure:\n\n{link_log}\n\n");

            // Dump shader source.
            for id in attached {
                let mut shader_type: GLint = 0;
                // SAFETY: one GLint out.
                unsafe { gl.get_shaderiv(id, glw::GL_SHADER_TYPE, &mut shader_type) };
                let shader_source = self.get_shader_source(context, id)?;
                log::info!(
                    "{} source:\n\n{shader_source}\n\n",
                    shader_type_name(shader_type as GLenum)
                );
            }

            return Ok((false, has_compilation_failed));
        }

        Ok((true, has_compilation_failed))
    }

    /// `TestCaseBase::doesProgramBuild` - the one that wants fragment, geometry and vertex bodies, in that order.
    pub fn does_program_build(
        &self,
        context: &Context,
        fs_body_parts: &[&str],
        gs_body_parts: &[&str],
        vs_body_parts: &[&str],
    ) -> Result<bool, TestError> {
        let gl = context.gl();

        // SAFETY: shader and program creation on the current context.
        let (vertex_shader_id, geometry_shader_id, fragment_shader_id, program_object_id) = unsafe {
            let ids = (
                gl.create_shader(glw::GL_VERTEX_SHADER),
                gl.create_shader(self.gl_ext_tokens.geometry_shader),
                gl.create_shader(glw::GL_FRAGMENT_SHADER),
                gl.create_program(),
            );
            glu::expect_no_error(gl, "glCreateProgram() call failed.")?;
            ids
        };

        // Compile and link the program.
        let result = self.build_program(
            context,
            program_object_id,
            &[
                ShaderBody::Source(fragment_shader_id, fs_body_parts),
                ShaderBody::Source(geometry_shader_id, gs_body_parts),
                ShaderBody::Source(vertex_shader_id, vs_body_parts),
            ],
        );

        // SAFETY: names created above.
        unsafe {
            if program_object_id != 0 {
                gl.delete_program(program_object_id);
            }
            if fragment_shader_id != 0 {
                gl.delete_shader(fragment_shader_id);
            }
            if geometry_shader_id != 0 {
                gl.delete_shader(geometry_shader_id);
            }
            if vertex_shader_id != 0 {
                gl.delete_shader(vertex_shader_id);
            }
        }

        Ok(result?.0)
    }

    /// `TestCaseBase::getShaderSource`
    pub fn get_shader_source(&self, context: &Context, shader_id: GLuint) -> Result<String, TestError> {
        let gl = context.gl();
        let mut length: GLint = 0;
        // SAFETY: one GLint out, then a buffer one byte longer than the source the driver reported.
        let result = unsafe {
            gl.get_shaderiv(shader_id, glw::GL_SHADER_SOURCE_LENGTH, &mut length);
            let mut buffer = vec![0u8; length.max(0) as usize + 1];
            gl.get_shader_source(shader_id, length + 1, std::ptr::null_mut(), buffer.as_mut_ptr().cast());
            buffer
        };
        glu::expect_no_error(gl, "Could not retrieve shader source!")?;
        Ok(c_string_lossy(&result))
    }

    /// `TestCaseBase::getCompilationInfoLog` / `getLinkingInfoLog` / `getPipelineInfoLog`
    pub fn get_info_log(&self, context: &Context, log_type: LogType, id: GLuint) -> Result<String, TestError> {
        let gl = context.gl();
        let mut n_characters: GLint = 0;

        // Retrieve amount of characters needed to store the info log (terminator-inclusive).
        // SAFETY: one GLint out.
        unsafe {
            match log_type {
                LogType::Shader => gl.get_shaderiv(id, glw::GL_INFO_LOG_LENGTH, &mut n_characters),
                LogType::Program => gl.get_programiv(id, glw::GL_INFO_LOG_LENGTH, &mut n_characters),
                LogType::Pipeline => gl.get_program_pipelineiv(id, glw::GL_INFO_LOG_LENGTH, &mut n_characters),
            }
        }
        glu::expect_no_error(gl, "Could not query info log length!")?;

        let mut buffer = vec![0u8; n_characters.max(0) as usize + 1];
        // SAFETY: a buffer of the length passed.
        unsafe {
            let out = buffer.as_mut_ptr().cast::<glw::GLchar>();
            match log_type {
                LogType::Shader => gl.get_shader_info_log(id, n_characters + 1, std::ptr::null_mut(), out),
                LogType::Program => gl.get_program_info_log(id, n_characters + 1, std::ptr::null_mut(), out),
                LogType::Pipeline => gl.get_program_pipeline_info_log(id, n_characters + 1, std::ptr::null_mut(), out),
            }
        }
        glu::expect_no_error(gl, "Could not retrieve info log!")?;

        Ok(c_string_lossy(&buffer))
    }

    /// `TestCaseBase::comparePixel` - assumes one byte per channel in R G B A order and lines stored one after another.
    #[allow(clippy::too_many_arguments)]
    pub fn compare_pixel(
        buffer: &[u8],
        x: u32,
        y: u32,
        width: u32,
        height: u32,
        pixel_size: u32,
        expected_red: u8,
        expected_green: u8,
        expected_blue: u8,
        expected_alpha: u8,
    ) -> bool {
        let line_size = width * pixel_size;
        let image_size = height * line_size;
        let texel_offset = (y * line_size + x * pixel_size) as usize;

        // Quick checks.
        if buffer.is_empty() || image_size < texel_offset as u32 {
            return false;
        }

        let expected = [expected_red, expected_green, expected_blue, expected_alpha];
        match pixel_size {
            1..=4 => {
                (0..pixel_size as usize).all(|channel| buffer.get(texel_offset + channel) == Some(&expected[channel]))
            }
            _ => false,
        }
    }

    /// `TestCaseBase::setupFramebufferWithTextureAsAttachment`
    pub fn setup_framebuffer_with_texture_as_attachment(
        context: &Context,
        framebuffer_object_id: GLuint,
        color_texture_id: GLuint,
        texture_format: GLenum,
        texture_width: GLuint,
        texture_height: GLuint,
    ) -> Result<bool, TestError> {
        let gl = context.gl();

        // SAFETY: calls on objects the caller created, with in-range arguments.
        unsafe {
            // Allocate texture storage.
            gl.bind_texture(glw::GL_TEXTURE_2D, color_texture_id);
            gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                1,
                texture_format,
                texture_width as GLint,
                texture_height as GLint,
            );
        }
        glu::expect_no_error(gl, "Could not allocate texture storage!")?;

        // SAFETY: as above.
        unsafe {
            // Setup framebuffer.
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, framebuffer_object_id);
            gl.framebuffer_texture_2d(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                color_texture_id,
                0,
            );
        }
        glu::expect_no_error(gl, "Could not setup framebuffer!")?;

        // Setup viewport.
        // SAFETY: a viewport.
        unsafe { gl.viewport(0, 0, texture_width as GLint, texture_height as GLint) };
        glu::expect_no_error(gl, "Could not setup viewport!")?;

        Ok(true)
    }

    /// `TestCaseBase::checkFramebufferStatus`
    pub fn check_framebuffer_status(context: &Context, framebuffer: GLenum) -> Result<(), TestError> {
        let gl = context.gl();

        // SAFETY: a status query.
        let framebuffer_status = unsafe { gl.check_framebuffer_status(framebuffer) };
        glu::expect_no_error(gl, "Error getting framebuffer status!")?;

        if framebuffer_status == glw::GL_FRAMEBUFFER_COMPLETE {
            return Ok(());
        }

        Err(TestError::Fail(
            match framebuffer_status {
                glw::GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT => {
                    "Framebuffer incomplete, status: GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT"
                }
                glw::GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS => {
                    "Framebuffer incomplete, status: GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS"
                }
                glw::GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT => {
                    "Framebuffer incomplete, status: GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT"
                }
                glw::GL_FRAMEBUFFER_UNSUPPORTED => "Framebuffer incomplete, status: Error: GL_FRAMEBUFFER_UNSUPPORTED",
                _ => "Framebuffer incomplete, status not recognized",
            }
            .to_string(),
        ))
    }
}

/// `TestCaseBase::LOG_TYPE`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum LogType {
    Shader,
    Program,
    Pipeline,
}

/// `TestCaseBase::randomSeed` + `randomFormula`: upstream's tiny linear congruential generator, which is its own so that a case's data is the same on every driver.
pub struct RandomFormula {
    seed_value: GLuint,
}

impl Default for RandomFormula {
    fn default() -> Self {
        Self { seed_value: 1 }
    }
}

impl RandomFormula {
    pub fn random_seed(&mut self, seed: GLuint) {
        self.seed_value = seed;
    }

    /// Returns a random unsigned integer from the range [0, max).
    pub fn random_formula(&mut self, max: GLuint) -> GLuint {
        const A: GLuint = 11;
        const B: GLuint = 17;

        self.seed_value = A.wrapping_mul(self.seed_value).wrapping_add(B) % max;
        self.seed_value
    }
}

fn c_string_lossy(buffer: &[u8]) -> String {
    let end = buffer.iter().position(|&b| b == 0).unwrap_or(buffer.len());
    String::from_utf8_lossy(&buffer[..end]).into_owned()
}
