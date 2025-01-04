// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcShaderImageLoadStoreTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. all 39 cases of the group are ported (`formats`, `all_targets` and `machines` hold the allFormats, allTargets and the stage-machine ones); the shaders keep their `#version 310 es` header, which a desktop context accepts through GL_ARB_ES3_1_compatibility.

/// A GL call with a current context and with pointers into live locals.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call below is made with a current context and with pointers into live locals or buffers of the right size.
        unsafe { $call }
    };
}

use std::ffi::CString;

use super::subcase::{ERROR, NO_ERROR, NOT_SUPPORTED, Subcase, SubcaseResult, TestSubcase, output_not_supported};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};

const GLSL_VER: &str = "#version 310 es";
const GLSL_PREC: &str = "\nprecision highp float;\nprecision highp int;\nprecision highp sampler2D;\nprecision highp sampler3D;\nprecision highp samplerCube;\nprecision highp sampler2DArray;\nprecision highp isampler2D;\nprecision highp isampler3D;\nprecision highp isamplerCube;\nprecision highp isampler2DArray;\nprecision highp usampler2D;\nprecision highp usampler3D;\nprecision highp usamplerCube;\nprecision highp usampler2DArray;\nprecision highp image2D;\nprecision highp image3D;\nprecision highp imageCube;\nprecision highp image2DArray;\nprecision highp iimage2D;\nprecision highp iimage3D;\nprecision highp iimageCube;\nprecision highp iimage2DArray;\nprecision highp uimage2D;\nprecision highp uimage3D;\nprecision highp uimageCube;\nprecision highp uimage2DArray;";

mod all_targets;
mod formats;
mod machines;

/// `ShaderImageLoadStoreBase::IsVSFSAvailable`
fn is_vsfs_available(gl: &glw::Functions, required_vs: i32, required_fs: i32) -> bool {
    let (images_vs, images_fs) = (
        get_integer(gl, glw::GL_MAX_VERTEX_IMAGE_UNIFORMS),
        get_integer(gl, glw::GL_MAX_FRAGMENT_IMAGE_UNIFORMS),
    );
    if images_vs >= required_vs && images_fs >= required_fs {
        return true;
    }
    output_not_supported(&format!(
        "Required {required_vs} VS image uniforms but only {images_vs} available.\nRequired {required_fs} FS image uniforms but only {images_fs} available.\n"
    ));
    false
}

fn get_integer(gl: &glw::Functions, pname: GLenum) -> GLint {
    let mut value = 0;
    gl!(gl.get_integerv(pname, &mut value));
    value
}

fn shader_source(gl: &glw::Functions, shader: GLuint, parts: &[&str]) {
    let pointers: Vec<*const glw::GLchar> = parts.iter().map(|part| part.as_ptr().cast()).collect();
    let lengths: Vec<GLint> = parts.iter().map(|part| part.len() as GLint).collect();
    gl!(gl.shader_source(shader, parts.len() as glw::GLsizei, pointers.as_ptr(), lengths.as_ptr()));
}

fn shader_status(gl: &glw::Functions, shader: GLuint) -> GLint {
    let mut status = 0;
    gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut status));
    status
}

fn program_status(gl: &glw::Functions, program: GLuint) -> GLint {
    let mut status = 0;
    gl!(gl.get_programiv(program, glw::GL_LINK_STATUS, &mut status));
    status
}

/// `ShaderImageLoadStoreBase::CompileShader`
fn compile_shader(gl: &glw::Functions, shader: GLuint) -> bool {
    gl!(gl.compile_shader(shader));
    if shader_status(gl, shader) == glw::GL_FALSE as GLint {
        let mut log = [0u8; 1024];
        let mut length: glw::GLsizei = 0;
        gl!(gl.get_shader_info_log(shader, log.len() as glw::GLsizei, &mut length, log.as_mut_ptr().cast()));
        if length > 1 {
            log::info!("Shader Info Log:\n{}", String::from_utf8_lossy(&log[..length as usize]));
        }
        return false;
    }
    true
}

/// `ShaderImageLoadStoreBase::LinkProgram`
fn link_program(gl: &glw::Functions, program: GLuint) -> bool {
    gl!(gl.link_program(program));
    if program_status(gl, program) == glw::GL_FALSE as GLint {
        let mut log = [0u8; 1024];
        let mut length: glw::GLsizei = 0;
        gl!(gl.get_program_info_log(program, log.len() as glw::GLsizei, &mut length, log.as_mut_ptr().cast()));
        if length > 1 {
            log::info!(
                "Program Info Log:\n{}",
                String::from_utf8_lossy(&log[..length as usize])
            );
        }
        return false;
    }
    true
}

/// One stage of `BuildProgram` and `CreateComputeProgram`: false when it did not compile (the program is returned as it is).
fn attach_stage(gl: &glw::Functions, program: GLuint, shader_type: GLenum, header: &str, source: &str) -> bool {
    let shader = gl!(gl.create_shader(shader_type));
    gl!(gl.attach_shader(program, shader));
    gl!(gl.delete_shader(shader));
    shader_source(gl, shader, &[header, source]);
    if !compile_shader(gl, shader) {
        log::info!("{header}{source}");
        return false;
    }
    true
}

/// `ShaderImageLoadStoreBase::BuildProgram` without the image atomic extension
fn build_program(gl: &glw::Functions, src_vs: Option<&str>, src_fs: Option<&str>) -> GLuint {
    let header = format!("{GLSL_VER}\n{GLSL_PREC}");
    let program = gl!(gl.create_program());
    if let Some(src_vs) = src_vs
        && !attach_stage(gl, program, glw::GL_VERTEX_SHADER, &header, src_vs)
    {
        return program;
    }
    if let Some(src_fs) = src_fs
        && !attach_stage(gl, program, glw::GL_FRAGMENT_SHADER, &header, src_fs)
    {
        return program;
    }
    if !link_program(gl, program) {
        if let Some(src_vs) = src_vs {
            log::info!("{GLSL_VER}{src_vs}");
        }
        if let Some(src_fs) = src_fs {
            log::info!("{GLSL_VER}{src_fs}");
        }
    }
    program
}

/// `ShaderImageLoadStoreBase::CreateComputeProgram` (the program is linked by the caller of `LinkProgram`, here inside as upstream)
fn create_compute_program(gl: &glw::Functions, cs: &str) -> GLuint {
    let header = format!("{GLSL_VER}\n{GLSL_PREC}");
    let program = gl!(gl.create_program());
    if !cs.is_empty() && !attach_stage(gl, program, glw::GL_COMPUTE_SHADER, &header, cs) {
        return program;
    }
    if !link_program(gl, program) && !cs.is_empty() {
        log::info!("{header}{cs}");
    }
    program
}

fn uniform_location(gl: &glw::Functions, program: GLuint, name: &str) -> GLint {
    let name = CString::new(name).expect("no NUL in the name");
    gl!(gl.get_uniform_location(program, name.as_ptr()))
}

/// `ShaderImageLoadStoreBase::CheckMax`
fn check_max(gl: &glw::Functions, pname: GLenum, min_value: GLint) -> bool {
    let mut i: GLint = 0;
    gl!(gl.get_integerv(pname, &mut i));
    if i < min_value {
        return false;
    }
    let mut b: glw::GLboolean = 0;
    gl!(gl.get_booleanv(pname, &mut b));
    if b != if i != 0 { glw::TRUE } else { glw::FALSE } {
        return false;
    }
    let mut f: glw::GLfloat = 0.0;
    gl!(gl.get_floatv(pname, &mut f));
    if f < min_value as glw::GLfloat {
        return false;
    }
    let mut i64_value: glw::GLint64 = 0;
    gl!(gl.get_integer_64v(pname, &mut i64_value));
    i64_value >= min_value as glw::GLint64
}

/// `ShaderImageLoadStoreBase::CheckBinding`
fn check_binding(
    gl: &glw::Functions,
    unit: GLuint,
    texture: GLuint,
    level: GLint,
    layered: glw::GLboolean,
    layer: GLint,
    access: GLenum,
    format: GLenum,
) -> bool {
    let mut i: GLint = 0;
    gl!(gl.get_integeri_v(glw::GL_IMAGE_BINDING_NAME, unit, &mut i));
    if i as GLuint != texture {
        log::info!("GL_IMAGE_BINDING_NAME is {i} should be {texture}");
        return false;
    }
    gl!(gl.get_integeri_v(glw::GL_IMAGE_BINDING_LEVEL, unit, &mut i));
    if i != level {
        log::info!("GL_IMAGE_BINDING_LEVEL is {i} should be {level}");
        return false;
    }
    let mut b: glw::GLboolean = 0;
    gl!(gl.get_integeri_v(glw::GL_IMAGE_BINDING_LAYERED, unit, &mut i));
    gl!(gl.get_booleani_v(glw::GL_IMAGE_BINDING_LAYERED, unit, &mut b));
    if i != layered as GLint || b != layered {
        log::info!("GL_IMAGE_BINDING_LAYERED is {i} should be {layered}");
        return false;
    }
    gl!(gl.get_integeri_v(glw::GL_IMAGE_BINDING_LAYER, unit, &mut i));
    if i != layer {
        log::info!("GL_IMAGE_BINDING_LAYER is {i} should be {layer}");
        return false;
    }
    gl!(gl.get_integeri_v(glw::GL_IMAGE_BINDING_ACCESS, unit, &mut i));
    if i as GLenum != access {
        log::info!("GL_IMAGE_BINDING_ACCESS is {i} should be {access}");
        return false;
    }
    gl!(gl.get_integeri_v(glw::GL_IMAGE_BINDING_FORMAT, unit, &mut i));
    if i as GLenum != format {
        log::info!("GL_IMAGE_BINDING_FORMAT is {i} should be {format}");
        return false;
    }
    true
}

fn is_at_least_gl_45(context: &Context) -> bool {
    context.context_type().supports_core(4, 5)
}

fn result(status: bool) -> SubcaseResult {
    Ok(if status { NO_ERROR } else { ERROR })
}

/// 1.1 BasicAPIGet
#[derive(Default)]
struct BasicApiGet;

impl Subcase for BasicApiGet {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        for (pname, min_value, name) in [
            (glw::GL_MAX_IMAGE_UNITS, 4, "GL_MAX_IMAGE_UNITS"),
            (
                glw::GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES,
                4,
                "GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES",
            ),
            (glw::GL_MAX_VERTEX_IMAGE_UNIFORMS, 0, "GL_MAX_VERTEX_IMAGE_UNIFORMS"),
            (glw::GL_MAX_FRAGMENT_IMAGE_UNIFORMS, 0, "GL_MAX_FRAGMENT_IMAGE_UNIFORMS"),
            (glw::GL_MAX_COMBINED_IMAGE_UNIFORMS, 4, "GL_MAX_COMBINED_IMAGE_UNIFORMS"),
            (glw::GL_MAX_COMPUTE_IMAGE_UNIFORMS, 4, "GL_MAX_COMPUTE_IMAGE_UNIFORMS"),
        ] {
            if !check_max(gl, pname, min_value) {
                log::info!("{name} value is invalid.");
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }
}

/// 1.2 BasicAPIBind
#[derive(Default)]
struct BasicApiBind {
    texture: GLuint,
}

impl Subcase for BasicApiBind {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut status = true;
        let format = if is_at_least_gl_45(context) {
            glw::GL_R8
        } else {
            glw::GL_R32UI
        };

        for index in 0..4 {
            if !check_binding(gl, index, 0, 0, glw::FALSE, 0, glw::GL_READ_ONLY, format) {
                log::info!("Binding point {index} has invalid default state.");
                status = false;
            }
        }

        gl!(gl.gen_textures(1, &mut self.texture));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, self.texture));
        gl!(gl.tex_storage_3d(glw::GL_TEXTURE_2D_ARRAY, 4, glw::GL_RG32F, 16, 16, 4));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, 0));

        for (unit, level, layered, layer, access, format) in [
            (0, 0, glw::FALSE, 0, glw::GL_READ_WRITE, glw::GL_R32F),
            (3, 1, glw::TRUE, 1, glw::GL_WRITE_ONLY, glw::GL_RGBA8),
            (1, 3, glw::FALSE, 2, glw::GL_READ_WRITE, glw::GL_RGBA8UI),
            (2, 4, glw::FALSE, 3, glw::GL_READ_ONLY, glw::GL_R32I),
        ] {
            gl!(gl.bind_image_texture(unit, self.texture, level, layered, layer, access, format));
            if !check_binding(gl, unit, self.texture, level, layered, layer, access, format) {
                status = false;
            }
        }

        gl!(gl.delete_textures(1, &self.texture));
        self.texture = 0;

        for index in 0..4 {
            let mut name: GLint = 0;
            gl!(gl.get_integeri_v(glw::GL_IMAGE_BINDING_NAME, index, &mut name));
            if name != 0 {
                log::info!(
                    "Binding point {index} should have no texture bound after the texture was deleted, but GL_IMAGE_BINDING_NAME is {name}."
                );
                status = false;
            }
            if !check_binding(gl, index, 0, 0, glw::FALSE, 0, glw::GL_READ_ONLY, format) {
                status = false;
            }
        }
        result(status)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().delete_textures(1, &self.texture));
        Ok(NO_ERROR)
    }
}

/// 1.3 BasicAPIBarrier
#[derive(Default)]
struct BasicApiBarrier;

impl Subcase for BasicApiBarrier {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let bits = [
            glw::GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT,
            glw::GL_ELEMENT_ARRAY_BARRIER_BIT,
            glw::GL_UNIFORM_BARRIER_BIT,
            glw::GL_TEXTURE_FETCH_BARRIER_BIT,
            glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT,
            glw::GL_COMMAND_BARRIER_BIT,
            glw::GL_PIXEL_BUFFER_BARRIER_BIT,
            glw::GL_TEXTURE_UPDATE_BARRIER_BIT,
            glw::GL_BUFFER_UPDATE_BARRIER_BIT,
            glw::GL_FRAMEBUFFER_BARRIER_BIT,
            glw::GL_TRANSFORM_FEEDBACK_BARRIER_BIT,
            glw::GL_ATOMIC_COUNTER_BARRIER_BIT,
            glw::GL_SHADER_STORAGE_BARRIER_BIT,
        ];
        for bit in bits {
            gl!(gl.memory_barrier(bit));
        }
        gl!(gl.memory_barrier(bits.iter().fold(0, |all, bit| all | bit)));
        gl!(gl.memory_barrier(glw::GL_ALL_BARRIER_BITS));
        Ok(NO_ERROR)
    }
}

/// 1.4 BasicAPIBarrierByRegion
#[derive(Default)]
struct BasicApiBarrierByRegion;

