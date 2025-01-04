// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcShaderImageLoadStoreTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `BasicAllTargets*` classes; `Target` is an enum and `TypePrefix<T>`/`Equal<T>` are the `Texel4` trait of `formats`.

use super::super::subcase::{NO_ERROR, NOT_SUPPORTED, Subcase, SubcaseResult};
use super::formats::{Texel4, format_enum_to_string};
use super::{
    build_program, create_compute_program, create_full_viewport_quad, is_ssb_in_vsfs_available, is_vsfs_available,
    map_ssbo_at, result, uniform_location, window_size,
};
use crate::glu::Context;
use crate::glw::{self, GLenum, GLuint};

const K_SIZE: usize = 11;
const BUFFER_BYTES: usize = 6 * K_SIZE * K_SIZE * 4 * 4;

#[derive(Clone, Copy, PartialEq, Debug)]
enum Target {
    T2d,
    T3d,
    Tcm,
    T2da,
}

impl Target {
    fn index(self) -> usize {
        self as usize
    }

    fn layers(self) -> usize {
        match self {
            Target::T2d => 1,
            Target::Tcm => 6,
            Target::T3d | Target::T2da => 2,
        }
    }

    fn image_declaration(self) -> (&'static str, &'static str, usize) {
        match self {
            Target::T2d => ("image2D", "g_image_2d", 0),
            Target::T3d => ("image3D", "g_image_3d", 1),
            Target::Tcm => ("imageCube", "g_image_cube", 2),
            Target::T2da => ("image2DArray", "g_image_2darray", 3),
        }
    }
}

/// One `Write(target, format, value, expected)` call of the upstream `Run`, with the type of `value` erased.
#[derive(Clone, Copy)]
enum Kind {
    Float,
    Int,
    Uint,
}

const STORE_VALUES: ([f32; 4], [i32; 4], [u32; 4]) = ([-1.0, 2.0, 3.0, -4.0], [1, -2, 3, -4], [1, 2, 3, 4]);

fn run_sequence(
    sequence: &[(Target, Kind)],
    (float_value, int_value, uint_value): ([f32; 4], [i32; 4], [u32; 4]),
    mut float: impl FnMut(Target, GLenum, [f32; 4]) -> bool,
    mut int: impl FnMut(Target, GLenum, [i32; 4]) -> bool,
    mut uint: impl FnMut(Target, GLenum, [u32; 4]) -> bool,
) -> bool {
    sequence.iter().all(|&(target, kind)| match kind {
        Kind::Float => float(target, glw::GL_RGBA32F, float_value),
        Kind::Int => int(target, glw::GL_RGBA32I, int_value),
        Kind::Uint => uint(target, glw::GL_RGBA32UI, uint_value),
    })
}

fn store_statements(target: Target, prefix: &str, value: &str, coord_z_count: usize) -> String {
    let (_, name, _) = target.image_declaration();
    match target {
        Target::T2d => format!("\n  imageStore({name}, coord, {prefix}vec4{value});"),
        _ => (0..coord_z_count)
            .map(|z| format!("\n  imageStore({name}, ivec3(coord, {z}), {prefix}vec4{value});"))
            .collect(),
    }
}

fn gen_image_declaration(target: Target, internalformat: GLenum, prefix: &str) -> String {
    let (image_type, name, binding) = target.image_declaration();
    format!(
        "\nlayout({}, binding = {binding}) writeonly uniform {prefix}{image_type} {name};",
        format_enum_to_string(internalformat)
    )
}

fn gen_fs<T: Texel4>(target: Target, internalformat: GLenum, write_value: T) -> String {
    let prefix = T::PREFIX;
    let mut source = gen_image_declaration(target, internalformat, prefix);
    source.push_str("\nvoid main() {\n  ivec2 coord = ivec2(gl_FragCoord.xy);");
    source.push_str(&store_statements(target, prefix, &write_value.glsl(), target.layers()));
    source.push_str("\n  discard;\n}");
    source
}

fn gen_cs<T: Texel4>(target: Target, internalformat: GLenum, write_value: T) -> String {
    let prefix = T::PREFIX;
    let mut source = String::from("\n#define KSIZE 11\nlayout (local_size_x = KSIZE, local_size_y = KSIZE) in;");
    source.push_str(&gen_image_declaration(target, internalformat, prefix));
    source.push_str("\nvoid main() {\n  ivec2 coord = ivec2(gl_LocalInvocationID);");
    source.push_str(&store_statements(target, prefix, &write_value.glsl(), target.layers()));
    source.push_str("\n}");
    source
}

