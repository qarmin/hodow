// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcShaderImageLoadStoreTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `basic-allFormats-*` cases: upstream's `template <typename T>` over `vec4`/`ivec4`/`uvec4` is the `Texel4` trait here (`[f32; 4]`, `[i32; 4]`, `[u32; 4]`); `tcu::Vector`'s `operator<<` becomes `glsl`.

use super::super::subcase::{NO_ERROR, NOT_SUPPORTED, Subcase, SubcaseResult};
use super::{
    build_program, create_compute_program, create_full_viewport_quad, is_ssb_in_vsfs_available, is_vsfs_available,
    map_ssbo_at, nearest_filtering, result, window_size,
};
use crate::glu::Context;
use crate::glw::{self, GLenum, GLuint};

pub(super) trait Texel4: Copy + PartialEq + std::fmt::Debug {
    /// `TypePrefix<T>`
    const PREFIX: &'static str;

    /// `operator<<` of the vector: `(1, 2, 3, 4)`.
    fn glsl(self) -> String;

    /// `Equal(T, T, internalformat)`
    fn equal(a: Self, b: Self, internalformat: GLenum) -> bool;

    /// The components as numbers, for the short and byte conversions of `ShortByteData`.
    fn as_f64(self) -> [f64; 4];

    /// The little-endian bytes of one component, for the raw upload of `ShortByteData::data`.
    fn component_bytes(self, index: usize) -> [u8; 4];
}

fn join<T: std::fmt::Display>(values: &[T; 4]) -> String {
    format!("({}, {}, {}, {})", values[0], values[1], values[2], values[3])
}

impl Texel4 for [f32; 4] {
    const PREFIX: &'static str = "";

    fn glsl(self) -> String {
        join(&self)
    }

    fn equal(a: Self, b: Self, internalformat: GLenum) -> bool {
        if internalformat == glw::GL_RGBA8_SNORM || internalformat == glw::GL_RGBA8 {
            return (0..4).all(|i| (a[i] - b[i]).abs() <= 0.01);
        }
        a == b
    }

    fn as_f64(self) -> [f64; 4] {
        self.map(f64::from)
    }

    fn component_bytes(self, index: usize) -> [u8; 4] {
        self[index].to_le_bytes()
    }
}

impl Texel4 for [i32; 4] {
    const PREFIX: &'static str = "i";

    fn glsl(self) -> String {
        join(&self)
    }

    fn equal(a: Self, b: Self, _internalformat: GLenum) -> bool {
        a == b
    }

    fn as_f64(self) -> [f64; 4] {
        self.map(f64::from)
    }

    fn component_bytes(self, index: usize) -> [u8; 4] {
        self[index].to_le_bytes()
    }
}

impl Texel4 for [u32; 4] {
    const PREFIX: &'static str = "u";

    fn glsl(self) -> String {
        join(&self)
    }

    fn equal(a: Self, b: Self, _internalformat: GLenum) -> bool {
        a == b
    }

    fn as_f64(self) -> [f64; 4] {
        self.map(f64::from)
    }

    fn component_bytes(self, index: usize) -> [u8; 4] {
        self[index].to_le_bytes()
    }
}

/// `FormatEnumToString`
pub(super) fn format_enum_to_string(format: GLenum) -> &'static str {
    match format {
        glw::GL_RGBA32F => "rgba32f",
        glw::GL_RGBA16F => "rgba16f",
        glw::GL_R32F => "r32f",
        glw::GL_RGBA32UI => "rgba32ui",
        glw::GL_RGBA16UI => "rgba16ui",
        glw::GL_RGBA8UI => "rgba8ui",
        glw::GL_R32UI => "r32ui",
        glw::GL_RGBA32I => "rgba32i",
        glw::GL_RGBA16I => "rgba16i",
        glw::GL_RGBA8I => "rgba8i",
        glw::GL_R32I => "r32i",
        glw::GL_RGBA8 => "rgba8",
        glw::GL_RGBA8_SNORM => "rgba8_snorm",
        _ => "",
    }
}