impl Subcase for BasicApiBarrierByRegion {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let bits = [
            glw::GL_UNIFORM_BARRIER_BIT,
            glw::GL_TEXTURE_FETCH_BARRIER_BIT,
            glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT,
            glw::GL_FRAMEBUFFER_BARRIER_BIT,
            glw::GL_ATOMIC_COUNTER_BARRIER_BIT,
            glw::GL_SHADER_STORAGE_BARRIER_BIT,
        ];
        for bit in bits {
            gl!(gl.memory_barrier_by_region(bit));
        }
        gl!(gl.memory_barrier_by_region(bits.iter().fold(0, |all, bit| all | bit)));
        gl!(gl.memory_barrier_by_region(glw::GL_ALL_BARRIER_BITS));
        Ok(NO_ERROR)
    }
}

/// 1.5 BasicAPITexParam
#[derive(Default)]
struct BasicApiTexParam {
    texture: GLuint,
}

impl Subcase for BasicApiTexParam {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_textures(1, &mut self.texture));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture));
        gl!(gl.tex_storage_2d(glw::GL_TEXTURE_2D, 5, glw::GL_RG32F, 16, 16));

        let mut i: GLint = 0;
        let mut f: glw::GLfloat = 0.0;
        gl!(gl.get_tex_parameteriv(glw::GL_TEXTURE_2D, glw::GL_IMAGE_FORMAT_COMPATIBILITY_TYPE, &mut i));
        if i as GLenum != glw::GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE {
            log::info!(
                "GL_IMAGE_FORMAT_COMPATIBILITY_TYPE should equal to GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE for textures allocated by the GL."
            );
            return Ok(ERROR);
        }
        gl!(gl.get_tex_parameterfv(glw::GL_TEXTURE_2D, glw::GL_IMAGE_FORMAT_COMPATIBILITY_TYPE, &mut f));
        if f as GLenum != glw::GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE {
            log::info!(
                "GL_IMAGE_FORMAT_COMPATIBILITY_TYPE should equal to GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE for textures allocated by the GL."
            );
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().delete_textures(1, &self.texture));
        Ok(NO_ERROR)
    }
}

/// `ShaderImageLoadStoreBase::IsSSBInVSFSAvailable`
fn is_ssb_in_vsfs_available(gl: &glw::Functions, required_vs: i32, required_fs: i32) -> bool {
    let (blocks_vs, blocks_fs) = (
        get_integer(gl, glw::GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS),
        get_integer(gl, glw::GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS),
    );
    if blocks_vs >= required_vs && blocks_fs >= required_fs {
        return true;
    }
    output_not_supported(&format!(
        "Required {required_vs} VS storage blocks but only {blocks_vs} available.\nRequired {required_fs} FS storage blocks but only {blocks_fs} available.\n"
    ));
    false
}

/// `ShaderImageLoadStoreBase::CreateFullViewportQuad`
fn create_full_viewport_quad(gl: &glw::Functions, vao: &mut GLuint, vbo: &mut GLuint, mut ebo: Option<&mut GLuint>) {
    // Interleaved data (vertex, color0 (green), color1 (blue), color2 (red)).
    const VERTICES: [f32; 44] = [
        -1.0, -1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0, -1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0,
        0.0, -1.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0,
        0.0,
    ];
    let float_size = std::mem::size_of::<f32>();
    gl!(gl.gen_buffers(1, vbo));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, *vbo));
    gl!(gl.buffer_data(
        glw::GL_ARRAY_BUFFER,
        std::mem::size_of_val(&VERTICES) as glw::GLsizeiptr,
        VERTICES.as_ptr().cast(),
        glw::GL_STATIC_DRAW
    ));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    if let Some(ebo) = &mut ebo {
        let index_data: [glw::GLushort; 4] = [0, 1, 2, 3];
        gl!(gl.gen_buffers(1, &mut **ebo));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, **ebo));
        gl!(gl.buffer_data(
            glw::GL_ELEMENT_ARRAY_BUFFER,
            std::mem::size_of_val(&index_data) as glw::GLsizeiptr,
            index_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0));
    }

    gl!(gl.gen_vertex_arrays(1, vao));
    gl!(gl.bind_vertex_array(*vao));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, *vbo));
    let stride = (float_size * 11) as glw::GLsizei;
    gl!(gl.vertex_attrib_pointer(0, 2, glw::GL_FLOAT, glw::FALSE, stride, std::ptr::null()));
    gl!(gl.vertex_attrib_pointer(
        1,
        3,
        glw::GL_FLOAT,
        glw::FALSE,
        stride,
        (float_size * 2) as *const std::ffi::c_void
    ));
    gl!(gl.vertex_attrib_pointer(
        2,
        3,
        glw::GL_FLOAT,
        glw::FALSE,
        stride,
        (float_size * 5) as *const std::ffi::c_void
    ));
    gl!(gl.vertex_attrib_pointer(
        3,
        3,
        glw::GL_FLOAT,
        glw::FALSE,
        stride,
        (float_size * 8) as *const std::ffi::c_void
    ));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
    for index in 0..4 {
        gl!(gl.enable_vertex_attrib_array(index));
    }
    if let Some(ebo) = &ebo {
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, **ebo));
    }
    gl!(gl.bind_vertex_array(0));
}

/// One `glTexParameteri` pair and the storage of a texture of the misc/early-fragment-test cases, filled with `data`.
fn nearest_filtering(gl: &glw::Functions, target: GLenum) {
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
}

fn window_size(context: &Context) -> (GLint, GLint) {
    let target = context.render_target();
    (target.width, target.height)
}

/// Maps the shader storage buffer read-only; `None` when the mapping failed.
fn map_ssbo<'a, T: Copy>(gl: &glw::Functions, count: usize) -> Option<&'a [T]> {
    let pointer = gl!(gl.map_buffer_range(
        glw::GL_SHADER_STORAGE_BUFFER,
        0,
        (count * std::mem::size_of::<T>()) as glw::GLsizeiptr,
        glw::GL_MAP_READ_BIT
    )) as *const T;
    if pointer.is_null() {
        return None;
    }
    // SAFETY: the mapping covers `count` elements of `T` and stays valid until the buffer is unmapped or deleted, which happens after the last read.
    Some(unsafe { std::slice::from_raw_parts(pointer, count) })
}

/// 3.1 BasicGLSLMiscFS
#[derive(Default)]
struct BasicGlslMiscFs {
    texture: GLuint,
    program: GLuint,
    vao: GLuint,
    vbo: GLuint,
    buffer: GLuint,
}

impl Subcase for BasicGlslMiscFs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 0, 2) || !is_ssb_in_vsfs_available(gl, 0, 1) {
            return Ok(NOT_SUPPORTED);
        }

        const SIZE: usize = 32;
        let data = vec![0.0f32; SIZE * SIZE * 4];
        gl!(gl.gen_textures(1, &mut self.texture));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, self.texture));
        nearest_filtering(gl, glw::GL_TEXTURE_2D_ARRAY);
        gl!(gl.tex_storage_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            1,
            glw::GL_R32F,
            SIZE as glw::GLsizei,
            SIZE as glw::GLsizei,
            4
        ));
        gl!(gl.tex_sub_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            0,
            0,
            0,
            SIZE as glw::GLsizei,
            SIZE as glw::GLsizei,
            4,
            glw::GL_RED,
            glw::GL_FLOAT,
            data.as_ptr().cast()
        ));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, 0));

        let src_vs = "\nlayout(location = 0) in vec4 i_position;\nvoid main() {\n  gl_Position = i_position;\n}";
        let src_fs = "\n#define KSIZE 32\nlayout(std430) buffer out_data {\n  ivec4 o_color[KSIZE*KSIZE];\n};\nlayout(r32f, binding = 0) coherent restrict uniform image2D g_image_layer0;\nlayout(r32f, binding = 1) volatile uniform image2D g_image_layer1;\nvoid main() {\n  ivec2 coord = ivec2(gl_FragCoord.xy);\n  imageStore(g_image_layer0, coord, vec4(1.0));\n  memoryBarrier();\n  imageStore(g_image_layer1, coord, vec4(2.0));\n  memoryBarrier();\n  imageStore(g_image_layer0, coord, vec4(3.0));\n  memoryBarrier();\n  int coordIndex = coord.x + KSIZE * coord.y;\n  o_color[coordIndex] = ivec4(imageLoad(g_image_layer0, coord) + imageLoad(g_image_layer1, coord));\n}";
        self.program = build_program(gl, Some(src_vs), Some(src_fs));
        create_full_viewport_quad(gl, &mut self.vao, &mut self.vbo, None);

        gl!(gl.bind_image_texture(0, self.texture, 0, glw::FALSE, 0, glw::GL_READ_WRITE, glw::GL_R32F));
        gl!(gl.bind_image_texture(1, self.texture, 0, glw::FALSE, 1, glw::GL_READ_WRITE, glw::GL_R32F));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.viewport(0, 0, SIZE as glw::GLsizei, SIZE as glw::GLsizei));

        let o_data = vec![0 as GLint; SIZE * SIZE * 4];
        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (SIZE * SIZE * 4 * 4) as glw::GLsizeiptr,
            o_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));

        gl!(gl.use_program(self.program));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let Some(out_data) = map_ssbo::<GLint>(gl, SIZE * SIZE * 4) else {
            return Ok(ERROR);
        };
        let mut status = true;
        for (i, texel) in out_data.chunks_exact(4).enumerate() {
            if texel != [5, 0, 0, 2] {
                status = false;
                log::info!("Value at index {i} is {texel:?} should be [5, 0, 0, 2].");
            }
        }
        result(status)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let (width, height) = window_size(context);
        gl!(gl.viewport(0, 0, width, height));
        gl!(gl.delete_textures(1, &self.texture));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.vbo));
        gl!(gl.delete_buffers(1, &self.buffer));
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        Ok(NO_ERROR)
    }
}

/// 3.2 BasicGLSLMiscCS
#[derive(Default)]
struct BasicGlslMiscCs {
    texture: GLuint,
    program: GLuint,
    buffer: GLuint,
}

impl Subcase for BasicGlslMiscCs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        const SIZE: usize = 10;
        let data = vec![0.0f32; SIZE * SIZE * 4];
        gl!(gl.gen_textures(1, &mut self.texture));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, self.texture));
        nearest_filtering(gl, glw::GL_TEXTURE_2D_ARRAY);
        gl!(gl.tex_storage_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            1,
            glw::GL_R32F,
            SIZE as glw::GLsizei,
            SIZE as glw::GLsizei,
            4
        ));
        gl!(gl.tex_sub_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            0,
            0,
            0,
            SIZE as glw::GLsizei,
            SIZE as glw::GLsizei,
            4,
            glw::GL_RED,
            glw::GL_FLOAT,
            data.as_ptr().cast()
        ));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, 0));

        let src_cs = "\n#define KSIZE 10\nlayout (local_size_x = KSIZE, local_size_y = KSIZE) in;\nlayout(std430) buffer out_data {\n  ivec4 o_color[KSIZE*KSIZE];\n};\nlayout(r32f, binding = 0) coherent restrict uniform image2D g_image_layer0;\nlayout(r32f, binding = 1) volatile uniform image2D g_image_layer1;\nvoid main() {\n  ivec2 coord = ivec2(gl_LocalInvocationID.xy);\n  imageStore(g_image_layer0, coord, vec4(1.0));\n  memoryBarrier();\n  imageStore(g_image_layer1, coord, vec4(2.0));\n  memoryBarrier();\n  imageStore(g_image_layer0, coord, vec4(3.0));\n  memoryBarrier();\n  o_color[gl_LocalInvocationIndex] = ivec4(imageLoad(g_image_layer0, coord) + imageLoad(g_image_layer1, coord));\n}";
        self.program = create_compute_program(gl, src_cs);

        gl!(gl.bind_image_texture(0, self.texture, 0, glw::FALSE, 0, glw::GL_READ_WRITE, glw::GL_R32F));
        gl!(gl.bind_image_texture(1, self.texture, 0, glw::FALSE, 1, glw::GL_READ_WRITE, glw::GL_R32F));

        let o_data = vec![0 as GLint; SIZE * SIZE * 4];
        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (SIZE * SIZE * 4 * 4) as glw::GLsizeiptr,
            o_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));

        gl!(gl.use_program(self.program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let Some(out_data) = map_ssbo::<GLint>(gl, SIZE * SIZE * 4) else {
            return Ok(ERROR);
        };
        let mut status = true;
        for (i, texel) in out_data.chunks_exact(4).enumerate() {
            if texel != [5, 0, 0, 2] {
                status = false;
                log::info!("Value at index {i} is {texel:?} should be [5, 0, 0, 2].");
            }
        }
        result(status)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_textures(1, &self.texture));
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.buffer));
        Ok(NO_ERROR)
    }
}

/// 3.3 BasicGLSLEarlyFragTests
#[derive(Default)]
struct BasicGlslEarlyFragTests {
    texture: [GLuint; 2],
    program: [GLuint; 2],
    vao: GLuint,
    vbo: GLuint,
    c_program: GLuint,
    buffer: GLuint,
}

