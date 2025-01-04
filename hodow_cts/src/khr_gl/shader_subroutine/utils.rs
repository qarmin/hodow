// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderSubroutineTests.{hpp,cpp}  (ShaderSubroutine::Utils)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The RAII structs of `Utils` (`buffer`, `framebuffer`, `program`, `texture`, `vertexArray`) are the same here, their destructors are `Drop`; a TCU_FAIL is a `TestError::Fail`.

use std::ffi::{CString, c_void};

use super::fail;
use crate::glu::Context;
use crate::glw::{self, GLenum, GLint, GLsizei, GLuint};
use crate::tcu::TestError;

/// `Utils::_variable_type`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum VariableType {
    Bool,
    Bvec2,
    Bvec3,
    Bvec4,
    Double,
    Dvec2,
    Dvec3,
    Dvec4,
    Float,
    Int,
    Ivec2,
    Ivec3,
    Ivec4,
    Mat2,
    Mat2x3,
    Mat2x4,
    Mat3,
    Mat3x2,
    Mat3x4,
    Mat4,
    Mat4x2,
    Mat4x3,
    Uint,
    Uvec2,
    Uvec3,
    Uvec4,
    Vec2,
    Vec3,
    Vec4,
}

impl VariableType {
    /// `Utils::getBaseVariableType`
    pub(super) fn base(self) -> VariableType {
        use VariableType::*;
        match self {
            Bool | Bvec2 | Bvec3 | Bvec4 => Bool,
            Double | Dvec2 | Dvec3 | Dvec4 => Double,
            Float | Mat2 | Mat2x3 | Mat2x4 | Mat3 | Mat3x2 | Mat3x4 | Mat4 | Mat4x2 | Mat4x3 | Vec2 | Vec3 | Vec4 => {
                Float
            }
            Int | Ivec2 | Ivec3 | Ivec4 => Int,
            Uint | Uvec2 | Uvec3 | Uvec4 => Uint,
        }
    }

    /// `Utils::getComponentSizeForVariableType`
    pub(super) fn component_size(self) -> usize {
        match self.base() {
            VariableType::Bool => std::mem::size_of::<bool>(),
            VariableType::Double => std::mem::size_of::<f64>(),
            VariableType::Float => std::mem::size_of::<f32>(),
            _ => std::mem::size_of::<i32>(),
        }
    }

    /// `Utils::getNumberOfComponentsForVariableType`
    pub(super) fn n_components(self) -> usize {
        use VariableType::*;
        match self {
            Bool | Double | Float | Int | Uint => 1,
            Bvec2 | Dvec2 | Ivec2 | Uvec2 | Vec2 => 2,
            Bvec3 | Dvec3 | Ivec3 | Uvec3 | Vec3 => 3,
            Bvec4 | Dvec4 | Ivec4 | Mat2 | Uvec4 | Vec4 => 4,
            Mat2x3 | Mat3x2 => 6,
            Mat2x4 | Mat4x2 => 8,
            Mat3 => 9,
            Mat3x4 | Mat4x3 => 12,
            Mat4 => 16,
        }
    }

    /// `Utils::getVariableTypeGLSLString`
    pub(super) fn glsl_name(self) -> &'static str {
        use VariableType::*;
        match self {
            Bool => "bool",
            Bvec2 => "bvec2",
            Bvec3 => "bvec3",
            Bvec4 => "bvec4",
            Double => "double",
            Dvec2 => "dvec2",
            Dvec3 => "dvec3",
            Dvec4 => "dvec4",
            Float => "float",
            Int => "int",
            Ivec2 => "ivec2",
            Ivec3 => "ivec3",
            Ivec4 => "ivec4",
            Mat2 => "mat2",
            Mat2x3 => "mat2x3",
            Mat2x4 => "mat2x4",
            Mat3 => "mat3",
            Mat3x2 => "mat3x2",
            Mat3x4 => "mat3x4",
            Mat4 => "mat4",
            Mat4x2 => "mat4x2",
            Mat4x3 => "mat4x3",
            Uint => "uint",
            Uvec2 => "uvec2",
            Uvec3 => "uvec3",
            Uvec4 => "uvec4",
            Vec2 => "vec2",
            Vec3 => "vec3",
            Vec4 => "vec4",
        }
    }

    /// `Utils::getVariableTypeFromProperties`
    pub(super) fn from_properties(base: VariableType, n_components: usize) -> Result<VariableType, TestError> {
        use VariableType::*;
        let types = match base {
            Bool => [Bool, Bvec2, Bvec3, Bvec4],
            Double => [Double, Dvec2, Dvec3, Dvec4],
            Float => [Float, Vec2, Vec3, Vec4],
            Int => [Int, Ivec2, Ivec3, Ivec4],
            Uint => [Uint, Uvec2, Uvec3, Uvec4],
            _ => return fail("Unrecognized base variable type"),
        };
        match n_components {
            1..=4 => Ok(types[n_components - 1]),
            _ => fail("Unsupported number of components requested"),
        }
    }
}

