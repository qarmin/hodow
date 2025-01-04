// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShadingLanguage420PackTests.{hpp,cpp}  (GLSL420Pack::Utils structs)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Destructors are `Drop`; the `shaderCompilationException` / `programLinkageException` throws of `program::build` are the `BuildOutcome` variants, while a TCU_FAIL stays a `TestError`. Shader code is bytes because the UTF-8 tests feed sequences that are not valid UTF-8.

use std::ffi::{CString, c_char, c_void};

use super::{TextureType, fail};
use crate::glu::Context;
use crate::glw::{self, GLenum, GLint, GLsizei, GLuint};
use crate::tcu::TestError;

/// `Utils::shaderSource::shaderPart`
#[derive(Clone, Default)]
pub(in crate::khr_gl) struct ShaderPart {
    pub(super) code: Vec<u8>,
    pub(super) length: GLint,
}

/// `Utils::shaderSource`
#[derive(Clone, Default)]
pub(in crate::khr_gl) struct ShaderSource {
    pub(super) parts: Vec<ShaderPart>,
    pub(super) use_lengths: bool,
}

impl ShaderSource {
    /// `shaderSource(const GLchar *)` with a source.
    pub(super) fn single(code: &str) -> Self {
        Self {
            parts: vec![ShaderPart {
                code: code.as_bytes().to_vec(),
                length: 0,
            }],
            use_lengths: false,
        }
    }

    /// The first part's code is empty, which upstream tests as `m_parts[0].m_code.empty()`.
    pub(super) fn first_part_empty(&self) -> bool {
        self.parts.first().is_none_or(|part| part.code.is_empty())
    }

    /// `Utils::program::printShaderSource`
    pub(super) fn print(&self) -> String {
        let mut text = String::from("Shader source.");
        let mut line_number = 0;
        for (i, part) in self.parts.iter().enumerate() {
            text.push_str(&format!("\nLine||Part: {}/{}", i + 1, self.parts.len()));
            if self.use_lengths {
                text.push_str(&format!(" Length: {}", part.length));
            }
            text.push('\n');
            for line in part.code.split_inclusive(|&byte| byte == b'\n') {
                text.push_str(&format!("{line_number:4}||{}", String::from_utf8_lossy(line)));
                line_number += 1;
            }
        }
        text
    }
}

/// What `program::build` did, where upstream throws `shaderCompilationException` and `programLinkageException`.
pub(in crate::khr_gl) enum BuildOutcome {
    Built,
    CompileFailed { source: ShaderSource, message: String },
    LinkFailed { message: String },
}

impl BuildOutcome {
    /// The `catch` blocks of the positive test bases: log and report the case as failed.
    pub(super) fn report_failure(&self) -> bool {
        match self {
            Self::Built => true,
            Self::CompileFailed { source, message } => {
                log::info!("Shader compilation failed. Error message: {message}{}", source.print());
                false
            }
            Self::LinkFailed { message } => {
                log::info!("Program linking failed. Error message: {message}");
                false
            }
        }
    }
}

/// `Utils::buffer`
pub(in crate::khr_gl) struct Buffer<'a> {
    context: &'a Context,
    pub(super) id: GLuint,
    target: GLenum,
}

impl<'a> Buffer<'a> {
    pub(super) fn new(context: &'a Context) -> Self {
        Self {
            context,
            id: 0,
            target: 0,
        }
    }