impl Subcase for BasicGlslEarlyFragTests {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 0, 1) {
            return Ok(NOT_SUPPORTED);
        }

        const SIZE: usize = 8;
        let data = vec![0.0f32; SIZE * SIZE * 4];
        gl!(gl.gen_textures(2, self.texture.as_mut_ptr()));
        for texture in self.texture {
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture));
            nearest_filtering(gl, glw::GL_TEXTURE_2D);
            gl!(gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                1,
                glw::GL_RGBA32F,
                SIZE as glw::GLsizei,
                SIZE as glw::GLsizei
            ));
            gl!(gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                SIZE as glw::GLsizei,
                SIZE as glw::GLsizei,
                glw::GL_RGBA,
                glw::GL_FLOAT,
                data.as_ptr().cast()
            ));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        }

        let glsl_vs = "\nlayout(location = 0) in vec4 i_position;\nvoid main() {\n  gl_Position = i_position;\n}";
        let glsl_early_frag_tests_fs = "\nlayout(early_fragment_tests) in;\nlayout(location = 0) out vec4 o_color;\nlayout(rgba32f, binding = 0) writeonly coherent uniform image2D g_image;\nvoid main() {\n  ivec2 coord = ivec2(gl_FragCoord.xy);\n  imageStore(g_image, coord, vec4(17.0));\n  o_color = vec4(1.0, 0.0, 0.0, 1.0);\n}";
        let glsl_fs = "\nlayout(location = 0) out vec4 o_color;\nlayout(rgba32f, binding = 1) writeonly coherent uniform image2D g_image;\nvoid main() {\n  ivec2 coord = ivec2(gl_FragCoord.xy);\n  imageStore(g_image, coord, vec4(13.0));\n  o_color = vec4(1.0, 0.0, 0.0, 1.0);\n}";
        self.program[0] = build_program(gl, Some(glsl_vs), Some(glsl_early_frag_tests_fs));
        self.program[1] = build_program(gl, Some(glsl_vs), Some(glsl_fs));
        create_full_viewport_quad(gl, &mut self.vao, &mut self.vbo, None);

        gl!(gl.bind_image_texture(
            0,
            self.texture[0],
            0,
            glw::FALSE,
            0,
            glw::GL_READ_WRITE,
            glw::GL_RGBA32F
        ));
        gl!(gl.bind_image_texture(
            1,
            self.texture[1],
            0,
            glw::FALSE,
            0,
            glw::GL_READ_WRITE,
            glw::GL_RGBA32F
        ));
        gl!(gl.viewport(0, 0, SIZE as glw::GLsizei, SIZE as glw::GLsizei));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.enable(glw::GL_DEPTH_TEST));
        gl!(gl.clear_color(0.0, 1.0, 0.0, 1.0));
        gl!(gl.clear_depthf(0.0));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT));
        gl!(gl.use_program(self.program[0]));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT));
        gl!(gl.use_program(self.program[1]));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        let check_cs = "\n#define KSIZE 8\nlayout (local_size_x = KSIZE, local_size_y = KSIZE) in;\nuniform sampler2D g_sampler;\nlayout(std430) buffer OutputBuffer {\n  vec4 data[KSIZE*KSIZE];\n};\nvoid main() {\n  data[gl_LocalInvocationIndex] = texelFetch(g_sampler, ivec2(gl_LocalInvocationID), 0);\n}";
        self.c_program = create_compute_program(gl, check_cs);

        let out_data = vec![0.0f32; SIZE * SIZE * 4];
        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (SIZE * SIZE * 4 * 4) as glw::GLsizeiptr,
            out_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        gl!(gl.active_texture(glw::GL_TEXTURE5));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture[0]));
        gl!(gl.memory_barrier(glw::GL_TEXTURE_FETCH_BARRIER_BIT));
        gl!(gl.use_program(self.c_program));
        gl!(gl.uniform_1i(uniform_location(gl, self.c_program, "g_sampler"), 5));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        // Without a depth buffer the early tests cannot reject the fragments, so the image is written.
        let expected_value = if context.render_target().depth_bits == 0 {
            17.0f32
        } else {
            0.0f32
        };
        let Some(map_data) = map_ssbo::<f32>(gl, SIZE * SIZE * 4) else {
            return Ok(ERROR);
        };
        if map_data.iter().any(|value| *value != expected_value) {
            log::info!("The early fragment tests image does not contain {expected_value} everywhere.");
            return Ok(ERROR);
        }
        gl!(gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER));

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture[1]));
        gl!(gl.memory_barrier(glw::GL_TEXTURE_FETCH_BARRIER_BIT));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        let Some(map_data) = map_ssbo::<f32>(gl, SIZE * SIZE * 4) else {
            return Ok(ERROR);
        };
        if map_data.iter().any(|value| *value != 13.0) {
            log::info!("The image of the shader without early fragment tests does not contain 13 everywhere.");
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.disable(glw::GL_DEPTH_TEST));
        gl!(gl.clear_color(0.0, 0.0, 0.0, 0.0));
        gl!(gl.clear_depthf(1.0));
        let (width, height) = window_size(context);
        gl!(gl.viewport(0, 0, width, height));
        gl!(gl.delete_textures(2, self.texture.as_ptr()));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.vbo));
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program[0]));
        gl!(gl.delete_program(self.program[1]));
        gl!(gl.delete_program(self.c_program));
        gl!(gl.delete_buffers(1, &self.buffer));
        gl!(gl.active_texture(glw::GL_TEXTURE0));
        Ok(NO_ERROR)
    }
}

/// `ShaderImageLoadStoreBase::BuildProgram`; a stage whose flag is set requires `GL_OES_shader_image_atomic`.
fn build_program_with(gl: &glw::Functions, src_vs: &str, src_fs: &str, sia_vs: bool, sia_fs: bool) -> GLuint {
    let header = |sia: bool| {
        if sia {
            format!("{GLSL_VER}\n#extension GL_OES_shader_image_atomic : require{GLSL_PREC}")
        } else {
            format!("{GLSL_VER}\n{GLSL_PREC}")
        }
    };
    let program = gl!(gl.create_program());
    for (shader_type, source, sia) in [
        (glw::GL_VERTEX_SHADER, src_vs, sia_vs),
        (glw::GL_FRAGMENT_SHADER, src_fs, sia_fs),
    ] {
        if !attach_stage(gl, program, shader_type, &header(sia), source) {
            return program;
        }
    }
    if !link_program(gl, program) {
        log::info!("{GLSL_VER}{src_vs}\n{GLSL_VER}{src_fs}");
    }
    program
}

/// `BuildProgram(vs, fs, true, true)`
fn build_program_sia(gl: &glw::Functions, src_vs: &str, src_fs: &str) -> GLuint {
    build_program_with(gl, src_vs, src_fs, true, true)
}

/// `ShaderImageLoadStoreBase::CreateComputeProgram` with `GL_OES_shader_image_atomic` required.
fn create_compute_program_sia(gl: &glw::Functions, cs: &str) -> GLuint {
    let header = format!("{GLSL_VER}\n#extension GL_OES_shader_image_atomic : require{GLSL_PREC}");
    let program = gl!(gl.create_program());
    if !cs.is_empty() && !attach_stage(gl, program, glw::GL_COMPUTE_SHADER, &header, cs) {
        return program;
    }
    if !link_program(gl, program) && !cs.is_empty() {
        log::info!("{header}{cs}");
    }
    program
}

/// `ShaderImageLoadStoreBase::IsImageAtomicSupported`
fn is_image_atomic_supported(context: &Context) -> bool {
    let is_arb_es31_compatibility = context
        .context_info
        .is_extension_supported("GL_ARB_ES3_1_compatibility");
    let is_oes_shader_image_atomic = context
        .context_info
        .is_extension_supported("GL_OES_shader_image_atomic");
    if !(is_at_least_gl_45(context) || is_arb_es31_compatibility || is_oes_shader_image_atomic) {
        output_not_supported("Required GL_OES_shader_image_atomic is not available.\n");
        return false;
    }
    true
}

/// `ShaderImageLoadStoreBase::CheckFB`
fn check_fb(context: &Context, expected: [f32; 3]) -> bool {
    let gl = context.gl();
    let target = context.render_target();
    let eps = [
        1.0 / (1u32 << target.red_bits) as f32,
        1.0 / (1u32 << target.green_bits) as f32,
        1.0 / (1u32 << target.blue_bits) as f32,
    ];
    let (width, height) = (target.width, target.height);
    let mut fb = vec![0 as glw::GLubyte; (width * height * 4) as usize];
    gl!(gl.read_pixels(
        0,
        0,
        width,
        height,
        glw::GL_RGBA,
        glw::GL_UNSIGNED_BYTE,
        fb.as_mut_ptr().cast()
    ));
    for (i, pixel) in fb.chunks_exact(4).enumerate() {
        if (0..3).any(|k| (pixel[k] as f32 / 255.0 - expected[k]).abs() > eps[k]) {
            let (x, y) = (i as i32 % width, i as i32 / width);
            log::info!(
                "Incorrect framebuffer color at pixel ({x} {y}). Color is ({} {} {}). Color should be ({} {} {}).",
                pixel[0] as f32 / 255.0,
                pixel[1] as f32 / 255.0,
                pixel[2] as f32 / 255.0,
                expected[0],
                expected[1],
                expected[2]
            );
            return false;
        }
    }
    true
}

/// `CompareValues` for four-component values (the `internalformat` argument is always 0 in these cases, so the comparison is exact).
fn compare_values<T: PartialEq + Copy + std::fmt::Debug>(map_data: &[T], count: usize, expected: [T; 4]) -> bool {
    for (i, texel) in map_data.chunks_exact(4).take(count).enumerate() {
        if texel != expected {
            log::info!("Value at index {i} is {texel:?} should be {expected:?}.");
            return false;
        }
    }
    true
}

/// Maps `count` elements of `T` of the shader storage buffer starting at `byte_offset`.
fn map_ssbo_at<'a, T: Copy>(gl: &glw::Functions, byte_offset: usize, count: usize) -> Option<&'a [T]> {
    let pointer = gl!(gl.map_buffer_range(
        glw::GL_SHADER_STORAGE_BUFFER,
        byte_offset as glw::GLintptr,
        (count * std::mem::size_of::<T>()) as glw::GLsizeiptr,
        glw::GL_MAP_READ_BIT
    )) as *const T;
    if pointer.is_null() {
        return None;
    }
    // SAFETY: the mapping covers `count` elements of `T` and stays valid until the buffer is unmapped or deleted, which happens after the last read.
    Some(unsafe { std::slice::from_raw_parts(pointer, count) })
}

const ADVANCED_SYNC_IMAGE_ACCESS_GLSL_STORE_VS: &str = "\nlayout(rgba32f) writeonly uniform image2D g_output_data;\nvoid main() {\n  vec2[4] data = vec2[4](vec2(-1, -1), vec2(1, -1), vec2(-1, 1), vec2(1, 1));\n  imageStore(g_output_data, ivec2(gl_VertexID,0), vec4(data[gl_VertexID], 0.0, 1.0));\n  gl_PointSize = 1.0;\n}";
const ADVANCED_SYNC_IMAGE_ACCESS_GLSL_STORE_FS: &str = "\nvoid main() {\n  discard;\n}";
const ADVANCED_SYNC_IMAGE_ACCESS_GLSL_DRAW_VS: &str = "\nout vec4 vs_color;\nlayout(rgba32f) readonly uniform image2D g_image;\nuniform sampler2D g_sampler;\nvoid main() {\n  vec4 pi = imageLoad(g_image, ivec2(gl_VertexID, 0));\n  vec4 ps = texelFetch(g_sampler, ivec2(gl_VertexID, 0), 0);\n  if (pi != ps) vs_color = vec4(1.0, 0.0, 0.0, 1.0);\n  else vs_color = vec4(0.0, 1.0, 0.0, 1.0);\n  gl_Position = pi;\n}";
const ADVANCED_SYNC_IMAGE_ACCESS_GLSL_DRAW_FS: &str = "\n#define KSIZE 44\nin vec4 vs_color;\nlayout(std430) buffer OutputBuffer {\n  vec4 o_color[KSIZE*KSIZE];\n};\nvoid main() {\n  ivec2 coord = ivec2(gl_FragCoord.xy);\n  int coordIndex = coord.x + KSIZE * coord.y;\n  o_color[coordIndex] = vs_color;\n}";
const ADVANCED_SYNC_VERTEX_ARRAY_GLSL_STORE_VS: &str = "\nlayout(rgba32f, binding = 0) writeonly uniform image2D g_position_buffer;\nlayout(rgba32f, binding = 1) writeonly uniform image2D g_color_buffer;\nlayout(r32ui, binding = 2) writeonly uniform uimage2D g_element_buffer;\nuniform vec4 g_color;\nvoid main() {\n  vec2[4] data = vec2[4](vec2(-1, -1), vec2(1, -1), vec2(-1, 1), vec2(1, 1));\n  imageStore(g_position_buffer, ivec2(gl_VertexID,0), vec4(data[gl_VertexID], 0.0, 1.0));\n  imageStore(g_color_buffer, ivec2(gl_VertexID,0), g_color);\n  imageStore(g_element_buffer, ivec2(gl_VertexID,0), uvec4(gl_VertexID));\n}";
const ADVANCED_SYNC_VERTEX_ARRAY_GLSL_STORE_FS: &str = "\nvoid main() {\n  discard;\n}";
const ADVANCED_SYNC_VERTEX_ARRAY_GLSL_COPY_CS: &str = "\n#define KSIZE 4\nlayout (local_size_x = KSIZE) in;\nlayout(rgba32f, binding = 0) readonly uniform image2D g_position_img;\nlayout(rgba32f, binding = 1) readonly uniform image2D g_color_img;\nlayout(r32ui, binding = 2) readonly uniform uimage2D g_element_img;\nlayout(std430, binding = 1) buffer g_position_buf {\n  vec2 g_pos[KSIZE];\n};\nlayout(std430, binding = 2) buffer g_color_buf {\n  vec4 g_col[KSIZE];\n};\nlayout(std430, binding = 3) buffer g_element_buf {\n  uint g_elem[KSIZE];\n};\nvoid main() {\n  ivec2 coord = ivec2(gl_LocalInvocationID.x, 0);\n  g_pos[coord.x] = (imageLoad(g_position_img, coord)).xy;\n  g_col[coord.x] = imageLoad(g_color_img, coord);\n  g_elem[coord.x] = uint((imageLoad(g_element_img, coord)).x);\n}";
const ADVANCED_SYNC_VERTEX_ARRAY_GLSL_DRAW_VS: &str = "\nlayout(location = 0) in vec4 i_position;\nlayout(location = 1) in vec4 i_color;\nout vec4 vs_color;\nvoid main() {\n  gl_Position = i_position;\n  vs_color = i_color;\n}";
const ADVANCED_SYNC_VERTEX_ARRAY_GLSL_DRAW_FS: &str =
    "\nin vec4 vs_color;\nlayout(location = 0) out vec4 o_color;\nvoid main() {\n  o_color = vs_color;\n}";
const ADVANCED_SYNC_IMAGE_ACCESS2_GLSL_VS: &str =
    "\nlayout(location = 0) in vec4 i_position;\nvoid main() {\n  gl_Position = i_position;\n}";