/// `GenC`; `bindings` are the SSBO bindings of the 2D, 3D, cube and 2D array outputs (the FS and the CS case permute them).
fn gen_c<T: Texel4>(write_value: T, bindings: [u32; 4]) -> String {
    let prefix = T::PREFIX;
    let [b2d, b3d, bcube, b2da] = bindings;
    format!(
        "\n#define KSIZE 11\nlayout (local_size_x = KSIZE, local_size_y = KSIZE) in;\nuniform {prefix}sampler2D g_sampler_2d;\nuniform {prefix}sampler3D g_sampler_3d;\nuniform {prefix}samplerCube g_sampler_cube;\nuniform {prefix}sampler2DArray g_sampler_2darray;\nlayout(std430, binding = {b2d}) buffer OutputBuffer2D {{\n  {prefix}vec4 data[KSIZE*KSIZE];\n}} g_buff_2d;\nlayout(std430, binding = {b3d}) buffer OutputBuffer3D {{\n  {prefix}vec4 data[KSIZE*KSIZE*2];\n}} g_buff_3d;\nlayout(std430, binding = {bcube}) buffer OutputBufferCube {{\n  {prefix}vec4 data[KSIZE*KSIZE*6];\n}} g_buff_cube;\nlayout(std430, binding = {b2da}) buffer OutputBuffer2DArray {{\n  {prefix}vec4 data[KSIZE*KSIZE*2];\n}} g_buff_2darray;\nvoid main() {{\n  int cubemap_i = 2 * int(gl_LocalInvocationID.x) - KSIZE + 1;\n  int cubemap_j = 2 * int(gl_LocalInvocationID.y) - KSIZE + 1;\n  uint layer = uint(KSIZE * KSIZE);\n  g_buff_2d.data[gl_LocalInvocationIndex] = texelFetch(g_sampler_2d, ivec2(gl_LocalInvocationID), 0);\n  g_buff_3d.data[gl_LocalInvocationIndex] = texelFetch(g_sampler_3d, ivec3(gl_LocalInvocationID.xy, 0), 0);\n  g_buff_3d.data[gl_LocalInvocationIndex + layer] = texelFetch(g_sampler_3d, ivec3(gl_LocalInvocationID.xy, 1), 0);\n  g_buff_2darray.data[gl_LocalInvocationIndex] = texelFetch(g_sampler_2darray, ivec3(gl_LocalInvocationID.xy, 0), 0);\n  g_buff_2darray.data[gl_LocalInvocationIndex + layer] = texelFetch(g_sampler_2darray, ivec3(gl_LocalInvocationID.xy, 1), 0);\n  g_buff_cube.data[gl_LocalInvocationIndex] = texture(g_sampler_cube, vec3(KSIZE,cubemap_i,cubemap_j));\n  g_buff_cube.data[gl_LocalInvocationIndex + layer] = texture(g_sampler_cube, vec3(KSIZE,cubemap_i,cubemap_j));\n  g_buff_cube.data[gl_LocalInvocationIndex + 2u * layer] = texture(g_sampler_cube, vec3(cubemap_i,KSIZE,cubemap_j));\n  g_buff_cube.data[gl_LocalInvocationIndex + 3u * layer] = texture(g_sampler_cube, vec3(cubemap_i,KSIZE,cubemap_j));\n  g_buff_cube.data[gl_LocalInvocationIndex + 4u * layer] = texture(g_sampler_cube, vec3(cubemap_i,cubemap_j,KSIZE));\n  g_buff_cube.data[gl_LocalInvocationIndex + 5u * layer] = texture(g_sampler_cube, vec3(cubemap_i,cubemap_j,KSIZE));\n  //g_buff_2d.data[gl_LocalInvocationIndex] = {};\n}}",
        write_value.glsl()
    )
}

const SIZE: glw::GLsizei = K_SIZE as glw::GLsizei;

