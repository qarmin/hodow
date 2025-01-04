// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcShaderImageLoadStoreTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `BasicAllTargetsAtomicFS` and the two state machines (`LoadStoreMachine`, `AtomicMachine`) behind the VS and CS cases; `m_stage` is the `Stage` enum and `Atomic<GLint/GLuint>` is `AtomicScalar`.

use super::super::subcase::{NO_ERROR, NOT_SUPPORTED, Subcase, SubcaseResult, output_not_supported};
use super::formats::{Texel4, format_enum_to_string};
use super::{
    build_program, build_program_with, create_compute_program, create_compute_program_sia, create_full_viewport_quad,
    get_integer, is_image_atomic_supported, is_ssb_in_vsfs_available, is_vsfs_available, map_ssbo_at,
    nearest_filtering, result, window_size,
};
use crate::glu::Context;
use crate::glw::{self, GLenum, GLuint};

const K_SIZE: usize = 100;
const K_TARGETS: usize = 4;

/// `AreOutputsAvailable`
fn are_outputs_available(gl: &glw::Functions, required: i32) -> bool {
    let outputs = get_integer(gl, glw::GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES);
    if outputs < required {
        output_not_supported(&format!(
            "Required {required} shader output resources but only {outputs} available.\n"
        ));
        return false;
    }
    true
}

#[derive(Clone, Copy, PartialEq)]
enum Stage {
    Vs,
    Cs,
}

trait AtomicScalar: Copy + Default {
    const PREFIX: &'static str;
    const TYPE: GLenum;
}

impl AtomicScalar for i32 {
    const PREFIX: &'static str = "i";
    const TYPE: GLenum = glw::GL_INT;
}

impl AtomicScalar for u32 {
    const PREFIX: &'static str = "u";
    const TYPE: GLenum = glw::GL_UNSIGNED_INT;
}

/// The `ivec4` upstream's `Equal(out_data[i], ivec4(..), 0)` compares against the SSBO contents.
fn all_equal(map_data: &[[i32; 4]], expected: [i32; 4], what: &str) -> bool {
    let mut status = true;
    for (index, value) in map_data.iter().enumerate() {
        if *value != expected {
            status = false;
            log::info!("[{index}] {what} check failed. ({value:?})");
        }
    }
    status
}

fn atomic_chain(image: &str, coord: &str, component: char) -> String {
    let operations = [
        ("Add", "t(2).x", "t(0).x"),
        ("Min", "t(3).x", "t(2).x"),
        ("Max", "t(4).x", "t(2).x"),
        ("And", "t(0).x", "t(4).x"),
        ("Or", "t(7).x", "t(0).x"),
        ("Xor", "t(4).x", "t(7).x"),
        ("Exchange", "t(1).x", "t(3).x"),
    ];
    let mut source = String::new();
    for (index, (operation, operand, expected)) in operations.iter().enumerate() {
        let keyword = if index == 0 { "if" } else { "else if" };
        source.push_str(&format!("\n  {keyword} (imageAtomic{operation}({image}, {coord}, {operand}) != {expected}) o_color[coordIndex].{component} = {};", index + 1));
    }
    source.push_str(&format!("\n  else if (imageAtomicCompSwap({image}, {coord}, t(1).x, t(6).x) != t(1).x) o_color[coordIndex].{component} = 8;\n  else o_color[coordIndex].{component} = 10;"));
    source
}

fn gen_atomic_fs<T: AtomicScalar>(internalformat: GLenum) -> String {
    let prefix = T::PREFIX;
    let format = format_enum_to_string(internalformat);
    let mut source = format!(
        "\n#define KSIZE 11\nlayout({format}, binding = 1) coherent uniform {prefix}image2D g_image_2d;\nlayout({format}, binding = 2) coherent uniform {prefix}image3D g_image_3d;\nlayout({format}, binding = 0) coherent uniform {prefix}imageCube g_image_cube;\nlayout({format}, binding = 3) coherent uniform {prefix}image2DArray g_image_2darray;\nlayout(std430) buffer out_data {{\n  ivec4 o_color[KSIZE*KSIZE];\n}};\n{prefix}vec2 t(int i) {{\n  return {prefix}vec2(i);\n}}\nvoid main() {{\n  ivec2 coord = ivec2(gl_FragCoord.xy);\n  int coordIndex = coord.x + KSIZE * coord.y;\n  o_color[coordIndex] = ivec4(coordIndex);"
    );
    source.push_str(&atomic_chain("g_image_2d", "coord", 'x'));
    source.push_str(&atomic_chain("g_image_3d", "ivec3(coord, 2)", 'y'));
    source.push_str(&atomic_chain("g_image_cube", "ivec3(coord, 3)", 'z'));
    source.push_str(&atomic_chain("g_image_2darray", "ivec3(coord, 2)", 'w'));
    source.push_str("\n  discard;\n}");
    source
}