    /// `buffer::bind`
    pub(super) fn bind(&self) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(gl, "BindBuffer", gl.bind_buffer(self.target, self.id));
        Ok(())
    }

    /// `buffer::generate`
    pub(super) fn generate(&mut self, target: GLenum) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(gl, "GenBuffers", gl.gen_buffers(1, &mut self.id));
        self.target = target;
        Ok(())
    }

    /// `buffer::map`
    pub(super) fn map(&self, access: GLenum) -> Result<*mut c_void, TestError> {
        let gl = self.context.gl();
        self.bind()?;
        // SAFETY: the buffer is bound to its own target.
        let result = unsafe { gl.map_buffer(self.target, access) };
        crate::glu::expect_no_error(gl, "MapBuffer")?;
        Ok(result)
    }

    /// `buffer::unmap`
    pub(super) fn unmap(&self) -> Result<(), TestError> {
        let gl = self.context.gl();
        self.bind()?;
        gl_call!(gl, "UnmapBuffer", gl.unmap_buffer(self.target));
        Ok(())
    }

    /// `buffer::update`
    pub(super) fn update(&self, size: glw::GLsizeiptr, data: *const c_void, usage: GLenum) -> Result<(), TestError> {
        let gl = self.context.gl();
        self.bind()?;
        gl_call!(gl, "BufferData", gl.buffer_data(self.target, size, data, usage));
        Ok(())
    }

    /// `buffer::bindRange`
    pub(super) fn bind_range(
        &self,
        index: GLuint,
        offset: glw::GLintptr,
        size: glw::GLsizeiptr,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(
            gl,
            "BindBufferRange",
            gl.bind_buffer_range(self.target, index, self.id, offset, size)
        );
        Ok(())
    }

    /// Gives the buffer name away without deleting it; `BufferStash` deletes it later.
    pub(super) fn leak(mut self) -> GLuint {
        std::mem::take(&mut self.id)
    }

    /// `buffer::release`
    pub(super) fn release(&mut self) {
        if self.id != 0 {
            // SAFETY: the name was generated by this value and is deleted once.
            unsafe { self.context.gl().delete_buffers(1, &self.id) };
            self.id = 0;
        }
    }
}

impl Drop for Buffer<'_> {
    fn drop(&mut self) {
        self.release();
    }
}

/// The buffers upstream keeps as members of a test case (generated in `prepareUniforms`, released in `releaseResource`).
#[derive(Default)]
pub(in crate::khr_gl) struct BufferStash(std::sync::Mutex<Vec<(GLuint, GLenum)>>);

impl BufferStash {
    /// `generate(target)`, `update(.., GL_STATIC_DRAW)` and `bindRange(index, 0, size)` of one member buffer.
    pub(super) fn add_bound_range<T>(
        &self,
        context: &Context,
        target: GLenum,
        index: GLuint,
        data: &[T],
    ) -> Result<(), TestError> {
        let size = std::mem::size_of_val(data) as glw::GLsizeiptr;
        let buffer = self.generate_filled(context, target, data)?;

        buffer.bind_range(index, 0, size)?;
        self.add(buffer, target);
        Ok(())
    }

    /// `generate(target)` and `update(.., GL_STATIC_DRAW)` of a member buffer that is not stashed yet.
    pub(super) fn generate_filled<'a, T>(
        &self,
        context: &'a Context,
        target: GLenum,
        data: &[T],
    ) -> Result<Buffer<'a>, TestError> {
        let mut buffer = Buffer::new(context);

        buffer.generate(target)?;
        buffer.update(
            std::mem::size_of_val(data) as glw::GLsizeiptr,
            data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        )?;
        Ok(buffer)
    }

    pub(super) fn add(&self, buffer: Buffer, target: GLenum) {
        self.0
            .lock()
            .expect("the stash is not poisoned")
            .push((buffer.leak(), target));
    }

    /// Runs `f` on member `index` as an ordinary `Utils::buffer`.
    pub(super) fn with<R>(&self, context: &Context, index: usize, f: impl FnOnce(&Buffer) -> R) -> R {
        let (id, target) = self.0.lock().expect("the stash is not poisoned")[index];
        let buffer = Buffer { context, id, target };
        let result = f(&buffer);
        buffer.leak();
        result
    }

    /// Drops the members without deleting their names (a buffer texture's release already deleted its buffer).
    pub(super) fn forget(&self) {
        self.0.lock().expect("the stash is not poisoned").clear();
    }

    /// `buffer::release` of every member
    pub(super) fn release(&self, context: &Context) {
        for (id, _) in self.0.lock().expect("the stash is not poisoned").drain(..) {
            // SAFETY: the names were generated by the stashed buffers and are deleted once.
            unsafe { context.gl().delete_buffers(1, &id) };
        }
    }
}