/// The four textures of upstream's `textures[8]` (slots 1, 2, 4 and 7 are used): 2D, 3D, cube map and 2D array.
fn create_textures(gl: &glw::Functions, internalformat: GLenum) -> [GLuint; 8] {
    let mut textures = [0 as GLuint; 8];
    gl!(gl.gen_textures(8, textures.as_mut_ptr()));
    let storages: [(usize, GLenum, bool); 4] = [
        (1, glw::GL_TEXTURE_2D, false),
        (2, glw::GL_TEXTURE_3D, true),
        (4, glw::GL_TEXTURE_CUBE_MAP, false),
        (7, glw::GL_TEXTURE_2D_ARRAY, true),
    ];
    for (slot, target, is_3d_storage) in storages {
        gl!(gl.bind_texture(target, textures[slot]));
        super::nearest_filtering(gl, target);
        if is_3d_storage {
            gl!(gl.tex_storage_3d(target, 1, internalformat, SIZE, SIZE, 2));
        } else {
            gl!(gl.tex_storage_2d(target, 1, internalformat, SIZE, SIZE));
        }
        gl!(gl.bind_texture(target, 0));
    }
    textures
}

fn bind_images(gl: &glw::Functions, textures: &[GLuint; 8], internalformat: GLenum, access: GLenum) {
    gl!(gl.bind_image_texture(0, textures[1], 0, glw::FALSE, 0, access, internalformat));
    gl!(gl.bind_image_texture(1, textures[2], 0, glw::TRUE, 0, access, internalformat));
    gl!(gl.bind_image_texture(2, textures[4], 0, glw::TRUE, 0, access, internalformat));
    gl!(gl.bind_image_texture(3, textures[7], 0, glw::TRUE, 0, access, internalformat));
}

fn bind_samplers(gl: &glw::Functions, textures: &[GLuint; 8]) {
    let units: [(GLenum, GLenum, usize); 4] = [
        (glw::GL_TEXTURE1, glw::GL_TEXTURE_2D, 1),
        (glw::GL_TEXTURE2, glw::GL_TEXTURE_3D, 2),
        (glw::GL_TEXTURE3, glw::GL_TEXTURE_CUBE_MAP, 4),
        (glw::GL_TEXTURE4, glw::GL_TEXTURE_2D_ARRAY, 7),
    ];
    for (unit, target, slot) in units {
        gl!(gl.active_texture(unit));
        gl!(gl.bind_texture(target, textures[slot]));
    }
}

fn set_sampler_uniforms(gl: &glw::Functions, program: GLuint) {
    for (name, unit) in [
        ("g_sampler_2d", 1),
        ("g_sampler_3d", 2),
        ("g_sampler_cube", 3),
        ("g_sampler_2darray", 4),
    ] {
        gl!(gl.uniform_1i(uniform_location(gl, program, name), unit));
    }
}

fn create_output_buffers(gl: &glw::Functions, bindings: [u32; 4]) -> [GLuint; 4] {
    let out_data = vec![0u8; BUFFER_BYTES];
    let mut buffers = [0 as GLuint; 4];
    gl!(gl.gen_buffers(4, buffers.as_mut_ptr()));
    for (slot, binding) in bindings.iter().enumerate() {
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, *binding, buffers[slot]));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            BUFFER_BYTES as glw::GLsizeiptr,
            out_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
    }
    buffers
}

/// `CompareValues` over the output buffer of `target`, with the failure message and the unmapping of upstream.
fn compare_output<T: Texel4>(
    gl: &glw::Functions,
    buffers: &[GLuint; 4],
    target: Target,
    internalformat: GLenum,
    expected_value: T,
) -> bool {
    gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffers[target.index()]));
    let count = K_SIZE * K_SIZE * target.layers();
    let status = match map_ssbo_at::<T>(gl, 0, count) {
        Some(map_data) => {
            let mismatch = map_data
                .iter()
                .enumerate()
                .find(|(_, value)| !T::equal(**value, expected_value, internalformat));
            if let Some((index, value)) = mismatch {
                log::info!("[{index}] Value is: {value:?}. Value should be: {expected_value:?}");
                log::info!(
                    "{target:?} target, {}. format failed.",
                    format_enum_to_string(internalformat)
                );
            }
            mismatch.is_none()
        }
        None => false,
    };
    gl!(gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER));
    status
}

