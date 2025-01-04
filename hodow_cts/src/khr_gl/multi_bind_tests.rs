// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cMultiBindTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. All 17 cases are ported. `CHECK_ERROR` is `check_error!`, which fails the case (upstream's `TCU_FAIL`). The `glDebugMessageCallback(debug_proc, ..)` calls only log driver messages and are not ported. Upstream's `Buffer`/`Texture` classes are `DataBuf`/`MbTex` guards that delete their object on drop.

use super::common_bugs_tests::{Program, Shader};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::{glu, glw};

macro_rules! check_error {
    ($gl:expr, $expected_error:expr, $($message:tt)+) => {{
        // SAFETY: plain state query.
        let generated_error = unsafe { $gl.get_error() };
        if generated_error != $expected_error {
            let message = format!($($message)+);
            log::info!("Got wrong error: {}, expected: {}, message: {message}", glw::error_name(generated_error), glw::error_name($expected_error));
            return Err(TestError::Fail("Invalid error generated".to_string()));
        }
    }};
}

/// `bufferTargetInfo`
struct BufferTargetInfo {
    target: glw::GLenum,
    pname_alignment: glw::GLenum,
    pname_binding: glw::GLenum,
    pname_max: glw::GLenum,
    pname_max_size: glw::GLenum,
}

/// `s_buffer_infos`
const BUFFER_INFOS: [BufferTargetInfo; 4] = [
    BufferTargetInfo {
        target: glw::GL_ATOMIC_COUNTER_BUFFER,
        pname_alignment: 0,
        pname_binding: glw::GL_ATOMIC_COUNTER_BUFFER_BINDING,
        pname_max: glw::GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS,
        pname_max_size: glw::GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE,
    },
    BufferTargetInfo {
        target: glw::GL_TRANSFORM_FEEDBACK_BUFFER,
        pname_alignment: 0,
        pname_binding: glw::GL_TRANSFORM_FEEDBACK_BUFFER_BINDING,
        pname_max: glw::GL_MAX_TRANSFORM_FEEDBACK_BUFFERS,
        pname_max_size: glw::GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS,
    },
    BufferTargetInfo {
        target: glw::GL_UNIFORM_BUFFER,
        pname_alignment: glw::GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT,
        pname_binding: glw::GL_UNIFORM_BUFFER_BINDING,
        pname_max: glw::GL_MAX_UNIFORM_BUFFER_BINDINGS,
        pname_max_size: glw::GL_MAX_UNIFORM_BLOCK_SIZE,
    },
    BufferTargetInfo {
        target: glw::GL_SHADER_STORAGE_BUFFER,
        pname_alignment: glw::GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT,
        pname_binding: glw::GL_SHADER_STORAGE_BUFFER_BINDING,
        pname_max: glw::GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS,
        pname_max_size: glw::GL_MAX_SHADER_STORAGE_BLOCK_SIZE,
    },
];

/// `textureTargetInfo`
struct TextureTargetInfo {
    target: glw::GLenum,
    pname_binding: glw::GLenum,
    name: &'static str,
}

/// `s_texture_infos`
const TEXTURE_INFOS: [TextureTargetInfo; 11] = [
    TextureTargetInfo {
        target: glw::GL_TEXTURE_1D,
        pname_binding: glw::GL_TEXTURE_BINDING_1D,
        name: "1D",
    },
    TextureTargetInfo {
        target: glw::GL_TEXTURE_1D_ARRAY,
        pname_binding: glw::GL_TEXTURE_BINDING_1D_ARRAY,
        name: "1D_ARRAY",
    },
    TextureTargetInfo {
        target: glw::GL_TEXTURE_2D,
        pname_binding: glw::GL_TEXTURE_BINDING_2D,
        name: "2D",
    },
    TextureTargetInfo {
        target: glw::GL_TEXTURE_2D_ARRAY,
        pname_binding: glw::GL_TEXTURE_BINDING_2D_ARRAY,
        name: "2D_ARRAY",
    },
    TextureTargetInfo {
        target: glw::GL_TEXTURE_3D,
        pname_binding: glw::GL_TEXTURE_BINDING_3D,
        name: "3D",
    },
    TextureTargetInfo {
        target: glw::GL_TEXTURE_BUFFER,
        pname_binding: glw::GL_TEXTURE_BINDING_BUFFER,
        name: "BUFFER",
    },
    TextureTargetInfo {
        target: glw::GL_TEXTURE_CUBE_MAP,
        pname_binding: glw::GL_TEXTURE_BINDING_CUBE_MAP,
        name: "CUBE",
    },
    TextureTargetInfo {
        target: glw::GL_TEXTURE_CUBE_MAP_ARRAY,
        pname_binding: glw::GL_TEXTURE_BINDING_CUBE_MAP_ARRAY,
        name: "CUBE_ARRAY",
    },
    TextureTargetInfo {
        target: glw::GL_TEXTURE_RECTANGLE,
        pname_binding: glw::GL_TEXTURE_BINDING_RECTANGLE,
        name: "RECTANGLE",
    },
    TextureTargetInfo {
        target: glw::GL_TEXTURE_2D_MULTISAMPLE,
        pname_binding: glw::GL_TEXTURE_BINDING_2D_MULTISAMPLE,
        name: "2D_MS",
    },
    TextureTargetInfo {
        target: glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
        pname_binding: glw::GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY,
        name: "2D_MS_ARRAY",
    },
];

/// `checkBinding`
fn check_binding(
    gl: &glw::Functions,
    pname: glw::GLenum,
    index: glw::GLuint,
    target_name: &str,
    expected_value: glw::GLint,
) -> Result<(), TestError> {
    let mut binding: glw::GLint = -1;
    // SAFETY: the value is written to a live local.
    unsafe { gl.get_integeri_v(pname, index, &mut binding) };
    glu::expect_no_error(gl, "GetIntegeri_v")?;

    if binding != expected_value {
        log::info!("Invalid binding: {binding}, expected: {expected_value}. Target: {target_name} at index: {index}");
        return Err(TestError::Fail("Invalid binding".to_string()));
    }
    Ok(())
}

/// `checkTextureBinding`
fn check_texture_binding(
    gl: &glw::Functions,
    pname: glw::GLenum,
    index: glw::GLuint,
    expected_value: glw::GLint,
) -> Result<(), TestError> {
    for info in &TEXTURE_INFOS {
        let mut binding: glw::GLint = -1;
        // SAFETY: the value is written to a live local.
        unsafe { gl.get_integeri_v(info.pname_binding, index, &mut binding) };
        glu::expect_no_error(gl, "GetIntegeri_v")?;

        let value = if info.pname_binding == pname { expected_value } else { 0 };
        if binding != value {
            log::info!(
                "Invalid binding: {binding}, expected: {expected_value}. Target: {} at index: {index}",
                info.name
            );
            return Err(TestError::Fail("Invalid binding".to_string()));
        }
    }
    Ok(())
}

/// `getBinding`
fn get_binding(index: usize) -> glw::GLenum {
    TEXTURE_INFOS
        .get(index)
        .map_or(glw::GL_TEXTURE_BINDING_2D, |info| info.pname_binding)
}

fn buffer_target_name(target: glw::GLenum) -> &'static str {
    match target {
        glw::GL_ATOMIC_COUNTER_BUFFER => "GL_ATOMIC_COUNTER_BUFFER",
        glw::GL_TRANSFORM_FEEDBACK_BUFFER => "GL_TRANSFORM_FEEDBACK_BUFFER",
        glw::GL_UNIFORM_BUFFER => "GL_UNIFORM_BUFFER",
        glw::GL_SHADER_STORAGE_BUFFER => "GL_SHADER_STORAGE_BUFFER",
        _ => "unknown target",
    }
}

/// `Buffer` after `Buffer::InitData`
struct DataBuf<'gl> {
    gl: &'gl glw::Functions,
    id: glw::GLuint,
}

impl<'gl> DataBuf<'gl> {
    fn init_data(
        gl: &'gl glw::Functions,
        target: glw::GLenum,
        usage: glw::GLenum,
        size: glw::GLsizeiptr,
    ) -> Result<Self, TestError> {
        Self::init_data_from(gl, target, usage, size, std::ptr::null())
    }

    /// `Buffer::InitData` with initial `data` (null or `size` bytes)
    fn init_data_from(
        gl: &'gl glw::Functions,
        target: glw::GLenum,
        usage: glw::GLenum,
        size: glw::GLsizeiptr,
        data: *const std::ffi::c_void,
    ) -> Result<Self, TestError> {
        let mut id = 0;
        // SAFETY: one name is written to the live local.
        unsafe { gl.gen_buffers(1, &mut id) };
        glu::expect_no_error(gl, "GenBuffers")?;
        let buffer = Self { gl, id };
        // SAFETY: a buffer generated above; no initial data.
        unsafe {
            gl.bind_buffer(target, id);
            glu::expect_no_error(gl, "BindBuffer")?;
            gl.buffer_data(target, size, data, usage);
        }
        glu::expect_no_error(gl, "BufferData")?;
        Ok(buffer)
    }
}

impl Drop for DataBuf<'_> {
    fn drop(&mut self) {
        // SAFETY: deletes the name this guard owns.
        unsafe { self.gl.delete_buffers(1, &self.id) };
    }
}

/// `Texture` after `Texture::InitStorage`
struct MbTex<'gl> {
    gl: &'gl glw::Functions,
    id: glw::GLuint,
}

impl<'gl> MbTex<'gl> {
    /// `Texture::Init` + `Texture::Generate` + `Texture::Bind`
    fn generate_bound(gl: &'gl glw::Functions, target: glw::GLenum) -> Result<Self, TestError> {
        let mut id = 0;
        // SAFETY: one name is written to the live local.
        unsafe { gl.gen_textures(1, &mut id) };
        glu::expect_no_error(gl, "GenTextures")?;
        let texture = Self { gl, id };
        // SAFETY: a texture name generated above.
        unsafe { gl.bind_texture(target, id) };
        glu::expect_no_error(gl, "BindTexture")?;
        Ok(texture)
    }

    /// `Texture::InitStorage` with `Texture::Storage`
    fn init_storage(
        gl: &'gl glw::Functions,
        target: glw::GLenum,
        levels: glw::GLsizei,
        internal_format: glw::GLenum,
        width: glw::GLuint,
        height: glw::GLuint,
        depth: glw::GLuint,
        allow_error: bool,
    ) -> Result<Self, TestError> {
        let texture = Self::generate_bound(gl, target)?;
        let (width, height, depth) = (width as glw::GLsizei, height as glw::GLsizei, depth as glw::GLsizei);

        // SAFETY: storage specification of the texture bound above.
        let name = unsafe {
            match target {
                glw::GL_TEXTURE_1D => {
                    gl.tex_storage_1d(target, levels, internal_format, width);
                    "TexStorage1D"
                }
                glw::GL_TEXTURE_1D_ARRAY
                | glw::GL_TEXTURE_2D
                | glw::GL_TEXTURE_RECTANGLE
                | glw::GL_TEXTURE_CUBE_MAP => {
                    gl.tex_storage_2d(target, levels, internal_format, width, height);
                    "TexStorage2D"
                }
                glw::GL_TEXTURE_2D_MULTISAMPLE => {
                    gl.tex_storage_2d_multisample(
                        target,
                        levels,
                        internal_format,
                        width,
                        height,
                        glw::GL_FALSE as glw::GLboolean,
                    );
                    "TexStorage2DMultisample"
                }
                glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => {
                    gl.tex_storage_3d_multisample(
                        target,
                        levels,
                        internal_format,
                        width,
                        height,
                        depth,
                        glw::GL_FALSE as glw::GLboolean,
                    );
                    "TexStorage3DMultisample"
                }
                glw::GL_TEXTURE_3D | glw::GL_TEXTURE_2D_ARRAY | glw::GL_TEXTURE_CUBE_MAP_ARRAY => {
                    gl.tex_storage_3d(target, levels, internal_format, width, height, depth);
                    "TexStorage3D"
                }
                _ => return Err(TestError::Fail("Invliad enum".to_string())),
            }
        };
        if !allow_error {
            glu::expect_no_error(gl, name)?;
        }
        Ok(texture)
    }
}

impl Drop for MbTex<'_> {
    fn drop(&mut self) {
        // SAFETY: deletes the name this guard owns.
        unsafe { self.gl.delete_textures(1, &self.id) };
    }
}

/// `Buffer::Bind(gl, id, target)`
fn bind(gl: &glw::Functions, id: glw::GLuint, target: glw::GLenum) -> Result<(), TestError> {
    // SAFETY: plain state change.
    unsafe { gl.bind_buffer(target, id) };
    glu::expect_no_error(gl, "BindBuffer")
}

/// Searches for a name `pred` reports as unused, starting at 1 (0 is not a valid name).
fn find_invalid_id(is_name: impl Fn(glw::GLuint) -> bool) -> glw::GLuint {
    let mut invalid_id = 1;
    while is_name(invalid_id) {
        invalid_id += 1;
    }
    invalid_id
}