/// `Utils::vertexArray`
pub(in crate::khr_gl) struct VertexArray<'a> {
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

/// `Utils::framebuffer`
pub(in crate::khr_gl) struct Framebuffer<'a> {
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

/// `Utils::texture`
pub(in crate::khr_gl) struct Texture<'a> {
    context: &'a Context,
    pub(super) id: GLuint,
    buffer_id: GLuint,
    texture_type: TextureType,
}

impl<'a> Texture<'a> {
    pub(super) fn new(context: &'a Context) -> Self {
        Self {
            context,
            id: 0,
            buffer_id: 0,
            texture_type: TextureType::Tex2D,
        }
    }

    /// `texture::bind`
    pub(super) fn bind(&self) -> Result<(), TestError> {
        let gl = self.context.gl();
        gl_call!(gl, "BindTexture", gl.bind_texture(self.texture_type.target(), self.id));
        Ok(())
    }

    /// `texture::create(width, height, internal_format)`
    pub(super) fn create(&mut self, width: GLuint, height: GLuint, internal_format: GLenum) -> Result<(), TestError> {
        let gl = self.context.gl();
        self.release();
        self.texture_type = TextureType::Tex2D;
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

    /// `texture::create(width, height, depth, internal_format, texture_type)`
    pub(super) fn create_typed(
        &mut self,
        width: GLuint,
        height: GLuint,
        depth: GLuint,
        internal_format: GLenum,
        texture_type: TextureType,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();
        self.release();
        self.texture_type = texture_type;
        let target = texture_type.target();
        gl_call!(gl, "GenTextures", gl.gen_textures(1, &mut self.id));
        self.bind()?;

        match texture_type {
            TextureType::Tex1D => {
                gl_call!(
                    gl,
                    "TexStorage1D",
                    gl.tex_storage_1d(target, 1, internal_format, width as GLsizei)
                );
            }
            TextureType::Tex2D | TextureType::Tex1DArray | TextureType::Tex2DRect | TextureType::TexCube => {
                gl_call!(
                    gl,
                    "TexStorage2D",
                    gl.tex_storage_2d(target, 1, internal_format, width as GLsizei, height as GLsizei)
                );
            }
            TextureType::Tex3D | TextureType::Tex2DArray => {
                gl_call!(
                    gl,
                    "TexStorage3D",
                    gl.tex_storage_3d(
                        target,
                        1,
                        internal_format,
                        width as GLsizei,
                        height as GLsizei,
                        depth as GLsizei
                    )
                );
            }
            TextureType::TexBuffer => return fail("Invliad enum"),
        }
        Ok(())
    }

    /// `texture::createBuffer`
    pub(super) fn create_buffer(&mut self, internal_format: GLenum, buffer_id: GLuint) -> Result<(), TestError> {
        let gl = self.context.gl();
        self.release();
        self.texture_type = TextureType::TexBuffer;
        self.buffer_id = buffer_id;
        gl_call!(gl, "GenTextures", gl.gen_textures(1, &mut self.id));
        self.bind()?;
        gl_call!(
            gl,
            "TexBuffer",
            gl.tex_buffer(glw::GL_TEXTURE_BUFFER, internal_format, buffer_id)
        );
        Ok(())
    }

    /// `texture::get`
    pub(super) fn get(&self, format: GLenum, type_: GLenum, out_data: *mut c_void) -> Result<(), TestError> {
        let gl = self.context.gl();
        let target = self.texture_type.target();
        self.bind()?;
        gl_call!(
            gl,
            "MemoryBarrier",
            gl.memory_barrier(glw::GL_TEXTURE_UPDATE_BARRIER_BIT)
        );

        if self.texture_type != TextureType::TexCube {
            gl_call!(gl, "GetTexImage", gl.get_tex_image(target, 0, format, type_, out_data));
            return Ok(());
        }

        let mut width: GLint = 0;
        let mut height: GLint = 0;
        if format != glw::GL_RGBA && type_ != glw::GL_UNSIGNED_BYTE {
            return fail("Not implemented");
        }
        let texel_size = 4;
        gl_call!(
            gl,
            "GetTexLevelParameteriv",
            gl.get_tex_level_parameteriv(
                glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
                0,
                glw::GL_TEXTURE_WIDTH,
                &mut width
            )
        );
        gl_call!(
            gl,
            "GetTexLevelParameteriv",
            gl.get_tex_level_parameteriv(
                glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
                0,
                glw::GL_TEXTURE_HEIGHT,
                &mut height
            )
        );
        let image_size = width as usize * height as usize * texel_size;

        for (face, target) in Self::CUBE_FACES.iter().enumerate() {
            // SAFETY: the caller provides room for six faces of the level-0 size.
            let face_data = unsafe { out_data.cast::<u8>().add(image_size * face) }.cast::<c_void>();
            // SAFETY: the target is a cube face of the bound cube map texture.
            unsafe { gl.get_tex_image(*target, 0, format, type_, face_data) };
        }
        crate::glu::expect_no_error(gl, "GetTexImage")?;
        Ok(())
    }

    const CUBE_FACES: [GLenum; 6] = [
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
    ];

    /// Gives the texture name (and the buffer of a buffer texture) away without deleting them; `TextureStash` deletes them later.
    fn leak(mut self) -> StashedTexture {
        let buffer_id = if self.texture_type == TextureType::TexBuffer {
            std::mem::take(&mut self.buffer_id)
        } else {
            0
        };
        StashedTexture {
            id: std::mem::take(&mut self.id),
            buffer_id,
            texture_type: self.texture_type,
        }
    }

    /// `texture::release`
    pub(super) fn release(&mut self) {
        if self.id != 0 {
            let gl = self.context.gl();
            // SAFETY: the names were generated by this value and are deleted once.
            unsafe {
                gl.delete_textures(1, &self.id);
                self.id = 0;
                if self.texture_type == TextureType::TexBuffer && self.buffer_id != 0 {
                    gl.delete_buffers(1, &self.buffer_id);
                    self.buffer_id = 0;
                }
            }
        }
    }

    /// `texture::update`
    pub(super) fn update(
        &self,
        width: GLuint,
        height: GLuint,
        depth: GLuint,
        format: GLenum,
        type_: GLenum,
        data: *const c_void,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();
        let target = self.texture_type.target();
        let (width, height, depth) = (width as GLsizei, height as GLsizei, depth as GLsizei);
        self.bind()?;

        match self.texture_type {
            TextureType::Tex1D => {
                gl_call!(
                    gl,
                    "TexStorage1D",
                    gl.tex_sub_image_1d(target, 0, 0, width, format, type_, data)
                );
            }
            TextureType::Tex2D | TextureType::Tex1DArray | TextureType::Tex2DRect => {
                gl_call!(
                    gl,
                    "TexStorage2D",
                    gl.tex_sub_image_2d(target, 0, 0, 0, width, height, format, type_, data)
                );
            }
            TextureType::TexCube => {
                for face in Self::CUBE_FACES {
                    // SAFETY: the same data is uploaded to every face of the bound cube map.
                    unsafe { gl.tex_sub_image_2d(face, 0, 0, 0, width, height, format, type_, data) };
                }
                crate::glu::expect_no_error(gl, "TexStorage2D")?;
            }
            TextureType::Tex3D | TextureType::Tex2DArray => {
                gl_call!(
                    gl,
                    "TexStorage3D",
                    gl.tex_sub_image_3d(target, 0, 0, 0, 0, width, height, depth, format, type_, data)
                );
            }
            TextureType::TexBuffer => return fail("Invliad enum"),
        }
        Ok(())
    }
}

impl Drop for Texture<'_> {
    fn drop(&mut self) {
        self.release();
    }
}