const CUBE_FACES: [GLenum; 6] = [
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
    glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
    glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
];

/// 1.3.3.1 BasicAllTargetsAtomicFS
#[derive(Default)]
pub(super) struct BasicAllTargetsAtomicFs {
    vao: GLuint,
    vbo: GLuint,
}

impl BasicAllTargetsAtomicFs {
    fn atomic<T: AtomicScalar>(&self, gl: &glw::Functions, internalformat: GLenum) -> bool {
        const SIZE: usize = 11;
        let size = SIZE as glw::GLsizei;
        let src_vs = "\nlayout(location = 0) in vec4 i_position;\nvoid main() {\n  gl_Position = i_position;\n}";
        let program = build_program_with(gl, src_vs, &gen_atomic_fs::<T>(internalformat), false, true);
        let mut textures = [0 as GLuint; 8];
        let mut buffer: GLuint = 0;
        gl!(gl.gen_textures(8, textures.as_mut_ptr()));
        gl!(gl.gen_buffers(1, &mut buffer));

        let data = [T::default(); SIZE * SIZE * 3];
        let pointer = data.as_ptr().cast();
        let format = glw::GL_RED_INTEGER;

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, textures[1]));
        nearest_filtering(gl, glw::GL_TEXTURE_2D);
        gl!(gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, internalformat, size, size));
        gl!(gl.tex_sub_image_2d(glw::GL_TEXTURE_2D, 0, 0, 0, size, size, format, T::TYPE, pointer));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));

        gl!(gl.bind_texture(glw::GL_TEXTURE_3D, textures[2]));
        nearest_filtering(gl, glw::GL_TEXTURE_3D);
        gl!(gl.tex_storage_3d(glw::GL_TEXTURE_3D, 1, internalformat, size, size, 3));
        gl!(gl.tex_sub_image_3d(glw::GL_TEXTURE_3D, 0, 0, 0, 0, size, size, 3, format, T::TYPE, pointer));
        gl!(gl.bind_texture(glw::GL_TEXTURE_3D, 0));

        gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, textures[4]));
        nearest_filtering(gl, glw::GL_TEXTURE_CUBE_MAP);
        gl!(gl.tex_storage_2d(glw::GL_TEXTURE_CUBE_MAP, 1, internalformat, size, size));
        for face in CUBE_FACES {
            gl!(gl.tex_sub_image_2d(face, 0, 0, 0, size, size, format, T::TYPE, pointer));
        }
        gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, 0));

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, textures[7]));
        nearest_filtering(gl, glw::GL_TEXTURE_2D_ARRAY);
        gl!(gl.tex_storage_3d(glw::GL_TEXTURE_2D_ARRAY, 1, internalformat, size, size, 3));
        gl!(gl.tex_sub_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            0,
            0,
            0,
            size,
            size,
            3,
            format,
            T::TYPE,
            pointer
        ));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, 0));

        gl!(gl.bind_image_texture(1, textures[1], 0, glw::FALSE, 0, glw::GL_READ_WRITE, internalformat));
        gl!(gl.bind_image_texture(2, textures[2], 0, glw::TRUE, 0, glw::GL_READ_WRITE, internalformat));
        gl!(gl.bind_image_texture(0, textures[4], 0, glw::TRUE, 0, glw::GL_READ_WRITE, internalformat));
        gl!(gl.bind_image_texture(3, textures[7], 0, glw::TRUE, 0, glw::GL_READ_WRITE, internalformat));

        let o_data = vec![0u8; SIZE * SIZE * 4 * 4];
        let mut m_buffer: GLuint = 0;
        gl!(gl.gen_buffers(1, &mut m_buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, m_buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            o_data.len() as glw::GLsizeiptr,
            o_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));

        gl!(gl.use_program(program));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.viewport(0, 0, size, size));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let status = match map_ssbo_at::<[i32; 4]>(gl, 0, SIZE * SIZE) {
            Some(out_data) => all_equal(out_data, [10, 10, 10, 10], "Atomic operation"),
            None => false,
        };

        gl!(gl.use_program(0));
        gl!(gl.delete_program(program));
        gl!(gl.delete_textures(8, textures.as_ptr()));
        gl!(gl.delete_buffers(1, &buffer));
        gl!(gl.delete_buffers(1, &m_buffer));
        status
    }
}