/// The 13 `(internalformat, written value, expected value)` rows of the `Write`/`WriteCS`/`Read` runs of one value type.
fn float_rows() -> [(GLenum, [f32; 4], [f32; 4]); 5] {
    [
        (glw::GL_RGBA32F, [1.0, 2.0, 3.0, 4.0], [1.0, 2.0, 3.0, 4.0]),
        (glw::GL_R32F, [1.0, 2.0, 3.0, 4.0], [1.0, 0.0, 0.0, 1.0]),
        (glw::GL_RGBA16F, [1.0, 2.0, 3.0, 4.0], [1.0, 2.0, 3.0, 4.0]),
        (glw::GL_RGBA8, [1.0; 4], [1.0; 4]),
        (glw::GL_RGBA8_SNORM, [1.0, -1.0, 1.0, -1.0], [1.0, -1.0, 1.0, -1.0]),
    ]
}

fn int_rows() -> [(GLenum, [i32; 4], [i32; 4]); 4] {
    [
        (glw::GL_RGBA32I, [1, -2, 3, -4], [1, -2, 3, -4]),
        (glw::GL_R32I, [1, -2, 3, -4], [1, 0, 0, 1]),
        (glw::GL_RGBA16I, [1, -2, 3, -4], [1, -2, 3, -4]),
        (glw::GL_RGBA8I, [1, -2, 3, -4], [1, -2, 3, -4]),
    ]
}

fn uint_rows() -> [(GLenum, [u32; 4], [u32; 4]); 4] {
    [
        (glw::GL_RGBA32UI, [0, 1, 2, 3], [0, 1, 2, 3]),
        (glw::GL_R32UI, [7, 2, 3, 4], [7, 0, 0, 1]),
        (glw::GL_RGBA16UI, [0, 1, 2, 3], [0, 1, 2, 3]),
        (glw::GL_RGBA8UI, [0, 1, 2, 3], [0, 1, 2, 3]),
    ]
}

/// Runs `check` over the rows in the order of upstream's `Run`: RGBA32F, R32F, RGBA16F, the integer formats, the unsigned formats, RGBA8, RGBA8_SNORM.
fn run_rows(
    mut check_float: impl FnMut(GLenum, [f32; 4], [f32; 4]) -> bool,
    mut check_int: impl FnMut(GLenum, [i32; 4], [i32; 4]) -> bool,
    mut check_uint: impl FnMut(GLenum, [u32; 4], [u32; 4]) -> bool,
) -> bool {
    let float = float_rows();
    let (int, uint) = (int_rows(), uint_rows());
    float[..3]
        .iter()
        .all(|(format, write, expected)| check_float(*format, *write, *expected))
        && int
            .iter()
            .all(|(format, write, expected)| check_int(*format, *write, *expected))
        && uint
            .iter()
            .all(|(format, write, expected)| check_uint(*format, *write, *expected))
        && float[3..]
            .iter()
            .all(|(format, write, expected)| check_float(*format, *write, *expected))
}

/// The common tail of `Write`, `WriteCS`: the compute shader `GenC` copies the texture into an SSBO and the result is compared with `expected_value`.
fn read_back_and_compare<T: Texel4>(
    gl: &glw::Functions,
    texture: GLuint,
    size: usize,
    expected_value: T,
    internalformat: GLenum,
    unit: GLuint,
    c_source: &str,
) -> bool {
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture));
    gl!(gl.memory_barrier(glw::GL_TEXTURE_FETCH_BARRIER_BIT));
    let c_program = create_compute_program(gl, c_source);
    let out_data = vec![0u8; size * size * 4 * 4];
    let mut buffer: GLuint = 0;
    gl!(gl.gen_buffers(1, &mut buffer));
    gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, buffer));
    gl!(gl.buffer_data(
        glw::GL_SHADER_STORAGE_BUFFER,
        (size * size * 4 * 4) as glw::GLsizeiptr,
        out_data.as_ptr().cast(),
        glw::GL_STATIC_DRAW
    ));
    gl!(gl.use_program(c_program));
    gl!(gl.dispatch_compute(1, 1, 1));
    gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

    let mut is_ok = true;
    match map_ssbo_at::<T>(gl, 0, size * size) {
        Some(map_data) => {
            for value in map_data {
                if !T::equal(*value, expected_value, internalformat) {
                    log::info!(
                        "Value is {value:?}. Value should be: {expected_value:?}. Format is: {}. Unit is: {unit}",
                        format_enum_to_string(internalformat)
                    );
                    is_ok = false;
                    break;
                }
            }
        }
        None => is_ok = false,
    }
    gl!(gl.delete_textures(1, &texture));
    gl!(gl.use_program(0));
    gl!(gl.delete_program(c_program));
    gl!(gl.delete_buffers(1, &buffer));
    is_ok
}