#[derive(Clone, Copy)]
pub(in crate::khr_gl) struct StashedTexture {
    id: GLuint,
    buffer_id: GLuint,
    texture_type: TextureType,
}

/// The textures upstream keeps as members of a test case (created in `prepareUniforms`, released in `releaseResource`).
#[derive(Default)]
pub(in crate::khr_gl) struct TextureStash(std::sync::Mutex<Vec<StashedTexture>>);

impl TextureStash {
    pub(super) fn add(&self, texture: Texture) {
        self.0.lock().expect("the stash is not poisoned").push(texture.leak());
    }

    /// Runs `f` on member `index` as an ordinary `Utils::texture`.
    pub(super) fn with<R>(&self, context: &Context, index: usize, f: impl FnOnce(&Texture) -> R) -> R {
        let stashed = self.0.lock().expect("the stash is not poisoned")[index];
        let texture = Texture {
            context,
            id: stashed.id,
            buffer_id: stashed.buffer_id,
            texture_type: stashed.texture_type,
        };
        let result = f(&texture);
        texture.leak();
        result
    }

    /// `texture::release` of every member
    pub(super) fn release(&self, context: &Context) {
        let gl = context.gl();
        for stashed in self.0.lock().expect("the stash is not poisoned").drain(..) {
            // SAFETY: the names were generated by the stashed textures and are deleted once.
            unsafe {
                gl.delete_textures(1, &stashed.id);
                if stashed.buffer_id != 0 {
                    gl.delete_buffers(1, &stashed.buffer_id);
                }
            }
        }
    }
}

