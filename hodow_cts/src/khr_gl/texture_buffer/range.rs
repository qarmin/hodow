// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_buffer/esextcTextureBufferTextureBufferRange.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::collections::BTreeMap;
use std::ffi::CString;

use super::TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLintptr, GLsizeiptr, GLuint};
use crate::khr_gl::esext::{EPSILON_FLOAT, ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// Sixteen-bit pattern of the half float 1.0 (upstream computes it with bit twiddling).
const HALF_ONE: u16 = 0x3C00;

/// `FormatInfo`
#[derive(Clone, Default)]
struct FormatInfo {
    aligned_size: GLuint,
    not_aligned_size: GLuint,
    ssbo_value_size: GLuint,
    internal_format: GLenum,
    #[allow(dead_code)]
    offset_alignment: GLuint,
    n_components: GLuint,
    input_type: GLenum,
    output_type: GLenum,
    is_image_supported: bool,
    image_format_name: &'static str,
    image_type_name: &'static str,
    sampler_type_name: &'static str,
    output_type_name: &'static str,
    value_selector: &'static str,
}

/// internal format, components, image support, input type, output type, input element size, output element size,
/// image format name, image type name, sampler type name, output type name, value selector
type FormatRow = (
    GLenum,
    usize,
    bool,
    GLenum,
    GLenum,
    usize,
    usize,
    &'static str,
    &'static str,
    &'static str,
    &'static str,
    &'static str,
);

const FORMAT_TABLE: &[FormatRow] = &[
    (
        glw::GL_R8,
        1,
        false,
        glw::GL_UNSIGNED_BYTE,
        glw::GL_FLOAT,
        size_of::<u8>(),
        size_of::<f32>(),
        "",
        "",
        "samplerBuffer",
        "float",
        ".x",
    ),
    (
        glw::GL_R16F,
        1,
        false,
        glw::GL_HALF_FLOAT,
        glw::GL_FLOAT,
        size_of::<u16>(),
        size_of::<f32>(),
        "",
        "",
        "samplerBuffer",
        "float",
        ".x",
    ),
    (
        glw::GL_R32F,
        1,
        true,
        glw::GL_FLOAT,
        glw::GL_FLOAT,
        size_of::<f32>(),
        size_of::<f32>(),
        "r32f",
        "imageBuffer",
        "samplerBuffer",
        "float",
        ".x",
    ),
    (
        glw::GL_R8I,
        1,
        false,
        glw::GL_BYTE,
        glw::GL_INT,
        size_of::<i8>(),
        size_of::<i32>(),
        "",
        "",
        "isamplerBuffer",
        "int",
        ".x",
    ),
    (
        glw::GL_R16I,
        1,
        false,
        glw::GL_SHORT,
        glw::GL_INT,
        size_of::<i16>(),
        size_of::<i32>(),
        "",
        "",
        "isamplerBuffer",
        "int",
        ".x",
    ),
    (
        glw::GL_R32I,
        1,
        true,
        glw::GL_INT,
        glw::GL_INT,
        size_of::<i32>(),
        size_of::<i32>(),
        "r32i",
        "iimageBuffer",
        "isamplerBuffer",
        "int",
        ".x",
    ),
    (
        glw::GL_R8UI,
        1,
        false,
        glw::GL_UNSIGNED_BYTE,
        glw::GL_UNSIGNED_INT,
        size_of::<u8>(),
        size_of::<u32>(),
        "",
        "",
        "usamplerBuffer",
        "uint",
        ".x",
    ),
    (
        glw::GL_R16UI,
        1,
        false,
        glw::GL_UNSIGNED_SHORT,
        glw::GL_UNSIGNED_INT,
        size_of::<u16>(),
        size_of::<u32>(),
        "",
        "",
        "usamplerBuffer",
        "uint",
        ".x",
    ),
    (
        glw::GL_R32UI,
        1,
        true,
        glw::GL_UNSIGNED_INT,
        glw::GL_UNSIGNED_INT,
        size_of::<u32>(),
        size_of::<u32>(),
        "r32ui",
        "uimageBuffer",
        "usamplerBuffer",
        "uint",
        ".x",
    ),
    (
        glw::GL_RG8,
        2,
        false,
        glw::GL_UNSIGNED_BYTE,
        glw::GL_FLOAT,
        size_of::<u8>(),
        size_of::<f32>(),
        "",
        "",
        "samplerBuffer",
        "vec2",
        ".xy",
    ),
    (
        glw::GL_RG16F,
        2,
        false,
        glw::GL_HALF_FLOAT,
        glw::GL_FLOAT,
        size_of::<u16>(),
        size_of::<f32>(),
        "",
        "",
        "samplerBuffer",
        "vec2",
        ".xy",
    ),
    (
        glw::GL_RG32F,
        2,
        false,
        glw::GL_FLOAT,
        glw::GL_FLOAT,
        size_of::<f32>(),
        size_of::<f32>(),
        "",
        "",
        "samplerBuffer",
        "vec2",
        ".xy",
    ),
    (
        glw::GL_RG8I,
        2,
        false,
        glw::GL_BYTE,
        glw::GL_INT,
        size_of::<i8>(),
        size_of::<i32>(),
        "",
        "",
        "isamplerBuffer",
        "ivec2",
        ".xy",
    ),
    (
        glw::GL_RG16I,
        2,
        false,
        glw::GL_SHORT,
        glw::GL_INT,
        size_of::<i16>(),
        size_of::<i32>(),
        "",
        "",
        "isamplerBuffer",
        "ivec2",
        ".xy",
    ),
    (
        glw::GL_RG32I,
        2,
        false,
        glw::GL_INT,
        glw::GL_INT,
        size_of::<i32>(),
        size_of::<i32>(),
        "",
        "",
        "isamplerBuffer",
        "ivec2",
        ".xy",
    ),
    (
        glw::GL_RG8UI,
        2,
        false,
        glw::GL_UNSIGNED_BYTE,
        glw::GL_UNSIGNED_INT,
        size_of::<u8>(),
        size_of::<u32>(),
        "",
        "",
        "usamplerBuffer",
        "uvec2",
        ".xy",
    ),
    (
        glw::GL_RG16UI,
        2,
        false,
        glw::GL_UNSIGNED_SHORT,
        glw::GL_UNSIGNED_INT,
        size_of::<u16>(),
        size_of::<u32>(),
        "",
        "",
        "usamplerBuffer",
        "uvec2",
        ".xy",
    ),
    (
        glw::GL_RG32UI,
        2,
        false,
        glw::GL_UNSIGNED_INT,
        glw::GL_UNSIGNED_INT,
        size_of::<u32>(),
        size_of::<u32>(),
        "",
        "",
        "usamplerBuffer",
        "uvec2",
        ".xy",
    ),
    (
        glw::GL_RGB32F,
        3,
        false,
        glw::GL_FLOAT,
        glw::GL_FLOAT,
        size_of::<f32>(),
        size_of::<f32>(),
        "",
        "",
        "samplerBuffer",
        "vec3",
        ".xyz",
    ),
    (
        glw::GL_RGB32I,
        3,
        false,
        glw::GL_INT,
        glw::GL_INT,
        size_of::<i32>(),
        size_of::<i32>(),
        "",
        "",
        "isamplerBuffer",
        "ivec3",
        ".xyz",
    ),
    (
        glw::GL_RGB32UI,
        3,
        false,
        glw::GL_UNSIGNED_INT,
        glw::GL_UNSIGNED_INT,
        size_of::<u32>(),
        size_of::<u32>(),
        "",
        "",
        "usamplerBuffer",
        "uvec3",
        ".xyz",
    ),
    (
        glw::GL_RGBA8,
        4,
        true,
        glw::GL_UNSIGNED_BYTE,
        glw::GL_FLOAT,
        size_of::<u8>(),
        size_of::<f32>(),
        "rgba8",
        "imageBuffer",
        "samplerBuffer",
        "vec4",
        "",
    ),
    (
        glw::GL_RGBA16F,
        4,
        true,
        glw::GL_HALF_FLOAT,
        glw::GL_FLOAT,
        size_of::<u16>(),
        size_of::<f32>(),
        "rgba16f",
        "imageBuffer",
        "samplerBuffer",
        "vec4",
        "",
    ),
    (
        glw::GL_RGBA32F,
        4,
        true,
        glw::GL_FLOAT,
        glw::GL_FLOAT,
        size_of::<f32>(),
        size_of::<f32>(),
        "rgba32f",
        "imageBuffer",
        "samplerBuffer",
        "vec4",
        "",
    ),
    (
        glw::GL_RGBA8I,
        4,
        true,
        glw::GL_BYTE,
        glw::GL_INT,
        size_of::<i8>(),
        size_of::<i32>(),
        "rgba8i",
        "iimageBuffer",
        "isamplerBuffer",
        "ivec4",
        "",
    ),
    (
        glw::GL_RGBA16I,
        4,
        true,
        glw::GL_SHORT,
        glw::GL_INT,
        size_of::<i16>(),
        size_of::<i32>(),
        "rgba16i",
        "iimageBuffer",
        "isamplerBuffer",
        "ivec4",
        "",
    ),
    (
        glw::GL_RGBA32I,
        4,
        true,
        glw::GL_INT,
        glw::GL_INT,
        size_of::<i32>(),
        size_of::<i32>(),
        "rgba32i",
        "iimageBuffer",
        "isamplerBuffer",
        "ivec4",
        "",
    ),
    (
        glw::GL_RGBA8UI,
        4,
        true,
        glw::GL_UNSIGNED_BYTE,
        glw::GL_UNSIGNED_INT,
        size_of::<u8>(),
        size_of::<u32>(),
        "rgba8ui",
        "uimageBuffer",
        "usamplerBuffer",
        "uvec4",
        "",
    ),
    (
        glw::GL_RGBA16UI,
        4,
        true,
        glw::GL_UNSIGNED_SHORT,
        glw::GL_UNSIGNED_INT,
        size_of::<u16>(),
        size_of::<u32>(),
        "rgba16ui",
        "uimageBuffer",
        "usamplerBuffer",
        "uvec4",
        "",
    ),
    (
        glw::GL_RGBA32UI,
        4,
        true,
        glw::GL_UNSIGNED_INT,
        glw::GL_UNSIGNED_INT,
        size_of::<u32>(),
        size_of::<u32>(),
        "rgba32ui",
        "uimageBuffer",
        "usamplerBuffer",
        "uvec4",
        "",
    ),
];

impl FormatInfo {
    /// `FormatInfo(internalFormat, offsetAlignment)` + `configure`
    fn new(internal_format: GLenum, offset_alignment: GLuint) -> Self {
        let mut info = FormatInfo {
            internal_format,
            offset_alignment,
            ..Default::default()
        };

        if let Some(row) = FORMAT_TABLE.iter().find(|row| row.0 == internal_format) {
            let (
                _,
                n_components,
                is_image_supported,
                input_type,
                output_type,
                input_size,
                output_size,
                image_format_name,
                image_type_name,
                sampler_type_name,
                output_type_name,
                value_selector,
            ) = *row;

            info.n_components = n_components as GLuint;
            info.is_image_supported = is_image_supported;
            info.input_type = input_type;
            info.output_type = output_type;
            info.not_aligned_size = (input_size * n_components) as GLuint;
            info.ssbo_value_size = (output_size * n_components) as GLuint;
            info.aligned_size = Self::count_aligned_size(offset_alignment, info.not_aligned_size);
            info.image_format_name = image_format_name;
            info.image_type_name = image_type_name;
            info.sampler_type_name = sampler_type_name;
            info.output_type_name = output_type_name;
            info.value_selector = value_selector;
        }
        info
    }

    /// `countAlignedSize`
    fn count_aligned_size(offset_alignment: GLuint, total_size: GLuint) -> GLuint {
        if total_size > offset_alignment {
            let rest = total_size % offset_alignment;
            if rest == 0 {
                return total_size;
            }
            return total_size + offset_alignment - rest;
        }
        offset_alignment
    }
}

/// `TextureBufferTextureBufferRange`
pub(super) struct TextureBufferRange {
    pub(super) ext_params: ExtParameters,
}

/// The members `initTest` fills and `cleanIteration`/`deinit` release.
#[derive(Default)]
struct Objects {
    cs_id: GLuint,
    cs_po_id: GLuint,
    ssbo_size_id: GLuint,
    ssbo_value_id: GLuint,
    tbo_id: GLuint,
    tbo_tex_id: GLuint,
    vao_id: GLuint,
    vs_id: GLuint,
    fs_id: GLuint,
    vsfs_po_id: GLuint,
    tf_size_buffer_id: GLuint,
    tf_value_buffer_id: GLuint,
    buffer_total_size: GLuint,
    texture_buffer_offset_alignment: GLint,
    configurations: BTreeMap<GLenum, FormatInfo>,
}

impl TextureBufferRange {
    /// `initTest`
    fn init_test(context: &Context, base: &TestCaseBase, objects: &mut Objects) -> Result<(), TestError> {
        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;

        if !base.is_texture_buffer_supported {
            return Err(TestError::NotSupported(
                TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        gl_call!(
            gl,
            "Error getting GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT_EXT parameter value!",
            gl.get_integerv(
                tokens.texture_buffer_offset_alignment,
                &mut objects.texture_buffer_offset_alignment
            )
        );

        let formats = [
            glw::GL_R8,
            glw::GL_R16F,
            glw::GL_R32F,
            glw::GL_R8I,
            glw::GL_R16I,
            glw::GL_R32I,
            glw::GL_R8UI,
            glw::GL_R16UI,
            glw::GL_R32UI,
            glw::GL_RG8,
            glw::GL_RG16F,
            glw::GL_RG32F,
            glw::GL_RG8I,
            glw::GL_RG16I,
            glw::GL_RG32I,
            glw::GL_RG8UI,
            glw::GL_RG16UI,
            glw::GL_RG32UI,
            glw::GL_RGB32F,
            glw::GL_RGB32I,
            glw::GL_RGB32UI,
            glw::GL_RGBA8,
            glw::GL_RGBA16F,
            glw::GL_RGBA32F,
            glw::GL_RGBA8I,
            glw::GL_RGBA16I,
            glw::GL_RGBA32I,
            glw::GL_RGBA8UI,
            glw::GL_RGBA16UI,
            glw::GL_RGBA32UI,
        ];

        for format in formats {
            let info = FormatInfo::new(format, objects.texture_buffer_offset_alignment as GLuint);
            objects.buffer_total_size += info.aligned_size;
            objects.configurations.insert(format, info);
        }

        let mut buffer = vec![0u8; objects.buffer_total_size as usize];

        let mut offset = 0usize;
        for info in objects.configurations.values() {
            Self::fill_input_data(&mut buffer, offset, info)?;
            offset += info.aligned_size as usize;
        }

        // SAFETY: object creation and binding on the current context.
        unsafe {
            gl.gen_vertex_arrays(1, &mut objects.vao_id);
            gl.bind_vertex_array(objects.vao_id);
        }

        gl_call!(
            gl,
            "Error generating buffer object!",
            gl.gen_buffers(1, &mut objects.tbo_id)
        );
        gl_call!(
            gl,
            "Error binding buffer object !",
            gl.bind_buffer(tokens.texture_buffer, objects.tbo_id)
        );
        gl_call!(
            gl,
            "Error allocating buffer object's data store!",
            gl.buffer_data(
                tokens.texture_buffer,
                objects.buffer_total_size as GLsizeiptr,
                buffer.as_ptr().cast(),
                glw::GL_STATIC_DRAW
            )
        );
        Ok(())
    }

    /// `getComputeShaderCode`
    fn get_compute_shader_code(info: &FormatInfo) -> String {
        format!(
            concat!(
                "${{VERSION}}\n",
                "\n",
                "${{TEXTURE_BUFFER_REQUIRE}}\n",
                "\n",
                "precision highp float;\n",
                "\n",
                "layout({}, binding = 0) uniform highp readonly {} image_buffer;\n",
                "\n",
                "layout(binding = 0 ) buffer ComputeSSBOSize\n",
                "{{\n",
                "    int outImageSize;\n",
                "}} computeSSBOSize;\n",
                "layout(binding = 1 ) buffer ComputeSSBOSizeValue\n",
                "{{\n",
                "    {} outValue;\n",
                "}} computeSSBOValue;\n",
                "\n",
                "layout (local_size_x = 1 ) in;\n",
                "\n",
                "void main(void)\n",
                "{{\n",
                "    computeSSBOValue.outValue    = imageLoad( image_buffer, 0){};\n",
                "    computeSSBOSize.outImageSize = imageSize( image_buffer );\n",
                "}}\n",
            ),
            info.image_format_name, info.image_type_name, info.output_type_name, info.value_selector
        )
    }

    /// `getFragmentShaderCode`
    fn get_fragment_shader_code() -> &'static str {
        concat!(
            "${VERSION}\n",
            "\n",
            "${TEXTURE_BUFFER_REQUIRE}\n",
            "\n",
            "precision highp float;\n",
            "\n",
            "void main(void)\n",
            "{\n",
            "}\n",
        )
    }

    /// `getVertexShaderCode`
    fn get_vertex_shader_code(info: &FormatInfo) -> String {
        let interpolation_qualifier = if info.output_type == glw::GL_UNSIGNED_INT || info.output_type == glw::GL_INT {
            "flat "
        } else {
            ""
        };

        format!(
            concat!(
                "${{VERSION}}\n",
                "\n",
                "${{TEXTURE_BUFFER_REQUIRE}}\n",
                "\n",
                "precision highp float;\n",
                "\n",
                "uniform highp {} sampler_buffer;\n",
                "\n",
                "layout(location = 0 ) out flat int outTextureSize;\n",
                "layout(location = 1 ) out {}{} outValue;\n",
                "void main(void)\n",
                "{{\n",
                "    outValue       = texelFetch ( sampler_buffer, 0){};\n",
                "    outTextureSize = textureSize( sampler_buffer );\n",
                "    gl_Position    = vec4(0.0f, 0.0f, 0.0f, 0.0f);\n",
                "}}\n",
            ),
            info.sampler_type_name, interpolation_qualifier, info.output_type_name, info.value_selector
        )
    }

    /// `cleanIteration`
    fn clean_iteration(context: &Context, base: &TestCaseBase, objects: &mut Objects) -> Result<(), TestError> {
        let gl = context.gl();

        // SAFETY: state resets on the current context.
        unsafe {
            gl.use_program(0);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, 0);
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, 0);
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0);
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 1, 0);
            gl.bind_texture(base.gl_ext_tokens.texture_buffer, 0);
        }
        glu::expect_no_error(gl, "Error reseting GLES state after iteration!")?;

        // SAFETY: deletes of names this case created.
        unsafe {
            if objects.vsfs_po_id != 0 {
                gl.delete_program(objects.vsfs_po_id);
                objects.vsfs_po_id = 0;
            }
            if objects.vs_id != 0 {
                gl.delete_shader(objects.vs_id);
                objects.vs_id = 0;
            }
            if objects.fs_id != 0 {
                gl.delete_shader(objects.fs_id);
                objects.fs_id = 0;
            }
            if objects.tf_size_buffer_id != 0 {
                gl.delete_buffers(1, &objects.tf_size_buffer_id);
                objects.tf_size_buffer_id = 0;
            }
            if objects.tf_value_buffer_id != 0 {
                gl.delete_buffers(1, &objects.tf_value_buffer_id);
                objects.tf_value_buffer_id = 0;
            }
            if objects.cs_po_id != 0 {
                gl.delete_program(objects.cs_po_id);
                objects.cs_po_id = 0;
            }
            if objects.cs_id != 0 {
                gl.delete_shader(objects.cs_id);
                objects.cs_id = 0;
            }
            if objects.ssbo_size_id != 0 {
                gl.delete_buffers(1, &objects.ssbo_size_id);
                objects.ssbo_size_id = 0;
            }
            if objects.ssbo_value_id != 0 {
                gl.delete_buffers(1, &objects.ssbo_value_id);
                objects.ssbo_value_id = 0;
            }
            if objects.tbo_tex_id != 0 {
                gl.delete_textures(1, &objects.tbo_tex_id);
                objects.tbo_tex_id = 0;
            }
        }
        glu::expect_no_error(gl, "Error removing iteration resources!")
    }

    /// `deinit`
    fn deinit(context: &Context, base: &TestCaseBase, objects: &mut Objects) {
        let gl = context.gl();

        if !base.is_texture_buffer_supported {
            return;
        }

        // SAFETY: state resets and deletes of names this case created.
        unsafe {
            gl.bind_buffer(base.gl_ext_tokens.texture_buffer, 0);
            gl.bind_vertex_array(0);

            if objects.tbo_id != 0 {
                gl.delete_buffers(1, &objects.tbo_id);
                objects.tbo_id = 0;
            }
            if objects.vao_id != 0 {
                gl.delete_vertex_arrays(1, &objects.vao_id);
            }
        }

        // The error check inside cleanIteration may throw upstream as well; a failing deinit has nobody to report to.
        let _ = Self::clean_iteration(context, base, objects);
    }

    /// The body of `iterate` after `initTest`
    fn run(context: &Context, base: &TestCaseBase, objects: &mut Objects) -> Result<bool, TestError> {
        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;

        Self::init_test(context, base, objects)?;

        let mut test_result = true;
        let mut offset: GLuint = 0;

        let infos: Vec<FormatInfo> = objects.configurations.values().cloned().collect();
        for info in &infos {
            gl_call!(
                gl,
                "Error generating texture object!",
                gl.gen_textures(1, &mut objects.tbo_tex_id)
            );
            gl_call!(
                gl,
                "Error setting active texture unit!",
                gl.active_texture(glw::GL_TEXTURE0)
            );
            gl_call!(
                gl,
                "Error binding texture buffer object!",
                gl.bind_texture(tokens.texture_buffer, objects.tbo_tex_id)
            );
            gl_call!(
                gl,
                "Error setting buffer object as data store for texture buffer!",
                gl.tex_buffer_range(
                    tokens.texture_buffer,
                    info.internal_format,
                    objects.tbo_id,
                    offset as GLintptr,
                    info.not_aligned_size as GLsizeiptr
                )
            );

            gl_call!(
                gl,
                "Error generating buffer object!",
                gl.gen_buffers(1, &mut objects.tf_size_buffer_id)
            );
            gl_call!(
                gl,
                "Error binding buffer object!",
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, objects.tf_size_buffer_id)
            );
            gl_call!(
                gl,
                "Error allocating buffer object's data store!",
                gl.buffer_data(
                    glw::GL_ARRAY_BUFFER,
                    size_of::<GLint>() as GLsizeiptr,
                    std::ptr::null(),
                    glw::GL_DYNAMIC_COPY
                )
            );

            let buffer = vec![0u8; info.ssbo_value_size as usize];

            gl_call!(
                gl,
                "Error generating buffer object!",
                gl.gen_buffers(1, &mut objects.tf_value_buffer_id)
            );
            gl_call!(
                gl,
                "Error binding buffer object!",
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, objects.tf_value_buffer_id)
            );
            gl_call!(
                gl,
                "Error allocating buffer object's data store!",
                gl.buffer_data(
                    glw::GL_ARRAY_BUFFER,
                    info.ssbo_value_size as GLsizeiptr,
                    buffer.as_ptr().cast(),
                    glw::GL_DYNAMIC_COPY
                )
            );

            // SAFETY: object creation on the current context.
            unsafe { objects.vsfs_po_id = gl.create_program() };
            glu::expect_no_error(gl, "Error creating program object!")?;

            let varyings = [
                CString::new("outTextureSize").expect("no NUL"),
                CString::new("outValue").expect("no NUL"),
            ];
            let varying_ptrs = [varyings[0].as_ptr(), varyings[1].as_ptr()];
            gl_call!(
                gl,
                "Error setting transform feedback varyings!",
                gl.transform_feedback_varyings(objects.vsfs_po_id, 2, varying_ptrs.as_ptr(), glw::GL_SEPARATE_ATTRIBS)
            );

            // SAFETY: as above.
            unsafe { objects.fs_id = gl.create_shader(glw::GL_FRAGMENT_SHADER) };
            glu::expect_no_error(gl, "Error creating shader object!")?;

            // SAFETY: as above.
            unsafe { objects.vs_id = gl.create_shader(glw::GL_VERTEX_SHADER) };
            glu::expect_no_error(gl, "Error creating shader object!")?;

            let fs_source = Self::get_fragment_shader_code();
            let vs_source = Self::get_vertex_shader_code(info);
            let fs_parts = [fs_source];
            let vs_parts = [vs_source.as_str()];
            let stages = [
                ShaderBody::Source(objects.fs_id, &fs_parts),
                ShaderBody::Source(objects.vs_id, &vs_parts),
            ];
            if !base.build_program(context, objects.vsfs_po_id, &stages)?.0 {
                return Err(TestError::Fail(
                    "Could not build program from valid vertex/fragment shader code!".to_string(),
                ));
            }

            gl_call!(
                gl,
                "Error setting active program object!",
                gl.use_program(objects.vsfs_po_id)
            );

            let sampler_name = CString::new("sampler_buffer").expect("no NUL");
            // SAFETY: a NUL-terminated name on the program in use.
            let sampler_location = unsafe { gl.get_uniform_location(objects.vsfs_po_id, sampler_name.as_ptr()) };
            glu::expect_no_error(gl, "Error getting uniform location!")?;
            if sampler_location == -1 {
                return Err(TestError::Fail(
                    "Failed to get uniform location for valid uniform variable".to_string(),
                ));
            }

            gl_call!(
                gl,
                "Error setting value for uniform location!",
                gl.uniform_1i(sampler_location, 0)
            );

            gl_call!(
                gl,
                "Error binding buffer object to transform feedback binding point.",
                gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, objects.tf_size_buffer_id)
            );
            gl_call!(
                gl,
                "Error binding buffer object to transform feedback binding point.",
                gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 1, objects.tf_value_buffer_id)
            );

            gl_call!(
                gl,
                "Error beginning transform feedback.",
                gl.begin_transform_feedback(glw::GL_POINTS)
            );

            // SAFETY: a draw with the program and transform feedback set up above.
            let glerr = unsafe {
                gl.draw_arrays(glw::GL_POINTS, 0, 1);
                gl.get_error()
            };

            // SAFETY: ends the transform feedback begun above.
            unsafe { gl.end_transform_feedback() };
            if glerr != glw::GL_NO_ERROR {
                return Err(TestError::Fail(format!("Error drawing arrays (GL error {glerr:#x})")));
            }
            glu::expect_no_error(gl, "Error ending transform feedback.")?;

            gl_call!(
                gl,
                "Error setting memory barrier.",
                gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT)
            );

            if !Self::check_result(context, objects, info, "Vertex/Fragment shader", true)? {
                test_result = false;
            }

            if info.is_image_supported {
                gl_call!(
                    gl,
                    "Error generating buffer object!",
                    gl.gen_buffers(1, &mut objects.ssbo_size_id)
                );
                gl_call!(
                    gl,
                    "Error binding  buffer object!",
                    gl.bind_buffer(glw::GL_ARRAY_BUFFER, objects.ssbo_size_id)
                );
                gl_call!(
                    gl,
                    "Error allocating buffer object's data store!",
                    gl.buffer_data(
                        glw::GL_ARRAY_BUFFER,
                        size_of::<GLint>() as GLsizeiptr,
                        std::ptr::null(),
                        glw::GL_DYNAMIC_COPY
                    )
                );

                gl_call!(
                    gl,
                    "Error generating buffer object!",
                    gl.gen_buffers(1, &mut objects.ssbo_value_id)
                );
                gl_call!(
                    gl,
                    "Error binding  buffer object!",
                    gl.bind_buffer(glw::GL_ARRAY_BUFFER, objects.ssbo_value_id)
                );
                gl_call!(
                    gl,
                    "Error allocating buffer object's data store!",
                    gl.buffer_data(
                        glw::GL_ARRAY_BUFFER,
                        info.ssbo_value_size as GLsizeiptr,
                        buffer.as_ptr().cast(),
                        glw::GL_DYNAMIC_COPY
                    )
                );

                // SAFETY: object creation on the current context.
                unsafe { objects.cs_po_id = gl.create_program() };
                glu::expect_no_error(gl, "Error creating program object!")?;

                // SAFETY: as above.
                unsafe { objects.cs_id = gl.create_shader(glw::GL_COMPUTE_SHADER) };
                glu::expect_no_error(gl, "Error creating shader object!")?;

                let cs_source = Self::get_compute_shader_code(info);
                let cs_parts = [cs_source.as_str()];
                if !base
                    .build_program(
                        context,
                        objects.cs_po_id,
                        &[ShaderBody::Source(objects.cs_id, &cs_parts)],
                    )?
                    .0
                {
                    return Err(TestError::Fail(
                        "Could not build program from valid compute shader code!".to_string(),
                    ));
                }

                gl_call!(
                    gl,
                    "Error setting active program object!",
                    gl.use_program(objects.cs_po_id)
                );

                gl_call!(
                    gl,
                    "Error binding buffer object to shader storage binding point!",
                    gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, objects.ssbo_size_id)
                );
                gl_call!(
                    gl,
                    "Error binding buffer object to shader storage binding point!",
                    gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, objects.ssbo_value_id)
                );

                gl_call!(
                    gl,
                    "Error binding texture object to image unit 0!",
                    gl.bind_image_texture(
                        0,
                        objects.tbo_tex_id,
                        0,
                        glw::GL_FALSE as glw::GLboolean,
                        0,
                        glw::GL_READ_ONLY,
                        info.internal_format
                    )
                );

                gl_call!(gl, "Error running compute shader!", gl.dispatch_compute(1, 1, 1));
                gl_call!(
                    gl,
                    "Error setting memory barrier!",
                    gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT)
                );

                if !Self::check_result(context, objects, info, "Compute shader", false)? {
                    test_result = false;
                }
            }

            offset += info.aligned_size;
            Self::clean_iteration(context, base, objects)?;
        }

        Ok(test_result)
    }

    /// `checkResult`
    fn check_result(
        context: &Context,
        objects: &Objects,
        info: &FormatInfo,
        phase: &str,
        transform_feedback: bool,
    ) -> Result<bool, TestError> {
        let gl = context.gl();

        let (buffer_target, buffer_size_id, buffer_value_id) = if transform_feedback {
            (
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                objects.tf_size_buffer_id,
                objects.tf_value_buffer_id,
            )
        } else {
            (
                glw::GL_SHADER_STORAGE_BUFFER,
                objects.ssbo_size_id,
                objects.ssbo_value_id,
            )
        };

        let mut test_result = true;

        gl_call!(
            gl,
            "Error binding buffer!",
            gl.bind_buffer(buffer_target, buffer_size_id)
        );

        // SAFETY: a read mapping of the first GLint of the bound buffer.
        let size =
            unsafe { gl.map_buffer_range(buffer_target, 0, size_of::<GLint>() as GLsizeiptr, glw::GL_MAP_READ_BIT) };
        glu::expect_no_error(gl, "Error mapping buffer!")?;

        const EXPECTED_SIZE: GLint = 1;

        // SAFETY: the mapping is at least four bytes long until it is unmapped below.
        let size_value = if size.is_null() {
            None
        } else {
            Some(unsafe { size.cast::<GLint>().read_unaligned() })
        };
        if size_value != Some(EXPECTED_SIZE) {
            log::info!(
                "Texture size is wrong for {phase} phase \nInternal Format: {:#x}\nExpected size:   {EXPECTED_SIZE}\nResult size:     {size_value:?}\n",
                info.internal_format
            );
        }

        gl_call!(gl, "Error unmapping buffer!", gl.unmap_buffer(buffer_target));

        gl_call!(
            gl,
            "Error binding buffer!",
            gl.bind_buffer(buffer_target, buffer_value_id)
        );

        // SAFETY: a read mapping of the value store, which is `ssbo_value_size` bytes long.
        let mapped = unsafe {
            gl.map_buffer_range(
                buffer_target,
                0,
                info.ssbo_value_size as GLsizeiptr,
                glw::GL_MAP_READ_BIT,
            )
        };
        let map_error = glu::expect_no_error(gl, "Error mapping buffer!");
        if map_error.is_err() || mapped.is_null() {
            if !mapped.is_null() {
                // SAFETY: undoes the successful mapping above.
                unsafe { gl.unmap_buffer(buffer_target) };
            }
            map_error?;
            return Err(TestError::Fail("Error mapping buffer!".to_string()));
        }

        let n = info.n_components as usize;
        let internal_format = info.internal_format;

        match info.output_type {
            glw::GL_FLOAT => {
                // SAFETY: the mapping holds `n` floats.
                let res = unsafe { std::slice::from_raw_parts(mapped.cast::<f32>(), n) };
                for (i, &value) in res.iter().enumerate() {
                    if (value - 1.0f32).abs() > EPSILON_FLOAT {
                        Self::log_error(phase, internal_format, i, &1.0f32.to_string(), &value.to_string());
                        test_result = false;
                    }
                }
            }
            glw::GL_INT => {
                // SAFETY: the mapping holds `n` ints.
                let res = unsafe { std::slice::from_raw_parts(mapped.cast::<i32>(), n) };
                for (i, &value) in res.iter().enumerate() {
                    if value != 1 {
                        Self::log_error(phase, internal_format, i, "1", &value.to_string());
                        test_result = false;
                    }
                }
            }
            glw::GL_UNSIGNED_INT => {
                // SAFETY: the mapping holds `n` uints.
                let res = unsafe { std::slice::from_raw_parts(mapped.cast::<u32>(), n) };
                for (i, &value) in res.iter().enumerate() {
                    if value != 1 {
                        Self::log_error(phase, internal_format, i, "1", &value.to_string());
                        test_result = false;
                    }
                }
            }
            _ => {
                gl_call!(gl, "Error ummapping buffer!", gl.unmap_buffer(buffer_target));
                return Err(TestError::Fail("Not allowed output type".to_string()));
            }
        }

        gl_call!(gl, "Error ummapping buffer!", gl.unmap_buffer(buffer_target));

        Ok(test_result)
    }

    /// `logError`
    fn log_error(phase: &str, internal_format: GLenum, component: usize, expected_value: &str, result_value: &str) {
        log::info!(
            "Result is different for {phase} phase \nInternal Format: {internal_format:#x}\nComponent Position: {component}\nExpected value: {expected_value}\nResult value: {result_value}\n"
        );
    }

    /// `fillInputData` - every component of the texel at `offset` gets the value that reads back as 1.
    fn fill_input_data(buffer: &mut [u8], offset: usize, info: &FormatInfo) -> Result<(), TestError> {
        let n = info.n_components as usize;
        let texel = &mut buffer[offset..];

        match info.input_type {
            glw::GL_FLOAT => {
                for i in 0..n {
                    texel[i * 4..i * 4 + 4].copy_from_slice(&1.0f32.to_ne_bytes());
                }
            }
            glw::GL_HALF_FLOAT => {
                for i in 0..n {
                    texel[i * 2..i * 2 + 2].copy_from_slice(&HALF_ONE.to_ne_bytes());
                }
            }
            glw::GL_UNSIGNED_BYTE => {
                let normalized = info.internal_format == glw::GL_R8
                    || info.internal_format == glw::GL_RG8
                    || info.internal_format == glw::GL_RGBA8;
                let val: u8 = if normalized { 255 } else { 1 };
                texel[..n].fill(val);
            }
            glw::GL_UNSIGNED_SHORT | glw::GL_SHORT => {
                for i in 0..n {
                    texel[i * 2..i * 2 + 2].copy_from_slice(&1u16.to_ne_bytes());
                }
            }
            glw::GL_UNSIGNED_INT | glw::GL_INT => {
                for i in 0..n {
                    texel[i * 4..i * 4 + 4].copy_from_slice(&1u32.to_ne_bytes());
                }
            }
            glw::GL_BYTE => texel[..n].fill(1),
            _ => return Err(TestError::Fail("Not allowed input type".to_string())),
        }
        Ok(())
    }
}

impl TestCase for TextureBufferRange {
    fn name(&self) -> &str {
        "texture_buffer_texture_buffer_range"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        let mut objects = Objects::default();

        let outcome = Self::run(context, &base, &mut objects);
        Self::deinit(context, &base, &mut objects);

        Ok(if outcome? {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}