const WRITE_FS_VS: &str = "\nlayout(location = 0) in vec4 i_position;\nvoid main() {\n  gl_Position = i_position;\n}";

fn gen_c<T: Texel4>(size: usize, value: T) -> String {
    let prefix = T::PREFIX;
    format!(
        "\n#define KSIZE {size}\nlayout (local_size_x = KSIZE, local_size_y = KSIZE) in;\nuniform {prefix}sampler2D g_sampler;\nlayout(std430) buffer OutputBuffer {{\n  {prefix}vec4 data[KSIZE*KSIZE];\n}};\nvoid main() {{\n  data[gl_LocalInvocationIndex] = texelFetch(g_sampler, ivec2(gl_LocalInvocationID), 0);\n  //data[gl_LocalInvocationIndex] = {prefix}vec4{};\n}}",
        value.glsl()
    )
}

fn new_nearest_texture(gl: &glw::Functions, internalformat: GLenum, size: usize) -> GLuint {
    let mut texture: GLuint = 0;
    gl!(gl.gen_textures(1, &mut texture));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture));
    nearest_filtering(gl, glw::GL_TEXTURE_2D);
    gl!(gl.tex_storage_2d(
        glw::GL_TEXTURE_2D,
        1,
        internalformat,
        size as glw::GLsizei,
        size as glw::GLsizei
    ));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
    texture
}

/// 2.1 BasicAllFormatsStoreFS
#[derive(Default)]
pub(super) struct BasicAllFormatsStoreFs {
    vao: GLuint,
    vbo: GLuint,
}

impl BasicAllFormatsStoreFs {
    fn write<T: Texel4>(&self, gl: &glw::Functions, internalformat: GLenum, write_value: T, expected_value: T) -> bool {
        const SIZE: usize = 11;
        let prefix = T::PREFIX;
        let fs = format!(
            "\nlayout({}, binding = 2) writeonly uniform {prefix}image2D g_image;\nvoid main() {{\n  ivec2 coord = ivec2(gl_FragCoord.xy);\n  imageStore(g_image, coord, {prefix}vec4{});\n  discard;\n}}",
            format_enum_to_string(internalformat),
            write_value.glsl()
        );
        let program = build_program(gl, Some(WRITE_FS_VS), Some(&fs));
        gl!(gl.use_program(program));
        let unit: GLuint = 2;
        let texture = new_nearest_texture(gl, internalformat, SIZE);
        gl!(gl.viewport(0, 0, SIZE as glw::GLsizei, SIZE as glw::GLsizei));
        gl!(gl.bind_image_texture(unit, texture, 0, glw::FALSE, 0, glw::GL_WRITE_ONLY, internalformat));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        let is_ok = read_back_and_compare(
            gl,
            texture,
            SIZE,
            expected_value,
            internalformat,
            unit,
            &gen_c(SIZE, write_value),
        );
        gl!(gl.delete_program(program));
        is_ok
    }
}

impl Subcase for BasicAllFormatsStoreFs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 0, 1) {
            return Ok(NOT_SUPPORTED);
        }
        create_full_viewport_quad(gl, &mut self.vao, &mut self.vbo, None);
        let this = &*self;
        result(run_rows(
            |format, write, expected| this.write(gl, format, write, expected),
            |format, write, expected| this.write(gl, format, write, expected),
            |format, write, expected| this.write(gl, format, write, expected),
        ))
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let (width, height) = window_size(context);
        gl!(gl.viewport(0, 0, width, height));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.vbo));
        Ok(NO_ERROR)
    }
}

/// 2.2 BasicAllFormatsStoreCS
#[derive(Default)]
pub(super) struct BasicAllFormatsStoreCs;