impl Subcase for BasicAllTargetsAtomicFs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !is_image_atomic_supported(context) {
            return Ok(NOT_SUPPORTED);
        }
        if !is_vsfs_available(gl, 0, 4) {
            return Ok(NOT_SUPPORTED);
        }
        if !are_outputs_available(gl, 5) {
            return Ok(NOT_SUPPORTED);
        }
        if !is_ssb_in_vsfs_available(gl, 0, 1) {
            return Ok(NOT_SUPPORTED);
        }
        create_full_viewport_quad(gl, &mut self.vao, &mut self.vbo, None);
        result(self.atomic::<i32>(gl, glw::GL_R32I) && self.atomic::<u32>(gl, glw::GL_R32UI))
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

/// Four textures for the 2D, 3D, cube map and 2D array targets, `K_SIZE` wide and one texel high (the cube map is square).
fn create_line_textures(gl: &glw::Functions, internalformat: GLenum) -> [GLuint; K_TARGETS] {
    let targets = [
        glw::GL_TEXTURE_2D,
        glw::GL_TEXTURE_3D,
        glw::GL_TEXTURE_CUBE_MAP,
        glw::GL_TEXTURE_2D_ARRAY,
    ];
    let mut textures = [0 as GLuint; K_TARGETS];
    gl!(gl.gen_textures(K_TARGETS as glw::GLsizei, textures.as_mut_ptr()));
    let size = K_SIZE as glw::GLsizei;
    for (target, texture) in targets.into_iter().zip(textures) {
        gl!(gl.bind_texture(target, texture));
        nearest_filtering(gl, target);
        if target == glw::GL_TEXTURE_2D {
            gl!(gl.tex_storage_2d(target, 1, internalformat, size, 1));
        } else if target == glw::GL_TEXTURE_3D || target == glw::GL_TEXTURE_2D_ARRAY {
            gl!(gl.tex_storage_3d(target, 1, internalformat, size, 1, 2));
        } else {
            gl!(gl.tex_storage_2d(target, 1, internalformat, size, size));
        }
    }
    textures
}

/// The image units of the store pass (and of the atomic pass): 2D on 1, 3D on 2, cube on 0 and 2D array on 3.
fn bind_line_images(
    gl: &glw::Functions,
    textures: &[GLuint; K_TARGETS],
    internalformat: GLenum,
    access: GLenum,
    units: [GLuint; K_TARGETS],
) {
    let layered = [glw::FALSE, glw::TRUE, glw::TRUE, glw::TRUE];
    for index in 0..K_TARGETS {
        gl!(gl.bind_image_texture(
            units[index],
            textures[index],
            0,
            layered[index],
            0,
            access,
            internalformat
        ));
    }
}

fn init_ssbo(gl: &glw::Functions, buffer: GLuint) {
    let b_data = vec![0u8; K_SIZE * 4 * 4];
    gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, buffer));
    gl!(gl.buffer_data(
        glw::GL_SHADER_STORAGE_BUFFER,
        b_data.len() as glw::GLsizeiptr,
        b_data.as_ptr().cast(),
        glw::GL_STATIC_DRAW
    ));
}

fn run_stage_pass(gl: &glw::Functions, vao: GLuint, stage: Stage) {
    gl!(gl.bind_vertex_array(vao));
    match stage {
        Stage::Cs => gl!(gl.dispatch_compute(1, 1, 1)),
        Stage::Vs => gl!(gl.draw_arrays(glw::GL_POINTS, 0, K_SIZE as glw::GLsizei)),
    }
}

const DISCARD_FS: &str = "\nvoid main() {\n  discard;\n}";

fn machine_setup(gl: &glw::Functions, vao: &mut GLuint, buffer: &mut GLuint) {
    gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
    gl!(gl.gen_vertex_arrays(1, vao));
    gl!(gl.gen_buffers(1, buffer));
}