const ADVANCED_SYNC_IMAGE_ACCESS2_GLSL_STORE_FS: &str = "\nlayout(rgba32f) writeonly uniform image2D g_image;\nuniform vec4 g_color;\nvoid main() {\n  imageStore(g_image, ivec2(gl_FragCoord.xy), g_color);\n  discard;\n}";
const ADVANCED_SYNC_IMAGE_ACCESS2_GLSL_DRAW_FS: &str = "\nlayout(location = 0) out vec4 o_color;\nuniform sampler2D g_sampler;\nlayout(std430) buffer OutputBuffer {\n  uvec4 counter;\n  vec4 data[];\n};\nvoid main() {\n  uint idx = atomicAdd(counter[0], 1u);\n  data[idx] = texelFetch(g_sampler, ivec2(gl_FragCoord.xy), 0);\n}";
const ADVANCED_ALL_STAGES_ONE_IMAGE_GLSL_VS: &str = "\nlayout(location = 0) in vec4 i_position;\nlayout(r32ui, binding = 3) coherent uniform uimage2D g_image;\nvoid main() {\n  gl_Position = i_position;\n  imageAtomicCompSwap(g_image, ivec2(0, gl_VertexID), 0u, 100u);\n}";
const ADVANCED_ALL_STAGES_ONE_IMAGE_GLSL_FS: &str = "\nlayout(r32ui, binding = 3) coherent uniform uimage2D g_image;\nvoid main() {\n  imageAtomicAdd(g_image, ivec2(0, int(gl_FragCoord.x) & 0x03), 0x1u);\n}";
const ADVANCED_ALL_STAGES_ONE_IMAGE_GLSL_CS: &str = "\n#define KSIZE 4\nlayout (local_size_x = KSIZE) in;\nlayout(r32ui, binding = 3) uniform uimage2D g_image;\nlayout(std430) buffer out_data {\n  uvec4 data[KSIZE];\n};\nvoid main() {\n  uvec4 v = imageLoad(g_image, ivec2(0, gl_LocalInvocationID.x));\n  data[gl_LocalInvocationIndex] = v;\n}";
const ADVANCED_MEMORY_ORDER_V_S_F_S_GLSL_VS: &str = "\nlayout(location = 0) in vec4 i_position;\nout vec4 vs_color;\nlayout(r32f, binding = 0) uniform image2D g_image_vs;\nvoid main() {\n  gl_Position = i_position;\n  vs_color = vec4(41, 42, 43, 44);\n  imageStore(g_image_vs, ivec2(gl_VertexID), vec4(1.0));\n  imageStore(g_image_vs, ivec2(gl_VertexID), vec4(2.0));\n  imageStore(g_image_vs, ivec2(gl_VertexID), vec4(3.0));\n  if (imageLoad(g_image_vs, ivec2(gl_VertexID)) != vec4(3,0,0,1)) vs_color = vec4(21, 22, 23, 24);\n}";
const ADVANCED_MEMORY_ORDER_V_S_F_S_GLSL_FS: &str = "\n#define KSIZE 11\nin vec4 vs_color;\nlayout(r32f, binding = 1) uniform image2D g_image;\nlayout(std430) buffer out_data {\n  vec4 data[KSIZE*KSIZE*4];\n};\nvoid main() {\n  ivec2 coord = ivec2(gl_FragCoord);\n  int coordIndex = coord.x + KSIZE * coord.y;\n  for (int i = 0; i < 4; ++i) {\n    data[coordIndex + i * KSIZE*KSIZE] = vs_color;\n  }\n  for (int i = 0; i < 4; ++i) {\n    imageStore(g_image, coord, vec4(i+50));\n    vec4 v = imageLoad(g_image, coord);\n    if (v.x != float(i+50)) {\n      data[coordIndex + i * KSIZE*KSIZE] = vec4(v.xyz, i+10);\n      break;\n    }\n  }\n}";

/// 5.1 AdvancedSyncImageAccess
#[derive(Default)]
struct AdvancedSyncImageAccess {
    buffer: GLuint,
    texture: GLuint,
    store_program: GLuint,
    draw_program: GLuint,
    attribless_vao: GLuint,
}

impl Subcase for AdvancedSyncImageAccess {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 1, 0) || !is_ssb_in_vsfs_available(gl, 1, 0) {
            return Ok(NOT_SUPPORTED);
        }

        const SIZE: usize = 44;
        self.store_program = build_program(
            gl,
            Some(ADVANCED_SYNC_IMAGE_ACCESS_GLSL_STORE_VS),
            Some(ADVANCED_SYNC_IMAGE_ACCESS_GLSL_STORE_FS),
        );
        self.draw_program = build_program(
            gl,
            Some(ADVANCED_SYNC_IMAGE_ACCESS_GLSL_DRAW_VS),
            Some(ADVANCED_SYNC_IMAGE_ACCESS_GLSL_DRAW_FS),
        );

        gl!(gl.gen_vertex_arrays(1, &mut self.attribless_vao));
        gl!(gl.bind_vertex_array(self.attribless_vao));

        gl!(gl.gen_textures(1, &mut self.texture));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture));
        nearest_filtering(gl, glw::GL_TEXTURE_2D);
        let data = [0 as GLint; 16];
        gl!(gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA32F, 4, 1));
        gl!(gl.tex_sub_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            0,
            0,
            4,
            1,
            glw::GL_RGBA,
            glw::GL_FLOAT,
            data.as_ptr().cast()
        ));
        gl!(gl.bind_image_texture(0, self.texture, 0, glw::FALSE, 0, glw::GL_READ_WRITE, glw::GL_RGBA32F));

        gl!(gl.use_program(self.store_program));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 4));
        gl!(gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT | glw::GL_TEXTURE_FETCH_BARRIER_BIT));

        gl!(gl.viewport(0, 0, SIZE as glw::GLsizei, SIZE as glw::GLsizei));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.use_program(self.draw_program));

        let out_data = vec![0.0f32; SIZE * SIZE * 4];
        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (SIZE * SIZE * 4 * 4) as glw::GLsizeiptr,
            out_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let Some(map_data) = map_ssbo_at::<f32>(gl, 0, SIZE * SIZE * 4) else {
            return Ok(ERROR);
        };
        result(compare_values(map_data, SIZE * SIZE, [0.0, 1.0, 0.0, 1.0]))
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_buffers(1, &self.buffer));
        gl!(gl.delete_textures(1, &self.texture));
        gl!(gl.delete_program(self.store_program));
        gl!(gl.delete_program(self.draw_program));
        gl!(gl.delete_vertex_arrays(1, &self.attribless_vao));
        let (width, height) = window_size(context);
        gl!(gl.viewport(0, 0, width, height));
        Ok(NO_ERROR)
    }
}

/// 5.2 AdvancedSyncVertexArray
#[derive(Default)]
struct AdvancedSyncVertexArray {
    position_buffer: GLuint,
    color_buffer: GLuint,
    element_buffer: GLuint,
    texture: [GLuint; 3],
    store_program: GLuint,
    copy_program: GLuint,
    draw_program: GLuint,
    attribless_vao: GLuint,
    draw_vao: GLuint,
}

impl Subcase for AdvancedSyncVertexArray {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 3, 0) {
            return Ok(NOT_SUPPORTED);
        }

        self.store_program = build_program(
            gl,
            Some(ADVANCED_SYNC_VERTEX_ARRAY_GLSL_STORE_VS),
            Some(ADVANCED_SYNC_VERTEX_ARRAY_GLSL_STORE_FS),
        );
        self.copy_program = create_compute_program(gl, ADVANCED_SYNC_VERTEX_ARRAY_GLSL_COPY_CS);
        self.draw_program = build_program(
            gl,
            Some(ADVANCED_SYNC_VERTEX_ARRAY_GLSL_DRAW_VS),
            Some(ADVANCED_SYNC_VERTEX_ARRAY_GLSL_DRAW_FS),
        );

        gl!(gl.gen_textures(3, self.texture.as_mut_ptr()));
        for (texture, internalformat) in self
            .texture
            .into_iter()
            .zip([glw::GL_RGBA32F, glw::GL_RGBA32F, glw::GL_R32UI])
        {
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture));
            gl!(gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, internalformat, 4, 1));
            nearest_filtering(gl, glw::GL_TEXTURE_2D);
        }

        gl!(gl.gen_vertex_arrays(1, &mut self.attribless_vao));
        gl!(gl.gen_vertex_arrays(1, &mut self.draw_vao));
        gl!(gl.bind_vertex_array(self.draw_vao));
        gl!(gl.gen_buffers(1, &mut self.position_buffer));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.position_buffer));
        gl!(gl.buffer_data(glw::GL_ARRAY_BUFFER, 4 * 4 * 4, std::ptr::null(), glw::GL_STATIC_DRAW));
        gl!(gl.vertex_attrib_pointer(0, 2, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null()));
        gl!(gl.gen_buffers(1, &mut self.color_buffer));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.color_buffer));
        gl!(gl.buffer_data(glw::GL_ARRAY_BUFFER, 4 * 4 * 4, std::ptr::null(), glw::GL_STATIC_DRAW));
        gl!(gl.vertex_attrib_pointer(1, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null()));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.enable_vertex_attrib_array(0));
        gl!(gl.enable_vertex_attrib_array(1));
        gl!(gl.gen_buffers(1, &mut self.element_buffer));
        gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, self.element_buffer));
        gl!(gl.buffer_data(
            glw::GL_ELEMENT_ARRAY_BUFFER,
            4 * 4 * 4,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        gl!(gl.bind_vertex_array(0));

        gl!(gl.bind_image_texture(
            0,
            self.texture[0],
            0,
            glw::FALSE,
            0,
            glw::GL_READ_WRITE,
            glw::GL_RGBA32F
        ));
        gl!(gl.bind_image_texture(
            1,
            self.texture[1],
            0,
            glw::FALSE,
            0,
            glw::GL_READ_WRITE,
            glw::GL_RGBA32F
        ));
        gl!(gl.bind_image_texture(2, self.texture[2], 0, glw::FALSE, 0, glw::GL_READ_WRITE, glw::GL_R32UI));

        for (index, color) in [[0.0, 1.0, 0.0, 1.0], [0.0, 0.0, 1.0, 1.0]].into_iter().enumerate() {
            gl!(gl.use_program(self.store_program));
            gl!(gl.uniform_4f(
                uniform_location(gl, self.store_program, "g_color"),
                color[0],
                color[1],
                color[2],
                color[3]
            ));
            gl!(gl.bind_vertex_array(self.attribless_vao));
            gl!(gl.draw_arrays(glw::GL_POINTS, 0, 4));
            gl!(gl.use_program(self.copy_program));
            if index == 0 {
                gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 1, self.position_buffer));
                gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 2, self.color_buffer));
                gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 3, self.element_buffer));
            }
            gl!(gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT));
            gl!(gl.dispatch_compute(1, 1, 1));
            gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
            gl!(gl.use_program(self.draw_program));
            gl!(gl.bind_vertex_array(self.draw_vao));
            gl!(gl.memory_barrier(glw::GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT | glw::GL_ELEMENT_ARRAY_BARRIER_BIT));
            gl!(gl.draw_elements(glw::GL_TRIANGLE_STRIP, 4, glw::GL_UNSIGNED_INT, std::ptr::null()));
            if !check_fb(context, [color[0], color[1], color[2]]) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.use_program(0));
        gl!(gl.delete_textures(3, self.texture.as_ptr()));
        gl!(gl.delete_buffers(1, &self.position_buffer));
        gl!(gl.delete_buffers(1, &self.color_buffer));
        gl!(gl.delete_buffers(1, &self.element_buffer));
        gl!(gl.delete_program(self.store_program));
        gl!(gl.delete_program(self.copy_program));
        gl!(gl.delete_program(self.draw_program));
        gl!(gl.delete_vertex_arrays(1, &self.attribless_vao));
        gl!(gl.delete_vertex_arrays(1, &self.draw_vao));
        Ok(NO_ERROR)
    }
}

/// 5.3 AdvancedSyncImageAccess2
#[derive(Default)]
struct AdvancedSyncImageAccess2 {
    texture: GLuint,
    store_program: GLuint,
    draw_program: GLuint,
    vao: GLuint,
    vbo: GLuint,
    buffer: GLuint,
}

impl Subcase for AdvancedSyncImageAccess2 {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        const SIZE: usize = 32;
        if !is_vsfs_available(gl, 0, 1) || !is_ssb_in_vsfs_available(gl, 0, 1) {
            return Ok(NOT_SUPPORTED);
        }

        self.store_program = build_program(
            gl,
            Some(ADVANCED_SYNC_IMAGE_ACCESS2_GLSL_VS),
            Some(ADVANCED_SYNC_IMAGE_ACCESS2_GLSL_STORE_FS),
        );
        self.draw_program = build_program(
            gl,
            Some(ADVANCED_SYNC_IMAGE_ACCESS2_GLSL_VS),
            Some(ADVANCED_SYNC_IMAGE_ACCESS2_GLSL_DRAW_FS),
        );

        let (width, height) = window_size(context);
        gl!(gl.gen_textures(1, &mut self.texture));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture));
        nearest_filtering(gl, glw::GL_TEXTURE_2D);
        gl!(gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA32F, width, height));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));

        create_full_viewport_quad(gl, &mut self.vao, &mut self.vbo, None);
        gl!(gl.viewport(0, 0, SIZE as glw::GLsizei, SIZE as glw::GLsizei));

        let data_b = vec![0.0f32; (SIZE * SIZE + 1) * 4];
        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            ((SIZE * SIZE + 1) * 4 * 4) as glw::GLsizeiptr,
            data_b.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));

        gl!(gl.bind_image_texture(0, self.texture, 0, glw::FALSE, 0, glw::GL_WRITE_ONLY, glw::GL_RGBA32F));
        gl!(gl.use_program(self.store_program));
        gl!(gl.uniform_4f(uniform_location(gl, self.store_program, "g_color"), 1.0, 0.0, 0.0, 1.0));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        gl!(gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT));
        gl!(gl.uniform_4f(uniform_location(gl, self.store_program, "g_color"), 0.0, 1.0, 0.0, 1.0));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture));
        gl!(gl.use_program(self.draw_program));
        gl!(gl.memory_barrier(glw::GL_TEXTURE_FETCH_BARRIER_BIT));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let Some(map_data) = map_ssbo_at::<f32>(gl, 4 * 4, SIZE * SIZE * 4) else {
            return Ok(ERROR);
        };
        result(compare_values(map_data, SIZE * SIZE, [0.0, 1.0, 0.0, 1.0]))
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let (width, height) = window_size(context);
        gl!(gl.viewport(0, 0, width, height));
        gl!(gl.use_program(0));
        gl!(gl.delete_buffers(1, &self.vbo));
        gl!(gl.delete_textures(1, &self.texture));
        gl!(gl.delete_program(self.store_program));
        gl!(gl.delete_program(self.draw_program));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.buffer));
        Ok(NO_ERROR)
    }
}

/// 5.4 AdvancedAllStagesOneImage
#[derive(Default)]
struct AdvancedAllStagesOneImage {
    program: GLuint,
    c_program: GLuint,
    vao: GLuint,
    vbo: GLuint,
    buffer: GLuint,
    texture: GLuint,
}