impl BasicAllFormatsStoreCs {
    fn write_cs<T: Texel4>(gl: &glw::Functions, internalformat: GLenum, write_value: T, expected_value: T) -> bool {
        const SIZE: usize = 4;
        let prefix = T::PREFIX;
        let cs = format!(
            "\n#define KSIZE 4\nlayout({}) writeonly uniform {prefix}image2D g_image;\nlayout (local_size_x = KSIZE, local_size_y = KSIZE) in;\nvoid main() {{\n  ivec2 thread_xy = ivec2(gl_LocalInvocationID);\n  imageStore(g_image, thread_xy, {prefix}vec4{});\n}}",
            format_enum_to_string(internalformat),
            write_value.glsl()
        );
        let program = create_compute_program(gl, &cs);
        let unit: GLuint = 0;
        let texture = new_nearest_texture(gl, internalformat, SIZE);
        gl!(gl.bind_image_texture(unit, texture, 0, glw::FALSE, 0, glw::GL_WRITE_ONLY, internalformat));
        gl!(gl.use_program(program));
        gl!(gl.dispatch_compute(1, 1, 1));
        let c_source = gen_c(SIZE, expected_value);
        let is_ok = read_back_and_compare(gl, texture, SIZE, expected_value, internalformat, unit, &c_source);
        gl!(gl.delete_program(program));
        is_ok
    }
}

impl Subcase for BasicAllFormatsStoreCs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        result(run_rows(
            |format, write, expected| Self::write_cs(gl, format, write, expected),
            |format, write, expected| Self::write_cs(gl, format, write, expected),
            |format, write, expected| Self::write_cs(gl, format, write, expected),
        ))
    }
}

fn shorts(internalformat: GLenum) -> bool {
    internalformat == glw::GL_RGBA16I || internalformat == glw::GL_RGBA16UI
}

fn bytes(internalformat: GLenum) -> bool {
    matches!(
        internalformat,
        glw::GL_RGBA8I | glw::GL_RGBA8UI | glw::GL_RGBA8 | glw::GL_RGBA8_SNORM
    )
}

/// `ShortByteData<T>`: the pixel data of a `size` x `size` texture filled with `value`, packed as the short, byte or raw (`T`) array the upload of `internalformat` reads.
fn texture_data<T: Texel4>(value: T, internalformat: GLenum, format: GLenum, size: usize) -> Vec<u8> {
    let texels = size * size;
    let v = value.as_f64();
    if shorts(internalformat) {
        return (0..texels)
            .flat_map(|_| v.iter().flat_map(|component| (*component as i64 as i16).to_le_bytes()))
            .collect();
    }
    if bytes(internalformat) {
        let scale = match internalformat {
            glw::GL_RGBA8 => 255.0,
            glw::GL_RGBA8_SNORM => 127.0,
            _ => 1.0,
        };
        return (0..texels)
            .flat_map(|_| v.iter().map(|component| (*component * scale) as i64 as i8 as u8))
            .collect();
    }
    if format == glw::GL_RED || format == glw::GL_RED_INTEGER {
        // The single-component rewrite of `ShortByteData` leaves the first component of the value in every texel.
        return (0..texels).flat_map(|_| value.component_bytes(0)).collect();
    }
    (0..texels)
        .flat_map(|_| (0..4).flat_map(|k| value.component_bytes(k)))
        .collect()
}

fn gen_load_fs<T: Texel4>(internalformat: GLenum, expected_value: T) -> String {
    let prefix = T::PREFIX;
    format!(
        "\n#define KSIZE 11\nlayout({}, binding = 1) readonly uniform {prefix}image2D g_image;\nlayout(std430) buffer OutputBuffer {{\n  {prefix}vec4 data[KSIZE*KSIZE];\n}};\nvoid main() {{\n  ivec2 coord = ivec2(gl_FragCoord.xy);\n  {prefix}vec4 v = imageLoad(g_image, coord);\n  data[coord.y * KSIZE + coord.x] = v;\n  //data[coord.y * KSIZE + coord.x] = {prefix}vec4{};\n  discard;\n}}",
        format_enum_to_string(internalformat),
        expected_value.glsl()
    )
}