/// The compute pass that copies every target of the textures into SSBOs, the comparison and the clean-up shared by the FS and CS store cases.
fn read_back_and_compare<T: Texel4>(
    gl: &glw::Functions,
    textures: &[GLuint; 8],
    program: GLuint,
    target: Target,
    internalformat: GLenum,
    write_value: T,
    expected_value: T,
    bindings: [u32; 4],
) -> bool {
    bind_samplers(gl, textures);
    gl!(gl.memory_barrier(glw::GL_TEXTURE_FETCH_BARRIER_BIT));

    let c_program = create_compute_program(gl, &gen_c(write_value, bindings));
    let buffers = create_output_buffers(gl, bindings);
    gl!(gl.use_program(c_program));
    set_sampler_uniforms(gl, c_program);
    gl!(gl.dispatch_compute(1, 1, 1));
    gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

    let status = compare_output(gl, &buffers, target, internalformat, expected_value);

    gl!(gl.delete_textures(8, textures.as_ptr()));
    gl!(gl.use_program(0));
    gl!(gl.delete_program(program));
    gl!(gl.delete_program(c_program));
    gl!(gl.delete_buffers(4, buffers.as_ptr()));
    status
}

const LOAD_SEQUENCE: [(Target, Kind); 12] = [
    (Target::T2d, Kind::Float),
    (Target::T2d, Kind::Int),
    (Target::T2d, Kind::Uint),
    (Target::T3d, Kind::Float),
    (Target::T3d, Kind::Int),
    (Target::T3d, Kind::Uint),
    (Target::Tcm, Kind::Float),
    (Target::Tcm, Kind::Int),
    (Target::Tcm, Kind::Uint),
    (Target::T2da, Kind::Float),
    (Target::T2da, Kind::Int),
    (Target::T2da, Kind::Uint),
];

const FS_SEQUENCE: [(Target, Kind); 12] = [
    (Target::T2d, Kind::Float),
    (Target::T2d, Kind::Int),
    (Target::T2d, Kind::Uint),
    (Target::T3d, Kind::Float),
    (Target::T3d, Kind::Int),
    (Target::T3d, Kind::Uint),
    (Target::Tcm, Kind::Float),
    (Target::Tcm, Kind::Int),
    (Target::Tcm, Kind::Uint),
    (Target::T2da, Kind::Float),
    (Target::T2da, Kind::Int),
    (Target::T2da, Kind::Uint),
];

const CS_SEQUENCE: [(Target, Kind); 12] = [
    (Target::T2d, Kind::Float),
    (Target::T2d, Kind::Int),
    (Target::T2d, Kind::Uint),
    (Target::T3d, Kind::Int),
    (Target::T3d, Kind::Uint),
    (Target::T3d, Kind::Float),
    (Target::Tcm, Kind::Uint),
    (Target::Tcm, Kind::Float),
    (Target::Tcm, Kind::Int),
    (Target::T2da, Kind::Float),
    (Target::T2da, Kind::Int),
    (Target::T2da, Kind::Uint),
];

/// 1.3.1.1 BasicAllTargetsStoreFS
#[derive(Default)]
pub(super) struct BasicAllTargetsStoreFs {
    vao: GLuint,
    vbo: GLuint,
}

impl BasicAllTargetsStoreFs {
    fn write<T: Texel4>(&self, gl: &glw::Functions, target: Target, internalformat: GLenum, value: T) -> bool {
        let src_vs = "\nlayout(location = 0) in vec4 i_position;\nvoid main() {\n  gl_Position = i_position;\n}";
        let program = build_program(gl, Some(src_vs), Some(&gen_fs(target, internalformat, value)));
        let textures = create_textures(gl, internalformat);
        bind_images(gl, &textures, internalformat, glw::GL_WRITE_ONLY);

        gl!(gl.use_program(program));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.viewport(0, 0, SIZE, SIZE));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        read_back_and_compare(
            gl,
            &textures,
            program,
            target,
            internalformat,
            value,
            value,
            [1, 0, 3, 2],
        )
    }
}

impl Subcase for BasicAllTargetsStoreFs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 0, 4) {
            return Ok(NOT_SUPPORTED);
        }
        create_full_viewport_quad(gl, &mut self.vao, &mut self.vbo, None);
        let this = &*self;
        result(run_sequence(
            &FS_SEQUENCE,
            STORE_VALUES,
            |target, format, value| this.write(gl, target, format, value),
            |target, format, value| this.write(gl, target, format, value),
            |target, format, value| this.write(gl, target, format, value),
        ))
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let (width, height) = window_size(context);
        gl!(gl.viewport(0, 0, width, height));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.vbo));
        gl!(gl.active_texture(glw::GL_TEXTURE0));
        Ok(NO_ERROR)
    }
}