/// `Utils::vec4<T>` of floats, compared with the 1e-5 tolerance of `Utils::compare`.
#[derive(Clone, Copy, Debug)]
pub(super) struct Vec4(pub(super) [f32; 4]);

impl Vec4 {
    /// `vec4::operator==`
    pub(super) fn matches(&self, other: &Vec4) -> bool {
        self.0
            .iter()
            .zip(&other.0)
            .all(|(left, right)| (right - left).abs() <= 0.00001)
    }
}

/// `Utils::buffer`
pub(super) struct Buffer<'a> {
    context: &'a Context,
    pub(super) id: GLuint,
}

impl<'a> Buffer<'a> {
    pub(super) fn new(context: &'a Context) -> Self {
        Self { context, id: 0 }
    }

    /// `buffer::generate`
    pub(super) fn generate(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(gl, "GenBuffers", gl.gen_buffers(1, &mut self.id));
        Ok(())
    }

    /// `buffer::bindRange`
    pub(super) fn bind_range(
        &self,
        target: GLenum,
        index: GLuint,
        offset: glw::GLintptr,
        size: glw::GLsizeiptr,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(
            gl,
            "BindBufferRange",
            gl.bind_buffer_range(target, index, self.id, offset, size)
        );
        Ok(())
    }

    /// `buffer::update`
    pub(super) fn update(
        &self,
        target: GLenum,
        size: glw::GLsizeiptr,
        data: *const c_void,
        usage: GLenum,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(gl, "bindBuffer", gl.bind_buffer(target, self.id));
        gl_call!(gl, "bufferData", gl.buffer_data(target, size, data, usage));
        Ok(())
    }
}

impl Drop for Buffer<'_> {
    fn drop(&mut self) {
        if self.id != 0 {
            // SAFETY: the name was generated by this value and is deleted once.
            unsafe { self.context.gl().delete_buffers(1, &self.id) };
            self.id = 0;
        }
    }
}

/// `Utils::vertexArray`
pub(super) struct VertexArray<'a> {
    context: &'a Context,
    pub(super) id: GLuint,
}

impl<'a> VertexArray<'a> {
    pub(super) fn new(context: &'a Context) -> Self {
        Self { context, id: 0 }
    }

    /// `vertexArray::generate`
    pub(super) fn generate(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(gl, "GenVertexArrays", gl.gen_vertex_arrays(1, &mut self.id));
        Ok(())
    }

    /// `vertexArray::bind`
    pub(super) fn bind(&self) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(gl, "BindVertexArray", gl.bind_vertex_array(self.id));
        Ok(())
    }
}

impl Drop for VertexArray<'_> {
    fn drop(&mut self) {
        if self.id != 0 {
            // SAFETY: the name was generated by this value and is deleted once.
            unsafe { self.context.gl().delete_vertex_arrays(1, &self.id) };
            self.id = 0;
        }
    }
}

/// `Utils::texture`
pub(super) struct Texture<'a> {
    context: &'a Context,
    pub(super) id: GLuint,
}

impl<'a> Texture<'a> {
    pub(super) fn new(context: &'a Context) -> Self {
        Self { context, id: 0 }
    }

    /// `texture::bind`
    pub(super) fn bind(&self) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(gl, "BindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, self.id));
        Ok(())
    }