fn machine_cleanup(gl: &glw::Functions, vao: &GLuint, buffer: &GLuint) {
    gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
    gl!(gl.delete_vertex_arrays(1, vao));
    gl!(gl.delete_buffers(1, buffer));
}

fn gen_store_shader<T: Texel4>(stage: Stage, internalformat: GLenum, write_value: T) -> String {
    let prefix = T::PREFIX;
    let format = format_enum_to_string(internalformat);
    let mut source = String::new();
    if stage == Stage::Cs {
        source.push_str("\n#define KSIZE 100\nlayout(local_size_x = KSIZE) in;");
    }
    source.push_str(&format!(
        "\nlayout({format}, binding = 1) writeonly uniform {prefix}image2D g_image_2d;\nlayout({format}, binding = 2) writeonly uniform {prefix}image3D g_image_3d;\nlayout({format}, binding = 0) writeonly uniform {prefix}imageCube g_image_cube;\nlayout({format}, binding = 3) writeonly uniform {prefix}image2DArray g_image_2darray;\nlayout(std430) buffer out_data {{\n  ivec4 o_color;\n}};\nvoid main() {{\n  {prefix}vec4 g_value = {prefix}vec4(o_color) + {prefix}vec4{};\n  int g_index[6] = int[](o_color.x, o_color.y, o_color.z, o_color.w, o_color.r, o_color.g);",
        write_value.glsl()
    ));
    source.push_str(match stage {
        Stage::Vs => "\n  ivec2 coord = ivec2(gl_VertexID, g_index[0]);",
        Stage::Cs => "\n  ivec2 coord = ivec2(gl_GlobalInvocationID.x, g_index[0]);",
    });
    source.push_str("\n  imageStore(g_image_2d, coord, g_value);\n  imageStore(g_image_3d, ivec3(coord.xy, g_index[0]), g_value);\n  imageStore(g_image_3d, ivec3(coord.xy, g_index[1]), g_value);\n  for (int i = 0; i < 6; ++i) {\n    imageStore(g_image_cube, ivec3(coord, g_index[i]), g_value);\n  }\n  imageStore(g_image_2darray, ivec3(coord, g_index[0]), g_value);\n  imageStore(g_image_2darray, ivec3(coord, g_index[1]), g_value);\n}");
    source
}

fn gen_load_shader<T: Texel4>(stage: Stage, internalformat: GLenum, expected_value: T) -> String {
    let prefix = T::PREFIX;
    let format = format_enum_to_string(internalformat);
    let mut source = String::from("\n#define KSIZE 100");
    if stage == Stage::Cs {
        source.push_str("\nlayout(local_size_x = KSIZE) in;");
    }
    source.push_str(&format!(
        "\nlayout({format}, binding = 3) readonly uniform {prefix}image2D g_image_2d;\nlayout({format}, binding = 2) readonly uniform {prefix}image3D g_image_3d;\nlayout({format}, binding = 1) readonly uniform {prefix}imageCube g_image_cube;\nlayout({format}, binding = 0) readonly uniform {prefix}image2DArray g_image_2darray;\nlayout(std430) buffer out_data {{\n  ivec4 o_color[KSIZE];\n}};\nvoid main() {{"
    ));
    let invocation = match stage {
        Stage::Vs => "gl_VertexID",
        Stage::Cs => "gl_GlobalInvocationID.x",
    };
    source.push_str(&format!(
        "\n  {prefix}vec4 g_value = {prefix}vec4(o_color[{invocation}]) + {prefix}vec4{};",
        expected_value.glsl()
    ));
    source.push_str("\n  int g_index[6] = int[](o_color[0].x, o_color[0].y, o_color[0].z, o_color[0].w, o_color[1].r, o_color[1].g);");
    source.push_str(&format!("\n  ivec2 coord = ivec2({invocation}, g_index[0]);"));
    source.push_str(&format!(
        "\n  vec4 r = vec4(0.0, 1.0, 0.0, 1.0);\n  {prefix}vec4 v;\n  v = imageLoad(g_image_2d, coord);\n  if (v != g_value) r = vec4(1.0, 0.0, float(coord.x), 2.0);\n  v = imageLoad(g_image_3d, ivec3(coord, g_index[0]));\n  if (v != g_value) r = vec4(1.0, 0.0, float(coord.x), 3.0);\n  v = imageLoad(g_image_cube, ivec3(coord, g_index[0]));\n  if (v != g_value) r = vec4(1.0, 0.0, float(coord.x), 6.0);\n  v = imageLoad(g_image_2darray, ivec3(coord, g_index[0]));\n  if (v != g_value) r = vec4(1.0, 0.0, float(coord.x), 23.0);\n  o_color[coord.x] = ivec4(r);\n}}"
    ));
    source
}