/// The shader sources `program::build` takes; an empty `parts` is a stage that is not built.
#[derive(Default)]
pub(in crate::khr_gl) struct ProgramSources<'s> {
    pub(super) compute: Option<&'s ShaderSource>,
    pub(super) fragment: Option<&'s ShaderSource>,
    pub(super) geometry: Option<&'s ShaderSource>,
    pub(super) tess_control: Option<&'s ShaderSource>,
    pub(super) tess_evaluation: Option<&'s ShaderSource>,
    pub(super) vertex: Option<&'s ShaderSource>,
}

/// `Utils::program`
pub(in crate::khr_gl) struct Program<'a> {
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

    /// `program::build`; the shader ids are stored as they are created so `Drop` deletes them on every path.
    pub(super) fn build(&mut self, sources: &ProgramSources, is_separable: bool) -> Result<BuildOutcome, TestError> {
        let gl = self.context.gl();

        let stages = [
            (sources.compute, glw::GL_COMPUTE_SHADER, 0),
            (sources.fragment, glw::GL_FRAGMENT_SHADER, 1),
            (sources.geometry, glw::GL_GEOMETRY_SHADER, 2),
            (sources.tess_control, glw::GL_TESS_CONTROL_SHADER, 3),
            (sources.tess_evaluation, glw::GL_TESS_EVALUATION_SHADER, 4),
            (sources.vertex, glw::GL_VERTEX_SHADER, 5),
        ];

        for (source, shader_type, slot) in stages {
            let Some(source) = source.filter(|source| !source.parts.is_empty()) else {
                continue;
            };
            // SAFETY: plain object creation.
            let id = unsafe { gl.create_shader(shader_type) };
            crate::glu::expect_no_error(gl, "CreateShader")?;
            *self.shader_slot(slot) = id;
            if let Some(message) = self.compile(id, source)? {
                return Ok(BuildOutcome::CompileFailed {
                    source: source.clone(),
                    message,
                });
            }
        }

        // SAFETY: plain object creation.
        self.program_object_id = unsafe { gl.create_program() };
        crate::glu::expect_no_error(gl, "CreateProgram")?;

        if is_separable {
            gl_call!(
                gl,
                "ProgramParameteri",
                gl.program_parameteri(self.program_object_id, glw::GL_PROGRAM_SEPARABLE, glw::GL_TRUE as GLint)
            );
        }

        self.link()
    }

    fn shader_slot(&mut self, slot: usize) -> &mut GLuint {
        match slot {
            0 => &mut self.compute_shader_id,
            1 => &mut self.fragment_shader_id,
            2 => &mut self.geometry_shader_id,
            3 => &mut self.tess_control_shader_id,
            4 => &mut self.tess_evaluation_shader_id,
            _ => &mut self.vertex_shader_id,
        }
    }

    /// `program::compile`; `Some(info log)` where upstream throws `shaderCompilationException`.
    fn compile(&self, shader_id: GLuint, source: &ShaderSource) -> Result<Option<String>, TestError> {
        let gl = self.context.gl();
        let mut status = glw::GL_FALSE as GLint;

        let codes: Vec<CString> = source
            .parts
            .iter()
            .map(|part| CString::new(part.code.clone()).expect("shader parts have no NUL"))
            .collect();
        let pointers: Vec<*const c_char> = codes.iter().map(|code| code.as_ptr()).collect();
        let lengths: Vec<GLint> = source.parts.iter().map(|part| part.length).collect();
        let lengths_ptr = if source.use_lengths {
            lengths.as_ptr()
        } else {
            std::ptr::null()
        };

        gl_call!(
            gl,
            "ShaderSource",
            gl.shader_source(shader_id, pointers.len() as GLsizei, pointers.as_ptr(), lengths_ptr)
        );
        gl_call!(gl, "CompileShader", gl.compile_shader(shader_id));
        gl_call!(
            gl,
            "GetShaderiv",
            gl.get_shaderiv(shader_id, glw::GL_COMPILE_STATUS, &mut status)
        );

        if status == glw::GL_TRUE as GLint {
            return Ok(None);
        }

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
        Ok(Some(info_log_text(&message)))
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

    pub(super) fn context(&self) -> &'a Context {
        self.context
    }

    /// `program::getUniform1i`
    pub(super) fn get_uniform_1i(&self, location: GLint) -> Result<GLint, TestError> {
        let gl = self.context.gl();
        let mut result: GLint = 0;
        gl_call!(
            gl,
            "GetUniformiv",
            gl.get_uniformiv(self.program_object_id, location, &mut result)
        );
        Ok(result)
    }

    /// `Utils::checkUniformBinding`
    pub(super) fn check_uniform_binding(&self, name: &str, expected_binding: GLint) -> Result<bool, TestError> {
        let location = self.get_uniform_location(name)?;
        Ok(expected_binding == self.get_uniform_1i(location)?)
    }

    /// `Utils::checkUniformArrayBinding`
    pub(super) fn check_uniform_array_binding(
        &self,
        name: &str,
        index: GLuint,
        expected_binding: GLint,
    ) -> Result<bool, TestError> {
        self.check_uniform_binding(&format!("{name}[{index}]"), expected_binding)
    }

    /// `program::getAttribLocation`
    pub(super) fn get_attrib_location(&self, name: &str) -> Result<GLint, TestError> {
        let gl = self.context.gl();
        let name = CString::new(name).expect("names have no NUL");

        // SAFETY: the name is a live NUL-terminated string.
        let location = unsafe { gl.get_attrib_location(self.program_object_id, name.as_ptr()) };
        crate::glu::expect_no_error(gl, "GetAttribLocation")?;
        Ok(location)
    }

    /// `program::link`; `LinkFailed` where upstream throws `programLinkageException`.
    fn link(&self) -> Result<BuildOutcome, TestError> {
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

        if status == glw::GL_TRUE as GLint {
            return Ok(BuildOutcome::Built);
        }

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
        Ok(BuildOutcome::LinkFailed {
            message: info_log_text(&message),
        })
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

            for slot in 0..6 {
                let shader_id = self.shader_slot(slot);
                if *shader_id != 0 {
                    gl.delete_shader(*shader_id);
                    *shader_id = 0;
                }
            }
        }
    }

    /// `program::uniform` for `Utils::FLOAT`: a vector of `n_rows` or a matrix of `n_columns` x `n_rows`.
    pub(super) fn uniform_float(
        &self,
        uniform_name: &str,
        n_columns: GLuint,
        n_rows: GLuint,
        data: &[f32],
    ) -> Result<(), TestError> {
        let gl = self.context.gl();
        let location = self.get_uniform_location(uniform_name)?;
        let value = data.as_ptr();
        let no_transpose = glw::GL_FALSE as glw::GLboolean;

        if n_columns == 1 {
            match n_rows {
                1 => gl_call!(gl, "UniformNfv", gl.uniform_1fv(location, 1, value)),
                2 => gl_call!(gl, "UniformNfv", gl.uniform_2fv(location, 1, value)),
                3 => gl_call!(gl, "UniformNfv", gl.uniform_3fv(location, 1, value)),
                4 => gl_call!(gl, "UniformNfv", gl.uniform_4fv(location, 1, value)),
                _ => return fail("Invalid number of rows"),
            }
            return Ok(());
        }

        match (n_columns, n_rows) {
            (2, 2) => gl_call!(
                gl,
                "UniformMatrixNfv",
                gl.uniform_matrix_2fv(location, 1, no_transpose, value)
            ),
            (2, 3) => gl_call!(
                gl,
                "UniformMatrixNfv",
                gl.uniform_matrix_2x_3fv(location, 1, no_transpose, value)
            ),
            (2, 4) => gl_call!(
                gl,
                "UniformMatrixNfv",
                gl.uniform_matrix_2x_4fv(location, 1, no_transpose, value)
            ),
            (3, 2) => gl_call!(
                gl,
                "UniformMatrixNfv",
                gl.uniform_matrix_3x_2fv(location, 1, no_transpose, value)
            ),
            (3, 3) => gl_call!(
                gl,
                "UniformMatrixNfv",
                gl.uniform_matrix_3fv(location, 1, no_transpose, value)
            ),
            (3, 4) => gl_call!(
                gl,
                "UniformMatrixNfv",
                gl.uniform_matrix_3x_4fv(location, 1, no_transpose, value)
            ),
            (4, 2) => gl_call!(
                gl,
                "UniformMatrixNfv",
                gl.uniform_matrix_4x_2fv(location, 1, no_transpose, value)
            ),
            (4, 3) => gl_call!(
                gl,
                "UniformMatrixNfv",
                gl.uniform_matrix_4x_3fv(location, 1, no_transpose, value)
            ),
            (4, 4) => gl_call!(
                gl,
                "UniformMatrixNfv",
                gl.uniform_matrix_4fv(location, 1, no_transpose, value)
            ),
            _ => return fail("Invalid number of columns or rows"),
        }
        Ok(())
    }

    /// `program::uniform` for `Utils::DOUBLE`
    pub(super) fn uniform_double(
        &self,
        uniform_name: &str,
        n_columns: GLuint,
        n_rows: GLuint,
        data: &[f64],
    ) -> Result<(), TestError> {
        let gl = self.context.gl();
        let location = self.get_uniform_location(uniform_name)?;
        let value = data.as_ptr();
        let no_transpose = glw::GL_FALSE as glw::GLboolean;

        if n_columns == 1 {
            match n_rows {
                1 => gl_call!(gl, "UniformNdv", gl.uniform_1dv(location, 1, value)),
                2 => gl_call!(gl, "UniformNdv", gl.uniform_2dv(location, 1, value)),
                3 => gl_call!(gl, "UniformNdv", gl.uniform_3dv(location, 1, value)),
                4 => gl_call!(gl, "UniformNdv", gl.uniform_4dv(location, 1, value)),
                _ => return fail("Invalid number of rows"),
            }
            return Ok(());
        }

        match (n_columns, n_rows) {
            (2, 2) => gl_call!(
                gl,
                "UniformMatrixNdv",
                gl.uniform_matrix_2dv(location, 1, no_transpose, value)
            ),
            (2, 3) => gl_call!(
                gl,
                "UniformMatrixNdv",
                gl.uniform_matrix_2x_3dv(location, 1, no_transpose, value)
            ),
            (2, 4) => gl_call!(
                gl,
                "UniformMatrixNdv",
                gl.uniform_matrix_2x_4dv(location, 1, no_transpose, value)
            ),
            (3, 2) => gl_call!(
                gl,
                "UniformMatrixNdv",
                gl.uniform_matrix_3x_2dv(location, 1, no_transpose, value)
            ),
            (3, 3) => gl_call!(
                gl,
                "UniformMatrixNdv",
                gl.uniform_matrix_3dv(location, 1, no_transpose, value)
            ),
            (3, 4) => gl_call!(
                gl,
                "UniformMatrixNdv",
                gl.uniform_matrix_3x_4dv(location, 1, no_transpose, value)
            ),
            (4, 2) => gl_call!(
                gl,
                "UniformMatrixNdv",
                gl.uniform_matrix_4x_2dv(location, 1, no_transpose, value)
            ),
            (4, 3) => gl_call!(
                gl,
                "UniformMatrixNdv",
                gl.uniform_matrix_4x_3dv(location, 1, no_transpose, value)
            ),
            (4, 4) => gl_call!(
                gl,
                "UniformMatrixNdv",
                gl.uniform_matrix_4dv(location, 1, no_transpose, value)
            ),
            _ => return fail("Invalid number of columns or rows"),
        }
        Ok(())
    }

    /// `program::uniform` for `Utils::INT`
    pub(super) fn uniform_int(&self, uniform_name: &str, n_rows: GLuint, data: &[GLint]) -> Result<(), TestError> {
        let gl = self.context.gl();
        let location = self.get_uniform_location(uniform_name)?;
        let value = data.as_ptr();

        match n_rows {
            1 => gl_call!(gl, "UniformNiv", gl.uniform_1iv(location, 1, value)),
            2 => gl_call!(gl, "UniformNiv", gl.uniform_2iv(location, 1, value)),
            3 => gl_call!(gl, "UniformNiv", gl.uniform_3iv(location, 1, value)),
            4 => gl_call!(gl, "UniformNiv", gl.uniform_4iv(location, 1, value)),
            _ => return fail("Invalid number of rows"),
        }
        Ok(())
    }

    /// `program::uniform` for `Utils::UINT`
    pub(super) fn uniform_uint(&self, uniform_name: &str, n_rows: GLuint, data: &[GLuint]) -> Result<(), TestError> {
        let gl = self.context.gl();
        let location = self.get_uniform_location(uniform_name)?;
        let value = data.as_ptr();

        match n_rows {
            1 => gl_call!(gl, "UniformNuiv", gl.uniform_1uiv(location, 1, value)),
            2 => gl_call!(gl, "UniformNuiv", gl.uniform_2uiv(location, 1, value)),
            3 => gl_call!(gl, "UniformNuiv", gl.uniform_3uiv(location, 1, value)),
            4 => gl_call!(gl, "UniformNuiv", gl.uniform_4uiv(location, 1, value)),
            _ => return fail("Invalid number of rows"),
        }
        Ok(())
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

fn info_log_text(message: &[u8]) -> String {
    let end = message.iter().position(|&byte| byte == 0).unwrap_or(message.len());
    String::from_utf8_lossy(&message[..end]).into_owned()
}