/// The `first`/`count` pair that makes `first + count` exceed `max` for `n` bound objects, avoiding a negative `first`.
fn exceeding_range(n: glw::GLsizei, max: glw::GLint) -> (glw::GLuint, glw::GLsizei) {
    if n <= max {
        ((max - n + 1) as glw::GLuint, n)
    } else {
        (0, max + 1)
    }
}

/// The `count` and `validated_index` that keep `first + count` within `max`.
fn clamped_range(n: glw::GLsizei, max: glw::GLint) -> (glw::GLsizei, usize) {
    if n > max {
        (max, (max - 1) as usize)
    } else {
        (n, (n - 1) as usize)
    }
}

fn pass() -> TestOutcome {
    Ok(TestStatus::pass("Pass"))
}

/// `ErrorsBindBuffersTest`
struct ErrorsBindBuffersTest;

impl TestCase for ErrorsBindBuffersTest {
    fn name(&self) -> &str {
        "errors_bind_buffers"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        // INVALID_ENUM when <target> is not valid.
        {
            const BUFFER_SIZE: glw::GLintptr = 16;
            const COUNT: glw::GLsizei = 1;
            const FIRST: glw::GLuint = 0;
            let offset: glw::GLintptr = 4;
            let size: glw::GLsizeiptr = BUFFER_SIZE - offset;
            let buffer = DataBuf::init_data(gl, glw::GL_ARRAY_BUFFER, glw::GL_DYNAMIC_COPY, BUFFER_SIZE)?;

            // SAFETY: one buffer name, one offset and one size are passed for COUNT == 1.
            unsafe { gl.bind_buffers_base(glw::GL_ARRAY_BUFFER, FIRST, COUNT, &buffer.id) };
            check_error!(gl, glw::GL_INVALID_ENUM, "BindBuffersBase with invalid <target>");
            // SAFETY: as above.
            unsafe { gl.bind_buffers_range(glw::GL_ARRAY_BUFFER, FIRST, COUNT, &buffer.id, &offset, &size) };
            check_error!(gl, glw::GL_INVALID_ENUM, "BindBuffersRange with invalid <target>");
        }

        for info in &BUFFER_INFOS {
            const N_BUFFERS: usize = 4;
            let target = info.target;
            let target_name = buffer_target_name(target);
            let mut buffer_size: glw::GLintptr = 16;
            let first: glw::GLuint = 0;
            let mut offset: glw::GLintptr = 4; // ATOMIC and XFB require alignment of 4
            let mut offset_alignment: glw::GLint = 1;
            let mut max_buffers: glw::GLint = 0;
            let mut size: glw::GLsizeiptr = buffer_size - offset;

            if info.pname_alignment != 0 {
                // SAFETY: the value is written to a live local.
                unsafe { gl.get_integerv(info.pname_alignment, &mut offset_alignment) };
                glu::expect_no_error(gl, "GetIntegerv")?;
                buffer_size += offset_alignment as glw::GLintptr;
                offset = offset_alignment as glw::GLintptr;
                size = buffer_size - offset;
            }

            // SAFETY: the value is written to a live local.
            unsafe { gl.get_integerv(info.pname_max, &mut max_buffers) };
            glu::expect_no_error(gl, "GetIntegerv")?;

            let (count, validated_index) = clamped_range(N_BUFFERS as glw::GLsizei, max_buffers);

            let mut buffers = Vec::new();
            let mut buffer_ids = [0 as glw::GLuint; N_BUFFERS];
            let offsets = [offset; N_BUFFERS];
            let sizes = [size; N_BUFFERS];
            for buffer_id in &mut buffer_ids {
                let buffer = DataBuf::init_data(gl, target, glw::GL_DYNAMIC_COPY, buffer_size)?;
                *buffer_id = buffer.id;
                buffers.push(buffer);
            }

            // INVALID_OPERATION when <first> + <count> is greater than allowed limit.
            {
                let (t_first, t_count) = exceeding_range(N_BUFFERS as glw::GLsizei, max_buffers);

                // SAFETY: the arrays hold N_BUFFERS entries; the call is expected to fail validation.
                unsafe { gl.bind_buffers_base(target, t_first, t_count, buffer_ids.as_ptr()) };
                check_error!(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "BindBuffersBase with invalid <first> + <count>, target: {target_name}"
                );
                // SAFETY: as above.
                unsafe {
                    gl.bind_buffers_range(
                        target,
                        t_first,
                        t_count,
                        buffer_ids.as_ptr(),
                        offsets.as_ptr(),
                        sizes.as_ptr(),
                    )
                };
                check_error!(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "BindBuffersRange with invalid <first> + <count>, target: {target_name}"
                );
            }

            // INVALID_OPERATION if any value in <buffers> is not zero or the name of existing buffer.
            {
                let mut t_buffer_ids = buffer_ids;
                // SAFETY: plain query.
                t_buffer_ids[validated_index] =
                    find_invalid_id(|id| unsafe { gl.is_buffer(id) } == glw::GL_TRUE as glw::GLboolean);

                // SAFETY: the arrays hold N_BUFFERS entries; the call is expected to fail validation.
                unsafe { gl.bind_buffers_base(target, first, count, t_buffer_ids.as_ptr()) };
                check_error!(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "BindBuffersBase with invalid buffer id, target: {target_name}"
                );
                // SAFETY: as above.
                unsafe {
                    gl.bind_buffers_range(
                        target,
                        first,
                        count,
                        t_buffer_ids.as_ptr(),
                        offsets.as_ptr(),
                        sizes.as_ptr(),
                    )
                };
                check_error!(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "BindBuffersRange with invalid buffer id, target: {target_name}"
                );
            }

            // INVALID_VALUE if any value in <offsets> is less than zero.
            {
                let mut t_offsets = offsets;
                let mut t_sizes = sizes;
                t_offsets[validated_index] = -1;
                t_sizes[validated_index] = -1;

                // SAFETY: the arrays hold N_BUFFERS entries; the call is expected to fail validation.
                unsafe {
                    gl.bind_buffers_range(
                        target,
                        first,
                        count,
                        buffer_ids.as_ptr(),
                        t_offsets.as_ptr(),
                        sizes.as_ptr(),
                    )
                };
                check_error!(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "BindBuffersRange with negative offset, target: {target_name}"
                );
                // SAFETY: as above.
                unsafe {
                    gl.bind_buffers_range(
                        target,
                        first,
                        count,
                        buffer_ids.as_ptr(),
                        offsets.as_ptr(),
                        t_sizes.as_ptr(),
                    )
                };
                check_error!(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "BindBuffersRange with negative size, target: {target_name}"
                );
            }

            // INVALID_VALUE if any pair of <offsets> and <sizes> exceeds limits.
            {
                let mut t_offsets = offsets;
                let mut t_sizes = sizes;
                t_offsets[validated_index] -= 1; // not aligned by required value
                t_sizes[validated_index] = size - 1; // not aligned by required value

                // SAFETY: the arrays hold N_BUFFERS entries; the call is expected to fail validation.
                unsafe {
                    gl.bind_buffers_range(
                        target,
                        first,
                        count,
                        buffer_ids.as_ptr(),
                        t_offsets.as_ptr(),
                        sizes.as_ptr(),
                    )
                };
                check_error!(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "BindBuffersRange with invalid <offset>, target: {target_name}"
                );
                if target == glw::GL_TRANSFORM_FEEDBACK_BUFFER {
                    // SAFETY: as above.
                    unsafe {
                        gl.bind_buffers_range(
                            target,
                            first,
                            count,
                            buffer_ids.as_ptr(),
                            offsets.as_ptr(),
                            t_sizes.as_ptr(),
                        )
                    };
                    check_error!(
                        gl,
                        glw::GL_INVALID_VALUE,
                        "BindBuffersRange with invalid <size>, target: {target_name}"
                    );
                }
            }
        }

        pass()
    }
}

/// The four textures `ErrorsBindTexturesTest` and `ErrorsBindImageTexturesTest` bind: 2D, 2D array, 1D array and 3D.
fn four_textures(gl: &glw::Functions) -> Result<[MbTex<'_>; 4], TestError> {
    const DEPTH: glw::GLuint = 8;
    const HEIGHT: glw::GLuint = 8;
    const WIDTH: glw::GLuint = 8;
    Ok([
        MbTex::init_storage(gl, glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, WIDTH, HEIGHT, DEPTH, false)?,
        MbTex::init_storage(
            gl,
            glw::GL_TEXTURE_2D_ARRAY,
            1,
            glw::GL_RGBA8,
            WIDTH,
            HEIGHT,
            DEPTH,
            false,
        )?,
        MbTex::init_storage(
            gl,
            glw::GL_TEXTURE_1D_ARRAY,
            1,
            glw::GL_RGBA8,
            WIDTH,
            HEIGHT,
            DEPTH,
            false,
        )?,
        MbTex::init_storage(gl, glw::GL_TEXTURE_3D, 1, glw::GL_RGBA8, WIDTH, HEIGHT, DEPTH, false)?,
    ])
}

/// `ErrorsBindTexturesTest`
struct ErrorsBindTexturesTest;

impl TestCase for ErrorsBindTexturesTest {
    fn name(&self) -> &str {
        "errors_bind_textures"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const N_TEXTURES: usize = 4;
        let gl = context.gl();
        let first: glw::GLuint = 0;
        let mut max_textures: glw::GLint = 0;

        // SAFETY: the value is written to a live local.
        unsafe { gl.get_integerv(glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS, &mut max_textures) };
        glu::expect_no_error(gl, "GetIntegerv")?;

        let (count, validated_index) = clamped_range(N_TEXTURES as glw::GLsizei, max_textures);

        let textures = four_textures(gl)?;
        let texture_ids = textures.each_ref().map(|texture| texture.id);

        // INVALID_OPERATION when <first> + <count> exceed limits.
        {
            let (t_first, t_count) = exceeding_range(N_TEXTURES as glw::GLsizei, max_textures);

            // SAFETY: the array holds N_TEXTURES entries; the call is expected to fail validation.
            unsafe { gl.bind_textures(t_first, t_count, texture_ids.as_ptr()) };
            check_error!(
                gl,
                glw::GL_INVALID_OPERATION,
                "BindTextures with invalid <first> + <count>"
            );
        }

        // INVALID_OPERATION if any value in <textures> is not zero or the name of an existing texture.
        {
            let mut t_texture_ids = texture_ids;
            // SAFETY: plain query.
            t_texture_ids[validated_index] =
                find_invalid_id(|id| unsafe { gl.is_texture(id) } == glw::GL_TRUE as glw::GLboolean);

            // SAFETY: as above.
            unsafe { gl.bind_textures(first, count, t_texture_ids.as_ptr()) };
            check_error!(gl, glw::GL_INVALID_OPERATION, "BindTextures with invalid texture id");
        }

        pass()
    }
}

/// `ErrorsBindSamplersTest`
struct ErrorsBindSamplersTest;

impl TestCase for ErrorsBindSamplersTest {
    fn name(&self) -> &str {
        "errors_bind_samplers"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const N_SAMPLERS: usize = 4;
        let gl = context.gl();
        let first: glw::GLuint = 0;
        let mut max_samplers: glw::GLint = 0;

        // SAFETY: the value is written to a live local.
        unsafe { gl.get_integerv(glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS, &mut max_samplers) };
        glu::expect_no_error(gl, "GetIntegerv")?;

        let (count, validated_index) = clamped_range(N_SAMPLERS as glw::GLsizei, max_samplers);

        struct Samplers<'gl> {
            gl: &'gl glw::Functions,
            ids: [glw::GLuint; N_SAMPLERS],
        }
        impl Drop for Samplers<'_> {
            fn drop(&mut self) {
                // SAFETY: deletes the names this guard generated.
                unsafe { self.gl.delete_samplers(N_SAMPLERS as glw::GLsizei, self.ids.as_ptr()) };
            }
        }

        let mut samplers = Samplers {
            gl,
            ids: [0; N_SAMPLERS],
        };
        // SAFETY: N_SAMPLERS names are written to the live array.
        unsafe { gl.gen_samplers(N_SAMPLERS as glw::GLsizei, samplers.ids.as_mut_ptr()) };
        glu::expect_no_error(gl, "GenSamplers")?;

        // INVALID_OPERATION when <first> + <count> exceed limits.
        {
            let (t_first, t_count) = exceeding_range(N_SAMPLERS as glw::GLsizei, max_samplers);

            // SAFETY: the array holds N_SAMPLERS entries; the call is expected to fail validation.
            unsafe { gl.bind_samplers(t_first, t_count, samplers.ids.as_ptr()) };
            check_error!(
                gl,
                glw::GL_INVALID_OPERATION,
                "BindSamplers with invalid <first> + <count>"
            );
        }

        // INVALID_OPERATION if any value in <samplers> is not zero or the name of an existing sampler; upstream looks the name up with glIsTexture and calls glBindTextures.
        {
            let mut t_sampler_ids = samplers.ids;
            // SAFETY: plain query.
            t_sampler_ids[validated_index] =
                find_invalid_id(|id| unsafe { gl.is_texture(id) } == glw::GL_TRUE as glw::GLboolean);

            // SAFETY: as above.
            unsafe { gl.bind_textures(first, count, t_sampler_ids.as_ptr()) };
            check_error!(gl, glw::GL_INVALID_OPERATION, "BindSamplers with invalid sampler id");
        }

        pass()
    }
}