/// 1.3.1.2 BasicAllTargetsStoreCS
#[derive(Default)]
pub(super) struct BasicAllTargetsStoreCs;

impl BasicAllTargetsStoreCs {
    fn write<T: Texel4>(gl: &glw::Functions, target: Target, internalformat: GLenum, value: T) -> bool {
        let program = create_compute_program(gl, &gen_cs(target, internalformat, value));
        let textures = create_textures(gl, internalformat);
        bind_images(gl, &textures, internalformat, glw::GL_WRITE_ONLY);

        gl!(gl.use_program(program));
        gl!(gl.dispatch_compute(1, 1, 1));

        read_back_and_compare(
            gl,
            &textures,
            program,
            target,
            internalformat,
            value,
            value,
            [0, 1, 2, 3],
        )
    }
}

impl Subcase for BasicAllTargetsStoreCs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        result(run_sequence(
            &CS_SEQUENCE,
            STORE_VALUES,
            |target, format, value| Self::write(gl, target, format, value),
            |target, format, value| Self::write(gl, target, format, value),
            |target, format, value| Self::write(gl, target, format, value),
        ))
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().active_texture(glw::GL_TEXTURE0));
        Ok(NO_ERROR)
    }
}

/// The (internalformat-specific) component type of the data `Read` uploads.
trait LoadTexel: Texel4 {
    const FORMAT: GLenum;
    const TYPE: GLenum;
}

impl LoadTexel for [f32; 4] {
    const FORMAT: GLenum = glw::GL_RGBA;
    const TYPE: GLenum = glw::GL_FLOAT;
}

impl LoadTexel for [i32; 4] {
    const FORMAT: GLenum = glw::GL_RGBA_INTEGER;
    const TYPE: GLenum = glw::GL_INT;
}

impl LoadTexel for [u32; 4] {
    const FORMAT: GLenum = glw::GL_RGBA_INTEGER;
    const TYPE: GLenum = glw::GL_UNSIGNED_INT;
}

const LOAD_FS_VALUES: ([f32; 4], [i32; 4], [u32; 4]) =
    ([-1.0, 10.0, -200.0, 3000.0], [-1, 10, -200, 3000], [1, 10, 200, 3000]);
const LOAD_CS_VALUES: ([f32; 4], [i32; 4], [u32; 4]) = (
    [-1.0, 10.0, -200.0, 3000.0],
    [-0x7fffffff, 0x7fffffff, -200, 3000],
    [0xffffffff, 0x7fffffff, 0x80000000, 3000],
);

const CUBE_FACES: [GLenum; 6] = [
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
];

fn upload_texels<T: LoadTexel>(gl: &glw::Functions, textures: &[GLuint; 8], value: T) {
    let data = [value; K_SIZE * K_SIZE * 2];
    let pointer = data.as_ptr().cast();
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, textures[1]));
    gl!(gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, SIZE, SIZE, T::FORMAT, T::TYPE, pointer));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
    gl!(gl.bind_texture(glw::GL_TEXTURE_3D, textures[2]));
    gl!(gl.tex_sub_image_3d(
        glw::GL_TEXTURE_3D,
        0,
        0,
        0,
        0,
        SIZE,
        SIZE,
        2,
        T::FORMAT,
        T::TYPE,
        pointer
    ));
    gl!(gl.bind_texture(glw::GL_TEXTURE_3D, 0));
    gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, textures[4]));
    for face in CUBE_FACES {
        gl!(gl.tex_sub_image_2d(face, 0, 0, 0, SIZE, SIZE, T::FORMAT, T::TYPE, pointer));
    }
    gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, 0));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, textures[7]));
    gl!(gl.tex_sub_image_3d(
        glw::GL_TEXTURE_2D_ARRAY,
        0,
        0,
        0,
        0,
        SIZE,
        SIZE,
        2,
        T::FORMAT,
        T::TYPE,
        pointer
    ));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, 0));
}

/// The image units upstream's `Read` binds: 2D on 2, 3D on 0, cube on 3 and 2D array on 1.
fn bind_read_images(gl: &glw::Functions, textures: &[GLuint; 8], internalformat: GLenum) {
    gl!(gl.bind_image_texture(2, textures[1], 0, glw::FALSE, 0, glw::GL_READ_ONLY, internalformat));
    gl!(gl.bind_image_texture(0, textures[2], 0, glw::TRUE, 0, glw::GL_READ_ONLY, internalformat));
    gl!(gl.bind_image_texture(3, textures[4], 0, glw::TRUE, 0, glw::GL_READ_ONLY, internalformat));
    gl!(gl.bind_image_texture(1, textures[7], 0, glw::TRUE, 0, glw::GL_READ_ONLY, internalformat));
}