    /// `texture::create`
    pub(super) fn create(&mut self, width: GLuint, height: GLuint, internal_format: GLenum) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(gl, "GenTextures", gl.gen_textures(1, &mut self.id));
        self.bind()?;
        gl_call!(
            gl,
            "TexStorage2D",
            gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                1,
                internal_format,
                width as GLsizei,
                height as GLsizei
            )
        );
        Ok(())
    }

    /// `texture::get`
    pub(super) fn get(&self, format: GLenum, type_: GLenum, out_data: *mut c_void) -> Result<(), TestError> {
        let gl = self.context.gl();
        self.bind()?;
        gl_call!(
            gl,
            "GetTexImage",
            gl.get_tex_image(glw::GL_TEXTURE_2D, 0, format, type_, out_data)
        );
        Ok(())
    }

    /// `texture::update`
    pub(super) fn update(
        &self,
        width: GLuint,
        height: GLuint,
        format: GLenum,
        type_: GLenum,
        data: *const c_void,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();
        self.bind()?;
        gl_call!(
            gl,
            "TexSubImage2D",
            gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                width as GLsizei,
                height as GLsizei,
                format,
                type_,
                data
            )
        );
        Ok(())
    }
}

impl Drop for Texture<'_> {
    fn drop(&mut self) {
        if self.id != 0 {
            // SAFETY: the name was generated by this value and is deleted once.
            unsafe { self.context.gl().delete_textures(1, &self.id) };
            self.id = 0;
        }
    }
}

/// `Utils::framebuffer`
pub(super) struct Framebuffer<'a> {
    context: &'a Context,
    pub(super) id: GLuint,
}

impl<'a> Framebuffer<'a> {
    pub(super) fn new(context: &'a Context) -> Self {
        Self { context, id: 0 }
    }

    /// `framebuffer::attachTexture`
    pub(super) fn attach_texture(
        &self,
        attachment: GLenum,
        texture_id: GLuint,
        width: GLuint,
        height: GLuint,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();
        self.bind()?;
        gl_call!(gl, "BindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, texture_id));
        gl_call!(
            gl,
            "FramebufferTexture2D",
            gl.framebuffer_texture_2d(glw::GL_DRAW_FRAMEBUFFER, attachment, glw::GL_TEXTURE_2D, texture_id, 0)
        );
        gl_call!(gl, "Viewport", gl.viewport(0, 0, width as GLsizei, height as GLsizei));
        Ok(())
    }

    /// `framebuffer::bind`
    pub(super) fn bind(&self) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(
            gl,
            "BindFramebuffer",
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, self.id)
        );
        Ok(())
    }

    /// `framebuffer::clear`
    pub(super) fn clear(&self, mask: glw::GLbitfield) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(gl, "Clear", gl.clear(mask));
        Ok(())
    }

    /// `framebuffer::clearColor`
    pub(super) fn clear_color(&self, red: f32, green: f32, blue: f32, alpha: f32) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(gl, "ClearColor", gl.clear_color(red, green, blue, alpha));
        Ok(())
    }

    /// `framebuffer::generate`
    pub(super) fn generate(&mut self) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(gl, "GenFramebuffers", gl.gen_framebuffers(1, &mut self.id));
        Ok(())
    }
}

impl Drop for Framebuffer<'_> {
    fn drop(&mut self) {
        if self.id != 0 {
            // SAFETY: the name was generated by this value and is deleted once.
            unsafe { self.context.gl().delete_framebuffers(1, &self.id) };
            self.id = 0;
        }
    }
}

/// The shader bodies `program::build` takes, one slot per stage.
#[derive(Default, Clone, Copy)]
pub(super) struct ProgramSources<'s> {
    pub(super) compute: Option<&'s str>,
    pub(super) fragment: Option<&'s str>,
    pub(super) geometry: Option<&'s str>,
    pub(super) tess_control: Option<&'s str>,
    pub(super) tess_evaluation: Option<&'s str>,
    pub(super) vertex: Option<&'s str>,
}

/// `Utils::program`
pub(super) struct Program<'a> {
    context: &'a Context,
    compute_shader_id: GLuint,
    fragment_shader_id: GLuint,
    geometry_shader_id: GLuint,
    pub(super) program_object_id: GLuint,
    tess_control_shader_id: GLuint,
    tess_evaluation_shader_id: GLuint,
    vertex_shader_id: GLuint,
}