/// `ErrorsBindImageTexturesTest`
struct ErrorsBindImageTexturesTest;

impl TestCase for ErrorsBindImageTexturesTest {
    fn name(&self) -> &str {
        "errors_bind_image_textures"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const N_TEXTURES: usize = 4;
        const DEPTH: glw::GLuint = 8;
        const WIDTH: glw::GLuint = 8;
        let gl = context.gl();
        let first: glw::GLuint = 0;
        let mut max_textures: glw::GLint = 0;

        // SAFETY: the value is written to a live local.
        unsafe { gl.get_integerv(glw::GL_MAX_IMAGE_UNITS, &mut max_textures) };
        glu::expect_no_error(gl, "GetIntegerv")?;

        let (count, validated_index) = clamped_range(N_TEXTURES as glw::GLsizei, max_textures);

        let textures = four_textures(gl)?;
        let texture_ids = textures.each_ref().map(|texture| texture.id);

        // INVALID_OPERATION when <first> + <count> exceed limits.
        {
            let (t_first, t_count) = exceeding_range(N_TEXTURES as glw::GLsizei, max_textures);

            // SAFETY: the array holds N_TEXTURES entries; the call is expected to fail validation.
            unsafe { gl.bind_image_textures(t_first, t_count, texture_ids.as_ptr()) };
            check_error!(
                gl,
                glw::GL_INVALID_OPERATION,
                "BindImageTextures with invalid <first> + <count>"
            );
        }

        // INVALID_OPERATION if any value in <textures> is not zero or the name of an existing texture.
        {
            let mut t_texture_ids = texture_ids;
            // SAFETY: plain query.
            t_texture_ids[validated_index] =
                find_invalid_id(|id| unsafe { gl.is_texture(id) } == glw::GL_TRUE as glw::GLboolean);

            // SAFETY: as above.
            unsafe { gl.bind_image_textures(first, count, t_texture_ids.as_ptr()) };
            check_error!(
                gl,
                glw::GL_INVALID_OPERATION,
                "BindImageTextures with invalid texture id"
            );
        }

        // INVALID_OPERATION if any entry found in <textures> has invalid internal format at level 0.
        {
            let mut t_texture_ids = texture_ids;

            let t_texture = MbTex::generate_bound(gl, glw::GL_TEXTURE_2D)?;
            // SAFETY: a zero height is the error this call is expected to generate.
            unsafe { gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGB9_E5, WIDTH as glw::GLsizei, 0) };
            check_error!(gl, glw::GL_INVALID_VALUE, "texStorage2D has height set to 0");

            t_texture_ids[validated_index] = t_texture.id;

            // SAFETY: the array holds N_TEXTURES entries; the call is expected to fail validation.
            unsafe { gl.bind_image_textures(first, count, t_texture_ids.as_ptr()) };
            check_error!(
                gl,
                glw::GL_INVALID_OPERATION,
                "BindImageTextures with invalid internal format"
            );
        }

        // INVALID_VALUE when any entry in <textures> has any of dimensions equal to 0 at level 0.
        {
            let mut t_texture_ids = texture_ids;

            // The error of this storage call is left pending, as upstream's `allow_error` does.
            let t_texture = MbTex::init_storage(gl, glw::GL_TEXTURE_2D, 1, glw::GL_RGB9_E5, WIDTH, 0, DEPTH, true)?;
            t_texture_ids[validated_index] = t_texture.id;

            // SAFETY: the array holds N_TEXTURES entries; the call is expected to fail validation.
            unsafe { gl.bind_image_textures(first, count, t_texture_ids.as_ptr()) };
            check_error!(
                gl,
                glw::GL_INVALID_VALUE,
                "BindImageTextures with 2D texture that has height set to 0"
            );
        }

        pass()
    }
}

/// `ErrorsBindVertexBuffersTest`
struct ErrorsBindVertexBuffersTest;

impl TestCase for ErrorsBindVertexBuffersTest {
    fn name(&self) -> &str {
        "errors_bind_vertex_buffers"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const N_BUFFERS: usize = 4;
        const STRIDE: glw::GLsizei = 4;
        let gl = context.gl();
        let buffer_size: glw::GLintptr = 16;
        let first: glw::GLuint = 0;
        let offset: glw::GLintptr = 4;
        let mut max_buffers: glw::GLint = 0;

        // SAFETY: the value is written to a live local.
        unsafe { gl.get_integerv(glw::GL_MAX_VERTEX_ATTRIB_BINDINGS, &mut max_buffers) };
        glu::expect_no_error(gl, "GetIntegerv")?;

        let (count, validated_index) = clamped_range(N_BUFFERS as glw::GLsizei, max_buffers);

        let mut buffers = Vec::new();
        let mut buffer_ids = [0 as glw::GLuint; N_BUFFERS];
        let offsets = [offset; N_BUFFERS];
        let strides = [STRIDE; N_BUFFERS];
        for buffer_id in &mut buffer_ids {
            let buffer = DataBuf::init_data(gl, glw::GL_ARRAY_BUFFER, glw::GL_DYNAMIC_COPY, buffer_size)?;
            *buffer_id = buffer.id;
            buffers.push(buffer);
        }

        struct Vao<'gl> {
            gl: &'gl glw::Functions,
            id: glw::GLuint,
        }
        impl Drop for Vao<'_> {
            fn drop(&mut self) {
                // SAFETY: deletes the name this guard generated.
                unsafe { self.gl.delete_vertex_arrays(1, &self.id) };
            }
        }

        let mut vao = Vao { gl, id: 0 };
        // SAFETY: one name is written to the live field.
        unsafe { gl.gen_vertex_arrays(1, &mut vao.id) };
        glu::expect_no_error(gl, "GenVertexArrays")?;

        // SAFETY: the vertex array was generated above.
        unsafe { gl.bind_vertex_array(vao.id) };
        glu::expect_no_error(gl, "BindVertexArrays")?;

        // INVALID_OPERATION when <first> + <count> exceeds limits.
        {
            let (t_first, t_count) = exceeding_range(N_BUFFERS as glw::GLsizei, max_buffers);

            // SAFETY: the arrays hold N_BUFFERS entries; the call is expected to fail validation.
            unsafe {
                gl.bind_vertex_buffers(
                    t_first,
                    t_count,
                    buffer_ids.as_ptr(),
                    offsets.as_ptr(),
                    strides.as_ptr(),
                )
            };
            check_error!(
                gl,
                glw::GL_INVALID_OPERATION,
                "BindVertexBuffers with invalid <first> + <count>"
            );
        }

        // INVALID_OPERATION if any value in <buffers> is not zero or the name of an existing buffer.
        {
            let mut t_buffer_ids = buffer_ids;
            // SAFETY: plain query.
            t_buffer_ids[validated_index] =
                find_invalid_id(|id| unsafe { gl.is_buffer(id) } == glw::GL_TRUE as glw::GLboolean);

            // SAFETY: as above.
            unsafe { gl.bind_vertex_buffers(first, count, t_buffer_ids.as_ptr(), offsets.as_ptr(), strides.as_ptr()) };
            check_error!(
                gl,
                glw::GL_INVALID_OPERATION,
                "BindVertexBuffers with invalid buffer id"
            );
        }

        // INVALID_VALUE if any value in <offsets> or <strides> is less than zero.
        {
            let mut t_offsets = offsets;
            let mut t_strides = strides;
            t_offsets[validated_index] = -1;
            t_strides[validated_index] = -1;

            // SAFETY: the arrays hold N_BUFFERS entries; the call is expected to fail validation.
            unsafe { gl.bind_vertex_buffers(first, count, buffer_ids.as_ptr(), t_offsets.as_ptr(), strides.as_ptr()) };
            check_error!(gl, glw::GL_INVALID_VALUE, "BindVertexBuffers with negative offset");
            // SAFETY: as above.
            unsafe { gl.bind_vertex_buffers(first, count, buffer_ids.as_ptr(), offsets.as_ptr(), t_strides.as_ptr()) };
            check_error!(gl, glw::GL_INVALID_VALUE, "BindVertexBuffers with negative stride");
        }

        drop(vao);
        glu::expect_no_error(gl, "DeleteVertexArrays")?;

        pass()
    }
}

/// `FunctionalBindBuffersBaseTest` and `FunctionalBindBuffersRangeTest`, which differ only in the entry point and the offsets/sizes it takes.
fn functional_bind_buffers(context: &Context, range: bool) -> TestOutcome {
    let gl = context.gl();
    let what = if range { "BindBuffersRange" } else { "BindBuffersBase" };

    // Every call is made with `buffers` of `max_buffers` entries (or null) and, for the range variant, `offsets`/`sizes` of as many.
    let bind_buffers = |target: glw::GLenum,
                        first: glw::GLuint,
                        count: glw::GLsizei,
                        buffers: Option<&[glw::GLuint]>,
                        offsets: &[glw::GLintptr],
                        sizes: &[glw::GLsizeiptr]| {
        let buffers = buffers.map_or(std::ptr::null(), |buffers| buffers.as_ptr());
        // SAFETY: see above; a null `buffers` unbinds.
        unsafe {
            if range {
                gl.bind_buffers_range(target, first, count, buffers, offsets.as_ptr(), sizes.as_ptr());
            } else {
                gl.bind_buffers_base(target, first, count, buffers);
            }
        }
    };

    for info in &BUFFER_INFOS {
        let target = info.target;
        let target_name = buffer_target_name(target);
        let mut max_buffers: glw::GLint = 0;
        let mut max_size: glw::GLint = 0;

        // SAFETY: the values are written to live locals.
        unsafe { gl.get_integerv(info.pname_max, &mut max_buffers) };
        glu::expect_no_error(gl, "GetIntegerv")?;
        // SAFETY: as above.
        unsafe { gl.get_integerv(info.pname_max_size, &mut max_size) };
        glu::expect_no_error(gl, "GetIntegerv")?;

        let buffer_size = (max_size / max_buffers) as glw::GLintptr;
        let n = max_buffers as usize;

        let mut buffers = Vec::with_capacity(n);
        let mut buffer_ids = vec![0 as glw::GLuint; n];
        let offsets = vec![0 as glw::GLintptr; n];
        let sizes = vec![buffer_size; n];
        for buffer_id in &mut buffer_ids {
            let buffer = DataBuf::init_data(gl, target, glw::GL_DYNAMIC_COPY, buffer_size)?;
            *buffer_id = buffer.id;
            buffers.push(buffer);
        }

        // Bind all buffers to the tested target and inspect the bindings.
        bind_buffers(target, 0, max_buffers, Some(&buffer_ids), &offsets, &sizes);
        glu::expect_no_error(gl, what)?;
        for (j, buffer_id) in buffer_ids.iter().enumerate() {
            check_binding(
                gl,
                info.pname_binding,
                j as glw::GLuint,
                target_name,
                *buffer_id as glw::GLint,
            )?;
        }

        // Unbind the first half, then the rest, with null as <buffers>.
        let half_index = max_buffers / 2;
        bind_buffers(target, 0, half_index, None, &offsets, &sizes);
        glu::expect_no_error(gl, what)?;
        for j in 0..half_index {
            check_binding(gl, info.pname_binding, j as glw::GLuint, target_name, 0)?;
        }
        for j in half_index..max_buffers {
            check_binding(
                gl,
                info.pname_binding,
                j as glw::GLuint,
                target_name,
                buffer_ids[j as usize] as glw::GLint,
            )?;
        }
        bind_buffers(
            target,
            half_index as glw::GLuint,
            max_buffers - half_index,
            None,
            &offsets,
            &sizes,
        );
        glu::expect_no_error(gl, what)?;
        for j in 0..max_buffers {
            check_binding(gl, info.pname_binding, j as glw::GLuint, target_name, 0)?;
        }

        // A first entry that is not a buffer name generates INVALID_OPERATION and leaves that binding alone.
        let invalid_id = find_invalid_id(|id| {
            // SAFETY: plain query.
            unsafe { gl.is_buffer(id) == glw::GL_TRUE as glw::GLboolean }
        });
        buffer_ids[0] = invalid_id;
        bind_buffers(target, 0, max_buffers, Some(&buffer_ids), &offsets, &sizes);
        check_error!(gl, glw::GL_INVALID_OPERATION, "{what} with invalid buffer id");

        buffer_ids[0] = 0;
        for (j, buffer_id) in buffer_ids.iter().enumerate() {
            check_binding(
                gl,
                info.pname_binding,
                j as glw::GLuint,
                target_name,
                *buffer_id as glw::GLint,
            )?;
        }

        // Bind a buffer to the first binding, then unbind it with a zero in <buffers>.
        // SAFETY: a live buffer name.
        unsafe { gl.bind_buffer_base(target, 0, buffers[0].id) };
        glu::expect_no_error(gl, "BindBufferBase")?;
        check_binding(gl, info.pname_binding, 0, target_name, buffers[0].id as glw::GLint)?;

        let t_buffer_ids = vec![0 as glw::GLuint; n];
        bind_buffers(target, 0, 1, Some(&t_buffer_ids), &offsets, &sizes);
        glu::expect_no_error(gl, what)?;
        for (j, buffer_id) in buffer_ids.iter().enumerate() {
            check_binding(
                gl,
                info.pname_binding,
                j as glw::GLuint,
                target_name,
                *buffer_id as glw::GLint,
            )?;
        }

        // Unbind all buffers.
        // SAFETY: a null <buffers> unbinds.
        unsafe { gl.bind_buffers_base(target, 0, max_buffers, std::ptr::null()) };
    }

    pass()
}