fn gen_load_cs<T: Texel4>(internalformat: GLenum, expected_value: T) -> String {
    let prefix = T::PREFIX;
    format!(
        "\n#define KSIZE 4\nlayout (local_size_x = KSIZE, local_size_y = KSIZE) in;\nlayout({}, binding = 1) readonly uniform {prefix}image2D g_image;\nlayout(std430) buffer OutputBuffer {{\n  {prefix}vec4 data[KSIZE*KSIZE];\n}};\nvoid main() {{\n  ivec2 coord = ivec2(gl_LocalInvocationID);\n  {prefix}vec4 v = imageLoad(g_image, coord);\n  data[gl_LocalInvocationIndex] = v;\n  //data[gl_LocalInvocationIndex] = {prefix}vec4{};\n}}",
        format_enum_to_string(internalformat),
        expected_value.glsl()
    )
}

fn upload(gl: &glw::Functions, size: usize, format: GLenum, type_: GLenum, bytes: &[u8]) {
    gl!(gl.tex_sub_image_2d(
        glw::GL_TEXTURE_2D,
        0,
        0,
        0,
        size as glw::GLsizei,
        size as glw::GLsizei,
        format,
        type_,
        bytes.as_ptr().cast()
    ));
}

/// The compute shader result buffer of `Read`/`ReadCS`: an SSBO of `size * size` vectors, mapped and compared with `expected_value`.
fn compare_ssbo<T: Texel4>(
    gl: &glw::Functions,
    size: usize,
    expected_value: T,
    internalformat: GLenum,
    unit: GLuint,
) -> bool {
    match map_ssbo_at::<T>(gl, 0, size * size) {
        Some(map_data) => {
            for (i, value) in map_data.iter().enumerate() {
                if !T::equal(*value, expected_value, internalformat) {
                    log::info!(
                        "[{i}] Value is: {value:?}. Value should be: {expected_value:?}. Format is: {}. Unit is: {unit}",
                        format_enum_to_string(internalformat)
                    );
                    return false;
                }
            }
            true
        }
        None => false,
    }
}

fn new_ssbo(gl: &glw::Functions, size: usize) -> GLuint {
    let mut buffer: GLuint = 0;
    let out_data = vec![0u8; size * size * 4 * 4];
    gl!(gl.gen_buffers(1, &mut buffer));
    gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, buffer));
    gl!(gl.buffer_data(
        glw::GL_SHADER_STORAGE_BUFFER,
        (size * size * 4 * 4) as glw::GLsizeiptr,
        out_data.as_ptr().cast(),
        glw::GL_STATIC_DRAW
    ));
    buffer
}

/// The rows of `Read`/`ReadCS`: `(internalformat, value, expected value, format, type)` in upstream's order.
fn read_rows<R>(
    mut float: impl FnMut(GLenum, [f32; 4], [f32; 4], GLenum, GLenum) -> R,
    mut int: impl FnMut(GLenum, [i32; 4], [i32; 4], GLenum, GLenum) -> R,
    mut uint: impl FnMut(GLenum, [u32; 4], [u32; 4], GLenum, GLenum) -> R,
    check: impl Fn(R) -> bool,
) -> bool {
    let f = [1.0, 2.0, 3.0, 4.0];
    let i = [1, -2, 3, -4];
    let u = [0, 1, 2, 3];
    check(float(glw::GL_RGBA32F, f, f, glw::GL_RGBA, glw::GL_FLOAT))
        && check(float(glw::GL_R32F, f, [1.0, 0.0, 0.0, 1.0], glw::GL_RED, glw::GL_FLOAT))
        && check(float(glw::GL_RGBA16F, f, f, glw::GL_RGBA, glw::GL_FLOAT))
        && check(int(glw::GL_RGBA32I, i, i, glw::GL_RGBA_INTEGER, glw::GL_INT))
        && check(int(glw::GL_R32I, i, [1, 0, 0, 1], glw::GL_RED_INTEGER, glw::GL_INT))
        && check(int(glw::GL_RGBA16I, i, i, glw::GL_RGBA_INTEGER, glw::GL_SHORT))
        && check(int(glw::GL_RGBA8I, i, i, glw::GL_RGBA_INTEGER, glw::GL_BYTE))
        && check(uint(glw::GL_RGBA32UI, u, u, glw::GL_RGBA_INTEGER, glw::GL_UNSIGNED_INT))
        && check(uint(
            glw::GL_R32UI,
            [7, 2, 3, 4],
            [7, 0, 0, 1],
            glw::GL_RED_INTEGER,
            glw::GL_UNSIGNED_INT,
        ))
        && check(uint(
            glw::GL_RGBA16UI,
            u,
            u,
            glw::GL_RGBA_INTEGER,
            glw::GL_UNSIGNED_SHORT,
        ))
        && check(uint(glw::GL_RGBA8UI, u, u, glw::GL_RGBA_INTEGER, glw::GL_UNSIGNED_BYTE))
        && check(float(
            glw::GL_RGBA8,
            [1.0; 4],
            [1.0; 4],
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
        ))
        && check(float(
            glw::GL_RGBA8_SNORM,
            [1.0, -1.0, 1.0, -1.0],
            [1.0, -1.0, 1.0, -1.0],
            glw::GL_RGBA,
            glw::GL_BYTE,
        ))
}