impl<'a> Program<'a> {
    pub(super) fn new(context: &'a Context) -> Self {
        Self {
            context,
            compute_shader_id: 0,
            fragment_shader_id: 0,
            geometry_shader_id: 0,
            program_object_id: 0,
            tess_control_shader_id: 0,
            tess_evaluation_shader_id: 0,
            vertex_shader_id: 0,
        }
    }

    fn create_and_compile(&self, shader_type: GLenum, code: &str) -> Result<GLuint, TestError> {
        let gl = self.context.gl();
        // SAFETY: plain object creation.
        let id = unsafe { gl.create_shader(shader_type) };
        crate::glu::expect_no_error(gl, "CreateShader")?;

        if let Err(error) = self.compile(id, code) {
            // SAFETY: the shader was created above and is not stored anywhere else.
            unsafe { gl.delete_shader(id) };
            return Err(error);
        }

        Ok(id)
    }

    /// `program::build`
    pub(super) fn build(
        &mut self,
        sources: &ProgramSources,
        varying_names: &[&str],
        is_separable: bool,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();

        if let Some(code) = sources.compute {
            self.compute_shader_id = self.create_and_compile(glw::GL_COMPUTE_SHADER, code)?;
        }
        if let Some(code) = sources.fragment {
            self.fragment_shader_id = self.create_and_compile(glw::GL_FRAGMENT_SHADER, code)?;
        }
        if let Some(code) = sources.geometry {
            self.geometry_shader_id = self.create_and_compile(glw::GL_GEOMETRY_SHADER, code)?;
        }
        if let Some(code) = sources.tess_control {
            self.tess_control_shader_id = self.create_and_compile(glw::GL_TESS_CONTROL_SHADER, code)?;
        }
        if let Some(code) = sources.tess_evaluation {
            self.tess_evaluation_shader_id = self.create_and_compile(glw::GL_TESS_EVALUATION_SHADER, code)?;
        }
        if let Some(code) = sources.vertex {
            self.vertex_shader_id = self.create_and_compile(glw::GL_VERTEX_SHADER, code)?;
        }

        // SAFETY: plain object creation.
        self.program_object_id = unsafe { gl.create_program() };
        crate::glu::expect_no_error(gl, "CreateProgram")?;

        if !varying_names.is_empty() {
            let names: Vec<CString> = varying_names
                .iter()
                .map(|name| CString::new(*name).expect("varying names have no NUL"))
                .collect();
            let pointers: Vec<_> = names.iter().map(|name| name.as_ptr()).collect();
            gl_call!(
                gl,
                "TransformFeedbackVaryings",
                gl.transform_feedback_varyings(
                    self.program_object_id,
                    pointers.len() as GLsizei,
                    pointers.as_ptr(),
                    glw::GL_INTERLEAVED_ATTRIBS
                )
            );
        }

        if is_separable {
            gl_call!(
                gl,
                "ProgramParameteri",
                gl.program_parameteri(self.program_object_id, glw::GL_PROGRAM_SEPARABLE, glw::GL_TRUE as GLint)
            );
        }

        self.link()
    }

    /// `program::compile`
    fn compile(&self, shader_id: GLuint, shader_code: &str) -> Result<(), TestError> {
        let gl = self.context.gl();
        let mut status = glw::GL_FALSE as GLint;

        super::shader_source(gl, shader_id, shader_code)?;
        gl_call!(gl, "CompileShader", gl.compile_shader(shader_id));
        gl_call!(
            gl,
            "GetShaderiv",
            gl.get_shaderiv(shader_id, glw::GL_COMPILE_STATUS, &mut status)
        );

        if status != glw::GL_TRUE as GLint {
            let mut length: GLint = 0;
            gl_call!(
                gl,
                "GetShaderiv",
                gl.get_shaderiv(shader_id, glw::GL_INFO_LOG_LENGTH, &mut length)
            );

            let mut message = vec![0u8; length.max(1) as usize];
            gl_call!(
                gl,
                "GetShaderInfoLog",
                gl.get_shader_info_log(shader_id, length, std::ptr::null_mut(), message.as_mut_ptr().cast())
            );

            log::info!(
                "Failed to compile shader:\n{}\nShader source\n{shader_code}",
                info_log_text(&message)
            );
            return fail("Failed to compile shader");
        }

        Ok(())
    }