/// `FunctionalBindBuffersBaseTest`
struct FunctionalBindBuffersBaseTest;

impl TestCase for FunctionalBindBuffersBaseTest {
    fn name(&self) -> &str {
        "functional_bind_buffers_base"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        functional_bind_buffers(context, false)
    }
}

/// `FunctionalBindBuffersRangeTest`
struct FunctionalBindBuffersRangeTest;

impl TestCase for FunctionalBindBuffersRangeTest {
    fn name(&self) -> &str {
        "functional_bind_buffers_range"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        functional_bind_buffers(context, true)
    }
}

/// `FunctionalBindTexturesTest`
struct FunctionalBindTexturesTest;

impl TestCase for FunctionalBindTexturesTest {
    fn name(&self) -> &str {
        "functional_bind_textures"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const DEPTH: glw::GLuint = 6;
        const HEIGHT: glw::GLuint = 6;
        const WIDTH: glw::GLuint = 6;
        let gl = context.gl();
        let mut max_textures: glw::GLint = 0;

        // SAFETY: the value is written to a live local.
        unsafe { gl.get_integerv(glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS, &mut max_textures) };
        glu::expect_no_error(gl, "GetIntegerv")?;
        let n = max_textures as usize;

        let buffer = DataBuf::init_data(gl, glw::GL_TEXTURE_BUFFER, glw::GL_DYNAMIC_COPY, 16)?;
        let mut textures: Vec<MbTex> = Vec::with_capacity(n);

        for (i, info) in TEXTURE_INFOS.iter().enumerate() {
            let target = info.target;
            let texture = if target != glw::GL_TEXTURE_BUFFER {
                MbTex::init_storage(gl, target, 1, glw::GL_RGBA8, WIDTH, HEIGHT, DEPTH, false)?
            } else {
                // Texture::InitBuffer
                let texture = MbTex::generate_bound(gl, glw::GL_TEXTURE_BUFFER)?;
                bind(gl, buffer.id, glw::GL_TEXTURE_BUFFER)?;
                // SAFETY: a live buffer and the texture bound above.
                unsafe { gl.tex_buffer(glw::GL_TEXTURE_BUFFER, glw::GL_RGBA8, buffer.id) };
                glu::expect_no_error(gl, "TexBuffer")?;
                texture
            };
            if i < n {
                textures.push(texture);
            }

            // Unbind
            // SAFETY: plain state change.
            unsafe { gl.bind_texture(target, 0) };
            glu::expect_no_error(gl, "BindTexture")?;
        }
        for _ in TEXTURE_INFOS.len()..n {
            textures.push(MbTex::init_storage(
                gl,
                glw::GL_TEXTURE_2D,
                1,
                glw::GL_RGBA8,
                WIDTH,
                HEIGHT,
                DEPTH,
                false,
            )?);
        }
        // SAFETY: plain state change.
        unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, 0) };
        glu::expect_no_error(gl, "BindTexture")?;

        let mut texture_ids: Vec<glw::GLuint> = textures.iter().map(|texture| texture.id).collect();

        // Bind all textures and inspect the bindings of all units.
        // SAFETY: `texture_ids` holds `max_textures` names.
        unsafe { gl.bind_textures(0, max_textures, texture_ids.as_ptr()) };
        glu::expect_no_error(gl, "BindTextures")?;
        for (i, texture_id) in texture_ids.iter().enumerate() {
            check_texture_binding(gl, get_binding(i), i as glw::GLuint, *texture_id as glw::GLint)?;
        }

        // Unbind the first half with zeros.
        let half_index = max_textures / 2;
        let t_texture_ids = vec![0 as glw::GLuint; n];
        // SAFETY: `t_texture_ids` holds `max_textures` names.
        unsafe { gl.bind_textures(0, half_index, t_texture_ids.as_ptr()) };
        glu::expect_no_error(gl, "BindTextures")?;
        for i in 0..half_index as usize {
            check_texture_binding(gl, get_binding(i), i as glw::GLuint, 0)?;
        }
        for i in half_index as usize..n {
            check_texture_binding(gl, get_binding(i), i as glw::GLuint, texture_ids[i] as glw::GLint)?;
        }

        // Unbind the second half with null as <textures>.
        // SAFETY: a null <textures> unbinds.
        unsafe { gl.bind_textures(half_index as glw::GLuint, max_textures - half_index, std::ptr::null()) };
        glu::expect_no_error(gl, "BindTextures")?;
        for i in 0..n {
            check_texture_binding(gl, get_binding(i), i as glw::GLuint, 0)?;
        }

        // A first entry that is not a texture name generates INVALID_OPERATION and leaves that unit alone.
        let invalid_id = find_invalid_id(|id| {
            // SAFETY: plain query.
            unsafe { gl.is_texture(id) == glw::GL_TRUE as glw::GLboolean }
        });
        texture_ids[0] = invalid_id;
        // SAFETY: `texture_ids` holds `max_textures` names; the call is expected to fail validation for the first one.
        unsafe { gl.bind_textures(0, max_textures, texture_ids.as_ptr()) };
        check_error!(gl, glw::GL_INVALID_OPERATION, "BindTextures with invalid texture id");
        check_texture_binding(gl, get_binding(0), 0, 0)?;
        for i in 1..n {
            check_texture_binding(gl, get_binding(i), i as glw::GLuint, texture_ids[i] as glw::GLint)?;
        }

        // Unbind all textures.
        // SAFETY: a null <textures> unbinds.
        unsafe { gl.bind_textures(0, max_textures, std::ptr::null()) };
        glu::expect_no_error(gl, "BindTextures")?;

        pass()
    }
}

/// `FunctionalBindSamplersTest`
struct FunctionalBindSamplersTest;

impl TestCase for FunctionalBindSamplersTest {
    fn name(&self) -> &str {
        "functional_bind_samplers"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut max_samplers: glw::GLint = 0;

        // SAFETY: the value is written to a live local.
        unsafe { gl.get_integerv(glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS, &mut max_samplers) };
        glu::expect_no_error(gl, "GetIntegerv")?;
        let n = max_samplers as usize;

        struct Samplers<'gl> {
            gl: &'gl glw::Functions,
            ids: Vec<glw::GLuint>,
        }
        impl Drop for Samplers<'_> {
            fn drop(&mut self) {
                // SAFETY: deletes the names this guard generated.
                unsafe {
                    self.gl
                        .delete_samplers(self.ids.len() as glw::GLsizei, self.ids.as_ptr())
                };
            }
        }

        let mut samplers = Samplers { gl, ids: vec![0; n] };
        let mut t_sampler_ids = vec![0 as glw::GLuint; n];

        // SAFETY: `max_samplers` names are written to the live vector.
        unsafe { gl.gen_samplers(max_samplers, samplers.ids.as_mut_ptr()) };
        glu::expect_no_error(gl, "GenSamplers")?;

        // Bind all samplers and inspect the bindings.
        // SAFETY: the vector holds `max_samplers` names.
        unsafe { gl.bind_samplers(0, max_samplers, samplers.ids.as_ptr()) };
        glu::expect_no_error(gl, "BindSamplers")?;
        for (i, sampler_id) in samplers.ids.iter().enumerate() {
            check_binding(
                gl,
                glw::GL_SAMPLER_BINDING,
                i as glw::GLuint,
                "Sampler",
                *sampler_id as glw::GLint,
            )?;
        }

        // Unbind the first half with zeros.
        let half_index = max_samplers / 2;
        // SAFETY: `t_sampler_ids` holds `max_samplers` names.
        unsafe { gl.bind_samplers(0, half_index, t_sampler_ids.as_ptr()) };
        glu::expect_no_error(gl, "BindSamplers")?;
        for i in 0..half_index as usize {
            check_binding(gl, glw::GL_SAMPLER_BINDING, i as glw::GLuint, "Sampler", 0)?;
        }
        for i in half_index as usize..n {
            check_binding(
                gl,
                glw::GL_SAMPLER_BINDING,
                i as glw::GLuint,
                "Sampler",
                samplers.ids[i] as glw::GLint,
            )?;
        }

        // Unbind the second half with null as <samplers>.
        // SAFETY: a null <samplers> unbinds.
        unsafe { gl.bind_samplers(half_index as glw::GLuint, max_samplers - half_index, std::ptr::null()) };
        glu::expect_no_error(gl, "BindSamplers")?;
        for i in 0..n {
            check_binding(gl, glw::GL_SAMPLER_BINDING, i as glw::GLuint, "Sampler", 0)?;
        }

        // A first entry that is not a sampler name generates INVALID_OPERATION and leaves that unit alone.
        let invalid_id = find_invalid_id(|id| {
            // SAFETY: plain query.
            unsafe { gl.is_sampler(id) == glw::GL_TRUE as glw::GLboolean }
        });
        t_sampler_ids[0] = invalid_id;
        t_sampler_ids[1..].copy_from_slice(&samplers.ids[1..]);

        // SAFETY: `t_sampler_ids` holds `max_samplers` names; the call is expected to fail validation for the first one.
        unsafe { gl.bind_samplers(0, max_samplers, t_sampler_ids.as_ptr()) };
        check_error!(gl, glw::GL_INVALID_OPERATION, "BindSamplers with invalid sampler id");

        t_sampler_ids[0] = 0;
        for (i, sampler_id) in t_sampler_ids.iter().enumerate() {
            check_binding(
                gl,
                glw::GL_SAMPLER_BINDING,
                i as glw::GLuint,
                "Sampler",
                *sampler_id as glw::GLint,
            )?;
        }

        // Unbind all samplers.
        // SAFETY: a null <samplers> unbinds.
        unsafe { gl.bind_samplers(0, max_samplers, std::ptr::null()) };
        glu::expect_no_error(gl, "BindSamplers")?;

        pass()
    }
}

/// `checkVertexAttribBinding`
fn check_vertex_attrib_binding(
    gl: &glw::Functions,
    index: glw::GLuint,
    expected_value: glw::GLint,
) -> Result<(), TestError> {
    let mut binding: glw::GLint = -1;
    // SAFETY: the value is written to a live local.
    unsafe { gl.get_vertex_attribiv(index, glw::GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING, &mut binding) };
    glu::expect_no_error(gl, "GetVertexAttribiv")?;

    if binding != expected_value {
        log::info!(
            "Invalid binding: {binding}, expected: {expected_value}. Target: Vertex attribute at index: {index}"
        );
        return Err(TestError::Fail("Invalid binding".to_string()));
    }
    Ok(())
}

/// `FunctionalBindImageTexturesTest`
struct FunctionalBindImageTexturesTest;