/// `LoadStoreMachine`
struct LoadStoreMachine {
    stage: Stage,
    vao: GLuint,
    buffer: GLuint,
}

impl LoadStoreMachine {
    fn write<T: Texel4>(&self, gl: &glw::Functions, internalformat: GLenum, write_value: T, expected_value: T) -> bool {
        let (program_store, program_load) = match self.stage {
            Stage::Vs => (
                build_program(
                    gl,
                    Some(&gen_store_shader(self.stage, internalformat, write_value)),
                    Some(DISCARD_FS),
                ),
                build_program(
                    gl,
                    Some(&gen_load_shader(self.stage, internalformat, expected_value)),
                    Some(DISCARD_FS),
                ),
            ),
            Stage::Cs => (
                create_compute_program(gl, &gen_store_shader(self.stage, internalformat, write_value)),
                create_compute_program(gl, &gen_load_shader(self.stage, internalformat, expected_value)),
            ),
        };
        let textures = create_line_textures(gl, internalformat);
        bind_line_images(gl, &textures, internalformat, glw::GL_WRITE_ONLY, [1, 2, 0, 3]);
        init_ssbo(gl, self.buffer);

        gl!(gl.use_program(program_store));
        run_stage_pass(gl, self.vao, self.stage);
        // The load pass needs the write-after-read of the buffer, the read-after-write of the images and the texture updates to be visible.
        gl!(gl.memory_barrier(
            glw::GL_TEXTURE_UPDATE_BARRIER_BIT
                | glw::GL_SHADER_STORAGE_BARRIER_BIT
                | glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT
        ));

        bind_line_images(gl, &textures, internalformat, glw::GL_READ_ONLY, [3, 2, 1, 0]);
        gl!(gl.use_program(program_load));
        run_stage_pass(gl, self.vao, self.stage);
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let status = match map_ssbo_at::<[i32; 4]>(gl, 0, K_SIZE) {
            Some(out_data) => all_equal(out_data, [0, 1, 0, 1], "load/store operation"),
            None => false,
        };
        gl!(gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER));
        gl!(gl.use_program(0));
        gl!(gl.delete_program(program_store));
        gl!(gl.delete_program(program_load));
        gl!(gl.delete_textures(K_TARGETS as glw::GLsizei, textures.as_ptr()));
        status
    }

    fn run_stage(&self, gl: &glw::Functions) -> bool {
        self.write(gl, glw::GL_RGBA32F, [1.0f32, 2.0, 3.0, 4.0], [1.0f32, 2.0, 3.0, 4.0])
            && self.write(gl, glw::GL_R32F, [1.0f32, 2.0, 3.0, 4.0], [1.0f32, 0.0, 0.0, 1.0])
            && self.write(gl, glw::GL_RGBA16F, [1.0f32, 2.0, 3.0, 4.0], [1.0f32, 2.0, 3.0, 4.0])
            && self.write(gl, glw::GL_RGBA32I, [1i32, -2, 3, -4], [1i32, -2, 3, -4])
            && self.write(gl, glw::GL_R32I, [1i32, -2, 3, -4], [1i32, 0, 0, 1])
            && self.write(gl, glw::GL_RGBA16I, [1i32, -2, 3, -4], [1i32, -2, 3, -4])
            && self.write(gl, glw::GL_RGBA8I, [1i32, -2, 3, -4], [1i32, -2, 3, -4])
            && self.write(gl, glw::GL_RGBA32UI, [0u32, 1, 2, 3], [0u32, 1, 2, 3])
            && self.write(gl, glw::GL_R32UI, [7u32, 2, 3, 4], [7u32, 0, 0, 1])
            && self.write(gl, glw::GL_RGBA16UI, [0u32, 1, 2, 3], [0u32, 1, 2, 3])
            && self.write(gl, glw::GL_RGBA8UI, [0u32, 1, 2, 3], [0u32, 1, 2, 3])
            && self.write(gl, glw::GL_RGBA8, [1.0f32; 4], [1.0f32; 4])
            && self.write(
                gl,
                glw::GL_RGBA8_SNORM,
                [1.0f32, -1.0, 1.0, -1.0],
                [1.0f32, -1.0, 1.0, -1.0],
            )
    }
}