fn gen_load_image_declaration(target: Target, internalformat: GLenum, prefix: &str, buffer_binding: u32) -> String {
    let (image_type, name, binding) = match target {
        Target::T2d => ("image2D", "g_image_2d", 2),
        Target::T3d => ("image3D", "g_image_3d", 0),
        Target::Tcm => ("imageCube", "g_image_cube", 3),
        Target::T2da => ("image2DArray", "g_image_2darray", 1),
    };
    let (buffer_type, buffer_name, size) = match target {
        Target::T2d => ("OutputBuffer2D", "g_buff_2d", "KSIZE*KSIZE"),
        Target::T3d => ("OutputBuffer3D", "g_buff_3d", "KSIZE*KSIZE*2"),
        Target::Tcm => ("OutputBufferCube", "g_buff_cube", "KSIZE*KSIZE*6"),
        Target::T2da => ("OutputBuffer2DArray", "g_buff_2darray", "KSIZE*KSIZE*2"),
    };
    format!(
        "\nlayout({}, binding = {binding}) readonly uniform {prefix}{image_type} {name};\nlayout(std430, binding = {buffer_binding}) buffer {buffer_type} {{\n  {prefix}vec4 data[{size}];\n}} {buffer_name};",
        format_enum_to_string(internalformat)
    )
}

fn load_names(target: Target) -> (&'static str, &'static str) {
    match target {
        Target::T2d => ("g_image_2d", "g_buff_2d"),
        Target::T3d => ("g_image_3d", "g_buff_3d"),
        Target::Tcm => ("g_image_cube", "g_buff_cube"),
        Target::T2da => ("g_image_2darray", "g_buff_2darray"),
    }
}

/// The `imageLoad` / SSBO store pair of every layer of `target`, with the coordinate and SSBO index expressions upstream uses per layer.
fn load_statements(
    target: Target,
    coord_of_layer: impl Fn(usize) -> String,
    index_of_layer: impl Fn(usize) -> String,
) -> String {
    let (image, buffer) = load_names(target);
    (0..target.layers())
        .map(|layer| {
            format!(
                "\n  v = imageLoad({image}, {});\n  {buffer}.data[{}] = v;",
                coord_of_layer(layer),
                index_of_layer(layer)
            )
        })
        .collect()
}

fn gen_load_fs<T: Texel4>(target: Target, internalformat: GLenum, expected_value: T) -> String {
    let prefix = T::PREFIX;
    let buffer_binding = match target {
        Target::T2d => 1,
        Target::T3d => 0,
        Target::Tcm => 3,
        Target::T2da => 2,
    };
    let mut source = String::from("\n#define KSIZE 11");
    source.push_str(&gen_load_image_declaration(
        target,
        internalformat,
        prefix,
        buffer_binding,
    ));
    source.push_str(&format!("\nvoid main() {{\n  ivec2 coord = ivec2(gl_FragCoord.xy);\n  int coordIndex = coord.x + KSIZE * coord.y;\n  int layer = int(KSIZE * KSIZE);\n  {prefix}vec4 v;"));
    let coord = |layer: usize| match target {
        Target::T2d => "coord".to_string(),
        Target::Tcm => format!("ivec3(coord, {layer})"),
        Target::T3d | Target::T2da => format!("ivec3(coord.xy, {layer})"),
    };
    let index = |layer: usize| match layer {
        0 => "coordIndex".to_string(),
        1 => "coordIndex + layer".to_string(),
        layer => format!("coordIndex + {layer} * layer"),
    };
    source.push_str(&load_statements(target, coord, index));
    source.push_str(&format!(
        "\n  //g_buff_2d.data[coordIndex] = {};\n}}",
        expected_value.glsl()
    ));
    source
}