impl Subcase for AdvancedAllStagesOneImage {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 1, 1) || !is_image_atomic_supported(context) {
            return Ok(NOT_SUPPORTED);
        }

        self.program = build_program_sia(
            gl,
            ADVANCED_ALL_STAGES_ONE_IMAGE_GLSL_VS,
            ADVANCED_ALL_STAGES_ONE_IMAGE_GLSL_FS,
        );
        self.c_program = create_compute_program_sia(gl, ADVANCED_ALL_STAGES_ONE_IMAGE_GLSL_CS);
        gl!(gl.use_program(self.program));
        create_full_viewport_quad(gl, &mut self.vao, &mut self.vbo, None);

        let ui32 = [0 as GLuint; 64];
        gl!(gl.gen_textures(1, &mut self.texture));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture));
        gl!(gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_R32UI, 4, 4));
        nearest_filtering(gl, glw::GL_TEXTURE_2D);
        gl!(gl.tex_sub_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            0,
            0,
            4,
            4,
            glw::GL_RED_INTEGER,
            glw::GL_UNSIGNED_INT,
            ui32.as_ptr().cast()
        ));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.bind_image_texture(3, self.texture, 0, glw::FALSE, 0, glw::GL_READ_WRITE, glw::GL_R32UI));

        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.draw_arrays_instanced(glw::GL_TRIANGLE_STRIP, 0, 4, 1));
        gl!(gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT));

        let data_b = [0.0f32; 16];
        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            4 * 4 * 4,
            data_b.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        gl!(gl.use_program(self.c_program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let Some(map_data) = map_ssbo_at::<GLuint>(gl, 0, 4 * 4) else {
            return Ok(ERROR);
        };
        let (width, height) = window_size(context);
        for i in 0..4 {
            let mut expected_value = ((width / 4) * height + 100) as GLuint;
            if i < width % 4 {
                expected_value += height as GLuint;
            }
            if !compare_values(&map_data[i as usize * 4..], 1, [expected_value, 0, 0, 1]) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_buffers(1, &self.buffer));
        gl!(gl.delete_buffers(1, &self.vbo));
        gl!(gl.delete_textures(1, &self.texture));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_program(self.c_program));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        Ok(NO_ERROR)
    }
}

/// 5.5 AdvancedMemoryOrderVSFS
#[derive(Default)]
struct AdvancedMemoryOrderVsfs {
    buffer: GLuint,
    texture: [GLuint; 2],
    program: GLuint,
    vao: GLuint,
    vbo: GLuint,
}

impl Subcase for AdvancedMemoryOrderVsfs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        const SIZE: usize = 11;
        if !is_vsfs_available(gl, 1, 1) || !is_ssb_in_vsfs_available(gl, 1, 1) {
            return Ok(NOT_SUPPORTED);
        }

        self.program = build_program(
            gl,
            Some(ADVANCED_MEMORY_ORDER_V_S_F_S_GLSL_VS),
            Some(ADVANCED_MEMORY_ORDER_V_S_F_S_GLSL_FS),
        );
        create_full_viewport_quad(gl, &mut self.vao, &mut self.vbo, None);

        let data = vec![0.0f32; SIZE * SIZE];
        gl!(gl.gen_textures(2, self.texture.as_mut_ptr()));
        for texture in self.texture {
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture));
            gl!(gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                1,
                glw::GL_R32F,
                SIZE as glw::GLsizei,
                SIZE as glw::GLsizei
            ));
            nearest_filtering(gl, glw::GL_TEXTURE_2D);
            gl!(gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                SIZE as glw::GLsizei,
                SIZE as glw::GLsizei,
                glw::GL_RED,
                glw::GL_FLOAT,
                data.as_ptr().cast()
            ));
        }
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.bind_image_texture(0, self.texture[0], 0, glw::FALSE, 0, glw::GL_READ_WRITE, glw::GL_R32F));
        gl!(gl.bind_image_texture(1, self.texture[1], 0, glw::FALSE, 0, glw::GL_READ_WRITE, glw::GL_R32F));

        let data_b = vec![0.0f32; SIZE * SIZE * 4 * 4];
        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (4 * SIZE * SIZE * 4 * 4) as glw::GLsizeiptr,
            data_b.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));

        gl!(gl.use_program(self.program));
        gl!(gl.viewport(0, 0, SIZE as glw::GLsizei, SIZE as glw::GLsizei));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.draw_arrays_instanced(glw::GL_TRIANGLE_STRIP, 0, 4, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let Some(map_data) = map_ssbo_at::<f32>(gl, 0, 4 * SIZE * SIZE * 4) else {
            return Ok(ERROR);
        };
        result(compare_values(map_data, SIZE * 2 * SIZE * 2, [41.0, 42.0, 43.0, 44.0]))
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let (width, height) = window_size(context);
        gl!(gl.viewport(0, 0, width, height));
        gl!(gl.use_program(0));
        gl!(gl.delete_buffers(1, &self.vbo));
        gl!(gl.delete_buffers(1, &self.buffer));
        gl!(gl.delete_textures(2, self.texture.as_ptr()));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        Ok(NO_ERROR)
    }
}

/// `ShaderImageLoadStoreBase::BuildShaderProgram`
fn build_shader_program(gl: &glw::Functions, shader_type: GLenum, source: &str) -> GLuint {
    let sources: Vec<CString> = [GLSL_VER, GLSL_PREC, source]
        .iter()
        .map(|part| CString::new(*part).expect("shader sources hold no NUL"))
        .collect();
    let pointers: Vec<*const glw::GLchar> = sources.iter().map(|part| part.as_ptr()).collect();
    let program = gl!(gl.create_shader_programv(shader_type, 3, pointers.as_ptr()));
    if program_status(gl, program) == glw::GL_FALSE as GLint {
        log::info!("Program Info Log:\n{GLSL_VER}\n{GLSL_PREC}\n{source}");
    }
    program
}

const ADVANCED_S_S_O_SIMPLE_GLSL_VS: &str =
    "\nlayout(location = 0) in vec4 i_position;\nvoid main() {\n  gl_Position = i_position;\n}";
const ADVANCED_S_S_O_SIMPLE_GLSL_FS0: &str = "\nlayout(rgba32f, binding = 2) writeonly uniform image2D g_image[2];\nvoid main() {\n  int i = g_image.length();\n  imageStore(g_image[0], ivec2(gl_FragCoord), vec4(i+98));\n  imageStore(g_image[1], ivec2(gl_FragCoord), vec4(i+99));\n  discard;\n}";
const ADVANCED_S_S_O_SIMPLE_GLSL_FS1: &str = "\nlayout(rgba32f, binding = 0) writeonly uniform image2D g_image[2];\nvoid main() {\n  int i = g_image.length();\n  imageStore(g_image[0], ivec2(gl_FragCoord), vec4(i+8));\n  imageStore(g_image[1], ivec2(gl_FragCoord), vec4(i+9));\n  discard;\n}";
const ADVANCED_S_S_O_SIMPLE_GLSL_CS: &str = "\n#define KSIZE 4\nlayout (local_size_x = KSIZE, local_size_y = KSIZE) in;\nlayout(rgba32f, binding = 0) readonly uniform image2D g_image[4];\nlayout(std430) buffer OutputBuffer {\n  uvec4 counter;\n  vec4 data[];\n};\nvoid main() {\n  uint idx = atomicAdd(counter[0], 1u);\n  data[idx][0] = (imageLoad(g_image[0], ivec2(gl_GlobalInvocationID))).z;\n  data[idx][1] = (imageLoad(g_image[1], ivec2(gl_GlobalInvocationID))).z;\n  data[idx][2] = (imageLoad(g_image[2], ivec2(gl_GlobalInvocationID))).z;\n  data[idx][3] = (imageLoad(g_image[3], ivec2(gl_GlobalInvocationID))).z;\n}";
const ADVANCED_COPY_IMAGE_F_S_GLSL_VS: &str =
    "\nlayout(location = 0) in vec4 i_position;\nvoid main() {\n  gl_Position = i_position;\n}";
const ADVANCED_COPY_IMAGE_F_S_GLSL_FS: &str = "\nlayout(rgba32f, binding = 3) readonly uniform image2D g_input_image;\nlayout(rgba32f, binding = 1) writeonly uniform image2D g_output_image;\nvoid main() {\n  ivec2 coord = ivec2(gl_FragCoord);\n  imageStore(g_output_image, coord, imageLoad(g_input_image, coord));\n  discard;\n}";
const ADVANCED_COPY_IMAGE_F_S_GLSL_CS: &str = "\n#define KSIZE 11\nlayout (local_size_x = KSIZE, local_size_y = KSIZE) in;\nlayout(rgba32f, binding = 2) readonly uniform image2D g_image;\nlayout(std430) buffer out_data {\n  vec4 data[KSIZE*KSIZE];\n};\nvoid main() {\n  ivec2 coord = ivec2(gl_LocalInvocationID);\n  data[gl_LocalInvocationIndex] = imageLoad(g_image, coord);\n}";
const ADVANCED_COPY_IMAGE_C_S_GLSL_CS: &str = "\n#define KSIZE 11\nlayout (local_size_x = KSIZE, local_size_y = KSIZE) in;\nlayout(rgba32f, binding = 3) readonly uniform image2D g_input_image;\nlayout(rgba32f, binding = 1) writeonly uniform image2D g_output_image;\nvoid main() {\n  ivec2 coord = ivec2(gl_LocalInvocationID);\n  imageStore(g_output_image, coord, imageLoad(g_input_image, coord));\n}";
const ADVANCED_COPY_IMAGE_C_S_GLSL_CS_C: &str = "\n#define KSIZE 11\nlayout (local_size_x = KSIZE, local_size_y = KSIZE) in;\nlayout(rgba32f, binding = 2) readonly uniform image2D g_image;\nlayout(std430) buffer out_data {\n  vec4 data[KSIZE*KSIZE];\n};\nvoid main() {\n  ivec2 coord = ivec2(gl_LocalInvocationID);\n  data[gl_LocalInvocationIndex] = imageLoad(g_image, coord);\n}";

/// 5.6 AdvancedSSOSimple
struct AdvancedSsoSimple {
    pipeline: bool,
    texture: GLuint,
    pipelines: [GLuint; 2],
    vsp: GLuint,
    fsp0: GLuint,
    fsp1: GLuint,
    vao: GLuint,
    vbo: GLuint,
    program: [GLuint; 2],
    c_program: GLuint,
    buffer: GLuint,
}

impl Default for AdvancedSsoSimple {
    fn default() -> Self {
        Self {
            pipeline: true,
            texture: 0,
            pipelines: [0; 2],
            vsp: 0,
            fsp0: 0,
            fsp1: 0,
            vao: 0,
            vbo: 0,
            program: [0; 2],
            c_program: 0,
            buffer: 0,
        }
    }
}

impl Subcase for AdvancedSsoSimple {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        self.c_program = 0;
        self.buffer = 0;
        create_full_viewport_quad(gl, &mut self.vao, &mut self.vbo, None);
        gl!(gl.gen_textures(1, &mut self.texture));
        if self.pipeline {
            gl!(gl.gen_program_pipelines(2, self.pipelines.as_mut_ptr()));
            self.vsp = build_shader_program(gl, glw::GL_VERTEX_SHADER, ADVANCED_S_S_O_SIMPLE_GLSL_VS);
            self.fsp0 = build_shader_program(gl, glw::GL_FRAGMENT_SHADER, ADVANCED_S_S_O_SIMPLE_GLSL_FS0);
            self.fsp1 = build_shader_program(gl, glw::GL_FRAGMENT_SHADER, ADVANCED_S_S_O_SIMPLE_GLSL_FS1);
        } else {
            self.program[0] = build_program(
                gl,
                Some(ADVANCED_S_S_O_SIMPLE_GLSL_VS),
                Some(ADVANCED_S_S_O_SIMPLE_GLSL_FS0),
            );
            self.program[1] = build_program(
                gl,
                Some(ADVANCED_S_S_O_SIMPLE_GLSL_VS),
                Some(ADVANCED_S_S_O_SIMPLE_GLSL_FS1),
            );
        }
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 0, 2) {
            return Ok(NOT_SUPPORTED);
        }

        const SIZE: i32 = 4;
        const TEXTURE_WIDTH: i32 = 16;
        const TEXTURE_HEIGHT: i32 = 16;

        if self.pipeline {
            gl!(gl.use_program_stages(self.pipelines[0], glw::GL_VERTEX_SHADER_BIT, self.vsp));
            gl!(gl.use_program_stages(self.pipelines[0], glw::GL_FRAGMENT_SHADER_BIT, self.fsp0));
            gl!(gl.use_program_stages(self.pipelines[1], glw::GL_VERTEX_SHADER_BIT, self.vsp));
            gl!(gl.use_program_stages(self.pipelines[1], glw::GL_FRAGMENT_SHADER_BIT, self.fsp1));
        }

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, self.texture));
        nearest_filtering(gl, glw::GL_TEXTURE_2D_ARRAY);
        gl!(gl.tex_storage_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            1,
            glw::GL_RGBA32F,
            TEXTURE_WIDTH,
            TEXTURE_HEIGHT,
            8
        ));
        for (unit, layer) in [(0, 6), (1, 4), (2, 1), (3, 3)] {
            gl!(gl.bind_image_texture(
                unit,
                self.texture,
                0,
                glw::FALSE,
                layer,
                glw::GL_READ_WRITE,
                glw::GL_RGBA32F
            ));
        }

        gl!(gl.bind_vertex_array(self.vao));
        if self.pipeline {
            gl!(gl.bind_program_pipeline(self.pipelines[0]));
        } else {
            gl!(gl.use_program(self.program[0]));
        }
        gl!(gl.draw_arrays_instanced(glw::GL_TRIANGLE_STRIP, 0, 4, 1));
        if self.pipeline {
            gl!(gl.bind_program_pipeline(self.pipelines[1]));
        } else {
            gl!(gl.use_program(self.program[1]));
        }
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        self.c_program = create_compute_program(gl, ADVANCED_S_S_O_SIMPLE_GLSL_CS);
        gl!(gl.use_program(self.c_program));

        let wsx = (TEXTURE_WIDTH / SIZE) * SIZE;
        let wsy = (TEXTURE_HEIGHT / SIZE) * SIZE;
        let minor = if wsx > wsy { wsy } else { wsx };
        let data_b = vec![0.0f32; ((wsx * wsy + 1) * 4) as usize];
        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            ((wsx * wsy + 1) * 4 * 4) as glw::GLsizeiptr,
            data_b.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        gl!(gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT));
        gl!(gl.dispatch_compute((wsx / SIZE) as GLuint, (wsy / SIZE) as GLuint, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let Some(map_data) = map_ssbo_at::<f32>(gl, 4 * 4, (wsx * wsy * 4) as usize) else {
            return Ok(ERROR);
        };
        result(compare_values(
            map_data,
            (minor * minor) as usize,
            [10.0, 11.0, 100.0, 101.0],
        ))
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_buffers(1, &self.vbo));
        gl!(gl.delete_textures(1, &self.texture));
        if self.pipeline {
            gl!(gl.delete_program(self.vsp));
            gl!(gl.delete_program(self.fsp0));
            gl!(gl.delete_program(self.fsp1));
            gl!(gl.delete_program_pipelines(2, self.pipelines.as_ptr()));
        } else {
            gl!(gl.delete_program(self.program[0]));
            gl!(gl.delete_program(self.program[1]));
        }
        gl!(gl.delete_program(self.c_program));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.buffer));
        Ok(NO_ERROR)
    }
}