/// 1.3.4 BasicAllTargetsLoadStoreVS and 1.3.8 BasicAllTargetsLoadStoreCS
pub(super) struct BasicAllTargetsLoadStore<const CS: bool>(LoadStoreMachine);

impl<const CS: bool> Default for BasicAllTargetsLoadStore<CS> {
    fn default() -> Self {
        Self(LoadStoreMachine {
            stage: if CS { Stage::Cs } else { Stage::Vs },
            vao: 0,
            buffer: 0,
        })
    }
}

impl<const CS: bool> Subcase for BasicAllTargetsLoadStore<CS> {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        machine_setup(context.gl(), &mut self.0.vao, &mut self.0.buffer);
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !CS && (!is_vsfs_available(gl, 4, 0) || !is_ssb_in_vsfs_available(gl, 1, 0)) {
            return Ok(NOT_SUPPORTED);
        }
        if !are_outputs_available(gl, 5) {
            return Ok(NOT_SUPPORTED);
        }
        result(self.0.run_stage(gl))
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        machine_cleanup(context.gl(), &self.0.vao, &self.0.buffer);
        Ok(NO_ERROR)
    }
}

fn gen_atomic_shader<T: AtomicScalar>(target: Target, stage: Stage, internalformat: GLenum) -> String {
    let prefix = T::PREFIX;
    let format = format_enum_to_string(internalformat);
    let mut source = String::from("\n#define KSIZE 100");
    if stage == Stage::Cs {
        source.push_str("\nlayout(local_size_x = KSIZE) in;");
    }
    let (image_type, name, binding, marker) = match target {
        Target::T2d => ("image2D", "g_image_2d", 1, 2),
        Target::T3d => ("image3D", "g_image_3d", 2, 3),
        Target::Tcm => ("imageCube", "g_image_cube", 0, 6),
        Target::T2da => ("image2DArray", "g_image_2darray", 3, 23),
    };
    source.push_str(&format!(
        "\nlayout({format}, binding = {binding}) coherent uniform {prefix}{image_type} {name};"
    ));
    source.push_str(&format!(
        "\nlayout(std430) buffer out_data {{\n  ivec4 o_color[KSIZE];\n}} r;\n{prefix}vec2 t(int i) {{\n  return {prefix}vec2(i);\n}}\nvoid main() {{\n  int g_value[6] = int[](r.o_color[0].x, r.o_color[0].y+1, r.o_color[0].z+2, r.o_color[0].w+3, r.o_color[1].r+4, r.o_color[1].g+5);"
    ));
    source.push_str(match stage {
        Stage::Vs => "\n  ivec2 coord = ivec2(gl_VertexID, g_value[0]);",
        Stage::Cs => "\n  ivec2 coord = ivec2(gl_GlobalInvocationID.x, g_value[0]);",
    });
    source.push_str(&format!(
        "\n  ivec4 o_color = ivec4(0, 1, 0, 1);\n  ivec4 i = ivec4(1, 0, 0, {marker});"
    ));
    // Upstream's per-target coordinates and operands, including the ones that differ from the rest of the chain on purpose.
    let coord = |layer_expression: &str| match target {
        Target::T2d => "coord".to_string(),
        _ => format!("ivec3(coord, {layer_expression})"),
    };
    let default_coord = coord("0");
    let operations: [(&str, String, &str, &str); 9] = [
        ("Exchange", default_coord.clone(), "t(0).x", ""),
        ("Add", default_coord.clone(), "t(2).x", "t(0).x"),
        ("Min", default_coord.clone(), "t(3).x", "t(2).x"),
        ("Max", default_coord.clone(), "t(4).x", "t(2).x"),
        ("And", default_coord.clone(), "t(0).x", "t(4).x"),
        ("Or", default_coord.clone(), "t(7).x", "t(0).x"),
        ("Xor", default_coord.clone(), "t(4).x", "t(7).x"),
        ("Exchange", default_coord.clone(), "t(1).x", "t(3).x"),
        ("CompSwap", default_coord.clone(), "t(1).x, t(6).x", "t(1).x"),
    ];
    for (index, (operation, operation_coord, operand, expected)) in operations.iter().enumerate() {
        let mut operation_coord = operation_coord.clone();
        let mut operand = operand.to_string();
        match (target, index) {
            (Target::T3d, 3) => operation_coord = coord("g_value[0]"),
            (Target::Tcm, 1) => operand = "t(g_value[2]).x".to_string(),
            (Target::Tcm, 8) => operation_coord = coord("g_value[0]"),
            (Target::T2da, 6) => operand = "t(g_value[4]).x".to_string(),
            _ => {}
        }
        if index == 0 {
            source.push_str(&format!(
                "\n  imageAtomicExchange({name}, {operation_coord}, {operand});"
            ));
        } else {
            source.push_str(&format!(
                "\n  if (imageAtomic{operation}({name}, {operation_coord}, {operand}) != {expected}) o_color = i;"
            ));
        }
    }
    source.push_str(&format!(
        "\n  if (imageAtomicExchange({name}, {default_coord}, t(0).x) != t(6).x) o_color = i;"
    ));
    source.push_str("\n  r.o_color[coord.x] = o_color;\n}");
    source
}