impl TestCase for FunctionalBindImageTexturesTest {
    fn name(&self) -> &str {
        "functional_bind_image_textures"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const DEPTH: glw::GLuint = 6;
        const HEIGHT: glw::GLuint = 6;
        const WIDTH: glw::GLuint = 6;
        let gl = context.gl();
        let mut max_textures: glw::GLint = 0;

        // SAFETY: the value is written to a live local.
        unsafe { gl.get_integerv(glw::GL_MAX_IMAGE_UNITS, &mut max_textures) };
        glu::expect_no_error(gl, "GetIntegerv")?;
        let n = max_textures as usize;

        let buffer = DataBuf::init_data(gl, glw::GL_TEXTURE_BUFFER, glw::GL_DYNAMIC_COPY, 16)?;
        let mut textures: Vec<MbTex> = Vec::with_capacity(n);

        for info in &TEXTURE_INFOS {
            let target = info.target;
            if textures.len() >= n {
                break;
            }

            let texture = if target != glw::GL_TEXTURE_BUFFER {
                MbTex::init_storage(gl, target, 1, glw::GL_RGBA8, WIDTH, HEIGHT, DEPTH, false)?
            } else {
                // Texture::InitBuffer
                let texture = MbTex::generate_bound(gl, glw::GL_TEXTURE_BUFFER)?;
                bind(gl, buffer.id, glw::GL_TEXTURE_BUFFER)?;
                // SAFETY: a live buffer and the texture bound above.
                unsafe { gl.tex_buffer(glw::GL_TEXTURE_BUFFER, glw::GL_RGBA8, buffer.id) };
                glu::expect_no_error(gl, "TexBuffer")?;
                texture
            };
            textures.push(texture);

            // SAFETY: plain state change.
            unsafe { gl.bind_texture(target, 0) };
            glu::expect_no_error(gl, "BindTexture")?;
        }
        for _ in TEXTURE_INFOS.len()..n {
            textures.push(MbTex::init_storage(
                gl,
                glw::GL_TEXTURE_2D,
                1,
                glw::GL_RGBA8,
                WIDTH,
                HEIGHT,
                DEPTH,
                false,
            )?);
        }
        // SAFETY: plain state change.
        unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, 0) };
        glu::expect_no_error(gl, "BindTexture")?;

        let mut texture_ids: Vec<glw::GLuint> = textures.iter().map(|texture| texture.id).collect();

        // Bind all images and inspect the bindings.
        // SAFETY: `texture_ids` holds `max_textures` names.
        unsafe { gl.bind_image_textures(0, max_textures, texture_ids.as_ptr()) };
        glu::expect_no_error(gl, "BindImageTextures")?;
        for (i, texture_id) in texture_ids.iter().enumerate() {
            check_binding(
                gl,
                glw::GL_IMAGE_BINDING_NAME,
                i as glw::GLuint,
                "Image unit",
                *texture_id as glw::GLint,
            )?;
        }

        // Unbind the first half with zeros.
        let half_index = max_textures / 2;
        let t_texture_ids = vec![0 as glw::GLuint; n];
        // SAFETY: `t_texture_ids` holds `max_textures` names.
        unsafe { gl.bind_image_textures(0, half_index, t_texture_ids.as_ptr()) };
        glu::expect_no_error(gl, "BindImageTextures")?;
        for i in 0..half_index as usize {
            check_binding(gl, glw::GL_IMAGE_BINDING_NAME, i as glw::GLuint, "Image unit", 0)?;
        }
        for i in half_index as usize..n {
            check_binding(
                gl,
                glw::GL_IMAGE_BINDING_NAME,
                i as glw::GLuint,
                "Image unit",
                texture_ids[i] as glw::GLint,
            )?;
        }

        // Unbind the second half with null as <textures>.
        // SAFETY: a null <textures> unbinds.
        unsafe { gl.bind_image_textures(half_index as glw::GLuint, max_textures - half_index, std::ptr::null()) };
        glu::expect_no_error(gl, "BindImageTextures")?;
        for i in 0..n {
            check_binding(gl, glw::GL_IMAGE_BINDING_NAME, i as glw::GLuint, "Image unit", 0)?;
        }

        // A first entry that is not a texture name generates INVALID_OPERATION and leaves that unit alone.
        let invalid_id = find_invalid_id(|id| {
            // SAFETY: plain query.
            unsafe { gl.is_texture(id) == glw::GL_TRUE as glw::GLboolean }
        });
        texture_ids[0] = invalid_id;
        // SAFETY: `texture_ids` holds `max_textures` names; the call is expected to fail validation for the first one.
        unsafe { gl.bind_image_textures(0, max_textures, texture_ids.as_ptr()) };
        check_error!(
            gl,
            glw::GL_INVALID_OPERATION,
            "BindImageTextures with invalid texture id"
        );
        check_binding(gl, glw::GL_IMAGE_BINDING_NAME, 0, "Image unit", 0)?;
        for i in 1..n {
            check_binding(
                gl,
                glw::GL_IMAGE_BINDING_NAME,
                i as glw::GLuint,
                "Image unit",
                texture_ids[i] as glw::GLint,
            )?;
        }

        // Unbind all images.
        // SAFETY: a null <textures> unbinds.
        unsafe { gl.bind_image_textures(0, max_textures, std::ptr::null()) };
        glu::expect_no_error(gl, "BindImageTextures")?;

        pass()
    }
}

/// `FunctionalBindVertexBuffersTest`
struct FunctionalBindVertexBuffersTest;

impl TestCase for FunctionalBindVertexBuffersTest {
    fn name(&self) -> &str {
        "functional_bind_vertex_buffers"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const BUFFER_SIZE: glw::GLintptr = 16;
        const OFFSET: glw::GLintptr = 4;
        const STRIDE: glw::GLsizei = 4;
        let gl = context.gl();
        let mut max_buffers: glw::GLint = 0;

        // SAFETY: the value is written to a live local.
        unsafe { gl.get_integerv(glw::GL_MAX_VERTEX_ATTRIB_BINDINGS, &mut max_buffers) };
        glu::expect_no_error(gl, "GetIntegerv")?;
        let n = max_buffers as usize;

        let mut buffers = Vec::with_capacity(n);
        let mut buffer_ids = vec![0 as glw::GLuint; n];
        let offsets = vec![OFFSET; n];
        let strides = vec![STRIDE; n];
        let t_buffer_ids = vec![0 as glw::GLuint; n];
        for buffer_id in &mut buffer_ids {
            let buffer = DataBuf::init_data(gl, glw::GL_ARRAY_BUFFER, glw::GL_DYNAMIC_COPY, BUFFER_SIZE)?;
            *buffer_id = buffer.id;
            buffers.push(buffer);
        }

        struct Vao<'gl> {
            gl: &'gl glw::Functions,
            id: glw::GLuint,
        }
        impl Drop for Vao<'_> {
            fn drop(&mut self) {
                // SAFETY: deletes the name this guard generated.
                unsafe { self.gl.delete_vertex_arrays(1, &self.id) };
            }
        }

        let mut vao = Vao { gl, id: 0 };
        // SAFETY: one name is written to the live field.
        unsafe { gl.gen_vertex_arrays(1, &mut vao.id) };
        glu::expect_no_error(gl, "GenVertexArrays")?;

        // SAFETY: the vertex array was generated above.
        unsafe { gl.bind_vertex_array(vao.id) };
        glu::expect_no_error(gl, "BindVertexArrays")?;

        // Bind all buffers and inspect the bindings.
        // SAFETY: the vectors hold `max_buffers` entries.
        unsafe { gl.bind_vertex_buffers(0, max_buffers, buffer_ids.as_ptr(), offsets.as_ptr(), strides.as_ptr()) };
        glu::expect_no_error(gl, "BindVertexBuffers")?;
        for (i, buffer_id) in buffer_ids.iter().enumerate() {
            check_vertex_attrib_binding(gl, i as glw::GLuint, *buffer_id as glw::GLint)?;
        }

        // Unbind the first half with zeros.
        let half_index = max_buffers / 2;
        // SAFETY: as above.
        unsafe { gl.bind_vertex_buffers(0, half_index, t_buffer_ids.as_ptr(), offsets.as_ptr(), strides.as_ptr()) };
        glu::expect_no_error(gl, "BindVertexBuffers")?;
        for i in 0..half_index as usize {
            check_vertex_attrib_binding(gl, i as glw::GLuint, 0)?;
        }
        for i in half_index as usize..n {
            check_vertex_attrib_binding(gl, i as glw::GLuint, buffer_ids[i] as glw::GLint)?;
        }

        // Unbind the second half with null as <buffers>.
        // SAFETY: a null <buffers> unbinds.
        unsafe {
            gl.bind_vertex_buffers(
                half_index as glw::GLuint,
                max_buffers - half_index,
                std::ptr::null(),
                offsets.as_ptr(),
                strides.as_ptr(),
            )
        };
        glu::expect_no_error(gl, "BindVertexBuffers")?;
        for i in 0..n {
            check_vertex_attrib_binding(gl, i as glw::GLuint, 0)?;
        }

        // A first entry that is not a buffer name generates INVALID_OPERATION and leaves that binding alone.
        let invalid_id = find_invalid_id(|id| {
            // SAFETY: plain query.
            unsafe { gl.is_buffer(id) == glw::GL_TRUE as glw::GLboolean }
        });
        buffer_ids[0] = invalid_id;
        // SAFETY: the vectors hold `max_buffers` entries; the call is expected to fail validation for the first one.
        unsafe { gl.bind_vertex_buffers(0, max_buffers, buffer_ids.as_ptr(), offsets.as_ptr(), strides.as_ptr()) };
        check_error!(gl, glw::GL_INVALID_OPERATION, "BindVertexBuffers with invalid id");
        check_vertex_attrib_binding(gl, 0, 0)?;
        for i in 1..n {
            check_vertex_attrib_binding(gl, i as glw::GLuint, buffer_ids[i] as glw::GLint)?;
        }

        // Unbind all buffers.
        // SAFETY: a null <buffers> unbinds.
        unsafe { gl.bind_vertex_buffers(0, max_buffers, std::ptr::null(), offsets.as_ptr(), strides.as_ptr()) };
        glu::expect_no_error(gl, "BindVertexBuffers")?;

        drop(vao);
        glu::expect_no_error(gl, "DeleteVertexArrays")?;

        pass()
    }
}

/// `replaceToken`: replaces the first `token` found at or after `search_position` with `text` and moves `search_position` behind the new text.
fn replace_token(token: &str, search_position: &mut usize, text: &str, string: &mut String) -> Result<(), TestError> {
    let Some(offset) = string[*search_position..].find(token) else {
        return Err(TestError::Fail(format!("replaceToken: token {token} not found")));
    };
    let token_position = *search_position + offset;
    string.replace_range(token_position..token_position + token.len(), text);
    *search_position = token_position + text.len();
    Ok(())
}

/// `Program::Init` with only a compute shader, followed by `Program::Use`.
fn use_compute_program<'gl>(gl: &'gl glw::Functions, source: &str) -> Result<Program<'gl>, TestError> {
    let compute = Shader::new(gl, glw::GL_COMPUTE_SHADER)?;
    compute.source(&[source])?;
    if !compute.compile()? {
        return Err(TestError::Fail("Failed to compile shader".to_string()));
    }
    let program = Program::new(gl)?;
    program.attach(&compute)?;
    if !program.link()? {
        return Err(TestError::Fail("Failed to link program".to_string()));
    }
    // SAFETY: a live, linked program.
    unsafe { gl.use_program(program.id) };
    glu::expect_no_error(gl, "UseProgram")?;
    Ok(program)
}

/// The tail shared by both dispatch buffer tests: dispatch one group, barrier, map the shader storage buffer and compare its first bytes with `expected`.
fn dispatch_and_compare(gl: &glw::Functions, expected: &[u8]) -> Result<bool, TestError> {
    // SAFETY: plain commands.
    unsafe {
        gl.dispatch_compute(1, 1, 1);
        glu::expect_no_error(gl, "DispatchCompute")?;
        gl.memory_barrier(glw::GL_ALL_BARRIER_BITS);
        glu::expect_no_error(gl, "MemoryBarrier")?;
    }

    // SAFETY: a read-only mapping of the buffer bound to GL_SHADER_STORAGE_BUFFER, which holds at least `expected.len()` bytes.
    let result = unsafe { gl.map_buffer(glw::GL_SHADER_STORAGE_BUFFER, glw::GL_READ_ONLY) };
    glu::expect_no_error(gl, "MapBuffer")?;
    // SAFETY: as above; the slice ends before the unmap.
    let same = unsafe { std::slice::from_raw_parts(result.cast::<u8>(), expected.len()) } == expected;

    // SAFETY: the buffer is mapped; the error, if any, is ignored as upstream does.
    unsafe {
        gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER);
        gl.get_error();
    }
    Ok(same)
}

/// `DispatchBindBuffersBaseTest`
struct DispatchBindBuffersBaseTest;

impl TestCase for DispatchBindBuffersBaseTest {
    fn name(&self) -> &str {
        "dispatch_bind_buffers_base"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const CS: &str = "#version 440 core\n\nlayout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\nUBO_LIST\nlayout (std140, binding = 0) buffer SSB {\n    vec4 sum;\n} ssb;\n\nvoid main()\n{\n    ssb.sum = SUM_LIST;\n}\n\n";
        const UBO: &str = "layout (std140, binding = XXX) uniform BXXX { vec4 data; } bXXX;";
        const BUFFER_SIZE: glw::GLintptr = 4 * std::mem::size_of::<f32>() as glw::GLintptr;
        let gl = context.gl();
        let mut max_buffers: glw::GLint = 0;
        let mut sum = [0.0f32; 4];

        // SAFETY: the value is written to a live local.
        unsafe { gl.get_integerv(glw::GL_MAX_COMPUTE_UNIFORM_BLOCKS, &mut max_buffers) };
        glu::expect_no_error(gl, "GetIntegerv")?;

        let mut uni_buffers = Vec::new();
        let mut uni_buffer_ids = Vec::new();
        for i in 0..max_buffers {
            let data = [
                (i * 4) as f32,
                (i * 4 + 1) as f32,
                (i * 4 + 2) as f32,
                (i * 4 + 3) as f32,
            ];
            for (sum, data) in sum.iter_mut().zip(data) {
                *sum += data;
            }
            let buffer = DataBuf::init_data_from(
                gl,
                glw::GL_UNIFORM_BUFFER,
                glw::GL_DYNAMIC_COPY,
                BUFFER_SIZE,
                data.as_ptr().cast(),
            )?;
            uni_buffer_ids.push(buffer.id);
            uni_buffers.push(buffer);
        }

        // SAFETY: `uni_buffer_ids` holds `max_buffers` names.
        unsafe { gl.bind_buffers_base(glw::GL_UNIFORM_BUFFER, 0, max_buffers, uni_buffer_ids.as_ptr()) };
        glu::expect_no_error(gl, "BindBuffersBase")?;

        let ssb_buffer = DataBuf::init_data(gl, glw::GL_SHADER_STORAGE_BUFFER, glw::GL_DYNAMIC_COPY, BUFFER_SIZE)?;
        // SAFETY: a live buffer; `BindBase(0)` of upstream's Buffer.
        unsafe { gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, ssb_buffer.id) };
        glu::expect_no_error(gl, "BindBufferBase")?;