/// Shared by `AdvancedCopyImageFS` and `AdvancedCopyImageCS`: two 11x11 RGBA32F textures, the first filled with 7.0, bound as image units 3, 1 and 2.
fn copy_image_textures(gl: &glw::Functions, textures: &[GLuint; 2], size: usize) {
    let data = vec![7.0f32; size * size * 4];
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, textures[0]));
    gl!(gl.tex_storage_2d(
        glw::GL_TEXTURE_2D,
        1,
        glw::GL_RGBA32F,
        size as glw::GLsizei,
        size as glw::GLsizei
    ));
    nearest_filtering(gl, glw::GL_TEXTURE_2D);
    gl!(gl.tex_sub_image_2d(
        glw::GL_TEXTURE_2D,
        0,
        0,
        0,
        size as glw::GLsizei,
        size as glw::GLsizei,
        glw::GL_RGBA,
        glw::GL_FLOAT,
        data.as_ptr().cast()
    ));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, textures[1]));
    gl!(gl.tex_storage_2d(
        glw::GL_TEXTURE_2D,
        1,
        glw::GL_RGBA32F,
        size as glw::GLsizei,
        size as glw::GLsizei
    ));
    nearest_filtering(gl, glw::GL_TEXTURE_2D);
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
    gl!(gl.bind_image_texture(3, textures[0], 0, glw::FALSE, 0, glw::GL_READ_ONLY, glw::GL_RGBA32F));
    gl!(gl.bind_image_texture(1, textures[1], 0, glw::FALSE, 0, glw::GL_WRITE_ONLY, glw::GL_RGBA32F));
    gl!(gl.bind_image_texture(2, textures[1], 0, glw::FALSE, 0, glw::GL_READ_ONLY, glw::GL_RGBA32F));
}

/// 5.7 AdvancedCopyImageFS
#[derive(Default)]
struct AdvancedCopyImageFs {
    texture: [GLuint; 2],
    program: GLuint,
    c_program: GLuint,
    vao: GLuint,
    vbo: GLuint,
    ebo: GLuint,
    buffer: GLuint,
}

impl Subcase for AdvancedCopyImageFs {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_textures(2, self.texture.as_mut_ptr()));
        create_full_viewport_quad(gl, &mut self.vao, &mut self.vbo, Some(&mut self.ebo));
        gl!(gl.gen_buffers(1, &mut self.buffer));
        self.program = build_program(
            gl,
            Some(ADVANCED_COPY_IMAGE_F_S_GLSL_VS),
            Some(ADVANCED_COPY_IMAGE_F_S_GLSL_FS),
        );
        self.c_program = create_compute_program(gl, ADVANCED_COPY_IMAGE_F_S_GLSL_CS);
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        const SIZE: usize = 11;
        if !is_vsfs_available(gl, 0, 2) {
            return Ok(NOT_SUPPORTED);
        }

        copy_image_textures(gl, &self.texture, SIZE);

        let data_b = vec![0.0f32; SIZE * SIZE * 4];
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (SIZE * SIZE * 4 * 4) as glw::GLsizeiptr,
            data_b.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));

        gl!(gl.use_program(self.program));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.viewport(0, 0, SIZE as glw::GLsizei, SIZE as glw::GLsizei));
        gl!(gl.draw_elements_instanced(glw::GL_TRIANGLE_STRIP, 4, glw::GL_UNSIGNED_SHORT, std::ptr::null(), 1));
        gl!(gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT));

        gl!(gl.use_program(self.c_program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let Some(map_data) = map_ssbo_at::<f32>(gl, 0, SIZE * SIZE * 4) else {
            return Ok(ERROR);
        };
        result(compare_values(map_data, SIZE * SIZE, [7.0; 4]))
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let (width, height) = window_size(context);
        gl!(gl.viewport(0, 0, width, height));
        gl!(gl.use_program(0));
        gl!(gl.delete_buffers(1, &self.vbo));
        gl!(gl.delete_buffers(1, &self.ebo));
        gl!(gl.delete_buffers(1, &self.buffer));
        gl!(gl.delete_textures(2, self.texture.as_ptr()));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_program(self.c_program));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        Ok(NO_ERROR)
    }
}

/// 5.8 AdvancedCopyImageCS
#[derive(Default)]
struct AdvancedCopyImageCs {
    texture: [GLuint; 2],
    program: GLuint,
    c_program: GLuint,
    buffer: GLuint,
}

impl Subcase for AdvancedCopyImageCs {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_textures(2, self.texture.as_mut_ptr()));
        gl!(gl.gen_buffers(1, &mut self.buffer));
        self.program = create_compute_program(gl, ADVANCED_COPY_IMAGE_C_S_GLSL_CS);
        self.c_program = create_compute_program(gl, ADVANCED_COPY_IMAGE_C_S_GLSL_CS_C);
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        const SIZE: usize = 11;
        copy_image_textures(gl, &self.texture, SIZE);

        let data_b = vec![0.0f32; SIZE * SIZE * 4];
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (SIZE * SIZE * 4 * 4) as glw::GLsizeiptr,
            data_b.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));

        gl!(gl.use_program(self.program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT));
        gl!(gl.use_program(self.c_program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let Some(map_data) = map_ssbo_at::<f32>(gl, 0, SIZE * SIZE * 4) else {
            return Ok(ERROR);
        };
        result(compare_values(map_data, SIZE * SIZE, [7.0; 4]))
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_buffers(1, &self.buffer));
        gl!(gl.delete_textures(2, self.texture.as_ptr()));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_program(self.c_program));
        Ok(NO_ERROR)
    }
}

const ADVANCED_ALL_MIPS_F_S_GLSL_VS: &str =
    "\nlayout(location = 0) in vec4 i_position;\nvoid main() {\n  gl_Position = i_position;\n}";
const ADVANCED_ALL_MIPS_F_S_GLSL_STORE_FS: &str = "\nlayout(rgba32f, binding = 0) writeonly uniform image2D g_image[4];\nvoid main() {\n  imageStore(g_image[0], ivec2(gl_FragCoord), vec4(23));\n  imageStore(g_image[1], ivec2(gl_FragCoord), vec4(24));\n  imageStore(g_image[2], ivec2(gl_FragCoord), vec4(25));\n  imageStore(g_image[3], ivec2(gl_FragCoord), vec4(26));\n  discard;\n}";
const ADVANCED_ALL_MIPS_F_S_GLSL_LOAD_CS: &str = "\n#define KSIZE 11\nlayout (local_size_x = KSIZE, local_size_y = KSIZE) in;\nlayout(rgba32f, binding = 0) readonly uniform image2D g_image[4];\nlayout(std430) buffer out_data {\n  ivec4 data[KSIZE*KSIZE];\n};\nvoid main() {\n  ivec2 coord = ivec2(gl_LocalInvocationID);\n  data[gl_LocalInvocationIndex] = ivec4(2, 3, 4, 5);\n  vec4 c0 = imageLoad(g_image[0], coord);\n  vec4 c1 = imageLoad(g_image[1], coord);\n  vec4 c2 = imageLoad(g_image[2], coord);\n  vec4 c3 = imageLoad(g_image[3], coord);\n  if ((all(lessThan(coord, ivec2(2))) && c0 != vec4(23)) || (any(greaterThanEqual(coord, ivec2(2))) && c0.xyz != vec3(0.0)))\n      data[gl_LocalInvocationIndex][0] = int(c0.x);\n  if ((all(lessThan(coord, ivec2(4))) && c1 != vec4(24)) || (any(greaterThanEqual(coord, ivec2(4))) && c1.xyz != vec3(0.0)))\n      data[gl_LocalInvocationIndex][1] = int(c1.x);\n  if ((all(lessThan(coord, ivec2(8))) && c2 != vec4(25)) || (any(greaterThanEqual(coord, ivec2(8))) && c2.xyz != vec3(0.0)))\n      data[gl_LocalInvocationIndex][2] = int(c2.x);\n  if ((all(lessThan(coord, ivec2(16))) && c3 != vec4(26)) || (any(greaterThanEqual(coord, ivec2(16))) && c3.xyz != vec3(0.0)))\n      data[gl_LocalInvocationIndex][3] = int(c3.x);\n}";
const ADVANCED_ALL_MIPS_C_S_GLSL_STORE_CS: &str = "\n#define KSIZE 11\nlayout (local_size_x = KSIZE, local_size_y = KSIZE) in;\nlayout(rgba32f, binding = 0) writeonly uniform image2D g_image[4];\nvoid main() {\n  ivec2 coord = ivec2(gl_LocalInvocationID);\n  imageStore(g_image[0], coord, vec4(23));\n  imageStore(g_image[1], coord, vec4(24));\n  imageStore(g_image[2], coord, vec4(25));\n  imageStore(g_image[3], coord, vec4(26));\n}";
const ADVANCED_ALL_MIPS_C_S_GLSL_LOAD_CS: &str = "\n#define KSIZE 11\nlayout (local_size_x = KSIZE, local_size_y = KSIZE) in;\nlayout(rgba32f, binding = 0) readonly uniform image2D g_image[4];\nlayout(std430) buffer out_data {\n  ivec4 data[KSIZE*KSIZE];\n};\nvoid main() {\n  ivec2 coord = ivec2(gl_LocalInvocationID);\n  data[gl_LocalInvocationIndex] = ivec4(2, 3, 4, 5);\n  vec4 c0 = imageLoad(g_image[0], coord);\n  vec4 c1 = imageLoad(g_image[1], coord);\n  vec4 c2 = imageLoad(g_image[2], coord);\n  vec4 c3 = imageLoad(g_image[3], coord);\n  if ((all(lessThan(coord, ivec2(2))) && c0 != vec4(23)) || (any(greaterThanEqual(coord, ivec2(2))) && c0.xyz != vec3(0.0)))\n      data[gl_LocalInvocationIndex][0] = int(c0.x);\n  if ((all(lessThan(coord, ivec2(4))) && c1 != vec4(24)) || (any(greaterThanEqual(coord, ivec2(4))) && c1.xyz != vec3(0.0)))\n      data[gl_LocalInvocationIndex][1] = int(c1.x);\n  if ((all(lessThan(coord, ivec2(8))) && c2 != vec4(25)) || (any(greaterThanEqual(coord, ivec2(8))) && c2.xyz != vec3(0.0)))\n      data[gl_LocalInvocationIndex][2] = int(c2.x);\n  if ((all(lessThan(coord, ivec2(16))) && c3 != vec4(26)) || (any(greaterThanEqual(coord, ivec2(16))) && c3.xyz != vec3(0.0)))\n      data[gl_LocalInvocationIndex][3] = int(c3.x);\n}";
const ADVANCED_CAST_F_S_GLSL_VS: &str =
    "\nlayout(location = 0) in vec4 i_position;\nvoid main() {\n  gl_Position = i_position;\n}";
const ADVANCED_CAST_F_S_GLSL_FS: &str = "\n#define KSIZE 11\nlayout(r32i, binding = 0) coherent uniform iimage2D g_image0;\nlayout(r32ui, binding = 1) coherent uniform uimage2D g_image1;\nvoid main() {\n  ivec2 coord = ivec2(gl_FragCoord.xy);\n  imageAtomicAdd(g_image0, coord, 2);\n  imageAtomicAdd(g_image0, coord, -1);\n  imageAtomicAdd(g_image1, coord, 1u);\n  imageAtomicAdd(g_image1, coord, 2u);\n}";
const ADVANCED_CAST_F_S_GLSL_CS: &str = "\n#define KSIZE 11\nlayout (local_size_x = KSIZE, local_size_y = KSIZE) in;\nlayout(r32i, binding = 0) uniform iimage2D gi_image;\nlayout(r32ui, binding = 1) uniform uimage2D gu_image;\nlayout(std430) buffer out_data {\n  ivec4 data[KSIZE*KSIZE];\n};\nvoid main() {\n  ivec2 coord = ivec2(gl_LocalInvocationID);\n  data[gl_LocalInvocationIndex].yx = imageLoad(gi_image, coord).xy;\n  data[gl_LocalInvocationIndex].wz = ivec2(imageLoad(gu_image, coord).xz);\n}";
const ADVANCED_CAST_C_S_GLSL_CS: &str = "\n#define KSIZE 11\nlayout (local_size_x = KSIZE, local_size_y = KSIZE) in;\nlayout(r32i, binding = 0) coherent uniform iimage2D g_image0;\nlayout(r32ui, binding = 1) coherent uniform uimage2D g_image1;\nvoid main() {\n  ivec2 coord = ivec2(gl_LocalInvocationID);\n  imageAtomicAdd(g_image0, coord, 222);\n  imageAtomicAdd(g_image0, coord, -11);\n  imageAtomicAdd(g_image1, coord, 1u);\n  imageAtomicAdd(g_image1, coord, 2u);\n}";
const ADVANCED_CAST_C_S_GLSL_CS_C: &str = "\n#define KSIZE 11\nlayout (local_size_x = KSIZE, local_size_y = KSIZE) in;\nlayout(r32i, binding = 0) uniform iimage2D gi_image;\nlayout(r32ui, binding = 1) uniform uimage2D gu_image;\nlayout(std430) buffer out_data {\n  ivec4 data[KSIZE*KSIZE];\n};\nvoid main() {\n  ivec2 coord = ivec2(gl_LocalInvocationID);\n  data[gl_LocalInvocationIndex].yz = imageLoad(gi_image, coord).xw;\n  data[gl_LocalInvocationIndex].wx = ivec2(imageLoad(gu_image, coord).xy);\n}";

/// 5.9 AdvancedAllMipsFS
#[derive(Default)]
struct AdvancedAllMipsFs {
    texture: GLuint,
    store_program: GLuint,
    load_program: GLuint,
    vao: GLuint,
    vbo: GLuint,
    ebo: GLuint,
    buffer: GLuint,
}