#[derive(Clone, Copy)]
enum Target {
    T2d,
    T3d,
    Tcm,
    T2da,
}

/// `AtomicMachine`
struct AtomicMachine {
    stage: Stage,
    vao: GLuint,
    buffer: GLuint,
}

impl AtomicMachine {
    fn atomic<T: AtomicScalar>(&self, gl: &glw::Functions, target: Target, internalformat: GLenum) -> bool {
        let program = match self.stage {
            Stage::Vs => build_program_with(
                gl,
                &gen_atomic_shader::<T>(target, self.stage, internalformat),
                DISCARD_FS,
                true,
                false,
            ),
            Stage::Cs => create_compute_program_sia(gl, &gen_atomic_shader::<T>(target, self.stage, internalformat)),
        };
        let textures = create_line_textures(gl, internalformat);
        bind_line_images(gl, &textures, internalformat, glw::GL_READ_WRITE, [1, 2, 0, 3]);
        init_ssbo(gl, self.buffer);

        gl!(gl.use_program(program));
        run_stage_pass(gl, self.vao, self.stage);
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));

        let status = match map_ssbo_at::<[i32; 4]>(gl, 0, K_SIZE) {
            Some(out_data) => all_equal(out_data, [0, 1, 0, 1], "Atomic operation"),
            None => false,
        };
        gl!(gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER));
        gl!(gl.use_program(0));
        gl!(gl.delete_program(program));
        gl!(gl.delete_textures(K_TARGETS as glw::GLsizei, textures.as_ptr()));
        status
    }

    fn run_stage(&self, context: &Context) -> bool {
        let gl = context.gl();
        [Target::T2d, Target::T3d, Target::Tcm, Target::T2da]
            .into_iter()
            .all(|target| self.atomic::<i32>(gl, target, glw::GL_R32I) && self.atomic::<u32>(gl, target, glw::GL_R32UI))
    }
}

/// 1.3.9 BasicAllTargetsAtomicVS and 1.3.13 BasicAllTargetsAtomicCS
pub(super) struct BasicAllTargetsAtomic<const CS: bool>(AtomicMachine);

impl<const CS: bool> Default for BasicAllTargetsAtomic<CS> {
    fn default() -> Self {
        Self(AtomicMachine {
            stage: if CS { Stage::Cs } else { Stage::Vs },
            vao: 0,
            buffer: 0,
        })
    }
}

impl<const CS: bool> Subcase for BasicAllTargetsAtomic<CS> {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        machine_setup(context.gl(), &mut self.0.vao, &mut self.0.buffer);
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !CS && (!is_vsfs_available(gl, 4, 0) || !is_ssb_in_vsfs_available(gl, 1, 0)) {
            return Ok(NOT_SUPPORTED);
        }
        if !is_image_atomic_supported(context) {
            return Ok(NOT_SUPPORTED);
        }
        result(self.0.run_stage(context))
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        machine_cleanup(context.gl(), &self.0.vao, &self.0.buffer);
        Ok(NO_ERROR)
    }
}