        let mut ubo_position = 0;
        let mut sum_position = 0;
        let mut cs_source = CS.to_string();
        for i in 0..max_buffers {
            let ubo_start_position = ubo_position;
            let sum_start_position = sum_position;
            let index = i.to_string();

            replace_token("UBO_LIST", &mut ubo_position, "UBO\nUBO_LIST", &mut cs_source)?;
            ubo_position = ubo_start_position;
            replace_token("UBO", &mut ubo_position, UBO, &mut cs_source)?;
            ubo_position = ubo_start_position;
            replace_token("XXX", &mut ubo_position, &index, &mut cs_source)?;
            replace_token("XXX", &mut ubo_position, &index, &mut cs_source)?;
            replace_token("XXX", &mut ubo_position, &index, &mut cs_source)?;

            replace_token("SUM_LIST", &mut sum_position, "bXXX.data + SUM_LIST", &mut cs_source)?;
            sum_position = sum_start_position;
            replace_token("XXX", &mut sum_position, &index, &mut cs_source)?;
        }
        replace_token(" + SUM_LIST", &mut sum_position, "", &mut cs_source)?;
        replace_token("UBO_LIST", &mut ubo_position, "", &mut cs_source)?;

        let _program = use_compute_program(gl, &cs_source)?;

        let expected: Vec<u8> = sum.iter().flat_map(|value| value.to_ne_bytes()).collect();
        let test_result = dispatch_and_compare(gl, &expected)?;