impl Subcase for AdvancedAllMipsFs {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_textures(1, &mut self.texture));
        create_full_viewport_quad(gl, &mut self.vao, &mut self.vbo, Some(&mut self.ebo));
        gl!(gl.gen_buffers(1, &mut self.buffer));
        self.store_program = build_program(
            gl,
            Some(ADVANCED_ALL_MIPS_F_S_GLSL_VS),
            Some(ADVANCED_ALL_MIPS_F_S_GLSL_STORE_FS),
        );
        self.load_program = create_compute_program(gl, ADVANCED_ALL_MIPS_F_S_GLSL_LOAD_CS);
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        const SIZE: usize = 11;
        if !is_vsfs_available(gl, 0, 4) {
            return Ok(NOT_SUPPORTED);
        }

        all_mips_texture(gl, self.texture);
        let data = vec![0u8; SIZE * SIZE * 4 * 4];
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (SIZE * SIZE * 4 * 4) as glw::GLsizeiptr,
            data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        gl!(gl.viewport(0, 0, SIZE as glw::GLsizei, SIZE as glw::GLsizei));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.use_program(self.store_program));
        gl!(gl.draw_elements(glw::GL_TRIANGLE_STRIP, 4, glw::GL_UNSIGNED_SHORT, std::ptr::null()));
        gl!(gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT));
        gl!(gl.use_program(self.load_program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let Some(map_data) = map_ssbo_at::<GLint>(gl, 0, SIZE * SIZE * 4) else {
            return Ok(ERROR);
        };
        result(compare_values(map_data, SIZE * SIZE, [2, 3, 4, 5]))
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let (width, height) = window_size(context);
        gl!(gl.viewport(0, 0, width, height));
        gl!(gl.use_program(0));
        gl!(gl.delete_buffers(1, &self.vbo));
        gl!(gl.delete_buffers(1, &self.ebo));
        gl!(gl.delete_textures(1, &self.texture));
        gl!(gl.delete_program(self.store_program));
        gl!(gl.delete_program(self.load_program));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.buffer));
        Ok(NO_ERROR)
    }
}

/// The texture of `AdvancedAllMipsFS` and `AdvancedAllMipsCS`: 8 levels of 128x128 RGBA32F, levels 6 to 3 bound as image units 0 to 3.
fn all_mips_texture(gl: &glw::Functions, texture: GLuint) {
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture));
    gl!(gl.tex_storage_2d(glw::GL_TEXTURE_2D, 8, glw::GL_RGBA32F, 128, 128));
    nearest_filtering(gl, glw::GL_TEXTURE_2D);
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
    for (unit, level) in [(0, 6), (1, 5), (2, 4), (3, 3)] {
        gl!(gl.bind_image_texture(unit, texture, level, glw::FALSE, 0, glw::GL_READ_WRITE, glw::GL_RGBA32F));
    }
}

/// 5.10 AdvancedAllMipsCS
#[derive(Default)]
struct AdvancedAllMipsCs {
    texture: GLuint,
    store_program: GLuint,
    load_program: GLuint,
    buffer: GLuint,
}

impl Subcase for AdvancedAllMipsCs {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_textures(1, &mut self.texture));
        gl!(gl.gen_buffers(1, &mut self.buffer));
        self.store_program = create_compute_program(gl, ADVANCED_ALL_MIPS_C_S_GLSL_STORE_CS);
        self.load_program = create_compute_program(gl, ADVANCED_ALL_MIPS_C_S_GLSL_LOAD_CS);
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        const SIZE: usize = 11;
        all_mips_texture(gl, self.texture);
        let data = vec![0u8; SIZE * SIZE * 4 * 4];
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (SIZE * SIZE * 4 * 4) as glw::GLsizeiptr,
            data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        gl!(gl.use_program(self.store_program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT));
        gl!(gl.use_program(self.load_program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let Some(map_data) = map_ssbo_at::<GLint>(gl, 0, SIZE * SIZE * 4) else {
            return Ok(ERROR);
        };
        result(compare_values(map_data, SIZE * SIZE, [2, 3, 4, 5]))
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_textures(1, &self.texture));
        gl!(gl.delete_program(self.store_program));
        gl!(gl.delete_program(self.load_program));
        gl!(gl.delete_buffers(1, &self.buffer));
        Ok(NO_ERROR)
    }
}

/// The two RGBA8 textures of `AdvancedCastFS` and `AdvancedCastCS` (on texture units 11 and 15) bound as R32I and R32UI images 0 and 1.
fn cast_textures(gl: &glw::Functions, textures: &[GLuint; 2], size: usize) {
    let data = vec![0u8; size * size * 4 * 4];
    for (unit, texture) in [(glw::GL_TEXTURE11, textures[0]), (glw::GL_TEXTURE15, textures[1])] {
        gl!(gl.active_texture(unit));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture));
        gl!(gl.tex_storage_2d(
            glw::GL_TEXTURE_2D,
            1,
            glw::GL_RGBA8,
            size as glw::GLsizei,
            size as glw::GLsizei
        ));
        gl!(gl.tex_sub_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            0,
            0,
            size as glw::GLsizei,
            size as glw::GLsizei,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            data.as_ptr().cast()
        ));
        nearest_filtering(gl, glw::GL_TEXTURE_2D);
    }
    gl!(gl.bind_image_texture(0, textures[0], 0, glw::FALSE, 0, glw::GL_READ_WRITE, glw::GL_R32I));
    gl!(gl.bind_image_texture(1, textures[1], 0, glw::FALSE, 0, glw::GL_READ_WRITE, glw::GL_R32UI));
}

/// 5.11 AdvancedCastFS
#[derive(Default)]
struct AdvancedCastFs {
    texture: [GLuint; 2],
    program: GLuint,
    c_program: GLuint,
    vao: GLuint,
    vbo: GLuint,
    ebo: GLuint,
    buffer: GLuint,
}

impl Subcase for AdvancedCastFs {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_textures(2, self.texture.as_mut_ptr()));
        gl!(gl.gen_buffers(1, &mut self.buffer));
        self.program = 0;
        self.c_program = 0;
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 0, 2) || !is_image_atomic_supported(context) {
            return Ok(NOT_SUPPORTED);
        }
        const SIZE: usize = 11;
        create_full_viewport_quad(gl, &mut self.vao, &mut self.vbo, Some(&mut self.ebo));

        self.program = build_program_with(gl, ADVANCED_CAST_F_S_GLSL_VS, ADVANCED_CAST_F_S_GLSL_FS, false, true);
        self.c_program = create_compute_program(gl, ADVANCED_CAST_F_S_GLSL_CS);

        cast_textures(gl, &self.texture, SIZE);
        let data = vec![0u8; SIZE * SIZE * 4 * 4];
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (SIZE * SIZE * 4 * 4) as glw::GLsizeiptr,
            data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));

        gl!(gl.use_program(self.program));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.viewport(0, 0, SIZE as glw::GLsizei, SIZE as glw::GLsizei));
        gl!(gl.draw_elements(glw::GL_TRIANGLE_STRIP, 4, glw::GL_UNSIGNED_SHORT, std::ptr::null()));
        gl!(gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT));
        gl!(gl.use_program(self.c_program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let Some(map_data) = map_ssbo_at::<GLint>(gl, 0, SIZE * SIZE * 4) else {
            return Ok(ERROR);
        };
        result(compare_values(map_data, SIZE * SIZE, [0, 1, 0, 3]))
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let (width, height) = window_size(context);
        gl!(gl.viewport(0, 0, width, height));
        gl!(gl.use_program(0));
        gl!(gl.delete_buffers(1, &self.vbo));
        gl!(gl.delete_buffers(1, &self.ebo));
        gl!(gl.delete_buffers(1, &self.buffer));
        gl!(gl.delete_textures(2, self.texture.as_ptr()));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_program(self.c_program));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.active_texture(glw::GL_TEXTURE0));
        Ok(NO_ERROR)
    }
}

/// 5.12 AdvancedCastCS
#[derive(Default)]
struct AdvancedCastCs {
    texture: [GLuint; 2],
    program: GLuint,
    c_program: GLuint,
    buffer: GLuint,
}

impl Subcase for AdvancedCastCs {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_textures(2, self.texture.as_mut_ptr()));
        gl!(gl.gen_buffers(1, &mut self.buffer));
        self.program = 0;
        self.c_program = 0;
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        const SIZE: usize = 11;
        if !is_image_atomic_supported(context) {
            return Ok(NO_ERROR);
        }

        self.program = create_compute_program_sia(gl, ADVANCED_CAST_C_S_GLSL_CS);
        self.c_program = create_compute_program(gl, ADVANCED_CAST_C_S_GLSL_CS_C);

        cast_textures(gl, &self.texture, SIZE);
        let data = vec![0u8; SIZE * SIZE * 4 * 4];
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            (SIZE * SIZE * 4 * 4) as glw::GLsizeiptr,
            data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));

        gl!(gl.use_program(self.program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT));
        gl!(gl.use_program(self.c_program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let Some(map_data) = map_ssbo_at::<GLint>(gl, 0, SIZE * SIZE * 4) else {
            return Ok(ERROR);
        };
        result(compare_values(map_data, SIZE * SIZE, [0, 211, 1, 3]))
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_buffers(1, &self.buffer));
        gl!(gl.delete_textures(2, self.texture.as_ptr()));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_program(self.c_program));
        gl!(gl.active_texture(glw::GL_TEXTURE0));
        Ok(NO_ERROR)
    }
}

/// 3.4 BasicGLSLConst
#[derive(Default)]
struct BasicGlslConst {
    program: GLuint,
    buffer: GLuint,
}

impl Subcase for BasicGlslConst {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let src_cs = CONST_CS;
        self.program = create_compute_program(gl, src_cs);
        gl!(gl.use_program(self.program));

        for (pname, name) in [
            (glw::GL_MAX_IMAGE_UNITS, "MaxImageUnits"),
            (
                glw::GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES,
                "MaxCombinedShaderOutputResources",
            ),
            (glw::GL_MAX_VERTEX_IMAGE_UNIFORMS, "MaxVertexImageUniforms"),
            (glw::GL_MAX_FRAGMENT_IMAGE_UNIFORMS, "MaxFragmentImageUniforms"),
            (glw::GL_MAX_COMPUTE_IMAGE_UNIFORMS, "MaxComputeImageUniforms"),
            (glw::GL_MAX_COMBINED_IMAGE_UNIFORMS, "MaxCombinedImageUniforms"),
        ] {
            let value = get_integer(gl, pname);
            gl!(gl.uniform_1i(uniform_location(gl, self.program, name), value));
        }

        let out_data = [0 as GLint; 4];
        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            4 * 4,
            out_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        let map_data =
            gl!(gl.map_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, 0, 4 * 4, glw::GL_MAP_READ_BIT)) as *const GLint;
        if map_data.is_null() {
            return Ok(ERROR);
        }
        // SAFETY: the mapping covers the four integers requested above.
        let value = unsafe { std::slice::from_raw_parts(map_data, 4) };
        if value != [0, 1, 0, 1] {
            log::info!("Value is {value:?} should be [0, 1, 0, 1].");
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        gl!(gl.delete_buffers(1, &self.buffer));
        Ok(NO_ERROR)
    }
}

const CONST_CS: &str = "\nlayout (local_size_x = 1) in;\nlayout(std430) buffer out_data {\n  ivec4 o_color;\n};\nuniform int MaxImageUnits;\nuniform int MaxCombinedShaderOutputResources;\nuniform int MaxVertexImageUniforms;\nuniform int MaxFragmentImageUniforms;\nuniform int MaxComputeImageUniforms;\nuniform int MaxCombinedImageUniforms;\nvoid main() {\n  o_color = ivec4(0, 1, 0, 1);\n  if (gl_MaxImageUnits != MaxImageUnits) o_color = ivec4(1, 0, 0, 1);\n  if (gl_MaxCombinedShaderOutputResources != MaxCombinedShaderOutputResources) o_color = ivec4(1, 0, 0, 2);\n  if (gl_MaxVertexImageUniforms != MaxVertexImageUniforms) o_color = ivec4(1, 0, 0, 4);\n  if (gl_MaxFragmentImageUniforms != MaxFragmentImageUniforms) o_color = ivec4(1, 0, 0, 5);\n  if (gl_MaxComputeImageUniforms != MaxComputeImageUniforms) o_color = ivec4(1, 0, 0, 6);\n  if (gl_MaxCombinedImageUniforms != MaxCombinedImageUniforms) o_color = ivec4(1, 0, 0, 9);\n}";

/// 4.1 NegativeUniform
#[derive(Default)]
struct NegativeUniform {
    program: GLuint,
}

impl Subcase for NegativeUniform {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_vs =
            "#version 310 es\nlayout(location = 0) in vec4 i_position;\nvoid main() {\n  gl_Position = i_position;\n}";
        let glsl_fs = "#version 310 es\nlayout(rgba32f) writeonly uniform image2D g_image;\nvoid main() {\n  ivec2 coord = ivec2(gl_FragCoord.xy);\n  imageStore(g_image, coord, vec4(0.0));\n  discard;\n}";
        self.program = build_program(gl, Some(glsl_vs), Some(glsl_fs));
        let _max_image_units = get_integer(gl, glw::GL_MAX_IMAGE_UNITS);

        gl!(gl.use_program(self.program));
        let mut status = true;
        let i: GLint = 1;
        let location = |program: GLuint| uniform_location(gl, program, "g_image");
        let expect_invalid_operation = |status: &mut bool| {
            if gl!(gl.get_error()) != glw::GL_INVALID_OPERATION {
                *status = false;
            }
        };
        gl!(gl.uniform_1i(location(self.program), 1));
        expect_invalid_operation(&mut status);
        gl!(gl.uniform_1iv(location(self.program), 1, &i));
        expect_invalid_operation(&mut status);
        gl!(gl.uniform_1ui(location(self.program), 0));
        expect_invalid_operation(&mut status);
        gl!(gl.uniform_2i(location(self.program), 0, 0));
        expect_invalid_operation(&mut status);
        if !status {
            log::info!("glUniform* should generate INVALID_OPERATION if the location refers to an image variable.");
            return Ok(ERROR);
        }

        gl!(gl.use_program(0));
        gl!(gl.program_uniform_1i(self.program, location(self.program), 1));
        expect_invalid_operation(&mut status);
        gl!(gl.program_uniform_1iv(self.program, location(self.program), 1, &i));
        expect_invalid_operation(&mut status);
        gl!(gl.program_uniform_1ui(self.program, location(self.program), 0));
        expect_invalid_operation(&mut status);
        gl!(gl.program_uniform_2i(self.program, location(self.program), 0, 0));
        expect_invalid_operation(&mut status);
        if !status {
            log::info!(
                "glProgramUniform* should generate INVALID_OPERATION if the location refers to an image variable."
            );
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.use_program(0));
        gl!(gl.delete_program(self.program));
        Ok(NO_ERROR)
    }
}