    /// `program::isProgramBinarySupported`
    pub(super) fn is_program_binary_supported(&self) -> Result<bool, TestError> {
        let gl = self.context.gl();
        let mut n_program_binary_formats: GLint = 0;

        if self
            .context
            .context_info
            .is_extension_supported("GL_ARB_get_program_binary")
        {
            gl_call!(
                gl,
                "glGetIntegerv() call failed.",
                gl.get_integerv(glw::GL_NUM_PROGRAM_BINARY_FORMATS, &mut n_program_binary_formats)
            );
        }

        Ok(n_program_binary_formats > 0)
    }

    /// `program::createFromBinary`
    pub(super) fn create_from_binary(&mut self, binary: &[u8], binary_format: GLenum) -> Result<(), TestError> {
        let gl = self.context.gl();

        // SAFETY: plain object creation.
        self.program_object_id = unsafe { gl.create_program() };
        crate::glu::expect_no_error(gl, "CreateProgram")?;

        gl_call!(
            gl,
            "ProgramBinary",
            gl.program_binary(
                self.program_object_id,
                binary_format,
                binary.as_ptr().cast(),
                binary.len() as GLsizei
            )
        );
        Ok(())
    }

    /// `program::getBinary`
    pub(super) fn get_binary(&self) -> Result<(Vec<u8>, GLenum), TestError> {
        let gl = self.context.gl();
        let mut length: GLint = 0;
        let mut binary_format: GLenum = 0;

        gl_call!(
            gl,
            "GetProgramiv",
            gl.get_programiv(self.program_object_id, glw::GL_PROGRAM_BINARY_LENGTH, &mut length)
        );

        let mut binary = vec![0u8; length.max(0) as usize];
        gl_call!(
            gl,
            "GetProgramBinary",
            gl.get_program_binary(
                self.program_object_id,
                binary.len() as GLsizei,
                &mut length,
                &mut binary_format,
                binary.as_mut_ptr().cast()
            )
        );

        Ok((binary, binary_format))
    }

    /// `program::getSubroutineIndex`
    pub(super) fn get_subroutine_index(
        &self,
        subroutine_name: &str,
        shader_stage: GLenum,
    ) -> Result<GLuint, TestError> {
        let gl = self.context.gl();
        let name = CString::new(subroutine_name).expect("names have no NUL");

        // SAFETY: the name is a live NUL-terminated string.
        let index = unsafe { gl.get_subroutine_index(self.program_object_id, shader_stage, name.as_ptr()) };
        crate::glu::expect_no_error(gl, "GetSubroutineIndex")?;

        if index == glw::GL_INVALID_INDEX {
            log::info!("Subroutine: {subroutine_name} is not available");
            return fail("Subroutine is not available");
        }

        Ok(index)
    }

    /// `program::getSubroutineUniformLocation`
    pub(super) fn get_subroutine_uniform_location(
        &self,
        uniform_name: &str,
        shader_stage: GLenum,
    ) -> Result<GLint, TestError> {
        let gl = self.context.gl();
        let name = CString::new(uniform_name).expect("names have no NUL");

        // SAFETY: the name is a live NUL-terminated string.
        let location =
            unsafe { gl.get_subroutine_uniform_location(self.program_object_id, shader_stage, name.as_ptr()) };
        crate::glu::expect_no_error(gl, "GetSubroutineUniformLocation")?;

        if location == -1 {
            log::info!("Subroutine uniform: {uniform_name} is not available");
            return fail("Subroutine uniform is not available");
        }

        Ok(location)
    }

    /// `program::getUniformLocation`
    pub(super) fn get_uniform_location(&self, uniform_name: &str) -> Result<GLint, TestError> {
        let gl = self.context.gl();
        let name = CString::new(uniform_name).expect("names have no NUL");

        // SAFETY: the name is a live NUL-terminated string.
        let location = unsafe { gl.get_uniform_location(self.program_object_id, name.as_ptr()) };
        crate::glu::expect_no_error(gl, "GetUniformLocation")?;

        if location == -1 {
            log::info!("Uniform: {uniform_name} is not available");
            return fail("Uniform is not available");
        }

        Ok(location)
    }