        Ok(if test_result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `DispatchBindBuffersRangeTest`
struct DispatchBindBuffersRangeTest;

impl TestCase for DispatchBindBuffersRangeTest {
    fn name(&self) -> &str {
        "dispatch_bind_buffers_range"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const CS: &str = "#version 440 core\n\nlayout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\nlayout (std140, binding = 0) uniform B0 { int data; } b0;layout (std140, binding = 1) uniform B1 { int data; } b1;layout (std140, binding = 2) uniform B2 { int data; } b2;layout (std140, binding = 3) uniform B3 { int data; } b3;\nlayout (std140, binding = 0) buffer SSB {\n    int sum;\n} ssb;\n\nvoid main()\n{\n    //ssb.sum = b1.data;// + b1.data + b2.data + b3.data;\n    ssb.sum = b0.data + b1.data + b2.data + b3.data;\n}\n\n";
        const DATA: [i32; 2] = [0x00010001, 0x01000100];
        const N_BUFFERS: usize = 4;
        const SUM: i32 = 0x02020202;
        let gl = context.gl();
        let mut offset_alignment: glw::GLint = 0;

        // SAFETY: the value is written to a live local.
        unsafe { gl.get_integerv(glw::GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT, &mut offset_alignment) };
        glu::expect_no_error(gl, "GetIntegerv")?;
        let alignment = offset_alignment as usize;

        let buffer_size = (N_BUFFERS - 1) * alignment + std::mem::size_of::<i32>();
        let mut uni_data = vec![0xaau8; buffer_size];
        for i in 0..N_BUFFERS {
            uni_data[i * alignment..i * alignment + std::mem::size_of::<i32>()]
                .copy_from_slice(&DATA[i % 2].to_ne_bytes());
        }
        let uni_buffer = DataBuf::init_data_from(
            gl,
            glw::GL_UNIFORM_BUFFER,
            glw::GL_DYNAMIC_COPY,
            buffer_size as glw::GLsizeiptr,
            uni_data.as_ptr().cast(),
        )?;

        let uni_buffer_ids = [uni_buffer.id; N_BUFFERS];
        let uni_offsets: [glw::GLintptr; N_BUFFERS] = std::array::from_fn(|i| (i * alignment) as glw::GLintptr);
        let uni_sizes = [std::mem::size_of::<i32>() as glw::GLsizeiptr; N_BUFFERS];
        // SAFETY: the arrays hold N_BUFFERS entries.
        unsafe {
            gl.bind_buffers_range(
                glw::GL_UNIFORM_BUFFER,
                0,
                N_BUFFERS as glw::GLsizei,
                uni_buffer_ids.as_ptr(),
                uni_offsets.as_ptr(),
                uni_sizes.as_ptr(),
            )
        };
        glu::expect_no_error(gl, "BindBuffersRange")?;

        let ssb_buffer = DataBuf::init_data(
            gl,
            glw::GL_SHADER_STORAGE_BUFFER,
            glw::GL_DYNAMIC_COPY,
            std::mem::size_of::<i32>() as glw::GLsizeiptr,
        )?;
        // SAFETY: a live buffer; `BindBase(0)` of upstream's Buffer.
        unsafe { gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, ssb_buffer.id) };
        glu::expect_no_error(gl, "BindBufferBase")?;

        let _program = use_compute_program(gl, CS)?;

        let test_result = dispatch_and_compare(gl, &SUM.to_ne_bytes())?;

        Ok(if test_result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `Texture::SubImage` for level 0 at the origin with `GL_RED_INTEGER`/`GL_UNSIGNED_INT` data, the only way the dispatch tests call it.
fn tex_sub_image_red_integer(
    gl: &glw::Functions,
    target: glw::GLenum,
    width: glw::GLuint,
    height: glw::GLuint,
    depth: glw::GLuint,
    data: &[u32],
) -> Result<(), TestError> {
    let (width, height, depth) = (width as glw::GLsizei, height as glw::GLsizei, depth as glw::GLsizei);
    let pixels: *const std::ffi::c_void = data.as_ptr().cast();
    let (format, type_) = (glw::GL_RED_INTEGER, glw::GL_UNSIGNED_INT);

    // SAFETY: `data` holds width * height * depth values, at least what each variant reads.
    let name = unsafe {
        match target {
            glw::GL_TEXTURE_1D => {
                gl.tex_sub_image_1d(target, 0, 0, width, format, type_, pixels);
                "TexSubImage1D"
            }
            glw::GL_TEXTURE_1D_ARRAY | glw::GL_TEXTURE_2D | glw::GL_TEXTURE_RECTANGLE => {
                gl.tex_sub_image_2d(target, 0, 0, 0, width, height, format, type_, pixels);
                "TexSubImage2D"
            }
            glw::GL_TEXTURE_CUBE_MAP => {
                for face in [
                    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
                    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
                    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
                    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
                    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
                    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
                ] {
                    gl.tex_sub_image_2d(face, 0, 0, 0, width, height, format, type_, pixels);
                }
                "TexSubImage2D"
            }
            glw::GL_TEXTURE_3D | glw::GL_TEXTURE_2D_ARRAY | glw::GL_TEXTURE_CUBE_MAP_ARRAY => {
                gl.tex_sub_image_3d(target, 0, 0, 0, 0, width, height, depth, format, type_, pixels);
                "TexSubImage3D"
            }
            _ => return Err(TestError::Fail("Invliad enum".to_string())),
        }
    };
    glu::expect_no_error(gl, name)
}

/// `Texture::InitBuffer` after the buffer exists.
fn init_buffer_texture<'gl>(
    gl: &'gl glw::Functions,
    internal_format: glw::GLenum,
    buffer_id: glw::GLuint,
) -> Result<MbTex<'gl>, TestError> {
    let texture = MbTex::generate_bound(gl, glw::GL_TEXTURE_BUFFER)?;
    bind(gl, buffer_id, glw::GL_TEXTURE_BUFFER)?;
    // SAFETY: a live buffer and the texture bound above.
    unsafe { gl.tex_buffer(glw::GL_TEXTURE_BUFFER, internal_format, buffer_id) };
    glu::expect_no_error(gl, "TexBuffer")?;
    Ok(texture)
}

/// `fillMSTexture`
fn fill_ms_texture(
    gl: &glw::Functions,
    texture_id: glw::GLuint,
    value: glw::GLuint,
    is_array: bool,
) -> Result<(), TestError> {
    const CS: &str = "#version 430 core\n\nlayout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\nlayout (location = 0) writeonly uniform IMAGE uni_image;\n\nlayout (location = 1) uniform uint uni_value;\n\nvoid main()\n{\n    const POINT;\n\n    imageStore(uni_image, point, 0, uvec4(uni_value, 0, 0, 0));\n}\n\n";
    let (image, point) = if is_array {
        (
            "uimage2DMSArray",
            "ivec3 point = ivec3(gl_WorkGroupID.x, gl_WorkGroupID.y, 0)",
        )
    } else {
        ("uimage2DMS", "ivec2 point = ivec2(gl_WorkGroupID.x, gl_WorkGroupID.y)")
    };

    let mut position = 0;
    let mut source = CS.to_string();
    replace_token("IMAGE", &mut position, image, &mut source)?;
    replace_token("POINT", &mut position, point, &mut source)?;

    let _program = use_compute_program(gl, &source)?;

    // SAFETY: a live texture and a bound program that declares the two uniforms.
    unsafe {
        gl.bind_image_texture(
            0,
            texture_id,
            0,
            (if is_array { glw::GL_TRUE } else { glw::GL_FALSE }) as glw::GLboolean,
            0,
            glw::GL_WRITE_ONLY,
            glw::GL_R32UI,
        );
        glu::expect_no_error(gl, "BindImageTexture")?;
        gl.uniform_1i(0, 0);
        glu::expect_no_error(gl, "Uniform1i")?;
        gl.uniform_1ui(1, value);
        glu::expect_no_error(gl, "Uniform1ui")?;
        gl.dispatch_compute(6, 6, 1);
    }
    glu::expect_no_error(gl, "DispatchCompute")
}

/// What distinguishes `DispatchBindTexturesTest` from `DispatchBindImageTexturesTest`.
struct TextureUnitsKind {
    max_pname: glw::GLenum,
    cs: &'static str,
    list_token: &'static str,
    type_token: &'static str,
    code_token: &'static str,
    declaration: &'static str,
    code: [&'static str; 11],
    types: [&'static str; 11],
    coordinates: [&'static str; 11],
    /// `max_image_samples` at or above which the multisampled targets are used
    min_image_samples: glw::GLint,
    is_image: bool,
}

const SAMPLERS_KIND: TextureUnitsKind = TextureUnitsKind {
    max_pname: glw::GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS,
    cs: "#version 440 core\n\nlayout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\nSAMPLER_LIST\nlayout (std140, binding = 0) buffer SSB {\n    uint sum;\n} ssb;\n\nvoid main()\n{\n    uvec4 sum = SUM_LIST;\n    ssb.sum = sum.r\n;}\n\n",
    list_token: "SAMPLER_LIST",
    type_token: "SAMPLER",
    code_token: "SAMPLING",
    declaration: "layout (location = XXX) uniform SAMPLER sXXX;",
    code: [
        "texture(sXXX, COORDS)",
        "texture(sXXX, COORDS)",
        "texture(sXXX, COORDS)",
        "texture(sXXX, COORDS)",
        "texture(sXXX, COORDS)",
        "texelFetch(sXXX, COORDS)",
        "texture(sXXX, COORDS)",
        "texture(sXXX, COORDS)",
        "texture(sXXX, COORDS)",
        "texelFetch(sXXX, COORDS, 0)",
        "texelFetch(sXXX, COORDS, 0)",
    ],
    types: [
        "usampler1D",
        "usampler1DArray",
        "usampler2D",
        "usampler2DArray",
        "usampler3D",
        "usamplerBuffer",
        "usamplerCube",
        "usamplerCubeArray",
        "usampler2DRect",
        "usampler2DMS",
        "usampler2DMSArray",
    ],
    coordinates: [
        "0.5f",
        "vec2(0.5f, 0.0f)",
        "vec2(0.5f, 0.5f)",
        "vec3(0.5f, 0.5f, 0.0f)",
        "vec3(0.5f, 0.5f, 0.5f)",
        "0",
        "vec3(0.5f, 0.5f, 0.5f)",
        "vec4(0.5f, 0.5f, 0.5f, 0.0f)",
        "vec2(0.5f, 0.5f)",
        "ivec2(0, 0)",
        "ivec3(0, 0, 0)",
    ],
    min_image_samples: 2,
    is_image: false,
};

const IMAGES_KIND: TextureUnitsKind = TextureUnitsKind {
    max_pname: glw::GL_MAX_COMPUTE_IMAGE_UNIFORMS,
    cs: "#version 440 core\n\nlayout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\nIMAGE_LIST\nlayout (std140, binding = 0) buffer SSB {\n    uint sum;\n} ssb;\n\nvoid main()\n{\n    uvec4 sum = SUM_LIST;\n    ssb.sum = sum.r\n;}\n\n",
    list_token: "IMAGE_LIST",
    type_token: "IMAGE",
    code_token: "LOADING",
    declaration: "layout (location = XXX, r32ui) readonly uniform IMAGE iXXX;",
    code: [
        "imageLoad(iXXX, COORDS)",
        "imageLoad(iXXX, COORDS)",
        "imageLoad(iXXX, COORDS)",
        "imageLoad(iXXX, COORDS)",
        "imageLoad(iXXX, COORDS)",
        "imageLoad(iXXX, COORDS)",
        "imageLoad(iXXX, COORDS)",
        "imageLoad(iXXX, COORDS)",
        "imageLoad(iXXX, COORDS)",
        "imageLoad(iXXX, COORDS, 0)",
        "imageLoad(iXXX, COORDS, 0)",
    ],
    types: [
        "uimage1D",
        "uimage1DArray",
        "uimage2D",
        "uimage2DArray",
        "uimage3D",
        "uimageBuffer",
        "uimageCube",
        "uimageCubeArray",
        "uimage2DRect",
        "uimage2DMS",
        "uimage2DMSArray",
    ],
    coordinates: [
        "0",
        "ivec2(0, 0)",
        "ivec2(0, 0)",
        "ivec3(0, 0, 0)",
        "ivec3(0, 0, 0)",
        "0",
        "ivec3(0, 0, 0)",
        "ivec3(0, 0, 0)",
        "ivec2(0, 0)",
        "ivec2(0, 0)",
        "ivec3(0, 0, 0)",
    ],
    min_image_samples: 1,
    is_image: true,
};

/// `DispatchBindTexturesTest::iterate` and `DispatchBindImageTexturesTest::iterate`, which share their structure.
fn dispatch_bind_texture_units(context: &Context, kind: &TextureUnitsKind) -> TestOutcome {
    const DEPTH: glw::GLuint = 6;
    const HEIGHT: glw::GLuint = 6;
    const WIDTH: glw::GLuint = 6;
    let gl = context.gl();
    let mut cs_filled_textures = false;
    let mut max_textures: glw::GLint = 0;
    let mut max_image_samples: glw::GLint = 0;
    let mut sum: u32 = 0;

    // SAFETY: the values are written to live locals.
    unsafe { gl.get_integerv(kind.max_pname, &mut max_textures) };
    glu::expect_no_error(gl, "GetIntegerv")?;
    // Check if load/store from multisampled images is supported
    // SAFETY: as above.
    unsafe { gl.get_integerv(glw::GL_MAX_IMAGE_SAMPLES, &mut max_image_samples) };
    glu::expect_no_error(gl, "GetIntegerv")?;
    let n = max_textures as usize;

    let mut textures: Vec<MbTex> = Vec::with_capacity(n);
    let mut texture_buffer: Option<DataBuf> = None;

    for i in 0..n {
        let mut target = TEXTURE_INFOS.get(i).map_or(glw::GL_TEXTURE_2D, |info| info.target);
        let multisample_unsupported = if kind.is_image {
            max_image_samples == 0
        } else {
            max_image_samples < 2
        };
        if target >= glw::GL_TEXTURE_2D_MULTISAMPLE && multisample_unsupported {
            target = glw::GL_TEXTURE_2D;
        }

        let data = vec![i as u32; (WIDTH * HEIGHT * DEPTH) as usize];
        sum += i as u32;

        let texture = match target {
            glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY | glw::GL_TEXTURE_2D_MULTISAMPLE => {
                let is_array = target == glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY;
                let texture = MbTex::init_storage(gl, target, 1, glw::GL_R32UI, WIDTH, HEIGHT, DEPTH, false)?;
                fill_ms_texture(gl, texture.id, i as glw::GLuint, is_array)?;
                cs_filled_textures = true;
                texture
            }
            glw::GL_TEXTURE_BUFFER => {
                let buffer = DataBuf::init_data_from(
                    gl,
                    glw::GL_TEXTURE_BUFFER,
                    glw::GL_DYNAMIC_COPY,
                    (data.len() * std::mem::size_of::<u32>()) as glw::GLsizeiptr,
                    data.as_ptr().cast(),
                )?;
                let texture = init_buffer_texture(gl, glw::GL_R32UI, buffer.id)?;
                texture_buffer = Some(buffer);
                texture
            }
            _ => {
                let texture = MbTex::init_storage(gl, target, 1, glw::GL_R32UI, WIDTH, HEIGHT, DEPTH, false)?;
                // SAFETY: plain state change.
                unsafe { gl.bind_texture(target, texture.id) };
                glu::expect_no_error(gl, "BindTexture")?;
                tex_sub_image_red_integer(gl, target, WIDTH, HEIGHT, DEPTH, &data)?;
                if !kind.is_image {
                    // SAFETY: parameters of the texture bound above.
                    unsafe {
                        gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as glw::GLint);
                        gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as glw::GLint);
                    }
                }
                texture
            }
        };

        // SAFETY: plain state change.
        unsafe { gl.bind_texture(target, 0) };
        glu::expect_no_error(gl, "BindTexture")?;
        textures.push(texture);
    }
    let texture_ids: Vec<glw::GLuint> = textures.iter().map(|texture| texture.id).collect();

    // Make sure fillMSTexture effects are seen in the next compute dispatch.
    if cs_filled_textures {
        // SAFETY: plain command.
        unsafe { gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT) };
    }
    // SAFETY: `texture_ids` holds `max_textures` names.
    unsafe {
        if kind.is_image {
            gl.bind_image_textures(0, max_textures, texture_ids.as_ptr());
        } else {
            gl.bind_textures(0, max_textures, texture_ids.as_ptr());
        }
    }
    glu::expect_no_error(
        gl,
        if kind.is_image {
            "BindImageTextures"
        } else {
            "BindTextures"
        },
    )?;

    let ssb_buffer = DataBuf::init_data(
        gl,
        glw::GL_SHADER_STORAGE_BUFFER,
        glw::GL_DYNAMIC_COPY,
        std::mem::size_of::<u32>() as glw::GLsizeiptr,
    )?;
    // SAFETY: a live buffer; `BindBase(0)` of upstream's Buffer.
    unsafe { gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, ssb_buffer.id) };
    glu::expect_no_error(gl, "BindBufferBase")?;

    let mut list_position = 0;
    let mut sum_position = 0;
    let mut cs_source = kind.cs.to_string();
    let max_target_index = if max_image_samples >= kind.min_image_samples {
        TEXTURE_INFOS.len()
    } else {
        TEXTURE_INFOS.len() - 2
    };
    for i in 0..n {
        let list_start_position = list_position;
        let sum_start_position = sum_position;
        let index = i.to_string();

        // Entries past the table use the 2D one.
        let k = if i < max_target_index { i } else { 2 };
        let (coords, type_name, code) = (kind.coordinates[k], kind.types[k], kind.code[k]);

        let list_with_entry = format!("{}\n{}", kind.type_token, kind.list_token);
        replace_token(kind.list_token, &mut list_position, &list_with_entry, &mut cs_source)?;
        list_position = list_start_position;
        replace_token(kind.type_token, &mut list_position, kind.declaration, &mut cs_source)?;
        list_position = list_start_position;
        replace_token("XXX", &mut list_position, &index, &mut cs_source)?;
        replace_token(kind.type_token, &mut list_position, type_name, &mut cs_source)?;
        replace_token("XXX", &mut list_position, &index, &mut cs_source)?;

        let sum_with_entry = format!("{} + SUM_LIST", kind.code_token);
        replace_token("SUM_LIST", &mut sum_position, &sum_with_entry, &mut cs_source)?;
        sum_position = sum_start_position;
        replace_token(kind.code_token, &mut sum_position, code, &mut cs_source)?;
        sum_position = sum_start_position;
        replace_token("XXX", &mut sum_position, &index, &mut cs_source)?;
        replace_token("COORDS", &mut sum_position, coords, &mut cs_source)?;
    }
    replace_token(" + SUM_LIST", &mut sum_position, "", &mut cs_source)?;
    replace_token(kind.list_token, &mut list_position, "", &mut cs_source)?;

    let _program = use_compute_program(gl, &cs_source)?;

    for i in 0..max_textures {
        // SAFETY: plain uniform update of the program in use.
        unsafe { gl.uniform_1i(i, i) };
        glu::expect_no_error(gl, "Uniform1i")?;
    }

    let test_result = dispatch_and_compare(gl, &sum.to_ne_bytes())?;
    drop(texture_buffer);

    Ok(if test_result {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

/// `DispatchBindTexturesTest`
struct DispatchBindTexturesTest;

impl TestCase for DispatchBindTexturesTest {
    fn name(&self) -> &str {
        "dispatch_bind_textures"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        dispatch_bind_texture_units(context, &SAMPLERS_KIND)
    }
}

/// `DispatchBindImageTexturesTest`
struct DispatchBindImageTexturesTest;

impl TestCase for DispatchBindImageTexturesTest {
    fn name(&self) -> &str {
        "dispatch_bind_image_textures"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        dispatch_bind_texture_units(context, &IMAGES_KIND)
    }
}

/// `DispatchBindSamplersTest`
struct DispatchBindSamplersTest;

impl TestCase for DispatchBindSamplersTest {
    fn name(&self) -> &str {
        "dispatch_bind_samplers"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const CS: &str = "#version 440 core\n\nlayout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\nSAMPLER_LIST\nlayout (std140, binding = 0) buffer SSB {\n    uint sum;\n} ssb;\n\nvoid main()\n{\n    uvec4 sum = SUM_LIST;\n    ssb.sum = sum.r\n;}\n\n";
        const SAMPLER: &str = "layout (location = XXX) uniform usampler2D sXXX;";
        const SAMPLING: &str = "texture(sXXX, vec2(1.5f, 0.5f))";
        const DEPTH: glw::GLuint = 1;
        const HEIGHT: usize = 8;
        const WIDTH: usize = 8;
        let gl = context.gl();
        let mut max_textures: glw::GLint = 0;

        // SAFETY: the value is written to a live local.
        unsafe { gl.get_integerv(glw::GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS, &mut max_textures) };
        glu::expect_no_error(gl, "GetIntegerv")?;
        let n = max_textures as usize;

        // A texture with a one pixel wide border of ones.
        let mut data = [0u32; WIDTH * HEIGHT];
        let last_line_offset = (HEIGHT - 1) * WIDTH;
        let last_pixel_in_line_offset = WIDTH - 1;
        for j in 0..WIDTH {
            data[j] = 1;
            data[j + last_line_offset] = 1;
        }
        for j in 0..HEIGHT {
            let line_offset = j * WIDTH;
            data[line_offset] = 1;
            data[line_offset + last_pixel_in_line_offset] = 1;
        }

        let mut textures: Vec<MbTex> = Vec::with_capacity(n);
        for _ in 0..n {
            let texture = MbTex::init_storage(
                gl,
                glw::GL_TEXTURE_2D,
                1,
                glw::GL_R32UI,
                WIDTH as glw::GLuint,
                HEIGHT as glw::GLuint,
                DEPTH,
                false,
            )?;
            // SAFETY: plain state change.
            unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, texture.id) };
            glu::expect_no_error(gl, "BindTexture")?;
            tex_sub_image_red_integer(
                gl,
                glw::GL_TEXTURE_2D,
                WIDTH as glw::GLuint,
                HEIGHT as glw::GLuint,
                DEPTH,
                &data,
            )?;
            textures.push(texture);
        }
        let texture_ids: Vec<glw::GLuint> = textures.iter().map(|texture| texture.id).collect();

        // SAFETY: plain state change.
        unsafe { gl.bind_texture(glw::GL_TEXTURE_2D, 0) };
        glu::expect_no_error(gl, "BindTexture")?;

        // SAFETY: `texture_ids` holds `max_textures` names.
        unsafe { gl.bind_textures(0, max_textures, texture_ids.as_ptr()) };
        glu::expect_no_error(gl, "BindTextures")?;

        let ssb_buffer = DataBuf::init_data(
            gl,
            glw::GL_SHADER_STORAGE_BUFFER,
            glw::GL_DYNAMIC_COPY,
            std::mem::size_of::<u32>() as glw::GLsizeiptr,
        )?;
        // SAFETY: a live buffer; `BindBase(0)` of upstream's Buffer.
        unsafe { gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, ssb_buffer.id) };
        glu::expect_no_error(gl, "BindBufferBase")?;

        let mut sam_position = 0;
        let mut sum_position = 0;
        let mut cs_source = CS.to_string();
        for i in 0..n {
            let sam_start_position = sam_position;
            let sum_start_position = sum_position;
            let index = i.to_string();

            replace_token(
                "SAMPLER_LIST",
                &mut sam_position,
                "SAMPLER\nSAMPLER_LIST",
                &mut cs_source,
            )?;
            sam_position = sam_start_position;
            replace_token("SAMPLER", &mut sam_position, SAMPLER, &mut cs_source)?;
            sam_position = sam_start_position;
            replace_token("XXX", &mut sam_position, &index, &mut cs_source)?;
            replace_token("XXX", &mut sam_position, &index, &mut cs_source)?;

            replace_token("SUM_LIST", &mut sum_position, "SAMPLING + SUM_LIST", &mut cs_source)?;
            sum_position = sum_start_position;
            replace_token("SAMPLING", &mut sum_position, SAMPLING, &mut cs_source)?;
            sum_position = sum_start_position;
            replace_token("XXX", &mut sum_position, &index, &mut cs_source)?;
        }
        replace_token(" + SUM_LIST", &mut sum_position, "", &mut cs_source)?;
        replace_token("SAMPLER_LIST", &mut sam_position, "", &mut cs_source)?;

        let _program = use_compute_program(gl, &cs_source)?;

        for i in 0..max_textures {
            // SAFETY: plain uniform update of the program in use.
            unsafe { gl.uniform_1i(i, i) };
            glu::expect_no_error(gl, "Uniform1i")?;
        }

        struct Samplers<'gl> {
            gl: &'gl glw::Functions,
            ids: Vec<glw::GLuint>,
        }
        impl Drop for Samplers<'_> {
            fn drop(&mut self) {
                // SAFETY: deletes the names this guard generated.
                unsafe {
                    self.gl
                        .delete_samplers(self.ids.len() as glw::GLsizei, self.ids.as_ptr())
                };
            }
        }