/// 2.3 BasicAllFormatsLoadFS
#[derive(Default)]
pub(super) struct BasicAllFormatsLoadFs {
    vao: GLuint,
    vbo: GLuint,
}

impl BasicAllFormatsLoadFs {
    fn read<T: Texel4>(
        &self,
        gl: &glw::Functions,
        internalformat: GLenum,
        value: T,
        expected_value: T,
        format: GLenum,
        type_: GLenum,
    ) -> bool {
        const SIZE: usize = 11;
        let program = build_program(
            gl,
            Some(WRITE_FS_VS),
            Some(&gen_load_fs(internalformat, expected_value)),
        );
        let unit: GLuint = 1;
        let mut texture: GLuint = 0;
        gl!(gl.gen_textures(1, &mut texture));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture));
        nearest_filtering(gl, glw::GL_TEXTURE_2D);
        gl!(gl.tex_storage_2d(
            glw::GL_TEXTURE_2D,
            1,
            internalformat,
            SIZE as glw::GLsizei,
            SIZE as glw::GLsizei
        ));
        upload(
            gl,
            SIZE,
            format,
            type_,
            &texture_data(value, internalformat, format, SIZE),
        );
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.viewport(0, 0, SIZE as glw::GLsizei, SIZE as glw::GLsizei));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.use_program(program));
        gl!(gl.bind_image_texture(unit, texture, 0, glw::FALSE, 0, glw::GL_READ_ONLY, internalformat));
        gl!(gl.bind_vertex_array(self.vao));
        let buffer = new_ssbo(gl, SIZE);
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        let is_ok = compare_ssbo(gl, SIZE, expected_value, internalformat, unit);
        gl!(gl.use_program(0));
        gl!(gl.delete_program(program));
        gl!(gl.delete_textures(1, &texture));
        gl!(gl.delete_buffers(1, &buffer));
        is_ok
    }
}

impl Subcase for BasicAllFormatsLoadFs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 0, 1) || !is_ssb_in_vsfs_available(gl, 0, 1) {
            return Ok(NOT_SUPPORTED);
        }
        create_full_viewport_quad(gl, &mut self.vao, &mut self.vbo, None);
        let this = &*self;
        result(read_rows(
            |format, value, expected, pixel_format, pixel_type| {
                this.read(gl, format, value, expected, pixel_format, pixel_type)
            },
            |format, value, expected, pixel_format, pixel_type| {
                this.read(gl, format, value, expected, pixel_format, pixel_type)
            },
            |format, value, expected, pixel_format, pixel_type| {
                this.read(gl, format, value, expected, pixel_format, pixel_type)
            },
            |ok| ok,
        ))
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let (width, height) = window_size(context);
        gl!(gl.viewport(0, 0, width, height));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.vbo));
        Ok(NO_ERROR)
    }
}

/// 2.4 BasicAllFormatsLoadCS
#[derive(Default)]
pub(super) struct BasicAllFormatsLoadCs;