fn gen_load_cs<T: Texel4>(target: Target, internalformat: GLenum, expected_value: T) -> String {
    let prefix = T::PREFIX;
    let buffer_binding = match target {
        Target::T2d => 0,
        Target::T3d => 1,
        Target::Tcm => 2,
        Target::T2da => 3,
    };
    let mut source = String::from("\n#define KSIZE 11\nlayout (local_size_x = KSIZE, local_size_y = KSIZE) in;");
    source.push_str(&gen_load_image_declaration(
        target,
        internalformat,
        prefix,
        buffer_binding,
    ));
    source.push_str(&format!("\nvoid main() {{\n  ivec3 coord = ivec3(gl_LocalInvocationID.xy, 0);\n  uint layer = uint(KSIZE * KSIZE);\n  {prefix}vec4 v;"));
    let coord = |layer: usize| match (target, layer) {
        (Target::T2d, _) => "coord.xy".to_string(),
        (_, 0) => "coord".to_string(),
        (_, layer) => format!("ivec3(coord.xy, {layer})"),
    };
    let index = |layer: usize| match layer {
        0 => "gl_LocalInvocationIndex".to_string(),
        1 => "gl_LocalInvocationIndex + layer".to_string(),
        layer => format!("gl_LocalInvocationIndex + {layer}u * layer"),
    };
    source.push_str(&load_statements(target, coord, index));
    source.push_str(&format!(
        "\n  //g_buff_2d.data[gl_LocalInvocationIndex] = {};\n}}",
        expected_value.glsl()
    ));
    source
}

/// 1.3.2.1 BasicAllTargetsLoadFS
#[derive(Default)]
pub(super) struct BasicAllTargetsLoadFs {
    vao: GLuint,
    vbo: GLuint,
}

impl BasicAllTargetsLoadFs {
    fn read<T: LoadTexel>(&self, gl: &glw::Functions, target: Target, internalformat: GLenum, value: T) -> bool {
        let src_vs = "\nlayout(location = 0) in vec4 i_position;\nvoid main() {\n  gl_Position = i_position;\n}";
        let program = build_program(gl, Some(src_vs), Some(&gen_load_fs(target, internalformat, value)));
        let textures = create_textures(gl, internalformat);
        upload_texels(gl, &textures, value);
        bind_read_images(gl, &textures, internalformat);
        let buffers = create_output_buffers(gl, [1, 0, 3, 2]);

        gl!(gl.use_program(program));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.viewport(0, 0, SIZE, SIZE));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let status = compare_output(gl, &buffers, target, internalformat, value);

        gl!(gl.use_program(0));
        gl!(gl.delete_program(program));
        gl!(gl.delete_textures(8, textures.as_ptr()));
        gl!(gl.delete_buffers(4, buffers.as_ptr()));
        status
    }
}

impl Subcase for BasicAllTargetsLoadFs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_vsfs_available(gl, 0, 4) || !is_ssb_in_vsfs_available(gl, 0, 4) {
            return Ok(NOT_SUPPORTED);
        }
        create_full_viewport_quad(gl, &mut self.vao, &mut self.vbo, None);
        let this = &*self;
        result(run_sequence(
            &LOAD_SEQUENCE,
            LOAD_FS_VALUES,
            |target, format, value| this.read(gl, target, format, value),
            |target, format, value| this.read(gl, target, format, value),
            |target, format, value| this.read(gl, target, format, value),
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

/// 1.3.2.2 BasicAllTargetsLoadCS
#[derive(Default)]
pub(super) struct BasicAllTargetsLoadCs;

impl BasicAllTargetsLoadCs {
    fn read<T: LoadTexel>(gl: &glw::Functions, target: Target, internalformat: GLenum, value: T) -> bool {
        let program = create_compute_program(gl, &gen_load_cs(target, internalformat, value));
        let textures = create_textures(gl, internalformat);
        upload_texels(gl, &textures, value);
        bind_read_images(gl, &textures, internalformat);
        let buffers = create_output_buffers(gl, [0, 1, 2, 3]);

        gl!(gl.use_program(program));
        gl!(gl.dispatch_compute(1, 1, 1));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let status = compare_output(gl, &buffers, target, internalformat, value);

        gl!(gl.use_program(0));
        gl!(gl.delete_program(program));
        gl!(gl.delete_textures(8, textures.as_ptr()));
        gl!(gl.delete_buffers(4, buffers.as_ptr()));
        status
    }
}

impl Subcase for BasicAllTargetsLoadCs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        result(run_sequence(
            &LOAD_SEQUENCE,
            LOAD_CS_VALUES,
            |target, format, value| Self::read(gl, target, format, value),
            |target, format, value| Self::read(gl, target, format, value),
            |target, format, value| Self::read(gl, target, format, value),
        ))
    }
}