        let mut samplers = Samplers { gl, ids: vec![0; n] };
        // SAFETY: `max_textures` names are written to the live vector.
        unsafe { gl.gen_samplers(max_textures, samplers.ids.as_mut_ptr()) };
        glu::expect_no_error(gl, "GenSamplers")?;

        // SAFETY: the vector holds `max_textures` names.
        unsafe { gl.bind_samplers(0, max_textures, samplers.ids.as_ptr()) };
        glu::expect_no_error(gl, "BindSamplers")?;
        for sampler_id in &samplers.ids {
            // SAFETY: samplers generated above.
            unsafe {
                gl.sampler_parameteri(*sampler_id, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as glw::GLint);
                gl.sampler_parameteri(*sampler_id, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as glw::GLint);
                gl.sampler_parameteri(*sampler_id, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as glw::GLint);
            }
            glu::expect_no_error(gl, "SamplerParameteri")?;
        }

        // SAFETY: plain commands.
        unsafe {
            gl.dispatch_compute(1, 1, 1);
            glu::expect_no_error(gl, "DispatchCompute")?;
            gl.memory_barrier(glw::GL_ALL_BARRIER_BITS);
            glu::expect_no_error(gl, "MemoryBarrier")?;
        }

        // Remove the samplers before the readback, as upstream does.
        drop(samplers);

        // SAFETY: a read-only mapping of the buffer bound to GL_SHADER_STORAGE_BUFFER, which holds four bytes.
        let result = unsafe { gl.map_buffer(glw::GL_SHADER_STORAGE_BUFFER, glw::GL_READ_ONLY) };
        glu::expect_no_error(gl, "MapBuffer")?;
        // SAFETY: as above; the slice ends before the unmap.
        let test_result = unsafe { std::slice::from_raw_parts(result.cast::<u8>(), std::mem::size_of::<glw::GLint>()) }
            == max_textures.to_ne_bytes();
        // SAFETY: the buffer is mapped; the error, if any, is ignored as upstream does.
        unsafe {
            gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER);
            gl.get_error();
        }

        Ok(if test_result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `DrawBindVertexBuffersTest`
struct DrawBindVertexBuffersTest;

impl TestCase for DrawBindVertexBuffersTest {
    fn name(&self) -> &str {
        "draw_bind_vertex_buffers"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const VS: &str = "#version 440 core\n\nATTRIBUTE_LIST\n\nout vec4 vs_gs_sum;\n\nvoid main()\n{\n    vs_gs_sum = SUM_LIST;\n}\n\n";
        const GS: &str = "#version 440 core\n\nlayout(points)                           in;\nlayout(triangle_strip, max_vertices = 4) out;\n\nin  vec4 vs_gs_sum[];\nout vec4 gs_fs_sum;\n\nvoid main()\n{\n    gs_fs_sum   = vs_gs_sum[0];\n    gl_Position = vec4(-1, -1, 0, 1);\n    EmitVertex();\n    gs_fs_sum   = vs_gs_sum[0];\n    gl_Position = vec4(-1, 1, 0, 1);\n    EmitVertex();\n    gs_fs_sum   = vs_gs_sum[0];\n    gl_Position = vec4(1, -1, 0, 1);\n    EmitVertex();\n    gs_fs_sum   = vs_gs_sum[0];\n    gl_Position = vec4(1, 1, 0, 1);\n    EmitVertex();\n}\n\n";
        const FS: &str = "#version 440 core\n\nin  vec4 gs_fs_sum;\nout vec4 fs_out;\n\nvoid main()\n{\n    fs_out = gs_fs_sum;\n}\n\n";
        const ATTRIBUTE: &str = "layout (location = XXX) in vec4 aXXX;";
        const HEIGHT: usize = 8;
        const WIDTH: usize = 8;
        const ATTRIBUTE_SIZE: glw::GLintptr = 4 * std::mem::size_of::<f32>() as glw::GLintptr;
        let gl = context.gl();
        let mut test_result = true;
        let mut max_buffers: glw::GLint = 0;

        // SAFETY: the value is written to a live local.
        unsafe { gl.get_integerv(glw::GL_MAX_VERTEX_ATTRIB_BINDINGS, &mut max_buffers) };
        glu::expect_no_error(gl, "GetIntegerv")?;
        let n = max_buffers as usize;

        // Every attribute reads `value`, so the sum of all of them is one.
        let value = 1.0f32 / max_buffers as f32;
        let data = vec![value; n * 4];

        let buffer = DataBuf::init_data_from(
            gl,
            glw::GL_ARRAY_BUFFER,
            glw::GL_DYNAMIC_COPY,
            (data.len() * std::mem::size_of::<f32>()) as glw::GLsizeiptr,
            data.as_ptr().cast(),
        )?;
        let buffer_ids = vec![buffer.id; n];
        let offsets: Vec<glw::GLintptr> = (0..n).map(|i| i as glw::GLintptr * ATTRIBUTE_SIZE).collect();
        let strides = vec![ATTRIBUTE_SIZE as glw::GLsizei; n];

        // Framebuffer with a texture to draw to
        struct Fbo<'gl> {
            gl: &'gl glw::Functions,
            id: glw::GLuint,
        }
        impl Drop for Fbo<'_> {
            fn drop(&mut self) {
                // SAFETY: deletes the name this guard generated.
                unsafe { self.gl.delete_framebuffers(1, &self.id) };
            }
        }

        let texture = MbTex::init_storage(
            gl,
            glw::GL_TEXTURE_2D,
            1,
            glw::GL_RGBA8,
            WIDTH as glw::GLuint,
            HEIGHT as glw::GLuint,
            1,
            false,
        )?;
        let mut framebuffer = Fbo { gl, id: 0 };
        // SAFETY: names written to live fields and objects generated here.
        unsafe {
            gl.gen_framebuffers(1, &mut framebuffer.id);
            glu::expect_no_error(gl, "GenFramebuffers")?;
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, framebuffer.id);
            glu::expect_no_error(gl, "BindFramebuffer")?;
            gl.framebuffer_texture(glw::GL_DRAW_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, texture.id, 0);
            glu::expect_no_error(gl, "FramebufferTexture")?;
            gl.viewport(0, 0, WIDTH as glw::GLsizei, HEIGHT as glw::GLsizei);
            glu::expect_no_error(gl, "Viewport")?;
        }

        // Program
        let mut attr_position = 0;
        let mut sum_position = 0;
        let mut vs_source = VS.to_string();
        for i in 0..n {
            let attr_start_position = attr_position;
            let sum_start_position = sum_position;
            let index = i.to_string();

            replace_token(
                "ATTRIBUTE_LIST",
                &mut attr_position,
                "ATTRIBUTE\nATTRIBUTE_LIST",
                &mut vs_source,
            )?;
            attr_position = attr_start_position;
            replace_token("ATTRIBUTE", &mut attr_position, ATTRIBUTE, &mut vs_source)?;
            attr_position = attr_start_position;
            replace_token("XXX", &mut attr_position, &index, &mut vs_source)?;
            replace_token("XXX", &mut attr_position, &index, &mut vs_source)?;

            replace_token("SUM_LIST", &mut sum_position, "aXXX + SUM_LIST", &mut vs_source)?;
            sum_position = sum_start_position;
            replace_token("XXX", &mut sum_position, &index, &mut vs_source)?;
        }
        replace_token(" + SUM_LIST", &mut sum_position, "", &mut vs_source)?;
        replace_token("ATTRIBUTE_LIST", &mut attr_position, "", &mut vs_source)?;

        let fragment = Shader::new(gl, glw::GL_FRAGMENT_SHADER)?;
        let geometry = Shader::new(gl, glw::GL_GEOMETRY_SHADER)?;
        let vertex = Shader::new(gl, glw::GL_VERTEX_SHADER)?;
        let program = Program::new(gl)?;
        for (shader, source) in [(&fragment, FS), (&geometry, GS), (&vertex, vs_source.as_str())] {
            shader.source(&[source])?;
            if !shader.compile()? {
                return Err(TestError::Fail("Failed to compile shader".to_string()));
            }
            program.attach(shader)?;
        }
        if !program.link()? {
            return Err(TestError::Fail("Failed to link program".to_string()));
        }
        // SAFETY: a live, linked program.
        unsafe { gl.use_program(program.id) };
        glu::expect_no_error(gl, "UseProgram")?;

        struct Vao<'gl> {
            gl: &'gl glw::Functions,
            id: glw::GLuint,
        }
        impl Drop for Vao<'_> {
            fn drop(&mut self) {
                // SAFETY: deletes the name this guard generated.
                unsafe { self.gl.delete_vertex_arrays(1, &self.id) };
            }
        }

        let mut vao = Vao { gl, id: 0 };
        // SAFETY: one name is written to the live field.
        unsafe { gl.gen_vertex_arrays(1, &mut vao.id) };
        glu::expect_no_error(gl, "GenVertexArrays")?;

        // SAFETY: the vertex array was generated above; the vectors hold `max_buffers` entries.
        unsafe {
            gl.bind_vertex_array(vao.id);
            glu::expect_no_error(gl, "BindVertexArrays")?;
            for i in 0..max_buffers {
                gl.enable_vertex_attrib_array(i as glw::GLuint);
                glu::expect_no_error(gl, "EnableVertexAttribArray")?;
            }

            gl.bind_vertex_buffers(0, max_buffers, buffer_ids.as_ptr(), offsets.as_ptr(), strides.as_ptr());
            glu::expect_no_error(gl, "BindVertexBuffers")?;

            gl.draw_arrays(glw::GL_POINTS, 0, 1);
            glu::expect_no_error(gl, "DrawArrays")?;
            for i in 0..max_buffers {
                gl.disable_vertex_attrib_array(i as glw::GLuint);
                glu::expect_no_error(gl, "DisableVertexAttribArray")?;
            }
        }

        drop(vao);
        glu::expect_no_error(gl, "DeleteVertexArrays")?;

        // Verify results
        let mut pixels = [0u32; WIDTH * HEIGHT];
        // SAFETY: `pixels` holds one RGBA8 value per texel of the bound level.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D, texture.id);
            glu::expect_no_error(gl, "BindTexture")?;
            gl.get_tex_image(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                pixels.as_mut_ptr().cast(),
            );
            glu::expect_no_error(gl, "GetTexImage")?;
            gl.bind_texture(glw::GL_TEXTURE_2D, 0);
            glu::expect_no_error(gl, "BindTexture")?;
        }

        if let Some((offset, pixel)) = pixels.iter().enumerate().find(|(_, pixel)| **pixel != 0xffffffff) {
            log::info!("Invalid value: {pixel} at offset: {offset}");
            test_result = false;
        }

        Ok(if test_result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `MultiBindTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("multi_bind");
    group.add_child(Box::new(DispatchBindTexturesTest) as Box<dyn TestCase>);
    group.add_child(Box::new(ErrorsBindBuffersTest) as Box<dyn TestCase>);
    group.add_child(Box::new(ErrorsBindTexturesTest) as Box<dyn TestCase>);
    group.add_child(Box::new(ErrorsBindSamplersTest) as Box<dyn TestCase>);
    group.add_child(Box::new(ErrorsBindImageTexturesTest) as Box<dyn TestCase>);
    group.add_child(Box::new(ErrorsBindVertexBuffersTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FunctionalBindBuffersBaseTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FunctionalBindBuffersRangeTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FunctionalBindTexturesTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FunctionalBindSamplersTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FunctionalBindImageTexturesTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FunctionalBindVertexBuffersTest) as Box<dyn TestCase>);
    group.add_child(Box::new(DispatchBindBuffersBaseTest) as Box<dyn TestCase>);
    group.add_child(Box::new(DispatchBindBuffersRangeTest) as Box<dyn TestCase>);
    group.add_child(Box::new(DispatchBindImageTexturesTest) as Box<dyn TestCase>);
    group.add_child(Box::new(DispatchBindSamplersTest) as Box<dyn TestCase>);
    group.add_child(Box::new(DrawBindVertexBuffersTest) as Box<dyn TestCase>);
    group
}