impl BasicAllFormatsLoadCs {
    fn read_cs<T: Texel4>(
        gl: &glw::Functions,
        internalformat: GLenum,
        value: T,
        expected_value: T,
        format: GLenum,
        type_: GLenum,
    ) -> bool {
        const SIZE: usize = 4;
        let program = create_compute_program(gl, &gen_load_cs(internalformat, expected_value));
        let unit: GLuint = 1;
        let mut texture: GLuint = 0;
        gl!(gl.gen_textures(1, &mut texture));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture));
        nearest_filtering(gl, glw::GL_TEXTURE_2D);
        gl!(gl.tex_storage_2d(
            glw::GL_TEXTURE_2D,
            1,
            internalformat,
            SIZE as glw::GLsizei,
            SIZE as glw::GLsizei
        ));
        upload(
            gl,
            SIZE,
            format,
            type_,
            &texture_data(value, internalformat, format, SIZE),
        );
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.use_program(program));
        gl!(gl.bind_image_texture(unit, texture, 0, glw::FALSE, 0, glw::GL_READ_ONLY, internalformat));
        let buffer = new_ssbo(gl, SIZE);
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        let is_ok = compare_ssbo(gl, SIZE, expected_value, internalformat, unit);
        gl!(gl.use_program(0));
        gl!(gl.delete_program(program));
        gl!(gl.delete_textures(1, &texture));
        gl!(gl.delete_buffers(1, &buffer));
        is_ok
    }
}

impl Subcase for BasicAllFormatsLoadCs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        result(read_rows(
            |format, value, expected, pixel_format, pixel_type| {
                Self::read_cs(gl, format, value, expected, pixel_format, pixel_type)
            },
            |format, value, expected, pixel_format, pixel_type| {
                Self::read_cs(gl, format, value, expected, pixel_format, pixel_type)
            },
            |format, value, expected, pixel_format, pixel_type| {
                Self::read_cs(gl, format, value, expected, pixel_format, pixel_type)
            },
            |ok| ok,
        ))
    }
}

/// 2.5 BasicAllFormatsLoadStoreComputeStage
#[derive(Default)]
pub(super) struct BasicAllFormatsLoadStoreComputeStage;

impl BasicAllFormatsLoadStoreComputeStage {
    fn gen_cs<T: Texel4>(internalformat: GLenum, expected_value: T) -> String {
        let prefix = T::PREFIX;
        let format = format_enum_to_string(internalformat);
        format!(
            "\n#define KSIZE 8\nlayout(local_size_x = KSIZE, local_size_y = KSIZE) in;\nlayout({format}, binding = 2) readonly uniform {prefix}image2D g_image_read;\nlayout({format}, binding = 3) writeonly uniform {prefix}image2D g_image_write;\nvoid main() {{\n  ivec2 coord = ivec2(gl_LocalInvocationID);\n  {prefix}vec4 v = imageLoad(g_image_read, coord);\n  imageStore(g_image_write, coord, v+v);\n  //imageStore(g_image_write, coord, {prefix}vec4{});\n}}",
            expected_value.glsl()
        )
    }