/// 4.2 NegativeBind
#[derive(Default)]
struct NegativeBind {
    texture: GLuint,
    texture2: GLuint,
}

impl Subcase for NegativeBind {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let max_image_units = get_integer(gl, glw::GL_MAX_IMAGE_UNITS);
        gl!(gl.gen_textures(1, &mut self.texture));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture));
        gl!(gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA32F, 64, 64));

        let texture = self.texture;
        let expect = |expected: GLenum, message: &str| -> bool {
            if gl!(gl.get_error()) != expected {
                log::info!("{message}");
                return false;
            }
            true
        };

        gl!(gl.bind_image_texture(
            max_image_units as GLuint,
            texture,
            0,
            glw::FALSE,
            0,
            glw::GL_READ_ONLY,
            glw::GL_RGBA32F
        ));
        if !expect(
            glw::GL_INVALID_VALUE,
            "BindImageTexture should generate INVALID_VALUE if <unit> is greater than or equal to the value of MAX_IMAGE_UNITS.",
        ) {
            return Ok(ERROR);
        }
        gl!(gl.bind_image_texture(0, 123, 0, glw::FALSE, 0, glw::GL_READ_ONLY, glw::GL_RGBA32F));
        if !expect(
            glw::GL_INVALID_VALUE,
            "BindImageTexture should generate INVALID_VALUE if <texture> is not the name of an existing texture object.",
        ) {
            return Ok(ERROR);
        }
        gl!(gl.bind_image_texture(1, texture, 0, glw::FALSE, 0, glw::GL_READ_ONLY, glw::GL_RGBA));
        if !expect(
            glw::GL_INVALID_VALUE,
            "BindImageTexture should generate INVALID_VALUE if <format> is not a legal format.",
        ) {
            return Ok(ERROR);
        }
        gl!(gl.bind_image_texture(1, texture, -1, glw::FALSE, 0, glw::GL_READ_ONLY, glw::GL_RGBA32F));
        if !expect(
            glw::GL_INVALID_VALUE,
            "BindImageTexture should generate INVALID_VALUE if <level> is less than zero.",
        ) {
            return Ok(ERROR);
        }
        gl!(gl.bind_image_texture(1, texture, 0, glw::FALSE, -1, glw::GL_READ_ONLY, glw::GL_RGBA32F));
        if !expect(
            glw::GL_INVALID_VALUE,
            "BindImageTexture should generate INVALID_VALUE if <layer> is less than zero.",
        ) {
            return Ok(ERROR);
        }

        if !is_at_least_gl_45(context) {
            gl!(gl.gen_textures(1, &mut self.texture2));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.texture2));
            gl!(gl.bind_image_texture(1, self.texture2, 0, glw::FALSE, 0, glw::GL_READ_ONLY, glw::GL_RGBA32F));
            if !expect(
                glw::GL_INVALID_OPERATION,
                "BindImageTexture should generate INVALID_OPERATION if <texture> is a mutable texture object.",
            ) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_textures(1, &self.texture));
        gl!(gl.delete_textures(1, &self.texture2));
        Ok(NO_ERROR)
    }
}

/// 4.3 NegativeCompileErrors
#[derive(Default)]
struct NegativeCompileErrors;

impl NegativeCompileErrors {
    /// `Compile`: the source has to fail to compile as a compute shader and as a fragment shader.
    fn compile(gl: &glw::Functions, source: &str) -> bool {
        for (shader_type, version) in [
            (glw::GL_COMPUTE_SHADER, "#version 310 es\nlayout(local_size_x = 1) in;"),
            (glw::GL_FRAGMENT_SHADER, "#version 310 es\nprecision highp float;"),
        ] {
            let shader = gl!(gl.create_shader(shader_type));
            shader_source(gl, shader, &[version, GLSL_PREC, source]);
            gl!(gl.compile_shader(shader));
            let mut log = [0u8; 1024];
            gl!(gl.get_shader_info_log(
                shader,
                log.len() as glw::GLsizei,
                std::ptr::null_mut(),
                log.as_mut_ptr().cast()
            ));
            let status = shader_status(gl, shader);
            gl!(gl.delete_shader(shader));
            if status == glw::GL_TRUE as GLint {
                log::info!("Shader should not compile (shader type {shader_type:#x}):\n{version}{GLSL_PREC}{source}");
                return false;
            }
        }
        true
    }
}

impl Subcase for NegativeCompileErrors {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let sources = [
            "\nlayout(rgba32f) writeonly readonly uniform image2D g_image;\nvoid main() {\n  vec4 o_color;\n  o_color = imageLoad(g_image, ivec2(0));\n}",
            "\nlayout(rgba32f) writeonly uniform image2D g_image;\nvoid main() {\n  vec4 o_color;\n  o_color = imageLoad(g_image, ivec2(0));\n}",
            "\nuniform vec4 i_color;\nlayout(rgba32f) readonly uniform image2D g_image;\nvoid main() {\n  vec4 o_color;\n  imageStore(g_image, ivec2(0), i_color);\n  o_color = i_color;\n}",
            "\nuniform image2D g_image;\nvoid main() {\n  vec4 o_color;\n  o_color = imageLoad(g_image, ivec2(0));\n}",
            "\nreadonly uniform image2D g_image;\nvoid main() {\n  vec4 o_color;\n  o_color = imageLoad(g_image, ivec2(0));\n}",
            "\nlayout(r32i) uniform image1D g_image;\nvoid main() {\n  vec4 o_color;\n  o_color = vec4(1.0);\n}",
            "\nlayout(rgba16) writeonly uniform iimage2D g_image;\nvoid main() {\n  vec4 o_color;\n  o_color = vec4(1.0);\n}",
            "\n#extension GL_OES_shader_image_atomic : require\nlayout(r32f) coherent uniform image2D g_image;\nvoid main() {\n  vec4 o_color;\n  imageAtomicAdd(g_image, ivec2(1), 10);\n  o_color = vec4(1.0);\n}",
            "\n#extension GL_OES_shader_image_atomic : require\nlayout(rgba8i) coherent uniform iimage2D g_image;\nvoid main() {\n  vec4 o_color;\n  imageAtomicAdd(g_image, ivec2(1), 1);\n  o_color = vec4(1.0);\n}",
            "\nlayout(r32ui) uniform iimage3D g_image;\nvoid main() {\n  vec4 o_color;\n  imageStore(g_image, ivec3(1), ivec4(1));\n  o_color = vec4(1.0);\n}",
            "\nlayout(r32f) uniform uimage2DArray g_image;\nvoid main() {\n  vec4 o_color;\n  imageStore(g_image, ivec3(0), uvec4(1));\n  o_color = vec4(1.0);\n}",
            "\nlayout(r32f) coherent uniform image2D g_image;\nvec4 Load(iimage2D image) {\n  return imageLoad(image, vec2(0));\n}\nvoid main() {\n  vec4 o_color;\n  o_color = Load(g_image);\n}",
        ];
        for source in sources {
            if !Self::compile(gl, source) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }
}

/// 4.4 NegativeLinkErrors
#[derive(Default)]
struct NegativeLinkErrors;

impl NegativeLinkErrors {
    /// `Link`: both stages have to compile and the program has to fail to link.
    fn link(gl: &glw::Functions, vs: &str, fs: &str) -> bool {
        let program = gl!(gl.create_program());
        let vsh = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        gl!(gl.attach_shader(program, vsh));
        gl!(gl.delete_shader(vsh));
        shader_source(gl, vsh, &[GLSL_VER, vs]);
        gl!(gl.compile_shader(vsh));

        let fsh = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        gl!(gl.attach_shader(program, fsh));
        gl!(gl.delete_shader(fsh));
        shader_source(gl, fsh, &[GLSL_VER, fs]);
        gl!(gl.compile_shader(fsh));

        if shader_status(gl, vsh) == glw::GL_FALSE as GLint {
            gl!(gl.delete_program(program));
            log::info!("Vertex shader should compile:\n{GLSL_VER}{vs}");
            return false;
        }
        if shader_status(gl, fsh) == glw::GL_FALSE as GLint {
            gl!(gl.delete_program(program));
            log::info!("Fragment shader should compile:\n{GLSL_VER}{fs}");
            return false;
        }

        gl!(gl.link_program(program));
        let mut log = [0u8; 1024];
        gl!(gl.get_program_info_log(
            program,
            log.len() as glw::GLsizei,
            std::ptr::null_mut(),
            log.as_mut_ptr().cast()
        ));
        let status = program_status(gl, program);
        gl!(gl.delete_program(program));
        if status == glw::GL_TRUE as GLint {
            log::info!("Program should not link:\n{GLSL_VER}{vs}\n{GLSL_VER}{fs}");
            return false;
        }
        true
    }
}

impl Subcase for NegativeLinkErrors {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 1, 1) {
            return Ok(NOT_SUPPORTED);
        }
        let pairs = [
            (
                "\nlayout(location = 0) in vec4 i_position;\nlayout(rgba32f) writeonly uniform highp image3D g_image;\nvoid main() {\n  imageStore(g_image, ivec3(gl_VertexID), vec4(0));\n  gl_Position = i_position;\n}",
                "\nprecision highp float;\nlayout(location = 0) out vec4 o_color;\nlayout(rgba32f) writeonly uniform highp image2D g_image;\nvoid main() {\n  imageStore(g_image, ivec2(gl_FragCoord), vec4(1.0));\n  o_color = vec4(1.0);\n}",
            ),
            (
                "\nlayout(location = 0) in vec4 i_position;\nlayout(rgba32f) writeonly uniform highp image2D g_image;\nvoid main() {\n  imageStore(g_image, ivec2(gl_VertexID), vec4(0));\n  gl_Position = i_position;\n}",
                "\nprecision highp float;\nlayout(location = 0) out vec4 o_color;\nlayout(r32f) writeonly uniform highp image2D g_image;\nvoid main() {\n  imageStore(g_image, ivec2(gl_FragCoord), vec4(1.0));\n  o_color = vec4(1.0);\n}",
            ),
        ];
        for (vs, fs) in pairs {
            if !Self::link(gl, vs, fs) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }
}

fn add_case<S: Subcase + Default + 'static>(group: &mut TestCaseGroup, name: &str) {
    group.add_child(Box::new(TestSubcase::new(name, || Box::new(S::default()))) as Box<dyn TestCase>);
}

/// `glcts::ShaderImageLoadStoreTests::init` (the ported part, in upstream order)
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_image_load_store");
    add_case::<BasicApiGet>(&mut group, "basic-api-get");
    add_case::<BasicApiBind>(&mut group, "basic-api-bind");
    add_case::<BasicApiBarrier>(&mut group, "basic-api-barrier");
    add_case::<BasicApiBarrierByRegion>(&mut group, "basic-api-barrier-byRegion");
    add_case::<BasicApiTexParam>(&mut group, "basic-api-texParam");
    add_case::<formats::BasicAllFormatsStoreFs>(&mut group, "basic-allFormats-store-fs");
    add_case::<formats::BasicAllFormatsStoreCs>(&mut group, "basic-allFormats-store-cs");
    add_case::<formats::BasicAllFormatsLoadFs>(&mut group, "basic-allFormats-load-fs");
    add_case::<formats::BasicAllFormatsLoadCs>(&mut group, "basic-allFormats-load-cs");
    add_case::<formats::BasicAllFormatsLoadStoreComputeStage>(&mut group, "basic-allFormats-loadStoreComputeStage");
    add_case::<all_targets::BasicAllTargetsStoreFs>(&mut group, "basic-allTargets-store-fs");
    add_case::<all_targets::BasicAllTargetsStoreCs>(&mut group, "basic-allTargets-store-cs");
    add_case::<all_targets::BasicAllTargetsLoadFs>(&mut group, "basic-allTargets-load-fs");
    add_case::<all_targets::BasicAllTargetsLoadCs>(&mut group, "basic-allTargets-load-cs");
    add_case::<machines::BasicAllTargetsAtomicFs>(&mut group, "basic-allTargets-atomicFS");
    add_case::<machines::BasicAllTargetsLoadStore<false>>(&mut group, "basic-allTargets-loadStoreVS");
    add_case::<machines::BasicAllTargetsLoadStore<true>>(&mut group, "basic-allTargets-loadStoreCS");
    add_case::<machines::BasicAllTargetsAtomic<false>>(&mut group, "basic-allTargets-atomicVS");
    add_case::<machines::BasicAllTargetsAtomic<true>>(&mut group, "basic-allTargets-atomicCS");
    add_case::<BasicGlslMiscFs>(&mut group, "basic-glsl-misc-fs");
    add_case::<BasicGlslMiscCs>(&mut group, "basic-glsl-misc-cs");
    add_case::<BasicGlslEarlyFragTests>(&mut group, "basic-glsl-earlyFragTests");
    add_case::<BasicGlslConst>(&mut group, "basic-glsl-const");
    add_case::<AdvancedSyncImageAccess>(&mut group, "advanced-sync-imageAccess");
    add_case::<AdvancedSyncVertexArray>(&mut group, "advanced-sync-vertexArray");
    add_case::<AdvancedSyncImageAccess2>(&mut group, "advanced-sync-imageAccess2");
    add_case::<AdvancedAllStagesOneImage>(&mut group, "advanced-allStages-oneImage");
    add_case::<AdvancedMemoryOrderVsfs>(&mut group, "advanced-memory-order-vsfs");
    add_case::<AdvancedSsoSimple>(&mut group, "advanced-sso-simple");
    add_case::<AdvancedCopyImageFs>(&mut group, "advanced-copyImage-fs");
    add_case::<AdvancedCopyImageCs>(&mut group, "advanced-copyImage-cs");
    add_case::<AdvancedAllMipsFs>(&mut group, "advanced-allMips-fs");
    add_case::<AdvancedAllMipsCs>(&mut group, "advanced-allMips-cs");
    add_case::<AdvancedCastFs>(&mut group, "advanced-cast-fs");
    add_case::<AdvancedCastCs>(&mut group, "advanced-cast-cs");
    add_case::<NegativeUniform>(&mut group, "negative-uniform");
    add_case::<NegativeBind>(&mut group, "negative-bind");
    add_case::<NegativeCompileErrors>(&mut group, "negative-compileErrors");
    add_case::<NegativeLinkErrors>(&mut group, "negative-linkErrors");
    group
}