    /// `program::link`
    pub(super) fn link(&self) -> Result<(), TestError> {
        let gl = self.context.gl();
        let mut status = glw::GL_FALSE as GLint;

        for shader_id in [
            self.compute_shader_id,
            self.fragment_shader_id,
            self.geometry_shader_id,
            self.tess_control_shader_id,
            self.tess_evaluation_shader_id,
            self.vertex_shader_id,
        ] {
            if shader_id != 0 {
                gl_call!(gl, "AttachShader", gl.attach_shader(self.program_object_id, shader_id));
            }
        }

        gl_call!(gl, "LinkProgram", gl.link_program(self.program_object_id));
        gl_call!(
            gl,
            "GetProgramiv",
            gl.get_programiv(self.program_object_id, glw::GL_LINK_STATUS, &mut status)
        );

        if status != glw::GL_TRUE as GLint {
            let mut length: GLint = 0;
            gl_call!(
                gl,
                "GetProgramiv",
                gl.get_programiv(self.program_object_id, glw::GL_INFO_LOG_LENGTH, &mut length)
            );

            let mut message = vec![0u8; length.max(1) as usize];
            gl_call!(
                gl,
                "GetProgramInfoLog",
                gl.get_program_info_log(
                    self.program_object_id,
                    length,
                    std::ptr::null_mut(),
                    message.as_mut_ptr().cast()
                )
            );

            log::info!("Failed to link program:\n{}", info_log_text(&message));
            return fail("Failed to link program");
        }

        Ok(())
    }

    /// `program::remove`
    pub(super) fn remove(&mut self) {
        let gl = self.context.gl();

        // SAFETY: every name below was created by this value, is deleted once and zero names are skipped.
        unsafe {
            gl.use_program(0);

            if self.program_object_id != 0 {
                gl.delete_program(self.program_object_id);
                self.program_object_id = 0;
            }

            for shader_id in [
                &mut self.compute_shader_id,
                &mut self.fragment_shader_id,
                &mut self.geometry_shader_id,
                &mut self.tess_control_shader_id,
                &mut self.tess_evaluation_shader_id,
                &mut self.vertex_shader_id,
            ] {
                if *shader_id != 0 {
                    gl.delete_shader(*shader_id);
                    *shader_id = 0;
                }
            }
        }
    }

    /// `program::use`
    pub(super) fn use_program(&self) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(gl, "UseProgram", gl.use_program(self.program_object_id));
        Ok(())
    }
}

impl Drop for Program<'_> {
    fn drop(&mut self) {
        self.remove();
    }
}

/// The text of an info log buffer up to its terminator.
fn info_log_text(message: &[u8]) -> String {
    let end = message.iter().position(|&byte| byte == 0).unwrap_or(message.len());
    String::from_utf8_lossy(&message[..end]).into_owned()
}

/// `Utils::vec4<GLuint>`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) struct UVec4(pub(super) [u32; 4]);

/// `glBeginTransformFeedback(GL_POINTS)`, a draw of `n_points` points, `glEndTransformFeedback`, then the first `n_words` 32-bit words of the transform feedback buffer; every caller binds the buffer first.
pub(super) fn draw_points_and_read_xfb(
    context: &Context,
    n_points: GLsizei,
    n_words: usize,
) -> Result<Vec<u32>, TestError> {
    let gl = context.gl();

    gl_call!(
        gl,
        "BeginTransformFeedback",
        gl.begin_transform_feedback(glw::GL_POINTS)
    );
    gl_call!(gl, "DrawArrays", gl.draw_arrays(glw::GL_POINTS, 0, n_points));
    gl_call!(gl, "EndTransformFeedback", gl.end_transform_feedback());

    // SAFETY: the buffer holds at least `n_words` words, written by the draw above.
    let feedback_data = unsafe { gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY) };
    crate::glu::expect_no_error(gl, "MapBuffer")?;

    if feedback_data.is_null() {
        return fail("MapBuffer returned no pointer");
    }

    // SAFETY: the mapping is at least `n_words` words long and stays valid until the unmap below.
    let words = unsafe { std::slice::from_raw_parts(feedback_data.cast::<u32>(), n_words) }.to_vec();

    gl_call!(gl, "UnmapBuffer", gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
    Ok(words)
}

/// Four consecutive words of `words` from `offset` as floats.
pub(super) fn words_as_vec4(words: &[u32], offset: usize) -> Vec4 {
    Vec4(std::array::from_fn(|i| f32::from_bits(words[offset + i])))
}