    fn read<T: Texel4>(
        gl: &glw::Functions,
        internalformat: GLenum,
        value: T,
        expected_value: T,
        format: GLenum,
        type_: GLenum,
    ) -> bool {
        const SIZE: usize = 8;
        let program = create_compute_program(gl, &Self::gen_cs(internalformat, expected_value));
        let mut texture = [0 as GLuint; 2];
        gl!(gl.gen_textures(2, texture.as_mut_ptr()));

        // The texture that is read.
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture[0]));
        nearest_filtering(gl, glw::GL_TEXTURE_2D);
        gl!(gl.tex_storage_2d(
            glw::GL_TEXTURE_2D,
            1,
            internalformat,
            SIZE as glw::GLsizei,
            SIZE as glw::GLsizei
        ));
        upload(
            gl,
            SIZE,
            format,
            type_,
            &texture_data(value, internalformat, format, SIZE),
        );

        // The texture that is written.
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture[1]));
        nearest_filtering(gl, glw::GL_TEXTURE_2D);
        gl!(gl.tex_storage_2d(
            glw::GL_TEXTURE_2D,
            1,
            internalformat,
            SIZE as glw::GLsizei,
            SIZE as glw::GLsizei
        ));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));

        gl!(gl.use_program(program));
        // Upstream binds both images as layered although they are plain 2D textures.
        gl!(gl.bind_image_texture(2, texture[0], 0, glw::TRUE, 0, glw::GL_READ_ONLY, internalformat));
        gl!(gl.bind_image_texture(3, texture[1], 0, glw::TRUE, 0, glw::GL_WRITE_ONLY, internalformat));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture[1]));
        gl!(gl.memory_barrier(glw::GL_TEXTURE_FETCH_BARRIER_BIT));

        let c_program = create_compute_program(gl, &gen_c(SIZE, expected_value));
        let buffer = new_ssbo(gl, SIZE);
        gl!(gl.use_program(c_program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        let is_ok = compare_ssbo(gl, SIZE, expected_value, internalformat, 2);
        gl!(gl.use_program(0));
        gl!(gl.delete_program(program));
        gl!(gl.delete_program(c_program));
        gl!(gl.delete_textures(2, texture.as_ptr()));
        gl!(gl.delete_buffers(1, &buffer));
        is_ok
    }
}

impl Subcase for BasicAllFormatsLoadStoreComputeStage {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let f = [1.0, 2.0, 3.0, 4.0];
        let i = [1, -2, 3, -4];
        let u: [u32; 4] = [0, 1, 2, 3];
        let ok = Self::read(
            gl,
            glw::GL_RGBA32F,
            f,
            [2.0, 4.0, 6.0, 8.0],
            glw::GL_RGBA,
            glw::GL_FLOAT,
        ) && Self::read(gl, glw::GL_R32F, f, [2.0, 0.0, 0.0, 1.0], glw::GL_RED, glw::GL_FLOAT)
            && Self::read(
                gl,
                glw::GL_RGBA16F,
                f,
                [2.0, 4.0, 6.0, 8.0],
                glw::GL_RGBA,
                glw::GL_FLOAT,
            )
            && Self::read(
                gl,
                glw::GL_RGBA32I,
                i,
                [2, -4, 6, -8],
                glw::GL_RGBA_INTEGER,
                glw::GL_INT,
            )
            && Self::read(gl, glw::GL_R32I, i, [2, 0, 0, 1], glw::GL_RED_INTEGER, glw::GL_INT)
            && Self::read(
                gl,
                glw::GL_RGBA16I,
                i,
                [2, -4, 6, -8],
                glw::GL_RGBA_INTEGER,
                glw::GL_SHORT,
            )
            && Self::read(
                gl,
                glw::GL_RGBA8I,
                i,
                [2, -4, 6, -8],
                glw::GL_RGBA_INTEGER,
                glw::GL_BYTE,
            )
            && Self::read(
                gl,
                glw::GL_RGBA32UI,
                u,
                [0, 2, 4, 6],
                glw::GL_RGBA_INTEGER,
                glw::GL_UNSIGNED_INT,
            )
            && Self::read(
                gl,
                glw::GL_R32UI,
                [7u32, 2, 3, 4],
                [14, 0, 0, 1],
                glw::GL_RED_INTEGER,
                glw::GL_UNSIGNED_INT,
            )
            && Self::read(
                gl,
                glw::GL_RGBA16UI,
                u,
                [0, 2, 4, 6],
                glw::GL_RGBA_INTEGER,
                glw::GL_UNSIGNED_SHORT,
            )
            && Self::read(
                gl,
                glw::GL_RGBA8UI,
                u,
                [0, 2, 4, 6],
                glw::GL_RGBA_INTEGER,
                glw::GL_UNSIGNED_BYTE,
            )
            && Self::read(
                gl,
                glw::GL_RGBA8,
                [0.5; 4],
                [1.0; 4],
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
            )
            && Self::read(
                gl,
                glw::GL_RGBA8_SNORM,
                [0.5, 0.0, 0.5, -0.5],
                [1.0, 0.0, 1.0, -1.0],
                glw::GL_RGBA,
                glw::GL_BYTE,
            );
        result(ok)
    }
}
